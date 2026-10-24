unit untOrdPro;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema, untGravando, cxProgressBar,
     untFatDigEstruturaVidro, untFatEstruturaVidro, UniClientDataSet, UniDataSetProvider, untFatorPreco, untBaixaOrdProdAcabado,
     untImpNaoFiscal, WinSpool,  math, untLoteIndividual, System.Generics.Collections, frxClass, untPreAlt_Trigger,
     untTEstruturaPersonalizada, untFuncFatTypes, untConstantes, untAuditoriaGravacaoSaldo,

     Fulfillment.RegrasMovimentacaoEstoque,
     Fulfillment.Classes.Parametros,

     unTOrdProMonitoramento, untZClient;

Type
  TDefineQtdSubItem = procedure(const strCodSubIte: String; Var fltQtdSubIte: Double) of Object;
  EBaixaOrdemProducao = class(Exception);

Type
  TLoteInd = record
    strNumLot : String;
    fltQtd    : real;
end;

Type
  TItemSub = Record
    strCodIte : String;
    strDesIte : String;
    strNumLot : String;
    fltQtdPro : real;
    fltSalDis : real;
    strCodFab : String;
end;

Type
  TcdsItensErro = Class(TUniClientDataSet)
  public
    blnApenasSaldo : Boolean;
    recItemAdd     : TItemSub;

    procedure pAddItem(strErro : String);
    constructor Create(Owner: TComponent); override;
end;

Type
  TobjOPPai = Class
    strSeqGer : String;
    strSeqUsa : String;
    strCodEst : String;
    strCodIte : String;
    fltQtdEtq : double;
    fltQtdUsa : double;
    fltQtdApr : double;
end;

Type
  TobjOPFilha = Class
    strCodIte    : String;
    fltQtdEtqIni : double;
    fltQtdEtq    : double;
    fltQtdApr    : double;

end;

Type
  TDefinicaoLote = record
  strSequencia: String;
  strLoteDefinido: String;
  fltSaldoLoteDefinido: double;
End;

TDefinicoesLote = array of TDefinicaoLote;


Type TOrdPro = Class(TComponent)
  Private
    FTemArm: Boolean; // SE O ITEM ESTRUTURA TEM ARMAZEM (LOTE)
    FTemSal: Boolean;//Apenas grava se algum subitem tem ou não saldo
    FCodArm: String;
    FAutInc: String;
    FCodPro: String;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCli: String;
    FEndEnt: String;
    FDesCli: String;
    FCodIte: String;
    FDesIte: String;
    FObs001: String;
    FObs002: String;
    FObs_PD: String;
    FConfer: String;
    FQtdApr: Double;
    FQtdPro: Double;
    FDtaPro: TDateTime;
    FDtaCad: TDateTime;
    FDtaBai: TDateTime;
    FHorBai: TTime;
    FSeqInd: String;
    FCodFor: String;
    FqryEst: TUniQuery;
    FdspEst: TUniDataSetProvider;
    FNumPed: String;
    FEspPed: String;
    FEmpPed: String;
    FClaFis: String;
    FDtaEnt: TDateTime;

    FFatPre: TFatorPreco;
    strAgrupadorPreAlt: String;

    fltPreCom: Double;        // Preço de Compra
    fltDesF01: Double;        // ITE_DESF01
    fltDesF02: Double;        // ITE_DESF02
    fltDesF03: Double;        // ITE_DESF03
    fltDesF04: Double;        // ITE_DESF04
    fltDesF05: Double;        // ITE_DESF05
    fltDesF06: Double;        // ITE_DESF06
    fltICMEnt: Double;        // ITE_ICMENT
    fltIPIEnt: Double;        // ITE_IPIENT
    fltFrete : Double;        // ITE_FREENT
    fltAcrFin: Double;        // ITE_ACRFIN
    fltSubsti: Double;        // ITE_SUBSTI
    fltValFre: Double;        // ITE_VALFRE
    fltDesAdb: Double;        // ITE_DESADB
    fltSubFed: Double;        // ITE_SUBFED
    fltICMSai: Double;        // ITE_ICMSAI
    fltImpFed: Double;        // ITE_IMPFED
    fltDesOpe: Double;        // ITE_DESOPE
    fltPreCus: Double;        // Preço de Custo
    fltMarVe1: Double;        // Margem 1
    fltMarVe2: Double;        // Margem 2
    fltMarVe3: Double;        // Margem 3
    fltMarVe4: Double;        // Margem 4
    fltMarVe5: Double;        // Margem 5
    fltMarVe6: Double;        // Margem 6
    fltMarVe7: Double;        // Margem 7
    fltPreVe1: Double;        // Preço de Venda 1
    fltPreVe2: Double;        // Preço de Venda 2
    fltPreVe3: Double;        // Preço de Venda 3
    fltPreVe4: Double;        // Preço de Venda 4
    fltPreVe5: Double;        // Preço de Venda 5
    fltPreVe6: Double;        // Preço de Venda 6
    fltPreVe7: Double;        // Preço de Venda 7
    fltComAnt: Double;        // Preço de Compra Anterior
    fltCusAnt: Double;        // Preço de Custo Anterior
    fltMa1Ant: Double;        // Margem 1 Anterior
    fltMa2Ant: Double;        // Margem 2 Anterior
    fltMa3Ant: Double;        // Margem 3 Anterior
    fltMa4Ant: Double;        // Margem 4 Anterior
    fltMa5Ant: Double;        // Margem 5 Anterior
    fltMa6Ant: Double;        // Margem 6 Anterior
    fltMa7Ant: Double;        // Margem 7 Anterior
    fltPr1Ant: Double;        // Preço de Venda 1 Anterior
    fltPr2Ant: Double;        // Preço de Venda 2 Anterior
    fltPr3Ant: Double;        // Preço de Venda 3 Anterior
    fltPr4Ant: Double;        // Preço de Venda 4 Anterior
    fltPr5Ant: Double;        // Preço de Venda 5 Anterior
    fltPr6Ant: Double;        // Preço de Venda 6 Anterior
    fltPr7Ant: Double;        // Preço de Venda 7 Anterior
    fltComTb1: Double;        // ITE_COMTB1
    fltComTb2: Double;        // ITE_COMTB2
    fltComTb3: Double;        // ITE_COMTB3
    fltComTb4: Double;        // ITE_COMTB4
    fltComTb5: Double;        // ITE_COMTB5
    fltComTb6: Double;        // ITE_COMTB6
    fltComTb7: Double;        // ITE_COMTB7
    fltTCIFCu: Double;        // ITE_TCIFCU
    fltTSCust: Double;        // ITE_TSCUST
    fltDePiCo: Double;        // ITE_DEPICO
    fltDeICMS: Double;        // ITE_DEICMS
    fltFatReg: Double;        // ITE_FATREG
    fltTotPreMed: Double;        // ITE_PREMED
    fltTotPreUlt: Double;     // ITE_PREULT
    fltTotImpUlt: Double;     // ITE_IMPULT


    PrinterHandler: NativeUInt;
    impNaoFiscal: TImpNaoFiscal;

    FDefineQtdSubItem: TDefineQtdSubItem;

    arrLotes : Array of TLoteInd;
    lstOPPai   : TObjectList<TobjOPPai>;
    lstOPFilha : TObjectList<TobjOPFilha>;

    FCodSep: String;
    FobjItensAcabado: TUniClientDataSet;
    FObjItensEstrutura: TUniClientDataSet;

    cdsDataSetQtdEditadaOrdPro: TUniClientDataSet;

    FobjEstruturaPersonalizada : TEstruturaPersonalizada;
    FRecItem : TDadosFechamento;

    FFulfillment : TFulfillment;

    FblnManutOrdProVidro: Boolean;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    FobjMonitor: TOrdProMonitoramento;

    blnMONFAS: Boolean;

    FcdsItensDefinidosCorrecao: TZClient;
    FBlnNotaRefugoVinculada: Boolean;

    function fModoEstruturaPersonalizada : Boolean;
    function fDocumentoEhSaida : Boolean;

    {**************************************}
    {* FUNCOES DE LEITURA DA PROPRIEDADE  *}
    {***********************************AF*}
    function getDtaBai: String;
    function getDtaCad: String;
    function getDtaPro: String;
    function getQtdApr: String;
    function getQtdPro: String;
    function getDesCli: String;
    function getDesIte: String;

    {*******************************************}
    {* PROCEDURES DE GRAVAÇÃO DAS PROPRIEDADES *}
    {****************************************AF*}
    procedure setDtaBai(const Value: String);
    procedure setDtaCad(const Value: String);
    procedure setDtaPro(const Value: String);
    procedure setQtdApr(const Value: String);
    procedure setQtdPro(const Value: String);

    Function fEstrututaTemLote: Boolean;
    procedure setCodIte(const Value: String);
    procedure pGerarLote(strNumLot: String; blnPriPro: boolean = False; strCodItem: String = '');
    procedure pAddArrLotes(strNumLot: String; fltQtd: Real);
    procedure pCarregaOPFilhas(strCodEstrutura: String; fltQtd: Double;qryTabela : TDataSet = nil);
    procedure pBeforePostQryOrdPro(DataSet: TDataSet);
    function fGeraOrdemProducaoFilha(strCodEst: String;
      fltQtdPro: Double): String;
    procedure pSetSeqGer(strCodIte, strAutInc: string);
    procedure pSetSeqUsa(strCodEst, strAutInc: string);
    function fSQLEstrutura(strCodPro: string): string;
    procedure pGeraLoteSequencial(strCodItem: String = ''; strCodArma: String = ''; strCodEmpr: String = '');
    function fBaixarOrdemProducaProdutoAcabado(pgbStatus: TcxProgressBar): Boolean;
    procedure pInsereItensNovos;
    procedure pAtualizaCusto;
    procedure pBaixarOrdemProducao(fltQtdPro: Double);
    function fGravarMovDet(strAutInc, strNumDoc, strCodIte, strCodCli: String;
      fltQtd: Currency; strClaFis, strCodPro, strNumLot: String): Boolean;
    procedure pAtualizarLoteDetPro(strAutInc, strNumLot: String);
    function fRetornaPrecoMedio(fltQtdPro, fltSaldosAntPro, fltPreMedAntPro: Double): Double;
    function fSalvaDadosItemMovPro(strSeqGer: String; strCodIte: String): Boolean;
    function fConsideraLoteEstoqueExternoSubProdutosFulfillment: Boolean;

    function fDeveMovimentarEstoqueFisico(AFulRegrasMovEstoque: FulfillmentRegrasMovimentacaoEstoque): Boolean;
    function fDeveMovimentarEstoqueExterno(AFulRegrasMovEstoque: FulfillmentRegrasMovimentacaoEstoque): Boolean;

    function fGetProximoSequenDetProFase(AStrSeqOrd: String): Integer;
    function fDefinirCorrecoesFases: Boolean;
    function fTemNotaRefugoJaEmitida(AStrAutIncOrdPro: String): Boolean;
    function fGetItensCorrecao: String;

  Public
    blnRecSub: Boolean;
    qryRelPro: TUniQuery;
    qryOrdPro: TUniQuery;
    dtsOrdPro: TDataSource;

    cdsIteEst: TUniClientDataSet;
    dtsIteEst: TDataSource;

    objLotInd: TLoteIndividual;

    blnTransacao: Boolean;

    blnFaturamento : Boolean;
    FblnApenasMovimentaProdAcabado: Boolean;

    //*************************************************//
    // ARQUIVO DETALHADO DA ORDEM DE PRODUCAO          //
    //**********************************************ED*//
    qryDetPro: TUniQuery;
    dtsDetPro: TDataSource;

    subItensEstruturaVidro: TSubItensVidro;

    procedure pSetObjEsttruturaPersonalizada(AEstruturaPersonalizada: TEstruturaPersonalizada);
    procedure pSetRecItemDadosFechamento(ARecItem: TDadosFechamento);

    {**************************************}
    {* FUNCTIONS                          *}
    {***********************************AF*}
    function fCarregaOrdPro(strOrdPro: String = ''; blnBaixad: Boolean = False): Boolean;
    function fGravaDetOrdPro(strSeqMat: String): Boolean;
    function fGravaDetOrdProFases(strSeqMat, strAutIncFase: String; cdsSubProdutos: TUniClientDataSet): Boolean;
    function fOrdemProducaoExiste: Boolean;
    function fRetPedidoOrdPro(strCodPro: String; Var strNumPed, strMen001, strMen002: String; var dtaPrevis: TDate; var tmrHPrevi: TTime): Boolean;
    function fRetPrecoCustoIte(strCodIte: String): Double;
    function fAtuPrecosProAca(strCodIte: String; fltQtdPro: Double; strAutInc: String = ''; blnBaixaTotal: Boolean = False): Boolean;
    function fRetPrecoCustoProAca: Double;
    function fRetPrecoVendaProAca(intOpcao, intTabPre: Integer): Double;
    function fVerificaLoteSubItens: Boolean;
    function fAtualizaQtdSubProd(strCodPro: String; fltQtdPro: Double): Boolean;
    function fInsereOrdemProducao: Boolean;
    function fDefinirOrdemProducaoItem: Boolean;
    function fBaixaOrdPro(fltQtdPro: Double; strConfer: String; blnGerarEstoque: Boolean = True): Boolean;
    function fBaixaOrdPro2(fltQtdPro: Double; strConfer: String; blnGerarEstoque: Boolean = True): Boolean;
    function fBaixaOrdProDV(fltQtdPro: Double; strConfer: String): Boolean;
    function fVerificaEstoqueLote(fltQtdPro: Double; blnExibeCodFabrica: Boolean = False):Boolean;
    function fValidaSaldoLotesSubItens(fltQtdPro: Double = 0; blnExibeCodFabrica: Boolean = False; blnValidaRelSaldoInsuficienteNoLancamentoOP: Boolean = False): Boolean;
    function fAjustaSequencialDia: Boolean;
    procedure pImprimeEtiqueta(fltQtdPro : real);

    function fOrigemOrdemProducaoEhPorArquivoDeImportacao(ACodPro, ACodEmp : String) : Boolean;
    function fGravarMovGer(strCodCli, strClaFis: String; var strAutInc: String): String;
    function fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque : Boolean;

    {**************************************}
    {* PROCEDURES                         *}
    {***********************************AF*}
    procedure pCriaTemporaria(blnAlteracao: Boolean; strCodPro: String; AStrAutIncFase: String = '');
    procedure pImprimeOrdPro(strCodPro          : String;
                             Var intUltimaLinha : Integer;
                             blnRefere          : Boolean = False;
                             strCodEmpP         : String  = '';
                             blnSelecOrdOP      : Boolean = True;
                             blnUltfolha        : Boolean = False);

    procedure pAtuDados;
    procedure pLimpaDados;
    procedure pAtualizarClienteEndEntrega(strOrdPro, strCodCli, strAutInc: String);
    procedure pAtualizarDadosPedido(strOrdPro, strNumPed, strEspPed, strEmpPed: String);
    procedure pRetPrecosProAca(strCodIte: String);
    procedure GravaQuantidadeEditaDoSubItem(strCodIte: String; fltQtd: Double);
    procedure pCriaFieldsCdsDataSetQtdEditadaOrdPro;
    function fExisteNivelInferiorSemBaixa(strAutoincrem : String): Boolean;
    function fExisteNivelInferior(strAutoincrem : String) : Boolean;
    function fExisteNivelSuperiorComBaixa(strAutoincrem : String) : Boolean;
    function fRetornaSaldoReservadoOrdPro(strCodPro, strCodIte, strNumLot : String) : Real;
    function fCarregaOPMonitoramento(strCodBar: String): Boolean;
    function fGravarFasesDaOrdem(AStrAutIncOrd, AStrCodIteEstrutura: String): Boolean;
    function fProdutoExisteNaEstrutura(AStrIteEstrut, AStrSubProd: String): Boolean;
    function fQuantidadeProdutoNaEstrutura(AStrIteEstrut, AStrSubProd: String): Double;
    procedure pImprimeOrdProMod2e7(qryOrd         : TUniQuery;
                                   Var
                                   intUltimaLinha : Integer;
                                   blnRefere      : Boolean = False;
                                   blnUltfolha    : Boolean = False);

    procedure Imp(strTexto: String; blnPula: Boolean = True; blnRetCaractEsp: Boolean = True);
    function fOrdemProducaoProdutoAcabado(strCodPro: String; blnManutOrdProVidro: Boolean = False; blnApenasMovimentaProdAcabado: Boolean = False): Boolean;
    class function fOrdemProducaoBaixada(strCodPro, strCodEmp: String): Boolean;
    class function fExcluirOrdemProducao(strOrdPro, strCodEmp, strNomForm, strOpeDel: String; blnValidaBaixada: Boolean = True): Boolean;
    class procedure pLimpaPedidoDaOrdemProducao(strOrdPro, strCodEmp: String);
    class procedure pLimpaOrdProDoPedido(strOrdPro, strNumPed, strEspDoc, strCodEmp: String);
    class function fSaldoLote(strCodIte, strNumLot, strCodEmp : String) : Real;
    class function fVerificaOPBaixada(strNumDoc, strEspDoc, strEmpDoc, strOrdPro: String): Boolean;


    property strAutInc: String  Read FAutInc   Write FAutInc;
    property strCodPro: String  Read FCodPro   Write FCodPro;
    property strNumDoc: String  Read FNumDoc   Write FNumDoc;
    property strEspDoc: String  Read FEspDoc   Write FEspDoc;
    property strCodEmp: String  Read FCodEmp   Write FCodEmp;
    property strCodCli: String  Read FCodCli   Write FCodCli;
    property strDesCli: String  Read getDesCli Write FDesCli;
    property strEndEnt: String  Read FEndEnt   Write FEndEnt;
    property strCodIte: String  Read FCodIte   Write setCodIte;
    property strDesIte: String  Read getDesIte Write FDesIte;
    property strObs001: String  Read FObs001   Write FObs001;
    property strObs002: String  Read FObs002   Write FObs002;
    property strObs_PD: String  Read FObs_PD   Write FObs_PD;
    property strConfer: String  Read FConfer   Write FConfer;
    property strQtdApr: String  Read getQtdApr Write setQtdApr;
    property strQtdPro: String  Read getQtdPro Write setQtdPro;
    property strDtaPro: String  Read getDtaPro Write setDtaPro;
    property strDtaCad: String  Read getDtaCad Write setDtaCad;
    property strDtaBai: String  Read getDtaBai Write setDtaBai;
    property strSeqInd: String  Read FSeqInd   Write FSeqInd;
    property strCodArm: String  Read FCodArm   Write FCodArm;
    property strCodSep: String  Read FCodSep   Write FCodSep;
    property strNumPed: String  Read FNumPed   Write FNumPed;
    property strEspPed: String  Read FEspPed   Write FEspPed;
    property strEmpPed: String  Read FEmpPed   Write FEmpPed;
    property strCodFor: String  Read FCodFor   Write FCodFor;
    property strClaFis: String  Read FClaFis   Write FClaFis;
    property dtaDtaEnt: TDateTime Read FDtaEnt Write FDtaEnt;
    property pDefineQtdSubItens: TDefineQtdSubItem Read FDefineQtdSubItem Write FDefineQtdSubItem;

    property blnTemArm   : Boolean Read FTemArm;
    property blnTemSal   : Boolean Read FTemSal      Write FTemSal;

    property Fulfillment : TFulfillment Read FFulfillment Write FFulfillment;

    property objMonitor: TOrdProMonitoramento Read FobjMonitor Write FobjMonitor;
    property fltQtdAprox: double Read FQtdApr;
    property cdsItensDefinidosCorrecao: TZClient Read FcdsItensDefinidosCorrecao Write FcdsItensDefinidosCorrecao;
    property blnNotaRefugoVinculada: Boolean Read FBlnNotaRefugoVinculada Write FBlnNotaRefugoVinculada;

    Constructor Create(Owner: TComponent; blnFaturamento : boolean); Reintroduce;
    Destructor  Destroy; Override;

  End;

implementation

uses untFuncoes, untFuncoesSimples, untCfgRel, untMovGer,
  untCadIte, untPreAlt, untParCalculaPrecoCusto, untEnderecoEntrega,
  untTConfiguracao, untVerificaEstoqueOrdPro,
  untCadLote, untQckOrdProModelo5, untObservacao, TypesRel,
  untEditorFastImpressao, untExibeArvoreOrdProd, untImpEtiOP, untIFatReservaSaldo,
  untTFatReservaSaldo, untFuncoesRel, untFuncoesRel2, untValidaCapacidadeMaximaLote,
  untQckOrdProducaoImp;

{ TOrdPro }

constructor TOrdPro.Create(Owner: TComponent; blnFaturamento : boolean);
begin
  Inherited Create(Owner);

  FblnManutOrdProVidro := False;
  FFulfillment := TFulfillment.New;

  FClaFis := '';
  FDtaEnt := 0;

  FillChar(FRecItem, SizeOf(FRecItem), #0);
  FobjEstruturaPersonalizada := Nil;

  If (fCfgSis('ATPCPM') = 'S') Then
  Begin
    pCriaFieldsCdsDataSetQtdEditadaOrdPro;
  End;

  FDefineQtdSubItem := nil;
  subItensEstruturaVidro := TSubItensVidro.Create;
  SetLength(subItensEstruturaVidro.FItems, 0);
  Self.blnFaturamento := blnFaturamento;
  FblnApenasMovimentaProdAcabado := False;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;

  blnRecSub    := fCfgSis('RECSUB', varBoolean);
  blnTransacao := True;

  Try
    If fCfgSis('FATPRE', varBoolean) Then
      FFatPre := TFatorPreco.Create
    Else
      FFatPre := Nil;

    qryRelPro := fCriaQuery(Self);
    qryOrdPro := fCriaQuery(Self);
    qryOrdPro.BeforePost := pBeforePostqryOrdPro;
    dtsOrdPro := fCriaDataSource(qryOrdPro);

    qryDetPro := fCriaQuery(Self);
    dtsDetPro := fCriaDataSource(qryOrdPro);

    cdsIteEst := TUniClientDataSet.Create(Self);
    dtsIteEst := TDataSource.Create(Self);
    dtsIteEst.DataSet := cdsIteEst;

    FqryEst := fCriaQuery(Self);
    FdspEst := TUniDataSetProvider.Create(Self);
    FdspEst.DataSet := FqryEst;

    objLotInd := TLoteIndividual.Create;

    cdsIteEst.SetProvider(FdspEst);

    lstOPPai := TObjectList<TobjOPPai>.Create;
    lstOPFilha := TObjectList<TobjOPFilha>.Create;

    FCodArm := '';
    FCodFor := '';
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

  blnMONFAS := fCfgSis('MONFAS', varBoolean);
  If blnMONFAS Then
    FobjMonitor := TOrdProMonitoramento.Create(Self);
end;

destructor TOrdPro.Destroy;
begin
  FreeAndNil(qryRelPro);
  FreeAndNil(qryOrdPro);
  FreeAndNil(qryDetPro);
  FreeAndNil(objLotInd);
  FreeAndNil(lstOPPai);
  FreeAndNil(lstOPFilha);
  FreeAndNil(cdsDataSetQtdEditadaOrdPro);

  If Assigned(FFatPre) Then
    FreeAndNil(FFatPre);

  If Assigned(FFulfillment) Then
    FreeAndNil(FFulfillment);

  If Assigned(FObjMonitor) Then
    FreeAndNil(FObjMonitor);

  inherited Destroy;

end;

{**************************************}
{* PEGA DESCRIÇÃO DO CLIENTE          *}
{***********************************AF*}
function TOrdPro.getDesCli: String;
Begin
  Result := fRetNomCliente(FCodCli);
End;

function TOrdPro.getDesIte: String;
Begin
  Result := fRetNomProduto(FCodIte);
End;

{**************************************}
{* FORMATA DTABAI                     *}
{***********************************AF*}
function TOrdPro.getDtaBai: String;
begin
  Result := IfThen(FDtaBai = 0, '', FormatDateTime('dd/mm/yyyy',FDtaBai));
end;

{**************************************}
{* FORMATA DTACAD                     *}
{***********************************AF*}
function TOrdPro.getDtaCad: String;
begin
  Result := IfThen(FDtaCad = 0, '', FormatDateTime('dd/mm/yyyy',FDtaCad));
end;

{**************************************}
{* FORMATA DTAPRO                     *}
{***********************************AF*}
function TOrdPro.getDtaPro: String;
begin
  Result := IfThen(FDtaPro = 0, '', FormatDateTime('dd/mm/yyyy',FDtaPro));
end;

{**************************************}
{* FORMATA QTDAPR                     *}
{***********************************AF*}
function TOrdPro.getQtdApr: String;
begin
  Result := FloatToStrF(FQtdApr, ffFixed, 12, fCfgSis('DECQTD', varInteger));
end;

{**************************************}
{* FORMATA QTDPRO                     *}
{***********************************AF*}
function TOrdPro.getQtdPro: String;
begin
  Result := FloatToStrF(FQtdPro, ffFixed, 12, fCfgSis('DECQTD', varInteger));
end;

procedure TOrdPro.pCriaFieldsCdsDataSetQtdEditadaOrdPro;
Begin
  cdsDataSetQtdEditadaOrdPro := TUniClientDataSet.Create(Self);
  cdsDataSetQtdEditadaOrdPro.FieldDefs.Add('CODITE', ftString, 7);
  cdsDataSetQtdEditadaOrdPro.FieldDefs.Add('QTDITE', ftFloat);
  cdsDataSetQtdEditadaOrdPro.CreateDataSet;
End;

procedure TOrdPro.GravaQuantidadeEditaDoSubItem(strCodIte: String;
  fltQtd: Double);
begin
  If Assigned(cdsDataSetQtdEditadaOrdPro) Then
  Begin
    If cdsDataSetQtdEditadaOrdPro.Locate('CODITE', strCodIte, []) Then
      cdsDataSetQtdEditadaOrdPro.Edit
    Else
      cdsDataSetQtdEditadaOrdPro.Insert;

    cdsDataSetQtdEditadaOrdPro.FieldByName('CODITE').AsString:= strCodIte;
    cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat := fltQtd;

    cdsDataSetQtdEditadaOrdPro.Post;
  End;
end;

{**************************************}
{* SETA A DATA DE BAIXA               *}
{***********************************AF*}
procedure TOrdPro.setCodIte(const Value: String);
begin
  FCodIte := Value;
  objLotInd.strCodIte := FCodIte;
end;

procedure TOrdPro.setDtaBai(const Value: String);
begin
  FDtaBai := StrToDateDef(Value,0);
end;

{**************************************}
{* SETA A DATA DE CADASTRO            *}
{***********************************AF*}
procedure TOrdPro.setDtaCad(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FDtaCad := StrToDate(Value)
  Else
    Raise Exception.Create('A data de cadastro deve ser preenchida!');
end;

{**************************************}
{* SETA A DATA DE PRODUCAO            *}
{***********************************AF*}
procedure TOrdPro.setDtaPro(const Value: String);
begin
  FDtaPro :=  StrToDateDef(Value,0);
end;

{**************************************}
{* SETA A QTD A PRODUZIR              *}
{***********************************AF*}
procedure TOrdPro.setQtdApr(const Value: String);
begin
  FQtdApr := fStrToFloat(Value);
end;

{**************************************}
{* SETA QTD PRODUZIDA                 *}
{***********************************AF*}
procedure TOrdPro.setQtdPro(const Value: String);
begin
  FQtdPro := fStrToFloat(Value);
  objLotInd.fltQtdPro := FQtdPro;
end;

function TOrdPro.fRetPedidoOrdPro(strCodPro: String; Var strNumPed, strMen001, strMen002: String; var dtaPrevis: TDate; var tmrHPrevi: TTime): Boolean;
  Var
    qryFatGor: TUniQuery;
begin
  strNumPed := '';
  strMen001 := '';
  strMen002 := '';
  dtaPrevis := 0;
  Result    := FALSE;

  qryFatGor := fCriaQuery;
  With qryFatGor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('  FGO_NUMDOC,');
    SQL.Add('  FGO_PREVIS,');
    SQL.Add('  FGO_HPREVI,');
    SQL.Add('  FGO_MEN001,');
    SQL.Add('  FGO_MEN002 ');
    SQL.Add('FROM');
    SQL.Add('  FATDOR');
    SQL.Add('INNER JOIN FATGOR G ON G.AUTOINCREM = FDO_SEQGER');
    SQL.Add('WHERE');
    SQL.Add('  FDO_ORDPRO = :ORDPRO AND');
    SQL.Add('  FDO_CODEMP = :CODEMP');

    ParamByName('ORDPRO').AsString := strCodPro;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
    Begin
      strNumPed := FieldByName('FGO_NUMDOC').AsString;
      strMen001 := FieldByName('FGO_MEN001').AsString;
      strMen002 := FieldByName('FGO_MEN002').AsString;
      dtaPrevis := FieldByName('FGO_PREVIS').AsDateTime;
      tmrHPrevi := FieldByName('FGO_HPREVI').AsDateTime;
      Result    := TRUE;
    End;

  End;
  FreeAndNil(qryFatGor);
end;

function TOrdPro.fRetPrecoCustoIte(strCodIte: String): Double;
  Var
    qryIteGer: TUniQuery;
begin
  Result    := 0;
  qryIteGer := fCriaQuery;
  With qryIteGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('  ITE_PRECUS ');
    SQL.Add('FROM');
    SQL.Add('  ITEGER ');
    SQL.Add('WHERE ');
    SQL.Add('  ITE_CODITE = :CODITE AND');
    SQL.Add('  ITE_CODEMP = :CODEMP');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('ITE_PRECUS').AsFloat;

  End;
  FreeAndNil(qryIteGer);
end;

function TOrdPro.fRetPrecoCustoProAca: Double;
  Var
    cpcParams: TParCalculaPrecoCusto;

begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
    With cpcParams Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := fltDesF01;
      curDesF02 := fltDesF02;
      curDesF03 := fltDesF03;
      curDesF04 := fltDesF04;
      curDesF05 := fltDesF05;
      curDesF06 := fltDesF06;
      curICMSEnt:= fltICMEnt;
      curIPIEnt := fltIPIEnt;
      curFrete  := fltFrete;
      curAcrFin := fltAcrFin;
      curSubsti := fltSubsti;
      curValFre := fltValFre;
      curDesAdb := fltDesAdb;
      curSubFed := fltSubFed;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := fltTCIFCu;
        curTSCust := fltTSCust;
        curDePiCo := fltDePiCo;
        curDeICMS := fltDeICMS;
        curFatReg := fltFatReg;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;
    Result := cpcParams.fCalculaPrecoCusto();
  Finally
    FreeAndNil(cpcParams);
  End;
end;

function TOrdPro.fRetPrecoVendaProAca(intOpcao, intTabPre: Integer): Double;
begin
  If Assigned(FFatPre) And (intTabPre <> 1) And (intOpcao = 1) Then
  Begin
    Result := 0;

    case intTabPre of
      1: Result := fltPr1Ant;
      2: Result := fltPr2Ant;
      3: Result := fltPr3Ant;
      4: Result := fltPr4Ant;
      5: Result := fltPr5Ant;
      6: Result := fltPr6Ant;
      7: Result := fltPr7Ant;
    End;

    If FFatPre.fTabelaAtiva(intTabPre) Then
    begin
      If (fCfgSis('TAPORP') = '1') Then
      Begin
        Result := FFatPre.fCalculaPrecoVendaFator(fltPr1Ant, intTabPre);
      End Else
      Begin
        Result := FFatPre.fCalculaPrecoVendaFator(fltPreVe1, intTabPre);
      End;
    End;

    Exit;
  End;

  If (intTabPre = 1) Then
  Begin
    If (fCfgSis('TAPORP') = '1') Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPr1Ant,
                                   fltMa1Ant,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb1)
    Else
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPreVe1,
                                   fltMarVe1,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb1);
  End
  Else If (intTabPre = 2) Then
  Begin
    If (fCfgSis('TAPORP') = '1') Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPr2Ant,
                                   fltMa2Ant,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb2)
    Else
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPreVe2,
                                   fltMarVe2,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb2);
  End
  Else If (intTabPre = 3) Then
  Begin
    If (fCfgSis('TAPORP') = '1') Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPr3Ant,
                                   fltMa3Ant,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb3)
    Else
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPreVe3,
                                   fltMarVe3,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb3);
  End
  Else If (intTabPre = 4) Then
  Begin
    If (fCfgSis('TAPORP') = '1') Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPr4Ant,
                                   fltMa4Ant,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb4)
    Else
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPreVe4,
                                   fltMarVe4,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb4);
  End
  Else If (intTabPre = 5) Then
  Begin
    If (fCfgSis('TAPORP') = '1') Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPr5Ant,
                                   fltMa5Ant,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb5)
    Else
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPreVe5,
                                   fltMarVe5,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb5);
  End
  Else If (intTabPre = 6) Then
  Begin
    If (fCfgSis('TAPORP') = '1') Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPr6Ant,
                                   fltMa6Ant,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb6)
    Else
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPreVe6,
                                   fltMarVe6,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb6);
  End
  Else If (intTabPre = 7) Then
  Begin
    If (fCfgSis('TAPORP') = '1') Then
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPr7Ant,
                                   fltMa7Ant,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb7)
    Else
      Result := fCalculaPrecoVenda(intOpcao,
                                   fltPreCus,
                                   fltPreVe7,
                                   fltMarVe7,
                                   fltICMSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltComTb7);
  End
  Else
    Result := 0;
end;

class function TOrdPro.fSaldoLote(strCodIte, strNumLot, strCodEmp : String): Real;
begin
  Result :=  fStrToFloat(fCampoTabela('LOT_SALDOS','CADLOT', ['LOT_CODITE', 'LOT_NUMLOT', 'LOT_CODEMP'],[strCodIte, strNumLot, strCodEmp]));
end;

