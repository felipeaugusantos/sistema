unit untFuncoesPedido;

interface

uses  SysUtils, DB, Uni, Forms, Controls, DateUtils, Math, Classes, Graphics,
      UniClientDataSet, StrUtils, untConsultaCds, Variants, Dialogs, UniDataSetProvider,
      untFuncoesSimples, Printers, EditFocus, DBEditFocus, ExtCtrls, StdCtrls,
      frxClass, frxDBSet, frxDMPExport, frxDMPClass,
      cxProgressBar, untZClient, untTypesSistema, untFuncoesPedidoSimples, dxCore,
      untSalvaDadosGiro, untRecuperaPedido, untTEditFocusWithTConsultasArray, untTLayoutPedidoCompra, TypesLayoutPedidoCompra;

type

  TFuncaoGiro = (fugRealizaCalculosGiro, fugSintetizaItensMultiLojas, fugCalculaGiroEstoque,
                 fugExecutaSQLGiroEstoque, fugAbrePedido, fugLendoItegerSintetizaItensMultiLojas,
                 fugLendoItegerItensSemGiro, fugExecutaSQLCarregarPedMultiLojas, fugIndexandoTabela,
                 fugCalculaSalResPedido, fugCalculaVendasPerdidas, fugCalculaSalResGarantia);

  TTipoSaldo = (salPedido, salTransfererncia, salEnderecamento);

  TGiroPedido = Class(TObject)

    FOpcGir: TRecOpcoesGiro;
    opcChamada: TOpcaoChamadaGiro;

    strEmpDesSpool: String;
    strEmpOriSpool: String;

    blnLibPcm,
    blnDiaSai,
    blnEntIte,
    blnGeraAuto,
    blnSitPro,
    blnCorIpd,
    blnSitEmp: Boolean;

    FstrEmpSel: String;

    objRecupera: TRecuperaPedido;

    pgbProgresso: TcxProgressBar;

    cdsVenPer: TUniQuery;
    cdsSalCot: TUniQuery;

    blnEncontrouGiro: Boolean;

    dtaDataBase: TDateTime;
    cdsItensPed,
    cdsItensMultLojas: TUniClientDataSet;
    strCodGru,
    strCodFor,
    strCodMar,
    strPrdGru,
    strGruCmp,
    strSitPro,
    strUnidade,
    strCodDep: String;
    intDiaVen: integer;
    strAcoObj,
    strRefere,
    strDesIte,
    strLocIni,
    strLocFin: String;

    intOpcGir: Integer;
    strFilGir: String;
    intQtdMes,
    intMesMos: Integer;
    blnMedAju,
    blnAllIte,
    blnArredSug,
    blnConsMCom,
    blnEmbala,
    blnConsTLoj,
    blnConsEMin,
    blnConsEMax,
    blnConsPedPen,
    blnConsRequisicao,
    blnConsPedPenTransferencia,
    blnDesconsPedGar,
    blnConsPedVen,
    blnDescSalExt,
    blnVenPer,
    blnVenPerMed,
    blnConsEndere,
    blnConsOrdPro,
    blnConsGarPen,
    blnConsMesAtu,
    blnConsCot,
    blnConsTransf,

    blnEntFutPrevisao,
    blnEntFutFalta,
    blnEntFutAguarda,

    blnAgrSim,
    blnAteMax,
    blnPonPed: Boolean;

    intDiaPedVen,
    intOrdem: Integer;
    strPedMlj,
    strNumPed,
    strEspPed,
    strEmpPed,
    strEmpOri: String;
    strEmpUsada: String;
    strEmpSubtraiPedTransf: String;
    blnAnalisaITEFOR: Boolean;
    arrCodFor,
    arrLinhaGrupo,
    arrMarca,
    arrPrdGru,
    arrGruCmp,
    arrSitPro,
    arrUnidade,
    arrCodDep: TConsultasArray;
    strEmpAgr: String;
    blnSugInd: Boolean;
    cdsEmpresasSel: OleVariant;

    slfLocFis: TSelecaoLocFisica;

    slsSaldosDestino,
    slsSaldos: TSelecaoSaldos;

    strCodCmp: String;
    strCodDig: String;

    blnEntBrf: Boolean;

    strFRMPCM: String;

    stlMeses : TStringList;

    strCodTab: String;
    strGirEmp: String;

    strNumPedAlt,
    strEmpPedAlt,
    strEspPedAlt: String;

    strTableSimilar: String;

    Function fSQLCamposGirIte: String;
    Function fSQLCamposSumGirIte: String;

    Procedure pIncluiSimilares;

    function fSQLFromPedidoMultiloja(blnRecupera: Boolean; strEmpGir: string): String;
    function fSQLWherePedidoMultiloja(blnRecupera: Boolean; strEmpGir: string): String;

    Function fSQLPedidoMultiloja(blnRecupera: Boolean; strEmpGir: string): String;

    Function fSQLCriaTempSimilarPedidoMultiloja(strEmpGir: string): String;

    function fSelecionouMesAtual: Boolean;
    function fRetQuantidadeDias(intQtdMes: Integer): Integer;
    function fRetMes(intContador: Integer): Integer;
    function fRetAno(intContador: Integer): Integer;
    function fRetAnos: String;

    function fRetQtdVenPerCons(strCodIte, strCodEmp, strNivGir: String): Double;
    function fRetQtdVenPer(strCodIte, strCodEmp, strNivGir: String): Double;

    function fRetQtdCotacaoCons(strCodIte, strCodEmp: String): Double;
    function fRetQtdCotacao(strCodIte, strCodEmp: String): Double;

    Function fSQLCodItemPrincipal: String;

    function fSQLPedidoVendaPend: String;

    Function fCarregaVendasPerdidas(strEmpSel, strEmpCal: String): Boolean;

    Function fCarregaSaldoCotacao(strEmpSel, strEmpCal, strCodEmp: String): Boolean;

    Function fExecutaFuncao(tfgFuncaoGiro: TFuncaoGiro): Boolean;

    function fCalcularMultiploNaEmpresaCentralizadora(strCprCen: String): Boolean;

    function fCalculaGiroEstoqueAux: Boolean;
    procedure pTranformLocate(var texto: string);
    function fRetTodasEmpresas: String;

    Function fGPCalculaGiroEstoque(pgbProgressoP: TcxProgressBar): Boolean;

    Procedure pSetaNomeFuncao(tfgFuncaoGiro: TFuncaoGiro);

    Procedure pCriaTabelaFiltroItem(strEmpSel, strEmpCal: String;  blnAnalisaIteFor: Boolean);

    Procedure pSetaParCalculaGiroEstoque(recOpcGirP: TRecOpcoesGiro;
                                         dtaDataBaseP: TDateTime;
                                         cdsItensPedP,
                                         cdsItensMultLojasP: TUniClientDataSet;
                                         strCodGruP,
                                         strCodForP,
                                         strCodMarP,
                                         strPrdGruP,
                                         strGruCmpP,
                                         strSitProP,
                                         strUnidadeP,
                                         strCodDepP: String;
                                         intDiaVenP: integer;
                                         strAcoObjP,
                                         strRefereP,
                                         strDesIteP: String;
                                         intOpcGirP: Integer;
                                         strFilGirP: String;
                                         intQtdMesP,
                                         intMesMosP: Integer;
                                         blnAnalisaITEFORP,
                                         blnAllIteP,
                                         blnArredSugP,
                                         blnConsMComP,
                                         blnEmbalaP,
                                         blnConsTLojP,
                                         blnConsEMinP,
                                         blnConsEMaxP,
                                         blnConsRequisicaoP,
                                         blnConsPedPenP,
                                         blnConsPedPenTransferenciaP,
                                         blnDesconsPedGarP,
                                         blnConsPedVenP,
                                         blnDescSalExtP,
                                         blnConsMesAtuP,
                                         blnConsOrdProP,
                                         blnConsGarPenP,
                                         blnConsTransfP,
                                         blnConsCotP: Boolean;
                                         intDiaPedVenP,
                                         intOrdemP: Integer;
                                         strPedMljP,
                                         strNumPedP,
                                         strEspPedP,
                                         strEmpPedP,
                                         strEmpOriP: String;
                                         strEmpUsadaP: String;
                                         strEmpSubtraiPedTransfP: String;
                                         arrCodForP,
                                         arrLinhaGrupoP,
                                         arrMarcaP,
                                         arrPrdGruP,
                                         arrGruCmpP,
                                         arrSitProP,
                                         arrUnidadeP,
                                         arrCodDepP: TConsultasArray;
                                         strEmpAgrP: String;
                                         blnSugIndP: Boolean;
                                         cdsEmpresasSelP: OleVariant;
                                         slfLocFisP: TSelecaoLocFisica;
                                         slsSaldosP: TSelecaoSaldos;
                                         strCodCmpP,
                                         strCodDigP,
                                         strGirEmpP: String);

    Function fExecutaSQLGiroEstoque(qryGenGir: TUniQuery; strAnoIni, strAnoFim,
      strCodEmp, strCodGru, strCodFor, strCodMar, strPrdGru, strGruCmp, strSitPro, strUnidade, strCodDep: string; intDiaVen: Integer; strAcoObj, strRefere, strDesIte, strCodCmp: String; ArrCodFor, arrLinhaGrupo, arrMarca, arrPrdGru, arrGruCmp, arrSitPro, arrUnidade, arrCodDep: TConsultasArray;
      cdsEmpresasSel: OleVariant;
      slfLocFis: TSelecaoLocFisica = slfTodas; slsSaldos: TSelecaoSaldos = slsTodos): Boolean;

    Function fExecutaSQLCarregarPedMultiLojas(qryGenGir: TUniQuery; strAnoIni, strAnoFim,
      strCodEmp, strCodGru, strCodFor, strCodMar, strPrdGru, strGruCmp, strSitPro, strUnidade, strCodDep: string; intDiaVen: integer; strAcoObj, strRefere, strDesIte, strNumPed, strEspPed, strCodCmp: String;
      arrCodFor, arrLinhaGrupo, arrMarca, arrPrdGru, arrGruCmp, arrSitPro, arrUnidade, arrCodDep: TConsultasArray;strEmpGir: string; cdsEmpresasSel: OleVariant): Boolean;

    Procedure pAjustaCompraCentraLizada(fltSomaCprCen, fltSomaCprCenCal,fltSomaCprTot,fltExtExc: Double;
                                        cdsItensMultiLojas, cdsItensPed: TUniClientDataSet; intDecUni: Integer;
                                        blnSetarSug: Boolean = True);

    Function fSQLFiltros(strEmpSel, strEmpCal: String; blnIteFor: Boolean =  False): String;
    function fEmpresaCentralizadora(ACodEmp: String): Boolean;
    Function fPedidoMultiLojaPorNivelAgregadaPorEmpresaComCalculoGlobal_E_NivelGiroPorEmpresa(strPedMlj, strEmpAgr: string; recNivEst: TRecOpcoesNivel; blnSugInd: Boolean ): Boolean;

    Function fSintetizaItensMultiLojas(strCodFor: String; cdsItensPed, cdsItensMultiLojas: TUniClientDataSet;
      intQtdMes, intMesMos: Integer;
      blnAnalisaITEFOR, blnAllIte, blnConsMCom, blnArredSug, blnConsRequisicao, blnConsPedPen, blnConsPedVen, blnDescSalExt, blnConsEMin, blnConsEMax,
      blnConsTLoj, blnConsOrdPro, blnConsGarPen, blnConsTransf, blnConsCot: Boolean;
      stlItensGiro: TStringList;
      strPedMlj, strEmpAgr: String;  blnSugInd: Boolean;
      cdsEmpresasSel: OleVariant;
      qryGenGir: TUniQuery;
      dtaDataBase: TDate;
      arrCodFor,
      arrLinhaGrupo,
      arrMarca,
      arrPrdGru,
      arrGruCmp,
      arrSitPro,
      arrUnidade,
      arrCodDep: TConsultasArray;
      strCodGru,
      strCodMar,
      strPrdGru,
      strGruCmp,
      strSitPro,
      strUnidade,
      strCodDep: String;
      intDiaVen: integer;
      strAcoObj,
      strRefere,
      strDesIte: String): Boolean;

    Function fGetValorGirIte(qryGenGir: TUniQuery; strNomCam: String): Double;

    function fRealizaCalculosGiro(dtaDataBase: TDateTime; cdsItensPed: TUniClientDataSet; qryGenGir: TUniQuery;
      blnConsEMin, blnConsEMax, blnConsMCom, blnArredSug, blnConsRequisicao, blnConsPedPen, blnConsPedVen, blnDescSalExt, blnConsMesAtu, blnConsOrdPro,
      blnConsGarPen, blnConsTransf, blnConsCot: Boolean;
      intQtdMes, intMesMos: Integer; blnAltPed, blnAllIte: Boolean;
      strFilGir: String; strCodFor, strEmpCal: String): Boolean;

  Public

    blnEmpVis : Boolean;
    strTableNameFILTRO_ITEM: String;

    strNumPedUmaLoja,
    strCodEmpUmaLoja,
    strSeqCot: String;

    recNivEst: TRecOpcoesNivel;

    Constructor Create;
    Destructor Destroy; override;

    function fCalculaGiroEstoque(    recOpcGirP: TRecOpcoesGiro;
                                     dtaDataBaseP: TDateTime;
                                     cdsItensPedP,
                                     cdsItensMultLojasP: TUniClientDataSet;
                                     strCodGruP,
                                     strCodForP,
                                     strCodMarP,
                                     strPrdGruP,
                                     strGruCmpP,
                                     strSitProP,
                                     strUnidadeP,
                                     strCodDepP: String;
                                     intDiaVenP: Integer;
                                     strAcoObjP,
                                     strRefereP,
                                     strDesIteP: String;
                                     intOpcGirP: Integer;
                                     strFilGirP: String;
                                 Var intQtdMesP,
                                     intMesMosP: Integer;
                                     blnAnalisaITEFORP,
                                     blnAllIteP,
                                     blnArredSugP,
                                     blnConsMComP,
                                     blnEmbalaP,
                                     blnConsTLojP,
                                     blnConsEMinP,
                                     blnConsEMaxP,
                                     blnConsRequisicaoP,
                                     blnConsPedPenP,
                                     blnConsPedPenTransferenciaP,
                                     blnDesconsPedGarP,
                                     blnConsPedVenP,
                                     blnDescSalExtP,
                                     blnConsMesAtuP,
                                     blnConsOrdProP,
                                     blnConsGarPenP,
                                     blnConsTransfP,
                                     blnConsCotP: Boolean;
                                     intDiaPedVenP,
                                     intOrdemP: Integer;
                                     strPedMljP,
                                     strNumPedP,
                                     strEspPedP,
                                     strEmpPedP,
                                     strEmpOriP: String;
                                 Var strEmpUsadaP: String;
                                     strEmpSubtraiPedTransfP: String;
                                     arrCodForP,
                                     arrLinhaGrupoP,
                                     arrMarcaP,
                                     arrPrdGruP,
                                     arrGruCmpP,
                                     arrSitProP,
                                     arrUnidadeP,
                                     arrCodDepP: TConsultasArray;
                                     strEmpAgrP: String;
                                     blnSugIndP: Boolean;
                                     cdsEmpresasSelP: OleVariant;
                                     slfLocFisP: TSelecaoLocFisica;
                                     slsSaldosP: TSelecaoSaldos;
                                     strCodCmpP: String;
                                     strCodDigP: String;
                                     strGirEmp: string): Boolean;

  End;

function fRetEmpresasSel(cdsEmpSel: TUniClientDataSet; strCampo: String; blnIncluirMarcados: Boolean = True): String;

function fElevaConsumiveis(fltQtdIte, fltPerCon: Double; strClaCRM: String): Double;

Function fSQLCamposPrecoCusto(strCodFor: String): String;
function fSqlWhereTabPre(strPrF_AE, strCodTab : String ): String;

function fCarregaPedidoDeCompraMultiLojas(Var recOpcoesGiro: TRecOpcoesGiro;
                                              cdsItensPed,
                                              cdsItensMultLojas: TUniClientDataSet;
                                              strNumPed,
                                              strEspDoc,
                                              strCodEmp: String;
                                          Var strEmpUsadaGiro: String;
                                              cdsEmpresasSel: OleVariant;
                                              strSeqCot: String = ''): Boolean;

function fCalculaGiroEstoque(    recOpcGir: TRecOpcoesGiro;
                                 opcChamada: TOpcaoChamadaGiro;
                                 dtaDataBase: TDateTime;
                                 cdsItensPed,
                                 cdsItensMultLojas: TUniClientDataSet;
                                 strCodGru,
                                 strCodFor,
                                 strCodMar,
                                 strPrdGru,
                                 strGruCmp,
                                 strSitPro,
                                 strUnidade,
                                 strCodDep: string;
                                 intDiaVen: integer;
                                 strAcoObj,
                                 strRefere,
                                 strDesIte,
                                 strLocIni,
                                 strLocFin: String;
                                 intOpcGir: Integer;
                                 strFilGir: String;
                             Var intQtdMes,
                                 intMesMos: Integer;
                                 blnAnalisaITEFOR,
                                 blnMedAju,
                                 blnAllIte,
                                 blnArredSug,
                                 blnConsMCom,
                                 blnEmbala,
                                 blnConsTLoj,
                                 blnConsEMin,
                                 blnConsEMax,
                                 blnConsRequisicao,
                                 blnConsPedPen,
                                 blnConsPedPenTransferencia,
                                 blnDesconsPedGar,
                                 blnConsPedVen,
                                 blnDescSalExt,
                                 blnConsMesAtu,
                                 blnConsOrdPro,
                                 blnConsGarPen,
                                 blnConsTransf,
                                 blnConsCot,
                                 blnVenPer,
                                 blnVenPerMed,
                                 blnConsEndere,
                                 blnPonPed,
                                 blnAteMax,
                                 blnAgrSim,
                                 blnEntFutPrevisao,
                                 blnEntFutFalta,
                                 blnEntFutAguarda: Boolean;
                                 intDiaPedVen,
                                 intOrdem: Integer;
                                 strPedMlj,
                                 strNumPed,
                                 strEspPed,
                                 strEmpPed,
                                 strEmpOri: String;
                             Var strEmpUsada: String;
                                 strEmpSubtraiPedTransf: String;
                                 arrCodFor,
                                 arrLinhaGrupo,
                                 arrMarca,
                                 arrPrdGru,
                                 arrGruCmp,
                                 arrSitPro,
                                 arrUnidade,
                                 arrCodDep: TConsultasArray;
                                 strEmpAgr: String;
                                 blnSugInd: Boolean;
                                 cdsEmpresasSel: OleVariant;
                                 recNivEst: TRecOpcoesNivel;
                                 slfLocFis: TSelecaoLocFisica;
                                 strCodTab: String;
                                 slsSaldos,
                                 slsSaldosDestino: TSelecaoSaldos;
                                 strCodCmp: String;
                                 strCodDig: String;
                                 Var strMeses: String;
                                 strSeqCot: String = '';
                                 strNumPedUmaLj: String = '';
                                 strCodEmpUmaLj: String = '';
                                 objRecupera: TRecuperaPedido = Nil;
                                 blnGeraAuto: Boolean = False;
                                 strGirEmp: string = '';
                                 blnEncontrouGiro: Boolean = False;
                                 strNumPedAlt: string = '';
                                 strEmpPedAlt: string = '';
                                 strEspPedAlt: String = ''): Boolean;

function fCalculaSugestaoCompra(intQtdMes,
                                intDiaCom: Integer;
                                fltQtdSai,
                                fltQtdReq,
                                fltQtdPen,
                                fltSalRes,
                                fltOrdPro,
                                fltSalFis,
                                fltEstMin,
                                fltEstMax,
                                fltMltCom,
                                fltQtdGar,
                                fltSalTransf,
                                fltSalCot,
                                fltVenPer,
                                fltSalExt,
                                fltPerCon,
                                fltPonPed,
                                fltEntAgu,
                                fltEntFal,
                                fltEntPre: Double;
                                blnConsRequisicao,
                                blnConsPedPen,
                                blnConsPedVen,
                                blnDescSalExt,
                                blnConsEMin,
                                blnConsEMax,
                                blnConsMCom,
                                blnArredSug,
                                blnConsOrdPro,
                                blnConsGarPen,
                                blnConsTransf,
                                blnConsCot,
                                blnVenPer,
                                blnVenPerMed,
                                blnConsEndere,
                                blnPonPed,
                                blnAteMax,
                                blnEntFutPrevisao,
                                blnEntFutFalta,
                                blnEntFutAguarda: Boolean;
                                strClaCrm: String;
                                Var blnAbaixoPonPed: Boolean;
                                Var fltQtdCal: Double): Double;

function fCalculaSugestaoAgregada(strEmpAgr: String; blnSugInd: Boolean): Boolean;
function fConsidera_EmpAgr_Vazio(ValEmpGer: String): boolean;

procedure pImprimePedidoCompra(strNumPed,
                               strEspDoc,
                               strCodEmp: String); stdcall;

procedure pImprimirPedido(RecOpcaoImpressao: TRecOpcaoImpressao;
                          strNumPed,
                          strEspDoc,
                          strCodEmp: String;
                      var strPath: string;
                      var strNomeFila: string;
                      var strTipImp: string;
                          blnReimpr: Boolean = False;
                          strCondPagBosh: string = '';
                          blnEsconderMensagem: boolean = False;
                          blnVeSePodeImprimir: Boolean = True;
                          blnCarregarFila: Boolean = True;
                          blnExcRes: Boolean = False);

procedure pImprimirOrdemCarregamento(strNumPed,
                                     strEspDoc,
                                     strCodEmp: String;
                                     intQtdImp: Integer = 1;
                                     blnReimpr: Boolean = False;
                                     blnOrdDig : Boolean = True);

function fVerificaPedidoBaixado(strNumPed, strEspDoc, strCodEmp: String; Var blnConferido: Boolean; Var AblnOrcamentoGeradoAutomaticamente: Boolean): Boolean;
function fVerificaPedidoBaixadoOuBaixaParcial(strNumPed, strEspDoc, strCodEmp: String): Boolean;

function fConsultaClientDataSet(Sender: TForm; cdsDataset: TUniClientDataSet; strNomeTabela: String;
  stlCampos, stlIndices: TStringList; strCaption: String = ''; frmConsulta: TfrmConsultaCds=Nil): TBookmark;

procedure pReaplicaMascara(cdsDataSet: TUniClientDataSet);

function fChamaCalculoGiro(var recOpcoesGiro: TRecOpcoesGiro;
                               blnCarregandoPedido: Boolean;
                               blnShow: Boolean = True;
                               blnConsulta: Boolean = False): Boolean;

function fRetornaCSTFornecedor(strCodFor, strCodIte: String; Var strCodSitOrigem: String): String;

procedure pCarregaEmpresasMlj(cdsEmpMlj: TUniClientDataSet);

procedure pRetstrPath(var strPath: string; intOpcao: Integer = 0);

Function fLePrecoCompraFornecedor(qryIteFor: TUniQuery; strCodFor, strCodIte, strCodEmp, strSqlWhereTabPre: String; blnConvert: Boolean): Boolean;
Function fTemItemPrecoFornecedor(strCodFor, strCodIte, strCodEmp, strSqlWhereTabPre: String; blnConvert: Boolean): Boolean;

procedure pAjustaTamanhoCampos(stlTexto: TStringList);
Function fCarregaObservPedido: TStringList;
procedure pGeraXML(blnExcelResumido: Boolean = False);
function fRetornaSQLCodigoFabricaProduto(const strTipFab, strEmpDes: String): String;
function fAliquotaPisCofinsProduto(ACodIte: String; APis: Boolean; ACFOP: string = '1102'): Double;

Var
  arrCampos: TarrCamposPedCompra;
  arrCamposAgg: TarrCamposAggPedCompra;
  objSalvaInterface: TSalvaInterfaceGiro;
  GlobalrecOpcoesGiro: TRecOpcoesGiro;

implementation

uses untGravando, untConstantes, untSaldoPedidoCompra,
     untPedidoCompraTXT,
     untFuncoesConsulta, RLReport, untCfgRel, untDigGiroEstoque,
     untQckBoletimRec, untModuloOrdemCarreg, untGeraExcel,
     untNotificaAtivacaoTabPreFor, untFornecedorBosh, untPnlDadosPedCompra,
  untMensagemExplicativa, untPesqAux, untFuncoesRel, untFuncoesRel2,
   untOpcPdfPedidoCompra;

{*****************************************}
{* CARREGA UM PEDIDO QUANDO USA MULTI-   *}
{* LOJAS.                                *}
{**************************************MV*}
function fCarregaPedidoDeCompraMultiLojas(Var recOpcoesGiro: TRecOpcoesGiro;
                                              cdsItensPed,
                                              cdsItensMultLojas: TUniClientDataSet;
                                              strNumPed,
                                              strEspDoc,
                                              strCodEmp: String;
                                          Var strEmpUsadaGiro: String;
                                              cdsEmpresasSel: OleVariant;
                                              strSeqCot: String = ''): Boolean;
  Var
   strCodFor : String;
begin
  if fCfgSis('PRF_AE', varString) = 'E' Then
  Begin
    strCodFor := fCampoTabela('PCG_CODFOR', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC', 'PCG_CODEMP'], [strNumPed, strEspDoc, strCodEmp]);
    Result := TfrmNotificaAtivacaoTabPreFor.fEscolheTabelaAUtilizar( strCodFor, recOpcoesGiro.strCodTab);
    If not Result Then
      Exit;
  End;

  With recOpcoesGiro Do
  Result := fCalculaGiroEstoque(recOpcoesGiro,
                                opcChamada,
                                dtaDataBaseGir,
                                cdsItensPed,
                                cdsItensMultLojas,
                                strCodGru,
                                strCodFor,
                                strCodMar,
                                strPrdGru,
                                strGruCmp,
                                strSitPro,
                                strUnidade,
                                strCodDep,
                                intDiaVen,
                                strAcoObj,
                                strRefere,
                                strDesIte,
                                strLocIni,
                                strLocFin,
                                intOpcGir,
                                strFilGir,
                                intMesGir,
                                intMesMos,
                                blnAnalisaITEFOR,
                                blnMedAju,
                                blnAllIte,
                                blnArredSug,
                                blnConsMCom,
                                blnEmbala,
                                blnConsTLoj,
                                blnConsEMin,
                                blnConsEMax,
                                blnConsRequisicao,
                                blnConsPedPen,
                                blnConsPedPenTransferencia,
                                blnDesconsPedGar,
                                blnConsPedVen,
                                blnDescSalExt,
                                blnConsMesAtu,
                                blnConsOrdPro,
                                blnConsGarPen,
                                blnConsTransf,
                                blnConsCot,
                                blnVenPer,
                                blnVenPerMed,
                                blnConsEndere,
                                blnPonPed,
                                blnAteMax,
                                blnAgrSim,
                                blnEntFutPrevisao,
                                blnEntFutFalta,
                                blnEntFutAguarda,
                                intDiaPedVen,
                                intOrdem,
                                'S',
                                strNumPed,
                                strEspDoc,
                                strCodEmp,
                                '%',
                                strEmpUsadaGiro,
                                strEmpSubtraiPedTransf,
                                arrCodFor,
                                arrLinhaGrupo,
                                arrMarca,
                                arrPrdGru,
                                arrGruCmp,
                                arrSitPro,
                                arrUnidade,
                                arrCodDep,
                                '',
                                True,
                                cdsEmpresasSel,
                                recNivEst,
                                slfLocFis,
                                strCodTab,
                                slsSaldos,
                                slsSaldosDestino,
                                strCodCmp,
                                strCodDig,
                                strMeses,
                                strSeqCot,
                                '', // strNumPedUmaLj: String = '';
                                '', // strCodEmpUmaLj: String = '';
                                objRecupera,
                                False,
                                strEmpGir,
                                Assigned(objSalInt) And objSalInt.blnEncontrouGiro,
                                strNumPedAlt,
                                strEmpPedAlt,
                                strEspPedAlt);
end;

function fSqlWhereTabPre(strPrF_AE, strCodTab : String ): String;
begin
  if fEmptyStr(strPrF_AE) Then
    strPrF_AE := fCfgSis('PRF_AE', varString);

  Result := IfThen((strPrF_AE = 'A') Or fEmptyStr(strCodTab), ' TAB_ATICMP = "S" ', IfThen( strCodTab = 'ITEGER', ' FALSE ', ' TAB_CODTAB = ' + QuotedStr(strCodTab) ));
end;

Function fSQLCamposPrecoCusto(strCodFor: String): String;
  Var
    strSQL,
    strDesIte: String;
Begin
  If (fCfgSis('REFPED', varBoolean)) Then
    strDesIte := strDesIte + '  CONCAT(C.ITE_DESITE, IF(C.ITE_REFERE IS NOT NULL AND C.ITE_REFERE <> "", CONCAT(" - ", C.ITE_REFERE), "")) '
  Else
    strDesIte := strDesIte + '  C.ITE_DESITE ';

    strSQL := strSQL + ' ITE_PRAVAL, ';
  // DADOS QUE PODEM VIR DO PREÇO POR FORNECEDOR
  If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') And fCfgSis('TABPRF', varBoolean) Then
  Begin
    strSQL := strSQL + ' F.ITE_CODTAB, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_DESF01, D.ITE_DESF01) AS ITE_DESF01, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_DESF02, D.ITE_DESF02) AS ITE_DESF02, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_DESF03, D.ITE_DESF03) AS ITE_DESF03, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_DESF04, D.ITE_DESF04) AS ITE_DESF04, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_DESF05, D.ITE_DESF05) AS ITE_DESF05, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_DESF06, D.ITE_DESF06) AS ITE_DESF06, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) AS ITE_PRECOM, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_PRECUS, D.ITE_PRECUS / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) AS ITE_PRECUS, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_IPIENT, D.ITE_IPIENT) AS ITE_PERIPI, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_SUBSTI, D.ITE_SUBSTI) AS ITE_PERSUB, ';
    strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, I.ITE_ACRFIN, D.ITE_ACRFIN) AS ITE_ACRFIN, ';
    strSQL := strSQL + ' IF(IFNULL(F.ITE_CLAIPI, "") = "", C.ITE_CLAIPI, F.ITE_CLAIPI) AS ITE_CLAIPI, ';
    strSQL := strSQL + ' IF((F.ITE_CODITE IS NULL) OR IFNULL(F.ITE_DESFAB, "") = "", ' + strDesIte + ', F.ITE_DESFAB) AS ITE_DESITE, ';

    strSQL := strSQL + ' IF(F.ITE_CODITE IS NULL, IF(IFNULL(C.ITE_MLTCOM, 0) <> 0, C.ITE_MLTCOM, 1), ';
    strSQL := strSQL + '                          IF(IFNULL(F.ITE_MLTCOM, 0) <> 0, F.ITE_MLTCOM, 1)) AS ITE_MLTCOM, ';
  End Else
  Begin
    strSQL := strSQL + ' CAST(NULL AS CHAR(6)) AS ITE_CODTAB, ';
    strSQL := strSQL + ' I.ITE_DESF01, ';
    strSQL := strSQL + ' I.ITE_DESF02, ';
    strSQL := strSQL + ' I.ITE_DESF03, ';
    strSQL := strSQL + ' I.ITE_DESF04, ';
    strSQL := strSQL + ' I.ITE_DESF05, ';
    strSQL := strSQL + ' I.ITE_DESF06, ';
    strSQL := strSQL + ' I.ITE_PRECOM, ';
    strSQL := strSQL + ' I.ITE_PRECUS, ';
    strSQL := strSQL + ' I.ITE_IPIENT AS ITE_PERIPI, ';
    strSQL := strSQL + ' I.ITE_SUBSTI AS ITE_PERSUB, ';
    strSQL := strSQL + ' I.ITE_ACRFIN, ';
    If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
      strSQL := strSQL + ' IF(IFNULL(F.ITE_CLAIPI, "") = "", C.ITE_CLAIPI, F.ITE_CLAIPI) AS ITE_CLAIPI, '
    Else
      strSQL := strSQL + '  C.ITE_CLAIPI AS ITE_CLAIPI, ';
    strSQL := strSQL +  strDesIte + ' AS ITE_DESITE, ';
    strSQL := strSQL + ' IF(IFNULL(C.ITE_MLTCOM, 0) <> 0, C.ITE_MLTCOM, 1) AS ITE_MLTCOM, ';
  End;

  Result := strSQL;
End;

{*****************************************}
{* CALCULA O GIRO DE ESTOQUE.            *}
{**************************************MV*}
function fCalculaGiroEstoque(    recOpcGir: TRecOpcoesGiro;
                                 opcChamada: TOpcaoChamadaGiro;
                                 dtaDataBase: TDateTime;
                                 cdsItensPed,
                                 cdsItensMultLojas: TUniClientDataSet;
                                 strCodGru,
                                 strCodFor,
                                 strCodMar,
                                 strPrdGru,
                                 strGruCmp,
                                 strSitPro,
                                 strUnidade,
                                 strCodDep: String;
                                 intDiaVen: integer;
                                 strAcoObj,
                                 strRefere,
                                 strDesIte,
                                 strLocIni,
                                 strLocFin: String;
                                 intOpcGir: Integer;
                                 strFilGir: String;
                             Var intQtdMes,
                                 intMesMos: Integer;
                                 blnAnalisaITEFOR,
                                 blnMedAju,
                                 blnAllIte,
                                 blnArredSug,
                                 blnConsMCom,
                                 blnEmbala,
                                 blnConsTLoj,
                                 blnConsEMin,
                                 blnConsEMax,
                                 blnConsRequisicao,
                                 blnConsPedPen,
                                 blnConsPedPenTransferencia,
                                 blnDesconsPedGar,
                                 blnConsPedVen,
                                 blnDescSalExt,
                                 blnConsMesAtu,
                                 blnConsOrdPro,
                                 blnConsGarPen,
                                 blnConsTransf,
                                 blnConsCot,
                                 blnVenPer,
                                 blnVenPerMed,
                                 blnConsEndere,
                                 blnPonPed,
                                 blnAteMax,
                                 blnAgrSim,
                                 blnEntFutPrevisao,
                                 blnEntFutFalta,
                                 blnEntFutAguarda: Boolean;
                                 intDiaPedVen,
                                 intOrdem: Integer;
                                 strPedMlj,
                                 strNumPed,
                                 strEspPed,
                                 strEmpPed,
                                 strEmpOri: String;
                             Var strEmpUsada: String;
                                 strEmpSubtraiPedTransf: String;
                                 arrCodFor,
                                 arrLinhaGrupo,
                                 arrMarca,
                                 arrPrdGru,
                                 arrGruCmp,
                                 arrSitPro,
                                 arrUnidade,
                                 arrCodDep: TConsultasArray;
                                 strEmpAgr: String;
                                 blnSugInd: Boolean;
                                 cdsEmpresasSel: OleVariant;
                                 recNivEst: TRecOpcoesNivel;
                                 slfLocFis: TSelecaoLocFisica;
                                 strCodTab: String;
                                 slsSaldos,
                                 slsSaldosDestino: TSelecaoSaldos;
                                 strCodCmp: String;
                                 strCodDig: String;
                                 Var strMeses: String;
                                 strSeqCot: String = '';
                                 strNumPedUmaLj: String = '';
                                 strCodEmpUmaLj: String = '';
                                 objRecupera: TRecuperaPedido = Nil;
                                 blnGeraAuto: Boolean = False;
                                 strGirEmp: string = '';
                                 blnEncontrouGiro: Boolean = False;
                                 strNumPedAlt: string = '';
                                 strEmpPedAlt: string = '';
                                 strEspPedAlt: String = ''): Boolean;
  Var
    gipGiro: TGiroPedido;
Begin
  If opcChamada <> chaSpoolTransferencia Then
  Begin
    strLocIni := '';
    strLocFin := '';
  End;

  gipGiro := TGiroPedido.Create;

  If opcChamada = chaSpoolTransferencia Then
    gipGiro.blnEmpVis := True;

  If strPedMlj = 'N' Then
    gipGiro.blnEmpVis := False;

  gipGiro.blnEncontrouGiro := blnEncontrouGiro;

  gipGiro.strCodTab        := strCodTab;
  gipGiro.strSeqCot        := strSeqCot;
  gipGiro.strNumPedUmaLoja := strNumPedUmaLj;
  gipGiro.strCodEmpUmaLoja := strCodEmpUmaLj;
  gipGiro.blnVenPer        := blnVenPer;
  gipGiro.blnVenPerMed     := blnVenPerMed;
  gipGiro.blnConsEndere    := blnConsEndere;
  gipGiro.objRecupera      := objRecupera;
  gipGiro.blnGeraAuto      := blnGeraAuto;
  gipGiro.recNivEst        := recNivEst;
  gipGiro.blnPonPed        := blnPonPed;
  gipGiro.blnAteMax        := blnAteMax;
  gipGiro.blnAgrSim        := blnAgrSim;
  gipGiro.blnMedAju        := blnMedAju;
  gipGiro.blnEntFutPrevisao := blnEntFutPrevisao;
  gipGiro.blnEntFutFalta    := blnEntFutFalta;
  gipGiro.blnEntFutAguarda  := blnEntFutAguarda;
  gipGiro.blnAnalisaITEFOR := blnAnalisaITEFOR;

  gipGiro.strLocIni        := strLocIni;
  gipGiro.strLocFin        := strLocFin;
  gipGiro.opcChamada       := opcChamada;
  gipGiro.slsSaldosDestino := slsSaldosDestino;
  gipGiro.strGirEmp        := strGirEmp;

  gipGiro.strNumPedAlt     := strNumPedAlt;
  gipGiro.strEmpPedAlt     := strEmpPedAlt;
  gipGiro.strEspPedAlt     := strEspPedAlt;

  If fEmptyStr(strMeses) Then
  Begin
    If dtaDataBase = 0 Then
      dtaDataBase := VS_Date;
    strMeses := fMontaStrMeses(intMesMos {intQtdMes});
  End;

  gipGiro.stlMeses.Text := strMeses;

  Result := gipGiro.fCalculaGiroEstoque(recOpcGir,
                                        dtaDataBase,
                                        cdsItensPed,
                                        cdsItensMultLojas,
                                        strCodGru,
                                        strCodFor,
                                        strCodMar,
                                        strPrdGru,
                                        strGruCmp,
                                        strSitPro,
                                        strUnidade,
                                        strCodDep,
                                        intDiaVen,
                                        strAcoObj,
                                        strRefere,
                                        strDesIte,
                                        intOpcGir,
                                        strFilGir,
                                        intQtdMes,
                                        intMesMos,
                                        blnAnalisaITEFOR,
                                        blnAllIte,
                                        blnArredSug,
                                        blnConsMCom,
                                        blnEmbala,
                                        blnConsTLoj,
                                        blnConsEMin,
                                        blnConsEMax,
                                        blnConsRequisicao,
                                        blnConsPedPen,
                                        blnConsPedPenTransferencia,
                                        blnDesconsPedGar,
                                        blnConsPedVen,
                                        blnDescSalExt,
                                        blnConsMesAtu,
                                        blnConsOrdPro,
                                        blnConsGarPen,
                                        blnConsTransf,
                                        blnConsCot,
                                        intDiaPedVen,
                                        intOrdem,
                                        strPedMlj,
                                        strNumPed,
                                        strEspPed,
                                        strEmpPed,
                                        strEmpOri,
                                        strEmpUsada,
                                        strEmpSubtraiPedTransf,
                                        arrCodFor,
                                        arrLinhaGrupo,
                                        arrMarca,
                                        arrPrdGru,
                                        arrGruCmp,
                                        arrSitPro,
                                        arrUnidade,
                                        arrCodDep,
                                        strEmpAgr,
                                        blnSugInd,
                                        cdsEmpresasSel,
                                        slfLocFis,
                                        slsSaldos,
                                        strCodCmp,
                                        strCodDig,
                                        strGirEmp);

  FreeAndNil(gipGiro);
End;

Constructor TGiroPedido.Create;
Begin
  Inherited;
  strSeqCot := '';
  TNivelDeGiroComAgrupamento.blnNivelDeGiroComAgrupamento := False;

  cdsVenPer := fCriaQuery(Nil);
  cdsSalCot := fCriaQuery(Nil);

  stlMeses  := TStringList.Create;

  blnEmpVis := fCfgSis('EMPVIS', varBoolean);
  blnEntBrf := fCfgSis('ENTBRF', varBoolean);
  strFRMPCM := fCfgSis('FRMPCM');
  blnEntIte := fCfgSis('ENTITE', VarBoolean);
  blnLibPcm := fCfgSis('LIBPCM', VarBoolean);
  blnDiaSai := fCfgSis('GIRDIA', varInteger) = 2;

  blnSitPro := fCfgSis('SITPRO', varBoolean);
  blnCorIpd := fCfgSis('CORIPD', varBoolean);
  blnSitEmp := fCfgSis('SITEMP', varInteger) = 1;
End;

Destructor TGiroPedido.Destroy;
Begin
  Inherited;

  cdsVenPer.Close;
  FreeAndNil(cdsVenPer);

  cdsSalCot.Close;
  FreeAndNil(cdsSalCot);

  FreeAndNil(stlMeses);

  fDropTable(strTableNameFILTRO_ITEM);

  fDropTable(strTableSimilar);
End;

function TGiroPedido.fSelecionouMesAtual: Boolean;
Begin
  Result := (YearOf(VS_Date)  = fRetAno(1)) And
            (MonthOf(VS_Date) = fRetMes(1));
End;

function TGiroPedido.fRetQuantidadeDias(intQtdMes: Integer): Integer;
  Var
    intContador: Integer;
Begin
  Result := 0;
  If blnConsMesAtu then
  Begin
    Result := Result + DayOfTheMonth(VS_Date) - 1;
    Dec(intQtdMes);
  End;

  For intContador := 1 To intQtdMes Do
  Begin
    if (Not blnConsMesAtu) And
       (YearOf(VS_Date)  = fRetAno(intContador)) And
       (MonthOf(VS_Date) = fRetMes(intContador)) Then
      Result := Result + DayOfTheMonth(VS_Date) - 1
    Else
      Result := Result + DaysInAMonth(fRetAno(intContador), fRetMes(intContador));
  End;
End;

function TGiroPedido.fRetTodasEmpresas: String;
  var qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT GROUP_CONCAT(EMP_CODEMP SEPARATOR  "_") AS EMPRESAS FROM CADEMP');
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
      Exit;
    Exit(fRetStrToSQLIn(qryConsulta.FieldByName('EMPRESAS').AsString, '_'));
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TGiroPedido.fRetMes(intContador: Integer): Integer;
Begin
  If stlMeses.Count < intContador Then
    Result :=  1
  Else
    Result := StrToIntDef(RightStr(stlMeses[Pred(intContador)], 2), 0);
End;

function TGiroPedido.fRetAno(intContador: Integer): Integer;
Begin
  If stlMeses.Count < intContador Then
    Result :=  1889
  Else
    Result := StrToIntDef(LeftStr(stlMeses[Pred(intContador)], 4), 0);
End;

function TGiroPedido.fRetAnos: String;
  Var
    intContador: Integer;
Begin
  Result := QuotedStr(IntToStr(YearOf(VS_Date)));
  For intContador := 1 To stlMeses.count Do
    If Pos(IntToStr(fRetAno(intContador)), Result) <= 0 Then
      Result := Result + ', ' + QuotedStr(IntToStr(fRetAno(intContador)));
End;

function TGiroPedido.fSQLPedidoVendaPend: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   0.000      AS QTDRES, ';
  strSQL := strSQL + '   0.000      AS QTDGAR  ';
  strSQL := strSQL + ' FROM                    ';
  strSQL := strSQL + '   ITEGER                ';
  strSQL := strSQL + ' WHERE                   ';
  strSQL := strSQL + '   FALSE                 ';
  Result := strSQL;
End;

Function TGiroPedido.fSQLFiltros(strEmpSel, strEmpCal: String; blnIteFor: Boolean =  False): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + TNivelGiroCriticidade.fSQLFiltraNiveis(recNivEst);

  strSQL := strSQL + fStrLocateLinGru(Nil, arrLinhaGrupo, 'C.ITE_CODGRU', 'CODGRU', False, False, strCodGru);

  If blnIteFor Then
  Begin
    If strCodFor = '00000000' Then
      strSQL := strSQL + fStrLocate(Nil, arrCodFor ,  'F.ITE_CODFOR', 'CODFOR', False, False, strCodFor)
    Else
      strSQL := strSQL + ' AND F.ITE_CODFOR LIKE :CODFOR '

  End
  Else
  Begin
    If strCodFor = '00000000' Then
      strSQL := strSQL + fStrLocate(Nil, arrCodFor ,  'C.ITE_CODFOR', 'CODFOR', False, False, strCodFor)
    Else
      strSQL := strSQL + ' AND C.ITE_CODFOR LIKE :CODFOR ';
  End;


  strSQL := strSQL + fStrLocate(Nil, arrMarca ,  'C.ITE_CODMAR', 'CODMAR', False, False, strCodMar);
  strSQL := strSQL + fStrLocate(Nil, arrPrdGru,  'C.ITE_PRDGRU', 'PRDGRU', False, False, strPrdGru);
  strSQL := strSQL + fStrLocate(Nil, arrGruCmp,  'C.ITE_GRUCMP', 'GRUCMP', False, False, strGruCmp);
  strSQL := strSQL + fStrLocate(Nil, arrSitPro,  'C.ITE_SITPRO', 'SITPRO', False, False, strSitPro);
  strSQL := strSQL + fStrLocate(Nil, arrUnidade, 'C.ITE_CODUNI', 'CODUNI', False, False, strUnidade);
  strSQL := strSQL + fStrLocate(Nil, arrCodDep,  'C.ITE_CODDEP', 'CODDEP', False, False, strCodDep);

  strSQL := strSQL + ' AND IFNULL(C.ITE_REFERE,"") LIKE :REFERE  ';
  strSQL := strSQL + ' AND IFNULL(C.ITE_DESITE,"") LIKE :DESITE  ';
  strSQL := strSQL + ' AND IFNULL(C.ITE_ACOOBJ,"") LIKE :ACOOBJ  ';
  strSQL := strSQL + ' AND C.ITE_ITEATI = "S"  ';
  strSQL := strSQL + ' AND C.ITE_ATICOM = "S"  ';

  {Precisa validar o imprime lista a empresa logada, pois ao adicionar o item no pedido de compra o imprime lista é sempre validado da empresa logada.}
  If (Not (fCfgSis('EXILCC', varBoolean))) Then
    strSQL := strSQL + ' AND C.ITE_CODITE IN (SELECT IG.ITE_CODITE FROM ITEGER IG WHERE IG.ITE_CODITE = C.ITE_CODITE AND IG.ITE_IMPLIS = "S" AND IG.ITE_CODEMP = "'+VS_strCodEmp+'" ) ';

  If Not fEmptyStr(strCodCmp) Then
    strSQL := strSQL + ' AND IF(IFNULL(GC.GRU_OPERES, "") = "", TRUE, GC.GRU_OPERES = "' + strCodCmp +'")  ';

  strSQL := strSQL + fSqlFiltroLocFisica(slfLocFis, strEmpSel);

  If opcChamada = chaSpoolTransferencia Then
    strSQL := strSQL + fSqlFiltroLocFisicaInicialFinal(strLocIni, strLocFin, strEmpOriSpool);

  strSQL := strSQL + fSQLFiltroSaldo(slsSaldos, strEmpSel);

  If blnAteMax Then
    strSQL := strSQL + fSQLFiltroAteMax(strEmpCal);

  Result := strSQL;
End;

Function TGiroPedido.fSQLCodItemPrincipal: String;
Begin
  Result := ' IF(IFNULL(C.ITE_CODSIM, "") = "", C.ITE_CODITE, IFNULL((SELECT S.ITE_CODITE FROM CADITE S WHERE S.ITE_CODSIM = C.ITE_CODSIM AND S.ITE_PRISIM = "S" LIMIT 1), C.ITE_CODITE)) ';
End;

Procedure TGiroPedido.pCriaTabelaFiltroItem(strEmpSel, strEmpCal: String;  blnAnalisaIteFor: Boolean);
  Var
    strDesMar,
    strLinGru,
    strDesPrdgru,
    strDesGruCmp,
    strDesSitPro,
    strDesUnidade,
    strDesCodDep,
    strDesCodFor,
    strSQL: String;
    qryFiltro: TUniQuery;
Begin
  strSQL := '';

  strTableNameFILTRO_ITEM := fGetMemoryTableName('FILTRO_ITEM');

  strSQL := strSQL + ' CREATE TABLE '+strTableNameFILTRO_ITEM+'(                 ';
  strSQL := strSQL + '  FIL_CODITE CHAR('+IntToStr(fTamCodIte)+'),  ';

  If blnAgrSim Then
  Begin
    strSQL := strSQL + '  FIL_CODPRI CHAR('+ fTamCodIte.ToString +'),                     ';
    strSQL := strSQL + '  FIL_CODSIM CHAR(6),                     ';
    strSQL := strSQL + '  FIL_PRISIM CHAR(1),                     ';
    strSQL := strSQL + '  FIL_AGRUPA CHAR(6),                     ';
    strSQL := strSQL + '  KEY IDX_FILTRO_ITEM_1 (FIL_CODSIM, FIL_PRISIM), ';
    strSQL := strSQL + '  KEY IDX_FILTRO_ITEM_2 (FIL_CODPRI, FIL_PRISIM), ';
    strSQL := strSQL + '  KEY IDX_FILTRO_ITEM_3 (FIL_CODITE, FIL_PRISIM), ';
    strSQL := strSQL + '  KEY IDX_FILTRO_ITEM_4 (FIL_PRISIM, FIL_CODPRI)  ';
  End Else
  Begin
    strSQL := strSQL + '  KEY IDX_FILTRO_ITEM_1 (FIL_CODITE)        ';
  End;

  strSQL := strSQL + '  ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1; ';

  strSQL := strSQL + ' INSERT INTO ' + strTableNameFILTRO_ITEM ;

  If Not fEmptyStr(strNumPedAlt) Then
  Begin
    strSQL := strSQL + ' SELECT DISTINCT ';
    strSQL := strSQL + '   PCD_CODITE AS FIL_CODITE ';

    If blnAgrSim Then
    Begin
      strSQL := strSQL + ', PCD_CODITE AS FIL_CODPRI, ';
      strSQL := strSQL + ' ITE_CODSIM AS FIL_CODSIM, ';
      strSQL := strSQL + ' ITE_PRISIM AS FIL_PRISIM, ';
      strSQL := strSQL + ' IF(ITE_PRISIM = "S", ITE_CODSIM, PCD_CODITE) AS FIL_AGRUPA ';
    End;

    strSQL := strSQL + ' FROM                  ';
    strSQL := strSQL + '   PCMDET              ';

    If blnAgrSim Then
      strSQL := strSQL + '  INNER JOIN CADITE C ON ITE_CODITE = PCD_CODITE   ';

    strSQL := strSQL + ' WHERE                 ';

    strSQL := strSQL + '      PCD_NUMPED = ' + QuotedStr(strNumPedAlt);
    strSQL := strSQL + '  AND PCD_CODEMP = ' + QuotedStr(strEmpPedAlt);
    strSQL := strSQL + '  AND PCD_ESPDOC = ' + QuotedStr(strEspPedAlt);
    strSQL := strSQL + '  AND NOT PCD_BAIXAD ';

//    strSQL := strSQL + '  AND PCD_CODITE = "01801"  ';

    strSQL := strSQL + '  UNION ';
  End;

  strSQL := strSQL + ' SELECT DISTINCT ';
  strSQL := strSQL + '   C.ITE_CODITE AS FIL_CODITE  ';

  If blnAgrSim Then
  Begin
    strSQL := strSQL + ', ' + fSQLCodItemPrincipal + ' AS FIL_CODPRI, ';
    strSQL := strSQL + '  ITE_CODSIM AS FIL_CODSIM, ';
    strSQL := strSQL + '  ITE_PRISIM AS FIL_PRISIM, ';
    strSQL := strSQL + '  IF(IFNULL(ITE_CODSIM, "") = "", C.ITE_CODITE, C.ITE_CODSIM) AS FIL_AGRUPA ';
  End;

  strSQL := strSQL + ' FROM            ';
  strSQL := strSQL + '   CADITE C      ';

  strSQL := strSQL + ' JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE ';

  strSQL := strSQL + ' LEFT JOIN GRU_COMPRA GC ON GC.GRU_CODIGO = C.ITE_GRUCMP ';

  strSQL := strSQL + ' LEFT JOIN SITPRO ON SIT_CODIGO = C.ITE_SITPRO ';

  strSQL := strSQL + ' LEFT JOIN CFGSIS TIPGIR ON TIPGIR.SIS_CODCFG = "CFG_TIPGIR" AND TIPGIR.SIS_CODEMP = I.ITE_CODEMP ';
  strSQL := strSQL + ' LEFT JOIN CFGSIS TIPCRI ON TIPCRI.SIS_CODCFG = "CFG_TIPCRI" AND TIPCRI.SIS_CODEMP = I.ITE_CODEMP ';

  If Not fEmptyStr(strNumPedAlt) Then
  Begin
    strSQL := strSQL + ' LEFT JOIN PCMDET ON PCD_CODITE = C.ITE_CODITE AND ';
    strSQL := strSQL + '      PCD_NUMPED = ' + QuotedStr(strNumPedAlt);
    strSQL := strSQL + '  AND PCD_CODEMP = ' + QuotedStr(strEmpPedAlt);
    strSQL := strSQL + '  AND PCD_ESPDOC = ' + QuotedStr(strEspPedAlt);
    strSQL := strSQL + '  AND NOT PCD_BAIXAD ';
  End;

  strSQL := strSQL + ' WHERE TRUE ';

  If Not fEmptyStr(strNumPedAlt) Then
    strSQL := strSQL + ' AND PCD_CODITE IS NULL ';

  strSQL := strSQL +    fSQLFiltros(strEmpSel, strEmpCal);

  strSQL := strSQL + ' AND I.ITE_CODEMP IN (' + strEmpSel + ') ';
  If intDiaVen > 0 Then
  Begin
    strSQL := strSQL + ' AND (SELECT COUNT(1) ';
    strSQL := strSQL + '        FROM MOVDET ';
    strSQL := strSQL + '       WHERE DET_TIP_FC = "C" ';
    strSQL := strSQL + '         AND DET_ORIDOC = "V" ';
    strSQL := strSQL + '         AND DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
    strSQL := strSQL + '         AND IFNULL(DET_PROEMB, "N") <> "S" ';
    strSQL := strSQL + '         AND LOCATE(DET_CLAFIS, "' + VS_strClaVen + '") > 0 ';
    strSQL := strSQL + '         AND DET_CLAFIS > 5000 ';
    strSQL := strSQL + '         AND DET_FILKAR = 0 ';
    strSQL := strSQL + '         AND DET_CODEMP = I.ITE_CODEMP ';
    strSQL := strSQL + '         AND DET_CODITE = I.ITE_CODITE';

    strSQL := strSQL + '         AND DET_DTAENT >= DATE_SUB(CURDATE(), INTERVAL ' + intDiaVen.ToString + ' DAY)) > 0 ';
  End;

  qryFiltro := fCriaQuery;
  qryFiltro.SQL.Text := strSQL;

  With qryFiltro Do
  Begin
    pInicializaFiltros(strCodFor, strRefere, strDesIte, strAcoObj);

    pSetaParam(strCodGru,arrLinhaGrupo, strLinGru, 'CODGRU', qryFiltro);


    If strCodFor <> '00000000' Then
      ParamByName('CODFOR').AsString := strCodFor
    Else
      pSetaParam(strCodFor, arrCodFor, strDesCodFor, 'CODFOR', qryFiltro);

    pSetaParam(strCodFor, arrCodFor, strDesCodFor, 'CODFOR', qryFiltro);
    pSetaParam(strCodMar, arrMarca,  strDesMar,    'CODMAR', qryFiltro);
    pSetaParam(strPrdGru, arrPrdGru, strDesPrdgru, 'PRDGRU', qryFiltro);
    pSetaParam(strGruCmp, arrGruCmp, strDesGruCmp, 'GRUCMP', qryFiltro);
    pSetaParam(strSitPro, arrSitPro, strDesSitPro, 'SITPRO', qryFiltro);
    pSetaParam(strUnidade,arrUnidade,strDesUnidade,'CODUNI', qryFiltro);
    pSetaParam(strCodDep, arrCodDep, strDesCodDep, 'CODDEP', qryFiltro);

    ParamByName('DESITE').AsString := strDesIte;
    ParamByName('REFERE').AsString := strRefere;
    ParamByName('ACOOBJ').AsString := strAcoObj;
  End;

//  UNION ALL COM ITEFOR
  If blnAnalisaITEFOR Then
  Begin
    strSQL := strSQL + '  UNION ';

    strSQL := strSQL + ' SELECT DISTINCT ';
    strSQL := strSQL + '   C.ITE_CODITE AS FIL_CODITE  ';

    If blnAgrSim Then
    Begin
      strSQL := strSQL + ', ' + fSQLCodItemPrincipal + ' AS FIL_CODPRI, ';
      strSQL := strSQL + '  ITE_CODSIM AS FIL_CODSIM, ';
      strSQL := strSQL + '  ITE_PRISIM AS FIL_PRISIM, ';
      strSQL := strSQL + '  IF(IFNULL(ITE_CODSIM, "") = "", C.ITE_CODITE, C.ITE_CODSIM) AS FIL_AGRUPA ';
    End;

    strSQL := strSQL + ' FROM            ';

    strSQL := strSQL + ' ITEFOR F         ';

    strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = F.ITE_CODITE  ';

    strSQL := strSQL + ' JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE ';

    strSQL := strSQL + ' LEFT JOIN GRU_COMPRA GC ON GC.GRU_CODIGO = C.ITE_GRUCMP ';

    strSQL := strSQL + ' LEFT JOIN SITPRO ON SIT_CODIGO = C.ITE_SITPRO ';

    strSQL := strSQL + ' LEFT JOIN CFGSIS TIPGIR ON TIPGIR.SIS_CODCFG = "CFG_TIPGIR" AND TIPGIR.SIS_CODEMP = I.ITE_CODEMP ';
    strSQL := strSQL + ' LEFT JOIN CFGSIS TIPCRI ON TIPCRI.SIS_CODCFG = "CFG_TIPCRI" AND TIPCRI.SIS_CODEMP = I.ITE_CODEMP ';

    If Not fEmptyStr(strNumPedAlt) Then
    Begin
      strSQL := strSQL + ' LEFT JOIN PCMDET ON PCD_CODITE = C.ITE_CODITE AND ';
      strSQL := strSQL + '      PCD_NUMPED = ' + QuotedStr(strNumPedAlt);
      strSQL := strSQL + '  AND PCD_CODEMP = ' + QuotedStr(strEmpPedAlt);
      strSQL := strSQL + '  AND PCD_ESPDOC = ' + QuotedStr(strEspPedAlt);
      strSQL := strSQL + '  AND NOT PCD_BAIXAD ';
    End;

    strSQL := strSQL + ' WHERE TRUE ';

    If Not fEmptyStr(strNumPedAlt) Then
      strSQL := strSQL + ' AND PCD_CODITE IS NULL ';

    strSQL := strSQL +    fSQLFiltros(strEmpSel, strEmpCal, True);

    strSQL := strSQL + ' AND I.ITE_CODEMP IN (' + strEmpSel + ') ';

    If intDiaVen > 0 Then
    Begin
      strSQL := strSQL + ' AND (SELECT COUNT(1) ';
      strSQL := strSQL + '        FROM MOVDET ';
      strSQL := strSQL + '       WHERE DET_TIP_FC = "C" ';
      strSQL := strSQL + '         AND DET_ORIDOC = "V" ';
      strSQL := strSQL + '         AND DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
      strSQL := strSQL + '         AND IFNULL(DET_PROEMB, "N") <> "S" ';
      strSQL := strSQL + '         AND LOCATE(DET_CLAFIS, "' + VS_strClaVen + '") > 0 ';
      strSQL := strSQL + '         AND DET_CLAFIS > 5000 ';
      strSQL := strSQL + '         AND DET_FILKAR = 0 ';
      strSQL := strSQL + '         AND DET_CODEMP = I.ITE_CODEMP ';
      strSQL := strSQL + '         AND DET_CODITE = I.ITE_CODITE';

      strSQL := strSQL + '         AND DET_DTAENT >= DATE_SUB(CURDATE(), INTERVAL ' + intDiaVen.ToString + ' DAY)) > 0 ';
    End;
  End;

  qryFiltro := fCriaQuery;
  qryFiltro.SQL.Text := strSQL;

  With qryFiltro Do
  Begin
    pInicializaFiltros(strCodFor, strRefere, strDesIte, strAcoObj);

    pSetaParam(strCodGru,arrLinhaGrupo, strLinGru, 'CODGRU', qryFiltro);

    pSetaParam(strCodMar, arrMarca,  strDesMar,    'CODMAR', qryFiltro);
    pSetaParam(strPrdGru, arrPrdGru, strDesPrdgru, 'PRDGRU', qryFiltro);
    pSetaParam(strGruCmp, arrGruCmp, strDesGruCmp, 'GRUCMP', qryFiltro);
    pSetaParam(strSitPro, arrSitPro, strDesSitPro, 'SITPRO', qryFiltro);
    pSetaParam(strUnidade,arrUnidade,strDesUnidade,'CODUNI', qryFiltro);
    pSetaParam(strCodDep, arrCodDep, strDesCodDep, 'CODDEP', qryFiltro);
    If strCodFor <> '00000000' Then
      ParamByName('CODFOR').AsString := strCodFor
    Else
      pSetaParam(strCodFor, arrCodFor, strDesCodFor, 'CODFOR', qryFiltro);

    ParamByName('DESITE').AsString := strDesIte;
    ParamByName('REFERE').AsString := strRefere;
    ParamByName('ACOOBJ').AsString := strAcoObj;
  End;

  qryFiltro.ExecSQL;


  If blnAgrSim Then
  Begin
    If fCfgSis('REMSIM') = 'S' Then
    Begin
      qryFiltro.SQL.Clear;
      qryFiltro.SQL.Add('UPDATE '+strTableNameFILTRO_ITEM+' F1');
      qryFiltro.SQL.Add(' INNER JOIN (');
      qryFiltro.SQL.Add('SELECT  * FROM '+strTableNameFILTRO_ITEM);
      qryFiltro.SQL.Add('WHERE FIL_CODSIM IS NOT NULL');
      qryFiltro.SQL.Add('GROUP BY FIL_CODSIM) TMP ON TMP.FIL_CODITE = F1.FIL_CODITE');
      qryFiltro.SQL.Add('SET F1.FIL_PRISIM = "S"');
      qryFiltro.ExecSQL;
    end;
    pIncluiSimilares;
  End;

  FreeAndNil(qryFiltro);
End;

Procedure TGiroPedido.pIncluiSimilares;
  Var
    strSQL: String;
    qryFiltro: TUniQuery;
Begin
  strSQL := '';
  If fCfgSis('REMSIM') = 'S' Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' INSERT INTO  ' + strTableNameFILTRO_ITEM;
    strSQL := strSQL + ' SELECT DISTINCT ITE_CODITE, IFNULL(F3.FIL_CODPRI,' + fSQLCodItemPrincipal + ') AS FIL_CODPRI, ITE_CODSIM, ITE_PRISIM, ITE_CODSIM FROM CADITE C      ';
    strSQL := strSQL + ' INNER JOIN ' + strTableNameFILTRO_ITEM + ' F1 ON ITE_CODSIM = F1.FIL_CODSIM   ';
    strSQL := strSQL + ' LEFT  JOIN ' + strTableNameFILTRO_ITEM + ' F2 ON ITE_CODITE = F2.FIL_CODITE   ';
    strSQL := strSQL + ' LEFT JOIN ' + strTableNameFILTRO_ITEM + ' F3 ON F3.FIL_CODSIM = F1.FIL_CODSIM AND F3.FIL_PRISIM = "S" ';
    strSQL := strSQL + ' WHERE F2.FIL_CODITE IS NULL AND  IFNULL(ITE_CODSIM, "") <> "" ';
    strSQL := strSQL + ' GROUP BY ITE_CODITE ';
  end
  Else
  begin
    strSQL := strSQL + ' INSERT INTO  ' + strTableNameFILTRO_ITEM;
    strSQL := strSQL + ' SELECT DISTINCT ITE_CODITE, ' + fSQLCodItemPrincipal + ' AS FIL_CODPRI, ITE_CODSIM, ITE_PRISIM, ITE_CODSIM FROM CADITE C      ';
    strSQL := strSQL + ' INNER JOIN ' + strTableNameFILTRO_ITEM + ' F1 ON ITE_CODSIM = F1.FIL_CODSIM   ';
    strSQL := strSQL + ' LEFT  JOIN ' + strTableNameFILTRO_ITEM + ' F2 ON ITE_CODITE = F2.FIL_CODITE   ';
    strSQL := strSQL + ' WHERE F2.FIL_CODITE IS NULL AND  IFNULL(ITE_CODSIM, "") <> "" ';
  End;

  qryFiltro := fCriaQuery;
  qryFiltro.SQL.Text := strSQL;
  qryFiltro.ExecSQL;
  // Ajsuta os principais
  If fCfgSis('REMSIM') = 'S' Then
  begin
    qryFiltro.SQL.Clear;
    qryFiltro.SQL.Add('UPDATE '+strTableNameFILTRO_ITEM + ' F1');
    qryFiltro.SQL.Add(' INNER JOIN ' + strTableNameFILTRO_ITEM + ' F2 ON F2.FIL_CODSIM = F1.FIL_CODSIM');
    qryFiltro.SQL.Add('                                                       AND F2.FIL_PRISIM = "N"');
    qryFiltro.SQL.Add('                                                       AND F2.FIL_CODITE = F2.FIL_CODPRI');
    qryFiltro.SQL.Add('   SET F2.FIL_CODPRI = F1.FIL_CODITE');
    qryFiltro.SQL.Add(' WHERE F1.FIL_PRISIM = "S"');
    qryFiltro.ExecSQL;
  End;

  FreeAndNil(qryFiltro);
End;

Function TGiroPedido.fCarregaSaldoCotacao(strEmpSel, strEmpCal, strCodEmp: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CODITE      AS CODITE, ';
    strSQL := strSQL + '   CODEMP      AS CODEMP, ';
    strSQL := strSQL + '   SUM(QTDITE) AS QTDITE  ';

    strSQL := strSQL + ' FROM ( ';

    strSQL := strSQL + ' SELECT ';

    If blnAgrSim Then
    Begin

      If fEmptyStr(strSeqCot) Then
      Begin
        strSQL := strSQL + ' FIL_CODPRI AS CODITE, ';
        strSQL := strSQL + ' FIL_AGRUPA, ';
      End Else
      Begin
        strSQL := strSQL + fSQLCodItemPrincipal + ' AS CODITE, ';
      End;

    End Else
    Begin
      strSQL := strSQL + '   CT.COT_CODITE      AS CODITE, ';

    End;

    strSQL := strSQL + '   IFNULL(G.COT_EMPDES, G.COT_CODEMP) AS CODEMP, ';
    strSQL := strSQL + '   SUM(CT.COT_QTDITE) AS QTDITE  ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + '   COTITE CT ';

    strSQL := strSQL + ' INNER JOIN COTGER G ON G.AUTOINCREM = CT.COT_SEQGER ';

    strSQL := strSQL + ' JOIN CADITE C ON C.ITE_CODITE = CT.COT_CODITE  ';

    strSQL := strSQL + ' JOIN ITEGER I ON I.ITE_CODITE = CT.COT_CODITE AND ';
    strSQL := strSQL + '                  I.ITE_CODEMP =  G.COT_CODEMP     ';

    If fEmptyStr(strSeqCot) Then
      strSQL := strSQL + ' JOIN ' + strTableNameFILTRO_ITEM + ' ON FIL_CODITE = C.ITE_CODITE ';

    strSQL := strSQL + ' LEFT JOIN GRU_COMPRA GC ON GC.GRU_CODIGO = C.ITE_GRUCMP ';

    If Not fEmptyStr(strSeqCot) Then
    Begin
      strSQL := strSQL + ' JOIN COTITE CO ON CO.COT_CODITE = CT.COT_CODITE AND ';
      strSQL := strSQL + '                   CO.COT_SEQGER = ' + QuotedStr(strSeqCot) + ' ';
    End;

    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '   G.COT_DTAFIN IS NULL AND ';
    strSQL := strSQL + '   G.COT_MULLOJ = "N" AND       ';
    strSQL := strSQL + '   CT.COT_QTDITE > 0 AND        ';

    strSQL := strSQL + '    IFNULL(G.COT_EMPDES, G.COT_CODEMP) IN (' + strEmpSel + ')  ';

    If fEmptyStr(strSeqCot) Then
    Begin
     If (strPedMlj = 'N') Then
       strSQL := strSQL + ' AND ((I.ITE_CPRCEN = "N") OR (IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") = I.ITE_CODEMP)) ';

     // strSQL := strSQL + fSQLFiltros(strEmpSel, strEmpCal);
    End;

    strSQL := strSQL + ' GROUP BY ';

    If blnAgrSim And fEmptyStr(strSeqCot) Then
      strSQL := strSQL + '  FIL_AGRUPA, '
    Else
      strSQL := strSQL + '  CODITE, ';

    strSQL := strSQL + '   CODEMP ';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT ';

    If blnAgrSim Then
    Begin

      If fEmptyStr(strSeqCot) Then
      Begin
        strSQL := strSQL + ' FIL_CODPRI AS CODITE, ';
        strSQL := strSQL + ' FIL_AGRUPA, ';
      End Else
      Begin
        strSQL := strSQL + fSQLCodItemPrincipal + ' AS CODITE, ';
      End;

    End Else
    Begin

      strSQL := strSQL + '   CT.PCD_CODITE      AS CODITE, ';

    End;

    strSQL := strSQL + '   CT.PCD_EMPDES      AS CODEMP, ';
    strSQL := strSQL + '   SUM(CT.PCD_QTDITE) AS QTDITE  ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + '   PCDCOT CT ';

    strSQL := strSQL + ' INNER JOIN COTGER G ON G.AUTOINCREM = CT.PCD_SEQGER ';

    strSQL := strSQL + ' JOIN CADITE C ON C.ITE_CODITE = CT.PCD_CODITE  ';

    strSQL := strSQL + ' JOIN ITEGER I ON I.ITE_CODITE = CT.PCD_CODITE AND ';
    strSQL := strSQL + '                  I.ITE_CODEMP = CT.PCD_EMPDES     ';

    If fEmptyStr(strSeqCot) Then
      strSQL := strSQL + ' JOIN ' + strTableNameFILTRO_ITEM + ' ON FIL_CODITE = C.ITE_CODITE ';

    strSQL := strSQL + ' LEFT JOIN GRU_COMPRA GC ON GC.GRU_CODIGO = C.ITE_GRUCMP ';

    If Not fEmptyStr(strSeqCot) Then
    Begin
      strSQL := strSQL + ' JOIN COTITE CO ON CO.COT_CODITE = CT.PCD_CODITE AND ';
      strSQL := strSQL + '                   CO.COT_SEQGER = ' + QuotedStr(strSeqCot) + ' ';
    End;

    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '   G.COT_DTAFIN IS NULL AND ';
    strSQL := strSQL + '   G.COT_MULLOJ = "S" AND       ';
    strSQL := strSQL + '   CT.PCD_QTDITE > 0 AND        ';

    strSQL := strSQL + '   CT.PCD_EMPDES IN (' + strEmpSel + ')  ';

    If fEmptyStr(strSeqCot) Then
    Begin
      If (strPedMlj = 'N') Then
        strSQL := strSQL + ' AND ((I.ITE_CPRCEN = "N") OR (IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") = I.ITE_CODEMP)) ';

      // strSQL := strSQL + fSQLFiltros(strEmpSel, strEmpCal);
    End;

    strSQL := strSQL + ' GROUP BY ';

    If blnAgrSim And fEmptyStr(strSeqCot) Then
      strSQL := strSQL + '  FIL_AGRUPA, '
    Else
      strSQL := strSQL + '  CODITE, ';

    strSQL := strSQL + '   CODEMP ';

    strSQL := strSQL + ' ) AS TABSUM ';

    strSQL := strSQL + ' GROUP BY ';

    If blnAgrSim And fEmptyStr(strSeqCot) Then
      strSQL := strSQL + '  FIL_AGRUPA, '
    Else
      strSQL := strSQL + '  CODITE, ';

    strSQL := strSQL + '   CODEMP ';

    With cdsSalCot Do
    Begin
      Close;

      SQL.Text := strSQL;

      pInicializaFiltros(strCodFor, strRefere, strDesIte, strAcoObj);

      Try
        Open;
      Except

        On E: Exception Do
        Begin

          If Pos(strTableNameFILTRO_ITEM, E.Message) > 0 Then
          Begin
            pMensagemOk('Houve uma falha de conexão com o banco de dados, por favor tente novamente!');
            Result := False;
            Exit;
          End

          Else Raise;

        End;

      End;

      IndexFieldNames := 'CODITE;CODEMP';
      KeyFields := 'CODITE;CODEMP';
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGiroPedido.fCarregaSaldoCotacao]');
    End;
  End;
End;

Function TGiroPedido.fCarregaVendasPerdidas(strEmpSel, strEmpCal: String): Boolean;
  Var
    strSQL: String;
    intContador: Integer;
    dtaDtaIni,
    dtaDtaFin: TDateTime;
    intQtdMesCalc: integer;

    Function fSQLVendasPerdidas(strDtaIni, strDtaFin: String): String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + '  SELECT ';

      If blnAgrSim Then
      Begin

        If fEmptyStr(strSeqCot) Then
          strSQL := strSQL + ' FIL_CODPRI AS CODITE, '
        Else
          strSQL := strSQL + fSQLCodItemPrincipal + ' AS CODITE, ';

      End Else
      Begin

        strSQL := strSQL + '    VPD_CODITE      AS CODITE, ';

      End;

      strSQL := strSQL + '    VPD_CODEMP      AS CODEMP, ';
      strSQL := strSQL + '    SUM(VPD_QTDITE) AS QTDPER  ';

      strSQL := strSQL + '  FROM ';
      strSQL := strSQL + '    MOVVPD ';

      strSQL := strSQL + '    INNER JOIN MOVVPG ON VPG_CODEMP = VPD_CODEMP AND VPG_CODIGO = VPD_CODIGO ';

      strSQL := strSQL + '    INNER JOIN MOTVPD ON MOT_CODMOT = VPD_CODMOT AND MOT_CONPED = "S" ';

      strSQL := strSQL + '    JOIN CADITE C ON C.ITE_CODITE = VPD_CODITE  ';

      If fEmptyStr(strSeqCot) Then
        strSQL := strSQL + ' JOIN ' + strTableNameFILTRO_ITEM + ' ON FIL_CODITE = C.ITE_CODITE ';

      strSQL := strSQL + '    JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ';
      strSQL := strSQL + '                     I.ITE_CODEMP = VPD_CODEMP       ';

      strSQL := strSQL + '    LEFT JOIN GRU_COMPRA GC ON GC.GRU_CODIGO = C.ITE_GRUCMP ';

      If Not fEmptyStr(strSeqCot) Then
      Begin
        strSQL := strSQL + ' JOIN COTITE ON COT_CODITE = C.ITE_CODITE AND ';
        strSQL := strSQL + '                COT_SEQGER = ' + QuotedStr(strSeqCot) + ' ';
      End;

      strSQL := strSQL + '  WHERE ';

      strSQL := strSQL + '    VPD_CODEMP IN (' + strEmpSel + ') ';

      strSQL := strSQL + '    AND VPG_DTACAD BETWEEN ' + QuotedStr(strDtaIni) + ' AND ' + QuotedStr(strDtaFin) + ' ';

      If fEmptyStr(strSeqCot) Then
      Begin
        If (strPedMlj = 'N') Then
          strSQL := strSQL + ' AND ((I.ITE_CPRCEN = "N") OR (IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") = I.ITE_CODEMP)) ';

        // strSQL := strSQL + fSQLFiltros(strEmpSel, strEmpCal);
      End;

      strSQL := strSQL + ' GROUP BY ';

      If blnAgrSim Then
      Begin

        If fEmptyStr(strSeqCot) Then
          strSQL := strSQL + '  FIL_AGRUPA, '
        Else
          strSQL := strSQL + '  CODITE, ';

      End
      Else
        strSQL := strSQL + '  CODITE, ';

      strSQL := strSQL + '   CODEMP ';

      Result := strSQL;
    End;

Begin

  Try
    pSetaNomeFuncao(fugCalculaVendasPerdidas);
    pgbProgresso.Position := 0;
    Application.ProcessMessages;

    strSQL := '';

    For intContador := 0 To intQtdMes - 1 Do
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ' UNION ALL ';

      dtaDtaIni := EncodeDate(fRetAno(Succ(intContador)), fRetMes(Succ(intContador)), 1);
      dtaDtaFin := EndOfTheMonth(dtaDtaIni);

      strSQL := strSQL + fSQLVendasPerdidas(FormatDateTime('YYYY-MM-DD', dtaDtaIni), FormatDateTime('YYYY-MM-DD', dtaDtaFin));
    End;

    If blnConsMesAtu Then
    Begin
      strSQL := strSQL + ' UNION ALL ';

      dtaDtaIni := StartOfTheMonth(VS_Date);
      dtaDtaFin := VS_Date;

      strSQL := strSQL + fSQLVendasPerdidas(FormatDateTime('YYYY-MM-DD', dtaDtaIni), FormatDateTime('YYYY-MM-DD', dtaDtaFin));
    End;

    intQtdMesCalc := 1;
    If blnVenPerMed Then
    begin
      If (intQtdMes > 1) Then
        intQtdMesCalc := intQtdMes;
      If blnConsMesAtu then
        inc(intQtdMesCalc);
    End;


    strSQL := 'SELECT CODITE, CODEMP, SUM(IFNULL(QTDPER, 0)) / '+IntToStr(intQtdMesCalc)+'  AS QTDPER FROM (' + strSQL + ') AS VENPER GROUP BY CODITE, CODEMP ';

    With cdsVenPer Do
    Begin
      SQL.Text := strSQL;

      pInicializaFiltros(strCodFor, strRefere, strDesIte, strAcoObj);

      Try
        Open;
      Except

        On E: Exception Do
        Begin

          If Pos(strTableNameFILTRO_ITEM, E.Message) > 0 Then
          Begin
            pMensagemOk('Houve uma falha de conexão com o banco de dados, por favor tente novamente!');
            Result := False;
            Exit;
          End

          Else Raise;

        End;

      End;

      IndexFieldNames := 'CODITE;CODEMP';
      KeyFields := 'CODITE;CODEMP';
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGiroPedido.fCarregaVendasPerdidas]');
    End;
  End;

End;

function fConsidera_EmpAgr_Vazio(ValEmpGer: String): boolean;
begin
  Result := ((fEmptyStr(ValEmpGer)) Or (ValEmpGer = 'Cen'));
end;

function TGiroPedido.fRetQtdVenPer(strCodIte, strCodEmp, strNivGir: String): Double;
var intDiaCom: integer;
Begin
  intDiaCom := -1;
  If cdsVenPer.FindKey([strCodIte, strCodEmp]) Then
  Begin
    Result := cdsVenPer.FieldByName('QTDPER').AsFloat;

    If FOpcGir.blnVenPerMed And (strNivGir<> '')then
    Begin
      If FOpcGir.recNivEst.nivEstoque = nivNenhum Then
        intDiaCom := FOpcGir.recNivEst.intDiaComGer
      Else If strNivGir[1] = 'A' Then
        intDiaCom := FOpcGir.recNivEst.intDiaComNvA
      Else If strNivGir[1] = 'B' Then
        intDiaCom := FOpcGir.recNivEst.intDiaComNvB
      Else If strNivGir[1] = 'C' Then
        intDiaCom := FOpcGir.recNivEst.intDiaComNvC;
      If intDiaCom > -1 Then
        Result := (cdsVenPer.FieldByName('QTDPER').AsFloat / 30) * intDiaCom;
    End;
  End
  Else
    Result := 0;
End;

function TGiroPedido.fRetQtdVenPerCons(strCodIte, strCodEmp, strNivGir: String): Double;
Begin
  If blnVenPer Then
    Result := fRetQtdVenPer(strCodIte, strCodEmp, strNivGir)
  Else
    Result := 0;
End;

function TGiroPedido.fRetQtdCotacao(strCodIte, strCodEmp: String): Double;
Begin
  If cdsSalCot.FindKey([strCodIte, strCodEmp]) Then
    Result := cdsSalCot.FieldByName('QTDITE').AsFloat
  Else
    Result := 0;
End;

function TGiroPedido.fRetQtdCotacaoCons(strCodIte, strCodEmp: String): Double;
Begin
  If blnConsCot Then
    Result := fRetQtdCotacao(strCodIte, strCodEmp)
  Else
    Result := 0;
End;

Procedure TGiroPedido.pSetaParCalculaGiroEstoque(recOpcGirP: TRecOpcoesGiro;
                                                 dtaDataBaseP: TDateTime;
                                                 cdsItensPedP,
                                                 cdsItensMultLojasP: TUniClientDataSet;
                                                 strCodGruP,
                                                 strCodForP,
                                                 strCodMarP,
                                                 strPrdGruP,
                                                 strGruCmpP,
                                                 strSitProP,
                                                 strUnidadeP,
                                                 strCodDepP: String;
                                                 intDiaVenP: Integer;
                                                 strAcoObjP,
                                                 strRefereP,
                                                 strDesIteP: String;
                                                 intOpcGirP: Integer;
                                                 strFilGirP: String;
                                                 intQtdMesP,
                                                 intMesMosP: Integer;
                                                 blnAnalisaITEFORP,
                                                 blnAllIteP,
                                                 blnArredSugP,
                                                 blnConsMComP,
                                                 blnEmbalaP,
                                                 blnConsTLojP,
                                                 blnConsEMinP,
                                                 blnConsEMaxP,
                                                 blnConsRequisicaoP,
                                                 blnConsPedPenP,
                                                 blnConsPedPenTransferenciaP,
                                                 blnDesconsPedGarP,
                                                 blnConsPedVenP,
                                                 blnDescSalExtP,
                                                 blnConsMesAtuP,
                                                 blnConsOrdProP,
                                                 blnConsGarPenP,
                                                 blnConsTransfP,
                                                 blnConsCotP: Boolean;
                                                 intDiaPedVenP,
                                                 intOrdemP: Integer;
                                                 strPedMljP,
                                                 strNumPedP,
                                                 strEspPedP,
                                                 strEmpPedP,
                                                 strEmpOriP: String;
                                                 strEmpUsadaP: String;
                                                 strEmpSubtraiPedTransfP: String;
                                                 arrCodForP,
                                                 arrLinhaGrupoP,
                                                 arrMarcaP,
                                                 arrPrdGruP,
                                                 arrGruCmpP,
                                                 arrSitProP,
                                                 arrUnidadeP,
                                                 arrCodDepP: TConsultasArray;
                                                 strEmpAgrP: String;
                                                 blnSugIndP: Boolean;
                                                 cdsEmpresasSelP: OleVariant;
                                                 slfLocFisP: TSelecaoLocFisica;
                                                 slsSaldosP: TSelecaoSaldos;
                                                 strCodCmpP,
                                                 strCodDigP,
                                                 strGirEmpP: String);
Begin

  FOpcGir           := recOpcGirP;

  dtaDataBase       := dtaDataBaseP       ;
  cdsItensPed       := cdsItensPedP       ;
  cdsItensMultLojas := cdsItensMultLojasP ;
  strCodGru         := strCodGruP         ;
  strCodFor         := strCodForP         ;
  strCodMar         := strCodMarP         ;
  strPrdGru         := strPrdGruP         ;
  strGruCmp         := strGruCmpP         ;
  strSitPro         := strSitProP         ;
  strUnidade        := strUnidadeP        ;
  strCodDep         := strCodDepP         ;
  strAcoObj         := strAcoObjP         ;
  intDiaVen         := intDiaVenP         ;
  strRefere         := strRefereP         ;
  strDesIte         := strDesIteP         ;
  intOpcGir         := intOpcGirP         ;
  strFilGir         := strFilGirP         ;
  intQtdMes         := intQtdMesP         ;
  intMesMos         := intMesMosP         ;
  blnAllIte         := blnAllIteP         ;
  blnArredSug       := blnArredSugP       ;
  blnConsMCom       := blnConsMComP       ;
  blnEmbala         := blnEmbalaP         ;
  blnConsTLoj       := blnConsTLojP       ;
  blnConsEMin       := blnConsEMinP       ;
  blnConsEMax       := blnConsEMaxP       ;
  blnConsRequisicao := blnConsRequisicaoP ;
  blnConsPedPen     := blnConsPedPenP     ;
  blnConsPedPenTransferencia := blnConsPedPenTransferenciaP;
  blnDesconsPedGar := blnDesconsPedGarP;
  blnConsPedVen     := blnConsPedVenP     ;
  blnDescSalExt     := blnDescSalExtP     ;
  blnConsTransf     := blnConsTransfP     ;
  blnConsCot        := blnConsCotP        ;
  blnConsMesAtu     := blnConsMesAtuP     ;
  blnConsOrdPro     := blnConsOrdProP     ;
  blnConsGarPen     := blnConsGarPenP     ;
  intDiaPedVen      := intDiaPedVenP      ;
  intOrdem          := intOrdemP          ;
  strPedMlj         := strPedMljP         ;
  strNumPed         := strNumPedP         ;
  strEspPed         := strEspPedP         ;
  strEmpPed         := strEmpPedP         ;
  strEmpOri         := strEmpOriP         ;
  strEmpUsada       := strEmpUsadaP       ;
  strEmpSubtraiPedTransf := strEmpSubtraiPedTransfP;
  arrCodFor         := arrCodForP;
  arrLinhaGrupo     := arrLinhaGrupoP     ;
  arrMarca          := arrMarcaP          ;
  arrPrdGru         := arrPrdGruP         ;
  arrGruCmp         := arrGruCmpP         ;
  arrSitPro         := arrSitProP         ;
  arrCodDep         := arrCodDepP         ;
  arrUnidade        := arrUnidadeP        ;
  strEmpAgr         := strEmpAgrP         ;
  blnSugInd         := blnSugIndP         ;
  cdsEmpresasSel    := cdsEmpresasSelP    ;
  slfLocFis         := slfLocFisP         ;
  slsSaldos         := slsSaldosP         ;
  strCodCmp         := strCodCmpP         ;
  strCodDig         := strCodDigP         ;
  strGirEmp         := strGirEmpP         ;
  blnAnalisaITEFOR  := blnAnalisaITEFORP ;
End;

procedure TGiroPedido.pTranformLocate(var texto: string);
begin
  If Pos(',', texto) > 0 Then
  Begin
    texto := ReplaceStr(texto, ' ','');
    texto := ReplaceStr(texto, ',', '_');
    texto := ReplaceStr(texto, '''', '');
  End;
end;

function TGiroPedido.fCalculaGiroEstoque(    recOpcGirP: TRecOpcoesGiro;
                                             dtaDataBaseP: TDateTime;
                                             cdsItensPedP,
                                             cdsItensMultLojasP: TUniClientDataSet;
                                             strCodGruP,
                                             strCodForP,
                                             strCodMarP,
                                             strPrdGruP,
                                             strGruCmpP,
                                             strSitProP,
                                             strUnidadeP,
                                             strCodDepP: String;
                                             intDiaVenP: Integer;
                                             strAcoObjP,
                                             strRefereP,
                                             strDesIteP: String;
                                             intOpcGirP: Integer;
                                             strFilGirP: String;
                                         Var intQtdMesP,
                                             intMesMosP: Integer;
                                             blnAnalisaITEFORP,
                                             blnAllIteP,
                                             blnArredSugP,
                                             blnConsMComP,
                                             blnEmbalaP,
                                             blnConsTLojP,
                                             blnConsEMinP,
                                             blnConsEMaxP,
                                             blnConsRequisicaoP,
                                             blnConsPedPenP,
                                             blnConsPedPenTransferenciaP,
                                             blnDesconsPedGarP,
                                             blnConsPedVenP,
                                             blnDescSalExtP,
                                             blnConsMesAtuP,
                                             blnConsOrdProP,
                                             blnConsGarPenP,
                                             blnConsTransfP,
                                             blnConsCotP: Boolean;
                                             intDiaPedVenP,
                                             intOrdemP: Integer;
                                             strPedMljP,
                                             strNumPedP,
                                             strEspPedP,
                                             strEmpPedP,
                                             strEmpOriP: String;
                                         Var strEmpUsadaP: String;
                                             strEmpSubtraiPedTransfP: String;
                                             arrCodForP,
                                             arrLinhaGrupoP,
                                             arrMarcaP,
                                             arrPrdGruP,
                                             arrGruCmpP,
                                             arrSitProP,
                                             arrUnidadeP,
                                             arrCodDepP: TConsultasArray;
                                             strEmpAgrP: String;
                                             blnSugIndP: Boolean;
                                             cdsEmpresasSelP: OleVariant;
                                             slfLocFisP: TSelecaoLocFisica;
                                             slsSaldosP: TSelecaoSaldos;
                                             strCodCmpP,
                                             strCodDigP: String;
                                             strGirEmp: string): Boolean;
Begin
  If fVerificaAcessoSistema('GRUCOM', strCodCmpP) Then
    strCodCmpP := '';

  pSetaParCalculaGiroEstoque(recOpcGirP,
                             dtaDataBaseP,
                             cdsItensPedP,
                             cdsItensMultLojasP,
                             strCodGruP,
                             strCodForP,
                             strCodMarP,
                             strPrdGruP,
                             strGruCmpP,
                             strSitProP,
                             strUnidadeP,
                             strCodDepP,
                             intDiaVenP,
                             strAcoObjP,
                             strRefereP,
                             strDesIteP,
                             intOpcGirP,
                             strFilGirP,
                             intQtdMesP,
                             intMesMosP,
                             blnAnalisaITEFOR,
                             blnAllIteP,
                             blnArredSugP,
                             blnConsMComP,
                             blnEmbalaP,
                             blnConsTLojP,
                             blnConsEMinP,
                             blnConsEMaxP,
                             blnConsRequisicaoP,
                             blnConsPedPenP,
                             blnConsPedPenTransferenciaP,
                             blnDesconsPedGarP,
                             blnConsPedVenP,
                             blnDescSalExtP,
                             blnConsMesAtuP,
                             blnConsOrdProP,
                             blnConsGarPenP,
                             blnConsTransfP,
                             blnConsCotP,
                             intDiaPedVenP,
                             intOrdemP,
                             strPedMljP,
                             strNumPedP,
                             strEspPedP,
                             strEmpPedP,
                             strEmpOriP,
                             strEmpUsadaP,
                             strEmpSubtraiPedTransfP,
                             arrCodForP,
                             arrLinhaGrupoP,
                             arrMarcaP,
                             arrPrdGruP,
                             arrGruCmpP,
                             arrSitProP,
                             arrUnidadeP,
                             arrCodDepP,
                             strEmpAgrP,
                             blnSugIndP,
                             cdsEmpresasSelP,
                             slfLocFisP,
                             slsSaldosP,
                             strCodCmpP,
                             strCodDigP,
                             strGirEmp);

  Result := fExecutaFuncao(fugCalculaGiroEstoque);

  intQtdMesP   := intQtdMes;
  intMesMosP   := intMesMos;
  strEmpUsadaP := strEmpUsada;

End;

function TGiroPedido.fEmpresaCentralizadora(ACodEmp: String): Boolean;
begin
  Result := UpperCase(ACodEmp) = 'CEN'
end;

Function TGiroPedido.fExecutaFuncao(tfgFuncaoGiro: TFuncaoGiro): Boolean;
Begin

  Try

    pCriarFormularios(TfrmGravando, frmGravando);

    Case tfgFuncaoGiro Of

      fugCalculaGiroEstoque       : Begin
                                      frmGravando.lblGravando.Caption := 'Calculando giro...';
                                      frmGravando.fExecutarAcao       := fGPCalculaGiroEstoque;
                                    End;
    End;

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGiroPedido.fExecutaFuncao]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Function TGiroPedido.fGPCalculaGiroEstoque(pgbProgressoP: TcxProgressBar): Boolean;
Begin
  pgbProgresso := pgbProgressoP;

  Result := fCalculaGiroEstoqueAux;
End;

function TGiroPedido.fPedidoMultiLojaPorNivelAgregadaPorEmpresaComCalculoGlobal_E_NivelGiroPorEmpresa(strPedMlj, strEmpAgr: string; recNivEst: TRecOpcoesNivel; blnSugInd: Boolean): Boolean;
begin
  Result := True;
  If (strPedMlj <> 'S') Then
    Exit(False);
   
  //POR EMPRESA
  If blnSugInd Then
    Exit(False);

  If (strEmpAgr = 'S') Then
    Exit(False);

  If Not (recNivEst.nivEstoque in [nivGiro, nivCriticidade, nivAmbos]) Then
    Exit(False);

  If fEmpresaCentralizadora(strEmpAgr) Then
    Exit(False);

  If Not (fCfgSis('TIPGIR') = 'S') Then
    Exit(False);

end;

Procedure TGiroPedido.pSetaNomeFuncao(tfgFuncaoGiro: TFuncaoGiro);
Begin

  Try
    If Not Assigned(frmGravando) Then
      Exit;

    Case tfgFuncaoGiro Of
      fugRealizaCalculosGiro :      Begin
                                      If fEmptyStr(strSeqCot) Then
                                        frmGravando.lblGravando.Caption := 'Calculando giro...'
                                      Else
                                        frmGravando.lblGravando.Caption := 'Carregando giro da cotação...';
                                    End;

      fugSintetizaItensMultiLojas : Begin
                                      frmGravando.lblGravando.Caption := 'Sintetizando itens...';
                                    End;

      fugCalculaGiroEstoque       : Begin
                                      frmGravando.lblGravando.Caption := 'Calculando itens sem giro...';
                                    End;

      fugExecutaSQLGiroEstoque    : Begin
                                      frmGravando.lblGravando.Caption := 'Lendo resumo do giro...';
                                    End;

      fugAbrePedido               : Begin
                                      frmGravando.lblGravando.Caption := 'Lendo pedidos pendentes...';
                                    End;

      fugLendoItegerSintetizaItensMultiLojas: Begin
                                                frmGravando.lblGravando.Caption := 'Lendo dados dos itens...';
                                              End;

      fugLendoItegerItensSemGiro  : Begin
                                      frmGravando.lblGravando.Caption := 'Lendo dados dos itens sem giro...';
                                    End;

      fugExecutaSQLCarregarPedMultiLojas : Begin
                                             frmGravando.lblGravando.Caption := 'Lendo resumo do giro do itens do pedido...';
                                           End;

      fugIndexandoTabela                 : Begin
                                             frmGravando.lblGravando.Caption := 'Criando índice para pesquisa...';
                                           End;

      fugCalculaSalResGarantia : frmGravando.lblGravando.Caption := 'Calculando saldo reservado garantia...';

      fugCalculaSalResPedido   : frmGravando.lblGravando.Caption := 'Calculando saldo reservado pedidos de venda...';

      fugCalculaVendasPerdidas : frmGravando.lblGravando.Caption := 'Calculando saldo de venda perdidas...';
    End;

    Application.ProcessMessages;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGiroPedido.pSetaNomeFuncao]');
    End;
  End;

End;

function fRetEmpresasSel(cdsEmpSel: TUniClientDataSet; strCampo: String; blnIncluirMarcados: Boolean = True): String;
  Var
    stlLista: TStringList;
Begin
  stlLista := TStringList.Create;

  cdsEmpSel.First;
  While Not cdsEmpSel.Eof Do
  Begin
    If (cdsEmpSel.FieldByName(strCampo).AsString = 'S') Then
      stlLista.Add(cdsEmpSel.FieldByName('CODEMP').AsString)

    Else If blnIncluirMarcados And SameText(strCampo, 'EMPVIS') And
           (cdsEmpSel.FieldByName('MARDES').AsString = 'S') Then
          stlLista.Add(cdsEmpSel.FieldByName('CODEMP').AsString);

    cdsEmpSel.Next;
  End;

  Result := fCommaText(stlLista, True);

  stlLista.Clear;
  FreeAndNil(stlLista);
End;

function fElevaConsumiveis(fltQtdIte, fltPerCon: Double; strClaCRM: String): Double;
Begin
  Result := fltQtdIte;

  If (strClaCRM = 'C') And (fltPerCon > 0) Then
    Result := fltQtdIte * (1 + fltPerCon/100);
End;

function TGiroPedido.fCalcularMultiploNaEmpresaCentralizadora(strCprCen: String): Boolean;
Begin
  Result := FOpcGir.blnMultiploNaEmpresaCentralizadora And (strCprCen = 'S');
End;

function TGiroPedido.fCalculaGiroEstoqueAux: Boolean;
  Var
    strLinGru: String;
    strDesMar: String;
    strDesPrdGru: String;
    strDesGruCmp: String;
    strDesSitPro: String;
    strDesUnidade: String;
    strDesCodDep : String;
    dtaBaseTmp: TDateTime;
    wrdAno, wrdMes, wrdDia: Word;

    blnAbaixoPonPed: Boolean;

    wrdAnoIni, wrdAnoFim: Word;

    strCodEmp: String;

    qryGenIte : TUniQuery;
    stlItensGiro: TStringList;

    strUniPcg: String;
    intDecUni: Integer;

    qryGenGir: TUniQuery;
    arrDatas: Array Of TDate;
    fltUnitar: Double;
    fltDesUni: Double;

    strItemAnt: String;

    fltQtdCal,
    fltSugest: Double;
    fltTotIte: Double;
    fltSaldosSug: Double;

    fltBasIpi: Double;
    fltTotIpi: Double;

    fltBasSub: Double;
    fltTotSub: Double;

    fltPerConTmp,
    fltLitros: Double;
    fltPesoit: Double;
    fltVenMes: Double;
    fltProMes: Double;
    fltSaldos: Double;
    fltSugMult: Double;

    cdsBkpDadosGiro: TUniClientDataSet;
    intContadorMes: Integer;
    strLitGal,
    strEmpBus: String;

    fltSalExc: Double;

    procedure pSalvaDadosComuns(cdsDestino: TUniClientDataSet);
      Var
        intContador: Integer;
    begin
      cdsDestino.FieldByName('ITE_INCIRQ').AsString := '';
      cdsDestino.FieldByName('ITE_QTDREQ').AsFloat  := 0;
      cdsDestino.FieldByName('ITE_QATREQ').AsFloat  := 0;
      cdsDestino.FieldByName('ITE_QTDTRA').AsFloat  := 0;
      cdsDestino.FieldByName('ITE_TRAINC').AsFloat  := 0;

      cdsDestino.FieldByName('ITE_CODGRU').AsString := qryGenIte.FieldByName('ITE_CODGRU').AsString;
      cdsDestino.FieldByName('ITE_CLACRM').AsString := qryGenIte.FieldByName('ITE_CLACRM').AsString;
      cdsDestino.FieldByName('ITE_CODABF').AsString := qryGenIte.FieldByName('ITE_CODABF').AsString;
      cdsDestino.FieldByName('ITE_EMBALA').AsFloat  := qryGenIte.FieldByName('ITE_EMBALA').AsFloat;
      cdsDestino.FieldByName('ITE_CODITE').AsString := qryGenIte.FieldByName('ITE_CODITE').AsString;
      cdsDestino.FieldByName('ITE_CODTAB').AsString := qryGenIte.FieldByName('ITE_CODTAB').AsString;
      cdsDestino.FieldByName('ITE_DESITE').AsString := qryGenIte.FieldByName('ITE_DESITE').AsString;
      cdsDestino.FieldByName('ITE_PESORI').AsFloat  := qryGenIte.FieldByName('ITE_PESOIT').AsFloat;
      cdsDestino.FieldByName('ITE_APLICA').AsString := qryGenIte.FieldByName('ITE_APLICA').AsString;
      cdsDestino.FieldByName('ITE_DIAFOR').AsInteger := qryGenIte.FieldByName('ITE_DIAFOR').AsInteger;

      cdsDestino.FieldByName('ITE_ESMIDG').AsString := qryGenIte.FieldByName('ITE_ESMIDG').AsString;
      cdsDestino.FieldByName('ITE_LOCFIS').AsString := qryGenIte.FieldByName('ITE_LOCFIS').AsString;
      cdsDestino.FieldByName('ITE_INCPIS').AsString := qryGenIte.FieldByName('ITE_INCPIS').AsString;
      cdsDestino.FieldByName('ITE_REFERE').AsString := qryGenIte.FieldByName('ITE_REFERE').AsString;
      cdsDestino.FieldByName('ITE_CODUNI').AsString := qryGenIte.FieldByName('ITE_CODUNI').AsString;
      cdsDestino.FieldByName('ITE_UNICOM').AsString := qryGenIte.FieldByName('ITE_UNICOM').AsString;
      cdsDestino.FieldByName('ITE_SIGUNI').AsString := qryGenIte.FieldByName('ITE_SIGUNI').AsString;
      cdsDestino.FieldByName('ITE_CLAIPI').AsString := qryGenIte.FieldByName('ITE_CLAIPI').AsString;
      cdsDestino.FieldByName('ITE_PRAVAL').AsString := qryGenIte.FieldByName('ITE_PRAVAL').AsString;
      cdsDestino.FieldByName('ITE_CODSIT').AsString := qryGenIte.FieldByName('ITE_CODSIT').AsString;
      cdsDestino.FieldByName('ITE_SITORI').AsString := qryGenIte.FieldByName('ITE_SITORI').AsString;
      cdsDestino.FieldByName('ITE_CODMAR').AsString := qryGenIte.FieldByName('ITE_CODMAR').AsString;
      cdsDestino.FieldByName('ITE_DESMAR').AsString := qryGenIte.FieldByName('MAR_DESMAR').AsString;
      cdsDestino.FieldByName('ITE_CODFOR').AsString := qryGenIte.FieldByName('ITE_CODFOR').AsString;
      cdsDestino.FieldByName('ITE_QTDITE').AsFloat  := qryGenIte.FieldByName('ITE_QTDITE').AsFloat;

      cdsDestino.FieldByName('ITE_QTDINC').AsFloat  := qryGenIte.FieldByName('ITE_QTDITE').AsFloat;

      cdsDestino.FieldByName('ITE_TOTITE').AsFloat  := qryGenIte.FieldByName('ITE_TOTITE').AsFloat;

      cdsDestino.FieldByName('ITE_BASIPI').AsFloat  := qryGenIte.FieldByName('ITE_BASIPI').AsFloat;
      cdsDestino.FieldByName('ITE_PERIPI').AsFloat  := qryGenIte.FieldByName('ITE_PERIPI').AsFloat;
      cdsDestino.FieldByName('ITE_TOTIPI').AsFloat  := qryGenIte.FieldByName('ITE_TOTIPI').AsFloat;

      cdsDestino.FieldByName('ITE_ALQIMP').AsFloat  := qryGenIte.FieldByName('ITE_ALQIMP').AsFloat;
      cdsDestino.FieldByName('ITE_VALIMP').AsFloat  := qryGenIte.FieldByName('ITE_VALIMP').AsFloat;

      cdsDestino.FieldByName('ITE_BASSUB').AsFloat  := qryGenIte.FieldByName('ITE_BASSUB').AsFloat;
      cdsDestino.FieldByName('ITE_PERSUB').AsFloat  := qryGenIte.FieldByName('ITE_PERSUB').AsFloat;
      cdsDestino.FieldByName('ITE_TOTSUB').AsFloat  := qryGenIte.FieldByName('ITE_TOTSUB').AsFloat;
      cdsDestino.FieldByName('ITE_TOTDAR').AsFloat  := qryGenIte.FieldByName('ITE_TOTDAR').AsFloat;

      cdsDestino.FieldByName('ITE_BASICM').AsFloat  := qryGenIte.FieldByName('ITE_BASICM').AsFloat;
      cdsDestino.FieldByName('ITE_PERBAS').AsFloat  := qryGenIte.FieldByName('ITE_PERBAS').AsFloat;
      cdsDestino.FieldByName('ITE_VALICM').AsFloat  := qryGenIte.FieldByName('ITE_VALICM').AsFloat;
      cdsDestino.FieldByName('ITE_DESPIS').AsFloat  := qryGenIte.FieldByName('ITE_DESPIS').AsFloat;

      cdsDestino.FieldByName('ITE_BASPIS').AsFloat  := qryGenIte.FieldByName('ITE_BASPIS').AsFloat;
      cdsDestino.FieldByName('ITE_ALQPIS').AsFloat  := qryGenIte.FieldByName('ITE_ALQPIS').AsFloat;
      cdsDestino.FieldByName('ITE_VALPIS').AsFloat  := qryGenIte.FieldByName('ITE_VALPIS').AsFloat;

      cdsDestino.FieldByName('ITE_BASCOF').AsFloat  := qryGenIte.FieldByName('ITE_BASCOF').AsFloat;
      cdsDestino.FieldByName('ITE_ALQCOF').AsFloat  := qryGenIte.FieldByName('ITE_ALQCOF').AsFloat;
      cdsDestino.FieldByName('ITE_VALCOF').AsFloat  := qryGenIte.FieldByName('ITE_VALCOF').AsFloat;

      cdsDestino.FieldByName('ITE_ACRFIN').AsFloat  := qryGenIte.FieldByName('ITE_ACRFIN').AsFloat;
      cdsDestino.FieldByName('ITE_DESF01').AsFloat  := qryGenIte.FieldByName('ITE_DESF01').AsFloat;
      cdsDestino.FieldByName('ITE_DESF02').AsFloat  := qryGenIte.FieldByName('ITE_DESF02').AsFloat;
      cdsDestino.FieldByName('ITE_DESF03').AsFloat  := qryGenIte.FieldByName('ITE_DESF03').AsFloat;
      cdsDestino.FieldByName('ITE_DESF04').AsFloat  := qryGenIte.FieldByName('ITE_DESF04').AsFloat;
      cdsDestino.FieldByName('ITE_DESF05').AsFloat  := qryGenIte.FieldByName('ITE_DESF05').AsFloat;
      cdsDestino.FieldByName('ITE_DESF06').AsFloat  := qryGenIte.FieldByName('ITE_DESF06').AsFloat;

      cdsDestino.FieldByName('ITE_PRECUS').AsFloat  := qryGenIte.FieldByName('ITE_PRECUS').AsFloat;
      cdsDestino.FieldByName('ITE_PREVE1').AsFloat  := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
      cdsDestino.FieldByName('ITE_PREVE2').AsFloat  := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
      cdsDestino.FieldByName('ITE_PREVE3').AsFloat  := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
      cdsDestino.FieldByName('ITE_PREVE4').AsFloat  := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
      cdsDestino.FieldByName('ITE_PREVE5').AsFloat  := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
      cdsDestino.FieldByName('ITE_PREVE6').AsFloat  := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
      cdsDestino.FieldByName('ITE_PREVE7').AsFloat  := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
      cdsDestino.FieldByName('ITE_MARBR1').AsFloat  := qryGenIte.FieldByName('ITE_MARBR1').AsFloat;
      cdsDestino.FieldByName('ITE_MARBR2').AsFloat  := qryGenIte.FieldByName('ITE_MARBR2').AsFloat;
      cdsDestino.FieldByName('ITE_MARBR3').AsFloat  := qryGenIte.FieldByName('ITE_MARBR3').AsFloat;
      cdsDestino.FieldByName('ITE_MARBR4').AsFloat  := qryGenIte.FieldByName('ITE_MARBR4').AsFloat;
      cdsDestino.FieldByName('ITE_MARBR5').AsFloat  := qryGenIte.FieldByName('ITE_MARBR5').AsFloat;
      cdsDestino.FieldByName('ITE_MARBR6').AsFloat  := qryGenIte.FieldByName('ITE_MARBR6').AsFloat;
      cdsDestino.FieldByName('ITE_MARBR7').AsFloat  := qryGenIte.FieldByName('ITE_MARBR7').AsFloat;
      cdsDestino.FieldByName('ITE_MLTCOM').AsFloat  := qryGenIte.FieldByName('ITE_MLTCOM').AsFloat;
      cdsDestino.FieldByName('ITE_ABAMLT').AsString := qryGenIte.FieldByName('ITE_ABAMLT').AsString;
      cdsDestino.FieldByName('ITE_PRINCI').AsString := qryGenIte.FieldByName('ITE_PRINCI').AsString;
      If blnSitPro And blnCorIpd Then
      Begin
        cdsDestino.FieldByName('ITE_DESSIT').AsString := qryGenIte.FieldByName('SIT_DESCRI').AsString;
        cdsDestino.FieldByName('ITE_CORSIT').AsString := qryGenIte.FieldByName('SIT_CORSIT').AsString;
      End;

      cdsDestino.FieldByName('ITE_CICMDE').AsString := qryGenIte.FieldByName('ITE_CICMDE').AsString;
      cdsDestino.FieldByName('ITE_CDPIOP').AsString := qryGenIte.FieldByName('ITE_CDPIOP').AsString;
      cdsDestino.FieldByName('ITE_DIDIOP').AsString := qryGenIte.FieldByName('ITE_DIDIOP').AsString;

      cdsDestino.FieldByName('ITE_UNITAR').AsFloat  := fltUnitar;
      cdsDestino.FieldByName('ITE_UNIORI').AsFloat  := fltUnitar;
      cdsDestino.FieldByName('ITE_DESUNI').AsFloat  := fltDesUni;
      cdsDestino.FieldByName('ITE_DESUN2').AsFloat  := 0;
      cdsDestino.FieldByName('ITE_DESUN3').AsFloat  := 0;
      cdsDestino.FieldByName('ITE_DESUN4').AsFloat  := 0;
      cdsDestino.FieldByName('ITE_DESUN5').AsFloat  := 0;
      cdsDestino.FieldByName('ITE_DESUN6').AsFloat  := 0;

      if Pos(strUniPcg, '2_4_8_') > 0 Then
      Begin
        cdsDestino.FieldByName('ITE_ACRFIN').AsFloat  := 0;
        cdsDestino.FieldByName('ITE_DESUNI').AsFloat  := 0;
        cdsDestino.FieldByName('ITE_DESUN2').AsFloat  := 0;
        cdsDestino.FieldByName('ITE_DESUN3').AsFloat  := 0;
        cdsDestino.FieldByName('ITE_DESUN4').AsFloat  := 0;
        cdsDestino.FieldByName('ITE_DESUN5').AsFloat  := 0;
        cdsDestino.FieldByName('ITE_DESUN6').AsFloat  := 0;
      End;

      cdsDestino.FieldByName('ITE_UNILIQ').AsFloat  := fCalculaUnitarioLiquido(intDecUni,
                                                        fltUnitar, fltDesUni, 0, 0, 0, 0, 0);

      cdsDestino.FieldByName('ITE_DIFPRE').AsFloat  := Iif(qryGenIte.FieldByName('ITE_PREULT').AsFloat = 0, 0, (((cdsDestino.FieldByName('ITE_UNITAR').AsFloat - qryGenIte.FieldByName('ITE_PREULT').AsFloat) / qryGenIte.FieldByName('ITE_PREULT').AsFloat) * 100));

      cdsDestino.FieldByName('ITE_CPRCEN').AsString := qryGenIte.FieldByName('ITE_CPRCEN').AsString;
      cdsDestino.FieldByName('ITE_EMPCEN').AsString := qryGenIte.FieldByName('ITE_EMPCEN').AsString;
      cdsDestino.FieldByName('ITE_CPCEMO').AsString := IfThen(qryGenIte.FieldByName('ITE_CPRCEN').AsString='S', 'C', 'I');
      cdsDestino.FieldByName('ITE_CODFAB').AsString := qryGenIte.FieldByName('ITE_CODFAB').AsString;
      cdsDestino.FieldByName('ITE_CODBAR').AsString := qryGenIte.FieldByName('ITE_CODBAR').AsString;
      cdsDestino.FieldByName('ITE_CODSIM').AsString := qryGenIte.FieldByName('ITE_CODSIM').AsString;
      cdsDestino.FieldByName('ITE_MLTSPO').AsString := qryGenIte.FieldByName('ITE_MLTSPO').AsString;
      cdsDestino.FieldByName('AUTOINCREM').AsString := qryGenIte.FieldByName('AUTOINCREM').AsString;
      cdsDestino.FieldByName('ITE_CODEMP').AsString := qryGenIte.FieldByName('EMP_CODEMP').AsString;
      cdsDestino.FieldByName('ITE_DESEMP').AsString := qryGenIte.FieldByName('EMP_NOMEMP').AsString;

      cdsDestino.FieldByName('GIRSINT').AsString    := qryGenIte.FieldByName('GIRSINT').AsString;
      cdsDestino.FieldByName('CRISINT').AsString    := qryGenIte.FieldByName('CRISINT').AsString;
      cdsDestino.FieldByName('ITE_NVLGIR').AsString := qryGenIte.FieldByName('ITE_NVLGIR').AsString;
      cdsDestino.FieldByName('ITE_NVLCRI').AsString := qryGenIte.FieldByName('ITE_NVLCRI').AsString;

      cdsDestino.FieldByName('ITE_DESSIM').AsString := qryGenIte.FieldByName('ITE_DESSIM').AsString;
      cdsDestino.FieldByName('ITE_DESGRU').AsString := qryGenIte.FieldByName('ITE_DESGRU').AsString;

      For intContador := 1 To 12 {intQtdMes} Do
      Begin
        cdsDestino.FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat  := 0.0;
        cdsDestino.FieldByName('ITE_Q_VP' + fStrZero(intContador, 2)).AsFloat  := 0.0;
        cdsDestino.FieldByName('ITE_DESM' + fStrZero(intContador, 2)).AsString := FormatDateTime('mm/yyyy', IncMonth(dtaDataBase, -intContador));
      End;

      cdsDestino.FieldByName('ITE_DIASAI').AsInteger:= 0;
      cdsDestino.FieldByName('ITE_MEDIA_').AsFloat  := 0.0;
      cdsDestino.FieldByName('ITE_AJUSTA').AsFloat  := 0.0;
      cdsDestino.FieldByName('ITE_MEDAJU').AsFloat  := 0.0;
      cdsDestino.FieldByName('ITE_MEDIXX').AsFloat  := 0.0;
      cdsDestino.FieldByName('ITE_ITEFRA').AsString := qryGenIte.FieldByName('UNI_ITEFRA').AsString;
      cdsDestino.FieldByName('ITE_FORPRI').AsString := qryGenIte.FieldByName('ITE_FORPRI').AsString;
      cdsDestino.FieldByName('ITE_DEPART').AsString := qryGenIte.FieldByName('ITE_DEPART').AsString;

    end;

    function fInd(intInd: Integer): String;
    begin
      Result := fStrZero(intInd, 2);
    end;

    Procedure pMontaDatasGiro;
      Var
        intContador1: Integer;
    Begin
      wrdAno    := 0;
      wrdMes    := 0;
      wrdDia    := 0;

      intQtdMes := 0;

      If intOpcGir = GIR_03MESES Then
        intQtdMes := 03
      Else if intOpcGir = GIR_06MESES Then
        intQtdMes := 06
      Else If intOpcGir = GIR_12MESES Then
        intQtdMes := 12;

      wrdAnoIni := YearOf(dtaDataBase);
      wrdAnoFim := 0;
      dtaBaseTmp:= IncMonth(dtaDataBase, -1);

      SetLength(arrDatas, 12 {intQtdMes});
      {*****************************************}
      {* GERA AS DATAS DO GIRO                 *}
      {**************************************MV*}
      For intContador1 := 0 To 12 {intQtdMes} -1 Do
        arrDatas[intContador1] := EncodeDate(fRetAno(Succ(intContador1)), fRetMes(Succ(intContador1)), 1);
    End;

    Var
      cdsEmpSel: TUniClientDataSet;
      strEmpCal,
      strEmpSel: String;
      intDiasCompraAgreg: Integer;
      fltPerConAgreg: Double;

    Procedure pAbrePedido;
    Begin
      pSetaNomeFuncao(fugAbrePedido);
      {*****************************************}
      {* AJUSTA AS VARIAVEIS DO FILTRO         *}
      {**************************************MV*}

      pInicializaFiltros(strCodFor, strRefere, strDesIte, strAcoObj);

      If ((strPedMlj = 'S') Or (blnConsTLoj)) And (fEmptyStr(strNumPed)) Then
        strCodEmp := '%';

      strEmpUsada := strCodEmp;


    End;

    Function fSQLSemGiroOuTodos: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  "" AS ITE_SEQCOT, ';
      strSQL := strSQL + ' C.ITE_CODGRU, ';

      strSQL := strSQL + ' C.ITE_CLACRM, ';

      If fCfgSis('TIPABF') = '1' THEN
        strSQL := strSQL + '  C.ITE_CODABF, '
      Else
        strSQL := strSQL + '  I.ITE_CODABF, ';

      strSQL := strSQL + ' C.ITE_CODITE, ';

      strSQL := strSQL + ' C.ITE_APLICA, ';
      strSQL := strSQL + ' C.ITE_DIAFOR, ';
      strSQL := strSQL + ' C.ITE_REFERE, ';
      strSQL := strSQL + ' C.ITE_CODUNI, ';
      strSQL := strSQL + ' C.ITE_UNICOM, ';
      strSQL := strSQL + ' U.UNI_SIGUNI AS ITE_SIGUNI, ';
      strSQL := strSQL + ' U.UNI_PESLIT, ';
      strSQL := strSQL + ' C.ITE_PESOIT, ';
      strSQL := strSQL + ' C.ITE_CODMAR, ';
      strSQL := strSQL + ' M.MAR_DESMAR, ';
      strSQL := strSQL + ' C.ITE_CODFOR, ';

      strSQL := strSQL + '  I.ITE_CICMDE, ';
      strSQL := strSQL + '  I.ITE_CDPIOP, ';
      strSQL := strSQL + '  I.ITE_DIDIOP, ';

      strSQL := strSQL + ' 0.0000     AS ITE_QTDITE, ';
      strSQL := strSQL + ' 0.0000     AS ITE_TOTITE, ';

      strSQL := strSQL + ' 0.0000     AS ITE_BASIPI, ';
      strSQL := strSQL + ' 0.0000     AS ITE_TOTIPI, ';

      strSQL := strSQL + ' 0.0000     AS ITE_ALQIMP, ';
      strSQL := strSQL + ' 0.0000     AS ITE_VALIMP, ';

      strSQL := strSQL + ' 0.0000    AS ITE_BASSUB, ';
      strSQL := strSQL + ' 0.0000    AS ITE_TOTSUB, ';
      strSQL := strSQL + ' 0.0000    AS ITE_TOTDAR, ';
      strSQL := strSQL + ' 0.0000    AS ITE_SUBFCP, ';

      strSQL := strSQL + ' 0.0000     AS ITE_BASICM, ';
      strSQL := strSQL + ' 0.0000     AS ITE_PERBAS, ';
      strSQL := strSQL + ' 0.0000     AS ITE_VALICM, ';
      strSQL := strSQL + ' 0.0000     AS ITE_DESPIS, ';

      strSQL := strSQL + ' 0.0000     AS ITE_BASPIS, ';
      strSQL := strSQL + ' 0.0000     AS ITE_ALQPIS, ';
      strSQL := strSQL + ' 0.0000     AS ITE_VALPIS, ';

      strSQL := strSQL + ' 0.0000     AS ITE_BASCOF, ';
      strSQL := strSQL + ' 0.0000     AS ITE_ALQCOF, ';
      strSQL := strSQL + ' 0.0000     AS ITE_VALCOF, ';

      strSQL := strSQL + fSQLCamposPrecoCusto(strCodFor);

      strSQL := strSQL + ' I.ITE_ABAMLT, ';

      If fCfgSis('CFPCFF', varBoolean) And (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
      Begin
        If fCfgSis('TABPRF', varBoolean) Then
          strSQL := strSQL + '  F.ITE_CODFAB AS ITE_CODFAB, '
        Else
          strSQL := strSQL + '  F.ITE_CODITF AS ITE_CODFAB, ';
      End
      Else
      Begin
        If fCfgSis('TABPRF', varBoolean) Then
          strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, '
        Else
          strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ';
      End;

      If fCfgSis('CODFIT', varBoolean) Then
      Begin
        strSQL := strSQL + '  C.ITE_CODFAB AS ITE_CODFAB, ';
      End
      Else
      Begin
        If fCfgSis('TABPRF', varBoolean) Then
          strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, '
        Else
          strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ';
      End;

      If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
      Begin
        strSQL := strSQL + fGetCodSitFornecedorSQL       + ' AS ITE_CODSIT, ';
        strSQL := strSQL + fGetCodSitOrigemFornecedorSQL + ' AS ITE_SITORI, ';
      End Else
      Begin
        strSQL := strSQL + ' "   " AS ITE_CODSIT, ';
        strSQL := strSQL + ' "   " AS ITE_SITORI, ';
      End;

      If blnAgrSim Then
      Begin
        strSQL := strSQL + ' SUM(S.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / ITE_CNV_ML, 0)) AS ITE_SALDOS, ';
        strSQL := strSQL +  fSQLSaldosReservadosAgrSim(False, False, FOpcGir,  'I', 'C', 'SP');
      End Else
      Begin
        strSQL := strSQL + ' I.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0) AS ITE_SALDOS, ';
        strSQL := strSQL + fSQLSaldosReservados(False, False,  FOpcGir, 'I', 'C', 'SP');
      End;

      strSQL := strSQL + ' I.ITE_PREVE1, ';
      strSQL := strSQL + ' I.ITE_PREVE2, ';
      strSQL := strSQL + ' I.ITE_PREVE3, ';
      strSQL := strSQL + ' I.ITE_PREVE4, ';
      strSQL := strSQL + ' I.ITE_PREVE5, ';
      strSQL := strSQL + ' I.ITE_PREVE6, ';
      strSQL := strSQL + ' I.ITE_PREVE7, ';
      strSQL := strSQL + ' I.ITE_MARBR1, ';
      strSQL := strSQL + ' I.ITE_MARBR2, ';
      strSQL := strSQL + ' I.ITE_MARBR3, ';
      strSQL := strSQL + ' I.ITE_MARBR4, ';
      strSQL := strSQL + ' I.ITE_MARBR5, ';
      strSQL := strSQL + ' I.ITE_MARBR6, ';
      strSQL := strSQL + ' I.ITE_MARBR7, ';
      strSQL := strSQL + ' I.ITE_PREULT, ';

      strSQL := strSQL + ' 0 AS ITE_UNIIMP, ';

      If blnGeraAuto Or ((Not fEmptyStr(strCodFor)) And (strCodFor <> '%')) Then
        strSQL := strSQL + ' IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = I.ITE_CODITE AND BAR_CODFOR = C.ITE_CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), C.ITE_EMBALA) AS ITE_EMBALA, '
      Else
        strSQL := strSQL + ' C.ITE_EMBALA, ';

      strSQL := strSQL + ' I.ITE_ESTMIN, ';
      strSQL := strSQL + ' I.ITE_ESTMAX, ';
      strSQL := strSQL + ' I.ITE_PMED_V, ';

      strSQL := strSQL + ' I.ITE_MINDIG, ';
      strSQL := strSQL + ' I.ITE_MAXDIG, ';

      strSQL := strSQL + ' I.ITE_PONPED, ';

      strSQL := strSQL + ' C.ITE_CODSIM, ';
      strSQL := strSQL + ' C.ITE_PRISIM, ';
      strSQL := strSQL + ' C.ITE_MLTSPO, ';

      strSQL := strSQL + ' C.ITE_CODBAR, ';
      strSQL := strSQL + ' I.ITE_CPRCEN, ';
      strSQL := strSQL + ' IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") AS ITE_EMPCEN, ';

      strSQL := strSQL + ' C.AUTOINCREM, ';
      strSQL := strSQL + ' E.EMP_CODEMP, ';
      strSQL := strSQL + ' E.EMP_NOMEMP, ';
      strSQL := strSQL + ' I.ITE_CODEMP, ';
      strSQL := strSQL + ' C.ITE_DESSIM, ';
      strSQL := strSQL + ' IF(COALESCE(GRU_DRELIN, "") <> "", CONCAT(COALESCE(GRU_DRELIN, ""), " - ", COALESCE(GRU_DESGRU, "")),COALESCE(GRU_DESGRU, "") ) AS ITE_DESGRU, ';

      strSQL := strSQL + TNivelGiroCriticidade.fSQLNiveis(FOpcGir.recNivEst);

      strSQL := strSQL + ' I.ITE_LOCFIS, ';
      strSQL := strSQL + ' I.ITE_ESMIDG, ';
      strSQL := strSQL + ' U.UNI_ITEFRA, ';

      If blnSitPro  And blnCorIpd Then
      Begin
        strSQL := strSQL + '  SIT_CODIGO, ';
        strSQL := strSQL + '  SIT_CORSIT, ';
        strSQL := strSQL + '  SIT_DESCRI, ';
      End;

      If blnAnalisaITEFOR Then
        strSQL := strSQL + ' IF(C.ITE_CODFOR = "' + strCodFor +'", "*", "") AS ITE_PRINCI, '
      Else
        strSQL := strSQL + ' " " AS ITE_PRINCI, ';

      strSql := strSql + '  I.ITE_TIPABS, ';
      strSql := strSql + '  I.ITE_VNOLCD, ';

      strSQL := strSQL + ' C.ITE_INCPIS,  ';
      strSQL := strSQL + '  FP.FOR_NOMFOR ITE_FORPRI, ';
      strSQL := strSQL + '  DP.DEP_DESCRI ITE_DEPART ';



      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE C ';
      strSQL := strSQL + '  JOIN CADMAR M      ON M.MAR_CODMAR  = C.ITE_CODMAR ';
      strSQL := strSQL + '  JOIN CADUNI U      ON U.UNI_CODUNI  = C.ITE_CODUNI ';

      If blnAgrSim Then
      Begin
        strSQL := strSQL + '  JOIN ' + strTableNameFILTRO_ITEM + ' ON   FIL_CODPRI = C.ITE_CODITE ';

        strSQL := strSQL + '  JOIN ITEGER I    ON I.ITE_CODITE =   FIL_CODPRI ';

        strSQL := strSQL + '  JOIN CADEMP E    ON E.EMP_CODEMP = I.ITE_CODEMP ';

        strSQL := strSQL + '  JOIN ITEGER S    ON S.ITE_CODITE =   FIL_CODITE ';
        strSQL := strSQL + '                  AND S.ITE_CODEMP = E.EMP_CODEMP ';

        strSQL := strSQL + '  LEFT JOIN SALPDC SP ON SP.SAL_CODITE =   FIL_CODITE ';
        strSQL := strSQL + '                     AND SP.SAL_CODEMP = I.ITE_CODEMP ';
      End Else
      Begin
        strSQL := strSQL + '  JOIN ' + strTableNameFILTRO_ITEM + ' ON   FIL_CODITE = C.ITE_CODITE ';

        strSQL := strSQL + '  JOIN ITEGER I    ON I.ITE_CODITE = C.ITE_CODITE ';

        strSQL := strSQL + '  JOIN CADEMP E    ON E.EMP_CODEMP = I.ITE_CODEMP ';

        strSQL := strSQL + '  LEFT JOIN SALPDC SP ON SP.SAL_CODITE = I.ITE_CODITE ';
        strSQL := strSQL + '                     AND SP.SAL_CODEMP = I.ITE_CODEMP ';
      End;

      strSQL := strSQL + '  LEFT JOIN GRU_COMPRA GC ON GC.GRU_CODIGO = C.ITE_GRUCMP ';

      strSQL := strSQL + '  LEFT JOIN CADGRU ON GRU_CODGRU = C.ITE_CODGRU ';

      strSQL := strSQL + '  LEFT JOIN ITEFOR F ON ';

      If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
      Begin
        strSQL := strSQL + '     F.ITE_CODITE = I.ITE_CODITE ';
        strSQL := strSQL + ' AND F.ITE_CODFOR = ' + QuotedStr(strCodFor);
        If fCfgSis('TABPRF', varBoolean) Then
        Begin
          strSQL := strSQL + '                    AND (SELECT COUNT(*) FROM TABPRE     ';
          strSQL := strSQL + '                          WHERE F.ITE_CODTAB = TAB_CODTAB AND ' + fSqlWhereTabPre('', strCodTab) + ') > 0 ';
        End Else
        Begin
          strSQL := strSQL + '                    AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ';
          strSQL := strSQL + '                                         WHERE FF.ITE_CODITE = I.ITE_CODITE AND ';
          strSQL := strSQL + '                                          FF.ITE_CODFOR = ' + QuotedStr(strCodFor) + ') ';
        End;
        strSQL := strSQL + '  LEFT JOIN CADFOR CF ON CF.FOR_CODFOR = ' + QuotedStr(strCodFor);
        strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CF.FOR_CODCID     ';
        strSQL := strSQL + '  LEFT JOIN ABFICM ON ABF_CODABF = ' + IfThen(fCfgSis('TIPABF') = '1', 'C', 'I') + '.ITE_CODABF AND ';
        strSQL := strSQL + '                      ABF_ESTADO = CID_ESTADO     ';
      End
      Else
        strSQL := strSQL + ' F.ITE_CODITE = "" ';

      If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') And fCfgSis('TABPRF', varBoolean) Then
      Begin
        strSQL := strSQL + ' LEFT JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB ';
        strSQL := strSQL + '                   AND D.ITE_CODITE = F.ITE_CODITE ';
        strSQL := strSQL + '                   AND D.ITE_CODEMP = I.ITE_CODEMP  ';
      End;

      If blnSitPro And blnCorIpd Then
      Begin
        If blnSitEmp Then
          strSQL := strSQL + ' LEFT JOIN SITPRO ON C.ITE_SITPRO = SIT_CODIGO '
        Else
          strSQL := strSQL + ' LEFT JOIN SITPRO ON I.ITE_SITPRO = SIT_CODIGO ';
      End;

      strSQL := strSQL +'  LEFT JOIN CADFOR FP ON FP.FOR_CODFOR = C.ITE_CODFOR ';
      strSQL := strSQL +'  LEFT JOIN CADDEP DP ON DP.DEP_CODIGO = C.ITE_CODDEP ';
      strSQL := strSQL + 'WHERE TRUE ';
{      strSQL := strSQL + '  I.ITE_CODEMP LIKE :CODEMP ';}

//      strSQL := strSQL + '  AND I.ITE_CODITE = "02003" ';

      If stlItensGiro.Count > 0 Then
        strSQL := strSQL + '  AND C.ITE_CODITE NOT IN (' + fCommaText(stlItensGiro) + ') ';

      strSQL := strSQL + ' AND EMP_CODEMP IN (' + strEmpSel + ') ';

      If (strPedMlj = 'N') Then
        strSQL := strSQL + ' AND ((I.ITE_CPRCEN = "N") OR (IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") = I.ITE_CODEMP)) ';

     //   strSQL := strSQL + fSQLFiltros(strEmpSel, strEmpCal); *)

      strSQL := strSQL + 'GROUP BY ';

      If blnAgrSim Then
        strSQL := strSQL + '  FIL_AGRUPA,   '
      Else
        strSQL := strSQL + '  I.ITE_CODITE, ';

      strSQL := strSQL + '  I.ITE_CODEMP ';

      strSQL := strSQL + 'ORDER BY ';

      strSQL := strSQL + '  I.ITE_CODITE, I.ITE_CODEMP ';

      Result := strSQL;
    End;

    Procedure pLiberaComps;
    Begin
      FreeAndNil(qryGenIte);
      FreeAndNil(qryGenGir);
      FreeAndNil(stlItensGiro);
      FreeAndNil(cdsEmpSel);

      FreeAndNil(cdsBkpDadosGiro);
      SetLength(arrDatas, 0);
    End;

    Procedure pLimpaSugestao;
    Begin
      If (fCalculaSugestaoAgregada(strEmpAgr, blnSugInd)) Then
      Begin

        cdsEmpSel.First;
        While (Not cdsEmpSel.Eof) Do
        Begin
          If (cdsItensMultLojas.FindKey([strItemAnt, cdsEmpSel.FieldByName('CODEMP').AsString])) Then
          Begin
            cdsItensMultLojas.Edit;
            cdsItensMultLojas.FieldByName('ITE_SUGEST').AsFloat := 0;
            cdsItensMultLojas.FieldByName('ITE_QTDITE').AsFloat := 0;
            cdsItensMultLojas.FieldByName('ITE_QTDCAL').AsFloat := 0;
            cdsItensMultLojas.FieldByName('ITE_SUGESTORI').AsFloat := 0;
            cdsItensMultLojas.Post;
          End;

          cdsEmpSel.Next;
        End;

      End;
    End;

//  Var
//    t1, t2: TDateTime;
begin
  GlobalrecOpcoesGiro := FOpcGir;
  cdsBkpDadosGiro := Nil;
  Result := True;
  cdsEmpSel := TUniClientDataSet.Create(Nil);

  If cdsEmpresasSel <> Null Then
  Begin
    cdsEmpSel.Data := cdsEmpresasSel;

    If blnEmpVis Then
    Begin
      strEmpSel := fRetEmpresasSel(cdsEmpSel, 'EMPVIS');
      strGirEmp := fRetEmpresasSel(cdsEmpSel, 'EMPVIS');
      strEmpCal := fRetEmpresasSel(cdsEmpSel, 'MARDES');

      strEmpOriSpool := fRetEmpresasSel(cdsEmpSel, 'EMPVIS', False);
      strEmpDesSpool := fRetEmpresasSel(cdsEmpSel, 'MARDES', False);

      If fEmptyStr(strEmpSel) Then
        strEmpSel := strEmpCal;
    End Else
    Begin
      strEmpSel := fRetEmpresasSel(cdsEmpSel, 'MARDES');
      strEmpCal := fRetEmpresasSel(cdsEmpSel, 'MARDES');
      strGirEmp := fRetEmpresasSel(cdsEmpSel, 'MARDES');
      strEmpOriSpool := '';
      strEmpDesSpool := '';
    End;

  End Else
  Begin
    If (strPedMlj = 'S') And fEmptyStr(strGirEmp) Then
      strGirEmp := fRetTodasEmpresas
    Else If fEmptyStr(strGirEmp) Then
      strGirEmp := QuotedStr(strEmpPed);
    strEmpSel := QuotedStr(strEmpPed);
    strEmpCal := QuotedStr(strEmpPed);
  End;

  FstrEmpSel := strEmpSel;

  strUniPcg := fCfgSis('UNIPCG');
  intDecUni := fCfgSis('DECUNI');
  strLitGal := fCfgSis('LITGAL');

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  pCriaTabelaFiltroItem(strEmpSel, strEmpCal, blnAnalisaITEFOR);

  fCarregaSaldoCotacao(strGirEmp, strEmpCal, strCodEmp);

  qryGenIte    := fCriaQuery;
  qryGenGir    := fCriaQuery;
  stlItensGiro := TStringList.Create;

  Screen.Cursor := crHourGlass;

  pMontaDatasGiro;

  fCarregaVendasPerdidas(strEmpSel, strEmpCal);

  pAbrePedido;

  If fEmptyStr(strNumPed) And fEmptyStr(strSeqCot) And
     ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido) Or (objRecupera.recPcmger.strPedMlj <> 'S')) Then
  Begin
    If Not fExecutaSQLGiroEstoque(qryGenGir, IntToStr(wrdAnoIni), IntToStr(wrdAnoFim),
             strCodEmp, strCodGru, strCodFor, strCodMar, strPrdGru, strGruCmp, strSitPro, strUnidade, strCodDep, intDiaVen, strAcoObj, strRefere, strDesIte, strCodCmp, arrCodFor, arrLinhaGrupo, arrMarca, arrPrdGru, arrGruCmp, arrSitPro, arrUnidade, arrCodDep,
            cdsEmpresasSel, slfLocFis, slsSaldos) Then
    Begin
      pLiberaComps;
      Result := False;
      Exit;
    End;
  End
  Else
  Begin
    If Not fExecutaSQLCarregarPedMultiLojas(qryGenGir, IntToStr(wrdAnoIni), IntToStr(wrdAnoFim),
         strCodEmp, strCodGru, strCodFor, strCodMar, strPrdGru, strGruCmp, strSitPro, strUnidade, strCodDep, intDiaVen, strAcoObj, strRefere, strDesIte, strNumPed, strEspPed, strCodCmp,
         arrCodFor, arrLinhaGrupo, arrMarca, arrPrdGru, arrGruCmp, arrSitPro, arrUnidade, arrCodDep, strGirEmp, cdsEmpresasSel) Then
    Begin
      pLiberaComps;
      Result := False;
      Exit;
    End;
  End;

  cdsItensPed.DisableControls;
  cdsItensPed.DisableConstraints;

  cdsItensMultLojas.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';

  Result := fRealizaCalculosGiro(dtaDataBase, cdsItensMultLojas, qryGenGir, blnConsEMin, blnConsEMax,
    blnConsMCom, blnArredSug, blnConsRequisicao, blnConsPedPen, blnConsPedVen, blnDescSalExt, blnConsMesAtu, blnConsOrdPro, blnConsGarPen, blnConsTransf, blnConsCot,
    intQtdMes, intMesMos,
    (Not fEmptyStr(strNumPed)) Or (Not fEmptyStr(strSeqCot)),
    blnAllIte, strFilGir, strCodFor, strEmpCal);

  If Not Result Then
  Begin
    pLiberaComps;
    Exit;
  End;

  cdsBkpDadosGiro := TUniClientDataSet.Create(Nil);
  cdsBkpDadosGiro.Data := cdsItensMultLojas.Data;
  cdsBkpDadosGiro.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';

  If (fEmptyStr(strNumPed) Or blnEncontrouGiro) And fEmptyStr(strSeqCot) And
     ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido) Or
        (objRecupera.recPcmger.blnRecuperaPedido And (Not fEmptyStr(strNumPed)))) Then
    Result := fSintetizaItensMultiLojas(strCodFor, cdsItensPed, cdsItensMultLojas, intQtdMes, intMesMos,
      blnAnalisaITEFOR, blnAllIte, blnConsMCom, blnArredSug, blnConsRequisicao, blnConsPedPen, blnConsPedVen, blnDescSalExt, blnConsEMin, blnConsEMax, blnConsTLoj, blnConsOrdPro, blnConsGarPen,
      blnConsTransf, blnConsCot,
      stlItensGiro, strPedMlj, strEmpAgr, blnSugInd, cdsEmpresasSel,
      qryGenGir, dtaDataBase,
      arrCodFor,
      arrLinhaGrupo,
      arrMarca,
      arrPrdGru,
      arrGruCmp,
      arrSitPro,
      arrUnidade,
      arrCodDep,
      strCodGru,
      strCodMar,
      strPrdGru,
      strGruCmp,
      strSitPro,
      strUnidade,
      strCodDep,
      intDiaVen,
      strAcoObj,
      strRefere,
      strDesIte);

  If Not Result then
  Begin
    pLiberaComps;
    Exit;
  End;
  {*******************************************}
  {* SEM GIRO DE ESTOQUE OU TODOS            *}
  {****************************************MV*}
  If (strFilGir <> 'C') And fEmptyStr(strNumPed) And fEmptyStr(strSeqCot) And
     ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido)) Then
  Begin

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fSQLSemGiroOuTodos);

      pSetaNomeFuncao(fugLendoItegerItensSemGiro);

      Try
        Open;
      Except

        On E: Exception Do
        Begin

          If Pos(strTableNameFILTRO_ITEM, E.Message) > 0 Then
          Begin
            pMensagemOk('Houve uma falha de conexão com o banco de dados, por favor tente novamente!');
            Result := False;
            Exit;
          End

          Else Raise;

        End;

      End;

      If strFilGir = 'S' Then
      Begin
        cdsItensPed.EmptyDataSet;
        cdsItensMultLojas.EmptyDataSet;
      End;

      pgbProgresso.Position := 0;
      pSetaNomeFuncao(fugCalculaGiroEstoque);
      pgbProgresso.Properties.Max := qryGenIte.RecordCount;
      Application.ProcessMessages;

      While (Not Eof) Do
      Begin
        fltDesUni := 0;

        If (strUniPcg = '1') Then
        Begin
          fltUnitar := qryGenIte.FieldByName('ITE_PRECOM').AsFloat;
        End
        Else If (strUniPcg = '2') Or (strUniPcg = '6') Then
        Begin
          fltUnitar := qryGenIte.FieldByName('ITE_PRECOM').AsFloat;
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF01').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF02').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF03').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF04').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF05').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF06').AsFloat / 100));
        End
        Else If (strUniPcg = '3') Then
        Begin
          fltUnitar := qryGenIte.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else If (strUniPcg = '4') Then
        Begin
          fltUnitar := qryGenIte.FieldByName('ITE_PRECOM').AsFloat;
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF01').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF02').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF03').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF04').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF05').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenIte.FieldByName('ITE_DESF06').AsFloat / 100));
          fltUnitar := fltUnitar + ( fltUnitar * (qryGenIte.FieldByName('ITE_ACRFIN').AsFloat  / 100 ) );
        End
        Else If (strUniPcg = '7') Then
        Begin
          fltUnitar := qryGenIte.FieldByName('ITE_PRECOM').AsFloat;

          fltDesUni := RoundTo((1 - (
                        (1 - qryGenIte.FieldByName('ITE_DESF01').AsFloat/100) *
                        (1 - qryGenIte.FieldByName('ITE_DESF02').AsFloat/100) *
                        (1 - qryGenIte.FieldByName('ITE_DESF03').AsFloat/100) *
                        (1 - qryGenIte.FieldByName('ITE_DESF04').AsFloat/100) *
                        (1 - qryGenIte.FieldByName('ITE_DESF05').AsFloat/100) *
                        (1 - qryGenIte.FieldByName('ITE_DESF06').AsFloat/100))) * 100, -2);
        End

        Else If (strUniPcg = '8') Then
        Begin
          fltUnitar := qryGenIte.FieldByName('ITE_PREULT').AsFloat;
        End

        Else fltUnitar := 0;

        fltUnitar  := fFormataFloatInterna(fltUnitar, intDecUni);

        strItemAnt := qryGenIte.FieldByName('ITE_CODITE').AsString;

        cdsItensPed.Append;
        pSalvaDadosComuns(cdsItensPed);

        While (Not Eof)                                                   And
              (qryGenIte.FieldByName('ITE_CODITE').AsString = strItemAnt) Do
        Begin

          If Not cdsItensMultLojas.FindKey([qryGenIte.FieldByName('ITE_CODITE').AsString,
                                            qryGenIte.FieldByName('ITE_CODEMP').AsString]) Then
          Begin
            cdsItensMultLojas.Append;

            pSalvaDadosComuns(cdsItensMultLojas);
          End Else
          Begin
            cdsItensMultLojas.Edit;
          End;

          cdsItensPed.FieldByName('ITE_SALGAR').AsFloat := cdsItensPed.FieldByName('ITE_SALGAR').AsFloat +
                                                             qryGenIte.FieldByName('ITE_SALGAR').AsFloat;

          cdsItensPed.FieldByName('ITE_SALTRA').AsFloat := cdsItensPed.FieldByName('ITE_SALTRA').AsFloat +
                                                             qryGenIte.FieldByName('ITE_SALTRA').AsFloat;

          cdsItensPed.FieldByName('ITE_SALEND').AsFloat := cdsItensPed.FieldByName('ITE_SALEND').AsFloat +
                                                             qryGenIte.FieldByName('ITE_SALEND').AsFloat;

          cdsItensPed.FieldByName('ITE_SALCOT').AsFloat := cdsItensPed.FieldByName('ITE_SALCOT').AsFloat +
                                                             fRetQtdCotacao(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                                                            qryGenIte.FieldByName('ITE_CODEMP').AsString);

          fltSaldosSug := qryGenIte.FieldByName('ITE_INIBAS').AsFloat - IfThen(blnConsPedVen, qryGenIte.FieldByName('ITE_SALRES').AsFloat, 0)
                                                                      - IfThen(blnDescSalExt, qryGenIte.FieldByName('ITE_SALEXT').AsFloat, 0)
                                                                      - IfThen(blnConsOrdPro, qryGenIte.FieldByName('ITE_QTPD_P').AsFloat, 0)

                                                                      - IfThen(blnConsGarPen, qryGenIte.FieldByName('ITE_SALGAR').AsFloat, 0)

                                                                      - IfThen(blnEntFutAguarda,  qryGenIte.FieldByName('ITE_QTEF_A').AsFloat, 0)
                                                                      - IfThen(blnEntFutFalta,    qryGenIte.FieldByName('ITE_QTEF_F').AsFloat, 0)
                                                                      - IfThen(blnEntFutPrevisao, qryGenIte.FieldByName('ITE_QTEF_P').AsFloat, 0)

                                                                      - fRetQtdVenPerCons(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                                                                          qryGenIte.FieldByName('ITE_CODEMP').AsString,
                                                                                          qryGenIte.FieldByName('ITE_NVLGIR').AsString) +

                                                                        IfThen(blnConsTransf, qryGenIte.FieldByName('ITE_SALTRA').AsFloat, 0) +

                                                                        fRetQtdCotacaoCons(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                                                                           qryGenIte.FieldByName('ITE_CODEMP').AsString) +

                                                                        IfThen(blnConsPedPen, qryGenIte.fieldbyname('ITE_QTDPEN').asfloat, 0) -

                                                                        IfThen(blnConsRequisicao, qryGenIte.fieldbyname('ITE_SALREQ').asfloat, 0);

          cdsItensPed.FieldByName('ITE_SALBAS').AsFloat := fltSaldosSug;
          cdsItensPed.FieldByName('ITE_TIPABS').Value := qryGenGir.FieldByName('ITE_TIPABS').Value;
          cdsItensPed.FieldByName('ITE_VNOLCD').Value := qryGenGir.FieldByName('ITE_VNOLCD').Value;
          {*****************************************}
          {* CALCULA A SUGESTÃO PARA ITENS SEM GIRO*}
          {**************************************MV*}
          If (blnConsEMin) Then
          Begin
            If (fltSaldosSug < qryGenIte.FieldByName('ITE_ESTMIN').AsFloat) Then
            Begin
              fltSugest  := qryGenIte.FieldByName('ITE_ESTMIN').AsFloat - fltSaldosSug;
            End
            Else If (fltSaldosSug < 0.0) Then
            Begin
              fltSugest  := (-1) * (fltSaldosSug);
            End
            Else
            Begin
              fltSugest  := 0.0;
            End;
          End
          Else  //DMELHORAR -> REPETIU UM CODIGO AQUI.
          Begin

            If (fltSaldosSug  < 0.0) Then
            Begin
              fltSugest  := (-1) * (fltSaldosSug);
            End
            Else
            Begin
              fltSugest  := 0.0;
            End;

          End;

          recNivEst.strIteGir := qryGenIte.FieldByName('ITE_NVLGIR').AsString;
          recNivEst.strIteCri := qryGenIte.FieldByName('ITE_NVLCRI').AsString;

          fltPerConTmp := fPercElevacaoConsumiveis(recNivEst);

          fltSugest := fElevaConsumiveis(fltSugest, fltPerConTmp, qryGenIte.FieldByName('ITE_CLACRM').AsString);

          If blnConsEMax And
            (qryGenIte.FieldByName('ITE_ESTMAX').AsFloat > 0) And
            (fltSugest + fltSaldosSug > qryGenIte.FieldByName('ITE_ESTMAX').AsFloat) Then
          Begin
            If fltSaldosSug > 0 Then
              fltSugest := qryGenIte.FieldByName('ITE_ESTMAX').AsFloat - fltSaldosSug
            Else
              fltSugest := qryGenIte.FieldByName('ITE_ESTMAX').AsFloat;

            If fltSugest < 0 Then
              fltSugest := 0;
          End;

          If blnAteMax Then
          Begin

            If (qryGenIte.FieldByName('ITE_ESTMAX').AsFloat > 0) Then
            Begin

              fltSugest := qryGenIte.FieldByName('ITE_ESTMAX').AsFloat;

              fltSugest := fltSugest - fltSaldosSug;

              If fltSugest < 0 Then
                fltSugest := 0;

            End

            Else fltSugest := 0;;

          End;

          fltQtdCal := fltSugest;
          If blnArredSug then
          Begin
            fltQtdCal := ceil(fltQtdCal);
          End;

          If (fltQtdCal > 0) And
             (blnEmpVis) And
             (opcChamada = chaSpoolTransferencia) And
             (qryGenGir.FieldByName('UNI_ITEFRA').AsString = 'N') And
             (frac(fltQtdCal) <> 0 ) Then
            fltQtdCal := ceil(fltQtdCal);

          //DMELHORAR
          If blnConsMCom Then
          Begin
            If Not fCalcularMultiploNaEmpresaCentralizadora(qryGenIte.fieldbyname('ITE_CPRCEN').AsString) Then
            Begin
              fltSugMult :=  (round(fltSugest / qryGenIte.fieldbyname('ITE_MLTCOM').asfloat)) * qryGenIte.fieldbyname('ITE_MLTCOM').asfloat;

              If fltSugMult < fltSugest Then
                fltSugest := (round(fltSugest / qryGenIte.fieldbyname('ITE_MLTCOM').asfloat) + 1) * qryGenIte.fieldbyname('ITE_MLTCOM').asfloat
              Else
                fltSugest := fltSugMult;
            End;
            If blnArredSug then
              fltSugest  := ceil(fltSugest);
          End
          Else
          Begin
            If blnArredSug then
            Begin
              fltSugest  := ceil(fltSugest);
            End;
          End;

          If (cdsItensMultLojas.FieldByName('ITE_CPRCEN').AsString = 'S') And
             (Pos(cdsItensMultLojas.FieldByName('ITE_EMPCEN').AsString, strEmpCal) = 0) Then
            fltSugest := 0;

          If blnPonPed Then
            cdsItensMultLojas.FieldByName('ITE_ABAPON').AsString := IfThen(((fltSaldosSug) > qryGenIte.FieldByName('ITE_PONPED').AsFloat), 'S', 'N')
          Else
            cdsItensMultLojas.FieldByName('ITE_ABAPON').AsString := 'N';

          If fEmptyStr(cdsItensPed.FieldByName('ITE_ABAPON').AsString) Then
            cdsItensPed.FieldByName('ITE_ABAPON').AsString := 'S';

          If cdsItensMultLojas.FieldByName('ITE_ABAPON').AsString = 'N' Then
            cdsItensPed.FieldByName('ITE_ABAPON').AsString := 'N';

          If blnPonPed And (cdsItensMultLojas.FieldByName('ITE_ABAPON').AsString = 'S') Then
             fltSugest := 0;

          Case slfLocFis Of
            slfComLocal: If fEmptyStr(qryGenIte.FieldByName('ITE_LOCFIS').AsString) Then
                           fltSugest := 0;

            slfSemLocal: If Not fEmptyStr(qryGenIte.FieldByName('ITE_LOCFIS').AsString) Then
                           fltSugest := 0;
          End;

          cdsItensMultLojas.FieldByName('ITE_QTEF_F').AsFloat := qryGenIte.FieldByName('ITE_QTEF_F').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_QTEF_A').AsFloat := qryGenIte.FieldByName('ITE_QTEF_A').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_QTEF_P').AsFloat := qryGenIte.FieldByName('ITE_QTEF_P').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_QTPD_P').AsFloat := qryGenIte.FieldByName('ITE_QTPD_P').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_SALDOS').AsFloat := qryGenIte.FieldByName('ITE_SALDOS').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_SALFIS').AsFloat := qryGenIte.FieldByName('ITE_SALFIS').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_INIBAS').AsFloat := qryGenIte.FieldByName('ITE_INIBAS').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_SALRES').AsFloat := qryGenIte.FieldByName('ITE_SALRES').AsFloat;

          cdsItensMultLojas.FieldByName('ITE_SALBAS').AsFloat := cdsItensMultLojas.FieldByName('ITE_INIBAS').AsFloat -
                                                                             ( IfThen(blnConsPedVen, cdsItensMultLojas.FieldByName('ITE_SALRES').AsFloat, 0) +
                                                                               IfThen(blnDescSalExt, cdsItensMultLojas.FieldByName('ITE_SALEXT').AsFloat, 0) +
                                                                               IfThen(blnConsOrdPro, cdsItensMultLojas.FieldByName('ITE_QTPD_P').AsFloat, 0) +

                                                                               IfThen(blnConsGarPen, cdsItensMultLojas.FieldByName('ITE_SALGAR').AsFloat, 0) +

                                                                               IfThen(blnEntFutAguarda,  cdsItensMultLojas.FieldByName('ITE_QTEF_A').AsFloat, 0) +
                                                                               IfThen(blnEntFutFalta,    cdsItensMultLojas.FieldByName('ITE_QTEF_F').AsFloat, 0) +
                                                                               IfThen(blnEntFutPrevisao, cdsItensMultLojas.FieldByName('ITE_QTEF_P').AsFloat, 0) +

                                                                               fRetQtdVenPerCons(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                                                                                 qryGenIte.FieldByName('ITE_CODEMP').AsString,
                                                                                                 qryGenIte.FieldByName('ITE_NVLGIR').AsString)
                                                                              ) +

                                                                              IfThen(blnConsTransf, qryGenIte.FieldByName('ITE_SALTRA').AsFloat, 0) +

                                                                              fRetQtdCotacaoCons(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                                                                                 qryGenIte.FieldByName('ITE_CODEMP').AsString) +

                                                                              IfThen(blnConsPedPen, qryGenIte.fieldbyname('ITE_QTDPEN').asfloat, 0) -
                                                                              IfThen(blnConsRequisicao, qryGenIte.fieldbyname('ITE_SALREQ').asfloat, 0);


          If blnEmpVis And (Pos(qryGenIte.FieldByName('ITE_CODEMP').AsString, strEmpCal) = 0) Then
            fltSugest := 0;

          If blnEmpVis And (opcChamada = chaSpoolTransferencia) Then
          Begin

            Case slsSaldosDestino Of
              slsMenorOuIgualZero   : If Not (cdsItensMultLojas.FieldByName('ITE_SALBAS').AsFloat <= 0) Then
                                        fltSugest := 0;

              slsAbaixoMinimo       : If Not (cdsItensMultLojas.FieldByName('ITE_SALBAS').AsFloat < qryGenIte.FieldByName('ITE_ESTMIN').AsFloat) Then
                                        fltSugest := 0;

              slsAcimaOuIgualMinimo : If Not (cdsItensMultLojas.FieldByName('ITE_SALBAS').AsFloat >= qryGenIte.FieldByName('ITE_ESTMIN').AsFloat) Then
                                        fltSugest := 0;

            End;

          End;

          fltTotIte := fltSugest * RoundTo(fltUnitar * (1 - fltDesUni / 100), -intDecUni);

          fltBasIpi := fltTotIte;
          fltTotIpi := fltTotIte * cdsItensPed.FieldByName('ITE_PERIPI').AsFloat / 100;

          fltBasSub := fltTotIte;
          fltTotSub := fltTotIte * cdsItensPed.FieldByName('ITE_PERSUB').AsFloat / 100;

          fltLitros := fltSugest * qryGenIte.FieldByName('UNI_PESLIT').AsFloat;

          If SameText(strLitGal, 'G') Then
            fltLitros := fltLitros / FLT_LITRO_GALAO;

          fltPesoit := fltSugest * qryGenIte.FieldByName('ITE_PESOIT').AsFloat;

          fltVenMes := fRetVendasMesItem(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                         IIF(blnAgrSim And (qryGenIte.FieldByName('ITE_PRISIM').AsString = 'S'), qryGenIte.FieldByName('ITE_CODSIM').AsString, ''),
                                         qryGenIte.FieldByName('ITE_CODEMP').AsString,
                                         MOnthOf(VS_Date),
                                         YearOf(VS_Date),
                                         False);

          fltProMes := fRetVendasMesItem(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                         IIF(blnAgrSim And (qryGenIte.FieldByName('ITE_PRISIM').AsString = 'S'), qryGenIte.FieldByName('ITE_CODSIM').AsString, ''),
                                         qryGenIte.FieldByName('ITE_CODEMP').AsString,
                                         MOnthOf(VS_Date),
                                         YearOf(VS_Date),
                                         True);

          cdsItensMultLojas.FieldByName('ITE_ESTMIN').AsFloat := qryGenIte.FieldByName('ITE_ESTMIN').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_ESTMAX').AsFloat := qryGenIte.FieldByName('ITE_ESTMAX').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_PMED_V').AsFloat := qryGenIte.FieldByName('ITE_PMED_V').AsFloat;

          cdsItensMultLojas.FieldByName('ITE_MINDIG').AsFloat := qryGenIte.FieldByName('ITE_MINDIG').AsFloat;
          cdsItensMultLojas.FieldByName('ITE_MAXDIG').AsFloat := qryGenIte.FieldByName('ITE_MAXDIG').AsFloat;

          cdsItensMultLojas.FieldByName('ITE_PONPED').AsFloat := qryGenIte.FieldByName('ITE_PONPED').AsFloat;

          If fltSugest = 0 Then
            fltQtdCal := 0;

          cdsItensMultLojas.FieldByName('ITE_QTDCAL').AsFloat := fltQtdCal;
          cdsItensMultLojas.FieldByName('ITE_SUGEST').AsFloat := fltSugest;
          cdsItensMultLojas.FieldByName('ITE_SUGESTORI').AsFloat := fltQtdCal;
          cdsItensMultLojas.FieldByName('ITE_QTDITE').AsFloat := fltSugest;
          cdsItensMultLojas.FieldByName('ITE_TOTITE').AsFloat := fltTotIte;

          cdsItensMultLojas.FieldByName('ITE_BASIPI').AsFloat := fltTotIte;
          cdsItensMultLojas.FieldByName('ITE_TOTIPI').AsFloat := fltTotIpi;

          pCopiaAliquotasReforma(cdsItensPed, cdsItensMultLojas, False);

          cdsItensMultLojas.FieldByName('ITE_BASSUB').AsFloat := fltTotIte;
          cdsItensMultLojas.FieldByName('ITE_TOTSUB').AsFloat := fltTotSub;

          cdsItensMultLojas.FieldByName('ITE_VENMES').AsFloat := fltVenMes;
          CdsItensMultLojas.FieldByName('ITE_Q_VPME').AsFloat := fltProMes;
          cdsItensMultLojas.FieldByName('ITE_QTDPEN').AsFloat := qryGenIte.fieldbyname('ITE_QTDPEN').asfloat;
          cdsItensMultLojas.FieldByName('ITE_SALREQ').AsFloat := qryGenIte.fieldbyname('ITE_SALREQ').asfloat;

          cdsItensMultLojas.FieldByName('ITE_VENPER').AsFloat := fRetQtdVenPer(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                                                               qryGenIte.FieldByName('ITE_CODEMP').AsString,
                                                                               qryGenIte.FieldByName('ITE_NVLGIR').AsString);

          cdsItensMultLojas.FieldByName('ITE_LITROS').AsFloat := fltLitros;
          cdsItensMultLojas.FieldByName('ITE_PESOIT').AsFloat := fltPesoit;

          strEmpBus := qryGenIte.FieldByName('EMP_CODEMP').AsString;

          If cdsBkpDadosGiro.FindKey([strItemAnt, strEmpBus]) Then
          Begin
            For intContadorMes := 1 To 12 {intQtdMes} Do
            Begin
              cdsItensMultLojas.FieldByName('ITE_Q_V_' + fInd(intContadorMes)).AsFloat    := cdsBkpDadosGiro.FieldByName('ITE_Q_V_' + fInd(intContadorMes)).AsFloat;
              cdsItensMultLojas.FieldByName('ITE_Q_VP' + fInd(intContadorMes)).AsFloat    := cdsBkpDadosGiro.FieldByName('ITE_Q_VP' + fInd(intContadorMes)).AsFloat;
              cdsItensMultLojas.FieldByName('ITE_Q_C_' + fInd(intContadorMes)).AsFloat    := cdsBkpDadosGiro.FieldByName('ITE_Q_C_' + fInd(intContadorMes)).AsFloat;
              cdsItensMultLojas.FieldByName('ITE_DESM' + fInd(intContadorMes)).AsString   := cdsBkpDadosGiro.FieldByName('ITE_DESM' + fInd(intContadorMes)).AsString;

              cdsItensMultLojas.FieldByName('ITE_MQSA' + fInd(intContadorMes)).AsFloat    := cdsBkpDadosGiro.FieldByName('ITE_MQSA' + fInd(intContadorMes)).AsFloat;
              cdsItensMultLojas.FieldByName('ITE_MDSA' + fInd(intContadorMes)).AsDateTime := cdsBkpDadosGiro.FieldByName('ITE_MDSA' + fInd(intContadorMes)).AsDateTime;
            End;
          End;

          If cdsItensMultLojas.FieldByName('ITE_QTDEMB').IsNull Or (cdsItensMultLojas.FieldByName('ITE_QTDEMB').AsFloat = 0) Then
            cdsItensMultLojas.FieldByName('ITE_QTDEMB').AsFloat := 1;

          If cdsItensMultLojas.FieldByName('ITE_QTDTRA').IsNull Then
            cdsItensMultLojas.FieldByName('ITE_QTDTRA').AsFloat := 0;

          pCalculaVariacaoCompra(cdsItensMultLojas);

         fltSalExc := cdsItensMultLojas.FieldByName('ITE_SALDIS').AsFloat - (IfThen(blnMedAju, cdsItensMultLojas.FieldByName('ITE_AJUSTA').AsFloat, cdsItensMultLojas.FieldByName('ITE_MEDIA_').AsFloat) / 30) * intQtdMes;

         If fltSalExc < 0 Then
            fltSalExc := 0;

         cdsItensMultLojas.FieldByName('ITE_SALEXC').AsFloat := fltSalExc;


          cdsItensMultLojas.Post;

          If (Not blnEmpVis) Or (Pos(qryGenIte.FieldByName('ITE_CODEMP').AsString, strEmpCal) > 0) Then
          Begin

            For intContadorMes := 1 To 12 {intQtdMes} Do
            Begin
              cdsItensPed.FieldByName('ITE_Q_V_' + fInd(intContadorMes)).AsFloat    := cdsItensPed.FieldByName('ITE_Q_V_' + fInd(intContadorMes)).AsFloat + cdsItensMultLojas.FieldByName('ITE_Q_V_' + fInd(intContadorMes)).AsFloat;
              cdsItensPed.FieldByName('ITE_Q_VP' + fInd(intContadorMes)).AsFloat    := cdsItensPed.FieldByName('ITE_Q_VP' + fInd(intContadorMes)).AsFloat + cdsItensMultLojas.FieldByName('ITE_Q_VP' + fInd(intContadorMes)).AsFloat;
              cdsItensPed.FieldByName('ITE_Q_C_' + fInd(intContadorMes)).AsFloat    := cdsItensPed.FieldByName('ITE_Q_C_' + fInd(intContadorMes)).AsFloat + cdsItensMultLojas.FieldByName('ITE_Q_C_' + fInd(intContadorMes)).AsFloat;
              cdsItensPed.FieldByName('ITE_DESM' + fInd(intContadorMes)).AsString   := cdsItensPed.FieldByName('ITE_DESM' + fInd(intContadorMes)).AsString + cdsItensMultLojas.FieldByName('ITE_DESM' + fInd(intContadorMes)).AsString;

              If cdsItensPed.FieldByName('ITE_MQSA' + fInd(intContadorMes)).AsFloat < cdsItensMultLojas.FieldByName('ITE_MQSA' + fInd(intContadorMes)).AsFloat Then
              Begin
                cdsItensPed.FieldByName('ITE_MQSA' + fInd(intContadorMes)).AsFloat    := cdsItensMultLojas.FieldByName('ITE_MQSA' + fInd(intContadorMes)).AsFloat;
                cdsItensPed.FieldByName('ITE_MDSA' + fInd(intContadorMes)).AsDateTime := cdsItensMultLojas.FieldByName('ITE_MDSA' + fInd(intContadorMes)).AsDateTime;
              End;
            End;

            cdsItensPed.FieldByName('ITE_SUGEST').AsFloat := cdsItensPed.FieldByName('ITE_SUGEST').AsFloat + fltSugest;
            cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat + fltSugest;

            cdsItensPed.FieldByName('ITE_QTDINC').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat;

            cdsItensPed.FieldByName('ITE_TOTITE').AsFloat := cdsItensPed.FieldByName('ITE_TOTITE').AsFloat + fltTotIte;

            cdsItensPed.FieldByName('ITE_BASIPI').AsFloat := cdsItensPed.FieldByName('ITE_BASIPI').AsFloat + fltBasIpi;
            cdsItensPed.FieldByName('ITE_TOTIPI').AsFloat := cdsItensPed.FieldByName('ITE_TOTIPI').AsFloat + fltTotIpi;

            pCalculaImpostosReformaItem(cdsItensPed, False);

            cdsItensPed.FieldByName('ITE_BASSUB').AsFloat := cdsItensPed.FieldByName('ITE_BASSUB').AsFloat + fltBasSub;
            cdsItensPed.FieldByName('ITE_TOTSUB').AsFloat := cdsItensPed.FieldByName('ITE_TOTSUB').AsFloat + fltTotSub;

            cdsItensPed.FieldByName('ITE_VENMES').AsFloat := cdsItensPed.FieldByName('ITE_VENMES').AsFloat + fltVenMes;
            cdsItensPed.FieldByName('ITE_Q_VPME').AsFloat := cdsItensPed.FieldByName('ITE_Q_VPME').AsFloat + fltProMes;
            cdsItensPed.FieldByName('ITE_QTDPEN').AsFloat := cdsItensPed.FieldByName('ITE_QTDPEN').AsFloat + qryGenIte.fieldbyname('ITE_QTDPEN').asfloat;

            cdsItensPed.FieldByName('ITE_SALRES').AsFloat := cdsItensPed.FieldByName('ITE_SALRES').AsFloat + qryGenIte.FieldByName('ITE_SALRES').AsFloat;

            cdsItensPed.FieldByName('ITE_VENPER').AsFloat := cdsItensPed.FieldByName('ITE_VENPER').AsFloat +
                                                               fRetQtdVenPer(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                                                             qryGenIte.FieldByName('ITE_CODEMP').AsString,
                                                                             qryGenIte.FieldByName('ITE_NVLGIR').AsString);

            cdsItensPed.FieldByName('ITE_LITROS').AsFloat := cdsItensPed.FieldByName('ITE_LITROS').AsFloat + fltLitros;
            cdsItensPed.FieldByName('ITE_PESOIT').AsFloat := cdsItensPed.FieldByName('ITE_PESOIT').AsFloat + fltPesoit;

            cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat := cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat + qryGenIte.FieldByName('ITE_QTEF_F').AsFloat;;
            cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat := cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat + qryGenIte.FieldByName('ITE_QTEF_A').AsFloat;;
            cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat := cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat + qryGenIte.FieldByName('ITE_QTEF_P').AsFloat;;
            cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat := cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat + qryGenIte.FieldByName('ITE_QTPD_P').AsFloat;;
            cdsItensPed.FieldByName('ITE_SALDOS').AsFloat := cdsItensPed.FieldByName('ITE_SALDOS').AsFloat + qryGenIte.FieldByName('ITE_SALDOS').AsFloat;;
            cdsItensPed.FieldByName('ITE_SALDIS').AsFloat := cdsItensPed.FieldByName('ITE_SALDIS').AsFloat + qryGenIte.FieldByName('ITE_SALDIS').AsFloat;;
            cdsItensPed.FieldByName('ITE_SALEXT').AsFloat := cdsItensPed.FieldByName('ITE_SALEXT').AsFloat + qryGenIte.FieldByName('ITE_SALEXT').AsFloat;;
            cdsItensPed.FieldByName('ITE_SALFIS').AsFloat := cdsItensPed.FieldByName('ITE_SALFIS').AsFloat + qryGenIte.FieldByName('ITE_SALFIS').AsFloat;;
            cdsItensPed.FieldByName('ITE_INIBAS').AsFloat := cdsItensPed.FieldByName('ITE_INIBAS').AsFloat + qryGenIte.FieldByName('ITE_INIBAS').AsFloat;;

            cdsItensPed.FieldByName('ITE_SALBAS').AsFloat := cdsItensPed.FieldByName('ITE_INIBAS').AsFloat -

                                                                               ( IfThen(blnConsPedVen, cdsItensPed.FieldByName('ITE_SALRES').AsFloat, 0) +

                                                                                 IfThen(blnDescSalExt, cdsItensPed.FieldByName('ITE_SALEXT').AsFloat, 0) +

                                                                                 IfThen(blnConsOrdPro, cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat, 0) +

                                                                                 IfThen(blnConsGarPen, cdsItensPed.FieldByName('ITE_SALGAR').AsFloat, 0) +

                                                                                 IfThen(blnEntFutAguarda,  cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat, 0) +
                                                                                 IfThen(blnEntFutFalta,    cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat, 0) +
                                                                                 IfThen(blnEntFutPrevisao, cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat, 0) +

                                                                                 IfThen(blnVenPer, cdsItensPed.FieldByName('ITE_VENPER').AsFloat, 0)
                                                                                ) +

                                                                                IfThen(blnConsTransf, cdsItensPed.FieldByName('ITE_SALTRA').AsFloat, 0) +
                                                                                IfThen(blnConsCot,    cdsItensPed.FieldByName('ITE_SALCOT').AsFloat, 0) +
                                                                                IfThen(blnConsPedPen, cdsItensPed.fieldbyname('ITE_QTDPEN').asfloat, 0) -
                                                                                IfThen(blnConsRequisicao, qryGenIte.fieldbyname('ITE_SALREQ').asfloat, 0);

            cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat := cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat + qryGenIte.FieldByName('ITE_ESTMIN').AsFloat;
            cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat := cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat + qryGenIte.FieldByName('ITE_ESTMAX').AsFloat;

            cdsItensPed.FieldByName('ITE_MINDIG').AsFloat := cdsItensPed.FieldByName('ITE_MINDIG').AsFloat + qryGenIte.FieldByName('ITE_MINDIG').AsFloat;
            cdsItensPed.FieldByName('ITE_MAXDIG').AsFloat := cdsItensPed.FieldByName('ITE_MAXDIG').AsFloat + qryGenIte.FieldByName('ITE_MAXDIG').AsFloat;


            cdsItensPed.FieldByName('ITE_PONPED').AsFloat := cdsItensPed.FieldByName('ITE_PONPED').AsFloat + qryGenIte.FieldByName('ITE_PONPED').AsFloat;
          End; {If (Not blnEmpVis) Or (Pos(qryGenIte.FieldByName('ITE_CODEMP').AsString, strEmpCal) > 0) Then}

          {********************************************************}
          {* CASO SEJA AGRUPAMENTO EM UMA EMPRESA E TENHA OPTADO  *}
          {* POR CALCULAR DE FORMA GLOBAL A SUGESTAO              *}
          {********************************************************}
          If fCalculaSugestaoAgregada(strEmpAgr, blnSugInd) Then
          Begin
            recNivEst.strIteGir := cdsItensPed.FieldByName('GIRSINT').AsString;
            recNivEst.strIteCri := cdsItensPed.FieldByName('CRISINT').AsString;

            intDiasCompraAgreg := fDiasCompra(recNivEst);
            fltPerConAgreg     := fPercElevacaoConsumiveis(recNivEst);

            cdsItensPed.FieldByName('ITE_SUGEST').AsFloat := fCalculaSugestaoCompra(intQtdMes,
                                                                                    intDiasCompraAgreg,
                                                                                    IfThen(blnMedAju, cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat,
                                                                                                    cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat) * intQtdMes,
                                                                                    cdsItensPed.FieldByName('ITE_SALREQ').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_QTDPEN').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_SALRES').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_INIBAS').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_MLTCOM').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_SALGAR').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_SALTRA').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_SALCOT').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_VENPER').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_SALEXT').AsFloat,
                                                                                    fltPerConAgreg,
                                                                                    cdsItensPed.FieldByName('ITE_PONPED').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat,
                                                                                    cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat,
                                                                                    blnConsRequisicao,
                                                                                    blnConsPedPen,
                                                                                    blnConsPedVen,
                                                                                    blnDescSalExt,
                                                                                    blnConsEMin,
                                                                                    blnConsEMax,
                                                                                    blnConsMCom,
                                                                                    blnArredSug,
                                                                                    blnConsOrdPro,
                                                                                    blnConsGarPen,
                                                                                    blnConsTransf,
                                                                                    blnConsCot,
                                                                                    blnVenPer,
                                                                                    blnVenPerMed,
                                                                                    blnConsEndere,
                                                                                    blnPonPed,
                                                                                    blnAteMax,
                                                                                    blnEntFutPrevisao,
                                                                                    blnEntFutFalta,
                                                                                    blnEntFutAguarda,
                                                                                    cdsItensPed.FieldByName('ITE_CLACRM').AsString,
                                                                                    blnAbaixoPonPed,
                                                                                    fltQtdCal);

            cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := cdsItensPed.FieldByName('ITE_SUGEST').AsFloat;

            cdsItensPed.FieldByName('ITE_QTDINC').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat;

            cdsItensPed.FieldByName('ITE_QTDCAL').AsFloat := fltQtdCal;
            cdsItensPed.FieldByName('ITE_SUGESTORI').AsFloat := fltQtdCal;
          End;

          If ((Not fConsidera_EmpAgr_Vazio(strEmpAgr)) And
             (cdsItensMultLojas.FieldByName('ITE_CODEMP').AsString <> strEmpAgr)) Then
          Begin
            If (cdsItensMultLojas.FindKey([strItemAnt, FieldByName('ITE_CODEMP').AsString])) Then
            Begin
              cdsItensMultLojas.Edit;
              cdsItensMultLojas.FieldByName('ITE_QTDITE').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_QTDCAL').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_SUGESTORI').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_TOTITE').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_PERIPI').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_PERSUB').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_TOTSUB').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_TOTDAR').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_TOTIPI').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_VALCBS').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_VALIBS').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_VAL_IS').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_ALQIMP').AsFloat := 0;
              cdsItensMultLojas.FieldByName('ITE_VALIMP').AsFloat := 0;

              pCalculaVariacaoCompra(cdsItensMultLojas);

              cdsItensMultLojas.Post;
            End;
          End;

          Next;
          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;

        End;  { While (Not Eof)                                                   And
              (qryGenIte.FieldByName('ITE_CODITE').AsString = strItemAnt) Do }

        If fCalculaSugestaoAgregada(strEmpAgr, blnSugInd) And
           ((Not fConsidera_EmpAgr_Vazio(strEmpAgr)) And cdsItensMultLojas.FindKey([cdsItensPed.FieldByName('ITE_CODITE').AsString, strEmpAgr])) Then
            pAjustaCompraCentraLizada(cdsItensPed.FieldByName('ITE_QTDITE').AsFloat,
                                      cdsItensPed.FieldByName('ITE_QTDCAL').AsFloat,
                                      0,
                                      0,
                                      cdsItensMultLojas, cdsItensPed, intDecUni, False);

        If (cdsItensPed.FieldByName('ITE_ABAPON').AsString = 'S') Then
        Begin
          cdsItensPed.Cancel;
          pLimpaSugestao;
        End

        Else If FopcGir.blnVenEsp And
           fEmptyStr(strSeqCot) And fEmptyStr(strNumPedUmaLoja) And fEmptyStr(strNumPed) And
           (cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat = 0) And
           (cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat = 0) And
           (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat >= 0) And
           ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido)) Then
        Begin
          cdsItensPed.Cancel;
        End

        Else If (blnAllIte) Then
        Begin
          If FopcGir.blnVenEsp And
             fEmptyStr(strSeqCot) And fEmptyStr(strNumPedUmaLoja) And fEmptyStr(strNumPed) And
             (cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat = 0) And
             (cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat = 0) And
             (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat < 0) And
             ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido)) Then
          Begin
            cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := - cdsItensPed.FieldByName('ITE_SALBAS').AsFloat;

            cdsItensPed.FieldByName('ITE_SUGEST').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat;
          End;

          If cdsItensPed.FieldByName('ITE_QTDEMB').IsNull Or (cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat = 0) Then
            cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat := 1;

          If cdsItensPed.FieldByName('ITE_QTDTRA').IsNull Then
            cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat := 0;

          pCalculaVariacaoCompra(cdsItensPed);

          cdsItensPed.FieldByName('ITE_TRAINC').AsFloat :=  cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat;

          cdsItensPed.FieldByName('ITE_QTDALT').AsString := 'N';
          cdsItensPed.FieldByName('ITE_TIPABS').Value := qryGenGir.FieldByName('ITE_TIPABS').Value;
          cdsItensPed.FieldByName('ITE_VNOLCD').Value := qryGenGir.FieldByName('ITE_VNOLCD').Value;

          cdsItensPed.Post;
        End
        Else
        Begin

          If cdsItensPed.FieldByName('ITE_QTDITE').AsFloat <= 0 Then
          Begin
            cdsItensPed.Cancel;
            pLimpaSugestao;
          End;

        End;

      End;

      Close
    End;

  End;

  cdsItensPed.EnableControls;

  pLiberaComps;

  Screen.Cursor := crDefault;
  Result := True;

//  pMensagemOk( FormatDateTime('HH:NN:SS', T2));
end;

function fCalculaSugestaoCompra(intQtdMes, intDiaCom: Integer; fltQtdSai, fltQtdReq, fltQtdPen, fltSalRes, fltOrdPro,
  fltSalFis, fltEstMin, fltEstMax,
  fltMltCom,
  fltQtdGar, fltSalTransf, fltSalCot, fltVenPer, fltSalExt, fltPerCon, fltPonPed,
  fltEntAgu, fltEntFal, fltEntPre: Double;
  blnConsRequisicao,
  blnConsPedPen, blnConsPedVen, blnDescSalExt, blnConsEMin,
  blnConsEMax, blnConsMCom, blnArredSug, blnConsOrdPro, blnConsGarPen, blnConsTransf, blnConsCot,
  blnVenPer, blnVenPerMed, blnConsEndere, blnPonPed, blnAteMax,
  blnEntFutPrevisao,
  blnEntFutFalta,
  blnEntFutAguarda: Boolean;
  strClaCrm: String; Var blnAbaixoPonPed: Boolean; Var fltQtdCal: Double): Double;
  var
    fltSalBas,
    fltSugMult: Double;
begin
  fltSalBas := fltSalFis;

  If blnEntFutPrevisao Then
    fltSalBas := fltSalBas - fltEntPre;

  If blnEntFutAguarda Then
    fltSalBas := fltSalBas - fltEntAgu;

  If blnEntFutFalta Then
    fltSalBas := fltSalBas - fltEntFal;

  If blnConsPedVen Then
    fltSalBas := fltSalBas - fltSalRes;

  If blnDescSalExt Then
    fltSalBas := fltSalBas - fltSalExt;


  If blnConsOrdPro Then
    fltSalBas := fltSalBas - fltOrdPro;

  If blnVenPer Then
    fltSalBas := fltSalBas - fltVenPer;

  If blnConsTransf Then
    fltSalBas := fltSalBas + fltSalTransf;

  If blnConsCot Then
    fltSalBas := fltSalBas + fltSalCot;

  If blnConsGarPen Then
    fltSalBas := fltSalBas - fltQtdGar;

  If blnConsPedPen Then
    fltSalBas := fltSalBas + fltQtdPen;

  If blnConsRequisicao Then
    fltSalBas := fltSalBas - fltQtdReq;

  Result := ( ( ( ( fltQtdSai / intQtdMes) / 30) * intDiaCom) - fltSalBas);
  Result := fFormataFloatInterna(Result, 2);

  If (Result <= 0) Then
    Result := 0;

  fltQtdCal := Result;
  {*****************************************}
  {* CASO CONSIDERE O ESTOQUE MINIMO       *}
  {**************************************MV*}
  If blnConsEMin Then
  Begin
    If (Result + fltSalBas < fltEstMin) Then
    Begin
      Result := fltEstMin - fltSalBas;
    End;
  End;

  If (Result <= 0) Then
    Result := 0;

  If (Result > 0) Or blnAteMax Then
  Begin

    Result := fElevaConsumiveis(Result, fltPerCon, strClaCRM);

    If blnConsEMax And (fltEstMax > 0) And (Result + fltSalBas > fltEstMax) Then
    Begin
      If fltSalBas > 0 Then
        Result := fltEstMax - fltSalBas
      Else
        Result := fltEstMax;
      If Result < 0 Then
        Result := 0;
    End;

    If blnAteMax Then
    Begin

      If (fltEstMax > 0) Then
      Begin
        Result := fltEstMax;

        Result := Result - fltSalBas;

        If Result < 0 Then
          Result := 0;
      End

      Else Result := 0;

    End;

    fltQtdCal := Result;
  End;

  If blnArredSug then
  Begin
    fltQtdCal := ceil(fltQtdCal);
  End;

  {*****************************************}
  {* REALIZA OPERAÇÕES SOBRE A SUGESTÃO    *}
  {**************************************MV*}
  If blnConsMCom Then
  Begin
    fltSugMult :=  (round(Result / fltMltCom)) * fltMltCom;

    If fltSugMult < Result Then
      Result := (round(Result / fltMltCom) + 1) * fltMltCom
    Else
      Result := fltSugMult;

    If blnArredSug then
      Result  := ceil(Result);
  End
  Else
  Begin
    If blnArredSug then
    Begin
      Result  := ceil(Result);
    End;
  End;


  If blnPonPed And (fltPonPed > 0) Then
  Begin
    blnAbaixoPonPed := fltSalBas > fltPonPed;
  End Else
  Begin
    blnAbaixoPonPed := False;
  End;

  If blnAbaixoPonPed Then
    Result := 0;

  If Result = 0 Then
    fltQtdCal := 0;
end;

Function TGiroPedido.fGetValorGirIte(qryGenGir: TUniQuery; strNomCam: String): Double;
Begin
  If qryGenGir.FieldByName('VALIDO').AsString = 'S' Then
    Result := qryGenGir.FieldByName(strNomCam).AsFloat
  Else
    Result := 0;
End;

{*****************************************}
{* ESSA FUNÇÃO REALIZA EFETIVAMENTE OS   *}
{* CÁLCULOS DO GIRO, COMO ARREDONDAR A   *}
{* SUGESTÃO, CONSIDERAR EST. MINIMO, ETC *}
{**************************************MV*}
function TGiroPedido.fRealizaCalculosGiro(dtaDataBase: TDateTime; cdsItensPed: TUniClientDataSet; qryGenGir: TUniQuery;
  blnConsEMin, blnConsEMax, blnConsMCom, blnArredSug, blnConsRequisicao, blnConsPedPen, blnConsPedVen, blnDescSalExt, blnConsMesAtu, blnConsOrdPro, blnConsGarPen,
  blnConsTransf, blnConsCot: Boolean;
  intQtdMes, intMesMos: Integer; blnAltPed, blnAllIte: Boolean;
  strFilGir: String; strCodFor, strEmpCal: String): Boolean;
  Var
    fltMedia_ : Double;
    fltMedAju : Double;
    fltQtdCal,
    fltSugest: Double;
    fltSugReal: Double;

    intDiaSaiMesAtual,
    intDiaSai: Integer;
    fltQtdPromoc: Double;
    fltQtdSai: Double;
    fltQtdEnt: Double;
    fltMaiSai: Double;
    dtaMaiSai: TDateTime;
    wrdAnoAnt: Integer;
    strItemAnt: String;
    wrdAno: Word;
    wrdMes: Word;
    wrdDia: Word;
    arrDatas: Array Of TDateTime;
    wrdAnoIni: Word;
    wrdAnoFim: Word;

    intContador1: Integer;
    fldQtdVen: TField;
    fldQtdVenProm: TField;
    fldQtdEnt: TField;
    fldDesMes: TField;

    bkmItemEmpresaAtual: TBookmark;
    bkmUltimoRegItem   : TBookmark;

    fltPosUltimoRegItem: Double;
    fltPosItemEmpresaAtual: Double;

    strLitGal,
    strUniPcg: String;
    fltUnitar: Double;
    fltDesUni: Double;
    intDecUni: Integer;
    fltSugMult: Double;
    fltLitrag: Double;
    fltPesoit: Double;
    dtaBaseTmp: TDateTime;

    fltQtdMlj: Double;
    fltQtdIte: Double;

    strEmpAtu: String;
    blnTevGir: Boolean;
    fltPreIteFor: Double;
    intDiaComTmp: Integer;

    fltPerConTmp,
    fltSaldosSug: Double;

    intDiaMaior,
    intDiaMenor: Integer; // quantidade de dias do maior mês de venda e do menor mês de venda

    intDiaSaiMaior,
    intDiaSaiMenor: Integer; // quantidade de dias com estoque do maior mês de venda e do menor mês de venda

    fltSaiMaior,
    fltSaiMenor: Double; // quantidade de saída do maior mês de venda e do menor mês de venda

    fltSalExc: Double;
    lstrCodEmp: String;
begin
  Result := True;
  lstrCodEmp := VS_strCodEmp;
  pSetaNomeFuncao(fugIndexandoTabela);

  SetLength(arrDatas, 12 {intQtdMes});

  {*****************************************}
  {* GERA AS DATAS DO GIRO                 *}
  {**************************************MV*}
  For intContador1 := 0 To 12 {intQtdMes} -1 Do
  Begin
    arrDatas[intContador1] := EncodeDate(fRetAno(Succ(intContador1)), fRetMes(Succ(intContador1)), 1);
  End;

  strUniPcg := fCfgSis('UNIPCG');
  intDecUni := fCfgSis('DECUNI');
  strLitGal := fCfgSis('LITGAL');

  qryGenGir.First;

  pSetaNomeFuncao(fugRealizaCalculosGiro);
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := qryGenGir.RecordCount;
  Application.ProcessMessages;

  If Not Sametext(cdsItensPed.IndexFieldNames, 'ITE_CODITE;ITE_CODEMP') Then
    cdsItensPed.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';

  {*****************************************}
  {* PROCESSANDO GIRITE                    *}
  {**************************************MV*}
  While Not qryGenGir.Eof Do
  Begin
    Application.ProcessMessages;

    blnTevGir := False;
    strItemAnt  := qryGenGir.FieldByName('GIR_CODITE').AsString;

    DecodeDate(dtaDataBase, wrdAno, wrdMes, wrdDia);

    While (Not qryGenGir.Eof)                                         And
          (strItemAnt = qryGenGir.FieldByName('GIR_CODITE').AsString) Do
    Begin
      {*****************************************}
      {* SALVO A POSIÇÃO INICIAL DO ITEM       *}
      {**************************************MV*}
      fltSugest  := 0.0;
      intDiaSai  := 0;
      intDiaSaiMesAtual := 0;

      fltMaiSai  := 0.0;
      intContador1 := 1;

      fltSaiMaior := 0;
      fltSaiMenor := -1;

      intDiaMaior := 0;
      intDiaMenor := 0;

      wrdAnoAnt   := StrToIntDef(qryGenGir.FieldByName('GIR_A_N_O_').AsString, YearOf(dtaDataBase));

      bkmItemEmpresaAtual    := qryGenGir.GetBookmark;
      fltPosItemEmpresaAtual := pgbProgresso.Position;

      strEmpAtu := qryGenGir.FieldByName('GIR_CODEMP').AsString;

      If cdsItensPed.FindKey([qryGenGir.FieldByName('GIR_CODITE').AsString,
                              qryGenGir.FieldByName('GIR_CODEMP').AsString]) Then
        cdsItensPed.Edit
      Else
      Begin
        cdsItensPed.Append;
      End;

      cdsItensPed.FieldByName('ITE_INCIRQ').AsString := qryGenGir.FieldByName('ITE_INCIRQ').AsString;
      cdsItensPed.FieldByName('ITE_QTDREQ').AsFloat  := qryGenGir.FieldByName('ITE_QTDREQ').AsFloat;
      cdsItensPed.FieldByName('ITE_QATREQ').AsFloat  := qryGenGir.FieldByName('ITE_QTDREQ').AsFloat;

      cdsItensPed.FieldByName('ITE_SEQCOT').Value    := qryGenGir.FieldByName('ITE_SEQCOT').Value;

      If qryGenGir.FieldByName('GIR_A_N_O_').AsInteger = YearOf(VS_date) Then
      Begin
        cdsItensPed.FieldByName('ITE_VENMES').AsFloat := fGetValorGirIte(qryGenGir, 'GIR_QSAI' + fStrZero(MOnthOf(dtaDataBase), 2));
        cdsItensPed.FieldByName('ITE_Q_VPME').AsFloat := fGetValorGirIte(qryGenGir, 'GIR_QPSA' + fStrZero(MOnthOf(dtaDataBase), 2));
        intDiaSaiMesAtual := qryGenGir.FieldByName('GIR_DSAI' + fStrZero(MOnthOf(dtaDataBase), 2)).AsInteger;
      End else
      Begin
        cdsItensPed.FieldByName('ITE_VENMES').AsFloat := 0;
        cdsItensPed.FieldByName('ITE_Q_VPME').AsFloat := 0;
      End;

      While (Not qryGenGir.Eof)                                         And
            (strItemAnt = qryGenGir.FieldByName('GIR_CODITE').AsString) And
            (intContador1 <= 12 {intQtdMes})                     Do
      Begin
        DecodeDate(arrDatas[intContador1-1], wrdAno, wrdMes, wrdDia);

        If (wrdAnoAnt <> wrdAno) Then
        Begin
          If wrdAno = 1889 Then
            intContador1 := 13
          Else
          begin
            qryGenGir.Next;
            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;
            wrdAnoAnt := wrdAno;
          End;
          Continue;
        End;

        If (strEmpAtu <> qryGenGir.FieldByName('GIR_CODEMP').AsString) Then
        Begin
          qryGenGir.Prior;
          pgbProgresso.Position := pgbProgresso.Position - 1;
        End;

        {*****************************************}
        {* ATUALIZA AS VARIAVEIS DE ENTRADA /    *}
        {* SAIDA / SUGESTAO COM OS VALOES DO GIRO*}
        {**************************************MV*}
        fltQtdSai := fGetValorGirIte(qryGenGir, 'GIR_QSAI' + fStrZero(IntToStr(wrdMes), 2));
        fltQtdPromoc := fGetValorGirIte(qryGenGir, 'GIR_QPSA' + fStrZero(IntToStr(wrdMes), 2));
        fltQtdEnt := fGetValorGirIte(qryGenGir, 'GIR_QENT' + fStrZero(IntToStr(wrdMes), 2));

        If intContador1 <= intQtdMes Then
        Begin
          fltSugest := fltSugest + fltQtdSai;

          intDiaSai := intDiaSai + qryGenGir.FieldByName('GIR_DSAI' + fStrZero(IntToStr(wrdMes), 2)).AsInteger;

          If fltQtdSai > fltSaiMaior Then
          Begin
            fltSaiMaior := fltQtdSai;
            intDiaMaior := DaysInAMonth(wrdAno, wrdMes);

            intDiaSaiMaior := qryGenGir.FieldByName('GIR_DSAI' + fStrZero(IntToStr(wrdMes), 2)).AsInteger;
          End;

          If (fltQtdSai < fltSaiMenor) Or (fltSaiMenor = -1) Then
          Begin
            fltSaiMenor := fltQtdSai;
            intDiaMenor := DaysInAMonth(wrdAno, wrdMes);

            intDiaSaiMenor := qryGenGir.FieldByName('GIR_DSAI' + fStrZero(IntToStr(wrdMes), 2)).AsInteger;
          End;

          If Not blnTevGir Then
            blnTevGir := fltQtdSai > 0;
        End;

        {*****************************************}
        {* GRAVA VALORES NO DATASET              *}
        {**************************************MV*}
        fldQtdVen := cdsItensPed.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador1), 2));
        fldQtdEnt := cdsItensPed.FieldByName('ITE_Q_C_' + fStrZero(IntToStr(intContador1), 2));
        fldQtdVenProm := cdsItensPed.FieldByName('ITE_Q_VP' + fStrZero(IntToStr(intContador1), 2));
        fldDesMes := cdsItensPed.FieldByName('ITE_DESM' + fStrZero(IntToStr(intContador1), 2));

        fldQtdVen.AsFloat  := {fldQtdVen.AsFloat +} fltQtdSai;
        fldQtdEnt.AsFloat  := {fldQtdEnt.AsFloat +} fltQtdEnt;
        fldQtdVenProm.ASFloat := fltQtdPromoc;
        fldDesMes.AsString := FormatDateTime('mm/yyyy', arrDatas[intContador1-1]);

        cdsItensPed.FieldByName('ITE_MQSA' + fStrZero(IntToStr(intContador1), 2)).AsFloat    := qryGenGir.FieldByName('GIR_MQSA' + fStrZero(IntToStr(wrdMes), 2)).AsFloat;
        cdsItensPed.FieldByName('ITE_MDSA' + fStrZero(IntToStr(intContador1), 2)).AsDateTime := qryGenGir.FieldByName('GIR_MDSA' + fStrZero(IntToStr(wrdMes), 2)).AsDateTime;

        Inc(intContador1);
      End; {While (Not qryGenGir.Eof)                                         And
            (strItemAnt = qryGenGir.FieldByName('GIR_CODITE').AsString) And
            (intContador1 <= intMesMos}

      (*  If qryGenGir.FieldByName('GIR_CODITE').AsString <> strItemAnt Then
      Begin
        pMensagemOk('Item ' + strItemAnt + ' sem giro para o ano de ' + IntToStr(wrdAno) + '!');
        Result := False;
        Exit;
      End; *)

      {*****************************************}
      {* NECESSÁRIO USAR O 'DOWNTO' PARA QUE   *}
      {* NO MULTI-LOJAS APARECA A DATA CORRETA.*}
      {**************************************MV*}
      For intContador1 := intQtdMes DownTo 1 Do
      Begin
        If (cdsItensPed.FieldByName('ITE_MQSA' + fStrZero(IntToStr(intContador1), 2)).AsFloat >= fltMaiSai) Then
        Begin
          fltMaiSai := cdsItensPed.FieldByName('ITE_MQSA' + fStrZero(IntToStr(intContador1), 2)).AsFloat;
          dtaMaiSai := cdsItensPed.FieldByName('ITE_MDSA' + fStrZero(IntToStr(intContador1), 2)).AsDateTime;

          cdsItensPed.FieldByName('ITE_MAQTSA').AsFloat    := fltMaiSai;
          cdsItensPed.FieldByName('ITE_MADTSA').AsDateTime := dtaMaiSai;
        End;
      End;

      {********************************************}
      {* CONSIDERA O MÊS ATUAL NO CÁLCULO DO GIRO *}
      {*****************************************MV*}
      If blnConsMesAtu Then
      Begin
        fltSugest := fltSugest + cdsItensPed.FieldByName('ITE_VENMES').AsFloat;

        intDiaSai := intDiaSai + intDiaSaiMesAtual;

        Inc(intQtdMes);

        If cdsItensPed.FieldByName('ITE_VENMES').AsFloat > fltSaiMaior Then
        Begin
          fltSaiMaior := cdsItensPed.FieldByName('ITE_VENMES').AsFloat;
          intDiaMaior := DayOfTheMonth(VS_Date) - 1;
          intDiaSaiMaior := intDiaSaiMesAtual;
        End;

        If (cdsItensPed.FieldByName('ITE_VENMES').AsFloat < fltSaiMenor) Or (fltSaiMenor = -1) Then
        Begin
          fltSaiMenor := cdsItensPed.FieldByName('ITE_VENMES').AsFloat;
          intDiaMenor := DayOfTheMonth(VS_Date) - 1;
          intDiaSaiMenor := intDiaSaiMesAtual;
        End;

        If qryGenGir.FieldByName('GIR_MQSA' + fStrZero(MOnthOf(dtaDataBase), 2)).AsFloat >= fltMaiSai Then
        Begin
          fltMaiSai := qryGenGir.FieldByName('GIR_MQSA' + fStrZero(MOnthOf(dtaDataBase), 2)).AsFloat;
          dtaMaiSai := qryGenGir.FieldByName('GIR_MDSA' + fStrZero(MOnthOf(dtaDataBase), 2)).AsDateTime;

          cdsItensPed.FieldByName('ITE_MAQTSA').AsFloat    := fltMaiSai;
          cdsItensPed.FieldByName('ITE_MADTSA').AsDateTime := dtaMaiSai;
        End;

        If Not blnTevGir Then
          blnTevGir := (fGetValorGirIte(qryGenGir, 'GIR_QSAI' + fStrZero(MOnthOf(dtaDataBase), 2)) > 0 );
      End;

      If cdsItensPed.FieldByName('ITE_MAQTSA').AsFloat = 0 Then
      Begin
        cdsItensPed.FieldByName('ITE_MAQTSA').Clear;
        cdsItensPed.FieldByName('ITE_MADTSA').Clear;
      End;

      cdsItensPed.FieldByName('GIRSINT').AsString    := qryGenGir.FieldByName('GIRSINT').AsString;
      cdsItensPed.FieldByName('CRISINT').AsString    := qryGenGir.FieldByName('CRISINT').AsString;
      cdsItensPed.FieldByName('ITE_NVLGIR').AsString := qryGenGir.FieldByName('ITE_NVLGIR').AsString;
      cdsItensPed.FieldByName('ITE_NVLCRI').AsString := qryGenGir.FieldByName('ITE_NVLCRI').AsString;

      recNivEst.strIteGir := cdsItensPed.FieldByName('ITE_NVLGIR').AsString;
      recNivEst.strIteCri := cdsItensPed.FieldByName('ITE_NVLCRI').AsString;

      intDiaComTmp := fDiasCompra(recNivEst);
      fltPerConTmp := fPercElevacaoConsumiveis(recNivEst);

      {*****************************************}
      {* SALVO A MÉDIA                         *}
      {**************************************MV*}
      If blnDiaSai And (intDiaSai > 0) Then
      Begin

        fltMedia_ := (fltSugest / IIF(intDiaSai > 0, intDiaSai, 1)) * 30;  // Média mensal
        fltMedAju := ((fltSugest - fltSaiMaior - fltSaiMenor) / IIF(intDiaSai - intDiaSaiMaior - intDiaSaiMenor > 0, (intDiaSai - intDiaSaiMaior - intDiaSaiMenor), 1)) * 30 ; // Média mensal Ajustada

      End Else
      Begin

        If blnConsMesAtu Or fSelecionouMesAtual Then
        Begin
          fltMedia_ := (fltSugest / fRetQuantidadeDias(intQtdMes)) * 30;

          If (fRetQuantidadeDias(intQtdMes) - intDiaMaior - intDiaMenor) <> 0 Then
            fltMedAju := ((fltSugest - fltSaiMaior - fltSaiMenor) / (fRetQuantidadeDias(intQtdMes) - intDiaMaior - intDiaMenor)) * 30
          Else
            fltMedAju := 0;

        End Else
        Begin
          fltMedia_ := fltSugest / intQtdMes;
          fltMedAju := (fltSugest - fltSaiMaior - fltSaiMenor) / (intQtdMes - 2);
        End;

      End;

      cdsItensPed.FieldByName('ITE_DIASAI').AsInteger := intDiaSai;

      cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat := fFormataFloatInterna(fltMedia_, 2);
      cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat := fFormataFloatInterna(fltMedAju, 2);

      cdsItensPed.FieldByName('ITE_MEDIXX').AsFloat := fFormataFloatInterna(cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat / 30 * intDiaComTmp, 2);
      cdsItensPed.FieldByName('ITE_MEDAJU').AsFloat := fFormataFloatInterna(fltMedAju / 30 * intDiaComTmp, 2);

      cdsItensPed.FieldByName('ITE_PREULT').Value := qryGenGir.FieldByName('ITE_PREULT').Value;
      cdsItensPed.FieldByName('ITE_IMPULT').Value := qryGenGir.FieldByName('ITE_IMPULT').Value;
      cdsItensPed.FieldByName('ITE_QTDUCO').Value := qryGenGir.FieldByName('ITE_QTDUCO').Value;
      cdsItensPed.FieldByName('ITE_FORULT').Value := qryGenGir.FieldByName('ITE_FORULT').Value;
      cdsItensPed.FieldByName('ITE_NOMFOR').Value := qryGenGir.FieldByName('ITE_NOMFOR').Value;
      cdsItensPed.FieldByName('ITE_DTAULT').Value := qryGenGir.FieldByName('ITE_DTAULT').Value;

      If (Not cdsItensPed.FieldByName('ITE_DTAULT').IsNull) And (cdsItensPed.FieldByName('ITE_DTAULT').AsDateTime > 0) Then
        cdsItensPed.FieldByName('ITE_DIAUCO').AsInteger  := Trunc(VS_Date - cdsItensPed.FieldByName('ITE_DTAULT').AsDateTime);

      cdsItensPed.FieldByName('ITE_PREUVE').Value := qryGenGir.FieldByName('ITE_PREUVE').Value;
      cdsItensPed.FieldByName('ITE_QTDUVE').Value := qryGenGir.FieldByName('ITE_QTDUVE').Value;
      cdsItensPed.FieldByName('ITE_DTAUVE').Value := qryGenGir.FieldByName('ITE_DTAUVE').Value;

      cdsItensPed.FieldByName('ITE_PONEXP').Value := qryGenGir.FieldByName('ITE_PONEXP').Value;
      If opcChamada <> chaSpoolTransferencia Then
        cdsItensPed.FieldByName('ITE_QTEP_S').Value := qryGenGir.FieldByName('ITE_QTEP_S').Value;

      If (Not cdsItensPed.FieldByName('ITE_DTAUVE').IsNull) And (cdsItensPed.FieldByName('ITE_DTAUVE').AsDateTime > 0) Then
        cdsItensPed.FieldByName('ITE_DIAUVE').AsInteger  := Trunc(VS_Date - cdsItensPed.FieldByName('ITE_DTAUVE').AsDateTime);

      {*****************************************}
      {* SALVO A POSIÇÃO DO PRÓX. ITEM A SER   *}
      {* PROCESSADO                            *}
      {**************************************MV*}
      bkmUltimoRegItem    := qryGenGir.GetBookmark;
      fltPosUltimoRegItem := pgbProgresso.Position;

      {*****************************************}
      {* RESTAURA A POSIÇÃO DO ITEM SENDO PRO- *}
      {* CESSADO ATUALMENTE.                   *}
      {**************************************MV*}
      qryGenGir.GotoBookmark(bkmItemEmpresaAtual);
      pgbProgresso.Position := fltPosItemEmpresaAtual;

      {*****************************************}
      {* CALCULA A SUGESTÃO.                   *}
      {**************************************MV*}

      (*Esta primeira linha do if foi comentada para resolver o **155955, pois neste ponto a sugestão é apenas o total de saida que no caso é zero e precisava calcular o resto da sugestão
      como pedido de venda, saldo de garantia e etc.*)
      If  ((*((fltSugest <= 0) And (Not blnAllIte) And (Not blnAteMax)) Or*)
           ((Not blnTevGir) And (strFilGir = 'S')) Or  {Sem giro e está para carregar os itens 'sem giro', deleta pois esse item irá entrar na função 'fSQLSemGiroOuTodos'}
           ((fltSugest <= 0) And (strFilGir = 'C') And ((Not blnAltPed) Or (qryGenGir.FieldByName('PCD_QTDITE').AsFloat = 0)))) And
         (Not blnTevGir) And fEmptyStr(strSeqCot) And fEmptyStr(strNumPed)  And
         ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido)) And
         (fEmptyStr(strNumPedAlt) Or ((qryGenGir.FindField('PCD_QTDITE') = Nil) Or (qryGenGir.FieldByName('PCD_QTDITE').AsFloat = 0))) Then
      Begin
        cdsItensPed.Cancel;
      End
      Else
      Begin
        cdsItensPed.FieldByName('ITE_SALGAR').AsFloat := qryGenGir.FieldByName('ITE_SALGAR').AsFloat;
        cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat := qryGenGir.FieldByName('ITE_QTEF_F').AsFloat;
        cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat := qryGenGir.FieldByName('ITE_QTEF_A').AsFloat;
        cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat := qryGenGir.FieldByName('ITE_QTEF_P').AsFloat;
        cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat := qryGenGir.FieldByName('ITE_QTPD_P').AsFloat;
        cdsItensPed.FieldByName('ITE_SALDOS').AsFloat := qryGenGir.FieldByName('ITE_SALDOS').AsFloat;
        cdsItensPed.FieldByName('ITE_SALDIS').AsFloat := qryGenGir.FieldByName('ITE_SALDIS').AsFloat;
        cdsItensPed.FieldByName('ITE_SALEXT').AsFloat := qryGenGir.FieldByName('ITE_SALEXT').AsFloat;
        cdsItensPed.FieldByName('ITE_SALFIS').AsFloat := qryGenGir.FieldByName('ITE_SALFIS').AsFloat;
        cdsItensPed.FieldByName('ITE_INIBAS').AsFloat := qryGenGir.FieldByName('ITE_INIBAS').AsFloat;

        cdsItensPed.FieldByName('ITE_SALTRA').AsFloat := qryGenGir.FieldByName('ITE_SALTRA').AsFloat;
        cdsItensPed.FieldByName('ITE_SALEND').AsFloat := qryGenGir.FieldByName('ITE_SALEND').AsFloat;

        cdsItensPed.FieldByName('ITE_SALCOT').AsFloat := fRetQtdCotacao(qryGenGir.FieldByName('ITE_CODITE').AsString,
                                                                        qryGenGir.FieldByName('ITE_CODEMP').AsString);

        fltSaldosSug := qryGenGir.FieldByName('ITE_INIBAS').AsFloat - IfThen(blnConsPedVen, qryGenGir.FieldByName('ITE_SALRES').AsFloat, 0)
                                                                    - IfThen(blnDescSalExt, qryGenGir.FieldByName('ITE_SALEXT').AsFloat, 0)

                                                                    - IfThen(blnConsOrdPro, qryGenGir.FieldByName('ITE_QTPD_P').AsFloat, 0)

                                                                    - IfThen(blnConsGarPen, qryGenGir.FieldByName('ITE_SALGAR').AsFloat, 0)

                                                                    - IfThen(blnEntFutAguarda,  qryGenGir.FieldByName('ITE_QTEF_A').AsFloat, 0)
                                                                    - IfThen(blnEntFutFalta,    qryGenGir.FieldByName('ITE_QTEF_F').AsFloat, 0)
                                                                    - IfThen(blnEntFutPrevisao, qryGenGir.FieldByName('ITE_QTEF_P').AsFloat, 0)

                                                                    - fRetQtdVenPerCons(qryGenGir.FieldByName('ITE_CODITE').AsString,
                                                                                        qryGenGir.FieldByName('ITE_CODEMP').AsString,
                                                                                        qryGenGir.FieldByName('ITE_NVLGIR').AsString) +

                                                                      IfThen(blnConsTransf, qryGenGir.FieldByName('ITE_SALTRA').AsFloat, 0) +

                                                                      fRetQtdCotacaoCons(qryGenGir.FieldByName('ITE_CODITE').AsString,
                                                                                         qryGenGir.FieldByName('ITE_CODEMP').AsString) +

                                                                      IfThen(blnConsPedPen, qryGenGir.fieldbyname('ITE_QTDPEN').asfloat, 0) -
                                                                      IfThen(blnConsRequisicao, qryGenGir.fieldbyname('ITE_SALREQ').asfloat, 0);

        cdsItensPed.FieldByName('ITE_SALBAS').AsFloat := fltSaldosSug;

        recNivEst.strIteGir := qryGenGir.FieldByName('ITE_NVLGIR').AsString;
        recNivEst.strIteCri := qryGenGir.FieldByName('ITE_NVLCRI').AsString;

        intDiaComTmp := fDiasCompra(recNivEst);
        fltPerConTmp := fPercElevacaoConsumiveis(recNivEst);

        fltSugest := ( ( ( IfThen(blnMedAju, fltMedAju, fltMedia_) / 30) * intDiaComTmp ) - (fltSaldosSug));
        fltSalExc := cdsItensPed.FieldByName('ITE_SALDIS').AsFloat -  (( IfThen(blnMedAju, fltMedAju, fltMedia_) / 30)  *  intDiaComTmp);
        fltSugReal := fltSugest;


        fltSalExc := fFormataFloatInterna(fltSalExc, 2);

        If fltSalExc < 0 Then
          fltSalExc := 0;

        fltSugest := fFormataFloatInterna(fltSugest, 2);

        If (fltSugest <= 0) Then
          fltSugest := 0;

        {*****************************************}
        {* CASO CONSIDERE O ESTOQUE MINIMO       *}
        {**************************************MV*}
        If blnConsEMin Then
        Begin

          If (fltSugest + fltSaldosSug < qryGenGir.FieldByName('ITE_ESTMIN').AsFloat) Then
          Begin
            fltSugest := qryGenGir.FieldByName('ITE_ESTMIN').AsFloat - (fltSaldosSug);
          End;

        End;

        If (fltSugest <= 0) Then
          fltSugest := 0;

        Case slfLocFis Of
          slfComLocal: If fEmptyStr(qryGenGir.FieldByName('ITE_LOCFIS').AsString) Then
                         fltSugest := 0;

          slfSemLocal: If Not fEmptyStr(qryGenGir.FieldByName('ITE_LOCFIS').AsString) Then
                         fltSugest := 0;
        End;

        fltDesUni := 0;

        {*****************************************}
        {* CALCULA O VALOR UNITARIO              *}
        {**************************************MV*}
        If (blnAltPed) And (qryGenGir.FieldByName('PCD_UNITAR').AsFloat > 0) Then
          fltUnitar := qryGenGir.FieldByName('PCD_UNITAR').AsFloat
        Else
        If (strUniPcg = '1') Then
        Begin
          fltUnitar := qryGenGir.FieldByName('ITE_PRECOM').AsFloat;
        End
        Else If (strUniPcg = '2') Or (strUniPcg = '6') Then
        Begin
          fltUnitar := qryGenGir.FieldByName('ITE_PRECOM').AsFloat;
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF01').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF02').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF03').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF04').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF05').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF06').AsFloat / 100));
        End
        Else If (strUniPcg = '3') Then
        Begin
          fltUnitar := qryGenGir.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else If (strUniPcg = '4') Then
        Begin
          fltUnitar := qryGenGir.FieldByName('ITE_PRECOM').AsFloat;
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF01').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF02').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF03').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF04').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF05').AsFloat / 100));
          fltUnitar := fltUnitar - (fltUnitar * (qryGenGir.FieldByName('ITE_DESF06').AsFloat / 100));
          fltUnitar := fltUnitar + ( fltUnitar * (qryGenGir.FieldByName('ITE_ACRFIN').AsFloat  / 100 ) );
        End
        Else If (strUniPcg = '7') Then
        Begin
          fltUnitar := qryGenGir.FieldByName('ITE_PRECOM').AsFloat;
          fltDesUni := RoundTo((1 - (
                        (1 - qryGenGir.FieldByName('ITE_DESF01').AsFloat/100) *
                        (1 - qryGenGir.FieldByName('ITE_DESF02').AsFloat/100) *
                        (1 - qryGenGir.FieldByName('ITE_DESF03').AsFloat/100) *
                        (1 - qryGenGir.FieldByName('ITE_DESF04').AsFloat/100) *
                        (1 - qryGenGir.FieldByName('ITE_DESF05').AsFloat/100) *
                        (1 - qryGenGir.FieldByName('ITE_DESF06').AsFloat/100))) * 100, -2);
        End

        Else If (strUniPcg = '8') Then
        Begin
          fltUnitar := qryGenGir.FieldByName('ITE_PREULT').AsFloat;
        End

        Else fltUnitar := 0;

        fltUnitar := fFormataFloatInterna(fltUnitar, intDecUni);

        If (fltSugest > 0) Or blnAteMax Then
        Begin

          fltSugest := fElevaConsumiveis(fltSugest, fltPerConTmp, qryGenGir.FieldByName('ITE_CLACRM').AsString);

          If blnConsEMax And
            (qryGenGir.FieldByName('ITE_ESTMAX').AsFloat > 0) And
            (fltSugest > qryGenGir.FieldByName('ITE_ESTMAX').AsFloat) Then
          Begin

            If (fltSaldosSug) > 0 Then
              fltSugest := qryGenGir.FieldByName('ITE_ESTMAX').AsFloat - (fltSaldosSug)
            Else
              fltSugest := qryGenGir.FieldByName('ITE_ESTMAX').AsFloat;

            If fltSugest < 0 Then
              fltSugest := 0;
          End;

          If blnAteMax Then
          Begin

            If (qryGenGir.FieldByName('ITE_ESTMAX').AsFloat > 0) Then
            Begin
              fltSugest := qryGenGir.FieldByName('ITE_ESTMAX').AsFloat;

              fltSugest := fltSugest - fltSaldosSug;

              If fltSugest < 0 Then
                fltSugest := 0;

            End

            Else fltSugest := 0;
          End;

          fltQtdCal := fltSugest;
          If blnArredSug then
          Begin
            fltQtdCal := ceil(fltQtdCal);
          End;

          If (fltQtdCal > 0) And
             (blnEmpVis) And
             (opcChamada = chaSpoolTransferencia) And
             (qryGenGir.FieldByName('UNI_ITEFRA').AsString = 'N') And
             (frac(fltQtdCal) <> 0 ) Then
            fltQtdCal := ceil(fltQtdCal);

          {*****************************************}
          {* REALIZA OPERAÇÕES SOBRE A SUGESTÃO    *}
          {**************************************MV*}
          If blnConsMCom Then
          Begin
            If (Not fCalcularMultiploNaEmpresaCentralizadora(qryGenGir.fieldbyname('ITE_CPRCEN').AsString)) aND
               (Not fPedidoMultiLojaPorNivelAgregadaPorEmpresaComCalculoGlobal_E_NivelGiroPorEmpresa(strPedMlj, strEmpAgr, recNivEst , blnSugInd)) Then
            Begin
              fltSugMult :=  (round(fltSugest / qryGenGir.fieldbyname('ITE_MLTCOM').asfloat)) * qryGenGir.fieldbyname('ITE_MLTCOM').asfloat;
              fltSugMult := RoundTo(fltSugMult, -9);


              If fltSugMult < fltSugest Then
                fltSugest := (round(fltSugest / qryGenGir.fieldbyname('ITE_MLTCOM').asfloat) + 1) * qryGenGir.fieldbyname('ITE_MLTCOM').asfloat
              Else
                fltSugest := fltSugMult;
            End;

            If blnArredSug then
              fltSugest  := ceil(fltSugest);
          End
          Else
          Begin
            If blnArredSug then
            Begin
              fltSugest  := ceil(fltSugest);
            End;
          End;

          Case slfLocFis Of
            slfComLocal: If fEmptyStr(qryGenGir.FieldByName('ITE_LOCFIS').AsString) Then
                           fltSugest := 0;

            slfSemLocal: If Not fEmptyStr(qryGenGir.FieldByName('ITE_LOCFIS').AsString) Then
                           fltSugest := 0;
          End;

        End;

        If blnPonPed Then
          cdsItensPed.FieldByName('ITE_ABAPON').AsString := IfThen((fltSaldosSug > qryGenGir.FieldByName('ITE_PONPED').AsFloat), 'S', 'N')
        Else
          cdsItensPed.FieldByName('ITE_ABAPON').AsString := 'N';

        If blnPonPed And (cdsItensPed.FieldByName('ITE_ABAPON').AsString = 'S') Then
          fltSugest := 0;

        If (qryGenGir.FieldByName('ITE_CPRCEN').AsString = 'S') And
           (Pos(qryGenGir.FieldByName('ITE_EMPCEN').AsString, strEmpCal) = 0) Then
          fltSugest := 0;

        cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat := qryGenGir.FieldByName('ITE_QTEF_F').AsFloat;
        cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat := qryGenGir.FieldByName('ITE_QTEF_A').AsFloat;
        cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat := qryGenGir.FieldByName('ITE_QTEF_P').AsFloat;
        cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat := qryGenGir.FieldByName('ITE_QTPD_P').AsFloat;
        cdsItensPed.FieldByName('ITE_SALDOS').AsFloat := qryGenGir.FieldByName('ITE_SALDOS').AsFloat;
        cdsItensPed.FieldByName('ITE_SALDIS').AsFloat := qryGenGir.FieldByName('ITE_SALDIS').AsFloat;
        cdsItensPed.FieldByName('ITE_SALEXT').AsFloat := qryGenGir.FieldByName('ITE_SALEXT').AsFloat;
        cdsItensPed.FieldByName('ITE_SALFIS').AsFloat := qryGenGir.FieldByName('ITE_SALFIS').AsFloat;
        cdsItensPed.FieldByName('ITE_INIBAS').AsFloat := qryGenGir.FieldByName('ITE_INIBAS').AsFloat;


        cdsItensPed.FieldByName('ITE_SALRES').AsFloat := qryGenGir.FieldByName('ITE_SALRES').AsFloat;

        cdsItensPed.FieldByName('ITE_VENPER').AsFloat := fRetQtdVenPer(qryGenGir.FieldByName('ITE_CODITE').AsString,
                                                                       qryGenGir.FieldByName('ITE_CODEMP').AsString,
                                                                       qryGenGir.FieldByName('ITE_NVLGIR').AsString);

        cdsItensPed.FieldByName('ITE_SALTRA').AsFloat := qryGenGir.FieldByName('ITE_SALTRA').AsFloat;

        cdsItensPed.FieldByName('ITE_SALEND').AsFloat := qryGenGir.FieldByName('ITE_SALEND').AsFloat;

        cdsItensPed.FieldByName('ITE_SALCOT').AsFloat := fRetQtdCotacao(qryGenGir.FieldByName('ITE_CODITE').AsString,
                                                                        qryGenGir.FieldByName('ITE_CODEMP').AsString);

        cdsItensPed.FieldByName('ITE_SALBAS').AsFloat := cdsItensPed.FieldByName('ITE_INIBAS').AsFloat -
                                                                             ( IfThen(blnConsPedVen, cdsItensPed.FieldByName('ITE_SALRES').AsFloat, 0) +

                                                                               IfThen(blnDescSalExt, cdsItensPed.FieldByName('ITE_SALEXT').AsFloat, 0) +

                                                                               IfThen(blnConsOrdPro, cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat, 0) +

                                                                               IfThen(blnConsGarPen, cdsItensPed.FieldByName('ITE_SALGAR').AsFloat, 0) +

                                                                               IfThen(blnEntFutAguarda,  cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat, 0) +
                                                                               IfThen(blnEntFutFalta,    cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat, 0) +
                                                                               IfThen(blnEntFutPrevisao, cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat, 0) +

                                                                               fRetQtdVenPerCons(qryGenGir.FieldByName('ITE_CODITE').AsString,
                                                                                                 qryGenGir.FieldByName('ITE_CODEMP').AsString,
                                                                                                 qryGenGir.FieldByName('ITE_NVLGIR').AsString)
                                                                             ) +

                                                                              IfThen(blnConsTransf, qryGenGir.FieldByName('ITE_SALTRA').AsFloat, 0) +

                                                                              fRetQtdCotacaoCons(qryGenGir.FieldByName('ITE_CODITE').AsString,
                                                                                                 qryGenGir.FieldByName('ITE_CODEMP').AsString) +

                                                                              IfThen(blnConsPedPen, qryGenGir.fieldbyname('ITE_QTDPEN').asfloat, 0) -
                                                                              IfThen(blnConsRequisicao, qryGenGir.fieldbyname('ITE_SALREQ').asfloat, 0);


        If blnEmpVis And (Pos(qryGenGir.FieldByName('ITE_CODEMP').AsString, strEmpCal) = 0) Then
          fltSugest := 0;

        If blnEmpVis And (opcChamada = chaSpoolTransferencia) Then
        Begin

          Case slsSaldosDestino Of
            slsMenorOuIgualZero   : If Not (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat <= 0) Then
                                      fltSugest := 0;

            slsAbaixoMinimo       : If Not (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat <  qryGenGir.FieldByName('ITE_ESTMIN').AsFloat) Then
                                      fltSugest := 0;

            slsAcimaOuIgualMinimo : If Not (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat >= qryGenGir.FieldByName('ITE_ESTMIN').AsFloat) Then
                                      fltSugest := 0;

          End;

        End;

        If (((fltSugest <= 0) And (Not blnAllIte)) Or (cdsItensPed.FieldByName('ITE_ABAPON').AsString = 'S')) And
           (Not blnTevGir) And fEmptyStr(strSeqCot) And
           fEmptyStr(strNumPedUmaLoja) And fEmptyStr(strNumPed) And
           ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido)) Then
        Begin
          cdsItensPed.Cancel;
        End
        Else
        Begin
          {*******************************************}
          {* CASO ESTEJA ALTERANDO UM PEDIDO, E SEJA *}
          {* MULTILOJAS, A QUANTIDADE DO PRODUTO É   *}
          {* A QUE ESTÁ GRAVADA NO PCDDET.           *}
          {****************************************MV*}
          If (blnAltPed) Or ((Assigned(objRecupera) And objRecupera.recPcmger.blnRecuperaPedido) And (qryGenGir.FindField('PCD_QTDITE') <> Nil)) Then
          Begin
            fltQtdIte := qryGenGir.FieldByName('PCD_QTDITE').AsFloat - qryGenGir.FieldByName('PCD_QTDBAI').AsFloat;
            fltQtdCal := fltQtdIte;
          End Else
          Begin
            fltQtdIte := fltSugest;
          End;

          fltLitrag := fltQtdIte * qryGenGir.fieldbyname('ITE_LITROS').AsFloat;

          If SameText(strLitGal, 'G') Then
            fltLitrag := fltLitrag / FLT_LITRO_GALAO;

          fltPesoit := fltQtdIte * qryGenGir.fieldbyname('ITE_PESOIT').AsFloat;

          {*****************************************}
          {* GRAVA OS VALORES NO DATASET           *}
          {**************************************MV*}
          cdsItensPed.FieldByName('ITE_CODGRU').AsString := qryGenGir.FieldByName('ITE_CODGRU').AsString;
          cdsItensPed.FieldByName('ITE_CLACRM').AsString := qryGenGir.FieldByName('ITE_CLACRM').AsString;

          cdsItensPed.FieldByName('ITE_CODABF').AsString := qryGenGir.FieldByName('ITE_CODABF').AsString;
          cdsItensPed.FieldByName('ITE_EMBALA').AsFloat  := qryGenGir.FieldByName('ITE_EMBALA').AsFloat;
          cdsItensPed.FieldByName('ITE_CODITE').AsString := qryGenGir.FieldByName('ITE_CODITE').AsString;
          cdsItensPed.FieldByName('ITE_CODTAB').AsString := qryGenGir.FieldByName('ITE_CODTAB').AsString;
          cdsItensPed.FieldByName('ITE_CODEMP').AsString := qryGenGir.FieldByName('ITE_CODEMP').AsString;
          cdsItensPed.FieldByName('ITE_DESEMP').AsString := qryGenGir.FieldByName('EMP_NOMEMP').AsString;
          cdsItensPed.FieldByName('ITE_FANEMP').AsString := qryGenGir.FieldByName('EMP_NOMFAN').AsString;
          cdsItensPed.FieldByName('ITE_DESITE').AsString := qryGenGir.FieldByName('ITE_DESITE').AsString;
          cdsItensPed.FieldByName('ITE_PESORI').AsFloat  := qryGenGir.FieldByName('ITE_PESOIT').AsFloat;
          cdsItensPed.FieldByName('ITE_APLICA').AsString := qryGenGir.FieldByName('ITE_APLICA').AsString;

          cdsItensPed.FieldByName('ITE_DIAFOR').AsInteger := qryGenGir.FieldByName('ITE_DIAFOR').AsInteger;

          cdsItensPed.FieldByName('ITE_ESMIDG').AsString := qryGenGir.FieldByName('ITE_ESMIDG').AsString;
          cdsItensPed.FieldByName('ITE_LOCFIS').AsString := qryGenGir.FieldByName('ITE_LOCFIS').AsString;
          cdsItensPed.FieldByName('ITE_INCPIS').AsString := qryGenGir.FieldByName('ITE_INCPIS').AsString;
          cdsItensPed.FieldByName('ITE_REFERE').AsString := qryGenGir.FieldByName('ITE_REFERE').AsString;
          cdsItensPed.FieldByName('ITE_CLAIPI').AsString := qryGenGir.FieldByName('ITE_CLAIPI').AsString;
          cdsItensPed.FieldByName('ITE_PRAVAL').AsString := qryGenGir.FieldByName('ITE_PRAVAL').AsString;
          cdsItensPed.FieldByName('ITE_CODSIT').AsString := qryGenGir.FieldByName('ITE_CODSIT').AsString;
          cdsItensPed.FieldByName('ITE_SITORI').AsString := qryGenGir.FieldByName('ITE_SITORI').AsString;
          cdsItensPed.FieldByName('ITE_CODUNI').AsString := qryGenGir.FieldByName('ITE_CODUNI').AsString;
          cdsItensPed.FieldByName('ITE_UNICOM').AsString := qryGenGir.FieldByName('ITE_UNICOM').AsString;
          cdsItensPed.FieldByName('ITE_SIGUNI').AsString := qryGenGir.FieldByName('UNI_SIGUNI').AsString;
          cdsItensPed.FieldByName('ITE_CODMAR').AsString := qryGenGir.FieldByName('ITE_CODMAR').AsString;
          cdsItensPed.FieldByName('ITE_DESMAR').AsString := qryGenGir.FieldByName('MAR_DESMAR').AsString;
          cdsItensPed.FieldByName('ITE_CODFOR').AsString := qryGenGir.FieldByName('ITE_CODFOR').AsString;
          cdsItensPed.FieldByName('ITE_ITEESP').AsString := IfThen(Pos('ITEM ESPECIAL', qryGenGir.FieldByName('ITE_DESITE').AsString) > 0, 'S', 'N');
          cdsItensPed.FieldByName('ITE_MLTCOM').AsFloat  := qryGenGir.FieldByName('ITE_MLTCOM').AsFloat;
          cdsItensPed.FieldByName('ITE_ABAMLT').AsString := qryGenGir.FieldByName('ITE_ABAMLT').AsString;

          cdsItensPed.FieldByName('GIRSINT').AsString    := qryGenGir.FieldByName('GIRSINT').AsString;
          cdsItensPed.FieldByName('CRISINT').AsString    := qryGenGir.FieldByName('CRISINT').AsString;
          cdsItensPed.FieldByName('ITE_NVLGIR').AsString := qryGenGir.FieldByName('ITE_NVLGIR').AsString;
          cdsItensPed.FieldByName('ITE_NVLCRI').AsString := qryGenGir.FieldByName('ITE_NVLCRI').AsString;

          cdsItensPed.FieldByName('ITE_LITROS').AsFloat  := fltLitrag;
          cdsItensPed.FieldByName('ITE_PESOIT').AsFloat  := fltPesoit;

          If (blnAltPed) Or (Assigned(objRecupera) And objRecupera.recPcmger.blnRecuperaPedido And (qryGenGir.FindField('PCD_QTDITE') <> Nil)) Then
            cdsItensPed.FieldByName('ITE_QTDBAI').AsFloat := qryGenGir.FieldByName('PCD_QTDBAI').AsFloat
          Else
            cdsItensPed.FieldByName('ITE_QTDBAI').AsFloat := 0.0;

          If fltQtdIte = 0 Then
            fltQtdCal := 0;

          cdsItensPed.FieldByName('ITE_QTDCAL').AsFloat  := fltQtdCal;
          cdsItensPed.FieldByName('ITE_SUGESTORI').AsFloat  := fltQtdCal;
          cdsItensPed.FieldByName('ITE_QTDITE').AsFloat  := fltQtdIte;
          cdsItensPed.FieldByName('ITE_QTDINC').AsFloat  := fltQtdIte;

          cdsItensPed.FieldByName('ITE_SUGEST').AsFloat  := fltSugest;
          cdsItensPed.FieldByName('ITE_SALEXC').AsFloat  := fltSalExc;
          If fltSugest > 0 Then
            cdsItensPed.FieldByName('ITE_DIFSUG').AsFloat := fltSugest - IIf(fltSugReal < 0, 0,fltSugReal)
          Else
            cdsItensPed.FieldByName('ITE_DIFSUG').AsFloat := 0;

          If  fltSugest > 0 Then
            cdsItensPed.FieldByName('ITE_ESTEXC').AsFloat  := 0
          Else If (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat - cdsItensPed.FieldByName('ITE_MEDIXX').AsFloat) >  qryGenGir.fieldbyname('ITE_ESTMIN').asfloat then
            cdsItensPed.FieldByName('ITE_ESTEXC').AsFloat  := cdsItensPed.FieldByName('ITE_SALBAS').AsFloat - qryGenGir.fieldbyname('ITE_ESTMIN').asfloat
          Else
            cdsItensPed.FieldByName('ITE_ESTEXC').AsFloat  := 0;


          cdsItensPed.FieldByName('ITE_QTDPEN').AsFloat  := qryGenGir.fieldbyname('ITE_QTDPEN').asfloat;
          cdsItensPed.FieldByName('ITE_SALREQ').AsFloat  := qryGenGir.fieldbyname('ITE_SALREQ').asfloat;

          cdsItensPed.FieldByName('ITE_TOTITE').AsFloat  := RoundTo(fltUnitar * (1 - fltDesUni/100), -intDecUni) * fltQtdIte;

          cdsItensPed.FieldByName('ITE_PERIPI').AsFloat  := qryGenGir.FieldByName('ITE_PERIPI').AsFloat;  {PERIPI};
          cdsItensPed.FieldByName('ITE_BASIPI').AsFloat  := cdsItensPed.FieldByName('ITE_TOTITE').AsFloat;
          cdsItensPed.FieldByName('ITE_TOTIPI').AsFloat  := qryGenGir.FieldByName('ITE_PERIPI').AsFloat * cdsItensPed.FieldByName('ITE_BASIPI').AsFloat / 100.0; {TOTIPI}

          If Assigned(qryGenGir.FindField('PCD_ALQCBS')) Then
          Begin
            cdsItensPed.FieldByName('ITE_ALQCBS').AsFloat := qryGenGir.FieldByName('PCD_ALQCBS').AsFloat;
            cdsItensPed.FieldByName('ITE_ALQIBS').AsFloat := qryGenGir.FieldByName('PCD_ALQIBS').AsFloat;
            cdsItensPed.FieldByName('ITE_ALQ_IS').AsFloat := qryGenGir.FieldByName('PCD_ALQ_IS').AsFloat;
          End;

          If strFRMPCM = '1' Then
            cdsItensPed.FieldByName('ITE_TOTSUB').AsFloat  := qryGenGir.FieldByName('ITE_PERSUB').AsFloat *
                    ((RoundTo(fltUnitar * (1 - fltDesUni/100), -intDecUni) * fltQtdIte) + cdsItensPed.FieldByName('ITE_TOTIPI').AsFloat) / 100.0   {TOTSUB}
          Else
            cdsItensPed.FieldByName('ITE_TOTSUB').AsFloat  := qryGenGir.FieldByName('ITE_PERSUB').AsFloat *
               RoundTo(fltUnitar * (1 - fltDesUni/100), -intDecUni) * fltQtdIte / 100.0;  {TOTSUB}

          cdsItensPed.FieldByName('ITE_ACRFIN').AsFloat  := qryGenGir.FieldByName('ITE_ACRFIN').AsFloat;
          cdsItensPed.FieldByName('ITE_DESF01').AsFloat  := qryGenGir.FieldByName('ITE_DESF01').AsFloat;
          cdsItensPed.FieldByName('ITE_DESF02').AsFloat  := qryGenGir.FieldByName('ITE_DESF02').AsFloat;
          cdsItensPed.FieldByName('ITE_DESF03').AsFloat  := qryGenGir.FieldByName('ITE_DESF03').AsFloat;
          cdsItensPed.FieldByName('ITE_DESF04').AsFloat  := qryGenGir.FieldByName('ITE_DESF04').AsFloat;
          cdsItensPed.FieldByName('ITE_DESF05').AsFloat  := qryGenGir.FieldByName('ITE_DESF05').AsFloat;
          cdsItensPed.FieldByName('ITE_DESF06').AsFloat  := qryGenGir.FieldByName('ITE_DESF06').AsFloat;

          cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat  := qryGenGir.FieldByName('ITE_QTEF_F').AsFloat;
          cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat  := qryGenGir.FieldByName('ITE_QTEF_A').AsFloat;
          cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat  := qryGenGir.FieldByName('ITE_QTEF_P').AsFloat;
          cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat  := qryGenGir.FieldByName('ITE_QTPD_P').AsFloat;
          cdsItensPed.FieldByName('ITE_SALDOS').AsFloat  := qryGenGir.FieldByName('ITE_SALDOS').AsFloat;
          cdsItensPed.FieldByName('ITE_SALFIS').AsFloat  := qryGenGir.FieldByName('ITE_SALFIS').AsFloat;
          cdsItensPed.FieldByName('ITE_INIBAS').AsFloat  := qryGenGir.FieldByName('ITE_INIBAS').AsFloat;
          cdsItensPed.FieldByName('ITE_SALDIS').AsFloat  := qryGenGir.FieldByName('ITE_SALDIS').AsFloat;
          cdsItensPed.FieldByName('ITE_SALEXT').AsFloat  := qryGenGir.FieldByName('ITE_SALEXT').AsFloat;

          cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat  := qryGenGir.FieldByName('ITE_ESTMIN').AsFloat;
          cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat  := qryGenGir.FieldByName('ITE_ESTMAX').AsFloat;
          cdsItensPed.FieldByName('ITE_PMED_V').AsFloat  := qryGenGir.FieldByName('ITE_PMED_V').AsFloat;

          cdsItensPed.FieldByName('ITE_MINDIG').AsFloat  := qryGenGir.FieldByName('ITE_MINDIG').AsFloat;
          cdsItensPed.FieldByName('ITE_MAXDIG').AsFloat  := qryGenGir.FieldByName('ITE_MAXDIG').AsFloat;

          cdsItensPed.FieldByName('ITE_PONPED').AsFloat  := qryGenGir.FieldByName('ITE_PONPED').AsFloat;
          cdsItensPed.FieldByName('ITE_PRECUS').AsFloat  := qryGenGir.FieldByName('ITE_PRECUS').AsFloat;
          cdsItensPed.FieldByName('ITE_PREVE1').AsFloat  := qryGenGir.FieldByName('ITE_PREVE1').AsFloat;
          cdsItensPed.FieldByName('ITE_PREVE2').AsFloat  := qryGenGir.FieldByName('ITE_PREVE2').AsFloat;
          cdsItensPed.FieldByName('ITE_PREVE3').AsFloat  := qryGenGir.FieldByName('ITE_PREVE3').AsFloat;
          cdsItensPed.FieldByName('ITE_PREVE4').AsFloat  := qryGenGir.FieldByName('ITE_PREVE4').AsFloat;
          cdsItensPed.FieldByName('ITE_PREVE5').AsFloat  := qryGenGir.FieldByName('ITE_PREVE5').AsFloat;
          cdsItensPed.FieldByName('ITE_PREVE6').AsFloat  := qryGenGir.FieldByName('ITE_PREVE6').AsFloat;
          cdsItensPed.FieldByName('ITE_PREVE7').AsFloat  := qryGenGir.FieldByName('ITE_PREVE7').AsFloat;
          cdsItensPed.FieldByName('ITE_MARBR1').AsFloat  := qryGenGir.FieldByName('ITE_MARBR1').AsFloat;
          cdsItensPed.FieldByName('ITE_MARBR2').AsFloat  := qryGenGir.FieldByName('ITE_MARBR2').AsFloat;
          cdsItensPed.FieldByName('ITE_MARBR3').AsFloat  := qryGenGir.FieldByName('ITE_MARBR3').AsFloat;
          cdsItensPed.FieldByName('ITE_MARBR4').AsFloat  := qryGenGir.FieldByName('ITE_MARBR4').AsFloat;
          cdsItensPed.FieldByName('ITE_MARBR5').AsFloat  := qryGenGir.FieldByName('ITE_MARBR5').AsFloat;
          cdsItensPed.FieldByName('ITE_MARBR6').AsFloat  := qryGenGir.FieldByName('ITE_MARBR6').AsFloat;
          cdsItensPed.FieldByName('ITE_MARBR7').AsFloat  := qryGenGir.FieldByName('ITE_MARBR7').AsFloat;
          If Assigned(qryGenGir.FindField('COT_FORESC')) Then
          Begin
            cdsItensPed.FieldByName('ITE_FORESC').AsString  := qryGenGir.FieldByName('COT_FORESC').AsString;
            cdsItensPed.FieldByName('ITE_IPIESC').AsFloat  := qryGenGir.FieldByName('COT_IPIENT').AsFloat * fltQtdIte;
            cdsItensPed.FieldByName('ITE_ST_ESC').AsFloat  := qryGenGir.FieldByName('COT_SUBSTI').AsFloat * fltQtdIte;
            cdsItensPed.FieldByName('ITE_VRTESC').AsFloat  := qryGenGir.FieldByName('COT_VALUNI').AsFloat * fltQtdIte;
          End;

          If Assigned(qryGenGir.FindField('COT_ALQCBS')) Then
          Begin
            cdsItensPed.FieldByName('ITE_ALQCBS').AsFloat  := qryGenGir.FieldByName('COT_ALQCBS').AsFloat;
            cdsItensPed.FieldByName('ITE_ALQIBS').AsFloat  := qryGenGir.FieldByName('COT_ALQIBS').AsFloat;
            cdsItensPed.FieldByName('ITE_ALQ_IS').AsFloat  := qryGenGir.FieldByName('COT_ALQ_IS').AsFloat;
          End;

          pCalculaImpostosReformaItem(cdsItensPed, False);

          cdsItensPed.FieldByName('ITE_UNITAR').AsFloat  := fltUnitar;
          cdsItensPed.FieldByName('ITE_UNIORI').AsFloat  := fltUnitar;

          If (blnAltPed) And (qryGenGir.FieldByName('PCD_UNITAR').AsFloat > 0) Then
          Begin
            cdsItensPed.FieldByName('ITE_DESUNI').AsFloat  := qryGenGir.FieldByName('PCD_DESUNI').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN2').AsFloat  := qryGenGir.FieldByName('PCD_DESUN2').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN3').AsFloat  := qryGenGir.FieldByName('PCD_DESUN3').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN4').AsFloat  := qryGenGir.FieldByName('PCD_DESUN4').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN5').AsFloat  := qryGenGir.FieldByName('PCD_DESUN5').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN6').AsFloat  := qryGenGir.FieldByName('PCD_DESUN6').AsFloat;
          End Else
          Begin
            cdsItensPed.FieldByName('ITE_DESUNI').AsFloat  := fltDesUni;
            cdsItensPed.FieldByName('ITE_DESUN2').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN3').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN4').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN5').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN6').AsFloat  := 0;
          End;

          If (Pos(strUniPcg, '7_') > 0)  Then
          Begin
            cdsItensPed.FieldByName('ITE_DESUNI').AsFloat  := qryGenGir.FieldByName('ITE_DESF01').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN2').AsFloat  := qryGenGir.FieldByName('ITE_DESF02').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN3').AsFloat  := qryGenGir.FieldByName('ITE_DESF03').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN4').AsFloat  := qryGenGir.FieldByName('ITE_DESF04').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN5').AsFloat  := qryGenGir.FieldByName('ITE_DESF05').AsFloat;
            cdsItensPed.FieldByName('ITE_DESUN6').AsFloat  := qryGenGir.FieldByName('ITE_DESF06').AsFloat;
          End Else
          If (Not ((blnAltPed) And (qryGenGir.FieldByName('PCD_UNITAR').AsFloat > 0))) And
             (Pos(strUniPcg, '2_4_8_') > 0) Then
          Begin
            cdsItensPed.FieldByName('ITE_DESUNI').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN2').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN3').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN4').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN5').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_DESUN6').AsFloat  := 0;
            cdsItensPed.FieldByName('ITE_ACRFIN').AsFloat  := 0;
          End;

          cdsItensPed.FieldByName('ITE_UNILIQ').AsFloat  := fCalculaUnitarioLiquido(intDecUni,
                                                              fltUnitar,
                                                              cdsItensPed.FieldByName('ITE_DESUNI').AsFloat,
                                                              cdsItensPed.FieldByName('ITE_DESUN2').AsFloat,
                                                              cdsItensPed.FieldByName('ITE_DESUN3').AsFloat,
                                                              cdsItensPed.FieldByName('ITE_DESUN4').AsFloat,
                                                              cdsItensPed.FieldByName('ITE_DESUN5').AsFloat,
                                                              cdsItensPed.FieldByName('ITE_DESUN6').AsFloat);

          cdsItensPed.FieldByName('ITE_DIFPRE').AsFloat  := Iif(cdsItensPed.FieldByName('ITE_PREULT').AsFloat = 0, 0, (((cdsItensPed.FieldByName('ITE_UNITAR').AsFloat - cdsItensPed.FieldByName('ITE_PREULT').AsFloat) / cdsItensPed.FieldByName('ITE_PREULT').AsFloat) * 100));

          cdsItensPed.FieldByName('ITE_CPRCEN').AsString := qryGenGir.FieldByName('ITE_CPRCEN').AsString;
          cdsItensPed.FieldByName('ITE_EMPCEN').AsString := qryGenGir.FieldByName('ITE_EMPCEN').AsString;
          cdsItensPed.FieldByName('ITE_PRINCI').AsString := qryGenGir.FieldByName('ITE_PRINCI').AsString;
          If blnSitPro And blnCorIpd Then
          Begin
            cdsItensPed.FieldByName('ITE_DESSIT').AsString := qryGenGir.FieldByName('SIT_DESCRI').AsString;
            cdsItensPed.FieldByName('ITE_CORSIT').AsString := qryGenGir.FieldByName('SIT_CORSIT').AsString;
          End;

          cdsItensPed.FieldByName('ITE_CICMDE').AsString := qryGenGir.FieldByName('ITE_CICMDE').AsString;
          cdsItensPed.FieldByName('ITE_CDPIOP').AsString := qryGenGir.FieldByName('ITE_CDPIOP').AsString;
          cdsItensPed.FieldByName('ITE_DIDIOP').AsString := qryGenGir.FieldByName('ITE_DIDIOP').AsString;

          cdsItensPed.FieldByName('ITE_CPCEMO').AsString := IfThen(qryGenGir.FieldByName('ITE_CPRCEN').AsString='S', 'C', 'I');
          cdsItensPed.FieldByName('ITE_CODFAB').AsString := qryGenGir.FieldByName('ITE_CODFAB').AsString;
          cdsItensPed.FieldByName('ITE_CODBAR').AsString := qryGenGir.FieldByName('ITE_CODBAR').AsString;
          cdsItensPed.FieldByName('ITE_CODSIM').AsString := qryGenGir.FieldByName('ITE_CODSIM').AsString;
          cdsItensPed.FieldByName('ITE_MLTSPO').AsString := qryGenGir.FieldByName('ITE_MLTSPO').AsString;
          cdsItensPed.FieldByName('ITE_DESSIM').AsString := qryGenGir.FieldByName('ITE_DESSIM').AsString;
          cdsItensPed.FieldByName('ITE_DESGRU').AsString := qryGenGir.FieldByName('ITE_DESGRU').AsString;
          cdsItensPed.FieldByName('AUTOINCREM').AsString := qryGenGir.FieldByName('AUTOINCREM').AsString;
          cdsItensPed.FieldByName('ITE_ITEFRA').AsString := qryGenGir.FieldByName('UNI_ITEFRA').AsString;

          If IfThen(blnMedAju, cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat, cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat) > 0 Then
          Begin
            cdsItensPed.FieldByName('ITE_DIAEST').AsInteger := Trunc(RoundTo(cdsItensPed.FieldByName('ITE_SALBAS').AsFloat /
                                                                 (IfThen(blnMedAju, cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat,
                                                                                 cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));

            cdsItensPed.FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((cdsItensPed.FieldByName('ITE_SALBAS').AsFloat +
                                                                      cdsItensPed.FieldByName('ITE_QTDITE').AsFloat) /
                                                                 (IfThen(blnMedAju, cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat,
                                                                                 cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));

          End Else
          Begin
            cdsItensPed.FieldByName('ITE_DIAEST').Clear;
            cdsItensPed.FieldByName('ITE_DIASUG').Clear;
          End;

          {*****************************************}
          {* EXECUTA O INSERT NA TEMPORARIA        *}
          {**************************************MV*}

          If FOpcGir.blnVenEsp And
             fEmptyStr(strSeqCot) And fEmptyStr(strNumPedUmaLoja) And fEmptyStr(strNumPed) And
             (cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat = 0) And
             (cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat = 0) And
             (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat >= 0) And
             ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido)) Then
            cdsItensPed.Cancel
          Else
          begin
            {*****************************************}
            {* Requisito 72407 ajustar o saldo apenas*}
            {* até zerar quando blnVenEsp            *}
            {**************************************WG*}
            If FOpcGir.blnVenEsp And
               fEmptyStr(strSeqCot) And fEmptyStr(strNumPedUmaLoja) And fEmptyStr(strNumPed) And
               (cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat = 0) And
               (cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat = 0) And
               (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat < 0) And
               ((Not Assigned(objRecupera)) Or (Not objRecupera.recPcmger.blnRecuperaPedido)) Then
             begin
               cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := - cdsItensPed.FieldByName('ITE_SALBAS').AsFloat;

               cdsItensPed.FieldByName('ITE_SUGEST').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat;
             End;

            If cdsItensPed.FieldByName('ITE_QTDEMB').IsNull Or (cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat = 0) Then
              cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat := 1;

            If cdsItensPed.FieldByName('ITE_QTDTRA').IsNull Then
              cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat := 0;

            pCalculaVariacaoCompra(cdsItensPed);

            cdsItensPed.FieldByName('ITE_TRAINC').AsFloat :=  cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat;

            cdsItensPed.FieldByName('ITE_QTDALT').AsString := 'N';
            cdsItensPed.FieldByName('ITE_FORPRI').AsString := qryGenGir.FieldByName('ITE_FORPRI').AsString;
            cdsItensPed.FieldByName('ITE_DEPART').AsString := qryGenGir.FieldByName('ITE_DEPART').AsString;

            if fEmptyStr(cdsItensPed.FieldByName('ITE_TIPABS').AsString) or (lstrCodEmp = qryGenGir.FieldByName('GIR_CODEMP').AsString) then
              cdsItensPed.FieldByName('ITE_TIPABS').AsString := qryGenGir.FieldByName('ITE_TIPABS').AsString;

            if fEmptyStr(cdsItensPed.FieldByName('ITE_VNOLCD').AsString) or (lstrCodEmp = qryGenGir.FieldByName('GIR_CODEMP').AsString) then
              cdsItensPed.FieldByName('ITE_VNOLCD').AsString := qryGenGir.FieldByName('ITE_VNOLCD').AsString;
            cdsItensPed.Post;
          End

        End;
      End;

      If blnConsMesAtu Then
      Begin
        Dec(intQtdMes);
      End;

      {*****************************************}
      {* REPOSICIONA NO REGISTRO DO PRÓXIMO    *}
      {* ITEM A SER PROCESSADO.                *}
      {**************************************MV*}
      qryGenGir.GotoBookmark(bkmUltimoRegItem);
      pgbProgresso.Position := fltPosUltimoRegItem;

      If strItemAnt = qryGenGir.FieldByName('GIR_CODITE').AsString Then
      Begin
        qryGenGir.Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    End;
  End;

  SetLength(arrDatas, 0);
end;

Function TGiroPedido.fSQLCamposGirIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' GIR_A_N_O_, ';
  strSQL := strSQL + ' GIR_CODITE, ';
  strSQL := strSQL + ' GIR_CODEMP, ';

  strSQL := strSQL + ' GIR_QENT01, ';
  strSQL := strSQL + ' GIR_QSAI01, ';
  strSQL := strSQL + ' GIR_QENT02, ';
  strSQL := strSQL + ' GIR_QSAI02, ';
  strSQL := strSQL + ' GIR_QENT03, ';
  strSQL := strSQL + ' GIR_QSAI03, ';
  strSQL := strSQL + ' GIR_QENT04, ';
  strSQL := strSQL + ' GIR_QSAI04, ';
  strSQL := strSQL + ' GIR_QENT05, ';
  strSQL := strSQL + ' GIR_QSAI05, ';
  strSQL := strSQL + ' GIR_QENT06, ';
  strSQL := strSQL + ' GIR_QSAI06, ';
  strSQL := strSQL + ' GIR_QENT07, ';
  strSQL := strSQL + ' GIR_QSAI07, ';
  strSQL := strSQL + ' GIR_QENT08, ';
  strSQL := strSQL + ' GIR_QSAI08, ';
  strSQL := strSQL + ' GIR_QENT09, ';
  strSQL := strSQL + ' GIR_QSAI09, ';
  strSQL := strSQL + ' GIR_QENT10, ';
  strSQL := strSQL + ' GIR_QSAI10, ';
  strSQL := strSQL + ' GIR_QENT11, ';
  strSQL := strSQL + ' GIR_QSAI11, ';
  strSQL := strSQL + ' GIR_QENT12, ';
  strSQL := strSQL + ' GIR_QSAI12, ';

  strSQL := strSQL + ' GIR_DSAI01, ';
  strSQL := strSQL + ' GIR_DSAI02, ';
  strSQL := strSQL + ' GIR_DSAI03, ';
  strSQL := strSQL + ' GIR_DSAI04, ';
  strSQL := strSQL + ' GIR_DSAI05, ';
  strSQL := strSQL + ' GIR_DSAI06, ';
  strSQL := strSQL + ' GIR_DSAI07, ';
  strSQL := strSQL + ' GIR_DSAI08, ';
  strSQL := strSQL + ' GIR_DSAI09, ';
  strSQL := strSQL + ' GIR_DSAI10, ';
  strSQL := strSQL + ' GIR_DSAI11, ';
  strSQL := strSQL + ' GIR_DSAI12, ';

  strSQL := strSQL + ' GIR_MDSA01, ';
  strSQL := strSQL + ' GIR_MQSA01, ';
  strSQL := strSQL + ' GIR_MDSA02, ';
  strSQL := strSQL + ' GIR_MQSA02, ';
  strSQL := strSQL + ' GIR_MDSA03, ';
  strSQL := strSQL + ' GIR_MQSA03, ';
  strSQL := strSQL + ' GIR_MDSA04, ';
  strSQL := strSQL + ' GIR_MQSA04, ';
  strSQL := strSQL + ' GIR_MDSA05, ';
  strSQL := strSQL + ' GIR_MQSA05, ';
  strSQL := strSQL + ' GIR_MDSA06, ';
  strSQL := strSQL + ' GIR_MQSA06, ';
  strSQL := strSQL + ' GIR_MDSA07, ';
  strSQL := strSQL + ' GIR_MQSA07, ';
  strSQL := strSQL + ' GIR_MDSA08, ';
  strSQL := strSQL + ' GIR_MQSA08, ';
  strSQL := strSQL + ' GIR_MDSA09, ';
  strSQL := strSQL + ' GIR_MQSA09, ';
  strSQL := strSQL + ' GIR_MDSA10, ';
  strSQL := strSQL + ' GIR_MQSA10, ';
  strSQL := strSQL + ' GIR_MDSA11, ';
  strSQL := strSQL + ' GIR_MQSA11, ';
  strSQL := strSQL + ' GIR_MDSA12, ';
  strSQL := strSQL + ' GIR_MQSA12, ';
  strSQL := strSQL + ' GIR_QPSA01,';
  strSQL := strSQL + ' GIR_QPSA02,';
  strSQL := strSQL + ' GIR_QPSA03,';
  strSQL := strSQL + ' GIR_QPSA04,';
  strSQL := strSQL + ' GIR_QPSA05,';
  strSQL := strSQL + ' GIR_QPSA06,';
  strSQL := strSQL + ' GIR_QPSA07,';
  strSQL := strSQL + ' GIR_QPSA08,';
  strSQL := strSQL + ' GIR_QPSA09,';
  strSQL := strSQL + ' GIR_QPSA10,';
  strSQL := strSQL + ' GIR_QPSA11,';
  strSQL := strSQL + ' GIR_QPSA12,';
  Result := strSQL;
End;

Function TGiroPedido.fSQLCamposSumGirIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' GIR_A_N_O_, ';
  strSQL := strSQL + ' FIL_CODPRI AS GIR_CODITE, ';
  strSQL := strSQL + ' GIR_CODEMP, ';

  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT01, 0)) AS GIR_QENT01, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI01, 0)) AS GIR_QSAI01, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT02, 0)) AS GIR_QENT02, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI02, 0)) AS GIR_QSAI02, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT03, 0)) AS GIR_QENT03, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI03, 0)) AS GIR_QSAI03, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT04, 0)) AS GIR_QENT04, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI04, 0)) AS GIR_QSAI04, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT05, 0)) AS GIR_QENT05, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI05, 0)) AS GIR_QSAI05, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT06, 0)) AS GIR_QENT06, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI06, 0)) AS GIR_QSAI06, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT07, 0)) AS GIR_QENT07, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI07, 0)) AS GIR_QSAI07, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT08, 0)) AS GIR_QENT08, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI08, 0)) AS GIR_QSAI08, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT09, 0)) AS GIR_QENT09, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI09, 0)) AS GIR_QSAI09, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT10, 0)) AS GIR_QENT10, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI10, 0)) AS GIR_QSAI10, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT11, 0)) AS GIR_QENT11, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI11, 0)) AS GIR_QSAI11, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QENT12, 0)) AS GIR_QENT12, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI12, 0)) AS GIR_QSAI12, ';

  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA01, 0)) AS GIR_QPSA01, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA02, 0)) AS GIR_QPSA02, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA03, 0)) AS GIR_QPSA03, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA04, 0)) AS GIR_QPSA04, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA05, 0)) AS GIR_QPSA05, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA06, 0)) AS GIR_QPSA06, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA07, 0)) AS GIR_QPSA07, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA08, 0)) AS GIR_QPSA08, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA09, 0)) AS GIR_QPSA09, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA10, 0)) AS GIR_QPSA10, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA11, 0)) AS GIR_QPSA11, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA12, 0)) AS GIR_QPSA12, ';

  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI01, 0)) AS GIR_DSAI01, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI02, 0)) AS GIR_DSAI02, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI03, 0)) AS GIR_DSAI03, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI04, 0)) AS GIR_DSAI04, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI05, 0)) AS GIR_DSAI05, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI06, 0)) AS GIR_DSAI06, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI07, 0)) AS GIR_DSAI07, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI08, 0)) AS GIR_DSAI08, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI09, 0)) AS GIR_DSAI09, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI10, 0)) AS GIR_DSAI10, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI11, 0)) AS GIR_DSAI11, ';
  strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI12, 0)) AS GIR_DSAI12, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA01, 0)) AS DATE) AS GIR_MDSA01, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA01, 0)) AS GIR_MQSA01, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA02, 0)) AS DATE) AS GIR_MDSA02, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA02, 0)) AS GIR_MQSA02, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA03, 0)) AS DATE) AS GIR_MDSA03, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA03, 0)) AS GIR_MQSA03, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA04, 0)) AS DATE) AS GIR_MDSA04, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA04, 0)) AS GIR_MQSA04, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA05, 0)) AS DATE) AS GIR_MDSA05, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA05, 0)) AS GIR_MQSA05, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA06, 0)) AS DATE) AS GIR_MDSA06, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA06, 0)) AS GIR_MQSA06, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA07, 0)) AS DATE) AS GIR_MDSA07, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA07, 0)) AS GIR_MQSA07, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA08, 0)) AS DATE) AS GIR_MDSA08, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA08, 0)) AS GIR_MQSA08, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA09, 0)) AS DATE) AS GIR_MDSA09, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA09, 0)) AS GIR_MQSA09, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA10, 0)) AS DATE) AS GIR_MDSA10, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA10, 0)) AS GIR_MQSA10, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA11, 0)) AS DATE) AS GIR_MDSA11, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA11, 0)) AS GIR_MQSA11, ';

  strSQL := strSQL + ' CAST(SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MDSA12, 0)) AS DATE) AS GIR_MDSA12, ';
  strSQL := strSQL + ' SUM(IF(IFNULL(ITE_CODSIM, "") = "" OR FIL_PRISIM = "S", GIR_MQSA12, 0)) AS GIR_MQSA12, ';

  Result := strSQL;
End;


{*****************************************}
{* EXECUTA O SQL NECESSÁRIO PARA O CÁL-  *}
{* CULO DO GIRO DE ESTOQUE.              *}
{**************************************MV*}
Function TGiroPedido.fExecutaSQLGiroEstoque(qryGenGir: TUniQuery;
                                 strAnoIni,
                                 strAnoFim,
                                 strCodEmp,
                                 strCodGru,
                                 strCodFor,
                                 strCodMar,
                                 strPrdGru,
                                 strGruCmp,
                                 strSitPro,
                                 strUnidade,
                                 strCodDep: String;
                                 intDiaVen: Integer;
                                 strAcoObj,
                                 strRefere,
                                 strDesIte,
                                 strCodCmp: String;
                                 arrCodFor,
                                 arrLinhaGrupo,
                                 arrMarca,
                                 arrPrdGru,
                                 arrGruCmp,
                                 arrSitPro,
                                 arrUnidade,
                                 arrCodDep: TConsultasArray;
                                 cdsEmpresasSel: OleVariant;
                                 slfLocFis: TSelecaoLocFisica = slfTodas;
                                 slsSaldos: TSelecaoSaldos = slsTodos): Boolean;
  Var
    strSQL: String;
    cdsEmpSel: TUniClientDataSet;
    strEmpCal,
    strEmpSel: String;

    Function fSQLItens: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT              ';
      strSQL := strSQL + '  "" AS ITE_SEQCOT, ';
      strSQL := strSQL + '  C.ITE_CODGRU, ';

      strSQL := strSQL + '  C.ITE_CLACRM, ';

      If fCfgSis('TIPABF') = '1' Then
        strSQL := strSQL + '  C.ITE_CODABF, '
      Else
        strSQL := strSQL + '  I.ITE_CODABF, ';

      strSQL := strSQL + '  I.ITE_CODITE, ';
      strSQL := strSQL + '  I.ITE_CODEMP, ';

      {*****************************************}
      {* MUDEI A POSIÇÃO DO "G.*", POR CONTA DA*}
      {* ALTERAÇÃO PARA REMOVER O CODGRU       *}
      {**************************************MV*}
      If blnAgrSim Then
      Begin
        strSQL := strSQL + fSQLCamposSumGirIte;
      End Else
      Begin
        strSQL := strSQL + fSQLCamposGirIte;
      End;

      If (strPedMlj = 'N') Then
        strSQL := strSQL + '  IF(((I.ITE_CPRCEN = "N") OR (IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") = ' + QuotedStr(VS_strCodEmp) + ')), "S", "N") AS "VALIDO", '
      Else
        strSQL := strSQL + '  "S" AS "VALIDO", ';

      strSQL := strSQL + '  C.ITE_APLICA, ';
      strSQL := strSQL + '  C.ITE_DIAFOR, ';

      strSQL := strSQL + '  C.ITE_REFERE, ';

      strSQL := strSQL + '  C.ITE_CODUNI, ';
      strSQL := strSQL + '  C.ITE_UNICOM, ';
      strSQL := strSQL + '  C.ITE_CODMAR, ';
      strSQL := strSQL + '  C.ITE_CODFOR, ';
      strSQL := strSQL + '  I.ITE_ESTMIN, ';
      strSQL := strSQL + '  I.ITE_ESTMAX, ';
      strSQL := strSQL + '  I.ITE_PMED_V, ';

      strSQL := strSQL + '  I.ITE_MINDIG, ';
      strSQL := strSQL + '  I.ITE_MAXDIG, ';

      strSQL := strSQL + '  I.ITE_PONPED, ';
      strSQL := strSQL + '  U.UNI_SIGUNI, ';

      strSQL := strSQL + fSQLCamposPrecoCusto(strCodFor);

      strSQL := strSQL + ' I.ITE_ABAMLT, ';

      If fCfgSis('CFPCFF', varBoolean) And (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
      Begin
        If fCfgSis('TABPRF', varBoolean) Then
          strSQL := strSQL + '  F.ITE_CODFAB AS ITE_CODFAB, '
        Else
          strSQL := strSQL + '  F.ITE_CODITF AS ITE_CODFAB, ';
      End
      Else
      Begin
        If fCfgSis('TABPRF', varBoolean) Then
          strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, '
        Else
          strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ';
      End;

      If fCfgSis('CODFIT', varBoolean) Then
      Begin
        strSQL := strSQL + '  C.ITE_CODFAB AS ITE_CODFAB, ';
      End
      Else
      Begin
        If fCfgSis('TABPRF', varBoolean) Then
          strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, '
        Else
          strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ';
      End;

      If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
      Begin
        strSQL := strSQL + fGetCodSitFornecedorSQL       + ' AS ITE_CODSIT, ';
        strSQL := strSQL + fGetCodSitOrigemFornecedorSQL + ' AS ITE_SITORI, ';
      End Else
      Begin
        strSQL := strSQL + ' "   " AS ITE_CODSIT, ';
        strSQL := strSQL + ' "   " AS ITE_SITORI, ';
      End;

      If blnAgrSim Then
      Begin
        strSQL := strSQL + '  SUM(S.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / ITE_CNV_ML, 0)) AS ITE_SALDOS, ';
        strSQL := strSQL +  fSQLSaldosReservadosAgrSim(False, False, FOpcGir, 'I', 'C', 'SP');
      End Else
      Begin
        strSQL := strSQL + '  I.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0) AS ITE_SALDOS, ';
        strSQL := strSQL +  fSQLSaldosReservados(False, False, FOpcGir, 'I', 'C','SP');
      End;

      If blnAnalisaITEFOR Then
        strSQL := strSQL + ' IF(LOCATE(C.ITE_CODFOR,' + QuotedStr(FOpcGir.fFornecedoresSelecionados) +') > 0, "*", "") AS ITE_PRINCI, '
      Else
        strSQL := strSQL + ' " " AS ITE_PRINCI, ';

      If blnSitPro  And blnCorIpd Then
      Begin
        strSQL := strSQL + '  SIT_CODIGO, ';
        strSQL := strSQL + '  SIT_CORSIT, ';
        strSQL := strSQL + '  SIT_DESCRI, ';
      End;

      strSQL := strSQL + '  I.ITE_CICMDE, ';
      strSQL := strSQL + '  I.ITE_CDPIOP, ';
      strSQL := strSQL + '  I.ITE_DIDIOP, ';


      strSQL := strSQL + '  I.ITE_ESTMIN, ';
      If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') And fCfgSis('TABPRF', varBoolean)  Then
      Begin
        If GlobalrecOpcoesGiro.blnEmbala Then
          strSQL := strSQL + '          IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1) AS ITE_EMBALA, '
        Else
          strSQL := strSQL + '          1 AS ITE_EMBALA, '
      End

      Else If blnGeraAuto Or ((Not fEmptyStr(strCodFor)) And (strCodFor <> '%')) Then
        strSQL := strSQL + '  IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = I.ITE_CODITE AND BAR_CODFOR = C.ITE_CODFOR ORDER BY BAR_COMPRA DESC  LIMIT 1), C.ITE_EMBALA) AS ITE_EMBALA, '
      Else
        strSQL := strSQL + '  C.ITE_EMBALA, ';

      strSQL := strSQL + '  I.ITE_MINDIG, ';
      strSQL := strSQL + '  I.ITE_MAXDIG, ';

      strSQL := strSQL + '  I.ITE_PREVE1, ';
      strSQL := strSQL + '  I.ITE_PREVE2, ';
      strSQL := strSQL + '  I.ITE_PREVE3, ';
      strSQL := strSQL + '  I.ITE_PREVE4, ';
      strSQL := strSQL + '  I.ITE_PREVE5, ';
      strSQL := strSQL + '  I.ITE_PREVE6, ';
      strSQL := strSQL + '  I.ITE_PREVE7, ';
      strSQL := strSQL + '  I.ITE_MARBR1, ';
      strSQL := strSQL + '  I.ITE_MARBR2, ';
      strSQL := strSQL + '  I.ITE_MARBR3, ';
      strSQL := strSQL + '  I.ITE_MARBR4, ';
      strSQL := strSQL + '  I.ITE_MARBR5, ';
      strSQL := strSQL + '  I.ITE_MARBR6, ';
      strSQL := strSQL + '  I.ITE_MARBR7, ';
      strSQL := strSQL + '  U.UNI_PESLIT AS ITE_LITROS, ';
      strSQL := strSQL + '  C.ITE_PESOIT, ';
      strSQL := strSQL + '  C.ITE_CODSIM, ';
      strSQL := strSQL + '  C.ITE_MLTSPO, ';
      strSQL := strSQL + '  C.ITE_CODBAR, ';
      strSQL := strSQL + '  I.ITE_CPRCEN, ';
      strSQL := strSQL + '  IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") AS ITE_EMPCEN, ';
      strSQL := strSQL + '  M.MAR_DESMAR, ';
      strSQL := strSQL + '  E.EMP_CODEMP, ';
      strSQL := strSQL + '  E.EMP_NOMEMP, ';
      strSQL := strSQL + '  E.EMP_NOMFAN, ';
      strSQL := strSQL + '  I.ITE_CODEMP, ';

      strSQL := strSQL + TNivelGiroCriticidade.fSQLNiveis(FOpcGir.recNivEst);

      strSQL := strSQL + '  U.UNI_ITEFRA, ';

      strSQL := strSQL + '  CAST("" AS CHAR(10)) AS ITE_INCIRQ, ';

      strSQL := strSQL + '  0.00 AS ITE_QTDREQ, ';

      strSQL := strSQL + '  I.ITE_ESMIDG, ';
      strSQL := strSQL + '  I.ITE_LOCFIS, ';
      strSQL := strSQL + '  C.ITE_INCPIS, ';
      strSQL := strSQL + '  I.AUTOINCREM, ';

      strSQL := strSQL + '  I.ITE_DTAUVE, ';
      strSQL := strSQL + '  I.ITE_PREUVE, ';
      strSQL := strSQL + '  I.ITE_QTDUVE, ';

      strSQL := strSQL + '  I.ITE_PREULT, ';
      strSQL := strSQL + '  I.ITE_IMPULT, ';
      strSQL := strSQL + '  I.ITE_QTDUCO, ';
      strSQL := strSQL + '  I.ITE_FORULT, ';
      strSQL := strSQL + '  I.ITE_PONEXP, ';

      strSQL := strSQL + '  UF.FOR_NOMFOR AS ITE_NOMFOR, ';
      strSQL := strSQL + '  ITE_DESSIM, ';
      strSQL := strSQL + '  IF(COALESCE(GRU_DRELIN, "") <> "", CONCAT(COALESCE(GRU_DRELIN, ""), " - ", COALESCE(GRU_DESGRU, "")),COALESCE(GRU_DESGRU, "") ) AS ITE_DESGRU, ';
      strSQL := strSQL + '  I.ITE_DTAULT,  ';
      strSQL := strSQL + '  FP.FOR_NOMFOR ITE_FORPRI, ';
      strSQL := strSQL + '  DP.DEP_DESCRI ITE_DEPART ';

      If Not fEmptyStr(strNumPedAlt) Then
      Begin
        strSQL := strSQL + ' , IFNULL((SELECT SUM(PCD_QTDITE - PCD_QTDBAI) FROM PCMDET WHERE ';
        strSQL := strSQL + '       PCD_CODITE = C.ITE_CODITE ' ;
        strSQL := strSQL + '   AND PCD_NUMPED = ' + QuotedStr(strNumPedAlt);
        strSQL := strSQL + '   AND PCD_CODEMP = ' + QuotedStr(strEmpPedAlt);
        strSQL := strSQL + '   AND PCD_ESPDOC = ' + QuotedStr(strEspPedAlt) + '), 0) AS PCD_QTDITE ';
      End;
      strSQL := strSQL + ',  I.ITE_QTEP_S ';
      strSQL := strSQL + ', I.ITE_TIPABS ';
      strSQL := strSQL + ', I.ITE_VNOLCD ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  GIRITE G ';

      If blnAgrSim Then
      Begin
        strSQL := strSQL + '  JOIN ' + strTableNameFILTRO_ITEM + ' ON    FIL_CODITE = G.GIR_CODITE ';

        strSQL := strSQL + '  JOIN ITEGER I    ON  I.ITE_CODITE =   FIL_CODPRI ';
        strSQL := strSQL + '                   AND I.ITE_CODEMP = G.GIR_CODEMP ';

        strSQL := strSQL + '  JOIN ITEGER S    ON  S.ITE_CODITE =   FIL_CODITE ';
        strSQL := strSQL + '                   AND S.ITE_CODEMP = G.GIR_CODEMP ';

        strSQL := strSQL + '  JOIN CADITE C ON C.ITE_CODITE = FIL_CODPRI ';

        strSQL := strSQL + '  LEFT JOIN SALPDC SP ON SP.SAL_CODITE =   FIL_CODITE ';
        strSQL := strSQL + '                     AND SP.SAL_CODEMP = I.ITE_CODEMP ';
      End Else
      Begin
        strSQL := strSQL + '  JOIN CADITE C ON C.ITE_CODITE = G.GIR_CODITE ';

        strSQL := strSQL + '  JOIN ' + strTableNameFILTRO_ITEM + ' ON    FIL_CODITE = C.ITE_CODITE ';

        strSQL := strSQL + '  JOIN ITEGER I    ON  I.ITE_CODITE = C.ITE_CODITE ';
        strSQL := strSQL + '                   AND I.ITE_CODEMP = G.GIR_CODEMP ';

        strSQL := strSQL + '  LEFT JOIN SALPDC SP ON SP.SAL_CODITE = I.ITE_CODITE ';
        strSQL := strSQL + '                     AND SP.SAL_CODEMP = I.ITE_CODEMP ';
      End;

      strSQL := strSQL + '  LEFT JOIN CADFOR FP ON FP.FOR_CODFOR = C.ITE_CODFOR ';
      strSQL := strSQL + '  LEFT JOIN CADDEP DP ON DP.DEP_CODIGO = C.ITE_CODDEP ';

      strSQL := strSQL + '  JOIN CADUNI U ON C.ITE_CODUNI = U.UNI_CODUNI ';
      strSQL := strSQL + '  JOIN CADMAR M ON C.ITE_CODMAR = M.MAR_CODMAR ';

      strSQL := strSQL + '  LEFT JOIN CADEMP E ON E.EMP_CODEMP = I.ITE_CODEMP ';

      strSQL := strSQL + '  LEFT JOIN CADFOR UF ON UF.FOR_CODFOR = I.ITE_FORULT ';

      strSQL := strSQL + '  LEFT JOIN CADGRU ON GRU_CODGRU = C.ITE_CODGRU ';

      strSQL := strSQL + '  LEFT JOIN ITEFOR F ON ';
      If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
      Begin
        strSQL := strSQL + '     F.ITE_CODITE = I.ITE_CODITE ';
        strSQL := strSQL + ' AND F.ITE_CODFOR = ' + QuotedStr(strCodFor);

        If fCfgSis('TABPRF', varBoolean) Then
        Begin
           strSQL := strSQL + '                    AND (SELECT COUNT(*) FROM TABPRE     ';
           strSQL := strSQL + '                          WHERE F.ITE_CODTAB = TAB_CODTAB AND ' + fSqlWhereTabPre('', strCodTab) + ') > 0 '
        End Else
        Begin
          strSQL := strSQL + '                    AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ';
          strSQL := strSQL + '                                         WHERE FF.ITE_CODITE = I.ITE_CODITE AND ';
          strSQL := strSQL + '                                          FF.ITE_CODFOR = ' + QuotedStr(strCodFor) + ') ';
        End;

        strSQL := strSQL + '  LEFT JOIN CADFOR CF ON CF.FOR_CODFOR = ' + QuotedStr(strCodFor);
        strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CF.FOR_CODCID     ';
        strSQL := strSQL + '  LEFT JOIN ABFICM ON ABF_CODABF = ' + IfThen(fCfgSis('TIPABF') = '1', 'C', 'I') + '.ITE_CODABF AND ';
        strSQL := strSQL + '                      ABF_ESTADO = CID_ESTADO     ';
      End
      Else
        strSQL := strSQL + ' F.ITE_CODITE = "" ';

      If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') And fCfgSis('TABPRF', varBoolean) Then
      Begin
        strSQL := strSQL + ' LEFT JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB ';
        strSQL := strSQL + '                   AND D.ITE_CODITE = F.ITE_CODITE ';
        strSQL := strSQL + '                   AND D.ITE_CODEMP = I.ITE_CODEMP  ';
      End;

      strSQL := strSQL + '  LEFT JOIN GRU_COMPRA GC ON C.ITE_GRUCMP = GC.GRU_CODIGO ';

      If blnSitPro And blnCorIpd Then
      Begin
        If blnSitEmp Then
          strSQL := strSQL + ' LEFT JOIN SITPRO ON C.ITE_SITPRO = SIT_CODIGO '
        Else
          strSQL := strSQL + ' LEFT JOIN SITPRO ON I.ITE_SITPRO = SIT_CODIGO ';
      End;

      strSQL := strSQL + 'WHERE TRUE ';

    //  strSQL := strSQL + '  AND I.ITE_CODITE = "02003" ';

      strSQL := strSQL + ' AND (GIR_A_N_O_ IN (' + fRetAnos  + ')) ';

      strSQL := strSQL + ' AND GIR_CODEMP IN (' + strEmpSel + ')  ';

    //  strSQL := strSQL + fSQLFiltros(strEmpSel, strEmpCal);

      strSQL := strSQL + 'GROUP BY ';

      If blnAgrSim Then
        strSQL := strSQL + '  FIL_AGRUPA, '
      Else
        strSQL := strSQL + '  GIR_CODITE, ';

      strSQL := strSQL + '  GIR_A_N_O_, GIR_CODEMP ';

      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  GIR_CODITE ASC, GIR_CODEMP ASC, GIR_A_N_O_ DESC  ';

      Result := strSQL;
    End;

begin
  pSetaNomeFuncao(fugExecutaSQLGiroEstoque);

  cdsEmpSel := TUniClientDataSet.Create(Nil);

  If cdsEmpresasSel <> Null Then
  Begin
    cdsEmpSel.Data := cdsEmpresasSel;

    If blnEmpVis Then
    Begin
      strEmpSel := fRetEmpresasSel(cdsEmpSel, 'EMPVIS');
      strEmpCal := fRetEmpresasSel(cdsEmpSel, 'MARDES');

      strEmpOriSpool := fRetEmpresasSel(cdsEmpSel, 'EMPVIS', False);
      strEmpDesSpool := fRetEmpresasSel(cdsEmpSel, 'MARDES', False);

      If fEmptyStr(strEmpSel) Then
        strEmpSel := strEmpCal;
    End Else
    Begin
      strEmpSel := fRetEmpresasSel(cdsEmpSel, 'MARDES');
      strEmpCal := fRetEmpresasSel(cdsEmpSel, 'MARDES');

      strEmpOriSpool := '';
      strEmpDesSpool := '';
    End;

  End Else
  Begin
    strEmpSel := QuotedStr(strEmpPed);
    strEmpCal := QuotedStr(strEmpPed);
  End;

  FstrEmpSel := strEmpSel;

  strSQL := AnsiReplaceStr(fSQLItens, '''', '"');

  {*******************************************}
  {* COM GIRO DE ESTOQUE OU TODOS            *}
  {****************************************MV*}
  {*****************************************}
  {* PREPARA A QUERY PARA VEERIFICAR DADOS *}
  {* DO GIRO                               *}
  {**************************************MV*}
  With qryGenGir Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    Try
      Open;
    Except

      On E: Exception Do
      Begin

        If Pos(strTableNameFILTRO_ITEM, E.Message) > 0 Then
        Begin
          pMensagemOk('Houve uma falha de conexão com o banco de dados, por favor tente novamente!');
          Result := False;
          Exit;
        End

        Else Raise;

      End;

    End;

    First;
  End;

  Result := True;

  FreeAndNil(cdsEmpSel);
end;

function TGiroPedido.fSQLFromPedidoMultiloja(blnRecupera: Boolean; strEmpGir: string): String;
   Var
     strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strSeqCot) Then
  Begin
    strSQL := strSQL + '	COTITE CT ';
    strSQL := strSQL + '	LEFT JOIN COTFOR CF2 ON CF2.COT_SEQGER = CT.COT_SEQGER AND CF2.COT_CODFOR = CT.COT_FORESC AND CF2.COT_CODITE = CT.COT_CODITE ';
  End Else
  Begin

    If blnRecupera Then
      strSQL := strSQL + '	PCMDET_RES PM '
    Else
      strSQL := strSQL + '	PCMDET PM ';

  End;

  If fEmptyStr(strSeqCot) Then
  Begin
    strSQL := strSQL + 'JOIN CADEMP E ON	  E.EMP_CODEMP  IN (' + strEmpGir + ')';

    If blnRecupera Then
    Begin

      strSQL := strSQL + ' LEFT JOIN PCDDET_RES PD ON PD.PCD_SEQPCG = PM.PCD_SEQGER ';
      strSQL := strSQL + '                        AND PD.PCD_CODITE = PM.PCD_CODITE ';
      strSQL := strSQL + '                        AND PD.PCD_EMPDES =  E.EMP_CODEMP ';
    End
    Else
      strSQL := strSQL + ' LEFT JOIN PCDDET PD ON PD.PCD_SEQGER = PM.AUTOINCREM AND PD.PCD_EMPDES = E.EMP_CODEMP ';

    strSQL := strSQL + 'JOIN CADITE C ON 	  C.ITE_CODITE = PM.PCD_CODITE ';

    strSQL := strSQL + 'JOIN ITEGER I ON 	  I.ITE_CODITE = PM.PCD_CODITE AND ';
    strSQL := strSQL + '			              I.ITE_CODEMP = E.EMP_CODEMP ';
  End Else
  Begin
    strSQL := strSQL + 'JOIN CADITE C ON 	  C.ITE_CODITE = CT.COT_CODITE ';

    strSQL := strSQL + 'JOIN CADEMP E ON	  E.EMP_CODEMP  IN (' + strEmpGir + ')';
    strSQL := strSQL + 'JOIN ITEGER I ON 	  I.ITE_CODITE = C.ITE_CODITE  ';
    strSQL := strSQL + '                AND	I.ITE_CODEMP = E.EMP_CODEMP  ';

     strSQL := strSQL + 'LEFT JOIN PCDCOT PD ON PD.PCD_SEQGER = CT.COT_SEQGER AND PD.PCD_CODITE = CT.COT_CODITE AND PD.PCD_EMPDES = I.ITE_CODEMP ';
   End;

  strSQL := strSQL + '  LEFT JOIN SALPDC SP ON SP.SAL_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                     AND SP.SAL_CODEMP = I.ITE_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU  ';

  strSQL := strSQL + '  LEFT JOIN ITEFOR F ON ';
  If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
  Begin
    strSQL := strSQL + '     F.ITE_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + ' AND F.ITE_CODFOR = ' + QuotedStr(strCodFor);
    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      strSQL := strSQL + '                    AND (SELECT COUNT(*) FROM TABPRE     ';
      strSQL := strSQL + '                          WHERE F.ITE_CODTAB = TAB_CODTAB AND ' + fSqlWhereTabPre('', strCodTab) + ') > 0 '
    End Else
    Begin
      strSQL := strSQL + '                    AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ';
      strSQL := strSQL + '                                         WHERE FF.ITE_CODITE = I.ITE_CODITE AND ';
      strSQL := strSQL + '                                          FF.ITE_CODFOR = ' + QuotedStr(strCodFor) + ') ';
    End;
    strSQL := strSQL + '  LEFT JOIN CADFOR CF ON CF.FOR_CODFOR = ' + QuotedStr(strCodFor);
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CF.FOR_CODCID     ';
    strSQL := strSQL + '  LEFT JOIN ABFICM ON ABF_CODABF = ' + IfThen(fCfgSis('TIPABF') = '1', 'C', 'I') + '.ITE_CODABF AND ';
    strSQL := strSQL + '                      ABF_ESTADO = CID_ESTADO     ';
  End
  Else
    strSQL := strSQL + ' F.ITE_CODITE = "" ';

  If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') And fCfgSis('TABPRF', varBoolean) Then
  Begin
    strSQL := strSQL + ' LEFT JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB ';
    strSQL := strSQL + '                   AND D.ITE_CODITE = F.ITE_CODITE ';
    strSQL := strSQL + '                   AND D.ITE_CODEMP = I.ITE_CODEMP  ';
  End;

  strSQL := strSQL + '  LEFT JOIN CADFOR UF ON UF.FOR_CODFOR = I.ITE_FORULT ';

  If fEmptyStr(strSeqCot) Then
    strSQL := strSQL + 'JOIN CADUNI U ON	  U.UNI_CODUNI = PM.PCD_CODUNI '
  Else
    strSQL := strSQL + 'JOIN CADUNI U ON	  U.UNI_CODUNI = C.ITE_CODUNI ';

  strSQL := strSQL + 'JOIN CADMAR M ON	  M.MAR_CODMAR = C.ITE_CODMAR ';

  strSQL := strSQL + 'LEFT JOIN GRU_COMPRA GC ON C.ITE_GRUCMP = GC.GRU_CODIGO ';

  If blnSitPro And blnCorIpd Then
  Begin
    If blnSitEmp Then
      strSQL := strSQL + ' LEFT JOIN SITPRO ON C.ITE_SITPRO = SIT_CODIGO '
    Else
      strSQL := strSQL + ' LEFT JOIN SITPRO ON I.ITE_SITPRO = SIT_CODIGO ';
  End;

  If fEmptyStr(strSeqCot) Then
  Begin
    strSQL := strSQL + ' LEFT JOIN GIRITE G ON G.GIR_CODITE = PM.PCD_CODITE AND ';
    strSQL := strSQL + '  		                 G.GIR_CODEMP = E.EMP_CODEMP AND ';
  End Else
  Begin
    strSQL := strSQL + 'LEFT JOIN GIRITE G ON G.GIR_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '			                G.GIR_CODEMP = E.EMP_CODEMP AND ';
  End;

  strSQL := strSQL + ' ((GIR_A_N_O_ IN (' + fRetAnos + ')) OR GIR_A_N_O_ IS NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADFOR FP ON FP.FOR_CODFOR = C.ITE_CODFOR ';
  strSQL := strSQL + '  LEFT JOIN CADDEP DP ON DP.DEP_CODIGO = C.ITE_CODDEP ';

  Result := strSQL;
End;

function TGiroPedido.fSQLWherePedidoMultiloja(blnRecupera: Boolean; strEmpGir: string): String;
   Var
     strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strSeqCot) Then
  Begin
    strSQL := strSQL + ' CT.COT_SEQGER = :SEQCOT ';
  End Else
  Begin
    strSQL := strSQL + ' PM.PCD_BAIXAD = 0 AND ';

    strSQL := strSQL + ' PM.PCD_NUMCTN = 0 ';

    If blnRecupera Then
    Begin

      strSQL := strSQL + '  AND PM.EXCLUIDO <> "S" ';
      strSQL := strSQL + '  AND PM.PCD_SEQGER = ' + QuotedStr(objRecupera.recPcmger.strAutInc);

    End Else
    Begin

      strSQL := strSQL + ' AND PM.PCD_NUMPED = :NUMPED  ';
      strSQL := strSQL + ' AND PM.PCD_ESPDOC = :ESPPED  ';
      strSQL := strSQL + ' AND PM.PCD_CODEMP = :CODEMP  ';

      If objRecupera.recPcmger.blnRecuperaPedido Then
      Begin
        strSQL := strSQL + ' AND (SELECT COUNT(*) FROM PCDDET_RES R ';
        strSQL := strSQL + '      WHERE R.PCD_CODITE = GIR_CODITE AND ';
        strSQL := strSQL + '            R.PCD_EMPDES = GIR_CODEMP AND ';
        strSQL := strSQL + '            R.PCD_SEQPCG = ' + QuotedStr(objRecupera.recPcmger.strAutInc) + ') = 0 ';

        strSQL := strSQL + ' AND IFNULL((SELECT EXCLUIDO FROM PCMDET_RES PR WHERE PR.PCD_CODITE = GIR_CODITE AND ';
        strSQL := strSQL + '             PR.PCD_SEQGER = ' + QuotedStr(objRecupera.recPcmger.strAutInc) + '), "N") <> "S" ';
      End;

    End;

  End;

  Result := strSQL;
End;

Function TGiroPedido.fSQLCriaTempSimilarPedidoMultiloja(strEmpGir: string): String;
  Var
    strSQLCabecalho,
    strSQL: String;
Begin
  strTableSimilar := fGetMemoryTableName('TAB_SIMILIAR');

  strSQLCabecalho := strSQLCabecalho + ' DROP TABLE IF EXISTS ' + strTableSimilar + '; ';
  strSQLCabecalho := strSQLCabecalho + ' CREATE TABLE ' + strTableSimilar + '        ';
  strSQL := '';

  If (Not fEmptyStr(strNumPed)) Or (Not fEmptyStr(strSeqCot)) Then
  Begin

    strSQL := strSQL + ' SELECT DISTINCT                            ';
    strSQL := strSQL + '   C.ITE_CODITE  AS SIM_CODITE,             ';
    strSQL := strSQL + '   IFNULL(CS.ITE_CODITE, C.ITE_CODITE) AS SIM_SIMILA  ';
    strSQL := strSQL + ' FROM                                       ';

    strSQL := strSQL +     fSQLFromPedidoMultiloja(False, strEmpGir);

    strSQL := strSQL + '   LEFT JOIN CADITE CS ON CS.ITE_CODSIM = C.ITE_CODSIM     ';

    strSQL := strSQL + ' WHERE                                                      ';

    strSQL := strSQL +    Trim(fSQLWherePedidoMultiloja(False, strEmpGir));
  End;

  If Assigned(objRecupera) And objRecupera.recPcmger.blnRecuperaPedido Then
  Begin
    If Not fEmptyStr(strSQL) Then
      strSQL := strSQL + ' UNION ';

    strSQL := strSQL + ' SELECT DISTINCT                            ';
    strSQL := strSQL + '   C.ITE_CODITE  AS SIM_CODITE,             ';
    strSQL := strSQL + '   IFNULL(CS.ITE_CODITE, C.ITE_CODITE) AS SIM_SIMILA  ';
    strSQL := strSQL + ' FROM                                       ';

    strSQL := strSQL +     fSQLFromPedidoMultiloja(True, strEmpGir);

    strSQL := strSQL + '   LEFT JOIN CADITE CS ON CS.ITE_CODSIM = C.ITE_CODSIM     ';

    strSQL := strSQL + ' WHERE                                                      ';

    strSQL := strSQL +    Trim(fSQLWherePedidoMultiloja(True, strEmpGir));
  End;

  strSQL := strSQL + '; ';

  strSQL := strSQL + ' CREATE INDEX IDX1 ON ' + strTableSimilar + '(SIM_CODITE);              ';
  strSQL := strSQL + ' CREATE INDEX IDX2 ON ' + strTableSimilar + '(SIM_SIMILA);              ';

  Result := strSQLCabecalho + strSQL;
End;

Function TGiroPedido.fSQLPedidoMultiloja(blnRecupera: Boolean; strEmpGir: string): String;
  Var
    strSQL: String;
    intContador: Integer;

    Function fGirIte(intContador: Integer; strCampo: String): String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + '     (SELECT SUM(IFNULL(GG.' + strCampo + RightStr('0' + IntToStr(intContador) , 2) + ', 0)) FROM GIRITE GG ';
      strSQL := strSQL + '      INNER JOIN ' + strTableSimilar + ' SP ON SP.SIM_SIMILA = GG.GIR_CODITE ';
      strSQL := strSQL + '      WHERE GG.GIR_CODEMP = G.GIR_CODEMP AND GG.GIR_A_N_O_ = G.GIR_A_N_O_ AND SP.SIM_CODITE = C.ITE_CODITE) ';

      Result := strSQL;
    End;

Begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  "S" AS "VALIDO", ';
  strSQL := strSQL + '  IFNULL(G.GIR_A_N_O_, YEAR(CURRENT_DATE)) AS GIR_A_N_O_, ';
  strSQL := strSQL + '  C.ITE_CODITE AS GIR_CODITE, ';

  If blnAgrSim Then
  Begin

    For intContador := 1 To 12 Do
    Begin
      strSQL := strSQL + fGirIte(intContador, 'GIR_QENT') + ' AS GIR_QENT' + RightStr('0' + IntToStr(intContador) , 2) + ', ';
      strSQL := strSQL + fGirIte(intContador, 'GIR_QSAI') + ' AS GIR_QSAI' + RightStr('0' + IntToStr(intContador) , 2) + ', ';
      strSQL := strSQL + fGirIte(intContador, 'GIR_DSAI') + ' AS GIR_DSAI' + RightStr('0' + IntToStr(intContador) , 2) + ', ';
      strSQL := strSQL + fGirIte(intContador, 'GIR_QPSA') + ' AS GIR_QPSA' + RightStr('0' + IntToStr(intContador) , 2) + ', ';
    End;

  End Else
  Begin
    strSQL := strSQL + '  G.GIR_QENT01, ';
    strSQL := strSQL + '  G.GIR_QSAI01, ';
    strSQL := strSQL + '  G.GIR_QENT02, ';
    strSQL := strSQL + '  G.GIR_QSAI02, ';
    strSQL := strSQL + '  G.GIR_QENT03, ';
    strSQL := strSQL + '  G.GIR_QSAI03, ';
    strSQL := strSQL + '  G.GIR_QENT04, ';
    strSQL := strSQL + '  G.GIR_QSAI04, ';
    strSQL := strSQL + '  G.GIR_QENT05, ';
    strSQL := strSQL + '  G.GIR_QSAI05, ';
    strSQL := strSQL + '  G.GIR_QENT06, ';
    strSQL := strSQL + '  G.GIR_QSAI06, ';
    strSQL := strSQL + '  G.GIR_QENT07, ';
    strSQL := strSQL + '  G.GIR_QSAI07, ';
    strSQL := strSQL + '  G.GIR_QENT08, ';
    strSQL := strSQL + '  G.GIR_QSAI08, ';
    strSQL := strSQL + '  G.GIR_QENT09, ';
    strSQL := strSQL + '  G.GIR_QSAI09, ';
    strSQL := strSQL + '  G.GIR_QENT10, ';
    strSQL := strSQL + '  G.GIR_QSAI10, ';
    strSQL := strSQL + '  G.GIR_QENT11, ';
    strSQL := strSQL + '  G.GIR_QSAI11, ';
    strSQL := strSQL + '  G.GIR_QENT12, ';
    strSQL := strSQL + '  G.GIR_QSAI12, ';

    strSQL := strSQL + '  G.GIR_QPSA01, ';
    strSQL := strSQL + '  G.GIR_QPSA02, ';
    strSQL := strSQL + '  G.GIR_QPSA03, ';
    strSQL := strSQL + '  G.GIR_QPSA04, ';
    strSQL := strSQL + '  G.GIR_QPSA05, ';
    strSQL := strSQL + '  G.GIR_QPSA06, ';
    strSQL := strSQL + '  G.GIR_QPSA07, ';
    strSQL := strSQL + '  G.GIR_QPSA08, ';
    strSQL := strSQL + '  G.GIR_QPSA09, ';
    strSQL := strSQL + '  G.GIR_QPSA10, ';
    strSQL := strSQL + '  G.GIR_QPSA11, ';
    strSQL := strSQL + '  G.GIR_QPSA12, ';

    strSQL := strSQL + '  G.GIR_DSAI01, ';
    strSQL := strSQL + '  G.GIR_DSAI02, ';
    strSQL := strSQL + '  G.GIR_DSAI03, ';
    strSQL := strSQL + '  G.GIR_DSAI04, ';
    strSQL := strSQL + '  G.GIR_DSAI05, ';
    strSQL := strSQL + '  G.GIR_DSAI06, ';
    strSQL := strSQL + '  G.GIR_DSAI07, ';
    strSQL := strSQL + '  G.GIR_DSAI08, ';
    strSQL := strSQL + '  G.GIR_DSAI09, ';
    strSQL := strSQL + '  G.GIR_DSAI10, ';
    strSQL := strSQL + '  G.GIR_DSAI11, ';
    strSQL := strSQL + '  G.GIR_DSAI12, ';
  End;

  strSQL := strSQL + '  G.GIR_MDSA01, ';
  strSQL := strSQL + '  G.GIR_MQSA01, ';
  strSQL := strSQL + '  G.GIR_MDSA02, ';
  strSQL := strSQL + '  G.GIR_MQSA02, ';
  strSQL := strSQL + '  G.GIR_MDSA03, ';
  strSQL := strSQL + '  G.GIR_MQSA03, ';
  strSQL := strSQL + '  G.GIR_MDSA04, ';
  strSQL := strSQL + '  G.GIR_MQSA04, ';
  strSQL := strSQL + '  G.GIR_MDSA05, ';
  strSQL := strSQL + '  G.GIR_MQSA05, ';
  strSQL := strSQL + '  G.GIR_MDSA06, ';
  strSQL := strSQL + '  G.GIR_MQSA06, ';
  strSQL := strSQL + '  G.GIR_MDSA07, ';
  strSQL := strSQL + '  G.GIR_MQSA07, ';
  strSQL := strSQL + '  G.GIR_MDSA08, ';
  strSQL := strSQL + '  G.GIR_MQSA08, ';
  strSQL := strSQL + '  G.GIR_MDSA09, ';
  strSQL := strSQL + '  G.GIR_MQSA09, ';
  strSQL := strSQL + '  G.GIR_MDSA10, ';
  strSQL := strSQL + '  G.GIR_MQSA10, ';
  strSQL := strSQL + '  G.GIR_MDSA11, ';
  strSQL := strSQL + '  G.GIR_MQSA11, ';
  strSQL := strSQL + '  G.GIR_MDSA12, ';
  strSQL := strSQL + '  G.GIR_MQSA12, ';

  strSQL := strSQL + '  I.ITE_CODEMP AS GIR_CODEMP, ';

  If Not fEmptyStr(strSeqCot) Then
  Begin
    strSQL := strSQL + '  I.AUTOINCREM, ';
    strSQL := strSQL + '  PCD_SEQGER AS ITE_SEQCOT, ';
  End Else
  Begin
    strSQL := strSQL + '  PM.AUTOINCREM, ';
    strSQL := strSQL + '  "" AS ITE_SEQCOT, ';
  End;

  strSQL := strSQL + '  C.ITE_CODGRU, ';

  strSQL := strSQL + '  C.ITE_CLACRM, ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  C.ITE_CODABF, '
  Else
    strSQL := strSQL + '  I.ITE_CODABF, ';

  strSQL := strSQL + '  I.ITE_CODITE, ';

  strSQL := strSQL + '  E.EMP_CODEMP AS ITE_CODEMP, ';

  strSQL := strSQL + '  C.ITE_APLICA, ';
  strSQL := strSQL + '  C.ITE_DIAFOR, ';

  strSQL := strSQL + '  C.ITE_REFERE, ';

  If Not fEmptyStr(strSeqCot) Then
    strSQL := strSQL + '   C.ITE_CODUNI AS ITE_CODUNI, '
  Else
    strSQL := strSQL + '  PM.PCD_CODUNI AS ITE_CODUNI, ';

  strSQL := strSQL + '  C.ITE_UNICOM, ';
  strSQL := strSQL + '  C.ITE_CODMAR, ';
  strSQL := strSQL + '  C.ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_ESTMIN, ';
  strSQL := strSQL + '  I.ITE_ESTMAX, ';
  strSQL := strSQL + '  I.ITE_PMED_V, ';

  strSQL := strSQL + '  I.ITE_MINDIG, ';
  strSQL := strSQL + '  I.ITE_MAXDIG, ';

  strSQL := strSQL + '  I.ITE_PONPED, ';
  strSQL := strSQL + '  U.UNI_SIGUNI, ';

  strSQL := strSQL + fSQLCamposPrecoCusto(strCodFor);

  strSQL := strSQL + ' I.ITE_ABAMLT, ';

  If fCfgSis('CODFIT', varBoolean) Then
  Begin
    strSQL := strSQL + '  C.ITE_CODFAB AS ITE_CODFAB, ';
  End
  Else
  Begin
    If fCfgSis('TABPRF', varBoolean) Then
      strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, '
    Else
      strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ';
  End;

  If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
  Begin
    strSQL := strSQL + fGetCodSitFornecedorSQL       + ' AS ITE_CODSIT, ';
    strSQL := strSQL + fGetCodSitOrigemFornecedorSQL + ' AS ITE_SITORI, ';
  End Else
  Begin
    strSQL := strSQL + ' "   " AS ITE_CODSIT, ';
    strSQL := strSQL + ' "   " AS ITE_SITORI, ';
  End;

  If fEmptyStr(strSeqCot) Then
  Begin
    strSQL := strSQL + '  PCD_UNITAR, ';
    strSQL := strSQL + '  PCD_DESUNI, ';
    strSQL := strSQL + '  PCD_DESUN2, ';
    strSQL := strSQL + '  PCD_DESUN3, ';
    strSQL := strSQL + '  PCD_DESUN4, ';
    strSQL := strSQL + '  PCD_DESUN5, ';
    strSQL := strSQL + '  PCD_DESUN6, ';
    strSQL := strSQL + '  IFNULL(PM.PCD_ALQCBS, 0) AS PCD_ALQCBS, ';
    strSQL := strSQL + '  IFNULL(PM.PCD_ALQIBS, 0) AS PCD_ALQIBS, ';
    strSQL := strSQL + '  IFNULL(PM.PCD_ALQ_IS, 0) AS PCD_ALQ_IS, ';
  End Else
  Begin
    strSQL := strSQL + '  0 AS PCD_UNITAR, ';
    strSQL := strSQL + '  0 AS PCD_DESUNI, ';
    strSQL := strSQL + '  0 AS PCD_DESUN2, ';
    strSQL := strSQL + '  0 AS PCD_DESUN3, ';
    strSQL := strSQL + '  0 AS PCD_DESUN4, ';
    strSQL := strSQL + '  0 AS PCD_DESUN5, ';
    strSQL := strSQL + '  0 AS PCD_DESUN6, ';
  End;

  strSQL := strSQL + '  I.ITE_PREVE1, ';
  strSQL := strSQL + '  I.ITE_PREVE2, ';
  strSQL := strSQL + '  I.ITE_PREVE3, ';
  strSQL := strSQL + '  I.ITE_PREVE4, ';
  strSQL := strSQL + '  I.ITE_PREVE5, ';
  strSQL := strSQL + '  I.ITE_PREVE6, ';
  strSQL := strSQL + '  I.ITE_PREVE7, ';
  strSQL := strSQL + '  I.ITE_MARBR1, ';
  strSQL := strSQL + '  I.ITE_MARBR2, ';
  strSQL := strSQL + '  I.ITE_MARBR3, ';
  strSQL := strSQL + '  I.ITE_MARBR4, ';
  strSQL := strSQL + '  I.ITE_MARBR5, ';
  strSQL := strSQL + '  I.ITE_MARBR6, ';
  strSQL := strSQL + '  I.ITE_MARBR7, ';

  If fEmptyStr(strSeqCot) Then
  Begin
    strSQL := strSQL + ' PM.PCD_UNITAR * (1 - PCD_DESUNI / 100) ';
    strSQL := strSQL + ' * (1 - PM.PCD_DESUN2 / 100) ';
    strSQL := strSQL + ' * (1 - PM.PCD_DESUN3 / 100) ';
    strSQL := strSQL + ' * (1 - PM.PCD_DESUN4 / 100) ';
    strSQL := strSQL + ' * (1 - PM.PCD_DESUN5 / 100) ';
    strSQL := strSQL + ' * (1 - PM.PCD_DESUN6 / 100)  + IF(IFNULL(PM.PCD_QTDITE, 0) = 0, 0, (IFNULL(PM.PCD_TOTIPI,0) / PM.PCD_QTDITE ) + (IFNULL(PM.PCD_TOTSUB, 0) / PM.PCD_QTDITE))' + fSQLUnitarioImpostosReforma('PM.PCD') + ' AS ITE_UNIIMP, ';
  End
  Else
    strSQL := strSQL + ' 0 AS ITE_UNIIMP, ';

  strSQL := strSQL + '  U.UNI_PESLIT AS ITE_LITROS, ';
  strSQL := strSQL + '  C.ITE_PESOIT, ';
  strSQL := strSQL + '  C.ITE_CODSIM, ';
  strSQL := strSQL + '  C.ITE_MLTSPO, ';
  strSQL := strSQL + '  C.ITE_CODBAR, ';
  strSQL := strSQL + '  M.MAR_DESMAR, ';
  strSQL := strSQL + '  E.EMP_CODEMP, ';
  strSQL := strSQL + '  E.EMP_NOMEMP, ';
  strSQL := strSQL + '  E.EMP_NOMFAN, ';
  strSQL := strSQL + '  I.ITE_CODEMP, ';

  If blnAgrSim Then
  Begin
    strSQL := strSQL + fSQLSaldoItem('I', True, 'C') + ' AS ITE_SALDOS, ';
    strSQL := strSQL +  fSQLSaldosReservadosAgrSim(False, False, FOpcGir, 'I', 'C', 'SP');
  End Else
  Begin
    strSQL := strSQL + '  I.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0) AS ITE_SALDOS, ';
    strSQL := strSQL +  fSQLSaldosReservados(False, False, FOpcGir, 'I', 'C', 'SP');
  End;

  If fEmptyStr(strSeqCot) Then
    strSQL := strSQL + '  IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = I.ITE_CODITE AND BAR_CODFOR = C.ITE_CODFOR ORDER BY BAR_COMPRA DESC  LIMIT 1), C.ITE_EMBALA) AS ITE_EMBALA, '
  Else
    strSQL := strSQL + '  C.ITE_EMBALA, ';

  strSQL := strSQL + TNivelGiroCriticidade.fSQLNiveis(FOpcGir.recNivEst);

  strSQL := strSQL + '  U.UNI_ITEFRA, ';

  strSQL := strSQL + '  PD.PCD_QTDITE, ';

  If blnAnalisaITEFOR Then
     strSQL := strSQL + ' IF(C.ITE_CODFOR = "' + strCodFor +'", "*", "") AS ITE_PRINCI, '
  Else
     strSQL := strSQL + ' " " AS ITE_PRINCI, ';

  If blnSitPro  And blnCorIpd Then
  Begin
    strSQL := strSQL + '  SIT_CODIGO, ';
    strSQL := strSQL + '  SIT_CORSIT, ';
    strSQL := strSQL + '  SIT_DESCRI, ';
  End;

  strSQL := strSQL + '  I.ITE_CICMDE, ';
  strSQL := strSQL + '  I.ITE_CDPIOP, ';
  strSQL := strSQL + '  I.ITE_DIDIOP, ';

  If Not fEmptyStr(strSeqCot) Then
    strSQL := strSQL + '  0 AS PCD_QTDBAI, '
  Else
    strSQL := strSQL + '  PD.PCD_QTDBAI, ';

  strSQL := strSQL + ' I.ITE_CPRCEN, ';
  strSQL := strSQL + ' IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") AS ITE_EMPCEN, ';

  strSQL := strSQL + ' I.ITE_ESMIDG, ';
  strSQL := strSQL + ' I.ITE_LOCFIS, ';
  strSQL := strSQL + ' C.ITE_INCPIS, ';

  If fEmptyStr(strSeqCot) Then
  Begin
    strSQL := strSQL + '  (SELECT IFNULL(GROUP_CONCAT(DISTINCT MOVRCD.AUTOINCREM), "")  ';
    strSQL := strSQL + '          FROM ';
    strSQL := strSQL + '            MOVRCD ';
    strSQL := strSQL + '          WHERE ';
    strSQL := strSQL + '            RCD_SEQPCD = PM.AUTOINCREM AND RCD_EMPDES = PD.PCD_EMPDES) AS ITE_INCIRQ, ';

    strSQL := strSQL + '  (SELECT IFNULL(SUM(RCD_QTDITE), 0.00) ';
    strSQL := strSQL + '          FROM ';
    strSQL := strSQL + '            MOVRCD ';
    strSQL := strSQL + '          WHERE ';
    strSQL := strSQL + '            RCD_SEQPCD = PM.AUTOINCREM AND RCD_EMPDES = PD.PCD_EMPDES) - ';

    strSQL := strSQL + '  (SELECT IFNULL(SUM(BAI_QTDREQ), 0.00) ';
    strSQL := strSQL + '          FROM ';
    strSQL := strSQL + '            BAIREQ  ';
    strSQL := strSQL + '          INNER JOIN MOVRCD M ON M.AUTOINCREM = BAI_AUTREQ ';
    strSQL := strSQL + '          WHERE ';
    strSQL := strSQL + '            BAI_AUTPED = PM.AUTOINCREM AND RCD_EMPDES = PD.PCD_EMPDES) AS ITE_QTDREQ, ';
  End Else
  Begin
    strSQL := strSQL + '  CAST("" AS CHAR(100)) AS ITE_INCIRQ, ';
    strSQL := strSQL + '  0.00                  AS ITE_QTDREQ, ';
  End;

  strSQL := strSQL + '  I.ITE_DTAUVE, ';
  strSQL := strSQL + '  I.ITE_PREUVE, ';
  strSQL := strSQL + '  I.ITE_QTDUVE, ';

  strSQL := strSQL + '  I.ITE_PREULT, ';
  strSQL := strSQL + '  I.ITE_IMPULT, ';
  strSQL := strSQL + '  I.ITE_QTDUCO, ';
  strSQL := strSQL + '  I.ITE_FORULT, ';
  strSQL := strSQL + '  UF.FOR_NOMFOR AS ITE_NOMFOR, ';
  strSQL := strSQL + '  C.ITE_DESSIM,';
  strSQL := strSQL + '  IF(COALESCE(GRU_DRELIN, "") <> "", CONCAT(COALESCE(GRU_DRELIN, ""), " - ", COALESCE(GRU_DESGRU, "")),COALESCE(GRU_DESGRU, "") ) AS ITE_DESGRU, ';
  strSQL := strSQL + '  I.ITE_DTAULT,  ';
  strSQL := strSQL + '  FP.FOR_NOMFOR ITE_FORPRI, ';
  strSQL := strSQL + '  DP.DEP_DESCRI ITE_DEPART, ';

  strSQL := strSQL + '  I.ITE_PONEXP, ';
  If opcChamada <> chaSpoolTransferencia Then
    strSQL := strSQL + '  I.ITE_QTEP_S ';

  If Not fEmptyStr(strSeqCot) Then
  begin
    strSQL := strSQL + '  ,CT.COT_FORESC, ';
    strSQL := strSQL + '    (CF2.COT_VALUNI * CF2.COT_SUBSTI) /100 AS COT_SUBSTI,';
    strSQL := strSQL + '    (CF2.COT_VALUNI * CF2.COT_IPIENT) /100 AS COT_IPIENT,';
    strSQL := strSQL + '    IFNULL(CF2.COT_ALQCBS, 0) AS COT_ALQCBS,';
    strSQL := strSQL + '    IFNULL(CF2.COT_ALQIBS, 0) AS COT_ALQIBS,';
    strSQL := strSQL + '    IFNULL(CF2.COT_ALQ_IS, 0) AS COT_ALQ_IS,';
    strSQL := strSQL + '    CF2.COT_VALUNI  ';
  End;

  strSQL := strSQL + ', I.ITE_TIPABS ';
  strSQL := strSQL + ', I.ITE_VNOLCD ';

  strSQL := strSQL + 'FROM ';

  strSQL := strSQL +   fSQLFromPedidoMultiloja(blnRecupera, strEmpGir);

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL +   fSQLWherePedidoMultiloja(blnRecupera, strEmpGir);

  If FOpcGir.blnRecuperCot Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'COTITE', 'COTITE_RES');
    strSQL := AnsiReplaceStr(strSQL, 'COTFOR', 'COTFOR_RES');
    strSQL := AnsiReplaceStr(strSQL, 'PCDCOT', 'PCDCOT_RES');
  End;

  Result := strSQL;
End;

{******************************************}
{* EXECUTA O SQL NECESSÁRIO PARA O CAR-   *}
{* REGAR UM PEDIDO CASO ESTEJA CONFIGURADO*}
{* PARA USAR MULTI LOJAS.                 *}
{***************************************MV*}
Function TGiroPedido.fExecutaSQLCarregarPedMultiLojas(qryGenGir: TUniQuery; strAnoIni, strAnoFim,
  strCodEmp, strCodGru, strCodFor, strCodMar, strPrdGru, strGruCmp, strSitPro, strUnidade, strCodDep: String; intDiaVen: Integer; strAcoObj, strRefere, strDesIte, strNumPed, strEspPed, strCodCmp: String;
  arrCodFor, arrLinhaGrupo, arrMarca, arrPrdGru, arrGruCmp, arrSitPro, arrUnidade, arrCodDep: TConsultasArray; strEmpGir: String; cdsEmpresasSel: OleVariant): Boolean;
  Var
    strSQL: String;
begin
  Try
    {*******************************************}
    {* COM GIRO DE ESTOQUE OU TODOS            *}
    {****************************************MV*}
    {*****************************************}
    {* PREPARA A QUERY PARA VEERIFICAR DADOS *}
    {* DO GIRO                               *}
    {**************************************MV*}
    With qryGenGir Do
    Begin
      Close;

      If blnAgrSim Then
      Begin
        qryGenGir.SQL.Text := fSQLCriaTempSimilarPedidoMultiloja(strEmpGir);

        If Assigned(qryGenGir.FindParam('SEQCOT')) Then
        Begin
          qryGenGir.ParamByName('SEQCOT').AsString := strSeqCot;
        End

        Else If Assigned(qryGenGir.FindParam('NUMPED')) Then
        Begin
          qryGenGir.ParamByName('NUMPED').AsString := strNumPed;
          qryGenGir.ParamByName('ESPPED').AsString := strEspPed;
          qryGenGir.ParamByName('CODEMP').AsString := strEmpPed;
        End;

        qryGenGir.Execute;
        qryGenGir.Close;
      End;

      SQL.Clear;
      strSQL := '';

      If (Not fEmptyStr(strNumPed)) Or (Not fEmptyStr(strSeqCot)) Then
        strSQL := fSQLPedidoMultiloja(False, strEmpGir);

      If Assigned(objRecupera) And objRecupera.recPcmger.blnRecuperaPedido Then
      Begin
        If Not fEmptyStr(strSQL) Then
          strSQL := strSQL + ' UNION ';

        strSQL := strSQL + fSQLPedidoMultiloja(True, strEmpGir);
      End;

      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '	GIR_CODITE ASC, GIR_CODEMP ASC, GIR_A_N_O_ DESC ';

      SQL.Add(strSQL);

      If Not fEmptyStr(strSeqCot) Then
      Begin
        ParamByName('SEQCOT').AsString := strSeqCot;
      End Else
      Begin

        If Not fEmptyStr(strNumPed) Then
        Begin
          ParamByName('CODEMP').AsString := strEmpPed;
          ParamByName('NUMPED').AsString := strNumPed;
          ParamByName('ESPPED').AsString := strEspPed;
        End;

      End;

      pSetaNomeFuncao(fugExecutaSQLCarregarPedMultiLojas);
      Open;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGiroPedido.fExecutaSQLCarregarPedMultiLojas]');
    End;
  End;
end;

function fCalculaSugestaoAgregada(strEmpAgr: String; blnSugInd: Boolean): Boolean;
begin
  Result := (Not fConsidera_EmpAgr_Vazio(strEmpAgr)) And (Not blnSugInd);
end;

Procedure TGiroPedido.pAjustaCompraCentraLizada(fltSomaCprCen, fltSomaCprCenCal, fltSomaCprTot, fltExtExc: Double;
                                                cdsItensMultiLojas, cdsItensPed: TUniClientDataSet; intDecUni: Integer;
                                                blnSetarSug: Boolean = True);
  Var
    fltTotIte,
    fltBasIpi,
    fltTotIpi,
    fltBasSub,
    fltTotSub,
    fltSugMult: Double;
    blnSalvar: Boolean;


Begin
  cdsItensMultiLojas.Edit;
  


  If FOpcGir.blnMultiploNaEmpresaCentralizadora And (Not fCalculaSugestaoAgregada(strEmpAgr, blnSugInd))  Then
  Begin
    fltSugMult :=  (round(fltSomaCprCen / cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat)) * cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat;

    If fltSugMult < fltSomaCprCen Then
      fltSomaCprCen := (round(fltSomaCprCen / cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat) + 1) * cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat
    Else
      fltSomaCprCen := fltSugMult;
  End;


  cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := IIf(fltSomaCprCen < 0, 0, fltSomaCprCen - fltExtExc) ;
  If cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat < 0 Then
    cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := 0;

  If (fPedidoMultiLojaPorNivelAgregadaPorEmpresaComCalculoGlobal_E_NivelGiroPorEmpresa(strPedMlj, strEmpAgr, recNivEst , blnSugInd))     Then
  Begin
    If blnConsMCom Then
    Begin
      fltSugMult :=  (round(cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat / cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat)) * cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat;

      If fltSugMult < cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat Then
        fltSomaCprCen := (round(cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat / cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat) + 1) * cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat
      Else
        fltSomaCprCen := fltSugMult;
      cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := fltSomaCprCen;
    End;
  End;

  cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat := fltSomaCprCenCal;
  cdsItensMultiLojas.FieldByName('ITE_SUGESTORI').AsFloat := fltSomaCprCenCal;

  If blnSetarSug And fCalculaSugestaoAgregada(strEmpAgr, blnSugInd) Then
    cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := fltSomaCprCen;

  cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat :=
    RoundTo(cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat *
             ((1 - cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN2').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN3').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN4').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN5').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN6').AsFloat / 100)), -intDecUni) *
    cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;

  cdsItensMultiLojas.FieldByName('ITE_UNILIQ').AsFloat :=
    RoundTo(cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat *
             ((1 - cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN2').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN3').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN4').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN5').AsFloat / 100) *
              (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN6').AsFloat / 100)), -intDecUni);

  cdsItensMultiLojas.FieldByName('ITE_DIFPRE').AsFloat  := Iif(cdsItensMultiLojas.FieldByName('ITE_PREULT').AsFloat = 0, 0, (((cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat - cdsItensMultiLojas.FieldByName('ITE_PREULT').AsFloat) / cdsItensMultiLojas.FieldByName('ITE_PREULT').AsFloat) * 100));

  If (Not cdsItensPed.IsEmpty) And
     (cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString = cdsItensPed.FieldByName('ITE_CODITE').AsString) Then
  Begin
    cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat := cdsItensPed.FieldByName('ITE_PERIPI').AsFloat;
    cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat := cdsItensPed.FieldByName('ITE_PERSUB').AsFloat;
    cdsItensMultiLojas.FieldByName('ITE_ALQCBS').AsFloat := cdsItensPed.FieldByName('ITE_ALQCBS').AsFloat;
    cdsItensMultiLojas.FieldByName('ITE_ALQIBS').AsFloat := cdsItensPed.FieldByName('ITE_ALQIBS').AsFloat;
    cdsItensMultiLojas.FieldByName('ITE_ALQ_IS').AsFloat := cdsItensPed.FieldByName('ITE_ALQ_IS').AsFloat;
  End;

  cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat;

  cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat := cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat *
                                                          cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat / 100;

  pCalculaImpostosReformaItem(cdsItensMultiLojas, False);

  If strFRMPCM  = '1' Then
    cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat := (cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat  +
                                                             cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat) *
                                                            cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat / 100
  Else
    cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat *
                                                            cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat / 100;

  If cdsItensMultiLojas.FieldByName('ITE_QTDEMB').IsNull Or (cdsItensMultiLojas.FieldByName('ITE_QTDEMB').AsFloat = 0) Then
    cdsItensMultiLojas.FieldByName('ITE_QTDEMB').AsFloat := 1;

  If cdsItensMultLojas.FieldByName('ITE_QTDTRA').IsNull Then
    cdsItensMultLojas.FieldByName('ITE_QTDTRA').AsFloat := 0;

  pCalculaVariacaoCompra(cdsItensMultLojas);

  cdsItensMultiLojas.Post;

  If (((strEmpAgr = 'Cen') And (Not blnSugInd)) Or
    (TNivelDeGiroComAgrupamento.blnNivelDeGiroComAgrupamento)) And
     (cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString = cdsItensPed.FieldByName('ITE_CODITE').AsString) Then
  Begin
    blnSalvar := False;
    If Not (cdsItensPed.State In dsEditModes) Then
    Begin
      cdsItensPed.Edit;
      blnSalvar := True;
    End;

    intDecUni := fCfgSis('DECUNI');

    If not TNivelDeGiroComAgrupamento.blnNivelDeGiroComAgrupamento Then
      cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := fltSomaCprTot ;

    fltTotIte :=  cdsItensPed.FieldByName('ITE_QTDITE').AsFloat * RoundTo(cdsItensPed.FieldByName('ITE_UNITAR').AsFloat * (1 - cdsItensPed.FieldByName('ITE_DESUNI').AsFloat / 100), -intDecUni);

    fltBasIpi := fltTotIte;
    fltTotIpi := fltTotIte * cdsItensPed.FieldByName('ITE_PERIPI').AsFloat / 100;

    fltBasSub := fltTotIte;
    fltTotSub := fltTotIte * cdsItensPed.FieldByName('ITE_PERSUB').AsFloat / 100;


    If cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat > 0 Then
      cdsItensPed.FieldByName('ITE_SUGEST').AsFloat := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;

    cdsItensPed.FieldByName('ITE_TOTITE').AsFloat := fltTotIte;
    cdsItensPed.FieldByName('ITE_BASIPI').AsFloat := fltBasIpi;
    cdsItensPed.FieldByName('ITE_TOTIPI').AsFloat := fltTotIpi;
    cdsItensPed.FieldByName('ITE_BASSUB').AsFloat := fltBasSub;
    cdsItensPed.FieldByName('ITE_TOTSUB').AsFloat := fltTotSub;

    pCalculaImpostosReformaItem(cdsItensPed, False);

    If cdsItensPed.FieldByName('ITE_QTDITE').AsFloat = 0 Then
      cdsItensPed.FieldByName('ITE_SUGEST').AsFloat := 0;

    If blnSalvar Then
      cdsItensPed.Post;
  End;



  If (Not cdsItensPed.IsEmpty) And (
     ((FOpcGir.blnMultiploNaEmpresaCentralizadora And (Not fCalculaSugestaoAgregada(strEmpAgr, blnSugInd))) Or
     (TNivelDeGiroComAgrupamento.blnNivelDeGiroComAgrupamento)) And
     (cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString = cdsItensPed.FieldByName('ITE_CODITE').AsString)) Then
  Begin
    If Not (cdsItensPed.State In dsEditModes) Then
    Begin
      cdsItensPed.Edit;
      blnSalvar := True;
    End

    Else blnSalvar := False;

    cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;
    cdsItensPed.FieldByName('ITE_SUGEST').AsFloat := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;
    cdsItensPed.FieldByName('ITE_TOTITE').AsFloat := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat;
    cdsItensPed.FieldByName('ITE_BASIPI').AsFloat := cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat;
    cdsItensPed.FieldByName('ITE_TOTIPI').AsFloat := cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat;
    cdsItensPed.FieldByName('ITE_TOTSUB').AsFloat := cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat;
    pCalculaImpostosReformaItem(cdsItensPed, False);

    If blnSalvar Then
      cdsItensPed.Post;
  End;
End;

{*****************************************}
{* GERA UM NOVO CLIENT DATASET COM OS    *}
{* DADOS DO MULTI LOJAS SINTETIZADOS.    *}
{**************************************MV*}
Function TGiroPedido.fSintetizaItensMultiLojas(strCodFor: String; cdsItensPed, cdsItensMultiLojas: TUniClientDataSet;
  intQtdMes, intMesMos: Integer;
  blnAnalisaITEFOR, blnAllIte, blnConsMCom, blnArredSug, blnConsRequisicao, blnConsPedPen, blnConsPedVen, blnDescSalExt, blnConsEMin, blnConsEMax,
  blnConsTLoj, blnConsOrdPro, blnConsGarPen, blnConsTransf, blnConsCot: Boolean;
  stlItensGiro: TStringList;
  strPedMlj, strEmpAgr: String;  blnSugInd: Boolean;
  cdsEmpresasSel: OleVariant;
  qryGenGir: TUniQuery;
  dtaDataBase: TDate;
  arrCodFor,
  arrLinhaGrupo,
  arrMarca,
  arrPrdGru,
  arrGruCmp,
  arrSitPro,
  arrUnidade,
  arrCodDep : TConsultasArray;
  strCodGru,
  strCodMar,
  strPrdGru,
  strGruCmp,
  strSitPro,
  strUnidade,
  strCodDep: String;
  intDiaVen: Integer;
  strAcoObj,
  strRefere,
  strDesIte: String): Boolean;
  Var
    blnAbaixoPonPed: Boolean;

    cdsEmpCen: TZClient;

    intMesGir,
    intAnoGir: Integer;

    fltQtdPen,
    fltQtdReq,
    fltSalGar,
    fltSalExt,
    fltQtdCal,
    fltLimVer,
    fltLimAma: Double;

    intDecUni: Integer;
    strItemAtu: String;
    strCont,
    strLinGru,
    strDesMar: String;
    strDesPrdGru : String;
    strDesGruCmp : String;
    strDesSitPro : String;
    strDesUnidade: String;
    strDesCodDep : String;

    fltPerConTmp,
    fltMaiSai: Double;
    intContador,
    intContadorMes: Integer;

    qryCadEmp: TUniQuery;
    lstEmpresas: TStringList;
    lstNomEmpresas: TStringList;
    lstNomFanEmp: TStringList;
    strEmpUsadas: String;

    bkmRegAtual: TBookmark;
    fltPosRegAtual: Double;
    intIdxEmp: Integer;

    cdsTmpMlj: TUniClientDataSet;
    strLitGal: String;

    qryIteger: TUniQuery;
    dspIteger: TUniDataSetProvider;
    cdsIteger: TUniClientDataSet;

    fltQtdCalcTotCenCon: Double;

    fltSugMult: Double;

    fltSomaIte,
    fltSomaIteCal: Double;

    fltEntFal,
    fltEntAgu,
    fltEntPre,

    fltSalTra,
    fltSalRes,
    fltSalEnd: Double;

    fltSomaCprCen,
    fltExtExc,
    fltSomaCprCenCal: Double;

    blnCprCen : Boolean;

    strEmpCal,
    strEmpSel: String;
    cdsEmpSel: TUniClientDataSet;

    intDiasCompraAgreg: Integer;
    fltPerConAgreg: Double;

    strCodIteFinalizou,
    strCodIteAcumulou: String;

    fltSaldosSug: Double;

    procedure pSalvaDadosComuns(cdsDestino, cdsOrigem: TUniClientDataSet;
      strCodEmp: String = ''; strNomEmp: String = ''; strNomFan: String = '');
      Var
        intContador: Integer;
    begin

      If Not fEmptyStr(strCodEmp) Then
      Begin
        For intContador := 0 To cdsDestino.FieldCount -1 Do
        Begin
          If (cdsDestino.Fields[intContador].DataType = ftFloat) Then
            cdsDestino.Fields[intContador].AsFloat := 0.0;
        End;
      End;

      cdsDestino.FieldByName('ITE_INCIRQ').AsString := cdsOrigem.FieldByName('ITE_INCIRQ').AsString;
      cdsDestino.FieldByName('ITE_QTDREQ').Value    := cdsOrigem.FieldByName('ITE_QTDREQ').Value;
      cdsDestino.FieldByName('ITE_QATREQ').Value    := cdsOrigem.FieldByName('ITE_QTDREQ').Value;

      cdsDestino.FieldByName('ITE_CODITE').AsString := cdsOrigem.FieldByName('ITE_CODITE').AsString;
      cdsDestino.FieldByName('ITE_CODTAB').AsString := cdsOrigem.FieldByName('ITE_CODTAB').AsString;
      cdsDestino.FieldByName('ITE_CODGRU').AsString := cdsOrigem.FieldByName('ITE_CODGRU').AsString;
      cdsDestino.FieldByName('ITE_CLACRM').AsString := cdsOrigem.FieldByName('ITE_CLACRM').AsString;

      cdsDestino.FieldByName('ITE_CODABF').AsString := cdsOrigem.FieldByName('ITE_CODABF').AsString;
      cdsDestino.FieldByName('ITE_EMBALA').AsFloat  := cdsOrigem.FieldByName('ITE_EMBALA').AsFloat;

      If fEmptyStr(strCodEmp) Then
      Begin
        cdsDestino.FieldByName('ITE_CODEMP').AsString := cdsOrigem.FieldByName('ITE_CODEMP').AsString;
        cdsDestino.FieldByName('ITE_DESEMP').AsString := cdsOrigem.FieldByName('ITE_DESEMP').AsString;
        cdsDestino.FieldByName('ITE_FANEMP').AsString := cdsOrigem.FieldByName('ITE_FANEMP').AsString;
      End
      Else
      Begin
        cdsDestino.FieldByName('ITE_CODEMP').AsString := strCodEmp;
        cdsDestino.FieldByName('ITE_DESEMP').AsString := strNomEmp;
        cdsDestino.FieldByName('ITE_FANEMP').AsString := strNomFan;
      End;
      cdsDestino.FieldByName('ITE_DESITE').AsString := cdsOrigem.FieldByName('ITE_DESITE').AsString;
      cdsDestino.FieldByName('ITE_PESORI').AsFloat  := cdsOrigem.FieldByName('ITE_PESORI').AsFloat;
      cdsDestino.FieldByName('ITE_APLICA').AsString := cdsOrigem.FieldByName('ITE_APLICA').AsString;
      cdsDestino.FieldByName('ITE_DIAFOR').AsInteger := cdsOrigem.FieldByName('ITE_DIAFOR').AsInteger;
      cdsDestino.FieldByName('ITE_ESMIDG').AsString := cdsOrigem.FieldByName('ITE_ESMIDG').AsString;
      cdsDestino.FieldByName('ITE_LOCFIS').AsString := cdsOrigem.FieldByName('ITE_LOCFIS').AsString;
      cdsDestino.FieldByName('ITE_INCPIS').AsString := cdsOrigem.FieldByName('ITE_INCPIS').AsString;
      cdsDestino.FieldByName('ITE_REFERE').AsString := cdsOrigem.FieldByName('ITE_REFERE').AsString;
      cdsDestino.FieldByName('ITE_CLAIPI').AsString := cdsOrigem.FieldByName('ITE_CLAIPI').AsString;
      cdsDestino.FieldByName('ITE_PRAVAL').AsString := cdsOrigem.FieldByName('ITE_PRAVAL').AsString;
      cdsDestino.FieldByName('ITE_CODSIT').AsString := cdsOrigem.FieldByName('ITE_CODSIT').AsString;
      cdsDestino.FieldByName('ITE_SITORI').AsString := cdsOrigem.FieldByName('ITE_SITORI').AsString;
      cdsDestino.FieldByName('ITE_CODUNI').AsString := cdsOrigem.FieldByName('ITE_CODUNI').AsString;
      cdsDestino.FieldByName('ITE_UNICOM').AsString := cdsOrigem.FieldByName('ITE_UNICOM').AsString;
      cdsDestino.FieldByName('ITE_SIGUNI').AsString := cdsOrigem.FieldByName('ITE_SIGUNI').AsString;
      cdsDestino.FieldByName('ITE_CODMAR').AsString := cdsOrigem.FieldByName('ITE_CODMAR').AsString;
      cdsDestino.FieldByName('ITE_DESMAR').AsString := cdsOrigem.FieldByName('ITE_DESMAR').AsString;
      cdsDestino.FieldByName('ITE_CODFOR').AsString := cdsOrigem.FieldByName('ITE_CODFOR').AsString;
      cdsDestino.FieldByName('ITE_ITEESP').AsString := cdsOrigem.FieldByName('ITE_ITEESP').AsString;

      cdsItensPed.FieldByName('GIRSINT').AsString   := cdsOrigem.FieldByName('GIRSINT').AsString;
      cdsItensPed.FieldByName('CRISINT').AsString   := cdsOrigem.FieldByName('CRISINT').AsString;
      cdsDestino.FieldByName('ITE_NVLGIR').AsString := cdsOrigem.FieldByName('ITE_NVLGIR').AsString;
      cdsDestino.FieldByName('ITE_NVLCRI').AsString := cdsOrigem.FieldByName('ITE_NVLCRI').AsString;

      cdsDestino.FieldByName('ITE_ITEFRA').AsString := cdsOrigem.FieldByName('ITE_ITEFRA').AsString;
      cdsDestino.FieldByName('ITE_FORPRI').AsString := cdsOrigem.FieldByName('ITE_FORPRI').AsString;
      cdsDestino.FieldByName('ITE_DEPART').AsString := cdsOrigem.FieldByName('ITE_DEPART').AsString;
    end;

    procedure pCalculaSaldoParaEmpresaDoAgrupamento(strCodEmp: String);
    begin
      {********************************************************}
      {* CASO SEJA AGRUPAMENTO EM UMA EMPRESA E TENHA OPTADO  *}
      {* POR CALCULAR DE FORMA GLOBAL A SUGESTAO              *}
      {********************************************************}
      With cdsItensPed Do
      Begin
        If (Pos(strCodEmp, strEmpCal) > 0) And
         fCalculaSugestaoAgregada(strEmpAgr, blnSugInd) Then
        Begin
          if fPedidoMultiLojaPorNivelAgregadaPorEmpresaComCalculoGlobal_E_NivelGiroPorEmpresa(strPedMlj, strEmpAgr, recNivEst, blnSugInd) Then
          Begin
            TNivelDeGiroComAgrupamento.blnNivelDeGiroComAgrupamento := True;
            recNivEst.strIteGir := cdsTmpMlj.FieldByName('ITE_NVLGIR').AsString;
            recNivEst.strIteCri := cdsTmpMlj.FieldByName('ITE_NVLCRI').AsString;

            intDiasCompraAgreg := fDiasCompra(recNivEst);
            fltPerConAgreg     := fPercElevacaoConsumiveis(recNivEst);
            fltSomaCprCen    :=  FieldByName('ITE_SUGEST').AsFloat;

            cdsItensPed.FieldByName('ITE_SUGEST').AsFloat :=  fltSomaCprCen;
                                                             {*fCalculaSugestaoCompra(False,
                                                                        intQtdMes,
                                                                        intDiasCompraAgreg,
                                                                        IfThen(blnMedAju, FieldByName('ITE_AJUSTA').AsFloat,
                                                                                          cdsTmpMlj.FieldByName('ITE_MEDIA_').AsFloat) * intQtdMes,
                                                                        cdsTmpMlj.FieldByName('ITE_SALREQ').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_QTDPEN').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_SALRES').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_QTPD_P').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_INIBAS').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_ESTMIN').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_ESTMAX').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_MLTCOM').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_SALGAR').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_SALTRA').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_SALCOT').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_VENPER').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_SALEXT').AsFloat,
                                                                        fltPerConAgreg,
                                                                        cdsTmpMlj.FieldByName('ITE_PONPED').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_QTEF_A').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_QTEF_F').AsFloat,
                                                                        cdsTmpMlj.FieldByName('ITE_QTEF_P').AsFloat,
                                                                        blnConsRequisicao,
                                                                        blnConsPedPen,
                                                                        blnConsPedVen,
                                                                        blnDescSalExt,
                                                                        blnConsEMin,
                                                                        blnConsEMax,
                                                                        blnConsMCom,
                                                                        blnArredSug,
                                                                        blnConsOrdPro,
                                                                        blnConsGarPen,
                                                                        blnConsTransf,
                                                                        blnConsCot,
                                                                        blnVenPer,
                                                                        blnVenPerMed,
                                                                        blnConsEndere,
                                                                        blnPonPed,
                                                                        blnAteMax,
                                                                        blnEntFutPrevisao,
                                                                        blnEntFutFalta,
                                                                        blnEntFutAguarda,
                                                                        cdsTmpMlj.FieldByName('ITE_CLACRM').AsString,
                                                                        blnAbaixoPonPed,
                                                                        fltQtdCal) + (fltSomaCprCen);
                                                                    *}

            fltExtExc        := fltExtExc + cdsTmpMlj.FieldByName('ITE_ESTEXC').AsFloat;
            If FieldByName('ITE_SUGEST').AsFloat < 0 Then
              FieldByName('ITE_SUGEST').AsFloat := 0;
          End
          Else
          Begin
            recNivEst.strIteGir := FieldByName('GIRSINT').AsString;
            recNivEst.strIteCri := FieldByName('CRISINT').AsString;

            intDiasCompraAgreg := fDiasCompra(recNivEst);
            fltPerConAgreg     := fPercElevacaoConsumiveis(recNivEst);

            FieldByName('ITE_SUGEST').AsFloat := fCalculaSugestaoCompra(intQtdMes,
                                                                        intDiasCompraAgreg,
                                                                        IfThen(blnMedAju, FieldByName('ITE_AJUSTA').AsFloat,
                                                                                          FieldByName('ITE_MEDIA_').AsFloat) * intQtdMes,
                                                                        FieldByName('ITE_SALREQ').AsFloat,
                                                                        FieldByName('ITE_QTDPEN').AsFloat,
                                                                        FieldByName('ITE_SALRES').AsFloat,
                                                                        FieldByName('ITE_QTPD_P').AsFloat,
                                                                        FieldByName('ITE_INIBAS').AsFloat,
                                                                        FieldByName('ITE_ESTMIN').AsFloat,
                                                                        FieldByName('ITE_ESTMAX').AsFloat,
                                                                        FieldByName('ITE_MLTCOM').AsFloat,
                                                                        FieldByName('ITE_SALGAR').AsFloat,
                                                                        FieldByName('ITE_SALTRA').AsFloat,
                                                                        FieldByName('ITE_SALCOT').AsFloat,
                                                                        FieldByName('ITE_VENPER').AsFloat,
                                                                        FieldByName('ITE_SALEXT').AsFloat,
                                                                        fltPerConAgreg,
                                                                        FieldByName('ITE_PONPED').AsFloat,
                                                                        FieldByName('ITE_QTEF_A').AsFloat,
                                                                        FieldByName('ITE_QTEF_F').AsFloat,
                                                                        FieldByName('ITE_QTEF_P').AsFloat,
                                                                        blnConsRequisicao,
                                                                        blnConsPedPen,
                                                                        blnConsPedVen,
                                                                        blnDescSalExt,
                                                                        blnConsEMin,
                                                                        blnConsEMax,
                                                                        blnConsMCom,
                                                                        blnArredSug,
                                                                        blnConsOrdPro,
                                                                        blnConsGarPen,
                                                                        blnConsTransf,
                                                                        blnConsCot,
                                                                        blnVenPer,
                                                                        blnVenPerMed,
                                                                        blnConsEndere,
                                                                        blnPonPed,
                                                                        blnAteMax,
                                                                        blnEntFutPrevisao,
                                                                        blnEntFutFalta,
                                                                        blnEntFutAguarda,
                                                                        FieldByName('ITE_CLACRM').AsString,
                                                                        blnAbaixoPonPed,
                                                                        fltQtdCal);
            fltSomaCprCen    := FieldByName('ITE_SUGEST').AsFloat;
            fltSomaCprCenCal := FieldByName('ITE_QTDCAL').AsFloat;
          End;

          FieldByName('ITE_QTDITE').AsFloat := FieldByName('ITE_SUGEST').AsFloat;
          FieldByName('ITE_QTDINC').AsFloat := FieldByName('ITE_QTDITE').AsFloat;

          FieldByName('ITE_QTDCAL').AsFloat := fltQtdCal;
          FieldByName('ITE_SUGESTORI').AsFloat := fltQtdCal;

          fltSomaIte       := FieldByName('ITE_SUGEST').AsFloat;
          fltSomaIteCal    := FieldByName('ITE_QTDCAL').AsFloat;
        End;
      End;
    end;

    procedure pZeraQuantidadeDoItemAtualCasoNecessario;
    begin
      If ((cdsTmpMlj.FieldByName('ITE_CPRCEN').AsString = 'S') And
          (cdsTmpMlj.FieldByName('ITE_CODEMP').AsString <> cdsTmpMlj.FieldByName('ITE_EMPCEN').AsString)) Or

         ((Not fConsidera_EmpAgr_Vazio(strEmpAgr)) And
          (cdsTmpMlj.FieldByName('ITE_CODEMP').AsString <> strEmpAgr)) Then
      Begin
        blnCprCen := True;

        If (cdsItensMultiLojas.FindKey([strItemAtu, cdsTmpMlj.FieldByName('ITE_CODEMP').AsString])) Then
        Begin
          cdsItensMultiLojas.Edit;
          cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_SUGESTORI').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_ALQCBS').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_ALQIBS').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_ALQ_IS').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_VALCBS').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_VALIBS').AsFloat := 0;
          cdsItensMultiLojas.FieldByName('ITE_VAL_IS').AsFloat := 0;
          cdsItensMultiLojas.Post;
        End;
      End;
    end;

    function fInd(intInd: Integer): String;
    begin
      Result := fStrZero(intInd, 2);
    end;

    Procedure pLiberaComps;
    Begin
      FreeAndNil(lstEmpresas);
      FreeAndNil(lstNomEmpresas);
      FreeAndNil(lstNomFanEmp);
      FreeAndNil(dspIteger);
      FreeAndNil(cdsIteger);
      FreeAndNil(qryIteger);
      FreeAndNil(cdsTmpMlj);
      FreeAndNil(cdsEmpSel);
      FreeAndNil(cdsEmpCen);
    End;

    Procedure pApagaItemSemSugestao;
    Begin
      cdsItensPed.Delete;
    End;

    Procedure pAdicionaCprCen(strCodIte, strEmpCen: String; fltQtdAcu, fltAcuCal, fltSaldis, fltGirEst: Double);
    Begin

      If fEmptyStr(strCodIteAcumulou) Or (strCodIte = strCodIteAcumulou) Then
      Begin
        blnCprCen         := True;

        strCodIteAcumulou := strCodIte;

        With cdsEmpCen Do
        If FindKey([strEmpCen]) Then
        Begin
          Edit;
          FieldByName('QTDACU').AsFloat := FieldByName('QTDACU').AsFloat + fltQtdAcu;
          FieldByName('ACUCAL').AsFloat := FieldByName('ACUCAL').AsFloat + fltAcuCal;
          FieldByName('SALDIS').AsFloat := FieldByName('SALDIS').AsFloat + fltSaldis;
          FieldByName('GIREST').AsFloat := FieldByName('GIREST').AsFloat + fltGirEst;
          Post;
        End;

      End Else
      Begin
        // NÃO DEVERIA ENTRAR AQUI
      End;

    End;

    Procedure pFinalizaCompraCentraliza(strCodIte: String);
      Var
        fltQtdAcu,
        fltQtdDis,
        fltQtdGir,
        fltQtdCal: Double;
        fltCalc: Double;

        strCodEmp: String;
    Begin

      If (strCodIte = strCodIteFinalizou) Then
      Begin

        strCodIteFinalizou := strCodIte;

      End Else If (strCodIte = strCodIteAcumulou) Then
      Begin
        strCodIteFinalizou := strCodIte;
        fltQtdCalcTotCenCon := 0;
        cdsEmpCen.IndexFieldNames := 'CODEMP';
        cdsEmpCen.First;

        fltQtdAcu := 0;
        fltQtdCal := 0;

        fltQtdDis := 0;
        fltQtdGir := 0;

        fltQtdCalcTotCenCon := 0;

        cdsEmpCen.First;
        While Not cdsEmpCen.Eof Do
        Begin
          strCodEmp := cdsEmpCen.FieldByName('CODEMP').AsString;
          fltQtdAcu := fltQtdAcu + cdsEmpCen.FieldByName('QTDACU').AsFloat;
          fltQtdCal := fltQtdCal + cdsEmpCen.FieldByName('ACUCAL').AsFloat;
          fltQtdDis := fltQtdDis + cdsEmpCen.FieldByName('SALDIS').AsFloat;
          fltQtdGir := fltQtdGir + cdsEmpCen.FieldByName('GIREST').AsFloat;

          cdsEmpCen.Edit;
          cdsEmpCen.FieldByName('QTDACU').AsFloat := 0;
          cdsEmpCen.Post;

          cdsEmpCen.Next;

          If (strCodEmp <> cdsEmpCen.FieldByName('CODEMP').AsString) Or (cdsEmpCen.Eof)  Then
          Begin

            If (fltQtdAcu > 0) And (cdsItensMultiLojas.FindKey([strCodIte, strCodEmp])) Then
            Begin
                If (strEmpAgr = 'Cen') And (Not blnSugInd) Then
                Begin
                  fltQtdDis := fltQtdDis + cdsItensMultiLojas.FieldByName('ITE_SALDIS').AsFloat;
                  fltQtdGir := fltQtdGir + IIf(blnMedAju, cdsItensMultiLojas.FieldByName('ITE_AJUSTA').AsFloat * (fDiasCompra(recNivEst) / 30),
                                                          cdsItensMultiLojas.FieldByName('ITE_MEDIA_').AsFloat * (fDiasCompra(recNivEst) / 30));


                  fltCalc :=  fltQtdGir - fltQtdDis;
                  If fltCalc < 0 Then
                    fltCalc := 0;

                  fltQtdCalcTotCenCon := fltQtdCalcTotCenCon + fltCalc;

                  pAjustaCompraCentraLizada(fltCalc,
                                            fltCalc,
                                            fltQtdCalcTotCenCon,
                                            fltExtExc,
                                            cdsItensMultiLojas, cdsItensPed, intDecUni);

                End
                Else
                  pAjustaCompraCentraLizada(cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat + fltQtdAcu,
                                            cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat + fltQtdCal,
                                            0,
                                            fltExtExc,
                                            cdsItensMultiLojas, cdsItensPed, intDecUni);
            End
            Else
            If (strEmpAgr = 'Cen') And (Not blnSugInd) And (cdsItensMultiLojas.FindKey([strCodIte, cdsEmpCen.FieldByName('CODEMP').AsString])) Then
            Begin
              If (cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat > 0) And
                 (cdsItensMultiLojas.FieldByName('ITE_CPRCEN').AsString = 'N') And
                 (cdsEmpCen.FieldByName('QTDACU').AsFloat = 0) Then
              Begin
                fltQtdCalcTotCenCon := fltQtdCalcTotCenCon + cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;
                pAjustaCompraCentraLizada(cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat + fltQtdAcu,
                                          cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat + fltQtdCal,
                                          fltQtdCalcTotCenCon,
                                          fltExtExc,
                                          cdsItensMultiLojas, cdsItensPed, intDecUni);
              End;
            End;


            fltQtdAcu := 0;
            fltQtdCal := 0;
            fltQtdDis := 0;
            fltQtdGir := 0;

            strCodEmp := cdsEmpCen.FieldByName('CODEMP').AsString;
          End;
        End; {While Not cdsEmpCen.Eof Do}
        If not ((strEmpAgr = 'Cen') And (Not blnSugInd)) Then
          If (fltQtdAcu > 0) And (cdsItensMultiLojas.FindKey([strCodIte, cdsEmpCen.FieldByName('CODEMP').AsString])) Then
            pAjustaCompraCentraLizada(cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat + fltQtdAcu,
                                      cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat + fltQtdCal,
                                      0,
                                      fltExtExc,
                                      cdsItensMultiLojas, cdsItensPed, intDecUni);

        strCodIteAcumulou := '';
        If ((strEmpAgr = 'Cen') And (Not blnSugInd)) Then
        Begin
          cdsEmpCen.First;
          While Not cdsEmpCen.Eof Do
          Begin
            cdsEmpCen.Edit;
            cdsEmpCen.FieldByName('QTDACU').AsFloat := 0;
            cdsEmpCen.FieldByName('ACUCAL').AsFloat := 0;
            cdsEmpCen.FieldByName('SALDIS').AsFloat := 0;
            cdsEmpCen.FieldByName('GIREST').AsFloat := 0;
            cdsEmpCen.Post;
            cdsEmpCen.Next;
          End;
        End;
      End;

    End;

    Function fSQLEmpCen: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   EMP_CODEMP AS CODEMP, ';
      strSQL := strSQL + '   0.0000     AS QTDACU, ';
      strSQL := strSQL + '   0.0000     AS SALDIS, ';
      strSQL := strSQL + '   0.0000     AS GIREST, ';
      strSQL := strSQL + '   0.0000     AS ACUCAL ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CADEMP ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EMP_CODEMP IN (' + strEmpSel + ') ';

      Result := strSQL;
    End;

begin
  TNivelDeGiroComAgrupamento.blnNivelDeGiroComAgrupamento := False;

  Result := True;

  strCodIteFinalizou := '';
  strCodIteAcumulou  := '';

  cdsEmpSel := TUniClientDataSet.Create(Nil);
  intDecUni := fCfgSis('DECUNI');
  fltLimVer := fCfgSis('LIMVER', varDouble);
  fltLimAma := fCfgSis('LIMAMA', varDouble);
  strLitGal := fCfgSis('LITGAL');

  If cdsEmpresasSel <> Null Then
  Begin
    cdsEmpSel.Data := cdsEmpresasSel;

    If blnEmpVis Then
    Begin
      strEmpSel := fRetEmpresasSel(cdsEmpSel, 'EMPVIS');
      strEmpCal := fRetEmpresasSel(cdsEmpSel, 'MARDES');

      strEmpOriSpool := fRetEmpresasSel(cdsEmpSel, 'EMPVIS', False);
      strEmpDesSpool := fRetEmpresasSel(cdsEmpSel, 'MARDES', False);

      If fEmptyStr(strEmpSel) Then
        strEmpSel := strEmpCal;
    End Else
    Begin
      strEmpSel := fRetEmpresasSel(cdsEmpSel, 'MARDES');
      strEmpCal := fRetEmpresasSel(cdsEmpSel, 'MARDES');

      strEmpOriSpool := '';
      strEmpDesSpool := '';
    End;

  End Else
  Begin
    strEmpSel := QuotedStr(strEmpPed);
    strEmpCal := QuotedStr(strEmpPed);
  End;

  FstrEmpSel := strEmpSel;

  cdsEmpCen := TZClient.Create(Nil, fSQLEmpCen);
  cdsEmpCen.fAbreClient(True, 'TGiroPedido.fSintetizaItensMultiLojas');
  cdsEmpCen.IndexFieldNames := 'CODEMP';

  lstEmpresas := TStringList.Create;
  lstNomEmpresas := TStringList.Create;
  lstNomFanEmp := TStringList.Create;

  dspIteger := TUniDataSetProvider.Create(Nil);
  cdsIteger := TUniClientDataSet.Create(Nil);

  qryIteger := fCriaQuery(Nil);
  qryIteger.SQL.Add('SELECT  SQL_NO_CACHE ');

  qryIteger.SQL.Add('  I.ITE_CODITE, ');
  qryIteger.SQL.Add('  I.ITE_CODEMP, ');
  qryIteger.SQL.Add('  I.ITE_ESTMIN, ');
  qryIteger.SQL.Add('  I.ITE_ESTMAX, ');
  qryIteger.SQL.Add('  I.ITE_PMED_V, ');

  qryIteger.SQL.Add('  I.ITE_MINDIG, ');
  qryIteger.SQL.Add('  I.ITE_MAXDIG, ');

  qryIteger.SQL.Add('  I.ITE_PONPED, ');

  qryIteger.SQL.Add('  I.ITE_DTAUVE, ');
  qryIteger.SQL.Add('  I.ITE_QTDUVE, ');
  qryIteger.SQL.Add('  I.ITE_PREUVE, ');
  qryIteger.SQL.Add('  I.ITE_ESMIDG, ');
  qryIteger.SQL.Add('  I.ITE_LOCFIS, ');
  qryIteger.SQL.Add('  I.ITE_PREULT, ');
  qryIteger.SQL.Add('  I.ITE_IMPULT, ');
  qryIteger.SQL.Add('  I.ITE_QTDUCO, ');
  qryIteger.SQL.Add('  I.ITE_FORULT, ');

  qryIteger.SQL.Add(' (SELECT GROUP_CONCAT(DISTINCT ITE_EMPCEN SEPARATOR "_") FROM ITEGER AGR ');
  qryIteger.SQL.Add('   WHERE AGR.ITE_CODITE = I.ITE_CODITE ');
  qryIteger.SQL.Add('     AND AGR.ITE_CPRCEN = "S") AS AGRCEN, ');

  qryIteger.SQL.Add('  UF.FOR_NOMFOR AS ITE_NOMFOR, ');

  qryIteger.SQL.Add('  I.ITE_DTAULT, ');

  If blnAgrSim Then
  Begin
    qryIteger.SQL.Add(' SUM(IF(LOCATE(S.ITE_CODEMP, "' + strEmpSel + '") > 0, S.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(S.ITE_SAL_ML, 0) / ITE_CNV_ML, 0), 0)) AS ITE_SALDOS, ');
    qryIteger.SQL.Add(fSQLSaldosReservadosAgrSim(False, False, FOpcGir, 'I', 'C', 'SP'));
  End Else
  Begin
    qryIteger.SQL.Add('  IF(LOCATE(I.ITE_CODEMP, "' + strEmpSel + '") > 0, I.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0), 0) AS ITE_SALDOS, ');
    qryIteger.SQL.Add(fSQLSaldosReservados(False, False, FOpcGir, 'I', 'C', 'SP'));
  End;

  qryIteger.SQL.Add(fSQLCamposPrecoCusto(strCodFor));

  qryIteger.SQL.Add('  I.ITE_ABAMLT, ');

  qryIteger.SQL.Add('  U.UNI_PESLIT, ');
  qryIteger.SQL.Add('  C.ITE_PESOIT, ');
  If blnAnalisaITEFOR Then
    qryIteger.SQL.Add('  IF(C.ITE_CODFOR = "' + strCodFor +'", "*", "") AS ITE_PRINCI, ')
  Else
    qryIteger.SQL.Add('  " " AS ITE_PRINCI, ');

  If blnSitPro  And blnCorIpd Then
  Begin
    qryIteger.SQL.Add('  SIT_CODIGO, ');
    qryIteger.SQL.Add('  SIT_CORSIT, ');
    qryIteger.SQL.Add('  SIT_DESCRI, ');
  End;

  qryIteger.SQL.Add('  I.ITE_CICMDE, ');
  qryIteger.SQL.Add('  I.ITE_CDPIOP, ');
  qryIteger.SQL.Add('  I.ITE_DIDIOP, ');
  qryIteger.SQL.Add('  I.ITE_PONEXP, ');

  qryIteger.SQL.Add('  I.ITE_TIPABS, ');
  qryIteger.SQL.Add('  I.ITE_VNOLCD, ');

  qryIteger.SQL.Add(TNivelGiroCriticidade.fSQLNiveis(FOpcGir.recNivEst));

  qryIteger.SQL.Add('  I.ITE_CPRCEN, ');
  qryIteger.SQL.Add('  IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") AS ITE_EMPCEN,  ');
  qryIteger.SQL.Add('  FP.FOR_NOMFOR ITE_FORPRI, ');
  qryIteger.SQL.Add('  DP.DEP_DESCRI ITE_DEPART ');

  qryIteger.SQL.Add('FROM ');
  qryIteger.SQL.Add('  ITEGER I ');
  qryIteger.SQL.Add('  JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ');
  qryIteger.SQL.Add('  LEFT JOIN CADFOR FP ON FP.FOR_CODFOR = C.ITE_CODFOR ');
  qryIteger.SQL.Add('  LEFT JOIN CADDEP DP ON DP.DEP_CODIGO = C.ITE_CODDEP ');
  If blnAgrSim Then
  Begin
    qryIteger.SQL.Add(' JOIN ' + strTableNameFILTRO_ITEM + ' ON FIL_CODPRI = C.ITE_CODITE ');

    qryIteger.SQL.Add(' JOIN ITEGER S  ON S.ITE_CODITE =   FIL_CODITE ');
    qryIteger.SQL.Add('               AND S.ITE_CODEMP = I.ITE_CODEMP ');

    qryIteger.SQL.Add('  LEFT JOIN SALPDC SP ON SP.SAL_CODITE =   FIL_CODITE ');
    qryIteger.SQL.Add('                     AND SP.SAL_CODEMP = I.ITE_CODEMP ');
  End Else
  Begin
    qryIteger.SQL.Add(' JOIN ' + strTableNameFILTRO_ITEM + ' ON FIL_CODITE = C.ITE_CODITE ');

    qryIteger.SQL.Add('  LEFT JOIN SALPDC SP ON SP.SAL_CODITE = I.ITE_CODITE ');
    qryIteger.SQL.Add('                     AND SP.SAL_CODEMP = I.ITE_CODEMP ');
  End;

  qryIteger.SQL.Add('  JOIN CADUNI U ON U.UNI_CODUNI = C.ITE_CODUNI ');
  qryIteger.SQL.Add('  JOIN CADMAR M ON C.ITE_CODMAR = M.MAR_CODMAR ');
  qryIteger.SQL.Add('  LEFT JOIN GRU_COMPRA GC ON M.MAR_CODGRU = GC.GRU_CODIGO ');

  If blnSitPro And blnCorIpd Then
  Begin
    If blnSitEmp Then
      qryIteger.SQL.Add(' LEFT JOIN SITPRO ON C.ITE_SITPRO = SIT_CODIGO ')
    Else
      qryIteger.SQL.Add(' LEFT JOIN SITPRO ON I.ITE_SITPRO = SIT_CODIGO ');
  End;

  qryIteger.SQL.Add('  LEFT JOIN CADFOR UF ON UF.FOR_CODFOR = I.ITE_FORULT ');

  If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') Then
  Begin
    qryIteger.SQL.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE AND ');
    qryIteger.SQL.Add('                        F.ITE_CODFOR = ' + QuotedStr(strCodFor) + ' AND ');
    qryIteger.SQL.Add('                        (SELECT COUNT(*) FROM TABPRE      ');
    qryIteger.SQL.Add('                         WHERE F.ITE_CODTAB = TAB_CODTAB AND ' + fSqlWhereTabPre('', strCodTab) + ') > 0 ');

    qryIteger.SQL.Add('  LEFT JOIN CADFOR CF ON CF.FOR_CODFOR = ' + QuotedStr(strCodFor));
    qryIteger.SQL.Add('  LEFT JOIN CADCID ON CID_CODCID = CF.FOR_CODCID     ');
    qryIteger.SQL.Add('  LEFT JOIN ABFICM ON ABF_CODABF = ' + IfThen(fCfgSis('TIPABF') = '1', 'C', 'I') + '.ITE_CODABF AND ');
    qryIteger.SQL.Add('                      ABF_ESTADO = CID_ESTADO     ');

    If (Not fEmptyStr(strCodFor)) And (strCodFor <> '%') And fCfgSis('TABPRF', varBoolean) Then
    Begin
      qryIteger.SQL.Add(' LEFT JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB ');
      qryIteger.SQL.Add('                   AND D.ITE_CODITE = F.ITE_CODITE ');
      qryIteger.SQL.Add('                   AND D.ITE_CODEMP = I.ITE_CODEMP ');
    End;
  End;

  qryIteger.SQL.Add('WHERE TRUE ');

//  qryIteger.SQL.Add('  AND I.ITE_CODITE = "02003" ');

   If (strPedMlj = 'N') Then
     qryIteger.SQL.Add(' AND ((I.ITE_CPRCEN = "N") OR (IFNULL(I.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") = I.ITE_CODEMP)) ');

  qryIteger.SQL.Add('AND I.ITE_CODEMP IN (' + strEmpSel + ') ');

  If blnAgrSim Then
    qryIteger.SQL.Add(' GROUP BY FIL_AGRUPA, ITE_CODEMP ');

  pSetaNomeFuncao(fugLendoItegerSintetizaItensMultiLojas);

 // qryIteger.SQL.Text := AnsiReplaceStr(qryIteger.SQL.Text, '''', '"');
 //  qryIteger.SQL.Text := AnsiReplaceStr(qryIteger.SQL.Text, #13#10, ' ');

  Try
    qryIteger.Open;
  Except

    On E: Exception Do
    Begin

      If Pos(strTableNameFILTRO_ITEM, E.Message) > 0 Then
      Begin
        pMensagemOk('Houve uma falha de conexão com o banco de dados, por favor tente novamente!');
        Result := False;
        Exit;
      End

      Else Raise;

    End;

  End;

  pSetaClient(qryIteger);

  dspIteger.DataSet := qryIteger;
  cdsIteger.SetProvider(dspIteger);

  Try
    cdsIteger.Open;
  Except

    On E: Exception Do
    Begin

      If Pos(strTableNameFILTRO_ITEM, E.Message) > 0 Then
      Begin
        pMensagemOk('Houve uma falha de conexão com o banco de dados, por favor tente novamente!');
        Result := False;
        Exit;
      End

      Else Raise;

    End;

  End;

  cdsIteger.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';

  qryCadEmp := fCriaQuery(Nil);
  qryCadEmp.SQL.Add('SELECT  SQL_NO_CACHE EMP_CODEMP, EMP_NOMEMP, EMP_NOMFAN  FROM CADEMP');
  qryCadEmp.SQL.Add(' WHERE EMP_CODEMP IN (' + strEmpSel + ') ');

  qryCadEmp.Open;

  While (Not qryCadEmp.Eof) Do
  Begin
    lstEmpresas.Add(qryCadEmp.FieldByName('EMP_CODEMP').AsString);
    lstNomEmpresas.Add(qryCadEmp.FieldByName('EMP_NOMEMP').AsString);
    lstNomFanEmp.Add(qryCadEmp.FieldByName('EMP_NOMFAN').AsString);
    qryCadEmp.Next;
  End;
  qryCadEmp.Close;
  FreeAndNil(qryCadEmp);

  cdsTmpMlj := TUniClientDataSet.Create(Nil);
  cdsTmpMlj.Data := cdsItensMultiLojas.Data;

  cdsItensPed.EmptyDataSet;
  cdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';
  cdsTmpMlj.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';
  cdsTmpMlj.First;

  pSetaNomeFuncao(fugSintetizaItensMultiLojas);
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := cdsTmpMlj.RecordCount;
  Application.ProcessMessages;

  qryGenGir.IndexFieldNames := 'GIR_CODITE;GIR_CODEMP;GIR_A_N_O_';
  qryGenGir.KeyFields       := 'GIR_CODITE;GIR_CODEMP;GIR_A_N_O_';

  While (Not cdsTmpMlj.Eof) Do
  Begin

    fltSomaIte       := 0.0;
    fltSomaIteCal    := 0.0;

    fltSomaCprCen    := 0.0;
    fltSomaCprCenCal := 0.0;
    fltExtExc := 0.0;

    fltMaiSai     := 0.0;
    strEmpUsadas  := '';
    blnCprCen     := False;
    strItemAtu    := cdsTmpMlj.FieldByName('ITE_CODITE').AsString;

    If (Not cdsItensPed.IsEmpty) And

       (((Not blnAllIte) And (Not blnAteMax) And
         (cdsItensPed.FieldByName('ITE_SUGEST').AsFloat <= 0.0)) Or

        (cdsItensPed.FieldByName('ITE_ABAPON').AsString = 'S')  Or

        (FOpcGir.blnVenEsp And
         (cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat = 0) And
         (cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat = 0) And
         (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat >= 0))
         ) And

       fEmptyStr(strCodEmpUmaLoja) Then

      pApagaItemSemSugestao;

    cdsItensPed.Append;
    cdsItensPed.FieldByName('ITE_INCIRQ').AsString := '';
    cdsItensPed.FieldByName('ITE_QTDREQ').AsFloat  := 0;
    cdsItensPed.FieldByName('ITE_QATREQ').AsFloat  := 0;
    cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat  := 0;
    cdsItensPed.FieldByName('ITE_TRAINC').AsFloat  := 0;

    While (Not cdsTmpMlj.Eof)                                         And
          (cdsTmpMlj.FieldByName('ITE_CODITE').AsString = strItemAtu) Do
    Begin

      strEmpUsadas := strEmpUsadas + cdsTmpMlj.FieldByName('ITE_CODEMP').AsString + '_';

      {*****************************************}
      {* DADOS COMUNS PARA TODAS AS EMPRESAS   *}
      {* CASO A EMPRESA ATUAL NÃO ESTEJA NO    *}
      {* GIRITE, PEGA A PRIMEIRA QUE VIER      *}
      {**************************************MV*}
      If (cdsTmpMlj.FieldByName('ITE_CODEMP').AsString = VS_strCodEmp) Or
         (cdsItensPed.FieldByName('ITE_PREVE1').AsFloat <= 0.0)        Then
      Begin

        pSalvaDadosComuns(cdsItensPed, cdsTmpMlj);

        cdsItensPed.FieldByName('ITE_PRECOM').AsFloat  := cdsTmpMlj.FieldByName('ITE_PRECOM').AsFloat;
        cdsItensPed.FieldByName('ITE_EMBALA').AsFloat  := cdsTmpMlj.FieldByName('ITE_EMBALA').AsFloat;
        cdsItensPed.FieldByName('ITE_PRECUS').AsFloat  := cdsTmpMlj.FieldByName('ITE_PRECUS').AsFloat;
        cdsItensPed.FieldByName('ITE_PREVE1').AsFloat  := cdsTmpMlj.FieldByName('ITE_PREVE1').AsFloat;
        cdsItensPed.FieldByName('ITE_PREVE2').AsFloat  := cdsTmpMlj.FieldByName('ITE_PREVE2').AsFloat;
        cdsItensPed.FieldByName('ITE_PREVE3').AsFloat  := cdsTmpMlj.FieldByName('ITE_PREVE3').AsFloat;
        cdsItensPed.FieldByName('ITE_PREVE4').AsFloat  := cdsTmpMlj.FieldByName('ITE_PREVE4').AsFloat;
        cdsItensPed.FieldByName('ITE_PREVE5').AsFloat  := cdsTmpMlj.FieldByName('ITE_PREVE5').AsFloat;
        cdsItensPed.FieldByName('ITE_PREVE6').AsFloat  := cdsTmpMlj.FieldByName('ITE_PREVE6').AsFloat;
        cdsItensPed.FieldByName('ITE_PREVE7').AsFloat  := cdsTmpMlj.FieldByName('ITE_PREVE7').AsFloat;
        cdsItensPed.FieldByName('ITE_MARBR1').AsFloat  := cdsTmpMlj.FieldByName('ITE_MARBR1').AsFloat;
        cdsItensPed.FieldByName('ITE_MARBR2').AsFloat  := cdsTmpMlj.FieldByName('ITE_MARBR2').AsFloat;
        cdsItensPed.FieldByName('ITE_MARBR3').AsFloat  := cdsTmpMlj.FieldByName('ITE_MARBR3').AsFloat;
        cdsItensPed.FieldByName('ITE_MARBR4').AsFloat  := cdsTmpMlj.FieldByName('ITE_MARBR4').AsFloat;
        cdsItensPed.FieldByName('ITE_MARBR5').AsFloat  := cdsTmpMlj.FieldByName('ITE_MARBR5').AsFloat;
        cdsItensPed.FieldByName('ITE_MARBR6').AsFloat  := cdsTmpMlj.FieldByName('ITE_MARBR6').AsFloat;
        cdsItensPed.FieldByName('ITE_MARBR7').AsFloat  := cdsTmpMlj.FieldByName('ITE_MARBR7').AsFloat;

        cdsItensPed.FieldByName('ITE_CPRCEN').AsString := cdsTmpMlj.FieldByName('ITE_CPRCEN').AsString;
        cdsItensPed.FieldByName('ITE_EMPCEN').AsString := cdsTmpMlj.FieldByName('ITE_EMPCEN').AsString;
        cdsItensPed.FieldByName('ITE_PRINCI').AsString := cdsTmpMlj.FieldByName('ITE_PRINCI').AsString;

        If blnSitPro And blnCorIpd Then
        Begin
          cdsItensPed.FieldByName('ITE_DESSIT').AsString := cdsTmpMlj.FieldByName('ITE_DESSIT').AsString;
          cdsItensPed.FieldByName('ITE_CORSIT').AsString := cdsTmpMlj.FieldByName('ITE_CORSIT').AsString;
        End;

        cdsItensPed.FieldByName('ITE_CICMDE').AsString := cdsTmpMlj.FieldByName('ITE_CICMDE').AsString;
        cdsItensPed.FieldByName('ITE_CDPIOP').AsString := cdsTmpMlj.FieldByName('ITE_CDPIOP').AsString;
        cdsItensPed.FieldByName('ITE_DIDIOP').AsString := cdsTmpMlj.FieldByName('ITE_DIDIOP').AsString;

        cdsItensPed.FieldByName('ITE_CPCEMO').AsString := IfThen(cdsTmpMlj.FieldByName('ITE_CPRCEN').AsString='S', 'C', 'I');
        cdsItensPed.FieldByName('ITE_UNITAR').AsFloat  := cdsTmpMlj.FieldByName('ITE_UNITAR').AsFloat;
        cdsItensPed.FieldByName('ITE_DESUNI').AsFloat  := cdsTmpMlj.FieldByName('ITE_DESUNI').AsFloat;
        cdsItensPed.FieldByName('ITE_DESUN2').AsFloat  := cdsTmpMlj.FieldByName('ITE_DESUN2').AsFloat;
        cdsItensPed.FieldByName('ITE_DESUN3').AsFloat  := cdsTmpMlj.FieldByName('ITE_DESUN3').AsFloat;
        cdsItensPed.FieldByName('ITE_DESUN4').AsFloat  := cdsTmpMlj.FieldByName('ITE_DESUN4').AsFloat;
        cdsItensPed.FieldByName('ITE_DESUN5').AsFloat  := cdsTmpMlj.FieldByName('ITE_DESUN5').AsFloat;
        cdsItensPed.FieldByName('ITE_DESUN6').AsFloat  := cdsTmpMlj.FieldByName('ITE_DESUN6').AsFloat;
        cdsItensPed.FieldByName('ITE_UNILIQ').AsFloat  := cdsTmpMlj.FieldByName('ITE_UNILIQ').AsFloat;
        cdsItensPed.FieldByName('ITE_DIFPRE').AsFloat  := cdsTmpMlj.FieldByName('ITE_DIFPRE').AsFloat;
        cdsItensPed.FieldByName('ITE_UNIORI').AsFloat  := cdsTmpMlj.FieldByName('ITE_UNIORI').AsFloat;
        cdsItensPed.FieldByName('ITE_CNDPAG').AsString := cdsTmpMlj.FieldByName('ITE_CNDPAG').AsString;
        cdsItensPed.FieldByName('ITE_CODACA').AsString := cdsTmpMlj.FieldByName('ITE_CODACA').AsString;
        cdsItensPed.FieldByName('ITE_EMPACA').AsString := cdsTmpMlj.FieldByName('ITE_EMPACA').AsString;
        cdsItensPed.FieldByName('ITE_PROACA').AsString := cdsTmpMlj.FieldByName('ITE_PROACA').AsString;
        cdsItensPed.FieldByName('ITE_PERIPI').AsFloat  := cdsTmpMlj.FieldByName('ITE_PERIPI').AsFloat;
        cdsItensPed.FieldByName('ITE_ALQCBS').AsFloat  := cdsTmpMlj.FieldByName('ITE_ALQCBS').AsFloat;
        cdsItensPed.FieldByName('ITE_ALQIBS').AsFloat  := cdsTmpMlj.FieldByName('ITE_ALQIBS').AsFloat;
        cdsItensPed.FieldByName('ITE_ALQ_IS').AsFloat  := cdsTmpMlj.FieldByName('ITE_ALQ_IS').AsFloat;
        cdsItensPed.FieldByName('ITE_PERSUB').AsFloat  := cdsTmpMlj.FieldByName('ITE_PERSUB').AsFloat;
        cdsItensPed.FieldByName('ITE_CODFAB').AsString := cdsTmpMlj.FieldByName('ITE_CODFAB').AsString;
        cdsItensPed.FieldByName('ITE_CODBAR').AsString := cdsTmpMlj.FieldByName('ITE_CODBAR').AsString;
        cdsItensPed.FieldByName('ITE_PEDTXT').AsString := cdsTmpMlj.FieldByName('ITE_PEDTXT').AsString;
        cdsItensPed.FieldByName('AUTOINCREM').AsString := cdsTmpMlj.FieldByName('AUTOINCREM').AsString;
        cdsItensPed.FieldByName('ITE_DESFAB').AsString := cdsTmpMlj.FieldByName('ITE_DESFAB').AsString;
        cdsItensPed.FieldByName('ITE_CODSIM').AsString := cdsTmpMlj.FieldByName('ITE_CODSIM').AsString;
        cdsItensPed.FieldByName('ITE_MLTSPO').AsString := cdsTmpMlj.FieldByName('ITE_MLTSPO').AsString;
        cdsItensPed.FieldByName('ITE_DESSIM').AsString := cdsTmpMlj.FieldByName('ITE_DESSIM').AsString;
        cdsItensPed.FieldByName('ITE_DESGRU').AsString := cdsTmpMlj.FieldByName('ITE_DESGRU').AsString;
        cdsItensPed.FieldByName('ITE_PMED_V').AsString := cdsTmpMlj.FieldByName('ITE_PMED_V').AsString;
        cdsItensPed.FieldByName('ITE_TIPABS').AsString := cdsTmpMlj.FieldByName('ITE_TIPABS').AsString;
        cdsItensPed.FieldByName('ITE_VNOLCD').AsString := cdsTmpMlj.FieldByName('ITE_VNOLCD').AsString;
      End;

      {*****************************************}
      {* DADOS QUE SERÃO SINTETIZADOS          *}
      {**************************************MV*}
      With cdsItensPed Do
      Begin
        // PARA MOSTRAR OS DADOS DA EMPRESA LOGADA PARA PEDIDOS NÃO MULTILOJA
        FieldByName('ITE_NVLGIR').AsString  := FieldByName('GIRSINT').AsString;
        FieldByName('ITE_NVLCRI').AsString  := FieldByName('CRISINT').AsString;

        If (Not blnEmpVis) Or (Pos(cdsTmpMlj.FieldByName('ITE_CODEMP').AsString, strEmpCal) > 0) Then
        Begin

          If cdsIteger.FindKey([cdsTmpMlj.FieldByName('ITE_CODITE').AsString, cdsTmpMlj.FieldByName('ITE_CODEMP').AsString]) Then
          Begin
            fltSalRes := cdsIteger.FieldByName('ITE_SALRES').AsFloat;
            fltSalTra := cdsIteger.FieldByName('ITE_SALTRA').AsFloat;
            fltSalEnd := cdsIteger.FieldByName('ITE_SALEND').AsFloat;
            fltSalGar := cdsIteger.FieldByName('ITE_SALGAR').AsFloat;
            fltSalExt := cdsIteger.FieldByName('ITE_SALEXT').AsFloat;
            fltQtdPen := cdsIteger.FieldByName('ITE_QTDPEN').AsFloat;
            fltQtdReq := cdsIteger.FieldByName('ITE_SALREQ').AsFloat;
            fltEntFal := cdsIteger.FieldByName('ITE_QTEF_F').AsFloat;
            fltEntAgu := cdsIteger.FieldByName('ITE_QTEF_A').AsFloat;
            fltEntPre := cdsIteger.FieldByName('ITE_QTEF_P').AsFloat;
          End Else
          Begin
            fltSalRes := 0;
            fltSalTra := 0;
            fltSalEnd := 0;
            fltSalGar := 0;
            fltSalExt := 0;
            fltQtdPen := 0;
            fltQtdReq := 0;
            fltEntFal := 0;
            fltEntAgu := 0;
            fltEntPre := 0;
          End;

          FieldByName('ITE_QTDPEN').AsFloat := FieldByName('ITE_QTDPEN').AsFloat + fltQtdPen;
          FieldByName('ITE_SALREQ').AsFloat := FieldByName('ITE_SALREQ').AsFloat + fltQtdReq;

          FieldByName('ITE_SALRES').AsFloat := FieldByName('ITE_SALRES').AsFloat + fltSalRes;

          FieldByName('ITE_VENPER').AsFloat := FieldByName('ITE_VENPER').AsFloat + fRetQtdVenPer(cdsTmpMlj.FieldByName('ITE_CODITE').AsString,
                                                                                                 cdsTmpMlj.FieldByName('ITE_CODEMP').AsString,
                                                                                                 cdsTmpMlj.FieldByName('ITE_NVLGIR').AsString);

          FieldByName('ITE_SALGAR').AsFloat := FieldByName('ITE_SALGAR').AsFloat + fltSalGar;
          FieldByName('ITE_SALEXT').AsFloat := FieldByName('ITE_SALEXT').AsFloat + fltSalExt;

          FieldByName('ITE_SALTRA').AsFloat := FieldByName('ITE_SALTRA').AsFloat + fltSaltra;

          FieldByName('ITE_SALEND').AsFloat := FieldByName('ITE_SALEND').AsFloat + fltSalEnd;

          FieldByName('ITE_QTEF_F').AsFloat := FieldByName('ITE_QTEF_F').AsFloat + fltEntFal;
          FieldByName('ITE_QTEF_A').AsFloat := FieldByName('ITE_QTEF_A').AsFloat + fltEntAgu;
          FieldByName('ITE_QTEF_P').AsFloat := FieldByName('ITE_QTEF_P').AsFloat + fltEntPre;


          FieldByName('ITE_SALCOT').AsFloat := FieldByName('ITE_SALCOT').AsFloat + fRetQtdCotacao(cdsTmpMlj.FieldByName('ITE_CODITE').AsString,
                                                                                                  cdsTmpMlj.FieldByName('ITE_CODEMP').AsString);


          FieldByName('ITE_QTPD_P').AsFloat := FieldByName('ITE_QTPD_P').AsFloat + cdsTmpMlj.FieldByName('ITE_QTPD_P').AsFloat;
          FieldByName('ITE_SALDOS').AsFloat := FieldByName('ITE_SALDOS').AsFloat + cdsTmpMlj.FieldByName('ITE_SALDOS').AsFloat;
          FieldByName('ITE_SALDIS').AsFloat := FieldByName('ITE_SALDIS').AsFloat + cdsTmpMlj.FieldByName('ITE_SALDIS').AsFloat;
          FieldByName('ITE_SALFIS').AsFloat := FieldByName('ITE_SALFIS').AsFloat + cdsTmpMlj.FieldByName('ITE_SALFIS').AsFloat;
          FieldByName('ITE_INIBAS').AsFloat := FieldByName('ITE_INIBAS').AsFloat + cdsTmpMlj.FieldByName('ITE_INIBAS').AsFloat;


          FieldByName('ITE_SALBAS').AsFloat := FieldByName('ITE_INIBAS').AsFloat -
                                                      ( IfThen(blnConsPedVen, FieldByName('ITE_SALRES').AsFloat, 0) +

                                                        IfThen(blnDescSalExt, FieldByName('ITE_SALEXT').AsFloat, 0) +

                                                        IfThen(blnConsOrdPro, FieldByName('ITE_QTPD_P').AsFloat, 0) +

                                                        IfThen(blnConsGarPen, FieldByName('ITE_SALGAR').AsFloat, 0) +

                                                        IfThen(blnEntFutAguarda,  FieldByName('ITE_QTEF_A').AsFloat, 0) +
                                                        IfThen(blnEntFutFalta,    FieldByName('ITE_QTEF_F').AsFloat, 0) +
                                                        IfThen(blnEntFutPrevisao, FieldByName('ITE_QTEF_P').AsFloat, 0) +

                                                        IfThen(blnVenPer, FieldByName('ITE_VENPER').AsFloat, 0)
                                                       ) +

                                                       IfThen(blnConsTransf, FieldByName('ITE_SALTRA').AsFloat, 0) +
                                                       IfThen(blnConsCot,    FieldByName('ITE_SALCOT').AsFloat, 0) +
                                                       IfThen(blnConsPedPen, fieldbyname('ITE_QTDPEN').asfloat, 0) -
                                                       IfThen(blnConsRequisicao, fieldbyname('ITE_SALREQ').asfloat, 0);


          FieldByName('ITE_MLTCOM').AsFloat  := cdsTmpMlj.FieldByName('ITE_MLTCOM').AsFloat;
          FieldByName('ITE_ABAMLT').AsString := cdsTmpMlj.FieldByName('ITE_ABAMLT').AsString;

          FieldByName('ITE_ACRFIN').AsFloat := FieldByName('ITE_ACRFIN').AsFloat + cdsTmpMlj.FieldByName('ITE_ACRFIN').AsFloat;
          FieldByName('ITE_DESF01').AsFloat := FieldByName('ITE_DESF01').AsFloat + cdsTmpMlj.FieldByName('ITE_DESF01').AsFloat;
          FieldByName('ITE_DESF02').AsFloat := FieldByName('ITE_DESF02').AsFloat + cdsTmpMlj.FieldByName('ITE_DESF02').AsFloat;
          FieldByName('ITE_DESF03').AsFloat := FieldByName('ITE_DESF03').AsFloat + cdsTmpMlj.FieldByName('ITE_DESF03').AsFloat;
          FieldByName('ITE_DESF04').AsFloat := FieldByName('ITE_DESF04').AsFloat + cdsTmpMlj.FieldByName('ITE_DESF04').AsFloat;
          FieldByName('ITE_DESF05').AsFloat := FieldByName('ITE_DESF05').AsFloat + cdsTmpMlj.FieldByName('ITE_DESF05').AsFloat;
          FieldByName('ITE_DESF06').AsFloat := FieldByName('ITE_DESF06').AsFloat + cdsTmpMlj.FieldByName('ITE_DESF06').AsFloat;
          FieldByName('ITE_QTDBAI').AsFloat := FieldByName('ITE_QTDBAI').AsFloat + cdsTmpMlj.FieldByName('ITE_QTDBAI').AsFloat;
          FieldByName('ITE_TOTBAI').AsFloat := FieldByName('ITE_TOTBAI').AsFloat + cdsTmpMlj.FieldByName('ITE_TOTBAI').AsFloat;
          FieldByName('ITE_IPIBAI').AsFloat := FieldByName('ITE_IPIBAI').AsFloat + cdsTmpMlj.FieldByName('ITE_IPIBAI').AsFloat;
          FieldByName('ITE_SUBBAI').AsFloat := FieldByName('ITE_SUBBAI').AsFloat + cdsTmpMlj.FieldByName('ITE_SUBBAI').AsFloat;
          FieldByName('ITE_DARBAI').AsFloat := FieldByName('ITE_DARBAI').AsFloat + cdsTmpMlj.FieldByName('ITE_DARBAI').AsFloat;
          FieldByName('ITE_LITROS').AsFloat := FieldByName('ITE_LITROS').AsFloat + cdsTmpMlj.FieldByName('ITE_LITROS').AsFloat;
          FieldByName('ITE_PESOIT').AsFloat := FieldByName('ITE_PESOIT').AsFloat + cdsTmpMlj.FieldByName('ITE_PESOIT').AsFloat;
          FieldByName('ITE_PONEXP').AsFloat := FieldByName('ITE_PONEXP').AsFloat + cdsTmpMlj.FieldByName('ITE_PONEXP').AsFloat;
          FieldByName('ITE_ESTMIN').AsFloat := FieldByName('ITE_ESTMIN').AsFloat + cdsTmpMlj.FieldByName('ITE_ESTMIN').AsFloat;
          FieldByName('ITE_ESTMAX').AsFloat := FieldByName('ITE_ESTMAX').AsFloat + cdsTmpMlj.FieldByName('ITE_ESTMAX').AsFloat;

          FieldByName('ITE_MINDIG').AsFloat := FieldByName('ITE_MINDIG').AsFloat + cdsTmpMlj.FieldByName('ITE_MINDIG').AsFloat;
          FieldByName('ITE_MAXDIG').AsFloat := FieldByName('ITE_MAXDIG').AsFloat + cdsTmpMlj.FieldByName('ITE_MAXDIG').AsFloat;

          FieldByName('ITE_PONPED').AsFloat := FieldByName('ITE_PONPED').AsFloat + cdsTmpMlj.FieldByName('ITE_PONPED').AsFloat;
        End; {If (Not blnEmpVis) Or (Pos(cdsTmpMlj.FieldByName('ITE_CODEMP').AsString, strEmpCal) > 0) Then}

        If fEmptyStr(FieldByName('ITE_ABAPON').AsString) Then
          FieldByName('ITE_ABAPON').AsString := 'S';

        If cdsTmpMlj.FieldByName('ITE_ABAPON').AsString = 'N' Then
          FieldByName('ITE_ABAPON').AsString := 'N';

        If (Not blnEmpVis) Or (Pos(cdsTmpMlj.FieldByName('ITE_CODEMP').AsString, strEmpCal) > 0) Then
        Begin
          FieldByName('ITE_VENMES').AsFloat   := FieldByName('ITE_VENMES').AsFloat   + cdsTmpMlj.FieldByName('ITE_VENMES').AsFloat;
          FieldByName('ITE_Q_VPME').AsFloat   := FieldByName('ITE_Q_VPME').AsFloat   + cdsTmpMlj.FieldByName('ITE_Q_VPME').AsFloat;

          FieldByName('ITE_DIASAI').AsInteger := FieldByName('ITE_DIASAI').AsInteger + cdsTmpMlj.FieldByName('ITE_DIASAI').AsInteger;

          FieldByName('ITE_MEDIA_').AsFloat := FieldByName('ITE_MEDIA_').AsFloat + cdsTmpMlj.FieldByName('ITE_MEDIA_').AsFloat;
          FieldByName('ITE_AJUSTA').AsFloat := FieldByName('ITE_AJUSTA').AsFloat + cdsTmpMlj.FieldByName('ITE_AJUSTA').AsFloat;
          FieldByName('ITE_MEDIXX').AsFloat := FieldByName('ITE_MEDIXX').AsFloat + cdsTmpMlj.FieldByName('ITE_MEDIXX').AsFloat;
          FieldByName('ITE_MEDAJU').AsFloat := FieldByName('ITE_MEDAJU').AsFloat + cdsTmpMlj.FieldByName('ITE_MEDAJU').AsFloat;

          FieldByName('ITE_TOTITE').AsFloat := FieldByName('ITE_TOTITE').AsFloat + cdsTmpMlj.FieldByName('ITE_TOTITE').AsFloat;
          FieldByName('ITE_BASIPI').AsFloat := FieldByName('ITE_BASIPI').AsFloat + cdsTmpMlj.FieldByName('ITE_BASIPI').AsFloat;
          FieldByName('ITE_TOTIPI').AsFloat := FieldByName('ITE_TOTIPI').AsFloat + cdsTmpMlj.FieldByName('ITE_TOTIPI').AsFloat;
          FieldByName('ITE_VALCBS').AsFloat := FieldByName('ITE_VALCBS').AsFloat + cdsTmpMlj.FieldByName('ITE_VALCBS').AsFloat;
          FieldByName('ITE_VALIBS').AsFloat := FieldByName('ITE_VALIBS').AsFloat + cdsTmpMlj.FieldByName('ITE_VALIBS').AsFloat;
          FieldByName('ITE_VAL_IS').AsFloat := FieldByName('ITE_VAL_IS').AsFloat + cdsTmpMlj.FieldByName('ITE_VAL_IS').AsFloat;
          FieldByName('ITE_TOTSUB').AsFloat := FieldByName('ITE_TOTSUB').AsFloat + cdsTmpMlj.FieldByName('ITE_TOTSUB').AsFloat;
          FieldByName('ITE_TOTDAR').AsFloat := FieldByName('ITE_TOTDAR').AsFloat + cdsTmpMlj.FieldByName('ITE_TOTDAR').AsFloat;
          FieldByName('ITE_VALIMP').AsFloat := FieldByName('ITE_VALIMP').AsFloat + cdsTmpMlj.FieldByName('ITE_VALIMP').AsFloat;

          FieldByName('ITE_SUGEST').AsFloat := FieldByName('ITE_SUGEST').AsFloat + cdsTmpMlj.FieldByName('ITE_SUGEST').AsFloat;
          FieldByName('ITE_QTDITE').AsFloat := FieldByName('ITE_QTDITE').AsFloat + cdsTmpMlj.FieldByName('ITE_QTDITE').AsFloat;
          FieldByName('ITE_SUGESTORI').AsFloat := FieldByName('ITE_SUGESTORI').AsFloat + cdsTmpMlj.FieldByName('ITE_QTDCAL').AsFloat;
          FieldByName('ITE_SALEXC').AsFloat := FieldByName('ITE_SALEXC').AsFloat + cdsTmpMlj.FieldByName('ITE_SALEXC').AsFloat;

          FieldByName('ITE_QTDINC').AsFloat := FieldByName('ITE_QTDITE').AsFloat;

          FieldByName('ITE_VALIMP').AsFloat := FieldByName('ITE_VALIMP').AsFloat + cdsTmpMlj.FieldByName('ITE_VALIMP').AsFloat;

          If IfThen(blnMedAju, cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat, cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat) > 0 Then
          Begin
            FieldByName('ITE_DIAEST').AsInteger := Trunc(RoundTo(FieldByName('ITE_SALBAS').AsFloat /
                                                                 (IfThen(blnMedAju, FieldByName('ITE_AJUSTA').AsFloat,
                                                                                 FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));

            FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((FieldByName('ITE_SALBAS').AsFloat +
                                                          FieldByName('ITE_QTDITE').AsFloat) /
                                                                 (IfThen(blnMedAju, FieldByName('ITE_AJUSTA').AsFloat,
                                                                                 FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));
          End Else
          Begin
            FieldByName('ITE_DIAEST').Clear;
            FieldByName('ITE_DIASUG').Clear;
          End;

          If (Not ((strPedMlj <> 'S') And ((strFilGir = 'C') Or (Not blnAllIte)) And (lstEmpresas.Count > 1))) And
             ((cdsItensPed.FieldByName('ITE_DTAULT').IsNull) Or
              (cdsTmpMlj.FieldByName('ITE_DTAULT').Value > cdsItensPed.FieldByName('ITE_DTAULT').Value)) then
          Begin
            cdsItensPed.FieldByName('ITE_PREULT').Value := cdsTmpMlj.FieldByName('ITE_PREULT').Value;
            cdsItensPed.FieldByName('ITE_IMPULT').Value := cdsTmpMlj.FieldByName('ITE_IMPULT').Value;
            cdsItensPed.FieldByName('ITE_QTDUCO').Value := cdsTmpMlj.FieldByName('ITE_QTDUCO').Value;
            cdsItensPed.FieldByName('ITE_FORULT').Value := cdsTmpMlj.FieldByName('ITE_FORULT').Value;
            cdsItensPed.FieldByName('ITE_NOMFOR').Value := cdsTmpMlj.FieldByName('ITE_NOMFOR').Value;
            cdsItensPed.FieldByName('ITE_DTAULT').Value := cdsTmpMlj.FieldByName('ITE_DTAULT').Value;

            If (Not cdsItensPed.FieldByName('ITE_DTAULT').IsNull) And (cdsItensPed.FieldByName('ITE_DTAULT').AsDateTime > 0) Then
              cdsItensPed.FieldByName('ITE_DIAUCO').AsInteger  := Trunc(VS_Date - cdsItensPed.FieldByName('ITE_DTAULT').AsDateTime);
          End;

          If (cdsItensPed.FieldByName('ITE_DTAUVE').IsNull) Or
             (cdsTmpMlj.FieldByName('ITE_DTAUVE').Value > cdsItensPed.FieldByName('ITE_DTAUVE').Value) then
          Begin
            cdsItensPed.FieldByName('ITE_DTAUVE').Value := cdsTmpMlj.FieldByName('ITE_DTAUVE').Value;
            cdsItensPed.FieldByName('ITE_PREUVE').Value := cdsTmpMlj.FieldByName('ITE_PREUVE').Value;
            cdsItensPed.FieldByName('ITE_QTDUVE').Value := cdsTmpMlj.FieldByName('ITE_QTDUVE').Value;

            If (Not cdsItensPed.FieldByName('ITE_DTAUVE').IsNull) And (cdsItensPed.FieldByName('ITE_DTAUVE').AsDateTime > 0) Then
              cdsItensPed.FieldByName('ITE_DIAUVE').AsInteger := Trunc(VS_Date - cdsItensPed.FieldByName('ITE_DTAUVE').AsDateTime);
          End;

          If (cdsItensPed.FieldByName('ITE_MAQTSA').IsNull) Or
             (cdsTmpMlj.FieldByName('ITE_MAQTSA').Value > cdsItensPed.FieldByName('ITE_MAQTSA').Value) then
          Begin
            cdsItensPed.FieldByName('ITE_MAQTSA').Value := cdsTmpMlj.FieldByName('ITE_MAQTSA').Value;
            cdsItensPed.FieldByName('ITE_MADTSA').Value := cdsTmpMlj.FieldByName('ITE_MADTSA').Value;
          End;
        End;

        fltSomaIte    := fltSomaIte    + cdsTmpMlj.FieldByName('ITE_QTDITE').AsFloat;
        fltSomaIteCal := fltSomaIteCal + cdsTmpMlj.FieldByName('ITE_QTDCAL').AsFloat;

        // SOMA A QUANTIDADE DA PROPRIA MATRIZ
        If (Not fConsidera_EmpAgr_Vazio(strEmpAgr)) Then
        Begin
          If Not fPedidoMultiLojaPorNivelAgregadaPorEmpresaComCalculoGlobal_E_NivelGiroPorEmpresa(strPedMlj, strEmpAgr, recNivEst, blnSugInd) then
            fltSomaCprCen    := fltSomaCprCen + cdsTmpMlj.FieldByName('ITE_QTDITE').AsFloat;
          fltSomaCprCenCal := fltSomaCprCenCal + cdsTmpMlj.FieldByName('ITE_QTDCAL').AsFloat;
        End

        Else If (cdsTmpMlj.FieldByName('ITE_CPRCEN').AsString = 'S') And
                (cdsTmpMlj.FieldByName('ITE_CODEMP').AsString <> cdsTmpMlj.FieldByName('ITE_EMPCEN').AsString) Then
        Begin
          pAdicionaCprCen(cdsTmpMlj.FieldByName('ITE_CODITE').AsString,
                          cdsTmpMlj.FieldByName('ITE_EMPCEN').AsString,
                          cdsTmpMlj.FieldByName('ITE_QTDITE').AsFloat,
                          cdsTmpMlj.FieldByName('ITE_QTDCAL').AsFloat,
                          cdsTmpMlj.FieldByName('ITE_SALDIS').AsFloat,
                          IIf(blnMedAju, cdsTmpMlj.FieldByName('ITE_AJUSTA').AsFloat * (fDiasCompra(recNivEst) / 30),
                                         cdsTmpMlj.FieldByName('ITE_MEDIA_').AsFloat * (fDiasCompra(recNivEst) / 30)));

        End;

        pCalculaSaldoParaEmpresaDoAgrupamento(cdsTmpMlj.FieldByName('ITE_CODEMP').AsString);

        pZeraQuantidadeDoItemAtualCasoNecessario;
      End; {With cdsItensPed Do}

      If (Not blnEmpVis) Or (Pos(cdsTmpMlj.FieldByName('ITE_CODEMP').AsString, strEmpCal) > 0) Then
      Begin

        For intContador := 1 To 12 Do
        Begin
          strCont := fStrZero(intContador, 2);
          With cdsItensPed Do
          Begin
            {*****************************************}
            {* CRIA OS CAMPOS REFERENTES ÀS VENDAS   *}
            {*****************************************}
            FieldByName('ITE_Q_V_' + strCont).AsFloat := FieldByName('ITE_Q_V_' + strCont).AsFloat +
                                                         cdsTmpMlj.FieldByName('ITE_Q_V_' + strCont).AsFloat;

            FieldByName('ITE_Q_VP' + strCont).AsFloat := cdsItensPed.FieldByName('ITE_Q_VP' + strCont).AsFloat +
                                                         cdsTmpMlj.FieldByName('ITE_Q_VP' + strCont).AsFloat;

            {*****************************************}
            {* CRIA OS CAMPOS REFERENTES ÀS COMPRAS  *}
            {*****************************************}
            FieldByName('ITE_Q_C_' + strCont).AsFloat := FieldByName('ITE_Q_C_' + strCont).AsFloat +
                                                         cdsTmpMlj.FieldByName('ITE_Q_C_' + strCont).AsFloat;

            {*****************************************}
            {* CRIA OS CAMPOS REFERENTES AOS MESES   *}
            {* DAS COMPRAS / VENDAS                  *}
            {*****************************************}
            FieldByName('ITE_DESM' + strCont).AsString := cdsTmpMlj.FieldByName('ITE_DESM' + strCont).AsString;
          End;
        End; {For intContador := 1 To INT_QTD_MES_MOSTRA_GIRO Do}

        For intContador := 1 To intQtdMes Do
        Begin
          strCont := fStrZero(IntToStr(intContador), 2);
          With cdsItensPed Do
          Begin
            If (cdsTmpMlj.FieldByName('ITE_MQSA' + strCont).AsFloat >= fltMaiSai) Then
            Begin
              {*****************************************}
              {* CRIA OS CAMPOS REF. QTD MAIOR VENDA   *}
              {*****************************************}
              fltMaiSai :=                                 cdsTmpMlj.FieldByName('ITE_MQSA' + strCont).AsFloat;
              FieldByName('ITE_MQSA' + strCont).AsFloat := cdsTmpMlj.FieldByName('ITE_MQSA' + strCont).AsFloat;

              {*****************************************}
              {* CRIA OS CAMPOS REF. DTA MAIOR VENDA   *}
              {*****************************************}
              FieldByName('ITE_MDSA' + strCont).AsDateTime := cdsTmpMlj.FieldByName('ITE_MDSA' + strCont).AsDateTime;
            End;

          End;
        End; {For intContador := 1 To intQtdMes Do}

      End; {If (Not blnEmpVis) Or (Pos(cdsTmpMlj.FieldByName('ITE_CODEMP').AsString, strEmpCal) > 0) Then}

      cdsTmpMlj.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End; {(Not cdsTmpMlj.Eof)                                         And
          (cdsTmpMlj.FieldByName('ITE_CODITE').AsString = strItemAtu) Do}

    {*****************************************}
    {* SE NÃO TEM MOVIMENTO, REGISTRA E CAN- *}
    {* CELA A INSERÇÃO.                      *}
    {**************************************MV*}
    If (((Not blnAllIte) And (cdsItensPed.FieldByName('ITE_SUGEST').AsFloat <= 0.0)) Or
        (cdsItensPed.FieldByName('ITE_ABAPON').AsString = 'S') Or

        (FopcGir.blnVenEsp And
        (cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat = 0) And
        (cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat = 0) And
        (cdsItensPed.FieldByName('ITE_SALBAS').AsFloat >= 0))

        ) And

       fEmptyStr(strNumPedAlt) Then
    Begin

      cdsItensPed.Cancel;

    End
    Else
    Begin
      stlItensGiro.Add(cdsItensPed.FieldByName('ITE_CODITE').AsString);

      pAcertaCorPedido(cdsItensPed, fltLimAma, fltLimVer);

      If cdsItensPed.FieldByName('ITE_QTDEMB').IsNull Or (cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat = 0) Then
        cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat := 1;

      If cdsItensPed.FieldByName('ITE_QTDTRA').IsNull Then
        cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat := 0;

      pCalculaVariacaoCompra(cdsItensPed);

      cdsItensPed.FieldByName('ITE_TRAINC').AsFloat := cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat;

      cdsItensPed.FieldByName('ITE_QTDALT').AsString := 'N';

      cdsItensPed.Post;

      If (cdsTmpMlj.Eof) Then
        bkmRegAtual := Nil
      Else
      Begin
        bkmRegAtual    := cdsTmpMlj.GetBookmark;
        fltPosRegAtual := pgbProgresso.Position;

        cdsTmpMlj.Prior;
        pgbProgresso.Position := pgbProgresso.Position - 1;
      End;

      If (strPedMlj = 'S') Or (blnConsTLoj) Then
      Begin
        {*****************************************}
        {* ACERTO O SALDO E A SUGESTÃO DOS ITENS *}
        {* SEM GIRO.                             *}
        {**************************************MV*}
        cdsItensPed.Edit;

        If (strPedMlj <> 'S') And ((strFilGir = 'C') Or (Not blnAllIte)) And (lstEmpresas.Count > 1) Then
          pCarregaUltimaCompraGeral(cdsItensPed, cdsItensPed.FieldByName('ITE_CODITE').AsString, strEmpSel);

        For intIdxEmp := 0 To lstEmpresas.Count -1 Do
        Begin

          If (Pos(lstEmpresas[intIdxEmp], strEmpUsadas) <= 0) Then
          Begin
            cdsItensMultiLojas.Append;
            pSalvaDadosComuns(cdsItensMultiLojas, cdsTmpMlj, lstEmpresas[intIdxEmp], lstNomEmpresas[intIdxEmp], lstNomFanEmp[intIdxEmp]);

            intMesGir := MOnthOf(dtaDataBase);
            intAnoGir := YearOf(dtaDataBase);

            If qryGenGir.Locate('GIR_CODITE;GIR_CODEMP;GIR_A_N_O_',
                  VarArrayOf([cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,
                              cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString,
                              IntToStr(intAnoGir)]), []) Then
            Begin
              cdsItensMultiLojas.FieldByName('ITE_VENMES').AsFloat := fGetValorGirIte(qryGenGir, 'GIR_QSAI' + fStrZero(intMesGir, 2));
              cdsItensMultiLojas.FieldByName('ITE_Q_VPME').AsFloat := fGetValorGirIte(qryGenGir, 'GIR_QPSA' + fStrZero(intMesGir, 2));
            End Else
            Begin
              Result := False;
              pMensagemOk('Não há informações de giro de estoque para o produto ' +
                       cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString +
                    ' no ano de ' + IntToStr(intAnoGir) + ' na empresa ' + cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString + '!');
              pLiberaComps;
              Exit;
            End;

            For intContadorMes := 1 To intQtdMes Do
            Begin
              intMesGir := fRetMes(intContadorMes);
              intAnoGir := fRetAno(intContadorMes);

              If qryGenGir.Locate('GIR_CODITE;GIR_CODEMP;GIR_A_N_O_',
                    VarArrayOf([cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,
                                cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString,
                                IntToStr(intAnoGir)]), []) Then
              Begin
                cdsItensMultiLojas.FieldByName('ITE_Q_V_' + fInd(intContadorMes)).AsFloat :=
                   fGetValorGirIte(qryGenGir, 'GIR_QSAI' + fInd(intMesGir));
                cdsItensMultiLojas.FieldByName('ITE_Q_VP' + fInd(intContadorMes)).AsFloat :=
                   fGetValorGirIte(qryGenGir, 'GIR_QPSA' + fInd(intMesGir));
              End Else
              Begin
                Result := False;
                pMensagemOk('Não há informações de giro de estoque para o produto ' +
                         cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString +
                      ' no ano de ' + IntToStr(intAnoGir) + ' na empresa ' + cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString + '!');
                pLiberaComps;
                Exit;
              End;

            End;

            If cdsIteger.FindKey([strItemAtu, lstEmpresas[intIdxEmp]]) Then
            Begin
              cdsItensMultiLojas.FieldByName('ITE_NVLGIR').Value    := cdsIteger.FieldByName('GIRSINT').Value;
              cdsItensMultiLojas.FieldByName('ITE_NVLCRI').Value    := cdsIteger.FieldByName('CRISINT').Value;
              cdsItensMultiLojas.FieldByName('ITE_CPRCEN').AsString := cdsIteger.FieldByName('ITE_CPRCEN').AsString;
              cdsItensMultiLojas.FieldByName('ITE_EMPCEN').AsString := cdsIteger.FieldByName('ITE_EMPCEN').AsString;
              cdsItensMultiLojas.FieldByName('ITE_PRINCI').AsString := cdsIteger.FieldByName('ITE_PRINCI').AsString;

              If blnSitPro And blnCorIpd Then
              Begin
                cdsItensMultiLojas.FieldByName('ITE_DESSIT').AsString := cdsIteger.FieldByName('SIT_DESCRI').AsString;
                cdsItensMultiLojas.FieldByName('ITE_CORSIT').AsString := cdsIteger.FieldByName('SIT_CORSIT').AsString;
              End;

              cdsItensMultiLojas.FieldByName('ITE_CICMDE').AsString := cdsIteger.FieldByName('ITE_CICMDE').AsString;
              cdsItensMultiLojas.FieldByName('ITE_CDPIOP').AsString := cdsIteger.FieldByName('ITE_CDPIOP').AsString;
              cdsItensMultiLojas.FieldByName('ITE_DIDIOP').AsString := cdsIteger.FieldByName('ITE_DIDIOP').AsString;

              cdsItensMultiLojas.FieldByName('ITE_PREUVE').Value := cdsIteger.FieldByName('ITE_PREUVE').Value;
              cdsItensMultiLojas.FieldByName('ITE_QTDUVE').Value := cdsIteger.FieldByName('ITE_QTDUVE').Value;
              cdsItensMultiLojas.FieldByName('ITE_DTAUVE').Value := cdsIteger.FieldByName('ITE_DTAUVE').Value;

              cdsItensMultiLojas.FieldByName('ITE_PONEXP').Value := cdsIteger.FieldByName('ITE_PONEXP').Value;

              If (Not cdsItensMultiLojas.FieldByName('ITE_DTAUVE').IsNull) And (cdsItensMultiLojas.FieldByName('ITE_DTAUVE').AsDateTime > 0) Then
                cdsItensMultiLojas.FieldByName('ITE_DIAUVE').AsInteger  := Trunc(VS_Date - cdsItensMultiLojas.FieldByName('ITE_DTAUVE').AsDateTime);

              cdsItensMultiLojas.FieldByName('ITE_PREULT').Value := cdsIteger.FieldByName('ITE_PREULT').Value;
              cdsItensMultiLojas.FieldByName('ITE_IMPULT').Value := cdsIteger.FieldByName('ITE_IMPULT').Value;
              cdsItensMultiLojas.FieldByName('ITE_QTDUCO').Value := cdsIteger.FieldByName('ITE_QTDUCO').Value;
              cdsItensMultiLojas.FieldByName('ITE_FORULT').Value := cdsIteger.FieldByName('ITE_FORULT').Value;
              cdsItensMultiLojas.FieldByName('ITE_NOMFOR').Value := cdsIteger.FieldByName('ITE_NOMFOR').Value;
              cdsItensMultiLojas.FieldByName('ITE_DTAULT').Value := cdsIteger.FieldByName('ITE_DTAULT').Value;

              If (Not cdsItensMultiLojas.FieldByName('ITE_DTAULT').IsNull) And (cdsItensMultiLojas.FieldByName('ITE_DTAULT').AsDateTime > 0) Then
                cdsItensMultiLojas.FieldByName('ITE_DIAUCO').AsInteger  := Trunc(VS_Date - cdsItensMultiLojas.FieldByName('ITE_DTAULT').AsDateTime);

              cdsItensMultiLojas.FieldByName('ITE_QTEF_F').AsFloat := cdsIteger.FieldByName('ITE_QTEF_F').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_QTEF_A').AsFloat := cdsIteger.FieldByName('ITE_QTEF_A').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_QTEF_P').AsFloat := cdsIteger.FieldByName('ITE_QTEF_P').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_QTPD_P').AsFloat := cdsIteger.FieldByName('ITE_QTPD_P').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_SALDOS').AsFloat := cdsIteger.FieldByName('ITE_SALDOS').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_SALDIS').AsFloat := cdsIteger.FieldByName('ITE_SALDIS').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_SALEXT').AsFloat := cdsIteger.FieldByName('ITE_SALEXT').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_SALFIS').AsFloat := cdsIteger.FieldByName('ITE_SALFIS').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_INIBAS').AsFloat := cdsIteger.FieldByName('ITE_INIBAS').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_ESTMAX').AsFloat := cdsIteger.FieldByName('ITE_ESTMAX').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_PMED_V').AsFloat := cdsIteger.FieldByName('ITE_PMED_V').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_PONPED').AsFloat := cdsIteger.FieldByName('ITE_PONPED').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_ESTMIN').AsFloat := cdsIteger.FieldByName('ITE_ESTMIN').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_MINDIG').AsFloat := cdsIteger.FieldByName('ITE_MINDIG').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_MAXDIG').AsFloat := cdsIteger.FieldByName('ITE_MAXDIG').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat  := cdsIteger.FieldByName('ITE_MLTCOM').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_ABAMLT').AsString := cdsIteger.FieldByName('ITE_ABAMLT').AsString;

              cdsItensMultiLojas.FieldByName('ITE_SALGAR').AsFloat := cdsIteger.FieldByName('ITE_SALGAR').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_SALTRA').AsFloat := cdsIteger.FieldByName('ITE_SALTRA').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_SALEND').AsFloat := cdsIteger.FieldByName('ITE_SALEND').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_SALCOT').AsFloat := fRetQtdCotacao(cdsIteger.FieldByName('ITE_CODITE').AsString,
                                                                                     cdsIteger.FieldByName('ITE_CODEMP').AsString);

              cdsItensMultiLojas.FieldByName('ITE_SALRES').AsFloat := cdsIteger.FieldByName('ITE_SALRES').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_QTDPEN').AsFloat := cdsIteger.FieldByName('ITE_QTDPEN').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_SALREQ').AsFloat := cdsIteger.FieldByName('ITE_SALREQ').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_VENPER').AsFloat := fRetQtdVenPer(cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,
                                                                                    cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString,
                                                                                    cdsItensMultiLojas.FieldByName('ITE_NVLGIR').AsString);


              fltSaldosSug := cdsIteger.FieldByName('ITE_INIBAS').AsFloat - IfThen(blnConsPedVen, cdsIteger.FieldByName('ITE_SALRES').AsFloat, 0)

                                                                          - IfThen(blnDescSalExt, cdsIteger.FieldByName('ITE_SALEXT').AsFloat, 0)

                                                                          - IfThen(blnConsOrdPro, cdsIteger.FieldByName('ITE_QTPD_P').AsFloat, 0)

                                                                          - IfThen(blnConsGarPen, cdsIteger.FieldByName('ITE_SALGAR').AsFloat, 0)

                                                                          - IfThen(blnEntFutAguarda,  cdsIteger.FieldByName('ITE_QTEF_A').AsFloat, 0)
                                                                          - IfThen(blnEntFutFalta,    cdsIteger.FieldByName('ITE_QTEF_F').AsFloat, 0)
                                                                          - IfThen(blnEntFutPrevisao, cdsIteger.FieldByName('ITE_QTEF_P').AsFloat, 0)

                                                                          - fRetQtdVenPerCons(cdsIteger.FieldByName('ITE_CODITE').AsString,
                                                                                              cdsIteger.FieldByName('ITE_CODEMP').AsString,
                                                                                              cdsIteger.FieldByName('ITE_NVLGIR').AsString) +

                                                                            IfThen(blnConsTransf, cdsIteger.FieldByName('ITE_SALTRA').AsFloat, 0) +

                                                                            fRetQtdCotacaoCons(cdsIteger.FieldByName('ITE_CODITE').AsString,
                                                                                               cdsIteger.FieldByName('ITE_CODEMP').AsString) +

                                                                            IfThen(blnConsPedPen, cdsIteger.fieldbyname('ITE_QTDPEN').asfloat, 0) -
                                                                            IfThen(blnConsRequisicao, cdsIteger.fieldbyname('ITE_SALREQ').asfloat, 0);



              cdsItensMultiLojas.FieldByName('ITE_SALBAS').AsFloat := fltSaldosSug;

              If (fltSaldosSug) < 0 Then
                cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := - fltSaldosSug;

              If (blnConsEMin) Then
              Begin
                If ((fltSaldosSug) < cdsIteger.FieldByName('ITE_ESTMIN').AsFloat) Then
                Begin
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := cdsIteger.FieldByName('ITE_ESTMIN').AsFloat - (fltSaldosSug);
                End
                Else If ((fltSaldosSug) < 0.0) Then
                Begin
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := (-1) * (fltSaldosSug);
                End
                Else
                Begin
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0.0;
                End;
              End;

              recNivEst.strIteGir := cdsItensMultiLojas.FieldByName('ITE_NVLGIR').AsString;
              recNivEst.strIteCri := cdsItensMultiLojas.FieldByName('ITE_NVLCRI').AsString;

              fltPerConTmp := fPercElevacaoConsumiveis(recNivEst);

              cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := fElevaConsumiveis(cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat, fltPerConTmp,
                                                                        cdsItensMultiLojas.FieldByName('ITE_CLACRM').AsString);

              If blnConsEMax And
                (cdsIteger.FieldByName('ITE_ESTMAX').AsFloat > 0) And
                (cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat > cdsIteger.FieldByName('ITE_ESTMAX').AsFloat) Then
              Begin

                If (fltSaldosSug) > 0 Then
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := cdsIteger.FieldByName('ITE_ESTMAX').AsFloat - (fltSaldosSug)
                Else
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := cdsIteger.FieldByName('ITE_ESTMAX').AsFloat;

                If cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat < 0 Then
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

              End;

              If blnAteMax Then
              Begin

                If (cdsIteger.FieldByName('ITE_ESTMAX').AsFloat > 0) Then
                Begin
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := cdsIteger.FieldByName('ITE_ESTMAX').AsFloat - fltSaldosSug;

                  If cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat < 0 Then
                    cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;
                End

                Else cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

              End;

              If blnEmpVis And (Pos(cdsIteger.FieldByName('ITE_CODEMP').AsString, strEmpCal) = 0) Then
                cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0.0;

              If blnEmpVis And (opcChamada = chaSpoolTransferencia) Then
              Begin

                Case slsSaldosDestino Of
                  slsMenorOuIgualZero   : If Not (cdsItensMultiLojas.FieldByName('ITE_SALBAS').AsFloat <= 0) Then
                                            cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

                  slsAbaixoMinimo       : If Not (cdsItensMultiLojas.FieldByName('ITE_SALBAS').AsFloat < cdsIteger.FieldByName('ITE_ESTMIN').AsFloat) Then
                                            cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

                  slsAcimaOuIgualMinimo : If Not (cdsItensMultiLojas.FieldByName('ITE_SALBAS').AsFloat >= cdsIteger.FieldByName('ITE_ESTMIN').AsFloat) Then
                                            cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

                End;

              End;

              If (cdsItensMultiLojas.FieldByName('ITE_CPRCEN').AsString = 'S') And
                 (Pos(cdsItensMultiLojas.FieldByName('ITE_EMPCEN').AsString, strEmpCal) = 0) Then
                cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

              If blnConsMCom Then
              Begin
                If Not fCalcularMultiploNaEmpresaCentralizadora(cdsItensMultiLojas.fieldbyname('ITE_CPRCEN').AsString) Then
                Begin
                  fltSugMult :=  (round(cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat / cdsIteger.fieldbyname('ITE_MLTCOM').asfloat)) * cdsIteger.fieldbyname('ITE_MLTCOM').asfloat;

                  If fltSugMult < cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat Then
                    cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := (round(cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat / cdsIteger.fieldbyname('ITE_MLTCOM').asfloat) + 1) * cdsIteger.fieldbyname('ITE_MLTCOM').asfloat
                  Else
                    cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := fltSugMult;
                End;

                If blnArredSug then
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat  := ceil(cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat);
              End
              Else
              Begin
                If blnArredSug then
                Begin
                  cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat  := ceil(cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat);
                End;
              End;

              Case slfLocFis Of
                slfComLocal: If fEmptyStr(cdsIteger.FieldByName('ITE_LOCFIS').AsString) Then
                               cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

                slfSemLocal: If Not fEmptyStr(cdsIteger.FieldByName('ITE_LOCFIS').AsString) Then
                               cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;
              End;

              If blnPonPed Then
                cdsItensMultiLojas.FieldByName('ITE_ABAPON').AsString := IfThen((fltSaldosSug > cdsIteger.FieldByName('ITE_PONPED').AsFloat), 'S', 'N')
              Else
                cdsItensMultiLojas.FieldByName('ITE_ABAPON').AsString := 'N';

              If cdsItensMultiLojas.FieldByName('ITE_ABAPON').AsString = 'S' Then
                cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

              If blnEmpVis And (Pos(cdsIteger.FieldByName('ITE_CODEMP').AsString, strEmpCal) = 0) Then
                cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

              If blnEmpVis And (opcChamada = chaSpoolTransferencia) Then
              Begin

                Case slsSaldosDestino Of
                  slsMenorOuIgualZero   : If Not (cdsItensMultiLojas.FieldByName('ITE_SALBAS').AsFloat <= 0) Then
                                            cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

                  slsAbaixoMinimo       : If Not (cdsItensMultiLojas.FieldByName('ITE_SALBAS').AsFloat < cdsIteger.FieldByName('ITE_ESTMIN').AsFloat) Then
                                            cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

                  slsAcimaOuIgualMinimo : If Not (cdsItensMultiLojas.FieldByName('ITE_SALBAS').AsFloat >= cdsIteger.FieldByName('ITE_ESTMIN').AsFloat) Then
                                            cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat := 0;

                End;

              End;

              fltSomaIte    := fltSomaIte    + cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat;
              fltSomaIteCal := fltSomaIteCal + cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat;

              If (Not fConsidera_EmpAgr_Vazio(strEmpAgr)) Then
              Begin

                If ((cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString = strEmpAgr) And (Not fConsidera_EmpAgr_Vazio(strEmpAgr)) And blnCprCen) Then
                Begin

                  cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := fltSomaIte;
                  cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat := fltSomaIteCal;
                  cdsItensMultiLojas.FieldByName('ITE_SUGESTORI').AsFloat := fltSomaIteCal;

                  fltSomaCprCen    := fltSomaCprCen    + cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat;
                  fltSomaCprCenCal := fltSomaCprCenCal + cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat;
                End Else
                Begin
                  cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := 0;
                  cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat := 0;
                  cdsItensMultiLojas.FieldByName('ITE_SUGESTORI').AsFloat := 0;
                  fltSomaCprCen    := fltSomaCprCen    + cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat;
                  fltSomaCprCenCal := fltSomaCprCenCal + cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat;

                  blnCprCen     := True;
                End;

              End

              Else If (cdsItensMultiLojas.FieldByName('ITE_CPRCEN').AsString = 'S') And
                      (cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString <> cdsItensMultiLojas.FieldByName('ITE_EMPCEN').AsString) Then

              Begin
                cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := 0;

                pAdicionaCprCen(cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,
                                cdsItensMultiLojas.FieldByName('ITE_EMPCEN').AsString,
                                cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat,
                                cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat,
                                cdsItensMultiLojas.FieldByName('ITE_SALDIS').AsFloat,
                                IIf(blnMedAju, cdsItensMultiLojas.FieldByName('ITE_AJUSTA').AsFloat * (fDiasCompra(recNivEst) / 30),
                                               cdsItensMultiLojas.FieldByName('ITE_MEDIA_').AsFloat * (fDiasCompra(recNivEst) / 30)));
                cdsItensMultiLojas.FieldByName('ITE_QTDCAL').AsFloat := 0;
                cdsItensMultiLojas.FieldByName('ITE_SUGESTORI').AsFloat := 0;
              End Else
              Begin

                cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat;

              End;

              cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat := cdsItensPed.FieldByName('ITE_UNITAR').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat := cdsItensPed.FieldByName('ITE_DESUNI').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_DESUN2').AsFloat := cdsItensPed.FieldByName('ITE_DESUN2').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_DESUN3').AsFloat := cdsItensPed.FieldByName('ITE_DESUN3').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_DESUN4').AsFloat := cdsItensPed.FieldByName('ITE_DESUN4').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_DESUN5').AsFloat := cdsItensPed.FieldByName('ITE_DESUN5').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_DESUN6').AsFloat := cdsItensPed.FieldByName('ITE_DESUN6').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_UNILIQ').AsFloat :=
                 RoundTo(cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN2').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN3').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN4').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN5').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN6').AsFloat / 100), -intDecUni);

              cdsItensMultiLojas.FieldByName('ITE_DIFPRE').AsFloat  := Iif(cdsItensMultiLojas.FieldByName('ITE_PREULT').AsFloat = 0, 0, (((cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat - cdsItensMultiLojas.FieldByName('ITE_PREULT').AsFloat) / cdsItensMultiLojas.FieldByName('ITE_PREULT').AsFloat) * 100));

              cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat :=
                 RoundTo(cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN2').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN3').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN4').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN5').AsFloat / 100)
                   * (1 - cdsItensMultiLojas.FieldByName('ITE_DESUN6').AsFloat / 100), -intDecUni) *
                 cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat := cdsItensPed.FieldByName('ITE_PERIPI').AsFloat;
              cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat := cdsItensPed.FieldByName('ITE_PERSUB').AsFloat;

              pCopiaAliquotasReforma(cdsItensPed, cdsItensMultiLojas, False);

              cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat :=  cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat;

              cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat := cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat *
                                                                      cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat / 100;

              If strFRMPCM  = '1' Then
                cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat := (cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat +
                                                                         cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat) *
                                                                        cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat / 100
              Else
                cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat *
                                                                        cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat / 100;

              cdsItensMultiLojas.FieldByName('ITE_CPCEMO').AsString := IfThen(cdsIteger.FieldByName('ITE_CPRCEN').AsString='S', 'C', 'I');
              cdsItensMultiLojas.FieldByName('ITE_LOCFIS').AsString := cdsIteger.FieldByName('ITE_LOCFIS').AsString;
              cdsItensMultiLojas.FieldByName('ITE_ESMIDG').AsString := cdsIteger.FieldByName('ITE_ESMIDG').AsString;

              {*****************************************}
              {* SOMA NOS ITENS SINTETIZADOS           *}
              {**************************************MV*}
              If (Not blnEmpVis) Or (Pos(cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString, strEmpCal) > 0) Then
              Begin
                cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat := cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_QTEF_F').AsFloat;

                cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat := cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_QTEF_A').AsFloat;

                cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat := cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_QTEF_P').AsFloat;

                cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat := cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_QTPD_P').AsFloat;

                cdsItensPed.FieldByName('ITE_SALDOS').AsFloat := cdsItensPed.FieldByName('ITE_SALDOS').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_SALDOS').AsFloat;

                cdsItensPed.FieldByName('ITE_SALDIS').AsFloat := cdsItensPed.FieldByName('ITE_SALDIS').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_SALDIS').AsFloat;

                cdsItensPed.FieldByName('ITE_SALEXT').AsFloat := cdsItensPed.FieldByName('ITE_SALEXT').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_SALEXT').AsFloat;

                cdsItensPed.FieldByName('ITE_SALFIS').AsFloat := cdsItensPed.FieldByName('ITE_SALFIS').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_SALFIS').AsFloat;

                cdsItensPed.FieldByName('ITE_INIBAS').AsFloat := cdsItensPed.FieldByName('ITE_INIBAS').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_INIBAS').AsFloat;

                cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat := cdsItensPed.FieldByName('ITE_ESTMIN').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_ESTMIN').AsFloat;

                cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat := cdsItensPed.FieldByName('ITE_ESTMAX').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_ESTMAX').AsFloat;

                cdsItensPed.FieldByName('ITE_MINDIG').AsFloat := cdsItensPed.FieldByName('ITE_MINDIG').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_MINDIG').AsFloat;

                cdsItensPed.FieldByName('ITE_MAXDIG').AsFloat := cdsItensPed.FieldByName('ITE_MAXDIG').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_MAXDIG').AsFloat;

                cdsItensPed.FieldByName('ITE_PONPED').AsFloat := cdsItensPed.FieldByName('ITE_PONPED').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_PONPED').AsFloat;

                cdsItensPed.FieldByName('ITE_SUGEST').AsFloat := cdsItensPed.FieldByName('ITE_SUGEST').AsFloat +
                                                                 cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat;

                cdsItensPed.FieldByName('ITE_QTDPEN').AsFloat := cdsItensPed.FieldByName('ITE_QTDPEN').AsFloat +
                                                                   cdsIteger.FieldByName('ITE_QTDPEN').AsFloat;

                cdsItensPed.FieldByName('ITE_SALREQ').AsFloat := cdsItensPed.FieldByName('ITE_SALREQ').AsFloat +
                                                                   cdsIteger.FieldByName('ITE_SALREQ').AsFloat;

                cdsItensPed.FieldByName('ITE_SALRES').AsFloat := cdsItensPed.FieldByName('ITE_SALRES').AsFloat +
                                                                   cdsIteger.FieldByName('ITE_SALRES').AsFloat;

                cdsItensPed.FieldByName('ITE_PONEXP').AsFloat := cdsItensPed.FieldByName('ITE_PONEXP').AsFloat +
                                                                   cdsIteger.FieldByName('ITE_PONEXP').AsFloat;

                cdsItensPed.FieldByName('ITE_VENPER').AsFloat := cdsItensPed.FieldByName('ITE_VENPER').AsFloat +
                                                                   fRetQtdVenPer(cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,
                                                                                 cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString,
                                                                                 cdsItensMultiLojas.FieldByName('ITE_NVLGIR').AsString);

                cdsItensPed.FieldByName('ITE_SALGAR').AsFloat := cdsItensPed.FieldByName('ITE_SALGAR').AsFloat +
                                                                   cdsIteger.FieldByName('ITE_SALGAR').AsFloat;

                cdsItensPed.FieldByName('ITE_SALTRA').AsFloat := cdsItensPed.FieldByName('ITE_SALTRA').AsFloat +
                                                                   cdsIteger.FieldByName('ITE_SALTRA').AsFloat;

                cdsItensPed.FieldByName('ITE_SALEND').AsFloat := cdsItensPed.FieldByName('ITE_SALEND').AsFloat +
                                                                   cdsIteger.FieldByName('ITE_SALEND').AsFloat;

                cdsItensPed.FieldByName('ITE_SALCOT').AsFloat := cdsItensPed.FieldByName('ITE_SALCOT').AsFloat +
                                                                   fRetQtdCotacao(cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,
                                                                                  cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString);

                cdsItensPed.FieldByName('ITE_SALBAS').AsFloat := cdsItensPed.FieldByName('ITE_INIBAS').AsFloat -
                                                                                 ( IfThen(blnConsPedVen, cdsItensPed.FieldByName('ITE_SALRES').AsFloat, 0) +

                                                                                   IfThen(blnDescSalExt, cdsIteger.FieldByName('ITE_SALEXT').AsFloat, 0) +

                                                                                   IfThen(blnConsOrdPro, cdsItensPed.FieldByName('ITE_QTPD_P').AsFloat, 0) +

                                                                                   IfThen(blnConsGarPen, cdsItensPed.FieldByName('ITE_SALGAR').AsFloat, 0) +

                                                                                   IfThen(blnEntFutAguarda,  cdsItensPed.FieldByName('ITE_QTEF_A').AsFloat, 0) +
                                                                                   IfThen(blnEntFutFalta,    cdsItensPed.FieldByName('ITE_QTEF_F').AsFloat, 0) +
                                                                                   IfThen(blnEntFutPrevisao, cdsItensPed.FieldByName('ITE_QTEF_P').AsFloat, 0) +

                                                                                   IfThen(blnVenPer, cdsItensPed.FieldByName('ITE_VENPER').AsFloat, 0)
                                                                                   ) +

                                                                                  IfThen(blnConsTransf, cdsItensPed.FieldByName('ITE_SALTRA').AsFloat, 0) +
                                                                                  IfThen(blnConsCot,    cdsItensPed.FieldByName('ITE_SALCOT').AsFloat, 0) +
                                                                                  IfThen(blnConsPedPen, cdsItensPed.fieldbyname('ITE_QTDPEN').asfloat, 0) -
                                                                                  IfThen(blnConsRequisicao, cdsItensPed.fieldbyname('ITE_SALREQ').asfloat, 0);
              End;

              If fEmptyStr(cdsItensPed.FieldByName('ITE_ABAPON').AsString) Then
                cdsItensPed.FieldByName('ITE_ABAPON').AsString := 'S';

              If cdsItensPed.FieldByName('ITE_ABAPON').AsString = 'N' Then
                cdsItensPed.FieldByName('ITE_ABAPON').AsString := 'N';

              pCalculaSaldoParaEmpresaDoAgrupamento(cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString);
            End; {If cdsIteger.FindKey([strItemAtu, lstEmpresas[intIdxEmp]]) Then}

            If cdsItensMultiLojas.FieldByName('ITE_QTDEMB').IsNull Or (cdsItensMultiLojas.FieldByName('ITE_QTDEMB').AsFloat = 0) Then
              cdsItensMultiLojas.FieldByName('ITE_QTDEMB').AsFloat := 1;

            If cdsItensMultLojas.FieldByName('ITE_QTDTRA').IsNull Then
              cdsItensMultLojas.FieldByName('ITE_QTDTRA').AsFloat := 0;

            pCalculaVariacaoCompra(cdsItensMultLojas);

            cdsItensMultiLojas.Post;
            pZeraQuantidadeDoItemAtualCasoNecessario;

          End; {If (Pos(lstEmpresas[intIdxEmp], strEmpUsadas) <= 0) Then}

        End; {For intIdxEmp := 0 To lstEmpresas.Count -1 Do}

        If cdsIteger.FindKey([strItemAtu, lstEmpresas[0]]) Then
        Begin

          If (blnCprCen) Then
          Begin

            If (Not fEmptyStr(strEmpAgr)) Then
            Begin
              cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := fltSomaIte;
              cdsItensPed.FieldByName('ITE_QTDINC').AsFloat := fltSomaIte;
              cdsItensPed.FieldByName('ITE_QTDCAL').AsFloat := fltSomaIteCal;
              cdsItensPed.FieldByName('ITE_SUGESTORI').AsFloat := fltSomaIteCal;
            End

            Else pFinalizaCompraCentraliza(cdsItensPed.FieldByName('ITE_CODITE').AsString);

          End Else
          Begin
            cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := cdsItensPed.FieldByName('ITE_SUGEST').AsFloat;
            cdsItensPed.FieldByName('ITE_QTDINC').AsFloat := cdsItensPed.FieldByName('ITE_SUGEST').AsFloat;
          End;

          cdsItensPed.FieldByName('ITE_TOTITE').AsFloat :=
            cdsItensPed.FieldByName('ITE_QTDITE').AsFloat *
            RoundTo(cdsItensPed.FieldByName('ITE_UNITAR').AsFloat
               * (1 - cdsItensPed.FieldByName('ITE_DESUNI').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN2').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN3').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN4').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN5').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN6').AsFloat / 100), -intDecUni);

          cdsItensPed.FieldByName('ITE_UNILIQ').AsFloat :=
            RoundTo(cdsItensPed.FieldByName('ITE_UNITAR').AsFloat
               * (1 - cdsItensPed.FieldByName('ITE_DESUNI').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN2').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN3').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN4').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN5').AsFloat / 100)
               * (1 - cdsItensPed.FieldByName('ITE_DESUN6').AsFloat / 100), -intDecUni);

          cdsItensPed.FieldByName('ITE_DIFPRE').AsFloat  := Iif(cdsItensPed.FieldByName('ITE_PREULT').AsFloat = 0, 0, (((cdsItensPed.FieldByName('ITE_UNITAR').AsFloat - cdsItensPed.FieldByName('ITE_PREULT').AsFloat) / cdsItensPed.FieldByName('ITE_PREULT').AsFloat) * 100));

          cdsItensPed.FieldByName('ITE_LITROS').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat *
                                                           cdsIteger.FieldByName('UNI_PESLIT').AsFloat;

          If SameText(strLitGal, 'G') Then
            cdsItensPed.FieldByName('ITE_LITROS').AsFloat := cdsItensPed.FieldByName('ITE_LITROS').AsFloat / FLT_LITRO_GALAO;

          cdsItensPed.FieldByName('ITE_PESOIT').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat *
                                                           cdsIteger.FieldByName('ITE_PESOIT').AsFloat;

          cdsItensPed.FieldByName('ITE_BASIPI').AsFloat := cdsItensPed.FieldByName('ITE_TOTITE').AsFloat;

          cdsItensPed.FieldByName('ITE_TOTIPI').AsFloat := cdsItensPed.FieldByName('ITE_BASIPI').AsFloat *
                                                         cdsItensPed.FieldByName('ITE_PERIPI').AsFloat / 100;

          pCalculaImpostosReformaItem(cdsItensPed, False);
          If strFRMPCM  = '1' Then
            cdsItensPed.FieldByName('ITE_TOTSUB').AsFloat := (cdsItensPed.FieldByName('ITE_TOTITE').AsFloat +
                                                              cdsItensPed.FieldByName('ITE_TOTIPI').AsFloat)*
                                                             cdsItensPed.FieldByName('ITE_PERSUB').AsFloat / 100
          Else
            cdsItensPed.FieldByName('ITE_TOTSUB').AsFloat := cdsItensPed.FieldByName('ITE_TOTITE').AsFloat *
                                                             cdsItensPed.FieldByName('ITE_PERSUB').AsFloat / 100;

        End; {If cdsIteger.FindKey([strItemAtu, lstEmpresas[0]]) Then}

        cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat := RoundTo(cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat, -4);
        cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat := RoundTo(cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat, -4);
        cdsItensPed.FieldByName('ITE_MEDAJU').AsFloat := RoundTo(cdsItensPed.FieldByName('ITE_MEDAJU').AsFloat, -4);

        If IfThen(blnMedAju, cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat, cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat) > 0 Then
        Begin
          cdsItensPed.FieldByName('ITE_DIAEST').AsInteger := Trunc(RoundTo(cdsItensPed.FieldByName('ITE_SALBAS').AsFloat /
                                                                   (IfThen(blnMedAju, cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat,
                                                                                   cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));

          cdsItensPed.FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((cdsItensPed.FieldByName('ITE_SALBAS').AsFloat +
                                                                    cdsItensPed.FieldByName('ITE_QTDITE').AsFloat) /
                                                                   (IfThen(blnMedAju, cdsItensPed.FieldByName('ITE_AJUSTA').AsFloat,
                                                                                   cdsItensPed.FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));
        End Else
        Begin
          cdsItensPed.FieldByName('ITE_DIAEST').Clear;
          cdsItensPed.FieldByName('ITE_DIASUG').Clear;
        End;

        pAcertaCorPedido(cdsItensPed, fltLimAma, fltLimVer);

        If cdsItensPed.FieldByName('ITE_QTDEMB').IsNull Or (cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat = 0) Then
          cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat := 1;

        If cdsItensPed.FieldByName('ITE_QTDTRA').IsNull Then
          cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat := 0;

        pCalculaVariacaoCompra(cdsItensPed);

        cdsItensPed.FieldByName('ITE_TRAINC').AsFloat := cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat;

        cdsItensPed.FieldByName('ITE_QTDALT').AsString := 'N';

        cdsItensPed.Post;

      End;

      If (Assigned(bkmRegAtual)) Then
      Begin
        cdsTmpMlj.GotoBookmark(bkmRegAtual);
        pgbProgresso.Position := fltPosRegAtual;
      End Else
      Begin
        cdsTmpMlj.Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;
    End;

    If (blnCprCen) Then
    Begin

      If ((Not fConsidera_EmpAgr_Vazio(strEmpAgr)) And cdsItensMultiLojas.FindKey([strItemAtu, strEmpAgr])) Then
      Begin
        If (Not cdsItensPed.IsEmpty) And
           (cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString <> cdsItensPed.FieldByName('ITE_CODITE').AsString) Then
          cdsItensPed.Locate('ITE_CODITE', cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString, []);

        pAjustaCompraCentraLizada(fltSomaCprCen, fltSomaCprCenCal, 0, fltExtExc, cdsItensMultiLojas, cdsItensPed, intDecUni, False);
      End

      Else If fConsidera_EmpAgr_Vazio(strEmpAgr) Then
      Begin
        pFinalizaCompraCentraliza(strItemAtu);
      End;

    End;

  End; {While (Not cdsTmpMlj.Eof) Do}

  If (strEmpAgr = 'Cen') And (Not blnSugInd) And  (Not blnAllIte)  And fEmptyStr(strNumPedAlt) Then
  Begin
    cdsItensPed.First;
    While not cdsItensPed.Eof Do
    Begin
      If cdsItensPed.FieldByName('ITE_SUGEST').AsFloat = 0 Then
      Begin
        cdsItensMultiLojas.First;
        While cdsItensMultiLojas.Locate('ITE_CODITE', cdsItensPed.FieldByName('ITE_CODITE').AsString, []) Do
          cdsItensMultiLojas.Delete;
        cdsItensPed.Delete;
      End
      Else
        cdsItensPed.Next;
    End;
  End;

  pLiberaComps;
end;

{*****************************************}
{* VERIFICA SE UM PEDIDO ESTÁ BAIXADO.   *}
{**************************************MV*}
function fVerificaPedidoBaixado(strNumPed, strEspDoc, strCodEmp: String; Var blnConferido: Boolean; Var AblnOrcamentoGeradoAutomaticamente: Boolean): Boolean;
  Var
    strSQL   : String;
    qryGenDet: TUniQuery;
begin
  blnConferido := FALSE;
  Try
    qryGenDet := fCriaQuery;

    Result := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT  SQL_NO_CACHE ';
    strSQL := strSQL + '  PCG_DTALIB, ';
    strSQL := strSQL + '  PCG_OBS001 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'INNER JOIN PCMGER ON          ';
    strSQL := strSQL + '  PCG_NUMPED = PCD_NUMPED AND ';
    strSQL := strSQL + '  PCG_CODEMP = PCD_CODEMP AND ';
    strSQL := strSQL + '  PCG_ESPDOC = PCD_ESPDOC     ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMCTN = 0 AND ' ;
    strSQL := strSQL + '  PCG_BAIXAD = 0 AND ';
    strSQL := strSQL + '  PCD_BAIXAD = 0 AND ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP ';

    With qryGenDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      If (strCodEmp = VS_strCodEmp) Then
      Begin
        ParamByName('CODEMP').AsString := VS_strCodEmp;
      End
      Else
      Begin
        ParamByName('CODEMP').AsString := strCodEmp;
      End;

      Open;

      Result := IsEmpty;

      If Not Result Then
      Begin
        blnConferido := Not FieldByName('PCG_DTALIB').IsNull;
        AblnOrcamentoGeradoAutomaticamente := (Pos('GERAÇÃO DE ORÇAMENTO DE COMPRA AUTOMÁTICO', FieldByName('PCG_OBS001').AsString) > 0);
      End;

      Close;

    End;

  Finally
    FreeAndNil(qryGenDet);
  End;
end;

{*****************************************}
{* VERIFICA SE UM PEDIDO TENHA QUALQUER  *}
{* TIPO DE BAIXA                         *}
{**************************************GB*}
function fVerificaPedidoBaixadoOuBaixaParcial(strNumPed, strEspDoc, strCodEmp: String): Boolean;
  Var
    strSQL   : String;
    qryGenDet: TUniQuery;
Begin
  Try
    qryGenDet := fCriaQuery;

    Result := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT  SQL_NO_CACHE ';
    strSQL := strSQL + '  SUM(PCD_QTDBAI) AS PCD_QTDBAI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMCTN = 0 AND ' ;
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP ';

    With qryGenDet Do
    Begin
      If fEmptyStr(strCodEmp) Then
        strCodEmp := VS_strCodEmp;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      Result := (FieldByName('PCD_QTDBAI').AsFloat > 0);

    End;
  Finally
    FreeAndNil(qryGenDet);
  End;
End;

{****************************}
{* IMPRIME PEDIDO DE COMPRA *}
{*************************AF*}
procedure pImprimePedidoCompra(strNumPed,
                               strEspDoc,
                               strCodEmp: String);
  Var
    qryModelo: TUniQuery;
    strCodLay: String;
    strCodFor: String;
Begin
  qryModelo := fCriaQuery;
  Try
    qryModelo.SQL.Add('SELECT LAY_CODLAY FROM LAYETI');
    qryModelo.SQL.Add(' WHERE LAY_TIPLAY = "214"');
    qryModelo.SQL.Add('   AND LAY_PADRAO = "S"');
    qryModelo.SQL.Add('   AND LAY_CODEMP = "'+strCodEmp+'"');
    qryModelo.Open;
    If qryModelo.IsEmpty Then
    Begin
      pMensagemOk('Não existe layout configurado para esta impressão!');
      Exit;
    End;
    strCodLay := qryModelo.FieldByName('LAY_CODLAY').AsString;


    qryModelo.SQL.Clear;
    qryModelo.SQL.Add('SELECT PCG_CODFOR FROM PCMGER WHERE PCG_NUMPED = "'+strNumPed+'" AND PCG_ESPDOC = "'+strEspDoc+'" AND PCG_CODEMP = "'+strCodEmp+'"');
    qryModelo.Open;
    strCodFor := qryModelo.FieldByName('PCG_CODFOR').AsString;


    TImpressaoPedidoLayout.fNovo
             .fCodFor(strCodFor)
             .fCodEmp(strCodEmp)
             .fNumPed(strNumPed)
             .fEspDoc(strEspDoc)
             .fVisPDF(True)
             .fQtdPen(False)
             .fZonaFranca(fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')))
             .fMltCom(False)
             .fCodLay(strCodLay)
             .fNomImp('')
             .fTipImp('')
             .fVaiGerarAquivoPDF(False)
             .fGerarPDF;

  Finally
    FreeAndNil(qryModelo);
  End;
End;

Procedure pImprimeBoletimRecebimento(strNumPed, strEspDoc, strCodEmp: String;
  intQtdVias: Integer; opcBoletimRec: TOpcBoletimRecebimento = tobrPadrao);
  Var
    qryPedido: TUniQuery;
    strNomeFila: String;
    strTipImp: String;
    frxBoletim: TfrxReport;

  Procedure pCarregaFila;
    Var
      qryCfgRel: TUniQuery;
  Begin
    qryCfgRel := fCriaQuery;
    pCarregaConfImpr(qryCfgRel, 'frmPedidoDeCompra');
    strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    If Not fEmptyStr(strNomeFila) Then
      fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
    FreeAndNil(qryCfgRel);
  End;

Begin
  qryPedido := fCriaQuery;

  With qryPedido, SQL Do
  Begin
    Add('SELECT ');
    Add(' PCD_DTAPED AS DTAPED,');
    Add(' PCD_DTAENT AS DTAENT,');
    Add(' PCD_CODEMP AS CODEMP,');
    Add(' EMP_NOMEMP AS NOMEMP,');
    Add(' PCD_CODFOR AS CODFOR,');
    Add(' FOR_NOMFOR AS NOMFOR,');
    Add(' PCD_CODITE AS CODITE,');
    Add(' PCD_DESITE AS DESITE,');
    Add(' UNI_SIGUNI AS SIGUNI,');
    Add(' C.ITE_CODBAR AS CODBAR,');
    Add(' IF(F.ITE_CODITE IS NULL, C.ITE_CODFAB, F.ITE_CODFAB) AS CODFAB');

    Add('FROM ');
    Add('  PCMDET');

    Add('INNER JOIN CADFOR ON PCD_CODFOR = FOR_CODFOR ');
    Add('INNER JOIN CADITE C ON C.ITE_CODITE = PCD_CODITE ');
    Add('LEFT  JOIN CADUNI ON UNI_CODUNI = C.ITE_CODUNI ');
    Add('INNER JOIN CADEMP ON PCD_CODEMP = EMP_CODEMP ');

    Add('LEFT JOIN ITEFOR F ON F.ITE_CODITE = PCD_CODITE AND ');
    Add('                      F.ITE_CODFOR = PCD_CODFOR AND ');
    Add('                     (SELECT COUNT(*) FROM TABPRE   ');
    Add('                      WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ');

    Add('WHERE');

    Add('	PCD_NUMCTN = 0 AND       ');
    Add('	PCD_NUMPED = :NUMPED AND ');
    Add('	PCD_ESPDOC = :ESPPED AND ');
    Add(' PCD_CODEMP = :CODEMP     ');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('ESPPED').AsString := strEspDoc;

    Open;

    pCriarFormularios(TfrmQckBoletimRec, frmQckBoletimRec);

    If (opcBoletimRec = tobrPadrao) Then
    Begin
      With frmQckBoletimRec, frxReport Do
      Begin
        If fCfgSis('TIPFOL') = '2' Then
        Begin
          TfrxDMPPage(frmQckBoletimRec.frxReport.FindObject('qckPagina')).PaperHeight := 292.364394514662;
          TfrxDMPCommand(frmQckBoletimRec.frxReport.FindObject('DMPCommand1')).Command := '#27#64#27#67#65';
        End;

        frxDBRel.DataSet := qryPedido;

        pCarregaFila;

        Script.Variables['NOMEMP']     := fRetNomeEmpresa;
        Script.Variables['NOMREL']     := 'BOLETIM DE RECEBIMENTO';
        Script.Variables['EMPRESA']    := 'EMPRESA     : ' + FieldByName('CODEMP').AsString + ' - ' +
                                                             FieldByName('NOMEMP').AsString;
        Script.Variables['FORNECEDOR'] := 'FORNECEDOR  : ' + FieldByName('CODFOR').AsString + ' - ' +
                                                             FieldByName('NOMFOR').AsString;
        Script.Variables['PEDIDO']     := 'PEDIDO      : ' + strNumPed + ' - ' + strEspDoc;
        Script.Variables['DTAPED']     := 'DATA PEDIDO : ' + FormatDateTime('DD/MM/YYYY', FieldByName('DTAPED').AsDateTime);
        Script.Variables['DTAENT']     := 'DATA ENTREGA: ' + FormatDateTime('DD/MM/YYYY', FieldByName('DTAENT').AsDateTime);

        If PrepareReport Then
          If fEmptyStr(strNomeFila) Then
            pPreviewReport('frmPedidoDeCompra', 'Impressão Boletim de Recebimento ('+strNumPed+')', frxReport)
          Else
          Begin
            PrintOptions.Copies     := intQtdVias;
            PrintOptions.ShowDialog := False;
            PrintOptions.Printer    := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');
            pPrintReport('frmPedidoDeCompra', 'Impressão Boletim de Recebimento ('+strNumPed+')', strNomeFila, frxReport);
          End;

      End;
    End
    Else
    Begin
      If (opcBoletimRec = tobrRetrato) Then
        frxBoletim := frmQckBoletimRec.frxReportA4Retrato
      Else
        frxBoletim := frmQckBoletimRec.frxReportA4Paisagem;

      Try
        frmQckBoletimRec.frxDBRel.DataSet := qryPedido;

        pCarregaFila;

        frxBoletim.Script.Variables['NOMEMP']     := fRetNomeEmpresa;
        frxBoletim.Script.Variables['NOMREL']     := 'BOLETIM DE RECEBIMENTO';
        frxBoletim.Script.Variables['PEDIDO']     := strNumPed + ' - ' + strEspDoc;

        If frxBoletim.PrepareReport Then
          If fEmptyStr(strNomeFila) Then
            pPreviewReport('frmPedidoDeCompra', 'Impressão Boletim de Recebimento ('+strNumPed+')', frxBoletim)
          Else
          Begin
            frxBoletim.PrintOptions.Copies     := intQtdVias;
            frxBoletim.PrintOptions.ShowDialog := False;
            frxBoletim.PrintOptions.Printer    := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');
            pPrintReport('frmPedidoDeCompra', 'Impressão Boletim de Recebimento ('+strNumPed+')', strNomeFila, frxBoletim);
          End;
      Finally
        FreeAndNil(frxBoletim);
      End;
    End;

    FreeAndNil(frmQckBoletimRec);

    Close;
  End;

  FreeAndNil(qryPedido);
End;

function fCarregaPedCom(qryPcmGer: TUniQuery; strNumPed, strEspDoc, strCodEmp: String): Boolean;
begin
  Result := True;
  With qryPcmGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT  SQL_NO_CACHE ');
    SQL.Add('  * ');
    SQL.Add('FROM ');
    SQL.Add('  PCMGER G');
    SQL.Add('  INNER JOIN CADEMP ED ON ED.EMP_CODEMP = IF(IFNULL(G.PCG_EMPDES, "") = "", G.PCG_CODEMP, G.PCG_EMPDES) ');
    SQL.Add('  LEFT JOIN CADCID    ON ED.EMP_CODCID = CID_CODCID ');

    SQL.Add('WHERE ');
    SQL.Add('  PCG_NUMPED = :NUMPED AND ');
    SQL.Add('  PCG_ESPDOC = :ESPDOC AND ');
    SQL.Add('  PCG_CODEMP = :CODEMP ');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If IsEmpty Then
      Result := False;
  End;

end;

procedure pArqATigreExcel(strNumPed, strEspDoc, strCodEmp: String; blnEsconderMensagem: Boolean = False);
  Var
    strSQL   : String;
    qryGen   : TUniQuery;
    objExcel : TGeraExcel;
Begin
  Try
    Screen.Cursor := crHourGlass;
    qryGen := fCriaQuery(Nil);
    objExcel := TGeraExcel.Create(qryGen, nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT  SQL_NO_CACHE ';
    strSQL := strSQL + '   PCD_QTDITE, ';
    strSQL := strSQL + '   IF(F.ITE_CODITE IS NULL, C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   PCMDET ';
    strSQL := strSQL + '   JOIN CADITE C ON (PCD_CODITE = C.ITE_CODITE) ';

    strSQL := strSQL + '   LEFT JOIN ITEFOR F ON F.ITE_CODITE = PCD_CODITE AND ';
    strSQL := strSQL + '                         F.ITE_CODFOR = PCD_CODFOR AND ';
    strSQL := strSQL + '                         (SELECT COUNT(*) FROM TABPRE  ';
    strSQL := strSQL + '                          WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '   PCD_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   PCD_CODEMP = :CODEMP ';

    With qryGen, objExcel.objExcel do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      objExcel.objExcel.CriarArquivo;

      objExcel.objExcel.LinhaAtual := 1;

      Escrever(objExcel.objExcel.LinhaAtual, 1, 'COD. FABRICA');
      Escrever(objExcel.objExcel.LinhaAtual, 2, 'QUANTIDADE');

      First;
      While Not Eof Do
      Begin
        ProximaLinha;

        FormatoNumerico(LinhaAtual, 1, '@');
        Escrever(LinhaAtual, 1, FieldByName('ITE_CODFAB').AsString);

        FormatoNumerico(LinhaAtual, 2);
        Escrever(LinhaAtual, 2, FieldByName('PCD_QTDITE').AsFloat);

        Next;
      End;

      AutoAjuste;
      LinhaAtual := 1;
      SalvarArquivo;
      FecharArquivo;
    End;
    If not blnEsconderMensagem Then
      fMensagem('','Arquivo gerado com sucesso!',['&OK']);

  Finally
    Screen.Cursor := crDefault;
    FreeAndNil(qryGen);
    FreeAndNil(objExcel);
  End;

End;

{*****************************************}
{* IMPRIME O PEDIDO DE ACORDO COM AS     *}
{* OPÇÕES SELECIONADAS (JATO OU TXT).    *}
{**************************************MV*}
procedure pImprimirPedido(RecOpcaoImpressao: TRecOpcaoImpressao;
                          strNumPed,
                          strEspDoc,
                          strCodEmp: String;
                      var strPath: string;
                      var strNomeFila: string;
                      var strTipImp: string;
                          blnReimpr: Boolean = False;
                          strCondPagBosh: string = '';
                          blnEsconderMensagem: boolean = False;
                          blnVeSePodeImprimir: Boolean = True;
                          blnCarregarFila: Boolean = True;
                          blnExcRes: Boolean = False);
  Var
    strCodEmpDest: String;
    qryPcmGer: TUniQuery;
    qryCfgRel: TUniQuery;
    strParametro,
    strNomeArquivo: String;
    blnDarRor: Boolean;

    strDtaFat,
    strCndPag: String;
    dtaDtaAux: TDate;
    arrDuplicata: TarrDuplicata;
    intQtdPar: Integer;
    curVTotal: Currency;
    intContador: Integer;
    strDtaVen, ArquivoPDF, pasta: String;

begin

  qryPcmGer := fCriaQuery(Nil);
  fCarregaPedCom(qryPcmGer, strNumPed, strEspDoc, strCodEmp);
  //Se Empresa Destino = "" Então Pega a Empresa do Pedido senão Empresa de Destino
  strCodEmpDest := IfThen(fEmptyStr(qryPcmGer.FieldByName('PCG_EMPDES').AsString),
                       qryPcmGer.FieldByName('PCG_CODEMP').AsString,
                       qryPcmGer.FieldByName('PCG_EMPDES').AsString);


  strDtaFat := qryPcmGer.FieldByName('PCG_DTAFAT').AsString;
  strCndPag := qryPcmGer.FieldByName('PCG_CONPAG').AsString;

  If (RecOpcaoImpressao.blnImpDtaVen) And (strDtaFat <> '') Then
  Begin
    pZeraDigDuplic(arrDuplicata);
    If VS_Date > StrToDate(strDtaFat) Then
      dtaDtaAux := VS_Date
    Else
      dtaDtaAux := StrToDate(strDtaFat);

    fDigDuplicSemTela(arrDuplicata,
                      intQtdPar,
                      curVTotal,
                      strCndPag,
                      0,
                      0,
                      False,
                      False,
                      dtaDtaAux,
                      False);

    For intContador := 0 To Length(arrDuplicata)-1 Do
    Begin
      If Not fEmptyStr(arrDuplicata[intContador].dtaDtaVen) Then
      Begin
        If (intContador = 0) Then
          strDtaVen := arrDuplicata[intContador].dtaDtaVen
        Else
          strDtaVen := strDtaVen + ' / '+ arrDuplicata[intContador].dtaDtaVen;
      End;
    End;
  End;


  If blnVeSePodeImprimir And
     (strEspDoc = 'PD') And
     (fCfgSis('LIBPCM', varBoolean)) And
     (Not fPedidoCompraLiberado(strNumPed,strCodEmp)) And
     (Not fCfgSis('LIBIMP', varBoolean)) Then
  Begin
    fMensagem('Atenção!', 'O Pedido de compra não está liberado, por isso não será impresso.', ['&OK']);
    Exit;
  End;


  Case RecOpcaoImpressao.intOpcao Of

    1,20: Begin
         If RecOpcaoImpressao.intOpcao <> 20 Then
         Begin
           If blnCarregarFila Then
           Begin
             qryCfgRel := fCriaQuery;
             pCarregaConfImpr(qryCfgRel, 'frmPedidoDeCompra');
             if RecOpcaoImpressao.intQtdVias > 0 Then
               fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
             FreeAndNil(qryCfgRel);
           End;
         End;


         If RecOpcaoImpressao.strCodLay = '' Then
         Begin
           blnDarRor := fCfgSis('DARROR', varBoolean);
           RecOpcaoImpressao.strTipExp := 'PDF';
           RecOpcaoImpressao.ShowReport := RecOpcaoImpressao.intOpcao <> 20;

           TGeraEmail.fGeraEmail(RecOpcaoImpressao,
                                 strNumPed,
                                 strEspDoc,
                                 strCodEmpDest,
                                 strCodEmp,
                                 blnDarRor,
                                 strNomeArquivo,
                                 False,
                                 nil,
                                 strNomeFila);
           If RecOpcaoImpressao.intOpcao = 20 Then
           begin
             fMensagem('','Arquivo ' + strNomeArquivo + ' gerado com sucesso!', ['&Ok']);
             pExecArquivo(strNomeArquivo, 0);
           End;
         End
         Else
         Begin
           pasta := '';
           if RecOpcaoImpressao.intOpcao = 20 then
           begin
             pasta := IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'OR' , 'OrcamentoCompra', 'PedidoCompra');
             If Not DirectoryExists(ExtractFilePath(Application.ExeName) + pasta) Then
                CreateDir(ExtractFilePath(Application.ExeName) + pasta);

           end;

           Try
             ArquivoPDF :=   TImpressaoPedidoLayout
                 .fNovo
                 .fCodFor(RecOpcaoImpressao.strCodFor)
                 .fCodEmp(strCodEmp)
                 .fNumPed(strNumPed)
                 .fEspDoc(strEspDoc)
                 .fVisPDF(True)
                 .fQtdPen(RecOpcaoImpressao.tipQtdIte = tqpPendente)
                 .fZonaFranca(fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')))
                 .fMltCom(RecOpcaoImpressao.blnMltCmp)
                 .fDataDeVencimento(strDtaVen)
                 .fCodLay(RecOpcaoImpressao.strCodLay)
                 .fNomImp(strNomeFila)
                 .fTipImp(strTipImp)
                 .fVaiGerarAquivoPDF(RecOpcaoImpressao.intOpcao = 20)
                 .fGerarPDF(pasta)
                 .fCaminhoPDF;

             if RecOpcaoImpressao.intOpcao = 20 then
               fMensagem('','Arquivo ' + ArquivoPDF + ' gerado com sucesso!', ['&Ok']);




           Except

           End;
         End;
         if RecOpcaoImpressao.intOpcao <> 20 then
         begin
          strParametro := '';
          If RecOpcaoImpressao.blnResumoMarca Then
           strParametro := strParametro + '14:Litragem Marca';
          If RecOpcaoImpressao.blnResumoReferencia Then
           strParametro := strParametro + '10:Referência';
          If RecOpcaoImpressao.blnResumoUnidade Then
           strParametro := strParametro + '7:Unidade';
          If RecOpcaoImpressao.blnResumoGrupo Then
           strParametro := strParametro + '17:Grupo de Produtos';
          If RecOpcaoImpressao.blnResumoAcordoObjetivo Then
           strParametro := strParametro + '19:Acordo de Objetivos';

          If strParametro <> '' Then
           prcExecutaRelatorio(426, 11453, [],
                     ['NUMPED','ESPDOC','CODEMP','TIPREL'],
                     [strNumPed,
                     strEspDoc,
                     strCodEmp,
                     '(IN);'+strParametro],
                     nil,
                     nil,
                     True);

         end;
       End;

    2: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetstrPath(strPath);
          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(290, 9221, [9222,9223,9224,9225,9226,9227],
                      ['NUMPED','ESPDOC','CODEMP','EMPDES','PATHAR'],
                      [strNumPed,
                      strEspDoc,
                      strCodEmp,
                      strCodEmpDest,
                      strPath],
                      nil,
                      nil,
                      True);
          End;

      End;

    5,8:
        Begin

          If fEmptyStr(strPath) Then
          begin

            if RecOpcaoImpressao.intOpcao = 8 then
            Begin
               strPath := fCfgSis('PATCRO');
            End
            Else
            Begin
               strPath := fCfgSis('PATPDC');
            End;

            pRetstrPath(strPath);

          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(288, 9192, [9153,9154,9155,9156,9157,9158,9159,9160,9161,9162,
                                            9163,9164,9165,9166,9167,9168,9169,9170,9171,9172,
                                            9173,9174,9175,9176,9177,9178,9179,9180,9181,9182,9183],
                      ['NUMPED','ESPDOC','CODEMP','EMPDES','TIPBAR','OPCC_N','PATHAR'],
                      [strNumPed,
                      strEspDoc,
                      strCodEmp,
                      strCodEmpDest,
                      IntToStr(0),
                      IfThen(RecOpcaoImpressao.intOpcao=8,'NeoGrid','Coral'),
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    4: pImprimeBoletimRecebimento(strNumPed, strEspDoc, strCodEmp, RecOpcaoImpressao.intQtdOrd, RecOpcaoImpressao.TipoBoletim);

    6: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetstrPath(strPath);
          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(289, 9196, [9197,9198],
                      ['NUMPED','ESPDOC','CODEMP','PATHAR'],
                      [strNumPed,
                      strEspDoc,
                      strCodEmp,
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    7: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetstrPath(strPath);
          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(294, 9296, [],
                      ['NUMPED','ESPDOC','CODEMP','EMPDES','PATHAR'],
                      [strNumPed,
                      strEspDoc,
                      strCodEmp,
                      strCodEmpDest,
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    9: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetstrPath(strPath);
          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(277, 9058, [],
                      ['NUMPED','ESPDOC','CODEMP','PATHAR'],
                      [strNumPed,
                      strEspDoc,
                      strCodEmp,
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    10: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetstrPath(strPath);
          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(295, 9332, [9333,9334,9335,9336],
                      ['NUMPED','EMPDES','ESPDOC','CODEMP','PATHAR'],
                      [strNumPed,
                      strCodEmpDest,
                      strEspDoc,
                      strCodEmp,
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    11: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetstrPath(strPath);
          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(293, 9267, [9268,9269,9270,9271],
                      ['NUMPED','EMPDES','ESPDOC','CODEMP','PATHAR','CNDBOS'],
                      [strNumPed,
                      strCodEmpDest,
                      strEspDoc,
                      strCodEmp,
                      strPath,
                      strCondPagBosh],
                      nil,
                      nil,
                      True);
          End;

        End;

    12: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetstrPath(strPath);
          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(276, 9057, [],
                      ['NUMPED','EMPDES','ESPDOC','CODEMP','PATHAR'],
                      [strNumPed,
                      strCodEmpDest,
                      strEspDoc,
                      strCodEmp,
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    13: TfrmPnlDadosPedCompra.pEnviaPedidoEmail('', strNumPed, strEspDoc, strCodEmp);

    14: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetStrPath(strPath)
          End;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(275, 9055, [9056],
                      ['NUMPED','ESPDOC','CODEMP','PATHAR','TIPBAR'],
                      [strNumPed,
                      strEspDoc,
                      strCodEmp,
                      strPath,
                      IntToStr(0)],
                      nil,
                      nil,
                      True);
          End;

        End;

    15: Begin

          If fEmptyStr(strPath) Then
          begin
            strPath := fCfgSis('PSTIHL');
            pRetStrPath(strPath)
          End;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(274, 9054, [],
                      ['NUMPED','ESPDOC','CODEMP','PATHAR'],
                      [strNumPed,
                      strEspDoc,
                      strCodEmp,
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    16: Begin

          If fEmptyStr(strPath) Then
          begin
            strPath := fCfgSis('PATCRO');
            pRetstrPath(strPath);
          end;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(273, 9043, [9044,9045,9046],
                      ['NUMPED','EMPDES','ESPDOC','CODEMP','TIPBAR','PATHAR'],
                      [strNumPed,
                      strCodEmpDest,
                      strEspDoc,
                      strCodEmp,
                      IntToStr(0),
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    17: pGeraXML(blnExcRes);

    18: Begin

          If fEmptyStr(strPath) Then
          begin
            pRetStrPath(strPath)
          End;

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(296, 9344, [9345],
                      ['NUMPED','ESPDOC','CODEMP','PATHAR'],
                      [strNumPed,
                      strEspDoc,
                      strCodEmp,
                      strPath],
                      nil,
                      nil,
                      True);
          End;

        End;

    19 : pArqATigreExcel(strNumPed, strEspDoc, strCodEmp, blnEsconderMensagem); //LayOut Tigre

  End; // fim do case

  FreeAndNil(qryPcmGer);

end;

procedure pImprimirOrdemCarregamento(strNumPed,
                                     strEspDoc,
                                     strCodEmp: String;
                                     intQtdImp: Integer = 1;
                                     blnReimpr: Boolean = False;
                                     blnOrdDig : Boolean = True);
  Var
    frxOrdCar: TfrxReport;
    qryIteOrd: TUniQuery;
    qryCabOrd: TUniQuery;
    qryCadEmp: TUniQuery;
    qryCfgRel: TUniQuery;
    strNomImp: String;
    strTipImp: String;

    procedure pCarregaCabOrdemCarregamento;
    Var
      strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT  ';
      strSQL := strSQL + '  PCG_NUMPED AS NUMDOC,  ';
      strSQL := strSQL + '  PCG_ESPDOC AS ESPDOC,  ';
      strSQL := strSQL + '  PCG_DTAENT AS DTAENT,  ';
      strSQL := strSQL + '  PCG_HORENT AS HORENT,  ';
      strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR,  ';
      strSQL := strSQL + '  FOR_CODFOR AS CODFOR   ';
      strSQL := strSQL + 'FROM                     ';
      strSQL := strSQL + '  PCMGER G               ';
      strSQL := strSQL + '  INNER JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ';
      strSQL := strSQL + 'WHERE                                          ';
      strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND                     ';
      strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC AND                     ';
      strSQL := strSQL + '  PCG_CODEMP = :CODEMP                         ';

      With qryCabOrd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
      End;
    End;

    procedure pCarregaItensOrdemCarregamento;
    Var
      strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                     ';
      strSQL := strSQL + '  G.ITE_LOCFIS AS LOCFIS,  ';
      strSQL := strSQL + '  IF(F.ITE_CODITE IS NULL, I.ITE_CODFAB, F.ITE_CODFAB) AS CODFAB, ';
      strSQL := strSQL + '  I.ITE_CODITE AS CODITE,  ';
      strSQL := strSQL + '  I.ITE_DESITE AS DESITE,  ';
      strSQL := strSQL + '  D.PCD_QTDITE AS QTDITE,  ';
      strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD,  ';
      strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR   ';
      strSQL := strSQL + 'FROM                       ';
      strSQL := strSQL + '  PCMDET D                 ';
      strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.PCD_CODITE     ';
      strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = D.PCD_CODITE AND ';
      strSQL := strSQL + '                         G.ITE_CODEMP = D.PCD_CODEMP     ';
      strSQL := strSQL + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI     ';
      strSQL := strSQL + '  INNER JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR     ';

      strSQL := strSQL + '   LEFT JOIN ITEFOR F ON F.ITE_CODITE = PCD_CODITE AND ';
      strSQL := strSQL + '                         F.ITE_CODFOR = PCD_CODFOR AND ';
      strSQL := strSQL + '                         (SELECT COUNT(*) FROM TABPRE  ';
      strSQL := strSQL + '                          WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ';

      strSQL := strSQL + 'WHERE                                                    ';
      strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND                               ';
      strSQL := strSQL + '  PCD_ESPDOC = :ESPDOC AND                               ';
      strSQL := strSQL + '  PCD_CODEMP = :CODEMP                                   ';

      strSQL := strSQL + '  ORDER BY  ';
      If blnOrdDig Then
        strSQL := strSQL + '  D.AUTOINCREM '
      Else
        strSQL := strSQL + '  D.PCD_DESITE ';


      With qryIteOrd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
      End;
    End;

    procedure pCarregaDadosEmpresa;
    Var
      strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE         ';
      strSQL := strSQL + '  CADEMP.*,                 ';
      strSQL := strSQL + '  CID_NOMCID AS EMP_NOMCID, ';
      strSQL := strSQL + '  CID_ESTADO AS EMP_ESTADO  ';
      strSQL := strSQL + 'FROM                        ';
      strSQL := strSQL + '  CADEMP                    ';
      strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ';
      strSQL := strSQL + 'WHERE                  ';
      strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

      With qryCadEmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;
      End;
    End;

Begin

  Try

    pCriarFormularios(TfrmModuloOrdemCarreg, frmModuloOrdemCarreg);
    qryCabOrd := fCriaQuery(Nil);
    qryIteOrd := fCriaQuery(Nil);
    qryCadEmp := fCriaQuery(Nil);
    qryCfgRel := fCriaQuery(Nil);

    pCarregaConfImpr(qryCfgRel, 'frmPedidoDeCompra_ORD');
    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

    pCarregaCabOrdemCarregamento;
    pCarregaItensOrdemCarregamento;
    pCarregaDadosEmpresa;

    With frmModuloOrdemCarreg Do
    Begin
      frxCadEmp.DataSet := qryCadEmp;
      frxItens.DataSet  := qryIteOrd;
      frxCadSep.DataSet := qryCabOrd;

      If strTipImp = 'J' Then
      Begin
        frxOrdCar := frxDocCar80J;
        frxOrdCar.DotMatrixReport           := False;
        frxOrdCar.PrintOptions.PrintMode    := pmScale;
        frxOrdCar.PrintOptions.PrintOnSheet := 9; //A4
      End
      Else
        frxOrdCar := frxDocCar80M;

      frxOrdCar.PrintOptions.Copies := intQtdImp;

      If (fEmptyStr(strNomImp)) Then
        frxOrdCar.PrintOptions.ShowDialog := False
      Else
      Begin
        frxOrdCar.PrintOptions.ShowDialog := False;
        frxOrdCar.PrintOptions.Printer    := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

        If (frxOrdCar.PrepareReport) Then
          pPrintReport('frmPedidoDeCompra_ORD', 'Impressão Ordem de Carregamento ('+strNumPed+')', strNomImp, frxOrdCar);
      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[pImprimirOrdemCarregamento]');
  End;

  FreeAndNil(frmModuloOrdemCarreg);
  FreeAndNil(qryCabOrd);
  FreeAndNil(qryIteOrd);
  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCfgRel);
End;


function fConsultaClientDataSet(Sender: TForm; cdsDataset: TUniClientDataSet; strNomeTabela: String;
  stlCampos, stlIndices: TStringList; strCaption: String = '';
  frmConsulta: TfrmConsultaCds=Nil): TBookmark;
  Var
    strFormTabela: String;
    blnLiberar : Boolean;
    blnConfirma: Boolean;
Begin

  If strNomeTabela = 'CADEMP' Then
    utcRegistros.Limpar(Sender.Name + strNomeTabela);

  strFormTabela := Sender.Name + strNomeTabela;
  blnLiberar := False;

  Try

    If Not Assigned(frmConsulta) Then
    Begin
      pCriarFormularios(TfrmConsultaCds, frmConsulta);
      blnLiberar := True;
    End;

    frmConsulta.Caption         := strCaption;
    frmConsulta.strUltSelect    := utcRegistros.Select;
    frmConsulta.bkmUltAcesso    := utcRegistros.Registro;
    frmConsulta.strUltIndice1   := utcRegistros.Indice1;
    frmConsulta.strUltIndice2   := utcRegistros.Indice2;
    frmConsulta.strUltIndice3   := utcRegistros.Indice3;
    frmConsulta.intUltItemIndex := utcRegistros.ItemIndex;

    frmConsulta.stlCampos       := stlCampos;
    frmConsulta.stlIndices      := stlIndices;

    frmConsulta.cdsConsulta     := cdsDataset;

    blnConfirma := (frmConsulta.ShowModal = mrOk);

    utcRegistros.Novo;

    utcRegistros.Tabela    := strFormTabela;
    utcRegistros.Registro  := frmConsulta.bkmUltAcesso;
    utcRegistros.Select    := frmConsulta.strUltSelect;
    utcRegistros.Indice1   := frmConsulta.strUltIndice1;
    utcRegistros.Indice2   := frmConsulta.strUltIndice2;
    utcRegistros.Indice3   := frmConsulta.strUltIndice3;
    utcRegistros.ItemIndex := frmConsulta.intUltItemIndex;

    utcRegistros.Grava;

    If blnConfirma Then
      Result := frmConsulta.bkmResult
    Else
      Result := Nil;

  Except
    On E: Exception Do
    Begin
      Result := Nil;
      pMensagensErro(E.Message, '[fConsultaClientDataSet]');
    End;
  End;

  If blnLiberar Then
    pFreeAndNil(frmConsulta);

end;

procedure pReaplicaMascara(cdsDataSet: TUniClientDataSet);
  Var
    intContador: Integer;
begin
  For intContador := Low(arrCampos) To HIgh(arrCampos) Do
  Begin
    If (Not fEmptyStr(arrCampos[intContador][3])) And (arrCampos[intContador][2] = 'N') Then
      TFloatField(cdsDataSet.FieldByName(arrCampos[intContador][1])).DisplayFormat := arrCampos[intContador][3];
  End;
end;


function fChamaCalculoGiro(var recOpcoesGiro: TRecOpcoesGiro;
                               blnCarregandoPedido: Boolean;
                               blnShow: Boolean = True;
                               blnConsulta: Boolean = False): Boolean;
  var
    intcontador,
    intIndice: Integer;
    blnMinDig: Boolean;
begin
  blnMinDig := fCfgSis('MINDIG', varBoolean);

  recOpcoesGiro.intMesGir := 0;
  recOpcoesGiro.dtaDataBaseGir := VS_Date;
  recOpcoesGiro.blnCarregItensGrid := True;

  Try
    pCriarFormularios(TfrmDigGiroEstoque, frmDigGiroEstoque);

    If blnConsulta Then
    Begin
      frmDigGiroEstoque.pnlFiltros.Enabled := False;
      frmDigGiroEstoque.tbsCalSug.Enabled := False;
      frmDigGiroEstoque.tbsCalGir.Enabled := False;
      frmDigGiroEstoque.tbsGeral.Enabled := False;
      frmDigGiroEstoque.btnConfirmaDados.Visible := False;
      frmDigGiroEstoque.btnCancelaDados.Caption := '&Sair';
    End;

    frmDigGiroEstoque.blnCarregandoPedido := blnCarregandoPedido;
    frmDigGiroEstoque.strPedMlj := recOpcoesGiro.strPedMlj;
    If Not Assigned(recOpcoesGiro.objSalInt) Then
    Begin
      recOpcoesGiro.objSalInt := TSalvaInterfaceGiro.Create(Nil);
      objSalvaInterface       := recOpcoesGiro.objSalInt;
    End;

    frmDigGiroEstoque.recOpcoesGiro := recOpcoesGiro;

    frmDigGiroEstoque.fraCalcGirFrame.chkPonPed.Visible := blnMinDig;
    If Not frmDigGiroEstoque.fraCalcGirFrame.chkPonPed.Visible  Then
      frmDigGiroEstoque.fraCalcGirFrame.chkPonPed.Checked := False;

    If blnShow Then
    Begin

      frmDigGiroEstoque.ShowModal;

    End Else
    Begin

      If Assigned(recOpcoesGiro.objSalInt) Then
      Begin
        recOpcoesGiro.objSalInt.fCarregaDados(recOpcoesGiro.strValKey, frmDigGiroEstoque,
                    recOpcoesGiro.strNomFrm, '', Assigned(recOpcoesGiro.objRecupera) And
                      TRecuperaPedido(recOpcoesGiro.objRecupera).recPcmger.blnRecuperaPedido);

        frmDigGiroEstoque.fraCalcGirFrame.chkPonPed.Visible := blnMinDig;
        If Not frmDigGiroEstoque.fraCalcGirFrame.chkPonPed.Visible  Then
          frmDigGiroEstoque.fraCalcGirFrame.chkPonPed.Checked := False;
      End;

      With frmDigGiroEstoque.fraCalcGirMesesFrame Do
      If fContaSelecaoBaseGiro = 0 Then
        lstBasGir.Checked[0] := True;

      frmDigGiroEstoque.blnConfirma := recOpcoesGiro.objSalInt.blnEncontrouGiro And frmDigGiroEstoque.fCamposOk;
    End;

    With frmDigGiroEstoque.fraCalcGirMesesFrame Do
  //  If Not grbBasGir.Visible Then
    Begin
      lstBasGir.Checked[0] := True;

      For intcontador := 1 To lstBasGir.Count - 1 Do
        lstBasGir.Checked[intcontador] := False;
    End;

    recOpcoesGiro.blnConfirmouExcecucao := frmDigGiroEstoque.blnConfirma;

    If (Not blnShow) Or frmDigGiroEstoque.blnConfirma Then
    Begin
      If Assigned(recOpcoesGiro.objSalInt) And blnShow Then
      Begin

        If recOpcoesGiro.opcChamada = chaSpoolTransferencia Then
          recOpcoesGiro.objSalInt.blnEmpVis := True;

        If recOpcoesGiro.objSalInt.fAtualizaDados Then
        Begin
          If fEmptyStr(recOpcoesGiro.strNomFrm) Then
            recOpcoesGiro.strNomFrm := 'frmDigGiroEstoque';

          recOpcoesGiro.objSalInt.fSalvaDados('', recOpcoesGiro.strNomFrm, strLoginUsuarioLogado);
        End;
      End;

      recOpcoesGiro.recNivEst     := frmDigGiroEstoque.recOpcoesGiro.recNivEst;

      recOpcoesGiro.blnImpReq     := frmDigGiroEstoque.chkImpReq.Checked;
      recOpcoesGiro.blnLimReq     := frmDigGiroEstoque.chkLimReq.Checked;
      recOpcoesGiro.blnInfMes     := frmDigGiroEstoque.fraCalcGirMesesFrame.chkInfMes.Checked;


      recOpcoesGiro.blnSpoTra     := frmDigGiroEstoque.chkSpoTra.Checked;

      recOpcoesGiro.blnMedAju     := frmDigGiroEstoque.fraCalcGirMesesFrame.rdgTipMed.ItemIndex = 1;

      recOpcoesGiro.strLocIni     := frmDigGiroEstoque.edtLocIni.Text;
      recOpcoesGiro.strLocFin     := frmDigGiroEstoque.edtLocFin.Text;

      recOpcoesGiro.strCodGru     := frmDigGiroEstoque.strCodGru;
      recOpcoesGiro.strCodFor     := frmDigGiroEstoque.strCodFor;

      SetLength(recOpcoesGiro.arrCodFor, Length(frmDigGiroEstoque.edtCodFor.ConsultasArray));
      For intIndice := Low(frmDigGiroEstoque.edtCodFor.ConsultasArray) To High(frmDigGiroEstoque.edtCodFor.ConsultasArray) Do
         recOpcoesGiro.arrCodFor[intIndice] := frmDigGiroEstoque.edtCodFor.ConsultasArray[intIndice];


      recOpcoesGiro.blnAnalisaITEFOR := frmDigGiroEstoque.blnAnalisaITEFOR;

      recOpcoesGiro.strCodMar     := frmDigGiroEstoque.strCodMar;
      recOpcoesGiro.strPrdGru     := frmDigGiroEstoque.strPrdGru;
      recOpcoesGiro.strGruCmp     := frmDigGiroEstoque.strGruCmp;
      recOpcoesGiro.strSitPro     := frmDigGiroEstoque.strSitPro;
      recOpcoesGiro.strUnidade    := frmDigGiroEstoque.strUnidade;
      recOpcoesGiro.strRefere     := frmDigGiroEstoque.strRefere;
      recOpcoesGiro.strDesIte     := frmDigGiroEstoque.strDesIte;
      recOpcoesGiro.strCodDep     := frmDigGiroEstoque.strCodDep;
      recOpcoesGiro.strAcoObj     := frmDigGiroEstoque.strAcoObj;
      recOpcoesGiro.intDiaVen     := frmDigGiroEstoque.intDiaVen;
      If frmDigGiroEstoque.dtaDataBaseGir <> StrToDate('30/12/1899') Then
        recOpcoesGiro.dtaDataBaseGir:= frmDigGiroEstoque.dtaDataBaseGir;
      recOpcoesGiro.blnAllIte     := frmDigGiroEstoque.blnAllIte;

      With frmDigGiroEstoque.fraCalcGirFrame do
      Begin
        recOpcoesGiro.cdsEmpSel     := cdsEmpSel.Data;
        recOpcoesGiro.blnArredSug   := chkArredQtdeSugest.Checked;
        recOpcoesGiro.blnConsMCom   := chkMultCompra.Checked;
        recOpcoesGiro.blnMultiploNaEmpresaCentralizadora := chkMultiploAposCentralizar.Checked;
        recOpcoesGiro.blnConsEMin   := chkEstMin.Checked;
        recOpcoesGiro.blnConsEMax   := chkEstMax.Checked;
        recOpcoesGiro.blnConsRequisicao := chkConsRequisicao.Checked;
        recOpcoesGiro.blnConsPedPen := chkPedPen.Checked;
        recOpcoesGiro.blnConsPedPenTransferencia := chkPedPenTransferencia.Checked;
        recOpcoesGiro.blnDesconsPedGar := chkPedGar.Checked;
        recOpcoesGiro.blnDescSalExt := chkDecSalExt.Checked;
        recOpcoesGiro.blnConsPedVen := chkPedVen.Checked;
        recOpcoesGiro.blnVenPer     := chkVenPer.Checked;
        recOpcoesGiro.blnVenPerMed  := rdgTipCalVenPer.ItemIndex = 1;
        recOpcoesGiro.blnVenEsp     := chkVenEsp.Checked;
        recOpcoesGiro.blnConsEndere := chkEndere.Checked;
        recOpcoesGiro.blnConsTransf := chkTransf.Checked;
        recOpcoesGiro.blnConsCot    := chkCotAbe.Checked;
        recOpcoesGiro.blnConsOrdPro := chkOrdPro.Checked;
        recOpcoesGiro.blnConsGarPen := chkGarPen.Checked;
        recOpcoesGiro.blnPonPed     := chkPonPed.Checked;
        recOpcoesGiro.blnAteMax     := chkAteMax.Checked;
        recOpcoesGiro.blnAgrSim     := chkAgrSim.Checked;

        recOpcoesGiro.blnEntFutPrevisao := chkPrevisao.Checked;
        recOpcoesGiro.blnEntFutFalta    := chkFalta.Checked;
        recOpcoesGiro.blnEntFutAguarda  := chkAguarda.Checked;

        If chkAgrEmp.Checked Then
          recOpcoesGiro.strEmpAgr := LeftStr(cbxAbrEmp.Text, 3)
        Else
          recOpcoesGiro.strEmpAgr := '';

        recOpcoesGiro.blnSugInd := rdgSugInd.ItemIndex = 0;

        recOpcoesGiro.intDiaPedVen  := StrToIntDef(edtDiaPre.Text, 0);
      End;

      recOpcoesGiro.blnConsTLoj   := frmDigGiroEstoque.blnConsTLoj;
      recOpcoesGiro.strCodCmp     := frmDigGiroEstoque.strCodCmp;
      recOpcoesGiro.strCodDig     := frmDigGiroEstoque.strCodDig;
      recOpcoesGiro.blnAnalisaITEFOR := frmDigGiroEstoque.blnAnalisaITEFOR;


      recOpcoesGiro.strEmpCal     := frmDigGiroEstoque.strEmpCal;

      recOpcoesGiro.strEmpGir     := frmDigGiroEstoque.strEmpGir;

      recOpcoesGiro.strEmpSubtraiPedTransf := frmDigGiroEstoque.strEmpSubtraiPedTransf;

      recOpcoesGiro.strCodTab     := frmDigGiroEstoque.strCodTab;
      recOpcoesGiro.blnExiApli    := frmDigGiroEstoque.chkExiApli.Checked;

      recOpcoesGiro.blnCarregItensGrid := frmDigGiroEstoque.chkCarIte.Checked;

      SetLength(recOpcoesGiro.arrLinhaGrupo, Length(frmDigGiroEstoque.mskLinGru.ConsultasArray));
      For intIndice := Low(frmDigGiroEstoque.mskLinGru.ConsultasArray) To High(frmDigGiroEstoque.mskLinGru.ConsultasArray) Do
         recOpcoesGiro.arrLinhaGrupo[intIndice] := frmDigGiroEstoque.mskLinGru.ConsultasArray[intIndice];

      SetLength(recOpcoesGiro.arrMarca, Length(frmDigGiroEstoque.edtCodMar.ConsultasArray));
      For intIndice := Low(frmDigGiroEstoque.edtCodMar.ConsultasArray) To High(frmDigGiroEstoque.edtCodMar.ConsultasArray) Do
         recOpcoesGiro.arrMarca[intIndice] := frmDigGiroEstoque.edtCodMar.ConsultasArray[intIndice];

      SetLength(recOpcoesGiro.arrPrdGru, Length(frmDigGiroEstoque.edtPrdGru.ConsultasArray));
      For intIndice := Low(frmDigGiroEstoque.edtPrdGru.ConsultasArray) To High(frmDigGiroEstoque.edtPrdGru.ConsultasArray) Do
         recOpcoesGiro.arrPrdGru[intIndice] := frmDigGiroEstoque.edtPrdGru.ConsultasArray[intIndice];

      SetLength(recOpcoesGiro.arrGruCmp, Length(frmDigGiroEstoque.edtGruCmp.ConsultasArray));
      For intIndice := Low(frmDigGiroEstoque.edtGruCmp.ConsultasArray) To High(frmDigGiroEstoque.edtGruCmp.ConsultasArray) Do
         recOpcoesGiro.arrGruCmp[intIndice] := frmDigGiroEstoque.edtGruCmp.ConsultasArray[intIndice];

      SetLength(recOpcoesGiro.arrSitPro, Length(frmDigGiroEstoque.edtCodSit.ConsultasArray));
      For intIndice := Low(frmDigGiroEstoque.edtCodSit.ConsultasArray) To High(frmDigGiroEstoque.edtCodSit.ConsultasArray) Do
         recOpcoesGiro.arrSitPro[intIndice] := frmDigGiroEstoque.edtCodSit.ConsultasArray[intIndice];

      SetLength(recOpcoesGiro.arrUnidade, Length(frmDigGiroEstoque.edtUnidade.ConsultasArray));
      For intIndice := Low(frmDigGiroEstoque.edtUnidade.ConsultasArray) To High(frmDigGiroEstoque.edtUnidade.ConsultasArray) Do
         recOpcoesGiro.arrUnidade[intIndice] := frmDigGiroEstoque.edtUnidade.ConsultasArray[intIndice];

      SetLength(recOpcoesGiro.arrCodDep, Length(frmDigGiroEstoque.edtCodDep.ConsultasArray));
      For intIndice := Low(frmDigGiroEstoque.edtCodDep.ConsultasArray) To High(frmDigGiroEstoque.edtCodDep.ConsultasArray) Do
         recOpcoesGiro.arrCodDep[intIndice] := frmDigGiroEstoque.edtCodDep.ConsultasArray[intIndice];
      With frmDigGiroEstoque.fraCalcGirMesesFrame do
      Begin
        recOpcoesGiro.strFilGir     := edtFilGir.Text;
        recOpcoesGiro.intOpcGir     := intOpcGir;

        If recOpcoesGiro.intOpcGir = GIR_03MESES Then
          recOpcoesGiro.intMesGir := 03

        Else if recOpcoesGiro.intOpcGir = GIR_06MESES Then
          recOpcoesGiro.intMesGir := 06

        Else If recOpcoesGiro.intOpcGir = GIR_12MESES Then
          recOpcoesGiro.intMesGir := 12;
        recOpcoesGiro.blnEmbala := False;
        If chkEmbala.Visible Then
          recOpcoesGiro.blnEmbala     := chkEmbala.Checked;
        recOpcoesGiro.blnConsMesAtu := chkMesAtu.Checked;

        If Not fEmptyStr(strMeses) Then
          recOpcoesGiro.strMeses := strMeses;

        If chkInfMes.Checked Then
        Begin
          recOpcoesGiro.intMesMos := recOpcoesGiro.intMesGir;
          recOpcoesGiro.blnInfMes := True;

        End Else
        Begin
          If fCfgSis('MESGIR', varInteger) = 1 Then
            recOpcoesGiro.intMesMos := 12
           Else
             recOpcoesGiro.intMesMos := recOpcoesGiro.intMesGir;
        End;

      End;

      recOpcoesGiro.intOrdem := frmDigGiroEstoque.intOrdem;

      Case frmDigGiroEstoque.rdgLocfis.ItemIndex Of
        0: recOpcoesGiro.slfLocFis := slfComLocal;
        1: recOpcoesGiro.slfLocFis := slfSemLocal;
        2: recOpcoesGiro.slfLocFis := slfTodas;
      End;

      If frmDigGiroEstoque.rdgSaldos.Visible Then
      Begin

        Case frmDigGiroEstoque.rdgSaldos.ItemIndex Of
          0:   recOpcoesGiro.slsSaldos := slsZerado;
          1:   recOpcoesGiro.slsSaldos := slsPositivo;
          2:   recOpcoesGiro.slsSaldos := slsNegativo;
          Else
            recOpcoesGiro.slsSaldos := slsTodos;
        End;

      End
      Else recOpcoesGiro.slsSaldos := slsTodos;

      If frmDigGiroEstoque.rdgSalEmpDes.Visible Then
      Begin

        Case frmDigGiroEstoque.rdgSalEmpDes.ItemIndex Of
          0:   recOpcoesGiro.slsSaldosDestino := slsMenorOuIgualZero;
          1:   recOpcoesGiro.slsSaldosDestino := slsAbaixoMinimo;
          2:   recOpcoesGiro.slsSaldosDestino := slsAcimaOuIgualMinimo;
          Else recOpcoesGiro.slsSaldosDestino := slsTodos;
        End;

      End
      Else recOpcoesGiro.slsSaldosDestino := slsTodos;

      If recOpcoesGiro.opcChamada = chaSpoolTransferencia Then
      Begin
        recOpcoesGiro.strEmpresasOrigens := fRetEmpresasSel(frmDigGiroEstoque.fraCalcGirFrame.cdsEmpSel, 'EMPVIS', False);
        recOpcoesGiro.strEmpresasDestino := fRetEmpresasSel(frmDigGiroEstoque.fraCalcGirFrame.cdsEmpSel, 'MARDES', False);
      End Else
      Begin
        recOpcoesGiro.strEmpresasOrigens := '';
        recOpcoesGiro.strEmpresasDestino := '';
      End;
    End
    Else
    begin
      FreeAndNil(recOpcoesGiro.objSalInt);
      objSalvaInterface := nil;
    End;


    Result := frmDigGiroEstoque.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fChamaCalculoGiro]');
    End;
  End;
  pFreeAndNil(frmDigGiroEstoque);
end;

function fRetornaCSTFornecedor(strCodFor, strCodIte: String; Var strCodSitOrigem: String): String;
  Var
    strTipAbf: String;
    qryDadosAbf: TUniQuery;
begin
  Result := '';

  If strCodFor.IsEmpty Then
    Exit;

  qryDadosAbf := fCriaQuery(Nil);
  pCarregaDadosST(qryDadosAbf, strCodFor, fRetornaAbreviacaoItem(strCodIte));

  strTipAbf := fGetTipoAbfFornecedor(strCodFor);
  Result := qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbf).AsString;

  strCodSitOrigem := qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbf + '_O').AsString;

  FreeAndNil(qryDadosAbf);
end;

Function fLePrecoCompraFornecedor(qryIteFor: TUniQuery; strCodFor, strCodIte, strCodEmp, strSqlWhereTabPre: String; blnConvert: Boolean): Boolean;
Begin
  If Not fCfgSis('TABPRF', varBoolean) Then
  Begin
    Result := False;
    Exit;
  End;

  With qryIteFor, SQL Do
  Begin
    Clear;
    Close;
    Add('SELECT');
    Add('  D.ITE_CODTAB, ');
    Add('  D.ITE_CODITE, ');
    Add('  D.ITE_DESF01, ');
    Add('  D.ITE_DESF02, ');
    Add('  D.ITE_DESF03, ');
    Add('  D.ITE_DESF04, ');
    Add('  D.ITE_DESF05, ');
    Add('  D.ITE_DESF06, ');
    If (fCfgSis('CNVEMB', VarString) = 'F') And
       (fCfgSis('TABPRD', VarBoolean)) Then
    Begin
      Add('  D.ITE_PRECOM / IF(IFNULL(ITE_CNVCUS, 0) <> 0,  ITE_CNVCUS, 1) AS ITE_PRECOM, ');
      Add('  D.ITE_PRECUS / IF(IFNULL(ITE_CNVCUS, 0) <> 0,  ITE_CNVCUS, 1) AS ITE_PRECUS, ');
      Add('  1.0000 AS ITE_EMBALA, ');
    End
    Else
    If (fCfgSis('CNVEMB', VarString) <> 'N') and blnConvert Then
    Begin // VAI LEVAR A EMBALAGEM PARA O PEDIDO
      Add('  D.ITE_PRECOM, ');
      Add('  D.ITE_PRECUS, ');
      Add('  IF(ITE_CNVCUS IS NULL OR ITE_CNVCUS = 0, 1, ITE_CNVCUS) AS ITE_EMBALA, ');
    End Else
    Begin
      Add('  D.ITE_PRECOM / IF(IFNULL(ITE_CNVCUS, 0) <> 0,  ITE_CNVCUS, 1) AS ITE_PRECOM, ');
      Add('  D.ITE_PRECUS / IF(IFNULL(ITE_CNVCUS, 0) <> 0,  ITE_CNVCUS, 1) AS ITE_PRECUS, ');
      Add('  1.0000 AS ITE_EMBALA, ');
    End;

    Add('  ITE_MLTCOM, ');
    Add('  D.ITE_IPIENT, ');
    Add('  D.ITE_SUBSTI, ');
    Add('  D.ITE_IMPFED, ');
    Add('  D.ITE_ACRFIN  ');

    Add('FROM');
    Add('  ITEFOR ');

    Add('INNER JOIN TABDET D ON D.ITE_SEQGER = ITEFOR.AUTOINCREM AND ');
    Add('                       D.ITE_CODEMP = :CODEMP');
    Add('INNER JOIN TABPRE ON TABPRE.TAB_CODTAB = D.ITE_CODTAB      ');

    Add('WHERE');
    Add('  D.ITE_CODFOR = :CODFOR AND ');
    Add('  D.ITE_CODITE = :CODITE     ');

    If strSqlWhereTabPre <> '' Then
      Add('AND  ' + strSqlWhereTabPre);

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODFOR').AsString := strCodFor;
    If strCodEmp <> '' then
      ParamByName('CODEMP').AsString := strCodEmp
    Else
      ParamByName('CODEMP').AsString := VS_StrCodEmp;

    Open;

    Result := Not IsEmpty;
  End;
End;

Function fTemItemPrecoFornecedor(strCodFor, strCodIte, strCodEmp, strSqlWhereTabPre: String; blnConvert: Boolean): Boolean;
  Var
    qryIteFor: TUniQuery;
Begin
  Result := True;

  // Deixa fora material de consumo (CFG_DXFMTC = SIM e FOR_MATREV = "M")
  If fCfgSis('DXFMTC', varBoolean) And (fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [strCodFor]) = 'M') Then
    Exit;
  qryIteFor := fCriaQuery(Nil);
  Result := fLePrecoCompraFornecedor(qryIteFor, strCodFor, strCodIte, strCodEmp, strSqlWhereTabPre, blnConvert);
  FreeAndNil(qryIteFor);
End;



procedure pCarregaEmpresasMlj(cdsEmpMlj: TUniClientDataSet);
  Var
    qryGenEmp: TUniQuery;
begin

  qryGenEmp := fCriaQuery(Nil);

  With qryGenEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT * FROM CADEMP ORDER BY EMP_CODEMP ');
    Open;

    cdsEmpMlj.CreateDataSet;
    cdsEmpMlj.Open;

    While Not Eof Do
    Begin
      cdsEmpMlj.Append;
      cdsEmpMlj.FieldByName('CODEMP').AsString := FieldByName('EMP_CODEMP').AsString;
      cdsEmpMlj.FieldByName('DESCRI').AsString := FieldByName('EMP_NOMEMP').AsString;
      cdsEmpMlj.FieldByName('MARDES').AsString := 'S';
      cdsEmpMlj.FieldByName('EMPVIS').AsString := 'S';
      cdsEmpMlj.Post;
      Next;
    End;

    cdsEmpMlj.First;
  End;

  FreeAndNil(qryGenEmp);

end;


procedure pRetstrPath(var strPath: string; intOpcao: Integer = 0);
begin
//  If strPath = '' Then
//  begin
    pCriarFormularios(TfrmPedidoCompraTXT, frmPedidoCompraTXT);
    Try
      Try
        frmPedidoCompraTXT.intOpcao := intOpcao;
        frmPedidoCompraTXT.strPathArq := strPath;
        frmPedidoCompraTXT.ShowModal;
        strPath := frmPedidoCompraTXT.strPathArq;
      Except
        On E: Exception Do
        Begin
          strPath := '';
          pMensagensErro(E.Message, '[pImprimirPedido]');
        End;
      End;
    Finally
      FreeAndNil(frmPedidoCompraTXT);
    End;
//  End;
end;


procedure pAjustaTamanhoCampos(stlTexto: TStringList);
  var
     i: integer;
    strResto, strTmp: string;

begin
  // Verfica se as linhas correspondem ao tamanaho maximo e ajusta;
  i := 0;
  while stlTexto.Strings[i].Length > 250 do
  Begin
     strTmp := copy(stlTexto.Strings[i], 0, 249);
     strResto := copy(stlTexto.Strings[i], 250, Length(stlTexto.Strings[i]));
     stlTexto.Strings[i] := strTMP;
     stlTexto.add(strResto);
     inc(i);
  End;

end;


Function fCarregaObservPedido: TStringList;
var i: integer;
Begin
  Result := TStringList.Create;

  Result.Text := fCfgSis('MSGPCG');

  For i := 0 to Result.Count -1 do
  Begin
    If Result.Strings[i].Length > 250 Then
    begin
       Result.Text := ReplaceText(Result.Text, #$D#$A, '');
       pAjustaTamanhoCampos(Result);
       Break;
    End;
  end;
  While Result.Count < 5 Do
    Result.Add('');
End;


procedure pGeraXML(blnExcelResumido: Boolean = False);
var
 qryGenFor: TUniQuery;
begin
  pCriarFormularios(TfrmPnlDadosPedCompra, frmPnlDadosPedCompra);

  qryGenFor   := fCriaQuery();

  pCriarFormularios(TfrmPnlDadosPedCompra, frmPnlDadosPedCompra);
  frmPnlDadosPedCompra.strNomeArquivos      := '';
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp := 'XLS';
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnExcRes := blnExcelResumido;
//  frmPnlDadosPedCompra.blnImpPedCompra := True;
  frmPnlDadosPedCompra.FblnShowOnTerminate := True;
  frmPnlDadosPedCompra.blnAbriArquivoExcelAoFinalizar := True;
  If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.StrEmpDes) Then
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.StrEmpDes := VS_strCodEmp;
  If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor) then
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor := fCampoTabela('PCG_CODFOR', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC', 'PCG_CODEMP'],
                                                                       [TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed,
                                                                        TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc,
                                                                        TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp]);

    pPesquisaCadFor(Nil, qryGenFor, TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor);


  FreeAndNil(qryGenFor);

  frmPnlDadosPedCompra.pGeraExcel;
End;

function fRetornaSQLCodigoFabricaProduto(const strTipFab, strEmpDes: String): String;
begin
  Result := ' I.ITE_CODFAB AS CODFAB, ';

  Case AnsiIndexStr(UpperCase(strTipFab), ['P', 'F']) Of
      0 : Result := ' I.ITE_CODFAB AS CODFAB, ';
      1 :  Begin
             If fCfgSis('TABPRF', varBoolean, strEmpDes) Then
               Result := '  F.ITE_CODFAB AS CODFAB, '
             Else
               Result := '  F.ITE_CODITF AS CODFAB, ';
           End;
  End;
end;

function fAliquotaPisCofinsProduto(ACodIte: String; APis: Boolean; ACFOP: string): Double;
var qryConsulta: TUniquery;
    blnUtiAbf: Boolean;
    strTabelaProduto: String;
    strTabelaPisCofins: String;
    strCodAbf: string;
    strCampoAbf: String;
begin
  blnUtiAbf := fCfgSis('UTIABI', varBoolean);
  If Not blnUtiAbf Then
  Begin
    If APis Then
      Exit(fCfgSis('ALPISP', varDouble))
    Else
      Exit(fCfgSis('ALCOFP', varDouble))

  End;

  strTabelaProduto := IIf(fCfgSis('TPABPC')= '2', 'ITEGER', 'CADITE');
  strTabelaPisCofins := IIf(APis, 'PISENT', 'COFENT');
  strCampoAbf :=  IIF(APis, 'ITE_ABFPIS', 'ITE_ABFCOF');

  qryConsulta := fCriaQuery;

  Try
    qryConsulta.SQl.Add('SELECT '+strCampoAbf+' FROM ' + strTabelaProduto);
    qryConsulta.SQl.Add(' WHERE ITE_CODITE = "'+ACodIte+'"');
    If strTabelaProduto = 'ITEGER' then
      qryConsulta.SQl.Add(' AND ITE_CODEMP = "'+VS_StrCodEmp+'"');
    qryConsulta.Open;

    strCodAbf := qryConsulta.FieldByName(strCampoAbf).AsString;

    qryConsulta.SQL.Clear;

    qryConsulta.SQL.Add('SELECT MAX(APC_ALQENT) AS ALQENT FROM ' + strTabelaPisCofins);
    qryConsulta.SQL.Add(' WHERE APC_CODAPC = "'+strCodAbf+'"');
    qryConsulta.SQL.Add('   AND LOCATE("' + ACFOP + '", APC_CFOENT) > 0 ');
    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
      Result := 0
    Else
      Result := qryConsulta.FieldByName('ALQENT').AsFloat;

  Finally
    FreeAndNil(qryConsulta);
  End;

End;


Initialization

  objSalvaInterface := Nil;

  dxInitialize;

finalization
  dxFinalize;

end.

