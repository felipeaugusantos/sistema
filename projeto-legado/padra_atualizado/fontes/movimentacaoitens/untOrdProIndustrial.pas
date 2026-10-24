unit untOrdProIndustrial;

interface

Uses
  Classes, SysUtils, System.StrUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, Math, frxClass, frxBarcode, DBEditFocus, Variants,
  untOrdProIndCorrecoes, cxProgressBar, untCadFasesOP, untOrdProIndMonitoramento,
  untQckOrdProIndustrial, JPEG, Vcl.Graphics, PNGImage, untLiberacao, untMsgLiberacao,
  REST.JSON, untConstantes, Vcl.DBCtrls, untTypesSistema, untFuncoesRel,

  untSaldoLojas,
  untCdsItensSemLote,
  untPreAlt_Trigger,
  untAuditoriaGravacaoSaldo,

  OrdemProducaoIndustrial.TEmbalagem,
  OrdemProducaoIndustrial.TMateriaPrima,
  OrdemProducaoIndustrial.TProdutoAcabado,
  OrdemProducaoIndustrial.TOrdemProducao,
  OrdemProducaoIndustrial.TCorrecao,
  OrdemProducaoIndustrial.Tipos,
  OrdemProducaoIndustrial.TSQLFormulaImpressao,
  OrdemProducaoIndustrial.Funcoes,
  OrdemProducaoIndustrial.TSQLOrdProdIndustrial,

  untGetMenuMultiSelecao;

Type
  TTipoBaixa = (tpbAcabado, tpbResiduo, tpbAcabadoResiduo, tpbParcial);

  TStatusOPI = (stOPIAberta, stInserindoOPI, stOPIBaixada);

  TRecReservaEstoque = Record
    strCodIte : String;
    strNumLot : String;
    fltQtdIte : Double;
    fltQtdTot : Double;
    intSequen : Integer;
    strIteAca : String;
    blnAcaGra: Boolean;
  End;

  TDadosImpressao = Record
    strAutImp: String;
    blnFormul, blnCorrec, blnConQua, blnTemPro, blnEnvase, blnFasDis, blnExtrus, blnAnaFor, blnDadCli: Boolean;
    blnLocFis: Boolean;
    blnVisCon: Boolean;
    intQtdFas: Integer;
    strCodGra,
    strCodCorDesenv: String;
    strObserv : String;
    intQtdPar : Integer;
    blnObsAss : Boolean;
  End;

  TDadosDocOpe = Record
    strDocOpe: String;
    dtaDtaCad: TDate;
    strCodCli, strAutInc: String;
  End;

  // Class Singleton, Pode Existir apenas uma instancia dessa classe.
  TProdutoEstoque = Class
  Private
    cdsEstoque: TUniClientDataSet;

    constructor Create;
    class var FInstance: TProdutoEstoque;

  Public
    class function fGetSaldos(strCodIte: String): TUniClientDataSet;
    class procedure pLimpaCds;

  End;

  TRecQuantidades = Record
    fltQtdUsa,
    fltUsaEst,
    fltQtdSub: Double
  End;

  TOrdProIndustrial = Class(TZClient)
  Private
    FDesenvFormulas: Boolean;
    FOrdemProducao : TOrdemProducao;
    FarrPaiOrdem: Array of String;
    cdsValidacaoLoteSaldo: TUniClientDataSet;
    FQryConsulta: TUniQuery;
    // Grava o Cód. Do Produto a Granel e A Cor que Solicitou a Geração da Ordem Filha
    // Formato 'GGGGGCCCC' - onde G Código do Granel e C - Cod Cor
    FarrQuantidades: Array of TRecQuantidades;

    FGeraOpSubProdutos: Boolean;
    FUsaCapacidadeMaxima : boolean;
    FBxCompSubPro: Boolean;
    FExibeResumoDeCalculoOPITela: Boolean;

    FDocOpe: TDadosDocOpe;
    FDoc_TL: TDadosDocOpe;

    FProgre: TProgressBar;

    blnProdKg: Boolean;
    dbeVolume, dbePeso: TDBEditFocus;

    cdsProFor: TZClient;

    cdsCustoProducao: TUniClientDataSet;
    dtsCustoProducao: TDataSource;

    cdsProdAcaNaoIncOPI: TZClient;
    dtsProdAcaNaoIncOPI: TDataSource;

    cdsDmtIpr: TZClient;
    cdsDisIpr: TZClient;
    cdsAgrLot: TZClient; // Client Responsavel Por Escolher os lotes considerados na op (rotina de agrupamento quando fAgrLot = True)


    intDecUni: Integer;
    intDecQtd: Integer;

    fltPesRea: Double;

    FRestaurarCadastro : Boolean;
    FAutBai: String;
    FPrgBar: TcxProgressBar;
    FDtaVal: TDateTime;

    fltPesoEspecifico : Double;

    //Paramentros da funçao fCarregaItens;
    FAutInc,
    FCodIte,
    FCodCor: String;
    FImpressao: Boolean;
    FBaixaOrdem: Boolean;
    FInclusao: Boolean;
    FCapacidadeMaxima : real;
    FLisIte: String;

    oleBackupCdsOPI : OleVariant;
    objLiberacao : TLiberacao;
    objSalLoj: TSaldoLojas;

    FConsiderarMultiploDeVenda : boolean;
    FUtilizaConferencia : boolean;

    FAgrupamentoPedido : Boolean;

    cdsLotesComponentes : TZClient;

    FCodAca,
    FNumOrd,
    FDesIte,
    FUndMed: String;
    FCusFor,
    FEstAtu,
    FQtdPro,
    FQtdPzd,
    FEstFin,
    FCusAtu,
    FCusUni: Double;

    arrLayouts : array of string;

    cdsLotesGeradosProcedure: TUniClientDataSet;

    FenuTipoBaixa: TTipoBaixa;
    FStatusOPI: TStatusOPI;
    FStrAutIncFormula: String;
    FcdsFormul: TZClient;
    FStrCodCorFormula: String;
    FStrCodIteFormula: String;

    FEditorRelatorios: Boolean;
    FEdtRelTabelaCadVal: String;
    FEdtImpPorTabelaTmp: Boolean;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    //Function fRetCustoUnitario: Double;
    Function fIncluiDocMovimentacao(dtaDtaBai: TDate; blnParcial : Boolean): Boolean;
    Function fIncluiDetMovimentacao(strCodIte: String; fltQtdIte: Double; strEntSai: String; strNumLot : String = '';
                                    blnAtualizouPreMed : Boolean = False; blnGravaAtualizaOrdMat : Boolean = False;
                                    strIncOrd : String = ''): Boolean;

    Function fVerificaLoteExiste(strCodIte, strNumLot: String): Boolean;
    Function fRetProdutoGranel(strAutInc: String): String;
    Function fRetCorProducao(strAutInc: String): String;
    Function fSQLOrdPro(blnComQtd: Boolean = False): String;
    Function fTemOrdemProducaoHoje: Boolean;
    Function fReservaEstoqueOP(qryTabela: TUniQuery; blnBaixaOp: Boolean = False; blnIgnoraCorrecao: Boolean = False): Boolean;
    Function fSqlProdutosFormula(blnOrdMat: Boolean): String;
    Function fSqlProdutosComposicaoSoma: String;
    Function fMostraProdutosSemSaldo(ABlnBaixaOpi: Boolean = False): Boolean;
    function fRetQtdPro(cdsDados : TUniClientDataSet; strCodIte: String): Double;

    Function fSQLCabecalhoImpr: String;
    Function fSQLFormulaIpr(blnDispersao: Boolean = False; blnIncOrdEst : Boolean = False): String;
    Function fAtualizaPesoAcabado(objProdutoAcabado : TProdutoAcabado; blnFormulaEspecial : boolean): Boolean;
    Function fBaixaEstoqueFormula(strAutInc: String): Boolean;
    Function fAtualizaUltimaCompraAcabado(strCodIte: String; fltPreCom, fltQtdIte: Double; strAgrupadorPreAlt: String): Boolean;
    Function fCustoComposicao(strIncOrdDet : String; fltQtdEnv : Double): Double;
    Function fAtualizaUltimaCompraGranel(strCodIte: String): Boolean;
    Function fRestauraCadastro(strAutInc: String; strAgrupadorPreAlt: String): Boolean;
    Function fRestauraEstoque(strSeqGer: String; blnValidaSaldoNegativoLote: Boolean = False): Boolean;
    Function fCancelaBaixaInterna(pgbProgresso: TcxProgressBar): Boolean;
    Function fPermiteSaldoNegativoParaProdutoAcabado(qryMovDet:TUniQuery): Boolean;
    procedure pCriaDataSetValidacaoLoteSaldo;
    procedure pCriaDataSetLotesDefinidosPedido;
    procedure cdsLotesDefinidosPedidoBeforePost(DataSet: TDataSet);
    procedure cdsLotesDefinidosPedidoAfterPost(DataSet: TDataSet);

    Procedure pSetaTituloPrg(strTitulo: String);
    Procedure pInicializaPrg(intMax: Integer);
    Procedure pProgressoPrg;

    Procedure pMontaDispersao;

    Procedure pSalvaDadosItem(strCodIte, strSeqGer: String);

    Procedure pCompletaProdutos(strCodIte, strCodCor: String;
      blnImpressao: Boolean = False; blnBaixaOrdem: Boolean = False);

    Procedure pCarregaProdutosComposicao(blnBaixaOp: Boolean;blnEditandoOP: Boolean = False);

    Procedure pCabecalhoImpressao(strAutInc: String);
    Procedure pCabecalhoImpressaoProdutoB(strAutInc: String);

    Procedure pProdutosFormulaImpressao(strAutInc: String; blnUtiEst : Boolean = False);
    Procedure pProdutosAcabadosImpressao(strAutInc: String);



    Function fSQLCabecalhoImprDesenv(strObserv: String; intQtdPar : Integer): String;
    Function fSQLFormulaIprDesenv(blnDispersao: Boolean = False): String;
    Procedure pCabecalhoImpressaoDesenv(strAutInc, strObserv: String; intQtdPar : Integer);
    Procedure pProdutosAcabadosImpressaoDesenv(strCodGra, strCodCor: String);
    Procedure pProdutosFormulaImpressaoDesenv(strAutInc: String);

    Procedure pAtulizaCamposBaixaOP(strAutInc: String; strSeqOPI: String;
      dtaDtaIni, horHorIni, dtaDtaFin, horHorFin, dtaDtaBai: TDateTime;
      fltCusOrd: Double; strLocFis, strAutIncLT : String; blnParcial : Boolean;
      strCodQui, strCodEnc, strCodLim, strCodQua, strSeqCpn : String);

    Procedure pCarregaDadosItem(strCodIte: String; qryCadIte: TUniQuery);

    //Procedure pBeforePostBaixa(dataSet: TDataSet);
    Procedure pBeforePostDesenv(dataSet: TDataSet);
    Procedure pApagaDocBaixa(strSeqGer: String);
    Procedure pZeraQtdEnvasada(strAutInc: String);

    function fGravaOrdOri(strSeqGer, strSeqUsa: String;
      fltQtdUsa, fltUsaEst, fltQtdSub: Double): Boolean;
    function pRetQtdJaReservado(strAutInc, strCodIte: String): Double;
    function fOrdemDeProducaoFilha(strAutInc: String): Boolean;
    Function fAbreAnalise(strAutAna: String; qryAnaGer, qryAnaDet: TUniQuery): Boolean;

    Function fSQLAnaGer: String;
    Function fSQLAnaDet: String;
    Function fPedeQuantidadeAProduzirDesenv: Boolean;

    Procedure pImprimeOrdemProducao;

    Function fSalvaItensBaixa(strAutInc: String): Boolean;
    procedure pQtdProDataChange(Sender: TField);
    function fRetPesoEspecifico(strCodIte, strCodCor: String): Double;
    procedure pSetObservPartidas(strAutInc, strObserv : string; intQtdPar : Integer);
    function fGetObserv(strAutImp: String) : String;
    function fGetQtdPar(strAutImp: String) : String;
    function fSQLAgrLot: String;
    function fSqlOrdMat: String;
    function fSqlOrdCom: String;
    procedure pCdsAgrLotBeforePost(DataSet: TDataSet);
    function fGeraTransferenciaLotes(strAutInc: String): Boolean;
    function fValidaQuantidadesDigitadas: Boolean;
    procedure pAtualizaCustoTotalParaExibirDiferencas(blnManutencao : boolean = false);
    procedure pCarregaOrdMat(strCodIte, strCodCor : String);
    procedure pCarregaOrdCom(strCodIte, strCodCor : String);
    function fRetCustoFormulacao: Double;
    procedure pCarregaDadosImpressaoAnalise(var frmQckOrdProIndustrial: TfrmQckOrdProIndustrial; var qryAnalise: TUniQuery; strAutInc : String);
    procedure pCarregaDadosImpressaoEPI(var frmQckOrdProIndustrial : TfrmQckOrdProIndustrial; var cdsEpi : TUniClientDataSet; strAutInc : String);
    procedure pCarregaDadosImpressaoComposicao(var frmQckOrdProIndustrial : TfrmQckOrdProIndustrial; var qryGerCom : TUniQuery);
    function fRetQtdeAProduzir(strCodIte : String): Double;
    function fCarregaItensInterna(cxProgressBar : TcxProgressBar) : Boolean;
    procedure pFormataCampos;
    procedure pCarregaDadosImpressaoCorrecao(var frmQckOrdProIndustrial: TfrmQckOrdProIndustrial; var qryCorrecao: TUniQuery; strAutInc: String);
    function fAtualizaDadosAcabados(strAutoincremORDGER : String; fltPesoReal : double; strAgrupadorPreAlt: String) : boolean;
    procedure pCarregaFormulaTOrdemProducao(fltPesoReal : double);
    procedure pCarregaCorrecoesTOrdemProducao;
    procedure pCarregaProdutosAcabadosTOrdemProducao(fltPesoReal : double);
    procedure pCarregaComposicaoTProdutoAcabado(strAutoIncremOrdDet: String;
      var objProdutoAcabado: TProdutoAcabado);
    function fAtualizaEstoqueAcabado(strCodigoItem, strNumeroLote: String;
      fltQuantidadeEnvasada: double): boolean;
    function fGetSQLLotesMateriaPrima(blnOrder: Boolean = True): String;
    procedure pCarregaItensSemLote(cdsItens: TCdsItensSemLote);
    procedure pCalculaCapacidadeMaximaAcabados;
    procedure setCapacidadeMaxima(const Value: real);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pAjustaCorrecoesEmbalagens(UtilizaQtdProOriginal: Boolean);

    procedure pImprimeProcessoDeExtrusao(strAutInc : String);
    procedure pCriaDataSetCustosProducao;
    procedure pGravaInformacaoPreviaDeCustoProdutoAcabado(objProdutoAcabado: TProdutoAcabado);
    procedure pGravaCustosProducaoTemp;
    procedure pCarregaDadosExtrusao(var frmQckOrdProIndustrial: TfrmQckOrdProIndustrial; var qryExtrusao: TUniQuery; strAutInc : String);
    function fTemSaldoDisponivelProduzir(fltDifProducao, fltQtdProduzir, fltSalRes: Double; FCdsItem: TUniClientDataSet): Boolean;
    function fRetSaldoLotDor(strCodIte, strNumLot: String): Double;

    procedure pInsereMateriaPrimaTemporariamenteApenasParaGeracaoDaOPI(cdsSubItemSelecionado: TUniClientDataSet);
    procedure pDeleteMateriaPrimaTemporariamenteApenasParaGeracaoDaOPI;
    procedure pCarregaLotesEEmbalagemParaEnvazadoSemProducao;
    function fCadastrarLotesAux(pgbProgresso: TCxProgressBar): Boolean;
    function fCriaQueryInsLotesSugeridos: TUniQuery;
    function fGravarLotesDaProcedure: Boolean;
    procedure pInserirLoteSugestao(ACodIte: String = '');
    procedure pCarregaDadosImpressaoCadastroFases(
      var frmQckOrdProIndustrial: TfrmQckOrdProIndustrial;
      var qryDataSet: TUniQuery; strAutInc: String);
    function fValidaQuantidadeCopias(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
    function fUsaPesoDaQuantidadeMaximaDeProducao: Boolean;
    function fGetPesoProducao: Double;
    function fGetVolumeProducao: Double;
    function fGetSQLFormulaInserindoOuAbertaOPI: String;
    function fGetSQLFormulaBaixada: String;
    procedure setStrAutIncFormula(const Value: String);
    procedure setCdsFormulas(const Value: TZClient);
    procedure setStatusOPI(const Value: TStatusOPI);
    procedure setStrCodCorFormula(const Value: String);
    procedure setStrCodIteFormula(const Value: String);
    function fGetMenuMultiSelecao(strTitulo: String; arrOpcoes: Array Of String;
                                  blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False;
                                  intWidth: Integer = 0): TArrString;
    function fDadosEmpresaRodape: String;
  Public
    blnAlterandoQtd: Boolean;
    cdsCabIpr: TZClient;
    cdsCabIpB: TZClient;
    cdsOrdMat: TZClient; // Cópia da ordem de produção no momento da criaçao da Ordem de Produção.
    cdsOrdCom: TZClient; // Cópia da Composição Do Produto Acabado no momento da criaçao da Ordem de Produção.

    FchbUsaCapacidadeMaxima: TDBCheckBox;

    intCasasDecimaisMateriaPrima: Integer;

    objCorrOP: TOrdProIndCorrecoes;

    objFasesOP: TCadFasesOP;

    objMonitor: TOrdProIndMonitoramento;
    CarregandoItens: Boolean;

    recImpres: TDadosImpressao;
    cdsLotesDefinidosPedido: TUniClientDataSet;
    cdsLotesDefinidosPedidoSaldos: TUniClientDataSet;

    blnUtilizaDistribuiLote: Boolean;

    blnGerarLotesPelaProcedure: Boolean;

    arrLotes : Array Of TRecReservaEstoque;

    stlItensSemUnidadeConfigurada : TStringList;

    qryInsLotesProc: TUniQuery;

    blnBaiVef: Boolean;

    constructor Create(Owner: TComponent; dbeVolumeP: TDBEditFocus = Nil;
      dbePesoP: TDBEditFocus = Nil; blnComQtd: Boolean = False;
      blnBaixaOp: Boolean = False); Reintroduce; Overload;

    constructor Create(Owner: TComponent; dbeVolumeP: TDBEditFocus;
      dbePesoP: TDBEditFocus; blnComQtd: Boolean; blnBaixaOp: Boolean;
      Var arrSubOP: Array of TOrdProIndustrial;
      Var arrQryTabela: Array of TUniQuery); Reintroduce; Overload;

    Destructor Destroy; override;

    Class function fRetOrdemProducao(intFormul: Integer; strCodIte, strCodCor: String): String;

    Class Function fRetornaPesoRealFormula(strCodIte, strCodCor: String): Double; Overload;
    Class Function fTemFormula(strCodIte, strCodCor: String): Boolean;

    function fVerificaSaldoParaBaixaEvazadaAcimaComSaldo(strSeqGer: String; var ListaErro: TStringList; blnBaixaParcial: Boolean = False): Boolean;
    procedure pLimpaCdsLotesComponentes;
    Function fRetornaPesoRealFormula(strAutInc : String): Double; Overload;
    Function fRetornaObsProcProducao(strCodIte, strCodCor: String): String;
    procedure pMostraMemo(stlIncon: TStrings);

    procedure pRetornaNumeroLoteFatDor(var fltQtdUtilizadaNoLote: Double; var strNumLote: String; var fltQtdLoteAtual: Double; strSeqGer, strCodIte: String);

    Function fCarregaItens(strAutInc, strCodIte, strCodCor: String;
      blnImpressao: Boolean = False; blnBaixaOrdem: Boolean = False;
      blnInclusao: Boolean = False): Boolean;
    function fRetQtdIteProduzidaTotal(strCodIte: String; var fltQtdSemPro:Double; var fltQtdPro: Double): Double;
    Function fCalculaCodBarOP(qryTabela: TUniQuery): String;
    Function fSalvaItens(qryTabela: TUniQuery; blnProcessaArray: Boolean = True; blnIgnoraCorrecao: Boolean = False): Boolean;
    Function fRetSequencialOP: String;
    Function fVerificaQuantidadeEstoque(qryTabela: TUniQuery; blnApenasMontarNecesSubOP: Boolean = False; blnBaixaOp : Boolean = False; cdsSubItemSelecionado: TUniClientDataSet = Nil): Boolean;
    Function fExisteLoteOP(qryOrdPro: TUniQuery; strNumLot: String): Boolean; OverLoad;

    Function fExisteLoteOP(qryOrdPro: TUniQuery; strCodOrd: String; dtaDtaCad: TDate): Boolean; OverLoad;

    function fTemDivergenciaQuantidadeBaixadaComSolitado(strAutInc: String; var strErro: string): Boolean;
    Function fBaixaOrdemProducao(strAutInc: String;
      strCodIte, strCodCor: String; dtaDtaIni, horHorIni, dtaDtaFin, horHorFin,
      dtaDtaBai: TDateTime; prgProgre: TProgressBar; strLocFis : String; blnBaixaParcial : Boolean; dtaDtaVal : TDateTime;
      strCodQui, strCodEnc, strCodLim, strCodQua, strSeqCpn: String; var strAgrupadorPreAlt: String; strHistoricoBaixa : String): Boolean;


    function fValidaSaldoLotesDefindos: Boolean;
    procedure pDefineCdsLotesComponentes;

    Function fRetQuantidadeUsada(strCodIte: String): Double;
    Function fPersisteBanco(cdsDados: TZClient): Boolean;

    Function fCancelaBaixa(strAutInc: String; blnRestaurarCadastro : Boolean): Boolean;
    Function fTemDadosBaixaSalvos(strAutInc: String): Boolean;

    Procedure pApagaReservaOP(strAutInc: String);
    Function fBaixaPDReservaOP(strAutInc: String; strJaFatu : String):Boolean;
    Procedure pImprimeOP;
    procedure pImprimeEtiqueta(AStrCodIte: String = '');
    procedure pSetLayoutEtiqueta(var cdsIteEti : TUniClientDataSet; var arrLayoutsSelecionados: TArrString);
    Procedure pImprimeDesenvOP;
    Procedure pCarregaTipoProducao(strCodIte: String);
    function fRetAtarelEditorRelatorios: Integer;
    function fRetChaveEditorRelatorios: Integer;
    function fVerificaImpressaoEditorRelatorios: boolean;
    Procedure pCriaTmpFiltrosEditorRelatorios;
    Procedure pRemoveTmpEditorRelatorios;
    Procedure pImprimessaoOP(strAutInc: String);
    Procedure pConfiguraImprimessaoOP;
    procedure pDeletaFilhas(strAutInc: String);
    function fExisteNivelInferior(strAutoincrem: String): Boolean;
    function fExisteNivelInferiorSemBaixa(strAutoincrem: String): Boolean;
    Function fCarregaOPMonitoramento(strCodBar: String): Boolean;

    Function fCarregaCabecalhoOP(strCodOPI: String; dtaDtaCad: TDate): Boolean; Overload;
    Function fCarregaCabecalhoOP(strAutOPI: String): Boolean; Overload;

    Function fCarregaCabecalhoOProdutoB(strCodOPI: String; dtaDtaCad: TDate): Boolean; Overload;
    Function fCarregaCabecalhoOProdutoB(strAutOPI: String): Boolean; Overload;

    Function fSelecionaLotesReserva(blnIgnoraCorrecao: Boolean = False) : Boolean;
    function fGetDataUltimaBaixa(strAutIncP : String) : TDate;
    Function fRetQtdeBaixaParcial(strCodIte : String) : Double;

    Function fVerificaQuantidadeDigitada: Boolean;
    Function fLiberaVinculoPedidosAgrupados(strAutInc: String): Boolean;

    Procedure pImprimessaoDesenvOP(strAutInc, strCodGra, strCodCor: String);
    Procedure pCalculaQuantidadesUsadas(strAutoinc: String = ''; blnValidaSaldo: Boolean = True; cdsSubItemSelecionado: TUniClientDataSet = Nil);

    Function fPodeBaixarOP(strAutInc: String): Boolean;
    Function fTemBaixaTotal(strAutInc: String): Boolean;
    Function fConfirmaUltimaBaixaRealizada(strAutInc: String): Boolean;
    Function fSalvaOrdMat(strSeqGer: String): Boolean;

    Procedure pImprimeLaudo(strAutAna: String);
    procedure LimparcdsLotesGeradosProcedure;

    Procedure pCarregaProdutosFormula_Composicao(strCodIte, strCodCor: String; strSeqOrd: String = ''; blnBaixaOp: Boolean = False; blnEditandoOP: Boolean = False);
    Procedure pSelecionaLotes;

    procedure pVerificaCusto;

    //Evento utilizado na baixa para verificar as qtdes das embalagens, para nao efetuar baixa fracionada de embalagens do tipo NÃO FRACIONADO.
    procedure pAcertaEmbalagens;
    procedure pBeforePost_AcertoEmbalagem(DataSet : TDataSet);
    function fTemComposicaoParaCorrecao(blnFiltra : Boolean) : Boolean;

    function fFoiBaixaPrdNaoRealizada(AStrAutInc: String): Boolean;

    property blnGeraOpSubProdutos: Boolean Read FGeraOpSubProdutos;
    property cdsProForProp : TZClient Read cdsProFor; // Utilizado apenas para sintetizar itens sem saldo na geraçao por pedido.
    property fltPesoReal : Double Read fltPesRea;
    property blnUsaCapacidadeMaxima : boolean read FUsaCapacidadeMaxima;
    property blnAgrupamentoPedido : boolean read FAgrupamentoPedido write FAgrupamentoPedido;
    property fltCapacidadeMaxima : real Read FCapacidadeMaxima write setCapacidadeMaxima;
    property chbUsaCapacidadeMaxima : TDBCheckbox read FchbUsaCapacidadeMaxima Write FchbUsaCapacidadeMaxima;
    property statusOPI: TStatusOPI read FStatusOPI write setStatusOPI;
    property strAutIncFormula: String read FStrAutIncFormula write setStrAutIncFormula;
    property strCodIteFormula: String read FStrCodIteFormula write setStrCodIteFormula;
    property strCodCorFormula: String read FStrCodCorFormula write setStrCodCorFormula;
    property cdsFormulas: TZClient read FcdsFormul write setCdsFormulas;
    property blnEditorRelatorios: Boolean read FEditorRelatorios write FEditorRelatorios;
    property strEdtRelTabelaCadVal: String read FEdtRelTabelaCadVal write FEdtRelTabelaCadVal;
    property blnEdtImpPorTabelaTmp: Boolean read FEdtImpPorTabelaTmp write FEdtImpPorTabelaTmp;



    property objOrdemProducao : TOrdemProducao read FOrdemProducao write FOrdemProducao;

    procedure pCarregaComposicoes(strAutInc : String);
    procedure pTrocaComposicaoBaixa;

    function fValidaBaixa(strSeqOpi : String): boolean;
    function fValidaAnalise(strSeqOpi : String): boolean;
    function fValidaConferenciaEnvase(strSeqOpi: String): boolean;
    function fValidaUnidadesItens: boolean;
    function fVerificaExisteItemFormulaSemLote: Boolean;


    procedure pBackupOPI;
    procedure pRestoreOPI;
    function fRetCapacidadeMaximaFormula(strCodIte, strCodCor : String):Double;
    function fRetCapacidadeMaximaOrdemProducao(strAutInc: String): Double;

    function fRetStatusOpi(strCodOrd, strDataCad: String): Boolean;
    function fRetDataSourceProdAcabNaoInclusosOPI(strCodIte, strCodCor: String): TDataSource;
    procedure pSalvaProdAcabadoNaoIncluso(DataSet: TDataSet);
    procedure pAjustacdsLotesDefinidosPedidoSaldos(blnSomaReservaPedido: Boolean; strNumLote: String;strCodIte:String; QtdUti: Double; var blnQuantidadeInvalida: Boolean);

    function fSQLProdutosAcabadosNaoInclusosOPI: String;

    Function fRetAutoIncremGEIMAT(strCodIte, strCodCor, strCodFormula : String):String;
    Function fEhFormulaEspecial(strAutIncGEIMAT: String): Boolean;

    procedure pGravaOrdExt(strCodIte, strCodCor, strSeqGer : String);

    function fOrdemDeProducaoIndustrialJaEnderecada(strAutInc: String): Boolean;
    procedure pInsereCorrecaoLote;
    procedure pExcluirCorrecao(strNumLot, strCodite: String);

    function fGerarLotesPelaProcedure(ATipoBaixa: TTipoBaixa; ADtaVal: TDateTime): Boolean;

    procedure pAbrirCdsFormula;
    Procedure pCompletaCorrecoes;
    procedure pRedistribuiQtdUtiPorSaldoFisico;

    class function fExisteAnaliseAberto(AStrSeqOpi: String; out AStrAnalises: String): Boolean;
    class function fNenhumaAnaliseGerada(AStrSeqOpi: String): Boolean;
    class function fDeveGerarAnalise(AStrSeqOpi: String): Boolean;
    class function fTodasAnalisesReprovadas(AStrSeqOpi: String): Boolean;
    class function fLiberaOrdemTodasAnalisesReprovadas(AStrSeqOpi: String): Boolean;
  End;

  function fRetFormulAtiva(strCodIte, strCodCor : String):Integer;

Var
  FarrSubOP: Array of TOrdProIndustrial;
  FarrQryTabela: Array of TUniQuery;

implementation

Uses
  untOrdProIndustrialProdSemSaldo, untAtualizaOcorrenciasCRM,
  untFuncoesCRM, untFatGor, untParCalculaPrecoCusto,
  untFuncoesSimples, untMovGer, untImpOrdProIndustrial, untPreAlt, untTConfiguracao,
  untCfgRel, untCadIte, untGravando, untOrdProIndustrialOperacoes, untAnaliseMovRel,
  TypesRel, untFuncoesEtiquetas, untOrdProIndDesenvQtds, untProdutosAcabadosIndustrial,
  untAgruPedOrdProIndLotes, untTransferenciaArmazens, untFuncFat,
  untImagemBase64, untOrdProIndustrialAjustaEmbalagem, untComposicaoProdAcabOP,
  untTypesCRM, untTFatReservaSaldo, untFormGrid,
  untIFatReservaSaldo, untTFatReprocessarSaldoItem, untItensSemLote,
  OrdemProducaoIndustrial.FuncoesJson, untCadLote,
  OrdemProducaoIndustrial.TReservaSaldoOrdemProducaoIndustrial, untMemo, untEditorFastImpressao,
  untGridMostraCalculoOPI, untEnderecamentoProduto, untTLog, untBaixaOrdProdIndCriarLotesAuto,
  untInputDialog, EditFocus, untRelatorio;

constructor TOrdProIndustrial.Create(Owner: TComponent;
  dbeVolumeP: TDBEditFocus = Nil; dbePesoP: TDBEditFocus = Nil;
  blnComQtd: Boolean = False; blnBaixaOp: Boolean = False);
Var
  arrSubOPLocal: Array of TOrdProIndustrial;
  arrQryTabelaLocal: Array of TUniQuery;
Begin
  FDesenvFormulas := False;
  FQryConsulta := fCriaQuery;
  CarregandoItens := False;
  FEditorRelatorios := fVerificaImpressaoEditorRelatorios;

  If (FEditorRelatorios) Then
    pCriaTmpFiltrosEditorRelatorios;

  FEdtImpPorTabelaTmp := False;

  Create(Owner, dbeVolumeP, dbePesoP, blnComQtd, blnBaixaOp, arrSubOPLocal, arrQryTabelaLocal);

  blnUtilizaDistribuiLote := ((fUsaRotinaWMS) And (fCfgSis('MATBOP') = 'S') And (fCfgSis('OPINLT') = 'S')) ;
  If blnUtilizaDistribuiLote Then
    pCriaDataSetLotesDefinidosPedido;

  objFasesOP := TCadFasesOP.Create(Owner);

  blnGerarLotesPelaProcedure := fCfgSis('OPISUG', varBoolean);

  If blnGerarLotesPelaProcedure Then
  Begin
    qryInsLotesProc := fCriaQueryInsLotesSugeridos;
    cdsLotesGeradosProcedure := TUniClientDataSet.Create(Nil);
  End;

  blnBaiVef := fCfgSis('BAIVEF', varBoolean);
End;

procedure TOrdProIndustrial.cdsLotesDefinidosPedidoAfterPost(DataSet: TDataSet);
var strNumLot, strCodIte, strITeAca: String;
    recNo: integer;
begin
  If (cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString <> 'S') And (cdsLotesDefinidosPedido.FieldByName('ORI_FORAORDEM').AsString <> 'S') Then
    Exit;
  cdsLotesDefinidosPedido.BeforePost := nil;
  cdsLotesDefinidosPedido.AfterPost  := nil;
  recNo := cdsLotesDefinidosPedido.RecNo;
  Try
    strNumLot := cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString;
    strCodIte := cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString;
    strITeAca := cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString;
    cdsLotesDefinidosPedido.First;
    cdsLotesDefinidosPedidoSaldos.First;
    If cdsLotesDefinidosPedidoSaldos.Locate('ITESUB;NUMLOT', varArrayOf([strCodIte, strNumLot]), []) then
    Begin

      While not cdsLotesDefinidosPedido.Eof Do
      Begin
        If (cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString <> strCodIte) Or
           (cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString <> strNumLot) Then
        Begin
          cdsLotesDefinidosPedido.Next;
          Continue;
        End;
        If cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat > 0 Then
        Begin
          cdsLotesDefinidosPedido.Edit;
          cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat := cdsLotesDefinidosPedidoSaldos.FieldByName('SALDIS').AsFloat +
                                                                   cdsLotesDefinidosPedidoSaldos.FieldByName('RESPED').AsFloat -
                                                                   cdsLotesDefinidosPedidoSaldos.FieldByName('QTDUTI').AsFloat;
          cdsLotesDefinidosPedido.Post;
        End;
        cdsLotesDefinidosPedido.Next;
      End;
      cdsLotesDefinidosPedido.First;
    End;


  Finally
     cdsLotesDefinidosPedido.BeforePost := cdsLotesDefinidosPedidoBeforePost;
     cdsLotesDefinidosPedido.AfterPost := cdsLotesDefinidosPedidoAfterPost;
     cdsLotesDefinidosPedido.RecNo := recNo;
  End;


end;

procedure TOrdProIndustrial.pCriaTmpFiltrosEditorRelatorios;
  Var
    ID : TGuid;
    qryTabela: TUniQuery;
begin
  CreateGUID(ID);
  FEdtRelTabelaCadVal :=  Concat('`', 'TMP_ORDIND_VAL_', GuidToString(ID), '`');
  try
    qryTabela := fCriaQuery();
    qryTabela.Close;
    qryTabela.SQL.Text := ' DROP  TABLE IF EXISTS ' + FEdtRelTabelaCadVal + ';' +   //
                          ' CREATE  TABLE ' + FEdtRelTabelaCadVal + ' ' +         //
                          ' SELECT * FROM CADVAL WHERE FALSE ';
    qryTabela.ExecSql;
  finally
    FreeAndNil(qryTabela);
  end;

end;

procedure TOrdProIndustrial.pRemoveTmpEditorRelatorios;
  Var
    qryTabela: TUniQuery;
Begin
  if (fEmptyStr(FEdtRelTabelaCadVal)) Then
    Exit;

  try
    qryTabela := fCriaQuery();
    qryTabela.Close;
    qryTabela.SQL.Text := ' DROP  TABLE IF EXISTS ' + FEdtRelTabelaCadVal;       //
    qryTabela.ExecSql;
  finally
    FreeAndNil(qryTabela);
  end;
end;

procedure TOrdProIndustrial.cdsLotesDefinidosPedidoBeforePost(DataSet: TDataSet);
begin
  If (cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString <> 'S') And (cdsLotesDefinidosPedido.FieldByName('ORI_FORAORDEM').AsString <> 'S') Then
    Exit;
  cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat := cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat

end;

constructor TOrdProIndustrial.Create(Owner: TComponent;
  dbeVolumeP: TDBEditFocus; dbePesoP: TDBEditFocus; blnComQtd: Boolean;
  blnBaixaOp: Boolean; Var arrSubOP: Array of TOrdProIndustrial;
  Var arrQryTabela: Array of TUniQuery);
Begin
  Inherited Create(Owner, fSQLOrdPro(blnComQtd));
  CarregandoItens := False;

  FchbUsaCapacidadeMaxima := Nil;

  FLisIte := '';

  blnUtilizaDistribuiLote := ((fUsaRotinaWMS) And (fCfgSis('MATBOP') = 'S') And (fCfgSis('OPINLT') = 'S')) ;


  cdsProdAcaNaoIncOPI := TZClient.Create(Self, fSQLProdutosAcabadosNaoInclusosOPI);
  dtsProdAcaNaoIncOPI := fCriaDataSource(cdsProdAcaNaoIncOPI);

  FDesenvFormulas := False;
  FAgrupamentoPedido := False;

  FOrdemProducao := TOrdemProducao.Create;

  objMonitor := Nil;
  objFasesOP := Nil;
  FarrSubOP := @arrSubOP;
  FarrQryTabela := @arrQryTabela;
  objLiberacao := TLiberacao.Create;
  objSalLoj := TSaldoLojas.Create(Self);

  FRestaurarCadastro := True;
  FGeraOpSubProdutos := fCfgSis('GOPSPR', varBoolean);
  FBxCompSubPro := fCfgSis('OPSPCO', varBoolean);
  FUsaCapacidadeMaxima := fCfgSis('CAPMAX', varBoolean);
  FExibeResumoDeCalculoOPITela:= fCfgSis('MOSCAL', varBoolean);
  FCapacidadeMaxima := 0;

  FUtilizaConferencia := fCfgSis('CONMAT', varBoolean);
  intCasasDecimaisMateriaPrima := fCfgSis('DECMOP', varInteger);

  dbeVolume := dbeVolumeP;
  dbePeso := dbePesoP;

  FConsiderarMultiploDeVenda := fCfgSis('ORDMTV', varBoolean);

  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecQtd := fCfgSis('DECQTD', varInteger);

  cdsProFor := TZClient.Create(Self);
  cdsProFor.pCriaSoma('PRECOM', 'TOTPRE');

  cdsOrdMat := TZClient.Create(Self, fSqlOrdMat);
  cdsOrdCom := TZClient.Create(Self, fSqlOrdCom);

  //alterado para tentar corrigir o erro intermitente de record not found
  cdsOrdCom.pSetUpdateMode(upWhereKeyOnly);

  // IMPRESSAO
  cdsCabIpr := TZClient.Create(Self, fSQLCabecalhoImpr);
  cdsCabIpB := TZClient.Create(Self, fSQLCabecalhoImpr);
  cdsDmtIpr := TZClient.Create(Self, fSQLFormulaIpr);
  cdsDisIpr := TZClient.Create(Self, fSQLFormulaIpr(True));

  stlItensSemUnidadeConfigurada := TStringList.Create;

  If blnBaixaOp Then
  Begin
    objCorrOP := TOrdProIndCorrecoes.Create(Self);
    objCorrOP.objOrdPro := Self;
  End
  Else
    objCorrOP := Nil;

  FPrgBar := Nil;

  recImpres.blnFormul       := True;
  recImpres.blnCorrec       := True;
  recImpres.blnConQua       := True;
  recImpres.blnTemPro       := True;
  recImpres.blnEnvase       := True;
  recImpres.blnFasDis       := False;
  recImpres.blnExtrus       := fCfgSis('EXMOPI', varBoolean);
  recImpres.blnAnaFor       := False;
  recImpres.blnDadCli       := fCfgSis('MDORIN', varInteger) = 4;
  recImpres.strAutImp       := '';
  recImpres.strCodGra       := '';
  recImpres.strCodCorDesenv := '';
  recImpres.strObserv       := '';
  recImpres.intQtdPar       := 1;
  recImpres.intQtdFas       := 0;
  recImpres.blnLocFis       := False;
  recImpres.blnVisCon       := True;
  recImpres.blnObsAss       := False;

  If fAgrLot Then
  Begin
    cdsAgrLot := TZClient.Create(Self, fSQLAgrLot);
    cdsAgrLot.BeforePost := pCdsAgrLotBeforePost;

  End;

  FCodAca:= '';
  FNumOrd:= '';
  FDesIte:= '';
  FUndMed:= '';
  FCusFor:= 0.00;
  FEstAtu:= 0.00;
  FQtdPro:= 0.00;
  FQtdPzd:= 0.00;
  FEstFin:= 0.00;
  FCusAtu:= 0.00;
  FCusUni:= 0.00;

  If FExibeResumoDeCalculoOPITela Then
    pCriaDataSetCustosProducao;

  blnBaiVef := fCfgSis('BAIVEF', varBoolean);

  blnUtilizaDistribuiLote := ((fUsaRotinaWMS) And (fCfgSis('MATBOP') = 'S') And (fCfgSis('OPINLT') = 'S')) ;
  If blnUtilizaDistribuiLote Then
    pCriaDataSetLotesDefinidosPedido;

  Self.AfterPost := pAfterPost;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
End;

Procedure TOrdProIndustrial.pCdsAgrLotBeforePost(DataSet : TDataSet);
Begin
  If DataSet.FieldByName('ESTUTI').AsFloat > DataSet.FieldByName('LOT_SALDOS').AsFloat Then
  Begin
    fMensagem('','A quantidade não pode ser maior que o estoque disponível!', ['&Ok']);
    Abort;
  End;

End;

Destructor TOrdProIndustrial.Destroy;
Begin
  FreeAndNIl(FQryConsulta);
  If fAgrLot Then
    FreeAndNil(cdsAgrLot);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  if Assigned(stlItensSemUnidadeConfigurada) then
    FreeAndNil(stlItensSemUnidadeConfigurada);

  if Assigned(FOrdemProducao) then
    FreeAndNil(FOrdemProducao);

  if Assigned(cdsCustoProducao) Then
    FreeAndNil(cdsCustoProducao);

  if Assigned(cdsProdAcaNaoIncOPI) Then
    FreeAndNil(cdsProdAcaNaoIncOPI);
  if Assigned(cdsLotesDefinidosPedido) Then
    FreeAndNil(cdsLotesDefinidosPedido);

  if Assigned(cdsLotesDefinidosPedidoSaldos) Then
    FreeAndNil(cdsLotesDefinidosPedidoSaldos);

  If Assigned(qryInsLotesProc) Then
    FreeAndNil(qryInsLotesProc);

  If Assigned(cdsLotesGeradosProcedure) Then
    FreeAndNil(cdsLotesGeradosProcedure);

  pRemoveTmpEditorRelatorios;

  Inherited;
End;

Function TOrdProIndustrial.fSqlProdutosFormula(blnOrdMat: Boolean): String;

  Function fSqlProdutos(blnFormula: Boolean): String;
  Begin
    Result := '';
    Result := Result + ' SELECT SQL_NO_CACHE ';
    Result := Result + '   "FORMUL"     AS TIPPRO, ';
    Result := Result + '   "NORMAL"     AS TIPITE, ';
    Result := Result + '   CAST("" AS CHAR(30))  AS NUMLOT, ';
    Result := Result + '   CAST("AAAAA" AS CHAR('+fTamCodIte.ToString()+'))     AS ITEACA, ';
    Result := Result + '   D.DMT_ITESUB AS ITESUB, ';
    Result := Result + '   D.DMT_QTDITE AS QTDITE, ';
    Result := Result + '   F.ITE_DESITE AS DESITE, ';
    Result := Result + '   F.ITE_REFERE AS REFERE, ';
    Result := Result + '   F.ITE_DENSID AS DENSID, ';
    Result := Result + '  IG.ITE_SALDOS AS SALDOS, ';
    Result := Result + '  IG.ITE_PRECUS AS PRECUS, ';

    Result := Result + '   0.0000       AS SALRES, ';
    Result := Result + '   0.0000       AS QTDTOT, ';
    Result := Result + '   0.0000       AS QTDTOTACUMULADO, ';
    Result := Result + '   0.0000       AS QTDPROACUMULADO, ';
    Result := Result + '   "N"          AS SEMSAL, ';
    Result := Result + '   0.0000       AS RESREA, ';
    Result := Result + '   0.0000       AS PRECOM, ';
    Result := Result + '   0.0000       AS SALDIS, ';
    Result := Result + '   D.DMT_SEQUEN AS SEQUEN, ';
    Result := Result + '   "D"          AS MARDES, ';
    Result := Result + '   "N"          AS ITTEMP, ';


    If FGeraOpSubProdutos Then
    Begin
      Result := Result + ' DEP_PROACA   AS PROACA, ';
      Result := Result + ' F.ITE_CODCOR AS CODCOR, ';
      Result := Result + ' F.ITE_CODPAG AS CODPAG, ';
    End;

    Result := Result + '   ""           AS ODMINC,  ';
    Result := Result + '   ""           AS SEMPRO  ';
    Result := Result + ' FROM CADITE GR                                      ';

    Result := Result + ' INNER JOIN GEIMAT G ON GR.ITE_CODITE = G.GMT_CODITE ';
    Result := Result + '                      AND GMT_CODCOR = :CODCOR       ';

    Case fCfgSis('TPBAOP', varInteger) Of
      1: Result := Result + '                 AND GMT_STATUS = "A"           ';
      2: Result := Result + '                 AND GMT_FORMUL = :FORMUL       ';
    End;

    If blnFormula Then
    Begin
      Result := Result + ' INNER JOIN DEIMAT D ON G.AUTOINCREM = D.DMT_SEQGER     ';
    End
    Else
    Begin
      Result := Result + ' INNER JOIN DEICOR D ON G.AUTOINCREM = D.DMT_SEQGER AND ';
      Result := Result + '                        D.DMT_SEQORD = :SEQORD          ';
    End;

    Result := Result + ' INNER JOIN CADITE F ON F.ITE_CODITE = D.DMT_ITESUB  ';

    If FGeraOpSubProdutos Then
    Begin
      Result := Result + ' LEFT JOIN CADDEP ON DEP_CODIGO = F.ITE_CODDEP     ';
    End;

    Result := Result + ' INNER JOIN ITEGER IG ON IG.ITE_CODITE = D.DMT_ITESUB AND ';
    Result := Result + '                         IG.ITE_CODEMP = :CODEMP          ';

    Result := Result + ' WHERE ';
    Result := Result + '   GR.ITE_CODITE = :CODITE AND DMT_QTDITE <> 0 ';
  End;

Begin
  Result := '/* untOrdProIndustrial.fSqlProdutosFormula */';

  {************************************************************}
  {* Se não for Baixa de ordem de produção carrega a formula  *}
  {* do cadastro de formulas, não é carregado da ORDMAT, pois *}
  {* a funçao "fVerificaQuantidadeEstoque" é chamada antes da *}
  {* gravação dos dados ( ainda nao tem ORDMAT ), sendo assim *}
  {* no cadastro da OP é utilizado os dados do cadastro, e na *}
  {* baixa é utilizado os dados da ORDMAT que foram gravados  *}
  {* na inclusão da Ordem de Produção;                        *}
  {************************************************************}
  {* Manter a mesma quantidade de colunas nos 3 select's      *}
  {* Olhe que tem uma função e um Union All                   *}
  {*********************************************************GB*}

  If (not blnOrdMat) Then
  Begin
    Result := Result + fSqlProdutos(True);
  End
  Else
  Begin
    Result := Result + ' SELECT SQL_NO_CACHE ';
    Result := Result + '   "FORMUL"     AS TIPPRO, ';
    Result := Result + '   "NORMAL"     AS TIPITE, ';
    Result := Result + '   CAST("" AS CHAR(30))  AS NUMLOT, ';
    Result := Result + '   CAST("AAAAA" AS CHAR('+fTamCodIte.ToString()+'))     AS ITEACA, ';
    Result := Result + '   D.ODM_ITESUB AS ITESUB, ';
    Result := Result + '   D.ODM_QTDITE AS QTDITE, ';
    Result := Result + '   F.ITE_DESITE AS DESITE, ';
    Result := Result + '   F.ITE_REFERE AS REFERE, ';
    Result := Result + '   F.ITE_DENSID AS DENSID, ';
    Result := Result + '  IG.ITE_SALDOS AS SALDOS, ';
    Result := Result + '  IG.ITE_PRECUS AS PRECUS, ';
    Result := Result + '   0.0000       AS SALRES, ';
    Result := Result + '   0.0000       AS QTDTOT, ';
    Result := Result + '   0.0000       AS QTDTOTACUMULADO, ';
    Result := Result + '   0.0000       AS QTDPROACUMULADO, ';
    Result := Result + '   "N"          AS SEMSAL, ';
    Result := Result + '   0.0000       AS RESREA, ';

    Result := Result + '   0.0000       AS PRECOM, ';
    Result := Result + '   0.0000       AS SALDIS, ';
    Result := Result + '   D.ODM_SEQUEN AS SEQUEN, ';
    Result := Result + '   "D"          AS MARDES, ';
    Result := Result + '   "N"          AS ITTEMP, ';

    If FGeraOpSubProdutos Then
    Begin
      Result := Result + ' DEP_PROACA   AS PROACA, ';
      Result := Result + ' F.ITE_CODCOR AS CODCOR, ';
      Result := Result + ' F.ITE_CODPAG AS CODPAG, ';
    End;

    Result := Result + '   D.AUTOINCREM AS ODMINC, ';
    Result := Result + '   D.ODM_SEQITE AS SEQUEN, ';
    Result := Result + '   ""           AS SEMPRO  ';

    Result := Result + ' FROM ORDMAT D             ';
    Result := Result + ' INNER JOIN CADITE F ON F.ITE_CODITE = D.ODM_ITESUB     ';

    If FGeraOpSubProdutos Then
    Begin
      Result := Result + ' LEFT JOIN CADDEP ON DEP_CODIGO = F.ITE_CODDEP ';
    End;

    Result := Result + ' INNER JOIN ITEGER IG ON IG.ITE_CODITE = D.ODM_ITESUB AND ';
    Result := Result + '                         IG.ITE_CODEMP = :CODEMP          ';
    Result := Result + ' WHERE ODM_SEQGER = :SEQORD AND ODM_QTDITE <> 0 ';

    Result := Result + ' UNION ALL ';

    Result := Result + ' SELECT SQL_NO_CACHE ';
    Result := Result + '   "FORMUL"     AS TIPPRO, ';
    Result := Result + '   "CORREC"     AS TIPITE, ';
    Result := Result + '   DMT_NUMLOT   AS NUMLOT, ';
    Result := Result + '   CAST("AAAAA" AS CHAR('+fTamCodIte.ToString()+'))     AS ITEACA, ';
    Result := Result + '   D.DMT_ITESUB AS ITESUB, ';
    Result := Result + '   D.DMT_QTDITE AS QTDITE, ';
    Result := Result + '   F.ITE_DESITE AS DESITE, ';
    Result := Result + '   F.ITE_REFERE AS REFERE, ';
    Result := Result + '   F.ITE_DENSID AS DENSID, ';
    Result := Result + '  IG.ITE_SALDOS AS SALDOS, ';
    Result := Result + '  IG.ITE_PRECUS AS PRECUS, ';

    Result := Result + '   0.0000       AS SALRES, ';
    Result := Result + '   0.0000       AS QTDTOT, ';
    Result := Result + '   0.0000       AS QTDTOTACUMULADO, ';
    Result := Result + '   0.0000       AS QTDPROACUMULADO, ';
    Result := Result + '   "N"          AS SEMSAL, ';
    Result := Result + '   0.0000       AS RESREA, ';
    Result := Result + '   0.0000       AS PRECOM, ';
    Result := Result + '   0.0000       AS SALDIS, ';
    Result := Result + '   0            AS SEQUEN, ';
    Result := Result + '   "D"          AS MARDES, ';
    Result := Result + '   "N"          AS ITTEMP, ';

    If FGeraOpSubProdutos Then
    Begin
      Result := Result + ' DEP_PROACA   AS PROACA, ';
      Result := Result + ' F.ITE_CODCOR AS CODCOR, ';
      Result := Result + ' F.ITE_CODPAG AS CODPAG, ';
    End;

    Result := Result + '   ""           AS ODMINC, ';
    Result := Result + '   D.DMT_SEQUEN AS SEQUEN,  ';
    Result := Result + '   ""           AS SEMPRO  ';
    Result := Result + ' FROM DEICOR D             ';
    Result := Result + ' INNER JOIN CADITE F ON F.ITE_CODITE = D.DMT_ITESUB ';

    If FGeraOpSubProdutos Then
    Begin
      Result := Result + ' LEFT JOIN CADDEP ON DEP_CODIGO = F.ITE_CODDEP ';
    End;

    Result := Result + ' INNER JOIN ITEGER IG ON IG.ITE_CODITE = D.DMT_ITESUB AND ';
    Result := Result + '                         IG.ITE_CODEMP = :CODEMP          ';

    Result := Result + ' WHERE D.DMT_SEQORD = :SEQORD ';
    Result := Result + '   AND DMT_QTDITE <> 0        ';
  End;

End;

Function TOrdProIndustrial.fSqlProdutosComposicaoSoma: String;
Begin
  Result := '/* untOrdProIndustrial.fSqlProdutosComposicaoSoma */';

  Result := Result + ' SELECT SQL_NO_CACHE       ';

  Result := Result + '   "COMPOS"     AS TIPPRO, ';
  Result := Result + '   "COMPOS"     AS TIPITE, ';
  Result := Result + '   A.ITE_CODITE AS ITEACA, ';
  Result := Result + '   C.ITE_CODITE AS ITESUB, ';
  Result := Result + '   SUM(D.DCO_QTDITE) AS QTDITE, ';
  Result := Result + '   C.ITE_DESITE AS DESITE, ';
  Result := Result + '   C.ITE_DENSID AS DENSID, ';
  Result := Result + '  IG.ITE_SALDOS AS SALDOS, ';
  Result := Result + '  IG.ITE_PRECUS AS PRECUS, ';
  Result := Result + '  DCO_IMP_OP    AS IMP_OP, ';
  Result := Result + '  UN.UNI_SIGUNI AS SIGUNI, ';
  Result := Result + '   C.ITE_REFERE AS REFERE, ';
  Result := Result + '   0.0000       AS SALRES, ';
  Result := Result + '   0.0000       AS QTDTOT, ';
  Result := Result + '   0.0000       AS QTDTOTACUMULADO, ';
  Result := Result + '   0.0000       AS QTDPROACUMULADO, ';
  Result := Result + '   "N"          AS SEMSAL, ';
  Result := Result + '   0.0000       AS RESREA, ';

  Result := Result + '   0.0000       AS PRECOM  ';

  Result := Result + ' FROM   ';
  Result := Result + '   CADITE A ';
  Result := Result + ' INNER JOIN GERCOM G  ON  A.ITE_CODCOM = G.GCO_CODCOM     ';
  Result := Result + ' INNER JOIN DETCOM D  ON  D.DCO_SEQGER = G.AUTOINCREM     ';
  Result := Result + ' INNER JOIN CADITE C  ON  C.ITE_CODITE = D.DCO_CODITE     ';
  Result := Result + ' INNER JOIN CADUNI UN ON UN.UNI_CODUNI = C.ITE_CODUNI     ';
  Result := Result + ' INNER JOIN ITEGER IG ON IG.ITE_CODITE = D.DCO_CODITE AND ';
  Result := Result + '                         IG.ITE_CODEMP = :CODEMP          ';
  Result := Result + ' WHERE ';
  Result := Result + '   A.ITE_CODPAG = :CODITE AND ';
  Result := Result + '   A.ITE_CODCOR = :CODCOR AND ';
  Result := Result + '   A.ITE_CODITE = :CODACA     ';
  Result := Result + ' GROUP BY ';
  Result := Result + '   C.ITE_CODITE ';
  Result := Result + ' ORDER BY D.DCO_SEQUEN ';
End;

Function TOrdProIndustrial.fSQLOrdPro(blnComQtd: Boolean = False): String;
var
  objSQLOrdProdIndustrial: TSQLOrdProdIndustrial;
Begin
  objSQLOrdProdIndustrial:= TSQLOrdProdIndustrial.create;
  Try
    objSQLOrdProdIndustrial.blnComQtd:= blnComQtd;
    objSQLOrdProdIndustrial.blnConCom:= fCfgSis('CONCOM', varBoolean);
    Result:= objSQLOrdProdIndustrial.fRetornaSQLOrdPro;
  Finally
    FreeAndNil(objSQLOrdProdIndustrial);
  End;
End;

function TOrdProIndustrial.fRetornaObsProcProducao(strCodIte,
  strCodCor: String): String;
Var
  qryCons: TUniQuery;
begin
  Result:= '';

  qryCons := fCriaQuery(Nil);
  Try
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add(' SELECT GMT_OBS008 AS OBS ');
    qryCons.SQL.Add(' FROM GEIMAT ');
    qryCons.SQL.Add(' WHERE');
    qryCons.SQL.Add('   GMT_STATUS = "A"        AND');
    qryCons.SQL.Add('   GMT_CODITE = :CODITE    AND');
    qryCons.SQL.Add('   GMT_CODCOR = :CODCOR    AND');
    qryCons.SQL.Add('   GMT_CODEMP = :CODEMP       ');

    qryCons.ParamByName('CODITE').AsString := strCodIte;
    qryCons.ParamByName('CODCOR').AsString := strCodCor;
    qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryCons.Open;

    Result:= qryCons.FieldByName('OBS').AsString;
  Finally
    FreeAndNil(qryCons);
  End;

end;

Function TOrdProIndustrial.fRetornaPesoRealFormula(strAutInc : String): Double;
Var
  qryCons: TUniQuery;
begin
  Result := 0;
  Try

    Try

      qryCons := fCriaQuery(Nil);
      With qryCons, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT ORD_PESREA AS PESREA ');
        Add(' FROM ORDGER ');
        Add(' WHERE AUTOINCREM = :AUTINC ');
        ParamByName('AUTINC').AsString := strAutInc;
        Open;

        Result := FieldByName('PESREA').AsFloat;

        Close;

      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fRetornaPesoRealFormula]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

Class Function TOrdProIndustrial.fTemFormula(strCodIte, strCodCor: String): Boolean;
Var
  qryCons: TUniQuery;
begin
  Result := False;
  Try

    Try

      qryCons := fCriaQuery(Nil);
      With qryCons, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT GMT_PESREA AS PESREA ');
        Add(' FROM GEIMAT ');
        Add(' WHERE');
        Add('   GMT_STATUS = "A"        AND');
        Add('   GMT_CODITE = :CODITE    AND');
//        Add('   GMT_CODEMP = :CODEMP    AND');
        Add('   GMT_CODCOR = :CODCOR       ');

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODCOR').AsString := strCodCor;
 //       ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        Result := Not qryCons.IsEmpty;

        Close;

      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fRetornaPesoRealFormula]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;

End;

Class Function TOrdProIndustrial.fRetornaPesoRealFormula(strCodIte, strCodCor: String): Double;
Var
  qryCons: TUniQuery;
begin
  Result := 0;
  Try

    Try

      qryCons := fCriaQuery(Nil);
      With qryCons, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT GMT_PESREA AS PESREA ');
        Add(' FROM GEIMAT ');
        Add(' WHERE');
        Add('   GMT_STATUS = "A"        AND');
        Add('   GMT_CODITE = :CODITE    AND');
//        Add('   GMT_CODEMP = :CODEMP    AND');
        Add('   GMT_CODCOR = :CODCOR       ');

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODCOR').AsString := strCodCor;
 //       ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        Result := FieldByName('PESREA').AsFloat;

        Close;

      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fRetornaPesoRealFormula]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;


procedure TOrdProIndustrial.pCompletaCorrecoes;
var
  i:Integer;
  fltQtdUtilizadaNoLote,
  fltQtdLoteAtual: Double;
  strNumLote: String;
begin
  If blnUtilizaDistribuiLote Then
  Begin
    cdsLotesDefinidosPedido.BeforePost := nil;
    cdsLotesDefinidosPedido.AfterPost  := nil;
  End;
  Try
    If Not Assigned(objCorrOP) Then
      Exit;

    if objCorrOP.blnMATBOP then
    begin
      i := objCorrOP.RecordCount;
      fltQtdUtilizadaNoLote := 0;
      fltQtdLoteAtual := 0;
      cdsProFor.First;
      while not cdsProFor.Eof do
      begin
        If objCorrOP.Locate('DMT_ITESUB', cdsProFor.FieldByName('ITESUB').AsString, []) Then
        Begin
          objCorrOP.Edit;
          objCorrOP.FieldByName('QTD_OP').AsFloat := objCorrOP.FieldByName('QTD_OP').AsFloat +
                                                     RoundTo(cdsProFor.FieldByName('QTDTOT').AsFloat, -4);
          objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat := objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat+
                                                            RoundTo(cdsProFor.FieldByName('QTDTOT').AsFloat, -4);

        End
        Else
        Begin
          objCorrOP.Insert;
          objCorrOP.FieldByName('DMT_ITESUB').AsString := cdsProFor.FieldByName('ITESUB').AsString;
          if cdsProFor.FieldByName('TIPITE').AsString = 'NORMAL' then
          Begin
            inc(i);
            objCorrOP.FieldByName('DMT_SEQUEN').AsInteger := i;
          End
          Else
            objCorrOP.FieldByName('DMT_SEQUEN').AsInteger := cdsProFor.FieldByName('SEQUEN').AsInteger;
          objCorrOP.FieldByName('DMT_REFERE').AsString    := cdsProFor.FieldByName('DESITE').AsString;
          objCorrOP.FieldByName('REFERENCIA').AsString    := cdsProFor.FieldByName('REFERE').AsString;
          objCorrOP.FieldByName('QTD_OP').AsFloat         := RoundTo(cdsProFor.FieldByName('QTDTOT').AsFloat, -4);
          objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat  := objCorrOP.FieldByName('QTD_OP').AsFloat;
          If (fUsaRotinaWMS) Then
          Begin
            pRetornaNumeroLoteFatDor(fltQtdUtilizadaNoLote, strNumLote, fltQtdLoteAtual, FAutInc, cdsProFor.FieldByName('ITESUB').AsString);
            objCorrOP.FieldByName('NUMLOT').AsString             := strNumLote;
            objCorrOP.FieldByName('QTD_UTILIZADA_LOTE').AsFloat  := fltQtdUtilizadaNoLote;
            objCorrOP.FieldByName('SALDO_ATUAL_LOTE').AsFloat    := fltQtdLoteAtual;
          End;

        End;
        objCorrOP.FieldByName('DMT_QTDITE').AsFloat   := 0;
        objCorrOP.Post;
        cdsProFor.Next;
      end;
    end;
  Finally
    Self.IndexFieldNames := 'DESITE';
    If blnUtilizaDistribuiLote Then
      Begin
        cdsLotesDefinidosPedido.BeforePost := cdsLotesDefinidosPedidoBeforePost;
        cdsLotesDefinidosPedido.AfterPost := cdsLotesDefinidosPedidoAfterPost;
      End;
  End;

end;

Procedure TOrdProIndustrial.pCompletaProdutos(strCodIte, strCodCor: String;
  blnImpressao: Boolean = False; blnBaixaOrdem: Boolean = False);
Var
  qryAcabados: TUniQuery;
  blnIncusao: Boolean;
  intOrdIte: Integer;
  recSaldos,
  recSaldosML: TRecSaldos;

  fltSaldos : double;
Begin
  intOrdIte := 0;
  blnIncusao := Self.IsEmpty;
  stlItensSemUnidadeConfigurada.Clear;

  qryAcabados := fCriaQuery(Self);

  With qryAcabados, SQL Do
  Begin
    Clear;

    If FDesenvFormulas Then
    Begin

      Add('/* untOrdProIndustrial.pCompletaProdutos */          ');
      Add('SELECT SQL_NO_CACHE                                  ');
      Add('  I.ITE_CODITE,                                      ');
      Add('  I.ITE_CODPAG,                                      ');
      Add('  I.ITE_CODBAR,                                      ');
      Add('  I.ITE_DESITE,                                      ');
      Add('  UNI_SIGUNI,                                        ');
      Add('  UNI_DESUNI,                                        ');
      Add('  UNI_KILLIT,                                        ');
      Add('  MAR_DESMAR,                                        ');
      Add('  1 AS UNI_PESLIT,                                   ');
      Add('  IFNULL(ITE_MLTVEN,0) AS MLTVEN,                    ');
      Add('  G.ITE_SALDOS,                                      ');
      Add('  G.ITE_ESTMIN,                                      ');
      Add('  G.ITE_ESTMAX,                                      ');
      Add('  IFNULL(I.ITE_CNV_ML,0) AS CNV_ML,                  ');
      Add('  G.ITE_SAL_ML                                       ');
      Add('FROM                                                 ');
      Add('  CADITE I                                           ');
      Add('  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
      Add('                     AND G.ITE_CODEMP = :CODEMP      ');
      Add('  INNER JOIN CADUNI   ON UNI_CODUNI   = I.ITE_CODUNI ');
      Add('  LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ');
      Add('WHERE                                                ');
      Add('  I.ITE_CODITE = :CODITE    AND                      ');
      Add('  I.ITE_ITEATI = "S"                                     ');
      Add('ORDER BY ITE_DESITE                                  ');

    End Else
    Begin
      Add('/* untOrdProIndustrial.pCompletaProdutos */          ');
      Add('SELECT SQL_NO_CACHE                                  ');
      Add('  I.ITE_CODITE,                                      ');
      Add('  I.ITE_CODPAG,                                      ');
      Add('  I.ITE_DESITE,                                      ');
      Add('  I.ITE_CODBAR,                                      ');
      Add('  UNI_SIGUNI,                                        ');
      Add('  UNI_DESUNI,                                        ');
      Add('  UNI_KILLIT,                                        ');
      Add('  MAR_DESMAR,                                        ');
      Add('  UNI_PESLIT,                                        ');
      Add('  IFNULL(ITE_MLTVEN,0) AS MLTVEN,                    ');
      Add('  G.ITE_SALDOS,                                      ');
      Add('  G.ITE_ESTMIN,                                      ');
      Add('  G.ITE_ESTMAX,                                      ');
      Add('  IFNULL(I.ITE_CNV_ML,0) AS CNV_ML,                  ');
      Add('  G.ITE_SAL_ML                                       ');
      Add('FROM                                                 ');
      Add('  CADITE I                                           ');
      Add('  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
      Add('                     AND G.ITE_CODEMP = :CODEMP      ');
      Add('  INNER JOIN CADUNI   ON UNI_CODUNI   = I.ITE_CODUNI ');
      Add('  LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ');
      Add('WHERE I.ITE_CODPAG = :CODITE                         ');
      Add('  AND I.ITE_CODCOR = :CODCOR                         ');
      Add('  AND I.ITE_ITEATI = "S"                                 ');

      //produtos resíduos para ordens de produção baixadas
      if (not fEmptyStr(qryQuery.ParamByName('SEQGER').AsString)) then begin
        Add('UNION ALL                                            ');
        Add('SELECT                                               ');
        Add('  I.ITE_CODITE,                                      ');
        Add('  I.ITE_CODPAG,                                      ');
        Add('  I.ITE_DESITE,                                      ');
        Add('  I.ITE_CODBAR,                                      ');
        Add('  UNI_SIGUNI,                                        ');
        Add('  UNI_DESUNI,                                        ');
        Add('  UNI_KILLIT,                                        ');
        Add('  MAR_DESMAR,                                        ');
        Add('  UNI_PESLIT,                                        ');
        Add('  IFNULL(ITE_MLTVEN,0) AS MLTVEN,                    ');
        Add('  G.ITE_SALDOS,                                      ');
        Add('  G.ITE_ESTMIN,                                      ');
        Add('  G.ITE_ESTMAX,                                      ');
        Add('  IFNULL(I.ITE_CNV_ML,0) AS CNV_ML,                  ');
        Add('  G.ITE_SAL_ML                                       ');
        Add('FROM                                                 ');
        Add('  ORDDET                                             ');
        Add('  INNER JOIN CADITE I ON I.ITE_CODITE = ORD_CODITE   ');
        Add('  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
        Add('                     AND G.ITE_CODEMP = :CODEMP      ');
        Add('INNER JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI       ');
        Add('LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR   ');
        Add('WHERE                                                ');
        Add('  ORD_SEQGER               =  :AUTOINC AND           ');
        Add('  IFNULL(I.ITE_CODPAG, "") <> :CODITE  AND           ');
        Add('  I.ITE_ITEATI = "S"                                     ');
        ParamByName('AUTOINC').AsString := qryQuery.ParamByName('SEQGER').AsString;
      end;

      Add('ORDER BY ITE_DESITE ');
      ParamByName('CODCOR').AsString := strCodCor;
    End;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not fEmptyStr(Self.FieldByName('ORD_SEQGER').AsString) then
      fltPesRea := fRetornaPesoRealFormula(Self.FieldByName('ORD_SEQGER').AsString)
    Else
      fltPesRea := fRetornaPesoRealFormula(strCodIte, strCodCor);

    FLisIte := '';

    Self.DisableControls;
    Try
      Self.First;
      While Not Eof Do
      Begin

        If blnIncusao Or (Not Self.Locate('ORD_CODITE', FieldByName('ITE_CODITE').AsString, [])) Then
        Begin

          If (not fEmptyStr(Self.FieldByName('ORD_SEQGER').AsString)) or blnImpressao  Then
          Begin
            Next;
            Continue;
          End;

          Self.Insert;
          Self.FieldByName('ORD_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          Self.FieldByName('ORD_QTDPRO').AsFloat := 0;
        End
        Else
        Begin
          Self.Edit;
        End;

        FLisIte := FLisIte + FieldByName('ITE_CODITE').AsString + '_';

        Self.FieldByName('ITE_CODPAG').AsString := FieldByName('ITE_CODPAG').AsString;
        Self.FieldByName('ITE_CODCOR').AsString := strCodCor;

        Self.FieldByName('ESTOQUE_MINIMO').AsFloat := FieldByName('ITE_ESTMIN').AsFloat;
        Self.FieldByName('ESTOQUE_MAXIMO').AsFloat := FieldByName('ITE_ESTMAX').AsFloat;
        Self.FieldByName('CODBAR').AsString        := FieldByName('ITE_CODBAR').AsString;


        fltSaldos := FieldByName('ITE_SALDOS').AsFloat;

        If (FieldByName('CNV_ML').AsFloat > 0) Then
          fltSaldos := fltSaldos + FieldByName('ITE_SAL_ML').AsFloat / FieldByName('CNV_ML').AsFloat;

        objSalLoj.pCalculaSaldos(Nil, recSaldos, recSaldosML,
                              fltSaldos, VS_strCodEmp, VS_strCodEmp,
                              Self.FieldByName('ORD_CODITE').AsString, FieldByName('CNV_ML').AsFloat,
                              fCfgSis('ENTFUT', varBoolean), false, fCfgSis('ORDPRO', varBoolean), fCfgSis('CALSAL', varInteger));

        Self.FieldByName('ESTOQUE_FISICO').AsFloat     := recSaldos.fltEstFis;
        Self.FieldByName('ESTOQUE_DISPONIVEL').AsFloat := recSaldos.fltSalDis;


        Self.FieldByName('DESITE').AsString := FieldByName('ITE_DESITE').AsString;
        Self.FieldByName('SIGUNI').AsString := FieldByName('UNI_SIGUNI').AsString;
        Self.FieldByName('DESUNI').AsString := FieldByName('UNI_DESUNI').AsString;

        Self.FieldByName('DESMAR').AsString := FieldByName('MAR_DESMAR').AsString;
        Self.FieldByName('PESLIT').AsFloat  := FieldByName('UNI_PESLIT').AsFloat;
        Self.FieldByName('MLTVEN').AsFloat  := FieldByName('MLTVEN').AsFloat;

        if Self.FieldByName('PESLIT').AsFloat = 0 then
          stlItensSemUnidadeConfigurada.Add(Self.FieldByName('ORD_CODITE').AsString + ' - ' + Self.FieldByName('SIGUNI').AsString);

        Self.FieldByName('PESREA').AsFloat  := fltPesRea;
        Self.FieldByName('KILLIT').AsString := qryAcabados.FieldByName('UNI_KILLIT').AsString;
        Self.FieldByName('ESTUTI').AsFloat  := 0.00;

        If qryAcabados.FieldByName('UNI_KILLIT').AsString = 'K' Then
        Begin
          Self.FieldByName('PESACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat;

          If Self.FieldByName('PESREA').AsFloat > 0 Then
            Self.FieldByName('VOLACA').AsFloat := (Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat) / Self.FieldByName('PESREA').AsFloat
          Else
            Self.FieldByName('VOLACA').AsFloat := 0;

        End
        Else
        Begin
          Self.FieldByName('PESACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat *
                                                Self.FieldByName('PESREA').AsFloat;

          Self.FieldByName('VOLACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat;
        End;


        If Self.FieldByName('ORD_QTDPRO').AsFloat > 0 Then
        Begin
          Self.FieldByName('PESUNI').AsFloat := Self.FieldByName('PESACA').AsFloat / Self.FieldByName('ORD_QTDPRO').AsFloat;
          Self.FieldByName('VOLUNI').AsFloat := Self.FieldByName('VOLACA').AsFloat / Self.FieldByName('ORD_QTDPRO').AsFloat;

          If blnBaixaOrdem Then
          Begin
            inc(intOrdIte);
            Self.FieldByName('ORDITE').AsString := fStrZero(IntToStr(intOrdIte), 2);
          End;

        End
        Else
        Begin

          If qryAcabados.FieldByName('UNI_KILLIT').AsString = 'K' Then
          Begin
            Self.FieldByName('PESUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat;
            Self.FieldByName('VOLUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat / Self.FieldByName('PESREA').AsFloat;
          End
          Else
          Begin
            Self.FieldByName('PESUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat * Self.FieldByName('PESREA').AsFloat;
            Self.FieldByName('VOLUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat;
          End;

        End;

        If blnBaixaOrdem Then
        Begin
          if FUtilizaConferencia then
            Self.FieldByName('ORD_QTDENV').AsFloat := Self.FieldByName('ORD_QTDCON').AsFloat
          else
            Self.FieldByName('ORD_QTDENV').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat;

          // Ao Carregar sugestão de baixa quando usa baixa parcial, tira do total da OP o que ja foi baixado Parcialmente
          if fCfgSis('OIBXPA', varBoolean) Then
          Begin
            Self.FieldByName('QTDBAI').AsFloat     := fRetQtdeBaixaParcial(Self.FieldByName('ORD_CODITE').AsString);
            Self.FieldByName('ORD_QTDENV').AsFloat := Self.FieldByName('ORD_QTDENV').AsFloat - Self.FieldByName('QTDBAI').AsFloat;
            If Self.FieldByName('ORD_QTDENV').AsFloat < 0then
              Self.FieldByName('ORD_QTDENV').AsFloat := 0;

          End;

          If Self.FieldByName('ORD_QTDPRO').AsFloat = 0 Then
          Begin

            If qryAcabados.FieldByName('UNI_KILLIT').AsString = 'K' Then
            Begin
              Self.FieldByName('PESUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat;
              Self.FieldByName('VOLUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat / Self.FieldByName('PESREA').AsFloat;
            End
            Else
            Begin
              Self.FieldByName('PESUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat * Self.FieldByName('PESREA').AsFloat;
              Self.FieldByName('VOLUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat;
            End;

          End;

        End;

        Self.Post;

        Next;
      End;

      If blnBaixaOrdem Then
      Begin

        Self.First;
        While Not Self.Eof Do
        Begin

          If fEmptyStr(Self.FieldByName('ORDITE').AsString) Then
          Begin
            inc(intOrdIte);

            Self.Edit;
            Self.FieldByName('ORDITE').AsString := fStrZero(IntToStr(intOrdIte), 2);
            Self.Post;
          End;

          Self.Next;
        End;

      End;
    Finally
      Self.EnableControls;
    End;

  End;

  Self.First;

  FreeAndNil(qryAcabados);
End;


function TOrdProIndustrial.fCarregaItensInterna(cxProgressBar : TcxProgressBar) : Boolean;
var
  strNumLote: String;
  fltQtdLoteAtual,
  fltQtdUtilizadaNoLote: Double;
  strAutIncGEIMAT: String;
  i: integer;

Begin
  With qryQuery Do
  Begin
    qryQuery.Close;
    ParamByName('SEQGER').AsString := FAutInc;
  End;

  If cdsOrdMat.Active Then
    cdsOrdMat.EmptyDataSet;
  cdsOrdMat.qryQuery.ParamByName('SEQGER').AsString := FAutInc;
  cdsOrdMat.fAbreClient(True, 'TOrdProIndustrial.fCarregaItens');

  pCarregaComposicoes(FAutInc);

  TFloatField(cdsOrdMat.FieldByName('ODM_QTDITE')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsOrdMat.FieldByName('ODM_DENSID')).DisplayFormat := fMskDigitos(4);

  pCarregaTipoProducao(FCodIte);

  Result := fAbreClient(True, 'TOrdProIndustrial.fCarregaItens');



  If  blnUtilizaDistribuiLote  And FBaixaOrdem Then
  Begin
    While not Self.Eof Do
    Begin
      Self.Edit;
      Self.FieldByName('QTDPRO_NOV').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat;
      Self.Post;
      Self.Next;
    End;

  End;
  Self.First;

  Self.FieldByName('ORD_QTDPRO').OnChange := pQtdProDataChange;

  pCompletaProdutos(FCodIte, FCodCor, FImpressao, FBaixaOrdem);

  if fEmptyStr(FAutInc) And (not fEmptyStr(FCodIte)) And (not fEmptyStr(FCodCor)) Then
  Begin
    pCarregaOrdMat(FCodIte, FCodCor);
    pCarregaOrdCom(FCodIte, FCodCor);
  End;

  if FUsaCapacidadeMaxima and (not FAgrupamentoPedido) then
  begin

    if fEmptyStr(FAutInc) then
      FCapacidadeMaxima := fRetCapacidadeMaximaFormula(FCodIte, FCodCor)
    else
      FCapacidadeMaxima := fRetCapacidadeMaximaOrdemProducao(FAutInc);

      If (not FBaixaOrdem) Then
        pCalculaCapacidadeMaximaAcabados;

  end;


  fltPesoEspecifico := fRetPesoEspecifico(FCodIte, FCodCor);

  If Result Then
    pFormataCampos;

  First;

  If FBaixaOrdem Then
  Begin
    pCarregaProdutosFormula_Composicao(FCodIte, FCodCor, FAutInc, FBaixaOrdem);

    pCalculaQuantidadesUsadas;

//    Self.BeforePost := pBeforePostBaixa;
  End;

  If blnUtilizaDistribuiLote Then
  Begin
    cdsLotesDefinidosPedido.Filtered := False;
    while not cdsLotesDefinidosPedido.isEmpty do
       cdsLotesDefinidosPedido.Delete;

    while not cdsLotesDefinidosPedidoSaldos.isEmpty do
       cdsLotesDefinidosPedidoSaldos.Delete;

  End;
  i := 0;
  If FBaixaOrdem And Assigned(objCorrOP) And (Not fExisteCorrecao(FAutInc)) Then
  Begin
    If objCorrOP.Active And (Not objCorrOP.IsEmpty) Then
      objCorrOP.EmptyDataSet;

    If blnUtilizaDistribuiLote Then
    Begin
      cdsLotesDefinidosPedido.BeforePost := nil;
      cdsLotesDefinidosPedido.AfterPost  := nil;
    End;

    if objCorrOP.blnMATBOP then
    begin

      cdsProFor.First;
      while not cdsProFor.Eof do
      begin
        If objCorrOP.Locate('DMT_ITESUB', cdsProFor.FieldByName('ITESUB').AsString, []) Then
        Begin
          objCorrOP.Edit;
          objCorrOP.FieldByName('QTD_OP').AsFloat := objCorrOP.FieldByName('QTD_OP').AsFloat +
                                                     RoundTo(cdsProFor.FieldByName('QTDTOT').AsFloat, -4);
          objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat := objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat+
                                                            RoundTo(cdsProFor.FieldByName('QTDTOT').AsFloat, -4);

        End
        Else
        Begin
          objCorrOP.Insert;
          objCorrOP.FieldByName('DMT_ITESUB').AsString := cdsProFor.FieldByName('ITESUB').AsString;
          if cdsProFor.FieldByName('TIPITE').AsString = 'NORMAL' then
          Begin
            inc(i);
            objCorrOP.FieldByName('DMT_SEQUEN').AsInteger := i;
          End
          Else
            objCorrOP.FieldByName('DMT_SEQUEN').AsInteger := cdsProFor.FieldByName('SEQUEN').AsInteger;
          objCorrOP.FieldByName('DMT_REFERE').AsString    := cdsProFor.FieldByName('DESITE').AsString;
          objCorrOP.FieldByName('REFERENCIA').AsString    := cdsProFor.FieldByName('REFERE').AsString;
          objCorrOP.FieldByName('QTD_OP').AsFloat         := RoundTo(cdsProFor.FieldByName('QTDTOT').AsFloat, -4);
          objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat  := objCorrOP.FieldByName('QTD_OP').AsFloat;
          If (fUsaRotinaWMS) Then
          Begin
            pRetornaNumeroLoteFatDor(fltQtdUtilizadaNoLote, strNumLote, fltQtdLoteAtual, FAutInc, cdsProFor.FieldByName('ITESUB').AsString);
            objCorrOP.FieldByName('NUMLOT').AsString             := strNumLote;
            objCorrOP.FieldByName('QTD_UTILIZADA_LOTE').AsFloat  := fltQtdUtilizadaNoLote;
            objCorrOP.FieldByName('SALDO_ATUAL_LOTE').AsFloat    := fltQtdLoteAtual;
          End;

        End;
        objCorrOP.FieldByName('DMT_QTDITE').AsFloat   := 0;
        objCorrOP.Post;
        cdsProFor.Next;
      end;
      If blnUtilizaDistribuiLote Then
      Begin
        cdsLotesDefinidosPedido.BeforePost := cdsLotesDefinidosPedidoBeforePost;
        cdsLotesDefinidosPedido.AfterPost := cdsLotesDefinidosPedidoAfterPost;
      End;

    end;
    Self.IndexFieldNames := 'DESITE';
  End;

  strAutIncGEIMAT := fRetAutoIncremGEIMAT(FCodIte, FCodCor, FieldByName('ORD_FORMUL').AsString);
  If fCfgSis('FASESP', varBoolean) And fEhFormulaEspecial(strAutIncGEIMAT) Then
  Begin
    If Assigned(objFasesOP) Then
      objFasesOP.fCarregaCadFasesOP(FAutInc, FInclusao, True, strAutIncGEIMAT);
  End
  Else
  Begin
    If Assigned(objFasesOP) Then
      objFasesOP.fCarregaCadFasesOP(FAutInc, FInclusao);
  End;

End;

Function TOrdProIndustrial.fEhFormulaEspecial(strAutIncGEIMAT: String):Boolean;
  Var
    qryGenerico : TUniQuery;
Begin
  qryGenerico := fCriaQuery(Self);
  Try

    qryGenerico.Close;
    qryGenerico.SQL.Clear;
    qryGenerico.SQL.Add(' SELECT                     ');
    qryGenerico.SQL.Add('   AUTOINCREM               ');
    qryGenerico.SQL.Add(' FROM                       ');
    qryGenerico.SQL.Add('   GEIFAS                   ');
    qryGenerico.SQL.Add(' WHERE GFA_SEQGER = :AUTINC ');

    qryGenerico.ParamByName('AUTINC').AsString := strAutIncGEIMAT;

    qryGenerico.Open;

    if qryGenerico.isEmpty then
      Result := False
    else
      Result := qryGenerico.RecordCount > 0;

    qryGenerico.Close;

  Finally
    FreeAndNil(qryGenerico);
  End;
End;


Function TOrdProIndustrial.fCarregaItens(strAutInc, strCodIte,
  strCodCor: String; blnImpressao: Boolean = False;
  blnBaixaOrdem: Boolean = False; blnInclusao: Boolean = False): Boolean;
Begin
  Try
    FAutInc     := strAutInc;
    FCodIte     := strCodIte;
    FCodCor     := strCodCor;
    FImpressao  := blnImpressao;
    FBaixaOrdem := blnBaixaOrdem;
    FInclusao   := blnInclusao;

    FStrCodIteFormula := strCodIte;
    FStrCodCorFormula := strCodCor;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fCarregaItensInterna;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    FreeAndNil(frmGravando);
  End;

End;

procedure TOrdProIndustrial.pDefineCdsLotesComponentes;
begin
  cdsLotesComponentes := TZClient.Create(Self);
  cdsLotesComponentes.qryQuery.SQL.Text := fGetSQLLotesMateriaPrima;
  cdsLotesComponentes.qryQuery.ParamByName('CODITE').AsString := '';
  cdsLotesComponentes.fAbreClient(True, 'TOrdProIndustrial.pDefineCdsLotesComponentes');
  Exit;
end;

procedure TOrdProIndustrial.pDeletaFilhas(strAutInc: String);
Var
  qrySelect: TUniQuery;
  qryDelete: TUniQuery;
Begin
  Try
    qryDelete := fCriaQuery(Self);
    qrySelect := fCriaQuery(Self);

    With qrySelect, SQL Do
    Begin

      Add(' SELECT ORD_SEQUSA           ');
      Add(' FROM ORDORI                 ');
      Add(' WHERE ORD_SEQGER = :SEQGER  ');

      ParamByName('SEQGER').AsString := strAutInc;

      Open;

    End;

    With qryDelete, SQL Do
    Begin
      Add(' DELETE FROM ORDGER          ');
      Add(' WHERE AUTOINCREM = :AUTOIN  ');

      While Not qrySelect.Eof Do
      Begin
        pApagaReservaOP(qrySelect.FieldByName('ORD_SEQUSA').AsString);

        ParamByName('AUTOIN').AsString :=
          qrySelect.FieldByName('ORD_SEQUSA').AsString;
        ExecSQL;

        qrySelect.Next;
      End;
    End;

  Finally
    FreeAndNil(qryDelete);
    FreeAndNil(qrySelect);
  End;

End;

procedure TOrdProIndustrial.pFormataCampos;
begin
  FieldByName('DESITE').ProviderFlags := [];
  FieldByName('SIGUNI').ProviderFlags := [];
  FieldByName('PESLIT').ProviderFlags := [];
  FieldByName('PESACA').ProviderFlags := [];

  pFormataDecimal('QTDPED', intDecQtd);
  pFormataDecimal('SALDOS', intDecQtd);
  pFormataDecimal('ESTUTI', intDecQtd);
  pFormataDecimal('ESTOQUE_FISICO', 3);
  pFormataDecimal('ESTOQUE_MINIMO', 3);
  pFormataDecimal('ESTOQUE_MAXIMO', 3);
  pFormataDecimal('ESTOQUE_DISPONIVEL', 3);

  pFormataDecimal('SUGEST', 3);

  pFormataDecimal('QTDBAI', 3);
  pFormataDecimal('ORD_QTDPRO', 3);
  pFormataDecimal('ORD_QTDENV', 3);
  pFormataDecimal('ORD_VOLACA', 3);
  pFormataDecimal('ORD_PESACA', 3);
  pFormataDecimal('VOLUME', 3);
  pFormataDecimal('PESO', 3);

  pFormataDecimal('VOLACA', 3);
  pFormataDecimal('PESACA', 3);

  pAlinhaCampoCentro('ORD_CODITE');
  pAlinhaCampoCentro('SIGUNI');
  pAlinhaCampoCentro('ORDITE');
end;

Function TOrdProIndustrial.fCalculaCodBarOP(qryTabela: TUniQuery): String;
Begin
  With qryTabela Do
    Result := fGeraCodBarraEAN13('100' + FormatDateTime('DDMMYY', FieldByName('ORD_DTACAD').AsDateTime) + FieldByName('ORD_CODORD').AsString);
End;

Function TOrdProIndustrial.fSalvaItens(qryTabela: TUniQuery;
  blnProcessaArray: Boolean = True; blnIgnoraCorrecao: Boolean = False): Boolean;

  procedure pGravaVinculo(qryTabelaV: TUniQuery);
  Var
    intCorre: Integer;
    intIndex: Integer;
    strChave: String;
  Begin
    strChave := qryTabelaV.FieldByName('ORD_CODITE').AsString + qryTabelaV.FieldByName('ORD_CODCOR').AsString;
    For intCorre := 0 To High(FarrSubOP) Do
    Begin
      With FarrSubOP[intCorre] Do
      Begin
        For intIndex := 0 To High(FarrPaiOrdem) Do
        Begin
          if FarrPaiOrdem[intIndex] = strChave Then
            fGravaOrdOri(qryTabelaV.FieldByName('AUTOINCREM').AsString,
              FarrQryTabela[intCorre].FieldByName('AUTOINCREM').AsString,
              FarrQuantidades[intIndex].fltQtdUsa,
              FarrQuantidades[intIndex].fltUsaEst,
              FarrQuantidades[intIndex].fltQtdSub);
        End;
      End;
    End;
  End;

Var
  intIndex: Integer;
  qryMatPri : TUniQuery;
  qryOrdLot : TUniQuery;
  strAutIncOrdDet,
  strAutIncOrdCom: String;
Begin
  Result := True;
  Try
    if blnProcessaArray And FGeraOpSubProdutos Then
    Begin
      For intIndex := High(FarrQryTabela) DownTo 0 Do
      Begin
        With FarrQryTabela[intIndex] Do
        Begin
          If Length(FieldByName('AUTOINCREM').AsString) = 20 Then //Já fez e setou o AUTOINCREM, valor original é o 'intIndex'
            Continue;

          Edit;
          FieldByName('ORD_CODORD').AsString := fRetSequencialOP;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ORDGER', VS_strCodEmp);

          If fEmptyStr(FieldByName('ORD_FORMUL').AsString) Then
          Begin
            FieldByName('ORD_FORMUL').AsInteger  := fRetFormulAtiva(FarrQryTabela[intIndex].FieldByName('ORD_CODITE').AsString,
                                                                    FarrQryTabela[intIndex].FieldByName('ORD_CODCOR').AsString);
          End;


          if blnUsaCapacidadeMaxima then
             FieldByName('ORD_CAPMAX').AsFloat := fRetCapacidadeMaximaFormula(FarrQryTabela[intIndex].FieldByName('ORD_CODITE').AsString,
                                                                              FarrQryTabela[intIndex].FieldByName('ORD_CODCOR').AsString);
          If fltPesoReal > 0 Then
             FieldByName('ORD_PESREA').AsFloat := fRetornaPesoRealFormula(FarrQryTabela[intIndex].FieldByName('ORD_CODITE').AsString,
                                                                          FarrQryTabela[intIndex].FieldByName('ORD_CODCOR').AsString);

          FieldByName('ORD_QTDPAR').AsInteger  := 1;

          FieldByName('ORD_CODOPE').AsString   := strLoginUsuarioLogado;


          Try
            If (FieldByName('ORD_FORMUL').AsInteger = 0) And ( RoundTo(FieldByName('ORD_PESREA').AsFloat, -4) = 0 ) Then
            Begin
              Raise Exception.Create('Peso real do Item Intermediário: '+FarrQryTabela[intIndex].FieldByName('ORD_CODITE').AsString+', '+
                                     'Cor '+FarrQryTabela[intIndex].FieldByName('ORD_CODCOR').AsString+' está zerado ou a Estrutura está inativa. '+
                                     'Verifique o Casdastro de Estruturas!');
              Result := False;
              Exit;
            End
            Else
              Post;

            FarrSubOP[intIndex].fSalvaOrdMat(FieldByName('AUTOINCREM').AsString);
          Except
            On E: Exception Do
            Begin
              Result := False;
              pMensagensErro(E.Message, 'TOrdProIndustrial.fSalvaItens');
            End;
          End;
        End;

        Try
          If Result Then
            Result := FarrSubOP[intIndex].fSalvaItens(FarrQryTabela[intIndex], False);
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, 'TOrdProIndustrial.fSalvaItens');
          End;
        End;

        If Not Result Then
          Break;

      End;

    End;

    TProdutoEstoque.pLimpaCds;

    If Not Result Then
      Exit;

    if fEmptyStr(qryTabela.FieldByName('ORD_CODORD').AsString) Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('ORD_CODORD').AsString := fRetSequencialOP;
      qryTabela.Post;
    End;

    if fEmptyStr(qryTabela.FieldByName('ORD_CODBAR').AsString) Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('ORD_CODBAR').AsString := fCalculaCodBarOP(qryTabela);
      qryTabela.Post;
    End;

    DisableControls;
    try

      First;

      strAutIncOrdDet := fRetAutoIncrem('ORDDET', VS_strCodEmp, RecordCount);
      While Not Eof Do
      Begin

        If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        Begin
          Edit;
          FieldByName('AUTOINCREM').AsString := strAutIncOrdDet;
          FieldByName('ORD_SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
          Post;

          strAutIncOrdDet := fNextAutoIncrem(strAutIncOrdDet);

          Result := ChangeCount > 0;

          cdsOrdCom.Filter   := 'ODC_SEQDET = ' + QuotedStr(Self.FieldByName('ORD_CODITE').AsString);
        End
        Else
          cdsOrdCom.Filter   := 'ODC_SEQDET = ' + QuotedStr(FieldByName('AUTOINCREM').AsString);

        cdsOrdCom.Filtered := True;
        cdsOrdCom.First;

        strAutIncOrdCom := fRetAutoIncrem('ORDCOM', VS_strCodEmp, cdsOrdCom.RecordCount);
        While not cdsOrdCom.Eof Do
        Begin
          If fEmptyStr(cdsOrdCom.FieldByName('AUTOINCREM').AsString) Then
          begin
            cdsOrdCom.Edit;


            cdsOrdCom.FieldByName('AUTOINCREM').AsString := strAutIncOrdCom;
            cdsOrdCom.FieldByName('ODC_SEQDET').AsString := FieldByName('AUTOINCREM').AsString;
            cdsOrdCom.Post;

            strAutIncOrdCom := fNextAutoIncrem(strAutIncOrdCom);
          end
          else
            cdsOrdCom.Next;
        End;

        cdsOrdCom.Filtered := False;
        cdsOrdCom.Filter   := '';

        Next;
      End;

      //Grava ORDEST (Estoque utilizado na ordem de produção, produtos intermediarios);
      If fAgrLot And Assigned(cdsAgrLot) And cdsAgrLot.Active Then
      Begin
        Try
          qryOrdLot := fCriaQuery;
          With qryOrdLot, SQL Do
          Begin
            Close;
            Clear;

            Add('INSERT INTO ORDEST(AUTOINCREM, ');
            Add('                   EST_SEQGER, ');
            Add('                   EST_CODEMP, ');
            Add('                   EST_CODITE, ');
            Add('                   EST_NUMLOT, ');
            Add('                   EST_ESTUTI) ');
            Add('VALUES            (:AUTINC,    ');
            Add('                   :SEQGER,    ');
            Add('                   :CODEMP,    ');
            Add('                   :CODITE,    ');
            Add('                   :NUMLOT,    ');
            Add('                   :ESTUTI)    ');

          End;

          cdsAgrLot.Filter   := 'ESTUTI > 0';
          cdsAgrLot.Filtered := True;
          cdsAgrLot.First;
          While not cdsAgrLot.Eof Do
          Begin
            qryOrdLot.ParamByName('AUTINC').AsString := fRetAutoIncrem('ORDEST', VS_strCodEmp);
            qryOrdLot.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
            qryOrdLot.ParamByName('CODEMP').AsString := VS_strCodEmp;
            qryOrdLot.ParamByName('CODITE').AsString := cdsAgrLot.FieldByName('LOT_CODITE').AsString;
            qryOrdLot.ParamByName('NUMLOT').AsString := cdsAgrLot.FieldByName('LOT_NUMLOT').AsString;
            qryOrdLot.ParamByName('ESTUTI').AsFloat  := cdsAgrLot.FieldByName('ESTUTI').AsFloat;
            qryOrdLot.ExecSQL;

            cdsAgrLot.Next;
          End;

        Finally
          cdsAgrLot.Filtered := False;
          cdsAgrLot.Filter   := '';
          FreeAndNil(qryOrdLot);
        End;

      End;

      //Se for Modelo 3. Grava tabela ORDLOT
      If (fCfgSis('MDORIN', varInteger) = 3) or (fCfgSis('MDORIN', varInteger) = 14) Or (fCfgSis('MDORIN', varInteger) = 37) Then
      Begin
        Try
          qryOrdLot := fCriaQuery;
          With qryOrdLot, SQL Do
          Begin
            Close;
            Clear;
            //Só insere a primeira vez, depois não insere mais
            //ai o usuario pode dar manutenção na tela de Ordem de Produção.
            Add(' INSERT IGNORE ORDLOT (      ');
            Add('               AUTOINCREM,   ');
            Add('               ODL_SEQGER,   ');
            Add('               ODL_CODITE,   ');
            Add('               ODL_NUMLOT    ');
            Add('               ) VALUES (    ');
            Add('                  :AUTOIN,   ');
            Add('                  :SEQGER,   ');
            Add('                  :CODITE,   ');
            Add('                  :NUMLOT )  ');
          End;

          qryMatPri := fCriaQuery;
          With qryMatPri, SQL Do
          Begin
            Close;
            Clear;
            Add(' SELECT ITE_CODITE, ITE_LOT_MP                         ');
            Add(' FROM GEIMAT                                           ');
            Add('   INNER JOIN DEIMAT ON DMT_SEQGER = GEIMAT.AUTOINCREM ');
            Add('   INNER JOIN CADITE ON ITE_CODITE = DMT_ITESUB        ');
            Add(' WHERE GMT_CODITE = :CODITE                            ');
            Add('   AND GMT_CODCOR = :CODCOR                            ');
            Add('   AND GMT_STATUS = "A"                                ');
            Add('   AND IFNULL(ITE_LOT_MP,"") <> ""                     ');

            ParamByName('CODITE').AsString := qryTabela.FieldByName('ORD_CODITE').AsString;
            ParamByName('CODCOR').AsString := qryTabela.FieldByName('ORD_CODCOR').AsString;

            Open;

            While Not Eof Do
            Begin
              qryOrdLot.ParamByName('AUTOIN').AsString := fRetAutoIncrem('ORDLOT', VS_strCodEmp);
              qryOrdLot.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
              qryOrdLot.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
              qryOrdLot.ParamByName('NUMLOT').AsString := FieldByName('ITE_LOT_MP').AsString;
              qryOrdLot.ExecSQL;

              Next;
            End;


          End;

        Finally
          FreeAndNil(qryMatPri);
          FreeAndNil(qryOrdLot);
        End;
      End;

      If (Self.RecordCount = 0) Then
      Begin
        Result := False;
        Raise Exception.Create('Não foi possível definir os produtos acabados, refaça a operação, caso volte a ocorrer essa mensagem, entre em contato com Citel !');
      End;

      Result := Result And fSalva;

      If fCfgSis('INCCOM', varBoolean) Then
      Begin
        pCarregaProdutosComposicao(False);
      End;

      If Result Then
        Result := cdsOrdCom.fSalva;

      If Result Then
        Result := fReservaEstoqueOP(qryTabela, False,blnIgnoraCorrecao);

      if Result And blnProcessaArray And FGeraOpSubProdutos And (Length(FarrQryTabela) > 0) Then
      Begin
        pGravaVinculo(qryTabela);

        For intIndex := High(FarrQryTabela) DownTo 0 Do
          pGravaVinculo(FarrQryTabela[intIndex]);

      End;

      If Result And Assigned(objFasesOP) Then
        Result := objFasesOP.fSalvaCadFasesOP(qryTabela.FieldByName('AUTOINCREM').AsString,
                                              qryTabela.FieldByName('ORD_CODITE').AsString,
                                              qryTabela.FieldByName('ORD_CODCOR').AsString,
                                              qryTabela.FieldByName('ORD_FORMUL').AsString,
                                              FAgrupamentoPedido);

    finally
      Filter := '';
      Filtered := False;
      EnableControls;
    end;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fSalvaItens]');
    End;
  End;

End;

Function TOrdProIndustrial.fSalvaItensBaixa(strAutInc: String): Boolean;
Begin
  Try
    try
      DisableControls;
      First;

      While Not Eof Do
      Begin

        If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        Begin

          If FieldByName('ORD_QTDENV').AsFloat > 0 Then
          Begin
            Edit;
            FieldByName('AUTOINCREM').AsString :=
              fRetAutoIncrem('ORDDET', VS_strCodEmp);
            FieldByName('ORD_SEQGER').AsString := strAutInc;
            Post;

            Next;
          End

          Else
            Delete;

        End

        Else
          Next;
      End;

      Result := fSalva;
    finally
      Filter := '';
      Filtered := False;
      EnableControls;
    end;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fSalvaItensBaixa]');
    End;
  End;
End;

Function TOrdProIndustrial.fRetSequencialOP: String;
Begin
  Result := RightStr(fRetSequencial('PROOPI', VS_strCodEmp), 3);

  If Not fTemOrdemProducaoHoje Then
  Begin
    Result := '1';
    fAtuCfgSis('PROOPI', IntToStr(StrToIntDef(Result, 0) + 1), VS_strCodEmp);
  End;

  Result := fStrZero(Result, 3);
End;

Function TOrdProIndustrial.fTemOrdemProducaoHoje: Boolean;
Var
  qryOrdPro: TUniQuery;
Begin
  qryOrdPro := fCriaQuery(Self);
  With qryOrdPro, SQL Do
  Begin
    Clear;
    Add('SELECT COUNT(*) AS QTDORD FROM ORDGER');
    Add('WHERE');
    Add('  ORD_DTACAD = :DTACAD AND');
    Add('  ORD_CODEMP = :CODEMP AND');
    Add('  IFNULL(ORD_CODORD,"") <> "" ');

    ParamByName('DTACAD').AsDate := VS_Date;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    Result := FieldByName('QTDORD').AsInteger > 0;

    Close;
  End;
  FreeAndNil(qryOrdPro);

End;

procedure TOrdProIndustrial.pRestoreOPI;
begin
  Self.Data := oleBackupCdsOPI;
  pFormataCampos;
end;

Function TOrdProIndustrial.pRetQtdJaReservado(strAutInc,
  strCodIte: String): Double;
Var
  qryFatGor: TUniQuery;
Begin
  qryFatGor := fCriaQuery(Self);

  With qryFatGor, SQL Do
  Begin
    Add(' SELECT SUM(IFNULL(FDO_QTDITE,0))  AS QTDITE ');
    Add(' FROM FATDOR       ');
    Add(' INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
    Add(' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ');
    Add(' WHERE FGO_ORDIND = :AUTOIN ');
    Add('   AND FDO_CODITE = :CODITE ');

    ParamByName('AUTOIN').AsString := strAutInc;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := FieldByName('QTDITE').AsFloat;

  End;

  FreeAndNil(qryFatGor);
End;

Procedure TOrdProIndustrial.pApagaReservaOP(strAutInc: String);
Var
  qryFatGor         : TUniQuery;
  blnTransacaoLocal : Boolean;
  strNumDoc, strEspDoc, strCodEmp : String;
  objReprocessaSaldoItem : IReprocessarSaldoItem;

  procedure pRetChaveDoc(Out strNumDoc, strEspDoc, strCodEmp : String);
  var
    LQryGet : TUniQuery;
  begin

    strNumDoc := '';
    strEspDoc := '';
    strCodEmp := '';

    LQryGet := fCriaQuery(Self);

    Try

      LQryGet.Close;
      LQryGet.SQL.Clear;

      LQryGet.SQL.Add('SELECT A.FGO_NUMDOC,');
      LQryGet.SQL.Add('       A.FGO_ESPDOC,');
      LQryGet.SQL.Add('       A.FGO_CODEMP');
      LQryGet.SQL.Add('  FROM FATGOR A');
      LQryGet.SQL.Add('  LEFT JOIN EXTGOR B ON A.AUTOINCREM = B.FGO_SEQFGO');
      LQryGet.SQL.Add(' WHERE TRUE');
      LQryGet.SQL.Add('   AND A.FGO_CODEMP = :CODEMP');
      LQryGet.SQL.Add('   AND B.FGO_ORDIND = :ORDIND');

      LQryGet.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryGet.ParamByName('ORDIND').AsString := strAutInc;
      LQryGet.Open;

      If Not LQryGet.IsEmpty Then
      Begin
        strNumDoc := LQryGet.FieldByName('FGO_NUMDOC').AsString;
        strEspDoc := LQryGet.FieldByName('FGO_ESPDOC').AsString;
        strCodEmp := LQryGet.FieldByName('FGO_CODEMP').AsString;
      End;

    Finally
      FreeAndNil(LQryGet);
    End;

  end;

Begin

  qryFatGor := fCriaQuery(Self);
  blnTransacaoLocal := False;

  If Not fInTransaction() Then
  Begin
    fStartTransaction();
    blnTransacaoLocal := True;
  End;


  Try

    Try

      qryFatGor.Close;
      qryFatGor.SQL.Clear;
      //O comando abaixo nao gera LOGREP
      //qryFatGor.SQL.Add('DELETE FATGOR FROM FATGOR JOIN EXTGOR E ON E.FGO_SEQFGO = FATGOR.AUTOINCREM WHERE FGO_CODEMP = :CODEMP AND FGO_ORDIND = :ORDIND');
      qryFatGor.SQL.Add('DELETE FROM FATGOR WHERE AUTOINCREM IN (SELECT FGO_SEQFGO FROM EXTGOR WHERE FGO_ORDIND = :ORDIND) AND FGO_CODEMP = :CODEMP ');
      qryFatGor.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryFatGor.ParamByName('ORDIND').AsString := strAutInc;

      pRetChaveDoc(strNumDoc, strEspDoc, strCodEmp);

      If Not fEmptyStr(strNumDoc) And
         Not fEmptyStr(strEspDoc) And
         Not fEmptyStr(strCodEmp) Then
      Begin
        {Reprocessar Saldos}
        objReprocessaSaldoItem := TReprocessarSaldoItem.New
                                    .AddItensDoDocumento(
                                      TItensReprocessarDoDocumento.New
                                        .Documento(strNumDoc)
                                        .Especie(strEspDoc)
                                        .Empresa(strCodEmp)


                                      ).NotificarRoboParaReprocessarSaldos;
      End;

      qryFatGor.ExecSQL;

      if Assigned(objReprocessaSaldoItem) then
        objReprocessaSaldoItem.ReprocessarSaldoPedidos(FPrgBar);

      If blnTransacaoLocal Then
        fCommit();

    Except

      If blnTransacaoLocal Then
        fRollBack();

      Raise;

    End;

  Finally
    FreeAndNil(qryFatGor);
  End;

End;

class function TOrdProIndustrial.fLiberaOrdemTodasAnalisesReprovadas(AStrSeqOpi: String): Boolean;
var
  qryOrdPro   : TUniQuery;
  objLiberacao : TLiberacao;
begin
  qryOrdPro := Nil;
  objLiberacao := Nil;
  try
    qryOrdPro := fCriaQuery;
    objLiberacao := TLiberacao.Create;
    qryOrdPro.SQL.Clear;
    qryOrdPro.SQL.Add('SELECT SQL_NO_CACHE                             ');
    qryOrdPro.SQL.Add('  ORD_CODORD AS CODORD,                         ');
    qryOrdPro.SQL.Add('  ORD_DTACAD AS DTACAD,                         ');
    qryOrdPro.SQL.Add('  ORD_CODITE AS CODITE,                         ');
    qryOrdPro.SQL.Add('  ITE_DESITE AS DESITE                          ');
    qryOrdPro.SQL.Add('FROM                                            ');
    qryOrdPro.SQL.Add('  ORDGER                                        ');
    qryOrdPro.SQL.Add('  INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE  ');
    qryOrdPro.SQL.Add('WHERE                                           ');
    qryOrdPro.SQL.Add('  ORDGER.AUTOINCREM = :AUTINC                   ');
    qryOrdPro.ParamByName('AUTINC').AsString := AStrSeqOpi;
    qryOrdPro.Open;
    If qryOrdPro.IsEmpty Then
      Exit(False);

    objLiberacao.clear;

    //Título
    objLiberacao.objMsgLibera.pAddTexto('Baixa de Ordem de Produção com todas análises de amostra reprovadas');

    objLiberacao.objMsgLibera.pAddSeparador(120);

    //Ordem de Produção
    objLiberacao.objMsgLibera.pAddTextoCaption('N.Ordem de Produção', qryOrdPro.FieldByName('CODORD').AsString + '-' + DateToStr(qryOrdPro.FieldByName('DTACAD').AsDateTime), 20);
    objLiberacao.objMsgLibera.pAddTextoCaption('Produto Granel'     , qryOrdPro.FieldByName('CODITE').AsString + '-' + qryOrdPro.FieldByName('DESITE').AsString             , 20);

    objLiberacao.strDirAce := 'PERBAR';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;

    Result := objLiberacao.fLibera;

  finally
    FreeAndNil(qryOrdPro);
    FreeAndNil(objLiberacao);
  end;
end;

Function TOrdProIndustrial.fLiberaVinculoPedidosAgrupados(strAutInc: String):Boolean;
  Var
    qryUpdate: TUniQuery;
Begin
  Result := True;
  Try
    qryUpdate := fCriaQuery;
    Try
      With qryUpdate, SQL Do
      Begin
        Add(' UPDATE EXTDOR              ');
        Add(' SET FDO_SEQOPI = NULL,     ');
        Add('     FDO_BAIOPI = "N"       ');
        Add(' WHERE FDO_SEQOPI = :SEQOPI ');

        ParamByName('SEQOPI').AsString := strAutInc;

        ExecSQL;

      End;

    Finally
      FreeAndNil(qryUpdate);
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TOrdProIndustrial.fLiberaVinculoPedidosAgrupados');
    End;
  End;

End;

function TOrdProIndustrial.fBaixaPDReservaOP(strAutInc: String; strJaFatu : String):Boolean;
  Var
    qryFatGor: TUniQuery;
    qryUpdate: TUniQuery;
    qryDelete: TUniQuery;
    objAtuCrm: TAtuOcoCrm;
Begin
  Result := True;
  Try
    Try
      qryFatGor := fCriaQuery(Self);

      With qryFatGor, SQL Do
      Begin
        Clear;
        Add('SELECT FGO_NUMDOC,                                  ');
        Add('       FGO_ESPDOC,                                  ');
        Add('       FGO_CODEMP,                                  ');
        Add('       FGO_CODCLI                                   ');
        Add('FROM FATGOR                                         ');
        Add('WHERE FGO_CODEMP = :CODEMP AND                      ');
        Add('  (SELECT FGO_ORDIND FROM EXTGOR E                  ');
        Add('   WHERE E.FGO_SEQFGO = FATGOR.AUTOINCREM) = :ORDIND');

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('ORDIND').AsString := strAutInc;

        Open;

        qryUpdate := fCriaQuery(Nil);
        qryUpdate.SQL.Add('UPDATE                     ');
        qryUpdate.SQL.Add('  FATGOR                   ');
        qryUpdate.SQL.Add('SET                        ');
        qryUpdate.SQL.Add('  FGO_JAFATU = ' + strJaFatu + ', ');
        qryUpdate.SQL.Add('  FGO_MOTBAI = :MOTBAI     ');
        qryUpdate.SQL.Add('WHERE                      ');
        qryUpdate.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
        qryUpdate.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
        qryUpdate.SQL.Add('  FGO_CODEMP = :CODEMP     ');
        qryUpdate.ParamByName('MOTBAI').AsString := 'BAIXA DE ORDEM DE PRODUÇÃO';
        qryUpdate.ParamByName('NUMDOC').AsString := FieldByName('FGO_NUMDOC').AsString;
        qryUpdate.ParamByName('ESPDOC').AsString := FieldByName('FGO_ESPDOC').AsString;
        qryUpdate.ParamByName('CODEMP').AsString := FieldByName('FGO_CODEMP').AsString;
        qryUpdate.ExecSQL;

        qryUpdate.SQL.Clear;
        qryUpdate.SQL.Add('UPDATE                     ');
        qryUpdate.SQL.Add('  FATDOR                   ');
        qryUpdate.SQL.Add('SET                        ');
        qryUpdate.SQL.Add('  FDO_JAFATU = ' + strJaFatu + ' ');
        qryUpdate.SQL.Add('WHERE                      ');
        qryUpdate.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
        qryUpdate.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
        qryUpdate.SQL.Add('  FDO_CODEMP = :CODEMP     ');
        qryUpdate.ParamByName('NUMDOC').AsString := FieldByName('FGO_NUMDOC').AsString;
        qryUpdate.ParamByName('ESPDOC').AsString := FieldByName('FGO_ESPDOC').AsString;
        qryUpdate.ParamByName('CODEMP').AsString := FieldByName('FGO_CODEMP').AsString;
        qryUpdate.ExecSQL;

        If Not fEmptyStr(FieldByName('FGO_NUMDOC').AsString) And
         Not fEmptyStr(FieldByName('FGO_ESPDOC').AsString) And
         Not fEmptyStr(FieldByName('FGO_CODEMP').AsString) Then
        Begin
          {Reprocessar Saldos}
          TReprocessarSaldoItem.New
           .AddItensDoDocumento(
             TItensReprocessarDoDocumento.New
               .Documento(FieldByName('FGO_NUMDOC').AsString)
               .Especie(FieldByName('FGO_ESPDOC').AsString)
               .Empresa(FieldByName('FGO_CODEMP').AsString)
             ).NotificarRoboParaReprocessarSaldos();
        End;

        If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
        Begin
          If strJaFatu = '0' Then
          Begin
            qryDelete := fCriaQuery(Nil);
            qryDelete.SQL.Add(' DELETE FROM FATGOR ');
            qryDelete.SQL.Add('  WHERE FGO_CODEMP = :CODEMP AND ');
            qryDelete.SQL.Add('  (SELECT FGO_ORDIND FROM EXTGOR E ');
            qryDelete.SQL.Add('    WHERE E.FGO_SEQFGO = FATGOR.AUTOINCREM) = :AUTINC AND ');
            qryDelete.SQL.Add('      FGO_MEN001 LIKE "%PEDIDO DE ENDERECAMENTO DE PRODUTO ACABADO%" ');
            qryDelete.ParamByName('AUTINC').AsString:= strAutInc;
            qryDelete.ParamByName('CODEMP').AsString:= VS_strCodEmp;
            qryDelete.ExecSQL;
          End;
        End;
        If fCfgSis('CORROP', varString) = 'N' Then
          TOrdProIndCorrecoes.fAtualizaReservaCorrecao(strAutInc, strJaFatu);

        If (VS_strHabilitarCRM) Then
        Begin
          objAtuCrm := TAtuOcoCrm.Create(Nil);
          Try
            objAtuCrm.pCarregaOcorrenciaCliente(FieldByName('FGO_CODEMP').AsString,
                                                FieldByName('FGO_ESPDOC').AsString,
                                                FieldByName('FGO_NUMDOC').AsString,
                                                FieldByName('FGO_CODCLI').AsString);
            objAtuCrm.pFinalizaOcorrencia('Baixa realizada pela confirmação de ordem de produção.');
          Finally
            FreeAndNil(objAtuCrm);
          End;
        End;

      End;
    Finally
      FreeAndNil(qryFatGor);
      FreeAndNil(qryUpdate);
      FreeAndNil(qryDelete);
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, 'TOrdProIndustrial.fBaixaPDReservaOP');
    End;

  End;
End;


Function TOrdProIndustrial.fReservaEstoqueOP(qryTabela: TUniQuery; blnBaixaOp: Boolean = False; blnIgnoraCorrecao: Boolean = False): Boolean;
Var
  strSeqFgo, strAutFdo, strNumDoc, strCodCli, strMens01, strMens02, strAutIncODMFDO, strAutFdoEnd: String;
  intIdxIte: Integer;
  intIndex : Integer;
  qryCadIte: TUniQuery;
  objOcoCrm: TAtuOcoCrm;
  recServicos: TDadosServicos;
  arrDuplic : TarrDuplicata;

  Procedure pAbreCadIte(strCodIte: String);
  Begin
    With qryCadIte, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT');
      Add('  ITE_DESITE,');
      Add('  ITE_CODMAR,');
      Add('  ITE_REFERE,');
      Add('  ITE_CODUNI,');
      Add('  ITE_CODFOR,');
      Add('  ITE_REAEND ');
      Add('FROM');
      Add('  CADITE');
      Add('WHERE');
      Add('  ITE_CODITE = :CODITE');

      ParamByName('CODITE').AsString := strCodIte;
      Open;
    End;
  End;

  function fMarcaDocumentoEnderecamento: Boolean;
  begin
    Result := fExecutaSQL(' UPDATE EXTGOR SET FGO_ORDIND = ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString) +
                          ' WHERE FGO_SEQFGO = ' + QuotedStr(strSeqFgo));
  end;

  procedure pGravaODMFDO(strAutInc, strSeqOrd, strSeqFdo : String; intSequen : integer; strIteAca: String);
    var
      qryODMFDO : TUniQuery;
  begin
    qryODMFDO := fCriaQuery;
    try
      qryODMFDO.SQL.Add('INSERT INTO ODMFDO (AUTOINCREM, ODF_SEQFDO, ODF_SEQUEN, ODF_SEQORD, ODF_ITEACA) VALUES (:AUTINC, :SEQFDO, :SEQUEN, :SEQORD, :ITEACA)');
      If fEmptyStr(strAutInc) Then
        strAutInc := fRetAutoIncrem('ODMFDO', VS_strCodEmp);
      qryODMFDO.ParamByName('AUTINC').AsString  := strAutInc;
      qryODMFDO.ParamByName('SEQFDO').AsString  := strSeqFdo;
      qryODMFDO.ParamByName('SEQUEN').AsInteger := intSequen;
      qryODMFDO.ParamByName('SEQORD').AsString  := strSeqOrd;
      qryODMFDO.ParamByName('ITEACA').AsString  := strIteAca;
      qryODMFDO.ExecSQL;
    finally
      FreeAndNil(qryODMFDO);
    end;

  end;

  function fGravaItemEnderecamento(AStrAutInc: String; AstrNumLot: String; AfltQtdIte: Double): Boolean;
  Begin
    fGravaItemEnderecamento := fGravaFatDor(AStrAutInc,
                                            strSeqFgo,                                    // strSeqGer
                                            VS_strCodEmp,                                 // strCodEmp
                                            strCodCli,                                    // strCodCli
                                            strLoginUsuarioLogado,                        // strCodVen
                                            Self.FieldByName('ORD_CODITE').AsString,      // strCodIte
                                            qryCadIte.FieldByName('ITE_CODMAR').AsString, // strCodMar
                                            '',                                           // strCodDiv
                                            strNumDoc,                                    // strNumDoc
                                            'PD',                                         // strEspDoc
                                            '',                                           // strSerie:
                                            VS_Date, fTime(),                             // dtaHorEnt
                                            '01000',                                      // strConPag
                                            '',                                           //strEstado
                                            qryCadIte.FieldByName('ITE_DESITE').AsString, // strDescri
                                            qryCadIte.FieldByName('ITE_REFERE').AsString, // strRefere
                                            qryCadIte.FieldByName('ITE_CODUNI').AsString, // strUnidad
                                            qryCadIte.FieldByName('ITE_CODFOR').AsString, // strForIte
                                            AfltQtdIte,
                                            0.0,                                          // fltUnitar
                                            0.0,                                          // fltUniOri
                                            0.0,                                          // fltUniVis
                                            0.0,                                          // fltTotIte
                                            0.0,                                          // fltVlrCon
                                            0.0,                                          // fltTotCus
                                            0.0,                                          // fltTotMed
                                            0.0,                                          // fltDesCon
                                            0.0,                                          // fltTotFre
                                            0.0,                                          // fltDesEsp
                                            0.0,                                          // fltDesAce
                                            '',                                           // strCodRep
                                            '',                                           // strCodVe2
                                            0.0,                                          // fltPerCom
                                            0.0,                                          // fltTotCom
                                            0.0,                                          // fltTotCo2
                                            '',                                           // strClaFis
                                            '',                                           // strCodFis
                                            0.0,                                          // fltValIpi
                                            0.0,                                          // fltAlqIpi
                                            0.0,                                          // fltBasIpi
                                            0.0,                                          // fltValIcm
                                            0.0,                                          // fltAlqIcm
                                            0.0,                                          // fltBasIcm
                                            0.0,                                          // fltValRet
                                            0.0,                                          // fltAlqRet
                                            0.0,                                          // fltBasRet
                                            0.0,                                          // fltTotPes
                                            0.0,                                          // fltPerBas
                                            0.0,                                          // fltPerRed
                                            False,                                        // blnJaFatu
                                            '',                                           // strTipFat
                                           //'',
                                            '',                                           // strNumFat
                                            '',                                           // strEmpFat
                                            0,                                            // dtaDtaFat
                                            '',                                           // strVenFat
                                            '',                                           // strCndFat
                                            0.0,                                          // fltValFat
                                            'NOR',                                        // strIdePro
                                            'N',                                          // strIncPis
                                            strLoginUsuarioLogado,                        // strCodDig
                                            '',                                           // strConPag
                                            '',                                           // strProEmb
                                            '',                                           // strCodFpg
                                            '',                                           // strIteCha
                                            '',                                           // strIteTin
                                            '',                                           // strDesCor
                                            '',                                           // strTipEmb
                                            0.0,                                          // fltQtdEmb
                                            0.0,                                          // fltPreEmb
                                            '',                                           // strTipPre
                                            0.0,                                          // fltPrvTin
                                            0.0,                                          // fltPrcTin
                                            0.0,                                          // fltFatTin
                                            '',                                           // strIteEmb
                                            '',                                           // strGruEmb
                                            0,                                            // intLazQua
                                            'N',                                          // strPromoc
                                            '',                                           // strSeqTin
                                            0.0,                                          // fltQtdPul
                                            intIdxIte,                                    // intSeqInd
                                            0.0,                                          // fltQtdBai
                                            0.0,                                          // fltUniDig
                                            '',                                           // strComple
                                            0.0,                                          // fltVolPro
                                            '',                                           // strCodAca
                                            '',                                           // strEmpAca
                                            False,                                        // blnProAca
                                            '',                                           // strTabPre
                                            '',                                           // strLinha:
                                            '',                                           // strCatali
                                            '',                                           // strCodDil
                                            0.0,                                          // fltPorDil
                                            '',                                           // strDilCon
                                            0.0,                                          // fltPorCat: Double;
                                            '',                                           // strEntRet,
                                            '',                                           // strLocRet,
                                            '',                                           // strEntFut,
                                            '',                                           // strMotFut: String;
                                            0,                                            // dtaDtEntr: TDateTime;
                                            0,                                            // fltTotCu2: Double;
                                            0,                                            // fltComRep,
                                            0,                                            // fltPerRep: Double;
                                            '',                                           // strKey_EP,
                                            AstrNumLot,         // strNumLot: String;
                                            '',                                           // strEmpPrd: String;
                                            False,                                        // blnBxSbIt: Boolean;
                                            '',                                           // strEmpIte: String;
                                            '',                                           // strDocDev,
                                            '',                                           // strEspDev,
                                            '',                                           // strEmpDev: String;
                                            '',                                           // strEmpFor: String;
                                            '',                                           // strOrdPro: String;
                                            0,                                            // fltFreSug: Double;
                                            0,                                            // fltQtdExp: Double;
                                            '',                                           // strBarEmb: String;
                                            '',                                           // strNumCmp: String;
                                            0,                                            // intNItCmp: Integer;
                                            '',                                           // strCodMec: String;
                                            '',                                           // strSeqRcd: String;
                                            0,                                            // intSeqInc: Integer;
                                            0,                                            // IntOrdIte
                                            0);                                           // fltPesLiq: Double;
  End;



begin

  Try
    If (Not(blnBaixaOp)) Then
    Begin
      pSetaTituloPrg('reservando estoque');

      pApagaReservaOP(qryTabela.FieldByName('AUTOINCREM').AsString);



      With qryTabela Do
        strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE OP-' +
                     qryTabela.FieldByName('ORD_CODORD').AsString + ' ' +
                     FormatDateTime('DD/MM/YYYY', qryTabela.FieldByName('ORD_DTACAD').AsDateTime);

    End
    Else
    Begin
      If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
      Begin
          strMens01 := 'PEDIDO DE ENDERECAMENTO DE PRODUTO ACABADO OP-' +
                       qryTabela.FieldByName('ORD_CODORD').AsString + ' ' +
                       FormatDateTime('DD/MM/YYYY', qryTabela.FieldByName('ORD_DTACAD').AsDateTime);
      End;
    End;

    strCodCli := fCadEmp('CLIFIL');

    qryCadIte := fCriaQuery(Self);

    If fEmptyStr(strCodCli) Then
    Begin
      Result := (fMensagem('ATENÇÃO', 'Informe o código do cliente filial no cadastro de empresas para continuar!', ['&OK']) = -1);
      Exit;
    End;

    strNumDoc := fRetSequencialPedido;
    If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      objOcoCrm := fAtualizaInformacoesCRM(strNumDoc, 'PD', VS_strCodEmp, strCodCli, '', '', strLoginUsuarioLogado, afcPedido)
    Else
      objOcoCrm := Nil;

    If Assigned(objOcoCrm) Then
      objOcoCrm.strNomFrm := Self.Name;

    FillChar(recServicos, SizeOf(TDadosServicos), #0);
    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    If (Not FBaixaOrdem) And (fEhMateriaPrimaEProdutoAGranel(Self.FieldByName('ORD_CODITE').AsString)) Then
      pCalculaQuantidadesUsadas;  
    Result := fGravaFatGor(strSeqFgo,             // strIncrem
                           VS_strCodEmp,          // strCodEmp
                           strNumDoc,             // strNumDoc
                           'PD',                  // strEspDoc
                           strCodCli,             // strCodCli
                           strLoginUsuarioLogado, // strCodVen
                           '',                    // strCodTra
                           '',                    // strSerie:
                           VS_Date,               // dtaDtaEnt
                           fTime(),               // dtaHorEnt
                           '01000',               // strConPag
                           '',                    // strEstado
                           '',                    // strNomCom
                           '',                    // strEndCon
                           '',                    // strBaiCon
                           '',                    // strCepCon
                           '',                    // strCidCon
                           '',                    // strEstCon
                           '',                    // strCodAti
                           '',                    // strTelCon
                           0,                     //  dtaNasCon
                           '',                    // strCgcCpf
                           '',                    // strCgcCon
                           '',                    // strIesCon
                           '',                    // strCli_Rg
                           0.0,                   // fltBasSim
                           0.0,                   // fltBasIpi
                           0.0,                   // fltAlqIpi
                           0.0,                   // fltTotIpi
                           0.0,                   // fltBasIcm
                           0.0,                   // fltAlqIcm
                           0.0,                   // fltTotIcm
                           0.0,                   // fltTotRet
                           0.0,                   // fltAlqRet
                           0.0,                   // fltBasRet
                           0.0,                   // fltDesEsp
                           0.0,                   // fltVlrCon
                           0.0,                   // fltTotPro
                           0.0,                   // fltTotCus
                           0.0,                   // fltTotMed
                           '',                    // strTipFre
                           0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                           0.0,                   // fltTotFre
                           0.0,                   // fltTotFre
                           0.0,                   // fltPesBru
                           0.0,                   // fltPesLiq
                           0,                     // fltVolume
                           arrDuplic,             // arrDuplic
                           '',                    // strEspeci
                           '',                    // strMarca,
                           strMens01,             // strMen001
                           strMens02,             // strMen002
                           False,                 // blnJaFatu
                           '',                    // strTipFat
                          // '',
                           '',                    // strNumFat
                           '',                    // strEmpFat
                           0,                     // dtaDtaFat
                           '',                    // strVenFat
                           '',                    // strCndFat
                           0.0,                   // fltValFat
                           0.0,                   // fltPorDes
                           strLoginUsuarioLogado, // strCodDig
                           '',                    // strCodCnd
                           '',                    // strCodFpg
                           recServicos, '',       // strConEnt
                           VS_Date,               // dtaPreVis
                           0.0,                   // fltVPgAnt
                           VS_Date,               // dtaUltAlt
                           '',                    // strNTrava
                           'A',                   // strTipPed
                           '',                    // strCliCtt
                           0,                     // intLibera
                           'S',                   // strEntFat
                           0.0,                   // fltDesCon
                           '1',                   // strTabPre
                           '',                    // strEntFut
                           0.0,                   // fltMargem
                           '',                    // strNumPok
                           '',                    // strEmp_CD
                           False,                 // blnEnt_CD
                           'N',                   // strOprFlj
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '', '', False,         // blnPedLib
                           0.0,
                           'N',
                           '',
                           0,
                           'P',                   // strTipFin
                           0,                     // fltDesFin
                           '',                    // strAutEnt
                           '',
                           '',
                           False,
                           '',
                           Nil,
                           '',
                           '',
                           0,
                           0,
                           0,
                           '',
                           objOcoCrm,
                           '',
                           0,
                           0,
                           '',
                           '',
                           0,
                           '',
                           0,
                           '',
                           '',
                           '',
                           'N');

    Result := Result And fMarcaDocumentoEnderecamento;

    If Result Then
    Begin
      If not(blnBaixaOP) Then
      Begin
        if not fSelecionaLotesReserva(blnIgnoraCorrecao) then
          exit(False);

        pInicializaPrg(Length(arrLotes)-1);

        intIdxIte := 0;

        strAutFdo := fRetAutoIncrem('FATDOR', VS_strCodEmp, Length(arrLotes));
        strAutIncODMFDO := fRetAutoIncrem('ODMFDO', VS_strCodEmp, Length(arrLotes));
        For intIndex := 0 To Length(arrLotes)-1 Do
        Begin

          pAbreCadIte(arrLotes[intIndex].strCodIte);
          inc(intIdxIte);
          Result := Result And fGravaFatDor(strAutFdo,
                                            strSeqFgo,                                    // strSeqGer
                                            VS_strCodEmp,                                 // strCodEmp
                                            strCodCli,                                    // strCodCli
                                            strLoginUsuarioLogado,                        // strCodVen
                                            arrLotes[intIndex].strCodIte,                 // strCodIte
                                            qryCadIte.FieldByName('ITE_CODMAR').AsString, // strCodMar
                                            '',                                           // strCodDiv
                                            strNumDoc,                                    // strNumDoc
                                            'PD',                                         // strEspDoc
                                            '',                                           // strSerie:
                                            VS_Date, fTime(),                             // dtaHorEnt
                                            '01000',                                      // strConPag
                                            '',                                           //strEstado
                                            qryCadIte.FieldByName('ITE_DESITE').AsString, // strDescri
                                            qryCadIte.FieldByName('ITE_REFERE').AsString, // strRefere
                                            qryCadIte.FieldByName('ITE_CODUNI').AsString, // strUnidad
                                            qryCadIte.FieldByName('ITE_CODFOR').AsString, // strForIte
                                            arrLotes[intIndex].fltQtdIte,                 // fltQtdIte
                                            0.0,                                          // fltUnitar
                                            0.0,                                          // fltUniOri
                                            0.0,                                          // fltUniVis
                                            0.0,                                          // fltTotIte
                                            0.0,                                          // fltVlrCon
                                            0.0,                                          // fltTotCus
                                            0.0,                                          // fltTotMed
                                            0.0,                                          // fltDesCon
                                            0.0,                                          // fltTotFre
                                            0.0,                                          // fltDesEsp
                                            0.0,                                          // fltDesAce
                                            '',                                           // strCodRep
                                            '',                                           // strCodVe2
                                            0.0,                                          // fltPerCom
                                            0.0,                                          // fltTotCom
                                            0.0,                                          // fltTotCo2
                                            '',                                           // strClaFis
                                            '',                                           // strCodFis
                                            0.0,                                          // fltValIpi
                                            0.0,                                          // fltAlqIpi
                                            0.0,                                          // fltBasIpi
                                            0.0,                                          // fltValIcm
                                            0.0,                                          // fltAlqIcm
                                            0.0,                                          // fltBasIcm
                                            0.0,                                          // fltValRet
                                            0.0,                                          // fltAlqRet
                                            0.0,                                          // fltBasRet
                                            0.0,                                          // fltTotPes
                                            0.0,                                          // fltPerBas
                                            0.0,                                          // fltPerRed
                                            False,                                        // blnJaFatu
                                            '',                                           // strTipFat
                                           //'',
                                            '',                                           // strNumFat
                                            '',                                           // strEmpFat
                                            0,                                            // dtaDtaFat
                                            '',                                           // strVenFat
                                            '',                                           // strCndFat
                                            0.0,                                          // fltValFat
                                            'NOR',                                        // strIdePro
                                            'N',                                          // strIncPis
                                            strLoginUsuarioLogado,                        // strCodDig
                                            '',                                           // strConPag
                                            '',                                           // strProEmb
                                            '',                                           // strCodFpg
                                            '',                                           // strIteCha
                                            '',                                           // strIteTin
                                            '',                                           // strDesCor
                                            '',                                           // strTipEmb
                                            0.0,                                          // fltQtdEmb
                                            0.0,                                          // fltPreEmb
                                            '',                                           // strTipPre
                                            0.0,                                          // fltPrvTin
                                            0.0,                                          // fltPrcTin
                                            0.0,                                          // fltFatTin
                                            '',                                           // strIteEmb
                                            '',                                           // strGruEmb
                                            0,                                            // intLazQua
                                            'N',                                          // strPromoc
                                            '',                                           // strSeqTin
                                            0.0,                                          // fltQtdPul
                                            intIdxIte,                                    // intSeqInd
                                            0.0,                                          // fltQtdBai
                                            0.0,                                          // fltUniDig
                                            '',                                           // strComple
                                            0.0,                                          // fltVolPro
                                            '',                                           // strCodAca
                                            '',                                           // strEmpAca
                                            False,                                        // blnProAca
                                            '',                                           // strTabPre
                                            '',                                           // strLinha:
                                            '',                                           // strCatali
                                            '',                                           // strCodDil
                                            0.0,                                          // fltPorDil
                                            '',                                           // strDilCon
                                            0.0,                                          // fltPorCat: Double;
                                            '',                                           // strEntRet,
                                            '',                                           // strLocRet,
                                            '',                                           // strEntFut,
                                            '',                                           // strMotFut: String;
                                            0,                                            // dtaDtEntr: TDateTime;
                                            0,                                            // fltTotCu2: Double;
                                            0,                                            // fltComRep,
                                            0,                                            // fltPerRep: Double;
                                            '',                                           // strKey_EP,
                                            arrLotes[intIndex].strNumLot,                 // strNumLot: String;
                                            '',                                           // strEmpPrd: String;
                                            False,                                        // blnBxSbIt: Boolean;
                                            '',                                           // strEmpIte: String;
                                            '',                                           // strDocDev,
                                            '',                                           // strEspDev,
                                            '',                                           // strEmpDev: String;
                                            '',                                           // strEmpFor: String;
                                            '',                                           // strOrdPro: String;
                                            0,                                            // fltFreSug: Double;
                                            0,                                            // fltQtdExp: Double;
                                            '',                                           // strBarEmb: String;
                                            '',                                           // strNumCmp: String;
                                            0,                                            // intNItCmp: Integer;
                                            '',                                           // strCodMec: String;
                                            '',                                           // strSeqRcd: String;
                                            0,                                            // intSeqInc: Integer;
                                            0,                                            // IntOrdIte
                                            0);                                           // fltPesLiq: Double;

            If Not arrLotes[intIndex].blnAcaGra Then
              pGravaODMFDO(strAutIncODMFDO, qryTabela.FieldByName('AUTOINCREM').AsString, strAutFdo, arrLotes[intIndex].intSequen, arrLotes[intIndex].strITEACA);

            If Result Then
            Begin
              strAutFdo := fNextAutoIncrem(strAutFdo);
              strAutIncODMFDO := fNextAutoIncrem(strAutIncODMFDO);
            End;


          If Not Result Then
            Break;

          pProgressoPrg
        End;
      End
      Else
      If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
      Begin
        Self.First;
        intIdxIte:= 0;
        While Not(Self.Eof) do
        Begin
          pAbreCadIte(Self.FieldByName('ORD_CODITE').AsString);
          inc(intIdxIte);

          If qryCadIte.FieldByName('ITE_REAEND').AsString = 'S' Then
          Begin
            If blnGerarLotesPelaProcedure And Assigned(cdsLotesGeradosProcedure) Then
            Begin
              cdsLotesGeradosProcedure.Filtered := False;
              cdsLotesGeradosProcedure.Filter := 'CODITE = ' + QuotedStr(Self.FieldByName('ORD_CODITE').AsString);
              cdsLotesGeradosProcedure.Filtered := True;
              If cdsLotesGeradosProcedure.IsEmpty  Then
              Begin
                strAutFdoEnd := fRetAutoIncrem('FATDOR', VS_StrCodEmp);
                Result := Result And fGravaItemEnderecamento(strAutFdoEnd, Self.FieldByName('NUMLOT').AsString,
                                                             Self.FieldByName('ORD_QTDENV').AsFloat - fRetQtdeBaixaParcial(Self.FieldByName('ORD_CODITE').AsString))
              End
              Else
              Begin
                While Not cdsLotesGeradosProcedure.Eof Do
                Begin
                  strAutFdoEnd := fRetAutoIncrem('FATDOR', VS_StrCodEmp, cdsLotesGeradosProcedure.RecordCount);
                  Result := Result And fGravaItemEnderecamento(strAutFdoEnd, cdsLotesGeradosProcedure.FieldByName('NUMLOT').AsString,
                                                               cdsLotesGeradosProcedure.FieldByName('QTDALO').AsFloat);
                  strAutFdoEnd := fNextAutoIncrem(strAutFdoEnd);
                  cdsLotesGeradosProcedure.Next;
                End;
              End;
            End
            Else
            Begin
              strAutFdoEnd := fRetAutoIncrem('FATDOR', VS_StrCodEmp);
              Result := Result And fGravaItemEnderecamento(strAutFdoEnd, Self.FieldByName('NUMLOT').AsString,
                                                           Self.FieldByName('ORD_QTDENV').AsFloat - fRetQtdeBaixaParcial(Self.FieldByName('ORD_CODITE').AsString))
            End;
          End;

          pProgressoPrg;

          Self.Next;
        End;

      End

    End;

    FreeAndNil(qryCadIte);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TOrdProIndustrial.fReservaEstoqueOP');
    End;
  End;

end;

Procedure TOrdProIndustrial.pCarregaProdutosFormula_Composicao(strCodIte, strCodCor: String; strSeqOrd: String = ''; blnBaixaOp: Boolean = False; blnEditandoOP: Boolean = False);
Begin
  With cdsProFor, qryQuery Do
  Begin
    SQL.Text := fSqlProdutosFormula(not fEmptyStr(strSeqOrd) and (fCampoTabela('COUNT(*)', 'ORDMAT', ['ODM_SEQGER'], [strSeqOrd]) > 0));

    If Params.FindParam('CODITE') <> Nil Then
      ParamByName('CODITE').AsString := strCodIte;

    If Params.FindParam('CODCOR') <> Nil Then
      ParamByName('CODCOR').AsString := strCodCor;

    If Params.FindParam('CODEMP') <> Nil Then
      ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Params.FindParam('SEQORD') <> Nil Then
      ParamByName('SEQORD').AsString := strSeqOrd;

    If Params.FindParam('FORMUL') <> Nil Then
    Begin
      If fEmptyStr(Self.FieldByName('ORD_FORMUL').AsString) Then
        ParamByName('FORMUL').AsInteger := fRetFormulAtiva(strCodIte, strCodCor)
      Else
        ParamByName('FORMUL').AsString := Self.FieldByName('ORD_FORMUL').AsString;
    End;

    cdsProFor.fAbreClient(True, 'TOrdProIndustrial.pCarregaProdutosFormula_Composicao');

    cdsProFor.pFormataDecimal('SALDOS', 3);
    cdsProFor.pFormataDecimal('SALDIS', 3);
    cdsProFor.pFormataDecimal('SALRES', 3);
    cdsProFor.pFormataDecimal('QTDTOT', 3);
    cdsProFor.pFormataDecimal('QTDTOTACUMULADO', 3);
    cdsProFor.pFormataDecimal('QTDPROACUMULADO', 3);

    If Self.Active Then
    Begin
      if blnBaixaOp And fOrdemDeProducaoFilha(strSeqOrd) then
      Begin
        if FBxCompSubPro Then
          pCarregaProdutosComposicao(blnBaixaOp);
      End
      Else
        pCarregaProdutosComposicao(blnBaixaOp, blnEditandoOP);
    End;
  End;
End;

Procedure TOrdProIndustrial.pCarregaProdutosComposicao(blnBaixaOp: Boolean;blnEditandoOP: Boolean = False);
Var
  qryCompos: TUniQuery;
  fltQtdPro: Double;
Begin
  qryCompos := fCriaQuery(Self);

  qryCompos.SQL.Clear;
  qryCompos.SQL.Add(' SELECT ITE_DESITE AS DESITE,                       ');
  qryCompos.SQL.Add('        ITE_DENSID AS DENSID,                       ');
  qryCompos.SQL.Add('        ITE_SALDOS AS SALDOS,                       ');
  qryCompos.SQL.Add('        ITE_REFERE AS REFERE,                       ');
  qryCompos.SQL.Add('        ITE_PRECUS AS PRECUS                        ');
  If FGeraOpSubProdutos Then
    qryCompos.SQL.Add(' , DEP_PROACA AS PROACA                           ');
  qryCompos.SQL.Add(' FROM ITEGER G                                      ');
  qryCompos.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
  If FGeraOpSubProdutos Then
    qryCompos.SQL.Add(' LEFT JOIN CADDEP ON I.ITE_CODDEP = DEP_CODIGO    ');
  qryCompos.SQL.Add(' WHERE G.ITE_CODITE = :CODITE                       ');
  qryCompos.SQL.Add('   AND G.ITE_CODEMP = :CODEMP                       ');

  qryCompos.ParamByName('CODEMP').AsString := VS_strCodEmp;

  Self.First;

  While Not Self.Eof Do
  Begin
    If blnBaixaOp Then
      fltQtdPro := Self.FieldByName('ORD_QTDENV').AsFloat + IIf(Self.FieldByName('QTDBAI').AsFloat > 0, Self.FieldByName('QTDBAI').AsFloat,  0)
    Else
      fltQtdPro := Self.FieldByName('ORD_QTDPRO').AsFloat + IIf((Self.FieldByName('ORD_QTDPRO').AsFloat = 0) And (Self.FieldByName('QTDBAI').AsFloat > 0), Self.FieldByName('QTDBAI').AsFloat, 0);
    If FUtilizaConferencia And CarregandoItens And (fltQtdPro = 0) And  blnBaixaOp and (Self.FieldByName('ORD_QTDPRO').AsFloat  > 0) Then
      fltQtdPro := Self.FieldByName('ORD_QTDPRO').AsFloat;

    If fltQtdPro > 0 Then
    Begin
      cdsOrdCom.Filter := 'ODC_SEQDET = ' + QuotedStr(Self.FieldByName('AUTOINCREM').AsString) + ' OR ODC_CODITE = ' + QuotedStr(Self.FieldByName('ORD_CODITE').AsString);
      cdsOrdCom.Filtered := True;

      While Not cdsOrdCom.Eof Do
      Begin
        qryCompos.Close;
        qryCompos.ParamByName('CODITE').AsString := cdsOrdCom.FieldByName('ODC_CODITE').AsString;
        qryCompos.Open;

        If fCfgSis('COMFRA', varString) <> '?' Then
        Begin
          cdsOrdCom.Edit;
          If (Not fUnidadeDoProdutoEhFracionaria(cdsOrdCom.FieldByName('ODC_CODITE').AsString)) And (Frac(cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat * fltQtdPro) > 0) Then
          Begin
            If fCfgSis('COMFRA', varString) = '+' Then
              cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat := Int((cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat * fltQtdPro) + 1)
            Else If fCfgSis('COMFRA', varString) = '-' Then
              cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat := Int((cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat * fltQtdPro));
            {***********************************************************************************************************************************}
            {*  Caso a quantidade utilizada no cadastro de composição for fracionado e a unidade desse produto seja Inteiro (UNI_ITEFRA = N)   *}
            {*  e se a multiplicação do que foi envasado for um numero quebrado, então arredonda de acordo com a configuraçao, para + ou -     *}
            {*                                                                                                                                 *}
            {*  isso ocorre pois o cliente trabalha com o estoque e a venda por kilos, porem ele embala apenas em baldes de 10kg. Quando       *}
            {*  um cliente faz um pedido "Picado" ele tem q produzir o que foi pedido, exemplo 12 kilos:                                       *}
            {*  qtde embalagem = 0,1 ( seria 1 balde dividido por 10 pois ele cabe 10 kg)                                                      *}
            {*  qtd envasada 12                                                                                                                *}
            {*  qtd embalagens = 0,1 * 12 = 1,2 | arredonda para 2 (foi utilizado 2 baldes)                                                    *}
            {********************************************************************************************************************************GB*}
          End
          Else
            cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat := cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat * fltQtdPro;

          cdsOrdCom.Post;
        End
        Else
        Begin
          If (cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat <= 0) Or (blnEditandoOP And (Not FBaixaOrdem)) Then
          Begin
            cdsOrdCom.Edit;
            cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat := cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat * fltQtdPro;
            cdsOrdCom.Post;
          End;
        End;

        If cdsProFor.Locate('ITEACA;ITESUB;TIPPRO', VarArrayOf([Self.FieldByName('ORD_CODITE').AsString, cdsOrdCom.FieldByName('ODC_CODITE').AsString, 'COMPOS']), []) Then
        Begin
          cdsProFor.Edit;
          cdsProFor.FieldByName('QTDITE').AsFloat := cdsProFor.FieldByName('QTDITE').AsFloat + (cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat);
        End
        Else
        Begin
            cdsProFor.Insert;

            cdsProFor.FieldByName('ITEACA').AsString := Self.FieldByName('ORD_CODITE').AsString;
            cdsProFor.FieldByName('ITESUB').AsString := cdsOrdCom.FieldByName('ODC_CODITE').AsString;
            cdsProFor.FieldByName('QTDITE').AsFloat  := cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat;

            cdsProFor.FieldByName('TIPPRO').AsString := 'COMPOS';
            cdsProFor.FieldByName('TIPITE').AsString := 'COMPOS';
            cdsProFor.FieldByName('DESITE').AsString := qryCompos.FieldByName('DESITE').AsString;
            cdsProFor.FieldByName('DENSID').AsString := qryCompos.FieldByName('DENSID').AsString;
            cdsProFor.FieldByName('SALDOS').AsFloat  := qryCompos.FieldByName('SALDOS').AsFloat;
            cdsProFor.FieldByName('PRECUS').AsFloat  := qryCompos.FieldByName('PRECUS').AsFloat;
            cdsProFor.FieldByName('SALRES').AsFloat  := 0;
            cdsProFor.FieldByName('QTDTOT').AsFloat  := cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat;
            cdsProFor.FieldByName('SEMSAL').AsString := 'N';
            cdsProFor.FieldByName('SEMPRO').AsString := IIF(Self.FieldByName('ORD_QTDPRO').AsFloat = 0, 'S', 'N');
            cdsProFor.FieldByName('PRECOM').AsFloat  := 0;
            cdsProFor.FieldByName('RESREA').AsFloat  := 0;
            cdsProFor.FieldByName('REFERE').AsString := qryCompos.FieldByName('REFERE').AsString;
            If FGeraOpSubProdutos Then
              cdsProFor.FieldByName('PROACA').AsString := qryCompos.FieldByName('PROACA').AsString;
        End;

        cdsProFor.Post;

        cdsOrdCom.Edit;
        cdsOrdCom.FieldByName('ODC_VLRCUS').AsFloat := qryCompos.FieldByName('PRECUS').AsFloat;
        cdsOrdCom.FieldByName('ODC_TOTCUS').AsFloat := qryCompos.FieldByName('PRECUS').AsFloat * cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat;
        cdsOrdCom.Post;

        cdsOrdCom.Next;
      End;

    End;

    Self.Next;
  End;
  cdsProFor.First;
  Self.First;

  cdsOrdCom.Filtered := False;
  cdsOrdCom.Filter := '';
  cdsOrdCom.First;

  FreeAndNil(qryCompos);
End;

procedure TOrdProIndustrial.pCalculaCapacidadeMaximaAcabados;
var
  fltPesoTotalDisponivel : real;
  bkmAcabado : TBookmark;
begin
  if Self.Active then
  begin

    fltPesoTotalDisponivel := FCapacidadeMaxima - fRetSoma('PESO');
    if fltPesoTotalDisponivel < 0 then
      fltPesoTotalDisponivel := 0;

    Self.DisableControls;
    Self.AfterPost := nil;
    try
      bkmAcabado := Self.GetBookmark;
      try
        Self.First;
        while not Self.eof do
        begin
          Self.Edit;
          Self.fieldByName('SUGMAX').AsInteger := fRetornaSugestaoMaximaProducao(fltPesoTotalDisponivel, Self.FieldByName('PESUNI').AsFloat);
          Self.Post;

          Self.next;
        end;
      finally
        Self.GotoBookmark(bkmAcabado);
        Self.FreeBookmark(bkmAcabado);
      end;
    finally
      Self.AfterPost := pAfterPost;
      Self.EnableControls;
    end;
  end;
end;

function TOrdProIndustrial.fTemSaldoDisponivelProduzir(fltDifProducao, fltQtdProduzir, fltSalRes: Double; FCdsItem: TUniClientDataSet): Boolean;
var
  saldoDisponivel,
  fltSaldoFalante,
  fltQtdReservadaOp,
  fltSaldoDisponivel: Double;
  fltSaldo: double;
begin
  fltSaldo := roundto(cdsProFor.FieldByName('SALDOS').AsFloat, -intCasasDecimaisMateriaPrima);
  fltDifProducao := roundto(fltDifProducao, -intCasasDecimaisMateriaPrima);
  fltSalRes := roundto(fltSalRes, -intCasasDecimaisMateriaPrima);
  fltQtdProduzir := roundto(fltQtdProduzir, -intCasasDecimaisMateriaPrima);
  If FBaixaOrdem Then
  Begin
    Result := True;

    If fltQtdProduzir <= 0 Then
      Exit;

    saldoDisponivel :=  roundto(fltSaldo - fltSalRes, -intCasasDecimaisMateriaPrima);
    If saldoDisponivel <  0 then
      Exit(False);

    If roundto(saldoDisponivel - fltQtdProduzir, -intCasasDecimaisMateriaPrima) < 0 then
      Exit(False);
  End
  Else
  Begin
    fltQtdReservadaOp := roundto(fltQtdProduzir, -intCasasDecimaisMateriaPrima);
    fltSaldoDisponivel :=  roundto(fltSaldo, -intCasasDecimaisMateriaPrima) +
                           roundto(fltQtdReservadaOp, -intCasasDecimaisMateriaPrima) -
                           roundto(fltSalRes, -intCasasDecimaisMateriaPrima);
   If fltSaldoDisponivel < 0 Then
      Exit(False);
   fltSaldoFalante    :=  roundto(fltQtdReservadaOp, -intCasasDecimaisMateriaPrima) -
                          roundto(fltSaldoDisponivel, -intCasasDecimaisMateriaPrima);
   If fltSaldoFalante < 0 Then
      fltSaldoFalante := 0;
   result := True;
   // fltSalRes  = Quantidade reservada total sem a reserva atual
   // fltQtdReservadaOp = é a quantidade que a Op. esta ou vai reservar
   // fltSaldoFalante = e quanto falt do saldo disponivel
   // fltDifProducao = é a diferença entre o que reservou para o que produziu
   If (fltSalRes + (fltQtdReservadaOp - fltSaldoFalante) + fltDifProducao) > (fltSaldo + fltQtdReservadaOp) then
     Exit(False);

   If (fltDifProducao > 0) And (((fltSaldo) - fltQtdReservadaOp + fltDifProducao) < 0) then
     Exit(False);
  End;
End;

Procedure TOrdProIndustrial.pCalculaQuantidadesUsadas(strAutoinc: String = ''; blnValidaSaldo: Boolean = True; cdsSubItemSelecionado: TUniClientDataSet = Nil);
Var
  fltQtdTotCorrecaoNegativa: Double;
  fltDifProducao,
  fltQtdProd,
  fltQtdCorrecaoDoItem, fltSalResOpe, fltQtdReservadaOp, fltPesTot, fltSalRes, fltQtdPes: Double;
  FCdsItem: TUniClientDataSet;
  blnSubItemInformado: Boolean;
  fltSalResSemOp: Double;
Begin
  fltQtdTotCorrecaoNegativa := 0;
  fltPesTot := fGetPesoProducao;

  FCdsItem := TUniClientDataSet.Create(Self);
  Try
    FCdsItem.FieldDefs.Add('CODITE', ftString, fTamCodIte);
    FCdsItem.FieldDefs.Add('TOTPES', ftFloat);
    FCdsItem.CreateDataSet;

    With cdsProFor Do
    Begin
      IndexFieldNames := 'SEQUEN';
      First;
      While Not Eof Do
      Begin
        Edit;

        fltQtdReservadaOp :=0;
        fltDifProducao :=0;

        fltSalRes := TProdutoEstoque.fGetSaldos(FieldByName('ITESUB').AsString).FieldByName('SALRES').AsFloat;
        fltSalResSemOp := TProdutoEstoque.fGetSaldos(FieldByName('ITESUB').AsString).FieldByName('SALSOP').AsFloat;

        if not fEmptyStr(strAutoinc) Then
          fltQtdReservadaOp  := pRetQtdJaReservado(strAutoinc, cdsProFor.FieldByName('ITESUB').AsString);

        fltSalResOpe :=  fltQtdReservadaOp;
        fltSalRes := fltSalRes - fltSalResOpe;

        FieldByName('SALDOS').AsFloat := TProdutoEstoque.fGetSaldos(FieldByName('ITESUB').AsString).FieldByName('SALDOS').AsFloat;

        If FieldByName('TIPPRO').AsString = 'FORMUL' Then
        Begin

          If FieldByName('TIPITE').AsString = 'NORMAL' Then
          Begin
            //Verifica se o cliente selecionou item na tela de agrupamento de pedido
            If (fCfgSis('SEPASD', varBoolean) And fCfgSis('GOPSPR', varBoolean)) Or
               (fCfgSis('GEQTOP', varBoolean) And fCfgSis('GOPSPR', varBoolean)) And (cdsSubItemSelecionado <> Nil) Then
            Begin

              If (fCfgSis('GEQTOP', varBoolean)) And (cdsSubItemSelecionado <> Nil) Then
              Begin
                If cdsSubItemSelecionado.Locate('ITESUB;CODCOR', VarArrayOf( [FieldByName('ITESUB').AsString,
                                                                              FieldByName('CODCOR').AsString]), [] ) Then
                  fltQtdPes := cdsSubItemSelecionado.FieldByName('QTDTOT').AsFloat
                Else
                  fltQtdPes := fltPesTot * (FieldByName('QTDITE').AsFloat / 100);
              End
              Else
              Begin
                If cdsSubItemSelecionado <> Nil Then
                Begin
                  If cdsSubItemSelecionado.Locate('ITESUB', FieldByName('ITESUB').AsString, []) Then
                    fltQtdPes := cdsSubItemSelecionado.FieldByName('QTDTOT').AsFloat
                  Else
                    fltQtdPes := fltPesTot * (FieldByName('QTDITE').AsFloat / 100);
                End
                Else
                  fltQtdPes := fltPesTot * (FieldByName('QTDITE').AsFloat / 100);
              End;

            End
            Else
              fltQtdPes := fltPesTot * (cdsProFor.FieldByName('QTDITE').AsFloat / 100)
          End
          Else
            fltQtdPes := FieldByName('QTDITE').AsFloat;

          FieldByName('PRECOM').AsFloat := fltQtdPes * FieldByName('PRECUS').AsFloat;
        End
        Else
        Begin
          fltQtdPes := FieldByName('QTDITE').AsFloat;
        End;

        FieldByName('QTDTOT').AsFloat := fltQtdPes;
        FieldByName('SALRES').AsFloat := fltSalRes;
        FieldByName('RESREA').AsFloat := fltSalResOpe;

        FieldByName('SALDIS').AsFloat := RoundTo(FieldByName('SALDOS').AsFloat - fltSalRes, intCasasDecimaisMateriaPrima* -1);
        fltQtdCorrecaoDoItem := 0;
        If blnValidaSaldo Then
        Begin
          If Not(FCdsItem.Locate('CODITE', cdsProFor.FieldByName('ITESUB').AsString, [])) Then
          Begin
            FCdsItem.Insert;
            FCdsItem.FieldByName('CODITE').AsString := cdsProFor.FieldByName('ITESUB').AsString;
            FCdsItem.FieldByName('TOTPES').AsFloat := fltQtdPes;
            FCdsItem.Post;
          End
          Else
          Begin
            FCdsItem.Edit;
            FCdsItem.FieldByName('TOTPES').AsFloat := FCdsItem.FieldByName('TOTPES').AsFloat + fltQtdPes;
            FCdsItem.Post
          End;

          cdsProFor.FieldByName('QTDTOTACUMULADO').AsFloat  := FCdsItem.FieldByName('TOTPES').AsFloat;
          cdsProFor.FieldByName('QTDPROACUMULADO').AsFloat  := FieldByName('QTDPROACUMULADO').AsFloat + fltQtdReservadaOp;

          If FCdsItem.FieldByName('CODITE').AsString <>  cdsProFor.FieldByName('ITESUB').AsString then
            (FCdsItem.Locate('CODITE', cdsProFor.FieldByName('ITESUB').AsString, []));

          fltDifProducao := (cdsProFor.FieldByName('QTDTOTACUMULADO').AsFloat - cdsProFor.FieldByName('QTDPROACUMULADO').AsFloat);

          fltQtdTotCorrecaoNegativa := 0.00;
          If Assigned(objCorrOP) Then
          begin
            fltQtdTotCorrecaoNegativa := RoundTo(objCorrOP.fRetQtdCorrecaoNegativaDoItem(FieldByName('ITESUB').AsString),intCasasDecimaisMateriaPrima* -1);
            fltQtdCorrecaoDoItem := RoundTo(objCorrOP.fRetQtdCorrecaoDoItem(FieldByName('ITESUB').AsString),intCasasDecimaisMateriaPrima* -1);
          end;
        End;


        If fltDifProducao < 0 Then
          fltDifProducao := 0;
        If FCdsItem.FieldByName('CODITE').AsString = cdsProFor.FieldByName('ITESUB').AsString then
        begin

          If cdsProFor.FieldByName('QTDTOTACUMULADO').AsFloat  <  cdsProFor.FieldByName('QTDPROACUMULADO').AsFloat then
            fltQtdProd := cdsProFor.FieldByName('QTDTOTACUMULADO').AsFloat
          Else
            fltQtdProd := cdsProFor.FieldByName('QTDPROACUMULADO').AsFloat;

          If (RoundTo(fltQtdPes + fltQtdTotCorrecaoNegativa, intCasasDecimaisMateriaPrima* -1) > 0) And
             (Not fTemSaldoDisponivelProduzir(fltDifProducao, IIF(FBaixaOrdem, fltQtdProd + fltQtdCorrecaoDoItem,fltQtdProd), IIF(FBaixaOrdem, fltSalResSemOp, fltSalRes), FCdsItem)) Then
            FieldByName('SEMSAL').AsString := 'S'
         Else
            FieldByName('SEMSAL').AsString := 'N';
         End;

        {Verifica se o cliente selecionou item na tela de agrupamento de pedido
         Se não encontrar no cdsProFor o item deletado. So irá entrar nesta rotina
         quando a chamada vier da tela de agrupamento de pedido}
        If fCfgSis('GOPSPR', varBoolean) And (cdsSubItemSelecionado <> Nil) And FAgrupamentoPedido Then
        Begin
          if Not(cdsSubItemSelecionado.IsEmpty) then
          Begin
            blnSubItemInformado:= (cdsSubItemSelecionado.Locate('ITESUB', cdsProFor.FieldByName('ITESUB').AsString, [])) and
                                  (cdsProFor.FieldByName('TIPITE').AsString = 'NORMAL');
            If Not(blnSubItemInformado) Then
              cdsProFor.FieldByName('MARDES').AsString:= 'D'
            Else
              cdsProFor.FieldByName('MARDES').AsString:= 'M';
          End;
        End;

        Post;

        Next;
      End;

    End;
  Finally
    FreeAndNil(FCdsItem);
  End;

End;


Function TOrdProIndustrial.fVerificaQuantidadeEstoque(qryTabela: TUniQuery;
  blnApenasMontarNecesSubOP: Boolean = False; blnBaixaOp : Boolean = False; cdsSubItemSelecionado: TUniClientDataSet = Nil): Boolean;
Var
  intIndex: Integer;
  blnAchou: Boolean;
  fltQtdPro: Double;

  function fCriaQryTabela(strCodPag, strCodCor: String): TUniQuery;
  Begin
    Result := fCriarQuery('SELECT * FROM ORDGER WHERE FALSE', Self);

    With Result Do
    Begin
      Open;
      Edit;
      FieldByName('AUTOINCREM').AsString := IntToStr(intIndex);
      FieldByName('ORD_CODORD').AsString := IntToStr(intIndex);
      FieldByName('ORD_CODEMP').AsString := VS_strCodEmp;
      FieldByName('ORD_CODITE').AsString := strCodPag;
      FieldByName('ORD_CODCOR').AsString := strCodCor;
      FieldByName('ORD_DTACAD').AsDateTime := VS_Date;
      FieldByName('ORD_DTAPRE').AsDateTime := qryTabela.FieldByName('ORD_DTAPRE').AsDateTime;
      FieldByName('ORD_HORCAD').AsDateTime := fNow();
      FieldByName('ORD_CUSORD').AsFloat := 0.00;
      FieldByName('ORD_DTABAI').Clear;
      FieldByName('ORD_DTAINI').Clear;
      FieldByName('ORD_HORINI').Clear;
      FieldByName('ORD_DTAFIN').Clear;
      FieldByName('ORD_HORFIN').Clear;

    End;

  End;

Begin
  Result := True;

  try
    TProdutoEstoque.pLimpaCds;
    DisableControls;

    pCarregaProdutosFormula_Composicao(qryTabela.FieldByName('ORD_CODITE').AsString,
                                       qryTabela.FieldByName('ORD_CODCOR').AsString,
                                       qryTabela.FieldByName('AUTOINCREM').AsString,
                                       blnBaixaOp,
                                       qryTabela.State = dsEdit);

    If fCfgSis('SLD_OI') = 'N' Then
      Exit;

    pCalculaQuantidadesUsadas(qryTabela.FieldByName('AUTOINCREM').AsString, True, cdsSubItemSelecionado);

    If  fCfgSis('GOPSPR', varBoolean) And fCfgSis('GEQTOP', varBoolean) And
       (cdsSubItemSelecionado <> Nil) And blnAgrupamentoPedido Then
    Begin
      pInsereMateriaPrimaTemporariamenteApenasParaGeracaoDaOPI(cdsSubItemSelecionado);
    End;

    With cdsProFor Do
    Begin

      Result := Not Locate('SEMSAL', 'S', []);

      If Not Result Then
      Begin

        // Aqui Calcula Todas As Ordens de Produção que serão Criadas.
        if blnApenasMontarNecesSubOP And FGeraOpSubProdutos Then
        Begin

          //Verifica se o cliente selecionou item na tela de agrupamento de pedido
          If  (fCfgSis('GEQTOP', varBoolean) Or
               fCfgSis('GOPSPR', varBoolean)) And
              (cdsSubItemSelecionado <> Nil) Then
          Begin

            If Not(cdsSubItemSelecionado.IsEmpty) Then
            Begin
              If  fCfgSis('GEQTOP', varBoolean) Then
              Begin
                Filtered := True;
                Filter := 'SEMSAL = ' + QuotedStr('S') + ' AND CODPAG <> ' + QuotedStr('')+' AND ITTEMP = '+QuotedStr('S');
                First;
              End
              Else
              Begin
                Filtered := True;
                Filter := 'SEMSAL = ' + QuotedStr('S') + ' AND MARDES = '+QuotedStr('M')+' AND CODPAG <> ' + QuotedStr('');
                First;
              End;
            End
            Else
            Begin
              Filtered := True;
              Filter := 'SEMSAL = ' + QuotedStr('S') + ' AND CODPAG <> ' + QuotedStr('');
              First;
            End;
          End
          Else
          Begin
            Filtered := True;
            Filter := 'SEMSAL = ' + QuotedStr('S') + ' AND CODPAG <> ' + QuotedStr('');
            First;
          End;


          While not Eof Do
          Begin
            blnAchou := False;
            For intIndex := 0 To High(FarrQryTabela) Do
            Begin
              if FarrQryTabela[intIndex].Locate('ORD_CODITE;ORD_CODCOR', VarArrayOf([FieldByName('CODPAG').AsString, FieldByName('CODCOR').AsString]), []) Then
              Begin
                blnAchou := True;
                Break;
              End;

            End;

            If (not (blnAchou)) Or (fCfgSis('GEQTOP', varBoolean) And (cdsSubItemSelecionado <> Nil)) Then
            Begin
              SetLength(FarrSubOP, Length(FarrSubOP) + 1);
              SetLength(FarrQryTabela, Length(FarrQryTabela) + 1);
              intIndex := High(FarrQryTabela);

              FarrQryTabela[intIndex] := fCriaQryTabela(FieldByName('CODPAG').AsString, FieldByName('CODCOR').AsString);

              FarrSubOP[intIndex] := TOrdProIndustrial.Create(Self, Nil, Nil, False, False, FarrSubOP, FarrQryTabela);
              FarrSubOP[intIndex].pCarregaTipoProducao(FieldByName('CODPAG').AsString);
              FarrSubOP[intIndex].fCarregaItens('', FieldByName('CODPAG').AsString, FieldByName('CODCOR').AsString);
            End;

            If FarrSubOP[intIndex].Locate('ORD_CODITE', FieldByName('ITESUB').AsString, []) Then
            Begin
              FarrSubOP[intIndex].Edit;

              // Seta o Vinculo
              SetLength(FarrSubOP[intIndex].FarrPaiOrdem,Length(FarrSubOP[intIndex].FarrPaiOrdem) + 1);
              FarrSubOP[intIndex].FarrPaiOrdem[High(FarrSubOP[intIndex].FarrPaiOrdem)] := qryTabela.FieldByName('ORD_CODITE').AsString +
                                                                                          qryTabela.FieldByName('ORD_CODCOR').AsString;

              SetLength(FarrSubOP[intIndex].FarrQuantidades,Length(FarrSubOP[intIndex].FarrQuantidades) + 1);
              FarrSubOP[intIndex].FarrQuantidades[High(FarrSubOP[intIndex].FarrQuantidades)].fltQtdUsa := FieldByName('QTDTOT').AsFloat;
              FarrSubOP[intIndex].FarrQuantidades[High(FarrSubOP[intIndex].FarrQuantidades)].fltUsaEst := 0;
              FarrSubOP[intIndex].FarrQuantidades[High(FarrSubOP[intIndex].FarrQuantidades)].fltQtdSub := 0;

              If (FieldByName('SALDIS').AsFloat > 0) Then
              Begin
                fltQtdPro := (FieldByName('QTDTOT').AsFloat - FieldByName('SALDIS').AsFloat);

                FarrSubOP[intIndex].FarrQuantidades[High(FarrSubOP[intIndex].FarrQuantidades)].fltUsaEst := FieldByName('SALDIS').AsFloat;
                FarrSubOP[intIndex].FarrQuantidades[High(FarrSubOP[intIndex].FarrQuantidades)].fltQtdSub := fltQtdPro;
                FarrSubOP[intIndex].FieldByName('ORD_QTDPRO').AsFloat := FarrSubOP[intIndex].FieldByName('ORD_QTDPRO').AsFloat + fltQtdPro;

                With TProdutoEstoque.fGetSaldos(FieldByName('ITESUB').AsString) Do
                Begin
                  Edit;
                  FieldByName('SALDOS').AsFloat := FieldByName('SALDOS').AsFloat - fltQtdPro;
                  Post;
                End;

              End
              Else
              Begin
                FarrSubOP[intIndex].FieldByName('ORD_QTDPRO').AsFloat := FarrSubOP[intIndex].FieldByName('ORD_QTDPRO').AsFloat +
                                                                         FieldByName('QTDTOT').AsFloat;
                FarrSubOP[intIndex].FarrQuantidades[High(FarrSubOP[intIndex].FarrQuantidades)].fltQtdSub := FieldByName('QTDTOT').AsFloat;
              End;

              FarrSubOP[intIndex].Post;
            End;

            FarrSubOP[intIndex].fVerificaQuantidadeEstoque(FarrQryTabela[intIndex], True, False, cdsSubItemSelecionado);

            Next;
          End;

          If  fCfgSis('GOPSPR', varBoolean) And fCfgSis('GEQTOP', varBoolean) And
             (cdsSubItemSelecionado <> Nil) And blnAgrupamentoPedido Then
          Begin
            pDeleteMateriaPrimaTemporariamenteApenasParaGeracaoDaOPI;
          End;

          Filtered := False;
          Filter := '';
          First;
        End;

        If not blnApenasMontarNecesSubOP Then
        Begin

          If blnBaixaOp Then
          Begin
            If fCfgSis('SLDGER', varBoolean) Then
              Result := fMostraProdutosSemSaldo(True)
            Else
              Result := True;
          End
          Else
            Result := fMostraProdutosSemSaldo

        End;
      End;

      Filtered := False;
      First;
    End;

  finally
    EnableControls;
    If Active Then
    	First;
  end;
End;


function TOrdProIndustrial.fRetQtdIteProduzidaTotal(strCodIte: String; var fltQtdSemPro:Double; var fltQtdPro: Double): Double;
var intRecNo: integer;
begin
  intRecNo := cdsProFor.RecNO;
  Try
    cdsProFor.First;
    result := 0;
    fltQtdSemPro := 0;
    fltQtdPro    := 0;
    while not cdsProFor.Eof do
    Begin
      If (cdsProFor.FieldByName('ITESUB').AsString = strCodIte) And
         (cdsProFor.FieldByname('TIPITE').AsString <> 'CORREC') then
      Begin
       If cdsProFor.FieldByname('SEMPRO').AsString = 'S' Then
          fltQtdSemPro := fltQtdSemPro + cdsProFor.FieldByname('QTDITE').AsFloat
        Else If cdsProFor.FieldByname('QTDITE').AsFloat > 0 Then
          fltQtdPro := fltQtdPro + cdsProFor.FieldByname('QTDITE').AsFloat;

        Result := Result + cdsProFor.FieldByname('QTDITE').AsFloat;
      End;
      cdsProFor.Next;
    End;
  Finally
    cdsProFor.RecNO := intRecNo;
  End;

End;

function TOrdProIndustrial.fVerificaSaldoParaBaixaEvazadaAcimaComSaldo(strSeqGer: String; var ListaErro: TStringList; blnBaixaParcial: Boolean = False): Boolean;
var qryConsulta: TUniQuery;
    qryLotes: TUniQuery;
    fltQtdFaltante: Double;
    fltSalDisLot: Double;
    fltQtdInserir: Double;
    strLinha: String;
    objReservaSaldoOrdemProducaoIndustrial: TReservaSaldoOrdemProducaoIndustrial;
    blnPermiteReservarProdutosComposicao: Boolean;
    fltQtdSemProducao, fltQtdComProducao,
    fltQtdReservaOriginal: Double;


begin
  Result := True;
  If Not fCfgSis('INCCOM', varBoolean) Then
    Exit;

  If Not fUsaRotinaWMS Then
    Exit;

  objReservaSaldoOrdemProducaoIndustrial:= TReservaSaldoOrdemProducaoIndustrial.Create;
  Try
    objReservaSaldoOrdemProducaoIndustrial.strTipoItem := cdsProFor.FieldByName('TIPITE').AsString;
    objReservaSaldoOrdemProducaoIndustrial.blnPermiteReservaComposicao:= fCfgSis('INCCOM', varBoolean);
    blnPermiteReservarProdutosComposicao:= objReservaSaldoOrdemProducaoIndustrial.fRetornaReservaProdutoComposicao;
  Finally
    FreeAndNil(objReservaSaldoOrdemProducaoIndustrial);
  End;

  If Not blnPermiteReservarProdutosComposicao Then
    Exit;

  If Not Assigned(ListaErro) Then
    ListaErro := TStringList.Create;

  qryConsulta := fCriaQuery;
  cdsLotesComponentes := TZClient.Create(Self);
  cdsLotesComponentes.qryQuery.SQL.Text := fGetSQLLotesMateriaPrima;
  cdsLotesComponentes.qryQuery.ParamByName('CODITE').AsString := '';
  cdsLotesComponentes.fAbreClient(True, 'TOrdProIndustrial.fReservaEstoqueOP');

  qryLotes := fCriaQuery;
  qryLotes.SQL.Text := fGetSQLLotesMateriaPrima;

  Try
    qryConsulta.SQL.Add('SELECT SUM(ODC_QTDITE * ORD_QTDPRO) AS QTD,');
    qryConsulta.SQL.Add('      SUM(ODC_QTDUSA) AS QTDENV, ODC_CODITE FROM ORDDET');
    qryConsulta.SQL.Add('  LEFT JOIN ORDCOM ON ORDCOM.ODC_SEQDET = ORDDET.AUTOINCREM');
    qryConsulta.SQL.Add(' WHERE ORD_SEQGER = "' + strSeqGer + '"');
    qryConsulta.SQL.Add(' GROUP BY ODC_CODITE');
    qryConsulta.Open;

    while not qryConsulta.Eof Do
    Begin
      cdsProFor.First;
      fltQtdFaltante := fRetQtdIteProduzidaTotal(qryConsulta.FieldByName('ODC_CODITE').AsString, fltQtdSemProducao, fltQtdComProducao);
      If fltQtdFaltante > 0 Then
      Begin
        {Subtrai pq a quantidade para a produzir ja esta reservando saldo}
        fltQtdReservaOriginal := qryConsulta.FieldByName('QTD').AsFloat;

        If fCfgSis('COMFRA', varString) <> '?' Then
        Begin
          If (Not fUnidadeDoProdutoEhFracionaria(qryConsulta.FieldByName('ODC_CODITE').AsString) And (Frac(fltQtdReservaOriginal) > 0)) Then
          Begin
            If fCfgSis('COMFRA', varString) = '+' Then
              fltQtdReservaOriginal := Int(fltQtdReservaOriginal + 1)
            Else If fCfgSis('COMFRA', varString) = '-' Then
              fltQtdReservaOriginal := Int(fltQtdReservaOriginal)
          End;
          If (Not fUnidadeDoProdutoEhFracionaria(qryConsulta.FieldByName('ODC_CODITE').AsString) And (Frac(fltQtdFaltante) > 0)) Then
          Begin
            If fCfgSis('COMFRA', varString) = '+' Then
              fltQtdFaltante := Int(fltQtdFaltante + 1)
            Else If fCfgSis('COMFRA', varString) = '-' Then
              fltQtdFaltante := Int(fltQtdFaltante)
          End;

        End;
        fltQtdFaltante := fltQtdFaltante - (fltQtdReservaOriginal + fltQtdSemProducao);

        If (fltQtdFaltante) > 0   Then
        Begin
          qryLotes.Close;
          qryLotes.ParamByName('CODITE').AsString := qryConsulta.FieldByName('ODC_CODITE').AsString;
          qryLotes.Open;

          While not qryLotes.Eof Do
          Begin
             fltSalDisLot := fRetornaSaldoDisponivel(qryLotes.FieldByName('CODITE').AsString,
                                                     False,
                                                     True,
                                                     qryLotes.FieldByName('NUMLOT').AsString,
                                                     True,
                                                     VS_strCodEmp);

            If fltSalDisLot > 0 then
            begin
              If fltSalDisLot >= (fltQtdFaltante) Then
                fltQtdInserir := (fltQtdFaltante)
              Else
              Begin
                fltQtdInserir := fltSalDisLot;
              End;

              If fltQtdInserir > 0 Then
              Begin
                cdsLotesComponentes.Insert;
                cdsLotesComponentes.FieldByName('CODITE').Value := qryLotes.FieldByName('CODITE').Value;
                cdsLotesComponentes.FieldByName('NUMLOT').Value := qryLotes.FieldByName('NUMLOT').Value;
                cdsLotesComponentes.FieldByName('SALDOS').Value := fltQtdInserir;
                cdsLotesComponentes.FieldByName('SEMRES').Value := 'N';
                cdsLotesComponentes.Post;
                fltQtdFaltante := fltQtdFaltante - fltQtdInserir;
              End;
            End;

            qryLotes.Next;
            If (fltQtdFaltante) <= 0 Then
              qryLotes.Last;

          End;

          If RoundTo((fltQtdFaltante), -4) > 0 Then
          Begin

            If ListaErro.Count = 0 Then
            Begin
              ListaErro.Add('Não foi possível encontrar saldo disponivel para os componentes listados abaixo.');
              ListaErro.Add('Para poder evazar estas quantidades será preciso ter saldo.');
              strLinha := StringOfChar(' ', 80);
              System.Insert('ITEM', strLinha, 1);
              System.Insert(' QTD. FALTANTE', strLinha, 31);
              ListaErro.Add(strLinha);
            End;
            strLinha := StringOfChar(' ', 80);
            System.Insert(Copy(qryLotes.FieldByName('CODITE').AsString + ' - ' + fRetNomProduto(qryLotes.FieldByName('CODITE').AsString), 1 , 30), strLinha, 1);
            System.Insert(fPadL(FormatFloat('#0.00', fltQtdFaltante ), 15), strLinha, 31);
            ListaErro.Add(strLinha);
            Result := False;
          End;
        End;


        //Quantidade sem reserva
        If (fltQtdSemProducao) > 0   Then
        Begin
          qryLotes.Close;
          qryLotes.ParamByName('CODITE').AsString := qryConsulta.FieldByName('ODC_CODITE').AsString;
          qryLotes.Open;
          fltQtdFaltante := fltQtdSemProducao;

          While not qryLotes.Eof Do
          Begin
             fltSalDisLot := fRetornaSaldoDisponivel(qryLotes.FieldByName('CODITE').AsString,
                                                     False,
                                                     True,
                                                     qryLotes.FieldByName('NUMLOT').AsString,
                                                     True,
                                                     VS_strCodEmp);

            If fltSalDisLot > 0 then
            begin
              If fltSalDisLot >= fltQtdFaltante Then
                fltQtdInserir := fltQtdFaltante
              Else
              Begin
                fltQtdInserir := fltSalDisLot;
              End;

              If fltQtdInserir > 0 Then
              Begin
                cdsLotesComponentes.Insert;
                cdsLotesComponentes.FieldByName('CODITE').Value := qryLotes.FieldByName('CODITE').Value;
                cdsLotesComponentes.FieldByName('NUMLOT').Value := qryLotes.FieldByName('NUMLOT').Value;
                cdsLotesComponentes.FieldByName('SALDOS').Value := fltQtdInserir;
                cdsLotesComponentes.FieldByName('SEMRES').Value := 'S';

                cdsLotesComponentes.Post;
                fltQtdFaltante := fltQtdFaltante - fltQtdInserir;
              End;
            End;

            qryLotes.Next;
            If (fltQtdFaltante) <= 0 Then
              qryLotes.Last;

          End;

          If RoundTo((fltQtdFaltante), -4) > 0 Then
          Begin

            If ListaErro.Count = 0 Then
            Begin
              ListaErro.Add('Não foi possível encontrar saldo disponivel para os componentes listados abaixo.');
              ListaErro.Add('Para poder evazar estas quantidades será preciso ter saldo.');
              strLinha := StringOfChar(' ', 80);
              System.Insert('ITEM', strLinha, 1);
              System.Insert(' QTD. FALTANTE', strLinha, 31);
              ListaErro.Add(strLinha);
            End;
            strLinha := StringOfChar(' ', 80);
            System.Insert(Copy(qryLotes.FieldByName('CODITE').AsString + ' - ' + fRetNomProduto(qryLotes.FieldByName('CODITE').AsString), 1 , 30), strLinha, 1);
            System.Insert(fPadL(FormatFloat('#0.00', fltQtdFaltante), 15), strLinha, 31);
            ListaErro.Add(strLinha);
            Result := False;
          End;
        End;
      End;
      qryConsulta.Next;
    End;
  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(qryLotes);

    If ListaErro.Count = 0 Then
      FreeAndNil(ListaErro)
    Else
    Begin
      cdsLotesComponentes.First;
      While not CdsLotesComponentes.Eof do
        CdsLotesComponentes.Delete;
    End;
  End;

end;


procedure TOrdProIndustrial.LimparcdsLotesGeradosProcedure;
begin
  If Assigned(cdsLotesGeradosProcedure) Then
  If cdsLotesGeradosProcedure.Active Then
  Begin
    cdsLotesGeradosProcedure.Filtered := False;
    cdsLotesGeradosProcedure.First;
    while not cdsLotesGeradosProcedure.IsEmpty Do
      cdsLotesGeradosProcedure.Delete;
   End;


end;

function TOrdProIndustrial.fRetQtdPro(cdsDados : TUniClientDataSet; strCodIte: String): Double;
begin
  Result := 0;
  cdsDados.Filtered := False;
  cdsDados.Filter := 'ITESUB = ' + QuotedStr(strCodIte);
  cdsDados.Filtered := True;

  While not cdsDados.Eof Do
  Begin
    If cdsDados.FieldByName('ITESUB').AsString = strCodIte Then
      Result := Result + cdsDados.FieldByName('QTDTOT').AsFloat;
    cdsDados.Next;
  End;

  If FBaixaOrdem Then
    Result := Result + RoundTo(objCorrOP.fRetQtdCorrecaoDoItem(cdsDados.FieldByName('ITESUB').AsString),intCasasDecimaisMateriaPrima* -1);

End;

Function TOrdProIndustrial.fMostraProdutosSemSaldo(ABlnBaixaOpi: Boolean = False): Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;
  cdsProForBkp : TUniClientDataSet;
Begin
  Try
    cdsProForBkp:= TUniClientDataSet.Create(Nil);
    Try

      cdsProForBkp.Data := cdsProFor.Data;
      With cdsProFor Do
      Begin
        Filtered := True;
        Filter := 'SEMSAL = ' + QuotedStr('S');
        First;

        // Se só avisa sem travar exibe no form, se não solicita digsenvar.
        If fCfgSis('SLD_OI') = 'A' Then
        Begin
          Result := True;
          pCriarFormularios(TfrmOrdProIndustrialProdSemSaldo, frmOrdProIndustrialProdSemSaldo);
          frmOrdProIndustrialProdSemSaldo.blnGeraOpSubProdutos := FGeraOpSubProdutos;
          frmOrdProIndustrialProdSemSaldo.cxgItensView.DataController.DataSource := cdsProFor.dtsSource;
          frmOrdProIndustrialProdSemSaldo.ShowModal;
          FreeAndNil(frmOrdProIndustrialProdSemSaldo);
        End

        Else
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Liberação para Ordem de Produção com Sub-Produtos sem Saldo em Estoque');

          objTabela := TRegistroMsgLiberaTabela.Create;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'Código'         , fTamCodIte, alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'Descrição'      , 45 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'Saldo Físico'   , 12 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'Reservado'      , 12 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'Reserva OP'     , 12 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'A Produzir'     , 12 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'O.P. em Aberto' , 14 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          While Not Eof Do
          Begin

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('Código'         , FieldByName('ITESUB').AsString                                              , fTamCodIte, alEsquerda );
            objLinha.pAddColuna('Descrição'      , FieldByName('DESITE').AsString                                              , 45 , alEsquerda );
            objLinha.pAddColuna('Saldo Físico'   , FormatFloat('#,##0.0000', FieldByName('SALDOS').AsFloat)                      , 12 , alDireita  );
            objLinha.pAddColuna('Reservado'      , FormatFloat('#,##0.0000', FieldByName('SALRES').AsFloat)                      , 12 , alDireita  );
            objLinha.pAddColuna('Reserva OP'     , FormatFloat('#,##0.0000', FieldByName('RESREA').AsFloat)                      , 12 , alDireita  );
            objLinha.pAddColuna('A Produzir'     , FormatFloat('#,##0.0000', fRetQtdPro(cdsProForBkp, FieldByName('ITESUB').AsString))                      , 12 , alDireita  );
            objLinha.pAddColuna('O.P. em Aberto' , FormatFloat('#,##0.0000', fRetQtdeAProduzir(FieldByName('ITESUB').AsString)) , 14 , alDireita  );
            objTabela.lstLinhas.Add(objLinha);

            Next;
          End;

          objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

          objLiberacao.strDirAce := IIF(ABlnBaixaOpi,'BAIXAOPIMPSEMSALDO' ,'SLD_OI');
          objLiberacao.strSenLib := fCfgSis('SEN_OI');
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.blnUsarSenhaFixa := False;
          objLiberacao.blnSempreVariavelUsuario := True;


          Result := objLiberacao.fLibera;

        {
          if not fVerificaAcessoSistema('SEN_OI', strLoginUsuarioLogado) Then
          Begin

            If ffrmSenha(strSenLib, 'Senha Produtos sem saldo') Then
            Begin
              Result := fVerificaAcessoSistema('SEN_OI',fRetCodVendedor(strSenLib));

              If Not Result Then
                pMensagemOk('A Senha não confere!');

            End

            Else
              Result := False;

          End
          Else
            Result := True;
        }
        End;

      End;
    Finally
      FreeAndNil(cdsProForBkp);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fMostraProdutosSemSaldo]');
    End;
  End;

  With cdsProFor Do
  Begin
    Filtered := False;
    First;
  End;
End;

class function TOrdProIndustrial.fTodasAnalisesReprovadas(AStrSeqOpi: String): Boolean;
var
  qryAux: TUniQuery;
  intCountTodos: Integer;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT                                                ');
    qryAux.SQL.Add('  ANAGER.AUTOINCREM,                                   ');
    qryAux.SQL.Add('  DET_STATUS                                           ');
    qryAux.SQL.Add(' FROM                                                  ');
    qryAux.SQL.Add('  ANAGER                                               ');
    qryAux.SQL.Add(' INNER JOIN ANADET ON DET_SEQGER = ANAGER.AUTOINCREM   ');
    qryAux.SQL.Add(' WHERE TRUE                                            ');
    qryAux.SQL.Add('   AND GER_SEQOPI = :SEQOPI                            ');
    qryAux.SQL.Add('   AND GER_CODEMP = :CODEMP                            ');
    qryAux.SQL.Add('   AND GER_DTABAI IS NOT NULL                          ');

    qryAux.ParamByName('SEQOPI').AsString := AStrSeqOpi;
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;

    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit(False);

    intCountTodos := qryAux.RecordCount;

    qryAux.Filter := 'DET_STATUS = 2';
    qryAux.Filtered := True;

    Result := intCountTodos = qryAux.RecordCount;

  Finally
    FreeAndNIl(qryAux);
  End;
end;

class function TOrdProIndustrial.fDeveGerarAnalise(AStrSeqOpi: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT DISTINCT G.AUTOINCREM           ');
    qryAux.SQL.Add('  FROM                                  ');
    qryAux.SQL.Add(' ORDGER G                               ');
    qryAux.SQL.Add('  INNER JOIN GEIMAT M                   ');
    qryAux.SQL.Add('    ON GMT_CODITE = G.ORD_CODITE        ');
    qryAux.SQL.Add('    AND GMT_CODCOR = G.ORD_CODCOR       ');
    qryAux.SQL.Add('    AND GMT_FORMUL = G.ORD_FORMUL       ');
    qryAux.SQL.Add('  INNER JOIN GEIANA N                   ');
    qryAux.SQL.Add('    ON GAN_SEQGMT = M.AUTOINCREM        ');
    qryAux.SQL.Add('  WHERE G.AUTOINCREM = :SEQOPI          ');
    qryAux.SQL.Add('    AND G.ORD_CODEMP = :CODEMP          ');
    qryAux.ParamByName('SEQOPI').AsString := AStrSeqOpi;
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;

    qryAux.Open;

    Result := Not qryAux.IsEmpty;

  Finally
    FreeAndNIl(qryAux);
  End;
end;

class function TOrdProIndustrial.fNenhumaAnaliseGerada(AStrSeqOpi: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT AUTOINCREM                   ');
    qryAux.SQL.Add('  FROM                               ');
    qryAux.SQL.Add(' ANAGER                              ');
    qryAux.SQL.Add(' WHERE GER_SEQOPI = :SEQOPI          ');
    qryAux.SQL.Add('   AND GER_CODEMP = :CODEMP          ');
    qryAux.ParamByName('SEQOPI').AsString := AStrSeqOpi;
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;

    qryAux.Open;

    Result := qryAux.IsEmpty;

  Finally
    FreeAndNIl(qryAux);
  End;
end;

class function TOrdProIndustrial.fExisteAnaliseAberto(AStrSeqOpi: String; out AStrAnalises: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT GER_CODIGO                      ');
    qryAux.SQL.Add('  FROM                                  ');
    qryAux.SQL.Add(' ANAGER                                 ');
    qryAux.SQL.Add('  WHERE GER_SEQOPI = :SEQOPI            ');
    qryAux.SQL.Add('    AND GER_CODEMP = :CODEMP            ');
    qryAux.SQL.Add('    AND GER_DTABAI IS NULL              ');
    qryAux.ParamByName('SEQOPI').AsString := AStrSeqOpi;
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;

    qryAux.Open;

    Result := Not qryAux.IsEmpty;

    If Result Then
    Begin
      AStrAnalises := 'Análise' + IIF(qryAux.RecordCount > 1,'s','') + ': ';
      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        AStrAnalises := AStrAnalises + qryAux.FieldByName('GER_CODIGO').AsString + IIF(qryAux.Recno = qryAux.RecordCount, '', ', ');
        qryAux.Next;
      End;
    End;
  Finally
    FreeAndNIl(qryAux);
  End;
end;

function TOrdProIndustrial.fOrdemDeProducaoFilha(strAutInc: String): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery(Self);
    With qryConsulta, SQL Do
    Begin
      Add(' SELECT SQL_NO_CACHE COUNT(0) AS QTD ');
      Add(' FROM ORDORI                         ');
      Add(' WHERE ORD_SEQUSA = :SEQUSA          ');

      ParamByName('SEQUSA').AsString := strAutInc;

      Open;

      Result := (FieldByName('QTD').AsInteger > 0);

    End;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

Function TOrdProIndustrial.fSQLAgrLot: String;
Begin
  Result := '';
  Result := Result + ' SELECT LOT_NUMLOT,                             ';
  Result := Result + '        LOT_CODITE,                             ';
  Result := Result + '        LOT_LOCFIS,                             ';
  Result := Result + '        LOC_DESCRI,                             ';
  Result := Result + '        LOT_DTAVAL,                             ';
  Result := Result + '        LOT_SALDOS,                             ';
  Result := Result + '        0.000000 AS ESTUTI                      ';
  Result := Result + ' FROM CADLOT                                    ';
  Result := Result + '   LEFT  JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS ';
  Result := Result + '                    AND LOT_CODEMP = LOC_CODEMP ';
  Result := Result + ' WHERE LOT_CODEMP = :CODEMP                     ';
  Result := Result + '   AND LOT_CODITE = :CODITE                     ';
  Result := Result + '   AND LOT_NUMLOT <> "A DEFINIR"                ';
  Result := Result + '   AND LOT_LOTAPR = "S"                         ';
  Result := Result + '   AND LOT_FULFIL = "N"                         ';
  Result := Result + '   AND LOT_GARPRI = "N"                         ';
  Result := Result + ' ORDER BY LOT_DTAVAL                            ';
End;

Function TOrdProIndustrial.fSQLCabecalhoImpr: String;
Var
  objSQLOrdProdIndustrial: TSQLOrdProdIndustrial;
Begin

  objSQLOrdProdIndustrial:= TSQLOrdProdIndustrial.create;
  Try
    Result:= objSQLOrdProdIndustrial.fSQLCabecalhoImpr;
  Finally
    FreeAndNil(objSQLOrdProdIndustrial);
  End;
End;

Function TOrdProIndustrial.fSQLFormulaIpr(blnDispersao: Boolean = False; blnIncOrdEst : Boolean = False): String;
  Var

    SQLFormulaImpressao: TSQLFormulaImpressao;
    intCfgMdOrin: Integer;

  Function fRetSQLPesBalanca : String;
  Begin
    Result :=          ' IF(SEQUEN < 900,';
    Result := Result + ' IF(SEQPES=1, (SELECT SUM(FDO_QTDITE)                                                             ';
    Result := Result + '               FROM FATDOR                                                                        ';
    Result := Result + '               WHERE FDO_SEQGER = FGO_SEQFGO                                                      ';
    Result := Result + '                 AND FDO_CODITE = ITESUB), NULL),                                                 ';
    Result := Result + ' IF(SEQPES=1, (SELECT SUM(EST_ESTUTI) FROM ORDEST WHERE EST_SEQGER = FGO_SEQFGO), NULL)) / QTDPAR ';
  End;

Begin
  intCfgMdOrin := fCfgSis('MDORIN', varInteger);

  Result := '/* untOrdProIndustrial.fSQLFormulaIpr */ ';
  If blnIncOrdEst Then
  Begin
    Result := Result + ' SELECT SEQUEN,                                           ';
    Result := Result + '        SEQPES,                                           ';
    Result := Result + '        NUMDIS,                                           ';
    Result := Result + '        ORDITE,                                           ';
    Result := Result + '        ITESUB,                                           ';
    Result := Result + '        CODFAS,                                           ';
    Result := Result + '        DISPER,                                           ';
    Result := Result + '        DESITE,                                           ';
    Result := Result + '        ITE_CODITE,                                       ';
    Result := Result + '        ITE_DESITE,                                       ';
    Result := Result + '        QTDPRO,                                           ';
    Result := Result + '        DMT_DENSID,                                       ';
    Result := Result + '        DMT_QTDITE,                                       ';
    Result := Result + '        PERTOL,                                           ';
    Result := Result + '        SIGUNI,                                           ';
    Result := Result + '        RELLOT,                                           ';
    Result := Result + '        LOT_MP,                                           ';
    Result := Result + '        QTDPAR,                                           ';
    Result := Result + '        DESGRU,                                           ';
    Result := Result + '        LOCFIS,                                           ';
    Result := Result + '        DTAVAL,                                           ';
    Result := Result + fRetSQLPesBalanca + ' AS PESBAL,                           ';
    Result := Result + '        (SELECT                                           ';
    Result := Result + '            EQP_DESCRI                                    ';
    Result := Result + '          FROM                                            ';
    Result := Result + '            CADEQP                                        ';
    Result := Result + '          WHERE EQP_CAPACI >= (' + fRetSQLPesBalanca + ') ';
    Result := Result + '          ORDER BY EQP_CAPACI                             ';
    Result := Result + '          LIMIT 1) AS BALANC                              ';

    Result := Result + ' FROM (                                                   ';

  End;

  Result := Result + ' SELECT ';

  If blnIncOrdEst Then
  Begin
    Result := Result + '     @SEQUEN := ODM_SEQUEN AS SEQUEN,                                      ';
    Result := Result + '     IF(@ULTITE <> @SEQUEN, 1, 0) AS SEQPES,                               ';
    Result := Result + '     IF(@ULTITE <> @SEQUEN, @ULTITE := @SEQUEN, @ULTITE := @ULTITE),       ';
  End
  Else
  If fCfgSis('MDORIN') = '6' Then
    Result := Result + '   IF(D.AUTOINCREM IS NULL, D2.AUTOINCREM, ODM_SEQUEN) AS SEQUEN,      '
  Else
    Result := Result + '   ODM_SEQUEN   AS SEQUEN,                                                 ';

  Result := Result + '   "   "        AS NUMDIS,                                                   ';
  Result := Result + '   "   "        AS ORDITE,                                                   ';
  Result := Result + '   D.ODM_ITESUB AS ITESUB,                                                   ';
  Result := Result + '   D.ODM_CODFAS AS CODFAS,                                                   ';
  Result := Result + '   FS.FAS_DESFAS,                                                             ';
  Result := Result + '   IF(IFNULL(D.ODM_CODFAS, "") = @FASDIS, "S", "N") AS DISPER,               ';




  //O MODELO 8 É IGUAL O MODELO 1, POREM EXIBE A DESCRIÇÃO E NAO A REFERENCIA.
  If (fCfgSis('MDORIN', varInteger) = 8)  OR
     (fCfgSis('MDORIN', varInteger) = 19) OR
     (fCfgSis('MDORIN', varInteger) = 15) OR
     (fCfgSis('MDORIN', varInteger) = 10) OR
     (fCfgSis('MDORIN', varInteger) = 20) OR
     (fCfgSis('MDORIN', varInteger) = 22) OR
     (fCfgSis('MDORIN', varInteger) = 29) Then
    Result := Result + '   IF(F.ITE_CODITE IS NULL, D.ODM_DESCRI, F.ITE_DESITE) AS DESITE,           '
  Else if fCfgSis('MDORIN', varInteger) = 24 Then
    Result := Result + '   F.ITE_DESITE AS DESITE,           '
  Else if (fCfgSis('MDORIN', varInteger) = 32) Or (fCfgSis('MDORIN', varInteger) = 39) Then
  Begin
    if fCfgSis('DESMAT', varString) = 'D' then
      Result := Result + '   IF(F.ITE_CODITE IS NULL, D.ODM_DESCRI, F.ITE_DESITE) AS DESITE,         '
    else
      Result := Result + '   IF(F.ITE_CODITE IS NULL, D.ODM_DESCRI, F.ITE_REFERE) AS DESITE,         ';
  End

  Else
    Result := Result + '   IF(F.ITE_CODITE IS NULL, D.ODM_DESCRI, F.ITE_REFERE) AS DESITE,           ';

  Result := Result + '   F.ITE_CODITE AS ITE_CODITE,                                               ';
  Result := Result + '   F.ITE_DESITE AS ITE_DESITE,                                               ';
  Result := Result + '   ODM_PERTOL AS PERTOL,                                                     ';
  Result := Result + '   UNI_SIGUNI AS SIGUNI,                                                     ';
  Result := Result + '   " " AS RELLOT,                         ';

  {If Pos(fCfgSis('MDORIN', varInteger),'5_9_11_18_20_21_28_30') > 0 Then}
  Case intCfgMdOrin of
    4,5,9,11,18,20,21,28,30:
                            Begin
                              Result := Result + '   IF(F.ITE_CODITE IS NULL, NULL, FDO_QTDITE) AS QTDPRO,                   ';
                              Result := Result + '   IF( F.ITE_DENSID > 0, FDO_QTDITE / ITE_DENSID, 0 ) AS DMT_DENSID,       ';
                              Result := Result + '   ODM_QTDITE AS DMT_QTDITE,                                               ';
                              Result := Result + '   FDO_NUMLOT AS LOT_MP,                                                   ';
                              If blnIncOrdEst Then
                                Result := Result + ' @QTDPAR := ORD_QTDPAR AS QTDPAR,                                        '
                              Else
                                Result := Result + '   ORD_QTDPAR AS QTDPAR,                                                 ';

                              Result := Result + '   GRU_DESGRU AS DESGRU,                                                   ';

                              If (fCfgSis('MDORIN', varInteger) = '4') Then
                                Result := Result + '   IFNULL(LOT_LOCFIS, I.ITE_LOCFIS) AS LOCFIS,                           '
                              Else
                                Result := Result + '   LOT_LOCFIS AS LOCFIS,                                                 ';

                              Result := Result + '   LOT_DTAVAL AS DTAVAL,                                                   ';

                              If (Not blnIncOrdEst) Then Begin
                                Result := Result + '   ""         AS PESBAL,                                                 ';
                                Result := Result + '   ""         AS BALANC,                                                 ';
                              End;

                              Result := Result + '   FGO_SEQFGO                                                              ';
                            End
                            Else
                            Begin
                              Result := Result + '   IF(F.ITE_CODITE IS NULL, NULL, (ODM_QTDITE / 100) * @PESTOT) AS QTDPRO, ';
                              Result := Result + '   IF( F.ITE_DENSID > 0, ODM_QTDITE / ITE_DENSID, 0 ) AS DMT_DENSID,       ';
                              Result := Result + '   ODM_QTDITE AS DMT_QTDITE,                                               ';
                              Result := Result + '   ODL_NUMLOT AS LOT_MP                                                    ';
                            End;
  End;

  Result := Result + ' ,FOR_NOMFOR AS NOMFOR                                                       ';
  Result := Result + ' ,F.ITE_PESOIT AS PESOIT                                                     ';


  If (intCfgMdOrin = 31) Then
    Result := Result + ' ,F.ITE_DESITE AS DESITE_IMP                                               ';


  Result := Result + ' FROM ORDGER GR                                                              ';
  Result := Result + ' LEFT JOIN ORDMAT D ON ODM_SEQGER = GR.AUTOINCREM                            ';
  Result := Result + ' LEFT JOIN CADITE F ON F.ITE_CODITE = D.ODM_ITESUB                           ';
  Result := Result + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI                                 ';
  Result := Result + ' LEFT JOIN CADFAS FS ON  (FS.FAS_CODFAS = ODM_CODFAS)                              ';
  Result := Result + ' LEFT JOIN CADFOR FO ON FO.FOR_CODFOR = F.ITE_CODFOR                         ';

  {If Pos(fCfgSis('MDORIN', varInteger),'5_9_11_18_20_21_28_30') > 0 Then}
  Case intCfgMdOrin of
    4,5,9,11,18,20,21,28,30:Begin
                              Result := Result + ' LEFT JOIN ODMFDO ON ODF_SEQORD = GR.AUTOINCREM AND ODF_SEQUEN = ODM_SEQUEN    ';
                              Result := Result + ' LEFT JOIN CADGRU ON GRU_CODGRU = CONCAT(LEFT(F.ITE_CODGRU,3),"000")           ';
                              Result := Result + ' LEFT JOIN EXTGOR ON FGO_ORDIND = GR.AUTOINCREM                                ';
                              Result := Result + ' LEFT JOIN FATDOR ON FDO_SEQGER = FGO_SEQFGO                                   ';
                              Result := Result + '                 AND FDO_CODITE = D.ODM_ITESUB                                 ';
                              Result := Result + '                 AND FATDOR.AUTOINCREM = IFNULL(ODF_SEQFDO, FATDOR.AUTOINCREM) ';
                              Result := Result + ' LEFT JOIN CADLOT ON LOT_CODITE = FDO_CODITE                                   ';
                              Result := Result + '                 AND LOT_NUMLOT = FDO_NUMLOT                                   ';
                              Result := Result + '                 AND LOT_CODEMP = IFNULL(IFNULL(FGO_EMP_TE, IFNULL(FGO_EMP_CD, FDO_EMPITE)),FDO_CODEMP) ';

                              If (fCfgSis('MDORIN', varInteger) = '4') Then
                                Result := Result + ' LEFT JOIN ITEGER I ON I.ITE_CODITE = F.ITE_CODITE AND I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

                            End
                            Else
                            Begin
                              Result := Result + ' LEFT JOIN ORDLOT ON ODL_SEQGER = GR.AUTOINCREM                            ';
                              Result := Result + '                 AND ODL_CODITE = D.ODM_ITESUB                             ';
                            End;
  End;

  If fCfgSis('MDORIN') = 6 Then
    Result := Result + '   LEFT JOIN ORDDET D2 ON ORD_SEQGER  = GR.AUTOINCREM AND D2.ORD_CODITE = D.ODM_ITESUB ';

  Result := Result + ' WHERE  ';

  If blnDispersao Then
  Begin
    Result := Result + '   FALSE ';
  End
  Else
  begin
    Result := Result + '      GR.AUTOINCREM = @AUTINC ';
    If fCfgSis('MDORIN') = 6 Then
    Begin
      Result := Result + ' AND IF((SELECT GMT_FORESP FROM GEIMAT WHERE GMT_CODITE = GR.ORD_CODITE ';
      Result := Result + '         AND GMT_CODCOR = GR.ORD_CODCOR AND GMT_FORMUL = GR.ORD_FORMUL) = 1 ';
      Result := Result + '        ,IFNULL(D.AUTOINCREM, "") = "", D.ODM_TIPOMP = "FOR" AND ODM_SEQUEN <> "9999") ';
    End
    Else
      Result := Result + '  AND  D.ODM_TIPOMP = "FOR" '
  end;

  If fCfgSis('MDORIN') <> 6 Then
  Begin
    SQLFormulaImpressao:= TSQLFormulaImpressao.Create;
    Try
      Result := Result + SQLFormulaImpressao.fRetornaSQLItemFormulaImpressao;
    Finally
      FreeAndNil(SQLFormulaImpressao);
    End;
  End;


  If blnIncOrdEst Then
  Begin
    Result := Result + ' UNION ALL ';

    Result := Result + ' SELECT IF(@SEQUEN < 900, @SEQUEN := 999, @SEQUEN := @SEQUEN+1), ';  //  1  SEQUEN
    Result := Result + '        IF(@SEQUEN = 999, 1, 0) AS SEQPES,      ';                  //  2  SEQPES
    Result := Result + '        @SEQUEN,                                ';                  //  3  (col sem alias)
    Result := Result + '        "   ",                                  ';                  //  4  NUMDIS
    Result := Result + '        NULL,                                   ';                  //  5  ORDITE
    Result := Result + '        EST_CODITE,                             ';                  //  6  ITESUB
    Result := Result + '        NULL,                                   ';                  //  7  CODFAS
    Result := Result + '        NULL,                                   ';                  //  8  FAS_DESFAS
    Result := Result + '        "S",                                    ';                  //  9  DISPER
    Result := Result + '        ITE_REFERE,                             ';                  // 10  DESITE
    Result := Result + '        NULL,                                   ';                  // 11  ITE_CODITE
    Result := Result + '        NULL,                                   ';                  // 12  ITE_DESITE
    Result := Result + '        NULL,                                   ';                  // 13  PERTOL      <-- ADICIONADO
    Result := Result + '        UNI_SIGUNI,                             ';                  // 14  SIGUNI      <-- ADICIONADO
    Result := Result + '        " ",                                    ';                  // 15  RELLOT      <-- ADICIONADO
    Result := Result + '        EST_ESTUTI,                             ';                  // 16  QTDPRO
    Result := Result + '        0,                                      ';                  // 17  DMT_DENSID
    Result := Result + '        0,                                      ';                  // 18  DMT_QTDITE
    Result := Result + '        EST_NUMLOT,                             ';                  // 19  LOT_MP
    Result := Result + '        @QTDPAR,                                ';                  // 20  QTDPAR
    Result := Result + '        GRU_DESGRU,                             ';                  // 21  DESGRU
    Result := Result + '        LOT_LOCFIS,                             ';                  // 22  LOCFIS
    Result := Result + '        LOT_DTAVAL,                             ';                  // 23  DTAVAL
    Result := Result + '        EST_SEQGER,                             ';                  // 24  FGO_SEQFGO

    Result := Result + '        FOR_NOMFOR AS NOMFOR,                   ';                  // 25  NOMFOR
    Result := Result + '        CADITE.ITE_PESOIT AS PESOIT             ';                  // 26  PESOIT
    Result := Result + ' FROM ORDEST                                    ';
    Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = EST_CODITE ';
    Result := Result + '   INNER JOIN CADFOR FO ON FOR_CODFOR = CADITE.ITE_CODFOR ';
    Result := Result + '   INNER JOIN CADGRU ON GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU,3),"000") ';
    Result := Result + '    LEFT JOIN CADUNI ON UNI_CODUNI = CADITE.ITE_CODUNI ';   // <-- ADICIONADO (para UNI_SIGUNI)
    Result := Result + '   INNER JOIN CADLOT ON LOT_CODITE = EST_CODITE ';
    Result := Result + '                    AND LOT_NUMLOT = EST_NUMLOT ';
    Result := Result + '                    AND LOT_CODEMP = EST_CODEMP ';
    Result := Result + '   LEFT  JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS ';
    Result := Result + '                    AND LOT_CODEMP = LOC_CODEMP ';
    Result := Result + ' WHERE EST_SEQGER =  @AUTINC                    ';
  End;

  If blnIncOrdEst Then
    Result := Result + ' ORDER BY SEQUEN, SEQPES DESC  '
  Else
    Result := Result + ' ORDER BY SEQUEN ';

  If blnIncOrdEst Then
    Result := Result + '  ) AS TMP ORDER BY SEQUEN, SEQPES DESC ';

End;

Procedure TOrdProIndustrial.pCabecalhoImpressao(strAutInc: String);
Begin
  With cdsCabIpr, qryQuery Do
  Begin
    qryQuery.Close;
    ParamByName('AUTINC').AsString := strAutInc;

    cdsCabIpr.fAbreClient(True, 'TOrdProIndustrial.pCabecalhoImpressao');
  End;
End;

Procedure TOrdProIndustrial.pCabecalhoImpressaoProdutoB(strAutInc: String);
Begin
  With cdsCabIpB, qryQuery Do
  Begin
    qryQuery.Close;
    ParamByName('AUTINC').AsString := strAutInc;

    cdsCabIpB.fAbreClient(True, 'TOrdProIndustrial.pCabecalhoImpressaoProdutoB');
  End;
End;

Procedure TOrdProIndustrial.pProdutosFormulaImpressao(strAutInc: String; blnUtiEst : Boolean = False);
Var
  intPosicao: Integer;
  qrySetVar : TUniQuery;
  strSQL    : String;
Begin
  With cdsDmtIpr, qryQuery Do
  Begin
    qryQuery.Close;

    strSQL := '';
    strSQL := strSQL + ' SET @AUTINC = :AUTINC;  ';
    strSQL := strSQL + ' SET @PESTOT = :PESTOT;  ';
    strSQL := strSQL + ' SET @FASDIS = :FASDIS;  ';
    strSQL := strSQL + ' SET @SEQUEN = 0;        ';
    strSQL := strSQL + ' SET @ULTITE = "";       ';

    Try
      qrySetVar := fCriaQuery;
      qrySetVar.SQL.Text := strSQL;

      qrySetVar.ParamByName('AUTINC').AsString := strAutInc;
      If qrySetVar.FindParam('PESTOT') <> Nil Then
        qrySetVar.ParamByName('PESTOT').AsFloat := fGetPesoProducao;
      qrySetVar.ParamByName('FASDIS').AsString := fCfgSis('FASDIS');
      qrySetVar.ExecSQL;
    Finally
      FreeAndNil(qrySetVar);
    End;

    If blnUtiEst Then
    Begin
      qryQuery.SQL.Clear;
      qryQuery.SQL.Text := fSQLFormulaIpr(False, True);

      If cdsDisIpr.Active Then
        cdsDisIpr.EmptyDataSet;
      cdsDisIpr.qryQuery.SQL.Clear;
      cdsDisIpr.qryQuery.SQL.Add(fSQLFormulaIpr(True, True))

    End;

    If cdsDmtIpr.FindField('TOT_QTDPRO') = Nil Then
      cdsDmtIpr.pCriaSoma('QTDPRO', 'TOT_QTDPRO');

    cdsDmtIpr.fAbreClient(True, 'TOrdProIndustrial.pProdutosFormulaImpressao');
    If (fCfgSis('MDORIN', varInteger) = 17) Or (fCfgSis('MDORIN', varInteger) = 33) Then
     cdsDmtIpr.IndexFieldNames := 'SEQUEN;CODFAS'
    Else
      cdsDmtIpr.IndexFieldNames := 'SEQUEN';

  End;

  intPosicao := 0;
  With cdsDmtIpr Do
  Begin
    First;
    While Not Eof Do
    Begin

      If FieldByName('QTDPRO').AsFloat > 0 Then
      Begin
        inc(intPosicao);
        Edit;
        FieldByName('ORDITE').AsString := fStrZero(IntToStr(intPosicao), 2);
        Post;
      End;

      Next;
    End;

    First;
  End;

  If recImpres.blnFasDis or FEditorRelatorios Then
    pMontaDispersao;

End;

Procedure TOrdProIndustrial.pMontaDispersao;
Var
  intDispersao, intOrdIte, intCampos: Integer;
  fltQtdRes: Double;
Begin
  Try
    If Not cdsDisIpr.IsEmpty Then // JA MONTOU
      Exit;

    If FEditorRelatorios Then
      recImpres.intQtdFas := 1;

    If recImpres.intQtdFas <= 0 Then
      Exit;

    cdsDmtIpr.Filter := 'CODFAS = ' + QuotedStr(fCfgSis('FASDIS'));
    cdsDmtIpr.Filtered := True;

    If Not cdsDisIpr.fAbreClient(True, 'TOrdProIndustrial.pMontaDispersao') Then
      Exit;

    With cdsDisIpr Do
    Begin

      cdsDmtIpr.First;

      intOrdIte := 0;

      While Not cdsDmtIpr.Eof Do
      Begin
        If cdsDmtIpr.FieldByName('QTDPRO').AsFloat > 0 Then
          inc(intOrdIte);

        fltQtdRes := cdsDmtIpr.FieldByName('QTDPRO').AsFloat;

        For intDispersao := 1 To recImpres.intQtdFas Do
        Begin

          Insert;

          For intCampos := 0 To cdsDmtIpr.Fields.Count - 1 Do
            Fields[intCampos].Value := cdsDmtIpr.Fields[intCampos].Value;

          FieldByName('NUMDIS').AsString := fStrZero(IntToStr(intDispersao), 3);

          If cdsDmtIpr.FieldByName('QTDPRO').AsFloat > 0 Then
            FieldByName('ORDITE').AsString := fStrZero(IntToStr(intOrdIte), 2);

          If intDispersao = recImpres.intQtdFas Then
            FieldByName('QTDPRO').AsFloat := fltQtdRes
          Else
            FieldByName('QTDPRO').AsFloat := RoundTo(cdsDmtIpr.FieldByName('QTDPRO').AsFloat / recImpres.intQtdFas, intCasasDecimaisMateriaPrima* -1);

          Post;

          fltQtdRes := fltQtdRes - FieldByName('QTDPRO').AsFloat;

        End;

        cdsDmtIpr.Next;
      End;

      IndexFieldNames := 'NUMDIS;SEQUEN';

      First;
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TOrdProIndustrial.pMontaDispersao]');
    End;

  End;

  cdsDmtIpr.Filtered := False;
  cdsDmtIpr.First;
End;

Function TOrdProIndustrial.fRetProdutoGranel(strAutInc: String): String;
Begin
  Result := fCampoTabela('ORD_CODITE', 'ORDGER', ['AUTOINCREM'], [strAutInc]);
End;

Function TOrdProIndustrial.fRetCorProducao(strAutInc: String): String;
Begin
  Result := fCampoTabela('ORD_CODCOR', 'ORDGER', ['AUTOINCREM'], [strAutInc]);
End;

Procedure TOrdProIndustrial.pProdutosAcabadosImpressao(strAutInc: String);
Begin
  qryQuery.Close;
  qryQuery.SQL.Text := fSQLOrdPro(True);

  fCarregaItens(strAutInc, fRetProdutoGranel(strAutInc), fRetCorProducao(strAutInc), True);

  Self.IndexFieldNames := 'DESITE';
  Self.First;

  While Not Eof Do
  Begin
    Edit;
    FieldByName('ORDITE').AsString := fStrZero(IntToStr(Self.RecNo), 2);
    Post;

    Next;
  End;

  Self.First;
End;

function TOrdProIndustrial.fExisteNivelInferiorSemBaixa(strAutoincrem
  : String): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  Result := False;
  if not FGeraOpSubProdutos then
    Exit;

  Try
    qryConsulta := fCriaQuery(Self);
    With qryConsulta, SQL do
    Begin

      Add('SELECT ORDGER.AUTOINCREM,                   ');
      Add('       ORD_DTABAI                           ');
      Add('FROM ORDORI                                 ');
      Add('  LEFT JOIN ORDGER                          ');
      Add(' ON ORDGER.AUTOINCREM = ORDORI.ORD_SEQUSA   ');
      Add('WHERE ORD_SEQGER = :AUTO                    ');

      ParamByName('AUTO').AsString := strAutoincrem;

      Open;

      if RecordCount <= 0 then
      Begin
        Result := False;
      End
      Else
      Begin
        While (not Eof) and (not Result) do
        Begin
          if FieldByName('ORD_DTABAI').IsNull then
          Begin
            Result := True;
            Break;
          End
          Else
          Begin
            Result := fExisteNivelInferiorSemBaixa
              (FieldByName('AUTOINCREM').AsString)
          End;
          Next;
        End;

      End;

    End;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TOrdProIndustrial.fExisteNivelInferior(strAutoincrem: String): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  Result := False;
  if not FGeraOpSubProdutos then
    Exit;

  Try
    qryConsulta := fCriaQuery(Self);
    With qryConsulta, SQL do
    Begin

      Add('SELECT ORDGER.AUTOINCREM,                 ');
      Add('       ORD_DTABAI                         ');
      Add('FROM ORDORI                               ');
      Add('  LEFT JOIN ORDGER                        ');
      Add(' ON ORDGER.AUTOINCREM = ORDORI.ORD_SEQUSA ');
      Add('WHERE ORD_SEQGER = :AUTO                  ');

      ParamByName('AUTO').AsString := strAutoincrem;

      Open;

      Result := (RecordCount > 0);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

End;

Function TOrdProIndustrial.fCarregaCabecalhoOP(strAutOPI: String): Boolean;
Begin
  Try
    Result := False;

    If Not fEmptyStr(strAutOPI) Then
    Begin
      pCabecalhoImpressao(strAutOPI);
      pProdutosAcabadosImpressao(strAutOPI);
      pProdutosFormulaImpressao(strAutOPI);
      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fCarregaCabecalhoOP]');
    End;
  End;
End;

Function TOrdProIndustrial.fCarregaCabecalhoOProdutoB(strAutOPI: String): Boolean;
Begin
  Try
    Result := False;

    If Not fEmptyStr(strAutOPI) Then
    Begin
      pCabecalhoImpressaoProdutoB(strAutOPI);
      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fCarregaCabecalhoOProdutoB]');
    End;
  End;
End;


Function TOrdProIndustrial.fCarregaCabecalhoOP(strCodOPI: String; dtaDtaCad: TDate): Boolean;
  Var
    strAutOPI: String;

    Function fRetAutoInc: String;
      Var
        qryOrdGer: TUniQuery;
    Begin
      qryOrdGer := fCriaQuery;
      With qryOrdGer, SQL Do
      Begin
        Add('SELECT AUTOINCREM FROM  ORDGER WHERE ORD_CODORD = :CODORD AND ORD_DTACAD = :DTACAD AND ORD_CODEMP = :CODEMP');

        ParamByName('CODORD').AsString   := strCodOPI;
        ParamByName('DTACAD').AsDateTime := dtaDtaCad;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        Open;

        Result := FieldByName('AUTOINCREM').AsString;
        Close;
      End;

      FreeAndNil(qryOrdGer);
    End;

Begin
  Try
    strAutOPI := fRetAutoInc;

    Result := fCarregaCabecalhoOP(strAutOPI);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fCarregaCabecalhoOP]');
    End;
  End;
End;

Function TOrdProIndustrial.fCarregaCabecalhoOProdutoB(strCodOPI: String; dtaDtaCad: TDate): Boolean;
  Var
    strAutOPI: String;

    Function fRetAutoInc: String;
      Var
        qryOrdGer: TUniQuery;
    Begin
      qryOrdGer := fCriaQuery;
      With qryOrdGer, SQL Do
      Begin
        Add('SELECT AUTOINCREM FROM  ORDGER WHERE ORD_CODORD = :CODORD AND ORD_DTACAD = :DTACAD AND ORD_CODEMP = :CODEMP');

        ParamByName('CODORD').AsString   := strCodOPI;
        ParamByName('DTACAD').AsDateTime := dtaDtaCad;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        Open;

        Result := FieldByName('AUTOINCREM').AsString;
        Close;
      End;

      FreeAndNil(qryOrdGer);
    End;

Begin
  Try
    strAutOPI := fRetAutoInc;

    Result := fCarregaCabecalhoOProdutoB(strAutOPI);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fCarregaCabecalhoOProdutoB]');
    End;
  End;
End;











Function TOrdProIndustrial.fCarregaOPMonitoramento(strCodBar: String): Boolean;
  Var
    strAutOPI: String;
Begin
  Try
    strAutOPI := fCampoTabela('AUTOINCREM', 'ORDGER', ['ORD_CODBAR'], [strCodBar]);

    If fEmptyStr(strAutOPI) Then
    Begin
      Result := False;
      pMensagemOk('Ordem de produção não encontrada!');
      Exit;
    End;

    pCabecalhoImpressao(strAutOPI);

    If Not cdsCabIpr.FieldByName('DTABAI').IsNull Then
    Begin
      Result := False;
      pMensagemOk('Ordem de produção já baixada!');
      Exit;
    End;

    pProdutosAcabadosImpressao(strAutOPI);
    pProdutosFormulaImpressao(strAutOPI);

    If Not Assigned(objMonitor) Then
      objMonitor := TOrdProIndMonitoramento.Create(Self);

    Result := objMonitor.fCarregaFases(strAutOPI);

    If Result Then
    Begin
      objMonitor.cdsCabIpr := cdsCabIpr;
      objMonitor.fltVolume := fRetSoma('VOLUME');
    End

    Else
      pMensagemOk('Não há fases cadastradas para essa O.P.!');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fCarregaOPMonitoramento]');
    End;
  End;
End;

Procedure TOrdProIndustrial.pImprimeEtiqueta(AStrCodIte: String = '');
  Var
    strNomImp, strTipImp: String;
    prmDllEtq: TParamDllEtiquetas;
    qryUpdate: TUniQuery;
    cdsIteEti: TUniClientDataSet;
    qryEti   : TUniQuery;
    i : Integer;
    arrLayoutsSelecionados: TArrString;

  Procedure pGeraItensImpressao;
  Var
    intQtdEti: Integer;
  Begin
    With qryEti Do
    Begin

      While Not Eof Do
      Begin
        For intQtdEti := 1 To Trunc(FieldByName('QTDETI').AsFloat) Do
        Begin
          cdsIteEti.Insert;

          cdsIteEti.FieldByName('DESITE').AsString := FieldByName('DESETI').AsString;
          cdsIteEti.FieldByName('DESCRI').AsString := FieldByName('DESCRI').AsString;
          cdsIteEti.FieldByName('DESCOR').AsString := FieldByName('DESCOR').AsString;
          cdsIteEti.FieldByName('CODBAR').AsString := FieldByName('CODBAR').AsString;
          cdsIteEti.FieldByName('CODFAB').AsString := FieldByName('CODFAB').AsString;
          cdsIteEti.FieldByName('NUMLOT').AsString := FieldByName('NUMLOT').AsString;
          cdsIteEti.FieldByName('LOTRAS').AsString := FieldByName('LOTRAS').AsString;
          cdsIteEti.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;

          cdsIteEti.FieldByName('DTAVAL').AsString := FieldByName('DTAVAL').AsString;
          cdsIteEti.FieldByName('VALITE').AsString := FieldByName('VALITE').AsString;
          cdsIteEti.FieldByName('AUTOIN').AsString := FieldByName('AUTOIN').AsString;

          cdsIteEti.FieldByName('REFERE').AsString := FieldByName('REFERE').AsString;
          cdsIteEti.FieldByName('SIGUNI').AsString := FieldByName('SIGUNI').AsString;
          cdsIteEti.FieldByName('DESUNI').AsString := FieldByName('DESUNI').AsString;
          cdsIteEti.FieldByName('DREUNI').AsString := FieldByName('DREUNI').AsString;
          cdsIteEti.FieldByName('DETUNI').AsString := FieldByName('DETUNI').AsString;
          cdsIteEti.FieldByName('DESFAB').AsString := FieldByName('DESFAB').AsString;
          cdsIteEti.FieldByName('DETLIN').AsString := FieldByName('DETLIN').AsString;
          cdsIteEti.FieldByName('DETGRU').AsString := FieldByName('DETGRU').AsString;
          cdsIteEti.FieldByName('BAREMB').AsString := FieldByName('BAREMB').AsString;
          cdsIteEti.FieldByName('SGETGR').AsString := FieldByName('SGETGR').AsString;

          cdsIteEti.FieldByName('CODCLI').AsString := FieldByName('CODCLI').AsString;
          cdsIteEti.FieldByName('NOMCLI').AsString := FieldByName('NOMCLI').AsString;
          cdsIteEti.FieldByName('NUMDOC').AsString := FieldByName('NUMDOC').AsString;
          cdsIteEti.FieldByName('DTAPRE').AsString := FieldByName('DTAPRE').AsString;
          cdsIteEti.FieldByName('PESOIT').AsFloat  := FieldByName('PESOIT').AsFloat;
          cdsIteEti.FieldByName('PESLIQ').AsFloat  := FieldByName('PESLIQ').AsFloat;
          cdsIteEti.FieldByName('QTDLAY').AsFloat  := FieldByName('QTDLAY').AsFloat;
          cdsIteEti.FieldByName('QTDETI').AsFloat  := FieldByName('QTDETI').AsFloat;

          cdsIteEti.FieldByName('COMP01').AsString  := FieldByName('COMP01').AsString;
          cdsIteEti.FieldByName('COMP02').AsString  := FieldByName('COMP02').AsString;
          cdsIteEti.FieldByName('COMP03').AsString  := FieldByName('COMP03').AsString;
          cdsIteEti.FieldByName('COMP04').AsString  := FieldByName('COMP04').AsString;
          cdsIteEti.FieldByName('COMP05').AsString  := FieldByName('COMP05').AsString;
          cdsIteEti.FieldByName('COMP06').AsString  := FieldByName('COMP06').AsString;
          cdsIteEti.FieldByName('COMP07').AsString  := FieldByName('COMP07').AsString;
          cdsIteEti.FieldByName('COMP08').AsString  := FieldByName('COMP08').AsString;
          cdsIteEti.FieldByName('COMP09').AsString  := FieldByName('COMP09').AsString;
          cdsIteEti.FieldByName('COMP10').AsString  := FieldByName('COMP10').AsString;
          cdsIteEti.FieldByName('PRAVAL').AsInteger  := FieldByName('PRAVAL').AsInteger;
          cdsIteEti.FieldByName('DTACAD').AsString  := FieldByName('DTACAD').AsString;
          cdsIteEti.FieldByName('COMPLE').AsString  := FieldByName('COMPLE').AsString;

          cdsIteEti.Post;
        End;

        Next;
      End;

      pSetLayoutEtiqueta(cdsIteEti, arrLayoutsSelecionados);

      First;

      EnableControls;
    End;
  End;

Begin
  Try
   Try
     qryEti := fCriaQuery(Nil);
     With qryEti, SQL Do
     Begin
       Close;
       Clear;
       Add(' SELECT SQL_NO_CACHE DISTINCT                                                                        ');
       Add('  IF(D.ORD_IMPETI = "S", "N", "S") AS MARDES,                                                        ');
       Add('  D.ORD_CODITE   AS CODITE,                                                                          ');
       Add('  ORD_QTDPRO     AS QTDPRO,                                                                          ');
       Add('  ORD_QTDPRO + ' + fCfgSis('QTDAMO', varString) + '   AS QTDETI,                                     ');
       Add('  IFNULL(FATDOR.FDO_DESCRI,CADITE.ITE_DESITE) AS DESITE,                                             ');
       Add('  CADITE.ITE_DESITE AS DESCRI,                                                                       ');
       Add('  CONCAT(IFNULL(GRU_DETLIN, ""), " ",                                                                ');
       Add('         IFNULL(GRU_DETGRU, ""), " ",                                                                ');
       Add('         IFNULL(UNI_DETUNI, "")) AS DESETI,                                                          ');
       Add('  GRU_DETGRU AS DETGRU,                                                                              ');
       Add('  GRU_DETLIN AS DETLIN,                                                                              ');
       Add('  GRU_SGETGR AS SGETGR,                                                                              ');
       Add('  ITE_CODBAR     AS CODBAR,                                                                          ');
       Add('  ITE_CODFAB     AS CODFAB,                                                                          ');
       Add('  UNI_SIGUNI     AS SIGUNI,                                                                          ');
       Add('  UNI_DETUNI     AS DETUNI,                                                                          ');
       Add('  UNI_PESLIT     AS PESLIT,                                                                          ');
       Add('  D.AUTOINCREM   AS AUTOIN,                                                                          ');
       Add('  D.ORD_IMPETI   AS IMPETI,                                                                          ');
       Add('  (UNI_PESLIT * ORD_QTDPRO) AS VOLUME,                                                               ');
       Add('  CONCAT(DATE_FORMAT(ORD_DTACAD,"%d%m%y"), ORD_CODORD) AS NUMLOT,                                    ');
       Add('  CONCAT(D.ORD_CODITE, DATE_FORMAT(ORD_DTACAD, "%d%m%y"), ORD_CODORD) AS LOTRAS,                     ');
       Add('  COR_DESCOR AS DESCOR,                                                                              ');
       Add('  ITE_REFERE AS REFERE,                                                                              ');
       Add('  UNI_SIGUNI AS SIGUNI,                                                                              ');
       Add('  UNI_DESUNI AS DESUNI,                                                                              ');
       Add('  UNI_DREUNI AS DREUNI,                                                                              ');
       Add('  UNI_DETUNI AS DETUNI,                                                                              ');
       Add('  GRU_DETGRU AS DETGRU,                                                                              ');
       Add('  ITE_BAREMB AS BAREMB,                                                                              ');
       Add('  GRU_SGETGR AS SGETGR,                                                                              ');
       Add('  FDO_CODCLI AS CODCLI,                                                                              ');
       Add('  CLI_NOMCLI AS NOMCLI,                                                                              ');
       Add('  FDO_NUMDOC AS NUMDOC,                                                                              ');
       Add('  ORD_DTAPRE AS DTAPRE,                                                                              ');
       Add('  ITE_PESOIT AS PESOIT,                                                                              ');
       Add('  ITE_DESFAB AS DESFAB,                                                                            ');
       Add('  IFNULL(LOT_LOCFIS,"") AS LOCFIS,                                                                   ');
       Add('  ITE_PESLIQ AS PESLIQ,                                                                              ');
       Add('  ORDGER.ORD_DTAVAL AS VALITE,                                                                       ');
       Add('  DATE_FORMAT(ORD_DTAVAL, "%m/%Y") AS DTAVAL,                                                        ');
       Add('  (SELECT COUNT(0) FROM LAYITE WHERE LAY_CODITE = D.ORD_CODITE) AS QTDLAY,                           ');
       Add('  ETI_COMP01 AS COMP01,                                                                              ');
       Add('  ETI_COMP02 AS COMP02,                                                                              ');
       Add('  ETI_COMP03 AS COMP03,                                                                              ');
       Add('  ETI_COMP04 AS COMP04,                                                                              ');
       Add('  ETI_COMP05 AS COMP05,                                                                              ');
       Add('  ETI_COMP06 AS COMP06,                                                                              ');
       Add('  ETI_COMP07 AS COMP07,                                                                              ');
       Add('  ETI_COMP08 AS COMP08,                                                                              ');
       Add('  ETI_COMP09 AS COMP09,                                                                              ');
       Add('  ETI_COMP10 AS COMP10,                                                                              ');
       Add('  ITE_PRAVAL AS PRAVAL,                                                                              ');
       Add('  ORD_DTACAD AS DTACAD,                                                                              ');
       Add('  ""  AS LAYOUT,                                                                                     ');
       Add('  CAST("" AS CHAR(100))   AS SEQDET,                                                                 ');
       Add('  FDO_COMPLE AS COMPLE                                                                               ');
       Add(' FROM                                                                                                ');
       Add('   ORDDET D                                                                                          ');
       Add('  INNER JOIN CADITE ON ITE_CODITE = D.ORD_CODITE                                                     ');
       Add('  INNER JOIN CADCOR ON ITE_CODCOR = COR_CODCOR                                                       ');
       Add('  INNER JOIN CADGRU ON ITE_CODGRU = GRU_CODGRU                                                       ');
       Add('  INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI                                                       ');
       Add('  INNER JOIN ORDGER ON ORDGER.AUTOINCREM = D.ORD_SEQGER                                              ');

       Add('  LEFT  JOIN EXTDOR ON FDO_SEQOPI = ORDGER.AUTOINCREM                                                ');
       Add('  LEFT  JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO                                                ');
       Add('  LEFT  JOIN CADCLI ON CLI_CODCLI = FDO_CODCLI                                                       ');
       Add('  LEFT  JOIN CADLOT ON LOT_CODITE = FDO_CODITE                                                       ');
       Add('                       AND LOT_NUMLOT = FDO_NUMLOT                                                   ');
       Add('                       AND LOT_CODEMP = FDO_CODEMP                                                   ');

       Add('  LEFT JOIN COMETI    ON ETI_CODITE = ITE_CODITE                                                   ');

       Add(' WHERE                                                                                               ');
       Add('   D.ORD_SEQGER = :AUTINC                                                                            ');
       If Not fEmptyStr(AStrCodIte) Then
       Begin
         Add(' AND D.ORD_CODITE = :CODITE                                                                        ');
         ParamByName('CODITE').AsString := AStrCodIte;
       End;
       ParamByName('AUTINC').AsString := Self.FieldByName('ORD_SEQGER').AsString;

       Open;

     End;

     cdsIteEti := fCriaClientDatset(qryEti, True);

     If qryEti.IsEmpty Then
       Exit;

     pGeraItensImpressao;

     If (Not cdsIteEti.IsEmpty) Then
     Begin
       pCarregaConfImprRel('frmManOrdProIndustrial_ETIQUETA', strNomImp, strTipImp);

       prmDllEtq := TParamDllEtiquetas.Create;

       With prmDllEtq Do
       Begin
         tpeTipEtq := tpeOPIndustrialArgox;
         dtsImpres := cdsIteEti;
         strNomFil := strNomImp;
         strNomFrm := 'frmManOrdProIndustrial_ETIQUETA';
         blnImpEti := False;
       End;

       for i := 0 to High(arrLayoutsSelecionados) do
       begin
         {cdsIteEti.Filtered := False;
         cdsIteEti.Filter   := 'LAYOUT = ' + QuotedStr(arrLayouts[i]);
         cdsIteEti.Filtered := True;   }

         prmDllEtq.strLayDoc := arrLayoutsSelecionados[i];

         If fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetaGeral') Then
         Begin
           Try
             qryUpdate := fCriaQuery(Self);
             With qryUpdate, Sql Do
               Add(' UPDATE ORDDET SET ORD_IMPETI = "S" WHERE AUTOINCREM = :AUTOIN ');

             With cdsIteEti Do
             Begin
               First;
               While not Eof Do
               Begin
                 qryUpdate.ParamByName('AUTOIN').AsString := FieldByName('AUTOIN').AsString;
                 qryUpdate.ExecSQL;
                 Next;
               End;

             End;
           Finally
             FreeAndNil(qryUpdate);
           End;
         End;
       end;

         FreeAndNil(prmDllEtq);
     End;

   Finally
     FreeAndNil(qryEti);
     FreeAndNil(cdsIteEti);
   End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmOrdProIndustrialEtq.pImprimeEtiquetas');
    End;
  End;
End;

function TOrdProIndustrial.fRetAtarelEditorRelatorios: Integer;
var
  intMDORIN: Integer;
begin
  Result := 0;
  intMDORIN := fCfgSis('MDORIN', varInteger);

  { migração iniciada em 05/06/2025 }
  { todas as chaves e atarels ja reservados, serão descomentados quando a migração for feita }

  Case intMDORIN of
    1: Result := 475;
    //2: Result := 476;
    //3: Result := 477;
    //4: Result := 478;
    //5: Result := 479;
    6: Result := 480;
    7: Result := 481;
    //8: Result := 482;
    //9: Result := 483;
    //10: Result := 484;
    //11: Result := 485;
    //12: Result := 486;
    //13: Result := 487;
    //14: Result := 488;
    //15: Result := 489;
    //16: Result := 490;
    //17: Result := 491;
    //18: Result := 492;
    //19: Result := 493;
    //20: Result := 494;
    21: Result := 495;
    //22: Result := 496;
    //23: Result := 497;
    //24: Result := 498;
    //25: Result := 499;
    26: Result := 500;
    //27: Result := 501;
    //28: Result := 502;
    //29: Result := 503;
    //30: Result := 504;
    //31: Result := 505;
    32: Result := 506;
    //33: Result := 507;
    //34: Result := 508;
    //35: Result := 509;
    //36: Result := 510;
    //37: Result := 511;
    //38: Result := 512;
    39: Result := 580;
    40: Result := 582;
  end;
end;

function TOrdProIndustrial.fRetChaveEditorRelatorios: Integer;
var
  intMDORIN: Integer;
begin
  Result := 0;
  intMDORIN := fCfgSis('MDORIN', varInteger);

  Case intMDORIN of
    1: Result := 34517;
    //2: Result := 34518;
    //3: Result := 34519;
    //4: Result := 34520;
    //5: Result := 34521;
    6: Result := 34522;
    7: Result := 34523;
    //8: Result := 34524;
    //9: Result := 34525;
    //10: Result := 34526;
    //11: Result := 34527;
    //12: Result := 34528;
    //13: Result := 34529;
    //14: Result := 34530;
    //15: Result := 34531;
    //16: Result := 34532;
    //17: Result := 34533;
    //18: Result := 34534;
    //19: Result := 34535;
    //20: Result := 34536;
    21: Result := 34537;
    //22: Result := 34538;
    //23: Result := 34539;
    //24: Result := 34540;
    //25: Result := 34541;
    26: Result := 34542;
    //27: Result := 34543;
    //28: Result := 34544;
    //29: Result := 34545;
    //30: Result := 34546;
    //31: Result := 34547;
    32: Result := 34548;
    //33: Result := 34549;
    //34: Result := 34550;
    //35: Result := 34551;
    //36: Result := 34552;
    //37: Result := 34553;
    //38: Result := 34554;
    39: Result := 39208;
    40: Result := 43996;
  end;
end;

function TOrdProIndustrial.fVerificaImpressaoEditorRelatorios: Boolean;
var
  intChave, intAtarel: Integer;
begin
  Result := False;
  intAtarel := fRetAtarelEditorRelatorios;
  intChave := fRetChaveEditorRelatorios;

  if (intChave <> 0) and (intAtarel <> 0) Then
    Result := fncVerificaSeRelatorioExiste(intAtarel, intChave);
end;

Procedure TOrdProIndustrial.pImprimessaoOP(strAutInc: String);
Begin
  recImpres.strAutImp := strAutInc;
  recImpres.strCodGra := '';
  recImpres.strCodCorDesenv := '';
  pCriarFormularios(TfrmImpOrdProIndustrial, frmImpOrdProIndustrial);

  frmImpOrdProIndustrial.objOrdPro := Self;
  frmImpOrdProIndustrial.mmoObservacao.Texto := fGetObserv(strAutInc);
  frmImpOrdProIndustrial.edtQtdPar.Text      := fGetQtdPar(strAutInc);

  If FEditorRelatorios Then
    pImprimeOP
  Else If fCfgSis('ATIOPI', varBoolean) Then
    frmImpOrdProIndustrial.ShowModal
  Else
    frmImpOrdProIndustrial.btnImprimir.Click;


  FreeAndNil(frmImpOrdProIndustrial);
End;

Procedure TOrdProIndustrial.pConfiguraImprimessaoOP;
Begin
  If (FEditorRelatorios) Then
  Begin
    TRelatorio.fEditarFiltrosRelatorioAtarel(IntToStr(fRetAtarelEditorRelatorios),
                                             [],
                                             '',
                                             Self.FEdtRelTabelaCadVal,
                                             False,
                                             True);

    Self.FEdtImpPorTabelaTmp := True;

  End
  Else If (not FEditorRelatorios) Then
  Begin
    recImpres.strCodGra := '';
    recImpres.strCodCorDesenv := '';
    pCriarFormularios(TfrmImpOrdProIndustrial, frmImpOrdProIndustrial);

    frmImpOrdProIndustrial.objOrdPro := Self;
    frmImpOrdProIndustrial.chkOpComp.Checked := recImpres.blnFormul And
                                                recImpres.blnCorrec And
                                                recImpres.blnConQua And
                                                recImpres.blnTemPro And
                                                recImpres.blnObsAss And
                                                recImpres.blnEnvase;

    frmImpOrdProIndustrial.chkFormul.Checked := recImpres.blnFormul;
    frmImpOrdProIndustrial.chkCorrec.Checked := recImpres.blnCorrec;
    frmImpOrdProIndustrial.chkConQua.Checked := recImpres.blnConQua;
    frmImpOrdProIndustrial.chkTemPro.Checked := recImpres.blnTemPro;
    frmImpOrdProIndustrial.chkEnvase.Checked := recImpres.blnEnvase;
    frmImpOrdProIndustrial.chkExtrusao.Checked:= recImpres.blnExtrus;
    frmImpOrdProIndustrial.ChkAnaFor.Checked := recImpres.blnAnaFor;
    frmImpOrdProIndustrial.chkObsAss.Checked := recImpres.blnObsAss;

    frmImpOrdProIndustrial.chkFasDis.Checked := recImpres.blnFasDis;
    frmImpOrdProIndustrial.edtQtdFas.Text    := IntToStr(recImpres.intQtdFas);
    frmImpOrdProIndustrial.mmoObservacao.Texto := recImpres.strObserv;
    frmImpOrdProIndustrial.edtQtdPar.Text := IntToStr(recImpres.intQtdPar);

    frmImpOrdProIndustrial.blnSoConfigurar     := True;
    frmImpOrdProIndustrial.btnImprimir.Caption := 'Confirmar';

    frmImpOrdProIndustrial.ShowModal;
    if frmImpOrdProIndustrial.ModalResult = mrOK Then
    Begin
      recImpres.blnFormul := frmImpOrdProIndustrial.chkFormul.Checked;
      recImpres.blnCorrec := frmImpOrdProIndustrial.chkCorrec.Checked;
      recImpres.blnConQua := frmImpOrdProIndustrial.chkConQua.Checked;
      recImpres.blnTemPro := frmImpOrdProIndustrial.chkTemPro.Checked;
      recImpres.blnEnvase := frmImpOrdProIndustrial.chkEnvase.Checked;
      recImpres.blnFasDis := frmImpOrdProIndustrial.chkFasDis.Checked;

      recImpres.blnLocFis := frmImpOrdProIndustrial.chkLocFis.Checked;
      recImpres.blnVisCon := frmImpOrdProIndustrial.chkVisCon.Checked;

      recImpres.blnExtrus := frmImpOrdProIndustrial.chkExtrusao.Checked;
      recImpres.blnAnaFor := frmImpOrdProIndustrial.chkAnaFor.Checked;
      recImpres.blnDadCli := frmImpOrdProIndustrial.chkDadCli.Checked;
      recImpres.intQtdFas := StrToIntDef(frmImpOrdProIndustrial.edtQtdFas.Text, 0);
      recImpres.strObserv := frmImpOrdProIndustrial.mmoObservacao.Texto;
      recImpres.intQtdPar := StrToIntDef(frmImpOrdProIndustrial.edtQtdPar.Text,0);
      recImpres.blnObsAss := frmImpOrdProIndustrial.chkObsAss.Checked;
    End;

    FreeAndNil(frmImpOrdProIndustrial);
  End;
End;

Procedure TOrdProIndustrial.pCarregaDadosImpressaoCorrecao(var frmQckOrdProIndustrial : TfrmQckOrdProIndustrial; var qryCorrecao: TUniQuery; strAutInc : String);
Begin
  With qryCorrecao, SQL Do
  Begin
    Add(' SELECT ODM_ITESUB AS ITESUB,                                       ');
    Add('        ODM_DESCRI AS DESCRI,                                       ');
    Add('        REPLACE(DMT_OBSERV,"<<csq>>", " ") AS OBSERV,               ');
    Add('        DET_QTDITE * IF(LEFT(DET_CLAFIS, 1) < 5, - 1, 1) AS QTDITE, ');
    Add('        DET_TOTCUS * IF(LEFT(DET_CLAFIS, 1) < 5, - 1, 1) AS TOTCUS, ');
    Add('        I.ITE_REFERE AS REFERE                                      ');
    Add(' FROM ORDMAT M                                                      ');
    Add('   INNER JOIN MOVDET D ON D.AUTOINCREM = ODM_SEQDET                 ');
    Add('   INNER JOIN DEICOR C ON C.DMT_SEQORD = ODM_SEQGER AND DMT_ITESUB = DET_CODITE ');
    Add('   INNER JOIN CADITE I ON I.ITE_CODITE =  ODM_ITESUB                ');
    Add(' WHERE ODM_SEQGER = :AUTINC                                         ');
    Add('   AND ODM_TIPOMP = "COR"                                          ');

    ParamByName('AUTINC').AsString := strAutInc;

    Open;

    If (qryCorrecao.IsEmpty) And (fCfgSis('MDORIN', varInteger) = 26) Then
    Begin
      Clear;
      Add(' SELECT                                ');
      Add('   CAST(" " AS CHAR(1)) AS ITESUB,     ');
      Add('   CAST(" " AS CHAR(1)) AS REFERE      ');
      Add(' UNION                                 ');
      Add(' ALL                                   ');
      Add(' SELECT                                ');
      Add('   CAST(" " AS CHAR(1)) AS ITESUB,     ');
      Add('   CAST(" " AS CHAR(1)) AS REFERE      ');
      Add(' UNION                                 ');
      Add(' ALL                                   ');
      Add(' SELECT                                ');
      Add('   CAST(" " AS CHAR(1)) AS ITESUB,     ');
      Add('   CAST(" " AS CHAR(1)) AS REFERE      ');
      Add(' UNION                                 ');
      Add(' ALL                                   ');
      Add(' SELECT                                ');
      Add('   CAST(" " AS CHAR(1)) AS ITESUB,     ');
      Add('   CAST(" " AS CHAR(1)) AS REFERE      ');
      Add(' UNION                                 ');
      Add(' ALL                                   ');
      Add(' SELECT                                ');
      Add('   CAST(" " AS CHAR(1)) AS ITESUB,     ');
      Add('   CAST(" " AS CHAR(1)) AS REFERE      ');
      Add(' UNION                                 ');
      Add(' ALL                                   ');
      Add(' SELECT                                ');
      Add('   CAST(" " AS CHAR(1)) AS ITESUB,     ');
      Add('   CAST(" " AS CHAR(1)) AS REFERE      ');
      Add(' UNION                                 ');
      Add(' ALL                                   ');
      Add(' SELECT                                ');
      Add('   CAST(" " AS CHAR(1)) AS ITESUB,     ');
      Add('   CAST(" " AS CHAR(1)) AS REFERE      ');

      Open;
    End;

    frmQckOrdProIndustrial.frxCorrecao.DataSet := qryCorrecao;

  End;

End;

procedure TOrdProIndustrial.pCarregaDadosExtrusao(var frmQckOrdProIndustrial: TfrmQckOrdProIndustrial; var qryExtrusao: TUniQuery; strAutInc : String);
Begin

  qryExtrusao.Close;
  qryExtrusao.SQL.Clear;
  qryExtrusao.SQL.Add(' SELECT ORD_ROSCA_, ORD_VELPIC, EXT_EXTS01, EXT_EXTS02, EXT_EXTS03, EXT_NOMTER FROM ORDGER O');
  qryExtrusao.SQL.Add('  JOIN ORDEXT AS E ON E.EXT_SEQGER = O.AUTOINCREM ');
  qryExtrusao.SQL.Add(' WHERE EXT_SEQGER = :AUTINC ');
  qryExtrusao.SQL.Add('   AND EXT_CODEMP = :CODEMP ');

  qryExtrusao.ParamByName('AUTINC').AsString := strAutInc;
  qryExtrusao.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryExtrusao.Open;

  frmQckOrdProIndustrial.frxGerExt.DataSet := qryExtrusao;

End;

Procedure TOrdProIndustrial.pCarregaDadosImpressaoAnalise(var frmQckOrdProIndustrial : TfrmQckOrdProIndustrial; var qryAnalise : TUniQuery; strAutInc : String);
  Var
    strCodigo : String;
Begin
  With qryAnalise, SQL Do
  Begin
    Close;
    Clear;

    If FDesenvFormulas then
    begin
      Add(' SELECT ANA_DESCRI AS DESCRI,                         ');
      Add('        GAN_CODANA AS CODANA,                         ');
      Add('        ANA_TIPRES AS TIPRES,                         ');
      Add('        GAN_LIMMIN AS LIMMIN,                         ');
      Add('        GAN_LIMMAX AS LIMMAX,                         ');

      If (fCfgSis('MDORIN', varInteger) = 35) Or (fCfgSis('MDORIN', varInteger) = 37) Then
      Begin
        Add('IF((IFNULL(GAN_LIMMIN,0) <= 0 AND (IFNULL(GAN_LIMMAX,0)) <= 0), GAN_DESRES, CONCAT("(",GAN_LIMMIN,'' a '', GAN_LIMMAX,")")) AS DESRES,    ');
        Add('"" AS GMTOBS, ');
      End
      Else
        Add('        GAN_DESRES AS DESRES,                         ');

      Add('        ANA_AMOSTR AS AMOSTR,                         ');
      Add('        ANA_INSTRU AS INSTRU,                         ');
      Add('        ANA_DESVIO AS DESVIO,                         ');
      Add('        NULL AS RESULT,                               ');
      Add('        " " AS STATUS,                                ');
      Add('        NULL AS DTAANA                                ');
      Add(' FROM GEDANA G                                        ');
      Add('   INNER JOIN CADANA A ON A.ANA_CODANA = G.GAN_CODANA ');
      Add(' WHERE G.GAN_SEQGMT = :AUTINC                         ');
    end
    else
    begin
      Add(' SELECT MAX(GER_CODIGO) AS CODIGO                       ');
      Add(' FROM ORDGER G                                          ');
      Add('   INNER JOIN ANAGER AG ON AG.GER_SEQOPI = G.AUTOINCREM ');
      Add(' WHERE G.AUTOINCREM = :AUTINC                           ');

      ParamByName('AUTINC').AsString := strAutInc;

      Open;

      //pega a ultima analise realizada, pois pode fazer várias analises.
      strCodigo := FieldByName('CODIGO').AsString;

      Close;
      Clear;

      If Not fEmptyStr(strCodigo) Then
      Begin
        Add(' SELECT ANA_DESCRI AS DESCRI,                         ');
        Add('        GAN_CODANA AS CODANA,                         ');
        Add('        ANA_TIPRES AS TIPRES,                         ');
        Add('        GAN_LIMMIN AS LIMMIN,                         ');
        Add('        GAN_LIMMAX AS LIMMAX,                         ');

        If (fCfgSis('MDORIN', varInteger) = 35) Or (fCfgSis('MDORIN', varInteger) = 37) Then
        Begin
          Add('IF((IFNULL(GAN_LIMMIN,0) <= 0 AND (IFNULL(GAN_LIMMAX,0)) <= 0), GAN_DESRES, CONCAT("(",GAN_LIMMIN,'' a '', GAN_LIMMAX,")")) AS DESRES,    ');
          Add('CONCAT(M.GMT_OBS001, " ", M.GMT_OBS002, " ", M.GMT_OBS003, " ", M.GMT_OBS004, " ", M.GMT_OBS005, " ", M.GMT_OBS006, " ", M.GMT_OBS007, " ", M.GMT_OBS008, " ") AS GMTOBS, ');
        End
        Else
          Add('        GAN_DESRES AS DESRES,                         ');

        Add('        ANA_AMOSTR AS AMOSTR,                         ');
        Add('        ANA_INSTRU AS INSTRU,                         ');
        Add('        ANA_DESVIO AS DESVIO,                         ');
        Add('        DET_RESULT AS RESULT,                         ');
        Add('        CASE DET_STATUS                               ');
        Add('          WHEN "1" THEN "APROVADO"                    ');
        Add('          WHEN "2" THEN "REPROVADO"                   ');
        Add('        END AS STATUS,                                ');
        Add('        DET_DTAANA AS DTAANA,                         ');
        Add('       G.AUTOINCREM AS CHAVE                          ');
        Add(' FROM ANAGER G                                        ');
        Add('   INNER JOIN ANADET D ON D.DET_SEQGER = G.AUTOINCREM ');
        Add('   INNER JOIN CADANA A ON A.ANA_CODANA = D.DET_CODANA ');
        Add('   INNER JOIN ORDGER O ON O.AUTOINCREM = G.GER_SEQOPI ');
        Add('   INNER JOIN GEIMAT M ON M.GMT_CODITE = O.ORD_CODITE ');
        Add('                      AND M.GMT_CODCOR = O.ORD_CODCOR ');
        Add('                      AND M.GMT_FORMUL = O.ORD_FORMUL ');
        Add('   INNER JOIN GEIANA N ON N.GAN_SEQGMT = M.AUTOINCREM ');
        Add('                      AND N.GAN_CODANA = D.DET_CODANA ');
        Add(' WHERE GER_SEQOPI = :AUTINC                           ');
        Add('   AND GER_CODIGO = :CODIGO                           ');

        If fCfgSis('ULTCMP', varBoolean) Then
          Add('   AND GAN_INFOAB <> "AB"                           ');

        ParamByName('CODIGO').AsString := strCodigo;
      End
      Else
      Begin
        Add(' SELECT ANA_DESCRI AS DESCRI,                         ');
        Add('        GAN_CODANA AS CODANA,                         ');
        Add('        ANA_TIPRES AS TIPRES,                         ');
        Add('        GAN_LIMMIN AS LIMMIN,                         ');
        Add('        GAN_LIMMAX AS LIMMAX,                         ');

        If (fCfgSis('MDORIN', varInteger) = 35) Or (fCfgSis('MDORIN', varInteger) = 37) Then
        Begin
          Add('IF((IFNULL(GAN_LIMMIN,0) <= 0 AND (IFNULL(GAN_LIMMAX,0)) <= 0), GAN_DESRES, CONCAT("(",GAN_LIMMIN,'' a '', GAN_LIMMAX,")")) AS DESRES,    ');
          Add('CONCAT(M.GMT_OBS001, " ", M.GMT_OBS002, " ", M.GMT_OBS003, " ", M.GMT_OBS004, " ", M.GMT_OBS005, " ", M.GMT_OBS006, " ", M.GMT_OBS007, " ", M.GMT_OBS008, " ") AS GMTOBS, ');
        End
        Else
          Add('        GAN_DESRES AS DESRES,                         ');

        Add('        ANA_AMOSTR AS AMOSTR,                         ');
        Add('        ANA_INSTRU AS INSTRU,                         ');
        Add('        ANA_DESVIO AS DESVIO,                         ');
        Add('        NULL AS RESULT,                               ');
        Add('        " " AS STATUS,                                ');
        Add('        NULL AS DTAANA,                               ');
        Add('       G.AUTOINCREM AS CHAVE                          ');
        Add(' FROM ORDGER G                                        ');
        Add('   INNER JOIN GEIMAT M ON M.GMT_CODITE = G.ORD_CODITE ');
        Add('                      AND M.GMT_CODCOR = G.ORD_CODCOR ');
        Add('                      AND M.GMT_FORMUL = G.ORD_FORMUL ');
        Add('   INNER JOIN GEIANA N ON N.GAN_SEQGMT = M.AUTOINCREM ');
        Add('   INNER JOIN CADANA A ON A.ANA_CODANA = N.GAN_CODANA ');
        Add(' WHERE G.AUTOINCREM = :AUTINC                         ');
        If fCfgSis('ULTCMP', varBoolean) Then
          Add('   AND GAN_INFOAB <> "AB"                           ');

      End;

    end;

    ParamByName('AUTINC').AsString := strAutInc;
    Open;

    frmQckOrdProIndustrial.frxAnalise.DataSet := qryAnalise;

  End;

End;

Procedure TOrdProIndustrial.pCarregaDadosImpressaoEPI(var frmQckOrdProIndustrial : TfrmQckOrdProIndustrial; var cdsEpi : TUniClientDataSet; strAutInc : String);
  Var
    qryConsul : TUniQuery;
    picImagem : TPicture;
    objStream : TStream;
    objBMP    : TBitmap;
Begin
  Try
    qryConsul := fCriaQuery;
    With qryConsul, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT EPI_DESCRI,                                   ');
      Add('        EPI_IMGEPI,                                   ');
      Add('        GEP_OBSERV,                                   ');
      Add('        GEP_TIPUSO                                    ');
      Add(' FROM ORDGER G                                        ');
      Add('   INNER JOIN GEIMAT M ON M.GMT_CODITE = G.ORD_CODITE ');
      Add('                      AND M.GMT_CODCOR = G.ORD_CODCOR ');
      Add('                      AND M.GMT_FORMUL = G.ORD_FORMUL ');
      Add('   INNER JOIN GEIEPI E ON E.GEP_SEQGMT = M.AUTOINCREM ');
      Add('   INNER JOIN CADEPI P ON P.EPI_CODEPI = E.GEP_CODEPI ');
      Add(' WHERE G.AUTOINCREM = :AUTINC                         ');

      ParamByName('AUTINC').AsString := strAutInc;

      Open;

      While Not Eof Do
      Begin
        cdsEpi.Append;
        cdsEpi.FieldByName('DESCRI').AsString := FieldByName('EPI_DESCRI').AsString;
        cdsEpi.FieldByName('OBSERV').AsString := FieldByName('GEP_OBSERV').AsString;
        cdsEpi.FieldByName('TIPUSO').AsString := FieldByName('GEP_TIPUSO').AsString;

        objStream := TMemoryStream.Create;
        objBMP := TBitmap.Create;
        picImagem := TPicture.Create;

        try
          try
            pImagemFromBase64(FieldByName('EPI_IMGEPI').AsString, picImagem);
            objBMP.Assign(picImagem.Graphic);

            objBMP.SaveToStream(objStream);
            objStream.Position := 0;
            TBlobField(cdsEpi.FieldByName('IMGEPI')).LoadFromStream( objStream );
          except
            cdsEpi.FieldByName('IMGEPI').Clear;
          end;
        finally
          FreeAndNil(picImagem);
          FreeAndNil(objStream);
          FreeAndNil(objBMP);
        end;

        cdsEpi.Post;

        Next;
      End;

    End;

    frmQckOrdProIndustrial.frxEPI.DataSet := cdsEpi;

  Finally
    FreeAndNil(qryConsul);
  End;

End;

procedure TOrdProIndustrial.pCarregaDadosImpressaoComposicao(var frmQckOrdProIndustrial : TfrmQckOrdProIndustrial; var qryGerCom : TUniQuery);
Begin
  With qryGerCom, SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT ODC_CODITE AS CODITE,                    ');
    Add('      ITE_CODITE AS ITE_CODITE,                  ');
    Add('      ITE_DESITE AS DESCRI,                      ');
    Add('      ITE_REFERE AS REFERE,                      ');
    Add('       ODC_QTDITE AS QTDITE,                     ');
    Add('       UNI_SIGUNI AS UNIDAD,                     ');
    Add('       ODC_QTDUSA AS QTDENV,                     ');

    if fCfgSis('MDORIN', varInteger) = 26 then
      Add('       CAST("QTD. UTILIZADA:___________  PERDA:____________  LOTE:____________  " AS CHAR(100)) AS QTDPRD')
    else
      Add('       CAST("QTD. UTILIZADA: ___________  PERDA: ____________" AS CHAR(50)) AS QTDPRD');

    Add('FROM ORDCOM                                      ');
    Add('  INNER JOIN CADITE ON ITE_CODITE = ODC_CODITE   ');
    Add('  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI   ');
    Add('WHERE ODC_SEQDET = :SEQDET                       ');
    Add('  AND ODC_IMP_OP = "S"                           ');
    Add('ORDER BY ORDCOM.AUTOINCREM                       ');

    frmQckOrdProIndustrial.frxGerCom.DataSet := qryGerCom;
  End;

End;

Procedure TOrdProIndustrial.pImprimeOrdemProducao;
  Var
    frxReport: TfrxReport;
    strTipImp, strNomImp: String;
    intCfgMdOrin: Integer;
    qryGeiQua : TUniQuery;
    qryObserv : TUniQuery;
    qryAnalise: TUniQuery;
    qryExtrusao: TUniQuery;
    qryCorrecao: TUniQuery;
    qryGerCom : TUniQuery;
    cdsCadEpi : TUniClientDataSet;
    qryCadFas : TUniQuery;
    strCadFas : String;
    intCopias : Integer;
    i:integer;
    qryEditor: TUniQuery;

    strTabelaTmpAnalise,
    strTabelaTmpCabec,
    strTabelaTmpDispersao,
    strTabelaTmpIteFor,
    strTabelaTmpIteAca,
    strTabelaTmpEpi,
    strTabelaTmpCorrec: String;

  Const
    fr1cm: Double = 37.7953;
Begin
  qryGeiQua := fCriaQuery(Self);
  qryObserv := fCriaQuery(Self);
  qryAnalise:= fCriaQuery(Self);
  qryExtrusao:= fCriaQuery(Self);
  qryGerCom := fCriaQuery(Self);
  qryCorrecao := fCriaQuery(Self);
  qryCadFas := fCriaQuery(Self);
  qryEditor := fCriaQuery(Self);

  cdsCadEpi := TUniClientDataSet.Create(Self);
  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'DESCRI'; DataType := ftString; Size := 045; Required := False; End;
  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'IMGEPI'; DataType := ftBlob;                Required := False; End;
  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'TIPUSO'; DataType := ftString; Size := 020; Required := False; End;
  With cdsCadEpi.FieldDefs.AddFieldDef Do Begin Name := 'OBSERV'; DataType := ftString; Size := 300; Required := False; End;

  cdsCadEpi.CreateDataSet;
  TBlobField.Create(cdsCadEpi.FieldByName('IMGEPI') as TBlobField);

  intCfgMdOrin := fCfgSis('MDORIN', varInteger);

  pCriarFormularios(TfrmQckOrdProIndustrial, frmQckOrdProIndustrial);

  With frmQckOrdProIndustrial, recImpres Do
  Begin

    qryGeiQua.SQL.Add(' SELECT * FROM GEIQUA WHERE GMT_CODPAG = :CODPAG ');
    qryGeiQua.ParamByName('CODPAG').AsString := cdsCabIpr.FieldByName('CODITE').AsString;
    qryGeiQua.Open;

    qryObserv.SQL.Add(' SELECT DISTINCT                                       ');
    qryObserv.SQL.Add('        CONCAT( FGO_MENEXP,                            ');
    qryObserv.SQL.Add('        IF(FGO_MENEX2 = "", "", FGO_MENEX2),           ');
    qryObserv.SQL.Add('        IF(FGO_MENEX3 = "", "", FGO_MENEX3),           ');
    qryObserv.SQL.Add('        IF(FGO_MENEX4 = "", "", FGO_MENEX4)) AS MENEXP ');
    qryObserv.SQL.Add(' FROM EXTDOR                                           ');
    qryObserv.SQL.Add('   INNER JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO ');
    qryObserv.SQL.Add('   INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ');
    qryObserv.SQL.Add(' WHERE FDO_SEQOPI = :SEQOPI                            ');
    qryObserv.ParamByName('SEQOPI').AsString := cdsCabIpr.FieldByName('AUTOIN').AsString;
    qryObserv.Open;

    qryCadFas.SQL.Add(' SELECT ');
    qryCadFas.SQL.Add('   FAS_DESFAS ');
    qryCadFas.SQL.Add(' FROM ');
    qryCadFas.SQL.Add('   CADFAS C ');
    qryCadFas.SQL.Add(' LEFT JOIN FASOPI O ON O.FAS_CODFAS = C.FAS_CODFAS ');
    qryCadFas.SQL.Add(' AND O.FAS_SEQOPI = :AUTINC ');
    qryCadFas.SQL.Add(' WHERE  O.FAS_CODFAS = C.FAS_CODFAS ');
    qryCadFas.SQL.Add('   ORDER BY C.FAS_SEQFAS ');
    qryCadFas.ParamByName('AUTINC').AsString := cdsCabIpr.FieldByName('AUTINC').AsString;
    qryCadFas.Open;

    strCadFas := 'OBSERVAÇÕES: ';
    If Not qryCadFas.IsEmpty Then
    Begin
      qryCadFas.First;
      While Not qryCadFas.Eof Do
      Begin
        strCadFas := strCadFas + qryCadFas.FieldByName('FAS_DESFAS').AsString + ', ';

        qryCadFas.Next;
      End;

      If Not fEmptyStr(strCadFas) Then
        strCadFas := Copy(strCadFas, 1, Length(strCadFas) -2)
    End;

    If intCfgMdOrin = 9 Then
    Begin
      If Not(fEmptyStr(strCadFas)) Then
      Begin
        If Not(fEmptyStr(fGetObserv(cdsCabIpr.FieldByName('AUTINC').AsString))) Then
          strCadFas := strCadFas + AnsiReplaceStr(fGetObserv(cdsCabIpr.FieldByName('AUTINC').AsString), '<<csq>>', #13#10);
      End
    End;


    frxIteFor.dataSet := cdsDmtIpr;
    frxIteAca.dataSet := Self;
    frxCabec.dataSet := cdsCabIpr;
    frxDispersao.dataSet := cdsDisIpr;

    frxGeiQua.dataSet := qryGeiQua;
    frxObserv.dataSet := qryObserv;

    Case intCfgMdOrin of
        37: Begin
              pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
              frxReport := frxReportJ_37;
            End;
        34: Begin
              frxReport := frxReportJ_34;
            End;
        33: Begin
              pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
              frxReport := frxReportJ_33;
            end;
        32,39: Begin
              frxReport := frxReportM_32;
              pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
              pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
              frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
            End;
        31: Begin
              frxReport := frxReportJ_31;
              pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
              pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
            End;
        30: Begin
              pCarregaDadosImpressaoCadastroFases(frmQckOrdProIndustrial, qryCadFas, cdsCabIpr.FieldByName('AUTINC').AsString);
              pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
              pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
              pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
              pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
              frxReport := frxReportJ_30;
              frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
            End;
        29: Begin
              pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
              pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
              frxReport := frxReportJ_29;
              frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
            End;
        28: Begin
              pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
              pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
              frxReport := frxReportJ_28;
              frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
            End;
        27: Begin
            pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
            pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
            pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
            pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
            frxReport := frxReportJ_27;
            frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
         End;
        26: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_26;
           frxReport.AddFunction('function fAbreComposicao(strSeqDet: String): Boolean;');
         End;
       25: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           frxReport := frxReportJ_25;
         End;
       24: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_24;
           frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
         End;
       23: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_23;
           frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
         End;

      22: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_22;
           frxReport.AddFunction('function fAbreComposicao(strSeqDet: String): Boolean;');
         End;
      21: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_21;
           frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
         End;
      20: Begin
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_20;
           frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
         End;
      19: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_19;
           frxReport.AddFunction('function fAbreComposicao(strSeqDet: String): Boolean;');

         End;
      18: Begin
           frxReport := frxReportJ_18;
         End;
      17: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           frxReport := frxReportJ_17;
         end;
      16: begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           frxReport := frxReportJ_16;
         end;
      15: begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           frxReport := frxReportJ_15;
         end;
      14: frxReport := frxReportJ_14;
      13: begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           frxReport := frxReportJ_13;
         end;

      12: Begin
           frxReport := frxReportJ_12;
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
          End;

      11: Begin
           frxReport := frxReportJ_11;
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
         End;

      10: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_10;
           frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
         End;

      9: Begin
           frxReport := frxReportJ_9;
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
         End;

      8: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoCorrecao(frmQckOrdProIndustrial, qryCorrecao, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_8;
           frxReport.AddFunction('function fAbreComposicao(strSeqDet: String): Boolean;');
         End;

      7: begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           frxReport := frxReportJ_7;
         end;

      6: Begin
           pCarregaDadosImpressaoAnalise(frmQckOrdProIndustrial, qryAnalise, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoEPI(frmQckOrdProIndustrial, cdsCadEpi, cdsCabIpr.FieldByName('AUTINC').AsString);
           pCarregaDadosImpressaoComposicao(frmQckOrdProIndustrial, qryGerCom);
           frxReport := frxReportJ_6;
           frxReport.AddFunction('function fAbreComposicao(strCodIte: String): Boolean;');
         End;

      5: Begin
           pCarregaDadosExtrusao(frmQckOrdProIndustrial, qryExtrusao, cdsCabIpr.FieldByName('AUTINC').AsString);
           frxReport := frxReportJ_5;
         End;

      4: frxReport := frxReportJ_4;
      3: frxReport := frxReportJ_3;
      2: frxReport := frxReportJ_2;
      Else
        frxReport := frxReportJ;
    End;

    if (FEditorRelatorios) then
    Begin
      with recImpres do
      begin
        qryEditor.Close;
        qryEditor.SQL.Text := ' DROP TEMPORARY TABLE IF EXISTS TMP_REL_ORDPROD_VARIAVEIS; ' +
                              ' CREATE TEMPORARY TABLE TMP_REL_ORDPROD_VARIAVEIS ' +
                              '   SELECT ' +
                              '     :PESESP AS PESESP, ' +
                              '     :PESO AS PESO, ' +
                              '     :VOLUME AS VOLUME, ' +
                              '     :BLNDESENV AS BLNDESENV, ' +
                              '     :TITULOREL AS TITULOREL, ' +
                              '     :NOMEMP AS NOMEMP, ' +
                              '     :NOMOPE AS NOMOPE, ' +
                              '     :REIIMP AS REIIMP, ' +
                              '     :QTDDIS AS QTDDIS, ' +
                              '     :QTDFAS AS QTDFAS, ' +
                              '     :MSGROD AS MSGROD, ' +
                              '     :DESFAS AS DESFAS, ' +
                              '     :OPEFOR AS OPEFOR, ' +
                              '     :VERFRM AS VERFRM, ' +
                              '     :NOMQUI AS NOMQUI, ' +
                              '     :KILLIT AS KILLIT, ' +
                              '     :PRAVAL AS PRAVAL, ' +
                              '     :DESMAT AS DESMAT; ' ;


        qryEditor.ParamByName('PESESP').AsFloat      := fltPesoEspecifico;
        qryEditor.ParamByName('PESO').AsFloat        := fGetPesoProducao;
        qryEditor.ParamByName('VOLUME').AsFloat      := fGetVolumeProducao;
        qryEditor.ParamByName('BLNDESENV').AsInteger := IIF(FDesenvFormulas, 1, 0);

        If FDesenvFormulas Then
          qryEditor.ParamByName('TITULOREL').AsString := 'Desenvolvimento de Fórmulas'
        else
          qryEditor.ParamByName('TITULOREL').AsString := 'Ordem de Produção Interna';

        qryEditor.ParamByName('NOMEMP').AsString      := fRetNomeEmpresa;
        qryEditor.ParamByName('NOMOPE').AsString      := fRetNomeOperador(Self.FieldByName('CODOPE').AsString);
        qryEditor.ParamByName('REIIMP').AsString      := fRetNomeOperador(strLoginUsuarioLogado);
        qryEditor.ParamByName('QTDDIS').AsString      := fStrZero(IntToStr(recImpres.intQtdFas), 3);
        qryEditor.ParamByName('QTDFAS').AsInteger     := recImpres.intQtdFas;
        qryEditor.ParamByName('MSGROD').AsString      := fCfgSis('MSGIND', varString);
        qryEditor.ParamByName('DESFAS').AsString      := strCadFas;
        qryEditor.ParamByName('OPEFOR').AsString      := fRetNomeOperador(Self.FieldByName('ORD_OPEFOR').AsString);
        qryEditor.ParamByName('VERFRM').AsString      := Self.FieldByName('ORD_FORMUL').AsString;
        qryEditor.ParamByName('KILLIT').AsString      := IIf(Self.FieldByName('KILLIT').AsString='K','KG','LT');
        qryEditor.ParamByName('PRAVAL').AsString      := fCampoTabela('ITE_PRAVAL','CADITE',['ITE_CODITE'],[Self.FieldByName('CODITE').AsString]);
        If Not cdsCabIpr.FieldByName('AUTINC').IsNull Then
          qryEditor.ParamByName('NOMQUI').AsString      :=  fRetNomeOperador(fCampoTabela('ORD_OPEBAI','ORDGER',['AUTOINCREM'],[cdsCabIpr.FieldByName('AUTINC').AsString]))
        Else
          qryEditor.ParamByName('NOMQUI').AsString := '';
        if fCfgSis('DESMAT', varString) = 'D' then
          qryEditor.ParamByName('DESMAT').AsString := 'DESCRIÇÃO'
        else
          qryEditor.ParamByName('DESMAT').AsString := 'REFERÊNCIA';
        qryEditor.ExecSQL;

        strTabelaTmpAnalise := 'TMP_REL_ORDPROD_ANALISE';
        strTabelaTmpCabec := 'TMP_REL_ORDPROD_CABEC';
        strTabelaTmpDispersao := 'TMP_REL_ORDPROD_DISPERSAO';
        strTabelaTmpIteFor := 'TMP_REL_ORDPROD_ITEFOR';
        strTabelaTmpIteAca := 'TMP_REL_ORDPROD_ITEACA';
        strTabelaTmpEpi := 'TMP_REL_ORDPROD_EPI';
        strTabelaTmpCorrec := 'TMP_REL_ORDPROD_CORREC';

        pGerandoTemporariaAtravesDataSet(strTabelaTmpAnalise, qryAnalise);
        pGerandoTemporariaAtravesDataSet(strTabelaTmpCabec, cdsCabIpr);
        pGerandoTemporariaAtravesDataSet(strTabelaTmpDispersao, cdsDisIpr);
        pGerandoTemporariaAtravesDataSet(strTabelaTmpIteFor, cdsDmtIpr);
        pGerandoTemporariaAtravesDataSet(strTabelaTmpIteAca, Self);
        pGerandoTemporariaAtravesDataSet(strTabelaTmpEpi, cdsCadEpi);
        pGerandoTemporariaAtravesDataSet(strTabelaTmpCorrec, qryCorrecao);

        // A TMP_ORDPROD_GERCOM (qryGerCom) vai ser criada pelo editor e filtrada em tempo de execução no BeforePrint do Fr3.
        // Ao migrar outros modelos MDORIN, copiar exemplos definidos no MDORIN 6, tanto no SQL, quanto no BeforePrint.

      end;

    End;

    if (FEditorRelatorios) then
    Begin
      if Assigned(prcExecutaRelatorio) then
      Begin
        if (not FEdtImpPorTabelaTmp) Then
        Begin
          prcExecutaRelatorio(fRetAtarelEditorRelatorios, fRetChaveEditorRelatorios, [],
                        [],
                        [],
                        Nil,
                        Nil,
                        not fCfgSis('ATIOPI', varBoolean));


        End
        else if (FEdtImpPorTabelaTmp) then
        begin
          TRelatorio.pExecutaRelatorioAtarel(IntToStr(fRetAtarelEditorRelatorios),
                                             [],
                                             not fCfgSis('ATIOPI', varBoolean),
                                             True,
                                             '',
                                             False,
                                             True,
                                             Self.FEdtRelTabelaCadVal);

        end;
      end;
    end;

    if (not FEditorRelatorios) then
    Begin

      With frxReport Do
      Begin
        Script.Variables['PESESP'] := fltPesoEspecifico;
        Script.Variables['PESO']   := fGetPesoProducao;
        Script.Variables['VOLUME'] := fGetVolumeProducao;

        AddFunction('function fRetLocFisica(strCodIte: String): String;');

        If (intCfgMdOrin <> 20) And (intCfgMdOrin <> 30) Then
        Begin
          If Assigned(TfrxHeader(FindComponent('rlbTitulo'))) Then
            TfrxHeader(FindComponent('rlbTitulo')).Visible := blnFormul;
          If Assigned(TfrxMasterData(FindComponent('rlbDetalhes'))) Then
            TfrxMasterData(FindComponent('rlbDetalhes')).Visible := blnFormul;
          If Assigned(TfrxFooter(FindComponent('fooFormul'))) Then
            TfrxFooter(FindComponent('fooFormul')).Visible := blnFormul;
          If FindComponent('grhDispersao') <> Nil Then
          Begin
            TfrxGroupHeader(FindComponent('grhDispersao')).Visible := blnFormul;
            TfrxGroupFooter(FindComponent('grfDispersao')).Visible := blnFormul;
          End;
        End;

        If (intCfgMdOrin <> 12) And (intCfgMdOrin <> 18) And (intCfgMdOrin <> 20) And (intCfgMdOrin <> 21) And (intCfgMdOrin <> 28)
          And (intCfgMdOrin <> 30) And (intCfgMdOrin <> 40) Then
          TfrxChild(FindComponent('childCorrecoes')).Visible := blnCorrec;

        If (fCfgSis('MDORIN', varInteger) = 5) Then
        Begin
          If fCfgSis('EXMOPI', varBoolean) And (blnExtrus) Then
            TfrxChild(FindComponent('ChildExtrusao')).Visible := True
          Else
            TfrxChild(FindComponent('ChildExtrusao')).Visible := False;
        End;

        If (intCfgMdOrin <> 20) And (intCfgMdOrin <> 30) And (intCfgMdOrin <> 34) Then
        Begin
        If Assigned(TfrxChild(FindComponent('childContQualidade'))) Then
        TfrxChild(FindComponent('childContQualidade')).Visible := blnConQua;
          If FindComponent('childEnvase') <> Nil Then
            TfrxChild(FindComponent('childEnvase')).Visible := blnEnvase;
        End;

        If (intCfgMdOrin <> 10) And (intCfgMdOrin <> 15) And (intCfgMdOrin <> 20) And (intCfgMdOrin <> 23) And (intCfgMdOrin <> 27) And (intCfgMdOrin <> 29)
        And (intCfgMdOrin <> 30) Then
        Begin

          If (intCfgMdOrin <> 18) And (intCfgMdOrin <> 21) And (intCfgMdOrin <> 28) And (intCfgMdOrin <> 34) Then
            If Assigned(TfrxChild(FindComponent('childTempoProducao'))) Then
          TfrxChild(FindComponent('childTempoProducao')).Visible := blnTemPro;

          If FindComponent('childDispersao') <> Nil Then
            TfrxChild(FindComponent('childDispersao')).Visible := blnFasDis;
        End;

        If ((intCfgMdOrin = 15) Or (intCfgMdOrin = 29)) And (intCfgMdOrin <> 30) And (intCfgMdOrin <> 32) And (intCfgMdOrin <> 39) Then
        Begin
          TfrxChild(FindComponent('childDispersao')).Visible := blnFasDis;
        End;

        If (intCfgMdOrin = 10) Then
        Begin
        If Assigned(TfrxChild(FindComponent('ChildAnalises'))) Then
            TfrxChild(FindComponent('ChildAnalises')).Visible := blnAnaFor;
        End;

        If Not(blnFormul Or blnCorrec Or blnConQua Or blnTemPro Or blnEnvase) Then
        Begin
          If FindComponent('rlbCabecalho') <> Nil Then
            TfrxPageHeader(FindComponent('rlbCabecalho')).Visible := False;
          If FindComponent('childDispersao') <> Nil Then
            TfrxChild(FindComponent('childDispersao')).StartNewPage := False;
        End;

        If FDesenvFormulas Then
        Begin
          if Assigned(FindComponent('mmoNumOP')) Then
            TfrxMemoView(FindComponent('mmoNumOP')).Visible   := False;

          if Assigned(FindComponent('mmoCodOrd')) Then
            TfrxMemoView(FindComponent('mmoCodOrd')).Visible  := False;

          If intCfgMdOrin <> 2 Then
          Begin
            If Assigned(FindComponent('barCode')) then
            TfrxBarCodeView(FindComponent('barCode')).Visible := False;
          End;
        End;

        If (intCfgMdOrin = 8)  Or (intCfgMdOrin = 15)
        Or (intCfgMdOrin = 19) Or (intCfgMdOrin = 22)
        Or (intCfgMdOrin = 29) Or ( (intCfgMdOrin = 10) And (fCfgSis('DESOPI', varInteger) = 2) ) Then
        Begin
        If Assigned(TfrxMemoView(FindComponent('lblRefDes'))) Then
          TfrxMemoView(FindComponent('lblRefDes')).Text := 'DESCRIÇÃO';
        If Assigned(TfrxMemoView(FindComponent('lblRefDesCor'))) Then
          TfrxMemoView(FindComponent('lblRefDesCor')).Text := 'DESCRIÇÃO';
        End;

        If (intCfgMdOrin = 37)  Then
        Begin
          frxReport.Script.Variables['ENDEMP'] := fDadosEmpresaRodape;
        End;


        If (fCfgSis('MDORIN', varInteger) = 4) Then
        Begin
          If Assigned(FindComponent('mmoCliOrd')) Then
            TfrxMemoView(FindComponent('mmoCliOrd')).Visible  := blnDadCli;

          //Visto do Conferente
          If Assigned(frxReport.FindComponent('mmoVisCon')) Then
            TfrxMemoView(frxReport.FindComponent('mmoVisCon')).Visible  := recImpres.blnVisCon;

          If Assigned(frxReport.FindComponent('lineMD7_h')) Then
            TfrxLineView(frxReport.FindComponent('lineMD7_h')).Visible  := recImpres.blnVisCon;

          If Assigned(frxReport.FindComponent('lineMD7')) Then
            TfrxLineView(frxReport.FindComponent('lineMD7')).Visible  := recImpres.blnVisCon;

          If Not (recImpres.blnLocFis) Then
          Begin
            //Localização Física
            TfrxMemoView(frxReport.FindComponent('mmoLocFis_h')).Visible  := False;
            TfrxMemoView(frxReport.FindComponent('mmoLocFis'  )).Visible  := False;
            TfrxLineView(frxReport.FindComponent('lineMD55'   )).Visible  := False;
            TfrxLineView(frxReport.FindComponent('lineMD55_h' )).Visible  := False;
            TfrxLineView(frxReport.FindComponent('lineMD55_h' )).Visible  := False;
            TfrxLineView(frxReport.FindComponent('lineMD5_h'  )).Left     := 2.95 * fr1cm;
            TfrxLineView(frxReport.FindComponent('lineMD5'    )).Left     := 2.95 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoCod_h'   )).Width    := 1.9 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoCod'     )).Width    := 1.9 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoDesIte_h')).Left     := 3.06 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoDesIte'  )).Left     := 3.06 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoDesIteNegrito')).Left:= 3.06 * fr1cm;

            TfrxMemoView(frxReport.FindComponent('mmoLocFisDisp_h')).Visible  := False;
            TfrxMemoView(frxReport.FindComponent('mmoLocFisDisp'  )).Visible  := False;
            TfrxLineView(frxReport.FindComponent('lineMD7Disp'    )).Visible  := False;
            TfrxLineView(frxReport.FindComponent('lineMD7Disp_h' )).Visible  := False;
            TfrxLineView(frxReport.FindComponent('lineMD9Disp_h'  )).Left     := 2.95 * fr1cm;
            TfrxLineView(frxReport.FindComponent('lineMD9Disp'    )).Left     := 2.95 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoCodDisp_h'   )).Width    := 1.9 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoCodDisp'     )).Width    := 1.9 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoDesIteDisp_h')).Left     := 3.06 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoDesIteDisp'  )).Left     := 3.06 * fr1cm;
            TfrxMemoView(frxReport.FindComponent('mmoDesIteDispNegrito')).Left:= 3.06 * fr1cm;
          End;
        End;

        If intCfgMdOrin = 1 Then
        Begin
          If Assigned(frxReport.FIndComponent('ChildObsAssina')) Then
            TfrxChild(frxReport.FIndComponent('ChildObsAssina')).Visible := recImpres.blnObsAss;
        End;

      End;

    end;
  End;

  if (not FEditorRelatorios) then
  Begin
    With frxReport, recImpres Do
    Begin
      Script.Variables['BLNDESENV'] := FDesenvFormulas;

      If FDesenvFormulas Then
      Begin
        Script.Variables['TITULOREL'] := 'Desenvolvimento de Fórmulas';
      End Else
      Begin
        Script.Variables['TITULOREL'] := 'Ordem de Produção Interna';
      End;

      Script.Variables['FORMULACAO'] := blnFormul;
      Script.Variables['NOMEMP']     := fRetNomeEmpresa;
      Script.Variables['NOMOPE']     := fRetNomeOperador(Self.FieldByName('CODOPE').AsString);
      Script.Variables['QTDDIS']     := fStrZero(IntToStr(recImpres.intQtdFas), 3);
      Script.Variables['QTDFAS']     := recImpres.intQtdFas;
      Script.Variables['MSGROD']     := fCfgSis('MSGIND', varString);
      Script.Variables['DESFAS']     := strCadFas;

      If intCfgMdOrin = 13 Then
        Script.Variables['OBSPRC'] := fRetornaObsProcProducao(FCodIte, FCodCor);

      If intCfgMdOrin = 32 Then
      Begin
        Script.Variables['PESO']   := fGetPesoProducao;
        Script.Variables['VOLUME'] := fGetVolumeProducao;
        Script.Variables['OPEORD'] := fRetNomeOperador(Self.FieldByName('CODOPE').AsString);
        Script.Variables['OPEFOR'] := fRetNomeOperador(Self.FieldByName('ORD_OPEFOR').AsString);
        Script.Variables['MSGROD'] := fCfgSis('MSGIND', varString);

        if fCfgSis('DESMAT', varString) = 'D' then
          Script.Variables['DESMAT'] := 'DESCRIÇÃO'
        else
          Script.Variables['DESMAT'] := 'REFERÊNCIA';

        If Assigned(FindComponent('DMPQtdKgFormula')) Then
          TFrxMemoView(FindComponent('DMPQtdKgFormula')).DisplayFormat.FormatStr := '%2.' + IntToStr(intCasasDecimaisMateriaPrima) + 'f';
      End;

      pCarregaConfImprRel('frmManOrdProIndustrial', strNomImp, strTipImp);

      PrintOptions.Printer := AnsiReplaceText(strNomImp, '\\' + fRetNomeRede + '\', '');

      PrepareReport;

      If (intCfgMdOrin = 32) And (blnEnvase) Then
      Begin
        frmQckOrdProIndustrial.frxReportEnvaseM.Script.Variables['PESO']   := fGetPesoProducao;
        frmQckOrdProIndustrial.frxReportEnvaseM.PrepareReport;
      End;

      If fEmptyStr(strNomImp) Then
      Begin
        If Not (intCfgMdOrin = 32) Then
          pPreviewReport('frmManOrdProIndustrial', 'Ordem de Produção Industrial', frxReport)
        Else
        Begin
          If ((blnFormul = True) Or
              (blnCorrec = True) Or
              (blnTemPro = True) Or
              (blnConQua = True)) Then
            pPreviewReport('frmManOrdProIndustrial', 'Ordem de Produção Industrial', frxReport);

          If blnEnvase Then
            pPreviewReport('frmManOrdProIndustrial', 'Ordem de Produção Industrial - Envase', frmQckOrdProIndustrial.frxReportEnvaseM);
        End;
      End
      Else
      Begin
        If Not (intCfgMdOrin = 32) Then
        Begin
          PrintOptions.ShowDialog := False;
          pPrintReport('frmManOrdProIndustrial', 'Ordem de Produção Industrial', strNomImp, frxReport);
        End
        Else
        Begin
          If ((blnFormul = True) Or
              (blnCorrec = True) Or
              (blnTemPro = True) Or
              (blnConQua = True)) Then
          Begin
            PrintOptions.ShowDialog := False;
            pPrintReport('frmManOrdProIndustrial', 'Ordem de Produção Industrial', strNomImp, frxReport);
          End;

          If blnEnvase Then
          Begin
            frmQckOrdProIndustrial.frxReportEnvaseM.PrintOptions.ShowDialog := False;
            pPrintReport('frmManOrdProIndustrial', 'Ordem de Produção Industrial - Envase', strNomImp, frmQckOrdProIndustrial.frxReportEnvaseM);
          End
        End;
      End;


      if fCfgSis('DCONOP', varBoolean) And (intCfgMdOrin = 32) then
      begin
        intCopias := StrToInt(fInputDialog('Documento para conferência', 'Quantidade de cópias:', '1', 3, 300, ttNumerico, False, '', fValidaQuantidadeCopias));

        if intCopias > 0 then
        begin
           frmQckOrdProIndustrial.frxReportConferenciaM.Script.Variables['PreviewAtivo'] := '0';
           frmQckOrdProIndustrial.frxReportConferenciaM.Script.Variables['contador'] := '1';
           frmQckOrdProIndustrial.frxReportConferenciaM.Script.Variables['totalPag'] :=IntToStr(intCopias);
           frmQckOrdProIndustrial.frxReportConferenciaM.Script.Variables['PESO']   := fGetPesoProducao;
           frmQckOrdProIndustrial.frxReportConferenciaM.Script.Variables['VOLUME'] := fGetVolumeProducao;

           frmQckOrdProIndustrial.frxReportConferenciaM.PrepareReport;

           If fEmptyStr(strNomImp) Then
           Begin
             frmQckOrdProIndustrial.frxReportConferenciaM.Script.Variables['PreviewAtivo'] := '1';
             frmQckOrdProIndustrial.frxReportConferenciaM.Script.Variables['contador'] := '-1';
             TfrxReportPage(frmQckOrdProIndustrial.frxReportConferenciaM.FindObject('qckPagina')).PageCount := intCopias;
             frmQckOrdProIndustrial.frxReportConferenciaM.PrepareReport;
             frmQckOrdProIndustrial.frxReportConferenciaM.ShowReport;
           End
           Else
           Begin
             frmQckOrdProIndustrial.frxReportConferenciaM.PrintOptions.ShowDialog := False;

             For i := 1 To intCopias do
             Begin
               frmQckOrdProIndustrial.frxReportConferenciaM.Script.Variables['contador'] := i.ToString;
               frmQckOrdProIndustrial.frxReportConferenciaM.PrepareReport;
               frmQckOrdProIndustrial.frxReportConferenciaM.Print;
             End;
           End;
        end;

      end;

    End;
  end;
  FreeAndNil(qryCorrecao);
  FreeAndNil(qryGerCom);
  FreeAndNil(cdsCadEpi);
  FreeAndNil(qryAnalise);
  FreeAndNil(qryExtrusao);
  FreeAndNil(qryGeiQua);
  FreeAndNil(qryObserv);
  pFreeAndNil(frmQckOrdProIndustrial);
  FreeAndNil(qryCadFas);
  FreeAndNil(qryEditor);
End;

procedure TOrdProIndustrial.pImprimeProcessoDeExtrusao(strAutInc : String);
  Var
    qryExtrusao : TUniQuery;
    strLayPadrao: string;
    objImpressao: TEditorFastImpressao;
begin
  Try
    qryExtrusao := fCriaQuery;
    qryExtrusao.Close;
    qryExtrusao.SQL.Clear;
    qryExtrusao.SQL.Add(' SELECT ORD_CODEMP AS CODEMP, ORD_CODORD AS CODORD, ORD_DTACAD AS DTACAD FROM ORDGER AS O ');
    qryExtrusao.SQL.Add('  JOIN ORDEXT AS E ON E.EXT_SEQGER = O.AUTOINCREM ');
    qryExtrusao.SQL.Add(' WHERE O.AUTOINCREM = :AUTINC ');
    qryExtrusao.SQL.Add('   AND ORD_CODEMP = :CODEMP ');

    qryExtrusao.ParamByName('AUTINC').AsString := strAutInc;
    qryExtrusao.ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (Not fCfgSis('EXMOPI', VarBoolean)) then
      Exit;

    strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeProcessoDeExtrusao], VS_strCodEmp, 'S']);

    If fEmptyStr(strLayPadrao) Then
    Begin
      pMensagemOk('Não há layout disponível para impressão!');
      Exit;
    End;

    objImpressao := TEditorFastImpressao.Create(Nil);

    Try
      qryExtrusao.Open;
      objImpressao.recDocume.blnProcessoDeExtrusao := True;
      objImpressao.recDocume.strCodEmp             := qryExtrusao.FieldByName('CODEMP').AsString;
      objImpressao.recDocume.strCodOrd             := qryExtrusao.FieldByName('CODORD').AsString;
      objImpressao.recDocume.strDtaCad             := FormatDateTime('yyyy-mm-dd', qryExtrusao.FieldByName('DTACAD').AsDateTime);
      objImpressao.recDocume.strCodEmp             := VS_strCodEmp;
      objImpressao.tpeTipoEtiqueta                 := tpeProcessoDeExtrusao;
      objImpressao.recDocume.blnTemLay             := True;
      objImpressao.recDocume.strCodLay             := strLayPadrao;
      objImpressao.fImprimeDocumento;
    Finally
      qryExtrusao.Close;
      FreeAndNil(objImpressao);
    End;

  Finally
    FreeAndNil(qryExtrusao);
  End;

end;

Procedure TOrdProIndustrial.pImprimeOP;
Begin
  With recImpres Do
  Try
    If cdsDisIpr.Active Then
      cdsDisIpr.EmptyDataSet;

    pSetObservPartidas(strAutImp, strObserv, intQtdPar);

    pCabecalhoImpressao(strAutImp);
    pProdutosAcabadosImpressao(strAutImp);
    pProdutosFormulaImpressao(strAutImp, fAgrLot);

    pImprimeOrdemProducao;

    pImprimeProcessoDeExtrusao(strAutImp);

  Except
    on E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TOrdProIndustrial.pImprimeOP]');
    End;
  End;
End;

Procedure TOrdProIndustrial.pSetObservPartidas(strAutInc, strObserv : string; intQtdPar : Integer);
  Var
    qryUpdate : TUniQuery;
Begin
  Try
    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE ORDGER SET ORD_OBSERV = :OBSERV, ');
      Add('                   ORD_QTDPAR = :QTDPAR  ');
      Add(' WHERE AUTOINCREM = :AUTINC              ');

      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('OBSERV').AsString := strObserv;
      ParamByName('QTDPAR').AsInteger:= intQtdPar;

      ExecSQL;

      Close;
    End;

  Finally
    FreeAndNil(qryUpdate)
  End;

End;

function TOrdProIndustrial.fGetDataUltimaBaixa(strAutIncP : String): TDate;
  Var
    qryDados : TUniQuery;
begin
  Try
    qryDados := fCriaQuery;
    With qryDados, SQL Do
    Begin
      Add('SELECT GER_DTAENT FROM ORDBAI O ');
      Add('INNER JOIN MOVGER G ON G.AUTOINCREM = ORB_SEQGER ');
      Add('WHERE ORB_SEQOPI = :SEQOPI ');
      Add('ORDER BY O.AUTOINCREM DESC ');

      ParamByName('SEQOPI').AsString := strAutIncP;

      Open;

      Result := FieldByName('GER_DTAENT').AsDateTime;

      Close;

    End;
  Finally
    FreeAndNil(qryDados);
  End;

end;

function TOrdProIndustrial.fGetObserv(strAutImp: String): String;
  Var
    qryObserv: TUniQuery;
Begin
  Try
    qryObserv := fCriaQuery(Self);
    With qryObserv, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT ORD_OBSERV FROM ORDGER ');
      Add(' WHERE AUTOINCREM = :AUTINC    ');

      ParamByName('AUTINC').AsString := strAutImp;

      Open;

      Result := FieldByName('ORD_OBSERV').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryObserv)
  End;

end;


function TOrdProIndustrial.fGetQtdPar(strAutImp: String): String;
  Var
    qryQtdPar: TUniQuery;
Begin
  Try
    qryQtdPar := fCriaQuery(Self);
    With qryQtdPar, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT ORD_QTDPAR FROM ORDGER ');
      Add(' WHERE AUTOINCREM = :AUTINC    ');

      ParamByName('AUTINC').AsString := strAutImp;

      Open;

      Result := FieldByName('ORD_QTDPAR').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryQtdPar)
  End;

end;

Function TOrdProIndustrial.fSQLCabecalhoImprDesenv(strObserv: String; intQtdPar : Integer): String;
Var
  strSQL: String;
Begin
  strSQL := '/* untOrdProIndustrial.fSQLCabecalhoImprDesenv */ ';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '   G.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '   G.AUTOINCREM AS AUTOIN, ';
  strSQL := strSQL + '   GMT_CODITE AS CODITE, ';
  strSQL := strSQL + '   GMT_CODCOR AS CODCOR, ';
  strSQL := strSQL + '   COR_DESCOR AS DESCOR, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   " "        AS CODORD, ';
  strSQL := strSQL + '   " "        AS CODBAR, ';

  strSQL := strSQL + '   CAST(:DTACAD AS DATE) AS DTACAD, ';
  strSQL := strSQL + '   CAST(:HORCAD AS TIME) AS HORCAD, ';

  strSQL := strSQL + '   ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   CAST(NULL AS DATE) AS DTAPRE, ';
  strSQL := strSQL + '   CAST(NULL AS DATE) AS DTABAI, ';
  strSQL := strSQL + '   CAST(NULL AS DATE) AS DTAVAL, ';
  strSQL := strSQL + '   CONCAT(IFNULL(GRU_DETLIN, ""), " ", ';
  strSQL := strSQL + '          IFNULL(GRU_DETGRU, ""), " ", ';
  strSQL := strSQL + '          IFNULL(COR_DETCOR, ""), " ", ';
  strSQL := strSQL + '          IFNULL(UNI_DETUNI, "")) AS DESETI,  ';

  strSQL := strSQL + '  " " AS NUMOPE, ';
  strSQL := strSQL + '  " " AS NUMLOT,  ';
  strSQL := strSQL + '  " " AS NUMRES,  ';
  strSQL := strSQL + '  0 AS ESTUTI,  ';
  strSQL := strSQL + IntToStr(intQtdPar) + ' AS QTDPAR,  ';
  strSQL := strSQL + '  "' + strObserv + '" AS OBSERV,  ';
  strSQL := strSQL + ' CAST("" AS CHAR(1)) AS OBSPRC ';
  strSQL := strSQL + ' FROM ';

  strSQL := strSQL + '   GEDMAT G ';

  strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = GMT_CODITE ';
  strSQL := strSQL + ' INNER JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';
  strSQL := strSQL + ' INNER JOIN CADCOR ON COR_CODCOR = GMT_CODCOR ';
  strSQL := strSQL + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   G.AUTOINCREM = :AUTINC ';

  Result := strSQL;
End;

Procedure TOrdProIndustrial.pCabecalhoImpressaoDesenv(strAutInc, strObserv: String; intQtdPar : Integer);
Begin
  if cdsCabIpr.Active Then
    cdsCabIpr.EmptyDataset;
  With cdsCabIpr, qryQuery Do
  Begin

    SQL.Text := fSQLCabecalhoImprDesenv(strObserv, intQtdPar);

    ParamByName('DTACAD').AsDateTime := VS_Date;
    ParamByName('HORCAD').AsTime     := fTime();
    ParamByName('AUTINC').AsString   := strAutInc;

    cdsCabIpr.fAbreClient(True, 'TOrdProIndustrial.pCabecalhoImpressaoDesenv');
  End;
End;

Procedure TOrdProIndustrial.pProdutosAcabadosImpressaoDesenv(strCodGra, strCodCor: String);
Begin
  qryQuery.SQL.Text := fSQLOrdPro(True);

  fCarregaItens('', strCodGra, strCodCor, False);

  Self.IndexFieldNames := 'DESITE';
  Self.First;

  While Not Eof Do
  Begin
    Edit;
    FieldByName('ORDITE').AsString := fStrZero(IntToStr(Self.RecNo), 2);
    Post;

    Next;
  End;

  Self.First;
End;













Function TOrdProIndustrial.fSQLFormulaIprDesenv(blnDispersao: Boolean = False): String;
Begin
  Result := '/* untOrdProIndustrial.fSQLFormulaIprDesenv */ ';

  Result := Result + ' SELECT SQL_NO_CACHE ';

  Result := Result + '   DMT_SEQUEN   AS SEQUEN, ';
  Result := Result + '   "   "        AS NUMDIS, ';
  Result := Result + '   "   "        AS ORDITE, ';
  Result := Result + '   D.DMT_ITESUB AS ITESUB, ';
  Result := Result + '   D.DMT_CODFAS AS CODFAS, ';
  Result := Result + '   IF(IFNULL(D.DMT_CODFAS, "") = :FASDIS, "S", "N") AS DISPER, ';
  Result := Result + '   IF(F.ITE_CODITE IS NULL, NULL, (D.DMT_QTDITE / 100) * :PESTOT) AS QTDPRO, ';

  Result := Result + '   IF(F.ITE_CODITE IS NULL, D.DMT_DESCRI,                         '+
                            IIF( (fCfgSis('DESOPI', varInteger) = 2) And
                                 (fCfgSis('MDORIN', varInteger) = 10), 'F.ITE_DESITE', 'F.ITE_REFERE') +') AS DESITE, ';

  Result := Result + '   F.ITE_CODITE, ';
  Result := Result + '   F.ITE_DESITE, ';
  Result := Result + '   F.ITE_REFERE, ';
  Result := Result + '   DMT_QTDITE , ';
  Result := Result + '   IF( F.ITE_DENSID > 0, DMT_QTDITE / ITE_DENSID, 0 ) AS DMT_DENSID, ';
  Result := Result + '   0 AS PERTOL,          ';
  Result := Result + '   0 AS PESBAL,          ';
  Result := Result + '   "" AS LOCFIS,         ';
  Result := Result + '   "" AS DTAVAL,         ';
  Result := Result + '   "" AS LOT_MP,         ';
  Result := Result + '   GRU_DESGRU AS DESGRU, ';
  Result := Result + '   ""         AS BALANC, ';
  Result := Result + '   UNI_SIGUNI AS SIGUNI,  ';
  Result := Result + '   " " AS RELLOT,                         ';
  Result := Result + '   FS.FAS_DESFAS         ';
  Result := Result + ' FROM                     ';
  Result := Result + '    GEDMAT G  ';
  Result := Result + ' INNER JOIN DEDMAT D ON G.AUTOINCREM = D.DMT_SEQGER     ';
  Result := Result + ' LEFT JOIN CADFAS FS ON  (FS.FAS_CODFAS = D.DMT_CODFAS) ';
  Result := Result + ' LEFT JOIN CADITE F ON F.ITE_CODITE = D.DMT_ITESUB      ';
  Result := Result + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI            ';
  Result := Result + ' LEFT JOIN CADGRU ON GRU_CODGRU = CONCAT(LEFT(F.ITE_CODGRU,3),"000")       ';
  Result := Result + ' WHERE ';

  If blnDispersao Then
    Result := Result + '   FALSE '
  Else
    Result := Result + '   G.AUTOINCREM = :AUTINC ';

  Result := Result + ' ORDER BY DMT_SEQUEN ';
End;

function TOrdProIndustrial.fSqlOrdMat: String;
begin
  Result := 'SELECT * FROM ORDMAT WHERE ODM_SEQGER = :SEQGER ';
end;

function TOrdProIndustrial.fSqlOrdCom: String;
begin
  Result :=          ' SELECT                                      ';
  Result := Result + '   ORDCOM.*,                                 ';
  Result := Result + '   ITE_DESITE AS COMPOSICAO,                 ';
  Result := Result + '   ITE_REFERE AS REFERENCIA,                 ';
  Result := Result + '   UNI_SIGUNI AS SIGUNIDADE,                 ';
  Result := Result + '   UNI_ITEFRA AS ITEM_FRACIONADO,            ';
  Result := Result + '   IFNULL(ITE_PESOIT, 0)  AS PESO_PRODUTO    ';
  Result := Result + ' FROM                                        ';
  Result := Result + '   ORDCOM                                    ';
  Result := Result + ' INNER JOIN                                  ';
  Result := Result + '   ORDDET ON ORDDET.AUTOINCREM = ODC_SEQDET  ';
  Result := Result + ' INNER JOIN                                  ';
  Result := Result + '   CADITE ON ITE_CODITE = ODC_CODITE         ';
  Result := Result + ' INNER JOIN                                  ';
  Result := Result + '   CADUNI ON UNI_CODUNI = ITE_CODUNI         ';
  Result := Result + ' WHERE                                       ';
  Result := Result + '   ORD_SEQGER = :SEQGER                      ';
end;

Procedure TOrdProIndustrial.pProdutosFormulaImpressaoDesenv(strAutInc: String);
Var
  intPosicao: Integer;
Begin
  With cdsDmtIpr, qryQuery Do
  Begin
    SQL.Text := fSQLFormulaIprDesenv(False);

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('PESTOT').AsFloat := fGetPesoProducao;
    ParamByName('FASDIS').AsString := fCfgSis('FASDIS');

    If cdsDmtIpr.FindField('TOT_QTDPRO') = Nil Then
      cdsDmtIpr.pCriaSoma('QTDPRO', 'TOT_QTDPRO');

    cdsDmtIpr.fAbreClient(True, 'TOrdProIndustrial.pProdutosFormulaImpressaoDesenv');
    cdsDmtIpr.IndexFieldNames := 'SEQUEN';

  End;

  intPosicao := 0;
  With cdsDmtIpr Do
  Begin
    First;
    While Not Eof Do
    Begin

      If FieldByName('QTDPRO').AsFloat > 0 Then
      Begin
        inc(intPosicao);
        Edit;
        FieldByName('ORDITE').AsString := fStrZero(IntToStr(intPosicao), 2);
        Post;
      End;

      Next;
    End;

    First;
  End;

  If recImpres.blnFasDis Then
    pMontaDispersao;

End;

Procedure TOrdProIndustrial.pImprimessaoDesenvOP(strAutInc, strCodGra, strCodCor: String);
Var
  LMdOrin: Integer;
Begin
  FDesenvFormulas := True;

  recImpres.strAutImp := strAutInc;
  recImpres.strCodGra := strCodGra;
  recImpres.strCodCorDesenv := strCodCor;
  LMdOrin := fCfgSis('MDORIN', varInteger);

  With recImpres Do
  Try
    If (LMdOrin In [13,36]) Then
      pCabecalhoImpressao(strAutImp)
    Else
      pCabecalhoImpressaoDesenv(strAutImp, strObserv, intQtdPar);

    If cdsDisIpr.Active Then
      cdsDisIpr.EmptyDataSet;

    pProdutosAcabadosImpressaoDesenv(strCodGra, strCodCorDesenv);

    If fPedeQuantidadeAProduzirDesenv Then
    Begin
      pCompletaProdutos(strCodGra, strCodCor, True, False);

      pProdutosFormulaImpressaoDesenv(strAutImp);

      pCriarFormularios(TfrmImpOrdProIndustrial, frmImpOrdProIndustrial);

      frmImpOrdProIndustrial.objOrdPro := Self;
      frmImpOrdProIndustrial.ShowModal;

      FreeAndNil(frmImpOrdProIndustrial);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TOrdProIndustrial.pImprimessaoDesenvOP]');
    End;
  End;
End;

Function TOrdProIndustrial.fVerificaQuantidadeDigitada: Boolean;
Begin
  Try
    try
      DisableControls;

      Result := False;

      First;

      While Not Eof Do
      Begin

        If FieldByName('ORD_QTDPRO').AsFloat > 0 Then
        Begin
          Result := True;
          Break;
        End;

        Next;
      End;
    finally
      EnableControls;
    end;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fVerificaQuantidadeDigitada]');
    End;

  End;
End;

Function TOrdProIndustrial.fPedeQuantidadeAProduzirDesenv: Boolean;
Begin
  If Self.IsEmpty Then
  Begin
    Result := False;
    pMensagemOk('Não há produtos acabados cadastrados para essa Fórmula!');
    Exit;
  End;

  pCriarFormularios(TfrmOrdProIndDesenvQtds, frmOrdProIndDesenvQtds);

  Self.BeforePost := pBeforePostDesenv;

  frmOrdProIndDesenvQtds.cxgItensView.DataController.DataSource := Self.dtsSource;
  frmOrdProIndDesenvQtds.objOrdPro := Self;
  frmOrdProIndDesenvQtds.ShowModal;
  Result := frmOrdProIndDesenvQtds.ModalResult = mrOk;

  FreeAndNil(frmOrdProIndDesenvQtds);

  Self.BeforePost := Nil;
End;

function TOrdProIndustrial.fPersisteBanco(cdsDados: TZClient): Boolean;
var qryComand : TUniQuery;
    i: integer;
    strCampos: String;
begin
  result := True;
  qryComand := fCriaQuery;
  Try
    strCampos := '_AUTOINCREM_ODC_SEQDET_ODC_CODITE_ODC_QTDITE_ODC_QTDUSA_ODC_VLRCUS_ODC_TOTCUS_ODC_IMP_OP_ODC_SEQSUB';
    qryComand.SQL.Add('UPDATE ORDCOM SET');
    For i :=0 To cdsDados.Fields.Count -1 do
      If Pos(cdsDados.Fields[i].FieldName, strCampos) > 0 Then
        qryComand.SQL.Add(IIf(i > 0, ',', '') + cdsDados.Fields[i].FieldName + ' = :' + cdsDados.Fields[i].FieldName) ;
    qryComand.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM');
    cdsDados.First;
    While not cdsDados.Eof Do
    Begin
      For i :=0 To cdsDados.Fields.Count -1 do
      If Pos(cdsDados.Fields[i].FieldName, strCampos) > 0 Then
        qryComand.ParamByName(cdsDados.Fields[i].FieldName).Value := cdsDados.Fields[i].Value;
      qryComand.ExecSQL;
      cdsDados.Next;
    End;
  Finally
    FreeAndNil(qryComand);
  End;
end;

Procedure TOrdProIndustrial.pImprimeDesenvOP;
Begin
  Try
    pImprimeOrdemProducao;
    pImprimeProcessoDeExtrusao(recImpres.strAutImp);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TOrdProIndustrial.pImprimeDesenvOP]');
    End;
  End;
End;

function TOrdProIndustrial.fValidaAnalise(strSeqOpi : String) : boolean;
  var
    qryAnaGer : TUniQuery;

  function fLiberaAnalise : boolean;
  var
    qryOrdPro   : TUniQuery;
  begin
    qryOrdPro := fCriaQuery(nil);
    try

      qryOrdPro.SQL.Add('SELECT SQL_NO_CACHE                             ');
      qryOrdPro.SQL.Add('  ORD_CODORD AS CODORD,                         ');
      qryOrdPro.SQL.Add('  ORD_DTACAD AS DTACAD,                         ');
      qryOrdPro.SQL.Add('  ORD_CODITE AS CODITE,                         ');
      qryOrdPro.SQL.Add('  ITE_DESITE AS DESITE                          ');
      qryOrdPro.SQL.Add('FROM                                            ');
      qryOrdPro.SQL.Add('  ORDGER                                        ');
      qryOrdPro.SQL.Add('  INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE  ');
      qryOrdPro.SQL.Add('WHERE                                           ');
      qryOrdPro.SQL.Add('  ORDGER.AUTOINCREM = :AUTINC                   ');
      qryOrdPro.ParamByName('AUTINC').AsString := strSeqOpi;
      qryOrdPro.Open;

      objLiberacao.clear;

      //Título
      objLiberacao.objMsgLibera.pAddTexto('Baixa de Ordem de Produção sem Análise de Qualidade Baixada');

      objLiberacao.objMsgLibera.pAddSeparador(120);

      //Ordem de Produção
      objLiberacao.objMsgLibera.pAddTextoCaption('N.Ordem de Produção', qryOrdPro.FieldByName('CODORD').AsString + '-' + DateToStr(qryOrdPro.FieldByName('DTACAD').AsDateTime), 20);
      objLiberacao.objMsgLibera.pAddTextoCaption('Produto Granel'     , qryOrdPro.FieldByName('CODITE').AsString + '-' + qryOrdPro.FieldByName('DESITE').AsString             , 20);

      objLiberacao.strDirAce := 'LANAOI';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnUsarSenhaFixa := False;
      objLiberacao.blnSempreVariavelUsuario := True;

      Result := objLiberacao.fLibera;

    finally
        FreeAndNil(qryOrdPro);
    end;

  end;

begin
  Result := fCfgSis('TRAANA', varString) = 'N';

  if not Result then
  begin
    qryAnaGer := fCriaQuery(nil);
    try
      qryAnaGer.SQL.Add('SELECT                       ');
      qryAnaGer.SQL.Add('  COUNT(0) AS QTD            ');
      qryAnaGer.SQL.Add('FROM                         ');
      qryAnaGer.SQL.Add('  ANAGER                     ');
      qryAnaGer.SQL.Add('WHERE                        ');
      qryAnaGer.SQL.Add('      GER_SEQOPI = :SEQOPI   ');
      qryAnaGer.SQL.Add('  AND GER_DTABAI IS NOT NULL ');
      qryAnaGer.ParamByName('SEQOPI').AsString := strSeqOpi;
      qryAnaGer.Open;

      Result := qryAnaGer.FieldByName('QTD').AsInteger > 0;
      if not Result then
      begin

        case AnsiIndexStr(fCfgSis('TRAANA', varString), ['T', 'A']) of
          0 : Result := fLiberaAnalise;
          1 :
             begin
               Result := True;
               pMensagemOk('Ordem de Produção sem Análise de Qualidade Baixada!');
             end;
        end;

      end;
    finally
      FreeAndNil(qryAnaGer);
    end;
  end;
end;


function TOrdProIndustrial.fValidaBaixa(strSeqOpi: String): boolean;
begin
  Result := fValidaAnalise(strSeqOpi);
  Result := Result and fValidaConferenciaEnvase(strSeqOpi);
end;

function TOrdProIndustrial.fValidaConferenciaEnvase(strSeqOpi : String) : boolean;
  var
    qryConferencia : TUniQuery;

  function fLiberaConferencia : boolean;
  var
    qryOrdPro   : TUniQuery;
  begin
    qryOrdPro := fCriaQuery(nil);
    try

      qryOrdPro.SQL.Add('SELECT SQL_NO_CACHE                             ');
      qryOrdPro.SQL.Add('  ORD_CODORD AS CODORD,                         ');
      qryOrdPro.SQL.Add('  ORD_DTACAD AS DTACAD,                         ');
      qryOrdPro.SQL.Add('  ORD_CODITE AS CODITE,                         ');
      qryOrdPro.SQL.Add('  ITE_DESITE AS DESITE                          ');
      qryOrdPro.SQL.Add('FROM                                            ');
      qryOrdPro.SQL.Add('  ORDGER                                        ');
      qryOrdPro.SQL.Add('  INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE  ');
      qryOrdPro.SQL.Add('WHERE                                           ');
      qryOrdPro.SQL.Add('  ORDGER.AUTOINCREM = :AUTINC                   ');
      qryOrdPro.ParamByName('AUTINC').AsString := strSeqOpi;
      qryOrdPro.Open;

      objLiberacao.clear;

      //Título
      objLiberacao.objMsgLibera.pAddTexto('Baixa de Ordem de Produção sem concluir a conferência de Envase');

      objLiberacao.objMsgLibera.pAddSeparador(120);

      //Ordem de Produção
      objLiberacao.objMsgLibera.pAddTextoCaption('N.Ordem de Produção', qryOrdPro.FieldByName('CODORD').AsString + '-' + DateToStr(qryOrdPro.FieldByName('DTACAD').AsDateTime), 20);
      objLiberacao.objMsgLibera.pAddTextoCaption('Produto Granel'     , qryOrdPro.FieldByName('CODITE').AsString + '-' + qryOrdPro.FieldByName('DESITE').AsString             , 20);

      objLiberacao.strDirAce := 'CEVOPI';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnUsarSenhaFixa := False;

      Result := objLiberacao.fLibera;

    finally
        FreeAndNil(qryOrdPro);
    end;

  end;

begin
  Result := not FUtilizaConferencia;

  if not Result then
  begin
    qryConferencia := fCriaQuery(nil);
    try
      qryConferencia.SQL.Add('SELECT                     ');
      qryConferencia.SQL.Add('  COUNT(0) AS QTD          ');
      qryConferencia.SQL.Add('FROM                       ');
      qryConferencia.SQL.Add('  ORDDET                   ');
      qryConferencia.SQL.Add('WHERE ORD_OPECON IS NULL   ');
      qryConferencia.SQL.Add('  AND ORD_QTDPRO > 0       ');
      qryConferencia.SQL.Add('  AND ORD_SEQGER = :SEQOPI ');
      qryConferencia.ParamByName('SEQOPI').AsString := strSeqOpi;
      qryConferencia.Open;

      Result := qryConferencia.FieldByName('QTD').AsInteger = 0;
      if not Result then
        Result := fLiberaConferencia;
    finally
      FreeAndNil(qryConferencia);
    end;
  end;
end;

Function TOrdProIndustrial.fExisteLoteOP(qryOrdPro: TUniQuery;
  strNumLot: String): Boolean;
Var
  strDtaCad: String;
Begin
  Try
    strDtaCad := LeftStr(strNumLot, 6);
    system.Insert('/', strDtaCad, 3);
    system.Insert('/', strDtaCad, 6);

    FOrdemProducao.Clear;

    With qryOrdPro, SQL Do
    Begin
      Clear;
      Close;

      Add('SELECT SQL_NO_CACHE');
      Add('  G.AUTOINCREM AS AUTINC, ');
      Add('  ORD_CODORD AS CODORD,   ');
      Add('  ORD_DTACAD AS DTACAD,   ');
      Add('  ORD_CODITE AS CODITE,   ');
      Add('  ORD_CODCOR AS CODCOR,   ');
      Add('  ORD_DTABAI AS DTABAI,   ');
      Add('  ORD_CODOPE AS CODOPE,   ');
      Add('  OPE_NOMOPE AS NOMOPE,   ');
      Add('  ITE_DESITE AS DESITE,   ');
      Add('  COR_DETCOR AS DETCOR,   ');
      Add('  COR_DESCOR AS DESCOR,   ');
      Add('  ORD_BAINPD AS BAINPD,   ');
      Add('  UNI_KILLIT AS KILLIT,   ');
      Add('  G.*                     '); // USADO PARA VALIDAR O ESTOQUE DOS SUB-ITENS NA BAIXA DA O.P.
      Add('FROM');
      Add('  ORDGER G');
      Add('INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE');
      Add('INNER JOIN CADCOR ON COR_CODCOR = ORD_CODCOR');
      Add('LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
      Add('LEFT JOIN CADOPE ON ORD_CODOPE = OPE_CODOPE');
      Add('WHERE');
      Add('  ORD_CODORD = :CODORD AND');
      Add('  ORD_DTACAD = :DTACAD AND');
      Add('  ORD_CODEMP = :CODEMP    ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODORD').AsString := RightStr(strNumLot, 3);
      ParamByName('DTACAD').AsDate := StrToDateDef(strDtaCad, 0);

      Open;

      Result := Not IsEmpty;

      if Result then
      begin
        FOrdemProducao.strAutoincrem := FieldByName('AUTINC').AsString;
        FOrdemProducao.dtaDataCadastro := FieldByName('DTACAD').AsDateTime;
        FOrdemProducao.strCodigo := FieldByName('CODORD').AsString;
        FOrdemProducao.strCodigoOperador := FieldByName('CODOPE').AsString;
        FOrdemProducao.strNomeOperador := FieldByName('NOMOPE').AsString;
        FOrdemProducao.objFormula.fltPesoReal := FieldByName('ORD_PESREA').AsFloat;
        FOrdemProducao.objFormula.objProdutoGranel.strCodigo := FieldByName('CODITE').AsString;
        FOrdemProducao.objFormula.objProdutoGranel.strDescricao := FieldByName('DESITE').AsString;
        FOrdemProducao.objFormula.objProdutoGranel.enuMedidaUnidade := fStrToTipoMedidaUnidade(FieldByName('KILLIT').AsString);
        FOrdemProducao.objFormula.objCor.strCodigo := FieldByName('CODCOR').AsString;
        FOrdemProducao.objFormula.objCor.strDescricao := FieldByName('DESCOR').AsString;
      end;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fExisteLoteOP]');
    End;
  End;
End;

Function TOrdProIndustrial.fExisteLoteOP(qryOrdPro: TUniQuery;
  strCodOrd: String; dtaDtaCad: TDate): Boolean;
Begin
  Result := fExisteLoteOP(qryOrdPro, FormatDateTime('DDMMYY', dtaDtaCad) + '-' + strCodOrd);
End;

function TOrdProIndustrial.fGravaOrdOri(strSeqGer, strSeqUsa: String;
  fltQtdUsa, fltUsaEst, fltQtdSub: Double): Boolean;
Var
  qryInsert: TUniQuery;
begin
  Try
    qryInsert := fCriaQuery(Self);

    With qryInsert, SQL Do
    Begin
      Add(' INSERT ORDORI (    ');
      Add('        AUTOINCREM, ');
      Add('        ORD_SEQGER, ');
      Add('        ORD_SEQUSA, ');
      Add('        ORD_QTDUSA, ');
      Add('        ORD_USAEST, ');
      Add('        ORD_QTDSUB) ');
      Add(' VALUES (           ');
      Add('       :AUTOIN,     ');
      Add('       :SEQGER,     ');
      Add('       :SEQUSA,     ');
      Add('       :QTDUSA,     ');
      Add('       :USAEST,     ');
      Add('       :QTDSUB)     ');

      ParamByName('AUTOIN').AsString := fRetAutoIncrem('ORDORI', VS_strCodEmp);
      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('SEQUSA').AsString := strSeqUsa;
      ParamByName('QTDUSA').AsFloat := fltQtdUsa;
      ParamByName('USAEST').AsFloat := fltUsaEst;
      ParamByName('QTDSUB').AsFloat := fltQtdSub;
      Try
        Result := True;
        ExecSQL;
      Except
        on E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, 'TOrdProIndustrial.fGravaOrdOri');
        end;
      End;

    End;

  Finally
    FreeAndNil(qryInsert);
  End;

end;

Procedure TOrdProIndustrial.pAtulizaCamposBaixaOP(strAutInc: String;
  strSeqOPI: String; dtaDtaIni, horHorIni, dtaDtaFin, horHorFin,
  dtaDtaBai: TDateTime; fltCusOrd: Double; strLocFis, strAutIncLT : String; blnParcial : Boolean;
  strCodQui, strCodEnc, strCodLim, strCodQua, strSeqCpn : String);
Var
  qryOrdGer: TUniQuery;
Begin
  qryOrdGer := fCriaQuery(Self);

  With qryOrdGer, SQL Do
  Begin
    Close;
    Clear;
    Add(' INSERT INTO ORDBAI(AUTOINCREM, ORB_SEQOPI, ORB_SEQGER, ORB_TIPBAI) ');
    Add('            VALUES (:AUTINC, :SEQOPI, :SEQGER, :TIPBAI)             ');

    ParamByName('AUTINC').AsString := fRetAutoIncrem('ORDBAI', VS_strCodEmp);
    ParamByName('SEQOPI').AsString := Self.FieldByName('ORD_SEQGER').AsString;
    ParamByName('SEQGER').AsString := strSeqOPI;
    ParamByName('TIPBAI').AsString := IfThen(blnParcial, 'P', 'T');
    ExecSQL;

    if not blnParcial Then
    Begin
      Close;
      Clear;

      Add('UPDATE ORDGER SET');

      Add('  ORD_CUSORD = :CUSORD,');

      Add('  ORD_DTAINI = :DTAINI,');
      Add('  ORD_HORINI = :HORINI,');

      Add('  ORD_DTAFIN = :DTAFIN,');
      Add('  ORD_HORFIN = :HORFIN,');

      Add('  ORD_DTABAI = :DTABAI,');
      Add('  ORD_OPEBAI = :OPEBAI, ');

      //Add('  ORD_SEQOPI = :SEQOPI,'); esse campo tornou-se obsoleto, olhar tabela ORDBAI
      Add('  ORD_LOCORP = :LOCORP,');
      Add('  ORD_SEQ_TL = :SEQ_TL,');
      Add('  ORD_DTAVAL = :DTAVAL,');
      Add('  ORD_TOTKIL = :TOTKIL,');
      Add('  ORD_TOTLIT = :TOTLIT,');
      Add('  ORD_CODQUI = :CODQUI,');
      Add('  ORD_CODENC = :CODENC,');
      Add('  ORD_CODLIM = :CODLIM,');
      Add('  ORD_CODQUA = :CODQUA,');
      Add('  ORD_SEQCPN = :SEQCPN ');


      Add('WHERE ');
      Add('  AUTOINCREM = :AUTINC AND ');
      Add('  ORD_CODEMP = :CODEMP      ');

      ParamByName('DTAINI').AsDate     := dtaDtaIni;
      ParamByName('HORINI').AsDateTime := horHorIni;
      ParamByName('DTAFIN').AsDate     := dtaDtaFin;
      ParamByName('HORFIN').AsDateTime := horHorFin;
      ParamByName('DTABAI').AsDate     := dtaDtaBai;
      ParamByName('OPEBAI').AsString   := strLoginUsuarioLogado;
      //ParamByName('SEQOPI').AsString   := strSeqOPI;
      ParamByName('CUSORD').AsFloat    := fltCusOrd;

      If Not fEmptyStr(strLocFis) Then
        ParamByName('LOCORP').AsString := strLocFis
      Else
        ParamByName('LOCORP').Clear;

      If Not fEmptyStr(strAutIncLT) Then
        ParamByName('SEQ_TL').AsString := strAutIncLT
      Else
        ParamByName('SEQ_TL').Clear;

      ParamByName('AUTINC').AsString   := strAutInc;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;

      ParamByName('DTAVAL').AsDateTime := FDtaVal;
      ParamByName('TOTKIL').AsFloat    := Self.fRetSoma('PESENV');
      ParamByName('TOTLIT').AsFloat    := Self.fRetSoma('PESENV') / Self.FieldByName('PESREA').AsFloat;

      ParamByName('CODQUI').AsString := strCodQui;
      ParamByName('CODENC').AsString := strCodEnc;
      ParamByName('CODLIM').AsString := strCodLim;
      ParamByName('CODQUA').AsString := strCodQua;

      If ParamByName('CODQUI').AsString = '' Then
        ParamByName('CODQUI').Clear;

      If ParamByName('CODENC').AsString = '' Then
        ParamByName('CODENC').Clear;

      If ParamByName('CODLIM').AsString = '' Then
        ParamByName('CODLIM').Clear;

      If ParamByName('CODQUA').AsString = '' Then
        ParamByName('CODQUA').Clear;

      If strSeqCpn <> '' then
        ParamByName('SEQCPN').AsString := strSeqCpn
      Else
      ParamByName('SEQCPN').Value := Null;

      ExecSQL;
    End;
  End;

  FreeAndNil(qryOrdGer);
End;

Function TOrdProIndustrial.fAtualizaUltimaCompraAcabado(strCodIte: String; fltPreCom, fltQtdIte: Double; strAgrupadorPreAlt: String): Boolean;
Var
  qryIteGer: TUniQuery;
  qryIteSav: TUniQuery;
  intContador: Integer;
  cpcParams: TParCalculaPrecoCusto;
Begin
  Result := True;
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  qryIteGer := fCriaQuery(Self);
  qryIteSav := fCriaQuery(Self);

  With qryIteGer, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM ITEGER');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE AND ');
    Add('  LOCATE(ITE_CODEMP,"' + fRetEmpresasUsamPrecoMatriz + '") > 0 ');

    ParamByName('CODITE').AsString := strCodIte;

    Open;

    qryIteSav.SQL.Text := qryIteGer.SQL.Text + ' AND ITE_CODEMP = :CODEMP ';

    While not Eof Do
    Begin
      qryIteSav.Close;
      qryIteSav.ParamByName('CODITE').AsString := strCodIte;
      qryIteSav.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
      qryIteSav.Open;

      If IsEmpty Then
      Begin
        Result := False;
        pMensagemOk('Produto acabado ' + strCodIte + ' não encontrado (ITEGER)!');
      End
      Else
      Begin
        Edit;

        FieldByName('ITE_FORULT').AsString := fCampoTabela('EMP_FORFIL', 'CADEMP', ['EMP_CODEMP'], [FieldByName('ITE_CODEMP').AsString]);

        If fEmptyStr(FieldByName('ITE_FORULT').AsString) Then
          FieldByName('ITE_FORULT').Clear;

        FieldByName('ITE_DTAULT').AsDateTime := VS_Date;
        FieldByName('ITE_QTDUCO').AsFloat := fltQtdIte;
        FieldByName('ITE_PREULT').AsFloat := fltPreCom;
        FieldByName('ITE_PREALT').AsString := strAgrupadorPreAlt;

        If fCfgSis('ATPRBI', varBoolean) Then
        Begin
          FieldByName('ITE_PRECOM').AsFloat := fltPreCom;

          With cpcParams Do
          Begin
            curPreCom := FieldByName('ITE_PRECOM').AsFloat;
            curDesF01 := FieldByName('ITE_DESF01').AsFloat;
            curDesF02 := FieldByName('ITE_DESF02').AsFloat;
            curDesF03 := FieldByName('ITE_DESF03').AsFloat;
            curDesF04 := FieldByName('ITE_DESF04').AsFloat;
            curDesF05 := FieldByName('ITE_DESF05').AsFloat;
            curDesF06 := FieldByName('ITE_DESF06').AsFloat;
            curICMSEnt := FieldByName('ITE_ICMENT').AsFloat;
            curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
            curFrete := FieldByName('ITE_FREENT').AsFloat;
            curValFre := FieldByName('ITE_VALFRE').AsFloat;
            curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
            curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
            curDesAdb := FieldByName('ITE_DESADB').AsFloat;
            curSubFed := FieldByName('ITE_SUBFED').AsFloat;

            if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
            begin
              curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
              curTSCust := FieldByName('ITE_TSCUST').AsFloat;
              curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
              curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
              curFatReg := FieldByName('ITE_FATREG').AsFloat;
            end
            else
            begin
              curTCIFCu := 0;
              curTSCust := 0;
              curDePiCo := 0;
              curDeICMS := 0;
              curFatReg := 0;
            end;

            FieldByName('ITE_PRECUS').AsFloat := fCalculaPrecoCusto();

            If (FExibeResumoDeCalculoOPITela) And (FBaixaOrdem) Then
            Begin
              If cdsCustoProducao.Locate('CODITE', FieldByName('ITE_CODITE').AsString, []) then
              Begin
                cdsCustoProducao.Edit;
                cdsCustoProducao.FieldByName('CUSFIN').AsFloat := FieldByName('ITE_PRECUS').AsFloat;
                cdsCustoProducao.Post;
              End;
            End;


          End;

          For intContador := 1 To Length(VS_strTabPrc) Do
          Begin
            If fCfgSis('INDPR' + IntToStr(intContador)) = 'M' Then
              FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat := fCalculaPrecoVenda(2, FieldByName('ITE_PRECUS').AsFloat +
                                                                                             FieldByName('ITE_OUTVAL').AsFloat,
                                                                                             FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat, 0,
                                                                                             FieldByName('ITE_ICMSAI').AsFloat, FieldByName('ITE_IMPFED').AsFloat,
                                                                                             FieldByName('ITE_DESOPE').AsFloat,
                                                                                             FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat)
            Else
              FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat := fCalculaPrecoVenda(1, FieldByName('ITE_PRECUS').AsFloat +
                                                                                             FieldByName('ITE_OUTVAL').AsFloat,
                                                                                             FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat,
                                                                                             FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat,
                                                                                             FieldByName('ITE_ICMSAI').AsFloat, FieldByName('ITE_IMPFED').AsFloat,
                                                                                             FieldByName('ITE_DESOPE').AsFloat,
                                                                                             FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat)
        End;

        FieldByName('ITE_PREMED').AsFloat := fCalculaPrecoMedio('',// Código Fiscal
                                                                '', // Classificação Fiscal
                                                                FieldByName('ITE_PREMED').AsFloat, // Preço medio anterior
                                                                FieldByName('ITE_SALDOS').AsFloat, // Saldo anterior
                                                                fltQtdIte, // Quantidade de entrada
                                                                  fltPreCom, // Unitario sem impostos
                                                                  0, // Aliquota de ICMS do Item
                                                                  0, // Valor do IPI
                                                                  0, // Valor de Substituição
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  False, // Contribuinte de IPI?
                                                                  True,
                                                                  'N', // Indice se incide Pis
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  nil,
                                                                  False);

        End;
        Post;
        If (Not VS_blnPreAltViaTrigger) Then
          If fCfgSis('ATPRBI', varBoolean) Then
            Result := fGravaPreAlt(FieldByName('ITE_CODITE').AsString,
                                 qryIteSav.FieldByName('ITE_PRECUS').AsFloat,
                                 FieldByName('ITE_PRECUS').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE1').AsFloat,
                                 FieldByName('ITE_PREVE1').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR1').AsFloat,
                                 FieldByName('ITE_MARBR1').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE2').AsFloat,
                                 FieldByName('ITE_PREVE2').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR2').AsFloat,
                                 FieldByName('ITE_MARBR2').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE3').AsFloat,
                                 FieldByName('ITE_PREVE3').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR3').AsFloat,
                                 FieldByName('ITE_MARBR3').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE4').AsFloat,
                                 FieldByName('ITE_PREVE4').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR4').AsFloat,
                                 FieldByName('ITE_MARBR4').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE5').AsFloat,
                                 FieldByName('ITE_PREVE5').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR5').AsFloat,
                                 FieldByName('ITE_MARBR5').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE6').AsFloat,
                                 FieldByName('ITE_PREVE6').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR6').AsFloat,
                                 FieldByName('ITE_MARBR6').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE7').AsFloat,
                                 FieldByName('ITE_PREVE7').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR7').AsFloat,
                                 FieldByName('ITE_MARBR7').AsFloat,

                                 qryIteSav.FieldByName('ITE_PRECOM').AsFloat,
                                 FieldByName('ITE_PRECOM').AsFloat,

                                 'BAIXA DE ORDEM DE PRODUCAO - fAtualizaUltimaCompraAcabado',

                                 Nil,
                                 FieldByName('ITE_CODEMP').AsString,
                                 strLoginUsuarioLogado);

        Next;
      End;
    End;
  End;

  FreeAndNil(qryIteGer);
  FreeAndNil(qryIteSav);
  FreeAndNil(cpcParams);
End;

Function TOrdProIndustrial.fCustoComposicao(strIncOrdDet : String; fltQtdEnv : Double): Double;
Begin
  Result := 0.00;

  if fltQtdEnv > 0.00 then
  begin
    Try
      cdsOrdCom.Filter   := 'ODC_SEQDET = ' + QuotedStr(strIncOrdDet);
      cdsOrdCom.Filtered := True;
      cdsOrdCom.First;

      While Not cdsOrdCom.Eof Do
      Begin
        Result := Result + (cdsOrdCom.FieldByName('ODC_TOTCUS').AsFloat);
        cdsOrdCom.Next;
      End;

      If Result > 0 Then
        Result := Result / fltQtdEnv
      Else
        Result := 0;

    Finally
      cdsOrdCom.Filtered := False;
      cdsOrdCom.Filter   := '';
      cdsOrdCom.First;
    End;
  end;

End;

Function TOrdProIndustrial.fRetAutoIncremGEIMAT(strCodIte, strCodCor, strCodFormula : String):String;
  Var
    qryGenerico : TUniQuery;
Begin
  qryGenerico := fCriaQuery(Self);
  Try

    qryGenerico.Close;
    qryGenerico.SQL.Clear;
    qryGenerico.SQL.Add(' SELECT                     ');
    qryGenerico.SQL.Add('   AUTOINCREM               ');
    qryGenerico.SQL.Add(' FROM                       ');
    qryGenerico.SQL.Add('   GEIMAT                   ');
    qryGenerico.SQL.Add(' WHERE GMT_CODITE = :CODITE ');
    qryGenerico.SQL.Add('   AND GMT_CODCOR = :CODCOR ');
    qryGenerico.SQL.Add('   AND GMT_CODEMP = :CODEMP ');

    If Not(fEmptyStr(strCodFormula)) Then
      qryGenerico.SQL.Add('   AND GMT_FORMUL = :FORMUL ')
    Else
      qryGenerico.SQL.Add('   AND GMT_STATUS = "A"     ');

    qryGenerico.ParamByName('CODITE').AsString := strCodIte;
    qryGenerico.ParamByName('CODCOR').AsString := strCodCor;
    qryGenerico.ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Not(fEmptyStr(strCodFormula)) Then
      qryGenerico.ParamByName('FORMUL').AsString := strCodFormula;

    qryGenerico.Open;

    if qryGenerico.isEmpty then
      Result := ''
    else
      Result := qryGenerico.FieldByName('AUTOINCREM').AsString;

    qryGenerico.Close;

  Finally
    FreeAndNil(qryGenerico);
  End;

End;


Function TOrdProIndustrial.fRetCapacidadeMaximaFormula(strCodIte, strCodCor : String):Double;
  Var
    qryFormula : TUniQuery;
Begin
  qryFormula := fCriaQuery(Self);
  Try

    qryFormula.Close;
    qryFormula.SQL.Clear;
    qryFormula.SQL.Add(' SELECT                     ');
    qryFormula.SQL.Add('   GMT_CAPMAX               ');
    qryFormula.SQL.Add(' FROM                       ');
    qryFormula.SQL.Add('   GEIMAT                   ');
    qryFormula.SQL.Add(' WHERE GMT_CODITE = :CODITE ');
    qryFormula.SQL.Add('   AND GMT_CODCOR = :CODCOR ');
    qryFormula.SQL.Add('   AND GMT_STATUS = "A"     ');

    qryFormula.ParamByName('CODITE').AsString := strCodIte;
    qryFormula.ParamByName('CODCOR').AsString := strCodCor;

    qryFormula.Open;

    if qryFormula.isEmpty then
      Result := 0
    else
      Result := qryFormula.FieldByName('GMT_CAPMAX').AsFloat;

    qryFormula.Close;

  Finally
    FreeAndNil(qryFormula);
  End;
End;

Function TOrdProIndustrial.fRetCapacidadeMaximaOrdemProducao(strAutInc : String):Double;
  Var
    qryOrdemProducao : TUniQuery;
Begin
  qryOrdemProducao := fCriaQuery(Self);
  Try

    qryOrdemProducao.Close;
    qryOrdemProducao.SQL.Clear;
    qryOrdemProducao.SQL.Add(' SELECT                     ');
    qryOrdemProducao.SQL.Add('   ORD_CAPMAX               ');
    qryOrdemProducao.SQL.Add(' FROM                       ');
    qryOrdemProducao.SQL.Add('   ORDGER                   ');
    qryOrdemProducao.SQL.Add(' WHERE AUTOINCREM = :AUTINC ');

    qryOrdemProducao.ParamByName('AUTINC').AsString := strAutInc;
    qryOrdemProducao.Open;

    if qryOrdemProducao.isEmpty then
      Result := 0
    else
      Result := qryOrdemProducao.FieldByName('ORD_CAPMAX').AsFloat;

    qryOrdemProducao.Close;

  Finally
    FreeAndNil(qryOrdemProducao);
  End;
End;

Function TOrdProIndustrial.fRetPesoEspecifico(strCodIte, strCodCor : String):Double;
  Var
    qryPeso : TUniQuery;
    intMaxSeqGer: Integer;
    fltTotPercen,
    fltTotCusIte,
    fltTotDensid,
    fltPVC,
    fltCPVC,
    fltPVCCPVC,
    fltMassaSolidos,
    fltVolumeSolidos : Double;
Begin
  qryPeso := fCriaQuery(Self);
  Try
    With qryPeso, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT DMT_SEQUEN,                                  ');
      Add('        DMT_QTDITE,                                  ');
      Add('        0.00 AS DMT_CUSITE,                          ');
      Add('        ITE_DENSID AS DMT_DENSID                     ');
      Add(' FROM DEIMAT                                         ');
      Add(' INNER JOIN GEIMAT ON GEIMAT.AUTOINCREM = DMT_SEQGER ');
      Add(' INNER JOIN CADITE ON ITE_CODITE = DMT_ITESUB        ');
      Add(' WHERE GMT_CODITE = :CODITE                          ');
      Add('   AND GMT_CODCOR = :CODCOR                          ');
      Add('   AND GMT_STATUS = "A"                              ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODCOR').AsString := strCodCor;

      Open;

      pCalculaPesoEspecificoSubItens(qryPeso, intMaxSeqGer, fltTotPercen, fltTotCusIte, fltTotDensid,
                                     fltPVC, fltCPVC, fltPVCCPVC, fltMassaSolidos, fltVolumeSolidos);

      Result := fltTotDensid;

      Close;

    End;
  Finally
    FreeAndNil(qryPeso);
  End;
End;

Function TOrdProIndustrial.fAtualizaPesoAcabado(objProdutoAcabado : TProdutoAcabado; blnFormulaEspecial : boolean): Boolean;
Var
  fltPesoLiquido, fltPesoBruto: Double;
  qryCadIte : TUniQuery;
Begin
  // se for fórmula especial ( sem itens na estrutura), soma apenas o peso da composição
  if blnFormulaEspecial then
  begin
    fltPesoLiquido := objProdutoAcabado.objComposicao.fRetornaPeso;
    fltPesoBruto := fltPesoLiquido;
  end
  else
  begin
    fltPesoLiquido := objProdutoAcabado.fRetornaPesoUnitario;
    fltPesoBruto := fltPesoLiquido + objProdutoAcabado.objComposicao.fRetornaPeso;
  end;

  qryCadIte := fCriaQuery(nil);
  try
    Result := False;

    qryCadIte.Close;
    qryCadIte.SQL.Clear;
    qryCadIte.SQL.Add('UPDATE CADITE SET           ');
    qryCadIte.SQL.Add('ITE_PESLIQ = :PESO_LIQUIDO, ');
    qryCadIte.SQL.Add('ITE_PESOIT = :PESO_BRUTO    ');
    qryCadIte.SQL.Add('WHERE                       ');
    qryCadIte.SQL.Add('  ITE_CODITE = :CODIGO_ITEM ');

    qryCadIte.ParamByName('CODIGO_ITEM').AsString := objProdutoAcabado.strCodigo;
    qryCadIte.ParamByName('PESO_LIQUIDO').AsFloat := fltPesoLiquido;
    qryCadIte.ParamByName('PESO_BRUTO').AsFloat   := fltPesoBruto;

    qryCadIte.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryCadIte);
  end;
End;

function TOrdProIndustrial.fTemDivergenciaQuantidadeBaixadaComSolitado(
  strAutInc: String; var strErro: string): Boolean;
var qryVal: TUniQuery;
begin
  qryVal := fCriaQuery;
  Try
    qryVal.SQL.Add('SELECT SUM(IFNULL(ORDCOM.ODC_QTDUSA,0) ) + ');
    qryVal.SQL.Add('       IFNULL((SELECT SUM(DMT_QTDITE)FROM DEICOR WHERE DMT_SEQORD = ORD_SEQGER AND DMT_ITESUB = ODC_CODITE), 0) QTDENV,');
    qryVal.SQL.Add('       IFNULL((SELECT  SUM(MOVDET.DET_QTDITE * IF(DET_CLAFIS > 5000, 1, -1)) FROM MOVDET WHERE DET_SEQGER = ORB_SEQGER AND DET_CODITE = ODC_CODITE), 0) AS QTDMOV, ODC_CODITE');
    qryVal.SQL.Add('  FROM ORDDET');
    qryVal.SQL.Add('  LEFT JOIN ORDCOM ON ORDCOM.ODC_SEQDET = ORDDET.AUTOINCREM');
    qryVal.SQL.Add(' INNER JOIN ORDBAI ON  ORB_SEQOPI = ORD_SEQGER');
    qryVal.SQL.Add(' INNER JOIN ORDGER ON ORDGER.AUTOINCREM = ORD_SEQGER');
    qryVal.SQL.Add(' LEFT JOIN CADITE ON ITE_CODITE = ODC_CODITE');
    qryVal.SQL.Add(' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
    qryVal.SQL.Add(' WHERE TRUE');
    qryVal.SQL.Add('  AND ORD_SEQGER = "'+strAutInc+'"');
    qryVal.SQL.Add('        AND ORDBAI.ORB_TIPBAI = "T"');
    qryVal.SQL.Add('        AND ORD_QTDENV > 0');
    qryVal.SQL.Add('      GROUP BY ORD_SEQGER, ODC_CODITE');
    qryVal.SQL.Add('HAVING  QTDENV <> QTDMOV');
    qryVal.Open;

    Result := Not qryVal.IsEmpty;

    If Result Then
    Begin
      While not qryVal.Eof Do
      Begin
        strErro :=  strErro + #$A#$D + 'Item: ' + qryVal.FieldByName('ODC_CODITE').AsString + ' ' +
                    'Qtd OP: ' + qryVal.FieldByName('QTDENV').AsString + ' ' +
                    'Qtd OI: ' + qryVal.FieldByName('QTDMOV').AsString ;
        qryVal.Next;
      End;
    End;


  Finally
    FreeAndNil(qryVal)
  End;
end;

function TOrdProIndustrial.fValidaQuantidadeCopias(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  intQtdCopias : integer;
begin

  Result := (Sender is TEditFocus);
  if Result then
  begin
    if TryStrToInt( (Sender as TEditFocus).Text, intQtdCopias) then
    begin
      if intQtdCopias <= 0 then
      begin
        Result := False;
        fMensagem('', 'A quantidade deve ser maior que zero!', ['&OK']);
      end;
    end
    else
    begin
      Result := False;
      fMensagem('', 'Informe uma quantidade válida!', ['&OK']);
    end;
  end;

end;

function TOrdProIndustrial.fValidaQuantidadesDigitadas : Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
	  objLinha  : TLinhaMsgLibera;

    fltQtdEnvasado : Double;
    fltPercent : Double;
    fltTotPla : Double;
    fltTotEnv : Double;
    blnSenha : Boolean;
Begin
  blnSenha := False;
  objLiberacao.clear;
  objTabela := TRegistroMsgLiberaTabela.Create;
  Try
    Self.DisableControls;
    Self.First;
    While Not Self.Eof Do
    Begin
      fltQtdEnvasado := Self.FieldByName('ORD_QTDENV').AsFloat + fRetQtdeBaixaParcial(Self.FieldByName('ORD_CODITE').AsString);

      If Self.FieldByName('ORD_QTDPRO').AsFloat <> fltQtdEnvasado Then
      Begin
        blnSenha := True;
        If objTabela.isEmpty Then
        Begin
          objLiberacao.objMsgLibera.pAddTexto('DIFERENÇA ENTRE QUANTIDADE ORIGINAL DE PRODUÇÃO E QUANTIDADE ENVASADA');

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'Código'         , fTamCodIte  , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'Descrição'      , 68 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'Qtde. O.P.'     , 18 , alDireita   , teAutcom);
          objLinha.pAddColuna(''  , 'Qtde. Envasado' , 18 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);
        End;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Código'         , FieldByName('ORD_CODITE').AsString                         , fTamCodIte  , alEsquerda);
        objLinha.pAddColuna('Descrição'      , FieldByName('DESITE').AsString                             , 68 , alEsquerda);
        objLinha.pAddColuna('Qtde. O.P.'     , FormatFloat('#,##0.00', FieldByName('ORD_QTDPRO').AsFloat) , 18 , alDireita );
        objLinha.pAddColuna('Qtde. Envasado' , FormatFloat('#,##0.00', fltQtdEnvasado)                    , 18 , alDireita );
        objTabela.lstLinhas.Add(objLinha);

      End;

      Self.Next;
    End;
    Self.First;
  Finally
    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    Self.EnableControls;
  End;

  If (objCorrOP.RecordCount > 0) Then
  Begin
    blnSenha := True;

    objLiberacao.objMsgLibera.pAddTexto('CORREÇÕES DA ORDEM DE PRODUÇÃO');

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Código'          , fTamCodIte + 1  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Descrição'       , 88 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Qtde. Utilizada' , 18 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    Try
      objCorrOP.DisableControls;
      objCorrOP.First;
      While not objCorrOP.Eof Do
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Código'          , objCorrOP.FieldByName('DMT_ITESUB').AsString                         , fTamCodIte + 1  , alEsquerda );
        objLinha.pAddColuna('Descrição'       , objCorrOP.FieldByName('DMT_REFERE').AsString                         , 88 , alEsquerda );
        objLinha.pAddColuna('Qtde. Utilizada' , FormatFloat('#,##0.00', objCorrOP.FieldByName('DMT_QTDITE').AsFloat) , 18 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        objCorrOP.Next;
      End;
    Finally
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
      objCorrOP.First;
      objCorrOP.EnableControls;
    End;

  End;

  If not blnSenha Then
  Begin
    Result := True;
    Exit;
  End;

  //Calcula Custos para exibir na trava.
  pAtualizaCustoTotalParaExibirDiferencas;

  objLiberacao.objMsgLibera.pAddTexto('CUSTOS');
  objTabela := TRegistroMsgLiberaTabela.Create;
  Try


    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Código'          , fTamCodIte  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Descrição'       , 68 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Custo Planejado' , 18 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Custo Envasado'  , 18 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , '%'               , 8  , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);


    fltTotPla := 0;
    fltTotEnv := 0;
    Self.DisableControls;
    Self.First;
    While Not Self.Eof Do
    Begin
      if FieldByName('CUSTO_PLA').AsFloat > 0 then
        fltPercent := (FieldByName('CUSTO_ENV').AsFloat - FieldByName('CUSTO_PLA').AsFloat) / FieldByName('CUSTO_PLA').AsFloat * 100
      else
        fltPercent := 0;

      fltTotPla := fltTotPla + FieldByName('CUSTO_PLA').AsFloat;
      fltTotEnv := fltTotEnv + FieldByName('CUSTO_ENV').AsFloat;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Código'          , FieldByName('ORD_CODITE').AsString                        , fTamCodIte  , alEsquerda );
      objLinha.pAddColuna('Descrição'       , FieldByName('DESITE').AsString                            , 68 , alEsquerda );
      objLinha.pAddColuna('Custo Planejado' , FormatFloat('#,##0.00', FieldByName('CUSTO_PLA').AsFloat) , 18 , alDireita  );
      objLinha.pAddColuna('Custo Envasado'  , FormatFloat('#,##0.00', FieldByName('CUSTO_ENV').AsFloat) , 18 , alDireita  );
      objLinha.pAddColuna('%'               , FormatFloat('#,##0.00', fltPercent                      ) , 8  , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      Self.Next;
    End;



    fltPercent := (fltTotEnv - fltTotPla) / fltTotPla * 100;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlTotal;
    objLinha.pAddColuna(''                , 'TOTAL'                             , 76 , alDireita );
    objLinha.pAddColuna('Custo Planejado' , FormatFloat('#,##0.00', fltTotPla ) , 18 , alDireita  );
    objLinha.pAddColuna('Custo Envasado'  , FormatFloat('#,##0.00', fltTotEnv ) , 18 , alDireita  );
    objLinha.pAddColuna('%'               , FormatFloat('#,##0.00', fltPercent) , 8  , alDireita  );
    objTabela.lstLinhas.Add(objLinha);


  Finally
    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    Self.First;
    Self.EnableControls;
  End;

  objLiberacao.strDirAce := 'BXOIDV';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;

  Result := objLiberacao.fLibera;

End;

function TOrdProIndustrial.fValidaSaldoLotesDefindos: Boolean;
var cdsLotesDefinidosPedidoBackup : TUniClientDataSet;
    strIteAca: String;

    strProForFilter: String;
    blnProForFilter: Boolean;

    strDistribuido: string;
    blnDistribuido: Boolean;

    fltQtdTotPro: Double;
    fltQtdDistri: Double;
    stlErros: TStringList;
    strItensValidadosSemPro,
    strItensValidados: String;
begin
  If Not blnUtilizaDistribuiLote Then
    Exit(True);

  If blnGerarLotesPelaProcedure Then
    Exit(True);

  strDistribuido := cdsLotesDefinidosPedido.Filter;
  blnDistribuido := cdsLotesDefinidosPedido.Filtered;

  strProForFilter := cdsProFor.Filter;
  blnProForFilter := cdsProFor.Filtered;

  cdsLotesDefinidosPedido.First;
  cdsLotesDefinidosPedido.Filtered := False;
//  cdsLotesDefinidosPedido.Filter := 'QTDUTI > 0';
//  cdsLotesDefinidosPedido.Filtered := True;
  cdsLotesDefinidosPedidoBackup := TUniClientDataSet.Create(nil);
  stlErros := TStringList.Create;
  stlErros.Text := '';


  Try
    cdsLotesDefinidosPedidoBackup.Data :=  cdsLotesDefinidosPedido.Data;
    cdsLotesDefinidosPedidoBackup.First;


    strItensValidados := '';
    strItensValidadosSemPro := '';
    cdsProFor.Filtered := False;
    cdsProFor.Filter   := 'TIPPRO = ' + QuotedStr('COMPOS');
    cdsProFor.Filtered := True;

    while not cdsProFor.Eof do
    Begin
      cdsLotesDefinidosPedidoBackup.Filtered := False;
      cdsLotesDefinidosPedidoBackup.Filter   := 'ITEACA = ' + QuotedStr(cdsProFor.FieldByName('ITEACA').AsString) +
                                                ' AND ITESUB = ' + QuotedStr(cdsProFor.FieldByName('ITESUB').AsString);
      cdsLotesDefinidosPedidoBackup.Filtered := True;

      If cdsLotesDefinidosPedidoBackup.IsEmpty Then
      Begin
        stlErros.Add('Item Acabado [' + cdsProFor.FieldByName('ITEACA').AsString  + '-' + fCampoTabela('ITE_DESITE','CADITE',['ITE_CODITE'],[cdsProFor.FieldByName('ITEACA').AsString]) + ']' +
                     ' Qtd. Prod.: ' + FormatFloat( '#0.0000', cdsProFor.FieldByName('QTDTOT').AsFloat));
        stlErros.Add(' Sub Produto [' + cdsProFor.FieldByName('ITESUB').AsString + '-' +
                     fRetNomProduto(cdsProFor.FieldByName('ITESUB').AsString) +'] Qtd. Lotes: ' + FormatFloat('#0.0000', 0));
        stlErros.Add('');
      End;
      cdsProFor.Next;
    End;

    cdsLotesDefinidosPedido.First;
    while not cdsLotesDefinidosPedido.Eof do
    Begin
      cdsProFor.First;
      strIteAca := cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString;
      If strIteAca = '' Then
      Begin
        cdsLotesDefinidosPedido.Next;
        Continue;
      End;
      cdsProFor.Filtered := False;
      cdsProFor.Filter   := 'ITEACA = ' + QuotedStr(strIteAca) + ' AND ITESUB = ' + QuotedStr(cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString) (*+ ' AND TIPPRO = ' + QuotedStr('COMPOS') *);
      cdsProFor.Filtered := True;

      If cdsProFor.IsEmpty then
      Begin

        If Not (Pos(cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString+ cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString, strItensValidadosSemPro) > 0) Then
        Begin
          fltQtdTotPro := 0;
          cdsLotesDefinidosPedidoBackup.Filtered := False;
          cdsLotesDefinidosPedidoBackup.Filter   := 'ITEACA = ' + QuotedStr(cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString) +
                                                    ' AND ITESUB = ' + QuotedStr(cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString);
          cdsLotesDefinidosPedidoBackup.Filtered := True;
          fltQtdDistri := 0;

          strItensValidados := strItensValidados + '_' + cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString + cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString;
          while not cdsLotesDefinidosPedidoBackup.EoF do
          Begin
            fltQtdDistri := fltQtdDistri + cdsLotesDefinidosPedidoBackup.FieldByName('QTDUTI').AsFloat;
            cdsLotesDefinidosPedidoBackup.Next;
          End;
          If fltQtdDistri <> 0 Then
          Begin
            stlErros.Add('Item Acabado [' + cdsLotesDefinidosPedido.FieldByName('ACADES').AsString + '] Qtd. Prod.: ' + FormatFloat( '#0.0000', RoundTo(fltQtdTotPro, -4)));
            stlErros.Add(' Sub Produto [' + cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString + '-' +cdsLotesDefinidosPedido.FieldByName('DESITE').AsString +'] Qtd. Lotes: ' + FormatFloat('#0.0000', RoundTo(fltQtdDistri, -4)));
            stlErros.Add('');
          End;

          strItensValidadosSemPro := strItensValidadosSemPro + '_' + cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString + cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString;

        End;
      End
      Else
      If cdsProFor.FieldByName('TIPPRO').AsString = 'COMPOS' Then
      Begin
        //Valida se a quantidade distribuida é igual a quantidade produzida
        If Pos(cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString+ cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString, strItensValidados) > 0 Then
        Begin
          cdsLotesDefinidosPedido.Next;
          continue;
        End;

        fltQtdTotPro := 0;
        while not cdsProFor.Eof do
        Begin
          fltQtdTotPro := fltQtdTotPro + cdsProFor.FieldByName('QTDTOT').AsFloat;
          cdsProFor.Next;
        End;
        cdsLotesDefinidosPedidoBackup.Filtered := False;
        cdsLotesDefinidosPedidoBackup.Filter   := 'ITEACA = ' + QuotedStr(cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString) +
                                                  ' AND ITESUB = ' + QuotedStr(cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString);
        cdsLotesDefinidosPedidoBackup.Filtered := True;
        fltQtdDistri := 0;

        strItensValidados := strItensValidados + '_' + cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString + cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString;
        while not cdsLotesDefinidosPedidoBackup.EoF do
        Begin
          fltQtdDistri := fltQtdDistri + cdsLotesDefinidosPedidoBackup.FieldByName('QTDUTI').AsFloat;
          cdsLotesDefinidosPedidoBackup.Next;
        End;

        If RoundTo(fltQtdDistri, -4) <> RoundTo(fltQtdTotPro, -4)  Then
        Begin
          stlErros.Add('Item Acabado [' + cdsLotesDefinidosPedido.FieldByName('ACADES').AsString + '] Qtd. Prod.: ' + FormatFloat( '#0.0000', RoundTo(fltQtdTotPro, -4)));
          stlErros.Add(' Sub Produto [' + cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString + '-' +cdsLotesDefinidosPedido.FieldByName('DESITE').AsString +'] Qtd. Lotes: ' + FormatFloat('#0.0000', RoundTo(fltQtdDistri, -4)));
          stlErros.Add('');
        End;

      End;
      cdsLotesDefinidosPedido.Next;
    End;
  Finally
    FreeAndNil(cdsLotesDefinidosPedidoBackup);

    cdsLotesDefinidosPedido.Filtered := False;
    cdsLotesDefinidosPedido.Filter := strDistribuido;
    cdsLotesDefinidosPedido.Filtered := blnDistribuido;

    cdsProFor.Filtered := False;
    cdsProFor.Filter := strProForFilter;
    cdsProFor.Filtered := blnProForFilter;


    Result := stlErros.Text = '';
    If Not Result Then
      TfrmLog.pShowLog('Divergêcias na distribuição de lotes', stlErros);

    FreeAndNil(stlErros);
  End;

end;

procedure TOrdProIndustrial.pVerificaCusto;
var
  cpcParams: TParCalculaPrecoCusto;
  fltCustoOrd : real;
  qryIteGer : TUniQuery;
  cdsDivergencias : TUniClientDataSet;
begin
  pAtualizaCustoTotalParaExibirDiferencas(True);

  Self.DisableControls;
  try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
    try
      qryIteGer := fCriaQuery;
      try
        cdsDivergencias := TUniClientDataSet.Create(nil);
        try
          With cdsDivergencias.FieldDefs.AddFieldDef Do
          Begin
            Name := 'CODITE';
            DataType := ftString;
            Size := fTamCodIte;
          End;

          With cdsDivergencias.FieldDefs.AddFieldDef Do
          Begin
            Name := 'DESCRI';
            DataType := ftString;
            Size := 70;
          End;

          With cdsDivergencias.FieldDefs.AddFieldDef Do
          Begin
            Name := 'SIGUNI';
            DataType := ftString;
            Size := 2;
          End;

          With cdsDivergencias.FieldDefs.AddFieldDef Do
          Begin
            Name := 'CUSCAD';
            DataType := ftFloat;
          End;

          With cdsDivergencias.FieldDefs.AddFieldDef Do
          Begin
            Name := 'CUSORD';
            DataType := ftFloat;
          End;

          cdsDivergencias.CreateDataSet;
          cdsDivergencias.Open;

          cdsDivergencias.FieldByName('CODITE').DisplayLabel := 'Cód.';
          cdsDivergencias.FieldByName('DESCRI').DisplayLabel := 'Descrição';
          cdsDivergencias.FieldByName('SIGUNI').DisplayLabel := 'UN.';
          cdsDivergencias.FieldByName('CUSCAD').DisplayLabel := 'Pr. custo atual Cad. Produtos';
          cdsDivergencias.FieldByName('CUSORD').DisplayLabel := 'Pr. custo estimado, conforme alteração da OP';

          TFloatField(cdsDivergencias.FieldByName('CUSCAD')).DisplayFormat := 'R$###,###,##0.00';
          TFloatField(cdsDivergencias.FieldByName('CUSORD')).DisplayFormat := 'R$###,###,##0.00';


          qryIteGer.SQL.Clear;
          qryIteGer.SQL.Add('SELECT G.*, ITE_DESITE, UNI_SIGUNI FROM ITEGER G');
          qryIteGer.SQL.Add('INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE');
          qryIteGer.SQL.Add('INNER JOIN CADUNI   ON UNI_CODUNI   = I.ITE_CODUNI');
          qryIteGer.SQL.Add('WHERE');
          qryIteGer.SQL.Add('  G.ITE_CODITE = :CODITE AND ');
          qryIteGer.SQL.Add('  G.ITE_CODEMP = :CODEMP     ');

          Self.First;
          while not Self.eof do
          begin
            if Self.FieldByName('ORD_QTDPRO').AsFloat > 0 then
            begin
              qryIteGer.Close;
              qryIteGer.ParamByName('CODITE').AsString := Self.FieldByName('ORD_CODITE').AsString;
              qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
              qryIteGer.Open;

              cpcParams.curPreCom  := self.FieldByName('CUSTO_PLA').AsFloat;
              cpcParams.curDesF01  := qryIteGer.FieldByName('ITE_DESF01').AsFloat;
              cpcParams.curDesF02  := qryIteGer.FieldByName('ITE_DESF02').AsFloat;
              cpcParams.curDesF03  := qryIteGer.FieldByName('ITE_DESF03').AsFloat;
              cpcParams.curDesF04  := qryIteGer.FieldByName('ITE_DESF04').AsFloat;
              cpcParams.curDesF05  := qryIteGer.FieldByName('ITE_DESF05').AsFloat;
              cpcParams.curDesF06  := qryIteGer.FieldByName('ITE_DESF06').AsFloat;
              cpcParams.curICMSEnt := qryIteGer.FieldByName('ITE_ICMENT').AsFloat;
              cpcParams.curIPIEnt  := qryIteGer.FieldByName('ITE_IPIENT').AsFloat;
              cpcParams.curFrete   := qryIteGer.FieldByName('ITE_FREENT').AsFloat;
              cpcParams.curValFre  := qryIteGer.FieldByName('ITE_VALFRE').AsFloat;
              cpcParams.curAcrFin  := qryIteGer.FieldByName('ITE_ACRFIN').AsFloat;
              cpcParams.curSubsti  := qryIteGer.FieldByName('ITE_SUBSTI').AsFloat;
              cpcParams.curDesAdb  := qryIteGer.FieldByName('ITE_DESADB').AsFloat;
              cpcParams.curSubFed  := qryIteGer.FieldByName('ITE_SUBFED').AsFloat;

              if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
              begin
                cpcParams.curTCIFCu := qryIteGer.FieldByName('ITE_TCIFCU').AsFloat;
                cpcParams.curTSCust := qryIteGer.FieldByName('ITE_TSCUST').AsFloat;
                cpcParams.curDePiCo := qryIteGer.FieldByName('ITE_DEPICO').AsFloat;
                cpcParams.curDeICMS := qryIteGer.FieldByName('ITE_DEICMS').AsFloat;
                cpcParams.curFatReg := qryIteGer.FieldByName('ITE_FATREG').AsFloat;
              end
              else
              begin
                cpcParams.curTCIFCu := 0;
                cpcParams.curTSCust := 0;
                cpcParams.curDePiCo := 0;
                cpcParams.curDeICMS := 0;
                cpcParams.curFatReg := 0;
              end;

              fltCustoOrd := cpcParams.fCalculaPrecoCusto();

              if RoundTo(fltCustoOrd, -2) <> RoundTo(qryIteGer.FieldByName('ITE_PRECUS').AsFloat, -2) then
              begin
                cdsDivergencias.Append;
                cdsDivergencias.FieldByName('CODITE').AsString := qryIteGer.FieldByName('ITE_CODITE').AsString;
                cdsDivergencias.FieldByName('DESCRI').AsString := qryIteGer.FieldByName('ITE_DESITE').AsString;
                cdsDivergencias.FieldByName('SIGUNI').AsString := qryIteGer.FieldByName('UNI_SIGUNI').AsString;
                cdsDivergencias.FieldByName('CUSCAD').AsFloat  := qryIteGer.FieldByName('ITE_PRECUS').AsFloat;
                cdsDivergencias.FieldByName('CUSORD').AsFloat  := fltCustoOrd;
                cdsDivergencias.Post;
              end;

            end;

            Self.Next;
          end;

          if not cdsDivergencias.isEmpty then
          begin
            frmGrid := TfrmGrid.Create(Nil);
            try
              frmGrid.Width := 924;
              frmGrid.DataSet := cdsDivergencias;
              frmGrid.Caption := 'Tabela comparativa após finalização da alteração desta ordem de producao';
              frmGrid.ShowModal;
            finally
              FreeAndNil(frmGrid);
            end;
          end;

        finally
          FreeAndNil(cdsDivergencias);
        end;
      finally
        FreeAndNil(qryIteGer);
      end;
    finally
      FreeAndNil(cpcParams);
    end;
  finally
    Self.First;
    Self.EnableControls;
  end;
end;



function TOrdProIndustrial.fValidaUnidadesItens: boolean;
begin
  if stlItensSemUnidadeConfigurada.Count > 0 then
  begin
    if FBaixaOrdem then
    begin
      Result := False;
      pMensagemOk('As unidades dos itens abaixo estão sem o PESO / LITRO configurado, configure para prosseguir.' + #13 + stlItensSemUnidadeConfigurada.Text);
    end
    else
      Result := fMensagem('AVISO', 'As unidades dos itens abaixo estão sem o PESO / LITRO configurado, deseja continuar mesmo assim?' + #13 + stlItensSemUnidadeConfigurada.Text, ['&Sim','&Não'], 2) = 1;
  end
  else
    Result := true;
end;

procedure TOrdProIndustrial.pAtualizaCustoTotalParaExibirDiferencas(blnManutencao : boolean = false);
  Var
    fltCusCom,
    fltPesTot,
    fltPesEnv,
    fltCusUni,
    fltPreCom,
    fltCusCad, //Custo de cadastro.
    fltPreCad: Double; // Preco unitario seguindo o cadastro.
    //objProAca : TProdutosAcabados;
Begin
  Try
    //Os Calculos de baixa / custo e etc, tem que ser feito com a quantidade total envasada da OP, sendo assim na hora de incluir
    //os produtos acabados, será subtraido a quantidade já baixada por bx parcial.
    Self.DisableControls;
    if not blnManutencao then
    begin
      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('ORD_QTDENV').AsFloat := Self.FieldByName('ORD_QTDENV').AsFloat + fRetQtdeBaixaParcial(Self.FieldByName('ORD_CODITE').AsString);
        Self.Post;

        Self.Next;
      End;
      Self.First;
    end;

    fltPesTot := fGetPesoProducao;

    {objProAca := TProdutosAcabados.Create;
    objProAca.strCodIte := FieldByName('ITE_CODPAG').AsString;
    fltCusUni := objProAca.fRetornaPrecoCustoProdutoAGranel(FieldByName('ITE_CODCOR').AsString, FieldByName('KILLIT').AsString);
    FreeAndNil(objProAca);}

    fltCusUni := fRetCustoFormulacao;

    if fltPesTot <> 0 then
      fltCusUni := fltCusUni / fltPesTot;

    fltCusCad := fltCusUni;

    if not blnManutencao then
    begin
      fltPesEnv := fRetSoma('PESENV');

      if fltPesEnv <> 0 then
      begin
        //O Custo unitário é custo total da materia prima ( valor unitario por KG * quantidade planejada) dividido pela quantidade envasada.
        //pois a ordem de produção sempre vai baixar a quantidade planejada, se houve quebra pra mais ou menos isso vai interferir no custo
        fltCusUni := (fltCusUni * fltPesTot) / fltPesEnv;

        //O Custo das correções deve ser somado o valor total e divido pela quantidade de KG envasados, esse valor entra no custo unitario por KG (fltCusUni);
        fltCusUni := fltCusUni + (objCorrOP.fRetTotalCustoCorrecoes / fltPesEnv);
      end;
    end;

    First;
    While Not Eof Do
    Begin
      Edit;

      If (FieldByName('ORD_QTDENV').AsFloat > 0) or (blnManutencao and (FieldByName('ORD_QTDPRO').AsFloat > 0)) Then
      Begin
        fltCusCom := fCustoComposicao(FieldByName('AUTOINCREM').AsString, IIF(blnManutencao, FieldByName('ORD_QTDPRO').AsFloat, FieldByName('ORD_QTDENV').AsFloat));

        If fltPesTot > 0 Then
        Begin
          fltPreCom := RoundTo(fltCusUni * FieldByName('PESUNI').AsFloat + fltCusCom, -intDecUni);
          fltPreCad := RoundTo(fltCusCad * FieldByName('PESUNI').AsFloat + fltCusCom, -intDecUni);
        End
        Else
        Begin
          fltPreCom := 0;
          fltPreCad := 0;
        End;

        if not blnManutencao then
        begin
          FieldByName('CUSTO_PLA').AsFloat := fltPreCad * FieldByName('ORD_QTDENV').AsFloat;
          FieldByName('CUSTO_ENV').AsFloat := fltPreCom * FieldByName('ORD_QTDENV').AsFloat;
        end
        else
        begin
          FieldByName('CUSTO_PLA').AsFloat := fltPreCad;
          FieldByName('CUSTO_ENV').AsFloat := fltPreCom;
        end;

      End
      Else
      Begin
        FieldByName('CUSTO_PLA').AsFloat := 0;
        FieldByName('CUSTO_ENV').AsFloat := 0;
      End;

      Post;

      Next;
    End;

  Finally
    if not blnManutencao then
    begin
      //Volta as quantidade pois apos abrir a transação ele vai atualizar de novo as qtdes para fazer o calculo do custo unitário;
      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('ORD_QTDENV').AsFloat := Self.FieldByName('ORD_QTDENV').AsFloat - fRetQtdeBaixaParcial(Self.FieldByName('ORD_CODITE').AsString);
        Self.Post;

        Self.Next;
      End;
    end;
    Self.First;
    Self.EnableControls;
  End;

End;

Function TOrdProIndustrial.fBaixaEstoqueFormula(strAutInc: String): Boolean;
Var
  fltQtdSemPro,
  fltQtdPro,
  fltQtdTot: Double;
  fltQtdTotABaixar: Double;
  strItem: String;
  strEntSai: String;
  strNumLote: String;
  qryFatDor: TUniQuery;
  blnIncCom : Boolean;
  cdsLotesDefinidosPedidoBkp: TUniClientDataSet;
Begin
  blnIncCom := fCfgSis('INCCOM', varBoolean);
  If blnUtilizaDistribuiLote Then
  Begin
    cdsLotesDefinidosPedidoBkp := TUniClientDataSet.Create(nil);
    cdsLotesDefinidosPedido.Filtered := False;
    cdsLotesDefinidosPedidoBkp.Data := cdsLotesDefinidosPedido.Data;
  End;


  Result := True;
  Try
    qryFatDor := fCriaQuery(Self);
    With qryFatDor, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT FDO_CODITE AS CODITE,                   ');
      Add('        FDO_NUMLOT AS NUMLOT,                   ');
      Add('        FDO_QTDITE AS QTDITE,                   ');
      Add('        ITE_PRECUS AS PRECUS,                   ');
      Add('        ODC_QTDUSA,                   ');

      Add('        ORDDET.ORD_CODITE,                  ');
      Add('        IF(IFNULL(ORDCOM.ODC_QTDITE, 1) < 0, 1, IFNULL(ORDCOM.ODC_QTDITE, 1)) AS ODC_QTDITE, ');

      Add('        ( SELECT COUNT(1) ');
      Add('                        FROM EXTGOR ');
      Add('                       INNER JOIN FATDOR ON FDO_SEQGER = FGO_SEQFGO ');
      Add('                       INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE  AND ITE_CODEMP = FDO_CODEMP ');
      Add('                        LEFT JOIN ORDDET ON ORD_SEQGER = FGO_ORDIND ');
      Add('                       INNER JOIN ORDCOM ON ORDCOM.ODC_SEQDET = ORDDET.AUTOINCREM AND FDO_CODITE = ODC_CODITE ');
      Add('                       LEFT JOIN ORDMAT ON ODM_SEQGER = ORDDET.ORD_SEQGER AND ODM_ITESUB =  FDO_CODITE ');
      Add('                       WHERE FGO_ORDIND = :ORDIND ');
      Add('                       AND IF(ODM_TIPOMP IS NOT NULL, ODM_TIPOMP = "COM" , TRUE) ');
      Add('                        AND FATDOR.FDO_CODITE = G.ITE_CODITE ) > 0 AS EMBALAGEM ');
      Add(' FROM  EXTGOR                                   ');
      Add('   INNER JOIN FATDOR ON FDO_SEQGER = FGO_SEQFGO ');
      Add('   INNER JOIN ITEGER G ON ITE_CODITE = FDO_CODITE ');
      Add('                    AND ITE_CODEMP = FDO_CODEMP ');
      Add('  LEFT JOIN ORDDET ON ORD_SEQGER = FGO_ORDIND ');
      Add('    LEFT JOIN ORDCOM ON ORDCOM.ODC_SEQDET = ORDDET.AUTOINCREM AND FDO_CODITE = ODC_CODITE ');
      Add(' WHERE FGO_ORDIND = :ORDIND                     ');
      Add(' GROUP BY FDO_CODITE, FDO_NUMLOT, FATDOR.AUTOINCREM  ');
      Add(' ORDER BY ORD_CODITE, FDO_CODITE, FDO_QTDITE');
      ParamByName('ORDIND').AsString := strAutInc;

      Open;

      First;
    End;

    {$Region 'WMS'}
    If fUsaRotinaWMS Then
    Begin
      strItem := '';
      fltQtdTotABaixar := 0;

      If blnUtilizaDistribuiLote then
      Begin
        cdsLotesDefinidosPedidoBkp.First;
        While not cdsLotesDefinidosPedidoBkp.Eof do
        Begin
          If cdsLotesDefinidosPedidoBkp.FieldByName('QTDUTI').AsFloat = 0 Then
            cdsLotesDefinidosPedidoBkp.Delete
          Else
            cdsLotesDefinidosPedidoBkp.Next;
        End;

        qryFatDor.First;
        while not qryFatDor.Eof Do
        begin
          If Not cdsProFor.Locate('ITESUB', qryFatDor.FieldByName('CODITE').AsString, []) Then
          begin
            qryFatDor.Next;
            Continue;
          End;

          while  cdsLotesDefinidosPedidoBkp.Locate('ITESUB', qryFatDor.FieldByName('CODITE').AsString, []) do
          begin
            Result := Result And fAtualizaEstoqueCadIte(qryFatDor.FieldByName('CODITE').AsString, 'S', cdsLotesDefinidosPedidoBkp.FieldByName('QTDUTI').AsFloat, qryFatDor.FieldByName('PRECUS').AsFloat, cdsLotesDefinidosPedidoBkp.FieldByName('NUMLOT').AsString);
            Result := Result And fIncluiDetMovimentacao(qryFatDor.FieldByName('CODITE').AsString, cdsLotesDefinidosPedidoBkp.FieldByName('QTDUTI').AsFloat, 'S', cdsLotesDefinidosPedidoBkp.FieldByName('NUMLOT').AsString, False, True, strAutInc);
            cdsLotesDefinidosPedidoBkp.Delete;
            cdsLotesDefinidosPedidoBkp.First;
            If cdsLotesDefinidosPedidoBkp.IsEmpty Then
              Break;
          End;

          qryFatDor.Next;
        End;
      End

      Else
      Begin
        While Not qryFatDor.Eof Do
        Begin

          { Retira as correções, pois quando tem correção com o mesmo item da formula estava gravando errado a ORDMAT}
          { Mais abaixo, já irá fazer a gravações das correções }
          cdsProFor.Filter   := '  TIPITE <> ' + QuotedStr('CORREC');
          cdsProFor.Filtered := True;

          If Not cdsProFor.Locate('ITESUB', qryFatDor.FieldByName('CODITE').AsString, []) Then
          begin
            qryFatDor.Next;
            Continue;
          End;

          If strItem <> qryFatDor.FieldByName('CODITE').AsString Then
          Begin
            strItem := qryFatDor.FieldByName('CODITE').AsString;
            fRetQtdIteProduzidaTotal(strItem,fltQtdSemPro, fltQtdPro );
            fltQtdTotABaixar := fltQtdPro;
          End;

          If blnIncCom Then
          begin

            If blnIncCom And (qryFatDor.FieldByName('EMBALAGEM').AsInteger > 0) Then
            Begin
              //Baixa Emabalagens exedentes caso tiver.
              cdsLotesComponentes.Filtered := False;
              cdsLotesComponentes.Filter := 'SEMRES = ' + fQuotedStr('N');
              cdsLotesComponentes.Filtered := True;

              While (cdsLotesComponentes.Locate('CODITE', qryFatDor.FieldByName('CODITE').AsString, [])) Or
                    (cdsLotesComponentes.FieldByName('CODITE').AsString = qryFatDor.FieldByName('CODITE').AsString) do
              Begin
                Result := Result And fAtualizaEstoqueCadIte(qryFatDor.FieldByName('CODITE').AsString, 'S', cdsLotesComponentes.FieldByName('SALDOS').AsFloat, qryFatDor.FieldByName('PRECUS').AsFloat, cdsLotesComponentes.FieldByName('NUMLOT').AsString);
                Result := Result And fIncluiDetMovimentacao(qryFatDor.FieldByName('CODITE').AsString, cdsLotesComponentes.FieldByName('SALDOS').AsFloat, 'S', cdsLotesComponentes.FieldByName('NUMLOT').AsString, False, True, strAutInc);
                fltQtdTotABaixar := fltQtdTotABaixar - cdsLotesComponentes.FieldByName('SALDOS').AsFloat;
                cdsLotesComponentes.Delete;
                cdsLotesComponentes.First;
                If cdsLotesComponentes.IsEmpty Then
                  Break;
              End;
            End;
          End;

          If qryFatDor.FieldByName('EMBALAGEM').AsInteger > 0 Then
          Begin
            fltQtdTot := 0;
            If fltQtdTotABaixar >= qryFatDor.FieldByName('QTDITE').AsFloat Then
               fltQtdTot := qryFatDor.FieldByName('QTDITE').AsFloat
            Else If  fltQtdTotABaixar < qryFatDor.FieldByName('QTDITE').AsFloat Then
               fltQtdTot := fltQtdTotABaixar;

            fltQtdTotABaixar := fltQtdTotABaixar - fltQtdTot;
          End
          Else
            fltQtdTot := qryFatDor.FieldByName('QTDITE').AsFloat;

          If fltQtdTot <> 0 Then
          Begin
            If fltQtdTot > 0 Then
              strEntSai := 'S'
            Else
              strEntSai := 'E';

            fltQtdTot := Abs(fltQtdTot);
            If (Not ((qryFatDor.FieldByName('EMBALAGEM').AsInteger > 0) )) Or
               (qryFatDor.FieldByName('EMBALAGEM').AsInteger > 0) And  (fltQtdTotABaixar >= 0) Then
            Begin
              Result := Result And fAtualizaEstoqueCadIte(qryFatDor.FieldByName('CODITE').AsString, strEntSai, fltQtdTot, qryFatDor.FieldByName('PRECUS').AsFloat, qryFatDor.FieldByName('NUMLOT').AsString);

              Result := Result And fIncluiDetMovimentacao(qryFatDor.FieldByName('CODITE').AsString, fltQtdTot, strEntSai, qryFatDor.FieldByName('NUMLOT').AsString, False, True, strAutInc);
            End;
          End;

          If Not Result Then
            Break;

          If Assigned(FProgre) Then
            FProgre.StepBy(1);

          Application.ProcessMessages;

          qryFatDor.Next;
        End;
      End;
      // baixa os componentes que não foram definidos na geração do pedido
      If blnIncCom Then
      begin
        cdsLotesComponentes.Filtered := False;
        cdsLotesComponentes.Filter := 'SEMRES = ' + fQuotedStr('S');
        cdsLotesComponentes.Filtered := True;
        If Result And (Not CdsLotesComponentes.IsEmpty) And ( fCfgSis('INCCOM',varBoolean)) Then
        Begin
          strEntSai := 'S';
          while not cdsLotesComponentes.IsEmpty Do
          Begin
            If cdsLotesComponentes.FieldByName('SEMRES').AsString = 'N' Then
            Begin
              cdsLotesComponentes.Delete;
              Continue;
            End;
            If cdsProFor.Locate('ITESUB', cdsLotesComponentes.FieldByName('CODITE').AsString, []) Then
            begin

              If cdsProFor.FieldByName('TIPITE').AsString  = 'COMPOS' Then
              Begin
                Result := Result And fAtualizaEstoqueCadIte(cdsLotesComponentes.FieldByName('CODITE').AsString, 'S', cdsLotesComponentes.FieldByName('SALDOS').AsFloat, cdsProFor.FieldByName('PRECUS').AsFloat, cdsLotesComponentes.FieldByName('NUMLOT').AsString);
                Result := Result And fIncluiDetMovimentacao(cdsLotesComponentes.FieldByName('CODITE').AsString, cdsLotesComponentes.FieldByName('SALDOS').AsFloat, 'S', cdsLotesComponentes.FieldByName('NUMLOT').AsString, False, True, strAutInc);
              End;
            End;
            cdsLotesComponentes.Delete;
            cdsLotesComponentes.First;
            If cdsLotesComponentes.IsEmpty Then
              Break;
          End;
        End;
      End;
    End;
    {$EndRegion}

    With cdsProFor Do
    Begin
      If fUsaRotinaWMS Then
      Begin
        Filter   := ' TIPITE = ' + QuotedStr('CORREC') + IfThen( fCfgSis('INCCOM',varBoolean), '', ' OR TIPITE = ' + QuotedStr('COMPOS') );
        Filtered := True;
      End;

      First;

      If blnUtilizaDistribuiLote Then
      Begin
        While Not Eof Do
        Begin
          while  cdsLotesDefinidosPedidoBkp.Locate('ITESUB', FieldByName('ITESUB').AsString, []) do
          begin
             Result := Result And fAtualizaEstoqueCadIte(FieldByName('ITESUB').AsString, 'S', cdsLotesDefinidosPedidoBkp.FieldByName('QTDUTI').AsFloat, FieldByName('PRECUS').AsFloat, cdsLotesDefinidosPedidoBkp.FieldByName('NUMLOT').AsString);
             Result := Result And fIncluiDetMovimentacao(FieldByName('ITESUB').AsString, cdsLotesDefinidosPedidoBkp.FieldByName('QTDUTI').AsFloat, 'S', cdsLotesDefinidosPedidoBkp.FieldByName('NUMLOT').AsString, False, True, strAutInc);
             cdsLotesDefinidosPedidoBkp.Delete;
             cdsLotesDefinidosPedidoBkp.First;
             If cdsLotesDefinidosPedidoBkp.IsEmpty Then
                Break;
          end;
          Next;
        End;
      End
      Else
      Begin

        While Not Eof Do
        Begin

          If intCasasDecimaisMateriaPrima > 4 Then
            fltQtdTot := RoundTo(cdsProFor.FieldByName('QTDTOT').AsFloat, -4)
          Else
            fltQtdTot := RoundTo(cdsProFor.FieldByName('QTDTOT').AsFloat, -intCasasDecimaisMateriaPrima);

          If fltQtdTot <> 0 Then
          Begin
            If fltQtdTot > 0 Then
              strEntSai := 'S'
            Else
              strEntSai := 'E';

            fltQtdTot := Abs(fltQtdTot);

            strNumLote := FieldByName('NUMLOT').AsString;

            If (not fCfgSis('INCCOM',varBoolean)) And
               (fCfgSis('OIBPOR',varBoolean)) And
               (strNumLote = '') And
               (cdsProFor.FieldByName('TIPITE').AsString = 'COMPOS') Then
            Begin
              strNumLote := TCadLot.fRetArmazemPrincipalOrdemProducao(FieldByName('ITESUB').AsString, '');
              If strNumLote = '' Then
                strNumLote := TCadLot.fRetArmazemPrincipalOrdemProducao(FieldByName('ITESUB').AsString, '', True);
            End;

            {if fUsaRotinaWMS then
            Begin
              If strNumLote = '' Then
                strNumLote:= TCadLot.fRetornaLoteComSaldo(FieldByName('ITESUB').AsString, VS_strCodEmp);
            End;}

            If blnUtilizaDistribuiLote And (strNumLote = '') And (cdsProFor.FieldByName('TIPITE').AsString = 'CORREC') Then
            Begin
              If (qryFatDor.Locate('CODITE', cdsProFor.FieldByName('ITESUB').AsString, [])) Then
                If (Not fEmptyStr(qryFatDor.FieldByName('NUMLOT').AsString)) Then
                  strNumLote := qryFatDor.FieldByName('NUMLOT').AsString;
            End;

            If (strNumLote = '') And ((fCfgSis('INCCOM',varBoolean) And (cdsProFor.FieldByName('TIPITE').AsString = 'COMPOS') Or (cdsProFor.FieldByName('TIPPRO').AsString = 'FORMUL'))) Then
            Begin
              If (qryFatDor.Locate('CODITE', cdsProFor.FieldByName('ITESUB').AsString, [])) Then
                If (Not fEmptyStr(qryFatDor.FieldByName('NUMLOT').AsString)) Then
                  strNumLote := qryFatDor.FieldByName('NUMLOT').AsString;
            End;

            Result := Result And fAtualizaEstoqueCadIte(FieldByName('ITESUB').AsString, strEntSai, fltQtdTot, FieldByName('PRECUS').AsFloat, strNumLote);

            Result := Result And fIncluiDetMovimentacao(FieldByName('ITESUB').AsString, fltQtdTot, strEntSai, strNumLote, False, True, strAutInc );
          End;

          If Not Result Then
            Break;

          If Assigned(FProgre) Then
            FProgre.StepBy(1);

          Application.ProcessMessages;

          Next;
        End;
      End;

    End;


    If blnUtilizaDistribuiLote Then
    Begin
      cdsProFor.Filtered := False;
      cdsLotesDefinidosPedidoBkp.First;
      While Not cdsLotesDefinidosPedidoBkp.IsEmpty Do
      Begin
        cdsProFor.First;
        If cdsLotesDefinidosPedidoBkp.FieldByName('QTDUTI').AsFloat > 0 Then
        Begin
          If cdsProFor.Locate('ITESUB', cdsLotesDefinidosPedidoBkp.FieldByName('ITESUB').AsString, []) Then
          begin
             Result := Result And fAtualizaEstoqueCadIte(cdsLotesDefinidosPedidoBkp.FieldByName('ITESUB').AsString, 'S',
                                                         cdsLotesDefinidosPedidoBkp.FieldByName('QTDUTI').AsFloat,
                                                         cdsProFor.FieldByName('PRECUS').AsFloat,
                                                         cdsLotesDefinidosPedidoBkp.FieldByName('NUMLOT').AsString);
             Result := Result And fIncluiDetMovimentacao(cdsLotesDefinidosPedidoBkp.FieldByName('ITESUB').AsString,
                                                         cdsLotesDefinidosPedidoBkp.FieldByName('QTDUTI').AsFloat, 'S',
                                                         cdsLotesDefinidosPedidoBkp.FieldByName('NUMLOT').AsString, False, True, strAutInc);
          end;
        End;
        cdsLotesDefinidosPedidoBkp.Delete;
      End;
    End;

  Finally
    cdsProFor.Filter   := '';
    cdsProFor.Filtered := False;
    FreeAndNil(qryFatDor);
    If blnUtilizaDistribuiLote Then
      FreeAndNil(cdsLotesDefinidosPedidoBkp);
  End;

End;

function TOrdProIndustrial.fRetQtdeAProduzir(strCodIte: String): Double;
  Var
    qryQuery : TUniQuery;
begin
  Try
    qryQuery := fCriaQuery;
    With qryQuery, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT IFNULL(SUM(D.ORD_QTDPRO),0) AS QTDPRO       ');
      Add(' FROM ORDDET D                                      ');
      Add('   INNER JOIN ORDGER G ON G.AUTOINCREM = ORD_SEQGER ');
      Add(' WHERE D.ORD_CODITE = :CODITE                       ');
      Add('   AND G.ORD_CODEMP = :CODEMP                       ');
      Add('   AND G.ORD_DTABAI IS NULL                         ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      Result := FieldByName('QTDPRO').AsFloat;

      Close;
    End;
  Finally
    FreeAndNil(qryQuery);
  End;

end;

function TOrdProIndustrial.fRetQtdeBaixaParcial(strCodIte: String): Double;
  Var
    qryOrdBai : TUniQuery;
begin
  qryOrdBai := fCriaQuery;
  Try
    With qryOrdBai, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT IFNULL(SUM(DET_QTDITE),0) AS QTDITE   ');
      Add(' FROM ORDBAI                                  ');
      Add(' INNER JOIN MOVDET ON DET_SEQGER = ORB_SEQGER ');
      Add(' WHERE ORB_SEQOPI = :SEQOPI                   ');

      If not fEmptyStr(strCodIte) Then
        Add('   AND DET_CODITE = :CODITE                 ');

      ParamByName('SEQOPI').AsString := Self.FieldByName('ORD_SEQGER').AsString;
      If not fEmptyStr(strCodIte) Then
        ParamByName('CODITE').AsString := strCodIte;

      Open;

      Result := FieldByName('QTDITE').AsFloat;

      Close;
    End;
  Finally
    FreeAndNil(qryOrdBai);
  End;

end;

Function TOrdProIndustrial.fRetQuantidadeUsada(strCodIte: String): Double;
var
  fltPesTot : Real;
Begin
  Result := 0;

  fltPesTot  := fGetPesoProducao;

  With cdsProFor Do
  Begin
    First;

    While Not Eof Do
    Begin
      If FieldByName('ITESUB').AsString = strCodIte Then
        Result := Result + fltPesTot * (FieldByName('QTDITE').AsFloat/100);

      Next;
    End;

  End;
End;

Function TOrdProIndustrial.fAtualizaUltimaCompraGranel
  (strCodIte: String): Boolean;
Var
  qryIteGer: TUniQuery;
  qryIteSav: TUniQuery;
  fltPreCom: Double;
  intContador: Integer;
  cpcParams: TParCalculaPrecoCusto;
Begin
  Result    := True;
  cpcParams := TParCalculaPrecoCusto.Create(Self,
    TConfiguracao.fGetConfiguracao);
  qryIteGer := fCriaQuery(Self);
  qryIteSav := fCriaQuery(Self);

  With qryIteGer, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM ITEGER');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE AND ');
    Add('  LOCATE(ITE_CODEMP,"' + fRetEmpresasUsamPrecoMatriz + '") > 0 ');

    ParamByName('CODITE').AsString := strCodIte;

    Open;

    qryIteSav.SQL.Text := qryIteGer.SQL.Text + ' AND ITE_CODEMP = :CODEMP ';

    While not Eof Do
    Begin
      qryIteSav.Close;
      qryIteSav.ParamByName('CODITE').AsString := strCodIte;
      qryIteSav.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
      qryIteSav.Open;

      If IsEmpty Then
      Begin
        Result := False;
        pMensagemOk('Produto granel ' + strCodIte + ' não encontrado (ITEGER)!');
      End
      Else
      Begin
        Edit;

        If objOrdemProducao.objFormula.objProdutoGranel.enuMedidaUnidade = tmLitro Then
          fltPreCom := objOrdemProducao.fRetornaCustoLitro
        else
          fltPreCom := objOrdemProducao.fRetornaCustoKilo;

        FieldByName('ITE_FORULT').AsString := fCampoTabela('EMP_FORFIL', 'CADEMP', ['EMP_CODEMP'], [FieldByName('ITE_CODEMP').AsString]);

        If fEmptyStr(FieldByName('ITE_FORULT').AsString) Then
          FieldByName('ITE_FORULT').Clear;

        FieldByName('ITE_DTAULT').AsDateTime := VS_Date;
        FieldByName('ITE_PREULT').AsFloat := fltPreCom;

        If fCfgSis('ATPRBI', varBoolean) Then
        Begin
          FieldByName('ITE_PRECOM').AsFloat := fltPreCom;
          With cpcParams Do
          Begin
            curPreCom  := FieldByName('ITE_PRECOM').AsFloat;
            curDesF01  := FieldByName('ITE_DESF01').AsFloat;
            curDesF02  := FieldByName('ITE_DESF02').AsFloat;
            curDesF03  := FieldByName('ITE_DESF03').AsFloat;
            curDesF04  := FieldByName('ITE_DESF04').AsFloat;
            curDesF05  := FieldByName('ITE_DESF05').AsFloat;
            curDesF06  := FieldByName('ITE_DESF06').AsFloat;
            curICMSEnt := FieldByName('ITE_ICMENT').AsFloat;
            curIPIEnt  := FieldByName('ITE_IPIENT').AsFloat;
            curFrete   := FieldByName('ITE_FREENT').AsFloat;
            curValFre  := FieldByName('ITE_VALFRE').AsFloat;
            curAcrFin  := FieldByName('ITE_ACRFIN').AsFloat;
            curSubsti  := FieldByName('ITE_SUBSTI').AsFloat;
            curDesAdb  := FieldByName('ITE_DESADB').AsFloat;
            curSubFed  := FieldByName('ITE_SUBFED').AsFloat;

            if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
            begin
              curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
              curTSCust := FieldByName('ITE_TSCUST').AsFloat;
              curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
              curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
              curFatReg := FieldByName('ITE_FATREG').AsFloat;
            end
            else
            begin
              curTCIFCu := 0;
              curTSCust := 0;
              curDePiCo := 0;
              curDeICMS := 0;
              curFatReg := 0;
            end;

            FieldByName('ITE_PRECUS').AsFloat := fCalculaPrecoCusto();
          End;

          For intContador := 1 To Length(VS_strTabPrc) Do
          Begin
            If fCfgSis('INDPR' + IntToStr(intContador)) = 'M' Then
              FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat := fCalculaPrecoVenda(2, FieldByName('ITE_PRECUS').AsFloat +
                                                                                                FieldByName('ITE_OUTVAL').AsFloat,
                                                                                                FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat, 0,
                                                                                                FieldByName('ITE_ICMSAI').AsFloat,
                                                                                                FieldByName('ITE_IMPFED').AsFloat,
                                                                                                FieldByName('ITE_DESOPE').AsFloat,
                                                                                                FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat)
            Else
              FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat := fCalculaPrecoVenda(1, FieldByName('ITE_PRECUS').AsFloat +
                                                                                                FieldByName('ITE_OUTVAL').AsFloat,
                                                                                                FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat,
                                                                                                FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat,
                                                                                                FieldByName('ITE_ICMSAI').AsFloat,
                                                                                                FieldByName('ITE_IMPFED').AsFloat,
                                                                                                FieldByName('ITE_DESOPE').AsFloat,
                                                                                                FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat);


          End;
        End;

        Post;

        If fCfgSis('ATPRBI', varBoolean) And (Not VS_blnPreAltViaTrigger) Then
          Result := fGravaPreAlt(FieldByName('ITE_CODITE').AsString,
                                 qryIteSav.FieldByName('ITE_PRECUS').AsFloat,
                                 FieldByName('ITE_PRECUS').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE1').AsFloat,
                                 FieldByName('ITE_PREVE1').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR1').AsFloat,
                                 FieldByName('ITE_MARBR1').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE2').AsFloat,
                                 FieldByName('ITE_PREVE2').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR2').AsFloat,
                                 FieldByName('ITE_MARBR2').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE3').AsFloat,
                                 FieldByName('ITE_PREVE3').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR3').AsFloat,
                                 FieldByName('ITE_MARBR3').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE4').AsFloat,
                                 FieldByName('ITE_PREVE4').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR4').AsFloat,
                                 FieldByName('ITE_MARBR4').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE5').AsFloat,
                                 FieldByName('ITE_PREVE5').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR5').AsFloat,
                                 FieldByName('ITE_MARBR5').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE6').AsFloat,
                                 FieldByName('ITE_PREVE6').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR6').AsFloat,
                                 FieldByName('ITE_MARBR6').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE7').AsFloat,
                                 FieldByName('ITE_PREVE7').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR7').AsFloat,
                                 FieldByName('ITE_MARBR7').AsFloat,

                                 qryIteSav.FieldByName('ITE_PRECOM').AsFloat,
                                 FieldByName('ITE_PRECOM').AsFloat,

                                 'BAIXA DE ORDEM DE PRODUCAO - fAtualizaUltimaCompraGranel',

                                 Nil,
                                 '',
                                 strLoginUsuarioLogado);
        Next;
      End;
    End;
  End; { With qryIteger, SQL Do }

  FreeAndNil(qryIteGer);
  FreeAndNil(qryIteSav);
  FreeAndNil(cpcParams);
End;

Procedure TOrdProIndustrial.pSalvaDadosItem(strCodIte, strSeqGer: String);
Var
  qryOrdSav, qryCadIte: TUniQuery;

  Function fLeItem: Boolean;
  Begin
    With qryCadIte, SQL Do
    Begin
      Add('SELECT ');

      Add('  ITE_FORULT, ');
      Add('  ITE_PRECOM, ');
      Add('  ITE_PREULT, ');
      Add('  ITE_DTAULT, ');
      Add('  ITE_PREMED, ');
      Add('  ITE_PESOIT, ');
      Add('  ITE_PESLIQ  ');

      Add('FROM CADITE C');
      Add('INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND I.ITE_CODEMP = :CODEMP');
      Add('WHERE');
      Add('  C.ITE_CODITE = :CODITE');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      Result := Not IsEmpty;
    End;
  End;

Begin
  qryOrdSav := fCriaQuery(Self);
  qryCadIte := fCriaQuery(Self);

  If fLeItem Then
    With qryOrdSav, SQL Do
    Begin
      Add('INSERT INTO ORDSAV');
      Add('( ');

      Add('ITE_SEQGER, ');
      Add('ITE_FORULT, ');
      Add('ITE_PRECOM, ');
      Add('ITE_PREULT, ');
      Add('ITE_DTAULT, ');
      Add('ITE_PREMED, ');
      Add('ITE_PESOIT, ');
      Add('ITE_PESLIQ, ');

      Add('ITE_CODITE ');

      Add(') ');
      Add('VALUES');
      Add('( ');

      Add(':SEQGER, ');
      Add(':FORULT, ');
      Add(':PRECOM, ');
      Add(':PREULT, ');
      Add(':DTAULT, ');
      Add(':PREMED, ');
      Add(':PESOIT, ');
      Add(':PESLIQ, ');

      Add(':CODITE ');

      Add(') ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('SEQGER').AsString := strSeqGer;

      ParamByName('FORULT').AsString := qryCadIte.FieldByName('ITE_FORULT').AsString;

      If fEmptyStr(ParamByName('FORULT').AsString) Then
        ParamByName('FORULT').Clear;

      ParamByName('PRECOM').AsFloat := qryCadIte.FieldByName('ITE_PRECOM').AsFloat;
      ParamByName('PREULT').AsFloat := qryCadIte.FieldByName('ITE_PREULT').AsFloat;
      ParamByName('DTAULT').AsDate  := qryCadIte.FieldByName('ITE_DTAULT').AsDateTime;
      ParamByName('PREMED').AsFloat := qryCadIte.FieldByName('ITE_PREMED').AsFloat;
      ParamByName('PESOIT').AsFloat := qryCadIte.FieldByName('ITE_PESOIT').AsFloat;
      ParamByName('PESLIQ').AsFloat := qryCadIte.FieldByName('ITE_PESLIQ').AsFloat;

      ExecSQL;
    End;

  FreeAndNil(qryOrdSav);
  FreeAndNil(qryCadIte);
End;

Function TOrdProIndustrial.fBaixaOrdemProducao(strAutInc, strCodIte,
  strCodCor: String; dtaDtaIni, horHorIni, dtaDtaFin, horHorFin,
  dtaDtaBai: TDateTime; prgProgre: TProgressBar; strLocFis : String; blnBaixaParcial : Boolean; dtaDtaVal : TDateTime;
  strCodQui, strCodEnc, strCodLim, strCodQua, strSeqCpn : String; var strAgrupadorPreAlt: String; strHistoricoBaixa : String): Boolean;
Var
  strCodEmp: string;
  strErro: String;
  strCodErrosAuditoria: String;
Begin
  pPreAltDefineVariaveisAltPre(fNow, 'BAIXA DE ORDEM DE PRODUCAO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
  Try
    strCodEmp := VS_StrCodEmp;

    if fExisteNivelInferiorSemBaixa(strAutInc) then
    Begin
      fMensagem('ATENÇÃO', 'Não é possível baixar uma ordem de produção que tenha ordem de produção de nivel inferior em aberto', ['&OK']);
      Result := False;
      Exit;
    End;

    If fCfgSis('OPCORR', varBoolean) Then
    Begin
      If (not blnBaixaParcial) And (not fValidaQuantidadesDigitadas) Then
      Begin
        Result := False;
        Exit;
      End;
    End;

    If (not Self.isEmpty) and ( RoundTo(Self.FieldByName('PESREA').AsFloat, -4) = 0 ) Then
    Begin
      pMensagemOk('Peso real da Estrutura está zerado ou a Estrutura está inativa. Verifique o Casdastro de Estruturas!');
      Result := False;
      Exit;
    End;

    FDtaVal := dtaDtaVal;
    FProgre := prgProgre;

    objAuditoriaSaldo.Limpar;

    fStartTransaction;

    If blnGerarLotesPelaProcedure Then
      fGravarLotesDaProcedure;

    if blnBaixaParcial Then
    Begin
      Result := fIncluiDocMovimentacao(dtaDtaBai, blnBaixaParcial);

      If Result Then
      Begin
        First;
        While Not Eof Do
        Begin
          If FieldByName('ORD_QTDENV').AsFloat > 0 Then
          Begin
            //A baixa parcial nao esta preparada para usar o WMS, so esta com o campo do lote para, se necessario um dia fazer parcial, tirar o campo ORDGER.ORD_SEQ_TL e passar para a tabela ORDBAI.

            If blnGerarLotesPelaProcedure And Assigned(cdsLotesGeradosProcedure) Then
            Begin
              cdsLotesGeradosProcedure.Filtered := False;
              cdsLotesGeradosProcedure.Filter := 'CODITE = ' + QuotedStr(FieldByName('ORD_CODITE').AsString) + ' AND IDTITULO = 3';
              cdsLotesGeradosProcedure.Filtered := True;
              cdsLotesGeradosProcedure.First;
            End;

            If blnGerarLotesPelaProcedure And Assigned(cdsLotesGeradosProcedure) And (Not cdsLotesGeradosProcedure.IsEmpty) Then
            Begin
              while not cdsLotesGeradosProcedure.Eof Do
              Begin
                pInserirLoteSugestao(FieldByName('ORD_CODITE').AsString);
                Result := Result And fAtualizaEstoqueCadIte(FieldByName('ORD_CODITE').AsString, 'E', cdsLotesGeradosProcedure.FieldByName('QTDALO').AsFloat, 0, cdsLotesGeradosProcedure.FieldByName('NUMLOT').AsString);
                Result := Result And fIncluiDetMovimentacao(FieldByName('ORD_CODITE').AsString, cdsLotesGeradosProcedure.FieldByName('QTDALO').AsFloat, 'E', cdsLotesGeradosProcedure.FieldByName('NUMLOT').AsString);
                cdsLotesGeradosProcedure.Next;
              End;
            End
            Else
            begin
              Result := Result And fAtualizaEstoqueCadIte(FieldByName('ORD_CODITE').AsString, 'E', FieldByName('ORD_QTDENV').AsFloat, 0, FieldByName('NUMLOT').AsString);
              Result := Result And fIncluiDetMovimentacao(FieldByName('ORD_CODITE').AsString, FieldByName('ORD_QTDENV').AsFloat, 'E', FieldByName('NUMLOT').AsString);
            End;

            If Result Then
            Begin
              Self.Edit;
              Self.FieldByName('ORD_QTDENV').AsFloat := Self.FieldByName('ORD_QTDENV').AsFloat + fRetQtdeBaixaParcial(Self.FieldByName('ORD_CODITE').AsString);
              Self.FieldByName('QTDBAI').AsFloat := 0;
              Self.Post;
            End;

          End;
          Next;
        End;
        pCarregaProdutosComposicao(True);
        pCarregaProdutosFormula_Composicao(strCodIte, strCodCor, strAutInc, True);

      End;

    End
    Else
    Begin
      //Os Calculos de baixa / custo e etc, tem que ser feito com a quantidade total envasada da OP, sendo assim na hora de incluir
      //os produtos acabados, será subtraido a quantidade já baixada por bx parcial.
      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('ORD_QTDENV').AsFloat := Self.FieldByName('ORD_QTDENV').AsFloat + fRetQtdeBaixaParcial(Self.FieldByName('ORD_CODITE').AsString);
        Self.FieldByName('QTDBAI').AsFloat := 0;
        Self.Post;

        Self.Next;
      End;
      Self.First;

      Result := objCorrOP.fGravaCorrecoes(strAutInc, strCodEmp);

      If Result Then
      Begin
        /// DEPENDE DAS CORREÇÕES GRAVADAS
        pCarregaProdutosFormula_Composicao(strCodIte, strCodCor, strAutInc, True);
        //carrega FOrdemProducao
        objOrdemProducao.dtaDataBaixa := dtaDtaBai;
        objOrdemProducao.strCodigoOpeBaixa := strLoginUsuarioLogado;
        pCarregaFormulaTOrdemProducao(fltPesoReal);
        pCarregaCorrecoesTOrdemProducao;
        pCarregaProdutosAcabadosTOrdemProducao(fltPesoReal);

        pCalculaQuantidadesUsadas('', False);

        If Assigned(prgProgre) Then
        Begin
          prgProgre.Position := 0;
          prgProgre.Visible := True;
          prgProgre.Max := Self.RecordCount + cdsProFor.RecordCount + 3;
          prgProgre.StepBy(1);
        End;

        Application.ProcessMessages;

      End;

      Result := Result And fIncluiDocMovimentacao(dtaDtaBai, blnBaixaParcial);

      Result := Result And fAtualizaDadosAcabados(strAutInc, Self.FieldByName('PESREA').AsFloat, strAgrupadorPreAlt);

      If (FExibeResumoDeCalculoOPITela) Then
      Begin

        pCriarFormularios(TfrmGridMostraCalculoOPI, frmGridMostraCalculoOPI);
        frmGridMostraCalculoOPI.cxgOrdCustoProdAcaView.DataController.DataSource := dtsCustoProducao;
        frmGridMostraCalculoOPI.DBNumOpi.DataSource:= dtsCustoProducao;
        frmGridMostraCalculoOPI.DBCustoFormula.DataSource:= dtsCustoProducao;
        frmGridMostraCalculoOPI.ShowModal;

        Result:= Result And (frmGridMostraCalculoOPI.ModalResult = 1);

        cdsCustoProducao.EmptyDataSet;

        FreeAndNil(frmGridMostraCalculoOPI);
      End;


      Result := Result And fBaixaEstoqueFormula(strAutInc);

      Result := Result And fGeraTransferenciaLotes(strAutInc); //Quando utiliza AgrLot

      If Result Then
        fBaixaPDReservaOP(strAutInc,'1');

    //pSalvaDadosItem(strCodIte, strAutInc); Tem q salvar apenas antes de recalcular;

      Result := Result And fAtualizaUltimaCompraGranel(strCodIte);

      If Assigned(prgProgre) Then
      Begin
        prgProgre.StepBy(1);
        Application.ProcessMessages;
      End;

    End; {Else}

    Result := Result And fSalvaItensBaixa(strAutInc) And fPersisteBanco(cdsOrdCom);

    If Result Then
      pAtulizaCamposBaixaOP(strAutInc, FDocOpe.strAutInc, dtaDtaIni, horHorIni,
        dtaDtaFin, horHorFin, dtaDtaBai, cdsProFor.fRetSoma('TOTPRE'), strLocFis, FDoc_TL.strAutInc, blnBaixaParcial,
        strCodQui, strCodEnc, strCodLim, strCodQua, strSeqCpn);


    If Result And (Not blnUtilizaDistribuiLote) And (VALIDA_QTDBAIXA_OP) And (Not  blnBaixaParcial) And fTemDivergenciaQuantidadeBaixadaComSolitado(strAutInc, strErro ) then
      raise Exception.Create('Foi encontrado divergencias entre o estoque movimentado e a quantidade baixada, entre em contato com a Citel!' + strErro);

    If fEmptyStr(strHistoricoBaixa) Then
      fExecutaSQL('DELETE FROM ORDHIS WHERE ORD_SEQGER = ' + QuotedStr(strAutInc))
    Else
      fExecutaSQL('REPLACE INTO ORDHIS(AUTOINCREM, ORD_SEQGER, ORD_HISTOR) VALUES(' +
                  QuotedStr(fRetAutoIncrem('ORDHIS', VS_strCodEmp)) + ', ' +
                  QuotedStr(strAutInc) + ', ' +
                  QuotedStr(strHistoricoBaixa) + ') ') ;

    If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      Try
        objCorrOP.pResetarEstadoAposRollback;
      Except
      End;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;

    If Result Then
      fCommit
    Else
    Begin
      fRollBack;
      Try
        objCorrOP.pResetarEstadoAposRollback;
      Except
      End;
    End;

    If Assigned(prgProgre) Then
    Begin
      prgProgre.StepBy(1);
    End;
    Application.ProcessMessages;

    If Result Then
    Begin
      objCorrOP.EmptyDataSet;
    End;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Try
        objCorrOP.pResetarEstadoAposRollback;
      Except
      End;
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fBaixaOrdemProducao]');
    End;

  End;

  If Assigned(prgProgre) Then
    prgProgre.Visible := False;
End;

Function TOrdProIndustrial.fIncluiDocMovimentacao(dtaDtaBai: TDate; blnParcial : Boolean): Boolean;
Var
  recServicos: TDadosServicos;
  arrDuplic  : TarrDuplicata;
  objEnderecamento : TEnderecamentoProduto;
  endDocumento: TEndDocumento;
  qryCons: TUniQuery;
  qryOrdGer: TUniQuery;

Begin
  FillChar(recServicos, SizeOf(TDadosServicos), #0);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
  With FDocOpe Do
  Begin
    strDocOpe := fRetSequencial('PROOPE');
    dtaDtaCad := dtaDtaBai;
    strCodCli := fCfgSis('CLIOPI');

    Result := fGravaMovGer(strAutInc,
                           strDocOpe,
                           'OI',
                           VS_strCodEmp,
                           '',
                           strLoginUsuarioLogado,
                           '',
                           strCodCli,
                           'C',
                           dtaDtaCad,
                           fTime(),
                           dtaDtaCad,
                           '01000',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           '',
                           'BAIXA DE ORDEM DE PRODUÇÃO INDUSTRIAL' + IfThen(blnParcial, ' - PARCIAL', ''),
                           '',
                           '',
                           '',
                           '',
                           False,
                           '',
                           '',
                           '', // Empresa do Faturamento
                           0,
                           '',
                           '',
                           False,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           arrDuplic,
                           '',
                           'N',
                           '1999',
                           '',
                           '',
                           '',
                           0,
                           '',
                           '',
                           '',
                           0,
                           recServicos,
                           0,
                           '',
                           'N',
                           '',
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           '',
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           '',
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           '',
                           0,
                           0.0,
                           0,
                           '', // Consumidor final
                           'N',
                           '',
                           '', // Operador da Expedição
                           '', // Separador da Expedição
                           '', // tabela de precos utilizada
                           '',
                           'N', // Entrega Futura
                           False, // Baixa de Entrega Futura
                           0, // Margem de Lucro
                           0.0, // Base do retido (caso tivesse) com ipi e frete de entrada
                           0.0, // Valor do retido considerando a base acima.
                           'N', // Gerar produção fora da loja
                           '', // Numero do Registro - Correios ou Transportadora
                           dtaDtaCad, // Data de Entrega no Romaneio
                           '', // Classificação fiscal 4
                           'N', // AUTO-SERVIÇO
                           '', // Evento
                           '', // AUTOINC DO ENDEREÇO DE ENTREGA
                           '', // Conteúdo do CNFNFE
                           '', // Motivo da Devolução
                           '',
                           True);

    If Result Then
      objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

    If Result And fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
    Begin

      //DOCUMENTOS DE ENDEREÇAMENTO
      qryOrdGer:= fCriaQuery();
      qryCons := fCriaQuery(Nil);
      objEnderecamento := TEnderecamentoProduto.Create;
      try

        qryOrdGer.Close;
        qryOrdGer.SQL.Clear;
        qryOrdGer.SQL.Add('SELECT * FROM ORDGER WHERE AUTOINCREM = "'+FAutInc+'"');
        qryOrdGer.Open;

        fReservaEstoqueOP(qryOrdGer, True);

        objEnderecamento.pLimpar;

        endDocumento.strNumDoc := strDocOpe;
        endDocumento.strEspDoc := 'OI';
        endDocumento.strSerie_ := '';
        endDocumento.strCodEmp := VS_strCodEmp;
        endDocumento.strCliFor := strCodCli;
        endDocumento.strTip_FC := 'C';
        objEnderecamento.endDocumento := endDocumento;


        qryCons.Close;
        qryCons.SQL.Clear;
        qryCons.SQL.Add(' UPDATE EXTGOR            '+
                        '   JOIN FATGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO '+
                        ' SET FGO_DOCEND = :DOCEND  '+
                        '   WHERE (FGO_MEN001 LIKE "%PRODUTO ACABADO OP%") '+
                        ' AND FGO_ORDIND = :AUTINC '+
                        ' AND FATGOR.FGO_CODEMP = :CODEMP ');

        qryCons.ParamByName('AUTINC').AsString   := FAutInc;
        qryCons.ParamByName('CODEMP').AsString   := VS_strCodEmp;
        qryCons.ParamByName('DOCEND').AsString   := objEnderecamento.strDocumento;
        qryCons.ExecSQL;

      finally
        FreeAndNil(objEnderecamento);
        FreeAndNil(qryOrdGer);
        FreeAndNil(qryCons);
      end;
    End;

  End;

End;

Procedure TOrdProIndustrial.pCarregaDadosItem(strCodIte: String;
  qryCadIte: TUniQuery);
Begin
  With qryCadIte, SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT I.ITE_CODITE AS CODITE,                       ');
    Add('        I.ITE_DESITE AS DESITE,                       ');
    Add('        I.ITE_REFERE AS REFERE,                       ');
    Add('        I.ITE_CODUNI AS CODUNI,                       ');
    Add('        I.ITE_CODMAR AS CODMAR,                       ');
    Add('        G.ITE_PRECUS AS PRECUS,                       ');
    Add('        G.ITE_PREULT AS PREULT,                       ');
    Add('        G.ITE_PREMED AS PREMED,                       ');
    Add('        G.ITE_IMPULT AS IMPULT                        ');
    Add(' FROM ITEGER G                                        ');
    Add('   INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
    Add(' WHERE G.ITE_CODITE = :CODITE                         ');
    Add('   AND G.ITE_CODEMP = :CODEMP                         ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
  End;
End;

Function TOrdProIndustrial.fIncluiDetMovimentacao(strCodIte: String; fltQtdIte: Double;
                                                  strEntSai: String; strNumLot : String = '';
                                                  blnAtualizouPreMed : Boolean = False;
                                                  blnGravaAtualizaOrdMat : Boolean = False;
                                                  strIncOrd : String = ''): Boolean;
Var
  strIncDet, strClaFis: String;
  qryCadIte: TUniQuery;
  qryOrdMat: TUniQuery;

Begin

  qryCadIte := fCriaQuery(Self);

  If Not fEmptyStr(strNumLot) And VALIDA_LOTE_OP then
  Begin
    If Not fVerificaLoteExiste(strCodIte, strNumLot) Then
      raise Exception.Create('O Lote ' + strNumLot + ' não foi encontrado para o item ' + strCodIte +'! Entre em contato com a Citel!');
  End;



  With FDocOpe, qryCadIte Do
  Begin
    pCarregaDadosItem(strCodIte, qryCadIte);

    If strEntSai = 'E' Then
      strClaFis := '1999'
    Else
      strClaFis := '5999';

    strIncDet := '';

    Result := fGravaMovDet(strIncDet,                                            //Var strAutInc: String;
                           strAutInc,                                            //strSeqGer: String;
                           strDocOpe,                                            //strNumDoc,
                           'OI',                                                 //strEspDoc,
                           VS_strCodEmp,                                         //strCodEmp,
                           strCodIte,                                            //strCodIte,
                           strLoginUsuarioLogado,                                //strCodVen,
                           '',                                                   //strCodDiv,
                           FieldByName('CODMAR').AsString,                       //strCodMar,
                           '',                                                   //strCodFor,
                           strCodCli,                                            //strCodCli: String;
                           dtaDtaCad,                                            //dtaDtaEnt,
                           fTime(),                                              //dtaHorEnt,
                           dtaDtaCad,                                            //dtaDtaDoc: TDateTime;
                           '01000',                                              //strConPag,
                           'C',                                                  //strTip_Fc,
                           '',                                                   //strEstado,
                           FieldByName('DESITE').AsString,                       //strDescri,
                           FieldByName('REFERE').AsString,                       //strRefere,
                           FieldByName('CODUNI').AsString,                       //strUnidad,
                           '',                                                   //strForIte: String;
                           fltQtdIte,                                            //fltQtdIte,
                           0,                                                    //fltUnitar,
                           0,                                                    //fltUniOri,
                           0,                                                    //fltUniVis,
                           0,                                                    //fltTotIte,
                           0,                                                    //fltVlrCon,
                           (FieldByName('PRECUS').AsFloat * fltQtdIte),          //fltTotCus,
                           (FieldByName('PREMED').AsFloat * fltQtdIte),          //fltTotMed,
                           0,                                                    //fltDesCon,
                           0,                                                    //fltTotFre,
                           0,                                                    //fltDesEsp: Double;
                           '',                                                   //strCodRep,
                           '',                                                   //strCodVe2: String;
                           0,                                                    //fltPerCom,
                           0,                                                    //fltTotCom,
                           0,                                                    //fltTotCo2: Double;
                           strClaFis,                                            //strClaFis,
                           '',                                                   //strCodFis: String;
                           0,                                                    //fltValIpi,
                           0,                                                    //fltAlqIpi,
                           0,                                                    //fltBasIpi,
                           0,                                                    //fltValIcm,
                           0,                                                    //fltAlqIcm,
                           0,                                                    //fltBasIcm,
                           0,                                                    //fltValRet,
                           0,                                                    //fltAlqRet,
                           0,                                                    //fltBasRet,
                           0,                                                    //fltTotPes,
                           0,                                                    //fltPerBas,
                           0,                                                    //fltPerRed: Double;
                           False,                                                //blnJafatu: Boolean;
                           '',                                                   //strTipFat,
                           '',                                                   //strNumFat,
                           '',// Empresa do Faturamento                          //strEmpFat: String;
                           0,                                                    //dtaDtaFat: TDateTime;
                           '',                                                   //strVenFat,
                           '',                                                   //strCndFat: String;
                           0,                                                    //fltValFat: Double;
                           'NOR',                                                //strIdePro,
                           '',                                                   //strIncPis,
                           '',                                                   //strSerie: String;
                           0,                                                    //fltDesAce: Double;
                           'N',                                                  //strNotEsp,
                           '',                                                   //strDocDev,
                           '',                                                   //strEspDev,
                           '',                                                   //strEmpDev,
                           '',                                                   //strIteCha,
                           '',                                                   //strIteTin,
                           '',                                                   //strDesCor,
                           '',                                                   //strTipEmb: String;
                           0,                                                    //fltQtdEmb,
                           0,                                                    //fltPreEmb: Double;
                           '',                                                   //strTipPre: String;
                           0,                                                    //fltPrvTin,
                           0,                                                    //fltPrcTin,
                           0,                                                    //fltFatTin: Double;
                           '',                                                   //strProEmb,
                           '',                                                   //strCodDig,
                           '',                                                   //strCodCnd,
                           '',                                                   //strCodFpg,
                           '',                                                   //strIteEmb,
                           '',                                                   //strGruEmb: String;
                           0,                                                    //intLazQua: Integer;
                           '',                                                   //strPromoc,
                           '',                                                   //strSeqTin: String;
                           0,                                                    //fltQtdPul: Double;
                           '',                                                   //strPedCom,
                           '',                                                   //strOriDoc,
                           '',                                                   //strNum_Pd,
                           '',                                                   //strEsp_Pd,
                           '',                                                   //strEmp_Pd: String;
                           0,                                                    //intInd_Pd: Integer;
                           '',                                                   //strOrdPro,
                           '',                                                   //strDesNes,
                           '',                                                   //strCliFat: String;
                           0,                                                    //fltBcaMin,
                           0,                                                    //fltBcaCom,
                           0.0,                                                  //fltVolPro: Double;
                           '',                                                   //strCodAca,
                           '',                                                   //strEmpAca: String;
                           False,                                                //blnProAca,
                           False,                                                //blnFilKar: Boolean;
                           '', // Especie da Entrega Fututa                      //strEspFut,
                           '', // Documento da Entrega Fututa                    //strDocFut,
                           '',                                                   //strEmpFut,
                           '', // Empresa da Entrega Fututa                      //strTabPre,
                           '',                                                   //strEmpCom: String;
                           '',                                                   //strLinha: String;
                           '',                                                   //strCatali: String;
                           '',                                                   //strCodDil: String;
                           0.0,                                                  //fltPorDil: Double;
                           '',                                                   //strDilCon: String;
                           0.0,                                                  //fltPorCat: Double;
                           0.0,                                                  //fltUniDig: Double;
                           0,                                                    //fltQtdPon: Double;
                           'N',                                                  //strEntFut,
                           '',                                                   //strMotFut: String;
                           0,                                                    //dtaDtaFut: TDateTime;
                           0,                                                    //fltTotCu2: Double;
                           0,                                                    //fltComRep,
                           0,                                                    //fltPerRep: Double;
                           '',                                                   //strKey_EP,
                           strNumLot,// strNumLot                                //strNumLot,
                           'N', // strPigBas                                     //strPigBas: String;
                           0,                                                    //fltVaEIpi,
                           0,                                                    //fltAlEIpi,
                           0,                                                    //fltBaEIpi,
                           (FieldByName('PREULT').AsFloat * fltQtdIte),          //fltTotUlt,
                           (FieldByName('IMPULT').AsFloat * fltQtdIte),          //fltImpUlt,
                           0,                                                    //fltBaRtSP,
                           0,                                                    //fltVaRtSP,
                           0,                                                    //fltIcOpPr: Double;
                           0,                                                    //intSeqCcr: Integer;
                           0,                                                    //fltEmbala,
                           0,                                                    //fltAlqPis,
                           0,                                                    //fltBasPis,
                           0,                                                    //fltValPis: Double;
                           '',                                                   //strCSTPis: String;
                           0,                                                    //fltAlqCof,
                           0,                                                    //fltBasCof,
                           0,                                                    //fltValCof: Double;
                           '',                                                   //strCSTCof,
                           '',                                                   //strCSTIpi: String;
                           '',                                                   //strEnqIpi: String;
                           0,                                                    //fltVaERet,
                           0,                                                    //fltAlERet,
                           0,                                                    //fltBaERet: Double;
                           0);                                                   //fltPesLiq: Double;

    If blnAtualizouPreMed Then
      fGravaCalcPreMed(strIncDet, 'TOrdProIndustrial.fIncluiDetMovimentacao', '', True);

    If blnGravaAtualizaOrdMat Then
    Begin
      Try
        qryOrdMat := fCriaQuery;
        qryOrdMat.SQL.Clear;

        If (not fEmptyStr(cdsProFor.FieldByName('ODMINC').AsString)) Then
        Begin
          If (not fEmptyStr(strNumLot)) And fUsaRotinaWMS Then
          Begin
            {* *********************************************************************************************}
            {* Caso for com lote e wms (reserva pelo pedido)                                               *}
            {* se tiver apenas um lote sera gravaco na ORDMAT o AUTOINCREM da MOVDET normalmente,          *}
            {* caso tenha 2 lotes, sera criado um registro sem qnde de formula para gravar essa referencia *}
            {* ******************************************************************************************GB*}

            qryOrdMat.SQL.Text := ' SELECT ODM_SEQDET FROM ORDMAT WHERE ODM_SEQGER = :SEQGER AND ODM_ITESUB = :CODITE ';
            qryOrdMat.ParamByName('SEQGER').AsString := strIncOrd;
            qryOrdMat.ParamByName('CODITE').AsString := cdsProFor.FieldByName('ITESUB').AsString;
            qryOrdMat.Open;

            If fEmptyStr(qryOrdMat.FieldByName('ODM_SEQDET').AsString) Then
            Begin
              qryOrdMat.Close;
              qryOrdMat.SQL.Clear;
              qryOrdMat.SQL.Text := ' UPDATE ORDMAT SET ODM_SEQDET = :SEQDET WHERE AUTOINCREM = :AUTINC ';
              qryOrdMat.ParamByName('SEQDET').AsString := strIncDet;
              qryOrdMat.ParamByName('AUTINC').AsString := cdsProFor.FieldByName('ODMINC').AsString;
              qryOrdMat.ExecSQL;
            End
            Else
            Begin
              qryOrdMat.Close;
              qryOrdMat.SQL.Clear;
              qryOrdMat.SQL.Add(' INSERT INTO ORDMAT (AUTOINCREM, ');
              qryOrdMat.SQL.Add('                     ODM_SEQGER, ');
              qryOrdMat.SQL.Add('                     ODM_SEQITE, ');
              qryOrdMat.SQL.Add('                     ODM_ITESUB, ');
              qryOrdMat.SQL.Add('                     ODM_DESCRI, ');
              qryOrdMat.SQL.Add('                     ODM_QTDITE, ');
              qryOrdMat.SQL.Add('                     ODM_DENSID, ');
              qryOrdMat.SQL.Add('                     ODM_CODFAS, ');
              qryOrdMat.SQL.Add('                     ODM_TIPOMP, ');
              qryOrdMat.SQL.Add('                     ODM_SEQDET, ');
              qryOrdMat.SQL.Add('                     ODM_SEQUEN) ');
              qryOrdMat.SQL.Add('             VALUES (:AUTINC,    ');
              qryOrdMat.SQL.Add('                     :SEQGER,    ');
              qryOrdMat.SQL.Add('                     :SEQITE,    ');
              qryOrdMat.SQL.Add('                     :ITESUB,    ');
              qryOrdMat.SQL.Add('                     :DESCRI,    ');
              qryOrdMat.SQL.Add('                     :QTDITE,    ');
              qryOrdMat.SQL.Add('                     :DENSID,    ');
              qryOrdMat.SQL.Add('                     NULL,       ');
              qryOrdMat.SQL.Add('                     :TIPOMP,    ');
              qryOrdMat.SQL.Add('                     :SEQDET,    ');
              qryOrdMat.SQL.Add('                     :SEQUEN)    ');

              qryOrdMat.ParamByName('AUTINC').AsString := fRetAutoIncrem('ORDMAT', VS_strCodEmp);
              qryOrdMat.ParamByName('SEQGER').AsString := strIncOrd;
              qryOrdMat.ParamByName('SEQITE').AsString := '';
              qryOrdMat.ParamByName('SEQUEN').AsInteger:= 9999;
              qryOrdMat.ParamByName('ITESUB').AsString := cdsProFor.FieldByName('ITESUB').AsString;
              qryOrdMat.ParamByName('DESCRI').AsString := cdsProFor.FieldByName('DESITE').AsString;
              qryOrdMat.ParamByName('QTDITE').AsFloat  := 0;
              qryOrdMat.ParamByName('DENSID').AsFloat  := cdsProFor.FieldByName('DENSID').AsFloat;
              qryOrdMat.ParamByName('TIPOMP').AsString := 'FOR';
              qryOrdMat.ParamByName('SEQDET').AsString := strIncDet;

              qryOrdMat.ExecSQL;

            End;

          End
          Else
          Begin
            qryOrdMat.SQL.Text := ' UPDATE ORDMAT SET ODM_SEQDET = :SEQDET WHERE AUTOINCREM = :AUTINC ';
            qryOrdMat.ParamByName('SEQDET').AsString := strIncDet;
            qryOrdMat.ParamByName('AUTINC').AsString := cdsProFor.FieldByName('ODMINC').AsString;
            qryOrdMat.ExecSQL;
          End;
        End
        Else
        Begin
          qryOrdMat.SQL.Add(' INSERT INTO ORDMAT (AUTOINCREM, ');
          qryOrdMat.SQL.Add('                     ODM_SEQGER, ');
          qryOrdMat.SQL.Add('                     ODM_SEQITE, ');
          qryOrdMat.SQL.Add('                     ODM_ITESUB, ');
          qryOrdMat.SQL.Add('                     ODM_DESCRI, ');
          qryOrdMat.SQL.Add('                     ODM_QTDITE, ');
          qryOrdMat.SQL.Add('                     ODM_DENSID, ');
          qryOrdMat.SQL.Add('                     ODM_CODFAS, ');
          qryOrdMat.SQL.Add('                     ODM_TIPOMP, ');
          qryOrdMat.SQL.Add('                     ODM_SEQDET, ');
          qryOrdMat.SQL.Add('                     ODM_SEQUEN) ');
          qryOrdMat.SQL.Add('             VALUES (:AUTINC,    ');
          qryOrdMat.SQL.Add('                     :SEQGER,    ');
          qryOrdMat.SQL.Add('                     :SEQITE,    ');
          qryOrdMat.SQL.Add('                     :ITESUB,    ');
          qryOrdMat.SQL.Add('                     :DESCRI,    ');
          qryOrdMat.SQL.Add('                     :QTDITE,    ');
          qryOrdMat.SQL.Add('                     :DENSID,    ');
          qryOrdMat.SQL.Add('                     NULL,       ');
          qryOrdMat.SQL.Add('                     :TIPOMP,    ');
          qryOrdMat.SQL.Add('                     :SEQDET,    ');
          qryOrdMat.SQL.Add('                     :SEQUEN)    ');

          qryOrdMat.ParamByName('AUTINC').AsString := fRetAutoIncrem('ORDMAT', VS_strCodEmp);
          qryOrdMat.ParamByName('SEQGER').AsString := strIncOrd;
          qryOrdMat.ParamByName('SEQITE').AsString := '';
          qryOrdMat.ParamByName('SEQUEN').AsInteger:= 9999;
          qryOrdMat.ParamByName('ITESUB').AsString := cdsProFor.FieldByName('ITESUB').AsString;
          qryOrdMat.ParamByName('DESCRI').AsString := cdsProFor.FieldByName('DESITE').AsString;
          qryOrdMat.ParamByName('QTDITE').AsFloat  := fltQtdIte;
          qryOrdMat.ParamByName('DENSID').AsFloat  := cdsProFor.FieldByName('DENSID').AsFloat;
          qryOrdMat.ParamByName('TIPOMP').AsString := cdsProFor.FieldByName('TIPITE').AsString; // O campo TIPITE Recebe "NORMAL/CORREC/COMPOR" quando normal, ja tem o autoincrem
          qryOrdMat.ParamByName('SEQDET').AsString := strIncDet;                                // Pois foi Inserido junto a OP, nos demais casos irá gravar COR ou COM.

          qryOrdMat.ExecSQL;
        End;

      Finally
        FreeAndNil(qryOrdMat);
      End;
    End;

    FreeAndNil(qryCadIte);
  End;

End;

Procedure TOrdProIndustrial.pCarregaTipoProducao(strCodIte: String);
Var
  qryCadUni: TUniQuery;
Begin
  qryCadUni := fCriaQuery(Self);

  With qryCadUni, SQL Do
  Begin
    Clear;
    Add('SELECT      ');
    Add(' UNI_KILLIT ');
    Add('FROM        ');
    Add('  CADUNI    ');
    Add('INNER JOIN CADITE ON ITE_CODUNI = UNI_CODUNI ');
    Add('WHERE       ');
    Add('  ITE_CODITE = :CODITE  ');

    ParamByName('CODITE').AsString := strCodIte;

    qryCadUni.Open;

    blnProdKg := (Not qryCadUni.IsEmpty) And
      SameText(qryCadUni.FieldByName('UNI_KILLIT').AsString, 'K');

    If Assigned(dbeVolume) Then
    Begin
      dbeVolume.DataSource := Nil;
      dbeVolume.DataField := '';
    End;

    If Assigned(dbePeso) Then
    Begin
      dbePeso.DataSource := Nil;
      dbePeso.DataField := '';
    End;

    Self.Close;

    Self.AggFields.Clear;

    pCriaSoma('VOLACA', 'VOLUME');
    pCriaSoma('PESACA', 'PESO');

    pCriaSoma('(ORD_QTDENV * PESUNI)', 'PESENV');

    // TOTAL EMVASADO - EM QUILOS OU LITROS

    If Assigned(dbeVolume) Then
    Begin
      dbeVolume.DataSource := dtsSource;
      dbeVolume.DataField := 'VOLUME';
    End;

    If Assigned(dbePeso) Then
    Begin
      dbePeso.DataSource := dtsSource;
      dbePeso.DataField := 'PESO';
    End;
  End;

  FreeAndNil(qryCadUni);
End;

{Procedure TOrdProIndustrial.pBeforePostBaixa(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin

    If (FieldByName('ORD_QTDPRO').AsFloat > 0) And
      (FieldByName('ORD_QTDENV').AsFloat <= 0) Then
    Begin
      pMensagemOk('A Quantidade envasada deve ser maior que zero');
      Cancel;
      Abort;
    End;
  End;
End;}

procedure TOrdProIndustrial.pBackupOPI;
begin
  oleBackupCdsOPI := Self.Data;
  pSetProvider;
end;

Procedure TOrdProIndustrial.pBeforePostDesenv(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    If (FieldByName('ORD_QTDPRO').AsFloat <= 0) Then
    Begin
      pMensagemOk('A Quantidade a ser produzida deve ser maior que zero');
      Cancel;
      Abort;
    End;
  End;
End;


Function TOrdProIndustrial.fRestauraCadastro(strAutInc: String; strAgrupadorPreAlt: String): Boolean;
Var
  qryCadIte: TUniQuery;
  qryIteGer: TUniQuery;
  qryIteSav: TUniQuery;
  qryOrdSav: TUniQuery;
  intContador: Integer;
  cpcParams: TParCalculaPrecoCusto;
Begin
  Result := True;

  cpcParams := TParCalculaPrecoCusto.Create(Self,
  TConfiguracao.fGetConfiguracao);

  qryCadIte := fCriaQuery(Self);
  qryCadIte.SQL.Text := 'SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE';

  qryIteGer := fCriaQuery(Self);
  qryIteGer.SQL.Text := 'SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';

  qryOrdSav := fCriaQuery(Self);
  qryIteSav := fCriaQuery(Self);

  pSetaTituloPrg('restaurando dados dos itens');

  With qryOrdSav, SQL Do
  Begin
    Add('SELECT * FROM ORDSAV');
    Add('WHERE ITE_SEQGER = :SEQGER');

    ParamByName('SEQGER').AsString := strAutInc;

    Open;

    pInicializaPrg(RecordCount);

    While Not Eof Do
    Begin
      qryCadIte.Close;
      qryCadIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      qryCadIte.Open;

      If Not qryCadIte.IsEmpty Then
      Begin
        qryCadIte.Edit;
        qryCadIte.FieldByName('ITE_PESOIT').AsFloat := FieldByName('ITE_PESOIT').AsFloat;
        qryCadIte.FieldByName('ITE_PESLIQ').AsFloat := FieldByName('ITE_PESLIQ').AsFloat;
        qryCadIte.Post;
      End;

      qryIteGer.Close;
      qryIteGer.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryIteGer.Open;

      qryIteSav.Close;
      qryIteSav.SQL.Text := qryIteGer.SQL.Text;
      qryIteSav.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      qryIteSav.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryIteSav.Open;

      If Not qryIteGer.IsEmpty Then
      Begin
        qryIteGer.Edit;

        qryIteGer.FieldByName('ITE_PREULT').AsFloat    := FieldByName('ITE_PREULT').AsFloat;
        qryIteGer.FieldByName('ITE_PREMED').AsFloat    := FieldByName('ITE_PREMED').AsFloat;

        qryIteGer.FieldByName('ITE_DTAULT').AsDateTime := FieldByName('ITE_DTAULT').AsDateTime;
        qryIteGer.FieldByName('ITE_FORULT').AsString   := FieldByName('ITE_FORULT').AsString;

        If fEmptyStr(qryIteGer.FieldByName('ITE_FORULT').AsString) Then
          qryIteGer.FieldByName('ITE_FORULT').Clear;

        If fCfgSis('ATPRBI', varBoolean) Then
        Begin
          qryIteGer.FieldByName('ITE_PRECOM').AsFloat    := FieldByName('ITE_PRECOM').AsFloat;
          qryIteGer.FieldByName('ITE_PREALT').AsString   := strAgrupadorPreAlt;

          With cpcParams Do
          Begin
            curPreCom  := qryIteGer.FieldByName('ITE_PRECOM').AsFloat;
            curDesF01  := qryIteGer.FieldByName('ITE_DESF01').AsFloat;
            curDesF02  := qryIteGer.FieldByName('ITE_DESF02').AsFloat;
            curDesF03  := qryIteGer.FieldByName('ITE_DESF03').AsFloat;
            curDesF04  := qryIteGer.FieldByName('ITE_DESF04').AsFloat;
            curDesF05  := qryIteGer.FieldByName('ITE_DESF05').AsFloat;
            curDesF06  := qryIteGer.FieldByName('ITE_DESF06').AsFloat;
            curICMSEnt := qryIteGer.FieldByName('ITE_ICMENT').AsFloat;
            curIPIEnt  := qryIteGer.FieldByName('ITE_IPIENT').AsFloat;
            curFrete   := qryIteGer.FieldByName('ITE_FREENT').AsFloat;
            curValFre  := qryIteGer.FieldByName('ITE_VALFRE').AsFloat;
            curAcrFin  := qryIteGer.FieldByName('ITE_ACRFIN').AsFloat;
            curSubsti  := qryIteGer.FieldByName('ITE_SUBSTI').AsFloat;
            curDesAdb  := qryIteGer.FieldByName('ITE_DESADB').AsFloat;
            curSubFed  := qryIteGer.FieldByName('ITE_SUBFED').AsFloat;

            if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
            begin
              curTCIFCu := qryIteGer.FieldByName('ITE_TCIFCU').AsFloat;
              curTSCust := qryIteGer.FieldByName('ITE_TSCUST').AsFloat;
              curDePiCo := qryIteGer.FieldByName('ITE_DEPICO').AsFloat;
              curDeICMS := qryIteGer.FieldByName('ITE_DEICMS').AsFloat;
              curFatReg := qryIteGer.FieldByName('ITE_FATREG').AsFloat;
            end
            else
            begin
              curTCIFCu := 0;
              curTSCust := 0;
              curDePiCo := 0;
              curDeICMS := 0;
              curFatReg := 0;
            end;

            qryIteGer.FieldByName('ITE_PRECUS').AsFloat := fCalculaPrecoCusto();
          End;

          For intContador := 1 To Length(VS_strTabPrc) Do
          Begin

            qryIteGer.FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat := fCalculaPrecoVenda(2, qryIteGer.FieldByName('ITE_PRECUS').AsFloat +
                                                                                                     qryIteGer.FieldByName('ITE_OUTVAL').AsFloat,
                                                                                                     qryIteGer.FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat,
                                                                                                     0,
                                                                                                     qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                                                                                     qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                                                                                     qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                                                                                     qryIteGer.FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat);
          End;
        End;

        qryIteGer.Post;

        If fCfgSis('ATPRBI', varBoolean) And (Not VS_blnPreAltViaTrigger) Then
          Result := fGravaPreAlt(qryIteGer.FieldByName('ITE_CODITE').AsString,
                                 qryIteSav.FieldByName('ITE_PRECUS').AsFloat,
                                 qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE1').AsFloat,
                                 qryIteGer.FieldByName('ITE_PREVE1').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR1').AsFloat,
                                 qryIteGer.FieldByName('ITE_MARBR1').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE2').AsFloat,
                                 qryIteGer.FieldByName('ITE_PREVE2').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR2').AsFloat,
                                 qryIteGer.FieldByName('ITE_MARBR2').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE3').AsFloat,
                                 qryIteGer.FieldByName('ITE_PREVE3').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR3').AsFloat,
                                 qryIteGer.FieldByName('ITE_MARBR3').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE4').AsFloat,
                                 qryIteGer.FieldByName('ITE_PREVE4').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR4').AsFloat,
                                 qryIteGer.FieldByName('ITE_MARBR4').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE5').AsFloat,
                                 qryIteGer.FieldByName('ITE_PREVE5').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR5').AsFloat,
                                 qryIteGer.FieldByName('ITE_MARBR5').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE6').AsFloat,
                                 qryIteGer.FieldByName('ITE_PREVE6').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR6').AsFloat,
                                 qryIteGer.FieldByName('ITE_MARBR6').AsFloat,
                                 qryIteSav.FieldByName('ITE_PREVE7').AsFloat,
                                 qryIteGer.FieldByName('ITE_PREVE7').AsFloat,
                                 qryIteSav.FieldByName('ITE_MARBR7').AsFloat,
                                 qryIteGer.FieldByName('ITE_MARBR7').AsFloat,

                                 qryIteSav.FieldByName('ITE_PRECOM').AsFloat,
                                 qryIteGer.FieldByName('ITE_PRECOM').AsFloat,

                                 'CANCELA BAIXA DE ORDEM DE PRODUCAO',

                                 Nil,
                                 qryIteGer.FieldByName('ITE_CODEMP').AsString,
                                 strLoginUsuarioLogado);

      End;

      If Not Result Then
        Break;

      Next;

      pProgressoPrg;
    End;

  End;

  FreeAndNil(qryCadIte);
  FreeAndNil(qryIteGer);
  FreeAndNil(qryOrdSav);
  FreeAndNil(qryIteSav);
  FreeAndNil(cpcParams);
End;

procedure TOrdProIndustrial.pSelecionaLotes; // Codigo do produto acabado.
  Var
    fltEstUti : Double;
    frmAgruPedOrdProIndLotes : TfrmAgruPedOrdProIndLotes;
begin
  If not fAgrLot Then
    Exit;

  fltEstUti := 0.00;
  Try
    pCriarFormularios(TfrmAgruPedOrdProIndLotes, frmAgruPedOrdProIndLotes);
    With frmAgruPedOrdProIndLotes Do
    Begin
      If not cdsAgrLot.Active Then
      Begin
        cdsAgrLot.qryQuery.ParamByName('CODITE').AsString := Self.FieldByName('ORD_CODITE').AsString;
        cdsAgrLot.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
        cdsAgrLot.fAbreClient(True, 'TOrdProIndustrial.pSelecionaLotes');

        While Not cdsAgrLot.Eof Do
        Begin
          cdsAgrLot.Edit;
          cdsAgrLot.FieldByName('LOT_SALDOS').AsFloat := fRetornaSaldoDisponivel(cdsAgrLot.FieldByName('LOT_CODITE').AsString,
                                                                                 False,
                                                                                 True,
                                                                                 cdsAgrLot.FieldByName('LOT_NUMLOT').AsString,
                                                                                 True,
                                                                                 VS_strCodEmp);


          cdsAgrLot.Post;
          cdsAgrLot.Next;
        End;

        TFloatField(cdsAgrLot.FieldByName('LOT_SALDOS')).DisplayFormat := fMskDigitos(intDecQtd);
        TFloatField(cdsAgrLot.FieldByName('ESTUTI')).DisplayFormat     := fMskDigitos(intDecQtd);

      End;

      cxgLotesTableView.DataController.DataSource := cdsAgrLot.dtsSource;
      cdsAgrLot.Filter   := ' LOT_SALDOS > 0 ';
      cdsAgrLot.Filtered := True;

      frmAgruPedOrdProIndLotes.ShowModal;
      If ModalResult = MrOK Then
      Begin
        cdsAgrLot.First;
        While Not cdsAgrLot.Eof Do
        Begin
          fltEstUti := fltEstUti + cdsAgrLot.FieldByName('ESTUTI').AsFloat;
          cdsAgrLot.Next;
        End;

      End;

      Self.Edit;
      Self.FieldByName('ESTUTI').AsFloat := fltEstUti;
      Self.Post;

    End;

  Finally
    cdsAgrLot.Filter   := '';
    cdsAgrLot.Filtered := False;
    cdsAgrLot.First;
    FreeAndNil(frmAgruPedOrdProIndLotes);
  End;
end;

Procedure TOrdProIndustrial.pSetaTituloPrg(strTitulo: String);
Begin
  If Assigned(frmGravando) Then
    frmGravando.lblGravando.Caption := 'Aguarde, ' + strTitulo + '...';
  Application.ProcessMessages;

  If Assigned(FPrgBar) Then
    FPrgBar.Position := 0;
End;

Procedure TOrdProIndustrial.pInicializaPrg(intMax: Integer);
Begin
  If Assigned(FPrgBar) Then
  Begin
    FPrgBar.Properties.Max := intMax;
    FPrgBar.Position := 0;
  End;

  Application.ProcessMessages;
end;

procedure TOrdProIndustrial.pLimpaCdsLotesComponentes;
begin
  If Assigned(CdsLotesComponentes) Then
    FreeAndNil(CdsLotesComponentes);
end;

Procedure TOrdProIndustrial.pProgressoPrg;
Begin
  If Assigned(FPrgBar) Then
    FPrgBar.Position := FPrgBar.Position + 1;

  Application.ProcessMessages;
end;

procedure TOrdProIndustrial.pQtdProDataChange(Sender: TField);
var
  fltQuantidade, fltMultiploDeVenda, fltCalculo : double;
begin
  Try
    if FConsiderarMultiploDeVenda  then
    begin
      fltQuantidade  := Self.FieldByName('ORD_QTDPRO').AsFloat;
      fltMultiploDeVenda := Self.FieldByName('MLTVEN').AsFloat;

      fltCalculo := fltQuantidade / fltMultiploDeVenda;

      if (fltMultiploDeVenda <> 0) and (Frac(fltCalculo)> 0) then
      begin
        pMensagemOk('A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(fltMultiploDeVenda, ffNumber, 12, 4));
        fltCalculo  := Int( ( (fltQuantidade + fltMultiploDeVenda) / fltMultiploDeVenda ) ) * fltMultiploDeVenda;
        Self.FieldByName('ORD_QTDPRO').AsFloat := fltCalculo;
      end;
    end;


    If Self.FieldByName('KILLIT').AsString = 'K' Then
    Begin
      Self.FieldByName('PESACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat;

      If Self.FieldByName('PESREA').AsFloat > 0 Then
        Self.FieldByName('VOLACA').AsFloat := (Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat) / Self.FieldByName('PESREA').AsFloat
      Else
        Self.FieldByName('VOLACA').AsFloat := 0;

    End
    Else
    Begin
      Self.FieldByName('PESACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat * Self.FieldByName('PESREA').AsFloat;

      Self.FieldByName('VOLACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat;
    End;
  Except
  End;
end;

procedure TOrdProIndustrial.pAfterPost(DataSet: TDataSet);
begin
  if FUsaCapacidadeMaxima and (not FBaixaOrdem) then
    pCalculaCapacidadeMaximaAcabados;

  If blnUtilizaDistribuiLote And (Not fEmptyStr(FAutInc)) Then
  Begin
    If (Self.FieldByName('ORD_QTDPRO').AsFloat = 0)AND (Self.FieldByName('QTDPRO_NOV').AsFloat = 0) And (Self.FieldByName('ORD_QTDENV').AsFloat > 0)  And  blnAlterandoQtd Then
    Begin
      pCarregaLotesEEmbalagemParaEnvazadoSemProducao;
      pAjustaCorrecoesEmbalagens(True);
    End
    Else If (Self.FieldByName('ORD_QTDENV').AsFloat <> Self.FieldByName('QTDPRO_NOV').AsFloat) And  blnAlterandoQtd Then
       pAjustaCorrecoesEmbalagens(False);

  End;

  If Assigned(dbePeso) Then
  Begin
    If (FStatusOPI in [stInserindoOPI,stOPIAberta]) And (Not fEmptyStr(dbePeso.Text)) Then
      pAbrirCdsFormula;
  End;
end;


procedure TOrdProIndustrial.pAjustaCorrecoesEmbalagens(UtilizaQtdProOriginal: Boolean);
var qryProducao: TUniquery;
    bkpAfterPost,
    bkpBeforePost,
    bkpAfterScroll: TDataSetNotifyEvent;
    fltQtdDistribuir: Double;
    fltQtdProOriginal: Double;
    fltQtdPro: Double;
    strFieldQtdPro: String;
begin
  If UtilizaQtdProOriginal Then
    strFieldQtdPro :=  'ORD_QTDPRO'
  Else
    strFieldQtdPro :=  'QTDPRO_NOV';
 objCorrOP.DisableControls;
  bkpAfterScroll := objCorrOP.AfterScroll;
  objCorrOP.AfterScroll := nil;
  qryProducao := fCriaQuery;
  Try
    qryProducao.SQL.Add('SELECT  ORD_CODITE ITEACA, ODC_CODITE ITESUB, ODC_QTDITE, ODC_QTDUSA FROM ORDCOM');
    qryProducao.SQL.Add(' INNER JOIN ORDDET ON ORDDET.AUTOINCREM = ORDCOM.ODC_SEQDET');
    qryProducao.SQL.Add(' INNER JOIN CADITE AC ON AC.ITE_CODITE = ORD_CODITE');
    qryProducao.SQL.Add(' INNER JOIN CADITE S ON S.ITE_CODITE = ODC_CODITE');
    qryProducao.SQL.Add(' WHERE ORD_SEQGER = "' + FAutInc +'"');
    qryProducao.SQL.Add('   AND ORD_CODITE = "' + Self.FieldByName('ORD_CODITE').AsString +'"');
    qryProducao.Open;


    while not qryProducao.Eof Do
    Begin
      objCorrOP.First;
      If objCorrOP.Locate('DMT_ITESUB', qryProducao.FieldByName('ITESUB').AsString, []) Then
      Begin
        fltQtdProOriginal := RoundTo(Self.FieldByName(strFieldQtdPro).AsFloat * qryProducao.FieldByName('ODC_QTDITE').AsFloat, -4);
        fltQtdDistribuir := RoundTo((qryProducao.FieldByName('ODC_QTDITE').AsFloat *  Self.FieldByName('ORD_QTDENV').AsFloat) - fltQtdProOriginal, -4);

        objCorrOP.Edit;

        objCorrOP.FieldByName('QTD_OP').AsFloat := (objCorrOP.FieldByName('QTD_OP').AsFloat  + fltQtdDistribuir);


        objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat :=  objCorrOP.FieldByName('QTD_OP').AsFloat;
        objCorrOP.Post;
        If (objCorrOP.FieldByName('QTD_OP').AsFloat = 0) And (Self.FieldByname('ORD_QTDPRO').AsFloat  = 0) And (objCorrOP.FieldByName('ORI_FORAORDEM').AsString = 'S') Then
          objCorrOP.Delete;

        If (Self.FieldByname('ORD_QTDPRO').AsFloat = 0) And (Self.FieldByname('ORD_QTDENV').AsFloat = 0) Then
        Begin
          cdsLotesDefinidosPedido.Filtered := False;
          cdsLotesDefinidosPedido.Filter := 'ITEACA = ' + QuotedStr(qryProducao.FieldByName('ITEACA').AsString);
          cdsLotesDefinidosPedido.Filtered := True;
          while (not cdsLotesDefinidosPedido.IsEmpty) do
            cdsLotesDefinidosPedido.Delete;
        End;


        cdsLotesDefinidosPedido.Filtered := False;
        cdsLotesDefinidosPedido.Filter := 'ITESUB = ' + QuotedStr(qryProducao.FieldByName('ITESUB').AsString) + ' AND ITEACA = ' + QuotedStr(qryProducao.FieldByName('ITEACA').AsString);
        cdsLotesDefinidosPedido.Filtered := True;

        fltQtdPro :=  Self.FieldByName('ORD_QTDENV').AsFloat * qryProducao.FieldByName('ODC_QTDITE').AsFloat;
        while (not cdsLotesDefinidosPedido.Eof) do
        Begin
          If fltQtdPro <= 0 Then
          Begin
            cdsLotesDefinidosPedido.Edit;
            cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat :=  0;
            cdsLotesDefinidosPedido.Post;
          End
          Else If cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat >=  fltQtdPro Then
          Begin
            cdsLotesDefinidosPedido.Edit;
            cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat :=  fltQtdPro;
            cdsLotesDefinidosPedido.Post;
          End
          Else
          Begin
            fltQtdPro := fltQtdPro -  cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat ;
            cdsLotesDefinidosPedido.Edit;
            cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat :=  cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat;
            cdsLotesDefinidosPedido.Post;
          End;
          cdsLotesDefinidosPedido.Next;
        End;

      End;
      qryProducao.Next;
    End;
  Finally
    FreeAndNil(qryProducao);
    objCorrOP.AfterScroll := bkpAfterScroll;
    objCorrOP.EnableControls;

    bkpAfterPost  := Self.AfterPost;
    bkpBeforePost := Self.BeforePost;
    Try
      Self.AfterPost := nil;
      Self.BeforePost := nil;
      Self.Edit;
      Self.FieldByName('QTDPRO_NOV').AsFloat := Self.FieldByName('ORD_QTDENV').AsFloat;
      Self.Post;
    Finally
      Self.AfterPost  := bkpAfterPost;
      Self.BeforePost := bkpBeforePost;
    End;
  End;
End;

Function TOrdProIndustrial.fCancelaBaixa(strAutInc: String; blnRestaurarCadastro : Boolean): Boolean;
  Var
    frmGrav : TfrmGravando;
Begin
  FAutBai := strAutInc;
  FRestaurarCadastro := blnRestaurarCadastro;

  pCriarFormularios(TfrmGravando, frmGrav);
  frmGrav.fExecutarAcao := fCancelaBaixaInterna;
  frmGrav.lblGravando.Caption := 'Cancelando Ordem de Produção';

  FPrgBar := frmGrav.pgbStatus;

  frmGrav.ShowModal;
  Result := frmGrav.blnConfirma;
  pFreeAndNil(frmGrav);
End;

Function TOrdProIndustrial.fCancelaBaixaInterna(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strAutInc,
    strSeqGer: String;
    qryTabela: TUniQuery;
    strAgrupadorPreAlt: String;
    qryCorrecoesReserva: TUniQuery;

  procedure pReabreOrdemProducao(ABlnBaixaPrdNaoRealizada: Boolean = False);
    Var
      qryUpdate : TUniQuery;
  Begin
    Try
      qryUpdate := fCriaQuery;
      With qryUpdate, SQL Do
      Begin
        Close;
        Clear;
        Add(' DELETE FROM ORDMAT WHERE ODM_SEQGER = :AUTINC AND ((ODM_TIPOMP <> "FOR") OR (ODM_TIPOMP = "FOR" AND ODM_QTDITE = 0) AND ODM_TIPOMP = "COM") ');
        ParamByName('AUTINC').AsString := FAutBai;
        ExecSQL;

        Close;
        Clear;
        Add(' UPDATE ORDMAT SET ODM_SEQDET = NULL WHERE ODM_SEQGER = :AUTINC AND ODM_TIPOMP = "FOR" ');
        ParamByName('AUTINC').AsString := FAutBai;
        ExecSQL;

        If Not ABlnBaixaPrdNaoRealizada THen
        Begin
          Close;
          Clear;
          Add(' DELETE FROM ORDDET WHERE ORD_SEQGER = :AUTINC AND (SELECT ITE_CODPAG FROM CADITE WHERE ITE_CODITE = ORD_CODITE) <> :CODITE  ');
          ParamByName('AUTINC').AsString := FAutBai;
          ParamByName('CODITE').AsString := qryTabela.FieldByName('ORD_CODITE').AsString;
          ExecSQL;
        End;

        Close;
        Clear;
        Add(' DELETE FROM OPJSON WHERE OPJ_SEQGER = :AUTINC');
        ParamByName('AUTINC').AsString := FAutBai;
        ExecSQL;



        Close;
        Clear;
        Add(' UPDATE ORDGER SET ORD_SEQ_TL = NULL, ');
        Add('                   ORD_CUSORD = NULL, ');
        Add('                   ORD_DTAINI = NULL, ');
        Add('                   ORD_HORINI = NULL, ');
        Add('                   ORD_DTAFIN = NULL, ');
        Add('                   ORD_HORFIN = NULL, ');
        Add('                   ORD_DTABAI = NULL, ');
        Add('                   ORD_OPEBAI = NULL, ');
        Add('                   ORD_DTAVAL = NULL, ');
        Add('                   ORD_TOTKIL = NULL, ');
        Add('                   ORD_TOTLIT = NULL, ');
        Add('                   ORD_SEQCPN = NULL, ');
        Add('                   ORD_CODOCO = NULL, ');
        Add('                   ORD_CRRFIN = NULL, ');
        Add('                   ORD_BAINPD = "N"   ');
        Add(' WHERE AUTOINCREM = :AUTINC           ');

        ParamByName('AUTINC').AsString := FAutBai;
        ExecSQL;
        Close;
      End;

    Finally
      FreeAndNil(qryUpdate);
    End;

  End;


Begin
  Try
    pPreAltDefineVariaveisAltPre(fNow, 'CANCELA BAIXA DE ORDEM DE PRODUCAO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    strAutInc := FAutBai;

    fCarregaItens(FAutBai, '', '');

    qryTabela := fCriaQuery;

    With qryTabela Do
    Begin
      pSetaTituloPrg('Lendo Ordem de Produção');

      SQL.Text := 'SELECT * FROM ORDBAI O ' +
                  'INNER JOIN ORDGER G ON G.AUTOINCREM = ORB_SEQOPI ' +
                  'WHERE ORB_SEQOPI = :SEQOPI ' +
                  'ORDER BY O.AUTOINCREM DESC ';
      ParamByName('SEQOPI').AsString := strAutInc;
      Open;

      If IsEmpty Then
      Begin
        If fFoiBaixaPrdNaoRealizada(strAutInc) Then
        Begin
          pReabreOrdemProducao(True);
          fExecutaSQL('DELETE FROM ORDHIS WHERE ORD_SEQGER = ' + QuotedStr(strAutInc));
          FreeAndNil(qryTabela);
          Result := True;
          Exit;
        End
        Else
        Begin
          FreeAndNil(qryTabela);
          Result := False;
          Exit;
        End;
      End;

      fStartTransaction;

      If (FieldByName('ORB_TIPBAI').AsString = 'T') Then
      Begin

        pSetaTituloPrg('Carregando Formulação');

        pCarregaProdutosFormula_Composicao(FieldByName('ORD_CODITE').AsString, FieldByName('ORD_CODCOR').AsString, strAutInc, True);

        Result := True;
        If FRestaurarCadastro Then
          Result := fRestauraCadastro(strAutInc, strAgrupadorPreAlt);

        Result := Result And fBaixaPDReservaOP(strAutInc,'0');//; fReservaEstoqueOP(qryTabela);

        Result := Result And fRestauraEstoque(FieldByName('ORB_SEQGER').AsString, True);

        Result := Result And fRestauraEstoque(FieldByName('ORD_SEQ_TL').AsString);

        If Result Then
        Begin

          qryCorrecoesReserva := fCriaQuery;
          Try
            qryCorrecoesReserva.SQL.Add('SELECT FDO_CODITE,  FDO_SEQGER  FROM RESCOR');
            qryCorrecoesReserva.SQL.Add('INNER JOIN FATDOR ON FATDOR.AUTOINCREM = RESCOR.COR_SEQFDO');
            qryCorrecoesReserva.SQL.Add(' WHERE COR_SEQORD = "'+strAutInc+'"');
            qryCorrecoesReserva.Open;

            TOrdProIndCorrecoes.fExluiReservaCorrecao(strAutInc, qryCorrecoesReserva );
          Finally
            FreeAndNil(qryCorrecoesReserva);
          End;

          pZeraQtdEnvasada(strAutInc);

          pSetaTituloPrg('Limpando Dados da Baixa');

          strSeqGer := FieldByName('ORB_SEQGER').AsString;

          pReabreOrdemProducao;

          pApagaDocBaixa(strSeqGer);
        End;

        If Result Then
        Begin
          Next;
          While Not Eof Do
          Begin
            Result := Result And fRestauraEstoque(FieldByName('ORB_SEQGER').AsString);
            pApagaDocBaixa(FieldByName('ORB_SEQGER').AsString);
            Next;
          End;


        End;
      End
      Else
      Begin
        //Se for parcial, baixa sempre a ultima baixa!
        Result := fRestauraEstoque(FieldByName('ORB_SEQGER').AsString);
        pApagaDocBaixa(FieldByName('ORB_SEQGER').AsString);
      End;

    End;

    If Result Then
    Begin

      cdsOrdCom.Filtered := False;
      cdsOrdCom.First;
      While Not cdsOrdCom.Eof Do
      Begin
        cdsOrdCom.Edit;
        cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat := 0;
        cdsOrdCom.FieldByName('ODC_VLRCUS').AsFloat := 0;
        cdsOrdCom.FieldByName('ODC_TOTCUS').AsFloat := 0;
        cdsOrdCom.Post;
        cdsOrdCom.Next;
      End;

      Result := cdsOrdCom.fSalva;
    End;

    If Result Then
      fCommit
    Else
      fRollBack;

    FreeAndNil(qryTabela);
    strAgrupadorPreAlt := '';

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TOrdProIndustrial.fCancelaBaixa]');
      Result := False;
      strAgrupadorPreAlt := '';
    End;
  End;
End;

function TOrdProIndustrial.fRetSaldoLotDor(strCodIte, strNumLot: String): Double;
  Const
    SQL_CONSULTA_SALDO_LOTDOR = '  SELECT                                     '+
                                '    SUM( IFNULL( LDO_QTDITE, 0)) AS  QTDITE  '+
                                '  FROM FATDOR FD                             '+
                                '    INNER JOIN LOTDOR LD ON LDO_SEQFDO = FD.AUTOINCREM '+
                                '  WHERE FDO_CODEMP = :CODEMP AND             '+
                                '        LDO_NUMLOT = :NUMLOT AND             '+
                                '        FDO_CODITE = :CODITE                 ';
  Var
    qryConsulta: TUniQuery;
Begin
  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.SQL.Add(SQL_CONSULTA_SALDO_LOTDOR);
    qryConsulta.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryConsulta.ParamByName('NUMLOT').AsString:= strNumLot;
    qryConsulta.ParamByName('CODITE').AsString:= strCodIte;
    qryConsulta.Open;

    result:= qryConsulta.FieldByName('QTDITE').AsFloat;

  Finally
    FreeAndNil(qryConsulta);
  End;
End;

procedure TOrdProIndustrial.pCriaDataSetValidacaoLoteSaldo;
begin
  cdsValidacaoLoteSaldo := TUniClientDataSet.Create(Self);

  cdsValidacaoLoteSaldo.FieldDefs.Add('CODITE', ftString, 7);
  cdsValidacaoLoteSaldo.FieldDefs.Add('DESITE', ftString, 100);
  cdsValidacaoLoteSaldo.FieldDefs.Add('UNIMED', ftString, 5);
  cdsValidacaoLoteSaldo.FieldDefs.Add('NUMLOT', ftString, 50);
  cdsValidacaoLoteSaldo.FieldDefs.Add('QTDCAN', ftFloat);
  cdsValidacaoLoteSaldo.FieldDefs.Add('QTDRES', ftFloat);
  cdsValidacaoLoteSaldo.FieldDefs.Add('NUMDOC', ftString, 20);
  cdsValidacaoLoteSaldo.FieldDefs.Add('SALATU', ftFloat);
  cdsValidacaoLoteSaldo.FieldDefs.Add('SALAPO', ftFloat);

  cdsValidacaoLoteSaldo.CreateDataSet;

end;


procedure TOrdProIndustrial.pCriaDataSetLotesDefinidosPedido;
begin
  cdsLotesDefinidosPedido := TUniClientDataSet.Create(Self);

  cdsLotesDefinidosPedido.FieldDefs.Add('ORIFDO', ftString, 1); // Oriundo da Fatdor
  cdsLotesDefinidosPedido.FieldDefs.Add('ITESUB', ftString, 7); // Item
  cdsLotesDefinidosPedido.FieldDefs.Add('DESITE', ftString, 60); // Descricao
  cdsLotesDefinidosPedido.FieldDefs.Add('NUMLOT', ftString, VS_Size_NumLot); // Lote
  cdsLotesDefinidosPedido.FieldDefs.Add('LOTORI', ftString, 30); // Lote Origem
  cdsLotesDefinidosPedido.FieldDefs.Add('SEQFDO', ftString, 30); // Lote Origem
  cdsLotesDefinidosPedido.FieldDefs.Add('ITEACA', ftString, 30); // Lote Origem
  cdsLotesDefinidosPedido.FieldDefs.Add('ACADES', ftString, 60); // Lote Origem
  cdsLotesDefinidosPedido.FieldDefs.Add('SALLOT', ftFloat); // Saldo Do Lote
  cdsLotesDefinidosPedido.FieldDefs.Add('SALDIS', ftFloat); // Saldo Disponivel do Lote
  cdsLotesDefinidosPedido.FieldDefs.Add('SALRES', ftFloat); // Saldo Disponivel do Lote

  cdsLotesDefinidosPedido.FieldDefs.Add('ORI_FORAORDEM', ftString, 1); // Saldo Disponivel do Lote

  cdsLotesDefinidosPedido.FieldDefs.Add('QTDORI', ftFloat); // Qtd Utilizada Original
  cdsLotesDefinidosPedido.FieldDefs.Add('QTDUTI', ftFloat); // Qtd Utilizada
  cdsLotesDefinidosPedido.FieldDefs.Add('SEQUEN', ftInteger); // Saldo Do Lote
  cdsLotesDefinidosPedido.FieldDefs.Add('ORICOR', ftString, 1); // Oriundo da Fatdor
  cdsLotesDefinidosPedido.FieldDefs.Add('RECLOT', ftString, 1); // Recalcula distribuição de qtds entre os lotes ( apenas qtd_lot>1)

  cdsLotesDefinidosPedido.CreateDataSet;

  with cdsLotesDefinidosPedido.IndexDefs.AddIndexDef do
  begin
    Name       := 'idxSALDISAsc';
    Fields     := 'ITEACA;SALDIS';
    Options    := [];
  end;

  cdsLotesDefinidosPedidoSaldos := TUniClientDataSet.Create(Self);
  cdsLotesDefinidosPedidoSaldos.FieldDefs.Add('ITESUB', ftString, 7); // Item
  cdsLotesDefinidosPedidoSaldos.FieldDefs.Add('NUMLOT', ftString, VS_Size_NumLot); // Lote
  cdsLotesDefinidosPedidoSaldos.FieldDefs.Add('SALDIS', ftFloat); // Saldo Disponivel do Lote
  cdsLotesDefinidosPedidoSaldos.FieldDefs.Add('RESPED', ftFloat); // Reserva Pelo Pedido
  cdsLotesDefinidosPedidoSaldos.FieldDefs.Add('QTDUTI', ftFloat); // Quantidade Utilizada
  cdsLotesDefinidosPedidoSaldos.CreateDataSet;



end;

Function TOrdProIndustrial.fPermiteSaldoNegativoParaProdutoAcabado(qryMovDet: TUniQuery): Boolean;
var
  fltSaldoLotDor,
  fltSaldoAtual,
  fltQtdEnvasada,
  fltResultado: Double;
  qryConsulta: TUniQuery;
  objLiberacao: TLiberacao;
  objLinha    : TLinhaMsgLibera;
  objTabela   : TRegistroMsgLiberaTabela;
Begin

  pCriaDataSetValidacaoLoteSaldo;
  objLiberacao:= TLiberacao.create;
  qryConsulta:= fCriaQuery();

  Try

    qryConsulta.SQL.Add('SELECT ORD_CODORD, ORD_DTACAD FROM ORDGER WHERE AUTOINCREM = "'+FAutInc+'" ');
    qryConsulta.Open;

    qryMovDet.First;
    while Not(qryMovDet.eof) do
    Begin
      fltQtdEnvasada:= qryMovDet.FieldByName('DET_QTDITE').AsFloat;
      fltSaldoLotDor:= fRetSaldoLotDor(qryMovDet.FieldByName('DET_CODITE').AsString, qryMovDet.FieldByName('DET_NUMLOT').AsString);
      fltSaldoAtual := fRetSaldosEmpresa(qryMovDet.FieldByName('DET_CODITE').AsString,
                                 VS_strCodEmp,
                                 qryMovDet.FieldByName('DET_NUMLOT').AsString);

      fltResultado:= (fltSaldoAtual - (fltQtdEnvasada + fltSaldoLotDor));

      If (fltResultado < 0) And (fEhProdutoAcabado(qryMovDet.FieldByName('DET_CODITE').AsString)) And (qryMovDet.FieldByName('DET_CLAFIS').AsString < '5000') Then
      Begin

        cdsValidacaoLoteSaldo.Append;

        cdsValidacaoLoteSaldo.FieldByName('CODITE').AsString:= qryMovDet.FieldByName('DET_CODITE').AsString;
        cdsValidacaoLoteSaldo.FieldByName('DESITE').AsString:= fRetNomProduto(qryMovDet.FieldByName('DET_CODITE').AsString);
        cdsValidacaoLoteSaldo.FieldByName('UNIMED').AsString:= fRetSiglaUni(qryMovDet.FieldByName('DET_CODITE').AsString);
        cdsValidacaoLoteSaldo.FieldByName('NUMLOT').AsString:= qryMovDet.FieldByName('DET_NUMLOT').AsString;
        cdsValidacaoLoteSaldo.FieldByName('QTDCAN').AsFloat:=  fltQtdEnvasada;
        cdsValidacaoLoteSaldo.FieldByName('QTDRES').AsFloat:=  fltSaldoLotDor;
        cdsValidacaoLoteSaldo.FieldByName('NUMDOC').AsString:= fRetornaDocumentoOpiVinculadoFaturamento(FAutInc, qryMovDet.FieldByName('DET_CODITE').AsString);
        cdsValidacaoLoteSaldo.FieldByName('SALATU').AsFloat:=  fltSaldoAtual;
        cdsValidacaoLoteSaldo.FieldByName('SALAPO').AsFloat:=  fltResultado;
        cdsValidacaoLoteSaldo.Post;

      End;
      qryMovDet.Next;
    End;

    result:= cdsValidacaoLoteSaldo.IsEmpty;

    If Not(result) Then
    Begin

      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'PBOPIS';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      //objLiberacao.strCodDig    := strLoginUsuarioLogado;

      objLiberacao.objMsgLibera.pAddTexto('Ao Cancelar a baixa da ordem de produção, os produtos listados abaixo ficarão com saldo do estoque negativo no lote.');
      objLiberacao.objMsgLibera.pAddTexto('para completar a operação será necessário senha de liberação.');
      objLiberacao.objMsgLibera.pAddQuebra;

      objLiberacao.objMsgLibera.pAddTextoCaption('Número da ordem de produção', qryConsulta.FieldByName('ORD_CODORD').AsString +'-'+ DateToStr(qryConsulta.FieldByName('ORD_DTACAD').AsDateTime), 30);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna('', 'COD.'       , fTamCodIte  , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'DESCRIÇÃO'  , 30 , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'UN'         , 3  , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'LOTE'       , 8 , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'QTD A SER CANCELADA' , 15 , alCentro, teAutcom);
      objLinha.pAddColuna('', 'QTD RESERV. SEPARAÇÃO', 15 , alCentro, teAutcom);
      objLinha.pAddColuna('', 'NUM VENDA', 12 , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'SALDO ATUAL', 12 , alCentro, teAutcom);
      objLinha.pAddColuna('', 'APÓS CANCELAR BAIXA', 15 , alCentro, teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsValidacaoLoteSaldo.First;
      While Not cdsValidacaoLoteSaldo.Eof Do
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('COD.'       , cdsValidacaoLoteSaldo.FieldbyName('CODITE').AsString                      , fTamCodIte );
        objLinha.pAddColuna('DESCRIÇÃO'  , cdsValidacaoLoteSaldo.FieldbyName('DESITE').AsString                      , 30);
        objLinha.pAddColuna('UN'         , cdsValidacaoLoteSaldo.FieldbyName('UNIMED').AsString                      , 3 );
        objLinha.pAddColuna('LOTE'       , cdsValidacaoLoteSaldo.FieldbyName('NUMLOT').AsString                      , 8);
        objLinha.pAddColuna('QTD A SER CANCELADA' , FormatFloat('#0.000', cdsValidacaoLoteSaldo.FieldbyName('QTDCAN').AsFloat), 15);
        objLinha.pAddColuna('QTD RESERV. SEPARAÇÃO' , FormatFloat('#0.000', cdsValidacaoLoteSaldo.FieldbyName('QTDRES').AsFloat), 15);
        objLinha.pAddColuna('NUM VENDA' , cdsValidacaoLoteSaldo.FieldbyName('NUMDOC').AsString, 12);
        objLinha.pAddColuna('SALDO ATUAL' , FormatFloat('#0.000', cdsValidacaoLoteSaldo.FieldbyName('SALATU').AsFloat), 12);
        objLinha.pAddColuna('APÓS CANCELAR BAIXA' , FormatFloat('#0.000', cdsValidacaoLoteSaldo.FieldbyName('SALAPO').AsFloat), 15);
        objTabela.lstLinhas.Add(objLinha);

        cdsValidacaoLoteSaldo.Next;
      End;

      If not objTabela.isEmpty then
      begin
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
        Result := objLiberacao.fLibera;
      end
      Else
        Result := True;

      objLiberacao.Clear;

    End;

  Finally
    pFreeAndNil(cdsValidacaoLoteSaldo);
    pFreeAndNil(objLiberacao);
    pFreeAndNil(qryConsulta);
  End;


End;

Function TOrdProIndustrial.fRestauraEstoque(strSeqGer: String; blnValidaSaldoNegativoLote: Boolean = False): Boolean;
Var
  qryMovDet: TUniQuery;
  strEntSai: String;
Begin
  Result := True;

  qryMovDet := fCriaQuery;
  With qryMovDet, SQL Do
  Begin
    pSetaTituloPrg('Restaurando Estoque dos Itens');

    Add('SELECT * FROM MOVDET ');
    Add('WHERE DET_SEQGER = :SEQGER');

    ParamByName('SEQGER').AsString := strSeqGer;
    Open;

    pInicializaPrg(RecordCount);

    If blnValidaSaldoNegativoLote Then
    Begin
      if Not(fPermiteSaldoNegativoParaProdutoAcabado(qryMovDet)) Then
      Begin
        result:= False;
        Exit;
      End;
    End;

    qryMovDet.First;
    While Not Eof Do
    Begin
      If FieldByName('DET_CLAFIS').AsString < '5000' Then
        strEntSai := 'S'
      Else
        strEntSai := 'E';

      fVerificaIntegridade('Cancelamento OP', 'MOVDET', qryMovDet, True, False, '');

      Result := fAtualizaEstoqueCadIte(FieldByName('DET_CODITE').AsString, strEntSai, FieldByName('DET_QTDITE').AsFloat, 0, FieldByName('DET_NUMLOT').AsString);

      If Not Result Then
        Break;

      Next;

      pProgressoPrg;
    End;

    Close;
  End;
  FreeAndNil(qryMovDet);
End;

Procedure TOrdProIndustrial.pApagaDocBaixa(strSeqGer : String);
Var
  qryMovGer: TUniQuery;
Begin
  pSetaTituloPrg('Excluindo Documento de Baixa');

  qryMovGer := fCriaQuery;
  With qryMovGer, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM ORDBAI ');
    Add('WHERE ORB_SEQGER = :AUTINC');

    ParamByName('AUTINC').AsString := strSeqGer;

    Open;

    If Not IsEmpty Then
    Begin
      fVerificaIntegridade('Cancelamento OP', 'ORDBAI', qryMovGer, True, False, '');

      qryMovGer.Delete;

      Close;
    End;

    Close;
    Clear;
    Add('SELECT * FROM MOVGER ');
    Add('WHERE AUTOINCREM = :AUTINC');

    ParamByName('AUTINC').AsString := strSeqGer;

    Open;

    If Not IsEmpty Then
    Begin
      fVerificaIntegridade('Cancelamento OP', 'MOVGER', qryMovGer, True, False, '');

      qryMovGer.Delete;

      Close;
    End;

  End;
  FreeAndNil(qryMovGer);
End;

Procedure TOrdProIndustrial.pZeraQtdEnvasada(strAutInc: String);
Var
  qryOrdDet: TUniQuery;
Begin
  pSetaTituloPrg('excluindo correções da OP');

  qryOrdDet := fCriaQuery;
  With qryOrdDet, SQL Do
  Begin
    Add('UPDATE ORDDET SET');
    Add('ORD_QTDENV = NULL');
    Add('WHERE ORD_SEQGER = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;
    ExecSQL;

    Close;
    Clear;
    Add('DELETE FROM DEICOR');
    Add('WHERE DMT_SEQORD = :AUTINC');
    ParamByName('AUTINC').AsString := strAutInc;
    ExecSQL;

    pSetaTituloPrg('excluindo dados da baixa');
    Close;
    Clear;
    Add('DELETE FROM ORDSAV');
    Add('WHERE ITE_SEQGER = :AUTINC');
    ParamByName('AUTINC').AsString := strAutInc;
    ExecSQL;

  End;
  FreeAndNil(qryOrdDet);
End;

procedure TOrdProIndustrial.setCapacidadeMaxima(const Value: real);
begin
  FCapacidadeMaxima := Value;
  pCalculaCapacidadeMaximaAcabados;
end;

procedure TOrdProIndustrial.setCdsFormulas(const Value: TZClient);
begin
  FcdsFormul := Value;
end;

procedure TOrdProIndustrial.setStatusOPI(const Value: TStatusOPI);
begin
  FStatusOPI := Value;
end;

procedure TOrdProIndustrial.setStrAutIncFormula(const Value: String);
begin
  FStrAutIncFormula := Value;
end;

procedure TOrdProIndustrial.setStrCodCorFormula(const Value: String);
begin
  FStrCodCorFormula := Value;
end;

procedure TOrdProIndustrial.setStrCodIteFormula(const Value: String);
begin
  FStrCodIteFormula := Value;
end;

procedure TOrdProIndustrial.pSetLayoutEtiqueta(var cdsIteEti : TUniClientDataSet; var arrLayoutsSelecionados: TArrString);
var
  qryLayout       : TUniQuery;
  strLayoutPadrao : String;

  function fGetLayoutPadrao : String;
  var
    arrLayPadrao : array of string;
  begin
    Result := '';

    qryLayout.Close;
    qryLayout.SQL.Clear;
    qryLayout.SQL.Add('SELECT                                  ');
    qryLayout.SQL.Add('  LAY_CODLAY,                           ');
    qryLayout.SQL.Add('  LAY_DESCRI,                           ');
    qryLayout.SQL.Add('  LAY_NOMLAY                            ');
    qryLayout.SQL.Add('FROM                                    ');
    qryLayout.SQL.Add('  LAYETI                                ');
    qryLayout.SQL.Add('WHERE                                   ');
    qryLayout.SQL.Add('      LAY_TIPLAY = :TIPLAY              ');
    qryLayout.SQL.Add('  AND LAY_PADRAO = "S"                  ');
    qryLayout.SQL.Add('ORDER BY                                ');
    qryLayout.SQL.Add('  LAY_DESCRI                            ');

    qryLayout.ParamByName('TIPLAY').AsInteger := ARR_TIPO_LAYOUT[tpeOPIndustrialArgox];

    qryLayout.Open;

    {*****************************************************************}
    {* se não tiver layout, retorna vazio                            *}
    {* 1 layout, retorna ele                                         *}
    {* +1 layout, pede para o usuário selecionar qual será utilizado *}
    {*****************************************************************}
    if qryLayout.RecordCount = 1 then
    Begin
      setLength(arrLayoutsSelecionados, 1);
      arrLayoutsSelecionados[High(arrLayoutsSelecionados)] := qryLayout.FieldByName('LAY_CODLAY').AsString;
    End
    else if qryLayout.RecordCount > 1 then
    begin
      qryLayout.First;
      setLength(arrLayPadrao, 0);

      while not qryLayout.Eof do
      begin
        setLength(arrLayPadrao, Length(arrLayPadrao)+1);
        arrLayPadrao[High(arrLayPadrao)] := qryLayout.FieldByName('LAY_CODLAY').AsString + ' - ' +
                                            qryLayout.FieldByName('LAY_NOMLAY').AsString + ' ( ' +
                                            qryLayout.FieldByName('LAY_DESCRI').AsString + ' )';

        qryLayout.Next;
      end;

      arrLayoutsSelecionados := fGetMenuMultiSelecao(  'Layout padrão para itens sem layout vinculado'
                                                      , arrLayPadrao
                                                      , True
                                                      , False);


      Result := qryLayout.FieldByName('LAY_CODLAY').AsString;
    end;

  end;

  function fGetLayouItem : String;
  var
    arrLayIte : array of string;
  begin
    Result := '';

    //layouts vinculados ao produto, na aba produtos acabados
    qryLayout.Close;
    qryLayout.SQL.Clear;
    qryLayout.SQL.Add('SELECT                                                  ');
    qryLayout.SQL.Add('  LAYETI.LAY_CODLAY,                                    ');
    qryLayout.SQL.Add('  LAY_DESCRI,                                           ');
    qryLayout.SQL.Add('  LAY_NOMLAY                                            ');
    qryLayout.SQL.Add('FROM                                                    ');
    qryLayout.SQL.Add('  LAYITE                                                ');
    qryLayout.SQL.Add('   JOIN LAYETI ON LAYETI.LAY_CODLAY = LAYITE.LAY_CODLAY ');
    qryLayout.SQL.Add('WHERE                                                   ');
    qryLayout.SQL.Add('  LAY_CODITE = :CODITE                                  ');
    qryLayout.SQL.Add('ORDER BY                                                ');
    qryLayout.SQL.Add('  LAY_DESCRI                                            ');
    qryLayout.ParamByName('CODITE').AsString := cdsIteEti.FieldByName('CODITE').AsString;
    qryLayout.Open;

    {*****************************************************************}
    {* se não tiver layout, retorna vazio                            *}
    {* 1 layout, retorna ele                                         *}
    {* +1 layout, pede para o usuário selecionar qual será utilizado *}
    {*****************************************************************}
    if qryLayout.RecordCount = 1 then
      Result := qryLayout.FieldByName('LAY_CODLAY').AsString
    else
    begin
      qryLayout.First;
      setLength(arrLayIte, 0);

      while not qryLayout.Eof do
      begin
        setLength(arrLayIte, Length(arrLayIte)+1);
        arrLayIte[High(arrLayIte)] := qryLayout.FieldByName('LAY_CODLAY').AsString + ' - ' +
                                      qryLayout.FieldByName('LAY_NOMLAY').AsString + ' ( ' +
                                      qryLayout.FieldByName('LAY_DESCRI').AsString + ' )';

        qryLayout.Next;
      end;

      arrLayoutsSelecionados := fGetMenuMultiSelecao(  'Layout: ' + cdsIteEti.FieldByName('CODITE').AsString
                                                    + ' - '
                                                    + cdsIteEti.FieldByName('DESCRI').AsString
                                                    , arrLayIte
                                                    , True
                                                    , False);


      Result := qryLayout.FieldByName('LAY_CODLAY').AsString;
    end;

  end;
Begin
  With cdsIteEti Do
  Begin

    SetLength(arrLayouts,0);

    DisableControls;

    Filtered := False;
    Filter   := '(QTDETI > 0)';
    Filtered := True;
    qryLayout := fCriaQuery(nil);
    try

      strLayoutPadrao := '';
      //se houver itens sem um layout vinculado, antes de tudo pede o layout padrão
      if Locate('QTDLAY', '0', []) then
        strLayoutPadrao := fGetLayoutPadrao;

      First;
      While Not Eof Do
      Begin
        //adiciona o layout no array e no cds para fazer a impressão por layout
        if FieldByName('QTDETI').AsInteger > 0 then
        begin
          Edit;
          //se qtdlay = 0, não possui registro na layite, então utiliza o principal
          if FieldByName('QTDLAY').asInteger = 0 then
            FieldByName('LAYOUT').AsString := strLayoutPadrao
          else
            FieldByName('LAYOUT').AsString := fGetLayouItem;
          Post;

          //se o layout do item não estiver no array, adiciona ele para entrar na fila de impressão
          if not MatchStr(FieldByName('LAYOUT').AsString, arrLayouts) then
          begin
            SetLength(arrLayouts, Length(arrLayouts) + 1);
            arrLayouts[High(arrLayouts)] := FieldByName('LAYOUT').AsString;
          end;
        end;

        Next;
      End;
    finally
      FreeAndNil(qryLayout);
    end;

    Filtered := False;
    First;

    EnableControls;
  End;
End;

function TOrdProIndustrial.fTemBaixaTotal(strAutInc: String): Boolean;
  Var
    qryDados : TUniQuery;
begin
  Try
    qryDados := fCriaQuery;
    With qryDados, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT COUNT(0) AS QTD FROM ORDBAI WHERE ORB_SEQOPI = :SEQOPI AND ORB_TIPBAI = "T" ');
      ParamByName('SEQOPI').AsString := strAutInc;
      Open;
      Result := FieldByName('QTD').AsFloat > 0;
      Close;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TOrdProIndustrial.fConfirmaUltimaBaixaRealizada(strAutInc: String): Boolean;
  Var
    qryDados : TUniQuery;
    strMsg : String;
    strNumDoc : String;
begin
  Try
    qryDados := fCriaQuery;
    With qryDados, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT DET_NUMDOC,                               ');
      Add('        DET_ESPDOC,                               ');
      Add('        DET_CODITE,                               ');
      Add('        DET_DESCRI,                               ');
      Add('        DET_QTDITE                                ');
      Add(' FROM ORDBAI O                                    ');
      Add(' INNER JOIN MOVDET D ON D.DET_SEQGER = ORB_SEQGER ');
      Add(' WHERE ORB_SEQOPI = :SEQOPI                       ');
      Add(' ORDER BY O.AUTOINCREM DESC                       ');

      ParamByName('SEQOPI').AsString := strAutInc;
      Open;

      If Not IsEmpty Then
      Begin
        strMsg := 'Documento: ' + FieldByName('DET_NUMDOC').AsString + '-' + FieldByName('DET_ESPDOC').AsString;
        strNumDoc := FieldByName('DET_NUMDOC').AsString;
        While Not Eof Do
        Begin
          strMsg := strMsg + #13 + FieldByName('DET_CODITE').AsString + ' - ' +
                                   FieldByName('DET_DESCRI').AsString + ' QTDE: ' +
                                   FormatFloat('#,##0.00', FieldByName('DET_QTDITE').AsFloat);
          Next;

          If strNumDoc <> FieldByName('DET_NUMDOC').AsString Then
          Begin
            Last;
            Next;
          End;
        End;

        Result := fMensagem('', 'Confima o Cancelamento do Documento?' + #13 + strMsg, ['&Sim', '&Não'], 2) = 1;
      End
      Else
      Begin
        Result := fMensagem('', 'Baixa não encontrada!', ['&Ok']) = -1;
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryDados);
  End;
end;


Function TOrdProIndustrial.fTemDadosBaixaSalvos(strAutInc: String): Boolean;
Var
  qryOrdSav: TUniQuery;
Begin
  qryOrdSav := fCriaQuery(Self);
  With qryOrdSav, SQL Do
  Begin
    Add('SELECT COUNT(*) AS QTDITE FROM ORDSAV');
    Add('WHERE ITE_SEQGER = :SEQGER');

    ParamByName('SEQGER').AsString := strAutInc;

    Open;

    Result := FieldByName('QTDITE').AsInteger > 0;
  End;

  FreeAndNil(qryOrdSav);
End;

Function TOrdProIndustrial.fPodeBaixarOP(strAutInc: String): Boolean;
Var
  strMsg: String;
Begin
  Result := True;

  If Not fCfgSis('TERMON', varBoolean) Then
    Exit;

  If Not Assigned(objMonitor) Then
    objMonitor := TOrdProIndMonitoramento.Create(Self);

  If Not objMonitor.fOPFinalizada(strAutInc, strMsg) Then
  Begin
    pCabecalhoImpressao(strAutInc);

    objMonitor.cdsCabIpr := cdsCabIpr;
    objMonitor.fltVolume := fRetSoma('VOLUME');

    Result := False;
    pCriarFormularios(TfrmOrdProIndustrialOperacoes,
      frmOrdProIndustrialOperacoes);

    frmOrdProIndustrialOperacoes.blnMonitoramento := False;
    frmOrdProIndustrialOperacoes.objOrdPro := Self;
    frmOrdProIndustrialOperacoes.dtsOperacoes.dataSet := objMonitor.qryMonOPI;
    frmOrdProIndustrialOperacoes.ShowModal;

    FreeAndNil(frmOrdProIndustrialOperacoes);
  End;
End;

Function TOrdProIndustrial.fSQLAnaGer: String;
  Var
    strSQL: String;
Begin
  strSQL := '';;
  strSQL := strSQL + ' SELECT ';;
  strSQL := strSQL + '   GER_SEQOPI AS SEQOPI, ';
  strSQL := strSQL + '   GER_CODIGO AS SEQANA, ';
  strSQL := strSQL + '   (CASE WHEN GER_STATUS = 1 THEN "APROVADO"  ';
  strSQL := strSQL + '         WHEN GER_STATUS = 2 THEN "REPROVADO"  ';
  strSQL := strSQL + '         WHEN GER_STATUS = 3 THEN "APROVADO COM CORREÇÃO"  ';
  strSQL := strSQL + '         ELSE "" END) AS SITUAC                            ';

  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   ANAGER ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   AUTOINCREM = :AUTINC  ';

  Result := strSQL;
End;

Function TOrdProIndustrial.fSQLAnaDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';;
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   DET_CODANA AS CODANA, ';
  strSQL := strSQL + '   ANA_DESCRI AS DESANA, ';
  strSQL := strSQL + '   ANA_TIPRES AS TIPRES, ';
  strSQL := strSQL + '   DET_OPEANA AS OPEANA, ';
  strSQL := strSQL + '   OPE_NOMOPE AS NOMOPE, ';
  strSQL := strSQL + '   DET_DTAANA AS DTAANA, ';
  strSQL := strSQL + '   DET_HORANA AS HORANA, ';

  strSQL := strSQL + '   GAN_LIMMIN AS LIMMIN, ';
  strSQL := strSQL + '   GAN_LIMMAX AS LIMMAX, ';
  strSQL := strSQL + '   GAN_DESRES AS DESRES, ';

  strSQL := strSQL + '   DET_RESULT AS RESULT, ';

  strSQL := strSQL + '   (CASE WHEN DET_STATUS = 1 THEN "APROVADO"   ';
  strSQL := strSQL + '         WHEN DET_STATUS = 2 THEN "REPROVADO"  ';
  strSQL := strSQL + '         ELSE "" END) AS SITUAC                ';

  strSQL := strSQL + ' FROM       ';
  strSQL := strSQL + '   ANADET D ';
  strSQL := strSQL + ' INNER JOIN ANAGER G ON G.AUTOINCREM = D.DET_SEQGER ';

  strSQL := strSQL + ' INNER JOIN ORDGER X ON X.AUTOINCREM = GER_SEQOPI   ';
  strSQL := strSQL + ' INNER JOIN GEIMAT M ON GMT_CODITE = X.ORD_CODITE   ';
  strSQL := strSQL + '                    AND GMT_CODCOR = X.ORD_CODCOR   ';
  strSQL := strSQL + '                    AND GMT_FORMUL = X.ORD_FORMUL   ';
  strSQL := strSQL + ' LEFT JOIN GEIANA N ON GAN_SEQGMT = M.AUTOINCREM   ';
  strSQL := strSQL + '                    AND GAN_CODANA = DET_CODANA     ';

  strSQL := strSQL + ' LEFT JOIN CADANA C ON D.DET_CODANA = C.ANA_CODANA ';

  strSQL := strSQL + ' LEFT JOIN CADOPE ON OPE_CODOPE = DET_OPEANA ';

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   DET_STATUS IS NOT NULL AND  ';
  strSQL := strSQL + '   DET_SEQGER = :SEQGER        ';

  Result := strSQL;
End;

Function TOrdProIndustrial.fAbreAnalise(strAutAna: String; qryAnaGer, qryAnaDet: TUniQuery): Boolean;
Begin
  With qryAnaGer Do
  Begin
    SQL.Text := fSQLAnaGer;

    ParamByName('AUTINC').AsString := strAutAna;

    Open;

    Result := Not IsEmpty;

    If Not Result Then
    Begin
      pMensagemOk('Análise não encontrada!');
      Exit;
    End;
  End;

  With qryAnaDet Do
  Begin
    SQL.Text := fSQLAnaDet;
    ParamByName('SEQGER').AsString := strAutAna;
    Open;
  End;
End;

Procedure TOrdProIndustrial.pImprimeLaudo(strAutAna: String);
Var
  frxReport: TfrxReport;
  strTipImp,
  strNomImp: String;
  qryAnaGer,
  qryAnaDet: TUniQuery;
  frmAnaliseMovRel: TfrmAnaliseMovRel;
Begin
  With recImpres Do
  Try
    qryAnaGer := fCriaQuery;
    qryAnaDet := fCriaQuery;

    If fAbreAnalise(strAutAna, qryAnaGer, qryAnaDet) Then
    Begin
      strAutImp := qryAnaGer.FieldByName('SEQOPI').AsString;

      pCabecalhoImpressao(strAutImp);
      pProdutosAcabadosImpressao(strAutImp);

      pCarregaConfImprRel('frmCadAnaliseMov', strNomImp, strTipImp);

      pCriarFormularios(TfrmAnaliseMovRel,frmAnaliseMovRel);

      With frmAnaliseMovRel Do
      Begin
        frxIteFor.dataSet := cdsDmtIpr;
        frxIteAca.dataSet := Self;
        frxCabec.dataSet  := cdsCabIpr;
        frxAnaGer.dataSet := qryAnaGer;
        frxAnaDet.dataSet := qryAnaDet;

        frxReport := frxReportJ;
       End;

      With frxReport, Script Do
      Begin
        Variables['NOMREL'] := 'LAUDO DE ANÁLISE';
        Variables['NOMEMP'] := fRetNomeEmpresa;

        If fCfgSis('ULTCMP', varBoolean) Then
        Begin
          Variables['CRQ']    := fCfgSis('NUMCRQ', varString);
          Variables['NOMCRQ'] := 'CRQ: ';
        End
        Else
        Begin
          Variables['CRQ']    := '';
          Variables['NOMCRQ'] := '';
        End;

        PrintOptions.Printer := AnsiReplaceText(strNomImp, '\\' + fRetNomeRede + '\', '');

        PrepareReport;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmCadAnaliseMov', 'Ordem de Produção Industrial - Laudo', frxReport)
        Else
          pPrintReport('frmCadAnaliseMov', 'Ordem de Produção Industrial - Laudo', strNomImp, frxReport);
      End;

      FreeAndNil(frmQckOrdProIndustrial);
    End;

    FreeAndNil(qryAnaGer);
    FreeAndNil(qryAnaDet);
  Except
    on E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TOrdProIndustrial.pImprimeLaudo]');
    End;
  End;

End;

{ TProdutoEstoque }

constructor TProdutoEstoque.Create;
begin
  cdsEstoque := TUniClientDataSet.Create(nil);

  With cdsEstoque.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsEstoque.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALDOS';
    DataType := ftFloat;
  End;

  With cdsEstoque.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALRES';
    DataType := ftFloat;
  End;

  With cdsEstoque.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALSOP';
    DataType := ftFloat;
  End;

  cdsEstoque.CreateDataSet;
  cdsEstoque.Open;

end;

class function TProdutoEstoque.fGetSaldos(strCodIte: String): TUniClientDataSet;
begin
  if not Assigned(FInstance) Then
    FInstance := TProdutoEstoque.Create;

  With FInstance Do
  Begin
    if cdsEstoque.Locate('CODITE', strCodIte, []) Then
      Result := cdsEstoque
    Else
    Begin
      if not fEmptyStr(fRetNomProduto(strCodIte)) Then
      Begin
        cdsEstoque.Insert;
        cdsEstoque.FieldByName('CODITE').AsString := strCodIte;
        cdsEstoque.FieldByName('SALDOS').AsFloat := fRetSaldosEmpresa(strCodIte, VS_strCodEmp);
        cdsEstoque.FieldByName('SALRES').AsFloat := TSaldoReservado.New(
                                                      TReservaParametros.New()
                                                        .EmpresaItem(VS_strCodEmp)
                                                        .CodigoItem(strCodIte)
                                                        .CodEmpresa(VS_strCodEmp)
                                                      ).fGetQuantidade();
        cdsEstoque.FieldByName('SALSOP').AsFloat := (TSaldoReservado.New(
                                                      TReservaParametros.New()
                                                        .EmpresaItem(VS_strCodEmp)
                                                        .CodigoItem(strCodIte)
                                                        .CodEmpresa(VS_strCodEmp)
                                                      ).fGetQuantidade() -
                                                      TSaldoReservado.New(
                                                      TReservaParametros.New()
                                                        .EmpresaItem(VS_strCodEmp)
                                                        .CodigoItem(strCodIte)
                                                        .CodEmpresa(VS_strCodEmp)
                                                        .TipoReserva(trsOrdemProducao)
                                                      ).fGetQuantidade());

        cdsEstoque.Post;

        Result := cdsEstoque

      End
      Else
        Result := Nil;

    End;
  End;
end;

class procedure TProdutoEstoque.pLimpaCds;
begin
  if Assigned(FInstance) Then
    FInstance.cdsEstoque.EmptyDataSet;
end;

function fRetFormulAtiva(strCodIte, strCodCor : String):Integer;
Begin
  Result := fCampoTabela('GMT_FORMUL', 'GEIMAT', ['GMT_CODITE', 'GMT_CODCOR', 'GMT_STATUS'], [strCodIte, strCodCor, 'A']);
End;

function TOrdProIndustrial.fGeraTransferenciaLotes(strAutInc : String) : Boolean;
  Var
    qryOrdEst : TUniQuery;
    cdsItensTL: TUniClientDataSet;
    objTransf : TTransferenciaArmazens;
    prgProgresso : TProgressBar;
Begin
  Result := True;

  FDoc_TL.strDocOpe := '';
  FDoc_TL.dtaDtaCad := 0;
  FDoc_TL.strCodCli := '';
  FDoc_TL.strAutInc := '';

  If not fAgrLot Then
    Exit;

  Try
    prgProgresso := TProgressBar.Create(Nil);
    qryOrdEst    := fCriaQuery;
    cdsItensTL   := TUniClientDataSet.Create(Self);

    With cdsItensTL.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODITE';
      DataType := ftString;
      Size     := fTamCodIte;
      Required := False;
    End;

    With cdsItensTL.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ARMDES';
      DataType := ftString;
      Size     := VS_Size_NumLot;
      Required := False;
    End;

    With cdsItensTL.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ARMORI';
      DataType := ftString;
      Size     := VS_Size_NumLot;
      Required := False;
    End;

    With cdsItensTL.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'QTDITE';
      DataType := ftFloat;
      Size     := 0;
      Required := False;
    End;

    cdsItensTL.CreateDataSet;
    cdsItensTL.Open;

    objTransf := TTransferenciaArmazens.Create(Self, cdsItensTL, Nil, prgProgresso);


    With qryOrdEst, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT * FROM ORDEST WHERE EST_SEQGER = :SEQGER ');

      ParamByName('SEQGER').AsString := strAutInc;

      Open;

      While Not Eof Do
      Begin
        cdsItensTL.Append;
        cdsItensTL.FieldByName('CODITE').AsString := FieldByName('EST_CODITE').AsString;
        cdsItensTL.FieldByName('ARMDES').AsString := Self.FieldByName('NUMLOT').AsString;
        cdsItensTL.FieldByName('ARMORI').AsString := FieldByName('EST_NUMLOT').AsString;
        cdsItensTL.FieldByName('QTDITE').AsFloat  := FieldByName('EST_ESTUTI').AsFloat;
        cdsItensTL.Post;

        Next;
      End;

    End;

    If cdsItensTL.RecordCount > 0 Then
    Begin
      Result := objTransf.fGeraTransferencia(True, False);
      FDoc_TL.strAutInc := objTransf.strAutIncRetorno;
    End;

  Finally
    FreeAndNil(objTransf );
    FreeAndNil(qryOrdEst );
    FreeAndNil(cdsItensTL);
    FreeAndNil(prgProgresso);
  End;

End;

procedure TOrdProIndustrial.pCarregaItensSemLote(cdsItens : TCdsItensSemLote);
var
  qryLoteItem : TUniQuery;
  blnItemPossuiLoteSaldo: Boolean;
begin
  qryLoteItem := fCriaQuery(nil);
  try
    qryLoteItem.SQL.Text := fGetSQLLotesMateriaPrima;

    cdsProFor.First;
    While Not cdsProFor.Eof Do
    Begin
      qryLoteItem.ParamByName('CODITE').AsString := cdsProFor.FieldByName('ITESUB').AsString;
      qryLoteItem.Open;

      blnItemPossuiLoteSaldo:= (Not qryLoteItem.isEmpty);{ O Progaamador não lembra pq fez And qryLoteItem.Locate('EST', '0', []);}

      if Not blnItemPossuiLoteSaldo then
      begin
        cdsItens.Append;
        cdsItens.FieldByName('CODIGO').AsString    := cdsProFor.FieldByName('ITESUB').AsString;
        cdsItens.FieldByName('DESCRICAO').AsString := cdsProFor.FieldByName('DESITE').AsString;
        cdsItens.Post;
      end;

      qryLoteItem.Close;
      cdsProFor.Next;
    end;
  finally
    FreeAndNil(qryLoteItem);
  end;

end;



procedure TOrdProIndustrial.pCarregaLotesEEmbalagemParaEnvazadoSemProducao;
var qryProducao: TUnIQuery;
    strFilter: String;
    blnFilter: Boolean;
    bkpAfterPost,
    bkpBeforePost: TDataSetNotifyEvent;
    procedure pInsere;
    Begin
      cdsLotesDefinidosPedido.Insert;
      cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString := 'N';
      cdsLotesDefinidosPedido.FieldByName('ORI_FORAORDEM').AsString := 'S';
      cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString := qryProducao.FieldByName('ODC_CODITE').AsString;

      cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString := qryProducao.FieldByName('ORD_CODITE').AsString;

      cdsLotesDefinidosPedido.FieldByName('ACADES').AsString := qryProducao.FieldByName('ACADES').AsString;
      cdsLotesDefinidosPedido.FieldByName('SEQUEN').AsString := '0';
      cdsLotesDefinidosPedido.FieldByName('DESITE').AsString := qryProducao.FieldByName('ITE_DESITE').AsString;
      cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString := '';
      cdsLotesDefinidosPedido.FieldByName('LOTORI').AsString := '';
      cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat  := 0;

      cdsLotesDefinidosPedido.FieldByName('SALRES').AsFloat  := 0;

      cdsLotesDefinidosPedido.FieldByName('SALDIS').AsCurrency  := 0;

      cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat  := 0;
      cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat  := 0;
      cdsLotesDefinidosPedido.FieldByName('SEQFDO').AsString := '';

      cdsLotesDefinidosPedido.Post;
    End;
begin
  cdsLotesDefinidosPedido.DisableControls;
  strFilter := cdsLotesDefinidosPedido.filter;
  blnFilter := cdsLotesDefinidosPedido.filtered;
  Try
    qryProducao := fCriaQuery;
    Try
      qryProducao.SQL.Add('SELECT CONCAT(AC.ITE_CODITE, "-", AC.ITE_DESITE) AS ACADES, S.ITE_DESITE, ORD_CODITE, ODC_CODITE, ODC_QTDITE, ODC_QTDUSA FROM ORDCOM');
      qryProducao.SQL.Add(' INNER JOIN ORDDET ON ORDDET.AUTOINCREM = ORDCOM.ODC_SEQDET');
      qryProducao.SQL.Add(' INNER JOIN CADITE AC ON AC.ITE_CODITE = ORD_CODITE');
      qryProducao.SQL.Add(' INNER JOIN CADITE S ON S.ITE_CODITE = ODC_CODITE');
      qryProducao.SQL.Add(' WHERE ORD_SEQGER = "' + FAutInc +'"');
      qryProducao.SQL.Add('   AND ORD_CODITE = "' + Self.FieldByName('ORD_CODITE').AsString +'"');
      qryProducao.Open;

      while not qryProducao.Eof Do
      Begin
        objCorrOP.First;
        If Not objCorrOP.Locate('DMT_ITESUB', qryProducao.FieldByName('ODC_CODITE').AsString, []) Then
        Begin
          objCorrOP.Insert;
          objCorrOP.FieldByName('DMT_ITESUB').AsString := qryProducao.FieldByName('ODC_CODITE').AsString;
          objCorrOP.FieldByName('DMT_SEQUEN').AsInteger := 0;
          objCorrOP.FieldByName('DMT_REFERE').AsString  := qryProducao.FieldByName('ITE_DESITE').AsString;
          objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat := RoundTo(qryProducao.FieldByName('ODC_QTDITE').AsFloat * Self.FieldByName('ORD_QTDENV').AsFloat, -4);
          objCorrOP.FieldByName('DMT_QTDITE').AsFloat  := 0;
          objCorrOP.FieldByName('QTD_OP').AsFloat := 0;
          objCorrOP.FieldByName('ORI_FORAORDEM').AsString := 'S';
          objCorrOP.Post;
          pInsere;
        End
        Else
        Begin
          cdsLotesDefinidosPedido.First;

          If Not cdsLotesDefinidosPedido.Locate('ITESUB;ITEACA', VarArrayOf([qryProducao.FieldByName('ODC_CODITE').AsString,
                                                                             qryProducao.FieldByName('ORD_CODITE').AsString]), []) Then
            pInsere;


        End;

        qryProducao.Next;
      End;
    Finally
      FreeAndNil(qryProducao);
    End;
  Finally
    bkpAfterPost  := Self.AfterPost;
    bkpBeforePost := Self.BeforePost;
    Try
      Self.AfterPost := nil;
      Self.BeforePost := nil;
      Self.Edit;
      Self.FieldByName('QTDPRO_NOV').AsFloat := Self.FieldByName('ORD_QTDENV').AsFloat;
      Self.Post;
    Finally
      Self.AfterPost  := bkpAfterPost;
      Self.BeforePost := bkpBeforePost;
    End;
    cdsLotesDefinidosPedido.filtered := False;
    cdsLotesDefinidosPedido.filter := strFilter;
    cdsLotesDefinidosPedido.filtered := blnFilter;
    cdsLotesDefinidosPedido.EnableControls;

  End;
end;

function TOrdProIndustrial.fVerificaExisteItemFormulaSemLote : Boolean;
var
  cdsItens : TCdsItensSemLote;
  frmItensSemLote : TfrmItensSemLote;
begin
  cdsItens := TCdsItensSemLote.Create(nil);
  try
    pCarregaItensSemLote(cdsItens);

    Result := not cdsItens.isEmpty;

    if not Result then
      exit;

    pCriarFormularios(TfrmItensSemLote, frmItensSemLote);
    try
      frmItensSemLote.cdsItens := cdsItens;
      if frmItensSemLote.ShowModal = mrOk then
      begin
        cdsItens.EmptyDataSet;
        pCarregaItensSemLote(cdsItens);
        Result := not cdsItens.isEmpty;

        if Result then
          pMensagemOk('Existem matérias primas sem lote disponível, não será possível gravar a ordem de produção');

      end;

    finally
      pFreeAndNil(frmItensSemLote);
    end;

  finally
    FreeAndNil(cdsItens);
  end;

end;

function TOrdProIndustrial.fVerificaLoteExiste(strCodIte,
  strNumLot: String): Boolean;
  var qryVal: TUniQuery;
begin
  qryVal := fCriaQuery;
  Try
    qryVal.SQL.Add('SELECT COUNT(1) QTD FROM CADLOT WHERE LOT_NUMLOT = "'+strNumLot+'" AND LOT_CODEMP = "'+VS_StrCodEmp+'" AND LOT_CODITE = "'+strCodIte+'"');
    qryVal.Open;
    Result := qryVal.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryVal)
  End;
end;

function TOrdProIndustrial.fGetSQLLotesMateriaPrima(blnOrder: Boolean = True) : String;
begin
  Result := Result + ' SELECT LOT_CODITE AS CODITE,                   ';
  Result := Result + '        LOT_NUMLOT AS NUMLOT,                   ';
  Result := Result + '        LOT_SALDOS AS SALDOS,                   ';
  Result := Result + '        LOT_DTAVAL AS DTAVAL,                   ';
  Result := Result + '        IF(IFNULL(LOT_PRIIND,"N")="S",0,1) AS PRIIND,  ';
  Result := Result + '        CAST("N" AS CHAR(1)) AS SEMRES,         ';
  Result := Result + '        IF(LOT_SALDOS>0,0,1) AS EST             ';
  Result := Result + ' FROM CADLOT                                    ';
  Result := Result + ' WHERE LOT_CODEMP = '+QuotedStr(VS_strCodEmp)    ;
  Result := Result + '   AND LOT_CODITE = :CODITE                     ';
  Result := Result + '   AND LOT_STATUS = "S"                         ';
  Result := Result + '   AND LOT_LOTAPR = "S"                         ';
  Result := Result + '   AND LOT_FULFIL = "N"                         ';
  Result := Result + '   AND LOT_GARPRI = "N"                         ';
  Result := Result + '   AND LOT_NUMLOT <> "A DEFINIR"                ';
  Result := Result + ' ORDER BY IFNULL(LOT_PRIIND,"N") DESC           ';
  If blnOrder Then
    Result := Result + ' , EST, DTAVAL, NUMLOT ASC               ';
end;


function TOrdProIndustrial.fSelecionaLotesReserva(blnIgnoraCorrecao: Boolean = False): Boolean;
  Var
    cdsLotes : TZClient;
    fltQtdFal: Double;
    iUltimoLote : Integer;
    blnPermiteReservarProdutosComposicao: Boolean;
    objReservaSaldoOrdemProducaoIndustrial: TReservaSaldoOrdemProducaoIndustrial;
    fltOpiQlt,
    fltSalDis: Double;
  procedure pAddLote;
  begin
    SetLength(arrLotes, Length(arrLotes)+1);
    iUltimoLote := High(arrLotes);
  end;

  Procedure pSetaEstoqueDisponivel;
    var
      intIndex: Integer;
  Begin
    Try
      cdsLotes.IndexFieldNames := '';
      cdsLotes.First;
      While Not cdsLotes.Eof Do
      Begin
        cdsLotes.Edit;
        cdsLotes.FieldByName('SALDOS').AsFloat := RoundTo(fRetornaSaldoDisponivel(cdsLotes.FieldByName('CODITE').AsString,
                                                                          False,
                                                                          True,
                                                                          cdsLotes.FieldByName('NUMLOT').AsString,
                                                                          True,
                                                                          VS_StrCodEmp), intCasasDecimaisMateriaPrima* -1);
        fltSalDis := cdsLotes.FieldByName('SALDOS').AsFloat;
        If (fltOpiQlt > 0) And (fltSalDis < fltOpiQlt) Then
          cdsLotes.FieldByName('SALDOS').AsFloat := 0;

        For intIndex := 0 To Length(arrLotes)-1 Do
        Begin
          If (arrLotes[intIndex].strCodIte = cdsLotes.FieldByName('CODITE').AsString) AND
             (arrLotes[intIndex].strNumLot = cdsLotes.FieldByName('NUMLOT').AsString) Then
            cdsLotes.FieldByName('SALDOS').AsFloat:= cdsLotes.FieldByName('SALDOS').AsFloat - arrLotes[intIndex].fltQtdIte;
        End;

        cdsLotes.FieldByName('EST').AsString   := IfThen(cdsLotes.FieldByName('SALDOS').AsFloat>0,'0','1');
        cdsLotes.Post;

        cdsLotes.Next;
      End;
    Finally
      cdsLotes.IndexFieldNames := 'EST;PRIIND;DTAVAL;NUMLOT';
      cdsLotes.First;
    End;
  End;

Begin
  Result := True;
  Try
    cdsLotes := TZClient.Create(Self);
    cdsLotes.qryQuery.SQL.Text := fGetSQLLotesMateriaPrima(False);

    fltOpiQlt := fCfgSis('OPIQLT', varDouble);

    SetLength(arrLotes,0);

    Self.DisableControls;
    Self.First;
    While Not Self.Eof Do
    Begin
      If fEhMateriaPrimaEProdutoAGranel(Self.FieldByName('ORD_CODITE').AsString) And (Not (fProdutoIntermediario(Self.FieldByName('ORD_CODITE').AsString))) Then
      Begin
        pAddLote;
        With arrLotes[iUltimoLote] Do
        Begin
          fltQtdTot := Self.FieldByName('ORD_QTDPRO').AsFloat;
          intSequen := -1;
          blnAcaGra := True;
          strCodIte := Self.FieldByName('ORD_CODITE').AsString;
          strNumLot := '';
          fltQtdIte := Self.FieldByName('ORD_QTDPRO').AsFloat;
        End;
      End;
      Self.Next;
    End;
    Self.EnableControls;

    cdsProFor.First;
    While Not cdsProFor.Eof Do
    Begin
      If (cdsProFor.FieldByName('TIPITE').Asstring = 'CORREC') And blnIgnoraCorrecao Then
      Begin
        cdsProFor.Next;
        Continue;
      End;
      objReservaSaldoOrdemProducaoIndustrial:= TReservaSaldoOrdemProducaoIndustrial.Create;
      Try
        objReservaSaldoOrdemProducaoIndustrial.strTipoItem := cdsProFor.FieldByName('TIPITE').AsString;
        objReservaSaldoOrdemProducaoIndustrial.blnPermiteReservaComposicao:= fCfgSis('INCCOM', varBoolean);
        blnPermiteReservarProdutosComposicao:= objReservaSaldoOrdemProducaoIndustrial.fRetornaReservaProdutoComposicao;
      Finally
        FreeAndNil(objReservaSaldoOrdemProducaoIndustrial);
      End;

      If blnPermiteReservarProdutosComposicao Then
      Begin

        fltQtdFal := cdsProFor.FieldByName('QTDTOT').AsFloat;

        cdsLotes.qryQuery.ParamByName('CODITE').AsString := cdsProFor.FieldByName('ITESUB').AsString;
        cdsLotes.fAbreClient(True, 'TOrdProIndustrial.fReservaEstoqueOP');

        pSetaEstoqueDisponivel;

       { If cdsLotes.IsEmpty Then
        Begin
          pMensagemOK('O Produto (' + cdsProFor.FieldByName('ITESUB').AsString + ') não possui lote disponível!');
          Exit(False);
        End
        Else
        Begin }

        If Not cdsLotes.IsEmpty Then
        Begin
          cdsLotes.First;
          While (fltQtdFal > 0) Do
          Begin
            iUltimoLote := -1;

            If (cdsLotes.FieldByName('SALDOS').AsFloat > 0) Then
            Begin
              If (cdsLotes.FieldByName('SALDOS').AsFloat > fltQtdFal) Then
              Begin
                pAddLote;
                With arrLotes[iUltimoLote] Do
                Begin
                  fltQtdTot := cdsProFor.FieldByName('QTDTOT').AsFloat;
                  intSequen := cdsProFor.FieldByName('SEQUEN').AsInteger;
                  strCodIte := cdsLotes.FieldByName('CODITE').AsString;
                  strNumLot := cdsLotes.FieldByName('NUMLOT').AsString;
                  strIteAca := cdsProFor.FieldByName('ITEACA').AsString;
                  fltQtdIte := fltQtdFal;
                  fltQtdFal := 0.00;
                End;
              End

              Else
              Begin
                pAddLote;
                With arrLotes[iUltimoLote] Do
                Begin
                  fltQtdTot := cdsProFor.FieldByName('QTDTOT').AsFloat;
                  intSequen := cdsProFor.FieldByName('SEQUEN').AsInteger;
                  strCodIte := cdsLotes.FieldByName('CODITE').AsString;
                  strNumLot := cdsLotes.FieldByName('NUMLOT').AsString;
                  fltQtdIte := cdsLotes.FieldByName('SALDOS').AsFloat;
                  strIteAca := cdsProFor.FieldByName('ITEACA').AsString;
                  fltQtdFal := fltQtdFal - cdsLotes.FieldByName('SALDOS').AsFloat;

                  cdsLotes.Next;
                  If (cdsLotes.Eof) And (fltQtdFal > 0) Then
                  Begin
                    fltQtdIte := fltQtdIte +  fltQtdFal;
                    fltQtdFal := 0;
                  End
                End;

              End;

            End

            Else
            Begin
              if iUltimoLote >= 0 then
                arrLotes[iUltimoLote].fltQtdIte := arrLotes[High(arrLotes)].fltQtdIte + fltQtdFal
              else
              begin
                pAddLote;
                With arrLotes[iUltimoLote] Do
                Begin
                  fltQtdTot := cdsProFor.FieldByName('QTDTOT').AsFloat;
                  intSequen := cdsProFor.FieldByName('SEQUEN').AsInteger;
                  strCodIte := cdsLotes.FieldByName('CODITE').AsString;
                  strNumLot := cdsLotes.FieldByName('NUMLOT').AsString;
                  strIteAca := cdsProFor.FieldByName('ITEACA').AsString;

                  fltQtdIte := fltQtdFal;
                End;
              end;

              fltQtdFal := 0.00;

            End;
          End;

        End
        Else
        Begin
          pAddLote;
          With arrLotes[iUltimoLote] Do
          Begin
            fltQtdTot := cdsProFor.FieldByName('QTDTOT').AsFloat;
            intSequen := cdsProFor.FieldByName('SEQUEN').AsInteger;
            strCodIte := cdsProFor.FieldByName('ITESUB').AsString;
            strNumLot := '';
            fltQtdIte := cdsProFor.FieldByName('QTDTOT').AsFloat;
          End;
        End;
      End;
      cdsProFor.Next;
    End;
  Finally
    FreeAndNil(cdsLotes);
  End;
End;

Class function TOrdProIndustrial.fRetOrdemProducao(intFormul: Integer; strCodIte, strCodCor: String): String;
  Var
    qryOrdGer: TUniQuery;
Begin
  qryOrdGer := fCriaQuery;

  With qryOrdGer, SQL Do
  Begin
    Add('SELECT');
    Add('  GROUP_CONCAT(CONCAT(ORD_CODORD, "-", DATE_FORMAT(ORD_DTACAD,"%d/%m/%y"))) AS ORDENS');
    Add('FROM');
    Add('  ORDGER');
    Add('WHERE');
    Add('  ORD_CODITE = :CODITE');
    Add('  AND ORD_CODCOR = :CODCOR');
    Add('  AND ORD_FORMUL = :FORMUL');
    Add('  AND ORD_DTABAI IS NULL ');

    ParamByName('FORMUL').AsInteger := intFormul;
    ParamByName('CODITE').AsString  := strCodIte;
    ParamByName('CODCOR').AsString  := strCodCor;

    Open;

    Result := FieldByName('ORDENS').AsString;
  End;


  FreeAndNil(qryOrdGer);
End;

procedure TOrdProIndustrial.pGravaOrdExt(strCodIte, strCodCor, strSeqGer : String);
  Var
    qryOrdExt : TUniQuery;
    qryExtIns : TUniQuery;
    qryConExt : TUniQuery;
Begin

  qryOrdExt := fCriaQuery;
  qryConExt := fCriaQuery;
  qryExtIns := fCriaQuery;

  Try

    qryOrdExt.Close;
    qryOrdExt.SQL.Clear;
    qryOrdExt.SQL.Add(' SELECT AUTOINCREM FROM GEIMAT    '+
                      '   WHERE GMT_CODEMP = :CODEMP AND '+
                      '         GMT_CODITE = :CODITE AND '+
                      '         GMT_CODCOR = :CODCOR AND '+
                      '         GMT_STATUS = "A"');
    qryOrdExt.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryOrdExt.ParamByName('CODITE').AsString:= strCodIte;
    qryOrdExt.ParamByName('CODCOR').AsString:= strCodCor;
    qryOrdExt.Open;


    qryConExt := fCriaQuery;
    qryConExt.Close;
    qryConExt.SQL.Clear;
    qryConExt.SQL.Add(' SELECT * FROM GEIEXT          '+
                      '   WHERE GXT_SEQGMT = :SEQGER  ');
    qryConExt.ParamByName('SEQGER').AsString:= qryOrdExt.FieldByName('AUTOINCREM').AsString;
    qryConExt.Open;

    If Not(qryConExt.IsEmpty) Then
    Begin
      qryExtIns.Close;
      qryExtIns.SQL.Clear;
      qryExtIns.SQL.Add('SELECT * FROM ORDEXT WHERE EXT_SEQGER = :SEQGER');
      qryExtIns.ParamByName('SEQGER').AsString:= strSeqGer;
      qryExtIns.Open;

      qryConExt.First;
      While Not(qryConExt.Eof) Do
      Begin
        qryExtIns.Append;


        qryExtIns.FieldByName('AUTOINCREM').AsString:= fRetAutoIncrem('ORDEXT', VS_strCodEmp);
        qryExtIns.FieldByName('EXT_SEQGER').AsString:= strSeqGer;
        qryExtIns.FieldByName('EXT_EXTS01').AsString:= qryConExt.FieldByName('GXT_EXTS01').AsString;
        qryExtIns.FieldByName('EXT_EXTS02').AsString:= qryConExt.FieldByName('GXT_EXTS02').AsString;
        qryExtIns.FieldByName('EXT_EXTS03').AsString:= qryConExt.FieldByName('GXT_EXTS03').AsString;
        qryExtIns.FieldByName('EXT_NOMTER').AsString:= qryConExt.FieldByName('GXT_NOMTER').AsString;
        qryExtIns.FieldByName('EXT_CODEMP').AsString:= VS_strCodEmp;

        qryExtIns.Post;

        qryConExt.Next;
      End;


    End;

  Finally
    FreeAndNil(qryOrdExt);
    FreeAndNil(qryExtIns);
    FreeAndNil(qryConExt);
  End;

End;


procedure TOrdProIndustrial.pCarregaOrdCom(strCodIte, strCodCor : String);
  Var
    qryCompos : TUniQuery;
Begin
  Try
    qryCompos := fCriaQuery;
    qryCompos.SQL.Text := fSqlProdutosComposicaoSoma;

    Self.DisableControls;
    Self.First;

    While not Self.Eof Do
    Begin
      qryCompos.Close;
      qryCompos.ParamByName('CODITE').AsString := strCodIte;
      qryCompos.ParamByName('CODCOR').AsString := strCodCor;
      qryCompos.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCompos.ParamByName('CODACA').AsString := Self.FieldByName('ORD_CODITE').AsString;
      qryCompos.Open;

      While Not qryCompos.Eof Do
      Begin
        cdsOrdCom.Append;
        cdsOrdCom.FieldByName('AUTOINCREM').AsString := '';
        cdsOrdCom.FieldByName('ODC_SEQDET').AsString := Self.FieldByName('ORD_CODITE').AsString;
        cdsOrdCom.FieldByName('ODC_CODITE').AsString := qryCompos.FieldByName('ITESUB').AsString;
        cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat  := qryCompos.FieldByName('QTDITE').AsFloat;
        cdsOrdCom.FieldByName('ODC_IMP_OP').AsString := qryCompos.FieldByName('IMP_OP').AsString;
        cdsOrdCom.FieldByName('COMPOSICAO').AsString := qryCompos.FieldByName('DESITE').AsString;
        cdsOrdCom.FieldByName('REFERENCIA').AsString := qryCompos.FieldByName('REFERE').AsString;
        cdsOrdCom.FieldByName('SIGUNIDADE').AsString := qryCompos.FieldByName('SIGUNI').AsString;
        cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat  := 0;
        cdsOrdCom.FieldByName('ODC_VLRCUS').AsFloat  := 0;
        cdsOrdCom.FieldByName('ODC_TOTCUS').AsFloat  := 0;
        cdsOrdCom.Post;

        qryCompos.Next;
      End;

      Self.Next;
    End;

  Finally
    Self.First;
    Self.EnableControls;
    FreeAndNil(qryCompos);
  End;

End;

procedure TOrdProIndustrial.pCarregaOrdMat(strCodIte, strCodCor : String);
  Var
    qryDados : TUniQuery;
Begin
  qryDados := fCriaQuery(Self);
  Try
    With qryDados, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT DMT_SEQUEN,                                    ');
      Add('        DMT_ITESUB,                                    ');
      Add('        IFNULL(ITE_DESITE, DMT_DESCRI) AS ITE_DESITE,  ');
      Add('        DMT_QTDITE,                                    ');
      Add('        DMT_PERTOL,                                    ');
      Add('        ITE_DENSID,                                    ');
      Add('        DMT_CODFAS,                                    ');
      Add('        "FOR"                                          ');
      Add(' FROM DEIMAT                                           ');
      Add('   INNER JOIN GEIMAT ON GEIMAT.AUTOINCREM = DMT_SEQGER ');
      Add('   LEFT  JOIN CADITE ON ITE_CODITE = DMT_ITESUB        ');
      Add(' WHERE GMT_CODITE = :CODITE                            ');
      Add('   AND GMT_CODCOR = :CODCOR                            ');
      Add('   AND GMT_STATUS = "A"                                ');
      Add(' ORDER BY DMT_SEQUEN                                   ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODCOR').AsString := strCodCor;

      Open;

      While Not Eof Do
      Begin
        cdsOrdMat.Append;
        cdsOrdMat.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ORDMAT', VS_strCodEmp);
        cdsOrdMat.FieldByName('ODM_SEQGER').AsString := '';//FieldByName('').AsString
        cdsOrdMat.FieldByName('ODM_SEQITE').AsString := FieldByName('DMT_SEQUEN').AsString;
        cdsOrdMat.FieldByName('ODM_SEQUEN').AsInteger:= FieldByName('DMT_SEQUEN').AsInteger;
        cdsOrdMat.FieldByName('ODM_ITESUB').AsString := FieldByName('DMT_ITESUB').AsString;
        cdsOrdMat.FieldByName('ODM_DESCRI').AsString := FieldByName('ITE_DESITE').AsString;
        cdsOrdMat.FieldByName('ODM_QTDITE').AsFloat  := FieldByName('DMT_QTDITE').AsFloat;
        cdsOrdMat.FieldByName('ODM_PERTOL').AsFloat  := FieldByName('DMT_PERTOL').AsFloat;
        cdsOrdMat.FieldByName('ODM_DENSID').AsFloat  := FieldByName('ITE_DENSID').AsFloat;
        cdsOrdMat.FieldByName('ODM_CODFAS').AsString := FieldByName('DMT_CODFAS').AsString;
        cdsOrdMat.FieldByName('ODM_TIPOMP').AsString := 'FOR';
        cdsOrdMat.Post;
        Next;
      End;

    End;

  Finally
    FreeAndNil(qryDados);
  End;

End;

function TOrdProIndustrial.fSalvaOrdMat(strSeqGer : String) : Boolean;
Begin
  Try
    cdsOrdMat.DisableControls;
    cdsOrdMat.First;
    While Not cdsOrdMat.Eof Do
    Begin
      If fEmptyStr(cdsOrdMat.FieldByName('ODM_SEQGER').AsString) Then
      Begin
        cdsOrdMat.Edit;
        cdsOrdMat.FieldByName('ODM_SEQGER').AsString := strSeqGer;
        cdsOrdMat.Post;
      End;

      If fEmptyStr(cdsOrdMat.FieldByName('ODM_ITESUB').AsString) Then
      Begin
        cdsOrdMat.Edit;
        cdsOrdMat.FieldByName('ODM_ITESUB').Clear;
        cdsOrdMat.Post;
      End;

      cdsOrdMat.Next;
    End;

    Result := cdsOrdMat.fSalva;
  Finally
    cdsOrdMat.EnableControls;
  End;

End;

function TOrdProIndustrial.fRetCustoFormulacao : Double;
Begin
  Try
    Result := 0;
    cdsProFor.Filter := 'TIPPRO = ' + QuotedStr('FORMUL') + ' AND TIPITE = ' + QuotedStr('NORMAL');
    cdsProFor.Filtered := True;
    cdsProFor.First;
    While Not cdsProFor.Eof Do
    Begin
      Result := Result + (cdsProFor.FieldByName('QTDTOT').AsFloat * cdsProFor.FieldByName('PRECUS').AsFloat);
      cdsProFor.Next;
    End;

  Finally
    cdsProFor.Filtered := False;
    cdsProFor.Filter   := '';
    cdsProFor.First;
  End;

End;

function TOrdProIndustrial.fTemComposicaoParaCorrecao(blnFiltra : Boolean) : Boolean;
Begin
  Try
    Result := False;

    If blnFiltra Then
    Begin
      cdsOrdCom.Filter := 'ODC_SEQDET = ' + QuotedStr(Self.FieldByName('AUTOINCREM').AsString);
      cdsOrdCom.Filtered := True;
    End;

    cdsOrdCom.First;
    While Not cdsOrdCom.Eof Do
    Begin
      cdsOrdCom.Edit;
      cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat := cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat * Self.FieldByName('ORD_QTDENV').AsFloat;
      cdsOrdCom.Post;

      If (not Result) And (Not fUnidadeDoProdutoEhFracionaria(cdsOrdCom.FieldByName('ODC_CODITE').AsString)) And (Frac(cdsOrdCom.FieldByName('ODC_QTDUSA').AsFloat) > 0) Then
        Result := True;

      cdsOrdCom.Next;
    End;

  Finally
    If blnFiltra Then
    Begin
      cdsOrdCom.Filter := '';
      cdsOrdCom.Filtered := False;
    End;
    cdsOrdCom.First;
  End;

End;

procedure TOrdProIndustrial.pCarregaComposicoes(strAutInc : String);
begin

  If cdsOrdCom.Active Then
    cdsOrdCom.EmptyDataSet;
  cdsOrdCom.qryQuery.ParamByName('SEQGER').AsString := strAutInc;
  cdsOrdCom.fAbreClient(True, 'TOrdProIndustrial.fCarregaItens');

  //alterado para funcionar com updatemode em upwherekeyonly
  cdsOrdCom.FieldByName('AUTOINCREM').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
  cdsOrdCom.qryQuery.FieldByName('AUTOINCREM').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
  cdsOrdCom.First;

end;

procedure TOrdProIndustrial.pAcertaEmbalagens;
Begin
  Try
    cdsOrdCom.Filter := 'ODC_SEQDET = ' + QuotedStr(Self.FieldByName('AUTOINCREM').AsString);
    cdsOrdCom.Filtered := True;

    Self.BeforePost := Nil;
    If fTemComposicaoParaCorrecao(False) Then
    Begin
      Self.Edit;
      If not TfrmOrdProIndustrialAjustaEmbalagem.fValidaFracionados(Self) Then
        Self.FieldByName('SITFRA').AsString := 'N'
      Else
        Self.FieldByName('SITFRA').AsString := 'S';

      Self.Post;
    End;

  Finally
    cdsOrdCom.Filter := '';
    cdsOrdCom.Filtered := False;
    cdsOrdCom.First;
    Self.BeforePost := pBeforePost_AcertoEmbalagem;
  End;

End;

procedure TOrdProIndustrial.pBeforePost_AcertoEmbalagem(DataSet : TDataSet);
Begin
  If fTemComposicaoParaCorrecao(True) Then
    Self.FieldByName('SITFRA').AsString := 'N'
  Else
    Self.FieldByName('SITFRA').AsString := 'S';
End;

procedure TOrdProIndustrial.pTrocaComposicaoBaixa;
var
  blnFiltered : boolean;
  strFilter   : String;
  strSeqDet   : String;
begin
  If Not fVerificaAcessoSistema('OIACOM') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso para alterar a composição na manutenção da OP!', ['&O k']);
    Exit;
  End;

  blnFiltered := cdsOrdCom.Filtered;
  strFilter   := cdsOrdCom.Filter;

  try
    if fEmptyStr(Self.FieldByName('AUTOINCREM').AsString) then
      strSeqDet := Self.FieldByName('ORD_CODITE').AsString
    else
      strSeqDet := Self.FieldByName('AUTOINCREM').AsString;

    cdsOrdCom.Filtered := False;
    cdsOrdcom.Filter   := 'ODC_SEQDET = ' + QuotedStr(strSeqDet);
    cdsOrdCom.Filtered := True;

    pCriarFormularios(TfrmComposicaoProdAcabOP, frmComposicaoProdAcabOP);
    frmComposicaoProdAcabOP.cdsOrdCom      := cdsOrdCom;
    frmComposicaoProdAcabOP.edtCodAca.Text := Self.FieldByName('ORD_CODITE').AsString;
    frmComposicaoProdAcabOP.edtDesAca.Text := Self.FieldByName('DESITE').AsString;
    frmComposicaoProdAcabOP.strSeqDet      := strSeqDet;
    frmComposicaoProdAcabOP.ShowModal;
    pFreeAndNil(frmComposicaoProdAcabOP)

  finally
    cdsOrdCom.Filtered := blnFiltered;
    cdsOrdCom.Filter   := strFilter;
  end;
end;



procedure TOrdProIndustrial.pCarregaFormulaTOrdemProducao(fltPesoReal : double);
var
  objMateriaPrima  : TMateriaPrima;
begin

  FOrdemProducao.objFormula.fltPesoReal := fltPesoReal;
//  FOrdemProducao.objFormula.objProdutoGranel :=
  try
    cdsProFor.DisableControls;
    cdsProFor.Filtered := False;
    cdsProFor.Filter   := 'TIPPRO = ' + QuotedStr('FORMUL') + ' AND TIPITE = ' + QuotedStr('NORMAL');
    cdsProFor.Filtered := True;

    if cdsProFor.IsEmpty then
      FOrdemProducao.objFormula.blnEspecial := True
    else
    begin
      FOrdemProducao.objFormula.blnEspecial := False;

      cdsProFor.First;
      while not cdsProFor.Eof do
      begin
        objMateriaPrima := TMateriaPrima.Create;
        objMateriaPrima.strCodigo := cdsProFor.FieldByName('ITESUB').AsString;
        objMateriaPrima.strDescricao := cdsProFor.FieldByName('DESITE').AsString;
        objMateriaPrima.fltCusto := cdsProFor.FieldByName('PRECUS').AsFloat;
        objMateriaPrima.fltPercentualFormula := cdsProFor.FieldByName('QTDITE').AsFloat;

        FOrdemProducao.objFormula.lstMateriasPrimas.Add(objMateriaPrima);
        cdsProFor.Next;
      end;
    end;
  finally
    cdsProFor.Filtered := False;
    cdsProFor.Filter := '';
    cdsProFor.EnableControls;
  end;
end;

procedure TOrdProIndustrial.pCarregaCorrecoesTOrdemProducao;
var
  objCorrecao  : TCorrecao;
begin
  if objCorrOP <> nil then
  begin
    try
      objCorrOP.DisableControls;
      objCorrOP.First;
      while not objCorrOP.Eof do
      begin
        objCorrecao := TCorrecao.Create;
        objCorrecao.strCodigo := objCorrOP.FieldByName('DMT_ITESUB').AsString;
        objCorrecao.strDescricao := objCorrOP.FieldByName('DMT_DESCRI').AsString;
        If fEmptyStr(objCorrOP.FieldByName('DMT_DESCRI').AsString) Then
          objCorrecao.strDescricao := objCorrOP.FieldByName('DMT_REFERE').AsString;
        objCorrecao.fltCusto := fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [objCorrOP.FieldByName('DMT_ITESUB').AsString, VS_strCodEmp]);
        objCorrecao.fltQuantidade := objCorrOP.FieldByName('DMT_QTDITE').AsFloat;

        FOrdemProducao.lstCorrecoes.Add(objCorrecao);
        objCorrOP.Next;
      end;
    finally
      objCorrOP.EnableControls;
    end;
  end;
end;

procedure TOrdProIndustrial.pCarregaComposicaoTProdutoAcabado(strAutoIncremOrdDet : String; var objProdutoAcabado : TProdutoAcabado);
var
  objEmbalagem : TEmbalagem;
begin
  try
    cdsOrdCom.DisableControls;
    cdsOrdCom.Filtered := False;
    cdsOrdCom.Filter   := 'ODC_SEQDET = ' + QuotedStr(strAutoIncremOrdDet);
    cdsOrdCom.Filtered := True;

    cdsOrdCom.First;
    While Not cdsOrdCom.Eof Do
    Begin
      objEmbalagem := TEmbalagem.Create(fStrToTipoArredondamentoComposicao(fCfgSis('COMFRA', varString)), cdsOrdCom.FieldByName('ITEM_FRACIONADO').AsString = 'S');
      objEmbalagem.strCodigo := cdsOrdCom.FieldByName('ODC_CODITE').AsString;
      objEmbalagem.strDescricao := cdsOrdCom.FieldByName('COMPOSICAO').AsString;
      objEmbalagem.fltCusto := cdsOrdCom.FieldByName('ODC_VLRCUS').AsFloat;
      objEmbalagem.fltPeso := cdsOrdCom.FieldByName('PESO_PRODUTO').AsFloat;
      objEmbalagem.fltQuantidade := cdsOrdCom.FieldByName('ODC_QTDITE').AsFloat;

      objProdutoAcabado.objComposicao.lstEmbalagens.Add(objEmbalagem);

      cdsOrdCom.Next;
    End;

  Finally
    cdsOrdCom.Filtered := False;
    cdsOrdCom.Filter   := '';
    cdsOrdCom.First;
    cdsOrdCom.EnableControls;
  End;
end;

procedure TOrdProIndustrial.pGravaInformacaoPreviaDeCustoProdutoAcabado(objProdutoAcabado: TProdutoAcabado);
Var
  fltSalAtu,
  fltSalRes: Double;
Begin
  If (FExibeResumoDeCalculoOPITela) And (FBaixaOrdem) Then
  Begin
    If objProdutoAcabado.fltQuantidadeEnvasada <> 0 then
    Begin
      fltSalRes := TProdutoEstoque.fGetSaldos(Self.FieldByName('ORD_CODITE').AsString).FieldByName('SALRES').AsFloat;
      fltSalAtu := TProdutoEstoque.fGetSaldos(FieldByName('ORD_CODITE').AsString).FieldByName('SALDOS').AsFloat;

      FNumOrd:= FOrdemProducao.strCodigo;
      FCodAca:= objProdutoAcabado.strCodigo;
      FDesIte:= objProdutoAcabado.strDescricao;
      FEstAtu:= RoundTo(fltSalAtu - fltSalRes, intCasasDecimaisMateriaPrima* -1);
      FUndMed:= Self.FieldByName('SIGUNI').AsString +' - '+ fRetNomUnidade(Self.FieldByName('SIGUNI').AsString);
      FQtdPro:= objProdutoAcabado.fltQuantidadeProduzida;
      FQtdPzd:= objProdutoAcabado.fltQuantidadeEnvasada;
      FEstFin:= RoundTo((fltSalAtu - fltSalRes) + objProdutoAcabado.fltQuantidadeEnvasada, intCasasDecimaisMateriaPrima* -1);
      FCusFor:= FOrdemProducao.fRetornaCustoTotalProducao;
      FCusAtu:= fRetCustoUnitarioIteGer(objProdutoAcabado.strCodigo);
      FCusUni:= objProdutoAcabado.fRetornaCustoUnitario(FOrdemProducao.fRetornaCustoKilo);

      pGravaCustosProducaoTemp;
    End;
  End;

End;

procedure TOrdProIndustrial.pCarregaProdutosAcabadosTOrdemProducao(fltPesoReal : double);
var
  objProdutoAcabado  : TProdutoAcabado;
begin
  try
    Self.DisableControls;
    Self.First;
    while not Self.Eof do
    begin
      objProdutoAcabado := TProdutoAcabado.Create;
      objProdutoAcabado.strCodigo := Self.FieldByName('ORD_CODITE').AsString;
      objProdutoAcabado.strDescricao := Self.FieldByName('DESITE').AsString;
      objProdutoAcabado.enuMedidaUnidade := fStrToTipoMedidaUnidade(Self.FieldByName('KILLIT').AsString);
      objProdutoAcabado.fltPesoLitro := Self.FieldByName('PESLIT').AsFloat;
      objProdutoAcabado.fltPesoReal := fltPesoReal;
      objProdutoAcabado.fltQuantidadeProduzida := Self.FieldByName('ORD_QTDPRO').AsFloat;
      objProdutoAcabado.fltQuantidadeEnvasada := Self.FieldByName('ORD_QTDENV').AsFloat;
      objProdutoAcabado.strNumeroLote := Self.FieldByName('NUMLOT').AsString;

      objProdutoAcabado.objComposicao.strCodigo := Self.FieldByName('CODCOM').AsString;
      objProdutoAcabado.objComposicao.strDescricao := Self.FieldByName('DESCOM').AsString;
      pCarregaComposicaoTProdutoAcabado(Self.FieldByName('AUTOINCREM').AsString, objProdutoAcabado);

      FOrdemProducao.lstProdutosAcabados.Add(objProdutoAcabado);

      pGravaInformacaoPreviaDeCustoProdutoAcabado(objProdutoAcabado);

      Self.Next;
    end;
  finally
    Self.EnableControls;
  end;
end;


function TOrdProIndustrial.fAtualizaDadosAcabados(strAutoincremORDGER : String; fltPesoReal : double; strAgrupadorPreAlt: String) : boolean;
var
  objProdutoAcabado : TProdutoAcabado;
  fltCustoKilo : double;
begin
  Result := True;

  pSalvaOrdemProducaoJson(strAutoincremORDGER, FOrdemProducao);

  fltCustoKilo := FOrdemProducao.fRetornaCustoKilo;

  for objProdutoAcabado in FOrdemProducao.lstProdutosAcabados do
  begin
    if Self.Locate('ORD_CODITE', objProdutoAcabado.strCodigo, []) then
    begin
      Self.Edit;
      Self.FieldByName('ORD_CUSACA').AsFloat := objProdutoAcabado.fRetornaCustoEnvasadoFormula(fltCustoKilo);
      Self.FieldByName('ORD_CUSCOM').AsFloat := objProdutoAcabado.fRetornaCustoUnitarioComposicao;
      Self.FieldByName('ORD_PESACA').AsFloat := objProdutoAcabado.fRetornaPesoEnvasado;
      Self.FieldByName('ORD_VOLACA').AsFloat := objProdutoAcabado.fRetornaVolumeEnvasado;
      Self.Post;
    end;

    If objProdutoAcabado.fltQuantidadeEnvasada <> 0 then
    begin
      pSalvaDadosItem(objProdutoAcabado.strCodigo, strAutoincremORDGER);
      Result := Result And fAtualizaPesoAcabado(objProdutoAcabado, FOrdemProducao.objFormula.blnEspecial);
      Result := Result And fAtualizaUltimaCompraAcabado(objProdutoAcabado.strCodigo, objProdutoAcabado.fRetornaCustoUnitario(fltCustoKilo), objProdutoAcabado.fltQuantidadeEnvasada, strAgrupadorPreAlt);
      Result := Result And fAtualizaEstoqueAcabado(objProdutoAcabado.strCodigo, objProdutoAcabado.strNumeroLote, objProdutoAcabado.fltQuantidadeEnvasada);
    end;

    if not Result then
      exit;

  end;

end;


function TOrdProIndustrial.fAtualizaEstoqueAcabado(strCodigoItem, strNumeroLote : String; fltQuantidadeEnvasada : double) : boolean;
var
  fltQtdMovEstoque : double;
begin
  Result := True;
  //inclui movdet
  fltQtdMovEstoque := fltQuantidadeEnvasada - fRetQtdeBaixaParcial(strCodigoItem);
  //Pode acontecer de baixar um produto acabado qtd total e outros ainda ficou saldo para a ultima baixa, por isso testa a qtd para nao gravar movdet com qtd = 0
  If fltQtdMovEstoque > 0 Then
  Begin
    If blnGerarLotesPelaProcedure And Assigned(cdsLotesGeradosProcedure) And cdsLotesGeradosProcedure.Active Then
    Begin
      cdsLotesGeradosProcedure.Filtered := False;
      cdsLotesGeradosProcedure.Filter := 'CODITE = ' + QuotedStr(FieldByName('ORD_CODITE').AsString) + ' AND IDTITULO = 3';
      cdsLotesGeradosProcedure.Filtered := True;
      cdsLotesGeradosProcedure.First;
    End;

    If blnGerarLotesPelaProcedure And Assigned(cdsLotesGeradosProcedure) And (Not cdsLotesGeradosProcedure.IsEmpty) Then
    Begin
      while not cdsLotesGeradosProcedure.Eof Do
      Begin
        pInserirLoteSugestao(strCodigoItem);
        Result := Result And fAtualizaEstoqueCadIte(strCodigoItem, 'E', cdsLotesGeradosProcedure.FieldByName('QTDALO').AsFloat, 0, cdsLotesGeradosProcedure.FieldByName('NUMLOT').AsString);
        Result := Result And fIncluiDetMovimentacao(strCodigoItem, cdsLotesGeradosProcedure.FieldByName('QTDALO').AsFloat, 'E', cdsLotesGeradosProcedure.FieldByName('NUMLOT').AsString);
        cdsLotesGeradosProcedure.Next;
      End;
    End
    Else
    begin
      Result := Result And fAtualizaEstoqueCadIte(strCodigoItem, 'E', fltQtdMovEstoque, 0, strNumeroLote);
      Result := Result And fIncluiDetMovimentacao(strCodigoItem, fltQtdMovEstoque, 'E', strNumeroLote, fCfgSis('ATPRBI', varBoolean));
    End;
  End;
end;


procedure TOrdProIndustrial.pMostraMemo(stlIncon: TStrings);
begin
  try
    pCriarFormularios(TfrmMemo, frmMemo);
    frmMemo.cxMemo.Lines := stlIncon;
    frmMemo.cxMemo.Style.Font.Name := 'Courier New';
    frmMemo.cxMemo.Style.BorderColor := clBlack;
    frmMemo.cxMemo.Style.Color := $FFE4D5;
    frmMemo.cxMemo.Style.BorderColor := clBlue;
    frmMemo.cxMemo.Style.Font.Color := clNavy;
    frmMemo.cxMemo.Style.Font.Size := 12;
    frmMemo.Width := 800;
    frmMemo.Height := 600;
    frmMemo.ShowModal;
  except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[]');
    end;
  end;
  pFreeAndNil(frmMemo);
end;

procedure TOrdProIndustrial.pGravaCustosProducaoTemp;//Rotina utilizada apenas para exibir na tela como informativo
Begin

  if cdsCustoProducao.Locate('CODITE',FCodAca, []) then
    cdsCustoProducao.Edit
  else
    cdsCustoProducao.Append;

  cdsCustoProducao.FieldByName('CODITE').AsString   := FCodAca;
  cdsCustoProducao.FieldByName('NUMORD').AsString   := FNumOrd;
  cdsCustoProducao.FieldByName('DESITE').AsString   := FCodAca+' - '+FDesIte;
  cdsCustoProducao.FieldByName('UNDMED').AsString   := FUndMed;
  cdsCustoProducao.FieldByName('CUSFOR').AsCurrency := FCusFor;
  cdsCustoProducao.FieldByName('ESTATU').AsCurrency := FEstAtu;
  cdsCustoProducao.FieldByName('QTDPRO').AsCurrency := FQtdPro;
  cdsCustoProducao.FieldByName('QTDPZD').AsCurrency := FQtdPzd;
  cdsCustoProducao.FieldByName('ESTFIN').AsCurrency := FEstFin;
  cdsCustoProducao.FieldByName('CUSATU').AsCurrency := FCusAtu;
  cdsCustoProducao.FieldByName('CUSUNI').AsCurrency := FCusUni;

  cdsCustoProducao.Post;

End;

procedure TOrdProIndustrial.pCriaDataSetCustosProducao;
Begin
  If Not(Assigned(cdsCustoProducao)) Then
  Begin

    cdsCustoProducao:= TUniClientDataSet.Create(Self);
    dtsCustoProducao:= fCriaDataSource(cdsCustoProducao);

    cdsCustoProducao.FieldDefs.Add('CODITE', ftString, 12);
    cdsCustoProducao.FieldDefs.Add('NUMORD', ftString, 10);
    cdsCustoProducao.FieldDefs.Add('CUSFOR', ftFloat);
    cdsCustoProducao.FieldDefs.Add('DESITE', ftString, 150);
    cdsCustoProducao.FieldDefs.Add('UNDMED', ftString, 15);
    cdsCustoProducao.FieldDefs.Add('ESTATU', ftFloat);
    cdsCustoProducao.FieldDefs.Add('QTDPRO', ftFloat);
    cdsCustoProducao.FieldDefs.Add('QTDPZD', ftFloat);
    cdsCustoProducao.FieldDefs.Add('ESTFIN', ftFloat);
    cdsCustoProducao.FieldDefs.Add('CUSATU', ftFloat);
    cdsCustoProducao.FieldDefs.Add('CUSFIN', ftFloat);
    cdsCustoProducao.FieldDefs.Add('CUSUNI', ftFloat);

    cdsCustoProducao.CreateDataSet;
    cdsCustoProducao.Open;

    TFloatField(cdsCustoProducao.FieldByName('CUSFOR')).DisplayFormat := '#,####0.0000';
    TFloatField(cdsCustoProducao.FieldByName('ESTATU')).DisplayFormat := '#,##0.00';
    TFloatField(cdsCustoProducao.FieldByName('QTDPRO')).DisplayFormat := '#,##0.00';
    TFloatField(cdsCustoProducao.FieldByName('QTDPZD')).DisplayFormat := '#,##0.00';
    TFloatField(cdsCustoProducao.FieldByName('ESTFIN')).DisplayFormat := '#,##0.00';
    TFloatField(cdsCustoProducao.FieldByName('CUSATU')).DisplayFormat := '#,####0.0000';
    TFloatField(cdsCustoProducao.FieldByName('CUSFIN')).DisplayFormat := '#,####0.0000';
    TFloatField(cdsCustoProducao.FieldByName('CUSUNI')).DisplayFormat := '#,####0.0000';

  End;

End;

function TOrdProIndustrial.fRetStatusOpi(strCodOrd, strDataCad: String): Boolean;
  Var
    qryCons: TUniQuery;
begin
  qryCons:= fCriaQuery;
  Try
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add('SELECT ORD_DTABAI FROM ORDGER    '+
                    '  WHERE ORD_CODEMP = :CODEMP AND '+
                    '        ORD_CODORD = :CODORD AND '+
                    '        ORD_DTACAD = :DTACAD     ');

    qryCons.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryCons.ParamByName('CODORD').AsString:= strCodOrd;
    qryCons.ParamByName('DTACAD').AsString:= FormatDateTime('yyyy-mm-dd', StrToDate(strDataCad));
    qryCons.Open;

    Result:= (qryCons.FieldByName('ORD_DTABAI').IsNull Or
              fEmptyStr(qryCons.FieldByName('ORD_DTABAI').AsString));{Retorna Opi's em aberto}
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TOrdProIndustrial.fSQLProdutosAcabadosNaoInclusosOPI: String;
Begin
  Result:=  'SELECT SQL_NO_CACHE                                  '+
            '  I.ITE_CODITE,                                      '+
            '  I.ITE_CODPAG,                                      '+
            '  I.ITE_DESITE,                                      '+
            '  I.ITE_CODBAR,                                      '+
            '  UNI_SIGUNI,                                        '+
            '  UNI_DESUNI,                                        '+
            '  UNI_KILLIT,                                        '+
            '  MAR_DESMAR,                                        '+
            '  UNI_PESLIT,                                        '+
            '  IFNULL(ITE_MLTVEN,0) AS MLTVEN,                    '+
            '  G.ITE_SALDOS,                                      '+
            '  G.ITE_ESTMIN,                                      '+
            '  G.ITE_ESTMAX,                                      '+
            '  IFNULL(I.ITE_CNV_ML,0) AS CNV_ML,                  '+
            '  G.ITE_SAL_ML,                                      '+
            '  "D" AS MARDES                                      '+
            'FROM                                                 '+
            '  CADITE I                                           '+
            '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE '+
            '                     AND G.ITE_CODEMP = :CODEMP      '+
            '  INNER JOIN CADUNI   ON UNI_CODUNI   = I.ITE_CODUNI '+
            '  LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR '+
            'WHERE I.ITE_CODPAG = :CODITE                         '+
            '  AND I.ITE_CODCOR = :CODCOR                         '+
            '  AND NOT (LOCATE(I.ITE_CODITE, :LISITE) > 0)            ';
End;

function TOrdProIndustrial.fRetDataSourceProdAcabNaoInclusosOPI(strCodIte, strCodCor: String): TDataSource;
Begin
  cdsProdAcaNaoIncOPI.qryQuery.ParamByName('CODITE').AsString:= strCodIte;
  cdsProdAcaNaoIncOPI.qryQuery.ParamByName('CODCOR').AsString:= strCodCor;
  cdsProdAcaNaoIncOPI.qryQuery.ParamByName('CODEMP').AsString:= VS_strCodEmp;
  cdsProdAcaNaoIncOPI.qryQuery.ParamByName('LISITE').AsString:= FLisIte;
  cdsProdAcaNaoIncOPI.fAbreClient(True, 'TOrdProIndustrial.fRetDataSourceProdAcabNaoInclusosOPI');

  Result:= dtsProdAcaNaoIncOPI;
End;

procedure TOrdProIndustrial.pSalvaProdAcabadoNaoIncluso(DataSet: TDataSet);
Var
  recSaldos,
  recSaldosML: TRecSaldos;
  fltSaldos:Double;
Begin

  If (Not Self.Locate('ORD_CODITE', DataSet.FieldByName('ITE_CODITE').AsString, [])) Then
  Begin
    Self.Insert;
    Self.FieldByName('ORD_CODITE').AsString:= DataSet.FieldByName('ITE_CODITE').AsString;
    Self.FieldByName('ORD_QTDPRO').AsFloat := 0;

    FLisIte := FLisIte + DataSet.FieldByName('ITE_CODITE').AsString + '_';

    Self.FieldByName('ITE_CODPAG').AsString := DataSet.FieldByName('ITE_CODPAG').AsString;
    Self.FieldByName('ITE_CODCOR').AsString := FCodCor;

    Self.FieldByName('ESTOQUE_MINIMO').AsFloat := DataSet.FieldByName('ITE_ESTMIN').AsFloat;
    Self.FieldByName('ESTOQUE_MAXIMO').AsFloat := DataSet.FieldByName('ITE_ESTMAX').AsFloat;
    Self.FieldByName('CODBAR').AsString        := DataSet.FieldByName('ITE_CODBAR').AsString;


    fltSaldos := DataSet.FieldByName('ITE_SALDOS').AsFloat;

    If (DataSet.FieldByName('CNV_ML').AsFloat > 0) Then
      fltSaldos := fltSaldos + DataSet.FieldByName('ITE_SAL_ML').AsFloat / DataSet.FieldByName('CNV_ML').AsFloat;

    objSalLoj.pCalculaSaldos(Nil, recSaldos, recSaldosML,
                          fltSaldos, VS_strCodEmp, VS_strCodEmp,
                          Self.FieldByName('ORD_CODITE').AsString, DataSet.FieldByName('CNV_ML').AsFloat,
                          fCfgSis('ENTFUT', varBoolean), false, fCfgSis('ORDPRO', varBoolean), fCfgSis('CALSAL', varInteger));

    Self.FieldByName('ESTOQUE_FISICO').AsFloat     := recSaldos.fltEstFis;
    Self.FieldByName('ESTOQUE_DISPONIVEL').AsFloat := recSaldos.fltSalDis;


    Self.FieldByName('DESITE').AsString := DataSet.FieldByName('ITE_DESITE').AsString;
    Self.FieldByName('SIGUNI').AsString := DataSet.FieldByName('UNI_SIGUNI').AsString;
    Self.FieldByName('DESUNI').AsString := DataSet.FieldByName('UNI_DESUNI').AsString;

    Self.FieldByName('DESMAR').AsString := DataSet.FieldByName('MAR_DESMAR').AsString;
    Self.FieldByName('PESLIT').AsFloat  := DataSet.FieldByName('UNI_PESLIT').AsFloat;
    Self.FieldByName('MLTVEN').AsFloat  := DataSet.FieldByName('MLTVEN').AsFloat;

    if Self.FieldByName('PESLIT').AsFloat = 0 then
      stlItensSemUnidadeConfigurada.Add(Self.FieldByName('ORD_CODITE').AsString + ' - ' + Self.FieldByName('SIGUNI').AsString);

    Self.FieldByName('PESREA').AsFloat  := fltPesRea;
    Self.FieldByName('KILLIT').AsString := DataSet.FieldByName('UNI_KILLIT').AsString;
    Self.FieldByName('ESTUTI').AsFloat  := 0.00;

    If DataSet.FieldByName('UNI_KILLIT').AsString = 'K' Then
    Begin
      Self.FieldByName('PESACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat;

      If Self.FieldByName('PESREA').AsFloat > 0 Then
        Self.FieldByName('VOLACA').AsFloat := (Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat) / Self.FieldByName('PESREA').AsFloat
      Else
        Self.FieldByName('VOLACA').AsFloat := 0;

    End
    Else
    Begin
      Self.FieldByName('PESACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat *
                                            Self.FieldByName('PESREA').AsFloat;

      Self.FieldByName('VOLACA').AsFloat := Self.FieldByName('ORD_QTDPRO').AsFloat * Self.FieldByName('PESLIT').AsFloat;
    End;


    If Self.FieldByName('ORD_QTDPRO').AsFloat > 0 Then
    Begin
      Self.FieldByName('PESUNI').AsFloat := Self.FieldByName('PESACA').AsFloat / Self.FieldByName('ORD_QTDPRO').AsFloat;
      Self.FieldByName('VOLUNI').AsFloat := Self.FieldByName('VOLACA').AsFloat / Self.FieldByName('ORD_QTDPRO').AsFloat;
    End
    Else
    Begin

      If DataSet.FieldByName('UNI_KILLIT').AsString = 'K' Then
      Begin
        Self.FieldByName('PESUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat;
        Self.FieldByName('VOLUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat / Self.FieldByName('PESREA').AsFloat;
      End
      Else
      Begin
        Self.FieldByName('PESUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat * Self.FieldByName('PESREA').AsFloat;
        Self.FieldByName('VOLUNI').AsFloat := Self.FieldByName('PESLIT').AsFloat;
      End;

    End;

    Self.Post;
  End;
End;


procedure  TOrdProIndustrial.pAjustacdsLotesDefinidosPedidoSaldos(blnSomaReservaPedido: Boolean; strNumLote: String;strCodIte:String; QtdUti: Double; var blnQuantidadeInvalida: Boolean);
var qtdSalDisReal: Double;
    qtdUtiReal: Double;
begin
  blnQuantidadeInvalida := False;
  If Not blnSomaReservaPedido Then
  begin
    If cdsLotesDefinidosPedidoSaldos.Locate('NUMLOT;ITESUB', VarArrayOf([strNumLote, strCodIte]), []) Then
    Begin
      qtdSalDisReal := roundto((cdsLotesDefinidosPedidoSaldos.FieldByName('SALDIS').AsFloat + cdsLotesDefinidosPedidoSaldos.FieldByName('RESPED').AsFloat), -intCasasDecimaisMateriaPrima);
      qtdUtiReal := roundto(cdsLotesDefinidosPedidoSaldos.FieldByName('QTDUTI').AsFloat + QtdUti, -intCasasDecimaisMateriaPrima);

      If qtdSalDisReal  < qtdUtiReal Then
      begin
        blnQuantidadeInvalida := True;
        Exit;
      End;
    End;
  End;


  cdsLotesDefinidosPedidoSaldos.First;
  If cdsLotesDefinidosPedidoSaldos.Locate('NUMLOT;ITESUB', VarArrayOf([strNumLote, strCodIte]), []) Then
  Begin
    cdsLotesDefinidosPedidoSaldos.Edit;
    cdsLotesDefinidosPedidoSaldos.FieldByName('QTDUTI').AsFloat := cdsLotesDefinidosPedidoSaldos.FieldByName('QTDUTI').AsFloat + QtdUti;
    If blnSomaReservaPedido Then
      cdsLotesDefinidosPedidoSaldos.FieldByName('RESPED').AsCurrency := cdsLotesDefinidosPedidoSaldos.FieldByName('RESPED').AsCurrency + QtdUti;
    cdsLotesDefinidosPedidoSaldos.Post;
  End
  Else
  Begin;
    cdsLotesDefinidosPedidoSaldos.Insert;
    cdsLotesDefinidosPedidoSaldos.FieldByName('ITESUB').AsString := strCodIte;
    cdsLotesDefinidosPedidoSaldos.FieldByName('NUMLOT').AsString := strNumLote;
    If blnSomaReservaPedido Then
      cdsLotesDefinidosPedidoSaldos.FieldByName('RESPED').AsCurrency := QtdUti;

    If blnBaiVef Then
      cdsLotesDefinidosPedidoSaldos.FieldByName('SALDIS').AsCurrency  := fRetornaSaldoFisico(strCodIte,
                                                                                             True,
                                                                                             strNumLote,
                                                                                             VS_strCodEmp)
    Else
      cdsLotesDefinidosPedidoSaldos.FieldByName('SALDIS').AsCurrency  := fRetornaSaldoDisponivel(strCodIte,
                                                                                                 False,
                                                                                                 True,
                                                                                                 strNumLote,
                                                                                                 True,
                                                                                                 VS_strCodEmp);

    cdsLotesDefinidosPedidoSaldos.FieldByname('QTDUTI').AsFloat :=  QtdUti;
    cdsLotesDefinidosPedidoSaldos.Post;
  End;
End;



procedure TOrdProIndustrial.pRetornaNumeroLoteFatDor(var fltQtdUtilizadaNoLote: Double; var strNumLote: String; var fltQtdLoteAtual: Double; strSeqGer, strCodIte: String);
CONST
  SQL_CONSULTA_NUMLOT_FATDOR = 'SELECT FDO_NUMLOT, FDO_QTDITE, LOT_SALDOS, FDO_DESCRI, ODF_SEQFDO, ODF_ITEACA, CAST(IF(ODF_ITEACA = "" , "Fórmula", CONCAT(ODF_ITEACA, "-",ITE_DESITE)) AS CHAR(60)) AS ODF_ACADES, ODF_SEQUEN ' +
                               '  FROM ORDGER GR ' +
                               '  LEFT JOIN ODMFDO ON ODF_SEQORD = GR.AUTOINCREM ' +
                               '  LEFT JOIN EXTGOR ON FGO_ORDIND = GR.AUTOINCREM ' +
                               '  LEFT JOIN FATDOR ON FDO_SEQGER = FGO_SEQFGO AND FATDOR.AUTOINCREM = ODF_SEQFDO ' +
                               '  LEFT JOIN CADITE ON ITE_CODITE =  ODF_ITEACA ' +

                               '  LEFT JOIN CADLOT ON LOT_CODITE = FDO_CODITE ' +
                               '                  AND LOT_NUMLOT = FDO_NUMLOT ' +
                               '                  AND LOT_CODEMP = IFNULL(IFNULL( FGO_EMP_TE, IFNULL(FGO_EMP_CD, FDO_EMPITE) ), FDO_CODEMP) ' +
//                               ' WHERE ODM_TIPOMP = "FOR"                           '+
                               ' WHERE TRUE                           '+
                               '   AND GR.AUTOINCREM = :SEQGER                      '+
                               '   AND FDO_CODITE = :ITESUB                       '+
//                               '   AND LOT_SALDOS > 0                               '+
                               '   AND LOT_LOCFIS IS NOT NULL                       ';

  SQL_CONSULTA_LISTA_NUMLOT_FATDOR = ' AND LOCATE(FDO_NUMLOT, (:LISTA_NUMLOT_FATDOR)) = 0 ';


Var
  qryBusca: TUniQuery;
  strNumLoteUti: String;
  strRecLot: String;
  blnQuantidadeInvalida: Boolean;
Begin
  If Not blnUtilizaDistribuiLote Then
    Exit;
  strNumLoteUti := '_';
  qryBusca:= fCriaQuery();
  Try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add(SQL_CONSULTA_NUMLOT_FATDOR);

    qryBusca.ParamByName('SEQGER').AsString:= strSeqGer;
    qryBusca.ParamByName('ITESUB').AsString:= strCodIte;
    fltQtdLoteAtual := 0;
    fltQtdUtilizadaNoLote := 0;
    qryBusca.Open;
    cdsLotesDefinidosPedido.Filtered := False;

    while not qryBusca.Eof do
    begin
      strNumLote            := qryBusca.FieldByName('FDO_NUMLOT').AsString;
      fltQtdUtilizadaNoLote := fltQtdUtilizadaNoLote + qryBusca.FieldByName('FDO_QTDITE').AsFloat;

      If Pos(strNumLote, strNumLoteUti) = 0 Then
      Begin
        strNumLoteUti := strNumLoteUti + strNumLote + '-';
        fltQtdLoteAtual := fltQtdLoteAtual + fRetSaldosEmpresa(strCodIte, VS_strCodEmp,  strNumLote);
      End;

      If cdsLotesDefinidosPedido.Locate('NUMLOT;ITESUB;ITEACA', VarArrayOf([strNumLote, strCodIte, qryBusca.FieldByName('ODF_ITEACA').AsString]), []) Then
      Begin
        cdsLotesDefinidosPedido.Edit;
        cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat  := cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat+
                                                                  qryBusca.FieldByName('FDO_QTDITE').AsFloat;
        cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat  := cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat +
                                                                  qryBusca.FieldByName('FDO_QTDITE').AsFloat;

        cdsLotesDefinidosPedido.FieldByName('SALRES').AsFloat  := cdsLotesDefinidosPedido.FieldByName('SALRES').AsFloat+ +
                                                                  qryBusca.FieldByName('FDO_QTDITE').AsFloat;

        cdsLotesDefinidosPedido.Post;

        pAjustacdsLotesDefinidosPedidoSaldos(True, strNumLote, strCodIte, qryBusca.FieldByName('FDO_QTDITE').AsFloat, blnQuantidadeInvalida);
        cdsLotesDefinidosPedido.First;


      End
      Else
      Begin
        //SINALIZO QUE O LOTE ESTA APTO A SOFRER REDISTRIBUICAO ( NUM. DE LOTES > 1 )
        strRecLot := 'N';
        If cdsLotesDefinidosPedido.Locate('ITESUB;ITEACA', VarArrayOf([strCodIte, qryBusca.FieldByName('ODF_ITEACA').AsString]), []) Then
        Begin
          strRecLot := 'S';
          cdsLotesDefinidosPedido.Edit;
          cdsLotesDefinidosPedido.FieldByName('RECLOT').AsString := strRecLot;
          cdsLotesDefinidosPedido.Post;
        End;

        cdsLotesDefinidosPedido.Insert;
        cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString := 'S';
        cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString := strCodIte;

        cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString := qryBusca.FieldByName('ODF_ITEACA').AsString;
        cdsLotesDefinidosPedido.FieldByName('ACADES').AsString := qryBusca.FieldByName('ODF_ACADES').AsString;
        cdsLotesDefinidosPedido.FieldByName('SEQUEN').AsString := qryBusca.FieldByName('ODF_SEQUEN').AsString;
        cdsLotesDefinidosPedido.FieldByName('RECLOT').AsString := strRecLot;

        cdsLotesDefinidosPedido.FieldByName('DESITE').AsString := qryBusca.FieldByName('FDO_DESCRI').AsString;
        cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString := strNumLote;
        cdsLotesDefinidosPedido.FieldByName('LOTORI').AsString := strNumLote;
        cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat  := fRetSaldosEmpresa(strCodIte, VS_strCodEmp,  strNumLote);

        cdsLotesDefinidosPedido.FieldByName('SALRES').AsFloat  := qryBusca.FieldByName('FDO_QTDITE').AsFloat;

        If blnBaiVef Then
          cdsLotesDefinidosPedido.FieldByName('SALDIS').AsCurrency  := fRetornaSaldoFisico(strCodIte,
                                                                                        True,
                                                                                        strNumLote,
                                                                                        VS_strCodEmp)
        Else
          cdsLotesDefinidosPedido.FieldByName('SALDIS').AsCurrency  := fRetornaSaldoDisponivel(strCodIte,
                                                                                            False,
                                                                                            True,
                                                                                            strNumLote,
                                                                                            True,
                                                                                            VS_strCodEmp);

        cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat  := qryBusca.FieldByName('FDO_QTDITE').AsFloat;
        cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat  := qryBusca.FieldByName('FDO_QTDITE').AsFloat;
        cdsLotesDefinidosPedido.FieldByName('SEQFDO').AsString := qryBusca.FieldByName('ODF_SEQFDO').AsString;

        cdsLotesDefinidosPedido.Post;

        pAjustacdsLotesDefinidosPedidoSaldos(True,
                                             strNumLote,
                                             strCodIte,
                                             qryBusca.FieldByName('FDO_QTDITE').AsFloat,
                                             blnQuantidadeInvalida);
      End;

      qryBusca.Next;
    End;



  Finally
    FreeAndNil(qryBusca);
  End;

End;

function TOrdProIndustrial.fOrdemDeProducaoIndustrialJaEnderecada(strAutInc: String): Boolean;
Var
  qryGen: TUniQuery;
  blnNaoEnderecada: Boolean;
Begin
  //ORD_PENEND = "N" Não existe pendencia de enderecamento
  qryGen:= fCriaQuery();
  Try
    qryGen.SQL.Add('SELECT AUTOINCREM FROM ORDGER WHERE AUTOINCREM = "'+strAutInc+'" AND ORD_PENEND = "S"');
    qryGen.Open;

    blnNaoEnderecada:= Not(fEmptyStr(qryGen.FieldByName('AUTOINCREM').AsString));

    If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
      Result:= blnNaoEnderecada
    Else
      Result:= True;

  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TOrdProIndustrial.pInsereCorrecaoLote;
begin
  If Not blnUtilizaDistribuiLote Then
    Exit;
  cdsLotesDefinidosPedido.Insert;
  cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString := 'N';
  cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString := objCorrOP.FieldByName('DMT_ITESUB').AsString;
  cdsLotesDefinidosPedido.FieldByName('DESITE').AsString := objCorrOP.FieldByName('DMT_REFERE').AsString;
  cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString := objCorrOP.FieldByName('NUMLOT').AsString;
  cdsLotesDefinidosPedido.FieldByName('LOTORI').AsString := objCorrOP.FieldByName('NUMLOT').AsString;
  cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat  := fRetSaldosEmpresa(objCorrOP.FieldByName('DMT_ITESUB').AsString,
                                                                              VS_strCodEmp,
                                                                              objCorrOP.FieldByName('NUMLOT').AsString);
  cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := fRetornaSaldoDisponivel(objCorrOP.FieldByName('DMT_ITESUB').AsString,
                                                                                    False,
                                                                                    True,
                                                                                    objCorrOP.FieldByName('NUMLOT').AsString,
                                                                                    True,
                                                                                    VS_strCodEmp);
  cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat  := objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat;
  cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat  := objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat;
  cdsLotesDefinidosPedido.FieldByName('ORICOR').AsString := 'S';
  cdsLotesDefinidosPedido.Post;
end;

procedure TOrdProIndustrial.pInsereMateriaPrimaTemporariamenteApenasParaGeracaoDaOPI(cdsSubItemSelecionado: TUniClientDataSet);
Begin

  cdsSubItemSelecionado.First;
  While Not(cdsSubItemSelecionado.Eof) do
  Begin

    cdsProFor.Insert;
    cdsProFor.FieldByName('ITESUB').AsString:= cdsSubItemSelecionado.FieldByName('ITESUB').AsString;
    cdsProFor.FieldByName('CODPAG').AsString:= cdsSubItemSelecionado.FieldByName('CODPAG').AsString;
    cdsProFor.FieldByName('CODCOR').AsString:= cdsSubItemSelecionado.FieldByName('CODCOR').AsString;
    cdsProFor.FieldByName('SALDOS').AsFloat := cdsSubItemSelecionado.FieldByName('SALDOS').AsFloat;
    cdsProFor.FieldByName('QTDTOTACUMULADO').AsFloat:= cdsSubItemSelecionado.FieldByName('QTDTOTACUMULADO').AsFloat;
    cdsProFor.FieldByName('QTDTOT').AsFloat := cdsSubItemSelecionado.FieldByName('QTDTOT').AsFloat;
    cdsProFor.FieldByName('ITTEMP').AsString := 'S';
    cdsProFor.FieldByName('SEMSAL').AsString := 'S';
    cdsProFor.FieldByName('MARDES').AsString := 'S';

    cdsProFor.Post;

    cdsSubItemSelecionado.Next;
  End;

End;

procedure TOrdProIndustrial.pDeleteMateriaPrimaTemporariamenteApenasParaGeracaoDaOPI;
Begin

  cdsProFor.First;
  While Not(cdsProFor.Eof) do
  Begin

    If cdsProFor.FieldByName('ITTEMP').AsString = 'S' Then
      cdsProFor.Delete;

    cdsProFor.Next;
  End;

End;


procedure TOrdProIndustrial.pExcluirCorrecao(strNumLot, strCodite: String);
var strFilter: String;
    blnFiltered: Boolean;
begin
  If Not blnUtilizaDistribuiLote Then
    Exit;
  strFilter := cdsLotesDefinidosPedido.Filter;
  blnFiltered := cdsLotesDefinidosPedido.Filtered;
  cdsLotesDefinidosPedido.DisableControls;
  cdsLotesDefinidosPedido.Filtered := False;
  Try
    If cdsLotesDefinidosPedido.Locate('NUMLOT;ITESUB', VarArrayOf([strNumLot, strCodIte]), []) Then
      cdsLotesDefinidosPedido.Delete;
  Finally
    cdsLotesDefinidosPedido.Filter := strFilter;
    cdsLotesDefinidosPedido.Filtered := blnFiltered;
    cdsLotesDefinidosPedido.EnableControls;
  End;
end;

function TOrdProIndustrial.fGerarLotesPelaProcedure(ATipoBaixa: TTipoBaixa; ADtaVal: TDateTime): Boolean;
begin
  FenuTipoBaixa := ATipoBaixa;

  If Not blnGerarLotesPelaProcedure Then
    Exit(True);

  If ATipoBaixa = tpbResiduo Then
    Exit(True);

  pCriarFormularios(TfrmBaixaOrdProdIndCriarLotesAuto, frmBaixaOrdProdIndCriarLotesAuto);
  Try
    frmBaixaOrdProdIndCriarLotesAuto.FobjOrdProInd := Self;
    frmBaixaOrdProdIndCriarLotesAuto.FDtaVal := ADtaVal;
    frmBaixaOrdProdIndCriarLotesAuto.ShowModal;
  Finally
    Result := frmBaixaOrdProdIndCriarLotesAuto.FblnConfirma;
    If Result Then
      cdsLotesGeradosProcedure.Data :=  frmBaixaOrdProdIndCriarLotesAuto.cdsLotes.Data;

    FreeAndNil(frmBaixaOrdProdIndCriarLotesAuto);
  End;
end;

function TOrdProIndustrial.fGravarLotesDaProcedure: Boolean;
begin
  If FenuTipoBaixa = tpbResiduo Then
    Exit(True);

  Result := TfrmGravando.fExecutarModalA(fCadastrarLotesAux, 'Salvando lotes sugeridos ...', '');
End;

function TOrdProIndustrial.fCadastrarLotesAux(pgbProgresso: TCxProgressBar): Boolean;
begin
  If cdsLotesGeradosProcedure.isEmpty Then
    Exit(True);

  Try
    cdsLotesGeradosProcedure.Filter := 'IDTITULO = 3';
    cdsLotesGeradosProcedure.Filtered := True;

    If Assigned(pgbProgresso) Then
      pgbProgresso.Properties.Max := cdsLotesGeradosProcedure.RecordCount;

    cdsLotesGeradosProcedure.First;
    While Not cdsLotesGeradosProcedure.Eof Do
    Begin
      pInserirLoteSugestao;

      cdsLotesGeradosProcedure.Next;
      If Assigned(pgbProgresso) Then
        pgbProgresso.Position := pgbProgresso.Position + 1;
    End;

    Result := True;

  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, '[TOrdProIndustrial.fCadastrarLotesAux]');
      Result := False;
    End;
  End;
end;

function TOrdProIndustrial.fCriaQueryInsLotesSugeridos: TUniQuery;
var
  blnGerarCodBar: Boolean;
begin
  blnGerarCodBar := (fCfgSis('LOTEND', varString) = '2') And fUsaRotinaWMS;
  Result := fCriaQuery;
  Result.SQL.Clear;
  Result.SQL.Add(' INSERT INTO CADLOT(AUTOINCREM, ');
  Result.SQL.Add('                    LOT_NUMLOT, ');
  Result.SQL.Add('                    LOT_CODEMP, ');
  Result.SQL.Add('                    LOT_CODITE, ');
  Result.SQL.Add('                    LOT_DTAFAB, ');
  Result.SQL.Add('                    LOT_DTAVAL, ');
  Result.SQL.Add('                    LOT_DTABAL, ');
  Result.SQL.Add('                    LOT_SALBAL, ');
  Result.SQL.Add('                    LOT_SALDOS, ');
  Result.SQL.Add('                    LOT_LOCFIS, ');
  If blnGerarCodBar Then
    Result.SQL.Add('                  LOT_CODBAR, ');
  Result.SQL.Add('                    LOT_STATUS) ');
  Result.SQL.Add('            VALUES (:AUTINC,    ');
  Result.SQL.Add('                    :NUMLOT,    ');
  Result.SQL.Add('                    :CODEMP,    ');
  Result.SQL.Add('                    :CODITE,    ');
  Result.SQL.Add('                    :DTAFAB,    ');
  Result.SQL.Add('                    :DTAVAL,    ');
  Result.SQL.Add('                    :DTABAL,    ');
  Result.SQL.Add('                    :SALBAL,    ');
  Result.SQL.Add('                    :SALDOS,    ');
  Result.SQL.Add('                    :LOCFIS,    ');
  If blnGerarCodBar Then
    Result.SQL.Add('                  :CODBAR,    ');
  Result.SQL.Add('                    :STATUS)    ');
end;

procedure TOrdProIndustrial.pInserirLoteSugestao(ACodIte: String = '');
var
  strFilterCadLot: String;
  lCodIte: String;
begin
  lCodIte := ACodIte;
  If fEmptyStr(lCodIte) Then
    lCodIte := cdsLotesGeradosProcedure.FieldByName('CODITE').AsString;
  strFilterCadLot :=  'WHERE LOT_CODITE = "' + lCodIte + '"' +
                      '  AND LOT_CODEMP = "' + VS_strCodEmp + '"' +
                      '  AND LOT_NUMLOT ="' + cdsLotesGeradosProcedure.FieldByName('NUMLOT').AsString + '"';
  FQryConsulta.SQL.Clear;
  FqryConsulta.SQL.Add('SELECT LOT_NUMLOT QTD FROM CADLOT ' + strFilterCadLot);
  FqryConsulta.Open;

  If FqryConsulta.IsEmpty Then
  Begin
    qryInsLotesProc.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CADLOT', VS_strCodEmp);
    qryInsLotesProc.ParamByName('NUMLOT').AsString   := cdsLotesGeradosProcedure.FieldByName('NUMLOT').AsString;
    qryInsLotesProc.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryInsLotesProc.ParamByName('CODITE').AsString   := lCodIte;
    qryInsLotesProc.ParamByName('DTAFAB').AsDateTime := cdsLotesGeradosProcedure.FieldByName('DTAFAB').AsDateTime;
    qryInsLotesProc.ParamByName('DTAVAL').AsDateTime := cdsLotesGeradosProcedure.FieldByName('DTAVAL').AsDateTime;
    qryInsLotesProc.ParamByName('DTABAL').AsDateTime := fNow;
    qryInsLotesProc.ParamByName('SALBAL').AsFloat    := 0.00;
    qryInsLotesProc.ParamByName('SALDOS').AsFloat    := 0;
    qryInsLotesProc.ParamByName('LOCFIS').AsString   := cdsLotesGeradosProcedure.FieldByName('LOCFIS').AsString;
    qryInsLotesProc.ParamByName('STATUS').AsString   := 'S';

    If Assigned(qryInsLotesProc.FindParam('CODBAR')) Then
      qryInsLotesProc.ParamByName('CODBAR').AsString   := SplitString(qryInsLotesProc.ParamByName('NUMLOT').AsString, '/')[0];

    qryInsLotesProc.ExecSQL;
  End
end;

Procedure TOrdProIndustrial.pCarregaDadosImpressaoCadastroFases(var frmQckOrdProIndustrial : TfrmQckOrdProIndustrial; var qryDataSet: TUniQuery; strAutInc : String);
Begin
  qryDataSet.SQL.Text := objMonitor.fSQLPosicaoOperacoes;
  qryDataSet.ParamByName('SEQOPI').AsString := strAutInc;
  qryDataSet.Open;
  frmQckOrdProIndustrial.frxFases.DataSet := qryDataSet;
End;

Function TOrdProIndustrial.fUsaPesoDaQuantidadeMaximaDeProducao : Boolean;
Begin
  Result := ((Self.FieldByName('UQDMAX').AsString = 'S') or (Assigned(FchbUsaCapacidadeMaxima) And FchbUsaCapacidadeMaxima.Checked));
End;

function TOrdProIndustrial.fGetPesoProducao:Double;
Begin
  If fUsaPesoDaQuantidadeMaximaDeProducao Then
    Result := FCapacidadeMaxima
  Else
    Result := Self.fRetSoma('Peso');
End;

function TOrdProIndustrial.fGetVolumeProducao: Double;
Begin
  If fUsaPesoDaQuantidadeMaximaDeProducao Then
    Result := FCapacidadeMaxima / fltPesRea
  Else
    Result := Self.fRetSoma('Volume');
End;

procedure TOrdProIndustrial.pAbrirCdsFormula;
begin
  FcdsFormul.qryQuery.Close;

  Case FStatusOPI Of
    stInserindoOPI,
       stOPIAberta: Begin
                      FcdsFormul.qryQuery.SQL.Text := fGetSQLFormulaInserindoOuAbertaOPI;
                      FcdsFormul.qryQuery.ParamByName('CODITE').AsString := FStrCodIteFormula;
                      FcdsFormul.qryQuery.ParamByName('CODCOR').AsString := FStrCodCorFormula;
                      FcdsFormul.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
                    End;
       stOPIBaixada:Begin
                      FcdsFormul.qryQuery.SQL.Text := fGetSQLFormulaBaixada;
                      FcdsFormul.qryQuery.ParamByName('AUTINC').AsString := FStrAutIncFormula;
                    End;
  End;

  FcdsFormul.fAbreClient(True, 'TfrmManOrdProIndustrial.pCarregaDadosAdicionais');

  TFloatField(FcdsFormul.FieldByName('QTDFOR')).DisplayFormat := fMskDigitos(intCasasDecimaisMateriaPrima);
  TFloatField(FcdsFormul.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(intCasasDecimaisMateriaPrima);
  TFloatField(FcdsFormul.FieldByName('UNITAR')).DisplayFormat := fMskDigitos(intCasasDecimaisMateriaPrima);
  TFloatField(FcdsFormul.FieldByName('TOTCUS')).DisplayFormat := fMskDigitos(intCasasDecimaisMateriaPrima);
  TAggregateField(FcdsFormul.FieldByName('SUM_TOTCUS')).DisplayFormat := fMskDigitos(intCasasDecimaisMateriaPrima);
end;

function TOrdProIndustrial.fGetSQLFormulaBaixada: String;
begin
  Result := '';
  Result := Result + '  SELECT ODM_ITESUB AS ITESUB,                                            ';
  Result := Result + '         ODM_DESCRI AS DESCRI,                                            ';
  Result := Result + '         IF(ODM_TIPOMP = "FOR", ODM_QTDITE, 0) AS QTDFOR,                 ';
  Result := Result + '         DET_QTDITE * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) AS QTDITE,        ';
  Result := Result + '         DET_TOTCUS / DET_QTDITE AS UNITAR,                               ';
  Result := Result + '         DET_TOTCUS * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) AS TOTCUS,        ';
  Result := Result + '         ODM_TIPOMP AS TIPOMP,                                            ';
  Result := Result + '         CASE ODM_TIPOMP                                                  ';
  Result := Result + '           WHEN "FOR" THEN 0                                              ';
  Result := Result + '           WHEN "COR" THEN 1                                              ';
  Result := Result + '           ELSE 10                                                        ';
  Result := Result + '         END AS ORD                                                       ';
  Result := Result + '  FROM ORDMAT M                                                           ';
  Result := Result + '  INNER JOIN MOVDET D ON D.AUTOINCREM = ODM_SEQDET                        ';
  Result := Result + '  WHERE ODM_SEQGER = :AUTINC                                              ';
  Result := Result + '    AND ODM_TIPOMP <> "COM"                                               ';
  Result := Result + '  ORDER BY ORD                                                            ';
End;

function TOrdProIndustrial.fGetSQLFormulaInserindoOuAbertaOPI: String;
var
  strPeso: String;
begin
  strPeso := StringReplace(StringReplace(dbePeso.Text,'.','',[rfReplaceAll]), ',','.',[rfReplaceAll]);
  Result := '';
  Result := Result + '  SELECT                                                                                 ';
  Result := Result + '    DMT_ITESUB AS ITESUB,                                                                ';
  Result := Result + '    C.ITE_DESITE AS DESCRI,                                                              ';
  Result := Result + '    @PESTOT := "' + strPeso +'" PESTOT,                                                  ';
  Result := Result + '    DMT_QTDITE AS QTDFOR,                                                                ';
  Result := Result + '    @QTDITE := (@PESTOT * (DMT_QTDITE / 100)) AS QTDITE,                                 ';
  Result := Result + '    ((G.ITE_PRECUS *   @QTDITE)/@QTDITE) UNITAR,                                         ';
  Result := Result + '    (G.ITE_PRECUS * @QTDITE) AS TOTCUS,                                                  ';
  Result := Result + '    CAST("FOR" AS CHAR(3)) AS TIPOMP,                                                    ';
  Result := Result + '    0 AS ORD                                                                             ';
  Result := Result + '  FROM                                                                                   ';
  Result := Result + '    DEIMAT M                                                                             ';
  Result := Result + '    INNER JOIN GEIMAT                                                                    ';
  Result := Result + '      ON GEIMAT.AUTOINCREM = DMT_SEQGER                                                  ';
  Result := Result + '    INNER JOIN ITEGER G                                                                  ';
  Result := Result + '      ON G.ITE_CODITE = DMT_ITESUB                                                       ';
  Result := Result + '      AND G.ITE_CODEMP = :CODEMP                                                         ';
  Result := Result + '    INNER JOIN CADITE C                                                                  ';
  Result := Result + '      ON C.ITE_CODITE = G.ITE_CODITE                                                     ';
  Result := Result + '  WHERE TRUE                                                                             ';
  Result := Result + '    AND GMT_CODITE = :CODITE                                                             ';
  Result := Result + '    AND GMT_CODCOR = :CODCOR                                                             ';
  Result := Result + '    AND GMT_STATUS = "A"                                                                 ';
End;

function TOrdProIndustrial.fGetMenuMultiSelecao(strTitulo: String; arrOpcoes: Array Of String;
                                                blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False;
                                                intWidth: Integer = 0): TArrString;
  Var
    intContador: Integer;
begin
  If (Not blnLibQtd) And (Length(arrOpcoes) <= 1) Then
  Begin
    fMensagem('', 'É Necessário escolher ao menos 2 opções', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmGetMenuMultiSelecao, frmGetMenuMultiSelecao);
    SetLength(frmGetMenuMultiSelecao.arrOpcoes, Length(arrOpcoes));

    For intContador := 0 To Length(arrOpcoes)-1 Do
    Begin
      frmGetMenuMultiSelecao.arrOpcoes[intContador] := arrOpcoes[intContador];
    End;

    frmGetMenuMultiSelecao.blnSaiComEsc := blnSaiComEsc;
    frmGetMenuMultiSelecao.Caption      := strTitulo;

    If intWidth > 0 Then
    Begin
      frmGetMenuMultiSelecao.Width         := frmGetMenuMultiSelecao.Width + intWidth;
    End;

    frmGetMenuMultiSelecao.showModal;

    If frmGetMenuMultiSelecao.blnConfirma Then
    Begin
      Result := frmGetMenuMultiSelecao.ArrSelecionados;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TOrdProIndustrial.fGetMenuMultiSelecao]');
    End;
  End;

  pFreeAndNil(frmGetMenuMultiSelecao);

end;

function TOrdProIndustrial.fFoiBaixaPrdNaoRealizada(AStrAutInc: String): Boolean;
begin
  Result := fCampoTabela('ORD_BAINPD', 'ORDGER', ['AUTOINCREM'], [AStrAutInc]) = 'S';
end;

function TOrdProIndustrial.fDadosEmpresaRodape: String;
var
  qryEmp: TUniQuery;
  strCodEmp: String;
begin

  Result := '';

  strCodEmp := fCfgSis('EMPMDO');

  If (fEmptyStr(strCodEmp)) Then
    strCodEmp := VS_strCodEmp;

  qryEmp := fCriaQuery;
  Try
    Try
      qryEmp.SQL.Clear;
      qryEmp.SQL.Add(' SELECT EMP_NOMEMP, EMP_ENDERE, EMP_ENDNUM, EMP_ENDCMP, EMP_BAIRRO, CID_NOMCID, CID_ESTADO ');
      qryEmp.SQL.Add(' FROM CADEMP E ');
      qryEmp.SQL.Add(' INNER JOIN CADCID C ON E.EMP_CODCID = C.CID_CODCID ');
      qryEmp.SQL.Add(' WHERE EMP_CODEMP = :CODEMP ');
      qryEmp.ParamByName('CODEMP').AsString := strCodEmp;
      qryEmp.Open;

      If (Not qryEmp.IsEmpty) Then
        Result := qryEmp.FieldByName('EMP_NOMEMP').AsString + #13#10 +
                  qryEmp.FieldByName('EMP_ENDERE').AsString + ', ' +
                  qryEmp.FieldByName('EMP_ENDNUM').AsString + ' ' +
                  qryEmp.FieldByName('EMP_ENDCMP').AsString + ' - ' +
                  qryEmp.FieldByName('EMP_BAIRRO').AsString + #13#10 +
                  qryEmp.FieldByName('CID_NOMCID').AsString + '-' + qryEmp.FieldByName('CID_ESTADO').AsString;

    Except On
      E:Exception Do
        pMensagensErro(E.Message, '[TOrdProIndustrial.fDadosEmpresaRodape]');
    End;
  Finally
    FreeAndNil(qryEmp);
  End;
end;

procedure TOrdProIndustrial.pRedistribuiQtdUtiPorSaldoFisico;
var
  blnFilteredAnt: Boolean;
  strIndexNameAnt,
  strFilterAnt,
  strItecaAtual,       // << renomeado (era strSubProdutoAtual, mas guarda ITEACA)
  strItesubAtual,      // << NOVO - sub-produto/matéria-prima da linha em análise
  strLoteDestino,
  strLoteAtual: String;
  evtBeforePostAnt, evtAfterPostAnt: TDataSetNotifyEvent;
  cdsLotesPedBkp: TUniClientDataSet;
  fltQtdRestante,
  fltNovaQtdUti,
  fltSaldoOrigem: Double;
  blnError: Boolean;
begin
  // Salva estado original ANTES de qualquer mutação
  strFilterAnt     := cdsLotesDefinidosPedido.Filter;
  blnFilteredAnt   := cdsLotesDefinidosPedido.Filtered;
  evtBeforePostAnt := cdsLotesDefinidosPedido.BeforePost;
  evtAfterPostAnt  := cdsLotesDefinidosPedido.AfterPost;
  strIndexNameAnt  := cdsLotesDefinidosPedido.IndexName;

  cdsLotesPedBkp := TUniClientDataSet.Create(Self);

  try
    cdsLotesDefinidosPedido.BeforePost := nil;
    cdsLotesDefinidosPedido.AfterPost  := nil;
    cdsLotesDefinidosPedido.DisableControls;

    // Filtro inicial: só registros candidatos a redistribuição
    cdsLotesDefinidosPedido.Filter   := 'RECLOT = ''S''';
    cdsLotesDefinidosPedido.Filtered := True;

    // Backup imutável com o estado original - origem da iteração
    cdsLotesPedBkp.Data := cdsLotesDefinidosPedido.Data;

    // Índice ASC: ao buscar destino, escolhe o menor SALDIS que cobre,
    // preservando lotes folgados para origens futuras com QTDUTI maior.
    // O índice é (ITEACA;SALDIS); combinado com o filtro por (ITEACA + ITESUB),
    // a varredura sequencial percorre os candidatos ordenados por SALDIS crescente
    // dentro do subgrupo do sub-produto.
    cdsLotesDefinidosPedido.IndexName := 'idxSALDISAsc';

    cdsLotesPedBkp.First;
    While Not cdsLotesPedBkp.Eof Do
    Begin
      strItecaAtual  := cdsLotesPedBkp.FieldByName('ITEACA').AsString;
      strItesubAtual := cdsLotesPedBkp.FieldByName('ITESUB').AsString;   // << NOVO
      strLoteAtual   := cdsLotesPedBkp.FieldByName('NUMLOT').AsString;
      fltQtdRestante := cdsLotesPedBkp.FieldByName('QTDUTI').AsFloat;
      fltSaldoOrigem := cdsLotesPedBkp.FieldByName('SALDIS').AsFloat;

      // Só processa origens em DÉFICIT (QTDUTI > SALDIS no estado original).
      // Lotes com QTDUTI <= SALDIS não precisam redistribuir.
      If fltQtdRestante > fltSaldoOrigem Then
      Begin
        // Filtro do dataset principal: candidatos a destino DO MESMO SUB-PRODUTO
        // (mesmo ITEACA + mesmo ITESUB), excluindo o próprio lote-origem.
        // ATENÇÃO: filtrar apenas por ITEACA transferia consumo entre matérias-primas
        // diferentes (ex.: tampa virando galão) — o ITESUB é obrigatório aqui.
        cdsLotesDefinidosPedido.Filter := 'RECLOT = ''S''' +
                                          ' AND ITEACA = ' + QuotedStr(strItecaAtual) +
                                          ' AND ITESUB = ' + QuotedStr(strItesubAtual) +
                                          ' AND NUMLOT <> ' + QuotedStr(strLoteAtual);
        cdsLotesDefinidosPedido.Filtered := True;

        // Busca o primeiro destino que cobre TODA a QTDUTI da origem
        // (com idxSALDISAsc, é o menor SALDIS que ainda cabe)
        strLoteDestino := '';
        cdsLotesDefinidosPedido.First;
        While Not cdsLotesDefinidosPedido.Eof Do
        Begin
          If (cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat > 0)
         And (cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat >= fltQtdRestante) Then
          Begin
            strLoteDestino := cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString;
            Break;
          End;
          cdsLotesDefinidosPedido.Next;
        End;

        // Se encontrou destino, transfere TODA a QTDUTI do origem para o destino
        // (esvazia origem completamente)
        If strLoteDestino <> '' Then
        Begin
          // Restaura filtro do subproduto (sem exclusão de NUMLOT) para alcançar o origem.
          // Continua restrito a ITEACA + ITESUB — não pode "vazar" para outra matéria-prima.
          cdsLotesDefinidosPedido.Filter := 'RECLOT = ''S''' +
                                            ' AND ITEACA = ' + QuotedStr(strItecaAtual) +
                                            ' AND ITESUB = ' + QuotedStr(strItesubAtual);
          cdsLotesDefinidosPedido.Filtered := True;

          // Edita origem: zera QTDUTI, devolve toda a quantidade ao SALDIS.
          // Locate usa a tripla (ITEACA;ITESUB;NUMLOT) porque o mesmo NUMLOT pode
          // existir em vários ITESUBs (ex.: 'LT-UNC' aparece em 00185 e 01383).
          If cdsLotesDefinidosPedido.Locate('ITEACA;ITESUB;NUMLOT',
                                            VarArrayOf([strItecaAtual, strItesubAtual, strLoteAtual]),
                                            []) Then
          Begin
            fltNovaQtdUti := cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat - fltQtdRestante;
            pAjustacdsLotesDefinidosPedidoSaldos(False,
                                                 cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString,
                                                 cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                 - fltQtdRestante,
                                                 blnError);
            If Not blnError Then
            Begin
              cdsLotesDefinidosPedido.Edit;
              cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat := fltNovaQtdUti;
              If cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat > 0 Then
              Begin
                cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat := cdsLotesDefinidosPedidoSaldos.FieldByName('SALDIS').AsFloat +
                                                                         cdsLotesDefinidosPedidoSaldos.FieldByName('RESPED').AsFloat -
                                                                         cdsLotesDefinidosPedidoSaldos.FieldByName('QTDUTI').AsFloat;
              End;
              cdsLotesDefinidosPedido.Post;
            End;
          End;

          // Edita destino: consome do SALDIS, absorve no QTDUTI
          If cdsLotesDefinidosPedido.Locate('ITEACA;ITESUB;NUMLOT',
                                            VarArrayOf([strItecaAtual, strItesubAtual, strLoteDestino]),
                                            []) Then
          Begin
            fltNovaQtdUti := cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat + fltQtdRestante;

            pAjustacdsLotesDefinidosPedidoSaldos(False,
                                                 cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString,
                                                 cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                 + fltQtdRestante,
                                                 blnError);
            If Not blnError Then
            Begin
              cdsLotesDefinidosPedido.Edit;
              cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat := fltNovaQtdUti;
              If cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat > 0 Then
              Begin
                cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat := cdsLotesDefinidosPedidoSaldos.FieldByName('SALDIS').AsFloat +
                                                                         cdsLotesDefinidosPedidoSaldos.FieldByName('RESPED').AsFloat -
                                                                         cdsLotesDefinidosPedidoSaldos.FieldByName('QTDUTI').AsFloat;
              End;
              cdsLotesDefinidosPedido.Post;
            End;
          End;
        End;
      End;

      cdsLotesPedBkp.Next;
    End;

  Finally
    cdsLotesDefinidosPedido.Filter          := strFilterAnt;
    cdsLotesDefinidosPedido.Filtered        := blnFilteredAnt;
    cdsLotesDefinidosPedido.IndexName       := strIndexNameAnt;
    cdsLotesDefinidosPedido.BeforePost      := evtBeforePostAnt;
    cdsLotesDefinidosPedido.AfterPost       := evtAfterPostAnt;
    cdsLotesDefinidosPedido.EnableControls;
    If Assigned(cdsLotesPedBkp) Then
      FreeAndNil(cdsLotesPedBkp);
  end;
End;

End.