function TOrdPro.fExisteNivelInferior(strAutoincrem : String) : Boolean;
  Var
    qryConsulta : TUniQuery;
begin
  Result := False;
  if not fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque then
    Exit;

  Try
    qryConsulta := fCriaQuery(Self);
    With qryConsulta, Sql do
    Begin

      Add('SELECT MOVPRO.AUTOINCREM,                    ');
      Add('       PRO_DTABAI                            ');
      Add('  FROM ORIPRO                                ');
      Add('  LEFT JOIN MOVPRO                           ');
      Add('    ON MOVPRO.AUTOINCREM = ORIPRO.PRO_SEQGER ');
      Add(' WHERE PRO_SEQUSA = :AUTO                    ');

      ParamByName('AUTO').AsString := strAutoincrem;

      Open;

      Result := (RecordCount > 0);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

End;

function TOrdPro.fExisteNivelInferiorSemBaixa(strAutoincrem : String): Boolean;
  Var
    qryConsulta : TUniQuery;
begin
  Result := False;
  if not fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque then
    Exit;

  Try
    qryConsulta := fCriaQuery(Self);
    With qryConsulta, Sql do
    Begin

      Add('SELECT MOVPRO.AUTOINCREM,                    ');
      Add('       PRO_DTABAI                            ');
      Add('  FROM ORIPRO                                ');
      Add('  LEFT JOIN MOVPRO                           ');
      Add('    ON MOVPRO.AUTOINCREM = ORIPRO.PRO_SEQGER ');
      Add(' WHERE PRO_SEQUSA = :AUTO                    ');

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
          if FieldByName('PRO_DTABAI').IsNull then
          Begin
            Result := True;
            Break;
          End
          Else
          Begin
            Result := fExisteNivelInferiorSemBaixa(FieldByName('AUTOINCREM').AsString)
          End;
          Next;
        End;

      End;

    End;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;


function TOrdPro.fExisteNivelSuperiorComBaixa(strAutoincrem: String): Boolean;
  Var
    qryConsulta : TUniQuery;
begin
  Result := False;
  if not fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque then
    Exit;

  Try
    qryConsulta := fCriaQuery(Self);
    With qryConsulta, Sql do
    Begin

      Add('SELECT MOVPRO.AUTOINCREM,                    ');
      Add('       PRO_DTABAI                            ');
      Add('  FROM ORIPRO                                ');
      Add('  LEFT JOIN MOVPRO                           ');
      Add('    ON MOVPRO.AUTOINCREM = ORIPRO.PRO_SEQUSA ');
      Add(' WHERE PRO_SEQGER = :AUTO                    ');
      Add('   AND PRO_DTABAI IS NOT NULL                ');

      ParamByName('AUTO').AsString := strAutoincrem;

      Open;

      Result := (RecordCount > 0);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

End;

{**************************************}
{* IMPRIME ORDEM DE PRODUCAO          *}
{***********************************AF*}
procedure TOrdPro.pImprimeEtiqueta(fltQtdPro : real);
begin
  if fCfgSis('IMPEBO', varBoolean) then
  begin
    If fMensagem('', 'Deseja imprimir a etiqueta dos produtos ?', ['&Sim', '&Não'], 1) = 1 Then
    Begin
      Try
        pCriarFormularios(TfrmImpEtiOP, frmImpEtiOP);
        frmImpEtiOP.strOrdPro := FCodPro;
        frmImpEtiOP.intQtd    := Ceil(fltQtdPro);
        frmImpEtiOP.ShowModal;
      Finally
        FreeAndNil(frmImpEtiOP);
      End;
    End;
  end;
end;

procedure TOrdPro.pImprimeOrdPro(strCodPro          : String;
                                 Var intUltimaLinha : Integer;
                                 blnRefere          : Boolean = False;
                                 strCodEmpP         : String  = '';
                                 blnSelecOrdOP      : Boolean = True;
                                 blnUltfolha        : Boolean = False);
Var
    frmQckOrdProModelo5: TfrmQckOrdProModelo5;
    strCodEmp  : String;
    strNomeFila: String;
    strTipImp  : String;
    strNumPed  : String;
    strMen001  : String;
    strMen002  : String;
    dtaPrevis  : TDate;
    tmrHPrevi  : TTime;
    qryCfgRel  : TUniQuery;
    qryModelo : TUniQuery;
    intModeloLayout : Integer;
    objImpressao    : TEditorFastImpressao;
    qryLayEst       : TUniQuery;
    strLayPadrao    : String;
    stlLista        : TStringList;
    ObjImpLista     : TOrdPro;
    intContador     : integer;
    frmQckOrdProducaoImp : TfrmQckOrdProducaoImp;
    frxReport       : tfrxReport;

  function fGetEnderecoEntrega(strCliente, strIdeEndereco: String): String;
    Var
      objEndEnt: TEnderecoEntrega;
  begin
    objEndEnt := TEnderecoEntrega.Create(Self);

    With objEndEnt, recEndere Do
    Begin
      Result := '';
      If fLeEnderecoEntrega(strCliente, strIdeEndereco, True, True) Then
         Result := 'End. Entrega: ' + strEndEnt + ' - ' +
                                      strBaiEnt + ' - ' +
                                      strNomCid + ' - ' +
                                      strEstEnt +
                                      IIF(fEmptyStr(strRefEnt), '', ' - Referência: ' + strRefEnt);
    End;

    FreeAndNil(objEndEnt);
  end;

  function fRetSQLDetMat(strCampo: String): String;
  begin
    Result := ' SELECT '+ strCampo +' FROM GERMAT '+
              '   INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM '+
              '   WHERE GMT_CODITE = PRO_CODITE '+
              '     AND DMT_ITESUB = DOP_ITESUB LIMIT 1';
    Result := '('+Result+')';
  end;
begin

  frxReport := TfrxReport.Create(Self);

  if fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque And blnSelecOrdOP then
  Begin
    Try
      stlLista    := TfrmExibeArvoreOrdProd.fSelectOpImpressao(strCodPro);
      If Assigned(stlLista) then
      Begin
        ObjImpLista := TOrdPro.Create(Self, Self.blnFaturamento);

        For intContador := 0 to stlLista.Count-1 Do
          ObjImpLista.pImprimeOrdPro(stlLista[intContador], intUltimaLinha, blnRefere, strCodEmpP, False);
      End;

    Finally
      FreeAndNil(stlLista);
      FreeAndNil(ObjImpLista);
    End;

    Exit;
  End;

  qryLayEst := fCriaQuery(nil);
  try
    qryLayEst.SQL.Add('SELECT DISTINCT LAYETI.LAY_CODLAY, LAYETI.LAY_TIPIMP, LAYETI.LAY_CODEMP FROM LAYGMT');
    qryLayEst.SQL.Add('INNER JOIN LAYETI ON     LAYETI.LAY_CODLAY = LAYGMT.LAY_CODLAY');
    qryLayEst.SQL.Add('                     AND LAYETI.LAY_CODEMP = LAYGMT.LAY_CODEMP');
    qryLayEst.SQL.Add('WHERE LAY_CODITE = :CODITE ORDER BY LAY_ORDEM_');
    qryLayEst.ParamByName('CODITE').AsString := fCampoTabela('PRO_CODITE', 'MOVPRO', ['PRO_CODPRO'], [strCodPro]);

    qryLayEst.Open;

    strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI',['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'],[ARR_TIPO_LAYOUT[tpeOrdPro], IIF(fEmptyStr(strCodEmpP), VS_strCodEmp, strCodEmpP), 'S']);

    if (not qryLayEst.isEmpty) or (not fEmptyStr(strLayPadrao))  then
    begin
      objImpressao := TEditorFastImpressao.Create(Nil);
      try
        With objImpressao Do
        Begin
          recDocume.strNumDoc        := strCodPro;
          recDocume.strCodEmp        := IIF(fEmptyStr(strCodEmpP), VS_strCodEmp, strCodEmpP);
          tpeTipoEtiqueta            := tpeOrdPro;

          qryCfgRel := fCriaQuery;
          pCarregaConfImpr(qryCfgRel, 'frmManOrdPro');
          fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False, '');
          FreeAndNil(qryCfgRel);

          if not qryLayEst.isEmpty then
          begin
            while not qryLayEst.Eof do
            begin
              recDocume.strCodLay := qryLayEst.FieldByName('LAY_CODLAY').AsString;
              strTipImp := qryLayEst.FieldByName('LAY_TIPIMP').AsString;

              recDocume.strNomImp   := strNomeFila;
              recDocume.strTipImp   := strTipImp;

              if not qryLayEst.FieldByName('LAY_CODEMP').isNull then
                TEditorFastImpressao.strEmpresaLayout := qryLayEst.FieldByName('LAY_CODEMP').AsString
              else
                TEditorFastImpressao.strEmpresaLayout := VS_strCodEmp;

              fImprimeDocumento;

              qryLayEst.Next;
            end;
          end
          else
          begin
            recDocume.strCodLay := strLayPadrao;
            strTipImp := fCampoTabela('LAY_TIPIMP', 'LAYETI',['LAY_CODLAY', 'LAY_CODEMP'],[strLayPadrao, IIF(fEmptyStr(strCodEmpP), VS_strCodEmp, strCodEmpP)]);

            recDocume.strNomImp   := strNomeFila;
            recDocume.strTipImp   := strTipImp;

            if fEmptyStr(TEditorFastImpressao.strEmpresaLayout) then
            begin
              TEditorFastImpressao.strEmpresaLayout := VS_strCodEmp;
            end;

            fImprimeDocumento;

            qryLayEst.Next;
          end;
        End;
      finally
        TEditorFastImpressao.strEmpresaLayout := '';
        FreeAndNil(objImpressao);
      end;
    end
    else
    begin
      Try
        If Not fEmptyStr(strCodEmpP) Then
          strCodEmp := strCodEmpP
        Else
          strCodEmp := VS_strCodEmp;

        intModeloLayout := StrToInt(fCfgSis('MLAYOP'));

        With qryRelPro Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('  PRO_CODCLI AS CODCLI, ');
          SQL.Add('  PRO_ENDENT AS ENDENT, ');
          SQL.Add('  PRO_CODPRO AS CODPRO, ');
          SQL.Add('  PRO_CODITE AS CODBAS, ');
          SQL.Add('  FDO_DESCRI AS DESBAS, ');
          SQL.Add('  CAST(C.ITE_APLICA AS CHAR(200)) AS APLICA, ');
          SQL.Add(fRetSQLDetMat('DMT_DESCRI')+' AS COMENT, ');
          SQL.Add('  PRO_QTDAPR AS QTDBAS, ');
          SQL.Add('  DOP_ITESUB AS CODITE, ');
          SQL.Add('  DOP_METRAG AS METRAG, ');
          SQL.Add('  C.ITE_REFERE AS REFITE, ');
          SQL.Add('  C.ITE_DESITE AS DESITE, ');
          SQL.Add('  IFNULL('+fRetSQLDetMat('DMT_REFERE')+', C.ITE_REFERE) AS REFERE, ');
          SQL.Add('  DOP_NUMFAS AS NUMFAS, ');
          SQL.Add('  IF((SELECT GMT_TIPQTD FROM GERMAT WHERE GMT_CODITE = PRO_CODITE AND GMT_CODEMP = PRO_CODEMP) = "P", 0.01, 1) AS FATPOR,');

          Case intModeloLayout of
              1: Begin
                   SQL.Add('  GMT_OBS001, ');
                   SQL.Add('  GMT_OBS002, ');
                   SQL.Add('  GMT_OBS003, ');
                   SQL.Add('  GMT_OBS004, ');
                   SQL.Add('  GMT_OBS005, ');
                   SQL.Add('  GMT_OBS006, ');
                   SQL.Add('  GMT_OBS007, ');
                 End;
              3: Begin
                   SQL.Add(' IFNULL(LOT_LOCFIS, I.ITE_LOCFIS) AS LOCFIS, ');
                   SQL.Add(' IFNULL(DOP_NUMLOT,LOT_NUMLOT) AS NUMLOT, ');
                 End;
            5,6: Begin
                   SQL.Add('  IF(IFNULL(C.ITE_DENSID, 1) <= 0, 1, IFNULL(C.ITE_DENSID, 1)) AS DENSID, ');
                   SQL.Add('  DOP_QTDITE AS QTDFOR, ');
                   SQL.Add('  C2.ITE_DESITE, ');
                   SQL.Add('  GRU_DESGRU,    ');
                 End;
              7: Begin
                   SQL.Add('  C2.ITE_DESITE AS DESITECAB, ');
                   SQL.Add('  I.ITE_LOCFIS AS LOCFIS, ');
                 End;
               Else
                 Begin
                   SQL.Add('  I.ITE_LOCFIS AS LOCFIS, ');
                   SQL.Add(' ""            AS NUMLOT, ');
                 End;
          end;

          SQL.Add('  U.UNI_SIGUNI AS SIGUNI, ');
          SQL.Add('  IFNULL('+fRetSQLDetMat('DMT_ACUMOP')+', "N") AS ACUMOP,  ');
          SQL.Add('  PRO_OBS001 AS OBS001, ');
          SQL.Add('  PRO_OBS002 AS OBS002, ');
          SQL.Add('  (DOP_QTDITE * PRO_QTDAPR) AS QTDITE, ');
          SQL.Add('  F1.FGO_CODVEN AS CODVEN, ');
          SQL.Add('  V.OPE_NOMOPE AS NOMVEN ');
          SQL.Add('FROM ');
          SQL.Add('  MOVPRO ');
          SQL.Add('  INNER JOIN DETPRO   ON DOP_SEQGER   = MOVPRO.AUTOINCREM ');
          SQL.Add('   LEFT JOIN ITEGER I ON I.ITE_CODITE = DOP_ITESUB AND I.ITE_CODEMP = :CODEMP ');
          SQL.Add('   LEFT JOIN CADITE C ON C.ITE_CODITE = DOP_ITESUB ');
          SQL.Add('   LEFT JOIN CADUNI U ON U.UNI_CODUNI = C.ITE_CODUNI ');
          //traz a observação da estrutura
          Case intModeloLayout of
              1: Begin
                   SQL.Add(' LEFT JOIN GERMAT G ON G.GMT_CODITE = PRO_CODITE');
                 End;
              3: Begin
                   SQL.Add(' LEFT JOIN CADLOT ON LOT_CODITE = I.ITE_CODITE AND LOT_CODEMP = I.ITE_CODEMP AND LOT_PRIPRO = "S"  ');
                 End;
            5,6: Begin
                   SQL.Add('   LEFT JOIN CADITE C2 ON C2.ITE_CODITE = PRO_CODITE ');
                   SQL.Add('   INNER JOIN CADGRU ON GRU_CODGRU = C2.ITE_CODGRU   ');
                 End;
              7: Begin
                   SQL.Add(' LEFT JOIN CADITE C2 ON C2.ITE_CODITE = PRO_CODITE ');
                 End;
          End;

          SQL.Add('  LEFT JOIN FATDOR ON FDO_ORDPRO = PRO_CODPRO AND FDO_CODEMP = :CODEMP ');
          SQL.Add('  LEFT JOIN FATGOR F1 ON F1.AUTOINCREM = FDO_SEQGER  ');
          SQL.Add('  LEFT JOIN CADOPE V ON V.OPE_CODOPE = F1.FGO_CODVEN       ');
          SQL.Add('WHERE ');
          SQL.Add('  PRO_CODPRO = :CODPRO AND ');
          SQL.Add('  PRO_CODEMP = :CODEMP ');
          SQL.Add('ORDER BY ');
          SQL.Add('  NUMFAS ');

          ParamByName('CODPRO').AsString := strCodPro;
          ParamByName('CODEMP').AsString := strCodEmp;
          Open;

          Case intModeloLayout of
            1,3: Begin
                   qryCfgRel := fCriaQuery;
                   pCarregaConfImpr(qryCfgRel, 'frmManOrdPro');
                   fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
                   FreeAndNil(qryCfgRel);

                   pCriarFormularios(TfrmQckOrdProducaoImp, frmQckOrdProducaoImp);

                   frxReport := frmQckOrdProducaoImp.frxImpressaoJ;

                   if strTipImp = 'M' then
                     frxReport := frmQckOrdProducaoImp.frxImpressaoM;

                   { ******************************** }
                   Try
                     frxReport.Script.Variables['REFERE'] := blnRefere;

                     If fRetPedidoOrdPro(strCodPro, strNumPed, strMen001, strMen002, dtaPrevis, tmrHPrevi) Then
                     Begin
                       If (fCfgSis('PROPRO', varBoolean)) Then
                         frxReport.Script.Variables['PEDIDO'] := 'PEDIDO Nº ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis) + ' ' + TimeToStr(tmrHPrevi)
                       Else
                         frxReport.Script.Variables['PEDIDO'] := 'PEDIDO Nº ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis);
                     End
                     Else
                       frxReport.Script.Variables['PEDIDO'] := '';

                     If Not fEmptyStr(FieldByName('OBS001').AsString) Then
                       TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('OBS001').AsString);
                     If Not fEmptyStr(FieldByName('OBS002').AsString) Then
                       TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('OBS002').AsString);
                     If Not fEmptyStr(strMen001) Then
                       TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(strMen001);
                     If Not fEmptyStr(strMen002) Then
                       TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(strMen002);


                     frxReport.Script.Variables['MODELO'] := '3';

                     If intModeloLayout = 1 Then
                     Begin
                       If Not fEmptyStr(FieldByName('GMT_OBS001').AsString) Then
                         TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('GMT_OBS001').AsString);
                       If Not fEmptyStr(FieldByName('GMT_OBS002').AsString) Then
                         TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('GMT_OBS002').AsString);
                       If Not fEmptyStr(FieldByName('GMT_OBS003').AsString) Then
                         TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('GMT_OBS003').AsString);
                       If Not fEmptyStr(FieldByName('GMT_OBS004').AsString) Then
                         TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('GMT_OBS004').AsString);
                       If Not fEmptyStr(FieldByName('GMT_OBS005').AsString) Then
                         TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('GMT_OBS005').AsString);
                       If Not fEmptyStr(FieldByName('GMT_OBS006').AsString) Then
                         TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('GMT_OBS006').AsString);
                       If Not fEmptyStr(FieldByName('GMT_OBS007').AsString) Then
                         TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(FieldByName('GMT_OBS007').AsString);

                       frxReport.Script.Variables['MODELO'] := '1';

                     End;

                     TfrxMemoView(frxReport.FindObject('mmo1Obs')).Lines.Add(fGetEnderecoEntrega(FieldByName('CODCLI').AsString,
                                                                              FieldByName('ENDENT').AsString));

                     {*******************************************************}
                     {* VERIFICA SE MOSTRA A COLUNA DA QUANTIDADE ACUMULADA *}
                     {****************************************************PZ*}

                     frxReport.Script.Variables['QDPRES'] := fCfgSis('QDPRES', varString);

                     frmQckOrdProducaoImp.frxRelatorio.DataSet := qryRelPro;

                     frxReport.AddFunction('function fRetNomProduto(strProduto: String): String;');
                     frxReport.AddFunction('function fFloatToStrF(Value: Extended): String;');
                     frxReport.AddFunction('function fRetReferenciaProd(strProduto: String): String;');

                     frxReport.DotMatrixReport := (strTipImp = 'M');

                     frxReport.PrepareReport;
                     pPrintReport('frmManOrdPro', 'Impressão Ordem de Produção', strNomeFila, frxReport);
                     //pPreviewReport('frmManOrdPro', 'Impressão Ordem de Produção', frxReport);

                   Finally
                     FreeAndNil(frmQckOrdProModelo5);
                   End;

                 End;

              2: Begin
                   pImprimeOrdProMod2e7(qryRelPro, intUltimaLinha, blnRefere, blnUltfolha);
                 End;

              4: Begin
                   qryCfgRel := fCriaQuery;
                   pCarregaConfImpr(qryCfgRel, 'frmManOrdPro');
                   fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
                   FreeAndNil(qryCfgRel);

                   pCriarFormularios(TfrmQckOrdProducaoImp, frmQckOrdProducaoImp);

                   frxReport := frmQckOrdProducaoImp.frxImpressaoJ;

                   if strTipImp = 'M' then
                     frxReport := frmQckOrdProducaoImp.frxImpressaoM;

                   frxReport.Script.Variables['MODELO'] := '4';

                   Try
                     frxReport.Script.Variables['REFERE'] := blnRefere;

                     If fRetPedidoOrdPro(strCodPro, strNumPed, strMen001, strMen002, dtaPrevis, tmrHPrevi) Then
                     Begin
                       If (fCfgSis('PROPRO', varBoolean)) Then
                         frxReport.Script.Variables['PEDIDO'] := 'PEDIDO Nº ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis) + ' ' + TimeToStr(tmrHPrevi)
                       Else
                         frxReport.Script.Variables['PEDIDO'] := 'PEDIDO Nº ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis);
                     End
                     Else
                       frxReport.Script.Variables['PEDIDO'] := '';

                     If Not fEmptyStr(FieldByName('OBS001').AsString) Then
                       TfrxMemoView(frxReport.FindObject('mmo3Obs')).Lines.Add(FieldByName('OBS001').AsString);
                     If Not fEmptyStr(FieldByName('OBS002').AsString) Then
                       TfrxMemoView(frxReport.FindObject('mmo3Obs')).Lines.Add(FieldByName('OBS002').AsString);
                     If Not fEmptyStr(strMen001) Then
                       TfrxMemoView(frxReport.FindObject('mmo3Obs')).Lines.Add(strMen001);
                     If Not fEmptyStr(strMen002) Then
                       TfrxMemoView(frxReport.FindObject('mmo3Obs')).Lines.Add(strMen002);

                     TfrxMemoView(frxReport.FindObject('mmo3Obs')).Lines.Add(fGetEnderecoEntrega(FieldByName('CODCLI').AsString,
                                                                                 FieldByName('ENDENT').AsString));

                     frxReport.Script.Variables['QDPRES'] := fCfgSis('QDPRES', varString);

                     frmQckOrdProducaoImp.frxRelatorio.DataSet := qryRelPro;

                     frxReport.AddFunction('function fRetNomProduto(strProduto: String): String;');
                     frxReport.AddFunction('function fFloatToStrF(Value: Extended): String;');
                     frxReport.AddFunction('function fRetReferenciaProd(strProduto: String): String;');

                     frxReport.DotMatrixReport := (strTipImp = 'M');

                     frxReport.PrepareReport;
                     pPrintReport('frmManOrdPro', 'Impressão Ordem de Produção', strNomeFila, frxReport);
                     //pPreviewReport('frmManOrdPro', 'Impressão Ordem de Produção', frxReport);
                   Finally
                     FreeAndNil(frmQckOrdProducaoImp);
                   End;
                 End;

              8: Begin
                   qryCfgRel := fCriaQuery;
                   pCarregaConfImpr(qryCfgRel, 'frmManOrdPro');
                   fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
                   FreeAndNil(qryCfgRel);

                   pCriarFormularios(TfrmQckOrdProducaoImp, frmQckOrdProducaoImp);

                   frxReport := frmQckOrdProducaoImp.frxImpressaoJ;

                   if strTipImp = 'M' then
                     frxReport := frmQckOrdProducaoImp.frxImpressaoM;

                   frxReport.Script.Variables['MODELO'] := '8';

                   Try
                     frxReport.Script.Variables['REFERE'] := blnRefere;

                     If fRetPedidoOrdPro(strCodPro, strNumPed, strMen001, strMen002, dtaPrevis, tmrHPrevi) Then
                     Begin
                       If (fCfgSis('PROPRO', varBoolean)) Then
                         frxReport.Script.Variables['PEDIDO'] := 'PEDIDO Nº ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis) + ' ' + TimeToStr(tmrHPrevi)
                       Else
                         frxReport.Script.Variables['PEDIDO'] := 'PEDIDO Nº ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis);
                     End
                     Else
                       frxReport.Script.Variables['PEDIDO'] := '';

                     If Not fEmptyStr(FieldByName('OBS001').AsString) Then
                       TfrxMemoView(frxReport.FindObject('mmo4Obs')).Lines.Add(FieldByName('OBS001').AsString);
                     If Not fEmptyStr(FieldByName('OBS002').AsString) Then
                       TfrxMemoView(frxReport.FindObject('mmo4Obs')).Lines.Add(FieldByName('OBS002').AsString);
                     If Not fEmptyStr(strMen001) Then
                       TfrxMemoView(frxReport.FindObject('mmo4Obs')).Lines.Add(strMen001);
                     If Not fEmptyStr(strMen002) Then
                       TfrxMemoView(frxReport.FindObject('mmo4Obs')).Lines.Add(strMen002);

                     TfrxMemoView(frxReport.FindObject('mmo4Obs')).Lines.Add(fGetEnderecoEntrega(FieldByName('CODCLI').AsString,
                                                                                 FieldByName('ENDENT').AsString));

                     frxReport.Script.Variables['QDPRES'] := fCfgSis('QDPRES', varString);

                     frmQckOrdProducaoImp.frxRelatorio.DataSet := qryRelPro;

                     frxReport.AddFunction('function fRetNomProduto(strProduto: String): String;');
                     frxReport.AddFunction('function fFloatToStrF(Value: Extended): String;');
                     frxReport.AddFunction('function fRetReferenciaProd(strProduto: String): String;');

                     frxReport.DotMatrixReport := (strTipImp = 'M');

                     frxReport.PrepareReport;
                     pPrintReport('frmManOrdPro', 'Impressão Ordem de Produção', strNomeFila, frxReport);
                     //pPreviewReport('frmManOrdPro', 'Impressão Ordem de Produção', frxReport);
                   Finally
                     FreeAndNil(frmQckOrdProducaoImp);
                   End;
                 End;


          5,6,7: Begin

                   Try
                     qryCfgRel := fCriaQuery;
                     qryModelo := fCriaQuery;
                     With qryModelo, SQL Do
                     Begin
                       Close;
                       Clear;
                       Add(' SELECT DMT_DESCRI                                     ');
                       Add(' FROM DETMAT                                           ');
                       Add('   INNER JOIN GERMAT ON DMT_SEQGER = GERMAT.AUTOINCREM ');
                       Add('   INNER JOIN MOVPRO ON PRO_CODITE = GMT_CODITE        ');
                       Add(' WHERE PRO_CODPRO = :CODPRO                            ');
                       Add('   AND PRO_CODEMP = :CODEMP                            ');
                       Add('   AND DMT_ITESUB IS NULL                              ');
                       Add(' ORDER BY DMT_SEQUEN                                   ');
                       ParamByName('CODPRO').AsString := strCodPro;
                       ParamByName('CODEMP').AsString := VS_strCodEmp;
                       Open;
                     End;

                     pCarregaConfImpr(qryCfgRel, 'frmManOrdPro');
                     fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

                     If (strTipImp = 'M') And (intModeloLayout = 7) Then
                     Begin
                       pImprimeOrdProMod2e7(qryRelPro, intUltimaLinha, blnRefere, blnUltfolha);
                     End
                     Else
                     Begin

                       pCriarFormularios(TfrmQckOrdProModelo5, frmQckOrdProModelo5);

                       frmQckOrdProModelo5.frxDBDataset.DataSet := qryRelPro;
                       frmQckOrdProModelo5.frxDBComents.DataSet := qryModelo;

                       Case intModeloLayout Of
                         5: frxReport := frmQckOrdProModelo5.frxReport;
                         6: frxReport := frmQckOrdProModelo5.frxReportMOD6;
                         7: frxReport := frmQckOrdProModelo5.frxReportMOD7;
                       End;
                       frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

                       If (intModeloLayout = 7) Then
                       Begin
                         If fRetPedidoOrdPro(strCodPro, strNumPed, strMen001, strMen002, dtaPrevis, tmrHPrevi) Then
                         Begin
                           TfrxMemoView(frmQckOrdProModelo5.frxReportMOD7.FindObject('rllPedido')).Visible := True;
                           TfrxMemoView(frmQckOrdProModelo5.frxReportMOD7.FindObject('rllPedido')).Text :='PEDIDO Nº ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis) + ' ' + TimeToStr(tmrHPrevi);
                         End
                         Else
                           TfrxMemoView(frmQckOrdProModelo5.frxReportMOD7.FindObject('rllPedido')).Visible := False;
                       End;

                       If (Not fEmptyStr(strNomeFila)) Then
                       Begin
                         frxReport.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');
                         frxReport.PrintOptions.ShowDialog := False;
                         If (frxReport.PrepareReport) Then
                           pPrintReport('frmManOrdPro', 'Impressão Ordem de Produção', strNomeFila, frxReport);
                       End
                       Else
                       Begin
                         frxReport.PrintOptions.ShowDialog := True;
                         pPreviewReport('frmManOrdPro', 'Impressão Ordem de Produção', frxReport);
                       End;

                     End;

                   Finally
                     FreeAndNil(frmQckOrdProModelo5);
                     FreeAndNil(qryModelo);
                     FreeAndNil(qryCfgRel);
                   End;
                 End;
          End;

          Close;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pImprimeOrdPro]');
        End;
      End;
    end;
  finally
    qryLayEst.Close;
    FreeAndNil(qryLayEst);
  end;
End;

procedure TOrdPro.Imp(strTexto: String; blnPula: Boolean; blnRetCaractEsp: Boolean);
  Var
    escritos: Cardinal;
begin

  {**********************************}
  {* RETIRA OS CARACTERES ESPECIAIS *}
  {*******************************JB*}
  If (blnRetCaractEsp) Then
    strTexto := fTiraCaracEspeciais(strTexto, False);

  If Not Assigned(impNaoFiscal) Then
  Begin
    WritePrinter(PrinterHandler, PAnsiChar(AnsiString(strTexto)), Length(strTexto), escritos);

    If (blnPula) Then
    Begin
      strTexto := #13#10;
      WritePrinter(PrinterHandler, PAnsiChar(AnsiString(strTexto)), 2, escritos);
    End;
  End
  Else
  Begin
    If (Not fEmptyStr(strTexto)) Or (blnPula) Then
      impNaoFiscal.pEscreveNormal(strTexto);
  End;
end;

