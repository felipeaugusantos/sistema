unit Contabilidade.Funcoes;

interface

uses ComboBoxFocus, Data.DB, UniClientDataSet, Contabilidade.Interfaces, System.Classes, Uni, DBEditFocus,
  Contabilidade.Model.Contabilizaveis, Contabilidade.Model.TDadosImportacaoContabil, System.Generics.Collections,
  Contabilidade.Classes.LogAjc, Contabilidade.Classes.LogAjcOp,
  cxDropDownEdit, untTypesSistema, frxClass, Contabilidade.Classes.Dicionarios, cxProgressBar, EditFocus,
  Contabilidade.Classes.TTrataIncDoc, Contabilidade.Classes.TGravacaoEmLote,
  FireDAC.Comp.Client ;

type
  TProcedureMultLancamentosContabeis = procedure (listaLancamento: TObjectList<TDadosImportacaoContabil>; const AValorTotalLanctos: double; const AdtaLan:TDate; const AstrEmpLan: string) Of Object;
  TProcedureExibirRelatorio = procedure(const APrograma, ADescricao: String; AReport: TfrxReport) of object;
  TSetaTextoProgresso = procedure(pgbProgresso: TcxProgressBar; strTexto: String) of object;
  TCarregaPlanoDeContasPorEmpresaInterno = procedure(const AstrTabela, AstrValorChave: String; var AcdsNCO: TUniClientDataSet) of object;
  TSalvaPlanoDeContasPorEmpresaInterno = procedure(const AstrTabela, AstrValorChave: String; const AcdsNCO: TUniClientDataSet) of object ;

  TRecFecCon = record
    FecIni : TDateTime ;
    FecFin : TDateTime ;
    Selecionado : Boolean ;
  end;
  TDynamicArrayFecCon = array of TRecFecCon;

  TRecCampos = record
    strCampos: string;
    strCamposDel: string;
  end;

  { Os três estados são distintos de propósito: "falhou" não é "não existe". Quem guarda
    a resposta precisa da diferença, sob pena de uma queda momentânea de conexão virar
    decisão permanente. }
  TSondaTabela = (staExiste, staNaoExiste, staFalhou);

const
  cLALUR = '1' ;
  cLACS = '2' ;

function fMskCon: String;
procedure pCarregaTiposContabeis(Combo: TComboBoxFocus; blnFolhaPatrim: boolean = false; blnManual: boolean = false);
function fSiglasContabeis: String;
function fSemMascaraPlaNco(strValor: String): String;
function fRemoveZerosEsquerda(strValor: String): String;
procedure pPlanoDeContasPorEmpresaParametro(strTabela: String; strContaUnica: String; cdsDados: TUniClientDataSet; strCreDeb: String = '');
procedure pPlanoDeContasPorEmpresa(strValorChave: String; strTabela: String; strContaUnica: String; State: TDataSetState; AcdsNCO: TUniClientDataSet = nil; AblnAlteracaoDadosExterna: Boolean = False);
function fVerificarPlanoDeContasPorEmpresa(strValorChave: String; strTabela: String; strContaContabil: string; AcdsNCO: TUniClientDataSet = nil):boolean;
function fDescritivoEntidade(strTabela: String): String;
function fCampoChave(strTabela: String): String;
function fParNco(const strSeqPar, strCodEmp, strCreDeb: string): string;
function fParNcoWhereSql(const strSeqPar: string): string;
function fGetSqlInsertLanCon: string;
function fGetSqlInsertTrnCnt: string;
function fGetSqlUpdateLanconTrnCntCredito: string;
function fGetSqlUpdateLanconTrnCntDebito: string;
function fGetSqlInsertLanCnt: string;
function fGetSqlLastAutoIncLanCon: string;
function fGetSqlInsertLanMes: string;
function fGetSqlInsertLanDet: string;
function fGetSQLInsertLogAjc: string;
{ Sonda do próprio módulo — a Contabilidade é external e não pode depender do
  comportamento de fTabelaExiste do autcom. AConexao é obrigatória: a pergunta só vale
  no banco em que a resposta vai ser usada, e há chamador em cada DAC. }
function fSondarTabelaContabil(const AstrTabela: String; const AConexao: TUniConnection): TSondaTabela; overload;
function fSondarTabelaContabil(const AstrTabela: String; const AConexao: TFDConnection): TSondaTabela; overload;
function fEhCreditoClienteComAdiantamento(const AstrTipoLancamento, AstrFormPagto, AstrEspDoc: String; const AfltValorLancamento: Double): Boolean ;
function fInverterContas(strTipoLancamento: string; fltValorLancamento: double; blnEstorno: boolean; strFormPagto: string; const AstrEspDoc: String): boolean;
function fSetouValorNaPropriedadeSeExiste(Instance: TObject; const PropName: string; const Value: Variant): boolean;
function fUtilizaNaturezaDeOperacao(strTipLan: string): boolean;
function fRetornaEventosNaoExportar: string;
function fGetIndexTipLan(Items: TStrings; strTipLan: String): Integer;
function fTamCodIte: Integer;
function fTamCodEve: Integer;
function fPeriodoFechado(const ADtaIni, ADtaFin: TDateTime; strCodEmp: String): boolean;
{ AstrMensagem: aviso pronto para o operador quando bloqueia; vazio quando libera }
function fLancamentoAnteriorFechamento(const ADtaLan: TDateTime; const AstrCodEmp: String; out AstrMensagem: String): boolean;
procedure pGravarPlanoContasAutomatico(qryTabela: TUniQuery; dbePlaNco: TDBEditFocus; strFieldConta: string; strNomeConta: string);
procedure pGravarPlanoContasAutomaticoParaCadaEmpresa(qryTabela: TUniQuery; dbePlaNco: TDBEditFocus; strFieldConta: string; strNomeConta: string);
function fExcluirFechamentos(dtaDtaIni, dtaDtaFin: TDate; strCodEmp: string; blnConfirmar: boolean = false; blnAnual: boolean = false; arrFechamento: TDynamicArrayFecCon = nil; strCodEmps: string = ''): boolean;
function fConfiguracaoExiste(strCodCfg: string; strCodEmp: string = ''): boolean;
function fProximaContaContabil(strCodEmp: string; blnFornecedor: boolean): string;
function fJaExisteContaNaEmpresa(strCodigoConta, strCodEmp, strTipoCampo: string): boolean;
procedure pGravarContaContabil(strNomeConta: string; strCodEmp: string; out strCodCon: string; blnFornecedor: boolean);
procedure pGravaContaContabilDeCadaEmpresa(strFieldConta, strCodCon, strCodigoPessoa, strCodEmp: string);
procedure pGravaCliNco(strCodCli, strCodEmp, strCodCon: string);
procedure pGravaForNco(strCodFor, strCodEmp, strCodCon: string);
function fValidaNumeroCertidaoContador(strCertidao: string): Boolean;
function fValidaAno(strAno: string): Boolean;
function fValidaNumero(strNumero: string): Boolean;
procedure pSetaItensEntradaSaida(cmbItens: TComboBoxFocus; blnAddClafisServico: boolean; strTipLan: string; blnEhCFOPX933: boolean = false);
function fgetSQLConhecimentoFrete(strVenCom: string; recParCon: TParametrosConsulta; recValCam: TValidacoesDeBanco): string;
function fValorLiquidoEntradaLivro(const AintColuna: integer = 1; const AblnUsarIpi: Boolean = False; const AblnUsarRet: Boolean = False; const AblnUsarTotPisCof: Boolean = True; const AstrAliasTabela: String = ''): string;
function fValorLiquidoContabilLivro(const AColunasValorContabil: TSetColunasValorLiquidoContabil; const AintColuna: integer = 1): string;
function fVlrContabilLivro(const AintColuna: integer = 1; const AstrAliasTabela: String = ''): string;
function fVlrIcmsLivro(const AintColuna: integer = 1; const AstrAliasTabela: String = ''): string;
function fVlrIpiLivro(const AintColuna: integer = 1; const AstrAliasTabela: String = ''): string;
function fVlrRetLivro(const AintColuna: integer = 1; const AstrAliasTabela: String = ''): string;
function fLancamentoUtilizaCentroDeCusto(strTipLan: string): boolean;
function fValidouCentroDeCusto(const AtpcTipo: TTipoPlanoContas; const AstrContaContabil, AstrCentroDeCusto: string; var AstrMotivo: string; const AcdsPlanco: TUniClientDataSet; const AstrCodEmp: string; const AblnTemCentroCusto: Boolean): boolean;
function fGetNovoLoteContabil: Int64;
function fFormatoLoteContabil(strCompet: string; intSequen: integer): string;
function fGetSqlInsertLotInc: string;
function fGetSqlInsertPlaMes: string;
function fGetSqlInsertLanBal: string;
function fGetSqlinsertFecMes: string;
function fInserirLotInc(strIncDoc, strTipLan, strEmpLan: string; dtaDtaLan: TDate; intAutoma: integer; intSequen: integer = -1): string;
procedure pSetaParametrosGerLanCon(recParCon: TParametrosConsulta; qryDados: TUniQuery);
procedure pShowModalContasPorEmpresa(objForm: IShowModalFormContasPorEmpresa);
function fCarregaParconAvista(const ATipLan: string): TUniClientDataset;
function fValidaParametroTipoAVista(ACdsParconAvista: TUniClientDataset; const dtaDataLan: TDate; const strCfop: string = ''): boolean;
function fParametrizouTipoAVista(ACdsParconAvista: TUniClientDataset; const dtaDataLan: TDate; const strCfop: string = ''): boolean;
function fgetContabilizaveis(const qryDados: TDataSet): TContabilizaveis; overload;
function fgetContabilizaveis(const AIncDoc: string): TContabilizaveis; overload;
function fCriarDataSetErros: TUniClientDataSet;
function fConfiguracaoGrupoPlanoContas(blnFornecedor: boolean): string;
function fStringZerada(AValue: string): boolean;
function fDataLanCon(const AarrIncDoc: TArrIncDoc; const ATipLan: string): TDateTime;
function fCampoSaldoInicialPlaIni: string;
function fCampoCCustoPlaIni(blCfg:boolean):string ;
function fCampoCCustoLanConDeb(blCfg:boolean):string ;
function fCampoCCustoLanConCred(blCfg:boolean):string ;
function fTemCfgFconcc:boolean ;
function fProcuraPeriodoFechamentoPelaData(dtPesquisa:TDate; arr:TDynamicArrayFecCon; var recFecCon:TRecFecCon):boolean ;
procedure pSeparaDatasPeriodoFechamentoSelecionado(var dtIni, dtFin:TDate; arr:TDynamicArrayFecCon) ;
function fTemLinhaCodHpd(ALayoutSelecionado: TLayoutImportacaoContabil): boolean ;
function fTemVigencia: boolean;
function fCarregaPlancoVigencia:TUniClientDataSet;
function fCarregaPlancoInfo:TUniClientDataSet;
function fPrecisaLimparCentroCusto(const AcdsPlanco: TUniClientDataSet; const AstrContaContabil, AstrCodEmp: string):Boolean;
function fRetornaCentroCusto(const AcdsPlanco: TUniClientDataSet; AstrContaContabil, AstrCentroCusto, AstrCodEmp: string):string;
function fVerificaPlancoVigencia(cdsPlancoVigencia: TUniClientDataSet; const dtaLanCon:TDate; const strCta:String; var strMensagemValidacao:String; const strCodEmp: string; AlstControleVigenciaContaContabil: TStringList = nil):boolean;
function fCarregaParconHistorico(const strTipLan:string; const blnUsaCheckListComplemento, blnConSeqParExiste:boolean):TUniClientDataSet;
function fCfgCtrpvi: string;
function fNormalizaWarningGenerico(const strTipLan, strMensagem: string):string ;
function fDemonstrativoEcfGrupo01(const ABloco:string):boolean ;
function fDemonstrativoEcfGrupo02(const ABloco:string):boolean ;
function fDemonstrativoEcfGrupo03(const ABloco:string):boolean ;
function fDemonstrativoEcfGrupo04(const ABloco:string):boolean ;
function fDemonstrativoEcfGrupo05(const ABloco:string):boolean ;
function fGerarIncDocLanConManual:string ;
function fCfgCtrnum: string;
function fMskConPatrimonioLiquido(const AMascaraContabil:string=''): String ;
function fMskConDigitoIdentificador(const AMascaraContabil:string=''): String ;
function fMskConPrimeiroGrau(const AMascaraContabil:string=''): String ;
function fFiltroSQLAtvPas(const AstrCampoContaContabil: string; const AblnDigCom: Boolean = False): string;
function fSplitContaContabil(const AContaContabil:string; const AGrau:integer):string;
function fCfgCtntsi: string;
function fCfgDigcus: string;
function fCfgDigrec: string;
function fCfgDigdes: string;
function fLenDig(const ACfg: string):integer;
procedure pValorBalCrdean(qryLanBal:TDataSet; strValor:String) ;
procedure pValorBalCrdefi(qryLanBal:TDataSet; strValor:String) ;
procedure pValorMesCredeb(qryPlaMes:TDataSet; strValor:String) ;
function fCampoSaldoInicialPlaMes: string;
function fCampoSaldoAnteriorLanBal: string;
function fCampoSaldoFinalLanBal: string;
function fCreDebPeloValor(const fltValor:double):string ;
function fCfgConTra: string;
function fUsarNaturezaOperacaoCapaOuItem: string;
function fUsarNaturezaOperacaoDoItemNoEnt: Boolean ;
function fCfgDigCom: string ;
function fCfgDigApu: string ;
function fColunaExisteSeleci: boolean;
function fTemPlancosTipoImobilizado:boolean;
procedure pRetornaFiltroAdicionalDemonstrativoECF(
  const ATipoLancamento, ATipoTabela, ALalurLacs: string;
  var ABloco, ARegistro, ATipo, ATipoLan: string);
function fRetDescDemonstrativoECF(
  const ACodigo, ALalurLacs, ATipoMovimento, ACodigoTabela: String; var ABloco, ARegistro: string): String;
function fRetDescPadraoRFBParteB(
  const ACodigo, ATributo: String): String;
function fRetTplacoEmpresaLogada(const ACodEmp: string = ''; const blnLerBanco: Boolean = False):string;
function fCfgObrCcu: string;
function fRetDemEcdCSLL(const ABloco, ARegistro, ATipo, ATipoLan: string):string ;
function fCfgExpEcd: string;
function fUtilizaNaturezaDoAjuste: boolean;
function fCfgTrDcZe: string;
function fCfgCSaCst: string;
function fColunaExisteConCodTri: boolean;
function fCfgCAgrDp: string;
function fPodeUsarTiposContabeisAgrupamento(const ATipo: TTiposContabeis):boolean ;
function fAjustaIndexDescricaoContabil(const AIndex: Integer; const ALista: TStrings): Integer ;
function fCfgTipCar: string;
function fGetSqlInsertLo2Inc: string;
function fInserirLo2Inc(strIncDoc, strTipLan, strEmpLan: string; dtaDtaLan: TDate; intAutoma: integer; intSequen: integer = -1): string;
function fCfgLigPdd: string;
function fCfgExpCtb: string;
function fCfgMaxHpd: integer;
function fCfgAgrLan: string;
function fPodeAgruparLancamentos(const ATipLan: string; const AblnAgrupaSaiEnt: Boolean):boolean ;
function fRetornaChaveAgrupaLancamentos(const AItem: TDadosImportacaoContabil):string ;
function fPodeAgruparLancamentoImpAgr(const AItem: TDadosImportacaoContabil; const AblnImpAgr: Boolean): Boolean ;
function fRetornaChaveImpAgr(const AItem: TDadosImportacaoContabil): string;
function fCfgImpAgr: Boolean;
function fVericaContaNoPlanoContas(const AStrContaContabil, AstrCodEmp, AstrTipo: string; var AlstControlePesquisaContaContabil: TStringList): string;
procedure pCarregaResponsavel(var AContador: TObjectList<TInfoResponsavelContador>;
                              var AAdministrador: TObjectList<TInfoResponsavelEmpresa>) ;
procedure pCarregaResponsavelComboBoxContador(const AContador: TObjectList<TInfoResponsavelContador>; var ACombo: TcxComboBox);
procedure pCarregaResponsavelComboBoxAdministrador(const AContador: TObjectList<TInfoResponsavelEmpresa>; var ACombo: TcxComboBox);
procedure pInfoAnoExercicio(const ALimpar: boolean; var AExercicio, AExercicioAnterior: string; const AAno:integer) ;
function fCarregaEmpresaRelatorio(const AArrEmp: TConsultasArray): TInfoEmpresaSelecionadaRelatorio ;
function fCarregaStringDataRelatorio(const ACidade, AEstado: string): string ;
procedure pPreparaRelatorio(const AExercicio: integer;
                            const AArrEmpSel: TConsultasArray;
                            const AImprimirAssinatura, AImprimirParaArquivo: boolean;
                            const ANumeroPaginaInicial, ANumeroLivro: integer;
                            const AInfoResponsavelEmpresa: TInfoResponsavelEmpresa;
                            const AInfoResponsavelContador: TInfoResponsavelContador;
                            const ATituloRelatorio: string;
                            var ARelatorio: TfrxReport);
procedure pExibirRelatorio(strNomPro, strDesPro: String; AReport: TfrxReport);
procedure pCarregaConfRelRol(const ARelNome: string; const AArrEmpSel: TConsultasArray; var ALivro, APagina: integer);
procedure pGravaConfRelRol(const ARelNome: string; const AArrEmpSel: TConsultasArray; const ALivro, APagina: integer);
function fCfgNatDsc: string;
function fCfgRpCtRd: string;
function fCfgExcrep: string;
function fCfgPCJuDt: TObjectList<TDictionary<string,string>>;
function fCfgPCDeDt: TObjectList<TDictionary<string,string>>;
function fCfgAdtOrd: string;
function fCfgDesMva: string;
function fCfgCtpVnd: string;
function fCfgCtp_as: string ;
function fConsideraCTP_AS_NaGeracaoDoCtp: Boolean;
function fCfgMktPla: string;
function fPreparaSqlMarketPlace(const AstrSql: string):string ;
function fCfgCtrAgr: string;
function fCarregaCTCadFis(const ArecParCon: TParametrosConsulta; const ArecValBan : TValidacoesDeBanco; const AstrVenCom: string): TUniClientDataSet ;
function fMontaSqlCTCadFisInterno(const ArecParCon: TParametrosConsulta; const ArecValBan : TValidacoesDeBanco; const AstrVenCom: string; const AblnComplemento, AblnExisteTabelaComplementoCTE: boolean): string ;
function fCfgConGru: string;
function fCfgConEmp: string;
function fCfgPatCco: string;
function fCfgPiCoRf: Boolean;
function fCfgHisTpl: Boolean;
function fRetDescHistoricoPadrao(const AstrCodigo: string; const AstrCodEmp: string = ''): string;
function fAlqPisRF: Double;
function fAlqCofinsRF: Double;
function fDesconsiderarProEmbNoSAI: Boolean;
procedure pSetarFiltroEmpresa(var AqryParam: TUniQuery);

function fCampoTabelaParcon(AstrCampo : String;
                      AarrCampoChave: Array Of String;
                      AarrValorChave: Array Of Variant;
                      AblnSempreLerBanco: Boolean = True;
                      AstrOrderBy: String = '';
                      AConexao: TUniConnection = Nil;
                      AblnUsarMax: Boolean = False): Variant;

function fPermiteApenasPeriodoDentroDeUmUnicoMes(const AdtaDtaIni, AdtaDtaFin: TDateTime; const AstrTipo: String): Boolean;
function fTiposQuePermitemApenasPeriodoDentroDeUmUnicoMes: TTiposQuePermitemApenasPeriodoDentroDeUmUnicoMes;
function fDeletaLacamentosGeradosParaOutraEmpresaExec(const AdtaDtaIni,
                                                               AdtaDtaFin: TDateTime;
                                                         const AstrCodEmp,
                                                               AstrIncDoc: String;
                                                               AarrIncDoc: TArrIncDoc;
                                                               AprocExecProgresso: TSetaTextoProgresso;
                                                               ApgbProgresso: TcxProgressBar;
                                                         const AfltValor: double = 0.00;
                                                         const AstrCodOpe: string = '';
                                                         const AstrConDeb: string = '';
                                                         const AstrConCre: string = '';
                                                         const AstrTipLan: String = 'CTR'): boolean;
function fConsiderarPrevisoesDeContasAPagar: string;
function fValidarPlanoContasSomenteExportacaoExec(ApgbProgresso: TcxProgressBar; const AprocErros: TErroContabilProc):boolean ;
function fRetNomCfg(strCodCfg: String): String;
function fRetornaOrigemImpMovimento(const AdicDados: TDadosImportacaoContabil): String ;
procedure pSomaDebitoCreditoImpMovimento(const AstrChave: String;
                                         const AListaLanCon: TObjectList<TDadosImportacaoContabil>;
                                         var AfltCredito, AfltDebito: Double) ;
function fEstaNaListaControleDiferencaDebitoCredito(const AstrChave: string; var AlstControleDiferencaDebitoCredito: TStringList): Boolean ;
function fCfgContabilizaContraPartidaAgrEmpresa: string;
function fRetornaChaveDesmembramentoValores(const AobjDados: TDadosImportacaoContabil; const AstrCreDeb: String): String ;
function fRetornaCodEmpDesmembramentoValores(const AobjDados: TDadosImportacaoContabil): String ;
procedure pRetornaLstPlanoContasDesmembramentoValores(const AListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>;
                                                      var AlstListaSemPlanoContas: TStringList;
                                                      var AlstInfoSemPlanoContas: TObjectList<TInfoContraPartidaAgrupadaNoDesmembramentoValores>) ;
procedure pAdicionaLstRemocaoDesmembramentoValores(const AobjDados: TDadosImportacaoContabil;
                                                   const AblnFlagPartidaDupla: Boolean;
                                                   var ADelListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>) ;
procedure pContraPartidaAgrupadaNoDesmembramentoValores(var AListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>) ;
function fCfgRetornaContaContabilEmpresasDiferentesCTP: string;
function fEfetuarLancamentoDuploEmpresasDiferentesCTP(const AstrCodEmpCad, AstrCodEmpBai: String; const AstrTipLan: String; const AblnContabilizarPelaEmpBai: Boolean): boolean;
procedure pCarregaDadosNCO(const AstrTabela, AstrCampoChave, AstrValorChave: String; var AcdsDados: TUniClientDataSet) ;
function fSalvaDadosNCO(const AstrTabela, AstrCampoChave, AstrValorChave: String; const AcdsDados: TUniClientDataSet): Boolean ;
function fCriaEstruturaCdsNCO(AOwner: TComponent): TUniClientDataSet ;
procedure pCarregaPlanoDeContasPorEmpresa(const AstrTabela, AstrValorChave: String; var AcdsNCO: TUniClientDataSet) ;
procedure pSalvaPlanoDeContasPorEmpresa(const AstrTabela, AstrValorChave: String; const AcdsNCO: TUniClientDataSet) ;
function fValidaPlanoDeContasObrigatoria(const ABlnExpAutSi: Boolean; const AStrPlanoContas: String; const AcdsPlanoContas: TUniClientDataSet): Boolean ;
function fCfgApresentarCfop949TransSaiConfEstCont: string;
function fRetornaVersaoAutcomLogAceCont(const AstrCampo: String): String;
function fRetornaVersaoCont(const blnValidarCampoVersao : Boolean = False): String ;
function fCfgDescCreditoDinheiroMesmoSeqCon: String;
function fCfgDesmembrarSubContaCliFor: String;
function fCentroCustoDefaultCntDespRecCus: string;
function fAjustaCentroCustoCntDespRecCus(const AstrCentroCusto: String; const AstrCentroCustoDefault: String): string;
function fRetornaCliFor(const AedtClifor: TEditFocus): String;
function fRetornaTipoFC(const AedtTipoFC: TEditFocus): String;
function fCarregaCliForBD(const AstrCodigo, AstrTipo: String): String ;
function fMontaJoinSaiPlanoContas(const ATipo: TJoinSaiPlanoContas): String ;
function fMontaJoinCoeCosPlanoContas: String ;
function fPreparaSqlCoeCosPlanoContas(const AstrSql: String; const ArecValCam: TValidacoesDeBanco): String;
function fInformaPlanoContasFaturamento: String ;
function fAtivaPlanoContasSAI: String ;
function fAtivaPlanoContasCoeCos: String ;
function fPodeIncluirComSubconta(const AblnContaDebito, AblnContaCredito: Boolean): Boolean ;
function fUsarVeioNFQuandoValorEmCodVel: String ;
function fUsaHub: Boolean ;
function fTemColFreteHub: Boolean ;
function fTemColDescontoHub: Boolean ;
function fTemColAjusteHub: Boolean ;
function fAtivaFormasPagamentoCaixaCRC: String ;
function fTemCampoMultaCTP: Boolean ;
function fTiraEnter(strTexto: String): String;
function fRetornaNomeTabela(strString: String): String;
function fEhTabelaDeContabilidade(strTabela: string): boolean;
function fUsarAbrevProdNoCoeCos(): Boolean ;
function fCoalesceVenComCosCoe(const AstrCampo: String; const AblnUsaAbrevProd: Boolean): String ;
procedure pGravaLogContabil(strSQL, strTabela: string);
function fGerarPelaEmpresaBaixaCTP(): Boolean ;
function fEhAdmContabilidade(): Boolean ;
function fMostrarWarningGeracaoMovimento(AtipoMov: string): Boolean ;
function fObtemEmpresasFiliais(const AstrCodEmp: String): TConsultasArray ;
function fColunasComCfopServico(ArecParCon: TParametrosConsulta; const AstrEntSai: String): TList<Integer> ;
function fColunasComCfopCadfis(ArecParCon: TParametrosConsulta; const AstrEntSai: String): TList<Integer> ;
function fDescricaoCfgCCECTR: String ;
function fPlanoContasEmprestimoEntreEmpresasAtivo: String ;
function fDescricaoCfgPlanoContasEmprestimoEntreEmpresasAtivo: String ;
function fPlanoContasEmprestimoEntreEmpresasPassivo: String ;
function fDescricaoCfgPlanoContasEmprestimoEntreEmpresasPassivo: String ;
function fEmpresaGeracaoCtp(const AstrAliasComPonto: String; const AblnUsarEmpBai: Boolean): string;
function fCfgCarHub: Boolean;
function fCfgConHis: Boolean;
function fDesconsiderarFiltroDataFaturaCTR: Boolean ;
function fCarregaCodigoHistoricoCadCta(const strCodCta, strTipLan: string): integer;

function fPlanoContabilCadCtaPorEmpresa(const AstrCodigo, AstrCodEmp: String): String ;
function fPlanoContabilPortadorPorEmpresa(const AstrCodigo, AstrCodEmp: String): String ;
function fPlanoContabilClientePorEmpresa(const AstrCodigo, AstrCodEmp: String): String ;
function fPlanoContabilBandeiraPorEmpresa(const AstrCodigo, AstrCodEmp: String): String ;

function fCarregaDescricaoConta(const AstrConta, AstrEmpresa: string):string ;
function fCarregaContaReduzida(const AstrConta, AstrEmpresa: string):string ;

function fTemFechamento(const AdtaIni, AdtaFin: TDateTime; const AarrEmp: TConsultasArray): Boolean;

function fTemApenasNumeros(const AstrValor: String): Boolean ;
function fFieldVRECOF(const AblnColunaExiste: Boolean):string ;
function fFieldVREPIS(const AblnColunaExiste: Boolean):string ;
procedure pTrataSQLEstornoMovimentoContabil(var AqryDados: TUniQuery;
                                            const AdtaDtaIni,
                                                  AdtaDtaFin: TDateTime;
                                            const AstrCodEmp,
                                                  AstrIncDoc: String;
                                                  AarrIncDoc: TArrIncDoc;
                                            const AfltValor: double;
                                            const AstrCodOpe: string;
                                            const AstrConDeb: string;
                                            const AstrConCre: string;
                                            const AstrTipLan: String) ;
function fGetInEmpresas(const AarrEmpSel: TConsultasArray): string;
function fFiltroVigenciaParcon(const ADate: TDate; const Ativo: boolean = true): string; overload;
function fFiltroVigenciaParcon: string; overload;
function fCfgCtpAdf: string;
function fCfgParNat: string;
function fCarregaEntAdt(recParCon: TParametrosConsulta): TUniClientDataset;
function fCarregaEntAdtFis(recParCon: TParametrosConsulta): TUniClientDataset;
function fVerificaDeletaFechamento(const AstrCodEmp: String; const AdtaFechamento: TDateTime; var AstrMsgErro: String): Boolean;
function fCampoInssPatronalCadfisExiste: Boolean;
function fRetornaCampoInssPatronalCadfis: String;
procedure pRetornaCamposDelTabela(const AstrTabela: String; var AstrCampos, AstrCamposDel: String) ;
function fCfgCtpUif: string;
function fListaCfopsOutrasEntradas: String ;
procedure pVerificaColunasExitemValorContabil(var AColunasValorContabil: TSetColunasValorLiquidoContabil) ;
function fRetornaColunasADescontarValorContabil(const AColunasValorContabil: TSetColunasValorLiquidoContabil): string ;
function fTemParametroConfigurado(const ALista: TStringList; const ATipo: String): Boolean ;
function fCarregaListaParametrosConfigurados(): TStringList ;
procedure pSetaTextoProgresso(ApgbProgresso: TcxProgressBar; AstrTexto: String);
function fRetornaDictCamposTabelaExclusaoFec(): TDictionary<string, TRecCampos>;
function fPermiteContabilizarCCtransfAdtnoCtr: boolean ;
procedure pTrataExercicioCodEmp(const AValor: string; var AExercicio: Integer; var ACodEmp: String);
function fOperadorCitelLogado: Boolean;
function fContabilizarDespesasCobrancaCTR: Boolean;
procedure pRegistraLogAjcDelLancon(var Aqry: TUniQuery; var ALstLog: TObjectList<TLogAjcItem>; const ANomFrm: string; const ArrCampos: TArray<string>);
function fEhExclusaoLancamentoPartidaSimples(const AAutoInc: string; var AarrAutoIncs: Tarray<string>; var AqryLan: TUniQuery): boolean;
procedure pMostraLancamentosDependentesDaPartidaSimples(Const AqryLan: TUniQuery);
function fVerificaDeletaFechamentoFecFisFecFinCadFec(ADtaIni, ADtaFin: TDate; AstrCodEmp, AstrCodEmps: String; var AstrMsgErro: string ): boolean;

var
  VC_intTamCadIte : Integer;
  VC_intTemFecCon : Integer;
  VC_intTamCadEve : Integer;
  ProcExibirRelatorio: TProcedureExibirRelatorio;
  objShowModalFormContasPorEmpresa: IShowModalFormContasPorEmpresa;
  dicResultadoQuerySimplesCont: TDicResultadoQuerySimplesContabilidade;
  dicVersaoAutcomCont: TDictionary<String,String>;
  VC_StrVersaoContabilidade: String;
  VC_CarregaPlanoDeContasPorEmpresaInterno : TCarregaPlanoDeContasPorEmpresaInterno ;
  VC_SalvaPlanoDeContasPorEmpresaInterno : TSalvaPlanoDeContasPorEmpresaInterno ;
  VC_VerificaDeletaFechamento: TDeletaFechamentoFunc ;

implementation

uses untFuncoesSimples, StrUtils, SysUtils, untModulo, TypInfo,
  Contabilidade.Classes.TParametrosFormContasPorEmpresa,
  Contabilidade.Classes.TChaveDocInterprete, Contabilidade.Classes.Helpers,
  System.Types, DateUtils, MaskUtils, Variants, Vcl.StdCtrls, Vcl.Forms,
  Contabilidade.Classes.TValidaProcessoContaContabil,
  NetEncoding, RegularExpressions, untProximoCodigo,
  FireDAC.Stan.Param, FireDAC.Stan.Option,
  Contabilidade.View.MemoInfo, Contabilidade.Classes.UniQueryAuditoria ;

function fVerificaDeletaFechamento(const AstrCodEmp: String; const AdtaFechamento: TDateTime; var AstrMsgErro: String): Boolean;
begin
  Result := True ;
  if not Assigned(VC_VerificaDeletaFechamento) then
    Exit ;

  Result := VC_VerificaDeletaFechamento(AstrCodEmp, AdtaFechamento, AstrMsgErro) ;
end ;

function fCampoInssPatronalCadfisExiste: Boolean;
begin
  result := fCampoExiste('CADFIS', 'FIS_RINSSP') ;
end ;

function fRetornaCampoInssPatronalCadfis: String;
begin
  if fCampoInssPatronalCadfisExiste then
    result := 'CADFIS.FIS_RINSSP'
  else
    result := 'NULL' ;
end ;

procedure pRetornaCamposDelTabela(const AstrTabela: String; var AstrCampos, AstrCamposDel: String) ;
var
  LqryConsulta: TUniQuery ;
  LlstControle: TStringList ;
  LlstControleDel: TStringList ;
  LintCnt: Integer ;
  LstrTabelaDel: String ;
begin
  AstrCampos    := '' ;
  AstrCamposDel := '' ;

  if not fTabelaExiste(AstrTabela) then
    Exit;

  LstrTabelaDel := 'DEL_' + AstrTabela ;

  LqryConsulta := fCriaQuery() ;
  LlstControle := TStringList.Create ;
  LlstControleDel := TStringList.Create ;
  try

    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT * FROM ' + AstrTabela + ' WHERE FALSE ') ;
    LqryConsulta.Open ;

    for LintCnt := 0 to LqryConsulta.Fields.Count - 1 do
      LlstControle.Add(UpperCase(LqryConsulta.Fields.Fields[LintCnt].FieldName)) ;

    for LintCnt := 0 to LlstControle.Count - 1 do
      AstrCampos := AstrCampos + ifthen(fEmptyStr(AstrCampos), '', ', ') + LlstControle.Strings[LintCnt] ;

    if fTabelaExiste(LstrTabelaDel) then
    begin
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add('SELECT * FROM ' + LstrTabelaDel + ' WHERE FALSE ') ;
      LqryConsulta.Open ;

      for LintCnt := 0 to LqryConsulta.Fields.Count - 1 do
      begin
        if LlstControle.IndexOf(UpperCase(LqryConsulta.Fields.Fields[LintCnt].FieldName)) >= 0 then
          LlstControleDel.Add(UpperCase(LqryConsulta.Fields.Fields[LintCnt].FieldName)) ;
      end ;
      LlstControleDel.Add('OPEDEL') ;
      LlstControleDel.Add('DTADEL') ;
      LlstControleDel.Add('HORDEL') ;
      LlstControleDel.Add('MOTDEL') ;

      AstrCampos := AstrCampos + ', ' + fQuotedStr(strLoginUsuarioLogado) + ' AS OPEDEL ' ;
      AstrCampos := AstrCampos + ', CURRENT_DATE AS DTADEL ' ;
      AstrCampos := AstrCampos + ', CURRENT_TIME AS HORDEL ' ;
      AstrCampos := AstrCampos + ', NULL AS MOTDEL ' ;

      for LintCnt := 0 to LlstControleDel.Count-1 do
        AstrCamposDel := AstrCamposDel + ifthen(fEmptyStr(AstrCamposDel), '', ', ') + LlstControleDel.Strings[LintCnt] ;
    end ;

  finally
    FreeAndNil(LqryConsulta) ;
    FreeAndNil(LlstControle) ;
    FreeAndNil(LlstControleDel) ;
  end ;

end ;

function fFieldVRECOF(const AblnColunaExiste: Boolean): string;
begin
  if AblnColunaExiste then
    Result := 'FIS_VRECOF'
  else
    Result := 'CAST(0 AS DECIMAL(14,2))' ;
end;

function fFieldVREPIS(const AblnColunaExiste: Boolean): string;
begin
  if AblnColunaExiste then
    Result := 'FIS_VREPIS'
  else
    Result := 'CAST(0 AS DECIMAL(14,2))' ;
end;

procedure pTrataSQLEstornoMovimentoContabil(var AqryDados: TUniQuery;
                                            const AdtaDtaIni,
                                                  AdtaDtaFin: TDateTime;
                                            const AstrCodEmp,
                                                  AstrIncDoc: String;
                                                  AarrIncDoc: TArrIncDoc;
                                            const AfltValor: double;
                                            const AstrCodOpe: string;
                                            const AstrConDeb: string;
                                            const AstrConCre: string;
                                            const AstrTipLan: String) ;
begin
  AqryDados.Close;
  AqryDados.SQL.Clear;
  AqryDados.SQL.Add(' SELECT LANCNT.CNT_ORIGEM, LANCNT.CNT_CONTRO ');
  AqryDados.SQL.Add('   FROM LANCNT INNER JOIN LANCON ON LANCON.AUTOINCREM = LANCNT.CNT_ORIGEM ');
  if AstrTipLan = 'CTR' then
    AqryDados.SQL.Add('   INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');

  if not fEmptyStr(AstrTipLan) then
  begin
    AqryDados.SQL.Add(' WHERE CON_TIPLAN = :TIPLAN ');
    AqryDados.ParamByName('TIPLAN').AsString := AstrTipLan ;
  end
  else
  begin
    AqryDados.SQL.Add(' WHERE TRUE ');
  end ;

  if (AdtaDtaIni > 0) then
  begin
    AqryDados.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
    AqryDados.ParamByName('DTAINI').AsDateTime := AdtaDtaIni ;
    AqryDados.ParamByName('DTAFIN').AsDateTime := AdtaDtaFin ;
  end ;

  If Not fEmptyStr(AstrCodEmp) Then
  begin
    AqryDados.SQL.Add('  AND CASE WHEN LANCNT.CNT_ORIGEM <> LANCNT.CNT_CONTRO THEN LANCON.CON_EMPLAN = :CODEMP ELSE LANCNT.CNT_EMPORI = :CODEMP END ');
    AqryDados.ParamByName('CODEMP').AsString := AstrCodEmp;
  end;

  TTrataIncDocContabil
    .New
    .fColunaIncDoc('LANCON.CON_INCDOC')
    .fIncDoc(AstrIncDoc)
    .fArrIncDoc(AarrIncDoc)
    .fQuerySql(AqryDados)
    .fExecute ;

  if AfltValor <> 0.00 then
  begin
    AqryDados.SQL.Add('  AND CON_VALLAN = :VALLAN ');
    AqryDados.ParamByName('VALLAN').AsFloat := AfltValor ;
  end ;

  if not fEmptyStr(AstrCodOpe) then
  begin
    AqryDados.SQL.Add('  AND CON_CODOPE = :CODOPE ');
    AqryDados.ParamByName('CODOPE').AsString := AstrCodOpe;
  end ;

  if not fEmptyStr(fSemMascaraPlaNco(AstrConDeb)) then
  begin
    AqryDados.SQL.Add('  AND CON_CONDEB = :CONDEB ');
    AqryDados.ParamByName('CONDEB').AsString := fSemMascaraPlaNco(AstrConDeb);
  end ;

  if not fEmptyStr(fSemMascaraPlaNco(AstrConCre)) then
  begin
    AqryDados.SQL.Add('  AND CON_CONCRE = :CONCRE ');
    AqryDados.ParamByName('CONCRE').AsString := fSemMascaraPlaNco(AstrConCre);
  end ;

