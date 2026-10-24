unit cadastro.Controller.ContratoLocacaoEquipamentos;

interface

uses
  Windows, Classes, Vcl.Controls,  Uni, DateUtils, SysUtils,
  untFuncFat, Faturamento.Classes.TEmitirPedido, System.Generics.Collections, cxProgressBar,
  untTypesLocEqu, untFuncFatTypes, UniClientDataSet, untTypesSistema,
  Forms, Messages, UniDataSetProvider, untFuncoesSimples, Data.DB, untFuncoes,
  untModulo,untTLock, cadastro.Model.ContratoLocacaoEquipamentos,
  Faturamento.Classes.TAlterarPedido, StrUtils, MaskUtils, untWord,
  untEnderecoEntrega, untFatDadosFiscais,
  cadastro.Model.EquipamentoLocacao, untCadLote;

Type
  TValidarContrato = Class;
  TItemPedidoContratoLocacao = Class;

  TPedidoContratoLocacao = Class
  private
    FContrato: TContratoLocacaoEquipamentos;
    FobjEmitirPedido: TEmitirPedido;
    FobjAlterarPedidoVenda: TAlterarPedido;
    FListaItens     : TList<TItemPedidoContratoLocacao>;
    FdadosPedido    : TDadosPedido;
    FNumDoc         : String;
    FEmpDoc         : String;
    FEspDoc         : String;
    FAutIncFatGor   : String;
    FobjCadLot      : TCadLot;

    function GetLItens: TList<TItemPedidoContratoLocacao>;
    function GetNumDoc: String;
    function GetAutIncFatGor: String;

    function fAdicionarItem: TItemPedidoContratoLocacao;
    function fAdicionarProduto: TItemPedidoContratoLocacao;
    function fAdicionarAcessorio: TItemPedidoContratoLocacao;
    function fAtualizaNumPed(const aAutInc, aNumDoc: String): Boolean;

    procedure pRemoveMovimentacaoContratoPedido;
  public
    constructor Create(aContrato: TContratoLocacaoEquipamentos);
    destructor Destroy; override;

    procedure pCarregaDadosPedido(const strAutInc: String);
    function fGerarPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fAtualizarPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fCancelarPedido: Boolean;
    function fDesmarcaPedidoFaturado(const strAutIncPed: String; strSeqEql: String): Boolean;
    function fCarregarPedidoParaAlteracao: Boolean;

    property Itens: TList<TItemPedidoContratoLocacao> read GetLItens ;
    property NumDoc: String read GetNumDoc;
    property AutIncFatGor: String read GetAutIncFatGor;
  End;

 TItemPedidoContratoLocacao = Class
 [weak]
 private
   FRegItem: TDadosProduto;
   FPedido: TPedidoContratoLocacao;
   function GetDadIte: TDadosProduto;
   procedure SetDadIte(const AValue: TDadosProduto);
 public
   constructor Create(aPedido: TPedidoContratoLocacao);
   destructor Destroy; override;

   property DadosItem: TDadosProduto read GetDadIte write SetDadIte;
 End;

 TItemNotaContratoLocacao = Class;
 TNotaFiscalContratoLocacao = Class
 private
    FContrato   : TContratoLocacaoEquipamentos;
    FListaItens : TList<TItemNotaContratoLocacao>;
    FObjFatVenda: TFatVenda;
    FNumDoc  : String;
    FEspDoc  : String;
    FEmpDoc  : String;
    FSerFsc  : String;
    FSLMensagemRetorno: TStringList;
    FstrOpcDoc  : String;
    FobjValidaCtr: TValidarContrato;

    function GetLItens: TList<TItemNotaContratoLocacao>;
    procedure pZeraImpostos;
    function GetContrato: TContratoLocacaoEquipamentos;
    procedure SetContrato(const AValue: TContratoLocacaoEquipamentos);
    procedure pGravaDadosEnvioEquipamentoDocumento(const aAutInc: String);
    procedure pGravaDadosEnvioAcessorioDocumento(const aAutInc: String);
    function fGravaDadosDocumentoEnvio: Boolean;
    function GetMsgRetorno: String;
    procedure pGravaDadosRetornoAcessorioDocumento(const aAutInc: String; strNumDoc: String = '';
      strEspDoc: String = ''; strCodEmp: String = ''; strSerie: String = '');
    procedure pGravaDadosRetornoEquipamentoDocumento(const aAutInc: String; strNumDoc: String = '';
      strEspDoc: String = ''; strCodEmp: String = ''; strSerie: String = '');
    function fValidaDocEntrada(strNumDoc, strEspDoc, strCodEmp,
      strSerie: String): Boolean;
    function fRetornaClaFisSaida(blnDentroEstado: Boolean): String;
    function fRetornaClaFisEntrada(blnDentroEstado: Boolean): String;
    function fPedeDadosEmissaoNotaFiscal: Boolean;
    function fEmiteNotaSimplesRemessaEnvio: Boolean;
    function fEmiteNotaSimplesRemessaRetorno: Boolean;
    function fEmiteFaturamentoFuturoSimplesRemessaEnvio: Boolean;
    function fEmiteFaturamentoFuturoSimplesRemessaRetorno: Boolean;
    function fValidaPodeEmitirDocumento: Boolean;
    function fValidaPodeEmitirDocumentoEntrada: Boolean;
    function fValidaPodeEmitirDocumentoSaida: Boolean;
    function GetValCtr: TValidarContrato;
  public
    constructor Create(aContrato: TContratoLocacaoEquipamentos; strOpcDoc: String);
    destructor Destroy; override;
    procedure pLimparItens;

    property Itens: TList<TItemNotaContratoLocacao> read GetLItens ;
    property Contrato: TContratoLocacaoEquipamentos read GetContrato write SetContrato;
    property NumDoc: String read FNumDoc write FNumDoc;
    property EspDoc: String read FEspDoc write FEspDoc;
    property EmpDoc: String read FEmpDoc write FEmpDoc;
    property SerFsc: String read FSerFsc write FSerFsc;
    property ObjFatVenda: TFatVenda read FObjFatVenda write FObjFatVenda;
    property MensagemRetorno: String read GetMsgRetorno;
    property ObjValidaCtr: TValidarContrato read GetValCtr;

    function fEmiteDocumentoSimplesRemessaEnvio(const strEspDoc: String = 'NF'): Boolean;
    function fEmiteDocumentoSimplesRemessaRetorno(const strEspDoc: String = 'NF'): Boolean;

    function fAdicionarProduto: TItemNotaContratoLocacao;
    function fAdicionarAcessorio: TItemNotaContratoLocacao;
    function fGravaDadosDocumentoRetorno: Boolean; overload;
    function fGravaDadosDocumentoRetorno(strNumDoc, strEspDoc, strCodEmp, strSerie: String): Boolean; overload;
    function fSelecionaNotaEntradaExistente(var strNumDoc, strEspDoc,
      strCodEmp, strSerie: String): Boolean;
  End;

  TItemNotaContratoLocacao = Class
  [weak]
  private
    FNota: TNotaFiscalContratoLocacao;
    FItemContrato: TItemContratoLocacaoEquipamentos;
    FItemAcessorioContrato: TAcessorioContratoLocacaoEquipamentos;
    FTipoItem: TTpEquipamentoLocacao;
    FAutInc: String;
    FCodigoItem: String;
    FEqdDescri: String;
    FEqdCodigo: String;
    FstrDescri: String;
    FstrIteDes: String;
    FstrClaFis: String;
    FstrNumLot: String;
    FstrCodGru: String;
    FstrDesFab: String;
    FstrUnidad: String;
    FstrCodIte: String;
    FstrCodUni: String;
    FstrCodMar: String;
    FstrCodFor: String;
    FstrRefere: String;
    FfltUniOri: Double;
    FfltUniVis: Double;
    FfltUniTar: Double;
    FfltTotIte: Double;
    FfltPreCus: Double;
    FfltTotCus: Double;
    FstrComLub: String;
    FfltIpiSai: Double;
    FfltDesMax: Double;
    FfltPreVe1: Double;
    FfltPreVe2: Double;
    FfltPreVe3: Double;
    FfltPreVe4: Double;
    FfltPreVe5: Double;
    FfltPreVe6: Double;
    FfltPreVe7: Double;
    FfltSaldos: Double;
    FfltComVar: Double; 
    FfltComAta: Double;
    FfltComDis: Double;
    FfltTotUlt: Double;
    FfltImpUlt: Double;
    FfltPreUlt: Double;
    FfltPreMed: Double;
    FstrClaIpi: String;
    FstrCodAbf: String;
    FfltPesoIt: Double;
    FfltPesLiq: Double;
    FstrCodFab: String;
    FfltMarMin: Double;
    FfltMarMSG: Double;
    FfltMarMGe: Double;
    FstrNumSer: String;
    FfltPreCom: Double;
    FfltUniDig: Double;
    FfltQtdPon: Double;
    FstrObrCpf: String;
    FstrSigUni: String;
    FfltIpiEnt: Double;
    FfltFreEnt: Double;
    FstrImpDir: String;
    FstrCodBar: String;
    FfltCusIte: Double;
    FfltTotImp: Double;
    FfltQtdIte: Double;
    FSLEquipamentoArmazem: TStringList;

    function fRetornaNumLote(const strCodIte: String): String;
    function fRetNumSerieItemEnvRet(): String;
    function fRetCodigoItemEnvRet(): String;
    function fRetDescricaoItemEnvRet(): String;
    function fRetQuantidadeIteItemEnvRet(): Double;
  public
    constructor Create(aNota: TNotaFiscalContratoLocacao);
    destructor Destroy; override;

    procedure pCarregarDadosItemNota;

    property AutInc: String read FAutInc write FAutInc;
    property TipoItem: TTpEquipamentoLocacao read FTipoItem write FTipoItem;
    property CodigoItem: String read FCodigoItem write FCodigoItem;
    property ItemContrato: TItemContratoLocacaoEquipamentos read FItemContrato write FItemContrato;
    property AcessorioContrato: TAcessorioContratoLocacaoEquipamentos read FItemAcessorioContrato write FItemAcessorioContrato;
    property DescricaoEquipamento: String read FEqdDescri write FEqdDescri;
    property CodigoEquipamento: String read FEqdCodigo write FEqdCodigo;
    property Descricao: String read FstrDescri write FStrDescri;
    property strIteDes: String read FstrIteDes write FstrIteDes;
    property strClaFis: String read FstrClaFis write FstrClaFis;
    property strNumLot: String read FstrNumLot write FstrNumLot;
    property strCodIte: String read FstrCodIte write FstrCodIte;
    property strCodGru: String read FstrCodGru write FstrCodGru;
    property strDesFab: String read FstrDesFab write FstrDesFab;
    property strUnidad: String read FstrUnidad write FstrUnidad;
    property strCodUni: String read FstrCodUni write FstrCodUni;
    property strCodMar: String read FstrCodMar write FstrCodMar;
    property strCodFor: String read FstrCodFor write FstrCodFor;
    property strRefere: String read FstrRefere write FstrRefere;
    property fltUniOri: Double read FfltUniOri write FfltUniOri;
    property fltUniVis: Double read FfltUniVis write FfltUniVis;
    property fltUniTar: Double read FfltUniTar write FfltUniTar;
    property fltTotIte: Double read FfltTotIte write FfltTotIte;
    property fltPreCus: Double read FfltPreCus write FfltPreCus;
    property fltTotCus: DOuble read FfltTotCus write FfltTotCus;
    property strComLub: String read FstrComLub write FstrComLub;
    property fltIpiSai: Double read FfltIpiSai write FfltIpiSai;
    property fltDesMax: Double read FfltDesMax write FfltDesMax; 
    property fltPreVe1: Double read FfltPreVe1 write FfltPreVe1;  
    property fltPreVe2: Double read FfltPreVe2 write FfltPreVe2;
    property fltPreVe3: Double read FfltPreVe3 write FfltPreVe3;
    property fltPreVe4: Double read FfltPreVe4 write FfltPreVe4;
    property fltPreVe5: Double read FfltPreVe5 write FfltPreVe5;
    property fltPreVe6: Double read FfltPreVe6 write FfltPreVe6;
    property fltPreVe7: Double read FfltPreVe7 write FfltPreVe7;
    property fltSaldos: Double read FfltSaldos write FfltSaldos;
    property fltComVar: Double read FfltComVar write FfltComVar;
    property fltComAta: Double read FfltComAta write FfltComAta;
    property fltComDis: Double read FfltComDis write FfltComDis;
    property fltTotUlt: Double read FfltTotUlt write FfltTotUlt;
    property fltImpUlt: Double read FfltImpUlt write FfltImpUlt;
    property fltPreUlt: Double read FfltPreUlt write FfltPreUlt;
    property fltPreMed: Double read FfltPreMed write FfltPreMed;
    property strClaIpi: String read FstrClaIpi write FstrClaIpi;
    property strCodAbf: String read FstrCodAbf write FstrCodAbf;
    property fltPesoIt: Double read FfltPesoIt write FfltPesoIt;
    property fltPesLiq: Double read FfltPesLiq write FfltPesLiq;
    property strCodFab: String read FstrCodFab write FstrCodFab;
    property fltMarMin: Double read FfltMarMin write FfltMarMin;
    property fltMarMSG: Double read FfltMarMSG write FfltMarMSG;
    property fltMarMGe: Double read FfltMarMGe write FfltMarMGe;
    property strNumSer: String read FstrNumSer write FstrNumSer;
    property fltPreCom: Double read FfltPreCom write FfltPreCom;
    property fltUniDig: Double read FfltUniDig write FfltUniDig;
    property fltQtdPon: Double read FfltQtdPon write FfltQtdPon;
    property strObrCpf: String read FstrObrCpf write FstrObrCpf;
    property strSigUni: String read FstrSigUni write FstrSigUni;
    property fltIpiEnt: Double read FfltIpiEnt write FfltIpiEnt;
    property fltFreEnt: Double read FfltFreEnt write FfltFreEnt;
    property strImpDir: String read FstrImpDir write FstrImpDir;
    property strCodBar: String read FstrCodBar write FstrCodBar;
    property fltCusIte: Double read FfltCusIte write FfltCusIte;
    property fltTotImp: Double read FfltTotImp write FfltTotImp;
    property fltQtdIte: Double read FfltQtdIte write FfltQtdIte;
    property ListaEquipamentoArmazemSemLote: TStringList read FSLEquipamentoArmazem;
  End;

  TItemTrocaContrato = Class;
  TTrocaContrato = Class
  private
    FContrato: TContratoLocacaoEquipamentos;
    FAutInc: String;
    FCodigo: String;
    FDtaTrc: TDateTime;
    FHraTrc: TDateTime;
    FCodOpe: String;
    FNomOpe: String;
    FListaItens: TList<TItemTrocaContrato>;
    FqryInsert: TUniQuery;
    FVlrTotCob: Double;
    FMensagemRetorno: String;
    FNomeArquivoAditivo: String;
    FListaEquipamentosTrocados: TList<TItemContratoLocacaoEquipamentos>;
    FListaAcessoriosTrocados: TList<TAcessorioContratoLocacaoEquipamentos>;
    FblnTrocaRealizada: Boolean;
    FValida: TValidarContrato;
    FEmAlteracaoValorCobranca: Boolean;

    function fGravarInspecaoEntrada: Boolean;
    procedure pCarregarItensTroca;

    function GetCodOpe: String;
    function GetContrato: TContratoLocacaoEquipamentos;
    function GetDtaTrc: TDateTime;
    function GetNomOpe: String;
    procedure SetCodOpe(const AValue: String);
    procedure SetContrato(const AValue: TContratoLocacaoEquipamentos);
    procedure SetDtaTrc(const AValue: TDateTime);
    procedure SetNomOpe(const AValue: String);
    function GetItens: TList<TItemTrocaContrato>;
    function GetAutInc: String;
    function GetCodTrc: String;
    procedure SetAutInc(const AValue: String);
    procedure SetCodTrc(const AValue: String);
    function GetTotCob: Double;
    procedure SetTotCob(const AValue: Double);
    function GetMsgRet: String;
    procedure SetMsgRet(const AValue: String);
    function GetNomAdt: String;
    procedure SetNomAdt(const AValue: String);
    function GetLstEql: TList<TItemContratoLocacaoEquipamentos>;
    procedure SetLstEql(const AValue: TList<TItemContratoLocacaoEquipamentos>);
    function GetLstAcl: TList<TAcessorioContratoLocacaoEquipamentos>;
    procedure SetLstAcl(
      const AValue: TList<TAcessorioContratoLocacaoEquipamentos>);
    function GetBlnTrc: Boolean;
  public
    constructor Create(Owner: TContratoLocacaoEquipamentos);
    destructor Destroy; override;

    function fGravarTroca: Boolean;
    function fAddItem: TItemTrocaContrato;
    function fAddAcessorio: TItemTrocaContrato;
    function fRetornaItemTroca(const aCodEql: String): TItemTrocaContrato;
    function fRetornaAcessorioTroca(const aCodEql, aCodAcl, aCodIte: String): TItemTrocaContrato;
    function fValidarTrocasRealizadas: Boolean;
    function fValidarTrocasEquipamentos(aItem, aItemAnterior: TItemContratoLocacaoEquipamentos): Boolean;
    function fValidarTrocasAcessorios(acessorio, acessorioanterior: TAcessorioContratoLocacaoEquipamentos): Boolean;
    function fConfirmarTroca: Boolean;
    function fRemoverItemTroca(const aCodEql: String): Boolean;
    function fRemoverAcessorioTroca(const aCodEql, aCodAcl: String): Boolean;
    function fImprimirAditivoContrato: Boolean;
    function fValidarEquipamentoTrocaDiferente(const strCodIteAnt, strCodEqlAnt: String;
      objItem: TEquipamentoLocacaoPrincipal): Boolean;
    function fValidarAcessoriosEntradaSaidaIguais(const strCodIteAnt, strCodEqlAnt: String;
      objItem: TEquipamentoLocacaoPrincipal): Boolean;
    function fValidarProdutoAcessorioEntradaSaidaIguais(const strCodIteAnt, strCodEqlAnt: String;
      objItem: TEquipamentoLocacaoPrincipal): Boolean;
    function fValidarQuantidadeAcessoriosEntradaSaidaIguais(const strCodIteAnt, strCodEqlAnt: String;
      objItem: TEquipamentoLocacaoPrincipal): Boolean;

    procedure pCarregarTroca(const strAutInc, strCodTrc: String);
    procedure pCalcularTotais;
    procedure pLimpar;
    function fImprimeComprovanteIspEnt: Boolean;
    function fImprimeComprovanteIspSai: Boolean;
    function fRetornaItemTrocaDo(const aCodEql: String; ATipoItem: TTpEquipamentoLocacao; ACodAcl: String = ''): TItemTrocaContrato;
    function ConfirmaAlteracaoCobranca: Boolean;

    property AutInc: String read GetAutInc write SetAutInc;
    property Codigo: String read GetCodTrc write SetCodTrc;
    property Contrato: TContratoLocacaoEquipamentos read GetContrato write SetContrato;
    property DataTroca: TDateTime read GetDtaTrc write SetDtaTrc;
    property HoraTroca: TDateTime read GetDtaTrc write SetDtaTrc;
    property CodUsuarioTroca: String read GetCodOpe write SetCodOpe;
    property NomeUsuarioTroca: String read GetNomOpe write SetNomOpe;
    property Itens: TList<TItemTrocaContrato> read GetItens;
    property ValorTotalCobranca: Double read GetTotCob write SetTotCob;
    property MensagemRetorno: String read GetMsgRet write SetMsgRet;
    property NomeArquivoAditivo: String read GetNomAdt write SetNomAdt;
    property ListaEquipamentos: TList<TItemContratoLocacaoEquipamentos> read GetLstEql write SetLstEql;
    property ListaAcessorios: TList<TAcessorioContratoLocacaoEquipamentos> read GetLstAcl write SetLstAcl;
    property blnTrocaRealizada: Boolean read GetBlnTrc;
    property Valida: TValidarContrato read FValida;
    property EmAlteracaoValorCobranca: Boolean read FEmAlteracaoValorCobranca write FEmAlteracaoValorCobranca;
  End;

  TItemTrocaContrato = Class
  [weak]
  private
    FItemContrato: TItemContratoLocacaoEquipamentos;
    FItemAnteriorContrato: TItemContratoLocacaoEquipamentos;
    FAcessorioContrato: TAcessorioContratoLocacaoEquipamentos;
    FAcessorioAnteriorContrato: TAcessorioContratoLocacaoEquipamentos;
    FTroca: TTrocaContrato;
    FqryInsert: TUniQuery;
    FAutInc: String;
    FCodigo: String;
    FTipoItem: TTpEquipamentoLocacao;
    FblnEdicao: Boolean;
    FblnPermiteEquDif: Boolean;
    FValorCobrancaAlterado: Boolean;

    function fConfirmarTrocaItemContrato: Boolean;
    function fConfirmarTrocaAcessorioContrato: Boolean;
    function fGravarInspecaoEntradaEquipamento: Boolean;
    function fGravarInspecaoEntradaAcessorio: Boolean;
    function fConfirmarTrocaItemEstruturaDiferente: Boolean;
    function fConfirmarTrocaItemEstruturaIgual: Boolean;
    function fAtualizarAcessoriosContrato: Boolean;

    function GetItem: TItemContratoLocacaoEquipamentos;
    procedure SetItem(const AValue: TItemContratoLocacaoEquipamentos);
    function GetAutInc: String;
    procedure SetAutInc(const AValue: String);
    function GetIteAnt: TItemContratoLocacaoEquipamentos;
    procedure SetIteAnt(const AValue: TItemContratoLocacaoEquipamentos);
    function GetCodTrc: String;
    procedure SetCodTrc(const AValue: String);
    function GetAceAnt: TAcessorioContratoLocacaoEquipamentos;
    function GetAcessorio: TAcessorioContratoLocacaoEquipamentos;
    procedure SetAceAnt(const AValue: TAcessorioContratoLocacaoEquipamentos);
    procedure SetAcessorio(const AValue: TAcessorioContratoLocacaoEquipamentos);
    function GetTipIte: TTpEquipamentoLocacao;
    procedure SetTipIte(const AValue: TTpEquipamentoLocacao);
    function GetEdicao: Boolean;
  public
    constructor Create(Owner: TTrocaContrato);
    destructor Destroy; override;

    function fGravarTrocaItem: Boolean;
    function fGravarTrocaAcessorioItem: Boolean;
    function fEfetuarTrocaEquipamento(const aCodEql: String): Boolean;
    function fEfetuarTrocaAcessorio(const aCodAcl: String): Boolean;

    property itemContrato: TItemContratoLocacaoEquipamentos read GetItem write SetItem;
    property itemAnteriorContrato: TItemContratoLocacaoEquipamentos read GetIteAnt write SetIteAnt;
    property acessorioContrato: TAcessorioContratoLocacaoEquipamentos read GetAcessorio write SetAcessorio;
    property acessorioAnteriorContrato: TAcessorioContratoLocacaoEquipamentos read GetAceAnt write SetAceAnt;
    property AutInc: String read GetAutInc write SetAutInc;
    property Codigo: String read GetCodTrc write SetCodTrc;
    property TipoItem: TTpEquipamentoLocacao read GetTipIte write SetTipIte;
    property blnEdicao: Boolean read GetEdicao;
    property blnPermiteEquDif: Boolean read FblnPermiteEquDif write FblnPermiteEquDif;
    property ValorCobrancaAlterado: Boolean read FValorCobrancaAlterado write FValorCobrancaAlterado;
  End;

  TProrrogaContratoLocacao = Class
  private
    FContrato: TContratoLocacaoEquipamentos;
    FContrato_Bkp: TContratoLocacaoEquipamentos;
    FMensagemRetorno: String;
    FblnProrrogacaoRealizada: Boolean;
    FqryInsert: TUniQuery;
    FAutInc: String;
    FCodigo: String;
    FobjValidaCtr: TValidarContrato;

    function GetPrgRea: Boolean;
    function GetObjCtr: TContratoLocacaoEquipamentos;
    procedure SetObjCtr(const AValue: TContratoLocacaoEquipamentos);
    function GetMsgRet: String;
    function GetAutInc: String;
    procedure SetAutInc(const AValue: String);
    function GetCodPrg: String;
    procedure SetCodPrg(const AValue: String);
  public
    constructor Create;
    destructor Destroy; override;

    function fValidarPodeProrrogarContato: Boolean;
    function fAddContrato(objContrato: TContratoLocacaoEquipamentos): Boolean;
    function fIniciarProrrogacaoContrato: Boolean;
    function fConfirmarProrrogacaoContrato: Boolean;

    property AutInc: String read GetAutInc write SetAutInc;
    property Codigo: String read GetCodPrg write SetCodPrg;
    property blnProrrogacaoRealizada: Boolean read GetPrgRea;
    property ObjContrato: TContratoLocacaoEquipamentos read GetObjCtr write SetObjCtr;
    property MensagemRetorno: String read GetMsgRet;
  End;

  TImpressaoLocacao = Class
  private
    FObjContrato: TContratoLocacaoEquipamentos;
    FObjWord    : TWord;
    FstrPasta : String;
    FstrNomOri: String;
    FstrNomDes: String;
    FblnProrrogacao: Boolean;
    FMensagemRetorno: String;

    procedure pInsereTabelaNegociacaoDiarias;
    procedure pInsereTabelaAcessorios;
    procedure pInsereTabelaEquipamentos;
    procedure pInsereTabelaResumEquipamentos;
    procedure pDeterminarArquivosImpressao;
    procedure pInserirDadosCabecalho;
    procedure pInserirDadosCorpoDocumento;
    procedure pInserirDadosResponsaveis;
    procedure pInserirDadosEquipamentoGeral;
    procedure pInserirTextoEspecificacaoEquipamentos;
    procedure pAdicionarTextoVariavel(strNomVar: String; strTexto: String);
    procedure pLimpaArquivosTemporarios;

    function fSubsituiCaracterQuebraLinha(const strTexto: String): String;

    function getMsgRetorno: String;
    function getNomArqDes: String;
    procedure setNomArqDes(const AValue: String);
    function getObjCtr: TContratoLocacaoEquipamentos;
    procedure setObjCtr(const AValue: TContratoLocacaoEquipamentos);
  public
    constructor Create(const pContrato: TContratoLocacaoEquipamentos);
    destructor Destroy; override;

    class function fRetornaModeloImpressao(const strStatus: String; const ablnProrrogacao: Boolean = False): String;
    class function fRetornaDiretorioPadraoContratos: String;
    function fImprimirContrato(var blnErroApl: Boolean; const blnProrrogacao: Boolean = False): Boolean;

    property ObjContrato: TContratoLocacaoEquipamentos read getObjCtr write setObjCtr;
    property strNomArquivo: String read getNomArqDes write setNomArqDes;
    property strMensagemRetorno: String read getMsgRetorno;
  End;

  TRetornoContrato = Class
  private
    FObjCtr: TContratoLocacaoEquipamentos;
    FObjCtrNF: TNotaFiscalContratoLocacao;
    FSlMensagemRetornoOk: TStringList;
    FSlMensagemRetorno: TStringList;
    FCodCli: String;
    FCodCnd: String;
    FobjEndEnt: TEnderecoEntrega;
    FValida: TValidarContrato;

    function getObjCtr: TContratoLocacaoEquipamentos;
    procedure setObjCtr(const Value: TContratoLocacaoEquipamentos);
    function getObjNota: TNotaFiscalContratoLocacao;
    procedure setObjNota(const Value: TNotaFiscalContratoLocacao);
    function GetstrMsgRet: String;
    function GetstrMsgRetOk: String;

    procedure pCarregarEntGer;
    procedure pAtualizaOSContrato(const strAutInc: String; strCodEmp, strNumOS: String);
  public
    constructor Create;
    destructor Destroy; override;

    procedure pProcessarOSContrato;
    class function fValidaPodeProcessarOSContrato: Boolean;

    property ObjContrato: TContratoLocacaoEquipamentos read getObjCtr write setObjCtr;
    property ObjNota: TNotaFiscalContratoLocacao read getObjNota write setObjNota;
    property strMensagemRetorno: String read GetstrMsgRet;
    property strMensagemRetornoOk: String read GetstrMsgRetOk;
    property Valida: TValidarContrato read FValida;
  End;

  TValidarContrato = Class
  private
    FObjCtr: TContratoLocacaoEquipamentos;
    FSlMensagemRetornoOk: TStringList;
    FSlMensagemRetorno: TStringList;
    function getObjCtr: TContratoLocacaoEquipamentos;
    procedure setObjCtr(const Value: TContratoLocacaoEquipamentos);
    function GetstrMsgRet: String;
    function GetstrMsgRetOk: String;
  public
    constructor Create(aContrato: TContratoLocacaoEquipamentos);
    destructor Destroy; override;

    function fContratoPossuiNFDeEnvio(strSeqCon: String = '') : Boolean;
    function fContratoPossuiNFDeRetorno(strSeqCon: String = '') : Boolean;
    function fContratoPossuiInspecaoSaida(strSeqCon: String) : Boolean;
    function fContratoPossuiInspecaoEntradaAberto: Boolean;
    function fContratoPossuiAdiantamento: Boolean;
    function fPodeCancelarContrato: Boolean;
    function fPodeEncerrarContrato(AValidarFaturamento: Boolean = True): Boolean;
    function fContratoPosssuiItensNaoEncerrados: Boolean;
    function fValidarItensEnviados: Boolean;
    function fContratoPossuiProrrogacao(const strSeqCon: String): Boolean;
    function fTemItemFaturado(strCodEmp, strEspSel, strNumDoc,
      strCodCli, strCodIte: String): Boolean;
    function fContratoPossuiValorFaturado: Boolean;
    function fValidarCondicaoPagamentoInformada: Boolean;
    function fVerificaContatoInseridoContrato(const strCodCli, strAutInc: String): Boolean;
    function fVerificaInspecaoSaidaPendente(const aSeqEql: String): Boolean;
    function fVerificaPodeEncerrarItens: Boolean;
    function fRealizarProcessoLocacaoOutraEmpresa: Boolean;
    function fVerificaPodeRealizarInspecaoSaida: Boolean;
    function fVerificaPodeRealizarInspecaoEntrada: Boolean;
    function fValidaCondicaoPgtoTipoCliente: Boolean;
    function fVerificaPodeRealizarEnvio: Boolean;
    function fVerificaPodeRealizarRetorno: Boolean;
    function fVerificaPodeRealizarTroca: Boolean;
    function fVerificaPodeRealizarInspecao: Boolean;
    function ValidaLiberacaoEncerramentoContratoSemFaturamento: Boolean;

    property ObjContrato: TContratoLocacaoEquipamentos read getObjCtr write setObjCtr;
    property strMensagemRetorno: String read GetstrMsgRet;
    property strMensagemRetornoOk: String read GetstrMsgRetOk;
  End;

  TImpressaoComprovanteContrato = Class
  private
    FSlMensagemRetornoOk: TStringList;
    FSlMensagemRetorno: TStringList;
    FCodLayRetorno: String;

    function fVerificaPodeImprimirRetorno: Boolean;
    function GetstrMsgRet: String;
    function GetstrMsgRetOk: String;

  public
    constructor Create;
    destructor Destroy; override;

    function fImprimirComprovanteRetorno(const strNroCon, strEspDoc, strEmpDoc, strNumDoc: String): Boolean;

    property strMensagemRetorno: String read GetstrMsgRet;
    property strMensagemRetornoOk: String read GetstrMsgRetOk;
  End;

implementation

uses
  untFatBaixarPedOrcNaoEntregue, untGravando,
  untSelDocEntrada, untDuplicatas, untDigCndPagamento, untDigCndPagamentoFrame, untLiberacao, untMsgLiberacao,
  Math, untAdiantamentoCliente, untValidaSituacaoFinanceiraPedido, untFuncoesGenerica,
  untEditorFastImpressao, TypesRel, untCarnePagto, untCadRec, untDigPortador, untBoleto,
  untConsertoEquipamento, untValorPorExtenso;

{ TPedidoContratoLocacao }

constructor TPedidoContratoLocacao.Create(
  aContrato: TContratoLocacaoEquipamentos);
begin
  FContrato := aContrato;
  FListaItens := TList<TItemPedidoContratoLocacao>.Create;
  FobjAlterarPedidoVenda := TAlterarPedido.Create(Nil);
  FobjCadLot := TCadLot.Create(Nil);
end;

destructor TPedidoContratoLocacao.Destroy;
begin
  FreeAndNil(FListaItens);

  FreeAndNil(FobjAlterarPedidoVenda);
  FreeAndNil(FobjCadLot);

  inherited;
end;

function TPedidoContratoLocacao.fAdicionarItem: TItemPedidoContratoLocacao;
var
  intCont: Integer;
begin
  FListaItens.add(TItemPedidoContratoLocacao.Create(Self));
  intCont := FListaItens.Count -1;
  Result  := FListaItens[intCont];
end;        

function TPedidoContratoLocacao.fAdicionarAcessorio: TItemPedidoContratoLocacao;
begin  
  Result := fAdicionarItem;
end;

function TPedidoContratoLocacao.fAdicionarProduto: TItemPedidoContratoLocacao;
begin  
   Result := fAdicionarItem;
end;

function TPedidoContratoLocacao.fAtualizaNumPed(const aAutInc, aNumDoc: String): Boolean;
var
  qry: TUniQuery;
begin
  Result := False;

  If fEmptyStr(aAutInc)Then
    Exit;

  qry := fCriaQuery;
  Try
    qry.DisableControls;
    Try
      qry.SQL.Add('UPDATE CONEQL SET EQL_AUT_PD = :EQL_AUT_PD ');
      qry.SQL.Add('WHERE AUTOINCREM = :AUTINC');
      qry.ParamByName('EQL_AUT_PD').AsString := aAutInc;
      qry.ParamByName('AUTINC').AsString := FContrato.AutInc;
      qry.ExecSQL;

      FContrato.AutIncPedAdiantamento := aAutInc;
      FContrato.NumDocPedAdiantamento := aNumDoc;
      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TPedidoContratoLocacao.fAtualizaNumPed]');
        Result := False;
      End;
    End;
  Finally
    pFreeAndNil(qry);
  End;
end;

procedure TPedidoContratoLocacao.pCarregaDadosPedido(const strAutInc: String);
var
  qry: TUniQuery;
  strSelect: String;
Begin
  FNumDoc := EmptyStr;
  FEspDoc := 'PD';
  FEmpDoc := EmptyStr;
  strSelect := 'SELECT FGO_NUMDOC, FGO_CODEMP FROM FATGOR WHERE AUTOINCREM = :AUTINC';

  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add(strSelect);
    qry.ParamByName('AUTINC').AsString := strAutInc;
    qry.Open;
    If Not qry.IsEmpty Then
    Begin
      FNumDoc := qry.FieldByName('FGO_NUMDOC').AsString;
      FEmpDoc := qry.FieldByName('FGO_CODEMP').AsString;
    End;
  Finally
    FreeAndNil(qry);
  End;
End;

function TPedidoContratoLocacao.fCancelarPedido: Boolean;
var
  ObjBaixarPedOrcNaoEntregue: TBaixarPedOrcNaoEntregue;
begin
  If fEmptyStr(FContrato.AutIncPedAdiantamento) Then
  Begin
    Result := True;
    Exit;
  End;

  pCarregaDadosPedido(FContrato.AutIncPedAdiantamento);

  ObjBaixarPedOrcNaoEntregue := TBaixarPedOrcNaoEntregue.Create;
  try
    ObjBaixarPedOrcNaoEntregue.blnExecutandoLocEqu := True;
    ObjBaixarPedOrcNaoEntregue.ExecutandoPeloCRM := False;
    ObjBaixarPedOrcNaoEntregue.AddDocumento(
      FNumDoc,
      'PD',
      FEmpDoc
    );

    Result := ObjBaixarPedOrcNaoEntregue.Executar;
  finally
    FreeAndNil(ObjBaixarPedOrcNaoEntregue);
  end;
end;

function TPedidoContratoLocacao.fCarregarPedidoParaAlteracao: Boolean;
begin
  pCarregaDadosPedido(FContrato.AutIncPedAdiantamento);
  FobjAlterarPedidoVenda.strNumPed := FNumDoc;
  FobjAlterarPedidoVenda.strEmpPed := FEmpDoc;
  Result := FobjAlterarPedidoVenda.fCarregarPedido();
end;

function TPedidoContratoLocacao.fDesmarcaPedidoFaturado(const strAutIncPed: String; strSeqEql: String): Boolean;
var
  qry: TUniQuery;
  strUpdateFgo,
  strUpdateFdo: String;
Begin

  If fEmptyStr(strAutIncPed) Then
  Begin
    Result := False;
    Exit;
  End;

  pCarregaDadosPedido(strAutIncPed);

  strUpdateFdo := strUpdateFdo + 'UPDATE FATDOR                               ';
  strUpdateFdo := strUpdateFdo + '  INNER JOIN EXTDOR ON                      ';
  strUpdateFdo := strUpdateFdo + '     EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM  ';
  strUpdateFdo := strUpdateFdo + 'SET                                         ';
  strUpdateFdo := strUpdateFdo + '  FDO_JAFATU = 0,                           ';
  strUpdateFdo := strUpdateFdo + '  FDO_QTDBAI = 0,                           ';
  strUpdateFdo := strUpdateFdo + '  FDO_TIPFAT = NULL,                        ';
  strUpdateFdo := strUpdateFdo + '  FDO_NUMFAT = NULL,                        ';
  strUpdateFdo := strUpdateFdo + '  FDO_EMPFAT = NULL,                        ';
  strUpdateFdo := strUpdateFdo + '  FDO_DTAFAT = NULL,                        ';
  strUpdateFdo := strUpdateFdo + '  FDO_VENFAT = NULL,                        ';
  strUpdateFdo := strUpdateFdo + '  FDO_CNDFAT = NULL,                        ';
  strUpdateFdo := strUpdateFdo + '  FDO_VALFAT = NULL                         ';
  strUpdateFdo := strUpdateFdo + 'WHERE                                       ';
  strUpdateFdo := strUpdateFdo + '  FDO_SEQGER = :AUTINC                      ';

  If Not fEmptyStr(strSeqEql) Then
    strUpdateFdo := strUpdateFdo + '  AND FDO_SEQEQL = :SEQEQL';

  strUpdateFgo := strUpdateFgo + 'UPDATE               ';
  strUpdateFgo := strUpdateFgo + '  FATGOR             ';
  strUpdateFgo := strUpdateFgo + 'SET                  ';
  strUpdateFgo := strUpdateFgo + '  FGO_MOTBAI = NULL, ';
  strUpdateFgo := strUpdateFgo + '  FGO_JAFATU = 0,    ';
  strUpdateFgo := strUpdateFgo + '  FGO_TIPFAT = NULL, ';
  strUpdateFgo := strUpdateFgo + '  FGO_NUMFAT = NULL, ';
  strUpdateFgo := strUpdateFgo + '  FGO_EMPFAT = NULL, ';
  strUpdateFgo := strUpdateFgo + '  FGO_DTAFAT = NULL, ';
  strUpdateFgo := strUpdateFgo + '  FGO_VENFAT = NULL, ';
  strUpdateFgo := strUpdateFgo + '  FGO_CNDFAT = NULL, ';
  strUpdateFgo := strUpdateFgo + '  FGO_VALFAT = NULL  ';
  strUpdateFgo := strUpdateFgo + 'WHERE                    ';
  strUpdateFgo := strUpdateFgo + '    AUTOINCREM = :AUTINC ';

  qry := fCriaQuery;
  Try
    qry.SQL.Clear;
    qry.SQL.Add(strUpdateFdo);
    qry.ParamByName('AUTINC').AsString := strAutIncPed;
    If Not fEmptyStr(strSeqEql) Then
      qry.ParamByName('SEQEQL').AsString := strSeqEql;
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add(strUpdateFgo);
    qry.ParamByName('AUTINC').AsString := strAutIncPed;
    qry.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qry);
  End;