procedure TOrdPro.pImprimeOrdProMod2e7(qryOrd         : TUniQuery;
                                       Var
                                       intUltimaLinha : Integer;
                                       blnRefere      : Boolean = False;
                                       blnUltfolha    : Boolean = False);
  Var
    strMarca,
    strNomeFila,
    strControle,
    strTipImp,
    strDesIte: String;

    DocInfo: TDocInfo1;

    qryCfgRel: TUniQuery;

    intIteImp,
    intTotIteImp,
    intPagina,
    intQtdPag: Integer;

    fltTotQtd: Double;

  Const
    intQtdFol = 23;
    intLinPag = 85;

  procedure Reseta;
  begin
    If Assigned(impNaoFiscal) Then
      Exit;

    Imp(#27 + '@', False);
    Imp(#18 + #27 + #80, False);
  end;

  procedure Eject;
  begin
    If Assigned(impNaoFiscal) Then
    Begin
      Exit;
    End;

    Imp(#12);
    Reseta;
  end;

  function Cond_10CPI(blnLiga: Boolean): String;
  begin
    Result := '';
    If Assigned(impNaoFiscal) Then
      Exit;

    If blnLiga Then
       Result := #15
    Else
       Result := #18;
  end;

  function Cpi_12(blnLiga: Boolean): String;
  begin
    Result := '';
    If Assigned(impNaoFiscal) Then
      Exit;

    If blnLiga Then
       Result := #27 + #77
    Else
       Result := #27 + #80;
  end;

  function Expandido(blnLiga: Boolean): String;
  begin
    If Assigned(impNaoFiscal) Then
    Begin
      Result := '';
      Exit;
    End;

    If blnLiga Then
       Result := #27 + #87 + '1'
    Else
       Result := #27 + #87 + '0';
  end;

  function Um_Oitavo(blnLiga: Boolean): String;
  begin
    Result := '';
    If Assigned(impNaoFiscal) Then
      Exit;

    If blnLiga Then
       Result := #27 + '0'
    Else
       Result := #27 + '2';
  end;

  function TamPag(intMaxLin: Integer): String;
  begin
    Result := '';
    If Assigned(impNaoFiscal) Then
      Exit;

    Result := #27 + 'C' + Chr(intMaxLin);
  end;

  procedure pImprimeSEPRodGenerico(blnTotal: Boolean;blnUltfolha: Boolean = False);
  begin
    Imp('');
    Inc(intUltimaLinha);
    If Not fEmptyStr(qryOrd.FieldByName('OBS001').AsString) Then
    Begin
      Imp(StringOfChar('-', 137));
      Imp('OBSERVACAO: ' + qryOrd.FieldByName('OBS001').AsString);
      Imp('            ' + qryOrd.FieldByName('OBS002').AsString);
      Inc(intUltimaLinha, 3);
    End;

    Imp(StringOfChar('-', 137));
    Imp(fPadR(DateToStr(VS_Date), 100) + fPadL(FormatDateTime('hh:nn:ss', fTime()), 37));
    Inc(intUltimaLinha, 2);

    If (fCfgSis('MLAYOP', varString) = '7') And (Not blnUltfolha) Then
    Begin
      Imp(StringOfChar('=', 137));
      Inc(intUltimaLinha);
    End
    Else
      Eject;
  end;

  function fLinhasCab: Integer;
    Var strNumPed, strMen001, strMen002: String;
        dtaPrevis: TDate;
        tmrHPrevi: TTime;
  begin
    Result := 7;

    If fRetPedidoOrdPro(qryOrd.FieldByName('CODPRO').AsString, strNumPed, strMen001, strMen002, dtaPrevis, tmrHPrevi) Then
      Inc(Result, 1);
  end;

  function fLinhasRodape: Integer;
  begin
    Result := 3;

    If Not fEmptyStr(qryOrd.FieldByName('OBS001').AsString) Then
      Inc(Result, 3);

    If fCfgSis('MLAYOP', varString) = '7' Then
      Inc(Result, 1);
  end;

  procedure pImprimeSEPCabGenerico(blnSemRodape: Boolean);
    Var
      strNumPed, strItemEstrutura, strMen001, strMen002: String;
      dtaPrevis: TDate;
      tmrHPrevi: TTime;
  begin
    Inc(intPagina);

    strControle := IntToStr(intPagina) + '/' + IntToStr(intQtdPag);

    If (intPagina > 1) And (Not blnSemRodape) Then
      pImprimeSEPRodGenerico(False);

    Reseta;
    If fCfgSis('MLAYOP', varString) = '7' Then
      Imp(Cond_10CPI(True),False)
    Else
    Begin
      Imp(Cond_10CPI(False), False);
      Imp(CPI_12(False), False);
    End;

    Imp(Um_Oitavo(True), False);
    If fCfgSis('MLAYOP', varString) <> '7' Then
      Imp(TamPag(intLinPag), False);

    Imp(Expandido(True), False);
    Imp(fPadR('ORDEM DE PRODUCAO N. '+ qryOrd.FieldByName('CODPRO').AsString, 33) + fPadL(strControle, 8));
    Imp(Expandido(False), False);
    Inc(intUltimaLinha);

    If fRetPedidoOrdPro(qryOrd.FieldByName('CODPRO').AsString, strNumPed, strMen001, strMen002, dtaPrevis, tmrHPrevi) Then
    Begin
      If (fCfgSis('PROPRO', varBoolean)) Then
        Imp('PEDIDO N. ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis) + ' ' + TimeToStr(tmrHPrevi))
      Else
        Imp('PEDIDO N. ' + strNumPed + '     PREVISAO ' + DateToStr(dtaPrevis));

      Inc(intUltimaLinha);
    End;

    If fCfgSis('MLAYOP', varString) = '7' Then
      Imp('')
    Else
      Imp(Cond_10CPI(True));

    Inc(intUltimaLinha);

    // Exibe estrutura
    strItemEstrutura := fRetNomProduto(qryOrd.FieldByName('CODBAS').AsString);
    If (Pos('ITEM ESPECIAL', strItemEstrutura) > 0) And (Not qryOrd.FieldByName('DESBAS').IsNull) Then
      strItemEstrutura := qryOrd.FieldByName('DESBAS').AsString;

    Imp(fPadR(qryOrd.FieldByName('CODBAS').AsString + '-' + strItemEstrutura, 117) +
        fPadL('QUANT.: ' + FloatToStrF(qryOrd.FieldByName('QTDBAS').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 20));

    Imp('');
    Imp(StringOfChar('-', 137));
    Imp('SEP CODIGO  DESCRICAO                                                                                                QUANTIDADE UN   CONF');
    Imp(StringOfChar('-', 137));

    Inc(intUltimaLinha, 5);
  end;

  function fLinhasRestantes: Integer;
  begin
    Result := intLinPag - intUltimaLinha;
  end;
begin
  intPagina := 0;

  intQtdPag := qryOrd.RecordCount div intQtdFol;
  If qryOrd.RecordCount mod intQtdFol > 0 Then
    Inc(intQtdPag);

  If fLinhasCab + fLinhasRodape + qryOrd.RecordCount * 3 > fLinhasRestantes Then
    Inc(intQtdPag);

  strMarca := fArqIniLocal(0, 'GERAL', 'MARCA', '', 'opcoes_nao_fiscal.ini');
  If (fArqIniLocal(0, 'GERAL', 'USAIMP', '', 'opcoes_nao_fiscal.ini') = 'S') Then
    impNaoFiscal := TImpNaoFiscal.fCriaImpressora(strMarca);

  If Not Assigned(impNaoFiscal) Then
  Begin

    qryCfgRel := fCriaQuery;

    Try
      pCarregaConfImpr(qryCfgRel, 'frmManOrdPro');
      If Not fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False, 'I') Then
      Begin
        FreeAndNil(qryCfgRel);
        Exit;
      End;

      If (strTipImp = 'J') And (fCfgSis('MLAYOP', varString) = '2') Then
      Begin
        fMensagem('Aviso', 'Impressão do modelo 2 está disponíveis somente para o modo '+#13+
                           '"Matricial", configure a fila "frmManOrdPro" corretamente !', ['&Ok']);
        FreeAndNil(qryCfgRel);
        Exit;
      End;

      OpenPrinter(PChar(strNomeFila), PrinterHandler, Nil);
    Finally
      FreeAndNil(qryCfgRel);
    End;
  End;

  with DocInfo do
  begin
    pDatatype := 'RAW';
    pDocName := PChar('Impressão de Faturamento');
    pOutputFile := nil;
  end;
  StartDocPrinter(PrinterHandler, 1, @DocInfo);
  StartPagePrinter(PrinterHandler);

  Try
    intIteImp := 0;
    intTotIteImp := 0;
    fltTotQtd := 0;

    If fCfgSis('MLAYOP', varString) = '7' Then
    Begin
      If fLinhasRestantes < fLinhasCab + fLinhasRodape + 3 Then
      Begin
        While intUltimaLinha < intLinPag Do
        Begin
          Imp('');
          Inc(intUltimaLinha);
        End;

        // Para igualar linhas.
        Imp('');
        Imp('');
        Imp('');
        intUltimaLinha := 0;
      End;
    End;

    With qryOrd Do
    Begin
      While (Not Eof) Do
      Begin

        If fCfgSis('MLAYOP', varString) = '7' Then
        Begin
          // Se a quantidade de linhas restantes for menor que o tamanho de um rodapé + 1 item, imprime rodapé
          If fLinhasRestantes < fLinhasRodape + 3 Then
          Begin
            pImprimeSEPRodGenerico(False);
            While intUltimaLinha < intLinPag Do
            Begin
              Imp('');
              Inc(intUltimaLinha);
            End;

            // Para igualar linhas.
            Imp('');
            Imp('');
            Imp('');
            intUltimaLinha := 0;
          End;

          If (intIteImp = 0) Or (intUltimaLinha = 0) Then
            pImprimeSepCabGenerico(True);

        End
        Else
        Begin
          If (intIteImp = 0) Or (intIteImp >= intQtdFol) Then
          Begin
            pImprimeSEPCabGenerico(False);

            intIteImp := 0;
            If (intTotIteImp >= qryOrd.RecordCount) Then
              Break;
          End;
        End;

        If Not fEmptyStr(FieldByName('COMENT').AsString) Then
          strDesIte := FieldByName('COMENT').AsString

        Else If blnRefere Then
          strDesIte := FieldByName('REFERE').AsString

        Else
          strDesIte := FieldByName('DESITE').AsString;

        Imp('');
        Imp('___ ' +  //Separação
            fPadR(FieldByName('CODITE').AsString, 07) + ' ' + // Código
            fPadR(strDesIte, 101) + ' ' + // Descrição
            fPadL(FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 13) + ' ' + // Qtde;
            fPadR(FieldByName('SIGUNI').AsString, 04) + ' ' +
            '____');

        Imp(fPadR('            LOC.FISICA: ' + FieldByName('LOCFIS').AsString, 137));

        fltTotQtd := fltTotQtd + FieldByName('QTDITE').AsFloat;

        Inc(intIteImp, 1);
        Inc(intTotIteImp, 1);

        Inc(intUltimaLinha, 3);

        Next;
      End;

      If fCfgSis('MLAYOP', varString) <> '7' Then
      Begin
        While intIteImp < intQtdFol Do
        Begin
          Imp('');
          Imp('');
          Imp('');
          Inc(intIteImp);
        End;
      End;

      pImprimeSEPRodGenerico(True, blnUltfolha);

    End;
  Finally
    ClosePrinter(PrinterHandler);
  End;
end;

function TOrdPro.fAtuPrecosProAca(strCodIte: String; fltQtdPro: Double; strAutInc: String = ''; blnBaixaTotal: Boolean = False): Boolean;
  Var
    strSQL: String;
    intCont: Integer;
    qryUpd: TUniQuery;
    blnPermiteReducaoDePreco: Boolean;
begin
  Result := True;
  Try
    pRetPrecosProAca(strCodIte);
    fltPreCus := fRetPrecoCustoProAca;
    If (fCfgSis('TAPORP') = '1') Then
    Begin
      fltMarVe1 := fRetPrecoVendaProAca(2, 1);
      fltMarVe2 := fRetPrecoVendaProAca(2, 2);
      fltMarVe3 := fRetPrecoVendaProAca(2, 3);
      fltMarVe4 := fRetPrecoVendaProAca(2, 4);
      fltMarVe5 := fRetPrecoVendaProAca(2, 5);
      fltMarVe6 := fRetPrecoVendaProAca(2, 6);
      fltMarVe7 := fRetPrecoVendaProAca(2, 7);
      fltPreVe1 := fltPr1Ant;
      fltPreVe2 := fltPr2Ant;
      fltPreVe3 := fltPr3Ant;
      fltPreVe4 := fltPr4Ant;
      fltPreVe5 := fltPr5Ant;
      fltPreVe6 := fltPr6Ant;
      fltPreVe7 := fltPr7Ant;
    End
    Else
    Begin
      fltMarVe1 := fltMa1Ant;
      fltMarVe2 := fltMa2Ant;
      fltMarVe3 := fltMa3Ant;
      fltMarVe4 := fltMa4Ant;
      fltMarVe5 := fltMa5Ant;
      fltMarVe6 := fltMa6Ant;
      fltMarVe7 := fltMa7Ant;
      fltPreVe1 := fRetPrecoVendaProAca(1, 1);
      fltPreVe2 := fRetPrecoVendaProAca(1, 2);
      fltPreVe3 := fRetPrecoVendaProAca(1, 3);
      fltPreVe4 := fRetPrecoVendaProAca(1, 4);
      fltPreVe5 := fRetPrecoVendaProAca(1, 5);
      fltPreVe6 := fRetPrecoVendaProAca(1, 6);
      fltPreVe7 := fRetPrecoVendaProAca(1, 7);
    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ITE_PRECOM = :PRECOM, ';
    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + '  ITE_MARBR' + IntToStr(intCont) + ' = :MARBR' + IntToStr(intCont) + ', ';
      strSQL := strSQL + '  ITE_PREVE' + IntToStr(intCont) + ' = :PREVE' + IntToStr(intCont) + ', ';
    End;


    strSQL := strSQL + '  ITE_PRECUS = :PRECUS,  ';


    strSQL := strSQL + '  ITE_FORULT = :FORULT,  ';
    strSQL := strSQL + '  ITE_DTAULT = :DTAULT,  ';
    strSQL := strSQL + '  ITE_QTDUCO = :QTDUCO,  ';
    strSQL := strSQL + '  ITE_QTDUCO = :QTDUCO,  ';
    strSQL := strSQL + '  ITE_PREULT = :PREULT,  ';
    strSQL := strSQL + '  ITE_PREALT = :PREALT   ';

    If (fCfgSis('ATPCPM') = 'S') Then
    Begin

      If blnBaixaTotal Then
        strSQL := strSQL + ',  ITE_PREMED = :PREMED  '; // DEVE SER ATUALIZADO APENAS APOS A BAIXA TOTAL

      strSQL := strSQL + ',  ITE_IMPULT = :IMPULT  ';

    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP     ';

    qryUpd := fCriaQuery;
    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('MARBR1').AsFloat  := fltMarVe1;
      ParamByName('PREVE1').AsFloat  := fltPreVe1;
      ParamByName('MARBR2').AsFloat  := fltMarVe2;
      ParamByName('PREVE2').AsFloat  := fltPreVe2;
      ParamByName('MARBR3').AsFloat  := fltMarVe3;
      ParamByName('PREVE3').AsFloat  := fltPreVe3;
      ParamByName('MARBR4').AsFloat  := fltMarVe4;
      ParamByName('PREVE4').AsFloat  := fltPreVe4;
      ParamByName('MARBR5').AsFloat  := fltMarVe5;
      ParamByName('PREVE5').AsFloat  := fltPreVe5;
      ParamByName('MARBR6').AsFloat  := fltMarVe6;
      ParamByName('PREVE6').AsFloat  := fltPreVe6;
      ParamByName('MARBR7').AsFloat  := fltMarVe7;
      ParamByName('PREVE7').AsFloat  := fltPreVe7;

      ParamByName('PREVE7').AsFloat  := fltPreVe7;

      If fCfgSis('ATPRBI', varBoolean) Then
      Begin
        blnPermiteReducaoDePreco:= fRetValorCampoIteGer(strCodIte, VS_strCodEmp, 'ITEGER', 'ITE_REDROP') = 'S';

        If Not(blnPermiteReducaoDePreco) Then
        Begin
          If fltPreCus < fltCusAnt Then
            fltPreCus:= fltCusAnt;
        End;
      End;

      ParamByName('PRECUS').AsFloat  := fltPreCus;
      ParamByName('FORULT').AsString := fRetCodForFilial(VS_strCodEmp);
      ParamByName('DTAULT').AsDate   := Date;
      ParamByName('QTDUCO').AsFloat  := fltQtdPro;

      If (fCfgSis('ATPCPM') = 'S') Then
        ParamByName('PREULT').AsFloat  := fltTotPreUlt
      Else
        ParamByName('PREULT').AsFloat  := fltPreCom;

      ParamByName('PRECOM').AsFloat  := fltPreCom;


      If (fCfgSis('ATPCPM') = 'S') Then
      Begin

        If blnBaixaTotal Then
          ParamByName('PREMED').AsFloat  := fltTotPreMed; // DEVE SER ATUALIZADO APENAS APOS A BAIXA TOTAL

        ParamByName('IMPULT').AsFloat  := fltTotImpUlt;

      End;

      ParamByName('PREALT').AsString  := strAgrupadorPreAlt;


      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Close;
    End;
    FreeAndNil(qryUpd);

    If Not VS_blnPreAltViaTrigger Then
    fGravaPreAlt(strCodIte,
                 fltCusAnt,
                 fltPreCus,
                 fltPr1Ant,
                 fltPreVe1,
                 fltMa1Ant,
                 fltMarVe1,
                 fltPr2Ant,
                 fltPreVe2,
                 fltMa2Ant,
                 fltMarVe2,
                 fltPr3Ant,
                 fltPreVe3,
                 fltMa3Ant,
                 fltMarVe3,
                 fltPr4Ant,
                 fltPreVe4,
                 fltMa4Ant,
                 fltMarVe4,
                 fltPr5Ant,
                 fltPreVe5,
                 fltMa5Ant,
                 fltMarVe5,
                 fltPr6Ant,
                 fltPreVe6,
                 fltMa6Ant,
                 fltMarVe6,
                 fltPr7Ant,
                 fltPreVe7,
                 fltMa7Ant,
                 fltMarVe7,
                 fCampoTabela('ITE_PRECOM', 'ITEGER', ['ITE_CODEMP', 'ITE_CODITE'], [VS_strCodEmp, strCodIte]),
                 fltPreCom,
                 'ORDEM DE PRODUCAO',
                 Nil,
                 '',
                 strLoginUsuarioLogado);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TOrdPro.pAtualizaCusto;
var qryAtuFdo: TUniQuery;
begin
  qryAtuFdo := fCriaQuery;
  Try
    FObjItensAcabado.First;
    While not FObjItensAcabado.Eof Do
    Begin
      If FObjItensAcabado.FieldByName('AUTINC').AsString <> '' Then
      Begin
        qryAtuFdo.SQL.Add('UPDATE FATDOR SET FDO_TOTCUS = :TOTCUS, FDO_TOTMED = :TOTMED WHERE AUTOINCREM = :AUTINC');
        qryAtuFdo.ParamByName('TOTCUS').Value := FobjItensAcabado.FieldByName('PRECUS').Value;
        qryAtuFdo.ParamByName('TOTMED').Value := FobjItensAcabado.FieldByName('PREMED').Value;
        qryAtuFdo.ParamByName('AUTINC').Value := FobjItensAcabado.FieldByName('AUTINC').AsString;
        qryAtuFdo.ExecSQL;
        Exit;
      End;
      FObjItensAcabado.Next;
    End;
  Finally
    FreeAndNil(qryAtuFdo);
  End;
end;

procedure TOrdPro.pAtualizarClienteEndEntrega(strOrdPro, strCodCli, strAutInc: String);
begin
  fExecutaSQL(' UPDATE MOVPRO ' +
              ' SET PRO_CODCLI = ' + IIF(fEmptyStr(strCodCli), ' NULL ', QuotedStr(strCodCli)) + ', ' +
              '     PRO_ENDENT = ' + IIF(fEmptyStr(strAutInc), ' NULL ', QuotedStr(strAutInc)) + '  ' +
              ' WHERE PRO_CODPRO = ' + QuotedStr(strOrdPro)  + ' AND ' +
              '       PRO_CODEMP = ' + QuotedStr(VS_strCodEmp));
end;

procedure TOrdPro.pAtualizarDadosPedido(strOrdPro, strNumPed, strEspPed, strEmpPed: String);
var
  qryAux: TUniQuery;
  strSQL: String;
begin
  qryAux := fCriaQuery();

  Try
    strSQL := '';
    strSQL := strSQL + '  UPDATE                    ';
    strSQL := strSQL + '    MOVPRO                  ';
    strSQL := strSQL + '  SET                       ';
    strSQL := strSQL + '    PRO_EMPPED =:EMPPED,    ';
    strSQL := strSQL + '    PRO_NUMPED =:NUMPED,    ';
    strSQL := strSQL + '    PRO_ESPPED =:ESPPED     ';
    strSQL := strSQL + '  WHERE                     ';
    strSQL := strSQL + '        PRO_CODPRO =:CODPRO ';
    strSQL := strSQL + '    AND PRO_CODEMP =:CODEMP ';

    qryAux.SQL.Add(strSQL);

    qryAux.ParamByName('EMPPED').AsString := strEmpPed;
    qryAux.ParamByName('NUMPED').AsString := strNumPed;
    qryAux.ParamByName('ESPPED').AsString := strEspPed;
    qryAux.ParamByName('CODPRO').AsString := strOrdPro;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

{**************************************}
{* RETORNA TRUE SE ENCONTROU A ORDPRO *}
{***********************************AF*}
function TOrdPro.fCarregaOrdPro(strOrdPro: String = ''; blnBaixad: Boolean = False): Boolean;
Begin
  Try
    Result := False;

    With qryOrdPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT   ');
      SQL.Add('  MOVPRO.*   ');
      SQL.Add('FROM     ');
      SQL.Add('  MOVPRO ');
      SQL.Add('WHERE    ');
      SQL.Add('  PRO_CODEMP = :CODEMP ');

      If Not blnBaixad Then
        SQL.Add('  AND PRO_DTABAI IS NULL ');

      If Not fEmptyStr(strOrdPro) Then
      Begin
        SQL.Add('  AND PRO_CODPRO = :CODPRO ');
        ParamByName('CODPRO').AsString := strOrdPro;
      End;

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        If not fEmptyStr(FCodPro) Then
          fLock_Unlock('ORDPRO_' + FCodPro + '_' + VS_strCodEmp, False, False, False, '', False);

        Result := True;
        objLotInd.Clear;
        pAtuDados;
      End;

      FTemArm := fEstrututaTemLote;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[TOrdPro.fCarregaOrdPro]');
    End;
  End;
End;

function TOrdPro.fConsideraLoteEstoqueExternoSubProdutosFulfillment: Boolean;
begin

  Result := False;

  If Not FFulfillment.EhOperacaoFulFillment Then
    Exit;

  If Not FFulfillment.EhEstoqueExterno Then
    Exit;

  If FFulfillment.CodigoDoEstoqueExterno.IsEmpty Then
    Exit;

  If Not MatchStr(fCfgSis('BXSBIT'), ['2','3']) Then
    Exit;

  Result := True;

end;

function TOrdPro.fDefinirOrdemProducaoItem: Boolean;
  Var
    qryTemp: TUniQuery;
begin
  Result := True;

  Try
    qryTemp := fCriaQuery(Nil);

    Try
      With qryTemp, SQL Do
      Begin
        Close;
        Clear;

        Add('UPDATE FATDOR, EXTDOR SET FDO_ORDPRO = :CODPRO ');
        Add(' WHERE AUTOINCREM = FDO_SEQFDO');
        Add('   AND FDO_NUMDOC = :NUMDOC ');
        Add('   AND FDO_ESPDOC = :ESPDOC ');
        Add('   AND FDO_CODEMP = :CODEMP ');
        Add('   AND FDO_CODCLI = :CODCLI ');
        Add('   AND FDO_CODITE = :CODITE ');
        Add('   AND FDO_SEQINC = :SEQINC ');

        ParamByName('CODPRO').AsString := FCodPro;
        ParamByName('NUMDOC').AsString := FNumDoc;
        ParamByName('ESPDOC').AsString := FEspDoc;
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('CODCLI').AsString := FCodCli;
        ParamByName('CODITE').AsString := FCodIte;
        ParamByName('SEQINC').AsString := FSeqInd;

        ExecSQL;
      End;
    Except
      On E: Exception Do
      Begin
        Result := True;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TOrdPro.fDocumentoEhSaida: Boolean;
  const
    SQL = 'SELECT GER_CLAFIS AS CLAFIS FROM MOVGER WHERE GER_NUMDOC = :NUMDOC AND GER_ESPDOC = :ESPDOC AND GER_CODEMP = :CODEMP';
  var
    qryAux : TUniQuery;
begin

  Result := True;

  If FNumDoc.IsEmpty Then
    Exit;

  If FEspDoc.IsEmpty Then
    Exit;

  If FCodEmp.IsEmpty Then
    Exit;

  If (FFulfillment.EhOperacaoFulFillment) And (FFulfillment.EhOperacaoDeRemessa) Then
    Exit(False);

  qryAux := fCriaQuery;

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(SQL);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit;

    If (Pos(qryAux.FieldByName('CLAFIS').AsString, fCfgSis('CLADEV')) > 0) Then
      Result := False;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TOrdPro.fBaixaOrdProDV(fltQtdPro: Double; strConfer: String): Boolean;
  Var
    strDocNov: String;
    strAutInc: String;
    strIncDet: String;
    strDescri: String;
    strRefere: String;
    strMarca : String;
    strUnidad: String;
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
    blnBAORDP : Boolean;
Begin

  Try
    If blnTransacao Then
      fStartTransaction;

    blnBAORDP := (fCfgSis('BAORDP', varInteger) = 0);

    Result := True;

    pAtuDados;

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
    pRetDadosItem(strCodIte, strDescri, strRefere, strMarca, strUnidad);

    //quandoconfigurado para utilizar o número da op como lote, cadastra o lote se ainda não houver no banco de dados
    pGeraLoteSequencial;

    {*****************************}
    {* BAIXA A ORDEM DE PRODUÇÃO *}
    {**************************AF*}
    With qryOrdPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE                                         ');
      SQL.Add('  MOVPRO                                       ');
      SQL.Add('SET                                            ');

      If (FQtdApr <= fltQtdPro) or (fCfgSis('BXOPPA', varString) = 'B') Then
      Begin
        SQL.Add('  PRO_DTABAI = ' + fCurrentDate + ', ');
        SQL.Add('  PRO_HORBAI = ' + FormatDateTime('hhmmss', fTime()) + ', ');
      End;

      If Not fEmptyStr(FCodArm) Then
      begin
        SQL.Add('  PRO_NUMLOT = :NUMLOT,                                ');
        ParamByName('NUMLOT').AsString := FCodArm;
      end;

      SQL.Add('  PRO_QTDPRO = IFNULL(PRO_QTDPRO,0) + :QTDPRO, ');
      SQL.Add('  PRO_CONFER = :CONFER                         ');
      SQL.Add('WHERE                                          ');
      SQL.Add('  PRO_CODPRO = :CODPRO AND ');
      SQL.Add('  PRO_CODEMP = :CODEMP ');

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ParamByName('QTDPRO').AsFloat  := fltQtdPro;
      ParamByName('CONFER').AsString := strConfer;

      ExecSQL;
      Close;
    End;

    {***************************************}
    {* ATUALIZA SALDO DOS PROD. ESTRUTURAS *}
    {************************************AF*}
    With qryOrdPro Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add('SELECT ');
      SQL.Add('  DETPRO.* ');

      If fCfgSis('CTLEST') = '2' Then
        SQL.Add(', IFNULL(DOP_NUMLOT, LOT_NUMLOT) AS NUMLOT')
      Else
        SQL.Add(', CAST(""  AS CHAR(30)) AS NUMLOT ');

      SQL.Add('FROM ');
      SQL.Add('  MOVPRO ');
      SQL.Add('  JOIN DETPRO ON DOP_SEQGER = MOVPRO.AUTOINCREM ');

      If fCfgSis('CTLEST') = '2' Then
      Begin
        SQL.Add('LEFT JOIN CADLOT L ON DOP_ITESUB = LOT_CODITE AND');
        SQL.Add('                      LOT_PRIPRO = "S"        AND');
        SQL.Add('                      LOT_CODEMP = ' + QuotedStr(VS_strCodEmp));
      End;

      SQL.Add('WHERE ');
      SQL.Add('  PRO_CODPRO = :CODPRO AND ');
      SQL.Add('  PRO_CODEMP = :CODEMP ');

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      strDocNov    := fRetSequencial('PRO_OP', VS_strCodEmp, fTamDocCadRec);
      strAutInc := '';
      fltPreCus := 0;
      fltPreCom := 0;

      {**************************************}
      {* GRAVA MOVGER DOS SUBITENS          *}
      {***********************************AF*}
      If Not fGravaMovGer(strAutInc,
                          strDocNov,
                          'OP',
                          VS_strCodEmp,
                          '',
                          strLoginUsuarioLogado,
                          IIF(fEmptyStr(strCodCli), strCodFor, ''),
                          strCodCli,
                          IIF(Not fEmptyStr(strCodCli), 'C', 'F'),
                          IIF(blnBAORDP, FDtaCad, VS_Date),
                          fTime(),
                          IIF(blnBAORDP, FDtaCad, VS_Date),
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
                          'BAIXA DE ORDEM DE PRODUÇÃO',
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
                          strCodPro,
                          0,
                          0.0,
                          0,
                          '',          // Consumidor final
                          'N',
                          '',
                          '',          // Operador da expedição
                          '',          // Separador da Expedição
                          '',
                          '',
                          'N',         // Entrega Futura
                          FALSE,       // Baixa de Entrega Futura
                          0,           // Margem de Lucro
                          0.0,         // Base do retido (caso tivesse) com ipi e frete de entrada
                          0.0,         // Valor do retido considerando a base acima.
                          'N',         // Gerar produção fora da loja
                          '',          // Numero do Registro - Correios ou Transportadora
                          VS_Date,     // Data de Entrega no Romaneio
                          '',          // Classificação fiscal 4
                          'N',         // AUTO-SERVICO
                          '',          // Evento
                          FEndEnt,     // AUTOINC DO ENDEREÇO DE ENTREGA
                          '',          // Conteúdo do CNFNFE
                          '',          // Motivo da Devolução
                          '',
                          True) Then   // Imprime Duplicatas na NF-e
      Begin
        Result := False;
        If blnTransacao Then
          fRollBack;
        Exit;
      End;

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

      pPreAltDefineVariaveisAltPre(fNow, 'ORDEM DE PRODUCAO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

      While Not Eof Do
      Begin

        strIncDet := '';
        pRetDadosItem(FieldByName('DOP_ITESUB').AsString, strDescri, strRefere, strMarca, strUnidad);

        {*************************************}
        {* GRAVA MOVDET                      *}
        {**********************************AF*}
        If Not fGravaMovDet(strIncDet,
                            strAutInc,
                            strDocNov,
                            'OP',
                            VS_strCodEmp,
                            FieldByName('DOP_ITESUB').AsString,
                            strLoginUsuarioLogado,
                            '',
                            strMarca,
                            IIF(fEmptyStr(strCodCli), strCodFor, ''),
                            strCodCli,
                            IIF(blnBAORDP, FDtaCad, VS_Date),
                            fTime(),
                            IIF(blnBAORDP, FDtaCad, VS_Date),
                            '01000',
                            IIF(Not fEmptyStr(strCodCli), 'C', 'F'),
                            '',
                            strDescri,
                            strRefere,
                            strUnidad,
                            '',
                            fltQtdPro * FieldByName('DOP_QTDITE').AsFloat,
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
                            '',
                            0,
                            0,
                            0,
                            '1999',
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
                            False,
                            '',
                            '',
                            '', // Empresa do Faturamento
                            0,
                            '',
                            '',
                            0,
                            'NOR',
                            '',
                            '',
                            0,
                            'N',
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            0,
                            0,
                            '',
                            0,
                            0,
                            0,
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            0,
                            '',
                            '',
                            0,
                            '',
                            '',
                            '',
                            '',
                            '',
                            0,
                            strCodPro,
                            '',
                            '',
                            0,
                            0,
                            0.0,
                            '',
                            '',
                            False,
                            False,
                            '',                                                             //  Especie da Entrega Fututa
                            '',                                                             //  Documento da Entrega Fututa
                            '',
                            '',                                                             //  Empresa da Entrega Fututa
                            '',
                            '',
                            '',
                            '',
                            0.0,
                            '',
                            0.0,
                            0.0,
                            0,
                            'N',
                            '',
                            0,
                            0,
                            0,
                            0,
                            '',
                            FieldByName('NUMLOT').AsString,  // strNumLot
                            'N',                             // strPigBas
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
                            '',
                            '',
                            '',
                            0,
                            0,
                            0,
                            0) Then
        Begin
          Result := False;
          If blnTransacao Then
            fRollBack;
          Exit;
        End;

        If Not fAtualizaEstoqueCadIte(FieldByName('DOP_ITESUB').AsString,
                                      'E',
                                      FieldByName('DOP_QTDITE').AsFloat * fltQtdPro,
                                      0.0,
                                      FieldByName('NUMLOT').AsString,
                                      False) Then
        Begin
          Result := False;
          If blnTransacao Then
            fRollBack;
          Exit;
        End;

        {**********************************************}
        {* CALCULA PREÇO DE COMPRA DO PRODUTO ACABADO *}
        {*******************************************RV*}
        If (fCfgSis('APORPR') = 'S') Then
          fltPreCom := fltPreCom + (fRetPrecoCustoIte(FieldByName('DOP_ITESUB').AsString) * FieldByName('DOP_QTDITE').AsFloat);

        Next;
      End;

      {**********************************************}
      {* GRAVA PREÇOS DO PRODUTO ACABADO            *}
      {*******************************************RV*}
      If (fCfgSis('APORPR') = 'S') Then
      Begin
        If Not fAtuPrecosProAca(strCodIte, fltQtdPro) Then
        Begin
          Result := False;
          If blnTransacao Then
            fRollBack;
          Exit;
        End;
      End;

      Close;
    End;

    If blnTransacao Then
    Begin
      If Result Then
      Begin
        fCommit;
        objLotInd.Clear; //limpa lotes individuais
        If blnTransacao Then
          fMensagem('','Ordem de produção baixada com sucesso!',['&OK']);
      End
      Else
        fRollBack;
    End;
    strAgrupadorPreAlt := '';


  Except
    On E: Exception Do
    Begin
      If blnTransacao Then
        fRollBack;
      strAgrupadorPreAlt := '';
      Raise Exception.Create(E.Message);
    End;
  End;

End;

Function TOrdPro.fEstrututaTemLote: Boolean;
  Var
    qryCadLot: TUniQuery;
Begin
  qryCadLot := fCriaQuery(Self);
  With qryCadLot, SQL Do
  Begin

    if fCfgsis('LOTORD', varBoolean) then
    begin
      FCodArm := FCodPro;
      Result  := True;
      exit;
    end;

    Add('SELECT LOT_NUMLOT, LOT_PRIPRO FROM CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND');
    Add('  LOT_CODEMP = :CODEMP    ');

    ParamByName('CODITE').AsString := FCodIte;
    ParamByName('CODEMP').AsString := FCodEmp;

    Open;

    Result := RecordCount > 0;

    If Result And Locate('LOT_PRIPRO ', 'S', []) Then
      FCodArm := FieldByName('LOT_NUMLOT').AsString
    Else
      FCodArm := '';

  End;
  FreeAndNil(qryCadLot);
End;

class function TOrdPro.fExcluirOrdemProducao(strOrdPro, strCodEmp, strNomForm, strOpeDel: String; blnValidaBaixada: Boolean = True): Boolean;
  Var
    qryOrdPro,
    qrySubItens: TUniQuery;
begin
  If blnValidaBaixada And fOrdemProducaoBaixada(strOrdPro, strCodEmp) Then
    Raise Exception.Create('Ordem de produção já foi baixada, não será permitido excluir a mesma!');

  qryOrdPro := fCriaQuery;
  qrySubItens := fCriaQuery;

  With qryOrdPro, SQL Do
  Begin
    Add('SELECT * FROM MOVPRO WHERE PRO_CODPRO = :CODPRO AND PRO_CODEMP = :CODEMP');
    ParamByName('CODPRO').AsString := strOrdPro;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    First;
    While Not Eof Do
    Begin
      pLimpaOrdProDoPedido(strOrdPro,
                           qryOrdPro.FieldByName('PRO_NUMPED').AsString,
                           qryOrdPro.FieldByName('PRO_ESPPED').AsString,
                           qryOrdPro.FieldByName('PRO_EMPPED').AsString);

      fVerificaIntegridade(strNomForm, 'MOVPRO', qryOrdPro, True, False, 'fExcluirOrdemProducao', strOpeDel);
      ReprocessarItem(qryOrdPro.FieldByName('PRO_CODITE').AsString, '', False);
      Next;
    End;
  End;

  With qrySubItens, SQL Do
  Begin
    Add('SELECT * FROM DETPRO WHERE DOP_SEQGER = :AUTINC AND DOP_CODEMP = :CODEMP');
    ParamByName('AUTINC').AsString := qryOrdPro.FieldByName('AUTOINCREM').AsString;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    First;
    While Not Eof Do
    Begin
      fVerificaIntegridade(strNomForm, 'DETPRO', qrySubItens, True, False, 'fExcluirOrdemProducao', strOpeDel);
      ReprocessarItem(qrySubItens.FieldByName('DOP_ITESUB').AsString, '', False);
      Next;
    End;
  End;

  While Not qrySubItens.IsEmpty Do qrySubItens.Delete;
  While Not qryOrdPro.IsEmpty Do qryOrdPro.Delete;

  FreeAndNil(qryOrdPro);
  FreeAndNil(qrySubItens);
  Result := True;
end;

Class procedure TOrdPro.pLimpaOrdProDoPedido(strOrdPro, strNumPed, strEspDoc, strCodEmp: String);
  Var
    qryLimpar : TUniQuery;
begin

  qryLimpar := fCriaQuery(Nil);

  With qryLimpar Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' UPDATE                      ');
    SQL.Add('   FATDOR                    ');
    SQL.Add(' SET                         ');
    SQL.Add('   FDO_ORDPRO = NULL         ');
    SQL.Add(' WHERE                       ');
    SQL.Add('   FDO_ORDPRO = :ORDPRO AND  ');

    If Not fEmptyStr(strNumPed) Then
      SQL.Add('   FDO_NUMDOC = :NUMPED AND  ');

    SQL.Add('   FDO_ESPDOC = :ESPDOC AND  ');
    SQL.Add('   FDO_CODEMP = :CODEMP      ');

    ParamByName('ORDPRO').AsString := strOrdPro;

    If (Not fEmptyStr(strNumPed)) Then
      ParamByName('NUMPED').AsString := strNumPed;

    If (Not fEmptyStr(strEspDoc)) Then
      ParamByName('ESPDOC').AsString := strEspDoc
    Else
      ParamByName('ESPDOC').AsString := 'PD';

    ParamByName('CODEMP').AsString := strCodEmp;

    ExecSQL;
  End;

  FreeAndNil(qryLimpar);

end;

class procedure TOrdPro.pLimpaPedidoDaOrdemProducao(strOrdPro, strCodEmp: String);
  Var
    qryLimpar : TUniQuery;
begin

  qryLimpar := fCriaQuery(Nil);

  With qryLimpar Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' UPDATE                      ');
    SQL.Add('   MOVPRO                    ');
    SQL.Add(' SET                         ');
    SQL.Add('   PRO_NUMDOC = NULL,        ');
    SQL.Add('   PRO_ESPDOC = NULL         ');
    SQL.Add(' WHERE                       ');
    SQL.Add('   PRO_CODPRO = :ORDPRO AND  ');
    SQL.Add('   PRO_CODEMP = :CODEMP      ');

    ParamByName('ORDPRO').AsString := strOrdPro;
    ParamByName('CODEMP').AsString := strCodEmp;

    ExecSQL;
  End;

  FreeAndNil(qryLimpar);

end;

Function TOrdPro.fAtualizaQtdSubProd(strCodPro: String; fltQtdPro: Double): Boolean;
  Var
    strSQL: String;
    DefinicoesLote: TDefinicoesLote;
    DefinicaoLote : TDefinicaoLote;
begin
  If cdsIteEst.Active Then
  Begin
    cdsIteEst.First;
    SetLength(DefinicoesLote, cdsIteEst.RecordCount);
    While not cdsIteEst.Eof Do
    Begin
      DefinicoesLote[cdsIteEst.RecNo -1].strSequencia    := cdsIteEst.FieldByName('AUTOINCREM').AsString;
      DefinicoesLote[cdsIteEst.RecNo -1].strLoteDefinido := cdsIteEst.FieldByName('NUMLOT').AsString;
      DefinicoesLote[cdsIteEst.RecNo -1].fltSaldoLoteDefinido := cdsIteEst.FieldByName('SALDOS').AsFloat;
      cdsIteEst.Next;
    End;
  End;

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DETPRO.AUTOINCREM,    ';
    strSQL := strSQL + '  DOP_ITESUB,           ';
    strSQL := strSQL + '  PRO_CODITE AS CODITE, ';
    strSQL := strSQL + '  DOP_ITESUB AS ITESUB, ';
    strSQL := strSQL + '  DOP_NUMFAS AS SEQUEN, ';

    If MatchStr(fCfgSis('MLAYOP', varString), ['5','6']) Then
      strSQL := strSQL + ' @DENSID := IF(IFNULL(ITE_DENSID, 1) <= 0, 1, IFNULL(ITE_DENSID, 1)) AS DENSID, '
    Else
      strSQL := strSQL + ' @DENSID := 1 AS DENSID, ';

    strSQL := strSQL + '  @DENSID * DOP_QTDITE AS QTDITE, ';
    strSQL := strSQL + '  (@DENSID * DOP_QTDITE * ' + AnsiReplaceStr(FloatToStr(fltQtdPro), ',', '.') + ') AS QTDPRO, ';
    strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
    strSQL := strSQL + '  ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  ITE_CONLOT AS CONLOT, ';
    strSQL := strSQL + '  CADITE.ITE_ITEATI AS ITEMATIVO, ';
    strSQL := strSQL + '  IF(IFNULL(ITE_REFERE, "") = "", " ", ITE_REFERE) AS REFERE,';
    strSQL := strSQL + '  IFNULL(DOP_NUMLOT, L.LOT_NUMLOT) AS NUMLOT,';
    strSQL := strSQL + '  COALESCE(L2.LOT_SALDOS, L.LOT_SALDOS, 0) AS SALDOS,';
    strSQL := strSQL + '  (SELECT COUNT(*) FROM CADLOT WHERE LOT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND LOT_CODITE = DOP_ITESUB) AS LOTQTD ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVPRO ';
    strSQL := strSQL + '  JOIN DETPRO      ON DOP_SEQGER = MOVPRO.AUTOINCREM ';
    strSQL := strSQL + '  JOIN CADITE      ON ITE_CODITE = DOP_ITESUB ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON UNI_CODUNI = CADITE.ITE_CODUNI ';

    //Lote principal para quando não houver nenhum lote vinculado
    strSQL := strSQL + '  LEFT JOIN CADLOT L ON DOP_ITESUB = L.LOT_CODITE AND ';
    strSQL := strSQL + '                        L.LOT_PRIPRO = "S"        AND ';
    strSQL := strSQL + '                        L.LOT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
    strSQL := strSQL + '                        L.LOT_SALDOS >= (DOP_QTDITE * ' + AnsiReplaceStr(FloatToStr(fltQtdPro), ',', '.') + ')';

    //Saldo do lote vinculado
    strSQL := strSQL + '  LEFT JOIN CADLOT L2 ON DOP_ITESUB = L2.LOT_CODITE AND ';
    strSQL := strSQL + '                         DOP_NUMLOT = L2.LOT_NUMLOT AND ';
    strSQL := strSQL + '                         L2.LOT_CODEMP = ' + QuotedStr(VS_strCodEmp);

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_CODPRO = :CODPRO AND ';
    strSQL := strSQL + '  PRO_CODEMP = :CODEMP ';

    With FqryEst Do
    Begin
      Close;
      cdsIteEst.Close;

      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;
      pSetaClient(FqryEst);

      cdsIteEst.SetProvider(FdspEst);
      cdsIteEst.Open;
      pSetaClient(cdsIteEst);
    End;
    (cdsIteEst.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
    (cdsIteEst.FieldByName('QTDPRO') As TFloatField).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );

    Result := True;
    cdsIteEst.First;
    For DefinicaoLote in DefinicoesLote do
    Begin
      If cdsIteEst.Locate('AUTOINCREM', DefinicaoLote.strSequencia, []) Then
      begin
        cdsIteEst.Edit;
        cdsIteEst.FieldByName('NUMLOT').AsString := DefinicaoLote.strLoteDefinido;
        cdsIteEst.FieldByName('SALDOS').AsFloat := DefinicaoLote.fltSaldoLoteDefinido;
        cdsIteEst.Post;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdPro.fAtualizaQtdSubProd]');
    End;
  End;
end;

{**************************************}
{* ATUALIZA DADOS PARA AS VARIAVEIS   *}
{***********************************AF*}
procedure TOrdPro.pAtuDados;
Begin

  Try

    If (Not qryOrdPro.Active) Or (qryOrdPro.IsEmpty) Then
    Begin
      pLimpaDados;
      Exit;
    End;

    With qryOrdPro Do
    Begin
      FAutInc := FieldByName('AUTOINCREM').AsString;
      FCodPro := FieldByName('PRO_CODPRO').AsString;
      FNumDoc := FieldByName('PRO_NUMDOC').AsString;
      FEspDoc := FieldByName('PRO_ESPDOC').AsString;
      FCodEmp := FieldByName('PRO_CODEMP').AsString;
      FCodCli := FieldByName('PRO_CODCLI').AsString;
      FEndEnt := FieldByName('PRO_ENDENT').AsString;
      FCodIte := FieldByName('PRO_CODITE').AsString;
      FObs001 := FieldByName('PRO_OBS001').AsString;
      FObs002 := FieldByName('PRO_OBS002').AsString;
      FObs_PD := FieldByName('PRO_OBS_PD').AsString;
      FConfer := FieldByName('PRO_CONFER').AsString;

      FQtdApr := roundTo(FieldByName('PRO_QTDAPR').AsFloat, -(fCfgSis('DECQTD', varInteger))) - roundTo(FieldByName('PRO_QTDPRO').AsFloat, -(fCfgSis('DECQTD', varInteger)));
      FQtdPro := roundTo(FieldByName('PRO_QTDPRO').AsFloat, -(fCfgSis('DECQTD', varInteger)));


      FDtaPro := FieldByName('PRO_DTAPRO').AsDateTime;
      FDtaCad := FieldByName('PRO_DTACAD').AsDateTime;
      FDtaBai := FieldByName('PRO_DTABAI').AsDateTime;
      FHorBai := FieldByName('PRO_HORBAI').AsDateTime;

      FNumPed := FieldByName('PRO_NUMPED').AsString;
      FEspPed := FieldByName('PRO_ESPPED').AsString;
      FEmpPed := FieldByName('PRO_EMPPED').AsString;

      If blnMonFas Then
        FBlnNotaRefugoVinculada := fTemNotaRefugoJaEmitida(FieldByName('AUTOINCREM').AsString);


      objLotInd.strCodIte := FCodIte;
    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

End;

procedure TOrdPro.pBeforePostQryOrdPro(DataSet: TDataSet);
begin
  if (qryOrdPro.State = dsInsert)  And fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque then
  Begin
    pAtuDados;
    pCarregaOPFilhas(FCodIte, fStrToFloat(strQtdApr), cdsIteEst);
  End;
end;

{**************************************}
{* LIMPA DADOS DAS VARIAVEIS          *}
{***********************************AF*}
procedure TOrdPro.pLimpaDados;
Begin
  If not fEmptyStr(FCodPro) Then
    fLock_Unlock('ORDPRO_' + FCodPro + '_' + VS_strCodEmp, False, False, False, '', False);

  FCodPro := '';
  FNumDoc := '';
  FEspDoc := '';
  FCodCli := '';
  FEndEnt := '';
  FCodIte := '';
  FObs001 := '';
  FObs002 := '';
  FObs_PD := '';
  FConfer := '';
  FQtdApr := 0;
  FQtdPro := 0;
  FDtaPro := 0;
  FDtaCad := 0;
  FDtaBai := 0;
  FSeqInd := '';
  FCodArm := '';
  FCodFor := '';
  objLotInd.Clear;
  setLength(arrLotes, 0);
  lstOPPai.Clear;
  lstOPFilha.Clear;
End;

procedure TOrdPro.pRetPrecosProAca(strCodIte: String);
  Var
    qryIteGer: TUniQuery;
begin
  qryIteGer := fCriaQuery;
  With qryIteGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('  ITE_PRECUS,  ');
    SQL.Add('  ITE_PRECOM,  ');
    SQL.Add('  ITE_MARBR1,  ');
    SQL.Add('  ITE_MARBR2,  ');
    SQL.Add('  ITE_MARBR3,  ');
    SQL.Add('  ITE_MARBR4,  ');
    SQL.Add('  ITE_MARBR5,  ');
    SQL.Add('  ITE_MARBR6,  ');
    SQL.Add('  ITE_MARBR7,  ');
    SQL.Add('  ITE_PREVE1,  ');
    SQL.Add('  ITE_PREVE2,  ');
    SQL.Add('  ITE_PREVE3,  ');
    SQL.Add('  ITE_PREVE4,  ');
    SQL.Add('  ITE_PREVE5,  ');
    SQL.Add('  ITE_PREVE6,  ');
    SQL.Add('  ITE_PREVE7,  ');
    SQL.Add('  ITE_DESF01,  ');
    SQL.Add('  ITE_DESF02,  ');
    SQL.Add('  ITE_DESF03,  ');
    SQL.Add('  ITE_DESF04,  ');
    SQL.Add('  ITE_DESF05,  ');
    SQL.Add('  ITE_DESF06,  ');
    SQL.Add('  ITE_ICMENT,  ');
    SQL.Add('  ITE_IPIENT,  ');
    SQL.Add('  ITE_FREENT,  ');
    SQL.Add('  ITE_ACRFIN,  ');
    SQL.Add('  ITE_SUBSTI,  ');
    SQL.Add('  ITE_VALFRE,  ');
    SQL.Add('  ITE_DESADB,  ');
    SQL.Add('  ITE_SUBFED,  ');
    SQL.Add('  ITE_ICMSAI,  ');
    SQL.Add('  ITE_IMPFED,  ');
    SQL.Add('  ITE_DESOPE,  ');
    SQL.Add('  ITE_COMTB1,  ');
    SQL.Add('  ITE_COMTB2,  ');
    SQL.Add('  ITE_COMTB3,  ');
    SQL.Add('  ITE_COMTB4,  ');
    SQL.Add('  ITE_COMTB5,  ');
    SQL.Add('  ITE_COMTB6,  ');
    SQL.Add('  ITE_COMTB7,  ');
    SQL.Add('  ITE_TCIFCU,  ');
    SQL.Add('  ITE_TSCUST,  ');
    SQL.Add('  ITE_DEPICO,  ');
    SQL.Add('  ITE_DEICMS,  ');
    SQL.Add('  ITE_FATREG   ');
    SQL.Add('FROM');
    SQL.Add('  ITEGER ');
    SQL.Add('WHERE ');
    SQL.Add('  ITE_CODITE = :CODITE AND');
    SQL.Add('  ITE_CODEMP = :CODEMP');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
    Begin
      fltCusAnt := FieldByName('ITE_PRECUS').AsFloat;
      fltComAnt := FieldByName('ITE_PRECOM').AsFloat;
      fltMa1Ant := FieldByName('ITE_MARBR1').AsFloat;
      fltMa2Ant := FieldByName('ITE_MARBR2').AsFloat;
      fltMa3Ant := FieldByName('ITE_MARBR3').AsFloat;
      fltMa4Ant := FieldByName('ITE_MARBR4').AsFloat;
      fltMa5Ant := FieldByName('ITE_MARBR5').AsFloat;
      fltMa6Ant := FieldByName('ITE_MARBR6').AsFloat;
      fltMa7Ant := FieldByName('ITE_MARBR7').AsFloat;
      fltPr1Ant := FieldByName('ITE_PREVE1').AsFloat;
      fltPr2Ant := FieldByName('ITE_PREVE2').AsFloat;
      fltPr3Ant := FieldByName('ITE_PREVE3').AsFloat;
      fltPr4Ant := FieldByName('ITE_PREVE4').AsFloat;
      fltPr5Ant := FieldByName('ITE_PREVE5').AsFloat;
      fltPr6Ant := FieldByName('ITE_PREVE6').AsFloat;
      fltPr7Ant := FieldByName('ITE_PREVE7').AsFloat;
      fltDesF01 := FieldByName('ITE_DESF01').AsFloat;
      fltDesF02 := FieldByName('ITE_DESF02').AsFloat;
      fltDesF03 := FieldByName('ITE_DESF03').AsFloat;
      fltDesF04 := FieldByName('ITE_DESF04').AsFloat;
      fltDesF05 := FieldByName('ITE_DESF05').AsFloat;
      fltDesF06 := FieldByName('ITE_DESF06').AsFloat;
      fltICMEnt := FieldByName('ITE_ICMENT').AsFloat;
      fltIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
      fltFrete  := FieldByName('ITE_FREENT').AsFloat;
      fltAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
      fltSubsti := FieldByName('ITE_SUBSTI').AsFloat;
      fltValFre := FieldByName('ITE_VALFRE').AsFloat;
      fltDesAdb := FieldByName('ITE_DESADB').AsFloat;
      fltSubFed := FieldByName('ITE_SUBFED').AsFloat;
      fltICMSai := FieldByName('ITE_ICMSAI').AsFloat;
      fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
      fltDesOpe := FieldByName('ITE_DESOPE').AsFloat;
      fltComTb1 := FieldByName('ITE_COMTB1').AsFloat;
      fltComTb2 := FieldByName('ITE_COMTB2').AsFloat;
      fltComTb3 := FieldByName('ITE_COMTB3').AsFloat;
      fltComTb4 := FieldByName('ITE_COMTB4').AsFloat;
      fltComTb5 := FieldByName('ITE_COMTB5').AsFloat;
      fltComTb6 := FieldByName('ITE_COMTB6').AsFloat;
      fltComTb7 := FieldByName('ITE_COMTB7').AsFloat;
      fltTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
      fltTSCust := FieldByName('ITE_TSCUST').AsFloat;
      fltDePiCo := FieldByName('ITE_DEPICO').AsFloat;
      fltDeICMS := FieldByName('ITE_DEICMS').AsFloat;
      fltFatReg := FieldByName('ITE_FATREG').AsFloat;
    End;

  End;
  FreeAndNil(qryIteGer);
end;

function TOrdPro.fValidaSaldoLotesSubItens(fltQtdPro: Double = 0; blnExibeCodFabrica: Boolean = False; blnValidaRelSaldoInsuficienteNoLancamentoOP: Boolean = False) : Boolean;
var
  cdsItensErro : TcdsItensErro;
  frmVerificaEstoqueOrdPro: TfrmVerificaEstoqueOrdPro;
begin

  cdsItensErro := TcdsItensErro.Create(nil);
  try
    cdsIteEst.First;

    while not cdsIteEst.Eof do
    begin
      cdsItensErro.recItemAdd.strCodIte := cdsIteEst.FieldByName('ITESUB').AsString;
      cdsItensErro.recItemAdd.strDesIte := cdsIteEst.FieldByName('DESITE').AsString;
      cdsItensErro.recItemAdd.strNumLot := cdsIteEst.FieldByName('NUMLOT').AsString;
      cdsItensErro.recItemAdd.strCodFab := cdsIteEst.FieldByName('CODFAB').AsString;

      if blnValidaRelSaldoInsuficienteNoLancamentoOP Then
      Begin

        cdsItensErro.recItemAdd.fltQtdPro := cdsIteEst.FieldByName('QTDITE').AsFloat * fltQtdPro;

        cdsItensErro.recItemAdd.fltSalDis := fRetornaSaldoDisponivel(cdsIteEst.FieldByName('ITESUB').AsString, False, True, cdsIteEst.FieldByName('NUMLOT').AsString);
        if cdsItensErro.recItemAdd.fltSalDis <= cdsItensErro.recItemAdd.fltQtdPro then
          cdsItensErro.pAddItem('Saldo Insuficiente');

      End
      Else
      Begin

        cdsItensErro.recItemAdd.fltQtdPro := cdsIteEst.FieldByName('QTDPRO').AsFloat;

        //Valida: Se o lote cadastrado existe / Se o produto possui lote ou é wms, é obrigado informar na baixa / O saldo do lote selecionado quando configurado para isso
        if (not fEmptyStr(cdsIteEst.FieldByName('NUMLOT').AsString)) and (fCampoTabela('COUNT(0)', 'CADLOT', ['LOT_CODITE','LOT_NUMLOT', 'LOT_CODEMP'], [cdsIteEst.FieldByName('ITESUB').AsString, cdsIteEst.FieldByName('NUMLOT').AsString, VS_strCodEmp]) = 0) then
        begin
          cdsItensErro.blnApenasSaldo := False;
          cdsItensErro.recItemAdd.fltSalDis := 0;
          cdsItensErro.pAddItem('Lote Inválido');
        end
        else if (fUsaRotinaWMS or (cdsIteEst.FieldByName('LOTQTD').AsInteger > 0)) and fEmptyStr(cdsIteEst.FieldByName('NUMLOT').AsString) then
        begin
          cdsItensErro.blnApenasSaldo := False;
          cdsItensErro.recItemAdd.fltSalDis := 0;
          cdsItensErro.pAddItem('Obrigatório Informar o Lote');
        end
        else if (fCfgSis('SLD_OI') <> 'N') and (not fEmptyStr(cdsIteEst.FieldByName('NUMLOT').AsString)) and (cdsIteEst.FieldByName('SALDOS').AsFloat < cdsIteEst.fieldByName('QTDPRO').AsFloat) then
        begin
          cdsItensErro.recItemAdd.fltSalDis := cdsIteEst.FieldByName('SALDOS').AsFloat;
          cdsItensErro.pAddItem('Saldo Insuficiente');
        end;

     End;

      cdsIteEst.Next;
    end;

    Result := cdsItensErro.isEmpty;
    if (Not Result) And blnTransacao then
    begin
      try
        pCriarFormularios(TfrmVerificaEstoqueOrdPro, frmVerificaEstoqueOrdPro );
        frmVerificaEstoqueOrdPro.frxRelatorio.DataSet := cdsItensErro;
        frmVerificaEstoqueOrdPro.frxReport.Script.Variables['CODPRO'] := strCodPro;

        If blnExibeCodFabrica Then
        Begin
          If Assigned(frmVerificaEstoqueOrdPro.frxReport.FindComponent('memCodFab')) Then
            TfrxMemoView(frmVerificaEstoqueOrdPro.frxReport.FindComponent('memCodFab')).Visible   := True;

          If Assigned(frmVerificaEstoqueOrdPro.frxReport.FindComponent('memCodFabLabel')) Then
            TfrxMemoView(frmVerificaEstoqueOrdPro.frxReport.FindComponent('memCodFabLabel')).Visible   := True;
        End;

        pPreviewReport('frmVerificaEstoqueOrdPro', 'Impressão Ordem de Produção (validação saldo lotes subitens)', frmVerificaEstoqueOrdPro.frxReport);
        FreeAndNil(frmVerificaEstoqueOrdPro);

        //a configuração SLD_OI vale apenas para o saldo, por isso se tiver aviso de lote inválido ou item sem lote, não da a opção da mensagem
        if (fCfgSis('SLD_OI') = 'A') and (cdsItensErro.blnApenasSaldo) and (not blnValidaRelSaldoInsuficienteNoLancamentoOP) then
          Result := (fMensagem('AVISO', 'O saldo do lote de alguns produtos é insuficiente, deseja continuar?', ['','']) = 1);

      finally
        pFreeAndNil(frmObservacao);
      end;
    end;
  finally
    FreeAndNil(cdsItensErro);
  end;
end;


Function TOrdPro.fVerificaEstoqueLote(fltQtdPro: Double; blnExibeCodFabrica: Boolean = False): Boolean;
  Var
    qryOrdPro : TUniQuery;
    cdsItensErro : TcdsItensErro;
    frmVerificaEstoqueOrdPro: TfrmVerificaEstoqueOrdPro;
Begin

  qryOrdPro := fCriaQuery(nil);
  cdsItensErro := TcdsItensErro.Create(nil);
  Try
    With qryOrdPro, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT DOP_QTDITE                       AS QTDITE, ');
      Add('        DOP_ITESUB                       AS ITESUB, ');
      Add('        ITE_DESITE                       AS DESITE, ');
      Add('        ITE_CODFAB                       AS CODFAB, ');
      Add('        IFNULL(DOP_NUMLOT, L.LOT_NUMLOT) AS NUMLOT, ');
      Add('        0.00                             AS SALDIS, ');
      Add('        (SELECT COUNT(*) FROM CADLOT                ');
      Add('         WHERE LOT_CODEMP = :CODEMP                 ');
      Add('         AND   LOT_CODITE = DOP_ITESUB)  AS LOTQTD  ');
      Add(' FROM MOVPRO                  ');
      Add('   JOIN DETPRO ON DOP_SEQGER = MOVPRO.AUTOINCREM ');
      Add('   JOIN CADITE ON ITE_CODITE = DOP_ITESUB        ');
      Add(' LEFT JOIN CADLOT L ON DOP_ITESUB = LOT_CODITE   ');
      Add('                   AND LOT_PRIPRO = "S"          ');
      Add('                   AND LOT_CODEMP = :CODEMP      ');
      Add(' WHERE ');
      Add('  PRO_CODPRO = :CODPRO AND ');
      Add('  PRO_CODEMP = :CODEMP ');

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryOrdPro.Open;
    End;

    With qryOrdPro Do
    Begin
      First;
      While Not Eof Do
      Begin
        cdsItensErro.recItemAdd.strCodIte := FieldByName('ITESUB').AsString;
        cdsItensErro.recItemAdd.strDesIte := FieldByName('DESITE').AsString;
        cdsItensErro.recItemAdd.strNumLot := FieldByName('NUMLOT').AsString;
        cdsItensErro.recItemAdd.fltQtdPro := FieldByName('QTDITE').AsFloat * fltQtdPro;
        cdsItensErro.recItemAdd.strCodFab := FieldByName('CODFAB').AsString;

        If fEmptyStr(FieldByName('NUMLOT').AsString) Then
        begin
          if fUsaRotinaWMS then
          begin
            cdsItensErro.blnApenasSaldo := False;
            cdsItensErro.recItemAdd.fltSalDis := 0;
            cdsItensErro.pAddItem('Sem Lote Cadastrado');
          end
          else if FieldByName('LOTQTD').AsInteger > 0 then
          begin
            cdsItensErro.blnApenasSaldo := False;
            cdsItensErro.recItemAdd.fltSalDis := 0;
            cdsItensErro.pAddItem('Lote principal não informado');
          end;
        end;

        If fCfgSis('SLD_OI') <> 'N' then
        begin
          cdsItensErro.recItemAdd.fltSalDis := fRetornaSaldoDisponivel(FieldByName('ITESUB').AsString, False, True, FieldByName('NUMLOT').AsString)+cdsItensErro.recItemAdd.fltQtdPro;
          if cdsItensErro.recItemAdd.fltSalDis < cdsItensErro.recItemAdd.fltQtdPro then
            cdsItensErro.pAddItem('Saldo Insuficiente');
        end;


        Next;
      End;

      Result := cdsItensErro.IsEmpty;

      If (not Result) And (blnTransacao) Then
      Begin
        pCriarFormularios(TfrmVerificaEstoqueOrdPro, frmVerificaEstoqueOrdPro );
        frmVerificaEstoqueOrdPro.frxRelatorio.DataSet := cdsItensErro;
        frmVerificaEstoqueOrdPro.frxReport.Script.Variables['CODPRO'] := strCodPro;

        If blnExibeCodFabrica Then
        Begin
          If Assigned(frmVerificaEstoqueOrdPro.frxReport.FindComponent('memCodFab')) Then
            TfrxMemoView(frmVerificaEstoqueOrdPro.frxReport.FindComponent('memCodFab')).Visible   := True;

          If Assigned(frmVerificaEstoqueOrdPro.frxReport.FindComponent('memCodFabLabel')) Then
            TfrxMemoView(frmVerificaEstoqueOrdPro.frxReport.FindComponent('memCodFabLabel')).Visible   := True;
        End;

        pPreviewReport('frmVerificaEstoqueOrdPro', 'Impressão Ordem de Produção (validação saldo lotes)', frmVerificaEstoqueOrdPro.frxReport);
        FreeAndNil(frmVerificaEstoqueOrdPro);

        //a configuração SLD_OI vale apenas para o saldo, por isso se tiver aviso de lote inválido ou item sem lote, não da a opção da mensagem
        if (fCfgSis('SLD_OI') = 'A') and cdsItensErro.blnApenasSaldo then
          Result := (fMensagem('AVISO', 'O saldo do lote de alguns produtos é insuficiente, deseja continuar?', ['','']) = 1);

      End;

    End;

  Finally
    FreeAndNil(qryOrdPro);
    FreeAndNil(cdsItensErro);
  End;

End;

procedure TOrdPro.pGeraLoteSequencial(strCodItem: String = ''; strCodArma: String = ''; strCodEmpr: String = '');
begin
  Try
    if fEmptyStr(strCodItem) then
      strCodItem := FCodIte;

    if fEmptyStr(strCodArma) then
      strCodArma := FCodArm;

    if fEmptyStr(strCodEmpr) then
      strCodEmpr := FCodEmp;

    if fCfgsis('LOTORD', varBoolean) and (FCodArm = FCodPro) then
      If fCampoTabela('COUNT(0)', 'CADLOT', ['LOT_CODITE','LOT_NUMLOT', 'LOT_CODEMP'], [strCodItem, strCodArma, strCodEmpr]) = '0'  then
        pGerarLote(strCodArma, True);

  except
    On E: Exception Do
      pMensagensErro(E.Message, '[fGeraLoteSequencial]');
  end;

end;

procedure TOrdPro.pGerarLote(strNumLot : String; blnPriPro : boolean = False; strCodItem: String = '');
var
  qryCadLot : TUniQuery;
begin
  if fEmptyStr(strCodItem) then
    strCodItem := FCodIte;

  qryCadLot := fCriaQuery(nil);
  try
    try
      qryCadLot.SQL.Add('INSERT INTO ');
      qryCadLot.SQL.Add('  CADLOT');
      qryCadLot.SQL.Add('SET');
      qryCadLot.SQL.Add('   AUTOINCREM = :AUTINC ');
      qryCadLot.SQL.Add('  ,LOT_NUMLOT = :NUMLOT ');
      qryCadLot.SQL.Add('  ,LOT_CODITE = :CODITE ');
      qryCadLot.SQL.Add('  ,LOT_CODEMP = :CODEMP ');
      qryCadLot.SQL.Add('  ,LOT_DTAFAB = :DTAFAB ');
      qryCadLot.SQL.Add('  ,LOT_DTAVAL = :DTAVAL ');
      qryCadLot.SQL.Add('  ,LOT_PRIPRO = ' +IIF(blnPriPro, QuotedStr('S'), QuotedStr('N')));

      qryCadLot.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADLOT', VS_strCodEmp);
      qryCadLot.ParamByName('NUMLOT').AsString   := strNumLot;
      qryCadLot.ParamByName('CODITE').AsString   := FCodIte;
      qryCadLot.ParamByName('CODEMP').AsString   := FCodEmp;
      qryCadLot.ParamByName('DTAFAB').AsDateTime := VS_Date;
      qryCadLot.ParamByName('DTAVAL').AsDateTime := IncMonth(VS_Date, StrToIntDef(fCampoTabela('ITE_PRAVAL', 'CADITE', ['ITE_CODITE'], [FCodIte]), 0));

      qryCadLot.ExecSQL;

      if blnPriPro then
        TCadLot.pAjustaArmPrincipalProducao(strNumLot, strCodItem);

    finally;
      FreeAndNil(qryCadLot);
    end;
  except
    Raise;
  end;
end;


procedure TOrdPro.pAddArrLotes(strNumLot : String; fltQtd : Real);
begin
  SetLength(arrLotes, Length(arrLotes) + 1);
  arrLotes[High(arrLotes)].strNumLot := strNumLot;
  arrLotes[High(arrLotes)].fltQtd    := fltQtd;
end;

{**************************************}
{* BAIXA ORDEM DE PRODUÇÃO            *}
{***********************************AF*}
function TOrdPro.fBaixaOrdPro(fltQtdPro: Double; strConfer: String; blnGerarEstoque: Boolean = True): Boolean;
  Var
    strDocNov: String;
    strAutInc: String;
    strIncDet: String;
    strDescri: String;
    strRefere: String;
    strMarca : String;
    strUnidad: String;
    recServicos: TDadosServicos;
    blnBAORDP : Boolean;
    i        : Integer;
    arrDuplic : TarrDuplicata;
    strAutIncProdAca: String;
    blnBaixaTotal: Boolean;
    qryIteGer: TUniQuery;
    fltTotCus,
    fltTotMed,
    fltPreUlt,
    fltSaldosOriginalProdutoEstrutura,fltPreMedOriginalProdutoEstrutura,
    fltUltImp: Double;

    LClafis : String;
    LEntSai : String;
    LFulRegrasMovEstoque          : FulfillmentRegrasMovimentacaoEstoque;
    LDeveMovimentarEstoqueExterno : Boolean;
    strFiltroItensCorrecao: String;
    fltQtdDet: Double;

    function GerarEstoque : Boolean;
    Begin

      Result := False;

      If FFulfillment.EhOperacaoFulFillment And fItemEstrutura(strCodIte) And MatchStr(fCfgSis('BXSBIT'), ['2','3']) Then
        Exit;

      Result := blnGerarEstoque And (Not fOrigemOrdemProducaoEhPorArquivoDeImportacao(strCodPro, VS_strCodEmp));

    End;

Begin

  fltSaldosOriginalProdutoEstrutura := 0;
  fltPreMedOriginalProdutoEstrutura := 0;

  if fExisteNivelInferiorSemBaixa(FAutInc) then
  Begin
    If (blnTransacao) Then
    Begin
      fMensagem('ATENÇÃO', 'Não é possível baixar uma ordem de produção que tenha ordem de produção de nivel inferior em aberto', ['&OK']);
      TfrmExibeArvoreOrdProd.pExibeArvore(FCodPro);
      Result := False;
      Exit;
    End
    Else
      Raise EBaixaOrdemProducao.Create('Não é possível baixar uma ordem de produção que tenha ordem de produção de nivel inferior em aberto');
  End;

  If (Not blnFaturamento) and (Not fVerificaEstoqueLote(fltQtdPro)) Then
  Begin
    If (blnTransacao) Then
    Begin
      fMensagem('', 'Existem Itens sem Saldo no Estoque, não é Possível efetuar a Baixa!', ['OK']);
      Result := False;
      Exit;
    End
    Else
      Raise EBaixaOrdemProducao.Create('Existem Itens sem Saldo no Estoque, não é Possível efetuar a Baixa!');
  End;

  Try

    If (fCfgSis('ATPCPM') = 'S') Then
    Begin
      fltSaldosOriginalProdutoEstrutura := fCampoTabela('ITE_SALDOS', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [FCodIte, FCodEmp]);
      fltPreMedOriginalProdutoEstrutura := fCampoTabela('ITE_PREMED', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [FCodIte, FCodEmp]);
    End;

    If blnTransacao Then
      fStartTransaction;

    blnBAORDP := (fCfgSis('BAORDP', varInteger) = 0);
    blnBaixaTotal := False;
    Result := True;

    pAtuDados;

    pRetDadosItem(strCodIte, strDescri, strRefere, strMarca, strUnidad);
    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    //quandoconfigurado para utilizar o número da op como lote, cadastra o lote se ainda não houver no banco de dados
    pGeraLoteSequencial;

    //monta o array dos lotes
    setLength(arrLotes, 0);
    if objLotInd.cdsLotInd.isEmpty then
    begin

      if fEmptyStr(FCodArm) then
        if fUsaRotinaWMS Or (TCadLot.ProdutoTemLote(strCodIte)) then
          if fConsideraLoteEstoqueExternoSubProdutosFulfillment then
            FCodArm := TCadLot.GeraNumeroLoteEstoqueExterno(Fulfillment.CodigoDoEstoqueExterno);

      pAddArrLotes(FCodArm, fltQtdPro);

    end
    else
    begin
      objLotInd.cdsLotInd.First;
      while not objLotInd.cdsLotInd.Eof do begin
        pAddArrLotes(objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString, objLotInd.cdsLotInd.FieldByName('QTD').AsFloat);

        //SE O LOTE NÃO EXISTIR, CADASTRA NA CADLOT
        If fCampoTabela('COUNT(0)', 'CADLOT', ['LOT_CODITE','LOT_NUMLOT', 'LOT_CODEMP'], [FCodIte, objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString, FCodEmp]) = '0' then
          pGerarLote(objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString);

        objLotInd.cdsLotInd.next;
      end;
    end;

    {*****************************}
    {* BAIXA A ORDEM DE PRODUÇÃO *}
    {**************************AF*}
    With qryOrdPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE                                                   ');
      SQL.Add('  MOVPRO                                                 ');
      SQL.Add('SET                                                      ');
      SQL.Add('/* FQtdApr = ' + FloatToStr(FQtdApr)  + ' fltQtdPro =  ' + FloatToStr(fltQtdPro) +' */');

      If (FQtdApr <= fltQtdPro) or (fCfgSis('BXOPPA', varString) = 'B') Then
      Begin
        SQL.Add('  PRO_DTABAI = ' + fCurrentDate + ',                   ');
        SQL.Add('  PRO_HORBAI = ' + FormatDateTime('hhmmss', fTime()) + ', ');
      End;

      If Not fEmptyStr(FCodArm) Then
      begin
        SQL.Add('  PRO_NUMLOT = :NUMLOT,                                ');
        ParamByName('NUMLOT').AsString := FCodArm;
      end;

      SQL.Add('  PRO_QTDPRO = IFNULL(PRO_QTDPRO,0) + :QTDPRO,           ');
      SQL.Add('  PRO_CONFER = :CONFER                                   ');


      SQL.Add('WHERE                                                    ');
      SQL.Add('  PRO_CODPRO = :CODPRO AND                               ');
      SQL.Add('  PRO_CODEMP = :CODEMP                                   ');

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ParamByName('QTDPRO').AsFloat  := fltQtdPro;
      ParamByName('CONFER').AsString := strConfer;

      ExecSQL;
      Close;
    End;

    If (GerarEstoque) Then
    Begin
      strDocNov := fRetSequencial('PRO_OP', VS_strCodEmp, fTamDocCadRec);
      blnBaixaTotal:= FQtdApr <= fltQtdPro;
      strAutIncProdAca := '';

      LEntSai := 'E';
      LClafis := '1999';

      LFulRegrasMovEstoque.Limpar;

      If Fulfillment.EhOperacaoFulfillment Then
        LFulRegrasMovEstoque := FulfillmentMovimentacaoEstoque(Fulfillment.ClassificacaoFiscal,
                                                               Fulfillment.ChaveDeAcesso,
                                                               Fulfillment.SiglaHubMarketPlace);

      {**************************************}
      {* GRAVA MOVGER                       *}
      {***********************************AF*}
      If Not fGravaMovGer(strAutInc,
                          strDocNov,
                          'OP',
                          VS_strCodEmp,
                          '',
                          strLoginUsuarioLogado,
                          '',
                          strCodCli,
                          'C',
                          IIF(blnBAORDP, FDtaCad, VS_Date),
                          fTime(),
                          IIF(blnBAORDP, FDtaCad, VS_Date),
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
                          'BAIXA DE ORDEM DE PRODUÇÃO',
                          '',
                          '',
                          '',
                          '',
                          False,
                          '',
                          '',
                          '',  // Empresa do Faturamento
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
                          LClafis,
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
                          strCodPro,
                          0,
                          0.0,
                          0,
                          '',          // Consumidor final
                          'N',
                          '',
                          '',          // Operador da Expedição
                          '',          // Separador da Expedição
                          '',          // tabela de precos utilizada
                          '',
                          'N',        // Entrega Futura
                          FALSE,      // Baixa de Entrega Futura
                          0,          // Margem de Lucro
                          0.0,        // Base do retido (caso tivesse) com ipi e frete de entrada
                          0.0,        // Valor do retido considerando a base acima.
                          'N',        // Gerar produção fora da loja
                          '',         // Numero do Registro - Correios ou Transportadora
                          VS_Date,    // Data de Entrega no Romaneio
                          '',         // Classificação fiscal 4
                          'N',        // AUTO-SERVIÇO
                          '',         //Evento
                          FEndEnt,    // AUTOINC DO ENDEREÇO DE ENTREGA
                          '',         // Conteúdo do CNFNFE
                          '',         // Motivo da Devolução
                          '',
                          True) Then  // Imprime Duplicatas na NF-e
      Begin
        Result := False;
        If blnTransacao Then
          fRollBack;
        Exit;
      End;

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

      for i := 0 to High(arrLotes) do
      begin

        strIncDet := '';
        {*************************************}
        {* GRAVA MOVDET                      *}
        {**********************************AF*}
        qryIteGer:= fCriaQuery;
        Try
          qryIteGer.SQL.Clear;
          qryIteGer.SQL.Add('SELECT ITE_PREULT, ITE_IMPULT, ITE_PREMED, ITE_SALDOS, ');
          qryIteGer.SQL.Add(' ITE_PRECUS, ITE_ICMSAI, ITE_IMPFED, ITE_DESOPE, ITE_OUTVAL FROM ITEGER');
          qryIteGer.SQL.Add('WHERE');
          qryIteGer.SQL.Add('  ITE_CODITE = :CODITE AND ');
          qryIteGer.SQL.Add('  ITE_CODEMP = :CODEMP     ');

          qryIteGer.ParamByName('CODITE').AsString := strCodIte;
          qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;

          qryIteGer.Open;


          fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat;
          fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat;
          fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat;
          fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                         qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                         qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                         qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                         qryIteGer.FieldByName('ITE_OUTVAL').AsFloat);

          LDeveMovimentarEstoqueExterno := fDeveMovimentarEstoqueExterno(LFulRegrasMovEstoque);

          If Not fGravaMovDet(strIncDet,
                              strAutInc,
                              strDocNov,
                              'OP',
                              VS_strCodEmp,
                              strCodIte,
                              strLoginUsuarioLogado,
                              '',
                              strMarca,
                              '',
                              strCodCli,
                              IIF(blnBAORDP, FDtaCad, VS_Date),
                              fTime(),
                              IIF(blnBAORDP, FDtaCad, VS_Date),
                              '01000',
                              'C',
                              '',
                              strDescri,
                              strRefere,
                              strUnidad,
                              '',
                              arrLotes[i].fltQtd,
                              0,
                              0,
                              0,
                              0,
                              0,
                              fltTotCus,
                              fltTotMed,
                              0,
                              0,
                              0,
                              '',
                              '',
                              0,
                              0,
                              0,
                              LClafis,
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
                              False,
                              '',
                              '',
                              '', // Empresa do Faturamento
                              0,
                              '',
                              '',
                              0,
                              'NOR',
                              '',
                              '',
                              0,
                              'N',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              0,
                              '',
                              0,
                              0,
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              '',
                              '',
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              strCodPro,
                              '',
                              '',
                              0,
                              0,
                              0.0,
                              '',
                              '',
                              False,
                              fDeveMovimentarEstoqueFisico(LFulRegrasMovEstoque).ToFilKar, //blnFilKar
                              '',                                                             //  Especie da Entrega Fututa
                              '',                                                             //  Documento da Entrega Fututa
                              '',
                              '',                                                             //  Empresa da Entrega Fututa
                              '',
                              '',
                              '',
                              '',
                              0.0,
                              '',
                              0.0,
                              0.0,
                              0,
                              'N',
                              '',
                              0,
                              0,
                              0,
                              0,
                              '',
                              arrLotes[i].strNumLot, // strNumLot
                              'N', // strPigBas
                              0,
                              0,
                              0,
                              fltPreUlt,
                              fltUltImp,
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
                              '',
                              '',
                              '',
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
                              0,
                              0,
                              'P',
                              0,
                              0,
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
                              '',
                              0,
                              0,
                              '',
                              'N',
                              'N',
                              0,
                              0,
                              0,
                              '',
                              'N',
                              0,
                              '',
                              0,
                              'N',
                              '',
                              'NOR',
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
                              '',
                              0,
                              0,
                              0,
                              '',
                              'N',
                              '',
                              '',
                              0,
                              '',
                              '',
                              0,
                              0,
                              0,
                              0,
                              '',
                              'N',
                              '',
                              'N',
                              0,
                              0,
                              '',
                              0,
                              0,
                              0,
                              False,
                              0,
                              '',
                              0,
                              0,
                              0,
                              '',
                              '',
                              '',
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              '',
                              0,
                              0,
                              '',
                              '',
                              '',
                              0,
                              0,
                              0,
                              0,
                              IIF(fConsideraLoteEstoqueExternoSubProdutosFulfillment, 'S', ''), //strExtFul
                              IIF(fConsideraLoteEstoqueExternoSubProdutosFulfillment, Fulfillment.CodigoDoEstoqueExterno, ''), //strCodExt
                              0,
                              0,
                              '',
                              '',
                              0,
                              0,
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
                              False,
                              '',
                              '',
                              '',
                              '',
                              False,
                              '',
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              0,
                              False,
                              0,
                              0,
                              0,
                              0,
                              0,
                              'N',
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              'N',
                              '',
                              '',
                              '',
                              0,
                              0,
                              False,
                              LDeveMovimentarEstoqueExterno.ToFilFul, //blnFilFul
                              False,
                              '',
                              0,
                              FFulfillment.SiglaHubMarketPlace,
                              0,
                              IIF(LDeveMovimentarEstoqueExterno, LFulRegrasMovEstoque.EntradaSaida, ''), //strFilFul_EntSai
                              '',                               //strIncOri: String = '';
                              '',                               //strTckQbt: String = '';
                              'N',                              //strEntTri: String = 'N';
                              '',                               //strFulDif: String = '';
                              FFulfillment.ClassificacaoFiscal  //strClaFat: String = '';
                             ) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;
        Finally
          FreeAndNil(qryIteGer);
        End;

        {*************************************}
        {* ATUALIZA SALDO                    *}
        {**********************************AF*}
        If fDeveMovimentarEstoqueFisico(LFulRegrasMovEstoque) Then
        Begin
          If Not fAtualizaEstoqueCadIte(strCodIte,
                                        LEntSai,
                                        arrLotes[i].fltQtd,
                                        0.0,
                                        arrLotes[i].strNumLot,
                                        False) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;
        End;

        strAutIncProdAca:= strIncDet;
        ReprocessarItem(strCodIte, '', False);

      end;
    End;

    {***************************************}
    {* ATUALIZA SALDO DOS PROD. ESTRUTURAS *}
    {************************************AF*}
    With qryOrdPro Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add('SELECT ');
      SQL.Add('  DETPRO.* ');

      If MatchStr(fCfgSis('MLAYOP', varString), ['5','6']) Then
        SQL.Add(', IF(IFNULL(ITE_DENSID, 1) <= 0, 1, IFNULL(ITE_DENSID, 1)) AS DENSID ')
      Else
        SQL.Add(', 1 AS DENSID ');

      SQL.Add(', IFNULL(DOP_NUMLOT, LOT_NUMLOT) AS NUMLOT');
      SQL.Add('FROM ');
      SQL.Add('  MOVPRO ');
      SQL.Add('  JOIN DETPRO ON DOP_SEQGER = MOVPRO.AUTOINCREM ');

      If MatchStr(fCfgSis('MLAYOP', varString), ['5','6']) Then
      Begin
        SQL.Add(' LEFT JOIN CADITE ON ITE_CODITE = DOP_ITESUB ');
      End;

      SQL.Add('LEFT JOIN CADLOT L ON DOP_ITESUB = LOT_CODITE AND');

      If fConsideraLoteEstoqueExternoSubProdutosFulfillment Then
        SQL.Add('  LOT_NUMLOT = ' + QuotedStr(TCadLot.GeraNumeroLoteEstoqueExterno(Fulfillment.CodigoDoEstoqueExterno)) + ' AND ')
      Else
        SQL.Add('  LOT_PRIPRO = "S" AND');

      SQL.Add('  LOT_CODEMP = ' + QuotedStr(VS_strCodEmp));

      SQL.Add('WHERE ');
      SQL.Add('  PRO_CODPRO = :CODPRO AND ');
      SQL.Add('  PRO_CODEMP = :CODEMP ');

      strFiltroItensCorrecao := fGetItensCorrecao;
      If blnMonFas And (Not fEmptyStr(strFiltroItensCorrecao)) Then
        SQL.Add(' AND DETPRO.AUTOINCREM NOT IN (' + strFiltroItensCorrecao + ')');

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      strDocNov := fRetSequencial('PRO_OP', VS_strCodEmp, fTamDocCadRec);
      strAutInc := '';
      fltPreCus := 0;
      fltPreCom := 0;
      fltTotPreMed := 0;
      fltTotImpUlt := 0;
      fltTotPreUlt := 0;

      {**************************************}
      {* GRAVA MOVGER DOS SUBITENS          *}
      {***********************************AF*}

      LEntSai := IIF(fDocumentoEhSaida, 'S', 'E');
      LClafis := IIF(LEntSai = 'S', '5999', '1999');

      LFulRegrasMovEstoque.Limpar;

      If Fulfillment.EhOperacaoFulfillment Then
        LFulRegrasMovEstoque := FulfillmentMovimentacaoEstoque(Fulfillment.ClassificacaoFiscal,
                                                               Fulfillment.ChaveDeAcesso,
                                                               Fulfillment.SiglaHubMarketPlace);

      If Not fGravaMovGer(strAutInc,
                          strDocNov,
                          'OP',
                          VS_strCodEmp,
                          '',
                          strLoginUsuarioLogado,
                          '',
                          strCodCli,
                          'C',
                          IIF(blnBAORDP, FDtaCad, VS_Date),
                          fTime(),
                          IIF(blnBAORDP, FDtaCad, VS_Date),
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
                          'BAIXA DE ORDEM DE PRODUÇÃO',
                          '',
                          '',
                          '',
                          '',
                          IIF(Fulfillment.EhOperacaoFulfillment, True, False),   //blnJafatu
                          IIF(Fulfillment.EhOperacaoFulfillment, strEspDoc, ''), //strTipFat
                          IIF(Fulfillment.EhOperacaoFulfillment, strNumDoc, ''), //strNumFat
                          IIF(Fulfillment.EhOperacaoFulfillment, strCodEmp, ''), //strEmpFat
                          IIF(Fulfillment.EhOperacaoFulfillment, Fulfillment.DataDeEntrada, 0),  //dtaDtaFat
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
                          LClafis,
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
                          strCodPro,
                          0,
                          0.0,
                          0,
                          '',          // Consumidor final
                          'N',
                          IIF(Fulfillment.EhOperacaoFulfillment, strCodCli, ''), //strCliFat
                          '',          // Operador da expedição
                          '',          // Separador da Expedição
                          '',
                          '',
                          'N',         // Entrega Futura
                          FALSE,       // Baixa de Entrega Futura
                          0,           // Margem de Lucro
                          0.0,         // Base do retido (caso tivesse) com ipi e frete de entrada
                          0.0,         // Valor do retido considerando a base acima.
                          'N',         // Gerar produção fora da loja
                          '',          // Numero do Registro - Correios ou Transportadora
                          VS_Date,     // Data de Entrega no Romaneio
                          '',          // Classificação fiscal 4
                          'N',         // AUTO-SERVICO
                          '',          // Evento
                          FEndEnt,     // AUTOINC DO ENDEREÇO DE ENTREGA
                          '',          // Conteúdo do CNFNFE
                          '',          // Motivo da Devolução
                          '',
                          True) Then   // Imprime Duplicatas na NF-e
      Begin
        Result := False;
        If blnTransacao Then
          fRollBack;
        Exit;
      End;

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

      pPreAltDefineVariaveisAltPre(fNow, 'ORDEM DE PRODUCAO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);


      While Not Eof Do
      Begin

        strIncDet := '';
        pRetDadosItem(FieldByName('DOP_ITESUB').AsString, strDescri, strRefere, strMarca, strUnidad);

        qryIteGer:= fCriaQuery;
        Try
          qryIteGer.SQL.Clear;
          qryIteGer.SQL.Add('SELECT ITE_PREULT, ITE_IMPULT, ITE_PREMED, ITE_SALDOS, ');
          qryIteGer.SQL.Add(' ITE_PRECUS, ITE_ICMSAI, ITE_IMPFED, ITE_DESOPE, ITE_OUTVAL FROM ITEGER');
          qryIteGer.SQL.Add('WHERE');
          qryIteGer.SQL.Add('  ITE_CODITE = :CODITE AND ');
          qryIteGer.SQL.Add('  ITE_CODEMP = :CODEMP     ');

          qryIteGer.ParamByName('CODITE').AsString := FieldByName('DOP_ITESUB').AsString;
          qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;

          qryIteGer.Open;

          If (fCfgSis('ATPCPM') = 'S') Then
          Begin
            If cdsDataSetQtdEditadaOrdPro.Locate('CODITE', FieldByName('DOP_ITESUB').AsString, []) Then
            Begin
              fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * (fltQtdPro * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * (fltQtdPro * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * (fltQtdPro * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                            qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                            qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                            qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                            qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * (fltQtdPro * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
            End
            Else
            Begin
              fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * (fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * (fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * (fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                             qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                             qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                             qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                             qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * (fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
            End

          End
          Else
          Begin

              fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * (fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * (fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * (fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
              fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                             qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                             qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                             qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                             qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * (fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat));
          End;

          LDeveMovimentarEstoqueExterno := fDeveMovimentarEstoqueExterno(LFulRegrasMovEstoque);

          fltQtdDet := fltQtdPro * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat);

          If (Not fEmptyStr(FieldByName('DOP_SEQFAS').AsString)) Then
          begin
            fltQtdDet := Abs(FieldByName('DOP_QTDITE').AsFloat);
            If FieldByName('DOP_QTDITE').AsFloat < 0 Then
            begin
              If (LEntSai = 'S') then
              begin
                LEntSai := 'E';
                LClafis := '1999';
              end
              Else
              begin
                LEntSai := 'S';
                LClafis := '5999';
              end;
            end;
          end;

          If Not fGravaMovDet(strIncDet,
                              strAutInc,
                              strDocNov,
                              'OP',
                              VS_strCodEmp,
                              FieldByName('DOP_ITESUB').AsString,
                              strLoginUsuarioLogado,
                              '',
                              strMarca,
                              '',
                              strCodCli,
                              IIF(blnBAORDP, FDtaCad, VS_Date),
                              fTime(),
                              IIF(blnBAORDP, FDtaCad, VS_Date),
                              '01000',
                              'C',
                              '',
                              strDescri,
                              strRefere,
                              strUnidad,
                              '',
                              fltQtdDet,
                              0,
                              0,
                              0,
                              0,
                              0,
                              fltTotCus,
                              fltTotMed,
                              0,
                              0,
                              0,
                              '',
                              '',
                              0,
                              0,
                              0,
                              LClafis,
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
                              IIF(Fulfillment.EhOperacaoFulfillment, True, False),   //blnJafatu
                              IIF(Fulfillment.EhOperacaoFulfillment, strEspDoc, ''), //strTipFat
                              IIF(Fulfillment.EhOperacaoFulfillment, strNumDoc, ''), //strNumFat
                              IIF(Fulfillment.EhOperacaoFulfillment, strCodEmp, ''), //strEmpFat
                              IIF(Fulfillment.EhOperacaoFulfillment, Fulfillment.DataDeEntrada, 0),  //dtaDtaFat
                              '',
                              '',
                              0,
                              'NOR',
                              '',
                              '',
                              0,
                              'N',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              0,
                              '',
                              0,
                              0,
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              '',
                              '',
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              strCodPro,
                              '',
                              IIF(Fulfillment.EhOperacaoFulfillment, strCodCli, ''), //strCliFat
                              0,
                              0,
                              0.0,
                              '',
                              '',
                              False,
                              fDeveMovimentarEstoqueFisico(LFulRegrasMovEstoque).ToFilKar, //blnFilKar
                              '',                                                             //  Especie da Entrega Fututa
                              '',                                                             //  Documento da Entrega Fututa
                              '',
                              '',                                                             //  Empresa da Entrega Fututa
                              '',
                              '',
                              '',
                              '',
                              0.0,
                              '',
                              0.0,
                              0.0,
                              0,
                              'N',
                              '',
                              0,
                              0,
                              0,
                              0,
                              '',
                              FieldByName('NUMLOT').AsString, // strNumLot
                              'N', // strPigBas
                              0,
                              0,
                              0,
                              fltPreUlt,
                              fltUltImp,
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
                              '',
                              '',
                              '',
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
                              0,
                              0,
                              'P',
                              0,
                              0,
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
                              '',
                              0,
                              0,
                              '',
                              'N',
                              'N',
                              0,
                              0,
                              0,
                              '',
                              'N',
                              0,
                              '',
                              0,
                              'N',
                              '',
                              'NOR',
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
                              '',
                              0,
                              0,
                              0,
                              '',
                              'N',
                              '',
                              '',
                              0,
                              '',
                              '',
                              0,
                              0,
                              0,
                              0,
                              '',
                              'N',
                              '',
                              'N',
                              0,
                              0,
                              '',
                              0,
                              0,
                              0,
                              False,
                              0,
                              '',
                              0,
                              0,
                              0,
                              '',
                              '',
                              '',
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              '',
                              0,
                              0,
                              '',
                              '',
                              '',
                              0,
                              0,
                              0,
                              0,
                              IIF(fConsideraLoteEstoqueExternoSubProdutosFulfillment, 'S', ''), //strExtFul
                              IIF(fConsideraLoteEstoqueExternoSubProdutosFulfillment, Fulfillment.CodigoDoEstoqueExterno, ''), //strCodExt
                              0,
                              0,
                              '',
                              '',
                              0,
                              0,
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
                              False,
                              '',
                              '',
                              '',
                              '',
                              False,
                              '',
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              0,
                              False,
                              0,
                              0,
                              0,
                              0,
                              0,
                              'N',
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              'N',
                              '',
                              '',
                              '',
                              0,
                              0,
                              False,
                              LDeveMovimentarEstoqueExterno.ToFilFul, //blnFilFul
                              False,
                              '',
                              0,
                              FFulfillment.SiglaHubMarketPlace,
                              0,
                              IIF(LDeveMovimentarEstoqueExterno, LFulRegrasMovEstoque.EntradaSaida, ''), //strFilFul_EntSai
                              '',                               //strIncOri: String = '';
                              '',                               //strTckQbt: String = '';
                              'N',                              //strEntTri: String = 'N';
                              '',                               //strFulDif: String = '';
                              FFulfillment.ClassificacaoFiscal  //strClaFat: String = '';
                             ) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;

        Finally
          FreeAndNil(qryIteGer);
        End;

        If fDeveMovimentarEstoqueFisico(LFulRegrasMovEstoque) Then
        Begin
          If Not fAtualizaEstoqueCadIte(FieldByName('DOP_ITESUB').AsString,
                                        LEntSai,
                                        fltQtdDet,
                                        0.0,
                                        FieldByName('NUMLOT').AsString,
                                        False) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;
        End;

        ReprocessarItem(FieldByName('DOP_ITESUB').AsString, '', False);

        {**********************************************}
        {* CALCULA PREÇO DE COMPRA DO PRODUTO ACABADO *}
        {*******************************************RV*}
        If (fCfgSis('APORPR') = 'S') Then
          fltPreCom := fltPreCom + (fRetPrecoCustoIte(FieldByName('DOP_ITESUB').AsString) * (FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat) );

        If (fCfgSis('ATPCPM') = 'S') Then
        Begin
          If cdsDataSetQtdEditadaOrdPro.Locate('CODITE', FieldByName('DOP_ITESUB').AsString, []) Then
          Begin
            fltTotPreUlt := fltTotPreUlt + (fRetPrecoUltimaCompra(FieldByName('DOP_ITESUB').AsString, VS_strCodEmp) * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat));
            fltTotImpUlt := fltTotImpUlt + (fRetPrecoUltimaCompraImpostos(FieldByName('DOP_ITESUB').AsString, VS_strCodEmp) * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat));
          End
          Else
          Begin
            fltTotPreUlt := fltTotPreUlt + (fRetPrecoUltimaCompra(FieldByName('DOP_ITESUB').AsString, VS_strCodEmp) * ((FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat)));
            fltTotImpUlt := fltTotImpUlt + (fRetPrecoUltimaCompraImpostos(FieldByName('DOP_ITESUB').AsString, VS_strCodEmp) * ((FieldByName('DOP_QTDITE').AsFloat * FieldByName('DENSID').AsFloat)));
          End;

        End;


        Next;
      End;

      If (fCfgSis('ATPCPM') = 'S') Then
      Begin
        fltTotPreMed := fRetornaPrecoMedio(fltQtdPro,fltSaldosOriginalProdutoEstrutura,fltPreMedOriginalProdutoEstrutura );
        If Not(fSalvaDadosItemMovPro(fRetornaAutIncMovPro(FCodIte, FCodPro, VS_strCodEmp), FCodIte)) Then
        Begin
          Result := False;
          If blnTransacao Then
            fRollBack;
          Exit;
        End;

      End;

      {**********************************************}
      {* GRAVA PREÇOS DO PRODUTO ACABADO            *}
      {*******************************************RV*}
      If (fCfgSis('APORPR') = 'S') Then
      Begin
        If Not fAtuPrecosProAca(strCodIte, fltQtdPro, strAutIncProdAca, blnBaixaTotal) Then
        Begin
          Result := False;
          If blnTransacao Then
            fRollBack;
          Exit;
        End;
      End;
      strAgrupadorPreAlt := '';

      Close;
    End;

    If blnMonFas And Assigned(FcdsItensDefinidosCorrecao) Then
      Result := Result And fDefinirCorrecoesFases;

    If blnTransacao Then
    Begin
      If Result Then
        fCommit
      Else
        fRollBack;
    End;

    if Result And blnTransacao then
    begin
      pImprimeEtiqueta(fltQtdPro);
      If blnTransacao Then
        fMensagem('','Ordem de produção baixada com sucesso!',['&OK']);
    end;


  Except
    On E: Exception Do
    Begin
      If blnTransacao Then
        fRollBack;
      strAgrupadorPreAlt := '';

      Raise Exception.Create(E.Message);
    End;
  End;
End;

{**************************************}
{* BAIXA ORDEM DE PRODUÇÃO            *}
{***********************************RV*}
function TOrdPro.fBaixaOrdPro2(fltQtdPro: Double; strConfer: String; blnGerarEstoque: Boolean): Boolean;
  Var
    strDocNov: String;
    strAutInc: String;
    strIncDet: String;
    strDescri: String;
    strRefere: String;
    strMarca : String;
    strUnidad: String;
    recServicos: TDadosServicos;
    qryAux : TUniQuery;
    intLote : Integer;
    arrDuplic : TarrDuplicata;
    blnBAORDP : Boolean;
    strAutIncProdAca: String;
    blnBaixaTotal: Boolean;
    qryIteGer: TUniQuery;
    fltTotCus,
    fltTotMed,
    fltPreUlt,
    fltSaldosOriginalProdutoEstrutura,fltPreMedOriginalProdutoEstrutura,
    fltUltImp: Double;
    cdsData: TUniClientDataSet;
Begin

  fltSaldosOriginalProdutoEstrutura := 0;
  fltPreMedOriginalProdutoEstrutura := 0;

  if fExisteNivelInferiorSemBaixa(FAutInc) then
  Begin
    If (blnTransacao) Then
    Begin
      fMensagem('ATENÇÃO', 'Não é possível baixar uma ordem de produção que tenha ordem de produção de nivel inferior em aberto', ['&OK']);
      TfrmExibeArvoreOrdProd.pExibeArvore(FCodPro);
      Result := False;
      Exit;
    End
    Else
      Raise EBaixaOrdemProducao.Create('Não é possível baixar uma ordem de produção que tenha ordem de produção de nivel inferior em aberto');
  End;

  //valida lotes dos subitens, editados no grid
  if not fValidaSaldoLotesSubItens then
  begin
    Result := False;
    exit;
  end;

  If (Not blnFaturamento) and (Not fVerificaEstoqueLote(fltQtdPro)) Then
  Begin
    If (blnTransacao) Then
    Begin
      fMensagem('', 'Existem Itens sem Saldo no Estoque, não é Possível efetuar a Baixa!', ['OK']);
      Result := False;
      Exit;
    End
    Else
      Raise EBaixaOrdemProducao.Create('Existem Itens sem Saldo no Estoque, não é Possível efetuar a Baixa!');
  End;

  Try

    If (fCfgSis('ATPCPM') = 'S') Then
    Begin
      fltSaldosOriginalProdutoEstrutura := fCampoTabela('ITE_SALDOS', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [FCodIte, FCodEmp]);
      fltPreMedOriginalProdutoEstrutura := fCampoTabela('ITE_PREMED', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [FCodIte, FCodEmp]);
    End;

    If blnTransacao Then
      fStartTransaction;

    blnBAORDP    := (fCfgSis('BAORDP', varInteger) = 0);
    blnBaixaTotal:= False;
    Result := True;
    cdsData:= Nil;

    pAtuDados;

    pRetDadosItem(strCodIte, strDescri, strRefere, strMarca, strUnidad);
    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    //quandoconfigurado para utilizar o número da op como lote, cadastra o lote se ainda não houver no banco de dados
    pGeraLoteSequencial;

    //monta o array dos lotes
    setLength(arrLotes, 0);
    if objLotInd.cdsLotInd.isEmpty then
      pAddArrLotes(FCodArm, fltQtdPro)
    else
    begin
      objLotInd.cdsLotInd.First;
      while not objLotInd.cdsLotInd.Eof do begin
        pAddArrLotes(objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString, objLotInd.cdsLotInd.FieldByName('QTD').AsFloat);

        //SE O LOTE NÃO EXISTIR, CADASTRA NA CADLOT
        If fCampoTabela('COUNT(0)', 'CADLOT', ['LOT_CODITE','LOT_NUMLOT', 'LOT_CODEMP'], [FCodIte, objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString, FCodEmp]) = '0' then
          pGerarLote(objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString);

        objLotInd.cdsLotInd.next;
      end;
    end;

    {*****************************}
    {* BAIXA A ORDEM DE PRODUÇÃO *}
    {**************************RV*}

    With qryOrdPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE                                         ');
      SQL.Add('  MOVPRO                                       ');
      SQL.Add('SET                                            ');

      If (FQtdApr <= fltQtdPro) or (fCfgSis('BXOPPA', varString) = 'B') Then
      Begin
        SQL.Add('  PRO_DTABAI = ' + fCurrentDate + ',         ');
        SQL.Add('  PRO_HORBAI = ' + fCurrentDate + ',         ');
      End;

      If Not fEmptyStr(FCodArm) Then
      begin
        SQL.Add('  PRO_NUMLOT = :NUMLOT,                      ');
        ParamByName('NUMLOT').AsString := FCodArm;
      end;

      SQL.Add('  PRO_QTDPRO = IFNULL(PRO_QTDPRO,0) + :QTDPRO, ');
      SQL.Add('  PRO_CONFER = :CONFER                         ');
      SQL.Add('WHERE                                          ');
      SQL.Add('  PRO_CODPRO = :CODPRO AND                     ');
      SQL.Add('  PRO_CODEMP = :CODEMP                         ');

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ParamByName('QTDPRO').AsFloat  := fltQtdPro;
      ParamByName('CONFER').AsString := strConfer;

      ExecSQL;
      Close;
    End;

    If blnGerarEstoque Then
    Begin
      strDocNov        := fRetSequencial('PRO_OP', VS_strCodEmp, fTamDocCadRec);
      blnBaixaTotal:= FQtdApr <= fltQtdPro;
      strAutIncProdAca := '';
      {**************************************}
      {* GRAVA MOVGER                       *}
      {***********************************RV*}
      If Not fGravaMovGer(strAutInc,
                          strDocNov,
                          'OP',
                          VS_strCodEmp,
                          '',
                          strLoginUsuarioLogado,
                          '',
                          strCodCli,
                          'C',
                          IIF(blnBAORDP, FDtaCad, VS_Date),
                          fTime(),
                          IIF(blnBAORDP, FDtaCad, VS_Date),
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
                          'BAIXA DE ORDEM DE PRODUÇÃO',
                          '',
                          '',
                          '',
                          '',
                          False,
                          '',
                          '',
                          '',  // Empresa do Faturamento
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
                          strCodPro,
                          0,
                          0.0,
                          0,
                          '',          // Consumidor final
                          'N',
                          '',
                          '',          // Operador da Expedição
                          '',          // Separador da Expedição
                          '',          // tabela de precos utilizada
                          '',
                          'N',        // Entrega Futura
                          FALSE,      // Baixa de Entrega Futura
                          0,          // Margem de Lucro
                          0.0,        // Base do retido (caso tivesse) com ipi e frete de entrada
                          0.0,        // Valor do retido considerando a base acima.
                          'N',        // Gerar produção fora da loja
                          '',         // Numero do Registro - Correios ou Transportadora
                          VS_Date,    // Data de Entrega no Romaneio
                          '',         // Classificação fiscal 4
                          'N',        // AUTO-SERVIÇO
                          '',         //Evento
                          FEndEnt,    // AUTOINC DO ENDEREÇO DE ENTREGA
                          '',         // Conteúdo do CNFNFE
                          '',         // Motivo da Devolução
                          '',
                          True) Then  // Imprime Duplicatas na NF-e
      Begin
        Result := False;
        If blnTransacao Then
          fRollBack;
        Exit;
      End;

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

      for intLote := 0 to High(arrLotes) do
      begin
        strIncDet := '';

        qryIteGer:= fCriaQuery;
        Try
          qryIteGer.SQL.Clear;
          qryIteGer.SQL.Add('SELECT ITE_PREULT, ITE_IMPULT, ITE_PREMED, ITE_SALDOS, ');
          qryIteGer.SQL.Add(' ITE_PRECUS, ITE_ICMSAI, ITE_IMPFED, ITE_DESOPE, ITE_OUTVAL FROM ITEGER');
          qryIteGer.SQL.Add('WHERE');
          qryIteGer.SQL.Add('  ITE_CODITE = :CODITE AND ');
          qryIteGer.SQL.Add('  ITE_CODEMP = :CODEMP     ');

          qryIteGer.ParamByName('CODITE').AsString := strCodIte;
          qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;

          qryIteGer.Open;

          If (fCfgSis('ATPCPM') = 'S') Then
          Begin
            If cdsDataSetQtdEditadaOrdPro.Locate('CODITE', strCodIte, []) Then
            Begin
              fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat);
              fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat);
              fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat);
              fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                            qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                            qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                            qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                            qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat);
            End
            Else
            Begin
              fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * (arrLotes[intLote].fltQtd);
              fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * (arrLotes[intLote].fltQtd);
              fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * (arrLotes[intLote].fltQtd);
              fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                             qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                             qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                             qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                             qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * (arrLotes[intLote].fltQtd);
            End

          End
          Else
            Begin

              fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * (cdsIteEst.FieldByName('QTDPRO').AsFloat);
              fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * (cdsIteEst.FieldByName('QTDPRO').AsFloat);
              fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * (cdsIteEst.FieldByName('QTDPRO').AsFloat);
              fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                             qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                             qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                             qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                             qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * (cdsIteEst.FieldByName('QTDPRO').AsFloat);
            End;


          {*************************************}
          {* GRAVA MOVDET                      *}
          {**********************************RV*}
          If Not fGravaMovDet(strIncDet,
                              strAutInc,
                              strDocNov,
                              'OP',
                              VS_strCodEmp,
                              strCodIte,
                              strLoginUsuarioLogado,
                              '',
                              strMarca,
                              '',
                              strCodCli,
                              IIF(blnBAORDP, FDtaCad, VS_Date),
                              fTime(),
                              IIF(blnBAORDP, FDtaCad, VS_Date),
                              '01000',
                              'C',
                              '',
                              strDescri,
                              strRefere,
                              strUnidad,
                              '',
                              arrLotes[intLote].fltQtd,
                              0,
                              0,
                              0,
                              0,
                              0,
                              fltTotCus,
                              fltTotMed,
                              0,
                              0,
                              0,
                              '',
                              '',
                              0,
                              0,
                              0,
                              '1999',
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
                              False,
                              '',
                              '',
                              '', // Empresa do Faturamento
                              0,
                              '',
                              '',
                              0,
                              'NOR',
                              '',
                              '',
                              0,
                              'N',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              0,
                              '',
                              0,
                              0,
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              '',
                              '',
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              strCodPro,
                              '',
                              '',
                              0,
                              0,
                              0.0,
                              '',
                              '',
                              False,
                              False,
                              '',                                                             //  Especie da Entrega Fututa
                              '',                                                             //  Documento da Entrega Fututa
                              '',
                              '',                                                             //  Empresa da Entrega Fututa
                              '',
                              '',
                              '',
                              '',
                              0.0,
                              '',
                              0.0,
                              0.0,
                              0,
                              'N',
                              '',
                              0,
                              0,
                              0,
                              0,
                              '',
                              arrLotes[intLote].strNumLot, // strNumLot
                              'N',                   // strPigBas
                              0,
                              0,
                              0,
                              fltPreUlt,
                              fltUltImp,
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
                              '',
                              '',
                              '',
                              0,
                              0,
                              0,
                              0) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;

        Finally
          FreeAndNil(qryIteGer);
        End;
        {*************************************}
        {* ATUALIZA SALDO                    *}
        {**********************************RV*}

        If ((fCfgSis('CAMXUT',varString) = 'A') Or (fCfgSis('CAMXUT',varString) = 'T')) And Not(fUsaRotinaWMS) Then
        Begin
          cdsData     := fCriaDataCapaMaxima(cdsData);
          cdsData     := fInsereItemCapacidadeMaxima(strCodIte, arrLotes[intLote].strNumLot, arrLotes[intLote].fltQtd, cdsData);

          If Not(fValidaCapacidadeMaximaLote(arrLotes[intLote].strNumLot, cdsData)) Then
          Begin
            Result := False;
            Exit;
          End
        End;


        If Not fAtualizaEstoqueCadIte(strCodIte,
                                     'E',
                                      arrLotes[intLote].fltQtd,
                                      0.0,
                                      arrLotes[intLote].strNumLot,
                                      False) Then
        Begin
          Result := False;
          If blnTransacao Then
            fRollBack;
          Exit;
        End;

        strAutIncProdAca:= strIncDet;
        ReprocessarItem(strCodIte, '', False);

      end;
    End;

    {***************************************}
    {* ATUALIZA SALDO DOS PROD. ESTRUTURAS *}
    {************************************RV*}
    With cdsIteEst Do
    Begin
      First;

      strDocNov := fRetSequencial('PRO_OP', VS_strCodEmp, fTamDocCadRec);
      strAutInc := '';
      fltPreCus := 0;
      fltPreCom := 0;
      fltTotPreMed := 0;
      fltTotImpUlt := 0;
      fltTotPreUlt := 0;


      {**************************************}
      {* GRAVA MOVGER DOS SUBITENS          *}
      {***********************************RV*}
      If Not fGravaMovGer(strAutInc,
                          strDocNov,
                          'OP',
                          VS_strCodEmp,
                          '',
                          strLoginUsuarioLogado,
                          '',
                          strCodCli,
                          'C',
                          IIF(blnBAORDP, FDtaCad, VS_Date),
                          fTime(),
                          IIF(blnBAORDP, FDtaCad, VS_Date),
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
                          'BAIXA DE ORDEM DE PRODUÇÃO',
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
                          '5999',
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
                          strCodPro,
                          0,
                          0.0,
                          0,
                          '',          // Consumidor final
                          'N',
                          '',
                          '',          // Operador da expedição
                          '',          // Separador da Expedição
                          '',
                          '',
                          'N',         // Entrega Futura
                          FALSE,       // Baixa de Entrega Futura
                          0,           // Margem de Lucro
                          0.0,         // Base do retido (caso tivesse) com ipi e frete de entrada
                          0.0,         // Valor do retido considerando a base acima.
                          'N',         // Gerar produção fora da loja
                          '',          // Numero do Registro - Correios ou Transportadora
                          VS_Date,     // Data de Entrega no Romaneio
                          '',          // Classificação fiscal 4
                          'N',         // AUTO-SERVICO
                          '',          // Evento
                          FEndEnt,     // AUTOINC DO ENDEREÇO DE ENTREGA
                          '',          // Conteúdo do CNFNFE
                          '',          // Motivo da Devolução
                          '',
                          True) Then   // Imprime Duplicatas na NF-e
      Begin
        Result := False;
        If blnTransacao Then
          fRollBack;
        Exit;
      End;

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

      qryAux := fCriaQuery(nil);
      qryAux.SQL.Add('UPDATE');
      qryAux.SQL.Add('  DETPRO');
      qryAux.SQL.Add('SET');
      qryAux.SQL.Add('  DOP_NUMLOT = :NUMLOT');
      qryAux.SQL.Add('WHERE');
      qryAux.SQL.Add('  AUTOINCREM = :AUTOINCREM');
      qryAux.SQL.Add('  AND IFNULL(DOP_NUMLOT,"") <> :NUMLOT');

      cdsIteEst.First;

      pPreAltDefineVariaveisAltPre(fNow, 'ORDEM DE PRODUCAO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);


      While Not Eof Do
      Begin
        //ALTERA OS LOTES NA DETPRO
        qryAux.Params.ParamByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
        qryAux.Params.ParamByName('NUMLOT').AsString := FieldByName('NUMLOT').AsString;
        qryAux.ExecSQL;

        If (FieldByName('QTDPRO').AsFloat > 0) Then
        Begin

          strIncDet := '';
          pRetDadosItem(FieldByName('DOP_ITESUB').AsString, strDescri, strRefere, strMarca, strUnidad);

          qryIteGer:= fCriaQuery;
          Try
            qryIteGer.SQL.Clear;
            qryIteGer.SQL.Add('SELECT ITE_PREULT, ITE_IMPULT, ITE_PREMED, ITE_SALDOS, ');
            qryIteGer.SQL.Add(' ITE_PRECUS, ITE_ICMSAI, ITE_IMPFED, ITE_DESOPE, ITE_OUTVAL FROM ITEGER');
            qryIteGer.SQL.Add('WHERE');
            qryIteGer.SQL.Add('  ITE_CODITE = :CODITE AND ');
            qryIteGer.SQL.Add('  ITE_CODEMP = :CODEMP     ');

            qryIteGer.ParamByName('CODITE').AsString := FieldByName('DOP_ITESUB').AsString;
            qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;

            qryIteGer.Open;

            If (fCfgSis('ATPCPM') = 'S') Then
            Begin
              If cdsDataSetQtdEditadaOrdPro.Locate('CODITE', FieldByName('DOP_ITESUB').AsString, []) Then
              Begin
                fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat);
                fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat);
                fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat);
                fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                              qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                              qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                              qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                              qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat);
              End
              Else
              Begin
                fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * (cdsIteEst.FieldByName('QTDPRO').AsFloat);
                fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * (cdsIteEst.FieldByName('QTDPRO').AsFloat);
                fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * (cdsIteEst.FieldByName('QTDPRO').AsFloat);
                fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                               qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                               qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                               qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                               qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * (cdsIteEst.FieldByName('QTDPRO').AsFloat);
              End

            End
            Else
            Begin
              fltPreUlt:= qryIteGer.FieldByName('ITE_PREULT').AsFloat * FieldByName('QTDPRO').AsFloat;
              fltTotMed:= qryIteGer.FieldByName('ITE_PREMED').AsFloat * FieldByName('QTDPRO').AsFloat;
              fltUltImp:= qryIteGer.FieldByName('ITE_IMPULT').AsFloat * FieldByName('QTDPRO').AsFloat;
              fltTotCus:= fCalculaCustoReal(qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
                                             qryIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                             qryIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                             qryIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                             qryIteGer.FieldByName('ITE_OUTVAL').AsFloat) * FieldByName('QTDPRO').AsFloat;
            End;

            {*************************************}
            {* GRAVA MOVDET                      *}
            {**********************************RV*}
            If Not fGravaMovDet(strIncDet,
                                strAutInc,
                                strDocNov,
                                'OP',
                                VS_strCodEmp,
                                FieldByName('DOP_ITESUB').AsString,
                                strLoginUsuarioLogado,
                                '',
                                strMarca,
                                '',
                                strCodCli,
                                IIF(blnBAORDP, FDtaCad, VS_Date),
                                fTime(),
                                IIF(blnBAORDP, FDtaCad, VS_Date),
                                '01000',
                                'C',
                                '',
                                strDescri,
                                strRefere,
                                strUnidad,
                                '',
                                FieldByName('QTDPRO').AsFloat,
                                0,
                                0,
                                0,
                                0,
                                0,
                                fltTotCus,
                                fltTotMed,
                                0,
                                0,
                                0,
                                '',
                                '',
                                0,
                                0,
                                0,
                                '5999',
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
                                False,
                                '',
                                '',
                                '', // Empresa do Faturamento
                                0,
                                '',
                                '',
                                0,
                                'NOR',
                                '',
                                '',
                                0,
                                'N',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                0,
                                0,
                                '',
                                0,
                                0,
                                0,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                0,
                                '',
                                '',
                                0,
                                '',
                                '',
                                '',
                                '',
                                '',
                                0,
                                strCodPro,
                                '',
                                '',
                                0,
                                0,
                                0.0,
                                '',
                                '',
                                False,
                                False,
                                '',                                                             //  Especie da Entrega Fututa
                                '',                                                             //  Documento da Entrega Fututa
                                '',
                                '',                                                             //  Empresa da Entrega Fututa
                                '',
                                '',
                                '',
                                '',
                                0.0,
                                '',
                                0.0,
                                0.0,
                                0,
                                'N',
                                '',
                                0,
                                0,
                                0,
                                0,
                                '',
                                FieldByName('NUMLOT').AsString, // strNumLot
                                'N',      // strPigBas
                                0,
                                0,
                                0,
                                fltPreUlt,
                                fltUltImp,
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
                                '',
                                '',
                                '',
                                0,
                                0,
                                0,
                                0) Then
            Begin
              Result := False;
              If blnTransacao Then
                fRollBack;
              Exit;
            End;
          Finally
            FreeAndNil(qryIteGer);
          End;

          If Not fAtualizaEstoqueCadIte(FieldByName('DOP_ITESUB').AsString,
                                       'S',
                                        FieldByName('QTDPRO').AsFloat,
                                        0.0,
                                        FieldByName('NUMLOT').AsString,
                                        False) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;

          ReprocessarItem(FieldByName('DOP_ITESUB').AsString, '', False);

          {**********************************************}
          {* CALCULA PREÇO DE COMPRA DO PRODUTO ACABADO *}
          {*******************************************RV*}
          If (fCfgSis('APORPR') = 'S') Then
            fltPreCom := fltPreCom + (fRetPrecoCustoIte(cdsIteEst.FieldByName('DOP_ITESUB').AsString) * (cdsIteEst.FieldByName('QTDPRO').AsFloat / fltQtdPro));

          If (fCfgSis('ATPCPM') = 'S') Then
          Begin
            If cdsDataSetQtdEditadaOrdPro.Locate('CODITE', FieldByName('DOP_ITESUB').AsString, []) Then
            Begin
              fltTotPreUlt := fltTotPreUlt + (fRetPrecoUltimaCompra(FieldByName('DOP_ITESUB').AsString, VS_strCodEmp) * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat / fltQtdPro));
              fltTotImpUlt := fltTotImpUlt + (fRetPrecoUltimaCompraImpostos(FieldByName('DOP_ITESUB').AsString, VS_strCodEmp) * (cdsDataSetQtdEditadaOrdPro.FieldByName('QTDITE').AsFloat  / fltQtdPro));
            End
            Else
            Begin
              fltTotPreUlt := fltTotPreUlt + (fRetPrecoUltimaCompra(FieldByName('DOP_ITESUB').AsString, VS_strCodEmp) * (FieldByName('QTDPRO').AsFloat / fltQtdPro));
              fltTotImpUlt := fltTotImpUlt + (fRetPrecoUltimaCompraImpostos(FieldByName('DOP_ITESUB').AsString, VS_strCodEmp) * (FieldByName('QTDPRO').AsFloat / fltQtdPro));
            End;

          End;

        End;

        Next;
      End;

      FreeAndNil(qryAux);

      If (fCfgSis('ATPCPM') = 'S') Then
      Begin
         fltTotPreMed := fRetornaPrecoMedio(fltQtdPro,fltSaldosOriginalProdutoEstrutura,fltPreMedOriginalProdutoEstrutura);
        If Not(fSalvaDadosItemMovPro(fRetornaAutIncMovPro(FCodIte, FCodPro, VS_strCodEmp), FCodIte)) Then
        Begin
          Result := False;
          If blnTransacao Then
            fRollBack;
          Exit;
        End;

      End;

      {**********************************************}
      {* GRAVA PREÇOS DO PRODUTO ACABADO            *}
      {*******************************************RV*}
      If (fCfgSis('APORPR') = 'S') Then
      Begin
        If Not fAtuPrecosProAca(strCodIte, fltQtdPro, strAutIncProdAca, blnBaixaTotal) Then
        Begin
          Result := False;
          If blnTransacao Then
            fRollBack;
          Exit;
        End;
      End;

      Close;
    End;

    strAgrupadorPreAlt := '';

    If blnMonFas And Assigned(FcdsItensDefinidosCorrecao) Then
      Result := Result And fDefinirCorrecoesFases;

    If blnTransacao Then
    Begin
      If Result Then
      Begin
        fCommit;
        objLotInd.Clear; //limpa lotes individuais
      End
      Else
        fRollBack;
    End;

    if Result and blnTransacao then
    begin
      pImprimeEtiqueta(fltQtdPro);
      if blnTransacao Then
        fMensagem('','Ordem de produção baixada com sucesso!',['&OK']);
    end;

  Except
    On E: Exception Do
    Begin
      If blnTransacao Then
        fRollBack;
      strAgrupadorPreAlt := '';

      Raise Exception.Create(E.Message);
    End;
  End;
end;

//*************************************************//
// GRAVA O ARQUIVO DETALHADO DA ORDEM DE PRODUCAO  //
//**********************************************ED*//
function TOrdPro.fGravaDetOrdPro(strSeqMat: String): Boolean;
  Var
    strSql     : String;
    prcScroll  : TprcScroll;
    objOPFilha : TobjOPFilha;
    objOPPai   : TobjOPPai;
    strAutInc  : String;
begin

  Result := True;

  Try

    //*************************************************//
    // LIMPA OS DADOS ANTERIORES JA GRAVADOS NO BANCO  //
    //**********************************************ED*//
    With qryDetPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE  ');
      SQL.Add('FROM     ');
      SQL.Add('  DETPRO ');
      SQL.Add('WHERE ');
      SQL.Add('  DOP_SEQGER = :SEQGER ');
      ParamByName('SEQGER').AsString := strSeqMat;
      ExecSQL;
      Close;
    End;

    //*************************************************//
    // SELECIONA OS REGISTROS DA TEMPORARIA Q CONTEM   //
    // OS ITENS DA ESTRUTURA, PARA GRAVAR NO ARQUIVO   //
    // DETALHADO                                       //
    //**********************************************ED*//
    With cdsIteEst Do
    Begin
      pDisableControls(cdsIteEst, prcScroll);
      First;

      While Not Eof Do
      Begin
        Try

          strSql := '';
          strSql := strSql + 'INSERT INTO DETPRO ( ';
          strSql := strSql + '  DOP_SEQGER,        ';
          strSql := strSql + '  DOP_SEQUEN,        ';
          strSql := strSql + '  DOP_CODEMP,        ';
          strSql := strSql + '  DOP_ITESUB,        ';
          strSql := strSql + '  DOP_QTDITE,        ';
          strSql := strSql + '  DOP_METRAG,        ';
          strSql := strSql + '  DOP_NUMLOT,        ';
          strSql := strSql + '  DOP_NUMFAS,        ';
          strSql := strSql + '  AUTOINCREM)        ';
          strSql := strSql + 'VALUES (             ';
          strSql := strSql + '  :SEQGER,           ';
          strSql := strSql + '  :SEQUEN,           ';
          strSql := strSql + '  :CODEMP,           ';
          strSql := strSql + '  :ITESUB,           ';
          strSql := strSql + '  :QTDITE,           ';
          strSql := strSql + '  :METRAG,           ';
          strSql := strSql + '  :NUMLOT,           ';
          strSql := strSql + '  :NUMFAS,           ';
          strSql := strSql + '  :AUTINC)           ';

          qryDetPro.Close;
          qryDetPro.SQL.Clear;
          qryDetPro.SQL.Add(strSql);

          qryDetPro.ParamByName('SEQGER').AsString  := strSeqMat;
          qryDetPro.ParamByName('SEQUEN').AsString  := fAtualizaProCod('DETPRO', 'DOP_SEQUEN');
          qryDetPro.ParamByName('CODEMP').AsString  := VS_strCodEmp;
          qryDetPro.ParamByName('ITESUB').AsString  := FieldByName('ITESUB').AsString;
          qryDetPro.ParamByName('QTDITE').AsFloat   := FieldByName('QTDITE').AsFloat;
          qryDetPro.ParamByName('METRAG').AsFloat   := FieldByName('METRAG').AsFloat;
          qryDetPro.ParamByName('AUTINC').AsString  := fRetAutoIncrem('DETPRO', VS_strCodEmp);
          qryDetPro.ParamByName('NUMLOT').AsString  := FieldByName('NUMLOT').AsString;
          If qryDetPro.ParamByName('NUMLOT').AsString = '' Then
            qryDetPro.ParamByName('NUMLOT').Clear;

          qryDetPro.ParamByName('NUMFAS').AsString  := FieldByName('SEQUEN').AsString;
          qryDetPro.ExecSQL;

        Except
          On E: Exception Do
          Begin
            fRollBack;
            Raise Exception.Create(E.Message);
          End;
        End;

        {**************************}
        {* ATUALIZA QTD RESERVADA *}
        {***********************FS*}
        ReprocessarItem(FieldByName('ITESUB').AsString, '', False);

        Next;
      End;

      pEnableControls(cdsIteEst, prcScroll);

    End;


    If fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque Then
    Begin
      Try
        pSetSeqUsa(FCodIte, FAutInc);

        For objOPFilha in lstOPFilha do
        Begin
          if objOPFilha.fltQtdApr > 0 Then
          Begin
            strAutInc := fGeraOrdemProducaoFilha(objOPFilha.strCodIte, objOPFilha.fltQtdApr);
            pSetSeqUsa(objOPFilha.strCodIte, strAutInc);
            pSetSeqGer(objOPFilha.strCodIte, strAutInc);
          End;
        End;

        strSql := '';
        strSql := strSql + ' INSERT INTO ORIPRO ( ';
        strSql := strSql + '  AUTOINCREM,         ';
        strSql := strSql + '  PRO_SEQGER,         ';
        strSql := strSql + '  PRO_SEQUSA,         ';
        strSql := strSql + '  PRO_QTDUSA,         ';
        strSql := strSql + '  PRO_USAEST,         ';
        strSql := strSql + '  PRO_QTDSUB)         ';
        strSql := strSql + '  VALUES (            ';
        strSql := strSql + '  :AUTINC,            ';
        strSql := strSql + '  :SEQGER,            ';
        strSql := strSql + '  :SEQUSA,            ';
        strSql := strSql + '  :QTDUSA,            ';
        strSql := strSql + '  :USAEST,            ';
        strSql := strSql + '  :QTDSUB)            ';




          qryDetPro.SQL.Clear;
          qryDetPro.SQL.Add(strSql);

          For objOPPai in lstOPPai do
          Begin
            if (not fEmptyStr(objOPPai.strSeqUsa)) and (not fEmptyStr(objOPPai.strSeqGer)) and (objOPPai.fltQtdApr > 0) then
            begin
              qryDetPro.ParamByName('AUTINC').AsString := fRetAutoIncrem('ORIPRO', VS_strCodEmp);
              qryDetPro.ParamByName('SEQGER').AsString := objOPPai.strSeqGer;
              qryDetPro.ParamByName('SEQUSA').AsString := objOPPai.strSeqUsa;
              qryDetPro.ParamByName('QTDSUB').AsFloat  := objOPPai.fltQtdUsa;
              qryDetPro.ParamByName('USAEST').AsFloat  := objOPPai.fltQtdEtq;
              qryDetPro.ParamByName('QTDUSA').AsFloat  := objOPPai.fltQtdApr;


              qryDetPro.ExecSQL;
            end;
          End;
      Finally
        lstOPFilha.Clear;
        lstOPPai.Clear;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fGravaDetOrdPro]');
    End;
  End;

