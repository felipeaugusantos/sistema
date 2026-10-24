unit untCadLote;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  cxProgressBar, Forms, UniClientDataSet, untClassPanelCx, Controls, EditFocus,
  untFuncoesSimples,
{$ENDIF}
  SysUtils, Classes, DB, Uni,
  untConstantes, untTypesSistema, untICadLote, DateUtils,
  untIExecutaSQLReplicacaoTinta, untFuncoesGenerica;

Type
  TTipoLote = (tplLote, tplArmazem);

Const
  ARR_TITCAD: Array[tplLote..tplArmazem] Of String =
    ('Cadastro de Lotes',
     'Cadastro de Armazéns');

  ARR_TITLAB: Array[tplLote..tplArmazem] Of String =
    ('Lote',
     'Cód Armaz.');

  ARR_TITLBS: Array[tplLote..tplArmazem] Of String =
    ('Lotes',
     'Armazéns');

  ARR_TITIMP: Array[tplLote..tplArmazem] Of String =
    ('LOTE',
     'ARMAZEM');

  ARR_DESCRI: Array[tplLote..tplArmazem] Of String =
    ('Lote',
     'Armazém');

Type
  TCadLot = Class (TComponent, ICadLot)
  Private
    FTemLotePrincipalDeTinta: String;
    FConAcu: Boolean;
    FConEst: Integer;
    FNumLot: String;
    FIdeLot: String;
    FCodIte: String;
    FDesIte: String;
    FCodEmp: String;
    FAutInc: String;
    FDtaVal: TDate;
    FDtaFab: TDate;
    FDtaBal: TDate;
    FSalBal: Double;
    FSaldos: Double;
    FML_Bal: Double;
    FSal_ML: Double;
    FPreVen: Double;
    FPreCus: Double;
    FVenTot: Double;
    FCusTot: Double;
    FDecUni: Integer;
    FDecQtd: Integer;
    FLocFis: String;
    FArmOPV: String;
    FArmPri: String;
    FArmPrC: String;
    FCapaci: Double;
    FPonRep: Double;

    FTipLot: TTipoLote;
    FTitCad: String;
    FTitLab: String;
    FTitLbs: String;
    FTitImp: String;
    FDescri: String;
    FGarPri: String;
    FPriTin: String;
    FColVal: boolean;
    FReplTinta: IExecutaSQLReplicacaoTinta;
    FArmPce: String;
    FIdxEntRetLot: Integer;

    FOpcDoc : String;
    FPreVee: Double;
    FVenToe: Double;
    FPriInd: String;

    Function  fExisteLotePrincipalProducao(strCodIte, strCodEmp: String): Boolean;
    Function  fExisteLotePrincipalProducaoIndustrial(strCodIte, strCodEmp: String): Boolean;

    Procedure pSetaTipoLote;

    function getDtaBal: string;
    function getDtaVal: string;
    function getDtaFab: string;
    function fGetStrTitLab : String;

    procedure setDtaBal(const Value: string);
    procedure setDtaVal(const Value: string);
    procedure setDtaFab(const Value: string);

    procedure setNumLot(const Value: String);
    procedure setCodIte(const Value: String);

    procedure setPreVen(const Value: Double);
    procedure setPreCus(const Value: Double);

    procedure setVenTot(const Value: Double);
    procedure setCusTot(const Value: Double);

    procedure setPonRep(const Value: Double);
    procedure setCapaci(const Value: Double);

    procedure setOpcDoc(const Value: String);

    Function fSQLPedidos: String;
    Function fSQLUpdatePedidos: String;
    Function fSQLUpdateSaldoCadLot: String;

    Procedure pSetaFatDor(strCodEmp, strCodIte, strNumLot: String);
    Procedure pUpdateFatDor(strAutInc, strNumLot: String; qryUpdate: TUniQuery);

    Function fSQLMovimentos(strTabela: String): String;
    Function fSQLUpdateMovDet(strTabela: String): String;
    Function fRetornaPrecoLoteDestinoEntrega: Boolean;


    Procedure pSetaMovDet(strTabDet, strCodEmp, strCodIte,
                          strNumLot: String; dtaDtaBal: TDate);

    Procedure pUpdateMovdet(strAutInc, strNumLot: String; qryUpdate: TUniQuery);

    Procedure pUpdateSaldoCadLot(strCodIte, strCodEmp, strNumLot: String; fltQtdIte: Double; qryUpdLot: TUniquery);
    function fRetornaLocalizacaoFisicaWMS(const AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual; const AstrCodEmp: String): String ;
    function fPodeGravarLote(const AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual; const AstrCodEmp: String): Boolean ;
    procedure setPreVee(const Value: Double);
    procedure setVenToe(const Value: Double);

  Public
    qryCadLot,
    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    strLotAnt: String;

    pgbStatusGravacao: TcxProgressBar;
    procedure pAfterOpen(Dataset: TDataSet);

    Class Function fRetLotesContagemAberta: String;
    Function  fExisteLotePrincipalOrcamentoPedidoVenda(strCodIte: String; strCodEmp: String): Boolean;
    Function  fExisteLotePrincipalVenda(strCodIte: String; strCodEmp: String): Boolean;
    Function  fExisteLotePrincipalGarantia(strCodIte: String; strCodEmp: String): Boolean;
    Function  fExisteLotePrincipalAluguelEquipamento(strCodIte: String; strCodEmp: String): Boolean;
    Function  fExisteLotePrincipalTintaMaquina(strCodIte: String; strCodEmp: String): Boolean;
    function fExisteAlgumLotePrincipalTintaMaquina: Boolean;
    Function  fExisteLotePrincipalOrdemProducao(strCodIte: String; strCodEmp: String): Boolean;
    function fEhPrincipalGarantia(strCodIte, strNumLot: String): Boolean;
    function fExisteLoteGarantia(strCodIte: String; strCodEmp: String): Boolean;
    Function fExisteLotePrincipalConsertoEquipamento(const strCodIte : String; const strCodEmp : String): Boolean;
    Function  fExisteLotePrincipalCompra(strCodIte: String; strCodEmp: String = ''): String;

    Function  fRetPrimeiroLote(strCodIte, strCodEmp: String): String;
    Function  fQtdDeLotes(strCodIte: String; strCodEmp: String = '';  strNumLot: String = ''; blnSoAtivos: Boolean = True;  blnEntraDefinir: Boolean = False;  blnEntraGarantia: Boolean = False): Integer;

    Function  fLoteAtivo(strNumLote, strCodEmp, strCodItem: String): Boolean;

    {function fTratarSaldoEntregaFutura(qryLote: TUniQuery; AblnJaTemLote: Boolean): Boolean;}
    function fJaTemLote(strCodIte, strCodEmp: String): Boolean;

    function  fAtivarLote(strAutInc: String; blnRemessaDevolucao: Boolean = False): Boolean;

    Function fReplicaLote: Boolean;

    Function fSqlLotIte(strCodIte: String): String;

    Function fRetQtdM2LiquidoLote(strCodIte,strCodEmp, strNumLot : String) : Double;

    function fRetSQLLoteItemEmp(strCodIte, strCodEmp: String): String;

    Property tplTipLot: TTipoLote Read FTipLot;
    Property strTitCad: String Read FTitCad;
    Property strTitLab: String Read fGetStrTitLab;
    Property strTitLbs: String Read FTitLbs;
    Property strTitImp: String Read FTitImp;
    Property strDescri: String Read FDescri;
    Property strCodEmp: String Read FCodEmp   Write FCodEmp;
    Property strAutInc: String Read FAutInc   Write FAutInc;
    Property strNumLot: String Read FNumLot   Write setNumLot;
    Property strCodIte: String Read FCodIte   Write setCodIte;
    Property strDesIte: String Read FDesIte   Write FDesIte;

    Property strDtaBal: String Read getDtaBal  Write setDtaBal;
    Property strDtaVal: String Read getDtaVal  Write setDtaVal;
    Property strDtaFab: String Read getDtaFab  Write setDtaFab;

    Property intDecUni: Integer Read FDecUni;
    Property intDecQtd: Integer Read FDecQtd;

    Property strLocFis: String Read FLocFis   Write FLocFis;

    Property fltSalBal: Double Read FSalBal;
    Property fltSaldos: Double Read FSaldos;

    Property fltML_Bal: Double Read FML_Bal;
    Property fltSal_ML: Double Read FSal_ML;

    Property fltPreCus: Double Read FPreCus Write setPreCus;
    Property fltPreVen: Double Read FPreVen Write setPreVen;
    Property fltPreVee: Double Read FPreVee Write setPreVee;
    Property fltVenToe: Double Read FVenToe Write setVenToe;

    Property fltCusTot: Double Read FCusTot Write setCusTot;
    Property fltVenTot: Double Read FVenTot Write setVenTot;

    Property fltCapaci: Double Read FCapaci Write setCapaci;
    Property fltPonRep: Double Read FPonRep Write setPonRep;
    Property strArmOPV: String Read FArmOPV Write FArmOPV;
    Property strArmPri: String Read FArmPri Write FArmPri;
    Property strPriInd: String Read FPriInd Write FPriInd;
    Property strArmPrC: String Read FArmPrC Write FArmPrC;
    Property strGarPri: String Read FGarPri Write FGarPri;
    Property strPriTin: String Read FPriTin Write FPriTin;
    Property blnColVal: Boolean Read FColVal Write FColVal;
    Property strArmPce: String Read FArmPce Write FArmPce;

    Property strOpcDoc: String Read FOpcDoc Write setOpcDoc;

    Property intIdxEntRetLot: Integer Read FIdxEntRetLot Write FIdxEntRetLot;

    procedure pSetaReplicadorTinta(objReplTinta: IExecutaSQLReplicacaoTinta);
    Function fRetPrecoVendaLote(fltQtdIte: Double; strTabPre: String): Double;
    Function fRetPrecoCustoLote(fltQtdIte: Double): Double;
    function fAtualizaEstoqueLote(strCodIte,
                                 strEntSai,
                                 strNumLot: String;
                                 fltQtdIte: Double;
                                 strCodEmp: String = '';
                                 AUsarBatchSaldos: Boolean = False): Boolean;

    function fAtualizaEstoqueMLLote(strCodIte,
                                    strEntSai,
                                    strNumLot    : String;
                                    fltQtdML     : Double;
                                    objReplTinta : IExecutaSQLReplicacaoTinta = nil): Boolean;

    Function fExisteLote(strCodIte, strCodEmp: String; strNumLot: String = '';
                         blnSalPos: Boolean = True; blnSoAtivo: Boolean = True;
                          blnDifADefinir: Boolean = False): Boolean;

    function fRetornaLoteGuardar(const ANumLot, ACodIte, ACodEmp, ALocFis: String; const ADtaVal: TDateTime): String;

    Class Function fRetornaLoteAtivo(strCodIte, strCodEmp: String) : String;
    Class Function fItemSemNenhumLoteEmpresa(strCodIte: String; strCodEmp : String = ''): Boolean;

    Class Function fTemCrossdocking(strCodIte, strCodEmp, strNumLot: String; Var strLoteEncontrado: String): Boolean;

    Function fItemSemNenhumLote(strCodIte: String): Boolean;

   {$IFNDEF LINUX}
    Function fedtNumLotKeyPress(strCodIte: String;
                                Sender: TObject;
                            var Key: Char;
                                edtNumLot: TEditFocus;
                                frmSelf: TForm;
                                blnSalPos: Boolean = True;
                                blnSemADef: Boolean = False;
                                objFrmPnl : TPanelCx = Nil;
                                arrNumLot: TStringArray = Nil;
                                strEmpLot: String = '';
                                blnApenasAprovados : Boolean = False;
                                blnApenasPrincipalVendaOuCheckout: Boolean = False;
                                bnlMovimentacaoProgramada: Boolean = false;
                                blnApenasChapa: Boolean = False;
                                arrLotesAdd: TStringArray = Nil;
                                strPicking: String = '';
                                blnSemGarantia : Boolean = False;
                                blnChamadaViaFaturamento : Boolean = False;
                                blnMostrarLotePickingCheckout : Boolean = False;
                                strEspDoc: String = '';
                                fltValorUnitario: Double = 0;
                                strTabPre: String = '';
                                strEntRet: String = '';
                                blnApenasPicking: Boolean = False;               {* Mostra somente os Lotes PICKING          *}
                                blnNaoExibeLotTransi : Boolean = False):Boolean;

   {$ENDIF}

    function fRetArmazemPrincipalOrcamentoPedidoVenda(strCodIte: String): String;
    function fRetArmazemPrincipalVenda(strCodIte: String; strCodEmp : String = ''): String;
    Class function fRetArmazemPrincipalOrdemProducao(strCodIte: String; strCodEmp : String = '';blnIndustrial: Boolean = False): String;
    function fRetArmazemPrincipalCompra(strCodIte: String): String;
    function fRetArmazemPrincipalGarantia(strCodIte: String): String;
    function fRetArmazemPrincipalLocacaoDeEquipamento(strCodIte: String): String;
    function fRetLotePrincipalTintaMaquina(strCodIte, strCodEmp: String): String;

    Function fTemLocalizacaoFisicaComLotePicking(strLocFis, strCodEmp, strCodIte: String; blnConsiderarLocFis: Boolean; out strAutIncLoteComPicking: String): Boolean;

    Function fSaldoLote(strCodIte, strCodEmp, strNumLot: String): Double;
    Function fLocalizacaoFisicaLote(strCodIte, strCodEmp, strNumLot: String): String;

    Function fSaldoMLLote(strCodIte, strCodEmp, strNumLot: String): Double;
    function fZeraContagemLote(blnLimpar: Boolean = True; strFilExt : String = ''; event_Parametros: TSetaParametros = nil):Boolean; overload;
    Function fZeraContagemLote(strArmazens: string; strCodIte: String; blnLimpar: Boolean = True; strFilExt: string = ''; event_Parametros: TSetaParametros = nil; AblnAtualizaIteger: Boolean = True):Boolean; overload;   {Req. 456948-B - B8: blnTableTmp removido; B4: AblnAtualizaIteger}
    {Req. 456948-B - B3. Zeramento de lote em passada unica, dirigido por BALZER}
    function fZeraContagemLoteRodada(const AstrConId, AstrCodCon: String): Boolean;

    Function fTemDocumentoLote(strCodIte, strCodEmp, strNumLot: String): Boolean;

    Function fIncluiLote(cdsSalLot: TUniClientDataSet): Boolean;

    Function fGeraLoteEmpresas(qryLote: TUniQuery; blnCriaEmpresasWms : Boolean = False; blnBaixaOPI: Boolean = False; AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual = Nil): Boolean;
    Function fGeraLotesReplicacao(qryLote: TUniQuery; blnBaixaOPI: Boolean = False): Boolean;

    Class Function fGeraADefinirWMS(strCodIte : String):Boolean;

    class function ProdutoTemLote(const ACodite: String; ACodEmp: String = ''): Boolean;
    class function ExisteLoteEstoqueExterno(const ACodIte, ACodExt: String; var ANumLot: String): Boolean; Overload;
    class function ExisteLoteEstoqueExterno(const ACodIte, ACodExt, ACodEmp: String; var ANumLot: String): Boolean; Overload;
    class function GeraLoteEstoqueExterno(const ACodIte, ACodExt: String; var ANumLot: String): Boolean;
    class function GeraLoteTAPedidoCancelado(const ACodIte: String; var ANumLot, ALocFis: String; const ACodEmp: String = ''): Boolean;
    class function GeraLoteAtivo(const ACodIte, ANumLot, ALocFis: String; const ACodEmp: String = ''; AUsarIgnore: Boolean = False; const ADtaVal: TDateTime = 0): Boolean;
    class function ValidaLoteEstoqueExterno(const ACodIte, ACodExt: String; var AMsgErr: String; AValidarSomenteSeLotSalExtCadastradoHoje: Boolean=False): Boolean;
    class function GeraNumeroLoteEstoqueExterno(const ACodExt: String) : String;

    function fEmpresasPossuemSaldoLote(strNumLot, strCodIte: String; Var strEmpresas: String): Boolean;

    Function fTemMovimentoItemSemLote(strCodIte: String; dtaDtaBal: TDate): Boolean;

    Function fSalvaContagemLote(strAutInc,
                                strCodIte,
                                strNumLot,
                                strCodDig,
                                strIncHis: String;
                                fltQtdCon,
                                fltQtdConML: Double;
                                intOrdCon: Integer;
                                strAutIncCONDET: String = '';
                                strCodOpe: String = ''): Boolean;

    Function fRetOrdemItem: Integer;

    Function fSetaMovimentosLote(strCodIte, strNumLot: String): Boolean;

    Function fTemProdutoComLocFisica(    strLocFis: String;
                                     Var strIteEnt: String;
                                     Var fltSaldos,
                                         fltSal_ML: Double;
                                         strCodIte: String = '';
                                         blnSupEst: Boolean = False): Boolean;

    Function fTemLoteComLocFisica(strLocFis: String;
                                  Var strIteEnt,
                                      strLotEnt: String;
                                  Var fltSaldos,
                                      fltSal_ML: Double;
                                  strCodIte: String = '';
                                  strNumLot: String = ''): Boolean; overload;

    Function fTemLoteComLocFisica(strLocFis: String; Var strCodIte: String; blnCadLoc: Boolean = False): Boolean; overload;

    Function fTemLocFisicaComArmazem(strCodAmz: String;
                                     Var strLocFis: String): Boolean;

    Function fTemProdutoComLocAdicional(    strLocFis: String;
                                        Var strIteEnt: String;
                                        Var fltSaldos,
                                            fltSal_ML:Double;
                                             strCodIte: String = ''): Boolean;

    function fAtualizaLocFisica(strCodAmzAnt, strCodAmzAtu, strCodLoc: String): Boolean;
    function fAtualizaLocFisicaLotes(strCodLocAnt, strCodLocAtu,
      strCodEmp: String): Boolean;
    function fTemMovimentacaoLocFisica(strCodAmz, strLocFis: String): Boolean;

    Function fTrocaLocFisica(strCodIte, strNumLot, strLocFis: String): Boolean;

    procedure pZerarLotesSemNecessidadeCalc(AFunctionGetFiltros: TFunctionGetFiltros = nil; AProcSetarParametros: TProcSetarParametros = nil);
    procedure pZeraContagemLote(strCodIte: String);
    procedure pExcluirLoteTodasEmpresas(strCodIte, strNumLot, strNomForm: String);

    Procedure pAjustaArmPrincipalOrcamentoPedidoVenda(qryCadLot: TUniQuery); Overload;
    Procedure pAjustaArmPrincipalVenda(qryCadLot: TUniQuery); Overload;
    Procedure pAjustaArmPrincipalCompra(qryCadLot: TUniQuery); Overload;
    Procedure pAjustaArmPrincipalGarantia(qryCadLot: TUniQuery); Overload;
    Procedure pAjustaArmPrincipalAluguelDeEquipamentos(qryCadLot: TUniQuery);
    Procedure pAjustaArmPrincipalProducao(qryCadLot: TUniQuery); Overload;
    Procedure pAjustaArmPrincipalProducaoIndustrial(qryCadLot: TUniQuery); Overload;
    procedure pAjustaLotePrincipalTintaMaquina(qryCadLot: TUniQuery); Overload;
    procedure pAjustaLotePrincipalConsertoEquipamento(qryCadLot: TUniQuery); Overload;

    Procedure pAjustaArmPrincipalOrcamentoPedidoVenda(strCadAmz, strCodIte: String); Overload;
    Procedure pAjustaArmPrincipalVenda(strCadAmz, strCodIte: String); Overload;
    Procedure pAjustaArmPrincipalCompra(strCadAmz, strCodIte: String); Overload;
    Procedure pAjustaArmPrincipalGarantia(strCadAmz, strCodIte: String); Overload;
    class procedure pAjustaArmPrincipalProducao(strCadAmz, strCodIte: String); Overload;
    class procedure pAjustaArmPrincipalProducaoIndustrial(strCadAmz, strCodIte: String); Overload;
    procedure pAjustaLotePrincipalTintaMaquina(strCadAmz, strCodIte: String); Overload;

    procedure pStepStatusGravacao;
    Procedure pFinalizaStatusGravacao;

    function fAtualizaLoteMovDet(strTabela, strAutInc, strNumLot : String): Boolean;
    function fTrocarLote(strTabela, strAutInc, strLotAtu, strLotNov, strCodIte : String; fltQtdIte: Double; strCodEmp: String = ''): Boolean;
    Class Function fIniciaContagemArmazem(arrCodAmz: TConsultasArray): Boolean;
    Class Function fTemContagemArmazem(Var strCodAmz: String; Var intNumAmz: Integer): Boolean;
    Class Function fFinalizaContagemArmazem: Boolean;
    Class Function fTemItemContado: Boolean;
    Class Function fLocalizacaoFisicaLoteC(strCodIte, strCodEmp, strNumLot : String) : String;
    Class function fRecuperaOuCriaNUMLOTLocalizacaoItem(strCodigoItem, strCodigoLocalizacaoFisica: String; dtaDataValidade: TDate = 0): String;
    class function fGetProximoNUMLOT(strCodigoItem: String): String; static;

    Class Procedure pRetSaldosLoteArmazem(strCodIte, strCodAmz: String; Var fltSaldos, fltSal_Ml: Double);


    function fLocalizacaoTemSeparacaoEmAberto(strLocFis: String): Boolean;
    function fItemTeraLoteDefinidoPeloVendedor(strCodIte : String; strCodEmp: String = ''; blnValidarRastrabilidade: Boolean = False) : Boolean;
    function fValidaLocalizacaoItemUnica(strCodIte, strCodLoc, strAutoincrem: String; dtaColVal: TDateTime = 0): boolean;
    class function fGeraLotePrincipalGarantiaWMS(strCodIte, strCodEmp : String):Boolean;

    function fRetLoteMenorValidade(strCodIte, strCodEmp: String; arrNumLot: TStringArray): String;
    function fLocalizacaoTemConfiguracaoVinculada(strCodLoc: String; Var strCodigo, strDescricao, strEmpresa: String): Boolean;
    procedure pGravaLoteRemessaDevolucao(strNumLote, strCodIte, strNumRem, strLocFis: String);

    Constructor Create(Owner: TComponent; qryCadTab: TUniQuery = Nil); Reintroduce;

    Destructor Destroy; Reintroduce;
    class procedure pGerarLoteGarantia(strCodIte, strCodEmp: String); static;
    class function fBloqueiaTranfSaldoLote(ANumLot, ALocFis, ACodIte, ACodEmp: String; AShwMsg: Boolean = True; ANomLot: String = 'Lote'; ADesconsiderarLocLaborat: Boolean = False): Boolean;
  end;

  ExceptionCadLot = Class(Exception);

  function fNumLotAtivo(strCodIte, strNumLot, strCodEmp : String):Boolean;
  function fVerificaLoteTransitorio(strCodIte, strNumLot, strCodEmp : String): Boolean;
  function fMensagemValidacaoPeloCodigoBarrasDoLote(strCodIte, strNumLot: String; cdsItens: TUniClientDataSet): String;
  function fTemLoteCadastradoNaCadLot(Var strCodIteRet, strNumLotRet: String; strCodigoBipado: String): Boolean;
  function fValidarLotePeloCodigoBarrasDoLote(Var strCodIteRet, strNumLotRet: String; strCodigoBipado: String): Boolean;

Const
  INT_MAXCAM = 21;

  arrCampos:  array[0..INT_MAXCAM] of String =   ('LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT',
                                          'LOT_DTAFAB', 'LOT_DTAVAL', 'LOT_DTABAL', 'LOT_SALBAL',
                                          'LOT_SALDOS', 'AUTOINCREM', 'LOT_PRECUS', 'LOT_PREVEN',
                                          'LOT_LOCFIS', 'LOT_CUSTOT', 'LOT_VENTOT',
                                          'LOT_CAPACI', 'LOT_PONREP', 'LOT_ARMPRI', 'LOT_ARMPRC',
                                          'LOT_LOCSEP', 'LOT_PRITIN', 'LOT_SAL_ML', 'LOT_ARMOPV');

  arrDescricao: array[0..INT_MAXCAM] of String = ('Item', 'Empresa', 'Núm.Lote',
                                          'Data Fabri.', 'Data Validade', 'Data Balanço', 'Saldo Balanço',
                                          'Saldo Atual', 'AUTOINCREM', 'Preço de Custo', 'Preço de Venda',
                                          'Loc. Física', 'Preço de Custo (Total)', 'Preço de Venda (Total)',
                                          'Capacidade', 'Ponto de Reposição', 'Arm.Prin.Vendas', 'Arm.Prin.Compras',
                                          'Local da Separação', 'Principal Tinta Máquina',
                                          'Saldo ML/GR', 'Arm.Prin.Orc/Ped/Ven');

  arrTipo:  array[0..INT_MAXCAM] of TFieldType = (ftString, ftString, ftString,
                                          ftDate, ftDate, ftDate, ftFloat,
                                          ftFloat, ftString, ftFloat, ftFloat,
                                          ftString, ftFloat, ftFloat,
                                          ftString, ftFloat, ftString, ftString, ftString,
                                          ftString, ftFloat, ftString);

  arrTamanhos: array[0..INT_MAXCAM] of Integer = (5, 3, 30,
                                         10, 10, 10, 0,
                                         0, 20, 0, 0, 20, 0, 0,
                                         0, 0, 1, 1, 10, 1, 0, 1);

  arrVisible:  array[0..INT_MAXCAM] of Boolean = (True, False, True,
                                          True, True, True, True,
                                          True, False, True, True, True, True, True,
                                          True, True, True, True, True, True, True, True);

  arrFormat:   array[0..INT_MAXCAM] of String  = ('', '', '',
                                         '99/99/9999;1;_', '99/99/9999;1;_', '99/99/9999;1;_', '#,##0.000',
                                         '#,##0.000', '', '#,##0.00', '#,##0.00', '', '#,##0.00', '#,##0.00',
                                         '#,##0.000', '#,##0.000', '', '', '', '', '#,##0.0000', '');

implementation

uses
  {$IFDEF LINUX}
  {$ELSE}
  untConsultas,
  untFuncoesConsulta,
  {$ENDIF}
  StrUtils, Variants, Math,  untConDet,  Estoque.Lote.TSQLSaldoLote,
  untHistoricoBalanco, untBalancoEstoqueManutencao, untControleContagemBalancoEstoque;


Procedure TCadLot.pSetaTipoLote;
Begin
  FTipLot := tplLote;

  If fCfgSis('CTLEST') = '1' Then
  Begin
    FTipLot := tplLote;
  End Else
  Begin
    FTipLot := tplArmazem;
  End;

  FTitCad := ARR_TITCAD[FTipLot];
  FTitLab := ARR_TITLAB[FTipLot];
  FTitLbS := ARR_TITLBS[FTipLot];
  FTitImp := ARR_TITIMP[FTipLot];
  FDescri := ARR_DESCRI[FTipLot];
End;

constructor TCadLot.Create(Owner: TComponent; qryCadTab: TUniQuery = Nil);
  Var
    IntContador: Integer;