End;

function TPedidoContratoLocacao.fAtualizarPedido(
  pgbStatus: TcxProgressBar): Boolean;
var
  intCnt,
  intCont: Integer;
begin
  Result := False;

  Try
    pCarregaDadosPedido(FContrato.AutIncPedAdiantamento);
    FobjAlterarPedidoVenda.strNumPed := FNumDoc;
    FobjAlterarPedidoVenda.strEmpPed := FEmpDoc;
    If Not FobjAlterarPedidoVenda.fCarregarPedido() Then
      Exit;

    If fEmptyStr(FNumDoc) Then
      Exit;

    pInformacao('Aguarde .. atualizando itens de pedido', pgbStatus);

    If cdsVenda.RecordCount <= 0 Then
      Exit(False);

    For intCnt := 0 to FContrato.Itens.Count-1 do
    Begin
      cdsVenda.First;
      while not cdsVenda.Eof do
      begin
        If (FContrato.Itens[intCnt].Equipamento.CodigoItem = cdsVenda.FieldByName('ITE_CODITE').AsString) and
           (FContrato.Itens[intCnt].Equipamento.AutInc = cdsVenda.FieldByName('ITE_SEQEQL').AsString) Then
        Begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_UNITAR').AsFloat := FContrato.Itens[intCnt].ValorTotalLiquido;
          cdsVenda.FieldByName('ITE_UNIDIG').AsFloat := FContrato.Itens[intCnt].ValorTotalLiquido;
          cdsVenda.FieldByName('ITE_TOTITE').AsFloat := FContrato.Itens[intCnt].ValorTotalLiquido;
          cdsVenda.FieldByName('ITE_DESCON').AsFloat := 0;

          If ((FobjCadLot.tplTipLot = tplArmazem) And (fEmptyStr(cdsVenda.FieldByName('ITE_NUMLOT').AsString))) Then
          Begin
            cdsVenda.FieldByName('ITE_NUMLOT').AsString := FobjCadLot.fRetArmazemPrincipalLocacaoDeEquipamento(cdsVenda.FieldByName('ITE_CODITE').AsString);
          End;

          cdsVenda.Post;
        End;

        For intCont:= 0  To FContrato.Itens[intCnt].Acessorios.Count-1 Do
        Begin
          If (cdsVenda.FieldByName('ITE_CODITE').AsString = FContrato.Itens[intCnt].Acessorios[intCont].Acessorio.CodigoItem) Then
          Begin
            cdsVenda.Edit;
            cdsVenda.FieldByName('ITE_QTDITE').AsFloat := FContrato.Itens[intCnt].Acessorios[intCont].Quantidade;
            cdsVenda.FieldByName('ITE_UNITAR').AsFloat := FContrato.Itens[intCnt].Acessorios[intCont].ValorAdicional;
            cdsVenda.FieldByName('ITE_UNIDIG').AsFloat := FContrato.Itens[intCnt].Acessorios[intCont].ValorAdicional;
            cdsVenda.FieldByName('ITE_TOTITE').AsFloat := FContrato.Itens[intCnt].Acessorios[intCont].ValorAdicional;
            cdsVenda.FieldByName('ITE_DESCON').AsFloat := 0;

            cdsVenda.Post;
          End;
        End;

        cdsVenda.Next;
      end;

      pProgresso(intCnt+1, FContrato.Itens.Count, pgbStatus);
    End;

    FobjAlterarPedidoVenda.objVenda.blnOrigemAtivacaoContrato := True;
    FobjAlterarPedidoVenda.objVenda.strEnvLib := 'S';
    FobjAlterarPedidoVenda.objVenda.blnUsaLiberacaoPedidosConformeEscolhaDoOperador := False;
    FobjAlterarPedidoVenda.objVenda.blnEhTelaAltItensPed := False;
    FobjAlterarPedidoVenda.objVenda.strEspDoc := 'PD';
    FobjAlterarPedidoVenda.objVenda.fltValFre := FContrato.ValorTaxaEntrega;
    FobjAlterarPedidoVenda.fCalculaTotalPedido;

    pRemoveMovimentacaoContratoPedido;
    If FobjAlterarPedidoVenda.fGravarPedido Then
    Begin
      FNumDoc := FobjAlterarPedidoVenda.objVenda.strNumDoc + '-' + FobjAlterarPedidoVenda.objVenda.strEmp_TE;
      FAutIncFatGor := FobjAlterarPedidoVenda.objVenda.strAutIncFatGor;
      Result := fAtualizaNumPed(FAutIncFatGor, FNumDoc) And (Not fEmptyStr(FAutIncFatGor));
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TPedidoContratoLocacao.fAtualizarPedido]');
      Result := False;
    End;
  End;
end;

function TPedidoContratoLocacao.fGerarPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
var
  ItemPedido: TItemPedidoContratoLocacao;
  dadosItem,
  dadosAcessorio: TDadosProduto;
  intCnt,
  intCont: Integer;
begin
  FobjEmitirPedido := TEmitirPedido.Create(Nil);
  FillChar(FdadosPedido, SizeOf(FdadosPedido), #0);

  Try
    Try
      FobjEmitirPedido.blnModoRobo   := False;
      FobjEmitirPedido.mmoInformacao := nil;
      FobjEmitirPedido.lblInformacao := nil;
      FobjEmitirPedido.pgbProgresso  := pgbStatus;

      FdadosPedido.blnSfaPag := False;
      FdadosPedido.strEmpLogSfa := VS_strCodEmp;
      FdadosPedido.strCodCli := FContrato.CodCliente;
      FdadosPedido.strCodVen := FContrato.Vendedor.Codigo;
      FdadosPedido.strCodDig := strLoginUsuarioLogado;
      FdadosPedido.strConPag := FContrato.CondicaoPgto;
      FdadosPedido.strCodCnd := FContrato.CodCondicaoPgto;
      FdadosPedido.strCodFpg := FContrato.CodFormaPgto;
      FdadosPedido.fltDesEsp := 0.00;
      FdadosPedido.strMen001 := '';
      FdadosPedido.strMen002 := '';
      FdadosPedido.strMenExp := '';
      FdadosPedido.strTipPed := 'A';
      FdadosPedido.strCodDiv := '';
      FdadosPedido.strTipOpe := 'V';
      FdadosPedido.strTipFre := '1';
      FdadosPedido.strTabPre := Pos('S', VS_strTabVen).ToString;
      FdadosPedido.strTipFin := 'P';
      FdadosPedido.strEntFat := 'N';
      FdadosPedido.strNumPok := '';
      FdadosPedido.fltValFre := FContrato.ValorTaxaEntrega;

      If Not fEmptyStr(fCfgSis('TRASUG', varString)) Then
        FdadosPedido.strCodTra := fCfgSis('TRASUG', varString);

      FdadosPedido.dtaHorImp := 0;
      FdadosPedido.dtaDtaTra := 0;
      FdadosPedido.dtaHorTra := 0;
      FdadosPedido.strCodRot := '';
      FdadosPedido.dtaPreVis := VS_Date;
      FdadosPedido.dtaGraPed := VS_Date;
      FdadosPedido.dtaDtaOri := VS_Date;
      FdadosPedido.dtaHorPed := fTime();
      FdadosPedido.strEspDoc := 'PD';
      FdadosPedido.strAutEnt := '';
      FdadosPedido.strCodTpA := '';
      FdadosPedido.strEnvLib := 'S';
      FdadosPedido.strEmp_CD := '';
      FdadosPedido.blnEnt_CD := False;
      FdadosPedido.blnGravarDavPv := False;
      FdadosPedido.blnOrigemAtivacaoContrato := True;

      Result := FobjEmitirPedido.fIniciarPedido(FdadosPedido);

      pInformacao('Aguarde .. adicionando itens de pedido', pgbStatus);

      If Result Then
      Begin
        FobjEmitirPedido.objFatVenda.strEmp_TE      := VS_strCodEmp;
        FobjEmitirPedido.objFatVenda.blnImprimeDocs := False;
        FobjEmitirPedido.objFatVenda.blnImprimeSep  := False;
        FobjEmitirPedido.objFatVenda.blnUsaLiberacaoPedidosConformeEscolhaDoOperador := False;

        For intCnt := 0 To FContrato.Itens.Count-1 Do
        Begin
          Try
            pProgresso(intCnt+1, FContrato.Itens.Count, pgbStatus);

            ItemPedido := fAdicionarProduto;
            dadosItem := ItemPedido.DadosItem;
            dadosItem.dtaDtaPed := VS_Date;
            dadosItem.strNumLot := FContrato.Itens[intCnt].Equipamento.NumLoteItem;
            dadosItem.strCodIte := FContrato.Itens[intCnt].Equipamento.CodigoItem;
            dadosItem.strIdePro := 'NOR';
            dadosItem.strDesIte := FContrato.Itens[intCnt].Equipamento.DescricaoItem;
            dadosItem.fltQtdIte := 1;
            dadosItem.strEntRet := 'R';
            dadosItem.strMd5Key := '';
            dadosItem.strPromoc := 'N';
            dadosItem.blnBxSbIt := False;
            dadosItem.strCodDiv := '';
            dadosItem.strTabIte := '1';
            dadosItem.strEmpIte := VS_strCodEmp;
            dadosItem.fltUnitar := FContrato.Itens[intCnt].ValorTotalLiquido;
            dadosItem.fltUniOri := FContrato.Itens[intCnt].ValorTotalLiquido;
            dadosItem.strSeqEql := FContrato.Itens[intCnt].Equipamento.AutInc;

            For intCont := 0 To FContrato.Itens[intCnt].Equipamento.Acessorios.Count-1 Do
            Begin
              ItemPedido := fAdicionarAcessorio;
              dadosAcessorio := ItemPedido.DadosItem;

              dadosAcessorio.dtaDtaPed := VS_Date;
              dadosAcessorio.strNumLot := FContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Acessorio.NumLoteItem;
              dadosAcessorio.strCodIte := FContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Acessorio.CodigoItem;
              dadosAcessorio.strIdePro := 'NOR';
              dadosAcessorio.strDesIte := FContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Acessorio.DescricaoItem;
              dadosAcessorio.fltQtdIte := FContrato.Itens[intCnt].Quantidade * FContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Quantidade;
              dadosAcessorio.strEntRet := 'R';
              dadosAcessorio.strMd5Key := '';
              dadosAcessorio.strPromoc := 'N';
              dadosAcessorio.blnBxSbIt := False;
              dadosAcessorio.strCodDiv := '';
              dadosAcessorio.strTabIte := '1';
              dadosAcessorio.strEmpIte := VS_strCodEmp;
              dadosAcessorio.fltUnitar := FContrato.Itens[intCnt].Equipamento.Acessorios[intCont].ValorAdicional;
              dadosAcessorio.fltUniOri := FContrato.Itens[intCnt].Equipamento.Acessorios[intCont].ValorAdicional;
              dadosAcessorio.strBrinde := 'S';
              dadosAcessorio.strIteEst := FContrato.Itens[intCnt].Equipamento.CodigoItem;

              If FobjEmitirPedido.fInserirProduto(dadosAcessorio) Then
              Begin
                FobjEmitirPedido.objFatVenda.pPreencheMatrizFechamento('AUTOINCREM = ' + cdsVenda.FieldByName('AUTOINCREM').AsString);
                FobjEmitirPedido.objFatVenda.pCalculaTotGer(True);
              End;
            End;

            If FobjEmitirPedido.fInserirProduto(dadosItem) Then
            Begin
              FobjEmitirPedido.objFatVenda.pPreencheMatrizFechamento('AUTOINCREM = ' + cdsVenda.FieldByName('AUTOINCREM').AsString);
              FobjEmitirPedido.objFatVenda.pCalculaTotGer(True);
            End;

          Except
            On E: Exception Do
            Begin
              Result := False;
              If Not cdsVenda.IsEmpty Then cdsVenda.Delete;
            End;
          End;
        End;
      End;

      If Not Result Then
        Exit;

      FobjEmitirPedido.objFatVenda.fltValFre := FContrato.ValorTaxaEntrega;
      FobjEmitirPedido.objFatVenda.fltFreDig := FContrato.ValorTaxaEntrega;
      FobjEmitirPedido.objFatVenda.strEspDoc := 'PD';
      FobjEmitirPedido.fCalcularTotais;

      Result := FobjEmitirPedido.fGravarPedido;

      If Result Then
      Begin
        FNumDoc := FobjEmitirPedido.objFatVenda.strNumDoc + '-' + FobjEmitirPedido.objFatVenda.strEmp_TE;
        FAutIncFatGor := FobjEmitirPedido.objFatVenda.strAutIncFatGor;
        Result := fAtualizaNumPed(FAutIncFatGor, FNumDoc);
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(FobjEmitirPedido);
  End;

end;

procedure TPedidoContratoLocacao.pRemoveMovimentacaoContratoPedido;
Var
  qryMov,
  qryDel: TUniQuery;
begin
  qryMov := fCriaQuery;
  qryDel := fCriaQuery;
  Try
    qryMov.SQL.Clear;
    qryMov.SQL.Add('SELECT * FROM              ');
    qryMov.SQL.Add('  FATDOR                   ');
    qryMov.SQL.Add('INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM');
    qryMov.SQL.Add('WHERE FATDOR.FDO_SEQGER = :AUTINC ');
    qryMov.ParamByName('AUTINC').AsString := FContrato.AutIncPedAdiantamento;
    qryMov.Open;

    qryMov.First;
    While Not qryMov.EOF Do
    Begin
      qryDel.SQL.Clear;
      qryDel.SQL.Add('DELETE FROM BRIDOR WHERE BRI_SEQDET = :BRI_SEQDET');
      qryDel.ParamByName('BRI_SEQDET').AsString := qryMov.FieldByName('AUTOINCREM').AsString;
      qryDel.ExecSQL;

      qryMov.Next;
    End;
  Finally
    FreeAndNil(qryMov);
    FreeAndNil(qryDel);
  End;
end;

function TPedidoContratoLocacao.GetAutIncFatGor: String;
begin
  Result := FAutIncFatGor;
end;

function TPedidoContratoLocacao.GetLItens: TList<TItemPedidoContratoLocacao>;
begin
  Result := FListaItens;
end;

function TPedidoContratoLocacao.GetNumDoc: String;
begin
  Result := FNumDoc;
end;

{ TItemPedidoContratoLocacao }

constructor TItemPedidoContratoLocacao.Create(aPedido: TPedidoContratoLocacao);
begin
  FillChar(FRegItem, SizeOf(FRegItem), #0);
  FPedido := aPedido;
end;

destructor TItemPedidoContratoLocacao.Destroy;
begin

  inherited;
end;

function TItemPedidoContratoLocacao.GetDadIte: TDadosProduto;
begin
  Result := FRegItem;
end;

procedure TItemPedidoContratoLocacao.SetDadIte(const AValue: TDadosProduto);
begin
  FRegItem := AValue;
end;

{ TNotaFiscalContratoLocacao }

constructor TNotaFiscalContratoLocacao.Create(
  aContrato: TContratoLocacaoEquipamentos;
  strOpcDoc: String);
begin
  FContrato := aContrato;
  FListaItens := TList<TItemNotaContratoLocacao>.Create;
  FSLMensagemRetorno := TStringList.Create;
  FstrOpcDoc := strOpcDoc;
  FObjFatVenda := TFatVenda.CreateInstance(FstrOpcDoc);
  FobjValidaCtr := TValidarContrato.Create(FContrato);
  pCriarCdsVenda(nil);
end;

destructor TNotaFiscalContratoLocacao.Destroy;
begin
  FreeAndNil(FListaItens);

  pFreeCdsVenda;

  If Assigned(FObjFatVenda) Then
    FreeAndNil(FObjFatVenda);

  FreeAndNil(FSlMEnsagemRetorno);
  FreeAndNil(FobjValidaCtr);
  inherited;
end;

function TNotaFiscalContratoLocacao.fAdicionarAcessorio: TItemNotaContratoLocacao;
var
  intCont: Integer;
begin    
  FListaItens.add(TItemNotaContratoLocacao.Create(Self));
  intCont := FListaItens.Count -1;
  FListaItens[intCont].TipoItem := tpAcessorio;
  Result  := FListaItens[intCont];
end;

function TNotaFiscalContratoLocacao.fAdicionarProduto: TItemNotaContratoLocacao;
var
  intCont: Integer;
begin
  FListaItens.add(TItemNotaContratoLocacao.Create(Self));
  intCont := FListaItens.Count -1;
  FListaItens[intCont].TipoItem := tpPrincipal;
  Result  := FListaItens[intCont];
end;

function TNotaFiscalContratoLocacao.fEmiteDocumentoSimplesRemessaEnvio(
  const strEspDoc: String = 'NF'): Boolean;
begin
  If Not fValidaPodeEmitirDocumento Then
    Exit(False);

  If Not fValidaPodeEmitirDocumentoSaida Then
    Exit(False);

  Case AnsiIndexStr(UpperCase(strEspDoc), arrEspDocLocEqu) Of
    Integer(tpEspFF) : Result := fEmiteFaturamentoFuturoSimplesRemessaEnvio;
    Else
      Result := fEmiteNotaSimplesRemessaEnvio;
  End;
end;

function TNotaFiscalContratoLocacao.fEmiteDocumentoSimplesRemessaRetorno(
  const strEspDoc: String): Boolean;
begin
  If Not fValidaPodeEmitirDocumento Then
    Exit(False);

  If Not fValidaPodeEmitirDocumentoEntrada Then
    Exit(False);

  Case AnsiIndexStr(UpperCase(strEspDoc), arrEspDocLocEqu) Of
    Integer(tpEspFF) : Result := fEmiteFaturamentoFuturoSimplesRemessaRetorno;
    Else
      Result := fEmiteNotaSimplesRemessaRetorno;
  End;
end;

function TNotaFiscalContratoLocacao.fEmiteFaturamentoFuturoSimplesRemessaEnvio: Boolean;
var
  recForTin   : TForTin;
  recMadeira  : TDadosMadeira;
  intCont: Integer;
  intCnt: Integer;
  strClaFis: String;
  frmGravando: TfrmGravando;
begin
  cdsVenda.EmptyDataSet;

  If Not Assigned(FObjFatVenda) Then
    FObjFatVenda := TFatVenda.CreateInstance('OU');
  FObjFatVenda.strOpcDocTrue := 'OU';
  FObjFatVenda.blnVerEstOrc  := False;
  FObjFatVenda.strNomeForm   := 'frmFatVendas';
  FObjFatVenda.strEspDoc := 'FF';
  FObjFatVenda.strTipFat := 'Faturamento Futuro';
  FObjFatVenda.strMen001 := 'CONTRATO DE LOCAÇÃO DE EQUIPAMENTO N. ' + FContrato.NroContrato;
  FObjFatVenda.strMen002 := '';
  FObjFatVenda.strOriDoc := 'V';
  FObjFatVenda.strCodVen := FContrato.Vendedor.Codigo;
  FObjFatVenda.strNomVen := FContrato.Vendedor.Nome;
  FObjFatVenda.strConPag := '01000';
  FObjFatVenda.fGravaInfoFora := fGravaDadosDocumentoEnvio;
  FObjFatVenda.pCarregaDadosClienteBaixa(FContrato.CodCliente);

  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    FListaItens[intCont].pCarregarDadosItemNota;

    If FListaItens[intCont].ListaEquipamentoArmazemSemLote.Count > 0 Then
    Begin
      FSLMensagemRetorno.Clear ;

      Case FListaItens[intCont].TipoItem Of
       TpPrincipal : FSLMensagemRetorno.Add('O(s) equipamento(s) (');
       TpAcessorio : FSLMensagemRetorno.Add('O(s) acessório(s) (');
      End;

      For intCnt:= 0 To FListaItens[intCont].ListaEquipamentoArmazemSemLote.Count-1 Do
      Begin
        If intCnt <> 0 Then
          FSLMensagemRetorno.Add( ', ' + FListaItens[intCont].ListaEquipamentoArmazemSemLote[intCnt])
        Else
          FSLMensagemRetorno.Add(FListaItens[intCont].ListaEquipamentoArmazemSemLote[intCnt]);
      End;

      Case  FListaItens[intCont].TipoItem Of
        TpPrincipal : FSLMensagemRetorno.Add(') não possuem o armazém principal para locação de equipamentos, cadastre o armazém dos equipamentos para continuar!');
        TpAcessorio : FSLMensagemRetorno.Add(') não possuem o armazém principal para locação de equipamentos, cadastre o armazém dos acessórios do equipamento para continuar!');
      End;

      Result := False;
      Exit;
    End;

    strClaFis := fRetornaClaFisSaida(FObjFatVenda.fDentroDoEstadoCFOP);

    FObjFatVenda.pAdicionaRegistroTemporaria(cdsVenda,                                                     // cdsDados
                                             Nil,                                                          // btnAdicionar
                                             'NOR',                                                        // strIdePro
                                             FListaItens[intCont].strCodGru,                               // strCodGru
                                             FListaItens[intCont].strCodIte,                               // strCodIte
                                             FListaItens[intCont].Descricao,                               // strDesOri
                                             FListaItens[intCont].strIteDes,                               // strDesIte
                                             FListaItens[intCont].strDesFab,                               // strDesFab
                                             FListaItens[intCont].strUnidad,                               // strUnidad
                                             FListaItens[intCont].strCodUni,                               // strCodUni
                                             FListaItens[intCont].strCodMar,                               // strCodMar
                                             FListaItens[intCont].strCodFor,                               // strCodFor
                                             FListaItens[intCont].strRefere,                               // strRefere
                                             FListaItens[intCont].fltUniOri,                               // fltUniOri
                                             FListaItens[intCont].fltUniVis,                               // fltUniVis
                                             FListaItens[intCont].fltUniTar,                               // fltUniTar
                                             0.0,                                                          // fltUniTmp
                                             0.0,                                                          // fltDesCon
                                             FListaItens[intCont].fltQtdIte,                               // fltQtdIte
                                             FListaItens[intCont].fltTotIte,                               // fltTotIte
                                             'S',                                                          // strEntSai
                                             FListaItens[intCont].fltPreCus,                               // fltPreCus
                                             FListaItens[intCont].fltTotCus,                               // fltTotCus
                                             FListaItens[intCont].strComLub,                               // strComLub
                                             FListaItens[intCont].fltIpiSai,                               // fltIpiSai
                                             FListaItens[intCont].fltDesMax,                               // fltDesMax
                                             FListaItens[intCont].fltPreVe1,                               // fltPreVe1
                                             FListaItens[intCont].fltPreVe2,                               // fltPreVe2
                                             FListaItens[intCont].fltPreVe3,                               // fltPreVe3
                                             FListaItens[intCont].fltPreVe4,                               // fltPreVe4
                                             FListaItens[intCont].fltPreVe5,                               // fltPreVe5
                                             FListaItens[intCont].fltPreVe6,                               // fltPreVe6
                                             FListaItens[intCont].fltPreVe7,                               // fltPreVe7
                                             0.0,                                                          // fltMarLuc
                                             FListaItens[intCont].fltSaldos,                               // fltSaldos
                                             'N',                                                          // strIncPis
                                             FListaItens[intCont].fltComVar,                               // fltComVar
                                             FListaItens[intCont].fltComAta,                               // fltComAta
                                             FListaItens[intCont].fltComDis,                               // fltComDis
                                             '',                                                           // strDocDev
                                             '',                                                           // strEspDev
                                             '',                                                           // strEmpDev
                                             0.0,                                                          // fltQtdDev
                                             0.0,                                                          // fltUniDev
                                             '',                                                           // strIncDev
                                             FListaItens[intCont].fltTotUlt,                               // fltTotUlt
                                             FListaItens[intCont].fltImpUlt,                               // fltImpUlt
                                             FListaItens[intCont].fltPreUlt,                               // fltPreUlt
                                             FListaItens[intCont].fltPreMed,                               // fltPreMed
                                             FListaItens[intCont].strClaIpi,                               // strClaIpi
                                             '',                                                           // strIteCha
                                             '',                                                           // strIteTin
                                             '',                                                           // strDesCor
                                             '',                                                           // strTipPre
                                             0,                                                            // intLazQua
                                             '',                                                           // strTipEmb
                                             0.0,                                                          // fltQtdEmb
                                             0.0,                                                          // fltPreEmb
                                             0.0,                                                          // fltPrvTin
                                             0.0,                                                          // fltPrcTin
                                             0.0,                                                          // fltFatTin
                                             'N',                                                          // strProEmb
                                             '',                                                           // strIteEmb
                                             0.0,                                                          // fltUniEmb
                                             0.0,                                                          // fltEmbAnt
                                             FListaItens[intCont].strCodAbf,                               // strCodAbf
                                             FListaItens[intCont].fltPesoIt,                               // fltPesoIt
                                             FListaItens[intCont].fltPesLiq,                               // fltPesLiq
                                             'N',                                                          // strPromoc
                                             0.0,                                                          // fltProPreCus
                                             0.0,                                                          // fltProPreVen
                                             0.0,                                                          // fltProComVar
                                             0.0,                                                          // fltProDesF07
                                             '',                                                           // strTipTin
                                             FObjFatVenda.fRetPerComGrupo(FListaItens[intCont].strCodGru), // fltGPeCom
                                             FListaItens[intCont].strCodFab,                               // strCodFab
                                             -1,                                                           // intSeqInd
                                             0.0,                                                          // fltQtdBai
                                             '',                                                           // strNumOrc
                                             '',                                                           // strEspOrc
                                             '',                                                           // strEmpOrc
                                             FListaItens[intCont].fltMarMin,                               // fltMarMin
                                             FListaItens[intCont].fltMarMSG,                               // fltMarMSG
                                             FListaItens[intCont].fltMarMGe,                               // fltMarMGe
                                             fRetNomMarca(FListaItens[intCont].strCodMar),                 // strMarca
                                             '',                                                           // strStatus
                                             0.0,                                                          // fltComDev
                                             0.0,                                                          // fltDesDev
                                             '',                                                           // strSeqDet
                                             '',                                                           // strCatali
                                             '',                                                           // strLinTin
                                             0.0,                                                          // fltEmbala
                                             'No. SÉRIE: ' + FListaItens[intCont].strNumSer,               // strDesNes
                                             '',                                                           // strSemEst
                                             '',                                                           // strLibEst
                                             FListaItens[intCont].fltPreCom,                               // fltPreCom
                                             FListaItens[intCont].fltUniDig,                               // fltUniDig
                                             FListaItens[intCont].fltQtdPon,                               // fltQtdPon
                                             '',                                                           // strComple
                                             '',                                                           // strDivDev
                                             FListaItens[intCont].strObrCpf,                               // strObrCpf
                                             '',                                                           // strMontad
                                             '',                                                           // strA_n_o_
                                             FListaItens[intCont].strSigUni,                               // strSigUni
                                             0.0,                                                          // fltVolPro
                                             intCont+1,                                                    // intOrdite
                                             '',                                                           // strChaFor
                                             '',                                                           // strCodAca
                                             '',                                                           // strEmpAca
                                             False,                                                        // blnProAca
                                             '',                                                           // strEspFut
                                             '',                                                           // strDocFut
                                             '',                                                           // strEmpFut
                                             0.0,                                                          // fltOutVal
                                             0.0,                                                          // fltComTbl
                                             0.0,                                                          // fltDesOpe
                                             0.0,                                                          // fltICMSai
                                             0.0,                                                          // fltImpFed
                                             0.0,                                                          // fltDesMge
                                             '',                                                           // strDocCnf
                                             '',                                                           // strEspCnf
                                             '',                                                           // strEmpCnf
                                             '1',                                                          // strTabPre
                                             FListaItens[intCont].fltIpiEnt,                               // fltIpiEnt
                                             FListaItens[intCont].fltFreEnt,                               // fltFreEnt
                                             '',                                                           // strCodDil
                                             0.0,                                                          // fltPorDil
                                             '',                                                           // strDilCon
                                             0.0,                                                          // fltPorCat
                                             'R',                                                          // strEntRet
                                             '',                                                           // strLocRet
                                             'N',                                                          // strEntFut
                                             '',                                                           // strMotFut
                                             0,                                                            // dtaDtaEnt
                                             1.0,                                                          // fltQtdOri
                                             0.0,                                                          // fltDesEsp
                                             0.0,                                                          // fltDesBai
                                             FListaItens[intCont].strImpDir,                               // strImpDir
                                             '',                                                           // strLocFis
                                             0.0,                                                          // fltPreCu2
                                             0.0,                                                          // fltTotCu2
                                             0.0,                                                          // fltProComAta
                                             0.0,                                                          // fltProComDis
                                             0.0,                                                          // fltTotPed
                                             0.0,                                                          // fltPanUti
                                             0.0,                                                          // fltTotDes
                                             0.0,                                                          // ftlTotFre
                                             recForTin,                                                    // recForTin
                                             '',                                                           // strKey_EP
                                             '',                                                           // strLotAnt
                                             FListaItens[intCont].strNumLot,                               // strNumLot
                                             '',                                                           // strEmpPrd
                                             '',                                                           // strVenCnf
                                             False,                                                        // blnBxSbIt
                                             'N',                                                          // strPigBas
                                             'NOR',                                                        // strIdeDev
                                             0.0,                                                          // fltQtdDet
                                             '',                                                           // strTabDev
                                             FListaItens[intCont].strCodBar,                               // strCodBar
                                             '',                                                           // strTipFin
                                             0.0,                                                          // fltDesFin
                                             0.0,                                                          // fltPreLot
                                             0.0,                                                          // fltCoDvRp
                                             '',                                                           // strEmpIte
                                             1.0,                                                          // fltFatAce
                                             True,                                                         // blnPodAlt
                                             '',                                                           // strEmpSol
                                             '',                                                           // strCndDev
                                             '',                                                           // strCCndDv
                                             0,                                                            // dtaEmiDev
                                             FListaItens[intCont].fltCusIte,                               // fltCusIte
                                             '',                                                           // strDesSim
                                             '',                                                           // strOrdPro
                                             recMadeira,                                                   // recMadeira
                                             FListaItens[intCont].fltTotImp,                               // fltTotImp
                                             0.0,                                                          // fltVal_RT
                                             0.0,                                                          // fltTaxJur
                                             '',                                                           // strSeqGad
                                             0.0,                                                          // fltQtdExp
                                             '',                                                           // strBarEmb
                                             '',                                                           // strNumCmp
                                             0,                                                            // intNItCmp
                                             0.0,                                                          // fltDeDVCf
                                             '',                                                           // strCodMec
                                             '',                                                           // strSeqRcd
                                             0,                                                            // intSeqInc
                                             '',                                                           // strCodVenIte
                                             'N',                                                          // strAltPCoIte
                                             0.0,                                                          // fltPerComIte
                                             0.0,                                                          // fltFreDev
                                             0.0,                                                          // fltDeADev
                                             False,                                                        // blnAlterandoPDORCarregado
                                             False,                                                        // blnInserindoPDORCarregado
                                             'N',                                                          // strCliBus
                                             '',                                                           // strTurEnt
                                             0,                                                            // intSeqCcr
                                             0.0,                                                          // fltDopTin
                                             '',                                                           // strCodVe2Ite
                                             'N',                                                          // strLibUni
                                             0.0,                                                          // fltValDif
                                             '',                                                           // strLotAba
                                             '',                                                           // strIncFut
                                             '',                                                           // strSepExp
                                             '',                                                           // strTabPreEmb
                                             '',                                                           // strExcIpi
                                             0.0,                                                          // fltDesMSu
                                             '',                                                           // strAiDvOr
                                             strClaFis);                                                   // strClaFis

  End;


  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    FObjFatVenda.pPreencheMatrizFechamento;
    FObjFatVenda.pCalculaPesBruLiq;
    FObjFatVenda.pCalculaTotGer(False, False, Nil, False);
    FObjFatVenda.strDesCla := fRetDesCla(FObjFatVenda.strClaFis);
    pZeraImpostos();
    FObjFatVenda.pRateiaValores;

    Try
      frmGravando.strChave            := 'FATFATURA';
      frmGravando.fExecutarAcao       := FObjFatVenda.fGravaArquivos;
      frmGravando.lblGravando.Caption := 'Aguarde, Gravando Nota fiscal de envio...';
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;

      If Result Then
      Begin
        FNumDoc := FObjFatVenda.strNumDoc;
        FEspDoc := FObjFatVenda.strEspDoc;
        FEmpDoc := FObjFatVenda.strEmpDoc;
        FSerFsc := FObjFatVenda.strSerFsc;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TNotaFiscalContratoLocacao.fEmiteNotaSimplesRemessa]');
        Result := False;
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;

end;

function TNotaFiscalContratoLocacao.fEmiteFaturamentoFuturoSimplesRemessaRetorno: Boolean;
var
  recForTin   : TForTin;
  recMadeira  : TDadosMadeira;
  intCont: Integer;
  intCnt: Integer;
  strClaFis: String;
  frmGravando: TfrmGravando;
begin
  cdsVenda.EmptyDataSet;

  If Not Assigned(FObjFatVenda) Then
    FObjFatVenda := TFatVenda.CreateInstance('OE');

  FObjFatVenda.strOpcDocTrue := 'OE';
  FObjFatVenda.blnVerEstOrc  := False;
  FObjFatVenda.strNomeForm   := 'frmFatVendas';
  FObjFatVenda.strEspDoc := 'FF';
  FObjFatVenda.strTipFat := 'Faturamento Futuro';
  FObjFatVenda.strMen001 := 'CONTRATO DE LOCAÇÃO DE EQUIPAMENTO N. ' + FContrato.NroContrato;
  FObjFatVenda.strMen002 := '';
  FObjFatVenda.strOriDoc := 'V';
  FObjFatVenda.strCodVen := FContrato.Vendedor.Codigo;
  FObjFatVenda.strNomVen := FContrato.Vendedor.Nome;
  FObjFatVenda.strConPag := FContrato.CondicaoPgto;
  FObjFatVenda.fGravaInfoFora := fGravaDadosDocumentoRetorno;
  FObjFatVenda.pCarregaDadosClienteBaixa(FContrato.CodCliente);

  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    FListaItens[intCont].pCarregarDadosItemNota;

    If FListaItens[intCont].ListaEquipamentoArmazemSemLote.Count > 0 Then
    Begin
      FSLMensagemRetorno.Clear ;

      Case FListaItens[intCont].TipoItem Of
       TpPrincipal : FSLMensagemRetorno.Add('O(s) equipamento(s) (');
       TpAcessorio : FSLMensagemRetorno.Add('O(s) acessório(s) (');
      End;

      For intCnt:= 0 To FListaItens[intCont].ListaEquipamentoArmazemSemLote.Count-1 Do
      Begin
        If intCnt <> 0 Then
          FSLMensagemRetorno.Add( ', ' + FListaItens[intCont].ListaEquipamentoArmazemSemLote[intCnt])
        Else
          FSLMensagemRetorno.Add(FListaItens[intCont].ListaEquipamentoArmazemSemLote[intCnt]);
      End;

      Case  FListaItens[intCont].TipoItem Of
        TpPrincipal : FSLMensagemRetorno.Add(') não possuem o armazém principal para locação de equipamentos, cadastre o armazém dos equipamentos para continuar!');
        TpAcessorio : FSLMensagemRetorno.Add(') não possuem o armazém principal para locação de equipamentos, cadastre o armazém dos acessórios do equipamento para continuar!');
      End;

      Result := False;
      Exit;
    End;

    strClaFis := fRetornaClaFisEntrada(FObjFatVenda.fDentroDoEstadoCFOP);

    FObjFatVenda.pAdicionaRegistroTemporaria(cdsVenda,                                                     // cdsDados
                                             Nil,                                                          // btnAdicionar
                                             'NOR',                                                        // strIdePro
                                             FListaItens[intCont].strCodGru,                               // strCodGru
                                             FListaItens[intCont].strCodIte,                               // strCodIte
                                             FListaItens[intCont].Descricao,                               // strDesOri
                                             FListaItens[intCont].strIteDes,                               // strDesIte
                                             FListaItens[intCont].strDesFab,                               // strDesFab
                                             FListaItens[intCont].strUnidad,                               // strUnidad
                                             FListaItens[intCont].strCodUni,                               // strCodUni
                                             FListaItens[intCont].strCodMar,                               // strCodMar
                                             FListaItens[intCont].strCodFor,                               // strCodFor
                                             FListaItens[intCont].strRefere,                               // strRefere
                                             FListaItens[intCont].fltUniOri,                               // fltUniOri
                                             FListaItens[intCont].fltUniVis,                               // fltUniVis
                                             FListaItens[intCont].fltUniTar,                               // fltUniTar
                                             0.0,                                                          // fltUniTmp
                                             0.0,                                                          // fltDesCon
                                             FListaItens[intCont].fltQtdIte,                               // fltQtdIte
                                             FListaItens[intCont].fltTotIte,                               // fltTotIte
                                             'E',                                                          // strEntSai
                                             FListaItens[intCont].fltPreCus,                               // fltPreCus
                                             FListaItens[intCont].fltTotCus,                               // fltTotCus
                                             FListaItens[intCont].strComLub,                               // strComLub
                                             FListaItens[intCont].fltIpiSai,                               // fltIpiSai
                                             FListaItens[intCont].fltDesMax,                               // fltDesMax
                                             FListaItens[intCont].fltPreVe1,                               // fltPreVe1
                                             FListaItens[intCont].fltPreVe2,                               // fltPreVe2
                                             FListaItens[intCont].fltPreVe3,                               // fltPreVe3
                                             FListaItens[intCont].fltPreVe4,                               // fltPreVe4
                                             FListaItens[intCont].fltPreVe5,                               // fltPreVe5
                                             FListaItens[intCont].fltPreVe6,                               // fltPreVe6
                                             FListaItens[intCont].fltPreVe7,                               // fltPreVe7
                                             0.0,                                                          // fltMarLuc
                                             FListaItens[intCont].fltSaldos,                               // fltSaldos
                                             'N',                                                          // strIncPis
                                             FListaItens[intCont].fltComVar,                               // fltComVar
                                             FListaItens[intCont].fltComAta,                               // fltComAta
                                             FListaItens[intCont].fltComDis,                               // fltComDis
                                             '',                                                           // strDocDev
                                             '',                                                           // strEspDev
                                             '',                                                           // strEmpDev
                                             0.0,                                                          // fltQtdDev
                                             0.0,                                                          // fltUniDev
                                             '',                                                           // strIncDev
                                             FListaItens[intCont].fltTotUlt,                               // fltTotUlt
                                             FListaItens[intCont].fltImpUlt,                               // fltImpUlt
                                             FListaItens[intCont].fltPreUlt,                               // fltPreUlt
                                             FListaItens[intCont].fltPreMed,                               // fltPreMed
                                             FListaItens[intCont].strClaIpi,                               // strClaIpi
                                             '',                                                           // strIteCha
                                             '',                                                           // strIteTin
                                             '',                                                           // strDesCor
                                             '',                                                           // strTipPre
                                             0,                                                            // intLazQua
                                             '',                                                           // strTipEmb
                                             0.0,                                                          // fltQtdEmb
                                             0.0,                                                          // fltPreEmb
                                             0.0,                                                          // fltPrvTin
                                             0.0,                                                          // fltPrcTin
                                             0.0,                                                          // fltFatTin
                                             'N',                                                          // strProEmb
                                             '',                                                           // strIteEmb
                                             0.0,                                                          // fltUniEmb
                                             0.0,                                                          // fltEmbAnt
                                             FListaItens[intCont].strCodAbf,                               // strCodAbf
                                             FListaItens[intCont].fltPesoIt,                               // fltPesoIt
                                             FListaItens[intCont].fltPesLiq,                               // fltPesLiq
                                             'N',                                                          // strPromoc
                                             0.0,                                                          // fltProPreCus
                                             0.0,                                                          // fltProPreVen
                                             0.0,                                                          // fltProComVar
                                             0.0,                                                          // fltProDesF07
                                             '',                                                           // strTipTin
                                             FObjFatVenda.fRetPerComGrupo(FListaItens[intCont].strCodGru), // fltGPeCom
                                             FListaItens[intCont].strCodFab,                               // strCodFab
                                             -1,                                                           // intSeqInd
                                             0.0,                                                          // fltQtdBai
                                             '',                                                           // strNumOrc
                                             '',                                                           // strEspOrc
                                             '',                                                           // strEmpOrc
                                             FListaItens[intCont].fltMarMin,                               // fltMarMin
                                             FListaItens[intCont].fltMarMSG,                               // fltMarMSG
                                             FListaItens[intCont].fltMarMGe,                               // fltMarMGe
                                             fRetNomMarca(FListaItens[intCont].strCodMar),                 // strMarca
                                             '',                                                           // strStatus
                                             0.0,                                                          // fltComDev
                                             0.0,                                                          // fltDesDev
                                             '',                                                           // strSeqDet
                                             '',                                                           // strCatali
                                             '',                                                           // strLinTin
                                             0.0,                                                          // fltEmbala
                                             'No. SÉRIE: ' + FListaItens[intCont].strNumSer,               // strDesNes
                                             '',                                                           // strSemEst
                                             '',                                                           // strLibEst
                                             FListaItens[intCont].fltPreCom,                               // fltPreCom
                                             FListaItens[intCont].fltUniDig,                               // fltUniDig
                                             FListaItens[intCont].fltQtdPon,                               // fltQtdPon
                                             '',                                                           // strComple
                                             '',                                                           // strDivDev
                                             FListaItens[intCont].strObrCpf,                               // strObrCpf
                                             '',                                                           // strMontad
                                             '',                                                           // strA_n_o_
                                             FListaItens[intCont].strSigUni,                               // strSigUni
                                             0.0,                                                          // fltVolPro
                                             intCont+1,                                                    // intOrdite
                                             '',                                                           // strChaFor
                                             '',                                                           // strCodAca
                                             '',                                                           // strEmpAca
                                             False,                                                        // blnProAca
                                             '',                                                           // strEspFut
                                             '',                                                           // strDocFut
                                             '',                                                           // strEmpFut
                                             0.0,                                                          // fltOutVal
                                             0.0,                                                          // fltComTbl
                                             0.0,                                                          // fltDesOpe
                                             0.0,                                                          // fltICMSai
                                             0.0,                                                          // fltImpFed
                                             0.0,                                                          // fltDesMge
                                             '',                                                           // strDocCnf
                                             '',                                                           // strEspCnf
                                             '',                                                           // strEmpCnf
                                             '1',                                                          // strTabPre
                                             FListaItens[intCont].fltIpiEnt,                               // fltIpiEnt
                                             FListaItens[intCont].fltFreEnt,                               // fltFreEnt
                                             '',                                                           // strCodDil
                                             0.0,                                                          // fltPorDil
                                             '',                                                           // strDilCon
                                             0.0,                                                          // fltPorCat
                                             'R',                                                          // strEntRet
                                             '',                                                           // strLocRet
                                             'N',                                                          // strEntFut
                                             '',                                                           // strMotFut
                                             0,                                                            // dtaDtaEnt
                                             1.0,                                                          // fltQtdOri
                                             0.0,                                                          // fltDesEsp
                                             0.0,                                                          // fltDesBai
                                             FListaItens[intCont].strImpDir,                               // strImpDir
                                             '',                                                           // strLocFis
                                             0.0,                                                          // fltPreCu2
                                             0.0,                                                          // fltTotCu2
                                             0.0,                                                          // fltProComAta
                                             0.0,                                                          // fltProComDis
                                             0.0,                                                          // fltTotPed
                                             0.0,                                                          // fltPanUti
                                             0.0,                                                          // fltTotDes
                                             0.0,                                                          // ftlTotFre
                                             recForTin,                                                    // recForTin
                                             '',                                                           // strKey_EP
                                             '',                                                           // strLotAnt
                                             FListaItens[intCont].strNumLot,                               // strNumLot
                                             '',                                                           // strEmpPrd
                                             '',                                                           // strVenCnf
                                             False,                                                        // blnBxSbIt
                                             'N',                                                          // strPigBas
                                             'NOR',                                                        // strIdeDev
                                             0.0,                                                          // fltQtdDet
                                             '',                                                           // strTabDev
                                             FListaItens[intCont].strCodBar,                               // strCodBar
                                             '',                                                           // strTipFin
                                             0.0,                                                          // fltDesFin
                                             0.0,                                                          // fltPreLot
                                             0.0,                                                          // fltCoDvRp
                                             '',                                                           // strEmpIte
                                             1.0,                                                          // fltFatAce
                                             True,                                                         // blnPodAlt
                                             '',                                                           // strEmpSol
                                             '',                                                           // strCndDev
                                             '',                                                           // strCCndDv
                                             0,                                                            // dtaEmiDev
                                             FListaItens[intCont].fltCusIte,                               // fltCusIte
                                             '',                                                           // strDesSim
                                             '',                                                           // strOrdPro
                                             recMadeira,                                                   // recMadeira
                                             FListaItens[intCont].fltTotImp,                               // fltTotImp
                                             0.0,                                                          // fltVal_RT
                                             0.0,                                                          // fltTaxJur
                                             '',                                                           // strSeqGad
                                             0.0,                                                          // fltQtdExp
                                             '',                                                           // strBarEmb
                                             '',                                                           // strNumCmp
                                             0,                                                            // intNItCmp
                                             0.0,                                                          // fltDeDVCf
                                             '',                                                           // strCodMec
                                             '',                                                           // strSeqRcd
                                             0,                                                            // intSeqInc
                                             '',                                                           // strCodVenIte
                                             'N',                                                          // strAltPCoIte
                                             0.0,                                                          // fltPerComIte
                                             0.0,                                                          // fltFreDev
                                             0.0,                                                          // fltDeADev
                                             False,                                                        // blnAlterandoPDORCarregado
                                             False,                                                        // blnInserindoPDORCarregado
                                             'N',                                                          // strCliBus
                                             '',                                                           // strTurEnt
                                             0,                                                            // intSeqCcr
                                             0.0,                                                          // fltDopTin
                                             '',                                                           // strCodVe2Ite
                                             'N',                                                          // strLibUni
                                             0.0,                                                          // fltValDif
                                             '',                                                           // strLotAba
                                             '',                                                           // strIncFut
                                             '',                                                           // strSepExp
                                             '',                                                           // strTabPreEmb
                                             '',                                                           // strExcIpi
                                             0.0,                                                          // fltDesMSu
                                             '',                                                           // strAiDvOr
                                             strClaFis);                                                   // strClaFis

  End;

  FObjFatVenda.pPreencheMatrizFechamento;
  FObjFatVenda.pCalculaPesBruLiq;
  FObjFatVenda.pCalculaTotGer(False, False, Nil, False);
  FObjFatVenda.strDesCla := fRetDesCla(FObjFatVenda.strClaFis);
  pZeraImpostos();
  FObjFatVenda.pRateiaValores;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      frmGravando.strChave            := 'FATFATURA';
      frmGravando.fExecutarAcao       := FObjFatVenda.fGravaArquivos;
      frmGravando.lblGravando.Caption := 'Aguarde, Gravando Nota fiscal de retorno...';
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;

      If Result Then
      Begin
        FNumDoc := FObjFatVenda.strNumDoc;
        FEspDoc := FObjFatVenda.strEspDoc;
        FEmpDoc := FObjFatVenda.strEmpDoc;
        FSerFsc := FObjFatVenda.strSerFsc;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TNotaFiscalContratoLocacao.fEmiteNotaSimplesRemessa]');
        Result := False;
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TNotaFiscalContratoLocacao.fEmiteNotaSimplesRemessaEnvio: Boolean;
var
  recForTin   : TForTin;
  recMadeira  : TDadosMadeira;
  intCont: Integer;
  intCnt: Integer;
  strClaFis: String;
  frmGravando: TfrmGravando;