end;



function TOrdPro.fAjustaSequencialDia : Boolean;
  Var
    intOldSeq : Integer;
    qrySeq : TUniQuery;
begin

  Result := True;

  if not fCfgSis('SEQORD', varBoolean) then
    exit;

  try
    if (qryOrdPro.State in [dsInsert]) or (qryOrdPro.FieldByName('PRO_SEQUEN').oldValue = Null) then
      intOldSeq := 0
    else
      intOldSeq := qryOrdPro.FieldByName('PRO_SEQUEN').oldValue;

    If intOldSeq <> qryOrdPro.FieldByName('PRO_SEQUEN').AsInteger then
    begin
      qrySeq := fCriaQuery(nil);
      try
        qrySeq.SQL.Add('SELECT                      ');
        qrySeq.SQL.Add('  AUTOINCREM, PRO_SEQUEN    ');
        qrySeq.SQL.Add('FROM                        ');
        qrySeq.SQL.Add('  MOVPRO                    ');
        qrySeq.SQL.Add('WHERE                       ');
        qrySeq.SQL.Add('      PRO_DTAPRO  = :DTAPRO ');
        qrySeq.SQL.Add('  AND PRO_SEQUEN >= :SEQUEN ');
        qrySeq.SQL.Add('  AND PRO_CODEMP  = :CODEMP ');
        qrySeq.SQL.Add('  AND AUTOINCREM <> :AUTINC ');
        qrySeq.SQL.Add('ORDER BY                    ');
        qrySeq.SQL.Add('  PRO_SEQUEN                ');

        qrySeq.ParamByName('DTAPRO').AsDateTime := qryOrdPro.FieldByName('PRO_DTAPRO').AsDateTime;
        qrySeq.ParamByName('SEQUEN').AsInteger  := qryOrdPro.FieldByName('PRO_SEQUEN').AsInteger;
        qrySeq.ParamByName('CODEMP').AsString   := VS_strCodEmp;
        qrySeq.ParamByName('AUTINC').AsString   := qryOrdPro.FieldByName('AUTOINCREM').AsString;

        qrySeq.Open;
        qrySeq.First;

        while not qrySeq.Eof do
        begin
          qrySeq.Edit;
          qrySeq.FieldByName('PRO_SEQUEN').AsInteger := qryOrdPro.FieldByName('PRO_SEQUEN').AsInteger + qrySeq.RecNo;
          qrySeq.Post;
          qrySeq.Next;
        end;

      finally
        FreeAndNil(qrySeq);
      end;
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAjustaSequencialDia]');
    End;
  End;