begin
  inherited Create(Owner);

  FReplTinta := Nil;

  pgbStatusGravacao := Nil;

  pSetaTipoLote;

  FConAcu := fCfgSis('CONACU', varBoolean);

  FDecUni := fCfgSis('DECUNI');
  FDecQtd := fCfgSis('DECQTD', varInteger);
  FConEst := fCfgSis('CONEST');
  FColVal := fCfgSis('COLVAL', varBoolean);

  Try
    SetLength(arrDefCam,Succ(INT_MAXCAM));

    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam := arrCampos[intContador];
      arrDefCam[intContador].strDesCri := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam := arrTipo[intContador];

      {* **************************************************}
      { CASO O CAMPO FOR CODITE, ASSUME O VALOR FTAMCODITE }
      { PARA MANTER COMPATIBILIDADE COM A BASE DE DADOS    }
      {************************************************CH**}
      arrDefCam[intContador].intTamCam := IIF( arrCampos[intContador] = 'LOT_CODITE',
                                               fTamCodIte,
                                               arrTamanhos[intContador] );

      arrDefCam[intContador].blnVisible:= arrVisible[intContador];
      arrDefCam[intContador].strFormat := arrFormat[intContador];
    End;

    If Assigned(qryCadTab) Then
    Begin
      qryTabela := qryCadTab;
      qryTabela.AfterOpen := pAfterOpen;
      qryTabela.Close;
      qryTabela.SQL.Clear;
      qryTabela.SQL.Add('SELECT * FROM CADLOT WHERE FALSE');
      qryTabela.Open;
    End;

    FNumLot := '';
    FIdeLot := '';
    FCodIte := '';
    FCodEmp := '';
    FAutInc := '';
    FDtaVal := 0;
    FDtaFab := 0;
    FDtaBal := 0;
    FSalBal := 0;
    FSaldos := 0;;
    FML_Bal := 0;;
    FSal_ML := 0;
    FPreVen := 0;;
    FPreCus := 0;;
    FLocFis := '';
    FPreVee := 0;
    FVenToe := 0;

    FArmOPV := 'N';
    FArmPri := 'N';
    FPriInd := 'N';
    FArmPrC := 'N';
    FCapaci := 0;;
    FPonRep := 0;;
    FGarPri := 'N';
    FPriTin := 'N';
    FArmPce := 'N';

    FIdxEntRetLot := IDX_VAZIO;

    strLotAnt := '';

    qryCadLot := Nil;
    FTemLotePrincipalDeTinta := '';
  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadLot!' + #13 + E.Message);

  End;

end;

Destructor TCadLot.Destroy;
Begin

  inherited;
End;

procedure TCadLot.pAfterOpen(Dataset: TDataSet);
var
  intCont: Integer;
begin
  TDateField(qryTabela.FieldByName('LOT_DTAVAL')).EditMask := '99/99/9999;1;_';
  TDateField(qryTabela.FieldByName('LOT_DTAFAB')).EditMask := '99/99/9999;1;_';
  TDateField(qryTabela.FieldByName('LOT_DTABAL')).EditMask := '99/99/9999;1;_';

  TFloatField(qryTabela.FieldByname('LOT_SALDOS')).DisplayFormat:= fMskDigitos(FDecQtd);;
  TFloatField(qryTabela.FieldByname('LOT_SALBAL')).DisplayFormat:= fMskDigitos(FDecQtd);;
  TFloatField(qryTabela.FieldByname('LOT_SAL_ML')).DisplayFormat:= '#,##0.0000';
  TFloatField(qryTabela.FieldByname('LOT_ML_BAL')).DisplayFormat:= '#,##0.0000';

  TFloatField(qryTabela.FieldByname('LOT_PONREP')).DisplayFormat:= '#,##0.000';
  TFloatField(qryTabela.FieldByname('LOT_CAPACI')).DisplayFormat:= '#,##0.000';

  TFloatField(qryTabela.FieldByname('LOT_PRECUS')).DisplayFormat:= fMskDigitos(FDecUni);
  TFloatField(qryTabela.FieldByname('LOT_PREVEN')).DisplayFormat:= fMskDigitos(FDecUni);

  TFloatField(qryTabela.FieldByname('LOT_CUSTOT')).DisplayFormat:= fMskDigitos(FDecUni);
  TFloatField(qryTabela.FieldByname('LOT_VENTOT')).DisplayFormat:= fMskDigitos(FDecUni);
  TFloatField(qryTabela.FieldByname('LOT_PREVEE')).DisplayFormat:= fMskDigitos(FDecUni);
  TFloatField(qryTabela.FieldByname('LOT_VENTOE')).DisplayFormat:= fMskDigitos(FDecUni);

  for intCont := 1 to 7 do
  begin
    TFloatField(qryTabela.FieldByname('LOT_PREVE' + intCont.ToString)).DisplayFormat:= fMskDigitos(FDecUni);
    TFloatField(qryTabela.FieldByname('LOT_PRVEE' + intCont.ToString)).DisplayFormat:= fMskDigitos(FDecUni);
    TFloatField(qryTabela.FieldByname('LOT_VENTO' + intCont.ToString)).DisplayFormat:= fMskDigitos(FDecUni);
    TFloatField(qryTabela.FieldByname('LOT_VETOE' + intCont.ToString)).DisplayFormat:= fMskDigitos(FDecUni);
  end;
end;

procedure TCadLot.setCodIte(const Value: string);
begin

  If Not fEmptyStr(Value) Then
  Begin
    FDesIte := fRetNomProduto(Value);

    If fEmptyStr(FDesIte) Then
    Begin
      FDesIte := '';
      Raise ExceptionCadLot.Create('Produto não encontrado!');
    End;

    FCodIte := Value;

  End Else
    Raise ExceptionCadLot.Create('Informe o código do item!');

end;

procedure TCadLot.setNumLot(const Value: string);
begin

  If Not fEmptyStr(Value) Then
  Begin

    FIdeLot := Value;

  End Else
    Raise ExceptionCadLot.Create('Informe o número do Lote!');

end;

function TCadLot.getDtaVal: string;
begin
  Result := FormatDateTime('dd/mm/yyyy', FDtaVal);
end;

function TCadLot.getDtaBal: string;
begin
  Result := FormatDateTime('dd/mm/yyyy', FDtaBal);
end;

function TCadLot.getDtaFab: string;
begin
  Result := FormatDateTime('dd/mm/yyyy', FDtaFab);
end;

procedure TCadLot.setDtaVal(const Value: string);
begin

  If Not fEmptyDate(Value) Then
    FDtaVal := StrToDateTime(Value)
  Else
    FDtaVal := 0;

  If (FDtaFab <> 0) And (FDtaVal <> 0) And (FDtaFab > FDtaVal) Then
  Begin
    Raise ExceptionCadLot.Create('A Data de Fabricação não pode ser maior que a Data de Validade!');
  End;

end;

procedure TCadLot.setDtaBal(const Value: string);
begin

  If Not fEmptyDate(Value) Then
    FDtaBal := StrToDateTime(Value)
  Else
    FDtaBal := 0;

end;

procedure TCadLot.setDtaFab(const Value: string);
begin

  If Not fEmptyDate(Value) Then
    FDtaFab := StrToDateTime(Value)
  Else
    FDtaFab := 0;

end;

procedure TCadLot.setPreVee(const Value: Double);
begin
  FPreVee := Value;
end;

procedure TCadLot.setPreVen(const Value: Double);
Begin
  If Value < 0 Then
  Begin
    Raise ExceptionCadLot.Create('O Preço de Venda deve ser maior ou igual a zero!');
  End
  Else FPreVen := Value;

End;

procedure TCadLot.setPreCus(const Value: Double);
Begin
  If Value < 0 Then
  Begin
    Raise ExceptionCadLot.Create('O Preço de Custo deve ser maior ou igual a zero!');
  End
  Else FPreCus := Value;
End;

procedure TCadLot.setVenToe(const Value: Double);
begin
  FVenToe := Value;
end;

procedure TCadLot.setVenTot(const Value: Double);
Begin
  If Value < 0 Then
  Begin
    Raise ExceptionCadLot.Create('O Preço de Venda total do ' + FTitLab + ' deve ser maior ou igual a zero!');
  End
  Else FVenTot := Value;

End;

procedure TCadLot.setCusTot(const Value: Double);
Begin
  If Value < 0 Then
  Begin
    Raise ExceptionCadLot.Create('O Preço de Custo total do ' + FTitLab + ' deve ser maior ou igual a zero!');
  End
  Else FCusTot := Value;
End;

procedure TCadLot.setPonRep(const Value: Double);
Begin
  If Value < 0 Then
  Begin
    Raise ExceptionCadLot.Create('O Ponto de Reposição deve ser maior ou igual a zero!');
  End

  Else If (FCapaci > 0) And (FCapaci < Value) Then
  Begin
    Raise ExceptionCadLot.Create('O Ponto de Reposição deve ser menor ou igual a capacidade máxima!');
  End

  Else FPonRep := Value;
End;

procedure TCadLot.setCapaci(const Value: Double);
Begin
  If Value < 0 Then
  Begin
    Raise ExceptionCadLot.Create('A capacidade máxima deve ser maior ou igual a zero!');
  End
  Else FCapaci := Value;
End;

procedure TCadLot.setOpcDoc(const Value: String);
Begin
  FOpcDoc := Value;
End;

Function TCadLot.fItemSemNenhumLote(strCodIte: String): Boolean;
begin
  Result := fCampoTabela('COUNT(*)', 'CADLOT', ['LOT_CODITE'], [strCodIte], False) = 0;
end;

Class Function TCadLot.fItemSemNenhumLoteEmpresa(strCodIte: String; strCodEmp : String = ''): Boolean;
begin
  Result := fCampoTabela('COUNT(*)', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP'], [strCodIte, IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp)], False) = 0;
end;

function TCadLot.fItemTeraLoteDefinidoPeloVendedor(strCodIte: String; strCodEmp: String = ''; blnValidarRastrabilidade: Boolean = False): Boolean;
begin

  Result := False;

  If Not fEmptyStr(strCodIte) Then
  Begin

    if not blnValidarRastrabilidade then
    begin
      {Obrigar a definição do lote(WMS) do produto na tela de pedido de venda?}
      If (fCampoTabela('ITE_LOTEPD', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S') Then
        Result := True;
    end
    else
    begin
      If (Length(strCodEmp) = 3) Then
      Begin
        If fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis(strCodEmp) Then
          Result := fCampoTabela('ITE_RASTRE', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S';
      End;
    end;

  End;

end;

Class Function TCadLot.fLocalizacaoFisicaLoteC(strCodIte, strCodEmp, strNumLot : String) : String;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT LOT_LOCFIS FROM CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_NUMLOT = :NUMLOT     ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('NUMLOT').AsString := strNumLot;

    Open;

    Result := FieldByName('LOT_LOCFIS').AsString;

    Close;
  End;

  FreeAndNil(qryGen);

End;

function TCadLot.fLocalizacaoFisicaLote(strCodIte, strCodEmp, strNumLot: String): String;
Begin
  Result := TCadLot.fLocalizacaoFisicaLoteC(strCodIte, strCodEmp, strNumLot);
end;

function TCadLot.fLoteAtivo(strNumLote, strCodEmp, strCodItem: String): Boolean;
begin
  Result := fCampoTabela('LOT_STATUS', 'CADLOT', ['LOT_NUMLOT', 'LOT_CODEMP', 'LOT_CODITE'], [strNumLote, strCodEmp, strCodItem]) = 'S';
end;

function TCadLot.fRetornaLocalizacaoFisicaWMS(
  const AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual;
  const AstrCodEmp: String): String;
begin
  Result := '' ;
  if not Assigned(AdictLocalizacaoFisicaEmpresa) then
    Exit ;

  if not fCfgSis('UTIWMS', VarBoolean) then
    Exit ;

  Result := AdictLocalizacaoFisicaEmpresa.Items[AstrCodEmp] ;
end;

function TCadLot.fQtdDeLotes(strCodIte: String; strCodEmp: String = '';  strNumLot: String = '';blnSoAtivos: Boolean = True;  blnEntraDefinir: Boolean = False;  blnEntraGarantia: Boolean = False): Integer;
  Var
    qryCadLot: TUniQuery;
begin

  qryCadLot := fCriaQuery(Self);

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;
  Try
    qryCadLot.Close;
    qryCadLot.SQL.Clear;

    qryCadLot.SQL.Add(' SELECT COUNT(1) AS QTD FROM CADLOT ');
    qryCadLot.SQL.Add(' WHERE ');
    qryCadLot.SQL.Add('  LOT_CODITE = :CODITE AND ');
    qryCadLot.SQL.Add('  LOT_CODEMP = :CODEMP     ');

    If not fEmptyStr(strNumLot) Then
      qryCadLot.SQL.Add('  AND LOT_NUMLOT = :NUMLOT ');

    If blnSoAtivos then
      qryCadLot.SQL.Add(' AND LOT_STATUS = "S" ');

    If Not blnEntraDefinir Then
      qryCadLot.SQL.Add(' AND ( LOCATE( "A DEFINIR", LOT_NUMLOT) <= 0 )');

    If Not blnEntraGarantia Then
      qryCadLot.SQL.Add(' AND ( LOCATE( "GARANTIA", LOT_NUMLOT) <= 0 ) ');

    qryCadLot.ParamByName('CODITE').AsString := strCodIte;
    qryCadLot.ParamByName('CODEMP').AsString := strCodEmp;

    if Not fEmptyStr(strNumLot) then
      qryCadLot.ParamByName('NUMLOT').AsString := strNumLot;

    qryCadLot.Open;

    If qryCadLot.IsEmpty Then
      Result := 0
    Else
      Result := qryCadLot.FieldByName('QTD').AsInteger;
  Finally
    FreeAndNil(qryCadLot);
  End;

end;

Class Function TCadLot.fRetornaLoteAtivo(strCodIte, strCodEmp: String) : String;
  Var
    qryCadLot : TUniQuery;
Begin
  qryCadLot := fCriaQuery(nil);

  With qryCadLot, SQL Do
  Begin
    Close;
    Clear;

    Add(' SELECT * FROM CADLOT                         ');
    Add('  WHERE LOT_CODITE = :CODITE                  ');
    Add('    AND LOT_CODEMP = :CODEMP                  ');
    Add('    AND LOCATE(LOT_NUMLOT, "A DEFINIR") <= 0  ');
    Add('    AND LOT_STATUS = "S"                      ');
    Add('  ORDER BY LOT_SALDOS DESC, LOT_ARMPRI DESC   ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    First;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString
    Else
      Result := '';

    FreeAndNil(qryCadLot);
  End;

End;

function TCadLot.fRetornaLoteGuardar(const ANumLot, ACodIte, ACodEmp, ALocFis: String; const ADtaVal: TDateTime): String;
var
  LQry: TUniQuery;
  LLote: String;

  procedure pAtualizaDataValidade;
  var
    LAux: TUniQuery;
  begin
    if (ADtaVal = 0) then
      Exit;

    LAux := fCriaQuery;

    try
      LAux.Close;
      LAux.SQL.Clear;
      LAux.SQL.Text := 'UPDATE CADLOT SET LOT_DTAVAL = :DTAVAL WHERE AUTOINCREM = :AUTINC ';
      LAux.ParamByName('AUTINC').AsString   := LQry.FieldByName('AUTOINCREM').AsString;
      LAux.ParamByName('DTAVAL').AsDateTime := ADtaVal;
      LAux.ExecSQL;
    finally
      FreeAndNil(LAux);
    end;
  end;
begin
  LQry := fCriaQuery;

  try
    if (ADtaVal > 0) then
    begin
      LQry.SQL.Add('SELECT LOT_NUMLOT ');
      LQry.SQL.Add('FROM CADLOT ');
      LQry.SQL.Add('WHERE LOT_CODITE = :CODITE ');
      LQry.SQL.Add('  AND LOT_CODEMP = :CODEMP ');
      LQry.SQL.Add('  AND LOCATE(:NUMLOT, LOT_NUMLOT) ');
      LQry.SQL.Add('  AND LOT_DTAVAL = :DTAVAL ');
      LQry.SQL.Add('LIMIT 1 ');

      LQry.ParamByName('CODITE').AsString := ACodIte;
      LQry.ParamByName('CODEMP').AsString := ACodEmp;
      LQry.ParamByName('NUMLOT').AsString := ANumLot;
      LQry.ParamByName('DTAVAL').AsDate   := ADtaVal;
      LQry.Open;

      if (not LQry.IsEmpty) then
      begin
        Result := LQry.FieldByName('LOT_NUMLOT').AsString;
        Exit;
      end;
    end;

    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add('SELECT AUTOINCREM, LOT_NUMLOT ');
    LQry.SQL.Add('FROM CADLOT ');
    LQry.SQL.Add('WHERE LOT_CODITE = :CODITE ');
    LQry.SQL.Add('  AND LOT_CODEMP = :CODEMP ');
    LQry.SQL.Add('  AND LOCATE(:NUMLOT, LOT_NUMLOT) ');
    LQry.SQL.Add('  AND LOT_SALDOS = 0 ');
    LQry.SQL.Add('LIMIT 1 ');

    LQry.ParamByName('CODITE').AsString := ACodIte;
    LQry.ParamByName('CODEMP').AsString := ACodEmp;
    LQry.ParamByName('NUMLOT').AsString := ANumLot;
    LQry.Open;

    if (not LQry.IsEmpty) then
    begin
      pAtualizaDataValidade;

      Result := LQry.FieldByName('LOT_NUMLOT').AsString;
      Exit;
    end;

    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add('SELECT COUNT(1) QTD ');
    LQry.SQL.Add('FROM CADLOT ');
    LQry.SQL.Add('WHERE LOT_CODITE = :CODITE ');
    LQry.SQL.Add('  AND LOT_CODEMP = :CODEMP ');
    LQry.SQL.Add('  AND LOCATE(:NUMLOT, LOT_NUMLOT) ');

    LQry.ParamByName('CODITE').AsString := ACodIte;
    LQry.ParamByName('CODEMP').AsString := ACodEmp;
    LQry.ParamByName('NUMLOT').AsString := ANumLot;
    LQry.Open;

    if (LQry.FieldByName('QTD').AsInteger > 0) then
      LLote := ANumLot + '/' + IntToStr(LQry.FieldByName('QTD').AsInteger + 1)
    else
      LLote := ANumLot;

    Result := LLote;
    GeraLoteAtivo(ACodIte, LLote, ALocFis, '', True, ADtaVal);
  finally
    FreeAndNil(LQry);
  end;
end;

function TCadLot.fRetornaPrecoLoteDestinoEntrega: Boolean;
begin
  Result := False;

  If (Not fCfgSis('MARENT', varBoolean)) Then
    Exit;

  If (Self.intIdxEntRetLot = IDX_ENTREGA) Then
    Result := True;
end;

Function TCadLot.fRetPrimeiroLote(strCodIte, strCodEmp: String): String;
  Var
    qryLote: TUniQuery;
Begin
  Result := '';

  qryLote := fCriaQuery;

  With qryLote, SQL Do
  Begin
    Close;
    Clear;

    Add(' SELECT LOT_NUMLOT FROM CADLOT ');
    Add(' WHERE ');
    Add('      LOT_CODITE = :CODITE ');
    Add('  AND LOT_CODEMP = :CODEMP ');
    Add('  AND LOT_STATUS = "S" ');
    Add('  AND LOCATE(LOT_NUMLOT, "A DEFINIR") <= 0 ');
    Add('ORDER BY AUTOINCREM');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    First;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString;

  End;

  FreeAndNil(qryLote);
End;


Function TCadLot.fExisteLote(strCodIte, strCodEmp: String; strNumLot: String = '';
                             blnSalPos: Boolean = True; blnSoAtivo: Boolean = True;
                             blnDifADefinir: Boolean = False): Boolean;
Begin
  If Not Assigned(qryCadLot) Then
    qryCadLot := fCriaQuery(Self);

  qryCadLot.Close;
  qryCadLot.SQL.Clear;

  qryCadLot.SQL.Add(' SELECT * FROM CADLOT ');
  qryCadLot.SQL.Add(' WHERE ');
  qryCadLot.SQL.Add('  LOT_CODITE = :CODITE AND ');
  qryCadLot.SQL.Add('  LOT_CODEMP = :CODEMP     ');

  If fEmptyStr(strNumLot) Then
  Begin
    If blnSalPos Then
    Begin
      qryCadLot.SQL.Add(' AND ( ( IFNULL(LOT_SALDOS, 0) > 0 AND          ');
      qryCadLot.SQL.Add('         LOCATE("A DEFINIR", LOT_NUMLOT ) <= 0 ) ');
      qryCadLot.SQL.Add('      OR LOCATE("A DEFINIR", LOT_NUMLOT) > 0  ) ');
    End;
  End Else
    qryCadLot.SQL.Add('  AND LOT_NUMLOT = :NUMLOT ');

  if (blnSoAtivo) and (Copy(strNumLot, 1, 4) <> 'REM_') then
    qryCadLot.SQL.Add(' AND LOT_STATUS = "S" ');

  If blnDifADefinir Then
    qryCadLot.SQL.Add(' AND LOCATE( "A DEFINIR", LOT_NUMLOT) <= 0 ');

  qryCadLot.SQL.Add('ORDER BY LOT_DTAVAL');

  qryCadLot.ParamByName('CODITE').AsString := strCodIte;
  qryCadLot.ParamByName('CODEMP').AsString := strCodEmp;
  if not fEmptyStr(strNumLot) then
    qryCadLot.ParamByName('NUMLOT').AsString := strNumLot;

  qryCadLot.Open;
  qryCadLot.First;

  Result := Not qryCadLot.IsEmpty;
End;

function TCadLot.fExisteLoteGarantia(strCodIte, strCodEmp: String): Boolean;
var
 qryCadLot : TUniQuery;
begin


  Try

    qryCadLot := fCriaQuery;

    qryCadLot.Close;
    qryCadLot.SQL.Clear;

    qryCadLot.SQL.Add('SELECT *                  ');
    qryCadLot.SQL.Add(' FROM                     ');
    qryCadLot.SQL.Add('     CADLOT               ');
    qryCadLot.SQL.Add(' WHERE                    ');
    qryCadLot.SQL.Add('     LOT_CODITE = :CODITE ');
    qryCadLot.SQL.Add(' AND LOT_CODEMP = :CODEMP ');
    qryCadLot.SQL.Add(' AND LOT_NUMLOT = :NUMLOT ');

    qryCadLot.ParamByName('CODITE').AsString := strCodIte;
    qryCadLot.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadLot.ParamByName('NUMLOT').AsString := 'GARANTIA';

    qryCadLot.Open;

    Result := not qryCadLot.IsEmpty; {existe lote garantia}

    {caso tenha o lote garantia, mas não está marcado como princial de garantia, ajusta}
    If Result and (qryCadLot.FieldByName('LOT_GARPRI').AsString = 'N') Then
    Begin
      qryCadLot.Close;
      qryCadLot.SQL.Clear;

      qryCadLot.SQL.Add('UPDATE CADLOT              ');
      qryCadLot.SQL.Add('  SET LOT_GARPRI = "S"     ');
      qryCadLot.SQL.Add('WHERE                      ');
      qryCadLot.SQL.Add('  LOT_CODITE = :CODITE AND ');
      qryCadLot.SQL.Add('  LOT_NUMLOT = :NUMLOT AND ');
      qryCadLot.SQL.Add('  LOT_CODEMP = :CODEMP     ');

      qryCadLot.ParamByName('CODITE').AsString := strCodIte;
      qryCadLot.ParamByName('NUMLOT').AsString := 'GARANTIA';
      qryCadLot.ParamByName('CODEMP').AsString := strCodEmp;

      qryCadLot.ExecSQL;
    End;

  Finally
    FreeAndNil(qryCadLot);
  End;

end;

Function TCadLot.fSaldoLote(strCodIte, strCodEmp, strNumLot: String): Double;
  Var
    qryGen: TUniQuery;
Begin

  Result := 0;

  If fEmptyStr(strCodIte) And fEmptyStr(strNumLot) Then
    Exit;

  qryGen := fCriaQuery;

  Try

    With qryGen, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT IFNULL(LOT_SALDOS, 0) AS LOT_SALDOS FROM CADLOT');
      Add('WHERE');
      Add('  LOT_CODITE = :CODITE AND ');
      Add('  LOT_CODEMP = :CODEMP AND ');
      Add('  LOT_NUMLOT = :NUMLOT     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMLOT').AsString := strNumLot;

      Open;

      If Not IsEmpty Then
        Result := FieldByName('LOT_SALDOS').AsFloat;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

Function TCadLot.fSaldoMLLote(strCodIte, strCodEmp, strNumLot: String): Double;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT IFNULL(LOT_SAL_ML, 0) AS LOT_SAL_ML FROM CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_NUMLOT = :NUMLOT     ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('NUMLOT').AsString := strNumLot;

    Open;

    If IsEmpty Then
      Result := 0
    Else
      Result := FieldByName('LOT_SAL_ML').AsFloat;

    Close;
  End;

  FreeAndNil(qryGen);
End;

Function TCadLot.fTemDocumentoLote(strCodIte, strCodEmp, strNumLot: String): Boolean;
  Var
    qryGen: TUniQuery;
    arrMensagem : TStringArray;

  procedure pAddLinha(strLinha : String);
  begin
    setLength(arrMensagem, length(arrMensagem)+1);
    arrMensagem[High(arrMensagem)] := strLinha;
  end;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT DET_NUMDOC AS NUMDOC, DET_ESPDOC AS ESPDOC, DET_CODEMP AS CODEMP, "" AS TIPO FROM MOVDET');
    Add('WHERE');
    Add('  DET_CODITE = :CODITE AND ');
    Add('  DET_NUMLOT = :NUMLOT     ');

    If Not fEmptyStr(strCodEmp) Then
      Add('  AND DET_CODEMP = :CODEMP ');

    Add(' UNION ALL  ');

    Add('SELECT FDO_NUMDOC AS NUMDOC, FDO_ESPDOC AS ESPDOC, FDO_CODEMP AS CODEMP, "" AS TIPO FROM FATDOR');
    Add('WHERE');
    Add('  FDO_CODITE = :CODITE AND ');
    Add('  FDO_NUMLOT = :NUMLOT     ');

    If Not fEmptyStr(strCodEmp) Then
      Add('  AND FDO_CODEMP = :CODEMP ');

    Add(' UNION ALL  ');

    Add('SELECT FDO_NUMDOC AS NUMDOC, FDO_ESPDOC AS ESPDOC, FDO_CODEMP AS CODEMP, "(Separação)" AS TIPO FROM FATDOR');
    Add('WHERE');
    Add('      FDO_CODITE = :CODITE ');
    Add('  AND (SELECT COUNT(*) FROM LOTDOR WHERE LDO_SEQFDO = FATDOR.AUTOINCREM AND FDO_CODITE AND LDO_NUMLOT = :NUMLOT) > 0 ');

    If Not fEmptyStr(strCodEmp) Then
      Add('  AND FDO_CODEMP = :CODEMP ');


    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;

    If Not fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    First;

    Result := Not IsEmpty;

    If Result Then
    Begin

      setLength(arrMensagem,0);
      pAddLinha('Documento(s) vinculados');
      pAddLinha(''                                              );

      first;
      while not eof do
      begin
        pAddLinha(fPadR(  fieldByName('NUMDOC').AsString +'-'
                        + fieldByName('ESPDOC').AsString +'-'
                        + fieldByName('CODEMP').AsString,19)+ ' '
                        + fieldByName('TIPO').AsString);

        Next;
      end;


      {$IFDEF LINUX}
      fMensagem('', 'Não é possível excluir o lote!', ['&Ok']);
      {$ELSE}
      fMensagemTabela('Lote: ' + strNumLot, '', arrMensagem, 'Não é possível excluir o lote!', ['&Ok'], 1,false,1,0,false,0,false,false,false,500);
      {$ENDIF}
    end;

  End;

  FreeAndNil(qryGen);
End;

{$IFNDEF LINUX}
Function TCadLot.fedtNumLotKeyPress(    strCodIte: String;
                                        Sender: TObject;
                                    var Key: Char;
                                        edtNumLot: TEditFocus;
                                        frmSelf: TForm;
                                        blnSalPos: Boolean = True;
                                        blnSemADef: Boolean = False;
                                        objFrmPnl: TPanelCx = Nil;
                                        arrNumLot: TStringArray = Nil;
                                        strEmpLot: String = '';
                                        blnApenasAprovados : Boolean = False;
                                        blnApenasPrincipalVendaOuCheckout: Boolean = False;
                                        bnlMovimentacaoProgramada: Boolean = false;
                                        blnApenasChapa: Boolean = False;
                                        arrLotesAdd: TStringArray = Nil;
                                        strPicking: String = '';
                                        blnSemGarantia : Boolean = False;
                                        blnChamadaViaFaturamento : Boolean = False;
                                        blnMostrarLotePickingCheckout : Boolean = False;
                                        strEspDoc: String = '';
                                        fltValorUnitario: Double = 0;
                                        strTabPre: String = '';
                                        strEntRet: String = '';
                                        blnApenasPicking: Boolean = False;               {* Mostra somente os Lotes PICKING          *}
                                        blnNaoExibeLotTransi : Boolean = False):Boolean;
 
  Var
    qryCadLot: TUniQuery;
    arrLotes: TConsultasArray;

  function fEntraNaConsultaDeLote: Boolean;
  begin
    Result := fEntraCons(Key);

    If Result And fCfgSis('MARMOR', varBoolean) Then
      Result := fEmptyStr(edtNumLot.Text);
  end;

begin

  {*****************************}
  {* NOVA CONSULTA DE LOTES    *}
  {**************************AC*}
  Result := False;

  If fEntraNaConsultaDeLote Then
  Begin

    utcRegistros.fRetRegistro(frmSelf.Name + 'CADLOT');
    utcRegistros.pLimparCampos;

    Try
      qryCadLot := fCriaQuery;
      If fPesqLoteFat(frmSelf, edtNumLot, FDecUni, strCodIte, blnSalPos, blnSemADef,
                      qryCadLot, Key, arrLotes, strEmpLot, objFrmPnl, True, arrNumLot, True, True,
                      blnApenasPrincipalVendaOuCheckout, bnlMovimentacaoProgramada, blnApenasChapa, arrLotesAdd, strPicking, blnSemGarantia,
                      blnChamadaViaFaturamento, blnMostrarLotePickingCheckout, strEspDoc, fltValorUnitario, 0, False, '', strTabPre, strEntRet, blnApenasPicking,blnNaoExibeLotTransi ) Then
      Begin
        edtNumLot.Text := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
        Result := True;
      End;
    Finally
      FreeAndNil(qryCadLot);
    End;
  End;

End;
{$ENDIF}

function TCadLot.fAtualizaEstoqueLote(strCodIte,
                                      strEntSai,
                                      strNumLot: String;
                                      fltQtdIte: Double;
                                      strCodEmp: String = '';
                                      AUsarBatchSaldos: Boolean = False): Boolean;
var
  strSQL: String;
  LstrCodEmp: String;
  qryGenIte: TUniQuery;

  function fMontaSQLAtualizaCadLot(const ASQLForExc: Boolean=False): String;
  begin
    Result :=          'UPDATE CADLOT';
    Result := Result + '   SET LOT_SALDOS = IFNULL(LOT_SALDOS, 0)' + IIF(strEntSai='E',' + ',' - ') + ':QTDITE';

    If strEntSai = 'E' Then
      Result := Result + ' ,LOT_STATUS = IF((LOT_FULFIL <> "S") AND (IFNULL(LOT_AUTREM, "") = ""), "S", "B") ';

    Result := Result + ' WHERE LOT_CODITE = :CODITE'+
                       '   AND LOT_NUMLOT = :NUMLOT'+
                       '   AND LOT_CODEMP = :CODEMP';

    If ASQLForExc Then
    Begin
      Result := StringReplace(Result, ':QTDITE', fDoubleToSQL(fltQtdIte),[rfReplaceAll]);
      Result := StringReplace(Result, ':CODITE', QuotedStr(strCodIte)   ,[rfReplaceAll]);
      Result := StringReplace(Result, ':NUMLOT', QuotedStr(strNumLot)   ,[rfReplaceAll]);
      Result := StringReplace(Result, ':CODEMP', QuotedStr(LstrCodEmp)  ,[rfReplaceAll]);
    End;
  end;

begin
  Result := True;
  qryGenIte := Nil;
  Try
    If fEmptyStr(strCodIte) Or
       fEmptyStr(strEntSai) Or
       fEmptyStr(strNumLot) Or
       (fltQtdIte = 0.0) Then
    Begin
      Exit;
    End;

    LstrCodEmp := IfEmptyStr(strCodEmp, VS_strCodEmp);
    Try
      If (Assigned(FReplTinta)) Then
      Begin
        strSQL := fMontaSQLAtualizaCadLot;

        FReplTinta.pExecutaSQL(strSQL, ['QTDITE', 'CODITE', 'NUMLOT', 'CODEMP'], [fltQtdIte, strCodIte, strNumLot, LstrCodEmp]);
      End
      Else
      Begin
        strSQL := fMontaSQLAtualizaCadLot(True);

        {Com o lote de saldos armado o UPDATE e acumulado (Nil fora do
         balanco). fUsouBatchSaldosSQL roda antes de AUsarBatchSaldos, entao
         blnTravarSeSaldoFicarNegativo le o saldo anterior ao ajuste durante o
         balanco - decisao: manter, a garantia e do B9. Ver specs.md secao 7.}
        If Not (fUsouBatchSaldosBalancoSQL(strSQL) Or
                (AUsarBatchSaldos And fUsouBatchReprocessarSaldo([strSQL], True))) Then
        Begin
          strSQL := fMontaSQLAtualizaCadLot;

          If (Not Assigned(qryGenIte)) Then
            qryGenIte := fCriaQuery(Nil);
          qryGenIte.Close;
          qryGenIte.SQL.Text := strSQL;

          qryGenIte.ParamByName('QTDITE').AsFloat    := fltQtdIte;
          qryGenIte.ParamByName('CODITE').AsString   := strCodIte;
          qryGenIte.ParamByName('NUMLOT').AsString   := strNumLot;
          qryGenIte.ParamByName('CODEMP').AsString   := LstrCodEmp;

          qryGenIte.ExecSQL;
          qryGenIte.Close;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadLot.fAtualizaEstoqueLote]');
      End;
    End;

  Finally
    If Assigned(qryGenIte) Then
      FreeAndNil(qryGenIte);
  End;
End;

function TCadLot.fAtualizaEstoqueMLLote(strCodIte,
                                        strEntSai,
                                        strNumLot    : String;
                                        fltQtdML     : Double;
                                        objReplTinta : IExecutaSQLReplicacaoTinta = nil): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
begin
  Try
    Result := True;

    If fEmptyStr(strCodIte) Or fEmptyStr(strEntSai)Or fEmptyStr(strNumLot) Or
       (fltQtdML = 0.0) Then
    Begin
      Exit;
    End;

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADLOT ';
    strSQL := strSQL + 'SET ';

    If strEntSai = 'E' Then
      strSQL := strSQL + '  LOT_SAL_ML = IFNULL(LOT_SAL_ML, 0) + :QTD_ML '
    Else
    Begin
      strSQL := strSQL + '  LOT_SAL_ML = IFNULL(LOT_SAL_ML, 0) - :QTD_ML ';
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  LOT_CODITE = :CODITE AND ';
    strSQL := strSQL + '  LOT_NUMLOT = :NUMLOT AND ';
    strSQL := strSQL + '  LOT_CODEMP = :CODEMP     ';

    Try

      With qryGenIte Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('QTD_ML').AsFloat := fltQtdML;

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('NUMLOT').AsString := strNumLot;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        if (Assigned(objReplTinta)) then
          objReplTinta.pExecutaSQL(strSQL, ['QTD_ML', 'CODITE', 'NUMLOT', 'CODEMP'], [fltQtdML, strCodIte, strNumLot, VS_strCodEmp])
        else
          ExecSQL;

        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadLot.fAtualizaEstoqueMLLote]');
      End;
    End;

  Finally
    If Assigned(qryGenIte) Then
      FreeAndNil(qryGenIte);
  End;

End;

Function TCadLot.fSqlLotIte(strCodIte: String): String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   *    ';
  Result := Result + ' FROM   ';
  Result := Result + '   CADLOT ';
  Result := Result + ' WHERE ';
  Result := Result + '   LOT_CODITE = ' + QuotedStr(strCodIte);
  Result := Result + '   AND LOT_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '   AND LOT_STATUS = "S" ';
End;

Function TCadLot.fIncluiLote(cdsSalLot: TUniClientDataSet): Boolean;
  var
    cdsSalSav: TUniClientDataSet;
Begin
  Try

    Result := True;
    If Not Assigned(cdsSalLot) Then
      Exit;

    With cdsSalLot Do
    Begin
      If (Not Active) Or IsEmpty Or
         (Not SameText(qryTabela.FieldByName('LOT_CODITE').AsString, FieldByName('LOT_CODITE').AsString)) Then
       Exit;

      cdsSalSav      := TUniClientDataSet.Create(Self);
      cdsSalSav.Data := cdsSalLot.Data;

      cdsSalLot.Close;
      cdsSalLot.Open;

      cdsSalSav.First;
      While Not cdsSalSav.Eof Do
      Begin
        If cdsSalLot.Locate('LOT_NUMLOT', cdsSalSav.FieldByName('LOT_NUMLOT').AsString, []) Then
        Begin
          cdsSalLot.Edit;
          cdsSalLot.FieldbyName('LOT_SALBAL').AsFloat := cdsSalSav.FieldbyName('LOT_SALBAL').AsFloat;
          cdsSalLot.FieldbyName('LOT_ML_BAL').AsFloat := cdsSalSav.FieldbyName('LOT_ML_BAL').AsFloat;
          cdsSalLot.Post;
        End;

        cdsSalSav.Next;
      End;


      FreeAndNil(cdsSalSav);
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadLot.fIncluiLote]');
    End;
  End;

End;


Class Function TCadLot.fGeraADefinirWMS(strCodIte : String):Boolean;
  Var
    qryGenerica: TUniQuery;
    qryIteGer  : TUniQuery;
Begin
{ Tem q entrar independente da empresa q ta logada ser ou nao wms.
  pois a matriz pode nao ter wms mas é ela que cadastra os produtos.


  If Not fUsaRotinaWMS Then
  Begin
    Result := True;
    Exit;
  End;}

  qryGenerica := fCriaQuery(Nil);
  qryIteGer   := fCriaQuery(Nil);
  Try
    With qryIteGer, SQL Do
    Begin
      Add(' SELECT ITE_CODEMP,                            ');
      Add(' ITE_SALDOS                                    ');
      Add(' FROM ITEGER                                   ');
      Add(' INNER JOIN CADEMP ON EMP_CODEMP = ITE_CODEMP  ');
      Add(' WHERE ITE_CODITE = ' + QuotedStr(strCodIte)    );
      Add('   AND EMP_UTIWMS = "S"                        ');
      Open;
    End;

    With qryGenerica, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM CADLOT WHERE FALSE');
      Open;
    End;

    While Not qryIteGer.Eof Do
    Begin
      qryGenerica.Insert;
      qryGenerica.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', qryIteGer.FieldByName('ITE_CODEMP').AsString);
      qryGenerica.FieldByName('LOT_NUMLOT').AsString   := 'A DEFINIR';
      qryGenerica.FieldByName('LOT_CODEMP').AsString   := qryIteGer.FieldByName('ITE_CODEMP').AsString;
      qryGenerica.FieldByName('LOT_CODITE').AsString   := strCodIte;
      qryGenerica.FieldByName('LOT_DTAFAB').Value      := VS_Date;
      qryGenerica.FieldByName('LOT_DTAVAL').Value      := IncYear(VS_Date);
      qryGenerica.FieldByName('LOT_DTABAL').Value      := VS_Date -1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
      qryGenerica.FieldByName('LOT_SALBAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SALDOS').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_ML_BAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SAL_ML').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SALCON').Value      := Null;
      qryGenerica.FieldByName('LOT_DIGCON').AsString   := 'N';
      qryGenerica.FieldByName('LOT_ORDCON').Value      := Null;
      qryGenerica.FieldByName('LOT_DIFSAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_LOCFIS').AsString   := '';
      qryGenerica.Post;

      qryGenerica.Insert;
      qryGenerica.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', qryIteGer.FieldByName('ITE_CODEMP').AsString);
      qryGenerica.FieldByName('LOT_NUMLOT').AsString   := 'GARANTIA';
      qryGenerica.FieldByName('LOT_CODEMP').AsString   := qryIteGer.FieldByName('ITE_CODEMP').AsString;
      qryGenerica.FieldByName('LOT_CODITE').AsString   := strCodIte;
      qryGenerica.FieldByName('LOT_DTAFAB').Value      := VS_Date;
      qryGenerica.FieldByName('LOT_DTAVAL').Clear;
      qryGenerica.FieldByName('LOT_DTABAL').Value      := VS_Date -1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
      qryGenerica.FieldByName('LOT_SALBAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SALDOS').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_ML_BAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SAL_ML').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SALCON').Value      := Null;
      qryGenerica.FieldByName('LOT_DIGCON').AsString   := 'N';
      qryGenerica.FieldByName('LOT_ORDCON').Value      := Null;
      qryGenerica.FieldByName('LOT_DIFSAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_LOCFIS').AsString   := '';
      qryGenerica.FieldByName('LOT_GARPRI').AsString   := 'S';
      qryGenerica.Post;

      qryIteGer.Next;
    End;
    Result := True;

  Finally
    qryGenerica.Close;
    qryIteGer.Close;
    FreeAndNil(qryGenerica);
    FreeAndNil(qryIteGer);
  End;