begin
  cdsVenda.EmptyDataSet;

  If Not Assigned(FObjFatVenda) Then
    FObjFatVenda := TFatVenda.CreateInstance('OU');
  FObjFatVenda.strOpcDocTrue := 'OU';
  FObjFatVenda.blnVerEstOrc  := False;
  FObjFatVenda.strNomeForm   := 'frmFatVendas';
  FObjFatVenda.strEspDoc := 'NF';
  FObjFatVenda.strTipFat := 'Nota Fiscal';
  FObjFatVenda.strMen001 := 'CONTRATO DE LOCAÇÃO DE EQUIPAMENTO N. ' + FContrato.NroContrato;
  FObjFatVenda.strMen002 := '';
  FObjFatVenda.strOriDoc := 'V';
  FObjFatVenda.strCodVen := FContrato.Vendedor.Codigo;
  FObjFatVenda.strNomVen := FContrato.Vendedor.Nome;
  FObjFatVenda.strConPag := '01000';
  FObjFatVenda.fGravaInfoFora := fGravaDadosDocumentoEnvio;
  FObjFatVenda.pCarregaDadosClienteBaixa(FContrato.CodCliente);

  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    FListaItens[intCont].pCarregarDadosItemNota;

    If FListaItens[intCont].ListaEquipamentoArmazemSemLote.Count > 0 Then
    Begin
      FSLMensagemRetorno.Clear ;

      Case FListaItens[intCont].TipoItem Of
        TpPrincipal : FSLMensagemRetorno.Add('O(s) equipamento(s) (');
        TpAcessorio : FSLMensagemRetorno.Add('O(s) acessório(s) (');
      End;

      For intCnt:= 0 To FListaItens[intCont].ListaEquipamentoArmazemSemLote.Count-1 Do
      Begin
        FSLMensagemRetorno.Add(IIF(intCnt <> 0,
                                   ', ' + FListaItens[intCont].ListaEquipamentoArmazemSemLote[intCnt],
                                   FListaItens[intCont].ListaEquipamentoArmazemSemLote[intCnt]));
      End;

      Case  FListaItens[intCont].TipoItem Of
        TpPrincipal : FSLMensagemRetorno.Add(') não possuem o armazém principal para locação de equipamentos, cadastre o armazém dos equipamentos para continuar!');
        TpAcessorio : FSLMensagemRetorno.Add(') não possuem o armazém principal para locação de equipamentos, cadastre o armazém dos acessórios do equipamento para continuar!');
      End;

      Result := False;
      Exit;
    End;

    strClaFis := fRetornaClaFisSaida(FObjFatVenda.fDentroDoEstadoCFOP);

    FObjFatVenda.pAdicionaRegistroTemporaria(cdsVenda,                                                     // cdsDados
                                             Nil,                                                          // btnAdicionar
                                             'NOR',                                                        // strIdePro
                                             FListaItens[intCont].strCodGru,                               // strCodGru
                                             FListaItens[intCont].strCodIte,                               // strCodIte
                                             FListaItens[intCont].Descricao,                               // strDesOri
                                             FListaItens[intCont].strIteDes,                               // strDesIte
                                             FListaItens[intCont].strDesFab,                               // strDesFab
                                             FListaItens[intCont].strUnidad,                               // strUnidad
                                             FListaItens[intCont].strCodUni,                               // strCodUni
                                             FListaItens[intCont].strCodMar,                               // strCodMar
                                             FListaItens[intCont].strCodFor,                               // strCodFor
                                             FListaItens[intCont].strRefere,                               // strRefere
                                             FListaItens[intCont].fltUniOri,                               // fltUniOri
                                             FListaItens[intCont].fltUniVis,                               // fltUniVis
                                             FListaItens[intCont].fltUniTar,                               // fltUniTar
                                             0.0,                                                          // fltUniTmp
                                             0.0,                                                          // fltDesCon
                                             FListaItens[intCont].fltQtdIte,                               // fltQtdIte
                                             FListaItens[intCont].fltTotIte,                               // fltTotIte
                                             'S',                                                          // strEntSai
                                             FListaItens[intCont].fltPreCus,                               // fltPreCus
                                             FListaItens[intCont].fltTotCus,                               // fltTotCus
                                             FListaItens[intCont].strComLub,                               // strComLub
                                             FListaItens[intCont].fltIpiSai,                               // fltIpiSai
                                             FListaItens[intCont].fltDesMax,                               // fltDesMax
                                             FListaItens[intCont].fltPreVe1,                               // fltPreVe1
                                             FListaItens[intCont].fltPreVe2,                               // fltPreVe2
                                             FListaItens[intCont].fltPreVe3,                               // fltPreVe3
                                             FListaItens[intCont].fltPreVe4,                               // fltPreVe4
                                             FListaItens[intCont].fltPreVe5,                               // fltPreVe5
                                             FListaItens[intCont].fltPreVe6,                               // fltPreVe6
                                             FListaItens[intCont].fltPreVe7,                               // fltPreVe7
                                             0.0,                                                          // fltMarLuc
                                             FListaItens[intCont].fltSaldos,                               // fltSaldos
                                             'N',                                                          // strIncPis
                                             FListaItens[intCont].fltComVar,                               // fltComVar
                                             FListaItens[intCont].fltComAta,                               // fltComAta
                                             FListaItens[intCont].fltComDis,                               // fltComDis
                                             '',                                                           // strDocDev
                                             '',                                                           // strEspDev
                                             '',                                                           // strEmpDev
                                             0.0,                                                          // fltQtdDev
                                             0.0,                                                          // fltUniDev
                                             '',                                                           // strIncDev
                                             FListaItens[intCont].fltTotUlt,                               // fltTotUlt
                                             FListaItens[intCont].fltImpUlt,                               // fltImpUlt
                                             FListaItens[intCont].fltPreUlt,                               // fltPreUlt
                                             FListaItens[intCont].fltPreMed,                               // fltPreMed
                                             FListaItens[intCont].strClaIpi,                               // strClaIpi
                                             '',                                                           // strIteCha
                                             '',                                                           // strIteTin
                                             '',                                                           // strDesCor
                                             '',                                                           // strTipPre
                                             0,                                                            // intLazQua
                                             '',                                                           // strTipEmb
                                             0.0,                                                          // fltQtdEmb
                                             0.0,                                                          // fltPreEmb
                                             0.0,                                                          // fltPrvTin
                                             0.0,                                                          // fltPrcTin
                                             0.0,                                                          // fltFatTin
                                             'N',                                                          // strProEmb
                                             '',                                                           // strIteEmb
                                             0.0,                                                          // fltUniEmb
                                             0.0,                                                          // fltEmbAnt
                                             FListaItens[intCont].strCodAbf,                               // strCodAbf
                                             FListaItens[intCont].fltPesoIt,                               // fltPesoIt
                                             FListaItens[intCont].fltPesLiq,                               // fltPesLiq
                                             'N',                                                          // strPromoc
                                             0.0,                                                          // fltProPreCus
                                             0.0,                                                          // fltProPreVen
                                             0.0,                                                          // fltProComVar
                                             0.0,                                                          // fltProDesF07
                                             '',                                                           // strTipTin
                                             FObjFatVenda.fRetPerComGrupo(FListaItens[intCont].strCodGru), // fltGPeCom
                                             FListaItens[intCont].strCodFab,                               // strCodFab
                                             -1,                                                           // intSeqInd
                                             0.0,                                                          // fltQtdBai
                                             '',                                                           // strNumOrc
                                             '',                                                           // strEspOrc
                                             '',                                                           // strEmpOrc
                                             FListaItens[intCont].fltMarMin,                               // fltMarMin
                                             FListaItens[intCont].fltMarMSG,                               // fltMarMSG
                                             FListaItens[intCont].fltMarMGe,                               // fltMarMGe
                                             fRetNomMarca(FListaItens[intCont].strCodMar),                 // strMarca
                                             '',                                                           // strStatus
                                             0.0,                                                          // fltComDev
                                             0.0,                                                          // fltDesDev
                                             '',                                                           // strSeqDet
                                             '',                                                           // strCatali
                                             '',                                                           // strLinTin
                                             0.0,                                                          // fltEmbala
                                             'No. SÉRIE: ' + FListaItens[intCont].strNumSer,               // strDesNes
                                             '',                                                           // strSemEst
                                             '',                                                           // strLibEst
                                             FListaItens[intCont].fltPreCom,                               // fltPreCom
                                             FListaItens[intCont].fltUniDig,                               // fltUniDig
                                             FListaItens[intCont].fltQtdPon,                               // fltQtdPon
                                             '',                                                           // strComple
                                             '',                                                           // strDivDev
                                             FListaItens[intCont].strObrCpf,                               // strObrCpf
                                             '',                                                           // strMontad
                                             '',                                                           // strA_n_o_
                                             FListaItens[intCont].strSigUni,                               // strSigUni
                                             0.0,                                                          // fltVolPro
                                             intCont+1,                                                    // intOrdite
                                             '',                                                           // strChaFor
                                             '',                                                           // strCodAca
                                             '',                                                           // strEmpAca
                                             False,                                                        // blnProAca
                                             '',                                                           // strEspFut
                                             '',                                                           // strDocFut
                                             '',                                                           // strEmpFut
                                             0.0,                                                          // fltOutVal
                                             0.0,                                                          // fltComTbl
                                             0.0,                                                          // fltDesOpe
                                             0.0,                                                          // fltICMSai
                                             0.0,                                                          // fltImpFed
                                             0.0,                                                          // fltDesMge
                                             '',                                                           // strDocCnf
                                             '',                                                           // strEspCnf
                                             '',                                                           // strEmpCnf
                                             '1',                                                          // strTabPre
                                             FListaItens[intCont].fltIpiEnt,                               // fltIpiEnt
                                             FListaItens[intCont].fltFreEnt,                               // fltFreEnt
                                             '',                                                           // strCodDil
                                             0.0,                                                          // fltPorDil
                                             '',                                                           // strDilCon
                                             0.0,                                                          // fltPorCat
                                             'R',                                                          // strEntRet
                                             '',                                                           // strLocRet
                                             'N',                                                          // strEntFut
                                             '',                                                           // strMotFut
                                             0,                                                            // dtaDtaEnt
                                             1.0,                                                          // fltQtdOri
                                             0.0,                                                          // fltDesEsp
                                             0.0,                                                          // fltDesBai
                                             FListaItens[intCont].strImpDir,                               // strImpDir
                                             '',                                                           // strLocFis
                                             0.0,                                                          // fltPreCu2
                                             0.0,                                                          // fltTotCu2
                                             0.0,                                                          // fltProComAta
                                             0.0,                                                          // fltProComDis
                                             0.0,                                                          // fltTotPed
                                             0.0,                                                          // fltPanUti
                                             0.0,                                                          // fltTotDes
                                             0.0,                                                          // ftlTotFre
                                             recForTin,                                                    // recForTin
                                             '',                                                           // strKey_EP
                                             '',                                                           // strLotAnt
                                             FListaItens[intCont].strNumLot,                               // strNumLot
                                             '',                                                           // strEmpPrd
                                             '',                                                           // strVenCnf
                                             False,                                                        // blnBxSbIt
                                             'N',                                                          // strPigBas
                                             'NOR',                                                        // strIdeDev
                                             0.0,                                                          // fltQtdDet
                                             '',                                                           // strTabDev
                                             FListaItens[intCont].strCodBar,                               // strCodBar
                                             '',                                                           // strTipFin
                                             0.0,                                                          // fltDesFin
                                             0.0,                                                          // fltPreLot
                                             0.0,                                                          // fltCoDvRp
                                             '',                                                           // strEmpIte
                                             1.0,                                                          // fltFatAce
                                             True,                                                         // blnPodAlt
                                             '',                                                           // strEmpSol
                                             '',                                                           // strCndDev
                                             '',                                                           // strCCndDv
                                             0,                                                            // dtaEmiDev
                                             FListaItens[intCont].fltCusIte,                               // fltCusIte
                                             '',                                                           // strDesSim
                                             '',                                                           // strOrdPro
                                             recMadeira,                                                   // recMadeira
                                             FListaItens[intCont].fltTotImp,                               // fltTotImp
                                             0.0,                                                          // fltVal_RT
                                             0.0,                                                          // fltTaxJur
                                             '',                                                           // strSeqGad
                                             0.0,                                                          // fltQtdExp
                                             '',                                                           // strBarEmb
                                             '',                                                           // strNumCmp
                                             0,                                                            // intNItCmp
                                             0.0,                                                          // fltDeDVCf
                                             '',                                                           // strCodMec
                                             '',                                                           // strSeqRcd
                                             0,                                                            // intSeqInc
                                             '',                                                           // strCodVenIte
                                             'N',                                                          // strAltPCoIte
                                             0.0,                                                          // fltPerComIte
                                             0.0,                                                          // fltFreDev
                                             0.0,                                                          // fltDeADev
                                             False,                                                        // blnAlterandoPDORCarregado
                                             False,                                                        // blnInserindoPDORCarregado
                                             'N',                                                          // strCliBus
                                             '',                                                           // strTurEnt
                                             0,                                                            // intSeqCcr
                                             0.0,                                                          // fltDopTin
                                             '',                                                           // strCodVe2Ite
                                             'N',                                                          // strLibUni
                                             0.0,                                                          // fltValDif
                                             '',                                                           // strLotAba
                                             '',                                                           // strIncFut
                                             '',                                                           // strSepExp
                                             '',                                                           // strTabPreEmb
                                             '',                                                           // strExcIpi
                                             0.0,                                                          // fltDesMSu
                                             '',                                                           // strAiDvOr
                                             strClaFis);                                                   // strClaFis

  End;


  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    FObjFatVenda.pPreencheMatrizFechamento;
    FObjFatVenda.pCalculaPesBruLiq;
    FObjFatVenda.pCalculaTotGer(False, False, Nil, False);
    FObjFatVenda.strDesCla := fRetDesCla(FObjFatVenda.strClaFis);
    pZeraImpostos();
    FObjFatVenda.pRateiaValores;

    If fCfgSis('ENVDNF', VarBoolean) Then
    Begin
      If Not fPedeDadosEmissaoNotaFiscal Then
        Exit(False);
    End;

    Try
      frmGravando.strChave            := 'FATFATURA';
      frmGravando.fExecutarAcao       := FObjFatVenda.fGravaArquivos;
      frmGravando.lblGravando.Caption := 'Aguarde, Gravando Nota fiscal de envio...';
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;

      If Result Then
      Begin
        FNumDoc := FObjFatVenda.strNumDoc;
        FEspDoc := FObjFatVenda.strEspDoc;
        FEmpDoc := FObjFatVenda.strEmpDoc;
        FSerFsc := FObjFatVenda.strSerFsc;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TNotaFiscalContratoLocacao.fEmiteNotaSimplesRemessa]');
        Result := False;
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;

end;

function TNotaFiscalContratoLocacao.fRetornaClaFisEntrada(blnDentroEstado: Boolean): String;
var
  strCFOP: String;
Begin
  strCFOP := fCfgSis('CFOPRT', varString);

  If (blnDentroEstado) Then
    Result := '1' + strCFOP
  Else
    Result := '2' + strCFOP;
End;

function TNotaFiscalContratoLocacao.fRetornaClaFisSaida(blnDentroEstado: Boolean): String;
var
  strCFOP: String;
Begin
   strCFOP := fCfgSis('CFOPEV', varString);

  If (blnDentroEstado) Then
    Result := '5' + strCFOP
  Else
    Result := '6' + strCFOP;
End;

function TNotaFiscalContratoLocacao.fEmiteNotaSimplesRemessaRetorno: Boolean;
var
  recForTin   : TForTin;
  recMadeira  : TDadosMadeira;
  intCont: Integer;
  intCnt: Integer;
  strClaFis: String;
  frmGravando: TfrmGravando;
begin
  cdsVenda.EmptyDataSet;

  If Not Assigned(FObjFatVenda) Then
    FObjFatVenda := TFatVenda.CreateInstance('OE');

  FObjFatVenda.strOpcDocTrue := 'OE';
  FObjFatVenda.blnVerEstOrc  := False;
  FObjFatVenda.strNomeForm   := 'frmFatVendas';
  FObjFatVenda.strEspDoc := 'NF';
  FObjFatVenda.strTipFat := 'Nota Fiscal';
  FObjFatVenda.strMen001 := 'CONTRATO DE LOCAÇÃO DE EQUIPAMENTO N. ' + FContrato.NroContrato;
  FObjFatVenda.strMen002 := '';
  FObjFatVenda.strOriDoc := 'V';
  FObjFatVenda.strCodVen := FContrato.Vendedor.Codigo;
  FObjFatVenda.strNomVen := FContrato.Vendedor.Nome;
  FObjFatVenda.strConPag := FContrato.CondicaoPgto;
  FObjFatVenda.fGravaInfoFora := fGravaDadosDocumentoRetorno;
  FObjFatVenda.pCarregaDadosClienteBaixa(FContrato.CodCliente);

  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    FListaItens[intCont].pCarregarDadosItemNota;

    If FListaItens[intCont].ListaEquipamentoArmazemSemLote.Count > 0 Then
    Begin
      FSLMensagemRetorno.Clear ;

      Case FListaItens[intCont].TipoItem Of
       TpPrincipal : FSLMensagemRetorno.Add('O(s) equipamento(s) (');
       TpAcessorio : FSLMensagemRetorno.Add('O(s) acessório(s) (');
      End;

      For intCnt:= 0 To FListaItens[intCont].ListaEquipamentoArmazemSemLote.Count-1 Do
      Begin
        If intCnt <> 0 Then
          FSLMensagemRetorno.Add( ', ' + FListaItens[intCont].ListaEquipamentoArmazemSemLote[intCnt])
        Else
          FSLMensagemRetorno.Add(FListaItens[intCont].ListaEquipamentoArmazemSemLote[intCnt]);
      End;

      Case  FListaItens[intCont].TipoItem Of
        TpPrincipal : FSLMensagemRetorno.Add(') não possuem o armazém principal para locação de equipamentos, cadastre o armazém dos equipamentos para continuar!');
        TpAcessorio : FSLMensagemRetorno.Add(') não possuem o armazém principal para locação de equipamentos, cadastre o armazém dos acessórios do equipamento para continuar!');
      End;

      Result := False;
      Exit;
    End;

    strClaFis := fRetornaClaFisEntrada(FObjFatVenda.fDentroDoEstadoCFOP);

    FObjFatVenda.pAdicionaRegistroTemporaria(cdsVenda,                                                     // cdsDados
                                             Nil,                                                          // btnAdicionar
                                             'NOR',                                                        // strIdePro
                                             FListaItens[intCont].strCodGru,                               // strCodGru
                                             FListaItens[intCont].strCodIte,                               // strCodIte
                                             FListaItens[intCont].Descricao,                               // strDesOri
                                             FListaItens[intCont].strIteDes,                               // strDesIte
                                             FListaItens[intCont].strDesFab,                               // strDesFab
                                             FListaItens[intCont].strUnidad,                               // strUnidad
                                             FListaItens[intCont].strCodUni,                               // strCodUni
                                             FListaItens[intCont].strCodMar,                               // strCodMar
                                             FListaItens[intCont].strCodFor,                               // strCodFor
                                             FListaItens[intCont].strRefere,                               // strRefere
                                             FListaItens[intCont].fltUniOri,                               // fltUniOri
                                             FListaItens[intCont].fltUniVis,                               // fltUniVis
                                             FListaItens[intCont].fltUniTar,                               // fltUniTar
                                             0.0,                                                          // fltUniTmp
                                             0.0,                                                          // fltDesCon
                                             FListaItens[intCont].fltQtdIte,                               // fltQtdIte
                                             FListaItens[intCont].fltTotIte,                               // fltTotIte
                                             'E',                                                          // strEntSai
                                             FListaItens[intCont].fltPreCus,                               // fltPreCus
                                             FListaItens[intCont].fltTotCus,                               // fltTotCus
                                             FListaItens[intCont].strComLub,                               // strComLub
                                             FListaItens[intCont].fltIpiSai,                               // fltIpiSai
                                             FListaItens[intCont].fltDesMax,                               // fltDesMax
                                             FListaItens[intCont].fltPreVe1,                               // fltPreVe1
                                             FListaItens[intCont].fltPreVe2,                               // fltPreVe2
                                             FListaItens[intCont].fltPreVe3,                               // fltPreVe3
                                             FListaItens[intCont].fltPreVe4,                               // fltPreVe4
                                             FListaItens[intCont].fltPreVe5,                               // fltPreVe5
                                             FListaItens[intCont].fltPreVe6,                               // fltPreVe6
                                             FListaItens[intCont].fltPreVe7,                               // fltPreVe7
                                             0.0,                                                          // fltMarLuc
                                             FListaItens[intCont].fltSaldos,                               // fltSaldos
                                             'N',                                                          // strIncPis
                                             FListaItens[intCont].fltComVar,                               // fltComVar
                                             FListaItens[intCont].fltComAta,                               // fltComAta
                                             FListaItens[intCont].fltComDis,                               // fltComDis
                                             '',                                                           // strDocDev
                                             '',                                                           // strEspDev
                                             '',                                                           // strEmpDev
                                             0.0,                                                          // fltQtdDev
                                             0.0,                                                          // fltUniDev
                                             '',                                                           // strIncDev
                                             FListaItens[intCont].fltTotUlt,                               // fltTotUlt
                                             FListaItens[intCont].fltImpUlt,                               // fltImpUlt
                                             FListaItens[intCont].fltPreUlt,                               // fltPreUlt
                                             FListaItens[intCont].fltPreMed,                               // fltPreMed
                                             FListaItens[intCont].strClaIpi,                               // strClaIpi
                                             '',                                                           // strIteCha
                                             '',                                                           // strIteTin
                                             '',                                                           // strDesCor
                                             '',                                                           // strTipPre
                                             0,                                                            // intLazQua
                                             '',                                                           // strTipEmb
                                             0.0,                                                          // fltQtdEmb
                                             0.0,                                                          // fltPreEmb
                                             0.0,                                                          // fltPrvTin
                                             0.0,                                                          // fltPrcTin
                                             0.0,                                                          // fltFatTin
                                             'N',                                                          // strProEmb
                                             '',                                                           // strIteEmb
                                             0.0,                                                          // fltUniEmb
                                             0.0,                                                          // fltEmbAnt
                                             FListaItens[intCont].strCodAbf,                               // strCodAbf
                                             FListaItens[intCont].fltPesoIt,                               // fltPesoIt
                                             FListaItens[intCont].fltPesLiq,                               // fltPesLiq
                                             'N',                                                          // strPromoc
                                             0.0,                                                          // fltProPreCus
                                             0.0,                                                          // fltProPreVen
                                             0.0,                                                          // fltProComVar
                                             0.0,                                                          // fltProDesF07
                                             '',                                                           // strTipTin
                                             FObjFatVenda.fRetPerComGrupo(FListaItens[intCont].strCodGru), // fltGPeCom
                                             FListaItens[intCont].strCodFab,                               // strCodFab
                                             -1,                                                           // intSeqInd
                                             0.0,                                                          // fltQtdBai
                                             '',                                                           // strNumOrc
                                             '',                                                           // strEspOrc
                                             '',                                                           // strEmpOrc
                                             FListaItens[intCont].fltMarMin,                               // fltMarMin
                                             FListaItens[intCont].fltMarMSG,                               // fltMarMSG
                                             FListaItens[intCont].fltMarMGe,                               // fltMarMGe
                                             fRetNomMarca(FListaItens[intCont].strCodMar),                 // strMarca
                                             '',                                                           // strStatus
                                             0.0,                                                          // fltComDev
                                             0.0,                                                          // fltDesDev
                                             '',                                                           // strSeqDet
                                             '',                                                           // strCatali
                                             '',                                                           // strLinTin
                                             0.0,                                                          // fltEmbala
                                             'No. SÉRIE: ' + FListaItens[intCont].strNumSer,               // strDesNes
                                             '',                                                           // strSemEst
                                             '',                                                           // strLibEst
                                             FListaItens[intCont].fltPreCom,                               // fltPreCom
                                             FListaItens[intCont].fltUniDig,                               // fltUniDig
                                             FListaItens[intCont].fltQtdPon,                               // fltQtdPon
                                             '',                                                           // strComple
                                             '',                                                           // strDivDev
                                             FListaItens[intCont].strObrCpf,                               // strObrCpf
                                             '',                                                           // strMontad
                                             '',                                                           // strA_n_o_
                                             FListaItens[intCont].strSigUni,                               // strSigUni
                                             0.0,                                                          // fltVolPro
                                             intCont+1,                                                    // intOrdite
                                             '',                                                           // strChaFor
                                             '',                                                           // strCodAca
                                             '',                                                           // strEmpAca
                                             False,                                                        // blnProAca
                                             '',                                                           // strEspFut
                                             '',                                                           // strDocFut
                                             '',                                                           // strEmpFut
                                             0.0,                                                          // fltOutVal
                                             0.0,                                                          // fltComTbl
                                             0.0,                                                          // fltDesOpe
                                             0.0,                                                          // fltICMSai
                                             0.0,                                                          // fltImpFed
                                             0.0,                                                          // fltDesMge
                                             '',                                                           // strDocCnf
                                             '',                                                           // strEspCnf
                                             '',                                                           // strEmpCnf
                                             '1',                                                          // strTabPre
                                             FListaItens[intCont].fltIpiEnt,                               // fltIpiEnt
                                             FListaItens[intCont].fltFreEnt,                               // fltFreEnt
                                             '',                                                           // strCodDil
                                             0.0,                                                          // fltPorDil
                                             '',                                                           // strDilCon
                                             0.0,                                                          // fltPorCat
                                             'R',                                                          // strEntRet
                                             '',                                                           // strLocRet
                                             'N',                                                          // strEntFut
                                             '',                                                           // strMotFut
                                             0,                                                            // dtaDtaEnt
                                             1.0,                                                          // fltQtdOri
                                             0.0,                                                          // fltDesEsp
                                             0.0,                                                          // fltDesBai
                                             FListaItens[intCont].strImpDir,                               // strImpDir
                                             '',                                                           // strLocFis
                                             0.0,                                                          // fltPreCu2
                                             0.0,                                                          // fltTotCu2
                                             0.0,                                                          // fltProComAta
                                             0.0,                                                          // fltProComDis
                                             0.0,                                                          // fltTotPed
                                             0.0,                                                          // fltPanUti
                                             0.0,                                                          // fltTotDes
                                             0.0,                                                          // ftlTotFre
                                             recForTin,                                                    // recForTin
                                             '',                                                           // strKey_EP
                                             '',                                                           // strLotAnt
                                             FListaItens[intCont].strNumLot,                               // strNumLot
                                             '',                                                           // strEmpPrd
                                             '',                                                           // strVenCnf
                                             False,                                                        // blnBxSbIt
                                             'N',                                                          // strPigBas
                                             'NOR',                                                        // strIdeDev
                                             0.0,                                                          // fltQtdDet
                                             '',                                                           // strTabDev
                                             FListaItens[intCont].strCodBar,                               // strCodBar
                                             '',                                                           // strTipFin
                                             0.0,                                                          // fltDesFin
                                             0.0,                                                          // fltPreLot
                                             0.0,                                                          // fltCoDvRp
                                             '',                                                           // strEmpIte
                                             1.0,                                                          // fltFatAce
                                             True,                                                         // blnPodAlt
                                             '',                                                           // strEmpSol
                                             '',                                                           // strCndDev
                                             '',                                                           // strCCndDv
                                             0,                                                            // dtaEmiDev
                                             FListaItens[intCont].fltCusIte,                               // fltCusIte
                                             '',                                                           // strDesSim
                                             '',                                                           // strOrdPro
                                             recMadeira,                                                   // recMadeira
                                             FListaItens[intCont].fltTotImp,                               // fltTotImp
                                             0.0,                                                          // fltVal_RT
                                             0.0,                                                          // fltTaxJur
                                             '',                                                           // strSeqGad
                                             0.0,                                                          // fltQtdExp
                                             '',                                                           // strBarEmb
                                             '',                                                           // strNumCmp
                                             0,                                                            // intNItCmp
                                             0.0,                                                          // fltDeDVCf
                                             '',                                                           // strCodMec
                                             '',                                                           // strSeqRcd
                                             0,                                                            // intSeqInc
                                             '',                                                           // strCodVenIte
                                             'N',                                                          // strAltPCoIte
                                             0.0,                                                          // fltPerComIte
                                             0.0,                                                          // fltFreDev
                                             0.0,                                                          // fltDeADev
                                             False,                                                        // blnAlterandoPDORCarregado
                                             False,                                                        // blnInserindoPDORCarregado
                                             'N',                                                          // strCliBus
                                             '',                                                           // strTurEnt
                                             0,                                                            // intSeqCcr
                                             0.0,                                                          // fltDopTin
                                             '',                                                           // strCodVe2Ite
                                             'N',                                                          // strLibUni
                                             0.0,                                                          // fltValDif
                                             '',                                                           // strLotAba
                                             '',                                                           // strIncFut
                                             '',                                                           // strSepExp
                                             '',                                                           // strTabPreEmb
                                             '',                                                           // strExcIpi
                                             0.0,                                                          // fltDesMSu
                                             '',                                                           // strAiDvOr
                                             strClaFis);                                                   // strClaFis

  End;

  FObjFatVenda.pPreencheMatrizFechamento;
  FObjFatVenda.pCalculaPesBruLiq;
  FObjFatVenda.pCalculaTotGer(False, False, Nil, False);
  FObjFatVenda.strDesCla := fRetDesCla(FObjFatVenda.strClaFis);
  pZeraImpostos();
  FObjFatVenda.pRateiaValores;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      frmGravando.strChave            := 'FATFATURA';
      frmGravando.fExecutarAcao       := FObjFatVenda.fGravaArquivos;
      frmGravando.lblGravando.Caption := 'Aguarde, Gravando Nota fiscal de retorno...';
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;

      If Result Then
      Begin
        FNumDoc := FObjFatVenda.strNumDoc;
        FEspDoc := FObjFatVenda.strEspDoc;
        FEmpDoc := FObjFatVenda.strEmpDoc;
        FSerFsc := FObjFatVenda.strSerFsc;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TNotaFiscalContratoLocacao.fEmiteNotaSimplesRemessa]');
        Result := False;
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TNotaFiscalContratoLocacao.fGravaDadosDocumentoEnvio: Boolean;
var
  intCont: Integer;
