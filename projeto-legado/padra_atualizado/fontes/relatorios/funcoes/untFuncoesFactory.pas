unit untFuncoesFactory;

interface

uses untIFuncoes, Classes, Uni, Vcl.Forms, untTypesSistema, Vcl.Controls, Data.DB,
  BitBtnLockedIncrem, StdCtrls, EditFocus, untClassPanelCx, ComboBoxFocus,
  untITintasDeMaquina, UniClientDataSet, DBEditFocus, MaskEditFocus, untICamGer,
  untIValorRecebido, untIConfTinta, untIControlePagtoFunc, untIFastPrint, untIMetAno,
  untFuncoesGenerica, untIIteBar, untIFuncoesEditorFast, untIOrdenacao, untIMadeireira,
  untIFinanceira, untICamposUso, untIFuncMacro, untIZClient, untICadLote, untConstantes,
  untIFiltrosRelatorio, untIConfiguracao,DBComboBoxFocus, untIMesesGiro, frxClass,
  SysUtils, CheckLst, RLPreviewForm, RLReport, Graphics, untIFatReservaSaldo,
  untIFatEntregaFutura;

  function fTamDocCadRec: Integer;
  function fCriaClientDataSetClientesDebitos: TUniClientDataSet;inline;
  function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean; inline;
  function fEhEstadoRegraZonaFranca(strEstado: String): Boolean; inline;
  function fTiraCaracEspeciaisPonto(strTexto: String): String; inline;
  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True): String; inline;
  function fRetNomeEmpresaSelec(Const strCodEmpresa: String): String; inline;
  function fRetNomVendRep(strCodVen: String): String; Overload; inline;
  function fRetNomVendRep(strCodVen: String; strCodEmp: String): String; Overload; inline;
  function fRetNomCliente(Const strCodCli: String): String; inline;
  function fRetNomeRedeLoja(Const strCodRed: String): String; inline;
  function fRetNomeRede: String; inline;
  function GetIPAddress: Integer; inline;
  function GetIPAddressAsString: String; inline;
  function GetMacAddress: String; inline;
  function GetUserFromWindows: String; inline;
  function GetComputerNetName: String; inline;
  function fRetLocSep(Const strCodLse: String): String; inline;
  function fRetNomeEmpresa: String; overload; inline;
  function fRetNomeEmpresa(strCodEmp: String): String; overload; inline;
  function fRetDadosEmitente(strNumCgc: String;
                               Var strNomEmi,
                                   strEndere,
                                   strTele01: String): Boolean;
  Function fMensagem(strTitulo: String;
                     strTexto: String;
                     arrOpcoes: Array Of String;
                     intFocoBotao: Integer = 1;
                     blnSaiComEsc: Boolean = False;
                     intEstFon: Integer = 1;
                     intWidBut: Integer = 0;
                     blnAutosize: Boolean = False;
                     intSomarTop: Integer=0;
                     blnObrigaEsc: Boolean = False;
                     blnOcultPainelBtn: Boolean = False;
                     blnBtnSemImg : Boolean = False;
                     intHeightOpc: Integer = 0;
                     intFormWidth : Integer = 0;
                     intQtdLinha: Integer = -1;
                     pProcedureAjuda: TProcedureAjuda = nil): Integer;

  function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
  function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
  function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean; inline;
  function fRetornaInGrupo(strCodGpo: String; arrGrupos: TConsultasArray; strCampo: String=''): String; inline;
  function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String; inline;
  function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant; inline;
  function fRelSomarReformaAoValorContabil: Boolean;
  function fRelSqlValorReformaFdoRef(const AAutoincrementoFatDor: String): String;
  function fRetClientesFilial: String; inline;
  function fEmptyDate(strDate: String): Boolean; inline;
  function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; inline;
  function fIsNumber(Const strNumber: String): Boolean; inline;
  function fAbrirTabela(NomeTabela: TDataSet): Boolean; inline;
  function fUsaProCodigo(strNomeTabela: String): Boolean; inline;
  function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String; inline;
  function fVerificaIntegridade(strNomFrm,
                                strTabela: String;
                                qryTabOriginal: TDataSet;
                                blnGravar: Boolean = True;
                                blnSoCriaTabela: Boolean = False;
                                strMotDel: String = '';
                                strOpeDel: String = '';
                                blnTabAux: Boolean = False): String; inline;
  function fStartTransaction: Boolean; inline;
  function fInTransaction(objConexao: TUniConnection = Nil): Boolean; inline;
  function fRollBack: Boolean; inline;
  function fCommit: Boolean; inline;
  function fValidarDirEspecificos(Var strDireitos: String; strLogin, strNomeForm: String): Boolean; inline;
  function fRetTamCampo(strNomeTabela: String): Integer; inline;
  function fAtualizaProCod(strNomeTabela: String; const strCampoBusca : String): String; inline;
  function fFecharTabela(NomeTabela: TDataSet): Boolean; inline;
  function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery; inline;
  function VerImpressoraONLINE(impressora: String): Cardinal; inline;
  function fIdentificarNomeDaImpressora(AImpressora: String): String; inline;
  function fMostraFilas(Var strNomeFila: String;
                            strNomFormul: String = '';
                            qryCfgRel: TUniQuery = nil;
                            blnBotoes: Boolean = True): Boolean; inline;
