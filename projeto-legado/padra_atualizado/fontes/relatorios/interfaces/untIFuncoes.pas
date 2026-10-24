unit untIFuncoes;

interface

uses DB, Uni, Classes, Forms, untTypesSistema, Vcl.Controls,DBComboBoxFocus,
  BitBtnLockedIncrem, StdCtrls, EditFocus, untClassPanelCx, ComboBoxFocus,
  untITintasDeMaquina, UniClientDataSet, DBEditFocus, MaskEditFocus, untICamGer,
  untIValorRecebido, untIConfTinta, untIControlePagtoFunc, untIFastPrint,
  untIMetAno, untFuncoesGenerica, untIFuncoesEditorFast, untIIteBar,
  untIOrdenacao, untIMadeireira, untIFinanceira, untICamposUso, untIFuncMacro,
  untIDocumentos, untIZClient, untICadLote, untIFiltrosRelatorio,
  RLReport, RLPreviewForm,
  untIConfiguracao, untIMesesGiro, frxClass, Graphics, untConstantes,
  untIFatReservaSaldo, untIFatEntregaFutura;

Type
   IUltConsultas = Interface
   ['{E625C50B-0FB7-477C-8E65-222051C5D395}']
     procedure pChecarIntegridade;

     procedure SetEstado(dsEstado: TDataSetState);
     function GetEstado: TDataSetState;

     procedure SetTabela(strTabela: String);
     function GetTabela: String;

     procedure SetRegistro(bkmRegistro: TBookmark);
     function GetRegistro: TBookmark;

     procedure SetSelect(strSelect: String);
     function GetSelect: String;

     procedure SetIndice1(strIndice: String);
     function GetIndice1: String;

     procedure SetIndice2(strIndice: String);
     function GetIndice2: String;

     procedure SetIndice3(strIndice: String);
     function GetIndice3: String;

     procedure SetItemIndex(intItemIndex: Integer);
     function GetItemIndex: Integer;

     procedure SetItemSaldo(blnItemSaldo: Boolean);
     function GetItemSaldo: Boolean;

     procedure SetComplChave(strComplChave: String);
     function GetComplChave: String;

     procedure pLimparCampos;
     procedure Novo;
     procedure Grava;
     procedure Limpar(strNomeTabela: String; strComplChave: String = '');

     function fRetRegistro(Const strNomeTabela: String; strComplChave: String = '';
        blnAtualizaDados: Boolean = True): Boolean;

     property Estado: TDataSetState read GetEstado write SetEstado;
     property Tabela: String read GetTabela write SetTabela;
     property ComplChave: String read GetComplChave write SetComplChave;
     property Registro: TBookmark read GetRegistro write SetRegistro;
     property Select: String read GetSelect write SetSelect;
     property Indice1: String read GetIndice1 write SetIndice1;
     property Indice2: String read GetIndice2 write SetIndice2;
     property Indice3: String read GetIndice3 write SetIndice3;
     property ItemIndex: Integer read GetItemIndex write SetItemIndex;
     property ItemSaldo: Boolean read GetItemSaldo write SetItemSaldo;
   End;

  IFuncoes = interface
  ['{9AD0BBA2-B1D1-4C40-B6F6-262B1393A553}']
    function fTamDocCadRec: Integer;
    function fCriaClientDataSetClientesDebitos : TUniClientDataSet;
    function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
    function fEhEstadoRegraZonaFranca(strEstado: String): Boolean;
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
    function fRetNomeRede: String;
    function GetIPAddress: Integer;
    function GetIPAddressAsString: String;
    function GetMacAddress: String;
    function GetUserFromWindows: String;
    function GetComputerNetName: String;
    function fRetLocSep(Const strCodLse: String): String;
    function fRetNomeEmpresa: String; overload;
    function fRetNomeEmpresa(strCodEmp: String): String; overload;
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
    function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
    function fRetornaInGrupo(strCodGpo: String; arrGrupos: TConsultasArray; strCampo: String=''): String;
    function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
    function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
    function fRetClientesFilial: String;
    function fEmptyDate(strDate: String): Boolean;
    function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fIsNumber(Const strNumber: String): Boolean;
    function fAbrirTabela(NomeTabela:TDataSet):Boolean;
    function fUsaProCodigo(strNomeTabela: String): Boolean;
    function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
    function fVerificaIntegridade(strNomFrm,
                                  strTabela: String;
                                  qryTabOriginal: TDataSet;
                                  blnGravar: Boolean = True;
                                  blnSoCriaTabela: Boolean = False;
                                  strMotDel: String = '';
                                  strOpeDel: String = '';
                                  blnTabAux: Boolean = False): String;
    function fInTransaction(objConexao: TUniConnection = Nil): Boolean;
    function fStartTransaction: Boolean;
    function fRollBack: Boolean;
    function fCommit: Boolean;
    function fValidarDirEspecificos(Var strDireitos: String; strLogin, strNomeForm: String): Boolean;
    function fRetTamCampo(strNomeTabela: String): Integer;
    function fAtualizaProCod(strNomeTabela: String; const strCampoBusca : String): String;
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
                           strDirImp: String = ''): Boolean;
    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fRetNomeLinhaGrupo(strCodigo: String): String;
    function fRetNomProduto(Const strCodIte: String): String;
    function fRetNomSituacaoProduto(strCodSit: String): String;
    function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TPicture): TRetornoImagem; Overload;
    function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TfrxPictureView): TRetornoImagem; Overload;
    function fRetNomFornecedor(strCodFor: String): String;
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
    function fRetornaComposicao(strDescri:String; blnPadrao : Boolean = False): String;
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
    function fRetDescDepartamento(strCodDep: String): String;
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
                                intDecUni: Integer = -1):Double;
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
    function fStrLocateEmpresa(objCodigo: TObject;
                               arrLinha: TConsultasArray;
                               strNomCampo,
                               strNomPar: String;
                               blnSemAND: Boolean = False;
                               strCodigo: String = ''): String;
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
    function fRetExtensoNumero(Value : String):String;
    function fDataExtenso(Data: TDateTime; blnImpCid: Boolean = False; blnImpDiaSemana: Boolean = False): String;
    function fRetDataExtenso(dtaData: TDateTime; blnComCidade: Boolean = False): String;
    function ffrmSenha(var strSenha: String; strTitulo: String = ''): Boolean;
    function fCampoTabela(strCampo : String;
                          strNomTab: String;
                          arrCampoChave: Array Of String;
                          arrValorChave: Array Of Variant;
                          blnSempreLerBanco: Boolean = True;
                          strOrderBy: String = '';
                          Conexao: TUniConnection = Nil;
                          blnUsarMax: Boolean = False): Variant;
    function fFormataFone(strFone: String): String;
    function fGetMsgRelCnf: String;
    function fValidaDataStr(strData: String): Boolean;
    function fRetUFCliente(strCodCli: String): String;
    function fRetUFEmpresa(strCodEmp: String): String;
    function fRetDadosClienteConsumidor(strDocumento, strCampo: String): String;
    function fValidaPlaca(strPlaca: String): Boolean;
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
    function fRetNomPortador(Const strCodPor: String): String;
    function fRetNomDep(strCodDep: String): String;
    function fRemoveAcento(Str: String): String;
    function fRetDesConPag(strCodCnd: String): String;
    function IfNull(varValor, varDefault: Variant): Variant;
    function fValidaEstado(strUf: String): Boolean;
    function fRetNomeEstado(strNomeEstado: String): String;
    function fRetDescOcorrencia(Const strCodOcorrencia: String): String;
    function fRetNomFaseObra(Const strCodFase: String): String;
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
                         strCodCid: String = '';
                         blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                         blnConsideraDomingo: Boolean = False): Boolean;
    function fGetZClient(Owner: TComponent; strSQL: String = ''): IZClient;
    function fGetMesesGiro(Owner: TComponent; intAnos: Integer): IMesesGiro;
    function fComponentByName(Owner: TWinControl; strNome: String): TComponent;
    function fRetDesSubReg(strCodSub: String): String;
    function fGetCamGer(Owner: TComponent): ICamGer;
    function fTamNumDoc: Integer;
    function fGetTValorRecebido: IValorRecebido;
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
    function fGetTCadFun(Owner: TComponent): ICadFun;
    function fSegToTimeStr(Segundos: Double): String;
    function fRetMotorista(Const strCodMot: String): String;
    function fRetCidade(Const strCodigo: String): String;
    function fRetNomRegiao(Const strCodReg: String): String;
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
    function fGetTFastPrintFileEditor(AOwner: TComponent): IFastPrintFileEditor;
    function fGetObjFastPrintFileEditor(): TObject;
    function fGetTReciboCtp(cdsDados: TUniClientDataSet): IFastPrintFile;
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
    function fRetDataPortador(strCodPor: String): TDateTime;
    function fDropTable(strNomeTabela: String): Boolean;
    function fRetSaldoAnterior(strCodPor: String; dtaDataIni: TDateTime; strCodEmp: String = '';
                               sitSitLan: TSituacaoLancBancario = sitTodos): Currency;
    function fRetornaCtaResDuplicado(qryAux: TUniQuery): Boolean;
    function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fRetNomEvento(strCodEve: String): String;
    function fDigDuplicSemTela(Var arrDuplicata: TarrDuplicata;
                               Var intQtdDup: Integer;
                               Var curTotalRes: Currency;
                               strCndPag:String;
                               intNumDoc:Int64;
                               curTotal:Currency;
                               blnEditavel,
                               blnHabEditDup:Boolean;
                               dtaDtaBas:TDateTime;
                               blnPergConf: Boolean;
                               fltImpost: Double = 0;
                               strUsaChq: String = 'N';
                               blnDupsRedondas: Boolean = True;
                               blnUsaHist: Boolean = False;
                               fltValRec: Double = 0.0;
                               arrValores: TDoubleArray = Nil;
                               blnSabDomFeriadoDiasUteis: Boolean = True;
                               strCodCid: String = ''): Boolean;
    function fRetNomTipoAtend(strCodigo: String): String;
    function fCriaDataSource(DataSet: TDataSet): TDataSource;
    function fCampoExiste(const strTabela, strCampo: String): Boolean;
    function fRetForFilialTodos(blnLista: Boolean = False): String;
    function StringToFloat(str : String) : Extended;
    Function fStrTituloPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus): String;
    function fStrTitulo(edtCodigo, edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo: String): String; overload;
    function fCadEmp(strNomCampo: String): String; Overload;
    function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery): String; Overload;
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
    function fRetAtividade(strCodAti: String): String;
    function fPreInv(strAlias : String = ''; strAliasImpFed : String = ''; strPreInv: String = ''):String;
    function fPreInvTitulo(strPreInv: String = ''): String;
    function fRoundSql(const strCampo: String; const intDecimais: Integer): String;
    function fRetornaSaldoCaixa(Var dtaDtaCai: TDateTime; strCodEmp: String = ''): Double;
    function fCaixaTemMovimento(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = ''; blnSoma: Boolean = False; dtaDtaFin: TDateTime = 0): Boolean;
    function fMovimentoFechamentoCaixa(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = ''): Boolean;
    procedure pRetornaUltimoFechamento(var fltUltFec: Double; var dtaDtaFec: TDateTime; strCodEmp: String = '');
    function fNecessitaFecharCaixa(blnFaturamento: Boolean; var dtaDtaLan: TDateTime; blnMostraMsg: Boolean = True; strCodEmp: String = ''): Boolean;
    Function fRetSiglaEmpresa(strCodEmp: String): String;
    function fRetMascaraFone(opcPais: TPais): String;
    function fRetMascaraFonePais: String;
    function fSQLCarregaEstoqu(dtaBase : TDateTime) : String; Overload;
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
    Function fRetValorCfg(strCodCfg, strValCfg: String): String;
    function fRetNomBandeira(strCodBan: String): String;
    function fGetTIteBar(opcCriacaP: TOpcaoCriacao = opcFuncoes;
                         qryTabIteP: TUniQuery = Nil;
                         dbeCodBarP: TDBEditFocus = Nil;
                         dbeBarEmbP: TDBEditFocus = Nil;
                         dbeEmbalaP: TDBEditFocus = Nil;
                         wncLocCadP: TWincontrol  = Nil;
                         strCodIteP: String = ''): IIteBar;
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
    function fDescontoClienteProfissional(strCodCli: String): Boolean;
    function fSomaFormasPagamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; intQtdCol: Integer = 0): String;
    function fRetSeqConCadRec(strNumDup: String;
                              strEspDoc: String;
                              strParcel: String;
                              strCodEmp: String;
                              strCodCli: String;
                              strOriF11: String): String;
    function fRetLocFisicaEmpEmissora(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String;
    function fRetDesFisicaEmpEmissora(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String;
    function fRetLocFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String;
    function fRetDesFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String; blnVirgula: Boolean = True): String;
    function fImprimirCabecalhoDocEmpresaPedidoCD(strNumFat, strTipFat, strEmpFat: String; Var strEmpPed: String): Boolean;
    function fMarcarPedidoComoImpresso(strNumDoc, strEspDoc, strCodEmp: String; blnDocSep, blnImpExpedicao: Boolean): Boolean;
    function fExecutaSQL(strSQL: String): Boolean;
    function fRetMltVenItem(Const strCodIte: String): Double;
    function fRetiraZerosEsquerda(strDado: String): String;
    function fRetNomeMarca(strCodigo: String): String;
    function fRetNomTabAuxMov(strNomTab: String): String;
    function fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes: String): String;
    function fGetTMadeireira: IMadeireira;
    function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double; Overload;
    function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; strDtaPag: String; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double; Overload;
    function fRetNomeBancoSelec(Const strCodBco: String): String;
    function fGetTFinanceira(AOwner: TComponent): IFinanceira;
    function fRetDesRegiao(strCodReg: String): String;
    function fCriaDiretorio(strPath: String): Boolean;
    function fRetFantasiaEmpresa(strCodEmp: String = ''): String;
    function fGetTCamposUso: ICamposUso;
    function fGetTFuncMacro: IFuncMacro;
    function fRetSQLCGCCPFFormatado(strCampoCGCCPF, strCampoC_G_C_: String): String;
    function fInformacaoAdicionalEtiquetaItens: String;
    function fVer_Banco_Carteira(strCodBan, strChave: String;
                                 Var strBanRet: String;
                                 Var intCarRet: Integer;
                                 blnVeioImpBol: Boolean = True): Boolean;
    function fArqIniAutban(ReadWrite:Integer; NomChave, NomSecao, Conteudo: String): String;
    function fFormataCCusto(strValor: String): String;
    function fFilaExiste(strFila: String): Boolean;
    function fGetMenu(strTitulo: String;
                      arrOpcoes: Array Of String;
                      intOpcao: Integer;
                      blnSaiComEsc: Boolean = False): Integer;
    function fAtuCfgSis(strCamCfg: String; strValCfg: String; strCodEmp: String = '') : Boolean;
    function fRetNatOpe(strCodCfo: String): String;
    function fInc(Var intValor: Integer) : Integer;
    function fRetTelaSelecaoImp(Var oleDados: OleVariant; var strOrdenacao: string; var bVerificarEmail: boolean): Boolean;
    function fGetTipoAbfFornecedor(const strCodFor: String): String;
    function fGetTipoAbfCliente(const strCodCli: String): String;
    function fRetEnderecoEmpresa(strCodEmp: String): String;
    Function fImprimeEtiqueta(prmDllRel: Pointer; strNomFun: String = 'fimprimeetiquetas'): Boolean;
    function fRetDesAbfPis(strAbfPis: String): String;
    function fRetDesAbfCof(strAbfCof: String): String;
    function fRetDesCstPis(strCstPis: String): String;
    function fRetDesCstCof(strCstPis: String): String;
    function fValidaEcf(strCodEcf: String; var strModelo: String): Boolean;
    function fRetMesExtenso(intMes: Integer): String;
    function fRetDesAbfIcm(strCodAbf: String): String;
    function fDigEmail(var strDestinatario, strEmailDestinatario: String) : Boolean;
    function fRetPreComMenosDescForn(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet = Nil;
        strCALSOP: String = ''): Double;
    function fRetNomLocFisica(Const strCodLoc: String): String;
    function fRetNumLoteConsulta(const strNumLot: String): String;
    function fGetTCadLot(Owner: TComponent; qryCadTab: TUniQuery = Nil): ICadLot;
    function fGetTFiltrosRelatorio: IFiltrosRelatorio;
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
    function fRetCodFornecedorTabelaPreco(strTabPre: String): String;
    function fRetNomeTabelaPreco(strCodTab: String): String;
    function fCheckParent(Sender, Parent: TWinControl): Boolean;
    function fGetConfiguracao : IConfiguracao;
    function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): Double;
    function fRetNomTabelaPreco(strCodTab: String): String;
    function fCalculaPrecoCompraLiq(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
                                  fltDesf04, fltDesf05, fltDesf06: Double;
                                  intDecUni: Integer = -1;
                                  blnPreDol: Boolean = False): Double; overload;
    function fCalculaPrecoCompraLiq(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet): Double; overload;
    function fValidaMesAno(mskMesAno: TMaskEditFocus; strInfErr: String): Boolean; Overload;
    function fValidaMesAno(mskMesAno: String; strInfErr: String): Boolean; Overload;
    function fRetTipoDepartamento(strCodigo,strTipo: String): String;

    function fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean): String;
    function fSQLCamposQuantidadePendenteCompra(blnSoma, blnFiltraTE, blnLibPcm: Boolean; strAliasSALPDC: String): String;
    function fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean): String;

    function fRetTipoImpressora(var strTipImp: String): Boolean;
    function fAcertaMaskTel(strFone: String): String;
    function fEnviarEMailComAnexo(Para, Assunto, Texto, Arquivo: String): Integer;
    function fEnviarEmail(strTitulo, strArquivo, strDestinatario: String): Boolean;
    function fDesconsiderarNaQtdLimDaPromoItensUnitarMaior: Boolean;

    function fPesqTabelaPreco(Self       : TForm;
                              edtCodigo  : TCustomEdit;
                              edtDescri  : TEditFocus;
                              qryTabela  : TUniQuery;
                              Var chrKey : Char;
                              Var arrSel : TConsultasArray;
                              blnConSim  : Boolean = True): Boolean;
    function fPesqTabDinamica(Self       : TForm;
                              edtCodigo  : TCustomEdit;
                              edtDescri  : TEditFocus;
                              qryTabela  : TUniQuery;
                              Var chrKey : Char;
                              Var arrSel : TConsultasArray;
                              blnConSim  : Boolean = True): Boolean;
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
    function fPesqTipoCliente(Self       : TForm;
                              edtCodigo  : TCustomEdit;
                              edtDescri  : TEditFocus;
                              qryTabela  : TUniQuery;
                              var chrKey : Char;
                              var arrSel : TConsultasArray;
                              blnConSim  : Boolean): Boolean;
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
    function fPesqConfiguracaoRel(opcTipCfg : TTipoConsultaSimples;
                                  Self      : TForm;                       {* Formulário                                  *}
                                  edtCodigo : TCustomEdit;                 {* Edit do Código                              *}
                                  edtDesPor : TEditFocus;                  {* Edit da Descrição do item                   *}
                                  qryTabela : TUniQuery;                   {* Query                                       *}
                                  Var chrKey: Char;                        {* Key                                         *}
                                  Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                                  strWhere  : String;                      {* Where                                       *}
                                  blnConSim : Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                  strTitulo : String = 'Configuração de Relatórios'): Boolean;
    function fPesqGrupo(Self     : TForm;                             {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                        edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                         {* Query                                       *}
                        Var chrKey: Char;                             {* Key                                         *}
                        Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                    {* Consulta Simples ou Múltipla (multi select) *}
                        blnDesRes: Boolean = False): Boolean;         {* Mostrar Descricao Resumida(INDUSTRIAL)      *}
    function fPesqItem(opcTipIte: TTipoConsultaItem;
                       Self     : TForm;                         {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                       edtDesIte: TCustomEdit;                   {* Edit da Descrição do item                   *}
                       qryTabela: TUniQuery;                     {* Query                                       *}
                       Var chrKey: Char;                         {* Key                                         *}
                       Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                       blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                       objFrmPnl: TPanelCx = Nil;                {* Painel                                      *}
                       strTitulo: string = 'Consulta de Itens';
                       strTabPre: String = '';
                       strConPag: String = '';
                       fltTaxVpr: Double = 0;
                       blnEmpFat: Boolean = False;
                       blnExiPar: Boolean = False;
                       intOpcAtivos: Integer = 0;
                       opcCodIte: TCodigoRetornoItem = cdrCodIte;
                       strAplica: String = '';
                       blnPedCom: Boolean = False;   {* Se é pedido de compra                        *}
                       strCodCli: String = '';
                       blnMostrarPrecos: Boolean = True;
                       blnTablet: Boolean = False;
                       blnConsiderarExiLis: Boolean = True;
                       strCodCmp: String = '';
                       blnDepMatPriIndustrial: Boolean = False; {Departamento materia prima cadestruturaindustrial}
                       blnDepProAcaIndustrial: Boolean = False; {Departamento produto acabado cadcomposicaoProdAcab}
                       blnDepProEmbIndustrial: Boolean = False; {Departamento produto embalagem cadcomposicaoProdAcab}
                       blnDepProGraIndustrial: Boolean = False; {Departamento produto granel cadestruturaindustrial}
                       blnVeioF11: Boolean = False;
                       blnSomenteEstrutura: Boolean = False): Boolean;
    function fPesqSituacaoProduto(Self     : TForm;                         {* Formulário                                  *}
                                  edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                                  edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                                  qryTabela: TUniQuery;                       {* Query                                       *}
                                  Var chrKey: Char;                         {* Key                                         *}
                                  Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                                  blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
                             Self     : TForm;                        {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                             edtNomEmp: TCustomEdit;                  {* Edit do Nome da Empresa                     *}
                             qryTabela: TUniQuery;                    {* Query                                       *}
                             Var chrKey: Char;                        {* Key                                         *}
                             Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                             blnConSim: Boolean = True): Boolean;     {* Consulta Simples ou Múltipla (multi select) *}
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

    function fPesqMarcas(Self     : TForm;                            {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                         edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                        {* Query                                       *}
                         Var chrKey: Char;                            {* Key                                         *}
                         Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                          Self     : TForm;                           {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                          edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                           {* Key                                         *}
                          Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                          blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                          blnResEmp: Boolean = False;                 {* Restringir empresas que usuário tem acesso  *}
                          strEmpresas: String = '';                   {* Empresas                                    *}
                          blnAceCtr: Boolean = False;                 {* Verifica se filtrará as empresas que o usuário tem acesso na Baixa de Contas a Receber *}
                          strAceCtr: String = ''): Boolean;           {* Empresas que o usuário possui acesso na Baixa de Contas a Receber        *}
    function fPesqCliente(opcTipCli: TTipoConsultaCliente;
                          Self     : TForm;                           {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                          edtNomCli: TEditFocus;                      {* Edit do Nome do Cliente                     *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                           {* Key                                         *}
                          Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                          blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                          objFrmPnl: TPanelCx = Nil;                  {* Painel                                      *}
                          blnTablet: Boolean = False;
                          strCodRep: String = ''): Boolean;
    function fPesqSubRegiao(Self     : TForm;                            {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                            edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                        {* Query                                       *}
                            Var chrKey: Char;                            {* Key                                         *}
                            Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqRedeLojas(Self     : TForm;                         {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                            edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                         {* Key                                         *}
                            Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqRegiao(Self     : TForm;                            {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                         edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                        {* Query                                       *}
                         Var chrKey: Char;                            {* Key                                         *}
                         Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqUnidade(Self      : TForm;                          {* Formulário                                  *}
                          edtCodigo : TCustomEdit;                    {* Edit do Código                              *}
                          edtUnidade: TEditFocus;                     {* Edit da Unidade                             *}
                          edtSigla  : TEditFocus;                     {* Edit da Sigla da Unidade                    *}
                          qryTabela : TUniQuery;                      {* Query                                       *}
                          Var chrKey: Char;                           {* Key                                         *}
                          Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                          blnConSim : Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                          blnPesqSigla : Boolean = False): Boolean;
    function fPesqAtividade(Self     : TForm;                         {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                            edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                         {* Key                                         *}
                            Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqFaseObra(Self     : TForm;                          {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                           edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                      {* Query                                       *}
                           Var chrKey: Char;                          {* Key                                         *}
                           Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqDepartamento(Self     : TForm;                      {* Formulário                                  *}
                               edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                               edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;                  {* Query                                       *}
                               Var chrKey: Char;                      {* Key                                         *}
                               Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                               blnConSim: Boolean = True): Boolean;   {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqCidade(Self     : TForm;                            {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                         edtCidade: TEditFocus;                       {* Edit da Cidade                              *}
                         edtEstado: TEditFocus;                       {* Edit do Estado (UF)                         *}
                         qryTabela: TUniQuery;                        {* Query                                       *}
                         Var chrKey: Char;                            {* Key                                         *}
                         Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqGrupoOperador(Self     : TForm;                     {* Formulário                                  *}
                                edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                                edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                 {* Query                                       *}
                                Var chrKey: Char;                     {* Key                                         *}
                                Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                                blnConSim: Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqCondicoesPgto(Self     : TForm;                     {* Formulário                                  *}
                                edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                                edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                 {* Query                                       *}
                                Var chrKey: Char;                     {* Key                                         *}
                                Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                                blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select) *}
                                blnTablet: Boolean = False;
                                opcTipCon: TTipoConsultaCondPagto = conCndSimples;
                                fltMarDoc: Double = 0;
                                fltValDoc: Double = 0;
                                strCodCli: String = '';
                                blnAtivas: Boolean = False;
                                blnFaturamento: Boolean = False): Boolean;
    function fPesqDiversos(Self        : TForm;                       {* Formulário                                  *}
                           edtCodigo   : TCustomEdit;                 {* Edit do Código                              *}
                           edtDescri   : TEditFocus;                  {* Edit da Descrição                           *}
                           qryTabela   : TUniQuery;                   {* Query                                       *}
                           Var chrKey  : Char;                        {* Key                                         *}
                           Var arrSel  : TConsultasArray;             {* Array de Seleção                            *}
                           blnConSim   : Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                           blnVerStatus: Boolean = False;
                           blnVerEmpAce: Boolean = False;
                           strCodCli   : String  = ''): Boolean;      {* Verifica Status (Ativo Sim ou Não)          *}
    function fPesqParceiro(Self     : TForm;                          {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                           edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                      {* Query                                       *}
                           Var chrKey: Char;                          {* Key                                         *}
                           Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqConsumidores(Self      : TForm;                            {* Formulário                                  *}
                               edtCodCon : TDBEditFocus;                     {* Edit do Código                              *}
                               edtDesCon : TDBEditFocus;                     {* Edit da Descricao                           *}
                               edtCgcCpf : TEditFocus;                       {* Edit CgcCpf                                 *}
                               mskNumCgc : TMaskEditFocus;                   {* Edit NumCgc                                 *}
                               qryTabela : TUniQuery;                        {* Query                                       *}
                               Var chrKey: Char;                             {* Key                                         *}
                               Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                               strCodCli : String  = '';                     {* Parametro Filtro Estado Consumidor          *}
                               blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqVeiculos(Self     : TForm;                          {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                           edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                      {* Query                                       *}
                           Var chrKey: Char;                          {* Key                                         *}
                           Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                           blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                           blnComMsk: Boolean = True;                 {* Com máscara (XXX-9999)                      *}
                           strFiltro: String = ''): Boolean;
    function fPesqPortador(opcTipPor: TTipoConsultaSimples;
                           Self     : TForm;                       {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                           edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                           qryTabela: TUniQuery;                   {* Query                                       *}
                           Var chrKey: Char;                       {* Key                                         *}
                           Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                           blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                           strTitulo: String = 'Consulta de Portadores';
                           strBolFat: String = '';                 {* Boleto no Faturamento                       *}
                           blnSalPor: Boolean = False): Boolean;   {* Entra no Relatório Saldo Portador           *}

    function fPesqOcorrencia(Self     : TForm;                        {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                             edtDescri: TEditFocus;                   {* Edit da Descrição                           *}
                             qryTabela: TUniQuery;                    {* Query                                       *}
                             Var chrKey: Char;                        {* Key                                         *}
                             Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                             blnConSim: Boolean = True): Boolean;     {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqServicos(Self     : TForm;                          {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                           edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                      {* Query                                       *}
                           Var chrKey: Char;                          {* Key                                         *}
                           Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                           blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                           blnAutCen: Boolean = False): Boolean;      {* Se CFG_AUTCEN = "S"                         *}
    function fPesqTransportadora(opcConTra: TTipoConsultaTransportad;
                                 Self     : TForm;                        {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                                 edtNomTra: TEditFocus;                   {* Edit do Nome da Transportadora              *}
                                 qryTabela: TUniQuery;                    {* Query                                       *}
                                 Var chrKey: Char;                        {* Key                                         *}
                                 Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                                 blnConSim: Boolean = True;               {* Consulta Simples ou Múltipla (multi select) *}
                                 strCidCli: String = ''): Boolean;        {* Cidade do Cliente                           *}
    function fPesqFormaPgto(opcTipPgt: TTipoConsultaFormaPagto;
                            Self     : TForm;                         {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                            edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                         {* Key                                         *}
                            Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                            blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                            blnTablet: Boolean = False): Boolean;
    function fPesqCampanha(Self       : TForm;                                {* Formulário                                  *}
                           edtCodCam  : TCustomEdit;                          {* Edit do Codigo                              *}
                           edtDesCam  : TEditFocus;                           {* Edit da Descrição                           *}
                           qryConCam  : TUniQuery;                            {* Query                                       *}
                           Var chrKey : Char;                                 {* Key                                         *}
                           Var arrSel : TConsultasArray;                      {* Array de Seleção                            *}
                           blnConSim  : Boolean = True;                       {* Consulta Simples ou Múltipla (multi select) *}
                           strTitulo  : String = 'Consulta de Campanhas'): Boolean;
    function fPesqMotorista(Self     : TForm;                         {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                            edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                         {* Key                                         *}
                            Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                            blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                            blnAtivos: Boolean = False): Boolean;     {* Apenas com status ativo                     *}
    function fPesqEntrga(Self      : TForm;                                   {* Formulário                                  *}
                         edtNumEnt : TCustomEdit;                             {* Edit do Número de entrega                   *}
                         qryConEnt : TUniQuery;                               {* Query                                       *}
                         Var chrKey: Char;                                    {* Key                                         *}
                         Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                         blnConSimp: Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                         strTitulo : String = 'Consulta de Entregas'): Boolean;
    function fPesqCentroCusto(Self     : TForm;                       {* Formulário                                         *}
                              edtCodigo: TCustomEdit;                 {* Edit do Código                                     *}
                              edtDescri: TEditFocus;                  {* Edit da Descrição                                  *}
                              qryTabela: TUniQuery;                   {* Query                                              *}
                              Var chrKey: Char;                       {* Key                                                *}
                              Var arrSel: TConsultasArray;            {* Array de Seleção                                   *}
                              blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select)        *}
                              blnUsaCtf: Boolean = False;             {* Só mostra o Plano de Contas vinculado no CADFOR *}
                              strCodFor: String  = ''): Boolean;      {* Código da empresa se blnUsaCtf = True              *}
    function fPesqMotVendasPerdidas(Self     : TForm;                    {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                    edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                    qryTabela: TUniQuery;                {* Query                                       *}
                                    Var chrKey: Char;                    {* Key                                         *}
                                    Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                    blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqGrupoCompra(Self     : TForm;                       {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                              edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                   {* Query                                       *}
                              Var chrKey: Char;                       {* Key                                         *}
                              Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqPromocoes(Self      : TForm;                            {* Formulário                                  *}
                            edtCodPro : TEditFocus;                       {* Edit do Código                              *}
                            edtDesPro : TEditFocus;                       {* Edit da Descricao                           *}
                            qryTabela : TUniQuery;                        {* Query                                       *}
                            Var chrKey: Char;                             {* Key                                         *}
                            Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                            blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqGrupoAtividade(Self     : TForm;                      {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                                 edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                  {* Query                                       *}
                                 Var chrKey: Char;                      {* Key                                         *}
                                 Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                                 blnConSim: Boolean = True): Boolean;   {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqEventos(Self     : TForm;                           {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                          edtDescri: TEditFocus;                      {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                           {* Key                                         *}
                          Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;        {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqPedOrc(opcTipCon: TTipoConsultaPedidoVenda;
                       Self     : TForm;                            {* Formulário                                  *}
                       strEspDoc: String;                           {* Tipo de Documento                           *}
                       strOpcDoc: String;                           {* Opção de Documento                          *}
                       strCodEmp: String;                           {* Código da Empresa                           *}
                       edtNumDoc: TCustomEdit;                      {* Edit do Número do Documento                 *}
                       edtEspDoc: TEditFocus;                       {* Edit do Tipo do Documento                   *}
                       edtCodEmp: TEditFocus;                       {* Edit do Código da Empresa                   *}
                       Var qryTabela: TUniQuery;                    {* Query                                       *}
                       Var chrKey: Char;                            {* Key                                         *}
                       Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                       blnConSim: Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                       objFrmPnl: TPanelCx = Nil;                   {* Painel                                      *}
                       strCliCrm: String = '';                      {* Código do cliente CRM                       *}
                       strOriF11: String = 'N'): Boolean;           {* F11 Resumo de Caixa                         *}
    function fPesqTipoAtendimento(Self     : TForm;                 {* Formulário                                  *}
                                edtCodigo: TCustomEdit;             {* Edit do Código                              *}
                                edtDescri: TEditFocus;              {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;               {* Query                                       *}
                                Var chrKey: Char;                   {* Key                                         *}
                                Var arrSel: TConsultasArray;        {* Array de Seleção                            *}
                                blnConSim: Boolean = True): Boolean;{* Consulta Simples ou Múltipla (multi select) *}
    function fPesqAbrevFiscal(Self     : TForm;                       {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                              edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                     {* Query                                       *}
                              Var chrKey: Char;                       {* Key                                         *}
                              Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
    function fPesqSetFlz(Self      : TForm;
                         edtCodigo : TCustomEdit;
                         edtDescri : TEditFocus;
                         qryTabela : TUniQuery;
                         var chrKey: Char;
                         var arrSel: TConsultasArray;
                         blnConSim : Boolean): Boolean;
    function fPesqCanalAcesso(Self      : TForm;
                              edtCodigo : TCustomEdit;
                              edtDescri : TEditFocus;
                              qryTabela : TUniQuery;
                              var chrKey: Char;
                              var arrSel: TConsultasArray;
                              blnConSim : Boolean): Boolean;
    function fPesqCfgSis(Self       : TForm;
                         edtCodCfg  : TCustomEdit;
                         edtDesCfg  : TEditFocus;
                         qryConCfg  : TUniQuery;
                         Var chrKey : Char;
                         Var arrSel : TConsultasArray;
                         blnConSim  : Boolean = True;
                         strTitulo  : String  = 'Cosulta de Configurações'): Boolean;
    function fPesqCfgTin(Self       : TForm;
                         edtCodCfg  : TCustomEdit;
                         edtDesCfg  : TEditFocus;
                         qryConCfg  : TUniQuery;
                         Var chrKey : Char;
                         Var arrSel : TConsultasArray;
                         blnConSim  : Boolean = True;
                         strTitulo  : String  = 'Cosulta de Configurações da Tinta de Máquina'): Boolean;
    function fPesqPesquisa(Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
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
                         blnEmpGer: Boolean = False): Boolean;
    function fPesqCartaoBandeira(Self     : TForm;
                                 edtCodigo: TCustomEdit;
                                 edtDescri: TEditFocus;
                                 qryTabela: TUniQuery;
                                 Var chrKey: Char;
                                 Var arrSel: TConsultasArray;
                                 blnConSim: Boolean = True): Boolean;
    function fPesqCamsposLayout(Self     : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                strFiltro: String;
                                intPosCam: Integer = -1;
                                blnConSim: Boolean = True): Boolean;
    function fPesqBanco(Self     : TForm;
                      edtCodigo: TCustomEdit;
                      edtDescri: TEditFocus;
                      qryTabela: TUniQuery;
                      Var chrKey: Char;
                      Var arrSel: TConsultasArray;
                      blnConSim: Boolean = True): Boolean;
    function fPesqLayout(Self     : TForm;
                         edtCodigo: TCustomEdit;
                         edtDescri: TEditFocus;
                         qryTabela: TUniQuery;
                         strTipImp: String;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
    function fPesqCFOP(Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDescri: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True): Boolean;
    function fPesqECF(Self     : TForm;
                      edtCodigo: TCustomEdit;
                      edtDescri: TEditFocus;
                      qryTabela: TUniQuery;
                      Var chrKey: Char;
                      Var arrSel: TConsultasArray;
                      blnConSim: Boolean = True): Boolean;
    function fPesqLocFisica(Self       : TForm;
                            edtCodigo  : TCustomEdit;
                            edtDescri  : TEditFocus;
                            qryTabela  : TUniQuery;
                            Var chrKey : Char;
                            Var arrSel : TConsultasArray;
                            blnConSim  : Boolean = True): Boolean;
    function fPesqLoteItens(Self       : TForm;
                            edtNumLote : TEditFocus;
                            edtCodIte  : TEditFocus;
                            intDecUni  : Integer;
                            qryTabela  : TUniQuery;
                            Var chrKey : Char;
                            Var arrSel : TConsultasArray;
                            blnConSim  : Boolean = True): Boolean;
    function fPesqPedidoCompra(Self       : TForm;
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
    function fPesqAjuste(Self      : TForm;
                         edtNumAju : TCustomEdit;
                         qryConAju : TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         strCodEmp : String;
                         blnConSim : Boolean = True;
                         strTitulo : String = 'Consulta de Ajustes de Estoque'): Boolean;
    function fPesqProdAcabado(Self      : TForm;
                              edtCodAca : TCustomEdit;
                              edtDesAca : TEditFocus;
                              qryConAca : TUniQuery;
                              Var chrKey: Char;
                              Var arrSel: TConsultasArray;
                              strEmpAca : String;
                              blnConSim : Boolean = True;
                              strTitulo : String  = 'Consulta de Produtos Acabados';
                              strEmpEst : String = ''): Boolean;
    function fPesqArmazem(Self       : TForm;
                          edtCodigo  : TCustomEdit;
                          edtDescri  : TEditFocus;
                          qryTabela  : TUniQuery;
                          Var chrKey : Char;
                          Var arrSel : TConsultasArray;
                          blnConSim  : Boolean = True): Boolean;
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

    function fGetStrCodigos(edtCodigo: TEditFocus; arrLinha: TConsultasArray; blnQuoted: Boolean = False): String;
    function fMostrarFatorConversaoMadeira(strCodIte: string): boolean;
    procedure pDestroiModulo(var NomeForm);
    procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm: TDataModule);
    procedure pCriarForm(ClasseForm: TFormClass; NomeForm: TForm);
    procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
    procedure pFreeAndNil(var frmForm);
    procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');
    procedure pIniciaLogLeak(intDebugH: Byte; strArquivo: String);
    procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
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
    procedure pCarregaConfImprRel(Const strNomeForm: String;
                                    Var strNomImp: String;
                                    Var strTipImp: String;
                                        strCodEmp: String = '';
                                        blnPreImp: Boolean = False);
    procedure pCarregaConfImpr(Var qryCfgRel: TUniQuery;
                             Const strNomeForm: String;
                                   strCodEmp: String = '';
                                   strNomeFila: String = '');
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

    procedure pCarregaComposicaoCusto(cbbComCus: TComboBoxFocus);
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
    procedure pMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);
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
    procedure pRetListaMesAno(stlLista : TStrings ; intQtdReg : Integer = 24; blnLimpaLista : Boolean = True);
    procedure pCarregaTabPre(cbxTabPre: TComboBox); overload;
    procedure pCarregaTabPre(cbxTabPre: TDBComboBoxFocus); overload;
    procedure pRetFilasImpressao(Var arrFilas: TarrFilas);
    function fPesqGrupoProduto(Self         : TForm;
                               edtCodigo    : TCustomEdit;
                               edtDescricao : TEditFocus;
                               qryTabela    : TUniQuery;
                               Var chrKey   : Char;
                               Var arrSel   : TConsultasArray;
                               blnConSim    : Boolean = True): Boolean;

    function fPesqTipoServico(Self     : TForm;                          {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                              edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                      {* Query                                       *}
                              Var chrKey: Char;                          {* Key                                         *}
                              Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}

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
    function fIsValidDate(Sender: TWinControl): Boolean; overload;
    function fRetDadosEmitente(strNumCgc: String;
                               Var strNomEmi,
                                   strEndere,
                                   strTele01: String): Boolean;
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

    Procedure pSetaNumPedCom(edtNumPed: TEditFocus);

    function fGetTituloVersao(): String;
    function fGetUsuarioUtilizaTemaClassico(): Boolean;
    function fGetUsuarioLogado(): String;
    function fGetEmpresaLogada(): String;

    function fCarregaCartoesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
    function fCarregaChequesTransferidos(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf :Boolean = false): TUniQuery;
    function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
    function fUsaSat(strCodEmp : String = '') : Boolean;
    function fEhFeriado(dtaData: TDateTime; strCodCid: String = ''): Boolean;
    function fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double): Double;
    function fRetConPagCodCnd(strCodCnd: String): String;
    function fRetornaSaldoDisponivel(strCodIte: String; blnCnvMl : Boolean = False;
                                   blnFaturamento: Boolean = True; strNumLot : String = '';
                                   blnConsiderarPedidos : Boolean = True;
                                   strCodEmp: String = ''; strNumPedAlt: String = '';
                                   blnConsiderarPedidoCompraPendente: Boolean = False;
                                   blnConsiderarCfgCalSal: Boolean = True;
                                   blnConsiderarOrdemProducao: Boolean = True): Double;
    function fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada: String;
                                                              arrAlias: TParamArrayString=NIL;
                                                              arrMacroParaCadaItemDoarrAlias: TParamArrayString=NIL;
                                                              arrApenasAsEspecies: TParamArrayString=NIL;
                                                              strPrefixo: String='DET_';
                                                              strOperacaoSeSomenteValor: String=''): String;
    function fRetornaInfMedVIDRO(blnDoisPontos: Boolean = False; blnAbreviadoComprimento: Boolean = False;blnMaximo : Boolean = False; blnMensagem :Boolean = False;blnAbreviadoAltura : Boolean = False) : String;
    function fFormataCasaDecimalVIDRO(strMascaraDefault : Variant) : Variant;
    function fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
    function fPesqTipoCotacaoPedCpr(Self     : TForm;                        {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                                    edtDescri: TEditFocus;                   {* Edit da Descrição                           *}
                                    qryTabela: TUniQuery;                    {* Query                                       *}
                                    Var chrKey: Char;                        {* Key                                         *}
                                    Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                                    blnConSim: Boolean = True): Boolean;     {* Consulta Simples ou Múltipla (multi select) *}
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
    Procedure pSetaCodIte(edtCodIte: TEditFocus); overload;
    Procedure pSetaCodIte(edtCodIte: TStringField); overload;
    function fTamCodIte: Integer;
    function fTime() : TDateTime;
    function fSomarNovosImpostosDaReformaAoValorContabil : Boolean;
    function fSqlValorReformaFdoRef(const AAutoincrementoFatDor: String): String;
  End;

implementation

end.