begin
  If Not Assigned(FObjFatVenda) Then
  Begin
    Result := False;
    Exit;
  End;

  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    Case  FListaItens[intCont].TipoItem Of
      TpPrincipal : pGravaDadosEnvioEquipamentoDocumento(FListaItens[intCont].ItemContrato.AutInc);
      TpAcessorio : pGravaDadosEnvioAcessorioDocumento(FListaItens[intCont].AcessorioContrato.AutInc);
    End;
  End;

  Result := True;

end;

function TNotaFiscalContratoLocacao.fGravaDadosDocumentoRetorno(strNumDoc,
  strEspDoc, strCodEmp, strSerie: String): Boolean;
var
  intCont: Integer;
begin
  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    Case  FListaItens[intCont].TipoItem Of
      TpPrincipal : pGravaDadosRetornoEquipamentoDocumento(FListaItens[intCont].ItemContrato.AutInc, strNumDoc, strEspDoc, strCodEmp, strSerie);
      TpAcessorio : pGravaDadosRetornoAcessorioDocumento(FListaItens[intCont].FItemAcessorioContrato.AutInc, strNumDoc,strEspDoc, strCodEmp, strSerie);
    End;
  End;

  Result := True;
end;

function TNotaFiscalContratoLocacao.fPedeDadosEmissaoNotaFiscal: Boolean;
var
  frmFatDadosFiscais: TfrmFatDadosFiscais;
begin
  pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
  Try
    Try
      frmFatDadosFiscais.fatVenda := FObjFatVenda;
      frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
      frmFatDadosFiscais.blnPodeCancelar  := True;

      frmFatDadosFiscais.ShowModal;
      Result := frmFatDadosFiscais.blnConfirma;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fPedeDadosEmissaoNotaFiscal_1');
      End;
    End;
  Finally
    pFreeAndNil(frmFatDadosFiscais);
    FObjFatVenda.objDadosCte.blnGrava := False;
  End;
end;

function TNotaFiscalContratoLocacao.fGravaDadosDocumentoRetorno: Boolean;
var
  intCont: Integer;
begin
  If Not Assigned(FObjFatVenda) Then
  Begin
    Result := False;
    Exit;
  End;

  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    Case  FListaItens[intCont].TipoItem Of
      TpPrincipal : pGravaDadosRetornoEquipamentoDocumento(FListaItens[intCont].ItemContrato.AutInc);
      TpAcessorio : pGravaDadosRetornoAcessorioDocumento(FListaItens[intCont].FItemAcessorioContrato.AutInc);
    End;
  End;

  Result := True;

end;

function TNotaFiscalContratoLocacao.fSelecionaNotaEntradaExistente(var strNumDoc, strEspDoc,
  strCodEmp, strSerie: String): Boolean;
Var
  frmSelDocEntrada: TfrmSelDocEntrada;
begin
  Result := False;
  pCriarFormularios(TfrmSelDocEntrada, frmSelDocEntrada);
  Try
    frmSelDocEntrada.ShowModal;
    If frmSelDocEntrada.blnConfirma Then
    Begin
      If  fValidaDocEntrada(frmSelDocEntrada.strNumDoc,
                            frmSelDocEntrada.strEspDoc,
                            frmSelDocEntrada.strEmpDoc,
                            frmSelDocEntrada.strSerDoc) Then
      Begin
        strNumDoc := frmSelDocEntrada.strNumDoc;
        strEspDoc := frmSelDocEntrada.strEspDoc;
        strCodEmp := frmSelDocEntrada.strEmpDoc;
        strSerie  := frmSelDocEntrada.strSerDoc;

        Result := True;
      End
    End;
  Finally
    pFreeAndNil(frmSelDocEntrada);
  End;
end;

function TNotaFiscalContratoLocacao.fValidaDocEntrada(strNumDoc, strEspDoc, strCodEmp,
  strSerie: String): Boolean;
var
  strSQL: String;
  intCnt: Integer;
  qryPes: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT                       ';
  strSQL := strSQL + '  DET_CODITE                          ';
  strSQL := strSQL + 'FROM                                  ';
  strSQL := strSQL + '  MOVDET                              ';
  strSQL := strSQL + 'WHERE DET_NUMDOC = :NUMDOC            ';
  strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC            ';
  strSQL := strSQL + '  AND DET_CODEMP = :CODEMP            ';
  strSQL := strSQL + '  AND IFNULL(DET_SERIE_, "") = :SERIE ';
  strSQL := strSQL + '  AND LEFT(DET_CLAFIS, 1) < 5         ';

  qryPes := fCriaQuery();
  Try
    qryPes.SQL.Text := strSQL;
    qryPes.ParamByName('NUMDOC').AsString := strNumDoc;
    qryPes.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPes.ParamByName('CODEMP').AsString := strCodEmp;
    qryPes.ParamByName('SERIE').AsString  := strSerie;
    qryPes.Open;

    Result := True;

    For intCnt := 0 To  FListaItens.Count-1 Do
    Begin
      If Not qryPes.Locate('DET_CODITE', FListaItens[intCnt].FCodigoItem, []) Then
      Begin
        fMensagem('ATENÇÃO', 'O produto de código ' + FListaItens[intCnt].FCodigoItem +
                             ' referente ao equipamento ' +
                             FListaItens[intCnt].FEqdCodigo + '-' +
                             FListaItens[intCnt].FEqdDescri +
                             ' não está entre os itens do documento de entrada informado!',
                  ['&OK']);
        Result := False;
        Exit;
      End;
    End;
  Finally
    FreeAndNil(qryPes);
  End;
end;

function TNotaFiscalContratoLocacao.fValidaPodeEmitirDocumento: Boolean;
var
  intCnt: Integer;
  PrecoContrato: TPrecoContrato;
  stlEquipamentosSemVlrCau,
  stlAcessoriosSemVlrCau: TStringList;
begin
  PrecoContrato :=  TPrecoContrato(fCfgSis('PRECTR', varInteger));

  stlEquipamentosSemVlrCau := TStringList.Create;
  stlAcessoriosSemVlrCau   := TStringList.Create;
  Try
    If PrecoContrato = preCaucao Then
    Begin
      For intCnt := 0 To  FListaItens.Count-1 Do
      Begin
        If FListaItens[intCnt].TipoItem = tpPrincipal Then
        Begin
          If FListaItens[intCnt].FItemContrato.Equipamento.ValorCaucao <= 0 Then
          Begin
            stlEquipamentosSemVlrCau.Add(FListaItens[intCnt].FItemContrato.Equipamento.Codigo + ' - ' +
                                         FListaItens[intCnt].FItemContrato.Equipamento.Descricao);
          End;
        End
        Else
        Begin
          If FListaItens[intCnt].FItemAcessorioContrato.Acessorio.ValorCaucao <= 0 Then
          Begin
            stlAcessoriosSemVlrCau.Add(FListaItens[intCnt].FItemAcessorioContrato.Acessorio.Codigo + ' - ' +
                                       FListaItens[intCnt].FItemAcessorioContrato.Acessorio.Descricao);
          End;
        End;
      End;
    End;

    Result := (stlEquipamentosSemVlrCau.Count <= 0) And
              (stlAcessoriosSemVlrCau.Count <= 0);

    If Not Result Then
    Begin
      FSLMensagemRetorno.Add('O sistema está configurado para utilizar o "Valor Caução" dos equipamentos na emissão de documentos, '+
                             'verifique o preenchimento do campo correspondente para os equipamentos a seguir'  );

      If stlEquipamentosSemVlrCau.Count > 0 Then
      Begin
        FSLMensagemRetorno.Add('');
        FSLMensagemRetorno.Add('Equipamentos:');
        FSLMensagemRetorno.Add(stlEquipamentosSemVlrCau.Text);
      End;

      If stlAcessoriosSemVlrCau.Count > 0 Then
      Begin
        FSLMensagemRetorno.Add('');
        FSLMensagemRetorno.Add('Acessórios:');
        FSLMensagemRetorno.Add(stlAcessoriosSemVlrCau.Text);
      End;
    End;
  Finally
    FreeAndNil(stlEquipamentosSemVlrCau);
    FreeAndNil(stlAcessoriosSemVlrCau);
  End;
end;

function TNotaFiscalContratoLocacao.fValidaPodeEmitirDocumentoEntrada: Boolean;
begin
  Result := True;
  FSLMensagemRetorno.Clear;
  If fEmptyStr(fCfgSis('CFOPRT', varString)) Then
  Begin
    FSLMensagemRetorno.Add('A configuração [CFG_CFOPEV - Rotina Locação de Equipamentos - CFOP para Retorno de Equipamento] não está preenchida. Verifique!');
    Exit(False);
  End;
end;

function TNotaFiscalContratoLocacao.fValidaPodeEmitirDocumentoSaida: Boolean;
begin
  Result := True;
  FSLMensagemRetorno.Clear;
  If fEmptyStr(fCfgSis('CFOPEV', varString)) Then
  Begin
    FSLMensagemRetorno.Add('"A configuração [CFG_CFOPEV - Rotina Locação de Equipamentos - CFOP para Envio de Equipamento] não está preenchida. Verifique!"');
    Exit(False);
  End;
end;

procedure TNotaFiscalContratoLocacao.pGravaDadosEnvioAcessorioDocumento(const aAutInc: String);
var
  strSQLAcessorio: String;
  qryUpd: TUniQuery;
begin
  If Not Assigned(FObjFatVenda) Then
  Begin
    Exit;
  End;

  strSQLAcessorio := '';
  strSQLAcessorio := strSQLAcessorio + 'UPDATE ACLDET            ';
  strSQLAcessorio := strSQLAcessorio + 'SET EQD_NUMENV = :NUMENV,  ';
  strSQLAcessorio := strSQLAcessorio + '    EQD_ESPENV = :ESPENV,  ';
  strSQLAcessorio := strSQLAcessorio + '    EQD_EMPENV = :EMPENV,  ';
  strSQLAcessorio := strSQLAcessorio + '    EQD_SERENV = :SERENV   ';
  strSQLAcessorio := strSQLAcessorio + 'WHERE AUTOINCREM = :CODDET ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add(strSQLAcessorio);
    qryUpd.ParamByName('NUMENV').AsString := FObjFatVenda.strNumDoc;
    qryUpd.ParamByName('ESPENV').AsString := FObjFatVenda.strEspDoc;
    qryUpd.ParamByName('EMPENV').AsString := FObjFatVenda.strEmpDoc;
    qryUpd.ParamByName('SERENV').AsString := FObjFatVenda.strSerFsc;
    qryUpd.ParamByName('CODDET').AsString := aAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;

end;

procedure TNotaFiscalContratoLocacao.pGravaDadosEnvioEquipamentoDocumento(const aAutInc: String);
var
  strSQLEquipamento: String;
  qryUpd: TUniQuery;
begin
  If Not Assigned(FObjFatVenda) Then
  Begin
    Exit;
  End;

  strSQLEquipamento := '';
  strSQLEquipamento := strSQLEquipamento + 'UPDATE EQLDET              ';
  strSQLEquipamento := strSQLEquipamento + 'SET EQD_NUMENV = :NUMENV,  ';
  strSQLEquipamento := strSQLEquipamento + '    EQD_ESPENV = :ESPENV,  ';
  strSQLEquipamento := strSQLEquipamento + '    EQD_EMPENV = :EMPENV,  ';
  strSQLEquipamento := strSQLEquipamento + '    EQD_SERENV = :SERENV   ';
  strSQLEquipamento := strSQLEquipamento + 'WHERE AUTOINCREM = :CODDET ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Text := strSQLEquipamento;

    qryUpd.ParamByName('NUMENV').AsString := FObjFatVenda.strNumDoc;
    qryUpd.ParamByName('ESPENV').AsString := FObjFatVenda.strEspDoc;
    qryUpd.ParamByName('EMPENV').AsString := FObjFatVenda.strEmpDoc;
    qryUpd.ParamByName('SERENV').AsString := FObjFatVenda.strSerFsc;
    qryUpd.ParamByName('CODDET').AsString := aAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;

end;

procedure TNotaFiscalContratoLocacao.pGravaDadosRetornoAcessorioDocumento(const aAutInc: String; strNumDoc: String = '';
  strEspDoc: String = ''; strCodEmp: String = ''; strSerie: String = '');
var
  strSQLAcessorio: String;
  qryUpd: TUniQuery;
begin
  If Assigned(FObjFatVenda) Then
  Begin
    If fEmptyStr(strNumDoc)Then
      strNumDoc := FObjFatVenda.strNumDoc;
    If fEmptyStr(strEspDoc)Then
      strEspDoc := FObjFatVenda.strEspDoc;
    If fEmptyStr(strCodEmp)Then
      strCodEmp := FObjFatVenda.strEmpDoc;
    If fEmptyStr(strSerie)Then
      strSerie := FObjFatVenda.strSerFsc;
  End;

  strSQLAcessorio := '';
  strSQLAcessorio := strSQLAcessorio + 'UPDATE ACLDET              ';
  strSQLAcessorio := strSQLAcessorio + 'SET EQD_NUMRET = :NUMRET,  ';
  strSQLAcessorio := strSQLAcessorio + '    EQD_ESPRET = :ESPRET,  ';
  strSQLAcessorio := strSQLAcessorio + '    EQD_EMPRET = :EMPRET,  ';
  strSQLAcessorio := strSQLAcessorio + '    EQD_SERRET = :SERRET   ';
  strSQLAcessorio := strSQLAcessorio + 'WHERE AUTOINCREM = :CODDET ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add(strSQLAcessorio);
    qryUpd.ParamByName('NUMRET').AsString := strNumDoc;
    qryUpd.ParamByName('ESPRET').AsString := strEspDoc;
    qryUpd.ParamByName('EMPRET').AsString := strCodEmp;
    qryUpd.ParamByName('SERRET').AsString := strSerie;
    qryUpd.ParamByName('CODDET').AsString := aAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;

end;

procedure TNotaFiscalContratoLocacao.pGravaDadosRetornoEquipamentoDocumento(const aAutInc: String; strNumDoc: String = '';
  strEspDoc: String = ''; strCodEmp: String = ''; strSerie: String = '');
var
  strSQLEquipamento: String;
  qryUpd: TUniQuery;
begin
  If Assigned(FObjFatVenda) Then
  Begin
    If fEmptyStr(strNumDoc)Then
      strNumDoc := FObjFatVenda.strNumDoc;
    If fEmptyStr(strEspDoc)Then
      strEspDoc := FObjFatVenda.strEspDoc;
    If fEmptyStr(strCodEmp)Then
      strCodEmp := FObjFatVenda.strEmpDoc;
    If fEmptyStr(strSerie)Then
      strSerie := FObjFatVenda.strSerFsc;
  End;

  strSQLEquipamento := '';
  strSQLEquipamento := strSQLEquipamento + 'UPDATE EQLDET              ';
  strSQLEquipamento := strSQLEquipamento + 'SET EQD_NUMRET = :NUMRET,  ';
  strSQLEquipamento := strSQLEquipamento + '    EQD_ESPRET = :ESPRET,  ';
  strSQLEquipamento := strSQLEquipamento + '    EQD_EMPRET = :EMPRET,  ';
  strSQLEquipamento := strSQLEquipamento + '    EQD_SERRET = :SERRET   ';
  strSQLEquipamento := strSQLEquipamento + 'WHERE AUTOINCREM = :CODDET ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Text := strSQLEquipamento;

    qryUpd.ParamByName('NUMRET').AsString := strNumDoc;
    qryUpd.ParamByName('ESPRET').AsString := strEspDoc;
    qryUpd.ParamByName('EMPRET').AsString := strCodEmp;
    qryUpd.ParamByName('SERRET').AsString := strSerie;
    qryUpd.ParamByName('CODDET').AsString := aAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;

end;

procedure TNotaFiscalContratoLocacao.pLimparItens;
begin
  FListaItens.Clear;
end;

function TNotaFiscalContratoLocacao.GetContrato: TContratoLocacaoEquipamentos;
begin
  Result := FContrato;
end;

function TNotaFiscalContratoLocacao.GetLItens: TList<TItemNotaContratoLocacao>;
begin
  Result := FListaItens;
end;

function TNotaFiscalContratoLocacao.GetMsgRetorno: String;
begin
  Result := FSLMensagemRetorno.Text;
end;

function TNotaFiscalContratoLocacao.GetValCtr: TValidarContrato;
begin
  Result := FobjValidaCtr;
end;

procedure TNotaFiscalContratoLocacao.pZeraImpostos;
var
  intCnt: Integer;
Begin
  If Not Assigned(FObjFatVenda) Then
    Exit;
  
  For intCnt := 0 To Length(FObjFatVenda.arrMatItens)-1 Do
  Begin
    FObjFatVenda.pZerarDadosIcmsMatrizItens(false, intCnt);
    FObjFatVenda.pZerarDadosIpiMatrizItens(True, intCnt);
    FObjFatVenda.pZerarDadosStMatrizItens(intCnt);
  End;

  FObjFatVenda.fltBasIcm := 0;
  FObjFatVenda.fltTotIcm := 0;
  FObjFatVenda.fltBasIpi := 0;
  FObjFatVenda.fltTotIpi := 0;
  FObjFatVenda.fltBasRet := 0;
  FObjFatVenda.fltTotRet := 0;
End;

procedure TNotaFiscalContratoLocacao.SetContrato(
  const AValue: TContratoLocacaoEquipamentos);
begin
  FContrato := AValue;
end;

{ TItemNotaContratoLocacao }

constructor TItemNotaContratoLocacao.Create(aNota: TNotaFiscalContratoLocacao);
begin
  FNota := aNota;
  FSLEquipamentoArmazem := TStringList.Create;
end;

destructor TItemNotaContratoLocacao.Destroy;
begin

  FreeAndNil(FSLEquipamentoArmazem);

  inherited;
end;

function TItemNotaContratoLocacao.fRetornaNumLote(
  const strCodIte: String): String;
var
  objCadLot : TCadLot;
begin
  Result := '';

  objCadLot := TCadLot.Create(Nil);
  Try
    If (objCadLot.tplTipLot = tplArmazem) Then
    Begin
      Result := objCadLot.fRetArmazemPrincipalLocacaoDeEquipamento(strCodIte);
      If fEmptyStr(Result) Then
      Begin
        Case FTipoItem Of
          TpPrincipal : FSLEquipamentoArmazem.Add(FItemContrato.Equipamento.Codigo);
          TpAcessorio : FSLEquipamentoArmazem.Add(FItemAcessorioContrato.Acessorio.Codigo);
        End;
      End;
    End;
  Finally
    FreeAndNil(objCadLot);
  End;
end;

procedure TItemNotaContratoLocacao.pCarregarDadosItemNota;
var
  strSQL: String;
  qryDet: TUniQuery;
  PrecoContrato: TPrecoContrato;
  intDecUni: Integer;
  strIteDesAux: String;
  blnAbfIcms: Boolean;
begin
  PrecoContrato :=  TPrecoContrato(fCfgSis('PRECTR', varInteger));
  intDecUni := fCfgSis('DECUNI', VarInteger);
  blnAbfIcms := fCfgSis('TIPABF', VarString, VS_strCodEmp) = '1';

  qryDet := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT                                    ';
    strSQL := strSQL + '  I.ITE_CODITE,                           ';
    strSQL := strSQL + '  I.ITE_CODGRU,                           ';
    strSQL := strSQL + '  I.ITE_DESITE,                           ';
    strSQL := strSQL + '  I.ITE_REFERE,                           ';
    strSQL := strSQL + '  I.ITE_CODFAB,                           ';
    strSQL := strSQL + '  I.ITE_DESFAB,                           ';
    strSQL := strSQL + '  U.UNI_CODUNI,                           ';
    strSQL := strSQL + '  U.UNI_SIGUNI,                           ';
    strSQL := strSQL + '  I.ITE_CODMAR,                           ';
    strSQL := strSQL + '  I.ITE_CODFOR,                           ';
    strSQL := strSQL + '  G.ITE_PRECUS,                           ';
    strSQL := strSQL + '  I.ITE_COMLUB,                           ';
    strSQL := strSQL + '  G.ITE_IPISAI,                           ';
    strSQL := strSQL + '  G.ITE_DESMAX,                           ';
    strSQL := strSQL + '  G.ITE_PREVE1,                           ';
    strSQL := strSQL + '  G.ITE_PREVE2,                           ';
    strSQL := strSQL + '  G.ITE_PREVE3,                           ';
    strSQL := strSQL + '  G.ITE_PREVE4,                           ';
    strSQL := strSQL + '  G.ITE_PREVE5,                           ';
    strSQL := strSQL + '  G.ITE_PREVE6,                           ';
    strSQL := strSQL + '  G.ITE_PREVE7,                           ';
    strSQL := strSQL + '  G.ITE_SALDOS,                           ';
    strSQL := strSQL + '  G.ITE_COMVAR,                           ';
    strSQL := strSQL + '  G.ITE_COMATA,                           ';
    strSQL := strSQL + '  G.ITE_COMDIS,                           ';
    strSQL := strSQL + '  G.ITE_PREULT,                           ';
    strSQL := strSQL + '  G.ITE_IMPULT,                           ';
    strSQL := strSQL + '  G.ITE_PREMED,                           ';
    strSQL := strSQL + '  I.ITE_CLAIPI,                           ';
    strSQL := strSQL + IIF(blnAbfIcms, '  I.ITE_CODABF, ',  'G.ITE_CODABF, ');
    strSQL := strSQL + '  I.ITE_PESOIT,                           ';
    strSQL := strSQL + '  I.ITE_PESLIQ,                           ';
    strSQL := strSQL + '  I.ITE_CODFAB,                           ';
    strSQL := strSQL + '  G.ITE_MARMIN,                           ';
    strSQL := strSQL + '  G.ITE_MARMSG,                           ';
    strSQL := strSQL + '  G.ITE_MARMGE,                           ';
    strSQL := strSQL + '  G.ITE_PRECOM,                           ';
    strSQL := strSQL + '  G.ITE_QTPPRO,                           ';
    strSQL := strSQL + '  I.ITE_OBRCPF,                           ';
    strSQL := strSQL + '  G.ITE_IPIENT,                           ';
    strSQL := strSQL + '  G.ITE_FREENT,                           ';
    strSQL := strSQL + '  I.ITE_IMPDIR,                           ';
    strSQL := strSQL + '  I.ITE_CODBAR,                           ';
    strSQL := strSQL + '  G.ITE_IMPULT,                           ';
    strSQL := strSQL + '  G.ITE_DESF01,                           ';
    strSQL := strSQL + '  G.ITE_DESF02,                           ';
    strSQL := strSQL + '  G.ITE_DESF03,                           ';
    strSQL := strSQL + '  G.ITE_DESF04,                           ';
    strSQL := strSQL + '  G.ITE_DESF05,                           ';
    strSQL := strSQL + '  G.ITE_DESF06                            ';
    strSQL := strSQL + 'FROM                                      ';
    strSQL := strSQL + '  CADITE I                                ';
    strSQL := strSQL + 'INNER JOIN CADUNI U                       ';
    strSQL := strSQL + '  ON U.UNI_CODUNI = I.ITE_CODUNI          ';
    strSQL := strSQL + 'INNER JOIN ITEGER G                       ';
    strSQL := strSQL + '  ON (G.ITE_CODITE = I.ITE_CODITE         ';
    strSQL := strSQL + '  AND G.ITE_CODEMP = :CODEMP)             ';
    strSQL := strSQL + 'WHERE I.ITE_CODITE = :CODITE              ';

    qryDet.Close;
    qryDet.SQL.Text := strSQL;
    qryDet.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDet.ParamByName('CODITE').AsString := FCodigoItem;

    qryDet.Open;

    If Not qryDet.IsEmpty Then
    Begin
      FstrCodIte := qryDet.FieldByName('ITE_CODITE').AsString;
      FstrDescri := qryDet.FieldByName('ITE_DESITE').AsString;
      FstrIteDes := qryDet.FieldByName('ITE_DESITE').AsString;

      strIteDesAux :=IIF((fCfgSis('MONDES', varString) = '1'),
                          FstrDescri +
                          IIF(Not fEmptyStr(qryDet.FieldByName('ITE_REFERE').AsString),' ' + qryDet.FieldByName('ITE_REFERE').AsString, '') +
                          IIF(Not fEmptyStr(qryDet.FieldByName('ITE_CODFAB').AsString),' ' + qryDet.FieldByName('ITE_CODFAB').AsString, ''),
                          //Else
                          IIF(Not fEmptyStr(qryDet.FieldByName('ITE_CODFAB').AsString),qryDet.FieldByName('ITE_CODFAB').AsString + ' ', '') +
                          IIF(Not fEmptyStr(qryDet.FieldByName('ITE_REFERE').AsString),qryDet.FieldByName('ITE_REFERE').AsString + ' ', '') +
                          FstrDescri);

      FstrIteDes := IIF((fCfgSis('IMPREF', varBoolean)), strIteDesAux, FstrIteDes);
      FstrNumLot := fRetornaNumLote(qryDet.FieldByName('ITE_CODITE').AsString);
      FstrCodGru := qryDet.FieldByName('ITE_CODGRU').AsString;
      FstrDesFab := qryDet.FieldByName('ITE_DESFAB').AsString;
      FstrUnidad := qryDet.FieldByName('UNI_CODUNI').AsString;
      FstrCodUni := qryDet.FieldByName('UNI_CODUNI').AsString;
      FstrCodMar := qryDet.FieldByName('ITE_CODMAR').AsString; 
      FstrCodFor := qryDet.FieldByName('ITE_CODFOR').AsString;
      FstrRefere := qryDet.FieldByName('ITE_REFERE').AsString;

      Case PrecoContrato of
        preCompraLiq: Begin
                        FfltTotIte := untfuncoesSimples.fCalculaPrecoCompraLiq(qryDet.FieldByName('ITE_PRECOM').AsFloat,
                                                                               qryDet.FieldByName('ITE_DESF01').AsFloat,
                                                                               qryDet.FieldByName('ITE_DESF02').AsFloat,
                                                                               qryDet.FieldByName('ITE_DESF03').AsFloat,
                                                                               qryDet.FieldByName('ITE_DESF04').AsFloat,
                                                                               qryDet.FieldByName('ITE_DESF05').AsFloat,
                                                                               qryDet.FieldByName('ITE_DESF06').AsFloat,
                                                                               intDecUni);

                        FfltUniOri := FfltTotIte;
                        FfltUniVis := FfltTotIte;
                        FfltUniTar := FfltTotIte;
                        FfltUniDig := FfltTotIte;
                        FfltTotIte := FfltTotIte * fRetQuantidadeIteItemEnvRet;
                      End;
        preCusto:     Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PRECUS').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PRECUS').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PRECUS').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PRECUS').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PRECUS').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preMedio:     Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PREMED').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PREMED').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PREMED').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PREMED').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PREMED').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preTabela1:   Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PREVE1').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PREVE1').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PREVE1').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PREVE1').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PREVE1').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preTabela2:   Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PREVE2').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PREVE2').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PREVE2').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PREVE2').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PREVE2').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preTabela3:   Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PREVE3').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PREVE3').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PREVE3').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PREVE3').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PREVE3').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preTabela4:   Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PREVE4').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PREVE4').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PREVE4').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PREVE4').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PREVE4').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preTabela5:   Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PREVE5').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PREVE5').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PREVE5').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PREVE5').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PREVE5').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preTabela6:   Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PREVE6').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PREVE6').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PREVE6').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PREVE6').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PREVE6').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preTabela7:   Begin
                        FfltUniOri := qryDet.FieldByName('ITE_PREVE7').AsFloat;
                        FfltUniVis := qryDet.FieldByName('ITE_PREVE7').AsFloat;
                        FfltUniTar := qryDet.FieldByName('ITE_PREVE7').AsFloat;
                        FfltUniDig := qryDet.FieldByName('ITE_PREVE7').AsFloat;
                        FfltTotIte := qryDet.FieldByName('ITE_PREVE7').AsFloat * fRetQuantidadeIteItemEnvRet;
                      End;
        preCaucao :   Begin
                        Case FTipoItem Of
                          TpPrincipal : Begin
                                          FfltUniOri := FItemContrato.Equipamento.ValorCaucao;
                                          FfltUniVis := FItemContrato.Equipamento.ValorCaucao;
                                          FfltUniTar := FItemContrato.Equipamento.ValorCaucao;
                                          FfltUniDig := FItemContrato.Equipamento.ValorCaucao;
                                          FfltTotIte := FItemContrato.Equipamento.ValorCaucao * FItemContrato.Quantidade;
                                        End;
                          TpAcessorio : Begin
                                          FfltUniOri := FItemAcessorioContrato.Acessorio.ValorCaucao;
                                          FfltUniVis := FItemAcessorioContrato.Acessorio.ValorCaucao;
                                          FfltUniTar := FItemAcessorioContrato.Acessorio.ValorCaucao;
                                          FfltUniDig := FItemAcessorioContrato.Acessorio.ValorCaucao;
                                          FfltTotIte := (FItemAcessorioContrato.Acessorio.ValorCaucao * FItemContrato.Quantidade) * FItemAcessorioContrato.ItemEquipamento.Quantidade;
                                        End;
                        End;
                      End;
      End;

      FfltPreCus := qryDet.FieldByName('ITE_PRECUS').AsFloat;
      FfltTotCus := qryDet.FieldByName('ITE_PRECUS').AsFloat;
      FstrComLub := qryDet.FieldByName('ITE_COMLUB').AsString;
      FfltIpiSai := qryDet.FieldByName('ITE_IPISAI').AsFloat;
      FfltDesMax := qryDet.FieldByName('ITE_DESMAX').AsFloat;
      FfltPreVe1 := qryDet.FieldByName('ITE_PREVE1').AsFloat;
      FfltPreVe2 := qryDet.FieldByName('ITE_PREVE2').AsFloat;
      FfltPreVe3 := qryDet.FieldByName('ITE_PREVE3').AsFloat;
      FfltPreVe4 := qryDet.FieldByName('ITE_PREVE4').AsFloat;
      FfltPreVe5 := qryDet.FieldByName('ITE_PREVE5').AsFloat;
      FfltPreVe6 := qryDet.FieldByName('ITE_PREVE6').AsFloat;
      FfltPreVe7 := qryDet.FieldByName('ITE_PREVE7').AsFloat;
      FfltSaldos := qryDet.FieldByName('ITE_SALDOS').AsFloat;
      FfltComVar := qryDet.FieldByName('ITE_COMVAR').AsFloat;
      FfltComAta := qryDet.FieldByName('ITE_COMATA').AsFloat;
      FfltComDis := qryDet.FieldByName('ITE_COMDIS').AsFloat;
      FfltTotUlt := qryDet.FieldByName('ITE_PREULT').AsFloat;
      FfltImpUlt := qryDet.FieldByName('ITE_IMPULT').AsFloat;
      FfltPreUlt := qryDet.FieldByName('ITE_PREULT').AsFloat;
      FfltPreMed := qryDet.FieldByName('ITE_PREMED').AsFloat;
      FstrClaIpi := qryDet.FieldByName('ITE_CLAIPI').AsString;
      FstrCodAbf := qryDet.FieldByName('ITE_CODABF').AsString;
      FfltPesoIt := qryDet.FieldByName('ITE_PESOIT').AsFloat;
      FfltPesLiq := qryDet.FieldByName('ITE_PESLIQ').AsFloat;
      FstrCodFab := qryDet.FieldByName('ITE_CODFAB').AsString;
      FfltMarMin := qryDet.FieldByName('ITE_MARMIN').AsFloat;
      FfltMarMSG := qryDet.FieldByName('ITE_MARMSG').AsFloat;
      FfltMarMGe := qryDet.FieldByName('ITE_MARMGE').AsFloat;
      FfltPreCom := qryDet.FieldByName('ITE_PRECOM').AsFloat;
      FfltQtdPon := qryDet.FieldByName('ITE_QTPPRO').AsFloat;
      FstrObrCpf := qryDet.FieldByName('ITE_OBRCPF').AsString;
      FstrSigUni := qryDet.FieldByName('UNI_SIGUNI').AsString;
      FfltIpiEnt := qryDet.FieldByName('ITE_IPIENT').AsFloat;
      FfltFreEnt := qryDet.FieldByName('ITE_FREENT').AsFloat;
      FstrImpDir := qryDet.FieldByName('ITE_IMPDIR').AsString;
      FstrCodBar := qryDet.FieldByName('ITE_CODBAR').AsString;
      FfltCusIte := qryDet.FieldByName('ITE_PRECUS').AsFloat;
      FfltTotImp := qryDet.FieldByName('ITE_IMPULT').AsFloat;
      FstrNumSer := fRetNumSerieItemEnvRet;
      FEqdDescri := fRetDescricaoItemEnvRet;
      FEqdCodigo := fRetCodigoItemEnvRet;
    End;
    
  Finally
    FreeAndNil(qryDet);
  End;

end;

function TItemNotaContratoLocacao.fRetNumSerieItemEnvRet(): String;
Begin
  Result := EmptyStr;
  Case FTipoItem Of
    tpPrincipal: Begin
                   If Assigned(FItemContrato) Then
                     Result := FItemContrato.Equipamento.NumSerie
                   Else
                     Result := '';
                 End;
    Else
      Result := '';
  End;
End;

function TItemNotaContratoLocacao.fRetCodigoItemEnvRet(): String;
Begin
  Result := EmptyStr;
  Case FTipoItem Of
    tpPrincipal: Begin
                   If Assigned(FItemContrato) Then
                     Result := FItemContrato.Equipamento.Codigo
                   Else
                     Result := '';
                 End;
    tpAcessorio: Begin
                   If Assigned(FItemAcessorioContrato) Then
                     Result := FItemAcessorioContrato.Acessorio.Codigo
                   Else
                     Result := '';
                 End;
    Else
      Result := '';
  End;
End;

function TItemNotaContratoLocacao.fRetDescricaoItemEnvRet(): String;
Begin
  Result := EmptyStr;
  Case FTipoItem Of
    tpPrincipal: Begin
                   If Assigned(FItemContrato) Then
                     Result := FItemContrato.Equipamento.Descricao
                   Else
                     Result := '';

                 End;
    tpAcessorio: Begin
                   If Assigned(FItemAcessorioContrato) Then
                     Result := FItemAcessorioContrato.Acessorio.Descricao
                   Else
                     Result := '';
                 End;
    Else
      Result := '';
  End;
End;

function TItemNotaContratoLocacao.fRetQuantidadeIteItemEnvRet(): Double;
Begin
  Case FTipoItem Of
    tpPrincipal: If Assigned(FItemContrato) Then
                   Result := FItemContrato.Quantidade
                 Else
                   Result := 1;

    tpAcessorio: If Assigned(FItemAcessorioContrato) Then
                   Result := FItemAcessorioContrato.Quantidade * FItemAcessorioContrato.ItemEquipamento.Quantidade
                 Else
                   Result := 1;
    Else
      Result := 1;
  End;
End;

{ TTrocaContrato }

function TTrocaContrato.ConfirmaAlteracaoCobranca: Boolean;
var
  LSQL: String;
  LQryUpd: TUniQuery;
  LIntCnt: Integer;
begin
  Result := False;

  LSQL := '';
  LSQL := LSQL + 'UPDATE TRCDET            ';
  LSQL := LSQL + 'SET TRC_VLRCOB = :TRC_VLRCOB,  ';
  LSQL := LSQL + '    TRC_DTACOB = :TRC_DTACOB,  ';
  LSQL := LSQL + '    TRC_HORCOB = :TRC_HORCOB,  ';
  LSQL := LSQL + '    TRC_CNFENT = :TRC_CNFENT,  ';
  LSQL := LSQL + '    TRC_SUPENT = :TRC_SUPENT   ';
  LSQL := LSQL + 'WHERE TRC_SEQTRC = :TRC_SEQTRC ';
  LSQL := LSQL + '  AND AUTOINCREM = :AUTOINCREM ';

  LQryUpd := fCriaQuery();
  Try
    LQryUpd.SQL.Clear;
    LQryUpd.SQL.Add(LSQL);

    For LIntCnt:= 0 To FListaItens.Count-1 Do
    Begin
      If Not FListaItens[LIntCnt].ValorCobrancaAlterado Then
        Continue;

      If FListaItens[LIntCnt].TipoItem =  tpPrincipal Then
      Begin
        LQryUpd.ParamByName('TRC_VLRCOB').AsFloat  := FListaItens[LIntCnt].FItemAnteriorContrato.ValorCobranca;
        LQryUpd.ParamByName('TRC_CNFENT').AsString := FListaItens[LIntCnt].FItemAnteriorContrato.CodConferenteEntrada;
        LQryUpd.ParamByName('TRC_SUPENT').AsString := FListaItens[LIntCnt].FItemAnteriorContrato.CodSupervisorEntrada;
      End;

      If FListaItens[LIntCnt].TipoItem =  tpAcessorio Then
      Begin
        LQryUpd.ParamByName('TRC_VLRCOB').AsFloat  := FListaItens[LIntCnt].FAcessorioAnteriorContrato.ValorCobranca;
        LQryUpd.ParamByName('TRC_CNFENT').AsString := FListaItens[LIntCnt].FAcessorioAnteriorContrato.CodConferenteEntrada;
        LQryUpd.ParamByName('TRC_SUPENT').AsString := FListaItens[LIntCnt].FAcessorioAnteriorContrato.CodSupervisorEntrada;
      End;

      LQryUpd.ParamByName('TRC_DTACOB').AsDateTime := fNow();
      LQryUpd.ParamByName('TRC_HORCOB').AsDateTime := fNow();
      LQryUpd.ParamByName('TRC_SEQTRC').AsString := FAutInc;
      LQryUpd.ParamByName('AUTOINCREM').AsString := FListaItens[LIntCnt].AutInc;

      LQryUpd.ExecSQL;

      Result := True;
    End;

    If Result Then
      FMensagemRetorno := 'Processo concluído com sucesso!'
    Else
      FMensagemRetorno := 'Não foi possível efeturar a atualização do valor da troca. Entre em contato com a Citel!';
  Finally
    FreeAndNil(LQryUpd);
  End;
end;

constructor TTrocaContrato.Create(
  Owner: TContratoLocacaoEquipamentos);
begin
  If Assigned(Owner) Then
    FContrato := Owner
  Else
    FContrato := TContratoLocacaoEquipamentos.Create;


  FqryInsert := fCriaQuery;

  FListaItens := TList<TItemTrocaContrato>.Create;
  FListaEquipamentosTrocados := TList<TItemContratoLocacaoEquipamentos>.Create;
  FListaAcessoriosTrocados := TList<TAcessorioContratoLocacaoEquipamentos>.Create;
  FValida := TValidarContrato.Create(FContrato);
end;

destructor TTrocaContrato.Destroy;
begin
  FreeAndNil(FqryInsert);
  FreeAndNil(FListaItens);
  FreeAndNil(FListaEquipamentosTrocados);
  FreeAndNil(FListaAcessoriosTrocados);
  FreeAndNil(FValida);

  inherited;
end;

function TTrocaContrato.fAddAcessorio: TItemTrocaContrato;
var
  intCont: Integer;
