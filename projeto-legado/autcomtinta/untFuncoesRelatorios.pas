unit untFuncoesRelatorios;

interface

uses untIFuncoes, Uni, Classes, Forms, untTypesSistema, Vcl.Controls, Data.DB,
  BitBtnLockedIncrem, StdCtrls, EditFocus, untClassPanelCx, ComboBoxFocus, DBComboBoxFocus,
  untITintasDeMaquina, UniClientDataSet, DBEditFocus, MaskEditFocus, untICamGer,
  {untIValorRecebido, }untIConfTinta, {untIControlePagtoFunc,} untIFastPrint,
  untIMetAno, untIFuncoesEditorFast, untFuncoesGenerica, {untIIteBar,} untICamposUso,
  untIOrdenacao, {untIMadeireira,} untIFinanceira, untIFuncMacro, untIZClient,
  TypesRel, untICadLote, untIFiltrosRelatorio, untIConfiguracao, untFuncEspecificas,
  {untMesesGiro, untIMesesGiro,} {untTEnvioEmail, }Graphics, frxClass,
  untFuncoesImagem, untConstantes, {untIFatReservaSaldo, }untIFatEntregaFutura;

Type
  TFuncoesRelatorio = class(TInterfacedObject, IFuncoes)
  Private
    function fTamDocCadRec: Integer;
    function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
    function fTiraCaracEspeciaisPonto(strTexto: String): String;
    function fTiraCaracEspeciais(strTexto      : String;
                                 blnUsaLista   : Boolean = True;
                                 blnTiraEspacos: Boolean = False;
                                 blnTiraPontos : Boolean = False;
                                 blnTiraDoisPts: Boolean = False;
                                 blnTiraTab    : Boolean = False;
                                 blnTiraVirgula: Boolean = True): String;
    function fRetNomeEmpresaSelec(Const strCodEmpresa: String): String;
    function fRetNomVendRep(strCodVen: String): String; Overload;
    function fRetNomVendRep(strCodVen: String; strCodEmp: String): String; Overload;
    function fRetNomCliente(Const strCodCli: String): String;
    function fRetNomeRedeLoja(Const strCodRed: String): String;
    function fRetNomeRede : String;
    function GetIPAddress: Integer;
    function GetIPAddressAsString: String;
    function GetMacAddress: String;
    function GetUserFromWindows: String;
    function GetComputerNetName: String;
    function fRetNomeEmpresa: String; overload;
    function fRetNomeEmpresa(strCodEmp: String): String; overload;
    function fRetLocSep(Const strCodLse: String): String;
    function fMensagem(strTitulo   : string;
                       strTexto    : string;
                       arrOpcoes   : Array Of String;
                       intFocoBotao: Integer = 1;
                       blnSaiComEsc: Boolean = False;
                       intEstFon   : Integer = 1;
                       intWidBut   : Integer = 0;
                       blnAutosize : Boolean = False;
                       intSomarTop : Integer = 0): Integer;
    function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
    function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
    function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
    function fRetornaInGrupo(strCodGpo: String; arrGrupos: TConsultasArray; strCampo: String=''): String;
    function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
    function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
    function fRetClientesFilial: String;
    function fEmptyDate(strDate: String): Boolean;
    function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fIsNumber(Const strNumber: String): Boolean;
    function fAbrirTabela(NomeTabela: TDataSet): Boolean;
    function fUsaProCodigo(strNomeTabela: String): Boolean;
    function fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;
    function fVerificaIntegridade(strNomFrm,
                                  strTabela: String;
                                  qryTabOriginal: TDataSet;
                                  blnGravar: Boolean = True;
                                  blnSoCriaTabela: Boolean = False;
                                  strMotDel: String = '';
                                  strOpeDel: String = '';
                                  blnTabAux: Boolean = False): String;
    function fInTransaction: Boolean;
    function fStartTransaction: Boolean;
    function fRollBack: Boolean;
    function fCommit: Boolean;
    function fValidarDirEspecificos(Var strDireitos: String; strLogin, strNomeForm: String): Boolean;
    function fRetTamCampo(strNomeTabela: String): Integer;
    function fAtualizaProCod(strNomeTabela: String): String;
    function fFecharTabela(NomeTabela: TDataSet): Boolean;
    function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;
    function VerImpressoraONLINE(impressora: String): Cardinal;
    function fIdentificarNomeDaImpressora(AImpressora: String): String;

    function fMostraFilas(Var strNomeFila: String;
                              strNomFormul: String = '';
                              qryCfgRel: TUniQuery = nil;
                              blnBotoes: Boolean = True): Boolean;

    function fPreImpressao(qryCfgRel: TUniQuery;
                       Var strNomeFila: String;
                       Var strTipImp: String;
                           blnLocal: Boolean;
                           strDirImp: String = '' ): Boolean;

    function GetUsuarioLogado(): String;
    function GetEmpresaLogada(): String;

    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fRetNomeLinhaGrupo(strCodigo: String): String;
    function fRetNomProduto(Const strCodIte: String): String;
    function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TPicture): TRetornoImagem; Overload;
    function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TfrxPictureView): TRetornoImagem; Overload;
    function fRetNomSituacaoProduto(strCodSit: String): String;
    function fRetNomMarca(strCodMar: String): String;
    function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
    function fGetTintasdeMaquina(blnDestruir: Boolean = False): ITintasDeMaquina;
    function fRetCodVendedor(strSenha: String; blnGerente : Boolean = False; blnSubGerente: Boolean = False): String;
    function fStrLocate(objCodigo: TObject;
                        arrLinha: TConsultasArray;
                        strNomCampo,
                        strNomPar: String;
                        blnSemAND: Boolean = False;
                        blnNegar: Boolean = False;
                        strCodigo: String = ''): String;
    function fRetornaComposicao(strDescri: String; blnPadrao : Boolean = False): String;
    function fStrRelFatorLit(strAliasDet: String = ''; blnVeioMarkup: Boolean = False): String;
    function fStrTitulo(strText: String;
                        edtDescri: TEditFocus;
                        arrLinha: TConsultasArray;
                        strLinha,
                        strTitulo: String;
                        blnTodas: Boolean = False;
                        blnNegar: Boolean = False): String; Overload;
    function fStrTitulo(strText: String;
                        edtDescri: TEditFocus;
                        arrLinha: TConsultasArray;
                        strLinha,
                        strTitulo,
                        strVazio: String): String; Overload;
    function fStrTitulo(edtValor: TEditFocus; strTitulo: String): String; Overload;
    function fStrSQLOr(objCodigo: TObject;
                       arrLinha: TConsultasArray;
                       strNomCampo,
                       strNomPar: String;
                       blnSemAND: Boolean = False;
                       blnNegar: Boolean = False ): String;
    function fRetornaNomeTinta(strIdePro: String): String;
    function fDescriLinhaWandaPro(intLinha: Integer): String;
    function fStrToFloat(strValorUnico: String): Double;
    function fEntraCons(strCodigo: String): Boolean;
    function fEscolheTinta(strCodCli : String = ''): ShortString;
    function fRetNomSubRegiao(Const strCodSub: String): String;
    function fRetDesReg(strCodReg: String): String;
    function fRetNomUnidade(strCodUni: String): String;
    function fRetNomAtividade(Const strCodAti: String): String;
    function fRetNomeGrupoProduto(strCodigo: String): String;
    function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                                curPrecus,
                                curPreven,
                                curMarBru,
                                curIcmsVenda,
                                curImpFed,
                                curDesOpe,
                                curValCom: Currency;
                                strMarMkp: String = '';
                                strPcmPro: String = '';
                                intDecUni: Integer = -1): Double;
    function fGetLetraAlfa(intCol: Integer): String;
    function fRetNomCidadeSemOpc(strCodigo: String): String;
    function fCalcMediaPagto(strConPag: String): Double;
    function fFormataCondPag(strCond: String): String;
    function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;
    function fTabelaExiste(strNomeTabela: String): Boolean;
    function fStrZero(Zeros: string; Quant: integer): String; Overload;
    function fStrZero(Zeros: Integer; Quant: integer): String; Overload;
    function fRetNomCadGpo(Const strCodGpo: String): String;
    function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;
    function fStrLocateEmpresa(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
      strNomPar: String; blnSemAND: Boolean = False; strCodigo: String = ''): String;
    function fRetConPag(strCodCnd: String): String;
    function fRetPerComMargem(fltValor: Double; strTipVen : String = ''; strConPag : String = ''): Double;
    function fRetPerComOpeMargem(fltCusto, fltVenda : Double; strCodOpe : String): Double;
    function fRetornaPrecosPromocao(strCodIte,
                                    strCodCli: String;
                                    dtaDtaPro: TDateTime;
                                    fltQtdDig,
                                    fltQtdJaDig,
                                    fltQtdJaEmPromoc: Double;
                                    intPraMed: Integer;
                                    Var fltPreCus,
                                    fltPreVen,
                                    fltComVar,
                                    fltComAta,
                                    fltComDis,
                                    fltQtdDis,
                                    fltDesF07: Double;
                                    Var strComPro: String;
                                    Var blnParticiona,
                                    blnPromo: Boolean;
                                    strTabPre: String;
                                    strCodCnd: String;
                                    strPrzPro: String = '';
                                    strENTBRF: String = '';
                                    blnConsideraQtd: Boolean = True;
                                    blnBuscaPreco: Boolean=False;
                                    strIteVid: String = '-1';
                                    blnEntIme: Boolean = False;
                                    blnEntFut: Boolean = False;
                                    strMotFut: String = '';
                                    strEmpPro: String = '';
                                    strNumOrc: String = '';
                                    strEspOrc: String = ''): Boolean;
    function fRetPerComLucro(fltQtdIte,
                             fltUniOri,
                             fltTotCus,
                             fltTotIteLiq,
                             fltComVar: Double;
                             fltTotCu2: Double = 0.0;
                             strMarMkp: String = '';
                             strPcmPro: String = '';
                             intDecUni: Integer = -1): Double;
    function fCurrentDate: String; Overload;
    function fCurrentDate(Const Value: TDateTime): String; Overload;
    function fRetNomProfissional(Const strCodPro: String; blnVerStatus: Boolean = False): String;
    function fRetNomDiversos(strCodDiv: String): String;
    function fRetExtensoNumero(Value: String): String;
    function fDataExtenso(Data: TDateTime; blnImpCid: Boolean = False; blnImpDiaSemana: Boolean = False): String;
    function fRetDataExtenso(dtaData: TDateTime; blnComCidade: Boolean = False): String;
    function ffrmSenha(var strSenha: String; strTitulo: String = ''): Boolean;
    function fCampoTabela(strCampo      : String;
                          strNomTab     : String;
                          arrCampoChave : Array Of String;
                          arrValorChave : Array Of Variant;
                          blnSempreLerBanco: Boolean = True):Variant;
    function fFormataFone(strFone: String): String;
//    function fGetMsgRelCnf: String;
    function fValidaDataStr(strData: String): Boolean;
    function fRetUFCliente(strCodCli: String): String;
    function fRetUFEmpresa(strCodEmp: String): String;
    function fRetDadosClienteConsumidor(strDocumento, strCampo: String): String;
    function fRetornaDescricaoVeic(strPlaVei: String): String;
    function fFrtStrExcel(strValor: String) : String;
    function fRetNomClienteConsumidor(strCodigo: String): String;
    function fStrLocateLinGru(objCodigo: TObject;
                              arrLinha: TConsultasArray;
                              strNomCampo,
                              strNomPar: String;
                              blnSemAND: Boolean = False;
                              blnNegar: Boolean = False;
                              strCodigo: String = '';
                              blnAndFinal: Boolean = False): String;
    function fReplicatorStr(strRepl: String; intTamanho: Integer): String;
    function fRetNomDep(strCodDep: String): String;
    function fRemoveAcento(Str: String): String;
    function fRetDesConPag(strCodCnd: String): String;
    function IfNull(varValor, varDefault: Variant): Variant;
    function fValidaEstado(strUf: String): Boolean;
    function fRetNomeEstado(strNomeEstado: String): String;
    function fRetNomeOperador(strCodOpe: String): String;
    function fRetSenhaVendedor(strCodVen: String): String;
    function fValidaGerSubVen(blnLib: Boolean; strTipo: Char; edtCod, edtDes: TEditFocus; strTitulo:String=''): Boolean;
    function fRetNomeServico(Const strCodSer: String): String;
    function fRetNomTransportadora(strCodTra: String): String;
    function fDescricaoFrete(strTipo: String): String;
    function fRetDesForPag(strCodFpg: String): String;
    function fRetCidEmpresa(strCodEmp: String): String;
    function fDiaDeFolga(dtaDta: TDateTime;
                         blnConsideraSabado : Boolean = True;
                         strCodCid: String = ''): Boolean;
    function fGetZClient(Owner: TComponent; strSQL: String = ''): IZClient;
//    function fGetMesesGiro(Owner: TComponent; intAnos: Integer): IMesesGiro;
    function fComponentByName(Owner: TWinControl; strNome: String): TComponent;
    function fRetDesSubReg(strCodSub: String): String;
    function fGetCamGer(Owner: TComponent): ICamGer;
//    function fGetTValorRecebido: IValorRecebido;
    function fStatusCndPag(strCndPag: String): Integer;
    function fRetDescFpg(Const strCodFpg: String): String;
    function fRetPerComIndice(fltValor, fltValorNt: Double; blnAtingiu: Boolean): Double;
    function fRetMetaIndice: Double;
    function fRetTipoForaConPag(strCodCnd: String): String;
    function fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
    function fRetNomeMotorista(strCodMot: String; blnAtivos: Boolean = False): String;
    function fCriaClientDatset(qryOrigem: TDataSet; blnVazio: Boolean = False; AOwner: TComponent = Nil): TUniClientDataSet;
    function fMediaTime(strMedia: String): Integer;
    function fSegToTempoStr(intSegundos: Integer): String;
    function fRetNomeConta(strCodCta: String): String;
    function fRetMotivoVendasPerdidas(Const strCodMot: String): String;
    function fRetDescGrupoCompra(Const strCodGru: String): String;
    function fRetQuantPendentePedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): Double;
    function fRetProximaDtaEntrPedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): String;
    function fRetNomeProfissional(Const strCodPro: String): String;
    function fRetNomeParceiro(Const strCodPar: String): String;
    function fGetConfTinta(strIdePro: String): IConfTinta;
    function fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela : String; fltCodigo: Double) : String;
//    function fGetTCadFun(Owner: TComponent): ICadFun;
    function fSegToTimeStr(Segundos: Double): String;
    function fRetMotorista(Const strCodMot: String): String;
    function fRetCidade(Const strCodigo: String): String;
    function fRetNomRegiao(Const strCodReg: String): String;
    function fGetTExtratoComissaoProfissional(dtaEntIni,
                                              dtaEntFin,
                                              dtaBaiIni,
                                              dtaBaiFin: TDateTime;
                                              strCodPro,
                                              strCodAti,
                                              strCodCli,
                                              strCodRed,
                                              strCodEmp: String;
                                              fltVlrCom: Double;
                                              intCalcul: Integer;
                                              strTipFil: String;
                                              strTCoPro: String): IFastPrintFile;
    function fGetTFastPrintFileEditor(AOwner: TComponent): IFastPrintFileEditor;
    function fGetObjFastPrintFileEditor(): TObject;
    function fGetTReciboCtp(cdsDados : TUniClientDataSet): IFastPrintFile;
    function fCriaClientDatasetReciboCTP : TUniClientDataSet;
    function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fRetVS_strTipExp: String;
    function fUsaQtdPendenteEntregaFutura: Boolean;
    function fRetDescGrupoAtividade(strCodGat: String): String;
    function fEhLetra(strCaract: String): Boolean;
    function fSomenteLetra(str: String): String;
    function fGetTMetAno(blnGlobal: Boolean = False; blnEmpOrigem: Boolean = False; strComCus: String = ''): IMetAno;
    function fRetSiglaUni(const strCodUni: String): String;
    function fRetSiglaUnidade(const strCodUni: String; qryAux: TUniQuery = Nil): String;
    function fRetSiglaUniConsulta(const strSigUni: String): String;
    function fValidaAcessoMultSelEmpresa(arrSelecao: TConsultasArray; Var strEmpNegadas: String): Boolean;
    function fGetMemoryTableNameEntregaFutura: String;
    function fRetDataPortador(strCodPor: String): TDateTime;
    function fCriaMemoryTableEntregaFutura(strNomTab: String;
                                         strCodEmp: String;
                                         strCodIte: String = '';
                                         strNumLot: String = '';
                                         blnConverteML: Boolean = False;
                                         blnApenasCriacao: Boolean = False;
                                         blnFaturamento: Boolean = False;
                                         strMotFut: String  = '';
                                         blnPorLote: Boolean = False): Boolean;
    function fDropTable(strNomeTabela: String): Boolean;
    function fRetSaldoAnterior(strCodPor: String; dtaDataIni: TDateTime; strCodEmp: String = '';
                             sitSitLan: TSituacaoLancBancario = sitTodos): Currency;
    function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fRetNomEvento(strCodEve: String): String;
    function fRetNomTipoAtend(strCodigo: String): String;
    function fCriaDataSource(DataSet: TDataSet): TDataSource;
    function fCampoExiste(const strTabela, strCampo: String): Boolean;
    function StringToFloat(str : String) : Extended;
    function fCadEmp(strNomCampo: String): String; Overload;
    function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery): String; Overload;
    function fStrTituloPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus): String;
    function fStrTitulo(edtCodigo, edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo: String): String; overload;
    function fItemEstrutura(strCodIte: String): Boolean;
    function fRetUnidadeItem(strCodIte: String): String;
    function fRetMarcaItem(strCodIte: String): String;
	  function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
    function fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String;
    function fCon_Precos(fltPreAtu: Double; intTipPre: Integer; blnCalGua: Boolean;
                         dtaDtaMoe: TDate; blnConGua: Boolean = False): Double;
    function fRetDesSfz(strCodigo: string): String;
    function fGetNumLinhasMemo(strMemo: String): Integer;
    function fRetNomCanalAcesso(Const strCodCac: String): String;
    function fCriaClientDataSetClientesDebitos: TUniClientDataSet;
    function fEhEstadoRegraZonaFranca(strEstado: String): Boolean;
    function fExt1(strS : String; strIdioma: String = 'P'): String;
    function fExt2(strS : string; strIdioma: String = 'P'): String;
    function fExt3(strS : string; strIdioma: String = 'P'): String;
    function fExtDezena(strS : String; strIdioma: String = 'P'): String;
    function FMes_Espano(dtaData: TDateTime; intTam: Integer): String;
    function fArqIni(ReadWrite :Integer; NomChave, NomSecao, Conteudo : String; strNomArq : String = '') : String;
    function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
    function fValidaCndPag(strCndPag: String; blnPerRep: Boolean = False): Boolean; overload;
    function fValidaCndPag(strCndPag: String; Var strCndRet: String;
      dtaDtaBas: TDateTime; blnPerRep: Boolean = False): Boolean; overload;
    function fRetNomCfg(strCodCfg: String): String;
    function fRetNomCfgTin(strCodCfg: String): String;
    function fPreInv(strAlias : String = ''; strAliasImpFed : String = ''; strPreInv: String = ''):String;
    function fPreInvTitulo(strPreInv: String = ''): String;
    function fRoundSql(const strCampo: String; const intDecimais: Integer): String;
    Function fRetSiglaEmpresa(strCodEmp: String): String;
    function fRetMascaraFone(opcPais: TPais): String;
    function fRetMascaraFonePais: String;
    function fVerificaCampoPrcCmpImp(dtaBase: TDateTime): Boolean;
    function fRetornaComposicaoPadrao: String;
    function fRetDebitoCliente(strCodCli: String): Double;
    function fRetDescCentroCusto(strCodCta: String): String;
    function fExisteCheque(strDocume, strCodEmp: String; intSeqCon: Integer; qryCheques: TUniQuery): Boolean;
    function fGetTFuncoesEditorFast: IFuncoesEditorFast;
    function fDigQuantidade(strCaption, strLabel: String; Var intQtdDig: Integer;
      intMin: Integer = -MaxInt; intMax: Integer = MaxInt): Boolean;
    function fFormataCEP(strCEP: String): String;
    function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime): TDateTime;
    function fRetNomeCartao(strCodCar: String): String;
    function fRetValorCfg(strCodCfg, strValCfg: String): String;
{    function fGetTIteBar(opcCriacaP: TOpcaoCriacao = opcFuncoes;
                         qryTabIteP: TUniQuery = Nil;
                         dbeCodBarP: TDBEditFocus = Nil;
                         dbeBarEmbP: TDBEditFocus = Nil;
                         dbeEmbalaP: TDBEditFocus = Nil;
                         wncLocCadP: TWincontrol  = Nil;
                         strCodIteP: String = ''): IIteBar;
                         }
    function fVerificaImpressora(strNomeImpr: String): Boolean;
    function fPergunta(strMensagem: String): Boolean;
    function fRetTopoEtiqueta(strTipEti: String): Integer;
    function fItemEstruturaIndustrial(strCodIte: String): Boolean;
    function fRetNomCor(strCodCor: String): String;
    function fCriaAggregateField(cdsClient: TUniClientDataSet;
                                 strFieldName,
                                 strExpression: String;
                                 strDisplayFormat: String = '';
                                 blnActive: Boolean = True): TAggregateField;
    function fGetTOrdenacao(Owner: TComponent; strCampos: String; intCodEtiP: Integer): IOrdenacao;
    function fMskDigitos(intDigitos: Integer): String;
    function fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean;