end ;

function fGetInEmpresas(const AarrEmpSel: TConsultasArray): string;
var
  intIndex : Integer;
begin
  Result := '' ;
  if Length(AarrEmpSel) > 0 Then
  begin
    For intIndex := Low(AarrEmpSel) To High(AarrEmpSel) Do
    Begin
      if not AarrEmpSel[intIndex].strCodigo.IsEmpty then
      begin
        If Result.IsEmpty then
          Result := QuotedStr(AarrEmpSel[intIndex].strCodigo)
        else
          Result := Result + ', ' + QuotedStr(AarrEmpSel[intIndex].strCodigo);
      end;
    end;
  end;

  if fEmptyStr(Result) then
    raise Exception.Create('Empresa de seleção não foi informada corretamente!');
end ;

function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
  Var
    c: Char;
begin
  Result := '';
  for c in strTexto do
    if (c <> chrFrom) then
      Result := Result + c
    Else If chrTo <> #0 Then
      Result := Result + chrTo;
end;

function fRetNomCfg(strCodCfg: String): String;
Begin
  If Not strCodCfg.StartsWith('CFG_') Then
    strCodCfg := 'CFG_' + strCodCfg;

  Result := fCampoTabela('SIS_DESCRI', 'CFGSIS', ['SIS_CODCFG','SIS_CODEMP'], [strCodCfg, VS_strCodEmp], False);
End;

function fCfgUticon:boolean ;
begin
  result := False ;
  if not fConfiguracaoExiste('UTICON') then
    exit;

  result := fCfgSis('UTICON', varBoolean) ;
end;

function fMskCon: String;
  const
    COMPL_MSK : String = ';0;_';
begin
  Result := fCfgSis('MSKCON', varString);

  If Not Result.EndsWith(COMPL_MSK) Then
    Result := Result + COMPL_MSK;
End;

procedure pCarregaTiposContabeis(Combo: TComboBoxFocus; blnFolhaPatrim: boolean = false; blnManual: boolean = false);
  Var
    intCnt : Integer;
begin
  Combo.Items.Clear;
  For intCnt := Ord(Low(TTiposContabeis)) To Ord(High(TTiposContabeis)) Do
  begin
    if (TTiposContabeis(intCnt) = tcANT) and (not fTabelaExiste('PAGANT')) then
      Continue;

    if not fPodeUsarTiposContabeisAgrupamento(TTiposContabeis(intCnt)) then
      Continue;

    if (TTiposContabeis(intCnt) = tcAJI) and (not fCfgSis('AJUICM', varBoolean)) then
      Continue;

    if (not fCfgSis('AJUPAR', varBoolean)) and ((TTiposContabeis(intCnt) = tcAJE) or (TTiposContabeis(intCnt) = tcAJS)) then
      Continue;

    Combo.Items.Add(DES_CONTABIL[TTiposContabeis(intCnt)]);
  end;

  if (blnFolhaPatrim) then
  begin
    Combo.Items.Add('FOL-Folha');
    Combo.Items.Add('PAT-Patrimonial');
    Combo.Items.Add('MOB-Dimob');
  end;

  if (blnManual) then
  begin
    Combo.Items.Add(DES_CONTABIL_MANUAL);
    Combo.Items.Add(DES_CONTABIL_IMPORTACAO);
  end;
end;

function fSiglasContabeis: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := Ord(Low(TTiposContabeis)) To Ord(High(TTiposContabeis)) Do
  Begin
    If fEmptyStr(Result) Then
      Result := DES_CONTABIL_SIGLA[TTiposContabeis(intCnt)] + '_'
    Else
      Result := Result + DES_CONTABIL_SIGLA[TTiposContabeis(intCnt)];
  End;
end;

function fSemMascaraPlaNco(strValor: String): String;
begin
  Result := fTiraCaracEspeciais(TrimRight(strValor), False, True, True, True, True, True);
end;

function fRemoveZerosEsquerda(strValor: String): String;
begin
  Result := strValor;
  while (Not fEmptyStr(Result)) And (LeftStr(Result, 1) = '0') do
    Result := Copy(Result, 2, Length(Result));
end;

procedure pPlanoDeContasPorEmpresaParametro(strTabela: String; strContaUnica: String; cdsDados: TUniClientDataSet; strCreDeb: String = '');
begin
  if not fEmptyStr(strContaUnica) then
  begin
    fMensagem('ATENÇÃO!', 'Já existe um plano de contas informado para esse ' + fDescritivoEntidade(strTabela) + ', será necessário remove-lo antes de informar o plano de contas desmembrado por empresa!', ['&Ok']);
    exit;
  end;

  objShowModalFormContasPorEmpresa.ShowModal(
    TParametrosFormContasPorEmpresa.New
      .Tabela(strTabela)
      .CampoChave(fCampoChave(strTabela))
      .CriaDataSet(False)
      .CdsDados(cdsDados)
      .CreditoDebito(strCreDeb)
   );
end;

function fVerificarPlanoDeContasPorEmpresa(strValorChave: String; strTabela: String; strContaContabil: string; AcdsNCO: TUniClientDataSet = nil):boolean;
var
  qryVerifica: TUniQuery ;
  LblnIsEmpty: Boolean ;