begin
  FListaItens.add(TItemTrocaContrato.Create(Self));
  intCont := FListaItens.Count -1;
  FListaItens[intCont].TipoItem := tpAcessorio;
  Result  := FListaItens[intCont];
end;

function TTrocaContrato.fAddItem: TItemTrocaContrato;
var
  intCont: Integer;
begin
  FListaItens.add(TItemTrocaContrato.Create(Self));
  intCont := FListaItens.Count -1;
  FListaItens[intCont].TipoItem := tpPrincipal;
  Result  := FListaItens[intCont];
end;

function TTrocaContrato.fGravarInspecaoEntrada: Boolean;
var
  intCnt: Integer;
Begin
  Try
    For intCnt := 0 to FListaItens.Count-1 do
    Begin
      If FListaItens[intCnt].TipoItem = tpPrincipal Then
        FListaItens[intCnt].fGravarInspecaoEntradaEquipamento
      Else
        FListaItens[intCnt].fGravarInspecaoEntradaAcessorio;
    End;
    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TTrocaContrato.fGravarInspecaoEntrada]');
      Result := False;
    End;
  End;
End;

function TTrocaContrato.fConfirmarTroca: Boolean;
var
  blnImprimir: Boolean;
begin
  Result := False;
  blnImprimir := False;
  If fValidarTrocasRealizadas Then
  Begin
    If fCfgSis('ISPCMP', VarBoolean) Then
    Begin
      If fGravarInspecaoEntrada Then
      Begin
        blnImprimir := True;
        If (fMensagem('CONFIRMAÇÃO!', 'Inspeção realizada com sucesso. Deseja imprimir o comprovante?', ['&Sim', '&Não'], 1) = 2) Then
            blnImprimir := False;

        If blnImprimir Then
           fImprimeComprovanteIspEnt;
      End;
    End;

    If fGravarTroca Then
    Begin
      Result := True;
      FblnTrocaRealizada := True;
      If blnImprimir Then
        fImprimeComprovanteIspSai;
    End;
  End;
end;

function TTrocaContrato.fGravarTroca: Boolean;
var
  intCnt: Integer;
begin
  FqryInsert.DisableControls;
  Try
    fStartTransaction;
    Try
      FAutInc := fRetAutoIncrem('TRCEQL', VS_strCodEmp);
      FCodigo := fAtualizaProCod('TRCEQL', 'TRC_CODIGO');
      FDtaTrc := Today;
      FHraTrc := fNow();

      FqryInsert.SQL.Clear;
      FqryInsert.SQL.Add('INSERT INTO TRCEQL(AUTOINCREM, TRC_SEQCON, TRC_CODIGO, TRC_DTATRC, TRC_HRATRC, TRC_CODOPE)');
      FqryInsert.SQL.Add('VALUES(:AUTOINCREM, :TRC_SEQCON, :TRC_CODIGO, :TRC_DTATRC, :TRC_HRATRC, :TRC_CODOPE)');

      FqryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
      FqryInsert.ParamByName('TRC_SEQCON').AsString := FContrato.AutInc;
      FqryInsert.ParamByName('TRC_CODIGO').AsString := FCodigo;
      FqryInsert.ParamByName('TRC_DTATRC').AsDate   := FDtaTrc;
      FqryInsert.ParamByName('TRC_HRATRC').AsDateTime := FHraTrc;
      FqryInsert.ParamByName('TRC_CODOPE').AsString := strLoginUsuarioLogado;

      FqryInsert.ExecSQL;

      For intCnt := 0 to FListaItens.Count-1 do
      Begin
        If FListaItens[intCnt].TipoItem = tpPrincipal Then
          FListaItens[intCnt].fGravarTrocaItem
        Else
          FListaItens[intCnt].fGravarTrocaAcessorioItem;
      End;

      Result := True;

      If Result Then
        fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TTrocaContrato.fEmiteNotaSimplesRemessa]');
        Result := False;
      End;
    End;

  Finally
    FqryInsert.EnableControls;
  End;
end;

function TTrocaContrato.fRemoverAcessorioTroca(const aCodEql, aCodAcl: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;

  For intCnt := 0 to FListaItens.Count-1 do
  Begin
    If FListaItens[intCnt].TipoItem = tpPrincipal Then
      continue;

    If FListaItens[intCnt].FAcessorioAnteriorContrato.CodEquipamento = aCodEql Then
    Begin
      If FListaItens[intCnt].FAcessorioAnteriorContrato.Acessorio.Codigo = aCodAcl  Then
      Begin
        FListaItens.Delete(intCnt);
        Result := True;
        Break;
      End;
    End;
  End;
end;

function TTrocaContrato.fRemoverItemTroca(const aCodEql: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;

  For intCnt := 0 to FListaItens.Count-1 do
  Begin
    If FListaItens[intCnt].TipoItem = tpAcessorio Then
      continue;

    If FListaItens[intCnt].FItemAnteriorContrato.Equipamento.Codigo = aCodEql  Then
    Begin
      FListaItens.Delete(intCnt);
      Result := True;
      Break;
    End;
  End;
end;

function TTrocaContrato.fRetornaAcessorioTroca(
  const aCodEql, aCodAcl, aCodIte: String): TItemTrocaContrato;
var
  intCnt: Integer;
begin
  Result := nil;

  For intCnt := 0 to FListaItens.Count-1 do
  Begin
    If FListaItens[intCnt].TipoItem = tpPrincipal Then
      continue;

    If FListaItens[intCnt].FAcessorioAnteriorContrato.CodEquipamento = aCodEql Then
    Begin

      If FListaItens[intCnt].FAcessorioAnteriorContrato.Acessorio.Codigo = aCodAcl  Then
      Begin
        Result := FListaItens[intCnt];
        Break;
      End;

      If FListaItens[intCnt].FAcessorioAnteriorContrato.Acessorio.CodigoItem = aCodIte  Then
      Begin
        Result := FListaItens[intCnt];
        Break;
      End;
    End;

  End;
end;

function TTrocaContrato.fRetornaItemTroca(
  const aCodEql: String): TItemTrocaContrato;
var
  intCnt: Integer;
begin
  Result := nil;
  For intCnt := 0 to FListaItens.Count-1 do
  Begin
    If FListaItens[intCnt].TipoItem = tpAcessorio Then
      continue;

    If FListaItens[intCnt].FItemContrato.Equipamento.Codigo = aCodEql  Then
    Begin
      Result := FListaItens[intCnt];
      Break;
    End;
  End;
end;

function TTrocaContrato.fRetornaItemTrocaDo(
  const aCodEql: String; ATipoItem: TTpEquipamentoLocacao; ACodAcl: String = ''): TItemTrocaContrato;
var
  intCnt: Integer;
begin
  Result := nil;
  For intCnt := 0 to FListaItens.Count-1 do
  Begin
    If (ATipoItem = tpPrincipal) And
       (FListaItens[intCnt].TipoItem = tpPrincipal) And
       (FListaItens[intCnt].FItemAnteriorContrato.Equipamento.Codigo = aCodEql)  Then
    Begin
      Result := FListaItens[intCnt];
      Break;
    End;

    If (ATipoItem = tpAcessorio) And
       (FListaItens[intCnt].TipoItem = tpAcessorio) And
       (FListaItens[intCnt].FAcessorioAnteriorContrato.CodEquipamento = aCodEql) And
       (FListaItens[intCnt].FAcessorioAnteriorContrato.Acessorio.Codigo = aCodAcl) Then
    Begin
      Result := FListaItens[intCnt];
      Break;
    End;
  End;
end;

function TTrocaContrato.fValidarAcessoriosEntradaSaidaIguais(const strCodIteAnt,
  strCodEqlAnt: String; objItem: TEquipamentoLocacaoPrincipal): Boolean;
var
  objItemCtrAnt: TItemContratoLocacaoEquipamentos;
  intCnt,
  intCont: Integer;
  blnItemEncontrado: Boolean;
  intEncontrados: Integer;
begin
  blnItemEncontrado := False;
  intEncontrados := 0;

  objItemCtrAnt := FContrato.fRetornaItemContrato(strCodEqlAnt);
  If Not Assigned(objItemCtrAnt)  Then
    Exit(False);

  For intCnt := 0 to objItemCtrAnt.Equipamento.Acessorios.Count-1  Do
  Begin
    For intCont := 0 to objItem.Acessorios.Count-1  Do
    Begin
      blnItemEncontrado := objItemCtrAnt.Equipamento.Acessorios[intCnt].Acessorio.Codigo = objItem.Acessorios[intCont].Acessorio.Codigo;
      If blnItemEncontrado Then
        Break;
    End;

    If blnItemEncontrado Then
    Begin
      Inc(intEncontrados);
    End;
  End;

  Result := (intEncontrados = objItemCtrAnt.Equipamento.Acessorios.Count);
end;

function TTrocaContrato.fValidarEquipamentoTrocaDiferente(const strCodIteAnt,
  strCodEqlAnt: String; objItem: TEquipamentoLocacaoPrincipal): Boolean;
var
  objLiberacao: TLiberacao;
  blnVlrLocDif: Boolean;
  objItemCtrAnt: TItemContratoLocacaoEquipamentos;
begin
  Result := (objItem.CodigoItem = strCodIteAnt);
  blnVlrLocDif := False;
  If Not Result Then
  Begin
    objItemCtrAnt := FContrato.fRetornaItemContrato(strCodEqlAnt);

    If Not Assigned(objItemCtrAnt)  Then
      Exit;

    Case objItemCtrAnt.TipoCalculoLocacao Of
      tpDiaria: blnVlrLocDif := objItemCtrAnt.ValorLocacaoContratado = objItem.ValorLocacaoDiaria;
      tpMensal: blnVlrLocDif := objItemCtrAnt.ValorLocacaoContratado = objItem.ValorLocacaoMensal;
      tpHoras : blnVlrLocDif := objItemCtrAnt.ValorLocacaoContratado = objItem.ValorLocacao;
    End;

    objLiberacao := TLiberacao.Create;
    Try
      Try
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddSeparador(99);
        objLiberacao.objMsgLibera.pAddTexto('LOCAÇÃO DE EQUIPAMENTOS - TROCA DE EQUIPAMENTOS', alEsquerda, teAmbos, '', 99);
        objLiberacao.objMsgLibera.pAddSeparador(99);
        objLiberacao.objMsgLibera.pAddTexto('Contrato: ' + FContrato.NroContrato , alEsquerda, teAmbos, '', 99);
        objLiberacao.objMsgLibera.pAddTexto('Cliente : ' + FContrato.CodCliente + ' - ' + FContrato.NomCliente, alEsquerda, teAmbos, '', 99);
        objLiberacao.objMsgLibera.pAddTexto('Cpf/Cnpj: ' + FContrato.Cliente.CpfCnpj, alEsquerda, teAmbos, '', 99);
        objLiberacao.objMsgLibera.pAddSeparador(99);
        objLiberacao.objMsgLibera.pAddTexto('Vlr.Contrato : R$ ' + FormatFloat('#,##0.00', FContrato.ValorTotalContrato), alEsquerda, teAmbos, '', 99);
        objLiberacao.objMsgLibera.pAddSeparador(99);
        objLiberacao.objMsgLibera.pAddTexto('Equipamento Atual: '+ objItemCtrAnt.Equipamento.Codigo +  ' - ' + objItemCtrAnt.Equipamento.Descricao, alEsquerda, teAmbos, '', 99);
        objLiberacao.objMsgLibera.pAddTexto('Equipamento Novo : '+ objItem.Codigo +  ' - ' + objItem.Descricao, alEsquerda, teAmbos, '', 99);
        objLiberacao.objMsgLibera.pAddSeparador(99);
        objLiberacao.objMsgLibera.pAddTexto('Considere as informações da locação antes de prosseguir:', alEsquerda, teAmbos, '', 99);
        objLiberacao.objMsgLibera.pAddSeparador(99);

        If blnVlrLocDif Then
          objLiberacao.objMsgLibera.pAddTexto('Os valores de locação dos equipamentos são diferentes.', alEsquerda, teAmbos, '', 99);
        If objItemCtrAnt.blnValorLocacaoAlteradoManualmente Then
          objLiberacao.objMsgLibera.pAddTexto('O valor de locação do equimento inserido originalmente no contrato foi alterado manualmente.', alEsquerda, teAmbos, '', 99);
        If (objItemCtrAnt.Equipamento.Diarias.Count > 1 ) And (objItem.Diarias.Count <= 0) Then
          objLiberacao.objMsgLibera.pAddTexto('O valor de locação do equimento inserido originalmente no contrato POSSUI NEGOCIAÇÃO.', alEsquerda, teAmbos, '', 99);
        If (objItemCtrAnt.Equipamento.Diarias.Count <= 0 ) And (objItem.Diarias.Count > 1) Then
          objLiberacao.objMsgLibera.pAddTexto('O valor de locação do equimento inserido originalmente no contrato NÃO possui negociação.', alEsquerda, teAmbos, '', 99);
        If Not fValidarAcessoriosEntradaSaidaIguais(strCodIteAnt, strCodEqlAnt,objItem) Then
          objLiberacao.objMsgLibera.pAddTexto('Os acessórios dos equipamentos são diferentes.', alEsquerda, teAmbos, '', 99);
        If Not fValidarProdutoAcessorioEntradaSaidaIguais(strCodIteAnt, strCodEqlAnt,objItem) Then
          objLiberacao.objMsgLibera.pAddTexto('Os produtos dos acessórios dos equipamentos são diferentes.', alEsquerda, teAmbos, '', 99);
        If Not fValidarQuantidadeAcessoriosEntradaSaidaIguais(strCodIteAnt, strCodEqlAnt,objItem) Then
          objLiberacao.objMsgLibera.pAddTexto('Os acessórios dos equipamentos possuem quantidades diferentes.', alEsquerda, teAmbos, '', 99);
        If fCfgSis('CPGCTR', VarBoolean) Then
          objLiberacao.objMsgLibera.pAddTexto('O pedido de adiantamento será cancelado e um com o novo item será gerado.', alEsquerda, teAmbos, '', 99);

        objLiberacao.strDirAce := 'TRCDIF';
        objLiberacao.strMsgSen := 'Permitir trocar equipamento de contrato com código de produto interno diferente do contratado.';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, 'TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoEntradaAcessorio');
        End;
      End;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;
end;

function TTrocaContrato.fValidarProdutoAcessorioEntradaSaidaIguais(
  const strCodIteAnt, strCodEqlAnt: String;
  objItem: TEquipamentoLocacaoPrincipal): Boolean;
var
  objItemCtrAnt: TItemContratoLocacaoEquipamentos;
  intCnt,
  intCont: Integer;
  blnItemEncontrado: Boolean;
  intEncontrados: Integer;
begin
  blnItemEncontrado := False;
  intEncontrados := 0;

  objItemCtrAnt := FContrato.fRetornaItemContrato(strCodEqlAnt);
  If Not Assigned(objItemCtrAnt)  Then
    Exit(False);

  For intCnt := 0 to objItemCtrAnt.Equipamento.Acessorios.Count-1  Do
  Begin
    For intCont := 0 to objItem.Acessorios.Count-1  Do
    Begin
      blnItemEncontrado := objItemCtrAnt.Equipamento.Acessorios[intCnt].Acessorio.CodigoItem = objItem.Acessorios[intCont].Acessorio.CodigoItem;
      If blnItemEncontrado Then
        Break;
    End;

    If blnItemEncontrado Then
    Begin
      Inc(intEncontrados);
    End;
  End;

  Result := (intEncontrados = objItemCtrAnt.Equipamento.Acessorios.Count);
end;

function TTrocaContrato.fValidarQuantidadeAcessoriosEntradaSaidaIguais(
  const strCodIteAnt, strCodEqlAnt: String;
  objItem: TEquipamentoLocacaoPrincipal): Boolean;
var
  objItemCtrAnt: TItemContratoLocacaoEquipamentos;
  intCnt,
  intCont: Integer;
  blnItemEncontrado: Boolean;
  intEncontrados: Integer;
begin
  blnItemEncontrado := False;
  intEncontrados := 0;

  objItemCtrAnt := FContrato.fRetornaItemContrato(strCodEqlAnt);
  If Not Assigned(objItemCtrAnt)  Then
    Exit(False);

  For intCnt := 0 to objItemCtrAnt.Equipamento.Acessorios.Count-1  Do
  Begin
    For intCont := 0 to objItem.Acessorios.Count-1  Do
    Begin
      blnItemEncontrado := objItemCtrAnt.Equipamento.Acessorios[intCnt].Quantidade = objItem.Acessorios[intCont].Quantidade;
      If blnItemEncontrado Then
        Break;
    End;

    If blnItemEncontrado Then
    Begin
      Inc(intEncontrados);
    End;
  End;

  Result := (intEncontrados = objItemCtrAnt.Equipamento.Acessorios.Count);
end;

function TTrocaContrato.fValidarTrocasAcessorios(acessorio, acessorioanterior: TAcessorioContratoLocacaoEquipamentos): Boolean;
begin
  Result := True;

  If Not Assigned(acessorioanterior) Then
  Begin
    FMensagemRetorno := 'Inspeção de entrada do acessório não realizada. ';
    Result := False;
    Exit;
  End;

  If Not acessorioanterior.InspecaoEntradaRealizada Then
  Begin
    FMensagemRetorno := 'Inspeção de entrada do acessório ' + acessorioanterior.Acessorio.Codigo + ' - ' + acessorioanterior.Acessorio.Descricao + ' não foi realizada.';
    Result := False;
    Exit;
  End;

  If Not Assigned(acessorio) Then
  Begin
    FMensagemRetorno := 'Inspeção de saída do acessório de troca do equipamento não realizada.';
    Result := False;
    Exit;
  End;

  If Not acessorio.InspecaoSaidaRealizada Then
  Begin
    FMensagemRetorno := 'Inspeção de saída do acessório de troca do equipamento ' + acessorio.Acessorio.Codigo + ' - ' + acessorio.Acessorio.Descricao + ' não foi realizada.';
    Result := False;
    Exit;
  End;
end;

function TTrocaContrato.fValidarTrocasEquipamentos(aItem, aItemAnterior: TItemContratoLocacaoEquipamentos): Boolean;
begin
  Result := True;

  If Not Assigned(aItemAnterior) Then
  Begin
    FMensagemRetorno := 'Inspeção de entrada do equipamento não realizada.';
    Result := False;
    Exit;
  End;

  If Not aItemAnterior.InspecaoEntradaRealizada Then
  Begin
    FMensagemRetorno := 'Inspeção de entrada do equipamento ' + aItemAnterior.Equipamento.Codigo + ' - ' + aItemAnterior.Equipamento.Descricao + ' não foi realizada.';
    Result := False;
    Exit;
  End;

  If Not Assigned(aItem) Then
  Begin
    FMensagemRetorno := 'Inspeção de saída do equipamento de troca do equipamento não realizada. ';
    Result := False;
    Exit;
  End;

  If Not aItem.InspecaoSaidaRealizada Then
  Begin
    FMensagemRetorno := 'Inspeção de saída do equipamento de troca do equipamento ' + aItem.Equipamento.Codigo + ' - ' + aItem.Equipamento.Descricao + ' não foi realizada.';
    Result := False;
    Exit;
  End;
end;

function TTrocaContrato.fValidarTrocasRealizadas: Boolean;
var
  intCnt: Integer;
begin
  Result := True;

  If FListaItens.Count <= 0 Then
  Begin
    FMensagemRetorno := 'Nenhum item adicionado para realização da troca.';
    Result := False;
    Exit;
  End;

  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCnt].TipoItem = tpPrincipal Then
    Begin
      Result := fValidarTrocasEquipamentos(FListaItens[intCnt].FItemContrato, FListaItens[intCnt].FItemAnteriorContrato);
      If Not Result Then
        Break;
    End
    Else
    Begin
      Result := fValidarTrocasAcessorios(FListaItens[intCnt].FAcessorioContrato, FListaItens[intCnt].FAcessorioAnteriorContrato);
      If Not Result Then
        Break;
    End;
  End;
end;

function TTrocaContrato.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TTrocaContrato.GetBlnTrc: Boolean;
begin
  Result := FblnTrocaRealizada;
end;

function TTrocaContrato.GetCodOpe: String;
begin
  Result := FCodOpe;
end;

function TTrocaContrato.GetCodTrc: String;
begin
  Result := FCodigo;
end;

function TTrocaContrato.GetContrato: TContratoLocacaoEquipamentos;
begin
  Result := FContrato;
end;

function TTrocaContrato.GetDtaTrc: TDateTime;
begin
  Result := FDtaTrc;
end;

function TTrocaContrato.GetItens: TList<TItemTrocaContrato>;
begin
  Result := FListaItens;
end;

function TTrocaContrato.GetLstAcl: TList<TAcessorioContratoLocacaoEquipamentos>;
begin
  Result := FListaAcessoriosTrocados;
end;

function TTrocaContrato.GetLstEql: TList<TItemContratoLocacaoEquipamentos>;
begin
  Result := FListaEquipamentosTrocados;
end;

function TTrocaContrato.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TTrocaContrato.GetNomAdt: String;
begin
  Result := FNomeArquivoAditivo;
end;

function TTrocaContrato.GetNomOpe: String;
begin
  Result := FNomOpe;
end;

function TTrocaContrato.GetTotCob: Double;
begin
  Result := FVlrTotCob;
end;

procedure TTrocaContrato.pCalcularTotais;
var
  intCnt: Integer;
begin
  FVlrTotCob := 0;

  For intCnt := 0 to FListaItens.Count-1 do
  Begin
    If FListaItens[intCnt].TipoItem = tpPrincipal Then
      FVlrTotCob := FVlrTotCob + FListaItens[intCnt].FItemAnteriorContrato.ValorCobranca
    Else
      FVlrTotCob := FVlrTotCob + FListaItens[intCnt].FAcessorioAnteriorContrato.ValorCobranca;
  End;
end;

procedure TTrocaContrato.pCarregarItensTroca;
var
  qry: TUniQuery;
  strSelect: String;
  itemTroca: TItemTrocaContrato;
  itemContrato: TItemContratoLocacaoEquipamentos;
  acessorioContrato: TAcessorioContratoLocacaoEquipamentos;
  itemAnteriorContrato: TItemContratoLocacaoEquipamentos;
  acessorioAnteriorContrato: TAcessorioContratoLocacaoEquipamentos;
Begin
  strSelect := 'SELECT TRCDET.*,                       ' +
               '       OPEENT.OPE_NOMOPE AS NOMCNFENT, ' +
               '       OPESAI.OPE_NOMOPE AS NOMCNFSAI, ' +
               '       SUPENT.OPE_NOMOPE AS NOMSUPENT, ' +
               '       SUPSAI.OPE_NOMOPE AS NOMSUPSAI  ' +
               '  FROM TRCDET ' +
               '  LEFT JOIN CADOPE OPEENT ON (TRC_CNFENT = OPEENT.OPE_CODOPE) ' +
               '  LEFT JOIN CADOPE OPESAI ON (TRC_CNFSAI = OPESAI.OPE_CODOPE) ' +
               '  LEFT JOIN CADOPE SUPENT ON (TRC_SUPENT = SUPENT.OPE_CODOPE) ' +
               '  LEFT JOIN CADOPE SUPSAI ON (TRC_SUPSAI = SUPSAI.OPE_CODOPE) ' +
               '  WHERE TRC_SEQTRC = :AUTINC';

  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add(strSelect);
    qry.ParamByName('AUTINC').AsString := FAutInc;
    qry.Open;
    While Not qry.EOF Do
    Begin
      itemTroca := fAddItem;
      itemTroca.FAutInc := qry.FieldByName('AUTOINCREM').AsString;
      If Not fEmptyStr(qry.FieldByName('TRC_CODEQL').AsString) Then
      Begin
        itemTroca.TipoItem := tpPrincipal;
        itemAnteriorContrato := TItemContratoLocacaoEquipamentos.Create(FContrato);
        itemAnteriorContrato.Equipamento.pCarregaEquipamento('', qry.FieldByName('TRC_EQLANT').AsString);
        itemAnteriorContrato.ValorCobranca := qry.FieldByName('TRC_VLRCOB').AsFloat;
        itemAnteriorContrato.CodConferenteEntrada := qry.FieldByName('TRC_CNFENT').AsString;
        itemAnteriorContrato.CodSupervisorEntrada := qry.FieldByName('TRC_SUPENT').AsString;
        itemAnteriorContrato.DataInspecaoEntrada := qry.FieldByName('TRC_DTAIPE').AsDateTime;
        itemAnteriorContrato.HoraInspecaoEntrada := qry.FieldByName('TRC_HRAIPE').AsDateTime;
        itemAnteriorContrato.ObservacoesEntrada := qry.FieldByName('TRC_OBSENT').AsString;
        itemAnteriorContrato.NomConferenteEntrada := qry.FieldByName('NOMCNFENT').AsString;
        itemAnteriorContrato.NomSupervisorEntrada := qry.FieldByName('NOMSUPENT').AsString;
        itemAnteriorContrato.strAvaria := qry.FieldByName('TRC_AVAENT').AsString;
        itemAnteriorContrato.strHigienizado := qry.FieldByName('TRC_HIGIPE').AsString;

        itemTroca.FitemAnteriorContrato := itemAnteriorContrato;

        itemContrato := TItemContratoLocacaoEquipamentos.Create(FContrato);
        itemContrato.Equipamento.pCarregaEquipamento('', qry.FieldByName('TRC_CODEQL').AsString);
        itemContrato.CodConferenteSaida := qry.FieldByName('TRC_CNFSAI').AsString;
        itemContrato.CodSupervisorSaida := qry.FieldByName('TRC_SUPSAI').AsString;
        itemContrato.DataInspecaoSaida := qry.FieldByName('TRC_DTAIPS').AsDateTime;
        itemContrato.HoraInspecaoSaida := qry.FieldByName('TRC_HRAIPS').AsDateTime;
        itemContrato.ObservacoesSaida := qry.FieldByName('TRC_OBSSAI').AsString;
        itemContrato.NomConferenteSaida := qry.FieldByName('NOMCNFSAI').AsString;
        itemContrato.NomSupervisorSaida := qry.FieldByName('NOMSUPSAI').AsString;
        itemContrato.strCondicaoPerfeitaSaida := qry.FieldByName('TRC_CNDIPS').AsString;

        itemTroca.FItemContrato := itemContrato;

        FListaEquipamentosTrocados.add(itemAnteriorContrato);
      End;

      If Not fEmptyStr(qry.FieldByName('TRC_CODACL').AsString) Then
      Begin
        itemContrato := TItemContratoLocacaoEquipamentos.Create(FContrato);
        itemTroca.TipoItem := tpAcessorio;
        acessorioAnteriorContrato := TAcessorioContratoLocacaoEquipamentos.Create(itemContrato);
        acessorioAnteriorContrato.Acessorio.pCarregaEquipamento(qry.FieldByName('TRC_ACLANT').AsString, '');
        acessorioAnteriorContrato.ValorCobranca := qry.FieldByName('TRC_VLRCOB').AsFloat;
        acessorioAnteriorContrato.CodConferenteEntrada := qry.FieldByName('TRC_CNFENT').AsString;
        acessorioAnteriorContrato.CodSupervisorEntrada := qry.FieldByName('TRC_SUPENT').AsString;
        acessorioAnteriorContrato.DataInspecaoEntrada := qry.FieldByName('TRC_DTAIPE').AsDateTime;
        acessorioAnteriorContrato.HoraInspecaoEntrada := qry.FieldByName('TRC_HRAIPE').AsDateTime;
        acessorioAnteriorContrato.ObservacoesEntrada := qry.FieldByName('TRC_OBSENT').AsString;
        acessorioAnteriorContrato.NomConferenteEntrada := qry.FieldByName('NOMCNFENT').AsString;
        acessorioAnteriorContrato.NomSupervisorEntrada := qry.FieldByName('NOMSUPENT').AsString;
        acessorioAnteriorContrato.CodEquipamento := qry.FieldByName('TRC_EQLANT').AsString;
        acessorioAnteriorContrato.strAvaria := qry.FieldByName('TRC_AVAENT').AsString;
        acessorioAnteriorContrato.Quantidade := qry.FieldByName('TRC_QTDACL').AsFloat;
        acessorioAnteriorContrato.strHigienizado := qry.FieldByName('TRC_HIGIPE').AsString;

        itemTroca.FacessorioAnteriorContrato := acessorioAnteriorContrato;

        acessorioContrato := TAcessorioContratoLocacaoEquipamentos.Create(itemContrato);
        acessorioContrato.Acessorio.pCarregaEquipamento(qry.FieldByName('TRC_CODACL').AsString, '');
        acessorioContrato.CodConferenteSaida := qry.FieldByName('TRC_CNFSAI').AsString;
        acessorioContrato.CodSupervisorSaida := qry.FieldByName('TRC_SUPSAI').AsString;
        acessorioContrato.DataInspecaoSaida := qry.FieldByName('TRC_DTAIPS').AsDateTime;
        acessorioContrato.HoraInspecaoSaida := qry.FieldByName('TRC_HRAIPS').AsDateTime;
        acessorioContrato.ObservacoesSaida := qry.FieldByName('TRC_OBSSAI').AsString;
        acessorioContrato.NomConferenteSaida := qry.FieldByName('NOMCNFSAI').AsString;
        acessorioContrato.NomSupervisorSaida := qry.FieldByName('NOMSUPSAI').AsString;
        acessorioContrato.CodEquipamento := qry.FieldByName('TRC_EQLACL').AsString;
        acessorioContrato.strCondicaoPerfeitaSaida := qry.FieldByName('TRC_CNDIPS').AsString;
        acessorioContrato.Quantidade := qry.FieldByName('TRC_QTDACL').AsFloat;
        itemTroca.FacessorioContrato := acessorioContrato;

        FListaAcessoriosTrocados.add(acessorioAnteriorContrato);
      End;

      qry.Next;

    End;
  Finally
    FreeAndNil(qry);
  End;
End;

procedure TTrocaContrato.pCarregarTroca(const strAutInc, strCodTrc: String);
var
  qry: TUniQuery;
  strSelect: String;
Begin
  pLimpar;

  strSelect := 'SELECT OPE_NOMOPE, TRCEQL.* ' +
               '  FROM TRCEQL ' +
               '  INNER JOIN CONEQL ON (TRC_SEQCON = CONEQL.AUTOINCREM) ' +
               '  INNER JOIN CADOPE ON (TRC_CODOPE = OPE_CODOPE) ' +
               '  WHERE TRUE ';

  If Not fEmptyStr(strAutInc) Then
    strSelect := strSelect + ' AND TRCEQL.AUTOINCREM = :AUTINC';

  If Not fEmptyStr(strCodTrc) Then
  Begin
    strSelect := strSelect + ' AND TRC_CODIGO = :CODIGO';
    strSelect := strSelect + ' AND EQL_CODEMP = :CODEMP';
  End;

  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add(strSelect);
    If Not fEmptyStr(strAutInc) Then
      qry.ParamByName('AUTINC').AsString := strAutInc;
    If Not fEmptyStr(strCodTrc) Then
    Begin
      qry.ParamByName('CODIGO').AsString := strCodTrc;
      qry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    End;

    qry.Open;
    If Not qry.IsEmpty Then
    Begin
      FAutInc := qry.FieldByName('AUTOINCREM').AsString;
      FCodigo := qry.FieldByName('TRC_CODIGO').AsString;
      FDtaTrc := qry.FieldByName('TRC_DTATRC').AsDateTime;
      FHraTrc := qry.FieldByName('TRC_HRATRC').AsDateTime;
      FCodOpe := qry.FieldByName('TRC_CODOPE').AsString;
      FNomOpe := qry.FieldByName('OPE_NOMOPE').AsString;

      FContrato.fCarregarContrato(qry.FieldByName('TRC_SEQCON').AsString);

      pCarregarItensTroca;

    End;
  Finally
    FreeAndNil(qry);
  End;
End;

function TTrocaContrato.fImprimeComprovanteIspEnt: Boolean;
var
  intCnt: Integer;
  strLayPadrao: String;
  objImpressao: TEditorFastImpressao;
begin
  strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeInspecaoEnt], VS_strCodEmp, 'S']);

  If fEmptyStr(strLayPadrao) Then
  Begin
    FMensagemRetorno := 'Não há layout disponível para impressão!';
    Result := False;
    Exit;
  End;

  objImpressao := TEditorFastImpressao.Create(Nil);
  Try
    objImpressao.recDocume.strEquipamentos := '';
    objImpressao.recDocume.strNumDoc       := FContrato.NroContrato;
    objImpressao.recDocume.strCodEmp       := VS_strCodEmp;

    For intCnt:= 0 to FListaItens.Count-1 Do
    Begin
      If FListaItens[intCnt].FTipoItem = tpPrincipal Then
      Begin
        If FListaItens[intCnt].FItemAnteriorContrato.InspecaoEntradaRealizada Then
        Begin
          If fEmptyStr(objImpressao.recDocume.strEquipamentos) Then
            objImpressao.recDocume.strEquipamentos := QuotedStr(FListaItens[intCnt].FItemAnteriorContrato.AutInc)
          else
            objImpressao.recDocume.strEquipamentos := objImpressao.recDocume.strEquipamentos + ',' + QuotedStr(FListaItens[intCnt].FItemAnteriorContrato.AutInc);
        End;
      End;
    End;
    objImpressao.recDocume.blnInspecaoEnt  := True;
    objImpressao.tpeTipoEtiqueta           := tpeInspecaoEnt;
    Result := objImpressao.fImprimeDocumento;
  Finally
    FreeAndNil(objImpressao);
  End;
end;

function TTrocaContrato.fImprimeComprovanteIspSai: Boolean;
var
  intCnt: Integer;
  strLayPadrao: String;
  objImpressao: TEditorFastImpressao;
begin
  strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeInspecaoSai], VS_strCodEmp, 'S']);

  If fEmptyStr(strLayPadrao) Then
  Begin
    FMensagemRetorno := 'Não há layout disponível para impressão!';
    Result := False;
    Exit;
  End;

  objImpressao := TEditorFastImpressao.Create(Nil);
  Try
    objImpressao.recDocume.strEquipamentos := '';
    objImpressao.recDocume.strNumDoc       := FContrato.NroContrato;
    objImpressao.recDocume.strCodEmp       := VS_strCodEmp;

    For intCnt:= 0 to FListaItens.Count-1 Do
    Begin
      If FListaItens[intCnt].FTipoItem = tpPrincipal Then
      Begin
        If FListaItens[intCnt].FItemContrato.InspecaoSaidaRealizada Then
        Begin
          If fEmptyStr(objImpressao.recDocume.strEquipamentos) Then
            objImpressao.recDocume.strEquipamentos := QuotedStr(FListaItens[intCnt].FItemContrato.AutInc)
          else
            objImpressao.recDocume.strEquipamentos := objImpressao.recDocume.strEquipamentos + ',' + QuotedStr(FListaItens[intCnt].FItemContrato.AutInc);
        End;
      End;
    End;

    objImpressao.recDocume.blnInspecaoSai  := True;
    objImpressao.tpeTipoEtiqueta           := tpeInspecaoSai;
    Result := objImpressao.fImprimeDocumento;
  Finally
    FreeAndNil(objImpressao);
  End;
end;

function TTrocaContrato.fImprimirAditivoContrato: Boolean;
var
  strPasta : String;
  strNomOri: String;
  strNomDes: String;
  strLogCit: String;
  Word: TWord;
  int: Integer;
  SLDevolvido: TStringList;
  SLEmprestado: TStringList;