//    function fDescontoClienteProfissional(strCodCli: String): Boolean;

    function fSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; intQtdCol: Integer = 0): String;
    function fExecutaSQL(strSQL: String): Boolean;
    function fRetMltVenItem(Const strCodIte: String): Double;
    function fRetiraZerosEsquerda(strDado: String): String;
    function fRetNomeMarca(strCodigo: String): String;
    function fRetNomTabAuxMov(strNomTab: String): String;
    function fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes: String): String;
//    function fGetTMadeireira: IMadeireira;
    function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double; Overload;
    function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; strDtaPag: String; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double; Overload;
    function fRetNomeBancoSelec(Const strCodBco: String): String;
    function fGetTFinanceira(AOwner: TComponent): IFinanceira;
    function fRetDesRegiao(strCodReg: String): String;
    function fCriaDiretorio(strPath: String): Boolean;
    function fRetFantasiaEmpresa(strCodEmp: String = ''): String;
    function fGetTCamposUso: ICamposUso;
    function fGetTFuncMacro: IFuncMacro;
    function fInformacaoAdicionalEtiquetaItens: String;
    function fVer_Banco_Carteira(strCodBan, strChave: String;
                                 Var strBanRet: String;
                                 Var intCarRet: Integer;
                                 blnVeioImpBol: Boolean = True): Boolean;
    function fArqIniAutban(ReadWrite: Integer; NomChave, NomSecao, Conteudo: String): String;
    function fFormataCCusto(strValor: String): String;
    function fFilaExiste(strFila: String): Boolean;
    function fGetMenu(strTitulo: String;
                      arrOpcoes: Array Of String;
                      intOpcao: Integer;
                      blnSaiComEsc: Boolean = False): Integer;
    function fAtuCfgSis(strCamCfg, strValCfg: String; strCodEmp: String = '') : Boolean;
    function fRetNatOpe(strCodCfo: String): String;
    function fInc(Var intValor: Integer) : Integer;
//    function fRetTelaSelecaoImp(Var oleDados: OleVariant; var strOrdenacao: string; var bVerificarEmail: boolean): Boolean;
    function fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;
    function fGetTipoAbfCliente(const strCodCli: String): String;
    function fRetEnderecoEmpresa(strCodEmp: String): String;
    function fImprimeEtiqueta(prmDllRel: Pointer; strNomFun: String = 'fimprimeetiquetas'): Boolean;
    function fRetDesAbfPis(strAbfPis: String): String;
    function fRetDesAbfCof(strAbfCof: String): String;
    function fRetDesCstPis(strCstPis: String): String;
    function fRetDesCstCof(strCstCof: String): String;
    function fValidaEcf(strCodEcf: String; var strModelo: String): Boolean;
    function fRetMesExtenso(intMes: Integer): String;
    function fRetDesAbfIcm(strCodAbf: String): String;
    function fDigEmail(var strDestinatario, strEmailDestinatario: String) : Boolean;
    function fRetPreComMenosDescForn(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet = Nil;
        strCALSOP: String = ''): Double;
    function fRetNomLocFisica(Const strCodLoc: String): String;
    function fGetSQLQtdEntregaFuturaItem(strCodIte, strCodEmp: String; strNumLot: String = '';
      strMotFut: String = ''): String;
    function fRetNumLoteConsulta(const strNumLot: String): String;

    function fGetTCadLot(Owner: TComponent; qryCadTab: TUniQuery = Nil): ICadLot;
    function fGetTFiltrosRelatorio : IFiltrosRelatorio;
    function fRetConsumidorDocumento(strNumDoc, strEspDoc, strCodEmp: String): String;
    function fRetGrupoItem(strCodIte: String): String;
    function fRetornaCndPag(arrDatas: TDateArray; dtaDtaBas: TDateTime): String; Overload;
    function fRetornaCndPag(const arrDuplicata: TarrDuplicata; dtaDtaBas: TDateTime): String; Overload;
    function fRetSomenteNumeros(strTexto: String): String;
    function fRetNomeSoGrupo(strCodigo: String): String;
    function fRetLitros(strCodIte: String): Double;
    function fRetNomProdutoAcabado(strCodIte, strCodEmp: String; strCodEmpAca : String = ''): String;
    function fRetNomTabelaDinamica(strCodTab: String): String;
    function fSQLParam(edtValor: TCustomEdit; strNomCam: String; strNomPar: String = ''; blnLike: Boolean = False): String;
    function fSQLParamPerido(mskDtaIni: TMaskEditFocus; strNomCam: String;
                             strParIni: String = 'DTAINI';
                             strParFin: String = 'DTAFIN'): String;
    function fRetNomeArmazem(Const strCodAmz: String): String;
    function fRetNomeTabelaPreco(strCodTab: String): String;
    function fCheckParent(Sender, Parent: TWinControl): Boolean;
    function fGetConfiguracao : IConfiguracao;
    function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): Double;
    function fRetNomTabelaPreco(strCodTab: String): String;
    function fCalculaPrecoCompraLiq(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
                                  fltDesf04, fltDesf05, fltDesf06: Double;
                                  blnPreDol: Boolean = False): Double; overload;
    function fCalculaPrecoCompraLiq(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet): Double; overload;
    function fValidaMesAno(mskMesAno: TMaskEditFocus; strInfErr: String): Boolean; Overload;
    function fValidaMesAno(mskMesAno: String; strInfErr: String): Boolean; Overload;
    function fRetTipoDepartamento(strCodigo, strTipo: String): String;

    function fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean): String;
    function fSQLCamposQuantidadePendenteCompra(blnFiltraTE, blnLibPcm: Boolean): String;
    function fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean): String;

    function fRetTipoImpressora(var strTipImp: String): Boolean;
    function fAcertaMaskTel(strFone: String): String;
    function fEnviarEMailComAnexo(Para, Assunto, Texto, Arquivo: String): Integer;
    function fEnviarEmail(strTitulo, strArquivo, strDestinatario: String): Boolean;
    function fDesconsiderarNaQtdLimDaPromoItensUnitarMaior: Boolean; Inline;

    function fPesqTabelaPreco(Selff      : TForm;
                              edtCodigo  : TCustomEdit;
                              edtDescri  : TEditFocus;
                              qryTabela  : TUniQuery;
                              Var chrKey : Char;
                              Var arrSel : TConsultasArray;
                              blnConSim  : Boolean = True): Boolean;
    function fPesqClaIPI(Selff     : TForm;
                         edtClaIPI : TCustomEdit;
                         qryConIPI : TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim : Boolean = True;
                         strTitulo : String  = 'Consulta de Classificação de IPI'): Boolean;
    function fPesqCores(Selff     : TForm;
                        edtCodigo : TCustomEdit;
                        edtDescri : TEditFocus;
                        qryTabela : TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim : Boolean = True;
                        strCodGra : String = ''): Boolean;
    function fPesqConfiguracaoRel(opcTipCfg : TTipoConsultaSimples;
                                  Selff      : TForm;
                                  edtCodigo : TCustomEdit;
                                  edtDesPor : TEditFocus;
                                  qryTabela : TUniQuery;
                                  Var chrKey: Char;
                                  Var arrSel: TConsultasArray;
                                  strWhere  : String;
                                  blnConSim : Boolean = True;
                                  strTitulo : String = 'Configuração de Relatórios'): Boolean;
    function fPesqGrupo(Selff      : TForm;
                        edtCodigo : TCustomEdit;
                        edtDescri : TEditFocus;
                        qryTabela : TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim : Boolean = True;
                        blnDesRes : Boolean = False): Boolean;
    function fPesqItem(opcTipIte: TTipoConsultaItem;
                       Selff     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDesIte: TCustomEdit;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True;
                       objFrmPnl: TPanelCx = Nil;
                       strTitulo: string = 'Consulta de Itens';
                       strTabPre: String = '';
                       strConPag: String = '';
                       fltTaxVpr: Double = 0;
                       blnEmpFat: Boolean = False;
                       blnExiPar: Boolean = False;
                       intOpcAtivos: Integer = 0;
                       opcCodIte: TCodigoRetornoItem = cdrCodIte;
                       strAplica: String = '';
                       blnPedCom: Boolean = False;
                       strCodCli: String = '';
                       blnMostrarPrecos: Boolean = True;
                       blnTablet: Boolean = False;
                       blnConsiderarExiLis: Boolean = True;
                       strCodCmp: String = '';
                       blnDepMatPriIndustrial: Boolean = False;
                       blnDepProAcaIndustrial: Boolean = False;
                       blnDepProEmbIndustrial: Boolean = False;
                       blnDepProGraIndustrial: Boolean = False;
                       blnVeioF11: Boolean = False;
                       blnSomenteEstrutura: Boolean = False): Boolean;
    function fPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
                             Selff     : TForm;
                             edtCodigo: TCustomEdit;
                             edtNomEmp: TCustomEdit;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;
    function fPesqOperador(Selff     : TForm;
                           edtCodigo: TCustomEdit;
                           edtDescri: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True;
                           blnAtivos: Boolean = False;
                           blnGerentes: Boolean = False;
                           blnMecanicos: Boolean = False;
                           blnVenRepre: Boolean = False;
                           blnCompradores: Boolean = False;
                           blnAdministrativo: Boolean = False;
                           blnSubGerentes: Boolean = False): Boolean;
    function fPesqMarcas(Selff     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
    function fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                          Selff     : TForm;
                          edtCodigo: TCustomEdit;
                          edtNomEmp: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True;
                          blnResEmp: Boolean = False;
                          strEmpPfl: String  = '';
                          blnAceCtr: Boolean = False;
                          strAceCtr: String = ''): Boolean;
    function fPesqSubRegiao(Selff     : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True): Boolean;
    function fPesqRegiao(Selff     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
    function fPesqUnidade(Selff      : TForm;
                          edtCodigo : TCustomEdit;
                          edtUnidade: TEditFocus;
                          edtSigla  : TEditFocus;
                          qryTabela : TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim : Boolean = True;
                          blnPesqSigla : Boolean = False): Boolean;
    function fPesqGrupoProduto(Selff         : TForm;
                             edtCodigo    : TCustomEdit;
                             edtDescricao : TEditFocus;
                             qryTabela    : TUniQuery;
                             Var chrKey   : Char;
                             Var arrSel   : TConsultasArray;
                             blnConSim    : Boolean = True): Boolean; inline;
    function fPesqTipoServico(Selff    : TForm;
                              edtCodigo: TCustomEdit;
                              edtDescri: TEditFocus;
                              qryTabela: TUniQuery;
                              Var chrKey: Char;
                              Var arrSel: TConsultasArray;
                              blnConSim: Boolean = True): Boolean; inline;
    function fPesqCidade(Selff     : TForm;
                         edtCodigo: TCustomEdit;
                         edtCidade: TEditFocus;
                         edtEstado: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
    function fPesqGrupoOperador(Selff     : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                blnConSim: Boolean = True): Boolean;
    function fPesqCondicoesPgto(Selff     : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                blnConSim: Boolean = True;
                                blnTablet: Boolean = False;
                                opcTipCon: TTipoConsultaCondPagto = conCndSimples;
                                fltMarDoc: Double = 0;
                                fltValDoc: Double = 0;
                                strCodCli: String = '';
                                blnAtivas: Boolean = False;
                                blnFaturamento: Boolean = False): Boolean;
    function fPesqDiversos(Selff        : TForm;
                           edtCodigo   : TCustomEdit;
                           edtDescri   : TEditFocus;
                           qryTabela   : TUniQuery;
                           Var chrKey  : Char;
                           Var arrSel  : TConsultasArray;
                           blnConSim   : Boolean = True;
                           blnVerStatus: Boolean = False;
                           blnVerEmpAce: Boolean = False;
                           strCodCli   : String  = ''): Boolean;
    function fPesqParceiro(Selff    : TForm;
                           edtCodigo: TCustomEdit;
                           edtDescri: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True): Boolean;
    function fPesqConsumidores(Selff     : TForm;
                               edtCodCon : TDBEditFocus;
                               edtDesCon : TDBEditFocus;
                               edtCgcCpf : TEditFocus;
                               mskNumCgc : TMaskEditFocus;
                               qryTabela : TUniQuery;
                               Var chrKey: Char;
                               Var arrSel: TConsultasArray;
                               strCodCli : String  = '';
                               blnConSim : Boolean = True): Boolean;
    function fPesqVeiculos(Selff     : TForm;
                           edtCodigo: TCustomEdit;
                           edtDescri: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True;
                           blnComMsk: Boolean = True): Boolean;
    function fPesqPortador(opcTipPor: TTipoConsultaSimples;
                           Selff     : TForm;
                           edtCodigo: TCustomEdit;
                           edtDesPor: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True;
                           strTitulo: String = 'Consulta de Portadores';
                           strBolFat: String = '';
                           blnSalPor: Boolean = False): Boolean;
    function fPesqOcorrencia(Selff    : TForm;
                             edtCodigo: TCustomEdit;
                             edtDescri: TEditFocus;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;
    function fPesqServicos(Selff    : TForm;
                           edtCodigo: TCustomEdit;
                           edtDescri: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True;
                           blnAutCen: Boolean = False): Boolean;
    function fPesqFormaPgto(opcTipPgt: TTipoConsultaFormaPagto;
                            Selff    : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True;
                            blnTablet: Boolean = False): Boolean;
    function fPesqCampanha(Selff      : TForm;
                           edtCodCam  : TCustomEdit;
                           edtDesCam  : TEditFocus;
                           qryConCam  : TUniQuery;
                           Var chrKey : Char;
                           Var arrSel : TConsultasArray;
                           blnConSim  : Boolean = True;
                           strTitulo  : String = 'Consulta de Campanhas'): Boolean;
    function fPesqMotorista(Selff    : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True;
                            blnAtivos: Boolean = False): Boolean;
    function fPesqEntrga(Selff     : TForm;
                         edtNumEnt : TCustomEdit;
                         qryConEnt : TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSimp: Boolean = True;
                         strTitulo : String = 'Consulta de Entregas'): Boolean;
    function fPesqMotVendasPerdidas(Selff    : TForm;
                                    edtCodigo: TCustomEdit;
                                    edtDescri: TEditFocus;
                                    qryTabela: TUniQuery;
                                    Var chrKey: Char;
                                    Var arrSel: TConsultasArray;
                                    blnConSim: Boolean = True): Boolean;
    function fPesqGrupoCompra(Selff    : TForm;
                              edtCodigo: TCustomEdit;
                              edtDescri: TEditFocus;
                              qryTabela: TUniQuery;
                              Var chrKey: Char;
                              Var arrSel: TConsultasArray;
                              blnConSim: Boolean = True): Boolean;
    function fPesqPromocoes(Selff     : TForm;
                            edtCodPro : TEditFocus;
                            edtDesPro : TEditFocus;
                            qryTabela : TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim : Boolean = True): Boolean;
    function fPesqGrupoAtividade(Selff    : TForm;
                                 edtCodigo: TCustomEdit;
                                 edtDescri: TEditFocus;
                                 qryTabela: TUniQuery;
                                 Var chrKey: Char;
                                 Var arrSel: TConsultasArray;
                                 blnConSim: Boolean = True): Boolean;
    function fPesqTipoAtendimento(Selff     : TForm;
                                  edtCodigo: TCustomEdit;
                                  edtDescri: TEditFocus;
                                  qryTabela: TUniQuery;
                                  Var chrKey: Char;
                                  Var arrSel: TConsultasArray;
                                  blnConSim: Boolean = True): Boolean;
    function fPesqSetFlz(Selff      : TForm;
                         edtCodigo  : TCustomEdit;
                         edtDescri  : TEditFocus;
                         qryTabela  : TUniQuery;
                         Var chrKey : Char;
                         Var arrSel : TConsultasArray;
                         blnConSim  : Boolean = True): Boolean;
    function fPesqTipoCliente(Selff      : TForm;
                              edtCodigo  : TCustomEdit;
                              edtDescri  : TEditFocus;
                              qryTabela  : TUniQuery;
                              Var chrKey : Char;
                              Var arrSel : TConsultasArray;
                              blnConSim  : Boolean = True): Boolean;
    function fPesqCfgSis(Selff      : TForm;
                         edtCodCfg  : TCustomEdit;
                         edtDesCfg  : TEditFocus;
                         qryConCfg  : TUniQuery;
                         Var chrKey : Char;
                         Var arrSel : TConsultasArray;
                         blnConSim  : Boolean = True;
                         strTitulo  : String  = 'Cosulta de Configurações'): Boolean;
    function fPesqCfgTin(Selff      : TForm;
                         edtCodCfg  : TCustomEdit;
                         edtDesCfg  : TEditFocus;
                         qryConCfg  : TUniQuery;
                         Var chrKey : Char;
                         Var arrSel : TConsultasArray;
                         blnConSim  : Boolean = True;
                         strTitulo  : String  = 'Cosulta de Configurações da Tinta de Máquina'): Boolean;
    function fPesqPesquisa(Selff     : TForm;
                           edtCodigo: TCustomEdit;
                           edtDescri: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True): Boolean;
    function fPesqCamsposLayout(Selff    : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                strFiltro: String;
                                intPosCam: Integer = -1;
                                blnConSim: Boolean = True): Boolean;
    function fPesqLayout(Selff    : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         strTipImp: String;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
    function fPesqECF(Selff     : TForm;
                      edtCodigo: TCustomEdit;
                      edtDescri: TEditFocus;
                      qryTabela: TUniQuery;
                      Var chrKey: Char;
                      Var arrSel: TConsultasArray;
                      blnConSim: Boolean = True): Boolean;
    function fPesqLoteItens(Selff      : TForm;
                            edtNumLote : TEditFocus;
                            edtCodIte  : TEditFocus;
                            intDecUni  : Integer;
                            qryTabela  : TUniQuery;
                            Var chrKey : Char;
                            Var arrSel : TConsultasArray;
                            blnConSim  : Boolean = True): Boolean;
    function fPesqPedidoCompra(Selff      : TForm;
                               edtCodPed  : TCustomEdit;
                               qryTabela  : TUniQuery;
                               Var chrKey : Char;
                               Var arrSel : TConsultasArray;
                               Var strDoc : String;
                               strCodEmp  : String;
                               intIndice  : Integer;
                               blnConSim  : Boolean = True;
                               objFrmPnl : TPanelCx = Nil;
                               strLitGal  : String = '3.600';
                               strTitulo  : String = 'Consulta de Pedidos de Compra'): Boolean;
    function fPesqProdAcabado(Selff     : TForm;
                              edtCodAca : TCustomEdit;
                              edtDesAca : TEditFocus;
                              qryConAca : TUniQuery;
                              Var chrKey: Char;
                              Var arrSel: TConsultasArray;
                              strEmpAca : String;
                              blnConSim : Boolean = True;
                              strTitulo : String  = 'Consulta de Produtos Acabados';
                              strEmpEst : String = ''): Boolean;
    function fPesqEntregasRotasRegiao(Selff     : TForm;                            {* Formulário                                  *}
                                      edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                      edtDescri : TEditFocus;                       {* Edit da Cidade                              *}
                                      qryTabela : TUniQuery;                        {* Query                                       *}
                                      Var chrKey: Char;                             {* Key                                         *}
                                      Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                      blnConSim : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                                      strCodCid : String = '';                      {* Cidade do endereco de entrega               *}
                                      blnFiltroPorData : Boolean = True): Boolean;

    function fConsulta(arrSql,
                       arrCampos,
                       arrOrdenacao: Array Of String;
                       strCampoChave,
                       strTabela,
                       strNomForm,
                       strTitulo: String;
                       qryAux: TUniQuery;
                       objFrmPnl: TPanelCx;
                       blnSimples: Boolean;
                       Var arrSelec: TConsultasArray;
                       strCodBusca: String = 'AUTOINCREM';
                       objConsulta: Pointer = Nil;
                       blnTablet: Boolean = False;
                       blnConIte: Boolean = False;
                       strCampoChave2 : String = ''): Boolean;

    function fGetStrCodigos(edtCodigo: TEditFocus; arrLinha: TConsultasArray; blnQuoted: Boolean = False): String;

    procedure pDestroiModulo(var NomeForm);
    procedure pCriarForm(ClasseForm: TFormClass; NomeForm: TForm);
    procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
    procedure pFreeAndNil(var frmForm);
    procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');
    procedure pIniciaLogLeak(intDebugH: Byte; strArquivo: String);
    procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm: TDataModule);
    procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm);
    procedure pValidaProCod(strNomeTabela: String);
    procedure pEnabled(NomeForm: TForm; Habilitar: Boolean);
    procedure pSetButton(NomeTabela: TDataSet;
                         btnNovo,
                         btnConfirma,
                         btnExclui,
                         btnCancela,
                         btnEditar,
                         btnLocalizar,
                         btnSair: TBitBtnLocked);
    procedure pAjudaAutcom(Handle: THandle; intNumHlp: Integer);
    procedure pGravarErro(GravarErro: Boolean; MensagemErro: String);
    procedure pCarregaConfImprRel(Const strNomeForm : String;
                                    Var strNomImp: String;
                                    Var strTipImp: String;
                                        strCodEmp: String = '';
                                        blnPreImp: Boolean = False);
    procedure pCarregaConfImpr(Var qryCfgRel: TUniQuery;
                             Const strNomeForm : String;
                                   strCodEmp: String = '';
                                   strNomeFila : String = '');
    procedure pDesmarcaLista(edtCodigo: TCustomEdit;
                         Var arrLinha: TConsultasArray;
                             strTempTable: String = '';
                             intTamCamp: Integer = 0);
    procedure pEdtCodSelectExit(edtCodigo       : TCustomEdit;
                                edtDescri       : TEditFocus;
                            Var arrLinha        : TConsultasArray;
                                fncRetNome      : TfncRetNome;
                                fncRetNomeConst : TfncRetNomeConst;
                                strMsgErr       : String;
                                intTamCamp      : integer = 0;
                                blnNegar: Boolean = False;
                                strCodigo: String  = 'Código');

    Function fArrCodigosToLista(strCodigo: String; arrCodigos: TConsultasArray; blnQuoted: Boolean = True): String;

    procedure pPreencheCombo(var cmb: TCustomComboBox; arr: Array of String; blnLimpa: Boolean = True);
    procedure pSetaParam(strText: String; arrLinha: TConsultasArray; Var strLinha: String; strNomPar: String; qryRelatorio: TUniQuery); Overload;
    procedure pSetaParam(edtValor:TEditFocus; strNomPar: String; qryRelatorio: TUniQuery; blnLike: Boolean = False); overload;
    procedure pSetaParamOR(objCodigo: TObject; arrLinha: TConsultasArray; strNomPar: String; qryRelatorio: TUniQuery);
    procedure pCriaTabelaDel(strNomTab: String);
    procedure pSetaClient(cdsClient: TDataSet);
    procedure pSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; qryResult: TUniQuery);
    procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
    procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
    procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False);
    procedure pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);
    procedure pMensagemOk(strMensagem: String);
    procedure pDropTable(strTempTable: String);
    procedure pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery);
    procedure pPesquisaCadAti(qryTabOri, qryTabela: TUniQuery; strCodAti: String);
    procedure pPesquisaAbfIcm(qryTabOri, qryTabela: TUniQuery; strCodAbf: String; strEstado: String = '');
    procedure pExecArquivo(strArquivo: String; Handle: THandle);
    procedure pPesquisaCadPor(qryTabOri, qryTabela: TUniQuery; strCodPor: String);
    procedure pCarrega(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray);
    procedure pPesquisaCadCli(qryTabOri, qryTabela: TUniQuery;
                              strCodCli: String;
                              blnVerCnd: Boolean = True;
                              blnVerCli: Boolean = False);
    procedure pZeraDigDuplic(var arrDuplicata: TarrDuplicata);
    procedure pAdicionaCheques(qryCadChq: TDataSet; cdsCadChq: TUniClientDataSet);
    procedure pCnfEtiqueta(tipTipEti: TTiposEtiqueta = etiVazio);
    procedure pSetaParamPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus; qryRelatorio: TUniQuery;
                                strParIni: String = 'DTAINI';
                                strParFin: String = 'DTAFIN');
    procedure pRetDadosItem(strCodIte, strGrupo: String; Var strNome, strRefere,
      strMarca, strUnidad: String); Overload;
    procedure pRetDadosItem(strCodIte: String; Var strNome, strRefere,
      strMarca, strUnidad: String); Overload;
    procedure pCalcSaldoInicialItens(Var fltSaldoIni: Double;
                                         dtaDtaBal,
                                         dtaDtaIni: TDateTime;
                                         strCodIte: String;
                                         strCodEmp: String;
                                         blnEntFut: Boolean = True;
                                         strNumLot: String = '');
    procedure pUltimaCompra(strCodIte, strCodEmp, strAnoMes: String;
      chrOpcInv: Char; var dtaUltComp: TDate; var strNumDoc: String);
    procedure pAtuVarGlobaisSimples;
    procedure pCarregaTabPre(cbxTabPre: TComboBox); overload;
    procedure pCarregaTabPre(cbxTabPre: TDBComboBoxFocus); overload;
    procedure pRetFilasImpressao(Var arrFilas: TarrFilas);
    function fClienteTemCndPagAssociado(strCodCli: String): Boolean;

    function fExisteLote(strNumLot: String; strCodIte: String; strCodEmp: String): Boolean;
    function fComplementoWhereSQLPosContabilReceber(strCodEmp: String): String;
    function fComplementoWhereSQLPosContabilPagar(edtCodEmpresa: TEditFocus;
                                                  arrEmp: TConsultasArray;
                                                  blnFiltrouPortador: Boolean;
                                                  edtCodPortador: TEditFocus;
                                                  arrPor: TConsultasArray;
                                                  strCodEmp: String = '';
                                                  blnSomenteJurosEDescontos: Boolean = False): String;
    function fComplementoWhereSQLPosContabilCartao(edtCodEmpresa: TEditFocus;
                                                   arrEmpresa: TConsultasArray;
                                                   strCodEmp: String = ''): String;
    function fComplementoWhereSQLPosContabilCheque(strCodEmp: String): String;
    function fRetornaAliquotaIcmsInternaDoEstado(strEstado: String): Double;
    function fIsValidDate(Sender: TWinControl): Boolean; overload;
    function fRetDadosEmitente(strNumCgc: String; var strNomEmi,
    strEndere, strTele01: String): Boolean;
    function fRetDesMotivoAtend(strCodMot: String): String;
    function fCarregaCartoesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
    function fCarregaChequesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
    function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
    function fUsaSat(strCodEmp : String = ''): Boolean;
    function fEhFeriado(dtaData: TDateTime; strCodCid: String = ''): Boolean;
    function fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double): Double;
    function fRetConPagCodCnd(strCodCnd: String): String;
    function fRetornaSaldoDisponivel(strCodIte: String; blnCnvMl : Boolean = False; blnFaturamento: Boolean = True; strNumLot : String = ''; blnConsiderarPedidos : Boolean = True): Double;
    function fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada: String; 
                                                              arrAlias: TParamArrayString=NIL;
                                                              arrMacroParaCadaItemDoarrAlias: TParamArrayString=NIL;
                                                              arrApenasAsEspecies: TParamArrayString=NIL; 
                                                              strPrefixo: String='DET_';
                                                              strOperacaoSeSomenteValor: String=''): String;
    function fFormataCasaDecimalVIDRO(strMascaraDefault : Variant) : Variant;
    function fRetornaInfMedVIDRO(blnDoisPontos: Boolean = False; blnAbreviadoComprimento: Boolean = False;blnMaximo : Boolean = False; blnMensagem :Boolean = False;blnAbreviadoAltura : Boolean = False) : String;
    function fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
    function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