//  function fSelecionaFilaImp(Var qryCfgRel: TUniQuery): Boolean; inline;
  function fPreImpressao(qryCfgRel: TUniQuery;
                     Var strNomeFila: String;
                     Var strTipImp: String;
                         blnLocal: Boolean;
                         strDirImp: String = '' ): Boolean; inline;
  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double; inline;
  function fRetNomeLinhaGrupo(strCodigo: String): String; inline;
  function fRetNomProduto(Const strCodIte: String): String; inline;
  function fRetNomSituacaoProduto(strCodSit: String): String; inline;
  function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TPicture): TRetornoImagem; overload; inline;
  function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TfrxPictureView): TRetornoImagem; overload; inline;
  function fRetNomFornecedor(strCodFor: String): String; inline;
  function fRetNomMarca(strCodMar: String): String; inline;
  function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean; inline;
  function fGetTintasdeMaquina(blnDestruir: Boolean = False): ITintasDeMaquina; inline;
  function fRetCodVendedor(strSenha: String; blnGerente : Boolean = False; blnSubGerente: Boolean = False): String; inline;
  function fRetSenhaVendedor(strCodVen: String): String;
  function fValidaGerSubVen(blnLib: Boolean; strTipo: Char; edtCod, edtDes: TEditFocus; strTitulo:String=''): Boolean;
  function fStrLocate(objCodigo: TObject;
                        arrLinha: TConsultasArray;
                        strNomCampo,
                        strNomPar: String;
                        blnSemAND: Boolean = False;
                        blnNegar: Boolean = False;
                        strCodigo: String = ''): String; inline;
  function fRetornaComposicao(strDescri:String; blnPadrao : Boolean = False): String; inline;
  function fStrRelFatorLit(strAliasDet: String = ''; blnVeioMarkup: Boolean = False): String; inline;
  function fStrTitulo(strText: String;
                      edtDescri: TEditFocus;
                      arrLinha: TConsultasArray;
                      strLinha,
                      strTitulo: String;
                      blnTodas: Boolean = False;
                      blnNegar: Boolean = False): String; Overload; inline;
  function fStrTitulo(strText: String;
                      edtDescri: TEditFocus;
                      arrLinha: TConsultasArray;
                      strLinha,
                      strTitulo,
                      strVazio: String): String; Overload; inline;
  function fStrTitulo(edtValor: TEditFocus; strTitulo: String): String; Overload; inline;
  function fStrSQLOr(objCodigo: TObject;
                     arrLinha: TConsultasArray;
                     strNomCampo,
                     strNomPar: String;
                     blnSemAND: Boolean = False;
                     blnNegar: Boolean = False ): String; inline;
  function fRetornaNomeTinta(strIdePro: String): String; inline;
  function fDescriLinhaWandaPro(intLinha: Integer): String; inline;
  function fStrToFloat(strValorUnico: String): Double; inline;
  function fEntraCons(strCodigo: String): Boolean; inline;
  function fEscolheTinta(strCodCli : String = ''): ShortString; inline;
  function fRetNomSubRegiao(Const strCodSub: String): String; inline;
  function fRetDesReg(strCodReg: String): String; inline;
  function fRetNomUnidade(strCodUni: String): String; inline;
  function fRetNomAtividade(Const strCodAti: String): String; inline;
  function fRetDescDepartamento(strCodDep: String): String; inline;
  function fRetNomeGrupoProduto(strCodigo: String): String; inline;
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
                              intDecUni: Integer = -1):Double; inline;
  function fGetLetraAlfa(intCol: Integer): String; inline;
  function fRetNomCidadeSemOpc(strCodigo: String): String; inline;
  function fCalcMediaPagto(strConPag: String): Double; inline;
  function fFormataCondPag(strCond: String): String; inline;
  function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String; inline;
  function fTabelaExiste(strNomeTabela: String): Boolean; inline;
  function fStrZero(Zeros: string; Quant: integer): String; Overload; inline;
  function fStrZero(Zeros: Integer; Quant: integer): String; Overload; inline;
  function fRetNomCadGpo(Const strCodGpo: String): String; inline;
  function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double; inline;
  function fStrLocateEmpresa(objCodigo: TObject;
                             arrLinha: TConsultasArray;
                             strNomCampo,
                             strNomPar: String;
                             blnSemAND: Boolean = False;
                             strCodigo: String = ''): String; inline;
  function fRetConPag(strCodCnd: String): String; inline;
  function fRetPerComMargem(fltValor: Double; strTipVen : String = ''; strConPag : String = ''): Double; inline;
  function fRetPerComOpeMargem(fltCusto, fltVenda : Double; strCodOpe : String): Double; inline;
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
                                  var strComPro: String;
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
                                  strEspOrc: String = ''): Boolean; inline;
  function fRetPerComLucro(fltQtdIte,
                           fltUniOri,
                           fltTotCus,
                           fltTotIte,
                           fltDesEsp,
                           fltComVar: Double;
                           fltTotCu2: Double = 0.0;
                           strMarMkp: String = '';
                           strPcmPro: String = '';
                           intDecUni: Integer = -1): Double; inline;
  function fCurrentDate: String; Overload; inline;
  function fCurrentDate(Const Value: TDateTime): String; Overload; inline;
  function fRetNomProfissional(Const strCodPro: String; blnVerStatus: Boolean = False): String; inline;
  function fRetNomDiversos(strCodDiv: String): String; inline;
  function fRetExtensoNumero(Value : String):String; inline;
  function fDataExtenso(Data: TDateTime; blnImpCid: Boolean = False; blnImpDiaSemana: Boolean = False): String; inline;
  function fRetDataExtenso(dtaData: TDateTime; blnComCidade: Boolean = False): String; inline;
  function ffrmSenha(var strSenha: String; strTitulo: String = ''): Boolean; inline;
  function fCampoTabela(strCampo : String;
                        strNomTab: String;
                        arrCampoChave: Array Of String;
                        arrValorChave: Array Of Variant;
                        blnSempreLerBanco: Boolean = True;
                        strOrderBy: String = '';
                        Conexao: TUniConnection = Nil;
                        blnUsarMax: Boolean = False): Variant;
  function fFormataFone(strFone: String): String; inline;
  function fGetMsgRelCnf: String; inline;
  function fValidaDataStr(strData: String): Boolean; inline;
  function fRetUFCliente(strCodCli: String): String; inline;
  function fRetUFEmpresa(strCodEmp: String): String; inline;
  function fRetDadosClienteConsumidor(strDocumento, strCampo: String): String; inline;
  function fValidaPlaca(strPlaca: String): Boolean; inline;
  function fRetornaDescricaoVeic(strPlaVei: String): String; inline;
  function fFrtStrExcel(strValor: String) : String; inline;
  function fRetNomClienteConsumidor(strCodigo: String): String; inline;
  function fReplicatorStr(strRepl: String; intTamanho: Integer): String; inline;
  function fRetNomPortador(Const strCodPor: String): String; inline;
  function fRetNomDep(strCodDep: String): String; inline;
  function fRemoveAcento(Str: String): String; inline;

  {**************************************************************************************}
  {* FUNCOES CUJOS PARAMENTOS, AO PASSAR PELA INTERFACE, PERDEM VALORES DE PROPRIEDADES *}
  {* EX: TCheckListBox PERDE A LISTA DOS ITENS CHECKADOS E POR CONTA DISTO FORAM IMPLE- *}
  {* MENTADAS SOMENTE AQUI.                                                             *}
  {***********************************************************************************VA*}
  procedure pCarregaChkLisTabPre(Var ChkLis: TCheckListBox);
  function fRetTabPreSelChkLis(ChkLis: TCheckListBox): String;
  procedure pRemoveAcentoVarRel(frx: TfrxReport; arrVar: Array Of String);
  {**************************************************************************************}

  function fRetDesConPag(strCodCnd: String): String; inline;
  function IfNull(varValor, varDefault: Variant): Variant; inline;
  function fValidaEstado(strUf: String): Boolean; inline;
  function fRetNomeEstado(strNomeEstado: String): String; inline;
  function fRetDescOcorrencia(Const strCodOcorrencia: String): String; inline;
  function fRetNomFaseObra(Const strCodFas: String): String; inline;
  function fRetNomeOperador(strCodOpe: String): String; inline;
  function fGetTituloVersao(): String;
  function fGetUsuarioLogado(): String;
  function fGetEmpresaLogada(): String;
  function fRetNomeServico(Const strCodSer: String): String; inline;
  function fRetNomTransportadora(strCodTra: String): String; inline;
  function fDescricaoFrete(strTipo: String): String; inline;
  function fRetDesForPag(strCodFpg: String): String; inline;
  function fRetCidEmpresa(strCodEmp: String): String; inline;
  function fDiaDeFolga(dtaDta: TDateTime;
                       blnConsideraSabado : Boolean = True;
                       strCodCid: String = '';
                       blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                       blnConsideraDomingo: Boolean = False): Boolean; inline;
  function fGetZClient(Owner: TComponent; strSQL: String = ''): IZClient; inline;
  function fGetMesesGiro(Owner: TComponent; intAnos: Integer): IMesesGiro;
  function fComponentByName(Owner: TWinControl; strNome: String): TComponent; inline;
  function fRetDesSubReg(strCodSub: String): String; inline;
  function fGetCamGer(Owner: TComponent): ICamGer; inline;
  function fTamNumDoc: Integer; inline;
  function fGetTValorRecebido: IValorRecebido; inline;
  function fStatusCndPag(strCndPag: String): Integer; inline;
  function fRetDescFpg(Const strCodFpg: String): String; inline;
  function fRetPerComIndice(fltValor, fltValorNt: Double; blnAtingiu: Boolean): Double; inline;
  function fRetMetaIndice: Double; inline;
  function fRetTipoForaConPag(strCodCnd: String): String; inline;
  function fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean; inline;
  function fRetNomeMotorista(strCodMot: String; blnAtivos: Boolean = False): String; inline;
  function fCriaClientDatset(qryOrigem: TDataSet; blnVazio: Boolean = False; AOwner: TComponent = Nil): TUniClientDataSet; inline;
  function fMediaTime(strMedia: String): Integer; inline;
  function fSegToTempoStr(intSegundos: Integer): String; inline;
  function fRetNomeConta(strCodCta: String): String; inline;
  function fRetMotivoVendasPerdidas(Const strCodMot: String): String; inline;
  function fRetDescGrupoCompra(Const strCodGru: String): String; inline;
  function fRetQuantPendentePedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): Double; inline;
  function fRetProximaDtaEntrPedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): String; inline;
  function fRetNomeProfissional(Const strCodPro: String): String; inline;
  function fRetNomeParceiro(Const strCodPar: String): String;
  function fGetConfTinta(strIdePro: String): IConfTinta; inline;
  function fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela : String; fltCodigo: Double) : String; inline;
  function fGetTCadFun(Owner: TComponent): ICadFun; inline;
  function fSegToTimeStr(Segundos: Double): String; inline;
  function fRetMotorista(Const strCodMot: String): String; inline;
  function fRetCidade(Const strCodigo: String): String; inline;
  function fRetNomRegiao(Const strCodReg: String): String; inline;
  function fGetTExtratoComissaoProfissional(dtaEntIni,
                                            dtaEntFin,
                                            dtaBaiIni,
                                            dtaBaiFin: TDateTime;
                                            objCodPro,
                                            objCodAti,
                                            objCodCli,
                                            objCodRed,
                                            objCodEmp: TObject;
                                            arrCodPro,
                                            arrCodAti,
                                            arrCodCli,
                                            arrCodRed,
                                            arrCodEmp: TConsultasArray;
                                            fltVlrCom: Double;
                                            intCalcul: Integer;
                                            strTipFil: String;
                                            strTCoPro: String;
                                            intOrdena: Integer): IFastPrintFile; inline;

  function fGetTFastPrintFileEditor(AOwner: TComponent): IFastPrintFileEditor; inline;
  function fGetObjFastPrintFileEditor(): TObject; inline;

  function fGetTReciboCtp(cdsDados: TUniClientDataSet): IFastPrintFile; inline;
  function fCriaClientDatasetReciboCTP : TUniClientDataSet; inline;
  function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; inline;
  function fRetVS_strTipExp: String;
  function fUsaQtdPendenteEntregaFutura: Boolean;
  function fRetDescGrupoAtividade(strCodGat: String): String; inline;
  function fEhLetra(strCaract: String): Boolean; inline;
  function fSomenteLetra(str: String): String; inline;
  function fGetTMetAno(blnGlobal: Boolean = False; blnEmpOrigem: Boolean = False; strComCus: String = ''): IMetAno; inline;
  function fRetSiglaUni(const strCodUni: String): String;inline;
  function fRetSiglaUnidade(const strCodUni: String; qryAux: TUniQuery = Nil): String; inline;
  function fRetSiglaUniConsulta(const strSigUni: String): String;inline;
  function fValidaAcessoMultSelEmpresa(arrSelecao: TConsultasArray; Var strEmpNegadas: String): Boolean; inline;
  function fRetDataPortador(strCodPor: String): TDateTime; inline;
  function fDropTable(strNomeTabela: String): Boolean; inline;
  function fRetSaldoAnterior(strCodPor: String; dtaDataIni: TDateTime; strCodEmp: String = '';
                             sitSitLan: TSituacaoLancBancario = sitTodos): Currency; Inline;
  function fRetornaCtaResDuplicado(qryAux: TUniQuery): Boolean; Inline;
  function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Inline;
  function fRetNomEvento(strCodEve: String): String; Inline;

  function fDigDuplicSemTela(Var arrDuplicata: TarrDuplicata;
                             Var intQtdDup: Integer;
                             Var curTotalRes: Currency;
                             strCndPag:String;
                             intNumDoc:Integer;
                             curTotal:Currency;
                             blnEditavel,blnHabEditDup:Boolean;
                             dtaDtaBas:TDateTime;
                             blnPergConf: Boolean;
                             fltImpost: Double = 0;
                             strUsaChq: String = 'N';
                             blnDupsRedondas: Boolean = True;
                             blnUsaHist: Boolean = False;
                             fltValRec: Double = 0.0;
                             arrValores: TDoubleArray = Nil;
                             blnSabDomFeriadoDiasUteis: Boolean = True;
                             strCodCid: String = ''): Boolean; Inline;

  function fRetNomTipoAtend(strCodigo: String): String; inline;
  function fCriaDataSource(DataSet: TDataSet): TDataSource; inline;
  function fCadEmp(strNomCampo: String): String; Overload; inline;
  function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery): String; Overload; inline;
  function fCampoExiste(const strTabela, strCampo: String): Boolean; Inline;
  function fRetForFilialTodos(blnLista: Boolean = False): String; Inline;
  function StringToFloat(str : String) : Extended; Inline;
  function fStrTituloPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus): String; Inline;
  function fStrTitulo(edtCodigo, edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo: String): String; overload;
  function fItemEstrutura(strCodIte: String): Boolean; Inline;
  function fRetUnidadeItem(strCodIte: String): String; Inline;
  function fRetMarcaItem(strCodIte: String): String; Inline;
	function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String; InLine;
  function fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String; InLine;
  function fCon_Precos(fltPreAtu: Double; intTipPre: Integer; blnCalGua: Boolean; dtaDtaMoe: TDate; blnConGua: Boolean = False): Double; InLine;
  function fRetDesSfz(strCodigo: string): String; InLine;
  function fGetNumLinhasMemo(strMemo: String): Integer; InLine;
  function fRetNomCanalAcesso(Const strCodCac: String): String;InLine;
  function fExt1(strS : String; strIdioma: String = 'P'): String;InLine;
  function fExt2(strS : string; strIdioma: String = 'P'): String;InLine;
  function fExt3(strS : string; strIdioma: String = 'P'): String;InLine;
  function fExtDezena(strS : String; strIdioma: String = 'P'): String;InLine;
  function FMes_Espano(dtaData: TDateTime; intTam: Integer): String;InLine;
  function fArqIni(ReadWrite :Integer; NomChave, NomSecao, Conteudo : String; strNomArq : String = '') : String;InLine;
  function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;InLine;
  function fValidaCndPag(strCndPag: String; blnPerRep: Boolean = False): Boolean; overload;InLine;
  function fValidaCndPag(strCndPag: String; Var strCndRet: String;
    dtaDtaBas: TDateTime; blnPerRep: Boolean = False): Boolean; overload;InLine;
  function fRetNomCfg(strCodCfg: String): String; InLine;
  function fRetNomCfgTin(strCodCfg: String): String; InLine;
  function fRetAtividade(strCodAti: String): String; InLine;
  function fPreInv(strAlias : String = ''; strAliasImpFed : String = ''; strPreInv: String = ''):String; Inline;
  function fPreInvTitulo(strPreInv: String = ''): String; Inline;
  function fRoundSql(const strCampo: String; const intDecimais: Integer): String; Inline;
  function fRetornaSaldoCaixa(var dtaDtaCai: TDateTime; strCodEmp: String): Double; Inline;
  function fCaixaTemMovimento(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = ''; blnSoma: Boolean = False; dtaDtaFin: TDateTime = 0): Boolean;
  function fMovimentoFechamentoCaixa(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = ''): Boolean;
  procedure pRetornaUltimoFechamento(var fltUltFec: Double; var dtaDtaFec: TDateTime; strCodEmp: String = ''); inline;
  function fNecessitaFecharCaixa(blnFaturamento: Boolean; var dtaDtaLan: TDateTime; blnMostraMsg: Boolean = True; strCodEmp: String = ''): Boolean; inline;
  function fRetSiglaEmpresa(strCodEmp: String): String; Inline;
  function fRetMascaraFone(opcPais: TPais): String;Inline;
  function fRetMascaraFonePais: String;Inline;
  function fSQLCarregaEstoqu(dtaBase: TDateTime): String; Overload; Inline;
  function fVerificaCampoPrcCmpImp(dtaBase: TDateTime): Boolean; Inline;
  function fRetornaComposicaoPadrao: String; Inline;
  function fRetDebitoCliente(strCodCli: String): Double; inline;
  function fRetDescCentroCusto(strCodCta: String): String; inline;
  function fExisteCheque(strDocume, strCodEmp: String; intSeqCon: Integer; qryCheques: TUniQuery): Boolean; inline;
  function fGetTFuncoesEditorFast: IFuncoesEditorFast; inline;
  function fDigQuantidade(strCaption, strLabel: String; Var intQtdDig: Integer;
    intMin: Integer = -MaxInt; intMax: Integer = MaxInt): Boolean;inline;
  function fFormataCEP(strCEP: String): String; inline;
  function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime): TDateTime; inline;
  function fRetNomeCartao(strCodCar: String): String; inline;
  function fRetValorCfg(strCodCfg, strValCfg: String): String; inline;
  function fRetNomBandeira(strCodBan: String): String; inline;
  function fGetTIteBar(opcCriacaP: TOpcaoCriacao = opcFuncoes;
                       qryTabIteP: TUniQuery = Nil;
                       dbeCodBarP: TDBEditFocus = Nil;
                       dbeBarEmbP: TDBEditFocus = Nil;
                       dbeEmbalaP: TDBEditFocus = Nil;
                       wncLocCadP: TWincontrol  = Nil;
                       strCodIteP: String = ''): IIteBar; InLine;
  function fVerificaImpressora(strNomeImpr: String): Boolean; inline;
  function fPergunta(strMensagem: String): Boolean; Inline;
  function fRetTopoEtiqueta(strTipEti: String): Integer; inline;
  function fItemEstruturaIndustrial(strCodIte: String): Boolean; Inline;
  function fRetNomCor(strCodCor: String): String; Inline;
  function fCriaAggregateField(cdsClient: TUniClientDataSet;
                               strFieldName,
                               strExpression: String;
                               strDisplayFormat: String = '';
                               blnActive: Boolean = True): TAggregateField; inline;
  function fGetTOrdenacao(Owner: TComponent; strCampos: String; intCodEtiP: Integer): IOrdenacao; inline;
  function fMskDigitos(intDigitos: Integer): String; inline;
  function fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean; inline;
  function fDescontoClienteProfissional(strCodCli: String): Boolean; inline;
  Procedure pSetaNumPedCom(edtNumPed: TEditFocus); inline;

  function fSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; intQtdCol: Integer = 0): String; inline;
  function fRetSeqConCadRec(strNumDup: String;
                            strEspDoc: String;
                            strParcel: String;
                            strCodEmp: String;
                            strCodCli: String;
                            strOriF11: String): String; inline;
  function fRetLocFisicaEmpEmissora(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String; inline;
  function fRetDesFisicaEmpEmissora(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String; inline;
  function fRetLocFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String; inline;
  function fRetDesFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String; inline;
  function fImprimirCabecalhoDocEmpresaPedidoCD(strNumFat, strTipFat, strEmpFat: String; Var strEmpPed: String): Boolean; inline;
  function fMarcarPedidoComoImpresso(strNumDoc, strEspDoc, strCodEmp: String; blnDocSep, blnImpExpedicao: Boolean): Boolean; inline;
  function fExecutaSQL(strSQL: String): Boolean; inline;
  function fRetMltVenItem(const strCodIte: String): Double; inline;
  function fRetiraZerosEsquerda(strDado: String): String; inline;
  function fRetNomeMarca(strCodigo: String): String; inline;
  function fRetNomTabAuxMov(strNomTab: String): String; inline;
  function fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes: String): String; inline;
  function fGetTMadeireira: IMadeireira; inline;
  function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double; Overload; inline;
  function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; strDtaPag: String; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double; Overload; inline;
  function fRetNomeBancoSelec(Const strCodBco: String): String; inline;
  function fGetTFinanceira(AOwner: TComponent): IFinanceira; inline;
  function fRetDesRegiao(strCodReg: String): String; inline;
  function fCriaDiretorio(strPath: String): Boolean; inline;
  function fRetFantasiaEmpresa(strCodEmp: String = ''): String; inline;
  function fGetTCamposUso: ICamposUso; inline;
  function fGetTFuncMacro: IFuncMacro; inline;
  function fRetSQLCGCCPFFormatado(strCampoCGCCPF, strCampoC_G_C_: String): String; inline;
  function fInformacaoAdicionalEtiquetaItens: String; inline;
  function fVer_Banco_Carteira(strCodBan, strChave: String;
                               Var strBanRet: String;
                               Var intCarRet: Integer;
                               blnVeioImpBol: Boolean = True): Boolean; inline;
  function fArqIniAutban(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String): String; inline;
  function fFormataCCusto(strValor: String): String; Inline;
  function fFilaExiste(strFila: String): Boolean; inline;
  function fGetMenu(strTitulo: String;
                    arrOpcoes: Array Of String;
                    intOpcao: Integer;
                    blnSaiComEsc: Boolean = False): Integer;
  function fAtuCfgSis(strCamCfg, strValCfg: String; strCodEmp: String = ''): Boolean; Inline;
  function fRetNatOpe(strCodCfo: String): String; Inline;
  function fInc(var intValor: Integer): Integer; Inline;
  function fRetTelaSelecaoImp(Var oleDados: OleVariant; var strOrdenacao: string; var bVerificarEmail: boolean): Boolean; inline;
  function fGetTipoAbfFornecedor(const strCodFor: String): String; Inline;
  function fGetTipoAbfCliente(const strCodCli: String): String; Inline;
  function fRetEnderecoEmpresa(strCodEmp: String): String; Inline;
  function fImprimeEtiqueta(prmDllRel: Pointer; strNomFun: String = 'fimprimeetiquetas'): Boolean; inline;
  function fRetDesAbfPis(strAbfPis: String): String; Inline;
  function fRetDesAbfCof(strAbfCof: String): String; Inline;
  function fRetDesCstPis(strCstPis: String): String; Inline;
  function fRetDesCstCof(strCstPis: String): String; Inline;
  function fValidaEcf(strCodEcf: String; var strModelo: String): Boolean;
  function fRetMesExtenso(intMes: Integer): String;
  function fRetDesAbfIcm(strCodAbf: String): String;
  function fDigEmail(var strDestinatario, strEmailDestinatario: String): Boolean; inline;
  function fRetPreComMenosDescForn(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet = Nil;
    strCALSOP: String = ''): Double; Inline;
  function fRetNomLocFisica(const strCodLoc: String): String; inline;
  function fRetNumLoteConsulta(const strNumLot: String): String;inline;
  function fGetTCadLot(Owner: TComponent; qryCadTab: TUniQuery = Nil): ICadLot; Inline;
  function fGetTFiltrosRelatorio: IFiltrosRelatorio;Inline;
  function fRetConsumidorDocumento(strNumDoc, strEspDoc, strCodEmp: String): String; Inline;
  function fRetGrupoItem(strCodIte: String): String; Inline;
  function fRetornaCndPag(arrDatas: TDateArray; dtaDtaBas: TDateTime): String; Overload;Inline;
  function fRetornaCndPag(const arrDuplicata: TarrDuplicata; dtaDtaBas: TDateTime): String; Overload;Inline;
  function fRetSomenteNumeros(strTexto: String): String;Inline;
  function fRetNomeSoGrupo(strCodigo: String): String; Inline;
  function fRetLitros(strCodIte: String): Double;
  function fRetNomProdutoAcabado(strCodIte, strCodEmp: String; strCodEmpAca: String = ''): String; Inline;
  function fRetNomTabelaDinamica(strCodTab: String): String;Inline;
  function fSQLParam(edtValor: TCustomEdit; strNomCam: String; strNomPar: String = ''; blnLike: Boolean = False): String;Inline;
  function fSQLParamPerido(mskDtaIni: TMaskEditFocus; strNomCam: String;
                           strParIni: String = 'DTAINI';
                           strParFin: String = 'DTAFIN'): String; Inline;
  function fRetNomeArmazem(Const strCodAmz: String): String; Inline;
  function fRetCodFornecedorTabelaPreco(strTabPre: String): String; Inline;
  function fRetNomeTabelaPreco(strCodTab: String): String; Inline;
  function fCheckParent(Sender, Parent: TWinControl): Boolean; Inline;
  function fGetConfiguracao : IConfiguracao; Inline;
  function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): Double;Inline;
  function fRetNomTabelaPreco(strCodTab: String): String; Inline;
  function fCalculaPrecoCompraLiq(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
                                  fltDesf04, fltDesf05, fltDesf06: Double;
                                  blnPreDol: Boolean = False): Double; overload;Inline
  function fCalculaPrecoCompraLiq(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet): Double; overload;Inline
  function fValidaMesAno(mskMesAno: TMaskEditFocus; strInfErr: String): Boolean; Overload; Inline;
  function fValidaMesAno(mskMesAno: String; strInfErr: String): Boolean; Overload; Inline;
  function fRetTipoDepartamento(strCodigo, strTipo: String): String;Inline;

  function fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean): String;  Inline;
  function fSQLCamposQuantidadePendenteCompra(blnSoma, blnFiltraTE, blnLibPcm: Boolean; strAliasSALPDC: String): String; Inline;
  function fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean): String; Inline;

  function fRetTipoImpressora(var strTipImp: String): Boolean; Inline;
  function fAcertaMaskTel(strFone: String): String; Inline;
  function fEnviarEMailComAnexo(const Para, Assunto, Texto, Arquivo: String): Integer; Inline;
  function fEnviarEmail(strTitulo, strArquivo, strDestinatario: String): Boolean; inline;
  function fDesconsiderarNaQtdLimDaPromoItensUnitarMaior: Boolean; Inline;

  function fPesqArmazem(Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtDescri: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True): Boolean;
  function fPesqTabDinamica(Self     : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True): Boolean;
  function fPesqClaIPI(Self      : TForm;
                       edtClaIPI : TCustomEdit;
                       qryConIPI : TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim : Boolean = True;
                       strTitulo : String  = 'Consulta de Classificação de IPI'): Boolean;
  function fPesqCores(Self      : TForm;
                      edtCodigo : TCustomEdit;
                      edtDescri : TEditFocus;
                      qryTabela : TUniQuery;
                      Var chrKey: Char;
                      Var arrSel: TConsultasArray;
                      blnConSim : Boolean = True;
                      strCodGra : String = ''): Boolean;
  function fPesqCanalAcesso(Self      : TForm;
                            edtCodigo : TCustomEdit;
                            edtDescri : TEditFocus;
                            qryTabela : TUniQuery;
                            var chrKey: Char;
                            var arrSel: TConsultasArray;
                            blnConSim : Boolean): Boolean;
  function fPesqAbrevFiscal(Self     : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True): Boolean; inline;
  function fPesqConfiguracaoRel(opcTipCfg : TTipoConsultaSimples;
                                Self      : TForm;
                                edtCodigo : TCustomEdit;
                                edtDesPor : TEditFocus;
                                qryTabela : TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                strWhere  : String;
                                blnConSim : Boolean = True;
                                strTitulo : String = 'Configuração de Relatórios'): Boolean; inline;
  function fPesqGrupo(Self     : TForm;
                      edtCodigo: TCustomEdit;
                      edtDescri: TEditFocus;
                      qryTabela: TUniQuery;
                      Var chrKey: Char;
                      Var arrSel: TConsultasArray;
                      blnConSim: Boolean = True;
                      blnDesRes: Boolean = False): Boolean; inline;
  function fPesqItem(opcTipIte: TTipoConsultaItem;
                     Self     : TForm;
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
                     blnSomenteEstrutura: Boolean = False): Boolean; inline;
  function fPesqSituacaoProduto(Self     : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                blnConSim: Boolean = True): Boolean; inline;
  function fPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
                           Self     : TForm;
                           edtCodigo: TCustomEdit;
                           edtNomEmp: TCustomEdit;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True): Boolean; inline;

  function fPesqOperador(Self     : TForm;                             {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                               {* Edit do Código                                            *}
                         edtDescri: TEditFocus;                                {* Edit da Descrição                                         *}
                         qryTabela: TUniQuery;                                 {* Query                                                     *}
                         Var chrKey: Char;                                     {* Key                                                       *}
                         Var arrSel: TConsultasArray;                          {* Array de Seleção                                          *}
                         blnConSim: Boolean = True;                            {* Consulta Simples ou Múltipla (multi select)               *}
                         blnAtivos: Boolean = False;                           {* Somente Operadores Ativos                                 *}
                         blnGerentes: Boolean = False;                         {* Somente Operadores Gerentes                               *}
                         blnMecanicos: Boolean = False;                        {* Somente Operadores Mecânicos                              *}
                         blnVenRepre: Boolean = False;                         {* Somente Vendedor Interno/Representante Externo            *}
                         blnCompradores: Boolean = False;                      {* Somente Compradores                                       *}
                         blnAdministrativo: Boolean = False;                   {* Somente Operadores Administrativos                        *}
                         blnSubGerentes: Boolean = False;
                         blnVendedorEmpLog: Boolean = False;                   {* Somente vendedor da empresa logada                        *}
                         blnPermissaoTransferencia: Boolean = False): Boolean; {* Somente Operadores com permissão de receber transferencia *}

  function fPesqMarcas(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True): Boolean; inline;
  function fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                        Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtNomEmp: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True;
                        blnResEmp: Boolean = False;
                        strEmpresas: String  = '';
                        blnAceCtr: Boolean = False;
                        strAceCtr: String = ''): Boolean;  inline;
  function fPesqCliente(opcTipCli: TTipoConsultaCliente;
                        Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtNomCli: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True;
                        objFrmPnl: TPanelCx = Nil;
                        blnTablet: Boolean = False;
                        strCodRep: String = ''): Boolean; inline;
  function fPesqSubRegiao(Self     : TForm;
                          edtCodigo: TCustomEdit;
                          edtDescri: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True): Boolean; inline;
  function fPesqRedeLojas(Self     : TForm;
                          edtCodigo: TCustomEdit;
                          edtDescri: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True): Boolean; inline;
  function fPesqRegiao(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True): Boolean; inline;
  function fPesqUnidade(Self      : TForm;
                        edtCodigo : TCustomEdit;
                        edtUnidade: TEditFocus;
                        edtSigla  : TEditFocus;
                        qryTabela : TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim : Boolean = True;
                        blnPesqSigla : Boolean = False): Boolean; inline;
  function fPesqGrupoProduto(Self         : TForm;
                             edtCodigo    : TCustomEdit;
                             edtDescricao : TEditFocus;
                             qryTabela    : TUniQuery;
                             Var chrKey   : Char;
                             Var arrSel   : TConsultasArray;
                             blnConSim    : Boolean = True): Boolean; inline;
  function fPesqTipoServico(Self     : TForm;                          {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                            edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                      {* Query                                       *}
                            Var chrKey: Char;                          {* Key                                         *}
                            Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;inline;{* Consulta Simples ou Múltipla (multi select) *}
  function fPesqAtividade(Self     : TForm;
                          edtCodigo: TCustomEdit;
                          edtDescri: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True): Boolean; inline;
  function fPesqDepartamento(Self     : TForm;
                             edtCodigo: TCustomEdit;
                             edtDescri: TEditFocus;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean; inline;
  function fPesqCidade(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtCidade: TEditFocus;
                       edtEstado: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True): Boolean; inline;
  function fPesqGrupoOperador(Self     : TForm;
                              edtCodigo: TCustomEdit;
                              edtDescri: TEditFocus;
                              qryTabela: TUniQuery;
                              Var chrKey: Char;
                              Var arrSel: TConsultasArray;
                              blnConSim: Boolean = True): Boolean; inline;
  function fPesqCondicoesPgto(Self     : TForm;
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
                              blnFaturamento: Boolean = False): Boolean; inline;
  function fPesqDiversos(Self        : TForm;
                         edtCodigo   : TCustomEdit;
                         edtDescri   : TEditFocus;
                         qryTabela   : TUniQuery;
                         Var chrKey  : Char;
                         Var arrSel  : TConsultasArray;
                         blnConSim   : Boolean = True;
                         blnVerStatus: Boolean = False;
                         blnVerEmpAce: Boolean = False;
                         strCodCli   : String  = ''): Boolean; inline;
  function fPesqParceiro(Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean; inline;
  function fPesqConsumidores(Self      : TForm;
                             edtCodCon : TDBEditFocus;
                             edtDesCon : TDBEditFocus;
                             edtCgcCpf : TEditFocus;
                             mskNumCgc : TMaskEditFocus;
                             qryTabela : TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             strCodCli : String  = '';
                             blnConSim : Boolean = True): Boolean; inline;
  function fPesqVeiculos(Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True;
                         blnComMsk: Boolean = True;
                         strFiltro: String = ''): Boolean; inline;
  function fStrLocateLinGru(objCodigo: TObject;
                            arrLinha: TConsultasArray;
                            strNomCampo,
                            strNomPar: String;
                            blnSemAND: Boolean = False;
                            blnNegar: Boolean = False;
                            strCodigo: String = '';
                            blnAndFinal: Boolean = False): String; inline;
  function fPesqPortador(opcTipPor: TTipoConsultaSimples;
                         Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDesPor: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True;
                         strTitulo: String = 'Consulta de Portadores';
                         strBolFat: String = '';
                         blnSalPor: Boolean = False): Boolean; inline;
  function fPesqOcorrencia(Self     : TForm;
                           edtCodigo: TCustomEdit;
                           edtDescri: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True): Boolean; inline;

  function fPesqFaseObra(Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean; inline;

  function fPesqServicos(Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True;
                         blnAutCen: Boolean = False): Boolean; inline;
  function fPesqTransportadora(opcConTra: TTipoConsultaTransportad;
                               Self     : TForm;
                               edtCodigo: TCustomEdit;
                               edtNomTra: TEditFocus;
                               qryTabela: TUniQuery;
                               Var chrKey: Char;
                               Var arrSel: TConsultasArray;
                               blnConSim: Boolean = True;
                               strCidCli: String = ''): Boolean; inline;
  function fPesqFormaPgto(opcTipPgt: TTipoConsultaFormaPagto;
                          Self     : TForm;
                          edtCodigo: TCustomEdit;
                          edtDescri: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True;
                          blnTablet: Boolean = False): Boolean; inline;
  function fPesqCampanha(Self       : TForm;
                         edtCodCam  : TCustomEdit;
                         edtDesCam  : TEditFocus;
                         qryConCam  : TUniQuery;
                         Var chrKey : Char;
                         Var arrSel : TConsultasArray;
                         blnConSim  : Boolean = True;
                         strTitulo  : String = 'Consulta de Campanhas'): Boolean; inline;
  function fPesqMotorista(Self     : TForm;
                          edtCodigo: TCustomEdit;
                          edtDescri: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True;
                          blnAtivos: Boolean = False): Boolean; inline;
  function fPesqEntrga(Self      : TForm;
                       edtNumEnt : TCustomEdit;
                       qryConEnt : TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSimp: Boolean = True;
                       strTitulo : String = 'Consulta de Entregas'): Boolean; inline;
  function fPesqCentroCusto(Self     : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True;
                            blnUsaCtf: Boolean = False;
                            strCodFor: String  = ''): Boolean; inline;
  function fPesqMotVendasPerdidas(Self     : TForm;
                                  edtCodigo: TCustomEdit;
                                  edtDescri: TEditFocus;
                                  qryTabela: TUniQuery;
                                  Var chrKey: Char;
                                  Var arrSel: TConsultasArray;
                                  blnConSim: Boolean = True): Boolean; inline;
  function fPesqGrupoCompra(Self     : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True): Boolean; inline;
  function fPesqPromocoes(Self      : TForm;
                          edtCodPro : TEditFocus;
                          edtDesPro : TEditFocus;
                          qryTabela : TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim : Boolean = True): Boolean; inline;
  function fPesqGrupoAtividade(Self     : TForm;
                               edtCodigo: TCustomEdit;
                               edtDescri: TEditFocus;
                               qryTabela: TUniQuery;
                               Var chrKey: Char;
                               Var arrSel: TConsultasArray;
                               blnConSim: Boolean = True): Boolean; inline;
  function fPesqEventos(Self      : TForm;
                        edtCodigo : TCustomEdit;
                        edtDescri : TEditFocus;
                        qryTabela : TUniQuery;
                        var chrKey: Char;
                        var arrSel: TConsultasArray;
                        blnConSim: Boolean = True): Boolean; inline;
  function fPesqPedOrc(opcTipCon: TTipoConsultaPedidoVenda;
                       Self     : TForm;
                       strEspDoc: String;
                       strOpcDoc: String;
                       strCodEmp: String;
                       edtNumDoc: TCustomEdit;
                       edtEspDoc: TEditFocus;
                       edtCodEmp: TEditFocus;
                       Var qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True;
                       objFrmPnl: TPanelCx = Nil;
                       strCliCrm: String = '';
                       strOriF11: String = 'N'): Boolean; inline;
  function fPesqTipoAtendimento(Self    : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                blnConSim: Boolean = True): Boolean; inline;
  function fPesqSetFlz(Self       : TForm;
                       edtCodigo  : TCustomEdit;
                       edtDescri  : TEditFocus;
                       qryTabela  : TUniQuery;
                       Var chrKey : Char;
                       Var arrSel : TConsultasArray;
                       blnConSim  : Boolean = True): Boolean; InLine;
  function fPesqTipoCliente(Self       : TForm;
                            edtCodigo  : TCustomEdit;
                            edtDescri  : TEditFocus;
                            qryTabela  : TUniQuery;
                            var chrKey : Char;
                            var arrSel : TConsultasArray;
                            blnConSim  : Boolean): Boolean; InLine;
  function fPesqCofSai(Self      : TForm;                                     {* Formulário                                  *}
                       edtCodigo : TCustomEdit;                               {* Edit do Código                              *}
                       edtDescri : TEditFocus;
                       qryConGen : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                      {* Key                                         *}
                       Var arrSel: TConsultasArray;                           {* Array de Consulta                           *}
                       blnConSim : Boolean = True;                            {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consultas de Abr. Cofins'): Boolean;
  function fPesqPisSai(Self      : TForm;                                     {* Formulário                                  *}
                       edtCodigo : TCustomEdit;                               {* Edit do Código                              *}
                       edtDescri : TEditFocus;
                       qryConGen : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                      {* Key                                         *}
                       Var arrSel: TConsultasArray;                           {* Array de Consulta                           *}
                       blnConSim : Boolean = True;                            {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consultas de Abr. Pis'): Boolean;
  function fPesqCstPis(Self      : TForm;                                     {* Formulário                                  *}
                       edtCodigo : TCustomEdit;                               {* Edit do Código                              *}
                       edtDescri : TEditFocus;
                       qryConGen : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                      {* Key                                         *}
                       Var arrSel: TConsultasArray;                           {* Array de Consulta                           *}
                       blnConSim : Boolean = True;                            {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consultas de CST de Pis'): Boolean;
  function fPesqCstCof(Self      : TForm;                                     {* Formulário                                  *}
                       edtCodigo : TCustomEdit;                               {* Edit do Código                              *}
                       edtDescri : TEditFocus;
                       qryConGen : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                      {* Key                                         *}
                       Var arrSel: TConsultasArray;                           {* Array de Consulta                           *}
                       blnConSim : Boolean = True;                            {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consultas de CST de Cofins'): Boolean;
  function fPesqCfgSis(Self      : TForm;
                       edtCodCfg : TCustomEdit;
                       edtDesCfg : TEditFocus;
                       qryConCfg : TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim : Boolean = True;
                       strTitulo : String  = 'Cosulta de Configurações'): Boolean; inline;

  function fPesqCfgTin(Self      : TForm;
                       edtCodCfg : TCustomEdit;
                       edtDesCfg : TEditFocus;
                       qryConCfg : TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim : Boolean = True;
                       strTitulo : String  = 'Cosulta de Configurações da Tinta de Máquina'): Boolean; inline;

  function fPesqCartao(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True;
                       blnSoAtiv: Boolean = False;
                       blnMostraDesconto: Boolean = False;
                       blnCadCar: Boolean = False;
                       blnEmpGer: Boolean = False): Boolean; inline;

  function fPesqPesquisa(Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean; inline;
  function fPesqCartaoBandeira(Self      : TForm;
                               edtCodigo : TCustomEdit;
                               edtDescri : TEditFocus;
                               qryTabela : TUniQuery;
                               Var chrKey: Char;
                               Var arrSel: TConsultasArray;
                               blnConSim: Boolean = True): Boolean; inline;
  function fPesqCamsposLayout(Self     : TForm;
                              edtCodigo: TCustomEdit;
                              edtDescri: TEditFocus;
                              qryTabela: TUniQuery;
                              Var chrKey: Char;
                              Var arrSel: TConsultasArray;
                              strFiltro: String;
                              intPosCam: Integer = -1;
                              blnConSim: Boolean = True): Boolean; inline;
  function fPesqBanco(Self     : TForm;
                      edtCodigo: TCustomEdit;
                      edtDescri: TEditFocus;
                      qryTabela: TUniQuery;
                      Var chrKey: Char;
                      Var arrSel: TConsultasArray;
                      blnConSim: Boolean = True): Boolean; inline;
  function fPesqLayout(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       strTipImp: String;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True): Boolean; inline;
  function fPesqCFOP(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True): Boolean; Inline;
  function fPesqECF(Self       : TForm;
                    edtCodigo  : TCustomEdit;
                    edtDescri  : TEditFocus;
                    qryTabela  : TUniQuery;
                    var chrKey : Char;
                    var arrSel : TConsultasArray;
                    blnConSim  : Boolean = True): Boolean; inline;
  function fPesqLocFisica(Self       : TForm;
                          edtCodigo  : TCustomEdit;
                          edtDescri  : TEditFocus;
                          qryTabela  : TUniQuery;
                          var chrKey : Char;
                          var arrSel : TConsultasArray;
                          blnConSim  : Boolean = true): Boolean; inline;
  function fPesqLoteItens(Self       : TForm;
                          edtNumLote : TEditFocus;
                          edtCodIte  : TEditFocus;
                          intDecUni  : Integer;
                          qryTabela  : TUniQuery;
                          Var chrKey : Char;
                          Var arrSel : TConsultasArray;
                          blnConSim  : Boolean = True): Boolean; inline;
  function fPesqPedidoCompra(Self       : TForm;
                             edtCodPed  : TCustomEdit;
                             qryTabela  : TUniQuery;
                             Var chrKey : Char;
                             Var arrSel : TConsultasArray;
                             Var strDoc : String;
                             strCodEmp  : String;
                             intIndice  : Integer;
                             blnConSim  : Boolean = True;
                             objFrmPnl  : TPanelCx = Nil;
                             strLitGal  : String = '3.600';
                             strTitulo  : String = 'Consulta de Pedidos de Compra'): Boolean; inline;
  function fPesqAjuste(Self      : TForm;
                       edtNumAju : TCustomEdit;
                       qryConAju : TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       strCodEmp : String;
                       blnConSim : Boolean = True;
                       strTitulo : String = 'Consulta de Ajustes de Estoque'): Boolean; inline;
  function fPesqProdAcabado(Self      : TForm;
                            edtCodAca : TCustomEdit;
                            edtDesAca : TEditFocus;
                            qryConAca : TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            strEmpAca : String;
                            blnConSim : Boolean = True;
                            strTitulo : String  = 'Consulta de Produtos Acabados';
                            strEmpEst : String = ''): Boolean; inline;
  function fPesqTabelaPreco(Self     : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True): Boolean; inline;
  function fPesqEntregasRotasRegiao(Self      : TForm;                            {* Formulário                                  *}
                                    edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                    edtDescri : TEditFocus;                       {* Edit da Cidade                              *}
                                    qryTabela : TUniQuery;                        {* Query                                       *}
                                    Var chrKey: Char;                             {* Key                                         *}
                                    Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                    blnConSim : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                                    strCodCid : String = '';                      {* Cidade do endereco de entrega               *}
                                    strCliCep : String = '';                      {* Cep do endereco de entrega                  *}
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

  function fGetStrCodigos(edtCodigo: TEditFocus; arrLinha: TConsultasArray; blnQuoted: Boolean = False): String; inline;
  function fMostrarFatorConversaoMadeira(strCodIte: string): boolean;Inline;

  procedure pDestroiModulo(var NomeForm);
  procedure pCriarForm(ClasseForm: TFormClass; NomeForm: TForm); inline;
  procedure pCriarFormularios(Classe: TComponentClass; Var frmForm); inline;
  procedure pFreeAndNil(var frmForm); inline;
  procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = ''); inline;
  procedure pIniciaLogLeak(intDebugH: Byte; strArquivo: String); inline;
  procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm: TDataModule); inline;
  procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
  procedure pValidaProCod(strNomeTabela: String); inline;
  procedure pEnabled(NomeForm: TForm; Habilitar: Boolean); inline;
  procedure pSetButton(NomeTabela: TDataSet;
                       btnNovo,
                       btnConfirma,
                       btnExclui,
                       btnCancela,
                       btnEditar,
                       btnLocalizar,
                       btnSair: TBitBtnLocked); inline;
  procedure pAjudaAutcom(Handle: THandle; intNumHlp: Integer); inline;
  procedure pGravarErro(GravarErro: Boolean; MensagemErro: String); inline;
  procedure pCarregaConfImprRel(Const strNomeForm : String;
                                  Var strNomImp: String;
                                  Var strTipImp: String;
                                      strCodEmp: String = '';
                                      blnPreImp: Boolean = False); inline;
  procedure pCarregaConfImpr(Var qryCfgRel: TUniQuery;
                           Const strNomeForm : String;
                                 strCodEmp: String = '';
                                 strNomeFila : String = ''); inline;
  procedure pDesmarcaLista(edtCodigo: TCustomEdit;
                       Var arrLinha: TConsultasArray;
                           strTempTable: String = '';
                           intTamCamp: Integer = 0); inline;
  procedure pEdtCodSelectExit(edtCodigo       : TCustomEdit;
                              edtDescri       : TEditFocus;
                          Var arrLinha        : TConsultasArray;
                              fncRetNome      : TfncRetNome;
                              fncRetNomeConst : TfncRetNomeConst;
                              strMsgErr       : String;
                              intTamCamp      : integer = 0;
                              blnNegar: Boolean = False;
                              strCodigo: String  = 'Código'); inline;

  Function fArrCodigosToLista(strCodigo: String; arrCodigos: TConsultasArray; blnQuoted: Boolean = True): String; inline;

  procedure pCarregaComposicaoCusto(cbbComCus: TComboBoxFocus); inline;
  procedure pPreencheCombo(var cmb: TCustomComboBox; arr: Array of String; blnLimpa: Boolean = True);
  procedure pSetaParam(strText: String; arrLinha: TConsultasArray; Var strLinha: String; strNomPar: String; qryRelatorio: TUniQuery); Overload; inline;
  procedure pSetaParam(edtValor:TEditFocus; strNomPar: String; qryRelatorio: TUniQuery; blnLike: Boolean = False); overload; inline;
  procedure pSetaParamOR(objCodigo: TObject; arrLinha: TConsultasArray; strNomPar: String; qryRelatorio: TUniQuery); inline;
  procedure pCriaTabelaDel(strNomTab: String); inline;
  procedure pSetaClient(cdsClient: TDataSet); inline;
  procedure pSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; qryResult: TUniQuery); inline;
  procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll); inline;
  procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False); inline;
  procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False); inline;
  procedure pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String); inline;
  procedure pMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0); inline;
  procedure pDropTable(strTempTable: String); inline;
  procedure pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery); inline;
  procedure pPesquisaCadAti(qryTabOri, qryTabela: TUniQuery; strCodAti: String); inline;
  procedure pPesquisaAbfIcm(qryTabOri, qryTabela: TUniQuery; strCodAbf: String; strEstado: String = '');inline;
  procedure pExecArquivo(strArquivo: String; Handle: THandle);inline;
  procedure pPesquisaCadPor(qryTabOri, qryTabela: TUniQuery; strCodPor: String); inline;
  procedure pCarrega(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray); inline;
  procedure pPesquisaCadCli(qryTabOri, qryTabela: TUniQuery;
                              strCodCli: String;
                              blnVerCnd: Boolean = True;
                              blnVerCli: Boolean = False); inline;
  procedure pZeraDigDuplic(var arrDuplicata: TarrDuplicata); inline;
  procedure pAdicionaCheques(qryCadChq: TDataSet; cdsCadChq: TUniClientDataSet); inline;
  procedure pCnfEtiqueta(tipTipEti: TTiposEtiqueta = etiVazio); inline;
  procedure pSetaParamPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus; qryRelatorio: TUniQuery;
                              strParIni: String = 'DTAINI';
                              strParFin: String = 'DTAFIN'); Inline;
  procedure pRetDadosItem(strCodIte, strGrupo: String; Var strNome, strRefere,
    strMarca, strUnidad: String); Overload;Inline;
  procedure pRetDadosItem(strCodIte: String; Var strNome, strRefere,
    strMarca, strUnidad: String); Overload; Inline;
  procedure pCalcSaldoInicialItens(Var fltSaldoIni: Double;
                                       dtaDtaBal,
                                       dtaDtaIni: TDateTime;
                                       strCodIte: String;
                                       strCodEmp: String;
                                       blnEntFut: Boolean = True;
                                       strNumLot: String = ''); Inline;
  procedure pUltimaCompra(strCodIte, strCodEmp, strAnoMes: String; chrOpcInv: Char;
    var dtaUltComp: TDate; var strNumDoc: String);Inline;
  procedure pAtuVarGlobaisSimples; Inline;
  procedure pRetListaMesAno(stlLista : TStrings ; intQtdReg : Integer = 24; blnLimpaLista : Boolean = True); Inline;
  procedure pCarregaTabPre(cbxTabPre: TComboBox); overload;
  procedure pCarregaTabPre(cbxTabPre: TDBComboBoxFocus); overload;
  procedure pRetFilasImpressao(Var arrFilas: TarrFilas);
  procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport); overload;
  procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TRLReport); overload;
  procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport); overload;
  procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TRLReport; ASetup: TRLPreviewSetup); overload;
  function fClienteTemCndPagAssociado(strCodCli: String): Boolean;
  function fEhPedidoRefenciadoHaUmOrcamento(strNumDoc, strCodEmp: String;
                                            Var strNumOrcRef: String; Var strEmpOrcRef: String): Boolean;

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
  function fIsValidDate(Sender: TWinControl): Boolean; Overload;
  function fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;
  function fRetornaAliquotaIcmsInternaDoEstado(strEstado: String): Double;
  function fRetDesMotivoAtend(strCodMot: String): String;
  function fPesqMotivosAtend(Self     : TForm;
                             edtCodigo: TCustomEdit;
                             edtDescri: TEditFocus;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;
  function fNow: TDateTime;

  function fCarregaCartoesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
  function fCarregaChequesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
  function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
  function fUsaSat(strCodEmp : String = ''):Boolean;
  function fEhFeriado(dtaData: TDateTime; strCodCid: String = ''): Boolean;
  function fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal,
             fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double): Double;
  function fRetornaSaldoDisponivel(strCodIte: String; blnCnvMl : Boolean = False;
                                   blnFaturamento: Boolean = True; strNumLot : String = '';
                                   blnConsiderarPedidos : Boolean = True;
                                   strCodEmp: String = ''; strNumPedAlt: String = '';
                                   blnConsiderarPedidoCompraPendente: Boolean = False;
                                   blnConsiderarCfgCalSal: Boolean = True;
                                   blnConsiderarOrdemProducao: Boolean = True): Double;
  procedure pRemoveAcentoObjRelFortes(Var obj: TForm);
  function fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada: String; 
                                                            arrAlias: TParamArrayString=NIL;
                                                            arrMacroParaCadaItemDoarrAlias: TParamArrayString=NIL;
                                                            arrApenasAsEspecies: TParamArrayString=NIL; 
                                                            strPrefixo: String='DET_';
                                                            strOperacaoSeSomenteValor: String=''): String;
  function fRetornaInfMedVIDRO(blnDoisPontos: Boolean = False; blnAbreviadoComprimento: Boolean = False;blnMaximo : Boolean = False; blnMensagem :Boolean = False;blnAbreviadoAltura : Boolean = False) : String;
  function fFormataCasaDecimalVIDRO(strMascaraDefault : Variant) : Variant;
  function fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
  function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
  function fReservaParametros: IReservaParametros;
  function fSaldoReservado(AParams: IReservaParametros): ISaldoReservado;
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
  function fGetSQLSomaCamposEntregaFutura(const AAlias: String = 'G';
                                          AFaturamento: Boolean = False;
                                          ALote: Boolean = False): String;
  function fEmpresaTemAcessoPortador(strCodPor: String; strCodEmp: String = ''): Boolean;
  Procedure pSetaCodIte(edtCodIte: TEditFocus); overload; inline;
  Procedure pSetaCodIte(edtCodIte: TStringField); overload; inline;
  function fTamCodIte: Integer; inline;

  Var
    VS_Date                  : TDateTime;
    utcRegistros             : IUltConsultas;
    strLoginUsuarioLogado    : String;
    strDescriUsuarioLogado   : String;
    strEmpAcessoUsuarioLogado: String;
    VS_strCodEmp             : String;
    VS_strUsaTmq             : string;
    VS_strTitLot             : String;
    VS_strTitLts             : String;
    VS_strClaVen             : String;
    VS_strClaDev             : String;
    VS_strClaCom             : String;
    VS_strTabPrc             : String;
    VS_strCliFil             : String;
    VS_strCla_UC             : String;
    objFuncoes               : IFuncoes;
    strPortadoresOperador    : String;
    arrProCod                : TArrProCod;
    arrFilas                 : TArrFilas;
    VS_objTraceViewer        : ITraceViewer;
    objTrace                 : ISQLTrace;