begin
  Result := False;

  strPasta  := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'CONTRATO_LOCACAO_TROCA_DE_EQUIPAMENTOS\';
  strNomOri := IncludeTrailingPathDelimiter(TImpressaoLocacao.fRetornaDiretorioPadraoContratos) + 'CONTRATO_LOCACAO_TROCA_DE_EQUIPAMENTOS.DOC';
  If Not FileExists(strNomOri) Then
    strNomOri := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'CONTRATO_LOCACAO_TROCA_DE_EQUIPAMENTOS.DOC';

  strNomDes := strPasta + 'CONTRATO_LOCACAO_TROCA_DE_EQUIPAMENTOS' + FContrato.NroContrato  + '_' + FContrato.CodCliente + '.DOC';
  FNomeArquivoAditivo := strNomDes;

  If Not DirectoryExists(strPasta) Then
    CreateDir(strPasta);

  If FileExists(strNomOri) Then
  Begin
    If FileExists(strNomDes) Then
      DeleteFile(strNomDes);

    Word := TWord.fCriarWord(nil);

    CopyFile(pChar(strNomOri), pChar(strNomDes), False);

    If Word = Nil Then
      Exit;


    SLDevolvido:= TStringList.Create;
    SLEmprestado:= TStringList.Create;
    Try
      If Not Word.AbrirArquivo(strNomDes) Then
      Begin
        fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
        Exit;
      End;

      FContrato.pCarregarDadosEmitente;
      FContrato.pCarregarDadosCliente;

      Application.ProcessMessages;
      Word.pGoToPageHeader;

      strLogCit := ExtractFilePath(Application.ExeName) + 'CITEL.BMP';
      Word.pInsereImagem(IIF(FileExists(fCfgSis('PATLOG')), fCfgSis('PATLOG'), strLogCit));

      Word.pReplace('{{NROCON}}', FContrato.NroContrato);
      Word.pReplace('{{NOMEMP}}', FContrato.Emitente.Nome);
      Word.pReplace('{{EMTCGC}}', FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), FContrato.Emitente.Cnpj));
      Word.pReplace('{{ENDEMP}}', FContrato.Emitente.Endereco);
      Word.pReplace('{{CIDEMP}}', FContrato.Emitente.NomCidade);
      Word.pReplace('{{FONEMP}}', FContrato.Emitente.Fone01);
      Word.pReplace('{{FAXEMP}}', FContrato.Emitente.Fax);
      Word.pReplace('{{NUMEMP}}', FContrato.Emitente.NumEnd);
      Word.pReplace('{{BAIEMP}}', FContrato.Emitente.Bairro);
      Word.pReplace('{{CEPEMP}}', fFormataCEP(FContrato.Emitente.Cep));
      Word.pReplace('{{UF_EMP}}', FContrato.Emitente.Estado);
      Word.pReplace('{{IESEMP}}', FContrato.Emitente.InstricaoEstadual);

      Word.pReplace('{{CLINOM}}', FContrato.NomCliente);
      Word.pReplace('{{CLIDOC}}', fFormataCpfCgc(FContrato.Cliente.CpfCnpj, opcBrasil));
      Word.pReplace('{{CLIEND}}', FContrato.Cliente.Endereco);
      Word.pReplace('{{CLICID}}', FContrato.Cliente.NomCid);
      Word.pReplace('{{CLIEST}}', FContrato.Cliente.Estado);
      Word.pReplace('{{CLICEP}}', fFormataCEP(FContrato.Cliente.Cep));
      Word.pReplace('{{CLIBAI}}', FContrato.Cliente.Bairro);
      Word.pReplace('{{CLIFON}}', fFormataFone(FContrato.Cliente.Fone01));
      Word.pReplace('{{CLIEMA}}', FContrato.Cliente.Email);
      Word.pReplace('{{VLRCOB}}', 'Total Cobrança: ' + FormatFloat('#,##0.00', FVlrTotCob));

      Application.ProcessMessages;
      Word.pGoToMainDocument;

      Word.pReplace('{{NROCON}}', FContrato.NroContrato);
      Word.pReplace('{{NOMEMP}}', FContrato.Emitente.Nome);
      Word.pReplace('{{EMTCGC}}', FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), FContrato.Emitente.Cnpj));
      Word.pReplace('{{ENDEMP}}', FContrato.Emitente.Endereco);
      Word.pReplace('{{CIDEMP}}', FContrato.Emitente.NomCidade);
      Word.pReplace('{{FONEMP}}', FContrato.Emitente.Fone01);
      Word.pReplace('{{FAXEMP}}', FContrato.Emitente.Fax);
      Word.pReplace('{{NUMEMP}}', FContrato.Emitente.NumEnd);
      Word.pReplace('{{BAIEMP}}', FContrato.Emitente.Bairro);
      Word.pReplace('{{CEPEMP}}', fFormataCEP(FContrato.Emitente.Cep));
      Word.pReplace('{{UF_EMP}}', FContrato.Emitente.Estado);
      Word.pReplace('{{IESEMP}}', FContrato.Emitente.InstricaoEstadual);

      Word.pReplace('{{CLINOM}}', FContrato.NomCliente);
      Word.pReplace('{{CLIDOC}}', fFormataCpfCgc(FContrato.Cliente.CpfCnpj, opcBrasil));
      Word.pReplace('{{CLIEND}}', FContrato.Cliente.Endereco);
      Word.pReplace('{{CLICID}}', FContrato.Cliente.NomCid);
      Word.pReplace('{{CLIEST}}', FContrato.Cliente.Estado);
      Word.pReplace('{{CLICEP}}', fFormataCEP(FContrato.Cliente.Cep));
      Word.pReplace('{{CLIBAI}}', FContrato.Cliente.Bairro);
      Word.pReplace('{{CLIFON}}', fFormataFone(FContrato.Cliente.Fone01));
      Word.pReplace('{{CLIEMA}}', FContrato.Cliente.Email);
      Word.pReplace('{{VLRCOB}}', 'Total Cobrança: ' + FormatFloat('#,##0.00', FVlrTotCob));

      For int:= 0 to FListaItens.Count-1 Do
      Begin
        If FListaItens[int].FTipoItem = tpPrincipal Then
        Begin
          SLDevolvido.Add('Equipamento devolvido: ' + FListaItens[int].FItemAnteriorContrato.Equipamento.Codigo + ' - '+ FListaItens[int].FItemAnteriorContrato.Equipamento.Descricao);
          SLEmprestado.Add('Equipamento emprestado: '+ FListaItens[int].FItemContrato.Equipamento.Codigo + ' - '+ FListaItens[int].FItemContrato.Equipamento.Descricao);
        End;
        If FListaItens[int].FTipoItem = tpAcessorio Then
        Begin
          SLDevolvido.Add('Acessório devolvido: ' + FListaItens[int].FAcessorioAnteriorContrato.Acessorio.Codigo + ' - '+ FListaItens[int].FAcessorioAnteriorContrato.Acessorio.Descricao);
          SLEmprestado.Add('Acessório emprestado: '+ FListaItens[int].FAcessorioContrato.Acessorio.Codigo + ' - '+ FListaItens[int].FAcessorioContrato.Acessorio.Descricao);
        End;
      End;

      Word.pReplace('{{ELQDEV}}', SLDevolvido.Text);
      Word.pReplace('{{ELQEMP}}', SLEmprestado.Text);
      Word.pReplace('{{CLINOM}}', FContrato.NomCliente);
      Word.pReplace('{{DTAINI}}', FormatDateTime('dd/mm/yyyy', Today));

      Word.pSalvar;

      Result := True;
    Finally
      Word.pFechar;
      FreeAndNil(Word);
      FreeAndNil(SLEmprestado);
      FreeAndNil(SLDevolvido);

      Application.ProcessMessages;
    End;
  End
  Else
    fMensagem('ATENÇÃO!', 'Modelo de aditivo de contrato não encontrado!', ['&O k']);
end;

procedure TTrocaContrato.pLimpar;
begin
  FAutInc := EmptyStr;
  FCodigo := EmptyStr;
  FCodOpe := EmptyStr;
  FNomOpe := EmptyStr;
  FContrato.pLimpar;
  FDtaTrc := 0;
  FHraTrc := 0;
  FVlrTotCob := 0;
  FMensagemRetorno := EmptyStr;
  FblnTrocaRealizada := False;
  FEmAlteracaoValorCobranca := False;

  FListaItens.Clear;
  FListaEquipamentosTrocados.Clear;
  FListaAcessoriosTrocados.Clear;
end;

procedure TTrocaContrato.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TTrocaContrato.SetCodOpe(const AValue: String);
begin
  FCodOpe := AValue;
end;

procedure TTrocaContrato.SetCodTrc(const AValue: String);
begin
  FCodigo := AValue;
end;

procedure TTrocaContrato.SetContrato(
  const AValue: TContratoLocacaoEquipamentos);
begin
  FContrato := AValue;
end;

procedure TTrocaContrato.SetDtaTrc(const AValue: TDateTime);
begin
  FDtaTrc := AValue;
end;

procedure TTrocaContrato.SetLstAcl(
  const AValue: TList<TAcessorioContratoLocacaoEquipamentos>);
begin
  FListaAcessoriosTrocados := AValue;
end;

procedure TTrocaContrato.SetLstEql(
  const AValue: TList<TItemContratoLocacaoEquipamentos>);
begin
  FListaEquipamentosTrocados := AValue;
end;

procedure TTrocaContrato.SetMsgRet(const AValue: String);
begin
  FMensagemRetorno := AValue;
end;

procedure TTrocaContrato.SetNomAdt(const AValue: String);
begin
  FNomeArquivoAditivo := AValue;
end;

procedure TTrocaContrato.SetNomOpe(const AValue: String);
begin
  FNomOpe := AValue;
end;

procedure TTrocaContrato.SetTotCob(const AValue: Double);
begin
  FVlrTotCob := AValue;
end;

{ TItemTrocaContrato }

constructor TItemTrocaContrato.Create(Owner: TTrocaContrato);
begin
  FTroca := Owner;
  FqryInsert := fCriaQuery;
  FblnPermiteEquDif := False;
  FblnEdicao := False;
  FValorCobrancaAlterado:= False;
end;

destructor TItemTrocaContrato.Destroy;
begin
  FreeAndNil(FqryInsert);

  inherited;
end;

function TItemTrocaContrato.fAtualizarAcessoriosContrato: Boolean;
var
  qryUpdate: TUniQuery;
  objPedido: TPedidoContratoLocacao;
  intCnt: Integer;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('DELETE FROM ACLDET              ' +
                      ' WHERE EQD_SEQCON = :EQD_SEQCON ' +
                      '   AND EQD_SEQEQL = :EQD_SEQEQL ' );
    qryUpdate.ParamByName('EQD_SEQEQL').AsString := FItemAnteriorContrato.Equipamento.Codigo;
    qryUpdate.ParamByName('EQD_SEQCON').AsString := FTroca.Contrato.AutInc;
    qryUpdate.ExecSQL;

    If fCfgSis('CPGCTR', VarBoolean) Then
    Begin
      objPedido := TPedidoContratoLocacao.Create(FItemAnteriorContrato.Contrato);
      Try
        If objPedido.fCarregarPedidoParaAlteracao Then
        Begin
          objPedido.fCancelarPedido;
        End;
      Finally
        FreeAndNil(objPedido);
      End;
    End;

    FItemContrato.pLimparAcessorios;
    If FItemContrato.Equipamento.Acessorios.Count > 0 Then
    Begin
      FItemContrato.pAddAcessorios;
      FItemContrato.fInserirAcessorios;
      For intCnt:= 0 To  FItemContrato.Acessorios.Count -1 Do
      Begin
        FItemContrato.Acessorios[intCnt].CodSupervisorSaida := FItemContrato.CodSupervisorSaida;
        FItemContrato.Acessorios[intCnt].CodConferenteSaida := FItemContrato.CodConferenteSaida;
        FItemContrato.Acessorios[intCnt].DataInspecaoSaida  := FItemContrato.DataInspecaoSaida;
        FItemContrato.Acessorios[intCnt].HoraInspecaoSaida  := FItemContrato.HoraInspecaoSaida;
        FItemContrato.Acessorios[intCnt].ObservacoesSaida   := FItemContrato.ObservacoesSaida;
        FItemContrato.Acessorios[intCnt].strCondicaoPerfeitaSaida := FItemContrato.strCondicaoPerfeitaSaida;
        FItemContrato.Acessorios[intCnt].blnAtualizarInspSaida := True;

        FItemContrato.Acessorios[intCnt].pConfirmarInspecaoSaida;
      End;
      FItemContrato.pCalcularValorLocacao;
      FItemContrato.Contrato.pCalculaTotais;
      FItemContrato.Contrato.pAtualizaTotalContrato;
    End;

    If fCfgSis('CPGCTR', VarBoolean) Then
    Begin
      objPedido := TPedidoContratoLocacao.Create(FItemContrato.Contrato);
      Try
        objPedido.fGerarPedido;
        FItemContrato.Contrato.fAtualizarPedidoAdiantamento(objPedido.AutIncFatGor);
      Finally
        FreeAndNil(objPedido);
      End;
    End;

    Result := True;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TItemTrocaContrato.fConfirmarTrocaAcessorioContrato: Boolean;
var
  FqryUpdate: TUniQuery;
begin
  FqryUpdate := fCriaQuery;
  Try
    FqryUpdate.DisableControls;
    FqryUpdate.SQL.Add('UPDATE ACLDET SET EQD_SEQACL = :EQD_SEQACL, '+
                       '       EQD_DTAIPE = NULL, '+
                       '       EQD_HIGIPE = NULL, '+
                       '       EQD_AVAIPE = NULL, '+
                       '       EQD_OBSIPE = NULL, '+
                       '       EQD_COBIPE = NULL, '+
                       '       EQD_VALIPE = NULL, '+
                       '       EQD_OPEIPE = NULL, '+
                       '       EQD_SUPIPE = NULL, '+
                       '       EQD_HORIPE = NULL  '+
                       ' WHERE AUTOINCREM = :AUTINC');
    FqryUpdate.ParamByName('EQD_SEQACL').AsString := FAcessorioContrato.Acessorio.Codigo;
    FqryUpdate.ParamByName('AUTINC').AsString := FAcessorioContrato.AutInc;
    FqryUpdate.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(FqryUpdate);
  End;
end;

function TItemTrocaContrato.fConfirmarTrocaItemContrato: Boolean;
begin
  If FblnPermiteEquDif Then
    Result := fConfirmarTrocaItemEstruturaDiferente
  Else
    Result := fConfirmarTrocaItemEstruturaIgual;
end;

function TItemTrocaContrato.fConfirmarTrocaItemEstruturaDiferente: Boolean;
var
  FqryUpdate: TUniQuery;
  intCnt: Integer;
begin
  FqryUpdate := fCriaQuery;
  Try
    FqryUpdate.DisableControls;
    FqryUpdate.SQL.Clear;
    FqryUpdate.SQL.Add('UPDATE EQLDET SET EQD_SEQEQL = :EQD_SEQEQL, '+
                       '       EQD_DTAIPE = NULL, '+
                       '       EQD_HIGIPE = NULL, '+
                       '       EQD_AVAIPE = NULL, '+
                       '       EQD_OBSIPE = NULL, '+
                       '       EQD_COBIPE = NULL, '+
                       '       EQD_VALIPE = NULL, '+
                       '       EQD_OPEIPE = NULL, '+
                       '       EQD_SUPIPE = NULL, '+
                       '       EQD_HORIPE = NULL, '+
                       '       EQD_HIGIPE = NULL, '+
                       '       EQD_EQUTRC = :EQUTRC, ' +
                       '       EQD_VLRALT = :VLRALT  ' +
                       ' WHERE AUTOINCREM = :AUTINC');
    FqryUpdate.ParamByName('EQD_SEQEQL').AsString := FItemContrato.Equipamento.Codigo;
    FqryUpdate.ParamByName('AUTINC').AsString := FItemContrato.AutInc;
    FqryUpdate.ParamByName('EQUTRC').AsString := 'S';
    FqryUpdate.ParamByName('VLRALT').AsString := 'S';
    FqryUpdate.ExecSQL;

    For intCnt := 0 to  FItemContrato.Contrato.Itens.Count-1 do
    Begin
      If FItemContrato.Contrato.Itens[intCnt].Equipamento.Codigo = FItemAnteriorContrato.Equipamento.Codigo  Then
      Begin
        FItemContrato.Contrato.Itens[intCnt] := FItemContrato;
        Break;
      End;
    End;

    Result := fAtualizarAcessoriosContrato;
  Finally
    FreeAndNil(FqryUpdate);
  End;
end;

function TItemTrocaContrato.fConfirmarTrocaItemEstruturaIgual: Boolean;
var
  FqryUpdate: TUniQuery;
begin
  FqryUpdate := fCriaQuery;
  Try
    FqryUpdate.DisableControls;
    FqryUpdate.SQL.Clear;
    FqryUpdate.SQL.Add('UPDATE EQLDET SET EQD_SEQEQL = :EQD_SEQEQL, '+
                       '       EQD_DTAIPE = NULL, '+
                       '       EQD_HIGIPE = NULL, '+
                       '       EQD_AVAIPE = NULL, '+
                       '       EQD_OBSIPE = NULL, '+
                       '       EQD_COBIPE = NULL, '+
                       '       EQD_VALIPE = NULL, '+
                       '       EQD_OPEIPE = NULL, '+
                       '       EQD_SUPIPE = NULL, '+
                       '       EQD_HORIPE = NULL, '+
                       '       EQD_HIGIPE = NULL  '+
                       ' WHERE AUTOINCREM = :AUTINC');
    FqryUpdate.ParamByName('EQD_SEQEQL').AsString := FItemContrato.Equipamento.Codigo;
    FqryUpdate.ParamByName('AUTINC').AsString := FItemContrato.AutInc;
    FqryUpdate.ExecSQL;

    FqryUpdate.SQL.Clear;
    FqryUpdate.SQL.Add('UPDATE ACLDET SET EQD_SEQEQL = :NEW_SEQEQL, '+
                       '       EQD_DTAIPE = NULL, '+
                       '       EQD_HIGIPE = NULL, '+
                       '       EQD_AVAIPE = NULL, '+
                       '       EQD_OBSIPE = NULL, '+
                       '       EQD_COBIPE = NULL, '+
                       '       EQD_VALIPE = NULL, '+
                       '       EQD_OPEIPE = NULL, '+
                       '       EQD_SUPIPE = NULL, '+
                       '       EQD_HORIPE = NULL, '+
                       '       EQD_HIGIPE = NULL  '+
                       ' WHERE EQD_SEQCON = :EQD_SEQCON ' +
                       '   AND EQD_SEQEQL = :EQD_SEQEQL ' );
    FqryUpdate.ParamByName('NEW_SEQEQL').AsString := FItemContrato.Equipamento.Codigo;
    FqryUpdate.ParamByName('EQD_SEQEQL').AsString := FItemAnteriorContrato.Equipamento.Codigo;
    FqryUpdate.ParamByName('EQD_SEQCON').AsString := FTroca.Contrato.AutInc;
    FqryUpdate.ExecSQL;

    FqryUpdate.SQL.Clear;
    FqryUpdate.SQL.Add(' UPDATE EXTDOR                                         ' +
                       '  INNER JOIN FATDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM  ' +
                       '  INNER JOIN FATGOR ON FDO_SEQGER = FATGOR.AUTOINCREM  ' +
                       '  INNER JOIN CONEQL ON EQL_AUT_PD = FATGOR.AUTOINCREM  ' +
                       ' SET FDO_SEQEQL = :NEW_SEQEQL                          ' +
                       ' WHERE FDO_SEQEQL = :OLD_SEQEQL AND                    ' +
                       '       CONEQL.AUTOINCREM = :EQD_SEQCON                 ');
    FqryUpdate.ParamByName('NEW_SEQEQL').AsString := FItemContrato.Equipamento.AutInc;
    FqryUpdate.ParamByName('OLD_SEQEQL').AsString := FItemAnteriorContrato.Equipamento.AutInc;
    FqryUpdate.ParamByName('EQD_SEQCON').AsString := FTroca.Contrato.AutInc;
    FqryUpdate.ExecSQL;

    FqryUpdate.SQL.Clear;
    FqryUpdate.SQL.Add(' UPDATE EQLFAT                                         ' +
                       ' SET EQF_SEQEQL = :NEW_SEQEQL                          ' +
                       ' WHERE EQF_SEQEQL = :OLD_SEQEQL                        ' +
                       '   AND EQF_SEQCON = :EQD_SEQCON                       ');
    FqryUpdate.ParamByName('NEW_SEQEQL').AsString := FItemContrato.Equipamento.Codigo;
    FqryUpdate.ParamByName('OLD_SEQEQL').AsString := FItemAnteriorContrato.Equipamento.Codigo;
    FqryUpdate.ParamByName('EQD_SEQCON').AsString := FTroca.Contrato.AutInc;
    FqryUpdate.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(FqryUpdate);
  End;
end;

function TItemTrocaContrato.fEfetuarTrocaAcessorio(
  const aCodAcl: String): Boolean;
begin
  Try
    FacessorioContrato.Acessorio.pCarregaEquipamento('', aCodAcl);
    FblnEdicao := True;
    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TItemTrocaContrato.fEfetuarTrocaAcessorio]');
      Result := False;
    End;
  End;
end;

function TItemTrocaContrato.fEfetuarTrocaEquipamento(
  const aCodEql: String): Boolean;
begin
  Try
    FitemContrato.Equipamento.pCarregaEquipamento('', aCodEql);
    FitemContrato.DataInicialCobranca := FItemAnteriorContrato.DataInicialCobranca;

    FblnEdicao := True;
    Result := True;
  Except
    Result := False;
  End;
end;

function TItemTrocaContrato.fGravarInspecaoEntradaAcessorio: Boolean;
begin
  Try
    FAcessorioAnteriorContrato.pConfirmarInspecaoEntrada;
    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TItemTrocaContrato.fGravarInspecaoEntradaAcessorio]');
      Result := False;
    End;
  End;
end;

function TItemTrocaContrato.fGravarInspecaoEntradaEquipamento: Boolean;
begin
  Try
    FItemAnteriorContrato.pConfirmarInspecaoEntrada;
    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TItemTrocaContrato.fGravarInspecaoEntradaEquipamento]');
      Result := False;
    End;
  End;
end;

function TItemTrocaContrato.fGravarTrocaAcessorioItem: Boolean;
var
  blnBloquear: Boolean;
begin
  FqryInsert.DisableControls;
  Try

    FAcessorioContrato.pConfirmarInspecaoSaida;

    blnBloquear := fCfgSis('LOCLIB', varBoolean);
    If Not blnBloquear Then
      blnBloquear := FAcessorioAnteriorContrato.strAvaria  = 'S';

    If blnBloquear Then
    Begin
      FAcessorioAnteriorContrato.fBloquearCadastroAcessorio;
    End;

    FAutInc := fRetAutoIncrem('TRCDET', VS_strCodEmp);
    FCodigo := fAtualizaProCod('TRCDET', 'TRC_CODIGO');

    FqryInsert.SQL.Clear;
    FqryInsert.SQL.Add('INSERT INTO TRCDET(AUTOINCREM, TRC_SEQTRC, TRC_CODIGO, TRC_CODEQL, TRC_CODACL, TRC_EQLANT, TRC_ACLANT, TRC_HRAIPE, TRC_HRAIPS, '+
                       '  TRC_DTAIPE, TRC_DTAIPS, TRC_VLRCOB, TRC_CNFENT, TRC_CNFSAI, TRC_SUPENT, TRC_SUPSAI, TRC_AVAENT, TRC_OBSENT, TRC_OBSSAI, TRC_EQLACL, '+
                       '  TRC_CNDIPS, TRC_HIGIPE, TRC_DTACOB, TRC_HORCOB, TRC_DTAANT, TRC_HRAANT, TRC_CNFANT, TRC_SUPANT, TRC_OBSANT, TRC_CNDANT, TRC_QTDACL)' );
    FqryInsert.SQL.Add('VALUES(:AUTOINCREM, :TRC_SEQTRC, :TRC_CODIGO, :TRC_CODEQL, :TRC_CODACL, :TRC_EQLANT, :TRC_ACLANT, :TRC_HRAIPE, :TRC_HRAIPS, ' +
                       '  :TRC_DTAIPE, :TRC_DTAIPS, :TRC_VLRCOB, :TRC_CNFENT, :TRC_CNFSAI, :TRC_SUPENT, :TRC_SUPSAI, :TRC_AVAENT, :TRC_OBSENT, :TRC_OBSSAI, :TRC_EQLACL, '+
                       '  :TRC_CNDIPS, :TRC_HIGIPE, :TRC_DTACOB, :TRC_HORCOB, :TRC_DTAANT, :TRC_HRAANT, :TRC_CNFANT, :TRC_SUPANT, :TRC_OBSANT, :TRC_CNDANT, :TRC_QTDACL )');

    FqryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    FqryInsert.ParamByName('TRC_SEQTRC').AsString := FTroca.AutInc;
    FqryInsert.ParamByName('TRC_CODIGO').AsString := FCodigo;
    FqryInsert.ParamByName('TRC_EQLACL').AsString := FAcessorioContrato.CodEquipamento;
    FqryInsert.ParamByName('TRC_CODACL').AsString := FAcessorioContrato.Acessorio.AutInc;
    FqryInsert.ParamByName('TRC_QTDACL').AsFloat  := FAcessorioAnteriorContrato.Quantidade;
    // SAIDA REALIZADA
    FqryInsert.ParamByName('TRC_DTAIPS').AsDateTime := FAcessorioContrato.DataInspecaoSaida;
    FqryInsert.ParamByName('TRC_HRAIPS').AsDateTime := FAcessorioContrato.HoraInspecaoSaida;
    FqryInsert.ParamByName('TRC_CNFSAI').AsString   := FAcessorioContrato.CodConferenteSaida;
    FqryInsert.ParamByName('TRC_SUPSAI').AsString   := FAcessorioContrato.CodSupervisorSaida;
    FqryInsert.ParamByName('TRC_OBSSAI').AsString   := FAcessorioContrato.ObservacoesSaida;
    FqryInsert.ParamByName('TRC_CNDIPS').AsString   := FAcessorioContrato.strCondicaoPerfeitaSaida;
    // SAIDA EQUIPAMENTO ANTERIOR
    FqryInsert.ParamByName('TRC_ACLANT').AsString   := FAcessorioAnteriorContrato.Acessorio.AutInc;
    FqryInsert.ParamByName('TRC_EQLANT').AsString   := FAcessorioAnteriorContrato.CodEquipamento;
    FqryInsert.ParamByName('TRC_DTAANT').AsDateTime := FAcessorioAnteriorContrato.DataInspecaoSaida;
    FqryInsert.ParamByName('TRC_HRAANT').AsDateTime := FAcessorioAnteriorContrato.HoraInspecaoSaida;
    FqryInsert.ParamByName('TRC_CNFANT').AsString   := FAcessorioAnteriorContrato.CodConferenteSaida;
    FqryInsert.ParamByName('TRC_SUPANT').AsString   := FAcessorioAnteriorContrato.CodSupervisorSaida;
    FqryInsert.ParamByName('TRC_OBSANT').AsString   := FAcessorioAnteriorContrato.ObservacoesSaida;
    FqryInsert.ParamByName('TRC_CNDANT').AsString   := FAcessorioAnteriorContrato.strCondicaoPerfeitaSaida;
    // ENTRADA
    FqryInsert.ParamByName('TRC_DTAIPE').AsDateTime := FAcessorioAnteriorContrato.DataInspecaoEntrada;
    FqryInsert.ParamByName('TRC_HRAIPE').AsDateTime := FAcessorioAnteriorContrato.HoraInspecaoEntrada;
    FqryInsert.ParamByName('TRC_CNFENT').AsString   := FAcessorioAnteriorContrato.CodConferenteEntrada;
    FqryInsert.ParamByName('TRC_SUPENT').AsString   := FAcessorioAnteriorContrato.CodSupervisorEntrada;
    FqryInsert.ParamByName('TRC_AVAENT').AsString   := FAcessorioAnteriorContrato.strAvaria;
    FqryInsert.ParamByName('TRC_OBSENT').AsString   := FAcessorioAnteriorContrato.ObservacoesEntrada;
    FqryInsert.ParamByName('TRC_HIGIPE').AsString   := FAcessorioAnteriorContrato.strHigienizado;
    FqryInsert.ParamByName('TRC_VLRCOB').AsFloat    := FAcessorioAnteriorContrato.ValorCobranca;
    FqryInsert.ParamByName('TRC_DTACOB').AsDateTime := FAcessorioAnteriorContrato.ItemEquipamento.DataInicialCobranca;
    FqryInsert.ParamByName('TRC_HORCOB').AsDateTime := FAcessorioAnteriorContrato.ItemEquipamento.DataInicialCobranca;

    FqryInsert.ExecSQL;

    Result := fConfirmarTrocaAcessorioContrato;

    Result := True;
  Finally
    FqryInsert.EnableControls;
  End;
end;

function TItemTrocaContrato.fGravarTrocaItem: Boolean;
var
  blnBloquear: Boolean;
begin
  FqryInsert.DisableControls;
  Try
    FItemContrato.pConfirmarInspecaoSaida;

    blnBloquear := fCfgSis('LOCLIB', varBoolean);
    If Not blnBloquear Then
      blnBloquear := FItemAnteriorContrato.strAvaria  = 'S';

    If blnBloquear Then
    Begin
      FItemAnteriorContrato.fBloquearCadastroEquipamento;
    End;

    FAutInc := fRetAutoIncrem('TRCDET', VS_strCodEmp);
    FCodigo := fAtualizaProCod('TRCDET', 'TRC_CODIGO');

    FqryInsert.SQL.Clear;
    FqryInsert.SQL.Add('INSERT INTO TRCDET(AUTOINCREM, TRC_SEQTRC, TRC_CODIGO, TRC_CODEQL, TRC_CODACL, TRC_EQLANT, TRC_ACLANT, TRC_HRAIPE, TRC_HRAIPS, '+
                       '  TRC_DTAIPE, TRC_DTAIPS, TRC_VLRCOB, TRC_CNFENT, TRC_CNFSAI, TRC_SUPENT, TRC_SUPSAI, TRC_AVAENT, TRC_OBSENT, TRC_OBSSAI, TRC_EQLACL, '+
                       '  TRC_CNDIPS, TRC_HIGIPE, TRC_DTACOB, TRC_HORCOB, TRC_DTAANT, TRC_HRAANT, TRC_CNFANT, TRC_SUPANT, TRC_OBSANT, TRC_CNDANT, TRC_QTDACL)' );
    FqryInsert.SQL.Add('VALUES(:AUTOINCREM, :TRC_SEQTRC, :TRC_CODIGO, :TRC_CODEQL, :TRC_CODACL, :TRC_EQLANT, :TRC_ACLANT, :TRC_HRAIPE, :TRC_HRAIPS, ' +
                       '  :TRC_DTAIPE, :TRC_DTAIPS, :TRC_VLRCOB, :TRC_CNFENT, :TRC_CNFSAI, :TRC_SUPENT, :TRC_SUPSAI, :TRC_AVAENT, :TRC_OBSENT, :TRC_OBSSAI, :TRC_EQLACL, '+
                       '  :TRC_CNDIPS, :TRC_HIGIPE, :TRC_DTACOB, :TRC_HORCOB, :TRC_DTAANT, :TRC_HRAANT, :TRC_CNFANT, :TRC_SUPANT, :TRC_OBSANT, :TRC_CNDANT, :TRC_QTDACL )');

    FqryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    FqryInsert.ParamByName('TRC_SEQTRC').AsString := FTroca.AutInc;
    FqryInsert.ParamByName('TRC_CODIGO').AsString := FCodigo;
    FqryInsert.ParamByName('TRC_CODEQL').AsString := FItemContrato.Equipamento.Codigo;
    FqryInsert.ParamByName('TRC_EQLACL').AsString := FItemContrato.Equipamento.Codigo;
    FqryInsert.ParamByName('TRC_QTDACL').AsFloat  := 0 ;
    // SAIDA EQUIPAMENTO ANTERIOR
    FqryInsert.ParamByName('TRC_EQLANT').AsString   := FItemAnteriorContrato.Equipamento.Codigo;
    FqryInsert.ParamByName('TRC_DTAANT').AsDateTime := FItemAnteriorContrato.DataInspecaoSaida;
    FqryInsert.ParamByName('TRC_HRAANT').AsDateTime := FItemAnteriorContrato.HoraInspecaoSaida;
    FqryInsert.ParamByName('TRC_CNFANT').AsString   := FItemAnteriorContrato.CodConferenteSaida;
    FqryInsert.ParamByName('TRC_SUPANT').AsString   := FItemAnteriorContrato.CodSupervisorSaida;
    FqryInsert.ParamByName('TRC_OBSANT').AsString   := FItemAnteriorContrato.ObservacoesSaida;
    FqryInsert.ParamByName('TRC_CNDANT').AsString   := FItemAnteriorContrato.strCondicaoPerfeitaSaida;
    // SAÍDA
    FqryInsert.ParamByName('TRC_DTAIPS').AsDateTime := FItemContrato.DataInspecaoSaida;
    FqryInsert.ParamByName('TRC_HRAIPS').AsDateTime := FItemContrato.HoraInspecaoSaida;
    FqryInsert.ParamByName('TRC_CNFSAI').AsString   := FItemContrato.CodConferenteSaida;
    FqryInsert.ParamByName('TRC_SUPSAI').AsString   := FItemContrato.CodSupervisorSaida;
    FqryInsert.ParamByName('TRC_OBSSAI').AsString   := FItemContrato.ObservacoesSaida;
    FqryInsert.ParamByName('TRC_CNDIPS').AsString   := FItemContrato.strCondicaoPerfeitaSaida;
    // ENTRADA
    FqryInsert.ParamByName('TRC_DTAIPE').AsDateTime := FItemAnteriorContrato.DataInspecaoEntrada;
    FqryInsert.ParamByName('TRC_HRAIPE').AsTime     := FItemAnteriorContrato.HoraInspecaoEntrada;
    FqryInsert.ParamByName('TRC_CNFENT').AsString   := FItemAnteriorContrato.CodConferenteEntrada;
    FqryInsert.ParamByName('TRC_SUPENT').AsString   := FItemAnteriorContrato.CodSupervisorEntrada;
    FqryInsert.ParamByName('TRC_AVAENT').AsString   := FItemAnteriorContrato.strAvaria;
    FqryInsert.ParamByName('TRC_OBSENT').AsString   := FItemAnteriorContrato.ObservacoesEntrada;
    FqryInsert.ParamByName('TRC_HIGIPE').AsString   := FItemAnteriorContrato.strHigienizado;
    FqryInsert.ParamByName('TRC_VLRCOB').AsFloat    := FItemAnteriorContrato.ValorCobranca;
    FqryInsert.ParamByName('TRC_DTACOB').AsDateTime := FItemAnteriorContrato.DataInicialCobranca;
    FqryInsert.ParamByName('TRC_HORCOB').AsDateTime := FItemAnteriorContrato.DataInicialCobranca;

    FqryInsert.ExecSQL;

    Result := fConfirmarTrocaItemContrato;
  Finally
    FqryInsert.EnableControls;
  End;
end;

function TItemTrocaContrato.GetAceAnt: TAcessorioContratoLocacaoEquipamentos;
begin
  Result := FAcessorioAnteriorContrato;
end;

function TItemTrocaContrato.GetAcessorio: TAcessorioContratoLocacaoEquipamentos;
begin
  Result := FAcessorioContrato;
end;

function TItemTrocaContrato.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TItemTrocaContrato.GetCodTrc: String;
begin
  Result := FCodigo;
end;

function TItemTrocaContrato.GetEdicao: Boolean;
begin
  Result := FblnEdicao;
end;

function TItemTrocaContrato.GetIteAnt: TItemContratoLocacaoEquipamentos;
begin
  Result := FItemAnteriorContrato;
end;

function TItemTrocaContrato.GetItem: TItemContratoLocacaoEquipamentos;
begin
  Result := FItemContrato;
end;

function TItemTrocaContrato.GetTipIte: TTpEquipamentoLocacao;
begin
  Result := FTipoItem;
end;

procedure TItemTrocaContrato.SetAceAnt(
  const AValue: TAcessorioContratoLocacaoEquipamentos);
begin
  FAcessorioAnteriorContrato := AValue;
end;

procedure TItemTrocaContrato.SetAcessorio(
  const AValue: TAcessorioContratoLocacaoEquipamentos);
begin
  FAcessorioContrato := AValue;
end;

procedure TItemTrocaContrato.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TItemTrocaContrato.SetCodTrc(const AValue: String);
begin
  FCodigo := AValue;
end;

procedure TItemTrocaContrato.SetIteAnt(
  const AValue: TItemContratoLocacaoEquipamentos);
begin
  FItemAnteriorContrato := AValue;
end;

procedure TItemTrocaContrato.SetItem(
  const AValue: TItemContratoLocacaoEquipamentos);
begin
  FItemContrato := AValue;
end;

procedure TItemTrocaContrato.SetTipIte(const AValue: TTpEquipamentoLocacao);
begin
  FTipoItem := AValue;
end;

{ TProrrogaContratoLocacao }

constructor TProrrogaContratoLocacao.Create;
begin
  FContrato := TContratoLocacaoEquipamentos.Create;
  FContrato_Bkp := TContratoLocacaoEquipamentos.Create;
  FobjValidaCtr := TValidarContrato.Create(FContrato);

  FblnProrrogacaoRealizada := False;

  FqryInsert := fCriaQuery;
end;

destructor TProrrogaContratoLocacao.Destroy;
begin

  FreeAndNil(FContrato);
  FreeAndNil(FContrato_Bkp);
  FreeAndNil(FqryInsert);
  FreeAndNil(FobjValidaCtr);

  inherited;
end;

function TProrrogaContratoLocacao.fAddContrato(objContrato: TContratoLocacaoEquipamentos): Boolean;
Begin
  Try
    FContrato := objContrato;
    FContrato_Bkp.fCarregarContrato(objContrato.AutInc);
    FobjValidaCtr.ObjContrato := objContrato;
    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TProrrogaContratoLocacao.fAddContrato]');
      Result := False;
    End;
  End;
End;

function TProrrogaContratoLocacao.fIniciarProrrogacaoContrato: Boolean;
begin
  If Not fValidarPodeProrrogarContato Then
  Begin
    Result := False;
    Exit;
  End;

  FContrato.BlnProrrogacao := True;
  Result := True;
end;

function TProrrogaContratoLocacao.fConfirmarProrrogacaoContrato: Boolean;
begin
  FMensagemRetorno := EmptyStr;

  If Not fValidarPodeProrrogarContato Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    FAutInc := fRetAutoIncrem('CONPRG', VS_strCodEmp);
    FCodigo := fAtualizaProCod('CONPRG', 'PRG_CODPRG');

    FqryInsert.SQL.Clear;
    FqryInsert.SQL.Add('INSERT INTO CONPRG(AUTOINCREM, PRG_SEQCON, PRG_CODPRG, PRG_DTAANT, PRG_HRAANT, PRG_VLREST, PRG_DTAPRG, PRG_HRAPRG, PRG_CODOPE, PRG_DTAINI, PRG_HRAINI, PRG_DTAFIN, PRG_HRAFIN, PRG_VLRPRG)');
    FqryInsert.SQL.Add('VALUES(:AUTOINCREM, :PRG_SEQCON,:PRG_CODPRG,  :PRG_DTAANT, :PRG_HRAANT, :PRG_VLREST, :PRG_DTAPRG, :PRG_HRAPRG, :PRG_CODOPE, :PRG_DTAINI, :PRG_HRAINI, :PRG_DTAFIN, :PRG_HRAFIN, :PRG_VLRPRG)');

    FqryInsert.ParamByName('AUTOINCREM').AsString   := FAutInc;
    FqryInsert.ParamByName('PRG_SEQCON').AsString   := FContrato.AutInc;
    FqryInsert.ParamByName('PRG_CODPRG').AsString   := FCodigo;
    FqryInsert.ParamByName('PRG_DTAANT').AsDateTime := FContrato_Bkp.DataFinal;
    FqryInsert.ParamByName('PRG_HRAANT').AsDateTime := FContrato_Bkp.HoraFinal;
    FqryInsert.ParamByName('PRG_VLREST').AsFloat    := FContrato_Bkp.ValorTotalContrato;
    FqryInsert.ParamByName('PRG_DTAPRG').AsDateTime := VS_Date;
    FqryInsert.ParamByName('PRG_HRAPRG').AsDateTime := fNow();
    FqryInsert.ParamByName('PRG_CODOPE').AsString   := strLoginUsuarioLogado;
    FqryInsert.ParamByName('PRG_DTAINI').AsDateTime := FContrato.DataInicial;
    FqryInsert.ParamByName('PRG_HRAINI').AsDateTime := FContrato.HoraInicial;
    FqryInsert.ParamByName('PRG_DTAFIN').AsDateTime := FContrato.DataFinal;
    FqryInsert.ParamByName('PRG_HRAFIN').AsDateTime := FContrato.HoraFinal;
    FqryInsert.ParamByName('PRG_VLRPRG').AsFloat    := FContrato.ValorTotalContrato;
    FqryInsert.ExecSQL;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TProrrogaContratoLocacao.fConfirmarProrrogacaoContrato]');
      Result := False;
    End;
  End;
end;

function TProrrogaContratoLocacao.fValidarPodeProrrogarContato: Boolean;
var
  dtaFinalAtual: TDateTime;
begin
  FMensagemRetorno := EmptyStr;
  FContrato.BlnProrrogacao := False;

  If Not FobjValidaCtr.fContratoPosssuiItensNaoEncerrados Then
  Begin
    Result := False;
    FMensagemRetorno := 'O contrato informado já foi encerrado e sendo assim, não é possível prorrogar.';
    Exit;
  End;

  If FContrato.Status <> 'A' Then
  Begin
    Result := False;
    FMensagemRetorno := 'Este contrato não está ativo. Sendo assim, não é possível prorrogar.';
    Exit;
  End;

  dtaFinalAtual := IIF(FContrato.TipoDuracaoContrato = 'M',
                       FContrato.DataMesFin,
                       FContrato.DataFinal + FContrato.HoraFinal);

  If (dtaFinalAtual < FContrato.DataFinalEstimada) Then
  Begin
    Result := False;
    FMensagemRetorno := 'Na prorrogação só é permitido informar uma data superior à data de término inicial do contrato.';
    Exit;
  End;

  Result := True;
end;

function TProrrogaContratoLocacao.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TProrrogaContratoLocacao.GetCodPrg: String;
begin
  Result := FCodigo;
end;

function TProrrogaContratoLocacao.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TProrrogaContratoLocacao.GetObjCtr: TContratoLocacaoEquipamentos;
begin
  Result := FContrato;
end;

function TProrrogaContratoLocacao.GetPrgRea: Boolean;
begin
  Result :=  FblnProrrogacaoRealizada;
