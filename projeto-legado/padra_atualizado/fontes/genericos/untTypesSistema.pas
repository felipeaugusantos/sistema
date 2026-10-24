{*************************************}
{* TELA COMPARTILHADA EM DLLs        *}
{*************************************}
{* Não deve haver códigos nessa unit *}
{* Exclusiva pata Types, Records e   *}
{* objetos de intefaces.             *}
{*************************************}
{* Podem ser declarada units no uses *}
{* contanto que não dependa de telas.*}
{**********************************AF*}
unit untTypesSistema;

interface

uses
  {$IFDEF LINUX}
  {$ELSE}
  frxClass, frxDBSet, UniClientDataSet, Vcl.Menus,
  Forms, EditFocus, StdCtrls, DBEditFocus,
  cxProgressBar, Controls, Grids, DBGridCitel, DBGrids,
  winapi.messages, TypesLayoutPedidoCompra,
  {$ENDIF}
  System.Classes, Data.DB, Uni, System.Types, System.SysUtils,
  System.strUtils, System.Generics.Collections, System.SyncObjs, System.DateUtils;

type TTipoArquivo = (tpaNone, tpaNormal, tpaPDF, tpaExcel, tpaTexto, tpaImagem, tpaImagemJpeg, tpaImagemJpg, tpaImagemPng, tpaXml, tpaDoc, tpaImagemBmp);

type
  TRecArquivosGatilhos = record
    Titulo: String;
    Arquivo: String;
    TipoArquivo: TTipoArquivo;
    Url: String;
    ArmazenadoNoBucket: Boolean;

    constructor Create(ATitulo, AArquivo, AUrl: String; ATipoArquivo: TTipoArquivo = tpaPDF; AArmazenadoNoBucket: Boolean = False);
  end;

  TDestinatarioWhatsapp = Class
  public
    FAutIncCtt: String;
    FTo: String;
    FIDFila: String;

    constructor Create;
  end;

  TTipoFiltroDataAnaliseProducao = (tfdNenhum, tfdPrevisaoPedido, tfdEntregaItem);

type
  TRecGatilhoImediato = record
    Assunto: String;
    Mensagem: String;
    Arquivos: TArray<TRecArquivosGatilhos>;
    Json: String;
    OperadorEnvio: String;
    NumeroWhatsapp: String;
    Email: String;

    constructor Create(AAssunto: String;
                       AMensagem: String;
                       AArquivos: TArray<TRecArquivosGatilhos>;
                       AJson: String;
                       AOperadorEnvio: String;
                       ANumeroWhatsapp: String;
                       AEmail: String);
  end;

Type
  TDocumentoFator = Record
    strEmpDoc: String;
    strEspDoc: String;
    strNumDoc: String;
    strCliDoc: String;
    strDocOri: String;
  End;

Type
  TAoConfirmarDocumento = function (Sender: TObject; strAutInc: String): Boolean of object;

  TCfgEmpresaPagamentoAntecipado = (tcepaEmpresaLogada, tcepaTodas, tcepaCNJRaizEmpresaLogada);

type
  TTiposDeFrete = (tfpTodos = 0, tfpCif = 1, tfpFob = 2, tfpTerceiros = 3, tfpSemFrete = 4, tfpTransporteProprioRemetente = 5, tfpTransporteProprioDestinatario = 6);
  TArrTiposDeFrete = Array Of TTiposDeFrete;

  TCallPedidoCompraAlt = Record
    appHandle: THandle;
  End;

Type
  ExceptionAutCom = Class(Exception);
  ExceptionTintaNaoDisponivel = Class(Exception);
  ExceptionAutComSugerirVendaPresencial = Class(Exception);
  ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente = Class(Exception);
  ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada = Class(Exception);
  ExceptionAutComErroAoIncluirMovimentacaoProgramada = Class(Exception);
  ExceptionImportacaoFulFillmentNaoImportouVendaReferenteDocumentoRetornoSimbolico = Class(Exception);
  ExceptionImportacaoFulFillmentNaoGravouPedidoDeEnderecamento = Class(Exception);
  ExceptionImportacaoFulFillmentRemessaComCodigoPrincipalEstrutura = Class(Exception);
  ExceptionQtdRomaneio = Class(Exception);
  ExceptionAuditoria = Class(Exception);

  TTipoSeparacaoGondolaImpressaoFiltro = (tsgiffTodos, tsgiImpresso, tsgiffNaoImpresso);

  TSeparacaoGondolaFiltro = record
    strOperadorSolicitacao: string;
    strOperadorEfetivacao: String;
    TipoSeparacaoGondolaImpressaoFiltro: TTipoSeparacaoGondolaImpressaoFiltro;
    dtaDataEfetivacao: TDate;
    strListaSolGon: String;
    blnFiltraApenasListaSolGon: Boolean;
  End;

  TTipoPesquisaAmarrarCartao = (tpaEmpresa, tpaEmpresaNull, tpaEmpresaNotNull);

  TprocessaReimpressao = procedure (ALocal: String; ASeparacaoGondolaFiltro: TSeparacaoGondolaFiltro) of object;
  TfuncTemFecMes = function (const AstrCodEmp: String; const AdtaFechamento: TDateTime): Boolean  of object ;

  TfuncCadastroCartaoTefConferencia = function(const AConfBandeira, AConfAdquirente: Boolean): Boolean of object ;

  TParametrosRelatorio = Class
  Private

  Public
    strCampoRetorno,
    strValorRetorno: String;

    blnRetornaCampoComEnter: Boolean;

    strMensagemRodape: String;
  End;

Type
  TOrdenaMnu = record
    blnInsRiscos,
    blnOrdSubMnu,
    blnOrdenados: Boolean;
End;

type
  TfncPermitirEditarConfiguracao = reference to function(const strCodigoConfiguracao : String) : Boolean;

type
  TTipoGatilho = (notEmail, notSMS, notWhatsapp, notOpiniOne);

  TProcedureDxInitializeOrFinalize = procedure(); stdcall;

  TTipLan = (tlEntrada, tlSaida, tlCtr, tlCtp);
  TTabelaLan = (ttMovger, ttNotGer, ttCadFis);
  TModoLan = (mlInclusao, mlEstorno, mlCancelamento);
  TrecRegistroContabilidade = record
    strClafis: string;
    strEspDoc: String;
    ttpTabela: TTabelaLan;
    strSeqGer: string;
    mlModLan: TModoLan;
    strEmpLan: String;
  end;

  TCalculoPreMedAgrup = Record
    SaldoAnterior: Double;
    PrecoMedioAnterior: Double;
    strCodIte: String;
    blnEncontrado: Boolean;
    fltPreMedOriginal: Double;
    fltPreUltOriginal: Double;
    fltPreImpUltOriginal: Double;
    strSeqDetOriginal: String;
    strSeqGer: String;
  End;

   TTipoQtdItePedido = (tqpCompleto, tqpPendente, tqpNaoExibir);

  TCalculoIpiNotImp = (cipiNotaImpSubDesc, cipiNotaImpDespesasAcessorias,cipiNotaImpSomarII);
  TConjCalculoIpiNotImp = set of TCalculoIpiNotImp;

  TArrCalculoPreMedAgrup = array of TCalculoPreMedAgrup;

  TCfgDisparaEmailPedidoDeCompraAutomatico = procedure (optCodigo: String) of object;

  TCalculoPrecoMediAgrup = class
  private
    ArrCalculoPreMedAgrup: TArrCalculoPreMedAgrup;
    function GetPreMedCalculado(Index: string; AutInc: String): TCalculoPreMedAgrup;
    function fGetIndex(ACodIte: String): integer;
  public
    strCodIteAtual: String;
    strSeqGerAtual: String;
    procedure pSetPreMedOri(ACodIte: String;
                            fltValorPreMed,fltPreUltOriginal, fltPreImpUltOriginal : Double;
                            strSeqDetOriginal: string);
    procedure pAdd(CalculoPreMedAgrup: TCalculoPreMedAgrup);
    property CalculoPreMed[index: string; AutInc: String]:TCalculoPreMedAgrup  read GetPreMedCalculado;
  End;

  TArrString = Array Of String;

  TRetornoRelatorio = Class(TComponent)
  private

  public
    intAlturaTela,
    intLarguraTela: Integer;

    arrParametrosInvisiveis: TArrString;

    blnPaiEmEdicao,
    blnExecutandoPeloBotao: Boolean;

    constructor Create(Owner: TComponent); reintroduce;

  published

  End;

{***************************************}
{* REPRESENTA UM LOG DE LIBERAÇÃO DO   *}
{* FAT VENDAS ---- PS. EU TO COM MUITO *}
{* SONO AAAAAAAAAAAAaaaaaaaa  ZZZZZZ.. *}
{************************************AF*}
Type
  TLogLib = Record
    strDirAce: String;
    strDirAceAuxiliar: String;
    strOpeLib: String;
    strCodVen: String;
    strCodIte: String;
    intAutInc: Integer;
    dtaDtaCad: TDateTime;
    dtaHraCad: TDateTime;
    dtaDtaLib: TDateTime;
    dtaHraLib: TDateTime;
    dtaDtaEnv: TDateTime;
    dtaHraEnv: TDateTime;
    strMsgSen: String;
    strObserv: String;
    strNumLib: String;
    blnInsLog: Boolean;
    strInfBlo: String;
    blnIgnInc: Boolean;
    strinfoF4: String;
    strTitulo: String;
    strCodLib: String;
End;

Type
  TArrLogLib = Array Of TLogLib;

Type
  TLogAvi = record
    strMsgSen,
    strDirAce,
    strDirAceAuxiliar: String;
    strNumLib,
    strInfBlo, //mensagem exibida ao usuário bloqueado
    strInfLib, //mensagem exibida ao usuário da liberação
    strMenObs,
    strCodOpe,
    strCodDig,
    strCodIte: String;
    intAutInc: Integer;
    blnIgnInc: Boolean;
    blnAviso_: Boolean;
    strMsgJso: String;
    strOpeLib: String;
  end;

Type
  TArrLogAvi = Array Of TLogAvi;

Type
  TCteMov = record
    strMOV_MOVDET: String;
    fltMOV_CONFRE: Double;
    fltMOV_ALQFRE: Double;
  End;

  TArrCteMov = Array of TCteMov;
  TFunctionGetFiltros = function :String of object;
  TProcSetarParametros =  procedure(qryParam: TUniQuery) of object;

  TDadosMadeira = Record
    fltQtdPec: Double;
    fltComPec: Double;
    fltLarPec: Double;
    fltEspPec: Double;
    strAparel: String;
    fltPerApa: Double;
    strBenefi: String;
    fltPerBen: Double;
  end;

  TTipoAvisoNaExpedicaoDePedidosPendentesParaOMesmoCliente = (taeNaoExibirAviso,
                                                              taeSimConsiderandoSomentePedidosQueEstejamNaExpedicao,
                                                              taeSimConsiderandoTodosOsPedidosAbertosParaOCliente);

  TTipoAvisoNaExpedicaoDePedidosPendentesParaOMesmoClienteHelper = record helper for TTipoAvisoNaExpedicaoDePedidosPendentesParaOMesmoCliente
    function  GetValue : String;
    procedure SetValue(Value : String);
  end;

  TTipoReceitaGnre = (ST, FCP, DIFAL, NENHUM);

  TTipoOpcaoDeRetencaoISS = (torReterISSDoCadastroDoCliente         = 1,
                             torReterISSDoCadastroDaCidadeDoCliente = 2);

  TTipoOpcaoDeTrava = (totTraval                   = 1,  totDescontoMaximo             = 2, totMargemMinimaPorProduto   = 3,
                       totMargemMinimaPorDocumento = 4,  totDescontoMaximoPorAtividade = 5, totMargemMinimaPorAtividade = 6);

  TTipoOpcaoDeTravaHelper = record helper for TTipoOpcaoDeTrava
    function GetValue: String;
    function fOpcaoDeTravaEhPorAtividade : Boolean;
  end;

  TConsultas = Record
    strCodigo: String;
    strDescri: String;
  End;

  TConsultasArray = Array Of TConsultas;

{$IFDEF LINUX}
type
  TCaption = string;

type
  TControl = class
  end;

type
  TPanelCx = class
  end;
{$ENDIF}