//    function fReservaParametros: IReservaParametros;
//    function fSaldoReservado(AParams: IReservaParametros): ISaldoReservado;
    function fSQLIn(objCodigo: TObject;
                    arrLinha: TConsultasArray;
                    strNomCampo,
                    strNomPar: String;
                    blnSemAND: Boolean = False;
                    blnNegar: Boolean = False;
                    strCodigo: String = ''): String;
    function fCommaText(stlListSelecao: TStringList;
                        blnQuoted: Boolean = False;
                        strSeparator : String = ', '): String;
    function fParametrosEntregaFutura: IParamEF;
    function fEntregaFutura(AParams: IParamEF): IEntregaFutura;
  End;

implementation

uses untFuncoesSimples, untConsultas, untCfgRel, untFuncoesConsulta,
  untFuncTinta, untCadPro, untValorPorExtenso, {untTipoFreteAtc,} untPesqAux,
  untTFuncMacro, untZClient, {untCamGer,} {untRelValorRecebido, {untControlePagtoFunc}
  untFastPrintEditor, {untExtratoComissaoProfissional, }untTMetAno, {untCadRcxx,}
  untCfgRepositorio, {untIteBar, }untTFuncoesEditorFast, untOrdenacao, {untTMadeireira,}
  untFinanceira, untFuncoesRel2, untCadLote, untFiltrosRelatorio, untTConfiguracao,
  {untReciboCtp, }untFuncoesEtiquetas; {untSaldoPedidoCompra;}
{ FuncoesRelatorio }

function TFuncoesRelatorio.fAbrirTabela(NomeTabela: TDataSet): Boolean;
begin
  Result := untFuncoesSimples.fAbrirTabela(NomeTabela);
end;

function TFuncoesRelatorio.fAcertaDataParaDiaUtil(
  const dtaOrigem: TDateTime): TDateTime;
begin
  Result := untFuncoesSimples.fAcertaDataParaDiaUtil(dtaOrigem);
end;

function TFuncoesRelatorio.fArqIni(ReadWrite: Integer; NomChave, NomSecao,
  Conteudo, strNomArq: String): String;
begin
  Result := untFuncoesSimples.fArqIni(ReadWrite, NomChave, NomSecao, Conteudo, strNomArq);
end;

function TFuncoesRelatorio.fArqIniAutban(ReadWrite: Integer; NomChave, NomSecao,
  Conteudo: String): String;
begin
  Result := untFuncoesSimples.fGetBancoConfig(ReadWrite, NomChave, NomSecao, Conteudo);
end;

function TFuncoesRelatorio.fArqIniLocal(ReadWrite: Integer; NomChave, NomSecao,
  Conteudo, strNomArq: String): String;
begin
  Result := untFuncoesSimples.fArqIniLocal(ReadWrite, NomChave, NomSecao, Conteudo, strNomArq);
end;

function TFuncoesRelatorio.fAtualizaProCod(strNomeTabela: String): String;
begin
  Result := untFuncoesSimples.fAtualizaProCod(strNomeTabela);
end;

function TFuncoesRelatorio.fAtuCfgSis(strCamCfg, strValCfg: String; strCodEmp: String = ''): Boolean;
begin
  Result := untFuncoesSimples.fAtuCfgSis(strCamCfg, strValCfg, strCodEmp);
end;

function TFuncoesRelatorio.fCalcMediaPagto(strConPag: String): Double;
begin
  Result := untFuncoesSimples.fCalcMediaPagto(strConPag);
end;

function TFuncoesRelatorio.fCalculaJurosCadCtr(dtaDtaVen: TDateTime; fltValDup,
  fltPerJur, fltPerMul: Double; intTolerancia: Integer): Double;
begin
  Result := untFuncoesSimples.fCalculaJurosCadCtr(dtaDtaVen, fltValDup, fltPerJur,
                                                  fltPerMul, intTolerancia);
end;

function TFuncoesRelatorio.fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed,
  fltDesOpe, fltOutVal: Double): Double;
begin
  Result := untFuncoesSimples.fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed,
  fltDesOpe, fltOutVal);
end;

function TFuncoesRelatorio.fCalculaJurosCadCtr(dtaDtaVen: TDateTime;
  strDtaPag: String; fltValDup, fltPerJur, fltPerMul: Double;
  intTolerancia: Integer): Double;
begin
  Result := untFuncoesSimples.fCalculaJurosCadCtr(dtaDtaVen, strDtaPag, fltValDup, fltPerJur,
                                                  fltPerMul, intTolerancia);
end;

function TFuncoesRelatorio.fCalculaPrecoCompraLiq(fltPreCom, fltDesf01,
  fltDesf02, fltDesf03, fltDesf04, fltDesf05, fltDesf06: Double;
  blnPreDol: Boolean): Double;
begin
  Result := untFuncoesSimples.fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01,
    fltDesf02, fltDesf03, fltDesf04, fltDesf05, fltDesf06, blnPreDol);
end;

function TFuncoesRelatorio.fCalculaPrecoCompraLiq(strCodIte, strCodEmp: String;
  cdsIteGer: TUniClientDataSet): Double;
begin
  Result := untFuncoesSimples.fCalculaPrecoCompraLiquido(strCodIte,
    strCodEmp, cdsIteGer);
end;

function TFuncoesRelatorio.fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double): Double;
begin
  Result := untFuncoesSimples.fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai,
    fltImpFed, fltDesOpe, fltDifal, fltFCP);
end;

function TFuncoesRelatorio.fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
  curPrecus, curPreven, curMarBru, curIcmsVenda, curImpFed, curDesOpe,
  curValCom: Currency; strMarMkp, strPcmPro: String;
  intDecUni: Integer): Double;
begin
  Result := untFuncoesSimples.fCalculaPrecoVenda(intOpcPrecoMargem, curPrecus,
    curPreven, curMarBru, curIcmsVenda, curImpFed, curDesOpe, curValCom, strMarMkp,
    strPcmPro, intDecUni);
end;

function TFuncoesRelatorio.fCampoExiste(const strTabela,
  strCampo: String): Boolean;
begin
  Result := untFuncoesSimples.fCampoExiste(strTabela, strCampo);
end;

function TFuncoesRelatorio.fCampoTabela(strCampo : String; strNomTab : String;
  arrCampoChave : Array Of String; arrValorChave : Array Of Variant; blnSempreLerBanco: Boolean = True):Variant;
begin
  Result := untFuncoesSimples.fCampoTabela(strCampo, strNomTab, arrCampoChave, arrValorChave, blnSempreLerBanco);
end;

function TFuncoesRelatorio.fCfgSis(strCamCfg: String; varTipVar: TVarType;
  strCodEmp: String): Variant;
begin
  Result := untFuncoesSimples.fCfgSis(strCamCfg, varTipVar, strCodEmp);
end;

function TFuncoesRelatorio.fCheckParent(Sender, Parent: TWinControl): Boolean;
begin
  Result := untFuncoesSimples.fCheckParent(Sender, Parent);
end;

function TFuncoesRelatorio.fGetConfiguracao : IConfiguracao;
begin
  Result := TConfiguracao.fGetConfiguracao;
end;

function TFuncoesRelatorio.fClienteConsumidor(strNomCli: String; blnCliBal, blnSeguradora: Boolean): Boolean;
begin
  Result := untFuncoesSimples.fClienteConsumidor(strNomCli, blnCliBal, blnSeguradora);
end;

function TFuncoesRelatorio.fClienteTemCndPagAssociado(
  strCodCli: String): Boolean;
begin
  Result := untFuncoesSimples.fClienteTemCndPagAssociado(strCodCli);
end;

function TFuncoesRelatorio.fCommaText(stlListSelecao: TStringList;
  blnQuoted: Boolean; strSeparator: String): String;
begin
  Result := untFuncoesSimples.fCommaText(stlListSelecao, blnQuoted, strSeparator);
end;

function TFuncoesRelatorio.fCommit: Boolean;
begin
  Result := untFuncoesSimples.fCommit;
end;

function TFuncoesRelatorio.fComplementoWhereSQLPosContabilCartao(
  edtCodEmpresa: TEditFocus; arrEmpresa: TConsultasArray;
  strCodEmp: String = ''): String;
begin
  Result := untFuncoesSimples.fComplementoWhereSQLPosContabilCartao(edtCodEmpresa, arrEmpresa, strCodEmp);
end;