end;

function TOrdPro.fSQLEstrutura(strCodPro : string) : string;
  var
    strTabGer : String;
    strTabDet : String;
begin

  strTabGer := 'GERMAT';
  strTabDet := 'DETMAT';

  If fModoEstruturaPersonalizada Then
  Begin
    strTabGer := 'GERPER';
    strTabDet := 'DETPER';
  End;

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  GMT_CODITE AS CODITE, ';
  Result := Result + '  DMT_ITESUB AS ITESUB, ';
  Result := Result + '  DMT_QTDITE AS QTDITE, ';
  Result := Result + '  DMT_SEQUEN AS SEQUEN, ';
  Result := Result + '  0.00       AS METRAG, ';
  Result := Result + '  0.00       AS QTDPRO, ';
  Result := Result + '  ITE_CODUNI AS UNIDAD, ';
  Result := Result + '  ITE_DESITE AS DESITE, ';
  Result := Result + '  ITE_CODFAB AS CODFAB, ';
  Result := Result + '  IF(IFNULL(ITE_REFERE, "") = "", " ", ITE_REFERE) AS REFERE, ';
  Result := Result + '  ITE_CONLOT AS CONLOT, ';
  Result := Result + '  CADITE.ITE_ITEATI AS ITEMATIVO, ';
  Result := Result + '  (SELECT COUNT(*) FROM CADLOT WHERE LOT_CODEMP = :CODEMP AND LOT_CODITE = ITE_CODITE) AS LOTQTD, ';
  Result := Result + '  @NUMLOT := IFNULL(LOTPRIPRO.LOT_NUMLOT,"") AS NUMLOT, ';
  Result := Result + '  0.0000 AS SALDOS,    ';
  Result := Result + '  0.0000 AS QTDTOT     ';
  Result := Result + 'FROM ';
  Result := Result + '  '+strTabGer+' ';
  Result := Result + '  JOIN '+strTabDet+' ON DMT_SEQGER = '+strTabGer+'.AUTOINCREM ';
  Result := Result + '  JOIN CADITE ON ITE_CODITE = DMT_ITESUB ';
  Result := Result + '  LEFT JOIN (SELECT LOT_NUMLOT, LOT_CODITE FROM CADLOT WHERE LOT_CODEMP = :CODEMP ';

  If fConsideraLoteEstoqueExternoSubProdutosFulfillment Then
    Result := Result + '  AND LOT_NUMLOT = ' + QuotedStr(TCadLot.GeraNumeroLoteEstoqueExterno(Fulfillment.CodigoDoEstoqueExterno))
  Else
    Result := Result + '  AND LOT_PRIPRO = "S" ';

  Result := Result + '  ) AS LOTPRIPRO ON LOT_CODITE = ITE_CODITE ';
  Result := Result + 'WHERE ';
  Result := Result + '  GMT_CODITE = :CODITE ';

  If fModoEstruturaPersonalizada Then
  Begin
    Result := Result + '  AND '+strTabGer+'.GMT_SEQPER = ' + FRecItem.intSeqPer.ToString + ' ';
    Result := Result + '  AND '+strTabDet+'.DMT_SEQPER = ' + FRecItem.intSeqPer.ToString + ' ';
  End;

  If fEhItemVendaVidro(strCodPro) And (Length(subItensEstruturaVidro.Items) > 0) Then
    Result := Result + '  AND FALSE ';

  Result := Result + 'ORDER BY';
  Result := Result + '  DMT_SEQUEN';