end;

procedure TProrrogaContratoLocacao.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TProrrogaContratoLocacao.SetCodPrg(const AValue: String);
begin
  FCodigo := AValue;
end;

procedure TProrrogaContratoLocacao.SetObjCtr(
  const AValue: TContratoLocacaoEquipamentos);
begin
  FContrato := AValue;
end;


{ TImpressaoLocacao }

constructor TImpressaoLocacao.Create(
  const pContrato: TContratoLocacaoEquipamentos);
begin
  FObjContrato := pContrato;
  FObjWord := TWord.fCriarWord(Nil);
end;

destructor TImpressaoLocacao.Destroy;
begin
  FreeAndNil(FObjWord);

  inherited;
end;

procedure TImpressaoLocacao.pAdicionarTextoVariavel(strNomVar,
  strTexto: String);
var
  intTamTexto: Integer;
  blnTextoLongo: Boolean;
  strNomVarAux,
  strNomVarAtu: String;
  intQtdQuebra: Integer;
  intCnt: Integer;
  strTextoAux,
  strTextoAtu: String;
  arrImpressao: Array of TRecImpVar;
begin
  intTamTexto := (Length(strTexto));
  blnTextoLongo := intTamTexto > 255;

  SetLength(arrImpressao, 0);

  If Not blnTextoLongo Then
  Begin
    FObjWord.pReplace('{{'+strNomVar+'}}', strTexto);
  End
  Else
  Begin
    intQtdQuebra := Ceil(intTamTexto/255);

    strNomVarAux := '{{' + strNomVar + '}}';
    strTextoAux  := strTexto;
    For intCnt:= 0 To intQtdQuebra-1 Do
    Begin
      strNomVarAtu := '{{'+ strNomVar + '_'+ IntToStr(intCnt) +'}}' ;

      FObjWord.pReplace(strNomVarAux, strNomVarAux + ' '+  strNomVarAtu);
      FObjWord.pSalvar;

      strNomVarAux := strNomVarAtu ;
      FObjWord.pSalvar;

      strTextoAtu := Copy(strTextoAux, 0, 255);
      strTextoAux := Copy(strTextoAux, 256, Length(strTextoAux));

      SetLength(arrImpressao, Length(arrImpressao)+1);
      arrImpressao[Length(arrImpressao)-1].strNomVar := strNomVarAtu;
      arrImpressao[Length(arrImpressao)-1].strTexto  := strTextoAtu;
    End;

    FObjWord.pReplace('{{'+strNomVar+'}}', EmptyStr);
    For intCnt:= 0 To Length(arrImpressao)-1 Do
    Begin
      FObjWord.pReplace(arrImpressao[intCnt].strNomVar, arrImpressao[intCnt].strTexto);
    End;

    FObjWord.pSalvar;
  End;
end;

procedure TImpressaoLocacao.pDeterminarArquivosImpressao;
Begin
  If FObjContrato.Status = 'O' Then
  Begin
    FstrPasta  := ExtractFilePath(Application.ExeName) + 'ORCAMENTOS_LOCACAO_EQUIPAMENTOS\';
    FstrNomDes := FstrPasta + 'ORCAMENTO_LOCACAO_EQUIPAMENTOS_' + FObjContrato.NroContrato + '_' + FObjContrato.CodCliente + '.DOC';
  End
  Else
  Begin
    FstrPasta  := ExtractFilePath(Application.ExeName) + 'CONTRATOS_LOCACAO_EQUIPAMENTOS\';
    FstrNomDes := FstrPasta + 'CONTRATO_LOCACAO_EQUIPAMENTOS_' + FObjContrato.NroContrato + '_' + FObjContrato.CodCliente + '.DOC';
  End;

  FstrNomOri := TImpressaoLocacao.fRetornaModeloImpressao(FObjContrato.Status, FblnProrrogacao);

  If Not DirectoryExists(FstrPasta) Then
    CreateDir(FstrPasta);
End;

function TImpressaoLocacao.fImprimirContrato(var blnErroApl: Boolean; const blnProrrogacao: Boolean = False): Boolean;
begin
  blnErroApl := False;

  FMensagemRetorno := EmptyStr;

  If FObjWord = Nil Then
    Exit(False);

  If FObjContrato = Nil Then
    Exit(False);

  If fEmptyStr(FObjContrato.AutInc)Then
  Begin
    FMensagemRetorno := 'Contrato não carregado!';
    Exit(False);
  End;

  FblnProrrogacao := blnProrrogacao;

  pDeterminarArquivosImpressao;

  If Not FileExists(FstrNomOri) Then
  Begin
    FMensagemRetorno := 'Modelo de ' + IIF(FObjContrato.Status = 'O', 'orçamento', 'contrato') + ' não encontrado!';
    Exit(False);
  End;

  If FileExists(FstrNomDes) Then
    DeleteFile(FstrNomDes);

  pLimpaArquivosTemporarios;

  CopyFile(pChar(FstrNomOri), pChar(FstrNomDes), False);

  Try
    If Not FObjWord.AbrirArquivo(FstrNomDes) Then
    Begin
      FMensagemRetorno := 'Não foi possível abrir o arquivo!';
      Exit(False);
    End;

    FObjContrato.pCarregarDadosCliente;
    FObjContrato.pCarregarDadosEmitente;
    FObjContrato.pCarregarResponsaveis;

    Try
      FObjWord.pSalvar;

      Application.ProcessMessages;
      FObjWord.pGoToPageHeader;
      pInserirDadosCabecalho;
      Application.ProcessMessages;
      FObjWord.pSalvar;

      FObjWord.pGoToMainDocument;
      pInserirDadosCorpoDocumento;
      Application.ProcessMessages;
      FObjWord.pSalvar;

      pInsereTabelaEquipamentos;
      pInsereTabelaResumEquipamentos;
      pInsereTabelaNegociacaoDiarias;
      pInsereTabelaAcessorios;
      Application.ProcessMessages;
      FObjWord.pSalvar;
      FObjWord.pFechar;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;

        blnErroApl := (E.Message = 'com.sun.star.container.NoSuchElementException:');

        If Not blnErroApl Then
          FMensagemRetorno := E.Message;

        FObjWord.pFechar;

      End;
    End;

  Finally
    FreeAndNil(FObjWord);
  End;

end;

procedure TImpressaoLocacao.pInsereTabelaNegociacaoDiarias;
var
  intLinha: Integer;
  intCnt,
  intCont,
  intTotDiariasNeg: Integer;
Begin
  intTotDiariasNeg := 0;
  For intCnt := 0 to FObjContrato.Itens.Count-1 Do
  Begin
    intTotDiariasNeg := intTotDiariasNeg + FObjContrato.Itens[intCnt].Equipamento.Diarias.Count;
  End;

  If intTotDiariasNeg <= 0 Then
  Begin
    FObjWord.pReplace('{{NEGOCIACAO}}', EmptyStr);
    Exit;
  End;

  FObjWord.pCriaTabela('{{NEGOCIACAO}}', intTotDiariasNeg + 1, 4);
  If Not FObjWord.blnTabelaCriada Then
    Exit;

  intLinha := 1;

  FObjWord.pCelulaNegrito(intLinha, 1);
  FObjWord.pCelulaEscreve(intLinha, 1, 'EQUIPAMENTO');

  FObjWord.pCelulaNegrito(intLinha, 2);
  FObjWord.pCelulaEscreve(intLinha, 2, 'QTD.DIAS');

  FObjWord.pCelulaNegrito(intLinha, 3);
  FObjWord.pCelulaEscreve(intLinha, 3, 'DIÁRIA');

  FObjWord.pCelulaNegrito(intLinha, 4);
  FObjWord.pCelulaAlignRight(intLinha, 4);
  FObjWord.pCelulaEscreve(intLinha, 4, 'TOTAL');

  For intCnt := 0 to FObjContrato.Itens.Count-1 Do
  Begin
    For intCont := 0 to FObjContrato.Itens[intCnt].Equipamento.Diarias.Count -1 do
    Begin
      Inc(intLinha);
      FObjWord.pCelulaEscreve(intLinha, 1, FObjContrato.Itens[intCnt].Equipamento.Codigo + ' - ' + FObjContrato.Itens[intCnt].Equipamento.Descricao);
      FObjWord.pCelulaAlignRight(intLinha, 2);
      FObjWord.pCelulaEscreve(intLinha, 2, IntToStr(FObjContrato.Itens[intCnt].Equipamento.Diarias[intCont].QuantidadeDias));
      FObjWord.pCelulaAlignRight(intLinha, 2);
      FObjWord.pCelulaEscreve(intLinha, 3, FormatFloat('#,##0.00', FObjContrato.Itens[intCnt].Equipamento.Diarias[intCont].ValorDiaria));
      FObjWord.pCelulaAlignRight(intLinha, 3);
      FObjWord.pCelulaEscreve(intLinha, 4, FormatFloat('#,##0.00', FObjContrato.Itens[intCnt].Equipamento.Diarias[intCont].ValorTotal));
    End;
  End;

  FObjWord.pOtimizaTamanho(1, 4, 65);
  FObjWord.pOtimizaTamanho(1, 3, 65);
  FObjWord.pOtimizaTamanho(1, 2, 65);
  FObjWord.pOtimizaTamanho(1, 1, 250);
End;

procedure TImpressaoLocacao.pInsereTabelaResumEquipamentos;
  var
    intLinha: Integer;
    intCnt: Integer;
  Begin
    FObjWord.pCriaTabela('{{RESUM_EQUIPAMENTOS}}', FObjContrato.Itens.Count + 1, 7);
    If Not FObjWord.blnTabelaCriada Then
      Exit;

    intLinha := 1;

    FObjWord.pCelulaNegrito(intLinha, 1);
    FObjWord.pCelulaEscreve(intLinha, 1, 'CÓDIGO');

    FObjWord.pCelulaNegrito(intLinha, 2);
    FObjWord.pCelulaEscreve(intLinha, 2, 'DESCRIÇÃO');

    FObjWord.pCelulaNegrito(intLinha, 3);
    FObjWord.pCelulaEscreve(intLinha, 3, 'CONTRATADO');

    FObjWord.pCelulaNegrito(intLinha, 4);
    FObjWord.pCelulaAlignRight(intLinha, 4);
    FObjWord.pCelulaEscreve(intLinha, 4, IIF(FObjContrato.TipoDuracaoContrato = 'M', 'TOTAL DE MESES', 'TOTAL DE HORAS/DIÁRIAS'));

    FObjWord.pCelulaNegrito(intLinha, 5);
    FObjWord.pCelulaAlignRight(intLinha, 5);
    FObjWord.pCelulaEscreve(intLinha, 5, IIF(FObjContrato.TipoDuracaoContrato = 'M', 'VALOR MENSAL','VALOR HORA/DIÁRIA') );

    FObjWord.pCelulaNegrito(intLinha, 6);
    FObjWord.pCelulaAlignRight(intLinha, 6);
    FObjWord.pCelulaEscreve(intLinha, 6, 'VALOR TOTAL');

    FObjWord.pCelulaNegrito(intLinha, 7);
    FObjWord.pCelulaAlignRight(intLinha, 7);
    FObjWord.pCelulaEscreve(intLinha, 7, 'VL. EQUIPAMENTO');

    For intCnt := 0 to FObjContrato.Itens.Count-1 Do
    Begin
      Inc(intLinha);
      FObjWord.pCelulaEscreve(intLinha, 1, FObjContrato.Itens[intCnt].Equipamento.Codigo);
      FObjWord.pCelulaEscreve(intLinha, 2, FObjContrato.Itens[intCnt].Equipamento.Descricao);
      FObjWord.pCelulaEscreve(intLinha, 3, arrDescTpCalculoVlLocacao[FObjContrato.Itens[intCnt].TipoCalculoLocacao]);
      FObjWord.pCelulaAlignRight(intLinha, 4);
      Case FObjContrato.Itens[intCnt].TipoCalculoLocacao Of
        tpDiaria : FObjWord.pCelulaEscreve(intLinha, 4, FormatFloat('#,##0.00', FObjContrato.TotalDias));
        tpHoras  : FObjWord.pCelulaEscreve(intLinha, 4, FormatFloat('#,##0.00', FObjContrato.TotalHoras));
        tpMensal : FObjWord.pCelulaEscreve(intLinha, 4, FormatFloat('#,##0.00', FObjContrato.TotalMeses));
      End;
      FObjWord.pCelulaAlignRight(intLinha, 5);
      FObjWord.pCelulaEscreve(intLinha, 5, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].ValorLocacaoContratado));
      FObjWord.pCelulaAlignRight(intLinha, 6);
      FObjWord.pCelulaEscreve(intLinha, 6, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].ValorTotalLocacaoContratado));
      FObjWord.pCelulaEscreve(intLinha, 7, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].Equipamento.ValorAqu));
      FObjWord.pCelulaAlignRight(intLinha, 7);
    End;
    FObjWord.pOtimizaTamanho(1, 7, 70);
    FObjWord.pOtimizaTamanho(1, 6, 70);
    FObjWord.pOtimizaTamanho(1, 5, 70);
    FObjWord.pOtimizaTamanho(1, 4, 70);
    FObjWord.pOtimizaTamanho(1, 3, 70);
    FObjWord.pOtimizaTamanho(1, 2, 100);
    FObjWord.pOtimizaTamanho(1, 1, 70);
  End;

procedure TImpressaoLocacao.pInserirDadosCabecalho;
var
  strLogCit: String;
begin
  strLogCit := ExtractFilePath(Application.ExeName) + 'CITEL.BMP';
  FObjWord.pInsereImagem(IIF(FileExists(fCfgSis('PATLOG')), fCfgSis('PATLOG'), strLogCit));

  FObjWord.pReplace('{{NOMEMP}}', FObjContrato.Emitente.Nome);
  FObjWord.pReplace('{{ENDEMP}}', FObjContrato.Emitente.Endereco);
  FObjWord.pReplace('{{CIDEMP}}', FObjContrato.Emitente.NomCidade);
  FObjWord.pReplace('{{FONEMP}}', fFormataFone(FObjContrato.Emitente.Fone01));
  FObjWord.pReplace('{{FAXEMP}}', fFormataFone(FObjContrato.Emitente.Fax));
  FObjWord.pReplace('{{NUMEMP}}', FObjContrato.Emitente.NumEnd);
  FObjWord.pReplace('{{BAIEMP}}', FObjContrato.Emitente.Bairro);
  FObjWord.pReplace('{{CEPEMP}}', fFormataCEP(FObjContrato.Emitente.Cep));
  FObjWord.pReplace('{{UF_EMP}}', FObjContrato.Emitente.Estado);
  FObjWord.pReplace('{{EMTCGC}}', FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), FObjContrato.Emitente.Cnpj));
  FObjWord.pReplace('{{IESEMP}}', FObjContrato.Emitente.InstricaoEstadual);
  FObjWord.pReplace('{{NROCON}}', FObjContrato.NroContrato);

  FObjWord.pReplace('{{CLINOM}}', FObjContrato.Cliente.NomeCliente);
  FObjWord.pReplace('{{CLIDOC}}', fFormataCpfCgc(FObjContrato.Cliente.CpfCnpj, opcBrasil));
  FObjWord.pReplace('{{CLIEND}}', FObjContrato.Cliente.Endereco);
  FObjWord.pReplace('{{CLICID}}', FObjContrato.Cliente.NomCid);
  FObjWord.pReplace('{{CLIEST}}', FObjContrato.Cliente.Estado);
  FObjWord.pReplace('{{CLICEP}}', fFormataCEP(FObjContrato.Cliente.Cep));
  FObjWord.pReplace('{{CLIBAI}}', FObjContrato.Cliente.Bairro);
  FObjWord.pReplace('{{CLIFON}}', fFormataFone(FObjContrato.Cliente.Fone01));
  FObjWord.pReplace('{{CLIEMA}}', FObjContrato.Cliente.Email);
  FObjWord.pReplace('{{CLI_RG}}', FObjContrato.Cliente.NumRG);

  FObjWord.pReplace('{{LOCALIZACAO OBRA}}', FObjContrato.strEnderecoObra);
  FObjWord.pReplace('{{PEDIDO_COMPRA}}', FObjContrato.NumPedCom);
end;

procedure TImpressaoLocacao.pInserirDadosCorpoDocumento;
var
  strAux: String;
begin
  FObjWord.pReplace('{{NOMEMP}}', FObjContrato.Emitente.Nome);
  FObjWord.pReplace('{{ENDEMP}}', FObjContrato.Emitente.Endereco);
  FObjWord.pReplace('{{NUMEMP}}', FObjContrato.Emitente.NumEnd);
  FObjWord.pReplace('{{BAIEMP}}', FObjContrato.Emitente.Bairro);
  FObjWord.pReplace('{{CEPEMP}}', fFormataCEP(FObjContrato.Emitente.Cep));
  FObjWord.pReplace('{{CIDEMP}}', FObjContrato.Emitente.NomCidade);
  FObjWord.pReplace('{{UF_EMP}}', FObjContrato.Emitente.Estado);
  FObjWord.pReplace('{{FONEMP}}', fFormataFone(FObjContrato.Emitente.Fone01));
  FObjWord.pReplace('{{FAXEMP}}', fFormataFone(FObjContrato.Emitente.Fax));
  FObjWord.pReplace('{{IESEMP}}', FObjContrato.Emitente.InstricaoEstadual);

  FObjWord.pReplace('{{CLINOM}}', FObjContrato.Cliente.NomeCliente);
  FObjWord.pReplace('{{CLIDOC}}', fFormataCpfCgc(FObjContrato.Cliente.CpfCnpj, opcBrasil));
  FObjWord.pReplace('{{CLIEND}}', FObjContrato.Cliente.Endereco);
  FObjWord.pReplace('{{CLICID}}', FObjContrato.Cliente.NomCid);
  FObjWord.pReplace('{{CLIEST}}', FObjContrato.Cliente.Estado);
  FObjWord.pReplace('{{CLICEP}}', fFormataCEP(FObjContrato.Cliente.Cep));
  FObjWord.pReplace('{{CLIBAI}}', FObjContrato.Cliente.Bairro);
  FObjWord.pReplace('{{CLIFON}}', fFormataFone(FObjContrato.Cliente.Fone01));
  FObjWord.pReplace('{{CLIEMA}}', FObjContrato.Cliente.Email);
  FObjWord.pReplace('{{TIPO_1}}', FObjContrato.Cliente.strTipo);
  FObjWord.pReplace('{{IE_CLIENTE}}', FObjContrato.Cliente.InscEst);
  FObjWord.pReplace('{{CLI_RG}}', FObjContrato.Cliente.NumRG);

  FObjWord.pReplace('{{NROCON}}', FObjContrato.NroContrato);
  FObjWord.pReplace('{{DTAINI}}', FormatDateTime('dd/mm/yyyy', FObjContrato.DataInicial));
  FObjWord.pReplace('{{HORINI}}', FormatDateTime('hh:mm', FObjContrato.HoraInicial));
  FObjWord.pReplace('{{DTAFIN}}', FormatDateTime('dd/mm/yyyy', FObjContrato.DataFinal));
  FObjWord.pReplace('{{HORFIN}}', FormatDateTime('hh:mm', FObjContrato.HoraFinal));
  FObjWord.pReplace('{{TOTHOR}}', FormatFloat('#,##0', FObjContrato.TotalHoras));
  FObjWord.pReplace('{{TOTDIA}}', FormatFloat('#,##0', FObjContrato.TotalDias));
  FObjWord.pReplace('{{TOTMES}}', FormatFloat('#,##0', FObjContrato.TotalMeses));
  FObjWord.pReplace('{{QTDEQU}}', FloatToStr(FObjContrato.QuantidadeEquipamentos));
  FObjWord.pReplace('{{TOTCON}}', FormatFloat('#,##0.00', FObjContrato.TotalContrato));
  FObjWord.pReplace('{{TOTAQU}}', FormatFloat('#,##0.00', FObjContrato.ValorTotalEquipamentos));
  FObjWord.pReplace('{{VALOR DO EQUIPAMENTO}}', FormatFloat('#,##0.00', FObjContrato.ValorTotalEquipamentos));
  FObjWord.pReplace('{{TAXENT}}', FormatFloat('#,##0.00', FObjContrato.ValorTaxaEntrega));
  FObjWord.pReplace('{{VLRADC}}', FormatFloat('#,##0.00', FObjContrato.ValorTotalAdicionalAcessorios));

  FObjWord.pReplace('{{TOTDUR}}', 'TOTAL DE ' + objContrato.fRetornastrDescriDuracaoCtr +': ' +
                    IIF(objContrato.TipoDuracaoContrato = 'M', FormatFloat('#,##0', FObjContrato.TotalMeses),
                      IIF(objContrato.TipoDuracaoContrato = 'D', FormatFloat('#,##0', FObjContrato.TotalDias),
                           FormatFloat('#,##0', FObjContrato.TotalHoras)) ) );

  strAux := AnsiLowerCase(fRetExtensoNumero(IntToStr(FObjContrato.TotalDias)));
  strAux := Copy(strAux, 0, Length(strAux)-6);
  FObjWord.pReplace('{{TOTDIA_EXTENSO}}', strAux);

  strAux := AnsiLowerCase(fValorPorExtenso(FloatToStr(FObjContrato.ValorTotalEquipamentos)));
  FObjWord.pReplace('{{VLREQU_EXTENSO}}', strAux);

  FObjWord.pReplace('{{CONPAG}}', fFormataCondPag(FObjContrato.CondicaoPgto));
  FObjWord.pReplace('{{DESFPG}}', FObjContrato.DescricaoFormPgto);
  FObjWord.pReplace('{{EMTCGC}}', FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), FObjContrato.Emitente.Cnpj));
  FObjWord.pReplace('{{AUT_PD}}', FObjContrato.NumDocPedAdiantamento);

  FObjWord.pReplace('{{ASSINADO_POR}}', FObjContrato.Vendedor.Nome);
  FObjWord.pReplace('{{CPF_ASSINADO}}', FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), FObjContrato.Vendedor.strCPF));

  FObjWord.pReplace('{{LOCALIZACAO_OBRA}}', FObjContrato.strEnderecoObra);
  FObjWord.pReplace('{{PEDIDO_COMPRA}}', FObjContrato.NumPedCom);

  pInserirDadosResponsaveis;
  pInserirDadosEquipamentoGeral;
  pInserirTextoEspecificacaoEquipamentos;
end;

procedure TImpressaoLocacao.pInserirDadosEquipamentoGeral;
var
  intCnt: Integer;
  intCont: Integer;
  fltVlrDia: Double;
  fltVlrSem: Double;
  fltVlrQui: Double;
  fltVlrMes: Double;
  strAux: String;
  strEquipamentosInf: String;
  strEquipamentosDes: String;
  strEquipamentosVlrDia: String;
  strEquipamentosVlrSem: String;
  strEquipamentosVlrQui: String;
  strEquipamentosVlrMes: String;
  strEquipamentosVlrRep: String;
  strTagEquip: String;
  strTagEquip_Det: String;
  blnImprimirNF: Boolean;
  blnImprimirReposicao: Boolean;
  strTagEquipAux,
  strTagEquipAtu: String;
  strTextoNF: String;
  strTextoCT: String;
begin
  strTagEquip := EmptyStr;
  Try
    strTagEquipAux := '{{'+ cstIMP_EQUGER +'}}';
    For intCnt := 0 to FObjContrato.Itens.Count-1 Do
    Begin
      strTagEquipAtu := '{{'+ cstIMP_EQUINT + '_'+ IntToStr(intCnt) +'}}' ;

      FObjWord.pReplace(strTagEquipAux, strTagEquipAux  + #13 + strTagEquipAtu);
      FObjWord.pSalvar;

      strTagEquipAux := strTagEquipAtu ;
    End;
    pAdicionarTextoVariavel(cstIMP_EQUGER, EmptyStr);

    For intCnt := 0 to FObjContrato.Itens.Count-1 Do
    Begin
      strTagEquip := cstIMP_EQUINT +'_'+ IntToStr(intCnt);
      strTagEquip_Det := EmptyStr;
      strTagEquip_Det := strTagEquip_Det + '{{EQU_INFOR_'+ IntToStr(intCnt) +'}}' + #13;
      strTagEquip_Det := strTagEquip_Det + '{{EQU_DESCR_'+ IntToStr(intCnt) +'}}' + #13;
      strTagEquip_Det := strTagEquip_Det + '{{EQU_DIARI_'+ IntToStr(intCnt) +'}}' + #13;
      strTagEquip_Det := strTagEquip_Det + '{{EQU_SEMAN_'+ IntToStr(intCnt) +'}}' + #13;
      strTagEquip_Det := strTagEquip_Det + '{{EQU_QUINZ_'+ IntToStr(intCnt) +'}}' + #13;
      strTagEquip_Det := strTagEquip_Det + '{{EQU_MENSA_'+ IntToStr(intCnt) +'}}' + #13;
      strTagEquip_Det := strTagEquip_Det + '{{EQU_REPOS_'+ IntToStr(intCnt) +'}}' + #13;
      pAdicionarTextoVariavel(strTagEquip, strTagEquip_Det);
    End;
    FObjWord.pSalvar;

    For intCnt := 0 to FObjContrato.Itens.Count-1 Do
    Begin
      strEquipamentosInf := EmptyStr;
      strEquipamentosDes := EmptyStr;
      strEquipamentosVlrDia := EmptyStr;
      strEquipamentosVlrSem := EmptyStr;
      strEquipamentosVlrQui := EmptyStr;
      strEquipamentosVlrMes := EmptyStr;
      strEquipamentosVlrRep := EmptyStr;

      FObjContrato.Itens[intCnt].pCarregarDadosDocEnvio;
      blnImprimirNF := Not fEmptyStr(FObjContrato.Itens[intCnt].strDocEnv);

      strTextoNF := 'Nota Fiscal: ' + FObjContrato.Itens[intCnt].strDocEnv + ' / ' +
                                      IIF(FObjContrato.Itens[intCnt].RecEnv.dtaEnv > 0, DateTimeToStr(FObjContrato.Itens[intCnt].RecEnv.dtaEnv) + ' / ', '') +
                                      'R$ ' + FormatFloat('#,##0.00', FObjContrato.Itens[intCnt].RecEnv.fltVlr);
      strTextoCT := 'N° Contrato: ' + FObjContrato.NroContrato + ' - ' +
                                                    'R$ ' + FormatFloat('#,##0.00', FObjContrato.ValorTotalContrato);

      strEquipamentosInf := strEquipamentosInf +(IIF(blnImprimirNF, strTextoNF, strTextoCt)) + #13;
      strEquipamentosInf := strEquipamentosInf +('Ordem de Compra: ' + FObjContrato.NumPedCom) + #13;
      strEquipamentosInf := strEquipamentosInf +('Obra: ' + FObjContrato.strEnderecoObra);
      strEquipamentosDes := strEquipamentosDes +('Número de série: ' + FObjContrato.Itens[intCnt].Equipamento.NumSerie)+ #13;
      strEquipamentosDes := strEquipamentosDes +('Especificação do equipamento: ' + FObjContrato.Itens[intCnt].Equipamento.Descricao);

      fltVlrDia := 0;
      fltVlrSem := 0;
      fltVlrQui := 0;
      fltVlrMes := 0;
      For intCont:= 0 To FObjContrato.Itens[intCnt].Equipamento.Diarias.Count-1 Do
      Begin
        Case FObjContrato.Itens[intCnt].Equipamento.Diarias[intCont].QuantidadeDias Of
          1 : fltVlrDia := FObjContrato.Itens[intCnt].Equipamento.Diarias[intCont].ValorTotal;
          7 : fltVlrSem := FObjContrato.Itens[intCnt].Equipamento.Diarias[intCont].ValorTotal;
          15: fltVlrQui := FObjContrato.Itens[intCnt].Equipamento.Diarias[intCont].ValorTotal;
          30: fltVlrMes := FObjContrato.Itens[intCnt].Equipamento.Diarias[intCont].ValorTotal;
        End;
      End;

      fltVlrDia := IIF(fltVlrDia <= 0, FObjContrato.Itens[intCnt].Equipamento.ValorLocacaoDiaria, 0);

      strAux := AnsiLowerCase(fRetExtensoNumero(FloatToStr(fltVlrDia)));
      strAux := Copy(strAux, 0, Length(strAux)-6);
      strEquipamentosVlrDia := strEquipamentosVlrDia +('Valor diário: R$ ' + FormatFloat('#,##0.00', fltVlrDia) + ' (' + strAux + ' reais)');

      fltVlrSem := IIF(fltVlrSem <= 0, FObjContrato.Itens[intCnt].Equipamento.ValorLocacaoDiaria * 7, 0);
      strAux := AnsiLowerCase(fRetExtensoNumero(FloatToStr(fltVlrSem)));
      strAux := Copy(strAux, 0, Length(strAux)-6);
      strEquipamentosVlrSem := strEquipamentosVlrSem +('Valor Semanal: R$ ' + FormatFloat('#,##0.00', fltVlrSem) + ' (' + strAux + ' reais)');

      fltVlrQui := IIF(fltVlrQui <= 0, FObjContrato.Itens[intCnt].Equipamento.ValorLocacaoDiaria * 15, 0);
      strAux := AnsiLowerCase(fRetExtensoNumero(FloatToStr(fltVlrQui)));
      strAux := Copy(strAux, 0, Length(strAux)-6);
      strEquipamentosVlrQui := strEquipamentosVlrQui +('Valor Quinzenal: R$ ' + FormatFloat('#,##0.00', fltVlrQui) + ' (' + strAux + ' reais)');

      fltVlrMes := IIF(fltVlrMes <= 0, FObjContrato.Itens[intCnt].Equipamento.ValorLocacaoDiaria * 30, 0);
      strAux := AnsiLowerCase(fRetExtensoNumero(FloatToStr(fltVlrMes)));
      strAux := Copy(strAux, 0, Length(strAux)-6);
      strEquipamentosVlrMes := strEquipamentosVlrMes +('Valor Mensal: R$ ' + FormatFloat('#,##0.00', fltVlrMes) + ' (' + strAux + ' reais)');

      blnImprimirReposicao := (fltVlrDia > 0) or
                              (fltVlrSem > 0) or
                              (fltVlrQui > 0) or
                              (fltVlrMes > 0);

      strEquipamentosVlrRep := IIF(blnImprimirReposicao, strEquipamentosVlrRep +('Valor de reposição: R$ ' + FormatFloat('#,##0.00', FObjContrato.Itens[intCnt].Equipamento.ValorCaucao)), '') + #13;

      pAdicionarTextoVariavel('EQU_INFOR_'+ IntToStr(intCnt), strEquipamentosInf);
      pAdicionarTextoVariavel('EQU_DESCR_'+ IntToStr(intCnt), strEquipamentosDes);
      pAdicionarTextoVariavel('EQU_DIARI_'+ IntToStr(intCnt), strEquipamentosVlrDia);
      pAdicionarTextoVariavel('EQU_SEMAN_'+ IntToStr(intCnt), strEquipamentosVlrSem);
      pAdicionarTextoVariavel('EQU_QUINZ_'+ IntToStr(intCnt), strEquipamentosVlrQui);
      pAdicionarTextoVariavel('EQU_MENSA_'+ IntToStr(intCnt), strEquipamentosVlrMes);
      pAdicionarTextoVariavel('EQU_REPOS_'+ IntToStr(intCnt), IIF(blnImprimirReposicao, strEquipamentosVlrRep, ''));
    End;

  Finally
    FObjWord.pSalvar;
  End;
end;

procedure TImpressaoLocacao.pInserirDadosResponsaveis;
var
  intCnt: Integer;
  strAux: String;
begin
  For intCnt := 0 To FObjContrato.Responsavel.Count-1 Do
  Begin
    strAux := '{{CONTATO_CARGO_'+ intToStr(intCnt +1)+'}}';
    FObjWord.pReplace(strAux, FObjContrato.Responsavel[intCnt].strNomCgo);
    strAux := '{{CONTATO_NOME_'+ intToStr(intCnt +1)+'}}';
    FObjWord.pReplace(strAux, FObjContrato.Responsavel[intCnt].strNomCtt);
    strAux := '{{CONTATO_CPF_'+ intToStr(intCnt +1)+'}}';
    FObjWord.pReplace(strAux, FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), FObjContrato.Responsavel[intCnt].strCpfCtt));
    strAux := '{{CONTATO_RG_'+ intToStr(intCnt +1)+'}}';
    FObjWord.pReplace(strAux, FObjContrato.Responsavel[intCnt].strRg_Ctt);
  End;

  If FObjContrato.Responsavel.Count = 1 Then
  Begin
    FObjWord.pReplace('{{CONTATO_CARGO_2}}', '');
    FObjWord.pReplace('{{CONTATO_NOME_2}}', '');
    FObjWord.pReplace('{{CONTATO_CPF_2}}', '');
    FObjWord.pReplace('{{CONTATO_RG_2}}', '');
  End;
end;

function TImpressaoLocacao.fSubsituiCaracterQuebraLinha(
  const strTexto: String): String;
var
  blnFinalizou: Boolean;
  strTmp_,
  strAux_,
  strAix2: String;
  intPos: Integer;
begin
  strAux_ := strTexto;
  repeat
    intPos := Pos('<<csq>>', strAux_);
    blnFinalizou := (intPos <= 0);

    strTmp_ := strAux_;
    strAux_ := Copy(strTmp_, 0, intPos-1) + #13;
    strAix2 := Copy(strTmp_, intPos+7, Length(strTmp_));
    strAux_ := strAux_ + strAix2;

  until blnFinalizou;

  Result := strAux_;
end;

procedure TImpressaoLocacao.pInserirTextoEspecificacaoEquipamentos;
var
  intCnt: Integer;
  strEspecificacoes: String;
  strTmp: String;
begin
  strEspecificacoes := EmptyStr;
  For intCnt := 0 to FObjContrato.Itens.Count-1 Do
  Begin
    strTmp := fSubsituiCaracterQuebraLinha(FObjContrato.Itens[intCnt].Equipamento.Especificacao);

    strEspecificacoes := strEspecificacoes +
                         FObjContrato.Itens[intCnt].Equipamento.Codigo + ' - ' +
                         FObjContrato.Itens[intCnt].Equipamento.Descricao + ': ' +
                         strTmp + #13#13;
  End;

  pAdicionarTextoVariavel(cstIMP_ESFEQU, strEspecificacoes)
end;

procedure TImpressaoLocacao.pLimpaArquivosTemporarios;
var
  srcRec: TSearchrec;
  intCnt: Integer;
  strAux: String;
  slListaArq: TStringList;
begin
  strAux := IncludeTrailingBackslash(FstrPasta);
  slListaArq := TStringList.Create;
  Try
    If (SysUtils.FindFirst(strAux + '*.*', faAnyFile, srcRec) = 0) Then
    Begin
      repeat
        slListaArq.Add(srcRec.Name);
      until SysUtils.FindNext(srcRec) <> 0;
    End;

    For intCnt:=0 To slListaArq.Count-1 Do
    Begin
      If Pos('~lock.', slListaArq[intCnt]) > 0 Then
      Begin
        DeleteFile(strAux + slListaArq[intCnt]);
      End;
    End;
  Finally
    SysUtils.FindClose(srcRec);
    FreeAndNil(slListaArq);
  End;
end;

procedure TImpressaoLocacao.setNomArqDes(const AValue: String);
begin
  FstrNomDes := AValue;
end;

procedure TImpressaoLocacao.setObjCtr(
  const AValue: TContratoLocacaoEquipamentos);
begin
  FObjContrato := AValue;
end;

procedure TImpressaoLocacao.pInsereTabelaAcessorios;
var
  intLinha: Integer;
  intCnt,
  intCont: Integer;
  intQtdAce: Integer;
Begin

  intQtdAce := 0;
  For intCnt := 0 to FObjContrato.Itens.Count-1 Do
  Begin
    intQtdAce := intQtdAce + FObjContrato.Itens[intCnt].Equipamento.Acessorios.Count;
  End;

  If intQtdAce <= 0 Then
  Begin
    FObjWord.pReplace('{{ACESSORIOS}}', EmptyStr);
    Exit;
  End;

  FObjWord.pCriaTabela('{{ACESSORIOS}}', intQtdAce + 1, 4);

  If Not FObjWord.blnTabelaCriada Then
    Exit;

  intLinha := 1;
  FObjWord.pCelulaNegrito(intLinha, 1);
  FObjWord.pCelulaEscreve(intLinha, 1, 'CÓDIGO');

  FObjWord.pCelulaNegrito(intLinha, 2);
  FObjWord.pCelulaEscreve(intLinha, 2, 'DESCRIÇÃO');

  FObjWord.pCelulaNegrito(intLinha, 3);
  FObjWord.pCelulaAlignRight(intLinha, 3);
  FObjWord.pCelulaEscreve(intLinha, 3, 'QUANTIDADE');

  FObjWord.pCelulaNegrito(intLinha, 4);
  FObjWord.pCelulaAlignRight(intLinha, 4);
  FObjWord.pCelulaEscreve(intLinha, 4, 'VL. ACESSÓRIO');

  For intCnt := 0 to FObjContrato.Itens.Count-1 Do
  Begin
    For intCont := 0 to FObjContrato.Itens[intCnt].Equipamento.Acessorios.Count-1 Do
    Begin
      Inc(intLinha);

      FObjWord.pCelulaEscreve(intLinha, 1, FObjContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Acessorio.Codigo);
      FObjWord.pCelulaEscreve(intLinha, 2, FObjContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Acessorio.Descricao);
      FObjWord.pCelulaAlignRight(intLinha, 3);
      FObjWord.pCelulaEscreve(intLinha, 3, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Quantidade * FObjContrato.Itens[intCnt].Quantidade));
      FObjWord.pCelulaAlignRight(intLinha, 4);
      FObjWord.pCelulaEscreve(intLinha, 4, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Acessorio.ValorAqu * FObjContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Quantidade));
    End;
  End;

  FObjWord.pOtimizaTamanho(1, 4, 65);
  FObjWord.pOtimizaTamanho(1, 3, 65);
  FObjWord.pOtimizaTamanho(1, 2, 250);
  FObjWord.pOtimizaTamanho(1, 1, 65);
End;

procedure TImpressaoLocacao.pInsereTabelaEquipamentos;
var
  intLinha: Integer;
  intCnt: Integer;
  strAux: String;