function TFuncoesRelatorio.fComplementoWhereSQLPosContabilCheque(
  strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fComplementoWhereSQLPosContabilCheque(strCodEmp);
end;

function TFuncoesRelatorio.fComplementoWhereSQLPosContabilPagar(edtCodEmpresa: TEditFocus;
                                                                arrEmp: TConsultasArray;
                                                                blnFiltrouPortador: Boolean;
                                                                edtCodPortador: TEditFocus;
                                                                arrPor: TConsultasArray;
                                                                strCodEmp: String = '';
                                                                blnSomenteJurosEDescontos: Boolean = False): String;
begin
  Result := untFuncoesSimples.fComplementoWhereSQLPosContabilPagar(edtCodEmpresa, arrEmp, blnFiltrouPortador, edtCodPortador, arrPor, strCodEmp, blnSomenteJurosEDescontos);
end;

function TFuncoesRelatorio.fComplementoWhereSQLPosContabilReceber(
  strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fComplementoWhereSQLPosContabilReceber(strCodEmp);
end;

function TFuncoesRelatorio.fComponentByName(Owner: TWinControl; strNome: String): TComponent;
begin
  Result := untFuncoesSimples.fComponentByName(Owner, strNome);
end;

function TFuncoesRelatorio.fCriaAggregateField(cdsClient: TUniClientDataSet;
  strFieldName, strExpression, strDisplayFormat: String;
  blnActive: Boolean): TAggregateField;
begin
  Result := untFuncoesSimples.fCriaAggregateField(cdsClient,
                                                  strFieldName,
                                                  strExpression,
                                                  strDisplayFormat,
                                                  blnActive);
end;

function TFuncoesRelatorio.fCriaClientDataSetClientesDebitos: TUniClientDataSet;
begin
  Result := untFuncoesSimples.fCriaClientDataSetClientesDebitos;
end;

function TFuncoesRelatorio.fEhEstadoRegraZonaFranca(strEstado: String): Boolean;
Begin
  Result := untFuncoesSimples.fEhEstadoRegraZonaFranca(strEstado);
End;

function TFuncoesRelatorio.fCriaClientDatasetReciboCTP: TUniClientDataSet;
begin
  Result := Nil;//untReciboCtp.fCriaClientDatasetReciboCTP;
end;

function TFuncoesRelatorio.fExecutarModal(const prcGen: TGenericProcedure;
  const strTexto, strChave: string): Boolean;
begin
  Result := untFuncoesSimples.fExecutarModal(prcGen, strTexto, strChave);
end;

function TFuncoesRelatorio.fExecutaSQL(strSQL: String): Boolean;
begin
  Result := untFuncoesSimples.fExecutaSQL(strSQL);
end;

function TFuncoesRelatorio.fExisteCheque(strDocume, strCodEmp: String;
  intSeqCon: Integer; qryCheques: TUniQuery): Boolean;
begin
  Result := untFuncoesSimples.fExisteCheque(strDocume, strCodEmp, intSeqCon, qryCheques);
end;

function TFuncoesRelatorio.fExisteLote(strNumLot, strCodIte,
  strCodEmp: String): Boolean;
begin
  Result := untFuncoesSimples.fExisteLote(strNumLot, strCodIte, strCodEmp);
end;

function TFuncoesRelatorio.fExt1(strS : String; strIdioma: String = 'P'): String;
begin
  Result := untFuncoesSimples.fExt1(strS, strIdioma);
end;

function TFuncoesRelatorio.fExt2(strS : string; strIdioma: String = 'P'): String;
begin
  Result := untFuncoesSimples.fExt2(strS, strIdioma);
end;


function TFuncoesRelatorio.fExt3(strS : string; strIdioma: String = 'P'): String;
begin
  Result := untFuncoesSimples.fExt3(strS, strIdioma);
end;


function TFuncoesRelatorio.fExtDezena(strS : String; strIdioma: String = 'P'): String;
begin
  Result := untFuncoesSimples.fExtDezena(strS, strIdioma);
end;

function TFuncoesRelatorio.FMes_Espano(dtaData: TDateTime; intTam: Integer): String;
begin
  Result := untFuncoesSimples.FMes_Espano(dtaData, intTam);
end;

function TFuncoesRelatorio.fCriaClientDatset(qryOrigem: TDataSet;
  blnVazio: Boolean = False; AOwner: TComponent = Nil): TUniClientDataSet;
begin
  Result := untFuncoesSimples.fCriaClientDatset(qryOrigem, blnVazio, AOwner);
end;

function TFuncoesRelatorio.fCriaDataSource(DataSet: TDataSet): TDataSource;
begin
  Result := untFuncoesSimples.fCriaDataSource(DataSet);
end;

function TFuncoesRelatorio.fCriaDiretorio(strPath: String): Boolean;
begin
  Result := untFuncoesSimples.fCriaDiretorio(strPath);
end;

function TFuncoesRelatorio.fCriaMemoryTableEntregaFutura(strNomTab, strCodEmp,
  strCodIte, strNumLot: String; blnConverteML, blnApenasCriacao,
  blnFaturamento: Boolean; strMotFut: String; blnPorLote: Boolean): Boolean;
begin
  Result := untFuncoesSimples.fCriaMemoryTableEntregaFutura(strNomTab, strCodEmp,
                          strCodIte, strNumLot, blnConverteML, blnApenasCriacao,
                          blnFaturamento, strMotFut, blnPorLote);
end;

function TFuncoesRelatorio.fCriaQuery(AOwner: TComponent; Conexao: TUniConnection): TUniQuery;
begin
  Result := untFuncoesSimples.fCriaQuery(AOwner, Conexao);
end;

function TFuncoesRelatorio.fCriarQuery(strSQL: String; AOwner: TComponent): TUniQuery;
begin
  Result := untFuncoesSimples.fCriarQuery(strSQL, AOwner);
end;

function TFuncoesRelatorio.fCurrentDate: String;
begin
  Result := untFuncoesSimples.fCurrentDate;
end;

function TFuncoesRelatorio.fCurrentDate(const Value: TDateTime): String;
begin
  Result := untFuncoesSimples.fCurrentDate(Value);
end;

function TFuncoesRelatorio.fDataExtenso(Data: TDateTime; blnImpCid: Boolean = False; blnImpDiaSemana: Boolean = False): String;
begin
  Result := untValorPorExtenso.fDataExtenso(Data, blnImpCid, blnImpDiaSemana);
end;

function TFuncoesRelatorio.fDesconsiderarNaQtdLimDaPromoItensUnitarMaior: Boolean;
begin
  Result := untFuncoesSimples.fDesconsiderarNaQtdLimDaPromoItensUnitarMaior;
end;

{function TFuncoesRelatorio.fDescontoClienteProfissional(strCodCli: String): Boolean;
begin
  Result := untFuncoesSimples.fDescontoClienteProfissional(strCodCli);
end;
 }


function TFuncoesRelatorio.fDescricaoFrete(strTipo: String): String;
begin
  Result := '';//untTipoFreteAtc.fDescricaoFrete(strTipo);
end;

function TFuncoesRelatorio.fDescriLinhaWandaPro(intLinha: Integer): String;
begin
  Result := untFuncEspecificas.fDescriLinhaWandaPro(intLinha);
end;

function TFuncoesRelatorio.fDiaDeFolga(dtaDta: TDateTime;
  blnConsideraSabado : Boolean = True; strCodCid: String = ''): Boolean;
begin
  Result := untFuncoesSimples.fDiaDeFolga(dtaDta, blnConsideraSabado, strCodCid);
end;


function TFuncoesRelatorio.fDigEmail(var strDestinatario, strEmailDestinatario: String): Boolean;
begin
  Result := untFuncoesSimples.fDigEmail(strDestinatario, strEmailDestinatario);
end;

function TFuncoesRelatorio.fDigQuantidade(strCaption, strLabel: String;
  var intQtdDig: Integer; intMin, intMax: Integer): Boolean;
begin
  Result := untFuncoesSimples.fDigQuantidade(strCaption, strLabel, intQtdDig, intMin, intMax);
end;

function TFuncoesRelatorio.fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;
begin
  Result := untFuncoesSimples.fDoubleAggregate(cdsClient, strNomCam);
end;

function TFuncoesRelatorio.fDropTable(strNomeTabela: String): Boolean;
begin
  Result := untFuncoesSimples.fDropTable(strNomeTabela);
end;

function TFuncoesRelatorio.fEhFeriado(dtaData: TDateTime; strCodCid: String = ''): Boolean;
begin
  Result := untFuncoesSimples.fEhFeriado(dtaData, strCodCid);
end;

function TFuncoesRelatorio.fEhLetra(strCaract: String): Boolean;
begin
  Result := untFuncoesSimples.fEhLetra(strCaract);
end;


function TFuncoesRelatorio.fEmptyDate(strDate: String): Boolean;
begin
  Result := untFuncoesSimples.fEmptyDate(strDate);
end;

function TFuncoesRelatorio.fEmptyStr(strString: String; blnTiraCaracEspecial: Boolean): Boolean;
begin
  Result := untFuncoesSimples.fEmptyStr(strString, blnTiraCaracEspecial);
end;

function TFuncoesRelatorio.fEntraCons(strCodigo: String): Boolean;
begin
  Result := untFuncoesSimples.fEntraCons(strCodigo);
end;

function TFuncoesRelatorio.fEntregaFutura(AParams: IParamEF): IEntregaFutura;
begin
  Result := untFuncoesSimples.fEntregaFutura(AParams);
end;

function TFuncoesRelatorio.fEnviarEMailComAnexo(Para, Assunto, Texto, Arquivo: String): Integer;
begin
  Result := untFuncoesSimples.EnviarEMailComAnexo(Para, Assunto, Texto, Arquivo);
end;

function TFuncoesRelatorio.fEscolheTinta(strCodCli : String = ''): ShortString;
begin
  Result := untFuncTinta.fEscolheTinta(strCodCli);
end;

function TFuncoesRelatorio.fFecharTabela(NomeTabela: TDataSet): Boolean;
begin
  Result := untFuncoesSimples.fFecharTabela(NomeTabela);
end;

function TFuncoesRelatorio.fFilaExiste(strFila: String): Boolean;
begin
  Result := untFuncoesSimples.fFilaExiste(strFila);
end;

function TFuncoesRelatorio.fFormataCCusto(strValor: String): String;
begin
  Result := untFuncoesSimples.fFormataCCusto(strValor);
end;

function TFuncoesRelatorio.fFormataCEP(strCEP: String): String;
begin
  Result := untFuncoesSimples.fFormataCEP(strCEP);
end;

function TFuncoesRelatorio.fFormataCondPag(strCond: String): String;
begin
  Result := untFuncoesSimples.fFormataCondPag(strCond);
end;

function TFuncoesRelatorio.fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := untFuncoesSimples.fFormataFloat(fltNumero, intDecimais);
end;

function TFuncoesRelatorio.fFormataFone(strFone: String): String;
begin
  Result := untFuncoesGenerica.fFormataFone(strFone);
end;

function TFuncoesRelatorio.ffrmSenha(var strSenha: String; strTitulo: String = ''): Boolean;
begin
  Result := untFuncoesSimples.ffrmSenha(strSenha, strTitulo);
end;

function TFuncoesRelatorio.fFrtStrExcel(strValor: String): String;
begin
  Result := untFuncoesSimples.fFrtStrExcel(strValor);
end;

function TFuncoesRelatorio.fGetCamGer(Owner: TComponent): ICamGer;
begin
  Result := Nil;//TCamGer.Create(Owner);
end;

function TFuncoesRelatorio.fGetConfTinta(strIdePro: String): IConfTinta;
begin
  Result := untFuncTinta.fGetConfTinta(strIdePro);
end;

function TFuncoesRelatorio.fGetLetraAlfa(intCol: Integer): String;
begin
  Result := untFuncoesSimples.fGetLetraAlfa(intCol);
end;

function TFuncoesRelatorio.fGetMemoryTableNameEntregaFutura: String;
begin
  Result := untFuncoesSimples.fGetMemoryTableNameEntregaFutura;
end;

function TFuncoesRelatorio.fGetMenu(strTitulo: String; arrOpcoes: array of String; intOpcao: Integer;
  blnSaiComEsc: Boolean): Integer;
begin
  Result := untFuncoesSimples.fGetMenu(strTitulo, arrOpcoes, intOpcao, blnSaiComEsc);
end;

{function TFuncoesRelatorio.fGetMsgRelCnf: String;
begin
  Result := untFuncoesSimples.fGetMsgRelCnf;
end;
 }
function TFuncoesRelatorio.fGetNumLinhasMemo(strMemo: String): Integer;
begin
  Result := untFuncoesSimples.fGetNumLinhasMemo(strMemo);
end;

function TFuncoesRelatorio.fGetSQLQtdEntregaFuturaItem(strCodIte, strCodEmp,
  strNumLot, strMotFut: String): String;
begin
  Result := untFuncoesSimples.fGetSQLQtdEntregaFuturaItem(strCodIte, strCodEmp, strNumLot, strMotFut);
end;

{function TFuncoesRelatorio.fGetTCadFun(Owner: TComponent): ICadFun;
begin
  Result := Nil;//TCadFun.Create(Owner);
end;
 }
function TFuncoesRelatorio.fGetTCadLot(Owner: TComponent;
  qryCadTab: TUniQuery): ICadLot;
begin
  Result := TCadLot.Create(Owner, qryCadTab);
end;

function TFuncoesRelatorio.fGetTFiltrosRelatorio: IFiltrosRelatorio;
begin
  Result := TFiltrosRelatorio.Create;
end;

function TFuncoesRelatorio.fGetTCamposUso: ICamposUso;
begin
  Result := TCamposUso.Create;
end;

function TFuncoesRelatorio.fGetTExtratoComissaoProfissional(dtaEntIni, dtaEntFin,
  dtaBaiIni, dtaBaiFin: TDateTime; strCodPro, strCodAti, strCodCli, strCodRed,
  strCodEmp: String; fltVlrCom: Double; intCalcul: Integer; strTipFil: String;
  strTCoPro: String): IFastPrintFile;
begin
  Result := Nil;
  {TExtratoComissaoProfissional.CreateInstance(dtaEntIni, dtaEntFin,
  dtaBaiIni, dtaBaiFin, strCodPro, strCodAti, strCodCli, strCodRed, strCodEmp,
  fltVlrCom, intCalcul, strTipFil, strTCoPro);}
end;

function TFuncoesRelatorio.fGetTFastPrintFileEditor(AOwner: TComponent): IFastPrintFileEditor;
begin
  Result := TFastPrintFileEditor.Create(AOwner);
end;

function TFuncoesRelatorio.fGetObjFastPrintFileEditor(): TObject;
begin
  Result := TFastPrintFileEditor.Create(nil);
end;

function TFuncoesRelatorio.fGetTFinanceira(AOwner: TComponent): IFinanceira;
begin
  Result := TFinanceira.Create(AOwner);
end;

function TFuncoesRelatorio.fGetTFuncMacro: IFuncMacro;
begin
  Result := TFuncMacro.Create;
end;

function TFuncoesRelatorio.fGetTFuncoesEditorFast: IFuncoesEditorFast;
begin
  Result := TFuncoesEditorFast.Create;
end;

function TFuncoesRelatorio.fGetTintasdeMaquina(blnDestruir: Boolean = False): ITintasDeMaquina;
begin
  Result := untFuncTinta.fGetTintasdeMaquina(blnDestruir);
end;

function TFuncoesRelatorio.fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;
begin
  Result := untFuncoesSimples.fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial);
end;


function TFuncoesRelatorio.fGetTipoAbfCliente(const strCodCli: String): String;
begin
  Result := untFuncoesSimples.fGetTipoAbfCliente(strCodCli);
end;

{function TFuncoesRelatorio.fGetTIteBar(opcCriacaP: TOpcaoCriacao;
  qryTabIteP: TUniQuery; dbeCodBarP, dbeBarEmbP, dbeEmbalaP: TDBEditFocus;
  wncLocCadP: TWincontrol; strCodIteP: String): IIteBar;
begin
  Result := TIteBar.Create(opcCriacaP, qryTabIteP, dbeCodBarP, dbeBarEmbP,
  dbeEmbalaP, wncLocCadP, strCodIteP);
end;
 }
{function TFuncoesRelatorio.fGetTMadeireira: IMadeireira;
begin
  Result := TMadeireira.Create;
end;
 }
function TFuncoesRelatorio.fGetTMetAno(blnGlobal: Boolean = False; blnEmpOrigem: Boolean = False; strComCus: String = ''): IMetAno;
begin
  Result := TMetAno.Create(blnGlobal, blnEmpOrigem, strComCus);
end;

function TFuncoesRelatorio.fGetTOrdenacao(Owner: TComponent; strCampos: String; intCodEtiP: Integer): IOrdenacao;
begin
  Result := TOrdenacao.Create(Owner, strCampos, intCodEtiP);
end;

function TFuncoesRelatorio.fGetTReciboCtp(cdsDados: TUniClientDataSet): IFastPrintFile;
begin
  Result := Nil;//TReciboCtp.CreateInstance(cdsDados);
end;

{function TFuncoesRelatorio.fGetTValorRecebido: IValorRecebido;
begin
  Result := Nil;//TValorRecebido.Create;
end;
 }
function TFuncoesRelatorio.fGetZClient(Owner: TComponent; strSQL: String = ''): IZClient;
begin
  Result := untZClient.TZClient.Create(Owner, strSQL);
end;

{function TFuncoesRelatorio.fGetMesesGiro(Owner: TComponent; intAnos: Integer): IMesesGiro;
begin
  Result := TMesesGiro.Create(Owner, intAnos);
end;
 }
function TFuncoesRelatorio.fImprimeEtiqueta(prmDllRel: Pointer;
  strNomFun: String): Boolean;
begin
  Result := untFuncoesEtiquetas.fImprimeEtiqueta(prmDllRel, strNomFun);
end;


function TFuncoesRelatorio.fInc(var intValor: Integer): Integer;
begin
  Result := untFuncoesSimples.fInc(intValor);
end;

function TFuncoesRelatorio.fInformacaoAdicionalEtiquetaItens: String;
begin
  Result := untFuncoesSimples.fInformacaoAdicionalEtiquetaItens;
end;

function TFuncoesRelatorio.fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean;
begin
  Result := untFuncoesSimples.fInsereProCod(strNomTab, blnCodAut);
end;

function TFuncoesRelatorio.fIsNumber(const strNumber: String): Boolean;
begin
  Result := untFuncoesSimples.fIsNumber(strNumber);
end;

function TFuncoesRelatorio.fIsValidDate(Sender: TWinControl): Boolean;
begin
  Result := untFuncoesSimples.fIsValidDate(Sender);
end;

function fTiraCaracEspeciais(strTexto      : String;
                             blnUsaLista   : Boolean = True;
                             blnTiraEspacos: Boolean = False;
                             blnTiraPontos : Boolean = False;
                             blnTiraDoisPts: Boolean = False;
                             blnTiraTab    : Boolean = False;
                             blnTiraVirgula: Boolean = True): String;
Begin
  Result := untFuncoesSimples.fTiraCaracEspeciais(strTexto, blnUsaLista, blnTiraEspacos, blnTiraPontos,
                                                  blnTiraDoisPts, blnTiraTab, blnTiraVirgula);
End;

function TFuncoesRelatorio.fRetNomVendRep(strCodVen: String): String;
begin
  Result := untFuncoesSimples.fRetNomVendRep(strCodVen);
end;

function TFuncoesRelatorio.fRetNomVendRep(strCodVen: String; strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetNomVendRep(strCodVen,strCodEmp);
end;

function TFuncoesRelatorio.fRetNumLoteConsulta(const strNumLot: String): String;
begin
  Result := untFuncoesSimples.fRetNumLoteConsulta(strNumLot);
end;

function TFuncoesRelatorio.fRetornaCndPag(arrDatas: TDateArray;
  dtaDtaBas: TDateTime): String;
begin
  Result := untFuncoesSimples.fRetornaCndPag(arrDatas, dtaDtaBas);
end;

function TFuncoesRelatorio.fRetornaAliquotaIcmsInternaDoEstado(strEstado: String): Double;
begin
  Result := untFuncoesSimples.fRetornaAliquotaIcmsInternaDoEstado(strEstado);
end;

function TFuncoesRelatorio.fRetornaCndPag(const arrDuplicata: TarrDuplicata; dtaDtaBas: TDateTime): String;
begin
  Result := untFuncoesSimples.fRetornaCndPag(arrDuplicata, dtaDtaBas);
end;

function TFuncoesRelatorio.fRetornaComposicao(strDescri: String;
  blnPadrao: Boolean): String;
begin
  Result := untFuncoesSimples.fRetornaComposicao(strDescri, blnPadrao);
end;

function TFuncoesRelatorio.fRetornaComposicaoPadrao: String;
begin
  Result := untFuncoesSimples.fRetornaComposicaoPadrao;
end;


function TFuncoesRelatorio.fRetornaDescricaoVeic(strPlaVei: String): String;
begin
  Result := untFuncoesSimples.fRetornaDescricaoVeic(strPlaVei);
end;

function TFuncoesRelatorio.fRetornaInGrupo(strCodGpo: String;
  arrGrupos: TConsultasArray; strCampo: String): String;
begin
  Result := untFuncoesSimples.fRetornaInGrupo(strCodGpo, arrGrupos, strCampo);
end;

function TFuncoesRelatorio.fRetornaNomeTinta(strIdePro: String): String;
begin
  Result := untFuncTinta.fRetornaNomeTinta(strIdePro);
end;

function TFuncoesRelatorio.fRetornaPrecosPromocao(strCodIte, strCodCli: String;
  dtaDtaPro: TDateTime; fltQtdDig, fltQtdJaDig, fltQtdJaEmPromoc: Double; intPraMed: Integer;
  var fltPreCus, fltPreVen, fltComVar, fltComAta, fltComDis, fltQtdDis, fltDesF07: Double; var strComPro: String;
  var blnParticiona, blnPromo: Boolean; strTabPre, strCodCnd: String; strPrzPro: String = '';
  strENTBRF: String = ''; blnConsideraQtd: Boolean = True; blnBuscaPreco: Boolean = False;
  strIteVid: String = '-1'; blnEntIme: Boolean = False; blnEntFut: Boolean = False; strMotFut: String = '';
  strEmpPro: String = ''; strNumOrc: String = ''; strEspOrc: String = ''): Boolean;
Var
  strCodPro: String;
begin
  Result := untCadPro.fRetornaPrecosPromocao(strCodIte, strCodCli, dtaDtaPro,
    fltQtdDig, fltQtdJaDig, fltQtdJaEmPromoc, intPraMed, fltPreCus, fltPreVen, fltComVar, fltComAta,
    fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPro, blnParticiona, blnPromo, strTabPre, strCodCnd, strPrzPro,
    strENTBRF, blnConsideraQtd, blnBuscaPreco, strIteVid, blnEntIme, blnEntFut, strMotFut,
    strEmpPro, strNumOrc, strEspOrc);
end;


function TFuncoesRelatorio.fRetPerComIndice(fltValor, fltValorNt: Double;
  blnAtingiu: Boolean): Double;
begin
  Result := untFuncoesSimples.fRetPerComIndice(fltValor, fltValorNt, blnAtingiu);
end;

function TFuncoesRelatorio.fRetPerComLucro(fltQtdIte, fltUniOri, fltTotCus,
  fltTotIteLiq, fltComVar, fltTotCu2: Double; strMarMkp, strPcmPro: String;
  intDecUni: Integer): Double;
begin
  Result := untFuncoesSimples.fRetPerComLucro(fltQtdIte, fltUniOri, fltTotCus,
    fltTotIteLiq, fltComVar, fltTotCu2, strMarMkp, strPcmPro, intDecUni);
end;

function TFuncoesRelatorio.fRetPerComMargem(fltValor: Double; strTipVen, strConPag: String): Double;
begin
  Result := untFuncoesSimples.fRetPerComMargem(fltValor, strTipVen, strConPag);
end;

function TFuncoesRelatorio.fRetPerComOpeMargem(fltCusto, fltVenda: Double; strCodOpe: String): Double;
begin
  Result := untFuncoesSimples.fRetPerComOpeMargem(fltCusto, fltVenda, strCodOpe);
end;

function TFuncoesRelatorio.fRetPreComMenosDescForn(strCodIte, strCodEmp: String;
  cdsIteGer: TUniClientDataSet; strCALSOP: String): Double;
begin
  Result := untFuncoesSimples.fRetPreComMenosDescForn(strCodIte, strCodEmp, cdsIteGer, strCALSOP);
end;

function TFuncoesRelatorio.fRetProximaDtaEntrPedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): String;
begin
//  Result := untSaldoPedidoCompra.fRetProximaDtaEntrPedidoCompra(strCodIte, strEmpresas, blnFiltraTE);
end;

function TFuncoesRelatorio.fRetQuantPendentePedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): Double;
begin
//  Result := untSaldoPedidoCompra.fRetQuantPendentePedidoCompra(strCodIte, strEmpresas, blnFiltraTE);
  result := 0;