end;

function TOrdPro.fTemNotaRefugoJaEmitida(AStrAutIncOrdPro: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT AUTOINCREM FROM RFGORD WHERE ORD_SEQORD = :SEQORD AND ORD_JAFATU = "S"');
    qryAux.ParamByName('SEQORD').AsString := AStrAutIncOrdPro;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TOrdPro.fRetornaSaldoReservadoOrdPro(strCodPro, strCodIte, strNumLot : String) : Real;
Var
  qryConRes : TUniQuery;
begin
  Result := 0;
  qryConRes := fCriaQuery(Self);
  Try
    qryConRes.SQL.Add(' SELECT PRO_QTDAPR * DOP_QTDITE AS QTDRES            ');
    qryConRes.SQL.Add(' FROM MOVPRO                                         ');
    qryConRes.SQL.Add(' INNER JOIN DETPRO ON DOP_SEQGER = MOVPRO.AUTOINCREM ');
    qryConRes.SQL.Add(' WHERE PRO_CODPRO            = :CODPRO               ');
    qryConRes.SQL.Add('   AND DOP_ITESUB            = :ITESUB               ');
    qryConRes.SQL.Add('   AND IFNULL(DOP_NUMLOT,"") = :NUMLOT               ');

    qryConRes.ParamByName('CODPRO').AsString := strCodPro;
    qryConRes.ParamByName('ITESUB').AsString := strCodIte;
    qryConRes.ParamByName('NUMLOT').AsString := strNumLot;

    qryConRes.Open;

    If not qryConRes.IsEmpty Then
      Result := qryConRes.FieldByName('QTDRES').AsFloat;
  Finally
    qryConRes.Close;
    FreeAndNil(qryConRes);
  End;

end;


{*******************************************}
{* CRIA UMA TEMPORARIA COM OS SUB-PRODUTOS *}
{* DE UM PRODUTO ESTRUTURA. CASO SEJA ALTE-*}
{* RAÇÃO, CARREGA OS ITENS JÁ GRAVADOS     *}
{****************************************MV*}
procedure TOrdPro.pCriaTemporaria(blnAlteracao: Boolean; strCodPro: String; AStrAutIncFase: String = '');
  Var
    strSQL: String;
    fltQtdIte: Double;
    subItem: TSubItemVidro;
begin
  If (Not blnAlteracao) Then
  Begin
    With FqryEst Do
    Begin
      Close;
      cdsIteEst.Close;

      SQL.Clear;
      SQL.Add(fSQLEstrutura(strCodPro));
      ParamByName('CODITE').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      pSetaClient(FqryEst);

      cdsIteEst.SetProvider(FdspEst);
      cdsIteEst.Open;
      pSetaClient(cdsIteEst);
    End;

    If fEhItemVendaVidro(strCodPro) And (Length(subItensEstruturaVidro.Items) > 0) Then
    Begin
      For subItem In subItensEstruturaVidro.Items Do
      Begin
        cdsIteEst.Append;
        cdsIteEst.FieldByName('CODITE').AsString := strCodPro;
        cdsIteEst.FieldByName('ITESUB').AsString := subItem.strCodigo;
        cdsIteEst.FieldByName('QTDITE').AsFloat  := subItem.fltQuantidadeVenda;
        cdsIteEst.FieldByName('UNIDAD').AsString := subItem.strUnidade;
        cdsIteEst.FieldByName('DESITE').AsString := subItem.strDescricao;
        cdsIteEst.FieldByName('REFERE').AsString := subItem.strReferencia;
        cdsIteEst.Post;
      End;
    End;

  End
  Else
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PRO_CODITE AS CODITE, ';
    strSQL := strSQL + '  DOP_ITESUB AS ITESUB, ';
    strSQL := strSQL + '  PRO_QTDAPR AS QTDPRO, ';
    strSQL := strSQL + '  DOP_QTDITE AS QTDITE, ';
    strSQL := strSQL + '  DOP_METRAG AS METRAG, ';
    strSQL := strSQL + '  ITE_CODUNI AS UNIDAD, ';
    strSQL := strSQL + '  ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  IF(IFNULL(ITE_REFERE, "") = "", " ", ITE_REFERE) AS REFERE,';
    strSQL := strSQL + '  ITE_CONLOT AS CONLOT, ';
    strSQL := strSQL + '  CADITE.ITE_ITEATI AS ITEMATIVO, ';
    strSQL := strSQL + '  (SELECT COUNT(0) FROM CADLOT WHERE LOT_CODEMP = :CODEMP AND LOT_CODITE = DOP_ITESUB) AS LOTQTD, ';
    strSQL := strSQL + '  DOP_NUMLOT AS NUMLOT, ';
    strSQL := strSQL + '  DOP_NUMLOT AS NUMLOTAUX, ';
    strSQL := strSQL + '  0.0000 AS SALDOS,      ';
    strSQL := strSQL + '  0.0000 AS QTDTOT,     ';
    strSQL := strSQL + '  DOP_NUMFAS AS SEQUEN ,  ';
    strSQL := strSQL + '  DOP_SEQFAS AS SEQFAS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVPRO ';
    strSQL := strSQL + '  JOIN DETPRO ON DOP_SEQGER = MOVPRO.AUTOINCREM ';
    strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = DOP_ITESUB ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_CODPRO = :CODPRO AND ';
    strSQL := strSQL + '  PRO_CODEMP = :CODEMP ';
    If Not fEmptyStr(AStrAutIncFase) Then
      strSQL := strSQL + ' AND DOP_SEQFAS = :SEQFAS ';

    With FqryEst Do
    Begin
      Close;
      cdsIteEst.Close;

      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      If Not fEmptyStr(AStrAutIncFase) Then
        ParamByName('SEQFAS').AsString := AStrAutIncFase;

      Open;
      pSetaClient(FqryEst);

      cdsIteEst.SetProvider(FdspEst);
      cdsIteEst.Open;
      pSetaClient(cdsIteEst);
    End;

  End;

  (cdsIteEst.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
  (cdsIteEst.FieldByName('QTDPRO') As TFloatField).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
  (cdsIteEst.FieldByName('QTDTOT') As TFloatField).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
  (cdsIteEst.FieldByName('SALDOS') As TFloatField).DisplayFormat := '#,##0.000';

  If (fCfgSis('SLD_OI') <> 'N') or Assigned(pDefineQtdSubItens) Then
  Begin
    Try
      cdsIteEst.DisableControls;
      cdsIteEst.First;
      While Not cdsIteEst.Eof Do
      Begin

        cdsIteEst.Edit;

        //Carrega saldo disponivel dos subprodutos.
        if (fCfgSis('SLD_OI') <> 'N') then
        begin
          cdsIteEst.FieldByName('SALDOS').AsFloat :=   fRetornaSaldoDisponivel(cdsIteEst.FieldByName('ITESUB').AsString,False, True, cdsIteEst.FieldByName('NUMLOT').AsString);
          if blnAlteracao then
            cdsIteEst.FieldByName('SALDOS').AsFloat := cdsIteEst.FieldByName('SALDOS').AsFloat + fRetornaSaldoReservadoOrdPro(strCodPro, cdsIteEst.FieldByName('ITESUB').AsString, cdsIteEst.FieldByName('NUMLOT').AsString);
        end;

        //Prestcon
        if Assigned(pDefineQtdSubItens) Then
        begin
          fltQtdIte := cdsIteEst.FieldByName('QTDITE').AsFloat;
          pDefineQtdSubItens(cdsIteEst.FieldByName('ITESUB').AsString, fltQtdIte);
          cdsIteEst.FieldByName('QTDITE').AsFloat := fltQtdIte;
        end;

        cdsIteEst.Post;
        cdsIteEst.Next;
      End;
    Finally
      cdsIteEst.First;
      cdsIteEst.EnableControls;
    End;
  End;


end;

function TOrdPro.fInsereOrdemProducao: Boolean;
  Var
    strAutIncr : String;
    strSql     : String;
    qryInsert  : TUniQuery;
begin
  Try
    Result := True;

    If (fOrdemProducaoExiste) Then
      Exit;

    If blnTransacao Then
      fStartTransaction;

    strSql := '';
    strSql := strSql + ' INSERT INTO MOVPRO ( ';
    strSql := strSql + '   PRO_CODPRO,        ';
    strSql := strSql + '   PRO_NUMDOC,        ';
    strSql := strSql + '   PRO_ESPDOC,        ';
    strSql := strSql + '   PRO_CODEMP,        ';
    strSql := strSql + '   PRO_CODCLI,        ';
    strSql := strSql + '   PRO_ENDENT,        ';
    strSql := strSql + '   PRO_CODITE,        ';
    strSql := strSql + '   PRO_OBS001,        ';
    strSql := strSql + '   PRO_OBS002,        ';
    strSql := strSql + '   PRO_OBS_PD,        ';
    strSql := strSql + '   PRO_CONFER,        ';
    strSql := strSql + '   PRO_QTDAPR,        ';
    strSql := strSql + '   PRO_QTDPRO,        ';
    strSql := strSql + '   PRO_DTAPRO,        ';
    strSql := strSql + '   PRO_DTACAD,        ';
    strSql := strSql + '   PRO_DTABAI,        ';
    strSql := strSql + '   PRO_HORBAI,        ';
    strSql := strSql + '   PRO_SEQIND,        ';
    strSql := strSql + '   PRO_EMPPED,        ';
    strSql := strSql + '   PRO_ESPPED,        ';
    strSql := strSql + '   PRO_NUMPED,        ';
    strSql := strSql + '   AUTOINCREM)        ';
    strSql := strSql + ' VALUES (             ';
    strSql := strSql + '   :CODPRO,           ';
    strSql := strSql + '   :NUMDOC,           ';
    strSql := strSql + '   :ESPDOC,           ';
    strSql := strSql + '   :CODEMP,           ';
    strSql := strSql + '   :CODCLI,           ';
    strSql := strSql + '   :ENDENT,           ';
    strSql := strSql + '   :CODITE,           ';
    strSql := strSql + '   :OBS001,           ';
    strSql := strSql + '   :OBS002,           ';
    strSql := strSql + '   :OBS_PD,           ';
    strSql := strSql + '   :CONFER,           ';
    strSql := strSql + '   :QTDAPR,           ';
    strSql := strSql + '   :QTDPRO,           ';
    strSql := strSql + '   :DTAPRO,           ';
    strSql := strSql + '   :DTACAD,           ';
    strSql := strSql + '   :DTABAI,           ';
    strSql := strSql + '   :HORBAI,           ';
    strSql := strSql + '   :SEQIND,           ';
    strSql := strSql + '   :EMPPED,           ';
    strSql := strSql + '   :ESPPED,           ';
    strSql := strSql + '   :NUMPED,           ';
    strSql := strSql + '   :AUTINC)           ';

    FCodPro    := fAtualizaProCod('MOVPRO', 'PRO_CODPRO');
    strAutIncr := fRetAutoIncrem('MOVPRO', IfThen( fEmptyStr(FCodEmp), VS_strCodEmp, FCodEmp) );

    qryInsert := fCriaQuery(Nil);

    With qryInsert, SQL Do
    Begin
      Clear;
      Add(strSql);

      ParamByName('CODPRO').AsString   := FCodPro;
      ParamByName('NUMDOC').AsString   := FNumDoc;
      ParamByName('ESPDOC').AsString   := FEspDoc;
      ParamByName('CODEMP').AsString   := FCodEmp;
      ParamByName('CODCLI').AsString   := FCodCli;

      if fEmptyStr(ParamByName('CODCLI').AsString) then
        ParamByName('CODCLI').clear;

      ParamByName('CODITE').AsString   := FCodIte;
      ParamByName('OBS001').AsString   := FObs001;
      ParamByName('OBS002').AsString   := FObs002;
      ParamByName('OBS_PD').AsString   := FObs_PD;
      ParamByName('CONFER').AsString   := FConfer;
      ParamByName('QTDAPR').AsFloat    := FQtdApr;
      ParamByName('QTDPRO').AsFloat    := FQtdPro;

      If fEmptyStr(FEndEnt) Then
        ParamByName('ENDENT').Value   := Null
      Else
        ParamByName('ENDENT').AsString   := FEndEnt;

      If (FDtaPro > 0) Then
        ParamByName('DTAPRO').AsDateTime := FDtaPro
      Else
        ParamByName('DTAPRO').Value := Null;

      ParamByName('DTACAD').AsDateTime := FDtaCad;

      If (FDtaBai > 0) Then
      Begin
        ParamByName('DTABAI').AsDateTime := FDtaBai;
        ParamByName('HORBAI').AsDateTime := FHorBai;
      End
      Else
      Begin
        ParamByName('DTABAI').Value := Null;
        ParamByName('HORBAI').Value := Null;
      End;

      If fEmptyStr(FSeqInd) Then
        ParamByName('SEQIND').Value := Null
      Else
        ParamByName('SEQIND').AsString := FSeqInd;

      If fEmptyStr(FNumPed) Then
      Begin
        ParamByName('NUMPED').Value := Null;
        ParamByName('ESPPED').Value := Null;
        ParamByName('EMPPED').Value := Null;
      End
      Else
      Begin
        ParamByName('NUMPED').Value := FNumPed;
        ParamByName('ESPPED').Value := FEspPed;
        ParamByName('EMPPED').Value := FEmpPed;
      End;

      ParamByName('AUTINC').AsString := strAutIncr;

      ExecSQL;
    End;

    If fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque Then
      pCarregaOPFilhas(FCodIte, FQtdApr);

    pCriaTemporaria(False, FCodIte);
    Result := fGravaDetOrdPro(strAutIncr);

    if Result then
      FAutInc := strAutIncr;

    {**************************}
    {* ATUALIZA QTD RESERVADA *}
    {***********************FS*}
    ReprocessarItem(FCodIte, '', False);

    qryOrdPro.Close;

    If blnTransacao Then
    Begin
      If Result Then
        fCommit
      Else
        fRollBack;
    End;
  Except
    On E: Exception Do
    Begin
      If blnTransacao Then
        fRollBack;
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(qryInsert);
end;

function TOrdPro.fModoEstruturaPersonalizada: Boolean;
begin
  Result := (Assigned(FobjEstruturaPersonalizada) And FobjEstruturaPersonalizada.blnEstruturaFoiPersonalizada) Or
            (FRecItem.intSeqPer > 0);
end;

function TOrdPro.fDeveMovimentarEstoqueFisico(AFulRegrasMovEstoque: FulfillmentRegrasMovimentacaoEstoque): Boolean;
begin
  Result := True;

  If Not Fulfillment.EhOperacaoFulfillment Then
    Exit;

  Result := AFulRegrasMovEstoque.MovimentaEstoqueFisico;

end;

function TOrdPro.fDeveMovimentarEstoqueExterno(AFulRegrasMovEstoque: FulfillmentRegrasMovimentacaoEstoque): Boolean;
begin
  Result := False;

  If Not Fulfillment.EhOperacaoFulfillment Then
    Exit;

  Result := AFulRegrasMovEstoque.MovimentaEstoqueExterno;

end;

function TOrdPro.fGeraOrdemProducaoFilha(strCodEst: String; fltQtdPro : Double):String;
  var
    objOrdFilha : TOrdPro;
begin
  Try
    objOrdFilha := TOrdPro.Create(Self, Self.blnFaturamento);
    objOrdFilha.Fulfillment.CopyFrom(Self.Fulfillment);

    objOrdFilha.blnTransacao := False;
    objOrdFilha.strNumDoc := Self.strNumDoc;
    objOrdFilha.strEspDoc := Self.strEspDoc;
    objOrdFilha.strCodEmp := Self.strCodEmp;
    objOrdFilha.strCodCli := Self.strCodCli;
    objOrdFilha.strCodIte := strCodEst;
    objOrdFilha.strQtdApr := FloatToStr(fltQtdPro);
    objOrdFilha.strQtdPro := '0.0';
    objOrdFilha.strConfer := Self.strConfer;
    objOrdFilha.strDtaPro := Self.strDtaPro;
    objOrdFilha.strDtaCad := Self.strDtaCad;
    objOrdFilha.strSeqInd := Self.strSeqInd;
    objOrdFilha.fInsereOrdemProducao;

    Result := objOrdFilha.strAutInc;

  Finally
    FreeAndNil(objOrdFilha);
  End;

end;


function TOrdPro.fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque: Boolean;
begin

  Result := False;

  If (Self.FFulfillment.EhOperacaoFulfillment) Then
    Exit;

  Result := fCfgSis('GOPSUB', varBoolean);

end;

class function TOrdPro.fOrdemProducaoBaixada(strCodPro, strCodEmp: String): Boolean;
begin
  Result := False;
  If fCampoTabela('COUNT(0)', 'MOVPRO', ['PRO_CODPRO','PRO_CODEMP'], [strCodPro, strCodEmp]) > 0 Then
    Result := fCampoTabela('IF(PRO_DTABAI IS NOT NULL, TRUE, FALSE)', 'MOVPRO', ['PRO_CODPRO','PRO_CODEMP'], [strCodPro, strCodEmp]);
end;

function TOrdPro.fOrdemProducaoExiste: Boolean;
  Var
    qryGenPro: TUniQuery;
begin
  qryGenPro := fCriaQuery(Self);
  With qryGenPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  COUNT(*) AS QTD ');
    SQL.Add('FROM ');
    SQL.Add('  MOVPRO ');
    SQL.Add('WHERE ');
    SQL.Add('  PRO_NUMDOC = :NUMDOC AND ');
    SQL.Add('  PRO_ESPDOC = :ESPDOC AND ');
    SQL.Add('  PRO_CODEMP = :CODEMP AND ');
    SQL.Add('  PRO_CODITE = :CODITE AND ');
    SQL.Add('  PRO_CODCLI = :CODCLI AND ');
    SQL.Add('  PRO_SEQIND = :SEQIND ');

    ParamByName('NUMDOC').AsString  := FNumDoc;
    ParamByName('ESPDOC').AsString  := FEspDoc;
    ParamByName('CODEMP').AsString  := FCodEmp;
    ParamByName('CODITE').AsString  := FCodIte;
    ParamByName('CODCLI').AsString  := FCodCli;
    ParamByName('SEQIND').AsString  := FSeqInd;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
  FreeAndNil(qryGenPro);
end;

function TOrdPro.fOrigemOrdemProducaoEhPorArquivoDeImportacao(ACodPro, ACodEmp: String): Boolean;
var
  qryImport : TUniQuery;
begin

  Result := False;

  If ACodPro.IsEmpty Then
    Exit;

  If ACodEmp.IsEmpty Then
    Exit;

  qryImport := fCriaQuery;

  Try

    qryImport.Close;
    qryImport.SQL.Clear;
    qryImport.SQL.Add('SELECT PRO_CODITE FROM MOVPRO');
    qryImport.SQL.Add('WHERE IFNULL(PRO_PROJEC, "") <> ""');
    qryImport.SQL.Add('  AND PRO_CODPRO = :CODPRO ');
    qryImport.SQL.Add('  AND PRO_CODEMP = :CODEMP ');

    qryImport.ParamByName('CODPRO').AsString := ACodPro;
    qryImport.ParamByName('CODEMP').AsString := ACodEmp;
    qryImport.Open;

    Result := Not qryImport.IsEmpty;

  Finally
    FreeAndNil(qryImport);
  End;

end;

function TOrdPro.fVerificaLoteSubItens: Boolean;
   Var
     qryCadLot,
     qryLotPri: TUniQuery;
     sltItens: TStringList;

  Procedure pAbreLote(qryCadLot: TUniQuery; blnPrincipal: Boolean);
  Begin
    With qryCadLot Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add('SELECT ');
      SQL.Add('  LOT_CODITE,   ');
      SQL.Add('  LOT_PRIPRO,   ');
      SQL.Add('  DOP_NUMLOT    ');
      SQL.Add('FROM ');
      SQL.Add('  MOVPRO ');
      SQL.Add('  JOIN DETPRO ON DOP_SEQGER = MOVPRO.AUTOINCREM ');

      SQL.Add('INNER JOIN CADLOT L ON DOP_ITESUB = LOT_CODITE AND');
      SQL.Add('                       LOT_CODEMP = :CODEMP ');

      SQL.Add('WHERE ');
      SQL.Add('  PRO_CODPRO = :CODPRO AND ');
      SQL.Add('  PRO_CODEMP = :CODEMP ');

      If blnPrincipal Then
        SQL.Add('  AND LOT_PRIPRO = "S" ');

      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;
  End;

Begin
  Result := True;

//  If (fCfgSis('CTLEST') <> '2')  Then
//    Exit;

  qryCadLot := fCriaQuery(Self);
  qryLotPri := fCriaQuery(Self);

  sltItens  := TStringList.Create;

  pAbreLote(qryCadLot, False);
  pAbreLote(qryLotPri, True);

  With qryCadLot Do
  Begin

    While Not Eof Do
    Begin

      if fEmptyStr(qryCadLot.FieldByName('DOP_NUMLOT').AsString) then
        If Not qryLotPri.Locate('LOT_CODITE', FieldByName('LOT_CODITE').AsString, []) Then
          sltItens.Add(QuotedStr(FieldByName('LOT_CODITE').AsString));

      Next;

    End;

  End;

  If sltItens.Count > 0 Then
  With qryCadLot, SQL Do
  Begin
    Close;

    Clear;
    Add('SELECT');
    Add('  ITE_CODITE AS CODITE,');
    Add('  ITE_DESITE AS DESITE ');
    Add('FROM         ');
    Add('   CADITE    ');
    Add('WHERE        ');
    Add('  ITE_CODITE IN (' + sltItens.CommaText + ')');

    Open;

    Result := IsEmpty;

    If Not Result Then
    Begin

      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(119, 6010, [],
                            ['CODPRO','CODEMP','LSTITE'],
                            [strCodPro,
                            VS_strCodEmp,
                            sltItens.CommaText],
                            nil,
                            nil,
                            True);
      End;

    End;
  End;

  FreeAndNil(sltItens);
  FreeAndNil(qryCadLot);
  FreeAndNil(qryLotPri);
End;



class function TOrdPro.fVerificaOPBaixada(strNumDoc, strEspDoc, strEmpDoc, strOrdPro: String): Boolean;
var
  strSQL: string;
  qryMovPro: TUniQuery;
begin
  qryMovPro := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + 'SELECT COUNT(*) QTDBAI FROM MOVPRO ';
    strSQL := strSQL + 'WHERE PRO_DTABAI IS NOT NULL ';
    strSQL := strSQL + '    AND PRO_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '    AND PRO_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '    AND PRO_CODEMP = :EMPDOC ';
    strSQL := strSQL + '    AND PRO_CODPRO = :CODPRO ';

    qryMovPro.SQL.Text := strSQL;
    qryMovPro.ParamByName('NUMDOC').AsString := strNumDoc;
    qryMovPro.ParamByName('ESPDOC').AsString := strEspDoc;
    qryMovPro.ParamByName('EMPDOC').AsString := strEmpDoc;
    qryMovPro.ParamByName('CODPRO').AsString := strOrdPro;
    qryMovPro.Open;

    Result := (qryMovPro.FieldByName('QTDBAI').AsInteger > 0);
  finally
    FreeAndNil(qryMovPro);
  end;
end;

procedure TOrdPro.pCarregaOPFilhas(strCodEstrutura: String; fltQtd: Double;qryTabela : TDataSet = nil);
var
  qryItemSub   : TDataSet;
  objOPFilha   : TobjOPFilha;
  objOPPai     : TobjOPPai;
  strItesub    : String;
  fltQtdApr    : double;
  fltQtdUsa    : double;
  fltQtdEtqOld : double;
  blnEditou    : boolean;

  procedure pAcertaQtd;
  begin
    if objOPFilha.fltQtdEtq > 0 then
    begin
      fltQtdApr := (fltQtdUsa - fltQtdEtqOld);
      if fltQtdApr < 0 then
        fltQtdApr := 0;

      objOPFilha.fltQtdEtq := fltQtdEtqOld - fltQtdUsa;
      if objOPFilha.fltQtdEtq < 0 then
        objOPFilha.fltQtdEtq := 0;
    end
    else
      fltQtdApr := fltQtdUsa;

    objOPFilha.fltQtdApr := objOPFilha.fltQtdApr + fltQtdApr;
  end;

begin
  if Assigned(qryTabela) And (qryTabela.RecordCount > 0) then
    qryItemSub := qryTabela
  Else
  Begin
    qryItemSub := fCriaQuery(Self);
    TUniQuery(qryItemSub).SQL.Text := fSQLEstrutura(strCodEstrutura);
    TUniQuery(qryItemSub).ParamByName('CODITE').AsString := strCodEstrutura;
    TUniQuery(qryItemSub).ParamByName('CODEMP').AsString := VS_strCodEmp;
    TUniQuery(qryItemSub).Open;
  end;

  try

    qryItemSub.First;
    While Not qryItemSub.Eof Do
    Begin
      strIteSub := qryItemSub.FieldByName('ITESUB').AsString;
      fltQtdUsa := (qryItemSub.FieldByName('QTDITE').AsFloat * fltQtd);
      if fItemEstrutura(strIteSub) then
      Begin

        blnEditou := False;
        for objOPFilha in lstOPFilha do
        begin
          if objOPFilha.strCodIte = strIteSub then
          begin
            fltQtdEtqOld := objOPFilha.fltQtdEtq;
            pAcertaQtd;

            blnEditou := True;
            break;
          end;
        end;

        if not blnEditou then
        begin
          objOPFilha := TobjOPFilha.Create;
          objOPFilha.strCodIte    := strIteSub;
          objOPFilha.fltQtdEtqIni := fRetornaSaldoDisponivel(qryItemSub.FieldByName('ITESUB').AsString, False, True, qryItemSub.FieldByName('NUMLOT').AsString);
          objOPFilha.fltQtdEtq    := objOPFilha.fltQtdEtqIni;
          fltQtdEtqOld            := objOPFilha.fltQtdEtq;
          objOPFilha.fltQtdApr    := 0;
          pAcertaQtd;

          lstOPFilha.Add(objOPFilha);
        end;


        blnEditou := False;
        for objOPPai in lstOPPai do
        begin
          if (objOPPai.strCodEst = strCodEstrutura) and (objOPPai.strCodIte = strIteSub) then
          begin
            objOPPai.fltQtdEtq := objOPPai.fltQtdEtq + fltQtdEtqOld;
            objOPPai.fltQtdUsa := objOPPai.fltQtdUsa + fltQtdUsa;
            objOPPai.fltQtdApr := objOPPai.fltQtdApr + fltQtdApr;
            blnEditou := True;
            break;
          end;
        end;

        if not blnEditou then
        begin
          objOPPai := TObjOPPai.Create;
          objOPPai.strCodEst := strCodEstrutura;
          objOPPai.strCodIte := strIteSub;
          objOPPai.fltQtdEtq := fltQtdEtqOld;
          objOPPai.fltQtdUsa := fltQtdUsa;
          objOPPai.fltQtdApr := fltQtdApr;

          lstOPPai.Add(objOPPai);
        end;

        pCarregaOPFilhas(strIteSub, fltQtdApr);

      end;

      qryItemSub.Next;
    End;


  finally
    if Assigned(qryTabela) And (qryTabela.RecordCount > 0) then
      qryItemSub := Nil
    Else
    begin
      qryItemSub.Close;
      FreeAndNil(qryItemSub);
    end;
  end;

end;




procedure TOrdPro.pSetSeqUsa(strCodEst, strAutInc: string);
var
  objOPPai : TObjOPPai;
begin
  for objOPPai in lstOPPai do
  begin
    if objOPPai.strCodEst = strCodEst then
      objOPPai.strSeqUsa := strAutInc;
  end;
end;

procedure TOrdPro.pSetObjEsttruturaPersonalizada(AEstruturaPersonalizada: TEstruturaPersonalizada);
begin
  If Assigned(AEstruturaPersonalizada) Then
    FobjEstruturaPersonalizada := AEstruturaPersonalizada;
end;

procedure TOrdPro.pSetRecItemDadosFechamento(ARecItem: TDadosFechamento);
begin
  FRecItem := ARecItem;
end;

procedure TOrdPro.pSetSeqGer(strCodIte, strAutInc: string);
var
  objOPPai : TObjOPPai;
begin
  for objOPPai in lstOPPai do
  begin
    if objOPPai.strCodIte = strCodIte then
      objOPPai.strSeqGer := strAutInc;
  end;
end;

{ TcdsItensErro }

constructor TcdsItensErro.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  blnApenasSaldo := True;
  Close;
  FieldDefs.Clear;
  FieldDefs.add('CODITE', ftString, fTamCodIte);
  FieldDefs.add('DESITE', ftString, 256);
  FieldDefs.add('NUMLOT', ftString, 256);
  FieldDefs.add('QTDPRO', ftFloat);
  FieldDefs.add('SALDIS', ftFloat);
  FieldDefs.add('CODFAB', ftString, 25);
  FieldDefs.add('ERRO'  , ftString, 256);
  CreateDataSet;

end;

procedure TcdsItensErro.pAddItem(strErro: String);
begin
  Insert;
  FieldByName('CODITE').AsString := recItemAdd.strCodIte;
  FieldByName('DESITE').AsString := recItemAdd.strDesIte;
  FieldByName('NUMLOT').AsString := recItemAdd.strNumLot;
  FieldByName('QTDPRO').AsFloat  := recItemAdd.fltQtdPro;
  FieldByName('SALDIS').AsFloat  := recItemAdd.fltSalDis;
  FieldByName('CODFAB').AsString := recItemAdd.strCodFab;
  FieldByName('ERRO').AsString   := strErro;
  Post;

end;

function TOrdPro.fOrdemProducaoProdutoAcabado(strCodPro: String; blnManutOrdProVidro: Boolean = False; blnApenasMovimentaProdAcabado: Boolean = False): Boolean;
Var
  frmAguarde: TfrmGravando;
begin
  Result := False;
  fCarregaOrdPro(strCodPro);
  FblnManutOrdProVidro := False;
  pCriarFormularios(TfrmBaixaOrdProdAcabado, frmBaixaOrdProdAcabado);
  Try
    If blnManutOrdProVidro then
    Begin
      FblnManutOrdProVidro := True;
      blnTransacao := False;
      frmBaixaOrdProdAcabado.fCodigoEmpresa(FEmpPed)
                            .fCodigoProducao(FCodPro)
                            .fNumeroDocumento(FNumPed)
                            .pInicia(Not blnApenasMovimentaProdAcabado);
      FCodSep := strLoginUsuarioLogado;
      FObjItensAcabado := frmBaixaOrdProdAcabado.cdsProdutoAcabado;
      FObjItensEstrutura := frmBaixaOrdProdAcabado.cdsItens;
      FblnApenasMovimentaProdAcabado := blnApenasMovimentaProdAcabado;
      try
        try
          pCriarFormularios(TfrmGravando, frmAguarde);
          frmAguarde.fExecutarAcao := fBaixarOrdemProducaProdutoAcabado;
          frmAguarde.lblGravando.Font.Size := 16;
          frmAguarde.ShowModal;
          Result := true;
        except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, 'TOrdPro.fOrdemProducaoProdutoAcabado');
          End;
        End;
      finally
        pFreeAndNil(frmAguarde);
      end;
    End
    Else
    begin
      If frmBaixaOrdProdAcabado
          .fCodigoEmpresa(FEmpPed)
          .fCodigoProducao(FCodPro)
          .fNumeroDocumento(FNumPed)
          .ShowModal = mrOk then
      Begin
        FCodSep := frmBaixaOrdProdAcabado.FSeparador;
        FObjItensAcabado := frmBaixaOrdProdAcabado.cdsProdutoAcabado;
        FObjItensEstrutura := frmBaixaOrdProdAcabado.cdsItens;

        try
          try
            pCriarFormularios(TfrmGravando, frmAguarde);
            frmAguarde.fExecutarAcao := fBaixarOrdemProducaProdutoAcabado;
            frmAguarde.lblGravando.Font.Size := 16;
            frmAguarde.ShowModal;
            Result := true;
          except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, 'TOrdPro.fOrdemProducaoProdutoAcabado');
            End;
          End;
        finally
          pFreeAndNil(frmAguarde);
        end;
      End;
    End;
  Finally
    FreeAndNil(frmBaixaOrdProdAcabado)
  End;