implementation

{ FuncoesFactory }

uses untModulo, untCfgRel;

function fCriaClientDataSetClientesDebitos: TUniClientDataSet;
begin
  Result := objFuncoes.fCriaClientDataSetClientesDebitos;
end;

function fEhEstadoRegraZonaFranca(strEstado: String): Boolean;
begin
  Result := objFuncoes.fEhEstadoRegraZonaFranca(strEstado);
end;

function fTamDocCadRec: Integer;
begin
  Result := objFuncoes.fTamDocCadRec;
end;

function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
Begin
  Result := objFuncoes.fEmptyStr(strString, blnTiraCaracEspecial);
End;

function fTiraCaracEspeciais(strTexto      : String;
                                 blnUsaLista   : Boolean = True;
                                 blnTiraEspacos: Boolean = False;
                                 blnTiraPontos : Boolean = False;
                                 blnTiraDoisPts: Boolean = False;
                                 blnTiraTab    : Boolean = False;
                                 blnTiraVirgula: Boolean = True): String;
Begin
  Result := objFuncoes.fTiraCaracEspeciais(strTexto, blnUsaLista,blnTiraEspacos,
                                           blnTiraPontos, blnTiraDoisPts, blnTiraTab, blnTiraVirgula);
End;

function fTiraCaracEspeciaisPonto(strTexto: String): String;
Begin
  Result := objFuncoes.fTiraCaracEspeciaisPonto(strTexto);
End;

function fRetNomeEmpresaSelec(Const strCodEmpresa: String): String;
begin
  Result := objFuncoes.fRetNomeEmpresaSelec(strCodEmpresa);
end;

function fRetNomVendRep(strCodVen: String): String; Overload;
begin
  Result := objFuncoes.fRetNomVendRep(strCodVen);
end;

function fRetNomVendRep(strCodVen: String; strCodEmp: String): String; Overload;
begin
  Result := objFuncoes.fRetNomVendRep(strCodVen, strCodEmp);
end;

function fRetNomCliente(Const strCodCli: String): String;
begin
  Result := objFuncoes.fRetNomCliente(strCodCli);
end;

function fRetNomeRedeLoja(Const strCodRed: String): String;
begin
  Result := objFuncoes.fRetNomeRedeLoja(strCodRed);
end;

function fRetNomeRede: String;
begin
  Result := objFuncoes.fRetNomeRede;
end;

function GetComputerNetName: String;
begin
  Result := objFuncoes.GetComputerNetName;
end;

function GetIPAddress: Integer;
begin
  Result := objFuncoes.GetIPAddress;
end;

function GetIPAddressAsString: String;
begin
  Result := objFuncoes.GetIPAddressAsString;
end;

function GetMacAddress: String;
begin
  Result := objFuncoes.GetMacAddress;
end;

function GetUserFromWindows: String;
begin
  Result := objFuncoes.GetUserFromWindows;
end;

function fRetLocSep(Const strCodLse: String): String;
begin
  Result := objFuncoes.fRetLocSep(strCodLse);
end;

function fRetNomeEmpresa: String; overload;
begin
  Result := objFuncoes.fRetNomeEmpresa;
end;

function fRetNomeEmpresa(strCodEmp: String): String; overload;
begin
  Result := objFuncoes.fRetNomeEmpresa(strCodEmp)
end;

Function fMensagem(strTitulo: String;
                   strTexto: String;
                   arrOpcoes: Array Of String;
                   intFocoBotao: Integer = 1;
                   blnSaiComEsc: Boolean = False;
                   intEstFon: Integer = 1;
                   intWidBut: Integer = 0;
                   blnAutosize: Boolean = False;
                   intSomarTop: Integer=0;
                   blnObrigaEsc: Boolean = False;
                   blnOcultPainelBtn: Boolean = False;
                   blnBtnSemImg : Boolean = False;
                   intHeightOpc: Integer = 0;
                   intFormWidth : Integer = 0;
                   intQtdLinha: Integer = -1;
                   pProcedureAjuda: TProcedureAjuda = nil): Integer;
begin
  Result := objFuncoes.fMensagem(strTitulo, strTexto, arrOpcoes, intFocoBotao, blnSaiComEsc,
                                 intEstFon, intWidBut, blnAutosize, intSomarTop, blnObrigaEsc,
                                 blnOcultPainelBtn, blnBtnSemImg, intHeightOpc, intFormWidth,
                                 intQtdLinha, pProcedureAjuda);
end;

function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
begin
  Result := objFuncoes.fExecutarModal(prcGen, strTexto, strChave);
end;

function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
Begin
  //Result := objFuncoes.fCriaQuery(AOwner, Conexao);
  Result := TUniQuery.Create(AOwner);

  If Assigned(Conexao) Then
    Result.Connection := Conexao
  Else
    Result.Connection := frmModulo.GetCurrentConnection;

  Result.Tag := Result.Connection.Tag;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.SetQueryEvents(Result);

  Result.Options.RequiredFields := False;
