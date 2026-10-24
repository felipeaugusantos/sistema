unit untICadLote;

interface

Uses
 {$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
 {$ELSE}
  UniClientDataSet, EditFocus, Forms, untClassPanelCx,
 {$ENDIF}
  Uni, untTypesSistema, Classes, System.Generics.Collections;

Type
  TLocalizacaoFisicaEmpresaManual = TDictionary<String, String> ;

  ICadLot = Interface
    Function  fExisteLotePrincipalVenda(strCodIte: String; strCodEmp: String): Boolean;
    Function  fExisteLotePrincipalGarantia(strCodIte: String; strCodEmp: String): Boolean;

    Function fSqlLotIte(strCodIte: String): String;
    Function fRetPrecoVendaLote(fltQtdIte: Double; strTabPre: String): Double;
    Function fRetPrecoCustoLote(fltQtdIte: Double): Double;
    function fAtualizaEstoqueLote(strCodIte, strEntSai, strNumLot: String; fltQtdIte: Double; strCodEmp: String = ''; AUsarBatchSaldos: Boolean = False): Boolean;
    Function fExisteLote(strCodIte, strCodEmp: String; strNumLot: String = '';
                         blnSalPos: Boolean = True; blnSoAtivo: Boolean = True;
                         blnDifADefinir: Boolean = False): Boolean;

    Function fItemSemNenhumLote(strCodIte: String): Boolean;

   {$IFDEF LINUX}
   {$ELSE}
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
                                bnlMovimentacaoProgramada: Boolean = False;
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
                                blnNaoExibeLotTransi : Boolean = False): Boolean;

   {$ENDIF}

    function fRetArmazemPrincipalOrcamentoPedidoVenda(strCodIte: String): String;
    function fRetArmazemPrincipalVenda(strCodIte: String; strCodEmp : String = ''): String;
    function fRetArmazemPrincipalCompra(strCodIte: String): String;
    function fRetArmazemPrincipalGarantia(strCodIte: String): String;

    Function fSaldoLote(strCodIte, strCodEmp, strNumLot: String): Double;
    Function fZeraContagemLote(strArmazens: string; strCodIte: String; blnLimpar: Boolean = True; strFilExt: string = ''; event_Parametros: TSetaParametros = nil; AblnAtualizaIteger: Boolean = True):Boolean; overload;   {Req. 456948-B - B8: blnTableTmp removido; B4: AblnAtualizaIteger}
    Function fZeraContagemLote(blnLimpar: Boolean = True; strFilExt : String = ''; event_Parametros: TSetaParametros = nil): Boolean; overload;
    {Req. 456948-B - B3}
    function fZeraContagemLoteRodada(const AstrConId, AstrCodCon: String): Boolean;


    Function fIncluiLote(cdsSalLot: TUniClientDataSet): Boolean;

    Function fGeraLoteEmpresas(qryLote: TUniQuery; blnCriaEmpresasWms : Boolean = False; blnBaixaOPI: Boolean = False; AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual = Nil): Boolean;

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
                                  strNumLot: String = ''): Boolean;

    Function fTemLocFisicaComArmazem(strCodAmz: String;
                                     Var strLocFis: String): Boolean;

    function fAtualizaLocFisica(strCodAmzAnt, strCodAmzAtu, strCodLoc: String): Boolean;
    function fTemMovimentacaoLocFisica(strCodAmz, strLocFis: String): Boolean;

    Function fTrocaLocFisica(strCodIte, strNumLot, strLocFis: String): Boolean;

    procedure pZerarLotesSemNecessidadeCalc(AFunctionGetFiltros: TFunctionGetFiltros = nil; AProcSetarParametros: TProcSetarParametros = nil);
    procedure pZeraContagemLote(strCodIte: String);
    Procedure pAjustaArmPrincipalVenda(qryCadLot: TUniQuery);
    Procedure pAjustaArmPrincipalCompra(qryCadLot: TUniQuery);
    Procedure pAjustaArmPrincipalGarantia(qryCadLot: TUniQuery);
    Procedure pAjustaArmPrincipalProducao(qryCadLot: TUniQuery);
    procedure pExcluirLoteTodasEmpresas(strCodIte, strNumLot, strNomForm: String);

    procedure pStepStatusGravacao;
    Procedure pFinalizaStatusGravacao;

    function fAtualizaLoteMovDet(strTabela, strAutInc, strNumLot : String): Boolean;
    function fTrocarLote(strTabela, strAutInc, strLotAtu, strLotNov, strCodIte : String; fltQtdIte: Double; strCodEmp: String = ''): Boolean;
    function fGetStrTitLab : String;

    Property strTitLab: String Read fGetStrTitLab;

End;

implementation

end.