end;

function TOrdPro.fBaixarOrdemProducaProdutoAcabado(
  pgbStatus: TcxProgressBar): Boolean;
Var
  i : integer;
  fltQtdPro: Currency;
  strCodItem: String;
  strDocEnt: String;
  strDocSai: String;
  strAutInc: String;
  strCodErrosAuditoria: String;
Begin
  if fExisteNivelInferiorSemBaixa(FAutInc) then
  Begin
    If (blnTransacao) Then
    Begin
      fMensagem('ATENÇÃO', 'Não é possível baixar uma ordem de produção que tenha ordem de produção de nivel inferior em aberto', ['&OK']);
      TfrmExibeArvoreOrdProd.pExibeArvore(FCodPro);
      Result := False;
      Exit;
    End
    Else
      Raise EBaixaOrdemProducao.Create('Não é possível baixar uma ordem de produção que tenha ordem de produção de nivel inferior em aberto');
  End;

  Result := True;
  pAtuDados;
  FConfer := FCodSep;

  pInsereItensNovos;

  fAtualizaQtdSubProd(strCodPro, 1);

  //valida lotes dos subitens, editados no grid
  If Not FblnManutOrdProVidro Then
    if not fValidaSaldoLotesSubItens then
    begin
      Result := False;
      exit;
    end;

  Try
    objAuditoriaSaldo.Limpar;

    FDtaCad := fNow;
    If blnTransacao Then
      fStartTransaction;

    {*****************************}
    {* BAIXA A ORDEM DE PRODUÇÃO *}
    {**************************RV*}
    fltQtdPro := VarToStrDef(FobjItensAcabado.FieldByName('TOTBAI').Value,'1').ToDouble;
    pBaixarOrdemProducao(fltQtdPro);

    {**************************************}
    {* GRAVA MOVGER DOS PRODUTOS ACABADOS *}
    {***********************************RV*}
    If FobjItensAcabado.RecordCount > 0 Then
    Begin

      strDocEnt := fGravarMovGer(strCodCli, '1999', strAutInc);

      FobjItensAcabado.First;
      pgbStatus.Properties.Max := FobjItensAcabado.RecordCount;
      pgbStatus.Position  := 0;
      while Not FobjItensAcabado.Eof  do
      Begin
        pgbStatus.Position := FobjItensAcabado.RecNo;
        Application.ProcessMessages;

        strCodItem := FobjItensAcabado.FieldByName('CODITE').AsString;
        fltQtdPro  := FobjItensAcabado.FieldByName('QTDBAI').AsCurrency;

        //quandoconfigurado para utilizar o número da op como lote, cadastra o lote se ainda não houver no banco de dados
        pGeraLoteSequencial(strCodItem, FCodArm, FCodEmp);

        //monta o array dos lotes
        setLength(arrLotes, 0);
        if objLotInd.cdsLotInd.isEmpty then
          pAddArrLotes(FCodArm, fltQtdPro)
        else
        begin
          objLotInd.cdsLotInd.First;
          while not objLotInd.cdsLotInd.Eof do begin
            pAddArrLotes(objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString, objLotInd.cdsLotInd.FieldByName('QTD').AsFloat);

            //SE O LOTE NÃO EXISTIR, CADASTRA NA CADLOT
            If fCampoTabela('COUNT(0)', 'CADLOT', ['LOT_CODITE','LOT_NUMLOT', 'LOT_CODEMP'], [strCodItem, objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString, FCodEmp]) = '0' then
              pGerarLote(objLotInd.cdsLotInd.FieldByName('NUMLOT').AsString, False, strCodItem);

            objLotInd.cdsLotInd.next;
          end;
        end;


        for i := 0 to High(arrLotes) do
        begin
          {*************************************}
          {* GRAVA MOVDET                      *}
          {**********************************RV*}
          If Not fGravarMovDet(strAutInc, strDocEnt, strCodItem,  strCodCli, arrLotes[i].fltQtd,
             '1999', strCodPro, arrLotes[i].strNumLot) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;

          {*************************************}
          {* ATUALIZA SALDO                    *}
          {**********************************RV*}
          If Not fAtualizaEstoqueCadIte(strCodItem,
                                       'E',
                                        arrLotes[i].fltQtd,
                                        0.0,
                                        arrLotes[i].strNumLot,
                                        False) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;

          ReprocessarItem(strCodItem, '', False);
        end;

        {**********************************************}
        {* GRAVA PREÇOS DO PRODUTO ACABADO            *}
        {*******************************************RV*}
        If (fCfgSis('APORPR') = 'S') Then
        Begin
          If Not fAtuPrecosProAca(strCodIte, fltQtdPro) Then
          Begin
            Result := False;
            If blnTransacao Then
              fRollBack;
            Exit;
          End;
        End;

        FobjItensAcabado.Next;
      End;
    End;

    If Not FblnApenasMovimentaProdAcabado Then
    Begin

      If cdsIteEst.RecordCount > 0 Then
      begin
        {**************************************}
        {* GRAVA MOVGER DOS SUBITENS          *}
        {***********************************RV*}
        strAutInc := '';
        strDocSai := fGravarMovGer(strCodCli, '5999', strAutInc);

        {***************************************}
        {* ATUALIZA SALDO DOS PROD. ESTRUTURAS *}
        {************************************RV*}
        pgbStatus.Properties.Max := cdsIteEst.RecordCount;
        pgbStatus.Position  := 0;
        Application.ProcessMessages;
        cdsIteEst.First;

        pPreAltDefineVariaveisAltPre(fNow, 'ORDEM DE PRODUCAO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);


        While Not cdsIteEst.Eof Do
        Begin
          pgbStatus.Position := cdsIteEst.RecNo;
          Application.ProcessMessages;
          //ALTERA OS LOTES NA DETPRO
          FObjItensEstrutura.First;
          pAtualizarLoteDetPro(cdsIteEst.FieldByName('AUTOINCREM').AsString, cdsIteEst.FieldByName('NUMLOT').AsString);
          If FObjItensEstrutura.Locate('AUTINC', cdsIteEst.FieldByName('AUTOINCREM').AsString, []) Then
          Begin
            If (FObjItensEstrutura.FieldByName('QTDBAI').AsFloat > 0) Then
            Begin
              {*************************************}
              {* GRAVA MOVDET                      *}
              {**********************************RV*}
              If Not fGravarMovDet(strAutInc, strDocSai, cdsIteEst.FieldByName('DOP_ITESUB').AsString,  strCodCli, FObjItensEstrutura.FieldByName('QTDBAI').AsFloat,
                 '5999', strCodPro, cdsIteEst.FieldByName('NUMLOT').AsString) Then
              Begin
                Result := False;
                If blnTransacao Then
                  fRollBack;
                Exit;
              End;

              If Not fAtualizaEstoqueCadIte(cdsIteEst.FieldByName('DOP_ITESUB').AsString,
                                           'S',
                                            FObjItensEstrutura.FieldByName('QTDBAI').AsFloat,
                                            0.0,
                                            cdsIteEst.FieldByName('NUMLOT').AsString,
                                            False) Then
              Begin
                Result := False;
                If blnTransacao Then
                  fRollBack;
                Exit;
              End;

              ReprocessarItem(cdsIteEst.FieldByName('DOP_ITESUB').AsString, '', False);

              {**********************************************}
              {* CALCULA PREÇO DE COMPRA DO PRODUTO ACABADO *}
              {*******************************************RV*}

            End;
            cdsIteEst.Next;
          End;
        End;
        If result Then
          pAtualizaCusto;

        cdsIteEst.Close;

      End;
    End;

    If blnTransacao Then
    Begin
      If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;

      If Result Then
      Begin
        fCommit;
        objLotInd.Clear; //limpa lotes individuais
      End
      Else
        fRollBack;
    End;

    if Result and blnTransacao then
    begin
      pImprimeEtiqueta(fltQtdPro);
      if blnTransacao Then
        fMensagem('','Ordem de produção baixada com sucesso!',['&OK']);
    end;

  Except
    On E: Exception Do
    Begin
      If blnTransacao Then
        fRollBack;
      strAgrupadorPreAlt := '';

      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TOrdPro.pBaixarOrdemProducao(fltQtdPro : Double);
begin
  With qryOrdPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE                                         ');
    SQL.Add('  MOVPRO                                       ');
    SQL.Add('SET                                            ');

    If (FQtdApr <= fltQtdPro) or (fCfgSis('BXOPPA', varString) = 'B') Or FblnManutOrdProVidro Then
    Begin
      SQL.Add('  PRO_DTABAI = ' + fCurrentDate + ',         ');
      SQL.Add('  PRO_HORBAI = ' + fCurrentDate + ',         ');
    End;

    If Not fEmptyStr(FCodArm) Then
    begin
      SQL.Add('  PRO_NUMLOT = :NUMLOT,                      ');
      ParamByName('NUMLOT').AsString := FCodArm;
    end;

    SQL.Add('  PRO_QTDPRO = IFNULL(PRO_QTDPRO,0) + :QTDPRO, ');
    SQL.Add('  PRO_CONFER = :CONFER                         ');
    SQL.Add('WHERE                                          ');
    SQL.Add('  PRO_CODPRO = :CODPRO AND                     ');
    SQL.Add('  PRO_CODEMP = :CODEMP                         ');

    ParamByName('CODPRO').AsString := strCodPro;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    ParamByName('QTDPRO').AsFloat  := fltQtdPro;
    ParamByName('CONFER').AsString := strConfer;

    ExecSQL;
    Close;
  End;
end;

function TOrdPro.fGravarMovGer(strCodCli, strClaFis: String; var strAutInc: String): String;
Var
  recServicos: TDadosServicos;
  arrDuplic : TarrDuplicata;
  blnGravou: Boolean;
begin
  FillChar(recServicos, Sizeof(recServicos) , #0);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
  Result := fRetSequencial('PRO_OP', VS_strCodEmp, fTamDocCadRec);

  blnGravou := fGravaMovGer(strAutInc,
    Result,
    'OP',
    VS_strCodEmp,
    '',
    strLoginUsuarioLogado,
    '',
    strCodCli,
    'C',
    FDtaCad,
    fTime(),
    FDtaCad,
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
    'BAIXA DE ORDEM DE PRODUÇÃO',
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
    strClaFis,
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
    strCodPro,
    0,
    0.0,
    0,
    '',          // Consumidor final
    'N',
    '',
    '',          // Operador da expedição
    '',          // Separador da Expedição
    '',
    '',
    'N',         // Entrega Futura
    FALSE,       // Baixa de Entrega Futura
    0,           // Margem de Lucro
    0.0,         // Base do retido (caso tivesse) com ipi e frete de entrada
    0.0,         // Valor do retido considerando a base acima.
    'N',         // Gerar produção fora da loja
    '',          // Numero do Registro - Correios ou Transportadora
    VS_Date,     // Data de Entrega no Romaneio
    '',          // Classificação fiscal 4
    'N',         // AUTO-SERVICO
    '',          // Evento
    FEndEnt,     // AUTOINC DO ENDEREÇO DE ENTREGA
    '',          // Conteúdo do CNFNFE
    '',          // Motivo da Devolução
    '',
    True);   // Imprime Duplicatas na NF-e

  If blnGravou Then
    objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');
end;

function TOrdPro.fGravarMovDet(strAutInc, strNumDoc, strCodIte,  strCodCli: String; fltQtd: Currency; strClaFis, strCodPro, strNumLot: String): Boolean;
Var
  strIncDet,
  strMarca,
  strDescri,
  strRefere,
  strUnidad: String;
Begin
  pRetDadosItem(strCodIte, strDescri, strRefere, strMarca, strUnidad);

  Result := fGravaMovDet(strIncDet,
    strAutInc,
    strNumDoc,
    'OP',
    VS_strCodEmp,
    strCodIte,
    strLoginUsuarioLogado,
    '',
    strMarca,
    '',
    strCodCli,
    FDtaCad,
    fTime(),
    FDtaCad,
    '01000',
    'C',
    '',
    strDescri,
    strRefere,
    strUnidad,
    '',
    fltQtd,
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
    '',
    0,
    0,
    0,
    strClaFis,
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
    False,
    '',
    '',
    '', // Empresa do Faturamento
    0,
    '',
    '',
    0,
    'NOR',
    '',
    '',
    0,
    'N',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    0,
    0,
    '',
    0,
    0,
    0,
    '',
    '',
    '',
    '',
    '',
    '',
    0,
    '',
    '',
    0,
    '',
    '',
    '',
    '',
    '',
    0,
    strCodPro,
    '',
    '',
    0,
    0,
    0.0,
    '',
    '',
    False,
    False,
    '',                                                             //  Especie da Entrega Fututa
    '',                                                             //  Documento da Entrega Fututa
    '',
    '',                                                             //  Empresa da Entrega Fututa
    '',
    '',
    '',
    '',
    0.0,
    '',
    0.0,
    0.0,
    0,
    'N',
    '',
    0,
    0,
    0,
    0,
    '',
    strNumLot, // strNumLot
    'N',                   // strPigBas
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
    '',
    '',
    '',
    0,
    0,
    0,
    0);
End;

procedure TOrdPro.pAtualizarLoteDetPro(strAutInc, strNumLot: String);
Var
  qryAux : TUniQuery;
Begin
  qryAux := fCriaQuery(nil);
  Try
    qryAux.SQL.Add('UPDATE');
    qryAux.SQL.Add('  DETPRO');
    qryAux.SQL.Add('SET');
    qryAux.SQL.Add('  DOP_NUMLOT = :NUMLOT');
    qryAux.SQL.Add('WHERE');
    qryAux.SQL.Add('  AUTOINCREM = :AUTOINCREM');
    qryAux.SQL.Add('  AND IFNULL(DOP_NUMLOT,"") <> :NUMLOT');
    qryAux.Params.ParamByName('AUTOINCREM').AsString := strAutInc;
    qryAux.Params.ParamByName('NUMLOT').AsString := strNumLot;
    qryAux.ExecSQL;
  Finally
    qryAux.Free;
  End;
End;

function TOrdPro.fRetornaPrecoMedio(fltQtdPro, fltSaldosAntPro, fltPreMedAntPro: Double): Double;
Var
  qryConsulta: TUniQuery;
Begin
           //FCodIte
  qryConsulta:= fCriaQuery();
  Try

    Result := fCalculaPrecoMedio('',// Código Fiscal
                                 '', // Classificação Fiscal
                                 fltPreMedAntPro, // Preço medio anterior
                                 fltSaldosAntPro, // Saldo anterior
                                 fltQtdPro, // Quantidade de entrada
                                 fltTotImpUlt, // Unitario com Impostos
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
  Finally
    FreeAndNil(qryConsulta);
  End;

End;

function TOrdPro.fSalvaDadosItemMovPro(strSeqGer: String; strCodIte: String): Boolean;
CONST
  SQL_CONSULTA_ITEM = ' SELECT         '+
                      '  C.ITE_CODITE, '+
                      '  ITE_PRECOM,   '+
                      '  ITE_IMPULT,   '+
                      '  ITE_PREMED    '+
                      ' FROM CADITE C  '+
                      '    INNER JOIN ITEGER I '+
                      '      ON I.ITE_CODITE = C.ITE_CODITE AND '+
                      '         I.ITE_CODEMP = :CODEMP '+
                      ' WHERE '+
                      '    C.ITE_CODITE = :CODITE ';

  SQL_INSERT_MOVSAV = ' INSERT INTO MOVSAV(   '+
                      '   ITE_PRECOM,         '+
                      '   ITE_PREMED,         '+
                      '   ITE_IMPULT,         '+
                      '   ITE_CODITE,         '+
                      '   ITE_SEQGER,         '+
                      '   ITE_DTABAI,         '+
                      '   ITE_HORBAI,         '+
                      '   ITE_CODEMP) VALUES( '+
                      '   :PRECOM,            '+
                      '   :PREMED,            '+
                      '   :IMPULT,            '+
                      '   :CODITE,            '+
                      '   :SEQGER,            '+
                      '   :DTABAI,            '+
                      '   :HORBAI,            '+
                      '   :CODEMP)            ';

  SQL_UPDATE_MOVSAV = ' UPDATE MOVSAV SET          '+
                      '   ITE_PRECOM = :PRECOM,    '+
                      '   ITE_PREMED = :PREMED,    '+
                      '   ITE_IMPULT = :IMPULT,    '+
                      '   ITE_DTABAI = :DTABAI,    '+
                      '   ITE_HORBAI = :HORBAI     '+
                      ' WHERE ITE_SEQGER = :SEQGER ';


Var
  qryOrdSav, qryCadIte: TUniQuery;
Begin

  Result := True;

  qryOrdSav := fCriaQuery(Self);
  qryCadIte := fCriaQuery(Self);
  Try
    qryCadIte.Close;
    qryCadIte.SQL.Clear;
    qryCadIte.SQL.Add(SQL_CONSULTA_ITEM);
    qryCadIte.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryCadIte.ParamByName('CODITE').AsString:= strCodIte;
    qryCadIte.Open;

    If Not(qryCadIte.IsEmpty) Then
    Begin

      If fExisteOrdSav(strSeqGer) Then
      Begin
        qryOrdSav.Close;
        qryOrdSav.SQL.Clear;
        qryOrdSav.SQL.Add(SQL_UPDATE_MOVSAV);
        qryOrdSav.ParamByName('SEQGER').AsString:= strSeqGer;
        qryOrdSav.ParamByName('PRECOM').AsFloat := qryCadIte.FieldByName('ITE_PRECOM').AsFloat;
        qryOrdSav.ParamByName('PREMED').AsFloat := qryCadIte.FieldByName('ITE_PREMED').AsFloat;
        qryOrdSav.ParamByName('IMPULT').AsFloat := qryCadIte.FieldByName('ITE_IMPULT').AsFloat;
        qryOrdSav.ParamByName('DTABAI').AsDate  := fNow;
        qryOrdSav.ParamByName('HORBAI').AsTime  := fTime();
        qryOrdSav.ExecSQL;
      End
      Else
      Begin
        qryOrdSav.Close;
        qryOrdSav.SQL.Clear;
        qryOrdSav.SQL.Add(SQL_INSERT_MOVSAV);
        qryOrdSav.ParamByName('SEQGER').AsString:= strSeqGer;
        qryOrdSav.ParamByName('PRECOM').AsFloat := qryCadIte.FieldByName('ITE_PRECOM').AsFloat;
        qryOrdSav.ParamByName('PREMED').AsFloat := qryCadIte.FieldByName('ITE_PREMED').AsFloat;
        qryOrdSav.ParamByName('IMPULT').AsFloat := qryCadIte.FieldByName('ITE_IMPULT').AsFloat;
        qryOrdSav.ParamByName('CODITE').AsString:= qryCadIte.FieldByName('ITE_CODITE').AsString;
        qryOrdSav.ParamByName('DTABAI').AsDate  := vs_Date;
        qryOrdSav.ParamByName('HORBAI').AsString:= FormatDateTime('HH:MM:SS', fNow());
        qryOrdSav.ParamByName('CODEMP').AsString:= VS_strCodEmp;
        qryOrdSav.ExecSQL;
      End;
    End;

    FreeAndNil(qryOrdSav);
    FreeAndNil(qryCadIte);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

End;

procedure TOrdPro.pInsereItensNovos;
var intNumFase: Integer;
    qryCommand: TUniQuery;
    strAutInc: String;
    strSeqMovPro: String;
begin
  intNumFase := FObjItensEstrutura.RecordCount;
  FObjItensEstrutura.Filtered := False;
  FObjItensEstrutura.Filter := 'AUTINC = ' + QuotedStr('') + ' AND  QTDBAI > 0';
  FObjItensEstrutura.Filtered := True;
  qryCommand := fCriaQuery;
  Try
    strSeqMovPro := FObjItensEstrutura.FieldByName('SEQGER').AsString;

    While not FObjItensEstrutura.IsEmpty Do
    Begin
      qryCommand.SQL.Add('INSERT INTO DETPRO ( DOP_SEQGER,  DOP_SEQUEN,   DOP_CODEMP,   DOP_ITESUB,  DOP_QTDITE,  DOP_NUMLOT,  DOP_NUMFAS, AUTOINCREM)');
      qryCommand.SQL.Add('            VALUES (:DOP_SEQGER, :DOP_SEQUEN,  :DOP_CODEMP,  :DOP_ITESUB, :DOP_QTDITE, :DOP_NUMLOT, :DOP_NUMFAS, :AUTOINCREM)');

      qryCommand.ParamByName('DOP_SEQGER').AsString := strSeqMovPro;
      qryCommand.ParamByName('DOP_SEQUEN').AsString := fAtualizaProCod('DETPRO', 'DOP_SEQUEN');
      qryCommand.ParamByName('DOP_CODEMP').AsString := VS_StrCodEmp;
      qryCommand.ParamByName('DOP_ITESUB').AsString := FObjItensEstrutura.FieldByName('CODITE').AsString;
      qryCommand.ParamByName('DOP_QTDITE').AsFloat :=  FObjItensEstrutura.FieldByName('QTDBAI').AsFloat;
      Inc(intNumFase);
      qryCommand.ParamByName('DOP_NUMFAS').AsInteger := intNumFase;
      qryCommand.ParamByName('DOP_NUMLOT').Clear;
      strAutInc := fRetAutoincrem('DETPRO', VS_StrCodEmp);
      qryCommand.ParamByName('AUTOINCREM').AsString := strAutInc;
      qryCommand.ExecSQL;

      FObjItensEstrutura.Edit;
      FObjItensEstrutura.FieldByName('AUTINC').AsString := strAutInc;
      FObjItensEstrutura.Post;


    End;
  Finally
    FObjItensEstrutura.Filtered := False;
    FObjItensEstrutura.Filter := '';
    FreeAndNil(qryCommand)
  End;




end;

function TOrdPro.fGravaDetOrdProFases(strSeqMat, strAutIncFase: String; cdsSubProdutos: TUniClientDataSet): Boolean;
Var
    strSql     : String;
    prcScroll  : TprcScroll;
    objOPFilha : TobjOPFilha;
    objOPPai   : TobjOPPai;
    strAutInc  : String;
begin

  Result := True;

  Try

    //**********************************************************//
    // LIMPA OS DADOS ANTERIORES DA FASE JA GRAVADOS NO BANCO  //
    //*****************************************************TK*//
    With qryDetPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE  ');
      SQL.Add('FROM     ');
      SQL.Add('  DETPRO ');
      SQL.Add('WHERE ');
      SQL.Add('  DOP_SEQFAS = :SEQFAS ');
      ParamByName('SEQFAS').AsString := strAutIncFase;
      ExecSQL;
      Close;
    End;

    With cdsSubProdutos Do
    Begin
      pDisableControls(cdsSubProdutos, prcScroll);
      First;

      While Not Eof Do
      Begin
        Try
          If fEmptyStr(FieldByName('SEQFAS').AsString) Then
          Begin
            Continue;
            Next;
          End;

          strSql := '';
          strSql := strSql + 'INSERT INTO DETPRO ( ';
          strSql := strSql + '  DOP_SEQGER,        ';
          strSql := strSql + '  DOP_SEQUEN,        ';
          strSql := strSql + '  DOP_CODEMP,        ';
          strSql := strSql + '  DOP_ITESUB,        ';
          strSql := strSql + '  DOP_QTDITE,        ';
          strSql := strSql + '  DOP_METRAG,        ';
          strSql := strSql + '  DOP_NUMLOT,        ';
          strSql := strSql + '  DOP_NUMFAS,        ';
          strSql := strSql + '  DOP_SEQFAS,        ';
          strSql := strSql + '  AUTOINCREM)        ';
          strSql := strSql + 'VALUES (             ';
          strSql := strSql + '  :SEQGER,           ';
          strSql := strSql + '  :SEQUEN,           ';
          strSql := strSql + '  :CODEMP,           ';
          strSql := strSql + '  :ITESUB,           ';
          strSql := strSql + '  :QTDITE,           ';
          strSql := strSql + '  :METRAG,           ';
          strSql := strSql + '  :NUMLOT,           ';
          strSql := strSql + '  :NUMFAS,           ';
          strSql := strSql + '  :SEQFAS,           ';
          strSql := strSql + '  :AUTINC)           ';

          qryDetPro.Close;
          qryDetPro.SQL.Clear;
          qryDetPro.SQL.Add(strSql);

          qryDetPro.ParamByName('SEQGER').AsString  := strSeqMat;
          qryDetPro.ParamByName('SEQUEN').AsString  := fAtualizaProCod('DETPRO', 'DOP_SEQUEN');
          qryDetPro.ParamByName('CODEMP').AsString  := VS_strCodEmp;
          qryDetPro.ParamByName('ITESUB').AsString  := FieldByName('ITESUB').AsString;
          qryDetPro.ParamByName('QTDITE').AsFloat   := FieldByName('QTDITE').AsFloat;
          qryDetPro.ParamByName('METRAG').AsFloat   := FieldByName('METRAG').AsFloat;
          qryDetPro.ParamByName('AUTINC').AsString  := fRetAutoIncrem('DETPRO', VS_strCodEmp);
          qryDetPro.ParamByName('NUMLOT').AsString  := FieldByName('NUMLOT').AsString;
          If qryDetPro.ParamByName('NUMLOT').AsString = '' Then
            qryDetPro.ParamByName('NUMLOT').Clear;

          qryDetPro.ParamByName('NUMFAS').AsInteger  := fGetProximoSequenDetProFase(strSeqMat);

          qryDetPro.ParamByName('SEQFAS').AsString  := strAutIncFase;
          If fEmptyStr(strAutIncFase) Then
            qryDetPro.ParamByName('SEQFAS').Clear;

          qryDetPro.ExecSQL;

        Except
          On E: Exception Do
          Begin
            fRollBack;
            Raise Exception.Create(E.Message);
          End;
        End;

        {**************************}
        {* ATUALIZA QTD RESERVADA *}
        {***********************FS*}
        ReprocessarItem(FieldByName('ITESUB').AsString, '', False);

        Next;
      End;

      pEnableControls(cdsSubProdutos, prcScroll);

    End;


    If fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque Then
    Begin
      pSetSeqUsa(FCodIte, FAutInc);

      For objOPFilha in lstOPFilha do
      Begin
        if objOPFilha.fltQtdApr > 0 Then
        Begin
          strAutInc := fGeraOrdemProducaoFilha(objOPFilha.strCodIte, objOPFilha.fltQtdApr);
          pSetSeqUsa(objOPFilha.strCodIte, strAutInc);
          pSetSeqGer(objOPFilha.strCodIte, strAutInc);
        End;
      End;

      strSql := '';
      strSql := strSql + ' INSERT INTO ORIPRO ( ';
      strSql := strSql + '  AUTOINCREM,         ';
      strSql := strSql + '  PRO_SEQGER,         ';
      strSql := strSql + '  PRO_SEQUSA,         ';
      strSql := strSql + '  PRO_QTDUSA,         ';
      strSql := strSql + '  PRO_USAEST,         ';
      strSql := strSql + '  PRO_QTDSUB)         ';
      strSql := strSql + '  VALUES (            ';
      strSql := strSql + '  :AUTINC,            ';
      strSql := strSql + '  :SEQGER,            ';
      strSql := strSql + '  :SEQUSA,            ';
      strSql := strSql + '  :QTDUSA,            ';
      strSql := strSql + '  :USAEST,            ';
      strSql := strSql + '  :QTDSUB)            ';




        qryDetPro.SQL.Clear;
        qryDetPro.SQL.Add(strSql);

        For objOPPai in lstOPPai do
        Begin
          if (not fEmptyStr(objOPPai.strSeqUsa)) and (not fEmptyStr(objOPPai.strSeqGer)) and (objOPPai.fltQtdApr > 0) then
          begin
            qryDetPro.ParamByName('AUTINC').AsString := fRetAutoIncrem('ORIPRO', VS_strCodEmp);
            qryDetPro.ParamByName('SEQGER').AsString := objOPPai.strSeqGer;
            qryDetPro.ParamByName('SEQUSA').AsString := objOPPai.strSeqUsa;
            qryDetPro.ParamByName('QTDSUB').AsFloat  := objOPPai.fltQtdUsa;
            qryDetPro.ParamByName('USAEST').AsFloat  := objOPPai.fltQtdEtq;
            qryDetPro.ParamByName('QTDUSA').AsFloat  := objOPPai.fltQtdApr;


            qryDetPro.ExecSQL;
          end;
        End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fGravaDetOrdProFases]');
    End;
  End;

end;

function TOrdPro.fDefinirCorrecoesFases: Boolean;
var
  qryDel,
  qryIns: TUniQuery;
begin
  qryDel := fCriaQuery;
  qryDel.SQL.Clear;
  qryIns := fCriaQuery;
  Try
    Try
      qryDel.SQL.Add('DELETE FROM DETPRO WHERE AUTOINCREM = :AUTINC;');
      qryIns.SQL.Add('DELETE FROM RFGORD WHERE ORD_SEQORD = :SEQORD;');
      qryIns.ParamByName('SEQORD').AsString := strAutInc;
      qryIns.ExecSQL;

      qryIns.SQL.Clear;
      qryIns.SQL.Add('INSERT INTO RFGORD (AUTOINCREM, ORD_SEQORD, ORD_CODITE, ORD_NUMLOT, ORD_QTDITE, ORD_DTACAD, ORD_HRACAD) ');
      qryIns.SQL.Add('VALUES (:AUTINC, :SEQORD, :CODITE, :NUMLOT, :QTDITE, CURDATE(), CURTIME() );');

      FcdsItensDefinidosCorrecao.Filter := 'ITE_EXCLUI = ''S''';
      FcdsItensDefinidosCorrecao.Filtered := True;
      FcdsItensDefinidosCorrecao.First;
      While Not FcdsItensDefinidosCorrecao.Eof Do
      Begin
        If FcdsItensDefinidosCorrecao.FieldByName('ITE_DESTIN').AsString = 'R' Then
        Begin
          qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('RFGORD', VS_StrCodEmp);
          qryIns.ParamByName('SEQORD').AsString := strAutInc;
          qryIns.ParamByName('CODITE').AsString := FcdsItensDefinidosCorrecao.FieldByName('ITE_CODITE').AsString;
          qryIns.ParamByName('NUMLOT').AsString := FcdsItensDefinidosCorrecao.FieldByName('DOP_NUMLOT').AsString;
          qryIns.ParamByName('QTDITE').AsFloat  := FcdsItensDefinidosCorrecao.FieldByName('DOP_QTDITE').AsFloat;
          qryIns.ExecSQL;
        End;

        qryDel.ParamByName('AUTINC').AsString  := FcdsItensDefinidosCorrecao.FieldByName('DOP_AUTINC').AsString;
        qryDel.ExecSQL;

        ReprocessarItem(FcdsItensDefinidosCorrecao.FieldByName('ITE_CODITE').AsString, VS_StrCodEmp, False);

        FcdsItensDefinidosCorrecao.Next;
      End;
      Result := True;
    Except On
      E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TOrdPro.fDefinirCorrecoesFases');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

Function TOrdPro.fCarregaOPMonitoramento(strCodBar: String): Boolean;
  Var
    strAutOP: String;
Begin
  Try
    strAutOP := fCampoTabela('AUTOINCREM', 'MOVPRO', ['PRO_CODPRO','PRO_CODEMP'], [strCodBar,VS_StrCodEmp]);

    If fEmptyStr(strAutOP) Then
    Begin
      Result := False;
      pMensagemOk('Ordem de produção não encontrada!');
      Exit;
    End;

    If TOrdPro.fOrdemProducaoBaixada(strCodBar, VS_StrCodEmp) Then
    Begin
      Result := False;
      pMensagemOk('Ordem de produção já baixada!');
      Exit;
    End;

    If Not Assigned(objMonitor) Then
      objMonitor := TOrdProMonitoramento.Create(Self);

    Result := objMonitor.fCarregaFases(strAutOP);

    If Not Result Then
      pMensagemOk('Não há fases cadastradas para essa O.P.!');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdPro.fCarregaOPMonitoramento]');
    End;
  End;
End;

function TOrdPro.fGravarFasesDaOrdem(AStrAutIncOrd, AStrCodIteEstrutura: String): Boolean;
Var
  qryBusca,
  qryIns: TUniQuery;
Begin
  Try
    Result := True;
    qryBusca := fCriaQuery;
    qryIns := fCriaQuery;
    Try
      qryIns.SQL.Clear;
      qryIns.SQL.Add('DELETE FROM FASORD WHERE ORD_SEQORD = :INCORD');
      qryIns.ParamByName('INCORD').AsString := AStrAutIncOrd;
      qryIns.ExecSQL;

      qryIns.SQL.Clear;
      qryIns.SQL.Add('INSERT INTO FASORD(AUTOINCREM, ORD_SEQORD, ORD_SEQFAS) VALUES (:AUTINC, :INCORD, :INCFAS)');

      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(' SELECT FMT.MAT_SEQFAS AS INCFAS FROM FASMAT FMT           ');
      qryBusca.SQL.Add(' INNER JOIN GERMAT GMT ON FMT.MAT_SEQMAT = GMT.AUTOINCREM  ');
      qryBusca.SQL.Add(' AND GMT.GMT_CODITE = :CODITE;                             ');

      qryBusca.ParamByName('CODITE').AsString := AStrCodIteEstrutura;
      qryBusca.Open;

      qryBusca.First;
      While not qryBusca.Eof do
      Begin
        qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('FASORD', VS_StrCodEmp);
        qryIns.ParamByName('INCORD').AsString := AStrAutIncOrd;
        qryIns.ParamByName('INCFAS').AsString := qryBusca.FieldByName('INCFAS').AsString;
        qryIns.ExecSQL;

        qryBusca.Next;
      End;

    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TOrdPro.fGravarFasesDaOrdem]');
      End;
    End;
  Finally
    FreeAndNil(qryBusca);
    FreeAndNil(qryIns);
  End;