End;

procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
Begin
  objFuncoes.pCriarFormularios(Classe, frmForm);
End;

procedure pFreeAndNil(var frmForm);
Begin
  objFuncoes.pFreeAndNil(frmForm);
End;

procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');
Begin
  objFuncoes.pMensagensErro(MensErro, LocalErro, strMensagem);
End;

function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
Begin
  Result := objFuncoes.fClienteConsumidor(strNomCli, blnCliBal, blnSeguradora);
End;

procedure pIniciaLogLeak(intDebugH: Byte; strArquivo: String);
Begin
  objFuncoes.pIniciaLogLeak(intDebugH, strArquivo);
End;

procedure pCriarForm(ClasseForm: TFormClass; NomeForm: TForm);
Begin
  objFuncoes.pCriarForm(ClasseForm, NomeForm);
End;

function fRetornaInGrupo(strCodGpo: String; arrGrupos: TConsultasArray; strCampo: String=''): String;
Begin
  Result := objFuncoes.fRetornaInGrupo(strCodGpo, arrGrupos, strCampo);
End;

procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm: TDataModule);
Begin
  objFuncoes.pCriarModulo(ClasseModulo, NomeForm);
End;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
Begin
  Result := objFuncoes.fTransform(strConteudo, intStep, strChar);
End;

function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
Begin
  Result := objFuncoes.fCfgSis(strCamCfg, varTipVar, strCodEmp);
End;

function fRelSomarReformaAoValorContabil: Boolean;
Begin
  Result := objFuncoes.fSomarNovosImpostosDaReformaAoValorContabil;
End;

function fRelSqlValorReformaFdoRef(const AAutoincrementoFatDor: String): String;
Begin
  Result := objFuncoes.fSqlValorReformaFdoRef(AAutoincrementoFatDor);
End;

function fRetClientesFilial: String;
Begin
  Result := objFuncoes.fRetClientesFilial;
End;

procedure pDestroiModulo(var NomeForm);
Begin
  objFuncoes.pDestroiModulo(NomeForm);
End;

procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
Begin
  If Form = nil Then
    Form := GetParentForm(SenderUnico);
  objFuncoes.pSetFocus(SenderUnico, Form);
End;

function fEmptyDate(strDate: String): Boolean;
Begin
  Result := objFuncoes.fEmptyDate(strDate);
End;

function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
Begin
  Result := objFuncoes.fPadL(strTexto, intTamanho, strCaracter);
End;

function fIsNumber(Const strNumber: String): Boolean;
Begin
  Result := objFuncoes.fIsNumber(strNumber);
End;

procedure pValidaProCod(strNomeTabela: String);
Begin
  objFuncoes.pValidaProCod(strNomeTabela);
End;

function fAbrirTabela(NomeTabela: TDataSet): Boolean;
Begin
  Result := objFuncoes.fAbrirTabela(NomeTabela);
End;

procedure pEnabled(NomeForm: TForm; Habilitar: Boolean);
Begin
  objFuncoes.pEnabled(NomeForm, Habilitar);
End;

function fUsaProCodigo(strNomeTabela: String): Boolean;
Begin
  Result := objFuncoes.fUsaProCodigo(strNomeTabela);
End;

procedure pSetButton(NomeTabela: TDataSet; btnNovo, btnConfirma, btnExclui,
  btnCancela, btnEditar, btnLocalizar, btnSair: TBitBtnLocked);
Begin
  objFuncoes.pSetButton(NomeTabela, btnNovo, btnConfirma, btnExclui, btnCancela,
    btnEditar, btnLocalizar, btnSair);
End;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
Begin
  Result := objFuncoes.fRetAutoIncrem(strNomeTabela, strCodEmp, intIntervalo);
End;

function fVerificaIntegridade(strNomFrm, strTabela: String; qryTabOriginal: TDataSet;
  blnGravar: Boolean = True; blnSoCriaTabela: Boolean = False; strMotDel: String = '';
  strOpeDel: String = ''; blnTabAux: Boolean = False): String;
Begin
  Result := objFuncoes.fVerificaIntegridade(strNomFrm, strTabela, qryTabOriginal,
    blnGravar, blnSoCriaTabela, strMotDel, strOpeDel, blnTabAux);
End;

function fInTransaction(objConexao: TUniConnection = Nil): Boolean;
begin
  Result := objFuncoes.fInTransaction(objConexao);
end;

function fStartTransaction: Boolean;
Begin
  Result := objFuncoes.fStartTransaction;
End;

function fRollBack: Boolean;
Begin
  Result := objFuncoes.fRollBack;
End;

function fCommit: Boolean;
Begin
  Result := objFuncoes.fCommit;
End;

function fValidarDirEspecificos(Var strDireitos: String; strLogin, strNomeForm: String): Boolean;
Begin
  Result := objFuncoes.fValidarDirEspecificos(strDireitos, strLogin, strNomeForm);
End;

function fRetTamCampo(strNomeTabela: String): Integer;
Begin
  Result := objFuncoes.fRetTamCampo(strNomeTabela);
End;

function fAtualizaProCod(strNomeTabela: String; const strCampoBusca : String): String;
Begin
  Result := objFuncoes.fAtualizaProCod(strNomeTabela, strCampoBusca);
End;

function fFecharTabela(NomeTabela: TDataSet): Boolean;
Begin
  Result := objFuncoes.fFecharTabela(NomeTabela);
End;

function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;
  Var
    intCont: Integer;
Begin
  //Result := objFuncoes.fCriarQuery(strSQL, AOwner);

  Result := fCriaQuery(AOwner);
  Result.SQL.Text := strSQL;
  Result.Open;
  Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs[intCont].CreateField(Result);
  End;
End;

function fPesqConfiguracaoRel(opcTipCfg : TTipoConsultaSimples;
                              Self      : TForm;
                              edtCodigo : TCustomEdit;
                              edtDesPor : TEditFocus;
                              qryTabela : TUniQuery;
                              Var chrKey: Char;
                              Var arrSel: TConsultasArray;
                              strWhere  : String;
                              blnConSim : Boolean = True;
                              strTitulo : String = 'Configuração de Relatórios'): Boolean;
Begin
  Result := objFuncoes.fPesqConfiguracaoRel(opcTipCfg, Self, edtCodigo, edtDesPor,
    qryTabela, chrKey, arrSel, strWhere, blnConSim, strTitulo);
End;

function fRetNomCanalAcesso(Const strCodCac: String): String;
begin
  Result := objFuncoes.fRetNomCanalAcesso(strCodCac);
end;

function fExt1(strS : String; strIdioma: String = 'P'): String;
begin
  Result := objFuncoes.fExt1(strS, strIdioma);
end;

function fExt2(strS : string; strIdioma: String = 'P'): String;
begin
  Result := objFuncoes.fExt2(strS, strIdioma);
end;

function fExt3(strS : string; strIdioma: String = 'P'): String;
begin
  Result := objFuncoes.fExt3(strS, strIdioma);
end;

function fExtDezena(strS : String; strIdioma: String = 'P'): String;
begin
  Result := objFuncoes.fExtDezena(strS, strIdioma);
end;

function FMes_Espano(dtaData: TDateTime; intTam: Integer): String;
begin
  Result := objFuncoes.FMes_Espano(dtaData, intTam);
end;

function fArqIni(ReadWrite :Integer; NomChave, NomSecao, Conteudo : String; strNomArq : String = '') : String;InLine;
begin
  Result := objFuncoes.fArqIni(ReadWrite, NomChave, NomSecao, Conteudo, strNomArq);
end;

function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;InLine;
begin
  Result := objFuncoes.fArqIniLocal(ReadWrite, NomChave, NomSecao, Conteudo, strNomArq);
end;

function fValidaCndPag(strCndPag: String; blnPerRep: Boolean = False): Boolean; overload;InLine;
begin
  Result := objFuncoes.fValidaCndPag(strCndPag, blnPerRep);
end;

function fValidaCndPag(strCndPag: String; Var strCndRet: String;
    dtaDtaBas: TDateTime; blnPerRep: Boolean = False): Boolean; overload;InLine;
begin
  Result := objFuncoes.fValidaCndPag(strCndPag, strCndRet, dtaDtaBas, blnPerRep);
end;

function fRetNomCfg(strCodCfg: String): String; InLine;
begin
  Result := objFuncoes.fRetNomCfg(strCodCfg);
end;

function fRetNomCfgTin(strCodCfg: String): String; InLine;
begin
  Result := objFuncoes.fRetNomCfgTin(strCodCfg);
end;


function fPesqCanalAcesso(Self     : TForm;
                          edtCodigo : TCustomEdit;
                          edtDescri : TEditFocus;
                          qryTabela : TUniQuery;
                          var chrKey: Char;
                          var arrSel: TConsultasArray;
                          blnConSim : Boolean): Boolean;
begin
  Result := objFuncoes.fPesqCanalAcesso(Self,
                                        edtCodigo,
                                        edtDescri,
                                        qryTabela,
                                        chrKey,
                                        arrSel,
                                        blnConSim);
end;

function fPesqAbrevFiscal(Self     : TForm;
                          edtCodigo: TCustomEdit;
                          edtDescri: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True): Boolean;
begin
  Result := objFuncoes.fPesqAbrevFiscal(Self,
                                        edtCodigo,
                                        edtDescri,
                                        qryTabela,
                                        chrKey,
                                        arrSel,
                                        blnConSim);
end;

function fStrTituloPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus): String; Inline;
begin
  Result := objFuncoes.fStrTituloPeriodo(mskDtaIni, mskDtaFin);
end;

function fStrTitulo(edtCodigo, edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo: String): String; overload;
begin
  Result := objFuncoes.fStrTitulo(edtCodigo, edtDescri, arrLinha, strLinha, strTitulo);
end;

function fItemEstrutura(strCodIte: String): Boolean; Inline;
begin
  Result := objFuncoes.fItemEstrutura(strCodIte);
end;

function fRetUnidadeItem(strCodIte: String): String; Inline;
begin
  Result := objFuncoes.fRetUnidadeItem(strCodIte);
end;

function fRetMarcaItem(strCodIte: String): String; Inline;
begin
  Result := objFuncoes.fRetMarcaItem(strCodIte);
end;

function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String; InLine;
begin
  Result := objFuncoes.fstrEspaco(Str, Tamanho, intPos);
end;

function fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String; InLine;
begin
  Result := objFuncoes.fFormataCpfCgc(strValor, FPais, strEstado);
end;

function fCon_Precos(fltPreAtu: Double; intTipPre: Integer; blnCalGua: Boolean; dtaDtaMoe: TDate; blnConGua: Boolean = False): Double; InLine;
begin
  Result := objFuncoes.fCon_Precos(fltPreAtu, intTipPre, blnCalGua, dtaDtaMoe, blnConGua);
end;

function fRetDesSfz(strCodigo: string): String; InLine;
begin
  Result := objFuncoes.fRetDesSfz(strCodigo);
end;

function fGetNumLinhasMemo(strMemo: String): Integer; InLine;
begin
  Result := objFuncoes.fGetNumLinhasMemo(strMemo);
end;

function VerImpressoraONLINE(impressora: String): Cardinal;
begin
  Result := objFuncoes.VerImpressoraONLINE(impressora);
end;

function fIdentificarNomeDaImpressora(AImpressora: String): String;
begin
  Result := objFuncoes.fIdentificarNomeDaImpressora(AImpressora);
end;

function fMostraFilas(Var strNomeFila: String; strNomFormul: String = '';
  qryCfgRel: TUniQuery = nil; blnBotoes: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fMostraFilas(strNomeFila, strNomFormul, qryCfgRel, blnBotoes);
End;

procedure pAjudaAutcom(Handle: THandle; intNumHlp: Integer);
Begin
  objFuncoes.pAjudaAutcom(Handle, intNumHlp);
End;

procedure pGravarErro(GravarErro: Boolean; MensagemErro: String);
Begin
  objFuncoes.pGravarErro(GravarErro, MensagemErro);
End;

procedure pCarregaConfImprRel(Const strNomeForm : String; Var strNomImp: String;
  Var strTipImp: String; strCodEmp: String = ''; blnPreImp: Boolean = False);
Begin
  objFuncoes.pCarregaConfImprRel(strNomeForm, strNomImp, strTipImp, strCodEmp, blnPreImp);
End;

procedure pCarregaConfImpr(Var qryCfgRel: TUniQuery; Const strNomeForm : String;
  strCodEmp: String = ''; strNomeFila : String = '');
Begin
  objFuncoes.pCarregaConfImpr(qryCfgRel, strNomeForm, strCodEmp, strNomeFila);
End;

{
function fSelecionaFilaImp(Var qryCfgRel: TUniQuery): Boolean;
Begin
  Result := objFuncoes.fSelecionaFilaImp(qryCfgRel);
End;
}

function fPreImpressao(qryCfgRel: TUniQuery; Var strNomeFila: String; Var strTipImp: String;
  blnLocal: Boolean; strDirImp: String = '' ): Boolean;
Begin
  Result := objFuncoes.fPreImpressao(qryCfgRel, strNomeFila, strTipImp, blnLocal, strDirImp);
End;

function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
Begin
  Result := objFuncoes.fFormataFloat(fltNumero, intDecimais);
End;

procedure pDesmarcaLista(edtCodigo: TCustomEdit; Var arrLinha: TConsultasArray;
  strTempTable: String = ''; intTamCamp: Integer = 0);
Begin
  objFuncoes.pDesmarcaLista(edtCodigo, arrLinha, strTempTable, intTamCamp);
End;

procedure pEdtCodSelectExit(edtCodigo       : TCustomEdit;
                            edtDescri       : TEditFocus;
                        Var arrLinha        : TConsultasArray;
                            fncRetNome      : TfncRetNome;
                            fncRetNomeConst : TfncRetNomeConst;
                            strMsgErr       : String;
                            intTamCamp      : integer = 0;
                            blnNegar: Boolean = False;
                            strCodigo: String  = 'Código');
Begin
  objFuncoes.pEdtCodSelectExit(edtCodigo, edtDescri, arrLinha, fncRetNome, fncRetNomeConst,
    strMsgErr, intTamCamp, blnNegar, strCodigo);
End;

Function fArrCodigosToLista(strCodigo: String; arrCodigos: TConsultasArray; blnQuoted: Boolean = True): String;
Begin
  Result := objFuncoes.fArrCodigosToLista(strCodigo, arrCodigos, blnQuoted);
End;

function fRetNomeLinhaGrupo(strCodigo: String): String;
Begin
  Result := objFuncoes.fRetNomeLinhaGrupo(strCodigo);
End;

function fPesqGrupo(Self     : TForm;
                    edtCodigo: TCustomEdit;
                    edtDescri: TEditFocus;
                    qryTabela: TUniQuery;
                    Var chrKey: Char;
                    Var arrSel: TConsultasArray;
                    blnConSim: Boolean = True;
                    blnDesRes: Boolean = False): Boolean;
Begin
  Result := objFuncoes.fPesqGrupo(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnDesRes);
End;

function fRetNomProduto(Const strCodIte: String): String;
Begin
  Result := objFuncoes.fRetNomProduto(strCodIte);
End;

function fRetNomSituacaoProduto(strCodSit: String): String;
begin
  Result := objFuncoes.fRetNomSituacaoProduto(strCodSit);
end;

function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TPicture): TRetornoImagem; overload;
begin
  Result := objFuncoes.fCarregaImagemLinhaGrupo(strCodGru, picImagem);
end;

function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TfrxPictureView): TRetornoImagem; overload;
begin
  Result := objFuncoes.fCarregaImagemLinhaGrupo(strCodGru, picImagem);
end;

