{*******************************************}
{* UNIT DE FUNÇÕES E PROCEDURES DO SISTEMA *}
{****************************************DV*}
unit untFuncoes;

interface

uses
	Windows, Messages,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, IniFiles,
  Buttons, DBCtrls, Uni, DB, Mask, Printers, EditFocus,
  DBLookupComboBoxFocus, ComboBoxFocus, MemoFocus, DBComboBoxFocus,
  DBMemoFocus, MaskEditFocus, DBEditFocus, Grids, Menus, Math,
  RLReport, RLTypes, DateUtils, MaskUtils, untTypesSistema, untDisparaSMSAut,
  {Qt,}  WinSock, cxProgressBar, System.Generics.Collections,
  IdSMTP,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdPOP3, IdSocks, IdMessage, ShellApi, WinSpool,
  untFuncoesSimples, UniClientDataSet, untFuncTinta, untCfgCfopCst,
  untFuncoesRel, untFuncoesRel2, XMLIntf, DBGridCitel, DBGrids, AnsiStrings, untConstantes,
  untILiberacao, untLiberacaoFactory, untMsgLiberacao, untTPerfilDespachanteAduaneiro,
  {$WARN UNIT_PLATFORM OFF}
  Vcl.FileCtrl,
  {$WARN UNIT_PLATFORM ON}
  Shared.Functions.Funcoes.Faturamento, untBancos, untTBoletoCarne, untTBoleto1Via_Comprovante,
  untFechamentoFinanceiro;

{*****************************************************}
{* SALVA A PROVISÃO DE DEVEDORES DUVIDOSOS NA AUXREC *}
{**S************************************************JL*}
Type
  TGravaAlteracaoDePortador = class
  private
    class procedure Salvar(PortadorAntigo, PortadorNovo, NumDup, Parcel,
                           EspDoc, CodEmp, CodCli, SeqBai: string ;
                           AVoltarDataPortador: Boolean = True;
                           ADataTrocaPortador: TDateTime = 0);
  public
    class procedure SalvarManualmente(PortadorAntigo, PortadorNovo, NumDup, Parcel,
                                      EspDoc, CodEmp, CodCli, SeqBai: string;
                                      AVoltarDataPortador: Boolean = True;
                                      ADataTrocaPortador: TDateTime = 0); overload;

    class procedure SalvarBeforePost(DataSet: TDataSet); overload;

    class function RetornaDataPortadorAnterior(ANumeroDocumento,
                                               AParcela,
                                               AEspecieDocumento,
                                               ACodigoEmpresa,
                                               ACodigoCliente,
                                               ASequencialBaixa: String): TDateTime;
  end;

{********************************************}
{* Registro Referente a Duplicatas Agrupadas*}
{*****************************************KP*}
Type
  TDuplicatasAgrupadas = record
    strNumAgr: String;
    strEmpAgr: String;
    strCodCli: String;
End;

Type
  TTipoCalculoSTGareImportacaoXML = (tcsgiPadrao, tcsgiProduto, tcsgiProduto_ComDesconto, tcsgiProduto_ComIPI, tcsgiIPIComDesconto);

Type
  {********************************************}
  {* TIPO DE AGENDAMENTO PARA O TELEMARKETING *}
  {*****************************************LA*}
  TTipoAgendamento = (taDiaInicio,taContinuo,taManual,taAutomatico);

Type
  TTipoEventoEntrega = (NFeConfirmacaoEntrega, NFeCancelamentoConfirmacaoEntrega, NFeInsucessoEntrega, NFeCancelamentoInsucessoEntrega,
                        CTeConfirmacaoEntrega, CTeCancelamentoConfirmacaoEntrega, CTeInsucessoEntrega, CTeCancelamentoInsucessoEntrega);

Type
  TRecMultaJuros = record
    fltValorMulta: Double;
    fltValorJuros: Double;
  end;

type
  TBaixaCheque = Record
    fltValor: Double;
    dtaDtaDep: TDateTime;
End;

Type
  TSituacaoPedido = (sitAberto,sitParcial,sitBaixado);

  TAtualizaVarGlobal = procedure (strCodEmp, strUsuLogado, strEmpAceUsuLogado, strEmpEstUsuarioLogadoP: String); stdcall;

 (* TInicializaDllPedidoDeCompra = procedure(frmModuloPar: TUniConnection; Handle: HWND; intDebugH: Byte;
                                           funcGravaFatGor: TfGravaFatGor;
                                           funcGravaFatDor: TfGravaFatDor;
                                           procExecutaRelatorio: TExecutaRelatorio); stdcall; *)

Type
  TIndMenus = Record
    strNomForm: String;
End;

Type

  {*****************************************}
  {* REPRESENTA UM AGRUPAMENTO             *}
  {**************************************MV*}
  TDadosAgrup = Record
//    strLtrDup: String;
//    intQtdDia: Integer;
    dtaDtaVen: TDateTime;
    strCodPor: String;
    fltValPag: Double;
    strObsAg1: String;
    strObsAg2: String;
    strObsAg3: String;

End;

Type
  TTravaFaturamento = record
    strDirAce,
    strGrupo,
    strInformacao: String;
    blnCarregarLibPed: Boolean;
  end;

Type
  TArrTravaFaturamento = Array Of TTravaFaturamento;

Type
  IEspecieParaArquivoRemessa = Interface
    ['{9E44A0C5-B615-40AE-A830-5B57C032F75D}']
    function fRetornaIndiceParaEspecie(AEspecie: String): String;
    function fRetornaEspecieDoIndice(ACaracter: String): String;
    function fValidaEspecie(AEspecie: String): Boolean;
    function fRetornaEspeciesPermitidas(): String;
    procedure pValidaEspecie(AEspecie: String);
  end;

Type
  TEspecieParaArquivoRemessa = class(TInterfacedObject, IEspecieParaArquivoRemessa)
    private
      FDicEspIndex: TDictionary<String,String>;
    protected
      constructor Create;
    public
      class function New(): IEspecieParaArquivoRemessa;
      function fRetornaIndiceParaEspecie(AEspecie: String): String;
      function fRetornaEspecieDoIndice(ACaracter: String): String;
      function fValidaEspecie(AEspecie: String): Boolean;
      function fRetornaEspeciesPermitidas(): String;
      procedure pValidaEspecie(AEspecie: String);
  end;

Type
  TProcMensagemTEF = procedure (frmNomeForm: TForm; strMensagem: String) of object;

  function fRetSQLItem : String;

  Procedure pCarregaItensPedidosTolerancia(fltCotDol: Double; qryItePed: TUniQuery; stlPedidos: TStringList = Nil);

  {**************************************}
  {* RETIRADA DO MODULO frmModuloTipClg *}
  {***********************************RV*}
  procedure pCarregaFormasPagto(strCodCli: String;
                                var stlForPag: TStringList;
                                var stlCndPag: TStringList;
                                strTipCli: String = '');

  function fPagamentoPermitidaParaTipoCliente(const strCodCli, strCodFpg: String): Boolean;

  procedure pMsgFormasPagtoPermitidasCliente( strCodFpg: String;
                                              stlForPag: TStringList;
                                              objMsg: TMensagemLiberacao );

  function fFormaPagtoPermitidaComAReceber(strCodFpg: String): Boolean;
  function fDescricaoFormasPagtoPermitidasComAReceber: String;

  {*******************************}
  {*    PROCEDURES DO SISTEMA    *}
  {****************************DV*}
  procedure pAtualizaPriComCliente(strCodCli: String; dtaDataCom: TDateTime = 0; dtaDataDoc: TDateTime = 0);

  procedure pAtualizaUltComCliente(strCodCli: String);
  function fAtualizaUltComCliente(strCodCli: String; dtaDataIni: TDateTime): Boolean;
  function fBuscaUltimaCompraItem(strCodCli, strCodIte: String) : String;

  procedure pAtualizaUltVenItem(strCodIte: String);

  procedure pAtualizaMaiComCliente(strCodCli: String;fltValor: Double; strNumDoc, strEspDoc: String);
	procedure pRegistraUsuario(NomeUsuario,Evento:String);
  procedure pGravaLogDelecao(NomeTabela,NomeCampo,Informacao: String; dtaDataDelecao: TDateTime; intPosicao: Integer);
	procedure pAtuCaptionLabel(Objeto: TLabel; strString:String);
  procedure pRaise(const strMensagem: String);

  Function fVerificaPesoDosItensEntrada(blnOutDes: Boolean = False): Boolean;
  Function fRetornaPesoEntrada(Var fltPesTotAnt: Double; blnConverteEmbalagem: Boolean = False): Double;
  Function fRetornaQtdeEntrada(Var fltQtdTotAnt: Double): Double;

  function fSqlItensPedidos(arrPedidos, arrEmpresas: Array of String; strCodEmp: String;
                            blnSomConferido: Boolean): String;

  function fSqlItensGarantia(strCodEmp: String;
                             blnRecClienteGrantia: Boolean;
                             strNumEnt: String;
                             blnRetornoForn: Boolean = False;
                             strClaFisEnt:String = '';
                             strChaveSEQGAG: String = '';
                             strCodFor: String = ''): String;

  function fRetornaNosNum(strCodBco, strLindig: String): String;

  function fDocumentoPossuiServicos(strNumDoc, strEspDoc, strCodEmp: String; Var blnSomenteServ: Boolean; blnFiltraJaFatu: Boolean=False; blnUsaCodEmp: Boolean=False): Boolean;
  function fQtdServicos(strNumDoc, strEspDoc, strCodEmp: String): Integer;  
  function fGravaCodSeq(strNomeTabela: String; intCodSeq: Integer): Boolean;
  function fRetCorEmpresa(strCodEmp: String): Integer;
  Function fEhConfirmacaoBaixa(strEspDoc, strNumDoc, strCodEmp: String): Boolean;
  function fRetEmpRespConfDocs(strCodCli: String) : String;
  procedure pAtualizaDuplicataCodCedente(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCodCed: String);

  function fTemInvFin(strTabela, strPreFix: String): Boolean;
  function fTemWhere(Const strSQL: String): Boolean;
  Function fTemTransportadoraPadrao(blnDarMensagem: Boolean): Boolean;

  //function EnviaEMail(Handle: THandle; Mail: TStrings):Cardinal;

  procedure pFinalizaModulos;

  function fGeraHtmlContaCorrente(strCodCli, strTipFil: String;
    fltTotVencido, fltTotDupRec, fltTotJur, fltTotCorDif, fltDupAve: Double;
    strMensagem: String; qryDados: TUniQuery): String;

  Function fGetFornecedorFilial(strCodEmp: String): String;
  function fRetPosCadOpe(strCodOpe: String): String;
  function fRetCadOpePos(strRecNo: String): String;

  Function fCriptografaOperador(strCodOpe, strSenLib: String): String;
  Function fDescriptografaOperador(strSenLib: String): String;

  procedure pZeraCodigoMovBan(blnAutoGiro: Boolean = False);
  procedure pAtualizaApgTmp;
  procedure pApagaTabelasTemporarias;

  procedure pZapTable(strNomeTabela: String);
  procedure pCriaApagaTrava(intCriApa: Integer);

  procedure pGeraGiroEstoqueDiario(dtaDtaTmp: TDateTime; blnAutoGiro: Boolean = False);

  procedure pResetaImpressora(Const strNomImp: String);

  {*******************************}
  {*     FUNCTION DO SISTEMA     *}
  {****************************DV*}
  Function fTemCFOPBaixaEntregaFutura(blnDarMensagem: Boolean): Boolean;
  function fTemCFOPBaixaEntregaFuturaMensagem(strIndRev: string; blnDarMensagem: Boolean): Boolean;
  Function fTemCFOPEntregaFutura(blnDarMensagem: Boolean): Boolean;
  Function fSetaVarAutoinc(strNomTab: String): Boolean;
  function fFormDesbloqueio: Boolean;
  function fConfirmaCadSenha(strSenha1,strSenha2: String): Boolean;
  function fVerificaExisteDuplic(Var strNumDup,strParcel,strEspDoc,strCodEmp,strCodCli, strNosNum, strCodBco, strTipCob: String;
                                 Var intQtdReg: Integer; Var strAutoIncremCadRec: String; Var strCarteira: String;
                                 ACarBco: String = ''; ANumDoc: String = ''; ADtaVen: String = ''): Boolean;

  function fVerificaExisteDuplicContasPagar(strAutInc:String; Var strCodFor, strNumDup, strParcel, strCodEmp, strSeqBai, strSerie_, strVenCtp: String): Boolean; Overload;
  function fVerificaExisteDuplicContasPagar(strAutInc: String; Var strCodFor, strNumDup, strParcel, strCodEmp, strSeqBai, strSerie_, strVenCtp: String; Var ACodigoDeBarras : String): Boolean; Overload;
  function fVerificaClaFisExiste(strClaFis: String): Boolean;
  function fVerificaClaFisExisteEst(strClaFis, strEstado: String; Var strMensagem: String): Boolean;
  function EhNumero(AVariavel: String): Boolean;

	function fIsEmpty(strNomeTabela: String):Boolean;
  function ffrmData(Var dtaData: TDateTime; strCaption, strCaptionLabel: String;
    dtaDtaMin: TDateTime = 0; dtaDtaMax: TDateTime = 0; fValidaDataEntIme: TfuncValidaDataEntIme = nil): Boolean;
  function ffrmDataNovo(Var dtaData: TDateTime; strCaption, strCaptionLabel: String): Boolean;

  function fRetornaProCod(strNomeTabela: String): String;

  function fRetornaSequencialUnico(strNomSeq: String; strCodEmp: String = ''; blnNovaConexao: Boolean=False): Int64; overload;
  function fRetornaSequencialUnico(strNomSeq: String; strCodEmp: String; AConn: TUniConnection): Int64; overload;

  function fRetRcxCon(strCodEmp: String = ''): String;
  function fRetCtpCon(strCodEmp: String = ''; blnNovaConexao: Boolean=True): Longint;
  function fRetSeqRCH: Longint;

  function fRetornaQtdRegistros(strTabela: String): Integer;

  function fRetMax(strNomeTabela,strNomeCampo:String):String;
	function fNomeDoComputador: String;
	function fDiskInDrive(const Drive: char): Boolean;
  function fColocaAspas(strString:String): String;
	function fCompDatas(strDtaIni,strDtaFin:String): Boolean;

	function fAnyToStr (const Valor: variant): String;
  function fRetDesFpg(strCodigo: String): String;
  function fValidaCndPagFora(strCndPag: String): String;
  function fRetDiasNoMes(intAno, IntMes: Integer): Integer;
  function fRetForPagCodCnd(strCodCnd: String): String;
  function fTiraCaracter(strStr: String):String;
	function fGetUsuRede : String;
  function fFormataTamStr(strString: String; intLargura: Integer): String;
  function fValidaVencimento(const arrDuplicata: TarrDuplicata): Boolean;

  Function fRenomearArquivo( strArqOrigem, strArqDestino : String ):Boolean;
  function fTiraPontoVirgula(strValor: String): String;
  function fTransf(fltValor: Double; intInteiro, intDecimais: Integer): String;
  function fCalculaMultaJuros(dtaDtaVen, dtaDtaPag: TDateTime; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999): TRecMultaJuros;
  function fRetCodDiv(strTabela,strAutInc: String): String;
  function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;
  function fGravaAutoIncrem(strNomeTabela: String; intAutInc: Integer): Boolean;


  function fDigDuplicFinanceira(Var arrDuplica: TArrDigDuplicArray;
                                strCndPag:String;
                                intNumDoc:Int64;
                                curTotal:Currency;
                                blnMosTela,
                                blnEditavel,
                                blnHabEditDup:Boolean;
                                dtaDtaBas:TDateTime;
                                blnPergConf: Boolean;
                                fltImpost: Double = 0;
                                strUsaChq: String = 'N';
                                blnDupsRedondas: Boolean = True;
                                blnUsaHist: Boolean = False;
                                fltValRec: Double = 0.0;
                                blnFaturamento: Boolean = False;
                                arrValores: TDoubleArray = Nil;
                                strEspDoc: String = '';
                                blnSabDomFeriadoDiasUteis: Boolean = True;
                                objArredondamento: IArredondaParcela = Nil): Boolean;

  function fValidade_Sistema: Boolean;
  function fVerificaSenhaVend(strSenha: String): Boolean;
  function fVerificaSenhaMotorista(strSenha: String): Boolean;
  function fVerificaUsuarioMotorista(strUsuario: String): Boolean;

  function fSeqContaBanco(intQtdCod: Integer = 1): String;

  function fSeqAgrupamentoCtr: String;
  function fSeqAgrupamentoCtp: String;
  function fSeqDespesasProtesto: String;
  function fSeqPedidoCompra: String;
  function fSeqOrcamento: String;
  function fSeqLaser: String;
  function fRetSequencialMovCar(strTblMovCar, strCodEmp: String): String; overload;
  function fRetSequencialMovCar(strTblMovCar, strCodEmp: String; Var arrCartoes: TCartoesResumoCaixaArray): String; overload;
  function fPegaArquivoTxt: String;
  function fRetQtrStr(strSubStr, strString: String): Integer;
  function fCalcIcms: Boolean;
  function fPodeExcluirItem(strCodIte: String): Boolean;
  function fCriarProcesso(strArquivo: string; blnTrava: Boolean; TipoChamado: TTipoChamadaProcesso = tcpMaximizado): boolean;
  function fCalculaValorIcms(fltBasIcm, fltAlqIcm: Double; blnRICMPR: Boolean = False): Double;
  function fVerificaIntegridadeOrigemDestino(strTabOri, strTabDes: String;
    Var lsvFantantes, lsvDivergentes: TListView): Boolean;

  function fRetNomFanVen(strCodVen: String): String;
  function fRetCodFornecedor(strCodIte: String): String;
  function fRetCodCidByCliente(strCodCli: String): String;
  function fRetDataSalBal(strCodIte, strCodEmp: String): TDate;
  function fClaFisCadastrada(strCodCfo: String): Boolean;
  function fRetDesCla(strClaFis: String; blnConsulta: Boolean = False): String;
  function fRetDesFis(strCodFis: String): String;
  function fValidaBancoCnf(Const strCodBco, strTblCnf: String): Boolean;
  function fArredCima(fltValor: Double): Double;
  function fRetMD5Laudo: String;
  function fNumeroLaudo: String;
  function fRetVersaoPAFER: String;
  function fRetornaI_PP_T(strCodIte: String): String;
  function fRetCodItem(strCodBar: String): String;
  function fRetNomeArquivoPAF(strNomeArq: String; strExt: String = '.txt'): String;
  function fFloatToStrPonto(valor: double; inte,deci: integer): string;
  function fFloatToStrVirgula(valor: double; inte,deci: integer): string;
  function fContaLinhasArq(strNomArq: String): Integer;
  function fRetEmpCarregamentoItem(strCodIte: String): String;

  function fRetornaValRet(strEstFor: String; fltBasRet, fltValIcm, fltAlqSub: Double): Double;
  function fRetornaValFCPRet(fltBase, fltAliquota: Double): Double;

  function fRetCreDebConta(strTabela, strCodCta, strCreDeb: String; dtaDtaIni, dtaDtaFin: TDateTime): Currency;

  function fVerificaVendaExiste(    strNumDoc, strEspDoc, strCodEmp: String;
                                Var strCodCli, strCodVen, strCodRep, strOriDoc: String;
                                Var dtaDtaEmi: TDateTime): Boolean; overload;

  function fVerificaVendaExiste(    strNumDoc, strEspDoc, strCodEmp: String;
                                Var strCodCli, strCodFaz, strCodVen, strCodRep, strOriDoc: String;
                                Var dtaDtaEmi: TDateTime;
                                Var blnPresencial: Boolean): Boolean; overload;

  function fItemFracionado(strCodUni: String; qryGen: TUniQuery = Nil): Boolean;
  function fVerificaAcessoCartao(strCodCar: String): Boolean;


  {***********************************************}
  {* FUNÇÕES REFERENTES À ENTRADA DE MERCADORIAS *}
  {********************************************MV*}
  procedure pCriaTabelaEntradaMercadorias(blnSempreDeletar: Boolean = True);
  procedure pDeletaTabelaEntradaMercadorias;

  function fCarregaItensPedidos(fltCotDol: Double;
                                arrPedidos,
                                arrEmpresas: Array of String;
                                strCodEmp: String;
                                blnSomConferido: Boolean;
                                qryItePed: TUniQuery): Boolean;

  function fCarregaItensGarantia(strCodEmp: String;
                                 qryItePed: TUniQuery;
                                 blnRecClienteGrantia: Boolean;
                                 strNumEnt: String;
                                 blnRetornoForn: Boolean = False;
                                 strClaFisEnt: String = '';
                                 strChaveSEQGAG: String = '';
                                 strCodFor: String = ''): Boolean;

  function fCarregaItensNotaEletronica(strAutEle, strCodEmp: String; finalidadeXML : tpeFinalidadeXML): Boolean;

  Function fSQLItensNotaEletronica(strAutEle, strCodEmp: String;
                                   finalidadeXML : tpeFinalidadeXML;
                                   blnUsoConsumo: Boolean = False;
                                   blnDescIncond: Boolean = False;
                                   strClaFisConsumoTributado: String = '';
                                   strClaFisConsumoSubstituido: String = '';
                                   blnEntradaAutomatizada: Boolean = False): String;

  Function fVerificaValorVOutroXML(strAutEle: String): Boolean;


  function fCodFisGravaIsentoDocEnt(strCFOP, strCodFis: String): Boolean; OverLoad;
  function fCodFisGravaIsentoDocEnt(strCFOP, strCodFis, strLVPENT, strLVPISE, strLVPE70, strLVPI30, strLVPI41, strLVPI50, strLVPI51, strIOE915: String): Boolean; OverLoad;

  function fEhRetornoGarantiaFornecedor(strClaFis: String; blnEhNfe_, blnVarGar: Boolean): Boolean;

  procedure pCalculaTFCI(qryEntMer: TUniQuery);

  function fRetOutDesImportacao: Double;
  function fRetDesAceForaComposicaoOutras(qryEntMer: TUniQuery;
                                          PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro): Double;
  function fAliquotaIpiSaidaProduto(ACodIte: String): Double;

  function fRestauraICM(qryEntMer: TDataSet; strCodFis: String): Boolean;
  function fTemSaldoParaEnderecamento: Boolean;

  function fCreditaIPI(blnContribuinteIPI: Boolean;
                       strCfoEnt: String;
                       CfgECAIPI: String;
                       blnIteIMPDIR: Boolean;
                       cfgIMPDIR: Boolean;
                       fltIpiSai: Double): Boolean;


  procedure pRateiaImpostos(qryEntMer: TUniQuery;
                            FinalidadeXML: tpeFinalidadeXML;
                            objExcecaoCfopCst: TCfgCfopCst;
                            fltTotIte,
                            fltValFre,
                            fltDesEsp,
                            fltDesCom,
                            fltDesPis,
                            fltPerDesPis,
                            fltDesAce,
                            fltTotRet,
                            fltTotIteRet: Double;
                            pgbDados: TProgressBar;
                            fltAlqFor: Double;
                            strEstFor,
                            strCodFor,
                            strTipFor: String;
                            fltDifIpi,
                            fltEdtIpi: Double;
                            blnDevolu: Boolean;
                            blnICMSDesoneradoEstaNoDescontoComercial: Boolean;
                            PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;
                            strClaSub: String = '';
                            fltTotRetOriginal: Double = 0.0;
                            blnApliRed: Boolean = True;
                            strAutEle: String = '';
                            blnFreTri: Boolean = False;
                            strClaBri: String = '';
                            blnGarant: Boolean = False;
                            blnRecCliGarantia: Boolean = False;
                            blnNotaImp: Boolean = False;
                            blnZonFra: Boolean = False;
                            strEspDoc: String = 'NF';
                            blnConEqu: Boolean = False;
                            blnDescIncond: Boolean = False;
                            tipRatFrete: TTipoRateioFrete = trfPropValorItem;
                            blnPrecoPraticado: Boolean = False;
                            blnPresencial: Boolean = False;
                            blnClaFisBonificacao: Boolean = False;
                            blnCaixa2: Boolean = False;
                            blnAcessadoViaRetornoConsignacao : Boolean = False;
                            blnManterIpi: Boolean = False;
                            blnZeraIcmsDevolucao: Boolean = True;
                            blnZerouSt: Boolean = False);

  function fRetornaTotIteRet: Double;
  function fRetornaAlqFor(strEstFor, strIesFor: String; strEstEmp: String = ''): Double;


  function fValorTabelaCFOPEntrada(strClaFis, strCST, strTipPro: String; var strClaFisOut: String): Boolean;

  function fRetornaDadosFiscais(    strEmpEst: String;
                                    blnContribuinteIPI,
                                    blnTemAntIcm: Boolean;
                                    strCodAbf: String;
                                    fltTotIte,
                                    fltAlqFor: Double;
                                    strEstFor,
                                    strCodFor: String;
                                    blnItemRevenda: Boolean;
                                Var strClaFis,
                                    strCodFis: String;
                                Var fltBasIcm,
                                    fltAlqIcm,
                                    fltAlqIcmRed,
                                    fltValIcm,
                                    fltPerBas,
                                    fltPeBaST,
                                    fltAliSte,
                                    fltAliFCP: Double;
                                var blnRedCargaMedia: Boolean;
                                    blnDevolu: Boolean;
                                    blnEntMer: Boolean = False;
                                    blnGarant: Boolean = False;
                                    blnRecCliGarantia: Boolean = False;
                                    blnNotaImp : Boolean = False;
                                    strI08CFO: String = '';
                                    blnConEqu: Boolean = False;
                                    blnPresencial: Boolean = False;
                                    cdsAbfIcm: TUniClientDataSet = Nil;
                                    blnAcessadoViaRetornoConsignacao  : Boolean = False;
                                    blnLumbrificante: Boolean = False;
                                    blnDevolucaoEntradaEmitidaFornecedor: Boolean = False): boolean;

  function fRetornaAliquotaIcmsInternaDoEstado(strEstado: String): Double;

  function fRetornaValorOutras(fltVlrCon, fltBasIcm, fltValIpi, fltValRet, fltVleRet, fltVleIpi, fltVFCPST: Double): Double;

  Function fMemoToStr(strMemo: String): String;

  procedure pCarregaItens(strCodEmp: String; Var qryCadIte: TUniQuery; fltCotDol: Double);

  Procedure pMontaSQLNota(Var strSql: String; strDtaIni, strDtaFin: String; const blnParaRetornoDeConsignacao : boolean = False);

  {*****************************************}
  {* FUNÇÕES E PROCEDURES PARA O CALCULO   *}
  {* DO GIRO DE ESTOQUE                    *}
  {**************************************MV*}
  function fDeletaTmpPedCom: Boolean;
  function fCriarTmpPedCom(intQtdMes: Integer): Boolean;
  {procedure pAtualizaTmpGirIte;}

  {*****************************************}
  {* FUNÇÕES PARA CARTÃO                   *}
  {**************************************MV*}
  function fCalculaValDocCartao(fltValTot, fltTaxAdm: Double): Double;  overload;
  function fCalculaValDocCartao(AValorBruto, APercentualTaxa, AValorFrete, AValorCupom: Double): Double; overload;

  {*****************************************}
  {* CALCULA O GIRO DE UM DETERMINADO ITEM *}
  {**************************************MV*}
  function fCalculaGiro(strCodIte: String; dtaDtaIni, dtaDtaFin: TDateTime;
    Var fltQtdEnt, fltQtdSai: Double): Boolean;

  function fClienteFilialCadastrado(strCodCli, strCodEmp: String): Boolean;
  function fFornecedorFilialCadastrado(strCodFor, strCodEmp: String): Boolean;

  Function fRetornaSenCli( intNumero: Integer ): String;
  function fRetSenOperador(strCodOpe: String): String;

  function fClienteFilial(strCodCli: String; Conexao: TUniConnection = Nil): Boolean; OverLoad;

  function fClienteFilial(strCodCli: String; Var strCodEmp: String; Conexao: TUniConnection = Nil): Boolean; OverLoad;

  function fGetPosLinha(strLinha, strDelimitador: String; intColuna: Integer): Integer;

  function fRetNomUnidadePorSig(strUnidad: String): String;

  function fVerificaEmpresaRecebimento(strCodEmp, strEspDoc: String): Boolean;
  function fRetNomProfissional(Const strCodPro: String): String;
  function fRetCliProfissional(Const strCodPro: String): String;
  function fRetCgcCpf(strCodCli: String): String;
  function fVerBarraFinal(strPath: String): String;
  function fAtuCodSeq(strChave, strCampo: String): String;

  function fVerificaDireitoAutBan(strNomForm: String): Boolean;
  function fRetDescri(strCampoRetorno, strCampoPesquisa , strNomeTabela , strCodigo: String): String;

  function fRetornaQtdParcelasCondicao(strCodCnd: String; Var blnSemEnt: Boolean; Var intQtdPar, intDiaFix, intLimite: Integer; Var blnDiaCor: Boolean): Boolean;
  function fRetCondicaoDiaFixo(blnSemEnt: Boolean; intQtdPar, intDiaFix: Integer; dtaDtaBas: TDateTime; intLimite: Integer; blnDiaCor: Boolean): String;
  function fRetCondicao(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCnd, strTipFor, strCndPag: String; dtaDtaBas: TDateTime = 0; strOpcDoc: String = ''; strCodCid: String = ''; blnForcarDataBase: Boolean = False): String;
  function fRetCondicaoDiaFixoCliente(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCli, strConPag: String; dtaDtaBas: TDateTime = 0; strOpcDoc: String = ''; strCodCid: String = ''): String;
  function fRetCondicaoDiaFixoCliente_MTLCND(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCli, strConPag: String; dtaDtaBas: TDateTime = 0; strOpcDoc: String = ''; strCodCid: String = ''): String;
  function fRetCondicaoDiaFixoCliente_Normal(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCli, strConPag: String; dtaDtaBas: TDateTime = 0; strOpcDoc: String = ''; strCodCid: String = ''): String;
  function fRetQtdDiasEntreDataBaseDataVencimento(dtaVenc, dtaBasTmp: TDateTime): String;
  function fRetCondicaoDevolucao(dtaEmiVen: TDate; strCndVen: String): String;
  function fGetCondicaoPrazo(strConPag: String): String;

  function fRetornaGrupoItem(strCodIte: String): String;
  function fRetNomeBco(strCodBco: String): String;
  function fPedLiberado(strNumPed: String; strCodEmp: String = ''): Boolean;
  function fPedidoOriginadoOutroPedidoPeloF11Caixa(strNumPed: String; strCodEmp: String = ''): Boolean;
  function fPedidoBaixaEntregaFutura(strNumPed, strEspDoc: String; strCodEmp: String = ''): Boolean;
  function fEhPedidoComServicoEProduto(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  function fPedidoFaturadoParcialmente(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  function fPedDevolucao(strNumPed: String): Boolean;

  function fRetCodForFilial: String; overload;
  function fRetCodForFilial(strCodEmp: String): String; overload;
  function fFornecedorFilial(strCodFor: String): Boolean;
  function fRetEmpresaFornecedorFilial(strCodFor: String): String;

  function fRetAliquotaIssCidade(strCodCid: String): Double;
  function fRetReducaoBaseIssCidade(strCodCid: String): Double;

  function fRetNossoNumeroDisponivel(strBcoBol, strNosNum, strBcoIni: String;
    intCodCar: Integer; strCodEmp: String): String;

  {*******************************************}
  {* =====> GERA TXT PARA O BOLETO.EXE <=====*}
  {*************************************MV*ED*}
  function fGeraBoletoLaser(strNumBco: String;
                            cpuCampos: TCamposUso;
                            fltPerMor: Double;
                            strNosNum,
                            strNumDig: String;
                            strNomEmp,
                            strCgcEmp,
                            strBcoIni: String;
                            intCodCar: Integer;
                            var strArqBoletos: String;
                            var ABoletoCarneBuilder : TBoletoCarneBuilder;
                            var ABoleto1ViaBuilder : TBoleto1Via_ComprovanteBuilder;
                            strMens01: String = '';
                            strMens02: String = '';
                            strReimpr: String = 'N';
                            strOpcFil: String = '';
                            blnBolPdf: Boolean = False;
                            strBraCrr: String = '';
                            strBB_Crr: String = '';
                            strConCrr: String = '';
                            strNomeForm: String = '';
                            strNomeFila: String = '';
                            fltMulta: Double = 0;
                            blnForcarImp: Boolean = False;
                            blnEnvioDeEMailAutomatico: Boolean = False;
                            strChaveCarteira: String = '';
                            strSelObs: String = '';
                            blnConsulta: Boolean = False;
                            strMsgProrrogacao : String ='';
                            blnBolEnvEmail: Boolean = False;
                            blnEnvioFaturamento: Boolean = False;
                            AReimprimirBoletoOriginal : Boolean = False): Boolean;

  Function fRetEspDocBoleto(sCodEsp : String) : String;

  function fRetTotIte: Double;

  function fDocumentoEmRomaneio(strNumDoc, strEspDoc: String; strCodEmp: String = ''): String;

  function fClaFisPermiteGarantia(const strClaFis: String): Boolean;
  function fRetTempoGarantia(strCodIte, strClaFis: String): Integer;
  function fRetPreUve(strCodEmp, strCodIte: String): Double;
  function fRetPreCus(strCodEmp, strCodIte: String): Double;


  function fVerificaClaFisForFil(strCodFor: String): Boolean;

  function fRetornaUltimaParcela(strNumDup, strEspDoc: String): String;

  function fRetVendedor2PedOrc(Const strSeqGer: String): String;
  function fRetVendedor2MovDet(Const strSeqGer, strEspDoc: String): String;
  function fRetValorCampo(Const strSeqGer, strTabela, strAbrTbl, strCampo_: String): String;

  procedure pGeraBackup; // realiza o backup do sistema

  function fStringRepetida(Const strString: String): Boolean;

  Function fGetProxNumSelEntradaMerc: Integer;

  function fVerificaItemEspecial: Boolean;

  function fDuplicataPrincipalBaixada(strNumDup, strParcel, strEspDoc,
    strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;

  Function fTemDuplicataPosteriorBaixada(strNumDup,
                                         strParcel,
                                         strEspDoc,
                                         strCodEmp,
                                         strCodCli: String;
                                         intSeqBai,
                                         intSeqCon: Integer): Boolean;

  function fTemTransfEstoque(intDiasTolerancia: Integer = 0): Boolean;
  function EstaConciliado(ASeqLan,ATabela: String;
                          ATipoBaixa: String = '';
                          ADtaConIsNotNull: Boolean = False;
                          ACodEmp: String = '';
                          ANumDup: String = '';
                          AParcel: String = '';
                          AEmpDup: String = '';
                          ASerie : String = '';
                          ADtaPag: TDateTime = 0;
                          ACodigoFornecedor: String = ''): Boolean;

  function fVerificaSeDuplicataEstaVinculadaParaConciliacao(strNumDup: String = '';strParcel: String = '';
                                                            strCodEmp: String = '';strForCli: String = '';
                                                            strEspDoc: String = '';strSerie_: String = '';
                                                            strTabela: String = '';strSeqLan: String = '') : Boolean ;
  function fGetSqlVinculada(strTabela : String = ''): String;

  function fItemAtivoParaCompras(strCodIte: String): Boolean;
  function fItemRealizaEnderecamento(strCodIte: String): Boolean;
  function fItemJaRealizadoEnderecamento(strAutInc: String): Boolean;
  function fRetMargemBruta(strCodIte, strTabPre: String): Double;
  function fRetornaPortadorCliente(strCodCli: String): String;
  function fRetornaStatusCliente(strCodCli: String): String;
  function fRetornaStatusCadastro(strCodigo, strTipo, strTabela, strCampo: String): String;
  function fValidaCodForFab(strCodFor, strCodFab, strCodIte: String; Var strItem: String): Boolean;
  function fEmpresaTemAcessoCondicaoPagto(strCodigo: String): Boolean;
  function fEmpresasTemAcessoPortador(strCodPor: String;
                                      objDataSet: TDataSet;
                                      strCodEmpFieldName: String;
                                      out strEmpSemAcesso: String;
                                      strFilter: String = ''): Boolean; Overload;
  function fEmpresasTemAcessoPortador(strCodPor: String;
                                      strCodEmps: TStrings;
                                      out strEmpSemAcesso: String): Boolean; Overload;

  function fEmpresasTemAcessoPortador(ACodPor: String;
                                      AArrEmpresas: TConsultasArray;
                                      out AEmpSemAcesso: String): Boolean; Overload;

  function fUsuarioTemAcessoEmpresa(ACodOpe: String;
                                    AArrEmpresas: TConsultasArray;
                                    out AEmpSemAcesso: String): Boolean;

  function fVerificaLinDigCtaPag(blnInserindo: Boolean;
                                 strLinDig: String = '';
                                 strCodBar: String = '';
                                 strAutoIncrem: String = ''): TStringList;

  {********************************}
  {* FUNCAO SIMILAR A POS()       *}
  {*****************************PH*}
  function fPos(const SubStr, S: String): Boolean;
  function fPosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;

  function fPedidoPossuiDuplicatasBaixadas(strNumPed: String): Boolean;

  function fArquivoRetornoTxtBemaFI32: String;

  function fCriaCdsCheques(AOwner: TComponent): TUniClientDataSet;
  procedure pLocksTravados(blnPerRem, blnMostraVazio: Boolean);

  procedure pDefineLayoutImpressao(strEspecie: String; Var strColRel, str40ColS: String;
    strEntFut: String);

  function fDigitaValor(var fltValor: Double;
                        strTitulo: String;
                        strFormato: String = '#,##0.00';
                        blnPermiteZero: Boolean = False;
                        blnPermiteMenorZero: Boolean = False): Boolean;overload;

  function fDigitaValor(var fltValor: Double;
                        var blnReplicaTabela: Boolean;
                        var blnReplicaValorItens: Boolean;
                        strTitulo: String;
                        strFormato: String = '#,##0.00';
                        blnPermiteZero: Boolean = False;
                        blnPermiteMenorZero: Boolean = False;
                        blnRediMensionaTela: Boolean = False;
                        blnRepeticaoPrecoMargem: Boolean = False;
                        AblnValidaEscala: Boolean = False;
                        AfltEscalaMinimo: Double = -1;
                        AfltEscalaMaximo: Double = -1): Boolean;overload;


  function fDigitaValor(var fltValor: Double;
                        var fltValorEmb: Double;
                        fltFator: Double;
                        strTitulo: String;
                        strFormato: String = '#,##0.00';
                        blnPermiteZero: Boolean = False;
                        blnPermiteMenorZero: Boolean = False): Boolean;overload;

function fDigitaValor(var fltValor: Double;
                      var fltValorEmb: Double;
                      var blnReplicaTabela: Boolean;
                      var blnReplicaValorItens: Boolean;
                      fltFator: Double;
                      strTitulo: String;
                      strFormato: String = '#,##0.00';
                      blnPermiteZero: Boolean = False;
                      blnPermiteMenorZero: Boolean = False;
                      blnRediMensionaTela: Boolean = False;
                      blnRepeticaoPrecoMargem: Boolean = False;
                      AblnValidaEscala: Boolean = False;
                      AfltEscalaMinimo: Double = -1;
                      AfltEscalaMaximo: Double = -1): Boolean;overload;


  function fGetValorXml(nodNo: IXMLNode; strNome: String; varTipVar: TVarType = varString;
    strDateFormat: String = 'YYYY-MM-DD'; chrDateSeparator: Char = '-'; blnDateTime: Boolean = False): Variant;

  function fGetXmlChildValoresEmTStrings(nodNo: IXMLNode): TStrings;

  function fDocumentoPossuiItemConcreto(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

  function fQuantidadeItensPedido(strNumDoc, strEspDoc, strCodEmp: String): Integer;

  procedure pRetPrecoItem(strCodIte, strCodEmp: String; Var fltCnv_Ml, fltPreVe1, fltPreCus: Double);

  function fGravaVendaMadeira(strAutInc, strTabela: String; recMadeira: TDadosMadeira): Boolean;

  function fRetornaAtividadeCliente(strCodCli: String): String;

  function fRetornaPerComProfissional(strCodDiv: String): Double;

  function fRetornaDesAceCnd(strCodCnd: String): Double;
  function fRetornaDesAcePrazoCnd(strCodCnd, strConPag : String): Double;
  function fRetornaDesAceUnicoPorVenda(strCodCnd: String): Double;
  function fRetCampoCndPagto(strCodCnd, strCampo: String): Boolean;
  function fCobrarDespAcessCondPagto(strCodCnd, strCodCli, strTipFat: String): Boolean;
  function fJaCobrouDespesasAcessoriasNaDezena(strCodCli: String): Boolean;
  function fTemVendaComDespesasAcessorias(strCodCli: String; dtaDataInicial: TDateTime): Boolean;

  function fClienteImprimeBoletoPelaEmpresa(strCodCli: String): Boolean;

  function fClienteRetemISS(strCodCli: String): Boolean;

  Function fVerificaVariacaoPreco(qryItePed: TUniQuery; strCodIte: String;
                                  fltValUni, fltOciVlr: Double): Boolean;

  Function fVerificaQuantidadeAMaior(strCodIte: String;
                                     fltQtdDig, fltQtdAnt: Double;
                                     cdsItens: TUniClientDataSet;
                                     qryItePed: TDataSet;
                                 Var fltQtdOri: Double;
                                 var fltQtdNov: Double): Boolean;

  function fPainelAtualizado: Boolean;
  function fValidaAliqIPI(Var strDesIte : String; Lista: TStrings = nil): Boolean;

  function fItemAtivo(Var strDesIte : String; Lista: TStrings = nil): Boolean;
  function fItemAtivoCompra(Var strDesIte : String; Lista: TStrings = Nil): Boolean;

  Function fVerificaQuantidadeDiferente(strCodIte: String;
                                     fltQtdDig, fltQtdAnt: Double;
                                     cdsItens: TUniClientDataSet; qryItePed: TDataSet;
                                     blnSenDif: Boolean): Boolean;

  function fSelecionaDuplicatasCredito(   strCodCli: String;
                                          fltValorTotal: Double;
                                       Var stlDupCred,
                                           stlLckDup: TStringList;
                                       Var fltTotCred: Double;
                                           strDataCorte: String;
                                           fncTravaUtiCred: TfncTravaUtiCred = Nil;
                                           blnExibirTela: Boolean = True;
                                           fltValorNegociado: Double = 0;
                                           objLiberacao: ILiberacao = Nil;
                                           strOpcDocTrue: String='';
                                           blnTentaAcharTambemPelaDuplicataOriginal: Boolean = False;
                                           strCrtDevSintetizadasConfDocs: String = '';
                                           blnDescontaCreditoAutomatico: Boolean = False;
                                           blnUsaEmpOri : Boolean = False): Boolean;

  function fValidaMaiorZero(dbe: TDBEditFocus; strCampo: String): Boolean;

  function fTemEntFut(strNumPed, strEspPed, strCodEmp: String): Boolean;
  function fTemServico(strNumPed, strEspPed, strCodEmp, strCodCli: String): Boolean;
  function fTemVidro(strNumPed, strEspPed, strCodEmp: String): Boolean;
  function fTemRetira(strNumPed, strEspPed, strCodEmp: String; strFDO_SEQGER: String = ''): Boolean;
  function fVerificaSeTemEntregaRetira(strNumPed, strEspPed, strCodEmp, strEntRet: String; strFDO_SEQGER: String = ''): Boolean;

  function fTemAbastecimento(strNumDoc, strEspDoc, strCodEmp: String; opcAbastecimento: TOpcAbastecimento; blnSomenteEmpDif: Boolean = False): Boolean;

  function fTemServicoPD(strCodEmp, strNumDoc, strCodCli: String): Boolean;
  function fGetCorFonteEdit(clCorFundo: TColor): TColor;
  function fGetNumbers(strTexto: String): String;

  Function fCondicaoPagamentoClienteOk(strOpcDoc, strCondic: String; strTipFC: String; strCodCliParam : String; strCndLib : String = ''; blnOriF11: Boolean = False): Boolean;
  procedure pMsgCondicoesPagtoPermitidasCliente(strCodCnd: String; stlCndPag: TStringList);
  function fItemNaoFracionavel(strOpcDoc, strCodUni: String; blnCarregandoEstrutura: Boolean=False; qryUni: TUniQuery=NIL): Boolean;
  procedure pFinalizaLibrarys(blnDestroyTinta: Boolean = True);

  function fUtilizaTravaMaxUtilCredProfissional(fltValor: Double): Boolean;
  procedure pDestravaDuplicatas(strChaLck: String);
  function  fTravaDupCreditoProf: Boolean;
  procedure pDestravaDupCreditoProf;
  function fVerificaCredProfissionaisMes(fltValor: Double; Var fltCreUti: Double): Boolean;
  function fVerificaDocumentoRequisicaoCompra(strEspSel, strNumDoc, strCodEmp: String): Boolean;
  function fItemComRequisicaoEmAberto(strCodEmp, strCodIte: String): Boolean;
  function fPedComRequisicaoEmAberto(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  function fGetSqlPedComRequisicaoEmAberto: String;

  function fTemItensEntregaRetira(strTabConf: String): Boolean;
  function fPodeMarcarEntregaRetira(qry: TUniQuery; strTabConf: String; strEntRet: String=''): Boolean;
  function fRetTotItemServ: Double;
  function fTinDorBaixado(strNumDoc, strEspDoc, strCodEmp: String; blnSomenteNaoFaturado: Boolean = False): Boolean;
  function fRetCodOpeSolicitante(strParOpcDoc, strParCodOpe: String): String;
  function fEmpresaUsaTransferenciaOuVenda(strCodEmp,strCodFilial : String) : Boolean;
  function fValidaPlaVei(strPlaVei:string) : Boolean;

  function fDisparaEmailSimples(strNumDoc,
                              strOpcDoc,
                              strEspDoc,
                              strNumOrc,
                              strEspOrc,
                              strEmpOri,
                              strCodDes: String;
                              AQrCodePix: String = '';
                              ALinkCitelPix: String = ''): Boolean;

  function fDisparaEmailAutomatico(strNumDoc,
                                   strOpcDoc,
                                   strEspDoc,
                                   strNumOrc,
                                   strEspOrc,
                                   strEmpOri,
                                   strCodCli : String;
                                   AQrCodePix: String = '';
                                   ALinkCitelPix: String = '';
                                   objGeraAnexo : IGeraArquivoAnexoEmailAutomatico = Nil;
                                   strCodCup: String = '';
                                   strAutInc: String = '';
                                   strFisAcesso: String = '';
                                   strSerie_: String = '';
                                   strAutIncNotfic: String = '';
                                   strCodOpe: String = '';
                                   blnResultTrueCasoEmailEmBranco: Boolean = False;
                                   blnResultTrueCasoGatilhoDesativado: Boolean = False;
                                   const blnAssincrono: boolean = True;
                                   strInfAdi: String = '';
                                   strCodRastreio: String = ''): Boolean;

  procedure pRetornarModeloEmailAutomatico(strEmailTela,
                                           strNumDoc,
                                           strOpcDoc,
                                           strEspDoc,
                                           strNumOrc,
                                           strEspOrc,
                                           strEmpOri,
                                           strCodCli      : String;
                                           var strModelo  : String;
                                           var strAssunto : String;
                                           out ADadosAutenticacao: TDadosLoginEmail;
                                           blnVerSomenteLayoutAtivo : Boolean = False;
                                           AQRCodePix: String = '';
                                           ALinkCitel: String = '');
  function fDisparaEmailBoletoAutomatico(objDados : TDadosDisparaEmail;
                                         strOpcDoc: String = 'BO';
                                         objStatus: TStatusDisparaEmail = staNenhumaAcao;
                                         blnAssincrono: Boolean = False): Boolean;

  procedure pGetMensagemEMASAI(Var FCorpo: TStringArray;
                               Var FAssunto: String;
                               objDados : TDadosDisparaEmail;
                               strOpcDoc: String;
                               objStatus: TStatusDisparaEmail;
                               var ADadosLogin: TDadosLoginEmail;
                               var ACodigoGrupoModelo: String;
                               var ACodigoModelo: String);

  function RetonaQRCodePixPedido(AQrCodePix,
                                 ALinkCitelPix: String;
                                 AEmail: Boolean = True): String;

   function RetornaValorSemZerosEsquerdaSMS(AValor: String): String;

  function fRetornarDataEntregaRota(strCodRot: String): TDate;
  function fDisparaSMSAutomatico(strNumDoc,
                                 strOpcDoc,
                                 strEspDoc,
                                 strNumOrc,
                                 strEspOrc,
                                 strEmpOri,
                                 strCodDes: String;
                                 AQrCodePix: String = '';
                                 const blnAssincrono: boolean = True;
                                 strCodCup: String = '';
                                 objGeraAnexo : IGeraArquivoAnexoEmailAutomatico = Nil;
                                 blnEnviarWhatsapp: Boolean = False;
                                 strAutInc: String = '';
                                 strFisAcesso: String = '';
                                 strSerie_: String = '';
                                 strUnitDisparo: String = '';
                                 strAutIncCtt: String = '';
                                 strCelularEnv: String = '';
                                 strFilaEnv: String = '';
                                 strAutIncNotfic: String = '';
                                 strCodigoDoServico: String = '';
                                 strCodigoStatusServico: String = '';
                                 blnResultTrueCasoCelularEmBranco: Boolean = False;
                                 blnResultTrueCasoGatilhoDesativado: Boolean = False;
                                 DestinatarioWhatsapp: TDestinatarioWhatsapp = nil;
                                 strInfAdi: String = '';
                                 strLinkPagamento: String = '';
                                 recArquivos: TArray<TRecArquivosGatilhos> = nil;
                                 strCodIte: String = '';
                                 strCodRastreio: String = ''): Boolean;

   function fDisparaWhatsappSimples(strNumDoc,
                                   strOpcDoc,
                                   strEspDoc,
                                   strNumOrc,
                                   strEspOrc,
                                   strEmpOri,
                                   strCodDes: String;
                                   AQrCodePix: String = ''): Boolean;

  function fDisparaWhatsappAutomatico(strNumDoc,
                                      strOpcDoc,
                                      strEspDoc,
                                      strNumOrc,
                                      strEspOrc,
                                      strEmpOri,
                                      strCodDes: String;
                                      AQrCodePix: String = '';
                                      const blnAssincrono: boolean = True;
                                      strCodCup: String = '';
                                      objGeraAnexo : IGeraArquivoAnexoEmailAutomatico = Nil;
                                      strAutInc: String = '';
                                      strFisAcesso: String = '';
                                      strSerie_: String = '';
                                      strUnitDisparo: String = '';
                                      strAutIncCtt: String = '';
                                      strCelularEnv: String = '';
                                      strFilaEnv: String = '';
                                      strAutIncNotfic: String = '';
                                      strCodigoDoServico: String = '';
                                      strCodigoStatusServico: String = '';
                                      blnResultTrueCasoCelularEmBranco: Boolean = False;
                                      blnResultTrueCasoGatilhoDesativado: Boolean = False;
                                      DestinatarioWhatsapp: TDestinatarioWhatsapp = nil;
                                      strInfAdi: String = '';
                                      strLinkPagamento: String = '';
                                      recArquivos: TArray<TRecArquivosGatilhos> = nil;
                                      strCodIte: String = '';
                                      strCodRastreio: String = ''): Boolean;

  function fDisparaSMSBoletoAutomatico(objDados: TDadosDisparaSMS;
                                       strOpcDoc: String = 'BO';
                                       objStatus: TStatusDisparaEmail = staNenhumaAcao;
                                       blnEnviaWhatsapp: Boolean = False;
                                       DestinatarioWhatsapp: TDestinatarioWhatsapp = nil): Boolean;

  function fDisparaWhatsappBoletoAutomatico(objDados: TDadosDisparaSMS;
                                            strOpcDoc: String = 'BO';
                                            objStatus: TStatusDisparaEmail = staNenhumaAcao;
                                            DestinatarioWhatsapp: TDestinatarioWhatsapp = nil): Boolean;

  function fRetFilaEContatoEnvio(var strAutIncCtt: String;
                                 var strCelular: String;
                                 var strFilaEnv: String;
                                     strCodCli,
                                     strNomCli,
                                     strCodigoGatilho,
                                     strCodigoGrupoGatilho: String;
                                     blnAbreTela: Boolean): Boolean;

  function fRetFilaDeAtendimentoEmAndamento(strCelular: String): Extended;
  function fEnvioDeArquivoObrigatorio(strOpcDoc: String): Boolean;

  function fValorTef(fltValor: Double): String;
  function fDatasetDistinctField(objDataSet: TDataSet; strFieldName: String): TStringList;
  function fRetSQLEspDocsNaoListadosNaExpedicao(Const strCampoEspDoc: String = 'GER_ESPDOC'): String;

  procedure pIniciarConexao;

  function fEhDuplicataOriginadaDeConverte(strNumDup: String = '';strParcel: String = '';
                                           strCodEmp: String = '';strForCli: String = '';
                                           strEspDoc: String = '';strSerie_: String = '';
                                           strTabela: String = '') : Boolean ;
  function fGetTextSqlConvertida(strTabela : String = ''): String;

  function fValidaRecebimentoDeCreditoPorPortador(AstrNumeroDocumento,
                                                  AstrEspecieDocumento,
                                                  AstrEmpresaDocumento : String;
                                                  var AMensagem : String;
                                                  AParcelaDocumento : String = '';
                                                  AClienteDocumento : String = '') : Boolean;
  procedure AddSql(out ADateSet:TUniQuery;
                       ACondicao:Boolean;
                       ASql:String);

  function fStringToArray(strValue: String): TArrayString;
  function fRemoveItensDuplicadosEmArray(var arrValue: TArrayString): TArrayString;
  procedure fAvisoClienteTemCreditoDisponivel(arrCodCli: TArrayString);
  function fTravaAliquota: Boolean;
  function TipoCalculoSTGareImportacaoXMLToInt(Value: TTipoCalculoSTGareImportacaoXML): integer;
  function IntToTipoCalculoSTGareImportacaoXML(Value: Integer): TTipoCalculoSTGareImportacaoXML;

  function fRemoverPercentual(strValor: String): String;
  function fSuprimirZeroDireita(strValor: String): String;

  function fExistePedidoAbastecimento(Const strNumPed, strEspPed, strEmpPed: String; Out strNmPdAb, strEsPdAb, strEmPdAb: String): Boolean;

  procedure pLimparImpressoraSelecionaBoleto;
  function fAlgumaEmpresaUtilizaRegimeEspecial: Boolean;


  function fAtualizaMovTriValoresCalculadosDoFrete(strSeqGer: String; fltValorFreteCalculado, fltValorConhecimentoCalculado: Double): Boolean;
  function fRetEmpOriRegimeEspecial(Const strNumDoc, strEspDoc, strCodEmp: String): String;

  function fRetJustificativaNegacaoMsgAnterior(Const strCodLib, strCodCli: String): String;

  function fDisparaSMSWhatsappAutOS(strNumOSe,
                                    strCodEmp,
                                    strCodCli: String;
                                    staStatus: TStatusDisparaEmail;
                                    var blnModeloAtivado: Boolean;
                                    blnEnviarWhatsapp: Boolean = False;
                                    recArquivos: TArray<TRecArquivosGatilhos> = nil): Boolean;

  function fVaiCalcularRetencoesServicos(ANumDoc, AEspDoc, ACodEmp, ACodCli: String): Boolean;
  procedure pValidaPDComAbastecimentoTransf(strNumDoc, strEspDoc, strEmpDoc: String; var AMensagem: TStringList);

  function fGatilhoEmailWhatsappSmsEstaAtivado(tipGatilho: TTipoGatilho;
                                               strOpcDoc,
                                               strEspDoc: String;
                                               strNumOrc: String = '';
                                               strEspOrc: String = ''): Boolean;

  procedure pSalvarXmlReinf(tpXml: TtpXmlReinf; cdsLote: TUniClientDataSet);

  function fTemDisparoDeOutroGatilhoNaSequencia(const strCodigo,
                                                      strCodGru: String;
                                                const blnGatilhoAtualFoiDisparado: Boolean;
                                                  var blnDispararNaSequenciaGatilhoInclusaoDePedido: Boolean): Boolean;

  function RetornaLinkImagemPixCitel(ATextoQRCode: String; ATamanho: Integer = 150): String;

  function fPermiteFaturamentoPedidoComItemEstruturaSemOrdemProducao(strNumDoc, strCodEmp: String; objLiberacao: ILiberacao = Nil): Boolean;

  function fPermiteCodigoProdutoExpedicaoItensMedianteSenha(strCodIte: String; objLiberacao: ILiberacao): Boolean;

  function fValidaPortadorDataPDD(ACodigoPortador, ACodigoEmpresa: String; Var ADataTrocaPortador : TDateTime; APortadorAnteriorPDD: Boolean): Boolean;
var
  fltJur: Double;

  blnImprime_Vencimentos_Orcamento : Boolean;

  arrLogAvi: TArrLogAvi;
  arrLogAviAux: TArrLogAvi;

  arrTravasLibFinalVenda: TArrTravaFaturamento;

  {*****************************************}
  {* TRUE CASO ESTEJA LIBERADO PARA CONFI- *}
  {* GURAR O BOLETO                        *}
  {**************************************MV*}
  blnLibCnf: Boolean;

  CorZebra : TColor;

  blnRede : Boolean;

  arrMenu       : Array Of TIndMenus;
  arrMenuPri    : Array Of TIndMenus;

  {*****************************************}
  {* VARIÁVEIS GLOBAIS DE CONFIGURAÇÃO MO- *}
  {* NETÁRIA                               *}
  {**************************************MV*}
  intPrecisao: Integer = 12;

  intMesGir: Integer;

  {*****************************************}
  {* REPRESENTA O COMANDO DE IMPRESSÃO     *}
  {**************************************MV*}
  strCmdLpr: String = 'lpr-cups';

  pMostraMensTEF: TProcMensagemTEF;

implementation

uses  untDigDuplicata, IdEMailAddress,
      untDesbloqueiodaCopia, untDigData, untFecGiroEstoque, untDigValor,
      untModulo, untThreadUtils,
      untPesqAux, untRelacaoLocks,
      untFatMostraCreditos,
      untFuncoesBoleto, untFuncAutban,untObservacao,
      untModuloReplicacao, untMadeireira,
      untDigDtaNovo, untGravando, untDuplicatas, System.Generics.Defaults,
      EmailContasReceber.Classes, untDisparaEmailAut,
      untQualiZapGetClientOpenChats, untFilaEContatoEnvio;

procedure pIniciarConexao;
begin
  {***********************************************************}
  {* CASO NAO CRIE OS MODULOS GRAVA ERRO E ENCERRA APLICACAO *}
  {********************************************************JC*}
  Try
    pCriarFormularios(TfrmModulo, frmModulo);
    pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));
  Except
    On E: Exception Do
    Begin
      TThreadFinalizarAutcomMonitor.Monitorar;
      pMensagensErro(E.Message, '[frmPrincipal]');
      Application.Terminate;
    End;
  End;
end;

{***********************************************************}
{*                                                         *}
{*    Procedure e Funções Utilizadas no Banco de Dados     *}
{*                                                         *}
{********************************************************DV*}

{***********************************}
{* VERIFICA SE TABELA ESTA VAZIA   *}
{********************************DV*}
function fIsEmpty(strNomeTabela: String):Boolean;
  Var
    qryGenTmp : TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS QTD FROM ' + strNomeTabela);
      Open;
      Result := FieldByName('QTD').AsInteger <= 0;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function EhNumero(AVariavel: String): Boolean;
begin
  Result := True;

  Try
     StrToInt(AVariavel);
  Except
    Result := False;
  end;
end;

{*********************************}
{* CONFIRMA SENHA DIGITADA       *}
{******************************DV*}
function fConfirmaCadSenha(strSenha1,strSenha2: String): Boolean;
begin
	Result := False;
  If strSenha1 = strSenha2 Then
  	Result := True;
end;

{*******************************************}
{* PEDE UMA DATA                           *}
{****************************************MV*}
function ffrmData(Var dtaData: TDateTime; strCaption, strCaptionLabel: String;
  dtaDtaMin: TDateTime = 0; dtaDtaMax: TDateTime = 0; fValidaDataEntIme: TfuncValidaDataEntIme = nil): Boolean;
  Var
    frmDigData : TfrmDigData;
begin

  If dtaData = 0 Then
    dtaData := VS_Date;

  Try
    pCriarFormularios(TfrmDigData, frmDigData);
    frmDigData.dtaDataMin      := dtaDtaMin;
    frmDigData.dtaDataMax      := dtaDtaMax;
    frmDigData.Caption         := strCaption;
    frmDigData.lblData.Caption := strCaptionLabel;
    frmDigData.fValidaDataEntIme := fValidaDataEntIme;

    Try
      frmDigData.dtmData.Date    := dtaData;
    Except
      frmDigData.dtmData.Date    := VS_Date;
    End;

    Result := (frmDigData.ShowModal = mrOk);

    If (Result) Then
      dtaData := frmDigData.dtmData.Date;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ffrmData]');
    End;
  End;

  pFreeAndNil(frmDigData);

end;

{*********************************************************}
{* RETORNA O PROXIMO CODIGO, PORÉM NÃO ATUALIZA O PROCOD *}
{******************************************************MV*}
function fRetornaProCod(strNomeTabela: String): String;
  Var
    intCodigoAtual: Integer;
    intTamCodigo  : Integer;

    strSQL   : String;
    qryGenCod: TUniQuery;

begin
//  fLock_Unlock('PROCOD', True);

  Try
    pValidaProCod(strNomeTabela);

    qryGenCod := fCriaQuery;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PRO_CODSEQ AS CODSEQ, ';
      strSQL := strSQL + '  PRO_TAMCOD AS TAMCOD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PROCOD ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
      strSQL := strSQL + ' FOR UPDATE ';

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        Open;

        If IsEmpty Then
        Begin
          Close;
          Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                 'na tabela de Próximos Codigos! Verifique.' + #13#10);
        End;

        intCodigoAtual := FieldByName('CODSEQ').AsInteger;
        intTamCodigo   := FieldByName('TAMCOD').AsInteger;
        Close;
      End;

    Except
      On E: Exception Do
      Begin
        Raise ExceptClass(E.ClassType).Create('Não consegui pegar o proximo sequencial de ' + strNomeTabela +
          ' em PROCOD. Tente novamente! ' + sLineBreak + '[' + E.Message + ']');
      End;
    End;

    Result := fPadL(IntToStr(intCodigoAtual), intTamCodigo, '0');

  Finally
    FreeAndNil(qryGenCod);
  End;

end;

{*****************************************}
{* RETORNA TRUE CASO O USUARIO JA EXISTE *}
{**************************************RV*}
function fVerificaUsuarioMotorista(strUsuario: String): Boolean;
  Var
    strSQL   : String;
    qryGenMot: TUniQuery;
begin
  Try
    qryGenMot := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MOT_USUMOT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADMOT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MOT_USUMOT = :USUARI ';

    With qryGenMot Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('USUARI').AsString := strUsuario;
      Open;
      If IsEmpty Then
        Result := False
      Else
        Result := True;
    End;

  Finally
    FreeAndNil(qryGenMot);
  End;
end;

//ja existe esta funcao na untCadRec
{function fRetSeqBai(strNomeTabela, strNumDup, strParcel, strCodEmp, strEspDoc,
  strCodCli: String): Integer;
  Var
    strSQL   : String;
    qryGenRec: TUniQuery;

begin
  Try

    qryGenRec := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MAX(CTR_SEQBAI) AS QTD ';
    strSQL := strSQL + 'FROM ';
  //  strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + strNomeTabela + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    With qryGenRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      Result := FieldByName('QTD').AsInteger;
      Close;
    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;}

{************************************************}
{* VERIFICA SE A LINHA DIGITÁVEL OU CÓDIGO DE   *}
{* BARRAS JÁ ESTÁ CADASTRADO NO CONTAS A PAGAR  *}
{**********************************REQ: 63966*AJ*}
function fVerificaLinDigCtaPag(blnInserindo: Boolean;
                               strLinDig: String = '';
                               strCodBar: String = '';
                               strAutoIncrem: String = ''): TStringList;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;
Begin
  Result := TStringList.Create;
  If (fEmptyStr(strLinDig)) And (fEmptyStr(strCodBar)) Then
    Exit;

  Try
    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTP_NUMDUP, CTP_SERIE_, CTP_PARCEL, CTP_CODFOR, FOR_NOMFOR, ';
    strSQL := strSQL + '  CTP_DTACAD, CTP_DTAVEN, CTP_CODEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' CADPAG ';
    strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ';
    strSQL := strSQL + 'WHERE TRUE AND (';
    If Not fEmptyStr(strCodBar) Then
      strSQL := strSQL + ' CTP_CODBAR = :CODBAR ';
    If Not fEmptyStr(strLinDig) Then
    Begin
      If Not fEmptyStr(strCodBar) Then
        strSQL := strSQL + ' OR ';

      strSQL := strSQL + ' CTP_LINDIG = :LINDIG ';
    End;
    strSQL := strSQL + ') ';

    If Not blnInserindo Then
      strSQL := strSQL + ' AND CADPAG.AUTOINCREM <> :AUTOINC ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If Not fEmptyStr(strCodBar) Then
        ParamByName('CODBAR').AsString := strCodBar;
      If Not fEmptyStr(strLinDig) Then
        ParamByName('LINDIG').AsString := strLinDig;
      If Not blnInserindo Then
        ParamByName('AUTOINC').AsString := strAutoIncrem;

      Open;

      If RecordCount > 0 Then
      Begin
        Result.Add(Fields[0].AsString);
        Result.Add(Fields[1].AsString);
        Result.Add(Fields[2].AsString);
        Result.Add(Fields[3].AsString);
        Result.Add(Fields[4].AsString);
        Result.Add(FormatDateTime('dd/mm/yyyy', Fields[5].AsDateTime));
        Result.Add(FormatDateTime('dd/mm/yyyy', Fields[6].AsDateTime));
        Result.Add(Fields[7].AsString);
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;
End;

function fRetornaQtdRegistros(strTabela: String): Integer;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabela;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := Fields[0].AsInteger;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function fRetornaSequencialUnico(strNomSeq: String; strCodEmp: String = ''; blnNovaConexao: Boolean=False): Int64;
var
  LConn: TCriarConexao;
begin
  if not blnNovaConexao then
  begin
    Result := fRetornaSequencialUnico(strNomSeq, strCodEmp, frmModulo.GetCurrentConnection);
    Exit;
  end;

  LConn := TCriarConexao.Create('fRetornaSequencialUnico('+strNomSeq+', '+strCodEmp+')');
  try
    Result := fRetornaSequencialUnico(strNomSeq, strCodEmp, LConn.objConexao);
  finally
    FreeAndNil(LConn);
  end;
End;

function fRetornaSequencialUnico(strNomSeq: String; strCodEmp: String; AConn: TUniConnection): Int64;
  Var
    blnComita: Boolean;
    qryCfgSis: TUniQuery;
    blnGravaLog: Boolean;
begin
  blnGravaLog := VS_blnGravaLogTransacao;
  Try
    Result := 1;

    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    blnComita := not fInTransaction(AConn);

    qryCfgSis := fCriaQuery(nil, AConn);

    If blnComita Then
    Begin
      VS_blnGravaLogTransacao := False;
      fStartTransaction(AConn);
    End;

    Try
      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                     ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := strCodEmp;
        ParamByName('CODCFG').Value := 'CFG_'+ strNomSeq;
        Open;

        pSetNaoReplicarConfig('CFG_' + strNomSeq);

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := FieldByName('SIS_VALCFG').AsLargeInt
        Else
          Result := 1;

        fAtuCfgSis(strNomSeq, IntToStr(Result+1), strCodEmp, AConn);
      End;

      If blnComita Then
        fCommit(AConn);
    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack(AConn);
        Raise ExceptClass(E.ClassType).Create('Não consegui pegar o proximo sequencial de ' + strNomSeq +
          ' em CFGSIS. Tente novamente! ' + sLineBreak + '[' + E.Message + ']');
      End;
    End;
  Finally
    VS_blnGravaLogTransacao := blnGravaLog;
    FreeAndNil(qryCfgSis);
  End;
End;


function fRetRcxCon(strCodEmp: String = ''): String;
begin
  Result := fStrZero(fRetornaSequencialUnico('RCXCON', strCodEmp, True).ToString, 10);
end;

function fRetMaiorCtpCon: Longint;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT IFNULL((SELECT MAX(CTP_SEQCON) FROM  CADPAG), 0) AS MAX');
    Open;

    Result := FieldByName('MAX').AsInteger;

    Close;
  End;
  FreeAndNil(qryGen);
End;

function fRetCtpCon(strCodEmp: String = ''; blnNovaConexao: Boolean=True): Longint;
begin
  Result := fRetornaSequencialUnico('CTPCON', strCodEmp, blnNovaConexao);
end;

function fRetSeqRCH: Longint;
begin
  Result := fRetornaSequencialUnico('SEQRCH');
end;

{***********************************************}
{* RETORNA O MAXIMO DE UM CAMPO EM UMA TABELA  *}
{********************************************DV*}
function fRetMax(strNomeTabela,strNomeCampo:String):String;
  Var
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT MAX('+strNomeCampo+') AS VALMAX FROM '+ strNomeTabela);
      Open;
      If FieldByName('VALMAX').IsNull Then
        Result := '1'
      Else
        Result := IntToStr(FieldByName('VALMAX').AsInteger);

    End;

    qryGenTmp.Close;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

{********************************************}
{* GRAVA ARQUIVO DE LOG DE ENTRADA E SAIDA  *}
{*****************************************DV*}
procedure pRegistraUsuario(NomeUsuario,Evento:String);
begin
{  Try
    fStartTransaction;
    With frmModulo.qryLogAce do
    Begin
	    Open;
      Insert;
      FieldByName('LOG_NOMUSU').AsString := NomeUsuario;
      FieldByName('LOG_DTALOG').AsDateTime := VS_Date;
      FieldByName('LOG_MAQUIN').AsString := fNomeDoComputador;
      If Evento = 'E' then
	      FieldByName('LOG_DESCRI').AsString := 'Entrou no Sistema'
      Else
  	    FieldByName('LOG_DESCRI').AsString := 'Saiu no Sistema';
      Post;
      fCommit;
      Close;
    End;
  Except
    On E : Exception do
    Begin
      pMensagensErro(E.Message, '[Registra Usuario]');
    End;
  End;}
End;

{***********************************}
{* RETORNA O NOME DO COMPURADOR    *}
{********************************MV*}
function fNomeDoComputador: String;
  {$IFDEF MSWINDOWS}
    Var
      dwrAux: DWord;
  {$ENDIF}
  {$IFDEF LINUX}
    Var
      hostName: PIOFile;
      pchrNomeMaq: Array[0..254] Of Char;
  {$ENDIF}
begin
  {$IFDEF LINUX}
    hostName := popen(PChar('hostname'), 'r');
    If fgets(pchrNomeMaq, 255, hostName) <> Nil Then
      Result := StrPas(pchrNomeMaq)
    Else
      Result := '';
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    dwrAux := MAX_COMPUTERNAME_LENGTH + 1;
    SetLength(Result, dwrAux);
    Windows.GetComputerName(PChar(Result), dwrAux);
    Result := String(PChar(Result));
  {$ENDIF}
end;

{***********************************}
{* GRAVA LOG DE DELECAO            *}
{********************************DV*}
procedure pGravaLogDelecao(NomeTabela,NomeCampo,Informacao: String; dtaDataDelecao: TDateTime; intPosicao: Integer);
begin
{  Try
    fStartTransaction;
    With frmModulo.qryLogDel do
    Begin
	    Open;
      Insert;
      FieldByName('LOG_LOGOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_DTADEL').AsDateTime := dtaDataDelecao;
      FieldByName('LOG_TABELA').AsString   := NomeTabela;
      FieldByName('LOG_NOMCAM').AsString   := NomeCampo;
      FieldByName('LOG_INFOMA').AsString   := Informacao;
      FieldByName('LOG_POSCAM').AsInteger  := intPosicao;
      Post;
      fCommit;
      Close;
    End;
  Except
    On E : Exception do
    Begin
      pMensagensErro(E.Message, '[Log de Deleção]');
    End;
  End;}
end;

{****************************************}
{* VERIFICA SE EXISTE DISCO NA UNIDADE  *}
{*************************************DV*}
function fDiskInDrive(const Drive: char): Boolean;
{	Var
		DrvNum: byte;
		EMode: Word;}
begin
 {result := false;
 DrvNum := ord(Drive);
 if DrvNum >= ord('a') then dec(DrvNum,$20);
 EMode := SetErrorMode(SEM_FAILCRITICALERRORS);
 try
  if DiskSize(DrvNum-$40) <> -1 then
  	result := true
  else
  	messagebeep(0);
  finally SetErrorMode(EMode);
 end;}
 Result := True;
end;

{************************************}
{* COLOCA ASPAS SIMPLES NUMA STRING *}
{*********************************DV*}
function fColocaAspas(strString:String): String;
begin
	Result := #39 + strString + #39;
end;

{***********************************}
{* COMPARA DUAS DATAS             *}
{********************************DV*}
function fCompDatas(strDtaIni,strDtaFin:String): Boolean;
	Var
  	dtaDtaIni, dtaDtaFin : TDateTime;
begin
  Result := False;
  dtaDtaIni := StrToDateTime(strDtaIni);
  dtaDtaFin := StrToDateTime(strDtaFin);
	If dtaDtaIni > dtaDtaFin then
	Begin
    fMensagem('','A data final não pode ser menor que a data inicial.', ['&Ok']);
	End
	Else
	Begin
  	Result := True;
	End;
end;

{*************************************}
{* CONVERTE QUALQUER VALOR EM STRING *}
{**********************************DV*}
function fAnyToStr (const Valor: variant): String;
begin
  Case TVarData(Valor).vType Of
    varEmpty:     Result := 'Empty';
    varNull:      Result := 'Null';
    varSmallInt:  Result := IntToStr(Valor);
    varInteger:   Result := IntToStr(Valor);
    varSingle:    Result := FloatToStr(Valor);
    varDouble:    Result := FloatToStr(Valor);
    varCurrency:  Result := FloatToStr(Valor);
    varDate:      Result := DateToStr(Valor);
    varVariant:   Result := FloatToStr(Valor);
    varUnknown:   Result := '?';
    varByte:      Result := IntToStr(Valor);
    varString:    Result := Valor;
    varBoolean: Begin
                   If Valor Then
                      Result := 'TRUE'
                   Else
                      Result := 'FALSE';
                End;
  End;
end;

{*********************************}
{* ATUALIZA UM LABEL NUMA TELA   *}
{******************************DV*}
procedure pAtuCaptionLabel(Objeto: TLabel; strString:String);
begin
  Objeto.Caption := '';
  Objeto.Refresh;
  Objeto.Caption := strString;
  Objeto.Refresh;
end;

procedure pRaise(const strMensagem: String);
begin
  Raise Exception.Create(strMensagem);
end;

{*******************************************}
{* TIRA CARACTERES ESPECIAIS DE UMA STRING *}
{****************************************DV*}
function fTiraCaracter(strStr: String):String;
	Const
  	strCaracteres : String = ',.;';
  Var
  	intIndice: Integer;
begin
	Result := '';
	For intIndice := 1 To Length(strStr) Do
  Begin
  	If Pos(strStr[intIndice],strCaracteres) = 0 Then
    Begin
			Result := Result + strStr[intIndice];
    End;
  End;
end;

{************************************}
{* PEGA NOME DA ESTAÇÃO NA REDE     *}
{*********************************DV*}
function fGetUsuRede : String;
{	Var
		arrNetName: Array[0..48] of Char;
		iResult: DBIResult;}
Begin
{	iResult:= DBIGetNetUserName(arrNetName);
	If iResult <> DBIErr_None Then
  Begin
		DBIError( iResult )
  End
	Else
  Begin
		Result:= StrPas(arrNetName);
  End;}
end;

function fFormataTamStr(strString: String; intLargura: Integer): String;
begin
  Result := Copy(fstrEspaco(strString, intLargura), 1, intLargura);
end;

function fValidaVencimento(const arrDuplicata: TarrDuplicata): Boolean;
var
  intContador: integer;
begin
  Result      := True;
  intContador := 0;

  While (ArrDuplicata[intContador].dtaDtaVen <> '') And (intContador < 24) do
  begin
    if StrToDateTime(ArrDuplicata[intContador].dtaDtaVen) < VS_Date then
    begin
      Result := False;
      Break;
    end;

    Inc(intContador);
  end;
end;

{**********************************************************}
{* -> RENOMEIRA ARQUIVOS                                  *}
{*******************************************************WI*}
Function fRenomearArquivo( strArqOrigem, strArqDestino : String ):Boolean;
  Var
    intQtdSegundos  : Integer;
    timHoraAnterior : TDateTime;
Begin
  Result := False;

  timHoraAnterior := SysUtils.Time;
  While True Do
  Begin
    Application.ProcessMessages;
    If RenameFile( strArqOrigem, strArqDestino ) Then
    Begin
      Result := True;
      Break;
    End;
    intQtdSegundos := SecondOfTheDay( SysUtils.Time ) - SecondOfTheDay( timHoraAnterior );
    If ( intQtdSegundos > 5 ) Then
      Break;
  End;
End;

function fTiraPontoVirgula(strValor: String): String;
Begin
  Result := AnsiReplaceStr(strValor, '.', '');
  Result := AnsiReplaceStr(Result  , ',', '');
End;
{*****************************************}
{* EXECUTA UM TRANSF IGUAL O CLIPPER :^) *}
{**************************************MV*}
function fTransf(fltValor: Double; intInteiro, intDecimais: Integer): String;
  Var
    strMascara: String;
    strValorFormatado: String;
    intContador: Integer;
begin

  strMascara := '#.';

  For intContador := 1 To intDecimais Do
    strMascara := strMascara + '0';

  strValorFormatado := FormatFloat(strMascara, fltValor);
  Result            := fPadl(strValorFormatado, (intInteiro + intDecimais + 1), ' ') ;

end;

{*********************************************}
{* RETORNA A DESCRIÇÃO DA FORMA DE PAGAMENTO *}
{******************************************AF*}
function fRetDesFpg(strCodigo: String): String;
begin
  Result := fCampoTabela('FPG_DESCRI', 'CADFPG', ['FPG_CODIGO'], [strCodigo], False);
end;

function fGravaAutoIncrem(strNomeTabela: String; intAutInc: Integer): Boolean;
  Var
    strSQL   : String;
    qryGenCod: TUniQuery;

begin
  Try

    qryGenCod := fCriaQuery;

    Try

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PROINC ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  PRO_AUTINC = :AUTINC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

      With qryGenCod Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsInteger := intAutInc;
        ParamByName('NOMARQ').AsString  := strNomeTabela;
        ExecSQL;
        Close;
        Result := True;

      End;

    Except

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaAutoIncrem]');
      End;
    End;

  Finally
    FreeAndNil(qryGenCod);
  End;

end;

{*****************************************}
{* RETORNA TRUE CASO A SENHA JA EXISTE   *}
{**************************************MV*}
function fVerificaSenhaVend(strSenha: String): Boolean;
  Var
    strSQL   : String;
    qryGenOpe: TUniQuery;

begin
  Try

    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  OPE_SENOPE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' BINARY OPE_SENOPE = :SENHA ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SENHA').AsString := fCrypt(strSenha);
      Open;
      If IsEmpty Then
        Result := False
      Else
        Result := True;
    End;

  Finally
    FreeAndNil(qryGenOpe);
  End;

end;

{*****************************************}
{* RETORNA TRUE CASO A SENHA JA EXISTE   *}
{**************************************RV*}
function fVerificaSenhaMotorista(strSenha: String): Boolean;
  Var
    strSQL   : String;
    qryGenMot: TUniQuery;
begin
  Try
    qryGenMot := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MOT_SENMOT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADMOT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' BINARY MOT_SENMOT = :SENHA ';

    With qryGenMot Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SENHA').AsString := fCrypt(strSenha);
      Open;
      If IsEmpty Then
        Result := False
      Else
        Result := True;
    End;

  Finally
    FreeAndNil(qryGenMot);
  End;
end;

{******************************************}
{* RETORNA O PROXIMO SEQUENCIAL DO MOVBAN *}
{***************************************JB*}
function fSeqContaBanco(intQtdCod: Integer = 1): String;
  Var
    strSequen: String;
    LTransacao: TCriarConexao;

    function fSequenCadastrado: Boolean;
      Var
        qryGenTmp : TUniQuery;
    begin
      Try
        qryGenTmp := fCriaQuery(nil, LTransacao.objConexao);
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE CTB_SEQLAN FROM MOVBAN WHERE CTB_SEQLAN = :SEQLAN LIMIT 1');
          ParamByName('SEQLAN').AsString := strSequen;
          Open;
          Result := (Not IsEmpty);
          Close;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    end;

begin
  LTransacao := TCriarConexao.Create('fSeqContaBanco');
  Try
    Repeat
      LTransacao.objConexao.StartTransaction;
      strSequen := VS_strCodEmp + fAtualizaProCod('MOVBAN', '', '', intQtdCod, LTransacao.objConexao);
      LTransacao.objConexao.Commit;
    Until (Not fSequenCadastrado);
    Result := strSequen;
  Finally
    FreeAndNil(LTransacao);
  End;
end;

{*****************************************}
{* RETORNA O SEQUENCIAL DE AGRUPAMENTO   *}
{* CONTAS A RECEBER                      *}
{**************************************JB*}
function fSeqAgrupamentoCtr: String;
begin
  Result := fStrZero(fRetornaSequencialUnico('AGRCTR').ToString, fTamDocCadRec);
end;

{*****************************************}
{* RETORNA O SEQUENCIAL DE AGRUPAMENTO   *}
{* CONTAS A PAGAR                        *}
{**************************************JB*}
function fSeqAgrupamentoCtp: String;
begin
  Result := fStrZero(fRetornaSequencialUnico('AGRCTP').ToString, 10);
end;

function fSeqDespesasProtesto: String;
begin
  Result := fStrZero(fRetornaSequencialUnico('SDESCO').ToString, fTamDocCadRec);
end;

{********************************************}
{* RETORNA O SEQUENCIAL DO PEDIDO DE COMPRA *}
{*****************************************JB*}
function fSeqPedidoCompra: String;
begin
  Result := fStrZero(fRetornaSequencialUnico('PRXPCO').ToString, fTamNumPedCom);
end;

{*****************************************}
{* RETORNA O SEQUENCIAL DO ORÇAMENTO     *}
{**************************************JB*}
function fSeqOrcamento: String;
begin
  Result := fStrZero(fRetornaSequencialUnico('PRXOCO').ToString, fTamNumPedCom);
end;

{*****************************************}
{* RETORNA UM ARQUIVO TEMPORÁRIO LIVRE   *}
{**************************************MV*}
function fPegaArquivoTxt: String;
  Var
    strPath: String;
    intQtdPad: Integer;
    intContador: Integer;
    txtArquivo: TextFile;
begin
  strPath   := fCfgSis('PATTMP');
  intQtdPad := Length(IntToStr(MAX_ARQTMP));

  Result := '';

  For intContador := 0 To MAX_ARQTMP Do
  Begin

    If Not FileExists( fGetPath( strPath + 'tmp' + fPadL(IntToStr(intContador), intQtdPad, '0') + '.txt' ) ) Then
    Begin
      Result := fGetPath( strPath + 'tmp' + fPadL(IntToStr(intContador), intQtdPad, '0') + '.txt' );
      AssignFile(txtArquivo, Result);
      Rewrite(txtArquivo);
      CloseFile(txtArquivo);
      Break;
    End;

  End;

end;

{**********************************************}
{* RETORNA QUANTAS VEZES A STRING 'strSubStr' *}
{* APARECE NA STRING 'strString'              *}
{*******************************************MV*}
function fRetQtrStr(strSubStr, strString: String): Integer;
  Var
    intContador: Integer;
    intLenStr: Integer;
    intLenSubStr: Integer;
begin

  Result       := 0;
  intLenStr    := Length(strString);
  intLenSubStr := Length(strSubStr);

  For intContador := 1 To intLenStr - intLenSubStr + 1 Do
  Begin
    If Copy(strString, intContador, intLenSubStr) = strSubStr Then
      Inc(Result);
  End;

end;

procedure pAtualizaApgTmp;
  Var
    qryApgTmp: TUniQuery;
    qryUpdate: TUniQuery;
    dtaDtaTmp: TDateTime;
Begin
  qryApgTmp := fCriaQuery(Nil);
  qryUpdate := fCriaQuery(Nil);
  Try
    fStartTransaction;
    Try
      qryApgTmp.SQL.Text := 'SELECT * FROM APGTMP ORDER BY APG_DTAAPG DESC FOR UPDATE';
      qryApgTmp.Open;

      If qryApgTmp.IsEmpty Then
      Begin
        qryUpdate.SQL.Text := 'INSERT IGNORE INTO APGTMP (APG_DTAAPG) VALUES (:DTAAPG)';
        qryUpdate.ParamByName('DTAAPG').AsDate := VS_Date;
        qryUpdate.ExecSQL;
      End
      Else
      Begin
        dtaDtaTmp := DateOf(qryApgTmp.FieldByName('APG_DTAAPG').AsDateTime);
        If dtaDtaTmp <> VS_Date Then
        Begin
          qryUpdate.SQL.Text := 'UPDATE APGTMP SET APG_DTAAPG = :DTAAPG WHERE APG_DTAAPG = :DTAAPG_OLD';
          qryUpdate.ParamByName('DTAAPG').AsDate := VS_Date;
          qryUpdate.ParamByName('DTAAPG_OLD').AsDate := dtaDtaTmp;
          qryUpdate.ExecSQL;
        End;
      End;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryApgTmp);
    FreeAndNil(qryUpdate);
  End;
End;

{*****************************************}
{* ZERA O SEQUENCIAL DO MOVBAN E SEQUEN- *}
{* CIAL DE TEMPORARIA TODO INCIO DE DIA  *}
{**************************************MV*}
procedure pZeraCodigoMovBan(blnAutoGiro: Boolean = False);
  Var
    dtaDtaTmp: TDateTime;
    qryGenCfg: TUniQuery;
begin

  Try
    qryGenCfg := fCriaQuery;

    If fEmptyStr(fCfgSisL('DTATMP')) Then
      dtaDtaTmp := 0
    Else
      dtaDtaTmp := fCfgSisL('DTATMP', varDate);

    If dtaDtaTmp <> VS_Date Then
    Begin
      frmModuloReplicacao.sqlMonitor.Active := False;
      Try
        fAtuCfgSis('DTATMP', FormatDateTime('dd/MM/yyyy', VS_Date ) );
        fAtuCfgSis('SEQTMP', '0');
        fAtuCfgSis('SEQGNR', IntToStr(fCfgSisL('SEQGNR', varInteger) + 1));//Sequencial diario remessa GNRE
      Finally
        frmModuloReplicacao.sqlMonitor.Active := True;
      End;
    End;

  Finally
    FreeAndNil(qryGenCfg);
  End;

end;

procedure pApagaTabelasTemporarias;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin

  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SHOW TABLES ';
    strSQL := strSQL + '  LIKE "TMP_%" ';

    With qryGenTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While Not Eof Do
      Begin
        fDropTable(Fields[0].AsString);
        Next;
      End;

    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function fCalcIcms: Boolean;
begin
  Result := fCfgSis('CALICM', varBoolean);
end;

{*****************************************}
{* VERIFICA SE PODE EXCLUIR DETERMINADO  *}
{* ITEM                                  *}
{**************************************MV*}
function fPodeExcluirItem(strCodIte: String): Boolean;
  Var
    strSQL: String;
    qryGenIte : TUniQuery;

begin

  Try

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_SALDOS <> 0 ';
    strSQL := strSQL + '  AND ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      Result := False;
      If FieldByName('QTD').AsInteger = 0 Then
        Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

{*****************************************}
{* CALCULA / RETORNA VALOR DO ICMS       *}
{**************************************MV*}
function fCalculaValorIcms(fltBasIcm, fltAlqIcm: Double; blnRICMPR: Boolean = False): Double;
begin
  Result := (fltBasIcm / 100) * fltAlqIcm;

  If blnRICMPR Then
    Result := Result * 0.6667;
end;

{*****************************************}
{* VALIDA OS CAMPOS DA TABELA DESTINO,   *}
{* COM RELAÇÃO À TABELA ORIGEM, MAS NÃO  *}
{* FAZ O CONTRÁRIO                       *}
{**************************************MV*}
function fVerificaIntegridadeOrigemDestino(strTabOri, strTabDes: String;
  Var lsvFantantes, lsvDivergentes: TListView): Boolean;
  Var
    strSQLOri: String;
    strSQLDes: String;
    intContadorCampos: Integer;
    intContadorDiv: Integer;

    qryGenOri : TUniQuery;
    qryGenTmp : TUniQuery;

begin

  qryGenOri := fCriaQuery;
  qryGenTmp := fCriaQuery;

  Result := True;

  intContadorCampos := 0;
  intContadorDiv := 0;

  If Not fTabelaExiste(strTabDes) Then
  Begin
    lsvDivergentes.Items.Add;
    lsvDivergentes.Items[intContadorDiv].Caption := 'TODAS!';
    lsvDivergentes.Items[intContadorDiv].SubItems.Add(strTabDes);
    lsvDivergentes.Items[intContadorDiv].SubItems.Add('Tabela não Existe!!');
    Inc(intContadorDiv);

    Result := False;
  End;


  strSQLOri := 'DESCRIBE ' + strTabOri;
  strSQLDes := 'DESCRIBE ' + strTabDes;

  {*****************************************}
  {* ABRE ARQUIVO DE ORIGEM                *}
  {**************************************MV*}
  With qryGenTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQLOri);
    IndexFieldNames := 'Field';
    Open;
  End;

  {*****************************************}
  {* ABRE ARQUIVO DE DESTINO               *}
  {**************************************MV*}
  With qryGenOri Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQLDes);
    IndexFieldNames := 'Field';
    Open;
  End;

  {*****************************************}
  {* PROCESSA A TABELA ORIGEM              *}
  {**************************************MV*}
  While (Not qryGenTmp.Eof) Do
  Begin

    If (qryGenOri.Eof) Then
    Begin
      lsvFantantes.Items.Add;
      lsvFantantes.Items[intContadorCampos].Caption := qryGenTmp.FieldByName('Field').AsString;
      lsvFantantes.Items[intContadorCampos].SubItems.Add(strTabDes);
      Inc(intContadorCampos);
      Result := False;
    End

    Else If (qryGenTmp.FieldByName('Field').AsString <>
             qryGenOri.FieldByName('Field').AsString) Then
    Begin

      If (qryGenTmp.FieldByName('Field').AsString <
          qryGenOri.FieldByName('Field').AsString) Then
      Begin

        lsvFantantes.Items.Add;
        lsvFantantes.Items[intContadorCampos].Caption := qryGenTmp.FieldByName('Field').AsString;
        lsvFantantes.Items[intContadorCampos].SubItems.Add(strTabDes);
        Inc(intContadorCampos);

        // Next no Arquivo Original
        qryGenTmp.Next;
        Result := False;
        Continue;

      End
      Else
      Begin

        // Next no Arquivo Destino
        qryGenOri.Next;
        Continue;

      End;

    End
    Else If (qryGenTmp.FieldByName('Type').AsString <>
             qryGenOri.FieldByName('Type').AsString) Then
    Begin

      lsvDivergentes.Items.Add;
      lsvDivergentes.Items[intContadorDiv].Caption := qryGenTmp.FieldByName('Field').AsString;
      lsvDivergentes.Items[intContadorDiv].SubItems.Add(strTabDes);
      lsvDivergentes.Items[intContadorDiv].SubItems.Add(qryGenTmp.FieldByName('Field').AsString + ': ' +
        strTabOri + ' tem tipo ' + qryGenTmp.FieldByName('Type').AsString +
        ' e ' + strTabDes + ' tem tipo ' + qryGenOri.FieldByName('Type').AsString);

      Inc(intContadorDiv);
      Result := False;

    End
    Else If (qryGenTmp.FieldByName('Null').AsString <>
             qryGenOri.FieldByName('Null').AsString) Then
    Begin

      If fEmptyStr(qryGenTmp.FieldByName('Null').AsString) Then
      Begin
        //Campo caixa2 permite nulo e caixa 1 nao
        lsvDivergentes.Items.Add;
        lsvDivergentes.Items[intContadorDiv].Caption := qryGenTmp.FieldByName('Field').AsString;
        lsvDivergentes.Items[intContadorDiv].SubItems.Add(strTabOri);
        lsvDivergentes.Items[intContadorDiv].SubItems.Add(qryGenTmp.FieldByName('Field').AsString + ': ' +
          strTabDes + ' permite nulo e ' + strTabOri + ' não permite ');

        Inc(intContadorDiv);
        Result := False;
      End
      Else
      Begin
        //Campo caixa1 permite nulo e caixa 2 nao
        lsvDivergentes.Items.Add;
        lsvDivergentes.Items[intContadorDiv].Caption := qryGenTmp.FieldByName('Field').AsString;
        lsvDivergentes.Items[intContadorDiv].SubItems.Add(strTabOri);
        lsvDivergentes.Items[intContadorDiv].SubItems.Add(qryGenTmp.FieldByName('Field').AsString + ': ' +
          strTabOri + ' permite nulo e ' + strTabDes + ' não permite ');

        Inc(intContadorDiv);
        Result := False;
      End

    End;

    qryGenTmp.Next;
    qryGenOri.Next;

  End;

  FreeAndNil(qryGenOri);
  FreeAndNil(qryGenTmp);  

end;

function fRetNomFanVen(strCodVen: String): String;
  Var
    strSQL   : String;
    qryGenOpe: TUniQuery;

Begin
  Try

    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODOPE = :CODVEN ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODVEN').AsString := strCodVen;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('OPE_NOMFAN').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenOpe);
  End;

End;

{***************************************************************}
{* RETORNA O CÓD. DO FORNECEDOR DE ACORDO COM O CÓDIGO DO ITEM *}
{************************************************************RL*}
function fRetCodFornecedor(strCodIte: String): String;
Begin
  Result := fCampoTabela('ITE_CODFOR', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
End;

function fRetCodCidByCliente(strCodCli: String): String;
Begin
  Result := fCampoTabela('CLI_CODCID', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
End;

function fValidaBancoCnf(Const strCodBco, strTblCnf: String): Boolean;
  Var
    strSQL   : String;
    qryGenCnf: TUniQuery;

begin
  Try

    Result := False;

    qryGenCnf := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTblCnf;
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '  CNF_CODBCO = :CODBCO ';

    With qryGenCnf Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      Open;
      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGenCnf);
  End;

end;


function fDigDuplicFinanceira(Var arrDuplica: TArrDigDuplicArray;
                              strCndPag:String;
                              intNumDoc:Int64;
                              curTotal:Currency;
                              blnMosTela,
                              blnEditavel,
                              blnHabEditDup:Boolean;
                              dtaDtaBas:TDateTime;
                              blnPergConf: Boolean;
                              fltImpost: Double = 0;
                              strUsaChq: String = 'N';
                              blnDupsRedondas: Boolean = True;
                              blnUsaHist: Boolean = False;
                              fltValRec : Double = 0.0;
                              blnFaturamento: Boolean = False;
                              arrValores: TDoubleArray = Nil;
                              strEspDoc: String = '';
                              blnSabDomFeriadoDiasUteis: Boolean = True;
                              objArredondamento: IArredondaParcela = Nil): Boolean;
  Var
    intQtdDup : Integer;
    curTotalRes: Currency;
begin

  Result := fDigDuplicSemTelaVar(True,
                                 arrDuplica,
                                 intQtdDup,
                                 curTotalRes,
                                 strCndPag,
                                 intNumDoc,
                                 curTotal,
                                 blnEditavel,
                                 blnHabEditDup,
                                 dtaDtaBas + IIF(Pos(strEspDoc, 'DV_TR_') > 0, fCfgSis('QTTRDV'), 0),
                                 blnPergConf,
                                 fltImpost,
                                 strUsaChq,
                                 blnDupsRedondas,
                                 blnUsaHist,
                                 fltValRec,
                                 arrValores,
                                 blnSabDomFeriadoDiasUteis,
                                 False,
                                 objArredondamento);
end;

{************************************************}
{* RETORNA VALOR DA CONTA PASSADA POR PARAMETRO *}
{*********************************************AF*}
function fRetCreDebConta(strTabela, strCodCta, strCreDeb: String; dtaDtaIni, dtaDtaFin: TDateTime): Currency;
  Var
    strSQL   : String;
    qryGenCtb: TUniQuery;

Begin
  Try

    qryGenCtb := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(CTB_VALLAN) AS VALLAN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabela + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTB_CODCTA = :CODCTA AND ';
    strSQL := strSQL + '  CTB_CREDEB = :CREDEB AND ';
    strSQL := strSQL + '  CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    With qryGenCtb Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCTA').AsString := strCodCta;
      ParamByName('DTAINI').AsDate   := dtaDtaIni;
      ParamByName('DTAFIN').AsDate   := dtaDtaFin;
      ParamByName('CREDEB').AsString := strCreDeb;
      Open;

      Result := FieldByName('VALLAN').AsCurrency;

      Close;
    End;

  Finally
    FreeAndNil(qryGenCtb);
  End;

End;

function fClaFisCadastrada(strCodCfo: String): Boolean;
  Var
    strSQL   : String;
    qryGenCfo: TUniQuery;

begin
  Try

    qryGenCfo := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCFO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CFO_CODCFO = :CODCFO ';

    With qryGenCfo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCFO').AsString := strCodCfo;
      Open;
      Result := FieldByName('QTD').AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCfo);
  End;

end;

function fRetDesCla(strClaFis: String; blnConsulta: Boolean = False): String;
var strCampo, strTabela, strCampoFiltro: string;
    qryConsulta: TUniQuery;
begin
  strCampo := 'CFO_DESCR1';
  strTabela := 'CADCFO';
  strCampoFiltro := 'CFO_CODCFO';
  If fCfgSis('OPCCFO', varInteger) = 1 Then
  Begin
    strCampo := 'NAT_DESCRI';
    strTabela := 'NATCFO';
    strCampoFiltro := 'NAT_CODCFO';
  End;

  If blnConsulta Then
  Begin
    qryConsulta := fCriaQuery;
    Try
      qryConsulta.SQL.Add('SELECT ' + strCampo + ' FROM ' +  strTabela + ' WHERE ' + strCampoFiltro + ' = "' + strClaFis + '"');
      qryConsulta.Open;
      IF qryConsulta.RecordCount > 1 Then
        Result := 'Diversos'
      Else
        Result := qryConsulta.FieldByName(strCampo).AsString;
      Exit;
    Finally
      FreeAndNil(qryConsulta);
    End;
  End
  Else
  Begin
    Result := '';
    If (strTabela = 'NATCFO') Then
      Result := fCampoTabela(strCampo, strTabela, [strCampoFiltro, 'NAT_ATIVO_'], [strClaFis, 'S'], False);
    If fEmptyStr(Result) Then
      Result := fCampoTabela(strCampo, strTabela, [strCampoFiltro], [strClaFis], False);
  End;
end;

function fRetDesFis(strCodFis: String): String;
  Var
    qryAux: TUniQuery;
begin
  Try

    qryAux := fCriaQuery;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT TRI_DESC01 FROM CADTRI WHERE TRI_CODTRI = :CODFIS ');
    qryAux.ParamByName('CODFIS').AsString := strCodFis;
    qryAux.Open;
    Result := qryAux.FieldByName('TRI_DESC01').AsString;
    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fDeletaTmpPedCom: Boolean;
begin
  Result := True;

  If fTabelaExiste('TMP_PCMDET') Then
    Result := fExecutaSQL('DROP TABLE TMP_PCMDET');

  If Result And fTabelaExiste('TMP_PCMEMP') Then
    Result := fExecutaSQL('DROP TABLE TMP_PCMEMP ');

  If Result And fTabelaExiste('TMP_CONSULTA') Then
    Result := fExecutaSQL('DROP TABLE TMP_CONSULTA');
end;

function fCriarTmpPedCom(intQtdMes: Integer): Boolean;
  Var
    intContador: Integer;
    strSQL   : String;
    qryGenDet: TUniQuery;

begin

  Try

    qryGenDet := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_PCMDET( ';
    strSQL := strSQL + '  ITE_CODITE VARCHAR('+ fTamCodIte.ToString +'), ';   // 01
    strSQL := strSQL + '  ITE_CODEMP VARCHAR(03), ';                          // 03
    strSQL := strSQL + '  ITE_DESITE VARCHAR(60), ';                          // 04
    strSQL := strSQL + '  ITE_REFERE VARCHAR(' + fTamRefere.ToString + '), '; // 05
    strSQL := strSQL + '  ITE_CODUNI VARCHAR(04), ';              // 06
    strSQL := strSQL + '  ITE_SIGUNI VARCHAR(06), ';              // 07
    strSQL := strSQL + '  ITE_CODMAR VARCHAR(06), ';              // 08
    strSQL := strSQL + '  ITE_DESMAR VARCHAR(30), ';              // 09
    strSQL := strSQL + '  ITE_CODFOR VARCHAR(08), ';              // 10
    strSQL := strSQL + '  ITE_ITEESP VARCHAR(01), ';              // 11
    strSQL := strSQL + '  ITE_DESF01 NUMERIC(12, 2), ';           // 12
    strSQL := strSQL + '  ITE_DESF02 NUMERIC(12, 2), ';           // 13
    strSQL := strSQL + '  ITE_DESF03 NUMERIC(12, 2), ';           // 14
    strSQL := strSQL + '  ITE_DESF04 NUMERIC(12, 2), ';           // 15
    strSQL := strSQL + '  ITE_DESF05 NUMERIC(12, 2), ';           // 16
    strSQL := strSQL + '  ITE_DESF06 NUMERIC(12, 2), ';           // 17
    strSQL := strSQL + '  ITE_SALDOS NUMERIC(12, 2), ';           // 18
    strSQL := strSQL + '  ITE_PRECUS NUMERIC(12, 2), ';           // 19
    strSQL := strSQL + '  ITE_PREVE1 NUMERIC(12, 2), ';           // 20
    strSQL := strSQL + '  ITE_PREVE2 NUMERIC(12, 2), ';           // 21
    strSQL := strSQL + '  ITE_PREVE3 NUMERIC(12, 2), ';           // 22
    strSQL := strSQL + '  ITE_PREVE4 NUMERIC(12, 2), ';           // 22
    strSQL := strSQL + '  ITE_PREVE5 NUMERIC(12, 2), ';           // 22
    strSQL := strSQL + '  ITE_PREVE6 NUMERIC(12, 2), ';           // 22
    strSQL := strSQL + '  ITE_PREVE7 NUMERIC(12, 2), ';           // 22
    strSQL := strSQL + '  ITE_MARBR1 NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + '), ';           // 23
    strSQL := strSQL + '  ITE_MARBR2 NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + '), ';           // 24
    strSQL := strSQL + '  ITE_MARBR3 NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + '), ';           // 25
    strSQL := strSQL + '  ITE_MARBR4 NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + '), ';           // 25
    strSQL := strSQL + '  ITE_MARBR5 NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + '), ';           // 25
    strSQL := strSQL + '  ITE_MARBR6 NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + '), ';           // 25
    strSQL := strSQL + '  ITE_MARBR7 NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + '), ';           // 25
    strSQL := strSQL + '  ITE_PREULT NUMERIC(12, 2), ';           // 26
    strSQL := strSQL + '  ITE_PRECOM NUMERIC(12, 2), ';           // 27
    strSQL := strSQL + '  ITE_QTDUCO NUMERIC(12, 2), ';           // 28
    strSQL := strSQL + '  ITE_CPRCEN CHAR(2), ';                  // 28.5

    strSQL := strSQL + '  ITE_UNITAR NUMERIC(12, 2), ';           // 29
    strSQL := strSQL + '  ITE_UNIORI NUMERIC(12, 2), '; //Unitario Original    
    strSQL := strSQL + '  ITE_CNDPAG VARCHAR(22), ';              // 30
    strSQL := strSQL + '  ITE_QTDITE NUMERIC(12, 2), ';           // 31
    strSQL := strSQL + '  ITE_TOTITE NUMERIC(12, 2), ';           // 32
    strSQL := strSQL + '  ITE_PERIPI NUMERIC(12, 2), ';           // 33
    strSQL := strSQL + '  ITE_TOTIPI NUMERIC(12, 2), ';           // 34
    strSQL := strSQL + '  ITE_PERSUB NUMERIC(12, 2), ';           // 35
    strSQL := strSQL + '  ITE_TOTSUB NUMERIC(12, 2), ';           // 36
    strSQL := strSQL + '  ITE_QTDBAI NUMERIC(12, 2), ';           // 37
    strSQL := strSQL + '  ITE_TOTBAI NUMERIC(12, 2), ';           // 38
    strSQL := strSQL + '  ITE_IPIBAI NUMERIC(12, 2), ';           // 39
    strSQL := strSQL + '  ITE_SUBBAI NUMERIC(12, 2), ';           // 40
    strSQL := strSQL + '  ITE_LITROS NUMERIC(12, 2), ';           // 41
    strSQL := strSQL + '  ITE_CODFAB VARCHAR(25), ';              // 42
    strSQL := strSQL + '  ITE_CODBAR VARCHAR(15), ';              // 43
    strSQL := strSQL + '  ITE_PEDTXT VARCHAR(03), ';              // 44
    strSQL := strSQL + '  ITE_QTDPEN NUMERIC(12, 2), ';           // 45
    strSQL := strSQL + '  AUTOINCREM VARCHAR(20), ';              // 46
    strSQL := strSQL + '  ITE_DESFAB VARCHAR(70), ';              // 47


    For intContador := 1 To intQtdMes Do
    Begin

      {*****************************************}
      {* CRIA OS CAMPOS REFERENTES ÀS VENDAS   *}
      {*****************************************}
      strSQL := strSQL + 'ITE_Q_V_' + fStrZero(IntToStr(intContador), 2);
      strSQL := strSQL + '  NUMERIC(12, 2), ';

      {*****************************************}
      {* CRIA OS CAMPOS REFERENTES ÀS COMPRAS  *}
      {*****************************************}
      strSQL := strSQL + 'ITE_Q_C_' + fStrZero(IntToStr(intContador), 2);
      strSQL := strSQL + '  NUMERIC(12, 2), ';

      {*****************************************}
      {* CRIA OS CAMPOS REFERENTES AOS MESES   *}
      {* DAS COMPRAS / VENDAS                  *}
      {*****************************************}
      strSQL := strSQL + 'ITE_DESM' + fStrZero(IntToStr(intContador), 2);
      strSQL := strSQL + '  VARCHAR(8), ';

      {*****************************************}
      {* CRIA OS CAMPOS REF. QTD MAIOR VENDA   *}
      {*****************************************}
      strSQL := strSQL + 'ITE_MQSA' + fStrZero(IntToStr(intContador), 2);
      strSQL := strSQL + '  NUMERIC(12, 2), ';

      {*****************************************}
      {* CRIA OS CAMPOS REF. DTA MAIOR VENDA   *}
      {*****************************************}
      strSQL := strSQL + 'ITE_MDSA' + fStrZero(IntToStr(intContador), 2);
      strSQL := strSQL + '  DATE, ';

    End;

    strSQL := strSQL + '  ITE_SUGEST NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_VENMES NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_CODACA VARCHAR(06), ';
    strSQL := strSQL + '  ITE_EMPACA VARCHAR(03), ';
    strSQL := strSQL + '  ITE_PROACA VARCHAR(01)) ';

    With qryGenDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCriarTmpPedCom]');
    End;
  End;

  FreeAndNil(qryGenDet);

end;

{*****************************************}
{* CALCULA O VALOR DO DOCUMENTO (CARTÃO) *}
{**************************************MV*}
function fCalculaValDocCartao(fltValTot, fltTaxAdm: Double): Double;
  Var
    LValorTaxaAdministrativa: Double;
begin
  LValorTaxaAdministrativa := fFormataFloat(fltValTot * (fltTaxAdm / 100), 2);
  Result := fFormataFloat(fltValTot - LValorTaxaAdministrativa, 2);
end;

function fCalculaValDocCartao(AValorBruto, APercentualTaxa, AValorFrete, AValorCupom: Double): Double;
  Var
    LValorTaxaAdministrativa: Double;
begin
  LValorTaxaAdministrativa := fFormataFloat(AValorBruto * (APercentualTaxa / 100), 2);

  Result := fFormataFloat(AValorBruto - LValorTaxaAdministrativa - AValorFrete + AValorCupom, 2);
end;

function fCalculaGiro(strCodIte: String; dtaDtaIni, dtaDtaFin: TDateTime;
  Var fltQtdEnt, fltQtdSai: Double): Boolean;
  Var
    strSQL   : String;
    qryGenDet: TUniQuery;

begin
  qryGenDet := fCriaQuery;

  fltQtdEnt := 0.0;
  fltQtdSai := 0.0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_CLAFIS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_CODITE = :CODITE AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  Try

    With qryGenDet Do
    Begin
    
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString   := strCodIte;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('DTAINI').AsDateTime := dtaDtaIni;
      ParamByName('DTAFIN').ASDateTime := dtaDtaFin;
      Open;

      First;

      If Not IsEmpty Then
      Begin

        While Not Eof Do
        Begin

          {*****************************************}
          {* SOMA VALORES DE ENTRADA / SAIDA       *}
          {**************************************MV*}

          If Pos(FieldByName('DET_CLAFIS').AsString, VS_strClaCom) > 0 Then
            fltQtdEnt := fltQtdEnt + FieldByName('DET_QTDITE').AsFloat

          Else If Pos(FieldByName('DET_CLAFIS').AsString, VS_strClaVen) > 0 Then
            fltQtdSai := fltQtdSai + FieldByName('DET_QTDITE').AsFloat;

          Next;
          Application.ProcessMessages;
        End;

      End;

      Close;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro durante o cálculo do giro: ' + E.Message, '[ fCalculaGiro ]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGenDet);

end;

function fVerificaVendaExiste(    strNumDoc, strEspDoc, strCodEmp: String;
                              Var strCodCli, strCodVen, strCodRep, strOriDoc: String;
                              Var dtaDtaEmi: TDateTime): Boolean;
  Var
    strCodFaz: String;
    blnPresencial: Boolean;
begin
  Result := fVerificaVendaExiste(strNumDoc, strEspDoc, strCodEmp,
                                 strCodCli, strCodFaz, strCodVen, strCodRep, strOriDoc,
                                 dtaDtaEmi, blnPresencial);
end;

function fVerificaVendaExiste(    strNumDoc, strEspDoc, strCodEmp: String;
                              Var strCodCli, strCodFaz, strCodVen, strCodRep, strOriDoc: String;
                              Var dtaDtaEmi: TDateTime;
                              Var blnPresencial: Boolean): Boolean;

  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  strCodCli := EmptyStr;
  strOriDoc := EmptyStr;
  
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_CODCLI,     ';
  strSQL := strSQL + '  GER_CODVEN,     ';
  strSQL := strSQL + '  GER_ORIDOC,     ';
  strSQL := strSQL + '  GER_DTAENT,     ';
  strSQL := strSQL + '  AUX_CODFAZ,     ';
  strSQL := strSQL + '  AUX_VENPRE,     ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  GER_TIP_FC = "C"     AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  GER_CLAFIS >= "5000"      ';
  strSQL := strSQL + 'GROUP BY                   ';
  strSQL := strSQL + '  GER_CODCLI, GER_CODVEN   ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL,'MOVGER','NOTGER'),'AUXMOV','AUXNOT');

  With qryGen do
  Begin
    Close;
   	SQL.Clear;
  	SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
	  Open;
    First;
    Result    :=  FieldByName('QTD').AsInteger > 0;
    strCodCli :=  FieldByName('GER_CODCLI').AsString;
    strCodFaz :=  FieldByName('AUX_CODFAZ').AsString;
    strCodVen :=  FieldByName('GER_CODVEN').AsString;
    strOriDoc :=  FieldByName('GER_ORIDOC').AsString;
    dtaDtaEmi :=  FieldByName('GER_DTAENT').AsDateTime;
    blnPresencial := FieldByName('AUX_VENPRE').AsString = 'S';

    Close;
  End;

  FreeAndNil(qryGen);
End;

function fVerificaAcessoCartao(strCodCar: String): Boolean;
  Var
    strCodEmp: String;
begin
  strCodEmp := fCampoTabela('CAR_CODEMP', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);
  Result    := (fEmptyStr(strCodEmp)) Or (Pos(strCodEmp, strEmpAcessoUsuarioLogado) > 0);
end;

procedure pCriaTabelaEntradaMercadorias(blnSempreDeletar: Boolean = True);
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;
    intTabPrc: Integer;

begin
  qryGenMer := fCriaQuery;

  If (fTabelaExiste('TMP_ENTMER')) and (blnSempreDeletar) Then
    pDeletaTabelaEntradaMercadorias;

  If (blnSempreDeletar) Then
    fDropTable('TMP_ENTTMP');

  strSQL := '';
  strSQL := strSQL + 'SET @CHAVE_TMP = 0; ';
  strSQL := strSQL + 'SET @N_ITEM := -1; ';
  strSQL := strSQL + 'SET @N_ITEM_TELA := 0; ';

  strSQL := strSQL + 'CREATE TEMPORARY TABLE IF NOT EXISTS TMP_ENTMER( ';
  strSQL := strSQL + '  ENT_IVA_ST  decimal(12,4), ';
  strSQL := strSQL + '  ENT_N_ITEM  INT, ';
  strSQL := strSQL + '  ENT_N_ITEM_TELA INT, ';

  strSQL := strSQL + '  CAL_VLICMS  decimal(12,2), ';
  strSQL := strSQL + '  ENT_CALSTU  INT, ';

  strSQL := strSQL + '  CAL_BASICM  decimal(12,2), ';
  strSQL := strSQL + '  CAL_ALQICM  decimal(12,2), ';
  strSQL := strSQL + '  CAL_BAS_ST  decimal(12,2), ';
  strSQL := strSQL + '  CAL_VR_IVA  decimal(12,4), ';
  strSQL := strSQL + '  CAL_VR_SUB  decimal(12,2), ';
  strSQL := strSQL + '  CAL_ALQINT  decimal(12,2), ';
  strSQL := strSQL + '  CAL_VFCPST  decimal(12,2), ';

  strSQL := strSQL + '  BKP_BASICMS decimal(12,2), ';
  strSQL := strSQL + '  BKP_ALQICMS decimal(12,2), ';
  strSQL := strSQL + '  BKP_VALICMS decimal(12,2), ';

  strSQL := strSQL + '  ENT_NUMPED VARCHAR(12), ';
  strSQL := strSQL + '  ENT_ESPDOC VARCHAR(02), ';
  strSQL := strSQL + '  ENT_CODEMP VARCHAR(03), ';
  strSQL := strSQL + '  ENT_SEQPCD VARCHAR(20), ';
  strSQL := strSQL + '  ENT_AUTELE VARCHAR(20), ';
  strSQL := strSQL + '  ENT_DETELE VARCHAR(20), ';
  strSQL := strSQL + '  ENT_DETEL2 VARCHAR(20), ';
  strSQL := strSQL + '  ENT_CODITE '+ fRetornaTipoDoCampo('CADITE', 'ITE_CODITE') + ', ';
  strSQL := strSQL + '  ENT_TIPPRO    CHAR(02), ';
  strSQL := strSQL + '  ENT_PREDOL    CHAR(01), ';
  strSQL := strSQL + '  ENT_CODGRU VARCHAR(06), ';
  strSQL := strSQL + '  ENT_IMPDIR CHAR(01), ';
  strSQL := strSQL + '  ENT_DESITE VARCHAR(70), ';
  strSQL := strSQL + '  ENT_DESIT1 VARCHAR(70), ';
  strSQL := strSQL + '  ENT_REFERE VARCHAR(50), ';
  strSQL := strSQL + '  ENT_CODUNI VARCHAR(04), ';
  strSQL := strSQL + '  ENT_SIGUNI VARCHAR(06), ';
  strSQL := strSQL + '  ENT_VENPRE CHAR(1), ';
  strSQL := strSQL + '  ENT_PREEM1 CHAR(01), ';
  strSQL := strSQL + '  ENT_PREEM2 CHAR(01), ';
  strSQL := strSQL + '  ENT_PREEM3 CHAR(01), ';
  strSQL := strSQL + '  ENT_PREEM4 CHAR(01), ';
  strSQL := strSQL + '  ENT_PREEM5 CHAR(01), ';
  strSQL := strSQL + '  ENT_PREEM6 CHAR(01), ';
  strSQL := strSQL + '  ENT_PREEM7 CHAR(01), ';

  strSQL := strSQL + '  ENT_CODABF VARCHAR(0'+ IntToStr(fTamCodAbfIcm) +'), ';
  strSQL := strSQL + '  ENT_DESABF VARCHAR(100), ';
  strSQL := strSQL + '  ENT_CODFOR VARCHAR(08), ';
  strSQL := strSQL + '  ENT_DIFICM CHAR(01), ';
  strSQL := strSQL + '  ENT_FRERPA NUMERIC(12 ,2) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_QTDITE NUMERIC(12, '+ fCfgSis('DEQTEM') +'), ';
  strSQL := strSQL + '  ENT_UNITAR NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_PERIPI NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_TOTITE NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_TOTGER NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_PRECOM NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_DESF01 NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESF02 NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESF03 NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESF04 NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESF05 NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESF06 NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ICMENT NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_SUBFED NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_IPIENT NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_FREENT NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_FREITE NUMERIC(12, 4), '; // VALOR DO FRETE
  strSQL := strSQL + '  ENT_ACRFIN NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_SUBSTI NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_OUTVAL NUMERIC(12, 3), ';
  strSQL := strSQL + '  ENT_IMPFED NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESOPE NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_PRECUS NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_ICMSAI NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESMAX NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESMGE NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESMSU NUMERIC(12, 2), ';

  For intTabPrc := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  ENT_PREVE' + IntToStr(intTabPrc) + ' NUMERIC(12, 4), ';
    strSQL := strSQL + '  ENT_MARBR' + IntToStr(intTabPrc) + ' NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + '), ';
    strSQL := strSQL + '  ENT_COMTB' + IntToStr(intTabPrc) + ' NUMERIC(12, 2), ';
  End;

  strSQL := strSQL + '  ENT_MARMIN NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_MARMSG NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_MARMGE NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_DESMVM NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESMSM NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESMGM NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_MARMMV NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_MARMMS NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_MARMMG NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_CLAIPI VARCHAR(10), ';
  strSQL := strSQL + '  ENT_CDCEST CHAR(7),  ';
  strSQL := strSQL + '  ENT_CLAFIS VARCHAR(04), ';
  strSQL := strSQL + '  ENT_I08CFO VARCHAR(04), ';
  strSQL := strSQL + '  ENT_CODFIS VARCHAR(03), ';
  strSQL := strSQL + '  ENT_VLRCON NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_PERBAS NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_BASICM NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ALQICM NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_VALICM NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ICMXML NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ALIXML NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_BAIXML NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_FCPXML NUMERIC(12, 2), ';

  {Nota de Importação }

  strSQL := strSQL + ' ENT_VALVII NUMERIC(12, 2), ';
  strSQL := strSQL + ' ENT_VSEGIMP NUMERIC(12, 2), ';
  strSQL := strSQL + ' ENT_VALIOF NUMERIC(12, 2), ';
  strSQL := strSQL + ' ENT_VALSIS NUMERIC(12, 2), ';
  strSQL := strSQL + ' ENT_VAFRMM NUMERIC(12, 2), ';
  strSQL := strSQL + ' ENT_DESPAD NUMERIC(12, 2), ';
  // VALOR BRUTO DA TAG <vOutro> DO XML - NECESSARIO PARA APURAR A PARCELA DE
  // DESPESA ACESSORIA QUE O EMITENTE INFORMOU DENTRO DE OUTRAS E QUE NAO FAZ
  // PARTE DA COMPOSICAO DO PERFIL ADUANEIRO
  strSQL := strSQL + ' ENT_VOUTRO NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_BASIPI NUMERIC(12, 2), ';
  // ENT_BASIPU - INFORMADO PELO USUARIO OU BASE ORIGINAL SEM FRETE E DESPESAS ACESSORIAS
  strSQL := strSQL + '  ENT_BASIPU NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ALQIPI NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_VALIPI NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_MATREV CHAR(1), ';

  // VARIAVEIS PARA GUARDAR O IPI QUANDO NAO UTILIZA CREDITOS DE IPI
  strSQL := strSQL + '  ENT_BAEIPI NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ALEIPI NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_VAEIPI NUMERIC(12, 2), ';

  // VARIAVEIS PARA GUARDAR O ICMS QUANDO EMPRESA SUBSTITUIDA
  strSQL := strSQL + '  ENT_BAERET NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ALERET NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_VAERET NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_IPISUB NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ISENTO NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_PEBAST NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_BASRET NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_VALRET NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_RETORI NUMERIC(12, 2), '; // VALOR DA SUBSTITUICAO ORIGINAL
  strSQL := strSQL + '  ENT_BASANT NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_VALANT NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_OUTRAS NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESESP NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_DESXML NUMERIC(12, 2), '; // DESCONTO DO XML SEM O ICMS DESONERADO

  strSQL := strSQL + '  ENT_N12CST CHAR(3), '; //

  strSQL := strSQL + '  ENT_DESACE NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESADB NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_VALADB NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_VALFRE NUMERIC(12 ,2), ';

  strSQL := strSQL + '  ENT_FRECON NUMERIC(12 ,2) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_BAFRAN NUMERIC(12, 2) DEFAULT 0, ';  // BASE DE ANTECIPACAO DO CONHECIMENTO DE FRETE
  strSQL := strSQL + '  ENT_VAFRAN NUMERIC(12, 2) DEFAULT 0, ';  // VALOR DA ANTECIPACAO DO CONHECIMENTO DE FRETE

  strSQL := strSQL + '  ENT_VENDOR NUMERIC(12 ,2) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_OUTDES NUMERIC(12 ,2) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_VALGNR NUMERIC(12 ,2) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_CALGNR TEXT, ';

  strSQL := strSQL + '  ENT_VLTCIF NUMERIC(12 ,2) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_ALQTCI NUMERIC(12 ,6) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_CLTCIF NUMERIC(12 ,2) DEFAULT 0, ';

  strSQL := strSQL + '  ENT_VAL_TS NUMERIC(12 ,2) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_ALQ_TS NUMERIC(12 ,6) DEFAULT 0, ';
  strSQL := strSQL + '  ENT_GNRTSU NUMERIC(12 ,6) DEFAULT 0, ';

  strSQL := strSQL + '  ENT_GNRORI CHAR(1), ';

  strSQL := strSQL + '  ENT_MARDES VARCHAR(01), ';
  strSQL := strSQL + '  ENT_PERSUB NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_TOTSUB NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DTABAL DATE, ';
  strSQL := strSQL + '  ENT_LOCFIS VARCHAR(30), ';
  strSQL := strSQL + '  ENT_INCPIS VARCHAR(01), ';

  {*********************************************************************}
  {* AUTOINCREMENTO DO ITEM CORRESPONDETE A VENDA QUANDO FOR DEVOLUÇÃO *}
  {******************************************************************LA*}
  strSQL := strSQL + '  ENT_AUTVEN VARCHAR(20), ';
  strSQL := strSQL + '  ENT_INCFUT VARCHAR(20), ';

  strSQL := strSQL + '  ENT_TABELA VARCHAR(6), ';

  {*********************************************************************}
  {* PARA ORDENAR PELA ORDEM NA QUAL O ITEM FOI SELECIONADO            *}
  {******************************************************************LA*}
  strSQL := strSQL + '  ENT_NUMSEL INTEGER, ';

  {*********************************}
  {* COLUNAS PARA PRODUTO ACABADO. *}
  {******************************MV*}
  strSQL := strSQL + '  ENT_CODACA VARCHAR(06), ';
  strSQL := strSQL + '  ENT_EMPACA VARCHAR(03), ';
  strSQL := strSQL + '  ENT_PROACA VARCHAR(01), ';
  strSQL := strSQL + '  ENT_SALACA NUMERIC(12, 3), ';
  strSQL := strSQL + '  ENT_PREACA NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_DESACA VARCHAR(75), ';
  strSQL := strSQL + '  ENT_CODFAB VARCHAR(35), ';

  strSQL := strSQL + '  ENT_CSTPIS CHAR(3),        '; // CST PIS
  strSQL := strSQL + '  ENT_PERPIS NUMERIC(12, 2), '; // PERCENTUAL DE PIS
  strSQL := strSQL + '  ENT_BASPIS NUMERIC(12, 2), '; // BASE DE PIS
  strSQL := strSQL + '  ENT_VALPIS NUMERIC(12, 2), '; // VALOR DO PIS

  strSQL := strSQL + '  ENT_CSTCOF CHAR(3),        '; // CST PIS
  strSQL := strSQL + '  ENT_PERCOF NUMERIC(12, 2), '; // PERCENTUAL DE CONFIS
  strSQL := strSQL + '  ENT_BASCOF NUMERIC(12, 2), '; // BASE DE COFINS
  strSQL := strSQL + '  ENT_VALCOF NUMERIC(12, 2), '; // VALOR DO CONFIS

  strSQL := strSQL + '  ENT_NUMLOT VARCHAR(30), ';    // NUMERO DO LOTE
  strSQL := strSQL + '  ENT_IDEPRO VARCHAR(3), ';    // Identificação Produto ( Normal / Outros )
  strSQL := strSQL + '  ENT_ITETIN VARCHAR(200), ';  // iTEM tINTAS

  strSQL := strSQL + '  ENT_GRAMAR VARCHAR(1), ';    // NUMERO DO LOTE

  strSQL := strSQL + '  ENT_ITE_F5 CHAR('+IntToStr(fTamCodIte)+'),'; // CODIGO DO ITEM ALTERADO PELO F5 ,
                                                      // PORQUE PODE MUDAR O CODIGO E NAO APAGAR O ITEM - NFE

  strSQL := strSQL + '  ENT_EMB_F5 CHAR(5),        '; // "S" MULTILICOU PELA EMBALAGEM NO F5,

  strSQL := strSQL + '  ENT_RPRENT VARCHAR(1), ';     // PERMITE REDUÇÃO DE PREÇOS

  {**********************************************************}
  {* QTDE MAXIMA PERMITIDA PARA DEVOLUÇÃO CONF DOC ORIGEM   *}
  {*******************************************************IV*}
  strSQL := strSQL + '  ENT_QTDMXD NUMERIC(12, 4), ';

  {*******************************************************}
  {* COD. MOTIVO ITENS AUTORIZACAO DE DEVOLUCAO DO CRM   *}
  {****************************************************AC*}
  strSQL := strSQL + '  ENT_CODMOT CHAR(3), ';

  strSQL := strSQL + '  AUTOINCREM INTEGER NOT NULL AUTO_INCREMENT, ';
  strSQL := strSQL + '  ENT_EMBALA NUMERIC(20, ' + IntToStr(DEC_EMBALAGEM) + '), ';
  strSQL := strSQL + '  ENT_EMBPED NUMERIC(20, ' + IntToStr(DEC_EMBALAGEM) + '), ';
  strSQL := strSQL + '  ENT_UNIEMB VARCHAR(4),  ';

  strSQL := strSQL + '  ENT_ANTPRO VARCHAR(1) DEFAULT "N", ';    // TEM ANTECIPACAO DE ICMS SOBRE O ITEM
  strSQL := strSQL + '  ENT_ANTFRE VARCHAR(1) DEFAULT "S", ';    // RATEIA ICMS ANTECIPADO DO FRETE
  strSQL := strSQL + '  ENT_COMGNR VARCHAR(1), ';                // RATEIA A GNRE

  strSQL := strSQL + '  ENT_EMP_PD VARCHAR(03), ';

  strSQL := strSQL + '  ENT_CODDIV VARCHAR(8), ';    // CODIGO DIVERSOS - PARA DEVOLUÇÃO
  strSQL := strSQL + '  ENT_DESUNI NUMERIC(12,6) DEFAULT 0, '; // Desconto Especial Unitario. Grava o valor do Desconto Especial Unitario, Utilizado apenas na Devolução de Mercadorias.
  strSQL := strSQL + '  ENT_USODES CHAR(1), ';
  strSQL := strSQL + '  ENT_VICMDE NUMERIC(12,3), ';
  strSQL := strSQL + '  ENT_DESCON NUMERIC(12,3), ';
  strSQL := strSQL + '  ENT_MTDICM CHAR(2), ';
  strSQL := strSQL + '  ENT_SITXML CHAR(3),  ';
  strSQL := strSQL + '  ENT_CSTCAD CHAR(1),  ';
  strSQL := strSQL + '  ENT_QTDREF NUMERIC(12,4), ';
  strSQL := strSQL + '  ENT_VAL_RT NUMERIC(12, 2), '; //
  strSQL := strSQL + '  ENT_PERRED NUMERIC(12, 2), '; //
  strSQL := strSQL + '  ENT_ALQRET NUMERIC(12, 2), '; //
  strSQL := strSQL + '  ENT_ALQCOF NUMERIC(12, 2), '; //
  strSQL := strSQL + '  ENT_ALQPIS NUMERIC(12, 2), '; //

  strSQL := strSQL + '  ENT_NR_PIS CHAR(3), ';
  strSQL := strSQL + '  ENT_NR_COF CHAR(3), ';
  strSQL := strSQL + '  ENT_VFCPST NUMERIC(12, 2), '; //
  strSQL := strSQL + '  ENT_BFCPST NUMERIC(12, 2), '; //
  strSQL := strSQL + '  ENT_PFCPST NUMERIC(12, 2), '; //

  strSQL := strSQL + '  ENT_VBCFCP NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_PERFCP NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_VALFCP NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_VLRGNR NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_PREGNR CHAR(1), ';

  strSQL := strSQL + '  ENT_INDPRES INTEGER, ';
  strSQL := strSQL + '  ENT_IDDEST INTEGER,  ';

  strSQL := strSQL + '  ENT_QTDORI NUMERIC(12, 4), '; // QUANTIDADE ORIGINAL DA NOTA DE VENDA NA DEVOLUÇÃO

  strSQL := strSQL + '  ENT_BSTANT NUMERIC(12, 2), ';    // N26_VBCSTRET
  strSQL := strSQL + '  ENT_VSTANT NUMERIC(12, 2), ';    // N27_VICMSSTRET
  strSQL := strSQL + '  ENT_PICMEF NUMERIC(12, 2), ';    // N34_PREDBCEEFET
  strSQL := strSQL + '  ENT_BICMEF NUMERIC(12, 2), ';    // N35_VBCEFET
  strSQL := strSQL + '  ENT_AICMEF NUMERIC(12, 2), ';    // N36_PICMSEFET
  strSQL := strSQL + '  ENT_VICMEF NUMERIC(12, 2), ';    // N37_VICMSEFET
  strSQL := strSQL + '  ENT_ALQSTI NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_ITETRI CHAR(1) , ';          // CFG_ATUADB = "D"

  strSQL := strSQL + '  ENT_EXISTELOTE CHAR(1), ';      // ENT_EXISTELOTE
  strSQL := strSQL + '  ENT_SALDOS DECIMAL(12,3), ';      // ENT_SALDOS
  strSQL := strSQL + '  ENT_CNV_ML DECIMAL(12,4), ';      // ENT_CNV_ML

  strSQL := strSQL + '  AUTOINCREMENTO_GRAVACAO VARCHAR(20), ';

  strSQL := strSQL + '  ENT_TCIFCU NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_TSCUST NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DEPICO NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DEICMS NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_FATREG NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_DESPIS NUMERIC(12, 2), ';

  strSQL := strSQL + '  ENT_PROEMB CHAR(01), ';  // S/N PRODUTO EMBALAGEM PARA DEVOLUÇÃO

  strSQL := strSQL + '  ENT_RICMPR VARCHAR(1) DEFAULT "N", ';  // REDUCAO ICM ESTADO PR

  strSQL := strSQL + '  ENT_ALTITEM CHAR(1) DEFAULT "N", ';  // INFORMA SE O ITEM FOI EDITADO MANUALMENTE NA GRID QUANDO PEDIDO

  strSQL := strSQL + '  ENT_NATOPE VARCHAR(120), ';
  strSQL := strSQL + '  ENT_ICMCFR NUMERIC(12, 2), ';
  strSQL := strSQL + '  ENT_DESMAR VARCHAR(40), ';
  strSQL := strSQL + '  ENT_QBCMON NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_ADREMN NUMERIC(12, 4), ';
  strSQL := strSQL + '  ENT_VALMON NUMERIC(12, 4), ';

  // Reforma Tributaria - campos DETERT (IBSCBS/IS por item)
  strSQL := strSQL + '  ENT_REFCST VARCHAR(3), ';
  strSQL := strSQL + '  ENT_REFCLA VARCHAR(6), ';
  strSQL := strSQL + '  ENT_REFVBC DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFCALQ DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFCALD DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFCVLD DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFCALR DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFCVLT DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFCALE DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFCVAL DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFIUFA DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFIUFD DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFIUVD DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFIUFR DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFIUFT DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFIUFE DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFIUFV DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFIMNA DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFIMND DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFIMVD DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFIMNR DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFIMNT DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFIMNE DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFIMNV DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFSCST VARCHAR(3), ';
  strSQL := strSQL + '  ENT_RFSCLA VARCHAR(6), ';
  strSQL := strSQL + '  ENT_RFSBAS DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFSALQ DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFSVLR DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFRCST VARCHAR(3), ';
  strSQL := strSQL + '  ENT_RFRCLA VARCHAR(6), ';
  strSQL := strSQL + '  ENT_RFRUFA DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFRUVT DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFRUMA DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFRUMT DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFRUCA DECIMAL(7,4), ';
  strSQL := strSQL + '  ENT_RFRUCB DECIMAL(12,2), ';
  strSQL := strSQL + '  ENT_RFIVAL DECIMAL(12,2), ';
  strSQL := strSQL + '  PRIMARY KEY (AUTOINCREM) ) ';

  With qryGenMer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  strSQL := AnsiReplaceStr( strSql, 'TMP_ENTMER', 'TMP_ENTTMP' );

  With qryGenMer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  FreeAndNil(qryGenMer);
  
end;

procedure pDeletaTabelaEntradaMercadorias;
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;

begin
  Try

    qryGenMer := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_ENTMER ';

    With qryGenMer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    fDropTable( 'TMP_ENTTMP' );

  Finally
    FreeAndNil(qryGenMer);
  End;

end;

function fSqlInsertEntMer(blnNotaEletronica: Boolean = False;
                          blnGarantia      : Boolean = False;
                          blnRecCli        : Boolean = False): String;
  Var
    strSQL: String;
    intTabPrc: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO ';
  strSQL := strSQL + '  TMP_ENTMER ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  ENT_NUMPED, ';
  strSQL := strSQL + '  ENT_CODEMP, ';
  strSQL := strSQL + '  ENT_N_ITEM, ';
  strSQL := strSQL + '  ENT_N_ITEM_TELA, ';
  strSQL := strSQL + '  ENT_NATOPE, ';
  strSQL := strSQL + '  ENT_SEQPCD, ';
  strSQL := strSQL + '  ENT_IVA_ST, ';

  strSQL := strSQL + '  CAL_VLICMS, ';
  strSQL := strSQL + '  ENT_CALSTU, ';

  strSQL := strSQL + '  CAL_BASICM, ';
  strSQL := strSQL + '  CAL_ALQICM, ';
  strSQL := strSQL + '  CAL_BAS_ST, ';
  strSQL := strSQL + '  CAL_VR_IVA, ';
  strSQL := strSQL + '  CAL_VR_SUB, ';
  strSQL := strSQL + '  CAL_ALQINT, ';
  strSQL := strSQL + '  CAL_VFCPST, ';

  If blnNotaEletronica Then
  Begin
    strSQL := strSQL + '  ENT_AUTELE, ';
    strSQL := strSQL + '  ENT_DETELE, ';
    strSQL := strSQL + '  ENT_DETEL2, ';

    strSQL := strSQL + '  ENT_BSTANT, ';    // N26_VBCSTRET
    strSQL := strSQL + '  ENT_VSTANT, ';    // N27_VICMSSTRET
    strSQL := strSQL + '  ENT_PICMEF, ';    // N34_PREDBCEEFET
    strSQL := strSQL + '  ENT_BICMEF, ';    // N35_VBCEFET
    strSQL := strSQL + '  ENT_AICMEF, ';    // N36_PICMSEFET
    strSQL := strSQL + '  ENT_VICMEF, ';   // N37_VICMSEFET
    strSQL := strSQL + '  ENT_ALQSTI, ';   // N22_PICMSST
  End;
  strSQL := strSQL + '  ENT_ITETRI, ';
  strSQL := strSQL + '  ENT_CODFOR, ';
  strSQL := strSQL + '  ENT_DIFICM, ';
  strSQL := strSQL + '  ENT_CODFAB, ';
  strSQL := strSQL + '  ENT_CODITE, ';
  strSQL := strSQL + '  ENT_TIPPRO, ';
  strSQL := strSQL + '  ENT_DESPIS, ';

  strSQL := strSQL + '  ENT_PREDOL, ';
  strSQL := strSQL + '  ENT_CODGRU, ';
  strSQL := strSQL + '  ENT_IMPDIR, ';

  strSQL := strSQL + '  ENT_DESITE, ';
  strSQL := strSQL + '  ENT_DESIT1, ';
  strSQL := strSQL + '  ENT_REFERE, ';
  strSQL := strSQL + '  ENT_CODUNI, ';
  strSQL := strSQL + '  ENT_SIGUNI, ';
  strSQL := strSQL + '  ENT_CODABF, ';
  strSQL := strSQL + '  ENT_DESABF, ';
  strSQL := strSQL + '  ENT_QTDITE, ';
  strSQL := strSQL + '  ENT_UNITAR, ';
  strSQL := strSQL + '  ENT_PERIPI, ';
  strSQL := strSQL + '  ENT_VALIPI, ';
  strSQL := strSQL + '  ENT_MATREV, ';

  If blnGarantia Then
  Begin
    strSQL := strSQL + '  ENT_BASIPI, ';
    strSQL := strSQL + '  ENT_BASRET, ';
    strSQL := strSQL + '  ENT_VALRET, ';
    strSQL := strSQL + '  ENT_BAERET, ';
    strSQL := strSQL + '  ENT_VAERET, ';
    strSQL := strSQL + '  ENT_CODFIS, ';
    strSQL := strSQL + '  ENT_CLAFIS, ';
    strSQL := strSQL + '  ENT_BASICM, ';
    strSQL := strSQL + '  ENT_ALQICM, ';
    strSQL := strSQL + '  ENT_VALICM, ';
  End;

  If blnNotaEletronica Then
  Begin
    strSQL := strSQL + '  ENT_BASICM, ';
    strSQL := strSQL + '  ENT_ALQICM, ';
    strSQL := strSQL + '  ENT_VALICM, ';
    strSQL := strSQL + '  ENT_ICMXML, ';
    strSQL := strSQL + '  ENT_ALIXML, ';
    strSQL := strSQL + '  ENT_BAIXML, ';

    strSQL := strSQL + '  ENT_FCPXML, ';

    strSQL := strSQL + '  ENT_BASIPI, ';
    strSQL := strSQL + '  ENT_VENPRE, ';
    {Nota Importacao}
    strSQL := strSQL + '  ENT_VALVII, ';
    strSQL := strSQL + '  ENT_VSEGIMP, ';
    strSQL := strSQL + '  ENT_VALIOF, ';
    strSQL := strSQL + '  ENT_VALSIS, ';
    strSQL := strSQL + '  ENT_VAFRMM, ';
    strSQL := strSQL + '  ENT_DESPAD, ';
    strSQL := strSQL + '  ENT_VOUTRO, ';
  End;

  If Not blnGarantia Then
  Begin
    strSQL := strSQL + '  ENT_USODES, ';
    strSQL := strSQL + '  ENT_VICMDE, ';
    strSQL := strSQL + '  ENT_DESCON, ';
    strSQL := strSQL + '  ENT_MTDICM, ';
  End;

  // VARIAVEIS PARA GUARDAR O IPI QUANDO NAO UTILIZA CREDITOS DE IPI
  strSQL := strSQL + '  ENT_VAEIPI, ';
  strSQL := strSQL + '  ENT_BAEIPI, ';

  strSQL := strSQL + '  ENT_TOTITE, ';
  strSQL := strSQL + '  ENT_TOTGER, ';
  strSQL := strSQL + '  ENT_PRECOM, ';
  strSQL := strSQL + '  ENT_DESF01, ';
  strSQL := strSQL + '  ENT_DESF02, ';
  strSQL := strSQL + '  ENT_DESF03, ';
  strSQL := strSQL + '  ENT_DESF04, ';
  strSQL := strSQL + '  ENT_DESF05, ';
  strSQL := strSQL + '  ENT_DESF06, ';

  strSQL := strSQL + '  ENT_GNRTSU, ';
  strSQL := strSQL + '  ENT_ALQTCI, ';
  strSQL := strSQL + '  ENT_ALQ_TS, ';
  strSQL := strSQL + '  ENT_TCIFCU, ';
  strSQL := strSQL + '  ENT_TSCUST, ';
  strSQL := strSQL + '  ENT_DEPICO, ';
  strSQL := strSQL + '  ENT_DEICMS, ';
  strSQL := strSQL + '  ENT_FATREG, ';

  strSQL := strSQL + '  ENT_ICMENT, ';
  strSQL := strSQL + '  ENT_SUBFED, ';
  strSQL := strSQL + '  ENT_IPIENT, ';
  strSQL := strSQL + '  ENT_FREENT, ';
  strSQL := strSQL + '  ENT_FREITE, '; // VALOR DO FRETE DO ITEM
  strSQL := strSQL + '  ENT_ACRFIN, ';
  strSQL := strSQL + '  ENT_SUBSTI, ';
  strSQL := strSQL + '  ENT_OUTVAL, ';
  strSQL := strSQL + '  ENT_IMPFED, ';
  strSQL := strSQL + '  ENT_DESOPE, ';
  strSQL := strSQL + '  ENT_PRECUS, ';
  strSQL := strSQL + '  ENT_ICMSAI, ';
  strSQL := strSQL + '  ENT_DESMAX, ';
  strSQL := strSQL + '  ENT_DESMGE, ';
  strSQL := strSQL + '  ENT_DESMSU, ';

  For intTabPrc := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  ENT_MARBR' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  ENT_PREVE' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  ENT_COMTB' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  ENT_PREEM' + IntToStr(intTabPrc) + ', ';
  End;

  strSQL := strSQL + '  ENT_MARMIN, ';
  strSQL := strSQL + '  ENT_MARMSG, ';
  strSQL := strSQL + '  ENT_MARMGE, ';

  strSQL := strSQL + '  ENT_DESMVM, ';
  strSQL := strSQL + '  ENT_DESMSM, ';
  strSQL := strSQL + '  ENT_DESMGM, ';

  strSQL := strSQL + '  ENT_MARMMV, ';
  strSQL := strSQL + '  ENT_MARMMS, ';
  strSQL := strSQL + '  ENT_MARMMG, ';

  strSQL := strSQL + '  ENT_CLAIPI, ';
  strSQL := strSQL + '  ENT_CDCEST, ';

  {********************************************************************}
  {* FOI INCLUIDA A DATA DE BALANÇO POIS É NECESSÁRIO VERIFICAR       *}
  {* ESSA DATA NA CONFIRMAÇÃO DE ITENS PARA A ENTRADA DE MERCADORIAS  *}
  {*****************************************************************LA*}
  strSQL := strSQL + '  ENT_DTABAL, ';

  strSQL := strSQL + '  ENT_NUMSEL, ';

  strSQL := strSQL + '  ENT_MARDES, ';
  strSQL := strSQL + '  ENT_PERSUB, ';
  strSQL := strSQL + '  ENT_TOTSUB, ';

  If blnNotaEletronica Then
  Begin
    strSQL := strSQL + '  ENT_BASRET, ';
    strSQL := strSQL + '  ENT_VALRET, ';

    // VARIAVEIS PARA GUARDAR O ICMS QUANDO EMPRESA SUBSTITUIDA
    strSQL := strSQL + '  ENT_BAERET, ';
    strSQL := strSQL + '  ENT_VAERET, ';

    strSQL := strSQL + '  ENT_I08CFO, ';

    strSQL := strSQL + '  ENT_VALFRE, ';
    strSQL := strSQL + '  ENT_DESACE, ';

    strSQL := strSQL + '  ENT_SITXML, ';
    strSQL := strSQL + '  ENT_CSTCAD, ';

    strSQL := strSQL + '  ENT_DESESP, ';

    strSQL := strSQL + '  ENT_DESXML, ';
    strSQL := strSQL + '  ENT_N12CST, ';

    strSQL := strSQL + '  ENT_VFCPST, ';
    strSQL := strSQL + '  ENT_BFCPST, ';
    strSQL := strSQL + '  ENT_PFCPST, ';

    strSQL := strSQL + ' ENT_VBCFCP, ';
    strSQL := strSQL + ' ENT_PERFCP, ';
    strSQL := strSQL + ' ENT_VALFCP, ';
    strSQL := strSQL + ' ENT_VLRGNR, ';
    strSQL := strSQL + ' ENT_CALGNR, ';
    strSQL := strSQL + ' ENT_GNRORI, ';
    strSQL := strSQL + ' ENT_PREGNR, ';

  End Else
  Begin

    If Not blnGarantia Then
      strSQL := strSQL + '  ENT_DESESP, ';

  End;

  strSQL := strSQL + '  ENT_INCPIS, ';

  strSQL := strSQL + '  ENT_CODACA, ';
  strSQL := strSQL + '  ENT_EMPACA, ';
  strSQL := strSQL + '  ENT_PROACA, ';
  strSQL := strSQL + '  ENT_SALACA, ';
  strSQL := strSQL + '  ENT_PREACA, ';
  strSQL := strSQL + '  ENT_DESACA, ';

  If blnNotaEletronica Then
    strSQL := strSQL + '  ENT_CSTPIS, ';

  strSQL := strSQL + '  ENT_PERPIS, ';
  strSQL := strSQL + '  ENT_BASPIS, ';
  strSQL := strSQL + '  ENT_VALPIS, ';

  If blnNotaEletronica Then
    strSQL := strSQL + '  ENT_CSTCOF, ';

  strSQL := strSQL + '  ENT_PERCOF, ';
  strSQL := strSQL + '  ENT_BASCOF, ';
  strSQL := strSQL + '  ENT_VALCOF, ';

  strSQL := strSQL + '  ENT_ITE_F5, ';
  strSQL := strSQL + '  ENT_RPRENT, ';
  strSQL := strSQL + '  ENT_NUMLOT, ';
  strSQL := strSQL + '  ENT_IDEPRO, ';
  strSQL := strSQL + '  ENT_ITETIN, ';
  strSQL := strSQL + '  ENT_GRAMAR, ';
  strSQL := strSQL + '  ENT_EMBALA, ';
  strSQL := strSQL + '  ENT_EMBPED, ';
  strSQL := strSQL + '  ENT_UNIEMB,  ';
  If blnNotaEletronica Then
    strSQL := strSQL + '  ENT_PROEMB,  ';
  strSQL := strSQL + ' ENT_RICMPR,     ';
  strSQL := strSQL + ' ENT_EXISTELOTE, ';
  strSQL := strSQL + ' ENT_SALDOS, ';
  strSQL := strSQL + ' ENT_CNV_ML, ';
  strSQL := strSQL + ' ENT_DESMAR, ';

  If blnGarantia and blnRecCli then
    strSQL := strSQL + ' ENT_DESESP, ';

  strSQL := strSQL + '  AUTOINCREMENTO_GRAVACAO ';

  If blnNotaEletronica Or ( (not blnNotaEletronica) And (not blnGarantia) And (fCfgSis('REFENT', varBoolean))) Then
  Begin
    If blnNotaEletronica Then
    begin
      strSQL := strSQL + ' , ENT_INDPRES ';
      strSQL := strSQL + ' , ENT_IDDEST ';
    end;
    strSQL := strSQL + ' ,ENT_QTDREF ';
    strSQL := strSQL + ' ,ENT_QBCMON ';
    strSQL := strSQL + ' ,ENT_ADREMN ';
    strSQL := strSQL + ' ,ENT_VALMON ';
    If blnNotaEletronica Then
    Begin
      strSQL := strSQL + ' ,ENT_REFCST ,ENT_REFCLA ,ENT_REFVBC ';
      strSQL := strSQL + ' ,ENT_RFCALQ ,ENT_RFCALD ,ENT_RFCVLD ,ENT_RFCALR ,ENT_RFCVLT ,ENT_RFCALE ,ENT_RFCVAL ';
      strSQL := strSQL + ' ,ENT_RFIUFA ,ENT_RFIUFD ,ENT_RFIUVD ,ENT_RFIUFR ,ENT_RFIUFT ,ENT_RFIUFE ,ENT_RFIUFV ';
      strSQL := strSQL + ' ,ENT_RFIMNA ,ENT_RFIMND ,ENT_RFIMVD ,ENT_RFIMNR ,ENT_RFIMNT ,ENT_RFIMNE ,ENT_RFIMNV ';
      strSQL := strSQL + ' ,ENT_RFSCST ,ENT_RFSCLA ,ENT_RFSBAS ,ENT_RFSALQ ,ENT_RFSVLR ';
      strSQL := strSQL + ' ,ENT_RFRCST ,ENT_RFRCLA ,ENT_RFRUFA ,ENT_RFRUVT ,ENT_RFRUMA ,ENT_RFRUMT ,ENT_RFRUCA ,ENT_RFRUCB ';
      strSQL := strSQL + ' ,ENT_RFIVAL ';
    End;
    strSQL := strSQL + ')';
  End
  Else
    strSQL := strSQL + ' ) ';

  Result := strSQL;
End;

function fRetSQLItem : String;
begin

  Result := ' SELECT ';
  Result := Result + '   ITE_CLAIPI, ';

  If fCfgSis('TIPABF') = '1' Then
    Result := Result + '   CADITE.ITE_CODABF AS ITE_CODABF, '
  Else
    Result := Result + '   ITEGER.ITE_CODABF AS ITE_CODABF, ';

  Result := Result + '   ITE_CODBAR, ';
  Result := Result + '   ITE_CODFAB, ';
  Result := Result + '   ITE_CODFOR, ';
  Result := Result + '   ITE_CODGRU, ';
  Result := Result + '   ITE_CODMAR, ';
  Result := Result + '   ITE_CODUNI, ';
  Result := Result + '   ITE_COMATA, ';
  Result := Result + '   ITE_COMDIS, ';
  Result := Result + '   ITE_COMLUB, ';
  Result := Result + '   ITE_COMTB1, ';
  Result := Result + '   ITE_COMTB2, ';
  Result := Result + '   ITE_COMTB3, ';
  Result := Result + '   ITE_COMTB4, ';
  Result := Result + '   ITE_COMTB5, ';
  Result := Result + '   ITE_COMTB6, ';
  Result := Result + '   ITE_COMTB7, ';
  Result := Result + '   ITE_COMVAR, ';
  Result := Result + '   ITE_DESFAB, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   ITE_DESMAX, ';
  Result := Result + '   ITE_DESMGE, ';
  Result := Result + '   ITE_DESMSU, ';
  Result := Result + '   ITE_DESOPE, ';
  Result := Result + '   ITE_DESSIM, ';
  Result := Result + '   ITE_FREENT, ';
  Result := Result + '   ITE_ICMSAI, ';

  If (fCfgSis('IMPDIG') = '1') Then
    Result := Result + '   CADITE.ITE_IMPDIR AS ITE_IMPDIR, '
  Else
    Result := Result + '   ITEGER.ITE_IMPDIR AS ITE_IMPDIR, ';

  Result := Result + '   ITE_IMPFED, ';
  Result := Result + '   ITE_IMPULT, ';
  Result := Result + '   ITE_INCPIS, ';
  Result := Result + '   ITE_IPIENT, ';
  Result := Result + '   ITE_IPISAI, ';
  Result := Result + '   ITE_LOCFIS, ';
  Result := Result + '   ITE_MARMGE, ';
  Result := Result + '   ITE_MARMIN, ';
  Result := Result + '   ITE_MARMSG, ';
  Result := Result + '   ITE_OBRCPF, ';
  Result := Result + '   ITE_OUTVAL, ';
  Result := Result + '   ITE_PESLIQ, ';
  Result := Result + '   ITE_PESOIT, ';
  Result := Result + '   ITE_PRECOM, ';
  Result := Result + '   ITE_PRECUS, ';
  Result := Result + '   ITE_PREMED, ';
  Result := Result + '   ITE_PREULT, ';
  Result := Result + '   ITE_PREVE1, ';
  Result := Result + '   ITE_PREVE2, ';
  Result := Result + '   ITE_PREVE3, ';
  Result := Result + '   ITE_PREVE4, ';
  Result := Result + '   ITE_PREVE5, ';
  Result := Result + '   ITE_PREVE6, ';
  Result := Result + '   ITE_PREVE7, ';
  Result := Result + '   ITE_QTPPRO, ';
  Result := Result + '   ITE_REFERE, ';
  Result := Result + '   ITE_SALDOS  ';
  Result := Result + ' FROM CADITE   ';
  Result := Result + '   INNER JOIN ITEGER ';
  Result := Result + ' ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ';
  Result := Result + '     AND ITEGER.ITE_CODEMP = :CODEMP ';
  Result := Result + '     AND CADITE.ITE_CODITE = :CODITE ';

end;

Procedure pCarregaItensPedidosTolerancia(fltCotDol: Double; qryItePed: TUniQuery; stlPedidos: TStringList = Nil);
// CARREGA OS DADOS ORIGINAIS DO PEDIDO
  Var
    intContador: Integer;
    strSQL: String;

  Function fSQLPedido(intContador: Integer): String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT       ';
    strSQL := strSQL + '  PCG_MOEDA_   AS MOEDA,     ';
    strSQL := strSQL + '  D.AUTOINCREM AS ENT_SEQPCD,';
    strSQL := strSQL + '  PCD_CODITE   AS ENT_CODITE,';
    strSQL := strSQL + '  PCD_QTDITE   AS ENT_QTDITE,';

    strSQL := strSQL + '  ROUND(ROUND(PCD_UNITAR ';
    strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUNI, 0) / 100) ';
    strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
    strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
    strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
    strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
    strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN6, 0) / 100), 4) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 4)  AS ENT_UNITAR, ';

    If fCfgSis('CNVEMB') <> 'N' Then
    Begin
      strSQL := strSQL + '  IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS ENT_EMBALA, ';
      strSQL := strSQL + '  IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS ENT_EMBPED  ';
    End

    Else
    Begin
      strSQL := strSQL + '  1 AS ENT_EMBALA, ';
      strSQL := strSQL + '  1 AS ENT_EMBPED  ';
    End;

    strSQL := strSQL + '  FROM         ';
    strSQL := strSQL + '    PCMDET D ';

    strSQL := strSQL + '  INNER JOIN PCMGER ON ';
    strSQL := strSQL + '         PCG_NUMPED = PCD_NUMPED ';
    strSQL := strSQL + '     AND PCG_CODEMP = PCD_CODEMP ';
    strSQL := strSQL + '     AND PCG_ESPDOC = PCD_ESPDOC ';
    strSQL := strSQL + '     AND PCG_NUMCTN = PCD_NUMCTN ';

    strSQL := strSQL + ' WHERE ';

    strSQL := strSQL + '   PCG_CODEMP = ' + QuotedStr(RightStr(stlPedidos[intContador], 3)) + ' AND ';
    strSQL := strSQL + '   PCD_NUMPED = ' + QuotedStr(LeftStr(stlPedidos[intContador], fTamDocCadRec()));

    Result := strSQL;
      End;

Begin
  If Not Assigned(qryItePed) Then
    Exit;

  If Assigned(stlPedidos) And (stlPedidos.Count > 0) Then
  Begin


    With qryItePed Do
    Begin
      Close;

      Filter   := '';
      Filtered := False;

      strSQL := fSQLPedido(0);

      For intContador := 1 To stlPedidos.Count - 1 Do
        strSQL := strSQL + ' UNION ALL ' + fSQLPedido(intContador);

      SQL.Text := strSQL;

      If fltCotDol = 0 Then
        fltCotDol := 1;

      If Assigned(Params.FindParam('COTMOE')) Then
        ParamByName('COTMOE').AsFloat := fltCotDol;

      Open;
    End;

  End Else
  Begin

    If Not fTabelaExiste('TMP_ENTMER') Then
      Exit;

    With qryItePed, SQL Do
    Begin
      Clear;
      Close;
      Add('SELECT       ');
      Add('  0 AS MOEDA,');
      Add('  ENT_SEQPCD,');
      Add('  ENT_CODITE,');
      Add('  ENT_QTDITE,');
      Add('  ENT_UNITAR,');
      Add('  ENT_EMBALA,');
      Add('  ENT_EMBPED ');
      Add('FROM         ');
      Add('  TMP_ENTMER ');
      Open;
    End;
  End;
End;

Function fVerificaQuantidadeAMaior(strCodIte: String;
                                   fltQtdDig, fltQtdAnt: Double;
                                   cdsItens: TUniClientDataSet;
                                   qryItePed: TDataSet;
                               Var fltQtdOri: Double;
                               var fltQtdNov: Double): Boolean;

  Var
    qryCopia: TUniQuery;
    strCnvEmb: String;
                               
  Function fSomaQuantidade(cdsDados: TDataSet; strCodIte: String): Double;
    Var
      fltEmbala: Double;
  Begin
    With cdsDados Do
    Begin
      Result := 0;
      Filter   := 'ENT_CODITE = ' + QuotedStr(strCodIte);
      Filtered := True;
      First;
      While Not Eof Do
      Begin
        If strCnvEmb = 'N' Then
          fltEmbala := 1
        Else  
          fltEmbala := FieldByName('ENT_EMBALA').AsFloat;
          
        Result    := Result + FieldByName('ENT_QTDITE').AsFloat * fltEmbala;
        Next;
      End;
    End
  End;

Begin
  If (Not Assigned(qryItePed)) Or
     (Not qryItePed.Active) Then
  Begin
    Result := True;
    Exit;
  End;

  strCnvEmb := fCfgSis('CNVEMB');
  
  If Assigned(cdsItens) Then
  Begin
    fltQtdNov := fSomaQuantidade(cdsItens, strCodIte);
  End Else
  Begin
    qryCopia := fCriaQuery;
    With qryCopia, SQL Do
    Begin
      Clear;
      
      If strCnvEmb = 'N' Then
        Add('SELECT SUM(ENT_QTDITE) AS QTDNOV FROM TMP_ENTMER')
      Else
        Add('SELECT SUM(ENT_QTDITE * ENT_EMBALA) AS QTDNOV FROM TMP_ENTMER');
      
      Add('WHERE ENT_CODITE = ' + QuotedStr(strCodIte));
      Open;
      fltQtdNov := FieldByName('QTDNOV').AsFloat;
      Close;
    End;
    FreeAndNil(qryCopia);
  End;

  fltQtdOri := fSomaQuantidade(qryItePed, strCodIte);
  fltQtdNov := RoundTo(fltQtdNov + fltQtdDig - fltQtdAnt, -2);
  Result := RoundTo(fltQtdNov, -2) <= RoundTo(fltQtdOri, -2);
End;

Function fVerificaQuantidadeDiferente(strCodIte: String;
                                      fltQtdDig, fltQtdAnt: Double;
                                      cdsItens: TUniClientDataSet; qryItePed: TDataSet;
                                      blnSenDif: Boolean): Boolean;
  Var
    strSenha: String;
    strCnvEmb: String;
    qryCopia: TUniQuery;
    fltQtdOri,
    fltQtdNov: Double;

  Function fSomaQuantidade(cdsDados: TDataSet; strCodIte: String): Double;
    Var
      fltEmbala: Double;
  Begin
    With cdsDados Do
    Begin
      Result := 0;

      Filter   := 'ENT_CODITE = ' + QuotedStr(strCodIte);
      Filtered := True;
      First;
      While Not Eof Do
      Begin
        If strCnvEmb = 'N' Then
          fltEmbala := 1
        Else
          fltEmbala := FieldByName('ENT_EMBALA').AsFloat;

        Result := Result + FieldByName('ENT_QTDITE').AsFloat * fltEmbala;
        Next;
      End;
    End
  End;

Begin
  If (Not Assigned(qryItePed)) Or
     (Not qryItePed.Active) Or
     (Not blnSenDif) Then
  Begin
    Result := True;
    Exit;
  End;

  strCnvEmb := fCfgSis('CNVEMB');

  If Assigned(cdsItens) Then
  Begin
    fltQtdNov := fSomaQuantidade(cdsItens, strCodIte);
  End Else
  Begin
    qryCopia := fCriaQuery;
    With qryCopia, SQL Do
    Begin
      Clear;

      If strCnvEmb = 'N' Then
        Add('SELECT SUM(ENT_QTDITE) AS QTDNOV FROM TMP_ENTMER')
      Else
        Add('SELECT SUM(ENT_QTDITE * ENT_EMBALA) AS QTDNOV FROM TMP_ENTMER');

      Add('WHERE ENT_CODITE = ' + QuotedStr(strCodIte));
      Open;
      fltQtdNov := FieldByName('QTDNOV').AsFloat;
      Close;
    End;
    FreeAndNil(qryCopia);
  End;

  fltQtdOri := fSomaQuantidade(qryItePed, strCodIte);

  Result := RoundTo(fltQtdNov + fltQtdDig - fltQtdAnt, -2) = RoundTo(fltQtdOri, -2);

  If Not Result Then
  Begin

    If ffrmSenha(strSenha, 'Quantidade diferente do pedido') Then
    Begin

      If fEmptyStr(fRetNomVendRep(fRetCodVendedor(strSenha))) Then
      Begin
        pMensagemOk('Senha inválida!');
        Result := False;
      End Else
      Begin
        Result := fVerificaAcessoSistema('SENDIFENT', fRetCodVendedor(strSenha));

        If Not Result Then
        Begin
          If strCnvEmb = 'N' Then
            pMensagemOk('Usuário sem direito a alteração! ' + #13#10 +
                       'A quantidade total do item deve ser igual a ' + FormatFloat('#0.00', fltQtdOri) + '!')
          Else
            pMensagemOk('Usuário sem direito a alteração! ' + #13#10 +
                       'A quantidade total do item multiplicada por sua embalagem deve ser igual a ' + FormatFloat('#0.00', fltQtdOri) + '!')
        End;

      End;
    End;

  End;
End;

Function fVerificaVariacaoPreco(qryItePed: TUniQuery; strCodIte: String;
                                fltValUni, fltOciVlr: Double): Boolean;
  Var
    strCnvEmb: String;
    fltUnitar: Double;
Begin
  If Not fCfgSis('VALOCI', varBoolean) Then
  Begin
    Result := True;
    Exit;
  End;

  strCnvEmb := fCfgSis('CNVEMB');

  With qryItePed Do
  If Assigned(qryItePed) And Active Then
  Begin
    Filter   := 'ENT_CODITE = ' + QuotedStr(strCodIte);
    Filtered := True;

    If IsEmpty Then
    Begin
      Result := True;
    End Else
    Begin
      Result := False;

      First;
      While Not Eof Do
      Begin
        If strCnvEmb = 'N' Then
          fltUnitar := FieldByName('ENT_UNITAR').AsFloat
        Else
          fltUnitar := FieldByName('ENT_UNITAR').AsFloat / IIF(FieldByName('ENT_EMBALA').AsFloat <> 0, FieldByName('ENT_EMBALA').AsFloat, 1);

        (*************************************************)
        (* ACHOU UM ITEM COM VALOR DENTRO DA TOLERANCIA  *)
        (**********************************************LA*)
        If RoundTo(Abs(fltValUni - fltUnitar), -2) <= fltOciVlr Then
        Begin
          Result   := True;
          Filtered := False;
          Exit;
        End;

        Next;
      End;
    End;

    Filtered := False;

    qryItePed.Locate('ENT_CODITE', strCodIte, []);
  End

  Else Result := True;
End;

function fSqlItensPedidos(arrPedidos, arrEmpresas: Array of String; strCodEmp: String;
                          blnSomConferido: Boolean): String;
  Var
    str_QTDCON,
    strSQL: String;
    intTamMat: Integer;
    intContador: Integer;
    intTabPrc: Integer;
    blnAtuICS: Boolean;
Begin
  intTamMat := Length(arrPedidos);

  If fCfgSis('CNVEMB') <> 'N' Then
    str_QTDCON := ' (P.PCD_QTDCON / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) '
  Else
    str_QTDCON := ' P.PCD_QTDCON ';

  blnAtuICS := fCfgSis('ATUICS', varBoolean);


  strSQL := strSQL + 'SELECT ';

  strSQL := strSQL + '  P.PCD_NUMPED, ';
  strSQL := strSQL + '  P.PCD_CODEMP, ';
  strSQL := strSQL + '  @N_ITEM := @N_ITEM + 1, ';           //ENT_N_ITEM
  strSQL := strSQL + '  @N_ITEM_TELA := @N_ITEM_TELA + 1, '; //ENT_N_ITEM_TELA
  strSQL := strSQL + '  "" AS NATOPE, ';

  strSQL := strSQL + '  P.AUTOINCREM, ';


  strSQL := strSQL + '     CASE          ';
  strSQL := strSQL + '       WHEN FOR_SIMPAU = "S" THEN IF(FOR_MATREV = "I",  A.ABF_IVA_ST_ENT_PSI, A.ABF_IVA_ST_ENT_PES) ';
  strSQL := strSQL + '       WHEN IFNULL(FOR_I_E_S_, "") ="" OR FOR_CGCCPF <> 1 THEN A.ABF_IVA_ST_ENT_PEF ';
  strSQL := strSQL + '       WHEN FOR_MATREV = "I" THEN A.ABF_IVA_ST_ENT_PEJ ';
  strSQL := strSQL + '       WHEN FOR_MATREV = "Y" THEN A.ABF_IVA_ST_ENT_PII ';
  strSQL := strSQL + '       ELSE A.ABF_IVA_ST_ENT_PER ';
  strSQL := strSQL + '     END AS ENT_IVA_ST, ';

  strSQL := strSQL + '   0 AS CAL_VLICMS, ';
  strSQL := strSQL + '   0 AS DET_CALSTU, ';
  strSQL := strSQL + '   0 AS CAL_BASICM, ';
  strSQL := strSQL + '   0 AS CAL_ALQICM, ';
  strSQL := strSQL + '   0 AS CAL_BAS_ST, ';
  strSQL := strSQL + '   0 AS CAL_VR_IVA, ';
  strSQL := strSQL + '   0 AS CAL_VR_SUB, ';
  strSQL := strSQL + '   0 AS CAL_ALQINT, ';
  strSQL := strSQL + '   0 AS CAL_VFCPST, ';
  strSQL := strSQL + ' CAST("N" AS CHAR(1)) AS ENT_ITETRI, ';

  strSQL := strSQL + '  P.PCD_CODFOR, ';
  strSQL := strSQL + '  I.ITE_DIFICM, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  P.PCD_CODITE, ';

  strSQL := strSQL + '      G.ITE_TIPPRO AS ENT_TIPPRO, ';
  strSQL := strSQL + '      0 AS ENT_DESPIS, ';
  strSQL := strSQL + '  G.ITE_PREDOL, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  If fCfgSIs('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR, '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR, ';

  (********************************************************)
  (* CONVERTENDO PARA VARCHAR POIS NA TELMAC É UM MEMO    *)
  (*****************************************************LA*)
  strSQL := strSQL + '  REPLACE(LEFT(PCD_DESITE,81), CHAR(13,10) ," ") AS PCD_DESITE, ';
  (********************************************************************)
  (* BUSCA A DESCRICAO DO CADITE TB PARA VERIFICAR SE É ITEM ESPECIAL *)
  (*****************************************************************LU*)
  strSQL := strSQL + '  I.ITE_DESITE AS ITE_DESITE, ';

  strSQL := strSQL + '  I.ITE_REFERE, ';

  If (fCfgSis('CNVEMB') = 'F') And fCfgSis('TABPRF', varBoolean) Then
  Begin
    strSQL := strSQL + '  IFNULL(IT.ITE_UNICOM, I.ITE_CODUNI) AS ITE_CODUNI, ';
    strSQL := strSQL + '  (SELECT UF.UNI_SIGUNI FROM CADUNI UF WHERE UF.UNI_CODUNI = IFNULL(IT.ITE_UNICOM, I.ITE_CODUNI)) AS ITE_SIGUNI, ';
  End Else
  Begin
    strSQL := strSQL + '  I.ITE_CODUNI, ';
    strSQL := strSQL + '  U.UNI_SIGUNI, ';
  End;

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF, '
  Else
    strSQL := strSQL + '  G.ITE_CODABF, ';

  strSQL := strSQL + '  A.ABF_DESABF, ';

  If Not blnSomConferido Then
  Begin

    strSQL := strSQL + '  (P.PCD_QTDITE - P.PCD_QTDBAI) AS PCD_QTDITE, '

  End Else
  Begin

    strSQL := strSQL + STR_QTDCON + ' AS PCD_QTDITE, ';

  End;

  strSQL := strSQL + '  ROUND(ROUND(P.PCD_UNITAR * (1 - IFNULL(P.PCD_DESUNI, 0) / 100) ';
  strSQL := strSQL + '                * (1 - IFNULL(P.PCD_DESUN2, 0) / 100) ';
  strSQL := strSQL + '                * (1 - IFNULL(P.PCD_DESUN3, 0) / 100) ';
  strSQL := strSQL + '                * (1 - IFNULL(P.PCD_DESUN4, 0) / 100) ';
  strSQL := strSQL + '                * (1 - IFNULL(P.PCD_DESUN5, 0) / 100) ';
  strSQL := strSQL + '                * (1 - IFNULL(P.PCD_DESUN6, 0) / 100) ';
  strSQL := strSQL + '    , 4) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 4)  AS PCD_UNITAR, ';

  strSQL := strSQL + '  P.PCD_PERIPI, ';

  If Not blnSomConferido Then
  Begin
    strSQL := strSQL + '  ROUND((P.PCD_TOTIPI - P.PCD_IPIBAI) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS PCD_TOTIPI, ';
    strSQL := strSQL + '  FOR_MATREV AS ENT_MATREV, ';
    // VARIAVEIS PARA GUARDAR O IPI QUANDO NAO UTILIZA CREDITOS DE IPI
    strSQL := strSQL + '0 AS ENT_USODES, ';

    If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
      strSQL := strSQL + ' ROUND((P.PCD_VALICM / P.PCD_QTDITE) * (P.PCD_QTDITE - P.PCD_QTDBAI) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_VICMDE, '
    Else
      strSQL := strSQL + ' 0.00 AS ENT_VICMDE, ';

    strSQL := strSQL + '  0.00 AS ENT_DESCON, ';

    strSQL := strSQL + '  CAST("" AS CHAR(2)) AS ENT_MTDICM, ';
    strSQL := strSQL + '  ROUND((P.PCD_TOTIPI - P.PCD_IPIBAI) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_VALIPI, ';

    strSQL := strSQL + '  ROUND((P.PCD_TOTITE - P.PCD_TOTBAI) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_BAEIPI, ';
    strSQL := strSQL + '  ROUND((P.PCD_TOTITE - P.PCD_TOTBAI) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_TOTITE, ';

    strSQL := strSQL + '  ROUND(((P.PCD_TOTSUB - P.PCD_SUBBAI) + (P.PCD_SUBFCP - P.PCD_FCPBAI) + (P.PCD_TOTIPI - P.PCD_IPIBAI) + (P.PCD_TOTITE - P.PCD_TOTBAI) ';

    If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
      strSQL := strSQL + ' - (P.PCD_VALICM / P.PCD_QTDITE) * (P.PCD_QTDITE - P.PCD_QTDBAI)  ';

    strSQL := strSQL + '   )  * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_TOTGER, ';
  End
  Else
  Begin

    strSQL := strSQL + ' ROUND(((P.PCD_TOTIPI - P.PCD_IPIBAI) / (P.PCD_QTDITE - P.PCD_QTDBAI) * ' + STR_QTDCON + ')  * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS PCD_TOTIPI, ';
    strSQL := strSQL + '  FOR_MATREV AS ENT_MATREV, ';

    strSQL := strSQL + '  0 ENT_USODES, ';

    If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
      strSQL := strSQL + ' ROUND( (P.PCD_VALICM / P.PCD_QTDITE) * ' + STR_QTDCON + '  * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_VICMDE, '
    Else
      strSQL := strSQL + ' 0.00 AS ENT_VICMDE, ';

    strSQL := strSQL + '  0.00 AS ENT_DESCON, ';

    strSQL := strSQL + '  CAST("" AS CHAR(2)) AS ENT_MTDICM, ';
    // VARIAVEIS PARA GUARDAR O IPI QUANDO NAO UTILIZA CREDITOS DE IPI
    strSQL := strSQL + ' ROUND(((P.PCD_TOTIPI - P.PCD_IPIBAI) / (P.PCD_QTDITE - P.PCD_QTDBAI) * ' + STR_QTDCON + ') * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_VALIPI, ';

    strSQL := strSQL + ' ROUND(((P.PCD_TOTIPI - P.PCD_IPIBAI) / (P.PCD_QTDITE - P.PCD_QTDBAI) * ' + STR_QTDCON + ') * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_BAEIPI, ';
    strSQL := strSQL + ' ROUND(((P.PCD_TOTITE - P.PCD_TOTBAI) / (P.PCD_QTDITE - P.PCD_QTDBAI) * ' + STR_QTDCON + ') * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_TOTITE, ';

    strSQL := strSQL + ' ROUND((((P.PCD_TOTSUB - P.PCD_SUBBAI) + (P.PCD_SUBFCP - P.PCD_FCPBAI) + (P.PCD_TOTIPI - P.PCD_IPIBAI) + (P.PCD_TOTITE - P.PCD_TOTBAI)) / (P.PCD_QTDITE - P.PCD_QTDBAI) * ' + STR_QTDCON;

    If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
      strSQL := strSQL + ' - (P.PCD_VALICM / P.PCD_QTDITE) * ' + STR_QTDCON;

    strSQL := strSQL + ' ) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_TOTGER, ';
  End;

  strSQL := strSQL + '  G.ITE_PRECOM, ';

  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06, ';

  strSQL := strSQL + '             0 AS ENT_GNRTSU, ';
  strSQL := strSQL + '  G.ITE_TCIFCU AS ENT_ALQTCI, ';
  strSQL := strSQL + '  G.ITE_TSCUST AS ENT_ALQ_TS, ';
  strSQL := strSQL + '  G.ITE_TCIFCU AS ENT_TCIFCU, ';
  strSQL := strSQL + '  G.ITE_TSCUST AS ENT_TSCUST, ';
  strSQL := strSQL + '  G.ITE_DEPICO AS ENT_DEPICO, ';
  strSQL := strSQL + '  G.ITE_DEICMS AS ENT_DEICMS, ';
  strSQL := strSQL + '  G.ITE_FATREG AS ENT_FATREG, ';

  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';

  If Not fCfgSis('ATUIPI', varBoolean) Then
    strSQL := strSQL + '  G.ITE_IPIENT, '
  Else
  Begin
    strSQL := strSQL + '  P.PCD_PERIPI AS ITE_IPIENT, '
  End;

  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_VALFRE, ';
  strSQL := strSQL + '  G.ITE_ACRFIN, ';

  If Not fCfgSis('ATUSUB', varBoolean) Then
    strSQL := strSQL + '  G.ITE_SUBSTI, '
  Else
  Begin
    strSQL := strSQL + ' P.PCD_PERSUB AS ITE_SUBSTI, '
  End;

  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';

  If blnAtuICS Then
  Begin
    strSQL := strSQL + '  IF((LOCATE(B.ABF_CODSIT_SAI_CNC, "'+CST_TRIBUTADO+'") > 0 ), ' ;
    strSQL := strSQL + '      ROUND(B.ABF_ALQICM_SAI_CNC * (B.ABF_BASICM_SAI_CNC / 100), 2), ';
    strSQL := strSQL + '      0) AS ITE_ICMSAI, ';
  End
  Else
    strSQL := strSQL + '  G.ITE_ICMSAI, ';

  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU, ';

  For intTabPrc := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  G.ITE_MARBR' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  G.ITE_PREVE' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  G.ITE_COMTB' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  " " AS ENT_PREEM' + IntToStr(intTabPrc) + ', ';
  End;

  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';

  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';

  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_CDCEST, ';

  {********************************************************************}
  {* FOI INCLUIDA A DATA DE BALANÇO POIS É NECESSÁRIO VERIFICAR       *}
  {* ESSA DATA NA CONFIRMAÇÃO DE ITENS PARA A ENTRADA DE MERCADORIAS  *}
  {*****************************************************************LA*}
  strSQL := strSQL + '  G.ITE_DTABAL, ';

  strSQL := strSQL + '  (@INC_ENTMER:=@INC_ENTMER+1) AS ENT_ENTMER, ';

  strSQL := strSQL + '  "M", '; //marcado...

  strSQL := strSQL + '  P.PCD_PERSUB, ';

  If Not blnSomConferido Then
  Begin
    strSQL := strSQL + ' ROUND((P.PCD_TOTSUB - P.PCD_SUBBAI) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS PCD_TOTSUB, '
  End Else
  Begin
    strSQL := strSQL + ' ROUND(((((P.PCD_TOTSUB - P.PCD_SUBBAI) / (P.PCD_QTDITE - P.PCD_QTDBAI)) * ' + STR_QTDCON + ') ) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS PCD_TOTSUB, ';
  End;

  If Not blnSomConferido Then
  Begin

    If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
      strSQL := strSQL + ' ROUND(((P.PCD_VALICM / P.PCD_QTDITE) * (P.PCD_QTDITE - P.PCD_QTDBAI)) * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_DESESP, '
    Else
      strSQL := strSQL + '  0.00 AS ENT_DESESP, '

  End Else
  Begin

    If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
      strSQL := strSQL + ' ROUND(((P.PCD_VALICM / P.PCD_QTDITE) * ' + STR_QTDCON + ') * IF(PCG_MOEDA_ = 1, :COTMOE, 1), 2) AS ENT_DESESP, '
    Else
      strSQL := strSQL + '  0.00 AS ENT_DESESP, '

  End;

  If fCfgSis('ENTPIS', varBoolean) Then
    strSQL := strSQL + '  I.ITE_INCPIS, '
  Else
    strSQL := strSQL + '  "N" AS ITE_INCPIS, ';

  strSQL := strSQL + '  P.PCD_CODACA, ';
  strSQL := strSQL + '  P.PCD_EMPACA, ';
  strSQL := strSQL + '  IF(P.PCD_CODACA = "" OR P.PCD_CODACA IS NULL, "N", "S") AS ENT_PROACA, ';
  strSQL := strSQL + '  AG.ACA_SALDOS, ';
  strSQL := strSQL + '  AG.ACA_PRECUS, ';
  strSQL := strSQL + '  AC.ACA_DESCRI, ';

  strSQL := strSQL + '  0  AS ENT_PERPIS,  ';  // PERCENTUAL DE PIS
  strSQL := strSQL + '  0  AS ENT_BASPIS, ';  // BASE DE PIS
  strSQL := strSQL + '  0  AS ENT_VALPIS, ';  // VALOR DE PIS
  strSQL := strSQL + '  0  AS ENT_PERCOF, ';  // PERCENTUAL DE COFINS
  strSQL := strSQL + '  0  AS ENT_BASCOF, ';  // BASE DE COFINS
  strSQL := strSQL + '  0  AS ENT_VALCOF, ';  // VALOR DE COFINS
  strSQL := strSQL + '  "" AS ENT_ITE_F5, ';  // ENT_ITE_F5

  strSQL := strSQL + '  I.ITE_RPRENT, ';
  strSQL := strSQL + '  P.PCD_NUMLOT, ';
  strSQL := strSQL + '  "" AS IDEPRO, ';
  strSQL := strSQL + '  "" AS ENT_ITETIN, ';
  strSQL := strSQL + '  I.ITE_GRAMAR, ';

  strSQL := strSQL + '  IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), ';  // EMBALAGEM DA ENTRADA DE MERCADORIAS - PODERÁ SER MODIFICADA NA ENTRADA
  strSQL := strSQL + '  IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), ';  // EMBALAGEM ORIGINAL DO PEDIDO

  If fCfgSis('CNVEMB') = 'F' Then
  Begin
    strSQL := strSQL + '  PCD_CODUNI AS ITE_UNICOM, ';
  End

  Else If fCfgSis('CNVEMB') = 'S' Then
  Begin
    strSQL := strSQL + '  I.ITE_UNICOM,  ';
  End

  Else
  Begin
    strSQL := strSQL + '  I.ITE_UNICOM,  ';
  End;
  strSQL := strSQL + ' "N" AS ENT_RICMPR, ';  // ENT_RICIMPR
  strSQL := strSQL + '   IF((SELECT COUNT(1) FROM CADLOT ';
  strSQL := strSQL + '    WHERE LOT_CODITE = G.ITE_CODITE';
  strSQL := strSQL + '      AND LOT_CODEMP = G.ITE_CODEMP) = 0 , "N", "S"), ';
  strSQL := strSQL + ' G.ITE_SALDOS, ';
  strSQL := strSQL + ' I.ITE_CNV_ML, ';
  strSQL := strSQL + ' CONCAT(IFNULL(I.ITE_CODMAR,""),"-",MAR_DESMAR) AS MAR_DESMAR, ';

  strSQL := strSQL + ' @CHAVE_TMP := @CHAVE_TMP + 1 ';

  If (fCfgSis('REFENT', varBoolean))  Then
  Begin
    strSQL := strSQL + ' , PCD_QTDREF ';
    strSQL := strSQL + ' ,0.0 AS ENT_QBCMON ';
    strSQL := strSQL + ' ,0.0 AS ENT_ADREMN ';
    strSQL := strSQL + ' ,0.0 AS ENT_VALMON ';
  End;

  strSQL := strSQL + 'FROM ';

  strSQL := strSQL + '  PCMGER PG ';

  strSQL := strSQL + '  INNER JOIN PCMDET P ';
  strSQL := strSQL + '     ON  PG.PCG_NUMPED = P.PCD_NUMPED ';
  strSQL := strSQL + '     AND PG.PCG_CODEMP = P.PCD_CODEMP ';
  strSQL := strSQL + '     AND PG.PCG_ESPDOC = P.PCD_ESPDOC ';
  strSQL := strSQL + '     AND PG.PCG_NUMCTN = P.PCD_NUMCTN ';

  strSQL := strSQL + '  INNER JOIN CADITE I ON P.PCD_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + '  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '                         G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  strSQL := strSQL + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';

  strSQL := strSQL + '  INNER JOIN CADFOR F ON P.PCD_CODFOR = F.FOR_CODFOR ';

  strSQL := strSQL + '  INNER JOIN CADCID C ON F.FOR_CODCID = C.CID_CODCID ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  INNER JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF AND '
  Else
    strSQL := strSQL + '  INNER JOIN ABFICM A ON A.ABF_CODABF = G.ITE_CODABF AND ';

  strSQL := strSQL + '                         A.ABF_ESTADO = C.CID_ESTADO ';

  If blnAtuICS Then
  Begin

    If fCfgSis('TIPABF') = '1' Then
      strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = I.ITE_CODABF AND '
    Else
      strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = G.ITE_CODABF AND ';

    strSQL := strSQL + '                         B.ABF_ESTADO = ' + QuotedStr(fCadEmpDes('ESTADO', VS_strCodEmp));

  End;

  strSQL := strSQL + '  LEFT JOIN ACAGER AG ON AG.ACA_CODACA = P.PCD_CODACA AND ';
  strSQL := strSQL + '                         AG.ACA_CODEMP = P.PCD_EMPACA AND ';
  strSQL := strSQL + '                         AG.ACA_EMPEST = P.PCD_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADACA AC ON AC.ACA_CODACA = P.PCD_CODACA AND ';
  strSQL := strSQL + '			 AC.ACA_CODEMP = P.PCD_EMPACA ';

  strSQL := strSQL + '  LEFT JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR ';

  If (fCfgSis('CNVEMB') = 'F') And fCfgSis('TABPRF', varBoolean) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN ITEFOR IT ON IT.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '                         IT.ITE_CODFOR =   PCG_CODFOR AND ';
    strSQL := strSQL + '                        (SELECT COUNT(*) FROM TABPRE      ';
    strSQL := strSQL + '                         WHERE IT.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End;


  strSQL := strSQL + 'WHERE ';

  If blnSomConferido Then
    strSQL := strSQL + '  P.PCD_QTDCON > 0 AND ';

  strSQL := strSQL + '  P.PCD_NUMCTN = 0 AND ';

  strSQL := strSQL + '  (P.PCD_BAIXAD = FALSE OR P.PCD_BAIXAD IS NULL) AND ';

  strSQL := strSQL + '  P.PCD_ESPDOC = "PD" AND ';

  strSQL := strSQL + ' ( ';
  For intContador := 0 To intTamMat -1 Do
  Begin
    strSQL := strSQL + ' ( ';
    strSQL := strSQL + ' PG.PCG_NUMPED = ' + QuotedStr(arrPedidos[intContador]) + ' AND ';
    strSQL := strSQL + ' PG.PCG_CODEMP = ' + QuotedStr(arrEmpresas[intContador]);
    strSQL := strSQL + ' ) ';

    If intContador < (intTamMat -1) Then
      strSQL := strSQL + ' OR ';
  End;
  strSQL := strSQL + ' ) ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  P.AUTOINCREM ';

  Result := strSQL;
End;

function fSqlItensGarantia(strCodEmp: String;
                           blnRecClienteGrantia: Boolean;
                           strNumEnt: String;
                           blnRetornoForn: Boolean = False;
                           strClaFisEnt:String = '';
                           strChaveSEQGAG: String = '';
                           strCodFor: String = ''): String;
  Function fSQLDet(strCampo : String) : String;
  Begin
    Result := ' IF(D1.AUTOINCREM IS NULL, D2.' + strCampo + ', D1.' + strCampo + ')';
  End;

  Var
    strSQL: String;
    intTabPrc: Integer;
    blnFilEmp: Boolean;
Begin
  If (fCfgSis('GARMAT', varBoolean)) then
    blnFilEmp := (VS_strCodEmp <> fCfgSis('EMPGAR', varString))
  Else
    blnFilEmp := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ""           AS PEDNUM, ';
  strSQL := strSQL + '  G.GAG_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  @N_ITEM := @N_ITEM + 1, ';           //ENT_N_ITEM
  strSQL := strSQL + '  @N_ITEM_TELA := @N_ITEM_TELA + 1, '; //ENT_N_ITEM_TELA

  strSQL := strSQL + '  ""           AS NATOPE, ';
  strSQL := strSQL + '  ""           AS SEQPED, ';

  If Not blnRecClienteGrantia Then
  Begin
    strSQL := strSQL + '   CASE ';
    strSQL := strSQL + '     WHEN FOR_SIMPAU = "S" THEN IF(IFNULL(AUX_MATREV, FOR_MATREV) = "I",  A.ABF_IVA_ST_ENT_PSI, A.ABF_IVA_ST_ENT_PES) ';
    strSQL := strSQL + '     WHEN IFNULL(FOR_I_E_S_, "") ="" OR FOR_CGCCPF <> 1 THEN A.ABF_IVA_ST_ENT_PEF ';
    strSQL := strSQL + '     WHEN IFNULL(AUX_MATREV, FOR_MATREV) = "I" THEN A.ABF_IVA_ST_ENT_PEJ ';
    strSQL := strSQL + '     WHEN IFNULL(AUX_MATREV, FOR_MATREV) = "Y" THEN A.ABF_IVA_ST_ENT_PII ';
    strSQL := strSQL + '     WHEN IFNULL(AUX_MATREV, FOR_MATREV) = "Y" THEN A.ABF_IVA_ST_ENT_PII ';

    strSQL := strSQL + '     ELSE A.ABF_IVA_ST_ENT_PER ';
    strSQL := strSQL + '   END AS ENT_IVA_ST, ';
  End
  Else
    strSQL := strSQL + '   0.0000 AS ENT_IVA_ST, ';

  strSQL := strSQL + '   0 AS CAL_VLICMS , ';
  strSQL := strSQL + '   0 AS DET_CALSTU , ';
  strSQL := strSQL + '   0 AS CAL_BASICM, ';
  strSQL := strSQL + '   0 AS CAL_ALQICM, ';
  strSQL := strSQL + '   0 AS CAL_BAS_ST, ';
  strSQL := strSQL + '   0 AS CAL_VR_IVA, ';
  strSQL := strSQL + '   0 AS CAL_VR_SUB, ';
  strSQL := strSQL + '   0 AS CAL_ALQINT, ';
  strSQL := strSQL + '   0 AS CAL_VFCPST, ';

  strSQL := strSQL + ' CAST("N" AS CHAR(1)) AS ENT_ITETRI, ';
  strSQL := strSQL + '  D.GAD_CODFOR AS CODFOR, ';
  strSQL := strSQL + '  I.ITE_DIFICM AS DIFICM, ';
  strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  D.GAD_CODITE AS CODITE, ';
  strSQL := strSQL + '  T.ITE_TIPPRO AS ENT_TIPPRO, ';
  strSQL := strSQL + '      0 AS ENT_DESPIS, ';


  strSQL := strSQL + '  T.ITE_PREDOL AS PREDOL, ';
  strSQL := strSQL + '  I.ITE_CODGRU AS CODGRU, ';
  If fCfgSIs('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR, '
  Else
    strSQL := strSQL + '  T.ITE_IMPDIR, ';


  strSQL := strSQL + '  IF(COALESCE(I.ITE_CODFAB, "") <> "", CONCAT(I.ITE_CODFAB, " ", I.ITE_DESITE), I.ITE_DESITE) AS GADDES, ';
  strSQL := strSQL + '  I.ITE_DESITE AS ITEDES, ';
  strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  I.ITE_CODUNI AS CODUNI, ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF AS CODABF, '
  Else
    strSQL := strSQL + '  T.ITE_CODABF AS CODABF, ';

  strSQL := strSQL + '  A.ABF_DESABF AS DESABF, ';

  If Not blnRecClienteGrantia Then
  Begin
    strSQL := strSQL + '  SUM(L.GAU_QTDRET) AS QTDITE, ';
    strSQL := strSQL + '  IFNULL(GAE_PRECUS, D.GAD_PRECUS) AS PRECUS, ';                                        //PRECUS
    strSQL := strSQL + '  IF(IFNULL(D2.DET_ALEIPI,0) > 0, D2.DET_ALEIPI, IFNULL(D1.DET_ALQIPI,0)) AS PERIPI, ';                     //PERIPI
    strSQL := strSQL + '  (IF(IFNULL(D2.DET_VAEIPI,0) > 0 , D2.DET_VAEIPI, IFNULL(D1.DET_VALIPI,0))) AS TOTIPI, ';                  //TOTIPI
    strSQL := strSQL + '  FOR_MATREV AS ENT_MATREV, ';
    strSQL := strSQL + '  DET_BASIPI AS BASIPI, ';                                                              //BASIPI
    strSQL := strSQL + '  DET_BASRET AS BASRET, ';                                                              //BASRET
    strSQL := strSQL + '  DET_VALRET AS VALRET, ';                                                              //VALRET
    strSQL := strSQL + '  DET_BASRET AS BAERET, ';                                                              //BAERET
    strSQL := strSQL + '  DET_VALRET AS VAERET, ';                                                              //VAERET
    strSQL := strSQL + '  "" AS CODFIS, ';                                                                      //CODFIS
    strSQL := strSQL + '  "" AS CLAFIS, ';                                                                      //CLAFIS
    strSQL := strSQL + '  DET_BASICM AS ENT_BASICM, ';                                                          //BASICM
    strSQL := strSQL + '  DET_ALQICM AS ENT_ALQICM, ';                                                          //ALQICM
    strSQL := strSQL + '  DET_VALICM AS ENT_VALICM, ';                                                          //VALICM
    strSQL := strSQL + '  IFNULL((D2.DET_VAEIPI/D1.DET_QTDITE),0) AS VALIPI, ';                                 //VALIPI
    strSQL := strSQL + '  IFNULL((D2.DET_BAEIPI/D1.DET_QTDITE),0) AS BAEIPI, ';                                 //BAEIPI
    strSQL := strSQL + ' (SUM(L.GAU_QTDRET) * IFNULL(GAE_PRECUS, D.GAD_PRECUS)) AS TOTITE, ';                   //TOTITE
    strSQL := strSQL + ' (L.GAU_QTDRET * IFNULL(GAE_PRECUS, D.GAD_PRECUS)) AS TOTGER, ';                        //TOTGER
  End
  Else
  Begin
   strSQL := strSQL + '  SUM(D.GAD_QTDREQ) AS QTDITE, ';
    strSQL := strSQL + '  (D.GAD_VALITE / D.GAD_QTDREQ) AS PRECUS, ';
    strSQL := strSQL + fSQLDet('DET_ALQIPI') + ' AS PERIPI, ';
    strSQL := strSQL + '  (' + fSQLDet('DET_VALIPI') + ' / ' + fSQLDet('DET_QTDITE') + ')  AS TOTIPI, ';
    strSQL := strSQL + '  "" AS ENT_MATREV, ';
    strSQL := strSQL + '  (' + fSQLDet('DET_BASIPI') + ' / ' + fSQLDet('DET_QTDITE') + ')  AS BASIPI, ';
    strSQL := strSQL + '  (' + fSQLDet('DET_BASRET') + ' / ' + fSQLDet('DET_QTDITE') + ')  AS BASRET, ';
    strSQL := strSQL + '  (' + fSQLDet('DET_VALRET') + ' / ' + fSQLDet('DET_QTDITE') + ')  AS VALRET, ';
    strSQL := strSQL + '  (' + fSQLDet('DET_BASRET') + ' / ' + fSQLDet('DET_QTDITE') + ')  AS BAERET, ';
    strSQL := strSQL + '  (' + fSQLDet('DET_VALRET') + ' / ' + fSQLDet('DET_QTDITE') + ')  AS VAERET, ';
    strSQL := strSQL + fSQLDet('DET_CODFIS') + ' AS DET_CODFIS, ';
    strSQL := strSQL + QuotedStr(strClaFisEnt) + ' AS CLAFIS, ';
    strSQL := strSQL + '  (' + fSQLDet('DET_BASICM') + ' / ' + fSQLDet('DET_QTDITE') + ') AS BASICM, '; // * D.GAD_QTDREQ
    strSQL := strSQL + fSQLDet('DET_ALQICM')+ ' DET_ALQICM, ';
    strSQL := strSQL + '  (' + fSQLDet('DET_VALICM') + ' / ' + fSQLDet('DET_QTDITE') + '), ';          //* D.GAD_QTDREQ
    strSQL := strSQL + '  (' + fSQLDet('DET_VALIPI') + ' / ' + fSQLDet('DET_QTDITE') + ') AS VALIPI, '; //* D.GAD_QTDREQ
    strSQL := strSQL + '  (' + fSQLDet('DET_BASIPI') + ' / ' + fSQLDet('DET_QTDITE') + ') AS BAEIPI, '; //* D.GAD_QTDREQ

    strSQL := strSQL + '  IFNULL(((' + fSQLDet('DET_TOTITE') + ' - ' + fSQLDet('DET_DESESP') + ') / ' + fSQLDet('DET_QTDITE') + '), (D.GAD_VALITE/D.GAD_QTDREQ)) * SUM(D.GAD_QTDREQ) AS TOTITE, ';    //TOTITE
    strSQL := strSQL + '  ((' + fSQLDet('DET_TOTITE') + ' - ' + fSQLDet('DET_DESESP') + ') / ' + fSQLDet('DET_QTDITE') + ') * SUM(D.GAD_QTDREQ) AS TOTGER, ';                                         //TOTGER
  End;

  strSQL := strSQL + '  T.ITE_PRECOM AS PRECOM, ';
  strSQL := strSQL + '  T.ITE_DESF01 AS DESFO1, ';
  strSQL := strSQL + '  T.ITE_DESF02 AS DESFO2, ';
  strSQL := strSQL + '  T.ITE_DESF03 AS DESFO3, ';
  strSQL := strSQL + '  T.ITE_DESF04 AS DESFO4, ';
  strSQL := strSQL + '  T.ITE_DESF05 AS DESFO5, ';
  strSQL := strSQL + '  T.ITE_DESF06 AS DESFO6, ';

  strSQL := strSQL + '             0 AS GNRTSU, ';
  strSQL := strSQL + '  T.ITE_TCIFCU AS ENT_ALQTCI, ';
  strSQL := strSQL + '  T.ITE_TSCUST AS ENT_ALQ_TS, ';

  strSQL := strSQL + '  T.ITE_TCIFCU AS TCIFCU, ';
  strSQL := strSQL + '  T.ITE_TSCUST AS TSCUST, ';
  strSQL := strSQL + '  T.ITE_DEPICO AS DEPICO, ';
  strSQL := strSQL + '  T.ITE_DEICMS AS DEICMS, ';
  strSQL := strSQL + '  T.ITE_FATREG AS FATREG, ';
  strSQL := strSQL + '  T.ITE_ICMENT AS ICMENT, ';
  strSQL := strSQL + '  T.ITE_SUBFED AS SUBFED, ';
  strSQL := strSQL + '  T.ITE_IPIENT AS IPIENT, ';
  strSQL := strSQL + '  T.ITE_FREENT AS FREENT, ';
  strSQL := strSQL + '  T.ITE_VALFRE AS VALFRE, ';
  strSQL := strSQL + '  T.ITE_ACRFIN AS ACRFIN, ';
  strSQL := strSQL + '  T.ITE_SUBSTI AS SUBSTI, ';
  strSQL := strSQL + '  T.ITE_OUTVAL AS OUTVAL, ';
  strSQL := strSQL + '  T.ITE_IMPFED AS IMPFED, ';
  strSQL := strSQL + '  T.ITE_DESOPE AS DESOPE, ';
  strSQL := strSQL + '  D.GAD_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  T.ITE_ICMSAI AS ICMSAI, ';
  strSQL := strSQL + '  T.ITE_DESMAX AS DESMAX, ';
  strSQL := strSQL + '  T.ITE_DESMGE AS DESMGE, ';
  strSQL := strSQL + '  T.ITE_DESMSU AS DESMSU, ';

  For intTabPrc := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  T.ITE_MARBR' + IntToStr(intTabPrc) + ' AS MARBR' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  T.ITE_PREVE' + IntToStr(intTabPrc) + ' AS PREVE' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  T.ITE_COMTB' + IntToStr(intTabPrc) + ' AS COMTB' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  " " AS ENT_PREEM' + IntToStr(intTabPrc) + ', ';
  End;

  strSQL := strSQL + '  T.ITE_MARMIN AS MARMIN, ';
  strSQL := strSQL + '  T.ITE_MARMSG AS MARMSG, ';
  strSQL := strSQL + '  T.ITE_MARMGE AS MARMGE, ';

  strSQL := strSQL + '  T.ITE_DESMVM AS DESMVM, ';
  strSQL := strSQL + '  T.ITE_DESMSM AS DESMSM, ';
  strSQL := strSQL + '  T.ITE_DESMGM AS DESMGM, ';

  strSQL := strSQL + '  T.ITE_MARMMV AS MARMMV, ';
  strSQL := strSQL + '  T.ITE_MARMMS AS MARMMS, ';
  strSQL := strSQL + '  T.ITE_MARMMG AS MARMMG, ';

  strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
  strSQL := strSQL + '  I.ITE_CDCEST AS CDCEST, ';
  strSQL := strSQL + '  T.ITE_DTABAL AS DTABAL, ';
  strSQL := strSQL + '  (@INC_ENTMER:=@INC_ENTMER+1) AS ENTMER, ';
  strSQL := strSQL + '  "M" AS MARCAD, ';
  strSQL := strSQL + '  0   AS PERSUB, ';
  strSQL := strSQL + '  0   AS TOTSUB, ';

  If fCfgSis('ENTPIS', varBoolean) Then
    strSQL := strSQL + '  I.ITE_INCPIS AS INCPIS, '
  Else
    strSQL := strSQL + '  "N" AS INCPIS, ';

  strSQL := strSQL + '  "" AS CODADA,  ';
  strSQL := strSQL + '  "" AS EMPACA,  ';
  strSQL := strSQL + '  "N" AS PROACA, ';
  strSQL := strSQL + '  0 AS ACASAL,   ';
  strSQL := strSQL + '  0 AS ACACUS,   ';
  strSQL := strSQL + '  "" AS ACADES,  ';
  strSQL := strSQL + '  0  AS PERPIS,  ';
  strSQL := strSQL + '  0  AS BASPIS,  ';
  strSQL := strSQL + '  0  AS VALPIS,  ';
  strSQL := strSQL + '  0  AS PERCOF,  ';
  strSQL := strSQL + '  0  AS BASCOF,  ';
  strSQL := strSQL + '  0  AS VALCOF,  ';
  strSQL := strSQL + '  "" AS ITE_F5,  ';
  strSQL := strSQL + '  I.ITE_RPRENT AS RPRENT, ';

  strSQL := strSQL + '  IFNULL( (      ';
  strSQL := strSQL + '          SELECT LOT_NUMLOT                                  ';
  strSQL := strSQL + '          FROM CADLOT                                        ';
  strSQL := strSQL + '          WHERE                                              ';
  strSQL := strSQL + '            LOT_CODITE = D.GAD_CODITE AND                    ';
  strSQL := strSQL + '            LOT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';

  if ( blnRetornoForn ) then
    strSQL := strSQL + '            LOT_ARMPRI = "S"), "")  AS NUMLOT,             '
  else
    strSQL := strSQL + '            LOT_GARPRI = "S"), "")  AS NUMLOT,             ';


  strSQL := strSQL + ' "" AS IDEPRO, ';
  strSQL := strSQL + ' "" AS ENT_ITETIN, ';
  strSQL := strSQL + '  I.ITE_GRAMAR, ';


  //na garantia nao tem que considerar a embalagem, tem que entrar a qtd digitada na garantia.
  //strSQL := strSQL + '  IF(I.ITE_EMBALA IS NULL OR I.ITE_EMBALA <= 0, 1, I.ITE_EMBALA) AS EMBALA, '; // ENT_EMBALA
  //strSQL := strSQL + '  IF(I.ITE_EMBALA IS NULL OR I.ITE_EMBALA <= 0, 1, I.ITE_EMBALA) AS EMBALA, '; // ENT_EMBPED
  strSQL := strSQL + '  1 AS EMBALA, '; // ENT_EMBALA
  strSQL := strSQL + '  1 AS EMBALA, '; // ENT_EMBPED

  strSQL := strSQL + '  I.ITE_UNICOM AS UNICOM, ';
  strSQL := strSQL + '       "N" AS ENT_RICMPR, ';
  strSQL := strSQL + '   IF((SELECT COUNT(1) FROM CADLOT ';
  strSQL := strSQL + '    WHERE LOT_CODITE = T.ITE_CODITE';
  strSQL := strSQL + '      AND LOT_CODEMP = T.ITE_CODEMP) = 0 , "N", "S"), ';
  strSQL := strSQL + ' T.ITE_SALDOS, ';
  strSQL := strSQL + ' I.ITE_CNV_ML, ';
  strSQL := strSQL + ' CONCAT(IFNULL(I.ITE_CODMAR,""),"-",MAR_DESMAR) AS MAR_DESMAR, ';

  if blnRecClienteGrantia then
  begin
    strSQL := strSQL + ' (IFNULL(D1.DET_DESESP, IFNULL(D2.DET_DESESP,0)) / ';
    strSQL := strSQL + '    IF((IFNULL(D1.DET_QTDITE, IFNULL(D2.DET_QTDITE,0)) = 0),';
    strSQL := strSQL + '         1,  ';
    strSQL := strSQL + '           (IFNULL(D1.DET_QTDITE, IFNULL(D2.DET_QTDITE,0))))) AS "DESESP", ';
  end;

  strSQL := strSQL + ' @CHAVE_TMP := @CHAVE_TMP + 1 ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGAG G  INNER JOIN MOVGAD D  ON  G.AUTOINCREM  = D.GAD_SEQGAG ';

  If Not blnRecClienteGrantia Then
  Begin
    strSQL := strSQL + '            INNER JOIN MOVGAU L  ON  D.AUTOINCREM  = L.GAU_SEQGAD ';
    strSQL := strSQL + '            LEFT JOIN MOVGAE E ON L.GAU_SEQGAE = E.AUTOINCREM ';
    strSQL := strSQL + '            LEFT JOIN MOVDET D1 ON D1.AUTOINCREM = E.GAE_INCENV  ';
    strSQL := strSQL + '               LEFT JOIN MOVTRI D2 ON D2.DET_SEQGER = IF(IFNULL(E.GAE_INCENV, "") <> "" , E.GAE_INCENV , D1.AUTOINCREM) ';
    strSQL := strSQL + '                                AND IF(IFNULL(E.GAE_INCENV, "") <> "", TRUE , D2.DET_SEQGAD = D.AUTOINCREM) ';
  End
  Else
  Begin
    strSQL := strSQL + '            LEFT JOIN MOVDET D1 ON D1.DET_NUMDOC = GAD_NUMDOC ';
    strSQL := strSQL + '                               AND D1.DET_ESPDOC = GAD_ESPDOC ';
    strSQL := strSQL + '                               AND D1.DET_CODCLI = GAG_CODCLI ';
    strSQL := strSQL + '                               AND D1.DET_CODITE = GAD_CODITE ';
    strSQL := strSQL + '                               AND D1.AUTOINCREM = GAD_SEQDOC ';

    strSQL := strSQL + '            LEFT JOIN NOTDET D2 ON D2.DET_NUMDOC = GAD_NUMDOC ';
    strSQL := strSQL + '                               AND D2.DET_ESPDOC = GAD_ESPDOC ';
    strSQL := strSQL + '                               AND D2.DET_CODCLI = GAG_CODCLI ';
    strSQL := strSQL + '                               AND D2.DET_CODITE = GAD_CODITE ';
    strSQL := strSQL + '                               AND D2.AUTOINCREM = GAD_SEQDOC ';
  End;

  strSQL := strSQL + '            LEFT JOIN AUXMOV AX ON AX.AUX_SEQGER = D1.DET_SEQGER ';

  strSQL := strSQL + '            INNER JOIN CADITE I  ON  D.GAD_CODITE  = I.ITE_CODITE ';
  strSQL := strSQL + '            INNER JOIN ITEGER T  ON  I.ITE_CODITE  = T.ITE_CODITE ';

  If blnRetornoForn then
    strSQL := strSQL + '                              AND  T.ITE_CODEMP  = ' + QuotedStr(VS_strCodEmp) + ' '
  else
  begin
    If blnFilEmp Then
      strSQL := strSQL + '                              AND  T.ITE_CODEMP  = ' + QuotedStr(VS_strCodEmp) + ' '
    else
      strSQL := strSQL + '                              AND  T.ITE_CODEMP  = G.GAG_CODEMP ';
  end;

  strSQL := strSQL + '            INNER JOIN CADUNI U  ON  U.UNI_CODUNI  = I.ITE_CODUNI ';

  If Not blnRecClienteGrantia Then
  Begin
    strSQL := strSQL + '            INNER JOIN CADFOR F  ON  D.GAD_CODFOR  = F.FOR_CODFOR ';
    strSQL := strSQL + '            INNER JOIN CADCID C  ON  F.FOR_CODCID  = C.CID_CODCID ';
  End
  Else
  Begin
    strSQL := strSQL + '            INNER JOIN CADCLI F  ON  G.GAG_CODCLI  = F.CLI_CODCLI ';
    strSQL := strSQL + '            INNER JOIN CADCID C  ON  F.CLI_CODCID  = C.CID_CODCID ';
  End;

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '          INNER JOIN ABFICM A  ON  A.ABF_CODABF = I.ITE_CODABF AND '
  Else
    strSQL := strSQL + '          INNER JOIN ABFICM A  ON  A.ABF_CODABF = T.ITE_CODABF AND ';

  strSQL := strSQL + '                                     A.ABF_ESTADO  = C.CID_ESTADO ';

  strSQL := strSQL + '  LEFT JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR ';

  strSQL := strSQL + 'WHERE TRUE ';

  If blnFilEmp Then
    strSQL := strSQL + '  AND G.GAG_CODEMP = ' + QuotedStr(strCodEmp);

  If Not blnRecClienteGrantia Then
    strSQL := strSQL + '  AND IFNULL(L.GAU_SEQDET,"") = "" '
  Else
    strSQL := strSQL + '  AND G.GAG_NUMENT = "' + strNumEnt + '" ';

  If strChaveSEQGAG <> '' Then
      strSQL := strSQL + '  AND G.AUTOINCREM in (' + strChaveSEQGAG + ') ';

  if blnRetornoForn then
      strSQL := strSQL + '  AND F.FOR_CODFOR = '+QuotedStr(strCodFor);

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  CODITE, PEDNUM, CODEMP, SEQPED, CODFOR, CODFAB, CODGRU, ';
  strSQL := strSQL + '  GADDES, ITEDES, REFERE, CODUNI, SIGUNI, CODABF, DESABF, ';
  strSQL := strSQL + '  PERIPI, TOTIPI, VALIPI, BAEIPI, PRECOM, DESFO1, ';
  strSQL := strSQL + '  DESFO2, DESFO3, DESFO4, DESFO5, DESFO6, ICMENT, SUBFED, ';
  strSQL := strSQL + '  IPIENT, FREENT, VALFRE, ACRFIN, SUBSTI, OUTVAL, IMPFED, ';

  For intTabPrc := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  MARBR' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  PREVE' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  COMTB' + IntToStr(intTabPrc) + ', ';
  End;

  strSQL := strSQL + '  DESOPE, ICMSAI, DESMAX, DESMGE, DESMSU,   ';
  strSQL := strSQL + '  MARMIN, MARMSG, MARMGE, CLAIPI, CDCEST,  DTABAL, ENTMER,         ';
  strSQL := strSQL + '  MARCAD, PERSUB, TOTSUB, INCPIS, CODADA, EMPACA, PROACA, ';
  strSQL := strSQL + '  ACASAL, ACACUS, ACADES, PERPIS, BASPIS, VALPIS, PERCOF, ';
  strSQL := strSQL + '  BASCOF, VALCOF, ITE_F5, RPRENT, NUMLOT, EMBALA, UNICOM   ';
  If Not blnRecClienteGrantia Then
    strSQL := strSQL + '  ,IFNULL(GAE_PRECUS, D.GAD_PRECUS) '
  Else
    strSQL := strSQL + '  , PRECUS ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  D.GAD_CODITE ';

  Result := strSQL;
End;

{*****************************************}
{* GERA UMA TABELA TEMPORARIA COM TODOS  *}
{* OS ITENS DOS PEDIDOS PASSADOS POR     *}
{* PARÂMETROS                            *}
{**************************************MV*}
function fCarregaItensPedidos(fltCotDol: Double;
                              arrPedidos,
                              arrEmpresas: Array of String;
                              strCodEmp: String;
                              blnSomConferido: Boolean;
                              qryItePed: TUniQuery): Boolean;
  Var
    strSQL: String;
    qryGenMer: TUniQuery;
    sltPedidos: TStringList;
    intContador: Integer;
begin
  qryGenMer := fCriaQuery;

  Screen.Cursor := crHourGlass;

  Try
    {*****************************************}
    {* CRIA A TABELA TEMPORARIA              *}
    {**************************************MV*}
    pCriaTabelaEntradaMercadorias;

    With qryGenMer Do
    Begin
      qryGenMer.ParamCheck := FALSE;

      strSQL := fSqlInsertEntMer;

      strSQL := strSQL + fSqlItensPedidos(arrPedidos, arrEmpresas, strCodEmp, blnSomConferido);

      If fltCotDol = 0 Then
        fltCotDol := 1;

      strSQL := AnsiReplaceStr(strSQL, ':COTMOE', AnsiReplaceStr(FormatFloat('#0.0000', fltCotDol), ',', '.'));

      {*****************************************}
      {* EXECUTA O INSERT NA TABELA TEMPORARIA *}
      {**************************************MV*}
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ExecSQL;
      Close;

      If fCfgSis('VALOCI', varBoolean) Or
         (Not fCfgSis('ALTMAI', varBoolean)) Or
         fCfgSis('SENDIF', varBoolean) Or
         (fCfgSis('CNVEMB') <> 'N') Then
      Begin
        sltPedidos := TStringList.Create;

        For intContador := Low(arrPedidos) To High(arrPedidos) Do
          sltPedidos.Add(arrPedidos[intContador] + arrEmpresas[intContador]);

        pCarregaItensPedidosTolerancia(fltCotDol, qryItePed, sltPedidos);

        FreeAndNil(sltPedidos);
    End;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaItensPedidos]');
    End;
  End;

  Screen.Cursor := crDefault;

  FreeAndNil(qryGenMer);
end;

{*****************************************}
{* GERA UMA TABELA TEMPORARIA COM TODOS  *}
{* OS ITENS ENVIADOS PELO FORNECEDOR     *}
{* NO RETORNO DE CONSERTO EM GARANTIA    *}
{**************************************MM*}
function fCarregaItensGarantia(strCodEmp: String;
                               qryItePed: TUniQuery;
                               blnRecClienteGrantia: Boolean;
                               strNumEnt: String;
                               blnRetornoForn: Boolean = False;
                               strClaFisEnt: String = '';
                               strChaveSEQGAG: String = '';
                               strCodFor: String = ''): Boolean;
    Var
    strSQL   : String;
    qryGenMer: TUniQuery;
begin
  qryGenMer     := fCriaQuery;
  Screen.Cursor := crHourGlass;

  Try
    {*****************************************}
    {* CRIA A TABELA TEMPORARIA              *}
    {**************************************MV*}
    pCriaTabelaEntradaMercadorias;

    With qryGenMer Do
    Begin
      qryGenMer.ParamCheck := FALSE;

      strSQL := fSqlInsertEntMer(False,True, blnRecClienteGrantia);
      strSQL := strSQL + fSqlItensGarantia(strCodEmp, blnRecClienteGrantia, strNumEnt, blnRetornoForn, strClaFisEnt, strChaveSEQGAG, strCodFor);

      {*****************************************}
      {* EXECUTA O INSERT NA TABELA TEMPORARIA *}
      {**************************************MV*}

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaItensGarantia]');
    End;
  End;

  Screen.Cursor := crDefault;

  FreeAndNil(qryGenMer);
end;

Function fSQLItensNotaEletronica(strAutEle, strCodEmp: String;
                                 finalidadeXML : tpeFinalidadeXML;
                                 blnUsoConsumo: Boolean = False;
                                 blnDescIncond: Boolean = False;
                                 strClaFisConsumoTributado: String = '';
                                 strClaFisConsumoSubstituido: String = '';
                                 blnEntradaAutomatizada: Boolean = False): String;
  Var
    strValCom,
    strOutras,
    strSQL: String;
    intTabPrc: Integer;
    blnAtuICS: Boolean;
Begin
  blnAtuICS := fCfgSis('ATUICS', varBoolean);

  strSQL := '';
  strSQL := strSQL + 'SELECT          ';
  strSQL := strSQL + '  ""  AS ENT_NUMPED, '; // PCD_NUMPED
  strSQL := strSQL + '  ""  AS ENT_CODEMP, '; // PCD_CODEMP
  strSQL := strSQL + ' IF(IFNULL(I02_NITEM, "") = "", @N_ITEM := @N_ITEM + 1, I02_NITEM - 1) AS ENT_N_ITEM, ';
  strSQL := strSQL + ' IF(IFNULL(I02_NITEM, "") = "", @N_ITEM_TELA := @N_ITEM_TELA + 1, I02_NITEM) AS ENT_N_ITEM_TELA, ';
  strSQL := strSQL + '  ""  AS ENT_NATOPE, ';
  strSQL := strSQL + '  D.AUTOINCREM AS ENT_SEQPCD, ';

  If (finalidadeXML in [xmlEntradaMercadoria,
                        xmlGarantiaRetFornecedor,
                        xmlRetornoSimbolico,
                        xmlDevolucaoEntradaEmitidaFornecedor,
                        xmlCFG_IMPXGRGarantiaRetFornecedor]) Then
  Begin

    strSQL := strSQL + '     CASE ';
    strSQL := strSQL + '       WHEN FOR_SIMPAU = "S" THEN IF(IFNULL(GER_MATREV, FOR_MATREV) = "I",  A.ABF_IVA_ST_ENT_PSI, A.ABF_IVA_ST_ENT_PES) ';
    strSQL := strSQL + '       WHEN IFNULL(FOR_I_E_S_, "") ="" OR FOR_CGCCPF <> 1 THEN A.ABF_IVA_ST_ENT_PEF ';
    strSQL := strSQL + '       WHEN IFNULL(GER_MATREV, FOR_MATREV) = "I" THEN A.ABF_IVA_ST_ENT_PEJ ';
    strSQL := strSQL + '       WHEN IFNULL(GER_MATREV, FOR_MATREV) = "Y" THEN A.ABF_IVA_ST_ENT_PII ';
    strSQL := strSQL + '       ELSE A.ABF_IVA_ST_ENT_PER ';
    strSQL := strSQL + '     END AS ENT_IVA_ST, ';
  End
  Else
    strSQL := strSQL + '  0.0000 AS ENT_IVA_ST, ';

  strSQL := strSQL + '  CAL_VLICMS, ';
  strSQL := strSQL + '  DET_CALSTU, ';
  strSQL := strSQL + '  CAL_BASICM, ';
  strSQL := strSQL + '  CAL_ALQICM, ';
  strSQL := strSQL + '  CAL_BAS_ST, ';
  strSQL := strSQL + '  CAL_VR_IVA, ';
  strSQL := strSQL + '  CAL_VR_SUB, ';
  strSQL := strSQL + '  CAL_ALQINT, ';
  strSQL := strSQL + '  CAL_VFCPST, ';

  strSQL := strSQL + '  D.AUTOINCREM AS ENT_AUTELE, '; // ENT_AUTELE

  strSQL := strSQL + '  IF((SELECT COUNT(*) FROM DEFBAI WHERE DEF_AUTELE = D.AUTOINCREM) > 0, D.AUTOINCREM, "") AS ENT_DETELE, ';
  strSQL := strSQL + '  D.AUTOINCREM AS ENT_DETEL2, ';

  strSQL := strSQL + '  N26_VBCSTRET     AS ENT_BSTANT, '; //  ENT_BSTANT
  strSQL := strSQL + '  N27_VICMSSTRET   AS ENT_VSTANT, '; //  ENT_VSTANT
  strSQL := strSQL + '  N34_PREDBCEEFET  AS ENT_PICMEF, '; //  ENT_PICMEF
  strSQL := strSQL + '  N35_VBCEFET      AS ENT_BICMEF, '; //  ENT_BICMEF
  strSQL := strSQL + '  N36_PICMSEFET    AS ENT_AICMEF, '; //  ENT_AICMEF
  strSQL := strSQL + '  N37_VICMSEFET    AS ENT_VICMEF, '; //  ENT_VICMEF
  strSQL := strSQL + '  CAST("N" AS CHAR(1)) AS ENT_ITETRI, '; //ENT_ITETRI
  strSQL := strSQL + '  N22_PICMSST AS ENT_ALQSTI, ';

  strSQL := strSQL + '  E.GER_CODFOR AS ENT_CODFOR, ';
  strSQL := strSQL + '  I.ITE_DIFICM, ';

  If blnUsoConsumo Then
  Begin
    strValCom := ' (I11_VPROD + O14_VIPI + I15_VFRETE  + IFNULL(I17A_VOUTRO, 0) + IFNULL(I16_VSEG, 0) + N23_VICMSST ';

    If Not blnDescIncond Then
      strValCom := strValCom + ' - ' + fSQLDescontoXML;

    strValCom := strValCom + ') ';

    strOutras := ' (' + strValCom + ' - (N15_VBC + O14_VIPI + N23_VICMSST)) ';

    If (Not (fCfgSis('FLUPDC', varBoolean))) Then
    Begin
      strSQL := strSQL + '  MCO_CODFAB AS ENT_CODFAB, ';
    
      strSQL := strSQL + '  MCO_CODBAR AS ENT_CODBAR, ';
      strSQL := strSQL + '  MCO_CODCTA AS ENT_CODCTA, ';
      strSQL := strSQL + '  CT1.CTA_DESCTA AS ENT_DESCTA, ';

      strSQL := strSQL + '  MCO_CODCT2 AS ENT_CODCT2, ';
      strSQL := strSQL + '  CT2.CTA_DESCTA AS ENT_DESCT2, ';

      strSQL := strSQL + '  MCO_CODCTA AS ENT_CODCTU, ';
      strSQL := strSQL + '  CT1.CTA_DESCTA AS ENT_DESCTU, ';

      strSQL := strSQL + '  MCO_CODMCO AS ENT_CODMCO, ';
    End
    Else
    Begin
      strSQL := strSQL + '  CAST(NULL AS CHAR(25)) AS ENT_CODFAB, ';

      strSQL := strSQL + '  CAST(NULL AS CHAR(20)) AS ENT_CODBAR, ';
      strSQL := strSQL + '  CAST(NULL AS CHAR(7)) AS ENT_CODCTA, ';
      strSQL := strSQL + '  CAST(NULL AS CHAR(60)) AS ENT_DESCTA, ';
      
      strSQL := strSQL + '  CAST(NULL AS CHAR(7)) AS ENT_CODCT2, ';
      strSQL := strSQL + '  CAST(NULL AS CHAR(60)) AS ENT_DESCT2, ';
          
      strSQL := strSQL + '  CAST(NULL AS CHAR(7)) AS ENT_CODCTU, ';
      strSQL := strSQL + '  CAST(NULL AS CHAR(60)) AS ENT_DESCTU, ';

      strSQL := strSQL + '  CAST(NULL AS CHAR(5)) AS ENT_CODMCO, ';
    End;    

    strSQL := strSQL + '  CONCAT(LEFT(DET_CSTXML, 1), "90") AS ENT_CODFIS, ';

    strSQL := strSQL +    strValCom + ' AS ENT_VLRCON, ';

    strSQL := strSQL + ' IF(' + strOutras + ' < 0, 0, ' + strOutras + ') AS ENT_OUTRAS, ';

    If fCfgSis('EACCFO', varBoolean) Then
    begin

      strSQL := strSQL + 'IF(FOR_SIMPAU = "S" AND IFNULL(I08_CFOP, "") <> "" AND LOCATE(RIGHT(I08_CFOP, 3), "101_102_405_401_403_404_653"),';
      strSQL := strSQL + 'CASE';
      strSQL := strSQL + '   WHEN RIGHT(I08_CFOP, 3) = "101" AND (LOCATE(RIGHT(DET_CSTXML, 2), "00_20")) THEN CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "6"), CONCLA.SIS_VALCFG)';
      strSQL := strSQL + '   WHEN RIGHT(I08_CFOP, 3) = "101" AND (NOT LOCATE(RIGHT(DET_CSTXML, 2), "00_20")) THEN CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "6"), CONSUB.SIS_VALCFG)';
      strSQL := strSQL + '   WHEN RIGHT(I08_CFOP, 3) = "102"  THEN CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "6"), CONCLA.SIS_VALCFG)';
      strSQL := strSQL + '   WHEN RIGHT(I08_CFOP, 3) = "405"  THEN CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "6"), CONSUB.SIS_VALCFG)';
      strSQL := strSQL + '   WHEN RIGHT(I08_CFOP, 3) = "401"  THEN CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "6"), CONSUB.SIS_VALCFG)';
      strSQL := strSQL + '   WHEN RIGHT(I08_CFOP, 3) = "403"  THEN CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "6"), CONSUB.SIS_VALCFG)';
      strSQL := strSQL + '   WHEN RIGHT(I08_CFOP, 3) = "404"  THEN CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "6"), CONSUB.SIS_VALCFG)';
      strSQL := strSQL + '   WHEN RIGHT(I08_CFOP, 3) = "653"  THEN CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "6"), COMLUB.SIS_VALCFG)';
      strSQL := strSQL + 'END,';
    End;


    strSQL := strSQL + ' IF (IFNULL(LA02_CPRODANP, "") = "", ( '; //MF: 325649
    strSQL := strSQL + '   IF(LOCATE(DET_CSTXML, "' + CST_SUBSTITUICAO + '"), "' + strClaFisConsumoSubstituido + '", "' + strClaFisConsumoTributado + '") ';
    strSQL := strSQL + ' ), "' + Copy(strClaFisConsumoSubstituido, 1, 1) + fCfgSis('COMLUB') + '"';
    If fCfgSis('EACCFO', varBoolean) Then
      strSQL := strSQL + ')';
    strSQL := strSQL + ')  AS ENT_CLAFIS, '; //MF: 325649

    strSQL := strSQL + ' "NF" AS ENT_ESPDOC, ';

    strSQL := strSQL + ' 0.00 AS ENT_PREMED, ';
    strSQL := strSQL + ' 0.00 AS ENT_PREULT, ';
    strSQL := strSQL + ' 0.00 AS ENT_IMPULT, ';
    strSQL := strSQL + ' CAST("" AS CHAR(50)) AS ENT_SEQDET, ';

    strSQL := strSQL + ' 0.00 AS ENT_OUTDES, ';
    strSQL := strSQL + ' 0.00 AS ENT_VALANT, ';
    strSQL := strSQL + ' 0.00 AS ENT_BASANT, ';
    strSQL := strSQL + ' 0.00 AS ENT_VALGNR, ';
    strSQL := strSQL + ' CAST("" AS CHAR(5000)) AS ENT_CALGNR, ';
    strSQL := strSQL + ' "P" AS ENT_GNRORI, ';
    strSQL := strSQL + ' 0.00 AS ENT_VENDOR, ';
    strSQL := strSQL + ' 0.00 AS ENT_FRECON, ';
    strSQL := strSQL + ' 0.00 AS ENT_VAFRAN, ';
    strSQL := strSQL + ' 0.00 AS ENT_BAFRAN, ';
    strSQL := strSQL + ' 0.00 AS ENT_ISENTO, ';
    strSQL := strSQL + ' CAST("" AS CHAR(03)) AS ENT_CODMOT, ';
    strSQL := strSQL + ' "N" AS ENT_ANTPRO, ';    // TEM ANTECIPACAO DE ICMS SOBRE O ITEM
    strSQL := strSQL + ' "S" AS ENT_ANTFRE, ';    // RATEIA ICMS ANTECIPADO DO FRETE
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS ENT_COMGNR, ';                // RATEIA A GNRE

    strSQL := strSQL + ' ITE_CODMAR AS ENT_CODMAR, ';
    strSQL := strSQL + ' I.ITE_CODFOR AS ENT_FORITE, ';
    strSQL := strSQL + ' G.ITE_SALDOS AS ENT_SALDOS,  ';

    strSQL := strSQL + '  O13_PIPI AS ENT_ALQIPI,  ';  // PERCENTUAL DE IPI
    strSQL := strSQL + '  O13_PIPI AS ENT_ALEIPI,  ';

    strSQL := strSQL + ' N20_PREBCST AS ENT_PEBAST, ';
    strSQL := strSQL + ' N14_PREDBC  AS ENT_PERBAS, ';

    strSQL := strSQL + ' CAST("" AS CHAR(08)) AS ENT_CODDIV, ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS ENT_TABPRE, ';
    strSQL := strSQL + ' CAST("" AS CHAR(03)) AS ENT_EMP_PD, ';

    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS ENT_AUTVEN, ';
    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS ENT_INCFUT, ';
    strSQL := strSQL + ' CAST("" AS CHAR(6)) AS ENT_TABELA, ';
    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS AUTOINCREMENTO_GRAVACAO, ';

    strSQL := strSQL + '  0 AS ENT_VLTCIF, ';
    strSQL := strSQL + '  0 AS ENT_ALQTCI, ';
    strSQL := strSQL + '  0 AS ENT_CLTCIF, ';
    strSQL := strSQL + '  0 AS ENT_VAL_TS, ';
    strSQL := strSQL + '  0 AS ENT_ALQ_TS, ';
  End Else
  Begin
    strSQL := strSQL + '  I.ITE_CODFAB AS ENT_CODFAB, ';
  End;

  strSQL := strSQL + '  I.ITE_CODITE AS ENT_CODITE, ';

  strSQL := strSQL + '      G.ITE_TIPPRO AS ENT_TIPPRO, ';
  strSQL := strSQL + '      0 AS ENT_DESPIS, ';

  strSQL := strSQL + '  G.ITE_PREDOL AS ENT_PREDOL, ';
  strSQL := strSQL + '  I.ITE_CODGRU AS ENT_CODGRU, ';
    If fCfgSIs('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR AS ENT_IMPDIR, '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR AS ENT_IMPDIR, ';

  If (finalidadeXML in [xmlEntradaMercadoria,
                        xmlGarantiaRetFornecedor,
                        xmlEntradaMercadoriasSistemaAnteriorDevolucao,
                        xmlDevolucaoEntradaEmitidaFornecedor,
                        xmlCFG_IMPXGRGarantiaRetFornecedor]) And (Not blnUsoConsumo) Then
  Begin
    (********************************************************)
    (* CONVERTENDO PARA VARCHAR POIS NA TELMAC É UM MEMO    *)
    (*****************************************************LA*)
    strSQL := strSQL + '  IF((IFNULL(GER_MATREV, FOR_MATREV) = "M") OR (LOCATE("ITEM ESPECIAL", I.ITE_DESITE)>0), D.I04_XPROD, I.ITE_DESITE) AS ENT_DESITE, ';
    (********************************************************************)
    (* BUSCA A DESCRICAO DO CADITE TB PARA VERIFICAR SE É ITEM ESPECIAL *)
    (*****************************************************************LU*)
    strSQL := strSQL + '  IF((IFNULL(GER_MATREV, FOR_MATREV) = "M") OR (LOCATE("ITEM ESPECIAL", I.ITE_DESITE)>0), D.I04_XPROD, I.ITE_DESITE) AS ENT_DESIT1, ';
  End Else Begin
    strSQL := strSQL + '  D.I04_XPROD AS ENT_DESITE, ';
    strSQL := strSQL + '  D.I04_XPROD AS ENT_DESIT1, ';
  End;

  strSQL := strSQL + '  I.ITE_REFERE AS ENT_REFERE,  ';
  strSQL := strSQL + '  I.ITE_CODUNI AS ENT_CODUNI,  ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS ENT_SIGUNI,  ';

  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF AS ENT_CODABF,  '
  Else
    strSQL := strSQL + '  G.ITE_CODABF AS ENT_CODABF,  ';

  strSQL := strSQL + '  A.ABF_DESABF AS ENT_DESABF,  ';
  strSQL := strSQL + '  I10_QCOM AS ENT_QTDITE,      '; // QUANTIDADE DO ITEM NA NOTA
  strSQL := strSQL + '  (I11_VPROD) / I10_QCOM AS ENT_UNITAR,  '; // VALOR UNITARIO

  If blnUsoConsumo and blnEntradaAutomatizada Then
  begin
    strSQL := strSQL + '  0 AS ENT_PERIPI,  ';              // PERCENTUAL DE IPI
    strSQL := strSQL + '  0 AS ENT_VALIPI,  ';              // VALOR DO IPI
  end
  else
  begin
    strSQL := strSQL + '  O13_PIPI AS ENT_PERIPI,  ';              // PERCENTUAL DE IPI
    strSQL := strSQL + '  O14_VIPI AS ENT_VALIPI,  ';              // VALOR DO IPI
  end;

  If (finalidadeXML in [xmlEntradaMercadoria,
                        xmlGarantiaRetFornecedor,
                        xmlRetornoSimbolico,
                        xmlDevolucaoEntradaEmitidaFornecedor,
                        xmlCFG_IMPXGRGarantiaRetFornecedor]) Then
  Begin
    strSQL := strSQL + ' IF(GER_MATREV IS NULL, FOR_MATREV, GER_MATREV) AS ENT_MATREV, ';
    strSQL := strSQL + '  CASE ';
    strSQL := strSQL + '     WHEN FOR_SIMPAU = "S" THEN IF(FOR_PEICMS = "S",  I11_VPROD - I17_VDESC, N15_VBC)';
    strSQL := strSQL + '     ELSE N15_VBC ';
    strSQL := strSQL + '  END  AS ENT_BASICM, '; // Base Cáculo IMCS
    strSQL := strSQL + '  CASE ';
    strSQL := strSQL + '     WHEN FOR_SIMPAU = "S" THEN IF(FOR_PEICMS = "S",  N24_CREDSN, N16_PICMS)';
    strSQL := strSQL + '     ELSE N16_PICMS ';
    strSQL := strSQL + '  END  AS ENT_ALQICM, '; //Percentual do IMCS
    strSQL := strSQL + '  CASE ';
    strSQL := strSQL + '     WHEN FOR_SIMPAU = "S" THEN IF(FOR_PEICMS = "S",  N24_CREDICMSSN, N17_VICMS)';
    strSQL := strSQL + '     ELSE N17_VICMS ';
    strSQL := strSQL + '  END AS ENT_VALICM, '; // Valor do IMCS
    strSQL := strSQL + '  CASE ';
    strSQL := strSQL + '     WHEN FOR_SIMPAU = "S" THEN IF(FOR_PEICMS = "S",  N24_CREDICMSSN, N17_VICMS)';
    strSQL := strSQL + '     ELSE N17_VICMS ';
    strSQL := strSQL + '  END AS ENT_ICMXML, '; // Valor do IMCS

    strSQL := strSQL + '  CASE ';
    strSQL := strSQL + '     WHEN FOR_SIMPAU = "S" THEN IF(FOR_PEICMS = "S",  N24_CREDSN, N16_PICMS)';
    strSQL := strSQL + '     ELSE N16_PICMS ';
    strSQL := strSQL + '  END  AS  ENT_ALIXML, ';
    strSQL := strSQL + '  CASE ';
    strSQL := strSQL + '     WHEN FOR_SIMPAU = "S" THEN IF(FOR_PEICMS = "S",  I11_VPROD - I17_VDESC, N15_VBC)';
    strSQL := strSQL + '     ELSE N15_VBC ';
    strSQL := strSQL + '  END  AS ENT_BAIXML, ';

  end
  else
  begin
    strSQL := strSQL + '  ""         AS ENT_MATREV, ';
    strSQL := strSQL + '  N15_VBC    AS ENT_BASICM, ';  // Base Cáculo IMCS
    strSQL := strSQL + '  N16_PICMS  AS ENT_ALQICM, ';  //Percentual do IMCS
    strSQL := strSQL + '  N17_VICMS  AS ENT_VALICM, ';  // Valor do IMCS
    strSQL := strSQL + '  N17_VICMS  AS ENT_ICMXML, ';  // Valor do IMCS
    strSQL := strSQL + '  N16_PICMS  AS ENT_ALIXML, ';
    strSQL := strSQL + '  N15_VBC    AS ENT_BAIXML, ';
  end;

  strSQL := strSQL + ' N17C_VFCP   AS ENT_FCPXML, ';

  If blnUsoConsumo And blnEntradaAutomatizada Then
    strSQL := strSQL + '  0 AS ENT_BASIPI, '                // Base Cáculo IPI
  else
    strSQL := strSQL + '  O10_VBC AS ENT_BASIPI, ';                // Base Cáculo IPI

  strSQL := strSQL + '  IF(B25B_INDPRES IN(1, 5), "S", "N") AS ENT_VENPRE, ';              // Valor do IMCS

 {Nota Importacao}
  strSQL := strSQL + ' P04_VII AS ENT_VALVII, ';
  strSQL := strSQL + ' I16_VSEGIMP AS ENT_VSEGIMP, ';
  strSQL := strSQL + ' P05_VIOF AS ENT_VALIOF, ';
  strSQL := strSQL + ' DET_VALSIS AS ENT_VALSIS, ';
  strSQL := strSQL + ' I23B_VAFRMM AS ENT_VAFRMM, ';
  strSQL := strSQL + ' P03_VDESPADU AS ENT_DESPAD, ';
  strSQL := strSQL + ' IFNULL(I17A_VOUTRO, 0) AS ENT_VOUTRO, ';

  strSQL := strSQL + ' IF((W07_VPROD + IFNULL(W18_VSERV, 0) + W06_VST + W08_VFRETE + W09_VSEG + W12_VIPI + W15_VOUTRO + IFNULL(W06A_VFCPST, 0) - W10_VDESC) - W16_VNF > 0.5, 1 , 0) AS ENT_USODES, ';
  strSQL := strSQL + '  N27A_VICMSDESON AS ENT_VICMDE, ';
  strSQL := strSQL + '  I17_VDESC AS ENT_DESCON, ';
  strSQL := strSQL + '  N27A_MOTDESICMS AS ENT_MTDICM, ';

  // VARIAVEIS PARA GUARDAR O IPI QUANDO NAO UTILIZA CREDITOS DE IPI
  strSQL := strSQL + '  O14_VIPI AS ENT_VAEIPI,  ';              // VALOR DO IPI
  strSQL := strSQL + '  O10_VBC  AS ENT_BAEIPI, ';                // Base Cáculo IPI

  strSQL := strSQL + '  I11_VPROD AS ENT_TOTITE, ';   // TOTITE

  strSQL := strSQL + '  I11_VPROD - ' + fSQLDescontoXML + ' + O14_VIPI + N23_VICMSST AS ENT_TOTGER, ';   // TOTGER

  strSQL := strSQL + '  G.ITE_PRECOM AS ENT_PRECOM, ';

  strSQL := strSQL + '  G.ITE_DESF01 AS ENT_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02 AS ENT_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03 AS ENT_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04 AS ENT_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05 AS ENT_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06 AS ENT_DESF06, ';

  strSQL := strSQL + '  D.DET_BASSUB AS ENT_GNRTSU, ';
  strSQL := strSQL + '  G.ITE_TCIFCU AS ENT_ALQTCI, ';
  strSQL := strSQL + '  G.ITE_TSCUST AS ENT_ALQ_TS, ';

  strSQL := strSQL + '  G.ITE_TCIFCU AS ENT_TCIFCU, ';
  strSQL := strSQL + '  G.ITE_TSCUST AS ENT_TSCUST, ';
  strSQL := strSQL + '  G.ITE_DEPICO AS ENT_DEPICO, ';

  If fCfgSis('ATUDIC', varBoolean) And fSeparaICMDesoneradoDoDesconto Then
    strSQL := strSQL + '  ROUND(N27A_VICMSDESON / I11_VPROD * 100, 2) AS ENT_DEICMS, '
  Else
    strSQL := strSQL + '  G.ITE_DEICMS AS ENT_DEICMS, ';

  strSQL := strSQL + '  G.ITE_FATREG AS ENT_FATREG, ';


  strSQL := strSQL + '  G.ITE_ICMENT AS ENT_ICMENT, ';
  strSQL := strSQL + '  G.ITE_SUBFED AS ENT_SUBFED, ';

  If Not fCfgSis('ATUIPI', varBoolean) Then
    strSQL := strSQL + '  G.ITE_IPIENT AS ENT_IPIENT, '
  Else
  Begin
    strSQL := strSQL + '  O13_PIPI AS ENT_IPIENT, '
  End;

  strSQL := strSQL + '  G.ITE_FREENT AS ENT_FREENT, ';
  strSQL := strSQL + '  G.ITE_VALFRE AS ENT_FREITE, ';
  strSQL := strSQL + '  G.ITE_ACRFIN AS ENT_ACRFIN, ';

  If Not fCfgSis('ATUSUB', varBoolean) Then
    strSQL := strSQL + '  G.ITE_SUBSTI AS ENT_SUBSTI, '
  Else
  Begin
    If fCfgSis('FRMCUS',varString ) = '1' Then
      strSQL := strSQL + '  ROUND((N23_VICMSST / (I11_VPROD - ' + fSQLDescontoXML + ' + O14_VIPI)) * 100, 2) AS ENT_SUBSTI, '
    Else
      strSQL := strSQL + '  ROUND((N23_VICMSST / (I11_VPROD - ' + fSQLDescontoXML + ')) * 100, 2) AS ENT_SUBSTI, '
  End;

  strSQL := strSQL + '  G.ITE_OUTVAL AS ENT_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED AS ENT_IMPFED, ';
  strSQL := strSQL + '  G.ITE_DESOPE AS ENT_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PRECUS AS ENT_PRECUS, ';

  If blnAtuICS Then
  Begin
    strSQL := strSQL + '  IF((LOCATE(B.ABF_CODSIT_SAI_CNC, "'+CST_TRIBUTADO+'") > 0 ), ';
    strSQL := strSQL + '      ROUND(B.ABF_ALQICM_SAI_CNC * (B.ABF_BASICM_SAI_CNC / 100), 2), ';
    strSQL := strSQL + '      0) AS ITE_ICMSAI, ';
  End
  Else
    strSQL := strSQL + '  G.ITE_ICMSAI AS ENT_ICMSAI, ';

  strSQL := strSQL + '  G.ITE_DESMAX AS ENT_DESMAX, ';
  strSQL := strSQL + '  G.ITE_DESMGE AS ENT_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU AS ENT_DESMSU, ';

  For intTabPrc := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  G.ITE_MARBR' + IntToStr(intTabPrc) + ' AS ENT_MARBR' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  G.ITE_PREVE' + IntToStr(intTabPrc) + ' AS ENT_PREVE' + IntToStr(intTabPrc) + ', ';
    strSQL := strSQL + '  G.ITE_COMTB' + IntToStr(intTabPrc) + ' AS ENT_COMTB' + IntToStr(intTabPrc) + ', ';

    strSQL := strSQL + '  " " AS ENT_PREEM' + IntToStr(intTabPrc) + ', ';
  End;

  strSQL := strSQL + '  G.ITE_MARMIN AS ENT_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG AS ENT_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE AS ENT_MARMGE, ';

  strSQL := strSQL + '  G.ITE_DESMVM AS ENT_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM AS ENT_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM AS ENT_DESMGM, ';

  strSQL := strSQL + '  G.ITE_MARMMV AS ENT_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS AS ENT_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG AS ENT_MARMMG, ';

  If (finalidadeXML in [xmlEntradaMercadoria,
                        xmlGarantiaRetFornecedor,
                        xmlEntradaMercadoriasSistemaAnteriorDevolucao,
                        xmlDevolucaoEntradaEmitidaFornecedor,
                        xmlCFG_IMPXGRGarantiaRetFornecedor]) Then
    strSQL := strSQL + '  I.ITE_CLAIPI AS ENT_CLAIPI, '
  Else
    strSQL := strSQL + '  D.I05_NCM AS ENT_CLAIPI, ';

  strSQL := strSQL + '  I.ITE_CDCEST AS ENT_CDCEST, ';

  {********************************************************************}
  {* FOI INCLUIDA A DATA DE BALANÇO POIS É NECESSÁRIO VERIFICAR       *}
  {* ESSA DATA NA CONFIRMAÇÃO DE ITENS PARA A ENTRADA DE MERCADORIAS  *}
  {*****************************************************************LA*}
  strSQL := strSQL + '  G.ITE_DTABAL AS ENT_DTABAL, ';

  strSQL := strSQL + '  @INC_ENTMER:=@INC_ENTMER+1 AS ENT_NUMSEL, ';

  strSQL := strSQL + '  "M" AS ENT_MARDES, '; //marcado...

    strSQL := strSQL + '  N22_PICMSST AS ENT_PERSUB, ';  // PERCENTUAL ISCMS SUB
    strSQL := strSQL + '  N23_VICMSST AS ENT_TOTSUB, ';  // VALOR DO ISCMS SUB

  If fCfgSis('CLASUB') = '1' Then
  Begin
    strSQL := strSQL + '  0 AS ENT_BASRET, ';             // BASE DO ISCMS SUB
    strSQL := strSQL + '  0 AS ENT_VALRET, ';             // VALOR DO ISCMS SUB
    strSQL := strSQL + '  N21_VBCST AS ENT_BAERET, ';    // BASE DO ISCMS SUB NAO CREDITADO
    strSQL := strSQL + '  N23_VICMSST AS ENT_VAERET, ';  // VALOR DO ISCMS SUB NAO CREDITADO
  End
  Else
  Begin
    strSQL := strSQL + '  N21_VBCST AS ENT_BASRET, ';    // BASE DO ISCMS SUB
    strSQL := strSQL + '  N23_VICMSST AS ENT_VALRET, ';  // VALOR DO ISCMS SUB
    strSQL := strSQL + '  0 AS ENT_BAERET, ';            // BASE DO ISCMS SUB NAO CREDITADO
    strSQL := strSQL + '  0 AS ENT_VAERET,';            // VALOR DO ISCMS SUB NAO CREDITADO
  End;

  strSQL := strSQL + '  I08_CFOP AS ENT_I08CFO, ';
  
  strSQL := strSQL + '  I15_VFRETE AS ENT_VALFRE, ';     // ENT_VALFRE
  strSQL := strSQL + '  IF(LEFT(I08_CFOP, 1) = "3", 0,IFNULL(I17A_VOUTRO, 0)) + IFNULL(I16_VSEG, 0) AS ENT_DESACE, ';    // ENT_DESACE

  strSQL := strSQL + '  DET_CSTXML AS ENT_SITXML, ';
  strSQL := strSQL + '  GER_CSTCAD AS ENT_CSTCAD, ';

  strSQL := strSQL + fSQLDescontoXML + ' AS ENT_DESESP, ';
  strSQL := strSQL + fSQLDescontoXMLSemDesonerado + ' AS ENT_DESXML, ';
  strSQL := strSQL + '  IFNULL(N12_CST, "") AS ENT_N12CST, ';

  strSQL := strSQL + ' N23D_FCPST AS ENT_VFCPST, ';
  strSQL := strSQL + ' N23A_VBCFCPST AS ENT_BFCPST, ';
  strSQL := strSQL + ' N23B_PFCPST AS ENT_PFCPST, ';

  if blnUsoConsumo And blnEntradaAutomatizada then
  begin
    strSQL := strSQL + ' 0 AS ENT_VBCFCP, ';
    strSQL := strSQL + ' 0 AS ENT_PERFCP, ';
    strSQL := strSQL + ' 0 AS ENT_VALFCP, ';
  end
  else
  begin
    strSQL := strSQL + ' N17A_VBCFCP AS ENT_VBCFCP, ';
    strSQL := strSQL + ' N17B_PFCP   AS ENT_PERFCP, ';
    strSQL := strSQL + ' N17C_VFCP   AS ENT_VALFCP, ';
  end;

  strSQL := strSQL + ' DET_VLRGNR  AS ENT_VALGNR, ';
  strSQL := strSQL + ' DET_CALGNR  AS ENT_CALGNR, ';
  strSQL := strSQL + ' CAST("P" AS CHAR(1))  AS ENT_GNRORI, ';
  strSQL := strSQL + ' GER_PREGNR  AS ENT_PREGNR, ';
  If fCfgSis('ENTPIS', varBoolean) Then
    strSQL := strSQL + '  I.ITE_INCPIS AS ENT_INCPIS, '
  Else
    strSQL := strSQL + '  "N" AS ENT_INCPIS, ';

  strSQL := strSQL + '  ""  AS ENT_CODACA,  ';  // PCD_CODACA
  strSQL := strSQL + '  ""  AS ENT_EMPACA,  ';  // PCD_EMPACA
  strSQL := strSQL + '  "N" AS ENT_PROACA, ';
  strSQL := strSQL + '  0   AS ENT_SALACA,   ';  // ACA_SALDOS
  strSQL := strSQL + '  0   AS ENT_PREACA,   ';  // ACA_PRECUS
  strSQL := strSQL + '  I04_XPROD AS ENT_DESACA,  ';  // ACA_DESCRI

  strSQL := strSQL + '  Q06_CST   AS ENT_CSTPIS,  ';     // CST PIS
  strSQL := strSQL + '  Q08_PPIS  AS ENT_PERPIS, ';    // PERCENTUAL DE PIS
  strSQL := strSQL + '  Q07_VBC   AS ENT_BASPIS,  ';    // BASE DE PIS
  strSQL := strSQL + '  Q09_VPIS  AS ENT_VALPIS, ';    // VALOR DE PIS

  strSQL := strSQL + '  S06_CST      AS ENT_CSTCOF, ';    // CST COFINS
  strSQL := strSQL + '  S08_PCOFINS  AS ENT_PERCOF, '; // PERCENTUAL DE COFINS
  strSQL := strSQL + '  S07_VBC      AS ENT_BASCOF, '; // BASE DE COFINS
  strSQL := strSQL + '  S11_VCOFINS  AS ENT_VALCOF, '; // VALOR DE COFINS
  strSQL := strSQL + '  ""           AS ENT_ITE_F5, ';  // ENT_ITE_F5

  strSQL := strSQL + '  I.ITE_RPRENT AS ENT_RPRENT, ';

  if (finalidadeXML = xmlGarantiaRecCliente) Then
    strSQL := strSQL + ' (SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP AND LOT_GARPRI = "S") AS ENT_NUMLOT,' // NUMERO DO LOTE
  Else If fCfgSis('MARMOR', varBoolean) Then
    strSQL := strSQL + '  IF(I.ITE_GRAMAR = "S", "A DEFINIR", "") AS ENT_NUMLOT,           ' // NUMERO DO LOTE
  Else
    strSQL := strSQL + '  "" AS ENT_NUMLOT,           '; // NUMERO DO LOTE

  strSQL := strSQL + '  "" AS ENT_IDEPRO,           ';
  strSQL := strSQL + '  "" AS ENT_ITETIN,           ';
  strSQL := strSQL + '  I.ITE_GRAMAR, ';



  If (fCfgSis('CNVEMB') <> 'N') Then
  Begin
    strSQL := strSQL + '  IF(GER_UNICOM = "N", 1, ';

    strSQL := strSQL + '  IF(D.DET_EMBALA IS NULL OR D.DET_EMBALA = 0, ' + fSQLEmbala('I', 'IT', 'GER_CODFOR', True) + ', D.DET_EMBALA) ';

    strSQL := strSQL + '  ) AS ENT_EMBALA, '; // ENT_EMBALA

    strSQL := strSQL + '  IF(GER_UNICOM = "N", 1, ';

    strSQL := strSQL + '  IF(D.DET_EMBALA IS NULL OR D.DET_EMBALA = 0, ' + fSQLEmbala('I', 'IT', 'GER_CODFOR', True) + ', D.DET_EMBALA) ';

    strSQL := strSQL + '  ) AS ENT_EMBPED, '; // ENT_EMBPED

    If fCfgSis('TABPRF', varBoolean) Then
      strSQL := strSQL + '  IF(IT.ITE_CODITE IS NULL, I.ITE_UNICOM, IT.ITE_UNICOM) AS ENT_UNIEMB, '
    Else
      strSQL := strSQL + '  I.ITE_UNICOM AS ENT_UNIEMB,            ';
  End

  Else

  Begin
    strSQL := strSQL + '  1 AS ENT_EMBALA,                                                                        ';  // ENT_EMBALA
    strSQL := strSQL + '  1 AS ENT_EMBPED,                                                                        ';  // ENT_EMBPED
    strSQL := strSQL + '  I.ITE_UNICOM AS ENT_UNIEMB,            ';
  End;

  If blnUsoConsumo Then
    strSQL := strSQL + '  0.0000 AS ENT_ICMCFR,                                                                        ';  // ENT_ICMCFR

  strSQL := strSQL + '  "N" AS  ENT_PROEMB,            ';
  strSQL := strSQL + '  "N" AS  ENT_RICMPR,            ';
  strSQL := strSQL + '   IF((SELECT COUNT(1) FROM CADLOT ';
  strSQL := strSQL + '    WHERE LOT_CODITE = G.ITE_CODITE';
  strSQL := strSQL + '      AND LOT_CODEMP = G.ITE_CODEMP) = 0 , "N", "S"), ';
  strSQL := strSQL + ' G.ITE_SALDOS, ';
  strSQL := strSQL + ' I.ITE_CNV_ML, ';
  strSQL := strSQL + ' CONCAT(IFNULL(I.ITE_CODMAR,""),"-",MAR_DESMAR) AS MAR_DESMAR, ';

  strSQL := strSQL + ' (@CHAVE_TMP := @CHAVE_TMP + 1) AS AUTOINCREMENTO_GRAVACAO, ';
  strSQL := strSQL + ' E.B25B_INDPRES AS ENT_INDPRES, ';
  strSQL := strSQL + ' E.GER_IDDEST AS ENT_IDDEST, ';

  strSQL := strSQL + ' D.DET_QTDREF AS ENT_QTDREF ';

  If (blnEntradaAutomatizada) Then
    strSQL := strSQL + ', "" AS ENT_ITETIN ';
  If fCfgSis('CRDMNF', varString) = 'S' Then
  Begin
    strSQL := strSQL + ' ,D.N28_QICMSMONORET AS ENT_QBCMON ';
    strSQL := strSQL + ' ,D.N28_ADBCMONORET AS ENT_ADREMN ';
    strSQL := strSQL + ' ,D.N28_VREMICMSRET AS ENT_VALMON ';
  End
  Else
  Begin
    strSQL := strSQL + ' ,0.0 AS ENT_QBCMON ';
    strSQL := strSQL + ' ,0.0 AS ENT_ADREMN ';
    strSQL := strSQL + ' ,0.0 AS ENT_VALMON ';
  End;

  // Reforma Tributaria - valores DETERT por item (LEFT JOIN abaixo)
  strSQL := strSQL + ' ,IFNULL(DRT.UB13_CST,            "")  AS ENT_REFCST ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB14_CCLASSTRIB,     "")  AS ENT_REFCLA ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB16_VBC,            0)   AS ENT_REFVBC ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB56_PCBS,           0)   AS ENT_RFCALQ ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB60_PDIF,           0)   AS ENT_RFCALD ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB61_VDIF,           0)   AS ENT_RFCVLD ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB65_PREDALIQ,       0)   AS ENT_RFCALR ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB63_VDEVTRIB,       0)   AS ENT_RFCVLT ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB66_PALIQEFET,      0)   AS ENT_RFCALE ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB67_VCBS,           0)   AS ENT_RFCVAL ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB18_PIBSUF,         0)   AS ENT_RFIUFA ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB22_PDIF,           0)   AS ENT_RFIUFD ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB23_VDIF,           0)   AS ENT_RFIUVD ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB27_PREDALIQ,       0)   AS ENT_RFIUFR ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB25_VDEVTRIB,       0)   AS ENT_RFIUFT ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB28_PALIQEFET,      0)   AS ENT_RFIUFE ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB35_VIBSUF,         0)   AS ENT_RFIUFV ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB37_PIBSMUN,        0)   AS ENT_RFIMNA ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB41_PDIF,           0)   AS ENT_RFIMND ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB42_VDIF,           0)   AS ENT_RFIMVD ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB46_PREDALIQ,       0)   AS ENT_RFIMNR ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB44_VDEVTRIB,       0)   AS ENT_RFIMNT ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB47_PALIQEFET,      0)   AS ENT_RFIMNE ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB54_VIBSMUN,        0)   AS ENT_RFIMNV ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB02_CSTIS,          "")  AS ENT_RFSCST ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB03_CCLASSTRIBIS,   "")  AS ENT_RFSCLA ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB05_VBCIS,          0)   AS ENT_RFSBAS ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB06_PIS,            0)   AS ENT_RFSALQ ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB11_VIS,            0)   AS ENT_RFSVLR ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB69_CSTREG,         "")  AS ENT_RFRCST ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB70_CCLASSTRIBREG,  "")  AS ENT_RFRCLA ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB71_PALIQEFETREGIBS,0)   AS ENT_RFRUFA ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB72_VTRIBREGIBSUF,  0)   AS ENT_RFRUVT ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB72A_PALIQEFETREGIB,0)   AS ENT_RFRUMA ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB72B_VTRIBREGIBSMUN,0)   AS ENT_RFRUMT ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB72C_PALIQEFETREGCB,0)   AS ENT_RFRUCA ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB72D_VTRIBREGCBS,   0)   AS ENT_RFRUCB ';
  strSQL := strSQL + ' ,IFNULL(DRT.UB55_VIBS, IFNULL(DRT.UB35_VIBSUF,0) + IFNULL(DRT.UB54_VIBSMUN,0)) AS ENT_RFIVAL ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DETELE D ';
  strSQL := strSQL + '  INNER JOIN GERELE E ON E.AUTOINCREM = D.DET_SEQGER ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON DET_CODITE   = I.ITE_CODITE ';

  strSQL := strSQL + '  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '                         G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  strSQL := strSQL + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';

  If (finalidadeXML in [xmlEntradaMercadoria,
                        xmlGarantiaRetFornecedor,
                        xmlEntradaMercadoriasSistemaAnteriorDevolucao,
                        xmlRetornoSimbolico,
                        xmlDevolucaoEntradaEmitidaFornecedor,
                        xmlCFG_IMPXGRGarantiaRetFornecedor]) Then
  Begin
    strSQL := strSQL + '  INNER JOIN CADFOR F ON E.GER_CODFOR = F.FOR_CODFOR ';
    strSQL := strSQL + '  INNER JOIN CADCID C ON F.FOR_CODCID = C.CID_CODCID ';
  End Else Begin
    strSQL := strSQL + '  INNER JOIN CADCLI F ON E.GER_CODCLI = F.CLI_CODCLI ';
    strSQL := strSQL + '  INNER JOIN CADCID C ON F.CLI_CODCID = C.CID_CODCID ';
  End;

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  INNER JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF AND '
  Else
    strSQL := strSQL + '  INNER JOIN ABFICM A ON A.ABF_CODABF = G.ITE_CODABF AND ';

  strSQL := strSQL + '                         A.ABF_ESTADO = C.CID_ESTADO ';

  If blnAtuICS Then
  Begin

    If fCfgSis('TIPABF') = '1' Then
      strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = I.ITE_CODABF AND '
    Else
      strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = G.ITE_CODABF AND ';

    strSQL := strSQL + '                         B.ABF_ESTADO = ' + QuotedStr(fCadEmpDes('ESTADO', VS_strCodEmp));

  End;

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN ITEFOR IT ON IT.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '                         IT.ITE_CODFOR =   GER_CODFOR AND ';
    strSQL := strSQL + '                        (SELECT COUNT(*) FROM TABPRE      ';
    strSQL := strSQL + '                         WHERE IT.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End;

  If (blnUsoConsumo) And (Not (fCfgSis('FLUPDC', varBoolean))) Then
  Begin
    strSQL := strSQL + '  INNER JOIN CADMCO ON MCO_CODMCO = DET_CODMCO ';
    strSQL := strSQL + '  LEFT JOIN CADCTA CT1 ON CT1.CTA_CODCTA = MCO_CODCTA ';
    strSQL := strSQL + '  LEFT JOIN CADCTA CT2 ON CT2.CTA_CODCTA = MCO_CODCT2 ';
  End;

  strSQL := strSQL + '  LEFT JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN DETERT DRT ON DRT.AUTOINCREM = D.AUTOINCREM ';


  If fCfgSis('EACCFO', varBoolean) Then
  begin
   strSQL := strSQL + '    INNER JOIN CFGSIS CONCLA ON CONCLA.SIS_CODCFG = "CFG_CONCLA" AND CONCLA.SIS_CODEMP = G.ITE_CODEMP ';
   strSQL := strSQL + '    INNER JOIN CFGSIS CONSUB ON CONSUB.SIS_CODCFG = "CFG_CONSUB" AND CONSUB.SIS_CODEMP = G.ITE_CODEMP ';
   strSQL := strSQL + '    INNER JOIN CFGSIS COMLUB ON COMLUB.SIS_CODCFG = "CFG_COMLUB" AND COMLUB.SIS_CODEMP = G.ITE_CODEMP ';
  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   D.DET_SEQGER = ' + QuotedStr(strAutEle);
  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   D.AUTOINCREM ';

  Result := strSQL;
End;

{*****************************************}
{* GERA UMA TABELA TEMPORARIA COM TODOS  *}
{* OS ITENS DA NOTA FISCAL ELETRONICA    *}
{**************************************LA*}
function fCarregaItensNotaEletronica(strAutEle, strCodEmp: String; finalidadeXML : tpeFinalidadeXML): Boolean;
  Var
    strSQL: String;
    qryGenMer: TUniQuery;
Begin
  qryGenMer := fCriaQuery;
  Screen.Cursor := crHourGlass;

  Try
    {*****************************************}
    {* CRIA A TABELA TEMPORARIA              *}
    {**************************************LA*}
    pCriaTabelaEntradaMercadorias;

    With qryGenMer Do
    Begin
      qryGenMer.ParamCheck := FALSE;

      strSQL := fSqlInsertEntMer(True);

      strSQL := strSQL + fSQLItensNotaEletronica(strAutEle, strCodEmp, finalidadeXML);

      {*****************************************}
      {* EXECUTA O INSERT NA TABELA TEMPORARIA *}
      {**************************************LA*}
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaItensNotaEletronica]');
    End;
  End;

  Screen.Cursor := crDefault;

  FreeAndNil(qryGenMer);
end;

Function fVerificaValorVOutroXML(strAutEle: String): Boolean;
   Var
     qryVOutro: TUniQuery;
Begin
  qryVOutro := fCriaQuery;
  With qryVOutro, SQL Do
  Begin
    Add('SELECT SUM(IFNULL(I17A_VOUTRO, 0) + IFNULL(I16_VSEG, 0)) AS DESACE');
    Add('FROM');
    Add('  DETELE');
    Add('WHERE ');
    Add('  DET_SEQGER = :SEQGER ');

    ParamByName('SEQGER').AsString := strAutEle;

    Open;

    Result := FieldByName('DESACE').AsFloat > 0;

    Close;
 End;

 FreeAndNil(qryVOutro);
End;

{******************************************************************************}
{* DEFINE SE ITENS COM REDUÇÃO OU ITENS ISENTOS DO GRUPO X40 TERÃO SEU VALORES*}
{* GRAVADOS NO CAMPO "ISENTAS" DE ACORDO COM A INTERPRETAÇÃO/NECESSIDADE      *}
{* DA CONTABILIDADE DO CLIENTE                                                *}
{***************************************************************************VA*}
function fCodFisGravaIsentoDocEnt(strCFOP, strCodFis: String): Boolean;
begin
  Result := ((Pos('915', strCFOP) > 0) And (Pos(strCodFis, CST_NAO_TRIBUTADO) > 0) And (RightStr(strCodFis, 2) = '41') And (fCfgSis('IOE915', varString) = 'I')) Or
            (((Pos(strCodFis, CST_REDUCAO) > 0)And (RightStr(strCodFis, 2) = '20') And (fCfgSis('LVPENT', varString) = 'I')) Or
            ((Pos(strCodFis, CST_REDUCAO) > 0)And (RightStr(strCodFis, 2) = '70') And (fCfgSis('LVPE70', varString) = 'I')) Or
            ((Pos(strCodFis, CST_ISENTO) > 0) And (RightStr(strCodFis, 2) = '40') And (fCfgSis('LVPISE', varString) = 'I')) Or  //< REQ. 33070
            ((Pos(strCodFis, CST_ISENTO) > 0) And (RightStr(strCodFis, 2) = '30') And (fCfgSis('LVPI30', varString) = 'I')) Or
            ((Pos('915', strCFOP) < 1) And (Pos(strCodFis, CST_NAO_TRIBUTADO) > 0) And (RightStr(strCodFis, 2) = '41') And (fCfgSis('LVPI41', varString) = 'I')) Or
            ((Pos(strCodFis, CST_NAO_TRIBUTADO) > 0) And (RightStr(strCodFis, 2) = '51') And (fCfgSis('LVPI51', varString) = 'I')) Or
            ((Pos(strCodFis, CST_ISENTO) > 0) And (RightStr(strCodFis, 2) = '50') And (fCfgSis('LVPI50', varString) = 'I')));

end;

function fCodFisGravaIsentoDocEnt(strCFOP, strCodFis, strLVPENT, strLVPISE, strLVPE70, strLVPI30, strLVPI41, strLVPI50, strLVPI51, strIOE915: String): Boolean;
begin
  Result := ((Pos('915', strCFOP) > 0) And (Pos(strCodFis, CST_NAO_TRIBUTADO) > 0) And (RightStr(strCodFis, 2) = '41') And (strIOE915 = 'I')) Or
            (((Pos(strCodFis, CST_REDUCAO) > 0)And (RightStr(strCodFis, 2) = '20') And (strLVPENT = 'I')) Or
            ((Pos(strCodFis, CST_REDUCAO) > 0)And (RightStr(strCodFis, 2) = '70') And (strLVPE70 = 'I')) Or
            ((Pos(strCodFis, CST_ISENTO) > 0) And (RightStr(strCodFis, 2) = '40') And (strLVPISE = 'I')) Or             //< REQ. 33070
            ((Pos(strCodFis, CST_ISENTO) > 0) And (RightStr(strCodFis, 2) = '30') And (strLVPI30 = 'I')) Or
            ((Pos('915', strCFOP) < 1) And (Pos(strCodFis, CST_NAO_TRIBUTADO) > 0) And (RightStr(strCodFis, 2) = '41') And (strLVPI41 = 'I')) Or
            ((Pos(strCodFis, CST_NAO_TRIBUTADO) > 0) And (RightStr(strCodFis, 2) = '51') And (strLVPI51 = 'I')) Or
            ((Pos(strCodFis, CST_ISENTO) > 0) And (RightStr(strCodFis, 2) = '50') And (strLVPI50 = 'I')));
end;


function fEhRetornoGarantiaFornecedor(strClaFis: String; blnEhNfe_, blnVarGar: Boolean): Boolean;
begin
  Result := (Not blnEhNfe_) And
            (blnVarGar) And
            (Pos(RightStr(strClaFis, 3), '915_916_') > 0);
end;

Function fRetornaCodFisInterna(strEstEmp, strCodAbf: String): String;
  Var
    qryAbfIcm: TUniQuery;
    strSQL: String;
Begin
  Result := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT                          ';
  strSQL := strSQL + '   ABF_CODSIT_ENT_PEJ AS CODSIT  ';
  strSQL := strSQL + ' FROM ABFICM                     ';
  strSQL := strSQL + ' WHERE                           ';
  strSQL := strSQL + '   ABF_CODABF = :CODABF AND      ';
  strSQL := strSQL + '   ABF_ESTADO = :ESTADO          ';

  qryAbfIcm := fCriaQuery;

  With qryAbfIcm Do
  Begin
    SQL.Text := strSQL;

    ParamByName('CODABF').AsString := strCodAbf;
    ParamByName('ESTADO').AsString := strEstEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('CODSIT').AsString;

  End;

  FreeAndNil(qryAbfIcm);
End;

function fRetAliquotaInternaEstado_Entrada(strEmpEst: String; strUsaMatrizIcms: string): Double;
var qryConsulta: TUniQuery;
Begin
  Result := -1;
  If not fEmptyStr(strUsaMatrizIcms) Then
  begin
    qryConsulta := fCriaQuery;
    Try
      qryConsulta.SQL.Add('SELECT ICM_ALQICM');
      qryConsulta.SQL.Add('  FROM ICMALQ');
      qryConsulta.SQL.Add(' WHERE ICM_CODMAT = "'+ strUsaMatrizIcms+'"');
      qryConsulta.SQL.Add('   AND ICM_UF_ORI = "' + strEmpEst + '"');
      qryConsulta.SQL.Add('   AND ICM_UF_DES = "' + strEmpEst + '"');

      qryConsulta.Open;
      If Not qryConsulta.IsEmpty Then
        Result := qryConsulta.FieldByName('ICM_ALQICM').AsFloat;
    Finally
      FreeAndNil(qryConsulta);
    End;

  End;

  If Result = -1 then
  begin
    If Pos(strEmpEst, 'AM_DF_MA_PB_PE_RN_RS_SE_TO_MG_PR_SP_RJ_BA_AP_CE_PI_') > 0 Then
      Result := 18
    Else If (strEmpEst = 'RO') Then
      Result := 17.5
    Else
      Result := 17;
  End;
End;

procedure pCalculaTFCI(qryEntMer: TUniQuery);
var qryConsulta: TUniQuery;
    fAliquotaTFCI : Double;
    fltTotalNota,
    fltTFCI,
    fltTFCI_Fase1,
    fltTFCI_Fase2,
    fltAlqRepresentacaoItemNaNota: Double;

Begin

  If Not fCfgSis('SUFRAM', varBoolean) Then
    Exit;

  fAliquotaTFCI := fCfgSis('ALQTCF', varDouble);
  If fAliquotaTFCI = 0 Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT SUM(ENT_VLRCON) AS VLRCON FROM TMP_ENTMER');

    qryConsulta.Open;
    fltTotalNota := qryConsulta.FieldByName('VLRCON').AsFloat;
    fltTFCI := (fltTotalNota * fAliquotaTFCI) / 100;
    If fltTFCI > 200 Then
      fltTFCI := 200;

    fltTFCI_Fase1 := fltTFCI;

    qryConsulta.SQL.Text := '';
    qryConsulta.SQL.Add('SELECT TMP_ENTMER.*, NCM_ALQIPI FROM TMP_ENTMER');
    qryConsulta.SQL.Add('INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE ');
    qryConsulta.SQL.Add('INNER JOIN CADNCM ON ITE_EXCIPI = NCM_CODEXC AND ITE_CLAIPI = NCM_CODNCM');

    qryConsulta.Open;

    fltTFCI := fltTFCI_Fase1;
    qryConsulta.First;
    While not qryConsulta.Eof Do
    Begin
      If qryConsulta.FieldByName('NCM_ALQIPI').AsFloat > 0 Then
      Begin

        fltTFCI_Fase2 := (qryConsulta.FieldByName('ENT_VLRCON').AsFloat * fAliquotaTFCI) / 100;

        If fltTFCI_Fase2 > 30 Then
          fltTFCI_Fase2 := 30;

        qryConsulta.Edit;
        qryConsulta.FieldByName('ENT_CLTCIF').AsFloat := fltTFCI_Fase2;
        qryConsulta.Post;

        fltTFCI := fltTFCI + fltTFCI_Fase2;
      end
      Else
      Begin
        qryConsulta.Edit;
        qryConsulta.FieldByName('ENT_CLTCIF').AsFloat := 0;
        qryConsulta.Post;
      End;

      qryConsulta.Next;
    End;
    qryConsulta.SQL.Text := '';
    qryConsulta.SQL.Add('SELECT * FROM TMP_ENTMER');

    qryConsulta.Open;

    qryConsulta.First;
    While not qryConsulta.Eof Do
    Begin
      fltAlqRepresentacaoItemNaNota := (qryConsulta.FieldByName('ENT_VLRCON').AsFloat * 100)/fltTotalNota;
      qryConsulta.Edit;
      qryConsulta.FieldByName('ENT_CLTCIF').AsFloat := qryConsulta.FieldByName('ENT_CLTCIF').AsFloat + (fltTFCI_Fase1 * fltAlqRepresentacaoItemNaNota)/100;
      qryConsulta.FieldByName('ENT_ALQTCI').AsFloat := (qryConsulta.FieldByName('ENT_CLTCIF').AsFloat * 100)/ qryConsulta.FieldByName('ENT_VLRCON').AsFloat;
      qryConsulta.Post;
      qryConsulta.Next;
    End;
  Finally
    FreeAndNil(qryConsulta);
    qryEntMer.Close;
    qryEntMer.Open;
  End;
End;

function fRetOutDesImportacao: Double;
  var qryConsulta: TUniQuery;
Begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT');
    qryConsulta.SQL.Add('SUM(IFNULL(ENT_VSEGIMP, 0)) +');
    qryConsulta.SQL.Add('SUM(IFNULL(ENT_VALVII,0)) +');
    qryConsulta.SQL.Add('SUM(IFNULL(ENT_VAFRMM,0)) +');
    qryConsulta.SQL.Add('SUM(IFNULL(ENT_DESPAD,0)) ');
    // Se subtrair pis e confins então não soma no valor outras.
    If Not fCfgSis('ULTPIS', varBoolean) Then
    Begin
      qryConsulta.SQL.Add(' + SUM(IFNULL(ENT_VALPIS,0))');
      qryConsulta.SQL.Add(' + SUM(IFNULL(ENT_VALCOF,0))');
    End;
    qryConsulta.SQL.Add('  AS OUTDES ');
    qryConsulta.SQL.Add('FROM TMP_ENTMER');
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
      Exit(0);
    Result := qryConsulta.FieldByName('OUTDES').AsFloat;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

{***********************************************************************}
{* RETORNA A PARCELA DA TAG <vOutro> DO XML QUE NAO ESTA CONTEMPLADA    *}
{* NA COMPOSICAO DO VALOR OUTRAS DO PERFIL ADUANEIRO.                   *}
{* EM NOTA DE IMPORTACAO O CAMPO ENT_DESACE E ZERADO PARA CFOP 3 PORQUE *}
{* AS PARCELAS QUE COMPOEM O VALOR OUTRAS (PIS, COFINS, IOF, SISCOMEX,  *}
{* AFRMM E DESPESAS ADUANEIRAS) SAO SOMADAS UMA A UMA PELO PERFIL - SE  *}
{* O VALOR OUTRAS FOSSE SOMADO INTEIRO HAVERIA DUPLICIDADE. PORTANTO O  *}
{* QUE SOBRA DE <vOutro> APOS DESCONTAR ESSAS PARCELAS E A DESPESA      *}
{* ACESSORIA INFORMADA PELO EMITENTE E PRECISA COMPOR O VALOR CONTABIL. *}
{***********************************************************************}
function fRetDesAceForaComposicaoOutras(qryEntMer: TUniQuery;
                                        PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro): Double;
  Var fltComposicaoOutras: Double;
Begin
  Result := 0;

  If Not Assigned(PerfilDespachanteAduaneiro) Then
    Exit;

  If qryEntMer.FindField('ENT_VOUTRO') = Nil Then
    Exit;

  fltComposicaoOutras := 0;

  If tcvoPIS in PerfilDespachanteAduaneiro.ComposicaoValorOutras Then
    fltComposicaoOutras := fltComposicaoOutras + qryEntMer.FieldByName('ENT_VALPIS').AsFloat;

  If tcvoCOFINS in PerfilDespachanteAduaneiro.ComposicaoValorOutras Then
    fltComposicaoOutras := fltComposicaoOutras + qryEntMer.FieldByName('ENT_VALCOF').AsFloat;

  If tcvoIOF in PerfilDespachanteAduaneiro.ComposicaoValorOutras Then
    fltComposicaoOutras := fltComposicaoOutras + qryEntMer.FieldByName('ENT_VALIOF').AsFloat;

  If tcvoSISCOMEX in PerfilDespachanteAduaneiro.ComposicaoValorOutras Then
    fltComposicaoOutras := fltComposicaoOutras + qryEntMer.FieldByName('ENT_VALSIS').AsFloat;

  If tcvoAFRMM in PerfilDespachanteAduaneiro.ComposicaoValorOutras Then
    fltComposicaoOutras := fltComposicaoOutras + qryEntMer.FieldByName('ENT_VAFRMM').AsFloat;

  If tcvoDESPESAS_ADUANEIRAS in PerfilDespachanteAduaneiro.ComposicaoValorOutras Then
    fltComposicaoOutras := fltComposicaoOutras + qryEntMer.FieldByName('ENT_DESPAD').AsFloat;

  Result := fFormataFloat(qryEntMer.FieldByName('ENT_VOUTRO').AsFloat - fltComposicaoOutras, 2);

  If Result < 0 Then
    Result := 0;
End;

function fRetFornecedorRegimeTributario(strCodFor: String): string;
begin
  Result := fCampoTabela('FOR_SIMPAU', 'CADFOR', ['FOR_CODFOR'], [strCodFor], False);
end;


function fAliquotaIpiSaidaProduto(ACodIte: String): Double;
var qryConsulta: TUniquery;
    strTabelaIpi: String;
    strCodAbfIpi: string;
begin
  strTabelaIpi := IIf(fCfgSis('TPABPC')= '2', 'ITEGER', 'CADITE');

  qryConsulta := fCriaQuery;

  Try
    qryConsulta.SQl.Add('SELECT ITE_ABFIPI FROM ' + strTabelaIpi);
    qryConsulta.SQl.Add(' WHERE ITE_CODITE = "'+ACodIte+'"');
    If strTabelaIpi = 'ITEGER' then
      qryConsulta.SQl.Add(' AND ITE_CODEMP = "'+VS_StrCodEmp+'"');
    qryConsulta.Open;

    strCodAbfIpi := qryConsulta.FieldByName('ITE_ABFIPI').AsString;

    qryConsulta.SQL.Clear;

    qryConsulta.SQL.Add('SELECT MAX(APC_ALQSAI) AS APC_ALQSAI FROM IPISAI');
    qryConsulta.SQL.Add(' WHERE APC_CODAPC = "'+strCodAbfIpi+'"');
    qryConsulta.SQL.Add('   AND APC_ALQSAI > 0');
    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
      Result := 0
    Else
      Result := qryConsulta.FieldByName('APC_ALQSAI').AsFloat;

  Finally
    FreeAndNil(qryConsulta);
  End;

End;

{*****************************************}
{* RETORNA SE UM FORNECEDOR É SIMPLES    *}
{**************************************MV*}
function fRetFornecedorSimples(strCodFor: String): Boolean;
begin
  Result := fRetFornecedorRegimeTributario(strCodFor) = 'S';
end;

procedure pRateiaImpostos(qryEntMer: TUniQuery;
                          FinalidadeXML: tpeFinalidadeXML;
                          objExcecaoCfopCst: TCfgCfopCst;
                          fltTotIte,
                          fltValFre,
                          fltDesEsp,
                          fltDesCom,
                          fltDesPis,
                          fltPerDesPis,
                          fltDesAce,
                          fltTotRet,
                          fltTotIteRet: Double;
                          pgbDados: TProgressBar;
                          fltAlqFor: Double;
                          strEstFor,
                          strCodFor,
                          strTipFor: String;
                          fltDifIpi,
                          fltEdtIpi: Double;
                          blnDevolu: Boolean;
                          blnICMSDesoneradoEstaNoDescontoComercial: Boolean;
                          PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;
                          strClaSub: String = '';
                          fltTotRetOriginal: Double = 0.0;
                          blnApliRed: Boolean = True;
                          strAutEle: String = '';
                          blnFreTri: Boolean = False;
                          strClaBri: String = '';
                          blnGarant: Boolean = False;
                          blnRecCliGarantia: Boolean = False;
                          blnNotaImp: Boolean = False;
                          blnZonFra: Boolean = False;
                          strEspDoc: String = 'NF';
                          blnConEqu: Boolean = False;
                          blnDescIncond: Boolean = False;
                          tipRatFrete: TTipoRateioFrete = trfPropValorItem;
                          blnPrecoPraticado: Boolean = False;
                          blnPresencial: Boolean = False;
                          blnClaFisBonificacao: Boolean = False;
                          blnCaixa2: Boolean = False;
                          blnAcessadoViaRetornoConsignacao : Boolean = False;
                          blnManterIpi: Boolean = False;
                          blnZeraIcmsDevolucao: Boolean = True;
                          blnZerouSt: Boolean = False);
Var
{$Region 'Variáveis'}
    intUltIpi: Integer;
    intUltRet: Integer;
    fltIpiAcumulado: Double;
    fltRetAcumulado: Double;
    blnATUIPI: Boolean;
    blnCreIpi: Boolean;
    blnIMPDIR: Boolean;
    strECAIPI: String;
    fltIpiSai: Double;
    SomaImpostoDeImportacao: Boolean;
    blnComLub: Boolean;
    strConCla,
    strConSub: String;

    blnSimPau: Boolean;

    strCodFisInterna: String;
    fltAlqIcmInterna: Double;

    qryFreEnt: TUniQuery;

    blnNfe: Boolean;
    strUsaMatrizIcms: string;
    blnRedCargaMedia: Boolean;

    blnTemValorDesAceXML: Boolean;

    fltDesPisRestante: Double;

    fltClcAux: Double;

    fltDifRetido: Double;
    fltTotFre: Double;
    fltTotAce: Double;
    fltTotDes: Double;
    fltTotValRet : Double;
    fltToEValRet : Double;
    fltVFCPST    : Double;
    fltValFCP    : Double;

    fltTmpFre: Double;
    fltTmpAce: Double;
    fltTmpDes: Double;
    fltTmpRet: Double;
    fltTmERet: Double;
    flValGnrTribut: Double;
    fltVlrCon: Double;
    strClaFis: String;
    strCodFis: String;
    fltBkpBasIcm: Double;
    fltBkpAlqIcm: Double;

    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltBasIcmBkp: Double;
    fltAlqIcmRed: Double;
    fltValIcm: Double;
    fltPerFCP: Double;
    fltPerBas: Double;
    fltAlqFCPSt: Double;
    fltBFCPST: Double;
    fltPeBaST: Double;
    fltOutras: Double;

    fltTotIpi: Double;
    fltBasIpi: Double;
    fltAlqIpi: Double;
    fltValIpi: Double;

    fltToEIpi: Double;
    fltBaEIpi: Double;
    fltAlEIpi: Double;
    fltVaEIpi: Double;

    fltToERet: Double;
    fltBaERet: Double;
    fltAlERet: Double;

    fltIsento: Double;
    fltBasRet: Double;
    fltAliSte: Double;
    fltAliFCP: Double;

    fltAlqIcmCalculoRetido,
    fltDesAdb: Double;

    strEstEmp,
    strTipAbf: String;

    strEmpEst: String;
    strIteSer: String;
    strSerTer: String;

    blnAtuPis,
    blnContribuinteIPI: Boolean;

    fltValIpiEdt: Double;
    fltVaEIpiEdt: Double;
    fltTotIpiVal: Double;
    fltPerCor   : Double;
    fltPerCorIPI: Double;
    fltPerCorRet: Double;
    fltTotSer   : Double;
    fltValPriIte: Double;
    fltVaEPriIte: Double;
    fltVaERetEdt: Double;
    fltPerRetAux: Double;

    strAtuAdb,
    strClaFisFalt: String;

    blnUsaLotePrecos: Boolean;
    blnUtiCadAbfIpi: Boolean;

    blnEhRetornoGarantiaFornecedor: Boolean;
    LMemCalGNRE: String;
    blnSomaReforma: Boolean;
{$EndRegion}
{$Region 'Métodos locais'}
   function fZeraICMSDevolucao : Boolean;
   Begin
      Result := fCfgSis('IMPDIR') = 'N';
      If  fCfgSis('IMPDIR') = 'S'  Then
        Result := qryEntMer.FieldbyName('ENT_IMPDIR').AsString = 'N'
   End;


    Function fSQLEntrada: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  TMP_ENTMER ';
      strSQL := strSQL + 'SET ';
      If (Not blnGarant) And (not blnRecCliGarantia) Then
      Begin
        strSQL := strSQL + '  ENT_CLAFIS = :CLAFIS, ';
        strSQL := strSQL + '  ENT_NATOPE = :NATOPE, ';
      End;
      strSQL := strSQL + '  ENT_CODFIS = :CODFIS, ';
      strSQL := strSQL + '  ENT_VLRCON = :VLRCON, ';
      strSQL := strSQL + '  ENT_PERBAS = :PERBAS, ';
      strSQL := strSQL + '  ENT_BASICM = :BASICM, ';
      strSQL := strSQL + '  ENT_ALQICM = :ALQICM, ';
      strSQL := strSQL + '  ENT_VALICM = :VALICM, ';
      strSQL := strSQL + '  ENT_VALFCP = :VALFCP, ';
      strSQL := strSQL + '  ENT_PERFCP = :PERFCP, ';

      strSQL := strSQL + '  ENT_BASIPI = :BASIPI, ';
      strSQL := strSQL + '  ENT_ALQIPI = :ALQIPI, ';
      strSQL := strSQL + '  ENT_VALIPI = :VALIPI, ';

      If blnUsaLotePrecos Then
      Begin
        strSQL := strSQL + '  ENT_IPIENT = :IPIENT, ';
        strSQL := strSQL + '  ENT_SUBSTI = IFNULL(:SUBSTI, ENT_SUBSTI), ';
    //    strSQL := strSQL + '  ENT_SUBSTI = IFNULL(:SUBSTI, 0), ';
      End;

      If (not blnNfe) and (Not blnGarant) And (not blnRecCliGarantia) and (not blnDevolu) then
      begin
        strSQL := strSQL + '  ENT_BFCPST = :BFCPST, ';
        strSQL := strSQL + '  ENT_PFCPST = :PFCPST, ';
        strSQL := strSQL + '  ENT_VFCPST = :VFCPST, ';
      end;

      // VARIAVEIS PARA GUARDAR O IPI QUANDO NAO UTILIZA CREDITOS DE IPI
      strSQL := strSQL + '  ENT_BAEIPI = :BAEIPI, ';
      strSQL := strSQL + '  ENT_ALEIPI = :ALEIPI, ';
      strSQL := strSQL + '  ENT_VAEIPI = :VAEIPI, ';

      // VARIAVEIS PARA GUARDAR O ICMS QUANDO EMPRESA SUBSTITUIDA
      strSQL := strSQL + '  ENT_BAERET = IFNULL(:BAERET, ENT_BAERET), ';
      strSQL := strSQL + '  ENT_VAERET = IFNULL(:VAERET, ENT_VAERET), ';

      strSQL := strSQL + '  ENT_ISENTO = :ISENTO, ';
      strSQL := strSQL + '  ENT_PEBAST = :PEBAST, ';
      strSQL := strSQL + '  ENT_BASRET = IFNULL(:BASRET, ENT_BASRET), ';
      strSQL := strSQL + '  ENT_VALRET = IFNULL(:VALRET, ENT_VALRET), ';

      strSQL := strSQL + '  ENT_DESPIS = :DESPIS, ';

      If blnAtuPis Then
        strSQL := strSQL + '  ENT_DEPICO = :DEPICO, ';

      strSQL := strSQL + '  ENT_OUTRAS = :OUTRAS, ';
      strSQL := strSQL + '  ENT_DESESP = :DESESP  ';

      If strAtuAdb = 'D' Then
      Begin
        strSQL := strSQL + ' ,ENT_DESADB = :DESADB ';
        strSQL := strSQL + ' ,ENT_ITETRI = :ITETRI ';
        strSQL := strSQL + ' ,ENT_VALADB = :VALADB ';
        strSQL := strSQL + ' ,ENT_CALGNR = :CALGNR ';
      End;
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

      Result := strSQL;
    End;

    Procedure pGetUltimosImpostos;
    Begin
      intUltIpi := -1;
      intUltRet := -1;

      With qryEntMer Do
      Begin
        First;
        While Not Eof Do
        Begin
          If FieldByName('ENT_VALIPI').AsFloat + FieldByName('ENT_VAEIPI').AsFloat > 0 Then
            intUltIpi := RecNo;

          If (Pos(FieldByName('ENT_CODFIS').AsString, CST_SUBSTITUICAO) > 0) Then
            intUltRet := RecNo;

          Next;
        End;
        First;
      End;
    End;

    Function fRetornaDescontoPisCofins(blnTestarUltImp: Boolean): Double;
    Begin
      If (qryEntMer.RecNo = qryEntMer.RecordCount) And blnTestarUltImp Then
      Begin
        Result := fltDesPisRestante;
      End Else
      Begin

        If fltDesCom = 0 Then
        Begin
          Result := qryEntMer.FieldByName('ENT_DESESP').AsFloat;

          If Not blnICMSDesoneradoEstaNoDescontoComercial Then
            Result := Result - qryEntMer.FieldByName('ENT_VICMDE').AsFloat;

        End Else
        Begin
          Result := RoundTo(qryEntMer.FieldByName('ENT_TOTITE').AsFloat * fltPerDesPis / 100, - 2);

          If (Result > fltDesPisRestante) And blnTestarUltImp Then
          Begin
           Result := fltDesPisRestante;
           fltDesPisRestante := 0;
          End;

        End;

        fltDesPisRestante := fltDesPisRestante - Result;
        If fltDesPisRestante < 0 Then
          fltDesPisRestante := 0;
      End;
    End;

    // Parcela da Reforma do item (CBS + IBS estadual + IBS municipal + IS), vinda do XML (DETERT)
    Function fValorReformaItem: Double;
    Begin
      Result := 0;
      If (Not blnSomaReforma) Or (Not Assigned(qryEntMer.FindField('ENT_RFCVAL'))) Then
        Exit;

      Result := qryEntMer.FieldByName('ENT_RFCVAL').AsFloat +
                qryEntMer.FieldByName('ENT_RFIVAL').AsFloat +
                qryEntMer.FieldByName('ENT_RFSVLR').AsFloat;
    End;

    procedure pCalculaImpostosItens(blnTestarUltImp: Boolean);
      Var
        qryGenTmp: TUniQuery;
        blnIsentas: Boolean;
    begin
      qryGenTmp := fCriaQuery;

      fltBasIpi := 0.0;
      fltBaEIpi := 0.0;

      If blnCreIpi Then
      Begin
        fltAlqIpi := qryEntMer.FieldByName('ENT_PERIPI').AsFloat;
        fltAlEIpi := 0;
      End Else
      Begin
        fltAlqIpi := 0;
        fltAlEIpi := qryEntMer.FieldByName('ENT_PERIPI').AsFloat;
      End;

      fltValIpi := 0.0;
      fltVaEIpi := 0.0;

      fltIsento := 0.0;
      fltBasRet := 0.0;

      If SameText(strEspDoc, 'NF') Then
      Begin

        If (fltAlqIpi > 0.0) Or ((blnNfe Or blnPrecoPraticado) And blnCreIpi) Then
        Begin

          If (Not blnNfe) And (Not blnPrecoPraticado) Then
          Begin

            fltBasIpi := ( qryEntMer.FieldByName('ENT_BASIPI').AsFloat );

            If (fltDifIpi <> 0) And blnTestarUltImp And (intUltIpi = qryEntMer.RecNo) Then
              fltValIpi := fltEdtIpi - fltIpiAcumulado

            Else If (fltDifIpi = 0) Then
              fltValIpi := qryEntMer.FieldByName('ENT_VALIPI').AsFloat

            Else
              fltValIpi := fFormataFloat( ( ( fltAlqIpi / 100 ) * fltBasIpi ) + fFormataFloat(( fltPerCorIPI * fltDifIpi ), 2), 2);

          End
          Else
          Begin
            fltBasIpi := (qryEntMer.FieldByName('ENT_BASIPI').AsFloat );
            fltValIpi := fFormataFloat( qryEntMer.FieldByName('ENT_VALIPI').AsFloat + fFormataFloat(( fltPerCorIPI * fltDifIpi ), 2), 2);
          End;

          if fltValIpi < 0 Then
            fltValIpi := 0;

          fltIpiAcumulado := fltIpiAcumulado + fltValIpi;

          If Not blnTestarUltImp Then
          Begin
            fltBasIpi := qryEntMer.FieldByName('ENT_BASIPI').AsFloat;
            fltValIpi := qryEntMer.FieldByName('ENT_VALIPI').AsFloat;
          End;
        End;

        If (fltAlEIpi > 0.0) Or ((blnNfe Or blnPrecoPraticado) And (Not blnCreIpi)) Then
        Begin

          If (Not blnNfe) And (Not blnPrecoPraticado) Then
          Begin
            fltBaEIpi := ( qryEntMer.FieldByName('ENT_BAEIPI').AsFloat );

            If (fltDifIpi <> 0) And blnTestarUltImp And (intUltIpi = qryEntMer.RecNo) Then
            Begin
              fltVaEIpi := fltEdtIpi - fltIpiAcumulado;
            End Else
            Begin
              fltVaEIpi := fFormataFloat( ( ( fltAlEIpi / 100 ) * fltBaEIpi ) + fFormataFloat(( fltPerCorIPI * fltDifIpi ), 2), 2);
            End;

          End Else
          Begin
            fltBaEIpi := (qryEntMer.FieldByName('ENT_BAEIPI').AsFloat );

            If (fltDifIpi <> 0) And blnTestarUltImp And (intUltIpi = qryEntMer.RecNo) Then
              fltVaEIpi := fltEdtIpi - fltIpiAcumulado
            Else
              fltVaEIpi := fFormataFloat( qryEntMer.FieldByName('ENT_VAEIPI').AsFloat + fFormataFloat(( fltPerCorIPI * fltDifIpi ), 2), 2);
          End;

          if fltVaEIpi < 0 Then
            fltVaEIpi := 0;

          fltIpiAcumulado := fltIpiAcumulado + fltVaEIpi;

          If Not blnTestarUltImp Then
          Begin
            fltBaEIpi := qryEntMer.FieldByName('ENT_BAEIPI').AsFloat;
            fltVaEIpi := qryEntMer.FieldByName('ENT_VAEIPI').AsFloat;
          End;
        End;

      End;

      fltDesAdb := 0;
      blnComLub := fCampotabela('ITE_COMLUB', 'CADITE', ['ITE_CODITE'], [qryEntMer.FieldByname('ENT_CODITE').AsString]) = 'S';

      If fRetornaDadosFiscais(strEmpEst,
                              blnContribuinteIPI,
                              qryEntMer.FieldByName('ENT_ANTPRO').AsString = 'S',
                              qryEntMer.FieldByName('ENT_CODABF').AsString,
                              qryEntMer.FieldByName('ENT_TOTITE').AsFloat - IIf(blnDescIncond, 0, fltTmpDes) +
                                IIF(blnFreTri, fltTmpFre + fltTmpAce, 0),
                              fltAlqFor,
                              strEstFor,
                              strCodFor,
                              fItemRevInd(qryEntMer.FieldByname('ENT_CODITE').AsString, VS_StrCodEmp) = 'R',
                              strClaFis,
                              strCodFis,
                              fltBasIcm,
                              fltAlqIcm,
                              fltAlqIcmRed,
                              fltValIcm,
                              fltPerBas,
                              fltPeBaST,
                              fltAliSte,
                              fltAliFCP,
                              blnRedCargaMedia,
                              blnDevolu,
                              True,
                              blnGarant,
                              blnRecCliGarantia,
                              blnNotaImp,
                              qryEntMer.FieldByName('ENT_I08CFO').AsString,
                              blnConEqu,
                              blnPresencial,
                              nil,
                              blnAcessadoViaRetornoConsignacao,
                              blnComLub,
                              FinalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor) Then
      Begin
        fltAlqFCPSt := fltAliFCP;
        fltBasIcmBkp := fltBasIcm;
        fltValFCP := qryEntMer.FieldByName('ENT_VALFCP').AsFloat;
        fltPerFCP := qryEntMer.FieldByName('ENT_PERFCP').AsFloat;

        If (qryEntMer.FieldByName('ENT_CODITE').AsString = strIteSer) Or
           (qryEntMer.FieldByName('ENT_CODITE').AsString = strSerTer) Or
           (qryEntMer.FieldByName('ENT_TIPPRO').AsString = TIPO_PRODUTO_SPED[9,0]) Then
            strClaFis := strClaFis[1] + '933'
        Else
        If (strTipFor = 'M') And (Not fEmptyStr(strClaFis)) Then
        Begin

          If (qryEntMer.FieldByName('ENT_VALRET').AsFloat + qryEntMer.FieldByName('ENT_VAERET').AsFloat) > 0 Then
            strClaFis := strClaFis[1] + strConSub
          Else
            strClaFis := strClaFis[1] + strConCla;

        End;

        If blnNfe Then
        Begin
          if (Not fEmptyStr(strClaBri)) And (String(qryEntMer.FieldByName('ENT_I08CFO').AsString).Substring(1,3) = '910') Then
            strClaFis := strClaBri;

          If (Not fEmptyStr(qryEntMer.FieldByName('ENT_SITXML').AsString) ) And
             (Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, '201_202_101_102') > 0)) And
             ((Not blnSimPau) Or (Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, '500') > 0))) And
             (qryEntMer.FieldByName('ENT_CSTCAD').AsString = 'N') And
             (strTipFor <> 'M')  Then
            strCodFis := qryEntMer.FieldByName('ENT_SITXML').AsString;

        End;

        If blnPrecoPraticado Then
        Begin
          strCodFis := qryEntMer.FieldByName('ENT_CODFIS').AsString;
          fltPerBas := qryEntMer.FieldByName('ENT_PERBAS').AsFloat;
        End;

        fltPerRetAux := fltPeBaST;

        blnEhRetornoGarantiaFornecedor := fEhRetornoGarantiaFornecedor(qryEntMer.FieldByName('ENT_CLAFIS').AsString, blnNfe, blnGarant);

        If (Not SameText(strEspDoc, 'NF')) Or (blnEhRetornoGarantiaFornecedor) Then
        Begin
          If (blnEhRetornoGarantiaFornecedor) Then
          Begin
            strCodFis := '041';
          End;

          if Not blnManterIpi then
          begin
            fltAlqIpi := 0.0;
            fltBasIpi := 0.0;
            fltValIpi := 0.0;

            fltAlEIpi := 0.0;
            fltBaEIpi := 0.0;
            fltVaEIpi := 0.0;
          end;

          fltAlERet := 0.0;
          fltBaERet := 0.0;

          fltBasIcm := 0.0;
          fltAlqIcm := 0.0;
          fltValIcm := 0.0;
          fltValFCP := 0.0;
          fltPerFCP := 0.0;
          fltPerBas := 0.0;
          fltPeBaST := 0.0;

          fltPerRetAux := 0.0;

          fltTmpRet := 0;
          fltTmERet := 0;

          fltAlqIcmCalculoRetido := 0;
        End
        Else
        Begin
          fltAlqIcmCalculoRetido := fltValIcm;

          {*****************************************}
          {* CASO O FORNECEDOR FOR DO SIMPLES ZERA *}
          {* DADOS DO ICMS.                        *}
          {**************************************GB*}
          If (not blnDevolu) and
             ((fRetFornecedorSimples(strCodFor) Or ((fFornecedorFilial(strCodFor)) and blnSimPau)) Or
              ((Not blnNfe) And (Pos(strCodFis, CST_SUBSTITUICAO) > 0))) Then
          Begin
            fltBasIcm := 0.0;
            fltAlqIcm := 0.0;
            fltValIcm := 0.0;
            fltValFCP := 0.0;
            fltPerFCP := 0.0;
            fltPerBas := 0.0;
            fltPeBaST := 0.0;
          End;

          {*****************************************}
          {* CASO FOR NOTA ELETRONICA, PEGA A BASE *}
          {* DE IPI DO ARQUIVO XML.                *}
          {**************************************LA*}
          If blnNFe And
            fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) and
            (fCfgSis('ICMABF') = 'S') and
            (qryEntMer.FieldByName('ENT_CSTCAD').AsString = 'S') And
            ((Pos(strCodFis, CST_X00) > 0) or (Pos(strCodFis, CST_X20) > 0)) and
            (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, CST_X40) > 0) Then

          Begin
            fltBasIcm := qryEntMer.FieldByName('CAL_BASICM').AsFloat;
            fltAlqIcm := qryEntMer.FieldByName('CAL_ALQICM').AsFloat;
            fltValIcm := qryEntMer.FieldByName('CAL_VLICMS').AsFloat;
          End
          Else
          If (blnNfe Or blnPrecoPraticado) Or (blnZonFra And (Pos(strCodFis, CST_SUBSTITUICAO) <= 0)) Then
          Begin
            If fRestauraICM(qryEntMer, strCodFis) Then
            Begin
              fltBasIcm := qryEntMer.FieldByName('ENT_BASICM').AsFloat;
              fltAlqIcm := qryEntMer.FieldByName('ENT_ALQICM').AsFloat;
              fltValIcm := qryEntMer.FieldByName('ENT_VALICM').AsFloat;
              fltValFCP := qryEntMer.FieldByName('ENT_VALFCP').AsFloat;
              fltPerFCP := qryEntMer.FieldByName('ENT_PERFCP').AsFloat;
            End;

            fltAlqIcmCalculoRetido := fltValIcm;
          End;

          if qryEntMer.FieldByName('ENT_DIFICM').AsString = 'S' Then
          Begin
            fltBasIcm := 0.0;
            fltAlqIcm := 0.0;
            fltValIcm := 0.0;
          end;


          If (strTipFor = 'M') Then
          Begin
            fltBasIcm := 0.0;
            fltAlqIcm := 0.0;
            fltValIcm := 0.0;
            fltValFCP := 0.0;
            fltPerFCP := 0.0;
            fltPerBas := 0.0;
            fltPeBaST := 0.0;
          End;

          fltBaERet := 0;
          fltBasRet := 0;

          If (Pos(strCodFis, CST_SUBSTITUICAO) > 0)  And
             (qryEntMer.FieldByName('ENT_ANTPRO').AsString <> 'S') Then
          Begin

            If (blnNfe Or blnPrecoPraticado) Then
            Begin
              If (strClaSub = '1') Then
              Begin
                fltBaERet := qryEntMer.FieldByName('ENT_BAERET').AsFloat;
                fltBasRet := 0;
              End
              Else
              Begin
                fltBasRet := qryEntMer.FieldByName('ENT_BASRET').AsFloat;
                fltBaERet := 0;
              End;
            End Else If (Not blnZerouSt) Then
            Begin
              If (strClaSub = '1') Then
              Begin
                fltBaeRet := ((((qryEntMer.FieldByName('ENT_TOTITE').AsFloat - IIf(blnDescIncond, 0, fltTmpDes)) + fltValIpi + fltVaEIPI) * IIF(blnApliRed, fltPerRetAux, 100)) / 100) *
                             fRetornaPercIVA(qryEntMer.FieldByName('ENT_CODABF').AsString,strEstFor,strTipAbf);
                fltBasRet := 0;
              End
              Else
              Begin
                fltBasRet := ((((qryEntMer.FieldByName('ENT_TOTITE').AsFloat - IIf(blnDescIncond, 0, fltTmpDes)) + fltValIpi + fltVaEIPI) * IIF(blnApliRed, fltPerRetAux, 100)) / 100) *
                             fRetornaPercIVA(qryEntMer.FieldByName('ENT_CODABF').AsString,strEstFor,strTipAbf);
                fltBaeRet := 0;
              End;
            End;

            {*************************************************************}
            {* COMO RECALCULA O VALOR DO RETIDO ENTAO ALTERA O VALOR     *}
            {* CONTABIL SUBSTITUINDO O RETIDO ANTERIOR PELO NOVO         *}
            {* (NAO APLICANDO A REDUCAO DA BASE)                         *}
            {**********************************************************JC*}
            If (Not blnApliRed) Then
            Begin
              fltVlrCon := fltVlrCon - (fltTmpRet + fltTmERet);

              If (strClaSub <> '1') Then
              Begin
                If (blnNfe Or blnPrecoPraticado) Then
                Begin
                  fltTmpRet := qryEntMer.FieldByName('ENT_VALRET').AsFloat ;
                End Else
                Begin
                  fltTmpRet := fRetornaValRet(strEmpEst, fltBasRet, fltAlqIcmCalculoRetido, fltAliSte);
                End;
                fltTmERet := 0;
              End
              Else
              Begin
                If (blnNfe Or blnPrecoPraticado) Then
                Begin
                  fltTmERet := qryEntMer.FieldByName('ENT_VAERET').AsFloat ;
                End Else
                Begin
                  fltTmERet := fRetornaValRet(strEmpEst, fltBaERet, fltAlqIcmCalculoRetido, fltAliSte);
                End;
                fltTmpRet := 0;
              End;

              fltVlrCon := fltVlrCon + (fltTmpRet + fltTmERet);
            End;

            If (Not blnDevolu) Or (blnDevolu And fZeraICMSDevolucao) And (blnZeraIcmsDevolucao) Then
            begin
              fltPerBas := 0.0;
              fltBasIcm := 0.0;
              fltAlqIcm := 0.0;
              fltValIcm := 0.0;
              fltValFCP := 0.0;
              fltPerFCP := 0.0;
            End;
          End {If (Pos(strCodFis, CST_SUBSTITUICAO) > 0)  And}

          Else If (qryEntMer.FieldByName('ENT_ANTPRO').AsString = 'S') Then
          Begin
            fltPerBas := 0.0;
            fltBasIcm := 0.0;
            fltAlqIcm := 0.0;
            fltValIcm := 0.0;
            fltValFCP := 0.0;
            fltPerFCP := 0.0;

            fltBasRet := 0;
            fltBaeRet := 0;
            fltTmpRet := 0;
            fltTmERet := 0;
          End;

        End;

        If blnCreIpi Then
        Begin
          fltVaEIpi := 0;
          fltBaEIpi := 0;
          fltAlEIpi := 0;

          If (fltValIpi > 0) Then
          Begin
            If fltBasIpi = 0 Then
              fltBasIpi := qryEntMer.FieldByName('ENT_TOTITE').AsFloat;

            If fltAlqIpi = 0 Then
              fltAlqIpi := RoundTo((fltValIpi / fltBasIpi) * 100, -2);
          End;

        End Else
        Begin
          fltValIpi := 0;
          fltBasIpi := 0;
          fltAlqIpi := 0;

          If (fltVaEIpi > 0) Then
          Begin
            If fltBaEIpi = 0 Then
              fltBaEIpi := qryEntMer.FieldByName('ENT_TOTITE').AsFloat;

            If fltAlEIpi = 0 Then
              fltAlEIpi := RoundTo((fltVaEIpi / fltBaEIpi) * 100, -2);
          End;

        End;

        {**********************************************************************}
        {* O IPI PODE TER SIDO ALTERADO ACIMA POR CAUSA DA DIFERENÇA DIGITADA *}
        {*******************************************************************LA*}
        If (not blnNfe) and (Not blnGarant) And (not blnRecCliGarantia) and (not blnDevolu) And (Not blnZerouSt) then
        begin
          fltBFCPST := (fltBaeRet  +  fltBasRet);
          fltVFCPST := RoundTo((fltBFCPST * fltAlqFCPSt) / 100, -2);
          If fCfgSis('EMCFCP') = '2' Then
           fltVFCPST := fltVFCPST - (fltBasIcmBkp * (fltAlqFCPSt / 100));
        end
        Else
          fltVFCPST := qryEntMer.FieldByName('ENT_VFCPST').AsFloat;

        If (blnNfe Or blnPrecoPraticado) And (LeftStr(strClaFis, 1) = '3') Then
        begin
          If Assigned(PerfilDespachanteAduaneiro) then
          begin
            fltVlrCon := qryEntMer.FieldByName('ENT_DESACE').AsFloat;

            {*************************************************************}
            {* ENT_DESACE FOI ZERADO NO SQL PARA CFOP 3 PARA NAO SOMAR EM *}
            {* DUPLICIDADE AS PARCELAS DO VALOR OUTRAS QUE O PERFIL JA    *}
            {* ADICIONA ABAIXO. O QUE SOBRA DA TAG <vOutro> APOS ESSAS    *}
            {* PARCELAS E DESPESA ACESSORIA DO EMITENTE E DEVE COMPOR O   *}
            {* VALOR CONTABIL.                                           *}
            {*************************************************************}
            fltVlrCon := fltVlrCon + fRetDesAceForaComposicaoOutras(qryEntMer, PerfilDespachanteAduaneiro);

            If tcvcVR_PRODUTOS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_TOTITE').AsFloat;

            If tcvcFRETE in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VALFRE').AsFloat;

            If tcvcPIS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VALPIS').AsFloat;

            If tcvcCOFINS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VALCOF').AsFloat;

            If tcvcIPI in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VALIPI').AsFloat;

            If tcvcII in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VALVII').AsFloat;

            If tcvcAFRMM in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VAFRMM').AsFloat;

            If tcvcVR_ICMS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VALICM').AsFloat;

            If tcvcDESPESAS_ADUANEIRAS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_DESPAD').AsFloat;

            If tcvcSEGURO in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VSEGIMP').AsFloat;

            If tcvcSISCOMEX in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VALSIS').AsFloat;

            If tcvcIOF in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
              fltVlrCon := fltVlrCon + qryEntMer.FieldByName('ENT_VALIOF').AsFloat;


          end
          else
            fltVlrCon := qryEntMer.FieldByName('ENT_TOTITE').AsFloat +

                         qryEntMer.FieldByName('ENT_DESESP').AsFloat +
                         qryEntMer.FieldByName('ENT_VALFRE').AsFloat +
                         qryEntMer.FieldByName('ENT_DESACE').AsFloat +
                         qryEntMer.FieldByName('ENT_VALIPI').AsFloat +

                         qryEntMer.FieldByName('ENT_VALPIS').AsFloat +
                         qryEntMer.FieldByName('ENT_VALCOF').AsFloat +
                         IIf(SomaImpostoDeImportacao, qryEntMer.FieldByName('ENT_VALVII').AsFloat, 0) +
                         qryEntMer.FieldByName('ENT_VAFRMM').AsFloat +
                         qryEntMer.FieldByName('ENT_VALICM').AsFloat +
                         qryEntMer.FieldByName('ENT_DESPAD').AsFloat
        end
        else
          fltVlrCon := (qryEntMer.FieldByName('ENT_TOTITE').AsFloat + fltValIpi + fltVaEIpi + fltTmpFre + fltTmpAce + fltTmpRet + fltVFCPST + fltTmERet) - IIf(blnDescIncond, 0, IIf(blnRecCliGarantia, 0,fltTmpDes));

        qryGenTmp.Close;
        qryGenTmp.SQL.Clear;
        qryGenTmp.SQL.Add(fSQLEntrada);

        qryGenTmp.ParamByName('DESPIS').AsFloat  := fRetornaDescontoPisCofins(blnTestarUltImp);

        If blnAtuPis Then
          qryGenTmp.ParamByName('DEPICO').AsFloat  := fltPerDesPis;

        {*****************************************}
        {* DADOS QUE SERÃO ATUALIZADOS           *}
        {**************************************MV*}
        if ((Not blnGarant) And (not blnRecCliGarantia)) then
        Begin
          If (fValorTabelaCFOPEntrada(qryEntMer.FieldByName('ENT_I08CFO').AsString,  strCodFis, qryEntMer.FieldByName('ENT_TIPPRO').AsString, strClaFis)) Then
            qryGenTmp.ParamByName('CLAFIS').AsString := strClaFis
          Else
          Begin
            If (Not blnGarant) And (not blnRecCliGarantia) Then
              qryGenTmp.ParamByName('CLAFIS').AsString := strClaFis;

            If blnClaFisBonificacao Then
              qryGenTmp.ParamByName('CLAFIS').AsString := strClaFis[1] + '910';
          End;

          If Not fEmptyStr(qryGenTmp.ParamByName('CLAFIS').AsString) Then
            qryGenTmp.ParamByName('NATOPE').AsString := fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(qryGenTmp.ParamByName('CLAFIS').AsString));
        End;

        {*****************************************}
        {* CALCULA VALOR DE 'OUTRAS/ISENTAS'     *}
        {**************************************MV*}
        fltClcAux := fRetornaValorOutras(fltVlrCon, fltBasIcm, fltValIpi, fltTmpRet, fltTmERet, fltVaeIpi, fltVFCPST);

        If (Not blnGarant) And (not blnRecCliGarantia) and objExcecaoCfopCst.fExcecaoDefinida(qryGenTmp.ParamByName('CLAFIS').AsString, strCodFis) Then
          blnIsentas := objExcecaoCfopCst.blnIsentas
        Else
          blnIsentas := fCodFisGravaIsentoDocEnt(qryEntMer.FieldByName('ENT_CLAFIS').AsString, strCodFis);

        If blnIsentas Then
        Begin
          fltIsento := fltClcAux;
          fltOutras := 0;
        End Else
        Begin
          fltIsento := 0;
          fltOutras := fltClcAux;
        End;

        {Req. 468382 - CBS + IBS + IS compõem o valor contábil, como no livro fiscal;
         Outras/Isentas acima já foram apuradas sem eles}
        fltVlrCon := fltVlrCon + fValorReformaItem;

        qryGenTmp.ParamByName('CODFIS').AsString := strCodFis;
        qryGenTmp.ParamByName('VLRCON').AsFloat  := fltVlrCon;
        qryGenTmp.ParamByName('PERBAS').AsFloat  := fltPerBas;
        qryGenTmp.ParamByName('PEBAST').AsFloat  := fltPeBaST;
        qryGenTmp.ParamByName('BASICM').AsFloat  := fltBasIcm;
        qryGenTmp.ParamByName('ALQICM').AsFloat  := fltAlqIcm;
        qryGenTmp.ParamByName('VALICM').AsFloat  := fltValIcm;
        qryGenTmp.ParamByName('VALFCP').AsFloat  := fltValFCP;
        qryGenTmp.ParamByName('PERFCP').AsFloat  := fltPerFCP;

        If (not blnNfe) and (Not blnGarant) And (not blnRecCliGarantia) and (not blnDevolu) then
        begin
          qryGenTmp.ParamByName('BFCPST').AsFloat  := fltBFCPST;
          qryGenTmp.ParamByName('PFCPST').AsFloat  := fltAlqFCPSt;
          qryGenTmp.ParamByName('VFCPST').AsFloat  := fltVFCPST;
        end;

        qryGenTmp.ParamByName('BASIPI').AsFloat  := fltBasIpi;
        qryGenTmp.ParamByName('ALQIPI').AsFloat  := fltAlqIpi;
        qryGenTmp.ParamByName('VALIPI').AsFloat  := fltValIpi;

        If blnUsaLotePrecos And blnATUIPI Then
        Begin
          If ((fltAlqIpi + fltAlEIpi) > 0) Then
          Begin
            If (fltAlEIpi = 0) then
              qryGenTmp.ParamByName('IPIENT').AsFloat := 0
            Else
              qryGenTmp.ParamByName('IPIENT').AsFloat  := fltAlqIpi + fltAlEIpi;
          End;
        End;

        // VARIAVEIS PARA GUARDAR O IPI QUANDO NAO UTILIZA CREDITOS DE IPI
        qryGenTmp.ParamByName('BAEIPI').AsFloat  := fltBaEIpi;
        qryGenTmp.ParamByName('ALEIPI').AsFloat  := fltAlEIpi;
        qryGenTmp.ParamByName('VAEIPI').AsFloat  := fltVaEIpi;

        // ADICIONADO TOTIPI DEVIDO AO RECALCULO DO TOTAL DO IPI DEPOIS DO
        // DESCONTO DA ENT.MERCADORIA
        qryGenTmp.ParamByName('ISENTO').AsFloat  := fltIsento;

        If (fltTotRetOriginal <= 0)                                             Or
           (fFormataFloat(fltTotRetOriginal, 2) <> fFormataFloat(fltTotRet, 2)) Or
           (Not blnApliRed) Then
        Begin
          If strClaSub = '1' Then
          Begin
            qryGenTmp.ParamByName('BAERET').AsFloat  := fltBaERet;
            qryGenTmp.ParamByName('VAERET').AsFloat  := fltTmERet;
            qryGenTmp.ParamByName('BASRET').Value := Null;
            qryGenTmp.ParamByName('VALRET').Value := Null;
          End
          Else
          Begin
            qryGenTmp.ParamByName('BASRET').AsFloat  := fltBasRet;
            qryGenTmp.ParamByName('VALRET').AsFloat  := fltTmpRet;
            qryGenTmp.ParamByName('BAERET').Value := Null;
            qryGenTmp.ParamByName('VAERET').Value := Null;
          End;

          If fCfgSis('ATUSUB', varBoolean) Then
          Begin
            If blnUsaLotePrecos Then
            begin
              If fltBasRet + fltBaERet > 0 Then
              qryGenTmp.ParamByName('SUBSTI').AsFloat  := fFormataFloat(((fltTmpRet + fltTmERet) / (fltBasRet + fltBaERet) * 100), 2)
              Else
                qryGenTmp.ParamByName('SUBSTI').AsFloat := 0;
            end;
          End;

        End
        Else
        Begin
          qryGenTmp.ParamByName('BASRET').Value := Null;
          qryGenTmp.ParamByName('VALRET').Value := Null;
          qryGenTmp.ParamByName('BAERET').Value := Null;
          qryGenTmp.ParamByName('VAERET').Value := Null;

          If blnUsaLotePrecos Then
            qryGenTmp.ParamByName('SUBSTI').Value := qryEntMer.FieldByName('ENT_SUBSTI').AsFloat;//Null;
        End;

        qryGenTmp.ParamByName('OUTRAS').AsFloat  := fltOutras;

        qryGenTmp.ParamByName('DESESP').AsFloat  := fltTmpDes;

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        qryGenTmp.ParamByName('AUTINC').AsInteger := qryEntMer.FieldByName('AUTOINCREM').AsInteger;
        flValGnrTribut := 0;

        If strAtuAdb = 'D' Then
        Begin
          fltBkpAlqIcm := fltAlqIcm;
          fltBkpBasIcm := fltBasIcm;
          If  qryEntMer.FieldByName('BKP_BASICMS').AsFloat > 0 Then
          begin
            fltBkpAlqIcm := qryEntMer.FieldByName('BKP_ALQICMS').AsFloat;
            fltBkpBasIcm := qryEntMer.FieldByName('BKP_BASICMS').AsFloat;
          End;


          strCodFisInterna := fRetornaCodFisInterna(strEstEmp, qryEntMer.FieldByName('ENT_CODABF').AsString);
          fltAlqIcmInterna := fRetAliquotaInternaEstado_Entrada(strEstEmp, strUsaMatrizIcms );

          If (Pos(strCodFis, CST_TRIBUTADO) > 0) And (Pos(strCodFisInterna, CST_TRIBUTADO) > 0) And (fCfgSis('SIMPAU', varBoolean)) Then
          Begin
            qryGenTmp.ParamByName('ITETRI').AsString := 'S';
            fltDesAdb := ( (fltAlqIcmInterna - fltBkpAlqIcm ) * fltPerBas ) / 100;

            flValGnrTribut := RoundTo((fltBkpBasIcm *  fltDesAdb) / 100, -2);

            LMemCalGNRE := 'Valor GNRE = (Base ICMS do XML (' +
                                           FormatFloat('#,##0.00', fltBkpBasIcm) + ') * ' +
                                           '(Alíquota ICMS do Sistema (' + FormatFloat('#,##0.00', fltAlqIcmInterna) + ') - ' +
                                           'Alíquota ICMS da NF (' + FormatFloat('#,##0.00', fltBkpAlqIcm) + '))' +
                                           ' * %Redução de Base ST(' + FormatFloat('#,##0.00', fltPerBas) + ') / 100) / 100) = ' +
                                           FormatFloat('#,##0.00', flValGnrTribut);


            If fltDesAdb < 0 Then
            Begin
              fltDesAdb := 0;
              flValGnrTribut := 0;
            End;

          End Else
          Begin

            fltDesAdb := qryEntMer.FieldByName('ENT_DESADB').AsFloat;
            qryGenTmp.ParamByName('ITETRI').AsString := 'N';
          End;

          qryGenTmp.ParamByName('DESADB').AsFloat := fltDesAdb;
          qryGenTmp.ParamByName('VALADB').AsFloat := flValGnrTribut;

          If (Assigned(qryGenTmp.FindParam('CALGNR'))) And
              (qryEntMer.FieldByName('ENT_VALGNR').AsFloat <= 0) And
              (flValGnrTribut > 0) And
              (Not fEmptyStr(LMemCalGNRE)) Then
            qryGenTmp.ParamByName('CALGNR').AsString := LMemCalGNRE
          Else
            qryGenTmp.ParamByName('CALGNR').AsString := qryEntMer.FieldByName('ENT_CALGNR').AsString;
        End;

        qryGenTmp.ExecSQL;
        qryGenTmp.Close;
      End;

      FreeAndNil(qryGenTmp);

    end;

   Procedure pLeFreteEntrada;
   Begin
     qryFreEnt := fCriaQuery;
     With qryFreEnt, SQL Do
     Begin
       Add('SELECT SQL_NO_CACHE');
       Add('  AUTOINCREM, ');
       Add('  IFNULL(ENT_VALFRE, 0) AS ENT_VALFRE, ');
       Add('  IFNULL(ENT_DESACE, 0) AS ENT_DESACE  ');
       Add('FROM  ');
       Add('  TMP_ENTMER  ');
       Open;
     End;

     blnTemValorDesAceXML := fVerificaValorVOutroXML(strAutEle);
   End;

   Function fRetornaValorFrete(strAutInc: String): Double;
   Begin
     With qryFreEnt, SQL Do
     If Locate('AUTOINCREM', strAutInc, []) Then
       Result := FieldByName('ENT_VALFRE').AsFloat
     Else
       Result := 0;
   End;

   Function fRetornaDespAcessorias(strAutInc: String): Double;
   Begin
     With qryFreEnt, SQL Do
     If Locate('AUTOINCREM', strAutInc, []) Then
       Result := FieldByName('ENT_DESACE').AsFloat
     Else
       Result := 0;
   End;
{$Endregion}
begin
  strUsaMatrizIcms := fCfgSis('MATALI');
  blnNfe := Not fEmptyStr(strAutEle);
  SomaImpostoDeImportacao := fCfgSis('VRCSII', varBoolean);
  strConCla := fCfgSis('CONCLA');
  strConSub := fCfgSis('CONSUB');

  blnAtuPis := fCfgSis('ATUPIS', varBoolean) And fSeparaICMDesoneradoDoDesconto;

  blnIMPDIR  := fCfgSis('IMPDIR') = 'S';
  blnATUIPI  := fCfgSis('ATUIPI') = 'S';
  strECAIPI := fTransform(fCfgSis('ECAIPI'), 4);
  blnSimPau := (fCfgSis('SIMPAU', varBoolean)) and (fCfgSis('IGNSIM') = '1');
  blnSomaReforma := fSomarNovosImpostosDaReformaAoValorContabil;

  strEstEmp := fCadEmp('ESTADO');

  blnTemValorDesAceXML := False;

  pGetUltimosImpostos;

  qryFreEnt := Nil;

  pLeFreteEntrada;

  If fEmptyStr(strClaSub) Then
    strClaSub := fCfgSis('CLASUB');

  strAtuAdb := fCfgSis('ATUADB');

  If fltTotRet > 0 Then
    fltDifRetido := RoundTo(fltTotRet - fltTotRetOriginal, -2)
  Else
    fltDifRetido := 0;

  If (blnNfe Or blnPrecoPraticado) Then
    fltDifRetido := 0;

  strClaFisFalt := '';

  blnUsaLotePrecos := (fCfgSis('LOTPRE', varBoolean));

  If (blnDevolu) Or (blnConEqu) or blnRecCliGarantia Then
    strTipAbf := fGetTipoAbfCliente(strCodFor)
  Else
    strTipAbf := fGetTipoAbfFornecedor(strCodFor);

  fltTotIpi    := 0.0;
  fltToEIpi    := 0.0;

  fltTotFre    := 0.0;
  fltTotAce    := 0.0;
  fltTotDes    := 0.0;

  fltValPriIte := 0.0;
  fltVaEPriIte := 0.0;

  fltTotValRet := 0.0;
  fltToEValRet := 0.0;

  fltDesPisRestante := fltDesPis;

  strEmpEst          := fCadEmp('ESTADO');
  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));

  With qryEntMer Do
  Begin

    pgbDados.Position := 0;
    pgbDados.Visible  := True;
    pgbDados.Max      := RecordCount;

    First;

    fltTotIpiVal := fRetTotIte;

    fltIpiAcumulado := 0;
    fltRetAcumulado := 0;

    fltTotSer := fRetTotItemServ;
    strIteSer := fCfgSis('ITESER');
    strSerTer := fCfgSis('SERTER');

    blnUtiCadAbfIpi := fCfgSis('UTIABI', varBoolean);

    While Not Eof Do
    Begin
      If (Not fEmptyStr(FieldByName('ENT_CLAFIS').AsString))         And
         (Not fClaFisCadastrada(FieldByName('ENT_CLAFIS').AsString)) Then
      Begin
        strClaFisFalt := strClaFisFalt + FieldByName('ENT_CLAFIS').AsString + ',';
      End;

      if blnUtiCadAbfIpi then
        fltIpiSai :=  fAliquotaIpiSaidaProduto(FieldByName('ENT_CODITE').AsString)
      else
        fltIpiSai := fCampoTabela('ITE_IPISAI', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [FieldByName('ENT_CODITE').AsString, VS_StrCodEmp]);

      blnCreIpi := fCreditaIPI(blnContribuinteIPI,
                               FieldByName('ENT_CLAFIS').AsString,
                               strECAIPI,
                               FieldByName('ENT_IMPDIR').AsString = 'S',
                               blnIMPDIR,
                               fltIpiSai);
      {*****************************************}
      {* CALCULA PERCENTUAL CORRESPONDENTE DO  *}
      {* TOTAL                                 *}
      {**************************************MV*}
      If ((fltTotIte - fltTotSer) <> 0) and (FieldByName('ENT_CODITE').AsString <> strIteSer)
                                        And (FieldByName('ENT_CODITE').AsString <> strSerTer)
                                        And (FieldByName('ENT_TIPPRO').AsString <> TIPO_PRODUTO_SPED[9,0]) Then
        fltPerCor    := FieldByName('ENT_TOTITE').AsFloat / (fltTotIte - fltTotSer)
      Else If ((fltTotIte - fltTotSer) = 0) Then // Apenas item serviço
        fltPerCor    := FieldByName('ENT_TOTITE').AsFloat / (fltTotSer)
      Else
        fltPerCor    := 0;

      fltPerCorIPI := 0.0;

      If fltTotIpiVal <> 0 Then
      Begin

        If (FieldByName('ENT_PERIPI').AsFloat > 0) Then
          fltPerCorIPI := FieldByName('ENT_TOTITE').AsFloat / fltTotIpiVal;

      End;

      fltPerCorRet := 0.0;

      If SameText(strEspDoc, 'NF') Then
      Begin

        If (Pos(FieldByName('ENT_CODFIS').AsString, CST_SUBSTITUICAO) > 0) And
           (FieldByName('ENT_ANTPRO').AsString <> 'S') Then
        Begin

          If fltTotIteRet <> 0 Then
            fltPerCorRet := FieldByName('ENT_TOTITE').AsFloat / fltTotIteRet;

        End;

      End;

      {*****************************************}
      {* CALCULO DO FRETE                      *}
      {**************************************MV*}
      //SE ALGUM DIA DESCOMENTAR ISSO, VER NA GRAVAÇÃO QUE ESTÁ SOMANDO NO VLRCON
    (*  If blnPesFre Or blnnfe Then *)
        fltTmpFre := fRetornaValorFrete(FieldByName('AUTOINCREM').AsString);

     (*
      Else If (RecNo = RecordCount) Then
        fltTmpFre := fltValFre - fltTotFre
      Else
      Begin
        fltTmpFre := fFormataFloat(fltValFre * fltPerCor, 2);

        If fltTotFre + fltTmpFre > fltValFre Then
          fltTmpFre := fFormataFloat(fltValFre - fltTotFre, 2);

      End; *)

      fltTotFre := fltTotFre + fltTmpFre;

      {*****************************************}
      {* CALCULO DA DESPESA ACESSÓRIA          *}
      {**************************************MV*}
      //SE ALGUM DIA DESCOMENTAR ISSO, VER NA GRAVAÇÃO QUE ESTÁ SOMANDO NO VLRCON
      If blnNfe And blnTemValorDesAceXML Then
        fltTmpAce := fRetornaDespAcessorias(FieldByName('AUTOINCREM').AsString)
      Else If RecNo = RecordCount Then
        fltTmpAce := fltDesAce - fltTotAce
      Else
        fltTmpAce := fFormataFloat(fltDesAce * fltPerCor, 2);

      fltTotAce := fltTotAce + fltTmpAce;

      {*****************************************}
      {* CALCULO DO DESCONTO ESPECIAL          *}
      {**************************************MV*}
      If ((blnNfe and (Not blnCaixa2)) Or blnPrecoPraticado or blnRecCliGarantia)  Then
      Begin
        fltTmpDes := FieldByName('ENT_DESESP').AsFloat;
      End Else
      Begin
        If (fFormataFloat(fltDesEsp * fltPerCor, 2) + fltTotDes >= fltDesEsp) Or
           ((RecNo = RecordCount) and (FieldByName('ENT_CODITE').AsString <> strIteSer)
                                  And (FieldByName('ENT_CODITE').AsString <> strSerTer)
                                  And (FieldByName('ENT_TIPPRO').AsString <> TIPO_PRODUTO_SPED[9,0])) Then
          fltTmpDes := fltDesEsp - fltTotDes
        Else
          fltTmpDes := fFormataFloat(fltDesEsp * fltPerCor, 2);
      End;

      fltTotDes := fltTotDes + fltTmpDes;

      fltTmERet := 0;
      fltTmpRet := 0;

      {*****************************************}
      {* CALCULO TOTAL SUBSTITUICAO            *}
      {**************************************MV*}
      If ((fltTotRetOriginal <= 0) Or (fltDifRetido <> 0)) And
         (fltPerCorRet > 0) Then
      Begin

        If strClaSub = '1' Then
        Begin
          If qryEntMer.RecNo = intUltRet Then
            fltTmERet := fltTotRet - fltRetAcumulado
          Else
            fltTmERet := fFormataFloat(qryEntMer.FieldByName('ENT_VALRET').AsFloat +
                                       qryEntMer.FieldByName('ENT_VAERET').AsFloat +
                                       qryEntMer.FieldByName('ENT_TOTITE').AsFloat *
                                       (fltDifRetido / fltTotIteRet) , 2);

          If (fltTmERet < 0) Or (fltTotRet = 0) Then
            fltTmERet := 0;

          fltTmpRet       := 0;
          fltRetAcumulado := fltRetAcumulado + fltTmERet;
        End
        Else
        Begin
          If qryEntMer.RecNo = intUltRet Then
            fltTmpRet := fltTotRet - fltRetAcumulado
          Else
            fltTmpRet := fFormataFloat(qryEntMer.FieldByName('ENT_VALRET').AsFloat +
                                       qryEntMer.FieldByName('ENT_VAERET').AsFloat +
                                       qryEntMer.FieldByName('ENT_TOTITE').AsFloat *
                                       (fltDifRetido / fltTotIteRet) , 2);

          If (fltTmpRet < 0) Or (fltTotRet = 0) Then
            fltTmpRet := 0;

          fltTmERet       := 0;
          fltRetAcumulado := fltRetAcumulado + fltTmpRet;
        End;

      End
      Else If (FieldByName('ENT_ANTPRO').AsString <> 'S') Then
      Begin
        If strClaSub = '1' Then
        Begin
          If fltTotRet > 0 Then
            fltTmERet := qryEntMer.FieldByName('ENT_VAERET').AsFloat
          Else
            fltTmERet := 0;

          fltRetAcumulado := fltRetAcumulado + fltTmERet;
          fltTmpRet       := 0;
        End
        Else
        Begin
          If fltTotRet > 0 Then
            fltTmpRet := qryEntMer.FieldByName('ENT_VALRET').AsFloat
          Else
            fltTmpRet := 0;

          fltRetAcumulado := fltRetAcumulado + fltTmpRet;
          fltTmERet       := 0;
        End;
      End;

      If (FieldByName('ENT_ANTPRO').AsString <> 'S') Then
      Begin
        If strClaSub = '1' Then
          fltToEValRet := fltToEValRet + fltTmERet
        Else
          fltTotValRet := fltTotValRet + fltTmpRet;
      End Else
      Begin
        fltTmERet := 0;
        fltTmpRet := 0;
      End;

      fltBasIpi := 0;
      fltValIpi := 0;

      fltBaEIpi := 0;
      fltVaEIpi := 0;

      {*****************************************}
      {* GRAVA OS DADOS NA TABELA              *}
      {**************************************MV*}
      If (FieldByName('ENT_PERIPI').AsFloat > 0) Or (blnNfe Or blnPrecoPraticado) Then
      Begin

        If blnCreIpi Then
        Begin

          If (Not blnNfe) And (Not blnPrecoPraticado) Then
          Begin
            fltBasIpi := ( qryEntMer.FieldByName('ENT_BASIPI').AsFloat );

            If fltDifIpi <> 0 Then
              fltValIpi := fFormataFloat(( ( FieldByName('ENT_PERIPI').AsFloat / 100 ) * fltBasIpi ) + fFormataFloat(( fltPerCorIPI * fltDifIpi ),2),2)
            Else
              fltValIpi := FieldByName('ENT_VALIPI').AsFloat;

            If fltValIpi < 0 Then
              fltValIpi := 0;

            fltTotIpi := fltTotIpi + fltValIpi;
          End
          Else
          Begin
            fltBasIpi := ( qryEntMer.FieldByName('ENT_BASIPI').AsFloat );
            fltValIpi := fFormataFloat(qryEntMer.FieldByName('ENT_VALIPI').AsFloat + fFormataFloat(( fltPerCorIPI * fltDifIpi ),2),2);
            fltTotIpi := fltTotIpi + fltValIpi;
          End;

        End Else
        Begin

          If (Not blnNfe) And (Not blnPrecoPraticado) Then
          Begin
            fltBaEIpi := ( qryEntMer.FieldByName('ENT_BAEIPI').AsFloat );

            If fltDifIpi <> 0 Then
              fltVaEIpi := fFormataFloat(( ( FieldByName('ENT_PERIPI').AsFloat / 100 ) * fltBaEIpi ) + fFormataFloat(( fltPerCorIPI * fltDifIpi ),2),2)
            Else
              fltVaEIpi := FieldByName('ENT_VAEIPI').AsFloat;

            if fltVaEIpi < 0 Then
              fltVaEIpi := 0;

            fltToEIpi := fltToEIpi + fltVaEIpi;
          End Else
          Begin
            fltBaEIpi := ( qryEntMer.FieldByName('ENT_BAEIPI').AsFloat );
            fltVaEIpi := FieldByName('ENT_VAEIPI').AsFloat;
            fltToEIpi := fltToEIpi + fltVaEIpi;
          End;

        End;

      End;

      fltValIpiEdt := 0;

      If blnCreIpi Then
      Begin
        If fltDifIpi <> 0 Then
          fltValIpiEdt := fFormataFloat(fltEdtIpi * fltPerCorIPI, 2)
        Else
          fltValIpiEdt := FieldByName('ENT_VALIPI').AsFloat;

        fltValPriIte := fltValPriIte + fltValIpiEdt;
      End Else
      Begin
        If fltDifIpi <> 0 Then
          fltVaEIpiEdt := fFormataFloat(fltEdtIpi * fltPerCorIPI, 2)
        Else
          fltVaEIpiEdt := FieldByName('ENT_VAEIPI').AsFloat;

        fltVaEPriIte := fltVaEPriIte + fltVaEIpiEdt;
      End;
      fltVFCPST := FieldByName('ENT_VFCPST').AsFloat;
      fltVlrCon := (FieldByName('ENT_TOTITE').AsFloat + fltValIpi + fltTmpFre + fltTmpAce + fltTmpRet + fltValIpiEdt + fltTmERet + fltVFCPST) - IIf(blnDescIncond, 0, IIf(blnRecCliGarantia, 0,fltTmpDes));

      {*****************************************}
      {* CALCULA E ATUALIZA DADOS FISCAIS /    *}
      {* RATEIO.                               *}
      {**************************************MV*}
      pCalculaImpostosItens(True);

      Next;
      pgbDados.StepBy(1);

      Application.ProcessMessages;
    End;

    pgbDados.Visible := False;

    If Assigned(qryFreEnt) Then
      FreeAndNil(qryFreEnt);
  End;

  {*****************************************}
  {* JOGA NO PRIMEIRO REGISTRO A DIFERENÇA *}
  {* DO RATEIO.                            *}
  {**************************************MV*}
  fltTmpFre := 0.0;
  fltTmpAce := 0.0;
  fltTmpDes := 0.0;
  fltTmpRet := 0.0;

  fltTmERet := 0.0;

  If (fltTotFre <> fltValFre) Then
    fltTmpFre := fltValFre - fltTotFre;

  If (fltTotAce <> fltDesAce) Then
    fltTmpAce := fltDesAce - fltTotAce;

  If (fltTotDes <> fltDesEsp) Then
      fltTmpDes := fltDesEsp - fltTotDes;

  If SameText(strEspDoc, 'NF') And (fltTotValRet <> fltTotRet) And (strClaSub <> '1') Then
    fltTmpRet := RoundTo(fltTotRet - fltTotValRet, -2);

  If SameText(strEspDoc, 'NF') And (fFormataFloat(fltToEValRet,2) <> fFormataFloat(fltTotRet,2)) And
     (strClaSub = '1') Then
    fltTmERet := fFormataFloat(fltTotRet - fltToEValRet,2);

  If (RoundTo(fltTmpFre, -2) <> 0) Or
     (RoundTo(fltTmpAce, -2) <> 0) Or
     (RoundTo(fltTmpDes, -2) <> 0) Or
     (RoundTo(fltTmpRet, -2) <> 0) Or
     (RoundTo(fltTmERet, -2) <> 0) Then
  Begin

    With qryEntMer Do
    Begin

      {*****************************************}
      {* PEGA VALORES DO PRIMEIRO REGISTRO E   *}
      {* ATUALIZA DIFERENÇA NOS CAMPOS ABAIXO. *}
      {**************************************MV*}
      Close;
      SQL.Clear;
      SQL.Add('SELECT '      );
      SQL.Add('  * '         );
      SQL.Add('FROM '        );
      SQL.Add('  TMP_ENTMER ');

      If fltTotIteRet <> 0 Then
        SQL.Add(' WHERE LOCATE(ENT_CODFIS, ' + QuotedStr(CST_SUBSTITUICAO) + ') > 0');

      If fltTmpDes <> 0 Then
      Begin
        SQL.Add( IfThen(fltTotIteRet <> 0, ' AND ', 'WHERE '));
        SQL.Add( '  ENT_CODITE <> "' + fCfgSis('ITESER') + '"');
        SQL.Add( '  AND ENT_CODITE <> "' + fCfgSis('SERTER') + '"');
        SQL.Add( '  AND ENT_TIPPRO <> "' +  TIPO_PRODUTO_SPED[9,0] + '"');

      End;

      SQL.Add('LIMIT 1 '     );

      Open;

      fltTotIpiVal := fRetTotIte;

      // POR CAUSA DO PCALCULA IMPOSTOS ABAIXO
      If fltTotIpiVal <> 0 Then
      Begin
        If (FieldByName('ENT_PERIPI').AsFloat > 0) Then
          fltPerCorIPI := FieldByName('ENT_TOTITE').AsFloat / fltTotIpiVal
        Else
          fltPerCorIPI := 0.0;
      End;

      fltVlrCon := qryEntMer.FieldByName('ENT_VLRCON').AsFloat +
                   (fltTmpFre + fltTmpAce + fltTmpRet + fltTmERet - fltTmpDes) ;

      fltTmpFre := fltTmpFre + qryEntMer.FieldByName('ENT_VALFRE').AsFloat;
      fltTmpAce := fltTmpAce + qryEntMer.FieldByName('ENT_DESACE').AsFloat;
      fltTmpDes := fltTmpDes + qryEntMer.FieldByName('ENT_DESESP').AsFloat;
      fltTmpRet := fltTmpRet + qryEntMer.FieldByName('ENT_VALRET').AsFloat;
      fltTmERet := fltTmERet + qryEntMer.FieldByName('ENT_VAERET').AsFloat;

      {*****************************************}
      {* CALCULA PERCENTUAL CORRESPONDENTE DO  *}
      {* TOTAL                                 *}
      {**************************************MV*}
      If fltTotIpiVal <> 0 Then
      Begin
        If (FieldByName('ENT_PERIPI').AsFloat > 0) Then
          fltPerCorIPI := FieldByName('ENT_TOTITE').AsFloat / fltTotIpiVal
        Else
          fltPerCorIPI := 0.0;
      End;

      pCalculaImpostosItens(False);
    End;

  End;

  If (Not fEmptyStr(strClaFisFalt)) Then
  Begin
    strClaFisFalt := Copy(strClaFisFalt, 1, Length(strClaFisFalt)-1);
    Raise Exception.Create('As CFOPs: ' + strClaFisFalt + ' não estão cadastradas!' + #13#10 +
      'Favor cadastrá-las.');
  End;

end;



function fCreditaIPI(blnContribuinteIPI: Boolean;
                     strCfoEnt: String;
                     CfgECAIPI: String;
                     blnIteIMPDIR: Boolean;
                     cfgIMPDIR: Boolean;
                     fltIpiSai: Double): Boolean;

Begin
  Result := False;
  If (Not blnContribuinteIPI) And
     (cfgIMPDIR) And
     (Pos(strCfoEnt , CfgECAIPI) > 0) And
     (blnIteIMPDIR) And
     (fltIpiSai > 0) Then
    Exit(True);

  If blnContribuinteIPI And
     (Pos(strCfoEnt , CfgECAIPI) > 0) Then
   Exit(True);
End;


{*****************************************}
{* RETORNA O TOTAL DOS ITENS DA ENTRADA  *}
{* DE MERCADORIAS QUE TEM CODIGO FISCAL  *}
{* IGUAL A "060" OR "010" OR 160 OR 260  *}
{*      OR "110" OR "210"                *}
{**************************************MV*}
function fRetornaTotIteRet: Double;
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;

begin
  Try
    qryGenMer := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(ENT_TOTITE) AS TOTITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  LOCATE(ENT_CODFIS, ' + QuotedStr(CST_SUBSTITUICAO) + ') > 0 ';

    With qryGenMer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := FieldByName('TOTITE').AsCurrency;
      Close;

    End;

  Finally
    FreeAndNil(qryGenMer);
  End;

end;

Procedure pConverteClaFisNFE(strI08CFO, strEmpEst, strEstFor: String; blnNotaImp, blnSubstiuido, blnPresencial: Boolean; Var strClaFis: String);
  Var
    blnSubstituiu: Boolean;
    strClaEnt: String;
Begin
  If Not fEmptyStr(strI08CFO) Then
  Begin
    If blnSubstiuido then
      strClaEnt := fCampoTabela('CEM_CLASUB', 'CFOCEM', ['CEM_CODCFO', 'CEM_CODEMP'], [strI08CFO, VS_strCodEmp])
    Else
      strClaEnt := fCampoTabela('CEM_CLAENT', 'CFOCEM', ['CEM_CODCFO', 'CEM_CODEMP'], [strI08CFO, VS_strCodEmp]);

    If fEmptyStr(strClaEnt) Then
    Begin
      If blnSubstiuido then
        strClaEnt := fCampoTabela('CFO_CLASUB', 'CADCFO', ['CFO_CODCFO'], [strI08CFO])
      Else
        strClaEnt := fCampoTabela('CFO_CLAENT', 'CADCFO', ['CFO_CODCFO'], [strI08CFO]);
    End;

    If Not fEmptyStr(strClaEnt) Then
    Begin
      strClaFis := strClaEnt;
    End Else
    Begin

      If (strI08CFO = '5109') Or ((strI08CFO = '6109') And  blnPresencial) Then
      Begin

        If blnSubstiuido then
          strI08CFO     := '1403'
        Else
          strI08CFO     := '1102';

        blnSubstituiu := True;
      End

      Else If (strI08CFO = '6109') Then
      Begin

        If blnSubstiuido then
          strI08CFO     := '2403'
        Else
          strI08CFO     := '2102';

        blnSubstituiu := True;

      End

      {CFOP 5949/6949}
      Else If ((strI08CFO = '5949') Or (strI08CFO = '6949')) Then
      Begin
        If (strEstFor = strEmpEst) Or blnPresencial Then
          strI08CFO := '1' +  RightStr(strI08CFO, 3)
        Else
          strI08CFO := '2' +  RightStr(strI08CFO, 3);

        blnSubstituiu := True;
  	  End

      Else If blnSubstiuido Then
      Begin

        If Pos(strI08CFO, '5405_6404_5403_6403_') > 0 Then
        Begin
          strI08CFO     := '1403';
          blnSubstituiu := True;
        End Else
        Begin
          blnSubstituiu := False;
        End;

        strI08CFO := RightStr(strI08CFO, 3);

        If blnNotaImp Then
          strI08CFO := '3' + strI08CFO

        Else If (strEstFor = strEmpEst) Or blnPresencial Then
          strI08CFO := '1' + strI08CFO

        Else
          strI08CFO := '2' + strI08CFO;

      End

      Else
      Begin
        strI08CFO := strClaFis;
        blnSubstituiu := False;
      End;

      If (Pos(strI08CFO, VS_strClaCom) <= 0) Or blnSubstituiu Then
        strClaFis := strI08CFO;

      If pos(strClaFis, '_1105_2105_2106_1106') > 0 Then
        strClafis := strClafis[1] + '102'

    End;

  End;
End;

function fRetornaDadosFiscais(    strEmpEst: String;
                                  blnContribuinteIPI,
                                  blnTemAntIcm: Boolean;
                                  strCodAbf: String;
                                  fltTotIte,
                                  fltAlqFor: Double;
                                  strEstFor,
                                  strCodFor: String;
                                  blnItemRevenda: Boolean;
                              Var strClaFis,
                                  strCodFis: String;
                              Var fltBasIcm,
                                  fltAlqIcm,
                                  fltAlqIcmRed,
                                  fltValIcm,
                                  fltPerBas,
                                  fltPeBaST,
                                  fltAliSte,
                                  fltAliFCP: Double;
                              var blnRedCargaMedia: Boolean;
                                  blnDevolu: Boolean;
                                  blnEntMer: Boolean = False;
                                  blnGarant: Boolean = False;
                                  blnRecCliGarantia: Boolean = False;
                                  blnNotaImp : Boolean = False;
                                  strI08CFO: String = '';
                                  blnConEqu: Boolean = False;
                                  blnPresencial: Boolean = False;
                                  cdsAbfIcm: TUniClientDataSet = Nil;
                                  blnAcessadoViaRetornoConsignacao : Boolean = False;
                                  blnLumbrificante: Boolean = False;
                                  blnDevolucaoEntradaEmitidaFornecedor: Boolean = False): boolean;
  Var
    strSQL: String;
    strTipFor,
    strTipAbf: String;
    blnForFil: Boolean;
    qryGenAbf: TUniQuery;
    intInd   : Integer;
    blnEMCPRC: Boolean;
    strCleTtr : String;
begin
  Try

    Result    := True;
    blnForFil := False;
    fltPerBas := 0.0;
    fltPeBaST := 0.0;
    fltAlqIcmRed := 0.0;


    blnEMCPRC := fCfgSis('EMCPRC') = 'S';
    strCleTtr := fCfgSis('CLETTR', varString);

    qryGenAbf := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ABFICM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ABF_CODABF = :CODABF AND ';
    strSQL := strSQL + '  ABF_ESTADO = :ESTADO ';

    Try
      If Not Assigned(cdsAbfIcm) Then
      Begin
        With qryGenAbf Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODABF').AsString := strCodAbf;
          ParamByName('ESTADO').AsString := strEstFor;
          Open;

          strTipFor := '';

          If (blnDevolu) or (blnRecCliGarantia) Then
            strTipAbf := fGetTipoAbfCliente(strCodFor)
          Else
            strTipAbf := fGetTipoAbfFornecedor(strCodFor, strTipFor);

          {*****************************************}
          {* PEGA PERCENTUAL E ALIQUOTA DA ABREVI- *}
          {* AÇÃO FISCAL                           *}
          {**************************************MV*}
          fltPerBas := FieldByName('ABF_BASICM' + strTipAbf).AsFloat;
          fltAlqIcm := FieldByName('ABF_ALQICM' + strTipAbf).AsFloat;
          fltPeBaST := FieldByName('ABF_BASRET' + strTipAbf).AsFloat;
          fltAliSte := FieldByName('ABF_ALQRET' + strTipAbf).AsFloat;
          fltAliFCP := FieldByName('ABF_ALQFCP' + strTipAbf).AsFloat;

          blnRedCargaMedia := False;
          If pos('_ENT', strTipAbf) > 0 Then
            blnRedCargaMedia := FieldByName('ABF_ALQCLI' + strTipAbf).AsInteger = 1;

          If (strTipAbf = '_ENT_PES') Or (strTipAbf = '_ENT_PEF') Or
             (strTipAbf = '_ENT_PER') Or (strTipAbf = '_ENT_PEJ') Then
          If qryGenAbf.FieldByName('ABF_RICMPR' + strTipAbf).AsString = 'S' Then
          fltAlqIcmRed := fltAlqIcm - ((fltAlqIcm * CONST_PERCENTUAL_DIFERIMENTO_RICMS)/100)
        Else
        Begin
          if( qryGenAbf.FieldByName('ABF_ALQRIC' + strTipAbf).AsFloat > 0 ) AND (fCfgSis('RICMAP',varBoolean)) Then
            fltAlqIcmRed := fltAlqIcm - ((fltAlqIcm * (qryGenAbf.FieldByName('ABF_ALQRIC' + strTipAbf).AsFloat) )/100);
        End;

        {*****************************************}
        {* PEGA CÓDIGO FISCAL DO ITEM            *}
          {**************************************MV*}
          strCodFis := FieldByName('ABF_CODSIT' + strTipAbf).AsString;

          {*****************************************}
          {* FECHA A TABELA                        *}
          {**************************************MV*}
          Close;

        End;

      End
      Else
      Begin

        with cdsAbfIcm Do
        begin
        strTipFor := '';

        If (blnDevolu) or (blnRecCliGarantia) Then
          strTipAbf := fGetTipoAbfCliente(strCodFor)
        Else
          strTipAbf := fGetTipoAbfFornecedor(strCodFor, strTipFor);

        {*****************************************}
        {* PEGA PERCENTUAL E ALIQUOTA DA ABREVI- *}
        {* AÇÃO FISCAL                           *}
        {**************************************MV*}
        fltPerBas := FieldByName('ABF_BASICM' + strTipAbf).AsFloat;
        fltAlqIcm := FieldByName('ABF_ALQICM' + strTipAbf).AsFloat;
        fltPeBaST := FieldByName('ABF_BASRET' + strTipAbf).AsFloat;
        fltAliSte := FieldByName('ABF_ALQRET' + strTipAbf).AsFloat;
        fltAliFCP := FieldByName('ABF_ALQFCP' + strTipAbf).AsFloat;
        If (strTipAbf = '_ENT_PES') Or (strTipAbf = '_ENT_PEF') Or
           (strTipAbf = '_ENT_PER') Or (strTipAbf = '_ENT_PEJ') Then
        If cdsAbfIcm.FieldByName('ABF_RICMPR' + strTipAbf).AsString = 'S' Then
          fltAlqIcmRed := fltAlqIcm - ((fltAlqIcm * CONST_PERCENTUAL_DIFERIMENTO_RICMS)/100);

        {*****************************************}
        {* PEGA CÓDIGO FISCAL DO ITEM            *}
        {**************************************MV*}
        strCodFis := FieldByName('ABF_CODSIT' + strTipAbf).AsString;
        end;
      End;

    Except
      On E: Exception Do
      Begin

        pMensagensErro(E.Message, '[fRetornaDadosFiscais]');
        Result := False;

      End;
    End;

    If (Result) Then
    Begin

      {****************************************}
      { VERIFICA CLIFIL SOMENTE SE FOR ENTRADA }
      {*************************************JB*}
      If (Not blnDevolu) Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  EMP_CLATE1, ';
        strSQL := strSQL + '  EMP_CLATE2, ';
        strSQL := strSQL + '  EMP_CLATE3, ';
        strSQL := strSQL + '  EMP_CLTEV1, ';
        strSQL := strSQL + '  EMP_CLTEV2, ';
        strSQL := strSQL + '  EMP_CLTEV3, ';
        strSQL := strSQL + '  (SELECT CON_TIPOPE FROM CONEMP ';
        strSQL := strSQL + '                    WHERE CON_EMPORI = (SELECT EMP_CODEMP FROM CADEMP WHERE EMP_FORFIL = ' + QuotedStr(strCodFor) + ' LIMIT 1) ';
        strSQL := strSQL + '                          AND CON_EMPDES = ' + QuotedStr(VS_strCodEmp) + ') AS TIPOPE ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADEMP ';
        strSQL := strSQL + 'WHERE ';
        If strCleTtr = '1' Then
          strSQL := strSQL + '  EMP_FORFIL = :CODFOR '
        Else
          strSQL := strSQL + '  EMP_CODEMP = :EMPORI ';

        With qryGenAbf Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          If strCleTtr = '1' Then
            ParamByName('CODFOR').AsString := strCodFor
          Else
            ParamByName('EMPORI').AsString := VS_strCodEmp;
          Open;

          blnForFil := fFornecedorFilial(strCodFor);

          If (FieldByName('TIPOPE').AsString = '2') Then
          Begin
            If (Pos(strCodFis, CST_SUBSTITUICAO) > 0) Then
            Begin
              strClaFis := FieldByName('EMP_CLATE2').AsString;
              If blnLumbrificante Then
                strClaFis := FieldByName('EMP_CLATE3').AsString;
            End
            Else
              strClaFis := FieldByName('EMP_CLATE1').AsString;
          End
          Else
          Begin
            If (Pos(strCodFis, CST_SUBSTITUICAO) > 0) Then
            Begin
              strClaFis := FieldByName('EMP_CLTEV2').AsString;
              If blnLumbrificante Then
                strClaFis := FieldByName('EMP_CLTEV3').AsString;
            End
            Else
              strClaFis := FieldByName('EMP_CLTEV1').AsString;
          End;

          If Not fEmptyStr(strClaFis) Then
          Begin
            strClaFis := IIF(strEstFor = fCadEmp('ESTADO'), '1', '2') + RightStr(strClaFis, 3);
          End;

          Close;
        End;

      End;

      {*****************************************}
      {* PEGA CLASSIFICAÇÃO FISCAL             *}
      {**************************************MV*}
      If (Not blnForFil) Then
      Begin
        If ((strEstFor = strEmpEst) Or blnPresencial) Then
        Begin

          If (Pos(strCodFis, CST_SUBSTITUICAO) > 0) And (Not blnNotaImp) Then
          Begin
            strClaFis := IIF(blnDevolu, '1411', '1403');
          End
          Else
          Begin
            strClaFis := IIF(blnDevolu, '1202', '1102');
            If blnContribuinteIPI And ((Not blnEMCPRC) Or (blnEMCPRC And (Not blnItemRevenda))) Then
              strClaFis := IIF(blnDevolu, '1201', '1101');
          End;

        End
        Else
        Begin

          If (Pos(strCodFis, CST_SUBSTITUICAO) > 0) And (Not blnNotaImp)Then
          Begin
            strClaFis := IIF(blnDevolu, '2411', '2403');
          End
          Else
          Begin
            strClaFis := IIF(blnDevolu, '2202', '2102');

            If blnContribuinteIPI And ((Not blnEMCPRC) Or (blnEMCPRC And (Not blnItemRevenda))) Then
              strClaFis := IIF(blnDevolu, '2201', '2101');
          End;

        End;

      End
      Else
      Begin
        {******************************************}
        {* VERIFICA SE ESTÁ NO ARRAY DE EXCESSÕES *}
        {***************************************RV*}
        For intInd := 0 To Length(arrClaSai) - 1 Do
        Begin
          If (arrClaSai[intInd] = strClaFis) Then
            strClaFis := arrClaEnt[intInd];
        End;

        If (strEstFor = strEmpEst) Or blnPresencial Then
          strClaFis := '1' + RightStr(strClaFis, 3)
        Else
          strClaFis := '2' + RightStr(strClaFis, 3);

      End;

      If blnEntMer And blnTemAntIcm {(Pos(strCodFis, CST_ANTECIPACAO_ICMS) > 0)} And
         (Not blnDevolu) And (Not blnForFil) And fTemAntecipacaoIcms Then
      Begin
        If (strEstFor = strEmpEst) Or blnPresencial Then
          strClaFis := '1102'
        Else
          strClaFis := '2102';
      End;

      If blnRecCliGarantia Then
        strClaFis := IIF(SameText(fRetEstadoCliente(strCodFor), fCadEmp('ESTADO')), '1', '2') + LeftStr(fCfgSis('CRECGC'),3);

      If blnConEqu Then
        strClaFis := IIF(SameText(fRetEstadoCliente(strCodFor), fCadEmp('ESTADO')), '1', '2') + Copy(fCfgSis('CLACON'), 2, 3);

      if blnNotaImp Then
        strClaFis := '3' + RightStr(strClaFis, 3);

      fltBasIcm := fFormataFloat((fltTotIte * fltPerBas) / 100, 2);
      If fltAlqIcmRed > 0 Then
        fltValIcm := fFormataFloat(fltBasIcm * (fltAlqIcmRed / 100), 2)
      Else
        fltValIcm := fFormataFloat(fltBasIcm * (fltAlqIcm / 100), 2);

      if blnAcessadoViaRetornoConsignacao then
        strClaFis := IIF(SameText(strEmpEst, strEstFor), '1', '2') + RightStr(fCfgSis('RETCON'),3);
    End;


    If blnDevolucaoEntradaEmitidaFornecedor Then
    begin
      If (strEstFor = strEmpEst) Or blnPresencial Then
        strClaFis := '5202'
      Else
        strClaFis := '6202';
    End
    Else If (strTipFor = 'M') Then
    Begin

      If Not fEmptyStr(strCodFis) Then
        strCodFis := strCodFis[1] + '90';
    End
    Else If Not fFornecedorFilial(strCodFor) Then
      pConverteClaFisNFE(strI08CFO, strEmpEst, strEstFor, blnNotaImp, (Pos(strCodFis, CST_SUBSTITUICAO) > 0), blnPresencial, strClaFis);


  Finally
    FreeAndNil(qryGenAbf);
  End;

end;

function fValorTabelaCFOPEntrada(strClaFis, strCST, strTipPro: String; var strClaFisOut: String): Boolean;
var qryConsulta: TUniQuery;
begin
  Result := False;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT CFO_RECFOP FROM  ENTCFO');
    qryConsulta.SQL.Add('WHERE CFO_CLAFIS = :CLAFIS');
    qryConsulta.SQL.Add('  AND CFO_CODCST = :CODCST');
    qryConsulta.SQL.Add('  AND CFO_TIPPRO = :TIPPRO');

    qryConsulta.ParamByName('CLAFIS').AsString := RightStr(strClaFis, 3);
    qryConsulta.ParamByName('CODCST').AsString := RightStr(strCST, 2);
    qryConsulta.ParamByName('TIPPRO').AsString := strTipPro;

    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      strClaFisOut := strClaFisOut[1] + qryConsulta.FieldByName('CFO_RECFOP').AsString;
      Result := True;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

End;

function fRetornaValorOutras(fltVlrCon, fltBasIcm, fltValIpi, fltValRet, fltVleRet, fltVleIpi, fltVFCPST: Double): Double;
begin

  Result := fFormataFloat(fltVlrCon - (fltBasIcm + fltValIpi + fltValRet + fltVleRet + fltVleIpi + fltVFCPST), 2);
  If Result <= 0.0 Then
    Result := 0.0;

end;

function fRetornaAlqFor(strEstFor, strIesFor: String; strEstEmp: String = ''): Double;
begin
  If strEstEmp = '' Then
    strEstEmp := fCadEmp('ESTADO');

  If (strEstFor = strEstEmp) Then
  Begin
    Result := 18;
    If (strEstFor = 'RS') Then
      Result := 17;
  End
  Else If (Pos(strEstFor, 'PR_RJ_MG_RS_SC_SP_ES_') > 0) Then
  Begin
    Result := 12;
  End
  Else
  Begin
    Result := 07;
  End;

  If (fEmptyStr(strIesFor)) And (strEstFor <> strEstEmp) Then
    Result := 18;

end;

{*****************************************}
{* CARREGA TODOS OS ITENS DE UMA DETER-  *}
{* MINADA EMPRESA                        *}
{**************************************MV*}
procedure pCarregaItens(strCodEmp: String; Var qryCadIte: TUniQuery; fltCotDol: Double);
  Var
    strSQL: String;
    strCodigos: String;
    intRecordCount: Integer;

begin

  strSQL := strSQL + '    SELECT ';
  strSQL := strSQL + '      DISTINCT ENT_CODITE ';
  strSQL := strSQL + '    FROM ';
  strSQL := strSQL + '      TMP_ENTMER ';

  With qryCadIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    intRecordCount := RecordCount;

    While Not Eof Do
    Begin

      strCodigos := strCodigos + QuotedStr(FieldByName('ENT_CODITE').AsString);
      If RecNo <> intRecordCount Then
        strCodigos := strCodigos + ', ';

      Next;

    End;

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_INCPIS, ';
  strSQL := strSQL + '  I.ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_CODMAR, ';
  strSQL := strSQL + '  I.ITE_EMBALA, ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_CODUNI, ';
  strSQL := strSQL + '  I.ITE_CESBAS, ';
  strSQL := strSQL + '  G.ITE_PREDOL, ';
  strSQL := strSQL + '  G.ITE_FORULT, ';
  strSQL := strSQL + '  G.ITE_NOTULT, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06, ';
  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_VALFRE, ';
  strSQL := strSQL + '  G.ITE_ACRFIN, ';
  strSQL := strSQL + '  G.ITE_SUBSTI, ';
  strSQL := strSQL + '  G.ITE_DESADB, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_MARBR1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_MARBR2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_MARBR3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_MARBR4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_MARBR5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_MARBR6, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';
  strSQL := strSQL + '  G.ITE_MARBR7, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';

  strSQL := strSQL + '  IF(G.ITE_PREDOL = "S", ROUND(G.ITE_PRECOM * :COTDOL, :DECUNI), G.ITE_PRECOM) AS ITE_PRECOM, ';

  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';

  strSQL := strSQL + '  G.ITE_TCIFCU, ';
  strSQL := strSQL + '  G.ITE_TSCUST, ';
  strSQL := strSQL + '  G.ITE_USAPPF, ';

  strSQL := strSQL + '  GC.GRU_OPERES AS ITE_OPERES, ';
  strSQL := strSQL + '  (SELECT  MAX(MOVDET.AUTOINCREM) ';
  strSQL := strSQL + '     FROM MOVDET ';
  strSQL := strSQL + '  WHERE DET_NUMDOC = TRIM(SUBSTRING(ITE_NOTULT,1,12)) ';
  strSQL := strSQL + '   AND DET_ESPDOC = TRIM(SUBSTRING(ITE_NOTULT,13,2)) ';
  strSQL := strSQL + '   AND DET_SERIE_ = TRIM(SUBSTRING(ITE_NOTULT,18,3)) ';
  strSQL := strSQL + '   AND DET_CODFOR = TRIM(SUBSTRING(ITE_NOTULT,21,28)) ';
  strSQL := strSQL + '   AND DET_CODEMP = TRIM(SUBSTRING(ITE_NOTULT,15,3)) ';
  strSQL := strSQL + '   AND  DET_CODITE = G.ITE_CODITE ) AS ITE_SEQDET  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN GRU_COMPRA GC ON I.ITE_GRUCMP = GC.GRU_CODIGO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  I.ITE_CODITE IN ( ' + strCodigos + ' ) ';

  With qryCadIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If fltCotDol = 0 Then
      fltCotDol := 1;

    ParamByName('COTDOL').AsFloat   := fltCotDol;
    ParamByName('DECUNI').AsInteger := fCfgSis('DECUNI', varInteger);
    ParamByName('CODEMP').AsString  := strCodEmp;
    Open;

  End;

end;

function fClienteFilialCadastrado(strCodCli, strCodEmp: String): Boolean;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try
    Result := False;

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CLIFIL = :CODCLI AND ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;

      Close;
    End;
  Finally
    FreeAndNil(qryGenEmp);
  End;
end;

function fFornecedorFilialCadastrado(strCodFor, strCodEmp: String): Boolean;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try
    Result := False;

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_FORFIL =  :CODFOR AND ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;

      Close;
    End;
  Finally
    FreeAndNil(qryGenEmp);
  End;
end;

{********************************************}
{* RETORNA A SENHA PARA LIBERACAO DE BLO-   *}
{* QUEIO DE CLIENTES                        *}
{*****************************************WI*}
Function fRetornaSenCli( intNumero: Integer ): String;
  Var
    intNumSenha : Int64;
Begin

  intNumSenha := StrToIntDef(RightStr(IntToStr(YearOf(VS_Date)),02), 0);
  intNumSenha := intNumSenha * DayOf(VS_Date);
  intNumSenha := intNumSenha * intNumero;
  intNumSenha := intNumSenha * 99999999;
  intNumSenha := intNumSenha * MonthOf(VS_Date);

  Result := Trim(IntToStr(intNumSenha));
  Result := RightStr( Result, 07 );

End;

{*****************************************}
{* RETORNA A SENHA DO OPERADOR JA DESCRI-*}
{* PTOGRAFADO                            *}
{**************************************MV*}
function fRetSenOperador(strCodOpe: String): String;
  Var
    strSQL   : String;
    qryGenOpe: TUniQuery;

begin
  Try

    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  OPE_SENOPE AS SENOPE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODOPE = :CODOPE ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;
      Result := fDecrypt(FieldByName('SENOPE').AsString);
      Close;

    End;

  Finally
    FreeAndNil(qryGenOpe);
  End;

end;

{*****************************************}
{* RETORNA SE É CLIENTE FILIAL           *}
{**************************************MV*}
function fClienteFilial(strCodCli: String; Conexao: TUniConnection = Nil): Boolean;
begin

  Result := False;

  If fEmptyStr(strCodCli) Then
    Exit;

  Result := (Not fEmptyStr(strCodCli)) And
            (fCampoTabela('COUNT(*)', 'CADEMP', ['EMP_CLIFIL'], [strCodCli], False, '', Conexao) > 0);

end;

function fClienteFilial(strCodCli: String; Var strCodEmp: String; Conexao: TUniConnection = Nil): Boolean;
begin
  strCodEmp := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CLIFIL'], [strCodCli], False, '', Conexao);

  Result := (Not fEmptyStr(strCodCli)) And (Not fEmptyStr(strCodEmp));
end;

procedure pZapTable(strNomeTabela: String);
  Var
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM ' + strNomeTabela);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure pGeraGiroEstoqueDiario(dtaDtaTmp: TDateTime; blnAutoGiro: Boolean = False);
begin

  Try
    pCriarFormularios(TfrmFecGiroEstoque, frmFecGiroEstoque);
    frmFecGiroEstoque.blnGerarAutomatico := True;
    frmFecGiroEstoque.blnAutoGiro        := blnAutoGiro;
    frmFecGiroEstoque.dtaDtaTmp := dtaDtaTmp;
    frmFecGiroEstoque.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGeraGiroEstoqueDiario]');
    End;
  End;
  pFreeAndNil(frmFecGiroEstoque);

end;

procedure pFinalizaModulos;
begin

//

end;

{**********************************************}
{* RETORNA A POSIÇÃO DA 'intColuna' LINHA DE  *}
{* UMA STRING SEPARADA POR 'strDelimitador'   *}
{*******************************************MV*}
function fGetPosLinha(strLinha, strDelimitador: String; intColuna: Integer): Integer;
  Var
    intContador: Integer;
    intContDel: Integer;
    intQtdCol: Integer;
begin

  intQtdCol := 0;

  intContador := 1;
  intContDel  := 1;

  While (intContDel < intColuna) Do
  Begin

    If (strLinha[intContador] = strDelimitador) Then
    Begin
      Inc(intQtdCol);
    End;
    Inc(intContador);

    If (intQtdCol = intColuna) Then
    Begin
      Break;
    End;

  End;

  Result := intContador;

end;

function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;
  Var
    iniArqIni: TIniFile;
Begin
  iniArqIni := TIniFile.Create(strPath + '\opcoes.ini');
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;

End;

function fRetNomUnidadePorSig(strUnidad: String): String;
  Var
    strSQL   : String;
    qryGenUni: TUniQuery;

Begin
  Try

    qryGenUni := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADUNI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  UNI_SIGUNI = :UNIDAD ';

    With qryGenUni Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('UNIDAD').AsString := strUnidad;

      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('UNI_DESUNI').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenUni);
  End;

End;

function fVerificaEmpresaRecebimento(strCodEmp, strEspDoc: String): Boolean;
begin
  Result := True;
  If (Pos(strEspDoc, 'MI_FF_') > 0) Then
  Begin
    If (strCodEmp <> VS_strCodEmp) Then
    Begin
      Result := False;
    End;
  End;
End;

{**********************************************}
{* RETORNA O NOME DO PROFISSIONAL SELECIONADO *}
{*******************************************LB*}
function fRetNomProfissional(Const strCodPro: String): String;
  Var
    strSQL   : String;
    qryGenDiv: TUniQuery;

Begin
  Try
    qryGenDiv := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADDIV ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DIV_CODDIV = :CODDIV ';

    With qryGenDiv Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODDIV').AsString := strCodPro;
      Open;
      If Not IsEmpty Then
        Result := FieldByName('DIV_NOMDIV').AsString
      Else
        Result := '';
      Close;
    End;

  Finally
    FreeAndNil(qryGenDiv);
  End;

End;

{************************************************************************}
{* RETORNA O CLIENTE ATRELADO AO PROFISSIONAL PELO CADASTRO DE DIVERSOS *}
{*********************************************************************JL*}
function fRetCliProfissional(Const strCodPro: String): String;
  Var
    strSQL   : String;
    qryGenDiv: TUniQuery;

Begin
  Try
    qryGenDiv := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' DIV_CODCLI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' CADDIV ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' DIV_CODDIV = :CODDIV ';

    With qryGenDiv Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODDIV').AsString := strCodPro;
      Open;
      If Not IsEmpty Then
        Result := FieldByName('DIV_CODCLI').AsString
      Else
        Result := '';
      Close;
    End;

  Finally
    FreeAndNil(qryGenDiv);
  End;

End;

{***************************************}
{* RETORNA O CPF OU CGC DE DETERMINADO *}
{* CLIENTE                             *}
{************************************AF*}
function fRetCgcCpf(strCodCli: String): String;
  Var
    strSQL   : String;
    qryGenCli: TUniQuery;

Begin
  Try

    qryGenCli := fCriaQuery;

    Result := '';
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CLI_C_G_C_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      Result := FieldByName('CLI_C_G_C_').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

End;

{********************************************}
{* VERIFICA SE O PATH PASSADO POR PARAMETRO *}
{* ESTA NA FORMA CORRETA, CASO CONTRARIO    *}
{* CORRIGE                                  *}
{*****************************************AF*}
function fVerBarraFinal(strPath: String): String;
Begin
  Result := Trim(strPath);

  If RightStr(Trim(strPath),1) <> '\' Then
  Begin
    Result := Trim(strPath) + '\';
  End;

End;

{********************************}
{* RETORNA O CODIGO SEQUENCIAL  *}
{* DAS CONFIGURACOES E ATUALIZA *}
{* --> AUTBAN <---              *}
{*****************************AF*}
function fAtuCodSeq(strChave, strCampo: String): String;
  Var
    strProxNum,
    strProxNumArq: String;
    intNumero : Integer;
Begin
  strProxNum := Trim(fGetBancoConfig(0, strChave, strCampo, ''));

  If Not fEmptyStr(strProxNum) Then
  Begin

    intNumero := StrToIntDef(strProxNum, 0);
    Inc(intNumero);
    strProxNum := IntToStr(intNumero);

    If fTemArquivoIniAutBan Then
    Begin

      Try
        strProxNumArq := Trim(fArqIniAutban(0, strChave, strCampo, '', ''));
        intNumero := StrToIntDef(strProxNumArq, 0);
        Inc(intNumero);

        If intNumero > StrToIntDef(strProxNum,0) Then
          strProxNum := IntToStr(intNumero);

        fArqIniAutban(1, strChave, strCampo, strProxNum);
      Except
        On E: Exception Do
        Begin
           Raise Exception.Create('Houve um problema ao atualizar o sequencial no arquivo cnfbco.ini,'+
                                  ' verifique se o mesmo não está sendo utilizado por outro processo.' + #10#13 +
                                  'Erro gerado: ' + E.Message);
        End;
      End;

    End;

    fGetBancoConfig(1, strChave, strCampo, strProxNum);
    Result := strProxNum;
  End
  Else
  Begin

    strProxNum := '1';
    Result     := strProxNum;
    fGetBancoConfig(1, strChave, strCampo, strProxNum);

  End;

End;

{***************************************}
{* VERIFICA SE EXISTE DIREITO NO AUTBAN*}
{***************************************}
function fVerificaDireitoAutBan(strNomForm: String): Boolean;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DIRBAN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAN_CODOPE = :CODOPE AND ';
  strSQL := strSQL + '  BAN_NOMFRM = :NOMFRM ';

  With frmModulo.qryDirBan Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    ParamByName('NOMFRM').AsString := strNomForm;
    Open;

    If Not IsEmpty Then
      Result := True
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   D.DIR_NOMFRM  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   DIRGPB D ';
      strSQL := strSQL + '   JOIN CADGPO G ON G.GPO_CODGPO = D.GPB_CODGPO ';
      strSQL := strSQL + '   JOIN OPEGPO O ON O.GPO_CODGPO = G.GPO_CODGPO ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   O.OPE_CODOPE = :CODOPE AND   ';
      strSQL := strSQL + '   D.DIR_NOMFRM = :NOMFRM       ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      ParamByName('NOMFRM').AsString := strNomForm;
      Open;

      If Not IsEmpty Then
        Result := True
      Else
        Result := False;
    End;
  End;
End;

function fRetornaQtdParcelasCondicao(strCodCnd: String; Var blnSemEnt: Boolean; Var intQtdPar, intDiaFix, intLimite: Integer; Var blnDiaCor: Boolean): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CND_SEMENT, ';
  strSQL := strSQL + '  CND_QTDPAR, ';
  strSQL := strSQL + '  CND_DIAFIX, ';
  strSQL := strSQL + '  CND_LIMITE, ';
  strSQL := strSQL + '  CND_DIACOR  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCND ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CND_CODIGO = :CODCND ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCND').AsString := strCodCnd;
    Open;

    Result := Not IsEmpty;

    If Result Then
    Begin
      blnSemEnt := FieldByName('CND_SEMENT').AsString = 'S';
      intQtdPar := FieldByName('CND_QTDPAR').AsInteger;
      intDiaFix := FieldByName('CND_DIAFIX').AsInteger;
      intLimite := FieldByName('CND_LIMITE').AsInteger;
      blnDiaCor := FieldByName('CND_DIACOR').AsString = 'S';
    End;

  End;

  FreeAndNil(qryGen);
end;

function fRetCondicaoDiaFixo(blnSemEnt: Boolean; intQtdPar, intDiaFix: Integer; dtaDtaBas: TDateTime; intLimite: Integer; blnDiaCor: Boolean): String;
  var
    intCont: Integer;
    intDiaV: Integer;
    dtaVenc: TDate;
    dtaCalc: TDate;
begin
  If intDiaFix <= 0 Then
    intDiaV := DayOf(dtaDtaBas)
  Else
    intDiaV := intDiaFix;

  dtaVenc := dtaDtaBas;

  If blnSemEnt Then
  Begin
    If (intDiaFix >= 1) And (DayOf(dtaVenc) < intDiaFix) And (intLimite >= 1) And (not blnDiaCor) Then
    Begin
      If intDiaV > DayOf(EndOfTheMonth(dtaVenc)) Then
        dtaCalc := EndOfTheMonth(dtaVenc)
      Else
        dtaCalc := EncodeDate(YearOf(dtaVenc), MonthOf(dtaVenc), intDiaFix);

      If (DaysBetween(dtaCalc, VS_Date) < intLimite) Then
        dtaVenc := IncMonth(dtaVenc, 1);
    End
    Else
    Begin
      dtaVenc := IncMonth(dtaVenc, 1)
    End;

    If (intDiaFix >= 1) And (intLimite >= 1) And blnDiaCor Then
    Begin
      If intDiaV > DayOf(EndOfTheMonth(dtaVenc)) Then
        dtaCalc := EndOfTheMonth(dtaVenc)
      Else
        dtaCalc := EncodeDate(YearOf(dtaVenc), MonthOf(dtaVenc), intDiaFix);

      If (DaysBetween(dtaCalc, VS_Date) < intLimite) Then
        dtaVenc := IncMonth(dtaVenc, 1);
    End;

  End;

  Result  := fStrZero(intQtdPar, 2);

  For intCont := 1 to intQtdPar Do
  Begin
    If intDiaV > DayOf(EndOfTheMonth(dtaVenc)) Then
      dtaVenc := EndOfTheMonth(dtaVenc)
    Else
      dtaVenc := EncodeDate(YearOf(dtaVenc), MonthOf(dtaVenc), intDiaV);

    If Not blnSemEnt And (intCont = 1) Then
      dtaVenc := dtaDtaBas;

    Result := Result + fStrZero( IntToStr( DaysBetween(dtaVenc, dtaDtaBas) ), 3 );

    dtaVenc := IncMonth(dtaVenc, 1);
  End;
end;


{************************************}
{* CALCULA CONDICAO DE PAGAMENTO    *}
{* REFERENTE AO TIPO DE FORA        *}
{* (FORA SEMANA, DEZENA...ETC)      *}
{*********************************MA*}
function fRetCondicao(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCnd, strTipFor, strCndPag: String; dtaDtaBas: TDateTime = 0;
  strOpcDoc: String = ''; strCodCid: String = ''; blnForcarDataBase: Boolean = False): String;
  var
    intQtdDia   : Integer;
    intQtdPar   : Integer;
    intDiaFix   : Integer;
    intLimite   : Integer;
    intQtdAtu   : Integer;
    intContador : Integer;
    strCndRet   : String;
    strStrDta   : String;
    blnSemEnt   : Boolean;
    dtaBasTmp   : TDateTime;
    dtaDtCalc   : TDateTime;
    intParc     : Integer;
    dtaVenc     : TDateTime;
    blnDiaCor   : Boolean;
    intQtdDiasPrimParc: Integer;
    dtaDataPrimeiraParcelaComBaseNaConPagEDataBase: TDateTime;

    Function fRetQtdDiasEntreDataBaseDataVencimento: String;
    Begin
      Result := fStrZero(Trim(IntToStr(DaysBetween(dtaVenc, dtaBasTmp))), 3);
    End;

Begin
  Result := strCndPag;

  If Not fConPagFora(strTipFor) Then
    Exit;
  If blnForcarDataBase Then
    dtaBasTmp := dtaDtaBas
  Else
    dtaBasTmp := VS_Date;

  //Reajusta a conpag caso ela não estiver vencida
  If fCfgSis('AJPZDF', VarBoolean) And (Not fEmptyStr(strConPagRef)) And (dtaUltDtaAlt > 0) Then
  Begin
    intQtdDiasPrimParc := StrToIntDef(Copy(strConPagRef, 3, 3), 0);
    dtaDataPrimeiraParcelaComBaseNaConPagEDataBase := IncDay(dtaUltDtaAlt, intQtdDiasPrimParc);
    //Se a primeira parcela com base na condição e da última gravação não estiver vencida, reajusta mesmas a CONPAG
    //para manter o mesmo vencimento porém a contar o dia de hoje;
    If (dtaDataPrimeiraParcelaComBaseNaConPagEDataBase > VS_Date) Then
    Begin
      Result := LeftStr(strConPagRef, 2);

      For intParc := 0 To StrToIntDef(LeftStr(Result, 2), 0) -1 Do
      Begin
        dtaVenc := dtaUltDtaAlt + StrToIntDef(Copy(strConPagRef, 3 + (intParc * 3), 3), 0); //Data de vencimento original;

        //Dias entre hoje e a data de vencimento original da parcela;
        Result := Result + fRetQtdDiasEntreDataBaseDataVencimento;
      End;

      Exit;
    End;
  End;

  intQtdDia := 0;
  intQtdPar := StrToIntDef( Trim( Copy( strCndPag, 1, 2 ) ), 0 );

  If (dtaDtaBas > 0) And (dtaDtaBas >= VS_Date) And (Pos(strOpcDoc, 'PD_OR_') > 0) Then
    dtaBasTmp := dtaDtaBas;

  {*******************************************}
  {* FORA SEMANA                             *}
  {****************************************MA*}
  If strTipFor = 'SEMANA' Then
  Begin

    intQtdDia := ( 8 - DayOfWeek(dtaBasTmp) );
    strCndRet := Copy( strCndPag, 1, 2 );

    For intContador := 1 to intQtdPar Do
    Begin

      intQtdAtu := StrToIntDef( Copy( strCndPag, ( intContador * 3 ), 3 ), 0 );
      strCndRet := strCndRet + fStrZero( Trim( IntToStr( intQtdDia + intQtdAtu ) ), 3 );

    End;

    Result := strCndRet;

  End
  Else

  {*******************************************}
  {* FORA DEZENA                             *}
  {****************************************MA*}
  If strTipFor = 'DEZENA' Then
  Begin

    If      DayOfTheMonth( dtaBasTmp ) > 20 Then
    Begin
      //strStrDta := '01/' + fStrZero( MonthOf( IncMonth( VS_Date, 1 ) ), 2 ) + '/' + fStrZero( YearOf( IncMonth( VS_Date, 1 ) ), 4 );
      strStrDta := DateToStr(EndOfTheMonth(dtaBasTmp));
      intQtdDia := DaysBetween( StrToDate( strStrDta ), dtaBasTmp );
    End
    Else If DayOfTheMonth( dtaBasTmp ) > 10 Then
    Begin
      strStrDta := '20/' + fStrZero( MonthOf( dtaBasTmp ), 2 ) + '/' + fStrZero( YearOf( dtaBasTmp ), 4 );
      intQtdDia := DaysBetween( StrToDate( strStrDta ), dtaBasTmp );
    End
    Else If DayOfTheMonth( dtaBasTmp ) >= 1 Then
    Begin
      strStrDta := '10/' + fStrZero( MonthOf( dtaBasTmp ), 2 ) + '/' + fStrZero( YearOf( dtaBasTmp ), 4 );
      intQtdDia := DaysBetween( StrToDate( strStrDta ), dtaBasTmp );
    End;

    strCndRet := Copy( strCndPag, 1, 2 );

    For intContador := 1 to intQtdPar Do
    Begin

      intQtdAtu := StrToIntDef( Copy( strCndPag, ( intContador * 3 ), 3 ), 0 );
      strCndRet := strCndRet + fStrZero( Trim( IntToStr( intQtdDia + intQtdAtu ) ), 3 );

    End;

    Result := strCndRet;

  End
  Else

  {*******************************************}
  {* FORA QUINZENA                           *}
  {****************************************MA*}
  If strTipFor = 'QUINZENA' Then
  Begin

    If DayOfTheMonth( dtaBasTmp ) > 15  Then
    Begin
//      strStrDta := '01/' + fStrZero( MonthOf( IncMonth( VS_Date, 1 ) ), 2 ) + '/' + fStrZero( YearOf( IncMonth( VS_Date, 1 ) ), 4 );
      strStrDta := fStrZero( DayOf(EndOfTheMonth( dtaBasTmp ) ), 2) + '/' +
                   fStrZero( MonthOf( dtaBasTmp ), 2 ) + '/' +
                   fStrZero( YearOf ( dtaBasTmp ), 4 );

      intQtdDia := DaysBetween( StrToDate( strStrDta ), dtaBasTmp );
    End
    Else
    Begin
      strStrDta := '15/' + fStrZero( MonthOf( dtaBasTmp ), 2 ) + '/' + fStrZero( YearOf( dtaBasTmp ), 4 );
      intQtdDia := DaysBetween( StrToDate( strStrDta ), dtaBasTmp );
    End;

    strCndRet := Copy( strCndPag, 1, 2 );

    For intContador := 1 to intQtdPar Do
    Begin

      intQtdAtu := StrToIntDef( Copy( strCndPag, ( intContador * 3 ), 3 ), 0 );
      strCndRet := strCndRet + fStrZero( Trim( IntToStr( intQtdDia + intQtdAtu ) ), 3 );

    End;

    Result := strCndRet;

  End
  Else

  {*******************************************}
  {* FORA MES                                *}
  {****************************************MA*}
  If strTipFor = 'MES' Then
  Begin


    strStrDta := DateToStr(EndOfTheMonth(dtaBasTmp));
    intQtdDia := DaysBetween( StrToDate( strStrDta ), dtaBasTmp );
    strCndRet := Copy( strCndPag, 1, 2 );

    For intContador := 1 to intQtdPar Do
    Begin
      intQtdAtu := StrToIntDef( Copy( strCndPag, ( intContador * 3 ), 3 ), 0);
      strCndRet := strCndRet + fStrZero( Trim( IntToStr( intQtdDia + intQtdAtu ) ), 3 );
    End;

    Result := strCndRet;

  End;

  {*******************************************}
  {* DIA FIXO                                *}
  {****************************************MA*}
  If strTipFor = 'DIA FIXO' Then
  Begin
    If fRetornaQtdParcelasCondicao(strCodCnd, blnSemEnt, intQtdPar, intDiaFix, intLimite, blnDiaCor) Then
      Result := fRetCondicaoDiaFixo(blnSemEnt, intQtdPar, intDiaFix, dtaBasTmp, intLimite, blnDiaCor);
  End;

  If Not fCfgSis('FSDUDP', varBoolean) Then
  Begin
    intQtdPar := StrToIntDef(Trim(Copy(Result, 1, 2)), 0);
    strCndRet := Copy(Result, 1, 2);

    For intContador := 1 to intQtdPar Do
    Begin
      dtaDtCalc := dtaBasTmp;
      intQtdAtu := StrToIntDef(Copy(Result, (intContador * 3), 3), 0);
      dtaDtCalc := dtaDtCalc + intQtdAtu;

      While (fDiaDeFolga(dtaDtCalc, True, IIF(fCfgSis('FEMUCP', varBoolean), strCodCid, ''))) Do
      Begin
        dtaDtCalc := dtaDtCalc + 1;
        intQtdAtu := intQtdAtu + 1;
      End;

      strCndRet := strCndRet + fStrZero(Trim(IntToStr(intQtdAtu)), 3);
    End;

    Result := strCndRet;
  End;
End;

function fRetCondicaoDiaFixoCliente(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCli, strConPag: String; dtaDtaBas: TDateTime = 0; strOpcDoc: String = ''; strCodCid: String = ''): String;
  Var
    strDiaFix: String;
    strDiaMes: String;
begin

  strDiaFix := fCampoTabela('CLI_DIAFIX', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
  strDiaFix := fPadR(strDiaFix, 5, 'N');

  strDiaMes := fCampoTabela('CLI_DIAMES', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
  strDiaMes := fTransform(strDiaMes, 2);


  if fCfgSis('MLTCND', varBoolean) And (strDiaFix <> 'NNNNN') And (strDiaMes <> '') then
    Result := fRetCondicaoDiaFixoCliente_MTLCND(strConPagRef, dtaUltDtaAlt, strCodCli, strConPag, dtaDtaBas, strOpcDoc, strCodCid )
  Else
    Result := fRetCondicaoDiaFixoCliente_Normal(strConPagRef, dtaUltDtaAlt, strCodCli, strConPag, dtaDtaBas, strOpcDoc, strCodCid );
end;

Function fRetQtdDiasEntreDataBaseDataVencimento(dtaVenc, dtaBasTmp: TDateTime): String;
Begin
  Result := fStrZero(Trim(IntToStr(DaysBetween(dtaVenc, dtaBasTmp))), 3);
End;

function fRetCondicaoDiaFixoCliente_MTLCND(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCli, strConPag: String; dtaDtaBas: TDateTime = 0; strOpcDoc: String = ''; strCodCid: String = ''): String;
  Var
    strDiaFix: String;
    strDiaMes: String;
    intParc: Integer;
    dtaVenc: TDateTime;
    dtaBasTmp: TDateTime;
    intQtdDiasPrimParc: Integer;
    dtaDataPrimeiraParcelaComBaseNaConPagEDataBase: TDateTime;

  function fDataVencimentoOk(strConPagFinal: String): Boolean;
    var
      intDiaSem: Integer;
      strDiaAtu: String;

      blnDiaSem: boolean;
      blnDiaMes: boolean;
  begin

    blnDiaSem := False;
    blnDiaMes := False;

    If strDiaMes <> '' Then
    Begin
      strDiaAtu := IntToStr(DayOf(dtaVenc));
      // Resulta True se o dia atual está contido nos dias cadastrados
      //Result := Pos(strDiaAtu, strDiaMes) > 0;  --> problema: dia 1 está em dia 10, dia 4 está em dia 14, e assim por diante.
      blnDiaMes := fDiaAtualEstaEmDiasCadastrados(strDiaMes, strDiaAtu);

      // Verifica se é ultimo dia do mês e existe o dia 31 cadastrado
      If (DayOf(dtaVenc) = DaysInMonth(dtaVenc)) and (Pos('31', strDiaMes) > 0) Then
        blnDiaMes := True;

      // Verifica se já foi criada uma parcela com o mesmo intervalo de data em dias. Se foi, tem que continuar até achar uma data válida.
      If Pos(fRetQtdDiasEntreDataBaseDataVencimento(dtaVenc, dtaBasTmp), Copy(strConPagFinal, 3, Length(strConPagFinal))) > 0 Then
        blnDiaMes := False;
    End;

    If strDiaFix <> 'NNNNN' Then
    Begin
      intDiaSem := DayOfWeek(dtaVenc);
      blnDiaSem := (intDiaSem In [2..6]) And (strDiaFix[intDiaSem -1] = 'S');//Entre segunda e sexta
    End;

    Result := blnDiaSem And blnDiaMes;
  end;

begin
  Result := strConPag;

  If (fStatusCndPag(strConPag) = A_VISTA) Or (Not fClienteTemDiaFixo(strCodCli)) Then
    Exit;

  strDiaFix := fCampoTabela('CLI_DIAFIX', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  //Prenche os dia fixos do cliente de segunda ate sexta
  strDiaFix := fPadR(strDiaFix, 5, 'N');

  //Caso não use dia fixo no cadastro do cliente
  // Verifica se usa dia fixo do mês
  strDiaMes := fCampoTabela('CLI_DIAMES', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
  strDiaMes := fTransform(strDiaMes, 2);

  dtaBasTmp := VS_Date;

  //Reajusta a conpag caso ela não estiver vencida
  If fCfgSis('AJPZDF', VarBoolean) And (Not fEmptyStr(strConPagRef)) And (dtaUltDtaAlt > 0) Then
  Begin
    intQtdDiasPrimParc := StrToIntDef(Copy(strConPagRef, 3, 3), 0);
    dtaDataPrimeiraParcelaComBaseNaConPagEDataBase := IncDay(dtaUltDtaAlt, intQtdDiasPrimParc);
    //Se a primeira parcela com base na condição e da última gravação não estiver vencida, reajusta mesmas a CONPAG
    //para manter o mesmo vencimento porém a contar o dia de hoje;
    If (dtaDataPrimeiraParcelaComBaseNaConPagEDataBase > VS_Date) Then
    Begin
      Result := LeftStr(strConPagRef, 2);

      For intParc := 0 To StrToIntDef(LeftStr(Result, 2), 0) -1 Do
      Begin
        dtaVenc := dtaUltDtaAlt + StrToIntDef(Copy(strConPagRef, 3 + (intParc * 3), 3), 0); //Data de vencimento original;

        //Dias entre hoje e a data de vencimento original da parcela;
        Result := Result + fRetQtdDiasEntreDataBaseDataVencimento(dtaVenc, dtaBasTmp);
      End;

      Exit;
    End;
  End;

  If (dtaDtaBas > 0) And (dtaDtaBas >= VS_Date) And (Pos(strOpcDoc, 'PD_OR_') > 0) Then
    dtaBasTmp := dtaDtaBas;

  Result := LeftStr(strConPag, 2);

  //Processa todos as Parcelas
  For intParc := 0 To StrToIntDef( LeftStr( Result , 2 ), 0 ) -1 Do
  Begin
    dtaVenc := dtaBasTmp + StrToIntDef( Copy( strConPag, 3 + ( intParc * 3 ), 3 ), 0 );

    //Incrementa a data de vencimento ate encontrar um dia fixo do cliente
    While Not fDataVencimentoOk(Result) Do dtaVenc := IncDay(dtaVenc);

    If Not fCfgSis('FSDUDP', varBoolean) Then
    Begin
      While (fDiaDeFolga(dtaVenc, True, IIF(fCfgSis('FEMUCP', varBoolean), strCodCid, ''))) Do
        dtaVenc := IncDay(dtaVenc);
    End;

    Result := Result + fRetQtdDiasEntreDataBaseDataVencimento(dtaVenc, dtaBasTmp);
  End;

end;

function fRetCondicaoDiaFixoCliente_Normal(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCli, strConPag: String; dtaDtaBas: TDateTime = 0; strOpcDoc: String = ''; strCodCid: String = ''): String;
  Var
    strDiaFix: String;
    strDiaMes: String;
    intParc: Integer;
    dtaVenc: TDateTime;
    dtaBasTmp: TDateTime;
    intQtdDiasPrimParc: Integer;
    dtaDataPrimeiraParcelaComBaseNaConPagEDataBase: TDateTime;

  function fDataVencimentoOk(strConPagFinal: String): Boolean;
    var
      intDiaSem: Integer;
      strDiaAtu: String;
  begin
    // Se usa dia fixo do mês
    If strDiaMes <> '' Then
    Begin
      strDiaAtu := IntToStr(DayOf(dtaVenc));
      // Resulta True se o dia atual está contido nos dias cadastrados
      //Result := Pos(strDiaAtu, strDiaMes) > 0;  --> problema: dia 1 está em dia 10, dia 4 está em dia 14, e assim por diante.
      Result := fDiaAtualEstaEmDiasCadastrados(strDiaMes, strDiaAtu);

      // Verifica se é ultimo dia do mês e existe o dia 31 cadastrado
      If (DayOf(dtaVenc) = DaysInMonth(dtaVenc)) and (Pos('31', strDiaMes) > 0) Then
        Result := True;

      // Verifica se já foi criada uma parcela com o mesmo intervalo de data em dias. Se foi, tem que continuar até achar uma data válida.
      If Pos(fRetQtdDiasEntreDataBaseDataVencimento(dtaVenc, dtaBasTmp), Copy(strConPagFinal, 3, Length(strConPagFinal))) > 0 Then
        Result := False;
    End
    // Se usa dia fixo da semana
    Else
    Begin
      intDiaSem := DayOfWeek(dtaVenc);
      Result := (intDiaSem In [2..6]) And (strDiaFix[intDiaSem -1] = 'S');//Entre segunda e sexta
    End;

  end;

begin
  Result := strConPag;

  If (fStatusCndPag(strConPag) = A_VISTA) Or (Not fClienteTemDiaFixo(strCodCli)) Then
    Exit;

  strDiaFix := fCampoTabela('CLI_DIAFIX', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  //Prenche os dia fixos do cliente de segunda ate sexta
  strDiaFix := fPadR(strDiaFix, 5, 'N');

  //Caso não use dia fixo no cadastro do cliente
  If strDiaFix = 'NNNNN' Then
  Begin
    // Verifica se usa dia fixo do mês
    strDiaMes := fCampoTabela('CLI_DIAMES', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
    strDiaMes := fTransform(strDiaMes, 2);
  End;

  dtaBasTmp := VS_Date;

  //Reajusta a conpag caso ela não estiver vencida
  If fCfgSis('AJPZDF', VarBoolean) And (Not fEmptyStr(strConPagRef)) And (dtaUltDtaAlt > 0) Then
  Begin
    intQtdDiasPrimParc := StrToIntDef(Copy(strConPagRef, 3, 3), 0);
    dtaDataPrimeiraParcelaComBaseNaConPagEDataBase := IncDay(dtaUltDtaAlt, intQtdDiasPrimParc);
    //Se a primeira parcela com base na condição e da última gravação não estiver vencida, reajusta mesmas a CONPAG
    //para manter o mesmo vencimento porém a contar o dia de hoje;
    If (dtaDataPrimeiraParcelaComBaseNaConPagEDataBase > VS_Date) Then
    Begin
      Result := LeftStr(strConPagRef, 2);

      For intParc := 0 To StrToIntDef(LeftStr(Result, 2), 0) -1 Do
      Begin
        dtaVenc := dtaUltDtaAlt + StrToIntDef(Copy(strConPagRef, 3 + (intParc * 3), 3), 0); //Data de vencimento original;

        //Dias entre hoje e a data de vencimento original da parcela;
        Result := Result + fRetQtdDiasEntreDataBaseDataVencimento(dtaVenc, dtaBasTmp);
      End;

      Exit;
    End;
  End;

  If (dtaDtaBas > 0) And (dtaDtaBas >= VS_Date) And (Pos(strOpcDoc, 'PD_OR_') > 0) Then
    dtaBasTmp := dtaDtaBas;

  Result := LeftStr(strConPag, 2);

  //Processa todos as Parcelas
  For intParc := 0 To StrToIntDef( LeftStr( Result , 2 ), 0 ) -1 Do
  Begin
    dtaVenc := dtaBasTmp + StrToIntDef( Copy( strConPag, 3 + ( intParc * 3 ), 3 ), 0 );

    //Incrementa a data de vencimento ate encontrar um dia fixo do cliente
    While Not fDataVencimentoOk(Result) Do dtaVenc := IncDay(dtaVenc);

    If Not fCfgSis('FSDUDP', varBoolean) Then
    Begin
      While (fDiaDeFolga(dtaVenc, True, IIF(fCfgSis('FEMUCP', varBoolean), strCodCid, ''))) Do
        dtaVenc := IncDay(dtaVenc);
    End;

    Result := Result + fRetQtdDiasEntreDataBaseDataVencimento(dtaVenc, dtaBasTmp);
  End;

end;

function fRetCondicaoDevolucao(dtaEmiVen: TDate; strCndVen: String): String;
  Var
    intParcela: Integer;
    strParcAtu: String;
    strParcAnt: String;
    dtaVencim : TDateTime;

begin
  Result := strCndVen;

  If (fStatusCndPag(strCndVen) = A_VISTA) Then
    Exit;

  Result := '';

  For intParcela := 0 To StrToIntDef( LeftStr( strCndVen , 2 ), 0 ) -1 Do
  Begin
    dtaVencim := dtaEmiVen + StrToIntDef( Copy( strCndVen, 3 + ( intParcela * 3 ), 3 ), 0 );

    If dtaVencim < VS_Date Then
      dtaVencim := VS_Date;

    //se a condicao original era a prazo o vencimento nao pode ser a vista
    //exemplo: original 01.030, calculado 01.000 deve ser trocado para 01.001
    //cliente Tunicar 12/11/2014 - Armando 
    If (dtaVencim = VS_Date) And (Copy(strCndVen, 3, 3) <> '000') Then
      dtaVencim := VS_Date + 1;

    strParcAtu := fStrZero( Trim( IntToStr( DaysBetween(dtaVencim, VS_Date) ) ), 3 );

    If strParcAtu <> strParcAnt Then
      Result  := Result + strParcAtu;

    strParcAnt := strParcAtu;
  End;

  Result := fStrZero(intToStr( Length(Result) div 3 ), 2) + Result;

  If (fStatusCndPag(Result) = A_VISTA) Then
     Result := '01001';  
end;

function fGetCondicaoPrazo(strConPag: String): String;
  Var
    intQtdPar: Integer;
begin
  Result := strConPag;
  intQtdPar := strToIntDef(LeftStr(Result, 2), 0);
  { Exemplo se a condicao de pagamento for 03.000.030.060 }
  If (Copy(Result, 3, 3) = '000') And (intQtdPar > 1) Then
  Begin
    // nova condicao sera 02.030.060
    Result := fStrZero(intToStr(intQtdPar - 1), 2) +
      Copy(Result, 6, Length(Result) - 5);
  End;
end;

function fRetornaGrupoItem(strCodIte: String): String;
begin
  Result := fCampoTabela('ITE_CODGRU', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
end;

{***************************************}
{* RETORNA O NOME DO BANCO PASSADO POR *}
{* PARAMETRO                           *}
{************************************AF*}
function fRetNomeBco(strCodBco: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodBco) Then
    Exit;

  Result := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [strCodBco], False);

End;

{***********************************}
{* VERIFICA SE DUPLICATA EXISTE    *}
{********************************LB*}
function fVerificaExisteDuplic(Var strNumDup,strParcel,strEspDoc,strCodEmp,strCodCli, strNosNum, strCodBco, strTipCob: String;
                               Var intQtdReg: Integer; Var strAutoIncremCadRec: String; Var strCarteira: String;
                               ACarBco: String = ''; ANumDoc: String = ''; ADtaVen: String = ''): Boolean;
  Var
    strSQL   : String;
    qryGenRec: TUniQuery;
    docConfirmado: TArray<String>;
    LDtaVen: TDatetime;
    LEmitidoBanco : Boolean;

  Procedure pSetaParametros;
  Begin

    With qryGenRec Do
    Begin
      If fEmptyStr( strNumDup ) Then
      Begin
        ParamByName('NOSNUM').AsString := strNosNum;
        ParamByName('CODBCO').AsString := strCodBco;
      End
      Else
      Begin
        If (strCodBco = '356') And (strTipCob = 'N') Then
        Begin
          ParamByName('NUMDUP').AsString := strNumDup;
          ParamByName('PARCEL').AsString := strParcel;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmp;
        End

        Else If (strCodBco = '033') And (fEmptyStr(strEspDoc)) Then //Santader sistema antigo
        Begin
          ParamByName('NUMDUP').AsString := strNumDup;
          ParamByName('PARCEL').AsString := strParcel;
          ParamByName('CODCLI').AsString := strCodCli;
          ParamByName('CODEMP').AsString := strCodEmp;
        End

        Else If (strCodBco = '748') and (Not fEmptyStr(strNosNum)) and (fEmptyStr(strCodCli)) then
        Begin
          ParamByName('NUMDUP').AsString := strNumDup;
          ParamByName('PARCEL').AsString := strParcel;
          ParamByName('ESPDOC').AsString := strEspDoc;

          If (strCodBco = '748') And (strNumDup.Length = 6) Then //Sicredi 400
            ParamByName('NUMDUP').AsString := '%' + strNumDup;

          If Params.FindParam('NOSNUM') <> Nil Then
          ParamByName('NOSNUM').AsString := strNosNum;
        End

        Else
        Begin
          ParamByName('NUMDUP').AsString := strNumDup;
          ParamByName('PARCEL').AsString := strParcel;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmp;

          If Not fEmptyStr(strCodCli) Then
          begin
            ParamByName('CODCLI').AsString := strCodCli;
          end;
        End;

      End;
    End;
  End;

  function GetNossoNumero(ANosNum: String): String;
  Begin
    Result := strNosNum;
    If (fGetBancoConfig(0, ACarBco, 'RESPONS', '') = 'E') Then
    Begin
      If MatchStr(strCodBco, ['341']) Then
      Begin
        If Not fEmptyStr(ANosNum) Then
          Result := ANosNum;
      End;
    End;
  End;

  function ApenasDuplicatasEmpresaLogada: String;
  Begin
    Result := '';
    If (fGetBancoConfig(0, ACarBco, 'DUPEMPLOG', '') = 'S') Then
    Begin
      Result := ' AND CTR_CODEMP = ' + VS_strCodEmp.QuotedString
    End;
  End;

Begin

  qryGenRec := fCriaQuery;
  intQtdReg := 0;
  strAutoIncremCadRec := '';
  LEmitidoBanco := False;
  if not fEmptyStr(ACarBco) then
    LEmitidoBanco := (fGetBancoConfig(0, ACarBco, 'RESPONS', '') = 'B');

  //Se utiliza boletos de adiantamento e especie de retorno bancario for pedido
  If (strEspDoc = 'PD') Then
    If fPedidoTemBoletoAdiantamento(strNumDup,strEspDoc,strCodEmp) Or (fCfgSis('BOLADT', VarBoolean)) Then
  Begin
    //Se não encontrou a duplicata do pedido
    If fCampoTabela('COUNT(0)',
                    'CADREC',
                   ['CTR_NUMDUP','CTR_PARCEL','CTR_ESPDOC','CTR_CODEMP'],
                   [strNumDup,strParcel,strEspDoc,strCodEmp]) = 0 Then
    Begin
      //Procura no CTRCNF para ver se a duplicata de pedido foi confirmada em NF, FF, etc ...
      docConfirmado := String(
        fCampoTabela('CONCAT(CTR_DOCCNF,"-",CTR_ESPCNF,"-",CTR_EMPCNF)',
                      'CTRCNF',
                     ['CTR_NUMDUP','CTR_PARCEL','CTR_ESPDOC','CTR_CODEMP','CTR_NOSNUM','CTR_ADTCLI'],
                     [strNumDup,strParcel,strEspDoc,strCodEmp,strNosNum,'S'])).Split(['-']);

      //Se achou o documento em que o pedido foi confirmado
      If Length(docConfirmado) = 3 Then
      Begin
        //Se localizou a duplicata do documento confirmado (incluindo no nosso numero na chave de busca).
        If fCampoTabela('COUNT(0)',
                        'CADREC',
                       ['CTR_NUMDUP','CTR_PARCEL','CTR_ESPDOC','CTR_CODEMP','CTR_NOSNUM','CTR_ADTCLI'],
                       [docConfirmado[0],strParcel,docConfirmado[1],docConfirmado[2],strNosNum,'S']) > 0 Then
        Begin
          //Entao substitui a duplicata do pedido pela nova duplicata gerada no faturamento do mesmo (NF,FF, etc...).
          strNumDup := docConfirmado[0];
          strEspDoc := docConfirmado[1];
          strCodEmp := docConfirmado[2];
        End;
      End;
    End;
  End;

  If fEmptyStr( strNumDup ) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NOSNUM = :NOSNUM AND   ';

    strSQL := strSQL + '  (CTR_BCOBOL = :CODBCO OR   ';
    strSQL := strSQL + '   CTR_BCOENV = :CODBCO) AND ';
    strSQL := strSQL + '  CTR_VALORI > 0 AND         ';
    strSQL := strSQL + '  CTR_ESPDOC <> "CC" AND     ';
    strSQL := strSQL + '  CTR_SEQBAI = 0             ';
    strSQL := strSQL + ApenasDuplicatasEmpresaLogada;

  End
  Else
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';

    If (strCodBco = '356') And (strTipCob = 'N') Then
    Begin
      If Length(strNumDup) = 6 Then
        strSQL := strSQL + '  RIGHT(CTR_NUMDUP, 6) = :NUMDUP AND '
      Else
        strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP  ';
    End

    Else If (strCodBco = '033') And (fEmptyStr(strEspDoc)) Then //Santader sistema antigo
    Begin
      If Length(strNumDup) = 6 Then
        strSQL := strSQL + '  RIGHT(CTR_NUMDUP, 6) = :NUMDUP AND '
      Else
        strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP  ';
    End

    Else If (strCodBco = '748') and (Not fEmptyStr(strNosNum)) and (fEmptyStr(strCodCli)) And (strNumDup.Length = 6) then // SICREDI NOVA REGRA SEM O CONREM REQUISITO 118625
    begin
      strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC         ';
      strSQL := strSQL + '  AND CTR_PARCEL = :PARCEL     ';

      If (fGetBancoConfig(0, ACarBco, 'RESPONS', '') = 'B') Then
      Begin
        strSQL := strSQL + '  AND (CTR_NOSNUM = :NOSNUM OR ';
        strSQL := strSQL + '      CTR_BCOBOL="748")        ';
      End
      Else
        strSQL := strSQL + '  AND CTR_NOSNUM = :NOSNUM';

      strSQL := strSQL + '  AND CTR_NUMDUP LIKE :NUMDUP  ';
    end

    Else
    Begin
      If Length(strNumDup) = 6 Then
        strSQL := strSQL + '  RIGHT(CTR_NUMDUP, 6) = :NUMDUP '
      Else
        strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP  ';
      strSQL := strSQL + '  AND CTR_PARCEL = :PARCEL  ';
      strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC  ';
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';

      If Not fEmptyStr(strCodCli) Then
        strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';
    End;

    strSQL := strSQL + '  AND CTR_VALORI > 0       ';
    strSQL := strSQL + '  AND CTR_ESPDOC <> "CC"   ';
    strSQL := strSQL + '  AND CTR_SEQBAI = 0       ';
    strSQL := strSQL + ApenasDuplicatasEmpresaLogada;
  End;

  With qryGenRec Do
  Begin

    Close;

    SQL.Clear;
    SQL.Add(strSQL);
    pSetaParametros;
    Open;

    Result := False;

    If Not IsEmpty Then
    Begin
      intQtdReg := RecordCount;

      If (intQtdReg > 1) And fEmptyStr(strCodCli) And (Not fEmptyStr(strNosNum)) Then
      Begin
        strSQL := strSQL + '  AND CTR_NOSNUM = :NOSNUM ';
        SQL.Clear;
        SQL.Add(strSQL);
        pSetaParametros;
        ParamByName('NOSNUM').AsString := strNosNum;
        Open;

        If IsEmpty And (fGetBancoConfig(0, ACarBco, 'RESPONS', '') = 'B') Then
        Begin

          strSQL := 'SELECT * FROM CADREC        '  +
                    'WHERE                       '  +
                    '      CTR_NUMDUP = :NUMDUP  '  +
                    '  AND CTR_PARCEL = :PARCEL  '  +
                    '  AND CTR_CODEMP = :CODEMP  '  +
                    '  AND CTR_BCOENV = :CODBCO  '  +
                    '  AND CTR_ESPDOC = :ESPDOC  '  +
                    '  AND CTR_VALORI > 0        '  +
                    '  AND CTR_SEQBAI = 0        '  +
                    '  AND CTR_NOSNUM IS NULL    '  +
                     ApenasDuplicatasEmpresaLogada;

          SQL.Clear;
          SQL.Add(strSQL);
          pSetaParametros;
          ParamByName('CODBCO').AsString := strCodBco;
          Open;

          intQtdReg := RecordCount;

          If (MatchStr(strCodBco,['033', '001'])) And (intQtdReg > 1) And (Not fEmptyStr(ADtaVen)) And TryStrToDate(ADtaVen, LDtaVen) Then
          Begin
            strSQL := strSQL + '  AND CTR_DTAVEN = :DTAVEN ';
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            pSetaParametros;
            ParamByName('CODBCO').AsString := strCodBco;
            ParamByName('DTAVEN').AsDateTime := LDtaVen;
            Open;
          End;
        End;


        If Not IsEmpty Then
        Begin
          intQtdReg           := RecordCount;
          strAutoIncremCadRec := FieldByName('AUTOINCREM').AsString;
          strNumDup           := FieldByName('CTR_NUMDUP').AsString;
          strCodEmp           := FieldByName('CTR_CODEMP').AsString;
          strParcel           := FieldByName('CTR_PARCEL').AsString;
          strEspDoc           := FieldByName('CTR_ESPDOC').AsString;
          strCodCli           := FieldByName('CTR_CODCLI').AsString;
          strCarteira         := FieldByName('CTR_CARTEI').AsString;
          strNosNum           := GetNossoNumero(FieldByName('CTR_NOSNUM').AsString);

          Result := True;
        End;
      End
      Else
      Begin
        strAutoIncremCadRec := FieldByName('AUTOINCREM').AsString;
        strNumDup           := FieldByName('CTR_NUMDUP').AsString;
        strCodEmp           := FieldByName('CTR_CODEMP').AsString;
        strParcel           := FieldByName('CTR_PARCEL').AsString;
        strEspDoc           := FieldByName('CTR_ESPDOC').AsString;
        strCodCli           := FieldByName('CTR_CODCLI').AsString;
        strCarteira         := FieldByName('CTR_CARTEI').AsString;
        strNosNum           := GetNossoNumero(FieldByName('CTR_NOSNUM').AsString);

        Result := True;
      End;
    End
    Else
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADREC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_NOSNUM = :NOSNUM AND ';
      strSQL := strSQL + '  CTR_BCOBOL = :CODBCO AND ';
      strSQL := strSQL + '  CTR_ESPDOC <> "CC" AND   ';
      strSQL := strSQL + '  CTR_SEQBAI = 0           ';
      strSQL := strSQL + ApenasDuplicatasEmpresaLogada;

      Close;

      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOSNUM').AsString := strNosNum;
      ParamByName('CODBCO').AsString := strCodBco;

      Open;

      If strCodBco.Equals('084') Then
      Begin
        If  (qryGenRec.RecordCount > 1) then
        Begin
         qryGenRec.First;

          While Not qryGenRec.Eof Do
          Begin
            If (Pos(ANumDoc, qryGenRec.FieldByName('CTR_CODVEL').AsString) > 0) Then
              Break;

            If (Pos(ANumDoc.Trim, qryGenRec.FieldByName('CTR_CODVEL').AsString) > 0) Then
              Break;

            qryGenRec.Next;
          End;
        End;
      End;

      If Not IsEmpty Then
      Begin
        intQtdReg := RecordCount;
        strAutoIncremCadRec := FieldByName('AUTOINCREM').AsString;
        strNumDup           := FieldByName('CTR_NUMDUP').AsString;
        strCodEmp           := FieldByName('CTR_CODEMP').AsString;
        strParcel           := FieldByName('CTR_PARCEL').AsString;
        strEspDoc           := FieldByName('CTR_ESPDOC').AsString;
        strCodCli           := FieldByName('CTR_CODCLI').AsString;
        strCarteira         := FieldByName('CTR_CARTEI').AsString;
        strNosNum           := GetNossoNumero(FieldByName('CTR_NOSNUM').AsString);

        Result := True;

      End
      Else
      Begin

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  * ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADREC ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  CTR_CODVEL = :NUMDUP AND ';
        strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
        strSQL := strSQL + '  CTR_ESPDOC <> "CC" AND ';
        strSQL := strSQL + '  CTR_SEQBAI = 0 ';
        strSQL := strSQL + ApenasDuplicatasEmpresaLogada;

        Close;

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('PARCEL').AsString := strParcel;

        Open;

        If Not qryGenRec.IsEmpty Then
        Begin
          strAutoIncremCadRec := FieldByName('AUTOINCREM').AsString;
          strNumDup           := FieldByName('CTR_NUMDUP').AsString;
          strCodEmp           := FieldByName('CTR_CODEMP').AsString;
          strParcel           := FieldByName('CTR_PARCEL').AsString;
          strEspDoc           := FieldByName('CTR_ESPDOC').AsString;
          strCodCli           := FieldByName('CTR_CODCLI').AsString;
          strCarteira         := FieldByName('CTR_CARTEI').AsString;
          strNosNum           := GetNossoNumero(FieldByName('CTR_NOSNUM').AsString);

          Result := True;

        End
        else
        begin
          If (strCodBco = '341') Or (strCodBco = '995') Or (strCodBco = '133') Or (strCodBco = '981') Then
          begin
            //SE MESMO ASSIM NÃO FOR ENCONTRADA A DUPLICATA, FAZEMOS A BUSCA POR BCOBOL, CODEMP E O NOSSO NÚMERO SEM O DÍGITO
            strSQL := '';
            strSQL := strSQL + 'SELECT * ';
            strSQL := strSQL + 'FROM CADREC ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '  CTR_BCOBOL = :CODBCO AND ';
            strSQL := strSQL + '  LEFT(CTR_NOSNUM, LENGTH(CTR_NOSNUM) -1 )  = :NOSNUM AND ';
            strSQL := strSQL + '  CTR_ESPDOC <> "CC" AND ';
            strSQL := strSQL + '  CTR_SEQBAI = 0 ';
            If Not fEmptyStr(strCodEmp) Then
              strSQL := strSQL + ' AND  CTR_CODEMP = :CODEMP ';

            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODBCO').AsString := strCodBco;
            ParamByName('NOSNUM').AsString := IIF(strCodBco.Equals('341'),strNosNum,Copy(strNosNum, 1, (strNosNum.Length-1)));
            If Not fEmptyStr(strCodEmp) Then
              ParamByName('CODEMP').AsString := strCodEmp;
            Open;
          End;

          If Not qryGenRec.IsEmpty Then
          Begin
            strAutoIncremCadRec := FieldByName('AUTOINCREM').AsString;
            strNumDup           := FieldByName('CTR_NUMDUP').AsString;
            strCodEmp           := FieldByName('CTR_CODEMP').AsString;
            strParcel           := FieldByName('CTR_PARCEL').AsString;
            strEspDoc           := FieldByName('CTR_ESPDOC').AsString;
            strCodCli           := FieldByName('CTR_CODCLI').AsString;
            strCarteira         := FieldByName('CTR_CARTEI').AsString;
            strNosNum           := GetNossoNumero(FieldByName('CTR_NOSNUM').AsString);

            Result := True;

          end
          else
          If (strCodBco = '001') and LEmitidoBanco then
          begin
            strSQL := 'SELECT * FROM CADREC         '  +
                      ' WHERE CTR_CODEMP = :CODEMP  '  +
                      '   AND CTR_NUMDUP = :NUMDUP  '  +
                      '   AND CTR_PARCEL = :PARCEL  '  +
                      '   AND CTR_BCOENV = :CODBCO  '  +
                      '   AND CTR_ESPDOC = :ESPDOC  '  +
                      '   AND CTR_VALORI > 0        '  +
                      '   AND CTR_SEQBAI = 0        '  +
                      '   AND CTR_NOSNUM IS NULL    '  +
                      ApenasDuplicatasEmpresaLogada ;

            qryGenRec.SQL.Clear;
            qryGenRec.SQL.Add(strSQL);
            qryGenRec.ParamByName('CODEMP').AsString := strCodEmp;
            qryGenRec.ParamByName('NUMDUP').AsString := strNumDup;
            qryGenRec.ParamByName('PARCEL').AsString := strParcel;
            qryGenRec.ParamByName('ESPDOC').AsString := strEspDoc;
            qryGenRec.ParamByName('CODBCO').AsString := strCodBco;
            qryGenRec.Open;

            If (qryGenRec.RecordCount > 1) and (Not fEmptyStr(ADtaVen)) and TryStrToDate(ADtaVen, LDtaVen) Then
            Begin
              strSQL := strSQL + ' AND CTR_DTAVEN = :DTAVEN ';

              qryGenRec.Close;
              qryGenRec.SQL.Clear;
              qryGenRec.SQL.Add(strSQL);
              qryGenRec.ParamByName('CODEMP').AsString    := strCodEmp;
              qryGenRec.ParamByName('NUMDUP').AsString    := strNumDup;
              qryGenRec.ParamByName('PARCEL').AsString    := strParcel;
              qryGenRec.ParamByName('ESPDOC').AsString    := strEspDoc;
              qryGenRec.ParamByName('CODBCO').AsString    := strCodBco;
              qryGenRec.ParamByName('DTAVEN').AsDateTime  := LDtaVen;
              qryGenRec.Open;
            End;

            If Not qryGenRec.IsEmpty Then
            Begin
              strAutoIncremCadRec := qryGenRec.FieldByName('AUTOINCREM').AsString;
              intQtdReg           := qryGenRec.RecordCount;
              strNumDup           := qryGenRec.FieldByName('CTR_NUMDUP').AsString;
              strCodEmp           := qryGenRec.FieldByName('CTR_CODEMP').AsString;
              strParcel           := qryGenRec.FieldByName('CTR_PARCEL').AsString;
              strEspDoc           := qryGenRec.FieldByName('CTR_ESPDOC').AsString;
              strCodCli           := qryGenRec.FieldByName('CTR_CODCLI').AsString;
              strCarteira         := qryGenRec.FieldByName('CTR_CARTEI').AsString;
              strNosNum           := GetNossoNumero(qryGenRec.FieldByName('CTR_NOSNUM').AsString);

              Result := True;

            end;
          end
          else
          If (strCodBco = '748') and (Not fEmptyStr(strNosNum)) and (fEmptyStr(strCodCli)) then // SICREDI NOVA REGRA SEM O CONREM REQUISITO 118625
          begin
            strSQL := '';
            strSQL := strSQL + 'SELECT ';
            strSQL := strSQL + '  * ';
            strSQL := strSQL + 'FROM ';
            strSQL := strSQL + '  CADREC ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '  CTR_CODEMP = :CODEMP           ';
            strSQL := strSQL + '  AND CTR_PARCEL = :PARCEL       ';
            strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC       ';
            strSQL := strSQL + '  AND CTR_NOSNUM = :NOSNUM       ';
            strSQL := strSQL + '  AND CTR_NUMDUP LIKE :NUMDUP    ';
            strSQL := strSQL + '  AND CTR_VALORI > 0             ';
            strSQL := strSQL + '  AND CTR_ESPDOC <> "CC"         ';
            strSQL := strSQL + '  AND CTR_SEQBAI = 0             ';

            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NUMDUP').AsString := strNumDup;
            ParamByName('PARCEL').AsString := strParcel;
            ParamByName('ESPDOC').AsString := strEspDoc;
            ParamByName('CODEMP').AsString := strCodEmp;
            ParamByName('NOSNUM').AsString := strNosNum;
            Open;

            Result := False;
            If Not IsEmpty Then
            Begin
              intQtdReg           := RecordCount;
              strAutoIncremCadRec := FieldByName('AUTOINCREM').AsString;
              strNumDup           := FieldByName('CTR_NUMDUP').AsString;
              strCodEmp           := FieldByName('CTR_CODEMP').AsString;
              strParcel           := FieldByName('CTR_PARCEL').AsString;
              strEspDoc           := FieldByName('CTR_ESPDOC').AsString;
              strCodCli           := FieldByName('CTR_CODCLI').AsString;
              strCarteira         := FieldByName('CTR_CARTEI').AsString;
              strNosNum           := GetNossoNumero(FieldByName('CTR_NOSNUM').AsString);

              Result := True;
            End;
          end;

        end;

      End;

    End;

  End;

  FreeAndNil(qryGenRec);

End;


{************************************}
{* RETORNA DATA DO SALDO DE BALANÇO *}
{*********************************AF*}
function fRetDataSalBal(strCodIte, strCodEmp: String): TDate;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

Begin
  Try

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_DTABAL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := FieldByName('ITE_DTABAL').AsDateTime;

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

End;

function fPedLiberado(strNumPed: String; strCodEmp: String = ''): Boolean;
  Var strSQL: String;
      qryPedido: TUniQuery;
Begin
  If (strCodEmp = '') Then
    strCodEmp := VS_strCodEmp;

  qryPedido := fCriaQuery;
  Try
    With qryPedido Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  FGO_LIBERA, ';
      strSQL := strSQL + '  FGO_LIBCOM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATGOR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  FGO_NUMDOC=:NUMDOC AND ';
      strSQL := strSQL + '  FGO_CODEMP=:CODEMP AND ';
      strSQL := strSQL + '  FGO_ESPDOC="PD" ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumPed;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := ((FieldByName('FGO_LIBERA').AsInteger > 0) And (FieldByName('FGO_LIBCOM').AsInteger > 0));
      Close;

    End;
  Finally
    FreeAndNil(qryPedido);
  End;
End;

function fPedidoOriginadoOutroPedidoPeloF11Caixa(strNumPed: String; strCodEmp: String = ''): Boolean;
begin
  If (strCodEmp = '') Then
    strCodEmp := VS_strCodEmp;

  Result := fCfgSis('NPDF11', varBoolean) Or fCfgSis('NPRF11', varBoolean) Or
            fCfgSis('NPLF11', varBoolean) Or fCfgSis('LOCRET', varBoolean);

  Result := Result And fCampoTabela('COUNT(*)', 'FATDOR',
                                   ['FDO_ESPDOC', 'FDO_NUMFAT', 'FDO_TIPFAT', 'FDO_EMPFAT'],
                                   ['PD', strNumPed, 'PD', strCodEmp]) > 0;
end;

function fEhPedidoComServicoEProduto(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   FATGOR INNER JOIN FATDOR ON FATDOR.FDO_SEQGER=FATGOR.AUTOINCREM ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   FDO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   FDO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   (FDO_JAFATU = "1" OR FDO_QTDBAI > 0) AND ';
    strSQL := strSQL + '   FGO_TOTPRO > 0 AND '; 
    strSQL := strSQL + '   FGO_TOTSER > 0 ';
    
    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      Result := Fields[0].AsInteger > 0;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function fPedidoFaturadoParcialmente(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  Result := False;

  Try
    qryAux := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATDOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (FDO_JAFATU = "1" OR FDO_QTDBAI > 0) AND ';
    strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FDO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      Result :=  FieldByName('QTD').AsInteger > 0;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fPedidoFaturadoParcialmente]');
  End;

  FreeAndNil(qryAux);
end;

function fPedidoBaixaEntregaFutura(strNumPed, strEspDoc: String; strCodEmp: String = ''): Boolean;
begin

  Result := False;

  If fEmptyStr(strNumPed) Then
    Exit;

  If (strCodEmp = '') Then
    strCodEmp := VS_strCodEmp;

  Result := fUsaPedidoBaixaEntregaFutura;

  Result := Result And fCampoTabela('COUNT(*)',
                                    'FATDOR INNER JOIN EXTDOR ON FDO_SEQFDO = AUTOINCREM AND IFNULL(FDO_INCFUT,"") <> ""',
                                   ['FDO_NUMDOC', 'FDO_ESPDOC', 'FDO_CODEMP'],
                                   [strNumPed, strEspDoc, strCodEmp]) > 0;
end;

function fRetForPagCodCnd(strCodCnd: String): String;
  Var
    strSQL   : String;
    qryGenCnd: TUniQuery;
Begin
  Try
    qryGenCnd := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CND_CODFPG ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCND ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CND_CODIGO = :CODIGO ';

    With qryGenCnd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODIGO').AsString := strCodCnd;
      Open;
      Result := FieldByName('CND_CODFPG').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCnd);
  End;
End;

{************************************}
{* RETORNA O CODIGO DO PROFISSIONAL *}
{* DE ACORDO COM O AUTOINCREM DO    *}
{* MOVGER                           *}
{* PS. O CODDIV ATÉ ESSE MOMENTO    *}
{* ESTA GRAVANDO APENAS NO MOVDET   *}
{* SE MUDAR PARA O MOVGER NAUM FUI  *}
{* EU QUE FIZ LAMBANÇA..HUAUHA      *}
{*********************************AF*}
function fRetCodDiv(strTabela,strAutInc: String): String;
  Var
    strSQL   : String;
    qryGenDiv: TUniQuery;

Begin
  Try

    qryGenDiv := fCriaQuery;

    If Pos(strTabela,'MOVDET_NOTDET_') > 0 Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   DET_CODDIV ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + strTabela;
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   DET_SEQGER = :AUTINC ';
    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   FDO_CODDIV ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + strTabela;
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   FDO_SEQGER = :AUTINC ';
    End;

    With qryGenDiv Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := strAutInc;
      Open;

      If Pos(strTabela,'MOVDET_NOTDET_') > 0 Then
        Result := FieldByName('DET_CODDIV').AsString
      Else
        Result := FieldByName('FDO_CODDIV').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenDiv);
  End;

End;

//*****************************************************//
// FUNÇÃO QUE VERIFICA A VALIDADE DO SISTEMA           //
//                                                     //
// SE A VALIDADE DO SISTEMA ESTIVER VENCIDA ENTAO      //
// RETORNA FALSE;                                      //
//**************************************************ED*//
function fValidade_Sistema: Boolean;
  Var
    strDtaVal: String;
    strPatTra: String;
    strCodEmp: String;
Begin

  Result := True;

  //*****************************************************//
  // VERIFICA SE EXISTE O ARQUIVO DE TRAVA, SE SIM ENTAO //
  // FINALIZA O SISTEMA                                  //
  //**************************************************ED*//
  strPatTra := Trim(ExtractFilePath(Application.ExeName) + 'MySqlSys.dll');

  //*****************************************************//
  // CARREGA A DATA DA TRAVA DO CADEMP                   //
  //**************************************************ED*//
  strCodEmp := Trim(VS_strCodEmp);
  strDtaVal := fRetDescri('EMP_DTAVAL','EMP_CODEMP','CADEMP', strCodEmp);


  //*****************************************************//
  // VERIFICA SE O CAMPO NO CADEMP EMP_DTAVAL ESTA EM    //
  // BRANCO, SE SIM ENTAO BLOQUEIO O SISTEMA             //
  //**************************************************ED*//
  If fEmptyStr(strDtaVal) Then
  Begin
    //*****************************************************//
    // PROCEDURE QUE CRIA OU APAGA O ARQUIVO GERADO PARA   //
    // A TRAVA DO SISTEMA                                  //
    // 0 - CRIA O ARQUIVO                                  //
    // 1 - APAGA O ARQUIVO DA TRAVA                        //
    //**************************************************ED*//
    pCriaApagaTrava(0);

    Result := False;
    Exit;
  End;

  //*****************************************************//
  // DESCRYPTOGRAFA O CAMPO QUE ARMAZENA A DATA DA TRAVA //
  //**************************************************ED*//
  strDtaVal := fDecrypt(strDtaVal);

  //*****************************************************//
  // VERIFICA SE A DATA DA TRAVA E MAIOR QUE A DATA DO   //
  // SISTEMA                                             //
  //**************************************************ED*//
  Try
    If StrToDate(strDtaVal) < VS_Date Then
    Begin
      //*****************************************************//
      // PROCEDURE QUE CRIA OU APAGA O ARQUIVO GERADO PARA   //
      // A TRAVA DO SISTEMA                                  //
      // 0 - CRIA O ARQUIVO                                  //
      // 1 - APAGA O ARQUIVO DA TRAVA                        //
      //**************************************************ED*//
      pCriaApagaTrava(0);
      Result := False;
    End;
  Except
    //*****************************************************//
    // PROCEDURE QUE CRIA OU APAGA O ARQUIVO GERADO PARA   //
    // A TRAVA DO SISTEMA                                  //
    // 0 - CRIA O ARQUIVO                                  //
    // 1 - APAGA O ARQUIVO DA TRAVA                        //
    //**************************************************ED*//
    pCriaApagaTrava(0);
    Result := False;
  End;

End;

{**********************************}
{* RETORNA O RESULTADO DE UMA SQL *}
{*******************************ED*}
function fRetDescri(strCampoRetorno, strCampoPesquisa , strNomeTabela , strCodigo: String): String;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + strCampoRetorno + ' AS RESULTADO ' ;
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strNomeTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + strCampoPesquisa + ' = :CODIGO ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODIGO').AsString := strCodigo;
      Open;
      Result := FieldByName('RESULTADO').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

//****************************************************//
// PROCEDURE QUE CRIA OU APAGA O ARQUIVO GERADO PARA  //
// A TRAVA DO SISTEMA                                 //
// 0 - CRIA O ARQUIVO                                 //
// 1 - APAGA O ARQUIVO DA TRAVA                       //
//*************************************************ED*//
procedure pCriaApagaTrava(intCriApa: Integer);
  Var
    strPatTra: String;
    txfArqTex: TextFile;
Begin

  strPatTra := Trim(ExtractFilePath(Application.ExeName) + 'MySqlSys.dll');

  //*****************************************************//
  // VERIFICA SE DEVE CRIAR OU APAGAR A TRVA             //
  // 0 = INDICA QUE DEVE CRIAR O ARQUIVO                 //
  //**************************************************ED*//
  If intCriApa = 0 Then
  Begin
    AssignFile(txfArqTex, strPatTra);
    Rewrite(txfArqTex);
    Writeln(txfArqTex, '');
    CloseFile(txfArqTex);
  End
  //*****************************************************//
  // VERIFICA SE DEVE CRIAR OU APAGAR A TRVA             //
  // 1 = INDICA QUE DEVE DELETAR O ARQUIVO               //
  //**************************************************ED*//
  Else
  Begin
    DeleteFile(strPatTra);
  End;

End;

function fFormDesbloqueio: Boolean;
  Var
    frmDesbloqueiodaCopia : TfrmDesbloqueiodaCopia;
Begin

  Try
    pCriarFormularios(TfrmDesbloqueiodaCopia, frmDesbloqueiodaCopia);
    frmDesbloqueiodaCopia.ShowModal;
    Result := frmDesbloqueiodaCopia.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fFormDesbloqueio]');
    End;
  End;
  pFreeAndNil(frmDesbloqueiodaCopia);

End;

function fPedDevolucao(strNumPed: String): Boolean;
  Var strSQL: String;
      qryPedido: TUniQuery;
Begin

  qryPedido := fCriaQuery;
  Try
    With qryPedido Do
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  FGO_TIPPED ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATGOR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  FGO_NUMDOC=:NUMDOC AND ';
      strSQL := strSQL + '  FGO_CODEMP=:CODEMP AND ';
      strSQL := strSQL + '  FGO_ESPDOC="PD" ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumPed;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := (FieldByName('FGO_TIPPED').AsString = 'D');
      Close;

    End;
  Finally
    FreeAndNil(qryPedido);
  End;
End;

{********************************}
{* CARREGA O FORNECEDOR FILIAL  *}
{* DO CADASTRO DE EMPRESAS      *}
{*****************************LB*}
function fRetCodForFilial: String;
Begin
  Result := fRetCodForFilial(VS_strCodEmp);
End;

function fRetCodForFilial(strCodEmp: String): String; overload;
  Var
    strSQL    : String;
    qryGenFil : TUniQuery;
Begin
  Try

    qryGenFil := fCriaQuery;

    Result := '';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_FORFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenFil Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('EMP_FORFIL').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenFil);
  End;

End;

function fFornecedorFilial(strCodFor: String): Boolean;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_FORFIL = :CODFOR ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;
      Result := (FieldByName('QTD').AsInteger > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;

function fRetEmpresaFornecedorFilial(strCodFor: String): String;
  Var
    strSQL    : String;
    qryGenFil : TUniQuery;
Begin
  Try

    qryGenFil := fCriaQuery;

    Result := '';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_CODEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_FORFIL = :FORFIL ';

    With qryGenFil Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORFIL').AsString := strCodFor;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('EMP_CODEMP').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenFil);
  End;

End;

{******************************************}
{* CALCULA O VALOR DE JUROS DE UM PERIODO *}
{***************************************AF*}
function fCalculaMultaJuros(dtaDtaVen, dtaDtaPag: TDateTime; fltValDup: Double;
  fltPerJur: Double = 9999; fltPerMul: Double = 9999): TRecMultaJuros;
  Var
    fltDiaAtr: Double;
    intTolera: Integer;    
begin
  Result.fltValorMulta := 0;
  Result.fltValorJuros := 0;

  If fltValDup > 0 Then
  Begin
    intTolera := fCfgSis('TOLATR', varInteger);

    If fltPerJur = 9999 Then
      fltPerJur := fCfgSis('JURATR', varDouble);

    If fltPerMul = 9999 Then
      fltPerMul := fCfgSis('MULATR', varDouble);

    fltDiaAtr := dtaDtaPag - dtaDtaVen;

    If (dtaDtaVen < dtaDtaPag) And (fltDiaAtr > intTolera) Then
    Begin
      Result.fltValorMulta := fFormataFloat(fltValDup * (fltPerMul / 100), 2);
      Result.fltValorJuros := fFormataFloat(fltValDup * (((fltPerJur / 30) * fltDiaAtr) / 100), 2);
    End;

  End;

end;

function fRetNossoNumeroDisponivel(strBcoBol, strNosNum, strBcoIni: String;
  intCodCar: Integer; strCodEmp: String): String;
  Var
    qryCadRec: TUniQuery;
    blnFim: Boolean;
    intTmpNum: Int64;

    strNosNumFmt: String;
begin
  Try
    qryCadRec := fCriaQuery;
    blnFim    := False;
    strNosNum := IntToStr(StrToInt64(strNosNum));

    qryCadRec.SQL.Clear;
    qryCadRec.SQL.Add(' SELECT SUM(QTD) AS QTD FROM (         ');
    qryCadRec.SQL.Add(' SELECT                                ');
    qryCadRec.SQL.Add('   COUNT(*) AS QTD                     ');
    qryCadRec.SQL.Add(' FROM                                  ');
    qryCadRec.SQL.Add('   CADREC                              ');
    qryCadRec.SQL.Add(' WHERE                                 ');
    qryCadRec.SQL.Add('   CTR_BCOBOL = :BCOBOL AND            ');
    qryCadRec.SQL.Add('   CTR_NOSNUM = :NOSNUM                ');
    qryCadRec.SQL.Add('                                       ');
    qryCadRec.SQL.Add(' UNION ALL                             ');
    qryCadRec.SQL.Add('                                       ');
    qryCadRec.SQL.Add(' SELECT                                ');
    qryCadRec.SQL.Add('   COUNT(*) AS QTD                     ');
    qryCadRec.SQL.Add(' FROM                                  ');
    qryCadRec.SQL.Add('   DEL_CADREC                          ');
    qryCadRec.SQL.Add(' WHERE                                 ');
    qryCadRec.SQL.Add('   CTR_BCOBOL = :BCOBOL AND            ');
    qryCadRec.SQL.Add('   CTR_NOSNUM = :NOSNUM                ');
    qryCadRec.SQL.Add('   )   AS TMP                          ');

    Repeat

      strNosNumFmt := fCalcNossoNumero(strBcoBol, strNosNum, strBcoIni, intCodCar, strCodEmp);
      If (strBcoBol = '001') And (strBcoIni <> '001API') Then
      Begin
        strNosNum := strNosNumFmt;
        strNosNumFmt := strNosNumFmt + fCalcDigito(strBcoBol, strNosNumFmt, strBcoIni, intCodCar, strCodEmp);
      End
      Else
        strNosNumFmt := strNosNumFmt + fCalcDigito(strBcoBol, strNosNum, strBcoIni, intCodCar, strCodEmp);

      If Not fEmptyStr(strNosNumFmt) Then
      Begin
        qryCadRec.Close;
        qryCadRec.ParamByName('BCOBOL').AsString := strBcoBol;
        qryCadRec.ParamByName('NOSNUM').AsString := strNosNumFmt;
        qryCadRec.Open;

        If qryCadRec.FieldByName('QTD').AsInteger <= 0 Then
          blnFim := True
        Else
        Begin
          intTmpNum := StrToInt64(strNosNum)+1;
          strNosNum := IntToStr(intTmpNum);
        End;

        qryCadRec.Close;
      End
      Else
      Begin
        Result := '';
        Exit;
      End;

    Until (blnFim);

    Result := strNosNum;

  Finally
    FreeAndNil(qryCadRec);
  End;

end;

Function fRetEspDocBoleto(sCodEsp : String): String;
begin

  Try

    Result := 'DMI';

    If sCodEsp = '03' Then result := 'DMI'
    else
    If sCodEsp = '05' Then result := 'DSI'
    else
    If sCodEsp = '12' Then result := 'NP'
    else
    If sCodEsp = '17' Then result := 'RC'
    else
    If sCodEsp = '20' Then result := 'AP'
    else
    If sCodEsp = '05' Then result := 'DSI'

  Except

  End;

end;


function fGeraBoletoLaser(strNumBco: String;
                          cpuCampos: TCamposUso;
                          fltPerMor: Double;
                          strNosNum,
                          strNumDig: String;
                          strNomEmp,
                          strCgcEmp,
                          strBcoIni: String;
                          intCodCar: Integer;
                          var strArqBoletos: String;
                          var ABoletoCarneBuilder : TBoletoCarneBuilder;
                          var ABoleto1ViaBuilder : TBoleto1Via_ComprovanteBuilder;
                          strMens01: String = '';
                          strMens02: String = '';
                          strReimpr: String = 'N';
                          strOpcFil: String = '';
                          blnBolPdf: Boolean = False;
                          strBraCrr: String = '';
                          strBB_Crr: String = '';
                          strConCrr: String = '';
                          strNomeForm: String = '';
                          strNomeFila: String = '';
                          fltMulta: Double = 0;
                          blnForcarImp: Boolean = False;
                          blnEnvioDeEMailAutomatico: Boolean = False;
                          strChaveCarteira: String = '';
                          strSelObs: String = '';
                          blnConsulta: Boolean = False;
                          strMsgProrrogacao : String = '';
                          blnBolEnvEmail: Boolean = False;
                          blnEnvioFaturamento: Boolean = False;
                          AReimprimirBoletoOriginal : Boolean = False): Boolean;
  Var
    strTipEmp  : String;
    strTipSac  : String;
    strValTit  : String;
    fltValTit  : Double;
    strJurSuj  : String;
    fltJurSuj  : Double;
    strDesCob  : String;
    fltDesCob  : Double;
    strValMor  : String;
    strPerMor  : String; //percentual de juros de mora
    LJurosMora : String;
    strValMul  : String; //Valor da Multa
    fltDescon  : Double; //Desconto (Banco do Brasil 7 digitos)
    strDescon  : String; //Desconto (Banco do Brasil 7 digitos)
    strDtaVen  : String;
    strDtaCad,
    strChaveBRB  : String;
    strConRem  : String;
    strNumDup  : String;
    strEspDoc  : String;
    strCliCgc  : String;
    strNomCli  : String;
    strCodCli  : String;
    strEndere  : String;
    strBaiCli  : String;
    strNumCep  : String;
    strNomCid  : String;
    strEstado  : String;
    strCodCed  : String;
    strLinha   : String;
    txtArqTxt  : TextFile;
    strCodCar  : String;
    strDiaProt : String;
    strCodConv : String;
    strDigAgen : String;
    strCodAgen : String;
    strVariacao: String;
    strInstr1  : String;
    strInstr2  : String;
    strInstr3  : String;
    strInstr4  : String;
    strInstr5  : String;
    strInTr5D  : String;
    LParcelasNegritoCarne: String;
    strObsAgr  : String;
    strObsAg1  : String;
    strObsAg2  : String;
    strObsAg3  : String;
    strUsoBan  : String;
    strProAce  : String; // IMPRIME PROTOCOLO DE ACEITE
    strParNum  : String; // UTILIZAR PARCELA NUMERAL? (A = 001) REQ:158267 --> MT
    strExpBol  : String; // TIPO DE EXPORTADOR PARA BOLETO
    strCntCor  : String; // CONTA CORRENTE
    strDigCnt  : String; // DIGITO DA CONTA CORRENTE
    strPathBol : String;
    strModali  : String; //Modalidade
    strDigCed  : String; //DIGITO DO CEDENTE
    strEndEmp,
    strCodEmp  : String;
    strObsAgrup1,
    strObsAgrup2,
    strObsAgrup3 : String;
    qryCadEmp  : TUniQuery;

    strIdeCed  : String;
    strUsoCli  : String;
    strTipDia  : String;
    LCarteira  : String;
    strCarCrr  : String;
    str7DgCrr  : String;
    strCobReg  : String;
    strParcel  : String;
    fltPerMul  : Double; //Percentual da Multa
    strDesSuj  : String;
    fltDesSuj  : Double; //Desconto informado no título
    LValorDoTituloComDescontoSugerido : Boolean;
    strOutAcr  : String; //Outros acrescimos
    strSisCob  : String; //COBRANÇA CEF (SICOB, SIGCB OU SINCO)
    strSacAva	 : String;
    strTpIden  : String; //TIPO IDENTIFICADOR //HSBC 399 //COBRANÇA SEM REGISTRO *BB*
    strDesCed  : String;
    strEndCed  : String;
    strCompCed : String;
    strBaiCed  : String;
    strCidCed  : String;
    strEstCed  : String;
    strCepCed  : String;
    strCgcCed  : String;
    intIndCar  : Integer;//Índice da carteira do Bradesco para correspondente
    strUsoBco  : String;
    strCodInstr1,
    strCodInstr2: String;
    strMailCli : String;
    strBenefi,
    strEndBen  : String;
    strPerMul  : String;
    strExibMsg : String;
    strImpAgBenef: String;
    strCedenteBRB: String;
    ADiasCartorio: String;
    strInfAdi  : String;
    strRazaoSocialCooperativa,
    strIncrisaoCooperativa,
    strEnderecoCoopetativa,
    strBairroCooperativa,
    strCidadeCooperativa,
    strEstadoCooperativa,
    strCEPCooperativa: String;

    strInstrucaoBancoInter1,
    strInstrucaoBancoInter2,
    strInstrucaoBancoInter3,
    strInstrucaoBancoInter4,
    strInstrucaoBancoInter5: String;

    strEspDocBol : String;

    strEmpresaCarteira: String;

    strCedenteInter: String;
    LObsCompletaAG: String;

    strNroOpe: String;

    strImprimeParcelaA: String;
    qryQtdeParcelas   : TUniQUery;
    FObsDupAgr : Boolean;
    LQRCode : String;
    LDuplicataBoleto: TDuplicataCtr;

    strDiaMora: String;
    strNumOperacao: String;
    strCodCartBoleto : String;

    procedure CarregaDadosProtestoBancoDoBrasil7D;
      Var
        LDiasProtesto: String;
        LInstrucao: String;
    Begin
      If AnsiReplaceStr(cpuCampos['CADCLI->CLI_PROPER'], #39, '') = 'S' Then
      Begin
        LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPERS', '', strEmpresaCarteira, @LDuplicataBoleto);
        LInstrucao    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTPER', '', strEmpresaCarteira, @LDuplicataBoleto);
      End;

      If fEmptyStr(LDiasProtesto) Then
      Begin
        If (AnsiReplaceStr(cpuCampos['CADCLI->CLI_CGCCPF'], #39, '') = '2') Then
        Begin
          LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAS_PROTESTO_PF', '', strEmpresaCarteira, @LDuplicataBoleto);
          LInstrucao    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRUCAO_PF', '', strEmpresaCarteira, @LDuplicataBoleto);
        End
        Else
        Begin
          LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAS_PROTESTO_PJ', '', strEmpresaCarteira, @LDuplicataBoleto);
          LInstrucao    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRUCAO_PJ', '', strEmpresaCarteira, @LDuplicataBoleto);
        End;
      End;

      If Not fEmptyStr(LDiasProtesto) Then
      Begin
        strDiaProt := LDiasProtesto;
        strTipDia  := IIF(MatchStr(LInstrucao,['03','04','05']),'1','2');
      End;
    End;

    procedure CarregaDadosProtestoBancoItau;
      Var
        LDiasProtesto: String;
        LCodProtesto: String;
        LTipDiaProtesto: String;
    Begin
        If AnsiReplaceStr(cpuCampos['CADCLI->CLI_PROPER'], #39, '') = 'S' Then
        Begin
          LCodProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTPER', '', strEmpresaCarteira,@LDuplicataBoleto);

          If Not LCodProtesto.IsEmpty Then
          Begin
            strCodInstr2 :=  LCodProtesto;
            Exit;
          End;
        End;

        If (AnsiReplaceStr(cpuCampos['CADCLI->CLI_CGCCPF'], #39, '') = '2') Then
        Begin
          LCodProtesto  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRUCAO_PF', '', strEmpresaCarteira, @LDuplicataBoleto);
          LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAS_PROTESTO_PF', '', strEmpresaCarteira, @LDuplicataBoleto);
          LTipDiaProtesto :=  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA_PF', '', strEmpresaCarteira, @LDuplicataBoleto);
        End
        Else
        Begin
          LCodProtesto  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRUCAO_PJ', '', strEmpresaCarteira, @LDuplicataBoleto);
          LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAS_PROTESTO_PJ', '', strEmpresaCarteira, @LDuplicataBoleto);
          LTipDiaProtesto :=  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA_PJ', '', strEmpresaCarteira, @LDuplicataBoleto);
        End;

       If (Not fEmptyStr(LCodProtesto)) And (Not fEmptyStr(LDiasProtesto)) Then
       Begin
         strCodInstr2 := LCodProtesto;
         strDiaProt := LDiasProtesto;
         strTipDia  := LTipDiaProtesto;
       End;
    End;

    procedure pPreencherInstrucaoVazia(strTexto : String);
    Begin
      If fEmptyStr(strInstr1) Then
        strInstr1 := strTexto
      Else If fEmptyStr(strInstr2) Then
        strInstr2 := strTexto
      Else If fEmptyStr(strInstr3) Then
        strInstr3 := strTexto
      Else If fEmptyStr(strInstr4) Then
        strInstr4 := strTexto
      Else If fEmptyStr(strInstr5) Then
        strInstr5 := strTexto;
    End;

    procedure pImprimirNroDocHistConfig;
    begin
      If (fCfgSis('IPNDBL', varBoolean, strEmpresaCarteira)) Then
      Begin
        if (not fEmptyStr(strInstr3)) And (Not fEmptyStr(strInstr4)) And (Not fEmptyStr(strInstr5)) Then
          Exit;

        strObsAg1 := fPadR(AnsiReplaceStr('REF. DOC.: ' + strNumDup + IIF(fEmptyStr(strEspDoc), '', '-' + strEspDoc), #39, ''), 60);

        if fEmptyStr(strInstr3) then
        begin
          strInstr3 := strInstr4;
          strInstr4 := strInstr5;
          strInstr5 := '';
        End;

        if fEmptyStr(strInstr4) then
        begin
          strInstr4 := strInstr5;
          strInstr5 := '';
        End;

        if fEmptyStr(strInstr3) then
          strInstr3 := strObsAg1
        else if fEmptyStr(strInstr4) then
          strInstr4 := strObsAg1
        else if fEmptyStr(strInstr5) then
          strInstr5 := strObsAg1;

      End;
    end;

    Function fImprimeObs(intObs: Integer; strObservacao: String): String;
    Begin

      If Not fCfgSis('SELOBS', varBoolean) Then
      Begin
        Result := strObservacao;
        Exit;
      End;

      Case intObs Of
        1: Result := IIF(Pos('1_', strSelObs) > 0, strObservacao, '');
        2: Result := IIF(Pos('2_', strSelObs) > 0, strObservacao, '');
        3: Result := IIF(Pos('3_', strSelObs) > 0, strObservacao, '');
        4: Result := IIF(Pos('4_', strSelObs) > 0, strObservacao, '');
        5: Result := IIF(Pos('5_', strSelObs) > 0, strObservacao, '');
      End;
    End;

    {**************************************************************************************}
    {*QUANDO ESTIVER CONFIGURADO PARA PRIORIZAR A IMPRESSÃO DAS OBSERVAÇÕES DA CARTEIRA   *}
    {*AO INVEZ DAS OBSERVAÇÕES DO AG, O SISTEMA IRA GERAR AS OBSERVAÇÕES DO AG            *}
    {*COM 120 CARACTER AO INVES DE 58, PARA CABER MAIS INFORMAÇÕES NA LINHAS DE OBSERVAÇÃO*}
    {*JÁ QUE ELA TERÁ MENOS LINHAS RESERVADAS PARA IMPRESSÃO NO BOLETO                    *}
    {***********************************************************REQ: 199996**************MT}
    function ImprimirObservacaoCompletaAG : Boolean;
    Begin
      Result := False;

      if strExibMsg <> 'N' then
      begin
        If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
        Begin
          LObsCompletaAG := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSIMPAG', 'N', strEmpresaCarteira, @LDuplicataBoleto);

          If Not LObsCompletaAG.Equals('S') Then Exit;

          Result := True;

          strInstr1 := fImprimeObs(1,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV1', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr2 := fImprimeObs(2,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV2', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

          strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
          strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
          strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

          If Length(strObsAgr) <= 120 Then
          Begin
            strObsAg1 := LeftStr(strObsAgr, 120);
            strObsAg2 := '';
            strObsAg3 := '';
          End
          Else If Length(strObsAgr) <= 240 Then
          Begin
            strObsAg1 := LeftStr(strObsAgr, 120);
            strObsAg2 := Copy(strObsAgr, 121, 120);
            strObsAg3 := '';
          End
          Else
          Begin
            strObsAg1 := LeftStr(strObsAgr, 120);
            strObsAg2 := Copy(strObsAgr, 121, 120);
            strObsAg3 := Copy(strObsAgr, 241, 120);
          End;
        End;
      end;

    End;

begin
  If Not SysUtils.DirectoryExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos') Then
  Begin
    Result := False;
    pMensagemOk('A pasta ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos não existe!' + #10#13 + 'O diretório deve existir com o logo no formato: LogoBanco.bmp!');
    Exit;
  End;
  strNosNum  := StringReplace(strNosNum,' ','',[rfreplaceAll]);
  blnPreview := blnConsulta;
  {*****************************************}
  {* TIPO DE DIAS PARA PROTESTO.           *}
  {**************************************MV*}
  strTipDia := '1';

  strVariacao := '';
  strDescon   := '';
  strIdeCed   := '';
  strUsoCli   := '';
  strOutAcr   := '';
  strSisCob   := ' ';
  strCobReg   := ' ';

  strDesCed  := '';
  strEndCed  := '';
  strCompCed := '';
  strBaiCed  := '';
  strCidCed  := '';
  strEstCed  := '';
  strCepCed  := '';
  strCgcCed  := '';
  strParcel  := '';
  strChaveBRB := '';
  strConRem  := '';

  strCedenteInter := '';

  FApresentarEspDocumento := 'N';

  LQRCode := '';

  If AReimprimirBoletoOriginal Then
  Begin
    LDuplicataBoleto.strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '');
    LDuplicataBoleto.strParcel := AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    LDuplicataBoleto.strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
    LDuplicataBoleto.strCodEmp := AnsiReplaceStr(cpuCampos['CADREC->CTR_CODEMP'], #39, '');
    LDuplicataBoleto.strCodCli := AnsiReplaceStr(cpuCampos['CADREC->CTR_CODCLI'], #39, '');
  End;

  LJurosMora := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CFG_TAXDIA', '0', strEmpresaCarteira, @LDuplicataBoleto);
  If AReimprimirBoletoOriginal and Not FEmptyStr(LJurosMora) Then
  Begin
    fltPerMor :=  strToFloat(LJurosMora);
  End;

  {************************************}
  {* DETERMINANDO EMPRESA DA CARTEIRA *}
  {*********************************AJ*}
  strEmpresaCarteira := VS_strCodEmp;
  If (Not fEmptyStr(strChaveCarteira)) Then
  Begin
    strEmpresaCarteira := RightStr(strChaveCarteira, 3);

    //Verifica se possui configuração da carteira no CNFBCO
    If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
    Begin
      If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'RESPONS', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
      strEmpresaCarteira := VS_strCodEmp;
  End;
  End;

  Try
    qryCadEmp := fCriaQuery;
    pPesquisaCadEmp(Nil,qryCadEmp, strEmpresaCarteira);

    strEndEmp := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
    strEndEmp := strEndEmp + IIF(fEmptyStr(qryCadEmp.FieldByName('EMP_ENDNUM').AsString),'',', ' + qryCadEmp.FieldByName('EMP_ENDNUM').AsString);
    strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
    strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
    strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
    strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
    strEndEmp := strEndEmp + ' - ' + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;
  Finally
    FreeAndNil(qryCadEmp);
  End;

  //*************************************************//
  // SE O NOME DO CEDENTE CADASTRADO NO CONFIGURACOES//
  // ESTIVER EM BRANCO ENTAO USA O NOME QUE VEM DO   //
  // CADASTRO DE EMPRESAS                            //
  //**********************************************ED*//
  If Not( fEmptyStr( fCfgSis('NOMCED', varString, strEmpresaCarteira) ) ) Then
    strNomEmp := fCfgSis('NOMCED', varString, strEmpresaCarteira);

  {*********************************************}
  {* MODALIDADE DE COBRANÇA INICIADA COM VAZIO *}
  {* DEPOIS CARREGADA                          *}
  {******************************************AF*}
  strModali := '';

  //*************************************************//
  // CARREGA AS CONFIGURACOES DO AUTBAN (CNFBCO.INI) //
  // FAVOR, ASSIM QUE CRIAR UMA NOVA CONFIGURACAO,   //
  // CARREGAR O CAMPO AQUI E NAO DENTRO DOS IF'S     //
  // DOS BANCOS                                      //
  //**********************************************ED*//
  strInTr5D  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSV5DE', '', strEmpresaCarteira, @LDuplicataBoleto);
  strProAce  := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PROACEI', '', strEmpresaCarteira, @LDuplicataBoleto), 01);
  strParNum  := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PARCNUM', '', strEmpresaCarteira, @LDuplicataBoleto), 01);
  LParcelasNegritoCarne := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PARCELASNEGRITOCARNE', '', strEmpresaCarteira, @LDuplicataBoleto);

  {EXIBIR NO BOLETO DUPLICATAS AGRUPADAS, REQ: 190934 MT}
  FObsDupAgr := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSDUPAGR', 'S', strEmpresaCarteira, @LDuplicataBoleto).Equals('S');
  LCarteira := 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar) + '-' + strEmpresaCarteira;

  strImpAgBenef := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IMPAGBENEF', '', strEmpresaCarteira, @LDuplicataBoleto), 01);

  If fEmptyStr(strImpAgBenef) Then
    strImpAgBenef := 'S';

  {*******************************************}
  {* PEGA A MENSAGEM QUE FOI DIGITADA PELO   *}
  {* USUÁRIO, SENÃO, PEGA A QUE ESTIVER      *}
  {* CADASTRADA NO ARQUIVO (CNFBCO.INI)      *}
  {****************************************AC*}
  If (Not fEmptyStr(strMens01)) Then
    strInstr1  := fPadR(strMens01, 60)
  Else
    strInstr1  := fImprimeObs(1,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV1', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

  If (Not fEmptyStr(strMens02)) Then
    strInstr2  := fPadR(strMens02, 60)
  Else
    strInstr2  := fImprimeObs(2,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV2', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

  If Pos(strNumBco, '237') > 0 Then
  Begin
    strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60));
    strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', ''), 60));
    strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', ''), 60));
  End;

  strUsoBan  := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'USOBANC', '', strEmpresaCarteira, @LDuplicataBoleto), 10);
  strCntCor  :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
  strDigCnt  :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodConv :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
  strDigAgen :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodAgen :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodCar  :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);
  strDiaProt :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodCed  :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
  strExibMsg :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXIBMSG', '', strEmpresaCarteira, @LDuplicataBoleto);
  ADiasCartorio :=    fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIACART', '', strEmpresaCarteira, @LDuplicataBoleto);

  if fEmptyStr(strDiaProt) Then
    strDiaProt := '0';

  strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

  strValTit := AnsiReplaceStr(cpuCampos['CADREC->CTR_VALDUP'], '.', ',');
  fltValTit := fStrToFloat(strValTit);

  strDesCob := AnsiReplaceStr(cpuCampos['CADREC->CTR_DESCOB'], '.', ',');
  If (fEmptyStr(strDesCob)) Then
    strDesCob := '0';
  fltDesCob := fStrToFloat(strDesCob);

  if fCfgSis('VALIMP', varBoolean, strEmpresaCarteira) then
  Begin
    strJurSuj := AnsiReplaceStr(cpuCampos['CADREC->CTR_JURSUJ'], '.', ',');
    fltJurSuj := fStrToFloat(strJurSuj);

    fltValTit := fltValTit + fltJurSuj + fltDesCob;
  End;

  LValorDoTituloComDescontoSugerido := (MatchStr(strNumBco,['237']) Or
                                       (MatchStr(strNumBco,['033']) And (strBcoIni= '033B')) Or
                                       (MatchStr(strNumBco,['756']) And (strBcoIni= '756_240p')) Or
                                        MatchStr(strNumBco,['001']) Or MatchStr(strNumBco,['341']) Or MatchStr(strNumBco,['748']) ) And
                                        fCfgSis('DESBOL', varBoolean) ;

  If LValorDoTituloComDescontoSugerido Then
  Begin
    fltValTit := (fltValTit - fStrToFloat(AnsiReplaceStr(cpuCampos['CADREC->CTR_DESSUJ'], '.', ',')));
  End;


  strValTit := fPadL(FloatToStr(fFormataFloat(fltValTit, 02) * 100), 14, '0');
  strDesCob := fPadL(FloatToStr(fFormataFloat(fltDesCob, 02) * 100), 14, '0');

  strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
  strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
  strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
  strParcel := AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '');
  strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
  strEspeci := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
  strCodEmp := AnsiReplaceStr(cpuCampos['CADREC->CTR_CODEMP'], #39, '');

  strEspDocOriginal         := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
  strNumDocumentoSemParcela := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '');
  strParcelaDoDocumento     := AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '');

  //*************************************************//
  // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
  // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
  //**********************************************ED*//
  strObsAgr := '';
  strObsAg1 := '';
  strObsAg2 := '';
  strObsAg3 := '';

  {**************************************************}
  {* VARIÁVEIS USADAS PARA INSTRUÇÃO DE AGRUPAMENTO *}
  {* COM 120 POSIÇÕES EM CADA LINHA NO BOLETO       *}
  {***********************************************JS*}
  strObsAgrup1 := '';
  strObsAgrup2 := '';
  strObsAgrup3 := '';

  if strExibMsg <> 'N' then
  begin
    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
    Begin
      strObsAgr :=             AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

      If Length(strObsAgr) <= 58 Then
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
      End
      Else If Length(strObsAgr) <= 116 Then
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := Copy(strObsAgr, 59, 56);
      End
      Else
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := Copy(strObsAgr, 59, 56);
        strObsAg3 := Copy(strObsAgr, 115, 58);
      End;

    End;
  end;

  strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
  strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
  strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
  strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');
  strMailCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_EMAIL_'], #39, '');

  {**************************************}
  {* VERIFICA SE PEGA ENDERECO DE COB   *}
  {***********************************AF*}
  If fEmptyStr(strEndere) Or (strBcoIni = '077') Then
  Begin
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');
    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
  End
  Else
  Begin
    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
  End;


  strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
  strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
  strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

  strCodInstr1 := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRU1', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodInstr2 := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRU2', '', strEmpresaCarteira, @LDuplicataBoleto);

  if strExibMsg <> 'N' then
  begin
    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
    Begin

      If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := strObsAg1;
      End
      Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := strObsAg1;
        strInstr5 := strObsAg2;
      End
      Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
      Begin
        strInstr3 := strObsAg1;
        strInstr4 := strObsAg2;
        strInstr5 := strObsAg3;
      End;
    end
    Else
    Begin
      strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

      pImprimirNroDocHistConfig();
    End;
  end;

  //*************************************************//
  // DAQUI PARA BAIXO SAO OS TRATAMENTOS ESPECIFICOS //
  // PARA CADA BANCO.                                //
  //**********************************************ED*//

  {*************************************************}
  { BANCO BANCOOB                                   }
  {**********************************************JB*}
  If (strNumBco = '756') Or (strNumBco = '089') Then
  Begin
    strModali  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'MODALID', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCONV', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strBB_Crr <> 'S' Then
    Begin
      strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCOPE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCOPE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEspDoc  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESPDOC_', '02 - DM  Duplicata Mercantil', strEmpresaCarteira, @LDuplicataBoleto);

      If strReimpr = 'N' Then
        strNosNum  := fStrZero(strNosNum, 07) + strNumDig
      Else
        strNosNum  := fStrZero(strNosNum, 08);
    End
    Else
    Begin
      str7DgCrr := IIF(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CRRBB7D', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S', 'D7', '');
      strCarCrr := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CRRCART', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCodCed := fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                   fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
      strDigCed := '';
      strCodAgen:= fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strDigAgen:= fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strTipDia := fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'TIPDIA' , '', strEmpresaCarteira, @LDuplicataBoleto);
      strCodCar := fStrZero(fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

      If strReimpr <> 'N' Then
        strNosNum  := LeftStr(strNosNum, 07);
    End;


    strCodCed := strCodCed + strDigCed;

    strCodProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
  End;

  //*************************************************//
  // BANCO BMP MONEYPLUS                             //
  //**********************************************ED*//
  If (strNumBco = '274') And (strBcoIni = '274LP400p') Then
  Begin

    //strCodCed  := fArqIniAutban(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODEMPR', '');
    strCodCartBoleto := fGetBancoConfig(0, 'CONFIG' + strBcoIni +  '-' +  IntToStr(intCodCar), 'CARTBCO', '');

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(strNosNum, 11) + strNumDig
    Else
      strNosNum  := fStrZero(strNosNum, 12);

    //*************************************************//
    // FOI CRIADO UM CAMPO NA CONFIGURACAO DO BRADESCO //
    // POIS SEGUNDO OS ATENDENTES EXISTEM 2 SITUACOES  //
    // PARA A GERACAO DE REMESSA BANCARIA              //
    //**********************************************ED*//
    strExpBol := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXPOBOL', '');
    If fEmptyStr( strExpBol ) Then
      strExpBol := '1';

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S' Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + '   ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

    strCodCar := fPadL(strCodCar, 2, '0');
    strCodCartBoleto := fPadL(strCodCartBoleto, 3, '0');
    If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni, 'JUROSDI', '')) Then
    Begin
      fltPerMor := fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni, 'JUROSDI', ''));
      strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
      fltPerMor := fFormataFloat((fltPerMor / 100.0)  / 30, 04);
      strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor, 02) * 100), 14, '0');
    End;
    strCodCed := fPadL(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '') +
                       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', ''), 8, '0');

  End;

  //*************************************************//
  // BANCO BRADESCO                                  //
  //**********************************************ED*//
  If (Pos(strNumBco, '237_099_993_994_992_996_997_998_991_989_987_274_982_984_084_983_990_970_979_906_978_977_976_975_974_973_962_') > 0) And (strBcoIni <> '274LP400p') Then
  Begin

    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODEMPR', '', strEmpresaCarteira, @LDuplicataBoleto);
    strOutAcr  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OUTACRE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fPadL(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto), 4);

    FApresentarEspDocumento := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESPDOCBOL', '', strEmpresaCarteira, @LDuplicataBoleto);

    If Not fEmptyStr(strOutAcr) Then
      strOutAcr  := FloatToStrF(fStrToFloat(strOutAcr), ffFixed, 12, 2);

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(strNosNum, 11) + strNumDig
    Else
      strNosNum  := fStrZero(strNosNum, 12);

    //*************************************************//
    // FOI CRIADO UM CAMPO NA CONFIGURACAO DO BRADESCO //
    // POIS SEGUNDO OS ATENDENTES EXISTEM 2 SITUACOES  //
    // PARA A GERACAO DE REMESSA BANCARIA              //
    //**********************************************ED*//
    strExpBol := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXPOBOL', '', strEmpresaCarteira, @LDuplicataBoleto);
    If fEmptyStr( strExpBol ) Then
      strExpBol := '1';

    If strExpBol = '2' Then
      strCodCed := strCntCor + strDigCnt;

    If  (strNumBco = '993') Or (strNumBco = '992') Or (strNumBco = '274') Then
    begin
      If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strNumBco, 'JUROSDI', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
      Begin
        fltPerMor := fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strNumBco, 'JUROSDI', '', strEmpresaCarteira, @LDuplicataBoleto));
        strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
        strValMor := fPadL(FloatToStr(fFormataFloat((fltValTit * fltPerMor / 100.0) / 30, 02) * 100), 14, '0');
      End;
      strCodCed := fPadL(fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                         fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto), 8, '0');
    end;

    If  (strNumBco = '987') or (strNumBco = '984') Then
    begin
        strCodCed := fPadL(fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                           fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto), 8, '0');
    End;

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S') And (Pos(strNumBco, '237_099_994_987_982_984_084_989_983_990_970_906_978_977_976_975_974_973_962_') > 0) Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;

    If Pos(strNumBco, '099_084_') > 0 Then
    Begin
      strRazaoSocialCooperativa := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMECOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strIncrisaoCooperativa    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CGCCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEnderecoCoopetativa    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDERECOCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strBairroCooperativa      := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRROCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCidadeCooperativa      := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDADECOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEstadoCooperativa      := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTADOCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCEPCooperativa         := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEPCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;

    If (strNumBco = '237') And (strExibMsg <> 'N') then
    Begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr :=             AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 120 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 240 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := Copy(strObsAgr, 241, 120);
        End;

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60);
          strInstr4 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', ''), 60);
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60);
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;
      end
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', ''), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', ''), 60));

        pImprimirNroDocHistConfig();
      End;
    End;

  End
  Else If (strNumBco = '741') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');

    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    //*************************************************//
    // DEPOIS DE MUITA LUTA, O BANCO RIBEIRAO INFORMOU //
    // QUE O NOSSO NUMERO CORRETO TEM A SEGUINTE MASK  //
    //  19/10000571603-4                               //
    //                                                 //
    // COMO A CARTEIRA E EXPORTADA EM OUTRO CAMPO,     //
    // ENTAO DEVEMOS EXPORTA SOMENTE O NN + DIG        //
    //                                 11 + 1          //
    //**********************************************ED*//
    strNosNum := strNosNum + strNumDig;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;
      end
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        pImprimirNroDocHistConfig();
      End;
    end;


  End

  Else If (strNumBco = '104') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If ((strEspDoc = 'AG') And FObsDupAgr) And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fPadL(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto), 4);

    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
    Begin
      If strCodCar = '01' Then
        strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig
      ELse
        strNosNum  := fStrZero(RightStr(strNosNum, 10), 10) + strNumDig;
    End
    Else
    Begin
      If strCodCar = '01' Then
        strNosNum  := fStrZero(RightStr(strNosNum, 12), 12)
      Else
        strNosNum  := fStrZero(RightStr(strNosNum, 11), 11);
    End;

    if strExibMsg <> 'N' then
    begin
      If ((strEspDoc = 'AG') And FObsDupAgr) And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SISCOB', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
      strSisCob := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SISCOB', '', strEmpresaCarteira, @LDuplicataBoleto);

  End
  Else If (strNumBco = '341') or (strNumBco = '995') Or (strNumBco = '707') Or (strNumBco = '988') Or (strNumBco = '981') Or (strNumBco = '964') Then
  Begin

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S' Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;


    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
    LQRCode   := AnsiReplaceStr(cpuCampos['CADREC->CTR_QRCODE'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strNumBco = '707' then
    Begin
      strCodCed  := fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'NUMCTAC', '',strEmpresaCarteira, @LDuplicataBoleto) +
                    fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'DIGCTAC', '',strEmpresaCarteira, @LDuplicataBoleto);
      strDigAgen := Copy(strCodAgen, Length(strCodAgen),1);
      strCodAgen := Copy(strCodAgen, 0, Length(strCodAgen)-1);
    End
    Else
      strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '',strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strTipDia  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA', '1', strEmpresaCarteira, @LDuplicataBoleto);
    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(RightStr(strNosNum, 08), 08) + strNumDig
    Else
      strNosNum  := fStrZero(RightStr(strNosNum, 09), 09);

    If strBcoIni = '341' Then
      CarregaDadosProtestoBancoItau;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    //*************************************************//
    // TRAVA QUE FOI CRIADA PARA NAO EXPORTAR O CNPJ   //
    // DO CEDENTE.                                     //
    // HOUVE CASOS DE CLIENTES QUE A IMPRESSAO DOS     //
    // BOLETOS ERA FEITA SOMENTE NA MATRIZ, DAI ENTAO  //
    // ERA IMPRESSO O CNPJ DA MATRIZ, MESMO SE O CLIEN.//
    // HAVIA REALIZADO A COMPRA EM UMA FILIAL          //
    //**********************************************ED*//
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXPCNPJ', '', strEmpresaCarteira, @LDuplicataBoleto) = 'N' Then
      strCgcEmp := '';

    strEspDoc := 'DM';

    If (strNumBco = '995') Or (strNumBco = '981') Then
     strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto)+
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    if strNumBco = '341' then
    begin
      if not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', '', strEmpresaCarteira, @LDuplicataBoleto))  then
      Begin
        qryCadEmp := fCriaQuery;
        Try
          pPesquisaCadEmp(Nil,qryCadEmp, (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', '', strEmpresaCarteira, @LDuplicataBoleto)));

          strEndEmp := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
          strEndEmp := strEndEmp + IIF(fEmptyStr(qryCadEmp.FieldByName('EMP_ENDNUM').AsString),'',', ' + qryCadEmp.FieldByName('EMP_ENDNUM').AsString);
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
          strEndEmp := strEndEmp + ' - ' + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;

          strCgcEmp  := qryCadEmp.FieldByName('EMP_C_G_C_').AsString;
          strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

          if fEmptyStr(fCfgSis('NOMCED')) then
            strNomEmp := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
        Finally
          FreeAndNil(qryCadEmp);
        End;
      End;
    end;

  End

  //****************************************************
  //*   BANCO ABC BRASIL                               *
  //****************************************************
  Else If (strNumBco = '246') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODBENE', '',strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strTipDia  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA', '1', strEmpresaCarteira, @LDuplicataBoleto);
    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    strNroOpe  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(RightStr(strNosNum, 10), 10) + strNumDig
    Else
      strNosNum  := fStrZero(RightStr(strNosNum, 11), 11);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    //*************************************************//
    // TRAVA QUE FOI CRIADA PARA NAO EXPORTAR O CNPJ   //
    // DO CEDENTE.                                     //
    // HOUVE CASOS DE CLIENTES QUE A IMPRESSAO DOS     //
    // BOLETOS ERA FEITA SOMENTE NA MATRIZ, DAI ENTAO  //
    // ERA IMPRESSO O CNPJ DA MATRIZ, MESMO SE O CLIEN.//
    // HAVIA REALIZADO A COMPRA EM UMA FILIAL          //
    //**********************************************ED*//
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXPCNPJ', '', strEmpresaCarteira, @LDuplicataBoleto) = 'N' Then
       strCgcEmp := '';

    strEspDoc := 'DM';

  End

  //****************************************************
  //*   BANCO BTG PACTUAL                              *
  //****************************************************
  Else If (strNumBco = '208') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strTipDia := '0';
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['1','5']) Then // CORRIDOS
       strTipDia := '2'
    Else
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['2','4']) Then // UTEIS
       strTipDia := '1';

    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    //strNroOpe  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
       strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig
    Else
       strNosNum  := fStrZero(RightStr(strNosNum, 12), 12);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    strEspDoc := 'DM';

  End

//****************************************************
  //*   BANCO GERENCIANET
  //    MF: 284963 - 13/07/23                               *
  //****************************************************
  Else If (strNumBco = '364') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMAGEC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strTipDia := '0';
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['1','5']) Then // CORRIDOS
       strTipDia := '2'
    Else
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['2','4']) Then // UTEIS
       strTipDia := '1';

    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    //strNroOpe  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    //If strReimpr = 'N' Then
    //   strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig
    //Else
    //   strNosNum  := fStrZero(RightStr(strNosNum, 12), 12);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    strEspDoc := 'DM';

  End

  //**************************************************
  //*   BANCO CRESOL                                 *
  //    MF: 287323 - 14/07/23                        *
  //**************************************************
  Else If (strNumBco = '133') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strTipDia := '0';
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['1','5']) Then // CORRIDOS
       strTipDia := '2'
    Else
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['2','4']) Then // UTEIS
       strTipDia := '1';

    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    //strNroOpe  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
       strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig
    Else
       strNosNum  := fStrZero(RightStr(strNosNum, 12), 12);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    strEspDoc := 'DM';

  End

  //*************************************************//
  // EXPORTADOR REFERENTE AO BANCO BANRISUL          //
  //**********************************************ED*//
  Else If (strNumBco = '041') Then
  Begin

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(RightStr(strNosNum, 08), 08) + strNumDig
    Else
      strNosNum  := strNosNum;

  End

  {***************************************}
  {* EXPORTADOR REFERENTE AO BANCO INTER *}
  {************************************AJ*}
  Else If (strNumBco = '077') Then
  Begin
    strCedenteInter := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strInstr1 := '';
    strInstr2 := '';
    strInstr3 := '';
    strInstr4 := '';
    strInstr5 := '';

    If (Not fEmptyStr(strMens01)) Then
      strInstr1  := fPadR(strMens01, 60);

    strInstrucaoBancoInter1 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV1', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
    strInstrucaoBancoInter2 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV2', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
    strInstrucaoBancoInter3 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
    strInstrucaoBancoInter4 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
    strInstrucaoBancoInter5 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
  End

  //*************************************************//
  // EXPORTADOR REFERENTE AO SICREDI                 //
  //**********************************************ED*//
  Else If ((strNumBco = '748') and (strBcoIni <> '748API')) Then
  Begin
    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S' Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
    Begin
      strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

      If Length(strObsAgr) <= 120 Then
      Begin
        strObsAgrup1 := LeftStr(strObsAgr, 120);
        strObsAgrup2 := '';
        strObsAgrup3 := '';
      End
      Else If Length(strObsAgr) <= 240 Then
      Begin
        strObsAgrup1 := LeftStr(strObsAgr, 120);
        strObsAgrup2 := Copy(strObsAgr, 121, 120);
        strObsAgrup3 := '';
      End
      Else
      Begin
        strObsAgrup1 := LeftStr(strObsAgr, 120);
        strObsAgrup2 := Copy(strObsAgr, 121, 120);
        strObsAgrup3 := Copy(strObsAgr, 241, 120);
      End;
    End;

    if strReimpr = 'N' then
    begin
      strConRem := fAtualizaProCod('CONREM', 'CTR_CONREM', 'CADREC');
      fExecutaSQL(' UPDATE   ' +
                  '   CADREC ' +
                  ' SET      ' +
                  '   CTR_CONREM = "'+strConRem+'" ' +
                  ' WHERE    ' +
                  '    CTR_NUMDUP = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '')+'" AND ' +
                  '    CTR_PARCEL = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '')+'" AND ' +
                  '    CTR_SEQBAI = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_SEQBAI'], #39, '')+'" AND ' +
                  '    CTR_ESPDOC = "'+strEspDoc+'" AND ' +
                  '    CTR_CODCLI = "'+strCodCli+'" AND ' +
                  '    CTR_CODEMP = "'+strCodEmp+'" ');
    end
    else strConRem := AnsiReplaceStr(cpuCampos['CADREC->CTR_CONREM'], #39, '');

    If strReimpr = 'N' Then
      strNosNum := fStrZero(RightStr(strNosNum, 08), 08) + strNumDig
    Else
      strNosNum := strNosNum;

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'POSTOCO', '', strEmpresaCarteira, @LDuplicataBoleto) +
                 fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCobReg := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'COBREGI', '', strEmpresaCarteira, @LDuplicataBoleto);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        {****************************************}
        {* PRIORIZA AS OBS DA CARTEIRA E TRUNCA *}
        {* AS OBS DO AGRUPAMENTO SE FOR O CASO  *}
        {*************************************JS*}
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        If fEmptyStr(strInstr3) And fEmptyStr(strInstr4) And fEmptyStr(strInstr5) Then
        Begin
          strInstr3 := strObsAgrup1;
          strInstr4 := strObsAgrup2;
          strInstr5 := strObsAgrup3;
        End
        Else If (Not fEmptyStr(strInstr3)) And fEmptyStr(strInstr4) And fEmptyStr(strInstr5) Then
        Begin
          strInstr4 := strObsAgrup1;
          strInstr5 := strObsAgrup2;
        End
        Else If (Not fEmptyStr(strInstr3)) And (Not fEmptyStr(strInstr4)) And fEmptyStr(strInstr5) Then
        Begin
          strInstr5 := strObsAgrup1;
        End;
      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

  End

  //*************************************************//
  // EXPORTADOR REFERENTE AO BANESPA                 //
  //**********************************************ED*//
  Else If (strNumBco = '033') And (Pos(strBcoIni,'033B_033B240p_') <= 0) And (Not strBcoIni.Contains('API')) Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 120 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 240 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := Copy(strObsAgr, 241, 120);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 10) + strNumDig
    Else
      strNosNum := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

  End

  {***********************************}
  {* SANTANDER 033                   *}
  {********************************AF*}
  Else If (strNumBco = '033') And (Pos(strBcoIni,'033B_033B240p_033API_') > 0) Then
  Begin
    strNumBco := '33B';
    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strTipDia := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA', '1', strEmpresaCarteira, @LDuplicataBoleto);

    If Length(strCodAgen) > 4 Then
      strDigAgen := RightStr(strCodAgen,1)
    Else
      strDigAgen := ' ';

    If (strReimpr = 'N') And (Not strBcoIni.Equals('033API')) Then
      strNosNum := RightStr(strNosNum, 7) + strNumDig
    Else
      strNosNum := strNosNum;

    If strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin

        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 120 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 240 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := Copy(strObsAgr, 241, 120);
        End;

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

    if (strBcoIni = '033B240p') then
    Begin
      strNumBco := '3B2';
      strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEDENTE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCodCar  := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPOCOB', ''),1);
    End;

  End

  {***********************************}
  {* BANESTES 021                    *}
  {********************************AF*}
  Else If (strNumBco = '021') Then
  Begin
    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    If Length(strCodAgen) > 4 Then
      strDigAgen := RightStr(strCodAgen,1)
    Else
      strDigAgen := ' ';

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 8) + strNumDig
    Else
      strNosNum := strNosNum;
  End

  Else If ((strNumBco = '422') and (strBcoIni = '422API')) Then
  Begin
    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

  End

  {*****************************************}
  {* BANCO SAFRA 422                       *}
  {**************************************AF*}
  Else If ((strNumBco = '422') and (strBcoIni <> '422API')) Then
  Begin
    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strIdeCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENCED', '', strEmpresaCarteira, @LDuplicataBoleto);
    strUsoCli := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'USOCLIE', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDigAgen := RightStr(strCodAgen,1);

    If SameText(strReimpr,'N') Then
      strNosNum := fStrZero(RightStr(strNosNum, 8), 8) + strNumDig
    Else
      strNosNum := strNosNum;

    If strBraCrr = 'S' Then
    Begin
      If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INDBRAD', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
        intIndCar := StrToIntDef(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INDBRAD', '', strEmpresaCarteira, @LDuplicataBoleto), 0)
      Else
      Begin
        fMensagem('','Informe o índice da carteira correspondente Bradesco nas configurações do Safra (Autban)!', ['&OK']);
        Result := False;
        Exit;
      End;

      strCodCed := fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);            //
      strCodCed := strCodCed + fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);//
      strCodAgen:= fPadL(fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto), 4);  //HOMOLOGAÇÃO IMPERIO
      strDigAgen:= fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);            //
      strCodCar := fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);            //

      strDesCed  := 'BANCO SAFRA S/A';
      strEndCed  := '';
      strCompCed := '';
      strBaiCed  := '';
      strCidCed  := '';
      strEstCed  := '';
      strCepCed  := '';
      strCgcCed  := '';
      strUsoBco  := 'CIP130';

      If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG237-' + IntToStr(intIndCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
      Begin
        strNosNum := fCalcNossoNumero('237', FormatDateTime('yy', VS_Date) + strNosNum, '237', intIndCar, VS_strCodEmp);
        strNumDig := fCalcDigito('237', strNosNum, '237', intIndCar, VS_strCodEmp);
        strNosNum := strNosNum + strNumDig;
        strCodCed := RightStr(strCodCed, 8);
      End
      Else
      Begin
        fMensagem('','Configure a carteira ' + IntToStr(intIndCar) + ' do Bradesco para a loja ' + VS_strCodEmp + ' para utilizar o Safra com correspondente (Autban)!', ['&OK']);
        Result := False;
        Exit;
      End;
    End;

    fltDescon := fStrToFloat(fGetBancoConfig(0, 'CONFIG422', 'DESCONT', '', strEmpresaCarteira, @LDuplicataBoleto));
    strDescon := fPadL(FloatToStr(fFormataFloat(fltDescon, 02) * 100), 14, '0');

    strEspDoc := 'DM';


    If strNumBco = '422' then
    begin
      if not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', ''))  then
      Begin
        qryCadEmp := fCriaQuery;
        Try
          pPesquisaCadEmp(Nil,qryCadEmp, (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', '')));

          strEndEmp := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
          strEndEmp := strEndEmp + IIF(fEmptyStr(qryCadEmp.FieldByName('EMP_ENDNUM').AsString),'',', ' + qryCadEmp.FieldByName('EMP_ENDNUM').AsString);
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
          strEndEmp := strEndEmp + ' - ' + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;

          strCgcEmp  := qryCadEmp.FieldByName('EMP_C_G_C_').AsString;
          strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

          if fEmptyStr(fCfgSis('NOMCED')) then
            strNomEmp := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
        Finally
          FreeAndNil(qryCadEmp);
        End;
      End;
    end;

  End

  //*************************************************//
  // EXPORTADOR REFERENTE AO SANTANDER               //
  //**********************************************LU*//
  Else If (strNumBco = '353') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 10) + strNumDig
    Else
      strNosNum := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

  End

  //*************************************************//
  // BANCO SOFISA REFERENTE AO SANTANDER             //
  //*************************************************//
  Else If (strNumBco = '637') And (strBcoIni <> '637LP444p') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 12) + strNumDig
    Else
      strNosNum := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

  End

  //*************************************************//
  // BANCO SOFISA 637 LP - LAYOUT PROPRIO            //
  //*************************************************//
  Else If (strNumBco = '637') And (strBcoIni = '637LP444p') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar      := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CARTBCO', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaMora     := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAMORA', '0', strEmpresaCarteira, @LDuplicataBoleto);
    strNumOperacao := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 10) + strNumDig
    Else
      strNosNum := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

  End

  Else If (strNumBco = '001') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;


    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');

    If ((Trim(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + intToStr(intCodCar), 'TIPCOBR', '', strEmpresaCarteira, @LDuplicataBoleto)) = 'D') And
      Not (Pos('D7', strBcoIni) > 0)) Then
    Begin
      strPerMor := fPadL('0', 14, '0');
      strValMor := fPadL('0', 14, '0');
    End
    Else
    Begin
      strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
      strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');
    End;

    {EDUARDO }
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strTipDia  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA', '1', strEmpresaCarteira, @LDuplicataBoleto);

    strVariacao := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'VARCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    strSacAva := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto), 21);
    if Not fEmptyStr(strSacAva) Then
  	  strSacAva := strSacAva + ' ' + fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJSAC', '', strEmpresaCarteira, @LDuplicataBoleto), 18);

    If strReimpr = 'N' Then
    Begin
      If Pos('D7', strBcoIni) > 0 Then
        strNosNum  := fStrZero(RightStr(strNosNum, 10), 10) + strNumDig
      Else
        strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig;
    End
    Else
      strNosNum  := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := '';
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := '';
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    If strBcoIni = '001D7' Then
    Begin
      fltDescon := fStrToFloat(fGetBancoConfig(0, 'CONFIG001D7', 'DESCONT', ''));
      strDescon := fPadL(FloatToStr(fFormataFloat(fltDescon, 02) * 100), 14, '0');
      CarregaDadosProtestoBancoDoBrasil7D;
    End;

    If (strBcoIni = '001') Or (strBcoIni = '001D7') Then
    begin
      if not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', ''))  then
      Begin
        qryCadEmp := fCriaQuery;
        Try
          pPesquisaCadEmp(Nil,qryCadEmp, (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', '', strEmpresaCarteira, @LDuplicataBoleto)));

          strEndEmp := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
          strEndEmp := strEndEmp + IIF(fEmptyStr(qryCadEmp.FieldByName('EMP_ENDNUM').AsString),'',', ' + qryCadEmp.FieldByName('EMP_ENDNUM').AsString);
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
          strEndEmp := strEndEmp + ' - ' + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;

          strCgcEmp  := qryCadEmp.FieldByName('EMP_C_G_C_').AsString;
          strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

          if fEmptyStr(fCfgSis('NOMCED')) then
            strNomEmp := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
        Finally
          FreeAndNil(qryCadEmp);
        End;
      End;

    end;

    If fCfgSis('BENBOL', varBoolean) And (Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'CPFBENE', '')))  Then
    Begin
      strNomEmp := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NOMBENE', '');
      strCgcEmp := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'CPFBENE', '');
      strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');
    End;

    strEspDoc := 'DM';

  End

  {*************************************************}
  { BANCO CREDISIS                                  }
  {**********************************************JB*}
  Else If (strNumBco = '097') Then
  Begin

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto),2);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    //strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strEspDocBol := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TPTITULO', '03', strEmpresaCarteira, @LDuplicataBoleto);
    strEspDoc := fRetEspDocBoleto( leftStr(strEspDocBol,2) );

    If strReimpr = 'N' Then
       strNosNum  := fStrZero(strNosNum, 20) //+ strNumDig
    Else
       strNosNum  := fStrZero(strNosNum, 20);

    strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
    strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
    strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

    pImprimirNroDocHistConfig();

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;

  End

  Else If (strNumBco = '409') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(strNosNum, 10) + strNumDig
    Else
      strNosNum  := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    strEspDoc := 'DM';

    If StrToIntDef(strCodCar, 0) = 20 Then
      strUsoCli  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

  End

  Else If (strNumBco = '356') Then
  Begin

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODEMPR', '', strEmpresaCarteira, @LDuplicataBoleto);
    strNosNum := strNosNum;

  End

  Else If (strNumBco = '399') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := '';
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strModali  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CBRAREG', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCDEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    If strModali = 'N' Then
    Begin
      strTpIden := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TPIDENT', '', strEmpresaCarteira, @LDuplicataBoleto);

    End;
    If strReimpr = 'N' Then
    Begin

      If strModali = 'S' Then
        strNosNum := fStrZero( RightStr(strNosNum, 10) + strNumDig , 11)
      Else
        strNosNum := fStrZero( strNosNum + strNumDig, 13);

    End
    Else
    Begin

      If strModali = 'S' Then
        strNosNum := fStrZero( RightStr(strNosNum, 11), 11)
      Else
        strNosNum := fStrZero( RightStr(strNosNum, 13), 13);

    End;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
  End

  {*****************************************}
  {* NOSSA CAIXA NOSSO BANCO               *}
  {**************************************AF*}
  Else If (strNumBco = '151') Then
  Begin
    strCodConv := '';
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strModali  := IIf(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPCOBR', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S', '8', '9');
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'MODALID', '', strEmpresaCarteira, @LDuplicataBoleto) +
                  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := fStrZero(RightStr(strNosNum, 9), 9) + strNumDig
    Else
      strNosNum := fStrZero(strNosNum, 10);
  End

  {*******************}
  {* BANCO MERCANTIL *}
  {****************JU*}
  Else If (strNumBco = '389') Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := '';
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strModali  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CBRAREG', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    If strReimpr = 'N' Then
      strNosNum := fStrZero(strNosNum, 10) + strNumDig
    Else
      strNosNum := fStrZero(strNosNum, 11);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
  End

  {*******************}
  {* B. DO NORDESTE  *}
  {*REQ-95543******MO*}
  Else If (strNumBco = '004') Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
    Begin
      strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

      If Length(strObsAgr) <= 58 Then
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := '';
        strObsAg3 := '';
      End
      Else If Length(strObsAgr) <= 116 Then
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := Copy(strObsAgr, 59, 56);
        strObsAg3 := '';
      End
      Else
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := Copy(strObsAgr, 59, 56);
        strObsAg3 := Copy(strObsAgr, 115, 58);
      End;
    End;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);
    strNosNum := fStrZero(strNosNum, 7);

    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
    Begin

      If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := strObsAg1;
      End
      Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := strObsAg1;
        strInstr5 := strObsAg2;
      End
      Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr3 := strObsAg1;
        strInstr4 := strObsAg2;
        strInstr5 := strObsAg3;
      End;

    End
    Else
    Begin
      strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
    End;
  End

  {*******************}
  {* BANCO CECRED    *}
  {*REQ-29077******JU*}
  Else If (strNumBco = '085') Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');


    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCOPE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCOPE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strModali  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CBRAREG', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
  End

  {*******************}
  {* BANCO BRB       *}
  {*******************}
  Else If (strNumBco = '070') Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    if strReimpr = 'N' then
    begin
      strConRem := fAtualizaProCod('CONREM', 'CTR_CONREM', 'CADREC');
      fExecutaSQL(' UPDATE   ' +
                  '   CADREC ' +
                  ' SET      ' +
                  '   CTR_CONREM = "'+strConRem+'" ' +
                  ' WHERE    ' +
                  '    CTR_NUMDUP = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '')+'" AND ' +
                  '    CTR_PARCEL = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '')+'" AND ' +
                  '    CTR_SEQBAI = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_SEQBAI'], #39, '')+'" AND ' +
                  '    CTR_ESPDOC = "'+strEspDoc+'" AND ' +
                  '    CTR_CODCLI = "'+strCodCli+'" AND ' +
                  '    CTR_CODEMP = "'+strCodEmp+'" ');
    end
    else strConRem := AnsiReplaceStr(cpuCampos['CADREC->CTR_CONREM'], #39, '');

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar  := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    strDigit1  := '';
    strDigit2  := '';

    strChaveBRB := strNosNum;
    strCedenteBRB := IntToStr(StrToInt64(strCodCed));

    If Length(strCedenteBRB) < 7 Then
      strCedenteBRB := fStrZero(strCedenteBRB, 7);

    strChaveBRB := Copy(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODMOD_', '', strEmpresaCarteira, @LDuplicataBoleto), 1 , 1) + strChaveBRB + '070';
    strChaveBRB := '000' + RightStr(strCodAgen, 3)+ strCedenteBRB + strChaveBRB;
    strDigit1   := fCalcDigitoModulo10(strChaveBRB);
    strDigit2   := fCalcDigitoModulo11(strChaveBRB, strDigit1);
    strChaveBRB := strChaveBRB + strDigit1 + strDigit2;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
  End

  {*******************}
  {* BANCO UNICRED   *}
  {*REQ-30140******JU*}
  Else If Pos(strNumBco, '090_136_') > 0 Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    If strReimpr = 'N' Then
      strNosNum := fStrZero(strNosNum, 10) + strNumDig
    Else
      strNosNum := fStrZero(strNosNum, 11);

    If strBraCrr = 'S' Then
    Begin
      strDesCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DESCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCompCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strBaiCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAICORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCidCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEstCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      intIndCar  := StrToInt(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INDCART', '', strEmpresaCarteira, @LDuplicataBoleto));
      strCepCed  := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEPCORR', '', strEmpresaCarteira, @LDuplicataBoleto));
      strCgcCed  := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CGCCORR', '', strEmpresaCarteira, @LDuplicataBoleto), True, True, True);
      strUsoBco  := '';

      strNosNum := fCalcNossoNumero('237', LeftStr(strNosNum,11), '237', intIndCar, VS_strCodEmp);
      strNumDig := fCalcDigito('237', strNosNum, '237', intIndCar, VS_strCodEmp);
      strNosNum := strNosNum + strNumDig;
      strCodCed := RightStr(strCodCed, 8);
    End;


    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
    If strNumBco = '136' Then
    Begin
      strNomEmp := IIF(fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NOMBENE', '', strEmpresaCarteira, @LDuplicataBoleto)),strNomEmp,
                                 fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NOMBENE', '', strEmpresaCarteira, @LDuplicataBoleto));
    End;
    ImprimirObservacaoCompletaAG;
  End
  {*********************}
  {* BANCO DA AMAZONIA *}
  {******************JU*}
  Else If (strNumBco = '003') Then
  Begin
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCntCor  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strNosNum  := fPadL(strNosNum, 12, '0');
  End;

  {****************************************************}
  {* PEGA O PERCENTUAL DE MULTA CONFIGURADO NO AUTBAN *}
  {*************************************************JC*}
  fltPerMul := IIF(fltMulta>0,fltMulta,fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PERMULT', '0', strEmpresaCarteira, @LDuplicataBoleto)));

  If AReimprimirBoletoOriginal Then
  Begin
    fltPerMul := fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PERMULT', '0', strEmpresaCarteira, @LDuplicataBoleto));
  End;

  {********************************************************}
  {* CALCULA O VALOR DA MULTA QUE SERA IMPRESSO NO BOLETO *}
  {*****************************************************JC*}
  strValMul := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMul / 100.0, 02) * 100), 14, '0');

  strPerMul := fPadL(FloatToStr(fFormataFloat(fltPerMul, 02) * 100), 14, '0');

  If (strNumBco = '246') Then
  Begin
    strValMul := '00000000000000';

    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TPMULTA', '0', strEmpresaCarteira) <> '0') Then
    Begin
      strValMul := FormatFloat('#,##0.00',fFormataFloat(fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'VALMULT', '0', strEmpresaCarteira, @LDuplicataBoleto)),02));

      If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TPMULTA', '0', strEmpresaCarteira, @LDuplicataBoleto) = '2') Then
      Begin
        fltPerMul := fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'VALMULT', '0', strEmpresaCarteira, @LDuplicataBoleto));
        strValMul := FormatFloat('#,##0.00',fFormataFloat(fltValTit * fltPerMul / 100.0, 02));
      End;
    End;

    strValMul := strValMul.Replace(',','');
    strValMul := strValMul.Replace('.','');
    strValMul := fPadL(strValMul,14, '0');
  End;

  {**********************************************************}
  {* PREENCHE INSTR05 COM MSG DE DESCONTO SE CTR_DESSUJ > 0 *}
  {*******************************************************IV*}
  strDesSuj := AnsiReplaceStr(cpuCampos['CADREC->CTR_DESSUJ'], '.', ',');
  If (fEmptyStr(strDesSuj)) Then
    strDesSuj := '0';
  fltDesSuj := fFormataFloat(fStrToFloat(strDesSuj), 02);

  If LValorDoTituloComDescontoSugerido Then
    fltDesSuj := 0.00;

  If fltDesSuj > 0 Then
  Begin
    strDesSuj := 'CONCEDER DESCONTO DE R$' + FloatToStrF(fltDesSuj, ffFixed, 12, 2) + ' SE PAGO ATE O VENCIMENTO.';

    If fEmptyStr(strInstr5) Then
      strInstr5 := strDesSuj
    Else If fEmptyStr(strInstr4) Then
      strInstr4 := strDesSuj
    Else If fEmptyStr(strInstr3) Then
      strInstr3 := strDesSuj
    Else
    Begin
      strInstr5 := strInstr4;
      strInstr4 := strInstr3;
      strInstr3 := strDesSuj;
    End;

  End;
  {**********************************************************}

  strCliCgc := fTiraCaracEspeciais(strCliCgc);
  strCgcEmp := fTiraCaracEspeciais(strCgcEmp);

  {********************************************}
  {* IMPRIMIR PARCELA "A" PARA VENDAS A VISTA *}
  {****************************REQ. 133539**AJ*}
  strImprimeParcelaA := 'S';
  If (cpuCampos['CADCLI->CLI_BOLPAR'] = QuotedStr('N')) And
     ((cpuCampos['CADREC->CTR_PARCEL'] = QuotedStr('A')) Or
      (cpuCampos['CADREC->CTR_PARCEL'] = QuotedStr('001'))) Then
  Begin
    qryQtdeParcelas := fCriarQuery('SELECT COUNT(CTR_PARCEL) AS PARCELAS FROM ( ' +
                                   ' SELECT CTR_PARCEL FROM CADREC              ' +
                                   ' WHERE CTR_NUMDUP=' + cpuCampos['CADREC->CTR_NUMDUP'] +
                                   '   AND CTR_ESPDOC=' + cpuCampos['CADREC->CTR_ESPDOC'] +
                                   '   AND CTR_CODEMP=' + cpuCampos['CADREC->CTR_CODEMP'] +
                                   '   AND CTR_CODCLI=' + cpuCampos['CADREC->CTR_CODCLI'] +
                                   '   AND CTR_SEQBAI=0                         ' +
                                   'UNION ALL                                   ' +
                                   ' SELECT CTR_PARCEL FROM DUPAGR              ' +
                                   ' WHERE CTR_NUMDUP=' + cpuCampos['CADREC->CTR_NUMDUP'] +
                                   '   AND CTR_ESPDOC=' + cpuCampos['CADREC->CTR_ESPDOC'] +
                                   '   AND CTR_CODEMP=' + cpuCampos['CADREC->CTR_CODEMP'] +
                                   '   AND CTR_CODCLI=' + cpuCampos['CADREC->CTR_CODCLI'] +
                                   '   AND CTR_SEQBAI=0                         ' +
                                   ' ) AS TMP                                   ');

    qryQtdeParcelas.Open;
    If qryQtdeParcelas.FieldByName('PARCELAS').AsInteger = 1 Then
      strImprimeParcelaA := 'N';

    FreeAndNil(qryQtdeParcelas);
  End;

  If Not fEmptyStr(strMsgProrrogacao) And (fCfgSis('SELOBS', varBoolean, VS_strCodEmp)) Then
    pPreencherInstrucaoVazia(strMsgProrrogacao);

  strLinha := fPadR(strNumBco,    003, '0')                     + // (01) Identificação do Banco
              strTipEmp                                         + // (02) Tipo de Inscrição da empresa(01 - CGC / 02 - CNPJ)
              fPadR(strCgcEmp,    014)                          + // (03) Numero de inscrição da empresa
              fPadR(strNomEmp,    060)                          + // (04) Nome do cedente
              fPadR(strCodAgen,   004)                          + // (05) Numero da Agencia
              fPadR(strCodCed,    020)                          + // (06) Codigo do cedente
              fPadR(strNosNum,    015)                          + // (07) Nosso numero
              fPadR(strNumDup,    015)                          + // (08) Numero do documento
              fPadR(strEspDoc,    007)                          + // (09) Espécie do documento
              FormatDateTime('ddmmyyyy', StrToDate(strDtaVen))  + // (10) Data de vencimento
              strValTit                                         + // (11) Valor nominal do título
              strDesCob                                         + // (12) Valor desconto
              fPadR(strCodCar,    003)                          + // (13) código da carteira
              fPadR('R$',         004)                          + // (14) espécie do título
         {'N'}fPadR(strProAce,    001)                          + // (15) Identificação de aceite (A)ceito (N)ão aceito
              FormatDateTime('ddmmyyyy', StrToDate(strDtaCad))  + // (16) Data de emissao
              FormatDateTime('ddmmyyyy', VS_Date)               + // (17) Data processamento
              strValMor                                         + // (18) Mora diaria
              strTipSac                                         + // (19) Tipo de Inscrição do sacado (01 - CGC / 02 - CPF)
              fPadR(strCliCgc,    014)                          + // (20) Numero de inscrição do sacado
              fPadR(strNomCli,    040)                          + // (21) Nome do sacado
              fPadR(strEndere,    140)                          + // (22) Endereço do sacado
              fPadR(strBaiCli,    060)                          + // (23) Bairro do sacado
              fPadR(strNumCep,    008)                          + // (24) CEP do sacado
              fPadR(strNomCid,    040)                          + // (25) Cidade do Sacado
              fPadR(strEstado,    002)                          + // (26) UF do sacado
              fPadR(VS_strRazSoc, 040)                          + // (27) Nome do sacador avalista
              fPadR(strDiaProt,   002)                          + // (28) Prazo para protesto
              fPadL('',           060)                          + // (29) Local de pagamento
              fPadL(strUsoBan,    010)                          + // (30) Uso do banco
              fPadL(strInstr1,    060)                          + // (31) Instrução 1
              fPadL(strInstr2,    060)                          + // (32) Instrução 2
              fPadL(strInstr3,    060)                          + // (33) Instrução 3
              fPadL(strInstr4,    060)                          + // (34) Instrução 4
              fPadL(strInstr5,    060)                          + // (35) Instrução 5
              fPadL(strCodConv,   007)                          + // (36) Código Convenio (Banco Brasil)
              fPadR(strDigAgen,   001)                          + // (37) Digito agencia
              fPadR(strCodCli,    008)                          + // (38) Código do cliente no CADREC
              fPadR(strModali,    004)                          + // (39) Modalidade de cobrança
              fPadL(strPerMor,    014, '0')                     + // (40) Percentual de Mora Diaria
              fPadR(strProAce,    001)                          + // (41) Imprime protocolo de aceite
              fPadR(strDigAgen,   002)                          + // (42) Digito agencia (2 CARACTERES)
              fPadR(strCodCar,    004)                          + // (43) Carteira (4 CARACTERES)
              fPadR(strVariacao,  003)                          + // (44) Variacao
              fPadR(strDescon,    014)                          + // (45) Desconto (Banco do Brasil 7 digitos)
              fPadR(strEndEmp,    160)                          + // (46) Endereço completo do cedente
              fPadR(strIdeCed,    006)                          + // (47) Identificação do cedente
              fPadR(strUsoCli,    017)                          + // (48) Uso do cliente
              fPadR(strDigCed,    002)                          + // (49) Digito do Cedente
              fPadR(strTipDia,    001)                          + // (50) Tipo de dias para protesto
              fPadL(strValMul,    014, '0')                     + // (51) Valor da multa
              fPadL(strOutAcr,    014, '0')                     + // (52) Outros Acrescimos
              fPadR(strSisCob,    005)                          + // (53) COBRANÇA CEF (SICOB, SIGCB OU SINCO)
              fPadR(strBB_Crr,    001)                          + // (54) Para Bancoob - se usa Banco do Brasil como correspondente
              fPadR(strConCrr,    010)                          + // (55) Convênio Correspondente - Para Bancoob 240 com Banco do Brasil como correspondente
              fPadR(strCobReg,    001)                          + // (56) Cobrança Registrada S/N
              fPadR(strSacAva,	  040)						              + //(57) Sacador / Avalista
              strTpIden                                         + //(58) TIPO IDENTIFICADOR, COBRANÇA SEM REGISTRO, HSBC;
              fPadR(IIF(Not fEmptyStr(strBraCrr),strBraCrr,' '),001)+ // (59) Para Bancos Safra/Unicred - se usa Bradesco como correspondente
              fPadR(strDesCed,   040)                           + //(60) Nome da agência do Unicred correspondente
              fPadR(strEndCed,   040)                           + //(61) Endereço da agência do Unicred correspondente
              fPadR(strCompCed,  040)                           + //(62) Complemento da agência do Unicred correspondente
              fPadR(strBaiCed,   040)                           + //(63) Bairro da agência do Unicred correspondente
              fPadR(strCidCed,   040)                           + //(64) Cidade da agência do Unicred correspondente
              fPadR(strEstCed,   002)                           + //(65) Estado da agência do Unicred correspondente
              fPadR(strCepCed,   008)                           + //(66) CEP da agência do Unicred correspondente
              fPadR(strCgcCed,   014)                           + //(67) CNPJ da agência do Unicred correspondente
              fPadR(strUsoBco,   006)                           + //(68) SE FOR SAFRA CORRESPONDENTE DEVE IR "CIP130", DEMAIS BANCOS DEVE IR EM BRANCO
              fPadL(strCodInstr1, 002, '0')                     + //(68) Código da primeira instrução
              fPadL(strCodInstr2, 002, '0')                     + //(69) Código da segunda instrução
              fPadL(strCodEmp,   003, '0')                      + //(70) Código da empresa na CADREC
              fPadR(strMailCli,  255)                           + //(71) Email do cliente
              fPadR(strBcoIni,   003)                           + //(72) Banco Inicial
              fPadR(strBenefi,   080)                           + //(73) Sacador/Avalista
              fPadR(strEndBen,   180)                           + //(74) Endereço Sacador/Avalista
              fPadR(strChaveBRB, 040)                           + //(75) Chave Banco BRB
              fPadR(strConRem,   020)                           + //(76) Sequencial que substitui a nossa chave para o banco BRB
              fPadR(strPerMul,   014)                           + //(77) Percentual da Multa
              fPadR(strInstr3,   120)                           + //(78) Instrução 3 Extendida
              fPadR(strInstr4,   120)                           + //(79) Instrução 4 Extendida
              fPadR(strInstr5,   120)                           + //(80) Instrução 5 Extendida
              fPadR(strImpAgBenef, 001)                         + //(81) Imprime Agência com Beneficiário
              fPadR(strRazaoSocialCooperativa, 060)             + //(82) Razão Social da Cooperativa
              fPadR(strIncrisaoCooperativa, 019)                + //(83) Inscrição da Cooperativa
              fPadR(strEnderecoCoopetativa, 060)                + //(84) Endereço da Cooperativa
              fPadR(strBairroCooperativa, 040)                  + //(85) Bairro da Cooperativa
              fPadR(strCidadeCooperativa, 040)                  + //(86) Cidade da Cooperativa
              fPadR(strEstadoCooperativa, 002)                  + //(87) Estavo da Cooperativa
              fPadR(strCEPCooperativa, 009)                     + //(88) CEP da Cooperativa
              fPadR(strCodProt, 001)                            + //(89) Código de Protesto (Apenas para Sicoob por enquanto)
              fPadR(strImprimeParcelaA, 001)                    + //(90) Imprimir parcela A
              fPadR(strEspDocOriginal,    005)                  + //(91) Especie Documento Padrao pelo AutCom
              fPadR(strNumDocumentoSemParcela, 012)             + //(92) Numero do documento sem parcela
              fPadR(strParcelaDoDocumento, 003)                 + //(93) Numero do documento sem parcela
              fPadR(ADiasCartorio,   002)                       + //(94) Prazo para Cartório
              fPadR(strParNum,    001)                          + //(95) Utilizar Parcela Numeral? (A = 001) REQ:158267 --> MT
              fPadR(strInTr5D,001)                              + //(96) Destaca em negrito a observacao 5 req: 159365
              fPadL(strInfAdi,   007,'0')                       + //(97) Informação Adicional (Carteira)
              fPadL(strCedenteInter,   009,'0')                 + //(98) Código do Cedente do banco Inter
              fPadR(strInstrucaoBancoInter1,   078)             + //(99) Linha1 da mensagem do banco Inter
              fPadR(strInstrucaoBancoInter2,   078)             + //(100) Linha2 da mensagem do banco Inter
              fPadR(strInstrucaoBancoInter3,   078)             + //(101) Linha3 da mensagem do banco Inter
              fPadR(strInstrucaoBancoInter4,   078)             + //(102) Linha4 da mensagem do banco Inter
              fPadR(strInstrucaoBancoInter5,   078)             + //(103) Linha5 da mensagem do banco Inter
              fPadL(strNroOpe,   007,'0')                       + //(104) Numero da operacao banco 246;
              fPadR(strObsAg1,                 120)             + //(105) Duplicatas Agrupadas Parte 1
              fPadR(strObsAg2,                 120)             + //(106) Duplicatas Agrupadas Parte 2
              fPadR(strObsAg3,                 120)             + //(107) Duplicatas Agrupadas Parte 3
              fPadR(LObsCompletaAG,            001)             + //(108) Observacao Completa AG
              fPadR(LCarteira,                 020)             + //(109) Identificação Banco
              fPadL(FApresentarEspDocumento,   001, 'N')        + //(110) Apresentar Esp. Documento no Boleto
              fPadL(strDiaMora,                010)             + //(111) a partir de quantos dias sera cobrada mora;
              fPadL(strNumOperacao,            020)             + //(112) Numero da operacao banco 637 LP;
              fPadL(strBcoIni,                 020)             + //(113) codigo do banco inicial completo
              fPadL(LQRCode,                   390)             + //(111) QRCODE
              fPadR(LParcelasNegritoCarne,     001)             + //(112) Destaca as parcelas em negrito em boletos com layout carnê
              fPadR(strCodCartBoleto,           03);              //(114) codigo da carteira do boleto no banco);

  pAtualizaDuplicataCodCedente(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCodCed);

  If Not fCfgSis('IMPBOD', varBoolean) Then
  Begin
    If fEmptyStr(strOpcFil) Then
      strPathBol := fCfgSis('PATLAS')
    Else
      strPathBol := strOpcFil;

    AssignFile(txtArqTxt, strPathBol + '\' + strNumBco + fSeqLaser + '.txt');
    Rewrite(txtArqTxt);
    WriteLn(txtArqTxt, strLinha);
    Flush(txtArqTxt);
    CloseFile(txtArqTxt);

    Result := True;
  End
  Else
  Begin
    Result := fProcessarArquivo(strLinha,
                                blnBolPdf,
                                ABoletoCarneBuilder,
                                ABoleto1ViaBuilder,
                                strNomeForm,
                                strNomeFila,
                                blnForcarImp,
                                blnEnvioDeEMailAutomatico,
                                blnBolEnvEmail,
                                blnEnvioFaturamento);
    strArqBoletos := strArqBoletos + ExtractFilePath(Application.ExeName) + 'Boletos\' + strNumDup + '.pdf,';
  End;

end;

procedure pAtualizaDuplicataCodCedente(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCodCed: String);
Var
 qryUpdate : TUniQuery;
begin
  qryUpdate := fCriaQuery;

  with qryUpdate do
  begin
    Sql.Clear;

    Sql.Text := ' UPDATE   ' +
                '   CADREC ' +
                ' SET      ' +
                '   CTR_CODCED = :CODCED ' +
                ' WHERE    ' +
                '   CTR_NUMDUP = :NUMDUP AND ' +
                '   CTR_PARCEL = :PARCEL AND ' +
                '   CTR_ESPDOC = :ESPDOC AND ' +
                '   CTR_CODEMP = :CODEMP AND ' +
                '   CTR_CODCLI = :CODCLI ';

    ParamByName('NUMDUP').AsString := Copy(strNumDup, 1, Length(Trim(strNumDup))-1);
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;


    ParamByName('CODCED').AsString := strCodCed;

    ExecSQL;

  end;

  qryUpdate.Free;


end;

function fSeqLaser: String;
Begin
  Result := fStrZero(fRetornaSequencialUnico('SEQLAS').ToString, 6);
end;

function fRetSequencialMovCar(strTblMovCar, strCodEmp: String; Var arrCartoes: TCartoesResumoCaixaArray): String;
  Var
    blnComitar: Boolean;
    intContador: Integer;
    blnGravaLog: Boolean;
begin
  blnGravaLog := VS_blnGravaLogTransacao;
  blnComitar := (Not frmModulo.GetCurrentConnection.InTransaction);

  Try
    If blnComitar Then
    Begin
      VS_blnGravaLogTransacao := False;
      fStartTransaction;
    End;

    For intContador := 0 To Length(arrCartoes) -1 Do
      arrCartoes[intContador].strNumDup := fRetSequencialMovCar(strTblMovCar, strCodEmp);

    If blnComitar Then
      fCommit;

    VS_blnGravaLogTransacao := blnGravaLog;
  Except
    On E: Exception Do
    Begin
      VS_blnGravaLogTransacao := blnGravaLog;
      If blnComitar Then
        fRollback;
      Raise;
    End;
  End;

end;

function fRetSequencialMovCar(strTblMovCar, strCodEmp: String): String;
  Var
    strSQL   : String;
    blnExiste: Boolean;
    qryGenCar: TUniQuery;

begin
  Try

    qryGenCar := fCriaQuery;

    Repeat

      Result := RightStr(fAtualizaProCod(strTblMovCar, ''), fTamDocCadRec);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COUNT(*) AS QTD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ' + strTblMovCar + ' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  MCA_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  MCA_CODEMP = :CODEMP     ';

      With qryGenCar Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := Result;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
        blnExiste := (FieldByName('QTD').AsInteger > 0);
        Close;
      End;

    Until (Not blnExiste);

  Finally
    FreeAndNil(qryGenCar);
  End;

end;

{**************************************}
{* PEGA O TOTAL DOS ITENS QUE TEM IPI *}
{***********************************AF*}
function fRetTotIte: Double;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin

  Try
    Result := 0;
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(ENT_TOTITE) AS TOTITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ENT_VALIPI > 0 ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      Result := FieldByName('TOTITE').AsFloat;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;


End;

function fDocumentoEmRomaneio(strNumDoc, strEspDoc: String; strCodEmp: String = ''): String;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(GER_NUMROM, "-", GER_EMPROM) AS GER_NUMROM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP ';

  Result := '';
  qryAux := fCriaQuery;

  With qryAux Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    While (Not Eof) Do
    Begin
      Result := Result + FieldByName('GER_NUMROM').AsString + ',';
      Next;
    End;

    Close;

  End;

  FreeAndNil(qryAux);
  Result := Copy(Result, 1, Length(Result)-1);

end;

function fVerificaClaFisExiste(strClaFis: String): Boolean;
  Var
    strSQL   : String;
    qryGenCfo: TUniQuery;

begin
  Try

    Result := True;

    qryGenCfo := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CFO_CODCFO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCFO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CFO_CODCFO = :CODCFO ';

    With qryGenCfo Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCFO').AsString := strClaFis;
      Open;

      If IsEmpty Then
        Result := False;

      Close;

    End;

  Finally
    FreeAndNil(qryGenCfo);
  End;

end;

{**************************************}
{* VERIFICA SE A CLASSIFICAÇAO EXISTE *}
{* POR ESTADO                         *}
{***********************************AF*}
function fVerificaClaFisExisteEst(strClaFis, strEstado: String; Var strMensagem: String): Boolean;
  Var
    strSQL   : String;
    qryGenCfo: TUniQuery;

begin
  Try

    Result := True;

    qryGenCfo := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CFO_CODCFO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCFO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CFO_CODCFO = :CODCFO ';

    With qryGenCfo Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCFO').AsString := strClaFis;
      Open;

      If IsEmpty Then
      Begin
        Result := False;
        strMensagem := 'Cfop ' + strClaFis + ' não encontrado!';
      End
      Else
      Begin

        If strEstado = fCadEmp('ESTADO') Then
          strMensagem := 'dentro do estado'
        Else
          strMensagem := 'fora do estado';

      End;

      Close;

    End;

  Finally
    FreeAndNil(qryGenCfo);
  End;

end;

function fClaFisPermiteGarantia(const strClaFis: String): Boolean;
Var
  strCFTGAR: String;
begin
  Result := True;

  If (Pos(strClaFis, VS_strClaVen) > 0) Then
    Exit;

  If (Pos(strClaFis, CLAFIS_ENTFUT_VEN) > 0) Then
    Exit;

  If (RightStr(strClaFis, 3) = fCfgSis('CLACIF', varString)) Then
    Exit;

  strCFTGAR := fTransform(fCfgSis('CFTGAR', varString),4);

  If Pos(strClaFis, strCFTGAR) > 0 Then
    Exit;

  Result := False;
end;

{*******************************************}
{* RETORNA O TEMPO DE GARANTIA DO PRODUTO  *}
{****************************************RL*}
function fRetTempoGarantia(strCodIte, strClaFis: String): Integer;
Begin
  Result := 0;

  If (fEmptyStr(strCodIte)) Then
    Exit;

  If (Not fCfgSis('GARANT', varBoolean)) Then
    Exit;

  If (Not fClaFisPermiteGarantia(strClaFis)) Then
    Exit;

  Result := fCampoTabela('ITE_TMPGAR', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
End;

{*******************************************}
{* RETORNA O PREÇO DA ÚLTIMA VENDA         *}
{****************************************RL*}
function fRetPreUve(strCodEmp, strCodIte: String): Double;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_PREUVE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := 0;

    If (Not IsEmpty) And (Not FieldByName('ITE_PREUVE').IsNull) Then
      Result := FieldByName('ITE_PREUVE').AsFloat;

    Close;
  End;

  FreeAndNil(qryTmp);

End;

function fRetPreCus(strCodEmp, strCodIte: String): Double;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_PRECUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := 0;

    If (Not IsEmpty) And (Not FieldByName('ITE_PRECUS').IsNull) Then
      Result := FieldByName('ITE_PRECUS').AsFloat;

    Close;
  End;

  FreeAndNil(qryTmp);

End;

Procedure pMontaSQLNota(Var strSql: String; strDtaIni, strDtaFin: String; const blnParaRetornoDeConsignacao : boolean = False);
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  "MOVGER" AS TABELA, ';
  strSQL := strSQL + '  GER_NUMDOC, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  GER_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_ESPDOC, ';
  strSQL := strSQL + '  GER_TOTPRO, ';
  strSQL := strSQL + '  GER_VLRCON, ';
  strSQL := strSQL + '  GER_TOTICM, ';
  strSQL := strSQL + '  GER_TOTIPI, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  GER_ORIDOC, ';
  strSQL := strSQL + '  MOVGER.AUTOINCREM, ';
  strSQL := strSQL + '  AUX_CODFAZ AS GER_CODFAZ, ';
  strSQL := strSQL + '  IFNULL(GER_CODREP, "   ") AS GER_CODREP, ';
  strSQL := strSQL + '  GER_CGCCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + '  INNER JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT  JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '  LEFT  JOIN CADFAZ ON FAZ_CODCLI = GER_CODCLI AND FAZ_CODFAZ = AUX_CODFAZ ';
  strSQL := strSQL + 'WHERE ';

  if blnParaRetornoDeConsignacao then
    strSQL := strSQL + '  (LOCATE(GER_CLAFIS, (SELECT TRIM(SIS_VALCFG) FROM CFGSIS WHERE SIS_CODEMP = GER_CODEMP AND SIS_CODCFG = "CFG_ENVCON")) > 0) AND '
  Else
  Begin
    strSQL := strSQL + '  (GER_ESPDOC = "NF" OR GER_ESPDOC = "EL" OR GER_ESPDOC = "IF") AND ';
    strSQL := strSQL + '  (NOT LOCATE(GER_CLAFIS, (SELECT TRIM(SIS_VALCFG) FROM CFGSIS WHERE SIS_CODEMP = GER_CODEMP AND SIS_CODCFG = "CFG_ENVCON")) > 0) AND ';
  End;

  strSQL := strSQL + '  GER_TIP_FC = "C"  AND ';
  strSQL := strSQL + '  LEFT(GER_CLAFIS, 1) >= 5 AND ';    
  strSQL := strSQL + '  GER_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  strSQL := strSQL + '  GER_DTAENT BETWEEN ' + strDtaIni + ' AND ' + strDtaFin + '  ';

  strSQL := strSQL + 'UNION ALL ' + AnsiReplaceStr(
                                    AnsiReplaceStr(
                                    AnsiReplaceStr(strSQL,'MOVGER', 'NOTGER'),
                                                          'AUXMOV', 'AUXNOT'),
                                                          'IFNULL(GER_CODREP, "   ")', 'NULL');

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  GER_NUMDOC  ';
End;

Function fMemoToStr(strMemo: String): String;
Var
  stlInf: TStringList;
  intInd: Integer;
Begin
  Result := '';
  stlInf := TStringList.Create;
  stlInf.Text := strMemo;
  For intInd := 0 to stlInf.Count -1 Do
    Result := Result + Trim(stlInf[intInd]) + ' ';
  Result := Trim(Result);
  FreeAndNil(stlInf);
End;

{**************************************}
{* CHAMA UM OUTRO EXECUTÁVEL EM UM    *}
{* PROCESSO SEPARADO                  *}
{***********************************AF*}
function fCriarProcesso(strArquivo: string; blnTrava: Boolean; TipoChamado: TTipoChamadaProcesso = tcpMaximizado): boolean;
begin
  Result := fCriarProcessoSimples(strArquivo, blnTrava, TipoChamado);
end;

function fVerificaClaFisForFil(strCodFor: String): Boolean;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  EMP_CLATE1, ');
  qryAux.SQL.Add('  EMP_CLATE2, ');
  qryAux.SQL.Add('  EMP_CLATE3, ');
  qryAux.SQL.Add('  EMP_CLTEV1, ');
  qryAux.SQL.Add('  EMP_CLTEV2, ');
  qryAux.SQL.Add('  EMP_CLTEV3, ');

  qryAux.SQL.Add('  (SELECT CON_TIPOPE FROM CONEMP ');
  qryAux.SQL.Add('   WHERE CON_EMPORI = EMP_CODEMP AND CON_EMPDES = :EMPORI) AS TIPOPE ');

  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADEMP ');
  qryAux.SQL.Add('WHERE ');
  If fCfgSis('CLETTR', varString) = '1' Then
    qryAux.SQL.Add('  EMP_FORFIL = :CODFOR ')
  Else
    qryAux.SQL.Add('  EMP_CODEMP = :EMPORI ');
  If fCfgSis('CLETTR', varString) = '1' Then
    qryAux.ParamByName('CODFOR').AsString := strCodFor;
  qryAux.ParamByName('EMPORI').AsString := VS_strCodEmp;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
    Result := True
  Else
  Begin

    If qryAux.FieldByName('TIPOPE').AsString = '1' Then
    Begin
      Result := (Not fEmptyStr(qryAux.FieldByName('EMP_CLTEV1').AsString)) And
                (Not fEmptyStr(qryAux.FieldByName('EMP_CLTEV2').AsString)) And
                (Not fEmptyStr(qryAux.FieldByName('EMP_CLTEV3').AsString));
    End
    Else
    Begin
      Result := (Not fEmptyStr(qryAux.FieldByName('EMP_CLATE1').AsString)) And
                (Not fEmptyStr(qryAux.FieldByName('EMP_CLATE2').AsString)) And
                (Not fEmptyStr(qryAux.FieldByName('EMP_CLATE3').AsString));
    End;
  End;
  qryAux.Close;
  FreeAndNil(qryAux);

  If (Not Result) Then
    fMensagem('ATENÇÃO!', 'É necessário configurar as classificações para transferência de estoque no cadastro de empresas!', ['&Ok']);

end;

{********************************************}
{* RETORNA A ÚLTIMA PARCELA DE UMA DUPLICATA*}
{***13/05/2008****************************MV*}
function fRetornaUltimaParcela(strNumDup, strEspDoc: String): String;
  Var
    qryAux: TUniQuery;
    strPrefix: String;
    strTabela: String;
begin
  strTabela := 'CADREC ';
  strPrefix := 'CTR_';

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                                   ');
  qryAux.SQL.Add('  MAX(' + strPrefix + 'PARCEL) AS PARCEL ');
  qryAux.SQL.Add('FROM                                     ');
  qryAux.SQL.Add('  ' + strTabela + '                      ');
  qryAux.SQL.Add('WHERE                                    ');
  qryAux.SQL.Add('  ' + strPrefix + 'NUMDUP = :NUMDUP AND  ');
  qryAux.SQL.Add('  ' + strPrefix + 'ESPDOC = :ESPDOC AND  ');
  qryAux.SQL.Add('  ' + strPrefix + 'CODEMP = :CODEMP      ');

  qryAux.ParamByName('NUMDUP').AsString := strNumDup;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  Result := qryAux.FieldByName('PARCEL').AsString;

  qryAux.Close;
  FreeAndNil(qryAux);
end;

{*****************************************}
{* ESSA BAGAÇA VAI RETORNA A POSICAO     *}
{* RECNO DO OPERDOR NO CADASTRO ORDENADO *}
{* POR CODIGO                            *}
{**************************************AF*}
function fRetPosCadOpe(strCodOpe: String): String;
  Var
    qryGen: TUniQuery;
Begin

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT       ');
    SQL.Add('  OPE_CODOPE ');
    SQL.Add('FROM         ');
    SQL.Add('  CADOPE     ');
    SQL.Add('ORDER BY     ');
    SQL.Add('  OPE_CODOPE ');
    Open;

    While Not Eof Do
    Begin

      If FieldByName('OPE_CODOPE').AsString = strCodOpe Then
      Begin
        Result := fStrZero(RecNo,3);
        Break;
      End;

      Next;
    End;

    Close;
  End;

  FreeAndNil(qryGen);

End;

{*****************************************}
{* RETORNA CODOPE PELO RECNO             *}
{**************************************AF*}
function fRetCadOpePos(strRecNo: String): String;
  Var
    qryGen: TUniQuery;
Begin

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT       ');
    SQL.Add('  OPE_CODOPE ');
    SQL.Add('FROM         ');
    SQL.Add('  CADOPE     ');
    SQL.Add('ORDER BY     ');
    SQL.Add('  OPE_CODOPE ');
    Open;

    RecNo := StrToIntDef(strRecNo,0);
    Result := FieldByName('OPE_CODOPE').AsString;

    Close;
  End;

  FreeAndNil(qryGen);

End;

Function fCriptografaOperador(strCodOpe, strSenLib: String): String;
  Var
    intFat,
    intOpe: int64;
    intInd: Integer;
    intSom: Integer;
Begin
  intFat := StrToInt64Def(RightStr(LeftStr(strSenLib,5),3),0);
  intOpe := StrToInt64Def(fRetPosCadOpe(strCodOpe),0);
  Result := IntToStr(intFat*IntOpe);

  (**************************************************)
  (* ACRESCENTA DIGITO VERIFICADOR                  *)
  (***********************************************LA*)
  intSom := 0;
  For intInd := 1 to Length(Result) Do
    inc(intSom,StrToIntDef(Result[intInd],0));

  intSom := intSom mod 11;

  Result := Result + LeftStr(IntToStr(intSom),1);

End;

Function fDescriptografaOperador(strSenLib: String): String;
  Var
    intFat,
    intSen,
    intOpe: int64;
    chrDig: Char;
    intSom,
    intInd: Integer;
Begin
  intOpe := 0;
  intFat := StrToInt64Def(RightStr(LeftStr(strSenLib,5),3),1);

  If intFat = 0 then
  Begin
    Result := '';
    Exit;
  end;  

  delete(strSenLib,1,7);

  chrDig := strSenLib[Length(strSenLib)];

  delete(strSenLib,Length(strSenLib),1);

  intSom := 0;
  For intInd := 1 to Length(strSenLib) Do
    inc(intSom,StrToIntDef(strSenLib[intInd],0));

  intSom := intSom mod 11;

  If LeftStr(IntToStr(intSom),1) <> chrDig Then
  Begin
    Result := '';
    Exit;
  End;

  intSen := StrToInt64Def(strSenLib,0);

  If intFat <> 0 Then
    intOpe := intSen div intFat;

  Result := fRetCadOpePos(IntToStr(intOpe));
End;

function fRetVendedor2PedOrc(Const strSeqGer: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT FDO_CODVE2 FROM FATDOR WHERE FDO_SEQGER = :SEQGER LIMIT 1');
  qryAux.ParamByName('SEQGER').AsString := strSeqGer;
  qryAux.Open;
  Result := qryAux.FieldByName('FDO_CODVE2').AsString;
  qryAux.Close;

  FreeAndNil(qryAux);

end;

function fRetVendedor2MovDet(Const strSeqGer, strEspDoc: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT DET_CODVE2 FROM MOVDET WHERE DET_SEQGER = :SEQGER LIMIT 1');
  qryAux.ParamByName('SEQGER').AsString := strSeqGer;
  qryAux.Open;
  Result := qryAux.FieldByName('DET_CODVE2').AsString;
  qryAux.Close;

  FreeAndNil(qryAux);

end;

function fRetValorCampo(Const strSeqGer, strTabela, strAbrTbl, strCampo_: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT ' + strCampo_ + ' FROM ' + strTabela + ' WHERE ' + strAbrTbl + '_SEQGER = :SEQGER LIMIT 1');
  qryAux.ParamByName('SEQGER').AsString := strSeqGer;
  qryAux.Open;
  Result := qryAux.FieldByName(strCampo_).AsString;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

(**********************************************************************)
(* SETA UMA VARIAVEL NO BANCO DE DADOS COM O PROXIMO AUTOINCREMENTO   *)
(* DA TABELA PASSADA COMO PARAMETRO                                   *)
(*******************************************************************LA*)
Function fSetaVarAutoinc(strNomTab: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try

    qryGen := fCriaQuery;

    Try

      With qryGen, Sql Do
      Begin
        Close;
        Clear;
        Add('SET @INC' + strNomTab + '=(SELECT IFNULL(CAST( LEFT(MAX(AUTOINCREM),17) AS UNSIGNED),0) AS AUTO FROM ' + strNomTab + ')');
        ExecSQL;
        Close;

        Result := TRUE;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
				pMensagensErro(E.Message,'[fSetaVarAutoinc]');
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

{****************************************}
{* REALIZA O BACKUP DO BANCO DE DADOS   *}
{*************************************LU*}
procedure pGeraBackup;
Var
  strHost   : String;
  strBanc   : String;
  strUsua   : String;
  strSenh   : String;
  txtText   : TextFile;
  strArqBat : String;
  strArqBac : String;
  strComand : String;
  strWinRar : String;
  strExtArq : String;
Begin

  If fMensagem('AVISO', 'Confirma geração do Backup?', ['&Sim', '&Não']) = 1 Then
  Begin
    {************************************************************}
    {* VERIFICA SE O PATH PARA GERAR O ARQUIVO ESTÁ CONFIGURADO *}
    {*********************************************************LU*}
    If fEmptyStr(fCfgSis('PATBAC')) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Path para geração do arquivo deve ser configurado!', ['&Ok']);
      exit;
    End;

    Try
      Try
        strArqBat := 'BACKUP.BAT';
        strArqBac := '\BACKUP_' + FormatDateTime('yyyymmdd',VS_Date) + FormatDateTime('hhnnss', fTime());

        strHost := frmModulo.GetCurrentConnection.Server;
        strBanc := frmModulo.GetCurrentConnection.Database;
        strUsua := frmModulo.GetCurrentConnection.Username;
        strSenh := frmModulo.GetCurrentConnection.Password;

        {***********************}
        {* CRIA O ARQUIVO .BAT *}
        {********************LU*}
        AssignFile(txtText, fCfgSis('PATBAC') + '\' +  strArqBat);
        Rewrite(txtText);

        strComand := 'mysqldump -u' + strUsua +
                     ' -p' + strSenh +
                     ' -h' + strHost +
                     ' ' + strBanc +
                     ' > ' + fCfgSis('PATBAC') +
                     strArqBac + '.SQL';

        Writeln(txtText,strComand);
        Writeln(txtText,'Pause');

      Finally
        Flush(txtText);
        CloseFile(txtText);
      End;

      If FileExists(fCfgSis('PATBAC') + '\' + strArqBat) Then
      Begin
        {**************************}
        {* EXECUTA O ARQUIVO .BAT *}
        {***********************LU*}
        fCriarProcesso(fCfgSis('PATBAC') + '\' + strArqBat, True);
        strExtArq := '.SQL';
        {************************}
        {* APAGA O ARQUIVO .BAT *}
        {*********************LU*}
        DeleteFile(fCfgSis('PATBAC') + '\' + strArqBat);

        {**********************************************}
        {* VERIFICA SE ESTÁ CONFIGURADO O COMPACTADOR *}
        {*******************************************LU*}
        If Not fEmptyStr(fCfgSis('PATWRA')) Then
        Begin
          strWinRAR := '';
          strWinRAR := fCfgSis('PATWRA');
          strWinRAR := strWinRAR + ' a -afZip -m5 -ep ' + fCfgSis('PATBAC') + '\' + strArqBac + '.ZIP ';
          strWinRAR := strWinRAR + fCfgSis('PATBAC') + '\' + strArqBac +'.SQL ';

          WinExec(PAnsiChar(AnsiString(strWinRAR)),SW_SHOWNORMAL);

          {****************************************************}
          {* QD FINALIZA A COMPACTAÇÃO, EXCLUI O ARQUIVO .SQL *}
          {*************************************************LU*}
          While FileExists(fCfgSis('PATBAC') + '\' + strArqBac + strExtArq) Do
          Begin
            DeleteFile(fCfgSis('PATBAC') + '\' + strArqBac + strExtArq);
          End;

          strExtArq := '.ZIP';
        End;

        fMensagem('ATENÇÃO!', 'Backup realizado com sucesso!' + #13#10 + fCfgSis('PATBAC') + strArqBac + strExtArq, ['&Ok']);

      End;

    Except
      On E : Exception Do
        pMensagensErro(E.Message, 'Erro na realização do Backup');
    End;

  End;

End;

Function fGetFornecedorFilial(strCodEmp: String): String;
  Var
    strSQL: String;
    qryGenEmp: TUniQuery;
begin
  Result := '';
  
  Try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_FORFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('EMP_FORFIL').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;

function fStringRepetida(Const strString: String): Boolean;
  Var
    intContador: Integer;
    strPrimeiro: String;
begin

  Result := True;
  If Length(strString) <= 0 THen
    Exit;

  strPrimeiro := strString[1];
  For intContador := 2 To Length(strString) Do
  Begin
    If strString[intContador] <> strPrimeiro Then
    Begin
      Result := False;
      Break;
    End;
  End;

end;

procedure pResetaImpressora(Const strNomImp: String);
  Var
    DocInfo: TDocInfo1;
    PrinterHandler: NativeUInt;
    escritos: Cardinal;
    strTexto: AnsiString;
begin
  OpenPrinter(PChar(strNomImp), PrinterHandler, Nil);
  with DocInfo do
  begin
    pDatatype := 'RAW';
    pDocName := PChar('Impressão de Faturamento');
    pOutputFile := nil;
  end;
  StartDocPrinter(PrinterHandler, 1, @DocInfo);
  StartPagePrinter(PrinterHandler);
  strTexto := AnsiString(#27 + '@');
  WritePrinter(PrinterHandler, PAnsiChar(strTexto), 2, escritos);

  ClosePrinter(PrinterHandler);
end;


Function fGetProxNumSelEntradaMerc: Integer;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Text := 'SELECT IFNULL(MAX(IF(ENT_NUMSEL=:MAXINT,0,ENT_NUMSEL)),0) FROM TMP_ENTMER';
    ParamByName('MAXINT').AsInteger := MaxInt;
    Open;
    Result := Succ(Fields[0].AsInteger);
    Close;
  End;

  FreeAndNil(qryGen);
End;

{*****************************************}
{* VERIFICA SE UMA SENTENÇA SQL JÁ TEM A *}
{* CLÁUSULA 'WHERE'                      *}
{**************************************MV*}
function fTemWhere(Const strSQL: String): Boolean;
begin
  Result := Pos('where', AnsiLowerCase(strSQL)) > 0;
end;

procedure pAtualizaPriComCliente(strCodCli: String; dtaDataCom: TDateTime = 0;
  dtaDataDoc: TDateTime = 0);
  Const
    ARR_FILTRO_MES: Array[0..4] Of Integer = (00, 01, 03, 06, 12);
  Var
    strSQL: String;
    qryGenCli,
    qryMovGer: TUniQuery;
    dtaPriCom: TDateTime;
    dtaPriComCli: TDateTime;
    dtaFimPeriodo: TDateTime;
    intIndex: Integer;
    blnEncontrou: Boolean;

    function fSQLWhere(dtaDataIni: TDateTime; dtaDataFin: TDateTime): String;
    begin
      Result := '';
      Result := Result + 'WHERE    ';
      Result := Result + '  GER_DTAENT BETWEEN ' + fCurrentDate(dtaDataIni);
      Result := Result + '                 AND ' + fCurrentDate(dtaDataFin) + ' AND ';
      Result := Result + '  LOCATE(GER_CLAFIS, :CLAFIS) > 0 AND ';
      Result := Result + '  LEFT(GER_CLAFIS, 1) >= 5 AND ';
      Result := Result + '  GER_CODCLI = :CODCLI ';
    end;

    function fSQLMovGer(dtaDataIni: TDateTime; dtaDataFin: TDateTime) : String;
    begin
      Result := '';
      Result := Result + 'SELECT ';
      Result := Result + '  GER_DTAENT ';
      Result := Result + 'FROM ';
      Result := Result + '  MOVGER ';
      Result := Result + fSQLWhere(dtaDataIni, dtaDataFin);
      Result := Result + 'ORDER BY GER_DTAENT, GER_HORENT ';
      Result := Result + 'LIMIT 1 ';
    end;

    function fEncontrouPrimeiraCompraCliente(strCodCli: String; dtaDataIni: TDateTime; dtaDataFin: TDateTime): Boolean;
    begin
      qryMovGer.Close;
      qryMovGer.SQL.Clear;
      qryMovGer.SQL.Add(fSQLMovGer(dtaDataIni, dtaDataFin));
      qryMovGer.ParamByName('CLAFIS').AsString := VS_strClaVen;
      qryMovGer.ParamByName('CODCLI').AsString := strCodCli;

      qryMovGer.Open;

      Result := (Not qryMovGer.IsEmpty) And (Not qryMovGer.FieldByName('GER_DTAENT').IsNull);
    end;
begin
  dtaPriCom := 0;
  dtaPriComCli := fCampoTabela('CLI_PRICOM', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
  qryMovGer := fCriaQuery;
  Try
    If (dtaDataCom = 0) And (dtaPriComCli = dtaDataDoc) Then
    Begin
      For intIndex := Low(ARR_FILTRO_MES) To High(ARR_FILTRO_MES) Do
      Begin
        dtaFimPeriodo := IncMonth(dtaDataDoc, ARR_FILTRO_MES[intIndex]);
        blnEncontrou := fEncontrouPrimeiraCompraCliente(strCodCli, dtaDataDoc, IIF(dtaFimPeriodo <= VS_DATE, dtaFimPeriodo, VS_DATE));
        If blnEncontrou Or (dtaFimPeriodo > VS_DATE) Then
          Break;

        If intIndex = High(ARR_FILTRO_MES) Then
          blnEncontrou := fEncontrouPrimeiraCompraCliente(strCodCli, dtaDataDoc, VS_Date);
      End;

      If blnEncontrou Then
        dtaPriCom := qryMovGer.FieldByName('GER_DTAENT').AsDateTime;

      qryMovGer.Close;
    End
    Else
    Begin
      If (dtaPriComCli > 0) Then
        Exit;
    End;
  Finally
    FreeAndNil(qryMovGer);
  End;

  qryGenCli := fCriaQuery;
  Try
    {**********************************}
    {* ATUALIZA O CADASTRO DO CLIENTE *}
    {**********************************}
    strSQL := '';
    strSQL := strSQL + 'UPDATE                    ';
    strSQL := strSQL + '  CADCLI                  ';
    strSQL := strSQL + 'SET                       ';
    If (dtaDataCom = 0) And (dtaPriCom = 0) Then
      strSQL := strSQL + '  CLI_PRICOM = NULL     '
    Else
      strSQL := strSQL + '  CLI_PRICOM = :PRICOM  ';
    strSQL := strSQL + 'WHERE CLI_CODCLI = :CODCLI';
    If Not (dtaDataCom = 0) Then
      strSQL := strSQL + '  AND CLI_PRICOM IS NULL  ';

    qryGenCli.Close;
    qryGenCli.SQL.Clear;
    qryGenCli.SQL.Add(strSQL);
    qryGenCli.ParamByName('CODCLI').AsString := strCodCli;
    If Not ((dtaDataCom = 0) And (dtaPriCom = 0)) Then
      qryGenCli.ParamByName('PRICOM').AsDateTime := IIF(dtaDataCom = 0, dtaPriCom, dtaDataCom);
    qryGenCli.ExecSQL;
    qryGenCli.Close;
  Finally
    FreeAndNil(qryGenCli);
  End;
end;

procedure pAtualizaUltComCliente(strCodCli: String);
  Const
    ARR_FILTRO_MES: Array[0..4] Of Integer = (00, 01, 03, 06, 12);
  Var
    intIndex: Integer;
    dtaDataIni: TDateTime;
begin
  For intIndex := Low(ARR_FILTRO_MES) To High(ARR_FILTRO_MES) Do
  Begin
    dtaDataIni := IncMonth(VS_Date, - ARR_FILTRO_MES[intIndex]);
    // Verifica a ultima compra no dia, no mes, no trimestre, no semestre, no ano
    If fAtualizaUltComCliente(strCodCli, dtaDataIni) Then
      Break;

    // Caso nao encontrou a ultima compra dentro do ano, busca em toda a movimentaco do cliente
    If intIndex = High(ARR_FILTRO_MES) Then
      fAtualizaUltComCliente(strCodCli, 0);
  End;
end;

function fAtualizaUltComCliente(strCodCli: String; dtaDataIni: TDateTime): Boolean;
  Var
    strSQL,
    strNumDoc : String;

    qryGenCli,
    qryMovGer: TUniQuery;

    fltValor: Double;

    dtaDataDoc : TDateTime;

    function fSQLMaiorCompra(strCampo, strValor: String): String;
    begin
      Result := strCampo + ' = ' + 'IF(:VRUCOM > CLI_VRMCOM OR CLI_VRMCOM IS NULL, ' +
                strValor + ', ' + strCampo + ') ';
    end;

    function fSQLWhere: String;
    Begin
      Result := '';
      Result := Result + 'WHERE    ';
      Result := Result + '  LOCATE(GER_CLAFIS, :CLAFIS) > 0 AND ';
      Result := Result + '  LEFT(GER_CLAFIS, 1) >= 5 AND ';
      Result := Result + '  GER_CODCLI = :CODCLI ';

      If dtaDataIni > 0 Then
        Result := Result + '  AND GER_DTAENT >= ' + fCurrentDate(dtaDataIni) + ' ';
    End;

    function fSQLUnion : String;
      Var
        strSQLU : String;
    Begin
      strSQLU := strSQLU + 'SELECT ';
      strSQLU := strSQLU + '  CONCAT(GER_NUMDOC,"-",GER_ESPDOC) AS GER_NUMDOC, ';
      strSQLU := strSQLU + '  GER_DTAENT, ';
      strSQLU := strSQLU + '  GER_VLRCON, ';
      strSQLU := strSQLU + '  GER_HORENT  ';
      strSQLU := strSQLU + 'FROM ';
      strSQLU := strSQLU + '  MOVGER ';
      strSQLU := strSQLU +  fSQLWhere;
      Result := strSQLU;
    End;
begin
  Try
    {*************************************************}
    {* SELECIONA OS DADOS DA ÚLTIMA COMPRA DO CLIENTE*}
    {*************************************************}
    fltValor   := 0.0;
    dtaDataDoc := 0;

    qryMovGer := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_NUMDOC, ';
    strSQL := strSQL + '  GER_DTAENT, ';
    strSQL := strSQL + '  GER_VLRCON  ';
    strSQL := strSQL + 'FROM ( ' + fSQLUnion + ' ) AS GER ';
    strSQL := strSQL + 'ORDER BY GER_DTAENT DESC, GER_HORENT DESC ';
    strSQL := strSQL + 'LIMIT 1 ';

    With qryMovGer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      Result := (Not IsEmpty) And (Not FieldByName('GER_DTAENT').IsNull);

      If Result Then
      Begin
        strNumDoc := FieldByName('GER_NUMDOC').AsString;
        dtaDataDoc:= FieldByName('GER_DTAENT').AsDateTime;
        fltValor  := FieldByName('GER_VLRCON').AsFloat;
      End;

      Close;
    End;

    {**********************************}
    {* ATUALIZA O CADASTRO DO CLIENTE *}
    {**********************************}
    qryGenCli := fCriaQuery;

    If Result Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + 'SET ';

      {*****************************************}
      {* MAIOR COMPRA.                         *}
      {**************************************MV*}
      strSQL := strSQL + fSQLMaiorCompra('CLI_DTMCOM', ':ULTCOM')    + ', ';
      strSQL := strSQL + fSQLMaiorCompra('CLI_DOMCOM', ':NUMDOC')    + ', ';
      strSQL := strSQL + fSQLMaiorCompra('CLI_VRMCOM', ':VRUCOM')    + ', ';

      {*****************************************}
      {* ÚLTIMA COMPRA.                        *}
      {**************************************MV*}
      strSQL := strSQL + '  CLI_ULTCOM = :ULTCOM, ';
      strSQL := strSQL + '  CLI_DOUCOM = :NUMDOC, ';
      strSQL := strSQL + '  CLI_VRUCOM = :VRUCOM  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('VRUCOM').AsFloat    := fltValor;
        ParamByName('CODCLI').AsString   := strCodCli;
        ParamByName('NUMDOC').AsString   := strNumDoc;
        ParamByName('ULTCOM').AsDateTime := dtaDataDoc;
        ExecSQL;
        Close;
      End;
    End;
  Finally
    FreeAndNil(qryGenCli);
    FreeAndNil(qryMovGer);
  End;

end;

function fBuscaUltimaCompraItem(strCodCli, strCodIte: String) : String;
var
  strUltCompra: String;

  function fUltimaCompraItems(strCodCli, strCodIte: String; dtaDtaIni: TDateTime): Boolean;
    var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery;

    Try
      With qryGen Do
      Begin
        SQL.Add(' SELECT SQL_NO_CACHE CONCAT(DATE_FORMAT(DET_DTAENT, "%d/%m/%Y"), " ", ');
        SQL.Add('   LPAD(FORMAT(DET_UNITAR - (DET_DESESP / DET_QTDITE), 4),10," ")) AS ULTCPA ');
        SQL.Add(' FROM MOVDET ');
        SQL.Add(' WHERE DET_CODCLI = :CODCLI ');
        SQL.Add('   AND DET_CODITE = :CODITE ');
        SQL.Add('   AND DET_TIP_FC = "C" ');
        SQL.Add('   AND LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaVen) + ') > 0 ');
        SQL.Add(' AND DET_DTAENT >= ' + fCurrentDate(dtaDtaIni));
        SQL.Add(' ORDER BY DET_DTAENT DESC, DET_HORENT DESC LIMIT 1 ');
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        Result := Not isEmpty;
        If Result Then
          strUltCompra := FieldByName('ULTCPA').AsString;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  end;

  Const
    cnsArrMes: Array[0..4] Of Integer = (00, 01, 03, 06, 12);
  Var
    intIdx: Integer;
    dtaDtaIni: TDateTime;
begin
  strUltCompra := '';

  For intIdx := Low(cnsArrMes) To High(cnsArrMes) Do
  Begin
    dtaDtaIni := IncMonth(VS_Date, -cnsArrMes[intIdx]);

    //Tenta atualizar verificando ultima venda no dia, no mes, no trimestre, no semestre, no ano
    If fUltimaCompraItems(strCodCli, strCodIte, dtaDtaIni) Then
      Break;

    //Caso não encontrou a ultima venda dentro do ano, busca em toda a movimentaco do cliente
    If intIdx = High(cnsArrMes) Then
      fUltimaCompraItems(strCodCli, strCodIte, 0);
  End;

  Result := strUltCompra;
end;

procedure pAtualizaUltVenItem(strCodIte: String);

  function fAtualizaUltVenItem(strCodIte: String; dtaDtaIni: TDateTime): Boolean;
    var
      strSQL: string;
      qryGen: TUniQuery;
      dtaDtaEnt: TDateTime;
      fltQtdIte,
      fltUnitar: Double;
  begin
    Result := False;
  
    strSQL :=  '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   DET_DTAENT, ';
    strSQL := strSQL + '   DET_UNITAR, ';
    strSQL := strSQL + '   DET_QTDITE  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVDET ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DET_CODITE = ' + QuotedStr(strCodIte) + ' AND ';
    strSQL := strSQL + '   DET_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
    strSQL := strSQL + '   DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '   DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '   IFNULL(DET_PROEMB, "N") <> "S" AND ';
    strSQL := strSQL + '   ((LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaVen) + ') > 0) OR ';
    strSQL := strSQL + '    (LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') > 0)    ';

    If (fCfgSis('ENTBRF', varBoolean)) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ' ) ';

    If dtaDtaIni > 0 Then
      strSQL := strSQL + ' AND DET_DTAENT >= ' + fCurrentDate(dtaDtaIni);

    strSQL := strSQL + ' ORDER BY DET_DTAENT DESC, DET_HORENT DESC ';
    strSQL := strSQL + ' LIMIT 1 ';

    qryGen := fCriaQuery(Nil);
    Try
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        strSQL := '';
        strSQL := strSQL + ' UPDATE ';
        strSQL := strSQL + '   ITEGER ';
        strSQL := strSQL + ' SET ITE_DTAUVE = :DTAUVE ';
        strSQL := strSQL + '    ,ITE_PREUVE = :PREUVE ';
        strSQL := strSQL + '    ,ITE_QTDUVE = :QTDITE ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
        strSQL := strSQL + '   ITE_CODEMP = :CODEMP ';

        If (Not IsEmpty) Then
        Begin
          dtaDtaEnt := FieldByName('DET_DTAENT').AsDateTime;
          fltUnitar := FieldByName('DET_UNITAR').AsFloat;
          fltQtdIte := FieldByName('DET_QTDITE').AsFloat;

          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('CODITE').AsString   := strCodIte;
          ParamByName('CODEMP').AsString   := VS_strCodEmp;
          ParamByName('DTAUVE').AsDateTime := dtaDtaEnt; 
          ParamByName('PREUVE').AsFloat    := fltUnitar; 
          ParamByName('QTDITE').AsFloat    := fltQtdIte;

          ExecSQL;

          Result := True;
        End
        Else If (dtaDtaIni = 0) Then
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('CODITE').AsString := strCodIte;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('DTAUVE').Value    := Null; 
          ParamByName('PREUVE').Value    := Null; 
          ParamByName('QTDITE').Value    := Null;

          ExecSQL;

          Result := True;
        End;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  end;
  
  Const
    cnsArrMes: Array[0..4] Of Integer = (00, 01, 03, 06, 12);
  Var
    intIdx: Integer;
    dtaDtaIni: TDateTime;
begin
  For intIdx := Low(cnsArrMes) To High(cnsArrMes) Do
  Begin
    dtaDtaIni := IncMonth(VS_Date, -cnsArrMes[intIdx]);

    //Tenta atualizar verificando ultima venda no dia, no mes, no trimestre, no semestre, no ano
    If fAtualizaUltVenItem(strCodIte, dtaDtaIni) Then
      Break;

    //Caso não encontrou a ultima venda dentro do ano, busca em toda a movimentaco do cliente
    If intIdx = High(cnsArrMes) Then
      fAtualizaUltVenItem(strCodIte, 0);
  End;
end;

procedure pAtualizaMaiComCliente(strCodCli: String;
  fltValor: Double; strNumDoc, strEspDoc: String);
  Var
    strSQL   : String;
    qryGenCli: TUniQuery;

begin
  Try

    qryGenCli := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CLI_VRMCOM = :VRMCOM, ';
    strSQL := strSQL + '  CLI_DTMCOM = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  CLI_DOMCOM = CONCAT(:NUMDOC, "-", :ESPDOC) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  ( :VRMCOM > CLI_VRMCOM OR CLI_VRMCOM IS NULL )';

    With qryGenCli Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VRMCOM').AsFloat  := fltValor;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ExecSQL;
      Close;

    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

end;

{*******************************************}
{* GERA HTML DA CONTA CORRENTE DO CLIENTE, *}
{* DE ACORDO COM O TIPO DE FILTO (ABERTO,  *}
{* BAIXADO OU TODOS)                       *}
{****************************************MV*}
function fGeraHtmlContaCorrente(strCodCli, strTipFil: String;
  fltTotVencido, fltTotDupRec, fltTotJur, fltTotCorDif, fltDupAve: Double;
  strMensagem: String; qryDados: TUniQuery): String;
  Var
    strSQL: String;
    strHtmlCabecalhoCadRec: String;
    strHtmlTmp: String;
    strHtmlDuplicatas: String;
    intContador: Integer;

    strHtmlCabAgrup: String;
    strHtmlAgrupamentos: String;

    qryCadRec: TUniQuery;
    qryCadEmp: TUniQuery;
    qryCadAgr: TUniQuery;

    qryTblCadCli: TUniQuery;

    arqHtmlModelo: TextFile;
    arqHtmlSaida: TextFile;
    strLinha: String;


begin

  strHtmlDuplicatas := '';
  qryCadRec    := qryDados;

  qryTblCadCli := fCriaQuery;
  qryCadEmp    := fCriaQuery;
  qryCadAgr    := fCriaQuery;

  With qryTblCadCli Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADEMP.*, ';
  strSQL := strSQL + '  CADCID.CID_NOMCID AS EMP_NOMCID, ';
  strSQL := strSQL + '  CADCID.CID_ESTADO AS EMP_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
  strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
                 
  {*******************************************}
  {* GERA O CABEÇALHO DO CADREC              *}
  {****************************************MV*}
  strHtmlCabecalhoCadRec := '';
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <tr bgcolor='#330099'> ' + #13#10;
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '    <td width="8%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Duplicata</font></strong></font></div> ' + #13#10;
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '    </td> ' + #13#10;
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '    <td width="8%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Esp&eacute;cie</font></strong></font></div> ' + #13#10;
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '    </td> ' + #13#10;
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '    <td width="8%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Empresa</font></strong></font></div> ' + #13#10;
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '    </td> ' + #13#10;
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '    <td width="10%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vendedor</font></strong></font></div> ' + #13#10;

  If (strTipFil = 'A') Then
  Begin
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Data Cadastro</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Data Vencimento</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vlr. Original</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vlr. Duplicata</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vlr. Juros</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vlr. Corrigido</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;
  End
  Else If (strTipFil = 'B') Or (strTipFil = 'T') Then
  Begin
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Data Vencimento</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Data Recebimento</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vlr. Original</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vlr. Recebido</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;

    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  <td width="11%"><div align="center"><font color="#CCCCCC"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Diferen&ccedil;a</font></strong></font></div> ' + #13#10;
    strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;
  End;

  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '  </td> ' + #13#10;
  strHtmlCabecalhoCadRec := strHtmlCabecalhoCadRec + '</tr> ' + #13#10;

  {*******************************************}
  {* CABEÇALHO PARA AGRUPAMENTO              *}
  {****************************************MV*}
  strHtmlCabAgrup := '';
  strHtmlCabAgrup := strHtmlCabAgrup + '<tr bgcolor="black"> ' + #13#10;

  strHtmlCabAgrup := strHtmlCabAgrup + '  <td bgcolor="white" width="11%"><div align="center"><font color="white"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></strong></font></div> ' + #13#10;
  strHtmlCabAgrup := strHtmlCabAgrup + '  </td> ' + #13#10;

  strHtmlCabAgrup := strHtmlCabAgrup + '  <td width="11%"><div align="center"><font color="white"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Agrupamentos</font></strong></font></div> ' + #13#10;
  strHtmlCabAgrup := strHtmlCabAgrup + '  </td> ' + #13#10;

  strHtmlCabAgrup := strHtmlCabAgrup + '  <td width="11%"><div align="center"><font color="white"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Duplicata</font></strong></font></div> ' + #13#10;
  strHtmlCabAgrup := strHtmlCabAgrup + '  </td> ' + #13#10;

  strHtmlCabAgrup := strHtmlCabAgrup + '  <td width="11%"><div align="center"><font color="white"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Esp&eacute;cie</font></strong></font></div> ' + #13#10;
  strHtmlCabAgrup := strHtmlCabAgrup + '  </td> ' + #13#10;

  strHtmlCabAgrup := strHtmlCabAgrup + '  <td width="11%"><div align="center"><font color="white"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Empresa</font></strong></font></div> ' + #13#10;
  strHtmlCabAgrup := strHtmlCabAgrup + '  </td> ' + #13#10;

  strHtmlCabAgrup := strHtmlCabAgrup + '</tr> ' + #13#10;

  {*******************************************}
  {* HTML AGRUPAMENTOS                       *}
  {****************************************MV*}
  strHtmlAgrupamentos := '';
  strHtmlAgrupamentos := strHtmlAgrupamentos + '<tr bgcolor="white"> ' + #13#10;
  strHtmlAgrupamentos := strHtmlAgrupamentos + '  <td width="11%"><div align="center"><font color="black"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></strong></font></div> ' + #13#10;
  strHtmlAgrupamentos := strHtmlAgrupamentos + '  </td> ' + #13#10;

  strHtmlAgrupamentos := strHtmlAgrupamentos + '  <td width="11%"><div align="center"><font color="black"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif"></font></strong></font></div> ' + #13#10;
  strHtmlAgrupamentos := strHtmlAgrupamentos + '  </td> ' + #13#10;

  strHtmlAgrupamentos := strHtmlAgrupamentos + '  <td width="11%"><div align="center"><font color="black"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">{{DUPAGR}}</font></strong></font></div> ' + #13#10;
  strHtmlAgrupamentos := strHtmlAgrupamentos + '  </td> ' + #13#10;

  strHtmlAgrupamentos := strHtmlAgrupamentos + '  <td width="11%"><div align="center"><font color="black"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">{{ESPAGR}}</font></strong></font></div> ' + #13#10;
  strHtmlAgrupamentos := strHtmlAgrupamentos + '  </td> ' + #13#10;

  strHtmlAgrupamentos := strHtmlAgrupamentos + '  <td width="11%"><div align="center"><font color="black"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">{{EMPAGR}}</font></strong></font></div> ' + #13#10;
  strHtmlAgrupamentos := strHtmlAgrupamentos + '  </td> ' + #13#10;
  strHtmlAgrupamentos := strHtmlAgrupamentos + '</tr> ' + #13#10;
  strHtmlAgrupamentos := strHtmlAgrupamentos + '<tr></tr> ' + #13#10;

  {*******************************************}
  {* GERA O HTML DOS ITENS DO CADREC         *}
  {****************************************MV*}
  qryCadRec.First;

  While (Not qryCadRec.Eof) Do
  Begin
    strHtmlTmp := '';

    strHtmlTmp := strHtmlTmp + '  <tr> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Nº Dupl.}}</font></div></td> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Esp.}}</font></div></td> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Emp.}}</font></div></td> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Ven.}}</font></div></td> ' + #13#10;

    If (strTipFil = 'A') Then
    Begin
      strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Dt. Cad.}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Dt. Ven.}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{V. Orig.}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{V. Dupl.}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{V. Juros}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{V. Corrig.}}</font></div></td> ' + #13#10;
    End
    Else If (strTipFil = 'B') Or (strTipFil = 'T') Then
    Begin
      strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Dt. Ven}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Dt. Rec.}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{V. Orig.}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{V. Receb.}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '    <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{Diferença}}</font></div></td> ' + #13#10;
    End;

    For intContador := 0 To qryCadRec.FieldCount -1 Do
    Begin
      If (qryCadRec.Fields[intContador].DataType = ftFloat)                        And
         (Not fEmptyStr(TFloatField(qryCadRec.Fields[intContador]).DisplayFormat)) Then
      Begin
        strHtmlTmp := AnsiReplaceStr(strHtmlTmp,
                                     '{{' + qryCadRec.Fields[intContador].FieldName + '}}',
                                     FormatFloat(TFloatField(qryCadRec.Fields[intContador]).DisplayFormat, qryCadRec.Fields[intContador].AsFloat));
      End
      Else
      Begin
        strHtmlTmp := AnsiReplaceStr(strHtmlTmp,
                                     '{{' + qryCadRec.Fields[intContador].FieldName + '}}',
                                     qryCadRec.Fields[intContador].AsString);
      End;
    End;

    strHtmlDuplicatas := strHtmlDuplicatas + strHtmlTmp;

    If (qryCadRec.FieldByName('Esp.').AsString = 'AG') Then
    Begin

      strHtmlDuplicatas := strHtmlDuplicatas + strHtmlCabAgrup;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CTR_NUMDUP, ';
      strSQL := strSQL + '  CTR_ESPDOC, ';
      strSQL := strSQL + '  CTR_CODEMP ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  DUPAGR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR AND ';
      strSQL := strSQL + '  CTR_EMPAGR = :EMPAGR ';

      With qryCadAgr Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMAGR').AsString := LeftStr(qryCadRec.FieldByName('Nº Dupl.').AsString, fTamDocCadRec());
        ParamByName('EMPAGR').AsString := VS_strCodEmp;
        Open;

        While (Not Eof) Do
        Begin
          strHtmlTmp := strHtmlAgrupamentos;;
          strHtmlTmp := AnsiReplaceStr(strHtmlTmp, '{{DUPAGR}}', FieldByName('CTR_NUMDUP').AsString);
          strHtmlTmp := AnsiReplaceStr(strHtmlTmp, '{{ESPAGR}}', FieldByName('CTR_ESPDOC').AsString);
          strHtmlTmp := AnsiReplaceStr(strHtmlTmp, '{{EMPAGR}}', FieldByName('CTR_CODEMP').AsString);

          strHtmlDuplicatas := strHtmlDuplicatas + strHtmlTmp;

          Next;
        End;

        Close;

      End;

    End;

    qryCadRec.Next;
  End;

  Result := 'conta_corr_' + strCodCli + '.html';

  AssignFile(arqHtmlModelo, ExtractFilePath(Application.ExeName) + '\modelo_conta_corr.html');
  AssignFile(arqHtmlSaida, Result);

  Reset(arqHtmlModelo);
  Rewrite(arqHtmlSaida);

  While (Not Eof(arqHtmlModelo)) Do
  Begin

    ReadLn(arqHtmlModelo, strLinha);

    strLinha := AnsiReplaceStr(strLinha, '{{CONTAS_RECEBER}}', strHtmlCabecalhoCadRec + strHtmlDuplicatas);

    If (strTipFil = 'A') Then
    Begin
      strLinha := AnsiReplaceStr(strLinha, '{{DUP_VEN_REC}}', 'Total Duplicatas');
      strLinha := AnsiReplaceStr(strLinha, '{{DUP_COR_DIF}}', 'Total Corrigido');
    End
    Else If (strTipFil = 'B') Or (strTipFil = 'T') Then
    Begin
      strLinha := AnsiReplaceStr(strLinha, '{{DUP_VEN_REC}}', 'Total Recebido');
      strLinha := AnsiReplaceStr(strLinha, '{{DUP_COR_DIF}}', 'Total Diferen&ccedil;a');
    End;

    strLinha := AnsiReplaceStr(strLinha, '{{TOT_DUP_VEN}}', FloatToStrF(fltTotVencido, ffFixed, 12, 2));
    strLinha := AnsiReplaceStr(strLinha, '{{TOT_DUP_REC}}', FloatToStrF(fltTotDupRec, ffFixed, 12, 2));
    strLinha := AnsiReplaceStr(strLinha, '{{TOT_DUP_AVE}}', FloatToStrF(fltDupAve, ffFixed, 12, 2));
    strLinha := AnsiReplaceStr(strLinha, '{{TOT_VAL_JUR}}', FloatToStrF(fltTotJur, ffFixed, 12, 2));
    strLinha := AnsiReplaceStr(strLinha, '{{TOT_VAL_COR}}', FloatToStrF(fltTotCorDif, ffFixed, 12, 2));
    strLinha := AnsiReplaceStr(strLinha, '{{MENSAGEM}}', strMensagem);

    For intContador := 0 To qryCadRec.FieldCount -1 Do
    Begin
      If (qryCadRec.Fields[intContador].DataType = ftFloat)                        And
         (Not fEmptyStr(TFloatField(qryCadRec.Fields[intContador]).DisplayFormat)) Then
      Begin
        strLinha := AnsiReplaceStr(strLinha,
                                   '{{' + qryCadRec.Fields[intContador].FieldName + '}}',
                                   FormatFloat(TFloatField(qryCadRec.Fields[intContador]).DisplayFormat, qryCadRec.Fields[intContador].AsFloat));
      End
      Else
      Begin
        strLinha := AnsiReplaceStr(strLinha,
                                   '{{' + qryCadRec.Fields[intContador].FieldName + '}}',
                                   qryCadRec.Fields[intContador].AsString);
      End;
    End;

    For intContador := 0 To qryCadEmp.FieldCount -1 Do
    Begin
      strLinha := AnsiReplaceStr(strLinha,
                                 '{{' + 'CADEMP->' + qryCadEmp.Fields[intContador].FieldName + '}}',
                                 qryCadEmp.Fields[intContador].AsString);
    End;

    For intContador := 0 To qryTblCadCli.FieldCount -1 Do
    Begin
      strLinha := AnsiReplaceStr(strLinha,
                                 '{{' + 'CADCLI->' + qryTblCadCli.Fields[intContador].FieldName + '}}',
                                 qryTblCadCli.Fields[intContador].AsString);
    End;

    WriteLn(arqHtmlSaida, strLinha);

  End;

  FreeAndNil(qryTblCadCli);
  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadAgr);

  CloseFile(arqHtmlModelo);
  CloseFile(arqHtmlSaida);

end;

{****************************************}
{* VERIFICA SE ITEM PODE SER FRACIONADO *}
{*************************************AF*}
function fItemFracionado(strCodUni: String; qryGen: TUniQuery = Nil): Boolean;
Begin

  Result := False;

  If fEmptyStr(strCodUni) Then
    Exit;

  If ( qryGen = Nil ) Then
  Begin
    Result := ( fCampoTabela('UNI_ITEFRA', 'CADUNI', ['UNI_CODUNI'], [strCodUni], False) = 'S' );
  End
  Else
  Begin
    With qryGen Do
    Begin

      If (Not Active) Or
         (strCodUni <> FieldByName('UNI_CODUNI').AsString) Then
      Begin
        Close;
        SQL.Clear;

        SQL.Add('SELECT        ');
        SQL.Add('  UNI_ITEFRA, ');
        SQL.Add('  UNI_SIGUNI, '); // NAO RETIRAR POIS ESTA SENDO USADO
        SQL.Add('  UNI_CODUNI  '); // NAO RETIRAR POIS ESTA SENDO USADO
        SQL.Add('FROM         ');
        SQL.Add('  CADUNI     ');
        SQL.Add('WHERE        ');
        SQL.Add('  UNI_CODUNI = :CODUNI ');

        ParamByName('CODUNI').AsString := strCodUni;
        Open;
      End;

      Result := ( FieldByName('UNI_ITEFRA').AsString = 'S' );

    End;
  End;

End;

Function fEhConfirmacaoBaixa(strEspDoc, strNumDoc, strCodEmp: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS QTDREG FROM MOVDET ');
      SQL.Add('WHERE');
      SQL.Add('  (DET_DOCFUT IS NOT NULL) AND ');
      SQL.Add('  (DET_ESPFUT <> "EP") AND ');
      SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
      SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
      SQL.Add('  DET_CODEMP = :CODEMP     ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      Result := FieldByName('QTDREG').AsInteger > 0;

      Close;

    End;
    
  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fEhConfirmacaoBaixa]');
    End;
  End;

  FreeAndNil(qryGen);
End;

Function fTemCFOPBaixaEntregaFutura(blnDarMensagem: Boolean): Boolean;
Begin
  Result := fTemCFOPBaixaEntregaFuturaMensagem(fCfgSis('CLAEFV'), blnDarMensagem);
  if Result then
  begin
    Result := fTemCFOPBaixaEntregaFuturaMensagem(fCfgSis('CLAEFI'), blnDarMensagem);
  end;
End;

function fTemCFOPBaixaEntregaFuturaMensagem(strIndRev: string; blnDarMensagem: Boolean): Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;

      Add('SELECT COUNT(*) AS QTDREG FROM CADCFO');
      Add('WHERE CFO_CODCFO IN ("5'+strIndRev+'","6'+strIndRev+'")');
      Open;

      Result := FieldByName('QTDREG').AsInteger >= 2;

      If (Not Result) And blnDarMensagem Then
        fMensagem('','Cadastre as Classificações Fiscais 5'+strIndRev+' e 6'+strIndRev+' para realizar a baixa.', ['&Ok']);

      Close;
    End;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fTemCFOPBaixaEntregaFuturaMensagem]');
    End;
  End;
end;

Function fTemCFOPEntregaFutura(blnDarMensagem: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
Begin

  Try

    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;

      Add('SELECT COUNT(*) AS QTDREG FROM CADCFO');
      Add('WHERE CFO_CODCFO IN ("5922","6922")');
      Open;

      Result := FieldByName('QTDREG').AsInteger >= 2;

      If (Not Result) And blnDarMensagem Then
        fMensagem('','Cadastre as Classificações Fiscais 5922 e 6922 para trabalhar com Entrega Futura.', ['&Ok']);

      Close;
    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fTemCFOPEntregaFutura]');
    End;
  End;

End;

Function fTemTransportadoraPadrao(blnDarMensagem: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
Begin

  Try

    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;

      Add('SELECT TRA_CODTRA FROM CADTRA');
      Add('WHERE TRA_CODTRA = :CODIGO');

      ParamByName('CODIGO').AsString := fCfgSis('TRASUG');

      Open;

      Result := Not IsEmpty;

      If (Not Result) And blnDarMensagem Then
        fMensagem('','Cadastre a Transportadora Sugestão em Configurações/ Nota Fiscal.', ['&Ok']);

      Close;
    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fTemTransportadoraPadrao]');
    End;
  End;
End;


function fVerificaExisteDuplicContasPagar(strAutInc: String; Var strCodFor, strNumDup, strParcel, strCodEmp, strSeqBai, strSerie_, strVenCtp: String; Var ACodigoDeBarras : String): Boolean;
  Var
    qryCtaCtp: TUniQuery;
    strSQL: String;
begin

  Result := False;

  Try

    qryCtaCtp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT CTP_CODFOR,          ';
    strSQL := strSQL + '        CTP_NUMDUP,          ';
    strSQL := strSQL + '        CTP_PARCEL,          ';
    strSQL := strSQL + '        CTP_CODEMP,          ';
    strSQL := strSQL + '        CTP_SEQBAI,          ';
    strSQL := strSQL + '        CTP_SERIE_,          ';
    strSQL := strSQL + '        CTP_CODBAR,          ';
    strSQL := strSQL + '        CTP_DTAVEN           ';
    strSQL := strSQL + '   FROM CADPAG               ';
    strSQL := strSQL + '  WHERE ';

    If Length(strAutInc) < 20 Then
    Begin
      strSQL := strSQL + ' (CTP_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '  (CTP_SERIE_ = :SERIE_ ' + IIF(fEmptyStr(strSerie_), ' OR CTP_SERIE_ IS NULL ', '') + ')  AND ';
      strSQL := strSQL + '  CTP_SEQBAI = 0)       OR ';
      strSQL := strSQL + ' (CTP_NUMDUP = :AUTOIN AND ';
      strSQL := strSQL + '  CTP_SEQBAI = 0)          '; //DEVEMOS RETIRAR ISSO, CHAVE MUITO, MAS MUITO FRACA MESMO.
      strSQL := strSQL + ' LIMIT 1 ';
    End
    Else
      strSQL := strSQL + ' AUTOINCREM = :AUTOIN ';

    With qryCtaCtp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOIN').AsString := strAutInc;

      If Length(strAutInc) < 20 Then
      Begin
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODFOR').AsString := strCodFor;
        ParamByName('SERIE_').AsString := strSerie_;
      End;

      Open;

      If (Not IsEmpty) And (RecordCount = 1) Then
      Begin

        Result := True;

        strCodFor := FieldByName('CTP_CODFOR').AsString;
        strNumDup := FieldByName('CTP_NUMDUP').AsString;
        strParcel := FieldByName('CTP_PARCEL').AsString;
        strCodEmp := FieldByName('CTP_CODEMP').AsString;
        strSeqBai := FieldByName('CTP_SEQBAI').AsString;
        strSerie_ := FieldByName('CTP_SERIE_').AsString;
        strVenCtp := FieldByName('CTP_DTAVEN').AsString;
        ACodigoDeBarras := FieldByName('CTP_CODBAR').AsString;

      End;

    End;

  Finally
    FreeAndNil(qryCtaCtp);
  End;

end;


function fVerificaExisteDuplicContasPagar(strAutInc: String; Var strCodFor, strNumDup, strParcel, strCodEmp, strSeqBai, strSerie_, strVenCtp: String): Boolean;
  Var
    qryCtaCtp: TUniQuery;
    strSQL: String;
begin

  Result := False;

  Try

    qryCtaCtp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT CTP_CODFOR,          ';
    strSQL := strSQL + '        CTP_NUMDUP,          ';
    strSQL := strSQL + '        CTP_PARCEL,          ';
    strSQL := strSQL + '        CTP_CODEMP,          ';
    strSQL := strSQL + '        CTP_SEQBAI,          ';
    strSQL := strSQL + '        CTP_SERIE_,          ';
    strSQL := strSQL + '        CTP_DTAVEN           ';
    strSQL := strSQL + '   FROM CADPAG               ';
    strSQL := strSQL + '  WHERE ';

    If Length(strAutInc) < 20 Then
    Begin
      strSQL := strSQL + ' (CTP_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '  (CTP_SERIE_ = :SERIE_ ' + IIF(fEmptyStr(strSerie_), ' OR CTP_SERIE_ IS NULL ', '') + ')  AND ';
      strSQL := strSQL + '  CTP_SEQBAI = 0)       OR ';
      strSQL := strSQL + ' (CTP_NUMDUP = :AUTOIN AND ';
      strSQL := strSQL + '  CTP_SEQBAI = 0)          '; //DEVEMOS RETIRAR ISSO, CHAVE MUITO, MAS MUITO FRACA MESMO.
      strSQL := strSQL + ' LIMIT 1 ';
    End
    Else
      strSQL := strSQL + ' AUTOINCREM = :AUTOIN ';

    With qryCtaCtp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOIN').AsString := strAutInc;

      If Length(strAutInc) < 20 Then
      Begin
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODFOR').AsString := strCodFor;
        ParamByName('SERIE_').AsString := strSerie_;
      End;

      Open;

      If (Not IsEmpty) And (RecordCount = 1) Then
      Begin

        Result := True;

        strCodFor := FieldByName('CTP_CODFOR').AsString;
        strNumDup := FieldByName('CTP_NUMDUP').AsString;
        strParcel := FieldByName('CTP_PARCEL').AsString;
        strCodEmp := FieldByName('CTP_CODEMP').AsString;
        strSeqBai := FieldByName('CTP_SEQBAI').AsString;
        strSerie_ := FieldByName('CTP_SERIE_').AsString;
        strVenCtp := FieldByName('CTP_DTAVEN').AsString;

      End;

    End;

  Finally
    FreeAndNil(qryCtaCtp);
  End;

end;

{*************************************************************************}
{* PROCESSA A TABELA TMP_ENTMER PARA VERFICAR SE EXISTEM ITENS ESPECIAIS *}
{**********************************************************************LU*}
function fVerificaItemEspecial: Boolean;
Begin

  Result := False;

  If (fCfgSis('EMIESP', varBoolean)) Then
    Exit;

  If (not fTabelaExiste('TMP_ENTMER')) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    Result := fncExecutaRelatorio(199, 7575, [], [], [], nil, nil, True, False);
  End;

End;

{********************************}
{* VALIDA CONDIÇÃO DE PAGAMENTO *}
{* FS - FORA SEMANA             *}
{* FD - FORA DEZENA             *}
{* FQ - FORA QUINZENA           *}
{* FM - FORA MES                *}
{*****************************LU*}
function fValidaCndPagFora(strCndPag: String): String;
Var
  strTipo: String;
  strCondPagto: String;
  intDiaDif: Integer;
	Dia, Mes, Ano : Word;
  dtaDataNov: TDateTime;
  intDias: Integer;
begin

  strCondPagto := EmptyStr;
  strTipo := copy(strCndPag, 1, 2);

  DecodeDate(VS_Date, Ano, Mes, Dia);

  If (strTipo = 'FS') Then   // FORA SEMANA
  Begin
    dtaDataNov := VS_Date + 1;
    //intDiaDif := Dia;

    intDias := 1;

    While DayOfWeek(dtaDataNov) <> 2 Do
    Begin
      intDias := intDias + 1;
      dtaDataNov := dtaDataNov + 1;
    End;

//    DecodeDate(dtaDataNov, Ano, Mes, Dia);
//    strCondPagto := '01' + fPadL(IntToStr((Dia - intDiaDif) + StrToInt(copy(strCndPag,3,3))),3,'0');

    strCondPagto := '01' + fPadL(IntToStr(intDias + StrToIntDef(copy(strCndPag,3,3), 0)),3,'0');
  End;

  If (strTipo = 'FD') Then   // FORA DEZENA
  Begin
    If (Dia <= 10) Then
      intDiaDif := 10 - Dia
    Else
    Begin
      If (Dia >= 11) And (Dia <= 20) Then
        intDiaDif := 20 - Dia
      Else
        intDiaDif := fRetDiasNoMes(Ano, Mes) - Dia;
    End;

    strCondPagto := '01' + fPadL(IntToStr(intDiaDif + StrToIntDef(copy(strCndPag,3,3), 0)), 3, '0');
  End;

  If (strTipo = 'FQ') Then   // FORA QUINZENA
  Begin
    If (Dia <= 15) Then
      intDiaDif := 15 - Dia
    Else
      intDiaDif := fRetDiasNoMes(Ano, Mes) - Dia;

    strCondPagto := '01' + fPadL(IntToStr(intDiaDif + StrToIntDef(copy(strCndPag,3,3), 0)),3,'0');
  End;

  If (strTipo = 'FM') Then   // FORA MÊS
  Begin
    intDiaDif := fRetDiasNoMes(Ano, Mes) - Dia;

    strCondPagto := '01' + fPadL(IntToStr(intDiaDif + StrToIntDef(copy(strCndPag,3,3), 0)),3,'0');
  End;

  Result := strCondPagto;

end;

{*******************************************}
{* RETORNA QTS DIAS TEM UM DETERMINADO MÊS *}
{****************************************LU*}
function fRetDiasNoMes(intAno, IntMes: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
Begin

  Result := DaysInMonth[IntMes];

  if IntMes = 2 then
  begin

    If (IntAno Mod 4) = 0 Then
      Result := 29;

  End;

End;

function fPos(const SubStr, S: String): Boolean;
begin
  Result := Pos(SubStr, S) > 0;
end;                            

function fPosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

function fTemInvFin(strTabela, strPreFix: String): Boolean;
  Var
    qryAux: TUniQuery;
begin

  Try
    qryAux := fCriaQuery;

    qryAux.SQL.Add( 'SELECT COUNT(*) AS VALOR FROM ' + strTabela + ' WHERE ' + strPreFix +
                    '_CODEMP  =  :CODEMP  GROUP BY ' + strPreFix + '_CODEMP' );
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;
    Result := (qryAux.FieldByName('VALOR').AsInteger > 0);
    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

End;

function fRetCorEmpresa(strCodEmp: String): Integer;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_CORFUN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := StrToIntDef(FieldByName('EMP_CORFUN').AsString,0);

      If Result = 0 Then
        Result := clWhite;

      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;

function fFormaPagtoPermitidaComAReceber(strCodFpg: String): Boolean;
begin
  Result := MatchStr(strCodFpg, FORMAS_PAGTO_PERMITIDAS_COM_A_RECEBER);
end;

function fDescricaoFormasPagtoPermitidasComAReceber: String;
  Var
    intFpg: Integer;
    strFpg: String;
begin
  Result := '';
  For intFpg := 0 To Length(FORMAS_PAGTO_PERMITIDAS_COM_A_RECEBER) -1 Do
  Begin
    strFpg := FORMAS_PAGTO_PERMITIDAS_COM_A_RECEBER[intFpg];

    If Result <> '' Then
      If intFpg < (Length(FORMAS_PAGTO_PERMITIDAS_COM_A_RECEBER) -1) Then
        Result := Result + ', '
      Else
        Result := Result + ' ou ';

    Result := Result + fRetDesFpg(strFpg);
  End;
end;

procedure pCarregaFormasPagto(strCodCli: String;
                              var stlForPag: TStringList;
                              var stlCndPag: TStringList;
                              strTipCli: String = '');
  Var
    strSQLFpg: String;
    strSQLCnd: String;
    qryGenTip: TUniQuery;

    procedure pSetaParametros;
    Begin
      If (Not fEmptyStr(strTipCli)) Then
        qryGenTip.ParamByName('CODTIP').AsString := strTipCli
      Else
        qryGenTip.ParamByName('CODCLI').AsString := strCodCli;
    End;

begin
  Try
     stlForPag.Clear;
     stlCndPag.Clear;

    If Not fCfgSis('USATPC', varBoolean) Then
      Exit;

    qryGenTip := fCriaQuery;

    If (Not fEmptyStr(strTipCli)) Then
    Begin
      strSQLFpg := '';
      strSQLFpg := strSQLFpg + 'SELECT ';
      strSQLFpg := strSQLFpg + '  TCD_CODFPG ';
      strSQLFpg := strSQLFpg + 'FROM ';
      strSQLFpg := strSQLFpg + '  TIPCLD ';
      strSQLFpg := strSQLFpg + 'WHERE ';
      strSQLFpg := strSQLFpg + '  TCD_CODTIP = :CODTIP ';

      strSQLCnd := '';
      strSQLCnd := strSQLCnd + 'SELECT ';
      strSQLCnd := strSQLCnd + '  IF(IFNULL(TCN_CODCND,"") = "", TCN_CNDPAG, TCN_CODCND) AS TCN_CNDPAG ';
      strSQLCnd := strSQLCnd + 'FROM ';
      strSQLCnd := strSQLCnd + '  TIPCND ';
      strSQLCnd := strSQLCnd + 'WHERE ';
      strSQLCnd := strSQLCnd + '  TCN_CODTIP = :CODTIP ';
    End
    Else
    Begin
      strSQLFpg := '';
      strSQLFpg := strSQLFpg + 'SELECT ';
      strSQLFpg := strSQLFpg + '  TCD_CODFPG ';
      strSQLFpg := strSQLFpg + 'FROM ';
      strSQLFpg := strSQLFpg + '  CADCLI ';
      strSQLFpg := strSQLFpg + '  JOIN TIPCLD ON TCD_CODTIP = CLI_TIPCLI ';
      strSQLFpg := strSQLFpg + 'WHERE ';
      strSQLFpg := strSQLFpg + '  CLI_CODCLI = :CODCLI ';

      strSQLCnd := '';
      strSQLCnd := strSQLCnd + 'SELECT ';
      strSQLCnd := strSQLCnd + '  IF(IFNULL(TCN_CODCND, "") = "", TCN_CNDPAG, TCN_CODCND) AS TCN_CNDPAG ';
      strSQLCnd := strSQLCnd + 'FROM ';
      strSQLCnd := strSQLCnd + '  CADCLI ';
      strSQLCnd := strSQLCnd + '  JOIN TIPCND ON TCN_CODTIP = CLI_TIPCLI ';
      strSQLCnd := strSQLCnd + 'WHERE ';
      strSQLCnd := strSQLCnd + '  CLI_CODCLI = :CODCLI ';
    End;

    With qryGenTip Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLFpg);
      pSetaParametros;
      Open;

      While (Not Eof) Do
      Begin
        stlForPag.Add(FieldByName('TCD_CODFPG').AsString);
        Next;
      End;
    End;

    With qryGenTip Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLCnd);
      pSetaParametros;
      Open;

      While (Not Eof) Do
      Begin
        stlCndPag.Add(FieldByName('TCN_CNDPAG').AsString);
        Next;
      End;
    End;

  Finally
    FreeAndNil(qryGenTip);
  End;
end;

function fPagamentoPermitidaParaTipoCliente(const strCodCli, strCodFpg: String): Boolean;
  Var
    stlForPag: TStringList;
    stlCndPag: TStringList;
begin
  Result := True;

  stlForPag := TStringList.Create;
  stlCndPag := TStringList.Create;
  Try
    pCarregaFormasPagto(strCodCli, stlForPag, stlCndPag);

    If (stlForPag.Count > 0) Then
      Result := (stlForPag.IndexOf(strCodFpg) >= 0);
  Finally
    FreeAndNil(stlForPag);
    FreeAndNil(stlCndPag);
  End;
end;

procedure pMsgFormasPagtoPermitidasCliente( strCodFpg: String;
                                            stlForPag: TStringList;
                                            objMsg: TMensagemLiberacao );
  Var
    intInd: Integer;
    strMsg: String;
begin

  strMsg := 'Cliente não tem permissão para essa forma de pagamento!' + #13 +
            strCodFpg + '-' + fRetDesFpg(strCodFpg)                   + #13 + #13 +
            'Formas permitidas: ';

  For intInd := 0 To stlForPag.Count -1 Do
    strMsg := strMsg + #13 + (stlForPag[intInd] + '-' + fRetDesFpg(stlForPag[intInd]));

  objMsg.pAddTexto(strMsg);
  pMensagemSonora(strMsg, False, 20);

end;

function fGravaCodSeq(strNomeTabela: String; intCodSeq: Integer): Boolean;
  Var
    strSQL   : String;
    qryGenCod: TUniQuery;
begin
  Try

    qryGenCod := fCriaQuery;

    Try

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PROCOD ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  PRO_CODSEQ = :CODSEQ ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

      With qryGenCod Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODSEQ').AsInteger := intCodSeq;
        ParamByName('NOMARQ').AsString  := strNomeTabela;
        ExecSQL;
        Close;
        Result := True;

      End;

    Except

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaProCod]');
      End;
    End;

  Finally
    FreeAndNil(qryGenCod);
  End;

end;

function fRetEmpRespConfDocs(strCodCli: String) : String;
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CLI_EMPRCF ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADCLI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      Result := fieldbyname('CLI_EMPRCF').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function fDuplicataPrincipalBaixada(strNumDup, strParcel, strEspDoc,
  strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
  Var
    qryDupPrinc: TUniQuery;
    strMsg: String;
Begin
  qryDupPrinc := fCriaQuery(Nil);

  qryDupPrinc.Close;
  qryDupPrinc.SQL.Clear;
  qryDupPrinc.SQL.Add('SELECT ');
  qryDupPrinc.SQL.Add('  CTR_DTABAI, ');
  qryDupPrinc.SQL.Add('  CTR_SEQCON  ');
  qryDupPrinc.SQL.Add('FROM ');
  qryDupPrinc.SQL.Add('  CADREC ');
  qryDupPrinc.SQL.Add('WHERE ');
  qryDupPrinc.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
  qryDupPrinc.SQL.Add('  CTR_PARCEL = :PARCEL AND ');
  qryDupPrinc.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
  qryDupPrinc.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
  qryDupPrinc.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
  qryDupPrinc.SQL.Add('  CTR_SEQBAI = 0 ');

  qryDupPrinc.ParamByName('NUMDUP').AsString  := strNumDup;
  qryDupPrinc.ParamByName('PARCEL').AsString  := strParcel;
  qryDupPrinc.ParamByName('ESPDOC').AsString  := strEspDoc;
  qryDupPrinc.ParamByName('CODEMP').AsString  := strCodEmp;
  qryDupPrinc.ParamByName('CODCLI').AsString  := strCodCli;
  qryDupPrinc.Open;

  If qryDupPrinc.IsEmpty Then
  Begin
    strMsg := 'Estorno não permitido, pois a duplicata principal da duplicata ' + #13#10 +
              '(' + strNumDup + strParcel + '-' + strEspDoc + '-' + strCodEmp + '-' + strCodCli + ').' + #13#10 +
              'Possível motivo: a duplicata já foi agrupada.';
    Raise ExceptionAutcom.Create(strMsg);
  End;

  Result := Not qryDupPrinc.FieldByName('CTR_DTABAI').IsNull;

  qryDupPrinc.Close;
  FreeAndNil(qryDupPrinc);

End;

//CADREC: PARAMETROS -> ASeqLan+ATabela+ACodEmp
//CADPAG: PARÂMETROS -> Todos eles
function EstaConciliado(ASeqLan,ATabela: String;
                        ATipoBaixa: String = '';
                        ADtaConIsNotNull: Boolean = False;
                        ACodEmp: String = '';
                        ANumDup: String = '';
                        AParcel: String = '';
                        AEmpDup: String = '';
                        ASerie : String = '';
                        ADtaPag: TDateTime = 0;
                        ACodigoFornecedor: String = ''): Boolean;
Var
  strSQL   : String;
  qryGen   : TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT CTB_DTACON ';
  strSQL := strSQL + 'FROM MOVBAN ';
  strSQL := strSQL + 'WHERE ';

  if ATabela = 'CADPAG' then
    strSQL := strSQL + 'CTB_PAGCON = :SEQLAN '
  else
    strSQL := strSQL + 'CTB_SEQLAN = :SEQLAN ';

  if (Trim(ACodEmp) <> '' ) then
    strSQL := strSQL + ' AND CTB_CODEMP = :CODEMP ';

  if ATipoBaixa = 'A' then
  begin
    if (Trim (ANumDup) <> '' ) then
      strSQL := strSQL + ' AND CTB_NUMDUP = :NUMDUP ';

    if (Trim (AParcel) <> '' ) then
      strSQL := strSQL + ' AND CTB_PARCEL = :PARCEL ';

    if (Trim (AEmpDup) <> '' ) then
      strSQL := strSQL + ' AND CTB_EMPDUP = :EMPDUP ';

    if (Trim (ASerie) <> '' ) then
      strSQL := strSQL + ' AND CTB_SERIE_ = :SERIE_ ';

    If Not ACodigoFornecedor.Trim.IsEmpty Then
      strSQL := strSQL + ' AND CTB_CODFOR = :CODFOR ';
  end;

  if ADtaConIsNotNull then
    strSQL := strSQL + ' AND CTB_DTACON IS NOT NULL ';

  If ADtaPag <> 0 Then
    strSQL := strSQL + ' AND CTB_DTALAN  = :DTALAN';

  Try
    qryGen := fCriaQuery(Nil);
    qryGen.SQL.Clear;
    qryGen.SQL.add(strSQL);
    qryGen.ParamByName('SEQLAN').AsString := ASeqLan;

    if (Trim(ACodEmp) <> '' ) then
      qryGen.ParamByName('CODEMP').AsString := ACodEmp;

    If ADtaPag <> 0 Then
      qryGen.ParamByName('DTALAN').AsDateTime := ADtaPag;

    if ATipoBaixa = 'A' then
    begin
      if (Trim(ANumDup) <> '' ) then
        qryGen.ParamByName('NUMDUP').AsString := ANumDup;

      if (Trim(AParcel) <> '' ) then
        qryGen.ParamByName('PARCEL').AsString := AParcel;

      if (Trim(AEmpDup) <> '' ) then
        qryGen.ParamByName('EMPDUP').AsString := AEmpDup;

      if (Trim(ASerie) <> '' ) then
        qryGen.ParamByName('SERIE_').AsString := ASerie;

      If Not ACodigoFornecedor.Trim.IsEmpty Then
        qryGen.ParamByName('CODFOR').AsString := ACodigoFornecedor;
    end;

    qryGen.Open;

    if (qryGen.RecordCount > 0) and (not (qryGen.FieldByName('CTB_DTACON').IsNull))then
    begin
      Result := True;
    end;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fVerificaSeDuplicataEstaVinculadaParaConciliacao(strNumDup: String = '';strParcel: String = '';
                                                          strCodEmp: String = '';strForCli: String = '';
                                                          strEspDoc: String = '';strSerie_: String = '';
                                                          strTabela: String = '';strSeqLan: String = '') : Boolean ;
  Var
    qryAux : TUniQuery;
Begin
  Try
    Result := False;
    Try
      qryAux := fCriaQuery(Nil);
      With qryAux Do
      Begin
        SQL.Clear;
        SQL.Add(fGetSqlVinculada(strTabela));

        ParamByName('NUMDUP').AsString  := strNumDup;
        ParamByName('PARCEL').AsString  := strParcel;
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('FORCLI').AsString  := strForCli;
        ParamByName('SEQLAN').AsString  := strSeqLan;

        If Not fEmptyStr(strEspDoc) Then
          ParamByName('ESPDOC').AsString := strEspDoc;
        If Not fEmptyStr(strSerie_) Then
          ParamByName('SERIE_').AsString := strSerie_;
        Open;
        Result := RecordCount > 0;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fVerificaSeDuplicataEstaVinculadaParaConciliacao]');
      End;
    End;
  Finally
    pFreeAndNil(qryAux);
  End;
End;


function fGetSqlVinculada(strTabela : String = ''): String;
  Var
    strSQL : String;
Begin
  If strTabela = 'CADREC' Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT                               ';
    strSQL := strSQL + '  *                                  ';
    strSQL := strSQL + 'FROM                                 ';
    strSQL := strSQL + '  BANCTR B                           ';
    strSQL := strSQL + '  INNER JOIN MOVBAN M                ';
    strSQL := strSQL + '    ON M.CTB_SEQLAN = B.CTB_SEQLAN   ';
    strSQL := strSQL + '  INNER JOIN BANEXR E                ';
    strSQL := strSQL + '    ON E.EXR_BANINC = M.AUTOINCREM   ';
    strSQL := strSQL + 'WHERE B.CTR_NUMDUP = :NUMDUP         ';
    strSQL := strSQL + '  AND B.CTR_PARCEL = :PARCEL         ';
    strSQL := strSQL + '  AND B.CTR_ESPDOC = :ESPDOC         ';
    strSQL := strSQL + '  AND B.CTR_CODEMP = :CODEMP         ';
    strSQL := strSQL + '  AND B.CTR_CODCLI = :FORCLI         ';
    strSQL := strSQL + '  AND M.CTB_SEQLAN = :SEQLAN        ';
    strSQL := strSQL + '  AND M.CTB_DTACON IS NULL           ';
  End;

  Result := strSQL;
End;

function fTemTransfEstoque(intDiasTolerancia: Integer = 0): Boolean;
  Var
    strSQL   : String;
    qryGen   : TUniQuery;
    strCliFil: String;
Begin
  Result    := False;

  strCliFil := QuotedStr(fCampoTabela('EMP_CLIFIL','CADEMP',['EMP_CODEMP'],[VS_strCodEmp], False));

  If fEmptyStr(strCliFil) Then
    Exit;

  Try

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
    strSQL := strSQL + '   "MOVGER" AS TABELA,        ';
    strSQL := strSQL + '   CONCAT(GER_NUMDOC," - ",GER_ESPDOC) AS GER_DOCUME, ';
    strSQL := strSQL + '   GER_VLRCON, PCG_CODFOR, PCG_NUMPED, GER_DTAENT     ';
    strSQL := strSQL + ' FROM                          ';
    strSQL := strSQL + '   MOVGER G                   ';

    If fCfgSis('USADIG', varBoolean) Then
      strSQL := strSQL + '   INNER JOIN CADOPE ON OPE_CODOPE = IFNULL(GER_CODDIG, GER_CODVEN) '
    Else
      strSQL := strSQL + '   INNER JOIN CADOPE ON OPE_CODOPE = GER_CODVEN ';

    If fCfgSis('CPDORI', varBoolean) Then
    Begin
      strSQL := strSQL + ' INNER JOIN PCMGER ON PCG_ORIGND = GER_NUMDOC ';
      strSQL := strSQL + '                  AND PCG_ORIGES = GER_ESPDOC ';
      strSQL := strSQL + '                  AND PCG_ORIGEP = GER_CODEMP ';
      strSQL := strSQL + '                  AND PCG_BAIXAD = 0 ';
    End
    Else
    Begin
      strSQL := strSQL + '   INNER JOIN                  ';
      strSQL := strSQL + '   (                           ';
      strSQL := strSQL + '     SELECT                    ';
      strSQL := strSQL + '       PCG_CODFOR, PCG_NUMPED, PCG_CODEMP,            ';
      strSQL := strSQL + '       SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ')        AS ORI_NUMDOC,       ';
      strSQL := strSQL + '       SUBSTRING(PCG_DOCORI,' + IntToStr(Succ(fTamDocCadRec)) + ', 2) AS ORI_ESPDOC,       ';
      strSQL := strSQL + '       SUBSTRING(PCG_DOCORI,' + IntToStr(fTamDocCadRec + 3) + ', 3)   AS ORI_CODEMP        ';
      strSQL := strSQL + '     FROM PCMGER               ';
      strSQL := strSQL + '     WHERE                     ';
      strSQL := strSQL + '       PCG_BAIXAD = 0 AND                             ';
      strSQL := strSQL + '       IFNULL(PCG_DOCORI, "") <> ""                   ';
      strSQL := strSQL + '   ) AS TMP ON ORI_NUMDOC = GER_NUMDOC AND            ';
      strSQL := strSQL + ' 	             ORI_ESPDOC = GER_ESPDOC AND            ';
      strSQL := strSQL + '               ORI_CODEMP = GER_CODEMP                ';
    end;
    strSQL := strSQL + ' WHERE                         ';
    strSQL := strSQL + '   GER_CODCLI = ' + strCliFil + ' AND ';
    strSQL := strSQL + '   GER_ESPDOC = "TE" AND  ';
    strSQL := strSQL + '   GER_DTAENT <= :DTAENT  ';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
    strSQL := strSQL + '   "MOVGER" AS TABELA,         ';
    strSQL := strSQL + '   CONCAT(GER_NUMDOC," - ",GER_ESPDOC) AS GER_DOCUME, ';
    strSQL := strSQL + '   GER_VLRCON, PCG_CODFOR, PCG_NUMPED, GER_DTAENT     ';
    strSQL := strSQL + ' FROM                          ';
    strSQL := strSQL + '   MOVGER G                    ';

    If fCfgSis('USADIG', varBoolean) Then
      strSQL := strSQL + '   INNER JOIN CADOPE ON OPE_CODOPE = IFNULL(GER_CODDIG, GER_CODVEN) '
    Else strSQL := strSQL + '   INNER JOIN CADOPE ON OPE_CODOPE = GER_CODVEN ';

    If fCfgSis('CPDORI', varBoolean) Then
    Begin
      strSQL := strSQL + ' INNER JOIN PCMGER ON PCG_ORIGND = GER_NUMDOC ';
      strSQL := strSQL + '                  AND PCG_ORIGES = GER_ESPDOC ';
      strSQL := strSQL + '                  AND PCG_ORIGEP = GER_CODEMP ';
      strSQL := strSQL + '                  AND PCG_BAIXAD = 0 ';
    end
    else
    begin
      strSQL := strSQL + '   INNER JOIN                  ';
      strSQL := strSQL + '   (                           ';
      strSQL := strSQL + '     SELECT                    ';
      strSQL := strSQL + '       PCG_CODFOR, PCG_NUMPED, PCG_CODEMP,            ';
      strSQL := strSQL + '       SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ')        AS ORI_NUMDOC,       ';
      strSQL := strSQL + '       SUBSTRING(PCG_DOCORI,' + IntToStr(Succ(fTamDocCadRec)) + ', 2) AS ORI_ESPDOC,       ';
      strSQL := strSQL + '       SUBSTRING(PCG_DOCORI,' + IntToStr(fTamDocCadRec + 3) + ', 3)   AS ORI_CODEMP        ';
      strSQL := strSQL + '     FROM PCMGER               ';
      strSQL := strSQL + '     WHERE                     ';
      strSQL := strSQL + '       PCG_BAIXAD = 0 AND                             ';
      strSQL := strSQL + '       IFNULL(PCG_DOCORI, "") <> ""                   ';
      strSQL := strSQL + '   ) AS TMP ON ORI_NUMDOC = GER_NUMDOC AND            ';
      strSQL := strSQL + '               ORI_ESPDOC = GER_ESPDOC AND            ';
      strSQL := strSQL + '               ORI_CODEMP = GER_CODEMP                ';
    end;
    strSQL := strSQL + ' WHERE                         ';
    strSQL := strSQL + '   GER_CODCLI = ' + strCliFil + ' AND ';
    strSQL := strSQL + '   (GER_ESPDOC = "NF" OR GER_ESPDOC = "EL") AND ';
    strSQL := strSQL + '   GER_DTAENT <= :DTAENT  ';

    Try
      qryGen := fCriaQuery(Nil);
      With qryGen Do
      Begin
        SQL.Clear;
        SQL.add(strSQL);
        ParamByName('DTAENT').AsDateTime := VS_Date - intDiasTolerancia;
        Open;

        Result := RecordCount > 0;
      End;
    Finally
      FreeAndNil(qryGen);
    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[fTemTransfEstoque]');
    End;
  End;

End;

Function fTemDuplicataPosteriorBaixada(strNumDup,
                                       strParcel,
                                       strEspDoc,
                                       strCodEmp,
                                       strCodCli: String;
                                       intSeqBai,
                                       intSeqCon: Integer): Boolean;
  Var
    qryDupPrinc: TUniQuery;
Begin

  If intSeqBai = 0 Then
  Begin
    Result := FALSE;
    Exit;
  End;

  qryDupPrinc := fCriaQuery(Nil);

  qryDupPrinc.Close;
  qryDupPrinc.SQL.Clear;
  qryDupPrinc.SQL.Add('SELECT ');
  qryDupPrinc.SQL.Add('  CTR_DTABAI ');
  qryDupPrinc.SQL.Add('FROM ');
  qryDupPrinc.SQL.Add('  CADREC ');
  qryDupPrinc.SQL.Add('WHERE ');
  qryDupPrinc.SQL.Add('  CTR_NUMDUP  = :NUMDUP AND ');
  qryDupPrinc.SQL.Add('  CTR_PARCEL  = :PARCEL AND ');
  qryDupPrinc.SQL.Add('  CTR_ESPDOC  = :ESPDOC AND ');
  qryDupPrinc.SQL.Add('  CTR_CODEMP  = :CODEMP AND ');
  qryDupPrinc.SQL.Add('  CTR_CODCLI  = :CODCLI AND ');
  qryDupPrinc.SQL.Add('  CTR_SEQCON <> :SEQCON AND ');
  qryDupPrinc.SQL.Add('  CTR_SEQBAI  > :SEQBAI     ');

  qryDupPrinc.ParamByName('NUMDUP').AsString  := strNumDup;
  qryDupPrinc.ParamByName('PARCEL').AsString  := strParcel;
  qryDupPrinc.ParamByName('ESPDOC').AsString  := strEspDoc;
  qryDupPrinc.ParamByName('CODEMP').AsString  := strCodEmp;
  qryDupPrinc.ParamByName('CODCLI').AsString  := strCodCli;
  qryDupPrinc.ParamByName('SEQCON').AsInteger := intSeqCon;
  qryDupPrinc.ParamByName('SEQBAI').AsInteger := intSeqBai;
  qryDupPrinc.Open;

  Result := Not qryDupPrinc.IsEmpty;

  qryDupPrinc.Close;
  FreeAndNil(qryDupPrinc);
End;

function fItemAtivoParaCompras(strCodIte: String): Boolean;
begin
  Result := fCampoTabela('ITE_ATICOM', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S';
end;

function fItemRealizaEnderecamento(strCodIte: String): Boolean;
begin
  Result := (fCampoTabela('ITE_REAEND', 'CADITE', ['ITE_CODITE'], [strCodIte]) <> 'N');
end;

function fItemJaRealizadoEnderecamento(strAutInc: String): Boolean;
begin
  Result := not fEmptyStr(fCampoTabela('FDO_SEQFDO', 'EXTDOR', ['FDO_AUTEND'], [strAutInc]));
end;

function fRetMargemBruta(strCodIte, strTabPre: String): Double;
  Var
    qryBusca : TUniQuery;
begin

  qryBusca := fCriaQuery(Nil);

  With qryBusca Do
  Begin
    Close;
    SQL.Clear;

    SQL.Add(' SELECT SQL_NO_CACHE          ');
    SQL.Add('   ITE_MARBR' + strTabPre + ' ');
    SQL.Add(' FROM                         ');
    SQL.Add('   ITEGER                     ');
    SQL.Add(' WHERE                        ');
    SQL.Add('   ITE_CODITE = :CODITE AND   ');
    SQL.Add('   ITE_CODEMP = :CODEMP       ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If IsEmpty Then
      Result := 0.0
    Else
      Result := Fields[0].AsFloat;

  End;

  FreeAndNil(qryBusca);

end;


function fRetornaPortadorCliente(strCodCli: String): String;
  Var
    strSql: String;
    qryCli: TUniQuery;
begin

  strSql := '';
  strSql := strSql + ' SELECT                      ';
  strSql := strSql + '   CLI_CODPOR                ';
  strSql := strSql + ' FROM                        ';
  strSql := strSql + '   CADCLI                    ';
  strSql := strSql + ' WHERE CLI_CODCLI = :CODCLI  ';

  qryCli := fCriaQuery(Nil);

  With qryCli Do
  Begin
    SQL.Add(strSql);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
    Result := Fields[0].AsString;
    Close;
  End;

  FreeAndNil(qryCli);

end;

function fRetornaStatusCliente(strCodCli: String): String;
  Var
    strSql: String;
    qryCli: TUniQuery;
begin

  strSql := '';
  strSql := strSql + ' SELECT                      ';
  strSql := strSql + '   CLI_STATUS                ';
  strSql := strSql + ' FROM                        ';
  strSql := strSql + '   CADCLI                    ';
  strSql := strSql + ' WHERE CLI_CODCLI = :CODCLI  ';

  qryCli := fCriaQuery(Nil);

  With qryCli Do
  Begin
    SQL.Add(strSql);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
    Result := Fields[0].AsString;
    Close;
  End;

  FreeAndNil(qryCli);

end;

function fRetornaStatusCadastro(strCodigo, strTipo, strTabela, strCampo: String): String;
  Var
    strSql: String;
    qryCad: TUniQuery;
begin

  strSql := '';
  strSql := strSql + ' SELECT                   ';
  strSql := strSql + '   ' + strTipo + '_STATUS ';
  strSql := strSql + ' FROM                     ';
  strSql := strSql + strTabela;
  strSql := strSql + ' WHERE                    ';
  strSql := strSql + strCampo + ' = :CODIGO     ';

  qryCad := fCriaQuery(Nil);

  With qryCad Do
  Begin
    SQL.Add(strSql);
    ParamByName('CODIGO').AsString := strCodigo;
    Open;
    Result := Fields[0].AsString;
    Close;
  End;

  FreeAndNil(qryCad);

end;

function fDocumentoPossuiServicos(strNumDoc, strEspDoc, strCodEmp: String; Var blnSomenteServ: Boolean; blnFiltraJaFatu: Boolean=False; blnUsaCodEmp: Boolean=False): Boolean;
  Var
    strSql : String;
    qryGen : TUniQuery;
Begin

  Result := False;

  qryGen := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FGO_CODS01 AS CODS01, ';
  strSQL := strSQL + '  FGO_DESS01 AS DESS01, ';
  strSQL := strSQL + '  FDO_CODITE AS CODITE  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR D';
  strSQL := strSQL + '  INNER JOIN FATGOR G ON (G.AUTOINCREM = FDO_SEQGER) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';
  If blnFiltraJaFatu Then
  strSql := strSql + '  AND FDO_JAFATU = 0 ';

  If Pos(strEspDoc, 'PD_OR') <= 0 Then
  Begin
    strSql := strSql + ' AND DET_TIP_FC = "C"  ';

    strSql := AnsiReplaceStr(strSql,'FDO', 'DET');
    strSql := AnsiReplaceStr(strSql,'FGO', 'GER');
    strSql := AnsiReplaceStr(strSql,'FATGOR', 'MOVGER');
    strSql := AnsiReplaceStr(strSql,'FATDOR', 'MOVDET');
  End;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strNumDoc) Then
    Begin
      Open;

      If IsEmpty And (Pos('MOVGER', strSQL) > 0) Then
      Begin
        strSql := AnsiReplaceStr(strSql,'MOVGER', 'NOTGER');
        strSql := AnsiReplaceStr(strSql,'MOVDET', 'NOTDET');
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
      End;

      Result := Not fEmptyStr(FieldByName('CODS01').AsString);

      blnSomenteServ := True;

      First;
      While Not Eof Do
      Begin
        If Not fEhItemServico(FieldByName('CODITE').AsString, False, IIF(blnUsaCodEmp, strCodEmp, '')) Then
          blnSomenteServ := False;
        Next;
      End;

    End;

  End;

  FreeAndNil(qryGen);

End;

function fQtdServicos(strNumDoc, strEspDoc, strCodEmp: String): Integer;
  Var
    strSql : String;
    qryGen : TUniQuery;
Begin
  qryGen := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   IFNULL(CHARACTER_LENGTH(CONCAT(IFNULL(FGO_CODS01,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS02,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS03,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS04,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS05,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS06,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS07,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS08,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS09,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS10,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS11,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS12,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS13,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS14,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS15,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS16,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS17,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS18,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS19,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS20,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS21,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS22,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS23,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS24,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS25,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS26,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS27,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS28,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS29,""), ';
  strSQL := strSQL + '                                  IFNULL(FGO_CODS30,""))),0) / 5 AS QTDSER     ';
  strSQL := strSQL + ' FROM FATGOR INNER JOIN SERGOR ON FATGOR.AUTOINCREM = SERGOR.FGO_SEQFGO ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FGO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   FGO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   FGO_CODEMP = :CODEMP ';

  If Pos(strEspDoc, 'PD_OR') <= 0 Then
  Begin
    strSql := strSql + ' AND GER_TIP_FC = "C"  ';

    strSql := AnsiReplaceStr(strSql,'FGO', 'GER');
    strSql := AnsiReplaceStr(strSql,'SERGOR', 'SERMOV');
    strSql := AnsiReplaceStr(strSql,'FATGOR', 'MOVGER');
  End;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If Not IsEmpty Then
      Result := FieldByName('QTDSER').AsInteger
    Else
      Result := 0;
  End;

  FreeAndNil(qryGen);
End;


{*****************************************}
{* VALIDA CODFOR + CODFAB E RETORNA O    *}
{* ITEM CASO ENCONTRE                    *}
{**************************************AF*}
function fValidaCodForFab(strCodFor, strCodFab, strCodIte: String; Var strItem: String): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
begin

  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  ITE_DESITE AS DESITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  ITE_CODFAB = :CODFAB AND ';
    strSQL := strSQL + '  ITE_CODITE <> ' + QuotedStr(strCodIte);

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + 'SELECT                          ';
    strSQL := strSQL + 'A.ITE_CODITE AS CODITE,         ';
    strSQL := strSQL + 'ITE_DESITE AS DESITE            ';
    strSQL := strSQL + 'FROM ITEFOR A                   ';
    strSQL := strSQL + '  INNER JOIN CADITE B ON        ';
    strSQL := strSQL + '  B.ITE_CODITE = A.ITE_CODITE   ';
    strSQL := strSQL + 'WHERE A.ITE_CODFOR = :CODFOR    ';

    If fCfgSis('TABPRF', varBoolean) Then
      strSQL := strSQL + '  AND A.ITE_CODFAB = :CODFAB    '
    Else
      strSQL := strSQL + '  AND A.ITE_CODITF = :CODFAB    ';

    strSQL := strSQL + '  AND A.ITE_CODITE <> ' + QuotedStr(strCodIte);

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODFAB').AsString := strCodFab;
      Open;

      If IsEmpty Then
        Result := True
      Else
      Begin
        Result := False;
        strItem := FieldByName('CODITE').AsString + ' - ' + FieldByName('DESITE').AsString;
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

function fEmpresaTemAcessoCondicaoPagto(strCodigo: String): Boolean;
  Var
    strSql: String;
    qryTmp: TUniQuery;
begin

  If Not (fCfgSis('USACND', varBoolean)) Then
    Exit(True);

  qryTmp := fCriaQuery(Nil);

  Try

    strSql := '';
    strSql := strSql + ' SELECT ';
    strSql := strSql + '   COUNT(*) AS QTD ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADCND ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   CND_CODIGO = :CODIGO AND ';
    strSql := strSql + '   LOCATE(' + QuotedStr(VS_strCodEmp) + ', CND_EMPACE) > 0 ';

    With qryTmp Do
    Begin
      SQL.Add(strSql);
      ParamByName('CODIGO').AsString := strCodigo;
      Open;

      Result := Fields[0].AsInteger > 0;

      Close;
    End;

  Finally
    FreeAndNil(qryTmp);
  End;

end;

{*****************************************************}
{* PERCORRE UM DATASET E VERIFICA SE AS EMPRESAS     *}
{* ESTÃO MARCADAS NO CADASTRO DO PORTADOR INFORMADO. *}
{* RETORNA AS QUE ESTÃO DESMARCADAS.                 *}
{* obs.: IGNORA CASO NENHUMA EMPRESA ESTEJA MARCADA.  *}
{*REQ*145940***************************************RP*}
function fEmpresasTemAcessoPortador(strCodPor: String;
                                    objDataSet: TDataSet;
                                    strCodEmpFieldName: String;
                                    out strEmpSemAcesso: String;
                                    strFilter: String = ''): Boolean;
var
  strOldFilter: String;
  bolFiltered: Boolean;
  intPosicao: Integer;
  strListCodEmp: TStringList;
begin
  objDataSet.DisableControls;
  strOldFilter := objDataSet.Filter;
  bolFiltered  := objDataSet.Filtered;
  intPosicao   := objDataSet.RecNo;
  Try
    If Not fEmptyStr(strFilter) And Not SameText(Trim(strFilter), Trim(strOldFilter)) Then
    Begin
      objDataSet.Filtered := False;
      objDataSet.Filter   := IfThen(bolFiltered And Not fEmptyStr(strOldFilter), strOldFilter + ' AND ') + strFilter;
    End;

    objDataSet.Filtered := Not fEmptyStr(objDataSet.Filter);

    //passa o código das empresas para um stringlist, caso haja duplicações
    strListCodEmp := fDatasetDistinctField(objDataSet, strCodEmpFieldName);

    Result := fEmpresasTemAcessoPortador(strCodPor, strListCodEmp, strEmpSemAcesso);

    strListCodEmp.Free;
  Finally
    objDataSet.Filter   := strOldFilter;
    objDataSet.Filtered := bolFiltered;
    objDataSet.RecNo    := intPosicao;
    objDataSet.EnableControls;
  End;
end;

{******************************************************}
{* PERCORRE UMA LISTA CONTENDO CÓDIGO DE EMPRESAS E   *}
{* VERIFICA SE ESTÃO MARCADAS NO CADASTRO DO PORTADOR *}
{* INFORMADO. RETORNA AS QUE ESTÃO DESMARCADAS.       *}
{* obs.: IGNORA CASO NENHUMA EMPRESA ESTEJA MARCADA.  *}
{*REQ*145940****************************************RP*}
function fEmpresasTemAcessoPortador(strCodPor: String;
                                    strCodEmps: TStrings;
                                    out strEmpSemAcesso: String): Boolean;
  Var
    strSql, strCodEmp: String;
    qryTmp: TUniQuery;
begin
  strEmpSemAcesso := '';
  qryTmp := fCriaQuery(Nil);
  Try
    strSql := '';
    strSql := strSql + ' SELECT POR_EMPACE ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADPOR ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   POR_CODPOR = :CODIGO ';

    With qryTmp Do
    Begin
      SQL.Add(strSql);
      ParamByName('CODIGO').AsString := strCodPor;
      Open;

      If Not fEmptyStr(FieldByName('POR_EMPACE').AsString) Then
      Begin
        For strCodEmp In strCodEmps Do
        Begin
          If Pos(strCodEmp, FieldByName('POR_EMPACE').AsString) = 0 Then
            strEmpSemAcesso := strEmpSemAcesso + strCodEmp + ',';
        End;
      End;

      Result := fEmptyStr(strEmpSemAcesso);

      If Not Result Then
        strEmpSemAcesso := LeftStr(strEmpSemAcesso, Length(strEmpSemAcesso) -1);

      Close;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

function fEmpresasTemAcessoPortador(ACodPor: String;
                                    AArrEmpresas: TConsultasArray;
                                    out AEmpSemAcesso: String): Boolean;
  Var
    strSql: String;
    qryTmp: TUniQuery;
    recItem : TConsultas;
begin

  AEmpSemAcesso := '';
  qryTmp := fCriaQuery(Nil);

  Try
    strSql := '';
    strSql := strSql + ' SELECT POR_EMPACE ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADPOR ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   POR_CODPOR = :CODIGO ';


    qryTmp.SQL.Add(strSql);
    qryTmp.ParamByName('CODIGO').AsString := ACodPor;
    qryTmp.Open;

    If Not fEmptyStr(qryTmp.FieldByName('POR_EMPACE').AsString) Then
    Begin
      For recItem In AArrEmpresas Do
      Begin
        If Pos(recItem.strCodigo, qryTmp.FieldByName('POR_EMPACE').AsString) = 0 Then
          AEmpSemAcesso := AEmpSemAcesso + recItem.strCodigo + ',';
      End;
    End;

    Result := fEmptyStr(AEmpSemAcesso);

    If Not Result Then
      AEmpSemAcesso := LeftStr(AEmpSemAcesso, Length(AEmpSemAcesso) -1);

    qryTmp.Close;

  Finally
    FreeAndNil(qryTmp);
  End;
end;

function fUsuarioTemAcessoEmpresa(ACodOpe: String;
                                  AArrEmpresas: TConsultasArray;
                                  out AEmpSemAcesso: String): Boolean;
  Var
    strSql: String;
    qryTmp: TUniQuery;
    recItem : TConsultas;
begin

  AEmpSemAcesso := '';
  qryTmp := fCriaQuery(Nil);

  Try
    strSql := '';
    strSql := strSql + ' SELECT OPE_EMPACE ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADOPE ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   OPE_CODOPE = :CODIGO ';


    qryTmp.SQL.Add(strSql);
    qryTmp.ParamByName('CODIGO').AsString := ACodOpe;
    qryTmp.Open;

    If Not fEmptyStr(qryTmp.FieldByName('OPE_EMPACE').AsString) Then
    Begin
      For recItem In AArrEmpresas Do
      Begin
        If Pos(recItem.strCodigo, qryTmp.FieldByName('OPE_EMPACE').AsString) = 0 Then
          AEmpSemAcesso := AEmpSemAcesso + recItem.strCodigo + ',';
      End;
    End;

    Result := fEmptyStr(AEmpSemAcesso);

    If Not Result Then
      AEmpSemAcesso := LeftStr(AEmpSemAcesso, Length(AEmpSemAcesso) -1);

    qryTmp.Close;

  Finally
    FreeAndNil(qryTmp);
  End;
end;

{*******************************}
{* PEGA UM FLOAT E RETORNA ELE *}
{* ARREDONDADO PARA CIMA       *}
{****************************AF*}
function fArredCima(fltValor: Double): Double;
  Var
    fltInteiro: Double;
Begin

  fltInteiro := Int(fltValor);

  If (fltValor - fltInteiro) > 0 Then
    Result := fltInteiro + 1
  Else
    Result := fltInteiro;

End;

function fRetornaValRet(strEstFor: String; fltBasRet, fltValIcm, fltAlqSub: Double): Double;
begin

  If (fltBasRet <= 0) Then
  Begin
    Result := 0.0;
    Exit;
  End;

  Result := fltBasRet * fltAlqSub / 100;
  Result := fFormataFloat(Result - fltValIcm, 2);

  if Result < 0 then
    Result := 0;

end;

function fRetornaValFCPRet(fltBase, fltAliquota: Double): Double;
begin
  Result := fltBase * fltAliquota / 100;
end;

function fPedidoPossuiDuplicatasBaixadas(strNumPed: String): Boolean;
begin
  Result := fCampoTabela('COUNT(*)',
                         'CADREC',
                         ['CTR_NUMDUP','CTR_ESPDOC','CTR_CODEMP','IF(CTR_DTAREC IS NULL, "ABERTO", "RECEBIDO")'],
                         [strNumPed, 'PD', VS_strCodEmp, 'RECEBIDO']) > 0;
end;

function fRetMD5Laudo: String;
begin
  Result := fCfgSis('PAFMD5');

  If fEmptyStr(Result) Then
  Begin
    Result := fArqIni(0, 'GERAL', 'MD5_LAUDO', 'LAUDO');
    fAtuCfgSis('PAFMD5', Result);
  End;
end;

function fNumeroLaudo: String;
begin
  Result := fCfgSis('PAFLAU');

  If fEmptyStr(Result) Then
  Begin
    Result := fArqIni(0, 'GERAL', 'NUMERO_LAUDO', 'XXXnnnAAAA');
    fAtuCfgSis('PAFLAU', Result);
  End;
end;

function fRetVersaoPAFER: String;
begin
  Result := fCfgSis('PAF_ER');

  If fEmptyStr(Result) Then
  Begin
    Result := '01.13';
  End;
end;

function fRetornaI_PP_T(strCodIte: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT * FROM GERMAT WHERE GMT_CODITE = :CODITE');
  qryAux.ParamByName('CODITE').AsString := fRetCodItem(strCodIte);
  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    Result := 'T'
  End
  Else
  Begin
    Result := 'P';
  End;

  FreeAndNil(qryAux);
end;

function fRetCodItem(strCodBar: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  ITE_CODITE ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADITE ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  ITE_CODBAR = :CODBAR ');

  qryAux.ParamByName('CODBAR').AsString := strCodBar;
  qryAux.Open;

  Result := qryAux.FieldByName('ITE_CODITE').AsString;

  FreeAndNil(qryAux);
end;

function fRetNomeArquivoPAF(strNomeArq: String; strExt: String = '.txt'): String;
  Var
    strDirSai: String;
begin
  strDirSai := ExtractFileDir(Application.ExeName) + '\PAF\';

  If (Not SysUtils.DirectoryExists(strDirSai)) Then
    CreateDir(strDirSai);

  Result    := strDirSai + strNomeArq + '_' + FormatDateTime('yyyy-mm-dd_hhnnss', fNow()) + strExt;
end;

{*************************************************************}
{* FORMATA O NUMERICO, TROCANDO VIRGULA POR PONTO            *}
{*********************************************OUT/2009***[AM]*}
function fFloatToStrPonto(valor: double; inte,deci: integer): string;
begin
  Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inte,deci),',','.');
end;

{*************************************************************}
{* FORMATA O NUMERICO, TROCANDO PONTO POR VIRGULA            *}
{*********************************************OUT/2009***[AM]*}
function fFloatToStrVirgula(valor: double; inte,deci: integer): string;
begin
  Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inte,deci),'.',',');
end;

{*******************************************}
{ RETORNA A QUANTIDADE DE LINHAS DO ARQUIVO }
{****************************************RP*}
function fContaLinhasArq(strNomArq: String): Integer;
begin
  with TStringList.Create do
  begin
    LoadFromFile(strNomArq);
    Result := Count;
    Free;
  end;
end;

function fRetEmpCarregamentoItem(strCodIte: String): String;
begin
  Result := fCampoTabela('ITE_EMPCAR', 'CADITE', ['ITE_CODITE'], [strCodIte]);
end;

function fArquivoRetornoTxtBemaFI32: String;
  Var
    iniBemaFI32: TIniFile;
    strBemaFI32: String;
begin
  strBemaFI32 := '';

  If FileExists('C:\WINDOWS\system32\BemaFI32.ini') Then
    strBemaFI32 := 'C:\WINDOWS\system32\BemaFI32.ini'

  Else If FileExists(fCfgSis('DIRINI') + '\BemaFI32.ini') Then
    strBemaFI32 := fCfgSis('DIRINI') + '\BemaFI32.ini'

  Else If FileExists(ExtractFilePath(Application.ExeName) + 'BemaFI32.ini') Then
    strBemaFI32 := ExtractFilePath(Application.ExeName) + 'BemaFI32.ini';

  If Not fEmptyStr(strBemaFI32) Then
  Begin
    Try
      iniBemaFI32 := TIniFile.Create(strBemaFI32);
      Result := iniBemaFI32.ReadString('Sistema', 'Path', 'C:\') + '\RETORNO.TXT';
    Finally
      FreeAndNil(iniBemaFI32);
    End;
  End
  Else
    Result := 'C:\RETORNO.TXT';

end;


function fCriaCdsCheques(AOwner: TComponent): TUniClientDataSet;
  Var
    qryCadChq: TUniQuery;
    intCont  : Integer;
begin
  qryCadChq := fCriarQuery('SELECT * FROM CADCHQ WHERE FALSE', AOwner);

  Result := TUniClientDataSet.Create(AOwner);
  Result.AggregatesActive := True;

  For intCont := 0 To qryCadChq.Fields.Count -1 Do
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := qryCadChq.Fields[intCont].FieldName;
      DataType := qryCadChq.Fields[intCont].DataType;
      Size     := qryCadChq.Fields[intCont].Size;
      Required := False;
    End;

  With TAggregateField.Create(Result) Do
  Begin
    FieldName     := 'TOT_VALCHQ';
    DataSet       := Result;
    DisplayFormat := '#,##0.00';
    Alignment     := Classes.taRightJustify;
    Expression    := 'SUM(CHQ_VALCHQ)';
    Active := True;
  End;

  Result.CreateDataSet;
  Result.Open;

  FreeAndNil(qryCadChq);
end;

procedure pLocksTravados(blnPerRem, blnMostraVazio: Boolean);
  Var
    frmRelacaoLocks : TfrmRelacaoLocks;
Begin

  Try
    pCriarFormularios(TfrmRelacaoLocks,frmRelacaoLocks);
    try
      frmRelacaoLocks.blnPerRem := blnPerRem;

      If frmRelacaoLocks.fCarregaLocks Or blnMostraVazio Then
        frmRelacaoLocks.ShowModal;
    finally
      pFreeAndNil(frmRelacaoLocks);
    end;
  Except
    pMensagensErro('','');
  End;
End;

procedure pDefineLayoutImpressao(strEspecie: String; Var strColRel, str40ColS: String;
  strEntFut: String);

  function fLayoutEntregaFutura: Boolean;
    Var
      strLayFut: String;
  begin
    Result := False;

    If (strEntFut <> 'S') Then
      Exit;
      
    strLayFut := fArqIni(0, 'ENTFUT', strEspecie, '');
    If (Not fEmptyStr(strLayFut)) Then
    Begin
      Result := True;
      strColRel := AnsiUpperCase(strLayFut);

      If strColRel = '40S' Then
      Begin
        strColRel := '40';
        str40ColS := 'S';
      End;
    End;
  end;
begin
  strColRel := '';
  str40ColS := '';

  If fEmptyStr(strEntFut) Then
    strEntFut := 'N';

  If Not fLayoutEntregaFutura Then
  Begin
    If (Pos(strEspecie, VS_strEsp80c) > 0) Then
      strColRel := '80'
    Else If (Pos(strEspecie, fCfgSis('ESP40C')) > 0) Then
      strColRel := '40'
    Else If (Pos(strEspecie, fCfgSis('ESP30C')) > 0) Then
      strColRel := '30'
    {*******************************************}
    {* IMPRESSAO 40 COLUNAS FAST REPORT        *}
    {****************************************AC*}
    Else If (Pos(strEspecie, VS_strEsp40s) > 0) Then
      Begin
        strColRel := '40';
        str40ColS := 'S';
      End
    Else If (fCfgSis('MODIMP') = '1') Then
      strColRel := '40'
    Else If (fCfgSis('MODIMP') = '2') Then
      strColRel := '80'
    Else If (fCfgSis('MODIMP') = '3') Then
      strColRel := '30'
    {*******************************************}
    {* IMPRESSAO 40 COLUNAS FAST REPORT        *}
    {****************************************AC*}
    Else If (fCfgSis('MODIMP') = '4') Then
      Begin
        strColRel := '40';
        str40ColS := 'S';
      End
    Else
      strColRel := '80';
  End;
end;

function fDigitaValor(var fltValor: Double;
                      strTitulo: String;
                      strFormato: String = '#,##0.00';
                      blnPermiteZero: Boolean = False;
                      blnPermiteMenorZero: Boolean = False): Boolean;
begin
  Try
    pCriarFormularios(TfrmDigValor, frmDigValor);
    frmDigValor.blnPermiteZero      := blnPermiteZero;
    frmDigValor.blnPermiteMenorZero := blnPermiteMenorZero;
    frmDigValor.edtValor.Text       := FormatFloat(strFormato, fltValor);
    frmDigValor.edtValor.EditFormat := strFormato;
    frmDigValor.Caption             := strTitulo;
    frmDigValor.ShowModal;

    Result   := (frmDigValor.ModalResult = mrOk);
    fltValor := fStrToFloat(frmDigValor.edtValor.Text);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[]');
    End;
  End;

  pFreeAndNil(frmDigValor);
end;

function fDigitaValor(var fltValor: Double;
                      var blnReplicaTabela: Boolean;
                      var blnReplicaValorItens: Boolean;
                      strTitulo: String;
                      strFormato: String = '#,##0.00';
                      blnPermiteZero: Boolean = False;
                      blnPermiteMenorZero: Boolean = False;
                      blnRediMensionaTela: Boolean = False;
                      blnRepeticaoPrecoMargem: Boolean = False;
                      AblnValidaEscala: Boolean = False;
                      AfltEscalaMinimo: Double = -1;
                      AfltEscalaMaximo: Double = -1): Boolean;
begin
  Result := True;

  If Not(blnRepeticaoPrecoMargem) Then
  Begin

    Try
      pCriarFormularios(TfrmDigValor, frmDigValor);
      frmDigValor.blnPermiteZero      := blnPermiteZero;
      frmDigValor.blnPermiteMenorZero := blnPermiteMenorZero;
      frmDigValor.edtValor.Text       := FormatFloat(strFormato, fltValor);
      frmDigValor.edtValor.EditFormat := strFormato;
      frmDigValor.Caption             := strTitulo;
      frmDigValor.blnValidaEscala     := AblnValidaEscala;
      frmDigValor.fltEscalaMinimo     := AfltEscalaMinimo;
      frmDigValor.fltEscalaMaximo     := AfltEscalaMaximo;

      If blnRediMensionaTela Then
      Begin
        frmDigValor.chkReplica.Top:= 26;
        frmDigValor.chkReplicaItens.Top:= 45;
        frmDigValor.edtEmbalagem.Visible:= False;
        frmDigValor.lblEmbalagem.Visible:= False;
        frmDigValor.Height:= 137;
        frmDigValor.Width:= 294;

        frmDigValor.chkReplicaItens.Visible:= True;
        frmDigValor.chkReplica.Visible:= True;
        frmDigValor.blnRedimessionaTelaExterna:= True;
      End;

      frmDigValor.ShowModal;

      Result         := (frmDigValor.ModalResult = mrOk);
      fltValor       := fStrToFloat(frmDigValor.edtValor.Text);
      blnReplicaTabela:= frmDigValor.chkReplica.Checked;
      blnReplicaValorItens:= frmDigValor.chkReplicaItens.Checked;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[]');
      End;
    End;

    pFreeAndNil(frmDigValor);
  End;
end;


function fDigitaValor(var fltValor: Double;
                      var fltValorEmb: Double;
                      fltFator: Double;
                      strTitulo: String;
                      strFormato: String = '#,##0.00';
                      blnPermiteZero: Boolean = False;
                      blnPermiteMenorZero: Boolean = False): Boolean;
begin
  Try
    pCriarFormularios(TfrmDigValor, frmDigValor);
    frmDigValor.blnEfetivacaoLote   := fCfgSis('ATIEMB', varBoolean);
    frmDigValor.blnPermiteZero      := blnPermiteZero;
    frmDigValor.blnPermiteMenorZero := blnPermiteMenorZero;
    frmDigValor.edtValor.Text       := FormatFloat(strFormato, fltValor);
    frmDigValor.edtValor.EditFormat := strFormato;
    frmDigValor.edtEmbalagem.Text   := FormatFloat(strFormato, fltValorEmb);
    frmDigValor.edtEmbalagem.EditFormat := strFormato;

    frmDigValor.Caption    := strTitulo;
    frmDigValor.fltQtdEmb  := fltFator;
    frmDigValor.Showmodal;

    Result   := (frmDigValor.ModalResult = mrOk);
    fltValor := fStrToFloat(frmDigValor.edtValor.Text);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[]');
    End;
  End;

  pFreeAndNil(frmDigValor);
end;

function fDigitaValor(var fltValor: Double;
                      var fltValorEmb: Double;
                      var blnReplicaTabela: Boolean;
                      var blnReplicaValorItens: Boolean;
                      fltFator: Double;
                      strTitulo: String;
                      strFormato: String = '#,##0.00';
                      blnPermiteZero: Boolean = False;
                      blnPermiteMenorZero: Boolean = False;
                      blnRediMensionaTela: Boolean = False;
                      blnRepeticaoPrecoMargem: Boolean = False;
                      AblnValidaEscala: Boolean = False;
                      AfltEscalaMinimo: Double = -1;
                      AfltEscalaMaximo: Double = -1): Boolean;
begin
  Result := True;

  If Not(blnRepeticaoPrecoMargem) Then
  Begin

    Try
      pCriarFormularios(TfrmDigValor, frmDigValor);
      frmDigValor.blnEfetivacaoLote   := fCfgSis('ATIEMB', varBoolean);
      frmDigValor.blnPermiteZero      := blnPermiteZero;
      frmDigValor.blnPermiteMenorZero := blnPermiteMenorZero;
      frmDigValor.edtValor.Text       := FormatFloat(strFormato, fltValor);
      frmDigValor.edtValor.EditFormat := strFormato;
      frmDigValor.edtEmbalagem.Text   := FormatFloat(strFormato, fltValorEmb);
      frmDigValor.edtEmbalagem.EditFormat := strFormato;
      frmDigValor.blnValidaEscala     := AblnValidaEscala;
      frmDigValor.fltEscalaMinimo     := AfltEscalaMinimo;
      frmDigValor.fltEscalaMaximo     := AfltEscalaMaximo;

      frmDigValor.Caption    := strTitulo;
      frmDigValor.fltQtdEmb  := fltFator;

      If blnRediMensionaTela Then
      Begin
        frmDigValor.chkReplica.Top:= IIF(frmDigValor.blnEfetivacaoLote,58, 26);
        frmDigValor.chkReplicaItens.Top:=  IIF(frmDigValor.blnEfetivacaoLote,77,45);
        frmDigValor.edtEmbalagem.Visible:= False;
        frmDigValor.lblEmbalagem.Visible:= False;
        frmDigValor.Height:= IIF(frmDigValor.blnEfetivacaoLote,176,138);
        frmDigValor.Width:= 294;
        frmDigValor.chkReplica.Visible:= True;
        frmDigValor.blnRedimessionaTelaExterna:= True;
        frmDigValor.chkReplicaItens.Visible:= True;
      End;


      frmDigValor.Showmodal;

      Result   := (frmDigValor.ModalResult = mrOk);
      fltValor := fStrToFloat(frmDigValor.edtValor.Text);
      blnReplicaTabela:= frmDigValor.chkReplica.Checked;
      blnReplicaValorItens:= frmDigValor.chkReplicaItens.Checked;


    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[]');
      End;
    End;

    pFreeAndNil(frmDigValor);
  End;
end;



function fGetValorXml(nodNo: IXMLNode; strNome: String; varTipVar: TVarType = varString;
  strDateFormat: String = 'YYYY-MM-DD'; chrDateSeparator: Char = '-'; blnDateTime: Boolean = False): Variant;
  Var
    nodRec: IXMLNode;
    forSet: TFormatSettings;
    strData: String;
Begin
  With nodNo Do
  Begin
    forSet.ShortDateFormat := strDateFormat;
    forSet.DateSeparator   := chrDateSeparator;

    nodRec := ChildNodes.FindNode(strNome);

    If Assigned(nodRec) Then
    Begin

      Try
        Case varTipVar Of

          varDate  :  Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0

                        Else If blnDateTime Then
                        Begin
                          strData := LeftStr(nodRec.NodeValue, 10);
                          Result  := StrToDate(strData, forSet);
                        End Else
                        Begin
                          Try
                            Result  := StrToDate(nodRec.NodeValue, forSet);
                          Except
                            Result  := 0;
                          End;
                        End;

                      End;

          varString:  Begin
                        If nodRec.NodeValue = Null Then
                          Result := ''
                        Else
                          Result := nodRec.NodeValue;
                      End;

          varDouble:  Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0
                        Else
                          Result := fStrToFloat(AnsiReplaceStr(nodRec.NodeValue,'.',','));
                      End;

          varInteger: Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0
                        Else
                          Result := nodRec.NodeValue;
                      End;

        End;
      Except
        Raise Exception.Create('Erro ao ler valor ' + strNome);
      End;

    End Else
    Begin
      Case varTipVar Of
        varDate:     Result := 0;
        varString:   Result := '';
        varDouble:   Result := 0;
        varInteger:  Result := 0;
      End;
    End;

  End;
End;

function fGetXmlChildValoresEmTStrings(nodNo: IXMLNode): TStrings;
var
  stlResult: TStringList;
  intIdx: Integer;
begin
  stlResult := TStringList.Create;

  For intIdx := 0 to nodNo.ChildNodes.Count - 1 Do
    stlResult.Add(nodNo.ChildNodes.Get(intIdx).NodeValue);

  Result := stlResult;
end;

function fDocumentoPossuiItemConcreto(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := False;

  If Not fCfgSis('USACCR', varBoolean) Then
    Exit;

  qryGen := fCriaQuery();

  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('  COUNT(*)');
  qryGen.SQL.Add('FROM');
  qryGen.SQL.Add('  FATDOR');
  qryGen.SQL.Add('  INNER JOIN GERMAT ON GMT_CODITE = FDO_CODITE');

  {**********************************************************************************}
  {* SE CONFIGURADO PARA DEFINIR SE O PRODUTO É CONCRETO, ENTAO VERIFICA O CADASTRO *}
  {**********************************************************************************}
  If fCfgSis('ITECCR', varBoolean) Then
    qryGen.SQL.Add('  INNER JOIN CADITE ON GMT_CODITE = ITE_CODITE AND ITE_ITECCR = "S" ');

  qryGen.SQL.Add('WHERE');
  qryGen.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryGen.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryGen.SQL.Add('  FDO_CODEMP = :CODEMP     ');

  If Pos(strEspDoc, 'PD_OR') <= 0 Then
  Begin
    qryGen.SQL.Add(' AND DET_TIP_FC = "C"  ');

    qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text,'FDO', 'DET');
    qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text,'FATDOR', 'MOVDET');
  End;

  qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
  qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
  qryGen.ParamByName('CODEMP').AsString := strCodEmp;

  qryGen.Open;

  Result := (qryGen.Fields[0].AsInteger > 0);
  FreeAndNil(qryGen);
end;

function fQuantidadeItensPedido(strNumDoc, strEspDoc, strCodEmp: String): Integer;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);

  qryGen.SQL.Add('SELECT  ');
  qryGen.SQL.Add('  COUNT(*) ');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('  FATDOR ');
  qryGen.SQL.Add('WHERE ');
  qryGen.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryGen.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryGen.SQL.Add('  FDO_CODEMP = :CODEMP AND ');
  qryGen.SQL.Add('  FDO_CODITE = :ITEBOM AND ');//Ignorar item bombeamento
  qryGen.SQL.Add('  FDO_CODITE = :ITETAX     ');//Igonorar item taxa minima

  qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
  qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
  qryGen.ParamByName('CODEMP').AsString := strCodEmp;
  qryGen.ParamByName('ITEBOM').AsString := fCfgSis('ITEBOM');
  qryGen.ParamByName('ITETAX').AsString := fCfgSis('ITETAX');

  qryGen.Open;

  Result := qryGen.Fields[0].AsInteger;

  FreeAndNil(qryGen);
end;

procedure pRetPrecoItem(strCodIte, strCodEmp: String;Var fltCnv_Ml, fltPreVe1, fltPreCus: Double);
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery(nil);
  With qryIteger, sql  Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  ITE_CNV_ML, ');
    Add('  ITE_PRECUS, ');
    Add('  ITE_PREVE1 ');
    Add('FROM          ');
    Add('  ITEGER G    ');
    Add('  INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
    Add('WHERE');
    Add('  G.ITE_CODITE = :CODITE AND');
    Add('  G.ITE_CODEMP = :CODEMP    ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    If IsEmpty Then
    Begin
      fltCnv_Ml := 0;
      fltPreCus := 0;
      fltPreVe1 := 0;
    End Else
    Begin
      fltCnv_Ml := FieldByName('ITE_CNV_ML').AsFloat;
      fltPreVe1 := FieldByName('ITE_PREVE1').AsFloat;
      fltPreCus := FieldByName('ITE_PRECUS').AsFloat;      
    End;

    If fltCnv_Ml = 0 Then
      fltCnv_Ml := 1;

    Close;
  End;

  FreeAndNil(qryIteger);
End;

function fGravaVendaMadeira(strAutInc, strTabela: String; recMadeira: TDadosMadeira): Boolean;
  var
    qryGen: TUniQuery;

  function fCampo(strCampo: String): TField;
  begin
    If strTabela = 'ORCMAD' Then
      Result := qryGen.FieldByName('FDO_' + strCampo)
    Else
      Result := qryGen.FieldByName('DET_' + strCampo);
  end;

begin
  Result := True;

  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ' + strTabela + ' WHERE FALSE');
      Open;

      qryGen.Append;

      fCampo('SEQGER').AsString := strAutInc;
      fCampo('APAREL').AsString := recMadeira.strAparel;
      fCampo('PERAPA').AsFloat  := recMadeira.fltPerApa;
      fCampo('BENEFI').AsString := recMadeira.strBenefi;
      fCampo('PERBEN').AsFloat  := recMadeira.fltPerBen;
      fCampo('QTDPEC').AsFloat  := recMadeira.fltQtdPec;
      fCampo('COMPEC').AsFloat  := recMadeira.fltComPec;
      fCampo('LARPEC').AsFloat  := recMadeira.fltLarPec;
      fCampo('ESPPEC').AsFloat  := recMadeira.fltEspPec;

      Post;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryGen);
end;

function fRetornaAliquotaIcmsInternaDoEstado(strEstado: String): Double;
begin
  If strEstado = 'RJ' Then
    Result := 19
  Else If Pos(strEstado, 'MG_PR_SP_') > 0 Then
    Result := 18
  Else
    Result := 17;
end;

function fRetornaAtividadeCliente(strCodCli: String): String;
begin
  Result := fCampoTabela('CLI_CODATI', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
end;

function fRetornaPerComProfissional(strCodDiv: String): Double;
begin
  Result := fCampoTabela('DIV_PERCOM', 'CADDIV', ['DIV_CODDIV'], [strCodDiv]);
end;


function fRetornaDesAceCnd(strCodCnd: String): Double;
begin
  Result := fCampoTabela('CND_PEDEAC', 'CADCND', ['CND_CODIGO'], [strCodCnd]);
end;

function fRetornaDesAceUnicoPorVenda(strCodCnd: String):Double;
begin
  Result := fCampoTabela('CND_VRDAUV', 'CADCND', ['CND_CODIGO'], [strCodCnd]);
end;

function fCobrarDespAcessCondPagto(strCodCnd, strCodCli, strTipFat: String): Boolean;
begin
  Result := True;

  If fCfgSis('TPDCEX') = '1' Then
    Result := Not fEmptyStr(strTipFat) And
      (Pos(strTipFat, fCampoTabela('CND_TPFTDA', 'CADCND', ['CND_CODIGO'], [strCodCnd])) > 0);

  //Deve cobrar apenas uma vez por dezena
  If Result And (fCampoTabela('CND_MCOBDA', 'CADCND', ['CND_CODIGO'], [strCodCnd]) = '2') Then
    Result := Not fJaCobrouDespesasAcessoriasNaDezena(strCodCli);
end;

function fJaCobrouDespesasAcessoriasNaDezena(strCodCli: String): Boolean;
  Var
    intDia: Integer;
    dtaDataInicial: TDateTime;
begin
  If DayOf(VS_Date) <= 10 Then
    intDia := 01  //Inicio primeira dezena
  Else If DayOf(VS_Date) <= 20 Then
    intDia := 11  //Inicio segunda dezena
  Else
    intDia := 21; //Inicio terceira dezena

  dtaDataInicial := EncodeDate(YearOf(VS_Date), MonthOf(VS_Date), intDia);

  Result := fTemVendaComDespesasAcessorias(strCodCli, dtaDataInicial);
end;

function fTemVendaComDespesasAcessorias(strCodCli: String; dtaDataInicial: TDateTime): Boolean;
  Var
    qryGen: TUniQuery;

  procedure pSetarParametros;
  begin
    qryGen.ParamByName('DTAINI').AsDateTime := dtaDataInicial;
    qryGen.ParamByName('DTAFIN').AsDateTime := VS_date;
    qryGen.ParamByName('CODCLI').AsString   := strCodCli;
    qryGen.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryGen.ParamByName('CLAVEN').AsString   := VS_strClaVen;
    qryGen.ParamByName('CLADEV').AsString   := VS_strClaDev;
  end;

begin
  qryGen := fCriaQuery;

  qryGen.SQL.Add('SELECT  ');
  qryGen.SQL.Add('  SUM(GER_DESACE) AS DESACE ');
  qryGen.SQL.Add('FROM  ');
  qryGen.SQL.Add('  MOVGER ');
  qryGen.SQL.Add('WHERE  ');
  qryGen.SQL.Add('  GER_DTAENT >= :DTAINI AND ');
  qryGen.SQL.Add('  GER_DTAENT <= :DTAFIN AND ');
  qryGen.SQL.Add('  GER_CODCLI  = :CODCLI AND ');
  qryGen.SQL.Add('  GER_CODEMP  = :CODEMP AND ');
  qryGen.SQL.Add('  ((LOCATE(GER_CLAFIS, :CLAVEN) > 0) OR ');
  qryGen.SQL.Add('   (LOCATE(GER_CLAFIS, :CLADEV) > 0))   ');

  pSetarParametros;

  qryGen.Open;

  Result := qryGen.FieldByName('DESACE').AsFloat > 0;

  If Not Result Then
  Begin
    qryGen.Close;

    qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'MOVGER', 'NOTGER');

    pSetarParametros;

    qryGen.Open;

    Result := qryGen.FieldByName('DESACE').AsFloat > 0;
  End;

  qryGen.Close;

  FreeAndNil(qryGen);
end;

function fRetornaDesAcePrazoCnd(strCodCnd, strConPag : String):Double;
  Var
    fltPeDeAc : Double;
    intQtdPar : Integer;
Begin
  Result := 0;
  fltPeDeAc := fCampoTabela('CND_VRDEAC', 'CADCND', ['CND_CODIGO'], [strCodCnd]);
  If (fltPeDeAc > 0) Then
  Begin
    intQtdPar := StrToIntDef( LeftStr(strConPag, 2), 0 );
    If fStrToFloat( MidStr(strConPag, 3, 3 )) = 0 Then
      Dec(intQtdPar);

    Result := fltPeDeAc * intQtdPar;
  End;

End;

function fClienteRetemISS(strCodCli: String): Boolean;
begin
  Result := fCampoTabela('CLI_RETISS', 'CADCLI', ['CLI_CODCLI'], [strCodCli]) = 'S';
end;

function fRetCampoCndPagto(strCodCnd, strCampo: String): Boolean;
begin
  {**************************************************************************}
  {* SEGUINDO O MESMO PADRÃO DA FUNÇÃO ACIMA "fRetCampoCndPagto()"          *}
  {* MOTIVO: CLIENTES QUE NÃO USAM O CADASTRO DE CND, strCodCnd vai vir ""  *}
  {* FAZENDO A FUNÇÃO RETORNAR SEMPRE FALSE, NÃO IMPRIMINDO/PERGUNTANDO SE  *}
  {* IMPRIME BOLETO.                                                        *}
  {* OBS: ORIGINALMENTE A FUNÇÃO JA FAZIA ISSO, VIDE SHOWLOG.               *}
  {***********************************************************************RN*}
  {**************************************************************************}
  {* MANTIDO SOMENTE A VERFICAÇÃO DA CONDIÇÃO E CAMPO REFERÊNCIA POR        *}
  {* CONTA DAS INCONSISTÊNCIAS APURADAS PELOS SEGUINTES REQUISITOS:         *}
  {* REQ.: 31527 INCONSIST.: 5707 / REQ.: 32464 INCONSIST.: 5701            *}
  {***********************************************************************VA*}
  If fCampoTabela('COUNT(*)', 'CADCND', ['CND_CODIGO'], [strCodCnd], False) = 0 Then
    Result := True
  Else
  Begin
    Result := fCampoTabela(strCampo, 'CADCND', ['CND_CODIGO'], [strCodCnd], False) = 'S';

    If (Not Result) And (strCampo = 'CND_ALTPRE') Then
      Result := (fCampoTabela(strCampo, 'CADCND', ['CND_CODIGO'], [strCodCnd], False) = 'C');
  End;
end;

function fClienteImprimeBoletoPelaEmpresa(strCodCli: String): Boolean;
begin
  Result := fCampoTabela('CLI_BOLIMP', 'CADCLI', ['CLI_CODCLI'], [strCodCli]) = 'E';
end;

function fSelecionaDuplicatasCredito(   strCodCli: String;
                                        fltValorTotal: Double;
                                       Var stlDupCred,
                                           stlLckDup: TStringList;
                                       Var fltTotCred: Double;
                                           strDataCorte: String;
                                           fncTravaUtiCred: TfncTravaUtiCred = Nil;
                                           blnExibirTela: Boolean = True;
                                           fltValorNegociado: Double = 0;
                                           objLiberacao: ILiberacao = Nil;
                                           strOpcDocTrue: String='';
                                           blnTentaAcharTambemPelaDuplicataOriginal: Boolean = False;
                                           strCrtDevSintetizadasConfDocs: String = '';
                                           blnDescontaCreditoAutomatico: Boolean = False;
                                           blnUsaEmpOri : Boolean = False): Boolean;
  Var
    dtaDataCorte: TDateTime;
    fltValorDuplicatas: Double;
begin
  Result := False;
  dtaDataCorte := 0;
  If Not fEmptyStr(fTiraCaracEspeciais(strDataCorte)) Then
    dtaDataCorte := StrToDate(strDataCorte);

  If fltValorNegociado > 0 Then
    fltValorTotal := fltValorNegociado;

  Try
    pCriarFormularios(TfrmFatMostraCreditos, frmFatMostraCreditos);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fSelecionaDuplicatasCredito_1]');
      Exit;
    End;
  End;

  Try
    frmFatMostraCreditos.strCodCli := strCodCli;
    frmFatMostraCreditos.fltValorTotal := fltValorTotal;
    frmFatMostraCreditos.dtaDataCorte := dtaDataCorte;
    frmFatMostraCreditos.fncTravaUtiCred := fncTravaUtiCred;
    frmFatMostraCreditos.fltValorNegociado := fltValorNegociado;
    frmFatMostraCreditos.objLiberacao := objLiberacao;
    frmFatMostraCreditos.strOpcDocTrue := strOpcDocTrue;
    frmFatMostraCreditos.strCrtDevSintetizadasConfDocs := strCrtDevSintetizadasConfDocs;
    frmFatMostraCreditos.blnDescontaCreditoAutomatico := blnDescontaCreditoAutomatico;
    frmFatMostraCreditos.blnUsaEmpOri := blnUsaEmpOri;

    If fPos(frmFatMostraCreditos.strOpcDocTrue, '11_PD_OR_') Then
      frmFatMostraCreditos.blnOrcamentos := True;

    If Not blnExibirTela Then
    Begin
      frmFatMostraCreditos.pOnShow;

      If Not frmFatMostraCreditos.blnFecharForm Then
      Begin
        frmFatMostraCreditos.blnMostrouTela := False;

        If blnDescontaCreditoAutomatico Then
        Begin
          fltValorDuplicatas := 0;
          frmFatMostraCreditos.cdsConsulta.First;

          while not frmFatMostraCreditos.cdsConsulta.Eof do
          begin
            If fltValorDuplicatas < fltValorTotal Then
            Begin
              stlDupCred.Add(QuotedStr(RightStr(frmFatMostraCreditos.cdsConsulta.FieldByName('AUTOINCREM').AsString, 20)));
              fltValorDuplicatas := fltValorDuplicatas + Abs(frmFatMostraCreditos.cdsConsulta.FieldByName('CTR_VALDUP').AsFloat);
            End
            Else
              Break;

            frmFatMostraCreditos.cdsConsulta.Next;
          end;
        End;

        frmFatMostraCreditos.pSelecionarDuplicatas('CADREC', stlDupCred, blnTentaAcharTambemPelaDuplicataOriginal);

        frmFatMostraCreditos.btnConfirma.Click;

        Result := frmFatMostraCreditos.blnConfirma;
      End
      Else
        Result := False;
    End
    Else
    Begin
      frmFatMostraCreditos.ShowModal;
      Result := frmFatMostraCreditos.blnConfirma;
    End;

    If (Result) Then
    Begin
      stlDupCred.Clear;
      stlLckDup.Clear;

      stlDupCred.Assign(frmFatMostraCreditos.fGetCreditos);
      stlLckDup.Assign(frmFatMostraCreditos.fGetLckDup);
      fltTotCred := frmFatMostraCreditos.fGetTotalSel;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fSelecionaDuplicatasCredito_2]');
      Result := False;
    End;
  End;

  pFreeAndNil(frmFatMostraCreditos);

end;

function fPainelAtualizado: Boolean;
  Var
    qryInfSis: TUniQuery;
    strVersao: String;
    stlResultado: TStringList;

    intVersao: Integer;
begin
  If fEmptyStr(VS_strCodEmp) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Not fCfgSis('NFEUSA', varBoolean)) Or (Not fCfgSis('PNLNFE', varBoolean)) Then
  Begin
    Result := True;
    Exit;
  End;

  qryInfSis := fCriaQuery(Nil);
  qryInfSis.SQL.Add('SELECT * FROM INFSIS WHERE INF_NOMARQ = "PainelNFe.exe"');
  qryInfSis.Open;

  strVersao := qryInfSis.FieldByName('INF_VERARQ').AsString;

  FreeAndNil(qryInfSis);

  If fEmptyStr(strVersao) Then
    intVersao := 0
  Else
  Begin
    stlResultado := TStringList.Create;
    ExtractStrings(['.'], [' '], PChar(strVersao), stlResultado);
    intVersao := (StrToIntDef(stlResultado[0], 0)*1000) +
                 (StrToIntDef(stlResultado[1], 0)*100) +
                 (StrToIntDef(stlResultado[2], 0)*10);
    FreeAndNil(stlResultado);
  End;

  Result := (intVersao >= 1000);
end;

function fValidaAliqIPI(Var strDesIte : String; Lista: TStrings = nil): Boolean;
  Var
    qryConsulta : TUniQuery;
Begin
  Try
    qryConsulta := fCriaQuery(nil);
    With qryConsulta, Sql Do
    Begin
      Clear;
      Add(' SELECT SQL_NO_CACHE ');
      Add(' ENT_CODITE, ');
      Add(' ENT_DESITE  ');
      Add(' FROM TMP_ENTMER ');
      Add(' WHERE ');
      Add(' ENT_PERIPI > 999 ');

      Open;

      Result := IsEmpty;

      If Not Result Then
      Begin
        strDesIte := '';
        First;
        While Not Eof Do
        Begin
          If Assigned(Lista) Then
          Begin
            Lista.Add(FieldByName('ENT_CODITE').AsString + '-' + FieldByName('ENT_DESITE').AsString);
            Next;
          End
          Else
          Begin
            strDesIte := strDesIte + FieldByName('ENT_CODITE').AsString + '-' + FieldByName('ENT_DESITE').AsString;

            Next;

            If not Eof Then
              strDesIte := strDesIte + #13;
          End;

        End;

      End;

    End;
  Finally
    FreeAndNil(qryConsulta)
  End;

End;

function fItemAtivo(Var strDesIte : String; Lista: TStrings = nil): Boolean;
  Var
    qryConsulta : TUniQuery;
Begin
  Try
    qryConsulta := fCriaQuery(nil);
    With qryConsulta, Sql Do
    Begin
      Clear;
      Add(' SELECT SQL_NO_CACHE     ');
      Add(' ENT_CODITE, ENT_DESITE  ');
      Add(' FROM TMP_ENTMER         ');
      Add(' INNER JOIN CADITE ON    ');
      Add(' ENT_CODITE = ITE_CODITE ');
      Add(' WHERE                   ');
      Add(' ITE_ITEATI = "N"        ');
      Open;
      Result := IsEmpty;
      If Not Result Then
      Begin
        strDesIte := '';
        First;
        While Not Eof Do
        Begin
          If Assigned(Lista) Then
          Begin
            Lista.Add(FieldByName('ENT_CODITE').AsString + '-' + FieldByName('ENT_DESITE').AsString);
            Next;
          End
          Else
          Begin

            strDesIte := strDesIte + FieldByName('ENT_CODITE').AsString + '-' + FieldByName('ENT_DESITE').AsString;
            Next;
            If not Eof Then
              strDesIte := strDesIte + #13;
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryConsulta)
  End;
End;

function fItemAtivoCompra(Var strDesIte : String; Lista: TStrings = Nil): Boolean;
  Var
    qryConsulta : TUniQuery;
Begin
  Try
    qryConsulta := fCriaQuery(nil);
    With qryConsulta, Sql Do
    Begin
      Clear;
      Add(' SELECT SQL_NO_CACHE     ');
      Add(' ENT_CODITE, ENT_DESITE  ');
      Add(' FROM TMP_ENTMER         ');
      Add(' INNER JOIN CADITE ON    ');
      Add(' ENT_CODITE = ITE_CODITE ');
      Add(' WHERE                   ');
      Add(' ITE_ATICOM = "N"        ');
      Open;
      Result := IsEmpty;
      If Not Result Then
      Begin
        strDesIte := '';
        First;
        While Not Eof Do
        Begin
          If Assigned(Lista) Then
          Begin
            Lista.Add(FieldByName('ENT_CODITE').AsString + '-' + FieldByName('ENT_DESITE').AsString);
            Next;
          End
          Else
          Begin
            strDesIte := strDesIte + FieldByName('ENT_CODITE').AsString + '-' + FieldByName('ENT_DESITE').AsString;
            Next;
            If not Eof Then
              strDesIte := strDesIte + #13;
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryConsulta)
  End;
End;

{*****************************************}
{* TEM ENTREGA FUTURA ???                *}
{**************************************AF*}
function fTemEntFut(strNumPed, strEspPed, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Result := false;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FDO_ENTFUT = "S" AND ';
  strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';

  try
    qryGen := fCriaQuery;

    try

      With qryGen Do
      Begin
        DisableControls;

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumPed;
        ParamByName('ESPDOC').AsString := strEspPed;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        EnableControls;

        Result := (RecordCount > 0);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[fTemEntFut]');
    End;
  finally
    FreeAndNil(qryGen);
  end;
End;

function fTemRetira(strNumPed, strEspPed, strCodEmp: String; strFDO_SEQGER: String = ''): Boolean;
begin
  Result := fVerificaSeTemEntregaRetira(strNumPed, strEspPed, strCodEmp, 'R');
end;

function fVerificaSeTemEntregaRetira(strNumPed, strEspPed, strCodEmp, strEntRet: String; strFDO_SEQGER: String = ''): Boolean;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    With fCriaQuery, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT SQL_NO_CACHE');
      Add('  COUNT(*)');
      Add('FROM FATDOR');
      Add('  INNER JOIN EXTDOR');
      Add('    ON FDO_SEQFDO = AUTOINCREM');
      If strFDO_SEQGER = '' Then
      Begin
        Add('WHERE FDO_NUMDOC = :NUMDOC');
        Add('    AND FDO_ESPDOC = :ESPDOC');
        Add('    AND FDO_CODEMP = :CODEMP');
      End
      Else
        Add(' WHERE FDO_SEQGER = :SEQGER ');
      Add('    AND FDO_ENTRET = :ENTRET');
      Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM')));
      Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITETAX')));
      Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEMAN')));
      Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITELAN')));

      If strFDO_SEQGER = '' Then
      Begin
        ParamByName('NUMDOC').AsString := strNumPed;
        ParamByName('ESPDOC').AsString := strEspPed;
        ParamByName('CODEMP').AsString := strCodEmp;
      End
      Else
        ParamByName('SEQGER').AsString := strFDO_SEQGER;
      ParamByName('ENTRET').AsString := strEntRet;
      Open;

      Result := (Fields[0].AsInteger > 0);

      Close;
      Destroy;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

Function fTemAbastecimento(strNumDoc, strEspDoc, strCodEmp: String;
                           opcAbastecimento: TOpcAbastecimento;
                           blnSomenteEmpDif: Boolean = False): Boolean;
  Var
    strSQL   : String;
    strSelect: String;
    qryItens : TUniQuery;
Begin


  strSQL := '';

  If (Pos(strEspDoc, 'PD_') > 0) Then
  Begin
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   COUNT(*) AS QTDITE ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   FATDOR ';
    strSQL := strSQL + '   LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = FATDOR.AUTOINCREM  ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM')) + ' AND ';
    strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('ITETAX')) + ' AND ';
    strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
    strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEMAN')) + ' AND ';
    strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('ITELAN')) + ' AND ';

    strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' AND ';
    strSQL := strSQL + '   (ROUND(IFNULL(FDO_QTDITE, 0), '+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+') - ';
    strSQL := strSQL + '    ROUND(IFNULL(FDO_QTDBAI, 0), '+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+') > 0) AND ';
    strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   FDO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   FDO_CODEMP = :CODEMP     ';

    Case opcAbastecimento Of
      opcSolicitado:
        Begin
          If blnSomenteEmpDif Then
            strSQL := strSQL + ' AND IFNULL(NULLIF(FDO_EMPFOR, IFNULL(FDO_EMPITE, FDO_CODEMP)), "") <> "" '
          Else
            strSQL := strSQL + ' AND IFNULL(FDO_EMPFOR, "") <> "" ';
        End;
      opcNaoSolicitado:
        Begin
          If blnSomenteEmpDif Then
            strSQL := strSQL + ' AND IFNULL(NULLIF(FDO_EMPFOR, IFNULL(FDO_EMPITE, FDO_CODEMP)), "") = "" '
          Else
            strSQL := strSQL + ' AND IFNULL(FDO_EMPFOR, "") = "" ';
        End;
    End;

    strSelect := strSQL;
  End
  Else
  Begin
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   COUNT(*) AS QTDITE ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVDET ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  IFNULL(DET_PROEMB, "N") <> "S"         AND ';
    strSQL := strSQL + '  DET_CODITE <> ' + QuotedStr(fCfgSis('ITEMAN')) + ' AND ';
    strSQL := strSQL + '  DET_CODITE <> ' + QuotedStr(fCfgSis('ITELAN')) + ' AND ';
    strSQL := strSQL + '  DET_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM')) + ' AND ';
    strSQL := strSQL + '  DET_CODITE <> ' + QuotedStr(fCfgSis('ITETAX')) + ' AND ';
    strSQL := strSQL + '  DET_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
    strSQL := strSQL + '  DET_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + '  ';

    If (opcAbastecimento In [opcSolicitado, opcNaoSolicitado]) Then
    Begin
      strSQL := strSQL + ' AND IFNULL( ( SELECT SQL_NO_CACHE ';
      strSQL := strSQL + IIF(blnSomenteEmpDif, 'NULLIF(FDO_EMPFOR, IFNULL(FDO_EMPITE, FDO_CODEMP))', 'FDO_EMPFOR');
      strSQL := strSQL + '               FROM ';
      strSQL := strSQL + '                 FATDOR ';
      strSQL := strSQL + '                 LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = FATDOR.AUTOINCREM  ';
      strSQL := strSQL + '               WHERE ';
      strSQL := strSQL + '                 FDO_NUMDOC = DET_NUM_PD AND ';
      strSQL := strSQL + '                 FDO_ESPDOC = DET_ESP_PD AND ';
      strSQL := strSQL + '                 FDO_CODEMP = DET_EMP_PD AND ';
      strSQL := strSQL + '                 FDO_SEQIND = DET_IND_PD AND ';
      strSQL := strSQL + '                 FDO_CODITE = DET_CODITE ), "" ) ';

      Case opcAbastecimento Of
        opcSolicitado    : strSQL := strSQL + ' <> "" ';
        opcNaoSolicitado : strSQL := strSQL + ' =  "" ';
      End;

    End;

    strSelect := '';
    strSelect := strSelect + 'SELECT ';
    strSelect := strSelect + '  SUM(IFNULL(QTDITE, 0)) AS QTDITE ';
    strSelect := strSelect + 'FROM ( ';
    strSelect := strSelect +         strSQL;
    strSelect := strSelect +       ') AS TAB ';
  End;

  qryItens := fCriaQuery;
  With qryItens Do
  Begin
    SQL.Text := strSelect;

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    Result := FieldByName('QTDITE').AsInteger > 0;

    Close;
  End;

  FreeAndNil(qryItens);
End;

{********************}
{* TEM SERVICO ???  *}
{*****************AF*}
function fTemServico(strNumPed, strEspPed, strCodEmp, strCodCli: String): Boolean;
Begin
  If fEmptyStr(strCodCli) Then
    Result := fCampoTabela('FGO_TOTSER', 'FATGOR',
                          ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],
                          [strNumPed, strEspPed, strCodEmp]) > 0
  Else
    Result := fCampoTabela('FGO_TOTSER', 'FATGOR',
                          ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP', 'FGO_CODCLI'],
                          [strNumPed, strEspPed, strCodEmp, strCodCli]) > 0;

  Result := Result Or fPedidoPossuiBrindesServicos(strNumPed, strEspPed, strCodEmp);
End;

{******************}
{* TEM VIDRO ???  *}
{***************AF*}
function fTemVidro(strNumPed, strEspPed, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Result := false;

  If Not fCfgSis('VENVID', varBoolean) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FDO_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FDO_CODITE = :ITEVID AND ';
  strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';

  Try
    qryGen := fCriaQuery;

    try

      With qryGen Do
      Begin
        DisableControls;

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumPed;
        ParamByName('ESPDOC').AsString := strEspPed;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('ITEVID').AsString := fCfgSis('ITEVID');
        Open;

        EnableControls;

        Result := (RecordCount > 0);

        Close;
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[fTemVidro]');
    End;
  finally
    FreeAndNil(qryGen);
  end;
End;

function fTemServicoPD(strCodEmp, strNumDoc, strCodCli: String): Boolean;
  Var
    qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.SQL.Add('SELECT COUNT(1)');
    qry.SQL.Add('  FROM FATDOR');
    qry.SQL.Add(' WHERE FDO_CODEMP = :CODEMP');
    qry.SQL.Add('   AND FDO_NUMDOC = :NUMDOC');
    qry.SQL.Add('   AND FDO_ESPDOC = "PD"');
    If Not fEmptyStr(strCodCli) Then
      qry.SQL.Add('   AND FDO_CODCLI = :CODCLI');
    qry.SQL.Add('   AND (FDO_CODITE = :ITESER OR FDO_CODITE = :SERTER)');

    qry.ParamByName('CODEMP').AsString := strCodEmp;
    qry.ParamByName('NUMDOC').AsString := strNumDoc;
    If Not fEmptyStr(strCodCli) Then
      qry.ParamByName('CODCLI').AsString := strCodCli;
    qry.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qry.ParamByName('SERTER').AsString := fCfgSis('SERTER');
    qry.Open;

    Result := qry.Fields[0].AsInteger > 0;
  Finally
    FreeAndNil(qry);
  End;
end;

function fValidaMaiorZero(dbe: TDBEditFocus; strCampo: String): Boolean;
Begin
  Result := True;

  If fStrToFloat(dbe.Text) = 0 Then
    dbe.Text := '0';

  If fStrToFloat(dbe.Text) < 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Campo "'+strCampo+'" deve ser maior ou igual a zero', ['&O k']);
    Result := False;
  End;
End;

function fGetCorFonteEdit(clCorFundo: TColor): TColor;
  Var
    r, g, b: Byte;
    rgb: DWORD;
    med: Integer;
begin
  rgb := ColorToRGB(clCorFundo);
  r := GetRValue(rgb);
  g := GetGValue(rgb);
  b := GetBValue(rgb);

  med := (r + g + b) div 3;

  If med > 255 div 2 Then
    Result := clBlack
  Else
    Result := clWhite;
end;

function fGetNumbers(strTexto: String): String;
  Var
    intPos: Integer;
begin
  Result := '';
  
  For intPos := 1 To Length(strTexto) Do
    If CharInSet(strTexto[intPos], ['0'..'9']) Then
      Result := Result + strTexto[intPos]
end;

Function fCondicaoPagamentoClienteOk(strOpcDoc, strCondic: String; strTipFC: String; strCodCliParam : String;
  strCndLib : String = ''; blnOriF11: Boolean = False): Boolean;
  Var
    qryCndCli: TUniQuery;
    blnMsnTipCnd: Boolean;
    stlForTipCli: TStringList;
    stlCndTipCli: TStringList;
    stlCndCadCli: TStringList;
    intIdx: Integer;
    blnUsaCnd : Boolean;

    function fVerificaCndTipoCliente: Boolean;
    Begin
      Result := True;

      If (fCfgSis('USATPC') = 'S') And (strTipFC = 'C') And (strOpcDoc <> 'OE')  And (strOpcDoc <> 'EF') Then
      Begin
        pCarregaFormasPagto(strCodCliParam, stlForTipCli, stlCndTipCli);

        If blnOriF11 And (fCfgSis('TVPGRC') = 'N') Then //Não avisa
          Exit;

        If (stlCndTipCli.Count <> 0) Or (stlCndCadCli.Count <> 0) Then
          Result := (stlCndTipCli.IndexOf(strCondic) > -1) Or (stlCndCadCli.IndexOf(strCondic) > -1);
      End;
    End;

Begin

  blnMsnTipCnd := False;
  blnUsaCnd := fCfgSis('USACND', varBoolean);

  Try

    stlForTipCli := TStringList.Create;
    stlForTipCli.Sorted     := True;
    stlForTipCli.Duplicates := dupIgnore;

    stlCndTipCli := TStringList.Create;
    stlCndTipCli.Sorted     := True;
    stlCndTipCli.Duplicates := dupIgnore;

    stlCndCadCli := TStringList.Create;

    If (Pos(strOpcDoc, 'OU_OE_OF_EF_') <= 0) And (strTipFC = 'C') And (fCfgSis('TRACND', varBoolean)) Then
    Begin

      qryCndCli := fCriaQuery;

      With qryCndCli, SQL Do
      Begin
        Add('SELECT * FROM CLICND');
        Add('WHERE CND_CODCLI = ' + QuotedStr(strCodCliParam) + ' AND ');

        If blnUsaCnd Then
          Add('CND_CODCND IS NOT NULL')
        Else
          Add('IFNULL(CND_CNDPAG, "") <> ""');

        Open;

        If IsEmpty Then
        Begin
          Result := fVerificaCndTipoCliente;
          blnMsnTipCnd := Not Result;
        End
        Else
        Begin
          First;
          While Not Eof Do
          Begin
            stlCndCadCli.Add(FieldByName(IIF(blnUsaCnd, 'CND_CODCND', 'CND_CNDPAG')).Text);
            Next;
          End;
          First;

          Result := Locate(IIF(blnUsaCnd, 'CND_CODCND', 'CND_CNDPAG'), fTiraCaracEspeciais(strCondic), []);

          If (Not Result) And ((fCfgSis('USATPC') = 'S') And (Not fEmptyStr(fRetTipoCliente(strCodCliParam)))) Then
          Begin
            Result := fVerificaCndTipoCliente;
            blnMsnTipCnd := Not Result;
          End;
        End;
      End;

      qryCndCli.Close;
      FreeAndNil(qryCndCli);

    End
    Else
    Begin
      Result := fVerificaCndTipoCliente;
      blnMsnTipCnd := Not Result;
    End;

    If (Not Result) Then
    Begin
      If (Not fEmptyStr(strCndLib)) And (SameText(strCndLib, strCondic)) Then
        Result := True
      Else If (blnMsnTipCnd) Then
      Begin
        For intIdx:= 0 To stlCndCadCli.Count-1 Do
          stlCndTipCli.Add(stlCndCadCli[intIdx]);

        pMsgCondicoesPagtoPermitidasCliente(strCondic, stlCndTipCli);
      End
      Else
        pMensagemOk('A condição de pagamento não é válida para esse cliente!')
    End;

  Finally
    FreeAndNil(stlForTipCli);
    FreeAndNil(stlCndTipCli);
    FreeAndNil(stlCndCadCli);
  End;

End;

procedure pMsgCondicoesPagtoPermitidasCliente(strCodCnd: String; stlCndPag: TStringList);
  Var
    intInd: Integer;
    blnUsaCnd: Boolean;
begin
  blnUsaCnd := fCfgSis('USACND', VarBoolean);
  Try
    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.Caption := 'Condição: (' + strCodCnd + IIF(blnUsaCnd, '-' + fRetDesConPag(strCodCnd), '') + ') não permitida!';
    frmObservacao.lblMensagem.Caption := 'Condições permitidas: ';
    For intInd := 0 To stlCndPag.Count -1 Do
      frmObservacao.memObs.Lines.Add(fPadR( stlCndPag[intInd] + IIF(blnUsaCnd, '-' + fRetDesConPag(stlCndPag[intInd]), ''), 40));
    frmObservacao.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[untFuncoesSimples.pMsgCondicoesPagtoPermitidasCliente]');
    End;
  End;
  pFreeAndNil(frmObservacao);
end;

function fItemNaoFracionavel(strOpcDoc, strCodUni: String; blnCarregandoEstrutura: Boolean=False; qryUni: TUniQuery=NIL): Boolean;
begin
  Result := (Not fItemFracionado(strCodUni, qryUni)) And
            (Not (blnCarregandoEstrutura And fCfgSis('USACCR', varBoolean))) And
            (Not ((strOpcDoc = 'NE') And fCfgSis('NESTIN', varBoolean)));
end;

Function fVerificaPesoDosItensEntrada(blnOutDes: Boolean = False): Boolean;
Begin
  If Not blnOutDes Then
  Begin
    { RATFRE:
        '1- Proporcional ao valor do item'
        '2- Proporcional ao peso do item'
        '3- Informar o tipo de rateio  no momento da entrada'
        '4- Proporcional a Quantidade de item'
        '5- Informar os percentuias por produto'}

    If (Pos(fCfgSis('RATFRE', varString), '1_4_5_') > 0 ) Then
    Begin
      Result := True;
      Exit;
    End;
  End;

  Result := (not fncExecutaRelatorio(202, 7584, [],
                                        ['OPCREL','NOTENT'],
                                        ['1', ''],
                                        nil,
                                        nil,
                                        True,
                                        False));
  if not Result then
  begin
    If Not blnOutDes Then
      pMensagemOk('O Sistema está configurado para ratear o frete proporcionalmente ao Peso do Item,' + #$A#$D +
                  'dessa forma itens com peso igual a zero não serão permitidos.' + #$A#$D +
                  'Informe no Cadastro de Produtos o peso dos itens.')
    Else
      pMensagemOk('Foi escolhido o rateamento proporcionalmente ao Peso do Item,' + #$A#$D +
                  'dessa forma itens com peso igual a zero não serão permitidos.' + #$A#$D +
                  'Informe no Cadastro de Produtos o peso dos itens.');
  end;

End;

Function fRetornaPesoEntrada(Var fltPesTotAnt: Double; blnConverteEmbalagem: Boolean = False): Double;
  Var
    qryEntMer: TUniQuery;
Begin
  Try
    fltPesTotAnt := 0;
    
    qryEntMer := fCriaQuery;

    With qryEntMer, SQL Do
    Begin
      Add('SELECT ');
      If blnConverteEmbalagem Then
      Begin
        Add('  SUM(ROUND(ENT_QTDITE * ENT_EMBALA, ' + fCfgSis('DEQTEM') + ') * ITE_PESOIT) AS PESTOT, ');
        Add('  SUM(IF(ENT_ANTFRE = "S", (ROUND(ENT_QTDITE * ENT_EMBALA, ' + fCfgSis('DEQTEM') + ') * ITE_PESOIT), 0)) AS PESTOTANT ');
      End
      Else
      Begin
        Add('  SUM(ENT_QTDITE * ITE_PESOIT) AS PESTOT, ');
        Add('  SUM(IF(ENT_ANTFRE = "S", ENT_QTDITE * ITE_PESOIT, 0)) AS PESTOTANT ');
      End;
      Add('FROM TMP_ENTMER');
      Add('INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE');

      Open;

      Result := FieldByName('PESTOT').AsFloat;

      fltPesTotAnt := FieldByName('PESTOTANT').AsFloat;

    End;

    FreeAndNil(qryEntMer);
  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[fVerificaPesoDosItensEntrada]');
    End;
  End;
End;

Function fRetornaQtdeEntrada(Var fltQtdTotAnt: Double): Double;
  Var
    qryEntMer: TUniQuery;
Begin
  Try

    qryEntMer := fCriaQuery;

    With qryEntMer, SQL Do
    Begin
      Add('SELECT ');
      Add('  SUM(ENT_QTDITE) AS QTDTOT, ');
      Add('  SUM(IF(ENT_ANTFRE = "S", ENT_QTDITE, 0)) AS QTDTOTANT ');
      Add('FROM TMP_ENTMER');

      Open;

      Result := FieldByName('QTDTOT').AsFloat;
      fltQtdTotAnt:= FieldByName('QTDTOTANT').AsFloat;

    End;

    FreeAndNil(qryEntMer);
  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[fRetornaQtdeEntrada]');
    End;
  End;
End;


procedure pFreeLibraryPedidoCompra;
  Var
//    dxFinalizePedCom: procedure;
    objFree: HMODULE;
Begin
  objFree := GetModuleHandle('libPedidoDeCompra.dll');
  If (objFree <> Null) And (objFree <> 0) Then
  Begin
  //  dxFinalizePedCom := GetProcAddress(objFree, PChar('dxFinalizePedCom'));
  //  dxFinalizePedCom;
    FreeLibrary(objFree);
  End;
End;

procedure pFreeLibraryOpeRefProd;
  Var
//    dxFinalizeOrp  : procedure;
    objFree: HMODULE;
Begin
  objFree := GetModuleHandle('libOpeRefProd.dll');
  If  (objFree <> Null) And (objFree <> 0) Then
  Begin
//    dxFinalizeOrp := GetProcAddress(objFree, PChar('dxFinalizeOrp'));
//    dxFinalizeOrp;
    FreeLibrary(objFree);
  End;
End;

procedure pFreeLibraryReinf;
  Var
//    dxFinalizeOrp  : procedure;
    objFree: HMODULE;
Begin
  objFree := GetModuleHandle('libReinf.dll');
  If  (objFree <> Null) And (objFree <> 0) Then
  Begin
//    dxFinalizeOrp := GetProcAddress(objFree, PChar('dxFinalizeOrp'));
//    dxFinalizeOrp;
    FreeLibrary(objFree);
  End;
End;

procedure pFreeLibraryTransfCod;
  Var
//    dxFinalizeTra  : procedure;
    objFree: HMODULE;
Begin
  objFree := GetModuleHandle('libTransfCodigo.dll');
  If  (objFree <> Null) And (objFree <> 0) Then
  Begin
//    dxFinalizeTra := GetProcAddress(objFree, PChar('dxFinalizeTra'));
//    dxFinalizeTra;
    FreeLibrary(objFree);
  End;
End;

procedure pFreeLibraryPixCitel;
  Var
    objFree: HMODULE;

    dxFinalizePix: procedure;
Begin
  Try
    objFree := GetModuleHandle('libIntegracaoPixCitel.dll');
    If (objFree = Null) Then
      Exit;

    If (objFree = 0) Then
      Exit;

    Try
      dxFinalizePix := GetProcAddress(objFree,'dxFinalizePix');
      dxFinalizePix;
    Finally
      FreeLibrary(objFree);
    End;
  Except

  End;
End;

procedure FreeLibraryCartoes;
  Var
    objFree: HMODULE;

    dxFinalize: procedure;
Begin
  Try
    objFree := GetModuleHandle('libCartoes\libCartoesAutcom.dll');
    If (objFree = Null) Then
      Exit;

    If (objFree = 0) Then
      Exit;

    Try
      dxFinalize := GetProcAddress(objFree,'dxFinalize');
      dxFinalize;
    Finally
      objFree := 0;
      FreeLibrary(objFree);
    End;
  Except

  End;
End;

procedure pFinalizaLibrarys(blnDestroyTinta: Boolean = True);
  Var
    objFree: HMODULE;
    strDllTin: String;
Begin
  objFree := GetModuleHandle('libRelFatGeral.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelPedidosDeVenda.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelBancariosContabeis.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelChequesPre.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelEstatistica.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelContasAPagar.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelContasAReceber.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelLivrosFiscais.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelEstoque.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelFatEvolucaoVendas.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelFatMetas.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelFatComissao.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelFatVendas.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  objFree := GetModuleHandle('libGNRE.dll');
  If objFree <> 0 Then
    FreeLibrary(objFree);

  If blnDestroyTinta Then
     blnDestroyTinta := HandleDllTinta <> 0;

  If blnDestroyTinta Then
  Begin
    If blnUsuarioLogadoUtilizaModoClassico Then
    Begin
      pLog('objFree   := GetModuleHandle(PChar(strDllTin));');
      strDllTin := ExtractFilePath(Application.ExeName) + DLL_TINTA_PATH;
      objFree   := GetModuleHandle(PChar(strDllTin));
    End
    Else
    Begin
      pLog('objFree   := GetModuleHandle(PChar(DLL_TINTA_NAME));');
      objFree := GetModuleHandle(PChar(DLL_TINTA_NAME));
    End;

    pLog('FreeLibrary(objFree);');
    If (objFree <> 0) Then
    Begin
      If Assigned(dxFinalizeTin) Then
        dxFinalizeTin;
    FreeLibrary(objFree);
  End;
  End;

  pLog('pFreeLibraryPedidoCompra;');
  pFreeLibraryPedidoCompra;

  pLog('pFreeLibraryEtiquetas;');
  pFreeLibraryEtiquetas;
  
  pLog('pFreeLibraryOpeRefProd;');
  pFreeLibraryOpeRefProd;
  
  pLog('pFreeLibraryTransfCod;');
  pFreeLibraryTransfCod;

  pLog('pFreeLibraryPixCitel;');
  pFreeLibraryPixCitel;

  pLog('pFreeLibraryAuttin;');
  pFreeLibraryAutTin;

  pLog('pFreeLibraryReinf;');
  pFreeLibraryReinf;

  pLog('FreeLibraryCartoes;');
  FreeLibraryCartoes;
End;

{****************************************}
{* FUNÇÃO PARA PEGAR UMA DATA A IDÉIA É *}
{* SUBSTITUIR O FFRMDATA PORQUE ESSA JÁ *}
{* TEM AS PROPRIEDADES DO FRMPAI        *}
{*************************************JU*}
function ffrmDataNovo(Var dtaData: TDateTime; strCaption, strCaptionLabel: String): Boolean;
Begin

  If dtaData = 0 Then
    dtaData := VS_Date;

  Try
    pCriarFormularios(TfrmDigDtaNovo, frmDigDtaNovo);
    frmDigDtaNovo.Caption          := strCaption;
    frmDigDtaNovo.lblDtaInf.Caption:= strCaptionLabel;

    Try
      frmDigDtaNovo.mskDtaInf.Text := FormatDateTime('dd/mm/yyyy', dtaData);
    Except
      frmDigDtaNovo.mskDtaInf.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
    End;

    Result := (frmDigDtaNovo.ShowModal = mrOk);

    If (Result) Then
      dtaData := StrToDate(frmDigDtaNovo.mskDtaInf.Text);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ffrmDataNovo]');
    End;
  End;

  pFreeAndNil(frmDigDtaNovo);

End;

function fUtilizaTravaMaxUtilCredProfissional(fltValor: Double): Boolean;
Begin
  Result := (fCfgSis('TCOPRO') = '2') And fCfgSis('TRACPR', varBoolean) And (fltValor <= 0);
End;

procedure pDestravaDuplicatas(strChaLck: String);
begin
  fLock_Unlock(strChaLck, False, False);
end;

function fTravaDupCreditoProf: Boolean;
Begin
  pDestravaDupCreditoProf;
  Result := fLock_Unlock(CHAVE_CRED_PROFISSIONAL, True, False);

  If (Not Result) Then
    fMensagem('', 'Existe Duplicata de crédito de profissional selecionada para ser baixada pela Estação ' +
                   fGetHostLock(CHAVE_CRED_PROFISSIONAL)  + '!' + #13#10 +
                  'Empresa configurada(CFG_TRACPR) para controlar limite máximo de baixa de crédito para profissional do mês.' , ['&Ok']);
End;

procedure pDestravaDupCreditoProf;
Begin
  fLock_Unlock(CHAVE_CRED_PROFISSIONAL, False, False);
End;

{************************************}
{* TRAVA PARA MÁXIMO DE UTILIZAÇÃO  *}
{* DE CRÉDITO PARA PROFISSIONAIS NO *}
{* MÊS CORRENTE                     *}
{*********************************AF*}
function fVerificaCredProfissionaisMes(fltValor: Double; Var fltCreUti: Double): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    Ano, Mes, Dia: Word;
    fltUtilizados: Double;
Begin
  fltCreUti := 0;

  Try
    fltValor := Abs(fltValor);

    fltUtilizados := 0;
    DecodeDate(VS_Date, Ano, Mes, Dia);
    Dia := DaysInMonth(VS_Date);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   SUM(CTR_VALREC) AS VALREC ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_EMPBAI = :CODEMP AND ';
    strSQL := strSQL + '   CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '   CTR_DOCDIV IS NOT NULL AND ';
    strSQL := strSQL + '   CTR_VALREC < 0  ';

    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('   SUM(VALREC) AS VALREC ');
      SQL.Add(' FROM ');
      SQL.Add(' ( ' + strSQL + ' ) AS TMP ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAINI').AsDate := EncodeDate(Ano, Mes, 01);
      ParamByName('DTAFIN').AsDate := EncodeDate(Ano, Mes, Dia);
      Open;

      If Not IsEmpty Then
        fltUtilizados := Abs(FieldByName('VALREC').AsFloat);
    End;

    fltCreUti := fltUtilizados;
    Result := Not (fFormataFloat(fltValor + fltUtilizados, 2) > fFormataFloat(fCfgSis('MAXUCM', varDouble), 2));
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(qryGen);
End;

function fVerificaDocumentoRequisicaoCompra(strEspSel, strNumDoc, strCodEmp: String): Boolean;
Var
  strSQL   : String;
  qryGenGer: TUniQuery;
begin
  Try
    Result := False;

    qryGenGer := fCriaQuery;

    strSQL := '';

    If Pos(strEspSel, 'NF_FF_IF_') > 0 Then
    Begin
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  RCD_CODIGO ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVRCD ';
      strSQL := strSQL + '  INNER JOIN MOVDET ';
      strSQL := strSQL + '    ON DET_NUMDOC = RCD_DOCPDV ';
      strSQL := strSQL + '    AND DET_ESPDOC = RCD_ESPPDV ';
      strSQL := strSQL + '    AND DET_CODEMP = RCD_EMPPDV ';
      strSQL := strSQL + '    AND DET_CODITE = RCD_CODITE ';
      strSQL := strSQL + 'WHERE TRUE ';
      strSQL := strSQL + '  AND DET_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
      strSQL := strSQL + '  AND DET_JAFATU = 0 ';
      strSQL := strSQL + '  AND RCD_REQNEG <> "S" ';
    End
    Else
    Begin
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  RCD_CODIGO ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVRCD ';
      strSQL := strSQL + '  INNER JOIN FATDOR ';
      strSQL := strSQL + '    ON FDO_NUMDOC = RCD_DOCPDV ';
      strSQL := strSQL + '    AND FDO_ESPDOC = RCD_ESPPDV ';
      strSQL := strSQL + '    AND FDO_CODEMP = RCD_EMPPDV ';
      strSQL := strSQL + '    AND FDO_CODITE = RCD_CODITE ';
      strSQL := strSQL + 'WHERE TRUE ';
      strSQL := strSQL + '  AND FDO_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '  AND FDO_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '  AND FDO_CODEMP = :CODEMP ';
      strSQL := strSQL + '  AND FDO_JAFATU = 0 ';
      strSQL := strSQL + '  AND RCD_REQNEG <> "S" ';
    End;

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspSel;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If (Not IsEmpty) Then
      Begin
        Result := True;
        fMensagem('', 'O documento: ' + strNumDoc + '-' + strEspSel + ' está na requisição de compra: ' +
                      FieldByName('RCD_CODIGO').AsString + ' e não poderá ser cancelado!', ['&Ok']);
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;
end;

function fItemComRequisicaoEmAberto(strCodEmp, strCodIte: String): Boolean;
Var
    strSQL: String;
    qryGenIte, qryReqAbe : TUniQuery;
Begin

  Try
    Result := False;
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                     ';
    strSQL := strSQL + '  AUTOINCREM               ';
    strSQL := strSQL + 'FROM                       ';
    strSQL := strSQL + '  MOVRCD                   ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '   RCD_EMPPDV = :CODEMP    ';
    strSQL := strSQL + '  AND RCD_CODITE = :CODITE ';

    qryGenIte.Close;
    qryGenIte.SQL.Clear;
    qryGenIte.SQL.Add(strSQL);
    qryGenIte.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenIte.ParamByName('CODITE').AsString := strCodIte;
    qryGenIte.Open;

    If not qryGenIte.IsEmpty  Then
    Begin
        qryReqAbe := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + 'SELECT                     ';
        strSQL := strSQL + '  COUNT(*) AS QTD          ';
        strSQL := strSQL + 'FROM                       ';
        strSQL := strSQL + '  BAIREQ                   ';
        strSQL := strSQL + 'WHERE                      ';
        strSQL := strSQL + '  BAI_AUTREQ = :AUTOINCREM ';


        While not qryGenIte.eof do
        Begin
          qryReqAbe.Close;
          qryReqAbe.SQL.Clear;
          qryReqAbe.SQL.Add(strSQL);
          qryReqAbe.ParamByName('AUTOINCREM').AsString := qryGenIte.FieldByName('AUTOINCREM').AsString;
          qryReqAbe.Open;

          If qryReqAbe.FieldByName('QTD').AsInteger = 0 Then
          Begin
            Result := True;
            exit  ;
          End;
          qryReqAbe.Close;
          qryGenIte.Next;
        End;
        FreeAndNil(qryReqAbe);
    End;
    qryGenIte.Close;
  Finally
    FreeAndNil(qryGenIte);
  End;

End;

function fPedComRequisicaoEmAberto(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add( fGetSqlPedComRequisicaoEmAberto );

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fGetSqlPedComRequisicaoEmAberto: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  CONCAT(F.FDO_CODCLI, "-", C.CLI_NOMCLI) AS NOMCLI, ';
  Result := Result + '  CONCAT(F.FDO_CODVEN, "-", O.OPE_NOMOPE) AS NOMVEN, ';
  Result := Result + '  CONCAT(F.FDO_NUMDOC, "-", F.FDO_ESPDOC, "-", F.FDO_CODEMP) AS PEDVEN, ';
  Result := Result + '  F.FDO_DTAENT AS DTAENT, ';
  Result := Result + '  CONCAT(F.FDO_CODITE, "-", F.FDO_DESCRI) AS DESITE, ';
  Result := Result + '  U.UNI_SIGUNI AS UNIDAD, ';
  Result := Result + '  F.FDO_QTDITE AS QTDITE, ';
  Result := Result + '  M.RCD_CODIGO AS NUMREQ, ';
  Result := Result + '  M.RCD_CODEMP AS EMPREQ, ';
  Result := Result + '  M.RCD_QTDITE AS QTDREQ, ';
  Result := Result + '  (SELECT IFNULL(SUM(BAI_QTDREQ), 0) ';
  Result := Result + '   FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM) AS QTDBAI, ';
  Result := Result + '  CONCAT(P.PCD_NUMPED, "-", P.PCD_ESPDOC, "-", P.PCD_CODEMP) AS NUMCOM, ';
  Result := Result + '  P.PCD_DTAENT AS DTAENT, ';
  Result := Result + '  (SELECT GROUP_CONCAT(CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP)) ';
  Result := Result + '   FROM BAIREQ ';
  Result := Result + '   INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET ';
  Result := Result + '   WHERE BAI_AUTREQ = M.AUTOINCREM) AS NOTAS, ';
  Result := Result + '  C.CLI_C_G_C_ ';
  Result := Result + 'FROM FATDOR F ';

  If fCfgSis('SLTFRC', varBoolean) Then
  Begin
    Result := Result + 'JOIN FDOABS A ON F.AUTOINCREM = A.ABS_SEQFDO ';
    Result := Result + 'JOIN PREPRQ Q ON A.ABS_SEQPRQ = Q.AUTOINCREM ';
  End;

  Result := Result + 'JOIN CADCLI C ON C.CLI_CODCLI = F.FDO_CODCLI ';
  Result := Result + 'JOIN MOVRCD M ON F.FDO_NUMDOC = M.RCD_DOCPDV ';
  Result := Result + '             AND F.FDO_ESPDOC = M.RCD_ESPPDV ';
  Result := Result + '             AND F.FDO_CODEMP = M.RCD_EMPPDV ';
  Result := Result + '             AND F.FDO_CODITE = M.RCD_CODITE ';
  Result := Result + 'LEFT JOIN CADUNI U ON F.FDO_UNIDAD = U.UNI_CODUNI ';
  Result := Result + 'LEFT JOIN CADOPE O ON O.OPE_CODOPE = F.FDO_CODVEN ';
  Result := Result + 'LEFT JOIN PCMDET P ON P.AUTOINCREM = M.RCD_SEQPCD ';
  Result := Result + 'WHERE F.FDO_NUMDOC = :NUMDOC ';
  Result := Result + '  AND F.FDO_ESPDOC = :ESPDOC ';
  Result := Result + '  AND F.FDO_CODEMP = :CODEMP ';
  Result := Result + '  AND M.RCD_REQNEG <> "S" ';
end;

function fTemItensEntregaRetira(strTabConf: String): Boolean;
   function fExecutaPesquisa(strEntRetWhere: String):Boolean;
   begin
      Result := fCampoTabela('IFNULL(TMP_ENTRET, "")', strTabConf, ['IFNULL(SAV_SINTET, "N")', 'TMP_ENTRET'], ['N', strEntRetWhere]) = strEntRetWhere;
   end;
begin
  Result := fExecutaPesquisa('R') And fExecutaPesquisa('E');
end;

function fPodeMarcarEntregaRetira(qry: TUniQuery; strTabConf: String; strEntRet: String=''): Boolean;
 Var
   strEntRetBusca : String;
   strEntRetWhere : String;
begin
  Result := True;

  If fCfgSis('COENRE', varBoolean) And (Not qry.IsEmpty) Then
  Begin
     strEntRetWhere := strEntRet;
     If fEmptyStr(strEntRetWhere) Then
       strEntRetWhere := qry.FieldByName('TMP_ENTRET').AsString;
     strEntRetWhere := IfThen(strEntRetWhere = 'E', 'R', 'E');

     strEntRetBusca := fCampoTabela('IFNULL(TMP_ENTRET, "")', strTabConf, ['TMP_MARDES', 'IFNULL(SAV_SINTET, "N")', 'TMP_ENTRET'], ['M', 'N', strEntRetWhere]);

     If (Not fEmptyStr(strEntRetBusca)) Then
     Begin
       fMensagem('', 'Já existem documentos de ' + IfThen(strEntRetBusca='E', '"Entrega"', '"Retira"') + ' marcados! ' + #13 +
                     'Somente podem ser confirmados no mesmo documento, documentos de "Entrega" ou "Retira"', ['&Ok']);
       Result := False;
     End;
  End;
end;

function fRetTotItemServ: Double;
  var
    qryTMP: TUniQuery;
begin
  qryTMP := fCriaQuery;
  Try
    Try
      qryTMP.Sql.Add('SELECT SUM(ENT_TOTITE) AS TOTSER FROM TMP_ENTMER');
      qryTMP.Sql.Add(' WHERE ENT_CODITE IN(' + QuotedStr(fCfgSis('ITESER', varString)) + ', ' + QuotedStr(fCfgSis('SERTER', varString))+')');
      qryTMP.Sql.Add('    OR ENT_TIPPRO = ' + QuotedStr(TIPO_PRODUTO_SPED[9,0] ));

      qryTMP.Open;
      Result := qryTMP.FieldByName('TOTSER').AsFloat;
    Except
      Result := 0.00;
    End;
  Finally
    FreeAndNil(qryTMP);
  end
end;

function fTinDorBaixado(strNumDoc, strEspDoc, strCodEmp: String; blnSomenteNaoFaturado: Boolean = False): Boolean;
  Var
    qryTinDor: TUniQuery;
begin
  Try
    qryTinDor := fCriaQuery(Nil);
    With qryTinDor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT T.FDO_NUMDOC ');
      SQL.Add('  FROM TINDOR T   ');

      If blnSomenteNaoFaturado Then
      Begin
        SQL.Add('   INNER JOIN FATDOR D                ');
        SQL.Add('     ON D.FDO_NUMDOC = T.FDO_NUMDOC   ');
        SQL.Add('     AND D.FDO_ESPDOC = T.FDO_ESPDOC  ');
        SQL.Add('     AND D.FDO_CODEMP = T.FDO_CODEMP  ');
        SQL.Add('     AND D.FDO_CODACA = T.FDO_CODACA  ');
        SQL.Add('     AND D.FDO_EMPACA = T.FDO_EMPACA  ');
      End;

      SQL.Add(' WHERE T.FDO_NUMDOC = :NUMDOC ');
      SQL.Add('   AND T.FDO_ESPDOC = :ESPDOC ');
      SQL.Add('   AND T.FDO_CODEMP = :CODEMP ');
      SQL.Add('   AND T.FDO_BAIXAD <> ''N''  ');

      If blnSomenteNaoFaturado Then
      Begin
        SQL.Add('   AND IFNULL(D.FDO_QTDBAI, 0) < D.FDO_QTDITE ');
        SQL.Add('   AND D.FDO_JAFATU = 0 ');
      End;

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryTinDor);
  End;
end;

function fRetCodOpeSolicitante(strParOpcDoc, strParCodOpe: String): String;
begin
  Result := IIF((Not fEmptyStr(strParCodOpe)) And (Pos(strParOpcDoc, 'PD_OR_VN_') > 0), strParCodOpe, strLoginUsuarioLogado);
end;

function fEmpresaUsaTransferenciaOuVenda(strCodEmp,strCodFilial : String) : Boolean;
  Var
  qryGen : TUniQuery;
begin
  Result := False;

  qryGen := fCriaQuery;

  qryGen.SQL.Add('SELECT * FROM CONEMP WHERE CON_EMPORI = :EMPRESALOGADA AND CON_EMPDES = :EMPRESAFILIAL AND CON_TIPOPE = 2');

  qryGen.ParamByName('EMPRESALOGADA').Value := strCodEmp;
  qryGen.ParamByName('EMPRESAFILIAL').Value := strCodFilial;

  qryGen.Open;

  If qryGen.RecordCount > 0 Then
   Result := True;

  FreeAndNil(qryGen);
end;

function fValidaPlaVei(strPlaVei:string) : Boolean;
  Var
    intIndice: Integer;
    strLetrasMercosul, strLetrasAtual,
    strNumerosMercosul, strNumerosAtual: String;
begin
  Result := True;
  strPlavei  := fTiraCaracEspeciais(strPlavei,False,True);

  If strPlaVei.Length < 7 Then
  Begin
    fMensagem('ATENÇÃO', 'Formato de placa inválida!', ['&O k']);
    Result := False;
  End
  Else
  Begin
    strLetrasMercosul := Copy(strPlaVei,1,3)+Copy(strPlaVei,5,1);
    strNumerosMercosul := Copy(strPlaVei,4,1)+Copy(strPlaVei,6,2);
    strLetrasAtual := LeftStr(strPlaVei,3);
    strNumerosAtual := RightStr(strPlaVei,4);

    If (Pos(Copy(strPlaVei,5,1),'0_1_2_3_4_5_6_7_8_9') = 0) Then //Padrão Mercosul
    Begin

      If Not fEmptyStr(strPlaVei) Then
      Begin
        For intIndice := 1 To strNumerosMercosul.Length Do
        Begin
          If Not CharInSet(strNumerosMercosul[intIndice], ['0'..'9']) Then
          Begin
            Result := False;
            Break;
          End;
        End;

        For intIndice := 1 To strLetrasMercosul.Length Do
        Begin
          If Not fEhLetra(strLetrasMercosul[intIndice])  Then
          Begin
            Result := False;
            Break;
          End;
        End;
      End;
    End
    Else
    Begin

      If Not fEmptyStr(strPlaVei) Then
      Begin
        For intIndice := 1 To strNumerosAtual.Length Do
        Begin
          If Not CharInSet(strNumerosAtual[intIndice], ['0'..'9']) Then
          Begin
            Result := False;
            Break;
          End;
        End;

        For intIndice := 1 To strLetrasAtual.Length Do
        Begin
          If Not fEhLetra(strLetrasAtual[intIndice])  Then
          Begin
            Result := False;
            Break;
          End;
        End;
      End;
    End;

    If Not Result Then
      fMensagem('ATENÇÃO', 'Formato de placa inválida!', ['&O k']);
  End;

end;

procedure pRetornarModeloEmailAutomatico(strEmailTela,
                                         strNumDoc,
                                         strOpcDoc,
                                         strEspDoc,
                                         strNumOrc,
                                         strEspOrc,
                                         strEmpOri,
                                         strCodCli      : String;
                                         var strModelo  : String;
                                         var strAssunto : String;
                                         out ADadosAutenticacao: TDadosLoginEmail;
                                         blnVerSomenteLayoutAtivo : Boolean = False;
                                         AQRCodePix: String = '';
                                         ALinkCitel: String = '');
Var
  objEmaAut: TEmaAut;
  strSQL: String;
  qrySQL: TUniQuery;
  strEmail: String;
Begin

  Try
    qrySQL := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  CLI_EMAIL_ AS EMAIL_, ';
    strSQL := strSQL + '  CLI_EMAIL2 AS EMAIL2, ';
    strSQL := strSQL + '  CLI_EMAIL3 AS EMAIL3, ';
    strSQL := strSQL + '  CONCAT(CID_NOMCID, "-", CID_ESTADO) AS NOMCID ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

    With qrySQL Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
    End;

    Try
      objEmaAut := TEmaAut.Create(Nil);
      objEmaAut.FNumDoc := strNumDoc;
      objEmaAut.FOpcDoc := strOpcDoc;
      objEmaAut.FEspDoc := strEspDoc;
      objEmaAut.FNumOrc := strNumOrc;
      objEmaAut.FEspOrc := strEspOrc;
      objEmaAut.FEmpOri := strEmpOri;

      objEmaAut.QrCodePix := RetonaQRCodePixPedido(AQRCodePix, ALinkCitel);

      objEmaAut.FEmaCli := '';
      strEmail := Trim(qrySQL.FieldByName('EMAIL_').AsString);

      If (fEmailValido(strEmail, False)) Then
        objEmaAut.FEmaCli := strEmail;

      strEmail := Trim(qrySQL.FieldByName('EMAIL2').AsString);

      If (fEmailValido(strEmail, False)) Then
      Begin
        If (fEmptyStr(objEmaAut.FEmaCli)) Then
          objEmaAut.FEmaCli := strEmail
        Else
        Begin
          If (Pos(strEmail, objEmaAut.FEmaCli) <= 0) Then
          Begin
            If (objEmaAut.FEmaCli[Length(objEmaAut.FEmaCli)] = ';' ) Then
              objEmaAut.FEmaCli := objEmaAut.FEmaCli + strEmail
            Else
              objEmaAut.FEmaCli := objEmaAut.FEmaCli + ';' + strEmail;
          End;
        End;
      End;

      strEmail := Trim(qrySQL.FieldByName('EMAIL3').AsString);

      If (fEmailValido(strEmail, False)) Then
      Begin
        If (fEmptyStr(objEmaAut.FEmaCli)) Then
          objEmaAut.FEmaCli := strEmail
        Else
        Begin
          If (Pos(strEmail, objEmaAut.FEmaCli) <= 0) Then
          Begin
            If (objEmaAut.FEmaCli[Length(objEmaAut.FEmaCli)] = ';' ) Then
              objEmaAut.FEmaCli := objEmaAut.FEmaCli + strEmail
            Else
              objEmaAut.FEmaCli := objEmaAut.FEmaCli + ';' + strEmail;
          End;
        End;
      End;

      If (fEmptyStr(objEmaAut.FEmaCli)) Then objEmaAut.FEmaCli := strEmailTela;

      objEmaAut.FNomCli := qrySQL.FieldByName('NOMCLI').AsString;
      objEmaAut.FPriCli := fRetPrimeiraPalavra(qrySQL.FieldByName('NOMCLI').AsString);
      objEmaAut.FCodCli := strCodCli;
      objEmaAut.FCidCli := qrySQL.FieldByName('NOMCID').AsString;
      objEmaAut.FTransp := '';
      objEmaAut.FCodOpe := strLoginUsuarioLogado;

      If (objEmaAut.fTemEmailAtivo) And (objEmaAut.fEnviaEmailAutomatico(False)) Then Begin
        strModelo  := objEmaAut.strCorpo;
        strAssunto := objEmaAut.strAssunt;
      End;

      ADadosAutenticacao.Senha := objEmaAut.FSenha;
      ADadosAutenticacao.Email := objEmaAut.FEmail;
      ADadosAutenticacao.Login := objEmaAut.FLogin;
      ADadosAutenticacao.Remetente := objEmaAut.FRemete;
      ADadosAutenticacao.ServidorSMTP := objEmaAut.FSerSmt;
      ADadosAutenticacao.ServidorImap := objEmaAut.FSerIma;
      ADadosAutenticacao.TextoAssinatura := objEmaAut.FTxtAss;
      ADadosAutenticacao.GravaPastaEnviados := objEmaAut.FGravaPastaEnviados;
      ADadosAutenticacao.Provedor := objEmaAut.FCodPrv;
      ADadosAutenticacao.PortaSMTP := objEmaAut.FPorSmt;
      ADadosAutenticacao.PortaImap := objEmaAut.FPorIma;
      ADadosAutenticacao.LimiteArquivos := objEmaAut.FLimArq;
      ADadosAutenticacao.ImagemAssinatura := objEmaAut.FImgAss;
      ADadosAutenticacao.AutenticacaoSSL := objEmaAut.FSSLSai;
      ADadosAutenticacao.AutenticacaoSSLImap := objEmaAut.FSSLEnt;
      ADadosAutenticacao.ImagemAssinaturaStream := objEmaAut.FImaAss;

      If (objEmaAut.FImgAss) Then
      Begin
        ADadosAutenticacao.ImagemAssinaturaStream := TMemoryStream.Create;

        If objEmaAut.FImaAss <> Nil Then
        Begin
          objEmaAut.FImaAss.SaveToStream(ADadosAutenticacao.ImagemAssinaturaStream);
          ADadosAutenticacao.ImagemAssinaturaStream.Seek(0,soFromBeginning);
        End;
      End
      Else
        ADadosAutenticacao.ImagemAssinaturaStream := nil;

    Finally
      FreeAndNil(objEmaAut);
    End;

  Finally
    FreeAndNil(qrySQL);
  End;
End;

function RetonaQRCodePixPedido(AQrCodePix,
                               ALinkCitelPix: String;
                               AEmail: Boolean = True): String;
Begin
  Result := EmptyStr;

  If AQrCodePix.IsEmpty Then
    Exit;

  If AEmail Then
  Begin
    Result := 'Pagamento por Pix:<br>' +
              '<p><img src="' + RetornaLinkImagemPixCitel(AQrCodePix) + '"></p>';

    If Not ALinkCitelPix.IsEmpty Then
    Begin
      If Not ALinkCitelPix.Contains('https://pix.citelsoftware.com.br/') Then
        ALinkCitelPix :=  'https://pix.citelsoftware.com.br/' + ALinkCitelPix;

      Result := Result + '<p>Link para Pix Copia e Cola: <a href="' + ALinkCitelPix + '">' + ALinkCitelPix + '</a></p>';
    End;

    Result := Result +  '<p>Para pagamento através do código (Pix Copia e Cola): <br>' +
                        '<textarea readonly style="text-decoration: underline; resize: none;" rows="4" cols="' + Trunc((AQrCodePix.Length + 3) / 3).ToString + '">' + AQrCodePix + '</textarea></p>';
  End
  Else
  Begin
    Result := AQrCodePix;

    If Not ALinkCitelPix.IsEmpty Then
    Begin
      Result := ALinkCitelPix;

      If Not Result.Contains('https://pix.citelsoftware.com.br/') Then
        Result := 'https://pix.citelsoftware.com.br/' + ALinkCitelPix;
    End;
  End;
End;

function fDisparaEmailSimples(strNumDoc,
                                 strOpcDoc,
                                 strEspDoc,
                                 strNumOrc,
                                 strEspOrc,
                                 strEmpOri,
                                 strCodDes: String;
                                 AQrCodePix: String = '';
                                 ALinkCitelPix: String = ''): Boolean;
begin
  Result := fDisparaEmailAutomatico(strNumDoc, strOpcDoc, strEspDoc, strNumOrc, strEspOrc, strEmpOri,  strCodDes, AQrCodePix, ALinkCitelPix);
end;

function fDisparaEmailAutomatico(strNumDoc,
                                 strOpcDoc,
                                 strEspDoc,
                                 strNumOrc,
                                 strEspOrc,
                                 strEmpOri,
                                 strCodCli : String;
                                 AQrCodePix: String = '';
                                 ALinkCitelPix: String = '';
                                 objGeraAnexo : IGeraArquivoAnexoEmailAutomatico = Nil;
                                 strCodCup: String = '';
                                 strAutInc: String = '';
                                 strFisAcesso: String = '';
                                 strSerie_: String = '';
                                 strAutIncNotfic: String = '';
                                 strCodOpe: String = '';
                                 blnResultTrueCasoEmailEmBranco: Boolean = False;
                                 blnResultTrueCasoGatilhoDesativado: Boolean = False;
                                 const blnAssincrono: boolean = True;
                                 strInfAdi: String = '';
                                 strCodRastreio: String = ''): Boolean;
Var
  objEmaAut: TEmaAut;
  strSQL: String;
  qrySQL: TUniQuery;
  strEmail: String;
  blnDispararNaSequenciaGatilhoInclusaoDePedido: Boolean;
  lstArquivos: TList<TRecArquivosGatilhos>;
Begin
  Result := False;
  blnDispararNaSequenciaGatilhoInclusaoDePedido := False;

  If OperadorCitelLogado Then
    Exit;
  
  Try
    qrySQL := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  CLI_EMAIL_ AS EMAIL_, ';
    strSQL := strSQL + '  CLI_EMAIL2 AS EMAIL2, ';
    strSQL := strSQL + '  CLI_EMAIL3 AS EMAIL3, ';
    strSQL := strSQL + '  CONCAT(CID_NOMCID, "-", CID_ESTADO) AS NOMCID ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

    With qrySQL Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
    End;

    Try
      objEmaAut := TEmaAut.Create(Nil);
      objEmaAut.FNumDoc := strNumDoc;
      objEmaAut.FOpcDoc := strOpcDoc;
      objEmaAut.FEspDoc := strEspDoc;
      objEmaAut.FNumOrc := strNumOrc;
      objEmaAut.FEspOrc := strEspOrc;
      objEmaAut.FEmpOri := strEmpOri;
      objEmaAut.FEmpDoc := strEmpOri;
      objEmaAut.FCodCli := strCodCli;
      objEmaAut.strCodCup := strCodCup;
      objEmaAut.FAutInc := strAutInc;
      objEmaAut.FFisAce := strFisAcesso;
      objEmaAut.FSerie_ := strSerie_;
      objEmaAut.FAssincrono := blnAssincrono;
      objEmaAut.FCodRas := strCodRastreio;

      objEmaAut.FCodCli := strCodCli;
      objEmaAut.FNomCli := qrySQL.FieldByName('NOMCLI').AsString;

      objEmaAut.strInfAdi := strInfAdi;

      If fClienteConsumidor(qrySQL.FieldByName('NOMCLI').AsString) Then
      Begin
        objEmaAut.FNomCli := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strEmpOri, 'NOMCON');
        If fEmptyStr(objEmaAut.FNomCli) Then
          objEmaAut.FNomCli := qrySQL.FieldByName('NOMCLI').AsString;
      End;

      objEmaAut.FPriCli := fRetPrimeiraPalavra(objEmaAut.FNomCli);

      If objEmaAut.fEhEnvioDeXmlDeNfParaFornecedor Then
        objEmaAut.FEmaCli := objEmaAut.fRetEmailParaEnvioDoXmlAoFornecedor
      Else If objEmaAut.fEhEnvioDeXmlDeNfParaTransportadora Then
      Begin
        objEmaAut.FEmaCli := objEmaAut.fRetEmailParaEnvioDoXmlATransportadora;
      End
      Else If fClienteConsumidor(qrySQL.FieldByName('NOMCLI').AsString) Then
      Begin
        strEmail := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strEmpOri, 'EMLCON');

        If (fEmailValido(strEmail, False)) Then
          objEmaAut.FEmaCli := strEmail
        Else
          objEmaAut.FEmaCli := Trim(qrySQL.FieldByName('EMAIL_').AsString);
      End
      Else
      Begin
        objEmaAut.FEmaCli := '';
        strEmail := Trim(qrySQL.FieldByName('EMAIL_').AsString);

        If (fEmailValido(strEmail, False)) Then
          objEmaAut.FEmaCli := strEmail;

        strEmail := Trim(qrySQL.FieldByName('EMAIL2').AsString);

        If (fEmailValido(strEmail, False)) Then
        Begin
          If (fEmptyStr(objEmaAut.FEmaCli)) Then
            objEmaAut.FEmaCli := strEmail
          Else
          Begin
            If (Pos(strEmail, objEmaAut.FEmaCli) <= 0) Then
            Begin
              If (objEmaAut.FEmaCli[Length(objEmaAut.FEmaCli)] = ';' ) Then
                objEmaAut.FEmaCli := objEmaAut.FEmaCli + strEmail
              Else
                objEmaAut.FEmaCli := objEmaAut.FEmaCli + ';' + strEmail;
            End;
          End;
        End;

        strEmail := Trim(qrySQL.FieldByName('EMAIL3').AsString);

        If (fEmailValido(strEmail, False)) Then
        Begin
          If (fEmptyStr(objEmaAut.FEmaCli)) Then
            objEmaAut.FEmaCli := strEmail
          Else
          Begin
            If (Pos(strEmail, objEmaAut.FEmaCli) <= 0) Then
            Begin
              If (objEmaAut.FEmaCli[Length(objEmaAut.FEmaCli)] = ';' ) Then
                objEmaAut.FEmaCli := objEmaAut.FEmaCli + strEmail
              Else
                objEmaAut.FEmaCli := objEmaAut.FEmaCli + ';' + strEmail;
            End;
          End;
        End;
      End;

      objEmaAut.FCidCli := qrySQL.FieldByName('NOMCID').AsString;
      objEmaAut.FTransp := '';
      objEmaAut.FCodOpe := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);

      objEmaAut.QrCodePix := RetonaQRCodePixPedido(AQrCodePix, ALinkCitelPix);

      objEmaAut.FAutIncNotfic := strAutIncNotfic;

      If (blnResultTrueCasoEmailEmBranco) and (fEmptyStr(objEmaAut.FEmaCli)) then
        Exit(True);

      repeat
        {*************************************************************************************}
        {* Verifica se o gatilho anterior foi de transformação de OR para PD,                *}
        {* Se foi, dispara na sequência o gatilho de inclusão de pedido                      *}
        {**********************************************************************************BL*}
        if blnDispararNaSequenciaGatilhoInclusaoDePedido then
        begin
          objEmaAut.FCodGru := '002';
          objEmaAut.FCodigo := '001';
          objEmaAut.FEspOrc := EmptyStr;
          objEmaAut.FNumOrc := EmptyStr;
        end;

        If (objEmaAut.fTemEmailAtivo) Then
        Begin
          If ((objEmaAut.fEnviaArquivo) or (objEmaAut.fEnviaArquivoXML)) and (Assigned(objGeraAnexo)) Then
          Begin
            try
              objGeraAnexo.EnviaArquivoPdf := objEmaAut.fEnviaArquivo;
              objGeraAnexo.EnviaArquivoXml := objEmaAut.fEnviaArquivoXML;

              lstArquivos := objGeraAnexo.fGeraArquivoAnexo(True);
              try
                objEmaAut.FArquiv := lstArquivos.ToArray;
              finally
                FreeAndNil(lstArquivos);
              end;

              If Length(objEmaAut.FArquiv) = 0 then
                Exit(False);
            except
              Exit(False);
            end;
          End;

          Result := objEmaAut.fEnviaEmailAutomatico;
        End
        Else if blnResultTrueCasoGatilhoDesativado then
          Result := True;

      until not fTemDisparoDeOutroGatilhoNaSequencia(objEmaAut.FCodigo,
                                                     objEmaAut.FCodGru,
                                                     Result,
                                                     blnDispararNaSequenciaGatilhoInclusaoDePedido);

    Finally
      FreeAndNil(objEmaAut);
    End;

  Finally
    FreeAndNil(qrySQL);
  End;
End;

function fDisparaEmailBoletoAutomatico(objDados : TDadosDisparaEmail;
                                       strOpcDoc: String = 'BO';
                                       objStatus: TStatusDisparaEmail = untTypesSistema.staNenhumaAcao;
                                       blnAssincrono: Boolean = False): Boolean;
Var
  objEmaAut  : TEmaAut;
  LobjEmailContaReceberBuilder : TEmailContaReceberBuilder;

  function fMontaArrayTabelaDuplicatas( strNumDoc, strCodEmp, strEspDoc, strCodCli : String ) : TArrDupTabelaEmail;
    Var
      strSQL: String;
      qrySQL: TUniQuery;
      arrDupT: TArrDupTabelaEmail;
  Begin

    Try
      qrySQL := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '   CTR_NUMDUP, ';
      strSQL := strSQL + '   CTR_PARCEL, ';
      strSQL := strSQL + '   CTR_ESPDOC, ';
      strSQL := strSQL + '   CTR_CODEMP, ';
      strSQL := strSQL + '   CTR_DTACAD, ';
      strSQL := strSQL + '   CTR_DTAVEN, ';
      strSQL := strSQL + '   CTR_VALDUP, ';
      strSQL := strSQL + '   CTR_CODCLI, ';
      strSQL := strSQL + '   CTR_LINDIG, ';
      strSQL := strSQL + '   AUTOINCREM  ';
      strSQL := strSQL + '  FROM CADREC  ';
      strSQL := strSQL + ' WHERE CTR_NUMDUP = :NUMDUP ';
      strSQL := strSQL + '   AND CTR_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '   AND CTR_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND CTR_CODCLI = :CODCLI ';

      With qrySQL Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        SetLength(arrDupT,0);

        If Not IsEmpty Then
        Begin

          qrySQL.First;
          While Not qrySQL.Eof Do
          Begin
              SetLength(arrDupT,Length(arrDupT)+1);
              arrDupT[Length(arrDupT)-1].strNumDoc := qrySQL.FieldByName('CTR_NUMDUP').AsString;
              arrDupT[Length(arrDupT)-1].strParcel := qrySQL.FieldByName('CTR_PARCEL').AsString;
              arrDupT[Length(arrDupT)-1].strEspDoc := qrySQL.FieldByName('CTR_ESPDOC').AsString;
              arrDupT[Length(arrDupT)-1].strCodEmp := qrySQL.FieldByName('CTR_CODEMP').AsString;
              arrDupT[Length(arrDupT)-1].strCodCli := qrySQL.FieldByName('CTR_CODCLI').AsString;
              arrDupT[Length(arrDupT)-1].dtaDtaCad := qrySQL.FieldByName('CTR_DTACAD').AsDatetime;
              arrDupT[Length(arrDupT)-1].dtaDtaVen := qrySQL.FieldByName('CTR_DTAVEN').AsDatetime;
              arrDupT[Length(arrDupT)-1].fltVlrDup := qrySQL.FieldByName('CTR_VALDUP').AsFloat;
              arrDupT[Length(arrDupT)-1].strAutoIn := qrySQL.FieldByName('AUTOINCREM').AsString;
              arrDupT[Length(arrDupT)-1].strLinDig := qrySQL.FieldByName('CTR_LINDIG').AsString;

              Application.ProcessMessages;

            qrySQL.Next;
          End;

        End;

      End;

      Result := arrDupT;

    Finally
      FreeAndNil(qrySQL);
    End;

  End;

Begin

  Result := False;

  If OperadorCitelLogado Then
    Exit;

  If Not VS_PermitidoEnviarEmail Then
    Raise ExceptionAutcom.Create('Não é permitido enviar e-mail nesse banco de dados!');

  Try
    objEmaAut := TEmaAut.Create(Nil);
    objEmaAut.FOpcDoc := strOpcDoc;
    objEmaAut.FStatus := objStatus;

    If (objEmaAut.fTemEmailAtivo) Then
    Begin
      LobjEmailContaReceberBuilder := TEmailContaReceberBuilder.Create;
      Try
        LobjEmailContaReceberBuilder.strNumeroDuplicata := objDados.strNumDoc;
        LobjEmailContaReceberBuilder.strEspecie         := objDados.strEspDoc;
        LobjEmailContaReceberBuilder.strCodigoEmpresa   := objDados.strCodEmp;
        LobjEmailContaReceberBuilder.strParcela         := objDados.strParcel;
        LobjEmailContaReceberBuilder.strCodigooOperador := strLoginUsuarioLogado;
        LobjEmailContaReceberBuilder.blnEmailEnviado    := False;

        Result := LobjEmailContaReceberBuilder.fGravar;
        if not Result then
          Exit;

      Finally
        FreeAndNil(LobjEmailContaReceberBuilder);
      End;

      objEmaAut.FNomCli   := fRetNomCliente(objDados.strCodCli);
      objEmaAut.FCodCli   := objDados.strCodCli;
      objEmaAut.FPriCli   := fRetPrimeiraPalavra(objEmaAut.FNomCli);
      objEmaAut.FCidCli   := fRetNomCidade(fRetCodCidByCliente(objDados.strCodCli));
      objEmaAut.FTransp   := '';
      objEmaAut.FCodOpe   := strLoginUsuarioLogado;
      objEmaAut.FNumDoc   := objDados.strNumDoc;
      objEmaAut.FEspDoc   := objDados.strEspDoc;
      objEmaAut.FEmpDoc   := objDados.strCodEmp;
      objEmaAut.FNumOrc   := objDados.strNumOrc;
      objEmaAut.FEspOrc   := objDados.strEspOrc;
      objEmaAut.FEmpOri   := objDados.strEmpOri;
      objEmaAut.FEmaCli   := objDados.strEmailCli;
      objEmaAut.FArquiv   := objDados.RecArquivos;
      objEmaAut.strLinDig := objDados.strLinhaDigitavel;
      objEmaAut.strDtaEmi := objDados.strDtaEmi;
      objEmaAut.strValDup := objDados.strValDup;
      objEmaAut.strParcel := objDados.strParcel;
      objEmaAut.strDtaVen := objDados.strDtaVen;
      objEmaAut.DiasVencimento := objDados.DiasVencimento;
      objEmaAut.strCorpoAdicional := objDados.strCorpoAdicional;
      objEmaAut.FArrDup   := objDados.arrDupTabela;
      objEmaAut.FAssincrono := blnAssincrono;

      If Not objDados.QRCodePix.Trim.IsEmpty Then
      Begin
        objEmaAut.QrCodePix := 'Pagamento por Pix:<br>' +
                               '<p><img src="' + RetornaLinkImagemPixCitel(objDados.QRCodePix) + '"></p>';

        If Not objDados.LinkCitelPix.IsEmpty Then
          objEmaAut.QrCodePix := objEmaAut.QrCodePix + '<p>Link para Pix Copia e Cola: <a href="' + objDados.LinkCitelPix + '">' + objDados.LinkCitelPix + '</a></p>';

        objEmaAut.QrCodePix := objEmaAut.QrCodePix +  '<p>Para pagamento através do código (Pix Copia e Cola): <br>' +
                                                      '<textarea readonly style="text-decoration: underline; resize: none;" rows="4" cols="' + Trunc((objDados.QRCodePix.Length + 3) / 3).ToString + '">' + objDados.QRCodePix + '</textarea></p>';
      End;

      Result := objEmaAut.fEnviaEmailAutomatico;
    End;
  Finally
    FreeAndNil(objEmaAut);
  End;
End;

procedure pGetMensagemEMASAI(Var FCorpo: TStringArray;
                             Var FAssunto: String;
                             objDados : TDadosDisparaEmail;
                             strOpcDoc: String;
                             objStatus: TStatusDisparaEmail;
                             var ADadosLogin: TDadosLoginEmail;
                             var ACodigoGrupoModelo: String;
                             var ACodigoModelo: String);

  Var
    objEmaAut  : TEmaAut;
Begin

  Try
    objEmaAut := TEmaAut.Create(Nil);
    objEmaAut.FOpcDoc := strOpcDoc;
    objEmaAut.FStatus := objStatus;

    objEmaAut.FNomCli   := fRetNomCliente(objDados.strCodCli);
    objEmaAut.FCodCli   := objDados.strCodCli;
    objEmaAut.FPriCli   := fRetPrimeiraPalavra(objEmaAut.FNomCli);
    objEmaAut.FCidCli   := fRetNomCidade(fRetCodCidByCliente(objDados.strCodCli));
    objEmaAut.FTransp   := '';
    objEmaAut.FCodOpe   := strLoginUsuarioLogado;
    objEmaAut.FNumDoc   := objDados.strNumDoc;
    objEmaAut.FEspDoc   := objDados.strEspDoc;
    objEmaAut.FEmpDoc   := objDados.strCodEmp;
    objEmaAut.FNumOrc   := objDados.strNumOrc;
    objEmaAut.FEspOrc   := objDados.strEspOrc;
    objEmaAut.FEmpOri   := objDados.strEmpOri;
    objEmaAut.FEmaCli   := objDados.strEmailCli;
    objEmaAut.FArquiv   := objDados.RecArquivos;
    objEmaAut.strLinDig := objDados.strLinhaDigitavel;
    objEmaAut.strDtaEmi := objDados.strDtaEmi;
    objEmaAut.strValDup := objDados.strValDup;
    objEmaAut.strParcel := objDados.strParcel;
    objEmaAut.strDtaVen := objDados.strDtaVen;
    objEmaAut.ArrDup    := objDados.arrDupTabela;

    If Not objDados.QRCodePix.IsEmpty Then
    Begin
      objEmaAut.QrCodePix := 'Pagamento por Pix:<br>' +
                             '<p><img src="' + RetornaLinkImagemPixCitel(objDados.QRCodePix) + '"></p>' +
                             '<p>Valor: ' + objDados.strValDup + '</p>';
      If Not objDados.LinkCitelPix.IsEmpty Then
        objEmaAut.QrCodePix := objEmaAut.QrCodePix + '<p>Link para Pix Copia e Cola: <a href="' + objDados.LinkCitelPix + '">' + objDados.LinkCitelPix + '</a></p>';

      objEmaAut.QrCodePix := objEmaAut.QrCodePix + '<p>Para pagamento através do código (Pix Copia e Cola):<br>' +
                                                   '<textarea readonly style="text-decoration: underline; resize: none;" rows="4" cols="' + Trunc((objDados.QRCodePix.Length + 3) / 3).ToString + '">' + objDados.QRCodePix + '</textarea></p>';
    End;

    FCorpo   := objEmaAut.fGetCorpoMensagem;
    FAssunto := objEmaAut.fGetAssuntoMensagem;

    ACodigoGrupoModelo := objEmaAut.FCodGru;
    ACodigoModelo := objEmaAut.FCodigo;

    objEmaAut.CarregaDadosProvedorDoModelo;

    ADadosLogin.Senha := objEmaAut.strSenha;
    ADadosLogin.Email := objEmaAut.strEmail;
    ADadosLogin.Login := objEmaAut.strLogin;
    ADadosLogin.Remetente := objEmaAut.strRemete;

    ADadosLogin.Provedor := objEmaAut.intCodPrv;
    ADadosLogin.ServidorSMTP := objEmaAut.strSerSmt;
    ADadosLogin.ServidorImap := objEmaAut.strSerIma;
    ADadosLogin.PortaSMTP := objEmaAut.intPorSmt;
    ADadosLogin.PortaImap := objEmaAut.intPorIma;
    ADadosLogin.LimiteArquivos := objEmaAut.intLimArq;
    ADadosLogin.TipoProvedor       := objEmaAut.strProved;

    ADadosLogin.ImagemAssinatura := objEmaAut.blnImgAss;
    ADadosLogin.TextoAssinatura := objEmaAut.strTxtAss;

    If ADadosLogin.ImagemAssinatura Then
    Begin
      ADadosLogin.ImagemAssinaturaStream := TMemoryStream.Create;
      objEmaAut.mmsImaAss.SaveToStream(ADadosLogin.ImagemAssinaturaStream);
      ADadosLogin.ImagemAssinaturaStream.Seek(0,soFromBeginning);
    End;

    ADadosLogin.GravaPastaEnviados := objEmaAut.strGravaPastaEnviados;

    ADadosLogin.AutenticacaoSSL := objEmaAut.blnSSLSai;
    ADadosLogin.AutenticacaoSSLImap := objEmaAut.blnSSLSai;
  Finally
    FreeAndNil(objEmaAut);
  End;
End;

function RetornaValorSemZerosEsquerdaSMS(AValor: String): String;
  Var
    LInteiro: Int64;
Begin
  Result := AValor;

  If TryStrToInt64(Result, LInteiro) Then
    Result := IntToStr(LInteiro);
End;

function fRetornaNosNum(strCodBco, strLindig: String): String;
begin
  if strCodBco = '033' then
  begin
    Result := Copy(strLindig, 19, 2) + Copy(strLindig, 22, 6);
  end;

  if strCodBco = '756' then
  begin
    Result := Copy(strLindig, 20, 1) + Copy(strLindig, 22, 7);
  end;

  if strCodBco = '341' then
  begin
    Result := Copy(strLindig, 8, 2) + Copy(strLindig, 11, 7);
  end;

  if strCodBco = '748' then
  begin
    Result := Copy(strLindig, 7, 3) + Copy(strLindig, 11, 6);
  end;

  if strCodBco = '389' then
  begin
    Result := Copy(strLindig, 9, 1) + Copy(strLindig, 11, 10);
  end;

  if strCodBco = '422' then
  begin
    Result := Copy(strLindig, 22, 9);
  end;
end;

function fRetornarDataEntregaRota(strCodRot: String): TDate;
begin
  Result := fCampoTabela('ENT_DTAENT', 'ENTREG', ['ENT_CODIGO'], [strCodRot]);
end;

function fVerificarSeEnviaWhatsappParaCliente(const strOpcDoc, strEspOrc: String): Boolean;
begin
  Result := True;

  if MatchStr(Concat(strOpcDoc, strEspOrc), ['PRFP']) then
    Exit(False);
end;

function fDisparaWhatsappSimples(strNumDoc,
                                 strOpcDoc,
                                 strEspDoc,
                                 strNumOrc,
                                 strEspOrc,
                                 strEmpOri,
                                 strCodDes: String;
                                 AQrCodePix: String = ''): Boolean;
begin
  Result := fDisparaWhatsappAutomatico(strNumDoc, strOpcDoc, strEspDoc, strNumOrc, strEspOrc, strEmpOri,  strCodDes, AQrCodePix);
end;

function fDisparaWhatsappAutomatico(strNumDoc,
                                    strOpcDoc,
                                    strEspDoc,
                                    strNumOrc,
                                    strEspOrc,
                                    strEmpOri,
                                    strCodDes: String;
                                    AQrCodePix: String = '';
                                    const blnAssincrono: boolean = True;
                                    strCodCup: String = '';
                                    objGeraAnexo : IGeraArquivoAnexoEmailAutomatico = Nil;
                                    strAutInc: String = '';
                                    strFisAcesso: String = '';
                                    strSerie_: String = '';
                                    strUnitDisparo: String = '';
                                    strAutIncCtt: String = '';
                                    strCelularEnv: String = '';
                                    strFilaEnv: String = '';
                                    strAutIncNotfic: String = '';
                                    strCodigoDoServico: String = '';
                                    strCodigoStatusServico: String = '';
                                    blnResultTrueCasoCelularEmBranco: Boolean = False;
                                    blnResultTrueCasoGatilhoDesativado: Boolean = False;
                                    DestinatarioWhatsapp: TDestinatarioWhatsapp = nil;
                                    strInfAdi: String = '';
                                    strLinkPagamento: String = '';
                                    recArquivos: TArray<TRecArquivosGatilhos> = nil;
                                    strCodIte: String = '';
                                    strCodRastreio: String = ''): Boolean;
begin
  Result := False;

  if fVerificarSeEnviaWhatsappParaCliente(strOpcDoc, strEspOrc) then
  begin
    if not fEnviaWhatsappParaCliente(strCodDes) then
      Exit(IIF(not fEmptyStr(strAutIncNotfic), True, False));
  end;

  if OperadorCitelLogado then
    Exit;

  if fCfgSis('UTIWPP', varBoolean) then
    Result := fDisparaSMSAutomatico(strNumDoc,
                                    strOpcDoc,
                                    strEspDoc,
                                    strNumOrc,
                                    strEspOrc,
                                    strEmpOri,
                                    strCodDes,
                                    AQrCodePix,
                                    blnAssincrono,
                                    strCodCup,
                                    objGeraAnexo,
                                    True,
                                    strAutInc,
                                    strFisAcesso,
                                    strSerie_,
                                    strUnitDisparo,
                                    strAutIncCtt,
                                    strCelularEnv,
                                    strFilaEnv,
                                    strAutIncNotfic,
                                    strCodigoDoServico,
                                    strCodigoStatusServico,
                                    blnResultTrueCasoCelularEmBranco,
                                    blnResultTrueCasoGatilhoDesativado,
                                    DestinatarioWhatsapp,
                                    strInfAdi,
                                    strLinkPagamento,
                                    recArquivos,
                                    strCodIte,
                                    strCodRastreio);
end;

procedure pRetQryCadCli(qrySQL: TUniQuery; const strCodCli: String);
begin
  qrySQL.Close;
  qrySQL.SQL.Text :=
  ' SELECT '+
  '   CLI_NOMCLI AS NOMDES, '+
  '   CLI_CELULA AS CELULA, '+
  '   CONCAT(CID_NOMCID, "-", CID_ESTADO) AS NOMCID '+
  ' FROM '+
  '   CADCLI '+
  ' LEFT JOIN CADCID '+
  '   ON CID_CODCID = CLI_CODCID ' +
  ' WHERE '+
  '   CLI_CODCLI = :CODCLI ';
  qrySQL.ParamByName('CODCLI').AsString := strCodCli;
  qrySQL.Open;
end;

procedure pRetQryDocumento(qrySQL: TUniQuery; const strOpcDoc, strNumDoc, strEspDoc, strCodCli, strCodEmp: String);
var
  strTabela: String;
  strCampo: String;
  strCampoAux: String;
  strSQL: String;
  blnEhClienteConsumidor: Boolean;
begin
  strTabela := IIF(Pos(strEspDoc, 'PD_OR_') > 0, 'FATGOR', 'MOVGER');
  strCampo := IIF(Pos(strEspDoc, 'PD_OR_') > 0, 'FGO_', 'GER_');
  strCampoAux := IIF(Pos(strEspDoc, 'PD_OR_') > 0, 'FGO_', 'AUX_');

  blnEhClienteConsumidor := fClienteConsumidor(fRetNomCliente(strCodCli), True, False);

  strSQL := '';
  strSQL := strSQL + 'SELECT        ';

  if (not blnEhClienteConsumidor) then
  begin
    strSQL := strSQL + '  CLI_NOMCLI AS NOMDES, ';
    strSQL := strSQL + '  CLI_CELULA AS CELULA, ';
  end
  else
  begin
    strSQL := strSQL + '  '+strCampo+'NOMCON AS NOMDES, ';
    strSQL := strSQL + '  '+strCampoAux+'CELCON AS CELULA, ';
  end;

  strSQL := strSQL + '  CONCAT(CID_NOMCID, "-", CID_ESTADO) AS NOMCID ';

  strSQL := strSQL + ', '+ strCampo+'CODVEN AS CODVEN ';

  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL +    strTabela;

  if not blnEhClienteConsumidor then
  begin
    strSQL := strSQL + '  LEFT JOIN CADCLI ON '+strCampo+'CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  end
  else
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = '+strCampo+'CIDCON ';

  if strTabela = 'FATGOR' then
    strSQL := strSQL + '  INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO '
  else if strTabela = 'MOVGER' then
    strSQL := strSQL + '  INNER JOIN AUXMOV ON MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER ';

  strSQL := strSQL + 'WHERE    ';

  strSQL := strSQL + '  '+strCampo+'NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  '+strCampo+'ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  '+strCampo+'CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  '+strCampo+'CODEMP = :CODEMP ';

  qrySQL.Close;
  qrySQL.SQL.Text := strSQL;
  qrySQL.ParamByName('NUMDOC').AsString := strNumDoc;
  qrySQL.ParamByName('ESPDOC').AsString := strEspDoc;
  qrySQL.ParamByName('CODCLI').AsString := strCodCli;
  qrySQL.ParamByName('CODEMP').AsString := strCodEmp;
  qrySQL.Open;

  if (qrySQL.IsEmpty) and (strTabela = 'MOVGER') then
  begin
    qrySQL.Close;
    qrySQL.SQL.Text := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
    qrySQL.ParamByName('NUMDOC').AsString := strNumDoc;
    qrySQL.ParamByName('ESPDOC').AsString := strEspDoc;
    qrySQL.ParamByName('CODCLI').AsString := strCodCli;
    qrySQL.ParamByName('CODEMP').AsString := strCodEmp;
    qrySQL.Open;
  end;
end;

function fSqlCadCli(const strOpcDoc, strEspOrc: String): Boolean;
begin
  Result := False;


  if MatchStr(Concat(strOpcDoc, strEspOrc), ['CFPC']) then
    Exit(True);

  if MatchStr(strOpcDoc, ['LP', 'CL']) then
    Exit(True);
end;

function fSqlDoc(const strOpcDoc, strEspOrc: String): Boolean;
begin
  Result := True;

  if MatchStr(Concat(strOpcDoc, strEspOrc), ['PRFP']) then
    Exit(False);
end;

procedure pRetQrySQL(qrySQL: TUniQuery; const strOpcDoc, strNumDoc, strEspDoc, strEspOrc, strCodDes, strCodEmp: String);
begin
  if fSqlCadCli(strOpcDoc, strEspOrc) then
    pRetQryCadCli(qrySQL, strCodDes)
  else if fSqlDoc(strOpcDoc, strEspOrc) then
    pRetQryDocumento(qrySQL, strOpcDoc, strNumDoc, strEspDoc, strCodDes, strCodEmp);
end;

function fDisparaSMSAutomatico(strNumDoc,
                               strOpcDoc,
                               strEspDoc,
                               strNumOrc,
                               strEspOrc,
                               strEmpOri,
                               strCodDes: String;
                               AQrCodePix: String = '';
                               const blnAssincrono: boolean = True;
                               strCodCup: String = '';
                               objGeraAnexo : IGeraArquivoAnexoEmailAutomatico = Nil;
                               blnEnviarWhatsapp: Boolean = False;
                               strAutInc: String = '';
                               strFisAcesso: String = '';
                               strSerie_: String = '';
                               strUnitDisparo: String = '';
                               strAutIncCtt: String = '';
                               strCelularEnv: String = '';
                               strFilaEnv: String = '';
                               strAutIncNotfic: String = '';
                               strCodigoDoServico: String = '';
                               strCodigoStatusServico: String = '';
                               blnResultTrueCasoCelularEmBranco: Boolean = False;
                               blnResultTrueCasoGatilhoDesativado: Boolean = False;
                               DestinatarioWhatsapp: TDestinatarioWhatsapp = nil;
                               strInfAdi: String = '';
                               strLinkPagamento: String = '';
                               recArquivos: TArray<TRecArquivosGatilhos> = nil;
                               strCodIte: String = '';
                               strCodRastreio: String = ''): Boolean;
  Var
    objSmsAut: TSMSAut;
    qrySQL: TUniQuery;
    blnDispararNaSequenciaGatilhoInclusaoDePedido: Boolean;
    lstArquivos: TList<TRecArquivosGatilhos>;
Begin
  Result := False;
  blnDispararNaSequenciaGatilhoInclusaoDePedido := False;

  if OperadorCitelLogado then
    Exit;

  qrySQL := fCriaQuery(Nil);
  Try
    pRetQrySQL(qrySQL, strOpcDoc, strNumDoc, strEspDoc, strEspOrc, strCodDes, IIF(fEmptyStr(strEmpOri), VS_strCodEmp, strEmpOri));
    Try
      objSmsAut := TSMSAut.Create(Nil);
      objSmsAut.FNumDoc := strNumDoc;
      objSmsAut.FOpcDoc := strOpcDoc;
      objSmsAut.FEspDoc := strEspDoc;
      objSmsAut.FNumOrc := strNumOrc;
      objSmsAut.FEspOrc := strEspOrc;
      objSmsAut.FEmpOri := strEmpOri;
      objSmsAut.FEmpDoc := strEmpOri;
      objSmsAut.blnAssincrono := blnAssincrono;
      objSmsAut.FCodCup := strCodCup;
      objSmsAut.FAutInc := strAutInc;
      objSmsAut.FFisAce := strFisAcesso;
      objSmsAut.FSerie_ := strSerie_;
      objSmsAut.FArquiv := RecArquivos;
      objSmsAut.FCodRas := strCodRastreio;

      if not fEmptyStr(strCelularEnv) then
        objSmsAut.FTo := strCelularEnv
      else if Assigned(qrySQL.FindField('CELULA')) then
        objSmsAut.FTo := Trim(qrySQL.FieldByName('CELULA').AsString);

      objSmsAut.FCodCli := strCodDes;

      objSmsAut.FNomCli := 'CONSUMIDOR';
      If Assigned(qrySQL.FindField('NOMDES')) then
      begin
        objSmsAut.FNomCli := qrySQL.FieldByName('NOMDES').AsString;
        objSmsAut.FPriCli := fRetPrimeiraPalavra(qrySQL.FieldByName('NOMDES').AsString);
      end;

      If Assigned(qrySQL.FindField('NOMCID')) then
        objSmsAut.FCidCli := qrySQL.FieldByName('NOMCID').AsString;

      objSmsAut.FTransp := '';

      If Not AQrCodePix.IsEmpty Then
        objSmsAut.QrCodePix := AQrCodePix;
      objSmsAut.LinkPgamento := strLinkPagamento;
      objSmsAut.FWhatsApp := blnEnviarWhatsapp;
      objSmsAut.FUntDis := strUnitDisparo;
      objSmsAut.FAutIncCtt := strAutIncCtt;
      objSmsAut.FIDFila := strFilaEnv;

      if Assigned(qrySQL.FindField('CODVEN')) then
        objSmsAut.FCodVen := qrySQL.FieldByName('CODVEN').AsString;

      objSmsAut.FAutIncNotfic := strAutIncNotfic;

      objSmsAut.FCodSer := strCodigoDoServico;
      objSmsAut.FStaSer := strCodigoStatusServico;

      objSmsAut.strInfAdi := strInfAdi;

      if Assigned(DestinatarioWhatsapp) then
      begin
        objSmsAut.FAutIncCtt := DestinatarioWhatsapp.FAutIncCtt;
        if not fEmptyStr(DestinatarioWhatsapp.FTo) then
          objSmsAut.FTo := DestinatarioWhatsapp.FTo;
        objSmsAut.FIDFila := DestinatarioWhatsapp.FIDFila;
      end;

      objSmsAut.strCodIte := strCodIte;

      if (blnResultTrueCasoCelularEmBranco) and (fEmptyStr(objSmsAut.FTo)) then
        Exit(True);

      repeat
        {*************************************************************************************}
        {* Verifica se o gatilho anterior foi de transformação de OR para PD,                *}
        {* Se foi, dispara na sequência o gatilho de inclusão de pedido                      *}
        {**********************************************************************************BL*}
        if blnDispararNaSequenciaGatilhoInclusaoDePedido then
        begin
          objSmsAut.FCodGru := '002';
          objSmsAut.FCodigo := '001';
          objSmsAut.FEspOrc := EmptyStr;
          objSmsAut.FNumOrc := EmptyStr;
        end;

        If (objSmsAut.fTemModeloAtivo) Then
        Begin
          If (objSmsAut.fEnviaArquivo) and (Assigned(objGeraAnexo)) Then
          Begin
            try
              objGeraAnexo.EnviaArquivoPdf := objSmsAut.fEnviaArquivo;
              objGeraAnexo.EnviaArquivoXml := objSmsAut.fEnviaArquivoXML;

              lstArquivos := objGeraAnexo.fGeraArquivoAnexo(True);
              try
                if Length(objSmsAut.FArquiv) > 0 then
                  lstArquivos.AddRange(objSmsAut.FArquiv);

                objSmsAut.FArquiv := lstArquivos.ToArray;
              finally
                FreeAndNil(lstArquivos);
              end;

              If (Length(objSmsAut.FArquiv) = 0) and (fEnvioDeArquivoObrigatorio(strOpcDoc)) then
                Exit(False);
            except
              Exit(False);
            end;
          End;

          if (blnEnviarWhatsapp) then
          begin
            if (not Assigned(DestinatarioWhatsapp)) or
               ((Assigned(DestinatarioWhatsapp)) and (fEmptyStr(DestinatarioWhatsapp.FTo))) then
            begin
              if fRetFilaEContatoEnvio(objSmsAut.FAutIncCtt,
                                       objSmsAut.FTo,
                                       objSmsAut.FIDFila,
                                       objSmsAut.FCodCli,
                                       objSmsAut.FNomCli,
                                       objSmsAut.FCodigo,
                                       objSmsAut.FCodGru,
                                       objSmsAut.FAbreTelaEscolherContato) then
              begin
                if Assigned(DestinatarioWhatsapp) then
                begin
                  DestinatarioWhatsapp.FAutIncCtt := objSmsAut.FAutIncCtt;
                  DestinatarioWhatsapp.FTo := objSmsAut.FTo;
                  DestinatarioWhatsapp.FIDFila := objSmsAut.FIDFila;
                end;
              end
              else
                Exit;
            end;
          end;

          Result := objSmsAut.fEnviaSMSAutomatico;
        End
        Else if blnResultTrueCasoGatilhoDesativado then
          Result := True;

      until not fTemDisparoDeOutroGatilhoNaSequencia(objSmsAut.FCodigo,
                                                     objSmsAut.FCodGru,
                                                     Result,
                                                     blnDispararNaSequenciaGatilhoInclusaoDePedido);

    Finally
      FreeAndNil(objSmsAut);
    End;

  Finally
    FreeAndNil(qrySQL);
  End;
End;

function fTemDisparoDeOutroGatilhoNaSequencia(const strCodigo,
                                                    strCodGru: String;
                                              const blnGatilhoAtualFoiDisparado: Boolean;
                                                var blnDispararNaSequenciaGatilhoInclusaoDePedido: Boolean): Boolean;
begin
  Result := False;

  blnDispararNaSequenciaGatilhoInclusaoDePedido := ((MatchStr(Concat(strCodigo, strCodGru), ['003001'])) and (not blnGatilhoAtualFoiDisparado));
  if blnDispararNaSequenciaGatilhoInclusaoDePedido then
    Result := True;
end;

function fRetFilaEContatoEnvio(var strAutIncCtt: String;
                               var strCelular: String;
                               var strFilaEnv: String;
                                   strCodCli,
                                   strNomCli,
                                   strCodigoGatilho,
                                   strCodigoGrupoGatilho: String;
                                   blnAbreTela: Boolean): Boolean;
var
  frmFilaEContatoEnvio: TfrmFilaEContatoEnvio;
  intCount: Integer;
  arrCelular: TArray<String>;
begin
  Result := True;

  if not blnAbreTela then
    Exit;

  pCriarFormularios(TfrmFilaEContatoEnvio, frmFilaEContatoEnvio);
  try
    frmFilaEContatoEnvio.strCodigoCliente := strCodCli;
    frmFilaEContatoEnvio.strNomeCliente := strNomCli;
    frmFilaEContatoEnvio.strCelular := strCelular;
    frmFilaEContatoEnvio.strCodigoGatilho := strCodigoGatilho;
    frmFilaEContatoEnvio.strCodigoGrupoGatilho := strCodigoGrupoGatilho;
    frmFilaEContatoEnvio.ShowModal;
    if frmFilaEContatoEnvio.ModalResult = mrOk then
    begin
      strCelular := frmFilaEContatoEnvio.strCelularEscolhido;
      strAutIncCtt := frmFilaEContatoEnvio.strContatoEscolhido;

      arrCelular := strCelular.Split(['_']);
      if (not frmFilaEContatoEnvio.blnEscolherFila) and (not fEmptyStr(strCelular)) then
      begin
        for intCount := 0 to High(arrCelular) do
          strFilaEnv := strFilaEnv + IIF(fEmptyStr(strFilaEnv), '', '_') + FloatToStr(fRetFilaDeAtendimentoEmAndamento(strCelular));
      end;

      if fEmptyStr(strFilaEnv) then
        strFilaEnv := frmFilaEContatoEnvio.strFilaEnvEscolhida;
    end
    else
      Result := False;
  finally
    pFreeAndNil(frmFilaEContatoEnvio);
  end;
end;

function fRetFilaDeAtendimentoEmAndamento(strCelular: String): Extended;
var
  ReturnGetClientOpenChats: TReturnGetClientOpenChats;
begin
  Result := 0;

  ReturnGetClientOpenChats := TControllerGetClientOpenChats.fGetClientOpenChats(strCelular);

  if (Assigned(ReturnGetClientOpenChats)) and (ReturnGetClientOpenChats.openChats > 0) then
    Result := ReturnGetClientOpenChats.chats[0].queueId;
end;

function fEnvioDeArquivoObrigatorio(strOpcDoc: String): Boolean;
begin
  Result := (strOpcDoc <> 'TE');
end;

function fDisparaWhatsappBoletoAutomatico(objDados: TDadosDisparaSMS;
                                          strOpcDoc: String = 'BO';
                                          objStatus: TStatusDisparaEmail = staNenhumaAcao;
                                          DestinatarioWhatsapp: TDestinatarioWhatsapp = nil): Boolean;
begin
  Result := False;

  if fCfgSis('UTIWPP', varBoolean) then
    Result := fDisparaSMSBoletoAutomatico(objDados,
                                          strOpcDoc,
                                          objStatus,
                                          True,
                                          DestinatarioWhatsapp);
end;

function fDisparaSMSBoletoAutomatico(objDados: TDadosDisparaSMS;
                                     strOpcDoc: String = 'BO';
                                     objStatus: TStatusDisparaEmail = staNenhumaAcao;
                                     blnEnviaWhatsapp: Boolean = False;
                                     DestinatarioWhatsapp: TDestinatarioWhatsapp = nil): Boolean;
Var
  objSmsAut: TSMSAut;
Begin
  Result := False;

  Try
    objSmsAut := TSMSAut.Create(Nil);
    objSmsAut.FOpcDoc := strOpcDoc;
    objSmsAut.FStatus := objStatus;
    objSmsAut.FWhatsapp := blnEnviaWhatsapp;

    If (objSmsAut.fTemModeloAtivo) Then
    Begin
      objSmsAut.FCodCli := objDados.strCodCli;
      objSmsAut.FNomCli := fRetNomCliente(objDados.strCodCli);
      objSmsAut.FPriCli := fRetPrimeiraPalavra(objSmsAut.FNomCli);
      objSmsAut.FCidCli := fRetNomCidade(fRetCodCidByCliente(objDados.strCodCli));
      objSmsAut.FTransp := '';
      objSmsAut.FNumDoc := objDados.strNumDoc;
      objSmsAut.FEspDoc := objDados.strEspDoc;
      objSmsAut.FEmpDoc := objDados.strCodEmp;
      objSmsAut.FNumOrc := objDados.strNumOrc;
      objSmsAut.FEspOrc := objDados.strEspOrc;
      objSmsAut.FEmpOri := objDados.strEmpOri;
      objSmsAut.FTo     := objDados.strCelula;
      objSmsAut.FLinDig := objDados.strLinhaDigitavel;
      objSmsAut.FEmaCob := objDados.strEmaCob;
      objSmsAut.FDtaEmi := objDados.strDtaEmi;
      objSmsAut.FValDup := objDados.strValDup;
      objSmsAut.FParcel := objDados.strParcel;
      objSmsAut.FDtaVen := objDados.strDtaVen;
      objSmsAut.FLinkDoBoleto := objDados.strLinkDoBoleto;
      objSmsAut.FArquiv := objDados.RecArquivos;
      objSmsAut.FQrCodePix := Trim(objDados.QRCodePix);
      objSmsAut.DiasVencimento := objDados.DiasVencimento;

      if (blnEnviaWhatsapp) then
      begin
        if (not Assigned(DestinatarioWhatsapp)) or
           ((Assigned(DestinatarioWhatsapp)) and (fEmptyStr(DestinatarioWhatsapp.FTo))) then
        begin
          if (fRetFilaEContatoEnvio(objSmsAut.FAutIncCtt,
                                    objSmsAut.FTo,
                                    objSmsAut.FIDFila,
                                    objSmsAut.FCodCli,
                                    objSmsAut.FNomCli,
                                    objSmsAut.FCodigo,
                                    objSmsAut.FCodGru,
                                    objSmsAut.FAbreTelaEscolherContato)) then
          begin
            if Assigned(DestinatarioWhatsapp) then
            begin
              DestinatarioWhatsapp.FAutIncCtt := objSmsAut.FAutIncCtt;
              DestinatarioWhatsapp.FTo := objSmsAut.FTo;
              DestinatarioWhatsapp.FIDFila := objSmsAut.FIDFila;
            end;
          end
          else
            Exit;
        end
        else if Assigned(DestinatarioWhatsapp) then
        begin
          objSmsAut.FAutIncCtt := DestinatarioWhatsapp.FAutIncCtt;
          objSmsAut.FTo := DestinatarioWhatsapp.FTo;
          objSmsAut.FIDFila := DestinatarioWhatsapp.FIDFila;
        end;
      end;

      objSmsAut.fEnviaSMSAutomatico;
    End;
  Finally
    FreeAndNil(objSmsAut);
  End;
End;

function fValorTef(fltValor: Double): String;
begin
  Result := FloatToStrF(fltValor, ffFixed, 12, 2);
  Result := fTiraCaracter(Result);
end;

{******************************************************}
{* RETORNA UMA STRINGLIST COM OS VALORES DISTINTOS DE *}
{* DETERMINADO CAMPO DO DATASET PASSADO NO PARÂMETRO  *}
{***************************************************RP*}
function fDatasetDistinctField(objDataSet: TDataSet; strFieldName: String): TStringList;
  Var
    intPosicao: Integer;
    tmpAfterScroll: TDataSetNotifyEvent;
begin
  Result := TStringList.Create;
  Result.Sorted := True; //melhora o desempenho no IndexOf

  With objDataSet Do
  Begin
    intPosicao     := RecNo;
    tmpAfterScroll := AfterScroll;
    AfterScroll    := Nil;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        If Result.IndexOf(FieldByName(strFieldName).AsString) = -1 Then
          Result.Add(FieldByName(strFieldName).AsString);
        Next;
      End;
    Finally
      RecNo       := intPosicao;
      AfterScroll := tmpAfterScroll;
      EnableControls;
    End;
  End;
end;

{*******************************************************
 * DUPLICATAS TRAZIDAS DE OUTRO SISTEMA (CONVERTIDAS) **
 * SÃO APENAS PARA CONSULTAS NÃO PODENDO SER ESTORNADAS*
 *****************************REQ:157323*************MT*}
function fEhDuplicataOriginadaDeConverte(strNumDup: String = '';strParcel: String = '';
                                         strCodEmp: String = '';strForCli: String = '';
                                         strEspDoc: String = '';strSerie_: String = '';
                                         strTabela: String = '') : Boolean ;
  Var
    qryAux : TUniQuery;
Begin
  Try
    Result := False;
    Try
      qryAux := fCriaQuery(Nil);
      With qryAux Do
      Begin
        SQL.Clear;
        SQL.Add(fGetTextSqlConvertida(strTabela));

        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('FORCLI').AsString := strForCli;

        If (Pos('ESPDOC',SQL.Text) > 0)Then
          ParamByName('ESPDOC').AsString := strEspDoc;
        If (Pos('SERIE_',SQL.Text) > 0)Then
          ParamByName('SERIE_').AsString := strSerie_;
        Open;
        Result := RecordCount > 0;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fEhDuplicataOriginadaDeConverte]');
      End;
    End;
  Finally
    pFreeAndNil(qryAux);
  End;
End;


function fGetTextSqlConvertida(strTabela : String = ''): String;
Begin
  Result := '';
  If strTabela = 'CADREC' Then
  Begin
    Result := 'SELECT                          ' +
              '   *                            ' +
              ' FROM                           ' +
              '  CADREC                        ' +
              ' WHERE CTR_NUMDUP = :NUMDUP     ' +
              '   AND CTR_CODCLI = :FORCLI     ' +
              '   AND CTR_CODEMP = :CODEMP     ' +
              '   AND CTR_PARCEL = :PARCEL     ' +
              '   AND CTR_ESPDOC = :ESPDOC     ' +
              '   AND CTR_CODVEL IS NOT NULL   ' +
              '   AND CTR_DTAREC IS NOT NULL   ' +
              '   AND CTR_SEQCON = 0           ' +
              '   AND CTR_DTABAI IS NULL       ';
  End
  Else If strTabela = 'CADPAG' Then
  Begin
    Result := 'SELECT                          ' +
              '   *                            ' +
              ' FROM                           ' +
              '  CADPAG                        ' +
              ' WHERE CTP_NUMDUP = :NUMDUP     ' +
              '   AND CTP_CODFOR = :FORCLI     ' +
              '   AND CTP_CODEMP = :CODEMP     ' +
              '   AND CTP_PARCEL = :PARCEL     ' +
              '   AND IFNULL(CTP_SERIE_,"") = :SERIE_ ' +
              '   AND CTP_CODVEL IS NOT NULL   ' +
              '   AND CTP_DTAPAG IS NOT NULL   ' +
              '   AND IFNULL(CTP_SEQCON,0) = 0 ' +
              '   AND CTP_DTABAI IS NULL       ';
  End;
End;


function fRetSQLEspDocsNaoListadosNaExpedicao(Const strCampoEspDoc: String): String;
  Var
    strEspDoc: String;
begin
  strEspDoc := fTransform(fCfgSis('DOCEXP'),2);

  If Not fEmptyStr(strEspDoc) Then
    Result := strCampoEspDoc + ' NOT IN (' + fRetStrToSQLIn(strEspDoc) + ')'
  Else
    Result := 'TRUE';
end;

procedure AddSql(out ADateSet:TUniQuery;
                     ACondicao:Boolean;
                     ASql:String);
Begin
  If Not Assigned(ADateSet) Then
    Exit;

  If ACondicao Then
    TUniQuery(ADateSet).SQL.Text := TUniQuery(ADateSet).SQL.Text + ASql;

End;

function fValidaRecebimentoDeCreditoPorPortador(AstrNumeroDocumento,
                                                AstrEspecieDocumento,
                                                AstrEmpresaDocumento : String;
                                                var AMensagem : String;
                                                AParcelaDocumento : String = '';
                                                AClienteDocumento : String = '') : Boolean;
  var
    LQuery : TUniQuery;
begin
  Result := True;

  LQuery := fCriaQuery();
  Try
    {*****************************************************************************************************
    se estiver recebendo na função PD ou OR verifica se a forma de pagamento negociada deste documento possui
    credito à cliente com o portador sem permissão de  baixar no caixa. Se vier outra modalidade de documento,
    verifica direto na CADREC.Esee seria o caso onde o operador escolhe a modalidade de crédito direto no F11 e
    lá escolhe a nota de crédito que deseja utilizar.
    ****************************************************************************************************GD*}
    if Pos(AstrEspecieDocumento, 'PD_OR_') > 0  then
    Begin
      LQuery.Sql.Text := ' SELECT P.POR_BAIRCX '+
                         '   FROM FATGOR G '+
                         '   JOIN FPNCRE F ON F.FPN_SEQFGO = G.AUTOINCREM '+
                         '   JOIN CADREC C ON C.AUTOINCREM = F.FPN_SEQCTR '+
                         '   JOIN CADPOR P ON C.CTR_CODPOR = P.POR_CODPOR '+
                         '  WHERE G.FGO_NUMDOC = :NUMDOC '+
                         '    AND G.FGO_ESPDOC = :ESPDOC '+
                         '    AND G.FGO_CODEMP = :CODEMP ';
    End
    Else
    Begin
      LQuery.Sql.Text := ' SELECT P.POR_BAIRCX '+
                         '   FROM CADREC C '+
                         '   JOIN CADPOR P '+
                         '     ON C.CTR_CODPOR = P.POR_CODPOR '+
                         ' WHERE C.CTR_NUMDUP = :NUMDOC '+
                         '   AND C.CTR_ESPDOC = :ESPDOC '+
                         '   AND C.CTR_CODEMP = :CODEMP ';

      AddSql(LQuery,(Not fEmptyStr(AParcelaDocumento)),' AND C.CTR_PARCEL = :PARCEL ' );
      AddSql(LQuery,(Not fEmptyStr(AClienteDocumento)),' AND C.CTR_CODCLI = :CODCLI ' );

    End;

    LQuery.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
    LQuery.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
    LQuery.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;

    If Assigned(LQuery.Params.FindParam('CODCLI')) Then
      LQuery.ParamByName('CODCLI').AsString := AClienteDocumento;

    If Assigned(LQuery.Params.FindParam('PARCEL')) Then
      LQuery.ParamByName('PARCEL').AsString := AParcelaDocumento;

    LQuery.Open;
    if not LQuery.IsEmpty then
    Begin
      if LQuery.FieldByName('POR_BAIRCX').AsString = 'N' then
      Begin
        AMensagem := 'Portador não tem permissão para baixar no resumo de caixa!';
        Exit(False);
      End;
    End;
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;

End;

{ TEspecieParaArquivoRemessa }

constructor TEspecieParaArquivoRemessa.Create;
begin
  FDicEspIndex := TDictionary<String,String>.Create();
  FDicEspIndex.Add('NF', '0');
  FDicEspIndex.Add('IF', '1');
  FDicEspIndex.Add('MI', '2');
  FDicEspIndex.Add('FF', '3');
  FDicEspIndex.Add('AG', '4');
  FDicEspIndex.Add('NV', '5');
  FDicEspIndex.Add('NS', '6');
  FDicEspIndex.Add('CV', '7');
  FDicEspIndex.Add('SV', '8');
  FDicEspIndex.Add('CO', '9');
  FDicEspIndex.Add('AC', 'A');
  FDicEspIndex.Add('CT', 'B');
  FDicEspIndex.Add('NP', 'C');
  FDicEspIndex.Add('PA', 'D');
  FDicEspIndex.Add('RL', 'E');
  FDicEspIndex.Add('PD', 'F');
  FDicEspIndex.Add('TR', 'G');
end;

function TEspecieParaArquivoRemessa.fRetornaEspecieDoIndice(ACaracter: String): String;
Var
  LEspecie: String;
begin
  For LEspecie In FDicEspIndex.Keys Do
    If FDicEspIndex[LEspecie] = ACaracter Then
      Exit(LEspecie);
end;

function TEspecieParaArquivoRemessa.fRetornaEspeciesPermitidas: String;
  Var
    LEspecie: String;
begin
  Result := '';

  For LEspecie in FDicEspIndex.Keys Do
    Result := Result + LEspecie + '_';
end;

function TEspecieParaArquivoRemessa.fRetornaIndiceParaEspecie(
  AEspecie: String): String;
begin
  If Not FDicEspIndex.TryGetValue(AEspecie, Result) Then
    Raise Exception.Create('Espécie do documento não disponível para envio no arquivo de ' +
                           'remessa. Favor entrar em contato com a Citel imediatamente!');
end;

function TEspecieParaArquivoRemessa.fValidaEspecie(AEspecie: String): Boolean;
Var
  LIndice: String;
begin
  If Not FDicEspIndex.TryGetValue(AEspecie, LIndice) Then
  begin
    fMensagem('ATENÇÃO', 'Não foi possível exportar documentos com espécie diferente de ' +
                         'NF, IF, MI, FF, AG, NV, NS, CV, SV, CO, AC, NP, CT, RL, PD, TR ou PA!', ['&O k']);
    Result := False;
  end
  else
    Result := True;
end;

class function TEspecieParaArquivoRemessa.New: IEspecieParaArquivoRemessa;
begin
  Result := Self.Create;
end;

procedure TEspecieParaArquivoRemessa.pValidaEspecie(AEspecie: String);
Var
  LIndice: String;
begin
  If Not FDicEspIndex.TryGetValue(AEspecie, LIndice) Then
    Raise Exception.Create('Espécie do documento não disponível para envio no arquivo de ' +
                           'remessa. Favor entrar em contato com a Citel imediatamente!');
end;

class function TGravaAlteracaoDePortador.RetornaDataPortadorAnterior(ANumeroDocumento,
                                                                     AParcela,
                                                                     AEspecieDocumento,
                                                                     ACodigoEmpresa,
                                                                     ACodigoCliente,
                                                                     ASequencialBaixa: String): TDateTime;

  Var
    LConsulta: TUniQuery;
begin
  Result := 0;
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT MAX(AUX_DTATRO) AS DATA ' +
                          'FROM AUXREC ' +
                          'WHERE AUX_NUMDUP=:NUMDUP ' +
                          '  AND AUX_PARCEL=:PARCEL ' +
                          '  AND AUX_ESPDOC=:ESPDOC ' +
                          '  AND AUX_CODEMP=:CODEMP ' +
                          '  AND AUX_CODCLI=:CODCLI ' +
                          '  AND AUX_SEQBAI=:SEQBAI ';

    LConsulta.ParamByName('NUMDUP').AsString := ANumeroDocumento;
    LConsulta.ParamByName('PARCEL').AsString := AParcela;
    LConsulta.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('CODCLI').AsString := ACodigoCliente;
    LConsulta.ParamByName('SEQBAI').AsString := ASequencialBaixa;

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    If LConsulta.FieldByName('DATA').IsNull THen
      Exit;

    Result := LConsulta.FieldByName('DATA').AsDateTime;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class procedure TGravaAlteracaoDePortador.Salvar(PortadorAntigo, PortadorNovo,
                                                 NumDup, Parcel, EspDoc, CodEmp,
                                                 CodCli, SeqBai: string;
                                                 AVoltarDataPortador: Boolean = True;
                                                 ADataTrocaPortador: TDateTime = 0);
var
  strSQL   : String;
  qryGenPor: TUniQuery;
  LSalvar : Boolean;
begin
  if PortadorAntigo <> PortadorNovo then
  Begin
    LSalvar := fRetGeraTituloPDDPortador(PortadorNovo);
    If Not LSalvar Then
      LSalvar := fRetGeraTituloPDDPortador(PortadorAntigo);

    if LSalvar then
    begin
      If (ADataTrocaPortador = 0) Then
        ADataTrocaPortador := VS_Date;

      If (AVoltarDataPortador) Then
        If Not (fValidaPortadorDataPDD(PortadorNovo, CodEmp, ADataTrocaPortador, fCampoTabela('POR_TITPDD', 'CADPOR', ['POR_CODPOR'], [PortadorAntigo]) = 'S')) Then
        Begin
          fMensagem('', 'Operação cancelada!', ['&O k']);
          Abort
        End;

      strSQL := 'SELECT * FROM AUXREC WHERE FALSE';
      qryGenPor := fCriarQuery(strSQL, nil);

      try
        qryGenPor.Open;
        qryGenPor.Insert;

        qryGenPor.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('AUXREC', VS_strCodEmp);
        qryGenPor.FieldByName('AUX_DTATRO').AsDateTime := ADataTrocaPortador;
        qryGenPor.FieldByName('AUX_HRATRO').AsDateTime := fTime();
        qryGenPor.FieldByName('AUX_CODOPE').AsString   := strLoginUsuarioLogado;
        qryGenPor.FieldByName('AUX_ANTPOR').AsString   := PortadorAntigo;
        qryGenPor.FieldByName('AUX_ATUPOR').AsString   := PortadorNovo;
        qryGenPor.FieldByName('AUX_NUMDUP').AsString   := NumDup;
        qryGenPor.FieldByName('AUX_PARCEL').AsString   := Parcel;
        qryGenPor.FieldByName('AUX_ESPDOC').AsString   := EspDoc;
        qryGenPor.FieldByName('AUX_CODEMP').AsString   := CodEmp;
        qryGenPor.FieldByName('AUX_CODCLI').AsString   := CodCli;
        qryGenPor.FieldByName('AUX_SEQBAI').AsString   := SeqBai;

        qryGenPor.Post;
        qryGenPor.Close;
      finally
        FreeAndNil(qryGenPor);
      end;
    end;
  End;
end;

class procedure TGravaAlteracaoDePortador.SalvarManualmente(PortadorAntigo, PortadorNovo, NumDup, Parcel,
                                      EspDoc, CodEmp, CodCli, SeqBai: string;
                                      AVoltarDataPortador: Boolean = True;
                                      ADataTrocaPortador: TDateTime = 0);
begin
  TGravaAlteracaoDePortador.Salvar(PortadorAntigo, PortadorNovo, NumDup, Parcel,
                                                   EspDoc, CodEmp, CodCli, SeqBai,
                                                   AVoltarDataPortador,
                                                   AdataTrocaPortador);
end;

class procedure TGravaAlteracaoDePortador.SalvarBeforePost(DataSet: TDataSet);
var
  PortadorAntigo, PortadorNovo: String;
begin
  if DataSet.State = dsEdit then
  begin
    PortadorAntigo := VarToStrDef(DataSet.FieldByName('CTR_CODPOR').OldValue, '');
    PortadorNovo   := VarToStrDef(DataSet.FieldByName('CTR_CODPOR').NewValue, '');

    TGravaAlteracaoDePortador.Salvar(PortadorAntigo,
                                     PortadorNovo,
                                     DataSet.FieldByName('CTR_NUMDUP').asString,
                                     DataSet.FieldByName('CTR_PARCEL').asString,
                                     DataSet.FieldByName('CTR_ESPDOC').asString,
                                     DataSet.FieldByName('CTR_CODEMP').asString,
                                     DataSet.FieldByName('CTR_CODCLI').asString,
                                     DataSet.FieldByName('CTR_SEQBAI').asString);
  end;
end;

{*************************************************************}
{*  Converte uma string para um array de string de 1 posição *}
{**********************************************************Jl*}
function fStringToArray(strValue: String): TArrayString;
begin
  result := TArrayString(TArray<String>.Create(strValue));
end;

{*******************************************************}
{*  REMOVE OS ITENS DUPLICADOS EM UM ARRAY DE STRING   *}
{****************************************************Jl*}
function fRemoveItensDuplicadosEmArray(var arrValue: TArrayString): TArrayString;
var
 new: TArrayString;
 i, FoundIndex: integer;
begin
  result := [];
  TArray.Sort<String>(arrValue);

  for I := Low(arrValue) to High(arrValue) do
    if not TArray.BinarySearch<String>(New, arrValue[i], FoundIndex) then
      begin
        SetLength(New,FoundIndex+1);
        New[FoundIndex]:=arrValue[i];
      end;

  if Length(New) > 0 then
    result := New;

end;

{*******************************************************}
{* MOSTRA UMA MENSAGEM INFORMANDO QUE O CLIENTE POSSUI *}
{* CREDITOS EM ABERTO, PASSAR 1 OU VARIOS CLIENTES     *}
{*       PARA PASSAR UM UNICO CLIENTE USE:             *}
{*      ...funcao(fStringToArray('CODCLI'));           *}
{***************************************************Jl *}
procedure fAvisoClienteTemCreditoDisponivel(arrCodCli: TArrayString);
var
  objLiberacao : ILiberacao;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  CreditoCliente: Double;
  QtdeClientesComCredito: Integer;
  strCodigoCliente: String;
  intContador: Integer;

begin
  arrCodCli := fRemoveItensDuplicadosEmArray(arrCodCli);

  QtdeClientesComCredito := 0;

  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.Clear;

  objLiberacao.strCaption := 'ATENÇÃO';
  objLiberacao.blnTraTel := False;
  objLiberacao.strSenLib := '';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := '';

  objLiberacao.objMsgLibera.pAddSeparador(98);
  objLiberacao.objMsgLibera.pAddTexto('***  CRÉDITOS EM ABERTO  *** ', alCentro, teAmbos, '', 98);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;

  objLinha.pAddColuna('', 'CÓDIGO'  , 8 , alEsquerda, teAutcom);
  objLinha.pAddColuna('', 'NOME'    , 60 , alEsquerda, teAutcom);
  objLinha.pAddColuna('', 'TOTAL DE CRÉDITO' , 23 , alDireita , teAutcom);

  objTabela.lstLinhas.Add(objLinha);

  For intContador := Low(arrCodCli) to High(arrCodCli) Do
  Begin
    strCodigoCliente := arrCodCli[intContador];
    CreditoCliente := fGetTotalCreditosCliente(strCodigoCliente);

    If (CreditoCliente > 0) Then
    Begin

      Inc(QtdeClientesComCredito);
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('CÓDIGO',  strCodigoCliente,                       8, alEsquerda);
      objLinha.pAddColuna('NOME',    fRetNomCliente(strCodigoCliente),       60, alEsquerda);
      objLinha.pAddColuna('CRÉDITO', FormatFloat('#,##0.00', CreditoCliente), 23 , alDireita);
      objTabela.lstLinhas.Add(objLinha);

    End;

  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTexto('Os clientes acima possuem créditos em aberto no contas a receber.');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTexto('O objetivo desta notificação é informá-lo que o contas a receber devedor pode ser baixado');
  objLiberacao.objMsgLibera.pAddTexto('com a devida utilização de crédito e posteriormente impresso o boleto, se for o caso.');

  if QtdeClientesComCredito > 0 then
    objLiberacao.fLibera;

end;

function fSuprimirZeroDireita(strValor: String): String;
begin
  strValor := fRemoverPercentual(strValor);
  Result := FloatToStr(fStrToFloat(strValor)/1)+'%';
end;

function fTravaAliquota: Boolean;
var
  frmObservacaoLocal: TfrmObservacao;
  strMsgTrava: string;
begin
  Result := False;
  strMsgTrava := EmptyStr;

  if not fCfgSis('SIMPAU', varBoolean) then
    Exit;

  if fEmptyStr(fCfgSis('ICMSIM', varString)) then
    strMsgTrava := '[CFG_ICMSIM]Percentual ICMS Simples Nacional - Produtos Revenda:';

  if fEmptyStr(fCfgSis('ICMIND', varString)) then
  begin
    if not fEmptyStr(strMsgTrava) then
      strMsgTrava := strMsgTrava + sLineBreak;

    strMsgTrava := strMsgTrava + '[CFG_ICMIND]Percentual ICMS Simples Nacional - Produtos Industrializados:';
  end;

  if not fEmptyStr(strMsgTrava) then
  begin
    strMsgTrava := 'O Sistema está configurado [CFG_SIMPAU]Optante por Simples Nacional = ( SIM ), ' +
                   'porém não tem alíquota cadastrada na(s) configuração(ções)' +
                   sLineBreak + sLineBreak + strMsgTrava;

    pCriarFormularios(TfrmObservacao, frmObservacaoLocal);

    try
      frmObservacaoLocal.Caption := 'Informação';
      frmObservacaoLocal.lblMensagem.Caption := 'Inconsistência(s) de alíquota encontrada: ';
      frmObservacaoLocal.memObs.CharCase := ecNormal;
      frmObservacaoLocal.Height := 195;
      frmObservacaoLocal.Width := 596;
      frmObservacaoLocal.memObs.Lines.Add(strMsgTrava);
      frmObservacaoLocal.ShowModal;
      Result := True;
    finally
      pFreeAndNil(frmObservacaoLocal);
    end;
  end;
end;

function fRemoverPercentual(strValor: String): String;
const
  strCaracter : String = '%';
var
  intIndice: Integer;
begin
	Result := '';
	for intIndice := 1 to Length(strValor) Do
  begin
  	if Pos(strValor[intIndice], strCaracter) = 0 Then
    begin
			Result := Result + strValor[intIndice];
    end;
  end;
end;

function fTemSaldoParaEnderecamento: Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT ITE_QTPD_E FROM ITEGER WHERE ITE_CODEMP = "' + VS_StrCodEmp + '" AND ITE_QTPD_E > 0 LIMIT 1');
    qryConsulta.Open;

    result := Not qryConsulta.IsEmpty;


  Finally
    FreeAndNil(qryConsulta)
  End;


End;


function fRestauraICM(qryEntMer: TDataSet; strCodFis: String): Boolean;
Begin
   If Not (qryEntMer.FieldByName('ENT_CSTCAD').AsString = 'S') Then
     Exit(True);

   If (fCfgSis('MITIIE') = 'S') And
      (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, CST_TRIBUTADO) > 0) And
      (Pos(strCodFis, CST_ISENTO) > 0) Then
     Exit(False);

   If Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, CST_SUBSTITUICAO) > 0) Then
     Exit(True);
   If Not (Pos(strCodFis, CST_TRIBUTADO) > 0) Then
     Exit(True);

   Result := False;
End;

function TipoCalculoSTGareImportacaoXMLToInt(Value: TTipoCalculoSTGareImportacaoXML): integer;
Begin

  case Value of
    tcsgiPadrao: Result := 0;
    tcsgiProduto: Result := 1;
    tcsgiProduto_ComDesconto: Result := 2;
    tcsgiProduto_ComIPI: Result := 3;
    tcsgiIPIComDesconto: Result := 4;

  Else
    Result := 0;
  End;
End;

function IntToTipoCalculoSTGareImportacaoXML(Value: Integer):TTipoCalculoSTGareImportacaoXML;
Begin
  case Value of
    0: Result := tcsgiPadrao;
    1: Result := tcsgiProduto;
    2: Result := tcsgiProduto_ComDesconto;
    3: Result := tcsgiProduto_ComIPI;
    4: Result := tcsgiIPIComDesconto;
  Else
    Result := tcsgiProduto;
  End;
End;


function fExistePedidoAbastecimento(Const strNumPed, strEspPed, strEmpPed: String;
  Out strNmPdAb, strEsPdAb, strEmPdAb: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  strNmPdAb := '';
  strEsPdAb := '';
  strEmPdAb := '';

  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  IFNULL(FGO_NUMDOC, "") AS FGO_NUMDOC, ');
    qryAux.SQL.Add('  IFNULL(FGO_ESPDOC, "") AS FGO_ESPDOC, ');
    qryAux.SQL.Add('  IFNULL(FGO_CODEMP, "") AS FGO_CODEMP  ');
    qryAux.SQL.Add('FROM FATGOR ');
    qryAux.SQL.Add('JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
    qryAux.SQL.Add('WHERE FGO_NMPDAB = :NMPDAB ');
    qryAux.SQL.Add('  AND FGO_ESPDAB = :ESPDAB ');
    qryAux.SQL.Add('  AND FGO_EMPDAB = :EMPDAB ');

    qryAux.ParamByName('NMPDAB').AsString := strNumPed;
    qryAux.ParamByName('ESPDAB').AsString := strEspPed;
    qryAux.ParamByName('EMPDAB').AsString := strEmpPed;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;

    If Result Then
    Begin
      strNmPdAb := qryAux.FieldByName('FGO_NUMDOC').AsString;
      strEsPdAb := qryAux.FieldByName('FGO_ESPDOC').AsString;
      strEmPdAb := qryAux.FieldByName('FGO_CODEMP').AsString;

      Result := Not fEmptyStr(Concat(strNmPdAb, strEsPdAb, strEmPdAb));
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;





procedure pLimparImpressoraSelecionaBoleto;
begin
  untBancos.pLimparImpressoraSelecionadaBoleto;
end;

function fAlgumaEmpresaUtilizaRegimeEspecial: Boolean;
begin
  Result := (fCampoTabela('COUNT(1)', 'CFGSIS', ['SIS_CODCFG','SIS_VALCFG'], ['CFG_UTI_RE','S'], False) > 0);
end;



function fAtualizaMovTriValoresCalculadosDoFrete(strSeqGer: String; fltValorFreteCalculado, fltValorConhecimentoCalculado: Double): Boolean;
var qryComand: TUniQuery;
Begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('UPDATE MOVTRI SET ');
    qryComand.SQL.Add('       DET_CFRETE = :DET_CFRETE,');
    qryComand.SQL.Add('       DET_CFRECO = :DET_CFRECO');
    qryComand.SQL.Add(' WHERE DET_SEQGER = "'+strSeqGer+'"');
    qryComand.ParamByName('DET_CFRETE').AsFloat := fltValorFreteCalculado;
    qryComand.ParamByName('DET_CFRECO').AsFloat := fltValorConhecimentoCalculado;
    qryComand.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(qryComand);
  End;
End;

function fRetAliquotaIssCidade(strCodCid: String): Double;
begin
  Result := fCampoTabela('CID_ALQISS', 'CADCID', ['CID_CODCID'], [strCodCid]);
end;

function fRetReducaoBaseIssCidade(strCodCid: String): Double;
  Var
    qryGen: TUniQuery;
begin

  Result := 0;

  If fTabelaExiste('CADRBC', True) Then
  Begin
    Try
      qryGen := fCriaQuery;
      qryGen.SQL.Add('SELECT CADRBC.CID_REDISS ');
      qryGen.SQL.Add('  FROM CADRBC ');
      qryGen.SQL.Add(' WHERE CADRBC.CID_CODCID = :CODCID ');
      qryGen.SQL.Add('   AND CADRBC.CID_CODEMP = :CODEMP ');
      qryGen.ParamByName('CODCID').asString := strCodCid;
      qryGen.ParamByName('CODEMP').asString := VS_strCodEmp;
      qryGen.Open;

      If Not qryGen.isEmpty Then
        Result := qryGen.FieldByName('CID_REDISS').asFloat;

      qryGen.Close;
    Finally
      FreeAndNil(qryGen);
    End;
  End
  Else
    Result := fCampoTabela('CID_REDISS', 'CADCID', ['CID_CODCID'], [strCodCid]);

end;

function fRetEmpOriRegimeEspecial(Const strNumDoc, strEspDoc, strCodEmp: String): String;
  Var
    qrySelect: TUniQuery;
begin
  Result := '';

  If Not fAlgumaEmpresaUtilizaRegimeEspecial Then
    Exit;

  qrySelect := fCriaQuery;
  Try
    qrySelect.SQL.Add('SELECT GER_CODEMP');
    qrySelect.SQL.Add('FROM MOVGER');
    qrySelect.SQL.Add('LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM');
    qrySelect.SQL.Add('WHERE AUX_DOC_RE = :DOC_RE');
    qrySelect.SQL.Add('  AND AUX_ESP_RE = :ESP_RE');
    qrySelect.SQL.Add('  AND AUX_EMP_RE = :EMP_RE');
    qrySelect.SQL.Add('  AND GER_TIP_FC = "C" ');

    qrySelect.ParamByName('DOC_RE').AsString := strNumDoc;
    qrySelect.ParamByName('ESP_RE').AsString := strEspDoc;
    qrySelect.ParamByName('EMP_RE').AsString := strCodEmp;

    qrySelect.Open;

    Result := qrySelect.FieldByName('GER_CODEMP').AsString;
  Finally
    FreeAndNil(qrySelect);
  End;
end;

function fRetJustificativaNegacaoMsgAnterior(Const strCodLib, strCodCli: String): String;
  Var
    qryMsgNeg: TUniQuery;
begin
  Result := '';

  If fEmptyStr(strCodLib) Then
    Exit;

  qryMsgNeg := fCriaQuery;
  Try
    qryMsgNeg.Close;
    qryMsgNeg.SQL.Clear;

    qryMsgNeg.SQL.Add('SELECT NEG_MSGNEG, NEG_OPENEG');
    qryMsgNeg.SQL.Add(' FROM MSGNEG ');
    qryMsgNeg.SQL.Add(' WHERE NEG_CODLIB = :CODLIB');
    qryMsgNeg.SQL.Add(' AND NEG_CODCLI = :CODCLI');
    qryMsgNeg.SQL.Add(' ORDER BY AUTOINCREM DESC');

    qryMsgNeg.ParamByName('CODLIB').AsString := strCodLib;
    qryMsgNeg.ParamByName('CODCLI').AsString := strCodCli;

    qryMsgNeg.Open;

    If Not qryMsgNeg.IsEmpty Then
      Result := STRING_QUEBRA + 'Esta venda já foi negada para este motivo de liberação! Justifcativa da negação anterior: ' +
                STRING_QUEBRA + qryMsgNeg.FieldByName('NEG_MSGNEG').AsString +
                STRING_QUEBRA + 'Do Operador: ' + qryMsgNeg.FieldByName('NEG_OPENEG').AsString
    Else
      Result := '';
  Finally
    FreeAndNil(qryMsgNeg);
  End;
end;

function fDisparaSMSWhatsappAutOS(strNumOSe,
                                  strCodEmp,
                                  strCodCli: String;
                                  staStatus: TStatusDisparaEmail;
                                  var blnModeloAtivado: Boolean;
                                  blnEnviarWhatsapp: Boolean = False;
                                  recArquivos: TArray<TRecArquivosGatilhos> = nil): Boolean;
Var
  objSmsAut: TSMSAut;
  strSQL: String;
  qrySQL: TUniQuery;
  blnEhClienteConsumidor: Boolean;
Begin
  Result := False;

  qrySQL := fCriaQuery(Nil);
  objSmsAut := TSMSAut.Create(Nil);

  Try
    blnEhClienteConsumidor := fClienteConsumidor(fRetNomCliente(strCodCli), True, False);

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';

    if not blnEhClienteConsumidor then
    begin
      strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
      strSQL := strSQL + '  CLI_CELULA AS CELULA, ';
    end
    else
    begin
      strSQL := strSQL + '  EQU_NOMCON AS NOMCLI, ';
      strSQL := strSQL + '  EQU_TELCON AS CELULA, ';
    end;

    strSQL := strSQL + '  CONCAT(EQU_CODVEN, "-", OPE_NOMOPE) AS VENDEDOR, ';
    strSQL := strSQL + '  CONCAT(CID_NOMCID, "-", CID_ESTADO) AS NOMCID ';
    strSQL := strSQL + 'FROM EQUGER ';

    if not blnEhClienteConsumidor then
    begin
      strSQL := strSQL + '  LEFT JOIN CADCLI ON EQU_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
    end
    else
      strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = EQU_CIDCON ';

    strSQL := strSQL + '  LEFT JOIN CADOPE ON EQU_CODVEN = OPE_CODOPE ';

    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  EQU_NUMOSE = :NUMOSE AND ';
    strSQL := strSQL + '  EQU_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EQU_CODCLI = :CODCLI ';

    qrySQL.Close;
    qrySQL.SQL.Text := strSQL;
    qrySQL.ParamByName('NUMOSE').AsString := strNumOSe;
    qrySQL.ParamByName('CODEMP').AsString := strCodEmp;
    qrySQL.ParamByName('CODCLI').AsString := strCodCli;
    qrySQL.Open;

    objSmsAut.strOpcDoc := 'CE';
    objSmsAut.staStatus := staStatus;
    objSmsAut.strNumeOS := strNumOSe;
    objSmsAut.blnAssincrono := True;

    objSmsAut.strTo := Trim(qrySQL.FieldByName('CELULA').AsString);

    objSmsAut.strCodCli := strCodCli;
    objSmsAut.strNomCli := qrySQL.FieldByName('NOMCLI').AsString;
    objSmsAut.strPriCli := fRetPrimeiraPalavra(qrySQL.FieldByName('NOMCLI').AsString);
    objSmsAut.strCidCli := qrySQL.FieldByName('NOMCID').AsString;
    objSmsAut.strTransp := '';

    objSmsAut.FArquiv := recArquivos;

    objSmsAut.blnWhatsApp := blnEnviarWhatsapp;

    objSmsAut.FVendedor := qrySQL.FieldByName('VENDEDOR').AsString;

    If (objSmsAut.fTemModeloAtivo) Then
    Begin
      blnModeloAtivado := True;

      if (blnEnviarWhatsapp) and (not fRetFilaEContatoEnvio(objSmsAut.FAutIncCtt,
                                                            objSmsAut.FTo,
                                                            objSmsAut.FIDFila,
                                                            objSmsAut.strCodCli,
                                                            objSmsAut.strNomCli,
                                                            objSmsAut.strCodigo,
                                                            objSmsAut.strCodGru,
                                                            objSmsAut.blnAbreTelaEscolherContato)) then
        Exit;

      Result := objSmsAut.fEnviaSMSAutomatico;
    End
    Else
      blnModeloAtivado := False;
  Finally
    FreeAndNil(qrySQL);
    FreeAndNil(objSmsAut);
  End;
end;

function fVaiCalcularRetencoesServicos(ANumDoc, AEspDoc, ACodEmp, ACodCli: String): Boolean;
var
  qryCadCli: TUniQuery;
  LSomenteServ: Boolean;
begin
  Result := False;

  If (Not fDocumentoPossuiServicos(ANumDoc, AEspDoc, ACodEmp, LSomenteServ)) Then
    Exit;

  qryCadCli := fCriaQuery;

  Try
    qryCadCli.SQL.Text := 'SELECT CLI_CDESPI, CLI_RETPCO, CLI_RETIRF FROM CADCLI WHERE CLI_CODCLI = :CODCLI ';
    qryCadCli.ParamByName('CODCLI').AsString := ACodCli;
    qryCadCli.Open;

    If not qryCadCli.IsEmpty Then
    Begin
      Result := (qryCadCli.FieldByName('CLI_CDESPI').AsString = 'S') And
                ((qryCadCli.FieldByName('CLI_RETPCO').AsString = 'S') Or (qryCadCli.FieldByName('CLI_RETIRF').AsString = 'S'));
    End;

  Finally
    FreeAndNil(qryCadCli);
  End;
end;

function fGatilhoEmailWhatsappSmsEstaAtivado(tipGatilho: TTipoGatilho;
                                             strOpcDoc,
                                             strEspDoc: String;
                                             strNumOrc: String = '';
                                             strEspOrc: String = ''): Boolean;
var
  GatilhoEmail: TEmaAut;
  GatilhoSmsWpp: TSMSAut;

  strCodGru,
  strCodigo: String;
begin
  Result := False;

  if tipGatilho = notEmail then
  begin
    GatilhoEmail := TEmaAut.Create(nil);
    try
      GatilhoEmail.FOpcDoc := strOpcDoc;
      GatilhoEmail.FEspDoc := strEspDoc;
      GatilhoEmail.FNumOrc := strNumOrc;
      GatilhoEmail.FEspOrc := strEspOrc;

      Result := GatilhoEmail.fTemEmailAtivo;

      strCodGru := GatilhoEmail.FCodGru;
      strCodigo := GatilhoEmail.FCodigo;
    finally
      FreeAndNil(GatilhoEmail);
    end;
  end;

  if tipGatilho in [notSMS, notWhatsapp] then
  begin
    GatilhoSmsWpp := TSMSAut.Create(nil);
    try
      GatilhoSmsWpp.FOpcDoc := strOpcDoc;
      GatilhoSmsWpp.FEspDoc := strEspDoc;
      GatilhoSmsWpp.FNumOrc := strNumOrc;
      GatilhoSmsWpp.FEspOrc := strEspOrc;
      GatilhoSmsWpp.FWhatsApp := IIF(tipGatilho = notWhatsapp, True, False);

      Result := GatilhoSmsWpp.fTemModeloAtivo;

      strCodGru := GatilhoSmsWpp.FCodGru;
      strCodigo := GatilhoSmsWpp.FCodigo;
    finally
      FreeAndNil(GatilhoSmsWpp);
    end;
  end;

  if not Result then
    fMensagem('Atenção!', 'Para enviar o Whatsapp configure '+
                          'o gatilho através das configurações do sistema.'+#13#10+
                          'CFG_GATWPP - Gatilhos para envio de mensagens.'+#13#10+
                          'O gatilho deve estar ativado, deve ter um texto preenchido na mensagem ou '+
                          'marcado para enviar o pdf do documento. '+
                          'Gatilho a ser ajustado: '+fRetNomeGatilhoEmailSmsWhatsapp(tipGatilho, strCodGru, strCodigo), ['&Ok']);
end;

procedure pValidaPDComAbastecimentoTransf(strNumDoc, strEspDoc, strEmpDoc: String; var AMensagem: TStringList);
var
  qryPed: TUniQuery;
  qryPrePTE: TUniQuery;
  stlFaturados: TStringList;
  stlExpedidos: TStringList;
  stlSeparados: TStringList;
begin
  qryPrePTE := fCriaQuery();
  qryPed := fCriaQuery();
  stlFaturados := TStringList.Create;
  stlExpedidos := TStringList.Create;
  stlSeparados := TStringList.Create;

  try
    qryPed.SQL.Add('SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_SEPIMP SEPIMP, SUM(FDO_QTDBAI) QTDBAI, SUM(FDO_QTDEXP) QTDEXP ');
    qryPed.SQL.Add('FROM FATGOR FG ');
    qryPed.SQL.Add('INNER JOIN FATDOR FD ON FG.AUTOINCREM = FD.FDO_SEQGER ');
    qryPed.SQL.Add('INNER JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO ');
    qryPed.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC ');
    qryPed.SQL.Add('  AND FGO_ESPDOC = :ESPDOC ');
    qryPed.SQL.Add('  AND FGO_CODEMP = :CODEMP ');
    qryPed.SQL.Add('GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_SEPIMP ');


    qryPrePTE.SQL.Add('SELECT PRE_NUMDOC, PRE_ESPDOC, PRE_EMPDOC ');
    qryPrePTE.SQL.Add('FROM PREPTE ');
    qryPrePTE.SQL.Add('WHERE PRE_DOCABS = :DOCABS ');
    qryPrePTE.SQL.Add('  AND PRE_ESPABS = :ESPABS ');
    qryPrePTE.SQL.Add('  AND PRE_EMPABS = :EMPABS ');
    qryPrePTE.SQL.Add('  AND IFNULL(PRE_NUMDOC, "") <> "" ');
    qryPrePTE.ParamByName('DOCABS').AsString := strNumDoc;
    qryPrePTE.ParamByName('ESPABS').AsString := strEspDoc;
    qryPrePTE.ParamByName('EMPABS').AsString := strEmpDoc;
    qryPrePTE.Open;

    if (qryPrePTE.IsEmpty) then
      Exit;

    while not qryPrePTE.Eof do
    begin
      qryPed.Close;
      qryPed.ParamByName('NUMDOC').AsString := qryPrePTE.FieldByName('PRE_NUMDOC').AsString;
      qryPed.ParamByName('ESPDOC').AsString := qryPrePTE.FieldByName('PRE_ESPDOC').AsString;
      qryPed.ParamByName('CODEMP').AsString := qryPrePTE.FieldByName('PRE_EMPDOC').AsString;
      qryPed.Open;

      if (qryPed.FieldByName('QTDBAI').AsFloat > 0) then
        stlFaturados.Add(qryPed.FieldByName('FGO_NUMDOC').AsString + '-' +
                          qryPed.FieldByName('FGO_ESPDOC').AsString + '-' +
                          qryPed.FieldByName('FGO_CODEMP').AsString);

      if (qryPed.FieldByName('QTDEXP').AsFloat > 0) then
        stlExpedidos.Add(qryPed.FieldByName('FGO_NUMDOC').AsString + '-' +
                          qryPed.FieldByName('FGO_ESPDOC').AsString + '-' +
                          qryPed.FieldByName('FGO_CODEMP').AsString);

      if (qryPed.FieldByName('SEPIMP').AsString <> '0') then
        stlSeparados.Add(qryPed.FieldByName('FGO_NUMDOC').AsString + '-' +
                          qryPed.FieldByName('FGO_ESPDOC').AsString + '-' +
                          qryPed.FieldByName('FGO_CODEMP').AsString);

      qryPrePTE.Next;
    end;

    if (stlFaturados.Count > 0) then
    begin
      AMensagem.Add('Este pedido de venda está vinculado a pedidos de abastecimento');
      AMensagem.Add('que já foram faturados (total ou parcial).');
      AMensagem.Add('Entre em contato com o operador responsável para desfazer a');
      AMensagem.Add('operação de faturamento e depois tente cancelar novamente.');
      AMensagem.Add('--------------------------------------------------------------');
      AMensagem.Add('Pedido(s) de abastecimento vinculado(s):');
      AMensagem.Add(stlFaturados.Text);
    end
    else if (stlExpedidos.Count > 0) then
    begin
      AMensagem.Add('Este pedido de venda está vinculado a pedidos de abastecimento');
      AMensagem.Add('que possui expedição realizada (total ou parcial).');
      AMensagem.Add('Entre em contato com o operador responsável para desfazer a');
      AMensagem.Add('expedição e a separação e depois tente cancelar novamente.');
      AMensagem.Add('--------------------------------------------------------------');
      AMensagem.Add('Pedido(s) de abastecimento vinculado(s):');
      AMensagem.Add(stlExpedidos.Text);
    end
    else if (stlSeparados.Count > 0) then
    begin
      AMensagem.Add('Este pedido de venda está vinculado a pedidos de abastecimento');
      AMensagem.Add('que já tiveram separação impressa (total ou parcial).');
      AMensagem.Add('Entre em contato com o operador responsável para limpar a');
      AMensagem.Add('separação e depois tente cancelar novamente.');
      AMensagem.Add('--------------------------------------------------------------');
      AMensagem.Add('Pedido(s) de abastecimento vinculado(s):');
      AMensagem.Add(stlSeparados.Text);
    end;
  finally
    FreeAndNil(qryPrePTE);
    FreeAndNil(qryPed);
    FreeAndNil(stlFaturados);
    FreeAndNil(stlExpedidos);
    FreeAndNil(stlSeparados);
  end;
end;

procedure pSalvarXmlReinf(tpXml: TtpXmlReinf; cdsLote: TUniClientDataSet);
var
  strCaminho: String;
  SaveDialog: TSaveDialog;
  blnBaixado: Boolean;
begin
  if not Assigned(cdsLote) then
    Exit;
  try
    cdsLote.DisableControls;

    cdsLote.Filtered := False;
    cdsLote.Filter   := 'MARDES = ' + QuotedStr('M') + ' AND ' + IIF(tpXml = xmlEnvio, 'LOT_XMLENV IS NOT NULL', 'LOT_XMLRET IS NOT NULL');
    cdsLote.Filtered := True;

    if cdsLote.IsEmpty then
      Exit;

    if cdsLote.RecordCount > 1 then
    begin
      blnBaixado := False;

      SelectDirectory('Selecione uma pasta', 'C:\', strCaminho, [sdNewUI, sdNewFolder]);

      if fEmptyStr(strCaminho) then
        Exit;

      cdsLote.First;

      while not cdsLote.Eof do
      begin
        blnBaixado := True;
        pGravarArquivoXML(strCaminho + '\' + cdsLote.FieldByName('LOT_IDEEVE').AsString + IIF(tpXml = xmlEnvio, '_ENV_', '_RET_') + cdsLote.FieldByName('LOT_EVENTO').AsString + '.xml', cdsLote.FieldByName(IIF(tpXml = xmlEnvio, 'LOT_XMLENV', 'LOT_XMLRET')).AsString);
        cdsLote.Next;
      end;

      cdsLote.First;

      if blnBaixado then
        fMensagem('ATENÇÃO', 'XML(s) baixado(s) com sucesso!', ['&Ok']);
    end
    else
    begin
      SaveDialog := TSaveDialog.Create(nil);
      try
        SaveDialog.FileName := cdsLote.FieldByName('LOT_IDEEVE').AsString + IIF(tpXml = xmlEnvio, '_ENV_', '_RET_') + cdsLote.FieldByName('LOT_EVENTO').AsString + '.xml';
        SaveDialog.Filter := '*.xml|*.xml';
        if SaveDialog.Execute then
        begin
          strCaminho := SaveDialog.FileName;

          pGravarArquivoXML(strCaminho, cdsLote.FieldByName(IIF(tpXml = xmlEnvio, 'LOT_XMLENV', 'LOT_XMLRET')).AsString);

          if fPergunta('Deseja abrir o arquivo xml?') then
            pExecArquivo(strCaminho, 0);
        end;
      finally
        FreeAndNil(SaveDialog);
      end;
    end;

  finally
    cdsLote.Filtered := False;
    cdsLote.EnableControls;
  end;
end;

function RetornaLinkImagemPixCitel(ATextoQRCode: String; ATamanho: Integer = 150): String;
Begin
  Result := EmptyStr;

  If ATamanho <= 0 Then
    ATamanho := 150;

  If Not ATextoQRCode.IsEmpty Then
    Result := 'https://pix.citelsoftware.com.br/qrcode?size=' + ATamanho.ToString +
              '&text=' + ATextoQRCode;
End;

function fPermiteFaturamentoPedidoComItemEstruturaSemOrdemProducao(strNumDoc, strCodEmp: String; objLiberacao: ILiberacao = Nil): Boolean;
  Var
    qryFatDor: TUniQuery;
begin
  Result := True;

  If Not fCfgSis('FIESOP', varBoolean) Then
    Exit;

  qryFatDor := fCriaQuery;
  Try
    qryFatDor.Close;
    qryFatDor.SQL.Clear;

    qryFatDor.SQL.Add('SELECT FDO_CODCLI, FDO_VLRCON, FDO_CODVEN, FDO_CONPAG, FDO_CODFPG, FDO_CODITE, FDO_DESCRI, FDO_QTDITE FROM FATDOR ');
    qryFatDor.SQL.Add('INNER JOIN GERMAT ON GMT_CODITE = FDO_CODITE ');
    qryFatDor.SQL.Add('WHERE FDO_CODEMP = :CODEMP ');
    qryFatDor.SQL.Add('AND FDO_NUMDOC = :NUMDOC ');
    qryFatDor.SQL.Add('AND FDO_ESPDOC = "PD" ');
    qryFatDor.SQL.Add('AND COALESCE(FDO_ORDPRO, "") = "" ');

    qryFatDor.ParamByName('CODEMP').AsString := strCodEmp;
    qryFatDor.ParamByName('NUMDOC').AsString := strNumDoc;

    qryFatDor.Open;

    If qryFatDor.IsEmpty Then
      Exit;

    If Not Assigned(objLiberacao) Then
      objLiberacao := TLiberacaoFactory.fGetLiberacao;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(80);

    objLiberacao.objMsgLibera.pAddTexto('Permitir faturar pedido com ordem de produção pendente de geração.', alCentro, teAutcom, '', 80);
    objLiberacao.objMsgLibera.pAddSeparador(80);
    objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'     , strNumDoc + '-PD-' + strCodEmp                                                                                      , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'    , qryFatDor.FieldByName('FDO_CODCLI').AsString + '-' + fRetNomCliente(qryFatDor.FieldByName('FDO_CODCLI').AsString)   , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'   , qryFatDor.FieldByName('FDO_CODVEN').AsString + '-' + fRetNomeOperador(qryFatDor.FieldByName('FDO_CODVEN').AsString) , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Pedido'  , FormatFloat('#,##0.00', qryFatDor.FieldByName('FDO_VLRCON').AsFloat)                                                , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cond.Pagto' , fFormataCondPag(qryFatDor.FieldByName('FDO_CONPAG').AsString)                                                       , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto', qryFatDor.FieldByName('FDO_CODFPG').AsString + '-' + fRetDescFpg(qryFatDor.FieldByName('FDO_CODFPG').AsString)      , 9);
    objLiberacao.objMsgLibera.pAddSeparador(80);
    objLiberacao.objMsgLibera.pAddTexto('Produtos Com Geração Pendente:');

    qryFatDor.First;
    While Not qryFatDor.Eof Do
    Begin
      objLiberacao.objMsgLibera.pAddTexto('Produto: ' + qryFatDor.FieldByName('FDO_CODITE').AsString + '-' + qryFatDor.FieldByName('FDO_DESCRI').AsString);
      objLiberacao.objMsgLibera.pAddTexto('Quantidade: ' + FormatFloat('#,##0.00', qryFatDor.FieldByName('FDO_QTDITE').AsFloat));
      objLiberacao.objMsgLibera.pAddSeparador(80);

      qryFatDor.Next;
    End;

    objLiberacao.strDirAce := 'FIESOP';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnSempreVariavelUsuario := True;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(qryFatDor);
  End;
end;

function fPermiteCodigoProdutoExpedicaoItensMedianteSenha(strCodIte: String; objLiberacao: ILiberacao): Boolean;
Begin
  Result := False;

  If Not fCfgSis('SBAREX', varBoolean) Then
    Exit;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Expedição Itens - Permitir digitação do Código do Produto quando obrigatório código de barras.');
  objLiberacao.objMsgLibera.pAddSeparador(95);
  objLiberacao.objMsgLibera.pAddTexto('Produto: ' + strCodIte + ' - ' + fRetNomProduto(strCodIte));

  objLiberacao.strDirAce := 'SBAREX';
  objLiberacao.strMsgSen := 'Expedição Itens - Permitir digitação do Código do Produto quando obrigatório código de barras.';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
End;

function fValidaPortadorDataPDD(ACodigoPortador, ACodigoEmpresa: String; Var ADataTrocaPortador : TDateTime; APortadorAnteriorPDD: Boolean): Boolean;
Var
  LFechamentoFinanceiro: TFechamentoFinanceiro;
  LDataSemPDD: TDateTime;
begin
  Result := True;

  If fRetGeraTituloPDDPortador(ACodigoPortador) Then
  Begin
    If fMensagem('', 'Considerar esse título como PDD nessa data?', ['&Sim','&Não'],1) <> 1 Then
    Begin
      LFechamentoFinanceiro := TFechamentoFinanceiro.Create(Nil, 'untFuncoes');

      Try
        Result := False;
        While Not Result Do
        Begin
          If Not ffrmDataNovo(ADataTrocaPortador, 'Data de Portador PDD', 'Data:') Then
          Begin
            Break;
          End
          Else
          Begin
            Result := Not LFechamentoFinanceiro.FechamentoFinanceiroJaRealizado(ACodigoEmpresa,ADataTrocaPortador , False);

            If Not Result Then
            Begin
              fMensagem('ATENÇÃO', 'Fechamento Financeiro já realizado para a data selecionada!', ['&O k']);
            End;
          End;
        End;
      Finally
        FreeAndNil(LFechamentoFinanceiro);
      End;
    End;
  End
  Else If APortadorAnteriorPDD Then
  Begin
    Result := fMensagem('', 'Esse título já foi reconhecido como PDD. Deseja realmente revertê-lo?', ['&Sim', '&Não'], 2) = 1;
    If Not Result Then
      Exit;

    If fMensagem('', 'Considerar a data atual?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      ADataTrocaPortador := VS_Date;
      Exit;
    End;

    LFechamentoFinanceiro := TFechamentoFinanceiro.Create(Nil, 'untFuncoes');

    Try
      Result := False;
      LDataSemPDD := VS_Date;

      While Not Result Do
      Begin

        If Not ffrmDataNovo(LDataSemPDD, 'Data de Reversão do Portador PDD', 'Data:') Then
        Begin
          Break;
        End
        Else
        Begin
          If ADataTrocaPortador <> 0 THen
          Begin
            Result := ADataTrocaPortador <= LDataSemPDD;

            If Not Result Then
            Begin
              fMensagem('ATENÇÃO', 'A data digitada deve ser maior ou igual a data do reconhecimento do PDD!' + #13 +
                                   'Data do reconhecimento PDD: ' + FormatDateTime('dd/mm/yyyy', ADataTrocaPortador), ['&Ok']);

              Continue;
            End;
          End;

          Result := Not LFechamentoFinanceiro.FechamentoFinanceiroJaRealizado(ACodigoEmpresa, LDataSemPDD, False);

          If Not Result Then
          Begin
            fMensagem('ATENÇÃO', 'Fechamento Financeiro já realizado para a data selecionada!', ['&O k']);
          End;
        End;
      End;
    Finally
      FreeAndNil(LFechamentoFinanceiro);
    End;

    If Result Then
     ADataTrocaPortador := LDataSemPDD;
  End;

End;

initialization

  blnImprime_Vencimentos_Orcamento := TRUE;

end.