end;

function TFuncoesRelatorio.fRetSaldoAnterior(strCodPor: String;
  dtaDataIni: TDateTime; strCodEmp: String;
  sitSitLan: TSituacaoLancBancario): Currency;
begin
  Result := untFuncoesSimples.fRetSaldoAnterior(strCodPor, dtaDataIni, strCodEmp, sitSitLan);
end;

function TFuncoesRelatorio.fRetSenhaVendedor(strCodVen: String): String;
begin
  Result := untFuncoesSimples.fRetSenhaVendedor(strCodVen);
end;


function TFuncoesRelatorio.fRetSiglaEmpresa(strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetSiglaEmpresa(strCodEmp);
end;

function TFuncoesRelatorio.fRetSiglaUni(const strCodUni: String): String;
begin
  Result := untFuncoesSimples.fRetSiglaUni(strCodUni);
end;

function TFuncoesRelatorio.fRetSiglaUniConsulta(const strSigUni: String): String;
begin
  Result := untFuncoesSimples.fRetSiglaUniConsulta(strSigUni);
end;

function TFuncoesRelatorio.fRetSiglaUnidade(const strCodUni: String;
  qryAux: TUniQuery): String;
begin
  Result := untFuncoesSimples.fRetSiglaUnidade(strCodUni, qryAux);
end;

function TFuncoesRelatorio.fRetSomenteNumeros(strTexto: String): String;
begin
  Result := untFuncoesSimples.fRetSomenteNumeros(strTexto);
end;


function TFuncoesRelatorio.fRetTamCampo(strNomeTabela: String): Integer;
begin
  Result := untFuncoesSimples.fRetTamCampo(strNomeTabela);
end;

{function TFuncoesRelatorio.fRetTelaSelecaoImp(Var oleDados: OleVariant;
  var strOrdenacao: string; var bVerificarEmail: boolean): Boolean;
begin
  Result := untFuncoesSimples.fRetTelaSelecaoImp(oleDados, strOrdenacao, bVerificarEmail);
end;
 }
function TFuncoesRelatorio.fRetTipoDepartamento(strCodigo,
  strTipo: String): String;
begin
  Result := untFuncoesSimples.fRetTipoDepartamento(strCodigo,strTipo);
end;

function TFuncoesRelatorio.fRetTipoForaConPag(strCodCnd: String): String;
begin
  Result := untFuncoesSimples.fRetTipoForaConPag(strCodCnd);
end;

function TFuncoesRelatorio.fRetTipoImpressora(var strTipImp: String): Boolean;
begin
  Result := untFuncoesSimples.fRetTipoImpressora(strTipImp);
end;

function TFuncoesRelatorio.fAcertaMaskTel(strFone: String): String;
begin
  Result := untFuncoesGenerica.fAcertaMaskTel(strFone);
end;

function TFuncoesRelatorio.fRetTopoEtiqueta(strTipEti: String): Integer;
begin
  Result := untFuncoesSimples.fRetTopoEtiqueta(strTipEti);
end;
function TFuncoesRelatorio.fRetUFCliente(strCodCli: String): String;
begin
  Result := untFuncoesSimples.fRetUFCliente(strCodCli);
end;

function TFuncoesRelatorio.fRetUFEmpresa(strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetUFEmpresa(strCodEmp);
end;

function TFuncoesRelatorio.fRetUnidadeItem(strCodIte: String): String;
begin
  Result := untFuncoesSimples.fRetUnidadeItem(strCodIte);
end;

function TFuncoesRelatorio.fRetValorCfg(strCodCfg, strValCfg: String): String;
begin
  pCriarFormularios(TFrmCfgRepositorio,FrmCfgRepositorio);
  Result := FrmCfgRepositorio.fRetValorCfg(strCodCfg, strValCfg);
  pFreeAndNil(FrmCfgRepositorio);
end;

function TFuncoesRelatorio.fRetMarcaItem(strCodIte: String): String;
begin
  Result := untFuncoesSimples.fRetMarcaItem(strCodIte);
end;

function TFuncoesRelatorio.fRetMascaraFone(opcPais: TPais): String;
begin
  Result := untFuncoesGenerica.fRetMascaraFone(opcPais);
end;

function TFuncoesRelatorio.fRetMascaraFonePais: String;
begin
  Result := untFuncoesGenerica.fRetMascaraFonePais;
end;

function TFuncoesRelatorio.fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
begin
  Result := untFuncoesSimples.fstrEspaco(Str, Tamanho, intPos);
end;

function TFuncoesRelatorio.fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String;
begin
  Result := untFuncoesSimples.fFormataCpfCgc(strValor, FPais, strEstado);
end;

function TFuncoesRelatorio.fCon_Precos(fltPreAtu: Double; intTipPre: Integer; blnCalGua: Boolean;
                         dtaDtaMoe: TDate; blnConGua: Boolean = False): Double;
begin
  Result := untFuncoesSimples.fCon_Precos(fltPreAtu, intTipPre, blnCalGua, dtaDtaMoe, blnConGua);
end;

function TFuncoesRelatorio.fRetDesSfz(strCodigo: string): String;
begin
  Result := untFuncoesSimples.fRetDesSfz(strCodigo);
end;


function TFuncoesRelatorio.fRollBack: Boolean;
begin
  Result := untFuncoesSimples.fRollBack;
end;

function TFuncoesRelatorio.fRoundSql(const strCampo: String;
  const intDecimais: Integer): String;
begin
  Result := untFuncoesSimples.fRoundSql(strCampo, intDecimais);
end;

function TFuncoesRelatorio.fSegToTempoStr(intSegundos: Integer): String;
begin
  Result := untFuncoesSimples.fSegToTempoStr(intSegundos);
end;

function TFuncoesRelatorio.fSegToTimeStr(Segundos: Double): String;
begin
  Result := untFuncoesSimples.fSegToTimeStr(Segundos);
end;

{function TFuncoesRelatorio.fSelecionaFilaImp(var qryCfgRel: TUniQuery): Boolean;
begin
  Result := untCfgRel.fSelecionaFilaImp(qryCfgRel);
end;}

function TFuncoesRelatorio.fSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp,
  strCodCli: String; intQtdCol: Integer): String;
begin
  Result := untFuncoesSimples.fSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp,
    strCodCli, intQtdCol);
end;

function TFuncoesRelatorio.fSomenteLetra(str: String): String;
begin
  Result := untFuncoesSimples.fSomenteLetra(str);
end;


function TFuncoesRelatorio.fSQLParam(edtValor: TCustomEdit; strNomCam,
  strNomPar: String; blnLike: Boolean): String;
begin
  Result := untFuncoesConsulta.fSQLParam(edtValor, strNomCam, strNomPar, blnLike);
end;

function TFuncoesRelatorio.fSQLParamPerido(mskDtaIni: TMaskEditFocus; strNomCam,
  strParIni, strParFin: String): String;
begin
  Result := untFuncoesConsulta.fSQLParamPerido(mskDtaIni, strNomCam, strParIni, strParFin);
end;

function TFuncoesRelatorio.fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean): String;
begin
//  Result := untSaldoPedidoCompra.fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp, blnCheckLibPcm, blnFiltraTE);
end;

function TFuncoesRelatorio.fSQLCamposQuantidadePendenteCompra(blnFiltraTE, blnLibPcm: Boolean): String;
Begin
//  Result := untSaldoPedidoCompra.fSQLCamposQuantidadePendenteCompra(blnFiltraTE, blnLibPcm);
End;

function TFuncoesRelatorio.fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean): String;
Begin
//  Result := untSaldoPedidoCompra.fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp, blnCheckLibPcm);
End;

function TFuncoesRelatorio.fInTransaction: Boolean;
begin
  Result := untFuncoesSimples.fInTransaction;
end;

function TFuncoesRelatorio.fStartTransaction: Boolean;
begin
  Result := untFuncoesSimples.fStartTransaction;
end;

function TFuncoesRelatorio.fStatusCndPag(strCndPag: String): Integer;
begin
  Result := untFuncoesSimples.fStatusCndPag(strCndPag);
end;

function TFuncoesRelatorio.fStrLocate(objCodigo: TObject;
  arrLinha: TConsultasArray; strNomCampo, strNomPar: String; blnSemAND,
  blnNegar: Boolean; strCodigo: String): String;
begin
  Result := untFuncoesConsulta.fStrLocate(objCodigo, arrLinha, strNomCampo, strNomPar,
    blnSemAND, blnNegar, strCodigo);
end;

function TFuncoesRelatorio.fStrLocateEmpresa(objCodigo: TObject;
  arrLinha: TConsultasArray; strNomCampo, strNomPar: String; blnSemAND: Boolean;
  strCodigo: String): String;
begin
  Result := untFuncoesConsulta.fStrLocateEmpresa(objCodigo, arrLinha, strNomCampo,
    strNomPar, blnSemAND, strCodigo);
end;

function TFuncoesRelatorio.fStrLocateLinGru(objCodigo: TObject;
  arrLinha: TConsultasArray; strNomCampo, strNomPar: String; blnSemAND: Boolean = False;
  blnNegar: Boolean = False; strCodigo: String = ''; blnAndFinal: Boolean = False): String;
begin
  Result := untFuncoesConsulta.fStrLocateLinGru(objCodigo, arrLinha, strNomCampo,
    strNomPar, blnSemAND, blnNegar, strCodigo, blnAndFinal);

end;

function TFuncoesRelatorio.fStrRelFatorLit(strAliasDet: String;
  blnVeioMarkup: Boolean): String;
begin
  Result := untFuncTinta.fStrRelFatorLit(strAliasDet, blnVeioMarkup);
end;

function TFuncoesRelatorio.fStrSQLOr(objCodigo: TObject;
  arrLinha: TConsultasArray; strNomCampo, strNomPar: String; blnSemAND,
  blnNegar: Boolean): String;
begin
  Result := untFuncoesConsulta.fStrSQLOr(objCodigo, arrLinha, strNomCampo, strNomPar,
    blnSemAND, blnNegar);
end;

function TFuncoesRelatorio.fStrTitulo(strText: String; edtDescri: TEditFocus;
  arrLinha: TConsultasArray; strLinha, strTitulo: String; blnTodas,
  blnNegar: Boolean): String;
begin
  Result := untFuncoesConsulta.fStrTitulo(strText, edtDescri, arrLinha, strLinha,
    strTitulo, blnTodas, blnNegar);
end;

function TFuncoesRelatorio.fStrTitulo(strText: String; edtDescri: TEditFocus;
  arrLinha: TConsultasArray; strLinha, strTitulo, strVazio: String): String;
begin
  Result := untFuncoesConsulta.fStrTitulo(strText, edtDescri, arrLinha, strLinha,
    strTitulo, strVazio);
end;

function TFuncoesRelatorio.fStrTitulo(edtValor: TEditFocus; strTitulo: String): String;
begin
  Result := untFuncoesConsulta.fStrTitulo(edtValor, strTitulo);
end;

function TFuncoesRelatorio.fStrToFloat(strValorUnico: String): Double;
begin
  Result := untFuncoesSimples.fStrToFloat(strValorUnico);
end;

function TFuncoesRelatorio.fStrZero(Zeros: string; Quant: integer): String;
begin
  Result := untFuncoesSimples.fStrZero(Zeros, Quant);
end;

function TFuncoesRelatorio.fStrZero(Zeros, Quant: integer): String;
begin
  Result := untFuncoesSimples.fStrZero(Zeros, Quant);
end;

function TFuncoesRelatorio.fTabelaExiste(strNomeTabela: String): Boolean;
begin
  Result := untFuncoesSimples.fTabelaExiste(strNomeTabela);
end;

function TFuncoesRelatorio.fTamDocCadRec: Integer;
begin
  Result := untFuncoesSimples.fTamDocCadRec;
end;


function TFuncoesRelatorio.fTiraCaracEspeciais(strTexto: String; blnUsaLista,
  blnTiraEspacos, blnTiraPontos, blnTiraDoisPts, blnTiraTab,
  blnTiraVirgula: Boolean): String;
begin
  Result := untFuncoesSimples.fTiraCaracEspeciais(strTexto, blnUsaLista,
    blnTiraEspacos, blnTiraPontos, blnTiraDoisPts, blnTiraTab, blnTiraVirgula);
end;

function TFuncoesRelatorio.fTiraCaracEspeciaisPonto(strTexto: String): String;
begin
  Result := untFuncoesSimples.fTiraCaracEspeciaisPonto(strTexto);
end;

function TFuncoesRelatorio.fTransform(strConteudo: String; intStep: Shortint;
  strChar: String): String;
begin
  Result := untFuncoesSimples.fTransform(strConteudo, intStep, strChar);
end;

function TFuncoesRelatorio.fUsaProCodigo(strNomeTabela: String): Boolean;
begin
  Result := untFuncoesSimples.fUsaProCodigo(strNomeTabela);
end;

function TFuncoesRelatorio.fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada: String; 
                                                                            arrAlias: TParamArrayString=NIL;
                                                                            arrMacroParaCadaItemDoarrAlias: TParamArrayString=NIL;
                                                                            arrApenasAsEspecies: TParamArrayString=NIL; 
                                                                            strPrefixo: String='DET_';
                                                                            strOperacaoSeSomenteValor: String=''): String;
begin
  Result := untFuncoesSimples.fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada, arrAlias, arrMacroParaCadaItemDoarrAlias, arrApenasAsEspecies, strPrefixo, strOperacaoSeSomenteValor);
end;

function TFuncoesRelatorio.fUsaRotinaWMS(strCodEmp: String): Boolean;
begin
  Result := untFuncoesSimples.fUsaRotinaWMS(strCodEmp);