End;

Class Function TCadLot.fGetProximoNUMLOT(strCodigoItem : String) : String;
var
  qryCADLOT : TUniQuery;
begin
  Result := 'W ';
  Result := Result + FormatDateTime('yy-MM-dd', VS_Date);
  Result := Result + '/';

  qryCADLOT := fCriaQuery(nil);
  try
    qryCADLOT.SQL.Add('SELECT                              ');
    qryCADLOT.SQL.Add('  COUNT(*) AS QUANTIDADE            ');
    qryCADLOT.SQL.Add('FROM                                ');
    qryCADLOT.SQL.Add('  CADLOT                            ');
    qryCADLOT.SQL.Add('WHERE LOT_CODEMP = :CODIGO_EMPRESA  ');
    qryCADLOT.SQL.Add('  AND LOT_CODITE = :CODIGO_ITEM     ');
    qryCADLOT.SQL.Add('  AND LOT_NUMLOT LIKE :PREFIXO      ');

    qryCADLOT.ParamByName('CODIGO_EMPRESA').AsString := VS_strCodEmp;
    qryCADLOT.ParamByName('CODIGO_ITEM').AsString    := strCodigoItem;
    qryCADLOT.ParamByName('PREFIXO').AsString        := Result + '%';

    qryCADLOT.Open;

    Result := Result +  IntToStr(qryCADLOT.FieldByName('QUANTIDADE').AsInteger + 1);

  finally
    FreeAndNil(qryCADLOT);
  end;
end;


Class function TCadLot.fRecuperaOuCriaNUMLOTLocalizacaoItem(strCodigoItem, strCodigoLocalizacaoFisica : String; dtaDataValidade : TDate = 0) : String;
var
  qryCADLOT : TUniQuery;
begin
  qryCADLOT := fCriaQuery(nil);
  try
    qryCADLOT.SQL.Add('SELECT                                        ');
    qryCADLOT.SQL.Add('  *                                           ');
    qryCADLOT.SQL.Add('FROM                                          ');
    qryCADLOT.SQL.Add('  CADLOT                                      ');
    qryCADLOT.SQL.Add('WHERE LOT_CODITE = :CODIGO_ITEM               ');
    qryCADLOT.SQL.Add('  AND LOT_CODEMP = :CODIGO_EMPRESA            ');
    qryCADLOT.SQL.Add('  AND LOT_LOCFIS = :CODIGO_LOCALIZACAO_FISICA ');

    if fCfgSis('COLVAL', varBoolean) then
      qryCADLOT.SQL.Add('  AND LOT_DTAVAL = :DATA_VALIDADE           ');

    qryCADLOT.SQL.Add('ORDER BY CADLOT.AUTOINCREM                    ');
    qryCADLOT.SQL.Add('LIMIT 1                                       ');

    qryCADLOT.ParamByName('CODIGO_ITEM').AsString               := strCodigoItem;
    qryCADLOT.ParamByName('CODIGO_EMPRESA').AsString            := VS_strCodEmp;
    qryCADLOT.ParamByName('CODIGO_LOCALIZACAO_FISICA').AsString := strCodigoLocalizacaoFisica;

    if fCfgSis('COLVAL', varBoolean) then
      qryCADLOT.ParamByName('DATA_VALIDADE').AsDateTime         := dtaDataValidade;

    qryCADLOT.Open;

    if qryCADLOT.isEmpty then
    begin
      qryCADLOT.Insert;
      qryCADLOT.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', VS_strCodEmp);
      qryCADLOT.FieldByName('LOT_NUMLOT').AsString   := TCadLot.fGetProximoNUMLOT(strCodigoItem);
      qryCADLOT.FieldByName('LOT_CODEMP').AsString   := VS_strCodEmp;
      qryCADLOT.FieldByName('LOT_CODITE').AsString   := strCodigoItem;

      if fCfgSis('COLVAL', varBoolean) and (dtaDataValidade <> 0)then
      begin
        qryCADLOT.FieldByName('LOT_DTAFAB').Value      := dtaDataValidade;
        qryCADLOT.FieldByName('LOT_DTAVAL').Value      := dtaDataValidade;
      end
      else
      begin
        qryCADLOT.FieldByName('LOT_DTAFAB').Value      := VS_Date;
        qryCADLOT.FieldByName('LOT_DTAVAL').Value      := VS_Date;
      end;

      qryCADLOT.FieldByName('LOT_DTABAL').Value      := VS_Date -1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
      qryCADLOT.FieldByName('LOT_SALBAL').AsFloat    := 0;
      qryCADLOT.FieldByName('LOT_SALDOS').AsFloat    := 0;
      qryCADLOT.FieldByName('LOT_ML_BAL').AsFloat    := 0;
      qryCADLOT.FieldByName('LOT_SAL_ML').AsFloat    := 0;
      qryCADLOT.FieldByName('LOT_SALCON').Value      := Null;
      qryCADLOT.FieldByName('LOT_DIGCON').AsString   := 'N';
      qryCADLOT.FieldByName('LOT_ORDCON').Value      := Null;
      qryCADLOT.FieldByName('LOT_DIFSAL').AsFloat    := 0;
      qryCADLOT.FieldByName('LOT_LOCFIS').AsString   := strCodigoLocalizacaoFisica;
      qryCADLOT.Post;
    end;

    Result := qryCADLOT.FieldByName('LOT_NUMLOT').AsString;

    qryCADLOT.Close;

  finally
    FreeAndNil(qryCADLOT);
  end;
end;

function TCadLot.fGeraLoteEmpresas(qryLote: TUniQuery; blnCriaEmpresasWms : Boolean = False; blnBaixaOPI: Boolean = False; AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual = Nil): Boolean;
  Var
    blnUsarSaldoItem: Boolean;
    stlEmpresas: TStringList;
    intContador: Integer;
    qryGenerica: TUniQuery;

    fltSaldo: Double;
    fltSaldoML: Double;

    blnReplicaEmpresa: Boolean;