type
  {$IFDEF LINUX}
  TcxProgressBar = class
  private type
    TProperties = record
      Max: Double;
    end;
  public
    Properties: TProperties;
    Position: Double;
    Visible: Boolean;
    class procedure pSetMax(AValue: Integer);
    class procedure pStep;
  end;
  {$ENDIF}

  TFunctionFormGravando = function(pgbProgresso: TcxProgressBar): Boolean Of Object;

  {$IFDEF LINUX}
  {$ELSE}
  TArrFrxDBDataSet = Array Of TfrxDBDataset;
  TArrFrxUserDataSet = Array Of TfrxUserDataSet;
  TpPlanoDeContasPorEmpresa = procedure(strValorChave: String; strTabela: String; strContaUnica: String; State: TDataSetState; AcdsNCO: TUniClientDataSet = nil; AblnAlteracaoDadosExterna: Boolean = False);
  TfVerificarPlanoDeContasPorEmpresa = function(strValorChave: String; strTabela: String; strContaContabil: string; AcdsNCO: TUniClientDataSet = nil): boolean ;
  TpCarregaPlanoDeContasPorEmpresa = procedure(const AstrTabela, AstrValorChave: String; var AcdsNCO: TUniClientDataSet);
  TpSalvaPlanoDeContasPorEmpresa = procedure(const AstrTabela, AstrValorChave: String; const AcdsNCO: TUniClientDataSet);
  TfCriaEstruturaCdsNCO = function(AOwner: TComponent): TUniClientDataSet;
  TfncTravaUtiCred = function(cdsCredit: TUniClientDataSet): Boolean Of Object;
  TProcSelectNext = procedure(CurControl: TWinControl; GoForward, CheckTabStop: Boolean) of object;
  TFuncValidaCampos = function(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean of object;

  TFuncPesquisaEmpresa = function (ASelf    : TForm;                           {* Formulário                                  *}
                                   edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                                   edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                                   Var chrKey: Char): Boolean  of object;

  TCalculoBaseICMSNotaImp = (cbiniII, cbiniIPI, cbiniPIS_COFINS, cbiniSiscomex, cbiniAFRMM, cbiniDespeasAduaneira);
  TConjCalculoBaseICMSNotaImp = set of TCalculoBaseICMSNotaImp;

  TFuncPesquisar = function (ASelf     : TForm;                          {* Formulário         *}
                             edtCodigo: TCustomEdit;                     {* Edit do Código     *}
                             edtDescri: TEditFocus;                      {* Edit Descrição     *}
                             Var chrKey: Char;
                             ACodPesquisa: String): Boolean of object;

  TFuncPedirLiberacao = Function (ADirAcesso:String; AMsgSenha:String;ATexto: String): Boolean of object;
  TFuncCriarQueryDLL = Function: TUniQuery of object;
  TFuncIncluirCartaoVenda = function (AAutoincremExtratoVenda: String): Boolean of object;
  TFuncAlterarCartaoVenda = function (AAutoincremCartao: String): Boolean of object;
  TProcChamaConciliacaoCartoes = procedure(ANomCon: String) of object;

  IEsmaecer = interface
  ['{93563DC5-5179-49C0-9FED-5DFCC17EBD2C}']
    procedure pEsmaecer(AForm: TForm);
    procedure pDesmaecer;
  end;

  ILogThr = Interface
  ['{E3136D1C-8539-4725-9D31-263F1D1F1EFC}']
    function Enter(const AMessage: string = ''): ILogThr;
    function Exit(const AMessage: string = ''): ILogThr;
  end;

  IThreadConnections = interface
  ['{89DB3625-F504-44DE-A895-FC354FE23200}']
    function GetThreadConnection(intThreadId: Cardinal; AThreadInfo: string): TUniConnection; overload;
    function HasThreadConnection(intThreadId: Cardinal): Boolean;
    function RemoveThreadConnection(intThreadId: Cardinal): Boolean; overload;
    function GetLocalConnection(AMethodName: string): TUniConnection; overload;
    function RemoveLocalConnection(AConn: TUniConnection): Boolean; overload;
    function GetAllMySqlStatementsHistory: string;
    function GetThreadConnectionInfo(intThreadId: Cardinal): string;
  end;

  TDatabaseParameters = record
    Database : String;
    UserName : String;
    Password : String;
    Port : Integer;
    Server : String;
    VendorLib : String;
    Driver : String;
    IsolationLevelSQLInstruction: String;
  End;

  TCellGrid = class(Grids.TCustomGrid);

  TDBGridCellHint = class(THintWindow)
  private
    FColumns: TArray<String>;
    FOriginalHint: String;
    FDBGrid: TDBGridCitel;
  protected
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateGridCellHint(ADBGrid: TDBGridCitel; AColumns: TArray<String>);
    procedure DoActivateHint();
    procedure MouseToCell(X, Y: integer; Var ACol, ARow: LongInt);
  end;

  TpGravarPlanoContasAutomatico = procedure(qryTabela: TUniQuery; dbePlaNco: TDBEditFocus; strFieldConta: string; strNomeConta: string);
  TpGravarPlanoContasAutomaticoParaCadaEmpresa = procedure(qryTabela: TUniQuery; dbePlaNco: TDBEditFocus; strFieldConta: string; strNomeConta: string);

  TTipoConsultaSimples     = (conSimples, conParaBaixas, conTransfCx);

  TfPesqConfiguracaoRel = reference to function(opcTipCfg : TTipoConsultaSimples;
                                                Self      : TForm;                       {* Formulário                                  *}
                                                edtCodigo : TCustomEdit;                 {* Edit do Código                              *}
                                                edtDesPor : TEditFocus;                  {* Edit da Descrição do item                   *}
                                                qryTabela : TUniQuery;                   {* Query                                       *}
                                                Var chrKey: Char;                        {* Key                                         *}
                                                Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                                                strWhere  : String;                      {* Where                                       *}
                                                blnConSim : Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                                strTitulo : String = 'Configuração de Relatórios'): Boolean;
  TfPesqOperador = reference to function(Self     : TForm;                          {* Formulário                                  *}
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
                                         blnPermissaoTransferencia: Boolean = False;           {* Somente Operadores com permissão de receber transferencia *}
                                         blnPermissaoBalancoColetor: Boolean = False): Boolean;{* Somente Operadores com permissão de balanço de estoque - coletor*}
  TpSetFocus = reference to procedure(SenderUnico: TWinControl; Form: TCustomForm);

  TfPesqPlanoContabil= function(Self     : TForm;
                                edtCodigo: TCustomEdit;
                                edtDescri: TEditFocus;
                                qryTabela: TUniQuery;
                                Var chrKey: Char;
                                Var arrSel: TConsultasArray;
                                blnConSim: Boolean = True;
                                strTplAco: String = ''): Boolean;
  {$ENDIF}

  TProcedureAjuda = procedure Of Object;
  TTipoConsulta = (tpcVazio, tcpPrimeira, tcpOrdemFiltro);
  TTipoConsultaTinta = (tpcVenda, tpcGeral);
  TTipoFrete = (tpfEntrada, tpfSaida);
  TTipoDocFrete = (tpdfIndefinido,tpdfCompra, tpdfVenda, tpdfDevolucaoVenda, tpdfDevolucaoCompra);
  TTipoOrigemEtiquetaAbreItens = (toeabiPrecificao, toeabiOutros);
  TTipoRateioFrete = (trfPropValorItem, trfPropPesoItem, trfPropQtdItem, trfDefinirEntrada, trfInformarPercentuais, trfIndefinido);
  TTipoChamadaProcesso = (tcpMaximizado, tcpNormal, tcpOculto);
  TipoOperacaoPreNota = (opeConferencia, opeCancelaConferencia, opeCancelaPreNota);
  TTipoPessoaFideliza = (tpfAutonomo, tpfFisica, tpfJuridica);
  TSetaParametros = procedure (qryConsulta: TUniQuery) Of Object;
  TFuncExisteDireitoAcesso = function(ADirAce: String): Boolean of object;
  TTipDocOri = (TTDONenhum, TTDODocConf, TTDOEntFut, TTDOPedOrc, TTDODetFat, TTDOFatFat, TTDONotFat);
  TTipoRegime = (trLucroReal, trLucroPresumido, trSimplesNacional, trNenhum);
  TTipoCfop = (tcCFOPNormal, tcCFOP922, tcCFOP117);
  TTipoConfigAtiva = (caPIS, caCOFINS, caICMS, caIPI, caSubsTri,
                      caFrete, caJurosVendaBruta, caDescontoVendaBruta,
                      caJurosDespesasFinanceiras, caDescontoDespesasFinanceiras, caNenhum);

  TProcedureAbreTelaPrecos = procedure(strCodIte: String) Of Object;

  TFuncVerificaAcessoSistema = reference to function(strNomeForm: String; strCodOpe: String = ''): Boolean;

  TTipoItemDoPedidoExp = (opItemInseridoNoPedido, opSubItemDeItemInseridoNoPedido);
  TTipoPedidoPorQuantidadeDeProdutosExp = (opPedidosDeUnicoItem, opPedidosDeVariosItens);
  TTipoQuantidadeDoItemNoPedidoExp = (opQuantidadeUmItem, opQuantidadeDiferenteDeUmItem);

  TTipoMatrizDesmembrada = (matDesNenhum,
                            matDesServico,
                            matDesRetira,
                            matDesEntregaImediata,
                            matDesEntregaFutura,
                            matDesProdutoDeBrinde,
                            matDesServicoDeBrinde,
                            matPrioridade);

  TArrTipoMatrizDesmembrada = Array Of TTipoMatrizDesmembrada;
  TTipoAltPreEti = (tpPrecoCusto, tpPrecoVenda, tpTodos);
  TTipoPercentualTributo = (ptAlqSimpNac, ptAlqIRPJ, ptAlqCSLL);
  TTipEnt = (tenCodigo, tenSenha, tenBarras);
  TTipEbx = (tebCodigo, tebSenha, tebBarras);
  TInsDoc = (idoDocumento, idoBarras);
  TTipMov = (tmvRetira, tmvEntregaImediata, tmvEntregaFutura, tmvIndefinido);
  TTipDir = (tdiAutcom, tdiAutBan, tdiAutTin, tdiAutcomRemocao);
  TTipoAgrupF11 = (taAbortou, taAviso, taNone);
  TChamaRotina = (crAgrupamento, crBaixaReceberCaixa, crNoneTela);
  TTipoValidaIcmDes = (idMotivo, idIcms, idNone);
  TTipProCombo = (pcoAtivacao, pcoCombo, pcoSimilar);
  TTipEle = (telLinhaGrupo, telMarca, telFornecedor, telGrupoProd, telGrupoPreco);
  TTipBan = (banCombo, banPromocao, banEstrutura);
  TTipoBaixaControleEntregadores = (tpbceIndefinida, tpbceCega, tpbceRapida);
  TProcReconectarModulo = reference to procedure(strErro: String);
  TProcMensagemErroRede = reference to procedure(strTrace: String);
  TProcReconectarModuloDiscreta = reference to procedure(strErro, strStack : String);
  TProcMensagemOK = procedure(strmensagem: string);
  TSituacaoTributariaPisCofins = (sitPisCofinsTributado, sitPisCofinsIsento, sitPisCofinsSuspenso, sitPisCofinsDiferido, sitPisCofinsTributadoAliquotaZero);
  TTipoEnvioFornecedorGarantia = (tefNulo, tefDevolucao, tefConserto);
  TFiltroOndaSeparacao = (fosSelecaoPedidosGeracaoOnda, fosFaturamentoLiberacaoOnda, fosNaoUtilizarOnda);
  TTipoProcessosFlxConEqu = (tprNumOS, tprDadosOS, tprDocsFiscais, tprDefPrdSer, tprOrcamento, tprEnviarCliente, tprInterromperOrc,
    tprAprovar, tprReprovar, tprCancelarRep, tprRealizarMan, tprInterromperMan, tprManutencao, tprCancelarMan, tprApontamento, tprArmazenar,
    tprRetirar, tprGarantia, tprFinalizacaoOS, tprCancelarArm, tprBaixarOSDes, tprCancEntregaEquip, tprTaxaArmazenamento, tprComunicacoesInternas);
  TTipoImpressaoFlxConEqu = (fpConsultar, fpImprimir, fpEtiqueta, fpTermoDev, fpEditar, fpTermoResp, fpOrdExecucao);
  TTipoDocsFiscaisFlxConEqu = (tpEntrada, tpSaida);
  TTipoFatuPDConEqu = (tpFaturado, tpBaixado, tpNaoFaturado);

  TTipoObservacoes = (tpoDadosAdicionaisNF, tpoObservacoesExpedicao, tpoObservacoes, tpoFeriados, tpoOrientacoes);
  TOpcSelecao = (opcMarcar, opcDesmarcar, opcInverter);
  TOrigemAlteracaoFrete = (oafIndefinido, oafExpedicao, oafBaixaEntregaFutura);
  TOrigemRomaneio = (torIndefinido, torBaixaRomaneio, torRomaneioInclusao);
  TTipoOperacaoRemessa = (toTodos, toRemessa, toTransferencia, toOutrasSaidas, toColetor);

  TProcMostraMensagem = procedure(strTitulo, strMensagem, strCodIte: string) of object;

  TTipoObservacoesHelper = record helper for TTipoObservacoes
    function GetValue: Integer;
  end;

  TRegistroConsumidor = Record
    strCliNom,
    strCliEnd,
    strCliBai,
    strCliCep,
    strCodCid,
    strCliCid,
    strCliEst,
    strCliTel,
    strCliCgc,
    strCliIes,
    strCli_Rg,
    strCliEml: String;
    intCgcCpf: Integer;
    strCodReg: String;
    strCodAti: String;
    strCodCac: String;
  End;

  TInformacaoDeDestinoManifestoEletronico = (tidInformadoEmCadaNF, tidDestinoUnico);

  TInformacaoDeDestinoManifestoEletronicoHelper = record helper for TInformacaoDeDestinoManifestoEletronico
    function GetValue        : Integer;
    function GetValueDefault : Integer;
    procedure SetValue(Value : Integer);
  end;

  TPermissaoAlteracaoDePedidosQuePossuemAdiantamento = (papSimTodosOsCampos,
                                                        papSimTodosOsCamposComExigenciaQueOValorFiqueOMesmo,
                                                        papSimSomenteReduzindoAQuantidadeOuEliminandoProdutos,
                                                        papNaoNenhumaInformacao);

  TPermissaoAlteracaoDePedidosQuePossuemAdiantamentoHelper = record helper for TPermissaoAlteracaoDePedidosQuePossuemAdiantamento
    function GetValue: String;
  end;

  TTipoDefinicaoDoVendedorNosPedidosGeradosDeTE = (tdvOperadorLogadoAgrupandoTodasAsSolicitacoes                            = 1,
                                                   tdvOperadorCadastradoAgrupandoTodasAsSolicitacoes                        = 2,
                                                   tdvOperadorSolicitanteAgrupandoTodasAsSolicitacoesPorVendedorSolicitante = 3);

  TTarefasHerancaCadEmpresas = (thcITEGER, thcACAGER, thcCFGSIS, thcCFGTIN, thcCFGREL, thcLAYETI,
                                thcCNF_NFE,thcCFGEMP, thcCADLOT, thcCNFBOL, thcCONEMP, thcITEEMB, thcCADCAR);

  TTipoTrava = (tpNaoAvisa = 0, tpAvisa = 1, tpTrava = 2);

  TTarefasHerancaCadEmpresasHelper = record helper for TTarefasHerancaCadEmpresas
    function GetValue: String;
    function GetSQL: String;
  end;

  TDespesasOperacionaisComplementar = (docNaoUtilizar, docFormaComplementar, docSubstitutiva);

  TDespesasOperacionaisComplementarHelper = record helper for TDespesasOperacionaisComplementar
    procedure SetValue(AValue : String);
    function  GetValue : TDespesasOperacionaisComplementar;
  end;

  TPrintBClick = procedure(Sender: TObject) of Object;
  TOnPreview = procedure(Sender: TObject) of Object;

  TPontoImpressao = record
    Nome: String;
    Impressora: String;
    TipoImpressora: String;
    Status: String;
    NomeFila: String;
    ImprimirParaArquivo: Boolean;
    ExportacaoPDF: Boolean;
    ExibirSomenteMaquinaServico: Boolean;
    Existe: Boolean;
  end;

  IReport = interface
    ['{CE47EE24-0DDF-4856-AB50-0CF90D412D5E}']
    procedure PrepareReport;
    procedure ShowReport;
    procedure Print;
    procedure SaveToFile(AFile: String);
    procedure ExportarParaPDF(ATitle: String);
    function Printer: String;
    function Copies: String;
    function Collate: String;
    function PageNumbers: String;
    function PrintMode: String;
    function PrintOnSheet: String;
    function PrintPages: String;
    function PagesCount: Integer;
    function GetPrintBClick: TPrintBClick;
    procedure SetPrintBClick(AProc: TPrintBClick);
    procedure SetOnPreview(AProc: TOnPreview);
  end;

  TProcPreviewReport = procedure(const APrograma, ADescricao: String; AReport: IReport) of object;

  TBotaoSQLTrace = (tbInicio, tbPausa, tbSalva, tbShow, tbHide);
  TTipoSQLTrace = (ttSimples, ttCompleto, ttPerformance);
  TStatusSQLTrace = (stIniciado, stPausado);

  ISQLTrace = interface
    function GetStackTrace: Boolean;
    function GetCabecalho: Boolean;
    function GetCountSQL: Integer;
    function GetStatus: TStatusSQLTrace;
    function GetTipo: TTipoSQLTrace;
    function GetTempFile: String;
    function GetAutenticado: Boolean;

    procedure SetStackTrace(const Value: Boolean);
    procedure SetCabecalho(const Value: Boolean);
    procedure SetCountSQL(const Value: Integer);
    procedure SetStatus(const Value: TStatusSQLTrace);
    procedure SetTipo(const Value: TTipoSQLTrace);
    procedure SetTempFile(const Value: String);
    procedure SetAutenticado(const Value: Boolean);

    procedure pIniciaTrace;
    procedure pPausaTrace;
    procedure pSalvaTrace;
    procedure pIncCountSQL;

    procedure pWrite(AText: String);

    property StackTrace: Boolean read GetStackTrace write SetStackTrace;
    property Cabecalho: Boolean read GetCabecalho write SetCabecalho;
    property CountSQL: Integer read GetCountSQL write SetCountSQL;
    property Status: TStatusSQLTrace read GetStatus write SetStatus;
    property Tipo: TTipoSQLTrace read GetTipo write SetTipo;
    property TempFile: String read GetTempFile write SetTempFile;
    property Autenticado: Boolean read GetAutenticado write SetAutenticado;
  end;

  ITraceViewer = interface
  ['{03A12EC3-EBBF-4710-96DD-7DEBFF492D42}']
    procedure Show();
    procedure Stop();
    procedure LogSQL(ALog: String);
    procedure LogTimer(AInfo: String);
    procedure SetQueryEvents(ADataSet: TUniQuery);
    procedure SetSQLTrace(AObj: ISQLTrace);
    function Visible(): Boolean;
    function EnabledSQLLog(): Boolean;
  End;

{$IFNDEF LINUX}
Type
  TRecModulosAutcom = Record
    Banco: TUniConnection;
  end;
{$ENDIF}

Type
  TImpressaoComSemPrecoOrPd = (impComPrecoGeral,
                               impSemPrecoGeral,
                               impComPrecoComMarca,
                               impComPrecoSemMarca,
                               impSemPrecoComMarca,
                               impSemPrecoSemMarca,
                               impSemPrecoSimplificado);

  TImpressaoComSemPrecoOrPdHelper = record helper for TImpressaoComSemPrecoOrPd
    function ToString: string;
    function FromString(AValue: string): TImpressaoComSemPrecoOrPd;
  end;

  TStatusDisparaEmail = (staNenhumaAcao, staIncluindo, staAlterando, staTransformando, staFaturandoTotal,
                         staFaturandoParcial, staBaixando, staCancelando, staImprimindoSeparacao,
                         staConferindo, staImprimindoDireto, staAtivando, staConsultandoReimprimindo,staConfirmandoDocumento,
                         sta1DiaVencer,  sta1DiaVencido,
                         sta2DiasVencer, sta2DiasVencido,
                         sta3DiasVencer, sta3DiasVencido,
                         sta4DiasVencer, sta4DiasVencido,
                         sta5DiasVencer, sta5DiasVencido,
                         sta8DiasVencido,

                         sta6DiasVencer,sta6DiasVencido,
                         sta7DiasVencer,sta7DiasVencido,
                         sta8DiasVencer,
                         sta9DiasVencer,sta9DiasVencido,
                         sta10DiasVencer,sta10DiasVencido,
                         sta30DiasVencido,

                         staAVencerProximoDiaUtil, staVencidoProximoDiaUtil,

                         staRotaIniciada,
                         staOcorrenciaEntrega, staEntregaConcluida,
                         staCobrancaEletronica,
                         staAutorizadaNFe, staAutorizadaNFCe, staAutorizadaNFSe, staAutorizadaNFeEnvioFornecedor,
                         staCancelandoBoleto,
                         staReimpressaoCobranca,
                         staPixParaCreditoCliente,
                         staNFeAutComBoleto,
                         staAlterouStatusDoServico,
                         staEnvioAgendado,
                         staReenvioNfeReimpressaoDocs,
                         staReenvioNfceReimpressaoDocs,
                         staReenvioFFReimpressaoDocs,
                         staAvisoDebitoDia16,
                         staImprimindoOS,
                         staCashbackVenda,
                         staPesquisaSatisfacao,
                         staAlteracaoStatusEntrega,
                         staAberto1Dia,
                         staAberto2Dias,
                         staAberto3Dias,
                         staClienteAniversariante,
                         staFotoProduto,
                         staTituloQuitado,
                         staEnvioPixDupGeradaConfirmacao,
                         staEnvCodRastreioCorreio, staEnvCodRastreioAcompanhamento,
                         staAutorizadaNFeEnvioTransportadora,
                         staCashback7DiasAVencer);

  {Implementado por untFuncFatTypes.TGeraArquivoAnexoEmailAutomatico}
  IGeraArquivoAnexoEmailAutomatico = Interface
  ['{2954F94F-09C4-4B36-9A78-E712E73DD332}']
    function fGeraArquivoAnexo(blnGerandoParaDisparoDeGatilho: Boolean) : TList<TRecArquivosGatilhos>;

    function GetAcesso() : String;
    function GetSerie() : String;
    function GetStatus() : TStatusDisparaEmail;

    procedure SetAcesso(const Value : String);
    procedure SetSerie(const Value : String);
    procedure SetStatus(const Value : TStatusDisparaEmail);

    property Acesso: string read GetAcesso write SetAcesso;
    property Serie: string read GetSerie write SetSerie;
    property Status: TStatusDisparaEmail read GetStatus write SetStatus;

    function fGetEnviaArquivoXml: Boolean;
    procedure pSetEnviaArquivoXml(const Value: Boolean);

    function fGetEnviaArquivoPdf: Boolean;
    procedure pSetEnviaArquivoPdf(const Value: Boolean);

    property EnviaArquivoXml: Boolean read fGetEnviaArquivoXml write pSetEnviaArquivoXml;
    property EnviaArquivoPdf: Boolean read fGetEnviaArquivoPdf write pSetEnviaArquivoPdf;

  End;

  TReabrirForm = Record
    blnReabrirForm          : Boolean;
    blnAbrirDevolucaoNormal : Boolean;
  End;

  TrecEnderecoEntrega = Record
    strCliAnt,
    strCodCli,
    strNomCli,
    strIncrem,
    strEndEnt,
    strBaiEnt,
    strCepEnt,
    strCidEnt,
    strCoIbge,
    strNomCid,
    strRefEnt,
    strCodCid,
    strEstEnt,
    strTelEnt,
    strCodTra,
    strCobIss,
    strCodObr,
    strCodArt,
    strCodCno,
    strInsImo,
    strCodCib,
    strConCli,
    strCodReg,
    strConEnt,
    strTraRed,
    strTipFre: String;
    blnAltera: Boolean;
  End;

  TrecInfoMarcaFornecedor = record
    strFieldCodigoDestino : string ;
    strFieldCodigoOrigem : string ;
    strFieldNome : string ;
    strDescricao : string ;
    strTabela : string ;
    strCdsCodigo : string ;
    intCdsLenCodigo : integer ;
    strCdsNome : string ;
    intCdsLenNome : integer ;
    strItemCodigo : string ;
  end ;

  TDupTabelaEmail = Record
    strNumDoc: String;
    strParcel: String;
    strEspDoc: String;
    strCodEmp: String;
    dtaDtaCad: TDate;
    dtaDtaVen: TDate;
    fltVlrDup: Double;
    strCodCli: String;
    strAutoIn: String;
    intSeqBai: Integer;

    ValorCorrigido,
    ValorJuros,
    ValorRecebido: Double;
    strLinDig : String;
  End;

  TSinaleiro = Record
    strPrecoUtilizadoParaCalculo     : String;
    strDiaParaCorte                  : String;
    strFaixaEncontradaDocumentoAtual : String;
    strMargemDocumentoAtual          : String;
    strMargemMesApuracao             : String;
    strFaixaEncontradaMesApuracao    : String;
  End;

Type
  TDadosDaBaixaContasReceber = class
    FSeqCon: Integer;
    FEmpBai: String;
  end;

  TArrDupTabelaEmail = Array Of TDupTabelaEmail;

  TDadosDisparaEmail = Record
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strNumOrc,
    strEspOrc,
    strEmpOri,
    strEmailCli,
    strCodCli,
    strLinhaDigitavel,
    strEmaCob,
    strDtaEmi,
    strValDup,
    strParcel,
    strDtaVen,
    QRCodePix,
    LinkCitelPix,
    ValorPix,
    DiasVencimento,
    strCorpoAdicional,
    CorpoEmailFixo,
    strLnkPag: String;
    arrDupTabela : TArrDupTabelaEmail;
    RecArquivos: TArray<TRecArquivosGatilhos>;
  End;

  TPreInv = record
   strCodigo: String;
   strDescricao: string;
  end;

  TDadosRemessaContasPagar = Class
    LCodBco : String;
    LNomBco : String;
    LNomEmp : String;
    LCodAge : String;
    LConCor : String;
    LDigCnt : String;
    LCodCar : String;
    LDigCar : String;
    LProNum : String;
    LDtaRem : String;
    LHorRem : String;
    LRemLoc : Boolean;
    LCodCon : String;
    LTipIns : Integer;
    LCgcEmp : String;
    LEndEmp : String;
    LNumEmp : String;
    LComEmp : String;
    LCidEmp : String;
    LCepEmp : String;
    LEstEmp : String;
    LQryRemessa: TUniQuery;
    FEnviarCaracterEspecial: Boolean;
  End;

  TDadosLoginEmail = Record
    Senha,
    Email,
    Login,
    Remetente,

    ServidorSMTP,
    ServidorImap,
    TextoAssinatura,
    GravaPastaEnviados: String;

    Provedor,
    PortaSMTP,
    PortaImap,
    LimiteArquivos: Integer;
    TipoProvedor: String;

    ImagemAssinatura,
    AutenticacaoSSL,
    AutenticacaoSSLImap: Boolean;

    ImagemAssinaturaStream: TMemoryStream;
    ImagemAssinaturaBase64: String;
  End;

  TDadosDisparaSMS = Record
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strNumOrc,
    strEspOrc,
    strEmpOri,
    strCelula,
    strCodCli,
    strLinhaDigitavel,
    strEmaCob,
    strDtaEmi,
    strValDup,
    strParcel,
    strDtaVen,
    strLinkDoBoleto,
    ValorPix,
    strLnkPag,
    QRCodePix,
    EnviarModal,
    DiasVencimento: String;
    RecArquivos: TArray<TRecArquivosGatilhos>;
  End;

  TModalidadeTransferencia = (mtfNenhuma, mtfDinheiro, mtfChequeAVista, mtfChequePre,
                              mtfCartao, mtfOrdemDePagamento, mtfFinanciamento);

  TOpcRequisicao = (opcManterAberto, opcNegar, opcSemRequisicao);

  TDadEle = record
    strCodEle: String;
    strDesEle: String;
  End;

  TItemEstru = Record
    blnEstrutura     : Boolean;
    blnPrincipal     : Boolean;
    strItemPrincipal : String;
  End;

  TFieldDefInf = record
    Name: String;
    DisplayLabel: String;
    DisplayFormat: String;
    DataType: TFieldType;
    Size: Integer;
    Precision: Integer;
    Visible: Boolean;
  End;

  TDocumento = record
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strSerie,
    strFalha,
    strCliFor: String;
  End;

  TArrDocumentos = Array Of TDocumento;

  TComanda = Record
    blnCancelaDig : Boolean;
    blnResult     : Boolean;
    strCodComanda : String;
    blnEmUso      : Boolean;
    Documento     : TDocumento;
    blnDif        : Boolean;
    strCodComPD   : String;
  end;

  TEndDocumento = record
    strNumDoc,
    strEspDoc,
    strSerie_,
    strCodEmp,
    strCliFor,
    strTip_FC,
    strAutInc: String;
  end;

  TConsIteDev = Record
    strSQL        : String;
    strWhere      : String;
    strSQLAndWhere: String;
    arrTitCol     : Array Of String;
  End;

  TUltDupBaixada = Record
    strSeqLan: String;
    strCodCta: String;
    strPagCon: String;
    strPagCta: String; // (PagCon + PagCta)
  End;

  TDupSel = Record
    strNumDoc: String;
    strParcel: String;
    strEspDoc: String;
    strCodEmp: String;
    dtaDtaCad: TDate;
    dtaDtaVen: TDate;
    fltVlrRec: Double;
    strSeqBai: String;
    strCodCli: String;
  End;

  TArrDupSel = Array Of TDupSel;

  TModalidade = Record
    strDesmod : String;
    fltValMod : Double;
  End;

  TArrModalidade = Array Of TModalidade;

  TDadosSerie = Record
    strNumSer: String;
    fltQtdSer: Double;
  End;

  TMatrizSeries = Array Of TDadosSerie;

  TArrayLinDigCodbar = Record
    strCodBar   : String;
    strLinDig   : String;
  End;

  TarrLinDigCodbar = Array[0..23] Of TArrayLinDigCodbar;

  TarrATPVMB = array[1..7] of Boolean;

  TIntArray = Array Of Integer;
  TDateArray = Array Of TDateTime;
{$IFDEF LINUX}
  TStringArray = TArray<string>;
{$ELSE}
  TStringArray = Array Of String;
{$ENDIF}
  TDoubleArray = Array Of Double;
  TVariantArray = Array Of Variant;
  TarrTipOpe = Array of Array[0..1] of String;
  TStringArrayArray = Array of Array of String;

  TarrCodCtaFornec = Array of Record
    strCodFor,
    strCodCta: String;
  End;

  TDadosCodBarra = record
    strCodEmp: string;
    strCodIte: string;
    strCodBar: string;
  end;

  TarrayDadosCodBarra = array of TDadosCodBarra;

  TPrecosParaTransferencia = (ePrecoCusto, ePrecoVenda1, ePrecoVenda2, ePrecoVenda3, ePrecoVenda4,
    ePrecoVenda5, ePrecoVenda6, ePrecoVenda7, ePrecoUltimaCompra, ePrecoUltimaCompraComImpostos, ePrecoMedio, ePrecoMedioSemIcms);

  TPrecosParaTransferenciaHelper = record helper for TPrecosParaTransferencia
    function GetDescricao: String;
    function GetCampo: String;
    function PodeUtilizar(ACfgTabPrc: String): Boolean;
  end;

  TStringArrayHelper = record helper for TStringArray
    function ToString(ADelim: String; AQuoted: Boolean = False): String;
  end;

  TFunctionLocalizarItemRetornoSimbolico = function(ACodXml, ADesXml, AEANXml: String; var ACodItem: String; var AItemAtivo: Boolean): Boolean of object;

  TGenericProcedure = procedure of object;
  TReferenceProcedure = reference to procedure;
  TReferenceBooleanFunction = reference to function () : Boolean;
  TGenericFunctionWithoutParam = function: Boolean of object;
  TBooleanFunctionWithBooleanParam = function(blnCheck : Boolean = False) : Boolean;
  TReferenceFunctionProgresso = reference to function(pgbProgresso: TcxProgressBar): Boolean;
  {$IFDEF LINUX}
  TBooleanFunction = function(): Boolean Of Object;
  {$ENDIF}

  TMostraDocumentoReimpressao = Procedure(strNumDoc, strEspDoc, strCodEmp, strSerie: String; strCodCli: string = ''; strTipFC: String = 'C';  blnFiltrarNE: Boolean = True; blnOpcaoImpressao: Boolean = False);

  TOpcBairro = (opcDescri, opcCodCid, opcNomCid, opcEstado);

  TTipoMaxDesconto = (mdVendedor, mdVendedorMaster, mdSubGerenteJunior, mdSubGerenteMaster, mdGerenteJunior, mdGerenteMaster);

  TCampoInfoServico = (isCodS, isDesS, isQtsS, isUniS, isValS, isCusS, isMecS,
                       isObsS, isStaS, isBriS, isParS, isTBrS, isPriS, isIdeS,
                       isDecS, isVenS, isVe2S);

  TDadosServicos = Record
    strCodS01: String;
    strCodS02: String;
    strCodS03: String;
    strCodS04: String;
    strCodS05: String;
    strCodS06: String;
    strCodS07: String;
    strCodS08: String;
    strCodS09: String;
    strCodS10: String;
    strCodS11: String;
    strCodS12: String;
    strCodS13: String;
    strCodS14: String;
    strCodS15: String;
    strCodS16: String;
    strCodS17: String;
    strCodS18: String;
    strCodS19: String;
    strCodS20: String;
    strCodS21: String;
    strCodS22: String;
    strCodS23: String;
    strCodS24: String;
    strCodS25: String;
    strCodS26: String;
    strCodS27: String;
    strCodS28: String;
    strCodS29: String;
    strCodS30: String;

    strDesS01: String;
    strDesS02: String;
    strDesS03: String;
    strDesS04: String;
    strDesS05: String;
    strDesS06: String;
    strDesS07: String;
    strDesS08: String;
    strDesS09: String;
    strDesS10: String;
    strDesS11: String;
    strDesS12: String;
    strDesS13: String;
    strDesS14: String;
    strDesS15: String;
    strDesS16: String;
    strDesS17: String;
    strDesS18: String;
    strDesS19: String;
    strDesS20: String;
    strDesS21: String;
    strDesS22: String;
    strDesS23: String;
    strDesS24: String;
    strDesS25: String;
    strDesS26: String;
    strDesS27: String;
    strDesS28: String;
    strDesS29: String;
    strDesS30: String;

    fltQtdS01: Double;
    fltQtdS02: Double;
    fltQtdS03: Double;
    fltQtdS04: Double;
    fltQtdS05: Double;
    fltQtdS06: Double;
    fltQtdS07: Double;
    fltQtdS08: Double;
    fltQtdS09: Double;
    fltQtdS10: Double;
    fltQtdS11: Double;
    fltQtdS12: Double;
    fltQtdS13: Double;
    fltQtdS14: Double;
    fltQtdS15: Double;
    fltQtdS16: Double;
    fltQtdS17: Double;
    fltQtdS18: Double;
    fltQtdS19: Double;
    fltQtdS20: Double;
    fltQtdS21: Double;
    fltQtdS22: Double;
    fltQtdS23: Double;
    fltQtdS24: Double;
    fltQtdS25: Double;
    fltQtdS26: Double;
    fltQtdS27: Double;
    fltQtdS28: Double;
    fltQtdS29: Double;
    fltQtdS30: Double;

    fltUniS01: Double;
    fltUniS02: Double;
    fltUniS03: Double;
    fltUniS04: Double;
    fltUniS05: Double;
    fltUniS06: Double;
    fltUniS07: Double;
    fltUniS08: Double;
    fltUniS09: Double;
    fltUniS10: Double;
    fltUniS11: Double;
    fltUniS12: Double;
    fltUniS13: Double;
    fltUniS14: Double;
    fltUniS15: Double;
    fltUniS16: Double;
    fltUniS17: Double;
    fltUniS18: Double;
    fltUniS19: Double;
    fltUniS20: Double;
    fltUniS21: Double;
    fltUniS22: Double;
    fltUniS23: Double;
    fltUniS24: Double;
    fltUniS25: Double;
    fltUniS26: Double;
    fltUniS27: Double;
    fltUniS28: Double;
    fltUniS29: Double;
    fltUniS30: Double;

    fltValS01: Double;
    fltValS02: Double;
    fltValS03: Double;
    fltValS04: Double;
    fltValS05: Double;
    fltValS06: Double;
    fltValS07: Double;
    fltValS08: Double;
    fltValS09: Double;
    fltValS10: Double;
    fltValS11: Double;
    fltValS12: Double;
    fltValS13: Double;
    fltValS14: Double;
    fltValS15: Double;
    fltValS16: Double;
    fltValS17: Double;
    fltValS18: Double;
    fltValS19: Double;
    fltValS20: Double;
    fltValS21: Double;
    fltValS22: Double;
    fltValS23: Double;
    fltValS24: Double;
    fltValS25: Double;
    fltValS26: Double;
    fltValS27: Double;
    fltValS28: Double;
    fltValS29: Double;
    fltValS30: Double;

    fltCusS01: Double;
    fltCusS02: Double;
    fltCusS03: Double;
    fltCusS04: Double;
    fltCusS05: Double;
    fltCusS06: Double;
    fltCusS07: Double;
    fltCusS08: Double;
    fltCusS09: Double;
    fltCusS10: Double;
    fltCusS11: Double;
    fltCusS12: Double;
    fltCusS13: Double;
    fltCusS14: Double;
    fltCusS15: Double;
    fltCusS16: Double;
    fltCusS17: Double;
    fltCusS18: Double;
    fltCusS19: Double;
    fltCusS20: Double;
    fltCusS21: Double;
    fltCusS22: Double;
    fltCusS23: Double;
    fltCusS24: Double;
    fltCusS25: Double;
    fltCusS26: Double;
    fltCusS27: Double;
    fltCusS28: Double;
    fltCusS29: Double;
    fltCusS30: Double;

    strMecS01: String;
    strMecS02: String;
    strMecS03: String;
    strMecS04: String;
    strMecS05: String;
    strMecS06: String;
    strMecS07: String;
    strMecS08: String;
    strMecS09: String;
    strMecS10: String;
    strMecS11: String;
    strMecS12: String;
    strMecS13: String;
    strMecS14: String;
    strMecS15: String;
    strMecS16: String;
    strMecS17: String;
    strMecS18: String;
    strMecS19: String;
    strMecS20: String;
    strMecS21: String;
    strMecS22: String;
    strMecS23: String;
    strMecS24: String;
    strMecS25: String;
    strMecS26: String;
    strMecS27: String;
    strMecS28: String;
    strMecS29: String;
    strMecS30: String;

    strObsS01: String;
    strObsS02: String;
    strObsS03: String;
    strObsS04: String;
    strObsS05: String;
    strObsS06: String;
    strObsS07: String;
    strObsS08: String;
    strObsS09: String;
    strObsS10: String;
    strObsS11: String;
    strObsS12: String;
    strObsS13: String;
    strObsS14: String;
    strObsS15: String;
    strObsS16: String;
    strObsS17: String;
    strObsS18: String;
    strObsS19: String;
    strObsS20: String;
    strObsS21: String;
    strObsS22: String;
    strObsS23: String;
    strObsS24: String;
    strObsS25: String;
    strObsS26: String;
    strObsS27: String;
    strObsS28: String;
    strObsS29: String;
    strObsS30: String;

    strStaS01: String;
    strStaS02: String;
    strStaS03: String;
    strStaS04: String;
    strStaS05: String;
    strStaS06: String;
    strStaS07: String;
    strStaS08: String;
    strStaS09: String;
    strStaS10: String;
    strStaS11: String;
    strStaS12: String;
    strStaS13: String;
    strStaS14: String;
    strStaS15: String;
    strStaS16: String;
    strStaS17: String;
    strStaS18: String;
    strStaS19: String;
    strStaS20: String;
    strStaS21: String;
    strStaS22: String;
    strStaS23: String;
    strStaS24: String;
    strStaS25: String;
    strStaS26: String;
    strStaS27: String;
    strStaS28: String;
    strStaS29: String;
    strStaS30: String;

    strBriS01: String;
    strBriS02: String;
    strBriS03: String;
    strBriS04: String;
    strBriS05: String;
    strBriS06: String;
    strBriS07: String;
    strBriS08: String;
    strBriS09: String;
    strBriS10: String;
    strBriS11: String;
    strBriS12: String;
    strBriS13: String;
    strBriS14: String;
    strBriS15: String;
    strBriS16: String;
    strBriS17: String;
    strBriS18: String;
    strBriS19: String;
    strBriS20: String;
    strBriS21: String;
    strBriS22: String;
    strBriS23: String;
    strBriS24: String;
    strBriS25: String;
    strBriS26: String;
    strBriS27: String;
    strBriS28: String;
    strBriS29: String;
    strBriS30: String;

    strParS01: String;
    strParS02: String;
    strParS03: String;
    strParS04: String;
    strParS05: String;
    strParS06: String;
    strParS07: String;
    strParS08: String;
    strParS09: String;
    strParS10: String;
    strParS11: String;
    strParS12: String;
    strParS13: String;
    strParS14: String;
    strParS15: String;
    strParS16: String;
    strParS17: String;
    strParS18: String;
    strParS19: String;
    strParS20: String;
    strParS21: String;
    strParS22: String;
    strParS23: String;
    strParS24: String;
    strParS25: String;
    strParS26: String;
    strParS27: String;
    strParS28: String;
    strParS29: String;
    strParS30: String;

    strTBrS01: String;
    strTBrS02: String;
    strTBrS03: String;
    strTBrS04: String;
    strTBrS05: String;
    strTBrS06: String;
    strTBrS07: String;
    strTBrS08: String;
    strTBrS09: String;
    strTBrS10: String;
    strTBrS11: String;
    strTBrS12: String;
    strTBrS13: String;
    strTBrS14: String;
    strTBrS15: String;
    strTBrS16: String;
    strTBrS17: String;
    strTBrS18: String;
    strTBrS19: String;
    strTBrS20: String;
    strTBrS21: String;
    strTBrS22: String;
    strTBrS23: String;
    strTBrS24: String;
    strTBrS25: String;
    strTBrS26: String;
    strTBrS27: String;
    strTBrS28: String;
    strTBrS29: String;
    strTBrS30: String;

    strPriS01: String;
    strPriS02: String;
    strPriS03: String;
    strPriS04: String;
    strPriS05: String;
    strPriS06: String;
    strPriS07: String;
    strPriS08: String;
    strPriS09: String;
    strPriS10: String;
    strPriS11: String;
    strPriS12: String;
    strPriS13: String;
    strPriS14: String;
    strPriS15: String;
    strPriS16: String;
    strPriS17: String;
    strPriS18: String;
    strPriS19: String;
    strPriS20: String;
    strPriS21: String;
    strPriS22: String;
    strPriS23: String;
    strPriS24: String;
    strPriS25: String;
    strPriS26: String;
    strPriS27: String;
    strPriS28: String;
    strPriS29: String;
    strPriS30: String;

    strIdeS01: String;
    strIdeS02: String;
    strIdeS03: String;
    strIdeS04: String;
    strIdeS05: String;
    strIdeS06: String;
    strIdeS07: String;
    strIdeS08: String;
    strIdeS09: String;
    strIdeS10: String;
    strIdeS11: String;
    strIdeS12: String;
    strIdeS13: String;
    strIdeS14: String;
    strIdeS15: String;
    strIdeS16: String;
    strIdeS17: String;
    strIdeS18: String;
    strIdeS19: String;
    strIdeS20: String;
    strIdeS21: String;
    strIdeS22: String;
    strIdeS23: String;
    strIdeS24: String;
    strIdeS25: String;
    strIdeS26: String;
    strIdeS27: String;
    strIdeS28: String;
    strIdeS29: String;
    strIdeS30: String;

    fltDecS01: Double;
    fltDecS02: Double;
    fltDecS03: Double;
    fltDecS04: Double;
    fltDecS05: Double;
    fltDecS06: Double;
    fltDecS07: Double;
    fltDecS08: Double;
    fltDecS09: Double;
    fltDecS10: Double;
    fltDecS11: Double;
    fltDecS12: Double;
    fltDecS13: Double;
    fltDecS14: Double;
    fltDecS15: Double;
    fltDecS16: Double;
    fltDecS17: Double;
    fltDecS18: Double;
    fltDecS19: Double;
    fltDecS20: Double;
    fltDecS21: Double;
    fltDecS22: Double;
    fltDecS23: Double;
    fltDecS24: Double;
    fltDecS25: Double;
    fltDecS26: Double;
    fltDecS27: Double;
    fltDecS28: Double;
    fltDecS29: Double;
    fltDecS30: Double;

    strVenS01: String;
    strVenS02: String;
    strVenS03: String;
    strVenS04: String;
    strVenS05: String;
    strVenS06: String;
    strVenS07: String;
    strVenS08: String;
    strVenS09: String;
    strVenS10: String;
    strVenS11: String;
    strVenS12: String;
    strVenS13: String;
    strVenS14: String;
    strVenS15: String;
    strVenS16: String;
    strVenS17: String;
    strVenS18: String;
    strVenS19: String;
    strVenS20: String;
    strVenS21: String;
    strVenS22: String;
    strVenS23: String;
    strVenS24: String;
    strVenS25: String;
    strVenS26: String;
    strVenS27: String;
    strVenS28: String;
    strVenS29: String;
    strVenS30: String;

    strVe2S01: String;
    strVe2S02: String;
    strVe2S03: String;
    strVe2S04: String;
    strVe2S05: String;
    strVe2S06: String;
    strVe2S07: String;
    strVe2S08: String;
    strVe2S09: String;
    strVe2S10: String;
    strVe2S11: String;
    strVe2S12: String;
    strVe2S13: String;
    strVe2S14: String;
    strVe2S15: String;
    strVe2S16: String;
    strVe2S17: String;
    strVe2S18: String;
    strVe2S19: String;
    strVe2S20: String;
    strVe2S21: String;
    strVe2S22: String;
    strVe2S23: String;
    strVe2S24: String;
    strVe2S25: String;
    strVe2S26: String;
    strVe2S27: String;
    strVe2S28: String;
    strVe2S29: String;
    strVe2S30: String;

    intPraEnt: Integer;
    fltTotSer: Double;
    fltPerIss: Double;
    fltRedIss: Double;
    fltDedIss: Double;
    fltBasIss: Double;
    fltValIss: Double;
    strNroCEI: String;

    intNroPro: Integer;
    dtaSerIni: TDate;
    dtaSerFin: TDate;
    strSerObs: String;

    dtaDtAgeS: TDate;
    horHrAgeS: TDateTime;
    dtaDtEntS: TDate;
    horHrEntS: TDateTime;

    strDisSer: String;
    strMunPre: String;
    strNatSer: String;

    Procedure pRateiaServicos(fltFator: Double);

    Function fTemCobranca: Boolean;
  end;

  TArrDadosServicos = Array Of TDadosServicos;

  Type
    TOpcaoDuplicata = (dupVista, dupPrazo, dupTodas);

  {*****************************************}
  {* REPRESENTA UM REGISTRO DA DIGDUPLIC   *}
  {**************************************MV*}
  TArrDigDuplic = Record
    intNumDup:  Int64;
    strSequen: String;
    curValor : Currency;
    dtaDtaVen: String;
    strUsaChq: String;
    strHist02: String;
    strNFNumDup: String;
    curJuros : Currency;
    curArred : Currency;
    strAutIncGra: String;

    blnManterValoresPadrao: Boolean;
    strHisFRF: String;
  End;

  TarrDuplicata = Array[0..23] Of TArrDigDuplic;
  TarrDuplicataPointer = ^TarrDuplicata;

  TArrDigDuplicArray = Array Of TArrDigDuplic;

Type
  IArredondaParcela = Interface
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
  End;

Type
  {*****************************************}
  {* REPRESENTA UMA DUPLICATA DO CADREC    *}
  {**************************************MV*}
  TDuplicataCtr = Record
    strNumDup: String;
    strParcel: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strAutoIn: String;
    strCartei: String;

    blnAvisoAutomaticoEmail: Boolean;
    strCodigoGrupo         : String;
    strCodigoEmail         : String;

    LinkDoBoleto,
    ArquivoBoleto,
    QRCodePix,
    LinkPixCitel,
    EndToEndPix,
    strMsgProrrogacao: String;
End;

Type
  PTDuplicataCtr = ^TDuplicataCtr;

Type
  TArrDupCtr = Array Of TDuplicataCtr;

  TfGravaDetLoc = function (AIncDet,
                            ACodIte,
                            ACodEmp,
                            ANumLot,
                            ALocFis,
                            ALocSep: String;
                            AQtdIte: Double): Boolean;

  TpAtuEstoqueLoc = procedure (const AEntSai,
                               ACodIte,
                               ACodEmp,
                               ANumLot,
                               ALocFis: String;
                               const AQtdIte: Double);

  {*****************************************}
  {* =============> ANTEÇÃO <============= *}
  {* AO CRIAR UM PARAMETRO NESSA FUNÇÃO,   *}
  {* RECOMPILAR O AUTCOMTINTA              *}
  {**************************************MV*}
  TfGravaMovGer = function(
                    Var strAutInc: String;
                        strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodTra,
                        strCodVen,
                        strCodFor,
                        strCodCli,
                        strTip_Fc: String;
                        dtaDtaEnt,
                        tmrHorEnt,
                        dtaDtaDoc: TDateTime;
                        strConPag,
                        strEstado,
                        strNomCon,
                        strEndCon,
                        strBaiCon,
                        strCepCon,
                        strCidCon,
                        strEstCon,
                        strTelCon: String;
                        dtaNasCon: TDate;
                        strCgcCpf,
                        strCgcCon,
                        strIesCon,
                        strCli_Rg: String;
                        fltBasSim,
                        fltBasIpi,
                        fltAlqIpi,
                        fltTotIpi,
                        fltBasIcm,
                        fltAlqIcm,
                        fltTotIcm,
                        fltTotRet,
                        fltAlqRet,
                        fltBasRet,
                        fltRet_SP,
                        fltDesEsp,
                        fltVlrCon,
                        fltTotPro,
                        fltTotCus,
                        fltTotMed: Double;
                        strTipFre: String;
                        fltTotFre,
                        fltPesBru,
                        fltPesLiq,
                        fltVolume: Double;
                        strEspeci,
                        strMarca,
                        strMen001,
                        strMen002,
                        strMen003,
                        strMen004,
                        strMen005: String;
                        blnJafatu: Boolean;
                        strTipFat,
                        strNumFat,
                        strEmpFat: String;
                        dtaDtaFat: TDateTime;
                        strVenFat,
                        strCndFat: String;
                        blnDevEsp: Boolean;
                        fltValFat,
                        fltVPar01,
                        fltVPar02,
                        fltVPar03,
                        fltVPar04,
                        fltVPar05,
                        fltVPar06,
                        fltVPar07,
                        fltVPar08,
                        fltVPar09,
                        fltVPar10,
                        fltVPar11,
                        fltVPar12: Double;
                        arrDuplic: TarrDuplicata;
                        strSerie,
                        strNotEsp,
                        strClaFis,
                        strClaFi2,
                        strClaFi3,
                        strNatOpe: String;
                        fltPorDes: Double;
                        strCodDig,
                        strCodCnd,
                        strCodFpg: String;
                        fltFatNot: Double;
                        recServicos: TDadosServicos;
                        fltDesAce: Double;
                        strOriDoc,
                        strConEnt,
                        strCodRep: String;
                        fltAlqIrf,
                        fltValIrf,
                        fltAlqPis,
                        fltValPis,
                        fltAlqCof,
                        fltValCof,
                        fltAlqCsl,
                        fltValCsL,
                        fltIrfRet,
                        fltPisRet,
                        fltCofRet,
                        fltCslRet: Double;
                        strNotRet: String;
                        fltAlIrfP,
                        fltAlPisP,
                        fltAlCofP,
                        fltAlCslP,
                        fltSerRet: Double;
                        strNoReSe: String;
                        fltPeSgSo,
                        fltVlSgSo,
                        fltIrPrRt,
                        fltIrPrDv,
                        fltIrSeRt,
                        fltIrSeDv,
                        fltPiPrRt,
                        fltPiPrDv,
                        fltPiSeRt,
                        fltPiSeDv,
                        fltCoPrRt,
                        fltCoPrDv,
                        fltCoSeRt,
                        fltCoSeDv,
                        fltCsPrRt,
                        fltCsPrDv,
                        fltCsSeRt,
                        fltCsSeDv: Double;
                        strOrdPro: String;
                        fltBasOrg,
                        fltIcmOrg: Double;
                        intNConhe: Integer;
                        strConsum,                     // Consumidor final
                        strEntFat,
                        strCliFat,
                        strOpeExp,
                        strSepExp,
                        strTabPre,
                        strNum_Pr,
                        strEntFut: String;
                        blnBaiFut: Boolean;
                        fltMargem: Double;
                        fltBaRtSp,
                        fltVlRtSp: Double;
                        strOprFlj,
                        strNumReg: String;
                        dtaDtEntr: TDateTime;
                        strClaFi4,
                        strAutSer,
                        strCodEve,
                        strAutEnt,
                        strObsNfe,
                        strCodOco: String;
                        strFasObr: String;
                        blnIpDpNf: Boolean;
                        fltValCre: Double    = 0;
                        dtadtlBex: TDateTime = 0;
                        strEmlCon: String    = '';
                        dtaDtESNf: TDateTime = 0;
                        tmrHrESNf: TDateTime = 0;
                        objFinanc: Pointer = Nil;
                        strDocCon: String = '';           // Conhecimento de Frete
                        strCodObr: String = '';
                        strCodArt: String = '';
                        strPermut: String = 'N';          // Permuta para isenção de pagamento de comissão
                        strRetIss: String = '';
                        strOpcDoc: String = '';
                        fltFreSug: Double = 0;
                        strNumAde: String = '';
                        fltBasAnt: Double = 0;            //BASE DE ICMS ANTECIPADO
                        fltValAnt: Double = 0;            //VALOR DE ICMS ANTECIPADO
                        strNaoAtu: String = '';
                        strEntUrg: String = '';
                        strMenExp: String = '';
                        strMenEx2: String = '';
                        strMenEx3: String = '';
                        strMenEx4: String = '';
                        fltDupRec: Double = 0;
                        fltValAdt: Double = 0;
                        fltDeDVCf: Double = 0;
                        strPlaVei: String = '';
                        strKm_Vei: String = '';
                        strCliOri: String = '';
                        strCodMot: String = '';
                        strBetone: String = '';
                        strLacre_: String = '';
                        strTipMps: String = '';
                        strAbatim: String = '';
                        strBrita_: String = '';
                        strConBom: String = '';
                        intFckDia: Integer = 0;
                        fltImpPag: Double = 0;
                        intPrzMed: integer = 0;
                        blnImpPdv: Boolean = False;
                        blnDTEXREP: Boolean = False;
                        strChvNfeDev: String = '';
                        strOpeSol: String = '';
                        blnEst_Dv: Boolean = False;
                        strNumCOODev: String = '';
                        strNumSerDev: String = '';
                        strNumUSUDev: String = '';
                        strTipDocDev: String = '';
                        fltTotDif: Double = 0;
                        objFazenda: Pointer = nil;
                        fltFedImp : Double = 0;
                        fltEstImp : Double = 0;
                        fltMunImp : Double = 0;
                        fltTroco_: Double = 0;
                        strObsNfeFis: String = '';
                        strVenPre: String = 'N';
                        strSeqDocOri: String = '';
                        blnConEqu: Boolean = False;
                        blnDescIncond: Boolean = False;
                        blnGraCTP: Boolean = True;
                        strNumera: String = '';
                        strEdiPes: String = 'N';
                        fltTaxEnt: Double = 0;
                        fltVrdIcm: Double = 0;
                        fltBasVrd: Double = 0;
                        intNroBox: Integer = 0;
                        strCodEmbarcacao: String = '';
                        fltTotBri: Double = 0;
                        strTraRdp: String = '';
                        strCliCtt: String = '';
                        strCodMod: String = '';
                        strNumGui: String = '';
                        strHisCom: String = '';
                        strCodPrj: String = '';
                        strNatCfo: String = '';
                        strTpOper: String = '';
                        strCupDes: String = '';
                        strNotPau: String = 'S';
                        fltCotMoe: Double = 0;
                        fltFreMkp: Double = 0;
                        fltComMkp: Double = 0;
                        strPlaFat: String = '';
                        blnDevWms: Boolean = False;
                        blnFulfillmentModoRobo: Boolean = False;
                        fltFreCot: Double = 0;
                        fltFreRat: Double = 0;
                        strEntSim: String = 'N';
                        strSeqDmp: String = '';
                        strCfgENFUOP: String = '';
                        fltTotIpiEntFut: Double = 0;
                        fltTotRetEntFut: Double = 0;
                        fltTotFcpSTEntFut: Double = 0;
                        fltICMDes: Double = 0;
                        fltDesPis: Double = 0;
                        strOpFaEx: String = '';
                        strDocAba: String = '';
                        strEspAba: String = '';
                        strEmpAba: String = '';
                        strCliAba: String = '';
                        blnColeta: Boolean = False;
                        strNumeroRandomico: String = '';
                        strNumeroDrawback : String = '';
                        strCodFinalidadeAjuste : String = '';
                        strDoc_RE: String = '';
                        strEsp_RE: String = '';
                        strEmp_RE: String = '';
                        strCli_RE: String = '';
                        strDocRE2: String = '';
                        strEspRE2: String = '';
                        strEmpRE2: String = '';
                        strCliRE2: String = '';
                        strEmp_TE: String = '';
                        strAutIcv: String = '';
                        strEmp_PR: String = '';
                        strCliCEO: String = '';
                        fltVolSepExc: Double = 0;
                        fltVolSepNExc: Double = 0;
                        strSupGer: String = '';
                        strSupReg: String = '';
                        strCelCon: String = '';
                        strAbaDep: String = 'N';
                        strEmpDep: String = '';
                        strAbf_Uf: String = '';
                        strEstornoNotaFiscal: String = '';
                        strCodTpA: String = '';
                        strMarRev: String = '';
                        strVchCdp: String = '';
                        strCodCno: String = '';
                        fltTotIbs:            Double = 0;
                        fltTotCbs:            Double = 0;
                        fltTotIs:             Double = 0;
                        fltTotProIs:          Double = 0;
                        fltTotNf:             Double = 0;
                        strInsImo : String = '';
                        strCodCib : String = ''
                        ): Boolean;

  {*****************************************}
  {* =============> ANTEÇÃO <============= *}
  {* AO CRIAR UM PARAMETRO NESSA FUNÇÃO,   *}
  {* RECOMPILAR O AUTCOMTINTA              *}
  {**************************************MV*}
  TfGravaMovDet = function(
                    Var strAutInc: String;
                        strSeqGer: String;
                        strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodIte,
                        strCodVen,
                        strCodDiv,
                        strCodMar,
                        strCodFor,
                        strCodCli: String;
                        dtaDtaEnt,
                        dtaHorEnt,
                        dtaDtaDoc: TDateTime;
                        strConPag,
                        strTip_Fc,
                        strEstado,
                        strDescri,
                        strRefere,
                        strUnidad,
                        strForIte: String;
                        fltQtdIte,
                        fltUnitar,
                        fltUniOri,
                        fltUniVis,
                        fltTotIte,
                        fltVlrCon,
                        fltTotCus,
                        fltTotMed,
                        fltDesCon,
                        fltTotFre,
                        fltDesEsp: Double;
                        strCodRep,
                        strCodVe2: String;
                        fltPerCom,
                        fltTotCom,
                        fltTotCo2: Double;
                        strClaFis,
                        strCodFis: String;
                        fltValIpi,
                        fltAlqIpi,
                        fltBasIpi,
                        fltValIcm,
                        fltAlqIcm,
                        fltBasIcm,
                        fltValRet,
                        fltAlqRet,
                        fltBasRet,
                        fltTotPes,
                        fltPerBas,
                        fltPerRed: Double;
                        blnJafatu: Boolean;
                        strTipFat,
                        strNumFat,
                        strEmpFat: String;
                        dtaDtaFat: TDateTime;
                        strVenFat,
                        strCndFat: String;
                        fltValFat: Double;
                        strIdePro,
                        strIncPis,
                        strSerie: String;
                        fltDesAce: Double;
                        strNotEsp,
                        strDocDev,
                        strEspDev,
                        strEmpDev,
                        strIteCha,
                        strIteTin,
                        strDesCor,
                        strTipEmb: String;
                        fltQtdEmb,
                        fltPreEmb: Double;
                        strTipPre: String;
                        fltPrvTin,
                        fltPrcTin,
                        fltFatTin: Double;
                        strProEmb,
                        strCodDig,
                        strCodCnd,
                        strCodFpg,
                        strIteEmb,
                        strGruEmb: String;
                        intLazQua: Integer;
                        strPromoc,
                        strSeqTin: String;
                        fltQtdPul: Double;
                        strPedCom,
                        strOriDoc,
                        strNum_Pd,
                        strEsp_Pd,
                        strEmp_Pd: String;
                        intInd_Pd: Integer;
                        strOrdPro,
                        strDesNes,
                        strCliFat: String;
                        fltBcaMin,
                        fltBcaCom,
                        fltVolPro: Double;
                        strCodAca,
                        strEmpAca: String;
                        blnProAca,
                        blnFilKar: Boolean;
                        strEspFut,
                        strDocFut,
                        strEmpFut,
                        strTabPre,
                        strEmpCom: String;
                        strLinha: String;
                        strCatali: String;
                        strCodDil: String;
                        fltPorDil: Double;
                        strDilCon: String;
                        fltPorCat: Double;
                        fltUniDig: Double;
                        fltQtdPon: Double;
                        strEntFut,
                        strMotFut: String;
                        dtaDtaFut: TDateTime;
                        fltTotCu2: Double;
                        fltComRep,
                        fltPerRep: Double;
                        strKey_EP,
                        strNumLot,
                        strPigBas: String;
                        fltVaEIpi,
                        fltAlEIpi,
                        fltBaEIpi,
                        fltTotUlt,
                        fltImpUlt,
                        fltBaRtSP,
                        fltVaRtSP,
                        fltIcOpPr: Double;
                        intSeqCcr: Integer;
                        fltEmbala,
                        fltAlqPis,
                        fltBasPis,
                        fltValPis: Double;
                        strCSTPis: String;
                        fltAlqCof,
                        fltBasCof,
                        fltValCof: Double;
                        strCSTCof,
                        strCSTIpi,
                        strEnqIpi: String;
                        fltVaERet,
                        fltAlERet,
                        fltBaERet: Double;
                        fltPesLiq: Double;
                        fltUniTab: Double = 0;
                        strLot_TA: String = '';
                        fltConFre: Double = 0;
                        fltBasAnt: Double = 0;
                        fltIcmAnt: Double = 0;
                        fltVendor: Double = 0;
                        fltOutDes: Double = 0;
                        fltVlGnre: Double = 0;
                        strGnrOri: string = 'P';
                        fltOutIcm: Double = 0;
                        fltIseIcm: Double = 0;
                        fltFreSug: Double = 0;
                        strCodMot: String = '';
                        strNatPis: String = '';
                        strNatCof: string = '';
                        strSeqGad: string = '';
                        fltOutVal: Double = 0;
                        fltIcmSai: Double = 0;
                        fltImpFed: Double = 0;
                        fltDesOpe: Double = 0;
                        fltQtdExp: Double = 0;
                        strNumCmp: String = '';
                        intNItCmp: Integer = 0;
                        fltDeDVCf: Double = 0;
                        strCodMec: String = '';
                        strAntPro: String = 'N';
                        strAntFre: String = 'N';
                        fltMedAnt: Double = 0;
                        fltPreAnt: Double = 0;
                        fltImpAnt: Double = 0;
                        strSeqAnt: string = '';
                        strRICMPR: String = 'N';
                        fltComLiq: Double = 0;
                        strNcmTin: String = '';
                        fltValIva: Double = 0;
                        strCliBus: String = 'N';
                        strTurEnt: String = '';
                        strIdeDev: String = 'NOR';
                        fltPeBaST: Double = 0;
                        fltVal_RT: Double = 0;
                        fltDesCli: Double = 0;
                        fltImpPag: Double = 0;
                        fltTaxJur: Double = 0;
                        fltSerRat: Double = 0;
                        strProBri: String = '';
                        fltPonBri: Double = 0;
                        fltValDif: Double = 0;
                        fltVaFrAn: Double = 0;
                        strLotAba: String = '';
                        fltFedImp: Double = 0;
                        fltEstImp: Double = 0;
                        fltMunImp: Double = 0;
                        strIncDev: String = '';
                        strBrinde: String = 'N';
                        strCodPar: String = '';
                        strTipBri: String = '';
                        fltIcmOrg: Double = 0;
                        strBaqtze: String = '';
                        strIncFut: String = '';
                        fltValFle: Double = 0;
                        fltTaxEnt: Double = 0;
                        fltVrdIcm: Double = 0;
                        fltBasVrd: Double = 0;
                        strMtdIcm: String = '';
                        strBxSbIt: String = 'N';
                        strIteAbf: String = '';
                        strAtivac: String = 'N';
                        intSeqCom: Integer = 0;
                        fltVICMDe: Double = 0;
                        strNcmIte: String = '';
                        fltComDig: Double = 0;
                        fltPerDig: Double = 0;
                        fltIcmPav: Double = 0;
                        blnIcmSai: Boolean = False;
                        fltAlDifa: Double = 0;
                        strAutSai: String = '';
                        fltBFCPST: Double = 0;
                        fltPFCPST: Double = 0;
                        fltVFCPST: Double = 0;
                        strDadSep: String = '';
                        strAutEle: String = '';
                        strNotUlt: String = '';
                        fltPICMEF: Double = 0;
                        fltBICMEF: Double = 0;
                        fltAICMEF: Double = 0;
                        fltVICMEF: Double = 0;
                        fltBSTANT: Double = 0;
                        fltVSTANT: Double = 0;
                        strNotC17: String = '';
                        fltAlq922: Double = 0;
                        fltDesCnd: Double = 0;
                        strProEsp: String = '';
                        strCodPro: String = '';
                        strInc_Pd: String = '';
                        fltSICMEF: Double = 0;
                        fltValTCI: Double = 0;
                        fltCalTCI: Double = 0;
                        fltVal_TS: Double = 0;
                        strExtFul: String = '';
                        strCodExt: String = '';
                        fltFreMkp: Double = 0;
                        fltComMkp: Double = 0;
                        strAIdKitPromocao : String = '';
                        strChaveAcesso: String = '';
                        fltQtdCom: Double = 0;
                        fltFreCot: Double = 0;
                        AstrComplemento : String = '';
                        strEmpCar: String = '';
                        strAutoinDevCar: String = '';
                        AfltBaseOperacaoPropriaICMSEntrada : Double = 0;
                        AfltAliquotaOperacaoPropriaICMSEntrada : Double = 0;
                        AfltValorOperacaoPropriaIMCSEntrada : Double = 0;
                        fltFreRat: Double = 0;
                        fltValIpiEntFut: Double = 0;
                        fltValRetEntFut: Double = 0;
                        fltValFcpSTEntFut: Double = 0;
                        fltDesPis: Double = 0;
                        blnClaRet: Boolean = False;
                        strOpSeEx: String = '';
                        strConExp: String = '';
                        strEmbExp: String = '';
                        strObsExp: String = '';
                        blnAtoDeclaratorioDF: Boolean = False;
                        strLocFis: String = '';
                        fltVDesST: Double = 0;
                        strMDesST: String = '';
                        strNumDrw: String = '';
                        strTipBus: String = '';
                        strNumPla: String = '';
                        strParNum: String = '';
                        strReqCom: String = '';
                        strNatOpe: String = '';
                        fltRpaFre: Double = 0;
                        fltPerRic: Double = 0;
                        blnAltEst: Boolean = False;
                        intSeqPer: Integer = 0;
                        intDetItem: Integer = 0;
                        fltICMCFR: Double = 0;
                        fltFreteCalc: Double = 0;
                        fltFreConCalc: Double = 0;
                        strPegou_ : String = 'N';
                        fltVFCPOP: Double = 0;
                        fltVFCPDF: Double = 0;
                        fltCubage: Double = 0;
                        fltCfbIpi: Double = 0;
                        fltCfaIpi: Double = 0;
                        fltCfvIpi: Double = 0;
                        strCipiOK: String = 'N';
                        strDocIpi: String = '';
                        strEspIpi: String = '';
                        strEmpIpi: String = '';
                        intRemFil: Integer = 0;
                        fltQtdRemFil: Double = 0;
                        blnFulfillmentModoRobo: Boolean = False;
                        blnFilFul: Boolean = True;
                        blnBaiDev: Boolean = False;
                        strAutEnt: String = '';
                        dtaDtaCmp: TDateTime = 0;
                        strFullHubMkp: String = '';
                        fltOutValPD: Double = 0;
                        strFilFul_EntSai: String = '';
                        strIncOri: String = '';
                        strTckQbt: String = '';
                        strEntTri: String = 'N';
                        strFulDif: String = '';
                        strClaFat: String = '';
                        fltICMNCR: Double = 0;
                        fltFCPNCR: Double = 0;
                        strColoranteDeEntregaFutura : String = 'N';
                        strCbenef: string = '';
                        strCodPre: string = '';
                        fltBasPre: Double = 0;
                        fltPerPre: Double = 0;
                        fltValPre: Double = 0;
                        strCodCmg: String = '';
                        fltVimRet: Double = 0;
                        dobQIcmsMonRet: Double = 0;
                        dobAdBcMonRet: Double = 0;
                        dobVrEmIcmsRet: Double = 0;
                        fltValSeg: Double = 0;
                        fltPerDif: Double = 0;
                        fltAlqSTXML: Double = 0;
                        fltCliDes: Double = 0;
                        strRefCodCst: String = '';
                        strRefClaTri: String = '';
                        fltRefValOpe: Double = 0;
                        fltRefBasCal: Double = 0;
                        fltRefCbsAlq: Double = 0;
                        fltRefCbsAlD: Double = 0;
                        fltRefCbsVlD: Double = 0;
                        fltRefCbsAlR: Double = 0;
                        fltRefCbsVlT: Double = 0;
                        fltRefCbsAlE: Double = 0;
                        fltRefCbsVal: Double = 0;
                        fltRefIbsUfA: Double = 0;
                        fltRefIbsUfD: Double = 0;
                        fltRefIbsUvD: Double = 0;
                        fltRefIbsUfR: Double = 0;
                        fltRefIbsUfT: Double = 0;
                        fltRefIbsUfE: Double = 0;
                        fltRefIbsUfV: Double = 0;
                        fltRefIbsMnA: Double = 0;
                        fltRefIbsMnD: Double = 0;
                        fltRefIbsMvD: Double = 0;
                        fltRefIbsMnR: Double = 0;
                        fltRefIbsMnT: Double = 0;
                        fltRefIbsMnE: Double = 0;
                        fltRefIbsMnV: Double = 0;
                        strRefSelCst: String = '';
                        strRefSelCla: String = '';
                        fltRefSelBas: Double = 0;
                        fltRefSelAlq: Double = 0;
                        fltRefSelVal: Double = 0;
                        strRefTriReg: String = 'N';
                        strRefCrePre: String = 'N';
                        strRefMonoFa: String = 'N';
                        fltRefValIbs: Double = 0;
                        strRefCesBas: String = '';
                        strRefCstReg: String = '';
                        strRefClaReg: String = '';
                        fltRefAiuReg: Double = 0;
                        fltRefTiuReg: Double = 0;
                        fltRefAimReg: Double = 0;
                        fltRefTimReg: Double = 0;
                        fltRefCbsReg: Double = 0;
                        fltRefTcbReg: Double = 0;
                        fltIcmPrd: Double = 0;
                        fltSiscomex: Double = 0;
                        strChvRef: String = '';
                        strIteRef: String = '';
                        ABatch: Pointer = Nil; {Req. 456948}
                        fltBimRet: Double = 0;
                        fltAimRet: Double = 0;
                        blnRefEspelhaDocumento: Boolean = False): Boolean;

  TMovDetParams = record
    fltUniTab: Double;
    strLot_TA: String;
    fltConFre: Double;
    fltBasAnt: Double;
    fltIcmAnt: Double;
    fltVendor: Double;
    fltOutDes: Double;
    fltVlGnre: Double;
    strGnrOri: string;
    fltOutIcm: Double;
    fltIseIcm: Double;
    fltFreSug: Double;
    strCodMot: String;
    strNatPis: String;
    strNatCof: string;
    strSeqGad: string;
    fltOutVal: Double;
    fltIcmSai: Double;
    fltImpFed: Double;
    fltDesOpe: Double;
    fltQtdExp: Double;
    strNumCmp: String;
    intNItCmp: Integer;
    fltDeDVCf: Double;
    strCodMec: String;
    strAntPro: String;
    strAntFre: String;
    fltMedAnt: Double;
    fltPreAnt: Double;
    fltImpAnt: Double;
    strSeqAnt: string;
    strRICMPR: String;
    fltComLiq: Double;
    strNcmTin: String;
    fltValIva: Double;
    strCliBus: String;
    strTurEnt: String;
    strIdeDev: String;
    fltPeBaST: Double;
    fltVal_RT: Double;
    fltDesCli: Double;
    fltImpPag: Double;
    fltTaxJur: Double;
    fltSerRat: Double;
    strProBri: String;
    fltPonBri: Double;
    fltValDif: Double;
    fltVaFrAn: Double;
    strLotAba: String;
    fltFedImp: Double;
    fltEstImp: Double;
    fltMunImp: Double;
    strIncDev: String;
    strBrinde: String;
    strCodPar: String;
    strTipBri: String;
    fltIcmOrg: Double;
    strBaqtze: String;
    strIncFut: String;
    fltValFle: Double;
    fltTaxEnt: Double;
    fltVrdIcm: Double;
    fltBasVrd: Double;
    strMtdIcm: String;
    strBxSbIt: String;
    strIteAbf: String;
    strAtivac: String;
    intSeqCom: Integer;
    fltVICMDe: Double;
    strNcmIte: String;
    fltComDig: Double;
    fltPerDig: Double;
    fltIcmPav: Double;
    blnIcmSai: Boolean;
    fltAlDifa: Double;
    strAutSai: String;
    fltBFCPST: Double;
    fltPFCPST: Double;
    fltVFCPST: Double;
    strDadSep: String;
    strAutEle: String;
    strNotUlt: String;
    fltPICMEF: Double;
    fltBICMEF: Double;
    fltAICMEF: Double;
    fltVICMEF: Double;
    fltBSTANT: Double;
    fltVSTANT: Double;
    strNotC17: String;
    fltAlq922: Double;
    fltDesCnd: Double;
    strProEsp: String;
    strCodPro: String;
    strInc_Pd: String;
    fltSICMEF: Double;
    fltValTCI: Double;
    fltCalTCI: Double;
    fltVal_TS: Double;
    strExtFul: String;
    strCodExt: String;
    fltFreMkp: Double;
    fltComMkp: Double;
    strAIdKitPromocao : String;
    strChaveAcesso: String;
    fltQtdCom: Double;
    fltFreCot: Double;
    AstrComplemento : String;
    strEmpCar: String;
    strAutoinDevCar: String;
    AfltBaseOperacaoPropriaICMSEntrada : Double;
    AfltAliquotaOperacaoPropriaICMSEntrada : Double;
    AfltValorOperacaoPropriaIMCSEntrada : Double;
    fltFreRat: Double;
    fltValIpiEntFut: Double;
    fltValRetEntFut: Double;
    fltValFcpSTEntFut: Double;
    fltDesPis: Double;
    blnClaRet: Boolean;
    strOpSeEx: String;
    strConExp: String;
    strEmbExp: String;
    strObsExp: String;
    blnAtoDeclaratorioDF: Boolean;
    strMovTriLocFis: String;
    fltVDesST: Double;
    strMDesST: String;
    strNumDrw: String;
    strTipBus: String;
    strNumPla: String;
    strParNum: String;
    strReqCom: String;
    strNatOpe: String;
    fltRpaFre: Double;
    fltPerRic: Double;
    blnAltEst: Boolean;
    intSeqPer: Integer;
    intDetItem: Integer;
    fltICMCFR: Double;
    fltFreteCalc: Double;
    fltFreConCalc: Double;
    strPegou_ : String;
    fltVFCPOP: Double;
    fltVFCPDF: Double;
    fltCubage: Double;
    fltCfbIpi: Double;
    fltCfaIpi: Double;
    fltCfvIpi: Double;
    strCipiOK: String;
    strDocIpi: String;
    strEspIpi: String;
    strEmpIpi: String;
    intRemFil: Integer;
    fltQtdRemFil: Double;
    blnFulfillmentModoRobo: Boolean;
    blnFilFul: Boolean;
    blnBaiDev: Boolean;
    strAutEnt: String;
    dtaDtaCmp: TDateTime;
    strFullHubMkp: String;
    fltOutValPD: Double;
    strFilFul_EntSai: String;
    strIncOri: String;
    strTckQbt: String;
    strEntTri: String;
    strFulDif: String;
    strClaFat: String;
    fltICMNCR: Double;
    fltFCPNCR: Double;
    strColoranteDeEntregaFutura : String;
    strCbenef: string;
    strCodPre: string;
    fltBasPre: Double;
    fltPerPre: Double;
    fltValPre: Double;
    strCodCmg: string;
    fltVimRet: Double;
    dobQIcmsMonRet: Double;
    dobAdBcMonRet: Double;
    dobVrEmIcmsRet: Double;
    fltValSeg: Double;
    fltPerDif: Double;
    fltAlqSTXML: Double;
    fltCliDes: Double;
    strRefCodCst: String;
    strRefClaTri: String;
    fltRefValOpe: Double;
    fltRefBasCal: Double;
    fltRefCbsAlq: Double;
    fltRefCbsAlD: Double;
    fltRefCbsVlD: Double;
    fltRefCbsAlR: Double;
    fltRefCbsVlT: Double;
    fltRefCbsAlE: Double;
    fltRefCbsVal: Double;
    fltRefIbsUfA: Double;
    fltRefIbsUfD: Double;
    fltRefIbsUvD: Double;
    fltRefIbsUfR: Double;
    fltRefIbsUfT: Double;
    fltRefIbsUfE: Double;
    fltRefIbsUfV: Double;
    fltRefIbsMnA: Double;
    fltRefIbsMnD: Double;
    fltRefIbsMvD: Double;
    fltRefIbsMnR: Double;
    fltRefIbsMnT: Double;
    fltRefIbsMnE: Double;
    fltRefIbsMnV: Double;
    strRefSelCst: String;
    strRefSelCla: String;
    fltRefSelBas: Double;
    fltRefSelAlq: Double;
    fltRefSelVal: Double;
    strRefTriReg: String;
    strRefCrePre: String;
    strRefMonoFa: String;
    fltRefValIbs: Double;
    strRefCesBas: String;
    strRefCstReg: String;
    strRefClaReg: String;
    fltRefAiuReg: Double;
    fltRefTiuReg: Double;
    fltRefAimReg: Double;
    fltRefTimReg: Double;
    fltRefCbsReg: Double;
    fltRefTcbReg: Double;
    fltIcmPrd: Double;
    fltSiscomex: Double;
    strChvRef: string;
    strIteRef: string;
    ABatch: Pointer;
    procedure Init;
  end;

  TNotDetParams = record
    fltBasAnt: Double;
    fltIcmAnt: Double;
    fltOutIcm: Double;
    fltIseIcm: Double;
    fltFreSug: Double;
    strNatPis: String;
    strNatCof: String;
    fltDeDVCf: Double;
    strRICMPR: String;
    fltComLiq: Double;
    strNcmTin: String;
    strNumLot: String;
    fltValIva: Double;
    strCliBus: string;
    strTurEnt: String;
    fltPeBaST: Double;
    fltVal_RT: Double;
    fltImpPag: Double;
    fltTaxJur: Double;
    strNumCmp: String;
    intNItCmp: Integer;
    strProBri: String;
    fltPonBri: Double;
    fltOutVal: Double;
    fltIcmSai: Double;
    fltImpFed: Double;
    fltDesOpe: Double;
    fltValDif: Double;
    fltFedImp: Double;
    fltEstImp: Double;
    fltMunImp: Double;
    fltIcmOrg: Double;
    fltVrdIcm: Double;
    fltBasVrd: Double;
    strMtdIcm: String;
    strAtivac: String;
    intSeqCom: Integer;
    strSeqDet: String;
    strDesNes: String;
    strNotUlt: String;
    fltPICMEF: Double;
    fltBICMEF: Double;
    fltAICMEF: Double;
    fltVICMEF: Double;
    fltBSTANT: Double;
    fltVSTANT: Double;
    strNotC17: String;
    fltSICMEF: Double;
    fltBFCPST: Double;
    fltPFCPST: Double;
    fltVFCPST: Double;
    strChaveAcesso: String;
    fltQtdCom: Double;
    strEmpCar: String;
    fltValIpiEntFut: Double;
    fltValRetEntFut: Double;
    fltValFcpSTEntFut: Double;
    blnAtoDeclaratorioDF: Boolean;
    fltVDesST: Double;
    strMDesST: String;
    strCForDi: String;
    strNumDrw: String;
    strNumPla: String;
    strParNum: String;
    strReqCom: String;
    fltFreCot: Double;
    intDetItem: Integer;
    fltVFCPOP: Double;
    fltVFCPDF: Double;
    fltCfbIpi: Double;
    fltCfaIpi: Double;
    fltCfvIpi: Double;
    strCipiOK: String;
    strDocIpi: String;
    strEspIpi: String;
    strEmpIpi: String;
    strNcmIte: String;
    strComple: String;
    dtaDtaCmp: TDateTime;
    fltOutValPD: Double;
    strCbenef: string;
    strCodPre: string;
    fltBasPre: Double;
    fltPerPre: Double;
    fltValPre: Double;
    strCodCmg: String;
    fltVimRet: Double;
    fltValSeg: Double;
    fltPerDif: Double;
    strEmpOri: String;
    fltIcmPrd: Double;
    strRefCodCst: String;
    strRefClaTri: String;
    fltRefValOpe: Double;
    fltRefBasCal: Double;
    fltRefCbsAlq: Double;
    fltRefCbsAlD: Double;
    fltRefCbsVlD: Double;
    fltRefCbsAlR: Double;
    fltRefCbsVlT: Double;
    fltRefCbsAlE: Double;
    fltRefCbsVal: Double;
    fltRefIbsUfA: Double;
    fltRefIbsUfD: Double;
    fltRefIbsUvD: Double;
    fltRefIbsUfR: Double;
    fltRefIbsUfT: Double;
    fltRefIbsUfE: Double;
    fltRefIbsUfV: Double;
    fltRefIbsMnA: Double;
    fltRefIbsMnD: Double;
    fltRefIbsMvD: Double;
    fltRefIbsMnR: Double;
    fltRefIbsMnT: Double;
    fltRefIbsMnE: Double;
    fltRefIbsMnV: Double;
    strRefSelCst: String;
    strRefSelCla: String;
    fltRefSelBas: Double;
    fltRefSelAlq: Double;
    fltRefSelVal: Double;
    strRefTriReg: String;
    strRefCrePre: String;
    strRefMonoFa: String;
    fltRefValIbs: Double;
    strRefCesBas: String;
    strRefCstReg: String;
    strRefClaReg: String;
    fltRefAiuReg: Double;
    fltRefTiuReg: Double;
    fltRefAimReg: Double;
    fltRefTimReg: Double;
    fltRefCbsReg: Double;
    fltRefTcbReg: Double;
    fltSiscomex: Double;
    strChvRef: String;
    strIteRef: string;
    ABatch: Pointer;
    procedure Init;
  end;

  TCadFisParams = record
    strEmpAut: String;
    fltImpMer: Double;
    fltImpSeg: Double;
    fltImpImp: Double;
    fltImpPro: Double;
    fltImpTax: Double;
    fltImpPis: Double;
    fltImpCof: Double;
    strImpIC1: String;
    strImpIC2: String;
    strModFre: String;
    fltBasIss: Double;
    fltAlqIss: Double;
    fltValIss: Double;
    fltBaseII: Double;
    fltDesAdu: Double;
    fltValIOF: Double;
    fltBasAn1: Double;
    fltAntIc1: Double;
    fltBasAn2: Double;
    fltAntIc2: Double;
    fltBasAn3: Double;
    fltAntIc3: Double;
    fltBasAn4: Double;
    fltAntIc4: Double;
    fltBasAn5: Double;
    fltAntIc5: Double;
    strCstEnt: String;
    blnGraCTP: Boolean;
    fltBaeRe1: Double;
    fltVaeRe1: Double;
    fltBaeRe2: Double;
    fltVaeRe2: Double;
    fltBaeRe3: Double;
    fltVaeRe3: Double;
    fltBaeRe4: Double;
    fltVaeRe4: Double;
    fltBaeRe5: Double;
    fltVaeRe5: Double;
    fltBaeIP1: Double;
    fltVaeIP1: Double;
    fltBaeIP2: Double;
    fltVaeIP2: Double;
    fltBaeIP3: Double;
    fltVaeIP3: Double;
    fltBaeIP4: Double;
    fltVaeIP4: Double;
    fltBaeIP5: Double;
    fltVaeIP5: Double;
    strCtsPis: String;
    strCtsCof: String;
    strCodMod: String;
    strVENCOM: String;
    fltBFCPS1: Double;
    fltVFCPS1: Double;
    fltBFCPS2: Double;
    fltVFCPS2: Double;
    fltBFCPS3: Double;
    fltVFCPS3: Double;
    fltBFCPS4: Double;
    fltVFCPS4: Double;
    fltBFCPS5: Double;
    fltVFCPS5: Double;
    fltALQFCP: Double;
    fltTotRmm: Double;
    strCodTra: String;
    fltIrSeRt: Double;
    fltPiSeRt: Double;
    fltCoSeRt: Double;
    fltCsSeRt: Double;
    fltRetISS: Double;
    fltRetINS: Double;
    fltBAFCP1: Double;
    fltVLFCP1: Double;
    fltBAFCP2: Double;
    fltVLFCP2: Double;
    fltBAFCP3: Double;
    fltVLFCP3: Double;
    fltBAFCP4: Double;
    fltVLFCP4: Double;
    fltBAFCP5: Double;
    fltVLFCP5: Double;
    strTipFre: String;
    fltRFRBAS: Double;
    fltRFRALQ: Double;
    fltRFRVAL: Double;
    strCstIPI: String;
    strNfCIAP: String;
    fltPesCTE: Double;
    strEstornoNotaFiscal: String;
    strEstornoNotaFiscalMotivo: String;
    strNatOpe: String;
    strTB01RE: String;
    strTB06RE: String;
    strBasFre: String;
    blnDevSim: Boolean;
    strCdsErv: String;
    fltQBCMO1: Double;
    fltQBCMO2: Double;
    fltQBCMO3: Double;
    fltQBCMO4: Double;
    fltQBCMO5: Double;
    fltQBCMO6: Double;
    fltQBCMO7: Double;
    fltQBCMO8: Double;
    fltADREM1: Double;
    fltADREM2: Double;
    fltADREM3: Double;
    fltADREM4: Double;
    fltADREM5: Double;
    fltADREM6: Double;
    fltADREM7: Double;
    fltADREM8: Double;
    fltVALMO1: Double;
    fltVALMO2: Double;
    fltVALMO3: Double;
    fltVALMO4: Double;
    fltVALMO5: Double;
    fltVALMO6: Double;
    fltVALMO7: Double;
    fltVALMO8: Double;
    strNfsSub: String;
    strMesAno: String;
    strFinNfe: String;
    strFinTip: String;
    fltTotIbs: Double;
    fltTotCbs: Double;
    fltTotIs: Double;
    fltTotProIs: Double;
    fltTotNf: Double;
    procedure Init;
  end;

  TTipoConsultaFormaPagto  = (conFpgSimples, conFpgBaiAvi);
  TTipoConsultaFornecedor  = (conForSimples, conForCompleta, conForUltimaCompra);
  TTipoConsultaCliente     = (conCliSimples, conCliCompleta, conCliEmpresaIdent, conCliFiliais, conCliAgrupDup);
  TTipoConsultaPedidoVenda = (conPedSimples, conPedCompleta, conPedOrdPro, conPedDigDoc, conPedSimpMultEmp);
  TTipoConsultaEmpresa     = (conEmpSimples, conEmpCompleta);
  TTipoConsultaTransportad = (conTraSimples, conTraCompleta, conTraCidFrete, conTraRegFrete);
  TTipoConsultaItem        = (conIteSimples, conIteCompleta, conNovosItens, conIteSemelhantes, conIteSimilar, conIteAgregados);
  TCodigoRetornoItem       = (cdrCodIte, cdrCodFab);
  TTipoConsultaCondPagto   = (conCndSimples, conCndPerfil);
  TTipoConsultaLivro       = (conGeral, conNotaComplemento, conCartaCorrecao, conNotaComplementar, conAgendamentoEntrega, conNFCeComplementar, conNotaEstorno);
  TPesquisaOPI             = (poiCodigo, poiLote);
  TStateOPI                = (staTodas, staAbertas, staBaixadas);
  TTipoCadastroLote        = (tclNormal, tclOrdemProducaoIndustrial);
  TTipoTintas              = (conAdt,
                              conAdv,
                              conAdvCor,
                              conAja,
                              conFal,
                              conAle,
                              conAnj,
                              conJot,
                              conAnn,
                              conAut,
                              conBau,
                              conQua,
                              conBel,
                              conCia,
                              conMeg,
                              conGra,
                              conBza,
                              conBzi, conBziLinha,
                              conBzc,
                              conCal,
                              conCorImo,
                              conCorInd,
                              conDac, conDacGroupFML,
                              conDox,
                              conDup,
                              conDux,
                              conEuc,
                              conFar,
                              conFut,
                              conGen,
                              conGla,
                              conGlo,
                              conHyd,
                              conInt,
                              conLec,
                              conInq,
                              conIqu,
                              conKil,
                              conKild,
                              conLaz,
                              conLik,
                              conLkd,
                              conLks,
                              conLkc,
                              conMaz,
                              conMza,
                              conMzd,
                              ConAjt,
                              conMzi,
                              conSpa,
                              conMon,
                              conNex,
                              conPPG,
                              conPPX,
                              conRec,
                              conRei,
                              conRen,
                              conRsi,
                              conSay,
                              conSal,
                              conShe,
                              conShw,
                              conSky,
                              conSol,
                              conSta,
                              conStaWeb,
                              ConSuv,
                              conUni,
                              conVel,
                              conWanda, conWandaLinha, conWandaPro, conWandaProLinha,
                              conWeg,
                              conZyn,
                              conInk,
                              conKre,
                              conKin,
                              conRob,
                              conMax,
                              conAlp,
                              conBsn,
                              conCsn,
                              conGbc,
                              conClb,
                              conBlt,
                              conAlk,
                              conCoa,
                              conC11,
                              conTex,
                              conChr,
                              conAds,
                              conDu2,
                              conLei,
                              conMae,
                              conSin,
                              conDca,
                              conLuz,
                              conRep,
                              conMif,
                              conPrt,
                              conAn2,
                              conRs2,
                              conLca,
                              conAlv,
                              conPfa,
                              conAla,
                              conBla);

  TTipAltBoca = (talFator, talValor);
  TTipItemBombeamento = (tbTaxaMinima, tbItemBombeamento);
  TTipoFiltraVendedorConsCli = (tfvNenhum, tfvCadCliente, tfvReimprDocs, tfvCRM);

  TfncRetNome      = function (strCodigo: String): String;
  TfncRetNomeConst = function (Const strCodigo: String): String;

  TfIncluiItem     = function(strCodIte,
                              strNumLot: String;
                              fltQtdIte: Double;
                              fltUnitar: Double = 0;
                              strSeqRcd: String = '';
                              strDesIteRemessaEqu: String = '';
                              strNcmIte: String = '';
                              fltDescon: Double = 0;
                              AstrDescricaoItem : String = '';
                              AMantemPreco: Boolean = False;
                              ACodEmpresa: String = '';
                              ACompleItem: String = '';
                              strEntRet: String = '';
                              strLocRet: String = '';
                              strMotFut: String = '';
                              strEntFut: String = ''): Boolean Of Object;

  TTipoPrecoImpItem = (tpPrecoTabelaAtualSemDesconto,
                       tpPrecoTabelaAtualComDesconto,
                       tpPrecoDocumentoOriginalSemDesconto,
                       tpPrecoDocumentoOriginalComDesconto,
                       tpNenhumaDefinicao);

  TTipoPrecoImpItemHelper = record helper for TTipoPrecoImpItem
    function  GetName : String;
    function  GetValue: String;
    procedure SetValue(Value : String);
  end;

  TOpcaoEtiqueta = (opcFaturamento, opcAvulsa);
  TOrigemPedido  = (oriTodas, oriBalcao, oriPocket, oriSite);

  TItemEtiqUnRestante = record
    intAutInc : Integer;
    intOrdIte : Integer;
    strCodItem: String;
    fltQtdItem: Double;
  end;

  TArrItensEtiqUnRestante = Array Of TItemEtiqUnRestante;

  TfncRetNomeParam = function (strCodigo: String; arrCod: TConsultasArray = nil; strAutIncrem: String = ''): string;

  TDataModuleClass = Class Of TDataModule;

  TprcScroll = procedure (DataSet: TDataSet) Of Object;

  TfuncValidaDataEntIme = function (dtaEntreg: TDateTime): Boolean of object;

  {* untRelRecebimento *}
  TRelacionamentoEmpresa = (reMovimentacao, reVendedor);
  TOpVendedorRepresentante = (opVendedor,
                              opRepresentante,
                              opSupGeral,
                              opSupRegional,
                              opVenCadCli,
                              opDigitador,
                              opParticipante1,
                              opParticipante2,
                              opProjetista1,
                              opProjetista2,
                              opQuimico,
                              opGerente);

  {* untFastPrintEditor *}
  TFastFileType = (ffLaser, ffMatrix);

  {* untTMetAno *}
  TRecMes = record
    intMes: Integer;
    fltDiasUteis: Double;
    fltMetaProjetada: Double;
    fltMetaRealizada: Double;
    fltMargemRealizada: Double;
    fltCustoMes: Double;
    fltResultado: Double;
    strMesAno: String;
    strMesAnoNum: String;
    fltMargemProjetada: Double;
    fltMetaDiariaProjetada: Double;
    fltLitragemProjetada: Double;
    fltLitragemRealizada: Double;
  End;

  TSfaStatusPagamento = (sspAguardandoPagamento, sspPagamentoAprovado, sspPagamentoReprovado, sspBranco);

  TSituacaoLancBancario = (sitConciliado, sitNaoConciliado, sitTodos, sitConc_NaoConc);

  TRecFiltros = Record
    strNomVar,
    strNomFil: String;
    blnTitulo: Boolean;
  End;

  TArrRecFiltros = Array Of TRecFiltros;

  {*****************************************}
  {* REPRESENTA UMA FILA DE IMPRESSÃO      *}
  {**************************************MV*}
  TFilasImp = Record
    strNomeFila: String;
    blnMostrar : Boolean;
  End;

  TarrFilas = Array Of TFilasImp;

  TProCod = record
    strNomArq: string;
    strCodSeq: string;
    intTamCod: integer;
    strCodAut: string;
    intAutInc: integer;
  End;

  TarrProCod = Array of Tprocod;

  TFormulEtiq = Record
    strNomFrm: String;
    strNomImp: String;
    strIdePro: String;
    strDesTin: String;
    strDilCon: String;
    strDtaEmi: String;
    strMontad: String;
    strAnoTin: String;
    fltQtdTin: Double;
    strCodBar: String;
    strNomOpe: String;
    strNomBas: String;
    strCodigo: String;
    strNumLot: String;
    strDtaFab: String;
    strCompon: String;
    strReduto: String;
    strConteu: String;
    strLinha : String;
    strCatali: String;
    //Cliente
    strCodCli: String;
    strNomCli: String;
    strEndere: String;
    strEndNum: String;
    strBairro: String;
    strCidade: String;
    strEstado: String;
    strC_E_P_: String;
    strFone01: String;
    strFone02: String;
    //Documento Formatado(Numdoc+Espdoc+Codemp)
    strDocume: String;
    strObsCol: String;
    strDtaVal: String;
  End;

  {* untFuncoesEditorFast *}
  TOpcAbastecimento = (opcSolicitado, opcNaoSolicitado, opcTodos);

  TOpcAbastecimentoHelper = record helper for TOpcAbastecimento
    function ToString: string;
    function FromString(AValue: string): TOpcAbastecimento;
  end;

  TOpcaoCriacao  = (opcCadastro, opcOperacoes, opcFuncoes, opcConsulta);
  TTipoLocalizacao = (locPageHeader, locHeaderData, locMasterData, locFooterData, locPageFooter, locFooterDataLinha1, locPageFooterLinha1);
  TcolMatricial = (col40, col80, col96, col137, col160, colVazio);
  TTipoDocumento = (docVazio, docMI, docFF, docBR, docTR, docDV, docAJ, docTA, docEP, docBE, docUS, docCS, docCR, docTE, docPI,
                    docPD, docOR, docPR, docNF, docIF, docTicketNF, docTicketDV, docSF, docD1, docSeparacaoGondola, docGA, docContGC, docGF, docContGF, docContGR,docContGRBaixa, docSolicitacaoManutencaoEquipamentos, docPedidoCompra, docOrdPro, docSepSF,
                    docSepNota, docSepNotaObs, docSepPedido, docCupomServico, docSepRomaneio, docSepItem, docOrdemServico, docOrdemServicoTermoResp, docOrdemServicoTermoDev, docOrdemServicoOrdExecucao, docOrdemServicoImagem, docRequisicao, docPA,
                    docROTin, docReqMaterialConsumo, docReqMaterialConsumoVidro, docNS, docLiberacaoArmazenagem, docCarnePagamento, docDuplicata, docInspecaoEnt, docInspecaoSai,
                    docComprovanteGeracaoCredito, docProcessoDeExtrusao, docRecAmostra, docOrdProImobiliaria, docOrdProAutomotiva, docLocacaoEquipamento, docRL, docDevolucaoLocacao, docFaturaLocacao, docRB, docEnderecamentoDeProduto,
                    docPDExterior, docORExterior, docCupomPromocao, docRemessaDevolucao, docFFDocumentosCR, docCupomProxDesc);

  TOpcAgrupaSepRomaneio = (opcCliente, opcPedido, opcNaoAgrupa);

  TOpcAgrupaSepRomaneioHelper = record helper for TOpcAgrupaSepRomaneio
    function ToString: string;
    function FromString(AValue: string): TOpcAgrupaSepRomaneio;
  end;

  TOpcTipoCalculoOrcamento = (opcAbaixoMinimo, opcAcimaMax, opcVendaReposicao);

  TOriImpressaoLiberaArmazenagem = (oriLibEntradaDadosCaixa, oriLibEntradaDadosFiscaisResumo, oriLibEntradaMercadoriaSimplificada, oriLibConferenciaEntradaMercadoria,
                                    oriLibEnderecamentoProduto, oriLibReimpressaoLiberacaoDocUnico, oriLibReimpressaoLiberacaoDocMultiplo, oriLibPreNota);

  TRecFonteMatricial = Record
    blnNegrito,
    blnItalico,
    blnSublinhado,
    blnSuperScript,
    blnSubScript,
    blnCondensado,
    blnExpandido,
    bln12cpi,
    bln15cpi,
    blnWide: Boolean;
  End;

  TRecDocumento = Record
     strNumDoc,
     strEspDoc,
     strCodEmp,
     strCodCli,
     strSerie_,
     strTipFc,
     strCodAca,
     strEmpAca,
     strEmpPrd,
     strDtaCad,
     strCodOrd: String;
     strParcel: String;
     SeparacaoGondolaFiltro: TSeparacaoGondolaFiltro;

     blnZonaFranca: Boolean;
     blnMltCom: Boolean;
     blnQtdPen: Boolean;
     blnReimpr: Boolean;
     blnDocCan: Boolean;        // DOCUMENTO CANCELADO
     blnQtdOri: Boolean;
     blnOpcFat: Boolean;
     intQtdImp: Integer;         // NUMERO DE COPIAS
     blnTemLay: Boolean;         // RETORNA SE TEM LAYOUT DEFINIDO PARA ESSA ESPECIE
     blnImprimiu: Boolean;
     blnConfir: Boolean;         // SE É CONFIRMAÇÃO DE DOCUMENTOS
     blnFilEmp: Boolean;

     blnDocSep: Boolean;         // SE É SEPARAÇÃO
     strWhereSep: String;        // Condição where utilizada para filtrar os itens da separação (ver untCfgFilasImpressaoSeparacao)
     blnSepPendRomaneio: Boolean; // Separação apenas de Produtos pendentes de Romaneio

     blnAjMl: Boolean;
     blnEnt_CD: Boolean;
     blnImpFil: Boolean;
     blnSepFut: Boolean;
     dtaSepFut: TDate;
     hraSepFut: TTime;
     blnSimples: Boolean;
     blnPerTot: Boolean;
     blnTicketNF: Boolean;
     blnTicketDV: Boolean;

     blnSempreEntr,
     blnRequisicao,
     blnVidro,
     blnLocFisEmpEmi,
     blnCancelamento: Boolean;   // CANCELAMENTO DE DOCUMENTOS
     blnImpExpedicao: Boolean;

     blnOrdProImo: Boolean;   // ORDEM DE PRODUÇÃO TINTAS IMOBILIARIAS
     blnOrdProAut: Boolean;   // ORDEM DE PRODUÇÃO TINTAS AUTOMOTIVAS

     strEspSel,                  // ESPECIE DO CANCELAMENTO
     strSaida,                   // IMPRESSAO [VIDEO,IMPRESSORA]
     SeqFatEnd,
     strEntFut,
     strNomPro,
     strDesPro,
     strNomImp,
     strTipImp,
     strDtaVen,
     strGerRom: String;

     // USADO NO PD/OR DE VENDA
     strSetor,
     strSepPedEntregaOuRetira: String;

     strCodLse: String;

     blnAgruparItensSeparacao: Boolean;

     opcAbastecimento: TOpcAbastecimento;
     blnSomenteEmpDifSep: Boolean;

     opcAgrupaPor: TOpcAgrupaSepRomaneio;
     blnSomenteNaoImp: Boolean;

    {$IFDEF LINUX}
    {$ELSE}
     cdsLogSeparacao: TUniClientDataSet;
    {$ENDIF}
     strCodLay   : String;
     blnGerPdf   : Boolean;
     strPasPdf   : String;
     blnVisPdf   : Boolean;
     blnPenExp   : Boolean;
     strCodIte   : String;
     blnSemProgesso,
     blnNaoSelImp: Boolean;
     strOrdem : String;

     TextoQrCodePix: String;

     blnCarnePagamento: Boolean;
     blnDuplicata: Boolean;


     blnComprovanteGeracaoCredito: Boolean;

     blnProcessoDeExtrusao: Boolean;

     blnEnderecamentoDeProduto: Boolean;

     blnPDExterior: Boolean;
     blnORExterior: Boolean;

     blnInspecaoEnt : Boolean;
     blnInspecaoSai : Boolean;
     strEquipamentos : String;

     strMensNovo     : String;
     strMensExcluido : String;
     strEmpCabecalho_CD : String;
     blnCabecalhoCD     : Boolean;

     strEmpDoctoVenda : String;
     strNumRom: String;

     blnLiberacaoArmazenagem : Boolean;

     strIdeDig : string;
     intSeqPar : integer;
     strModeloImpressao : string;
     blnExiApl : Boolean;
     blnFiltroPorAutoIncrem : Boolean;

     stlTipFC: TStringList;
     stlDocumentos: TStringList;
     stlEspecies: TStringList;
     stlSeries: TStringList;
     stlEmpresas: TStringList;
     stlFornecedores: TStringList;
     stlListaMovGer: TStringList;

     oriLibOrigem: TOriImpressaoLiberaArmazenagem;
     strIncPed: string;
     stlListaItens : TStringList;
     blnImpSepPickingCheckOut : Boolean;
     blnFatAut : Boolean;
     blnCupomPromocao: Boolean;
     strNroCon: String;
     strNumCup: String;
     blnImpressaoColetor: Boolean;
     blnReimpressaoGR: Boolean;
     strNumRem: string;
     intQtdIte: Integer;
     blnTinAut: Boolean;
     blnPedidoCompra: Boolean;
     strCodPro: String;
     blnDocumentoCreditoFF: Boolean;
     fltQtdSep: Double;
     strAutInc: String;
     intSeqSepPar: Integer; //sequencial da separação parcial
  End;

  TTipoEtiqueta = (tpeNenhum,
                   tpeClienteLaser,
                   tpeClienteArgox,
                   tpeClienteMatricial,
                   tpeFornecedorLaser,
                   tpeFornecedorArgox,
                   tpeFornecedorMatricial,
                   tpeDiversosLaser,
                   tpeDiversosMatricial,
                   tpeDiversosArgox,
                   tpeEstruturaArgox,
                   tpeOperadorLaser,
                   tpeOperadorMatricial,

                   {* ITENS *}
                   tpeItensLaser,
                   tpeItensLaserCodBarPadr,
                   tpeItensLaserCodBarPers,
                   tpeItensLaserCodBarSPre,

                   tpeItensZebraGondolaCPre,
                   tpeItensZebraGondolaSPre,
                   tpeItensZebraCodBarCPre,
                   tpeItensZebraCodBarSPre,

                   tpeItensArgoxGondolaCPre,
                   tpeItensArgoxGondolaCPreLayout1,
                   tpeItensArgoxGondolaSPre,
                   tpeItensArgoxCodBarCPre,
                   tpeItensArgoxCodBarSPre,
                   tpeItensMatricial,

                   {* ITENS DE ORCAMENTO E PEDIDO*}
                   tpeItensOrcPedLaser,
                   tpeItensOrcPedLaserCodBar,

                   tpeItensOrcPedZebraGondolaCPre,
                   tpeItensOrcPedZebraGondolaSPre,
                   tpeItensOrcPedZebraCodBarCPre,
                   tpeItensOrcPedZebraCodBarSPre,

                   tpeItensOrcPedArgoxGondolaCPre,
                   tpeItensOrcPedArgoxGondolaSPre,
                   tpeItensOrcPedArgoxCodBarCPre,
                   tpeItensOrcPedArgoxCodBarSPre,
                   tpeItensOrcPedMatricial,

                   {* DESPACHO DE MERCADORIAS *}
                   tpeDespachoLaser,
                   tpeDespachoLaserECommerce,
                   tpeDespachoArgox,
                   tpeDespachoMatricial,
                   tpeDespachoFaturarExpedidoLaser,
                   tpeDespachoFaturarExpedidoArgox,
                   tpeEtiquetaDespachoVolumeGeralArgox,
                   tpeEtiquetaDespachoVolumeIndividualArgox,
                   tpeEtiquetaDespachoVolumeGeralLaser,
                   tpeEtiquetaDespachoVolumeIndividualLaser,

                   (* TINTA DE MAQUINA *)
                   tpeEntregaTintaMaquina,
                   tpeFomulacaoTinta,
                   tpeProducaoTintaMaquina,

                   (* UNIDADES RESTANTES *)
                   tpeUnidadesRestantesFat,
                   tpeUnidadesRestantesArgoxFat,

                   tpeUnidadesRestantesAvu,
                   tpeUnidadesRestantesArgoxAvu,

                   tpeOPIndustrial,
                   tpeOPIndustrialArgox,

                   tpeFuncionarioLaser,
                   tpeFuncionarioArgox,

                   tpeMI,
                   tpeFF,
                   tpeBR,
                   tpeAmostraProdutoAuto,
                   tpeTR,
                   tpeDV,
                   tpeAJ,
                   tpeTA,
                   tpeEP,
                   tpeBE,
                   tpeUS,
                   tpeCS,
                   tpeCR,
                   tpeTE,
                   tpePI,

                   tpePD,
                   tpeOR,
                   tpePR,

                   {* ORDEM DE PRODUÇÃO PARA TINTAS INDUSTRIAIS/IMOBILIARIA *}
                   tpeOrdProImobiliaria,
                   {* ORDEM DE PRODUÇÃO PARA TINTAS AUTOMOTIVAS *}
                   tpeOrdProAutomotiva,

                   tpePA,
                   tpeROTin,
                   tpeSeparacaoGondola,
                   tpeGA,
                   tpeContGC,
                   tpeGF,
                   tpeContGF,
                   tpeContGR,
                   tpeContGRBaixa,
                   tpeSolicitacaoManutencaoEquipamentos,
                   tpePedidoCompra,
                   tpeOrdPro,

                   tpeNF,
                   tpeIF,
                   tpeTicketNF,
                   tpeTicketDV,
                   tpeSF,

                   tpeD1,

                   tpeSepNota,
                   tpeSepNotaObs,
                   tpeSepSF,
                   tpeSepPedido,
                   tpeCupomServico,
                   tpeSepRomaneio,
                   tpeSepItem,
                   tpeOrdemServico,
                   tpeOrdemServicoTermoResp,
                   tpeOrdemServicoTermoDev,
                   tpeOrdemServicoOrdExecucao,
                   tpeOrdemServicoImagem,
                   tpeReqMaterialConsumo,
                   tpeReqMaterialConsumoVidro,

                   tpeLiberacaoArmazenagem,

                   {* VENDA CREDIÁRIO *}
                   tpeCarnePagamento,
                   tpeDuplicata,

                   {* INSPECAO DE ENTRADA E SAIDA}
                   tpeInspecaoEnt,
                   tpeInspecaoSai,

                   tpeComprovanteGeracaoCredito,

                   (* Ordem de produção industrial *)
                   tpeProcessoDeExtrusao,

                   (* Locação Equipamentos *)
                   tpeLocacaoEquipamento,
                   tpeRL,
                   tpeDevolucaoLocacao,
                   tpeFaturaLocacao,

                   {* Recebimento Venda Base Troca*}
                   tpeRB,

                   (* Endereçamento de Produto *)
                   tpeEnderecamentoDeProduto,

                   (* Pedido de Venda Exterior *)
                   tpePDExterior,

                   (* Orçamento de Venda Exterior *)
                   tpeORExterior,

                   (* Cupom Promoção *)
                   tpeCupomPromocao,

                   (* Remessa de Devolução *)
                   tpeRemessaDevolucao,
                   tpeFFDocumentosCR,
                   tpeCupomProxDesc,
                   tpeRequisicao,

                   (* PRECIFICAÇÃO DE PRODUTOS *)
                   tpePrecificacaoProdutosLaser,
                   tpePrecificacaoProdutosArgox,

                   (* ITENS CONTROLADOS *)
                   tpeItensControladosLaser,
                   tpeItensControladosArgox,

                   {* ORDEM DE SERVIÇO *}
                   tpeOrdemServicoLaser,
                   tpeOrdemServicoArgox,
                   tpeOrdemServicoZebra,

                   {* ORDEM DE SERVIÇO VENDA *}
                   tpeOrdemServicoVendaLaser,
                   tpeOrdemServicoVendaArgox,
                   tpeOrdemServicoVendaZebra,

                   (* ITENS COM OBRIGATORIEDADE DE CPF *)
                   tpeItensCPF,
                   tpeItensCPFArgox,

                   (* Etiqueta da empresa *)
                   tpeEmpresaLazer,
                   tpeEmpresaArgox,

                   (* Ordem de produção NÃO industrial *)
                   tpeOrdemProducao,
                   tpeOrdemProducaoArgox,
                   tpeOrdemProducaoZebra,

                   (* Etiqueta de Localização Física *)
                   tpeLocFisLaser,
                   tpeLocFisArgox,

                   tpePlanoRecebWMSLaser,
                   tpePlanoRecebWMSArgox,

                   tpeSeqSeparacaoWMSLaser,
                   tpeSeqSeparacaoWMSArgox,

                   (* ETIQUETA DE CAIXAS *)
                   tpeCaixasLaser,
                   tpeCaixasArgox,
                   tpeArmazenamento,
                   tpeArmazenamentoArgox,
                   tpeArmazenamentoZebra,
                   {* NOTA DE SERVIÇO *}
                   tpeNS,

                   (* Etiqueta do produto que foi separado a mais na Expedicao de Saída *)
                   tpeCodBarrasProduto,
                   tpeSepErrLaser,
                   tpeSepErrArgox,

                   (* ETIQUETA DE MONTAGEM DE CAIXAS *)
                   tpeMontagemCaixasLaser,
                   tpeMontagemCaixasLaserCodBarras,
                   tpeMontagemCaixasLaserPackList,
                   tpeMontagemCaixasZebraPackList,

                   {* LOTE PRODUTO *}
                   tpeMarmoreGranito,
                   tpeMarmoreGranitoArgox,
                   tpeEtiquetaDoProdutoSeparadoArgox,
                   tpeEtiquetaDoProdutoSeparado,
                   tpeLoteProdutoArgox,
                   tpeLoteProduto,

                   {* LOTE RASTREAMENTO *}
                   tpeLoteRastreamentoProdutoLaser,
                   tpeLoteRastreamentoProdutoArgox,
                   tpeLoteRastreamentoProdutoZebra,

                   {* LOCAL DE ARMAZENAMENTO - WMS *}
                   tpeLocalArmazenamentoWmsLaser,
                   tpeLocalArmazenamentoWmsArgox,

                   {* CADASTRO DE REGIOES *}
                   tpeRegiaoLaser,
                   tpeRegiaoArgox,

                   tpeMontagemCaixasArgox,
                   tpeMontagemCaixasZebra,

                   tpeProdutosControladosVendasArgox,
                   tpeProdutosControladosVendasLaser,
                   tpeProdutosControladosVendasZebra,

                   tpeDespachoProdutoArgox,

                   tpePlanoDeRecebimentoEtiquetaIDLaser,
                   tpePlanoDeRecebimentoEtiquetaIDArgox,

                   tpeProdutoQuantidadeFracionadaLaser,
                   tpeProdutoQuantidadeFracionadaArgox);

  {* untReguaEditor *}
  TTipoLayout = (tplDocumentos, tplEtiquetas);

  TCartoesResumoCaixa = Record
    strNumDup: String;
    intCodSeq: Integer;
    strCodCar: String;
    strDesCar: String;
    fltValDig: Double;
    fltValDes: Double;
    fltPerDes: Double;
    fltTaxMkt: Double;
    fltFreMkt: Double;
    fltCupMkt: Double;
    strCndPag: String;
    strObsCar: String;
    strNumCcd: String;
    strCodFin: String;
    strArqTef: String;
    strTipCar: String;
    fltValIpi,
    fltValRet,
    fltValAce,
    fltValFre,
    fltValCbs,
    fltValIbs,
    fltVal_Is: Double;
    strNumNsu: String;
    strConteudoArquivo: String;
    strCodOpe: String;
    dtaDtaCad: TDateTime;
    strPorCar: String;
    strCtaCar: String;
    intQtdPar: Integer;
    strChaPix: String;
    strPixS_N: String;
    strCodigoCarteiraDigital: String;
    strViaCli: String;
    strViaLoj: String;
    strNumDoc: String;
    strDtaTra: String;
    strHraTra: String;
    strStatusCartao: String;
    dtaDtaTra: TDateTime;
    strControle: String;
    strObsCar2: String;
    blnTefCnf: Boolean;
    strCodigoTipoOperacaoCartao: string;
    strCodigoBandeira: string;
  End;
  TCartoesResumoCaixaArray = Array Of TCartoesResumoCaixa;
  TCartoesFinanceira = Array Of Record
    strCodFin: String;
    arrCartao: TCartoesResumoCaixaArray;
  End;

  TTipoRegistroMovBan = (trmNenhum, trmBaixaReceber, trmBaixaPagar,
                         trmBaixaCartoes, trmDepositoCheques, trmAdiantamentoDeCliente);

  TFunctionProCodContabilidadeAdicionar = procedure(var arrProCod : TarrProCod; var intPosMat: Integer) of object ;
  TFunctionCfgRepositorioContabilidadeAdicionar = procedure of object ;
  TFunctionCfgRepositorioContabilidadeProperty = procedure (strCodCfg: String; var AProperties: Pointer; var intInd: Integer; ACfgRepositorio: Pointer) of object ;
  TProcTracerContabilidadeSetQueryEvent = procedure (const AQuery: TUniQuery) of object ;
  TProcLimparDicionarioCampoTabelaContabilidade = procedure of object ;

  TprcShowPreview = procedure (cdsDados: TDataSet) Of Object;

  TTiposEtiqueta = (etiVazio, etiItensCPF);

  TFiltroOrdServProd = (odTodos, odBaixados, odNaoBaixados);

  TPrcMostraContaCorrente = Procedure Of Object;
  TProcOnTimer = Procedure (Sender: TObject) Of Object;

  TpImprimePedidoCompra = procedure(strNumPed,
                                    strEspDoc,
                                    strCodEmp: String); stdcall;

  TFunctionCfgRepositorioCartoesAdicionar = procedure; StdCall;
  TFunctionCfgRepositorioAntecipacaoRedeCardAdicionar = procedure; StdCall;
  TFunctionCfgRepositorioCartoesProperty = procedure(ACodigoConfiguracao: String; var AProperties: Pointer; var AIndiceCfg: Integer; ACfgRepositorio: Pointer); StdCall;
  TFunctionCfgRepositorioAntecipacaoRedeCardProperty = procedure(ACodigoConfiguracao: String; var AProperties: Pointer; var AIndiceCfg: Integer; ACfgRepositorio: Pointer); StdCall;
  TFunctionCfgRepositorioCartoesCreateProperties = procedure(var ACfgRepositorio: Pointer) Of Object;

  {$IFNDEF LINUX}
  TFunctionCfgRepositorioCartoesValidar = procedure(var ADatasetCfg: TUniClientDataset; AAdicionarConfigDuranteValidacao: Boolean; var AResultado: Boolean; AFiltroEmpresa: Boolean = True); StdCall;
  {$ENDIF}

  TChequeEmitido = Record
    strCodBco: String;
    strNumAge: String;
    strConCor: String;
    strNumChq: String;
    strDtaBom: String;
    strDtaEmi: String;
    strFavore: String;
    fltValChq: Double;
    blnChqVis: Boolean;
  End;

  TChequeRepassado = Record
    strCodBco: String;
    strNumAge: String;
    strConCor: String;
    strNumChq: String;
    strDtaBom: String;
    strDtaEmi: String;
    strEmpChq: String;
    strCtaDep: String;
    strCodCta: String;
    strHistor: String;
    strCodCli: String;
    strAutInc: String;
    dtaDtaDep: TDateTime;
    fltValChq: Double;
  End;

  TAlqOrgDemaisImpostos = Record
    fltImpFed : Double;
    fltDesOpe : Double;
    fltOutVal : Double;
    fltIcmSai : Double;
  End;

  {**************************************************************}
  {* CONFIGURAÇÃO FUNCIONA DE FORMA BINARIA, PARA INCLUIR OUTRA *}
  {* OPÇÃO, BASTA INCLUIR SUA DESCRIÇÃO E DOBRAR O ULTIMO VALOR *}
  {* NO  "TOpcCliPro"  EXEMPLO, ULT. = 2 O PROXIMO SERÁ 4, APOS *}
  {* O 4 SERA 8, APOS 16, 32, 64, 128 E ASSIM POR SEQUENCIA     *}
  {* Exemplo para inserir as Proximas Opçoces                   *}
  {* TOpcCliPro = (opcPdOrNf = 1, opcEtiqueta = 2, opcTeste = 4)*}
  {* -----------------------------------------------------------*}
  {* Utilizar sempre a funcao fRetUtilizaCliPro para verificar  *}
  {* a composição da Configuração                               *}
  {* -----------------------------------------------------------*}
  {* Ao incluir uma nova opçao Em TOpcCliPro Colocar a Descrição*}
  {* da Mesma na untFuncoesSimples.fRetDescOpcCliPro e já vai   *}
  {* funcionar tudo, ai é so utilizar a fRetUtilizaCliPro       *}
  {* Exemplo:   (opcPdOrNf in fRetUtilizaCliPro)                *}
  {* -----------------------------------------------------------*}
  {* Caso for incluir uma nova opção e ela tiver que ser default*}
  {* True ( opção marcada ) enviar update somando o valor da opc*}
  {* UPDATE CFGSIS SET SIS_VALCFG = SIS_VALCFG + X              *}
  {* WHERE SIS_CODCFG = "CFG_ACLPRO"                            *}
  {* onde X é o valor do bit da nova configuração               *}
  {***********************************************************GB*}
  TOpcCliPro = (opcPdOrNf = 1, opcEtiqueta = 2);
  TUtilizaCliPro = Set Of TOpcCliPro;
  TOpcStatusProd = (sprTodos, sprAtivo, sprInativo);

  TDadosVeiculo = Record
    strPlaVei: String;
    strKM_Vei: String;
    strMarVei: String;
    strModVei: String;
    strAnoVei: String;
    strCorVei: String;
    strCondut: String;
    intCapCar: Integer;
  End;

  TrecDadosTransportadora = Record
    strCodTra: String;
    strNomTra: String;
    strCidTra: String;
    strEstTra: String;
    strFone01: String;
    strCnpTra: String;
    strIesTra: String;
    strEndere: String;
    strBairro: String;
    strCepTra: String;
  End;

  TItemExpedido = Record
    strSeqIte: String;
    strCodIte: String;
    fltQtdIte: Double;
    fltQtdExp: Double;
    fltQtdDes: Double;
  End;

  TItensExpedidosPedido = Array Of TItemExpedido;

  {* Conciliação de Cartões de Crédito *}
  TCamposConcil = Record
    strTabCon,
    strCamCon,
    strNomCon,
    strConfEs,
    strValBru,
    strValLiq,
    strCodCon,
    strCodAut,
    strNumNSU,
    strDtaTra,
    strID,
    strNumPar,
    strTotPar,
    strNumCar,
    strDtaRec,
    strConfPr,
    strConfCt,
    strConfFo,
    strConfCp,
    strTipReg,
    strTipTra,
    strEventoCancelamentoAjuste,
    strChavePrimaria,
    CfgPortadorTransferencia,
    CfgPlanoDeContasTransferencia,
    CfgCentroDeCustosTransferencia,
    CfgVlrTolerancia,
    CodigoEmpresaFixaParaBaixa: String;
  End;

  TArrBaiSinCar = Record
    fltValDoc,
    fltValTax,
    fltValAnt,
    FreteMarketPlace,
    AjusteMarketPlace,
    CupomMarketPlace,
    SubtrairFrete : Double;

    dtaDtaRec    : TDateTime;

    strCodEmp,
    strSeqLanCre,
    strSeqLanDeb,
    strSeqLanTax,
    strSeqLanAnt,
    strPorBai,
    strCtaBai,
    strEventoCredito,
    strPorTax,
    strCtaTax,
    strForTax,
    strEventoTaxa,
    strPorBad,
    strCtaBad,
    strEveDeb,
    strHisDoc,
    strNumDoc,
    strDocBai,
    strCtaAnt,
    strTipAju,
    strEventoCancelamentoAjuste,
    PlanoDeContasParaCTPDet,

    SeqLanFreteMkt,
    SeqLanAjusteMkt,
    SeqLanCupomMkt,

    PlanoDeContasFreteMkt,
    PlanoDeContasAjusteMkt,
    PlanoDeContasCupomMkt,

    SeqlanTaxaNegociacao,
    PlanoDEContasTaxaNegociacao: String;

    intPagCon,
    intQtdCar    : Integer;
  End;

  Type
    TSeqLanCar = Record
      intDocTot,         //Total de SeqLans
      intDocIni,         //SeqLan Inicial
      intPagTot,         //Total de PagCons
      intPagIni: Int64;  //PagCon Inicial
  End;

  Type
    TSequenciaisBaixaCartao = record
      intSeqLan,
      intSequencialCadPag,

      intContadorAutIncMovBan,
      intContadorAutIncBanMca,
      intContadorAutIncCadPag,
      intContadorAutIncLogMca,
      intContadorAutIncLogCtp,

      SequencialControleBaixaPagar: Int64;

      NumeroDocumentoBaixa: String;
  end;

  {* Metas de Contas a Pagar a partir de Rateio *}
  type
  TCtaMetas = Record
    strCodCta: String;
    strCodEmp: String;
    dtaDtaPar: TDate;
    fltValDup: Double;

  End;

  TTipoAltPrecoFranq = (taPrecoCusAltPreVen, taPrecoCusAltMargem, taPreVenAltMargem);
  TRetornoImagem = (riOK, riErro, riNulo, riNaoConfig);

Type
  TDadosRota = record
    strCodRot: String;  // Código da rota           - ENT_CODIGO [ENTREG]
    strCodReg: String;  // Código da região         - ENT_CODREG
    strVeiPad: String;  // Código do veículo padrão - REV_CODIGO [ROTREV]
  End;

type
  TOpcaoTEF =(toCliSiTef, toScope);

Type
  tpeFinalidadeXML = (xmlEntradaMercadoria = 0,
                      xmlConsertoEquipamento = 1,
                      xmlGarantiaRecCliente = 2,
                      xmlGarantiaRetFornecedor = 3,
                      xmlEntradaMercadoriasSistemaAnteriorDevolucao = 4,
                      xmlConsignacaoDevolucaoCliente = 5,
                      xmlRetornoSimbolico = 6,
                      xmlRetornoLocacao = 7,
                      xmlEntradaMercadoriaAuditoria = 8,
                      xmlDevolucaoEntradaEmitidaFornecedor = 9,
                      xmlCFG_IMPXGRGarantiaRetFornecedor = 10,
                      xmlCFG_UVNEGFEntMerRetornoFornecedor = 11,
                      xmlDevolucaoVendaCliente = 12,
                      xmlNfeAjuste = 13);

  tpeNfeToPedidoCompra = (ImpNotaEletronica = 0, FluxoCompras = 1);

  Const
    arrFinalidadeXML : array[xmlEntradaMercadoria..xmlDevolucaoVendaCliente] of String = ('Entrada de Mercadorias', //xmlEntradaMercadoria = 0,
                                                                                                     'Conserto de Equipamento', // xmlConsertoEquipamento = 1,
                                                                                                     'Garantia - Recebimento de Cliente', // xmlGarantiaRecCliente = 2,
                                                                                                     'Garantia - Retorno de Fornecedor', // xmlGarantiaRetFornecedor = 3,
                                                                                                     'Entrada Mercadorias sistema anterior para emissão de devolução', // xmlEntradaMercadoriasSistemaAnteriorDevolucao = 4,
                                                                                                     'Consignação - Devolução de Cliente', // xmlConsignacaoDevolucaoCliente = 5,
                                                                                                     'Retorno Simbólico',  // xmlRetornoSimbolico = 6,
                                                                                                     'Locação - Retorno de Cliente', // xmlRetornoLocacao = 7,
                                                                                                     'Entrada Mercadoria Auditoria', // xmlEntradaMercadoriaAuditoria = 8,
                                                                                                     'Devolução de Entrada Emitida por Fornecedor',  //xmlDevolucaoEntradaEmitidaFornecedor = 9
                                                                                                     'Garantia - Retorno do Fornecedor', // xmlCFG_IMPXGRGarantiaRetFornecedor = 10,
                                                                                                     'Entrada de Mercadorias - Retorno do Fornecedor', // Entrada de Mercadorias - Retorno do Fornecedor = 11
                                                                                                     'Devoluçao de Venda de Cliente');  // xmlDevolucaoVendaCliente = 12
    OPCAO_CLISITEF           = 'S';
    OPCAO_NCR                = 'T';

  function fGetFinalidadeXML(ASelected: String): integer;

Type
  TOnMensagem = reference to procedure(ATexto: String);

Var
  VS_ExibirMensagemAoUsuario: Boolean;
  VS_ExibirMensagemDeErro: Boolean;
  VS_ExibirMensagemAguarde: Boolean;
  VS_ExibirMensagemStayOnTop: Boolean;

  VS_strTrilhaMensagensTotem: String;
  VS_csTrilhaMensagensTotem: TCriticalSection;

  VS_OnMensagemAoUsuario: TOnMensagem;
  VS_OnMensagemDeErro: TOnMensagem;
  VS_OnMensagemAguarde: TOnMensagem;

  VS_TrimMemorySize : String;

  procLibCartoesInicializarObjetos: procedure of object;

  procLibContasBancariasInicializarObjetos: procedure of object;
  procLibContasBancariasFinaluizarObjetos: procedure of object;


  procCfgRepositorioContabilidadeAdicionar : TFunctionCfgRepositorioContabilidadeAdicionar;
  procCfgRepositorioContabilidadeProperty : TFunctionCfgRepositorioContabilidadeProperty;
  ProcTracerContabilidadeSetQueryEvent : TProcTracerContabilidadeSetQueryEvent;

  procCfgRepositorioCartoesAdicionar: TFunctionCfgRepositorioCartoesAdicionar;
  procCfgRepositorioAntecipacaoRedeCardAdicionar: TFunctionCfgRepositorioAntecipacaoRedeCardAdicionar;
  procCfgRepositorioCartoesProperty: TFunctionCfgRepositorioCartoesProperty;
  procCfgRepositorioAntecipacaoRedeCardProperty: TFunctionCfgRepositorioAntecipacaoRedeCardProperty;
  procCfgRepositorioCartoesCreateProperties: TFunctionCfgRepositorioCartoesCreateProperties;

  {$IFNDEF LINUX}
  procCfgRepositorioCartoesValidar: TFunctionCfgRepositorioCartoesValidar;
  {$ENDIF}

type
  // Metadata dos marketplaces para etiqueta unificada (CFG_EDUNIF).
  // Fonte unica da verdade de prefixo + nome amigavel exibido na UI.
  TInfoMarketplace = record
    Prefixo: String;       // Chave uppercase gravada em CFG_EDUNIF (ex: 'SHP_')
    NomeAmigavel: String;  // Label exibido no CheckGroup (ex: 'Shopee')
  end;

  // reuNaoUnificada: o marketplace esta no CFG_EDUNIF, mas a etiqueta saiu sem a
  // DANFE (nao coube, falhou ou a etiqueta nao foi impressa) - quem imprime precisa mandar a
  // DANFE separada.
  TResultadoEtiquetaUnificada = (reuNaoAplicavel, reuUnificada, reuNaoUnificada);

const
  // Lista oficial de marketplaces suportados pela etiqueta unificada.
  // Novo marketplace = adicionar aqui + criar unit Marketplace.EtiquetaDespachoUnificada.<Nome>
  // que se auto-registra via TRegistroProcessadores.pRegistrar.
  // Ordem alfabetica para UI estavel.
  VS_arrMarketplaces: array[0..2] of TInfoMarketplace = (
    (Prefixo: 'MLB_';    NomeAmigavel: 'Mercado Livre'),
    (Prefixo: 'SHP_';    NomeAmigavel: 'Shopee'),
    (Prefixo: 'TIKTOK_'; NomeAmigavel: 'TikTok Shop')
  );

Type
  TDocAdiantamento = Record
    //Dados do Pedido
    strAutInc: String;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodVen: String;
    dtaDtaEnt: TDateTime;
    horHorEnt: TDateTime;
    fltVlrCon: Double;
    fltBolAdt: Double;
    fltTotIpi: Double;
    fltTotRet: Double;
    fltDesAce: Double;
    fltTotFre: Double;
    fltTotCbs: Double;
    fltTotIbs: Double;
    fltTot_Is: Double;
    fltDupRec: Double;
    fltValAdt: Double;
    blnEnt_CD: Boolean;
    strCodCnd: String;
    strCodFpg: String;
    strFpgOri: String;
    strConPag: String;
    blnLibCom: Boolean;
    blnLibera: Boolean;
    strCodCar: String;
    intQtdPaC: Integer;
    //Dados do Cliente
    strCodCli: String;
    strNomCli: String;
    strEndere: String;
    strBairro: String;
    strEndCom: String;
    strEndNum: String;
    strC_E_P_: String;
    strCodCid: String;
    strFone01: String;
    strCgcCpf: String;
    strC_G_C_: String;
    strNomCid: String;
    strEstado: String;
    strEmail_: String;
    strCodAti: String;
    dtaNasCon: TDate;
    strNum_RG: String;
    strNumIes: String;
    //Valor do lancamento de adiantamento
    fltValLan: Double;
    //Sequencial de desmembramento de pedido
    strSeqDmp: String;

    blnCliGry: Boolean; // indica se é cliente da gryncash
    fltCshGry: Double; // indica o saldo a ser utilizado
    strIncAdt: String; // Autoincrem da Tabela ADTCLI(Adiantamento)
  End;

Type
  TArrDocAdiantamento = Array Of TDocAdiantamento;

Type
  TDadosAdiantamento = Record
    documentos: TArrDocAdiantamento;   // Dados do documento
    dtaDtaLan: TDate;                  // Data Lançamento
    horHorLan: TTime;                  // Data Lançamento
    strEmpLan: String;                 // Empresa do Lançamento
    strOpeLan: String;                 // Operador do Lançamento
    fltValLan: Double;                 // Valor do Lançamento
    fltValDin: Double;                 // Dinheiro
    fltValChV: Double;                 // Cheque a Vista
    fltValChP: Double;                 // Cheque Pre
    fltValCar: Double;                 // Cartao
    fltValOrd: Double;                 // Ordem de Pagamento
    fltValFin: Double;                 // Financiamento
    fltValCre: Double;                 // Utilizacao de Créditos
    fltValJur: Double;                 // Valor de Juros
    strTipLan: String;                 // Tipo de Lançamento
    strDescri: String;                 // Descricao
    strEstorn: String;                 // Estorno (S/N)
    intSeqCon: Integer;                // Sequencial de Controle
    strOrigem: String;                 // Origem do Adiantamento RCX / CTR
    blnPagueFacil: Boolean;            // Rotina Pague Facil - Recebimento de pedido
    strCodPor: String;                 // Código do Portador
    strCodCta: String;                 // Código do Plano de Contas
    strParcel: String;                 // Parcela (boleto)
    strNosNum: String;                 // Nosso número
    strDtaBol: String;                 // Emissao boleto
    strBcoBol: String;                 // Banco boleto
    strBcoEnv: String;                 // Banco de envio
    strDtaEnv: String;                 // data de Envio
    strCartei: String;                 // Carteira
    strLinDig: String;                 // Linha digitavel
    strCodCed: String;                 // Cod. Cedente
    strDocume: String;                 // Documento informado na baixa
    strPorCre: String;                 // Portador para gerar crédito no Contas a Receber
    fltCreGer: Double;                 // Valor de credito a ser gerado no Contas a receber
    RecebidoPorPix: Boolean;           // Indica que o valor da Ordem de Pagamento foi recebido por Pix
    ValorTFAutomatica: Double;         // Valor da transferência automática de ordem de pagamento
    PortadorTFAutomatica: String;      // Portador da transferência automática de ordem de pagamento
    dtaDtaBan: TDate;                  // Data Lançamento de movimentação bancária
    strCodPorOrdPagto : String;        // Código do Portador Para Ordem de Pagamento
    strSeqBan: String; // CTB_SEQLAN da MOVBAN
    procedure AddDocumento(documento: TDocAdiantamento);
  End;

Type
  TArrAdiantamentos = Array Of TDadosAdiantamento;

Type
  TTotaisAdiantamento = record
    fltValLan: Double;                 // Total dos Lançamentos
    fltValDin: Double;                 // Total Dinheiro
    fltValChV: Double;                 // Total Cheque a Vista
    fltValChP: Double;                 // Total Cheque Pre
    fltValCar: Double;                 // Total Cartao
    fltValOrd: Double;                 // Total Ordem de Pagamento
    fltValFin: Double;                 // Total Financiamento
    fltValCre: Double;                 // Total Utilizacao de Créditos
    fltValJur: Double;                 // Total de Juros
    blnExiAdt: Boolean;                // Existe lançamentos?
  End;

Type
  TArrTotaisAdiantamento = Array Of TTotaisAdiantamento;

type
  TDadosAdicCartao = record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strNumPok: String;
    dtaDtaCar: TDateTime;
    dtaDtaCup: TDateTime;
    fltTotVen: Double;
    fltTxDsGe: Double;
    fltTxDsPa: Double;
    strTxDsGe: String;
    strTxDsPa: String;
    intQtdPar: Integer;
    strCodVen: String;
  end;

Type
 TPedidoCompraCodigoFabricaProduto = (cfPrincipalProduto, cfFornedorPedidoCompra);


type
  TDespesasAduaneiras = record
    fltDemurr: Double;
    fltTaxArm: Double;
    fltDespac: Double;
    fltFrete_: Double;
    fltOutDes: Double;
    fltMulAdu: Double;
    fltFreInt: Double;
    fltF_500_: Double;
    fltTotalD: Double;
  end;

  TfMskCon = function: string;
  TfSemMascaraPlaNco = function (Valor: String): string;
  TfCampoTabelaPlanco= function(strCampo : String;
                                arrCampoChave: Array Of String;
                                arrValorChave: Array Of Variant;
                                blnSempreLerBanco: Boolean = True;
                                strOrderBy: String = ''):Variant;

  TfCriaQuery = reference to function(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
  TfCriarQuery = reference to function(strSQL: String; AOwner: TComponent = nil): TUniQuery;
  TfRetAutoIncrem = reference to function(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1; blnUsaTransacaoCorrente: Boolean = False; conexao: TUniConnection = nil): String;
  TfCfgSis = reference to function(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;

  TfEmptyStr = reference to function(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
  TpMensagemOk = reference to procedure(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);
  TfRetNomeOperador = reference to function(strCodOpe: String): String;
  TfGetTituloVersao = reference to function(): String;
  TfGetUsuarioLogado = reference to function(): String;
  TfGetEmpresaLogada = reference to function(): String;
  TfRetNomeRede = reference to function(): String;
  TfGetIPAddress = reference to function(): Integer;
  TfGetIPAddressAsString = reference to function(): String;
  TfGetMacAddress = reference to function(): String;
  TfGetUserFromWindows = reference to function(): String;
  TfGetComputerNetName = reference to function(): String;
  TfEntraCons = reference to function(strCodigo: String): Boolean;
  TfInTransaction = reference to function(objConexao: TUniConnection = Nil): Boolean;
  TpCriarFormularios = reference to procedure(Classe: TComponentClass; Var frmForm; appHandle: THandle = 0);
  TpFreeAndNil = reference to procedure(var frmForm);
  TpMensagensErro = reference to procedure(MensErro, LocalErro: String; strMensagem: String = ''; conexao: TUniConnection = nil);
  TfCampoTabela = reference to function(strCampo: String;
                                        strNomTab: String;
                                        arrCampoChave: Array Of String;
                                        arrValorChave: Array Of Variant;
                                        blnSempreLerBanco: Boolean = True;
                                        strOrderBy: String = '';
                                        Conexao: TUniConnection = Nil;
                                        blnUsarMax: Boolean = False): Variant;
  TfMensagem = reference to function (strTitulo   : string;
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

    TfCadastroRapidoCliente = function (Var strCodCli: String;
                                        strNomCli,
                                        strFanSob,
                                        strEndere,
                                        strEndNum,
                                        strEndCom,
                                        strBairro,
                                        strCodCid,
                                        strCep,
                                        strFone01,
                                        strCelula,
                                        strNum_Rg,
                                        strI_E_S_,
                                        strEmail,
                                        strEmNfe,
                                        strStatus,
                                        strContat: String;
                                        intCgcCpf: Integer;
                                        strC_G_C_,
                                        strCodRep,
                                        strCodVen: String;
                                        dta_DtaCad: TDate = 0;
                                        dta_DtaNas: TDate = 0;
                                        str_Fone02: String = '';
                                        str_HomePa: String = '';
                                        str_CodAti: String = '';
                                        strEmail2 : String = '';
                                        strNumFax : String = '';
                                        strObserva: String = '';
                                        strRgExp  : String = '';
                                        blnCadCliCon: Boolean = False;
                                        strCRMFre : String = '';
                                        strCRMPor : String = '';
                                        strCRMFai : String = '';
                                        strCRMCat : String = '';
                                        strCodReg : String = '';
                                        strCodCac : String = ''): Boolean of Object;

    TfCadastroRapidoTransportadora = function(var strCodTra: string;
                                              strNomTra,
                                              strNomFan,
                                              strEndere,
                                              strBairro,
                                              strCodCid,
                                              strNumCep,
                                              strFone01,
                                              StrEmail,
                                              strNumCgc,
                                              strFone02,
                                              strInsEst,
                                              strHomPag: string;
                                              intCgcCpf: integer): Boolean of Object;

    TfCadastroRapidoFornecedor = function(Var strCodFor: String;
                                          strNomFor,
                                          strNomFan,
                                          strEndere,
                                          strBairro,
                                          strCodCid,
                                          strNumCep,
                                          strFone01,
                                          strNumRg,
                                          strEmail,
                                          strStatus,
                                          strNumCgc,
                                          strFon02,
                                          strNumCel,
                                          strHomPag,
                                          strCodCli,
                                          strInsEst,
                                          strCodAti: String;
                                          intCgcCpf: integer): Boolean of Object;

   TRecEmailInvalidos = Record
    strCodCli: String;
    strEmail : String;
    strNomCli: String;
    strNomCid: String;
    strNom_UF: String;
    strFone01: String;
    strFone02: String;
  End;

Type
  TRegLivroFiscal = Record
    strClaFis: String;
    fltVlrCon: Double;
    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltValIcm: Double;
    fltOutras: Double;
    fltIsento: Double;
    fltRetido: Double;
    fltBasIpi: Double;
    fltValIpi: Double;
    fltBcReti: Double;
    fltDAcess: Double;
    fltValIss: Double;
    strCstPis: String;
    fltBasPis: Double;
    fltAlqPis: Double;
    fltValPis: Double;
    strCstCof: String;
    fltBasCof: Double;
    fltAlqCof: Double;
    fltValCof: Double;
    fltBasFCP: Double;
    fltValFCP: Double;
    fltAlqFCP: Double;
    fltIrSeRt: Double;
    fltPiSeRt: Double;
    fltCoSeRt: Double;
    fltCsSeRt: Double;
    fltBasFcpST: Double;
    fltValFcpST: Double;
    fltBasERet: Double;
    fltValERet: Double;
    fltBasIbs : Double;
    fltBasCbs : Double;
    fltBas_IS : Double;
    fltVlrIbs : Double;
    fltVlrCbs : Double;
    fltVlr_IS : Double;
  end;

  TLatLon = (coorLat, coorLon);

  TtpEventoReinf = (R2010, R2020, R2098, R2099, R4010, R4020, R4080, R4099);
  TtpEventoFechamentoReaberturaReinf = (serieR2000, serieR4000);
  TtpXmlReinf = (xmlEnvio, xmlRetorno);

Type
  TRecSizeField = Record
    Name: String;
    Size: Integer;
  end;

  TTipoConsCli = (tpCliVenCad, tpTodosCli, tpCliVenLog, tpLibCliVenLog, tpCliVenLogVenEsp);
  TTipoConsPro = (tpProVenCad, tpTodosPro, tpProVenLog, tpLibProVenLog);

  function fStrToTipoConsCli(const strConsCli: String): TTipoConsCli;
  function fTipoConsCliToStr(const aConsCli: TTipoConsCli): String;

  function fStrToTipoConsPro(const strConsPro: String): TTipoConsPro;
  function fTipoConsProToStr(const aConsPro: TTipoConsPro): String;

Type
  TprocCarregaCodigoLiberacao = procedure (AstrCodigoLiberacao: String) of object;

{$IFNDEF LINUX}
  TfunDisparaSMSWhatsappPedidoCompra = function (strNumPed,
                                  strCodEmp,
                                  strEspDoc: String;
                                  staStatus: TStatusDisparaEmail;
                                  ARecOpcaoImpressao: TRecOpcaoImpressao;
                                  blnEnviarWhatsapp: Boolean = False): Boolean of object;

  TfunDisparaWhatsAppAutomatico = function (strNumDoc,
                                            strOpcDoc,
                                            strEspDoc,
                                            strNumOrc,
                                            strEspOrc,
                                            strEmpOri,
                                            strCodDes: String;
                                            AQrCodePix: String = ''): Boolean;

  TfunDisparaEmailAutomatico = function (strNumDoc,
                                         strOpcDoc,
                                         strEspDoc,
                                         strNumOrc,
                                         strEspOrc,
                                         strEmpOri,
                                         strCodDes : String;
                                         AQrCodePix: String = '';
                                         ALinkCitelPix: String = ''): Boolean;
{$ENDIF}
type
  TDefaultPoolingOptions = class sealed
  public
    class var Pooling: Boolean;
    class var Validate: Boolean;
    class var MaxPoolSize: Integer;
    class var MinPoolSize: Integer;
    class var ConnectionLifetime: Integer;
  end;

type
  TTrackedCriticalSection = class
  private
    FName: string;
    FCaller: string;
    FThreadID: TThreadID;
    FLock: TCriticalSection;
  private
    function TryEnter(const Caller: string; out HeldBy: string): Boolean;
  public
    constructor Create(AName: string);
    destructor Destroy; override;
  public
    procedure SafeEnter(ACaller: string; ATimeoutMS: Cardinal = 5000);
    procedure Leave;
  end;

  TTipoImpressaoEntEtq = (etqEntradaMercadorias, etqPedido, etqLotePrecos, etqProdutosControlados, etqPreNota, impXML, etqConfPedido);

Const
  {$IFDEF LINUX}
  {$ELSE}
  WM_CANCELOU_OPE_DLL = WM_APP + 501;
  {$ENDIF}
  MOME_MENU_CRIAREL = 'Criar Novo Relatório';
  arrTipoTrava: array[TTipoTrava] of string = ('N', 'A', 'T');
  arrDescTrava: array[TTipoTrava] of string = ('NÃO AVISA', 'AVISA', 'TRAVA');

  arrConsCli: array[TTipoConsCli] of string = ('S', 'N', 'V', 'L', 'E');
  arrConsPro: array[TTipoConsPro] of string = ('S', 'N', 'V', 'L');

  arrCamposPrecos: Array [0..40] of String[10] = ('ITE_PRECOM', 'ITE_DESF01', 'ITE_DESF02',
                                                  'ITE_DESF03', 'ITE_DESF04', 'ITE_DESF05',
                                                  'ITE_DESF06', 'ITE_ICMENT', 'ITE_SUBFED',
                                                  'ITE_IPIENT', 'ITE_FREENT', 'ITE_VALFRE',
                                                  'ITE_ACRFIN', 'ITE_SUBSTI', 'ITE_DESADB',
                                                  'ITE_PRECUS', 'ITE_OUTVAL', 'ITE_ICMSAI',
                                                  'ITE_IMPFED', 'ITE_DESOPE',
                                                  'ITE_MARBR1', 'ITE_PREVE1', 'ITE_COMTB1', //TABELA DE PRECO 1
                                                  'ITE_MARBR2', 'ITE_PREVE2', 'ITE_COMTB2', //TABELA DE PRECO 2
                                                  'ITE_MARBR3', 'ITE_PREVE3', 'ITE_COMTB3', //TABELA DE PRECO 3
                                                  'ITE_MARBR4', 'ITE_PREVE4', 'ITE_COMTB4', //TABELA DE PRECO 4
                                                  'ITE_MARBR5', 'ITE_PREVE5', 'ITE_COMTB5', //TABELA DE PRECO 5
                                                  'ITE_MARBR6', 'ITE_PREVE6', 'ITE_COMTB6', //TABELA DE PRECO 6
                                                  'ITE_MARBR7', 'ITE_PREVE7', 'ITE_COMTB7');//TABELA DE PRECO 7

  TIPO_PRODUTO_SPED: array[0..11] Of Array[0..1] Of String = (
     ('00', 'Mercadoria para Revenda'),
     ('01', 'Matéria Prima'),
     ('02', 'Embalagem'),
     ('03', 'Produto em Processo'),
     ('04', 'Produto Acabado'),
     ('05', 'Subproduto'),
     ('06', 'Produto Intermediário'),
     ('07', 'Material de Uso/Consumo'),
     ('08', 'Ativo Imobilizado'),
     ('09', 'Serviços'),
     ('10', 'Outros Insumos'),
     ('99', 'Outros')
    );
  CST_X40 = '040_140_240_340_540_640_740_840_940';
  CST_X00 = '000_100_200_300_500_600_700_800_900';
  CST_X20 = '020_120_220_320_520_620_720_820_920';
  CST_ANTECIPACAO_ICMS = '090_190_290_390_490_590_690_790_890';

  CST_SUBSTITUICAO = '010_110_210_310_410_510_610_710_810_' +
                     '060_160_260_360_460_560_660_760_860_' +
                     '070_170_270_370_470_570_670_770_870_' +
                     '030_130_230_330_430_530_630_730_830';  // Isenta ou não tributada e com cobrança do ICMS por substituição tributária

  CST_NAO_TRIBUTADO = '041_141_241_341_441_541_641_741_' +
                      '051_151_251_351_451_551_651_751_';

  CST_ISENTO = '030_130_230_330_430_530_630_730_' +
               '040_140_240_340_440_540_640_740_' +
               '050_150_250_350_450_550_650_750_';

  CST_REDUCAO = '020_120_220_320_420_520_620_720_820_' +
                '070_170_270_370_470_570_670_770_870_';

  CST_REDUCAO_20 = '020_120_220_320_420_520_620_720_820_';

  CST_DIFERE_PIS_COFINS = '041_141_241_341_441_541_641_741_' +
                          '060_160_260_360_460_560_660_760_' +
                          '010_110_210_310_410_510_610_710_' +
                          '070_170_270_370_470_570_670_770_';

  CST_TRIBUTADO = '000_100_200_300_400_500_600_700_800_' +
                  '020_120_220_320_420_520_620_720_820_';

  CST_NAO_APLICA_ICMS_DESONERADO = '000_100_200_300_400_500_600_700_800_051_151_251_351_451_551_651_751_';

  UnidadePor  : Array[0..9] Of String[7] = ('','UM ','DOIS ','TRES ','QUATRO ','CINCO ','SEIS ','SETE ','OITO ','NOVE ');
  DezenaPor   : Array[0..9] Of String[10]= ('','DEZ ','VINTE ','TRINTA ','QUARENTA ','CINQUENTA ','SESSENTA ','SETENTA ','OITENTA ','NOVENTA ');
  CentenaPor  : Array[0..9] Of String[13] = ('','CEM ','DUZENTOS ','TREZENTOS ','QUATROCENTOS ','QUINHENTOS ','SEISCENTOS ','SETECENTOS ','OITOCENTOS ','NOVECENTOS ');

  UnidadeEsp  : Array[0..9] Of String[7] = ('','UN ','DOS ','TRES ','CUATRO ','CINCO ','SEIS ','SIETE ','OCHO ','NUEVE ');
  DezenaEsp   : Array[0..9] Of String[10]= ('','DIEZ ','VEINTE ','TRIENTA ','CUARENTA ','CINCUENTA ','SESSENTA ','SETENTA ','OCHENTA ','NOVENTA ');
  CentenaEsp  : Array[0..9] Of String[13] = ('','CIEN ','DOCIENTOS ','TRESCIENTOS ','CUATROCIENTOS','QUINIENTOS ','SEISCIENTOS ','SETECIENTOS ','OCHOCIENTOS ','NOVECIENTOS ');

  UnidadeIng  : Array[0..9] Of String[7] = ('','ONE ','TWO ','THREE ','FOUR ','FIVE ','SIX ','SEVEN ','EIGHT ','NINE ');
  DezenaIng   : Array[0..9] Of String[10]= ('','TEN ','TWENTY ','THIRTY ','FORTY ','FIFTY ','SIXTY ','SEVENTY ','EIGHTY ','NINETY ');
  CentenaIng  : Array[0..9] Of String[13] = ('','ONE HUNDRED ','TWO HUNDRED ','THREE HUNDRED','FOUR HUNDRED ','FIVE HUNDRED ','SIX HUNDRED ','SEVEN HUNDRED','EIGHT HUNDRED','NINE HUNDRED ');

  MEN001_TRANSF_REF_DEV_AUT_DOCS_OUT_EMP = 'TRANSF.REF. Devolução automatizada para documentos de outras empresas';

implementation

{ TMovDetParams }

procedure TMovDetParams.Init;
begin
  fltUniTab := 0;
  strLot_TA := '';
  fltConFre := 0;
  fltBasAnt := 0;
  fltIcmAnt := 0;
  fltVendor := 0;
  fltOutDes := 0;
  fltVlGnre := 0;
  strGnrOri := 'P';
  fltOutIcm := 0;
  fltIseIcm := 0;
  fltFreSug := 0;
  strCodMot := '';
  strNatPis := '';
  strNatCof := '';
  strSeqGad := '';
  fltOutVal := 0;
  fltIcmSai := 0;
  fltImpFed := 0;
  fltDesOpe := 0;
  fltQtdExp := 0;
  strNumCmp := '';
  intNItCmp := 0;
  fltDeDVCf := 0;
  strCodMec := '';
  strAntPro := 'N';
  strAntFre := 'N';
  fltMedAnt := 0;
  fltPreAnt := 0;
  fltImpAnt := 0;
  strSeqAnt := '';
  strRICMPR := 'N';
  fltComLiq := 0;
  strNcmTin := '';
  fltValIva := 0;
  strCliBus := 'N';
  strTurEnt := '';
  strIdeDev := 'NOR';
  fltPeBaST := 0;
  fltVal_RT := 0;
  fltDesCli := 0;
  fltImpPag := 0;
  fltTaxJur := 0;
  fltSerRat := 0;
  strProBri := '';
  fltPonBri := 0;
  fltValDif := 0;
  fltVaFrAn := 0;
  strLotAba := '';
  fltFedImp := 0;
  fltEstImp := 0;
  fltMunImp := 0;
  strIncDev := '';
  strBrinde := 'N';
  strCodPar := '';
  strTipBri := '';
  fltIcmOrg := 0;
  strBaqtze := '';
  strIncFut := '';
  fltValFle := 0;
  fltTaxEnt := 0;
  fltVrdIcm := 0;
  fltBasVrd := 0;
  strMtdIcm := '';
  strBxSbIt := 'N';
  strIteAbf := '';
  strAtivac := 'N';
  intSeqCom := 0;
  fltVICMDe := 0;
  strNcmIte := '';
  fltComDig := 0;
  fltPerDig := 0;
  fltIcmPav := 0;
  blnIcmSai := False;
  fltAlDifa := 0;
  strAutSai := '';
  fltBFCPST := 0;
  fltPFCPST := 0;
  fltVFCPST := 0;
  strDadSep := '';
  strAutEle := '';
  strNotUlt := '';
  fltPICMEF := 0;
  fltBICMEF := 0;
  fltAICMEF := 0;
  fltVICMEF := 0;
  fltBSTANT := 0;
  fltVSTANT := 0;
  strNotC17 := '';
  fltAlq922 := 0;
  fltDesCnd := 0;
  strProEsp := '';
  strCodPro := '';
  strInc_Pd := '';
  fltSICMEF := 0;
  fltValTCI := 0;
  fltCalTCI := 0;
  fltVal_TS := 0;
  strExtFul := '';
  strCodExt := '';
  fltFreMkp := 0;
  fltComMkp := 0;
  strAIdKitPromocao := '';
  strChaveAcesso := '';
  fltQtdCom := 0;
  fltFreCot := 0;
  AstrComplemento := '';
  strEmpCar := '';
  strAutoinDevCar := '';
  AfltBaseOperacaoPropriaICMSEntrada := 0;
  AfltAliquotaOperacaoPropriaICMSEntrada := 0;
  AfltValorOperacaoPropriaIMCSEntrada := 0;
  fltFreRat := 0;
  fltValIpiEntFut := 0;
  fltValRetEntFut := 0;
  fltValFcpSTEntFut := 0;
  fltDesPis := 0;
  blnClaRet := False;
  strOpSeEx := '';
  strConExp := '';
  strEmbExp := '';
  strObsExp := '';
  blnAtoDeclaratorioDF := False;
  strMovTriLocFis := '';
  fltVDesST := 0;
  strMDesST := '';
  strNumDrw := '';
  strTipBus := '';
  strNumPla := '';
  strParNum := '';
  strReqCom := '';
  strNatOpe := '';
  fltRpaFre := 0;
  fltPerRic := 0;
  blnAltEst := False;
  intSeqPer := 0;
  intDetItem := 0;
  fltICMCFR := 0;
  fltFreteCalc := 0;
  fltFreConCalc := 0;
  strPegou_ := 'N';
  fltVFCPOP := 0;
  fltVFCPDF := 0;
  fltCubage := 0;
  fltCfbIpi := 0;
  fltCfaIpi := 0;
  fltCfvIpi := 0;
  strCipiOK := 'N';
  strDocIpi := '';
  strEspIpi := '';
  strEmpIpi := '';
  intRemFil := 0;
  fltQtdRemFil := 0;
  blnFulfillmentModoRobo := False;
  blnFilFul := True;
  blnBaiDev := False;
  strAutEnt := '';
  dtaDtaCmp := 0;
  strFullHubMkp := '';
  fltOutValPD := 0;
  strFilFul_EntSai := '';
  strIncOri := '';
  strTckQbt := '';
  strEntTri := 'N';
  strFulDif := '';
  strClaFat := '';
  fltICMNCR := 0;
  fltFCPNCR := 0;
  strColoranteDeEntregaFutura := 'N';
  strCbenef := '';
  strCodPre := '';
  fltBasPre := 0;
  fltPerPre := 0;
  fltValPre := 0;
  strCodCmg := '';
  fltVimRet := 0;
  dobQIcmsMonRet := 0;
  dobAdBcMonRet := 0;
  dobVrEmIcmsRet := 0;
  fltValSeg := 0;
  fltPerDif := 0;
  fltAlqSTXML := 0;
  fltCliDes := 0;
  strRefCodCst := '';
  strRefClaTri := '';
  fltRefValOpe := 0;
  fltRefBasCal := 0;
  fltRefCbsAlq := 0;
  fltRefCbsAlD := 0;
  fltRefCbsVlD := 0;
  fltRefCbsAlR := 0;
  fltRefCbsVlT := 0;
  fltRefCbsAlE := 0;
  fltRefCbsVal := 0;
  fltRefIbsUfA := 0;
  fltRefIbsUfD := 0;
  fltRefIbsUvD := 0;
  fltRefIbsUfR := 0;
  fltRefIbsUfT := 0;
  fltRefIbsUfE := 0;
  fltRefIbsUfV := 0;
  fltRefIbsMnA := 0;
  fltRefIbsMnD := 0;
  fltRefIbsMvD := 0;
  fltRefIbsMnR := 0;
  fltRefIbsMnT := 0;
  fltRefIbsMnE := 0;
  fltRefIbsMnV := 0;
  strRefSelCst := '';
  strRefSelCla := '';
  fltRefSelBas := 0;
  fltRefSelAlq := 0;
  fltRefSelVal := 0;
  strRefTriReg := 'N';
  strRefCrePre := 'N';
  strRefMonoFa := 'N';
  fltRefValIbs := 0;
  strRefCesBas := '';
  strRefCstReg := '';
  strRefClaReg := '';
  fltRefAiuReg := 0;
  fltRefTiuReg := 0;
  fltRefAimReg := 0;
  fltRefTimReg := 0;
  fltRefCbsReg := 0;
  fltRefTcbReg := 0;
  fltIcmPrd := 0;
  fltSiscomex := 0;
  strChvRef := '';
  strIteRef := '';
  ABatch := nil;

end;


{ TCadFisParams }

procedure TCadFisParams.Init;
begin
  strEmpAut := '';
  fltImpMer := 0;
  fltImpSeg := 0;
  fltImpImp := 0;
  fltImpPro := 0;
  fltImpTax := 0;
  fltImpPis := 0;
  fltImpCof := 0;
  strImpIC1 := '';
  strImpIC2 := '';
  strModFre := '';
  fltBasIss := 0;
  fltAlqIss := 0;
  fltValIss := 0;
  fltBaseII := 0;
  fltDesAdu := 0;
  fltValIOF := 0;
  fltBasAn1 := 0;
  fltAntIc1 := 0;
  fltBasAn2 := 0;
  fltAntIc2 := 0;
  fltBasAn3 := 0;
  fltAntIc3 := 0;
  fltBasAn4 := 0;
  fltAntIc4 := 0;
  fltBasAn5 := 0;
  fltAntIc5 := 0;
  strCstEnt := '';
  blnGraCTP := False;
  fltBaeRe1 := 0;
  fltVaeRe1 := 0;
  fltBaeRe2 := 0;
  fltVaeRe2 := 0;
  fltBaeRe3 := 0;
  fltVaeRe3 := 0;
  fltBaeRe4 := 0;
  fltVaeRe4 := 0;
  fltBaeRe5 := 0;
  fltVaeRe5 := 0;
  fltBaeIP1 := 0;
  fltVaeIP1 := 0;
  fltBaeIP2 := 0;
  fltVaeIP2 := 0;
  fltBaeIP3 := 0;
  fltVaeIP3 := 0;
  fltBaeIP4 := 0;
  fltVaeIP4 := 0;
  fltBaeIP5 := 0;
  fltVaeIP5 := 0;
  strCtsPis := '';
  strCtsCof := '';
  strCodMod := '';
  strVENCOM := '';
  fltBFCPS1 := 0;
  fltVFCPS1 := 0;
  fltBFCPS2 := 0;
  fltVFCPS2 := 0;
  fltBFCPS3 := 0;
  fltVFCPS3 := 0;
  fltBFCPS4 := 0;
  fltVFCPS4 := 0;
  fltBFCPS5 := 0;
  fltVFCPS5 := 0;
  fltALQFCP := 0;
  fltTotRmm := 0;
  strCodTra := '';
  fltIrSeRt := 0;
  fltPiSeRt := 0;
  fltCoSeRt := 0;
  fltCsSeRt := 0;
  fltRetISS := 0;
  fltRetINS := 0;
  fltBAFCP1 := 0;
  fltVLFCP1 := 0;
  fltBAFCP2 := 0;
  fltVLFCP2 := 0;
  fltBAFCP3 := 0;
  fltVLFCP3 := 0;
  fltBAFCP4 := 0;
  fltVLFCP4 := 0;
  fltBAFCP5 := 0;
  fltVLFCP5 := 0;
  strTipFre := '';
  fltRFRBAS := 0;
  fltRFRALQ := 0;
  fltRFRVAL := 0;
  strCstIPI := '';
  strNfCIAP := 'N';
  fltPesCTE := 0;
  strEstornoNotaFiscal := '';
  strEstornoNotaFiscalMotivo := '';
  strNatOpe := '';
  strTB01RE := '';
  strTB06RE := '';
  strBasFre := '';
  blnDevSim := False;
  strCdsErv := '';
  fltQBCMO1 := 0;
  fltQBCMO2 := 0;
  fltQBCMO3 := 0;
  fltQBCMO4 := 0;
  fltQBCMO5 := 0;
  fltQBCMO6 := 0;
  fltQBCMO7 := 0;
  fltQBCMO8 := 0;
  fltADREM1 := 0;
  fltADREM2 := 0;
  fltADREM3 := 0;
  fltADREM4 := 0;
  fltADREM5 := 0;
  fltADREM6 := 0;
  fltADREM7 := 0;
  fltADREM8 := 0;
  fltVALMO1 := 0;
  fltVALMO2 := 0;
  fltVALMO3 := 0;
  fltVALMO4 := 0;
  fltVALMO5 := 0;
  fltVALMO6 := 0;
  fltVALMO7 := 0;
  fltVALMO8 := 0;
  strNfsSub := '';
  strMesAno := '';
  strFinNfe := '';
  strFinTip := '';
  fltTotIbs := 0;
  fltTotCbs := 0;
  fltTotIs := 0;
  fltTotProIs := 0;
  fltTotNf := 0;
End;

procedure TNotDetParams.Init;
Begin
  fltBasAnt := 0;
  fltIcmAnt := 0;
  fltOutIcm := 0;
  fltIseIcm := 0;
  fltFreSug := 0;
  strNatPis := '';
  strNatCof := '';
  fltDeDVCf := 0;
  strRICMPR := 'N';
  fltComLiq := 0;
  strNcmTin := '';
  strNumLot := '';
  fltValIva := 0;
  strCliBus := 'N';
  strTurEnt := '';
  fltPeBaST := 0;
  fltVal_RT := 0;
  fltImpPag := 0;
  fltTaxJur := 0;
  strNumCmp := '';
  intNItCmp := 0;
  strProBri := '';
  fltPonBri := 0;
  fltOutVal := 0;
  fltIcmSai := 0;
  fltImpFed := 0;
  fltDesOpe := 0;
  fltValDif := 0;
  fltFedImp := 0;
  fltEstImp := 0;
  fltMunImp := 0;
  fltIcmOrg := 0;
  fltVrdIcm := 0;
  fltBasVrd := 0;
  strMtdIcm := '';
  strAtivac := 'N';
  intSeqCom := 0;
  strSeqDet := '';
  strDesNes := '';
  strNotUlt := '';
  fltPICMEF := 0;
  fltBICMEF := 0;
  fltAICMEF := 0;
  fltVICMEF := 0;
  fltBSTANT := 0;
  fltVSTANT := 0;
  strNotC17 := '';
  fltSICMEF := 0;
  fltBFCPST := 0;
  fltPFCPST := 0;
  fltVFCPST := 0;
  strChaveAcesso := '';
  fltQtdCom := 0;
  strEmpCar := '';
  fltValIpiEntFut := 0;
  fltValRetEntFut := 0;
  fltValFcpSTEntFut := 0;
  blnAtoDeclaratorioDF := False;
  fltVDesST := 0;
  strMDesST := '';
  strCForDi := '';
  strNumDrw := '';
  strNumPla := '';
  strParNum := '';
  strReqCom := '';
  fltFreCot := 0;
  intDetItem := 0;
  fltVFCPOP := 0;
  fltVFCPDF := 0;
  fltCfbIpi := 0;
  fltCfaIpi := 0;
  fltCfvIpi := 0;
  strCipiOK := 'N';
  strDocIpi := '';
  strEspIpi := '';
  strEmpIpi := '';
  strNcmIte := '';
  strComple := '';
  dtaDtaCmp := 0;
  fltOutValPD := 0;
  strCbenef := '';
  strCodPre := '';
  fltBasPre := 0;
  fltPerPre := 0;
  fltValPre := 0;
  strCodCmg := '';
  fltVimRet := 0;
  fltValSeg := 0;
  fltPerDif := 0;
  strEmpOri := '';
  fltIcmPrd := 0;
  strRefCodCst := '';
  strRefClaTri := '';
  fltRefValOpe := 0;
  fltRefBasCal := 0;
  fltRefCbsAlq := 0;
  fltRefCbsAlD := 0;
  fltRefCbsVlD := 0;
  fltRefCbsAlR := 0;
  fltRefCbsVlT := 0;
  fltRefCbsAlE := 0;
  fltRefCbsVal := 0;
  fltRefIbsUfA := 0;
  fltRefIbsUfD := 0;
  fltRefIbsUvD := 0;
  fltRefIbsUfR := 0;
  fltRefIbsUfT := 0;
  fltRefIbsUfE := 0;
  fltRefIbsUfV := 0;
  fltRefIbsMnA := 0;
  fltRefIbsMnD := 0;
  fltRefIbsMvD := 0;
  fltRefIbsMnR := 0;
  fltRefIbsMnT := 0;
  fltRefIbsMnE := 0;
  fltRefIbsMnV := 0;
  strRefSelCst := '';
  strRefSelCla := '';
  fltRefSelBas := 0;
  fltRefSelAlq := 0;
  fltRefSelVal := 0;
  strRefTriReg := 'N';
  strRefCrePre := 'N';
  strRefMonoFa := 'N';
  fltRefValIbs := 0;
  strRefCesBas := '';
  strRefCstReg := '';
  strRefClaReg := '';
  fltRefAiuReg := 0;
  fltRefTiuReg := 0;
  fltRefAimReg := 0;
  fltRefTimReg := 0;
  fltRefCbsReg := 0;
  fltRefTcbReg := 0;
  ABatch := nil;
  fltSiscomex := 0;
  strChvRef := '';
  strIteRef := '';
End;

{ TDadosServicos }

function TDadosServicos.fTemCobranca: Boolean;
begin
  Result := False;

  If (strCodS01 <> '') And (strIdeS01 = 'S') Then Result := True;
  If (strCodS02 <> '') And (strIdeS02 = 'S') Then Result := True;
  If (strCodS03 <> '') And (strIdeS03 = 'S') Then Result := True;
  If (strCodS04 <> '') And (strIdeS04 = 'S') Then Result := True;
  If (strCodS05 <> '') And (strIdeS05 = 'S') Then Result := True;
  If (strCodS06 <> '') And (strIdeS06 = 'S') Then Result := True;
  If (strCodS07 <> '') And (strIdeS07 = 'S') Then Result := True;
  If (strCodS08 <> '') And (strIdeS08 = 'S') Then Result := True;
  If (strCodS09 <> '') And (strIdeS09 = 'S') Then Result := True;
  If (strCodS10 <> '') And (strIdeS10 = 'S') Then Result := True;
  If (strCodS11 <> '') And (strIdeS11 = 'S') Then Result := True;
  If (strCodS12 <> '') And (strIdeS12 = 'S') Then Result := True;
  If (strCodS13 <> '') And (strIdeS13 = 'S') Then Result := True;
  If (strCodS14 <> '') And (strIdeS14 = 'S') Then Result := True;
  If (strCodS15 <> '') And (strIdeS15 = 'S') Then Result := True;
  If (strCodS16 <> '') And (strIdeS16 = 'S') Then Result := True;
  If (strCodS17 <> '') And (strIdeS17 = 'S') Then Result := True;
  If (strCodS18 <> '') And (strIdeS18 = 'S') Then Result := True;
  If (strCodS19 <> '') And (strIdeS19 = 'S') Then Result := True;
  If (strCodS20 <> '') And (strIdeS20 = 'S') Then Result := True;
  If (strCodS21 <> '') And (strIdeS21 = 'S') Then Result := True;
  If (strCodS22 <> '') And (strIdeS22 = 'S') Then Result := True;
  If (strCodS23 <> '') And (strIdeS23 = 'S') Then Result := True;
  If (strCodS24 <> '') And (strIdeS24 = 'S') Then Result := True;
  If (strCodS25 <> '') And (strIdeS25 = 'S') Then Result := True;
  If (strCodS26 <> '') And (strIdeS26 = 'S') Then Result := True;
  If (strCodS27 <> '') And (strIdeS27 = 'S') Then Result := True;
  If (strCodS28 <> '') And (strIdeS28 = 'S') Then Result := True;
  If (strCodS29 <> '') And (strIdeS29 = 'S') Then Result := True;
  If (strCodS30 <> '') And (strIdeS30 = 'S') Then Result := True;
end;

procedure TDadosServicos.pRateiaServicos(fltFator: Double);
begin
  fltUniS01 := fltUniS01 * fltFator;
  fltUniS02 := fltUniS02 * fltFator;
  fltUniS03 := fltUniS03 * fltFator;
  fltUniS04 := fltUniS04 * fltFator;
  fltUniS05 := fltUniS05 * fltFator;
  fltUniS06 := fltUniS06 * fltFator;
  fltUniS07 := fltUniS07 * fltFator;
  fltUniS08 := fltUniS08 * fltFator;
  fltUniS09 := fltUniS09 * fltFator;
  fltUniS10 := fltUniS10 * fltFator;
  fltUniS11 := fltUniS11 * fltFator;
  fltUniS12 := fltUniS12 * fltFator;
  fltUniS13 := fltUniS13 * fltFator;
  fltUniS14 := fltUniS14 * fltFator;
  fltUniS15 := fltUniS15 * fltFator;
  fltUniS16 := fltUniS16 * fltFator;
  fltUniS17 := fltUniS17 * fltFator;
  fltUniS18 := fltUniS18 * fltFator;
  fltUniS19 := fltUniS19 * fltFator;
  fltUniS20 := fltUniS20 * fltFator;
  fltUniS21 := fltUniS21 * fltFator;
  fltUniS22 := fltUniS22 * fltFator;
  fltUniS23 := fltUniS23 * fltFator;
  fltUniS24 := fltUniS24 * fltFator;
  fltUniS25 := fltUniS25 * fltFator;
  fltUniS26 := fltUniS26 * fltFator;
  fltUniS27 := fltUniS27 * fltFator;
  fltUniS28 := fltUniS28 * fltFator;
  fltUniS29 := fltUniS29 * fltFator;
  fltUniS30 := fltUniS30 * fltFator;

  fltValS01 := fltValS01 * fltFator;
  fltValS02 := fltValS02 * fltFator;
  fltValS03 := fltValS03 * fltFator;
  fltValS04 := fltValS04 * fltFator;
  fltValS05 := fltValS05 * fltFator;
  fltValS06 := fltValS06 * fltFator;
  fltValS07 := fltValS07 * fltFator;
  fltValS08 := fltValS08 * fltFator;
  fltValS09 := fltValS09 * fltFator;
  fltValS10 := fltValS10 * fltFator;
  fltValS11 := fltValS11 * fltFator;
  fltValS12 := fltValS12 * fltFator;
  fltValS13 := fltValS13 * fltFator;
  fltValS14 := fltValS14 * fltFator;
  fltValS15 := fltValS15 * fltFator;
  fltValS16 := fltValS16 * fltFator;
  fltValS17 := fltValS17 * fltFator;
  fltValS18 := fltValS18 * fltFator;
  fltValS19 := fltValS19 * fltFator;
  fltValS20 := fltValS20 * fltFator;
  fltValS21 := fltValS21 * fltFator;
  fltValS22 := fltValS22 * fltFator;
  fltValS23 := fltValS23 * fltFator;
  fltValS24 := fltValS24 * fltFator;
  fltValS25 := fltValS25 * fltFator;
  fltValS26 := fltValS26 * fltFator;
  fltValS27 := fltValS27 * fltFator;
  fltValS28 := fltValS28 * fltFator;
  fltValS29 := fltValS29 * fltFator;
  fltValS30 := fltValS30 * fltFator;

  fltCusS01 := fltCusS01 * fltFator;
  fltCusS02 := fltCusS02 * fltFator;
  fltCusS03 := fltCusS03 * fltFator;
  fltCusS04 := fltCusS04 * fltFator;
  fltCusS05 := fltCusS05 * fltFator;
  fltCusS06 := fltCusS06 * fltFator;
  fltCusS07 := fltCusS07 * fltFator;
  fltCusS08 := fltCusS08 * fltFator;
  fltCusS09 := fltCusS09 * fltFator;
  fltCusS10 := fltCusS10 * fltFator;
  fltCusS11 := fltCusS11 * fltFator;
  fltCusS12 := fltCusS12 * fltFator;
  fltCusS13 := fltCusS13 * fltFator;
  fltCusS14 := fltCusS14 * fltFator;
  fltCusS15 := fltCusS15 * fltFator;
  fltCusS16 := fltCusS16 * fltFator;
  fltCusS17 := fltCusS17 * fltFator;
  fltCusS18 := fltCusS18 * fltFator;
  fltCusS19 := fltCusS19 * fltFator;
  fltCusS20 := fltCusS20 * fltFator;
  fltCusS21 := fltCusS21 * fltFator;
  fltCusS22 := fltCusS22 * fltFator;
  fltCusS23 := fltCusS23 * fltFator;
  fltCusS24 := fltCusS24 * fltFator;
  fltCusS25 := fltCusS25 * fltFator;
  fltCusS26 := fltCusS26 * fltFator;
  fltCusS27 := fltCusS27 * fltFator;
  fltCusS28 := fltCusS28 * fltFator;
  fltCusS29 := fltCusS29 * fltFator;
  fltCusS30 := fltCusS30 * fltFator;

  fltDecS01 := fltDecS01 * fltFator;
  fltDecS02 := fltDecS02 * fltFator;
  fltDecS03 := fltDecS03 * fltFator;
  fltDecS04 := fltDecS04 * fltFator;
  fltDecS05 := fltDecS05 * fltFator;
  fltDecS06 := fltDecS06 * fltFator;
  fltDecS07 := fltDecS07 * fltFator;
  fltDecS08 := fltDecS08 * fltFator;
  fltDecS09 := fltDecS09 * fltFator;
  fltDecS10 := fltDecS10 * fltFator;
  fltDecS11 := fltDecS11 * fltFator;
  fltDecS12 := fltDecS12 * fltFator;
  fltDecS13 := fltDecS13 * fltFator;
  fltDecS14 := fltDecS14 * fltFator;
  fltDecS15 := fltDecS15 * fltFator;
  fltDecS16 := fltDecS16 * fltFator;
  fltDecS17 := fltDecS17 * fltFator;
  fltDecS18 := fltDecS18 * fltFator;
  fltDecS19 := fltDecS19 * fltFator;
  fltDecS20 := fltDecS20 * fltFator;
  fltDecS21 := fltDecS21 * fltFator;
  fltDecS22 := fltDecS22 * fltFator;
  fltDecS23 := fltDecS23 * fltFator;
  fltDecS24 := fltDecS24 * fltFator;
  fltDecS25 := fltDecS25 * fltFator;
  fltDecS26 := fltDecS26 * fltFator;
  fltDecS27 := fltDecS27 * fltFator;
  fltDecS28 := fltDecS28 * fltFator;
  fltDecS29 := fltDecS29 * fltFator;
  fltDecS30 := fltDecS30 * fltFator;
end;

{ TDadosAdiantamento }

procedure TDadosAdiantamento.AddDocumento(documento: TDocAdiantamento);
begin
  SetLength(Self.documentos, Length(Self.documentos) + 1);
  Self.documentos[Length(Self.documentos) -1] := documento;
end;

{ TPrecosParaTransferenciaHelper }

function TPrecosParaTransferenciaHelper.GetCampo: String;
begin
  case Self of
    ePrecoCusto: Result  := 'PRECUS';
    ePrecoVenda1: Result := 'PREVE1';
    ePrecoVenda2: Result := 'PREVE2';
    ePrecoVenda3: Result := 'PREVE3';
    ePrecoVenda4: Result := 'PREVE4';
    ePrecoVenda5: Result := 'PREVE5';
    ePrecoVenda6: Result := 'PREVE6';
    ePrecoVenda7: Result := 'PREVE7';
    ePrecoUltimaCompra: Result := 'PREULT';
    ePrecoUltimaCompraComImpostos: Result := 'IMPULT';
    ePrecoMedio: Result := 'PREMED';
    ePrecoMedioSemIcms: Result := 'MEDSIC';
    else Result := 'PRECUS';
  end;
end;

function TPrecosParaTransferenciaHelper.GetDescricao: String;
begin
  case Self of
    ePrecoCusto: Result  := 'Preço de Custo';
    ePrecoVenda1: Result := 'Preço de Venda 1';
    ePrecoVenda2: Result := 'Preço de Venda 2';
    ePrecoVenda3: Result := 'Preço de Venda 3';
    ePrecoVenda4: Result := 'Preço de Venda 4';
    ePrecoVenda5: Result := 'Preço de Venda 5';
    ePrecoVenda6: Result := 'Preço de Venda 6';
    ePrecoVenda7: Result := 'Preço de Venda 7';
    ePrecoUltimaCompra: Result := 'Preço da Última compra';
    ePrecoUltimaCompraComImpostos: Result := 'Preço da Última compra + Impostos';
    ePrecoMedio: Result := 'Preço Médio';
    ePrecoMedioSemIcms: Result := 'Preço Médio sem ICMS';
    else Result := 'Preço de Custo';
  end;
end;

function TPrecosParaTransferenciaHelper.PodeUtilizar(
  ACfgTabPrc: String): Boolean;
begin
  case Self of
    ePrecoVenda1: Result := ACfgTabPrc[1] = 'S';
    ePrecoVenda2: Result := ACfgTabPrc[2] = 'S';
    ePrecoVenda3: Result := ACfgTabPrc[3] = 'S';
    ePrecoVenda4: Result := ACfgTabPrc[4] = 'S';
    ePrecoVenda5: Result := ACfgTabPrc[5] = 'S';
    ePrecoVenda6: Result := ACfgTabPrc[6] = 'S';
    ePrecoVenda7: Result := ACfgTabPrc[7] = 'S';
    else Result := True;
  end;
end;

{ TDBGridCellHint }

{$IFNDEF LINUX}
constructor TDBGridCellHint.Create(AOwner: TComponent);
begin
  raise Exception.Create('Use CreateGridCellHint constructor');
end;

constructor TDBGridCellHint.CreateGridCellHint(ADBGrid: TDBGridCitel; AColumns: TArray<String>);
begin
  inherited Create(ADBGrid);
  FColumns := AColumns;
  FDBGrid := ADBGrid;
  FDBGrid.OnMouseMove := GridMouseMove;
end;

procedure TDBGridCellHint.GridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  LColumn, LRow: Longint;
begin
  If FOriginalHint = '' Then
    FOriginalHint := FDBGrid.Hint;

  // A partir da posição do mouse obtemos a coordenada da célula do grid
  MouseToCell(X, Y, LColumn, LRow);
  // Se for uma célula válida ...
  if (LRow > 0) and (LColumn > 0) and (LColumn <= FDBGrid.Columns.Count) And
     (MatchStr(FDBGrid.Columns[LColumn -1].FieldName, FColumns)) then
  begin
    // Fazemos a coluna do Grid ser a coluna apontada pelo mouse, para isso usamos a classe amiga
    // definida no começo da unit
    TCellGrid(FDBGrid).Col := LColumn;

    // Movemos o DataSet para a linha apontada pelo mouse deslocando em relação à sua posição
    // anterior
    FDBGrid.DataSource.DataSet.MoveBy(LRow - TCellGrid(FDBGrid).Row);

    // Se o dado apontado não for do tipo String nem Variant não apresentamos o Hint
    if (FDBGrid.Columns[LColumn - 1].Field.DataType <> ftString) and
      (FDBGrid.Columns[LColumn - 1].Field.DataType <> ftVariant) then
    begin
      FDBGrid.Hint := FOriginalHint;
      Self.ReleaseHandle;
      Exit;
    end;
    // Passamos o conteúdo do campo para o Hint do Grid e chamamos a função para exibi-lo

    FDBGrid.Hint := FDBGrid.Columns[LColumn - 1].Field.AsString;
    Self.DoActivateHint();
  end
  else
  begin
    // Se não for célula válida limpo o Hint
    FDBGrid.Hint := FOriginalHint;
    Self.ReleaseHandle;
  end;
end;

procedure TDBGridCellHint.MouseToCell(X, Y: integer; var ACol, ARow: Integer);
Var
  Coord: TGridCoord;
begin
  Coord := FDBGrid.MouseCoord(X,Y);
  ACol  := Coord.X;
  ARow  := Coord.Y;
end;

procedure TDBGridCellHint.DoActivateHint();
var
  Rect: TRect;
  HintWidth, HintHeight: Integer;
begin
  // Calculo as dimensões necessárias à janela de Hint sendo o limite igual à 1/3 da tela
  Rect := CalcHintRect((Screen.Width div 3), FDBGrid.Hint, nil);
  HintWidth := Rect.Right - Rect.Left;
  HintHeight := Rect.Bottom - Rect.Top;

  // Reposiciono a janela do Hint para próximo da posição do Mouse mantendo o tamanho
  // calculado pela rotina anterior
  Rect.Left := Rect.Left + Mouse.CursorPos.X + 16;
  Rect.Top := Rect.Top + Mouse.CursorPos.Y + 16;
  Rect.Right := Rect.Left + HintWidth;
  Rect.Bottom := Rect.Top + HintHeight;

  // Executo o procedimento para exibição do Hint na tela
  ActivateHint(Rect, FDBGrid.Hint);
end;
{$ENDIF}

{ TStringArrayHelper }

function TStringArrayHelper.ToString(ADelim: String; AQuoted: Boolean): String;
  Var
    strElem: String;
begin
  Result := EmptyStr;

  For strElem In Self Do
  Begin
    If AQuoted Then
      Result := Result + QuotedStr(strElem) + ADelim
    Else
      Result := Result + strElem + ADelim;
  End;

  Result := Copy(Result, 1, Length(Result) - Length(ADelim));
end;

{ TTipoObservacoesHelper }

function TTipoObservacoesHelper.GetValue: Integer;
begin
  case Self of
    tpoDadosAdicionaisNF    : Result := 0;
    tpoObservacoesExpedicao : Result := 1;
    tpoObservacoes          : Result := 2;
    tpoFeriados             : Result := 3;
    tpoOrientacoes          : Result := 4;
    else Result := -1;
  end;
end;

{ TTarefasHerancaCadEmpresasHelper }

function TTarefasHerancaCadEmpresasHelper.GetSQL: String;
const
  SQL_CFGSIS = 'SELECT                  '+
               '  SIS_CODCFG,           '+
               '  CONCAT(               '+
               '    "INSERT INTO CFGSIS (SIS_CODEMP, SIS_CODCFG, SIS_DESCRI, SIS_VALCFG, SIS_GRUCFG, SIS_NUMHLP, SIS_LAYOUT) VALUES (", '+
               '    QUOTE(:DES_CODEMP), '+
               '    ",",                '+
               '    QUOTE(SIS_CODCFG),  '+
               '    ",",                '+
               '    QUOTE(SIS_DESCRI),  '+
               '    ",",                '+
               '    QUOTE(SIS_VALCFG),  '+
               '    ",",                '+
               '    QUOTE(SIS_GRUCFG),  '+
               '    ",",                '+
               '    IFNULL(SIS_NUMHLP, 0), '+
               '    ",",                   '+
               '    QUOTE(SIS_LAYOUT),     '+
               '    ");"                   '+
               '  ) AS INS                 '+
               'FROM                       '+
               '  CFGSIS                   '+
               'WHERE SIS_CODEMP = :ORI_CODEMP';

  SQL_CFGTIN = 'SELECT                  '+
               '  CONCAT(               '+
               '    "INSERT INTO CFGTIN (CFG_CODEMP, CFG_IDEPRO, CFG_CODCFG, CFG_VALCFG, CFG_DESCRI, CFG_GRUCFG) VALUES (", '+
               '    QUOTE(:DES_CODEMP), '+
               '    ",",                '+
               '    QUOTE(CFG_IDEPRO),  '+
               '    ",",                '+
               '    QUOTE(CFG_CODCFG),  '+
               '    ",",                '+
               '    QUOTE(CFG_VALCFG),  '+
               '    ",",                '+
               '    QUOTE(CFG_DESCRI),  '+
               '    ",",                '+
               '    QUOTE(CFG_GRUCFG),  '+
               '    ");"                '+
               '  ) AS INS              '+
               'FROM                    '+
               '  CFGTIN                '+
               'WHERE CFG_CODEMP = :ORI_CODEMP';

  SQL_CNF_NFE = 'SELECT                            '+
                '  CONCAT(                         '+
                '    "INSERT INTO CNF_NFE (CNF_CODSEQ, CNF_IDENTI, CNF_DESCAM, CNF_CODEMP, CNF_SETOR_, CNF_TIPMSG, CNF_ULTALT) VALUES (", '+
                '    QUOTE(IFNULL(CNF_CODSEQ, 0)), '+
                '    ",",                          '+
                '    QUOTE(CNF_IDENTI),            '+
                '    ",",                          '+
                '    QUOTE(CNF_DESCAM),            '+
                '    ",",                          '+
                '    QUOTE(:DES_CODEMP),           '+
                '    ",",                          '+
                '    QUOTE(CNF_SETOR_),            '+
                '    ",",                          '+
                '    QUOTE(CNF_TIPMSG),            '+
                '    ",",                          '+
                '    "NULL",                       '+
                '    ");"                          '+
                '  ) AS INS                        '+
                'FROM                              '+
                '  CNF_NFE                         '+
                'WHERE CNF_CODEMP = :ORI_CODEMP';

  SQL_CFGEMP = 'SELECT    '+
               '  CONCAT( '+
               '    "INSERT INTO CFGEMP (CFG_SEQGER, CFG_CODEMP, CFG_CHAVE_) VALUES (", '+
               '    QUOTE(CFG_SEQGER),  '+
               '    ",",                '+
               '    QUOTE(:DES_CODEMP), '+
               '    ",",                '+
               '    QUOTE(CFG_CHAVE_),  '+
               '    ");"                '+
               '  ) AS INS              '+
               'FROM                    '+
               '  CFGEMP                '+
               'WHERE CFG_CODEMP = :ORI_CODEMP';
begin

  case Self of
    thcCFGSIS  : Result := SQL_CFGSIS;
    thcCFGTIN  : Result := SQL_CFGTIN;
    thcCNF_NFE : Result := SQL_CNF_NFE;
    thcCFGEMP  : Result := SQL_CFGEMP;
    else Result := '';
  end;

end;

function TTarefasHerancaCadEmpresasHelper.GetValue: String;
begin
  case Self of
    thcITEGER  : Result := 'ITEGER';
    thcACAGER  : Result := 'ACAGER';
    thcCFGSIS  : Result := 'CFGSIS';
    thcCFGTIN  : Result := 'CFGTIN';
    thcCFGREL  : Result := 'CFGREL';
    thcLAYETI  : Result := 'LAYETI';
    thcCNF_NFE : Result := 'CNF_NFE';
    thcCFGEMP  : Result := 'CFGEMP';
    thcCADLOT  : Result := 'CADLOT';
    thcCNFBOL  : Result := 'CNFBOL';
    thcCONEMP  : Result := 'CONEMP';
    thcITEEMB  : Result := 'ITEEMB';
    thcCADCAR  : Result := 'CADCAR';
    else Result := '';
  end;
end;

{ TPermissaoAlteracaoDePedidosQuePossuemAdiantamentoHelper }

function TPermissaoAlteracaoDePedidosQuePossuemAdiantamentoHelper.GetValue: String;
begin
  case Self of
    papSimTodosOsCampos                                   : Result := 'S';
    papSimTodosOsCamposComExigenciaQueOValorFiqueOMesmo   : Result := 'X';
    papSimSomenteReduzindoAQuantidadeOuEliminandoProdutos : Result := 'N';
    papNaoNenhumaInformacao                               : Result := 'T';
    else Result := '';
  end;
end;

{ TTipoOpcaoDeTravaHelper }

function TTipoOpcaoDeTravaHelper.fOpcaoDeTravaEhPorAtividade : Boolean;
begin

  Result := True;

  If Self.GetValue.Equals(totDescontoMaximoPorAtividade.GetValue) Then
    Exit;

  If Self.GetValue.Equals(totMargemMinimaPorAtividade.GetValue) Then
    Exit;

  Result := False;

end;

function TTipoOpcaoDeTravaHelper.GetValue: String;
begin
  case Self of
    totTraval                     : Result := '1';
    totDescontoMaximo             : Result := '2';
    totMargemMinimaPorProduto     : Result := '3';
    totMargemMinimaPorDocumento   : Result := '4';
    totDescontoMaximoPorAtividade : Result := '5';
    totMargemMinimaPorAtividade   : Result := '6';
    else Result := '';
  end;
end;

{ TTipoAvisoNaExpedicaoDePedidosPendentesParaOMesmoClienteHelper }

function TTipoAvisoNaExpedicaoDePedidosPendentesParaOMesmoClienteHelper.GetValue: String;
begin
  case Self of
    taeNaoExibirAviso                                     : Result := 'N';
    taeSimConsiderandoSomentePedidosQueEstejamNaExpedicao : Result := 'S';
    taeSimConsiderandoTodosOsPedidosAbertosParaOCliente   : Result := 'T';
    else Result := '';
  end;
end;

procedure TTipoAvisoNaExpedicaoDePedidosPendentesParaOMesmoClienteHelper.SetValue(Value: String);
begin

  If Value.Equals('N') Then
    Self := taeNaoExibirAviso

  Else If Value.Equals('S') Then
    Self := taeSimConsiderandoSomentePedidosQueEstejamNaExpedicao

  Else If Value.Equals('T') Then
    Self := taeSimConsiderandoTodosOsPedidosAbertosParaOCliente;

end;

{ TInformacaoDeDestinoManifestoEletronicoHelper }

function TInformacaoDeDestinoManifestoEletronicoHelper.GetValue: Integer;
begin
  case Self of
    tidInformadoEmCadaNF : Result := 0;
    tidDestinoUnico      : Result := 1;
    Else Result := -1;
  end;
end;

function TInformacaoDeDestinoManifestoEletronicoHelper.GetValueDefault: Integer;
begin
  Result := tidInformadoEmCadaNF.GetValue;
end;

procedure TInformacaoDeDestinoManifestoEletronicoHelper.SetValue(Value: Integer);
begin
  case TInformacaoDeDestinoManifestoEletronico(Value) of
    tidInformadoEmCadaNF : Self := tidInformadoEmCadaNF;
    tidDestinoUnico      : Self := tidDestinoUnico;
  end;
end;

function fStrToTipoConsCli(const strConsCli: String): TTipoConsCli;
var
  aConsCli: TTipoConsCli;
Begin
  Result := tpTodosCli;
  For aConsCli:= Low( arrConsCli ) To High( arrConsCli ) Do
  Begin
    If arrConsCli[ aConsCli ] = strConsCli Then
    Begin
      Result := aConsCli;
      Exit;
    End;
  End;
End;

function fTipoConsCliToStr(const aConsCli: TTipoConsCli): String;
Begin
  Result := arrConsCli[aConsCli];
End;

function fStrToTipoConsPro(const strConsPro: String): TTipoConsPro;
var
  aConsPro: TTipoConsPro;
Begin
  Result := tpTodosPro;
  For aConsPro:= Low( arrConsPro ) To High( arrConsPro ) Do
  Begin
    If arrConsPro[ aConsPro ] = strConsPro Then
    Begin
      Result := aConsPro;
      Exit;
    End;
  End;
End;

function fTipoConsProToStr(const aConsPro: TTipoConsPro): String;
Begin
  Result := arrConsPro[aConsPro];
End;

{ TTipoPrecoImpItemHelper }

function TTipoPrecoImpItemHelper.GetName: String;
begin
  Case Self Of
    tpPrecoTabelaAtualSemDesconto       : Result := 'Carregar preço de tabela atual sem desconto';
    tpPrecoTabelaAtualComDesconto       : Result := 'Carregar preço de tabela atual com desconto em percentual praticado no produto do documento original';
    tpPrecoDocumentoOriginalSemDesconto : Result := 'Carregar preço praticado no documento original, sem desconto';
    tpPrecoDocumentoOriginalComDesconto : Result := 'Carregar preço praticado no documento original, com desconto em percentual praticado no produto do documento original';
    tpNenhumaDefinicao                  : Result := 'Nenhuma definida';
  End;
end;

function TTipoPrecoImpItemHelper.GetValue: String;
begin
  Case Self Of
    tpPrecoTabelaAtualSemDesconto       : Result := '1';
    tpPrecoTabelaAtualComDesconto       : Result := '2';
    tpPrecoDocumentoOriginalSemDesconto : Result := '3';
    tpPrecoDocumentoOriginalComDesconto : Result := '4';
    tpNenhumaDefinicao                  : Result := '5';
  End;
end;

procedure TTipoPrecoImpItemHelper.SetValue(Value: String);
begin
  Case Value.ToInteger Of
    1: Self := tpPrecoTabelaAtualSemDesconto;
    2: Self := tpPrecoTabelaAtualComDesconto;
    3: Self := tpPrecoDocumentoOriginalSemDesconto;
    4: Self := tpPrecoDocumentoOriginalComDesconto;
    5: Self := tpNenhumaDefinicao;
  End;
end;

{ TcxProgressBar }

{$IFDEF LINUX}
class procedure TcxProgressBar.pSetMax(AValue: Integer);
begin
  //do nothing
end;

class procedure TcxProgressBar.pStep;
begin
  //do nothing
end;
{$ENDIF}

{ TCalculoPrecoMediAgrup }


function TCalculoPrecoMediAgrup.fGetIndex(ACodIte: String): integer;
var i: integer;
begin

  If ACodIte = '' Then
    Exit(-1);

  For i:= 0 To High(ArrCalculoPreMedAgrup) do
  Begin
     If ArrCalculoPreMedAgrup[i].strCodIte = ACodIte then
       Exit(i)
  End;
  Result := -1;

end;

procedure TCalculoPrecoMediAgrup.pSetPreMedOri(ACodIte: String;
  fltValorPreMed,fltPreUltOriginal, fltPreImpUltOriginal : Double;
  strSeqDetOriginal: string);
  var i: integer;
begin
   i := fGetIndex(ACodIte);
   If i > -1 Then
   Begin
     ArrCalculoPreMedAgrup[i].fltPreMedOriginal := fltValorPreMed;
     ArrCalculoPreMedAgrup[i].fltPreUltOriginal := fltPreUltOriginal;
     ArrCalculoPreMedAgrup[i].fltPreImpUltOriginal := fltPreImpUltOriginal;
     ArrCalculoPreMedAgrup[i].strSeqDetOriginal := strSeqDetOriginal;
   End;
end;

function TCalculoPrecoMediAgrup.GetPreMedCalculado(Index: string; AutInc: String): TCalculoPreMedAgrup;
var   CalculoPreMedAgrupLocal: TCalculoPreMedAgrup;
begin
  Result.blnEncontrado := False;

  If Index = '' Then
    Exit(Result);

  For CalculoPreMedAgrupLocal in ArrCalculoPreMedAgrup do
  begin
    If (CalculoPreMedAgrupLocal.strCodIte = Index) And
       (CalculoPreMedAgrupLocal.strSeqGer =  AutInc) Then
    Begin
      Result := CalculoPreMedAgrupLocal;
      Result.blnEncontrado := True;
      Exit(Result);
    End;
  End;

  Result.blnEncontrado := False;
end;

procedure TCalculoPrecoMediAgrup.pAdd(CalculoPreMedAgrup: TCalculoPreMedAgrup);
var   CalculoPreMedAgrupLocal: TCalculoPreMedAgrup;
begin
  CalculoPreMedAgrupLocal := GetPreMedCalculado(CalculoPreMedAgrup.strCodIte, CalculoPreMedAgrup.strSeqGer);
  If CalculoPreMedAgrupLocal.blnEncontrado Then
  Begin
    CalculoPreMedAgrupLocal.SaldoAnterior :=  CalculoPreMedAgrup.SaldoAnterior;
    CalculoPreMedAgrupLocal.PrecoMedioAnterior := CalculoPreMedAgrup.PrecoMedioAnterior;
  End
  Else
  Begin
    If High(ArrCalculoPreMedAgrup)= -1 Then
      SetLength(ArrCalculoPreMedAgrup, 1)
    Else
      SetLength(ArrCalculoPreMedAgrup, Length(ArrCalculoPreMedAgrup) + 1);
    CalculoPreMedAgrup.strCodIte  := strCodIteAtual;
    CalculoPreMedAgrup.strSeqGer  := strSeqGerAtual;
    ArrCalculoPreMedAgrup[ High(ArrCalculoPreMedAgrup)] := CalculoPreMedAgrup;

  End;
end;

constructor TRetornoRelatorio.Create(Owner: TComponent);
Begin
  inherited Create(Owner);

  intAlturaTela := 0;
  intLarguraTela:= 0;

  blnPaiEmEdicao := False;
  blnExecutandoPeloBotao := False;

  arrParametrosInvisiveis := Nil;
End;

{ TDespesasOperacionaisComplementarHelper }

function TDespesasOperacionaisComplementarHelper.GetValue: TDespesasOperacionaisComplementar;
begin
  Result := Self;
end;

procedure TDespesasOperacionaisComplementarHelper.SetValue(AValue: String);
begin

  If AValue.Equals('N') Then
    Self := docNaoUtilizar
  Else If AValue.Equals('S') Then
    Self := docFormaComplementar
  Else If AValue.Equals('T') Then
    Self := docSubstitutiva;

end;

{ TImpressaoComSemPrecoOrPdHelper }

function TImpressaoComSemPrecoOrPdHelper.FromString(
  AValue: string): TImpressaoComSemPrecoOrPd;
begin
  if AValue.Equals('impComPrecoGeral') then
    Result := impComPrecoGeral
  else if AValue.Equals('impSemPrecoGeral') then
    Result := impSemPrecoGeral
  else if AValue.Equals('impComPrecoComMarca') then
    Result := impComPrecoComMarca
  else if AValue.Equals('impComPrecoSemMarca') then
    Result := impComPrecoSemMarca
  else if AValue.Equals('impSemPrecoComMarca') then
    Result := impSemPrecoComMarca
  else if AValue.Equals('impSemPrecoSemMarca') then
    Result := impSemPrecoSemMarca
  else if AValue.Equals('impSemPrecoSimplificado') then
    Result := impSemPrecoSimplificado
  else
    raise Exception.Create('Unknown TImpressaoComSemPrecoOrPd value ' + AValue);
end;

function TImpressaoComSemPrecoOrPdHelper.ToString: string;
begin
  case Self of
    impComPrecoGeral: Result := 'impComPrecoGeral';
    impSemPrecoGeral: Result := 'impSemPrecoGeral';
    impComPrecoComMarca: Result := 'impComPrecoComMarca';
    impComPrecoSemMarca: Result := 'impComPrecoSemMarca';
    impSemPrecoComMarca: Result := 'impSemPrecoComMarca';
    impSemPrecoSemMarca: Result := 'impSemPrecoSemMarca';
    impSemPrecoSimplificado: Result := 'impSemPrecoSimplificado';
  end;
end;

{ TOpcAbastecimentoHelper }

function TOpcAbastecimentoHelper.FromString(AValue: string): TOpcAbastecimento;
begin
  if AValue.Equals('opcSolicitado') then Result := opcSolicitado
  else if AValue.Equals('opcNaoSolicitado') then Result := opcNaoSolicitado
  else if AValue.Equals('opcTodos') then Result := opcTodos
  else raise Exception.Create('Unknown TOpcAbastecimento value ' + AValue);
end;

function TOpcAbastecimentoHelper.ToString: string;
begin
  case Self of
    opcSolicitado: Result := 'opcSolicitado';
    opcNaoSolicitado: Result := 'opcNaoSolicitado';
    opcTodos: Result := 'opcTodos';
  end;
end;

{ TOpcAgrupaSepRomaneioHelper }

function TOpcAgrupaSepRomaneioHelper.FromString(
  AValue: string): TOpcAgrupaSepRomaneio;
begin
  if AValue.Equals('opcCliente') then Result := opcCliente
  else if AValue.Equals('opcPedido') then Result := opcPedido
  else if AValue.Equals('opcNaoAgrupa') then Result := opcNaoAgrupa
  else raise Exception.Create('Unknown TOpcAgrupaSepRomaneio value ' + AValue);
end;

function TOpcAgrupaSepRomaneioHelper.ToString: string;
begin
  case Self of
    opcCliente: Result := 'opcCliente';
    opcPedido: Result := 'opcPedido';
    opcNaoAgrupa: Result := 'opcNaoAgrupa';
  end;
end;

function fGetFinalidadeXML(ASelected: String): integer;
Begin
  Result := 0;
  If ASelected = 'Entrada de Mercadorias' Then
    Result := 0;
  If ASelected = 'Conserto de Equipamento' Then
    Result := 1;
  If ASelected = 'Garantia - Recebimento de Cliente' Then
    Result := 2;
  If ASelected = 'Garantia - Retorno de Fornecedor' Then
    Result := 3;
  If ASelected = 'Entrada Mercadorias sistema anterior para emissão de devolução' Then
    Result := 4;
  If ASelected = 'Consignação - Devolução de Cliente' Then
    Result := 5;
  If ASelected = 'Retorno Simbólico' Then
    Result := 6;
  If ASelected = 'Locação - Retorno de Cliente' Then
    Result := 7;
  If ASelected = 'Entrada Mercadoria Auditoria' Then
    Result := 8;
  If ASelected = 'Devolução de Entrada Emitida por Fornecedor' Then
    Result := 9;
  If ASelected = 'Garantia - Retorno do Fornecedor' Then
    Result := 10;

End;

{ TTrackedCriticalSection }

constructor TTrackedCriticalSection.Create(AName: string);
begin
  FCaller := '';
  FName := AName;
  FThreadID := 0;
  FLock := TCriticalSection.Create;
end;

destructor TTrackedCriticalSection.Destroy;
begin
  FLock.Free;
  inherited;
end;

function TTrackedCriticalSection.TryEnter(const Caller: string; out HeldBy: string): Boolean;
begin
  FLock.Enter;
  Exit(True);
//  if FLock.TryEnter then
//  begin
//    FThreadID := TThread.CurrentThread.ThreadID;
//    FCaller := Caller;
//    HeldBy := '';
//    Result := True;
//  end
//  else
//  begin
//    HeldBy := FName + ' - [held by thread id ' + IntToStr(FThreadID) + ', Caller=' + FCaller + ']';
//    Result := False;
//  end;
end;

procedure TTrackedCriticalSection.SafeEnter(ACaller: string; ATimeoutMS: Cardinal = 5000);
var
  StartTime: TDateTime;
  HeldBy: string;
begin
  StartTime := Now;
  while not Self.TryEnter(ACaller, HeldBy) do
  begin
    Sleep(50); // evita consumir 100% CPU
    if MilliSecondsBetween(Now, StartTime) > ATimeoutMS then
    begin
     {$IFDEF LINUX}
      WriteLn(ACaller + ' timeout -> ' + HeldBy);
     {$ENDIF}
      raise Exception.Create(ACaller + ' timeout -> ' + HeldBy);
    end;
  end;
end;

procedure TTrackedCriticalSection.Leave;
begin
  FThreadID := 0;
  FCaller := '';
  FLock.Leave;
end;

{ TRecArquivosGatilhos }

constructor TRecArquivosGatilhos.Create(ATitulo, AArquivo, AUrl: String; ATipoArquivo: TTipoArquivo = tpaPDF; AArmazenadoNoBucket: Boolean = False);
begin
  Titulo := ATitulo;
  Arquivo := AArquivo;
  TipoArquivo := ATipoArquivo;
  Url := AUrl;
  ArmazenadoNoBucket := AArmazenadoNoBucket;
end;

{ TRecGatilhoImediato }

constructor TRecGatilhoImediato.Create(AAssunto: String;
                                       AMensagem: String;
                                       AArquivos: TArray<TRecArquivosGatilhos>;
                                       AJson: String;
                                       AOperadorEnvio: String;
                                       ANumeroWhatsapp: String;
                                       AEmail: String);
begin
  Assunto := AAssunto;
  Mensagem := AMensagem;
  Arquivos := AArquivos;
  Json := AJson;
  OperadorEnvio := AOperadorEnvio;
  NumeroWhatsapp := ANumeroWhatsapp;
  Email := AEmail;
end;

{ TDestinatarioWhatsapp }

constructor TDestinatarioWhatsapp.Create;
begin
  FAutIncCtt := EmptyStr;
  FTo := EmptyStr;
  FIDFila := EmptyStr;
end;

Initialization
  VS_csTrilhaMensagensTotem := TCriticalSection.Create;

  VS_TrimMemorySize := '';
  TDefaultPoolingOptions.MaxPoolSize := 30;
  TDefaultPoolingOptions.MinPoolSize := 0;
  TDefaultPoolingOptions.Validate := True;
  TDefaultPoolingOptions.ConnectionLifetime := 600000;
  TDefaultPoolingOptions.Pooling := True;

  VS_ExibirMensagemAoUsuario := True;
  VS_ExibirMensagemDeErro    := True;
  VS_ExibirMensagemAguarde   := True;
  VS_ExibirMensagemStayOnTop := False;

  VS_strTrilhaMensagensTotem := '';

  VS_OnMensagemAoUsuario := nil;
  VS_OnMensagemDeErro    := nil;
  VS_OnMensagemAguarde   := nil;

  procCfgRepositorioContabilidadeAdicionar := nil;
  procCfgRepositorioContabilidadeProperty := nil;
  ProcTracerContabilidadeSetQueryEvent := nil ;

  procCfgRepositorioCartoesAdicionar := nil;
  procCfgRepositorioCartoesProperty := nil;
  procCfgRepositorioAntecipacaoRedeCardAdicionar := nil;
  procCfgRepositorioAntecipacaoRedeCardProperty := nil;

  procCfgRepositorioCartoesCreateProperties := Nil;

  {$IFNDEF LINUX}
  procCfgRepositorioCartoesValidar := Nil;
  {$ENDIF}

finalization
  procCfgRepositorioContabilidadeAdicionar := nil;
  procCfgRepositorioContabilidadeProperty := nil;
  ProcTracerContabilidadeSetQueryEvent := nil ;

    procCfgRepositorioCartoesAdicionar := nil;
  procCfgRepositorioCartoesProperty := nil;
  procCfgRepositorioAntecipacaoRedeCardAdicionar := nil;
  procCfgRepositorioAntecipacaoRedeCardProperty := nil;

  procCfgRepositorioCartoesCreateProperties := Nil;

  {$IFNDEF LINUX}
  procCfgRepositorioCartoesValidar := Nil;
  {$ENDIF}

  if Assigned(VS_csTrilhaMensagensTotem) then
    FreeAndNil(VS_csTrilhaMensagensTotem);

end.