begin
  result := False ;

  if not fCfgSis('UTICON', varBoolean) then
    Exit(True) ;

  if fEmptyStr(fSemMascaraPlaNco(strContaContabil)) then
  begin
    result := True ;
    exit ;
  end;

  if fEmptyStr(strValorChave) then
  begin
    result := True ;
    exit ;
  end;

  qryVerifica := fCriaQuery() ;
  try
    while True do
    begin
      if not Assigned(AcdsNCO) then
      begin
        qryVerifica.Close ;
        qryVerifica.SQL.Clear ;
        qryVerifica.SQL.Add('SELECT * FROM ' + strTabela + ' WHERE ' + fCampoChave(strTabela) + ' = "' + strValorChave + '" ' ) ;
        qryVerifica.Open ;
        LblnIsEmpty := qryVerifica.IsEmpty ;
      end
      else
      begin
        LblnIsEmpty := AcdsNCO.IsEmpty ;
      end ;

      if LblnIsEmpty then
      begin
        break ;
      end;

      If (fMensagem('', 'Existe um plano de contas desmembrado por empresa, será necessário remove-lo antes de informar o plano de contas para o ' + fDescritivoEntidade(strTabela) + '!' + #13#10 + 'Deseja remover agora?', ['&Sim', '&Não'], 1) = 2) Then
      begin
        exit ;
      end;

      ////chama a manutenção de contas por empresa.
      pPlanoDeContasPorEmpresa(strValorChave, strTabela, '', dsBrowse, AcdsNCO) ;

    end;
  finally
    FreeAndNil(qryVerifica) ;
  end;
  result := True ;
end;

procedure pPlanoDeContasPorEmpresa(strValorChave: String; strTabela: String; strContaUnica: String; State: TDataSetState; AcdsNCO: TUniClientDataSet = nil; AblnAlteracaoDadosExterna: Boolean = False);
var
  LblnReadOnly: Boolean ;
begin
  if fEmptyStr(strValorChave) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um ' + fDescritivoEntidade(strTabela) + ' já gravado!', ['&Ok']);
    exit;
  end;

  if not fEmptyStr(strContaUnica) then
  begin
    fMensagem('ATENÇÃO!', 'Já existe um plano de contas informado para esse ' + fDescritivoEntidade(strTabela) + ', será necessário remove-lo antes de informar o plano de contas desmembrado por empresa!', ['&Ok']);
    exit;
  end;

  LblnReadOnly := False ;
  if not AblnAlteracaoDadosExterna then
  begin
    if State in [dsInsert, dsEdit] then
    begin
      fMensagem('ATENÇÃO!', 'É necessário salvar ou cancelar as alterações no registro selecionado!', ['&Ok']);
      exit;
    end;
  end
  else
  begin
    if not (State in [dsInsert, dsEdit]) then
    begin
      fMensagem('ATENÇÃO!', 'É necessário colocar o registro selecionado em modo de edição, caso precise alterar!', ['&Ok']);
      LblnReadOnly := True ;
    end;
  end ;

  objShowModalFormContasPorEmpresa.ShowModal(
    TParametrosFormContasPorEmpresa.New
      .Tabela(strTabela)
      .ValorChave(strValorChave)
      .CampoChave(fCampoChave(strTabela))
      .CdsDados(AcdsNCO)
      .CriaDataSet(not Assigned(AcdsNCO))
      .ReadOnly(LblnReadOnly)
   );
end;

function fDescritivoEntidade(strTabela: String): String;
begin
  result := '(entidade)';
  if strTabela = 'CLINCO' then
    result := 'cliente'
  else if strTabela = 'FORNCO' then
    result := 'fornecedor'
  else if strTabela = 'PORNCO' then
    result := 'portador'
  else if strTabela = 'CARNCO' then
    result := 'cartão'
  else if strTabela = 'CTANCO' then
    result := 'plano de contas'
  else if strTabela = 'PARNCO' then
    result := 'parâmetro contábil'
  else if strTabela = 'BANNCO' then
    result := 'bandeira';
end;

function fCampoChave(strTabela: String): String;
begin
  Result := '';
  if (strTabela = 'CLINCO') then
    result := 'NCO_CODCLI'
  else if strTabela = 'FORNCO' then
    result := 'NCO_CODFOR'
  else if strTabela = 'PORNCO' then
    result := 'NCO_CODPOR'
  else if strTabela = 'CARNCO' then
    result := 'NCO_CODCAR'
  else if strTabela = 'CTANCO' then
    result := 'NCO_CODCTA'
  else if strTabela = 'PARNCO' then
    result := 'NCO_MD5KEY'
  else if strTabela = 'BANNCO' then
    result := 'NCO_CODBAN';
end;

function fParNco(const strSeqPar, strCodEmp, strCreDeb: string): string;
var
  LqryParNco: TUniQuery;
begin
  Result := '';

  if fEmptyStr(strCodEmp) or fEmptyStr(strCreDeb) then
    Exit;

  if fEmptyStr(strSeqPar) then
    Exit;

  LqryParNco := fCriaQuery();
  try
    LqryParNco.SQL.Add('SELECT NCO_CODCON ');
    LqryParNco.SQL.Add('FROM PARNCO ');
    LqryParNco.SQL.Add('WHERE TRUE ');
    LqryParNco.SQL.Add('  AND NCO_CODEMP = :CODEMP ');
    LqryParNco.SQL.Add('  AND NCO_CREDEB = :CREDEB ');
    LqryParNco.SQL.Add('  AND ' + fParNcoWhereSql(strSeqPar));
    LqryParNco.SQL.Add('LIMIT 1 ');
    LqryParNco.ParamByName('CODEMP').AsString := strCodEmp;
    LqryParNco.ParamByName('CREDEB').AsString := strCreDeb;
    LqryParNco.Open;

    if LqryParNco.RecordCount > 0 then
      Result := LqryParNco.FieldByName('NCO_CODCON').AsString;
  finally
    FreeAndNil(LqryParNco);
  end;
end;

function fParNcoWhereSql(const strSeqPar: string): string;
begin
  if fEmptyStr(strSeqPar) then
  begin
    Result := ' FALSE ';
    Exit;
  end;

  Result := ' CON_SEQPAR = ' + QuotedStr(strSeqPar);
end;

function fGetSqlLastAutoIncLanCon: string;
var
  strSQL : string;
begin
  strSQL := '' ;
  strSQL := strSQL + 'SELECT LAST_INSERT_ID()' ;
  Result := strSQL ;
end;

function fGetSqlInsertLanCnt: string;
var
  strSQL : string;
begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO LANCNT ( ';
  strSQL := strSQL + ' CNT_ORIGEM, ';
  strSQL := strSQL + ' CNT_CONTRO) ';
  strSQL := strSQL + ' VALUES ';
  strSQL := strSQL + ' (:ORIGEM, ';
  strSQL := strSQL + '  :CONTRO); ';
  Result := strSQL;
end;

function fGetSqlInsertLanCon: string;
  var
    strSQL : string;
    blnCON_TABELA : boolean;
    blnCON_CCUSCR : boolean ;
    blnCON_PAGAME : boolean ;
    blnCON_VERSIS : boolean ;
    blnCON_EMPLOG : boolean ;
    blnCON_FORPGO : boolean ;

    blnCON_CLIFOR : boolean ;
    blnCON_TIP_FC : boolean ;
    blnCON_SEQPAR: boolean;
    blnCON_INVNCO: boolean;
    blnCON_TPORIC: boolean;
    blnCON_CDORIC: boolean;
    blnCON_OPBCCR: boolean;
    blnCON_TPORID: boolean;
    blnCON_CDORID: boolean;
    blnCON_OPBCDB: boolean;
    blnCON_NUMDOC: boolean;
begin
  blnCON_TABELA := fCampoExiste('LANCON', 'CON_TABELA');
  blnCON_CCUSCR := fCampoExiste('LANCON', 'CON_CCUSCR');
  blnCON_PAGAME := fCampoExiste('LANCON', 'CON_PAGAME');
  blnCON_VERSIS := fCampoExiste('LANCON', 'CON_VERSIS');
  blnCON_EMPLOG := fCampoExiste('LANCON', 'CON_EMPLOG');
  blnCON_FORPGO := fCampoExiste('LANCON', 'CON_FORPGO');

  blnCON_CLIFOR := fCampoExiste('LANCON', 'CON_CLIFOR');
  blnCON_TIP_FC := fCampoExiste('LANCON', 'CON_TIP_FC');
  blnCON_SEQPAR := fCampoExiste('LANCON', 'CON_SEQPAR');
  blnCON_INVNCO := fCampoExiste('LANCON', 'CON_INVNCO');
  blnCON_TPORIC := fCampoExiste('LANCON', 'CON_TPORIC');
  blnCON_CDORIC := fCampoExiste('LANCON', 'CON_CDORIC');
  blnCON_OPBCCR := fCampoExiste('LANCON', 'CON_OPBCCR');
  blnCON_TPORID := fCampoExiste('LANCON', 'CON_TPORID');
  blnCON_CDORID := fCampoExiste('LANCON', 'CON_CDORID');
  blnCON_OPBCDB := fCampoExiste('LANCON', 'CON_OPBCDB');
  blnCON_NUMDOC := fCampoExiste('LANCON', 'CON_NUMDOC');

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO LANCON ( ';
  strSQL := strSQL + '  CON_EMPLAN, ';
  strSQL := strSQL + '  CON_DTALAN, ';
  strSQL := strSQL + '  CON_TIPLAN, ';
  strSQL := strSQL + '  CON_CLAFIS, ';
  strSQL := strSQL + '  CON_NATOPE, ';
  strSQL := strSQL + '  CON_DESVAL, ';
  strSQL := strSQL + '  CON_CONCRE, ';
  strSQL := strSQL + '  CON_CONDEB, ';
  strSQL := strSQL + '  CON_HISPAD, ';
  strSQL := strSQL + '  CON_HISTOR, ';
  strSQL := strSQL + '  CON_VALLAN, ';
  strSQL := strSQL + '  CON_AUTOMA, ';
  strSQL := strSQL + '  CON_CCUSTO, ';
  strSQL := strSQL + '  CON_CODOPE, ';

  if (blnCON_TABELA) then
    strSQL := strSQL + ' CON_TABELA, ';

  if (blnCON_CCUSCR) then
    strSQL := strSQL + ' CON_CCUSCR, ';

  if (blnCON_PAGAME) then
    strSQL := strSQL + ' CON_PAGAME, ';

  if (blnCON_VERSIS) then
    strSQL := strSQL + ' CON_VERSIS, ';

  if (blnCON_EMPLOG) then
    strSQL := strSQL + ' CON_EMPLOG, ';

  if (blnCON_FORPGO) then
    strSQL := strSQL + ' CON_FORPGO, ';

  if (blnCON_CLIFOR) then
    strSQL := strSQL + '  CON_CLIFOR,  ';

  if (blnCON_TIP_FC) then
    strSQL := strSQL + '  CON_TIP_FC,  ';

  if (blnCON_SEQPAR) then
    strSQL := strSQL + '  CON_SEQPAR,  ';

  if (blnCON_INVNCO) then
    strSQL := strSQL + '  CON_INVNCO,  ';

  if (blnCON_TPORIC) then
    strSQL := strSQL + '  CON_TPORIC,  ';

  if (blnCON_CDORIC) then
    strSQL := strSQL + '  CON_CDORIC,  ';

  if (blnCON_OPBCCR) then
    strSQL := strSQL + '  CON_OPBCCR,  ';

  if (blnCON_TPORID) then
    strSQL := strSQL + '  CON_TPORID,  ';

  if (blnCON_CDORID) then
    strSQL := strSQL + '  CON_CDORID,  ';

  if (blnCON_OPBCDB) then
    strSQL := strSQL + '  CON_OPBCDB,  ';

  if (blnCON_NUMDOC) then
    strSQL := strSQL + '  CON_NUMDOC,  ';

  strSQL := strSQL + '  CON_INCDOC  ';
  strSQL := strSQL + ' ) ';
  strSQL := strSQL + 'VALUES ';
  strSQL := strSQL + '   (:EMPRESA, ';
  strSQL := strSQL + '   :DTALAN, ';
  strSQL := strSQL + '   :TIPOLAN, ';
  strSQL := strSQL + '   :CFOP, ';
  strSQL := strSQL + '   :NATOPE, ';
  strSQL := strSQL + '   :DESVAL, ';
  strSQL := strSQL + '   :CONCRE, ';
  strSQL := strSQL + '   :CONDEB, ';
  strSQL := strSQL + '   :HISPAD, ';
  strSQL := strSQL + '   :HISTOR, ';
  strSQL := strSQL + '   :VALLAN, ';
  strSQL := strSQL + '   :AUTOMA, ';
  strSQL := strSQL + '   :CCUSTO, ';
  strSQL := strSQL + '   :CODOPE, ';

  if (blnCON_TABELA) then
    strSQL := strSQL + ' :TABELA, ';

  if (blnCON_CCUSCR) then
    strSQL := strSQL + '   :CCUSCR, ';

  if (blnCON_PAGAME) then
    strSQL := strSQL + '   :PAGAME, ';

  if (blnCON_VERSIS) then
    strSQL := strSQL + '   :VERSIS, ';

  if (blnCON_EMPLOG) then
    strSQL := strSQL + '   :EMPLOG, ';

  if (blnCON_FORPGO) then
    strSQL := strSQL + '   :FORPGO, ';

  if (blnCON_CLIFOR) then
    strSQL := strSQL + '   :CLIFOR,  ';

  if (blnCON_TIP_FC) then
    strSQL := strSQL + '   :TIP_FC,  ';

  if (blnCON_SEQPAR) then
    strSQL := strSQL + '   :SEQPAR,  ';

  if (blnCON_INVNCO) then
    strSQL := strSQL + '   :INVNCO,  ';

  if (blnCON_TPORIC) then
    strSQL := strSQL + '   :TPORIC,  ';

  if (blnCON_CDORIC) then
    strSQL := strSQL + '   :CDORIC,  ';

  if (blnCON_OPBCCR) then
    strSQL := strSQL + '   :OPBCCR,  ';

  if (blnCON_TPORID) then
    strSQL := strSQL + '   :TPORID,  ';

  if (blnCON_CDORID) then
    strSQL := strSQL + '   :CDORID,  ';

  if (blnCON_OPBCDB) then
    strSQL := strSQL + '   :OPBCDB,  ';

  if (blnCON_NUMDOC) then
    strSQL := strSQL + '   :NUMDOC,  ';

  strSQL := strSQL + '   :INCDOC) ';
  Result := strSQL;
end;

function fGetSqlInsertTrnCnt: string;
var
  LstrSQL : string ;
begin
  LstrSQL := '';
  LstrSQL := LstrSQL + ' INSERT INTO TRNCNT ( ';
  LstrSQL := LstrSQL + ' TRN_CNTORI, ';
  LstrSQL := LstrSQL + ' TRN_CNTNOV, ';
  LstrSQL := LstrSQL + ' TRN_CREDEB, ';
  LstrSQL := LstrSQL + ' TRN_CODOPE, ';
  LstrSQL := LstrSQL + ' TRN_DTATRN, ';
  LstrSQL := LstrSQL + ' TRN_HRATRN, ';
  LstrSQL := LstrSQL + ' TRN_LANCON) ';
  LstrSQL := LstrSQL + ' VALUES ( ';
  LstrSQL := LstrSQL + ' :CNTORI, ';
  LstrSQL := LstrSQL + ' :CNTNOV, ';
  LstrSQL := LstrSQL + ' :CREDEB, ';
  LstrSQL := LstrSQL + ' :CODOPE, ';
  LstrSQL := LstrSQL + ' :DTATRN, ';
  LstrSQL := LstrSQL + ' :HRATRN, ';
  LstrSQL := LstrSQL + ' :LANCON) ; ';
  Result := LstrSQL;
end ;

function fGetSqlUpdateLanconTrnCntDebito: string;
var
  LstrSQL : string ;
begin
  LstrSQL := ' UPDATE LANCON SET CON_CONDEB = :CONDEB, CON_AUTMOD = CASE WHEN CON_AUTOMA = 1 THEN "S" ELSE "N" END WHERE AUTOINCREM = :AUTOINCREM ; ';
  Result := LstrSQL;
end ;

function fGetSqlUpdateLanconTrnCntCredito: string;
var
  LstrSQL : string ;
begin
  LstrSQL := ' UPDATE LANCON SET CON_CONCRE = :CONCRE, CON_AUTMOD = CASE WHEN CON_AUTOMA = 1 THEN "S" ELSE "N" END WHERE AUTOINCREM = :AUTOINCREM ; ';
  Result := LstrSQL;
end ;

function fGetSqlInsertLanMes: string;
  var
    strSQL : string;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO LANMES ( ';
  strSQL := strSQL + '  CON_EMPLAN, ';
  strSQL := strSQL + '  CON_DTALAN, ';
  strSQL := strSQL + '  CON_TIPLAN, ';
  strSQL := strSQL + '  CON_CLAFIS, ';
  strSQL := strSQL + '  CON_NATOPE, ';
  strSQL := strSQL + '  CON_DESVAL, ';
  strSQL := strSQL + '  CON_CONCRE, ';
  strSQL := strSQL + '  CON_CONDEB, ';
  strSQL := strSQL + '  CON_HISPAD, ';
  strSQL := strSQL + '  CON_HISTOR, ';
  strSQL := strSQL + '  CON_VALLAN, ';
  strSQL := strSQL + '  CON_AUTOMA, ';
  strSQL := strSQL + '  CON_CODOPE, ';
  strSQL := strSQL + '  CON_CCUSTO, ';
  strSQL := strSQL + '  CON_INCDOC  ';
  strSQL := strSQL + ' ) ';
  strSQL := strSQL + 'VALUES ';
  strSQL := strSQL + '  (:EMPLAN, ';
  strSQL := strSQL + '   :DTALAN, ';
  strSQL := strSQL + '   :TIPLAN, ';
  strSQL := strSQL + '   :CLAFIS, ';
  strSQL := strSQL + '   :NATOPE, ';
  strSQL := strSQL + '   :DESVAL, ';
  strSQL := strSQL + '   :CONCRE, ';
  strSQL := strSQL + '   :CONDEB, ';
  strSQL := strSQL + '   :HISPAD, ';
  strSQL := strSQL + '   :HISTOR, ';
  strSQL := strSQL + '   :VALLAN, ';
  strSQL := strSQL + '   :AUTOMA, ';
  strSQL := strSQL + '   :CODOPE, ';
  strSQL := strSQL + '   :CCUSTO, ';
  strSQL := strSQL + '   :INCDOC) ';
  Result := strSQL;
end;

function fGetSqlInsertLanDet: string;
var
  strSQL : string;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO LANDET ( ';
  strSQL := strSQL + 'DET_DTAMOV, ';
  strSQL := strSQL + 'DET_CODCON, ';
  strSQL := strSQL + 'DET_CCUSTO, ';
  strSQL := strSQL + 'DET_CODEMP, ';
  strSQL := strSQL + 'DET_EMPDET, ';
  strSQL := strSQL + 'DET_SALFIN, ';
  strSQL := strSQL + 'DET_SALANT, ';
  strSQL := strSQL + 'DET_CRDEFI, ';
  strSQL := strSQL + 'DET_CRDEAN, ';
  strSQL := strSQL + 'DET_CREDIT, ';
  strSQL := strSQL + 'DET_DEBITO ';
  strSQL := strSQL + ') VALUES ( ';
  strSQL := strSQL + ':DTAMOV, ';
  strSQL := strSQL + ':CODCON, ';
  strSQL := strSQL + ':CCUSTO, ';
  strSQL := strSQL + ':CODEMP, ';
  strSQL := strSQL + ':EMPDET, ';
  strSQL := strSQL + ':SALFIN, ';
  strSQL := strSQL + ':SALANT, ';
  strSQL := strSQL + ':CRDEFI, ';
  strSQL := strSQL + ':CRDEAN, ';
  strSQL := strSQL + ':CREDIT, ';
  strSQL := strSQL + ':DEBITO ';
  strSQL := strSQL + ') ';

  Result := strSQL;
end;

function fGetSQLInsertLogAjc: string;
var
  strSQL : string;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO LOGAJC (';
  strSQL := strSQL + 'LOG_CODEMP, ';
  strSQL := strSQL + 'LOG_DTAALT, ';
  strSQL := strSQL + 'LOG_HRAALT, ';
  strSQL := strSQL + 'LOG_CODOPE, ';
  strSQL := strSQL + 'LOG_TABELA, ';
  strSQL := strSQL + 'LOG_INCDOC, ';
  strSQL := strSQL + 'LOG_TIPAJU, ';
  strSQL := strSQL + 'LOG_COLUNA, ';
  strSQL := strSQL + 'LOG_VALANT, ';
  strSQL := strSQL + 'LOG_VALATU, ';
  strSQL := strSQL + 'LOG_NOMFRM, ';
  strSQL := strSQL + 'LOG_SEQAJU ';
  strSQL := strSQL + ') VALUES ( ';
  strSQL := strSQL + ':CODEMP, ';
  strSQL := strSQL + ':DTAALT, ';
  strSQL := strSQL + ':HRAALT, ';
  strSQL := strSQL + ':CODOPE, ';
  strSQL := strSQL + ':TABELA, ';
  strSQL := strSQL + ':INCDOC, ';
  strSQL := strSQL + ':TIPAJU, ';
  strSQL := strSQL + ':COLUNA, ';
  strSQL := strSQL + ':VALANT, ';
  strSQL := strSQL + ':VALATU, ';
  strSQL := strSQL + ':NOMFRM, ';
  strSQL := strSQL + ':SEQAJU ';
  strSQL := strSQL + ') ';

  Result := strSQL;
end;

const
  { INFORMATION_SCHEMA em vez de SELECT na tabela alvo: tabela ausente devolve conjunto
    vazio, não exceção. Sobra exceção só para falha de verdade - conexão caída, timeout,
    permissão -, e é isso que permite separar staNaoExiste de staFalhou sem depender de
    código de erro do servidor. As duas sobrecargas usam este mesmo SQL; o que muda entre
    elas é só o DAC. }
  CSQLSondaTabelaContabil = 'SELECT 1 '                         +
                            '  FROM INFORMATION_SCHEMA.TABLES ' +
                            ' WHERE TABLE_SCHEMA = DATABASE() ' +
                            '   AND TABLE_NAME   = :TABELA ';

function fSondarTabelaContabil(const AstrTabela: String; const AConexao: TUniConnection): TSondaTabela;
  Var
    LqrySonda: TUniQuery;
begin
  Result := staFalhou;

  If (Trim(AstrTabela) = '') Or (Not Assigned(AConexao)) Then
    Exit;

  Try
    LqrySonda := TUniQuery.Create(Nil);
    Try
      LqrySonda.Connection := AConexao;
      LqrySonda.SQL.Text := CSQLSondaTabelaContabil;
      LqrySonda.ParamByName('TABELA').AsString := UpperCase(Trim(AstrTabela));
      LqrySonda.Open;

      If LqrySonda.IsEmpty Then
        Result := staNaoExiste
      Else
        Result := staExiste;
    Finally
      FreeAndNil(LqrySonda);
    End;
  Except
    Result := staFalhou;
  End;
end;

function fSondarTabelaContabil(const AstrTabela: String; const AConexao: TFDConnection): TSondaTabela;
  Var
    LqrySonda: TFDQuery;
begin
  Result := staFalhou;

  If (Trim(AstrTabela) = '') Or (Not Assigned(AConexao)) Then
    Exit;

  Try
    LqrySonda := TFDQuery.Create(Nil);
    Try
      LqrySonda.Connection := AConexao;
      LqrySonda.SQL.Text := CSQLSondaTabelaContabil;
      LqrySonda.ParamByName('TABELA').AsString := UpperCase(Trim(AstrTabela));
      LqrySonda.Open;

      If LqrySonda.IsEmpty Then
        Result := staNaoExiste
      Else
        Result := staExiste;
    Finally
      FreeAndNil(LqrySonda);
    End;
  Except
    Result := staFalhou;
  End;
end;

function fEhCreditoClienteComAdiantamento(const AstrTipoLancamento, AstrFormPagto, AstrEspDoc: String; const AfltValorLancamento: Double): Boolean ;
begin
  Result := False ;
  if AstrTipoLancamento <> 'CTR' then
    Exit ;

  if AstrFormPagto <> FPG_ADIANTAMENTO then
    Exit ;

  if AstrEspDoc <> 'CC' then
    Exit ;

  if AfltValorLancamento >= 0 then
    Exit ;

  Result := True ;
end ;

function fInverterContas(strTipoLancamento: string; fltValorLancamento: double; blnEstorno: boolean; strFormPagto: string; const AstrEspDoc: String): boolean;
begin
  if (blnEstorno) then
    Exit(True);

  result := False;
  if ((strTipoLancamento = 'CTR') or
     (strTipoLancamento = 'CTP') or
     (strTipoLancamento = 'ENT'))  then
  begin
    if (strFormPagto = FPG_CREDITO) or (fEhCreditoClienteComAdiantamento(strTipoLancamento, strFormPagto, AstrEspDoc, fltValorLancamento)) then
    begin
      result := False;
      exit ;
    end;
    Result := (fltValorLancamento < 0);
  end;
end;

function fSetouValorNaPropriedadeSeExiste(Instance: TObject; const PropName: string; const Value: Variant): boolean;
begin
  try
    Result := True;
    SetPropValue(Instance, PropName, Value);
  except
    on E: EPropertyError do
      Result := False;
  end;
end;

function fUtilizaNaturezaDeOperacao(strTipLan: string): boolean;
begin
  Result := MatchStr(strTipLan, ['ENT', 'SAI', 'COE', 'COS', 'CMV']);
end;

function fRetornaEventosNaoExportar: string;
  var
    qryEveNec : TUniQuery;
begin
  Result := '';
  if Not fTabelaExiste('EVENEC') then
    Exit;

  qryEveNec := fCriaQuery(nil);
  try
    qryEveNec.Close;
    qryEveNec.SQL.Clear;
    qryEveNec.SQL.Add(' SELECT ENE_CODEVE ');
    qryEveNec.SQL.Add('   FROM EVENEC ');
    qryEveNec.SQL.Add('  WHERE ');
    qryEveNec.SQL.Add('    ENE_CODEMP = :CODEMP ');
    qryEveNec.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryEveNec.Open;

    While Not qryEveNec.Eof Do
    Begin
      Result := Result + qryEveNec.FieldByName('ENE_CODEVE').AsString + '_';

      qryEveNec.Next;
    End;

    qryEveNec.Close;
  finally
    FreeAndNil(qryEveNec);
  end;
end;

function fGetIndexTipLan(Items: TStrings; strTipLan: String): Integer;
  Var
   intCnt : Integer;
begin
  Result := -1;
  For intCnt := 0 To Items.Count-1 Do
  Begin
    If (LeftStr(Items[intCnt], 3) = LeftStr(strTipLan, 3)) Then
    Begin
      Result := intCnt;
      Break;
    End;
  End;
end;

// Contabilidade.Funcoes
function fTamCodIte: Integer;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    intPosInicial, intQtde: Integer;
begin
  Result := VC_intTamCadIte;

  If VC_intTamCadIte > 0 Then
    Exit;

  qryGen := fCriaQuery;
  Try
    strSQL := 'DESC CADITE;';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While (Not Eof) Do
      Begin
        If FieldByName('Field').asString = 'ITE_CODITE' Then
        Begin
          intPosInicial := Pos('(',FieldByName('Type').asString)+1;
          intQtde       := Pos(')',FieldByName('Type').asString) - intPosInicial;
          Result        := StrToInt( Copy( FieldByName('Type').asString, intPosInicial, intQtde ) );
          VC_intTamCadIte := Result;
          Break;
        End;
        Next;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fTamCodEve: Integer;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    intPosInicial, intQtde: Integer;
begin
  Result := VC_intTamCadEve;

  If VC_intTamCadEve > 0 Then
    Exit;

  qryGen := fCriaQuery;
  Try
    strSQL := 'DESC CADEVE;';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While (Not Eof) Do
      Begin
        If FieldByName('Field').asString = 'EVE_CODEVE' Then
        Begin
          intPosInicial := Pos('(',FieldByName('Type').asString)+1;
          intQtde       := Pos(')',FieldByName('Type').asString) - intPosInicial;
          Result        := StrToInt( Copy( FieldByName('Type').asString, intPosInicial, intQtde ) );
          VC_intTamCadEve := Result;
          Break;
        End;
        Next;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fPeriodoFechado(const ADtaIni, ADtaFin: TDateTime; strCodEmp: String): boolean;
  var
    qryLanCon: TUniQuery;
    LstrInEmpresas: string;
begin
  Result := False;

  If (VC_intTemFecCon = -1) Then
  begin
    if fTabelaExiste('FECCON') then
      VC_intTemFecCon := 1
    else
      VC_intTemFecCon := 0;
  end
  else if (VC_intTemFecCon = 0) then
    exit;

  try
    LstrInEmpresas := fGetInEmpresas(fObtemEmpresasFiliais(strCodEmp));
  except
    LstrInEmpresas := strCodEmp;
  end;

  qryLanCon := fCriaQuery;
  Try
    qryLanCon.Close;
    qryLanCon.SQL.Clear;
    qryLanCon.SQL.Add(' SELECT COUNT(*) CNT ');
    qryLanCon.SQL.Add('   FROM FECCON ');
    qryLanCon.SQL.Add('  WHERE IFNULL(CON_CODEMP, "") IN ('+LstrInEmpresas+') ');
    qryLanCon.SQL.Add('    AND :DTAINI <= COALESCE(CON_FECFIN,"9999-01-01") AND :DTAFIN >= COALESCE(CON_FECINI,"0001-01-01") ');
    qryLanCon.ParamByName('DTAINI').AsDate := ADtaIni;
    qryLanCon.ParamByName('DTAFIN').AsDate := ADtaFin;
    qryLanCon.Open;
    Result := (qryLanCon.FieldByName('CNT').AsInteger > 0);
    qryLanCon.Close;
  Finally
    FreeAndNil(qryLanCon);
  End;
end;

function fFechamentoContabilAteData(const ADtaLan: TDateTime; const AstrInEmpresas: String; out AstrMensagem: String): boolean;
var
  LqryFecCon: TUniQuery;
begin
  Result := False;
  AstrMensagem := '';

  If (VC_intTemFecCon = -1) Then
  begin
    if fTabelaExiste('FECCON') then
      VC_intTemFecCon := 1
    else
      VC_intTemFecCon := 0;
  end;
  if (VC_intTemFecCon = 0) then
    Exit;

  // Vale o ultimo fechamento, nao so os periodos fechados: data igual ou anterior a ele fica
  // bloqueada mesmo antes do primeiro periodo (Req. 469576). Abrange a regra de fPeriodoFechado,
  // que so bloqueia data dentro de um periodo; CON_FECFIN nulo segue como periodo sem fim.
  // Sem empresa (geracao de todas), vale o fechamento de qualquer empresa.
  LqryFecCon := fCriaQuery;
  try
    LqryFecCon.SQL.Add(' SELECT CON_CODEMP, CON_FECFIN ');
    LqryFecCon.SQL.Add('   FROM FECCON ');
    LqryFecCon.SQL.Add('  WHERE :DTALAN <= COALESCE(CON_FECFIN, "9999-01-01") ');
    if not fEmptyStr(AstrInEmpresas) then
      LqryFecCon.SQL.Add('    AND IFNULL(CON_CODEMP, "") IN (' + AstrInEmpresas + ') ');
    LqryFecCon.SQL.Add('  ORDER BY COALESCE(CON_FECFIN, "9999-01-01") DESC ');
    LqryFecCon.SQL.Add('  LIMIT 1 ');
    LqryFecCon.ParamByName('DTALAN').AsDate := ADtaLan;
    LqryFecCon.Open;

    Result := not LqryFecCon.IsEmpty;
    if Result then
    begin
      AstrMensagem := 'Lançamento com data ' + FormatDateTime('dd/mm/yyyy', ADtaLan) + ' não permitido: ';
      if fEmptyStr(LqryFecCon.FieldByName('CON_CODEMP').AsString) then
        AstrMensagem := AstrMensagem + 'existe fechamento contábil'
      else
        AstrMensagem := AstrMensagem + 'a empresa ' + LqryFecCon.FieldByName('CON_CODEMP').AsString + ' tem fechamento contábil';
      if LqryFecCon.FieldByName('CON_FECFIN').IsNull then
        AstrMensagem := AstrMensagem + ' sem data final.'
      else
        AstrMensagem := AstrMensagem + ' até ' + FormatDateTime('dd/mm/yyyy', LqryFecCon.FieldByName('CON_FECFIN').AsDateTime) + '.';
    end;
  finally
    FreeAndNil(LqryFecCon);
  end;
end;

function fLancamentoAnteriorFechamento(const ADtaLan: TDateTime; const AstrCodEmp: String; out AstrMensagem: String): boolean;
var
  LarrEmpresas: TConsultasArray;
  LstrInEmpresas: string;
begin
  // Empresas da mesma raiz de CNPJ, como em fPeriodoFechado; sem CNPJ, so a propria
  if fEmptyStr(AstrCodEmp) then
    Exit(fFechamentoContabilAteData(ADtaLan, '', AstrMensagem));

  LarrEmpresas := fObtemEmpresasFiliais(AstrCodEmp);
  if Length(LarrEmpresas) = 0 then
    LstrInEmpresas := QuotedStr(AstrCodEmp)
  else
    LstrInEmpresas := fGetInEmpresas(LarrEmpresas);

  Result := fFechamentoContabilAteData(ADtaLan, LstrInEmpresas, AstrMensagem);
end;

procedure pGravarPlanoContasAutomatico(qryTabela: TUniQuery; dbePlaNco: TDBEditFocus; strFieldConta: string; strNomeConta: string);
  var
    strCodCon : String;
    blnMesmaContaParaTodasAsEmpresas : boolean;
    blnFornecedor : boolean;
begin
  blnFornecedor := strFieldConta.Contains('FOR_');
  If (fCfgUticon) And (fEmptyStr(dbePlaNco.Text)) And (qryTabela.State = dsInsert) And
     (fCfgSis('OPCPLC', varString) = 'A') And
     (Not fEmptyStr(fCfgSis(fConfiguracaoGrupoPlanoContas(blnFornecedor), varString))) Then
  Begin
    blnMesmaContaParaTodasAsEmpresas := True;
    if fConfiguracaoExiste('CCCEMP') then
      blnMesmaContaParaTodasAsEmpresas := fCfgSis('CCCEMP', varBoolean);

    if (blnMesmaContaParaTodasAsEmpresas) then
    begin
      pGravarContaContabil(strNomeConta, VS_strCodEmp, strCodCon, blnFornecedor);
      if not fEmptyStr(strCodCon) then
        qryTabela.FieldByName(strFieldConta).AsString := strCodCon;
    end;
  End;
end;

procedure pGravarPlanoContasAutomaticoParaCadaEmpresa(qryTabela: TUniQuery; dbePlaNco: TDBEditFocus; strFieldConta: string; strNomeConta: string);

  function fFieldCodigoPessoa: string;
  begin
    Result := '';
    if (strFieldConta = 'CLI_PLANCO') then
      Result := 'CLI_CODCLI'
    else if (strFieldConta = 'FOR_PLANCO') then
      Result := 'FOR_CODFOR';
  end;

  var
    strCodCon : String;
    blnMesmaContaParaTodasAsEmpresas : boolean;
    qryCadEmp : TUniQuery;
    blnFornecedor : boolean;
begin
  blnFornecedor := strFieldConta.Contains('FOR_');
  If (fCfgUticon) And (fEmptyStr(dbePlaNco.Text)) And (qryTabela.State = dsBrowse) And
     (fCfgSis('OPCPLC', varString) = 'A') And
     (Not fEmptyStr(fCfgSis(fConfiguracaoGrupoPlanoContas(blnFornecedor), varString))) Then
  Begin
    blnMesmaContaParaTodasAsEmpresas := True;
    if fConfiguracaoExiste('CCCEMP') then
      blnMesmaContaParaTodasAsEmpresas := fCfgSis('CCCEMP', varBoolean);

    if (blnMesmaContaParaTodasAsEmpresas) then
      exit;

    if fEmptyStr(fFieldCodigoPessoa) then
      exit;

    if not Assigned(qryTabela.FindField(fFieldCodigoPessoa)) then
      exit;

    if fEmptyStr(qryTabela.FieldByName(fFieldCodigoPessoa).AsString) then
      exit;

    qryCadEmp := fCriaQuery;
    try
      qryCadEmp.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP ORDER BY EMP_CODEMP';
      qryCadEmp.Open;
      qryCadEmp.First;
      while not qryCadEmp.Eof do
      begin
        if fJaExisteContaNaEmpresa(qryTabela.FieldByName(fFieldCodigoPessoa).AsString, qryCadEmp.FieldByName('EMP_CODEMP').AsString, fFieldCodigoPessoa) then
        begin
          qryCadEmp.Next;
          Continue;
        end;

        pGravarContaContabil(strNomeConta, qryCadEmp.FieldByName('EMP_CODEMP').AsString, strCodCon, blnFornecedor);
        if (not fEmptyStr(strCodCon)) then
          pGravaContaContabilDeCadaEmpresa(strFieldConta, strCodCon, qryTabela.FieldByName(fFieldCodigoPessoa).AsString, qryCadEmp.FieldByName('EMP_CODEMP').AsString);
        qryCadEmp.Next;
      end;
    finally
      FreeAndNil(qryCadEmp);
    end;
  End;
end;

function fCreateItemLogExcFec(AqryLog: TFDQuery; ATabela, AColuna: string; ADtaAlt: TDate; AHraAlt: TTime): TLogAjcItem;
begin
  Result := TLogAjcItem.Create;
  Result.CodEmp := VS_strCodEmp;
  Result.CodOpe := strLoginUsuarioLogado;
  Result.DtaAlt := ADtaAlt;
  Result.HraAlt := AHraAlt;
  Result.Tabela := ATabela;
  Result.Incdoc := AqryLog.FieldByName('AUTOINCREM').AsString;
  Result.Tipaju := 'EXC';
  Result.Coluna := AColuna;
  Result.ValAnt := AqryLog.FieldByName(AColuna).AsString;
  Result.ValAtu := '';
  Result.NomFrm := 'fExcluirFechamentos';
  Result.SeqAju := TLogAjcOpContext.SeqAju;
end;

function fExcluirFechamentos(dtaDtaIni, dtaDtaFin: TDate; strCodEmp: string; blnConfirmar: boolean = false; blnAnual: boolean = false; arrFechamento: TDynamicArrayFecCon = nil; strCodEmps: string = ''): boolean;
  var
    qryDados, qryDelete : TFDQuery;
    qryConDetails: TUniquery;
    strMensagem : String;
    blnConfirmou : boolean;
    auxRecCon : TRecFecCon ;
    auxDtIni, auxDtFin: TDate ;
    LdtaIniMensagem, LdtaFimMensagem: TDateTime ;
    LstrMsgErro: String ;
    LGravacaoEmLote: TGravacaoEmLote;
    LdictTabelas: TDictionary<String, TRecCampos>;
    LCampos: TRecCampos;
    LblnLANDET, LblnDPRDET: Boolean;
    LContador: Integer;
begin
  LdictTabelas := nil;
  LGravacaoEmLote := nil;
  qryDados := TFDQuery.Create(nil);
  qryDelete := TFDQuery.Create(nil);
  qryConDetails := fCriaQuery(nil);
  try
    LdictTabelas := fRetornaDictCamposTabelaExclusaoFec();
    LGravacaoEmLote := TGravacaoEmLote.Create(Nil, qryConDetails.Connection.Database,
    qryConDetails.Connection.Username, qryConDetails.Connection.Password,
    IntToStr(qryConDetails.Connection.Port), qryConDetails.Connection.Server);

    qryDados.Connection := LGravacaoEmLote.getDataBase;
    qryDelete.Connection := LGravacaoEmLote.getDataBase;
    Result := True;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT * ');
    qryDados.SQL.Add('   FROM FECCON ');
    qryDados.SQL.Add('  WHERE CON_CODEMP = :CODEMP ');
    qryDados.SQL.Add('    AND ((CON_FECINI BETWEEN :DTAINI AND :DTAFIN) OR ');
    qryDados.SQL.Add('         (CON_FECFIN BETWEEN :DTAINI AND :DTAFIN)) ');
    qryDados.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryDados.ParamByName('DTAFIN').AsDate := dtaDtaFin;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.Open;

    if blnConfirmar then
    begin
      if qryDados.isEmpty then
      begin
        fMensagem('Aviso', 'Nenhum fechamento encontrado no período informado!', ['&OK'], 1) ;
        Result := False ;
        Exit ;
      end ;

      qryDados.First;
      LdtaIniMensagem := qryDados.FieldByName('CON_FECINI').AsDateTime ;
      LdtaFimMensagem := qryDados.FieldByName('CON_FECFIN').AsDateTime ;
      while not qryDados.Eof do
      begin
        LdtaFimMensagem := qryDados.FieldByName('CON_FECFIN').AsDateTime ;
        qryDados.Next ;
      end ;

      strMensagem := 'Confirma exclusão do fechamento no período de ' + FormatDateTime('dd/mm/yyyy', LdtaIniMensagem) +
                                                                    ' a ' + FormatDateTime('dd/mm/yyyy', LdtaFimMensagem) + '?';

      blnConfirmou := fMensagem('Aviso', strMensagem, ['&Sim', '&Não'], 2) = 1 ;
      if not blnConfirmou then
      begin
        Result := False ;
        Exit ;
      end ;

      qryDados.First;
    end ;

    if not qryDados.isEmpty then
    begin
      blnConfirmou := False;

      LblnLANDET := fTabelaExiste('LANDET');
      LblnDPRDET := fTabelaExiste('DPRDET');

      qryDados.First;
      while not qryDados.Eof do
      begin
        if Assigned(arrFechamento) then
        begin
          if fProcuraPeriodoFechamentoPelaData(qryDados.FieldByName('CON_FECINI').AsDateTime, arrFechamento, auxRecCon) then
          begin
            ////verifica se pode excluir, se não pula para o proximo registro
            if not auxRecCon.Selecionado then
            begin
              qryDados.Next;
              Continue ;
            end;
          end;
        end;

        if (blnAnual) then
        begin
          if Assigned(arrFechamento) then
          begin
            ////separa a data inicial e final do periodo customizado selecionado
            pSeparaDatasPeriodoFechamentoSelecionado(auxDtIni, auxDtFin, arrFechamento) ;
            strMensagem := 'Confirma exclusão do fechamento no período de ' + FormatDateTime('dd/mm/yyyy', auxDtIni) +
                                                                      ' a ' + FormatDateTime('dd/mm/yyyy', auxDtFin) + '?';
          end
          else
          begin
            strMensagem := 'Confirma exclusão do fechamento no período de ' + FormatDateTime('dd/mm/yyyy', dtaDtaIni) +
                                                                      ' a ' + FormatDateTime('dd/mm/yyyy', dtaDtaFin) + '?';
          end;
        end
        else
        begin
          strMensagem := 'Existem fechamentos no período de ' + FormatDateTime('dd/mm/yyyy', qryDados.FieldByName('CON_FECINI').AsDateTime) +
                                                        ' a ' + FormatDateTime('dd/mm/yyyy', qryDados.FieldByName('CON_FECFIN').AsDateTime) + ', deseja excluir?';
        end;

        if (blnAnual and blnConfirmou) Or (blnConfirmar or (fMensagem('Aviso', strMensagem, ['&Sim', '&Não'], 1) = 1)) then
        begin
          blnConfirmou := True;

          LGravacaoEmLote.fStartTransaction;
          try

            if LdictTabelas.TryGetValue('LANCON', LCampos)
              and (not fEmptyStr(LCampos.strCampos))
              and (not fEmptyStr(LCampos.strCamposDel)) then
            begin
              try
                qryDelete.SQL.Clear ;
                qryDelete.SQL.Add('INSERT INTO DEL_LANCON (' + LCampos.strCamposDel + ') ');
                qryDelete.SQL.Add('SELECT ' + LCampos.strCampos + ' FROM LANCON WHERE CON_TIPLAN = "FEC" AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
                if fEmptyStr(strCodEmps) then
                begin
                  qryDelete.SQL.Add(' AND CON_EMPLAN = :EMPLAN ');
                  qryDelete.ParamByName('EMPLAN').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
                end
                else
                begin
                  qryDelete.SQL.Add(' AND CON_EMPLAN IN (' + strCodEmps + ') ');
                end;
                qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
                qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
                qryDelete.ExecSQL;
              except
                on E: Exception do
                begin
                  ; // Best-effort: falha na auditoria não bloqueia exclusão (Req. 455744)
                end ;
              end ;
            end ;
            qryDelete.SQL.Clear ;
            qryDelete.SQL.Add('DELETE FROM LANCON WHERE CON_TIPLAN = "FEC" AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
            if fEmptyStr(strCodEmps) then
            begin
              qryDelete.SQL.Add(' AND CON_EMPLAN = :EMPLAN ');
              qryDelete.ParamByName('EMPLAN').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
            end
            else
            begin
              qryDelete.SQL.Add(' AND CON_EMPLAN IN (' + strCodEmps + ') ');
            end;
            qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
            qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
            qryDelete.ExecSQL ;

            if LdictTabelas.TryGetValue('FECCON', LCampos)
              and (not fEmptyStr(LCampos.strCampos))
              and (not fEmptyStr(LCampos.strCamposDel)) then
            begin
              try
                qryDelete.SQL.Clear ;
                qryDelete.SQL.Add('INSERT INTO DEL_FECCON (' + LCampos.strCamposDel + ') ') ;
                qryDelete.SQL.Add('SELECT ' + LCampos.strCampos + ' FROM FECCON WHERE ') ;
                if fEmptyStr(strCodEmps) then
                begin
                  qryDelete.SQL.Add(' AUTOINCREM = :AUTINC ');
                  qryDelete.ParamByName('AUTINC').AsInteger := qryDados.FieldByName('AUTOINCREM').AsInteger;
                end
                else
                begin
                  qryDelete.SQL.Add(' CON_CODEMP IN (' + strCodEmps + ') ');
                  qryDelete.SQL.Add(' AND ((CON_FECINI BETWEEN :DTAINI AND :DTAFIN) OR ');
                  qryDelete.SQL.Add('      (CON_FECFIN BETWEEN :DTAINI AND :DTAFIN)) ');
                  qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
                  qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
                end;
                qryDelete.ExecSQL;
              except
                on E: Exception do
                begin
                  ; // Best-effort: falha na auditoria não bloqueia exclusão (Req. 455744)
                end ;
              end ;
            end ;
            qryDelete.SQL.Text := 'DELETE FROM FECCON WHERE ';
            if fEmptyStr(strCodEmps) then
            begin
              qryDelete.SQL.Add(' AUTOINCREM = :AUTINC ');
              qryDelete.ParamByName('AUTINC').AsInteger := qryDados.FieldByName('AUTOINCREM').AsInteger;
            end
            else
            begin
              qryDelete.SQL.Add(' CON_CODEMP IN (' + strCodEmps + ') ');
              qryDelete.SQL.Add(' AND ((CON_FECINI BETWEEN :DTAINI AND :DTAFIN) OR ');
              qryDelete.SQL.Add('      (CON_FECFIN BETWEEN :DTAINI AND :DTAFIN)) ');
              qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
              qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
            end;
            qryDelete.ExecSQL;

            if LdictTabelas.TryGetValue('FECMES', LCampos)
              and (not fEmptyStr(LCampos.strCampos))
              and (not fEmptyStr(LCampos.strCamposDel)) then
            begin
              try
                qryDelete.SQL.Clear ;
                qryDelete.SQL.Add('INSERT INTO DEL_FECMES (' + LCampos.strCamposDel + ') ') ;
                qryDelete.SQL.Add('SELECT ' + LCampos.strCampos + ' FROM FECMES WHERE MES_EMPGRV = :EMPGRV AND MES_MESDTA BETWEEN :DTAINI AND :DTAFIN') ;
                qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
                qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
                qryDelete.ParamByName('EMPGRV').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
                qryDelete.ExecSQL;
              except
                on E: Exception do
                begin
                  ; // Best-effort: falha na auditoria não bloqueia exclusão (Req. 455744)
                end ;
              end ;
            end ;
            qryDelete.Close;
            qryDelete.SQL.Text := 'SELECT MES_CODEMP, MES_MESDTA FROM FECMES WHERE MES_EMPGRV = :EMPGRV AND MES_MESDTA BETWEEN :DTAINI AND :DTAFIN';
            qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
            qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
            qryDelete.ParamByName('EMPGRV').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
            qryDelete.Open;
            try
              while not qryDelete.Eof do
              begin
                if not fVerificaDeletaFechamento(qryDelete.FieldByName('MES_CODEMP').AsString,
                                                 qryDelete.FieldByName('MES_MESDTA').AsDateTime,
                                                 LstrMsgErro) then
                  raise Exception.Create('Problemas ao estornar ' + LstrMsgErro);
                qryDelete.Next;
              end;
            finally
              qryDelete.Close;
            end;

            qryDelete.SQL.Text := 'DELETE FROM FECMES WHERE MES_EMPGRV = :EMPGRV AND MES_MESDTA BETWEEN :DTAINI AND :DTAFIN';
            qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
            qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
            qryDelete.ParamByName('EMPGRV').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
            qryDelete.ExecSQL;

            if LdictTabelas.TryGetValue('LANMES', LCampos)
              and (not fEmptyStr(LCampos.strCampos))
              and (not fEmptyStr(LCampos.strCamposDel)) then
            begin
              try
                qryDelete.SQL.Clear ;
                qryDelete.SQL.Add('INSERT INTO DEL_LANMES (' + LCampos.strCamposDel + ') ') ;
                qryDelete.SQL.Add('SELECT ' + LCampos.strCampos + ' FROM LANMES WHERE CON_EMPLAN = :EMPLAN AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN') ;
                qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
                qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
                qryDelete.ParamByName('EMPLAN').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
                qryDelete.ExecSQL;
              except
                on E: Exception do
                begin
                  ; // Best-effort: falha na auditoria não bloqueia exclusão (Req. 455744)
                end ;
              end ;
            end ;
            qryDelete.SQL.Text := 'DELETE FROM LANMES WHERE CON_EMPLAN = :EMPLAN AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN';
            qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
            qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
            qryDelete.ParamByName('EMPLAN').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
            qryDelete.ExecSQL;

            if LdictTabelas.TryGetValue('PLAMES', LCampos)
              and (not fEmptyStr(LCampos.strCampos))
              and (not fEmptyStr(LCampos.strCamposDel)) then
            begin
              try
                qryDelete.SQL.Clear ;
                qryDelete.SQL.Add('INSERT INTO DEL_PLAMES (' + LCampos.strCamposDel + ') ') ;
                qryDelete.SQL.Add('SELECT ' + LCampos.strCampos + ' FROM PLAMES WHERE MES_CODEMP = :CODEMP AND MES_DTASAL BETWEEN :DTAINI AND :DTAFIN');
                qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
                qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
                qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
                qryDelete.ExecSQL;
              except
                on E: Exception do
                begin
                  ; // Best-effort: falha na auditoria não bloqueia exclusão (Req. 455744)
                end ;
              end ;
            end ;

            qryDelete.SQL.Text := 'DELETE FROM PLAMES WHERE MES_CODEMP = :CODEMP AND MES_DTASAL BETWEEN :DTAINI AND :DTAFIN';
            qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
            qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
            qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
            qryDelete.ExecSQL;

            if LdictTabelas.TryGetValue('LANBAL', LCampos)
              and (not fEmptyStr(LCampos.strCampos))
              and (not fEmptyStr(LCampos.strCamposDel)) then
            begin
              try
                qryDelete.SQL.Clear ;
                qryDelete.SQL.Add('INSERT INTO DEL_LANBAL (' + LCampos.strCamposDel + ') ') ;
                qryDelete.SQL.Add('SELECT ' + LCampos.strCampos + ' FROM LANBAL WHERE BAL_CODEMP = :CODEMP AND BAL_DTAMOV BETWEEN :DTAINI AND :DTAFIN') ;
                qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
                qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
                qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
                qryDelete.ExecSQL;
              except
                on E: Exception do
                begin
                  ; // Best-effort: falha na auditoria não bloqueia exclusão (Req. 455744)
                end ;
              end ;
            end ;

            if LblnLANDET then
            begin
              qryDelete.SQL.Text := 'DELETE FROM LANDET WHERE DET_CODEMP = :CODEMP AND DET_DTAMOV BETWEEN :DTAINI AND :DTAFIN';
              qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
              qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
              qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
              qryDelete.ExecSQL;
            end;

            qryDelete.SQL.Text := 'DELETE FROM LANBAL WHERE BAL_CODEMP = :CODEMP AND BAL_DTAMOV BETWEEN :DTAINI AND :DTAFIN';
            qryDelete.ParamByName('DTAINI').AsDate := qryDados.FieldByName('CON_FECINI').AsDateTime;
            qryDelete.ParamByName('DTAFIN').AsDate := qryDados.FieldByName('CON_FECFIN').AsDateTime;
            qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
            qryDelete.ExecSQL;

            if MonthOf(qryDados.FieldByName('CON_FECFIN').AsDateTime) = MonthsPerYear then
            begin
              if LdictTabelas.TryGetValue('PLAINI', LCampos)
                and (not fEmptyStr(LCampos.strCampos))
                and (not fEmptyStr(LCampos.strCamposDel)) then
              begin
                try
                  qryDelete.SQL.Clear ;
                  qryDelete.SQL.Add('INSERT INTO DEL_PLAINI (' + LCampos.strCamposDel + ') ') ;
                  qryDelete.SQL.Add('SELECT ' + LCampos.strCampos + ' FROM PLAINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP = :CODEMP ') ;
                  qryDelete.ParamByName('EXERCI').AsInteger := YearOf(qryDados.FieldByName('CON_FECFIN').AsDateTime)+1 ;
                  qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
                  qryDelete.ExecSQL;
                except
                  on E: Exception do
                  begin
                    ; // Best-effort: falha na auditoria não bloqueia exclusão (Req. 455744)
                  end ;
                end ;
              end ;

              qryDelete.SQL.Text := 'DELETE FROM PLAINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP = :CODEMP ';
              qryDelete.ParamByName('EXERCI').AsInteger := YearOf(qryDados.FieldByName('CON_FECFIN').AsDateTime)+1 ;
              qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
              qryDelete.ExecSQL;

              if LdictTabelas.TryGetValue('DPRINI', LCampos)
                and (not fEmptyStr(LCampos.strCampos))
                and (not fEmptyStr(LCampos.strCamposDel)) then
              begin
                try
                  qryDelete.SQL.Clear ;
                  qryDelete.SQL.Add('INSERT INTO DEL_DPRINI (' + LCampos.strCamposDel + ') ') ;
                  qryDelete.SQL.Add('SELECT ' + LCampos.strCampos + ' FROM DPRINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP = :CODEMP ') ;
                  qryDelete.ParamByName('EXERCI').AsInteger := YearOf(qryDados.FieldByName('CON_FECFIN').AsDateTime)+1 ;
                  qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
                  qryDelete.ExecSQL;
                except
                  on E: Exception do
                  begin
                    ; // Best-effort: falha na auditoria não bloqueia exclusão (Req. 455744)
                  end ;
                end ;
              end ;

              qryDelete.SQL.Text := 'DELETE FROM DPRINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP = :CODEMP ';
              qryDelete.ParamByName('EXERCI').AsInteger := YearOf(qryDados.FieldByName('CON_FECFIN').AsDateTime)+1 ;
              qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
              qryDelete.ExecSQL;

              if LblnDPRDET then
              begin
                qryDelete.SQL.Text := 'DELETE FROM DPRDET WHERE DET_EXERCI = :EXERCI AND DET_CODEMP = :CODEMP ';
                qryDelete.ParamByName('EXERCI').AsInteger := YearOf(qryDados.FieldByName('CON_FECFIN').AsDateTime)+1 ;
                qryDelete.ParamByName('CODEMP').AsString := qryDados.FieldByName('CON_CODEMP').AsString;
                qryDelete.ExecSQL;
              end;

            end ;

            LGravacaoEmLote.fCommit;
          except
            On E: Exception do
            begin
              Result := False;
              LGravacaoEmLote.fRollBack;
              raise;
            end;
          end;
        end
        else
        begin
          Result := False;
          Break;
        end;

        qryDados.Next;
      end;
    end;

    if Result then
    begin
      LGravacaoEmLote.fStartTransaction;
      try
        if Assigned(arrFechamento) then
        begin
          for LContador := low(arrFechamento) to high(arrFechamento) do
          begin
            if arrFechamento[LContador].Selecionado then
            begin
              if not fVerificaDeletaFechamentoFecFisFecFinCadFec(arrFechamento[LContador].FecIni, arrFechamento[LContador].FecFin, strCodEmp, strCodEmps, LstrMsgErro ) then
                raise Exception.Create('Problemas ao estornar ' + LstrMsgErro);
            end;
          end;
        end
        else
        begin
          if not fVerificaDeletaFechamentoFecFisFecFinCadFec(dtaDtaIni, dtaDtaFin, strCodEmp, strCodEmps, LstrMsgErro ) then
            raise Exception.Create('Problemas ao estornar ' + LstrMsgErro);
        end;

        LGravacaoEmLote.fCommit;
      except
        On E: Exception do
        begin
          Result := False;
          LGravacaoEmLote.fRollBack;
          raise;
        end;
      end;

    end;

  finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDelete);
    FreeAndNil(qryConDetails);
    if Assigned(LGravacaoEmLote) then
      FreeAndNil(LGravacaoEmLote);
    if Assigned(LdictTabelas) then
      FreeAndNil(LdictTabelas);
  end;
end;

function fConfiguracaoExiste(strCodCfg: string; strCodEmp: string = ''): boolean;
begin
  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  Result := (fCampoTabela('COUNT(*)', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_' + strCodCfg, strCodEmp], False) > 0);
end;

function fProximaContaContabil(strCodEmp: string; blnFornecedor: boolean): string;
  var
    intProxCod : Integer;
    strMascara : String;
    strCodCon : String;
begin
  strCodCon := fCfgSis(fConfiguracaoGrupoPlanoContas(blnFornecedor), varString, strCodEmp);

  if fEmptyStr(strCodCon) then
    exit;

  strMascara := fCfgSis('MSKCON', varString, strCodEmp);
  strMascara := Trim(AnsiReplaceStr(AnsiReplaceStr(strMascara, '.', ''), '-', ''));

  Result := fGetProximoCodigoEmTransacao('PLANCO', 'NCO_CODCON', '',
    function (const AValue : String) : String
    begin
      intProxCod := StrToInt(AValue);
      strCodCon := Trim(AnsiReplaceStr(AnsiReplaceStr(strCodCon, '.', ''), '-', ''));
      strCodCon := strCodCon + fStrZero(intProxCod, (Length(strMascara) - Length(strCodCon)));
      Result := strCodCon;
    end
  );
end;

function fJaExisteContaNaEmpresa(strCodigoConta, strCodEmp, strTipoCampo: string): boolean;
begin
  Result := False;
  if (strTipoCampo = 'FOR_CODFOR') then
    Result := (fCampoTabela('COUNT(*)', 'FORNCO', ['NCO_CODFOR', 'NCO_CODEMP'], [strCodigoConta, strCodEmp], False) > 0)
  else if (strTipoCampo = 'CLI_CODCLI') then
    Result := (fCampoTabela('COUNT(*)', 'CLINCO', ['NCO_CODCLI', 'NCO_CODEMP'], [strCodigoConta, strCodEmp], False) > 0);
end;

procedure pGravarContaContabil(strNomeConta: string; strCodEmp: string; out strCodCon: string; blnFornecedor: boolean);
  var
    qryPlaNco : TUniQuery;
    strTplaco : string ;
begin
  strCodCon := fProximaContaContabil(strCodEmp, blnFornecedor);

  if fEmptyStr(strCodCon) then
    exit;

  qryPlaNco := fCriaQuery(nil);
  try
    qryPlaNco.SQL.Text := 'SELECT * FROM PLANCO WHERE NCO_CODCON = ' + QuotedStr(strCodCon);
    qryPlaNco.Open;

    strTplaco := fRetTplacoEmpresaLogada ;

    If (qryPlaNco.IsEmpty) Then
    Begin
      qryPlaNco.Insert;
      qryPlaNco.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PLANCO', VS_strCodEmp);
      qryPlaNco.FieldByName('NCO_CODCON').AsString := strCodCon;
      qryPlaNco.FieldByName('NCO_TPLACO').AsString := strTplaco;
      qryPlaNco.FieldByName('NCO_DESCRI').AsString := strNomeConta;
      qryPlaNco.FieldByName('NCO_CONRED').AsString := '';
      qryPlaNco.Post;
    End
    Else
      strCodCon := ''; //caso a conta já exista, não faz vínculo nenhum
  finally
    FreeAndNil(qryPlaNco);
  end;
end;

procedure pGravaContaContabilDeCadaEmpresa(strFieldConta, strCodCon, strCodigoPessoa, strCodEmp: string);
begin
  if fEmptyStr(strCodigoPessoa) then
    exit;

  if strFieldConta = 'CLI_PLANCO' then
    pGravaCliNco(strCodigoPessoa, strCodEmp, strCodCon)
  else if strFieldConta = 'FOR_PLANCO' then
    pGravaForNco(strCodigoPessoa, strCodEmp, strCodCon);
end;

procedure pGravaCliNco(strCodCli, strCodEmp, strCodCon: string);
  var
    qryCliNco : TUniQuery;
begin
  qryCliNco := fCriaQuery;
  try
    qryCliNco.SQL.Text := 'SELECT * FROM CLINCO WHERE FALSE';
    qryCliNco.Open;
    qryCliNco.Insert;
    qryCliNco.FieldByName('NCO_CODCLI').AsString := strCodCli;
    qryCliNco.FieldByName('NCO_CODEMP').AsString := strCodEmp;
    qryCliNco.FieldByName('NCO_CODCON').AsString := strCodCon;
    qryCliNco.Post;
  finally
    FreeAndNil(qryCliNco);
  end;
end;

procedure pGravaForNco(strCodFor, strCodEmp, strCodCon: string);
  var
    qryForNco : TUniQuery;
begin
  qryForNco := fCriaQuery;
  try
    qryForNco.SQL.Text := 'SELECT * FROM FORNCO WHERE FALSE';
    qryForNco.Open;
    qryForNco.Insert;
    qryForNco.FieldByName('NCO_CODFOR').AsString := strCodFor;
    qryForNco.FieldByName('NCO_CODEMP').AsString := strCodEmp;
    qryForNco.FieldByName('NCO_CODCON').AsString := strCodCon;
    qryForNco.Post;
  finally
    FreeAndNil(qryForNco);
  end;
end;

function fValidaNumeroCertidaoContador(strCertidao: string): Boolean;
begin
  Result := False;
  if fValidaEstado(Copy(strCertidao,1,2)) then
  begin
    if fValidaAno(Copy(strCertidao,4,4)) then
    begin
      if fValidaNumero(Copy(strCertidao,9, Length(strCertidao))) then
      begin
        if (Copy(strCertidao,3,1) = '/') and (Copy(strCertidao,8,1) = '/') then
        begin
          Result := True;
        end;
      end;
    end;
  end;
end;

function fValidaAno(strAno: string): Boolean;
var
  dtaData: TDate;
begin
  Result := True;
  try
    dtaData := StrToDate('01/01/' + strAno);
    strAno := RightStr(DateToStr(dtaData),4);
  except
    Result := False;
  end;
end;

function fValidaNumero(strNumero: string): Boolean;
var
  intNumero: integer;
begin
  Result := True;
  try
    intNumero := StrToInt(strNumero);
    strNumero := IntToStr(intNumero);
  except
    Result := False;
  end;
end;

procedure pSetaItensEntradaSaida(cmbItens: TComboBoxFocus; blnAddClafisServico: boolean; strTipLan: string; blnEhCFOPX933: boolean = false);
begin
  cmbItens.Items.Add('Vr.Contábil');
  cmbItens.Items.Add('Vr.ICMS');
  cmbItens.Items.Add('Vr.IPI');
  cmbItens.Items.Add('Vr.Frete');
  cmbItens.Items.Add('Vr.Desp.Acessórias');
  cmbItens.Items.Add('Vr.Sub.Tributária');
  cmbItens.Items.Add('Vr.PIS');
  cmbItens.Items.Add('Vr.COFINS');
  If (blnAddClafisServico) Then
  Begin
    cmbItens.Items.Add('Vr.ISS');
    cmbItens.Items.Add('Vr.CSLL');
    cmbItens.Items.Add('Vr.IRPJ');
    cmbItens.Items.Add('Vr.INSS');
    cmbItens.Items.Add(DES_VALOR_RETENCAO_PIS);
    cmbItens.Items.Add(DES_VALOR_RETENCAO_COFINS);
    if strTipLan = 'SAI' then
      cmbItens.Items.Add(DES_VALOR_RETENCAO_ISS);
    cmbItens.Items.Add(DES_VALOR_LIQUIDO_CONTABIL);
  End;
  cmbItens.Items.Add(DES_VALOR_CMV);
  if (strTipLan = 'ENT') then
  begin
    cmbItens.Items.Add(DES_VALOR_LIQUIDO_ENTRADA);
    cmbItens.Items.Add(DES_VALOR_GNRE);
    cmbItens.Items.Add('Vl.Adiantamento');
    cmbItens.Items.Add(DES_VALOR_ICMS_ST);
    if fCampoInssPatronalCadfisExiste then
      cmbItens.Items.Add(DES_VALOR_INSS_PATRONAL);
  end;
  cmbItens.Items.Add(DES_VALOR_FCP);
  cmbItens.Items.Add(DES_VALOR_FCP_ST);
  cmbItens.Items.Add(DES_VALOR_DIFAL);
  if not((strTipLan = 'ENT') and blnEhCFOPX933)  then
    cmbItens.Items.Add(DES_VALOR_RET_IRRF);
  if strTipLan = 'SAI' then
    cmbItens.Items.Add(DES_VALOR_LIQUIDO_SAIDA);
end;

function fgetSQLConhecimentoFrete(strVenCom: string; recParCon: TParametrosConsulta; recValCam: TValidacoesDeBanco): string;
  var
    blnExisteTabelaComplementoCTE : boolean;

  function fgetSQLConhecimentoFreteInterna(strTabelaConhecimento: string; blnComplemento: boolean = false): string;
    var
      strAliasCadFis : string;
      AblnUsaAbrevProd : Boolean ;
      AblnTemRecNotSeq : Boolean ;
  begin
    if blnComplemento then
      strAliasCadFis := 'FISCOM.'
    else
      strAliasCadFis := 'FISORI.';

    AblnUsaAbrevProd := fUsarAbrevProdNoCoeCos ;
    AblnTemRecNotSeq := fCampoExiste('RECTNF', 'REC_NOTSEQ') ;

    Result := '';
    Result := Result + ' SELECT ' + strAliasCadFis + 'FIS_SERIE_ AS SERIE_, ' + strAliasCadFis + 'FIS_CLFSC1 AS CLAFIS, ' + strAliasCadFis + 'FIS_DTAENT AS DTAENT, ' + strAliasCadFis + 'FIS_NUMDOC AS NUMDOC, ';
    Result := Result + '        ' + strAliasCadFis + 'FIS_ESPDOC AS ESPDOC, ' + strAliasCadFis + 'FIS_CODEMP AS CODEMP, ';
    Result := Result + '        IFNULL(' + strAliasCadFis + 'FIS_VLCON1, 0) + IFNULL(' + strAliasCadFis + 'FIS_VLCON2, 0) + IFNULL(' + strAliasCadFis + 'FIS_VLCON3, 0) + IFNULL(' + strAliasCadFis + 'FIS_VLCON4, 0) + IFNULL(' + strAliasCadFis + 'FIS_VLCON5, 0) AS VLRCON, ';
    Result := Result + '        IFNULL(' + strAliasCadFis + 'FIS_VLRIC1, 0) + IFNULL(' + strAliasCadFis + 'FIS_VLRIC2, 0) + IFNULL(' + strAliasCadFis + 'FIS_VLRIC3, 0) + IFNULL(' + strAliasCadFis + 'FIS_VLRIC4, 0) + IFNULL(' + strAliasCadFis + 'FIS_VLRIC5, 0) AS VALICM, ';
    Result := Result + '        ' + strAliasCadFis + 'FIS_TOTPIS AS VALPIS, ';
    Result := Result + '        ' + strAliasCadFis + 'FIS_TOTCOF AS VALCOF, ';
    Result := Result + '        IF(' + strAliasCadFis + 'FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
    Result := Result + '        IF(' + strAliasCadFis + 'FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';

    Result := Result + '        TRIM(' + strAliasCadFis + 'FIS_NATOPE) AS NATCFO, ';

    Result := Result + '        ' + strAliasCadFis + 'FIS_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
    Result := Result + '        IF(' + strAliasCadFis + 'FIS_TIP_FC = "C", IFNULL(NCO_CODCLI, CLI_CODCLI), IFNULL(NCO_CODFOR, FOR_CODFOR)) AS CODIGO_CLIENTE_FORNECEDOR, ';
    Result := Result + '        IF(' + strAliasCadFis + 'FIS_TIP_FC = "C", IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO), IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO)) AS PLANCO, ';

    Result := Result + '        ' + fValorLiquidoEntradaLivro(1, False, False, True,  strAliasCadFis) + ' + '
                                  + fValorLiquidoEntradaLivro(2, False, False, False, strAliasCadFis) + ' + '
                                  + fValorLiquidoEntradaLivro(3, False, False, False, strAliasCadFis) + ' + '
                                  + fValorLiquidoEntradaLivro(4, False, False, False, strAliasCadFis) + ' + '
                                  + fValorLiquidoEntradaLivro(5, False, False, False, strAliasCadFis) + ' AS LIQENT, ';

    Result := Result + '        ' + strAliasCadFis + 'AUTOINCREM AS FISINC ';

    if (recValCam.FUsaCampoAbfCon) and (not fEmptyStr(strTabelaConhecimento)) then
      Result := Result + '  ,GROUP_CONCAT(DISTINCT ITE_ABFCON) AS ITE_ABFCON '
    else
      Result := Result + '  ,CAST(NULL AS CHAR(1)) AS ITE_ABFCON ' ;

    Result := Result + '   FROM CADFIS AS FISORI ';

    if (strTabelaConhecimento = 'CONFRE') then
    begin
      Result := Result + '   JOIN CONFRE ON FISORI.AUTOINCREM = CONFRE.CON_SEQFIS ';
      Result := Result + '   JOIN MOVDET ON MOVDET.DET_SEQGER = CONFRE.CON_SEQGER ';
      Result := Result + '   JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
      if (recValCam.FUsaCampoAbfCon) then
        Result := Result + ' JOIN CADITE ON CADITE.ITE_CODITE = MOVDET.DET_CODITE ';
      if (recValCam.FUsaCampoNatCfo) then
        Result := Result + ' LEFT JOIN AUXMOV A2 ON A2.AUX_SEQGER = MOVDET.DET_SEQGER ';
    end
    else if (strTabelaConhecimento = 'RECTNF') then
    begin
      Result := Result + '   JOIN RECTNF ON FISORI.AUTOINCREM = RECTNF.REC_CTESEQ ';
      Result := Result + '   JOIN MOVDET ON MOVDET.DET_SEQGER = RECTNF.REC_MOVSEQ ';
      Result := Result + '   JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
      if (recValCam.FUsaCampoAbfCon) then
        Result := Result + ' JOIN CADITE ON CADITE.ITE_CODITE = MOVDET.DET_CODITE ';
      if (recValCam.FUsaCampoNatCfo) then
        Result := Result + ' LEFT JOIN AUXMOV A2 ON A2.AUX_SEQGER = MOVDET.DET_SEQGER ';
    end;

    if (blnExisteTabelaComplementoCTE) then
    begin
      if (blnComplemento) then
      begin
        Result := Result + ' JOIN CTECOM ON FISORI.AUTOINCREM = CTECOM.COM_CTEORI ';
        Result := Result + ' JOIN CADFIS FISCOM ON FISCOM.AUTOINCREM = CTECOM.COM_CTECOM ';
      end
      else
        Result := Result + ' LEFT JOIN CTECOM ON FISORI.AUTOINCREM = CTECOM.COM_CTEORI ';
    end;

    Result := Result + '   LEFT JOIN CADCLI ON CLI_CODCLI = ' + strAliasCadFis + 'FIS_FORCLI ';
    Result := Result + '   LEFT JOIN CADFOR ON FOR_CODFOR = ' + strAliasCadFis + 'FIS_FORCLI ';

    Result := Result + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
    Result := Result + '                   AND CLINCO.NCO_CODEMP = ' + strAliasCadFis + 'FIS_CODEMP ';
    Result := Result + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
    Result := Result + '                   AND FORNCO.NCO_CODEMP = ' + strAliasCadFis + 'FIS_CODEMP ';

    Result := Result + '  WHERE FISORI.FIS_ESPDOC = ' + QuotedStr('CT');

    if (strVenCom = CONHECIMENTO_TIPO_COMPRA) then
    begin
      Result := Result + '   AND ' + fCoalesceVenComCosCoe('FISORI.FIS_VENCOM', AblnUsaAbrevProd) + ' = ' + QuotedStr(strVenCom);

      if (recValCam.FUsaCampoCalMed) then
        Result := Result + ' AND IFNULL(FISORI.FIS_CALMED,"N") = "S" ';
    end
    else if (strVenCom = CONHECIMENTO_TIPO_VENDA) then
    begin
      if (recValCam.FUsaCampoCalMed) then
        Result := Result + ' AND ((' + fCoalesceVenComCosCoe('FISORI.FIS_VENCOM', AblnUsaAbrevProd) + ' = ' + QuotedStr(CONHECIMENTO_TIPO_VENDA) + ') OR (' + fCoalesceVenComCosCoe('FISORI.FIS_VENCOM', AblnUsaAbrevProd) + ' = ' + QuotedStr(CONHECIMENTO_TIPO_COMPRA) + ' AND IFNULL(FISORI.FIS_CALMED,"N") = "N"))'
      else
        Result := Result + ' AND ' + fCoalesceVenComCosCoe('FISORI.FIS_VENCOM', AblnUsaAbrevProd) + ' = ' + QuotedStr(strVenCom);
    end
    else
      raise Exception.Create('Tipo de conhecimento "' + strVenCom + '" desconhecido.');

    If Not fEmptyStr(recParCon.strCodEmp) Then
      Result := Result + '  AND ' + strAliasCadFis + 'FIS_CODEMP = :CODEMP ';

    if (recParCon.dtaDtaIni > 0) then
      Result := Result + '    AND ' + strAliasCadFis + 'FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    Result := Result + TTrataIncDocContabil
                         .New
                         .fColunaIncDoc(strAliasCadFis + 'AUTOINCREM')
                         .fIncDoc(recParCon.strIncDoc)
                         .fArrIncDoc(recParCon.arrIncDoc)
                         .fQuerySql(Nil)
                         .fExecute ;

    Result := Result + '  GROUP BY ' + strAliasCadFis + 'AUTOINCREM ';

    if AblnTemRecNotSeq then
      Result := Result + ' UNION ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Result, 'REC_MOVSEQ', 'REC_NOTSEQ'), 'AUXMOV', 'AUXNOT'), 'MOVTRI', 'NOTTRI'), 'MOVDET', 'NOTDET' ) ;
  end;

begin
  blnExisteTabelaComplementoCTE := fTabelaExiste('CTECOM');

  Result := '';
  if fUsarAbrevProdNoCoeCos then
  begin
    Result := Result + fgetSQLConhecimentoFreteInterna('CONFRE');
    Result := Result + ' UNION ';
    Result := Result + fgetSQLConhecimentoFreteInterna('RECTNF');

    if (blnExisteTabelaComplementoCTE) then
    begin
      Result := Result + ' UNION ';
      Result := Result + fgetSQLConhecimentoFreteInterna('CONFRE', True);
      Result := Result + ' UNION ';
      Result := Result + fgetSQLConhecimentoFreteInterna('RECTNF', True);
    end;
  end
  else
  begin
    Result := Result + fgetSQLConhecimentoFreteInterna('');
    if (blnExisteTabelaComplementoCTE) then
    begin
      Result := Result + ' UNION ';
      Result := Result + fgetSQLConhecimentoFreteInterna('', True);
    end ;
  end ;
  result := fPreparaSqlCoeCosPlanoContas(result, recValCam) ;

end;

function fValorLiquidoEntradaLivro(const AintColuna: integer = 1; const AblnUsarIpi: Boolean = False; const AblnUsarRet: Boolean = False; const AblnUsarTotPisCof: Boolean = True; const AstrAliasTabela: String = ''): string;
var
  LstrAuxIpi: String ;
  LstrAuxRet: String ;
  LstrAuxTotPisCofins: String ;
begin
  LstrAuxIpi := '0.00' ;
  if AblnUsarIpi then
    LstrAuxIpi := fVlrIpiLivro(AintColuna, AstrAliasTabela) ;

  LstrAuxRet := '0.00' ;
  if AblnUsarRet then
    LstrAuxRet := fVlrRetLivro(AintColuna, AstrAliasTabela) ;

  LstrAuxTotPisCofins := '0.00' ;
  if AblnUsarTotPisCof then
    LstrAuxTotPisCofins := 'IFNULL(' + AstrAliasTabela + 'FIS_TOTPIS, 0) - IFNULL(' + AstrAliasTabela + 'FIS_TOTCOF, 0)' ;

  Result := ' (' + fVlrContabilLivro(AintColuna, AstrAliasTabela) + ' - ' +  fVlrIcmsLivro(AintColuna, AstrAliasTabela) + ' - ' + LstrAuxIpi + ' - ' + LstrAuxRet + ' - ' + LstrAuxTotPisCofins + ') ';
end;

function fValorLiquidoContabilLivro(const AColunasValorContabil: TSetColunasValorLiquidoContabil; const AintColuna: integer = 1): string;
begin
  Result := ' (' + fVlrContabilLivro(AintColuna) + ' - (' + fRetornaColunasADescontarValorContabil(AColunasValorContabil) + ')) ';
end ;

function fVlrContabilLivro(const AintColuna: integer = 1; const AstrAliasTabela: String = ''): string;
begin
  Result := ' (IFNULL(' + AstrAliasTabela + 'FIS_VLCON' + inttostr(AintColuna) + ',0)) ';
end;

function fVlrIcmsLivro(const AintColuna: integer = 1; const AstrAliasTabela: String = ''): string;
begin
  Result := ' (IFNULL(' + AstrAliasTabela + 'FIS_VLRIC' + intTostr(AintColuna) + ',0)) ';
end;

function fVlrIpiLivro(const AintColuna: integer = 1; const AstrAliasTabela: String = ''): string;
begin
  Result := ' (IFNULL(' + AstrAliasTabela + 'FIS_VLRIP' + intTostr(AintColuna) + ',0)) ';
end ;

function fVlrRetLivro(const AintColuna: integer = 1; const AstrAliasTabela: String = ''): string;
begin
  Result := ' (IFNULL(' + AstrAliasTabela + 'FIS_RETID' + intTostr(AintColuna) + ',0)) ';
end;

function fLancamentoUtilizaCentroDeCusto(strTipLan: string): boolean;
begin
  Result := MatchStr(strTipLan, ['ENT', 'BAN', 'CRC', 'CTR', 'OUE', 'SAI', 'CTP']);
end;

function fValidouCentroDeCusto(const AtpcTipo: TTipoPlanoContas; const AstrContaContabil, AstrCentroDeCusto: string; var AstrMotivo: string; const AcdsPlanco: TUniClientDataSet; const AstrCodEmp: string; const AblnTemCentroCusto: Boolean): boolean;
var
  LstrTipo: String ;
begin
  Result := True;
  AstrMotivo := '';

  if not AblnTemCentroCusto then
    Exit ;

  if fPrecisaLimparCentroCusto(AcdsPlanco, AstrContaContabil, AstrCodEmp) then
    exit ;

  LstrTipo := '' ;
  if AtpcTipo = tpcCredito then
    LstrTipo := 'Crédito'
  else if AtpcTipo = tpcDebito then
    LstrTipo := 'Débito' ;

  if (fEmptyStr(AstrCentroDeCusto)) then
  begin
    if (not fEmptyStr(AstrContaContabil)) then
    begin
      if (not fEmptyStr(fCfgDigrec)) and (copy(fSemMascaraPlaNco(AstrContaContabil),1,fLenDig(fCfgDigrec)) = fCfgDigrec) then
      begin
        AstrMotivo := 'Conta ' + LstrTipo + ' (Receita) sem centro de custo preenchido';
        Result := False;
      end;

      if (not fEmptyStr(fCfgDigdes)) and (copy(fSemMascaraPlaNco(AstrContaContabil),1,fLenDig(fCfgDigdes)) = fCfgDigdes) then
      begin
        AstrMotivo := 'Conta ' + LstrTipo + ' (Despesa) sem centro de custo preenchido';
        Result := False;
      end;

      if (not fEmptyStr(fCfgDigcus)) and (copy(fSemMascaraPlaNco(AstrContaContabil),1,fLenDig(fCfgDigcus)) = fCfgDigcus) then
      begin
        AstrMotivo := 'Conta ' + LstrTipo + ' (Custo) sem centro de custo preenchido';
        Result := False;
      end;
    end;
  end
  else if (not fEmptyStr(AstrCentroDeCusto)) and (fConfiguracaoExiste('EVEPRI')) then
  begin
    if (not fEmptyStr(fCfgSis('EVEPRI'))) then
    begin
      if (AstrCentroDeCusto = fCfgSis('EVEPRI')) then
      begin
        AstrMotivo := 'Centro de custo informado igual ao principal "CFG_EVEPRI", não permitido';
        Result := False;
      end;
    end;
  end;
end;

function fGetNovoLoteContabil: Int64;
  var
    qryDados : TUniQuery;
    objCriarConexao: TCriarConexao;
begin
  objCriarConexao := TCriarConexao.Create;
  try
    qryDados := fCriaQuery(Nil, objCriarConexao.objConexao);
    try
      objCriarConexao.objConexao.Options.LocalFailover := False;
      objCriarConexao.objConexao.StartTransaction;
      qryDados.SQL.Text := 'SELECT * FROM SQLCON FOR UPDATE';
      qryDados.Open;
      if qryDados.IsEmpty then
      begin
        qryDados.Insert;
        qryDados.FieldByName('CON_SEQUEN').AsInteger := 0;
      end
      else
        qryDados.Edit;
      qryDados.FieldByName('CON_SEQUEN').AsInteger := qryDados.FieldByName('CON_SEQUEN').AsInteger + 1;
      qryDados.Post;
      Result := qryDados.FieldByName('CON_SEQUEN').AsInteger;
      objCriarConexao.objConexao.Commit;
    finally
      FreeAndNil(qryDados);
    end;
  finally
    objCriarConexao.objConexao.Options.LocalFailover := True;
    FreeAndNil(objCriarConexao);
  end;
end;

function fFormatoLoteContabil(strCompet: string; intSequen: integer): string;
begin
  Result := strCompet + fStrZero(intSequen, 14);
end;

function fGetSqlInsertLotInc: string;
begin
  Result := 'INSERT INTO LOTINC (INC_INCDOC, INC_TIPLAN, INC_COMPET, INC_EMPLAN, INC_DTALAN, INC_AUTOMA, INC_SEQUEN) VALUES (:INCDOC, :TIPLAN, :COMPET, :EMPLAN, :DTALAN, :AUTOMA, :SEQUEN)';
end;

function fGetSqlInsertPlaMes: string;
var
  LblnMES_CREDEB : Boolean ;
  LstrCampos: String ;
  LstrParametros: String ;
begin
  LblnMES_CREDEB := fCampoExiste('PLAMES', 'MES_CREDEB');

  LstrCampos := 'MES_CODCON, MES_SALINI, MES_CODEMP, MES_DTASAL, MES_CCUSTO' ;
  LstrParametros := ':CODCON, :SALINI, :CODEMP, :DTASAL, :CCUSTO' ;
  if LblnMES_CREDEB then
  begin
    LstrCampos := LstrCampos + ', MES_CREDEB' ;
    LstrParametros := LstrParametros + ', :CREDEB' ;
  end ;

  Result := 'INSERT INTO PLAMES (' + LstrCampos + ') VALUES (' + LstrParametros + ');' ;

end ;

function fGetSqlInsertLanBal: string;
var
  LblnBAL_CRDEAN: boolean ;
  LblnBAL_CRDEFI: boolean ;
  LstrCampos: String ;
  LstrParametros: String ;
begin
  LblnBAL_CRDEAN := fCampoExiste('LANBAL', 'BAL_CRDEAN') ;
  LblnBAL_CRDEFI := fCampoExiste('LANBAL', 'BAL_CRDEFI') ;

  LstrCampos := 'BAL_DTAMOV, BAL_CODCON, BAL_SALANT, BAL_DEBITO, BAL_CREDIT, BAL_SALFIN, BAL_CODEMP, BAL_CCUSTO' ;
  LstrParametros := ':DTAMOV, :CODCON, :SALANT, :DEBITO, :CREDIT, :SALFIN, :CODEMP, :CCUSTO' ;

  if LblnBAL_CRDEAN then
  begin
    LstrCampos := LstrCampos + ', BAL_CRDEAN' ;
    LstrParametros := LstrParametros + ', :CRDEAN' ;
  end ;

  if LblnBAL_CRDEFI then
  begin
    LstrCampos := LstrCampos + ', BAL_CRDEFI' ;
    LstrParametros := LstrParametros + ', :CRDEFI' ;
  end ;

  result := 'INSERT INTO LANBAL (' + LstrCampos + ') VALUES (' + LstrParametros + ') ;' ;
end ;

function fGetSqlinsertFecMes: string;
begin
  result := 'INSERT INTO FECMES (MES_CODOPE, MES_DTAFEC, MES_MESDTA, MES_CODEMP, MES_EMPGRV) VALUES (:CODOPE, :DTAFEC, :MESDTA, :CODEMP, :EMPGRV) ;' ;
end ;

function fInserirLotInc(strIncDoc, strTipLan, strEmpLan: string; dtaDtaLan: TDate; intAutoma: integer; intSequen: integer = -1): string;
  var
    qryLotInc : TUniQuery;
begin
  qryLotInc := fCriaQuery;
  try
    qryLotInc.Close;
    qryLotInc.SQL.Text := fGetSqlInsertLotInc;
    qryLotInc.ParamByName('INCDOC').AsString := strIncDoc;
    qryLotInc.ParamByName('TIPLAN').AsString := strTipLan;
    qryLotInc.ParamByName('COMPET').AsString := FormatDateTime('yyyymm', VS_Date);
    qryLotInc.ParamByName('EMPLAN').AsString := strEmpLan;
    qryLotInc.ParamByName('DTALAN').AsDateTime := dtaDtaLan;
    qryLotInc.ParamByName('AUTOMA').AsInteger := intAutoma;
    if (intSequen = -1) then
      qryLotInc.ParamByName('SEQUEN').AsInteger := fGetNovoLoteContabil
    else
      qryLotInc.ParamByName('SEQUEN').AsInteger := intSequen;
    qryLotInc.ExecSQL;
    Result := fFormatoLoteContabil(qryLotInc.ParamByName('COMPET').AsString, qryLotInc.ParamByName('SEQUEN').AsInteger);
  finally
    FreeAndNil(qryLotInc);
  end;
end;

function fGetSqlInsertLo2Inc: string;
begin
  Result := 'INSERT INTO LO2INC (INC_INCDOC, INC_TIPLAN, INC_COMPET, INC_EMPLAN, INC_DTALAN, INC_AUTOMA, INC_SEQUEN) VALUES (:INCDOC, :TIPLAN, :COMPET, :EMPLAN, :DTALAN, :AUTOMA, :SEQUEN)';
end;

function fInserirLo2Inc(strIncDoc, strTipLan, strEmpLan: string; dtaDtaLan: TDate; intAutoma: integer; intSequen: integer = -1): string;
  var
    qryLotInc : TUniQuery;
begin
  qryLotInc := fCriaQuery;
  try
    qryLotInc.Close;
    qryLotInc.SQL.Text := fGetSqlInsertLotInc;
    qryLotInc.ParamByName('INCDOC').AsString := strIncDoc;
    qryLotInc.ParamByName('TIPLAN').AsString := strTipLan;
    qryLotInc.ParamByName('COMPET').AsString := FormatDateTime('yyyymm', VS_Date);
    qryLotInc.ParamByName('EMPLAN').AsString := strEmpLan;
    qryLotInc.ParamByName('DTALAN').AsDateTime := dtaDtaLan;
    qryLotInc.ParamByName('AUTOMA').AsInteger := intAutoma;
    if (intSequen = -1) then
      qryLotInc.ParamByName('SEQUEN').AsInteger := fGetNovoLoteContabil
    else
      qryLotInc.ParamByName('SEQUEN').AsInteger := intSequen;
    qryLotInc.ExecSQL;
    Result := fFormatoLoteContabil(qryLotInc.ParamByName('COMPET').AsString, qryLotInc.ParamByName('SEQUEN').AsInteger);
  finally
    FreeAndNil(qryLotInc);
  end;
end;

procedure pSetaParametrosGerLanCon(recParCon: TParametrosConsulta; qryDados: TUniQuery);
begin
  If Not fEmptyStr(recParCon.strCodEmp) Then
    qryDados.ParamByName('CODEMP').AsString := recParCon.strCodEmp;

  if (recParCon.dtaDtaIni > 0) then
  begin
    qryDados.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
    qryDados.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
  end;

  if (not fEmptyStr(recParCon.strIncDoc)) and (Length(recParCon.arrIncDoc) = 0) then
    qryDados.ParamByName('INCDOC').AsString := recParCon.strIncDoc;
end;

procedure pShowModalContasPorEmpresa(objForm: IShowModalFormContasPorEmpresa);
begin
  objShowModalFormContasPorEmpresa := objForm;
end;

function fCarregaParconAvista(const ATipLan: string): TUniClientDataset;
var
  qryParCon : TUniQuery;
begin
  qryParCon := fCriaQuery;
  try
    qryParCon.Close;
    qryParCon.SQL.Add(' SELECT CON_SEQPAR, CON_CLAFIS, ');
    qryParCon.SQL.Add('   CAST(COALESCE(CON_VIGINI, "2000-01-01") AS DATE) AS CON_VIGINI, ');
    qryParCon.SQL.Add('   CAST(COALESCE(CON_VIGFIN, "3000-01-01") AS DATE) AS CON_VIGFIN ');
    qryParCon.SQL.Add(' FROM PARCON ');
    qryParCon.SQL.Add(' WHERE CON_TIPLAN = :TIPLAN ');
    qryParCon.SQL.Add('   AND CON_NATOPE = :NATOPE ');
    pSetarFiltroEmpresa(qryParCon) ;
    qryParCon.ParamByName('TIPLAN').AsString := ATipLan;
    qryParCon.ParamByName('NATOPE').AsString := 'À Vista';
    qryParCon.Open;

    Result := fCriaClientDatset(qryParCon);
    Result.IndexFieldNames := 'CON_SEQPAR';
    Result.Open;

  finally
    FreeAndNil(qryParCon);
  end;
end;

function fValidaParametroTipoAVista(ACdsParconAvista: TUniClientDataset; const dtaDataLan: TDate; const strCfop: string = ''): boolean;
begin
  Result := (ACdsParconAvista.FieldByName('CON_VIGINI').AsDateTime <= dtaDataLan) and (ACdsParconAvista.FieldByName('CON_VIGFIN').AsDateTime >= dtaDataLan);

  if Result and (not strCfop.IsEmpty) then
    Result := ACdsParconAvista.FieldByName('CON_CLAFIS').AsString.Contains(strCfop);
end;

function fParametrizouTipoAVista(ACdsParconAvista: TUniClientDataset; const dtaDataLan: TDate; const strCfop: string = ''): boolean;
begin
  Result := False;

  if ACdsParconAvista.IsEmpty then
    Exit;

  Result := fValidaParametroTipoAVista(ACdsParconAvista, dtaDataLan, strCfop);

  if Result then
    Exit;

  ACdsParconAvista.First;
  while not ACdsParconAvista.Eof do
  begin
    Result := fValidaParametroTipoAVista(ACdsParconAvista, dtaDataLan, strCfop);

    if Result then
      break;

    ACdsParconAvista.Next;
  end;
end;

function fgetContabilizaveis(const AIncDoc: string): TContabilizaveis; overload;
begin
  Result := TContabilizaveis.Create;
  Result.IncDoc := AIncDoc;
end;

function fgetContabilizaveis(const qryDados: TDataSet): TContabilizaveis;
begin
  Result := TContabilizaveis.Create;

  Result.IncDoc := TChaveDocInterprete.New(qryDados).getChave;

  if (Assigned(qryDados.FindField('TIPO_CLIENTE_FORNECEDOR'))) and
     (Assigned(qryDados.FindField('CODIGO_CLIENTE_FORNECEDOR'))) then
  begin
    if (qryDados.FieldByName('TIPO_CLIENTE_FORNECEDOR').AsString = 'C') then
      Result.Cliente.strCodigo := qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString
    else if (qryDados.FieldByName('TIPO_CLIENTE_FORNECEDOR').AsString = 'F') then
      Result.Fornecedor.strCodigo := qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString
  end;

  if (Assigned(qryDados.FindField('CODIGO_PORTADOR'))) then
    Result.Portador.strCodigo := qryDados.FieldByName('CODIGO_PORTADOR').AsString;

  if (Assigned(qryDados.FindField('CODIGO_PLANO_CONTA'))) then
    Result.PlanoContasCadastro.strCodigo := qryDados.FieldByName('CODIGO_PLANO_CONTA').AsString;

  if (Assigned(qryDados.FindField('CODIGO_PLANO_CONTA_BAIXA'))) then
    Result.PlanoContasBaixa.strCodigo := qryDados.FieldByName('CODIGO_PLANO_CONTA_BAIXA').AsString;

  if (Assigned(qryDados.FindField('CODIGO_PLANO_CONTA_TAXA'))) then
    Result.PlanoContasTaxa.strCodigo := qryDados.FieldByName('CODIGO_PLANO_CONTA_TAXA').AsString;

  if (Assigned(qryDados.FindField('CODIGO_BANDEIRA'))) then
    Result.CodigoBandeira := qryDados.FieldByName('CODIGO_BANDEIRA').AsString;
end;

function fCriarDataSetErros: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  With Result, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name     := 'ERR_STATUS';
      DataType := ftString;
      Size     := 2;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'ERR_MOTIVO';
      DataType := ftMemo;
      //Size     := 60;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'ERR_HISTOR';
      DataType := ftMemo;
      //Size     := 255;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'ERR_TIPLAN';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'ERR_DESVAL';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'ERR_NATOPE';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'ERR_ORIPLA';
      DataType := ftString;
      Size := 100;
      Required := False;
    end;

    With AddFieldDef Do
    Begin
      Name := 'ERR_CHVDOC';
      DataType := ftString;
      Size := 100;
      Required := False;
    end;

    With AddFieldDef Do
    Begin
      Name := 'ERR_TABELA';
      DataType := ftString;
      Size := 20;
      Required := False;
    end;

    With AddFieldDef Do
    Begin
      Name := 'ERR_PLANCO';
      DataType := ftString;
      Size := 50;
      Required := False;
    end;

    With AddFieldDef Do
    Begin
      Name := 'ERR_WARNIN';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    Result.FieldDefs.Add('ERR_CODEMP', ftString, 3, False);
    Result.FieldDefs.Add('ERR_DTALAN', ftDate, 0, False);
    Result.FieldDefs.Add('ERR_SIGLA', ftString, 20, False);

    IndexFieldNames := 'ERR_TIPLAN;ERR_STATUS';
    CreateDataSet;
    Open;
  End;
end;

function fConfiguracaoGrupoPlanoContas(blnFornecedor: boolean): string;
begin
  Result := 'GRPNCO';

  if (not blnFornecedor) then
    exit;

  if not fConfiguracaoExiste('GRPNCF') then
    exit;

  Result := 'GRPNCF';
end;

function fStringZerada(AValue: string): boolean;
begin
  Result := AValue = StringOfChar('0', Length(AValue));
end;

function fDataLanCon(const AarrIncDoc: TArrIncDoc; const ATipLan: string): TDateTime;
var
  LqryLanCon: TUniQuery ;
begin
  LqryLanCon := fCriaQuery() ;
  try
    LqryLanCon.Close ;
    LqryLanCon.SQL.Clear ;
    LqryLanCon.SQL.Add('SELECT MIN(CON_DTALAN) AS DTALAN FROM LANCON WHERE CON_TIPLAN = :TIPLAN ') ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('LANCON.CON_INCDOC')
      .fIncDoc('')
      .fArrIncDoc(AarrIncDoc)
      .fQuerySql(LqryLanCon)
      .fExecute ;

    LqryLanCon.Open ;
    Result := LqryLanCon.Fields.Fields[0].AsDateTime ;

  finally
    FreeAndNil(LqryLanCon) ;
  end ;
end;

function fCampoSaldoInicialPlaIni: string;
begin
  if fCampoExiste('PLAINI', 'INI_CREDEB') then
    Result := 'IF(INI_CREDEB = "D", ABS(INI_SALINI), -ABS(INI_SALINI))'
  else
    Result := 'INI_SALINI';
end;

function fCampoCCustoPlaIni(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(INI_CCUSTO,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;

function fCampoCCustoLanConCred(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(CON_CCUSCR,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;

function fCampoCCustoLanConDeb(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(CON_CCUSTO,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;

function fTemCfgFconcc: boolean;
begin
  result := False ;
  if fConfiguracaoExiste('FCONCC') then
  begin
    result := fCfgSis('FCONCC', varBoolean) ;
  end;
end;

function fProcuraPeriodoFechamentoPelaData(dtPesquisa:TDate; arr:TDynamicArrayFecCon; var recFecCon:TRecFecCon):boolean ;
var
  i : integer ;
begin
  result := False ;
  for i := Low(arr) to High(arr) do
  begin
    if arr[i].FecIni = dtPesquisa then
    begin
      recFecCon := arr[i] ;
      result := True ;
      break
    end;
  end;
end;

procedure pSeparaDatasPeriodoFechamentoSelecionado(var dtIni, dtFin:TDate; arr:TDynamicArrayFecCon) ;
var
  i : integer ;
  flag : boolean ;
begin
  flag := false ;
  for i := Low(arr) to High(arr) do
  begin
    if arr[i].Selecionado then
    begin
      if not flag then
      begin
        flag := True ;
        dtIni := arr[i].FecIni ;
      end;
      dtFin := arr[i].FecFin ;
    end;
  end;
end;

function fTemLinhaCodHpd(ALayoutSelecionado: TLayoutImportacaoContabil): boolean ;
var
  AChave : string ;
  LPosicaoInicial : Integer;
  LCodigoLayout : string;
begin
  AChave := 'CODHPD' ;
  LCodigoLayout := ALayoutSelecionado.toCodigo;
  LPosicaoInicial := fCampoTabela('LAY_POSINI', 'LYCONT', ['LAY_CODLAY', 'LAY_CODEMP', 'LAY_CODCAM'], [LCodigoLayout, VS_strCodEmp, AChave], True);
  result := (LPosicaoInicial > 0) ;
end;

function fTemVigencia: boolean;
begin
  result := fCampoExiste('PLANCO', 'NCO_DTAINI');
end;

function fCarregaPlancoVigencia:TUniClientDataSet;
var
  qryPlanco : TUniQuery ;
  strSql : string ;
begin
  result := nil ;
  if not fTemVigencia then
  begin
    exit ;
  end;
  strSql := '' ;
  strSql := strSql + ' SELECT NCO_CODCON, COALESCE(NCO_DTAINI, CAST("2000-01-01" AS DATE)) AS NCO_DTAINI, COALESCE(NCO_DTAFIN, CAST("9999-01-01" AS DATE)) AS NCO_DTAFIN, EMP_CODEMP ' ;
  strSql := strSql + ' FROM PLANCO INNER JOIN CADEMP ON PLANCO.NCO_TPLACO = CADEMP.EMP_TPLACO ' ;
  strSql := strSql + ' WHERE NCO_DTAINI IS NOT NULL OR NCO_DTAFIN IS NOT NULL ' ;
  strSql := strSql + ' ORDER BY NCO_CODCON, EMP_CODEMP ' ;

  qryPlanco := fCriaQuery(nil) ;
  try
    qryPlanco.SQL.Clear ;
    qryPlanco.SQL.Add(strSql) ;
    qryPlanco.Open ;

    result := fCriaClientDatset(qryPlanco, False, nil, False);
    result.IndexFieldNames := 'NCO_CODCON;EMP_CODEMP';

  finally
    qryPlanco.Close ;
    FreeAndNil(qryPlanco) ;
  end;
end;

function fCarregaPlancoInfo:TUniClientDataSet;
var
  LqryPlanco : TUniQuery ;
  LstrSql : string ;
begin
  LstrSql := '' ;
  LstrSql := LstrSql + ' SELECT PLANCO.NCO_CODCON, CADEMP.EMP_CODEMP, PLANCO.NCO_PATRIM ' ;
  LstrSql := LstrSql + '    FROM PLANCO INNER JOIN CADEMP ON PLANCO.NCO_TPLACO = CADEMP.EMP_TPLACO ' ;
  LstrSql := LstrSql + '    ORDER BY PLANCO.NCO_CODCON, CADEMP.EMP_CODEMP  ' ;

  LqryPlanco := fCriaQuery(nil) ;
  try
    LqryPlanco.SQL.Clear ;
    LqryPlanco.SQL.Add(LstrSql) ;
    LqryPlanco.Open ;

    result := fCriaClientDatset(LqryPlanco, False, nil, False);
    result.IndexFieldNames := 'NCO_CODCON;EMP_CODEMP';

  finally
    LqryPlanco.Close ;
    FreeAndNil(LqryPlanco) ;
  end;
end;

function fPrecisaLimparCentroCusto(const AcdsPlanco: TUniClientDataSet; const AstrContaContabil, AstrCodEmp: string):Boolean;
begin
  result := False ;

  if fEmptyStr(AstrContaContabil) then
    exit ;

  if fCfgPatCco = 'S' then
    exit ;

  if AcdsPlanco.FindKey([AstrContaContabil, AstrCodEmp]) then
    // se for conta patrimonial, limpa o centro de custo
    if AcdsPlanco.FieldByName('NCO_PATRIM').AsString = 'S' then
      result := True ;

end ;

function fRetornaCentroCusto(const AcdsPlanco: TUniClientDataSet; AstrContaContabil, AstrCentroCusto, AstrCodEmp: string):string;
begin
  result := '' ;

  if fEmptyStr(AstrCentroCusto) then
    exit ;

  if fPrecisaLimparCentroCusto(AcdsPlanco, AstrContaContabil, AstrCodEmp) then
    exit ;

  result := AstrCentroCusto ;

end ;

function fCarregaParconHistorico(const strTipLan:string; const blnUsaCheckListComplemento, blnConSeqParExiste:boolean):TUniClientDataSet;
var
  qryParcon : TUniQuery ;
begin
  qryParCon := fCriaQuery(nil) ;
  try
    qryParCon.SQL.Clear ;
    qryParCon.SQL.Add(' SELECT PARCON.*, PAD_DESCRI ');
    if (blnUsaCheckListComplemento) and (blnConSeqParExiste) then
    begin
      qryParCon.SQL.Add(' , CAST((SELECT GROUP_CONCAT(PAR_COMPLE SEPARATOR "_") FROM CMPPAR WHERE PAR_SEQPAR = CON_SEQPAR) AS CHAR(255)) AS COMPLEMENTOS ');
    end;
    qryParCon.SQL.Add('   FROM PARCON ');
    qryParCon.SQL.Add('   LEFT JOIN HISPAD ON PAD_CODIGO = CON_HISCRE ');
    if fCfgHisTpl then
      qryParCon.SQL.Add(' AND PAD_TPLACO = ' + fRetTplacoEmpresaLogada.QuotedString)
    else
      qryParCon.SQL.Add(' AND IFNULL(PAD_TPLACO, "") = "" ');
    qryParCon.SQL.Add('  WHERE CON_TIPLAN = :TIPLAN ');
    pSetarFiltroEmpresa(qryParCon) ;
    qryParCon.SQL.Add('  LIMIT 1 ');
    qryParCon.ParamByName('TIPLAN').AsString := strTipLan ;
    qryParCon.Open ;

    result := fCriaClientDatset(qryParCon, False, nil, False);
  finally
    qryParCon.Close ;
    FreeAndNil(qryParCon) ;
  end;
end;

function fVerificaPlancoVigencia(cdsPlancoVigencia: TUniClientDataSet; const dtaLanCon: TDate;
  const strCta: String; var strMensagemValidacao: String; const strCodEmp: string;
  AlstControleVigenciaContaContabil: TStringList = nil): boolean;
var
  LstrCta: string ;
begin
  result := True ;
  strMensagemValidacao := '' ;

  if not Assigned(cdsPlancoVigencia) then
  begin
    exit ;
  end;

  if Assigned(AlstControleVigenciaContaContabil) and (AlstControleVigenciaContaContabil.IndexOf(LstrCta+strCodEmp) > -1) then
    Exit ;

  LstrCta := fSemMascaraPlaNco(strCta) ;

  if fEmptyStr(LstrCta) then
  begin
    exit ;
  end;

  if cdsPlancoVigencia.FindKey([LstrCta, strCodEmp]) then
  begin
    if not ((dtaLanCon >= cdsPlancoVigencia.FieldByName('NCO_DTAINI').AsDateTime) and
            (dtaLanCon <= cdsPlancoVigencia.FieldByName('NCO_DTAFIN').AsDateTime)
           ) then
    begin
      strMensagemValidacao := 'Dt.Lanc.['+DateToStr(dtaLanCon)+'] fora vigência cta.:'+LstrCta ;
      result := False ;
      exit ;
    end;
  end;

  if Assigned(AlstControleVigenciaContaContabil) then
    AlstControleVigenciaContaContabil.Add(LstrCta+strCodEmp) ;

end;

function fCfgCtrpvi: string;
begin
  result := 'N' ;
  if fConfiguracaoExiste('CTRPVI') then
  begin
    result := fCfgSis('CTRPVI') ;
  end;
end;

function fNormalizaWarningGenerico(const strTipLan, strMensagem: string):string ;
begin
  result := '['+ strTipLan + ' | ' + strMensagem + ']' ;
end;

function fDemonstrativoEcfGrupo01(
  const ABloco: string): boolean;
begin
  result := True ;
  if ABloco = 'L210' then
  begin
    exit ;
  end;
  if ABloco = 'N600' then
  begin
    exit ;
  end;
  if ABloco = 'N620' then
  begin
    exit ;
  end;
  if ABloco = 'N630A' then
  begin
    exit ;
  end;
  if ABloco = 'N660' then
  begin
    exit ;
  end;
  if ABloco = 'N670' then
  begin
    exit ;
  end;
  if ABloco = 'Y681' then
  begin
    exit ;
  end;
  result := false ;
end;

function fDemonstrativoEcfGrupo02(
  const ABloco: string): boolean;
begin
  result := True ;
  if ABloco = 'M300A' then
  begin
    exit ;
  end;
  result := False ;
end;

function fDemonstrativoEcfGrupo03(
  const ABloco: string): boolean;
begin
  result := True ;
  if ABloco = 'M350A' then
  begin
    exit ;
  end;
  if ABloco = 'M350B' then
  begin
    exit ;
  end;
  result := False ;
end;

function fDemonstrativoEcfGrupo04(
  const ABloco: string): boolean;
begin
  result := True ;
  if ABloco = 'N500' then
  begin
    exit ;
  end;
  if ABloco = 'N610' then
  begin
    exit ;
  end;
  result := False ;
end;

function fDemonstrativoEcfGrupo05(
  const ABloco: string): boolean;
begin
  result := True ;
  if ABloco = 'N650' then
  begin
    exit ;
  end;
  result := False ;
end;

function fCfgCtrnum: string;
begin
  result := 'N' ;
  if fConfiguracaoExiste('CTRNUM') then
  begin
    result := fCfgSis('CTRNUM') ;
  end;
end;

function fGerarIncDocLanConManual:string ;
begin
  result := RightStr(fStrZero(Random(100), 3) + FormatDateTime('ddmmyyyyhhnnsszzz', fNow), 20) ;
end;

function fMskConPatrimonioLiquido(const AMascaraContabil:string=''): String;
const
  COMPL_MSK : String = ';0;_';
var
  strMascContabil : string ;
  strMascPatrimonio : string ;
begin

  if fEmptyStr(AMascaraContabil) then
  begin
    strMascContabil := fCfgSis('MSKCON', varString) ;
  end
  else
  begin
    strMascContabil := AMascaraContabil ;
  end;

  strMascPatrimonio := fSplitContaContabil(strMascContabil, 2) ;

  If Not strMascPatrimonio.EndsWith(COMPL_MSK) Then
    strMascPatrimonio := strMascPatrimonio + COMPL_MSK;

  Result := strMascPatrimonio ;
End;

function fMskConDigitoIdentificador(const AMascaraContabil:string=''): String ;
const
  COMPL_MSK : String = ';0;_';
var
  strMascContabil : string ;
  strMascDigIden : string ;
  intNivel : integer ;
begin

  if fEmptyStr(AMascaraContabil) then
  begin
    strMascContabil := fCfgSis('MSKCON', varString) ;
  end
  else
  begin
    strMascContabil := AMascaraContabil ;
  end;

  intNivel := length(SplitString(strMascContabil, '.')) ;

  ///desconta -1 do nivel, pois deve ser somente contas analiticas
  strMascDigIden := fSplitContaContabil(strMascContabil, intNivel-1) ;

  If Not strMascDigIden.EndsWith(COMPL_MSK) Then
    strMascDigIden := strMascDigIden + COMPL_MSK;

  Result := strMascDigIden ;
End;

function fMskConPrimeiroGrau(const AMascaraContabil:string=''): String ;
const
  COMPL_MSK : String = ';0;_';
var
  strMascContabil : string ;
begin
  Result := '';

  if fEmptyStr(AMascaraContabil) then
    strMascContabil := fCfgSis('MSKCON', varString)
  else
    strMascContabil := AMascaraContabil ;

  if strMascContabil.Trim.IsEmpty then
    Exit;

  Result := fSplitContaContabil(strMascContabil, 1) ;

  if not Result.EndsWith(COMPL_MSK) then
    Result := Result + COMPL_MSK;
end;

function fFiltroSQLAtvPas(const AstrCampoContaContabil: string; const AblnDigCom: Boolean = False): string;
var
  LstrAtvCfg, LstrAtvSql, LstrPasCfg, LstrPasSql, LstrComCfg, LstrComSql: string;
begin
  LstrAtvCfg := fCfgSis('DIGATI');
  LstrAtvSql := ' LEFT(' + AstrCampoContaContabil + ',' + fLenDig(LstrAtvCfg).ToString + ') = ' + LstrAtvCfg.QuotedString;

  LstrPasCfg := fCfgSis('DIGPAS');
  LstrPasSql := ' LEFT(' + AstrCampoContaContabil + ',' + fLenDig(LstrPasCfg).ToString + ') = ' + LstrPasCfg.QuotedString;

  LstrComSql := '';
  if AblnDigCom then
  begin
    LstrComCfg := fSemMascaraPlaNco(fCfgDigCom);
    if not LstrComCfg.IsEmpty then
      LstrComSql := ' LEFT(' + AstrCampoContaContabil + ',' + fLenDig(LstrComCfg).ToString + ') = ' + LstrComCfg.QuotedString;
  end;

  Result :=  '  AND (' + LstrAtvSql + ' OR ' + LstrPasSql + IfThen(not LstrComSql.IsEmpty, ' OR ' + LstrComSql) + ') ' ;
end;

function fSplitContaContabil(const AContaContabil:string; const AGrau:integer):string;
var
  intCnt : integer ;
  arrPartes : TStringDynArray ;
  strResultado : string ;
begin
  arrPartes := SplitString(AContaContabil, '.') ;
  strResultado := '' ;
  for intCnt := Low(arrPartes) to High(arrPartes) do
  begin
    if fEmptyStr(strResultado) then
    begin
      strResultado := arrPartes[intCnt] ;
    end
    else
    begin
      strResultado := strResultado + '.' + arrPartes[intCnt] ;
    end;
    if (intCnt+1) = AGrau then
    begin
      break ;
    end;
  end;
  Result := strResultado ;
end;

function fCfgCtntsi: string;
begin
  // De acordo com req. 431670 vamos sempre trabalhar com o valor "N"
  result := 'N' ;
end;

function fCfgDigcus: string;
begin
  result := '' ;
  if fConfiguracaoExiste('DIGCUS') then
  begin
    result := trim(fCfgSis('DIGCUS')) ;
  end;
end;

function fCfgDigdes: string;
begin
  result := '' ;
  if fConfiguracaoExiste('DIGDES') then
  begin
    result := trim(fCfgSis('DIGDES')) ;
  end;
end;

function fLenDig(const ACfg: string):integer;
begin
  result := 1 ;
  if fEmptyStr(ACfg) then
  begin
    exit ;
  end;
  result := Length(ACfg) ;
end;

function fCfgDigrec: string;
begin
  result := '' ;
  if fConfiguracaoExiste('DIGREC') then
  begin
    result := trim(fCfgSis('DIGREC')) ;
  end;
end;

procedure pValorBalCrdefi(qryLanBal:TDataSet; strValor:String) ;
begin
  if Assigned(qryLanBal.FindField('BAL_CRDEFI')) then
  begin
    qryLanBal.FieldByName('BAL_CRDEFI').AsString := strValor ;
  end;
end;

procedure pValorBalCrdean(qryLanBal:TDataSet; strValor:String) ;
begin
  if Assigned(qryLanBal.FindField('BAL_CRDEAN')) then
  begin
    qryLanBal.FieldByName('BAL_CRDEAN').AsString := strValor ;
  end;
end;

procedure pValorMesCredeb(qryPlaMes:TDataSet; strValor:String) ;
begin
  if Assigned(qryPlaMes.FindField('MES_CREDEB')) then
  begin
    qryPlaMes.FieldByName('MES_CREDEB').AsString := strValor ;
  end;
end;

function fCampoSaldoInicialPlaMes: string;
begin
  if fCampoExiste('PLAMES', 'MES_CREDEB') then
    Result := 'IF(MES_CREDEB = "D", ABS(MES_SALINI), -ABS(MES_SALINI))'
  else
    Result := 'MES_SALINI';
end;

function fCampoSaldoAnteriorLanBal: string;
begin
  if fCampoExiste('LANBAL', 'BAL_CRDEAN') then
    Result := 'IF(BAL_CRDEAN = "D", ABS(BAL_SALANT), -ABS(BAL_SALANT))'
  else
    Result := 'BAL_SALANT';
end;

function fCampoSaldoFinalLanBal: string;
begin
  if fCampoExiste('LANBAL', 'BAL_CRDEFI') then
    Result := 'IF(BAL_CRDEFI = "D", ABS(BAL_SALFIN), -ABS(BAL_SALFIN))'
  else
    Result := 'BAL_SALFIN';
end;

function fCreDebPeloValor(const fltValor:double):string ;
begin
  if fltValor > 0 then
  begin
    result := 'D' ;
  end
  else
  begin
    result := 'C' ;
  end;
end;

function fCfgConTra: string;
begin
  result := 'S' ;
  if fConfiguracaoExiste('CONTRA') then
  begin
    result := fCfgSis('CONTRA') ;
  end;
end;

function fUsarNaturezaOperacaoCapaOuItem: string;
begin
  result := 'N' ;
  if fConfiguracaoExiste('NATCNT') then
    result := fCfgSis('NATCNT') ;
end ;

function fUsarNaturezaOperacaoDoItemNoEnt: Boolean ;
begin
  result := fCampoExiste('MOVTRI', 'DET_NATOPE') and (fUsarNaturezaOperacaoCapaOuItem = 'N') ;
end ;

function fCfgDigCom: string;
begin
  result := '' ;
  if fConfiguracaoExiste('DIGCOM') then
  begin
    result := trim(fCfgSis('DIGCOM')) ;
  end;
end;

function fCfgDigApu: string;
begin
  result := '5' ;
  if fConfiguracaoExiste('DIGAPU') then
  begin
    result := trim(fCfgSis('DIGAPU')) ;
  end;
end;

function fColunaExisteSeleci: boolean;
begin
  result := fCampoExiste('LYCONT', 'LAY_SELECI') ;
end;

function fTemPlancosTipoImobilizado: boolean;
begin
  result := fCampoExiste('TIPIMO', 'TIP_PCATIM') ;
end;

procedure pRetornaFiltroAdicionalDemonstrativoECF(
  const ATipoLancamento, ATipoTabela, ALalurLacs: string;
  var ABloco, ARegistro, ATipo, ATipoLan: string);
begin
  ABloco := 'M' ;
  ARegistro := '' ;
  ATipo := QuotedStr('E') ;
  ATipoLan := '' ;

  if ALalurLacs = cLALUR then
  begin
    ARegistro := '300' ;
  end
  else if ALalurLacs = cLACS then
  begin
    ARegistro := '350' ;
  end;

  if StrToIntDef(ATipoTabela,0) = 1 then
  begin
    ARegistro := ARegistro + 'A' ;
  end
  else if StrToIntDef(ATipoTabela,0) = 2 then
  begin
    ARegistro := ARegistro + 'B' ;
  end
  else if StrToIntDef(ATipoTabela,0) = 3 then
  begin
    ARegistro := ARegistro + 'C' ;
  end;

  if copy(ATipoLancamento,1,1) = 'A' then  ////adição
  begin
    ATipoLan := 'A' ;
  end
  else if copy(ATipoLancamento,1,1) = 'E' then  ///exclusão
  begin
    ATipoLan := 'E' ;
  end
  else if copy(ATipoLancamento,1,1) = 'C' then ///compensação
  begin
    ATipoLan := 'P' ;
  end;

  ////regra adicional
  if (ALalurLacs = cLALUR) and (copy(ATipoLancamento,1,1) = 'A') and (StrToIntDef(ATipoTabela,0) in [1,3]) then
  begin
    ATipo := ATipo + ',' + QuotedStr('CA') ;
  end;

end;

function fRetDescDemonstrativoECF(
  const ACodigo, ALalurLacs, ATipoMovimento, ACodigoTabela: String; var ABloco, ARegistro: string): String;
var
  LBloco, LRegistro, LTipo, LTipoLan: string;
  qryConsulta: TUniQuery ;
  strSQL: String ;
  strWhere: String ;
  strCSLL: String ;
begin
  pRetornaFiltroAdicionalDemonstrativoECF(
   ATipoMovimento,
   ACodigoTabela,
   ALalurLacs,
   LBloco,
   LRegistro,
   LTipo,
   LTipoLan) ;

  strCSLL := fRetDemEcdCSLL(LBloco, LRegistro, LTipo, LTipoLan) ;

  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + '  DEM_DESCRI  ';
  strSQL := strSQL + 'FROM                ';
  strSQL := strSQL + '  ECFDEM            ';
  strSQL := strSQL + 'WHERE                ';
  strSQL := strSQL + '  DEM_CODDEM = :CODDEM ';

  strWhere := ' TRUE ' ;
  if not fEmptyStr(LBloco) then
    strWhere := strWhere + ' AND DEM_BLCECF = ' + LBloco.QuotedString;

  if not fEmptyStr(LRegistro) then
    strWhere := strWhere + ' AND DEM_REGECF = ' + LRegistro.QuotedString;

  if not fEmptyStr(LTipo) then
    strWhere := strWhere + ' AND DEM_TIPDEM IN (' + LTipo + ') ';

  if not fEmptyStr(LTipoLan) then
    strWhere := strWhere + ' AND DEM_TIPLAN = ' + LTipoLan.QuotedString;

  strWhere := '(' + strWhere + ')' ;
  if not fEmptyStr(strCSLL) then
  begin
    strWhere := strWhere + ' OR AUTOINCREM IN (' + strCSLL + ') '
  end;

  strSQL := strSQL + ' AND (' + strWhere + ') ' ;

  qryConsulta := fCriaQuery ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(strSQL) ;
    qryConsulta.ParamByName('CODDEM').AsString := ACodigo ;
    qryConsulta.Open ;

    result := qryConsulta.FieldByName('DEM_DESCRI').AsString ;
    ABloco := LBloco ;
    ARegistro := LRegistro ;
  finally
    FreeAndNil(qryConsulta) ;
  end;

end;

function fRetDescPadraoRFBParteB(
  const ACodigo, ATributo: String): String;
var
  qryConsulta: TUniQuery ;
  strSQL: String ;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LLB_DESCRI  ';
  strSQL := strSQL + 'FROM                ';
  strSQL := strSQL + '  ECFLLB            ';
  strSQL := strSQL + 'WHERE                ';
  strSQL := strSQL + '  LLB_CODIGO = :CODIGO ';

  if not fEmptyStr(ATributo) then
    strSQL := strSQL + ' AND LLB_TRIBUT IN ( ' + ATributo + ')';

  qryConsulta := fCriaQuery ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(strSQL) ;
    qryConsulta.ParamByName('CODIGO').AsString := ACodigo ;
    qryConsulta.Open ;

    result := qryConsulta.FieldByName('LLB_DESCRI').AsString ;

  finally
    FreeAndNil(qryConsulta) ;
  end;

end;

function fRetTplacoEmpresaLogada(const ACodEmp: string = ''; const blnLerBanco: Boolean = False):string;
var
  strTplAco : string ;
  LCodEmp: string ;
begin
  result := '000000' ;

  if fEmptyStr(ACodEmp) then
  begin
    LCodEmp := Vs_strCodEmp ;
  end
  else
  begin
    LCodEmp := ACodEmp ;
  end;

  strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [LCodEmp], blnLerBanco);
  if not fEmptyStr(strTplAco) then
  begin
    result := strTplAco ;
  end;
end;

function fCfgObrCcu: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('OBRCCU') then
    exit;

  if (not fCfgSis('OBRCCU', varBoolean)) then
    exit;
  result := 'S' ;
end;

function fRetDemEcdCSLL(const ABloco, ARegistro, ATipo, ATipoLan: string):string ;
var
  qryAdicional: TUniQuery;
  strAutoInc: string ;
begin
  result := '' ;
  if (ABloco = 'M') and
     (ARegistro = '300B') and
     (ATipo = Quotedstr('E')) and
     (ATipoLan = 'A') then
  begin
    qryAdicional := fCriaQuery() ;
    try
      qryAdicional.Close ;
      qryAdicional.SQL.Clear ;
      qryAdicional.SQL.Add('SELECT AUTOINCREM FROM ECFDEM WHERE DEM_BLCECF = :BLCECF AND DEM_REGECF = :REGECF AND DEM_CODDEM  = "7" ') ;
      qryAdicional.ParamByName('BLCECF').AsString := ABloco ;
      qryAdicional.ParamByName('REGECF').AsString := ARegistro ;
      qryAdicional.Open ;
      qryAdicional.First ;
      strAutoInc := '' ;
      while not qryAdicional.Eof do
      begin
        if fEmptyStr(strAutoInc) then
        begin
          strAutoInc := qryAdicional.FieldByName('AUTOINCREM').AsString ;
        end
        else
        begin
          strAutoInc := strAutoInc + ',' + qryAdicional.FieldByName('AUTOINCREM').AsString ;
        end;
        qryAdicional.Next ;
      end;
      result := strAutoInc ;
    finally
      FreeAndNil(qryAdicional) ;
    end;
  end;
end;

function fCfgExpEcd: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('EXPECD') then
    exit;

  if (not fCfgSis('EXPECD', varBoolean)) then
    exit;
  result := 'S' ;
end;

function fUtilizaNaturezaDoAjuste: boolean;
begin
  Result := False;

  if not fConfiguracaoExiste('SPDECF') then
    Exit;

  if not fCfgSis('SPDECF', varBoolean) then
    Exit;

  if not fCampoExiste('PLANCO', 'NCO_NATAJU') then
    Exit;

  Result := True;
end;

function fCfgTrDcZe: string;
begin
  result := 'S' ;
  if not fConfiguracaoExiste('TRDCZE') then
    exit;

  if fCfgSis('TRDCZE', varBoolean) then
    exit;
  result := 'N' ;
end;

function fCfgCSaCst: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('CSACST') then
    exit;

  if not fCfgSis('CSACST', varBoolean) then
    exit;
  result := 'S' ;
end;

function fColunaExisteConCodTri: boolean;
begin
  Result := False ;
  if not fCampoExiste('PARCON', 'CON_CODTRI') then
    Exit;
  Result := True ;
end;

function fCfgCAgrDp: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('CAGRDP') then
    exit;

  if not fCfgSis('CAGRDP', varBoolean) then
    exit;
  result := 'S' ;
end;

function fCfgImpAgr: Boolean;
begin
  Result := False ;

  if not fConfiguracaoExiste('IMPAGR') then
    Exit;

  if not fCfgSis('IMPAGR', varBoolean) then
    exit;

  Result := True ;
end;

function fPodeUsarTiposContabeisAgrupamento(const ATipo: TTiposContabeis):boolean ;
begin
  if fCfgCAgrDp = 'N' then
  begin
    if ATipo in [tcAGR, tcAGP] then
    begin
      result := False ;
      exit ;
    end;
  end;
  Result := True ;
end;

function fAjustaIndexDescricaoContabil(
  const AIndex: Integer; const ALista: TStrings): Integer;
var
  intCnt: integer ;
  strTipoContabil: string ;
begin
  if AIndex <= -1 then
  begin
    result := -1 ;
    exit ;
  end;

  strTipoContabil :=  LeftStr(trim(ALista.Strings[AIndex]), 3) ;
  result := -1 ;

  for intCnt := 0 to Length(DES_CONTABIL_SIGLA)-1 do
  begin
    if strTipoContabil = DES_CONTABIL_SIGLA[TTiposContabeis(intCnt)] then
    begin
      result := intCnt ;
      break ;
    end;
  end;
end;

function fCfgTipCar: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('TIPCAR') then
    exit;

  if not fCfgSis('TIPCAR', varBoolean) then
    exit;
  result := 'S' ;
end;

function fCfgLigPdd: string;
begin
  result := 'S' ;
  if not fConfiguracaoExiste('LIGPDD') then
    exit;

  if fCfgSis('LIGPDD', varBoolean) then
    exit;
  result := 'N' ;
end;

function fCfgExpCtb: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('EXPCTB') then
    exit;

  if not fCfgSis('EXPCTB', varBoolean) then
    exit;
  result := 'S' ;
end;

function fCfgMaxHpd: integer;
begin
  result := 40 ;
  if not fConfiguracaoExiste('MAXHPD') then
    exit;

  result := fCfgSis('MAXHPD', varInteger) ;
end;

function fCfgAgrLan: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('AGRLAN') then
    exit;

  if not fCfgSis('AGRLAN', varBoolean) then
    exit;

  result := 'S' ;
end;

function fPodeAgruparLancamentos(const ATipLan: string; const AblnAgrupaSaiEnt: Boolean):boolean ;
begin
  Result := False ;

  if (ATipLan = 'ENT') or (ATipLan = 'SAI') then
  begin
    if AblnAgrupaSaiEnt then
    begin
      Result := True ;
    end ;
  end;

end;

function fPodeAgruparLancamentoImpAgr(const AItem: TDadosImportacaoContabil; const AblnImpAgr: Boolean): boolean ;
const
  CarrImpAgrDesVal: array[0..14] of string = (
    DES_VALOR_ICMS,
    DES_VALOR_IPI,
    DES_VALOR_SUBTRIB,
    DES_VALOR_PIS,
    DES_VALOR_COFINS,
    DES_VALOR_ISS,
    DES_VALOR_CSLL,
    DES_VALOR_IRPJ,
    DES_VALOR_INSS,
    DES_VALOR_RETENCAO_PIS,
    DES_VALOR_RETENCAO_COFINS,
    DES_VALOR_ICMS_ST,
    DES_VALOR_INSS_PATRONAL,
    DES_VALOR_FCP,
    DES_VALOR_FCP_ST
  );
var
  LIntCount: Integer;
begin
  Result := False;

  if (AItem.strTipoLancamento <> 'ENT') then
    Exit;

  if not AblnImpAgr then
    Exit;

  for LIntCount := Low(CarrImpAgrDesVal) to High(CarrImpAgrDesVal) do
  begin
    Result := CarrImpAgrDesVal[LIntCount] = AItem.strDescricaoValor;
    if Result then
      Break;
  end;
end;

function fRetornaChaveImpAgr(const AItem: TDadosImportacaoContabil): string;
begin
  result := AItem.strCodigoEmpresa  + '|' +
            AItem.strTipoLancamento + '|' +
            AItem.strDescricaoValor + '|' +
            AItem.strContaDebito    + '|' +
            AItem.strContaCredito   + '|' +
            AItem.strCtpInc         + '|' +
            AItem.strTip_fc         + '|' +
            AItem.strCliFor         + '|' +
            AItem.strCfopConfig     + '|' +
            AItem.strCCusto         + '|' +
            AItem.strCCustoCredito  ;
end;

function fRetornaChaveAgrupaLancamentos(
  const AItem: TDadosImportacaoContabil): string;
begin
  result := AItem.strCodigoEmpresa  + '|' +
            AItem.strTipoLancamento + '|' +
            AItem.strDescricaoValor + '|' +
            AItem.strContaDebito    + '|' +
            AItem.strContaCredito   + '|' +
            AItem.strCCusto         + '|' +
            AItem.strCCustoCredito  + '|' +
            AItem.strCtpInc ;
end;

function fVericaContaNoPlanoContas(const AStrContaContabil, AstrCodEmp, AstrTipo: string; var AlstControlePesquisaContaContabil: TStringList): string;
var
  strVerifica : string ;
  strTpLaCo : string ;
  blnCtntsi : boolean ;
begin
  result := '' ;

  if AlstControlePesquisaContaContabil.IndexOf(AStrContaContabil+AstrCodEmp) > -1 then
    Exit ;

  strTpLaCo := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [AstrCodEmp], False) ;
  blnCtntsi := fCfgCtntsi = 'N' ;
  if not fEmptyStr(AStrContaContabil) then
  begin
    strVerifica := fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [AStrContaContabil, strTpLaCo], False) ;
    if fEmptyStr(strVerifica) then
    begin
      result :=  'Conta ' + AstrTipo + ' [' + AStrContaContabil + ' - ' + strTpLaCo + '] inexistente, verifique os parâmetros contábeis!' ;
      exit ;
    end;
    if blnCtntsi then
    begin
      if strVerifica = 'S' then
      begin
        result :=  'Conta ' + AstrTipo + ' [' + AStrContaContabil + ' - ' + strTpLaCo + '] configurada como sintética, verifique os parâmetros contábeis!' ;
        exit ;
      end;
    end;
  end;

  AlstControlePesquisaContaContabil.Add(AStrContaContabil+AstrCodEmp) ;

end;

procedure pCarregaResponsavel(
  var AContador: TObjectList<TInfoResponsavelContador>;
  var AAdministrador: TObjectList<TInfoResponsavelEmpresa>);
var
  qryCarrega: TUniQuery ;
  ItemContador: TInfoResponsavelContador ;
  ItemAdministrador: TInfoResponsavelEmpresa ;
begin
  qryCarrega := fCriaQuery() ;
  try
    qryCarrega.SQL.Add(' SELECT CSE_NOMSIG, CSE_DESQUA, CSE_DOCSIG, CSE_NUMCRC ') ;
    qryCarrega.SQL.Add(' FROM CADCSE ') ;
    qryCarrega.SQL.Add(' ORDER BY CSE_NOMSIG ') ;
    qryCarrega.Open ;
    qryCarrega.First ;
    while not qryCarrega.Eof do
    begin
      /// contador
      if not qryCarrega.FieldByName('CSE_NUMCRC').IsNull then
      begin
        ItemContador := TInfoResponsavelContador.Create ;
        ItemContador.CSE_NOMSIG := qryCarrega.FieldByName('CSE_NOMSIG').AsString ;
        ItemContador.CSE_NUMCRC := qryCarrega.FieldByName('CSE_NUMCRC').AsString ;
        ItemContador.CSE_DOCSIG := qryCarrega.FieldByName('CSE_DOCSIG').AsString ;
        AContador.Add(ItemContador) ;
      end
      else /// administrador
      begin
        ItemAdministrador := TInfoResponsavelEmpresa.Create ;
        ItemAdministrador.CSE_NOMSIG := qryCarrega.FieldByName('CSE_NOMSIG').AsString ;
        ItemAdministrador.CSE_DESQUA := qryCarrega.FieldByName('CSE_DESQUA').AsString ;
        ItemAdministrador.CSE_DOCSIG := qryCarrega.FieldByName('CSE_DOCSIG').AsString ;
        AAdministrador.Add(ItemAdministrador) ;
      end;
      qryCarrega.Next ;
    end;

  finally
    FreeAndNil(qryCarrega) ;
  end;
end;

procedure pCarregaResponsavelComboBoxAdministrador(
  const AContador: TObjectList<TInfoResponsavelEmpresa>;
  var ACombo: TcxComboBox);
var
  LItem: TInfoResponsavelEmpresa ;
begin
  ACombo.Clear ;
  for LItem in AContador do
  begin
    ACombo.Properties.Items.AddObject(LItem.CSE_NOMSIG, LItem) ;
  end;
  if ACombo.Properties.Items.Count = 1 then
  begin
    ACombo.ItemIndex := 0 ;
  end;
end;

procedure pCarregaResponsavelComboBoxContador(
  const AContador: TObjectList<TInfoResponsavelContador>;
  var ACombo: TcxComboBox);
var
  LItem: TInfoResponsavelContador ;
begin
  ACombo.Clear ;
  for LItem in AContador do
  begin
    ACombo.Properties.Items.AddObject(LItem.CSE_NOMSIG, LItem) ;
  end;
  if ACombo.Properties.Items.Count = 1 then
  begin
    ACombo.ItemIndex := 0 ;
  end;
end;

procedure pInfoAnoExercicio(
  const ALimpar: boolean; var AExercicio, AExercicioAnterior: string; const AAno:integer);
begin
  if ALimpar then
  begin
    AExercicio := '' ;
    AExercicioAnterior := '' ;
  end
  else
  begin
    AExercicio := '31/12/'+IntToStr(AAno) ;
    AExercicioAnterior := '31/12/'+inttostr(AAno-1);
  end;
end;

function fCarregaEmpresaRelatorio(
  const AArrEmp: TConsultasArray): TInfoEmpresaSelecionadaRelatorio;
var
  strEmpSel: string ;
  strEmpMat: string ;
  intCnt: integer ;
  qryConsulta: TUniQuery ;
begin
  strEmpMat := fCfgSis('EMPMAT') ;
  if Length(AArrEmp) = 0 then  ///todas lojas selecionadas
  begin
    strEmpSel := strEmpMat ;
  end
  else if Length(AArrEmp) = 1 then /// uma empresa selecionada
  begin
    strEmpSel := AArrEmp[0].strCodigo ;
  end
  else /// algumas lojas selecionadas
  begin
    for intCnt := Low(AArrEmp) to High(AArrEmp) do
    begin
      if AArrEmp[intCnt].strCodigo = strEmpMat then
      begin
        strEmpSel := strEmpMat ;
      end;
    end;
  end;

  if fEmptyStr(strEmpSel) then
  begin
    result.EMP_NOMEMP := '' ;
    result.EMP_ENDERE := '' ;
    result.EMP_BAIRRO := '' ;
    result.EMP_ENDNUM := '' ;
    result.EMP_ENDCMP := '' ;
    result.EMP_C_E_P_ := '' ;
    result.EMP_C_G_C_ := '' ;
    result.EMP_I_E_S_ := '' ;
    result.EMP_JUCESP := '' ;
    result.EMP_CIDADE := '' ;
    result.EMP_ESTADO := '' ;
    exit ;
  end;

  qryConsulta := fCriaQuery ;
  try
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(' SELECT EMP_NOMEMP, EMP_ENDERE, EMP_BAIRRO, EMP_ENDNUM, EMP_ENDCMP, EMP_C_E_P_, EMP_C_G_C_, EMP_I_E_S_, EMP_JUCESP, CID_NOMCID AS EMP_CIDADE, CID_ESTADO ') ;
    qryConsulta.SQL.Add(' FROM CADEMP LEFT JOIN CADCID ON EMP_CODCID = CID_CODCID ') ;
    qryConsulta.SQL.Add(' WHERE EMP_CODEMP = :CODEMP ') ;
    qryConsulta.ParamByName('CODEMP').AsString := strEmpSel ;
    qryConsulta.Open ;

    result.EMP_NOMEMP := qryConsulta.FieldByName('EMP_NOMEMP').AsString ;
    result.EMP_ENDERE := qryConsulta.FieldByName('EMP_ENDERE').AsString ;
    result.EMP_BAIRRO := qryConsulta.FieldByName('EMP_BAIRRO').AsString ;
    result.EMP_ENDNUM := qryConsulta.FieldByName('EMP_ENDNUM').AsString ;
    result.EMP_ENDCMP := qryConsulta.FieldByName('EMP_ENDCMP').AsString ;
    result.EMP_C_E_P_ := qryConsulta.FieldByName('EMP_C_E_P_').AsString ;
    result.EMP_C_G_C_ := qryConsulta.FieldByName('EMP_C_G_C_').AsString ;
    result.EMP_I_E_S_ := qryConsulta.FieldByName('EMP_I_E_S_').AsString ;
    result.EMP_JUCESP := qryConsulta.FieldByName('EMP_JUCESP').AsString ;
    result.EMP_CIDADE := qryConsulta.FieldByName('EMP_CIDADE').AsString ;
    result.EMP_ESTADO := qryConsulta.FieldByName('CID_ESTADO').AsString ;
  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

function fCarregaStringDataRelatorio(const ACidade, AEstado: string): string;
const
  arrMes: Array [0..12] Of String = ('', 'Janeiro', 'Fevereiro', 'Março', 'Abril',
    'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');
var
  LCidade, LEstado: string ;
  qryConsulta: TUniQuery ;
begin
  if fEmptyStr(ACidade) then
  begin
    qryConsulta := FCriaQuery() ;
    try
      qryConsulta.SQL.Clear ;
      qryConsulta.SQL.Add(' SELECT CID_NOMCID, CID_ESTADO ') ;
      qryConsulta.SQL.Add(' FROM CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID ') ;
      qryConsulta.SQL.Add(' WHERE EMP_CODEMP = :CODEMP ') ;
      qryConsulta.ParamByName('CODEMP').AsString := fCfgSis('EMPMAT') ;
      qryConsulta.Open ;
      LCidade := qryConsulta.FieldByName('CID_NOMCID').AsString ;
      LEstado := qryConsulta.FieldByName('CID_ESTADO').AsString ;
    finally
      FreeAndNil(qryConsulta) ;
    end;
  end
  else
  begin
    LCidade := ACidade ;
    LEstado := AEstado ;
  end;
  result := LCidade + '/' + LEstado + ', ' +inttostr(DayOf(Date))+ ' de '+arrMes[Pred(MonthOf(Date))]+' de '+inttostr(YearOf(Date))+'.' ;
end;

procedure pExibirRelatorio(strNomPro, strDesPro: String; AReport: TfrxReport);
begin
  AReport.PreviewOptions.Buttons := [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator];
  If Assigned(ProcExibirRelatorio) Then
    ProcExibirRelatorio(strNomPro, strDesPro, AReport)
  Else
    AReport.ShowReport;
end;

procedure pPreparaRelatorio(const AExercicio: integer;
                            const AArrEmpSel: TConsultasArray;
                            const AImprimirAssinatura, AImprimirParaArquivo: boolean;
                            const ANumeroPaginaInicial, ANumeroLivro: integer;
                            const AInfoResponsavelEmpresa: TInfoResponsavelEmpresa;
                            const AInfoResponsavelContador: TInfoResponsavelContador;
                            const ATituloRelatorio: string;
                            var ARelatorio: TfrxReport);
{$I rev.inc}
var
  strExercicio, strExercicioAnterior : string ;
  LLinhaAdm, LLinhaCon: TfrxLineView ;
  LBandaCabecalho: TfrxReportTitle ;
  LMemoObs, LMemoLivro, LMemoPagina: TfrxMemoView ;
  LLinhaCabecalho, LLinhaCabecalho2: TfrxLineView ;
  LMemoCabecalho: TfrxMemoView ;
  LLinha01, LLinha02, LLinha03, LLinha04, LLinha05: TfrxMemoView ;
  LInfoEmpresa: TInfoEmpresaSelecionadaRelatorio ;
begin

  LInfoEmpresa := fCarregaEmpresaRelatorio(AArrEmpSel) ;

  pInfoAnoExercicio(False, strExercicio, strExercicioAnterior, AExercicio) ;
  ARelatorio.Script.Variables['EXERCI'] := strExercicio ;
  ARelatorio.Script.Variables['EXEANT'] := strExercicioAnterior ;
  ARelatorio.Script.Variables['REPTIT'] := ATituloRelatorio ;
  ARelatorio.Script.Variables['DATAHO'] := fCarregaStringDataRelatorio(LInfoEmpresa.EMP_CIDADE, LInfoEmpresa.EMP_ESTADO) ;

  LLinhaAdm := (ARelatorio.FindObject('LineAdministrador') as TfrxLineView) ;
  LLinhaAdm.Visible := AImprimirAssinatura or AImprimirParaArquivo ;
  LLinhaCon := (ARelatorio.FindObject('LineContador') as TfrxLineView) ;
  LLinhaCon.Visible := AImprimirAssinatura or AImprimirParaArquivo ;

  ARelatorio.Script.Variables['PaginaInicial'] := intTostr(ANumeroPaginaInicial-1) ; /// subtrai 1 por causa que a pagina inicial do fast é 1
  ARelatorio.Script.Variables['NumeroLivro'] := intToStr(ANumeroLivro) ;
  ARelatorio.Script.Variables['VersaoDataHora'] := DateTimeToStr(fnow) + ' - ' + SVN_REVISION ;

  if (AImprimirAssinatura) or (AImprimirParaArquivo) then
  begin
    /// responsavel
    ARelatorio.Script.Variables['NOMRES'] := 'Nome: ' + AInfoResponsavelEmpresa.CSE_NOMSIG ;
    ARelatorio.Script.Variables['QUALIF'] := 'Qualificação: ' + AInfoResponsavelEmpresa.CSE_DESQUA ;
    ARelatorio.Script.Variables['RESCPF'] := 'CPF: ' + FormatMaskText('000.000.000-00;0',AInfoResponsavelEmpresa.CSE_DOCSIG) ;
    /// contador
    ARelatorio.Script.Variables['NOMCON'] := 'Nome: ' + AInfoResponsavelContador.CSE_NOMSIG ;
    ARelatorio.Script.Variables['NUMCRC'] := 'CRC: ' + AInfoResponsavelContador.CSE_NUMCRC ;
    ARelatorio.Script.Variables['CONCPF'] := 'CPF: ' + FormatMaskText('000.000.000-00;0',AInfoResponsavelContador.CSE_DOCSIG) ;
  end
  else ///limpa os valores
  begin
    ARelatorio.Script.Variables['NOMRES'] := '' ;
    ARelatorio.Script.Variables['QUALIF'] := '' ;
    ARelatorio.Script.Variables['RESCPF'] := '' ;
    ARelatorio.Script.Variables['NOMCON'] := '' ;
    ARelatorio.Script.Variables['NUMCRC'] := '' ;
    ARelatorio.Script.Variables['CONCPF'] := '' ;
  end;

  LBandaCabecalho := (ARelatorio.FindObject('BandaCabecalho') as TfrxReportTitle) ;
  LMemoObs := (ARelatorio.FindObject('MemoObs') as TfrxMemoView) ;
  LMemoLivro := (ARelatorio.FindObject('memoLivro') as TfrxMemoView) ;
  LMemoPagina := (ARelatorio.FindObject('memoPagina') as TfrxMemoView) ;
  LMemoCabecalho := (ARelatorio.FindObject('MemoCabecalho') as TfrxMemoView) ;
  LLinhaCabecalho := (ARelatorio.FindObject('LinhaCabecalho') as TfrxLineView) ;
  LLinhaCabecalho2 := (ARelatorio.FindObject('LinhaCabecalho2') as TfrxLineView) ;
  LLinha01 := (ARelatorio.FindObject('Linha01') as TfrxMemoView) ;
  LLinha02 := (ARelatorio.FindObject('Linha02') as TfrxMemoView) ;
  LLinha03 := (ARelatorio.FindObject('Linha03') as TfrxMemoView) ;
  LLinha04 := (ARelatorio.FindObject('Linha04') as TfrxMemoView) ;
  LLinha05 := (ARelatorio.FindObject('Linha05') as TfrxMemoView) ;

  LLinha01.Visible := AImprimirParaArquivo ;
  LLinha02.Visible := AImprimirParaArquivo ;
  LLinha03.Visible := AImprimirParaArquivo ;
  LLinha04.Visible := AImprimirParaArquivo ;
  LLinha05.Visible := AImprimirParaArquivo ;
  LLinhaCabecalho2.Visible := AImprimirParaArquivo ;
  LMemoLivro.Visible := AImprimirParaArquivo and (ANumeroLivro >= 0) ;
  LMemoPagina.Visible := AImprimirParaArquivo and (ANumeroPaginaInicial >= 0) ;
  if AImprimirParaArquivo then
  begin
    LBandaCabecalho.Height := 148.74015748 ;
    ARelatorio.Script.Variables['LINHA01'] := 'Razão Social: ' + LInfoEmpresa.EMP_NOMEMP ;
    ARelatorio.Script.Variables['LINHA02'] := 'Endereço: ' + LInfoEmpresa.EMP_ENDERE +
                                                               iif(fEmptyStr(LInfoEmpresa.EMP_ENDNUM), '', ', '+LInfoEmpresa.EMP_ENDNUM) +
                                                               iif(fEmptyStr(LInfoEmpresa.EMP_ENDCMP), '', ', '+LInfoEmpresa.EMP_ENDCMP) +
                                                               ', '+LInfoEmpresa.EMP_BAIRRO +
                                                               ', '+LInfoEmpresa.EMP_CIDADE + '/' + LInfoEmpresa.EMP_ESTADO +
                                                               ', '+FormatMaskText('00000-000;0',LInfoEmpresa.EMP_C_E_P_) ;
    ARelatorio.Script.Variables['LINHA03'] := 'CNPJ: '+ FormatMaskText('>aa\.aaa\.aaa/aaaa-99;0',LInfoEmpresa.EMP_C_G_C_);
    ARelatorio.Script.Variables['LINHA04'] := 'Inscrição Estadual: '+ LInfoEmpresa.EMP_I_E_S_ ;
    ARelatorio.Script.Variables['LINHA05'] := 'Registro Junta Comercial: '+ LInfoEmpresa.EMP_JUCESP ;
    LMemoCabecalho.Top := 89.078740157 ;
    LLinhaCabecalho.Top := 110.622047244 ;
    LLinhaCabecalho.Visible := False ;
    LMemoObs.Top := 130.15748031 ;
  end
  else
  begin
    LBandaCabecalho.Height := 52.91335 ;
    ARelatorio.Script.Variables['LINHA01'] := '' ;
    ARelatorio.Script.Variables['LINHA02'] := '' ;
    ARelatorio.Script.Variables['LINHA03'] := '' ;
    ARelatorio.Script.Variables['LINHA04'] := '' ;
    ARelatorio.Script.Variables['LINHA05'] := '' ;
    LMemoCabecalho.Top := 5.2677165354 ;
    LLinhaCabecalho.Top := 29.811023622 ;
    LMemoObs.Top := 32.346456693 ;
  end;
end;

procedure pCarregaConfRelRol(const ARelNome: string; const AArrEmpSel: TConsultasArray; var ALivro, APagina: integer);
var
  qryConsulta: TUniQuery ;
  intCnt: integer ;
  strEmpSel: string ;
begin
  strEmpSel := '' ;
  ALivro := 0 ;
  APagina := 0 ;
  for intCnt := Low(AArrEmpSel) to High(AArrEmpSel) do
  begin
    if fEmptyStr(strEmpSel) then
    begin
      strEmpSel := AArrEmpSel[intCnt].strCodigo ;
    end
    else
    begin
      strEmpSel := strEmpSel + '_' + AArrEmpSel[intCnt].strCodigo ;
    end;
  end;

  qryConsulta := fCriaQuery() ;
  try
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(' SELECT ROL_LIVRO_, ROL_PAGINA FROM CNFROL ') ;
    qryConsulta.SQL.Add(' WHERE  ROL_CODEMP = :CODEMP ') ;
    qryConsulta.SQL.Add(' AND ROL_MODULO = :MODULO ') ;
    qryConsulta.ParamByName('CODEMP').AsString := strEmpSel ;
    qryConsulta.ParamByName('MODULO').AsString := ARelNome ;
    qryConsulta.Open ;
    if not qryConsulta.IsEmpty then
    begin
      ALivro := qryConsulta.FieldByName('ROL_LIVRO_').AsInteger ;
      APagina := qryConsulta.FieldByName('ROL_PAGINA').AsInteger ;
    end;
  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

procedure pGravaConfRelRol(const ARelNome: string; const AArrEmpSel: TConsultasArray; const ALivro, APagina: integer);
var
  qryConsulta: TUniQuery ;
  intCnt: integer ;
  strEmpSel: string ;
begin
  strEmpSel := '' ;
  for intCnt := Low(AArrEmpSel) to High(AArrEmpSel) do
  begin
    if fEmptyStr(strEmpSel) then
    begin
      strEmpSel := AArrEmpSel[intCnt].strCodigo ;
    end
    else
    begin
      strEmpSel := strEmpSel + '_' + AArrEmpSel[intCnt].strCodigo ;
    end;
  end;

  fStartTransaction ;
  try
    qryConsulta := fCriaQuery() ;
    try
      qryConsulta.SQL.Clear ;
      qryConsulta.SQL.Add(' SELECT * FROM CNFROL ') ;
      qryConsulta.SQL.Add(' WHERE  ROL_CODEMP = :CODEMP ') ;
      qryConsulta.SQL.Add(' AND ROL_MODULO = :MODULO ') ;
      qryConsulta.ParamByName('CODEMP').AsString := strEmpSel ;
      qryConsulta.ParamByName('MODULO').AsString := ARelNome ;
      qryConsulta.Open ;
      if not qryConsulta.IsEmpty then
      begin
        qryConsulta.Edit ;
      end
      else
      begin
        qryConsulta.Insert ;
        qryConsulta.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CNFROL', VS_strCodEmp) ;
        qryConsulta.FieldByName('ROL_CODEMP').AsString := strEmpSel ;
        qryConsulta.FieldByName('ROL_MODULO').AsString := ARelNome ;
      end;
      qryConsulta.FieldByName('ROL_LIVRO_').AsInteger := ALivro ;
      qryConsulta.FieldByName('ROL_PAGINA').AsInteger := APagina ;
      qryConsulta.Post ;
      fCommit;
    finally
      FreeAndNil(qryConsulta) ;
    end;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  End;
end;

function fCfgNatDsc: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('NATDSC') then
    exit;

  if not fCfgSis('NATDSC', varBoolean) then
    exit;

  result := 'S' ;
end;

function fCfgRpCtRd: string;
begin
  result := 'S' ;
  if not fConfiguracaoExiste('RPCTRD') then
    exit;

  if fCfgSis('RPCTRD', varBoolean) then
    exit;

  result := 'N' ;
end;

function fCfgExcrep: string;
begin
  result := 'S' ;
  if not fConfiguracaoExiste('EXCREP') then
    exit;

  if fCfgSis('EXCREP', varBoolean) then
    exit;

  result := 'N' ;
end;

function fCfgPCDeDt: TObjectList<TDictionary<string,string>>;
var
  LqryConsulta: TUniQuery ;
  LdictItem: TDictionary<string,string> ;
  LintCnt : Integer ;
begin
  result := Nil ;
  if not fConfiguracaoExiste('PCDEDT') then
  begin
    exit;
  end;

  if not fTabelaExiste('CTAJDT') then
  begin
    exit;
  end;

  LintCnt := fCampoTabela('COUNT(*)', 'CTAJDT', ['JDT_CODEMP', 'JDT_TIPREG'], [VS_strCodEmp, COD_TIPOPLANOCONTASCTPDET[pcccDescontos]], False) ;
  if LintCnt = 0 then
  begin
    exit ;
  end;

  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close;
    LqryConsulta.SQL.Clear;
    LqryConsulta.SQL.Add('SELECT JDT_CODCTA, JDT_TPCDPG FROM CTAJDT WHERE JDT_CODEMP = :CODEMP AND JDT_TIPREG = :TIPREG ') ;
    LqryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp ;
    LqryConsulta.ParamByName('TIPREG').AsString := COD_TIPOPLANOCONTASCTPDET[pcccDescontos] ;
    LqryConsulta.Open ;

    result := TObjectList<TDictionary<string,string>>.Create ;
    LqryConsulta.First ;
    while not LqryConsulta.Eof do
    begin
      LdictItem := TDictionary<string,string>.Create();
      LdictItem.Add('JDT_CODCTA', LqryConsulta.FieldByName('JDT_CODCTA').AsString);
      LdictItem.Add('JDT_TPCDPG', LqryConsulta.FieldByName('JDT_TPCDPG').AsString);
      result.Add(LdictItem) ;
      LqryConsulta.Next ;
    end;

  finally
    FreeAndNil(LqryConsulta) ;
  end;
end;

function fCfgPCJuDt: TObjectList<TDictionary<string,string>>;
var
  LqryConsulta: TUniQuery ;
  LdictItem: TDictionary<string,string> ;
  LintCnt: Integer ;
begin
  result := Nil ;
  if not fConfiguracaoExiste('PCJUDT') then
  begin
    exit;
  end;

  if not fTabelaExiste('CTAJDT') then
  begin
    exit;
  end;

  LintCnt := fCampoTabela('COUNT(*)', 'CTAJDT', ['JDT_CODEMP', 'JDT_TIPREG'], [VS_strCodEmp, COD_TIPOPLANOCONTASCTPDET[pcccJuros]], False) ;
  if LintCnt = 0 then
  begin
    exit ;
  end;

  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close;
    LqryConsulta.SQL.Clear;
    LqryConsulta.SQL.Add('SELECT JDT_CODCTA, JDT_TPCDPG FROM CTAJDT WHERE JDT_CODEMP = :CODEMP  AND JDT_TIPREG = :TIPREG ') ;
    LqryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp ;
    LqryConsulta.ParamByName('TIPREG').AsString := COD_TIPOPLANOCONTASCTPDET[pcccJuros] ;
    LqryConsulta.Open ;

    result := TObjectList<TDictionary<string,string>>.Create ;
    LqryConsulta.First ;
    while not LqryConsulta.Eof do
    begin
      LdictItem := TDictionary<string,string>.Create();
      LdictItem.Add('JDT_CODCTA', LqryConsulta.FieldByName('JDT_CODCTA').AsString);
      LdictItem.Add('JDT_TPCDPG', LqryConsulta.FieldByName('JDT_TPCDPG').AsString);
      result.Add(LdictItem) ;
      LqryConsulta.Next ;
    end;

  finally
    FreeAndNil(LqryConsulta) ;
  end;
end;

function fCfgAdtOrd: string;
begin
  result := '' ;
  if not fConfiguracaoExiste('ADTORD') then
    exit;

  result := fCfgSis('ADTORD', varString) ;
end;

function fCfgDesMva: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('DESMVA') then
    exit;

  if not fCfgSis('DESMVA', varBoolean) then
    exit;

  result := 'S' ;
end;

function fCfgCtpVnd: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('CTPVND') then
    exit;

  if not fCfgSis('CTPVND', varBoolean) then
    exit;

  result := 'S' ;
end;

function fCfgCtp_as: string ;
begin
  result := 'A' ;
  if not fConfiguracaoExiste('CTP_AS') then
    exit;

  result := fCfgSis('CTP_AS', varString) ;
end;

function fConsideraCTP_AS_NaGeracaoDoCtp: Boolean;
begin
  Result := True;

  if not fConfiguracaoExiste('CCTPAS') Then
    Exit;

  Result := fCfgSis('CCTPAS', varBoolean);
end;

function fCfgMktPla: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('MKTPLA') then
    exit;

  if not fCfgSis('MKTPLA', varBoolean) then
    exit;

  result := 'S' ;
end;

function fPreparaSqlMarketPlace(const AstrSql: string): string;
var
  LstrSql: string ;
begin
  if fCfgMktPla = 'S' then
  begin
    LstrSql := ' SELECT SEL.*, CASE WHEN IFNULL( A.FGO_NUMPOK, "" ) <> "" AND A.FGO_ESPDOC = "PD" THEN B.FGO_CODORI ELSE CAST(NULL AS CHAR(3)) END AS CODIGO_MARKETPLACE FROM (' ;
    LstrSql := LstrSql + AstrSql ;
    LstrSql := LstrSql + ' ) AS SEL ' ;
    LstrSql := LstrSql + ' LEFT JOIN FATGOR A ON A.FGO_NUMFAT = SEL.NUMDOC AND A.FGO_TIPFAT = SEL.ESPDOC AND A.FGO_EMPFAT = SEL.CODEMP AND A.FGO_CODCLI = SEL.CODIGO_CLIENTE_FORNECEDOR ' ;
    LstrSql := LstrSql + ' LEFT JOIN EXTGOR B ON A.AUTOINCREM = B.FGO_SEQFGO ' ;
    result := LstrSql ;
  end
  else
  begin
    result := AstrSql ;
  end;
end;

function fCfgCtrAgr: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('CTRAGR') then
    exit;

  if not fCfgSis('CTRAGR', varBoolean) then
    exit;

  result := 'S' ;
end ;

function fMontaSqlCTCadFisInterno(const ArecParCon: TParametrosConsulta; const ArecValBan : TValidacoesDeBanco; const AstrVenCom: string; const AblnComplemento, AblnExisteTabelaComplementoCTE: boolean): string ;
var
  LstrAliasCadFis: string ;
  LstrSql: string ;
begin
  if AblnComplemento then
  begin
    LstrAliasCadFis := 'FISCOM.' ;
  end
  else
  begin
    LstrAliasCadFis := 'FISORI.';
  end ;

  LstrSql := LstrSql + ' SELECT ' + LstrAliasCadFis + 'AUTOINCREM AS FISINC, ' + LstrAliasCadFis + 'FIS_NUMDOC, ' + LstrAliasCadFis + 'FIS_CODEMP FROM CADFIS FISORI  ' ;

  if AblnExisteTabelaComplementoCTE then
  begin
    if AblnComplemento then
    begin
      LstrSql := LstrSql + ' JOIN CTECOM ON FISORI.AUTOINCREM = CTECOM.COM_CTEORI ';
      LstrSql := LstrSql + ' JOIN CADFIS FISCOM ON FISCOM.AUTOINCREM = CTECOM.COM_CTECOM ';
    end
    else
    begin
      LstrSql := LstrSql + ' LEFT JOIN CTECOM ON FISORI.AUTOINCREM = CTECOM.COM_CTEORI ';
    end ;
  end ;

  LstrSql := LstrSql + ' WHERE ' ;

  LstrSql := LstrSql + '       FISORI.FIS_ESPDOC = "CT" ' ;

  if (AstrVenCom = CONHECIMENTO_TIPO_COMPRA) then
  begin
    LstrSql := LstrSql + '   AND FISORI.FIS_VENCOM = ' + QuotedStr(AstrVenCom) ;

    if (ArecValBan.FUsaCampoCalMed) then
    begin
      LstrSql := LstrSql + ' AND IFNULL(FISORI.FIS_CALMED,"N") = "S" ' ;
    end ;

  end
  else if (AstrVenCom = CONHECIMENTO_TIPO_VENDA) then
  begin
    if (ArecValBan.FUsaCampoCalMed) then
    begin
      LstrSql := LstrSql + ' AND ((FISORI.FIS_VENCOM = ' + QuotedStr(CONHECIMENTO_TIPO_VENDA) + ') OR (FISORI.FIS_VENCOM = ' + QuotedStr(CONHECIMENTO_TIPO_COMPRA) + ' AND IFNULL(FISORI.FIS_CALMED,"N") = "N"))' ;
    end
    else
    begin
      LstrSql := LstrSql + ' AND FISORI.FIS_VENCOM = ' + QuotedStr(AstrVenCom) ;
    end ;
  end
  else
    raise Exception.Create('Tipo de conhecimento "' + AstrVenCom + '" desconhecido.');

  If Not fEmptyStr(ArecParCon.strCodEmp) Then
  begin
    LstrSql := LstrSql + '  AND ' + LstrAliasCadFis + 'FIS_CODEMP = :CODEMP ' ;
  end ;

  if (ArecParCon.dtaDtaIni > 0) then
  begin
    LstrSql := LstrSql + '    AND ' + LstrAliasCadFis + 'FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ' ;
  end ;

  LstrSql := LstrSql + TTrataIncDocContabil
                        .New
                        .fColunaIncDoc(LstrAliasCadFis + 'AUTOINCREM')
                        .fIncDoc(ArecParCon.strIncDoc)
                        .fArrIncDoc(ArecParCon.arrIncDoc)
                        .fQuerySql(Nil)
                        .fExecute ;

  result := LstrSql ;
end ;

function fCarregaCTCadFis(const ArecParCon: TParametrosConsulta; const ArecValBan : TValidacoesDeBanco; const AstrVenCom: string): TUniClientDataSet ;
var
  LqryConsulta: TUniQuery ;
  LblnExisteTabelaComplementoCTE: boolean ;
  LstrSql: string ;
begin
  LblnExisteTabelaComplementoCTE := fTabelaExiste('CTECOM');

  LstrSql := fMontaSqlCTCadFisInterno(ArecParCon, ArecValBan, AstrVenCom, False, LblnExisteTabelaComplementoCTE) ;
  if LblnExisteTabelaComplementoCTE then
  begin
    LstrSql := LstrSql + ' UNION ';
    LstrSql := LstrSql + fMontaSqlCTCadFisInterno(ArecParCon, ArecValBan, AstrVenCom, True, LblnExisteTabelaComplementoCTE) ;
  end ;

  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(LstrSql) ;

    If Not fEmptyStr(ArecParCon.strCodEmp) Then
    begin
      LqryConsulta.ParamByName('CODEMP').AsString := ArecParCon.strCodEmp ;
    end ;

    if (ArecParCon.dtaDtaIni > 0) then
    begin
      LqryConsulta.ParamByName('DTAINI').AsDateTime := ArecParCon.dtaDtaIni ;
      LqryConsulta.ParamByName('DTAFIN').AsDateTime := ArecParCon.dtaDtaFin ;
    end ;

    If (Not ArecParCon.strIncDoc.IsEmpty) and (Length(ArecParCon.arrIncDoc) = 0) Then
    begin
      LqryConsulta.ParamByName('INCDOC').AsString := ArecParCon.strIncDoc ;
    end ;
    LqryConsulta.Open ;

    result := fCriaClientDatset(LqryConsulta) ;
    result.IndexFieldNames := 'FISINC' ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;

end ;

function fCfgConGru: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('CONGRU') then
    exit;

  if not fCfgSis('CONGRU', varBoolean) then
    exit;

  result := 'S' ;
end ;

function fCfgConEmp: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('CONEMP') then
    exit;

  if not fCfgSis('CONEMP', varBoolean) then
    exit;

  result := 'S' ;
end ;

function fCfgPatCco: string;
begin
  result := 'S' ;
  if not fConfiguracaoExiste('PATCCO') then
    exit;

  if fCfgSis('PATCCO', varBoolean) then
    exit;

  result := 'N' ;
end ;

function fCfgPiCoRf: Boolean;
begin
  Result := False;

  if not fConfiguracaoExiste('PICORF') then
    Exit;

  Result :=  UpperCase(fCfgSis('PICORF', varString)) = 'HABILITADO';
end;

function fCfgHisTpl: Boolean;
begin
  Result := False;

  if not fConfiguracaoExiste('HISTPL') then
    Exit;

  if not fCfgSis('HISTPL', varBoolean) then
    Exit;

  Result := True;
end;

function fRetDescHistoricoPadrao(const AstrCodigo: string; const AstrCodEmp: string = ''): string;
var
  Lqry: TUniQuery ;
  Lintcodigo: Integer;
begin
  Result := '';

  LintCodigo := StrToIntDef(AstrCodigo, -1) ;
  if LintCodigo = -1 then
    Exit;

  Lqry := fCriaQuery(nil);
  try
    Lqry.SQL.Add('SELECT PAD_DESCRI FROM HISPAD WHERE PAD_CODIGO = :CODIGO ');
    Lqry.ParamByName('CODIGO').AsInteger := LintCodigo;
    if fCfgHisTpl then
      Lqry.SQL.Add(' AND PAD_TPLACO = ' + fRetTplacoEmpresaLogada(AstrCodEmp).QuotedString)
    else
      Lqry.SQL.Add(' AND IFNULL(PAD_TPLACO, "") = "" ');
    Lqry.Open;

    if Lqry.RecordCount > 0 then
      Result := Lqry.FieldByName('PAD_DESCRI').AsString;
  finally
    FreeAndNil(Lqry);
  end
end;

function fAlqPisRF: Double;
begin
  Result := 0.00;

  if not fCfgPiCoRf then
    Exit;

  Result := fCampoTabela('PCR_ALQPIS', 'PICORF', ['PCR_CODEMP'], [VS_strCodEmp], False);

  Result := Result / 100;
end;

function fAlqCofinsRF: Double;
begin
  Result := 0.00;

  if not fCfgPiCoRf then
    Exit;

  Result := fCampoTabela('PCR_ALQCOF', 'PICORF', ['PCR_CODEMP'], [VS_strCodEmp], False);

  Result := Result / 100;
end;

function fDesconsiderarProEmbNoSAI: Boolean;
begin
  Result := False;
  if not fConfiguracaoExiste('SPROEM') then
    Exit;

  if not fCfgSis('SPROEM', varBoolean) then
    Exit;

  Result := True;
end;

procedure pSetarFiltroEmpresa(var AqryParam: TUniQuery);
begin
  if fCfgConEmp = 'S' then
  begin
    AqryParam.SQL.Add(' AND PARCON.CON_CODEMP = :CODEMP ') ;
    AqryParam.ParamByName('CODEMP').AsString := VS_strCodEmp ;
  end
  else
  begin
    AqryParam.SQL.Add(' AND PARCON.CON_CODEMP IS NULL ') ;
  end ;
end;

function fCampoTabelaParcon(AstrCampo : String;
                            AarrCampoChave: Array Of String;
                            AarrValorChave: Array Of Variant;
                            AblnSempreLerBanco: Boolean = True;
                            AstrOrderBy: String = '';
                            AConexao: TUniConnection = Nil;
                            AblnUsarMax: Boolean = False): Variant;
Const
  arrParms : Array [0..11] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L');

Var
  LintCont  : Integer;
  LstrSQL   : String;
  LqryGenGer: TUniQuery;
  LstrNomTab: string ;
Begin
  LstrNomTab := 'PARCON' ;

  LqryGenGer := fCriaQuery;
  try
    Try
      LstrSQL := '';
      LstrSQL := LstrSQL + 'SELECT SQL_NO_CACHE ';
      LstrSQL := LstrSQL + '  ' + AstrCampo + ' ';
      LstrSQL := LstrSQL + 'FROM ';
      LstrSQL := LstrSQL + '  ' + LstrNomTab + ' ';
      LstrSQL := LstrSQL + 'WHERE ';

      For LintCont := 0 To Length(AarrCampoChave) -1 Do
      Begin
        If Pos('<>', AarrCampoChave[LintCont]) > 0 Then
          LstrSQL := LstrSQL + '  ' + AarrCampoChave[LintCont] + ' :' + String(arrParms[LintCont]) + ' AND '
        Else
          LstrSQL := LstrSQL + '  ' + AarrCampoChave[LintCont] + ' = :' + String(arrParms[LintCont]) + ' AND ';
      End;

      LstrSQL := LstrSQL + '  TRUE  ';

      if fCfgConEmp = 'S' then
      begin
        LstrSQL := LstrSQL + '  AND CON_CODEMP = ' + VS_strCodEmp.QuotedString ;
      end
      else
      begin
        LstrSQL := LstrSQL + '  AND CON_CODEMP IS NULL ' ;
      end ;

      If Not fEmptyStr(AstrOrderBy) Then
        LstrSQL := LstrSQL + ' ORDER BY ' + AstrOrderBy;

      LstrSQL := LstrSQL + ' LIMIT 1 ';

      With LqryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(LstrSQL);

        For LintCont := 0 To Length(AarrCampoChave) -1 Do
          ParamByName(String(arrParms[LintCont])).Value := AarrValorChave[LintCont];

        If (Not AblnSempreLerBanco) And (dicResultadoQuerySimplesCont[LqryGenGer] <> Null) Then
        Begin
          Result := dicResultadoQuerySimplesCont[LqryGenGer];
        End
        Else
        Begin
          Open;

          Result := Fields[0].Value;

          {*******************************************}
          {* EXECUTA UM CAST PARA NAO RETORNAR NULL  *}
          {****************************************JC*}
          Case Fields[0].DataType Of
            ftString : Result := Fields[0].AsString;
            ftMemo   : Result := Fields[0].AsString;
            ftFloat  : Result := Fields[0].AsFloat;
            ftInteger: Result := Fields[0].AsInteger;
            ftBoolean: Result := Fields[0].AsBoolean;
            ftDate   : Result := Fields[0].AsDateTime;
            ftTime   : Result := Fields[0].AsDateTime;
          End;

          If (Not AblnSempreLerBanco) Then
            dicResultadoQuerySimplesCont[LqryGenGer] := Result;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'fCampoTabela');
      End;
    End;

  finally
    FreeAndNil(LqryGenGer);
  end ;

end;

function fTiposQuePermitemApenasPeriodoDentroDeUmUnicoMes: TTiposQuePermitemApenasPeriodoDentroDeUmUnicoMes;
begin
  Result := ['CMV'];
end ;

function fPermiteApenasPeriodoDentroDeUmUnicoMes(const AdtaDtaIni,
  AdtaDtaFin: TDateTime; const AstrTipo: String): Boolean;
var
  LintMesIni, LintMesFin : integer ;
  LintAnoIni, LintAnoFin : integer ;
begin
  Result := True;

  If Not MatchStr(AstrTipo, fTiposQuePermitemApenasPeriodoDentroDeUmUnicoMes) Then
    Exit;

  LintMesIni := MonthOf(AdtaDtaIni);
  LintAnoIni := YearOf(AdtaDtaIni);

  LintMesFin := MonthOf(AdtaDtaFin);
  LintAnoFin := YearOf(AdtaDtaFin);

  if (LintMesIni <> LintMesFin) or (LintAnoIni <> LintAnoFin) then
  begin
    fMensagem('ATENÇÃO!','Tipo "'+AstrTipo+'" permite apenas período de datas dentro de um único mês!',['&OK']);
    Exit(False);
  end;
end;

function fCreateItemLogDelLanOutEmp(AqryLog: TUniQuery; ATabela, AColuna, AIncDoc: string; ADtaAlt: TDate; AHraAlt: TTime): TLogAjcItem;
begin
  Result := TLogAjcItem.Create;
  Result.CodEmp := VS_strCodEmp;
  Result.CodOpe := strLoginUsuarioLogado;
  Result.DtaAlt := ADtaAlt;
  Result.HraAlt := AHraAlt;
  Result.Tabela := ATabela;
  Result.Incdoc := AIncDoc;
  Result.Tipaju := 'EXC';
  Result.Coluna := AColuna;
  Result.ValAnt := AqryLog.FieldByName(AColuna).AsString;
  Result.ValAtu := '';
  Result.NomFrm := 'fDeletaLacamentosGeradosParaOutraEmpresaExec';
  Result.SeqAju := TLogAjcOpContext.SeqAju;
end;

function fDeletaLacamentosGeradosParaOutraEmpresaExec(const AdtaDtaIni,
                                                               AdtaDtaFin: TDateTime;
                                                         const AstrCodEmp,
                                                               AstrIncDoc: String;
                                                               AarrIncDoc: TArrIncDoc;
                                                               AprocExecProgresso: TSetaTextoProgresso;
                                                               ApgbProgresso: TcxProgressBar;
                                                         const AfltValor: double = 0.00;
                                                         const AstrCodOpe: string = '';
                                                         const AstrConDeb: string = '';
                                                         const AstrConCre: string = '';
                                                         const AstrTipLan: String = 'CTR'): boolean;
Var
  LqryDel : TUniQuery;
  LintControle1, LintControle2: Largeint ;
  LqryExec: TUniQuery;
  LintRecCount: integer ;
  LintRecNo: integer ;
  LlstOrigem: TStringList ;
  LintCnt: integer ;
  LstrSqlModelo, LstrSql: String ;
  LblnCTR_DTABAN_Existe: Boolean ;
begin
  LblnCTR_DTABAN_Existe := fCampoExiste('CADREC', 'CTR_DTABAN') ;

  LqryDel := fCriaQuery(nil);
  LqryExec := fCriaQuery(nil);
  LlstOrigem := TStringList.Create ;
  Try
    LlstOrigem.Sorted := True ;

    pTrataSQLEstornoMovimentoContabil(LqryDel,
                                      AdtaDtaIni,
                                      AdtaDtaFin,
                                      AstrCodEmp,
                                      AstrIncDoc,
                                      AarrIncDoc,
                                      AfltValor,
                                      AstrCodOpe,
                                      AstrConDeb,
                                      AstrConCre,
                                      AstrTipLan) ;

    LstrSqlModelo := LqryDel.SQL.Text ;
    if AstrTipLan = 'CTR' then
    begin
      LstrSql := '(' ;
      LstrSql := LstrSql + AnsiReplaceStr(LstrSqlModelo,
                                          'INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM',
                                          'LEFT JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM') ;
      LstrSql := LstrSql + ' AND CADREC.AUTOINCREM IS NULL ' ;
      LstrSql := LstrSql + ' ) ' ;
      LstrSql := LstrSql + ' UNION ALL ' ;
      if not LblnCTR_DTABAN_Existe then
      begin
        LstrSql := LstrSql + '(' ;
        LstrSql := LstrSql + AnsiReplaceStr(LstrSqlModelo,
                                          'AND LANCON.CON_DTALAN BETWEEN',
                                          'AND CADREC.CTR_DTAREC BETWEEN') ;
        LstrSql := LstrSql + ' ) ' ;
      end
      else
      begin
        LstrSql := LstrSql + '(' ;
        LstrSql := LstrSql + AnsiReplaceStr(LstrSqlModelo,
                                          'AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ',
                                          'AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN AND CADREC.CTR_DTABAN IS NULL ') ;
        LstrSql := LstrSql + ' ) ' ;
        LstrSql := LstrSql + ' UNION ALL ' ;
        LstrSql := LstrSql + '(' ;
        LstrSql := LstrSql + AnsiReplaceStr(LstrSqlModelo,
                                          'AND LANCON.CON_DTALAN BETWEEN',
                                          'AND CADREC.CTR_DTABAN BETWEEN') ;
        LstrSql := LstrSql + ' ) ' ;
      end ;
      LstrSql := LstrSql + ' UNION ALL ' ;
      LstrSql := LstrSql + '(' ;
      LstrSql := LstrSql + LstrSqlModelo;
      LstrSql := LstrSql + ' AND CADREC.CTR_DTAREC IS NULL ';
      LstrSql := LstrSql + ' ) ' ;

      LqryDel.SQL.Text := LstrSql ;
    end ;

    LqryDel.Open ;
    LqryDel.First ;

    AprocExecProgresso(ApgbProgresso, 'Deletando lançamentos:'+ifThen(fEmptyStr(AstrTipLan), '', ' "'+AstrTipLan+'" ')+'(Empresa do Cadastro <> Empresa da Baixa)');

    LintRecCount := LqryDel.RecordCount ;
    ApgbProgresso.Properties.Max := LintRecCount ;
    LintRecNo := 0 ;
    LqryDel.First;
    While Not LqryDel.Eof Do
    Begin
      inc(LintRecNo) ;
      ApgbProgresso.Position := LintRecNo;
      AprocExecProgresso(ApgbProgresso, 'Deletando lançamentos:'+ifThen(fEmptyStr(AstrTipLan), '', ' "'+AstrTipLan+'" ')+'(Empresa do Cadastro <> Empresa da Baixa): ' + IntToStr(LintRecNo) + ' / ' + IntToStr(LintRecCount));

      LintControle1 := LqryDel.FieldByName('CNT_ORIGEM').AsLargeInt ;
      LintControle2 := LqryDel.FieldByName('CNT_CONTRO').AsLargeInt ;
      ///apaga o controle
      LqryExec.Close;
      LqryExec.SQL.Clear;
      LqryExec.SQL.Add(' DELETE FROM LANCNT WHERE CNT_ORIGEM = :ORIGEM AND CNT_CONTRO = :CONTRO ; ');
      LqryExec.ParamByName('ORIGEM').AsLargeInt := LintControle1 ;
      LqryExec.ParamByName('CONTRO').AsLargeInt := LintControle2 ;
      LqryExec.ExecSQL ;
      //apaga os lançamentos na lancon
      LqryExec.Close;
      LqryExec.SQL.Clear;
      LqryExec.SQL.Add(' DELETE FROM LANCON WHERE AUTOINCREM = :INC2 ; ');
      LqryExec.ParamByName('INC2').AsLargeInt := LintControle2 ;
      LqryExec.ExecSQL ;

      if LlstOrigem.IndexOf(intTostr(LintControle1)) = -1 then
      begin
        LlstOrigem.add(intTostr(LintControle1)) ;
      end ;

      LqryDel.Next ;
    end;

    //caso precise apagar o original
    for LintCnt := 0 to LlstOrigem.Count-1 do
    begin
      LqryExec.Close;
      LqryExec.SQL.Clear;
      LqryExec.SQL.Add(' DELETE FROM LANCON WHERE AUTOINCREM = :INC2 ; ');
      LqryExec.ParamByName('INC2').AsLargeInt := strtoint64(LlstOrigem[LintCnt]) ;
      LqryExec.ExecSQL ;
    end ;

    AprocExecProgresso(ApgbProgresso, '');

  Finally
    FreeAndNil(LqryDel);
    FreeAndNil(LqryExec);
    FreeAndNil(LlstOrigem);
  End;

  result := True ;
end;

function fConsiderarPrevisoesDeContasAPagar: string;
begin
  result := 'S' ;
  if not fConfiguracaoExiste('PRECTP') then
    exit;

  if fCfgSis('PRECTP', varBoolean) then
    exit;

  result := 'N' ;
end;

procedure pSetaTextoProgresso(ApgbProgresso: TcxProgressBar; AstrTexto: String);
begin
  If Assigned(ApgbProgresso) And (GetParentForm(ApgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(ApgbProgresso).FindComponent('lblGravando')).Caption := AstrTexto;
    Application.ProcessMessages;
  End;
end;

function fValidarPlanoContasSomenteExportacaoExec(ApgbProgresso: TcxProgressBar; const AprocErros: TErroContabilProc):boolean ;
var
  LintCnt, LintTot: integer ;
  LqryPlanoContas: TUniQuery ;
  LstrTpLaCo: String ;
  LlstValidacao: TList<TDadosValidacaoContaContabil> ;
  LregItem: TDadosValidacaoContaContabil;
begin
  LstrTpLaCo := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]) ;
  LqryPlanoContas := fCriaQuery() ;
  LlstValidacao := TList<TDadosValidacaoContaContabil>.Create();
  try
    LqryPlanoContas.Close ;
    LqryPlanoContas.SQL.Clear ;
    LqryPlanoContas.SQL.Add(' SELECT NCO_CODCON, NCO_TPLACO, NCO_DTAINI, NCO_DTAFIN, AUTOINCREM, NCO_APURAC, NCO_CTAREF, NCO_DESCRI, NCO_NATURE, NCO_FINALI, NCO_REDUTO, NCO_NATAJU, NCO_AJULIQ, NCO_PATRIM, NCO_CONRED FROM PLANCO ') ;
    LqryPlanoContas.SQL.Add(' WHERE NCO_TPLACO = :TPLACO ') ;
    LqryPlanoContas.SQL.Add(' ORDER BY NCO_CODCON ') ;
    LqryPlanoContas.ParamByName('TPLACO').AsString := LstrTpLaCo ;
    LqryPlanoContas.Open ;
    LqryPlanoContas.First ;


    pSetaTextoProgresso(ApgbProgresso, 'Validando Plano de Contas');
    LintTot := LqryPlanoContas.RecordCount ;
    ApgbProgresso.Properties.Max := LintTot ;
    LintCnt := 0 ;
    while not LqryPlanoContas.eof do
    begin
      Inc(LintCnt) ;
      ApgbProgresso.Position := LintCnt ;
      pSetaTextoProgresso(ApgbProgresso, 'Validando Plano de Contas: ' + IntToStr(LintCnt) + '/' + IntToStr(LintTot));
      FillChar(LregItem, sizeOf(LregItem), #0);
      LregItem.AContaContabil := LqryPlanoContas.FieldByName('NCO_CODCON').AsString ;
      LregItem.ATpLaco := LqryPlanoContas.FieldByName('NCO_TPLACO').AsString ;
      LregItem.AInicio := LqryPlanoContas.FieldByName('NCO_DTAINI').AsDateTime ;
      LregItem.AFinal := LqryPlanoContas.FieldByName('NCO_DTAFIN').AsDateTime ;
      LregItem.AAutoInc := LqryPlanoContas.FieldByName('AUTOINCREM').AsString ;
      LregItem.AApurac := LqryPlanoContas.FieldByName('NCO_APURAC').AsString ;
      LregItem.AContaRef := LqryPlanoContas.FieldByName('NCO_CTAREF').AsString ;
      LregItem.ADescricaoConta := LqryPlanoContas.FieldByName('NCO_DESCRI').AsString ;
      LregItem.ANatureza := LqryPlanoContas.FieldByName('NCO_NATURE').AsString ;
      LregItem.AFinalidade := LqryPlanoContas.FieldByName('NCO_FINALI').AsString ;
      LregItem.ARedutora := LqryPlanoContas.FieldByName('NCO_REDUTO').AsString ;
      LregItem.ANatAju := LqryPlanoContas.FieldByName('NCO_NATAJU').AsString ;
      LregItem.AAjuLiq := LqryPlanoContas.FieldByName('NCO_AJULIQ').AsString ;
      LregItem.APatrimonial := LqryPlanoContas.FieldByName('NCO_PATRIM').AsString ;
      LregItem.AContaReduzida := LqryPlanoContas.FieldByName('NCO_CONRED').AsString ;
      LlstValidacao.Add(LregItem) ;
      LqryPlanoContas.Next ;
    end ;
    pSetaTextoProgresso(ApgbProgresso, 'Aguarde, Finalizando Validação...');
    result := TValidaProcessoContaContabil.fValidaPlanoContasBloco(LlstValidacao, AprocErros, 'N') ;
    if not result then
    begin
      pSetaTextoProgresso(ApgbProgresso, 'Processo Cancelado!');
      Sleep(1000) ;
    end ;
  finally
    FreeAndNil(LqryPlanoContas) ;
    FreeAndNil(LlstValidacao) ;
  end ;
end ;

function fRetornaOrigemImpMovimento(const AdicDados: TDadosImportacaoContabil): String ;
begin
  Result := '' ;

  if AdicDados.blnParametrizouCredito then
    if fEmptyStr(AdicDados.strContaCredito) then
      Result := AdicDados.strOrigemCredito ;

  if AdicDados.blnParametrizouDebito then
    if fEmptyStr(AdicDados.strContaDebito) then
      Result := AdicDados.strOrigemDebito ;

end ;

procedure pSomaDebitoCreditoImpMovimento(const AstrChave: String;
                                         const AListaLanCon: TObjectList<TDadosImportacaoContabil>;
                                         var AfltCredito, AfltDebito: Double) ;
var
  LdicDados: TDadosImportacaoContabil;
begin
  AfltDebito := 0;
  AfltCredito := 0;
  for LdicDados in AListaLanCon do
  begin
    if (AstrChave = LdicDados.strCtpInc) then
    begin
      if not fEmptyStr(LdicDados.strContaCredito) then
        AfltCredito := AfltCredito + abs(LdicDados.fltValorLancamento);
      if not fEmptyStr(LdicDados.strContaDebito) then
        AfltDebito := AfltDebito + abs(LdicDados.fltValorLancamento);
    end;
  end;
end ;

function fEstaNaListaControleDiferencaDebitoCredito(
  const AstrChave: string; var AlstControleDiferencaDebitoCredito: TStringList): Boolean;
begin
  Result := True ;
  if AlstControleDiferencaDebitoCredito.IndexOf(AstrChave) = -1 then
    AlstControleDiferencaDebitoCredito.Add(AstrChave)
  else
    Exit ;

  Result := False ;
end;

function fCfgContabilizaContraPartidaAgrEmpresa: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('DESMSI') then
    exit;

  if not fCfgSis('DESMSI', varBoolean) then
    exit;

  result := 'S' ;
end ;

function fRetornaChaveDesmembramentoValores(const AobjDados: TDadosImportacaoContabil; const AstrCreDeb: String): String ;
begin
  Result := AobjDados.strCtpInc + '|' +
            AobjDados.strDescricaoValor + '|' +
            AobjDados.strFormaPagamento + '|' +
            AobjDados.strPagamento + '|' +
            AobjDados.strCfopConfig + '|' +
            AobjDados.strNaturezaOperacao + '|' +
            fRetornaCodEmpDesmembramentoValores(AobjDados) + '|' +
            AstrCreDeb ;
end ;

function fRetornaCodEmpDesmembramentoValores(const AobjDados: TDadosImportacaoContabil): String ;
begin
  if (Assigned(AobjDados.empresaCtpDet)) and (fCfgDesMva = 'S') then
    Result := AobjDados.empresaCtpDet.strCodigo
  else if Assigned(AobjDados.empresa) then
    Result := AobjDados.empresa.strCodigo
  else if (not fEmptyStr(AobjDados.strCodigoEmpDesmem)) and (fCfgDesMva = 'S') then
    Result := AobjDados.strCodigoEmpDesmem
  else
    Result := AobjDados.strCodigoEmpresa ;
end ;

procedure pRetornaLstPlanoContasDesmembramentoValores(
  const AListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>;
  var AlstListaSemPlanoContas: TStringList;
  var AlstInfoSemPlanoContas: TObjectList<TInfoContraPartidaAgrupadaNoDesmembramentoValores>) ;
var
  Ldados: TDadosImportacaoContabil;
  LstrChave: String ;
  LobjInfoContraPartida: TInfoContraPartidaAgrupadaNoDesmembramentoValores ;
begin
  for Ldados in AListaDadosImportacaoContabil do
  begin
    if Ldados.blnIsCtpDet then
    begin
      if Ldados.blnParametrizouCredito then
      begin
        LstrChave := fRetornaChaveDesmembramentoValores(Ldados, 'C') ;
        if (Pos(DES_PLANO_DE_CONTAS, Ldados.strOrigemCredito) <= 0) and (AlstListaSemPlanoContas.IndexOf(LstrChave) = -1) then
        begin
          LobjInfoContraPartida := TInfoContraPartidaAgrupadaNoDesmembramentoValores.Create ;
          LobjInfoContraPartida.RefDadosImportacaoContabil := Nil ;
          AlstInfoSemPlanoContas.Add(LobjInfoContraPartida) ;

          AlstListaSemPlanoContas.AddObject(LstrChave, LobjInfoContraPartida) ;
        end ;
      end ;

      if Ldados.blnParametrizouDebito then
      begin
        LstrChave := fRetornaChaveDesmembramentoValores(Ldados, 'D') ;
        if (Pos(DES_PLANO_DE_CONTAS, Ldados.strOrigemDebito) <= 0) and (AlstListaSemPlanoContas.IndexOf(LstrChave) = -1) then
        begin
          LobjInfoContraPartida := TInfoContraPartidaAgrupadaNoDesmembramentoValores.Create ;
          LobjInfoContraPartida.RefDadosImportacaoContabil := Nil ;
          AlstInfoSemPlanoContas.Add(LobjInfoContraPartida) ;

          AlstListaSemPlanoContas.AddObject(LstrChave, LobjInfoContraPartida) ;
        end ;
      end ;
    end ;
  end ;
end ;

procedure pAdicionaLstRemocaoDesmembramentoValores(const AobjDados: TDadosImportacaoContabil;
                                                   const AblnFlagPartidaDupla: Boolean;
                                                   var   ADelListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>) ;
begin
  if not AblnFlagPartidaDupla then
    ADelListaDadosImportacaoContabil.Add(AobjDados) ;
end ;

procedure pContraPartidaAgrupadaNoDesmembramentoValores(
  var AListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>) ;
var
  LAuxListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>;
  LDelListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>;
  LauxDados: TDadosImportacaoContabil;
  Ldados: TDadosImportacaoContabil;
  LlstListaSemPlanoContas: TStringList;
  LstrChave: String;
  LintIndexLst: Integer ;
  LblnFlagPartidaDupla: Boolean ;
  LblnCreditoTemPlanoContas: Boolean;
  LblnDebitoTemPlanoContas: Boolean;
  LlstInfoSemPlanoContas: TObjectList<TInfoContraPartidaAgrupadaNoDesmembramentoValores>;
  LobjInfoContraPartida: TInfoContraPartidaAgrupadaNoDesmembramentoValores ;
begin
  if fCfgContabilizaContraPartidaAgrEmpresa = 'N' then
    exit ;

  LlstListaSemPlanoContas := TStringList.Create ;
  ///usado para desalocar os objetos da memoria
  LlstInfoSemPlanoContas := TObjectList<TInfoContraPartidaAgrupadaNoDesmembramentoValores>.Create;
  LAuxListaDadosImportacaoContabil := TObjectList<TDadosImportacaoContabil>.Create(False);
  LDelListaDadosImportacaoContabil := TObjectList<TDadosImportacaoContabil>.Create(False);
  try
    LlstListaSemPlanoContas.Sorted := True ;
    //analisa a lista e verifica se há contabilização por plano de contas e separa os autoincrem em uma lista para fazer o agrupamento
    pRetornaLstPlanoContasDesmembramentoValores(AListaDadosImportacaoContabil, LlstListaSemPlanoContas, LlstInfoSemPlanoContas) ;

    //acerta os lançamentos com plano de contas e cria a contrapartida
    for Ldados in AListaDadosImportacaoContabil do
    begin
      if (Ldados.blnIsCtpDet) and (not Ldados.blnLancamentoDuploEmpDif) then
      begin
        //verifica se crédito e débito têm origem no plano de contas
        LstrChave := fRetornaChaveDesmembramentoValores(Ldados, 'C') ;
        LblnCreditoTemPlanoContas := Ldados.blnParametrizouCredito and (LlstListaSemPlanoContas.IndexOf(LstrChave) = -1);

        LstrChave := fRetornaChaveDesmembramentoValores(Ldados, 'D') ;
        LblnDebitoTemPlanoContas := Ldados.blnParametrizouDebito and (LlstListaSemPlanoContas.IndexOf(LstrChave) = -1);

        //se nem crédito nem débito tiverem origem no plano de contas, o registro não deve ser tratado por esta rotina
        if (not LblnCreditoTemPlanoContas) and (not LblnDebitoTemPlanoContas) then
          Continue;

        ///partida dupla
        LblnFlagPartidaDupla := Ldados.blnParametrizouCredito and Ldados.blnParametrizouDebito ;

        if Ldados.blnParametrizouCredito then
        begin
          LstrChave := fRetornaChaveDesmembramentoValores(Ldados, 'C') ;
          ///trata o crédito
          LintIndexLst := LlstListaSemPlanoContas.IndexOf(LstrChave) ;
          if LintIndexLst <> -1 then
          begin
            LobjInfoContraPartida := TInfoContraPartidaAgrupadaNoDesmembramentoValores(LlstListaSemPlanoContas.Objects[LintIndexLst]) ;
            if not Assigned(LobjInfoContraPartida.RefDadosImportacaoContabil) then
            begin
              /// clona o obj da importação contabil
              LauxDados := TDadosImportacaoContabil(Ldados.Clone) ;
              /// torna partida simples
              LauxDados.strContaDebito := '' ;
              LauxDados.blnParametrizouDebito := False ;
              LauxDados.strOrigemDebito := '' ;
              LauxDados.strCodigoContabilizavelDebito := '' ;
              LauxDados.strCCusto := '' ;

              LobjInfoContraPartida.RefDadosImportacaoContabil := LauxDados ;
              LAuxListaDadosImportacaoContabil.Add(LauxDados) ;
            end
            else
            begin
              /// acumula o valor da contrapartida
              LauxDados := LobjInfoContraPartida.RefDadosImportacaoContabil ;
              LauxDados.fltValorLancamento := LauxDados.fltValorLancamento + Ldados.fltValorLancamento ;
              ///
            end ;
            /// se for pardida simples será removido da lista principal
            pAdicionaLstRemocaoDesmembramentoValores(Ldados, LblnFlagPartidaDupla, LDelListaDadosImportacaoContabil) ;
            /// torna partida simples
            Ldados.strContaCredito := '' ;
            Ldados.blnParametrizouCredito := False ;
            Ldados.strOrigemCredito := '' ;
            Ldados.strCodigoContabilizavelCredito := '' ;
            Ldados.strCCustoCredito := '' ;
          end ;
        end ;

        ///trata o débito
        if Ldados.blnParametrizouDebito then
        begin
          LstrChave := fRetornaChaveDesmembramentoValores(Ldados, 'D') ;
          LintIndexLst := LlstListaSemPlanoContas.IndexOf(LstrChave) ;
          if LintIndexLst <> -1 then
          begin
            LobjInfoContraPartida := TInfoContraPartidaAgrupadaNoDesmembramentoValores(LlstListaSemPlanoContas.Objects[LintIndexLst]) ;
            if not Assigned(LobjInfoContraPartida.RefDadosImportacaoContabil) then
            begin
              /// clona o obj da importação contabil
              LauxDados := TDadosImportacaoContabil(Ldados.Clone) ;
              /// torna partida simples
              LauxDados.strContaCredito := '' ;
              LauxDados.blnParametrizouCredito := False ;
              LauxDados.strOrigemCredito := '' ;
              LauxDados.strCodigoContabilizavelCredito := '' ;
              LauxDados.strCCustoCredito := '' ;

              LobjInfoContraPartida.RefDadosImportacaoContabil := LauxDados ;
              LAuxListaDadosImportacaoContabil.Add(LauxDados) ;
            end
            else
            begin
              /// acumula o valor da contrapartida
              LauxDados := LobjInfoContraPartida.RefDadosImportacaoContabil ;
              LauxDados.fltValorLancamento := LauxDados.fltValorLancamento + Ldados.fltValorLancamento ;
              ///
            end ;
            /// se for pardida simples será removido da lista principal
            pAdicionaLstRemocaoDesmembramentoValores(Ldados, LblnFlagPartidaDupla, LDelListaDadosImportacaoContabil) ;

            ////torna partida simples
            Ldados.strContaDebito := '' ;
            Ldados.blnParametrizouDebito := False ;
            Ldados.strOrigemDebito := '' ;
            Ldados.strCodigoContabilizavelDebito := '' ;
            Ldados.strCCusto := '' ;
          end ;
        end ;
      end ;
    end ;

    //adiociona os novos itens na lista principal
    for LauxDados in LAuxListaDadosImportacaoContabil do
    begin
      AListaDadosImportacaoContabil.Add(LauxDados) ;
    end ;

    //remove da lista principal
    for LauxDados in LDelListaDadosImportacaoContabil do
    begin
      AListaDadosImportacaoContabil.Remove(LauxDados) ;
    end ;

  finally
    FreeAndNil(LlstListaSemPlanoContas) ;
    FreeAndNil(LlstInfoSemPlanoContas) ;
    FreeAndNil(LAuxListaDadosImportacaoContabil) ;
    FreeAndNil(LDelListaDadosImportacaoContabil) ;
  end ;

end ;

function fCfgRetornaContaContabilEmpresasDiferentesCTP: string;
begin
  result := '' ;
  if not fConfiguracaoExiste('CCECTP') then
    exit;

  if fEmptyStr(fCfgSis('CCECTP', varString)) then
    exit;

  result := fCfgSis('CCECTP', varString) ;
end ;

function fEfetuarLancamentoDuploEmpresasDiferentesCTP(const AstrCodEmpCad, AstrCodEmpBai: String; const AstrTipLan: String; const AblnContabilizarPelaEmpBai: Boolean): boolean;
begin
  Result := False;

  if not AblnContabilizarPelaEmpBai then
    Exit ;

  if fEmptyStr(fCfgRetornaContaContabilEmpresasDiferentesCTP) then
    Exit;

  if (AstrTipLan <> 'CTP') then
    Exit;

  if fEmptyStr(AstrCodEmpCad) then
    Exit;

  if fEmptyStr(AstrCodEmpBai) then
    Exit;

  Result := (AstrCodEmpCad <> AstrCodEmpBai);
end;

procedure pCarregaDadosNCO(const AstrTabela, AstrCampoChave, AstrValorChave: String; var AcdsDados: TUniClientDataSet) ;
var
  LqryDados: TUniQuery ;
  LstrMascara: String ;
begin
  LstrMascara := fMskCon;

  LqryDados := fCriaQuery(Nil);
  try
    AcdsDados.EmptyDataSet;

    LqryDados.Close;
    LqryDados.SQL.Clear;
    LqryDados.SQL.Add(' SELECT * FROM ' + AstrTabela + ' WHERE ' + AstrCampoChave + ' = ' + QuotedStr(AstrValorChave));
    LqryDados.Open;

    LqryDados.First;
    while not LqryDados.Eof do
    begin
      AcdsDados.Insert;
      AcdsDados.FieldByName('CODEMP').AsString := LqryDados.FieldByName('NCO_CODEMP').AsString;
      AcdsDados.FieldByName('CODCON').AsString := LqryDados.FieldByName('NCO_CODCON').AsString;
      AcdsDados.FieldByName('CONMSK').AsString := FormatMaskText(LstrMascara, LqryDados.FieldByName('NCO_CODCON').AsString);
      AcdsDados.Post;

      LqryDados.Next;
    end;
  finally
    FreeAndNil(LqryDados);
  end;
end ;

function fSalvaDadosNCO(const AstrTabela, AstrCampoChave, AstrValorChave: String; const AcdsDados: TUniClientDataSet): Boolean ;
var
  LqryDados: TUniQuery ;
  LblnEmTransacao: Boolean ;
begin
  result := False ;
  LblnEmTransacao := fInTransaction ;
  LqryDados := fCriaQueryContabilidade(AstrTabela, 'fSalvaDadosNCO');
  try
    if not LblnEmTransacao then
      fStartTransaction;
    try
      LqryDados.Close;
      LqryDados.SQL.Clear;
      LqryDados.SQL.Add('SELECT * FROM ' + AstrTabela + ' WHERE ' + AstrCampoChave + ' = ' + QuotedStr(AstrValorChave));
      LqryDados.Open;
      LqryDados.First;
      while not LqryDados.Eof do
      begin
        LqryDados.Delete;
      end;

      LqryDados.Close;
      LqryDados.SQL.Clear;
      LqryDados.SQL.Add('SELECT * FROM ' + AstrTabela + ' WHERE FALSE ');
      LqryDados.Open;

      AcdsDados.First;
      while not AcdsDados.Eof do
      begin
        LqryDados.Insert;
        LqryDados.FieldByName('NCO_CODEMP').AsString := AcdsDados.FieldByName('CODEMP').AsString;
        LqryDados.FieldByName('NCO_CODCON').AsString := AcdsDados.FieldByName('CODCON').AsString;
        LqryDados.FieldByName(AstrCampoChave).AsString := AstrValorChave;
        LqryDados.Post;

        AcdsDados.Next;
      end;

      if not LblnEmTransacao then
        fCommit;
      Result := True ;
    except
      on E: Exception do
      begin
        if not LblnEmTransacao then
          fRollBack;
        pMensagensErro(E.Message, '[fSalvaDadosNCO]');
      end;
    end;
  finally
    FreeAndNil(LqryDados);
  end;

end ;

function fCriaEstruturaCdsNCO(AOwner: TComponent): TUniClientDataSet ;
begin
  Result := Nil ;

  if not fCfgSis('UTICON', varBoolean) then
    Exit ;

  Result := TUniClientDataSet.Create(AOwner);
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Required := False;
    Size := 3;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCON';
    DataType := ftString;
    Required := False;
    Size := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONMSK';
    DataType := ftString;
    Required := False;
    Size := 100;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CREDEB';
    DataType := ftString;
    Required := False;
    Size := 1;
  End;
  Result.CreateDataSet;
  Result.IndexFieldNames := 'CODEMP;CODCON';
end ;

procedure pCarregaPlanoDeContasPorEmpresa(const AstrTabela, AstrValorChave: String; var AcdsNCO: TUniClientDataSet);
begin

  if Assigned(VC_CarregaPlanoDeContasPorEmpresaInterno) then
    VC_CarregaPlanoDeContasPorEmpresaInterno(AstrTabela, AstrValorChave, AcdsNCO) ;

end ;

procedure pSalvaPlanoDeContasPorEmpresa(const AstrTabela, AstrValorChave: String; const AcdsNCO: TUniClientDataSet);
begin

  if Assigned(VC_SalvaPlanoDeContasPorEmpresaInterno) then
    VC_SalvaPlanoDeContasPorEmpresaInterno(AstrTabela, AstrValorChave, AcdsNCO) ;

end ;

function fValidaPlanoDeContasObrigatoria(const ABlnExpAutSi: Boolean; const AStrPlanoContas: String; const AcdsPlanoContas: TUniClientDataSet): Boolean ;
begin
  Result := True ;

  if not fCfgSis('UTICON', varBoolean) then
    Exit ;

  if not Assigned(AcdsPlanoContas) then
    Exit ;

  if not ABlnExpAutSi then
    Exit ;

  Result := False ;

  if (fTiraCaracEspeciais(AStrPlanoContas) = '') and (AcdsPlanoContas.IsEmpty) then
  begin
    fMensagem('ATENÇÃO!', 'Plano contábil não informado!', ['&Ok']);
    Exit ;
  end ;

  Result := True ;
end ;

function fCfgApresentarCfop949TransSaiConfEstCont: string;
begin
  result := 'S' ;
  if fConfiguracaoExiste('TRFCEC') then
  begin
    result := fCfgSis('TRFCEC') ;
  end;
end;

function fCfgDescCreditoDinheiroMesmoSeqCon: String;
begin
  result := 'N' ;
  if fConfiguracaoExiste('CRECTR') then
  begin
    result := fCfgSis('CRECTR') ;
  end;
end ;

function fCfgDesmembrarSubContaCliFor: String;
begin
  result := 'N' ;
  if fConfiguracaoExiste('SUBCNT') then
  begin
    result := fCfgSis('SUBCNT') ;
  end;
end ;

function fCentroCustoDefaultCntDespRecCus: string;
begin
  result := '' ;
  if fConfiguracaoExiste('EVESAI') then
  begin
    result := trim(fCfgSis('EVESAI')) ;
  end;
end ;

function fAjustaCentroCustoCntDespRecCus(const AstrCentroCusto: String; const AstrCentroCustoDefault: String): string;
var
  LstrCentroCusto: String ;
begin
  result := AstrCentroCusto ;
  if not fEmptyStr(AstrCentroCusto) then
    Exit ;

  LstrCentroCusto := AstrCentroCustoDefault ;
  if fEmptyStr(LstrCentroCusto) then
    Exit ;

  result := LstrCentroCusto ;

end ;

function fRetornaCliFor(const AedtClifor: TEditFocus): String;
begin
  result := '' ;
  if not AedtClifor.Visible then
    exit ;

  result := AedtClifor.Text ;
end ;

function fRetornaTipoFC(const AedtTipoFC: TEditFocus): String;
begin
  result := '' ;
  if not AedtTipoFC.Visible then
    exit ;

  result := AedtTipoFC.Text ;
end ;

function fCarregaCliForBD(const AstrCodigo,
  AstrTipo: String): String;
begin
  Result := '' ;
  if fEmptyStr(AstrTipo) then
    Exit ;

  if AstrTipo = 'C' then
    Result := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [AstrCodigo])
  else // fornecedor
    Result := fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR'], [AstrCodigo]) ;
end;

function fRetornaVersaoAutcomLogAceCont(const AstrCampo: String): String;
 Var
  LstrFileAge: String;
  LdtaFileAge: TDateTime;
  LstrPathExe: String;
  LstrExeName: String;
  LqryLog : TUniQuery;
  LstrChave : String;
  LBase64: TBase64Encoding;
begin
  FileAge(Application.ExeName, LdtaFileAge);
  LstrFileAge := FormatDateTime('yyyy-MM-dd hh:mm:ss', LdtaFileAge);

  LstrPathExe := ExtractFilePath(Application.ExeName);
  LstrExeName := ExtractFileName(Application.ExeName);

  LBase64 := TBase64Encoding.Create(0);
  try
    LstrChave := LBase64.Encode(DateTimeToStr(LdtaFileAge) + LstrPathExe + LstrExeName + AstrCampo) ;
  finally
    FreeAndNil(LBase64) ;
  end ;

  if not dicVersaoAutcomCont.ContainsKey(LstrChave) then
  begin

    if not fTabelaExiste('LOGACE') then
    begin
      Result := '';
      dicVersaoAutcomCont.Add(LstrChave, Result);
      Exit ;
    end ;

    LqryLog := fCriaQuery();
    Try
      LqryLog.SQL.Clear;
      LqryLog.SQL.Add(' SELECT ' + AstrCampo);
      LqryLog.SQL.Add(' FROM ');
      LqryLog.SQL.Add('   LOGACE ');
      LqryLog.SQL.Add(' WHERE LOG_DTAENT = :DTAENT ');
      LqryLog.SQL.Add('   AND LOG_DTAEXE = :DTAEXE ');
      LqryLog.SQL.Add('   AND LOG_NOMEXE = :NOMEXE ');
      LqryLog.SQL.Add('   AND REPLACE(LOG_PATEXE, CHAR(92), "*") = :PATEXE ');
      LqryLog.SQL.Add(' LIMIT 1 ');

      LqryLog.ParamByName('DTAENT').AsDateTime := Date();
      LqryLog.ParamByName('DTAEXE').AsString := LstrFileAge;
      LqryLog.ParamByName('NOMEXE').AsString   := LstrExeName;
      LqryLog.ParamByName('PATEXE').AsString   := LstrPathExe.Replace('\', '*');

      LqryLog.Open;
      Result := LqryLog.FieldByName(AstrCampo).AsString;

      dicVersaoAutcomCont.Add(LstrChave, Result);
    Finally
      FreeAndNil(LqryLog);
    End;
  end
  else
  begin
    Result := dicVersaoAutcomCont.Items[LstrChave] ;
  end ;
end ;

function fRetornaVersaoCont(const blnValidarCampoVersao : Boolean = False): String ;
{$I rev.inc}
var
  LstrVersaoArquivo, LstrVersaoProduto: String ;
  LstrVersao, LstrBuild : String ;
  LArrVersaoArquivo : TArray<String>;
  LArrVersaoProduto : TArray<String>;
  LCount : Integer;
  LRevision : String;
begin
  LstrVersaoArquivo := fRetornaVersaoAutcomLogAceCont('LOG_VEREXE') ;
  LstrVersaoProduto := fRetornaVersaoAutcomLogAceCont('LOG_VERPRO') ;
  Result := '' ;

  if fEmptyStr(LstrVersaoArquivo) then
    Exit ;

  If fEmptyStr(LstrVersaoProduto) Then
    Exit;

  If (blnValidarCampoVersao) Then
  Begin
    If (Not fCampoExiste('LANCON', 'CON_VERSIS')) Then
      Exit;
  End;

  Try
    LRevision := ' [ ' + SVN_REVISION + ' ]';

    LArrVersaoArquivo := LstrVersaoArquivo.Split(['.']);
    LArrVersaoProduto := LstrVersaoProduto.Split(['.']);

    LstrVersao := '';

    For LCount := 0 To Length(LArrVersaoArquivo)-1 Do
    Begin
      LstrVersao := LArrVersaoArquivo[LCount];
      Break;
    End;

    For LCount := 0 To Length(LArrVersaoProduto)-1 Do
    Begin
      If fEmptyStr(LstrVersao) Then
        Exit(LstrVersaoProduto + LRevision)
      Else
        LstrVersao := LstrVersao + '.' + LArrVersaoProduto[LCount];
      If (LCount >= 2) Then
        Break;
    End;

    LstrBuild := '';

    For LCount := 0 To Length(LArrVersaoProduto)-1 Do
    Begin
      If (LCount = 3) Then
      Begin
        LstrBuild := LArrVersaoProduto[LCount];
        Break;
      End;
    End;

    If fEmptyStr(LstrBuild) Then
      Exit(LstrVersaoProduto + LRevision);

    Result := LstrVersao + '.' + LstrBuild + LRevision;
  Except
    Result := '';
  End;

end ;

function fMontaJoinSaiPlanoContas(const ATipo: TJoinSaiPlanoContas): String ;
begin
  result := '' ;
  if jspcPagar in ATipo then
  begin
    result := result + '  LEFT JOIN DUPAGP AGP ' ;
    result := result + '     ON AGP.CTP_NUMDUP = TMP.NUMDOC ' ;
    result := result + '     AND AGP.CTP_CODEMP = TMP.CODEMP ' ;
    result := result + '     AND AGP.CTP_CODFOR = TMP.CODIGO_CLIENTE_FORNECEDOR ' ;
    result := result + '     AND AGP.CTP_PARCEL = "A" ' ;
    result := result + '     AND IFNULL(AGP.CTP_SERIE_, "") = IFNULL(TMP.SERIE_, "") ' ;
    result := result + '     AND TMP.ENTSAI = "S" ' ;
    result := result + '     AND TMP.TIP_FC = "F" ' ;
    result := result + '  LEFT JOIN CADPAG P ' ;
    result := result + '     ON P.CTP_NUMDUP = IF(AGP.CTP_NUMAGR IS NULL, TMP.NUMDOC, AGP.CTP_NUMAGR) ' ;
    result := result + '     AND P.CTP_CODFOR = TMP.CODIGO_CLIENTE_FORNECEDOR ' ;
    result := result + '     AND P.CTP_CODEMP = IF(AGP.CTP_NUMAGR IS NULL, TMP.CODEMP, AGP.CTP_EMPAGR) ' ;
    result := result + '     AND IFNULL(P.CTP_SERIE_, "") = IFNULL(IF(AGP.CTP_NUMAGR IS NULL, TMP.SERIE_, P.CTP_SERIE_), "" ) ' ;
    result := result + '     AND P.CTP_SEQBAI = 0 ' ;
    result := result + '     AND P.CTP_PARCEL = "A" ' ;
    result := result + '     AND TMP.ENTSAI = "S" ' ;
    result := result + '     AND TMP.TIP_FC = "F" ' ;
    result := result + '  LEFT JOIN CTPDET D ' ;
    result := result + '     ON  CASE WHEN AGP.CTP_CODFOR IS NULL THEN P.CTP_CODFOR ELSE AGP.CTP_CODFOR END = D.CTP_CODFOR ' ;
    result := result + '     AND CASE WHEN AGP.CTP_NUMDUP IS NULL THEN P.CTP_NUMDUP ELSE AGP.CTP_NUMDUP END = D.CTP_NUMDUP ' ;
    result := result + '     AND CASE WHEN AGP.CTP_PARCEL IS NULL THEN P.CTP_PARCEL ELSE AGP.CTP_PARCEL END = D.CTP_PARCEL ' ;
    result := result + '     AND CASE WHEN AGP.CTP_CODEMP IS NULL THEN P.CTP_CODEMP ELSE AGP.CTP_CODEMP END = D.CTP_EMPORI ' ;
    result := result + '     AND CASE WHEN AGP.CTP_NUMDUP IS NULL THEN TRIM(COALESCE(P.CTP_SERIE_, "")) ELSE TRIM(COALESCE(AGP.CTP_SERIE_, "")) END = TRIM(COALESCE(D.CTP_SERIE_, "")) ' ;
    result := result + '  LEFT JOIN CADCTA as CADCTA_P ' ;
    result := result + '     ON CADCTA_P.CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA,  D.CTP_CODCTA) ' ;
    result := result + '  LEFT JOIN CTANCO AS CTANCO_P ' ;
    result := result + '     ON  CTANCO_P.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) ' ;
    result := result + '     AND CTANCO_P.NCO_CODEMP = TMP.CODEMP ' ;
  end ;
  if jspcReceber in ATipo then
  begin
    result := result + '  LEFT JOIN DUPAGR AGR ' ;
    result := result + '     ON AGR.CTR_NUMAGR = TMP.NUMDOC ' ;
    result := result + '     AND AGR.CTR_EMPAGR = TMP.CODEMP ' ;
    result := result + '     AND AGR.CTR_CODCLI = TMP.CODIGO_CLIENTE_FORNECEDOR ' ;
    result := result + '     AND AGR.CTR_ESPDOC = TMP.ESPDOC ' ;
    result := result + '     AND AGR.CTR_PARCEL = "A" ' ;
    result := result + '     AND TMP.ENTSAI = "S" ' ;
    result := result + '     AND TMP.TIP_FC = "C" ' ;
    result := result + '  LEFT JOIN DUPAGR AGR2 ' ;
    result := result + '     ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ' ;
    result := result + '     AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ' ;
    result := result + '     AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ' ;
    result := result + '     AND AGR2.CTR_ESPDOC = TMP.ESPDOC ' ;
    result := result + '     AND AGR2.CTR_PARCEL = "A" ' ;
    result := result + '     AND TMP.ENTSAI = "S" ' ;
    result := result + '     AND TMP.TIP_FC = "C" ' ;
    result := result + '  LEFT JOIN CADREC R ' ;
    result := result + '     ON  R.CTR_NUMDUP = IF(AGR.CTR_NUMAGR IS NULL, TMP.NUMDOC, IF(AGR.CTR_ESPDOC = "AG", AGR2.CTR_NUMDUP, AGR.CTR_NUMAGR)) ' ;
    result := result + '     AND R.CTR_CODCLI = TMP.CODIGO_CLIENTE_FORNECEDOR ' ;
    result := result + '     AND R.CTR_CODEMP = IF(AGR.CTR_NUMAGR IS NULL, TMP.CODEMP, IF(AGR.CTR_ESPDOC = "AG", AGR2.CTR_CODEMP, AGR.CTR_EMPAGR)) ' ;
    result := result + '     AND R.CTR_ESPDOC = TMP.ESPDOC ' ;
    result := result + '     AND R.CTR_SEQBAI = 0 ' ;
    result := result + '     AND R.CTR_PARCEL = "A" ' ;
    result := result + '     AND TMP.ENTSAI = "S" ' ;
    result := result + '     AND TMP.TIP_FC = "C" ' ;
    result := result + '  LEFT JOIN CADCTA AS CADCTA_R ' ;
    result := result + '     ON CADCTA_R.CTA_CODCTA = R.CTR_CODCTA ' ;
    result := result + '  LEFT JOIN CTANCO AS CTANCO_R ' ;
    result := result + '     ON CTANCO_R.NCO_CODCTA = R.CTR_CODCTA ' ;
    result := result + '     AND CTANCO_R.NCO_CODEMP = TMP.CODEMP ' ;
  end ;
end ;

function fMontaJoinCoeCosPlanoContas: String ;
begin
  result := '' ;
  result := result + '  LEFT JOIN DUPAGP AGP ' ;
  result := result + '     ON AGP.CTP_NUMDUP = TMP.NUMDOC ' ;
  result := result + '     AND AGP.CTP_CODEMP = TMP.CODEMP ' ;
  result := result + '     AND AGP.CTP_CODFOR = TMP.CODIGO_CLIENTE_FORNECEDOR ' ;
  result := result + '     AND AGP.CTP_PARCEL = "A" ' ;
  result := result + '     AND IFNULL(AGP.CTP_SERIE_, "") = IFNULL(TMP.SERIE_, "") ' ;
  result := result + '  LEFT JOIN CADPAG P ' ;
  result := result + '     ON P.CTP_NUMDUP = IF(AGP.CTP_NUMAGR IS NULL, TMP.NUMDOC, AGP.CTP_NUMAGR) ' ;
  result := result + '     AND P.CTP_CODFOR = TMP.CODIGO_CLIENTE_FORNECEDOR ' ;
  result := result + '     AND P.CTP_CODEMP = IF(AGP.CTP_NUMAGR IS NULL, TMP.CODEMP, AGP.CTP_EMPAGR) ' ;
  result := result + '     AND IFNULL(P.CTP_SERIE_, "") = IFNULL(IF(AGP.CTP_NUMAGR IS NULL, TMP.SERIE_, P.CTP_SERIE_), "" ) ' ;
  result := result + '     AND P.CTP_SEQBAI = 0 ' ;
  result := result + '     AND P.CTP_PARCEL = "A" ' ;
  result := result + '  LEFT JOIN CTPDET D ' ;
  result := result + '     ON  CASE WHEN AGP.CTP_CODFOR IS NULL THEN P.CTP_CODFOR ELSE AGP.CTP_CODFOR END = D.CTP_CODFOR ' ;
  result := result + '     AND CASE WHEN AGP.CTP_NUMDUP IS NULL THEN P.CTP_NUMDUP ELSE AGP.CTP_NUMDUP END = D.CTP_NUMDUP ' ;
  result := result + '     AND CASE WHEN AGP.CTP_PARCEL IS NULL THEN P.CTP_PARCEL ELSE AGP.CTP_PARCEL END = D.CTP_PARCEL ' ;
  result := result + '     AND CASE WHEN AGP.CTP_CODEMP IS NULL THEN P.CTP_CODEMP ELSE AGP.CTP_CODEMP END = D.CTP_EMPORI ' ;
  result := result + '     AND CASE WHEN AGP.CTP_NUMDUP IS NULL THEN TRIM(COALESCE(P.CTP_SERIE_, "")) ELSE TRIM(COALESCE(AGP.CTP_SERIE_, "")) END = TRIM(COALESCE(D.CTP_SERIE_, "")) ' ;
  result := result + '  LEFT JOIN CADCTA as CADCTA_P ' ;
  result := result + '     ON CADCTA_P.CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(AGP.AUTOINCREM IS NULL, P.CTP_CODCTA, AGP.CTP_CODCTA), D.CTP_CODCTA) ' ;
  result := result + '  LEFT JOIN CTANCO AS CTANCO_P ' ;
  result := result + '     ON  CTANCO_P.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(AGP.AUTOINCREM IS NULL, P.CTP_CODCTA, AGP.CTP_CODCTA), D.CTP_CODCTA) ' ;
  result := result + '     AND CTANCO_P.NCO_CODEMP = TMP.CODEMP ' ;
end ;

function fPreparaSqlCoeCosPlanoContas(const AstrSql: String; const ArecValCam: TValidacoesDeBanco): String;
begin
  result := AstrSql ;

  result := '' ;
  result := result + ' SELECT ' ;
  result := result + '   TMP.CLAFIS, ' ;
  result := result + '   TMP.DTAENT, ' ;
  result := result + '   TMP.NUMDOC, ' ;
  result := result + '   TMP.ESPDOC, ' ;
  result := result + '   TMP.CODEMP, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VLRCON, ROUND(TMP.VLRCON*D.CTP_FATCAL,2)) AS VLRCON, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALICM, ROUND(TMP.VALICM*D.CTP_FATCAL,2)) AS VALICM, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALPIS, ROUND(TMP.VALPIS*D.CTP_FATCAL,2)) AS VALPIS, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALCOF, ROUND(TMP.VALCOF*D.CTP_FATCAL,2)) AS VALCOF, ' ;
  result := result + '   TMP.NOME, ' ;
  result := result + '   TMP.CNPJ, ' ;
  if (ArecValCam.FUsaCampoNatCfo) then
    result := result + '   TMP.NATCFO, ' ;
  result := result + '   TMP.TIPO_CLIENTE_FORNECEDOR, ' ;
  result := result + '   TMP.CODIGO_CLIENTE_FORNECEDOR, ' ;
  result := result + '   TMP.PLANCO, ' ;
  result := result + '   TMP.LIQENT, ' ;
  result := result + '   TMP.FISINC, ' ;
  if (ArecValCam.FUsaCampoAbfCon) then
    result := result + '   TMP.ITE_ABFCON, ' ;
  result := result + '   IFNULL(CTANCO_P.NCO_CODCON, CADCTA_P.CTA_PLANCO) AS CTA_PLANCO, ' ;
  result := result + '   IFNULL(CTANCO_P.NCO_CODCTA, CADCTA_P.CTA_CODCTA) AS CODIGO_PLANO_CONTA, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, P.CTP_CODEVE, D.CTP_CODEVE) AS CODEVE ' ;
  result := result + ' FROM ( ' ;
  result := result + AstrSql ;
  result := result + ' ) AS  TMP ' ;
  result := result + fMontaJoinCoeCosPlanoContas ;
end;

function fInformaPlanoContasFaturamento: String ;
begin
  result := 'N' ;
  if fConfiguracaoExiste('CTAFAT') then
  begin
    result := fCfgSis('CTAFAT') ;
  end;
end ;

function fAtivaPlanoContasSAI: String ;
begin
  result := 'N' ;
  if fConfiguracaoExiste('CTASAI') then
  begin
    result := fCfgSis('CTASAI') ;
  end;
end ;

function fAtivaPlanoContasCoeCos: String ;
begin
  result := 'N' ;
  if fConfiguracaoExiste('CTACNT') then
  begin
    result := fCfgSis('CTACNT') ;
  end;
end ;

function fUsarVeioNFQuandoValorEmCodVel: String ;
begin
  result := 'N' ;
  if fConfiguracaoExiste('CTPVEL') then
  begin
    result := fCfgSis('CTPVEL') ;
  end;
end ;

function fTemColFreteHub: Boolean ;
begin
  Result := False ;
  if not fCampoExiste('MOVCAR', 'MCA_FREMKT') then
    exit ;

  if not fCfgCarHub then
    exit ;

  if not fUsaHub then
    exit ;

  Result := True ;
end ;

function fTemColDescontoHub: Boolean ;
begin
  Result := False ;
  if not fCampoExiste('MOVCAR', 'MCA_CUPMKT') then
    exit ;

  if not fCfgCarHub then
    exit ;

  if not fUsaHub then
    exit ;

  Result := True ;
end ;

function fTemColAjusteHub: Boolean ;
begin
  Result := False ;
  if not fCampoExiste('MOVCAR', 'MCA_VALAJU') then
    exit ;

  if not fCfgCarHub then
    exit ;

  if not fUsaHub then
    exit ;

  Result := True ;
end ;

function fUsaHub: Boolean ;
var
  LqryNumPok: TUniQuery ;
begin
  Result := False ;

  if not fTabelaExiste('ORIFGO') then
    exit ;

  LqryNumPok := fCriaQuery() ;
  try
    LqryNumPok.Close ;
    LqryNumPok.SQL.Clear ;
    LqryNumPok.SQL.Add(' SELECT ORIFGO.AUTOINCREM ') ;
    LqryNumPok.SQL.Add(' FROM ORIFGO ') ;
    LqryNumPok.SQL.Add(' WHERE ORI_CODORI IN ( SELECT DISTINCT FGO_CODORI FROM EXTGOR WHERE FGO_CODORI IS NOT NULL  ) AND ORI_DESORI LIKE "%HUBCITEL%" ') ;
    LqryNumPok.SQL.Add(' LIMIT 1 ') ;
    LqryNumPok.Open ;
    Result := not LqryNumPok.IsEmpty ;

  finally
    LqryNumPok.Close ;
    FreeAndNil(LqryNumPok) ;
  end ;
end ;

function fPodeIncluirComSubconta(const AblnContaDebito, AblnContaCredito: Boolean): Boolean ;
begin
  Result := True ;
  if (not AblnContaDebito) and (not AblnContaCredito) then
    Exit ;

  if (AblnContaDebito) and (AblnContaCredito) then
    Exit(False) ;
end ;

function fAtivaFormasPagamentoCaixaCRC: String ;
begin
  result := 'N' ;
  if fConfiguracaoExiste('CRCCXX') then
  begin
    result := fCfgSis('CRCCXX') ;
  end;
end ;

function fUsarAbrevProdNoCoeCos(): Boolean ;
begin
  result := True ;
  if fConfiguracaoExiste('ABRECO') then
  begin
    result := fCfgSis('ABRECO') = 'S' ;
  end;
end ;

function fTemCampoMultaCTP: Boolean ;
begin
  result := fCampoExiste('CADPAG', 'CTP_VALMUL') ;
end ;

function fTiraEnter(strTexto: String): String;
begin
  Result := strTexto;
  Result := fTrocaCaracter(Result, #13, ' ');
  Result := fTrocaCaracter(Result, #10, ' ');
  Result := Trim(Result);
end;

function fRetornaNomeTabela(strString: String): String;
  Var
    strTmp     : String;
    intPosicao : Integer;
    intContador: Integer;
Begin
  strString := AnsiUpperCase(Trim(strString));

  If Length(strString) > 1000 Then
  Begin
    Result := fRetornaNomeTabela(LeftStr(strString, 1000));
    If Result <> '' Then
      Exit;
  End;

  Result     := '';
  intPosicao := 0;

  If LeftStr(strString,6) = 'INSERT' Then
  Begin
    intPosicao :=  Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString,6) = 'UPDATE' Then
  Begin
    intPosicao :=  Pos('UPDATE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'UPDATE ', '');
  End

  Else If LeftStr(strString,6) = 'DELETE' Then
  Begin
    intPosicao := Pos('FROM ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'FROM ', '');
  End

  Else If LeftStr(strString,7) = 'REPLACE' Then
  Begin
    intPosicao := Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End;

  If (intPosicao > 0) Then
  Begin
    strTmp := fTrocaCaracter(strTmp,'(', ' ');
    strTmp := fTrocaCaracter(strTmp,')', ' ');
    strTmp := fTrocaCaracter(strTmp,',', ' ');
    strTmp := Trim(strTmp);

    For intContador := 1 To Length(strTmp) Do
    Begin
      If fEmptyStr(Copy(strTmp, intContador, 1)) Then
        Break;

      Result := Result + Copy(strTmp, intContador, 1);
    End;

    Result := Trim(Result);
  End;

  If Not fEmptyStr(Result) Then
  Begin

    intPosicao := Pos('.',Result);

    If intPosicao > 0 Then
      Result := Copy(Result, intPosicao +1, Length(Result) -intPosicao);

  End;
End;

function fEhTabelaDeContabilidade(strTabela: string): boolean;
begin
  Result := MatchStr(strTabela, ['LANCON',
                                 'PARCON',
                                 'HISPAD',
                                 'PLANCO',
                                 'ECFLAN',
                                 'ECFMES',
                                 'ECFCTA',
                                 'ECFSLD',
                                 'PLAINI',
                                 'APUPRE',
                                 'APUVRE',
                                 'APUARE',
                                 'APUCRE',
                                 'APUSAL',
                                 'APUCDE',
                                 'CTACON',
                                 'LO2CON',
                                 'LO2LAN',
                                 'CADCTA',
                                 'BANNCO',
                                 'CARNCO',
                                 'CLINCO',
                                 'CTANCO',
                                 'FORNCO',
                                 'PARNCO',
                                 'PORNCO',
                                 'FECCON',
                                 'FECMES']);
end;

function fCoalesceVenComCosCoe(const AstrCampo: String; const AblnUsaAbrevProd: Boolean): String ;
begin
  Result := AstrCampo ;
  if not AblnUsaAbrevProd then
    Result := 'COALESCE(' + AstrCampo + ', "V")' ;
end ;

procedure pGravaLogContabil(strSQL, strTabela: string);

  function fExtrairTipLan: string;
    const
      FIELD_TO_FIND : String = 'CON_TIPLAN';
      arrIgnoreChar : array[1..3] of string = ('=', '"', chr(39));
      MAX_LENGTH_TIPLAN : Integer = 3;
    var
      intPos : Integer;
      intCnt : Integer;
  begin
    Result := '';

    if (LeftStr(strSQL, 30).Contains('INSERT')) then
      exit;

    intPos := Pos(FIELD_TO_FIND, strSQL);

    if (intPos > 0) then
    begin
      intPos := intPos + Length(FIELD_TO_FIND);
      for intCnt := intPos to Length(strSQL) do
      begin
        if not fEmptyStr(strSQL[intCnt]) then
        begin
          if not (MatchStr(strSQL[intCnt], arrIgnoreChar)) then
            Result := Result + strSQL[intCnt];
        end;

        if Length(Result) = MAX_LENGTH_TIPLAN then
          break;
      end;
    end;
  end;

  var
    qryLogCtl : TUniQuery;
begin
  if strSQL.IsEmpty then
    exit;

  qryLogCtl := fCriaQuery;
  try
    qryLogCtl.SQL.Text := 'SELECT * FROM LOGCTL WHERE FALSE';
    qryLogCtl.Open;
    qryLogCtl.Insert;
    qryLogCtl.FieldByName('CTL_CODEMP').AsString := VS_strCodEmp;
    qryLogCtl.FieldByName('CTL_DTALOG').AsDateTime := VS_Date;
    qryLogCtl.FieldByName('CTL_HORLOG').AsDateTime := fTime();
    qryLogCtl.FieldByName('CTL_TABELA').AsString := strTabela;

    if (strTabela = 'LANCON') or (strTabela = 'PARCON') then
      qryLogCtl.FieldByName('CTL_TIPLAN').AsString := fExtrairTipLan;

    qryLogCtl.FieldByName('CTL_COMAND').AsString := strSQL;
    qryLogCtl.FieldByName('CTL_CODOPE').AsString := strLoginUsuarioLogado;
    qryLogCtl.Post;
  finally
    FreeAndNil(qryLogCtl);
  end;

end;

function fGerarPelaEmpresaBaixaCTP(): Boolean ;
begin
  result := False ;
  if fConfiguracaoExiste('EXCPAP') then
    result := fCfgSis('EXCPAP')='S' ;
end ;

function fEhAdmContabilidade: Boolean ;
begin
  Result := fEhAdministrador(strLoginUsuarioLogado) ;
end ;

function fMostrarWarningGeracaoMovimento(AtipoMov: string): Boolean ;
begin
  Result := False;
  if (AtipoMov = DES_CONTABIL_SIGLA[tcENT]) OR
     (AtipoMov = DES_CONTABIL_SIGLA[tcSAI]) OR
     (AtipoMov = DES_CONTABIL_SIGLA[tcCOE]) OR
     (AtipoMov = DES_CONTABIL_SIGLA[tcCOS]) OR
     (AtipoMov = 'CEN')    OR
     (AtipoMov = 'CSA')    OR
     (AtipoMov = 'ENTADT') OR
     (AtipoMov = 'OUE')    OR
     (AtipoMov = 'SEE')    OR
     (AtipoMov = 'SES') then
    Result := True;
end;

function fObtemEmpresasFiliais(const AstrCodEmp: String): TConsultasArray ;
var
  LreqEmpresa: TConsultas ;
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try

    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT EMP_CODEMP ') ;
    LqryConsulta.SQL.Add(' FROM CADEMP ') ;
    LqryConsulta.SQL.Add(' WHERE SUBSTR(EMP_C_G_C_,1,8) IN (SELECT SUBSTR(EMP_C_G_C_,1,8) FROM CADEMP WHERE EMP_CODEMP = :CODEMP) ') ;
    LqryConsulta.SQL.Add(' ORDER BY EMP_CODEMP ') ;
    LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryConsulta.Open ;
    LqryConsulta.First ;
    SetLength(Result, 0);
    while not LqryConsulta.Eof do
    begin
      FillChar(LreqEmpresa, SizeOf(LreqEmpresa), #0);
      LreqEmpresa.strCodigo := LqryConsulta.FieldByName('EMP_CODEMP').AsString ;

      SetLength(Result, Length(Result)+1);
      Result[High(Result)] := LreqEmpresa ;

      LqryConsulta.Next ;
    end ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;

end ;

function fColunasComCfopServico(ArecParCon: TParametrosConsulta; const AstrEntSai: String): TList<Integer>;
var
  LqryCadFis: TUniQuery ;
  LintCnt: Integer ;
  LlstControle: TStringList ;
begin
  Result := TList<Integer>.Create;
  LlstControle := TStringList.Create ;
  LqryCadFis := fCriaQuery() ;
  try
    LlstControle.Sorted := True ;
    LqryCadFis.Close ;
    LqryCadFis.SQL.Clear ;
    LqryCadFis.SQL.Add('SELECT DISTINCT FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5 FROM CADFIS ') ;
    LqryCadFis.SQL.Add('WHERE FIS_ENTSAI = :ENTSAI ') ;
    LqryCadFis.ParamByName('ENTSAI').AsString := AstrEntSai ;
    If Not fEmptyStr(ArecParCon.strCodEmp) Then
    begin
      LqryCadFis.SQL.Add(' AND FIS_CODEMP = :CODEMP ') ;
      LqryCadFis.ParamByName('CODEMP').AsString := ArecParCon.strCodEmp;
    end ;

    if (ArecParCon.dtaDtaIni > 0) then
    begin
      LqryCadFis.SQL.Add(' AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryCadFis.ParamByName('DTAINI').AsDate := ArecParCon.dtaDtaIni;
      LqryCadFis.ParamByName('DTAFIN').AsDate := ArecParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADFIS.AUTOINCREM')
      .fIncDoc(ArecParCon.strIncDoc)
      .fArrIncDoc(ArecParCon.arrIncDoc)
      .fQuerySql(LqryCadFis)
      .fExecute ;

    LqryCadFis.Open ;

    if LqryCadFis.IsEmpty then
    begin
      Result.Add(1) ;
    end
    else
    begin
      for LintCnt := 1 to 5 do
      begin
        LqryCadFis.First ;
        while not LqryCadFis.Eof do
        begin
          if (not fEmptyStr(LqryCadFis.FieldByName('FIS_CLFSC'+inttostr(LintCnt)).AsString)) and (copy(LqryCadFis.FieldByName('FIS_CLFSC'+inttostr(LintCnt)).AsString, 2, 3) = '933') then
          begin
            if LlstControle.IndexOf(IntToStr(LintCnt)) <> -1 then
            begin
              LqryCadFis.Next ;
              Continue ;
            end ;
            LlstControle.Add(IntToStr(LintCnt)) ;
            Result.Add(LintCnt) ;
          end ;
          LqryCadFis.Next ;
        end ;
      end ;

      if Result.Count = 0 then
        Result.Add(1) ;
    end ;

  finally
    FreeAndNil(LqryCadFis) ;
    FreeAndNil(LlstControle) ;
  end ;
end;

function fColunasComCfopCadfis(ArecParCon: TParametrosConsulta; const AstrEntSai: String): TList<Integer> ;
var
  LqryCadFis: TUniQuery ;
  LintCnt: Integer ;
begin
  Result := TList<Integer>.Create;
  LqryCadFis := fCriaQuery() ;
  try

    LqryCadFis.Close ;
    LqryCadFis.SQL.Clear ;
    LqryCadFis.SQL.Add(' SELECT  ') ;
    LqryCadFis.SQL.Add('  SUM(COALESCE(FIS_VLCON1, 0.00)) AS FIS_VLCON1, ') ;
    LqryCadFis.SQL.Add('  SUM(COALESCE(FIS_VLCON2, 0.00)) AS FIS_VLCON2, ') ;
    LqryCadFis.SQL.Add('  SUM(COALESCE(FIS_VLCON3, 0.00)) AS FIS_VLCON3, ') ;
    LqryCadFis.SQL.Add('  SUM(COALESCE(FIS_VLCON4, 0.00)) AS FIS_VLCON4, ') ;
    LqryCadFis.SQL.Add('  SUM(COALESCE(FIS_VLCON5, 0.00)) AS FIS_VLCON5  ') ;
    LqryCadFis.SQL.Add(' FROM CADFIS ') ;
    LqryCadFis.SQL.Add(' WHERE FIS_ENTSAI = :ENTSAI ') ;
    LqryCadFis.ParamByName('ENTSAI').AsString := AstrEntSai ;
    If Not fEmptyStr(ArecParCon.strCodEmp) Then
    begin
      LqryCadFis.SQL.Add(' AND FIS_CODEMP = :CODEMP ') ;
      LqryCadFis.ParamByName('CODEMP').AsString := ArecParCon.strCodEmp;
    end ;

    if (ArecParCon.dtaDtaIni > 0) then
    begin
      LqryCadFis.SQL.Add(' AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ') ;
      LqryCadFis.ParamByName('DTAINI').AsDate := ArecParCon.dtaDtaIni;
      LqryCadFis.ParamByName('DTAFIN').AsDate := ArecParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADFIS.AUTOINCREM')
      .fIncDoc(ArecParCon.strIncDoc)
      .fArrIncDoc(ArecParCon.arrIncDoc)
      .fQuerySql(LqryCadFis)
      .fExecute ;

    LqryCadFis.Open ;

    if LqryCadFis.IsEmpty then
    begin
      Result.Add(1) ;
    end
    else
    begin
      LqryCadFis.First ;
      for LintCnt := 1 to 5 do
        if fFormataFloat(LqryCadFis.FieldByName('FIS_VLCON'+inttostr(LintCnt)).AsFloat, 2) <> 0.00  then
          Result.Add(LintCnt) ;

      if Result.Count = 0 then
        Result.Add(1) ;
    end ;

  finally
    FreeAndNil(LqryCadFis) ;
  end ;
end ;

function fDescricaoCfgCCECTR: String ;
begin
  Result := 'CCECTR';
end;

function fPlanoContasEmprestimoEntreEmpresasAtivo: String ;
var
  LCfg: String;
begin
  Result := '' ;
  LCfg := fDescricaoCfgPlanoContasEmprestimoEntreEmpresasAtivo;
  if fConfiguracaoExiste(LCfg) then
    result := fCfgSis(LCfg) ;
end ;

function fDescricaoCfgPlanoContasEmprestimoEntreEmpresasAtivo: String ;
begin
  Result := 'EMPATI' ;
end ;

function fPlanoContasEmprestimoEntreEmpresasPassivo: String ;
var
  LCfg: string;
begin
  Result := '' ;
  LCfg := fDescricaoCfgPlanoContasEmprestimoEntreEmpresasPassivo;
  if fConfiguracaoExiste(LCfg) then
    result := fCfgSis(LCfg) ;
end ;

function fDescricaoCfgPlanoContasEmprestimoEntreEmpresasPassivo: String ;
begin
  Result := 'EMPPAS';
end;

function fEmpresaGeracaoCtp(const AstrAliasComPonto: String; const AblnUsarEmpBai: Boolean): string;
begin
  Result := AstrAliasComPonto + 'CTP_CODEMP' ;
  if AblnUsarEmpBai then
    Result := AstrAliasComPonto + 'CTP_EMPBAI' ;
end;

function fCfgCarHub: Boolean;
begin
  Result := False;

  if not fConfiguracaoExiste('CARHUB') then
    Exit;

  if not fCfgSis('CARHUB', varBoolean) then
    Exit;

  Result := True;
end;

function fCfgConHis: Boolean;
begin
  Result := False;

  if not fConfiguracaoExiste('CONHIS') then
    Exit;

  if not fCfgSis('CONHIS', varBoolean) then
    Exit;

  Result := True;
end;

function fDesconsiderarFiltroDataFaturaCTR: Boolean ;
begin
  Result := False;

  if not fConfiguracaoExiste('CTRFAT') then
    Exit;

  if not fCfgSis('CTRFAT', varBoolean) then
    Exit;

  Result := True;
end ;

function fCarregaCodigoHistoricoCadCta(const strCodCta, strTipLan: string): integer;
begin
  Result := 0;

  if fEmptyStr(strCodCta) then
    Exit;

  if not MatchStr(strTipLan, ['CTR', 'CTP']) then
    Exit;

  if not fCfgConHis then
    Exit;

  if not fCampoExiste('CADCTA', 'CTA_HISCON') then
    Exit;

   Result := fCampoTabela('CTA_HISCON', 'CADCTA', ['CTA_CODCTA'], [strCodCta], False);
end;

function fPlanoContabilCadCtaPorEmpresa(const AstrCodigo, AstrCodEmp: String): String ;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT ') ;
    LqryConsulta.SQL.Add('   IFNULL(NCO_CODCON, CTA_PLANCO ) AS CODCTA, ') ;
    LqryConsulta.SQL.Add('   IFNULL(NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA ') ;
    LqryConsulta.SQL.Add(' FROM CADCTA ') ;
    LqryConsulta.SQL.Add('      LEFT JOIN CTANCO ON NCO_CODCTA = CTA_CODCTA AND NCO_CODEMP = :CODEMP ') ;
    LqryConsulta.SQL.Add(' WHERE CTA_CODCTA = :CODIGO ') ;
    LqryConsulta.ParamByName('CODIGO').AsString := AstrCodigo ;
    LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryConsulta.Open ;

    Result := LqryConsulta.FieldByName('CODCTA').AsString ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end ;

function fPlanoContabilPortadorPorEmpresa(const AstrCodigo, AstrCodEmp: String): String ;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT ') ;
    LqryConsulta.SQL.Add('   IFNULL(NCO_CODCON, POR_PLANCO) AS PLAPOR, ') ;
    LqryConsulta.SQL.Add('   IFNULL(NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR ') ;
    LqryConsulta.SQL.Add(' FROM CADPOR ') ;
    LqryConsulta.SQL.Add('      LEFT JOIN PORNCO ON NCO_CODPOR = POR_CODPOR AND NCO_CODEMP = :CODEMP ') ;
    LqryConsulta.SQL.Add(' WHERE POR_CODPOR = :CODIGO ') ;
    LqryConsulta.ParamByName('CODIGO').AsString := AstrCodigo ;
    LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryConsulta.Open ;

    Result := LqryConsulta.FieldByName('PLAPOR').AsString ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end ;

function fPlanoContabilClientePorEmpresa(const AstrCodigo, AstrCodEmp: String): String ;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT ') ;
    LqryConsulta.SQL.Add('   IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ') ;
    LqryConsulta.SQL.Add('   IFNULL(NCO_CODCON, CLI_PLANCO) AS PLANCO ') ;
    LqryConsulta.SQL.Add(' FROM CADCLI ') ;
    LqryConsulta.SQL.Add('      LEFT JOIN CLINCO ON NCO_CODCLI = CLI_CODCLI AND NCO_CODEMP = :CODEMP ') ;
    LqryConsulta.SQL.Add(' WHERE CLI_CODCLI = :CODIGO ') ;
    LqryConsulta.ParamByName('CODIGO').AsString := AstrCodigo ;
    LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryConsulta.Open ;

    Result := LqryConsulta.FieldByName('PLANCO').AsString ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end ;

function fPlanoContabilBandeiraPorEmpresa(const AstrCodigo, AstrCodEmp: String): String ;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT ') ;
    LqryConsulta.SQL.Add('   IFNULL(NCO_CODBAN, BAN_CODBAN) AS CODIGO_BANDEIRA, ') ;
    LqryConsulta.SQL.Add('   IFNULL(NCO_CODCON, BAN_PLANCO) AS BAN_PLANCO ') ;
    LqryConsulta.SQL.Add(' FROM CADBAN ') ;
    LqryConsulta.SQL.Add('      LEFT JOIN BANNCO ON NCO_CODBAN = BAN_CODBAN AND NCO_CODEMP = :CODEMP ') ;
    LqryConsulta.SQL.Add(' WHERE BAN_CODBAN = :CODIGO ') ;
    LqryConsulta.ParamByName('CODIGO').AsString := AstrCodigo ;
    LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryConsulta.Open ;

    Result := LqryConsulta.FieldByName('BAN_PLANCO').AsString ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end ;

function fCarregaContaReduzida(const AstrConta, AstrEmpresa: string): string;
var
  LstrTplaco : string ;
begin
  LstrTplaco := fRetTplacoEmpresaLogada(AstrEmpresa) ;
  result := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AstrConta), LstrTplaco]);
end;

function fCarregaDescricaoConta(const AstrConta, AstrEmpresa: string): string;
var
  LstrTplaco : string ;
begin
  LstrTplaco := fRetTplacoEmpresaLogada(AstrEmpresa) ;
  result := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AstrConta), LstrTplaco]);
end;

function fTemFechamento(const AdtaIni, AdtaFin: TDateTime; const AarrEmp: TConsultasArray): boolean;
var
  LlstEmpresas: TStringList;
  LarrFiliais: TConsultasArray;
  LintEmp, LintFil: Integer;
  LstrInEmpresas, LstrMensagem: string;
begin
  // Basta o inicio do periodo: fechamento que toque qualquer data dele termina em data igual
  // ou posterior ao inicio, e o periodo inteiro e recusado (Req. 469576). Cada empresa entra
  // com a sua raiz de CNPJ, consultada uma vez por raiz.
  LlstEmpresas := TStringList.Create;
  try
    for LintEmp := Low(AarrEmp) to High(AarrEmp) do
    begin
      if fEmptyStr(AarrEmp[LintEmp].strCodigo) or (LlstEmpresas.IndexOf(AarrEmp[LintEmp].strCodigo) >= 0) then
        Continue;

      LarrFiliais := fObtemEmpresasFiliais(AarrEmp[LintEmp].strCodigo);
      if Length(LarrFiliais) = 0 then
        LlstEmpresas.Add(AarrEmp[LintEmp].strCodigo);
      for LintFil := Low(LarrFiliais) to High(LarrFiliais) do
        if LlstEmpresas.IndexOf(LarrFiliais[LintFil].strCodigo) < 0 then
          LlstEmpresas.Add(LarrFiliais[LintFil].strCodigo);
    end;

    LstrInEmpresas := '';
    for LintEmp := 0 to LlstEmpresas.Count - 1 do
    begin
      if LstrInEmpresas <> '' then
        LstrInEmpresas := LstrInEmpresas + ', ';
      LstrInEmpresas := LstrInEmpresas + QuotedStr(LlstEmpresas[LintEmp]);
    end;

    Result := fFechamentoContabilAteData(AdtaIni, LstrInEmpresas, LstrMensagem);
    if Result then
      fMensagem('ATENÇÃO!', LstrMensagem, ['&OK']);
  finally
    FreeAndNil(LlstEmpresas);
  end;
end;

function fTemApenasNumeros(const AstrValor: String): Boolean ;
var
  LintCnt: Integer ;
begin
  Result := False ;

  if fEmptyStr(AstrValor) then
    Exit ;

  for LintCnt := 1 to Length(AstrValor) do
  begin
    if not CharInSet(AstrValor[LintCnt], ['0'..'9']) then
      Exit ;
  end ;
  Result := True ;
end ;

function fFiltroVigenciaParcon: string; overload;
begin
  Result := fFiltroVigenciaParcon(VS_Date, true);
end;

function fFiltroVigenciaParcon(const ADate: TDate; const Ativo: boolean = true): string;
begin
  Result := ' AND "' + FormatDateTime('yyyy-mm-dd', ADate) + '"' + IfThen(Ativo, ' ', ' NOT') +
            ' BETWEEN COALESCE(PARCON.CON_VIGINI, "2000-01-01") AND COALESCE(PARCON.CON_VIGFIN, "3000-01-01") ';
end;

function fCfgCtpAdf: string;
begin
  result := '1' ; ///valor padrão
  if fConfiguracaoExiste('CTPADF') then
  begin
    result := fCfgSis('CTPADF') ;
  end;
end;

function fCfgParNat: string;
begin
  result := 'N' ; ///valor padrão
  if fConfiguracaoExiste('PARNAT') then
  begin
    result := fCfgSis('PARNAT') ;
  end;
end;

function fCarregaEntAdt(recParCon: TParametrosConsulta): TUniClientDataset;
var
  strSQL: string;
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Clear;

    strSQL := '';
    strSQL := strSQL + 'SELECT DISTINCT MOVGER.AUTOINCREM AS SEQGER, "MOVGER" AS TABELA ';
    strSQL := strSQL + 'FROM MOVGER ';
    strSQL := strSQL + 'INNER JOIN CADPAG ON TRUE ';
    strSQL := strSQL + '  AND CTP_NUMDUP = GER_NUMDOC ';
    strSQL := strSQL + '  AND CTP_CODFOR = GER_CODFOR ';
    strSQL := strSQL + '  AND CTP_CODEMP = GER_CODEMP ';
    strSQL := strSQL + '  AND IFNULL(CTP_SERIE_,"") = IFNULL(GER_SERIE_,"") ';
    strSQL := strSQL + 'WHERE TRUE ';
    strSQL := strSQL + '  AND IFNULL(CTP_PAGANT, "") = "S" ';
    strSQL := strSQL + '  AND CTP_SEQBAI = 0 ';

    If Not fEmptyStr(recParCon.strCodEmp) Then
      strSQL := strSQL + '  AND GER_CODEMP = :CODEMP ';

    if (recParCon.dtaDtaIni > 0) then
      strSQL := strSQL + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    if fEmptyStr(recParCon.strTabela) then
      strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER')
    else if (recParCon.strTabela = 'NOTGER') then
      strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');

    qryAux.SQL.Add(strSQL);

    pSetaParametrosGerLanCon(recParCon, qryAux);

    qryAux.Open;

    result := fCriaClientDatset(qryAux) ;
    result.IndexFieldNames := 'SEQGER;TABELA';
  finally
    FreeAndNil(qryAux);
  end;
end;

function fCarregaEntAdtFis(recParCon: TParametrosConsulta): TUniClientDataset;
var
  strSQL: string;
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Clear;

    strSQL := '';
    strSQL := strSQL + 'SELECT DISTINCT CADFIS.AUTOINCREM AS FISINC ';
    strSQL := strSQL + 'FROM CADFIS ';
    strSQL := strSQL + 'INNER JOIN CADPAG ON TRUE ';
    strSQL := strSQL + '  AND CTP_NUMDUP = FIS_NUMDOC ';
    strSQL := strSQL + '  AND CTP_CODFOR = FIS_FORCLI ';
    strSQL := strSQL + '  AND CTP_CODEMP = FIS_CODEMP ';
    strSQL := strSQL + '  AND IFNULL(CTP_SERIE_,"") = IFNULL(FIS_SERIE_,"") ';
    strSQL := strSQL + 'WHERE TRUE ';
    strSQL := strSQL + '  AND IFNULL(CTP_PAGANT, "") = "S" ';
    strSQL := strSQL + '  AND CTP_SEQBAI = 0 ';

    If Not fEmptyStr(recParCon.strCodEmp) Then
      strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';

    if (recParCon.dtaDtaIni > 0) then
      strSQL := strSQL + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    qryAux.SQL.Add(strSQL);

    pSetaParametrosGerLanCon(recParCon, qryAux);

    qryAux.Open;

    result := fCriaClientDatset(qryAux) ;
    result.IndexFieldNames := 'FISINC';
  finally
    FreeAndNil(qryAux);
  end;
end;

function fCfgCtpUif: string;
begin
  Result := 'A';
  if fConfiguracaoExiste('CTPUIF') then
    Result := fCfgSis('CTPUIF');
end;

function fListaCfopsOutrasEntradas: String ;
begin
  Result := '"251", "252", "253", "254", "255", "256", "257", "301", "302", "303", "304", "305", "306", "602", "605"' ;
end ;

procedure pVerificaColunasExitemValorContabil(var AColunasValorContabil: TSetColunasValorLiquidoContabil) ;
var
  LItem: TColunasValorLiquidoContabil ;
  LColuna: String ;
begin
  for LItem := Low(TColunasValorLiquidoContabil) to High(TColunasValorLiquidoContabil) do
  begin
    LColuna := DES_COLUNAS_VALOR_LIQUIDO_CONTABIL[LItem] ;
    if not fCampoExiste('CADFIS', LColuna) then
      Exclude(AColunasValorContabil, LItem);
  end ;
end ;

function fRetornaColunasADescontarValorContabil(const AColunasValorContabil: TSetColunasValorLiquidoContabil): string ;
var
  LItem: TColunasValorLiquidoContabil ;
  LColuna: String ;
begin
  Result := '0.00' ;
  for LItem := Low(TColunasValorLiquidoContabil) to High(TColunasValorLiquidoContabil) do
  begin
    if LItem in AColunasValorContabil then
    begin
      LColuna := DES_COLUNAS_VALOR_LIQUIDO_CONTABIL[LItem] ;
      Result := Result + format('+COALESCE(%S, 0.00)', [LColuna]) ;
    end ;
  end ;
end ;


function fTemParametroConfigurado(const ALista: TStringList; const ATipo: String): Boolean ;
begin
  Result := ALista.IndexOf(ATipo) >= 0;
end ;

function fCarregaListaParametrosConfigurados(): TStringList ;
var
  LConsulta: TUniQuery ;
begin
  Result := TStringList.Create ;
  Result.Sorted := True ;

  LConsulta := fCriaQuery() ;
  try
    LConsulta.Close ;
    LConsulta.SQL.Clear ;
    LConsulta.SQL.Add('SELECT DISTINCT CON_TIPLAN FROM PARCON') ;
    LConsulta.SQL.Add('ORDER BY CON_TIPLAN ') ;
    LConsulta.Open ;
    LConsulta.First ;

    while not LConsulta.Eof do
    begin
      Result.Add(LConsulta.FieldByName('CON_TIPLAN').AsString) ;
      LConsulta.Next ;
    end ;

  finally
    FreeAndNil(LConsulta) ;
  end ;

end ;

function fRetornaDictCamposTabelaExclusaoFec(): TDictionary<string, TRecCampos>;
var
  LCampos: TRecCampos;
begin
  Result := TDictionary<string, TRecCampos>.Create;

  LCampos := Default(TRecCampos);
  pRetornaCamposDelTabela('LANCON', LCampos.strCampos, LCampos.strCamposDel) ;
  Result.AddOrSetValue('LANCON', LCampos);

  LCampos := Default(TRecCampos);
  pRetornaCamposDelTabela('FECCON', LCampos.strCampos, LCampos.strCamposDel) ;
  Result.AddOrSetValue('FECCON', LCampos);

  LCampos := Default(TRecCampos);
  pRetornaCamposDelTabela('FECMES', LCampos.strCampos, LCampos.strCamposDel) ;
  Result.AddOrSetValue('FECMES', LCampos);

  LCampos := Default(TRecCampos);
  pRetornaCamposDelTabela('LANMES', LCampos.strCampos, LCampos.strCamposDel) ;
  Result.AddOrSetValue('LANMES', LCampos);

  LCampos := Default(TRecCampos);
  pRetornaCamposDelTabela('PLAMES', LCampos.strCampos, LCampos.strCamposDel) ;
  Result.AddOrSetValue('PLAMES', LCampos);

  LCampos := Default(TRecCampos);
  pRetornaCamposDelTabela('LANBAL', LCampos.strCampos, LCampos.strCamposDel) ;
  Result.AddOrSetValue('LANBAL', LCampos);

  LCampos := Default(TRecCampos);
  pRetornaCamposDelTabela('PLAINI', LCampos.strCampos, LCampos.strCamposDel) ;
  Result.AddOrSetValue('PLAINI', LCampos);

  LCampos := Default(TRecCampos);
  pRetornaCamposDelTabela('DPRINI', LCampos.strCampos, LCampos.strCamposDel) ;
  Result.AddOrSetValue('DPRINI', LCampos);
end;

function fPermiteContabilizarCCtransfAdtnoCtr: boolean ;
begin
  Result := True ;
  if fConfiguracaoExiste('ADTOCC') then
    result := fCfgSis('ADTOCC') = 'S' ;
end ;

procedure pTrataExercicioCodEmp(const AValor: string; var AExercicio: Integer; var ACodEmp: String);
var
  LParts: TArray<string>;
begin
  AExercicio := 0;
  ACodEmp    := '';

  LParts := AValor.Split(['|']);

  if Length(LParts) <> 2 then
    Exit;

  AExercicio := StrToIntDef(LParts[0], 0);
  ACodEmp    := LParts[1];
end ;


function fOperadorCitelLogado: Boolean;
begin
  Result := MatchStr(strLoginUsuarioLogado, ['997', '998', '999']);
end;

function fContabilizarDespesasCobrancaCTR: Boolean;
begin
  Result := False;
  if fConfiguracaoExiste('DESCOB') then
    result := fCfgSis('DESCOB') = 'S' ;
end ;

procedure pRegistraLogAjcDelLancon(var Aqry: TUniQuery; var ALstLog: TObjectList<TLogAjcItem>; const ANomFrm: string; const ArrCampos: TArray<string>);
var
  LstrCampo: string;
  LLogItem: TLogAjcItem;
  LDtaAlt: TDate;
  LHraAlt: TTime;
begin
  try
    if Length(ArrCampos) = 0 then
      Exit;

    LDtaAlt := fNow();
    LHraAlt := fTime();

    Aqry.SQL.Strings[0] := ' SELECT LANCON.* ';
    Aqry.Open;

    while not Aqry.Eof do
    begin
      for LstrCampo in ArrCampos do
      begin
        LLogItem := TLogAjcItem.Create;
        LLogItem.CodEmp := VS_strCodEmp;
        LLogItem.CodOpe := strLoginUsuarioLogado;
        LLogItem.DtaAlt := LDtaAlt;
        LLogItem.HraAlt := LHraAlt;
        LLogItem.Tabela := 'LANCON';
        LLogItem.Incdoc := Aqry.FieldByName('AUTOINCREM').AsString;
        LLogItem.Tipaju := 'EXC';
        LLogItem.Coluna := LstrCampo;
        LLogItem.ValAnt := Aqry.FieldByName(LstrCampo).AsString;
        LLogItem.ValAtu := '';
        LLogItem.NomFrm := ANomFrm;
        LLogItem.SeqAju := TLogAjcOpContext.SeqAju;
        ALstLog.Add(LLogItem);
      end;

      Aqry.Next;
    end;
  finally
    Aqry.Close;
    Aqry.SQL.Strings[0] := ' DELETE LANCON ';
  end;
end;

function fEhExclusaoLancamentoPartidaSimples(const AAutoInc: string; var AarrAutoIncs: Tarray<string>; var AqryLan: TUniQuery): boolean;
begin
  Result := False;
  AqryLan.Close;
  AqryLan.SQL.Clear;
  AqryLan.SQL.Add(' SELECT B.AUTOINCREM, B.CON_EMPLAN, B.CON_DTALAN, B.CON_TIPLAN, B.CON_DESVAL, B.CON_CONCRE, B.CON_CONDEB, B.CON_VALLAN, B.CON_HISTOR');
  AqryLan.SQL.Add(' FROM LANCON B,');
  AqryLan.SQL.Add('  (SELECT A.CON_EMPLAN, A.CON_TIPLAN, COALESCE(CON_TABELA,"") CON_TABELA, CON_INCDOC');
  AqryLan.SQL.Add('   FROM LANCON A');
  AqryLan.SQL.Add('   WHERE AUTOINCREM = :AUTOINCREM');
  AqryLan.SQL.Add('   AND (CON_CONCRE IS NULL OR CON_CONDEB IS NULL)) C');
  AqryLan.SQL.Add(' WHERE B.CON_INCDOC = C.CON_INCDOC');
  AqryLan.SQL.Add(' AND B.CON_TIPLAN = C.CON_TIPLAN');
  AqryLan.SQL.Add(' AND COALESCE(B.CON_TABELA,"")  = C.CON_TABELA');
  AqryLan.SQL.Add(' AND B.CON_EMPLAN = C.CON_EMPLAN');

  AqryLan.ParamByName('AUTOINCREM').AsString := AAutoInc ;
  AqryLan.Open ;

  if AqryLan.RecordCount > 1 then
  begin
    Result := True;
    while not (AqryLan.Eof) do
    begin
      SetLength(AarrAutoIncs, Length(AarrAutoIncs)+1);
      AarrAutoIncs[High(AarrAutoIncs)] := AqryLan.FieldByName('AUTOINCREM').AsString;
      AqryLan.Next;
    end;
  end;
end;

procedure pMostraLancamentosDependentesDaPartidaSimples(Const AqryLan: TUniQuery);
var
  LfrmMemoInfo: TfrmMemoInfo;
begin
  pCriarFormularios(TfrmMemoInfo, LfrmMemoInfo) ;
  try
    LfrmMemoInfo.edtInfo.Lines.Add('Emp Data Lanc. Tipo Descrição                 Conta Cred. Conta Deb. Valor        Historico');
    LfrmMemoInfo.edtInfo.Lines.Add('---------------------------------------------------------------------------------------------------------------------------------------------------');

    AqryLan.First;
    While not AqryLan.Eof do
    begin
      LfrmMemoInfo.edtInfo.Lines.Add(
       fPreencheEspaco(AqryLan.FieldByName('CON_EMPLAN').AsString, 3, true, ' ')    + ' ' +
       FormatDateTime('dd/mm/yyyy', AqryLan.FieldByName('CON_DTALAN').AsDateTime)   + ' ' +
       fPreencheEspaco(AqryLan.FieldByName('CON_TIPLAN').AsString, 4, true, ' ')               + ' ' +
       fPreencheEspaco(AqryLan.FieldByName('CON_DESVAL').AsString, 25, true, ' ')              + ' ' +
       fPreencheEspaco(AqryLan.FieldByName('CON_CONCRE').AsString, 11, true, ' ')              + ' ' +
       fPreencheEspaco(AqryLan.FieldByName('CON_CONDEB').AsString, 10, true, ' ')              + ' ' +
       fPreencheEspaco(fFloatToSQL(AqryLan.FieldByName('CON_VALLAN').AsFloat ), 12, true, ' ') + ' ' +
       AqryLan.FieldByName('CON_HISTOR').AsString
      );
      AqryLan.Next;
    end;

    LfrmMemoInfo.btnSair.Visible := False;
    LfrmMemoInfo.ShowModal ;
   finally
    pFreeAndNil(LfrmMemoInfo) ;
  end ;
end;

function fVerificaDeletaFechamentoFecFisFecFinCadFec(ADtaIni, ADtaFin: TDate; AstrCodEmp, AstrCodEmps: String; var AstrMsgErro: string ): boolean;
var
    LqryLog: TUniquery;
    LtabFecFisExiste, LtabFecFinExiste, LtabCadFecExiste: boolean;
begin
  result := true;
  LtabFecFisExiste := fTabelaExiste('FECFIS');
  LtabFecFinExiste := fTabelaExiste('FECFIN');
  LtabCadFecExiste := fTabelaExiste('CADFEC');

  if LtabFecFisExiste or LtabFecFinExiste or LtabCadFecExiste then
  begin
    LqryLog := fCriaQuery(nil);
    try
      LqryLog.Close;
      LqryLog.SQL.Clear;
      if LtabFecFisExiste then
      begin
        LqryLog.SQL.Add('SELECT FEC_CODEMP, FEC_DTAREF  ') ;
        LqryLog.SQL.Add('FROM FECFIS') ;
        if fEmptyStr(AstrCodEmps) then
          LqryLog.SQL.Add('WHERE FEC_CODEMP = :EMPGRV ')
        else
          LqryLog.SQL.Add('WHERE FEC_CODEMP IN (' + AstrCodEmps + ') ') ;
        LqryLog.SQL.Add('AND FEC_DTAREF BETWEEN :DTAINI AND :DTAFIN') ;
        LqryLog.SQL.Add('AND FEC_DTAREF = LAST_DAY(FEC_DTAREF)') ;
      end;
      if LtabFecFinExiste then
      begin
        if LqryLog.SQL.Count > 0 then
          LqryLog.SQL.Add('UNION') ;
        LqryLog.SQL.Add('SELECT FEC_CODEMP, FEC_DTAREF ') ;
        LqryLog.SQL.Add('FROM FECFIN') ;
        if fEmptyStr(AstrCodEmps) then
          LqryLog.SQL.Add('WHERE FEC_CODEMP = :EMPGRV ')
        else
          LqryLog.SQL.Add('WHERE FEC_CODEMP IN (' + AstrCodEmps + ') ') ;
        LqryLog.SQL.Add('AND FEC_DTAREF BETWEEN :DTAINI AND :DTAFIN') ;
        LqryLog.SQL.Add('AND FEC_DTAREF = LAST_DAY(FEC_DTAREF)') ;
      end;
      if LtabCadFecExiste then
      begin
        if LqryLog.SQL.Count > 0 then
          LqryLog.SQL.Add('UNION') ;
        LqryLog.SQL.Add('SELECT FEC_CODEMP, LAST_DAY(STR_TO_DATE(CONCAT(FEC_ANOMES,"/01") , "%Y/%m/%d")) AS FEC_DTAREF ') ;
        LqryLog.SQL.Add('FROM CADFEC') ;
        if fEmptyStr(AstrCodEmps) then
          LqryLog.SQL.Add('WHERE FEC_CODEMP = :EMPGRV ')
        else
          LqryLog.SQL.Add('WHERE FEC_CODEMP IN (' + AstrCodEmps + ') ') ;
        LqryLog.SQL.Add('AND STR_TO_DATE(CONCAT(FEC_ANOMES,"/01") , "%Y/%m/%d") BETWEEN :DTAINI AND :DTAFIN') ;
      end;

      LqryLog.ParamByName('DTAINI').AsDate := ADtaIni;
      LqryLog.ParamByName('DTAFIN').AsDate := ADtaFin;

      if fEmptyStr(AstrCodEmps) then
        LqryLog.ParamByName('EMPGRV').AsString := AstrCodEmp;

      LqryLog.Open;

      while not LqryLog.Eof do
      begin
        if not fVerificaDeletaFechamento(LqryLog.FieldByName('FEC_CODEMP').AsString,
                                         LqryLog.FieldByName('FEC_DTAREF').AsDateTime,
                                         AstrMsgErro) then
        begin
          result := false;
          exit;
        end;

        LqryLog.Next;
      end ;
    finally
      FreeAndNil(LqryLog);
    end;
  end;

end;

initialization
  VC_intTamCadIte := 0;
  VC_intTamCadEve := 0;
  VC_intTemFecCon := -1;
  dicResultadoQuerySimplesCont := TDicResultadoQuerySimplesContabilidade.Create;
  dicVersaoAutcomCont := TDictionary<String,String>.Create();
  VC_StrVersaoContabilidade := '' ;
  VC_CarregaPlanoDeContasPorEmpresaInterno := Nil ;
  VC_SalvaPlanoDeContasPorEmpresaInterno := Nil ;
  VC_VerificaDeletaFechamento := Nil ;

finalization
  FreeAndNil(dicResultadoQuerySimplesCont);
  FreeAndNil(dicVersaoAutcomCont);

end.