Begin

  FObjWord.pCriaTabela('{{EQUIPAMENTOS}}', FObjContrato.Itens.Count + 1, 11);
  If Not FObjWord.blnTabelaCriada Then
    Exit;

  intLinha := 1;

  FObjWord.pCelulaNegrito(intLinha, 1);
  FObjWord.pCelulaEscreve(intLinha, 1, 'CÓDIGO');

  FObjWord.pCelulaNegrito(intLinha, 2);
  FObjWord.pCelulaEscreve(intLinha, 2, 'DESCRIÇÃO');

  FObjWord.pCelulaNegrito(intLinha, 3);
  FObjWord.pCelulaEscreve(intLinha, 3, 'NÚM. SÉRIE');

  FObjWord.pCelulaNegrito(intLinha, 4);
  FObjWord.pCelulaEscreve(intLinha, 4, 'CONTRATADO');

  FObjWord.pCelulaNegrito(intLinha, 5);
  FObjWord.pCelulaAlignRight(intLinha, 5);
  If FObjContrato.TipoDuracaoContrato = 'M' Then
  Begin
    FObjWord.pCelulaEscreve(intLinha, 5, 'TOTAL DE MESES');
  End
  Else
  Begin
    FObjWord.pCelulaEscreve(intLinha, 5, 'TOTAL DE DIÁRIAS/HORAS');
  End;

  FObjWord.pCelulaNegrito(intLinha, 6);
  FObjWord.pCelulaAlignRight(intLinha, 6);
  FObjWord.pCelulaEscreve(intLinha, 6, 'VALOR ' + FobjContrato.fRetornastrDescriDuracaoCtr(False));

  FObjWord.pCelulaNegrito(intLinha, 7);
  FObjWord.pCelulaAlignRight(intLinha, 7);
  FObjWord.pCelulaEscreve(intLinha, 7, 'VALOR TOTAL');

  FObjWord.pCelulaNegrito(intLinha, 8);
  FObjWord.pCelulaAlignRight(intLinha, 8);
  FObjWord.pCelulaEscreve(intLinha, 8, 'VALOR LÍQU.');

  FObjWord.pCelulaNegrito(intLinha, 9);
  FObjWord.pCelulaAlignRight(intLinha, 9);
  FObjWord.pCelulaEscreve(intLinha, 9, 'TOTAL LÍQU.');

  FObjWord.pCelulaNegrito(intLinha, 10);
  FObjWord.pCelulaAlignRight(intLinha, 10);
  FObjWord.pCelulaEscreve(intLinha, 10, 'VL. CAUÇÃO.');

  FObjWord.pCelulaNegrito(intLinha, 11);
  FObjWord.pCelulaAlignRight(intLinha, 11);
  FObjWord.pCelulaEscreve(intLinha, 11, 'VL. EQUIPAMENTO');

  For intCnt:= 0 To FObjContrato.Itens.Count-1 Do
  Begin
    inc(intLinha);
    FObjWord.pCelulaEscreve(intLinha, 1, FObjContrato.Itens[intCnt].Equipamento.Codigo);
    FObjWord.pCelulaEscreve(intLinha, 2, FObjContrato.Itens[intCnt].Equipamento.Descricao);
    FObjWord.pCelulaEscreve(intLinha, 3, FObjContrato.Itens[intCnt].Equipamento.NumSerie);

    strAux := arrDescTpCalculoVlLocacao[FObjContrato.Itens[intCnt].TipoCalculoLocacao];
    FObjWord.pCelulaEscreve(intLinha, 4,  strAux);
    FObjWord.pCelulaAlignRight(intLinha, 5);
    Case FObjContrato.Itens[intCnt].TipoCalculoLocacao Of
      tpDiaria : FObjWord.pCelulaEscreve(intLinha, 5, FormatFloat('#,##0.00',FObjContrato.TotalDias));
      tpHoras  : FObjWord.pCelulaEscreve(intLinha, 5, FormatFloat('#,##0.00',FObjContrato.TotalHoras));
      tpMensal : FObjWord.pCelulaEscreve(intLinha, 5, FormatFloat('#,##0.00',FObjContrato.TotalMeses));
    End;
    FObjWord.pCelulaAlignRight(intLinha, 6);
    FObjWord.pCelulaEscreve(intLinha, 6, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].ValorLocacaoContratado));
    FObjWord.pCelulaAlignRight(intLinha, 7);
    FObjWord.pCelulaEscreve(intLinha, 7, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].ValorTotalLocacaoContratado));
    FObjWord.pCelulaEscreve(intLinha, 8, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].ValorLocacaoLiquido));
    FObjWord.pCelulaAlignRight(intLinha, 8);
    FObjWord.pCelulaEscreve(intLinha, 9, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].ValorTotalLiquido));
    FObjWord.pCelulaAlignRight(intLinha, 9);
    FObjWord.pCelulaEscreve(intLinha, 10, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].Equipamento.ValorCaucao));
    FObjWord.pCelulaAlignRight(intLinha, 10);
    FObjWord.pCelulaEscreve(intLinha, 11, FormatFloat('#,##0.00',FObjContrato.Itens[intCnt].Equipamento.ValorAqu));
    FObjWord.pCelulaAlignRight(intLinha, 11);
  End;

  FObjWord.pOtimizaTamanho(1, 11, 40);
  FObjWord.pOtimizaTamanho(1, 10, 40);
  FObjWord.pOtimizaTamanho(1, 9, 40);
  FObjWord.pOtimizaTamanho(1, 8, 40);
  FObjWord.pOtimizaTamanho(1, 7, 40);
  FObjWord.pOtimizaTamanho(1, 6, 40);
  FObjWord.pOtimizaTamanho(1, 5, 40);
  FObjWord.pOtimizaTamanho(1, 4, 40);
  FObjWord.pOtimizaTamanho(1, 3, 65);
  FObjWord.pOtimizaTamanho(1, 2, 100);
  FObjWord.pOtimizaTamanho(1, 1, 40);
End;

class function TImpressaoLocacao.fRetornaDiretorioPadraoContratos: String;
var
  strDirModeloImp: String;
begin
  strDirModeloImp := ExtractFilePath(Application.ExeName) +  'ModelosRelatoriosClientes\Modelos_Locacao_Equipamentos\';
  If Not DirectoryExists(strDirModeloImp) Then
    CreateDir(strDirModeloImp);

  Result := strDirModeloImp;
end;

class function TImpressaoLocacao.fRetornaModeloImpressao(const strStatus: String; const ablnProrrogacao: Boolean = False): String;
var
  strNomOri: String;
  strDirModeloImp: String;
  strDirPadrao: String;
  strNomModeloDoc: String;
begin
  strDirPadrao := ExtractFilePath(Application.ExeName);
  strDirModeloImp := fRetornaDiretorioPadraoContratos;

  If ablnProrrogacao Then
  Begin
    strNomModeloDoc := 'CONTRATO_PRORROGACAO_LOCACAO_EQUIPAMENTOS.DOC';
  End
  Else
  Begin
    If strStatus = 'O' Then
      strNomModeloDoc := 'ORCAMENTO_LOCACAO_EQUIPAMENTOS.DOC'
    Else
      strNomModeloDoc := 'CONTRATO_LOCACAO_EQUIPAMENTOS.DOC';
  End;

  strNomOri := strDirModeloImp + strNomModeloDoc;
  If Not FileExists(strNomOri) Then
  Begin
    strNomOri := strDirPadrao + strNomModeloDoc;
    If Not FileExists(strNomOri) Then
      strNomOri := strDirPadrao + 'CONTRATO_LOCACAO_EQUIPAMENTOS.DOC';
  End;

  Result := strNomOri;
end;

function TImpressaoLocacao.getMsgRetorno: String;
begin
  Result := FMensagemRetorno;
end;

function TImpressaoLocacao.getNomArqDes: String;
begin
  Result := FstrNomDes;
end;

function TImpressaoLocacao.getObjCtr: TContratoLocacaoEquipamentos;
begin
  Result := FObjContrato;
end;

{ TRetornoContrato }

constructor TRetornoContrato.Create;
begin
  FObjCtr := TContratoLocacaoEquipamentos.Create;
  FObjCtrNF := TNotaFiscalContratoLocacao.Create(FObjCtr, 'OE');
  FSlMensagemRetorno := TStringList.Create;
  FSlMensagemRetornoOk := TStringList.Create;
  FobjEndEnt  := TEnderecoEntrega.Create(Nil);
  FValida := TValidarContrato.Create(FObjCtr);

  FCodCli := fCfgSis('CLIGOS', varString);
  FCodCnd := fCfgSis('CNDGOS', varString);

end;

destructor TRetornoContrato.Destroy;
begin

  inherited;

  FreeAndNil(FObjCtrNF);
  FreeAndNil(FObjCtr);
  FreeAndNil(FSlMensagemRetorno);
  FreeAndNil(FSlMensagemRetornoOk);
  FreeAndNil(FobjEndEnt);
  FreeAndNil(FValida);
end;

function TRetornoContrato.getObjCtr: TContratoLocacaoEquipamentos;
begin
  Result := FObjCtr;
end;

function TRetornoContrato.getObjNota: TNotaFiscalContratoLocacao;
begin
  Result := FObjCtrNF;
end;

function TRetornoContrato.GetstrMsgRet: String;
begin
  Result := FSlMensagemRetorno.Text;
end;

function TRetornoContrato.GetstrMsgRetOk: String;
begin
  Result := FSlMensagemRetornoOk.Text;
end;

procedure TRetornoContrato.setObjCtr(const Value: TContratoLocacaoEquipamentos);
begin
  FObjCtr := Value;
end;

procedure TRetornoContrato.setObjNota(
  const Value: TNotaFiscalContratoLocacao);
begin
  FObjCtrNF := Value;
end;

procedure TRetornoContrato.pAtualizaOSContrato(const strAutInc: String; strCodEmp, strNumOS: String);
Var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Add('UPDATE EQLDET                    ');
    qryUpdate.SQL.Add('  SET EQD_EMP_OS  = :EMP_OS,     ');
    qryUpdate.SQL.Add('  EQD_NUM_OS = :NUM_OS           ');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTINC       ');
    qryUpdate.ParamByName('AUTINC').AsString := strAutInc;
    qryUpdate.ParamByName('EMP_OS').AsString := strCodEmp;
    qryUpdate.ParamByName('NUM_OS').AsString := strNumOS;

    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TRetornoContrato.pCarregarEntGer;
begin
  FobjEndEnt.recEndere.strCodCli := FCodCli;
  FobjEndEnt.recEndere.strIncrem := '';
  FobjEndEnt.recEndere.strEndEnt := '';
  FobjEndEnt.recEndere.strBaiEnt := '';
  FobjEndEnt.recEndere.strCepEnt := '';
  FobjEndEnt.recEndere.strCodCid := '';
  FobjEndEnt.recEndere.strCidEnt := '';
  FobjEndEnt.recEndere.strNomCid := '';
  FobjEndEnt.recEndere.strTelEnt := '';

  FobjEndEnt.fSelecionaEnderecoEntrega(FCodCli);
end;

Class function TRetornoContrato.fValidaPodeProcessarOSContrato: Boolean;
begin
  Result := fCfgSis('RETGOS', varBoolean);

  If (Result) And
     (fEmptyStr(fCfgSis('CLIGOS', varString)) Or
      fEmptyStr(fCfgSis('CNDGOS', varString))) Then
  Begin
    fMensagem('ATENÇÃO', 'Configurado para gerar Ordem de Serviço no retorno do Equipamento, ' +
                         'preencher as configurações [CFG_CLIGOS] e [CFG_CNDGOS] para emitir o retorno!', ['&Ok']);
    Exit(False);
  End;

end;

procedure TRetornoContrato.pProcessarOSContrato;
var
  intCnt: Integer;
  objConEqu: TConEqu;
begin
  FSlMensagemRetorno.Clear;
  FSlMensagemRetornoOk.Clear;

  If Not fValidaPodeProcessarOSContrato Then
    Exit;

  pCarregarEntGer;

  fStartTransaction;

  Try
    For intCnt := 0 To FObjCtrNF.Itens.Count-1 Do
    Begin

      If fEmptyStr(FObjCtrNF.Itens[intCnt].ItemContrato.Equipamento.CodEquipamentoOS) Then
      Begin
        FSlMensagemRetorno.Add('');
        FSlMensagemRetorno.Add('Não foi definido o código do equipamento para OS para o equipamento de locação: ');
        FSlMensagemRetorno.Add(FObjCtrNF.Itens[intCnt].ItemContrato.Equipamento.Codigo + ' - ' +
                               FObjCtrNF.Itens[intCnt].ItemContrato.Equipamento.Descricao);
        continue;
      End;

      objConEqu := TConEqu.Create(Nil);
      Try
        objConEqu.pCarregarCliente(Nil, FCodCli, True);
        objConEqu.strOperac := 'I';
        objConEqu.strCodEmp := VS_strCodEmp;
        objConEqu.strEmpSer := VS_strCodEmp;
        objConEqu.strDtaEnt := DateTimeToStr(VS_Date);
        objConEqu.strHorEnt := TimeToStr(fNow);
        objConEqu.strEntGer := FobjEndEnt.recEndere.strIncrem;
        objConEqu.strPrevis := DateTimeToStr(VS_Date);
        objConEqu.strGarant := 'N';
        objConEqu.strCodDig := strLoginUsuarioLogado;
        objConEqu.strCodCli := FCodCli;
        objConEqu.strCodCnd := FCodCnd;
        objConEqu.strConPag := fRetConPag(FCodCnd);
        objConEqu.strCodFpg := fRetCodFpg(FCodCnd);
        objConEqu.strCodVen := strLoginUsuarioLogado;
        objConEqu.strCodEqu := FObjCtrNF.Itens[intCnt].ItemContrato.Equipamento.CodEquipamentoOS;
        objConEqu.strNumPat := FObjCtrNF.Itens[intCnt].ItemContrato.Equipamento.NumPatrimonio;
        objConEqu.strObsGer := 'Contrato ' + FObjCtrNF.Itens[intCnt].ItemContrato.Contrato.NroContrato + ' ' +
                               'Equip. ' + FObjCtrNF.Itens[intCnt].ItemContrato.Equipamento.Codigo + ' - ' +
                               'Inspeção: ' + FObjCtrNF.Itens[intCnt].ItemContrato.strInspecaoEntrada + ' ';
        objConEqu.strStatus := 'E';
        objConEqu.strSubSta := 'O';
        objConEqu.strFlxFas := 'A';
        objConEqu.strFlxSit := 'OI';
        objConEqu.strFlxCom := 'AT';

        If objConEqu.fGravaEquGer() Then
        Begin
          If fEmptyStr(FSlMensagemRetornoOk.Text) Then
          Begin
            FSlMensagemRetornoOk.Add('Ordem de Serviço gerada(s):');
          End;
          FSlMensagemRetornoOk.Add('OS - ' + objConEqu.strNumero);

          pAtualizaOSContrato(FObjCtrNF.Itens[intCnt].ItemContrato.AutInc,VS_strCodEmp, objConEqu.strNumero);

          FObjCtrNF.Itens[intCnt].ItemContrato.fBloquearCadastroEquipamento;

          objConEqu.pGravarLogSta(strLoginUsuarioLogado,
                                  objConEqu.strStaAnt,
                                  objConEqu.strStatus + objConEqu.strSubSta,
                                  objConEqu.strNumero,
                                  objConEqu.strCodDig);

          objConEqu.pGravarLogFlx(False);

          pGeraLogLiberacao(objConequ.strNumero, 'OS', objConEqu.strCodEmp);
        End
        Else
        Begin
          FSlMensagemRetorno.Add('');
          FSlMensagemRetorno.Add('Não foi possível gerar OS para o(s) equipamento(s): ');
          FSlMensagemRetorno.Add(FObjCtrNF.Itens[intCnt].ItemContrato.Equipamento.Codigo + ' - ' +
                                 FObjCtrNF.Itens[intCnt].ItemContrato.Equipamento.Descricao);
          FSlMensagemRetorno.Add('');
        End;

      Finally
        FreeAndNil(objConEqu);
      End;
    End;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TRetornoContrato.pProcessarOSContrato]');
    End;
  End;
end;

{ TValidarContrato }

constructor TValidarContrato.Create(aContrato: TContratoLocacaoEquipamentos);
begin
  FObjCtr := aContrato;
  FSlMensagemRetorno := TStringList.Create;
  FSlMensagemRetornoOk := TStringList.Create;
end;

destructor TValidarContrato.Destroy;
begin
  If Assigned(FSlMensagemRetorno) Then
    FreeAndNil(FSlMensagemRetorno);
  If Assigned(FSlMensagemRetornoOk) Then
    FreeAndNil(FSlMensagemRetornoOk);

  inherited;
end;

function TValidarContrato.fContratoPosssuiItensNaoEncerrados: Boolean;
var
  intCnt: Integer;
begin
  If Not Assigned(FObjCtr) Then
    Exit(False);

  Result := False;
  For intCnt := 0 to FObjCtr.Itens.Count-1 Do
  Begin
    If FObjCtr.Itens[intCnt].DataEncerramento <= 0 Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TValidarContrato.fContratoPossuiAdiantamento: Boolean;
Var
  qryAux: TUniQuery;
Begin

  If Not Assigned(FObjCtr) Then
    Exit(False);

  qryAux := fCriaQuery();
  Try
    qryAux.DisableControls;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  SUM((CASE WHEN ADT_TIPLAN = "D" THEN (-1 * ADT_VALLAN) ELSE ADT_VALLAN END)) AS VLRADT');
    qryAux.SQL.Add('FROM ADTCLI');
    qryAux.SQL.Add('  INNER JOIN FATGOR ON (ADT_CODEMP = FATGOR.FGO_CODEMP AND ADT_ESPDOC = FATGOR.FGO_ESPDOC AND FATGOR.FGO_NUMDOC = ADT_NUMDOC)');
    qryAux.SQL.Add('  INNER JOIN EXTGOR ON (EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM)');
    qryAux.SQL.Add('WHERE FATGOR.AUTOINCREM = :AUTINC ');
    qryAux.ParamByName('AUTINC').asString := FObjCtr.AutIncPedAdiantamento;
    qryAux.Open;
    Result := qryAux.FieldByName('VLRADT').AsFloat > 0;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;
End;

function TValidarContrato.fContratoPossuiInspecaoEntradaAberto: Boolean;
var
  intCnt: Integer;
  intQtdIpe: Integer;
Begin
  If Not Assigned(FObjCtr) Then
    Exit(False);

  intQtdIpe := 0;
  For intCnt:= 0 To FObjCtr.Itens.Count-1 Do
  Begin
    If (FObjCtr.Itens[intCnt].DataInspecaoEntrada > 0) Then
      Inc(intQtdIpe);
  End;
  Result := (intQtdIpe <> FObjCtr.Itens.Count);
End;

function TValidarContrato.fContratoPossuiInspecaoSaida(
  strSeqCon: String): Boolean;
Var
  qryAux: TUniQuery;
Begin
  If fEmptyStr(strSeqCon) Then
  Begin
    If Not Assigned(FObjCtr) Then
      Exit(False);

    strSeqCon := FObjCtr.AutInc;
  End;

  If fEmptyStr(strSeqCon) Then
    Exit(False);

  qryAux := fCriaQuery();
  Try
    qryAux.DisableControls;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  COUNT(*) AS QTD_IS ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  EQLDET ');
    qryAux.SQL.Add('WHERE EQD_SEQCON = :SEQCON ');
    qryAux.SQL.Add('  AND EQD_DTAIPS IS NOT NULL ');
    qryAux.SQL.Add('  AND EQD_OPEIPS IS NOT NULL ');
    qryAux.ParamByName('SEQCON').asString := strSeqCon;
    qryAux.Open;
    Result := qryAux.FieldByName('QTD_IS').asInteger > 0;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;
End;

function TValidarContrato.fContratoPossuiNFDeEnvio(strSeqCon: String): Boolean;
Var
  qryAux: TUniQuery;
Begin
  If fEmptyStr(strSeqCon) Then
    strSeqCon := FObjCtr.AutInc;

  If fEmptyStr(strSeqCon) Then
    Exit(False);

  qryAux := fCriaQuery();
  Try
    qryAux.DisableControls;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  COUNT(*) AS QTD_NF ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  EQLDET ');
    qryAux.SQL.Add('WHERE EQD_SEQCON = :SEQCON ');
    qryAux.SQL.Add('  AND EQD_NUMENV IS NOT NULL ');
    qryAux.SQL.Add('  AND EQD_ESPENV IS NOT NULL ');
    qryAux.ParamByName('SEQCON').asString := strSeqCon;
    qryAux.Open;
    Result := qryAux.FieldByName('QTD_NF').asInteger > 0;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;
End;

function TValidarContrato.fContratoPossuiNFDeRetorno(
  strSeqCon: String): Boolean;
Var
  qryAux: TUniQuery;
Begin
  If fEmptyStr(strSeqCon) Then
    strSeqCon := FObjCtr.AutInc;

  If fEmptyStr(strSeqCon) Then
    Exit(False);

  qryAux := fCriaQuery();
  Try
    qryAux.DisableControls;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  COUNT(*) AS QTD_NF ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  EQLDET ');
    qryAux.SQL.Add('WHERE EQD_SEQCON = :SEQCON ');
    qryAux.SQL.Add('  AND EQD_NUMRET IS NOT NULL ');
    qryAux.SQL.Add('  AND EQD_ESPRET IS NOT NULL ');
    qryAux.ParamByName('SEQCON').asString := strSeqCon;
    qryAux.Open;
    Result := qryAux.FieldByName('QTD_NF').asInteger > 0;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;
End;

function TValidarContrato.fContratoPossuiProrrogacao(
  const strSeqCon: String): Boolean;
Var
  qryAux: TUniQuery;
Begin
  qryAux := fCriaQuery();
  Try
    qryAux.DisableControls;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  COUNT(AUTOINCREM) AS QTD ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CONPRG ');
    qryAux.SQL.Add('WHERE PRG_SEQCON = :SEQCON ');
    qryAux.ParamByName('SEQCON').asString := strSeqCon;
    qryAux.Open;
    Result := qryAux.FieldByName('QTD').asInteger > 0;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;
End;

function TValidarContrato.fContratoPossuiValorFaturado: Boolean;
Var
  qryAux: TUniQuery;
Begin
  If Not Assigned(FObjCtr) Then
    Exit(False);

  qryAux := fCriaQuery();
  Try
    qryAux.DisableControls;
    qryAux.SQL.Add('SELECT                      ');
    qryAux.SQL.Add('  COUNT(AUTOINCREM) QTD     ');
    qryAux.SQL.Add('FROM EQLFAT                 ');
    qryAux.SQL.Add('WHERE EQF_SEQCON = :SEQCON  ');
    qryAux.ParamByName('SEQCON').asString := FObjCtr.AutInc;
    qryAux.Open;
    Result := qryAux.FieldByName('QTD').asInteger > 0;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;
End;

function TValidarContrato.fTemItemFaturado(strCodEmp, strEspSel, strNumDoc,
  strCodCli, strCodIte: String): Boolean;
Var
  qryAux: TUniQuery;
Begin
  If Not Assigned(FObjCtr) Then
    Exit(False);

  qryAux := fCriaQuery();
  Try
    qryAux.DisableControls;
    qryAux.SQL.Add('SELECT                      ');
    qryAux.SQL.Add('  COUNT(AUTOINCREM) QTD     ');
    qryAux.SQL.Add('FROM EQLFAT                 ');
    qryAux.SQL.Add('WHERE EQF_NUMDOC = :NUMDOC  ');
    qryAux.SQL.Add('  AND EQF_ESPDOC = :ESPDOC  ');
    qryAux.SQL.Add('  AND EQF_EMPDOC = :EMPDOC  ');
    qryAux.SQL.Add('  AND EQF_SEQEQL = :SEQEQL  ');
    qryAux.SQL.Add('  AND EQF_SEQCON = :SEQCON  ');
    qryAux.ParamByName('SEQCON').asString := FObjCtr.AutInc;
    qryAux.ParamByName('NUMDOC').asString := strNumDoc;
    qryAux.ParamByName('ESPDOC').asString := strEspSel;
    qryAux.ParamByName('EMPDOC').asString := strCodEmp;
    qryAux.ParamByName('SEQEQL').asString := strCodIte;
    qryAux.Open;
    Result := qryAux.FieldByName('QTD').asInteger > 0;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;
End;

function TValidarContrato.fPodeCancelarContrato: Boolean;
begin
  Result := True;

  If fEmptyStr(FObjCtr.AutInc) Then
    Exit;

  If FObjCtr.Status = 'A' Then
  Begin
    Result := Not(fContratoPossuiNFDeEnvio(FObjCtr.AutInc));

    If Result Then
      Result := Not(fContratoPossuiInspecaoSaida(FObjCtr.AutInc));

    If Result Then
      Result := Not(fContratoPossuiAdiantamento);
  End
  Else If (Pos(FObjCtr.Status, 'F_C_E_') > 0) Then
    Result := False;
end;

function TValidarContrato.fPodeEncerrarContrato(AValidarFaturamento: Boolean = True): Boolean;
begin
  FSlMensagemRetorno.Clear;

  If fEmptyStr(FObjCtr.AutInc) Then
  Begin
    FSlMensagemRetorno.Add('Contrato não carregado');
    Exit(False);
  End;

  If (Not (FObjCtr.Status = 'A')) Then
  Begin
    FSlMensagemRetorno.Add('Não é possível encerrar o contrato. O contrato não está ativo');
    Exit(False);
  End;

  Result := fContratoPossuiInspecaoSaida(FObjCtr.AutInc);
  If Not Result Then
  Begin
    FSlMensagemRetorno.Add('Não é possível encerrar o contrato. O contrato não possui inspeção de saída.');
    Exit(False);
  End;

  Result := (Not fContratoPossuiInspecaoEntradaAberto);
  If Not Result Then
  Begin
    FSlMensagemRetorno.Add('Não é possível encerrar o contrato. O contrato não possui inspeção de entrada.');
    Exit(False);
  End;

  Result := fContratoPossuiNFDeEnvio(FObjCtr.AutInc);
  If Not Result Then
  Begin
    FSlMensagemRetorno.Add('Não é possível encerrar o contrato. O contrato não possui nota de envio.');
    Exit(False);
  End;

  If fCfgSis('VALDRT', VarBoolean) Then
  Begin
    Result := fContratoPossuiNFDeRetorno(FObjCtr.AutInc);
    If Not Result Then
    Begin
      FSlMensagemRetorno.Add('Não é possível encerrar o contrato. O contrato não possui nota de retorno.');
      Exit(False);
    End;
  End;

  If AValidarFaturamento Then
  Begin
    Result := (Not(fCfgSis('ENCCTR', varBoolean))) And (Not fContratoPossuiValorFaturado);
    If Not Result Then
    Begin
      FSlMensagemRetorno.Add('Não é possível encerrar o contrato. O contrato possui faturamento.');
      Exit(False);
    End;
  End;
end;

function TValidarContrato.fRealizarProcessoLocacaoOutraEmpresa: Boolean;
begin
  Result := FObjCtr.fPermiteCarregarContratoOutraEmpresa And
            fVerificaAcessoSistema('PROEMP');
end;

function TValidarContrato.fValidaCondicaoPgtoTipoCliente: Boolean;
Var
  objLiberacao : TLiberacao;
  strTipCli: String;
begin

  If Not fCfgSis('CNDCLI', varBoolean) Then
    Exit(True);

  If Not fCfgSis('USATPC', varBoolean) Then
    Exit(True);

  strTipCli := fCampoTabela('CLI_TIPCLI','CADCLI', ['CLI_CODCLI'], [FObjCtr.CodCliente]);

  objLiberacao := TLiberacao.Create;
  try
    objLiberacao.objMsgLibera.pAddTexto('Condição de pagamento não permitida conforme o tipo do cliente');
    objLiberacao.objMsgLibera.pAddTextoCaption('Condição Pagamento',IIF(fCfgSis('USACND', varBoolean), FObjCtr.CodCondicaoPgto + '-' + fRetDesConPag(FObjCtr.CodCondicaoPgto) + ' ', '') + fFormataCondPag(fRetConPag(FObjCtr.CodCondicaoPgto)), 18);
    objLiberacao.objMsgLibera.pAddTextoCaption('Tipo de Cliente   ',strTipCli + '-' + fRetDescTipoCli(strTipCli), 18);

    if not fEmptyStr(FObjCtr.NroContrato) then
    begin
      objLiberacao.objMsgLibera.pAddTextoCaption('Contrato ', FObjCtr.NroContrato, 18);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento ', FloatToStrF(FObjCtr.ValorTotalContrato, ffNumber, 12, 2), 18);
    end;

    objLiberacao.strDirAce := 'CNDSEN';
    objLiberacao.strSenLib := fCfgSis('CNDSEN');
    objLiberacao.blnTraTel := True;
    objLiberacao.strMsgSen := 'Condição de pagamento não permitida conforme o tipo do cliente';
    objLiberacao.strCodOpe := IIF(fEmptyStr(FObjCtr.Vendedor.Codigo), strLoginUsuarioLogado, FObjCtr.Vendedor.Codigo);
    objLiberacao.strCliente := FObjCtr.Cliente.Codigo + '-' + FObjCtr.Cliente.NomeCliente;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
  end;
End;

function TValidarContrato.fValidarCondicaoPagamentoInformada: Boolean;
begin
  Result := True;

  If Not Assigned(FObjCtr) Then
    Exit(False);

  If fCfgSis('CPGCTR', VarBoolean) Then
  Begin
    Result := Not fEmptyStr(FObjCtr.CodCondicaoPgto);
  End;
end;

function TValidarContrato.fValidarItensEnviados: Boolean;
var
  intCont: Integer;
  intEquEnviado: Integer;
begin
  intEquEnviado := 0;
  For intCont := 0 to FObjCtr.Itens.Count-1 Do
  Begin
    If Not fEmptyStr(FObjCtr.Itens[intCont].NumEnv) Then
      Inc(intEquEnviado);
  End;

  Result := (intEquEnviado = FObjCtr.Itens.Count);
end;

function TValidarContrato.fVerificaContatoInseridoContrato(const strCodCli,
  strAutInc: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 To FObjCtr.Responsavel.Count-1 Do
  Begin
    If (FObjCtr.Responsavel[intCnt].strCodCli = strCodCli) And
       (FObjCtr.Responsavel[intCnt].strAutoincrem = strAutInc) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TValidarContrato.fVerificaInspecaoSaidaPendente(
  const aSeqEql: String): Boolean;
var
  qry: TUniQuery;
Begin
  Result := True;

  If Not Assigned(FObjCtr) Then
    Exit(False);

  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('SELECT COUNT(AUTOINCREM) AS QTDINSP_PENDENTE FROM EQLDET WHERE EQD_SEQCON = :EQD_SEQCON AND EQD_DTAIPS IS NULL AND EQD_SEQEQL = :EQD_SEQEQL');
    qry.ParamByName('EQD_SEQCON').AsString := FObjCtr.AutInc;
    qry.ParamByName('EQD_SEQEQL').AsString := aSeqEql;
    qry.Open;

    If Not qry.IsEmpty Then
    Begin
      Result := qry.FieldByName('QTDINSP_PENDENTE').AsInteger > 0;
    End;

  Finally
    pFreeAndNil(qry);
  End;
End;

function TValidarContrato.fVerificaPodeEncerrarItens: Boolean;
var
  intCnt: Integer;
begin
  FSlMensagemRetorno.Clear;

  Result := True;
  For intCnt := 0 To FObjCtr.Itens.Count-1 Do
  Begin
    If (FObjCtr.Itens[intCnt].blnEncerrarIte) And
       (FObjCtr.Itens[intCnt].DataInspecaoEntrada <= 0) Then
    Begin
      FSlMensagemRetorno.Add('O Equipamento "' + FObjCtr.Itens[intCnt].Equipamento.Codigo + ' - ' + FObjCtr.Itens[intCnt].Equipamento.Descricao + '" não possui inspeção de entrada.');
      Result := False;
      Break;
    End;
  End;
end;

function TValidarContrato.fVerificaPodeRealizarEnvio: Boolean;
begin
  Result := True;

  FSlMensagemRetorno.Clear;

  If fEmptyStr(FObjCtr.NroContrato) Then
  Begin
    FSlMensagemRetorno.Add('Contrato não encontrado!');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'O' Then
  Begin
    FSlMensagemRetorno.Add('Contrato não está ativo! Favor realizar a ativação do contrato antes do envio.');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'F' Then
  Begin
    FSlMensagemRetorno.Add('Contrato já faturado.');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'E' Then
  Begin
    FSlMensagemRetorno.Add('Contrato encerrado.');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'C' Then
  Begin
    FSlMensagemRetorno.Add('Contrato cancelado.');
    Result := False;
    Exit;
  End;
end;

function TValidarContrato.fVerificaPodeRealizarInspecao: Boolean;
begin
  FSlMensagemRetorno.Clear;
  Result := True;

  If FObjCtr.Status = 'O' Then
  Begin
    FSlMensagemRetorno.Add('Contrato não está ativo! Favor realizar a ativação do contrato antes da inspeção.');
    Exit(False);
  End;

  If FObjCtr.Status = 'F' Then
  Begin
    FSlMensagemRetorno.Add('Contrato já faturado.');
    Exit(False);
  End;

  If FObjCtr.Status = 'E' Then
  Begin
    FSlMensagemRetorno.Add('Contrato Encerrado.');
    Exit(False);
  End;

  If FObjCtr.Status = 'C' Then
  Begin
    FSlMensagemRetorno.Add('Contrato Cancelado');
    Exit(False);
  End;

end;

function TValidarContrato.fVerificaPodeRealizarInspecaoEntrada: Boolean;
begin
  Result := True;

  FSlMensagemRetorno.Clear;

  If Not fVerificaAcessoSistema('LOCIPE') Then
  Begin
    FSlMensagemRetorno.Text := 'Operador não possui acesso liberado para realizar a inspeção de Entrada!';
    Exit(False);
  End;

  If (FObjCtr.Emitente.Codigo <> VS_strCodEmp) And (Not fRealizarProcessoLocacaoOutraEmpresa) Then
  Begin
    FSlMensagemRetorno.Text := 'Operador não possui acesso liberado para realizar a inspeção de Entrada de contrato de outra empresa!';
    Exit(False);
  End;
end;

function TValidarContrato.fVerificaPodeRealizarInspecaoSaida: Boolean;
begin
  Result := True;

  FSlMensagemRetorno.Clear;

  If Not fVerificaAcessoSistema('LOCIPS') Then
  Begin
    FSlMensagemRetorno.Text := 'Operador não possui acesso liberado para realizar a inspeção de Saída!';
    Exit(False);
  End;

  If (FObjCtr.Emitente.Codigo <> VS_strCodEmp) And (Not fRealizarProcessoLocacaoOutraEmpresa) Then
  Begin
    FSlMensagemRetorno.Text := 'Operador não possui acesso liberado para realizar a inspeção de Saída de contrato de outra empresa!';
    Exit(False);
  End;
end;

function TValidarContrato.fVerificaPodeRealizarRetorno: Boolean;
begin
  Result := True;

  FSlMensagemRetorno.Clear;

  If fEmptyStr(FObjCtr.NroContrato) Then
  Begin
    FSlMensagemRetorno.Add('Contrato não encontrado!');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'O' Then
  Begin
    FSlMensagemRetorno.Add('Contrato não está ativo! Favor realizar a ativação do contrato antes do retorno.');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'F' Then
  Begin
    FSlMensagemRetorno.Add('Contrato já faturado.');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'E' Then
  Begin
    FSlMensagemRetorno.Add('Contrato encerrado.');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'C' Then
  Begin
    FSlMensagemRetorno.Add('Contrato cancelado.');
    Result := False;
    Exit;
  End;
end;

function TValidarContrato.fVerificaPodeRealizarTroca: Boolean;
begin
  Result := True;

  FSlMensagemRetorno.Clear;

  If fEmptyStr(FObjCtr.NroContrato) Then
  Begin
    FSlMensagemRetorno.Add('Contrato não encontrado!');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'O' Then
  Begin
    FSlMensagemRetorno.Add('Contrato não está ativo! ');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'F' Then
  Begin
    FSlMensagemRetorno.Add('Contrato já faturado.');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'E' Then
  Begin
    FSlMensagemRetorno.Add('Contrato encerrado.');
    Result := False;
    Exit;
  End;

  If FObjCtr.Status = 'C' Then
  Begin
    FSlMensagemRetorno.Add('Contrato cancelado.');
    Result := False;
    Exit;
  End;
end;

function TValidarContrato.getObjCtr: TContratoLocacaoEquipamentos;
begin
  Result := FObjCtr;
end;

function TValidarContrato.GetstrMsgRet: String;
begin
  Result := FSlMensagemRetorno.Text;
end;

function TValidarContrato.GetstrMsgRetOk: String;
begin
  Result := FSlMensagemRetornoOk.Text;
end;

procedure TValidarContrato.setObjCtr(const Value: TContratoLocacaoEquipamentos);
begin
  FObjCtr := Value;
end;

function TValidarContrato.ValidaLiberacaoEncerramentoContratoSemFaturamento: Boolean;
var
  objLib: TLiberacao;
begin
  objLib := TLiberacao.Create;
  Try
    objLib.Clear;
    objLib.strDirAce    := 'ENCCTR';
    objLib.strMsgSen    := 'Permitir encerrar contrato sem faturamento';
    objLib.strCodOpe    := strLoginUsuarioLogado;
    objLib.objMsgLibera.pAddTexto('Permitir encerrar contrato sem faturamento');
    objLib.objMsgLibera.pAddTexto('');
    objLib.objMsgLibera.pAddTexto('Contrato:' + FObjCtr.NroContrato);
    objLib.objMsgLibera.pAddTexto('Cliente:'  + FObjCtr.CodCliente + ' - ' + FObjCtr.NomCliente);

    Result := objLib.fLibera;
  Finally
    FreeAndNil(objLib);
  End;
end;

{ TImpressaoComprovanteContrato }

constructor TImpressaoComprovanteContrato.Create;
begin
  FSlMensagemRetorno := TStringList.Create;
  FSlMensagemRetornoOk := TStringList.Create;
end;

destructor TImpressaoComprovanteContrato.Destroy;
begin

  inherited;

  FreeAndNil(FSlMensagemRetorno);
  FreeAndNil(FSlMensagemRetornoOk);
end;

function TImpressaoComprovanteContrato.fImprimirComprovanteRetorno(
  const strNroCon, strEspDoc, strEmpDoc, strNumDoc: String): Boolean;
Var
  objImpressao: TEditorFastImpressao;
begin

  If Not fVerificaPodeImprimirRetorno Then
  Begin
    Exit(False);
  End;

  objImpressao := TEditorFastImpressao.Create(Nil);
  Try
    objImpressao.recDocume.strEspSel := 'DL';
    objImpressao.recDocume.strNroCon := strNroCon;
    objImpressao.recDocume.strEspDoc := strEspDoc;
    objImpressao.recDocume.strCodEmp := strEmpDoc;
    objImpressao.recDocume.strNumDoc := strNumDoc;
    objImpressao.recDocume.intQtdImp := fCfgSis('QTIMPR', varInteger);
    objImpressao.tpeTipoEtiqueta     := tpeDevolucaoLocacao;
    Result := objImpressao.fImprimeDocumento();

  Finally
    FreeAndNil(objImpressao);
  End;
end;

function TImpressaoComprovanteContrato.fVerificaPodeImprimirRetorno: Boolean;

begin
  FCodLayRetorno := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'],
                     [ARR_TIPO_LAYOUT[tpeDevolucaoLocacao], VS_strCodEmp, 'S']);

  If fEmptyStr(FCodLayRetorno) Then
  Begin
    FSlMensagemRetorno.Add('Não foi definido modelo para impressão. Utilize o editor de layout');
    Exit(False);
  End
  Else
    Result := True;

end;

function TImpressaoComprovanteContrato.GetstrMsgRet: String;
begin
  Result := FSlMensagemRetorno.Text;
end;

function TImpressaoComprovanteContrato.GetstrMsgRetOk: String;
begin
  Result := FSlMensagemRetornoOk.Text;
end;

end.