function fPesqSituacaoProduto(Self     : TForm;                         {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                              edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                       {* Query                                       *}
                              Var chrKey: Char;                         {* Key                                         *}
                              Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}
begin
  Result := objFuncoes.fPesqSituacaoProduto(Self,edtCodigo,edtDescri,qryTabela,chrKey,arrSel,blnConSim);
end;

function fPesqItem(opcTipIte: TTipoConsultaItem;
                   Self     : TForm;
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
Begin
  Result := objFuncoes.fPesqItem(opcTipIte, Self, edtCodigo, edtDesIte, qryTabela,
    chrKey, arrSel, blnConSim, objFrmPnl, strTitulo, strTabPre, strConPag, fltTaxVpr,
    blnEmpFat, blnExiPar, intOpcAtivos, opcCodIte, strAplica, blnPedCom, strCodCli,
    blnMostrarPrecos, blnTablet, blnConsiderarExiLis, strCodCmp, blnDepMatPriIndustrial,
    blnDepProAcaIndustrial, blnDepProEmbIndustrial, blnDepProGraIndustrial, blnVeioF11,
    blnSomenteEstrutura);
End;

function fRetNomFornecedor(strCodFor: String): String;
Begin
  Result := objFuncoes.fRetNomFornecedor(strCodFor);
End;

function fPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
                         Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtNomEmp: TCustomEdit;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqFornecedor(opcConFor, Self, edtCodigo, edtNomEmp, qryTabela,
    chrKey, arrSel, blnConSim);
End;

function fPesqOperador(Self     : TForm;                             {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                               {* Edit do Código                                            *}
                       edtDescri: TEditFocus;                                {* Edit da Descrição                                         *}
                       qryTabela: TUniQuery;                                 {* Query                                                     *}
                       Var chrKey: Char;                                     {* Key                                                       *}
                       Var arrSel: TConsultasArray;                          {* Array de Seleção                                          *}
                       blnConSim: Boolean = True;                            {* Consulta Simples ou Múltipla (multi select)               *}
                       blnAtivos: Boolean = False;                           {* Somente Operadores Ativos                                 *}
                       blnGerentes: Boolean = False;                         {* Somente Operadores Gerentes                               *}
                       blnMecanicos: Boolean = False;                        {* Somente Operadores Mecânicos                              *}
                       blnVenRepre: Boolean = False;                         {* Somente Vendedor Interno/Representante Externo            *}
                       blnCompradores: Boolean = False;                      {* Somente Compradores                                       *}
                       blnAdministrativo: Boolean = False;                   {* Somente Operadores Administrativos                        *}
                       blnSubGerentes: Boolean = False;
                       blnVendedorEmpLog: Boolean = False;                   {* Somente vendedor da empresa logada                        *}
                       blnPermissaoTransferencia: Boolean = False): Boolean; {* Somente Operadores com permissão de receber transferencia *}
Begin
  Result := objFuncoes.fPesqOperador(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnAtivos, blnGerentes, blnMecanicos, blnVenRepre, blnCompradores,
    blnAdministrativo, blnSubGerentes, blnVendedorEmpLog, blnPermissaoTransferencia);
End;

function fRetNomMarca(strCodMar: String): String;
Begin
  Result := objFuncoes.fRetNomMarca(strCodMar);
End;

function fPesqMarcas(Self     : TForm;
                     edtCodigo: TCustomEdit;
                     edtDescri: TEditFocus;
                     qryTabela: TUniQuery;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqMarcas(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
End;

function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
Begin
  Result := objFuncoes.fVerificaAcessoSistema(strNomeForm, strCodOpe);
End;

procedure pCarregaComposicaoCusto(cbbComCus: TComboBoxFocus);
Begin
  objFuncoes.pCarregaComposicaoCusto(cbbComCus);
End;

procedure pPreencheCombo(var cmb: TCustomComboBox; arr: Array of String; blnLimpa: Boolean = True);
Begin
  objFuncoes.pPreencheCombo(cmb, arr, blnLimpa);
End;

function fGetTintasdeMaquina(blnDestruir: Boolean = False): ITintasDeMaquina;
Begin
  Result := objFuncoes.fGetTintasdeMaquina(blnDestruir);
End;

function fRetCodVendedor(strSenha: String; blnGerente : Boolean = False; blnSubGerente: Boolean = False): String;
Begin
  Result := objFuncoes.fRetCodVendedor(strSenha, blnGerente, blnSubGerente);
End;

function fRetSenhaVendedor(strCodVen: String): String;
begin
  Result := objFuncoes.fRetSenhaVendedor(strCodVen);
end;

function fValidaGerSubVen(blnLib: Boolean; strTipo: Char; edtCod, edtDes: TEditFocus; strTitulo:String=''): Boolean;
begin
  Result := objFuncoes.fValidaGerSubVen(blnLib, strTipo, edtCod, edtDes, strTitulo);
end;

function fStrLocate(objCodigo: TObject;
                    arrLinha: TConsultasArray;
                    strNomCampo,
                    strNomPar: String;
                    blnSemAND: Boolean = False;
                    blnNegar: Boolean = False;
                    strCodigo: String = ''): String;
Begin
  Result := objFuncoes.fStrLocate(objCodigo, arrLinha, strNomCampo, strNomPar,
    blnSemAND, blnNegar, strCodigo);
End;

function fRetornaComposicao(strDescri:String; blnPadrao : Boolean = False): String;
Begin
  Result := objFuncoes.fRetornaComposicao(strDescri, blnPadrao);
End;

function fStrRelFatorLit(strAliasDet: String = ''; blnVeioMarkup: Boolean = False): String;
Begin
  Result := objFuncoes.fStrRelFatorLit(strAliasDet, blnVeioMarkup);
End;

procedure pSetaParam(strText: String; arrLinha: TConsultasArray; Var strLinha: String; strNomPar: String; qryRelatorio: TUniQuery); Overload;
Begin
  objFuncoes.pSetaParam(strText, arrLinha, strLinha, strNomPar, qryRelatorio);
End;

procedure pSetaParam(edtValor:TEditFocus; strNomPar: String; qryRelatorio: TUniQuery; blnLike: Boolean = False); overload;
Begin
  objFuncoes.pSetaParam(edtValor, strNomPar, qryRelatorio, blnLike);
End;

procedure pSetaParamOR(objCodigo: TObject; arrLinha: TConsultasArray; strNomPar: String; qryRelatorio: TUniQuery);
Begin
  objFuncoes.pSetaParamOR(objCodigo, arrLinha, strNomPar, qryRelatorio);
End;

function fStrTitulo(strText: String;
                    edtDescri: TEditFocus;
                    arrLinha: TConsultasArray;
                    strLinha,
                    strTitulo: String;
                    blnTodas: Boolean = False;
                    blnNegar: Boolean = False): String; Overload;
Begin
  Result := objFuncoes.fStrTitulo(strText, edtDescri, arrLinha, strLinha, strTitulo,
    blnTodas, blnNegar);
End;

function fStrTitulo(strText: String;
                    edtDescri: TEditFocus;
                    arrLinha: TConsultasArray;
                    strLinha,
                    strTitulo,
                    strVazio: String): String; Overload;
Begin
  Result := objFuncoes.fStrTitulo(strText, edtDescri, arrLinha, strLinha, strTitulo,
    strVazio);
End;

function fStrTitulo(edtValor: TEditFocus; strTitulo: String): String; Overload;
Begin
  Result := objFuncoes.fStrTitulo(edtValor, strTitulo);
End;

function fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                        Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtNomEmp: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True;
                        blnResEmp: Boolean = False;
                        strEmpresas: String  = '';
                        blnAceCtr: Boolean = False;
                        strAceCtr: String = ''): Boolean;
Begin
  Result := objFuncoes.fPesqEmpresa(opcTipCon, Self, edtCodigo, edtNomEmp, qryTabela,
    chrKey, arrSel, blnConSim, blnResEmp, strEmpresas, blnAceCtr, strAceCtr);
End;

function fStrSQLOr(objCodigo: TObject;
                   arrLinha: TConsultasArray;
                   strNomCampo,
                   strNomPar: String;
                   blnSemAND: Boolean = False;
                   blnNegar: Boolean = False ): String;
Begin
  Result := objFuncoes.fStrSQLOr(objCodigo, arrLinha, strNomCampo, strNomPar,
    blnSemAND, blnNegar);
End;

function fPesqCliente(opcTipCli: TTipoConsultaCliente;
                      Self     : TForm;
                      edtCodigo: TCustomEdit;
                      edtNomCli: TEditFocus;
                      qryTabela: TUniQuery;
                      Var chrKey: Char;
                      Var arrSel: TConsultasArray;
                      blnConSim: Boolean = True;
                      objFrmPnl: TPanelCx = Nil;
                      blnTablet: Boolean = False;
                      strCodRep: String = ''): Boolean;
Begin
  Result := objFuncoes.fPesqCliente(opcTipCli, Self, edtCodigo, edtNomCli, qryTabela,
    chrKey, arrSel, blnConSim, objFrmPnl, blnTablet, strCodRep);
End;

function fRetornaNomeTinta(strIdePro: String): String;
Begin
  Result := objFuncoes.fRetornaNomeTinta(strIdePro);
End;

function fDescriLinhaWandaPro(intLinha: Integer): String;
Begin
  Result := objFuncoes.fDescriLinhaWandaPro(intLinha);
End;

function fStrToFloat(strValorUnico: String): Double;
Begin
  Result := objFuncoes.fStrToFloat(strValorUnico);
End;

function fEntraCons(strCodigo: String): Boolean;
Begin
  Result := objFuncoes.fEntraCons(strCodigo);
End;

function fEscolheTinta(strCodCli : String = ''): ShortString;
Begin
  Result := objFuncoes.fEscolheTinta(strCodCli);
End;

function fRetNomSubRegiao(Const strCodSub: String): String;
Begin
  Result := objFuncoes.fRetNomSubRegiao(strCodSub);
End;

function fPesqSubRegiao(Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtDescri: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqSubRegiao(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
End;

function fPesqRedeLojas(Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtDescri: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqRedeLojas(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
End;

function fRetDesReg(strCodReg: String): String;
Begin
  Result := objFuncoes.fRetDesReg(strCodReg);
End;

function fPesqRegiao(Self     : TForm;
                     edtCodigo: TCustomEdit;
                     edtDescri: TEditFocus;
                     qryTabela: TUniQuery;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqRegiao(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
End;

function fRetNomUnidade(strCodUni: String): String;
Begin
  Result := objFuncoes.fRetNomUnidade(strCodUni);
End;

function fPesqUnidade(Self      : TForm;
                      edtCodigo : TCustomEdit;
                      edtUnidade: TEditFocus;
                      edtSigla  : TEditFocus;
                      qryTabela : TUniQuery;
                      Var chrKey: Char;
                      Var arrSel: TConsultasArray;
                      blnConSim : Boolean = True;
                      blnPesqSigla : Boolean = False): Boolean;
Begin
  Result := objFuncoes.fPesqUnidade(Self, edtCodigo, edtUnidade, edtSigla, qryTabela,
    chrKey, arrSel, blnConSim, blnPesqSigla);
End;

function fPesqGrupoProduto(Self         : TForm;
                           edtCodigo    : TCustomEdit;
                           edtDescricao : TEditFocus;
                           qryTabela    : TUniQuery;
                           Var chrKey   : Char;
                           Var arrSel   : TConsultasArray;
                           blnConSim    : Boolean = True): Boolean; inline;
Begin
  Result := objFuncoes.fPesqGrupoProduto(Self, edtCodigo, edtDescricao, qryTabela,
    chrKey, arrSel, blnConSim);
End;

function fPesqTipoServico(Self     : TForm;                          {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                          edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                      {* Query                                       *}
                          Var chrKey: Char;                          {* Key                                         *}
                          Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;inline;{* Consulta Simples ou Múltipla (multi select) *}
begin
  Result := objFuncoes.fPesqTipoServico(Self, edtCodigo, edtDescri, qryTabela,
                                        chrKey, arrSel, blnConSim);
end;

function fRetNomAtividade(Const strCodAti: String): String;
Begin
  Result := objFuncoes.fRetNomAtividade(strCodAti);
End;

function fPesqAtividade(Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtDescri: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqAtividade(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
End;

function fRetDescDepartamento(strCodDep: String): String;
Begin
  Result := objFuncoes.fRetDescDepartamento(strCodDep);
End;

function fRetNomeGrupoProduto(strCodigo: String): String; inline;
Begin
  Result := objFuncoes.fRetNomeGrupoProduto(strCodigo);
End;

function fPesqDepartamento(Self     : TForm;
                           edtCodigo: TCustomEdit;
                           edtDescri: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqDepartamento(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
End;

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
Begin
  Result := objFuncoes.fCalculaPrecoVenda(intOpcPrecoMargem, curPrecus, curPreven,
    curMarBru, curIcmsVenda, curImpFed, curDesOpe, curValCom, strMarMkp, strPcmPro,
    intDecUni);
End;

function fGetLetraAlfa(intCol: Integer): String;
Begin
  Result := objFuncoes.fGetLetraAlfa(intCol);
End;

function fRetNomCidadeSemOpc(strCodigo: String): String;
Begin
  Result := objFuncoes.fRetNomCidadeSemOpc(strCodigo);
End;

function fCalcMediaPagto(strConPag: String): Double;
Begin
  Result := objFuncoes.fCalcMediaPagto(strConPag);
End;

function fPesqCidade(Self     : TForm;
                     edtCodigo: TCustomEdit;
                     edtCidade: TEditFocus;
                     edtEstado: TEditFocus;
                     qryTabela: TUniQuery;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqCidade(Self, edtCodigo, edtCidade, edtEstado, qryTabela,
    chrKey, arrSel, blnConSim);
End;

procedure pCriaTabelaDel(strNomTab: String);
Begin
  objFuncoes.pCriaTabelaDel(strNomTab);
End;

function fFormataCondPag(strCond: String): String;
Begin
  Result := objFuncoes.fFormataCondPag(strCond);
End;

function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;
Begin
  Result := objFuncoes.fRetNomCidade(strCodigo, intOpcao);
End;

function fTabelaExiste(strNomeTabela: String): Boolean;
Begin
  Result := objFuncoes.fTabelaExiste(strNomeTabela);
End;

function fStrZero(Zeros: string; Quant: integer): String; Overload;
Begin
  Result := objFuncoes.fStrZero(Zeros, Quant);
End;

function fStrZero(Zeros: Integer; Quant: integer): String; Overload;
Begin
  Result := objFuncoes.fStrZero(Zeros, Quant);
End;

function fRetNomCadGpo(Const strCodGpo: String): String;
Begin
  Result := objFuncoes.fRetNomCadGpo(strCodGpo);
End;

function fPesqGrupoOperador(Self     : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqGrupoOperador(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
End;

function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;
Begin
  Result := objFuncoes.fDoubleAggregate(cdsClient, strNomCam);
End;

function fStrLocateEmpresa(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
  strNomPar: String; blnSemAND: Boolean = False; strCodigo: String = ''): String;
Begin
  Result := objFuncoes.fStrLocateEmpresa(objCodigo, arrLinha, strNomCampo, strNomPar,
    blnSemAND, strCodigo);
End;

function fRetConPag(strCodCnd: String): String;
Begin
  Result := objFuncoes.fRetConPag(strCodCnd);
End;

function fPesqCondicoesPgto(Self     : TForm;
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
Begin
  Result := objFuncoes.fPesqCondicoesPgto(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, blnTablet, opcTipCon, fltMarDoc, fltValDoc, strCodCli,
    blnAtivas, blnFaturamento);
End;

function fRetPerComMargem(fltValor: Double; strTipVen : String = ''; strConPag : String = ''): Double;
Begin
  Result := objFuncoes.fRetPerComMargem(fltValor, strTipVen, strConPag);
End;

function fRetPerComOpeMargem(fltCusto, fltVenda : Double; strCodOpe : String): Double;
Begin
  Result := objFuncoes.fRetPerComOpeMargem(fltCusto, fltVenda, strCodOpe);
End;

procedure pSetaClient(cdsClient: TDataSet);
Begin
  objFuncoes.pSetaClient(cdsClient);
End;

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
                                var strComPro: String;
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
Begin
    Result := objFuncoes.fRetornaPrecosPromocao(strCodIte, strCodCli, dtaDtaPro,
    fltQtdDig, fltQtdJaDig, fltQtdJaEmPromoc, intPraMed, fltPreCus, fltPreVen, fltComVar, fltComAta,
    fltComDis, fltQtdDis, fltDesF07, strComPro, blnParticiona, blnPromo, strTabPre, strCodCnd, strPrzPro,
    strENTBRF, blnConsideraQtd, blnBuscaPreco, strIteVid, blnEntIme, blnEntFut, strMotFut,
    strEmpPro, strNumOrc, strEspOrc);
End;

function fRetPerComLucro(fltQtdIte,
                         fltUniOri,
                         fltTotCus,
                         fltTotIte,
                         fltDesEsp,
                         fltComVar: Double;
                         fltTotCu2: Double = 0.0;
                         strMarMkp: String = '';
                         strPcmPro: String = '';
                         intDecUni: Integer = -1): Double;
Begin
  Result := objFuncoes.fRetPerComLucro(fltQtdIte, fltUniOri, fltTotCus, fltTotIte - fltDesEsp,
    fltComVar, fltTotCu2, strMarMkp, strPcmPro, intDecUni);
End;

function fCurrentDate: String; Overload;
Begin
  Result := objFuncoes.fCurrentDate;
End;

function fCurrentDate(Const Value: TDateTime): String; Overload;
Begin
  Result := objFuncoes.fCurrentDate(Value);
End;

function fRetNomProfissional(Const strCodPro: String; blnVerStatus: Boolean = False): String;
Begin
  Result := objFuncoes.fRetNomProfissional(strCodPro, blnVerStatus);
End;

function fRetNomDiversos(strCodDiv: String): String;
Begin
  Result := objFuncoes.fRetNomDiversos(strCodDiv);
End;

function fPesqDiversos(Self        : TForm;
                       edtCodigo   : TCustomEdit;
                       edtDescri   : TEditFocus;
                       qryTabela   : TUniQuery;
                       Var chrKey  : Char;
                       Var arrSel  : TConsultasArray;
                       blnConSim   : Boolean = True;
                       blnVerStatus: Boolean = False;
                       blnVerEmpAce: Boolean = False;
                       strCodCli   : String  = ''): Boolean;
Begin
  Result := objFuncoes.fPesqDiversos(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnVerStatus, blnVerEmpAce, strCodCli);
End;

function fPesqParceiro(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True): Boolean;
begin
  Result := objFuncoes.fPesqParceiro(Self, edtCodigo, edtDescri, qryTabela, chrKey, arrSel, blnConSim);
end;

function fRetExtensoNumero(Value : String):String;
Begin
  Result := objFuncoes.fRetExtensoNumero(Value);
End;

function fDataExtenso(Data:TDateTime; blnImpCid : Boolean = False; blnImpDiaSemana : Boolean = False): String;
Begin
  Result := objFuncoes.fDataExtenso(Data, blnImpCid, blnImpDiaSemana);
End;

function fRetDataExtenso(dtaData: TDateTime; blnComCidade: Boolean = False): String;
Begin
  Result := objFuncoes.fRetDataExtenso(dtaData, blnComCidade);
End;

function ffrmSenha(var strSenha: String; strTitulo: String = ''): Boolean;
Begin
  Result := objFuncoes.ffrmSenha(strSenha, strTitulo);
End;

function fCampoTabela(strCampo : String;
                      strNomTab: String;
                      arrCampoChave: Array Of String;
                      arrValorChave: Array Of Variant;
                      blnSempreLerBanco: Boolean = True;
                      strOrderBy: String = '';
                      Conexao: TUniConnection = Nil;
                      blnUsarMax: Boolean = False): Variant;
Begin
  Result := objFuncoes.fCampoTabela(strCampo, strNomTab, arrCampoChave, arrValorChave, blnSempreLerBanco,
    strOrderBy, Conexao, blnUsarMax);
End;

function fFormataFone(strFone: String): String;
Begin
  Result := objFuncoes.fFormataFone(strFone);
End;

procedure pSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; qryResult: TUniQuery);
Begin
  objFuncoes.pSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli, qryResult);
End;

procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
Begin
  objFuncoes.pDisableControls(dtsDataSet, prcScroll);
End;

procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
Begin
  objFuncoes.pEnableControls(dtsDataSet, prcScroll, blnRefresh);
End;

function fGetMsgRelCnf: String;
Begin
  Result := objFuncoes.fGetMsgRelCnf;
End;

procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False);
Begin
  objFuncoes.pCloneDataSet(dtsDestino, dtsOrigem, blnComFomatacao);
End;

function fValidaDataStr(strData: String): Boolean;
Begin
  Result := objFuncoes.fValidaDataStr(strData);
End;

function fRetUFCliente(strCodCli: String): String;
Begin
  Result := objFuncoes.fRetUFCliente(strCodCli);
End;

function fRetUFEmpresa(strCodEmp: String): String;
Begin
  Result := objFuncoes.fRetUFEmpresa(strCodEmp);
End;

function fRetDadosClienteConsumidor(strDocumento, strCampo: String): String;
Begin
  Result := objFuncoes.fRetDadosClienteConsumidor(strDocumento, strCampo);
End;

function fValidaPlaca(strPlaca: String): Boolean;
Begin
  Result := objFuncoes.fValidaPlaca(strPlaca);
End;

function fRetornaDescricaoVeic(strPlaVei: String): String;
Begin
  Result := objFuncoes.fRetornaDescricaoVeic(strPlaVei);
End;

function fFrtStrExcel(strValor: String) : String;
Begin
  Result := objFuncoes.fFrtStrExcel(strValor);
End;

function fRetNomClienteConsumidor(strCodigo: String): String;
Begin
  Result := objFuncoes.fRetNomClienteConsumidor(strCodigo);
End;

function fPesqConsumidores(Self      : TForm;
                           edtCodCon : TDBEditFocus;
                           edtDesCon : TDBEditFocus;
                           edtCgcCpf : TEditFocus;
                           mskNumCgc : TMaskEditFocus;
                           qryTabela : TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           strCodCli : String  = '';
                           blnConSim : Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqConsumidores(Self, edtCodCon, edtDesCon, edtCgcCpf,
    mskNumCgc, qryTabela, chrKey, arrSel, strCodCli, blnConSim);
End;

function fPesqVeiculos(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True;
                       blnComMsk: Boolean = True;
                       strFiltro: String = ''): Boolean;
Begin
  Result := objFuncoes.fPesqVeiculos(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnComMsk, strFiltro);
End;

function fStrLocateLinGru(objCodigo: TObject;
                          arrLinha: TConsultasArray;
                          strNomCampo,
                          strNomPar: String;
                          blnSemAND: Boolean = False;
                          blnNegar: Boolean = False;
                          strCodigo: String = '';
                          blnAndFinal: Boolean = False): String;
Begin
  Result := objFuncoes.fStrLocateLinGru(objCodigo, arrLinha, strNomCampo, strNomPar,
    blnSemAND, blnNegar, strCodigo, blnAndFinal);
End;

function fReplicatorStr(strRepl: String; intTamanho: Integer): String;
Begin
  Result := objFuncoes.fReplicatorStr(strRepl, intTamanho);
End;

function fRetNomPortador(Const strCodPor: String): String;
Begin
  Result := objFuncoes.fRetNomPortador(strCodPor);
End;

function fPesqPortador(opcTipPor: TTipoConsultaSimples;
                       Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDesPor: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True;
                       strTitulo: String = 'Consulta de Portadores';
                       strBolFat: String = '';
                       blnSalPor: Boolean = False): Boolean;
Begin
  Result := objFuncoes.fPesqPortador(opcTipPor, Self, edtCodigo, edtDesPor, qryTabela,
    chrKey, arrSel, blnConSim, strTitulo, strBolFat, blnSalPor);
End;

function fRetNomDep(strCodDep: String): String;
Begin
  Result := objFuncoes.fRetNomDep(strCodDep);
End;

function fRemoveAcento(Str: String): String;
Begin
  Result := objFuncoes.fRemoveAcento(Str);
End;

procedure pRemoveAcentoVarRel(frx: TfrxReport; arrVar: Array Of String);
  Var
    strVar: String;
Begin
 {********************************************}
 {* IMPLEMENTADA TAMBÉM EM untFuncoesSimples *}
 {* SE MODIFICAR ALGO AQUI MUDAR LÁ TAMBÉM   *}
 {*****************************************VA*}
  For strVar In arrVar Do
    Try
      frx.Script.Variables[strVar]:=fRemoveAcento(frx.Script.Variables[strVar]);
    Except

    End;
End;

procedure pCarregaChkLisTabPre(Var ChkLis: TCheckListBox);
  Var
    intIndex: Integer;
Begin
  ChkLis.Items.Clear;
  For intIndex := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intIndex] = 'S' Then
      ChkLis.Items.Add('Tabela ' + IntToStr(intIndex));
end;

function fRetTabPreSelChkLis(ChkLis: TCheckListBox): String;

  function fRetSomenteNumeros(strTexto: String): String;
    Var
      intIndex: Integer;
  begin
    Result := '';

    If Not fEmptyStr(strTexto) Then
    Begin
      For intIndex := 1 To Length(strTexto) Do
        If CharInSet(strTexto[intIndex], ['0'..'9']) Then
          Result := Result + strTexto[intIndex];
    End;
  end;

  function fVirgula(strAux: String): String;
  begin
    If Not fEmptyStr(strAux) Then
      Result := ', ';
  end;

  Var
    intIndex: Integer;
Begin
  Result := '';
  For intIndex := 0 To ChkLis.Items.Count - 1 Do
    If ChkLis.Checked[intIndex] Then
      Result := Result + fVirgula(Result) + fRetSomenteNumeros(ChkLis.Items[intIndex]);
end;

function fRetDesConPag(strCodCnd: String): String;
Begin
  Result := objFuncoes.fRetDesConPag(strCodCnd);
End;

function IfNull(varValor, varDefault: Variant): Variant;
Begin
  Result := objFuncoes.IfNull(varValor, varDefault);
End;

function fValidaEstado(strUf: String): Boolean;
Begin
  Result := objFuncoes.fValidaEstado(strUf);
End;

function fRetNomeEstado(strNomeEstado: String): String;
Begin
  Result := objFuncoes.fRetNomeEstado(strNomeEstado);
End;

function fRetDescOcorrencia(Const strCodOcorrencia: String): String;
Begin
  Result := objFuncoes.fRetDescOcorrencia(strCodOcorrencia);
End;

function fRetNomFaseObra(Const strCodFas: String): String;
Begin
  Result := objFuncoes.fRetNomFaseObra(strCodFas);
End;

function fPesqOcorrencia(Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqOcorrencia(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
End;

function fPesqFaseObra(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True): Boolean; inline;
begin
  Result := objFuncoes.fPesqFaseObra(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
end;

function fRetNomeOperador(strCodOpe: String): String;
Begin
  Result := objFuncoes.fRetNomeOperador(strCodOpe);
End;

function fGetTituloVersao(): String;
begin
  Result := objFuncoes.fGetTituloVersao;
end;

function fGetUsuarioLogado(): String;
begin
  Result := objFuncoes.fGetUsuarioLogado;
end;

function fGetEmpresaLogada(): String;
begin
  Result := objFuncoes.fGetEmpresaLogada;
end;

function fRetNomeServico(Const strCodSer: String): String;
Begin
  Result := objFuncoes.fRetNomeServico(strCodSer);
End;

function fPesqServicos(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True;
                       blnAutCen: Boolean = False): Boolean;
Begin
  Result := objFuncoes.fPesqServicos(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim, blnAutCen);
End;

function fRetNomTransportadora(strCodTra: String): String;
Begin
  Result := objFuncoes.fRetNomTransportadora(strCodTra);
End;

function fDescricaoFrete(strTipo: String): String;
Begin
  Result := objFuncoes.fDescricaoFrete(strTipo);
End;

function fPesqTransportadora(opcConTra: TTipoConsultaTransportad;
                             Self     : TForm;
                             edtCodigo: TCustomEdit;
                             edtNomTra: TEditFocus;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True;
                             strCidCli: String = ''): Boolean;
Begin
  Result := objFuncoes.fPesqTransportadora(opcConTra, Self, edtCodigo, edtNomTra,
    qryTabela, chrKey, arrSel, blnConSim, strCidCli);
End;

procedure pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);
Begin
  objFuncoes.pPesquisaCadEmp(qryTabOri, qryTabela, strCodEmp);
End;

function fRetDesForPag(strCodFpg: String): String;
Begin
  Result := objFuncoes.fRetDesForPag(strCodFpg);
End;

function fPesqFormaPgto(opcTipPgt: TTipoConsultaFormaPagto;
                        Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtDescri: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True;
                        blnTablet: Boolean = False): Boolean;
Begin
  Result := objFuncoes.fPesqFormaPgto(opcTipPgt, Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, blnTablet);
End;

function fRetCidEmpresa(strCodEmp: String): String;
Begin
  Result := objFuncoes.fRetCidEmpresa(strCodEmp);
End;

function fDiaDeFolga(dtaDta: TDateTime;
                     blnConsideraSabado : Boolean = True;
                     strCodCid: String = '';
                     blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                     blnConsideraDomingo: Boolean = False): Boolean;
Begin
  Result := objFuncoes.fDiaDeFolga(dtaDta, blnConsideraSabado, strCodCid, blnConsideraSabadoAndDomingoComoDiaUtil, blnConsideraDomingo);
End;

function fGetZClient(Owner: TComponent; strSQL: String = ''): IZClient;
Begin
  Result := objFuncoes.fGetZClient(Owner, strSQL);
End;

function fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada: String;
                                                          arrAlias: TParamArrayString=NIL;
                                                          arrMacroParaCadaItemDoarrAlias: TParamArrayString=NIL;
                                                          arrApenasAsEspecies: TParamArrayString=NIL; 
                                                          strPrefixo: String='DET_';
                                                          strOperacaoSeSomenteValor: String=''): String;
begin
  Result := objFuncoes.fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada, arrAlias, arrMacroParaCadaItemDoarrAlias, arrApenasAsEspecies, strPrefixo, strOperacaoSeSomenteValor);
end;

function fGetMesesGiro(Owner: TComponent; intAnos: Integer): IMesesGiro;
Begin
  Result := objFuncoes.fGetMesesGiro(Owner,intAnos);
End;

procedure pMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);
Begin
  objFuncoes.pMensagemOk(strMensagem, intWidth, intHeight);
End;

function fComponentByName(Owner: TWinControl; strNome: String): TComponent;
Begin
  Result := objFuncoes.fComponentByName(Owner, strNome);
End;

function fRetDesSubReg(strCodSub: String): String;
Begin
  Result := objFuncoes.fRetDesSubReg(strCodSub);
End;

function fGetCamGer(Owner: TComponent): ICamGer;
Begin
  Result := objFuncoes.fGetCamGer(Owner);
End;

function fPesqCampanha(Self       : TForm;
                       edtCodCam  : TCustomEdit;
                       edtDesCam  : TEditFocus;
                       qryConCam  : TUniQuery;
                       Var chrKey : Char;
                       Var arrSel : TConsultasArray;
                       blnConSim  : Boolean = True;
                       strTitulo  : String = 'Consulta de Campanhas'): Boolean;
Begin
  Result := objFuncoes.fPesqCampanha(Self, edtCodCam, edtDesCam, qryConCam, chrKey,
    arrSel, blnConSim, strTitulo);
End;

function fTamNumDoc: Integer;
Begin
  Result := objFuncoes.fTamNumDoc;
End;

function fGetTValorRecebido: IValorRecebido;
Begin
  Result := objFuncoes.fGetTValorRecebido;
End;

function fStatusCndPag(strCndPag: String): Integer;
Begin
  Result := objFuncoes.fStatusCndPag(strCndPag);
End;

function fRetDescFpg(Const strCodFpg: String): String;
Begin
  Result := objFuncoes.fRetDescFpg(strCodFpg);
End;

function fRetPerComIndice(fltValor, fltValorNt: Double; blnAtingiu: Boolean): Double;
Begin
  Result := objFuncoes.fRetPerComIndice(fltValor, fltValorNt, blnAtingiu);
End;

function fRetMetaIndice: Double;
Begin
  Result := objFuncoes.fRetMetaIndice;
End;

function fRetTipoForaConPag(strCodCnd: String): String;
Begin
  Result := objFuncoes.fRetTipoForaConPag(strCodCnd);
End;

function fPesqMotorista(Self     : TForm;
                        edtCodigo: TCustomEdit;
                        edtDescri: TEditFocus;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True;
                        blnAtivos: Boolean = False): Boolean;
Begin
  Result := objFuncoes.fPesqMotorista(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, blnAtivos);
End;

function fPesqEntrga(Self      : TForm;
                     edtNumEnt : TCustomEdit;
                     qryConEnt : TUniQuery;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSimp: Boolean = True;
                     strTitulo : String = 'Consulta de Entregas'): Boolean;
Begin
  Result := objFuncoes.fPesqEntrga(Self, edtNumEnt, qryConEnt, chrKey, arrSel,
    blnConSimp, strTitulo);
End;

function fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
Begin
  Result := objFuncoes.fValidaPeriodo(strDtaIni, strDtaFin);
End;

function fRetNomeMotorista(strCodMot: String; blnAtivos: Boolean = False): String;
Begin
  Result := objFuncoes.fRetNomeMotorista(strCodMot, blnAtivos);
End;

function fCriaClientDatset(qryOrigem: TDataSet; blnVazio: Boolean = False; AOwner: TComponent = Nil): TUniClientDataSet;
Begin
  Result := objFuncoes.fCriaClientDatset(qryOrigem, blnVazio, AOwner);
End;

function fMediaTime(strMedia: String): Integer;
Begin
  Result := objFuncoes.fMediaTime(strMedia);
End;

function fSegToTempoStr(intSegundos: Integer): String;
Begin
  Result := objFuncoes.fSegToTempoStr(intSegundos);
End;

procedure pDropTable(strTempTable: String);
Begin
  objFuncoes.pDropTable(strTempTable);
End;

function fRetNomeConta(strCodCta: String): String;
Begin
  Result := objFuncoes.fRetNomeConta(strCodCta);
End;

function fPesqCentroCusto(Self     : TForm;
                          edtCodigo: TCustomEdit;
                          edtDescri: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True;
                          blnUsaCtf: Boolean = False;
                          strCodFor: String  = ''): Boolean;
Begin
  Result := objFuncoes.fPesqCentroCusto(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, blnUsaCtf, strCodFor);
End;

function fRetMotivoVendasPerdidas(Const strCodMot: String): String;
Begin
  Result := objFuncoes.fRetMotivoVendasPerdidas(strCodMot);
End;

function fPesqMotVendasPerdidas(Self     : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqMotVendasPerdidas(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
End;

function fRetDescGrupoCompra(Const strCodGru: String): String;
Begin
  Result := objFuncoes.fRetDescGrupoCompra(strCodGru);
End;

function fPesqGrupoCompra(Self     : TForm;
                          edtCodigo: TCustomEdit;
                          edtDescri: TEditFocus;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqGrupoCompra(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
End;

function fRetQuantPendentePedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): Double;
Begin
  Result := objFuncoes.fRetQuantPendentePedidoCompra(strCodIte, strEmpresas, blnFiltraTE);
End;

function fRetProximaDtaEntrPedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): String;
Begin
  Result := objFuncoes.fRetProximaDtaEntrPedidoCompra(strCodIte, strEmpresas, blnFiltraTE);
End;

function fRetNomeProfissional(Const strCodPro: String): String;
Begin
  Result := objFuncoes.fRetNomeProfissional(strCodPro);
End;

function fRetNomeParceiro(Const strCodPar: String): String;
begin
  Result := objFuncoes.fRetNomeParceiro(strCodPar);
end;

function fGetConfTinta(strIdePro: String): IConfTinta;
Begin
  Result := objFuncoes.fGetConfTinta(strIdePro);
End;

function fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela : String; fltCodigo: Double) : String;
Begin
  Result := objFuncoes.fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela, fltCodigo);
End;

function fPesqPromocoes(Self      : TForm;
                        edtCodPro : TEditFocus;
                        edtDesPro : TEditFocus;
                        qryTabela : TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim : Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqPromocoes(Self, edtCodPro, edtDesPro, qryTabela, chrKey,
    arrSel, blnConSim);
End;

function fGetTCadFun(Owner: TComponent): ICadFun;
Begin
  Result := objFuncoes.fGetTCadFun(Owner);
End;

function fSegToTimeStr(Segundos: Double): String;
Begin
  Result := objFuncoes.fSegToTimeStr(Segundos);
End;

function fRetMotorista(Const strCodMot: String): String;
Begin
  Result := objFuncoes.fRetMotorista(strCodMot);
End;

function fRetCidade(Const strCodigo: String): String;
Begin
  Result := objFuncoes.fRetCidade(strCodigo);
End;

function fRetNomRegiao(Const strCodReg: String): String;
Begin
  Result := objFuncoes.fRetNomRegiao(strCodReg);
End;

function fGetTExtratoComissaoProfissional(dtaEntIni,
                                          dtaEntFin,
                                          dtaBaiIni,
                                          dtaBaiFin: TDateTime;
                                          objCodPro,
                                          objCodAti,
                                          objCodCli,
                                          objCodRed,
                                          objCodEmp: TObject;
                                          arrCodPro,
                                          arrCodAti,
                                          arrCodCli,
                                          arrCodRed,
                                          arrCodEmp: TConsultasArray;
                                          fltVlrCom: Double;
                                          intCalcul: Integer;
                                          strTipFil: String;
                                          strTCoPro: String;
                                          intOrdena: Integer): IFastPrintFile;
Begin
  Result := objFuncoes.fGetTExtratoComissaoProfissional(dtaEntIni, dtaEntFin,
    dtaBaiIni, dtaBaiFin, objCodPro, objCodAti, objCodCli, objCodRed, objCodEmp,
    arrCodPro, arrCodAti, arrCodCli, arrCodRed, arrCodEmp, fltVlrCom, intCalcul,
    strTipFil, strTCoPro, intOrdena);
End;

function fGetTFastPrintFileEditor(AOwner: TComponent): IFastPrintFileEditor;
Begin
  Result := objFuncoes.fGetTFastPrintFileEditor(AOwner);
End;

function fGetObjFastPrintFileEditor(): TObject;
begin
  Result := objFuncoes.fGetObjFastPrintFileEditor();
end;

function fGetTReciboCtp(cdsDados: TUniClientDataSet): IFastPrintFile; inline;
Begin
  Result := objFuncoes.fGetTReciboCtp(cdsDados);
End;

function fCriaClientDatasetReciboCTP : TUniClientDataSet; inline;
Begin
  Result := objFuncoes.fCriaClientDatasetReciboCTP;
End;

function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
Begin
  Result := objFuncoes.fPadR(strTexto, intTamanho, strCaracter);
End;

function fRetVS_strTipExp: String;
begin
  Result := objFuncoes.fRetVS_strTipExp;
end;

function fUsaQtdPendenteEntregaFutura: Boolean;
begin
  Result := objFuncoes.fUsaQtdPendenteEntregaFutura;
end;

function fRetDescGrupoAtividade(strCodGat: String): String;
Begin
  Result := objFuncoes.fRetDescGrupoAtividade(strCodGat);
End;

function fPesqGrupoAtividade(Self     : TForm;
                             edtCodigo: TCustomEdit;
                             edtDescri: TEditFocus;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqGrupoAtividade(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
End;

function fEhLetra(strCaract: String): Boolean;
Begin
  Result := objFuncoes.fEhLetra(strCaract);
End;

function fSomenteLetra(str: String): String;
Begin
  Result := objFuncoes.fSomenteLetra(str);
End;

function fGetTMetAno(blnGlobal: Boolean = False; blnEmpOrigem: Boolean = False; strComCus: String = ''): IMetAno;
Begin
  Result := objFuncoes.fGetTMetAno(blnGlobal, blnEmpOrigem, strComCus);
End;

function fRetSiglaUnidade(const strCodUni: String; qryAux: TUniQuery = Nil): String;
begin
  Result := objFuncoes.fRetSiglaUnidade(strCodUni, qryAux);
end;

function fRetSiglaUni(const strCodUni: String): String;
begin
  Result := objFuncoes.fRetSiglaUni(strCodUni);
end;

function fRetSiglaUniConsulta(const strSigUni: String): String;
begin
  Result := objFuncoes.fRetSiglaUniConsulta(strSigUni);
end;

function fValidaAcessoMultSelEmpresa(arrSelecao: TConsultasArray; Var strEmpNegadas: String): Boolean;
begin
  Result := objFuncoes.fValidaAcessoMultSelEmpresa( arrSelecao, strEmpNegadas);
end;

function fRetDataPortador(strCodPor: String): TDateTime;
begin
  Result := objFuncoes.fRetDataPortador(strCodPor);
end;

function fDropTable(strNomeTabela: String): Boolean;
begin
  Result := objFuncoes.fDropTable(strNomeTabela);
end;

function fRetSaldoAnterior(strCodPor: String; dtaDataIni: TDateTime; strCodEmp: String = '';
                           sitSitLan: TSituacaoLancBancario = sitTodos): Currency;
begin
  Result := objFuncoes.fRetSaldoAnterior(strCodPor, dtaDataIni, strCodEmp, sitSitLan);
end;

function fRetornaCtaResDuplicado(qryAux: TUniQuery): Boolean;
begin
  Result := objFuncoes.fRetornaCtaResDuplicado(qryAux);
end;

function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
begin
  Result := objFuncoes.fPadC(strTexto, intTamanho, strCaracter);
end;

function fRetNomEvento(strCodEve: String): String;
begin
  Result := objFuncoes.fRetNomEvento(strCodEve);
end;

function fPesqEventos(Self: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := objFuncoes.fPesqEventos(Self, edtCodigo, edtDescri, qryTabela,chrKey,
    arrSel, blnConSim);
end;

function fPesqPedOrc(opcTipCon: TTipoConsultaPedidoVenda;
  Self: TForm; strEspDoc, strOpcDoc, strCodEmp: String; edtNumDoc: TCustomEdit;
  edtEspDoc, edtCodEmp: TEditFocus; var qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean; objFrmPnl: TPanelCx;
  strCliCrm, strOriF11: String): Boolean;
begin
  Result := objFuncoes.fPesqPedOrc(opcTipCon, Self, strEspDoc, strOpcDoc, strCodEmp, edtNumDoc,
                        edtEspDoc, edtCodEmp, qryTabela, chrKey, arrSel, blnConSim, objFrmPnl,
                        strCliCrm, strOriF11);
end;

function fDigDuplicSemTela(Var arrDuplicata: TarrDuplicata; Var intQtdDup: Integer; Var curTotalRes: Currency;
  strCndPag:String; intNumDoc:Integer; curTotal:Currency; blnEditavel,
  blnHabEditDup:Boolean; dtaDtaBas:TDateTime; blnPergConf: Boolean;
  fltImpost: Double = 0; strUsaChq: String = 'N'; blnDupsRedondas: Boolean = True;
  blnUsaHist: Boolean = False; fltValRec: Double = 0.0;
  arrValores: TDoubleArray = Nil; blnSabDomFeriadoDiasUteis: Boolean = True; strCodCid: String = ''): Boolean;
begin
  Result := objFuncoes.fDigDuplicSemTela(arrDuplicata,
                                         intQtdDup,
                                         curTotalRes,
                                         strCndPag,
                                         intNumDoc,
                                         curTotal,
                                         blnEditavel,
                                         blnHabEditDup,
                                         dtaDtaBas,
                                         blnPergConf,
                                         fltImpost,
                                         strUsaChq,
                                         blnDupsRedondas,
                                         blnUsaHist,
                                         fltValRec,
                                         arrValores,
                                         blnSabDomFeriadoDiasUteis,
                                         strCodCid);
end;

function fRetNomTipoAtend(strCodigo: String): String;
begin
  Result := objFuncoes.fRetNomTipoAtend(strCodigo);
end;

function fPesqTipoAtendimento(Self    : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                blnConSim: Boolean = True): Boolean;
begin
  Result := objFuncoes.fPesqTipoAtendimento(Self, edtCodigo, edtDescri, qryTabela,
                        chrKey, arrSel, blnConSim);
end;

function fPesqSetFlz(Self       : TForm;
                     edtCodigo  : TCustomEdit;
                     edtDescri  : TEditFocus;
                     qryTabela  : TUniQuery;
                     Var chrKey : Char;
                     Var arrSel : TConsultasArray;
                     blnConSim  : Boolean = True): Boolean;
begin
  Result := objFuncoes.fPesqSetFlz(Self,
                                   edtCodigo,
                                   edtDescri,
                                   qryTabela,
                                   chrKey,
                                   arrSel,
                                   blnConSim);
end;
function fPesqTipoCliente(Self       : TForm;
                          edtCodigo  : TCustomEdit;
                          edtDescri  : TEditFocus;
                          qryTabela  : TUniQuery;
                          var chrKey : Char;
                          var arrSel : TConsultasArray;
                          blnConSim  : Boolean): Boolean;
begin
  Result := objFuncoes.fPesqTipoCliente(Self, edtCodigo, edtDescri, qryTabela,
                                        chrKey, arrSel, blnConSim);
end;

function fPesqCofSai(Self      : TForm;                                     {* Formulário                                  *}
                     edtCodigo : TCustomEdit;                               {* Edit do Código                              *}
                     edtDescri : TEditFocus;
                     qryConGen : TUniQuery;                                 {* Query                                       *}
                     Var chrKey: Char;                                      {* Key                                         *}
                     Var arrSel: TConsultasArray;                           {* Array de Consulta                           *}
                     blnConSim : Boolean = True;                            {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String  = 'Consultas de Abr. Cofins'): Boolean;
Begin
  Result := objFuncoes.fPesqCofSai(Self, edtCodigo, edtDescri, qryConGen, chrKey, arrSel, blnConSim, strTitulo);
End;

function fPesqPisSai(Self      : TForm;                                     {* Formulário                                  *}
                     edtCodigo : TCustomEdit;                               {* Edit do Código                              *}
                     edtDescri : TEditFocus;
                     qryConGen : TUniQuery;                                 {* Query                                       *}
                     Var chrKey: Char;                                      {* Key                                         *}
                     Var arrSel: TConsultasArray;                           {* Array de Consulta                           *}
                     blnConSim : Boolean = True;                            {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String  = 'Consultas de Abr. Pis'): Boolean;
Begin
  Result := objFuncoes.fPesqPisSai(Self, edtCodigo, edtDescri, qryConGen, chrKey, arrSel, blnConSim, strTitulo);
End;

function fPesqCstPis(Self      : TForm;                                     {* Formulário                                  *}
                     edtCodigo : TCustomEdit;                               {* Edit do Código                              *}
                     edtDescri : TEditFocus;
                     qryConGen : TUniQuery;                                 {* Query                                       *}
                     Var chrKey: Char;                                      {* Key                                         *}
                     Var arrSel: TConsultasArray;                           {* Array de Consulta                           *}
                     blnConSim : Boolean = True;                            {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String  = 'Consultas de CST de Pis'): Boolean;
Begin
  Result := objFuncoes.fPesqCstPis(Self, edtCodigo, edtDescri, qryConGen, chrKey, arrSel, blnConSim, strTitulo);
End;

function fPesqCstCof(Self      : TForm;                                     {* Formulário                                  *}
                     edtCodigo : TCustomEdit;                               {* Edit do Código                              *}
                     edtDescri : TEditFocus;
                     qryConGen : TUniQuery;                                 {* Query                                       *}
                     Var chrKey: Char;                                      {* Key                                         *}
                     Var arrSel: TConsultasArray;                           {* Array de Consulta                           *}
                     blnConSim : Boolean = True;                            {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String  = 'Consultas de CST de Cofins'): Boolean;
begin
  Result := objFuncoes.fPesqCstCof(Self, edtCodigo, edtDescri, qryConGen, chrKey, arrSel, blnConSim, strTitulo);
end;

function fPesqCfgSis(Self      : TForm;
                     edtCodCfg : TCustomEdit;
                     edtDesCfg : TEditFocus;
                     qryConCfg : TUniQuery;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSim : Boolean = True;
                     strTitulo : String  = 'Cosulta de Configurações'): Boolean;
begin
  Result := objFuncoes.fPesqCfgSis(Self, edtCodCfg , edtDesCfg, qryConCfg, chrKey,                                  arrSel, blnConSim, strTitulo);
end;

function fPesqCfgTin(Self      : TForm;
                     edtCodCfg : TCustomEdit;
                     edtDesCfg : TEditFocus;
                     qryConCfg : TUniQuery;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSim : Boolean = True;
                     strTitulo : String  = 'Cosulta de Configurações da Tinta de Máquina'): Boolean; inline;
Begin
  Result := objFuncoes.fPesqCfgTin(Self, edtCodCfg , edtDesCfg, qryConCfg, chrKey,
                                   arrSel, blnConSim, strTitulo);

End;

function fCadEmp(strNomCampo: String): String; Overload;
begin
  Result := objFuncoes.fCadEmp(strNomCampo);
end;

function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery): String; Overload;
begin
  Result := objFuncoes.fCadEmp(strNomCampo, qryGenEmp);
end;

function fCampoExiste(const strTabela, strCampo: String): Boolean;
begin
  Result := objFuncoes.fCampoExiste(strTabela, strCampo);
end;

function fCriaDataSource(DataSet: TDataSet): TDataSource;
begin
  Result := objFuncoes.fCriaDataSource(DataSet);
end;

function fRetForFilialTodos(blnLista: Boolean = False): String;
begin
  Result := objFuncoes.fRetForFilialTodos(blnLista);
end;

function StringToFloat(str : String) : Extended;
begin
  Result := objFuncoes.StringToFloat(str);
end;

procedure pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery);inline;
begin
  objFuncoes.pAtribuiDisplayLabels(qryTabOri, qryTabDest);
end;

procedure pPesquisaCadAti(qryTabOri, qryTabela: TUniQuery; strCodAti: String);inline;
begin
  objFuncoes.pPesquisaCadAti(qryTabOri, qryTabela, strCodAti);
end;

procedure pPesquisaAbfIcm(qryTabOri, qryTabela: TUniQuery; strCodAbf: String; strEstado: String = '');inline;
begin
  objFuncoes.pPesquisaAbfIcm(qryTabOri, qryTabela, strCodAbf, strEstado);
end;

procedure pExecArquivo(strArquivo: String; Handle: THandle);inline;
begin
  objFuncoes.pExecArquivo(strArquivo, Handle);
end;

procedure pPesquisaCadPor(qryTabOri, qryTabela: TUniQuery; strCodPor: String);
begin
  objFuncoes.pPesquisaCadPor(qryTabOri, qryTabela, strCodPor);
end;

procedure pCarrega(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray);
begin
  objFuncoes.pCarrega(strText, edtDescri, arrLinha);
end;

function fRetAtividade(strCodAti: String): String;
begin
  Result := objFuncoes.fRetAtividade(strCodAti);
end;

function fPreInv(strAlias, strAliasImpFed,
  strPreInv: String): String;
begin
  Result := ObjFuncoes.fPreInv(strAlias, strAliasImpFed, strPreInv);
end;

function fPreInvTitulo(strPreInv: String): String;
begin
  Result := objFuncoes.fPreInvTitulo(strPreInv);
end;

function fRoundSql(const strCampo: String;
  const intDecimais: Integer): String;
begin
  Result := ObjFuncoes.fRoundSql(strCampo, intDecimais);
end;

function fRetornaSaldoCaixa(var dtaDtaCai: TDateTime;
  strCodEmp: String): Double;
begin
  Result := ObjFuncoes.fRetornaSaldoCaixa(dtaDtaCai, strCodEmp);
end;

function fCaixaTemMovimento(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = ''; blnSoma: Boolean = False; dtaDtaFin: TDateTime = 0): Boolean;
begin
  Result := ObjFuncoes.fCaixaTemMovimento(dtaDtaCai, qryCaixa, strCodEmp, blnSoma, dtaDtaFin);
end;

function fMovimentoFechamentoCaixa(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = ''): Boolean;
begin
  Result := ObjFuncoes.fMovimentoFechamentoCaixa(dtaDtaCai, qryCaixa, strCodEmp);
end;

procedure pRetornaUltimoFechamento(var fltUltFec: Double; var dtaDtaFec: TDateTime; strCodEmp: String = '');
Begin
  ObjFuncoes.pRetornaUltimoFechamento(fltUltFec, dtaDtaFec, strCodEmp);
End;

function fNecessitaFecharCaixa(blnFaturamento: Boolean; var dtaDtaLan: TDateTime; blnMostraMsg: Boolean = True; strCodEmp: String = ''): Boolean;
Begin
  Result := ObjFuncoes.fNecessitaFecharCaixa(blnFaturamento, dtaDtaLan, blnMostraMsg, strCodEmp);
End;

function fRetSiglaEmpresa(strCodEmp: String): String;
begin
  Result := objFuncoes.fRetSiglaEmpresa(strCodEmp);
end;

function fRetMascaraFone(opcPais: TPais): String;Inline;
begin
  Result := objFuncoes.fRetMascaraFone(opcPais);
end;

function fRetMascaraFonePais: String;Inline;
begin
  Result := objFuncoes.fRetMascaraFonePais;
end;

function fSQLCarregaEstoqu(dtaBase: TDateTime): String;
begin
  Result := ObjFuncoes.fSQLCarregaEstoqu(dtaBase);
end;

function fVerificaCampoPrcCmpImp(dtaBase: TDateTime): Boolean;
begin
  Result := ObjFuncoes.fVerificaCampoPrcCmpImp(dtaBase);
end;

function fRetornaComposicaoPadrao: String;
begin
  Result := ObjFuncoes.fRetornaComposicaoPadrao;
end;

function fPesqPesquisa(Self: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := ObjFuncoes.fPesqPesquisa( Self,
                                      edtCodigo,
                                      edtDescri,
                                      qryTabela,
                                      chrKey,
                                      arrSel,
                                      blnConSim );
end;

function fRetDebitoCliente(strCodCli: String): Double;
begin
  Result := ObjFuncoes.fRetDebitoCliente(strCodCli);
end;

function fRetDescCentroCusto(strCodCta: String): String;
begin
  Result := ObjFuncoes.fRetDescCentroCusto(strCodCta);
end;

function fExisteCheque(strDocume, strCodEmp: String; intSeqCon: Integer; qryCheques: TUniQuery): Boolean;
begin
  Result := ObjFuncoes.fExisteCheque(strDocume, strCodEmp, intSeqCon, qryCheques);
end;

function fDigQuantidade(strCaption, strLabel: String; Var intQtdDig: Integer;
    intMin: Integer = -MaxInt; intMax: Integer = MaxInt): Boolean;
begin
  Result := ObjFuncoes.fDigQuantidade(strCaption, strLabel, intQtdDig, intMin, intMax);
end;

function fFormataCEP(strCEP: String): String;
begin
  Result := ObjFuncoes.fFormataCEP(strCEP);
end;

function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime): TDateTime;
begin
  Result := ObjFuncoes.fAcertaDataParaDiaUtil(dtaOrigem);
end;

function fRetNomeCartao(strCodCar: String): String;
begin
  Result := ObjFuncoes.fRetNomeCartao(strCodCar);
end;

function fRetValorCfg(strCodCfg, strValCfg: String): String;
begin
  Result := ObjFuncoes.fRetValorCfg(strCodCfg, strValCfg);
end;



function fPesqCartao(Self: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim, blnSoAtiv, blnMostraDesconto,
  blnCadCar, blnEmpGer: Boolean): Boolean;
begin
  Result := ObjFuncoes.fPesqCartao(Self,
                                      edtCodigo,
                                      edtDescri,
                                      qryTabela,
                                      chrKey,
                                      arrSel,
                                      blnConSim,
                                      blnSoAtiv,
                                      blnMostraDesconto,
                                      blnCadCar,
                                      blnEmpGer);
end;

function fRetNomBandeira(strCodBan: String): String;
begin
  Result := ObjFuncoes.fRetNomBandeira(strCodBan);
end;

function fGetTIteBar(opcCriacaP: TOpcaoCriacao = opcFuncoes;
                       qryTabIteP: TUniQuery = Nil;
                       dbeCodBarP: TDBEditFocus = Nil;
                       dbeBarEmbP: TDBEditFocus = Nil;
                       dbeEmbalaP: TDBEditFocus = Nil;
                       wncLocCadP: TWincontrol  = Nil;
                       strCodIteP: String = ''): IIteBar;
begin
  Result := ObjFuncoes.fGetTIteBar(opcCriacaP, qryTabIteP, dbeCodBarP,
    dbeBarEmbP, dbeEmbalaP, wncLocCadP, strCodIteP);
end;

function fPesqCartaoBandeira(Self: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := ObjFuncoes.fPesqCartaoBandeira(Self,
                                             edtCodigo,
                                             edtDescri,
                                             qryTabela,
                                             chrKey,
                                             arrSel,
                                             blnConSim);
end;

function fVerificaImpressora(strNomeImpr: String): Boolean;
begin
  Result := ObjFuncoes.fVerificaImpressora(strNomeImpr);
end;

function fPergunta(strMensagem: String): Boolean;
begin
  result := ObjFuncoes.fPergunta(strMensagem);
end;

function fRetTopoEtiqueta(strTipEti: String): Integer;
begin
  Result := ObjFuncoes.fRetTopoEtiqueta(strTipEti);
end;

function fItemEstruturaIndustrial(strCodIte: String): Boolean;
begin
  result := ObjFuncoes.fItemEstruturaIndustrial(strCodIte);
end;

function fRetNomCor(strCodCor: String): String;
begin
  result := ObjFuncoes.fRetNomCor(strCodCor);
end;

function fPesqCores(Self      : TForm;
                    edtCodigo : TCustomEdit;
                    edtDescri : TEditFocus;
                    qryTabela : TUniQuery;
                    Var chrKey: Char;
                    Var arrSel: TConsultasArray;
                    blnConSim : Boolean = True;
                    strCodGra : String = ''): Boolean;
begin
  result := ObjFuncoes.fPesqCores(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim, strCodGra );
end;

function fPesqClaIPI(Self      : TForm;
                     edtClaIPI : TCustomEdit;
                     qryConIPI : TUniQuery;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSim : Boolean = True;
                     strTitulo : String  = 'Consulta de Classificação de IPI'): Boolean;
begin
  result := ObjFuncoes.fPesqClaIPI(Self, edtClaIPI, qryConIPI, chrKey, arrSel, blnConSim, strTitulo);
end;

function fPesqTabDinamica(Self : TForm; edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  Var chrKey: Char; Var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  result := ObjFuncoes.fPesqTabDinamica(Self, edtCodigo, edtDescri, qryTabela, chrKey, arrSel, blnConSim);
end;

function fPesqArmazem(Self : TForm; edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  Var chrKey: Char; Var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  result := ObjFuncoes.fPesqArmazem(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
end;

procedure pPesquisaCadCli(qryTabOri, qryTabela: TUniQuery; strCodCli: String;
  blnVerCnd: Boolean = True; blnVerCli: Boolean = False);
begin
  ObjFuncoes.pPesquisaCadCli(qryTabOri, qryTabela, strCodCli, blnVerCnd, blnVerCli);
end;

function fCriaAggregateField(cdsClient: TUniClientDataSet; strFieldName, strExpression: String;
    strDisplayFormat: String = ''; blnActive: Boolean = True): TAggregateField;
begin
  Result := ObjFuncoes.fCriaAggregateField(cdsClient,
                                            strFieldName,
                                            strExpression,
                                            strDisplayFormat,
                                            blnActive);
end;

procedure pZeraDigDuplic(var arrDuplicata: TarrDuplicata);
begin
  ObjFuncoes.pZeraDigDuplic(arrDuplicata);
end;

procedure pAdicionaCheques(qryCadChq: TDataSet; cdsCadChq: TUniClientDataSet);
begin
  ObjFuncoes.pAdicionaCheques(qryCadChq, cdsCadChq);
end;

function fGetTFuncoesEditorFast: IFuncoesEditorFast;
Begin
  Result := objFuncoes.fGetTFuncoesEditorFast;
End;

function fGetTOrdenacao(Owner: TComponent; strCampos: String; intCodEtiP: Integer): IOrdenacao;
Begin
  Result := objFuncoes.fGetTOrdenacao(Owner, strCampos, intCodEtiP);
End;

function fMskDigitos(intDigitos: Integer): String;
Begin
  Result := objFuncoes.fMskDigitos(intDigitos);
End;

function fPesqCamsposLayout(Self     : TForm;
                            edtCodigo: TCustomEdit;
                            edtDescri: TEditFocus;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            strFiltro: String;
                            intPosCam: Integer = -1;
                            blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqCamsposLayout(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, strFiltro, intPosCam, blnConSim);
End;

function fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean;
Begin
  Result := objFuncoes.fInsereProCod(strNomTab, blnCodAut);
End;

function fDescontoClienteProfissional(strCodCli: String): Boolean;
Begin
  Result := objFuncoes.fDescontoClienteProfissional(strCodCli);
End;

Procedure pSetaNumPedCom(edtNumPed: TEditFocus);
Begin
  objFuncoes.pSetaNumPedCom(edtNumPed);
End;

function fSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; intQtdCol: Integer = 0): String;
Begin
  Result := objFuncoes.fSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli, intQtdCol);
End;

function fRetSeqConCadRec(strNumDup: String;
                          strEspDoc: String;
                          strParcel: String;
                          strCodEmp: String;
                          strCodCli: String;
                          strOriF11: String): String;
Begin
  Result := objFuncoes.fRetSeqConCadRec(strNumDup, strEspDoc, strParcel,
    strCodEmp, strCodCli, strOriF11);
End;

function fRetLocFisicaEmpEmissora(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String;
Begin
  Result := objFuncoes.fRetLocFisicaEmpEmissora(strFieldNumLot, strFieldCodIte, strFieldCodEmp, blnVirgula);
End;

function fRetDesFisicaEmpEmissora(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String;
Begin
  Result := objFuncoes.fRetDesFisicaEmpEmissora(strFieldNumLot, strFieldCodIte, strFieldCodEmp, blnVirgula);
End;

function fRetLocFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String;
Begin
  Result := objFuncoes.fRetLocFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp, blnVirgula);
End;

function fRetDesFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String;
Begin
  Result := objFuncoes.fRetDesFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp, blnVirgula);
End;

function fImprimirCabecalhoDocEmpresaPedidoCD(strNumFat, strTipFat, strEmpFat: String; Var strEmpPed: String): Boolean;
Begin
  Result := objFuncoes.fImprimirCabecalhoDocEmpresaPedidoCD(strNumFat, strTipFat, strEmpFat, strEmpPed);
End;

function fMarcarPedidoComoImpresso(strNumDoc, strEspDoc, strCodEmp: String; blnDocSep, blnImpExpedicao: Boolean): Boolean;
begin
  Result := objFuncoes.fMarcarPedidoComoImpresso(strNumDoc, strEspDoc, strCodEmp, blnDocSep, blnImpExpedicao);
end;

function fExecutaSQL(strSQL: String): Boolean;
Begin
  Result := objFuncoes.fExecutaSQL(strSQL);
End;

function fRetMltVenItem(const strCodIte: String): Double;
Begin
  Result := objFuncoes.fRetMltVenItem(strCodIte);
End;

function fRetiraZerosEsquerda(strDado: String): String;
Begin
  Result := objFuncoes.fRetiraZerosEsquerda(strDado);
End;

function fRetNomeMarca(strCodigo: String): String;
Begin
  Result := objFuncoes.fRetNomeMarca(strCodigo);
End;

function fRetNomTabAuxMov(strNomTab: String): String;
Begin
  Result := objFuncoes.fRetNomTabAuxMov(strNomTab);
End;

function fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes: String): String;
Begin
  Result := objFuncoes.fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes);
End;

function fGetTMadeireira: IMadeireira;
Begin
  Result := objFuncoes.fGetTMadeireira;
End;

function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; fltValDup: Double;
  fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double;
begin
  Result := ObjFuncoes.fCalculaJurosCadCtr(dtaDtaVen, fltValDup, fltPerJur,
                                                  fltPerMul, intTolerancia);
end;

function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; strDtaPag: String; fltValDup: Double;
  fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double;
begin
  Result := ObjFuncoes.fCalculaJurosCadCtr(dtaDtaVen, strDtaPag, fltValDup, fltPerJur,
                                                  fltPerMul, intTolerancia);
end;

function fRetNomeBancoSelec(Const strCodBco: String): String;
begin
  Result := ObjFuncoes.fRetNomeBancoSelec(strCodBco);
end;

function fGetTFinanceira(AOwner: TComponent): IFinanceira;
Begin
  Result := ObjFuncoes.fGetTFinanceira(AOwner);
End;

function fRetDesRegiao(strCodReg: String): String;
begin
  Result := ObjFuncoes.fRetDesRegiao(strCodReg);
end;

function fCriaDiretorio(strPath: String): Boolean;
Begin
  Result := ObjFuncoes.fCriaDiretorio(strPath);
End;

function fRetFantasiaEmpresa(strCodEmp: String = ''): String;
Begin
  Result := ObjFuncoes.fRetFantasiaEmpresa(strCodEmp);
End;

function fGetTCamposUso: ICamposUso;
Begin
  Result := ObjFuncoes.fGetTCamposUso;
End;

function fGetTFuncMacro: IFuncMacro;
Begin
  Result := ObjFuncoes.fGetTFuncMacro;
End;

function fRetSQLCGCCPFFormatado(strCampoCGCCPF, strCampoC_G_C_: String): String;
Begin
  Result := ObjFuncoes.fRetSQLCGCCPFFormatado(strCampoCGCCPF, strCampoC_G_C_);
End;

function fInformacaoAdicionalEtiquetaItens: String;
Begin
  Result := ObjFuncoes.fInformacaoAdicionalEtiquetaItens;
End;

function fPesqBanco(Self: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := ObjFuncoes.fPesqBanco(Self, edtCodigo, edtDescri, qryTabela,
                                    chrKey, arrSel, blnConSim);
end;

function fVer_Banco_Carteira(strCodBan, strChave: String; Var strBanRet: String;
                             Var intCarRet: Integer;
                             blnVeioImpBol: Boolean = True): Boolean;
begin
  Result := ObjFuncoes.fVer_Banco_Carteira(strCodBan, strChave, strBanRet, intCarRet,
                                           blnVeioImpBol);
end;

function fPesqLayout(Self     : TForm;
                     edtCodigo: TCustomEdit;
                     edtDescri: TEditFocus;
                     qryTabela: TUniQuery;
                     strTipImp: String;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqLayout(Self, edtCodigo, edtDescri, qryTabela, strTipImp,
    chrKey, arrSel, blnConSim);
End;

procedure pCnfEtiqueta(tipTipEti: TTiposEtiqueta = etiVazio);
Begin
  objFuncoes.pCnfEtiqueta(tipTipEti);
End;

function fArqIniAutban(ReadWrite:Integer; NomChave, NomSecao, Conteudo: String): String;
begin
  Result := ObjFuncoes.fArqIniAutban(ReadWrite, NomChave, NomSecao, Conteudo);
end;

function fFormataCCusto(strValor: String): String;
begin
  Result := ObjFuncoes.fFormataCCusto(strValor);
end;

function fAtuCfgSis(strCamCfg, strValCfg: String; strCodEmp: String = ''): Boolean;
begin
  Result := ObjFuncoes.fAtuCfgSis(strCamCfg, strValCfg, strCodEmp);
end;

function fFilaExiste(strFila: String): Boolean;
Begin
  Result := objFuncoes.fFilaExiste(strFila);
End;

function fGetMenu(strTitulo: String;
                  arrOpcoes: Array Of String;
                  intOpcao: Integer;
                  blnSaiComEsc: Boolean = False): Integer;
Begin
  Result := objFuncoes.fGetMenu(strTitulo, arrOpcoes, intOpcao, blnSaiComEsc);
End;

function fRetNatOpe(strCodCfo: String): String;
begin
  Result := ObjFuncoes.fRetNatOpe(strCodCfo);
end;

function fInc(var intValor: Integer): Integer;
begin
  Result := ObjFuncoes.fInc(intValor);
end;

function fPesqCFOP(Self: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := ObjFuncoes.fPesqCFOP(Self,
                                 edtCodigo,
                                 edtDescri,
                                 qryTabela,
                                 chrKey,
                                 arrSel,
                                 blnConSim);
end;

function fRetTelaSelecaoImp(Var oleDados: OleVariant; var strOrdenacao: string; var bVerificarEmail: boolean): Boolean;
begin
  Result := ObjFuncoes.fRetTelaSelecaoImp(oleDados, strOrdenacao, bVerificarEmail);
end;

procedure pSetaParamPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus;
  qryRelatorio: TUniQuery; strParIni, strParFin: String);
begin
  ObjFuncoes.pSetaParamPeriodo(mskDtaIni,mskDtaFin, qryRelatorio,
    strParIni, strParFin);
end;

procedure pRetDadosItem(strCodIte, strGrupo: String; Var strNome, strRefere,
  strMarca, strUnidad: String); Overload;
begin
  ObjFuncoes.pRetDadosItem(strCodIte, strGrupo, strNome, strRefere,strMarca, strUnidad);
end;

procedure pRetDadosItem(strCodIte: String; Var strNome, strRefere,
  strMarca, strUnidad: String); Overload;
begin
  ObjFuncoes.pRetDadosItem(strCodIte, strNome, strRefere,strMarca, strUnidad);
end;

procedure pCalcSaldoInicialItens(Var fltSaldoIni: Double;
                                     dtaDtaBal,
                                     dtaDtaIni: TDateTime;
                                     strCodIte: String;
                                     strCodEmp: String;
                                     blnEntFut: Boolean = True;
                                     strNumLot: String = '');
begin
  ObjFuncoes.pCalcSaldoInicialItens(fltSaldoIni, dtaDtaBal, dtaDtaIni, strCodIte,
    strCodEmp, blnEntFut, strNumLot);
end;

procedure pUltimaCompra(strCodIte, strCodEmp, strAnoMes: String; chrOpcInv: Char;
  var dtaUltComp: TDate; var strNumDoc: String);
begin
  ObjFuncoes.pUltimaCompra(strCodIte, strCodEmp, strAnoMes, chrOpcInv, dtaUltComp, strNumDoc);
end;

procedure pAtuVarGlobaisSimples;
begin
  ObjFuncoes.pAtuVarGlobaisSimples;
end;

procedure pCarregaTabPre(cbxTabPre: TComboBox); overload;
begin
  ObjFuncoes.pCarregaTabPre(cbxTabPre);
end;

procedure pCarregaTabPre(cbxTabPre: TDBComboBoxFocus); overload;
begin
  ObjFuncoes.pCarregaTabPre(cbxTabPre);
end;

procedure pRetListaMesAno(stlLista : TStrings ; intQtdReg : Integer = 24; blnLimpaLista : Boolean = True);
begin
  ObjFuncoes.pRetListaMesAno(stlLista, intQtdReg, blnLimpaLista);
end;

function fGetTipoAbfFornecedor(const strCodFor: String): String;
begin
  Result := ObjFuncoes.fGetTipoAbfFornecedor(strCodFor);
end;

function fGetTipoAbfCliente(const strCodCli: String): String; Inline;
begin
  Result := ObjFuncoes.fGetTipoAbfCliente(strCodCli);
end;

function fRetEnderecoEmpresa(strCodEmp: String): String;
begin
  Result := ObjFuncoes.fRetEnderecoEmpresa(strCodEmp);
end;

function fImprimeEtiqueta(prmDllRel: Pointer; strNomFun: String = 'fimprimeetiquetas'): Boolean;
begin
  Result := ObjFuncoes.fImprimeEtiqueta(prmDllRel, strNomFun);
end;

function fRetDesAbfPis(strAbfPis: String): String;
begin
  Result := ObjFuncoes.fRetDesAbfPis(StrAbfPis);
end;

function fRetDesAbfCof(strAbfCof: String): String;
begin
  Result := ObjFuncoes.fRetDesAbfCof(strAbfCof);
end;

function fRetDesCstPis(strCstPis: String): String;
begin
  Result := ObjFuncoes.fRetDesCstPis(strCstPis);
end;

function fRetDesCstCof(strCstPis: String): String; Inline;
begin
  Result := ObjFuncoes.fRetDesCstCof(strCstPis);
end;

function fPesqECF(Self: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  Result := ObjFuncoes.fPesqECF(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim );
end;

function fPesqLocFisica(Self: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim: Boolean = true): Boolean;
begin
  Result := ObjFuncoes.fPesqLocFisica(Self, edtCodigo, edtDescri, qryTabela, chrKey,
    arrSel, blnConSim);
end;

function fPesqLoteItens(Self : TForm; edtNumLote : TEditFocus; edtCodIte  : TEditFocus;
  intDecUni : Integer; qryTabela : TUniQuery; Var chrKey : Char; Var arrSel : TConsultasArray;
  blnConSim  : Boolean = True): Boolean;
begin
  Result := ObjFuncoes.fPesqLoteItens(Self, edtNumLote, edtCodIte, intDecUni,
    qryTabela, chrKey, arrSel, blnConSim);
end;

function fPesqPedidoCompra(Self : TForm; edtCodPed : TCustomEdit; qryTabela : TUniQuery;
  Var chrKey : Char; Var arrSel : TConsultasArray; Var strDoc : String; strCodEmp  : String;
  intIndice  : Integer; blnConSim  : Boolean = True; objFrmPnl  : TPanelCx = Nil; strLitGal  : String = '3.600';
  strTitulo  : String = 'Consulta de Pedidos de Compra'): Boolean;
begin
  Result := ObjFuncoes.fPesqPedidoCompra(Self , edtCodPed, qryTabela, chrKey, arrSel, strDoc, strCodEmp,
    intIndice, blnConSim, objFrmPnl, strLitGal,  strTitulo);
end;

function fPesqAjuste(Self : TForm; edtNumAju : TCustomEdit; qryConAju : TUniQuery; Var chrKey: Char;
                       Var arrSel: TConsultasArray; strCodEmp : String; blnConSim : Boolean = True;
                       strTitulo : String = 'Consulta de Ajustes de Estoque'): Boolean;
begin
  Result := ObjFuncoes.fPesqAjuste(Self, edtNumAju, qryConAju , chrKey, arrSel, strCodEmp,
    blnConSim, strTitulo);
end;

function fPesqProdAcabado(Self : TForm; edtCodAca : TCustomEdit; edtDesAca : TEditFocus;
  qryConAca : TUniQuery; Var chrKey: Char; Var arrSel: TConsultasArray; strEmpAca : String;
  blnConSim : Boolean = True; strTitulo : String  = 'Consulta de Produtos Acabados'; strEmpEst : String = ''): Boolean;
begin
  Result := ObjFuncoes.fPesqProdAcabado(Self, edtCodAca, edtDesAca, qryConAca,
    chrKey, arrSel, strEmpAca , blnConSim, strTitulo, strEmpEst);
end;

function fPesqTabelaPreco(Self : TForm; edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  Var chrKey: Char; Var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;
begin
  Result := ObjFuncoes.fPesqTabelaPreco(Self, edtCodigo, edtDescri, qryTabela,
    chrKey, arrSel, blnConSim);
end;

function fPesqEntregasRotasRegiao(Self      : TForm;
                                  edtCodigo : TCustomEdit;
                                  edtDescri : TEditFocus;
                                  qryTabela : TUniQuery;
                                  Var chrKey: Char;
                                  Var arrSel: TConsultasArray;
                                  blnConSim : Boolean = True;
                                  strCodCid : String = '';
                                  strCliCep : String = '';
                                  blnFiltroPorData : Boolean = True): Boolean;
begin
  Result := objFuncoes.fPesqEntregasRotasRegiao(Self, edtCodigo, edtDescri,
    qryTabela, chrKey, arrSel, blnConSim, strCodCid, strCliCep, blnFiltroPorData);
end;

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
begin
  Result := objFuncoes.fConsulta(arrSql,
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

function fGetStrCodigos(edtCodigo: TEditFocus; arrLinha: TConsultasArray; blnQuoted: Boolean = False): String;
begin
  Result := ObjFuncoes.fGetStrCodigos(edtCodigo, arrLinha, blnQuoted);
end;

function fMostrarFatorConversaoMadeira(strCodIte: string): boolean;
begin
  Result := ObjFuncoes.fMostrarFatorConversaoMadeira(strCodIte);
end;

function fValidaEcf(strCodEcf: String;
  var strModelo: String): Boolean;
begin
  Result := ObjFuncoes.fValidaEcf(strCodEcf, strModelo);
end;

function fRetMesExtenso(intMes: Integer): String;
begin
  Result := ObjFuncoes.fRetMesExtenso(intMes);
end;

function fRetDesAbfIcm(strCodAbf: String): String;
begin
  Result := ObjFuncoes.fRetDesAbfIcm(strCodabf);
end;

function fDigEmail(var strDestinatario, strEmailDestinatario: String): Boolean; inline;
begin
  Result := ObjFuncoes.fDigEmail(strDestinatario, strEmailDestinatario);
end;

function fRetPreComMenosDescForn(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet = Nil;
    strCALSOP: String = ''): Double;
begin
  Result := ObjFuncoes.fRetPreComMenosDescForn(strCodIte, strCodEmp, cdsIteGer, strCALSOP);
end;

function fRetNomLocFisica(const strCodLoc: String): String;
begin
  Result := ObjFuncoes.fRetNomLocFisica(strCodLoc);
end;

function fRetNumLoteConsulta(const strNumLot: String): String;
begin
  Result := ObjFuncoes.fRetNumLoteConsulta(strNumLot);
end;

function fGetTCadLot(Owner: TComponent; qryCadTab: TUniQuery = Nil): ICadLot;
begin
  Result := ObjFuncoes.fGetTCadLot(Owner, qryCadTab);
end;

function fGetTFiltrosRelatorio: IFiltrosRelatorio;
begin
  Result := ObjFuncoes.fGetTFiltrosRelatorio;
end;

function fRetConsumidorDocumento(strNumDoc, strEspDoc, strCodEmp: String): String;
begin
  Result := ObjFuncoes.fRetConsumidorDocumento(strNumDoc, strEspDoc, strCodEmp);
end;

function fRetGrupoItem(strCodIte: String): String;
begin
  Result := ObjFuncoes.fRetGrupoItem(strCodIte);
end;

function fRetornaCndPag(arrDatas: TDateArray; dtaDtaBas: TDateTime): String; Overload;
begin
  Result := ObjFuncoes.fRetornaCndPag(arrDatas, dtaDtaBas);
end;

function fRetornaCndPag(const arrDuplicata: TarrDuplicata; dtaDtaBas: TDateTime): String; Overload;
begin
  Result := ObjFuncoes.fRetornaCndPag(arrDuplicata, dtaDtaBas);
end;

function fRetSomenteNumeros(strTexto: String): String;
begin
  Result := ObjFuncoes.fRetSomenteNumeros(strTexto);
end;

function fRetNomeSoGrupo(strCodigo: String): String;
begin
  Result := ObjFuncoes.fRetNomeSoGrupo(strCodigo);
end;

function fRetLitros(strCodIte: String): Double;
begin
  Result := ObjFuncoes.fRetLitros(strCodIte);
end;

function fRetNomProdutoAcabado(strCodIte, strCodEmp: String ; strCodEmpAca : String = ''): String;
begin
  Result := ObjFuncoes.fRetNomProdutoAcabado(strCodIte, strCodEmp, strCodEmpAca);
end;

function fRetNomTabelaDinamica(strCodTab: String): String;
begin
  Result := ObjFuncoes.fRetNomTabelaDinamica(strCodTab);
end;

Function fSQLParam(edtValor: TCustomEdit; strNomCam: String; strNomPar: String = ''; blnLike: Boolean = False): String;
begin
  Result := ObjFuncoes.fSQLParam(edtValor, strNomCam, strNomPar, blnLike);
end;

function fSQLParamPerido(mskDtaIni: TMaskEditFocus; strNomCam: String;
                           strParIni: String = 'DTAINI';
                           strParFin: String = 'DTAFIN'): String;
begin
  Result := ObjFuncoes.fSQLParamPerido(mskDtaIni, strNomCam, strParIni, strParFin);
end;

function fRetNomeArmazem(Const strCodAmz: String): String;
begin
  Result := ObjFuncoes.fRetNomeArmazem(strCodAmz);
end;

function fRetCodFornecedorTabelaPreco(strTabPre: String): String;
begin
  Result := ObjFuncoes.fRetCodFornecedorTabelaPreco(strTabPre);
end;

function fRetNomeTabelaPreco(strCodTab: String): String;
begin
  Result := ObjFuncoes.fRetNomeTabelaPreco(strCodTab);
end;

function fCheckParent(Sender, Parent: TWinControl): Boolean;
begin
  Result := ObjFuncoes.fCheckParent(Sender, Parent);
end;

function fGetConfiguracao : IConfiguracao;
begin
  Result := ObjFuncoes.fGetConfiguracao;
end;

function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): Double;
begin
  Result := ObjFuncoes.fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal);
end;

function fRetNomTabelaPreco(strCodTab: String): String;
begin
  Result := ObjFuncoes.fRetNomTabelaPreco(strCodTab);
end;

function fCalculaPrecoCompraLiq(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
                                  fltDesf04, fltDesf05, fltDesf06: Double;
                                  blnPreDol: Boolean = False): Double; overload;
begin
  Result := ObjFuncoes.fCalculaPrecoCompraLiq(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
                                  fltDesf04, fltDesf05, fltDesf06, -1, blnPreDol);
end;

function fValidaMesAno(mskMesAno: TMaskEditFocus; strInfErr: String): Boolean; Overload;
begin
  Result := ObjFuncoes.fValidaMesAno(mskMesAno, strInfErr);
end;


function fValidaMesAno(mskMesAno: String; strInfErr: String): Boolean; Overload;
begin
  Result := ObjFuncoes.fValidaMesAno(mskMesAno, strInfErr);
end;

function fRetTipoDepartamento(strCodigo, strTipo: String): String;Inline;
begin
  Result := ObjFuncoes.fRetTipoDepartamento(strCodigo, strTipo);
end;

function fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean): String;
begin
  Result := ObjFuncoes.fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp, blnCheckLibPcm, blnFiltraTE);
end;

function fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean): String;
Begin
  Result := ObjFuncoes.fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp, blnCheckLibPcm);
End;

function fSQLCamposQuantidadePendenteCompra(blnSoma, blnFiltraTE, blnLibPcm: Boolean; strAliasSALPDC: String): String;
Begin
  Result := ObjFuncoes.fSQLCamposQuantidadePendenteCompra(blnSoma, blnFiltraTE, blnLibPcm, strAliasSALPDC);
End;

function fCalculaPrecoCompraLiq(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet): Double; overload;
begin
  Result := ObjFuncoes.fCalculaPrecoCompraLiq(strCodIte, strCodEmp, cdsIteGer);
end;

procedure pRetFilasImpressao(Var arrFilas: TarrFilas);
begin
  ObjFuncoes.pRetFilasImpressao(arrFilas);
end;

procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport);
begin
  TCfgRel.pPrintReport(strNomPro, strDesPro, strNomImp, AReport);
end;

procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TRLReport);
begin
  TCfgRel.pPrintReport(strNomPro, strDesPro, strNomImp, AReport);
end;

procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport);
begin
  TCfgRel.pPreviewReport(strNomPro, strDesPro, AReport);
end;

procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TRLReport; ASetup: TRLPreviewSetup);
begin
  TCfgRel.pPreviewReport(strNomPro, strDesPro, AReport, ASetup);
end;

function fRetTipoImpressora(var strTipImp: String): Boolean;
begin
  Result := ObjFuncoes.fRetTipoImpressora(strTipImp);
end;

function fAcertaMaskTel(strFone: String): String;
begin
  Result := ObjFuncoes.fAcertaMaskTel(strFone);
end;

function fEnviarEMailComAnexo(const Para, Assunto, Texto, Arquivo: String): Integer;
begin
  Result := objFuncoes.fEnviarEMailComAnexo(Para, Assunto, Texto, Arquivo);
end;

function fEnviarEmail(strTitulo, strArquivo, strDestinatario: String): Boolean; inline;
begin
  Result := objFuncoes.fEnviarEmail(strTitulo, strArquivo, strDestinatario);
end;

function fDesconsiderarNaQtdLimDaPromoItensUnitarMaior: Boolean;
begin
  Result := objFuncoes.fDesconsiderarNaQtdLimDaPromoItensUnitarMaior;
end;

function fClienteTemCndPagAssociado(strCodCli: String): Boolean;
Begin
  Result := objFuncoes.fClienteTemCndPagAssociado(strCodCli);
End;

function fEhPedidoRefenciadoHaUmOrcamento(strNumDoc, strCodEmp: String;
                                          Var strNumOrcRef: String; Var strEmpOrcRef: String): Boolean;
Begin
  Result := objFuncoes.fEhPedidoRefenciadoHaUmOrcamento(strNumDoc, strCodEmp, strNumOrcRef, strEmpOrcRef);
End;

function fExisteLote(strNumLot: String; strCodIte: String; strCodEmp: String): Boolean;
Begin
  Result := objFuncoes.fExisteLote(strNumLot, strCodIte, strCodEmp);
End;

function fComplementoWhereSQLPosContabilReceber(strCodEmp: String): String;
Begin
  Result := objFuncoes.fComplementoWhereSQLPosContabilReceber(strCodEmp);
End;

function fComplementoWhereSQLPosContabilPagar(edtCodEmpresa: TEditFocus;
                                              arrEmp: TConsultasArray;
                                              blnFiltrouPortador: Boolean;
                                              edtCodPortador: TEditFocus;
                                              arrPor: TConsultasArray;
                                              strCodEmp: String = '';
                                              blnSomenteJurosEDescontos: Boolean = False): String;
Begin
  Result := objFuncoes.fComplementoWhereSQLPosContabilPagar(edtCodEmpresa,
                                                            arrEmp,
                                                            blnFiltrouPortador,
                                                            edtCodPortador,
                                                            arrPor,
                                                            strCodEmp,
                                                            blnSomenteJurosEDescontos);
End;

function fComplementoWhereSQLPosContabilCartao(edtCodEmpresa: TEditFocus;
                                               arrEmpresa: TConsultasArray;
                                               strCodEmp: String = ''): String;
Begin
  Result := objFuncoes.fComplementoWhereSQLPosContabilCartao(edtCodEmpresa,
                                                             arrEmpresa,
                                                             strCodEmp);
End;

function fComplementoWhereSQLPosContabilCheque(strCodEmp: String): String;
Begin
  Result := objFuncoes.fComplementoWhereSQLPosContabilCheque(strCodEmp);
End;

function fIsValidDate(Sender: TWinControl): Boolean;
begin
  Result := objFuncoes.fIsValidDate(Sender); //objFuncoes.fIsValidDate(Sender);
end;

function fRetDadosEmitente(strNumCgc: String;
                                   Var strNomEmi,
                                   strEndere,
                                   strTele01: String): Boolean;
Begin
  Result := objFuncoes.fRetDadosEmitente(strNumCgc, strNomEmi, strENdere, strTele01);
End;

function fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;
Begin
   Result := objFuncoes.fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial);
End;

function fRetornaAliquotaIcmsInternaDoEstado(strEstado: String): Double;
Begin
  Result := objFuncoes.fRetornaAliquotaIcmsInternaDoEstado(strEstado)
End;

function fRetDesMotivoAtend(strCodMot: String): String;
Begin
  Result := objFuncoes.fRetDesMotivoAtend(strCodMot);
End;

function fPesqMotivosAtend(Self     : TForm;
                           edtCodigo: TCustomEdit;
                           edtDescri: TEditFocus;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True): Boolean;
Begin
  Result := objFuncoes.fPesqMotivosAtend(Self, edtCodigo, edtDescri, qryTabela, chrKey, arrSel, blnConSim);
End;

function fNow: TDateTime;
begin
  Result := VS_Date + Time();
end;

function fCarregaCartoesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
begin
  Result := ObjFuncoes.fCarregaCartoesTransferidos(intSeqCon,strEmpRcx,dtaDtaCad,blnNaoTransf);
end;

function fCarregaChequesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
begin
 Result := ObjFuncoes.fCarregaChequesTransferidos(intSeqcon,strEmpRcx,dtaDtaCad,blnNaoTransf);
end;

function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
Begin
  Result := ObjFuncoes.fUsaRotinaWMS(strCodEmp);
End;

function fUsaSat(strCodEmp : String):Boolean;
Begin
  Result := ObjFuncoes.fUsaSat(strCodEmp);
End;

function fEhFeriado(dtaData: TDateTime; strCodCid: String = ''): Boolean;
begin
  Result := ObjFuncoes.fEhFeriado(dtaData, strCodCid);
end;

function fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal,
             fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double): Double;
begin
  Result := ObjFuncoes.fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal,
             fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP);
end;

function fRetornaSaldoDisponivel(strCodIte: String; blnCnvMl : Boolean = False;
                                   blnFaturamento: Boolean = True; strNumLot : String = '';
                                   blnConsiderarPedidos : Boolean = True;
                                   strCodEmp: String = ''; strNumPedAlt: String = '';
                                   blnConsiderarPedidoCompraPendente: Boolean = False;
                                   blnConsiderarCfgCalSal: Boolean = True;
                                   blnConsiderarOrdemProducao: Boolean = True): Double;
begin
  Result := ObjFuncoes.fRetornaSaldoDisponivel(strCodIte, blnCnvMl, blnFaturamento, strNumLot, blnConsiderarPedidos, strCodEmp, strNumPedAlt, blnConsiderarPedidoCompraPendente, blnConsiderarCfgCalSal, blnConsiderarOrdemProducao)
end;

function fRetornaInfMedVIDRO(blnDoisPontos: Boolean = False; blnAbreviadoComprimento: Boolean = False;blnMaximo : Boolean = False; blnMensagem :Boolean = False;blnAbreviadoAltura : Boolean = False) : String;
begin
  Result := ObjFuncoes.fRetornaInfMedVIDRO(blnDoisPontos, blnAbreviadoComprimento, blnMaximo, blnMensagem, blnAbreviadoAltura );
end;

function fFormataCasaDecimalVIDRO(strMascaraDefault : Variant) : Variant;
begin
  Result := ObjFuncoes.fFormataCasaDecimalVIDRO(strMascaraDefault);
end;

function fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
begin
  Result := objFuncoes.fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli, blnCliBalcao, blnCliSegura);
end;

procedure pRemoveAcentoObjRelFortes(Var obj: TForm);
  Var
    intContador: Integer;
begin
  For intContador := 0 To obj.ComponentCount -1 Do
  Begin
    If (obj.Components[intContador] Is TRLLabel) Then
    Begin
      TRLLabel(obj.Components[intContador]).Caption := fRemoveAcento(TRLLabel(obj.Components[intContador]).Caption);
    End;
  End;
end;

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
  Result := objFuncoes.IIF(lTest, vExpr1, vExpr2);
end;

function fReservaParametros: IReservaParametros;
begin
  Result := objFuncoes.fReservaParametros();
end;

function fSaldoReservado(AParams: IReservaParametros): ISaldoReservado;
begin
  Result := objFuncoes.fSaldoReservado(AParams);
end;

function fSQLIn(objCodigo: TObject;
                arrLinha: TConsultasArray;
                strNomCampo,
                strNomPar: String;
                blnSemAND: Boolean = False;
                blnNegar: Boolean = False;
                strCodigo: String = ''): String;
begin
  Result := objFuncoes.fSQLIn(objCodigo, arrLinha, strNomCampo, strNomPar,
    blnSemAND, blnNegar, strCodigo);
end;

function fCommaText(stlListSelecao: TStringList;
                    blnQuoted: Boolean = False;
                    strSeparator : String = ', '): String;
begin
  Result := objFuncoes.fCommaText(stlListSelecao, blnQuoted, strSeparator);
end;

function fParametrosEntregaFutura: IParamEF;
begin
  Result := objFuncoes.fParametrosEntregaFutura();
end;

function fEntregaFutura(AParams: IParamEF): IEntregaFutura;
begin
  Result := objFuncoes.fEntregaFutura(AParams);
end;

function fGetSQLSomaCamposEntregaFutura(const AAlias: String = 'G';
                                        AFaturamento: Boolean = False;
                                        ALote: Boolean = False): String;
begin
  Result := objFuncoes.fGetSQLSomaCamposEntregaFutura(AAlias, AFaturamento, ALote);
end;

function fEmpresaTemAcessoPortador(strCodPor: String; strCodEmp: String = ''): Boolean;
begin
  Result := objFuncoes.fEmpresaTemAcessoPortador(strCodPor, strCodEmp);
end;

Procedure pSetaCodIte(edtCodIte: TEditFocus);
Begin
  objFuncoes.pSetaCodIte(edtCodIte);
End;

Procedure pSetaCodIte(edtCodIte: TStringField);
Begin
  objFuncoes.pSetaCodIte(edtCodIte);
End;

function fTamCodIte: Integer;
Begin
  Result := objFuncoes.fTamCodIte;
End;

initialization
  EnableUniSQL := False;

Finalization

end.