end;

function TFuncoesRelatorio.fValidaAcessoMultSelEmpresa(
  arrSelecao: TConsultasArray; var strEmpNegadas: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaAcessoMultSelEmpresa(arrSelecao, strEmpNegadas);
end;

function TFuncoesRelatorio.fValidaCndPag(strCndPag: String;
  blnPerRep: Boolean): Boolean;
begin
    Result := untFuncoesSimples.fValidaCndPag(strCndPag, blnPerRep);
end;

function TFuncoesRelatorio.fValidaCndPag(strCndPag: String;
  var strCndRet: String; dtaDtaBas: TDateTime; blnPerRep: Boolean): Boolean;
begin
    Result := untFuncoesSimples.fValidaCndPag(strCndPag, strCndRet, dtaDtaBas, blnPerRep);
end;

function TFuncoesRelatorio.fValidaDataStr(strData: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaDataStr(strData);
end;

function TFuncoesRelatorio.fValidaEcf(strCodEcf: String;
  var strModelo: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaEcf(strCodEcf, strModelo);
end;

function TFuncoesRelatorio.fValidaEstado(strUf: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaEstado(strUf);
end;

function TFuncoesRelatorio.fValidaGerSubVen(blnLib: Boolean; strTipo: Char;
  edtCod, edtDes: TEditFocus; strTitulo:String=''): Boolean;
begin
  Result := untFuncoesSimples.fValidaGerSubVen(blnLib, strTipo, edtCod, edtDes, strTitulo);
end;

function TFuncoesRelatorio.fValidaMesAno(mskMesAno: TMaskEditFocus;
  strInfErr: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaMesAno(mskMesAno, strInfErr);
end;

function TFuncoesRelatorio.fValidaMesAno(mskMesAno, strInfErr: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaMesAno(mskMesAno, strInfErr);
end;

function TFuncoesRelatorio.fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaPeriodo(strDtaIni, strDtaFin);
end;


function TFuncoesRelatorio.fVerificaAcessoSistema(strNomeForm, strCodOpe: String): Boolean;
begin
  Result := untFuncoesSimples.fVerificaAcessoSistema(strNomeForm, strCodOpe);
end;

function TFuncoesRelatorio.fVerificaCampoPrcCmpImp(dtaBase: TDateTime): Boolean;
begin
  Result := untFuncoesSimples.fVerificaCampoPrcCmpImp(dtaBase);
end;

function TFuncoesRelatorio.fValidarDirEspecificos(var strDireitos: String;
  strLogin, strNomeForm: String): Boolean;
begin
  Result := untFuncoesSimples.fValidarDirEspecificos(strDireitos, strLogin, strNomeForm);
end;

function TFuncoesRelatorio.fVerificaImpressora(strNomeImpr: String): Boolean;
begin
  Result := untFuncoesSimples.fVerificaImpressora(strNomeImpr);
end;

function TFuncoesRelatorio.fVerificaIntegridade(strNomFrm, strTabela: String;
  qryTabOriginal: TDataSet; blnGravar, blnSoCriaTabela: Boolean; strMotDel,
  strOpeDel: String; blnTabAux: Boolean): String;
begin
  Result := untFuncoesSimples.fVerificaIntegridade(strNomFrm, strTabela, qryTabOriginal,
    blnGravar, blnSoCriaTabela, strMotDel, strOpeDel, blnTabAux);
end;

function TFuncoesRelatorio.fVer_Banco_Carteira(strCodBan, strChave: String;
                                               Var strBanRet: String;
                                               Var intCarRet: Integer;
                                               blnVeioImpBol: Boolean = True): Boolean;
begin
  Result := untFuncoesSimples.fVer_Banco_Carteira(strCodBan, strChave, strBanRet,
    intCarRet, blnVeioImpBol);
end;

{function TFuncoesRelatorio.fReservaParametros: IReservaParametros;
begin
  Result := untFuncoesSimples.fReservaParametros();
end;

function TFuncoesRelatorio.fSaldoReservado(
  AParams: IReservaParametros): ISaldoReservado;
begin
  Result := untFuncoesSimples.fSaldoReservado(AParams);
end;
 }
function TFuncoesRelatorio.IfNull(varValor, varDefault: Variant): Variant;
begin
  Result := untFuncoesSimples.IfNull(varValor, varDefault);
end;

function TFuncoesRelatorio.GetComputerNetName: String;
begin
  Result := untFuncoesSimples.GetComputerNetName;
end;

function TFuncoesRelatorio.GetEmpresaLogada: String;
begin
  Result := untFuncoesSimples.VS_strCodEmp;
end;

function TFuncoesRelatorio.GetIPAddress: Integer;
begin
  Result := untFuncoesSimples.GetIPAddress;
end;

function TFuncoesRelatorio.GetIPAddressAsString: String;
begin
  Result := untFuncoesSimples.GetIPAddressAsString;
end;

function TFuncoesRelatorio.GetMacAddress: String;
begin
  Result := untFuncoesSimples.GetMacAddress;
end;

function TFuncoesRelatorio.GetUserFromWindows: String;
begin
  Result := untFuncoesSimples.GetUserFromWindows;
end;

function TFuncoesRelatorio.GetUsuarioLogado: String;
begin
  Result := untFuncoesSimples.strLoginUsuarioLogado;
end;

function TFuncoesRelatorio.IIF(lTest: Boolean; vExpr1,
  vExpr2: Variant): Variant;
begin
  Result := untFuncoesSimples.IIF(lTest, vExpr1, vExpr2);
end;

procedure TFuncoesRelatorio.pAdicionaCheques(qryCadChq: TDataSet;
  cdsCadChq: TUniClientDataSet);
begin
  untFuncoesSimples.pAdicionaCheques(qryCadChq, cdsCadChq);
end;

procedure TFuncoesRelatorio.pAjudaAutcom(Handle: THandle; intNumHlp: Integer);
begin
  untFuncoesSimples.pAjudaAutcom(Handle, intNumHlp);
end;

procedure TFuncoesRelatorio.pCalcSaldoInicialItens(var fltSaldoIni: Double;
  dtaDtaBal, dtaDtaIni: TDateTime; strCodIte: String;
  strCodEmp: String; blnEntFut: Boolean; strNumLot: String);
begin
  untFuncoesSimples.pCalcSaldoInicialItens(fltSaldoIni, dtaDtaBal, dtaDtaIni, strCodIte,
    strCodEmp, blnEntFut, strNumLot);
end;

procedure TFuncoesRelatorio.pCarrega(strText: String; edtDescri: TEditFocus;
  arrLinha: TConsultasArray);
begin
  untFuncoesConsulta.pCarrega(strText, edtDescri, arrLinha);
end;

procedure TFuncoesRelatorio.pCarregaConfImpr(var qryCfgRel: TUniQuery;
  const strNomeForm: String; strCodEmp, strNomeFila: String);
begin
  TCfgRel.pCarregaConfImpr(qryCfgRel, strNomeForm, strCodEmp, strNomeFila);
end;

procedure TFuncoesRelatorio.pCarregaConfImprRel(const strNomeForm: String;
  var strNomImp, strTipImp: String; strCodEmp: String; blnPreImp: Boolean);
begin
  TCfgRel.pCarregaConfImprRel(strNomeForm, strNomImp, strTipImp, strCodEmp, blnPreImp);
end;

procedure TFuncoesRelatorio.pCarregaTabPre(cbxTabPre: TComboBox);
begin
  untFuncoesSimples.pCarregaTabPre(cbxTabPre);
end;

procedure TFuncoesRelatorio.pCarregaTabPre(cbxTabPre: TDBComboBoxFocus);
begin
  untFuncoesSimples.pCarregaTabPre(cbxTabPre);
end;

procedure TFuncoesRelatorio.pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False);
begin
  untFuncoesSimples.pCloneDataSet(dtsDestino, dtsOrigem, blnComFomatacao);
end;

procedure TFuncoesRelatorio.pCnfEtiqueta(tipTipEti: TTiposEtiqueta);
begin
  untFuncoesSimples.pCnfEtiqueta(tipTipEti);
end;

procedure TFuncoesRelatorio.pCriarForm(ClasseForm: TFormClass; NomeForm: TForm);
begin
  untFuncoesSimples.pCriarForm(ClasseForm, NomeForm);
end;

procedure TFuncoesRelatorio.pCriarFormularios(Classe: TComponentClass; var frmForm);
begin
  untFuncoesSimples.pCriarFormularios(Classe, frmForm);
end;

procedure TFuncoesRelatorio.pCriarModulo(ClasseModulo: TDataModuleClass;
  var NomeForm: TDataModule);
begin
  untFuncoesSimples.pCriarModulo(ClasseModulo, NomeForm);
end;

procedure TFuncoesRelatorio.pCriaTabelaDel(strNomTab: String);
begin
  untFuncoesSimples.pCriaTabelaDel(strNomTab);
end;

procedure TFuncoesRelatorio.pDesmarcaLista(edtCodigo: TCustomEdit;
  var arrLinha: TConsultasArray; strTempTable: String; intTamCamp: Integer);
begin
  untFuncoesConsulta.pDesmarcaLista(edtCodigo, arrLinha, strTempTable, intTamCamp);
end;

procedure TFuncoesRelatorio.pDestroiModulo(var NomeForm);
begin
  untFuncoesSimples.pDestroiModulo(NomeForm);
end;

procedure TFuncoesRelatorio.pDisableControls(dtsDataSet: TDataSet; var prcScroll: TprcScroll);
begin
  untFuncoesSimples.pDisableControls(dtsDataSet, prcScroll);
end;

procedure TFuncoesRelatorio.pDropTable(strTempTable: String);
begin
  untFuncoesConsulta.pDropTable(strTempTable);
end;

procedure TFuncoesRelatorio.pEdtCodSelectExit(edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; var arrLinha: TConsultasArray; fncRetNome: TfncRetNome;
  fncRetNomeConst: TfncRetNomeConst; strMsgErr: String; intTamCamp: integer;
  blnNegar: Boolean; strCodigo: String);
begin
  untFuncoesConsulta.pEdtCodSelectExit(edtCodigo, edtDescri, arrLinha, fncRetNome,
    fncRetNomeConst, strMsgErr, intTamCamp, blnNegar, strCodigo);
end;

Function TFuncoesRelatorio.fArrCodigosToLista(strCodigo: String; arrCodigos: TConsultasArray; blnQuoted: Boolean = True): String;
Begin
  Result := untFuncoesConsulta.fArrCodigosToLista(strCodigo, arrCodigos, blnQuoted);
End;

procedure TFuncoesRelatorio.pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
begin
  untFuncoesSimples.pEnableControls(dtsDataSet, prcScroll, blnRefresh);
end;

procedure TFuncoesRelatorio.pEnabled(NomeForm: TForm; Habilitar: Boolean);
begin
  untFuncoesSimples.pEnabled(NomeForm, Habilitar);
end;

function TFuncoesRelatorio.fEnviarEmail(strTitulo, strArquivo, strDestinatario: String): Boolean;
//  Var
//    arrArquivos, arrDestinatarios : TStringArray;
begin
//  pCriarArrayAnexosEDestinatarios(strArquivo, strDestinatario, arrDestinatarios, arrArquivos);

  Result := false;{TEnvioEmail.EnviarEmail(nil,
                                    strLoginUsuarioLogado,
                                    strTitulo,
                                    arrDestinatarios,
                                    [],
                                    [],
                                    [],
                                    arrArquivos,
                                    False);}
end;

procedure TFuncoesRelatorio.pExecArquivo(strArquivo: String; Handle: THandle);
begin
  untFuncoesSimples.pExecArquivo(strArquivo, Handle);
end;

procedure TFuncoesRelatorio.pFreeAndNil(var frmForm);
begin
  untFuncoesSimples.pFreeAndNil(frmForm);
end;

procedure TFuncoesRelatorio.pGravarErro(GravarErro: Boolean; MensagemErro: String);
begin
  untFuncoesSimples.pGravarErro(GravarErro, MensagemErro);
end;

procedure TFuncoesRelatorio.pIniciaLogLeak(intDebugH: Byte; strArquivo: String);
begin
  untFuncoesSimples.pIniciaLogLeak(intDebugH, strArquivo);
end;

procedure TFuncoesRelatorio.pMensagemOk(strMensagem: String);
begin
  untFuncoesSimples.pMensagemOk(strMensagem);
end;

procedure TFuncoesRelatorio.pMensagensErro(MensErro, LocalErro, strMensagem: String);
begin
  untFuncoesSimples.pMensagensErro(MensErro, LocalErro, strMensagem);
end;

procedure TFuncoesRelatorio.pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);
begin
  untPesqAux.pPesquisaCadEmp(qryTabOri, qryTabela, strCodEmp);
end;

procedure TFuncoesRelatorio.pPesquisaCadPor(qryTabOri, qryTabela: TUniQuery;
  strCodPor: String);
begin
  untPesqAux.pPesquisaCadPor(qryTabOri, qryTabela, strCodPor);
end;

procedure TFuncoesRelatorio.pPreencheCombo(var cmb: TCustomComboBox; arr: array of String; blnLimpa: Boolean);
begin
  untFuncoesSimples.pPreencheCombo(cmb, arr, blnLimpa);
end;

procedure TFuncoesRelatorio.pRetDadosItem(strCodIte, strGrupo: String;
  var strNome, strRefere, strMarca, strUnidad: String);
begin
  untFuncEspecificas.pRetDadosItem(strCodIte, strGrupo, strNome, strRefere, strMarca, strUnidad);
end;

procedure TFuncoesRelatorio.pRetDadosItem(strCodIte: String; var strNome,
  strRefere, strMarca, strUnidad: String);
begin
  untFuncEspecificas.pRetDadosItem(strCodIte, strNome, strRefere, strMarca, strUnidad);
end;

procedure TFuncoesRelatorio.pRetFilasImpressao(Var arrFilas: TarrFilas);
begin
  untFuncoesSimples.pRetFilasImpressao(arrFilas);
end;



procedure TFuncoesRelatorio.pSetaParam(strText: String;
  arrLinha: TConsultasArray; var strLinha: String; strNomPar: String;
  qryRelatorio: TUniQuery);
begin
  untFuncoesConsulta.pSetaParam(strText, arrLinha, strLinha, strNomPar, qryRelatorio);
end;

procedure TFuncoesRelatorio.pSetaClient(cdsClient: TDataSet);
begin
  untFuncoesSimples.pSetaClient(cdsClient);
end;

procedure TFuncoesRelatorio.pSetaParam(edtValor: TEditFocus; strNomPar: String;
  qryRelatorio: TUniQuery; blnLike: Boolean);
begin
  untFuncoesConsulta.pSetaParam(edtValor, strNomPar, qryRelatorio, blnLike);
end;

procedure TFuncoesRelatorio.pSetaParamOR(objCodigo: TObject;
  arrLinha: TConsultasArray; strNomPar: String; qryRelatorio: TUniQuery);
begin
  untFuncoesConsulta.pSetaParamOR(objCodigo, arrLinha, strNomPar, qryRelatorio);
end;

procedure TFuncoesRelatorio.pSetaParamPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus; qryRelatorio: TUniQuery;
                                strParIni: String = 'DTAINI';
                                strParFin: String = 'DTAFIN');
begin
  untFuncoesConsulta.pSetaParamPeriodo(mskDtaIni,mskDtaFin, qryRelatorio,
    strParIni, strParFin);
end;

procedure TFuncoesRelatorio.pSetButton(NomeTabela: TDataSet; btnNovo,
  btnConfirma, btnExclui, btnCancela, btnEditar, btnLocalizar,
  btnSair: TBitBtnLocked);
begin
  untFuncoesSimples.pSetButton(NomeTabela, btnNovo, btnConfirma, btnExclui, btnCancela,
    btnEditar, btnLocalizar, btnSair);
end;

procedure TFuncoesRelatorio.pSetFocus(SenderUnico: TWinControl; Form: TCustomForm);
begin
  untFuncoesSimples.pSetFocus(SenderUnico, Form);
end;

procedure TFuncoesRelatorio.pSomaFormasPagamento(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String; qryResult: TUniQuery);
begin
  untFuncoesSimples.pSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp,
    strCodCli, qryResult);
end;

procedure TFuncoesRelatorio.pUltimaCompra(strCodIte, strCodEmp,
  strAnoMes: String; chrOpcInv: Char; var dtaUltComp: TDate;
  var strNumDoc: String);
begin
  untFuncoesSimples.pUltimaCompra(strCodIte, strCodEmp,strAnoMes,
    chrOpcInv, dtaUltComp, strNumDoc);
end;

procedure TFuncoesRelatorio.pValidaProCod(strNomeTabela: String);
begin
  untFuncoesSimples.pValidaProCod(strNomeTabela);
end;

procedure TFuncoesRelatorio.pZeraDigDuplic(var arrDuplicata: TarrDuplicata);
begin
  untFuncoesSimples.pZeraDigDuplic(arrDuplicata);
end;

function TFuncoesRelatorio.StringToFloat(str: String): Extended;
begin
  Result := untFuncoesSimples.StringToFloat(str);
end;

function TFuncoesRelatorio.fRemoveAcento(Str: String): String;
begin
  Result := untFuncoesSimples.fRemoveAcento(Str);
end;

function TFuncoesRelatorio.fReplicatorStr(strRepl: String; intTamanho: Integer): String;
begin
  Result := untFuncoesSimples.fReplicatorStr(strRepl, intTamanho);
end;


function TFuncoesRelatorio.fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetAutoIncrem(strNomeTabela, strCodEmp);
end;

function TFuncoesRelatorio.fRetCidade(const strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetCidade(strCodigo);
end;

function TFuncoesRelatorio.fRetCidEmpresa(strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetCidEmpresa(strCodEmp);
end;

function TFuncoesRelatorio.fRetClientesFilial: String;
begin
  Result := untFuncoesSimples.fRetClientesFilial;
end;

function TFuncoesRelatorio.fRetCodVendedor(strSenha: String; blnGerente : Boolean = False; blnSubGerente: Boolean = False): String;
begin
  Result := untFuncoesSimples.fRetCodVendedor(strSenha, blnGerente, blnSubGerente);
end;

function TFuncoesRelatorio.fRetConPag(strCodCnd: String): String;
begin
  Result := untFuncoesSimples.fRetConPag(strCodCnd);
end;

function TFuncoesRelatorio.fRetConsumidorDocumento(strNumDoc, strEspDoc, strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetConsumidorDocumento(strNumDoc, strEspDoc, strCodEmp);
end;

function TFuncoesRelatorio.fRetDadosClienteConsumidor(strDocumento, strCampo: String): String;
begin
  Result := untFuncoesSimples.fRetDadosClienteConsumidor(strDocumento, strCampo);
end;

function TFuncoesRelatorio.fRetDataExtenso(dtaData: TDateTime; blnComCidade: Boolean = False): String;
begin
  Result := untValorPorExtenso.fRetDataExtenso(dtaData, blnComCidade);
end;

function TFuncoesRelatorio.fRetDataPortador(strCodPor: String): TDateTime;
begin
  Result := untFuncoesSimples.fRetDataPortador(strCodPor);
end;

function TFuncoesRelatorio.fRetDebitoCliente(strCodCli: String): Double;
begin
  Result := untFuncoesSimples.fRetDebitoCliente(strCodCli);
end;

function TFuncoesRelatorio.fRetDesAbfCof(strAbfCof: String): String;
begin
  Result := untFuncoesSimples.fRetDesAbfCof(strAbfCof);
end;

function TFuncoesRelatorio.fRetDesCstPis(strCstPis: String): String;
begin
  Result := untFuncoesSimples.fRetDesCstPis(strCstPis);
end;

function TFuncoesRelatorio.fRetDesCstCof(strCstCof: String): String;
begin
  Result := untFuncoesSimples.fRetDesCstCof(strCstCof);
end;

function TFuncoesRelatorio.fRetDesAbfIcm(strCodAbf: String): String;
begin
  Result := untFuncoesSimples.fRetDesAbfIcm(strCodabf);
end;

function TFuncoesRelatorio.fRetDesAbfPis(strAbfPis: String): String;
begin
  Result := untFuncoesSimples.fRetDesAbfPis(StrAbfPis);
end;

function TFuncoesRelatorio.fRetDescCentroCusto(strCodCta: String): String;
begin
  Result := untFuncoesSimples.fRetDescCentroCusto(strCodCta);
end;


function TFuncoesRelatorio.fRetDescFpg(const strCodFpg: String): String;
begin
  Result := untFuncoesSimples.fRetDescFpg(strCodFpg);
end;

function TFuncoesRelatorio.fRetDescGrupoAtividade(strCodGat: String): String;
begin
  Result := untFuncoesSimples.fRetDescGrupoAtividade(strCodGat);
end;

function TFuncoesRelatorio.fRetDescGrupoCompra(const strCodGru: String): String;
begin
  Result := untFuncoesSimples.fRetDescGrupoCompra(strCodGru);
end;


function TFuncoesRelatorio.fRetDesConPag(strCodCnd: String): String;
begin
  Result := untFuncoesSimples.fRetDesConPag(strCodCnd);
end;

function TFuncoesRelatorio.fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes: String): String;
begin
  Result := untFuncoesSimples.fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes);
end;

function TFuncoesRelatorio.fRetDesForPag(strCodFpg: String): String;
begin
  Result := untFuncoesSimples.fRetDesForPag(strCodFpg);
end;

function TFuncoesRelatorio.fRetDesReg(strCodReg: String): String;
begin
  Result := untFuncoesSimples.fRetDesReg(strCodReg);
end;

function TFuncoesRelatorio.fRetDesRegiao(strCodReg: String): String;
begin
  Result := untFuncoesSimples.fRetDesRegiao(strCodReg);
end;

function TFuncoesRelatorio.fRetDesSubReg(strCodSub: String): String;
begin
  Result := untFuncoesSimples.fRetDesSubReg(strCodSub);
end;

function TFuncoesRelatorio.fRetEnderecoEmpresa(strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetEnderecoEmpresa(strCodEmp);
end;

function TFuncoesRelatorio.fRetExtensoNumero(Value: String): String;
begin
  Result := untValorPorExtenso.fRetExtensoNumero(Value);
end;

function TFuncoesRelatorio.fRetFantasiaEmpresa(strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetFantasiaEmpresa(strCodEmp);
end;


function TFuncoesRelatorio.fRetGrupoItem(strCodIte: String): String;
begin
  Result := untFuncoesSimples.fRetGrupoItem(strCodIte);
end;

function TFuncoesRelatorio.fRetiraZerosEsquerda(strDado: String): String;
begin
  Result := untFuncoesSimples.fRetiraZerosEsquerda(strDado);
end;

function TFuncoesRelatorio.fRetLitros(strCodIte: String): Double;
begin
  Result := untFuncoesSimples.fRetLitros(strCodIte);
end;


function TFuncoesRelatorio.fRetLocSep(const strCodLse: String): String;
begin
  Result := untFuncoesSimples.fRetLocSep(strCodLse);
end;

function TFuncoesRelatorio.fRetMesExtenso(intMes: Integer): String;
begin
  Result := untValorPorExtenso.fRetMesExtenso(intMes);
end;

function TFuncoesRelatorio.fRetMetaIndice: Double;
begin
  Result := untFuncoesSimples.fRetMetaIndice;
end;

function TFuncoesRelatorio.fRetMltVenItem(const strCodIte: String): Double;
begin
  Result := untFuncoesSimples.fRetMltVenItem(strCodIte);
end;

function TFuncoesRelatorio.fRetMotivoVendasPerdidas( const strCodMot: String): String;
begin
  Result := untFuncoesSimples.fRetMotivoVendasPerdidas(strCodMot);
end;

function TFuncoesRelatorio.fRetMotorista(const strCodMot: String): String;
begin
  Result := untFuncoesSimples.fRetMotorista(strCodMot);
end;

function TFuncoesRelatorio.fRetNatOpe(strCodCfo: String): String;
begin
  Result := untFuncoesSimples.fRetNatOpe(strCodCfo);
end;

function TFuncoesRelatorio.fRetNomAtividade(const strCodAti: String): String;
begin
  Result := untFuncoesSimples.fRetNomAtividade(strCodAti);
end;


function TFuncoesRelatorio.fRetNomCadGpo(const strCodGpo: String): String;
begin
  Result := untFuncoesSimples.fRetNomCadGpo(strCodGpo);
end;

function TFuncoesRelatorio.fRetNomCanalAcesso(const strCodCac: String): String;
begin
  Result := untFuncoesSimples.fRetNomCanalAcesso(strCodCac);
end;

function TFuncoesRelatorio.fRetNomCfg(strCodCfg: String): String;
begin
  Result := untFuncoesSimples.fRetNomCfg(strCodCfg);
end;

function TFuncoesRelatorio.fRetNomCfgTin(strCodCfg: String): String;
begin
  Result := untFuncoesSimples.fRetNomCfgTin(strCodCfg);
end;

function TFuncoesRelatorio.fRetNomCidade(strCodigo: String; intOpcao: Integer): String;
begin
  Result := untFuncoesSimples.fRetNomCidade(strCodigo, intOpcao);
end;

function TFuncoesRelatorio.fRetNomCidadeSemOpc(strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetNomCidadeSemOpc(strCodigo);
end;

function TFuncoesRelatorio.fRetNomCliente(Const strCodCli: String): String;
begin
  Result := untFuncoesSimples.fRetNomCliente(strCodCli);
end;

function TFuncoesRelatorio.fRetNomClienteConsumidor(strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetNomClienteConsumidor(strCodigo);
end;

function TFuncoesRelatorio.fRetNomDep(strCodDep: String): String;
begin
  Result := untFuncoesSimples.fRetNomDep(strCodDep);
end;

function TFuncoesRelatorio.fRetNomDiversos(strCodDiv: String): String;
begin
  Result := untFuncoesSimples.fRetNomDiversos(strCodDiv);
end;

function TFuncoesRelatorio.fRetNomeRedeLoja(Const strCodRed: String): String;
begin
  Result := untFuncoesSimples.fRetNomeRedeLoja(strCodRed);
end;

function TFuncoesRelatorio.fRetNomeServico(const strCodSer: String): String;
begin
  Result := untFuncoesSimples.fRetNomeServico(strCodSer);
end;

function TFuncoesRelatorio.fRetNomeSoGrupo(strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetNomeSoGrupo(strCodigo);
end;

function TFuncoesRelatorio.fRetNomeTabelaPreco(strCodTab: String): String;
begin
  Result := untFuncoesSimples.fRetNomeTabelaPreco(strCodTab);
end;

function TFuncoesRelatorio.fRetNomEvento(strCodEve: String): String;
begin
  Result := untFuncoesSimples.fRetNomEvento(strCodEve);
end;

function TFuncoesRelatorio.fRetNomSituacaoProduto(strCodSit: String): String;
begin
  Result := untFuncoesSimples.fRetNomSituacaoProduto(strCodSit);
end;

function TFuncoesRelatorio.fRetNomGeral(strCampoRetorno, strCampoPesquisa,
  strNomeTabela: String; fltCodigo: Double): String;
begin
  Result := untFuncoesSimples.fRetNomGeral(strCampoRetorno, strCampoPesquisa,
    strNomeTabela, fltCodigo);
end;

function TFuncoesRelatorio.fRetNomLocFisica(const strCodLoc: String): String;
begin
  Result := untFuncoesSimples.fRetNomLocFisica(strCodLoc);
end;

function TFuncoesRelatorio.fRetNomMarca(strCodMar: String): String;
begin
  Result := untFuncoesSimples.fRetNomMarca(strCodMar);
end;


function TFuncoesRelatorio.fRetNomProduto(const strCodIte: String): String;
begin
  Result := untFuncoesSimples.fRetNomProduto(strCodIte);
end;

function TFuncoesRelatorio.fRetNomProdutoAcabado(strCodIte,  strCodEmp: String; strCodEmpAca : String = ''): String;
begin
  Result := untFuncoesSimples.fRetNomProdutoAcabado(strCodIte,  strCodEmp, strCodEmpAca);
end;

function TFuncoesRelatorio.fRetNomProfissional(const strCodPro: String; blnVerStatus: Boolean): String;
begin
  Result := untFuncoesSimples.fRetNomProfissional(strCodPro, blnVerStatus);
end;

function TFuncoesRelatorio.fRetNomRegiao(const strCodReg: String): String;
begin
  Result := untFuncoesSimples.fRetNomRegiao(strCodReg);
end;

function TFuncoesRelatorio.fRetNomSubRegiao(const strCodSub: String): String;
begin
  Result := untFuncoesSimples.fRetNomSubRegiao(strCodSub);
end;

function TFuncoesRelatorio.fRetNomTabAuxMov(strNomTab: String): String;
begin
  Result := untFuncoesSimples.fRetNomTabAuxMov(strNomTab);
end;

function TFuncoesRelatorio.fRetNomTabelaDinamica(strCodTab: String): String;
begin
  Result := untFuncoesSimples.fRetNomTabelaDinamica(strCodTab);
end;

function TFuncoesRelatorio.fRetNomTabelaPreco(strCodTab: String): String;
begin
  Result := untFuncoesSimples.fRetNomTabelaPreco(strCodTab);
end;

function TFuncoesRelatorio.fRetNomTipoAtend(strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetNomTipoAtend(strCodigo);
end;

function TFuncoesRelatorio.fRetNomTransportadora(strCodTra: String): String;
begin
  Result := untFuncoesSimples.fRetNomTransportadora(strCodTra);
end;

function TFuncoesRelatorio.fRetNomUnidade(strCodUni: String): String;
begin
  Result := untFuncoesSimples.fRetNomUnidade(strCodUni);
end;

function TFuncoesRelatorio.fRetNomeRede : String;
begin
  Result := untFuncoesSimples.fRetNomeRede;
end;

function TFuncoesRelatorio.fRetNomeEmpresa: String;
begin
  Result := untFuncoesSimples.fRetNomeEmpresa;
end;

function TFuncoesRelatorio.fRetNomeArmazem(const strCodAmz: String): String;
begin
  Result := untFuncoesSimples.fRetNomeArmazem(strCodAmz);
end;

function TFuncoesRelatorio.fRetNomeBancoSelec(const strCodBco: String): String;
begin
  Result := untFuncoesSimples.fRetNomeBancoSelec(strCodBco);
end;

function TFuncoesRelatorio.fRetNomeCartao(strCodCar: String): String;
begin
  Result := untFuncoesSimples.fRetNomeCartao(strCodCar);
end;

function TFuncoesRelatorio.fRetNomeConta(strCodCta: String): String;
begin
  Result := untFuncoesSimples.fRetNomeConta(strCodCta);
end;

function TFuncoesRelatorio.fRetNomeEmpresa(strCodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetNomeEmpresa(strCodEmp);
end;

function TFuncoesRelatorio.fRetNomeEmpresaSelec(const strCodEmpresa: String): String;
begin
  Result := untFuncoesSimples.fRetNomeEmpresaSelec(strCodEmpresa);
end;

function TFuncoesRelatorio.fRetNomeEstado(strNomeEstado: String): String;
begin
  Result := untFuncoesSimples.fRetNomeEstado(strNomeEstado);
end;

function TFuncoesRelatorio.fRetNomeGrupoProduto(strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetNomeGrupoProduto(strCodigo);
end;

function TFuncoesRelatorio.fRetNomeLinhaGrupo(strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetNomeLinhaGrupo(strCodigo);
end;

function TFuncoesRelatorio.fRetNomeMarca(strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetNomeMarca(strCodigo);
end;

function TFuncoesRelatorio.fRetNomeMotorista(strCodMot: String; blnAtivos: Boolean = False): String;
begin
  Result := untFuncoesSimples.fRetNomeMotorista(strCodMot, blnAtivos);
end;

function TFuncoesRelatorio.fRetNomeOperador(strCodOpe: String): String;
begin
  Result := untFuncoesSimples.fRetNomeOperador(strCodOpe);
end;

function TFuncoesRelatorio.fRetNomeProfissional(const strCodPro: String): String;
begin
  Result := untFuncoesSimples.fRetNomeProfissional(strCodPro);
end;

function TFuncoesRelatorio.fRetNomeParceiro(const strCodPar: String): String;
begin
  Result := untFuncoesSimples.fRetNomeParceiro(strCodPar);
end;


function TFuncoesRelatorio.fMediaTime(strMedia: String): Integer;
begin
  Result := untFuncoesSimples.fMediaTime(strMedia);
end;

function TFuncoesRelatorio.fMensagem(strTitulo   : string;
                                     strTexto    : string;
                                     arrOpcoes   : Array Of String;
                                     intFocoBotao: Integer = 1;
                                     blnSaiComEsc: Boolean = False;
                                     intEstFon   : Integer = 1;
                                     intWidBut   : Integer = 0;
                                     blnAutosize : Boolean = False;
                                     intSomarTop : Integer = 0): Integer;
begin
  Result := untFuncoesSimples.fMensagem(strTitulo, strTexto, arrOpcoes, intFocoBotao, blnSaiComEsc,
                                        intEstFon, intWidBut, blnAutosize, intSomarTop);
end;


function TFuncoesRelatorio.fMskDigitos(intDigitos: Integer): String;
begin
  Result := untFuncoesSimples.fMskDigitos(intDigitos);
end;


function TFuncoesRelatorio.fPadC(strTexto: String; intTamanho: Integer;
  strCaracter: String): String;
begin
  Result := untFuncoesSimples.fPadC(strTexto, intTamanho, strCaracter);
end;

function TFuncoesRelatorio.fPadL(strTexto: String; intTamanho: Integer;
  strCaracter: String): String;
begin
  Result := untFuncoesSimples.fPadL(strTexto, intTamanho, strCaracter);
end;

function TFuncoesRelatorio.fPadR(strTexto: String; intTamanho: Integer;
  strCaracter: String = ' '): String;
begin
  Result := untFuncoesSimples.fPadR(strTexto, intTamanho, strCaracter);
end;

function TFuncoesRelatorio.fParametrosEntregaFutura: IParamEF;
begin
  Result := untFuncoesSimples.fParametrosEntregaFutura();
end;

function TFuncoesRelatorio.fPergunta(strMensagem: String): Boolean;
begin
  result := untFuncoesSimples.fPergunta(strMensagem);
end;



function TFuncoesRelatorio.fConsulta(arrSql,
                                     arrCampos,
                                     arrOrdenacao: Array Of String;
                                     strCampoChave,
                                     strTabela,
                                     strNomForm,
                                     strTitulo: String;
                                     qryAux: TUniQuery;
                                     objFrmPnl: TPanelCx;
                                     blnSimples: Boolean;
                                     Var arrSelec: TConsultasArray;
                                     strCodBusca: String = 'AUTOINCREM';
                                     objConsulta: Pointer = Nil;
                                     blnTablet: Boolean = False;
                                     blnConIte: Boolean = False;
                                     strCampoChave2 : String = ''): Boolean;
begin
  Result := untFuncoesSimples.fConsulta(arrSql,
                                 arrCampos,
                                 arrOrdenacao,
                                 strCampoChave,
                                 strTabela,
                                 strNomForm,
                                 strTitulo,
                                 qryAux,
                                 objFrmPnl,
                                 blnSimples,
                                 arrSelec,
                                 strCodBusca,
                                 objConsulta,
                                 blnTablet,
                                 blnConIte,
                                 strCampoChave2);
end;

function TFuncoesRelatorio.fGetStrCodigos(edtCodigo: TEditFocus; arrLinha: TConsultasArray; blnQuoted: Boolean = False): String;
begin
  Result := untFuncoesConsulta.fGetStrCodigos(edtCodigo, arrLinha, blnQuoted);
end;

function TFuncoesRelatorio.fItemEstrutura(strCodIte: String): Boolean;
begin
  Result := untFuncoesSimples.fItemEstrutura(strCodIte);
end;

function TFuncoesRelatorio.fItemEstruturaIndustrial(strCodIte: String): Boolean;
begin
  Result := untFuncoesSimples.fItemEstruturaIndustrial(strCodIte);
end;

function TFuncoesRelatorio.fPesqCampanha(Selff: TForm; edtCodCam: TCustomEdit;
  edtDesCam: TEditFocus; qryConCam: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean = True;
  strTitulo: String = 'Consulta de Campanhas'): Boolean;
begin
  Result := untConsultas.fPesqCampanha(Selff, edtCodCam, edtDesCam, qryConCam,
    chrKey, arrSel, blnConSim, strTitulo);
end;

function TFuncoesRelatorio.fPesqCamsposLayout(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  strFiltro: String; intPosCam: Integer; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqCamsposLayout(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, strFiltro, intPosCam, blnConSim);
end;




function TFuncoesRelatorio.fPesqCfgSis(Selff: TForm; edtCodCfg: TCustomEdit;
  edtDesCfg: TEditFocus; qryConCfg: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean; strTitulo: String): Boolean;
begin
  Result := untConsultas.fPesqCfgSis(Selff, edtCodCfg, edtDesCfg, qryConCfg,
                                     chrKey, arrSel, blnConSim, strTitulo);
end;

function TFuncoesRelatorio.fPesqCfgTin(Selff: TForm; edtCodCfg: TCustomEdit;
  edtDesCfg: TEditFocus; qryConCfg: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean; strTitulo: String): Boolean;
begin
  Result := untConsultas.fPesqCfgTin(Selff, edtCodCfg, edtDesCfg, qryConCfg,
                                     chrKey, arrSel, blnConSim, strTitulo);
end;


function TFuncoesRelatorio.fPesqCidade(Selff: TForm; edtCodigo: TCustomEdit;
  edtCidade, edtEstado: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqCidade(Selff, edtCodigo, edtCidade, edtEstado, qryTabela,
    chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqClaIPI(Selff: TForm; edtClaIPI: TCustomEdit;
  qryConIPI: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  blnConSim: Boolean; strTitulo: String): Boolean;
begin
  result := untConsultas.fPesqClaIPI(Selff, edtClaIPI, qryConIPI, chrKey,
    arrSel, blnConSim, strTitulo);
end;


function TFuncoesRelatorio.fPesqCondicoesPgto(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim, blnTablet: Boolean;
  opcTipCon: TTipoConsultaCondPagto; fltMarDoc, fltValDoc: Double;
  strCodCli: String; blnAtivas: Boolean; blnFaturamento: Boolean): Boolean;
begin
  Result := untConsultas.fPesqCondicoesPgto(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, blnTablet, opcTipCon, fltMarDoc, fltValDoc, strCodCli,
    blnAtivas, blnFaturamento);
end;

function TFuncoesRelatorio.fPesqConfiguracaoRel(opcTipCfg : TTipoConsultaSimples;
                                                Selff      : TForm;
                                                edtCodigo : TCustomEdit;
                                                edtDesPor : TEditFocus;
                                                qryTabela : TUniQuery;
                                                var chrKey: Char;
                                                var arrSel: TConsultasArray;
                                                strWhere  : String;
                                                blnConSim : Boolean;
                                                strTitulo : String): Boolean;
begin
  Result := untConsultas.fPesqConfiguracaoRel(opcTipCfg, Selff, edtCodigo, edtDesPor, qryTabela,
    chrKey, arrSel, strWhere, blnConSim, strTitulo);
end;

function TFuncoesRelatorio.fPesqConsumidores(Selff: TForm; edtCodCon,
  edtDesCon: TDBEditFocus; edtCgcCpf: TEditFocus; mskNumCgc: TMaskEditFocus;
  qryTabela: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  strCodCli: String; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqConsumidores(Selff, edtCodCon, edtDesCon, edtCgcCpf,
    mskNumCgc, qryTabela, chrKey, arrSel, strCodCli, blnConSim);
end;


function TFuncoesRelatorio.fPesqDiversos(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim, blnVerStatus, blnVerEmpAce: Boolean;
  strCodCli: String): Boolean;
begin
  Result := untConsultas.fPesqDiversos(Selff, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnVerStatus, blnVerEmpAce, strCodCli);
end;

function TFuncoesRelatorio.fPesqParceiro(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; Var chrKey: Char; Var arrSel: TConsultasArray;
  blnConSim: Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqParceiro(Selff, edtCodigo, edtDescri, qryTabela, chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqECF(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqECF(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim );
end;

function TFuncoesRelatorio.fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                          Selff     : TForm;
                          edtCodigo: TCustomEdit;
                          edtNomEmp: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True;
                          blnResEmp: Boolean = False;
                          strEmpPfl: String  = '';
                          blnAceCtr: Boolean = False;
                          strAceCtr: String = ''): Boolean;
begin
  Result := untConsultas.fPesqEmpresa(opcTipCon, Selff, edtCodigo, edtNomEmp, qryTabela,
    chrKey, arrSel, blnConSim, blnResEmp, strEmpPfl, blnAceCtr, strAceCtr);
end;

function TFuncoesRelatorio.fPesqEntregasRotasRegiao(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean;
  strCodCid: String; blnFiltroPorData: Boolean): Boolean;
begin
  Result := untConsultas.fPesqEntregasRotasRegiao(Selff, edtCodigo, edtDescri,
    qryTabela, chrKey, arrSel, blnConSim, strCodCid, blnFiltroPorData);
end;

function TFuncoesRelatorio.fPesqEntrga(Selff: TForm; edtNumEnt: TCustomEdit;
  qryConEnt: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  blnConSimp: Boolean = True; strTitulo : String = 'Consulta de Entregas'): Boolean;
begin
  Result := untConsultas.fPesqEntrga(Selff, edtNumEnt, qryConEnt, chrKey, arrSel,
    blnConSimp, strTitulo);
end;


function TFuncoesRelatorio.fPesqFormaPgto(opcTipPgt: TTipoConsultaFormaPagto;
  Selff: TForm; edtCodigo: TCustomEdit; edtDescri: TEditFocus;
  qryTabela: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  blnConSim: Boolean = True; blnTablet: Boolean = False): Boolean;
begin
  Result := untConsultas.fPesqFormaPgto(opcTipPgt, Selff, edtCodigo, edtDescri,
    qryTabela, chrKey, arrSel, blnConSim, blnTablet);
end;

function TFuncoesRelatorio.fPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
  Selff: TForm; edtCodigo, edtNomEmp: TCustomEdit; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqFornecedor(opcConFor, Selff, edtCodigo, edtNomEmp,
    qryTabela, chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqGrupo(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim, blnDesRes: Boolean): Boolean;
begin
  Result := untConsultas.fPesqGrupo(Selff, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnDesRes);
end;

function TFuncoesRelatorio.fPesqGrupoAtividade(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqGrupoAtividade(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqGrupoCompra(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqGrupoCompra(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqGrupoOperador(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqGrupoOperador(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqGrupoProduto(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescricao: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqGrupoProduto(Selff, edtCodigo, edtDescricao, qryTabela,
    chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqTipoServico(Selff : TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  Var chrKey: Char; Var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqTipoServico(Selff, edtCodigo, edtDescri, qryTabela,
                                          chrKey, arrSel, blnConSim);
end;


function TFuncoesRelatorio.fPesqItem(opcTipIte: TTipoConsultaItem; Selff: TForm;
  edtCodigo, edtDesIte: TCustomEdit; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean; objFrmPnl: TPanelCx;
  strTitulo, strTabPre, strConPag: String; fltTaxVpr: Double; blnEmpFat,
  blnExiPar: Boolean; intOpcAtivos: Integer; opcCodIte: TCodigoRetornoItem;
  strAplica: String; blnPedCom: Boolean; strCodCli: String; blnMostrarPrecos,
  blnTablet, blnConsiderarExiLis: Boolean; strCodCmp: String;
  blnDepMatPriIndustrial, blnDepProAcaIndustrial, blnDepProEmbIndustrial,
  blnDepProGraIndustrial, blnVeioF11, blnSomenteEstrutura: Boolean): Boolean;
begin
  Result := untConsultas.fPesqItem(opcTipIte, Selff, edtCodigo, edtDesIte, qryTabela,
    chrKey, arrSel, blnConSim, objFrmPnl, strTitulo, strTabPre, strConPag, fltTaxVpr,
    blnEmpFat, blnExiPar, intOpcAtivos, opcCodIte, strAplica, blnPedCom, strCodCli,
    blnMostrarPrecos, blnTablet, blnConsiderarExiLis, strCodCmp, blnDepMatPriIndustrial,
    blnDepProAcaIndustrial, blnDepProEmbIndustrial, blnDepProGraIndustrial, blnVeioF11,
    blnSomenteEstrutura);
end;

function TFuncoesRelatorio.fPesqLayout(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; strTipImp: String;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqLayout(Selff, edtCodigo, edtDescri, qryTabela, strTipImp,
    chrKey, arrSel, blnConSim);
end;


function TFuncoesRelatorio.fPesqLoteItens(Selff: TForm; edtNumLote,
  edtCodIte: TEditFocus; intDecUni: Integer; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqLoteItens(Selff, edtNumLote,
  edtCodIte, intDecUni, qryTabela, chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqMarcas(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqMarcas(Selff, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqMotorista(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean = True; blnAtivos: Boolean = False): Boolean;
begin
  Result := untConsultas.fPesqMotorista(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, blnAtivos);
end;

function TFuncoesRelatorio.fPesqMotVendasPerdidas(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqMotVendasPerdidas(Selff, edtCodigo, edtDescri,
    qryTabela, chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqOcorrencia(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqOcorrencia(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
end;


function TFuncoesRelatorio.fPesqOperador(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim, blnAtivos, blnGerentes, blnMecanicos,
  blnVenRepre, blnCompradores, blnAdministrativo,
  blnSubGerentes: Boolean): Boolean;
begin
  Result := untConsultas.fPesqOperador(Selff, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnAtivos, blnGerentes, blnMecanicos, blnVenRepre, blnCompradores,
    blnAdministrativo, blnSubGerentes);
end;

function TFuncoesRelatorio.fPesqPedidoCompra(Selff: TForm;
  edtCodPed: TCustomEdit; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; var strDoc: String; strCodEmp: String;
  intIndice: Integer; blnConSim: Boolean; objFrmPnl: TPanelCx; strLitGal,
  strTitulo: String): Boolean;
begin
  Result := untConsultas.fPesqPedidoCompra(Selff, edtCodPed, qryTabela, chrKey,
    arrSel, strDoc, strCodEmp, intIndice, blnConSim, objFrmPnl, strLitGal, strTitulo);
end;


function TFuncoesRelatorio.fPesqPesquisa(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqPesquisa( Selff,
                                        edtCodigo,
                                        edtDescri,
                                        qryTabela,
                                        chrKey,
                                        arrSel,
                                        blnConSim );
end;

function TFuncoesRelatorio.fPesqPortador(opcTipPor: TTipoConsultaSimples;
  Selff: TForm; edtCodigo: TCustomEdit; edtDesPor: TEditFocus;
  qryTabela: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  blnConSim: Boolean = True; strTitulo: String = 'Consulta de Portadores';
  strBolFat: String = ''; blnSalPor: Boolean = False): Boolean;
begin
  Result := untConsultas.fPesqPortador(opcTipPor, Selff, edtCodigo, edtDesPor,
    qryTabela, chrKey, arrSel, blnConSim, strTitulo, strBolFat, blnSalPor);
end;

function TFuncoesRelatorio.fPesqProdAcabado(Selff: TForm;
  edtCodAca: TCustomEdit; edtDesAca: TEditFocus; qryConAca: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; strEmpAca: String;
  blnConSim: Boolean; strTitulo: String; strEmpEst: String): Boolean;
begin
  Result := untConsultas.fPesqProdAcabado(Selff, edtCodAca, edtDesAca, qryConAca,
    chrKey, arrSel, strEmpAca, strEmpEst, blnConSim, strTitulo);
end;

function TFuncoesRelatorio.fPesqPromocoes(Selff: TForm; edtCodPro,
  edtDesPro: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim : Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqPromocoes(Selff, edtCodPro, edtDesPro, qryTabela,
    chrKey, arrSel, blnConSim);
end;


function TFuncoesRelatorio.fPesqRegiao(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqRegiao(Selff, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqServicos(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean = True; blnAutCen: Boolean = False): Boolean;
begin
  Result := untConsultas.fPesqServicos(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, blnAutCen);
end;

function TFuncoesRelatorio.fPesqSetFlz(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqSetFlz(Selff, edtCodigo, edtDescri, qryTabela,
                                     chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqSubRegiao(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqSubRegiao(Selff, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqTabelaPreco(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqTabelaPreco(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqTipoAtendimento(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqTipoAtendimento(Selff, edtCodigo, edtDescri, qryTabela,
                                chrKey, arrSel, blnConSim);
end;

function TFuncoesRelatorio.fPesqTipoCliente(Selff: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqTipoCliente(Selff, edtCodigo, edtDescri, qryTabela,
                                          chrKey, arrSel, blnConSim);
end;




function TFuncoesRelatorio.fPesqUnidade(Selff: TForm; edtCodigo: TCustomEdit;
  edtUnidade, edtSigla: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim, blnPesqSigla: Boolean): Boolean;
begin
  Result := untConsultas.fPesqUnidade(Selff, edtCodigo, edtUnidade, edtSigla, qryTabela,
    chrKey, arrSel, blnConSim, blnPesqSigla);
end;

function TFuncoesRelatorio.fPesqVeiculos(Selff: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean = True; blnComMsk: Boolean = True): Boolean;
begin
  Result := untConsultas.fPesqVeiculos(Selff, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnComMsk);
end;

function TFuncoesRelatorio.fPreImpressao(qryCfgRel: TUniQuery; var strNomeFila,
  strTipImp: String; blnLocal: Boolean; strDirImp: String): Boolean;
begin
  Result := TCfgRel.fPreImpressao(qryCfgRel, strNomeFila, strTipImp, blnLocal, strDirImp);
end;

function TFuncoesRelatorio.fMostraFilas(var strNomeFila: String; strNomFormul: String;
  qryCfgRel: TUniQuery; blnBotoes: Boolean): Boolean;
begin
  Result := TCfgRel.fMostraFilas(strNomeFila, strNomFormul, qryCfgRel, blnBotoes);
end;

function TFuncoesRelatorio.VerImpressoraONLINE(impressora: String): Cardinal;
begin
  Result := TCfgRel.VerImpressoraONLINE(impressora);
end;

function TFuncoesRelatorio.fIdentificarNomeDaImpressora(
  AImpressora: String): String;
begin
  Result := TCfgRel.fIdentificarNomeDaImpressora(AImpressora);
end;

function TFuncoesRelatorio.fPreInv(strAlias, strAliasImpFed,
  strPreInv: String): String;
begin
  Result := untFuncoesSimples.fPreInv(strAlias, strAliasImpFed, strPreInv);
end;

function TFuncoesRelatorio.fPreInvTitulo(strPreInv: String): String;
begin
  Result := untFuncoesSimples.fPreInvTitulo(strPreInv);
end;

function TFuncoesRelatorio.fRetVS_strTipExp: String;
begin
  Result := VS_strTipExp;
end;

function TFuncoesRelatorio.fUsaQtdPendenteEntregaFutura: Boolean;
begin
  Result := untFuncoesSimples.fUsaQtdPendenteEntregaFutura;
end;

function TFuncoesRelatorio.fUsaSat(strCodEmp: String): Boolean;
begin
  Result := untFuncoesSimples.fUsaSat(strCodEmp);
end;

function TFuncoesRelatorio.fCadEmp(strNomCampo: String): String;
begin
  Result := untFuncoesSimples.fCadEmp(strNomCampo);
end;

function TFuncoesRelatorio.fCadEmp(strNomCampo: String;  qryGenEmp: TUniQuery): String;
begin
  Result := untFuncoesSimples.fCadEmp(strNomCampo, qryGenEmp);
end;



procedure TFuncoesRelatorio.pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery);
begin
  untPesqAux.pAtribuiDisplayLabels(qryTabOri, qryTabDest);
end;

procedure TFuncoesRelatorio.pAtuVarGlobaisSimples;
begin
  untFuncoesSimples.pAtuVarGlobaisSimples;
end;

procedure TFuncoesRelatorio.pPesquisaCadAti(qryTabOri, qryTabela: TUniQuery; strCodAti: String);
begin
  untPesqAux.pPesquisaCadAti(qryTabOri, qryTabela, strCodAti);
end;

procedure TFuncoesRelatorio.pPesquisaCadCli(qryTabOri, qryTabela: TUniQuery;
  strCodCli: String; blnVerCnd, blnVerCli: Boolean);
begin
  untPesqAux.pPesquisaCadCli(qryTabOri, qryTabela, strCodCli, blnVerCnd, blnVerCli);
end;

procedure TFuncoesRelatorio.pPesquisaAbfIcm(qryTabOri, qryTabela: TUniQuery; strCodAbf: String; strEstado: String = '');
begin
  untPesqAux.pPesquisaAbfIcm(qryTabOri, qryTabela, strCodAbf, strEstado);
End;

Function TFuncoesRelatorio.fStrTituloPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus): String;
begin
  Result := untFuncoesConsulta.fStrTituloPeriodo(mskDtaIni, mskDtaFin);
end;

function TFuncoesRelatorio.fStrTitulo(edtCodigo, edtDescri: TEditFocus;
  arrLinha: TConsultasArray; strLinha, strTitulo: String): String;
begin
  Result := untFuncoesConsulta.fStrTitulo(edtCodigo, edtDescri, arrLinha, strLinha, strTitulo);
end;

function TFuncoesRelatorio.fRetNomCor(strCodCor: String): String;
begin
  result := untFuncoesSimples.fRetNomCor(strCodCor);
end;

function TFuncoesRelatorio.fPesqCores(Selff     : TForm;
                                      edtCodigo : TCustomEdit;
                                      edtDescri : TEditFocus;
                                      qryTabela : TUniQuery;
                                      Var chrKey: Char;
                                      Var arrSel: TConsultasArray;
                                      blnConSim : Boolean = True;
                                      strCodGra : String = ''): Boolean;
begin
  result := untConsultas.fPesqCores(Selff, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, strCodGra );
end;

function TFuncoesRelatorio.fRetDadosEmitente(strNumCgc: String; var strNomEmi,
                           strEndere, strTele01: String): Boolean;
begin
  Result := untFuncoesSimples.fRetDadosEmitente(strNumCgc, strNomEmi, strEndere, strTele01);
end;


function TFuncoesRelatorio.fRetDesMotivoAtend(strCodMot: String): String;
begin
  Result := untFuncoesSimples.fRetDesMotivoAtend(strCodMot);
end;



function TFuncoesRelatorio.fCarregaCartoesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
begin
  Result :=  untFuncoesSimples.fCarregaCartoesTransferidos(intSeqcon,strEmpRcx,dtaDtaCad,blnNaoTransf);
end;

function TFuncoesRelatorio.fCarregaChequesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
begin
  Result :=  untFuncoesSimples.fCarregaChequesTransferidos(intSeqcon,strEmpRcx,dtaDtaCad,blnNaoTransf);
end;

function TFuncoesRelatorio.fCarregaImagemLinhaGrupo(strCodGru: String; picImagem: TPicture): TRetornoImagem;
begin
  Result := untFuncoesImagem.fCarregaImagemLinhaGrupo(strCodGru, picImagem);
end;

function TFuncoesRelatorio.fCarregaImagemLinhaGrupo(strCodGru: String; picImagem: TfrxPictureView): TRetornoImagem;
begin
  Result := untFuncoesImagem.fCarregaImagemLinhaGrupo(strCodGru, picImagem);
end;


function TFuncoesRelatorio.fRetConPagCodCnd(strCodCnd: String): String;
begin
  Result := untFuncoesSimples.fRetConPagCodCnd(strCodCnd);
end;

function TFuncoesRelatorio.fRetornaSaldoDisponivel(strCodIte: String; blnCnvMl : Boolean = False; blnFaturamento: Boolean = True; strNumLot : String = ''; blnConsiderarPedidos : Boolean = True): Double;
begin
  Result := untFuncoesSimples.fRetornaSaldoDisponivel(strCodIte, blnCnvMl, blnFaturamento,strNumLot, blnConsiderarPedidos);
end;

function TFuncoesRelatorio.fFormataCasaDecimalVIDRO(strMascaraDefault : Variant) : Variant;
begin
  Result := untFuncoesSimples.fFormataCasaDecimalVIDRO(strMascaraDefault);
end;

function TFuncoesRelatorio.fRetornaInfMedVIDRO(blnDoisPontos: Boolean = False; blnAbreviadoComprimento: Boolean = False;blnMaximo : Boolean = False; blnMensagem :Boolean = False;blnAbreviadoAltura : Boolean = False) : String;
begin
  Result :=  untFuncoesSimples.fRetornaInfMedVIDRO(blnDoisPontos, blnAbreviadoComprimento, blnMaximo, blnMensagem, blnAbreviadoAltura);
end;

function TFuncoesRelatorio.fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
begin
  Result := untFuncoesSimples.fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli, blnCliBalcao, blnCliSegura);
end;


function TFuncoesRelatorio.fSQLIn(objCodigo: TObject; arrLinha: TConsultasArray;
  strNomCampo, strNomPar: String; blnSemAND, blnNegar: Boolean;
  strCodigo: String): String;
begin
  Result := untFuncoesConsulta.fSQLIn(objCodigo, arrLinha, strNomCampo, strNomPar, blnSemAND, blnNegar, strCodigo);
end;

initialization
  pInicializarCfgRel();

end.