begin
  (*If fUsaRotinaWMS And
  Begin
    Result := True;
    Exit;
  End;*)

  If (fCfgSis('TREPLO', varString) = '2') And
     (fCfgSis('CTLEST', varString) = '1') And
     (Not (fCfgSis('UTIWMS', VarBoolean))) Then
  Begin
    qryGenerica := fCriaQuery(Self);
    With qryGenerica, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM CADLOT WHERE FALSE');
      Open;


      If (Not fExisteLote(qryLote.FieldByName('LOT_CODITE').AsString, VS_strCodEmp, 'A DEFINIR', False, False)) Then
      Begin
        qryGenerica.Insert;

        FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', VS_strCodEmp);
        FieldByName('LOT_NUMLOT').AsString   := 'A DEFINIR';
        FieldByName('LOT_CODEMP').AsString   := VS_strCodEmp;
        FieldByName('LOT_CODITE').AsString   := qryLote.FieldByName('LOT_CODITE').AsString;
        FieldByName('LOT_DTAFAB').Value      := qryLote.FieldByName('LOT_DTAFAB').Value;
        FieldByName('LOT_DTAVAL').Value      := qryLote.FieldByName('LOT_DTAVAL').Value;
        FieldByName('LOT_DTABAL').Value      := qryLote.FieldByName('LOT_DTABAL').Value;
        FieldByName('LOT_SALBAL').AsFloat    := 0;
        FieldByName('LOT_SALDOS').AsFloat    := 0;
        FieldByName('LOT_ML_BAL').AsFloat    := 0;
        FieldByName('LOT_SAL_ML').AsFloat    := 0;
        FieldByName('LOT_SALCON').Value      := Null;
        FieldByName('LOT_DIGCON').AsString   := 'N';
        FieldByName('LOT_ORDCON').Value      := Null;
        FieldByName('LOT_DIFSAL').AsFloat    := 0;
        FieldByName('LOT_LOCFIS').AsString   := IfThen(blnCriaEmpresasWms,'A DEFINIR',''); (*qryLote.FieldByName('LOT_LOCFIS').AsString*)

        fGravaLogLocFisica(FieldByName('LOT_CODITE').AsString, '','', 1, FieldByName('LOT_NUMLOT').AsString);

        Post;
      End;
    end;

    freeAndNil(qryGenerica);

    Result := True;
    Exit;
  End;

  Try

    stlEmpresas := TStringList.Create;
    If fUsaRotinaWMS Then
    Begin
      If fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') And (not blnCriaEmpresasWms) Then
        stlEmpresas.Text := VS_strCodEmp
      Else
        stlEmpresas.Text := AnsiReplaceStr(fRetEmpresasWms(True),',', #13#10)
    End
    Else
      stlEmpresas.Text := AnsiReplaceStr(fRetEmpresasWms(False),',', #13#10);

    qryGenerica := fCriaQuery(Self);

    For intContador := 0 To stlEmpresas.Count - 1 Do
    Begin
      blnReplicaEmpresa := ( (fCfgSis('AMZEMP', varBoolean)) And (fCfgSis('CTLEST', varString) = '2') ) Or
                           (fCfgSis('CTLEST', varString) <> '2');

      // CADASTRANDO O LOTE INFORMADO EM CADA OUTRA EMPRESA
      If (blnReplicaEmpresa) And
         (stlEmpresas[intContador] <> qryLote.FieldByName('LOT_CODEMP').AsString) And
         (Not fExisteLote(qryLote.FieldByName('LOT_CODITE').AsString,
                          stlEmpresas[intContador],
                          qryLote.FieldByName('LOT_NUMLOT').AsString)) and
         (fPodeGravarLote(AdictLocalizacaoFisicaEmpresa, stlEmpresas[intContador])) Then
      Begin
        With qryGenerica, SQL Do
        Begin
          Close;
          Clear;
          Add('SELECT * FROM CADLOT WHERE FALSE');
          Open;
          qryGenerica.Insert;

          fltSaldo := 0;
          fltSaldoML := 0;

          blnUsarSaldoItem := (Not fExisteLote(qryLote.FieldByName('LOT_CODITE').AsString, stlEmpresas[intContador], '', False, True, True));
          If (blnUsarSaldoItem) Then
          Begin
            fltSaldo := fRetSaldosEmpresa(qryLote.FieldByName('LOT_CODITE').AsString,
                                          stlEmpresas[intContador]);

            If fUsaRotinaWMS Then
              fltSaldoML := fRetSaldosMLEmpresa(qryLote.FieldByName('LOT_CODITE').AsString,
                                                stlEmpresas[intContador]);
          End;

          FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', stlEmpresas[intContador]);
          FieldByName('LOT_NUMLOT').AsString   := qryLote.FieldByName('LOT_NUMLOT').AsString;
          FieldByName('LOT_CODEMP').AsString   := stlEmpresas[intContador];
          FieldByName('LOT_CODITE').AsString   := qryLote.FieldByName('LOT_CODITE').AsString;
          FieldByName('LOT_DTAFAB').Value      := qryLote.FieldByName('LOT_DTAFAB').Value;
          FieldByName('LOT_DTAVAL').Value      := qryLote.FieldByName('LOT_DTAVAL').Value;
          FieldByName('LOT_DTABAL').Value      := fCampoTabela('ITE_DTABAL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                                      [qryLote.FieldByName('LOT_CODITE').AsString, stlEmpresas[intContador]]);
          FieldByName('LOT_SALBAL').AsFloat    := fltSaldo;
          FieldByName('LOT_SALDOS').AsFloat    := fltSaldo;
          FieldByName('LOT_ML_BAL').AsFloat    := fltSaldoML;
          FieldByName('LOT_SAL_ML').AsFloat    := fltSaldoML;
          FieldByName('LOT_SALCON').Value      := Null;
          FieldByName('LOT_DIGCON').AsString   := 'N';
          FieldByName('LOT_ORDCON').Value      := Null;
          FieldByName('LOT_DIFSAL').AsFloat    := 0;
          FieldByName('LOT_LOCFIS').AsString   := IfThen(blnCriaEmpresasWms,fRetornaLocalizacaoFisicaWMS(AdictLocalizacaoFisicaEmpresa, stlEmpresas[intContador]),qryLote.FieldByName('LOT_LOCFIS').AsString);

          If (fCfgSis('LOTEND', varString) = '2') And fUsaRotinaWMS Then
            FieldByName('LOT_CODBAR').AsString   := qryLote.FieldByName('LOT_NUMLOT').AsString;

          Post;

          fGravaLogLocFisica(FieldByName('LOT_CODITE').AsString, '','', 1, FieldByName('LOT_NUMLOT').AsString);

          Close;
        End;
      End;

      blnReplicaEmpresa :=
         (
           ( (fCfgSis('AMZEMP', varBoolean)) And (fCfgSis('CTLEST', varString) = '2') ) Or
           (
             (Not fCfgSis('AMZEMP', varBoolean)) And
             (stlEmpresas[intContador] = qryLote.FieldByName('LOT_CODEMP').AsString)
           ) Or
           (fCfgSis('CTLEST', varString) = '1')
         );

      // CADASTRANDO O LOTE "A DEFINIR" EM CADA EMPRESA
      If (blnReplicaEmpresa) Then
      Begin
        With qryGenerica, SQL Do
        Begin
          Close;
          Clear;
          Add('SELECT * FROM CADLOT WHERE FALSE');
          Open;

          If (Not fExisteLote(qryLote.FieldByName('LOT_CODITE').AsString, stlEmpresas[intContador], 'A DEFINIR', False, False)) Then
          Begin
            qryGenerica.Insert;

            FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', stlEmpresas[intContador]);
            FieldByName('LOT_NUMLOT').AsString   := 'A DEFINIR';
            FieldByName('LOT_CODEMP').AsString   := stlEmpresas[intContador];
            FieldByName('LOT_CODITE').AsString   := qryLote.FieldByName('LOT_CODITE').AsString;
            FieldByName('LOT_DTAFAB').Value      := qryLote.FieldByName('LOT_DTAFAB').Value;
            FieldByName('LOT_DTAVAL').Value      := qryLote.FieldByName('LOT_DTAVAL').Value;
            FieldByName('LOT_DTABAL').Value      := qryLote.FieldByName('LOT_DTABAL').Value;
            FieldByName('LOT_SALBAL').AsFloat    := 0;
            FieldByName('LOT_SALDOS').AsFloat    := 0;
            FieldByName('LOT_ML_BAL').AsFloat    := 0;
            FieldByName('LOT_SAL_ML').AsFloat    := 0;
            FieldByName('LOT_SALCON').Value      := Null;
            FieldByName('LOT_DIGCON').AsString   := 'N';
            FieldByName('LOT_ORDCON').Value      := Null;
            FieldByName('LOT_DIFSAL').AsFloat    := 0;
            FieldByName('LOT_LOCFIS').AsString   := IfThen(blnCriaEmpresasWms,'A DEFINIR',''); (*qryLote.FieldByName('LOT_LOCFIS').AsString*)

            If (fCfgSis('LOTEND', varString) = '2') And fUsaRotinaWMS Then
              FieldByName('LOT_CODBAR').AsString   := 'A DEFINIR';

            fGravaLogLocFisica(FieldByName('LOT_CODITE').AsString, '','', 1, FieldByName('LOT_NUMLOT').AsString);

            Post;
          End;

          If (fCfgSis('GARANT', varBoolean, stlEmpresas[intContador])) And
             (Not fExisteLote(qryLote.FieldByName('LOT_CODITE').AsString, stlEmpresas[intContador], 'GARANTIA', False, False)) Then
          Begin
            qryGenerica.Insert;

            FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', stlEmpresas[intContador]);
            FieldByName('LOT_NUMLOT').AsString   := 'GARANTIA';
            FieldByName('LOT_CODEMP').AsString   := stlEmpresas[intContador];
            FieldByName('LOT_CODITE').AsString   := qryLote.FieldByName('LOT_CODITE').AsString;
            FieldByName('LOT_DTAFAB').Value      := qryLote.FieldByName('LOT_DTAFAB').Value;
            FieldByName('LOT_DTAVAL').Clear;
            FieldByName('LOT_DTABAL').Value      := qryLote.FieldByName('LOT_DTABAL').Value;
            FieldByName('LOT_SALBAL').AsFloat    := 0;
            FieldByName('LOT_SALDOS').AsFloat    := 0;
            FieldByName('LOT_ML_BAL').AsFloat    := 0;
            FieldByName('LOT_SAL_ML').AsFloat    := 0;
            FieldByName('LOT_SALCON').Value      := Null;
            FieldByName('LOT_DIGCON').AsString   := 'N';
            FieldByName('LOT_GARPRI').AsString   := 'S';
            FieldByName('LOT_ORDCON').Value      := Null;
            FieldByName('LOT_DIFSAL').AsFloat    := 0;
            FieldByName('LOT_LOCFIS').AsString   := IfThen(blnCriaEmpresasWms,'GARANTIA',''); (*qryLote.FieldByName('LOT_LOCFIS').AsString*)

            If (fCfgSis('LOTEND', varString) = '2') And fUsaRotinaWMS Then
              FieldByName('LOT_CODBAR').AsString   := 'GARANTIA';

            Post;


            fGravaLogLocFisica(FieldByName('LOT_CODITE').AsString, '','', 1, FieldByName('LOT_NUMLOT').AsString);

          End;

          Close;
        End;
      End;

    End;

    FreeAndNil(qryGenerica);
    FreeAndNil(stlEmpresas);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadLot.fGeraLoteEmpresas]');
    End;
  End;

end;

class function TCadLot.ExisteLoteEstoqueExterno(const ACodIte, ACodExt: String; var ANumLot: String): Boolean;
begin
  Result := ExisteLoteEstoqueExterno(ACodIte, ACodExt, VS_strCodEmp, ANumLot);
end;

class function TCadLot.ExisteLoteEstoqueExterno(const ACodIte, ACodExt, ACodEmp: String; var ANumLot: String): Boolean;
begin
  ANumLot := fCampoTabela('LOT_NUMLOT', 'CADLOT', ['LOT_FULFIL', 'LOT_CODEXT', 'LOT_CODEMP', 'LOT_CODITE'], ['S', ACodExt, ACodEmp, ACodIte]);
  Result  := Not ANumLot.IsEmpty;
end;

class function TCadLot.GeraLoteEstoqueExterno(const ACodIte, ACodExt: String; var ANumLot: String): Boolean;
  Var
    qryCadLot : TUniQuery;
    qryIteGer : TUniQuery;
Begin

  Result := False;

  qryCadLot := fCriaQuery(Nil);
  qryIteGer := fCriaQuery(Nil);

  Try

    Try

      qryIteGer.Close;
      qryIteGer.SQL.Clear;
      qryIteGer.SQL.Add('SELECT ');
      qryIteGer.SQL.Add('  ITE_CODEMP ');
      qryIteGer.SQL.Add('FROM         ');
      qryIteGer.SQL.Add('  ITEGER     ');
      qryIteGer.SQL.Add('WHERE ITE_CODITE = "' + ACodIte + '" ');
      qryIteGer.Open;

      If qryIteGer.IsEmpty Then
        Exit;

      qryCadLot.Close;
      qryCadLot.SQL.Clear;
      qryCadLot.SQL.Add('SELECT * FROM CADLOT WHERE FALSE');
      qryCadLot.Open;

      ANumLot := GeraNumeroLoteEstoqueExterno(ACodExt);

      While Not qryIteGer.Eof Do
      Begin

        If (Not fUsaRotinaWMS(qryIteGer.FieldByName('ITE_CODEMP').AsString)) And
           (Not TCadLot.ProdutoTemLote(ACodIte, qryIteGer.FieldByName('ITE_CODEMP').AsString)) Then
        Begin
          qryIteGer.Next;
          Continue;
        End;

        If untFuncoesGenerica.fExisteLote(ANumLot, ACodIte, qryIteGer.FieldByName('ITE_CODEMP').AsString) Then
        Begin
          qryIteGer.Next;
          Continue;
        End;

        qryCadLot.Insert;
        qryCadLot.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADLOT', qryIteGer.FieldByName('ITE_CODEMP').AsString);
        qryCadLot.FieldByName('LOT_NUMLOT').AsString := ANumLot;
        qryCadLot.FieldByName('LOT_CODEMP').AsString := qryIteGer.FieldByName('ITE_CODEMP').AsString;
        qryCadLot.FieldByName('LOT_CODITE').AsString := ACodIte;
        qryCadLot.FieldByName('LOT_DTAFAB').Value    := VS_Date;
        qryCadLot.FieldByName('LOT_DTAVAL').Value    := IncYear(VS_Date, 100);
        qryCadLot.FieldByName('LOT_DTABAL').Value    := VS_Date-1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
        qryCadLot.FieldByName('LOT_SALBAL').AsFloat  := 0;
        qryCadLot.FieldByName('LOT_SALDOS').AsFloat  := 0;
        qryCadLot.FieldByName('LOT_CODEXT').AsString := ACodExt;
        qryCadLot.FieldByName('LOT_FULFIL').AsString := 'S';
        qryCadLot.FieldByName('LOT_ML_BAL').AsFloat  := 0;
        qryCadLot.FieldByName('LOT_SAL_ML').AsFloat  := 0;
        qryCadLot.FieldByName('LOT_SALCON').Value    := Null;
        qryCadLot.FieldByName('LOT_DIGCON').AsString := 'N';
        qryCadLot.FieldByName('LOT_ABSAUT').AsString := 'N';
        qryCadLot.FieldByName('LOT_LOTAPR').AsString := 'S';
        qryCadLot.FieldByName('LOT_STATUS').AsString := 'B';//Deve ficar bloqueado para nao permitir vendas pelo autcom
        qryCadLot.FieldByName('LOT_ORDCON').Value    := Null;
        qryCadLot.FieldByName('LOT_DIFSAL').AsFloat  := 0;
        qryCadLot.FieldByName('LOT_LOCFIS').AsString := '';
        qryCadLot.Post;
        qryIteGer.Next;
      End;

      Result := True;

    Finally
      FreeAndNil(qryCadLot);
      FreeAndNil(qryIteGer);
    End;

  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao inserir o LOTE!' + #13 + E.Message);

  End;

end;

class function TCadLot.GeraLoteTAPedidoCancelado(const ACodIte: String; var ANumLot, ALocFis: String; const ACodEmp: String = ''): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux    := fCriaQuery;

  try
    qryAux.SQL.Add('SELECT * FROM CADLOT WHERE FALSE');
    qryAux.Open;

    qryAux.Insert;
    qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADLOT', VS_strCodEmp);
    qryAux.FieldByName('LOT_NUMLOT').AsString := ANumLot;
    qryAux.FieldByName('LOT_CODEMP').AsString := IIF(ACodEmp.IsEmpty, VS_strCodEmp, ACodEmp);
    qryAux.FieldByName('LOT_CODITE').AsString := ACodIte;
    qryAux.FieldByName('LOT_DTAFAB').Value    := VS_Date;
    qryAux.FieldByName('LOT_DTAVAL').Value    := IncYear(VS_Date, 100);
    qryAux.FieldByName('LOT_DTABAL').Value    := VS_Date-1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
    qryAux.FieldByName('LOT_SALBAL').AsFloat  := 0;
    qryAux.FieldByName('LOT_SALDOS').AsFloat  := 0;
    qryAux.FieldByName('LOT_ML_BAL').AsFloat  := 0;
    qryAux.FieldByName('LOT_SAL_ML').AsFloat  := 0;
    qryAux.FieldByName('LOT_SALCON').Value    := Null;
    qryAux.FieldByName('LOT_DIGCON').AsString := 'N';
    qryAux.FieldByName('LOT_ABSAUT').AsString := 'N';
    qryAux.FieldByName('LOT_LOTAPR').AsString := 'S';
    qryAux.FieldByName('LOT_STATUS').AsString := 'S';
    qryAux.FieldByName('LOT_ORDCON').Value    := Null;
    qryAux.FieldByName('LOT_DIFSAL').AsFloat  := 0;
    qryAux.FieldByName('LOT_LOCFIS').AsString := ALocFis;
    qryAux.Post;

    Result := True;
  finally
    FreeAndNil(qryAux);
  end;
end;

class function TCadLot.GeraLoteAtivo(const ACodIte, ANumLot, ALocFis: String; const ACodEmp: String = '';
  AUsarIgnore: Boolean = False; const ADtaVal: TDateTime = 0): Boolean;
var
  LQry: TUniQuery;
begin
  LQry    := fCriaQuery;

  try
    LQry.SQL.Add('INSERT ' + IIF(AUsarIgnore, 'IGNORE', '') + ' INTO CADLOT ');
    LQry.SQL.Add('  (AUTOINCREM, LOT_NUMLOT, LOT_CODEMP, LOT_CODITE, LOT_DTAFAB, LOT_DTAVAL, LOT_DTABAL, LOT_SALBAL, ');
    LQry.SQL.Add('   LOT_SALDOS, LOT_ML_BAL, LOT_SAL_ML, LOT_SALCON, LOT_DIGCON, LOT_ABSAUT, LOT_LOTAPR, LOT_STATUS, ');
    LQry.SQL.Add('   LOT_ORDCON, LOT_DIFSAL, LOT_LOCFIS) ');
    LQry.SQL.Add('VALUES ');
    LQry.SQL.Add('  (:AUTOINCREM, :LOT_NUMLOT, :LOT_CODEMP, :LOT_CODITE, :LOT_DTAFAB, :LOT_DTAVAL, :LOT_DTABAL, :LOT_SALBAL, ');
    LQry.SQL.Add('   :LOT_SALDOS, :LOT_ML_BAL, :LOT_SAL_ML, :LOT_SALCON, :LOT_DIGCON, :LOT_ABSAUT, :LOT_LOTAPR, :LOT_STATUS, ');
    LQry.SQL.Add('   :LOT_ORDCON, :LOT_DIFSAL, :LOT_LOCFIS) ');

    LQry.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADLOT', VS_strCodEmp);
    LQry.ParamByName('LOT_NUMLOT').AsString := ANumLot;
    LQry.ParamByName('LOT_CODEMP').AsString := IIF(ACodEmp.IsEmpty, VS_strCodEmp, ACodEmp);
    LQry.ParamByName('LOT_CODITE').AsString := ACodIte;
    LQry.ParamByName('LOT_DTAFAB').Value    := VS_Date;

    if (ADtaVal > 0) then
      LQry.ParamByName('LOT_DTAVAL').Value    := ADtaVal
    else
      LQry.ParamByName('LOT_DTAVAL').Value    := IncYear(VS_Date, 100);

    LQry.ParamByName('LOT_DTABAL').Value    := VS_Date-1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
    LQry.ParamByName('LOT_SALBAL').AsFloat  := 0;
    LQry.ParamByName('LOT_SALDOS').AsFloat  := 0;
    LQry.ParamByName('LOT_ML_BAL').AsFloat  := 0;
    LQry.ParamByName('LOT_SAL_ML').AsFloat  := 0;
    LQry.ParamByName('LOT_SALCON').Value    := Null;
    LQry.ParamByName('LOT_DIGCON').AsString := 'N';
    LQry.ParamByName('LOT_ABSAUT').AsString := 'N';
    LQry.ParamByName('LOT_LOTAPR').AsString := 'S';
    LQry.ParamByName('LOT_STATUS').AsString := 'S';
    LQry.ParamByName('LOT_ORDCON').Value    := Null;
    LQry.ParamByName('LOT_DIFSAL').AsFloat  := 0;
    LQry.ParamByName('LOT_LOCFIS').AsString := ALocFis;
    LQry.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TCadLot.GeraNumeroLoteEstoqueExterno(const ACodExt: String): String;
begin
  Result := 'FULFILLMENT_' + ACodExt;
end;

Function TCadLot.fReplicaLote: Boolean;
Begin
  Result := (
             ((fCfgSis('CTLEST', varString) = '1') And (fCfgSis('TREPLO', varString) = '1')) Or
             ((fCfgSis('CTLEST', varString) = '2') And (fCfgSis('AMZEMP', varBoolean)))
             );
End;

function TCadLot.fGeraLotesReplicacao(qryLote: TUniQuery; blnBaixaOPI: Boolean = False): Boolean;
  Var
    intContador: Integer;
    stlEmpresas: TStringList;
    fltSaldo, fltSaldoML: Double;
    qryLotRep, qryGenerica: TUniQuery;
begin
  Result := True;

  If ( Not (
             (fCfgSis('REPLOT', varBoolean)) And (fCfgSis('CTLEST', varString) = '2')
           )
     ) Then
    Exit;

  Try
    stlEmpresas := TStringList.Create;

    If fUsaRotinaWMS Then
      stlEmpresas.Text := AnsiReplaceStr(fRetEmpresasWms(True),',', #13#10)
    Else
      stlEmpresas.Text := AnsiReplaceStr(fRetEmpresasWms(False),',', #13#10);

    qryLotRep := fCriaQuery(Self);
    qryLotRep.Close();
    qryLotRep.SQL.Clear();
    qryLotRep.SQL.Text := 'SELECT * FROM CADAMZ WHERE AMZ_REPAMZ = "S" AND AMZ_CODAMZ <> :CODAMZ AND AMZ_CODEMP = "'+VS_StrCodEmp+'"';
    qryLotRep.ParamByName('CODAMZ').AsString := qryLote.FieldByName('LOT_NUMLOT').AsString;
    qryLotRep.Open();

    qryLotRep.First();

    qryGenerica := fCriaQuery(Self);

    While (Not qryLotRep.Eof) Do Begin

      For intContador := 0 To stlEmpresas.Count - 1 Do Begin

        If (Not fCfgSis('AMZEMP', varBoolean)) And (stlEmpresas[intContador] <> VS_strCodEmp) Then
          Continue;

        If (Not fExisteLote(qryLote.FieldByName('LOT_CODITE').AsString,
                            stlEmpresas[intContador],
                            qryLotRep.FieldByName('AMZ_CODAMZ').AsString, False, False )) Then Begin
          With qryGenerica, SQL Do Begin

            Close;
            Clear;
            Add('SELECT * FROM CADLOT WHERE FALSE');
            Open;
            qryGenerica.Insert;

            fltSaldo := 0;
            fltSaldoML := 0;

            FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', stlEmpresas[intContador]);
            FieldByName('LOT_NUMLOT').AsString   := qryLotRep.FieldByName('AMZ_CODAMZ').AsString;
            FieldByName('LOT_CODEMP').AsString   := stlEmpresas[intContador];
            FieldByName('LOT_CODITE').AsString   := qryLote.FieldByName('LOT_CODITE').AsString;
            FieldByName('LOT_DTAFAB').Value      := qryLote.FieldByName('LOT_DTAFAB').Value;
            FieldByName('LOT_DTAVAL').Value      := qryLote.FieldByName('LOT_DTAVAL').Value;
            FieldByName('LOT_DTABAL').Value      := fCampoTabela('ITE_DTABAL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                                        [qryLote.FieldByName('LOT_CODITE').AsString, stlEmpresas[intContador]]);
            FieldByName('LOT_SALBAL').AsFloat    := fltSaldo;
            FieldByName('LOT_SALDOS').AsFloat    := fltSaldo;
            FieldByName('LOT_ML_BAL').AsFloat    := fltSaldoML;
            FieldByName('LOT_SAL_ML').AsFloat    := fltSaldoML;
            FieldByName('LOT_SALCON').Value      := Null;
            FieldByName('LOT_DIGCON').AsString   := 'N';
            FieldByName('LOT_ORDCON').Value      := Null;
            FieldByName('LOT_DIFSAL').AsFloat    := 0;
            FieldByName('LOT_LOCFIS').AsString   := qryLote.FieldByName('LOT_LOCFIS').AsString;

            FieldByName('LOT_PRIPRO').AsString   := qryLotRep.FieldByName('AMZ_PRIPRO').AsString;
            FieldByName('LOT_ARMPRC').AsString   := qryLotRep.FieldByName('AMZ_ARMPRC').AsString;
            FieldByName('LOT_GARPRI').AsString   := qryLotRep.FieldByName('AMZ_GARPRI').AsString;
            FieldByName('LOT_ARMOPV').AsString   := qryLotRep.FieldByName('AMZ_ARMOPV').AsString;
            FieldByName('LOT_ARMPRI').AsString   := qryLotRep.FieldByName('AMZ_ARMPRI').AsString;
            FieldByName('LOT_PRITIN').AsString   := qryLotRep.FieldByName('AMZ_PRITIN').AsString;

            If (fCfgSis('LOTEND', varString) = '2') And blnBaixaOPI And fUsaRotinaWMS Then
              FieldByName('LOT_CODBAR').AsString   := qryLote.FieldByName('LOT_NUMLOT').AsString;


            Post;
            Close;

            If (qryLotRep.FieldByName('AMZ_ARMOPV').AsString = 'S') Then
              pAjustaArmPrincipalOrcamentoPedidoVenda(qryLotRep.FieldByName('AMZ_CODAMZ').AsString,
                qryLote.FieldByName('LOT_CODITE').AsString);

            If (qryLotRep.FieldByName('AMZ_ARMPRI').AsString = 'S') Then
              pAjustaArmPrincipalVenda(qryLotRep.FieldByName('AMZ_CODAMZ').AsString,
                qryLote.FieldByName('LOT_CODITE').AsString);

            If (qryLotRep.FieldByName('AMZ_ARMPRC').AsString = 'S') Then
              pAjustaArmPrincipalCompra(qryLotRep.FieldByName('AMZ_CODAMZ').AsString,
                qryLote.FieldByName('LOT_CODITE').AsString);

            If (qryLotRep.FieldByName('AMZ_GARPRI').AsString = 'S') Then
              pAjustaArmPrincipalGarantia(qryLotRep.FieldByName('AMZ_CODAMZ').AsString,
                qryLote.FieldByName('LOT_CODITE').AsString);

            If (qryLotRep.FieldByName('AMZ_PRIPRO').AsString = 'S') Then
              pAjustaArmPrincipalProducao(qryLotRep.FieldByName('AMZ_CODAMZ').AsString,
                qryLote.FieldByName('LOT_CODITE').AsString);

            If (qryLotRep.FieldByName('AMZ_PRITIN').AsString = 'S') Then
              pAjustaLotePrincipalTintaMaquina(qryLotRep.FieldByName('AMZ_CODAMZ').AsString,
                qryLote.FieldByName('LOT_CODITE').AsString);
          End;

        End;

      End;

      qryLotRep.Next();
    End;

    FreeAndNil(qryLotRep);
    FreeAndNil(qryGenerica);
    FreeAndNil(stlEmpresas);
  Except
    On E: Exception Do Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadLot.fGeraLotesReplicacao]');
    End;
  End;
end;

function TCadLot.fGetStrTitLab: String;
begin
  Result := FTitLab;
end;

Function TCadLot.fSalvaContagemLote(strAutInc,
                                    strCodIte,
                                    strNumLot,
                                    strCodDig,
                                    strIncHis: String;
                                    fltQtdCon,
                                    fltQtdConML: Double;
                                    intOrdCon: Integer;
                                    strAutIncCONDET: String = '';
                                    strCodOpe: String = ''): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
begin
  Try
    Result := True;

    qryGenIte := fCriaQuery;

    If fEmptyStr(strCodIte) Then
    Begin
      With qryGenIte Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( ' SELECT SQL_NO_CACHE         ' );
        SQL.Add( '        LOT_NUMLOT,          ' );
        SQL.Add( '        LOT_CODEMP,          ' );
        SQL.Add( '        LOT_CODITE           ' );
        SQL.Add( ' FROM CADLOT                 ' );
        SQL.Add( ' WHERE AUTOINCREM = :AUTOINC ' );

        ParamByName('AUTOINC').AsString := strAutInc;

        Open;

        strCodIte := FieldByName('LOT_CODITE').AsString;
        strNumLot := FieldByName('LOT_NUMLOT').AsString;

        TConDet.fGravaConDet(FConAcu, Self.Owner, strCodIte, VS_strCodEmp, strNumLot, 'S', strAutIncCONDET, fltQtdCon, fltQtdConML, (FConEst = 1), False, strCodOpe );
        THistoricoBalanco.pIncluiHistorico(VS_strCodEmp, strCodIte, strNumLot, strCodDig, strIncHis, fltQtdCon, fltQtdConML);

        strCodIte := '';
        strNumLot := '';

      End;

    End Else
    Begin
      TConDet.fGravaConDet(FConAcu, Self.Owner, strCodIte, VS_strCodEmp, strNumLot, 'S', strAutIncCONDET, fltQtdCon, fltQtdConML, (FConEst = 1), False, strCodOpe );
      THistoricoBalanco.pIncluiHistorico(VS_strCodEmp, strCodIte, strNumLot, strCodDig, strIncHis, fltQtdCon, fltQtdConML);
    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADLOT ';
    strSQL := strSQL + 'SET ';

    If FConEst = 1 Then
    Begin
      If FConAcu Then
      Begin
        strSQL := strSQL + '  LOT_SALCON = IFNULL(LOT_SALCON, 0) + :QTDCON, ';
        strSQL := strSQL + '  LOT_ML_CON = IFNULL(LOT_ML_CON, 0) + :QTDMLCON, ';
      End
      Else
      Begin
        strSQL := strSQL + '  LOT_SALCON = :QTDCON, ';
        strSQL := strSQL + '  LOT_ML_CON = :QTDMLCON, ';
      end;
    End
    Else
    Begin

      strSQL := strSQL + '  LOT_SALCON = :QTDCON, ';
      strSQL := strSQL + '  LOT_ML_CON = :QTDMLCON, ';

      strSQL := strSQL + '  LOT_DIFSAL = IFNULL(LOT_SALDOS, 0) - :QTDCON, ';
      strSQL := strSQL + '  LOT_DIF_ML = IFNULL(LOT_SAL_ML, 0) - :QTDMLCON, ';
    End;

      strSQL := strSQL + '  LOT_ORDCON = :ORDCON,                         ';
    strSQL := strSQL + '  LOT_DIGCON = "S"                              ';

    strSQL := strSQL + 'WHERE ';

    If Not fEmptyStr(strAutInc) Then
    Begin
      strSQL := strSQL + '  AUTOINCREM = :AUTINC ';
    End Else
    Begin
      strSQL := strSQL + '  LOT_NUMLOT = :NUMLOT AND  ';
      strSQL := strSQL + '  LOT_CODEMP = :CODEMP AND  ';
      strSQL := strSQL + '  LOT_CODITE = :CODITE  ';
    End;

    Try

      With qryGenIte Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
          ParamByName('ORDCON').AsInteger := intOrdCon;

        ParamByName('QTDCON').AsFloat   := fltQtdCon;
        ParamByName('QTDMLCON').AsFloat   := fltQtdConML;

        If Not fEmptyStr(strAutInc) Then
        Begin
          ParamByName('AUTINC').AsString := strAutInc;
        End Else
        Begin
          ParamByName('CODITE').AsString := strCodIte;
          ParamByName('NUMLOT').AsString := strNumLot;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
        End;

        ExecSQL;
        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadLot.fSalvaContagemLote]');
      End;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

End;


procedure TCadLot.pZerarLotesSemNecessidadeCalc(AFunctionGetFiltros: TFunctionGetFiltros = nil; AProcSetarParametros: TProcSetarParametros = nil);
  Var
    qryZerIte: TUniQuery;
    GerenciaBalancoEstoqueManutencao: TGerenciaBalancoEstoqueManutencao;
begin
  qryZerIte := fCriaQuery(Nil);
  Try
    If (FConEst = 1) And (TGerenciaBalancoEstoqueManutencao.fUtilizaRecurso) Then
      GerenciaBalancoEstoqueManutencao := TGerenciaBalancoEstoqueManutencao.pIniciaProcesso;

    With qryZerIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(' UPDATE                                              ');
      SQL.Add('   CADLOT                                            ');
      SQL.Add('   INNER JOIN CADITE I ON I.ITE_CODITE = LOT_CODITE  ');
      If Assigned(GerenciaBalancoEstoqueManutencao) Then
      Begin
        if (fCfgSis('ESTMAN', varInteger) = 2)  Then
        Begin
          SQL.Add('   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Lote_ESTMAN+' M ON M.FDO_CODITE = LOT_CODITE  AND M.ID_OPERACAO = "'+GerenciaBalancoEstoqueManutencao.IDOperacao+'"');
          SQL.Add('  AND  M.FGO_EMPEXP = LOT_CODEMP ');
          SQL.Add('  AND  M.FDO_NUMLOT = LOT_NUMLOT ');
        End;

        if (GerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS)  Then
        Begin
          SQL.Add('   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Lote_BEACCS +' B ON B.FDO_CODITE = LOT_CODITE AND B.ID_OPERACAO = "'+GerenciaBalancoEstoqueManutencao.IDOperacao+'"');
          SQL.Add('  AND  B.FGO_CODEMP = LOT_CODEMP ');
          SQL.Add('  AND  B.FDO_NUMLOT = LOT_NUMLOT ');
        End;

      End;

      SQL.Add('   INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE');
      SQL.Add('                      AND G.ITE_CODEMP = LOT_CODEMP  ');
      SQL.Add(' SET                                                 ');
      SQL.Add('  LOT_QTDAJU = 0, ');
      SQL.Add('  LOT_DTAAJU = CURDATE(), ');
      SQL.Add('  LOT_SEQAJU = NULL, ');
      SQL.Add('  LOT_ORDCON = 0,                                   ');
      SQL.Add('  LOT_SALCON = 0,                                   ');
      SQL.Add('  LOT_ML_CON = 0,                                   ');
      SQL.Add('  LOT_DIFSAL = 0,                                   ');
      SQL.Add('  LOT_DIF_ML = 0,                                   ');
      SQL.Add('  LOT_DIGCON = "N"                                  ');
      SQL.Add(' WHERE                                               ');
      SQL.Add('   LOT_DIGCON = "S" AND                              ');

      If FConEst = 1 Then
      Begin
        SQL.Add('   (FORMAT(LOT_SALDOS, 3) =  FORMAT(LOT_SALCON ');
        if fCfgSis('ESTAJU', varInteger) = 2 then
          SQL.Add('   + IFNULL(LOT_SALREG, 0) ');
        If Assigned(GerenciaBalancoEstoqueManutencao) Then
        Begin
          if (fCfgSis('ESTMAN', varInteger) = 2)Then
            SQL.Add('   + IFNULL(LOT_SALMAN, 0) ');
          if (GerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS)  Then
            SQL.Add('   + IFNULL(LOT_BEACCS, 0) ');
        End;
        SQL.Add(', 3)) AND ');

        SQL.Add(' FORMAT(IFNULL(LOT_SAL_ML, 0), 4) = FORMAT(IFNULL(LOT_ML_CON,0), 4) AND ');
      End
      Else
        SQL.Add('   ROUND(LOT_DIFSAL, 3) = 0 AND                        ');

      SQL.Add('   LOT_CODEMP =:CODEMP                               ');
      If Assigned(AFunctionGetFiltros) Then
        SQL.Add(AFunctionGetFiltros);

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      If Assigned(AProcSetarParametros) Then
       AProcSetarParametros(qryZerIte);

      ExecSQL;

    End;
  Finally
    If Assigned(GerenciaBalancoEstoqueManutencao) Then
      FreeAndNil(GerenciaBalancoEstoqueManutencao);
    FreeAndNil(qryZerIte);
  End;
end;

Function TCadLot.fTemMovimentoItemSemLote(strCodIte: String; dtaDtaBal: TDate): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
begin
  Try
  {$IFNDEF LINUX}
    Result := FALSE;
  {$ENDIF}

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT SUM(QTD) AS QTD FROM (';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM MOVDET ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DET_ESPDOC <> "TM" AND          ';
    strSQL := strSQL + '   DET_ESPDOC <> "DF" AND          ';
    strSQL := strSQL + '   IFNULL(DET_NUMLOT, "") = "" AND ';
    strSQL := strSQL + '   DET_CODITE =  :CODITE AND ';
    strSQL := strSQL + '   DET_CODEMP =  :CODEMP AND ';
    strSQL := strSQL + '   DET_DTAENT >= :DTABAL     ';
    strSQL := strSQL + ' ) AS TAB ';

    Try

      With qryGenIte Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('DTABAL').AsDate   := dtaDtaBal;

        Open;

        Result := FieldByName('QTD').AsInteger > 0;
        
        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadLot.fTemMovimentoItemSemLote]');
      End;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

End;

Function TCadLot.fRetOrdemItem: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT IFNULL(MAX(MAXORD), 0) AS MAXORD FROM (');
    SQL.Add('SELECT IFNULL(MAX(ITE_ORDCON), 0) AS MAXORD FROM ITEGER');
    SQL.Add('UNION ALL');
    SQL.Add('SELECT IFNULL(MAX(LOT_ORDCON), 0) AS MAXORD FROM CADLOT');
    SQL.Add(') AS TAB');
    Open;
    Result := Succ(FieldByName('MAXORD').AsInteger);
    Close;
  End;

  FreeAndNil(qryGen);
End;

procedure TCadLot.pZeraContagemLote(strCodIte: String);
  Var
    qryGen : TUniQuery;
    strAutIncConDet: String;
    strSql : String;
begin
  strSql := '';
  strSql := strSql + ' UPDATE                                         ';
  strSql := strSql + '   CADLOT                                       ';
  strSql := strSql + ' SET                                            ';
  strSql := strSql + '   LOT_ORDCON = 0,                              ';
  strSql := strSql + '   LOT_SALCON = 0,                              ';
  strSql := strSql + '   LOT_DIFSAL = 0,                              ';
  strSql := strSql + '   LOT_ML_CON = 0,                              ';
  strSql := strSql + '   LOT_DIF_ML = 0,                              ';
  strSql := strSql + '   LOT_DIGCON = "N"                             ';
  strSql := strSql + ' WHERE                                          ';
  strSql := strSql + '   LOT_CODITE =:CODITE AND                      ';
  strSql := strSql + '   LOT_CODEMP =:CODEMP                          ';

  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( ' SELECT LOT_NUMLOT          ' );
    SQL.Add( ' FROM CADLOT                ' );
    SQL.Add( ' WHERE LOT_CODITE = :CODITE ' );
    SQL.Add( '   AND LOT_CODEMP = :CODEMP ' );

    ParamByName('CODITE').AsString  := strCodIte;
    ParamByName('CODEMP').AsString  := VS_strCodEmp;

    Open;

    strAutIncConDet := fRetAutoIncrem('CONDET', VS_strCodEmp, RecordCount);

    While Not Eof Do
    Begin
      TConDet.fGravaConDet(FConAcu, Self.Owner, strCodIte, VS_strCodEmp, FieldByName('LOT_NUMLOT').AsString, 'N', strAutIncConDet, 0, 0 );
      strAutIncConDet := fNextAutoIncrem(strAutIncConDet);
      Next;
    End;

  End;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);

    ParamByName('CODITE').AsString  := strCodIte;
    ParamByName('CODEMP').AsString  := VS_strCodEmp;

    ExecSQL;

  End;

  FreeAndNil(qryGen);

End;

function TCadLot.fEmpresasPossuemSaldoLote(strNumLot, strCodIte: String; Var strEmpresas: String): Boolean;
  Var
    stlEmpresas: TStringList;
    intContador: Integer;
begin

  Result := False;

  Try
    stlEmpresas := TStringList.Create;
    stlEmpresas.Text := AnsiReplaceStr(fCampoTabela('GROUP_CONCAT(EMP_CODEMP)', 'CADEMP', [], []),',', #13#10);

    strEmpresas := '';

    For intContador := 0 To stlEmpresas.Count - 1 Do
    Begin
      If fSaldoLote(strCodIte, stlEmpresas[intContador], strNumLot) <> 0 Then
      Begin
        Result := True;
        strEmpresas := strEmpresas + stlEmpresas[intContador] + ', ';
      End;
    End;

    If Result Then
    Begin
      strEmpresas := Copy(strEmpresas, 1, Length(strEmpresas) - 2);
    End;

    FreeAndNil(stlEmpresas);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadLot.fEmpresasPossuemSaldoLote]');
    End;
  End;

end;

procedure TCadLot.pExcluirLoteTodasEmpresas(strCodIte, strNumLot, strNomForm: String);
  Var
    qryLotes: TUniQuery;
begin

  qryLotes := fCriaQuery(Self);

  With qryLotes, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT ');
    Add('  *    ');
    Add('FROM   ');
    Add('  CADLOT ');
    Add('WHERE  ');
    Add('   LOT_NUMLOT = "' + strNumLot + '" AND ');
    Add('   LOT_CODITE = "' + strCodIte + '"     ');

    Open;

    While Not IsEmpty Do
    Begin
      fVerificaIntegridade(strNomForm, 'CADLOT', qryLotes, True);
      qryLotes.Delete;
    End;

    Close;
    Clear;

    Add('SELECT ');
    Add('  *    ');
    Add('FROM   ');
    Add('  CADLOT ');
    Add('WHERE  ');
    Add('   LOT_NUMLOT <> "A DEFINIR" AND ');
    Add('   LOT_CODITE = "' + strCodIte + '"     ');

    Open;

    If IsEmpty Then
    Begin

      Close;
      Clear;

      Add('SELECT ');
      Add('  *    ');
      Add('FROM   ');
      Add('  CADLOT ');
      Add('WHERE  ');
      Add('   LOT_NUMLOT = "A DEFINIR" AND ');
      Add('   LOT_CODITE = "' + strCodIte + '"     ');

      Open;

      While Not IsEmpty Do
      Begin
        fVerificaIntegridade(strNomForm, 'CADLOT', qryLotes, True);
        qryLotes.Delete;
      End;

      Close;

    End;
    
  End;

  FreeAndNil(qryLotes);

end;

Function TCadLot.fRetPrecoVendaLote(fltQtdIte: Double; strTabPre: String): Double;
Begin
  if fEmptyStr(strTabPre) then
    strTabPre := '1';

  With qryCadLot Do
  Begin
    If fItemLoteChapa(FieldByName('LOT_CODITE').asString, FOpcDoc) then
      Result :=  IIF(fRetornaPrecoLoteDestinoEntrega, FieldByName('LOT_PRVEE' + strTabPre).AsFloat, FieldByName('LOT_PREVE' + strTabPre).AsFloat)
    Else
    Begin
      If (RoundTo(fltQtdIte, -FDecQtd) > 0) And
         (RoundTo(fltQtdIte, -FDecQtd) = RoundTo(FieldByName('LOT_SALDOS').AsFloat, -FDecQtd)) Then
        Result := IIF(fRetornaPrecoLoteDestinoEntrega, FieldByName('LOT_VETOE' + strTabPre).AsFloat, FieldByName('LOT_VENTO' + strTabPre).AsFloat)
      Else
        Result := IIF(fRetornaPrecoLoteDestinoEntrega, FieldByName('LOT_PRVEE' + strTabPre).AsFloat,FieldByName('LOT_PREVE' + strTabPre).AsFloat);
    End;
  End;
End;

function TCadLot.fAtivarLote(strAutInc: String; blnRemessaDevolucao: Boolean = False): Boolean;
var
  qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery;

  Try
    With qryUpd, SQL Do
    Begin
      Add('  UPDATE                      ');
      Add('    CADLOT                    ');
      Add('  SET                         ');

      If blnRemessaDevolucao Then
        Add('    LOT_STATUS = "B"          ')
      Else
        Add('    LOT_STATUS = "S"          ');

      Add('  WHERE                       ');
      Add('    AUTOINCREM = :AUTINC AND  ');
      Add('    LOT_CODEMP = :CODEMP      ');

      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
    End;

    Try

      qryUpd.ExecSQL;

      Result := True;
    Except
      Result := False;
    End;

  Finally
    FreeAndNil(qryUpd);
  End;
end;

Function TCadLot.fRetPrecoCustoLote(fltQtdIte: Double): Double;
Begin
  With qryCadLot Do
  Begin
    If fItemLoteChapa(FieldByName('LOT_CODITE').asString, FOpcDoc) then
      Result :=  FieldByName('LOT_PRECUS').AsFloat
    Else
    Begin
      If (RoundTo(fltQtdIte, -FDecQtd) > 0) And
         (RoundTo(fltQtdIte, -FDecQtd) = RoundTo(FieldByName('LOT_SALDOS').AsFloat, -FDecQtd)) Then
        Result :=  FieldByName('LOT_CUSTOT').AsFloat
      Else
        Result :=  FieldByName('LOT_PRECUS').AsFloat;
    End;
  End;
End;

Function TCadLot.fExisteLotePrincipalVenda(strCodIte: String; strCodEmp: String): Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  qryLotAux := fCriaQuery;
  With qryLotAux, SQL Do
  Begin
    Add(' SELECT *                    ');
    Add('   FROM CADLOT               ');
    Add('  WHERE LOT_CODITE = :CODITE ');
    Add('    AND LOT_ARMPRI = "S"     ');
    Add('    AND LOT_CODEMP = :CODEMP ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    Result := Not IsEmpty;
    Close;
  End;

  FreeAndNil(qryLotAux);
End;

Function TCadLot.fExisteLotePrincipalCompra(strCodIte: String; strCodEmp: String = ''): String;
  Var
    qryLotAux: TUniQuery;
Begin
  Result := '';
  qryLotAux := fCriaQuery;
  Try
    qryLotAux.Sql.Add('SELECT LOT_NUMLOT FROM CADLOT        ');
    qryLotAux.Sql.Add('WHERE                       ');
    qryLotAux.Sql.Add('  LOT_CODITE  = :CODITE AND ');
    qryLotAux.Sql.Add('  LOT_ARMPRC  = "S"   ');
    If (Not fEmptyStr(strCodEmp)) Then
      qryLotAux.Sql.Add(' AND LOT_CODEMP  = :CODEMP   ');

    qryLotAux.ParamByName('CODITE').AsString := strCodIte;

    If (Not fEmptyStr(strCodEmp)) Then
      qryLotAux.ParamByName('CODEMP').AsString := strCodEmp;

    qryLotAux.Open;

    If (Not qryLotAux.IsEmpty) Then
      Result := qryLotAux.FieldByName('LOT_NUMLOT').AsString;

    qryLotAux.Close;

  Finally
    FreeAndNil(qryLotAux);
  End;
End;

Function TCadLot.fExisteLotePrincipalAluguelEquipamento(strCodIte: String; strCodEmp: String): Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  qryLotAux := fCriaQuery;
  With qryLotAux, SQL Do
  Begin
    Add('SELECT * FROM CADLOT        ');
    Add('WHERE                       ');
    Add('  LOT_CODITE  = :CODITE AND ');
    Add('  LOT_EQPPRI  = "S"         ');

    If Not fEmptyStr(strCodEmp) Then
      Add('  AND LOT_CODEMP  = :CODEMP ');

    ParamByName('CODITE').AsString := strCodIte;

    If Not fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    Result := Not IsEmpty;
    Close;
  End;

  FreeAndNil(qryLotAux);

end;

function TCadLot.fExisteLotePrincipalGarantia(strCodIte: String; strCodEmp: String): Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  qryLotAux := fCriaQuery;
  With qryLotAux, SQL Do
  Begin
    Add('SELECT * FROM CADLOT        ');
    Add('WHERE                       ');
    Add('  LOT_CODITE  = :CODITE AND ');
    Add('  LOT_GARPRI  = "S"         ');

    If Not fEmptyStr(strCodEmp) Then
      Add('  AND LOT_CODEMP  = :CODEMP ');

    ParamByName('CODITE').AsString := strCodIte;

    If Not fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    Result := Not IsEmpty;
    Close;
  End;

  FreeAndNil(qryLotAux);

end;

Function TCadLot.fExisteLotePrincipalOrdemProducao(strCodIte: String; strCodEmp: String): Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  qryLotAux := fCriaQuery;
  With qryLotAux, SQL Do
  Begin
    Add('SELECT * FROM CADLOT        ');
    Add('WHERE                       ');
    Add('  LOT_CODITE  = :CODITE AND ');
    Add('  LOT_CODEMP  = :CODEMP AND ');
    Add('  LOT_PRIPRO  = "S"         ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    Result := Not IsEmpty;
    Close;
  End;

  FreeAndNil(qryLotAux);

end;

function TCadLot.fExisteAlgumLotePrincipalTintaMaquina: Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  Result := False;

  qryLotAux := fCriaQuery;
  Try
    qryLotAux.SQL.Text := 'SELECT AUTOINCREM FROM CADLOT WHERE LOT_PRITIN = "S" LIMIT 1';
    qryLotAux.Open;
    If (Not qryLotAux.IsEmpty) Then
      Result := (Not fEmptyStr(qryLotAux.FieldByName('AUTOINCREM').AsString));
    qryLotAux.Close;
  Finally
    FreeAndNil(qryLotAux);
  End;
end;

function TCadLot.fExisteLotePrincipalTintaMaquina(strCodIte: String; strCodEmp: String): Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  If (FTemLotePrincipalDeTinta = '') Then
  Begin
    If fExisteAlgumLotePrincipalTintaMaquina Then
      FTemLotePrincipalDeTinta := 'S'
    Else
      FTemLotePrincipalDeTinta := 'N';
  End;

  If (FTemLotePrincipalDeTinta = 'N') Then
  Begin
    Result := False;
    Exit;
  End;

  qryLotAux := fCriaQuery;
  Try
    qryLotAux.SQL.Add(' SELECT COUNT(0) AS CNT ');
    qryLotAux.SQL.Add('   FROM CADLOT        ');
    qryLotAux.SQL.Add('  WHERE LOT_CODITE = :CODITE ');
    qryLotAux.SQL.Add('    AND LOT_CODEMP = :CODEMP ');
    qryLotAux.SQL.Add('    AND LOT_PRITIN = "S"   ');
    qryLotAux.ParamByName('CODITE').AsString := strCodIte;
    qryLotAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryLotAux.Open;
    Result := (qryLotAux.FieldByName('CNT').AsInteger > 0);
    qryLotAux.Close;
  Finally
    FreeAndNil(qryLotAux);
  End;
end;

function TCadLot.fExisteLotePrincipalProducao(strCodIte, strCodEmp: String): Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  qryLotAux := Nil;
  Try
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('SELECT * FROM CADLOT        ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_PRIPRO  = "S" AND     ');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;

      Open;
      Result := Not IsEmpty;
      Close;
    End;

  Finally
    FreeAndNil(qryLotAux);
  End;
end;

function TCadLot.fExisteLotePrincipalProducaoIndustrial(strCodIte, strCodEmp: String): Boolean;
Var
  qryLotAux: TUniQuery;
Begin
  qryLotAux := Nil;
  Try
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('SELECT * FROM CADLOT        ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_PRIIND  = "S" AND     ');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;

      Open;
      Result := Not IsEmpty;
      Close;
    End;
  Finally
    FreeAndNil(qryLotAux);
  End;

end;

Function TCadLot.fExisteLotePrincipalConsertoEquipamento(const strCodIte: String; const strCodEmp: String): Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  qryLotAux := fCriaQuery;
  Try
    qryLotAux.SQL.Add(' SELECT * FROM CADLOT ');
    qryLotAux.SQL.Add('  WHERE LOT_CODITE  = :CODITE ');
    qryLotAux.SQL.Add('    AND LOT_CODEMP  = :CODEMP ');
    qryLotAux.SQL.Add('    AND LOT_ARMPCE  = "S" ');
    qryLotAux.ParamByName('CODITE').AsString := strCodIte;
    qryLotAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryLotAux.Open;
    Result := Not qryLotAux.IsEmpty;
    qryLotAux.Close;
  Finally
    FreeAndNil(qryLotAux);
  End;
End;

Procedure TCadLot.pAjustaArmPrincipalVenda(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  If qryCadLot.FieldByName('LOT_ARMPRI').AsString = 'S' Then
  Begin
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_ARMPRI = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT AND ');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;
    End;

    FreeAndNil(qryLotAux);
  End

  Else If (Not SameText(qryCadLot.FieldByName('LOT_NUMLOT').AsString, 'A DEFINIR')) And
          (Not fExisteLotePrincipalVenda(qryCadLot.FieldByName('LOT_CODITE').AsString, Vs_strCodEmp)) Then
  Begin
    qryCadLot.Edit;
    qryCadLot.FieldByName('LOT_ARMPRI').AsString := 'S';
    qryCadLot.Post;
  End;
End;

Procedure TCadLot.pAjustaArmPrincipalCompra(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  If qryCadLot.FieldByName('LOT_ARMPRC').AsString = 'S' Then
  Begin
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_ARMPRC = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT AND ');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;
    End;

    FreeAndNil(qryLotAux);
  End

  Else If (Not fUsaRotinaWMS) And
          (Not SameText(qryCadLot.FieldByName('LOT_NUMLOT').AsString, 'A DEFINIR')) And
          (fEmptyStr(fExisteLotePrincipalCompra(qryCadLot.FieldByName('LOT_CODITE').AsString))) Then
  Begin
    qryCadLot.Edit;
    qryCadLot.FieldByName('LOT_ARMPRC').AsString := 'S';
    qryCadLot.Post;
  End;
End;


procedure TCadLot.pAjustaArmPrincipalAluguelDeEquipamentos(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  If qryCadLot.FieldByName('LOT_EQPPRI').AsString = 'S' Then
  Begin
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_EQPPRI = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT AND ');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;
    End;

    FreeAndNil(qryLotAux);
  End

  Else If (Not SameText(qryCadLot.FieldByName('LOT_NUMLOT').AsString, 'A DEFINIR')) And
          (Not fExisteLotePrincipalAluguelEquipamento(qryCadLot.FieldByName('LOT_CODITE').AsString, Vs_strCodEmp)) Then
  Begin
    qryCadLot.Edit;
    qryCadLot.FieldByName('LOT_EQPPRI').AsString := 'S';
    qryCadLot.Post;
  End;

End;

procedure TCadLot.pAjustaArmPrincipalGarantia(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  if fUsaRotinaWMS and fCfgSis('GARANT', varBoolean) Then
  Begin
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_GARPRI = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT AND ');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := 'GARANTIA';
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;
      Close;
      Clear;
      Add('UPDATE CADLOT              ');
      Add('  SET LOT_GARPRI = "S"     ');
      Add('WHERE                      ');
      Add('  LOT_CODITE = :CODITE AND ');
      Add('  LOT_NUMLOT = :NUMLOT AND ');
      Add('  LOT_CODEMP = :CODEMP     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := 'GARANTIA';
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;
    End;

    FreeAndNil(qryLotAux);
  End
  Else
  If qryCadLot.FieldByName('LOT_GARPRI').AsString = 'S' Then
  Begin
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_GARPRI = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT AND ');
      Add('  LOT_NUMLOT <> "GARANTIA" AND');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;
    End;

    FreeAndNil(qryLotAux);
  End;


  If (Not SameText(qryCadLot.FieldByName('LOT_NUMLOT').AsString, 'A DEFINIR')) Then
  Begin
    If Not fExisteLotePrincipalGarantia(qryCadLot.FieldByName('LOT_CODITE').AsString, Vs_strCodEmp) Then
      If Not fUsaRotinaWMS then
        If fCfgSis('GARANT', varBoolean) then
          pGerarLoteGarantia(qryCadLot.FieldByName('LOT_CODITE').AsString, Vs_strCodEmp);
  End;

end;

procedure TCadLot.pAjustaLotePrincipalTintaMaquina(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  If qryCadLot.FieldByName('LOT_PRITIN').AsString = 'S' Then
  Begin
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_PRITIN = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_CODEMP  = :CODEMP AND ');
      Add('  LOT_NUMLOT <> :NUMLOT     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('CODEMP').AsString := qryCadLot.FieldByName('LOT_CODEMP').AsString;
      ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;

      ExecSQL;
    End;

    FreeAndNil(qryLotAux);
  End;

end;

procedure TCadLot.pAjustaArmPrincipalProducao(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  If qryCadLot.FieldByName('LOT_PRIPRO').AsString = 'S' Then
  Begin
    qryLotAux := Nil;
    Try
      qryLotAux := fCriaQuery;
      With qryLotAux, SQL Do
      Begin
        Add('UPDATE CADLOT               ');
        Add('  SET LOT_PRIPRO = "N"      ');
        Add('WHERE                       ');
        Add('  LOT_CODITE  = :CODITE AND ');
        Add('  LOT_NUMLOT <> :NUMLOT AND ');
        Add('  LOT_CODEMP  = :CODEMP     ');

        ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
        ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
        ParamByName('CODEMP').AsString := qryCadLot.FieldByName('LOT_CODEMP').AsString;

        ExecSQL;
      End;
    Finally
      FreeAndNil(qryLotAux);
    End;
  End

  Else If (Not SameText(qryCadLot.FieldByName('LOT_NUMLOT').AsString, 'A DEFINIR')) And
          (Not fExisteLotePrincipalProducao(qryCadLot.FieldByName('LOT_CODITE').AsString, qryCadLot.FieldByName('LOT_CODEMP').AsString)) Then
  Begin
    qryCadLot.Edit;
    qryCadLot.FieldByName('LOT_PRIPRO').AsString := 'S';
    qryCadLot.Post;
  End;

end;

procedure TCadLot.pAjustaArmPrincipalProducaoIndustrial(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  If qryCadLot.FieldByName('LOT_PRIIND').AsString = 'S' Then
  Begin
    qryLotAux := Nil;
    Try
      qryLotAux := fCriaQuery;
      With qryLotAux, SQL Do
      Begin
        Add('UPDATE CADLOT               ');
        Add('  SET LOT_PRIIND = "N"      ');
        Add('WHERE                       ');
        Add('  LOT_CODITE  = :CODITE AND ');
        Add('  LOT_NUMLOT <> :NUMLOT AND ');
        Add('  LOT_CODEMP  = :CODEMP     ');

        ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
        ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
        ParamByName('CODEMP').AsString := qryCadLot.FieldByName('LOT_CODEMP').AsString;

        ExecSQL;
      End;
    Finally
      FreeAndNil(qryLotAux);
    End;
  End

  Else If (Not SameText(qryCadLot.FieldByName('LOT_NUMLOT').AsString, 'A DEFINIR')) And
          (Not fExisteLotePrincipalProducaoIndustrial(qryCadLot.FieldByName('LOT_CODITE').AsString, qryCadLot.FieldByName('LOT_CODEMP').AsString)) Then
  Begin
    qryCadLot.Edit;
    qryCadLot.FieldByName('LOT_PRIIND').AsString := 'S';
    qryCadLot.Post;
  End;

end;


function TCadLot.fTemLocalizacaoFisicaComLotePicking(strLocFis, strCodEmp, strCodIte: String; blnConsiderarLocFis: Boolean; out strAutIncLoteComPicking: String): Boolean;
Var
  qryCadLot: TUniQuery;
begin
  qryCadLot := fCriaQuery;

  Try
    qryCadLot.Close;
     qryCadLot.Sql.Clear;
    qryCadLot.Sql.Add(' SELECT CADLOT.AUTOINCREM                     ');
    qryCadLot.Sql.Add(' FROM CADLOT                                  ');
    qryCadLot.Sql.Add(' INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS ');
    qryCadLot.Sql.Add('                  AND LOC_CODEMP = LOT_CODEMP ');
    qryCadLot.Sql.Add(' WHERE LOC_PICKIN = "S"                       ');
    qryCadLot.Sql.Add('   AND LOT_CODEMP = :CODEMP                   ');
    If blnConsiderarLocFis Then
      qryCadLot.Sql.Add('   AND LOT_LOCFIS = :LOCFIS                   ');
    qryCadLot.Sql.Add('   AND LOT_STATUS = "S"                       ');
    qryCadLot.Sql.Add('   AND LOT_CODITE = :CODITE                   ');

    qryCadLot.Parambyname('CODEMP').AsString := strCodEmp;
    If blnConsiderarLocFis Then
      qryCadLot.Parambyname('LOCFIS').AsString := strLocFis;
    qryCadLot.Parambyname('CODITE').AsString := strCodIte;

    qryCadLot.Open;

    Result := Not fEmptyStr(qryCadLot.FieldByName('AUTOINCREM').AsString);

    If Result Then
      strAutIncLoteComPicking := qryCadLot.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(qryCadLot);
  End;
end;

function TCadLot.fPodeGravarLote(
  const AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual;
  const AstrCodEmp: String): Boolean;
begin
  Result := True ;
  if not Assigned(AdictLocalizacaoFisicaEmpresa) then
    Exit ;

  if not fCfgSis('UTIWMS', VarBoolean) then
    Exit ;

  if fEmptyStr(AdictLocalizacaoFisicaEmpresa.Items[AstrCodEmp]) then
    Exit(False) ;

end;

function TCadLot.fTemLocFisicaComArmazem(strCodAmz: String;
  var strLocFis: String): Boolean;
begin
  strLocFis := fCampoTabela('GROUP_CONCAT(LOC_CODLOC)', 'CADLOC', ['LOC_CODAMZ'], [strCodAmz]);
  Result    := Not fEmptyStr(strLocFis);
end;

Function TCadLot.fTemLoteComLocFisica(strLocFis: String;
                                      Var strIteEnt,
                                          strLotEnt: String;
                                      Var fltSaldos,
                                          fltSal_ML: Double;
                                      strCodIte: String = '';
                                      strNumLot: String = ''): Boolean;
  Var
    qryCadLot: TUniQuery;
Begin
  qryCadLot := fCriaQuery;

  With qryCadLot, SQL Do
  Begin
    Clear;
    Add('SELECT LOT_CODITE, LOT_NUMLOT, LOT_SALDOS, LOT_SAL_ML FROM CADLOT');
    Add('WHERE ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_LOCFIS = :LOCFIS     ');

    If Not fEmptyStr(strCodIte) Then
    Begin
      Add(' AND NOT (LOT_CODITE = :CODITE AND ');
      Add('          LOT_NUMLOT = :NUMLOT)    ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strNumLot;
    End;

    ParamByName('LOCFIS').AsString := strLocFis;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
    Result := Not IsEmpty;

    If Result Then
    Begin
      strIteEnt := FieldByName('LOT_CODITE').AsString;
      strLotEnt := FieldByName('LOT_NUMLOT').AsString;
      fltSaldos := FieldByName('LOT_SALDOS').AsFloat;
      fltSal_ML := FieldByName('LOT_SAL_ML').AsFloat;
    End Else
    Begin
      strIteEnt := '';
      strLotEnt := '';
      fltSaldos := 0;
      fltSal_ML := 0;
    End;

    Close;
  End;
  FreeAndNil(qryCadLot);
End;

Function TCadLot.fTemLoteComLocFisica(strLocFis: String; Var strCodIte: String; blnCadLoc: Boolean = False): Boolean;
  Var
    qryCadLot: TUniQuery;
Begin
  qryCadLot := fCriaQuery;

  With qryCadLot, SQL Do
  Begin
    Clear;

    Add('SELECT TRIM(GROUP_CONCAT(DISTINCT LOT_CODITE SEPARATOR ", ")) AS CODITE FROM CADLOT');
    Add('WHERE ');

    If blnCadLoc Then
      Add('  LOT_SALDOS <> 0    AND ');

    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_LOCFIS = :LOCFIS     ');

    ParamByName('LOCFIS').AsString := strLocFis;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    strCodIte := FieldByName('CODITE').AsString;

    Result := strCodIte <> '';

    Close;
  End;
  FreeAndNil(qryCadLot);
End;


function TCadLot.fLocalizacaoTemConfiguracaoVinculada(strCodLoc: String;
  var strCodigo, strDescricao, strEmpresa: String): Boolean;
var
  qryCadLoc: TUniQuery;
begin
  qryCadLoc := fCriaQuery;

  try
    Result := False;

    qryCadLoc.Close;
    qryCadLoc.SQL.Clear;
    qryCadLoc.SQL.Add('SELECT SIS_CODCFG, SIS_DESCRI, SIS_CODEMP FROM CFGSIS');
    qryCadLoc.SQL.Add('WHERE SIS_CODCFG IN("CFG_RDDLFL", "CFG_RDLFLT", "CFG_LFLOSF", "CFG_LFLGDC")');
    qryCadLoc.SQL.Add('AND SIS_VALCFG = :CODLOC');
    qryCadLoc.ParamByName('CODLOC').AsString := strCodLoc;
    qryCadLoc.Open;

    if qryCadLoc.IsEmpty then
      Exit;

    strCodigo := qryCadLoc.FieldByName('SIS_CODCFG').AsString;
    strDescricao := qryCadLoc.FieldByName('SIS_DESCRI').AsString;
    strEmpresa := qryCadLoc.FieldByName('SIS_CODEMP').AsString;

    Result := True;
  finally
    FreeAndNil(qryCadLoc);
  end;
end;

Function TCadLot.fLocalizacaoTemSeparacaoEmAberto(strLocFis: String): Boolean;
  Var
    qryCadLot: TUniQuery;
Begin
  qryCadLot := fCriaQuery;
  try
    qryCadLot.SQL.Clear;

    qryCadLot.SQL.Add('SELECT                                                       ');
    qryCadLot.SQL.Add('  COUNT(*) AS QTD                                            ');
    qryCadLot.SQL.Add('FROM                                                         ');
    qryCadLot.SQL.Add('  CADLOC                                                     ');
    qryCadLot.SQL.Add('INNER JOIN CADLOT ON     LOT_LOCFIS = LOC_CODLOC             ');
    qryCadLot.SQL.Add('                     AND LOT_CODEMP = LOC_CODEMP             ');
    qryCadLot.SQL.Add('INNER JOIN ( SELECT                                          ');
    qryCadLot.SQL.Add('	       FDO_CODITE,                                          ');
    qryCadLot.SQL.Add('	       FDO_CODEMP,                                          ');
    qryCadLot.SQL.Add('	       LDO_NUMLOT                                           ');
    qryCadLot.SQL.Add('	     FROM                                                   ');
    qryCadLot.SQL.Add('	       LOTDOR                                               ');
    qryCadLot.SQL.Add('	       INNER JOIN FATDOR ON FATDOR.AUTOINCREM = LDO_SEQFDO  ');
    qryCadLot.SQL.Add('	   ) SEP ON     FDO_CODITE = LOT_CODITE                     ');
    qryCadLot.SQL.Add('		    AND FDO_CODEMP = LOT_CODEMP                           ');
    qryCadLot.SQL.Add('		    AND LDO_NUMLOT = LOT_NUMLOT                           ');
    qryCadLot.SQL.Add('WHERE                                                        ');
    qryCadLot.SQL.Add('      LOC_CODEMP = :CODEMP                                   ');
    qryCadLot.SQL.Add('  AND LOT_LOCFIS = :LOCFIS                                   ');

    qryCadLot.ParamByName('LOCFIS').AsString := strLocFis;
    qryCadLot.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryCadLot.Open;

    Result := qryCadLot.FieldByName('QTD').AsInteger > 0;

    qryCadLot.Close;
  finally
   FreeAndNil(qryCadLot);
  End;
End;

Function TCadLot.fTemProdutoComLocFisica(    strLocFis: String;
                                         Var strIteEnt: String;
                                         Var fltSaldos,
                                             fltSal_ML: Double;
                                             strCodIte: String = '';
                                             blnSupEst: Boolean = False): Boolean;
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery;
  With qryIteger, SQL Do
  Begin
    Clear;
    Add('SELECT ITE_CODITE, ITE_SALDOS, ITE_SAL_ML FROM ITEGER');
    Add('WHERE');
    Add(' ITE_CODEMP = :CODEMP AND ');

    Case blnSupEst Of
      False: Add(' ITE_LOCFIS = :LOCFIS');
      True: Add(' ITE_LOCSUP = :LOCFIS');
    End;

    If Not fEmptyStr(strCodIte) Then
    Begin
      Add(' AND ITE_CODITE <> :CODITE');

      ParamByName('CODITE').AsString := strCodIte;
    End;

    Add('ORDER BY ITE_SALDOS DESC LIMIT 1');

    ParamByName('LOCFIS').AsString := strLocFis;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
    Result := Not IsEmpty;

    If Result Then
    Begin
      strIteEnt := FieldByName('ITE_CODITE').AsString;
      fltSaldos := FieldByName('ITE_SALDOS').AsFloat;
      fltSal_ML := FieldByName('ITE_SAL_ML').AsFloat;
    End Else
    Begin
      fltSaldos := 0;
      fltSal_ML := 0;
      strIteEnt := '';
    End;

    Close;
  End;
  FreeAndNil(qryIteger);
End;

Function TCadLot.fTemProdutoComLocAdicional(    strLocFis: String;
                                            Var strIteEnt: String;
                                            Var fltSaldos,
                                                fltSal_ML:Double;
                                                strCodIte: String = ''): Boolean;
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery;
  With qryIteger, SQL Do
  Begin
    Clear;
    Add('SELECT ITE_CODITE, ITE_SALDOS, ITE_SAL_ML FROM ITEGER');
    Add('INNER JOIN LOCFIS ON LOC_CODITE = ITE_CODITE AND LOC_CODEMP = ITE_CODEMP ');
    Add('WHERE');
    Add(' ITE_CODEMP = :CODEMP AND ');
    Add(' LOC_LOCFIS = :LOCFIS');

    If Not fEmptyStr(strCodIte) Then
    Begin
      Add(' AND ITE_CODITE <> :CODITE');

      ParamByName('CODITE').AsString := strCodIte;
    End;

    Add('ORDER BY ITE_SALDOS DESC LIMIT 1');

    ParamByName('LOCFIS').AsString := strLocFis;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
    Result := Not IsEmpty;

    If Result Then
    Begin
      strIteEnt := FieldByName('ITE_CODITE').AsString;
      fltSaldos := FieldByName('ITE_SALDOS').AsFloat;
      fltSal_ML := FieldByName('ITE_SAL_ML').AsFloat;
    End Else
    Begin
      fltSaldos := 0;
      fltSal_ML := 0;
      strIteEnt := '';
    End;

    Close;
  End;
  FreeAndNil(qryIteger);
End;

function TCadLot.fRetArmazemPrincipalVenda(strCodIte: String; strCodEmp : String = ''): String;
  Var
    qryNumLot: TUniQuery;
Begin
  Result := '';

  qryNumLot := fCriaQuery;
  With qryNumLot, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  LOT_NUMLOT');
    Add('FROM');
    Add('  CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_ARMPRI = "S"');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);

    Open;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString;

    Close;
  End;

  FreeAndNil(qryNumLot);
End;

function TCadLot.fRetArmazemPrincipalCompra(strCodIte: String): String;
  Var
    qryNumLot: TUniQuery;
Begin
  Result := '';

  If (FTipLot <> tplArmazem) And (Not fUsaRotinaWMS) Then
    Exit;

  qryNumLot := fCriaQuery;
  With qryNumLot, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  LOT_NUMLOT');
    Add('FROM');
    Add('  CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_ARMPRC = "S"');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString;

    Close;
  End;

  FreeAndNil(qryNumLot);
End;

function TCadLot.fRetLotePrincipalTintaMaquina(strCodIte, strCodEmp: String): String;
  Var
    qryNumLot: TUniQuery;
Begin
  Result := '';

  qryNumLot := fCriaQuery;
  With qryNumLot, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  LOT_NUMLOT');
    Add('FROM');
    Add('  CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_PRITIN = "S"');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString;

    Close;
  End;

  FreeAndNil(qryNumLot);

end;


function TCadLot.fValidaLocalizacaoItemUnica(strCodIte, strCodLoc, strAutoincrem: String; dtaColVal : TDateTime = 0): boolean;
  Var
    qryAux: TUniQuery;
Begin

  qryAux := fCriaQuery;
  try

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                       ');
    qryAux.SQL.Add('  COUNT(*) AS QTD            ');
    qryAux.SQL.Add('FROM                         ');
    qryAux.SQL.Add('  CADLOT                     ');
    qryAux.SQL.Add('WHERE                        ');
    qryAux.SQL.Add('      LOT_CODITE = :CODITE   ');
    qryAux.SQL.Add('  AND LOT_CODEMP = :CODEMP   ');
    qryAux.SQL.Add('  AND LOT_LOCFIS = :LOCFIS   ');
    qryAux.SQL.Add('  AND AUTOINCREM <> :AUTINC  ');

    If FColVal then
      qryAux.SQL.Add('  AND LOT_DTAVAL = :COLVAL ');

    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ParamByName('LOCFIS').AsString := strCodLoc;
    qryAux.ParamByName('AUTINC').AsString := strAutoincrem;

    If FColVal then
      qryAux.ParamByName('COLVAL').AsDateTime := dtaColVal;

    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsInteger = 0;

    qryAux.Close;
  finally
    FreeAndNil(qryAux);
  end;

end;

class function TCadLot.ValidaLoteEstoqueExterno(const ACodIte, ACodExt: String; var AMsgErr: String; AValidarSomenteSeLotSalExtCadastradoHoje: Boolean=False): Boolean;
Var
  LNumLot: String;
  LTitLot: String;
begin

  Result := False;

  LTitLot := IIF(fCfgSis('CTLEST') = '1', 'lote', 'armazém');

  If Not ExisteLoteEstoqueExterno(ACodIte, ACodExt, LNumLot) Then
  Begin
    AMsgErr := Format('Não existe %s vinculado ao estoque externo "%s" para o produto "%s".', [LTitLot, ACodExt, ACodIte]);
    Exit;
  End;

  Result := True;

end;

function TCadLot.fRetArmazemPrincipalLocacaoDeEquipamento(strCodIte: String): String;
  Var
    qryNumLot: TUniQuery;
Begin
  Result := '';

  qryNumLot := fCriaQuery;
  With qryNumLot, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  LOT_NUMLOT');
    Add('FROM');
    Add('  CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_EQPPRI = "S"');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString;

    Close;
  End;

  FreeAndNil(qryNumLot);

end;

function TCadLot.fRetArmazemPrincipalGarantia(strCodIte: String): String;
  Var
    qryNumLot: TUniQuery;
Begin
  Result := '';

  qryNumLot := fCriaQuery;
  With qryNumLot, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  LOT_NUMLOT');
    Add('FROM');
    Add('  CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_GARPRI = "S"');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString;

    Close;
  End;

  FreeAndNil(qryNumLot);

end;

function TCadLot.fEhPrincipalGarantia(strCodIte: String; strNumLot : String): Boolean;
  Var
    qryCadLot: TUniQuery;
Begin
  Result := False;

  qryCadLot := fCriaQuery;
  try
    qryCadLot.SQL.Clear;
    qryCadLot.SQL.Add('SELECT                              ');
    qryCadLot.SQL.Add('  IFNULL(LOT_GARPRI, "N") AS GARPRI ');
    qryCadLot.SQL.Add('FROM                                ');
    qryCadLot.SQL.Add('  CADLOT                            ');
    qryCadLot.SQL.Add('WHERE LOT_CODITE = :CODITE          ');
    qryCadLot.SQL.Add('  AND LOT_CODEMP = :CODEMP          ');
    qryCadLot.SQL.Add('  AND LOT_NUMLOT = :NUMLOT          ');

    qryCadLot.ParamByName('CODITE').AsString := strCodIte;
    qryCadLot.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadLot.ParamByName('NUMLOT').AsString := strNumLot;

    qryCadLot.Open;

    If Not qryCadLot.IsEmpty Then
      Result := qryCadLot.FieldByName('GARPRI').AsString = 'S';

    qryCadLot.Close;

  finally
    FreeAndNil(qryCadLot);
  end;

end;


function TCadLot.fAtualizaLocFisica(strCodAmzAnt, strCodAmzAtu, strCodLoc: String): Boolean;
  Var
    qryCadUpd: TUniQuery;
Begin

  Try
    qryCadUpd := fCriaQuery(Self);

    With qryCadUpd, SQL Do
    Begin
      Clear;
      Add('UPDATE CADLOT');
      Add('SET');
      Add('  LOT_NUMLOT = :AMZATU');
      Add('WHERE');
      Add('  LOT_NUMLOT = :AMZANT AND ');
      Add('  LOT_LOCFIS = :LOCFIS AND ');
      Add('  LOT_CODEMP = :CODEMP     ');

      ParamByName('AMZATU').AsString := strCodAmzAtu;
      ParamByName('AMZANT').AsString := strCodAmzAnt;
      ParamByName('LOCFIS').AsString := strCodLoc;
      ParamByName('CODEMP').AsString := strCodLoc;

      ExecSQL;
    End;

    Result := True;

    FreeAndNil(qryCadUpd);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadLot.fAtualizaLocFisica]');
    End;

  End;

End;

function TCadLot.fAtualizaLocFisicaLotes(strCodLocAnt, strCodLocAtu, strCodEmp : String): Boolean;
  Var
    qryCadUpd: TUniQuery;
Begin
  try
    Try
      qryCadUpd := fCriaQuery(Self);

      With qryCadUpd, SQL Do
      Begin
        Clear;
        Add('UPDATE CADLOT                 ');
        Add('SET                           ');
        Add('  LOT_LOCFIS = :LOCFISATU     ');
        Add('WHERE                         ');
        Add('  LOT_LOCFIS = :LOCFISANT AND ');
        Add('  LOT_CODEMP = :CODEMP        ');

        ParamByName('LOCFISATU').AsString := strCodLocAtu;
        ParamByName('LOCFISANT').AsString := strCodLocAnt;
        ParamByName('CODEMP').AsString := strCodEmp;

        ExecSQL;
      End;

      Result := True;

    Except

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadLot.fAtualizaLocFisica]');
      End;

    End;
  finally
    FreeAndNil(qryCadUpd);
  end;
End;

function TCadLot.fAtualizaLoteMovDet(strTabela, strAutInc,
  strNumLot: String): Boolean;
  Var
    qryUpdDet : TUniQuery;
begin
  qryUpdDet := fCriaQuery(Self);

  Try
    With qryUpdDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add( fSQLUpdateMovDet(strTabela) );
      ParamByName('NUMLOT').AsString := strNumLot;
      ParamByName('AUTINC').AsString := strAutInc;
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadLot.fAtualizaLoteMovDet]');
    End;
  End;
  
  FreeAndNil(qryUpdDet);
end;

function TCadLot.fTemMovimentacaoLocFisica(strCodAmz, strLocFis: String): Boolean;

  Var
    qryMovDet: TUniQuery;
    qryItens : TUniQuery;

  Function fSQLMovdet(strTabela: String): String;
  Begin
    Result := ' /* untCadLot.fTemMovimentacaoLocFisica */ ';
    Result := Result + ' SELECT SQL_NO_CACHE  DET_NUMDOC ';
    Result := Result + ' FROM ' + strTabela;
    Result := Result + ' WHERE ';
    Result := Result + '   DET_CODITE = :CODITE AND  ';
    Result := Result + '   DET_NUMLOT = :NUMLOT      ';
    Result := Result + ' LIMIT 1                     ';
  End;

  Function fTemMovimento(strTabela: String): Boolean;
  Begin
    With qryMovDet Do
    Begin
      Close;

      SQL.Text := fSQLMovdet(strTabela);

      ParamByName('NUMLOT').AsString := strCodAmz;
      ParamByName('CODITE').AsString := qryItens.FieldByName('LOT_CODITE').AsString;

      Open;

      Result := Not IsEmpty;
    End;
  End;

Begin
  Result := False;
  
  qryMovDet := fCriaQuery(Self);
  qryItens  := fCriaQuery(Self);

  With qryItens, SQL Do
  Begin
    Clear;
    Add('/* untCadLot.fTemMovimentacaoLocFisica */');
    Add('SELECT DISTINCT LOT_CODITE FROM CADLOT');
    Add('WHERE');
    Add('  LOT_NUMLOT = :CODAMZ AND ');
    Add('  LOT_LOCFIS = :LOCFIS     ');

    ParamByName('CODAMZ').AsString := strCodAmz;
    ParamByName('LOCFIS').AsString := strLocFis;

    Open;
  End;

  While Not qryItens.Eof Do
  Begin

    If fTemMovimento('MOVDET') Then
    Begin
      Result := True;
      Break;
    End;

    If fTemMovimento('NOTDET') Then
    Begin
      Result := True;
      Break;
    End;

    qryItens.Next;
  End;

  FreeAndNil(qryMovDet);
  FreeAndNil(qryItens);
End;

Function TCadLot.fSQLMovimentos(strTabela: String): String;

  Function fRetSQLDocEnd: String;
  Begin
    Result := '';
    IF fCfgSis('SPCDEN', varBoolean) THEN
    Begin
      Result := Result + ' AND FGO_DCENUM IS NOT NULL ';
      Result := Result + ' AND FGO_DCENUM = '+ strTabela +'.DET_NUMDOC  ';
      Result := Result + ' AND FGO_DCEESP = '+ strTabela +'.DET_ESPDOC  ';
      Result := Result + ' AND FGO_DCESER = '+ strTabela +'.DET_SERIE_  ';
      Result := Result + ' AND FGO_DCEEMP = '+ strTabela +'.DET_CODEMP  ';
      Result := Result + ' AND FGO_DCEFOR = '+ strTabela +'.DET_CODFOR  ';
      Result := Result + ' AND FGO_DCETFC = '+ strTabela +'.DET_TIP_FC  ';
    End
    Else
    Begin
      Result := ' AND FGO_DOCEND = CONCAT(';
      Result := Result + '                  DET_NUMDOC, ';
      Result := Result + '                  DET_ESPDOC, ';
      Result := Result + '                  LEFT(CONCAT(IFNULL(DET_SERIE_, ""), "   "), 3), ';
      Result := Result + '                  DET_CODEMP, ';
      Result := Result + '                  IFNULL(DET_CODFOR, DET_CODCLI),  ';
      Result := Result + '                  IF(DET_CODFOR IS NULL, "C", "F") ';
      Result := Result + '                )';
    End;
  End;

Begin
  Result := '';
  Result := Result + ' SELECT IFNULL(CADITE.ITE_REAEND, "N") AS ITE_REAEND,                    ';
  Result := Result +   strTabela +'.AUTOINCREM AS AUTOINCREM,                                  ';
  Result := Result + ' DET_QTDITE,                                                             ';
  Result := Result + ' DET_CLAFIS,                                                             ';
  Result := Result + ' IF(DET_DTAENT IS NULL, "S", "N") AS DOCSEMDATA,                         ';
  Result := Result + '  IF( IFNULL(                                                            ';
  Result := Result + '          ( SELECT FGO_DOCEND                                            ';
  Result := Result + '              FROM FATDOR                                                ';
  Result := Result + '               INNER JOIN EXTGOR ON FDO_SEQGER = FGO_SEQFGO              ';
  Result := Result + '             WHERE TRUE                                                  ';
  Result := Result + '               AND IFNULL(FGO_DOCEND, "") <> ""                          ';
  Result := Result +                 fRetSQLDocEnd ;
  Result := Result + '               AND FDO_CODITE = DET_CODITE                               ';
  Result := Result + '               LIMIT 1                                                   ';
  Result := Result + '          ), "") = "", "N", "S"                                          ';
  Result := Result + '  ) AS ENDERE,                                                           ';

  If SameText(strTabela, 'MOVDET' ) Then
  Begin
    Result := Result + ' IF(RIGHT(DET_CLAFIS, 3) = "922" AND IFNULL(DET_QTDENT,0) >= IFNULL(DET_QTDITE,0), "S", "N") AS ENTFUT_BAIXADA, ';
    Result := Result + ' IF(RIGHT(DET_CLAFIS, 3) = "922" , (IFNULL(DET_QTDITE,0) - IFNULL(DET_QTDENT,0) ),0 ) AS ENTFUT_QTDRESTANT      ';
  End
  Else
  Begin
    Result := Result + ' "N" AS ENTFUT_BAIXADA, ';
    Result := Result + ' 0 AS ENTFUT_QTDRESTANT  ';
  End;

  Result := Result + ' FROM ' + strTabela + ' ';
  Result := Result + ' LEFT JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + '  ( DET_DTAENT > :DTABAL OR DET_DTAENT IS NULL )AND ';
  Result := Result + '   DET_CODEMP = :CODEMP AND ';
  Result := Result + '   DET_CODITE = :CODITE AND ';
  Result := Result + '   IFNULL(DET_NUMLOT, "") = "" ';

End;

Function TCadLot.fSQLPedidos: String;
Begin
  Result := '';
  Result := Result + ' SELECT AUTOINCREM, IF(IFNULL(FGO_DOCEND, "") = "", "N", "S") AS ENDERE FROM FATDOR F ';
  Result := Result + ' LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = F.FDO_SEQGER ';
  Result := Result + ' WHERE ';
  Result := Result + '   FDO_JAFATU = 0       AND ';
  Result := Result + '   FDO_CODEMP = :CODEMP AND ';
  Result := Result + '   FDO_CODITE = :CODITE     ';
End;

Function TCadLot.fSQLUpdateMovDet(strTabela: String): String;
Begin
  Result := '';
  Result := Result + ' UPDATE ' + strTabela;
  Result := Result + '   SET DET_NUMLOT = :NUMLOT ';
  Result := Result + ' WHERE                      ';
  Result := Result + '   AUTOINCREM = :AUTINC     ';
End;

Function TCadLot.fSQLUpdatePedidos: String;
Begin
  Result := '';
  Result := Result + ' UPDATE FATDOR ';
  Result := Result + '   SET FDO_NUMLOT = :NUMLOT ';
  Result := Result + ' WHERE                      ';
  Result := Result + '   AUTOINCREM = :AUTINC     ';
End;

Procedure TCadLot.pUpdateMovdet(strAutInc, strNumLot: String; qryUpdate: TUniQuery);
Begin
  With qryUpdate Do
  Begin
    Close;

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('NUMLOT').AsString := strNumLot;

    ExecSQL;
  End;
End;

Procedure TCadLot.pUpdateFatDor(strAutInc, strNumLot: String; qryUpdate: TUniquery);
Begin
  With qryUpdate Do
  Begin
    Close;

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('NUMLOT').AsString := strNumLot;

    ExecSQL;
  End;
End;

Function TCadLot.fSQLUpdateSaldoCadLot: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE CADLOT SET ';
  strSQL := strSQL + '   LOT_SALDOS = IFNULL(LOT_SALDOS, 0) + :QTDITE ';
  strSQL := strSQL + ' WHERE LOT_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '       LOT_CODITE = :CODITE AND ';
  strSQL := strSQL + '       LOT_NUMLOT = :NUMLOT     ';

  Result := strSQL;
End;

Procedure TCadLot.pUpdateSaldoCadLot(strCodIte, strCodEmp, strNumLot: String; fltQtdIte: Double; qryUpdLot: TUniQuery);
Begin
  With qryUpdLot Do
  Begin
    Close;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;
    ParamByName('QTDITE').AsFloat  := fltQtdIte;
    ExecSQL;
  End;
End;

Procedure TCadLot.pSetaMovDet(strTabDet, strCodEmp, strCodIte, strNumLot: String; dtaDtaBal: TDate);
  Var
    qryMovDet: TUniquery;
    qryUpdate: TUniquery;
    qryUpdLot: TUniquery;
Begin
  qryMovDet := fCriaQuery;
  qryUpdate := fCriaQuery;
  qryUpdLot := fCriaQuery;

  qryUpdLot.SQL.Text := fSQLUpdateSaldoCadLot;

  With qryMovDet Do
  Begin

    SQL.Text := fSQLMovimentos(strTabDet);

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('DTABAL').AsDate   := dtaDtaBal;

    Open;

    If Assigned(pgbStatusGravacao) Then
    Begin
      pgbStatusGravacao.Position       := 0;
      pgbStatusGravacao.Properties.Max := RecordCount;
    End;

    qryUpdate.SQL.Text := fSQLUpdateMovDet(strTabDet);

    While Not Eof Do
    Begin
      If FieldByName('ENDERE').AsString = 'S' Then
      Begin
        pUpdateMovdet(FieldByName('AUTOINCREM').AsString, 'A DEFINIR', qryUpdate);
        pUpdateSaldoCadLot(strCodIte, strCodEmp, strNumLot,   -FieldByName('DET_QTDITE').AsFloat, qryUpdLot);
        pUpdateSaldoCadLot(strCodIte, strCodEmp, 'A DEFINIR',  FieldByName('DET_QTDITE').AsFloat, qryUpdLot);
      End
      Else If (FieldByName('ENDERE').AsString = 'N') AND ( FieldByName('DOCSEMDATA').AsString = 'S') Then
      Begin
        If (FieldByName('ITE_REAEND').AsString = 'N') Then
          pUpdateMovdet(FieldByName('AUTOINCREM').AsString, strNumLot, qryUpdate)
        Else
          pUpdateMovdet(FieldByName('AUTOINCREM').AsString, 'A DEFINIR', qryUpdate);
      End
      Else
      Begin
        If Pos(FieldByName('DET_CLAFIS').AsString, '5922_6922') > 0 Then
        Begin
          If (FieldByName('ENTFUT_BAIXADA').AsString = 'S') Then
            pUpdateMovdet(FieldByName('AUTOINCREM').AsString, strNumLot, qryUpdate)
          Else
          begin
            pUpdateMovdet(FieldByName('AUTOINCREM').AsString, 'A DEFINIR', qryUpdate);
            pUpdateSaldoCadLot(strCodIte, strCodEmp, 'A DEFINIR',  -FieldByName('ENTFUT_QTDRESTANT').AsFloat, qryUpdLot);
            pUpdateSaldoCadLot(strCodIte, strCodEmp, strNumLot,  FieldByName('ENTFUT_QTDRESTANT').AsFloat, qryUpdLot);
          End;
        End
        Else
          pUpdateMovdet(FieldByName('AUTOINCREM').AsString, strNumLot, qryUpdate);
      End;

      Next;
      pStepStatusGravacao;
    End;

  End;

  FreeAndNil(qryMovDet);
  FreeAndNil(qryUpdate);
  FreeAndNil(qryUpdLot);
End;

procedure TCadLot.pSetaReplicadorTinta(
  objReplTinta: IExecutaSQLReplicacaoTinta);
begin
  FReplTinta := objReplTinta;
end;

Procedure TCadLot.pSetaFatDor(strCodEmp, strCodIte, strNumLot: String);
  Var
    qryFatDor: TUniquery;
    qryUpdate: TUniquery;
Begin
  qryFatDor := fCriaQuery;
  qryUpdate := fCriaQuery;

  With qryFatDor Do
  Begin

    SQL.Text := fSQLPedidos;

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    If Assigned(pgbStatusGravacao) Then
    Begin
      pgbStatusGravacao.Position       := 0;
      pgbStatusGravacao.Properties.Max := RecordCount;
    End;

    qryUpdate.SQL.Text := fSQLUpdatePedidos;

    While Not Eof Do
    Begin
      If FieldByName('ENDERE').AsString = 'S' Then
        pUpdateFatDor(FieldByName('AUTOINCREM').AsString, 'A DEFINIR', qryUpdate)
      Else
        pUpdateFatDor(FieldByName('AUTOINCREM').AsString, strNumLot, qryUpdate);
      Next;
      pStepStatusGravacao;
    End;

  End;

  FreeAndNil(qryFatDor);
  FreeAndNil(qryUpdate);
End;

Function TCadLot.fSetaMovimentosLote(strCodIte, strNumLot: String): Boolean;
  Var
    qryIteger  : TUniQuery;
    stlEmpresas: TStringList;
    intContador: Integer;
Begin
  stlEmpresas := TStringList.Create;
  Try
    qryIteger := fCriaQuery;
    Try
      Try
        {Empresa unica quando a rotina WMS ja restringe por empresa ou o sistema
         nao replica lote entre empresas; senao, mesmo grupo WMS/nao-WMS usado
         por fGeraLoteEmpresas para replicar o CADLOT.
         Verificar Nota 1 - Req. 460354}
        If fUsaRotinaWMS Or (Not fReplicaLote) Then
          stlEmpresas.Add(VS_strCodEmp)
        Else
          stlEmpresas.Text := AnsiReplaceStr(fRetEmpresasWms(fUsaRotinaWMS), ',', #13#10);

        With qryIteger, SQL Do
        Begin
          Add('SELECT');
          Add('  ITE_CODEMP, ITE_DTABAL');
          Add('FROM');
          Add('  ITEGER');
          Add('WHERE');
          Add('  ITE_CODITE = :CODITE AND ITE_DTABAL IS NOT NULL AND ITE_CODEMP = :CODEMP');
        End;

        For intContador := 0 To stlEmpresas.Count - 1 Do
        Begin
          With qryIteger Do
          Begin
            Close;
            ParamByName('CODITE').AsString := strCodIte;
            ParamByName('CODEMP').AsString := stlEmpresas[intContador];
            Open;

            While Not Eof Do
            Begin
              pSetaMovDet('MOVDET', FieldByName('ITE_CODEMP').AsString,
                                    strCodIte, strNumLot,
                                    FieldByName('ITE_DTABAL').AsDateTime);

              pSetaMovDet('NOTDET', FieldByName('ITE_CODEMP').AsString,
                                    strCodIte, strNumLot,
                                    FieldByName('ITE_DTABAL').AsDateTime);

              {************************************************************************}
              {* TAMBEM PRECISA SETAR O NUMERO DE LOTE PARA OS PEDIDOS EM ABERTO,     *}
              {* POIS PODE OCORRER DE FATURAR OS MESMOS SEM O NUMERO DE LOTE, ASSIM   *}
              {* BAIXANDO SOMENTE O ESTOQUE DO ITEGER E NAO DO CADASTRO DE LOTES      *}
              {* TAMBEM OCORRE QUE NO ENDERECAMENTO DE PRODUTOS DEBITA A QUANTIDADE   *}
              {* DO LOTE A DEFINIR (FDO_NUMLOT ESTA NULL), DEIXANDO ASSIM O MESMO COM *}
              {* ESTOQUE NEGATIVO, OQUE NAO PODE OCORRER                              *}
              {*********************************************************************JC*}
              pSetaFatDor(FieldByName('ITE_CODEMP').AsString, strCodIte, strNumLot);

              Next;
            End;

            Close;
          End;
        End;

        Result := True;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          Result := False;
          pMensagensErro(E.Message, '[TCadLot.fSetaMovimentosLote]');
        End;
      End;
    Finally
      FreeAndNil(qryIteger);
    End;
  Finally
    FreeAndNil(stlEmpresas);
  End;
End;

procedure TCadLot.pStepStatusGravacao;
Begin
  If Assigned(pgbStatusGravacao) Then
  Begin
    pgbStatusGravacao.Position := pgbStatusGravacao.Position + 1;
    Application.ProcessMessages;
  End;
End;

Procedure TCadLot.pFinalizaStatusGravacao;
Begin
  If Assigned(pgbStatusGravacao) Then
  Begin
    pgbStatusGravacao.Position := pgbStatusGravacao.Properties.Max;
    Application.ProcessMessages;
  End;
End;

Function TCadLot.fTrocaLocFisica(strCodIte, strNumLot, strLocFis: String): Boolean;
  Var
    qryUpdate: TUniQuery;
Begin
  If Not fEmptyStr(strLocFis) Then
  Begin
    qryUpdate := fCriaQuery;

    With qryUpdate, SQL Do
    Begin
      Clear;
      Add('UPDATE CADLOT');
      Add('SET LOT_LOCFIS = NULL');
      Add('WHERE');
      Add('  LOT_CODEMP  = :CODEMP AND ');
      Add('  LOT_LOCFIS  = :LOCFIS AND ');
      Add('  (NOT ((LOT_NUMLOT = :NUMLOT) AND ');
      Add('        (LOT_CODITE = :CODITE)))   ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strNumLot;
      ParamByName('LOCFIS').AsString := strLocFis;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;

      fGravaLogLocFisica(strCodIte, strLocFis, '', 1, strNumLot);

      Clear;
      Add('UPDATE ITEGER');
      Add('SET ITE_LOCFIS = NULL');
      Add('WHERE');
      Add('  ITE_CODEMP  = :CODEMP AND ');
      Add('  ITE_LOCFIS  = :LOCFIS AND ');
      Add('  ITE_CODITE  <> :CODITE     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('LOCFIS').AsString := strLocFis;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;

      fGravaLogLocFisica(strCodIte, strLocFis, '', 1, '');

    End;

    FreeAndNil(qryUpdate);
  End;

  Result := True;
End;

function TCadLot.fTrocarLote(strTabela, strAutInc, strLotAtu, strLotNov,
  strCodIte: String; fltQtdIte: Double; strCodEmp: String = ''): Boolean;
begin
  fStartTransaction;
  Result := True;
  Try
    Result := Result And fAtualizaEstoqueLote(strCodIte, 'E', strLotAtu, fltQtdIte, strCodEmp);
    Result := Result And fAtualizaEstoqueLote(strCodIte, 'S', strLotNov, fltQtdIte, strCodEmp);
    Result := Result And fAtualizaLoteMovDet(strTabela, strAutInc, strLotNov);
    If (Result) Then
    Begin
      ReprocessarItem(strCodIte, '');

      fCommit;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message,'[TCadLot.fTrocarLote]');
    End;
  End;
  If Not Result Then
    fRollBack;
end;

function fNumLotAtivo(strCodIte, strNumLot, strCodEmp : String):Boolean;
Begin
  Result := (fCampoTabela('LOT_STATUS', 'CADLOT', ['LOT_CODITE', 'LOT_NUMLOT', 'LOT_CODEMP'], [strCodIte, strNumLot, strCodEmp]) = 'S');
End;

function fVerificaLoteTransitorio(strCodIte, strNumLot, strCodEmp : String): Boolean;
Begin
  Result := (fCampoTabela('LOT_TRANSI', 'CADLOT', ['LOT_CODITE', 'LOT_NUMLOT', 'LOT_CODEMP'], [strCodIte, strNumLot, strCodEmp]) = 'S');
End;

function fMensagemValidacaoPeloCodigoBarrasDoLote(strCodIte, strNumLot: String; cdsItens: TUniClientDataSet): String;
var
  strLotesPedidos: String;
  cdsClone: TUniClientDataSet;
Begin
  Result := EmptyStr;

  if not Assigned(cdsItens) then
    Exit;

  if not cdsItens.Active then
    Exit;

  if cdsItens.RecordCount <= 0 then
    Exit;

  if not Assigned(cdsItens.FieldByName('NUMLOT')) then
    Exit;

  cdsClone := TUniClientDataSet.Create(Nil);
  pCloneDataSet(cdsClone, cdsItens);

  try
    strLotesPedidos := EmptyStr;

    cdsClone.First;

    while not cdsClone.Eof do
    begin
      if not fEmptyStr(cdsClone.FieldByName('NUMLOT').AsString) then
        strLotesPedidos := strLotesPedidos + ';' + cdsClone.FieldByName('NUMLOT').AsString;
      cdsClone.Next;
    end;

    if not fEmptyStr(strLotesPedidos) then
      Delete(strLotesPedidos,1,1);

    Result := 'Atenção! O lote bipado não condiz com o lote que foi informado no pedido de venda para o item '+strCodIte+'. ' + sLineBreak +
              'Lote bipado: '+strNumLot+' - Lote(s) do pedido: '+strLotesPedidos+' ' + sLineBreak +
              'Fale com o vendedor responsável pelo pedido ou, bipe o lote correto para continuar.';
  finally
    FreeAndNil(cdsClone);
  end;
End;

function fTemLoteCadastradoNaCadLot(Var strCodIteRet, strNumLotRet: String; strCodigoBipado: String): Boolean;
begin
  Result := False;

  if strCodigoBipado.Length <= fTamCodIte then
    Exit;

  strCodIteRet := Copy(strCodigoBipado, 1, fTamCodIte);

  Delete(strCodigoBipado, 1, fTamCodIte);

  strNumLotRet := Trim(strCodigoBipado);

  if fEmptyStr(strNumLotRet) then
    Exit;

  Result := Not fEmptyStr(fCampoTabela('LOT_NUMLOT','CADLOT',['LOT_CODEMP','LOT_CODITE','LOT_NUMLOT'],[VS_strCodEmp,strCodIteRet,strNumLotRet],False));
end;

function fValidarLotePeloCodigoBarrasDoLote(Var strCodIteRet, strNumLotRet: String; strCodigoBipado: String): Boolean;
begin
  Result := ((fCfgSis('LOTBAR', varBoolean)) And
             (Not fUsaRotinaWMS) And
             (strCodigoBipado.Length > fTamCodIte) And
             (fTemLoteCadastradoNaCadLot(strCodIteRet, strNumLotRet, strCodigoBipado)));
end;

Class Function TCadLot.fRetLotesContagemAberta: String;
  Var
    stlArmazens: TStringList;
    qryGenIte: TUniQuery;
Begin
  If (fCfgSis('CTLEST') = '2') Then
  Begin
    stlArmazens := TStringList.Create;
    qryGenIte   := fCriaQuery;

    With qryGenIte Do
    Begin
      Close;
      SQL.Text := 'SELECT CON_ARMAZE FROM CONAMZ WHERE CON_CODEMP = :CODEMP AND CON_DTAFIN IS NULL';

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      stlArmazens.Text := FieldByName('CON_ARMAZE').AsString;

      Result := fCommaText(stlArmazens, True);
    End;

    FreeAndNil(qryGenIte);
    FreeAndNil(stlArmazens);
  End

  Else Result := '';
End;

function TCadLot.fZeraContagemLote(blnLimpar: Boolean = True; strFilExt : String = ''; event_Parametros: TSetaParametros = nil):Boolean;
  Var
    strArmazens: string;
begin
  If (Not blnLimpar) Then
    strArmazens := fRetLotesContagemAberta
  Else
    strArmazens := '';
  Result := fZeraContagemLote(strArmazens, '', blnLimpar, strFilExt, event_Parametros);
end;

{Req. 456948-B - B3. Zeramento de contagem de lote em passada unica.

 Substitui a chamada por linha de fZeraContagemLote na Fase 2 de fZeraItens.
 Medido numa rodada de 280 linhas: 216 execucoes do UPDATE conjugado, cada uma
 tocando uma linha de ITEGER e pagando 3 statements de trigger.

 NAO toca ITEGER (B4): a Fase 1 ja gravou os mesmos seis campos em lote.
 NAO grava CONDET: quem faz e TConDet.fGravaConDetZeraLotesRodada, chamada
 ANTES desta, porque precisa de LOT_SALCON e LOT_DIGCON pre-zeramento.
 NAO limpa HISBAL: a Fase 1 ja faz DELETE FROM HISBAL por item, que e
 superconjunto do por lote.

 Os campos e os valores sao os do ramo blnLimpar = True do UPDATE conjugado,
 que e o unico ramo que o balanco usava.}
function TCadLot.fZeraContagemLoteRodada(const AstrConId, AstrCodCon: String): Boolean;
  Var
    qryLote: TUniQuery;
begin
  Result := True;

  qryLote := fCriaQuery;
  Try
    Try

      qryLote.SQL.Add(' UPDATE CADLOT L                                         ');
      qryLote.SQL.Add('  INNER JOIN BALZER Z ON Z.ZER_CODEMP = L.LOT_CODEMP      ');
      qryLote.SQL.Add('                    AND Z.ZER_CODITE = L.LOT_CODITE      ');
      qryLote.SQL.Add('                    AND Z.ZER_NUMLOT = L.LOT_NUMLOT      ');
      qryLote.SQL.Add('    SET L.LOT_SALCON = 0,                                 ');
      qryLote.SQL.Add('        L.LOT_ML_CON = 0,                                 ');
      qryLote.SQL.Add('        L.LOT_DIFSAL = 0,                                 ');
      qryLote.SQL.Add('        L.LOT_DIF_ML = 0,                                 ');
      qryLote.SQL.Add('        L.LOT_DIGCON = "N",                               ');
      qryLote.SQL.Add('        L.LOT_ORDCON = 0                                  ');
      qryLote.SQL.Add('  WHERE Z.ZER_CON_ID = :CONID                             ');
      qryLote.SQL.Add('    AND Z.ZER_CODCON = :CODCON                            ');
      qryLote.SQL.Add('    AND Z.ZER_ORIGEM = "Z"                                ');
      qryLote.SQL.Add('    AND Z.ZER_NUMLOT <> ""                                ');

      {Req. 456948 - achado DelphAI 2026-08-31. CADLOT nao tem coluna de
       localizacao - e o agregado do lote inteiro. A chave granular
       item+lote+localizacao pertence a LOTLOC (UPDATE acima), ja zerado por
       localizacao. Antes este UPDATE so rodava com Z.ZER_LOCFIS = "", que em
       cliente multi-localizacao nunca casa (BALZER "Z" sempre traz a
       localizacao real - ver untBalancoEstoqueGravar.pas, populacao de
       FItemZeraList): CADLOT.LOT_DIGCON ficava preso em "S" e
       fVerificaIntegridadeRodada (V4a) rejeitava toda gravacao em cliente
       multi-localizacao. O JOIN por CODEMP+CODITE+NUMLOT ja basta - zera o
       lote assim que qualquer localizacao dele entrou na rodada.}

      qryLote.ParamByName('CONID').AsString  := AstrConId;
      qryLote.ParamByName('CODCON').AsString := AstrCodCon;
      qryLote.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadLot.fZeraContagemLoteRodada]');
      End;
    End;
  Finally
    FreeAndNil(qryLote);
  End;
end;

function TCadLot.fZeraContagemLote(strArmazens: string; strCodIte: String; blnLimpar: Boolean = True; strFilExt: string = ''; event_Parametros: TSetaParametros = nil; AblnAtualizaIteger: Boolean = True):Boolean;   {Req. 456948-B - B8/B4: blnTableTmp removido, virou AblnAtualizaIteger}
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
begin
  Try
    Result := True;

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADLOT ';
    If (strCodIte = '') And (Assigned(event_Parametros)) Then
    Begin
      strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODEMP = CADLOT.LOT_CODEMP AND G.ITE_CODITE = CADLOT.LOT_CODITE ';
      strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
    End;

    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  LOT_SALCON = 0,      ';
    strSQL := strSQL + '  LOT_DIFSAL = 0,      ';
    strSQL := strSQL + '  LOT_ML_CON = 0,      ';
    strSQL := strSQL + '  LOT_DIF_ML = 0,      ';

    If (strCodIte = '') And (Assigned(event_Parametros)) And AblnAtualizaIteger Then   {Req. 456948-B - B4}
    Begin
       strSql := strSql + ' 	 G.ITE_SALCON = 0,                                     ';
       strSql := strSql + ' 	 G.ITE_ORDCON = 0,                                     ';
       strSql := strSql + ' 	 G.ITE_GMLCON = 0,                                     ';
       strSql := strSql + ' 	 G.ITE_DIFSAL = 0,                                     ';
       strSql := strSql + ' 	 G.ITE_DIF_ML = 0,                                     ';

       If blnLimpar Then
         strSql := strSql + ' 	 G.ITE_DIGCON = "N",                                    '
       Else
         strSql := strSql + ' 	 G.ITE_DIGCON = "S",                                    ';
    End;

    If blnLimpar Then
    Begin
      strSQL := strSQL + '  LOT_DIGCON = "N", ';
      strSQL := strSQL + '  LOT_ORDCON = 0    ';
    End
    Else
      strSQL := strSQL + '  LOT_DIGCON = "S"   ';

    strSQL := strSQL + 'WHERE  LOT_CODEMP = :CODEMP    ';

    If Not fEmptyStr(strArmazens) Then
      strSQL := strSQL + ' AND LOT_NUMLOT IN (' + strArmazens + ') ';

    If strCodIte <> '' Then
    Begin
      strSQL := strSQL + '  AND LOT_CODITE = :CODITE  ';
    End;

    strSQL := strSQL + ' ' + strFilExt;

    TConDet.fGravaConDetZeraContagemLote(strCodIte, Self.Owner, IIF(blnLimpar, 'N', 'S'), VS_strCodEmp, strFilExt, event_Parametros, strArmazens);

    Try

      If blnLimpar Then
        THistoricoBalanco.pLimpaHistoricoSaldoLote(strArmazens, strCodIte,
                              strFilExt, event_Parametros)
      Else
        THistoricoBalanco.pIncluiHistoricoZeraSaldoLote(strArmazens, strCodIte,
                              strFilExt, event_Parametros);

      With qryGenIte Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        If strCodIte <> '' Then
        Begin
          ParamByName('CODITE').AsString := strCodIte;
        End;
        If Assigned(event_Parametros) Then
          event_Parametros(qryGenIte);

        ExecSQL;
        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadLot.fZeraContagemLote]');
      End;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
end;

procedure TCadLot.pAjustaArmPrincipalCompra(strCadAmz, strCodIte: String);
  Var
    qryLotAux: TUniQuery;
Begin
  Try
    qryLotAux := fCriaQuery;

    With qryLotAux, SQL Do Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_ARMPRC = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strCadAmz;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryLotAux);
  End;
End;

procedure TCadLot.pAjustaArmPrincipalGarantia(strCadAmz, strCodIte: String);
  Var
    qryLotAux: TUniQuery;
Begin
  Try
    qryLotAux := fCriaQuery;

    With qryLotAux, SQL Do Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_GARPRI = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strCadAmz;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryLotAux);
  End;
end;

class procedure TCadLot.pAjustaArmPrincipalProducao(strCadAmz, strCodIte: String);
  Var
    qryLotAux: TUniQuery;
Begin
  Try
    qryLotAux := fCriaQuery;

    With qryLotAux, SQL Do Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_PRIPRO = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strCadAmz;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryLotAux);
  End;
end;

class procedure TCadLot.pAjustaArmPrincipalProducaoIndustrial(strCadAmz,
  strCodIte: String);
  Var
    qryLotAux: TUniQuery;
Begin
  qryLotAux := Nil;
  Try
    qryLotAux := fCriaQuery;

    With qryLotAux, SQL Do Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_PRIIND = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strCadAmz;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryLotAux);
  End;
end;

procedure TCadLot.pAjustaArmPrincipalVenda(strCadAmz, strCodIte: String);
  Var
    qryLotAux: TUniQuery;
Begin
  Try
    qryLotAux := fCriaQuery;

    With qryLotAux, SQL Do Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_ARMPRI = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strCadAmz;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryLotAux);
  End;
End;

procedure TCadLot.pAjustaLotePrincipalConsertoEquipamento(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  If qryCadLot.FieldByName('LOT_ARMPCE').AsString = 'S' Then
  Begin
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_ARMPCE = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT AND ');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;
    End;

    FreeAndNil(qryLotAux);
  End

  Else If (Not SameText(qryCadLot.FieldByName('LOT_NUMLOT').AsString, 'A DEFINIR')) And
          (Not fExisteLotePrincipalConsertoEquipamento(qryCadLot.FieldByName('LOT_CODITE').AsString, Vs_strCodEmp)) Then
  Begin
    qryCadLot.Edit;
    qryCadLot.FieldByName('LOT_ARMPCE').AsString := 'S';
    qryCadLot.Post;
  End;
end;

procedure TCadLot.pAjustaLotePrincipalTintaMaquina(strCadAmz, strCodIte: String);
  Var
    qryLotAux: TUniQuery;
Begin
  Try
    qryLotAux := fCriaQuery;

    With qryLotAux, SQL Do Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_PRITIN = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strCadAmz;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryLotAux);
  End;
end;

Class Function TCadLot.fTemCrossdocking(strCodIte, strCodEmp, strNumLot: String; Var strLoteEncontrado: String): Boolean;
  Var
    qryCadLot: TUniQuery;
    strSQL: String;
Begin
  strLoteEncontrado := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT LOT_NUMLOT ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADLOT ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       LOT_CODITE = :CODITE ';
  strSQL := strSQL + '   AND LOT_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND LOT_CRODOC = "S"     ';

  If Not fEmptyStr(strNumLot) Then
    strSQL := strSQL + '   AND LOT_NUMLOT <> :NUMLOT ';

  qryCadLot := fCriaQuery;
  With qryCadLot Do
  Begin
    SQL.Text := strSQL;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strNumLot) Then
      ParamByName('NUMLOT').AsString := strNumLot;

    Open;

    Result := Not IsEmpty;

    If Result Then
      strLoteEncontrado := FieldByName('LOT_NUMLOT').AsString;

  End;
  FreeAndNil(qryCadLot);
End;

Class Function TCadLot.fTemContagemArmazem(Var strCodAmz: String; Var intNumAmz: Integer): Boolean;
  Var
    qryConAmz: TUniQuery;
    stlLista: TStringList;
Begin
  Try
    strCodAmz := '';

    qryConAmz := fCriaQuery;
    With qryConAmz, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM CONAMZ WHERE CON_CODEMP = :CODEMP AND CON_DTAFIN IS NULL');

      ParamByName('CODEMP').AsString   := VS_strCodEmp;

      Open;

      Result := Not IsEmpty;

      If Result Then
      Begin
        stlLista  := TStringList.Create;

        stlLista.Text := Trim(FieldByName('CON_ARMAZE').AsString);

        intNumAmz := stlLista.Count;

        If stlLista.Count > 1 Then
          strCodAmz := fCommaText(stlLista, False)
        Else
          strCodAmz := stlLista.Text;

        FreeAndNil(stlLista);
      End;

    End;
    FreeAndNil(qryConAmz);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadLot.fTemContagemArmazem]');
    End;

  End;

End;

Class Function TCadLot.fIniciaContagemArmazem(arrCodAmz: TConsultasArray): Boolean;
  Var
    qryConAmz: TUniQuery;
    strAmzIni: String;
    intNumAmz: Integer;
Begin
  Try
    If fTemContagemArmazem(strAmzIni, intNumAmz) Then
    Begin
      pMensagemOk('O balanço do(s) armazém(s) ' + strAmzIni + ' já iniciado!');
      Result := False;
      Exit;
    End;

    If fTemItemContado Then
    Begin
      pMensagemOk('Há itens com contagem iniciada. Para iniciar a contagem por armazém é necessário zerar a contagem em aberto!');
      Result := False;
      Exit;
    End;

    If (Not fLock_Unlock('INICIA_CONTAGEM_ARMAZEM_' + VS_strCodEmp, True, False)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock('INICIA_CONTAGEM_ARMAZEM_' + VS_strCodEmp), ['&Ok']);
      Result := False;
      Exit;
    End;

    qryConAmz := fCriaQuery;
    With qryConAmz Do
    Begin
      SQL.Text  := 'SELECT * FROM CONAMZ WHERE FALSE';
      Open;

      Insert;
      FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CONAMZ', VS_strCodEmp);
      FieldByName('CON_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('CON_CODOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('CON_ARMAZE').AsString   := fArrCodigosToText(arrCodAmz);
      FieldByName('CON_DTAINI').AsDateTime := VS_Date;
      FieldByName('CON_HORINI').AsDateTime := fTime();
      Post;

      Result := True;
    End;
    FreeAndNil(qryConAmz);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadLot.fIniciaContagemArmazem]');
    End;

  End;

  fLock_Unlock('INICIA_CONTAGEM_ARMAZEM_' + VS_strCodEmp, False, False);
End;

Class Function TCadLot.fTemItemContado: Boolean;
  Var
    qryItem: TUniQuery;
Begin
  qryItem := fCriaQuery;
  With qryItem, SQL Do
  Begin
    Add('SELECT COUNT(*) AS QTD FROM ITEGER');
    Add('WHERE');
    Add('  ITE_CODEMP = :CODEMP AND');
    Add('  ITE_DIGCON = "S"');

    ParamByName('CODEMP').AsString   := VS_strCodEmp;

    Open;

    Result := FieldByName('QTD').AsInteger > 0;

  End;
  FreeAndNil(qryItem);
End;

Class Function TCadLot.fFinalizaContagemArmazem: Boolean;
  Var
    strAmzIni: String;
    qryConAmz: TUniQuery;
    intNumAmz: Integer;
Begin
  Try

    If Not fTemContagemArmazem(strAmzIni, intNumAmz) Then
    Begin
      pMensagemOk('Não há balanço de armazém iniciado!');
      Result := False;
      Exit;
    End;

    If fTemItemContado Then
    Begin
      pMensagemOk('Há itens com contagem iniciada. Para finalizar a contagem por armazém é necessário Limpar a contagem em aberto!');
      Result := False;
      Exit;
    End;

    qryConAmz := fCriaQuery;
    With qryConAmz, SQL Do
    Begin
      Clear;
      Add('UPDATE CONAMZ SET');

      Add('  CON_OPEFIN = :OPEFIN,');
      Add('  CON_DTAFIN = :DTAFIN,');
      Add('  CON_HORFIN = :HORFIN ');

      Add('WHERE CON_CODEMP = :CODEMP AND CON_DTAFIN IS NULL ');

      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('OPEFIN').AsString   := strLoginUsuarioLogado;
      ParamByName('DTAFIN').AsDateTime := VS_Date;
      ParamByName('HORFIN').AsDateTime := fTime();

      ExecSQL;

      Result := True;
    End;
    FreeAndNil(qryConAmz);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadLot.fFinalizaContagemArmazem]');
    End;

  End;

End;

Class Procedure TCadLot.pRetSaldosLoteArmazem(strCodIte, strCodAmz: String; Var fltSaldos, fltSal_Ml: Double);
  Var
    qryCadLot: TUniQuery;
Begin
  fltSaldos := 0;
  fltSal_Ml := 0;

  qryCadLot := fCriaQuery;
  With qryCadLot, SQL Do
  Begin
    Add('SELECT');
    Add('  LOT_SALDOS,');
    Add('  LOT_SAL_ML ');
    Add('FROM');
    Add('  CADLOT');
    Add('WHERE');
    Add('  LOT_NUMLOT IN (' + strCodAmz + ') AND');
    Add('  LOT_CODITE = :CODITE AND');
    Add('  LOT_CODEMP = :CODEMP');

    ParamByName('CODEMP').AsString   := VS_strCodEmp;
    ParamByName('CODITE').AsString   := strCodIte;

    Open;

    If Not IsEmpty Then
    Begin
      fltSaldos := FieldByName('LOT_SALDOS').AsFloat;
      fltSal_Ml := FieldByName('LOT_SAL_ML').AsFloat;;
    End;

  End;

  FreeAndNil(qryCadLot);
End;

class function TCadLot.ProdutoTemLote(const ACodite: String; ACodEmp: String = ''): Boolean;
begin
  If (fEmptyStr(ACodEmp)) Then
    ACodEmp := VS_strCodEmp;

  Result := fCampoTabela('COUNT(0)', 'CADLOT', ['LOT_CODEMP', 'LOT_CODITE'], [ACodEmp, ACodIte]) > 0;
end;

Function TCadLot.fExisteLotePrincipalOrcamentoPedidoVenda(strCodIte: String; strCodEmp: String): Boolean;
  Var
    qryLotAux: TUniQuery;
Begin
  qryLotAux := fCriaQuery;
  With qryLotAux, SQL Do
  Begin
    Add(' SELECT *                    ');
    Add('   FROM CADLOT               ');
    Add('  WHERE LOT_CODITE = :CODITE ');
    Add('    AND LOT_ARMOPV = "S"     ');
    Add('    AND LOT_CODEMP = :CODEMP ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    Result := Not IsEmpty;
    Close;
  End;

  FreeAndNil(qryLotAux);
End;

Procedure TCadLot.pAjustaArmPrincipalOrcamentoPedidoVenda(qryCadLot: TUniQuery);
  Var
    qryLotAux: TUniQuery;
Begin
  If qryCadLot.FieldByName('LOT_ARMOPV').AsString = 'S' Then
  Begin
    qryLotAux := fCriaQuery;
    With qryLotAux, SQL Do
    Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_ARMOPV = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT AND ');
      Add('  LOT_CODEMP  = :CODEMP     ');

      ParamByName('CODITE').AsString := qryCadLot.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;
    End;

    FreeAndNil(qryLotAux);
  End

  Else If (Not SameText(qryCadLot.FieldByName('LOT_NUMLOT').AsString, 'A DEFINIR')) And
          (Not fExisteLotePrincipalOrcamentoPedidoVenda(qryCadLot.FieldByName('LOT_CODITE').AsString, Vs_strCodEmp)) Then
  Begin
    qryCadLot.Edit;
    qryCadLot.FieldByName('LOT_ARMOPV').AsString := 'S';
    qryCadLot.Post;
  End;
End;

function TCadLot.fRetLoteMenorValidade(strCodIte, strCodEmp: String; arrNumLot: TStringArray): String;
var
  qryLotVen: TUniQuery;
  strNumLot: String;
  intContador: Integer;
begin

  qryLotVen := fCriaQuery;
  try
    qryLotVen.Close;

    strNumLot := '';
    If Assigned(arrNumLot) And (Length(arrNumLot) > 0) Then
    Begin
      strNumLot := strNumLot + ' AND ( ';
      For intContador := 0 To Length(arrNumLot) -1 Do
      Begin
        strNumLot := strNumLot + ' (LOT_NUMLOT = ' + QuotedStr(arrNumLot[intContador]) + ')';
        If intContador < (Length(arrNumLot) -1) Then
          strNumLot := strNumLot + ' OR ';
      End;
      strNumLot := strNumLot + ' ) ';
    End;

    if fCfgSis('LMENDV', varBoolean) then
    begin
      strNumLot := IIF(not fEmptyStr(strNumLot), strNumLot, 'AND LOT_NUMLOT NOT IN ("A DEFINIR", "GARANTIA", "LABORATORIO") ');

      qryLotVen.SQL.Add('  SELECT                                       ');
      qryLotVen.SQL.Add('    LOT_NUMLOT                                 ');
      qryLotVen.SQL.Add('  FROM                                         ');
      qryLotVen.SQL.Add('    CADLOT                                     ');
      qryLotVen.SQL.Add('  WHERE                                        ');
      qryLotVen.SQL.Add('    LOT_CODEMP = :CODEMP                       ');
      qryLotVen.SQL.Add('    AND LOT_CODITE = :CODITE                   ');
      qryLotVen.SQL.Add('    AND LOT_STATUS = "S"                       ');
      qryLotVen.SQL.Add('    AND LOT_LOTAPR = "S"                       ');
      qryLotVen.SQL.Add('    AND LOT_SALDOS > 0                         ');
      qryLotVen.SQL.Add('    AND LOT_DTAVAL IS NOT NULL                 ');
      qryLotVen.SQL.Add(     strNumLot                                   );
      qryLotVen.SQL.Add('    AND LOCATE("FULFILLMENT", LOT_NUMLOT) <= 0 ');
      qryLotVen.SQL.Add('  ORDER BY LOT_DTAVAL, LOT_SALDOS              ');
    end
    else
    begin
      strNumLot := IIF(not fEmptyStr(strNumLot), strNumLot, ' AND LOT_NUMLOT NOT IN ("A DEFINIR", "GARANTIA") ');

      qryLotVen.SQL.Add('  SELECT                                ');
      qryLotVen.SQL.Add('    LOT_NUMLOT                          ');
      qryLotVen.SQL.Add('  FROM                                  ');
      qryLotVen.SQL.Add('    CADLOT                              ');
      qryLotVen.SQL.Add('  WHERE                                 ');
      qryLotVen.SQL.Add('    LOT_CODEMP = :CODEMP                ');
      qryLotVen.SQL.Add('    AND LOT_CODITE = :CODITE            ');
      qryLotVen.SQL.Add('    AND LOT_STATUS = "S"                ');
      qryLotVen.SQL.Add('    AND LOT_LOTAPR = "S"                ');
      qryLotVen.SQL.Add('    AND LOT_DTAVAL >= CURRENT_DATE      ');
      qryLotVen.SQL.Add('    AND LOT_SALDOS > 0                  ');
      qryLotVen.SQL.Add('    AND LOT_DTAVAL IS NOT NULL          ');
      qryLotVen.SQL.Add(     strNumLot                            );
      qryLotVen.SQL.Add('  ORDER BY                              ');
      qryLotVen.SQL.Add('    DATEDIFF(LOT_DTAVAL, CURRENT_DATE), ');
      qryLotVen.SQL.Add('    LOT_SALDOS                          ');
    end;

    qryLotVen.ParamByName('CODEMP').AsString := strCodEmp;
    qryLotVen.ParamByName('CODITE').AsString := strCodIte;
    qryLotVen.Open;

    qryLotVen.First;
    Result := qryLotVen.FieldByName('LOT_NUMLOT').AsString;

  finally
    FreeAndNil(qryLotVen);
  end;

end;

function TCadLot.fRetArmazemPrincipalOrcamentoPedidoVenda(strCodIte: String): String;
  Var
    qryNumLot: TUniQuery;
Begin
  Result := '';

  qryNumLot := fCriaQuery;
  With qryNumLot, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  LOT_NUMLOT');
    Add('FROM');
    Add('  CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_ARMOPV = "S"');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString;

    Close;
  End;

  FreeAndNil(qryNumLot);
End;

class function TCadLot.fRetArmazemPrincipalOrdemProducao(strCodIte: String; strCodEmp: String = ''; blnIndustrial: Boolean = False): String;
  Var
    qryNumLot: TUniQuery;
Begin
  Result := '';

  qryNumLot := fCriaQuery;
  With qryNumLot, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  LOT_NUMLOT');
    Add('FROM');
    Add('  CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add(IIF(blnIndustrial, ' LOT_PRIIND', ' LOT_PRIPRO') + ' = "S"');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);

    Open;

    If Not IsEmpty Then
      Result := FieldByName('LOT_NUMLOT').AsString;

    Close;
  End;

  FreeAndNil(qryNumLot);

end;

procedure TCadLot.pAjustaArmPrincipalOrcamentoPedidoVenda(strCadAmz, strCodIte: String);
  Var
    qryLotAux: TUniQuery;
Begin
  Try
    qryLotAux := fCriaQuery;

    With qryLotAux, SQL Do Begin
      Add('UPDATE CADLOT               ');
      Add('  SET LOT_ARMOPV = "N"      ');
      Add('WHERE                       ');
      Add('  LOT_CODITE  = :CODITE AND ');
      Add('  LOT_NUMLOT <> :NUMLOT     ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strCadAmz;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryLotAux);
  End;
End;

Class Function TCadLot.fGeraLotePrincipalGarantiaWMS(strCodIte, strCodEmp : String):Boolean;
  Var
    qryGenerica: TUniQuery;
    qryIteGer: TUniQuery;
Begin
  qryGenerica := fCriaQuery(Nil);
  qryIteGer   := fCriaQuery(Nil);

  try
    qryIteGer.close;
    qryIteGer.Sql.Add(' SELECT ITE_CODEMP,                            ');
    qryIteGer.Sql.Add(' ITE_SALDOS                                    ');
    qryIteGer.Sql.Add(' FROM ITEGER                                   ');
    qryIteGer.Sql.Add(' INNER JOIN CADEMP ON EMP_CODEMP = ITE_CODEMP  ');
    qryIteGer.Sql.Add(' WHERE ITE_CODITE = :CODITE                    ');
    qryIteGer.Sql.Add('   AND ITE_CODEMP = :CODEMP                    ');
    qryIteGer.Sql.Add('   AND EMP_UTIWMS = "S"                        ');
    qryIteGer.ParamByName('CODITE').AsString := strCodIte;
    qryIteGer.ParamByName('CODEMP').AsString := strCodEmp;
    qryIteGer.Open;
    Result := QryIteGer.IsEmpty;
    if QryIteGer.Active then
      QryIteGer.Close;
  finally
    if Assigned(QryIteGer) then
    begin
      QryIteGer.Free;
    end;
  end;

  if Result then
    Exit;

  try
    qryGenerica.Close;
    qryGenerica.Sql.Clear;
    qryGenerica.sql.Add('SELECT * FROM CADLOT WHERE FALSE');
    qryGenerica.Open;

    qryGenerica.Insert;
    qryGenerica.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', strCodEmp);
    qryGenerica.FieldByName('LOT_NUMLOT').AsString   := 'GARANTIA';
    qryGenerica.FieldByName('LOT_CODEMP').AsString   := strCodEmp;
    qryGenerica.FieldByName('LOT_CODITE').AsString   := strCodIte;
    qryGenerica.FieldByName('LOT_DTAFAB').Value      := VS_Date;
    qryGenerica.FieldByName('LOT_DTAVAL').Clear;
    qryGenerica.FieldByName('LOT_DTABAL').Value      := VS_Date -1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
    qryGenerica.FieldByName('LOT_SALBAL').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_SALDOS').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_ML_BAL').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_SAL_ML').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_SALCON').Value      := Null;
    qryGenerica.FieldByName('LOT_DIGCON').AsString   := 'N';
    qryGenerica.FieldByName('LOT_ORDCON').Value      := Null;
    qryGenerica.FieldByName('LOT_DIFSAL').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_LOCFIS').AsString   := '';
    qryGenerica.FieldByName('LOT_GARPRI').AsString   := 'S';
    qryGenerica.Post;

    Result := True;

  Finally
    qryGenerica.Close;
    FreeAndNil(qryGenerica);
  End;

End;

Class procedure TCadLot.pGerarLoteGarantia(strCodIte, strCodEmp : String);
  Var
    qryGenerica: TUniQuery;
Begin
  qryGenerica := fCriaQuery(Nil);
  try
    qryGenerica.sql.Text := 'SELECT * FROM CADLOT WHERE FALSE';
    qryGenerica.Open;

    qryGenerica.Insert;
    qryGenerica.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', strCodEmp);
    qryGenerica.FieldByName('LOT_NUMLOT').AsString   := 'GARANTIA';
    qryGenerica.FieldByName('LOT_CODEMP').AsString   := strCodEmp;
    qryGenerica.FieldByName('LOT_CODITE').AsString   := strCodIte;
    qryGenerica.FieldByName('LOT_DTAFAB').Value      := VS_Date;
    qryGenerica.FieldByName('LOT_DTAVAL').Clear;
    qryGenerica.FieldByName('LOT_DTABAL').Value      := VS_Date -1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
    qryGenerica.FieldByName('LOT_SALBAL').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_SALDOS').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_ML_BAL').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_SAL_ML').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_SALCON').Value      := Null;
    qryGenerica.FieldByName('LOT_DIGCON').AsString   := 'N';
    qryGenerica.FieldByName('LOT_ORDCON').Value      := Null;
    qryGenerica.FieldByName('LOT_DIFSAL').AsFloat    := 0;
    qryGenerica.FieldByName('LOT_LOCFIS').AsString   := '';
    qryGenerica.FieldByName('LOT_GARPRI').AsString   := 'S';
    qryGenerica.Post;
  Finally
    FreeAndNil(qryGenerica);
  End;
End;



procedure TCadLot.pGravaLoteRemessaDevolucao(strNumLote, strCodIte, strNumRem,
  strLocFis: String);
var
  qryLoteRemessa: TUniQuery;
begin
  qryLoteRemessa := fCriaQuery;

  try
    qryLoteRemessa.Close;
    qryLoteRemessa.SQL.Clear;
    qryLoteRemessa.SQL.Add('SELECT * FROM CADLOT WHERE FALSE');
    qryLoteRemessa.Open;

    qryLoteRemessa.Append;
    qryLoteRemessa.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', VS_strCodEmp);
    qryLoteRemessa.FieldByName('LOT_NUMLOT').AsString   := strNumLote;
    qryLoteRemessa.FieldByName('LOT_CODEMP').AsString   := VS_strCodEmp;
    qryLoteRemessa.FieldByName('LOT_CODITE').AsString   := strCodIte;
    qryLoteRemessa.FieldByName('LOT_DTAFAB').Value      := VS_Date;
    qryLoteRemessa.FieldByName('LOT_DTAVAL').Value      := VS_Date;
    qryLoteRemessa.FieldByName('LOT_DTABAL').Value      := VS_Date -1;
    qryLoteRemessa.FieldByName('LOT_SALBAL').AsFloat    := 0;
    qryLoteRemessa.FieldByName('LOT_SALDOS').AsFloat    := 0;
    qryLoteRemessa.FieldByName('LOT_ML_BAL').AsFloat    := 0;
    qryLoteRemessa.FieldByName('LOT_SAL_ML').AsFloat    := 0;
    qryLoteRemessa.FieldByName('LOT_SALCON').Value      := Null;
    qryLoteRemessa.FieldByName('LOT_DIGCON').AsString   := 'N';
    qryLoteRemessa.FieldByName('LOT_ORDCON').Value      := Null;
    qryLoteRemessa.FieldByName('LOT_DIFSAL').AsFloat    := 0;
    qryLoteRemessa.FieldByName('LOT_LOCFIS').AsString   := strLocFis;
    qryLoteRemessa.FieldByName('LOT_AUTREM').AsString   := strNumRem;
    qryLoteRemessa.FieldByName('LOT_TRANSI').AsString   := 'S';
    qryLoteRemessa.Post;
  finally
    FreeAndNil(qryLoteRemessa);
  end;
end;

Function TCadLot.fRetQtdM2LiquidoLote(strCodIte,strCodEmp, strNumLot : String)  : Double;
  Var
    qryLote: TUniQuery;
Begin
  Try
    qryLote := fCriaQuery;

    qryLote.Close;
    qryLote.SQL.Clear;

    qryLote.SQL.Add(' SELECT LOT_MEDL_L * LOT_MEDL_A QTD_M2 FROM CADLOT ');
    qryLote.SQL.Add(' WHERE ');
    qryLote.SQL.Add('      LOT_CODITE = :CODITE ');
    qryLote.SQL.Add('  AND LOT_CODEMP = :CODEMP ');
    qryLote.SQL.Add('  AND LOT_NUMLOT = :NUMLOT ');
    qryLote.SQL.Add('ORDER BY AUTOINCREM');

    qryLote.ParamByName('CODITE').AsString := strCodIte;
    qryLote.ParamByName('CODEMP').AsString := strCodEmp;
    qryLote.ParamByName('NUMLOT').AsString := strNumLot;

    qryLote.Open;
    qryLote.First;

    If Not qryLote.IsEmpty Then
      Result := qryLote.FieldByName('QTD_M2').AsFloat
    Else
      Result := 0;
  Finally
    FreeAndNil(qryLote);
  End;
End;

function TCadLot.fRetSQLLoteItemEmp(strCodIte, strCodEmp: String): String;
begin
  Result := '';
  Result := Result + ' SELECT LOT_NUMLOT ';
  Result := Result + ' FROM CADLOT ';
  Result := Result + ' WHERE LOT_CODITE = ' + QuotedStr(strCodIte);
  Result := Result + '   AND LOT_CODEMP = ' + QuotedStr(strCodEmp);
  Result := Result + '   AND LOT_STATUS = "S" ';
  Result := Result + '   AND LOCATE("A DEFINIR", LOT_NUMLOT) <= 0 ';
end;

{function TCadLot.fTratarSaldoEntregaFutura(qryLote: TUniQuery; AblnJaTemLote: Boolean): Boolean;
var
  blnUsaQtdPen: Boolean;
  qryAux,
  qryIteGer: TUniQuery;
begin
  Result := True;

  blnUsaQtdPen := (Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura;

  If AblnJaTemLote Then
    Exit;

  If Not blnUsaQtdPen Then
    Exit;

  qryAux := fCriaQuery;
  qryIteGer := fCriaQuery;
  Try
    qryIteGer.SQL.Clear;
    qryIteGer.SQL.Add(' SELECT       ');
    qryIteGer.SQL.Add(' ITE_SALDOS + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / I.ITE_CNV_ML, 0) + ' +  IIf(blnUsaQtdPen, fGetSQLSomaCamposEntregaFutura('G'), '0') + ' AS ITE_SALDOS ');
    qryIteGer.SQL.Add(' FROM ITEGER AS G ');
    qryIteGer.SQL.Add(' INNER JOIN CADITE AS I ');
    qryIteGer.SQL.Add('WHERE G.ITE_CODITE = :CODITE ');

    If fUsaRotinaWMS Or (Not fReplicaLote) Then
    qryIteGer.SQL.Add('  AND G.ITE_CODEMP = :CODEMP ');

    If Assigned(qryIteGer.FindParam('CODITE')) Then qryIteGer.ParamByName('CODITE').AsString := qryLote.FieldByName('LOT_CODITE').AsString;
    If Assigned(qryIteGer.FindParam('CODEMP')) Then qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryIteGer.Open;


    If qryIteGer.IsEmpty Then
      Exit;

    qryIteGer.First;
    While Not qryIteGer.Eof Do
    Begin

      qryAux.SQL.Clear;
      qryAux.SQL.Add(' UPDATE CADLOT SET LOT_SALDOS =  :SALDOS ');
      qryAux.SQL.Add(' WHERE LOT_NUMLOT = :LOTE                ');
      qryAux.SQL.Add('   AND LOT_CODITE = :CODITE              ');

      If fUsaRotinaWMS Or (Not fReplicaLote) Then
      qryAux.SQL.Add('  AND LOT_CODEMP = :CODEMP ');

      If Assigned(qryAux.FindParam('CODITE')) Then qryAux.ParamByName('CODITE').AsString := qryLote.FieldByName('LOT_CODITE').AsString;
      If Assigned(qryAux.FindParam('CODEMP')) Then qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryAux.ParamByName('LOTE').AsString := qryTabela.FieldByName('LOT_NUMLOT').AsString;

      qryAux.ParamByName('SALDOS').AsFloat := qryIteger.FieldByName('ITE_SALDOS').AsFloat;

      qryAux.ExecSQL;

      qryIteGer.Next
    End;
  Finally
    FreeAndNil(qryIteGer);
    FreeAndNil(qryAux);
  End;
end;}


function TCadLot.fJaTemLote(strCodIte, strCodEmp: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD FROM CADLOT WHERE LOT_CODITE = :CODITE AND LOT_CODEMP = :CODEMP ');
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;

    qryAux.Open;
    Result := (qryAux.FieldByName('QTD').AsInteger > 0);
  Finally
    FreeAndNil(qryAux);
  End;
end;

class function TCadLot.fBloqueiaTranfSaldoLote(ANumLot, ALocFis, ACodIte, ACodEmp: String; AShwMsg: Boolean = True; ANomLot: String = 'Lote'; ADesconsiderarLocLaborat: Boolean = False): Boolean;
Const
  cMSG_LOTE_BLOQ = 'Não é possível movimentar';
Var
  LqryVerLot: TUniQuery;
  LLCTASE: String;
  LLCTALC: String;
begin
  If (fEmptyStr(ACodEmp)) Then
    ACodEmp := VS_strCodEmp;

  If (fEmptyStr(ANomLot)) Then
    ANomLot := 'Lote';

  Result := False;
  Try
    LLCTASE := fCfgSis('LCTASE');
  Except
    LLCTASE := '';
  End;

  Try
    LLCTALC := fCfgSis('LCTALC');
  Except
    LLCTALC := '';
  End;

  If (Not fEmptyStr(ALocFis)) and ((not ADesconsiderarLocLaborat) or (not SameText(ALocFis, 'LABORAT'))) Then
  Begin
    If (Not fEmptyStr(LLCTASE)) And (Pos(LLCTASE, ALocFis) > 0) Then
    Begin
      If (AShwMsg) Then
        fMensagem('', cMSG_LOTE_BLOQ + ' a Localização Física ' + ALocFis + ' pois a mesma está relacionada na configuração [CFG_LCTASE]!', ['&Ok']);
      Exit(True);
    End;

    If (Not fEmptyStr(LLCTALC)) And (ALocFis = LLCTALC) Then
    Begin
      If (AShwMsg) Then
        fMensagem('', cMSG_LOTE_BLOQ + ' a Localização Física ' + ALocFis + ' pois a mesma está relacionada na configuração [CFG_LCTALC]!', ['&Ok']);
      Exit(True);
    End;

    LqryVerLot := fCriaQuery();
    Try
      LqryVerLot.Close;
      LqryVerLot.SQL.Add('SELECT COUNT(1) AS QTD ');
      LqryVerLot.SQL.Add('FROM CADLOC LOC ');
      LqryVerLot.SQL.Add('INNER JOIN CADLAR LAR ON LOC.AUTOINCREM = LAR.LAR_LOCFIS ');
      LqryVerLot.SQL.Add('WHERE LOC_CODLOC = :CODLOC');
      LqryVerLot.ParamByName('CODLOC').AsString := ALocFis;
      LqryVerLot.Open;

      If (LqryVerLot.FieldByName('QTD').AsInteger > 0) Then
      Begin
        If (AShwMsg) Then
          fMensagem('', cMSG_LOTE_BLOQ + ' a Localização Física ' + ALocFis +
                    ' pois a mesma está relacionada a Locais de Armazenamento do Coletor (Tabela [CADLAR])!', ['&Ok']);
        Exit(True);
      End;
    Finally
      LqryVerLot.Close;
      FreeAndNil(LqryVerLot);
    End;
  End;

  //Verificação do Lote
  If (Not fEmptyStr(ANumLot)) Then
  Begin
    LqryVerLot := fCriaQuery();
    Try
      LqryVerLot.Close;
      LqryVerLot.SQL.Add('SELECT COUNT(1) AS QTD FROM CADLOT ');
      LqryVerLot.SQL.Add('INNER JOIN CADLOC LOC ON LOC_CODLOC = LOT_LOCFIS ');
      LqryVerLot.SQL.Add('WHERE LOT_NUMLOT = :NUMLOT ');
      LqryVerLot.SQL.Add('AND LOT_CODITE = :CODITE ');
      LqryVerLot.SQL.Add('AND LOT_CODEMP = :CODEMP ');

      if ADesconsiderarLocLaborat then
        LqryVerLot.SQL.Add('AND LOC_CODLOC <> "LABORAT" ');

      LqryVerLot.SQL.Add('AND ( ');

      LqryVerLot.SQL.Add('      LOC.AUTOINCREM IN (SELECT LAR_LOCFIS FROM CADLAR LAR WHERE LAR.LAR_LOCFIS = LOC.AUTOINCREM ) ');

      If (Not fEmptyStr(LLCTALC)) Then
        LqryVerLot.SQL.Add('    OR LOC_CODLOC = ' + QuotedStr(LLCTALC));

      If (Not fEmptyStr(LLCTASE)) Then
        LqryVerLot.SQL.Add('    OR LOC_CODLOC LIKE ' + QuotedStr(LLCTASE + '%'));

      LqryVerLot.SQL.Add(')');

      LqryVerLot.ParamByName('NUMLOT').AsString := ANumLot;
      LqryVerLot.ParamByName('CODITE').AsString := ACodIte;
      LqryVerLot.ParamByName('CODEMP').AsString := ACodEmp;
      LqryVerLot.Open;

      If (LqryVerLot.FieldByName('QTD').AsInteger > 0) Then
      Begin
        If (AShwMsg) Then
          fMensagem('', cMSG_LOTE_BLOQ + ' o ' + ANomLot + ' ' + ANumLot +
                  ' pois o mesmo está relacionado às Configurações [CFG_LCTASE]/[CFG_LCTALC] e/ou Locais de Armazenamento do Coletor (Tabela [CADLAR])!', ['&Ok']);
        Exit(True);
      End;

    Finally
      LqryVerLot.Close;
      FreeAndNil(LqryVerLot);
    End;
  End;
end;

end.