End;

function TOrdPro.fGetItensCorrecao: String;
Begin
  Result := '';
  If Not Assigned(FcdsItensDefinidosCorrecao) Then
    Exit;
  Try
    FcdsItensDefinidosCorrecao.First;
    FcdsItensDefinidosCorrecao.Filter := ' ITE_EXCLUI = ''S''';
    FcdsItensDefinidosCorrecao.Filtered := True;
    While Not FcdsItensDefinidosCorrecao.Eof Do
    Begin
      Result := Result + QuotedStr(FcdsItensDefinidosCorrecao.FieldByName('DOP_AUTINC').AsString);
      If FcdsItensDefinidosCorrecao.RecNo <> FcdsItensDefinidosCorrecao.RecordCount Then
        Result := Result + ',';
      FcdsItensDefinidosCorrecao.Next;
    End;
  Finally
    FcdsItensDefinidosCorrecao.Filter := '';
    FcdsItensDefinidosCorrecao.Filtered := False;
  End;
End;

function TOrdPro.fGetProximoSequenDetProFase(AStrSeqOrd: String): Integer;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT MAX(DOP_NUMFAS)+1 AS NEXT_COD FROM DETPRO WHERE DOP_SEQGER = :AUTINC');
    qryAux.ParamByName('AUTINC').AsString := AStrSeqOrd;
    qryAux.Open;

    Result := qryAux.FieldByName('NEXT_COD').AsInteger;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TOrdPro.fProdutoExisteNaEstrutura(AStrIteEstrut, AStrSubProd: String): Boolean;
var
  qryAux: TUniQuery;
  strTabGer : String;
  strTabDet : String;
begin
  strTabGer := 'GERMAT';
  strTabDet := 'DETMAT';

  If fModoEstruturaPersonalizada Then
  Begin
    strTabGer := 'GERPER';
    strTabDet := 'DETPER';
  End;

  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                                                        ');
    qryAux.SQL.Add('  GMT_CODITE AS CODITE                                        ');
    qryAux.SQL.Add('FROM                                                          ');
    qryAux.SQL.Add(strTabGer                                                       );
    qryAux.SQL.Add('  JOIN '+strTabDet+' ON DMT_SEQGER = '+strTabGer+'.AUTOINCREM ');
    qryAux.SQL.Add('WHERE                                                         ');
    qryAux.SQL.Add('  GMT_CODITE = :CODITE AND                                    ');
    qryAux.SQL.Add('  DMT_ITESUB = :ITESUB                                        ');

    If fModoEstruturaPersonalizada Then
    Begin
      qryAux.SQL.Add(' AND '+strTabGer+'.GMT_SEQPER = ' + FRecItem.intSeqPer.ToString);
      qryAux.SQL.Add(' AND '+strTabDet+'.DMT_SEQPER = ' + FRecItem.intSeqPer.ToString);
    End;

    qryAux.ParamByName('ITESUB').AsString := AStrSubProd;
    qryAux.ParamByName('CODITE').AsString := AStrIteEstrut;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;

end;

function TOrdPro.fQuantidadeProdutoNaEstrutura(AStrIteEstrut,
  AStrSubProd: String): Double;
var
  qryAux: TUniQuery;
  strTabGer : String;
  strTabDet : String;
begin
  strTabGer := 'GERMAT';
  strTabDet := 'DETMAT';

  If fModoEstruturaPersonalizada Then
  Begin
    strTabGer := 'GERPER';
    strTabDet := 'DETPER';
  End;

  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                                                        ');
    qryAux.SQL.Add('  DMT_QTDITE AS QTDITE                                        ');
    qryAux.SQL.Add('FROM                                                          ');
    qryAux.SQL.Add(strTabGer                                                       );
    qryAux.SQL.Add('  JOIN '+strTabDet+' ON DMT_SEQGER = '+strTabGer+'.AUTOINCREM ');
    qryAux.SQL.Add('WHERE                                                         ');
    qryAux.SQL.Add('  GMT_CODITE = :CODITE AND                                    ');
    qryAux.SQL.Add('  DMT_ITESUB = :ITESUB                                        ');

    If fModoEstruturaPersonalizada Then
    Begin
      qryAux.SQL.Add(' AND '+strTabGer+'.GMT_SEQPER = ' + FRecItem.intSeqPer.ToString);
      qryAux.SQL.Add(' AND '+strTabDet+'.DMT_SEQPER = ' + FRecItem.intSeqPer.ToString);
    End;

    qryAux.ParamByName('ITESUB').AsString := AStrSubProd;
    qryAux.ParamByName('CODITE').AsString := AStrIteEstrut;
    qryAux.Open;

    Result := qryAux.FieldByName('QTDITE').AsFloat;
  Finally
    FreeAndNil(qryAux);
  End;


end;

end.

