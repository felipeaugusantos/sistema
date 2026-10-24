unit cadastro.Model.ContratoLocacaoEquipamentos;

interface

uses
  SysUtils, Classes, System.Generics.Collections, cadastro.Model.EquipamentoLocacao, untTypesLocEqu,
  Uni, Messages, Math, cadastro.Model.AcessorioLocacao, Forms, untTypesSistema, Data.DB,
  untCliCtt;

type

  TRecEnv = Record
    dtaEnv: TDateTime;
    fltVlr: Double;
  End;

  TItemContratoLocacaoEquipamentos = Class;
  TAcessorioContratoLocacaoEquipamentos = Class;

  TAdiantamentoContrato = Class
  private
    FNumDocAdt: String;
    FEspDocAdt: String;
    FEmpDocAdt: String;
    function GetEmpDoc: String;
    function GetEspDoc: String;
    function GetNumDoc: String;
    procedure SetEmpDoc(const AValue: String);
    procedure SetEspDoc(const AValue: String);
    procedure SetNumDoc(const AValue: String);
  public
    procedure pCarregar(Const strAutInc: String);

    property NumDocAdt: String read GetNumDoc write SetNumDoc;
    property EspDocAdt: String read GetEspDoc write SetEspDoc;
    property EmpDocAdt: String read GetEmpDoc write SetEmpDoc;
  End;

  TEmitenteContratoLocacao = Class
  private
    FEmtCGC: String;
    FCodEmp: String;
    FNomEmp: String;
    FEndere: String;
    FCodCid: String;
    FNomCid: String;
    FFone01: String;
    FNumFax: String;
    FBairro: String;
    FNumEnd: String;
    F_C_E_P: String;
    FEstado: String;
    F_I_E_S: String;

    function GetEmtCGC: String;
    procedure SetEmtCGC(const AValue: String);
    function GetCodEmp: String;
    function GetNomEmp: String;
    procedure SetCodEmp(const AValue: String);
    procedure SetNomEmp(const AValue: String);
    function GetCodCid: String;
    function GetEndEmp: String;
    function GetFone01: String;
    function GetNomCid: String;
    function GetNumFax: String;
    procedure SetCodCid(const AValue: String);
    procedure SetEndEmp(const AValue: String);
    procedure SetFone01(const AValue: String);
    procedure SetNomCid(const AValue: String);
    procedure SetNumFax(const AValue: String);
    function GetBairro: String;
    function GetCep: String;
    function GetEstado: String;
    function GetNumEnd: String;
    procedure SetBairro(const AValue: String);
    procedure SetCep(const AValue: String);
    procedure SetEstado(const AValue: String);
    procedure SetNumEnd(const AValue: String);
    function GetIES: String;
    procedure SetIES(const aValue: String);
  public
    procedure pCarregar(Const aCodEmp: String);

    property Codigo: String read GetCodEmp write SetCodEmp;
    property Nome: String read GetNomEmp write SetNomEmp;
    property Cnpj: String read GetEmtCGC write SetEmtCGC;

    property Endereco: String read GetEndEmp write SetEndEmp;
    property CodCidade: String read GetCodCid write SetCodCid;
    property NomCidade: String read GetNomCid write SetNomCid;
    property Fone01: String read GetFone01 write SetFone01;
    property Fax: String read GetNumFax write SetNumFax;
    property Bairro: String read GetBairro write SetBairro;
    property NumEnd: String read GetNumEnd write SetNumEnd;
    property Cep: String read GetCep write SetCep;
    property Estado: String read GetEstado write SetEstado;
    property InstricaoEstadual: String read GetIES write SetIES;
  End;

  TClienteContratoLocacao = Class
  private
    FCodCli,
    FNomCli,
    FCliFone01,
    FCliRamal1,
    FCliFone02,
    FCliRamal2,
    FCliNumFax,
    FCliRamal3,
    FCliTelCel,
    FCliNextel,
    FCliTelEnt: String;
    FNomCid: String;
    FEstado: String;
    FCliBairro:String;
    FCliEndereco: string;
    FCliCpfCnpj: String;
    FCliCep: String;
    FEmail_: String;
    FCliInscEst: String;
    FstrTipo_1: String;
    FNum_RG: String;
    FNomFan: String;

    function GetCodCli: String;
    function GetFone01: String;
    function GetFone02: String;
    function GetNomCli: String;
    function GetNumFax: String;
    function GetRamal1: String;
    function GetRamal2: String;
    function GetRamal3: String;
    function GetTelCel: String;
    function GetTelEnt: String;
    procedure SetCodCli(const AValue: String);
    procedure SetFone01(const AValue: String);
    procedure SetFone02(const AValue: String);
    procedure SetNomCli(const AValue: String);
    procedure SetnumFax(const AValue: String);
    procedure SetRamal1(const AValue: String);
    procedure SetRamal2(const AValue: String);
    procedure SetRamal3(const AValue: String);
    procedure SetTelCel(const AValue: String);
    procedure SetTelEnt(const AValue: String);
    procedure SetNextel(const AValue: String);
    function GetNextel: String;
    function GetNomCid: String;
    procedure SetNomCid(const AValue: String);
    function GetCli_UF: String;
    procedure SetCli_UF(const AValue: String);

    function fAdicionaMensagemTelefone(const strMensagem, strTelefone: String): String;
    function fFormataTelefoneMensagem(const strNroTel, strRamal: String): String;
    function GetCliBai: String;
    function GetCliCep: String;
    function GetCliDoc: String;
    procedure SetCliBai(const AValue: String);
    procedure SetCliCep(const AValue: String);
    procedure SetCliDoc(const AValue: String);
    function GetCliEnd: String;
    procedure SetCliEnd(const AValue: String);
    function GetEmail_: String;
    procedure SetEmail_(const AValue: String);
    function GetCliIes: String;
    procedure SetCliIes(const AValue: String);
    function GetTipo_1: String;
    procedure SetTipo_1(const AValue: String);
    function GetNum_Rg: String;
    procedure SetNum_Rg(const Value: String);
    function GetNomFan: String;
    procedure SetNomFan(const Value: String);
  public
    procedure pCarregar(Const aCodCli: String; const aSeqCon: String = '');
    procedure pLimpar;
    function fRetornaMensagemTelefone: String;

    property Codigo: String read GetCodCli write SetCodCli;
    property NomeCliente: String read GetNomCli write SetNomCli;
    property Fone01: String read GetFone01 write SetFone01;
    property Ramal1: String read GetRamal1 write SetRamal1;
    property Fone02: String read GetFone02 write SetFone02;
    property Ramal2: String read GetRamal2 write SetRamal2;
    property NumFax: String read GetNumFax write SetnumFax;
    property Ramal3: String read GetRamal3 write SetRamal3;
    property TelCel: String read GetTelCel write SetTelCel;
    property TelEnt: String read GetTelEnt write SetTelEnt;
    property Nextel: String read GetNextel write SetNextel;
    property NomCid: String read GetNomCid write SetNomCid;
    property Estado: String read GetCli_UF write SetCli_UF;
    property Bairro: String read GetCliBai write SetCliBai;
    property CpfCnpj: String read GetCliDoc write SetCliDoc;
    property Cep: String read GetCliCep write SetCliCep;
    property Endereco: String read GetCliEnd write SetCliEnd;
    property Email : String read GetEmail_ write SetEmail_;
    property InscEst: String read GetCliIes write SetCliIes;
    property strTipo: String read GetTipo_1 write SetTipo_1;
    property NumRG:   String read GetNum_Rg write SetNum_Rg;
    property NomeFantasia: String read GetNomFan write SetNomFan;
  End;

  TVendedorContratoLocacao = Class
  private
    FCodVen: String;
    FNomVen: String;
    FCpfVen: String;

    function GetCodVen: String;
    procedure SetCodVen(const AValue: String);
    function GetNomVen: String;
    procedure SetNomVen(const AValue: String);
    function GetCpfVen: String;
    procedure SetCpfVen(const AValue: String);
  public
    procedure pCarregar(const strCodigo: String);
    procedure pLimpar;

    property Codigo: String read GetCodVen write SetCodVen;
    property Nome: String read GetNomVen write SetNomVen;
    property strCpf: String read GetCpfVen write SetCpfVen;
  End;

  TContratoLocacaoEquipamentos = Class
  private
    FAutInc: String;
    FCodCli: String;
    FNomCli: String;
    FCodEmp: String;
    FDtaFin: TDateTime;
    FDtaIni: TDateTime;
    FDeclar: String;
    FEntCli: String;
    FHorFin: TDateTime;
    FHorIni: TDateTime;
    FNroCon: String;
    FQtdTEq: Double;
    FStatus: String;
    FTotCon: Double;
    FTotHor: Double;
    FTotDia: Integer;
    FTotMes: Integer;
    FConPag: String;
    FCodCnd: String;
    FCodFpg: String;
    FDesFpg: String;
    FAUT_PD: String;
    FEmitente: TEmitenteContratoLocacao;
    FCliente : TClienteContratoLocacao;
    FNumDoc: String;
    FblnInspecaoRealizada: Boolean;
    FListaItens: TList<TItemContratoLocacaoEquipamentos>;
    FValorTotalContrato: Double;
    FValorTotalCobranca: Double;
    FIndiceEquipamentoSelecionado: Integer;
    FSLMensagemRetorno : TStringList;
    FblnCarregarDadosCliente: Boolean;
    FblnCarregarDadosFaturamento: Boolean;
    FstrLoc: String;
    FTotalDiasEstimado: Double;
    FTotalHorasEstimadas: Double;
    FDataInicialEstimada,
    FDataFinalEstimada: TDateTime;
    FBlnProrrogacao: Boolean;
    FAdiantamento: TAdiantamentoContrato;
    FVlrTotAqu: Double;
    FVlTxEn: Double;
    FVlrTotLoc: Double;
    FTotalMesesEstimado: Integer;
    FTipDur: String;
    FMesIni: TDateTime;
    FMesFin: TDateTime;
    FstrMesIni: String;
    FstrMesFin: String;
    FListaResp: TList<TCliCtt>;
    FVendedor: TVendedorContratoLocacao;
    FPedCom: String;
    FstrEndObr: String;
    FVlrTotAdc: Double;
    FOpLocacao: TOperacaoLocacao;

    function GetAutInc: String;
    function GetCodCli: String;
    function GetCodEmp: String;
    function GetDtaFin: TDateTime;
    function GetDtaIni: TDateTime;
    function GetDeclar: String;
    function GetEntCli: String;
    function GetHorFin: TDateTime;
    function GetHorIni: TDateTime;
    function GetNroCon: String;
    function GetQtdEqu: Double;
    function GetStatus: String;
    function GetTotCon: Double;
    function GetTotHor: Double;
    procedure SetAutInc(const AValue: String);
    procedure SetCodCli(const AValue: String);
    procedure SetCodEmp(const AValue: String);
    procedure SetDtaFin(const AValue: TDateTime);
    procedure SetDtaIni(const AValue: TDateTime);
    procedure SetDeclar(const AValue: String);
    procedure SetEntCli(const AValue: String);
    procedure SetHorFin(const AValue: TDateTime);
    procedure SetHorIni(const AValue: TDateTime);
    procedure SetNroCon(const AValue: String);
    procedure SetQtdEqu(const AValue: Double);
    procedure SetStatus(const AValue: String);
    procedure SetTotCon(const AValue: Double);
    procedure SetTotHor(const AValue: Double);
    function GetTotDia: Integer;
    procedure SetTotDia(const AValue: Integer);
    function GetLItens: TList<TItemContratoLocacaoEquipamentos>;
    procedure SetLItens(const AValue: TList<TItemContratoLocacaoEquipamentos>);
    function GetVlrTot: Double;
    procedure SetVlrTot(const AValue: Double);
    function GetIndSel: Integer;
    procedure SetIndSel(const AValue: Integer);
    function GetNomCli: String;
    procedure SetNomCli(const AValue: String);
    function GetCodCnd: String;
    function GetCodFpg: String;
    function GetConPag: String;
    procedure SetCodCnd(const AValue: String);
    procedure SetCodFpg(const AValue: String);
    procedure SetConPag(const AValue: String);
    function GetAUT_PD: String;
    procedure SetAUT_PD(const AValue: String);
    function GetDesFpg: String;
    procedure SetDesFpg(const AValue: String);
    function GetEmitente: TEmitenteContratoLocacao;
    procedure SetEmitente(const AValue: TEmitenteContratoLocacao);
    function GetMsgRet: String;
    function GetDdoCli: Boolean;
    procedure SetDdoCli(const AValue: Boolean);
    function GetCliente: TClienteContratoLocacao;
    procedure SetCliente(const AValue: TClienteContratoLocacao);
    procedure SetNumDoc(const AValue: String);
    function GetNumDoc: String;
    function GetBlnIns: Boolean;
    procedure setBlnIns(const AValue: Boolean);
    function GetBlnFat: Boolean;
    procedure SetBlnFat(const AValue: Boolean);
    function GetStrLoc: String;
    function GetTotCob: Double;
    procedure SetTotCob(const AValue: Double);
    function GetTotDEst: Double;
    function GetTotHEst: Double;
    procedure SetTotDEst(const AValue: Double);
    procedure SetTotHEst(const AValue: Double);
    function GetDtFEst: TDateTime;
    function GetDtIEst: TDateTime;
    procedure SetDtFEst(const AValue: TDateTime);
    procedure SetDtIEst(const AValue: TDateTime);
    function GetBlnPrg: Boolean;
    procedure SetBlnPrg(const AValue: Boolean);

    function fVerificaInspecaoSaidaPendente(const aSeqEql: String): Boolean;
    procedure pConfirmarInspecaoSaida;
    procedure pConfirmarInspecaoEntrada;
    procedure pCarregarLocalizacao;
    function GetPedAdt: TAdiantamentoContrato;
    procedure SetPedAdt(const AValue: TAdiantamentoContrato);
    procedure SetTotAqu(const AValue: Double);
    function GetTotAqu: Double;
    function GetTaxEnt: Double;
    procedure SetTaxEnt(const AValue: Double);
    function GetVlrTotLoc: Double;
    procedure SetVlrTotLoc(const AValue: Double);
    function GetTotMes: Integer;
    procedure SetTotMes(const AValue: Integer);
    function GetTipDur: String;
    function GetStrMesFin: String;
    function GetStrMesIni: String;
    function GetMesFin: TDateTime;
    function GetMesIni: TDateTime;
    function GetTotMEst: Integer;
    procedure SetTotMEst(const AValue: Integer);
    procedure SetTipDur(const AValue: String);
    function fRetornaTipoDuracaoContrato: String;
    function GetLResp: TList<TCliCtt>;
    procedure SetLResp(const AValue: TList<TCliCtt>);
    function GetVendedor: TVendedorContratoLocacao;
    procedure SetVendedor(const Value: TVendedorContratoLocacao);
    function GetPedCom: String;
    procedure SetPedCom(const Value: String);
    function GetEndObr: String;
    procedure SetEndObr(const Value: String);

    procedure pAtualizarDataTerminoContrato;
    function fObtemDtaUltFat: TDateTime;
    function GetVlrTotAdc: Double;
    procedure SetVlrTotAdc(const AValue: Double);

  public
    constructor Create(opLocacao: TOperacaoLocacao = opNenhum);
    destructor Destroy; override;

    procedure pCalculaTotais;
    procedure pCalculaDuracaoContrato;
    procedure pRecalculaItensContrato;
    function fCarregarContrato(const strAutInc: String = ''; const strCodCon: String = '';
      ablnCarregarDadosCliente: Boolean = False; const strNumPed: String = ''): Boolean;
    procedure pCarregarItensContrato;
    procedure pCarregarResponsaveis;
    procedure pExcluirItens;
    procedure pExcluirAcessorios;
    procedure pExcluirResponsaveis;
    procedure pLimparItens;
    procedure pLimpar;
    procedure pCarregarDadosCliente;
    procedure pCarregarDadosEmitente;
    procedure pCarregarDuracaoContrato;
    procedure pCarregarDadosAdiantamento;
    procedure pAtualizarItensContrato;
    procedure pAtualizaTotalContrato;

    function fGravarResponsaveis: Boolean;

    function fRemoveItem(const strCodEql: String): Boolean;
    function fRemoveResponsavel(const strCodCli, strAutIncCtt: String): Boolean;
    function fAtivarContrato: Boolean;
    function fAlterarStatusContrato(const strStatus: String = ''; const tpStatus: TStatusContratoLocacao = stNone): Boolean;
    function fAddItem(const aItem: TItemContratoLocacaoEquipamentos = Nil): TItemContratoLocacaoEquipamentos;
    function fEquipamentoJaInseridoNesseContrato(const strCodEql: String): Boolean;
    function fCalculaDataFinalCobranca(const aDataInicial: TDateTime; aNumeroHoras: Double): TDateTime;
    function fRetornaItemContrato(const strCodEQL: String): TItemContratoLocacaoEquipamentos;
    function fRetornaItemAcessorioContrato(const strCodEql, strCodAcl: String): TAcessorioContratoLocacaoEquipamentos;
    function fValidarInspecaoSaidaEquipamentos(strCodEql: String = ''): Boolean;
    function fValidarInspecaoEntradaEquipamentos(strCodEql: String = ''): Boolean;
    function fValidarInspecao: Boolean;
    function fConfirmarInspecao: Boolean;
    function fAlterarDataTerminoContrato(aDataInicial: TDateTime; aDataFinal: TDateTime;
      aMesInicial: String = ''; aMesFinal: String = ''; blnAtualizaDB: Boolean = False): Boolean;

    function fValidarDatasContrato(aDataInicial, aDataFinal: TDateTime): Boolean;

    function fRetornastrDescriDuracaoCtr(const blnPlural: Boolean = True): String;
    function fAddResponsavel(const strCodCli, strAutInc: String): TCliCtt;
    function fValidaResponsaveisContrato: Boolean;
    function fPermiteCarregarContratoOutraEmpresa: Boolean;
    function fAtualizarPedidoAdiantamento(const strAutInc: String): Boolean;
    function fVerificaPedAdtGerado: Boolean;
    function fValidaPodeAtivarContrato: Boolean;
    function fValidarContratosVencidos: Boolean;
    procedure SugerirDataInicialContratoMensal(AMesIni, AMesFin: String);

    class  function fEquipamentoDisponivel(arrCodEql: TConsultasArray; strNumCont: String;
      blnForUpdate: Boolean = False; strDtaIni: String = ''; strHorIni: String = '';
      strDtaFin: String = ''; strHorFin: String = ''): Boolean; overload;
    class function fEquipamentoDisponivel(strCodEql: String; ObjContrato: TContratoLocacaoEquipamentos;
      blnForUpdate: Boolean = False ): Boolean; overload;

    property AutInc: String read GetAutInc write SetAutInc;
    property NroContrato: String read GetNroCon write SetNroCon;
    property Status: String read GetStatus write SetStatus;
    property CodCliente: String read GetCodCli write SetCodCli;
    property NomCliente: String read GetNomCli write SetNomCli;
    property EntCliente: String read GetEntCli write SetEntCli;
    property DataInicial: TDateTime read GetDtaIni write SetDtaIni;
    property DataFinal: TDateTime read GetDtaFin write SetDtaFin;
    property HoraInicial: TDateTime read GetHorIni write SetHorIni;
    property HoraFinal: TDateTime read GetHorFin write SetHorFin;
    property TotalHoras: Double read GetTotHor write SetTotHor;
    property TotalContrato: Double read GetTotCon write SetTotCon;
    property QuantidadeEquipamentos: Double read GetQtdEqu write SetQtdEqu;
    property CodigoEmpresa: String read GetCodEmp write SetCodEmp;
    property Declaracao: String read GetDeclar write SetDeclar;
    property TotalDias: Integer read GetTotDia write SetTotDia;
    property ValorTotalContrato: Double read GetVlrTot write SetVlrTot;
    property IndiceEquipamentoSelecionado: Integer read GetIndSel write SetIndSel;
    property CondicaoPgto: String read GetConPag write SetConPag;
    property CodCondicaoPgto: String read GetCodCnd write SetCodCnd;
    property CodFormaPgto: String read GetCodFpg write SetCodFpg;
    property DescricaoFormPgto: String read GetDesFpg write SetDesFpg;
    property AutIncPedAdiantamento: String read GetAUT_PD write SetAUT_PD;
    property Emitente: TEmitenteContratoLocacao read GetEmitente write SetEmitente;
    property MensagemRetorno: String read GetMsgRet;
    property blnCarregarDadosCliente: Boolean read GetDdoCli write SetDdoCli;
    property Cliente: TClienteContratoLocacao read GetCliente write SetCliente;
    property NumDocPedAdiantamento: String read GetNumDoc write SetNumDoc;
    property Itens: TList<TItemContratoLocacaoEquipamentos> read GetLItens write SetLItens;
    property blnInspecaoRealizada: Boolean read GetBlnIns write setBlnIns;
    property blnCarregarDadosFaturamento: Boolean read GetBlnFat write SetBlnFat;
    property Localizacao: String read GetStrLoc;
    property ValorTotalCobranca: Double read GetTotCob write SetTotCob;
    property TotalDiasEstimado: Double read GetTotDEst write SetTotDEst;
    property TotalHorasEstimadas: Double read GetTotHEst write SetTotHEst;
    property DataInicialEstimada: TDateTime read GetDtIEst write SetDtIEst;
    property DataFinalEstimada: TDateTime read GetDtFEst write SetDtFEst;
    property blnProrrogacao: Boolean read GetBlnPrg write SetBlnPrg;
    property Adiantamento: TAdiantamentoContrato read GetPedAdt write SetPedAdt;
    property ValorTotalEquipamentos: Double read GetTotAqu write SetTotAqu;
    property ValorTaxaEntrega: Double read GetTaxEnt write SetTaxEnt;
    property ValorTotalEqlLocacao: Double read GetVlrTotLoc write SetVlrTotLoc;
    property TotalMeses: Integer read GetTotMes write SetTotMes;
    property TipoDuracaoContrato: String read GetTipDur write SetTipDur;
    property strMesIni: String read GetStrMesIni;
    property strMesFin: String read GetStrMesFin;
    property DataMesIni: TDateTime read GetMesIni;
    property DataMesFin: TDateTime read GetMesFin;
    property TotalMesesEstimados: Integer read GetTotMEst write SetTotMEst;
    property Responsavel: TList<TCliCtt> read GetLResp write SetLResp;
    property Vendedor: TVendedorContratoLocacao read GetVendedor write SetVendedor;
    property NumPedCom: String read GetPedCom write SetPedCom;
    property strEnderecoObra: String read GetEndObr write SetEndObr;
    property ValorTotalAdicionalAcessorios: Double read GetVlrTotAdc write SetVlrTotAdc;
  End;

  TItemContratoLocacaoEquipamentos = Class
  [weak]
  private
    FAutInc: String;
    FTipoCalculo: TTipoCalculoValorLocacao;
    FEquipamento: TEquipamentoLocacaoPrincipal;
    FContrato: TContratoLocacaoEquipamentos;
    FStrTipoCalculo: String;
    FqryInsert: TUniQuery;
    FqryDelete: TUniQuery;
    FqryInsertNeg: TUniQuery;
    FVlrTotalLocacaoContratado: Double;
    FVlrLocacaoContratado: Double;
    FVlrLocacaoLiquido: Double;
    FPerDes: Double;
    FPerDesTmp: Double;
    FVlrTotLiquido: Double;
    FMensagem: String;
    FblnDescontoLiberado: Boolean;
    FlbnAlteradoTotalLiquidoManual: Boolean;
    FListaAcessorios: TList<TAcessorioContratoLocacaoEquipamentos>;
    FInspecaoSaidaRealizada,
    FInspecaoEntradaRealizada: Boolean;
    FstrInspecaoSaida: String;
    FstrInspecaoEntrada: String;
    FstrCondicaoPerfeitaSaida: String;
    FstrObservacoesSaida: String;
    FCodConferenteSaida: String;
    FCodSupervisorSaida: String;
    FNomConferenteSaida: String;
    FNomConferenteEntrada: String;
    FNomSupervisorSaida: String;
    FNomSupervisorEntrada: String;
    FstrHigienizado: String;
    FstrAvaria: String;
    FstrObservacoesEntrada: String;
    FstrGerarCobranca: String;
    FVlrCobranca: Double;
    FCodConferenteEntrada: String;
    FCodSupervisorEntrada: String;
    FDataInspecaoEntrada: TDateTime;
    FDataInspecaoSaida: TDateTime;
    FHoraInspecaoEntrada: TDateTime;
    FHoraInspecaoSaida: TDateTime;
    FstrDocEnv: String;
    FstrDocRet: String;
    FDuracaoContratado: Double;
    FDataIniCobranca: TDateTime;
    FDataFimCobranca: TDateTime;
    FVlrTot: Double;
    FblnUtilizaFaixaNegociacao: Boolean;
    FDataEncerramento: TDateTime;
    FHraFCob: TDateTime;
    FVlrCobAce: Double;
    FNumEnv: String;
    FEspEnv: String;
    FEmpEnv: String;
    FSerEnv: String;
    FNumRet: String;
    FEspRet: String;
    FEmpRet: String;
    FSerRet: String;
    FBlnAtuIpS: Boolean;
    FBlnAtuIpE: Boolean;
    FblnLimparInspecaoEntrada: Boolean;
    FblnLimparInspecaoSaida: Boolean;
    FVlrCobTrc: Double;
    FVlrTotCob: Double;
    FMensagemRetorno: String;
    FblnEncerrarItem: Boolean;
    FRecEnv: TRecEnv;
    FblnRecalcularVlrLocacao: Boolean;
    FVlrDes: Double;
    FTotDes: Double;
    FDesLoc: Double;
    FQtdEqu: Double;
    FblnEquTrc: Boolean;

    procedure pCalculaValorLocacaoPorDiaria(const blnCalcVlrContratado: Boolean);
    procedure pCalculaValorLocacaoPorHora(const blnCalcVlrContratado: Boolean);
    procedure pCalculaValorLocacaoPorMes(const blnCalcVlrContratado: Boolean);
    procedure pCalculaValorLocacaoLiquidoPorDiaria;
    procedure pCalculaValorLocacaoLiquidoPorHora;
    procedure pCalculaValorLocacaoLiquidoPorMes;
    procedure pCalculaValorDescontoPorDiaria(const aVlrLocacaoLiquido: Double; const aVlrTotalLiquido: Double);
    procedure pCalculaValorDescontoPorHora(const aVlrLocacaoLiquido: Double; const aVlrTotalLiquido: Double);
    procedure pAtualizarDataHoraInicioCobrancaEquipamento(const strAutInc: String);
    procedure pCalcularValorDescontoTotalItem;

    function fValidarDescontoVendedor(const aPerDesc: Double): Boolean;
    function fValidarDescontoSubGerente(const aPerDesc: Double): Boolean;
    function fValidarDescontoGerente(const aPerDesc: Double): Boolean;
    function fObtemValorNegociadoFaixaMaisProxima: Double;
    function fSenhaDescontoContrato(const srtDirAce: String; const aPerDes: Double; const intNvl: Integer): Boolean;
    function fVerificaCalcularVlrContratado: Boolean;

    procedure SetTipDur(const AValue: TTipoCalculoValorLocacao);
    function GetTipDur: TTipoCalculoValorLocacao;
    function GetEquip: TEquipamentoLocacaoPrincipal;
    procedure SetEquip(const AValue: TEquipamentoLocacaoPrincipal);
    function GetContrato: TContratoLocacaoEquipamentos;
    procedure SetContrato(const AValue: TContratoLocacaoEquipamentos);
    function GetAutInc: String;
    procedure SetAutInc(const AValue: String);
    function GetStrTpDur: String;
    procedure SetStrTpDur(const AValue: String);
    function GetVlLocC: Double;
    function GetVlTotC: Double;
    procedure SetVlLocC(const AValue: Double);
    procedure SetVlTotC(const AValue: Double);
    function GetVlLocL: Double;
    function GetPerDes: Double;
    function GetVlTotL: Double;
    procedure SetVlLocL(const AValue: Double);
    procedure SetPerDes(const AValue: Double);
    procedure SetVlTotL(const AValue: Double);
    function GetLAce: TList<TAcessorioContratoLocacaoEquipamentos>;
    procedure SetLAce(const AValue: TList<TAcessorioContratoLocacaoEquipamentos>);
    function GetIspERea: Boolean;
    function GetIspSRea: Boolean;
    procedure SetIspERea(const AValue: Boolean);
    procedure SetIspSRea(const AValue: Boolean);
    function GetStrInsE: String;
    function GetStrInsS: String;
    procedure SetStrInsE(const AValue: String);
    procedure SetStrInsS(const AValue: String);
    function GetCndIps: String;
    function GetNOpIps: String;
    function GetNSuIps: String;
    function GetObsIps: String;
    function GetOpeIps: String;
    function GetSupIps: String;
    procedure SetCndIps(const AValue: String);
    procedure SetNOpIps(const AValue: String);
    procedure SetNSuIps(const AValue: String);
    procedure SetObsIps(const AValue: String);
    procedure SetOpeIps(const AValue: String);
    procedure SetSupIps(const AValue: String);
    function GetEqlAva: String;
    function GetEqlHig: String;
    function GetGerCob: String;
    function GetObsIpE: String;
    function GetOpeIpE: String;
    function GetSupIpE: String;
    function GetVlrCob: Double;
    procedure SetEqlAva(const AValue: String);
    procedure SetEqlHig(const AValue: String);
    procedure SetGerCob(const AValue: String);
    procedure SetObsIpE(const AValue: String);
    procedure SetOpeIpE(const AValue: String);
    procedure SetSupIpE(const AValue: String);
    procedure SetVlrCob(const AValue: Double);
    function GetDtaIpe: TDateTime;
    procedure SetDtaIpE(const AValue: TDateTime);
    function GetNomCfE: String;
    procedure SetNomCfE(const AValue: String);
    function GetDtaIpS: TDateTime;
    procedure SetDtaIps(const AValue: TDateTime);
    function getHorIpE: TDateTime;
    function getHorIpS: TDateTime;
    procedure SetHorIpE(const AValue: TDateTime);
    procedure SetHorIpS(const AValue: TDateTime);
    function GetDocEnv: String;
    procedure SetDocEnv(const AValue: String);
    function GetDocRet: String;
    procedure SetDocRet(const AValue: String);
    function GetVlrTot: Double;
    procedure SetVlrTot(const AValue: Double);
    function GetDurEql: Double;
    procedure SetDurEql(const AValue: Double);
    function GetDtaCob: TDateTime;
    procedure SetDtaCob(const AValue: TDateTime);
    function GetDtaFCob: TDateTime;
    procedure SetDtaFCob(const AValue: TDateTime);
    function GetDtaEnc: TDateTime;
    procedure SetDtaEnc(const AValue: TDateTime);
    function GetDscLib: Boolean;
    function GetHraFCob: TDateTime;
    procedure SetHraFCob(const AValue: TDateTime);
    function GetVlrCobA: Double;
    function GetStrAva: String;
    function GetNSuIpE: String;
    procedure SetNSuIpE(const AValue: String);
    function GetUtiFxN: String;
    procedure SetUtiFxN(const AValue: String);
    function GetEmpEnv: String;
    function GetEmpRet: String;
    function GetEspEnv: String;
    function GetEspRet: String;
    function GetNumEnv: String;
    function GetNumRet: String;
    function GetSerEnv: String;
    function GetSerRet: String;
    procedure SetSerEnv(const AValue: String);
    procedure SetEmpEnv(const AValue: String);
    procedure SetEmpRet(const AValue: String);
    procedure SetEspEnv(const AValue: String);
    procedure SetEspRet(const AValue: String);
    procedure SetNumEnv(const AValue: String);
    procedure SetNumRet(const AValue: String);
    procedure SetSerRet(const AValue: String);
    function GetAtuIpE: Boolean;
    function GetAtuIpS: Boolean;
    procedure SetAtuIpE(const AValue: Boolean);
    procedure SetAtuIpS(const AValue: Boolean);
    function GetCobTrc: Double;
    procedure SetCobTrc(const AValue: Double);
    function GetTotTrc: Double;
    procedure SetTotTrc(const AValue: Double);
    function GetMsgRet: String;
    function GetblnEnc: Boolean;
    procedure SetblnEnc(const AValue: Boolean);
    function GetRecEnv: TRecEnv;
    function GetVlrDes: Double;
    procedure SetVlrDes(const AValue: Double);
    function GetQtdEqu: Double;
    procedure SetQtdEqu(const Value: Double);
    function GetEquTrc: Boolean;
    procedure SetEquTrc(const Value: Boolean);
  public
    constructor Create(Owner: TContratoLocacaoEquipamentos);
    destructor Destroy; override;

    function fInserir: Boolean;
    function fExcluir: Boolean;
    function fObtemValorDiaria: Double;
    function fObtemValorDiariaNegociada: Double;
    function fValidarDesconto(const aPerDesc: Double; aVlrDesc: Double): Boolean;
    function fItemUtilizaFaixaNegociacao: Boolean;
    function fBloquearCadastroEquipamento: Boolean;
    function fAddAcessorio: TAcessorioContratoLocacaoEquipamentos;
    function fInserirAcessorios: Boolean;
    function fObtemValorTroca: Double;
    function fValidaDataInspecao(const aDtaInspecao: TDateTime): Boolean;

    procedure pCalcularValorCobrancaAcessorios;
    procedure pCalcularValorLocacao;
    procedure pCalculaValorDesconto(const aVlrLocacaoLiquido: Double; const aVlrTotalLiquido: Double);
    procedure pCarregarTipoLocacaoEquipamento;
    procedure pLimpar;
    procedure pAddAcessorios;
    procedure pCarregarAcessorios;
    procedure pRealizarInspecaoSaida(const strChaveDet: String; strPerfeitasCondicoes, strObservacoes, strCodConf,
      strCodSup: String; dtaInspecao: TDateTime; dtaCobIni: TDateTime; const blnAtualizaDataCobranca : Boolean = False);
    procedure pConfirmarInspecaoSaida;
    procedure pRealizarInspecaoEntrada(const strChaveDet: String;
      strHigienizado, strAvaria, strObservacoes, strGerarCobranca: String;
      vlrCobranca: Double; strCodConf, strCodSup: String; dtaInspecao: TDateTime = 0);
    procedure pCarregar(const strAutInc: String; strCodEql: String = '');
    procedure pConfirmarInspecaoEntrada;
    procedure pCarregaDataFinalCobranca;
    procedure pLimparDadosInspecaoEntrada(blnLimparGravacaoDados: Boolean = False);
    procedure pLimparDadosInspecaoSaida(blnLimparGravacaoDados: Boolean = False);
    procedure pGravarDadosInspecaoEntrada;
    procedure pGravarDadosInspecaoSaida;
    procedure pLimparGravacaoInspecaoEntrada;
    procedure pLimparGravacaoInspecaoSaida;
    procedure pLimparDocumentoEnvio;
    procedure pLimparDocumentoRetorno;
    procedure pCalculaValorTotalCobranca;
    procedure pCarregarDadosDocEnvio;
    procedure pLimparAcessorios;

    property AutInc: String read GetAutInc write SetAutInc;
    property Equipamento: TEquipamentoLocacaoPrincipal read GetEquip write SetEquip;
    property TipoCalculoLocacao: TTipoCalculoValorLocacao read GetTipDur write SetTipDur;
    property Contrato: TContratoLocacaoEquipamentos read GetContrato write SetContrato;
    property StrTipoCalculoLocacao: String read GetStrTpDur write SetStrTpDur;
    property ValorLocacaoContratado: Double read GetVlLocC write SetVlLocC;
    property ValorTotalLocacaoContratado: Double read GetVlTotC write SetVlTotC;
    property PercentualDesconto: Double read GetPerDes write SetPerDes;
    property ValorDesconto: Double read GetVlrDes write SetVlrDes;
    property ValorLocacaoLiquido: Double read GetVlLocL write SetVlLocL;
    property ValorTotalLiquido: Double read GetVlTotL write SetVlTotL;
    property blnDescontoLiberado: Boolean read GetDscLib;
    property blnValorLocacaoAlteradoManualmente: Boolean read FlbnAlteradoTotalLiquidoManual write FlbnAlteradoTotalLiquidoManual;
    property Acessorios: TList<TAcessorioContratoLocacaoEquipamentos> read GetLAce write SetLAce;
    property strInspecaoEntrada: String read GetStrInsE write SetStrInsE;
    property strInspecaoSaida: String read GetStrInsS write SetStrInsS;
    property InspecaoEntradaRealizada: Boolean read GetIspERea write SetIspERea;
    property InspecaoSaidaRealizada: Boolean read GetIspSRea write SetIspSRea;
    property strCondicaoPerfeitaSaida: String read GetCndIps write SetCndIps;
    property ObservacoesSaida  : String read GetObsIps write SetObsIps;
    property CodConferenteSaida: String read GetOpeIps write SetOpeIps;
    property NomConferenteSaida: String read GetNOpIps write SetNOpIps;
    property CodSupervisorSaida: String read GetSupIps write SetSupIps;
    property NomSupervisorSaida: String read GetNSuIps write SetNSuIps;
    property NomSupervisorEntrada: String read GetNSuIpE write SetNSuIpE;
    property strHigienizado: String read GetEqlHig write SetEqlHig;
    property strAvaria: String read GetEqlAva write SetEqlAva;
    property Avaria: String read GetStrAva;
    property ObservacoesEntrada: String read GetObsIpE write SetObsIpE;
    property strGerarCobranca: String read GetGerCob write SetGerCob;
    property ValorCobranca: Double read GetVlrCob write SetVlrCob;
    property CodConferenteEntrada: String read GetOpeIpE write SetOpeIpE;
    property CodSupervisorEntrada: String read GetSupIpE write SetSupIpE;
    property DataInspecaoEntrada: TDateTime read GetDtaIpe write SetDtaIpE;
    property NomConferenteEntrada: String read GetNomCfE write SetNomCfE;
    property DataInspecaoSaida: TDateTime read GetDtaIpS write SetDtaIps;
    property HoraInspecaoEntrada: TDateTime read getHorIpE write SetHorIpE;
    property HoraInspecaoSaida: TDateTime read getHorIpS write SetHorIpS;
    property strDocEnv: String read GetDocEnv write SetDocEnv;
    property strDocRet: String read GetDocRet write SetDocRet;
    property Duracao: Double read GetDurEql write SetDurEql;
    property DataInicialCobranca: TDateTime read GetDtaCob write SetDtaCob;
    property DataFinalCobranca: TDateTime read GetDtaFCob write SetDtaFCob;
    property HoraFinalCobranca: TDateTime read GetHraFCob write SetHraFCob;
    property ValorTotal: Double read GetVlrTot write SetVlrTot;
    property DataEncerramento: TDateTime read GetDtaEnc write SetDtaEnc;
    property ValorCobrancaAcessorios: Double read GetVlrCobA;
    property strUtiFaixaNegociacao: String read GetUtiFxN write SetUtiFxN;
    property NumEnv: String read GetNumEnv write SetNumEnv;
    property EspEnv: String read GetEspEnv write SetEspEnv;
    property EmpEnv: String read GetEmpEnv write SetEmpEnv;
    property SerEnv: String read GetSerEnv write SetSerEnv;
    property NumRet: String read GetNumRet write SetNumRet;
    property EspRet: String read GetEspRet write SetEspRet;
    property EmpRet: String read GetEmpRet write SetEmpRet;
    property SerRet: String read GetSerRet write SetSerRet;
    property blnAtualizarInspSaida: Boolean read GetAtuIpS write SetAtuIpS;
    property blnAtualizarInspEntrada: Boolean read GetAtuIpE write SetAtuIpE;
    property ValorCobrancaTroca: Double read GetCobTrc write SetCobTrc;
    property ValorTotalCobranca: Double read GetTotTrc write SetTotTrc;
    property MensagemRetorno: String read GetMsgRet;
    property blnEncerrarIte: Boolean read GetblnEnc write SetblnEnc;
    property RecEnv: TRecEnv read GetRecEnv;
    property blnRecalcularVlrLocacao: Boolean read FblnRecalcularVlrLocacao write FblnRecalcularVlrLocacao;
    property Quantidade: Double read GetQtdEqu write SetQtdEqu;
    property blnEquTrc: Boolean read GetEquTrc write SetEquTrc;
  End;

  TAcessorioContratoLocacaoEquipamentos = Class
  [weak]
  private
    FAutInc: String;
    FAcessorio: TEquipamentoLocacaoAcessorio;
    FItem: TItemContratoLocacaoEquipamentos;
    FqryInsert: TUniQuery;
    FqryDelete: TUniQuery;
    FQtdAcl: Double;
    FMensagem: String;
    FCodEql: String;
    FInspecaoEntradaRealizada: Boolean;
    FInspecaoSaidaRealizada: Boolean;
    FstrInspecaoEntrada: String;
    FstrInspecaoSaida: String;
    FstrCondicaoPerfeitaSaida: String;
    FstrObservacoesSaida: String;
    FCodConferenteSaida: String;
    FCodSupervisorSaida: String;
    FNomSupervisorSaida: String;
    FNomSupervisorEntrada: String;
    FNomConferenteEntrada: String;
    FNomConferenteSaida: String;
    FstrHigienizado: String;
    FstrAvaria: String;
    FstrObservacoesEntrada: String;
    FstrGerarCobranca: String;
    FVlrCobranca: Double;
    FCodConferenteEntrada: String;
    FCodSupervisorEntrada: String;
    FDataInspecaoEntrada: TDateTime;
    FDataInspecaoSaida: TDateTime;
    FHoraInspecaoEntrada: TDateTime;
    FHoraInspecaoSaida: TDateTime;
    FstrDocEnv: String;
    FstrDocRet: String;
    FVlrTotal: Double;
    FblnLimparInspecaoEntrada: Boolean;
    FblnLimparInspecaoSaida: Boolean;
    FMensagemRetorno: String;
    FblnAtualizarInspSaida: Boolean;
    FblnAtualizarInspEntrada: Boolean;
    FVlrAdc: Double;

    function GetAutInc: String;
    procedure SetAutInc(const AValue: String);
    function GetAcessorio: TEquipamentoLocacaoAcessorio;
    procedure SetAcessorio(const AValue: TEquipamentoLocacaoAcessorio);
    procedure SetQtdAcl(const AValue: Double);
    function GetCodEql: String;
    procedure SetCodEql(const AValue: String);
    function GetQtdAcl: Double;
    function GetIspERea: Boolean;
    function GetIspSRea: Boolean;
    procedure SetIspERea(const AValue: Boolean);
    procedure SetIspSRea(const AValue: Boolean);
    function GetStrInsE: String;
    function GetStrInsS: String;
    procedure SetStrInsE(const AValue: String);
    procedure SetStrInsS(const AValue: String);
    function GetCndIps: String;
    function GetNOpIps: String;
    function GetNSuIps: String;
    function GetObsIps: String;
    function GetOpeIps: String;
    function GetSupIps: String;
    procedure SetCndIps(const AValue: String);
    procedure SetNOpIps(const AValue: String);
    procedure SetNSuIps(const AValue: String);
    procedure SetObsIps(const AValue: String);
    procedure SetOpeIps(const AValue: String);
    procedure SetSupIps(const AValue: String);
    function GetEqlAva: String;
    function GetEqlHig: String;
    function GetGerCob: String;
    function GetObsIpE: String;
    function GetOpeIpE: String;
    function GetSupIpE: String;
    function GetVlrCob: Double;
    procedure SetEqlAva(const AValue: String);
    procedure SetEqlHig(const AValue: String);
    procedure SetGerCob(const AValue: String);
    procedure SetObsIpE(const AValue: String);
    procedure SetOpeIpE(const AValue: String);
    procedure SetSupIpE(const AValue: String);
    procedure SetVlrCob(const AValue: Double);
    function GetDtaIpe: TDateTime;
    procedure SetDtaIpE(const AValue: TDateTime);
    function GetNomCfE: String;
    procedure SetNomCfE(const AValue: String);

    function GetDatIpS: TDateTime;
    procedure SetDatIpS(const AValue: TDateTime);
    function getHorIpE: TDateTime;
    function getHorIpS: TDateTime;
    procedure SetHorIpE(const AValue: TDateTime);
    procedure SetHorIpS(const AValue: TDateTime);
    function GetItem: TItemContratoLocacaoEquipamentos;
    function GetDocEnv: String;
    procedure SetDocEnv(const AValue: String);
    function GetDocRet: String;
    procedure SetDocRet(const AValue: String);
    function GetStrAva: String;
    function GetNSuIpE: String;
    procedure SetNSuIpE(const AValue: String);
    function GetMsgRet: String;
    function GetBlnAtuEnt: Boolean;
    procedure SetBlnAtuEnt(const AValue: Boolean);
    function GetBlnAtuSai: Boolean;
    procedure SetBlnAtuSai(const AValue: Boolean);
    function GetVlrAdc: Double;
    procedure SetVlrAdc(const AValue: Double);
  public
    constructor Create(Owner: TItemContratoLocacaoEquipamentos);
    destructor Destroy; override;

    function fInserir: Boolean;
    function fExcluir: Boolean;
    function fBloquearCadastroAcessorio: Boolean;
    function fValidaDataInspecao(const aDtaInspecao: TDateTime): Boolean;

    procedure pRealizarInspecaoSaida(const strChaveDet: String; strPerfeitasCondicoes: String; strObservacoes: String;
      strCodConf: String; strCodSup: String; dtaInspecao: TDateTime = 0; blnAtualizarDataInsp: Boolean = True);
    procedure pConfirmarInspecaoSaida;
    procedure pCarregar(const strAutInc: String);
    procedure pRealizarInspecaoEntrada(const strChaveDet: String;
      strHigienizado, strAvaria, strObservacoes, strGerarCobranca: String;
      vlrCobranca: Double; strCodConf, strCodSup: String; dtaInspecao: TDateTime = 0;
      blnAtualizarDataInsp: Boolean = True);
    procedure pConfirmarInspecaoEntrada;
    procedure pLimpar;
    procedure pLimparDadosInspecaoEntrada(const blnLimparGravacaoDados: Boolean = False);
    procedure pLimparDadosInspecaoSaida(const blnLimparGravacaoDados: Boolean = False);
    procedure pGravarDadosInspecaoEntrada;
    procedure pGravarDadosInspecaoSaida;
    procedure pLimparGravacaoInspecaoEntrada;
    procedure pLimparGravacaoInspecaoSaida;

    property ItemEquipamento: TItemContratoLocacaoEquipamentos Read GetItem;
    property AutInc: String read GetAutInc write SetAutInc;
    property Acessorio: TEquipamentoLocacaoAcessorio read GetAcessorio write SetAcessorio;
    property CodEquipamento: String read GetCodEql write SetCodEql;
    property Quantidade: Double read GetQtdAcl write SetQtdAcl;
    property InspecaoEntradaRealizada: Boolean read GetIspERea write SetIspERea;
    property InspecaoSaidaRealizada: Boolean read GetIspSRea write SetIspSRea;
    property strInspecaoEntrada: String read GetStrInsE write SetStrInsE;
    property strInspecaoSaida: String read GetStrInsS write SetStrInsS;
    property strCondicaoPerfeitaSaida: String read GetCndIps write SetCndIps;
    property ObservacoesSaida  : String read GetObsIps write SetObsIps;
    property CodConferenteSaida: String read GetOpeIps write SetOpeIps;
    property NomConferenteSaida: String read GetNOpIps write SetNOpIps;
    property CodSupervisorSaida: String read GetSupIps write SetSupIps;
    property NomSupervisorSaida: String read GetNSuIps write SetNSuIps;
    property strHigienizado: String read GetEqlHig write SetEqlHig;
    property strAvaria: String read GetEqlAva write SetEqlAva;
    property ObservacoesEntrada: String read GetObsIpE write SetObsIpE;
    property strGerarCobranca: String read GetGerCob write SetGerCob;
    property ValorCobranca: Double read GetVlrCob write SetVlrCob;
    property CodConferenteEntrada: String read GetOpeIpE write SetOpeIpE;
    property CodSupervisorEntrada: String read GetSupIpE write SetSupIpE;
    property DataInspecaoEntrada: TDateTime read GetDtaIpe write SetDtaIpE;
    property NomConferenteEntrada: String read GetNomCfE write SetNomCfE;
    property DataInspecaoSaida: TDateTime read GetDatIpS write SetDatIpS;
    property HoraInspecaoEntrada: TDateTime read getHorIpE write SetHorIpE;
    property HoraInspecaoSaida: TDateTime read getHorIpS write SetHorIpS;
    property strDocEnv: String read GetDocEnv write SetDocEnv;
    property strDocRet: String read GetDocRet write SetDocRet;
    property Avaria: String read GetStrAva;
    property NomSupervisorEntrada: String read GetNSuIpE  write SetNSuIpE;
    property MensagemRetorno: String read GetMsgRet;
    property blnAtualizarInspEntrada: Boolean read GetBlnAtuEnt write SetBlnAtuEnt;
    property blnAtualizarInspSaida: Boolean read GetBlnAtuSai write SetBlnAtuSai;
    property ValorAdicional: Double read GetVlrAdc write SetVlrAdc;
  End;

const
  cstDirAceDescNvl1 = 'LOCVM1';
  cstDirAceDescNvl2 = 'LOCVM2';
  cstDirAceDescNvl3 = 'LOCVM3';

implementation

uses
  DateUtils, untFuncoesSimples, untLiberacao, untMsgLiberacao, untFuncoesGenerica,
  untFuncoesRel, untFuncoesRel2, untFuncoesLocEqu, Faturamento.Classes.CalcularFaturaLocEqu;

{ TContratoLocacaoEquipamentos }

constructor TContratoLocacaoEquipamentos.Create(opLocacao: TOperacaoLocacao = opNenhum);
begin
  FListaItens := TList<TItemContratoLocacaoEquipamentos>.Create;
  FEmitente   := TEmitenteContratoLocacao.Create;
  FSLMensagemRetorno := TStringList.Create;
  FCliente := TClienteContratoLocacao.Create;
  FblnInspecaoRealizada := False;
  FAdiantamento := TAdiantamentoContrato.Create;
  FListaResp := TList<TCliCtt>.Create;
  FVendedor := TVendedorContratoLocacao.Create;

  FOpLocacao := opLocacao;

  pLimpar;
end;

destructor TContratoLocacaoEquipamentos.Destroy;
begin
  FreeAndNil(FListaItens);
  FreeAndNil(FEmitente);
  FreeAndNil(FCliente);
  FreeAndNil(FSLMensagemRetorno);
  FreeAndNil(FAdiantamento);
  FreeAndNil(FListaResp);
  FreeAndNil(FVendedor);

  inherited;
end;

function TContratoLocacaoEquipamentos.fAddItem(const aItem: TItemContratoLocacaoEquipamentos = Nil): TItemContratoLocacaoEquipamentos;
var
  itemAux: TItemContratoLocacaoEquipamentos;
begin
  itemAux := TItemContratoLocacaoEquipamentos.Create(Self);

  If Assigned(aItem) Then
  Begin
    itemAux.Equipamento.Codigo          := aItem.Equipamento.Codigo;
    itemAux.Equipamento.pCarregaEquipamento('', aItem.Equipamento.Codigo);
    itemAux.TipoCalculoLocacao          := aItem.TipoCalculoLocacao;
    itemAux.ValorLocacaoContratado      := aItem.ValorLocacaoContratado;
    itemAux.ValorTotalLocacaoContratado := aItem.ValorTotalLocacaoContratado;
    itemAux.PercentualDesconto          := aItem.PercentualDesconto;
    itemAux.ValorLocacaoLiquido         := aItem.ValorLocacaoLiquido;
    itemAux.ValorTotalLiquido           := aItem.ValorTotalLiquido;
    itemAux.blnValorLocacaoAlteradoManualmente := aItem.blnValorLocacaoAlteradoManualmente;
    itemAux.blnRecalcularVlrLocacao     := (Not aItem.blnValorLocacaoAlteradoManualmente);
    itemAux.Quantidade                  := aItem.Quantidade;
  End;

  FListaItens.add(itemAux);
  itemAux.pAddAcessorios;

  Result := itemAux;

  If Assigned(aItem) Then
    pCalculaTotais;
end;

function TContratoLocacaoEquipamentos.fAddResponsavel(
  const strCodCli, strAutInc: String): TCliCtt;
var
  respAux: TCliCtt;
begin
  respAux := TCliCtt.Create(Nil, strCodCli, strAutInc);

  FListaResp.add(respAux);

  Result := respAux;
end;

function TContratoLocacaoEquipamentos.fAlterarDataTerminoContrato(aDataInicial,
  aDataFinal: TDateTime; aMesInicial: String = ''; aMesFinal: String = '';
  blnAtualizaDB: Boolean = False): Boolean;
begin
  Try
    If (aDataFinal < aDataInicial) Then
    Begin
      FSLMensagemRetorno.Clear;
      FSLMensagemRetorno.Add('A data final para término de contrato não pode ser inferior a data inicial do contrato.');
      Exit(False);
    End;

    If (aDataFinal > FDataFinalEstimada) And (FDataFinalEstimada > 0) And (FStatus = 'A') And (Not FBlnProrrogacao) Then
    Begin
      FSLMensagemRetorno.Clear;
      FSLMensagemRetorno.Add('A data final para término de contrato não pode ser maior a data final estimada do contrato. ' +
                             'Utilize a rotina de prorrogação caso seja necessário aumentar a data final do contrato.');
      Exit(False);
    End;

    If (aDataFinal < fObtemDtaUltFat) Then
    Begin
      FSLMensagemRetorno.Clear;
      FSLMensagemRetorno.Add('A data final para término de contrato não pode ser menor que a data do último faturamento. ' +
                             'Utilize a rotina de prorrogação caso seja necessário aumentar a data final do contrato.');
      Exit(False);
    End;

    FDtaIni := fObtemData(aDataInicial);
    FDtaFin := fObtemData(aDataFinal);
    FHorIni := fObtemHora(aDataInicial);
    FHorFin := fObtemHora(aDataFinal);

    FMesIni := fObtemDtaIniMes(aMesInicial);
    FMesFin := fObtemDtaFiniMes(aMesFinal);

    pCalculaDuracaoContrato;

    If (Not FBlnProrrogacao) Then
    Begin
      FDataInicialEstimada := aDataInicial;
      FDataFinalEstimada := aDataFinal;
      FTotalDiasEstimado := FTotDia;
      FTotalHorasEstimadas := FTotHor;
    End;

    pRecalculaItensContrato;
    pCalculaTotais;

    If blnAtualizaDB Then
      pAtualizarDataTerminoContrato;

    Result := True;
  Except
    On E: Exception Do
    Begin
      FSLMensagemRetorno.Text := 'Não foi possível alterar a data do contrato: ' + E.Message;
      Result := False;
    End;
  End;
end;

function TContratoLocacaoEquipamentos.fAlterarStatusContrato(const strStatus: String = ''; const tpStatus: TStatusContratoLocacao = stNone): Boolean;
var
  qry: TUniQuery;
  strStatusAtu: String;
begin
  If Not fEmptyStr(strStatus) Then
    strStatusAtu := strStatus
  Else If (tpStatus <> stNone) Then
    strStatusAtu := arrSitContratoLocacao[tpStatus];

  If fEmptyStr(strStatus) And (tpStatus = stNone) Then
    strStatusAtu := 'O';

  qry := fCriaQuery;
  Try
    qry.DisableControls;
    Try
      qry.SQL.Add('UPDATE CONEQL SET EQL_STATUS = :STATUS ');
      qry.SQL.Add('WHERE AUTOINCREM = :AUTINC');
      qry.ParamByName('STATUS').AsString := strStatusAtu;
      qry.ParamByName('AUTINC').AsString := FAutInc;
      qry.ExecSQL;

      Result := True;

      If Result Then
        FStatus := strStatusAtu;
    Except
      Result := False;
    End;
  Finally
    pFreeAndNil(qry);
  End;
end;

function TContratoLocacaoEquipamentos.fAtivarContrato: Boolean;
begin
  Result := fAlterarStatusContrato(arrSitContratoLocacao[stAtivo]);
end;
function TContratoLocacaoEquipamentos.fAtualizarPedidoAdiantamento(
  const strAutInc: String): Boolean;
Var
  qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.DisableControls;
    Try
      qry.SQL.Add('UPDATE CONEQL SET EQL_AUT_PD = :AUT_PD ');
      qry.SQL.Add('WHERE AUTOINCREM = :AUTINC');
      qry.ParamByName('AUT_PD').AsString := FAUT_PD;
      qry.ParamByName('AUTINC').AsString := FAutInc;
      qry.ExecSQL;

      Result := True;

    Except
      Result := False;
    End;
  Finally
    pFreeAndNil(qry);
  End;
end;

function TContratoLocacaoEquipamentos.fConfirmarInspecao: Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  Try

    If FListaItens.Count <= 0 Then
    Begin
      FSLMensagemRetorno.Text := 'Não há itens para realizar a inspeção.';
      Exit;
    End;

    fStartTransaction;
    Try
      For intCnt := 0 To FListaItens.Count-1 Do
      Begin
        If fVerificaInspecaoSaidaPendente(FListaItens[intCnt].Equipamento.Codigo) Then
        Begin
          pConfirmarInspecaoSaida;
        End
        Else
          pConfirmarInspecaoEntrada;
      End;

      fCommit;
      Result := True;
    Except
      On Erro: Exception Do
      Begin
        Result := False;
        FSLMensagemRetorno.Text := Erro.Message;
        fRollBack;
      End;
    End;
  Finally
    FblnInspecaoRealizada := Result;
  End;
end;

procedure TContratoLocacaoEquipamentos.pConfirmarInspecaoEntrada;
var
  intCnt: Integer;
  intCont: Integer;
begin
  For intCont := 0 To FListaItens.Count-1 Do
  Begin

    If Not fEmptyStr(FListaItens[intCont].CodConferenteEntrada) Then
    Begin
      FListaItens[intCont].pConfirmarInspecaoEntrada;
      If  FListaItens[intCont].strAvaria = 'S' Then
        FListaItens[intCont].fBloquearCadastroEquipamento;
    End;

    If fCfgSis('UTIACE', VarBoolean) Then
    Begin
      For intCnt := 0 to FListaItens[intCont].Acessorios.Count-1 Do
      Begin
        If Not fEmptyStr(FListaItens[intCont].Acessorios[intCnt].CodConferenteEntrada) Then
        Begin
          FListaItens[intCont].Acessorios[intCnt].pConfirmarInspecaoEntrada;

          If FListaItens[intCont].Acessorios[intCnt].strAvaria = 'S' Then
            FListaItens[intCont].Acessorios[intCnt].fBloquearCadastroAcessorio;
        End;
      End;
    End;
  End;
end;

procedure TContratoLocacaoEquipamentos.pConfirmarInspecaoSaida;
var
  intCnt,
  intCont: Integer;
begin
  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    If Not fEmptyStr(FListaItens[intCont].CodConferenteSaida) Then
      FListaItens[intCont].pConfirmarInspecaoSaida;

    If fCfgSis('UTIACE', VarBoolean) Then
    Begin
      For intCnt := 0 to FListaItens[intCont].Acessorios.Count  -1 Do
      Begin
        If Not fEmptyStr(FListaItens[intCont].Acessorios[intCnt].CodConferenteSaida) Then
          FListaItens[intCont].Acessorios[intCnt].pConfirmarInspecaoSaida;
      End;
    End;
  End;
end;

function TContratoLocacaoEquipamentos.fCalculaDataFinalCobranca(const aDataInicial: TDateTime;
  aNumeroHoras: Double): TDateTime;
var
  dtaFinalCobranca: TDateTime;
  nroDias: Double;
begin
  If FTipDur = 'M' Then
  Begin
    dtaFinalCobranca := IncMonth(aDataInicial, FTotMes);
  End
  Else
  Begin
    If FTipDur = 'D' Then
    Begin
      dtaFinalCobranca := aDataInicial + FTotDia;
    End
    Else
    Begin
      nroDias := (aNumeroHoras / HoursPerDay);
      dtaFinalCobranca := aDataInicial + nroDias;
    End;
  End;
  Result  := dtaFinalCobranca;
end;

function TContratoLocacaoEquipamentos.fEquipamentoJaInseridoNesseContrato(const
  strCodEql: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;

  For intCnt := 0 to FListaItens.Count -1 Do
  Begin
    If FListaItens[intCnt].FEquipamento.Codigo = strCodEql Then
    Begin
      If Not fEmptyStr(FListaItens[intCnt].AutInc) Then
      Begin
        FIndiceEquipamentoSelecionado := intCnt;
        Result := True;
        Break;
      End;
    End;
  End;
end;

function TContratoLocacaoEquipamentos.fObtemDtaUltFat: TDateTime;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add('SELECT EQF_DTAREF, EQF_HORREF FROM EQLFAT WHERE EQF_SEQCON = :SEQCON ');
    qryConsulta.SQL.Add('ORDER BY EQF_DTAREF DESC, EQF_HORREF DESC LIMIT 1');
    qryConsulta.ParamByName('SEQCON').AsString := FAutInc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      Result := qryConsulta.FieldByName('EQF_DTAREF').AsDateTime + qryConsulta.FieldByName('EQF_HORREF').AsDateTime;
    End
    Else
      Result := FDtaIni;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TContratoLocacaoEquipamentos.fPermiteCarregarContratoOutraEmpresa: Boolean;
begin
  Result := False;

  If fCfgSis('LOCEMP', VarBoolean) Then
  Begin
    If FOpLocacao in [opInspecao, opManutencao] Then
      Result := True;
  End;
end;

function TContratoLocacaoEquipamentos.fRemoveItem(
  const strCodEql: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCnt].Equipamento.Codigo = strCodEql Then
    Begin
      FListaItens.Delete(intCnt);
      pCalculaTotais;
      Result := True;
      Break;
    End;
  End;
end;

function TContratoLocacaoEquipamentos.fRemoveResponsavel(
  const strCodCli, strAutIncCtt: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 to FListaResp.Count-1 Do
  Begin
    If (FListaResp[intCnt].strAutoincrem = strAutIncCtt) And
       (FListaResp[intCnt].strCodCli = strCodCli) Then
    Begin
      FListaResp.Delete(intCnt);
      Result := True;
      Break;
    End;
  End;
end;

class function TContratoLocacaoEquipamentos.fEquipamentoDisponivel(
  arrCodEql: TConsultasArray;
  strNumCont: String;
  blnForUpdate: Boolean = False;
  strDtaIni: String = '';
  strHorIni: String = '';
  strDtaFin: String = '';
  strHorFin: String = ''): Boolean;
var
  strCodEql: String;
  objEquip: TConsultas;
  qryAux: TUniQuery;
  dtmDtHrIni, dtmDtHrFin: TDateTime;
  strAux: String;
begin
  dtmDtHrIni := StrToDateTime(strDtaIni + ' ' + strHorIni);
  dtmDtHrFin := StrToDateTime(strDtaFin + ' ' + strHorFin);

  qryAux := fCriaQuery();
  Try

    If Length(arrCodEql) = 1 Then
      strCodEql := ' = ' + QuotedStr(arrCodEql[0].strCodigo)
    Else
    Begin
      strCodEql := '';
      For objEquip in arrCodEql Do
      Begin
        If Not fEmptyStr(strCodEql) Then
          strCodEql := strCodEql + ', ';

        strCodEql := strCodEql + QuotedStr(objEquip.strCodigo);
      End;
      strCodEql := ' IN (' + strCodEql + ')';
    End;

    qryAux.SQL.Clear;

    qryAux.SQL.Add('SELECT                                             ');
    qryAux.SQL.Add('  EQL_NROCON,                                      ');
    qryAux.SQL.Add('  EQD_SEQEQL,                                      ');
    qryAux.SQL.Add('  IFNULL(EQL_DTAINI, EQL_MESINI),                  ');
    qryAux.SQL.Add('  EQL_HORINI,                                      ');
    qryAux.SQL.Add('  IFNULL(EQL_DTAFIN, EQL_MESFIN),                  ');
    qryAux.SQL.Add('  EQL_HORFIN                                       ');
    qryAux.SQL.Add('FROM                                               ');
    qryAux.SQL.Add('  CONEQL C                                         ');
    qryAux.SQL.Add('INNER JOIN EQLDET D                                ');
    qryAux.SQL.Add('  ON D.EQD_SEQCON = C.AUTOINCREM                   ');
    qryAux.SQL.Add('WHERE D.EQD_SEQEQL ' + strCodEql + '               ');
    qryAux.SQL.Add('  AND TIMESTAMP(IFNULL(EQL_DTAINI, EQL_MESINI), IFNULL(EQL_HORINI, 0)) <= :DTHFIN ');
    qryAux.SQL.Add('  AND TIMESTAMP(IFNULL(EQL_DTAFIN, EQL_MESFIN), IFNULL(EQL_HORFIN, 0)) >= :DTHINI ');
    qryAux.SQL.Add('  AND C.EQL_STATUS NOT IN ("C","F", "E", "O")      ');
    qryAux.SQL.Add('  AND IFNULL((SELECT MAX(EQF_DTAENC)               ');
    qryAux.SQL.Add('                FROM EQLFAT                        ');
    qryAux.SQL.Add('              WHERE EQF_SEQCON = EQD_SEQCON AND        ');
    qryAux.SQL.Add('                    EQF_SEQEQL = EQD_SEQEQL), IFNULL(EQD_DTAENC, 0)) <= 0  ');
    If Not fEmptyStr(strNumCont) Then
      qryAux.SQL.Add('  AND EQL_NROCON <> :NROCON                      ');
    If blnForUpdate Then
      qryAux.SQL.Add('FOR UPDATE                                       ');

    qryAux.ParamByName('DTHINI').AsDateTime := dtmDtHrIni;
    qryAux.ParamByName('DTHFIN').AsDateTime := dtmDtHrFin;
    If Not fEmptyStr(strNumCont) Then
      qryAux.ParamByName('NROCON').AsString := strNumCont;
    qryAux.Open;

    strAux := qryAux.SQL.Text;

    TTimeField(qryAux.FieldByName('EQL_HORINI')).DisplayFormat := 'hh:nn';
    TTimeField(qryAux.FieldByName('EQL_HORFIN')).DisplayFormat := 'hh:nn';

    If qryAux.RecordCount >= 1 Then
    Begin

      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(88, 5392, [],
                            ['DTAINI', 'HORINI', 'DTAFIN', 'HORFIN', 'SEQEQL', 'STATUS', IIF(Not fEmptyStr(strNumCont),'NROCON','')],
                            [strDtaIni, strHorIni, strDtaFin, strHorFin, strCodEql, 'C_F_E_O_', IIF(Not fEmptyStr(strNumCont),strNumCont,'')],
                            nil,
                            nil,
                            True,
                            False);
      End;

      Result := False;

    End
    Else
      Result := True;

  Finally
    FreeAndNil(qryAux);
  End;

end;

class function TContratoLocacaoEquipamentos.fEquipamentoDisponivel(
  strCodEql: String;
  ObjContrato: TContratoLocacaoEquipamentos;
  blnForUpdate: Boolean = False): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  Try
    strCodEql := ' IN (' + strCodEql + ')';
    qryAux.SQL.Clear;

    qryAux.SQL.Add('SELECT                                             ');
    qryAux.SQL.Add('  EQL_NROCON,                                      ');
    qryAux.SQL.Add('  EQD_SEQEQL,                                      ');
    qryAux.SQL.Add('  EQL_DTAINI,                                      ');
    qryAux.SQL.Add('  EQL_HORINI,                                      ');
    qryAux.SQL.Add('  EQL_DTAFIN,                                      ');
    qryAux.SQL.Add('  EQL_HORFIN                                       ');
    qryAux.SQL.Add('FROM                                               ');
    qryAux.SQL.Add('  CONEQL C                                         ');
    qryAux.SQL.Add('INNER JOIN EQLDET D                                ');
    qryAux.SQL.Add('  ON D.EQD_SEQCON = C.AUTOINCREM                   ');
    qryAux.SQL.Add('WHERE D.EQD_SEQEQL ' + strCodEql + '               ');
    qryAux.SQL.Add('  AND TIMESTAMP(EQL_DTAINI, EQL_HORINI) <= :DTHFIN ');
    qryAux.SQL.Add('  AND TIMESTAMP(EQL_DTAFIN, EQL_HORFIN) >= :DTHINI ');
    qryAux.SQL.Add('  AND C.EQL_STATUS NOT IN ("C","F")                ');
    qryAux.SQL.Add('  AND EQL_NROCON <> :NROCON                        ');
    If blnForUpdate Then
      qryAux.SQL.Add('FOR UPDATE                                       ');

    qryAux.ParamByName('NROCON').AsString   := ObjContrato.NroContrato;
    qryAux.ParamByName('DTHINI').AsDateTime := ObjContrato.DataInicial;
    qryAux.ParamByName('DTHFIN').AsDateTime := ObjContrato.DataFinal;
    qryAux. Open;

    TTimeField(qryAux.FieldByName('EQL_HORINI')).DisplayFormat := 'hh:nn';
    TTimeField(qryAux.FieldByName('EQL_HORFIN')).DisplayFormat := 'hh:nn';

    If qryAux.RecordCount >= 1 Then
    Begin

      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(88, 5392, [],
                            ['DTAINI', 'HORINI', 'DTAFIN', 'HORFIN', 'SEQEQL', 'STATUS', IIF(Not fEmptyStr(ObjContrato.NroContrato),'NROCON','')],
                            [DateTimeToStr(ObjContrato.DataInicial),
                             DateTimeToStr(ObjContrato.HoraInicial),
                             DateTimeToStr(ObjContrato.DataFinal),
                             DateTimeToStr(ObjContrato.HoraFinal),
                             strCodEql, 'C_F', ObjContrato.NroContrato,''],
                             nil,
                             nil,
                             True,
                             False);
      End;

      Result := False;

    End
    Else
      Result := True;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TContratoLocacaoEquipamentos.fRetornaItemAcessorioContrato(
  const strCodEql, strCodAcl: String): TAcessorioContratoLocacaoEquipamentos;
var
  intCont,
  intCnt: Integer;
begin
  Result := nil;
  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCont].Equipamento.Codigo = strCodEql Then
    Begin
      For intCnt := 0 to FListaItens[intCont].Acessorios.Count  -1 Do
      Begin
        If FListaItens[intCont].Acessorios[intCnt].FAcessorio.Codigo = strCodAcl Then
        Begin
          Result := FListaItens[intCont].Acessorios[intCnt];
          Break;
        End;
      End;
    End;
  End;
end;

function TContratoLocacaoEquipamentos.fRetornaItemContrato(
  const strCodEQL: String): TItemContratoLocacaoEquipamentos;
var
  intCont: Integer;
begin
  Result := nil;
  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCont].Equipamento.Codigo = strCodEql Then
    Begin
      Result := FListaItens[intCont];
      Break;
    End;
  End;
end;

function TContratoLocacaoEquipamentos.fRetornastrDescriDuracaoCtr(const blnPlural: Boolean = True): String;
begin
  If FTipDur = 'D' Then
    Result := IIF(blnPlural,'DIÁRIAS', 'DIÁRIA')
  ELse If FTipDur = 'M' Then
    Result := IIF(blnPlural,'MESES', 'MÊS')
  ELse If FTipDur = 'H' Then
    Result := IIF(blnPlural,'HORAS', 'HORA')
  Else
    Result := IIF(blnPlural,'HORAS/DIÁRIAS', 'HORA/DIÁRIA');
end;

function TContratoLocacaoEquipamentos.fRetornaTipoDuracaoContrato: String;
var
  intCnt: Integer;
  intTotItemDia : Integer;
  intTotItemHora: Integer;
  intTotItemMes : Integer;
begin
  Result := 'D';
  intTotItemDia := 0;
  intTotItemHora:= 0;
  intTotItemMes := 0;
  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    Case FListaItens[intCnt].TipoCalculoLocacao Of
      tpDiaria : inc(intTotItemDia);
      tpHoras  : inc(intTotItemHora);
      tpMensal : inc(intTotItemMes);
    End;
  End;

  If FListaItens.Count > 0 Then
  Begin
    If (FListaItens.Count = intTotItemDia) Then
      Result := 'D'
    Else If (FListaItens.Count = intTotItemHora) Then
      Result := 'H'
    Else If (FListaItens.Count = intTotItemMes) Then
      Result := 'M'
    Else
      Result := 'T';
  End
  Else
  Begin
    If (FMesIni > 0) And (FMesFin > 0) Then
    Begin
      Result := 'M';
    End
    Else
      Result := FTipDur;
  End;

end;

function TContratoLocacaoEquipamentos.fValidaPodeAtivarContrato: Boolean;
Begin
  If  fCfgSis('SLIBCT', VarBoolean) Then
  Begin
    Result := fValidarContratosVencidos;
  End
  Else
    Exit(True);
End;

function TContratoLocacaoEquipamentos.fValidarContratosVencidos: Boolean;
var
  qrySelect: TUniQuery;
  objLiberacao: TLiberacao;
  objLinha  : TLinhaMsgLibera;
  objTabela : TRegistroMsgLiberaTabela;
Begin
  Cliente.pCarregar(FCodCli);

  objLiberacao := TLiberacao.Create;
  qrySelect := fCriaQuery;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(130);
    objLiberacao.objMsgLibera.pAddTexto('Liberação de novo contrato para cliente com contratos vencidos pendentes de retorno de equipamento', alCentro, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + Cliente.Codigo + ' - ' + Cliente.NomeCliente, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Cnpj: ' + Cliente.CpfCnpj, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Nome Fantasia: ' + Cliente.NomeFantasia, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('');
    objLiberacao.objMsgLibera.pAddTexto('Equipamentos pendentes: ', alEsquerda, teAmbos, '', 99);

    qrySelect.SQL.Add('SELECT EQL_CODCLI, ' +
                      '       EQL_NROCON, ' +
                      '       EQL_DTAINI, ' +
                      '       EQL_DTAFIN, ' +
                      '       EQL_HORINI, ' +
                      '       EQL_HORFIN, ' +
                      '       (CASE WHEN CONEQL.EQL_STATUS = ''A'' THEN ''ATIVO'' ' +
                      '             WHEN CONEQL.EQL_STATUS = ''F'' THEN ''FATURADO'' END) AS EQL_STATUS, '+
                      '       CONCAT (EQD_SEQEQL, '' - '', EQL_DESCRI) AS EQUIPAMENTO, ' +
                      '       CONCAT (EQD_DTAIPS, '' - '', EQD_HORIPS) AS SAIDA,  ' +
                      '       CONCAT (EQD_DTAIPE, '' - '', EQD_HORIPE) AS ENTRADA ' +
                      '  FROM EQLDET                                              ' +
                      '  INNER JOIN CONEQL ON CONEQL.AUTOINCREM = EQLDET.EQD_SEQCON '+
                      '  LEFT  JOIN CADEQL ON CADEQL.EQL_CODIGO = EQLDET.EQD_SEQEQL '+
                      '  WHERE CONEQL.EQL_DTAFIN < CURRENT_DATE '+
                      '    AND EQLDET.EQD_DTAIPS IS NOT NULL '+
                      '    AND EQLDET.EQD_DTAIPE IS NULL     '+
                      '    AND CONEQL.EQL_STATUS IN (''A'',''F'') '+
                      '    AND CONEQL.EQL_CODCLI = :CODCLI');

    qrySelect.ParamByName('CODCLI').AsString := FCodCli;
    qrySelect.Open;

    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'EQUIPAMENTO', 55  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CONTRATO', 15 , alCentro , teAutcom);
    objLinha.pAddColuna(''  , 'INICIO', 20 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'TÉRMINO', 20 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'STATUS', 10 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    If Not qrySelect.IsEmpty Then
    Begin
      While Not qrySelect.EOF Do
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('EQUIPAMENTO', qrySelect.FieldByName('EQUIPAMENTO').AsString , 55  , alEsquerda);
        objLinha.pAddColuna('CONTRATO', qrySelect.FieldByName('EQL_NROCON').AsString , 15 , alCentro);
        objLinha.pAddColuna('INICIO', FormatDateTime('dd/mm/yyyy hh:mm', qrySelect.FieldByName('EQL_DTAINI').AsDateTime + qrySelect.FieldByName('EQL_HORINI').AsDateTime)  , 20  , alCentro);
        objLinha.pAddColuna('TÉRMINO', FormatDateTime('dd/mm/yyyy hh:mm', qrySelect.FieldByName('EQL_DTAFIN').AsDateTime + qrySelect.FieldByName('EQL_HORFIN').AsDateTime) , 20 , alCentro);
        objLinha.pAddColuna('STATUS', qrySelect.FieldByName('EQL_STATUS').AsString , 10 , alDireita);
        objTabela.lstLinhas.Add(objLinha);

        qrySelect.Next;
      End;
    End;
    objLiberacao.strDirAce    := 'PECTVN';

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strMsgSen := 'Novo contrato para cliente com contratos vencidos pendentes de retorno de equipamento.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := qrySelect.RecordCount <= 0 ;

    If Not Result Then
      Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(qrySelect);
    FreeAndNil(objLiberacao);
  End;
End;

function TContratoLocacaoEquipamentos.fValidarDatasContrato(aDataInicial,
  aDataFinal: TDateTime): Boolean;
begin
  FSLMensagemRetorno.Clear;
  Result := True;

  If FBlnProrrogacao Then
  Begin
    If aDataFinal <= FDataFinalEstimada Then
    Begin
      FSLMensagemRetorno.Add('Na prorrogação só é permitido informar uma data superior à data de término inicial do contrato.');
      Result := False;
      Exit;
    End;
  End;

  If FDataInicialEstimada = aDataInicial Then
  Begin
    If FDataFinalEstimada = aDataFinal Then
      Exit;
  End;

  If (aDataInicial >= aDataFinal) Then
  Begin
    FSLMensagemRetorno.Add('A data e hora final do contrato deve ser maior ou igual à data inicial do contrato!');
    Result := False;
    Exit;
  End;

end;

function TContratoLocacaoEquipamentos.fValidaResponsaveisContrato: Boolean;
begin
  Result := True;

  FSLMensagemRetorno.Clear;
  If FListaResp.Count >= cst_QTD_MAXIMA_RESPONSAVEIS_CONTRATO Then
  Begin
    Result := False;
    FSLMensagemRetorno.Add('Não é permitido informar mais de dois responsáveis no contrato.');
  End;
end;

function TContratoLocacaoEquipamentos.fValidarInspecao: Boolean;
begin
  Result := fValidarInspecaoSaidaEquipamentos;

  If Result Then
    Result := fValidarInspecaoEntradaEquipamentos;

end;

function TContratoLocacaoEquipamentos.fValidarInspecaoEntradaEquipamentos(strCodEql: String = ''): Boolean;
var
  intCnt,
  intCont: Integer;
  intNroAcessoriosSemInspecao,
  intTotAcessoriosSemInspecao: Integer;
begin
  FSLMensagemRetorno.Clear;
  If fEmptyStr(strCodEql) Then
    FSLMensagemRetorno.Add('Para finalizar a inspeção de entrada, é preciso que todos os acessórios ligados ao equipamento também tenham ' +
                           'sua inspeção realizada. Finalize a inspeção dos acessórios para concluir a rotina. ');

  intTotAcessoriosSemInspecao := 0;
  For intCnt := 0 to FListaItens.Count -1 Do
  Begin
    If Not fEmptyStr(strCodEql) Then
    Begin
      If FListaItens[intCnt].FEquipamento.Codigo <> strCodEql Then
        Continue;
    End;

    If FListaItens[intCnt].InspecaoEntradaRealizada Then
    Begin
      intNroAcessoriosSemInspecao := 0;
      For intCont:= 0 to FListaItens[intCnt].Acessorios.Count -1 Do
      Begin
        If Not FListaItens[intCnt].Acessorios[intCont].InspecaoEntradaRealizada  Then
        Begin
          If intNroAcessoriosSemInspecao = 0  Then
          Begin
            FSLMensagemRetorno.Add('');
            FSLMensagemRetorno.Add('Equipamento: ' + FListaItens[intCnt].Equipamento.Codigo + ' - ' + FListaItens[intCnt].Equipamento.Descricao);
            FSLMensagemRetorno.Add('Acessórios:  ');
          End;
          FSLMensagemRetorno.Add(FListaItens[intCnt].Acessorios[intCont].Acessorio.Codigo + ' - ' + FListaItens[intCnt].Acessorios[intCont].Acessorio.Descricao);
          Inc(intNroAcessoriosSemInspecao);
        End;
        intTotAcessoriosSemInspecao := intTotAcessoriosSemInspecao + intNroAcessoriosSemInspecao;
      End;
    End;
  End;

  If intTotAcessoriosSemInspecao = 0 Then
  Begin
    FSLMensagemRetorno.Clear;
    Result := True;
  End
  Else
    Result := False;
end;

function TContratoLocacaoEquipamentos.fValidarInspecaoSaidaEquipamentos(strCodEql: String = ''): Boolean;
var
  intCnt,
  intCont: Integer;
  intNroAcessoriosSemInspecao,
  intTotAcessoriosSemInspecao: Integer;
begin
  FSLMensagemRetorno.Clear;
  If fEmptyStr(strCodEql) Then
    FSLMensagemRetorno.Add('Para finalizar a inspeção de saída, é preciso que todos os acessórios ligados ao equipamento também tenham ' +
                           'sua inspeção realizada. Finalize a inspeção dos acessórios para concluir a rotina. ');

  intTotAcessoriosSemInspecao := 0;

  For intCnt := 0 to FListaItens.Count -1 Do
  Begin
    If FListaItens[intCnt].InspecaoSaidaRealizada Then
    Begin
      intNroAcessoriosSemInspecao := 0;

      For intCont:= 0 to FListaItens[intCnt].Acessorios.Count -1 Do
      Begin
        If Not FListaItens[intCnt].Acessorios[intCont].FInspecaoSaidaRealizada  Then
        Begin
          If intNroAcessoriosSemInspecao = 0 Then
          Begin
            FSLMensagemRetorno.Add('');
            FSLMensagemRetorno.Add('Equipamento: ' +FListaItens[intCnt].Equipamento.Codigo + ' - ' + FListaItens[intCnt].Equipamento.Descricao);
            FSLMensagemRetorno.Add('Acessórios:  ');
          End;
          FSLMensagemRetorno.Add(FListaItens[intCnt].Acessorios[intCont].Acessorio.Codigo + ' - ' + FListaItens[intCnt].Acessorios[intCont].Acessorio.Descricao);
          Inc(intNroAcessoriosSemInspecao);
        End;
        intTotAcessoriosSemInspecao := intTotAcessoriosSemInspecao + intNroAcessoriosSemInspecao;
      End;
    End;
  End;

  If intTotAcessoriosSemInspecao = 0 Then
  Begin
    FSLMensagemRetorno.Clear;
    Result := True;
  End
  Else
    Result := False;
end;

function TContratoLocacaoEquipamentos.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TContratoLocacaoEquipamentos.GetAUT_PD: String;
begin
  Result := FAUT_PD;
end;

function TContratoLocacaoEquipamentos.GetBlnFat: Boolean;
begin
  Result := FblnCarregarDadosFaturamento;
end;

function TContratoLocacaoEquipamentos.GetBlnIns: Boolean;
begin
  Result := FblnInspecaoRealizada;
end;

function TContratoLocacaoEquipamentos.GetBlnPrg: Boolean;
begin
  Result := FBlnProrrogacao;
end;

function TContratoLocacaoEquipamentos.GetCliente: TClienteContratoLocacao;
begin
  Result := FCliente;
end;

function TContratoLocacaoEquipamentos.GetCodCli: String;
begin
  Result := FCodCli;
end;

function TContratoLocacaoEquipamentos.GetCodCnd: String;
begin
  Result := FCodCnd;
end;

function TContratoLocacaoEquipamentos.GetCodEmp: String;
begin
  Result := FCodFpg;
end;

function TContratoLocacaoEquipamentos.GetCodFpg: String;
begin
  Result := FCodFpg;
end;

function TContratoLocacaoEquipamentos.GetConPag: String;
begin
  Result := FConPag;
end;

function TContratoLocacaoEquipamentos.GetDtaFin: TDateTime;
begin
  Result := FDtaFin;
end;

function TContratoLocacaoEquipamentos.GetDtaIni: TDateTime;
begin
  Result := FDtaIni;
end;

function TContratoLocacaoEquipamentos.GetDtFEst: TDateTime;
begin
  Result := FDataFinalEstimada;
end;

function TContratoLocacaoEquipamentos.GetDtIEst: TDateTime;
begin
  Result := FDataInicialEstimada;
end;

function TContratoLocacaoEquipamentos.GetDdoCli: Boolean;
begin
  Result := FblnCarregarDadosCliente;
end;

function TContratoLocacaoEquipamentos.GetDeclar: String;
begin
  Result := FDeclar;
end;

function TContratoLocacaoEquipamentos.GetDesFpg: String;
begin
  Result := FDesFpg;
end;

function TContratoLocacaoEquipamentos.GetEmitente: TEmitenteContratoLocacao;
begin
  Result := FEmitente;
end;

function TContratoLocacaoEquipamentos.GetEndObr: String;
begin
  Result := FstrEndObr;
end;

function TContratoLocacaoEquipamentos.GetEntCli: String;
begin
  Result := FEntCli;
end;

function TContratoLocacaoEquipamentos.GetHorFin: TDateTime;
begin
  Result := FHorFin;
end;

function TContratoLocacaoEquipamentos.GetHorIni: TDateTime;
begin
  Result := FHorIni;
end;

function TContratoLocacaoEquipamentos.GetIndSel: Integer;
begin
  Result := FIndiceEquipamentoSelecionado;
end;

function TContratoLocacaoEquipamentos.GetLItens: TList<TItemContratoLocacaoEquipamentos>;
begin
  Result := FListaItens;
end;

function TContratoLocacaoEquipamentos.GetLResp: TList<TCliCtt>;
begin
  Result := FListaResp;
end;

function TContratoLocacaoEquipamentos.GetMesFin: TDateTime;
begin
  Result := FMesFin;
end;

function TContratoLocacaoEquipamentos.GetMesIni: TDateTime;
begin
  Result := FMesIni;
end;

function TContratoLocacaoEquipamentos.GetMsgRet: String;
begin
  Result := FSLMensagemRetorno.Text;
end;

function TContratoLocacaoEquipamentos.GetNomCli: String;
begin
  Result := FNomCli;
end;

function TContratoLocacaoEquipamentos.GetNroCon: String;
begin
  Result := FNroCon;
end;

function TContratoLocacaoEquipamentos.GetNumDoc: String;
begin
  Result := FNumDoc;
end;

function TContratoLocacaoEquipamentos.GetPedAdt: TAdiantamentoContrato;
begin
  Result := FAdiantamento;
end;

function TContratoLocacaoEquipamentos.GetPedCom: String;
begin
  Result := FPedCom;
end;

function TContratoLocacaoEquipamentos.fVerificaInspecaoSaidaPendente(const aSeqEql: String): Boolean;
var
  qry: TUniQuery;
Begin
  Result := True;

  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('SELECT COUNT(AUTOINCREM) AS QTDINSP_PENDENTE FROM EQLDET WHERE EQD_SEQCON = :EQD_SEQCON AND EQD_DTAIPS IS NULL AND EQD_SEQEQL = :EQD_SEQEQL');
    qry.ParamByName('EQD_SEQCON').AsString := FAutInc;
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

function TContratoLocacaoEquipamentos.fVerificaPedAdtGerado: Boolean;
begin
  If Not fCfgSis('CPGCTR', VarBoolean) Then
    Exit(True);

  pCarregarDadosAdiantamento;

  Result := Not fEmptyStr( FAdiantamento.NumDocAdt );
end;

function TContratoLocacaoEquipamentos.GetQtdEqu: Double;
begin
  Result := FQtdTEq;
end;

function TContratoLocacaoEquipamentos.GetStatus: String;
begin
  Result := FStatus;
end;

function TContratoLocacaoEquipamentos.GetStrLoc: String;
begin
  Result := FstrLoc;
end;

function TContratoLocacaoEquipamentos.GetStrMesFin: String;
begin
  Result := FstrMesFin;
end;

function TContratoLocacaoEquipamentos.GetStrMesIni: String;
begin
  Result := FstrMesIni;
end;

function TContratoLocacaoEquipamentos.GetTaxEnt: Double;
begin
  Result := FVlTxEn;
end;

function TContratoLocacaoEquipamentos.GetTipDur: String;
begin
  Result := FTipDur;
end;

function TContratoLocacaoEquipamentos.GetTotAqu: Double;
begin
  Result := FVlrTotAqu;
end;

function TContratoLocacaoEquipamentos.GetTotCob: Double;
begin
  Result := FValorTotalCobranca;
end;

function TContratoLocacaoEquipamentos.GetTotCon: Double;
begin
  Result := FTotCon;
end;

function TContratoLocacaoEquipamentos.GetTotDEst: Double;
begin
  Result := FTotalDiasEstimado;
end;

function TContratoLocacaoEquipamentos.GetTotDia: Integer;
begin
  Result := FTotDia;
end;

function TContratoLocacaoEquipamentos.GetTotHEst: Double;
begin
  Result := FTotalHorasEstimadas;
end;

function TContratoLocacaoEquipamentos.GetTotHor: Double;
begin
  Result := FTotHor;
end;

function TContratoLocacaoEquipamentos.GetTotMes: Integer;
begin
  Result := FTotMes;
end;

function TContratoLocacaoEquipamentos.GetTotMEst: Integer;
begin
  Result := FTotalMesesEstimado;
end;

function TContratoLocacaoEquipamentos.GetVendedor: TVendedorContratoLocacao;
begin
  Result := FVendedor;
end;

function TContratoLocacaoEquipamentos.GetVlrTot: Double;
begin
  Result := FValorTotalContrato;
end;

function TContratoLocacaoEquipamentos.GetVlrTotAdc: Double;
begin
  Result := FVlrTotAdc;
end;

function TContratoLocacaoEquipamentos.GetVlrTotLoc: Double;
begin
  Result := FVlrTotLoc;
end;

procedure TContratoLocacaoEquipamentos.pAtualizarDataTerminoContrato;
var
  qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('UPDATE CONEQL               ');
    qry.SQL.Add('SET                         ');
    qry.SQL.Add('  EQL_DTAFIN = :EQL_DTAFIN, ');
    qry.SQL.Add('  EQL_HORFIN = :EQL_HORFIN, ');
    qry.SQL.Add('  EQL_TOTHOR = :EQL_TOTHOR, ');
    qry.SQL.Add('  EQL_TOTDIA = :EQL_TOTDIA, ');
    qry.SQL.Add('  EQL_TOTCON = :EQL_TOTCON  ');
    qry.SQL.Add('WHERE                       ');
    qry.SQL.Add('  AUTOINCREM = :AUTOINCREM  ');
    qry.ParamByName('AUTOINCREM').AsString   := FAutInc;
    qry.ParamByName('EQL_DTAFIN').AsDatetime := FDtaFin;
    qry.ParamByName('EQL_HORFIN').AsDatetime := FHorFin;
    qry.ParamByName('EQL_TOTHOR').AsFloat    := FTotHor;
    qry.ParamByName('EQL_TOTDIA').AsFloat    := FTotDia;
    qry.ParamByName('EQL_TOTCON').AsFloat    := FVlrTotLoc;
    qry.ExecSQL;

    pAtualizarItensContrato;
  Finally
    FreeAndNil(qry);
  End;
end;

procedure TContratoLocacaoEquipamentos.pAtualizarItensContrato;
var
  qry: TUniQuery;
  intCnt: Integer;
begin
  qry := fCriaQuery;
  Try
    qry.DisableControls;

    For intCnt := 0 to FListaItens.Count-1 Do
    Begin
      If FListaItens[intCnt].DataEncerramento <= 0 Then
      Begin
        qry.SQL.Clear;
        qry.SQL.Add('UPDATE EQLDET               ');
        qry.SQL.Add('SET                         ');
        qry.SQL.Add('  EQD_VALHOR = :EQD_VALHOR, ');
        qry.SQL.Add('  EQD_TOTEQL = :EQD_TOTEQL, ');
        qry.SQL.Add('  EQD_PERDES = :EQD_PERDES, ');
        qry.SQL.Add('  EQD_VLLOCL = :EQD_VLLOCL, ');
        qry.SQL.Add('  EQD_TOTLIQ = :EQD_TOTLIQ, ');
        qry.SQL.Add('  EQD_VLRALT = :EQD_VLRALT, ');
        qry.SQL.Add('  EQD_VLRAQU = :EQD_VLRAQU, ');
        qry.SQL.Add('  EQD_TOTDIA = :EQD_TOTDIA, ');
        qry.SQL.Add('  EQD_TOTHOR = :EQD_TOTHOR  ');
        qry.SQL.Add('WHERE                       ');
        qry.SQL.Add('  AUTOINCREM = :AUTOINCREM  ');

        qry.ParamByName('AUTOINCREM').AsString := FListaItens[intCnt].FAutInc;
        qry.ParamByName('EQD_VALHOR').AsFLoat  := FListaItens[intCnt].ValorLocacaoContratado;
        qry.ParamByName('EQD_TOTEQL').AsFLoat  := FListaItens[intCnt].ValorTotalLocacaoContratado;
        qry.ParamByName('EQD_VLLOCL').AsFLoat  := FListaItens[intCnt].ValorLocacaoLiquido;
        qry.ParamByName('EQD_TOTLIQ').AsFLoat  := FListaItens[intCnt].ValorTotalLiquido;
        qry.ParamByName('EQD_VLRAQU').AsFLoat  := FListaItens[intCnt].Equipamento.ValorAqu;
        qry.ParamByName('EQD_PERDES').AsFLoat  := FListaItens[intCnt].FPerDes;
        qry.ParamByName('EQD_TOTDIA').AsFLoat  := FTotDia;
        qry.ParamByName('EQD_TOTHOR').AsFLoat  := FTotHor;
        qry.ParamByName('EQD_VLRALT').AsString := IIF(FListaItens[intCnt].blnValorLocacaoAlteradoManualmente, 'S', 'N');
        qry.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qry);
  End;
end;

procedure TContratoLocacaoEquipamentos.pAtualizaTotalContrato;
var
  qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('UPDATE CONEQL               ');
    qry.SQL.Add('SET                         ');
    qry.SQL.Add('  EQL_TOTCON = :EQL_TOTCON  ');
    qry.SQL.Add('WHERE                       ');
    qry.SQL.Add('  AUTOINCREM = :AUTOINCREM  ');

    qry.ParamByName('AUTOINCREM').AsString := FAutInc;
    qry.ParamByName('EQL_TOTCON').AsFLoat  := FValorTotalContrato;

    qry.ExecSQL;
  Finally
    FreeAndNil(qry);
  End;
end;

procedure TContratoLocacaoEquipamentos.pCalculaDuracaoContrato;
var
  intCnt: Integer;
begin
  FDtaIni := fObtemData(FDtaIni);
  FDtaFin := fObtemData(FDtaFin);
  FHorIni := fObtemHora(FHorIni);
  FHorFin := fObtemHora(FHorFin);

  FTipDur := fRetornaTipoDuracaoContrato;
  If FTipDur = 'M' Then
  Begin
    FDtaIni := fObtemData(FMesIni);
    FDtaFin := fObtemData(FMesFin);
    FHorIni := 0;
    FHorFin := 0;
  End;

  FTotHor := TCalcularPeriodoFatura.New.CalculaTotalHoras(FDtaIni + FHorIni, FDtaFin + FHorFin);
  FTotDia := TCalcularPeriodoFatura.New.CalculaTotalDias(FDtaIni + FHorIni, FDtaFin + FHorFin);
  FTotMes := TCalcularPeriodoFatura.New.CalculaTotalMeses(FMesIni, FMesFin);

  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    Case FListaItens[intCnt].TipoCalculoLocacao Of
      tpDiaria : FListaItens[intCnt].Duracao := FTotDia;
      tpHoras  : FListaItens[intCnt].Duracao := FTotHor;
      tpMensal : FListaItens[intCnt].Duracao := FTotMes;
    End;
  End;
end;

procedure TContratoLocacaoEquipamentos.pCalculaTotais;
var
  intCnt: Integer;
  intCont: Integer;
begin
  FValorTotalContrato := 0;
  FValorTotalCobranca := 0;
  FVlrTotLoc := 0;
  FVlrTotAqu := 0;
  FQtdTEq    := 0;
  FVlrTotAdc := 0;
  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    FListaItens[intCnt].pCalcularValorLocacao;
    FVlrTotLoc := FVlrTotLoc + FListaItens[intCnt].ValorTotalLiquido;
    FValorTotalCobranca := FValorTotalCobranca + FListaItens[intCnt].ValorCobranca;
    FVlrTotAqu :=  FVlrTotAqu + FListaItens[intCnt].Equipamento.ValorAqu;
    For intCont := 0 to FListaItens[intCnt].FListaAcessorios.Count -1 Do
    Begin
      FValorTotalCobranca := FValorTotalCobranca + FListaItens[intCnt].FListaAcessorios[intCont].ValorCobranca;
      FVlrTotAqu := FVlrTotAqu + (FListaItens[intCnt].FListaAcessorios[intCont].Acessorio.ValorAqu * FListaItens[intCnt].FListaAcessorios[intCont].Quantidade);
      FVlrTotAdc := FVlrTotAdc + (FListaItens[intCnt].Quantidade * (FListaItens[intCnt].FListaAcessorios[intCont].ValorAdicional * FListaItens[intCnt].FListaAcessorios[intCont].Quantidade));
    End;
    FQtdTEq := FQtdTEq + FListaItens[intCnt].Quantidade;
  End;

  FValorTotalContrato := FVlrTotLoc  + FVlTxEn + FVlrTotAdc;
end;

procedure TContratoLocacaoEquipamentos.pCarregarLocalizacao;
var
  qryEntCli: TUniQuery;
begin
  If fEmptyStr(FEntCli) or
     fEmptyStr(FCodCli) Then
    Exit;

  qryEntCli := fCriarQuery('SELECT ENTCLI.AUTOINCREM, ' +
                           '       CONCAT(ETC_ENDENT, " - ", ETC_BAIENT, " - ", CID_NOMCID, " - ", CID_ESTADO) AS ETC_ENDENT ' +
                           '  FROM ENTCLI ' +
                           '  INNER JOIN CADCID ON CID_CODCID = ETC_CIDENT ' +
                           '  WHERE ETC_CODCLI = :CODCLI AND ' +
                           '        ENTCLI.AUTOINCREM = :CODENT', nil);

  Try
    qryEntCli.ParamByName('CODCLI').AsString := FCodCli;
    qryEntCli.ParamByName('CODENT').AsString := FEntCli;
    qryEntCli.Open;

    If Not qryEntCli.IsEmpty Then
    Begin
      FstrLoc := qryEntCli.FieldByName('ETC_ENDENT').AsString;
    End;
  Finally
    FreeAndNil(qryEntCli);
  End;
end;

procedure TContratoLocacaoEquipamentos.pCarregarResponsaveis;
var
  strSQLSelect: String;
  qryConsulta: TUniQuery;
begin
  FListaResp.Clear;
  strSQLSelect := ' SELECT EQR_CODCLI, EQR_SEQCTT FROM EQLRSP ' +
                  '  INNER JOIN CONEQL ON CONEQL.AUTOINCREM = EQR_SEQCON ' +
                  '  WHERE EQR_SEQCON = :SEQCON ' ;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(strSQLSelect);
    qryConsulta.ParamByName('SEQCON').AsString := FAutInc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      qryConsulta.First;
      While Not qryConsulta.EOF Do
      Begin
        fAddResponsavel(qryConsulta.FieldByName('EQR_CODCLI').AsString,
                        qryConsulta.FieldByName('EQR_SEQCTT').AsString);

        qryConsulta.Next;
      End;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

function TContratoLocacaoEquipamentos.fCarregarContrato(const strAutInc: String = ''; const strCodCon: String = '';
  ablnCarregarDadosCliente: Boolean = False; const strNumPed: String = ''): Boolean;
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
  strAux: String;
begin
  Result := False;

  pLimpar;

  If fEmptyStr(strAutInc) and
     fEmptyStr(strCodCon) and
     fEmptyStr(strNumPed) Then
    Exit;

  FblnCarregarDadosCliente := ablnCarregarDadosCliente;

  SQLSelect := 'SELECT CONEQL.AUTOINCREM, ' +
               '       EQL_NROCON,        ' +
               '       EQL_STATUS,        ' +
               '       EQL_CODCLI,        ' +
               '       CLI_NOMCLI,        ' +
               '       EQL_CODVEN,        ' +
               '       OPE_NOMOPE,        ' +
               '       EQL_ENTCLI,        ' +
               '       EQL_DTAINI,        ' +
               '       EQL_DTAFIN,        ' +
               '       EQL_HORINI,        ' +
               '       EQL_HORFIN,        ' +
               '       EQL_TOTHOR,        ' +
               '       EQL_TOTCON,        ' +
               '       EQL_QTDEQU,        ' +
               '       EQL_CODEMP,        ' +
               '       EQL_DECLAR,        ' +
               '       EQL_TOTDIA,        ' +
               '       EQL_CONPAG,        ' +
               '       EQL_CODCND,        ' +
               '       EQL_CODFPG,        ' +
               '       FPG_DESCRI,        ' +
               '       EQL_AUT_PD,        ' +
               '       CONCAT(FGO_NUMDOC, " - " , FGO_CODEMP) AS NUMDOC_PD, '+
               '       EQL_TAXENT,        ' +
               '       EQL_MESINI,        ' +
               '       EQL_MESFIN,        ' +
               '       EQL_TIPDUR,        ' +
               '       EQL_TOTMES,        ' +
               '       EQL_PEDCOM,        ' +
               '       EQL_ENDOBR,        ' +
               '       EQL_TOTADC         ' +
               'FROM CONEQL               ' +
               'INNER JOIN CADCLI ON EQL_CODCLI = CLI_CODCLI  ' +
               'INNER JOIN CADOPE ON EQL_CODVEN = OPE_CODOPE  ' +
               'LEFT  JOIN CADFPG ON EQL_CODFPG = FPG_CODIGO  ' +
               'LEFT  JOIN FATGOR ON EQL_AUT_PD = FATGOR.AUTOINCREM  ' +
               'WHERE TRUE ';

  If Not fEmptyStr(strAutInc) Then
    SQLSelect := SQLSelect +  ' AND CONEQL.AUTOINCREM = :AUTOINCREM ';

  If Not fPermiteCarregarContratoOutraEmpresa  Then
    SQLSelect := SQLSelect + '  AND CONEQL.EQL_CODEMP = ' + QuotedStr(VS_strCodEmp) ;

  If Not fEmptyStr(strCodCon) Then
  Begin
    SQLSelect := SQLSelect +  ' AND CONEQL.EQL_NROCON = :EQL_NROCON ';
  End;

  If Not fEmptyStr(strNumPed) Then
  Begin
    SQLSelect := SQLSelect + '  AND CONEQL.EQL_CODEMP = ' + QuotedStr(VS_strCodEmp) ;
    SQLSelect := SQLSelect +  ' AND FATGOR.FGO_CODEMP = :CODEMP ';
    SQLSelect := SQLSelect +  ' AND FATGOR.FGO_ESPDOC = :ESPDOC ';
    SQLSelect := SQLSelect +  ' AND FATGOR.FGO_NUMDOC = :NUMDOC ';
  End;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    If qryConsulta.Params.FindParam('AUTOINCREM') <> Nil Then
      qryConsulta.ParamByName('AUTOINCREM').AsString := strAutInc;
    If qryConsulta.Params.FindParam('EQL_NROCON') <> Nil Then
      qryConsulta.ParamByName('EQL_NROCON').AsString := strCodCon;

    If Not fEmptyStr(strNumPed) Then
    Begin
      qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryConsulta.ParamByName('ESPDOC').AsString := 'PD';
      qryConsulta.ParamByName('NUMDOC').AsString := strNumPed;
    End;

    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      FAutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;
      FCodCli := qryConsulta.FieldByName('EQL_CODCLI').AsString;
      FNomCLi := qryConsulta.FieldByName('CLI_NOMCLI').AsString;
      FCodEmp := qryConsulta.FieldByName('EQL_CODEMP').AsString;
      FDtaFin := qryConsulta.FieldByName('EQL_DTAFIN').AsDateTime;
      FDtaIni := qryConsulta.FieldByName('EQL_DTAINI').AsDateTime;
      FDeclar := qryConsulta.FieldByName('EQL_DECLAR').AsString;
      FEntCli := qryConsulta.FieldByName('EQL_ENTCLI').AsString;
      FHorFin := qryConsulta.FieldByName('EQL_HORFIN').AsDateTime;
      FHorIni := qryConsulta.FieldByName('EQL_HORINI').AsDateTime;
      FNroCon := qryConsulta.FieldByName('EQL_NROCON').AsString;
      FQtdTEq := qryConsulta.FieldByName('EQL_QTDEQU').AsFloat;
      FStatus := qryConsulta.FieldByName('EQL_STATUS').AsString;
      FTotCon := qryConsulta.FieldByName('EQL_TOTCON').AsFloat;
      FTotHor := qryConsulta.FieldByName('EQL_TOTHOR').AsFloat;
      FTotDia := qryConsulta.FieldByName('EQL_TOTDIA').AsInteger;
      FConPag := qryConsulta.FieldByName('EQL_CONPAG').AsString;
      FCodCnd := qryConsulta.FieldByName('EQL_CODCND').AsString;
      FCodFpg := qryConsulta.FieldByName('EQL_CODFPG').AsString;
      FDesFpg := qryConsulta.FieldByName('FPG_DESCRI').AsString;
      FAUT_PD := qryConsulta.FieldByName('EQL_AUT_PD').AsString;
      FNumDoc := qryConsulta.FieldByName('NUMDOC_PD').AsString;
      FVlTxEn := qryConsulta.FieldByName('EQL_TAXENT').AsFloat;
      FTipDur := qryConsulta.FieldByName('EQL_TIPDUR').AsString;
      FPedCom := qryConsulta.FieldByName('EQL_PEDCOM').AsString;
      FstrEndObr := qryConsulta.FieldByName('EQL_ENDOBR').AsString;
      FVlrTotAdc := qryConsulta.FieldByName('EQL_TOTADC').AsFloat;

      FDataInicialEstimada := FDtaIni + FHorIni;
      FDataFinalEstimada := FDtaFin + FHorFin;
      FTotalDiasEstimado := FTotDia;
      FTotalHorasEstimadas := FTotHor;

      If qryConsulta.FieldByName('EQL_TIPDUR').AsString = 'M' Then
      Begin
        strAux := DateTimeToStr(qryConsulta.FieldByName('EQL_MESINI').AsDateTime);
        FstrMesIni := Copy(strAux, Pos('/', strAux) + 1, Length(strAux)) ;
        strAux := DateTimeToStr(qryConsulta.FieldByName('EQL_MESFIN').AsDateTime);
        FstrMesFin := Copy(strAux, Pos('/', strAux) + 1, Length(strAux)) ;

        FMesIni := qryConsulta.FieldByName('EQL_MESINI').AsDateTime;
        FMesFin := qryConsulta.FieldByName('EQL_MESFIN').AsDateTime;
        FTotMes := qryConsulta.FieldByName('EQL_TOTMES').AsInteger;

        FDataInicialEstimada := FMesIni;
        FDataFinalEstimada := FMesFin;
        FTotalMesesEstimado := FTotMes;
      End;

      FEmitente.pCarregar(FCodEmp);
      FVendedor.pCarregar(qryConsulta.FieldByName('EQL_CODVEN').AsString);
      pCarregarItensContrato;
      FAdiantamento.pCarregar(FAUT_PD);
      pCarregarResponsaveis;

      If FblnCarregarDadosCliente Then
        FCliente.pCarregar(FCodCli, FAutInc) ;

      pCarregarLocalizacao;

      pCalculaTotais;

      Result := True;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TContratoLocacaoEquipamentos.pCarregarDadosAdiantamento;
begin
  FAdiantamento.pCarregar(FAUT_PD);
end;

procedure TContratoLocacaoEquipamentos.pCarregarDadosCliente;
begin
  FCliente.pCarregar(FCodCli, FAutInc);
end;

procedure TContratoLocacaoEquipamentos.pCarregarDadosEmitente;
begin
  If fEmptyStr(FCodEmp) Then
    FCodEmp := VS_strCodEmp;
  FEmitente.pCarregar(FCodEmp);
end;

procedure TContratoLocacaoEquipamentos.pCarregarDuracaoContrato;
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
begin
  SQLSelect := 'SELECT CONEQL.AUTOINCREM, ' +
               '       EQL_DTAINI,        ' +
               '       EQL_DTAFIN,        ' +
               '       EQL_HORINI,        ' +
               '       EQL_HORFIN,        ' +
               '       EQL_TOTHOR,        ' +
               '       EQL_TOTDIA,        ' +
               '       EQL_TOTCON,        ' +
               '       EQL_TOTMES         ' +
               '  FROM CONEQL             ' +
               '  WHERE CONEQL.AUTOINCREM = :AUTOINCREM ';
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);

    qryConsulta.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      FDtaFin := qryConsulta.FieldByName('EQL_DTAFIN').AsDateTime + qryConsulta.FieldByName('EQL_HORFIN').AsDateTime;
      FDtaIni := qryConsulta.FieldByName('EQL_DTAINI').AsDateTime + qryConsulta.FieldByName('EQL_HORINI').AsDateTime;
      FHorFin := qryConsulta.FieldByName('EQL_HORFIN').AsDateTime;
      FHorIni := qryConsulta.FieldByName('EQL_HORINI').AsDateTime;
      FTotCon := qryConsulta.FieldByName('EQL_TOTCON').AsFloat;
      FTotHor := qryConsulta.FieldByName('EQL_TOTHOR').AsFloat;
      FTotDia := qryConsulta.FieldByName('EQL_TOTDIA').AsInteger;
      FTotMes := qryConsulta.FieldByName('EQL_TOTMES').AsInteger;

      pCalculaDuracaoContrato;
      pRecalculaItensContrato;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TContratoLocacaoEquipamentos.pCarregarItensContrato;
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
  item: TItemContratoLocacaoEquipamentos;
begin
  pLimparItens;

  SQLSelect := 'SELECT EQLDET.*,                          ' +
               '  IF(                                     ' +
               '    EQD_DTAIPS IS NULL,                   ' +
               '    "PENDENTE",                           ' +
               '     CONCAT(                              ' +
               '      "REALIZADA ",                       ' +
               '      DATE_FORMAT(EQD_DTAIPS, "%d/%m/%Y") ' +
               '    )                                     ' +
               '  ) AS EQD_STTIPS,                        ' +
               '  IF(                                     ' +
               '    EQD_DTAIPE IS NULL,                   ' +
               '    "PENDENTE",                           ' +
               '    CONCAT(                               ' +
               '      "REALIZADA ",                       ' +
               '      DATE_FORMAT(EQD_DTAIPE, "%d/%m/%Y") ' +
               '    )                                     ' +
               '  ) AS EQD_STTIPE,                        ' +
               '  E.OPE_NOMOPE AS  OPE_NOMIPE,            ' +
               '  CONCAT(                                 ' +
               '    EQD_NUMENV,                           ' +
               '    "-",                                  ' +
               '    EQD_ESPENV,                           ' +
               '    "-",                                  ' +
               '    EQD_EMPENV                            ' +
               '  ) AS EQD_DOCENV,                        ' +
               '  CONCAT(                                 ' +
               '    EQD_NUMRET,                           ' +
               '    "-",                                  ' +
               '    EQD_ESPRET,                           ' +
               '    "-",                                  ' +
               '    EQD_EMPRET                            ' +
               '  ) AS EQD_DOCRET,                        ' +
               '  (SELECT MAX(EQF_DTAENC)                 ' +
               '     FROM EQLFAT                          ' +
               '     WHERE EQF_SEQCON = EQD_SEQCON AND    ' +
               '           EQF_SEQEQL = EQD_SEQEQL ) AS EQF_DTAENC, ' +
               '  SUPE.OPE_NOMOPE AS OPE_NOMSPE,          ' +
               '  SUPS.OPE_NOMOPE AS OPE_NOMSPS,          ' +
               '    EQD_NUMENV,                           ' +
               '    EQD_ESPENV,                           ' +
               '    EQD_EMPENV,                           ' +
               '    EQD_SERENV,                           ' +
               '    EQD_NUMRET,                           ' +
               '    EQD_ESPRET,                           ' +
               '    EQD_EMPRET,                           ' +
               '    EQD_SERRET,                           ' +
               '    EQD_DTAENC                            ' +
               'FROM EQLDET                               ' +
               'LEFT JOIN CADOPE E ON (E.OPE_CODOPE = EQLDET.EQD_OPEIPE)  ' +
               'LEFT JOIN CADOPE SUPE ON (SUPE.OPE_CODOPE = EQLDET.EQD_SUPIPE)  ' +
               'LEFT JOIN CADOPE SUPS ON (SUPS.OPE_CODOPE = EQLDET.EQD_SUPIPS)  ' +
               'WHERE EQD_SEQCON = :SEQCON    ' +
               'ORDER BY EQLDET.AUTOINCREM ';

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    qryConsulta.ParamByName('SEQCON').AsString := FAutInc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      While Not qryConsulta.EOF Do
      Begin
        item := fAddItem;
        item.AutInc  := qryConsulta.FieldByName('AUTOINCREM').AsString;
        item.TipoCalculoLocacao := fStrTipoCalculoVlLocacaoToTipoCalculoVlLocacao(qryConsulta.FieldByName('EQD_TIPDUR').AsString);
        item.Equipamento.pCarregaEquipamento('', qryConsulta.FieldByName('EQD_SEQEQL').AsString);
        item.ValorLocacaoContratado := qryConsulta.FieldByName('EQD_VALHOR').AsFloat;
        item.ValorTotalLocacaoContratado := qryConsulta.FieldByName('EQD_TOTEQL').AsFloat;
        item.PercentualDesconto := qryConsulta.FieldByName('EQD_PERDES').AsFloat;
        item.ValorLocacaoLiquido := qryConsulta.FieldByName('EQD_VLLOCL').AsFloat;
        item.ValorTotalLiquido := qryConsulta.FieldByName('EQD_TOTLIQ').AsFloat;
        item.ValorDesconto := item.ValorTotalLocacaoContratado - item.ValorTotalLiquido;
        item.blnValorLocacaoAlteradoManualmente := qryConsulta.FieldByName('EQD_VLRALT').AsString = 'S';
        item.strInspecaoEntrada := qryConsulta.FieldByName('EQD_STTIPE').AsString;
        item.strInspecaoSaida := qryConsulta.FieldByName('EQD_STTIPS').AsString;
        item.strCondicaoPerfeitaSaida := qryConsulta.FieldByName('EQD_CNDIPS').AsString;
        item.ObservacoesSaida := qryConsulta.FieldByName('EQD_OBSIPS').AsString;
        item.CodConferenteSaida := qryConsulta.FieldByName('EQD_OPEIPS').AsString;
        item.CodSupervisorSaida := qryConsulta.FieldByName('EQD_SUPIPS').AsString;
        item.NomSupervisorSaida := qryConsulta.FieldByName('OPE_NOMSPS').AsString;
        item.strHigienizado := qryConsulta.FieldByName('EQD_HIGIPE').AsString;
        item.strAvaria := qryConsulta.FieldByName('EQD_AVAIPE').AsString;
        item.ObservacoesEntrada := qryConsulta.FieldByName('EQD_OBSIPE').AsString;
        item.strGerarCobranca := qryConsulta.FieldByName('EQD_COBIPE').AsString;
        item.ValorCobranca := qryConsulta.FieldByName('EQD_VALIPE').AsFloat;
        item.CodConferenteEntrada := qryConsulta.FieldByName('EQD_OPEIPE').AsString;
        item.CodSupervisorEntrada := qryConsulta.FieldByName('EQD_SUPIPE').AsString;
        item.NomSupervisorEntrada := qryConsulta.FieldByName('OPE_NOMSPE').AsString;
        item.NomConferenteEntrada := qryConsulta.FieldByName('OPE_NOMIPE').AsString;
        item.DataInspecaoEntrada := qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime;
        item.DataInspecaoSaida := qryConsulta.FieldByName('EQD_DTAIPS').AsDateTime;
        item.HoraInspecaoEntrada := qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
        item.HoraInspecaoSaida := qryConsulta.FieldByName('EQD_HORIPS').AsDateTime;
        item.strDocEnv := qryConsulta.FieldByName('EQD_DOCENV').AsString;
        item.strDocRet := qryConsulta.FieldByName('EQD_DOCRET').AsString;
        item.InspecaoEntradaRealizada := item.DataInspecaoEntrada > 0;
        item.InspecaoSaidaRealizada := item.DataInspecaoSaida > 0;
        item.DataInicialCobranca := qryConsulta.FieldByName('EQD_DTACOB').AsDateTime + qryConsulta.FieldByName('EQD_HORCOB').AsDateTime;
        If item.InspecaoEntradaRealizada  Then
        Begin
          item.DataFinalCobranca := qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime + qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
          item.HoraFinalCobranca := qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
        End
        Else
        Begin
          item.DataFinalCobranca := fCalculaDataFinalCobranca(item.DataInicialCobranca, item.FContrato.FTotHor);
          item.HoraFinalCobranca := fCalculaDataFinalCobranca(item.DataInicialCobranca, item.FContrato.FTotHor);
        End;

        Case item.TipoCalculoLocacao Of
          tpHoras : item.Duracao := FTotHor;
          tpDiaria: item.Duracao := FTotDia;
          tpMensal: item.Duracao := FTotMes;
        End;
        item.ValorTotal := item.ValorTotalLiquido + item.ValorCobranca;
        item.DataEncerramento := IIF(qryConsulta.FieldByName('EQF_DTAENC').AsDateTime > 0,
                                     qryConsulta.FieldByName('EQF_DTAENC').AsDateTime,
                                     qryConsulta.FieldByName('EQD_DTAENC').AsDateTime);
        item.NumEnv := qryConsulta.FieldByName('EQD_NUMENV').AsString;
        item.EspEnv := qryConsulta.FieldByName('EQD_ESPENV').AsString;
        item.EmpEnv := qryConsulta.FieldByName('EQD_EMPENV').AsString;
        item.SerEnv := qryConsulta.FieldByName('EQD_SERENV').AsString;
        item.NumRet := qryConsulta.FieldByName('EQD_NUMRET').AsString;
        item.EspRet := qryConsulta.FieldByName('EQD_ESPRET').AsString;
        item.EmpRet := qryConsulta.FieldByName('EQD_EMPRET').AsString;
        item.SerRet := qryConsulta.FieldByName('EQD_SERRET').AsString;
        item.Quantidade := qryConsulta.FieldByName('EQD_QTDEQU').AsFloat;

        item.blnValorLocacaoAlteradoManualmente := IIF(qryConsulta.FieldByName('EQD_VLRALT').AsString = 'S', True, False);
        item.blnRecalcularVlrLocacao := (Not item.blnValorLocacaoAlteradoManualmente);

        item.pCarregarAcessorios;
        item.pCalculaValorTotalCobranca;

        qryConsulta.Next;
      End;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TContratoLocacaoEquipamentos.pExcluirAcessorios;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.DisableControls;
    qryDelete.SQL.Add('DELETE FROM ACLDET WHERE EQD_SEQCON = :EQD_SEQCON');
    qryDelete.ParamByName('EQD_SEQCON').AsString := FAutInc;
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TContratoLocacaoEquipamentos.pExcluirItens;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.DisableControls;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM EQLDET WHERE EQD_SEQCON = :EQD_SEQCON');
    qryDelete.ParamByName('EQD_SEQCON').AsString := FAutInc;
    qryDelete.ExecSQL;

    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM EQLNEG WHERE EQN_SEQCON = :EQN_SEQCON');
    qryDelete.ParamByName('EQN_SEQCON').AsString := FAutInc;
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TContratoLocacaoEquipamentos.pExcluirResponsaveis;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.DisableControls;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM EQLRSP WHERE EQR_SEQCON = :EQR_SEQCON');
    qryDelete.ParamByName('EQR_SEQCON').AsString := FAutInc;
    qryDelete.ExecSQL;

  Finally
    FreeAndNil(qryDelete);
  End;
end;

function TContratoLocacaoEquipamentos.fGravarResponsaveis: Boolean;
var
  intCnt: Integer;
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery;
  Try

    pExcluirResponsaveis;

    qryInsert.DisableControls;

    For intCnt := 0 To FListaResp.Count-1 Do
    Begin
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add('INSERT INTO EQLRSP (AUTOINCREM, EQR_SEQCTT, EQR_CODCLI, EQR_SEQCON)');
      qryInsert.SQL.Add('  VALUES (:AUTOINCREM, :EQR_SEQCTT, :EQR_CODCLI, :EQR_SEQCON)');

      qryInsert.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('EQLRSP', VS_strCodEmp);
      qryInsert.ParamByName('EQR_SEQCTT').AsString := FListaResp[intCnt].strAutoincrem;
      qryInsert.ParamByName('EQR_CODCLI').AsString := FListaResp[intCnt].strCodCli;
      qryInsert.ParamByName('EQR_SEQCON').AsString := FAutInc;

      qryInsert.ExecSQL;
    End;

    Result := FListaResp.Count > 0;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TContratoLocacaoEquipamentos.pLimpar;
begin
  FAutInc := EmptyStr;
  FCodCli := EmptyStr;
  FCodEmp := EmptyStr;
  FVendedor.pLimpar;
  FDtaFin := 0;
  FDtaIni := 0;
  FDeclar := EmptyStr;
  FEntCli := EmptyStr;
  FHorFin := 0;
  FHorIni := 0;
  FNroCon := EmptyStr;
  FQtdTEq := 0;
  FStatus := EmptyStr;
  FTotCon := 0;
  FTotHor := 0;
  FTotDia := 0;
  FTotMes := 0;
  FValorTotalContrato := 0;
  FValorTotalCobranca := 0;
  FIndiceEquipamentoSelecionado:= 0;
  FConPag := EmptyStr;
  FCodCnd := EmptyStr;
  FCodFpg := EmptyStr;
  FDesFpg := EmptyStr;
  FAut_PD := EmptyStr;
  FNumDoc := EmptyStr;
  FblnInspecaoRealizada := False;
  FBlnProrrogacao := False;
  FVlTxEn := 0;
  FVlrTotLoc := 0;
  FTipDur := 'D';
  FMesIni := 0;
  FMesFin := 0;
  FstrMesIni := '';
  FstrMesFin := '';
  FPedCom := EmptyStr;
  FstrEndObr := EmptyStr;
  FVlrTotAdc := 0;

  pLimparItens;
end;

procedure TContratoLocacaoEquipamentos.pLimparItens;
begin
  FListaItens.Clear;
end;

procedure TContratoLocacaoEquipamentos.pRecalculaItensContrato;
var
  intCnt: Integer;
begin
  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    FListaItens[intCnt].pCalcularValorLocacao;
  End;
end;

procedure TContratoLocacaoEquipamentos.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetAUT_PD(const AValue: String);
begin
  FAUT_PD := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetBlnFat(const AValue: Boolean);
begin
  FblnCarregarDadosFaturamento := AValue;
end;

procedure TContratoLocacaoEquipamentos.setBlnIns(const AValue: Boolean);
begin
  FblnInspecaoRealizada := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetBlnPrg(const AValue: Boolean);
begin
  FBlnProrrogacao := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetCliente(
  const AValue: TClienteContratoLocacao);
begin
  FCliente := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetCodCli(const AValue: String);
begin
  FCodCli := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetCodCnd(const AValue: String);
begin
  FCodCnd := AVaLue;
end;

procedure TContratoLocacaoEquipamentos.SetCodEmp(const AValue: String);
begin
  FCodEmp := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetCodFpg(const AValue: String);
begin
  FCodFpg := AVaLue;
end;

procedure TContratoLocacaoEquipamentos.SetConPag(const AValue: String);
begin
  FConPag := AVaLue;
end;

procedure TContratoLocacaoEquipamentos.SetDtaFin(const AValue: TDateTime);
begin
  FDtaFin := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetDtaIni(const AValue: TDateTime);
begin
  FDtaIni := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetDtFEst(const AValue: TDateTime);
begin
  FDataFinalEstimada := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetDtIEst(const AValue: TDateTime);
begin
  FDataInicialEstimada := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetDdoCli(const AValue: Boolean);
begin
  FblnCarregarDadosCliente := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetDeclar(const AValue: String);
begin
  FDeclar := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetDesFpg(const AValue: String);
begin
  FDesFpg := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetEmitente(
  const AValue: TEmitenteContratoLocacao);
begin
  FEmitente := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetEndObr(const Value: String);
begin
  FstrEndObr := Value;
end;

procedure TContratoLocacaoEquipamentos.SetEntCli(const AValue: String);
begin
  FEntCli := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetHorFin(const AValue: TDateTime);
begin
  FHorFin := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetHorIni(const AValue: TDateTime);
begin
  FHorIni := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetIndSel(const AValue: Integer);
begin
  FIndiceEquipamentoSelecionado := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetLItens(const AValue: TList<TItemContratoLocacaoEquipamentos>);
begin
  FListaItens := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetLResp(const AValue: TList<TCliCtt>);
begin
  FListaResp := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetNomCli(const AValue: String);
begin
  FNomCli := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetNroCon(const AValue: String);
begin
  FNroCon := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetNumDoc(const AValue: String);
begin
  FNumDoc := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetPedAdt(
  const AValue: TAdiantamentoContrato);
begin
  FAdiantamento := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetPedCom(const Value: String);
begin
  FPedCom := Value;
end;

procedure TContratoLocacaoEquipamentos.SetQtdEqu(const AValue: Double);
begin
  FQtdTEq := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetStatus(const AValue: String);
begin
  FStatus := Copy(AValue, 0,1);
end;

procedure TContratoLocacaoEquipamentos.SetTaxEnt(const AValue: Double);
begin
  FVlTxEn := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTipDur(const AValue: String);
begin
  FTipDur := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotAqu(const AValue: Double);
begin
  FVlrTotAqu := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotCob(const AValue: Double);
begin
  FValorTotalCobranca := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotCon(const AValue: Double);
begin
  FTotCon := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotDEst(const AValue: Double);
begin
  FTotalDiasEstimado := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotDia(const AValue: Integer);
begin
  FTotDia := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotHEst(const AValue: Double);
begin
  FTotalHorasEstimadas := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotHor(const AValue: Double);
begin
  FTotHor := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotMes(const AValue: Integer);
begin
  FTotMes := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetTotMEst(const AValue: Integer);
begin
  FTotalMesesEstimado := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetVendedor(
  const Value: TVendedorContratoLocacao);
begin
  FVendedor := Value;
end;

procedure TContratoLocacaoEquipamentos.SetVlrTot(const AValue: Double);
begin
  FValorTotalContrato := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetVlrTotAdc(const AValue: Double);
begin
  FVlrTotAdc := AValue;
end;

procedure TContratoLocacaoEquipamentos.SetVlrTotLoc(const AValue: Double);
begin
  FVlrTotLoc := AValue;
end;

procedure TContratoLocacaoEquipamentos.SugerirDataInicialContratoMensal(AMesIni,
  AMesFin: String);
begin
  FDtaIni := fObtemDtaIniMes(AMesIni);
  FDtaFin := fObtemDtaFiniMes(AMesFin);
  FTipDur := 'M';
end;

{ TItemContratoLocacaoEquipamentos }

constructor TItemContratoLocacaoEquipamentos.Create(
  Owner: TContratoLocacaoEquipamentos);
begin
  FContrato := Owner;
  FEquipamento := TEquipamentoLocacaoPrincipal.Create;

  FqryInsert := fCriaQuery;
  FqryInsert.DisableControls;

  FqryDelete := fCriaQuery;
  FqryDelete.DisableControls;

  FqryInsertNeg := fCriaQuery;
  FqryInsertNeg.DisableControls;

  FListaAcessorios := TList<TAcessorioContratoLocacaoEquipamentos>.Create;
  FblnUtilizaFaixaNegociacao := False;
  pLimpar;
end;

destructor TItemContratoLocacaoEquipamentos.Destroy;
begin
  FreeAndNil(FListaAcessorios);
  FreeAndNil(FEquipamento);
  FreeAndNil(FqryDelete);
  FreeAndNil(FqryInsert);
  FreeAndNil(FqryInsertNeg);

  inherited;
end;

function TItemContratoLocacaoEquipamentos.fAddAcessorio: TAcessorioContratoLocacaoEquipamentos;
var
  itemAux: TAcessorioContratoLocacaoEquipamentos;
  intCnt: Integer;
begin
  itemAux := TAcessorioContratoLocacaoEquipamentos.Create(Self);
  FListaAcessorios.add(itemAux);
  intCnt := FListaAcessorios.Count-1;
  Result := FListaAcessorios[intCnt];
end;

function TItemContratoLocacaoEquipamentos.fBloquearCadastroEquipamento: Boolean;
var
  qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('UPDATE CADEQL SET EQL_STATUS = "B" WHERE AUTOINCREM = :AUTOINCREM');
    qry.ParamByName('AUTOINCREM').AsString := FEquipamento.AutInc;
    qry.ExecSQL;
    Result := True;
  Finally
    qry.Close;
  End;

end;

function TItemContratoLocacaoEquipamentos.fExcluir: Boolean;
begin
  Try
    FqryDelete.SQL.Clear;
    FqryDelete.SQL.Add('DELETE FROM EQLDET WHERE AUTOINCREM = :AUTOINCREM');
    FqryDelete.ParamByName('AUTOINCREM').AsString := FAutInc;
    FqryDelete.ExecSQL;

    Result := True;
  Finally
    FqryDelete.Close;
  End;
end;

function TItemContratoLocacaoEquipamentos.fInserir: Boolean;
var
  intCnt: Integer;
begin
  Try
    FAutInc := fRetAutoIncrem('EQLDET', VS_strCodEmp);

    FqryInsert.SQL.Clear;
    FqryInsert.SQL.Add('INSERT INTO EQLDET( AUTOINCREM,	EQD_SEQCON,	EQD_SEQEQL,	EQD_TOTEQL,	' +
                                         'EQD_VALHOR,	EQD_TIPDUR, EQD_PERDES, EQD_VLLOCL, ' +
                                         'EQD_TOTLIQ, EQD_VLRALT, EQD_UTIFXN, EQD_VLRAQU, ' +
                                         'EQD_TOTDIA, EQD_TOTHOR, EQD_QTDEQU ) ' +
                       'VALUES            ( :AUTOINCREM, :EQD_SEQCON,	:EQD_SEQEQL, :EQD_TOTEQL,	' +
                                         ':EQD_VALHOR, :EQD_TIPDUR, :EQD_PERDES, :EQD_VLLOCL, ' +
                                         ':EQD_TOTLIQ, :EQD_VLRALT, :EQD_UTIFXN, :EQD_VLRAQU, ' +
                                         ':EQD_TOTDIA, :EQD_TOTHOR, :EQD_QTDEQU ) ' );
    FqryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    FqryInsert.ParamByName('EQD_SEQCON').AsString := FContrato.FAutInc;
    FqryInsert.ParamByName('EQD_SEQEQL').AsString := FEquipamento.Codigo;
    FqryInsert.ParamByName('EQD_TOTEQL').AsFloat  := FVlrTotalLocacaoContratado;
    FqryInsert.ParamByName('EQD_VALHOR').AsFloat  := FVlrLocacaoContratado;
    FqryInsert.ParamByName('EQD_TIPDUR').AsString := arrTpCalculoVlLocacao[FTipoCalculo];
    FqryInsert.ParamByName('EQD_PERDES').AsFloat  := FPerDes;
    FqryInsert.ParamByName('EQD_VLLOCL').AsFloat  := FVlrLocacaoLiquido;
    FqryInsert.ParamByName('EQD_TOTLIQ').AsFloat  := FVlrTotLiquido;
    FqryInsert.ParamByName('EQD_VLRALT').AsString := IIF(FlbnAlteradoTotalLiquidoManual, 'S', 'N');
    FqryInsert.ParamByName('EQD_UTIFXN').AsString := IIF(FblnUtilizaFaixaNegociacao, 'S', 'N');
    FqryInsert.ParamByName('EQD_VLRAQU').AsFloat  := FEquipamento.ValorAqu;
    FqryInsert.ParamByName('EQD_TOTDIA').AsFloat  := IIF(FTipoCalculo = tpDiaria, FContrato.TotalDias, 0);
    FqryInsert.ParamByName('EQD_TOTHOR').AsFloat  := IIF(FTipoCalculo = tpHoras, FContrato.TotalHoras, 0);
    FqryInsert.ParamByName('EQD_QTDEQU').AsFloat  := FQtdEqu;
    FqryInsert.ExecSQL;

    For intCnt:= 0 To FEquipamento.Diarias.Count-1 Do
    Begin
      FqryInsertNeg.SQL.Clear;
      FqryInsertNeg.SQL.Add('INSERT INTO EQLNEG(AUTOINCREM, EQN_SEQCON, EQN_CODEQU, EQN_QTDDIA, EQN_VLRDIA, EQN_VLRTOT, EQN_SEQEQU) ' +
                        '            VALUES(:AUTOINCREM, :EQN_SEQCON, :EQN_CODEQU, :EQN_QTDDIA, :EQN_VLRDIA, :EQN_VLRTOT, :EQN_SEQEQU) ');
      FqryInsertNeg.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('EQLNEG', VS_strCodEmp);
      FqryInsertNeg.ParamByName('EQN_SEQCON').AsString := FContrato.FAutInc;
      FqryInsertNeg.ParamByName('EQN_CODEQU').AsString := FEquipamento.Codigo;
      FqryInsertNeg.ParamByName('EQN_SEQEQU').AsString := FEquipamento.AutInc;
      FqryInsertNeg.ParamByName('EQN_QTDDIA').AsInteger := FEquipamento.Diarias[intCnt].QuantidadeDias;
      FqryInsertNeg.ParamByName('EQN_VLRDIA').AsFloat := FEquipamento.Diarias[intCnt].ValorDiaria;
      FqryInsertNeg.ParamByName('EQN_VLRTOT').AsFloat := FEquipamento.Diarias[intCnt].ValorTotal;

      FqryInsertNeg.ExecSQL;
    End;

    Result := True;
  Finally
    FqryInsert.Close;
    FqryInsertNeg.Close;
  End;
end;

function TItemContratoLocacaoEquipamentos.fInserirAcessorios: Boolean;
var
  intCnt: Integer;
begin
  For intCnt := 0 to FListaAcessorios.Count-1 Do
  Begin
    FListaAcessorios[intCnt].fInserir;
  End;

  Result := True;
end;

function TItemContratoLocacaoEquipamentos.fItemUtilizaFaixaNegociacao: Boolean;
begin
  Result := False;
  If FTipoCalculo = tpDiaria Then
  Begin
    fObtemValorDiaria;
    Result := FblnUtilizaFaixaNegociacao;
  End;
end;

function TItemContratoLocacaoEquipamentos.GetAtuIpE: Boolean;
begin
  Result := FBlnAtuIpE;
end;

function TItemContratoLocacaoEquipamentos.GetAtuIpS: Boolean;
begin
  Result := FBlnAtuIpS;
end;

function TItemContratoLocacaoEquipamentos.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TItemContratoLocacaoEquipamentos.GetblnEnc: Boolean;
begin
  Result := FblnEncerrarItem;
end;

function TItemContratoLocacaoEquipamentos.GetCndIps: String;
begin
  Result := FstrCondicaoPerfeitaSaida;
end;

function TItemContratoLocacaoEquipamentos.GetCobTrc: Double;
begin
  Result := FVlrCobTrc;
end;

function TItemContratoLocacaoEquipamentos.GetContrato: TContratoLocacaoEquipamentos;
begin
  Result := FContrato;
end;

function TItemContratoLocacaoEquipamentos.GetDocEnv: String;
begin
  Result := FstrDocEnv;
end;

function TItemContratoLocacaoEquipamentos.GetDocRet: String;
begin
  Result := FstrDocRet;
end;

function TItemContratoLocacaoEquipamentos.GetDscLib: Boolean;
begin
  If FTotDes = 0 Then
    FblnDescontoLiberado := True;
  Result := FblnDescontoLiberado;
end;

function TItemContratoLocacaoEquipamentos.GetDtaCob: TDateTime;
begin
  Result := FDataIniCobranca;
end;

function TItemContratoLocacaoEquipamentos.GetDtaEnc: TDateTime;
begin
  Result := FDataEncerramento;
end;

function TItemContratoLocacaoEquipamentos.GetDtaFCob: TDateTime;
begin
  Result := FDataFimCobranca;
end;

function TItemContratoLocacaoEquipamentos.GetDtaIpe: TDateTime;
begin
  Result := FDataInspecaoEntrada;
end;

function TItemContratoLocacaoEquipamentos.GetDtaIpS: TDateTime;
begin
  Result := FDataInspecaoSaida;
end;

function TItemContratoLocacaoEquipamentos.GetDurEql: Double;
begin
  Result := FDuracaoContratado;
end;

function TItemContratoLocacaoEquipamentos.GetEmpEnv: String;
begin
  Result := FEmpEnv;
end;

function TItemContratoLocacaoEquipamentos.GetEmpRet: String;
begin
  Result := FEmpRet;
end;

function TItemContratoLocacaoEquipamentos.GetEqlAva: String;
begin
  Result := FstrAvaria;
end;

function TItemContratoLocacaoEquipamentos.GetEqlHig: String;
begin
  Result := FstrHigienizado;
end;

function TItemContratoLocacaoEquipamentos.GetEquip: TEquipamentoLocacaoPrincipal;
begin
  Result := FEquipamento;
end;

function TItemContratoLocacaoEquipamentos.GetEquTrc: Boolean;
begin
  Result := FblnEquTrc;
end;

function TItemContratoLocacaoEquipamentos.GetEspEnv: String;
begin
  Result := FEspEnv;
end;

function TItemContratoLocacaoEquipamentos.GetEspRet: String;
begin
  Result := FEspRet;
end;

function TItemContratoLocacaoEquipamentos.GetGerCob: String;
begin
  Result := FstrGerarCobranca;
end;

function TItemContratoLocacaoEquipamentos.getHorIpE: TDateTime;
begin
  Result := FHoraInspecaoEntrada;
end;

function TItemContratoLocacaoEquipamentos.getHorIpS: TDateTime;
begin
  Result := FHoraInspecaoSaida;
end;

function TItemContratoLocacaoEquipamentos.GetHraFCob: TDateTime;
begin
  Result := FHraFCob;
end;

function TItemContratoLocacaoEquipamentos.GetIspERea: Boolean;
begin
  Result := FInspecaoEntradaRealizada;
end;

function TItemContratoLocacaoEquipamentos.GetIspSRea: Boolean;
begin
  Result := FInspecaoSaidaRealizada;
end;

function TItemContratoLocacaoEquipamentos.GetLAce: TList<TAcessorioContratoLocacaoEquipamentos>;
begin
  Result := FListaAcessorios;
end;

function TItemContratoLocacaoEquipamentos.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TItemContratoLocacaoEquipamentos.GetNomCfE: String;
begin
  If fEmptyStr(FNomConferenteEntrada) Then
  Begin
    FNomConferenteEntrada := fRetNomeOperador(FCodConferenteEntrada);
  End;

  Result := FNomConferenteEntrada;
end;

function TItemContratoLocacaoEquipamentos.GetNOpIps: String;
begin
  If fEmptyStr(FNomConferenteSaida) Then
  Begin
    FNomConferenteSaida := fRetNomeOperador(FCodConferenteSaida);
  End;

  Result := FNomConferenteSaida;
end;

function TItemContratoLocacaoEquipamentos.GetNSuIpE: String;
begin
  If fEmptyStr(FNomSupervisorEntrada) Then
  Begin
    FNomSupervisorEntrada := fRetNomeOperador(FCodSupervisorEntrada);
  End;

  Result := FNomSupervisorEntrada;
end;

function TItemContratoLocacaoEquipamentos.GetNSuIps: String;
begin
  If fEmptyStr(FNomSupervisorSaida) Then
  Begin
    FNomSupervisorSaida := fRetNomeOperador(FCodSupervisorSaida);
  End;

  Result := FNomSupervisorSaida;
end;

function TItemContratoLocacaoEquipamentos.GetNumEnv: String;
begin
  Result := FNumEnv;
end;

function TItemContratoLocacaoEquipamentos.GetNumRet: String;
begin
  Result := FNumRet;
end;

function TItemContratoLocacaoEquipamentos.GetObsIpE: String;
begin
  Result := FstrObservacoesEntrada;
end;

function TItemContratoLocacaoEquipamentos.GetObsIps: String;
begin
  Result := FstrObservacoesSaida;
end;

function TItemContratoLocacaoEquipamentos.GetOpeIpE: String;
begin
  Result := FCodConferenteEntrada;
end;

function TItemContratoLocacaoEquipamentos.GetOpeIps: String;
begin
  Result := FCodConferenteSaida;
end;

function TItemContratoLocacaoEquipamentos.GetSerEnv: String;
begin
  Result := FSerEnv;
end;

function TItemContratoLocacaoEquipamentos.GetSerRet: String;
begin
  Result := FSerRet;
end;

function TItemContratoLocacaoEquipamentos.GetStrAva: String;
begin
  Result := IIF(FstrAvaria = 'S', 'Sim', 'Não');
end;

function TItemContratoLocacaoEquipamentos.GetStrInsE: String;
begin
  Result := FstrInspecaoEntrada;
end;

function TItemContratoLocacaoEquipamentos.GetStrInsS: String;
begin
  Result := FstrInspecaoSaida;
end;

function TItemContratoLocacaoEquipamentos.GetStrTpDur: String;
begin
  FStrTipoCalculo := fTipoCalculoVlLocacao( arrTpCalculoVlLocacao[FTipoCalculo] );
  Result := FStrTipoCalculo;
end;

function TItemContratoLocacaoEquipamentos.GetSupIpE: String;
begin
  Result := FCodSupervisorEntrada;
end;

function TItemContratoLocacaoEquipamentos.GetSupIps: String;
begin
  Result := FCodSupervisorSaida;
end;

function TItemContratoLocacaoEquipamentos.GetTipDur: TTipoCalculoValorLocacao;
begin
  Result := FTipoCalculo;
end;

function TItemContratoLocacaoEquipamentos.GetTotTrc: Double;
begin
  Result := FVlrTotCob;
end;

function TItemContratoLocacaoEquipamentos.GetUtiFxN: String;
begin
  Result := IIF(FblnUtilizaFaixaNegociacao, 'S', 'N');
end;

function TItemContratoLocacaoEquipamentos.GetVlLocC: Double;
begin
  Result := FVlrLocacaoContratado;
end;

function TItemContratoLocacaoEquipamentos.GetVlLocL: Double;
begin
  Result := FVlrLocacaoLiquido;
end;

function TItemContratoLocacaoEquipamentos.GetVlrCob: Double;
begin
  Result := FVlrCobranca;
end;

function TItemContratoLocacaoEquipamentos.GetVlrCobA: Double;
begin
  Result := FVlrCobAce
end;

function TItemContratoLocacaoEquipamentos.GetVlrDes: Double;
begin
  Result := FVlrDes;
end;

function TItemContratoLocacaoEquipamentos.GetVlrTot: Double;
begin
  Result := FVlrTot;
end;

function TItemContratoLocacaoEquipamentos.GetPerDes: Double;
begin
  Result := FPerDes;
end;

function TItemContratoLocacaoEquipamentos.GetQtdEqu: Double;
begin
  Result := FQtdEqu;
end;

function TItemContratoLocacaoEquipamentos.GetRecEnv: TRecEnv;
begin
  Result := FRecEnv;
end;

function TItemContratoLocacaoEquipamentos.GetVlTotC: Double;
begin
  Result := FVlrTotalLocacaoContratado;
end;

function TItemContratoLocacaoEquipamentos.GetVlTotL: Double;
begin
  Result := FVlrTotLiquido;
end;

procedure TItemContratoLocacaoEquipamentos.pCalcularValorCobrancaAcessorios;
var
  intCnt: Integer;
begin
  FVlrCobAce := 0;
  For intCnt := 0 to FListaAcessorios.Count-1  Do
  Begin
    FVlrCobAce := FVlrCobAce + FListaAcessorios[intCnt].ValorCobranca;
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pCalcularValorDescontoTotalItem;
begin
  FTotDes := 0;
  If ( FVlrDes > 0 ) Then
  Begin
    Case FTipoCalculo of
      tpDiaria: FDesLoc := (FVlrDes/FContrato.TotalDias);
      tpHoras : FDesLoc := (FVlrDes/FContrato.TotalHoras);
    End;
    FTotDes := FVlrDes;
    FPerDes := (FVlrDes * 100)/FVlrTotalLocacaoContratado;
    FPerDes := fformatafloat(FPerDes, 2);
  End
  Else
  Begin
    FDesLoc := FVlrLocacaoContratado * (FPerDes/100);
    Case FTipoCalculo of
      tpDiaria: Begin
                  FVlrDes := (FDesLoc * FContrato.TotalDias);
                End;
      tpHoras : Begin
                  FVlrDes := (FDesLoc * FContrato.TotalHoras);
                End;
    End;
    FVlrDes := fformatafloat(FVlrDes, 2);
    FTotDes := FVlrDes;
  End;
end;

function TItemContratoLocacaoEquipamentos.fVerificaCalcularVlrContratado: Boolean;
var
  duracaoEstimada: Double;
Begin
  If ((FContrato.Status <> 'A') And (FContrato.Status <> 'F')) Then
    Exit(False);

  If (FblnRecalcularVlrLocacao) Then
    Exit(False);

  Result := True;

  Case FTipoCalculo Of
    tpDiaria : duracaoEstimada := FContrato.TotalDiasEstimado;
    tpHoras  : duracaoEstimada := FContrato.TotalHorasEstimadas;
    tpMensal : duracaoEstimada := FContrato.TotalMesesEstimados
    Else
      duracaoEstimada := FContrato.TotalDiasEstimado;
  End;

  If (FDuracaoContratado = duracaoEstimada) Or
    ((FDuracaoContratado < duracaoEstimada) And (Not FblnEncerrarItem)) Then
  Begin
    Result := True;
  End
  Else If (FDuracaoContratado > duracaoEstimada) Or (FblnEncerrarItem) Then
  Begin
    Result := False;
  End;
End;

procedure TItemContratoLocacaoEquipamentos.pCalcularValorLocacao;
var
  blnCalcularVlrContratado: Boolean;
begin
  If FDataEncerramento > 0 Then
    Exit;

  blnCalcularVlrContratado := fVerificaCalcularVlrContratado;

  Case FTipoCalculo Of
    tpDiaria : Begin
                 pCalculaValorLocacaoPorDiaria(blnCalcularVlrContratado);
                 pCalculaValorLocacaoLiquidoPorDiaria;
               End;
    tpHoras  : Begin
                 pCalculaValorLocacaoPorHora(blnCalcularVlrContratado);
                 pCalculaValorLocacaoLiquidoPorHora;
               End;
    tpMensal : Begin
                 pCalculaValorLocacaoPorMes(blnCalcularVlrContratado);
                 pCalculaValorLocacaoLiquidoPorMes;
               End;
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorDesconto(
  const aVlrLocacaoLiquido, aVlrTotalLiquido: Double);
begin
  If FDataEncerramento > 0 Then
    Exit;

  Case FTipoCalculo Of
    tpDiaria : Begin
                 pCalculaValorDescontoPorDiaria(aVlrLocacaoLiquido, aVlrTotalLiquido);
               End;
    tpHoras  : Begin
                 pCalculaValorDescontoPorHora(aVlrLocacaoLiquido, aVlrTotalLiquido);
               End;
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorDescontoPorDiaria(const aVlrLocacaoLiquido: Double; const aVlrTotalLiquido: Double);
var
  fltVlrLocAnt,
  fltVlrTotAnt,
  fltPerDesAnt,
  fltVlrDesAnt: Double;
  auxVlrLiq,
  auxVlrTotLiq: Double;
begin
  auxVlrLiq   := aVlrLocacaoLiquido;
  auxVlrTotLiq:= aVlrTotalLiquido;

  fltPerDesAnt := FPerDes;
  fltVlrDesAnt := FVlrLocacaoContratado * (FPerDes / 100);
  fltVlrLocAnt := FVlrLocacaoLiquido;
  fltVlrTotAnt := FVlrTotLiquido;

  If auxVlrLiq > 0 Then
  Begin
    If auxVlrLiq = FVlrLocacaoLiquido Then
      Exit;

    auxVlrTotLiq := auxVlrLiq * FContrato.TotalDias;
    FVlrDes := FVlrTotalLocacaoContratado - auxVlrTotLiq;
    FPerDes := ( FVlrDes * 100 ) / FVlrTotalLocacaoContratado;
    FPerDes := fformatafloat(FPerDes, 2);
  End

  Else If auxVlrTotLiq > 0 Then
  Begin
    If auxVlrTotLiq = FVlrTotLiquido Then
      Exit;

    auxVlrLiq := (auxVlrTotLiq / FQtdEqu)  / FContrato.TotalDias;
    auxVlrLiq := fformatafloat(auxVlrLiq, 4);
    FVlrDes := FVlrTotalLocacaoContratado - auxVlrTotLiq;
    FPerDes := ( FVlrDes * 100 ) / FVlrTotalLocacaoContratado;
    FPerDes := fformatafloat(FPerDes, 2);
  End;

  If FPerDes < 0 Then
    FPerDes := 0;

  If fValidarDesconto(FPerDes, FVlrDes) Then
  Begin
    FlbnAlteradoTotalLiquidoManual := True;
    FVlrLocacaoLiquido := auxVlrLiq;
    FVlrTotLiquido := auxVlrTotLiq;
    FblnRecalcularVlrLocacao := False;
  End
  Else
  Begin
    FPerDes := fltPerDesAnt;
    FVlrDes := fltVlrDesAnt;
    FVlrLocacaoLiquido := fltVlrLocAnt;
    FVlrTotLiquido := fltVlrTotAnt;
  End;
  pCalcularValorDescontoTotalItem;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorDescontoPorHora(const aVlrLocacaoLiquido: Double; const aVlrTotalLiquido: Double);
var
  fltPerDesAnt,
  fltVlrDesAnt: Double;
  fltVlrLocAnt,
  fltVlrTotAnt: Double;
  auxVlrLiq,
  auxVlrTotLiq: Double;
  blnCalcularValorLiquido,
  blnCalcularValorTotalLiquido: Boolean;
begin
  auxVlrLiq   := aVlrLocacaoLiquido;
  auxVlrTotLiq:= aVlrTotalLiquido;

  fltPerDesAnt := FPerDes;
  fltVlrDesAnt := FVlrLocacaoContratado * (FPerDes / 100);
  fltVlrLocAnt := FVlrLocacaoLiquido;
  fltVlrTotAnt := FVlrTotLiquido;

  blnCalcularValorLiquido := auxVlrLiq > 0;
  blnCalcularValorTotalLiquido := auxVlrTotLiq > 0;

  If blnCalcularValorLiquido Then
  Begin
    If auxVlrTotLiq = FVlrTotLiquido Then
      Exit;

    auxVlrTotLiq := (auxVlrLiq * FQtdEqu) * FContrato.TotalHoras;
    FVlrDes := FVlrTotalLocacaoContratado - auxVlrTotLiq;
    FPerDes := ( FVlrDes * 100 ) / FVlrTotalLocacaoContratado;
    FPerDes := fformatafloat(FPerDes, 2);
  End;

  If blnCalcularValorTotalLiquido Then
  Begin
    If auxVlrTotLiq = FVlrTotLiquido Then
      Exit;

    auxVlrLiq := (auxVlrTotLiq /FQtdEqu) / FContrato.TotalHoras;
    FVlrDes := FVlrTotalLocacaoContratado - auxVlrTotLiq;
    FPerDes := ( FVlrDes * 100 ) / FVlrTotalLocacaoContratado;
    FPerDes := fformatafloat(FPerDes, 2);
  End;

  If FPerDes < 0 Then
    FPerDes := 0;

  If fValidarDesconto(FPerDes, FVlrDes) Then
  Begin
    FlbnAlteradoTotalLiquidoManual := True;
    FVlrLocacaoLiquido := auxVlrLiq;
    FVlrTotLiquido := auxVlrTotLiq;
    FblnRecalcularVlrLocacao := False;
  End
  Else
  Begin
    FPerDes := fltPerDesAnt;
    FVlrDes := fltVlrDesAnt;
    FVlrLocacaoLiquido := fltVlrLocAnt;
    FVlrTotLiquido := fltVlrTotAnt;
  End;
  pCalcularValorDescontoTotalItem;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorLocacaoLiquidoPorDiaria;
begin
  pCalcularValorDescontoTotalItem;
  If (Not FlbnAlteradoTotalLiquidoManual) or (FblnRecalcularVlrLocacao) Then
    FVlrLocacaoLiquido := FVlrLocacaoContratado - FDesLoc;
  FVlrTotLiquido     := (FVlrLocacaoLiquido * FQtdEqu) * FContrato.TotalDias;
  FDuracaoContratado := FContrato.TotalDias;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorLocacaoLiquidoPorHora;
begin
  pCalcularValorDescontoTotalItem;
  If (Not FlbnAlteradoTotalLiquidoManual) or (FblnRecalcularVlrLocacao) Then
    FVlrLocacaoLiquido := FVlrLocacaoContratado - FDesLoc;
  FVlrTotLiquido     := (FVlrLocacaoLiquido * FQtdEqu) * FContrato.TotalHoras;
  FDuracaoContratado := FContrato.TotalHoras;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorLocacaoLiquidoPorMes;
begin
  pCalcularValorDescontoTotalItem;
  If (Not FlbnAlteradoTotalLiquidoManual) or (FblnRecalcularVlrLocacao) Then
    FVlrLocacaoLiquido := FVlrLocacaoContratado - FDesLoc;

  FVlrTotLiquido     := (FVlrLocacaoLiquido * FQtdEqu) * FContrato.TotalMeses;
  FDuracaoContratado := FContrato.TotalMeses;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorLocacaoPorDiaria(const blnCalcVlrContratado: Boolean);
begin
  If FblnRecalcularVlrLocacao Then
    FVlrLocacaoContratado := fObtemValorDiaria;
  FVlrTotalLocacaoContratado := (FVlrLocacaoContratado * FQtdEqu)  *  FContrato.TotalDias;
end;

function TItemContratoLocacaoEquipamentos.fObtemValorDiaria: Double;
Begin
  If FContrato.TotalDias > 1 Then
    Result := fObtemValorDiariaNegociada
  Else
    Result := FEquipamento.ValorLocacaoDiaria;
End;

function TItemContratoLocacaoEquipamentos.fObtemValorDiariaNegociada: Double;
var
  intCnt: Integer;
  NumeroDiasMinimoNegociado: Integer;
Begin
  NumeroDiasMinimoNegociado := 0;

  For intCnt := 0 To FEquipamento.Diarias.Count -1 Do
  Begin
    If intCnt = 0 Then
    Begin
      NumeroDiasMinimoNegociado := FEquipamento.Diarias[intCnt].QuantidadeDias;
    End;

    If FEquipamento.Diarias[intCnt].QuantidadeDias <= NumeroDiasMinimoNegociado Then
    Begin
      NumeroDiasMinimoNegociado := FEquipamento.Diarias[intCnt].QuantidadeDias;
    End;

    If FContrato.TotalDias = FEquipamento.Diarias[intCnt].QuantidadeDias Then
    Begin
      Result := FEquipamento.Diarias[intCnt].ValorDiaria;
      Exit;
    End
  End;

  If FContrato.TotalDias < NumeroDiasMinimoNegociado Then
  Begin
    Result := FEquipamento.ValorLocacaoDiaria;
    Exit;
  End;

  Result := fObtemValorNegociadoFaixaMaisProxima;

End;

function TItemContratoLocacaoEquipamentos.fObtemValorNegociadoFaixaMaisProxima : Double;
var
  intCnt: Integer;
  intDif,
  intDifAnt,
  intQtdAnt: Integer;
Begin
  intDifAnt := 0;
  intQtdAnt := 0;

  Result := FEquipamento.ValorLocacaoDiaria;
  FblnUtilizaFaixaNegociacao := False;
  For intCnt := 0 To FEquipamento.Diarias.Count -1 Do
  Begin

    If intCnt = 0 Then
    Begin
      intDifAnt := FEquipamento.Diarias[intCnt].QuantidadeDias - FContrato.TotalDias;
      Result := FEquipamento.Diarias[intCnt].ValorDiaria;
      intQtdAnt := FEquipamento.Diarias[intCnt].QuantidadeDias;
    End;

    intDif := FEquipamento.Diarias[intCnt].QuantidadeDias - FContrato.TotalDias;

    If FContrato.TotalDias <= FEquipamento.Diarias[intCnt].QuantidadeDias Then
    Begin
      If intDif < intDifAnt Then
      Begin
        If intDif > 0 Then
        Begin
          Result := FEquipamento.Diarias[intCnt].ValorDiaria;
          intDifAnt := intDif;
        End;
      End;
    End
    Else
    Begin
      If FEquipamento.Diarias[intCnt].QuantidadeDias > intQtdAnt Then
      Begin
        intQtdAnt := FEquipamento.Diarias[intCnt].QuantidadeDias;
        Result := FEquipamento.Diarias[intCnt].ValorDiaria;
      End;
    End;

  End;

  FblnUtilizaFaixaNegociacao := (Result <> FEquipamento.ValorLocacaoDiaria);
End;

function TItemContratoLocacaoEquipamentos.fObtemValorTroca: Double;
var
  qrySelect: TUniQuery;
  fltvlrCobranca: Double;
  strCodEQlAnt: String;
begin
  fltvlrCobranca := 0;
  strCodEQlAnt :=  EmptyStr;

  qrySelect := fCriaQuery;
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT TRC_EQLACL, TRC_EQLANT, TRC_VLRCOB              ');
    qrySelect.SQL.Add('  FROM TRCDET                                          ');
    qrySelect.SQL.Add('  INNER JOIN TRCEQL ON (TRC_SEQTRC = TRCEQL.AUTOINCREM)');
    qrySelect.SQL.Add('WHERE TRC_SEQCON = :TRC_SEQCON                         ');
    qrySelect.SQL.Add('ORDER BY TRCDET.AUTOINCREM DESC                        ');
    qrySelect.ParamByName('TRC_SEQCON').AsString := FContrato.AutInc;
    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      While Not qrySelect.EOF Do
      Begin
        If ((qrySelect.FieldByName('TRC_EQLACL').AsString = strCodEQlAnt) and (Not fEmptyStr(strCodEQlAnt)) or
            (qrySelect.FieldByName('TRC_EQLACL').AsString = FEquipamento.Codigo) or
            (qrySelect.FieldByName('TRC_EQLANT').AsString = FEquipamento.Codigo)) Then
        Begin
          fltvlrCobranca := fltvlrCobranca + qrySelect.FieldByName('TRC_VLRCOB').AsFloat;
          strCodEQlAnt := qrySelect.FieldByName('TRC_EQLANT').AsString;
        End;

        qrySelect.Next;
      End;
    End;
  Finally
    Result := fltvlrCobranca;
    FreeAndNil(qrySelect);
  End;
end;

function TItemContratoLocacaoEquipamentos.fValidaDataInspecao(
  const aDtaInspecao: TDateTime): Boolean;
begin
  Result := aDtaInspecao > (FContrato.DataInicial + FContrato.HoraInicial);
end;

function TItemContratoLocacaoEquipamentos.fValidarDesconto(const aPerDesc: Double; aVlrDesc: Double): Boolean;
var
  PerDesAux : Double;
begin
  FPerDesTmp := FPerDes;

  If aVlrDesc > 0 Then
  Begin
    PerDesAux := (aVlrDesc * 100) / FVlrTotalLocacaoContratado;
  End
  Else
    PerDesAux := aPerDesc;

  If FPerDes <> PerDesAux Then
    FblnDescontoLiberado := False;

  If PerDesAux = 0 Then
  Begin
    FblnDescontoLiberado := True;
  End;

  If FblnDescontoLiberado Then
  Begin
    Result := True;
    Exit;
  End;

  FPerDes := PerDesAux;
  FVlrDes := aVlrDesc;
  pCalcularValorLocacao;

  Result := fValidarDescontoVendedor(PerDesAux);

  If Not Result Then
    Result := fValidarDescontoSubGerente(PerDesAux);

  If Not Result Then
    Result := fValidarDescontoGerente(PerDesAux);

  FblnDescontoLiberado := Result;

  If Not Result Then
  Begin
    FPerDes := FPerDesTmp;
    FVlrDes := fformatafloat(FVlrLocacaoContratado * (FPerDes / 100), 2);
    pCalcularValorLocacao;
  End;
end;

function TItemContratoLocacaoEquipamentos.fValidarDescontoGerente(const aPerDesc: Double): Boolean;
begin
  Result := False;

  If aPerDesc >= FEquipamento.ValorDescontoGerente Then
    Result := fSenhaDescontoContrato(cstDirAceDescNvl3, aPerDesc, 3);
end;

function TItemContratoLocacaoEquipamentos.fValidarDescontoSubGerente(const aPerDesc: Double): Boolean;
begin
  Result := False;

  If (aPerDesc >= FEquipamento.ValorDescontoSubGerente) Then
    If (aPerDesc < FEquipamento.ValorDescontoGerente) Then
      Result := fSenhaDescontoContrato(cstDirAceDescNvl2, aPerDesc, 2);
end;

function TItemContratoLocacaoEquipamentos.fValidarDescontoVendedor(const aPerDesc: Double): Boolean;
begin
  Result := False;

  If aPerDesc <= FEquipamento.ValorDescontoVendedor Then
    Result := True
  Else
  If aPerDesc < FEquipamento.ValorDescontoSubGerente Then
  Begin
    Result := fSenhaDescontoContrato(cstDirAceDescNvl1, aPerDesc, 1);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorLocacaoPorHora(const blnCalcVlrContratado: Boolean);
begin
  If Not blnCalcVlrContratado Then
    FVlrLocacaoContratado := FEquipamento.ValorLocacao;
  FVlrTotalLocacaoContratado := (FVlrLocacaoContratado * FQtdEqu)  *  FContrato.TotalHoras;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorLocacaoPorMes(const blnCalcVlrContratado: Boolean);
begin
  If Not blnCalcVlrContratado Then
    FVlrLocacaoContratado := FEquipamento.ValorLocacaoMensal;
  FVlrTotalLocacaoContratado := (FVlrLocacaoContratado * FQtdEqu)  *  FContrato.TotalMeses;
end;

procedure TItemContratoLocacaoEquipamentos.pCalculaValorTotalCobranca;
begin
  pCalcularValorCobrancaAcessorios;
  FVlrCobTrc := fObtemValorTroca;
  FVlrTotCob := FVlrCobTrc + FVlrCobranca + FVlrCobAce;
end;

procedure TItemContratoLocacaoEquipamentos.pCarregaDataFinalCobranca;
begin
  If FInspecaoEntradaRealizada  Then
  Begin
    FDataFimCobranca := FDataInspecaoEntrada + FHoraInspecaoEntrada;
    FHraFCob := FHoraInspecaoEntrada;
  End
  Else
  Begin
    FDataFimCobranca := FContrato.fCalculaDataFinalCobranca(FDataIniCobranca, FContrato.FTotHor);
    FHraFCob := FContrato.fCalculaDataFinalCobranca(FDataIniCobranca, FContrato.FTotHor);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pCarregarAcessorios;
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
  item: TAcessorioContratoLocacaoEquipamentos;
begin
  FListaAcessorios.Clear;

  SQLSelect := 'SELECT ACLDET.*,                          ' +
               '  IF(                                     ' +
               '    EQD_DTAIPS IS NULL,                   ' +
               '    "PENDENTE",                           ' +
               '     CONCAT(                              ' +
               '      "REALIZADA ",                       ' +
               '      DATE_FORMAT(EQD_DTAIPS, "%d/%m/%Y") ' +
               '    )                                     ' +
               '  ) AS EQD_STTIPS,                        ' +
               '  IF(                                     ' +
               '    EQD_DTAIPE IS NULL,                   ' +
               '    "PENDENTE",                           ' +
               '    CONCAT(                               ' +
               '      "REALIZADA ",                       ' +
               '      DATE_FORMAT(EQD_DTAIPE, "%d/%m/%Y") ' +
               '    )                                     ' +
               '  ) AS EQD_STTIPE,                        ' +
               '  E.OPE_NOMOPE AS  OPE_NOMIPE,            ' +
               '  CONCAT(                                 ' +
               '    EQD_NUMENV,                           ' +
               '    "-",                                  ' +
               '    EQD_ESPENV,                           ' +
               '    "-",                                  ' +
               '    EQD_EMPENV                            ' +
               '  ) AS EQD_DOCENV,                        ' +
               '  CONCAT(                                 ' +
               '    EQD_NUMRET,                           ' +
               '    "-",                                  ' +
               '    EQD_ESPRET,                           ' +
               '    "-",                                  ' +
               '    EQD_EMPRET                            ' +
               '  ) AS EQD_DOCRET,                        ' +
               '  SUPE.OPE_NOMOPE AS OPE_NOMSPE,          ' +
               '  SUPS.OPE_NOMOPE AS OPE_NOMSPS,          ' +
               '  EQD_VLRADC                              ' +
               'FROM ACLDET                               ' +
               'LEFT JOIN CADOPE E ON (E.OPE_CODOPE = ACLDET.EQD_OPEIPE)  ' +
               'LEFT JOIN CADOPE SUPE ON (SUPE.OPE_CODOPE = ACLDET.EQD_SUPIPE)  ' +
               'LEFT JOIN CADOPE SUPS ON (SUPS.OPE_CODOPE = ACLDET.EQD_SUPIPS)  ' +
               'WHERE EQD_SEQCON = :SEQCON    ' +
               '  AND EQD_SEQEQL = :SEQEQL    ' +
               'ORDER BY ACLDET.AUTOINCREM ';

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    qryConsulta.ParamByName('SEQCON').AsString := FContrato.FAutInc;
    qryConsulta.ParamByName('SEQEQL').AsString := FEquipamento.Codigo;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      While Not qryConsulta.EOF Do
      Begin
        item := fAddAcessorio;
        item.AutInc  := qryConsulta.FieldByName('AUTOINCREM').AsString;
        item.CodEquipamento  := qryConsulta.FieldByName('EQD_SEQEQL').AsString;
        item.Acessorio.fCarregaAcessorio(qryConsulta.FieldByName('EQD_SEQACL').AsString);
        item.Quantidade := qryConsulta.FieldByName('EQD_QTDACL').AsFloat;
        
        item.strInspecaoEntrada := qryConsulta.FieldByName('EQD_STTIPE').AsString;
        item.strInspecaoSaida := qryConsulta.FieldByName('EQD_STTIPS').AsString;
        item.strCondicaoPerfeitaSaida := qryConsulta.FieldByName('EQD_CNDIPS').AsString;
        item.ObservacoesSaida := qryConsulta.FieldByName('EQD_OBSIPS').AsString;
        item.CodConferenteSaida := qryConsulta.FieldByName('EQD_OPEIPS').AsString;
        item.CodSupervisorSaida := qryConsulta.FieldByName('EQD_SUPIPS').AsString;
        item.strHigienizado := qryConsulta.FieldByName('EQD_HIGIPE').AsString;
        item.strAvaria := qryConsulta.FieldByName('EQD_AVAIPE').AsString;
        item.ObservacoesEntrada := qryConsulta.FieldByName('EQD_OBSIPE').AsString;
        item.strGerarCobranca := qryConsulta.FieldByName('EQD_COBIPE').AsString;

        item.ValorCobranca := qryConsulta.FieldByName('EQD_VALIPE').AsFloat;
        item.CodConferenteEntrada := qryConsulta.FieldByName('EQD_OPEIPE').AsString;
        item.CodSupervisorEntrada := qryConsulta.FieldByName('EQD_SUPIPE').AsString;
        item.DataInspecaoEntrada :=  qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime;
        item.NomConferenteEntrada := qryConsulta.FieldByName('OPE_NOMIPE').AsString;
        item.DataInspecaoEntrada := qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime;
        item.DataInspecaoSaida := qryConsulta.FieldByName('EQD_DTAIPS').AsDateTime;
        item.HoraInspecaoEntrada := qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
        item.HoraInspecaoSaida := qryConsulta.FieldByName('EQD_HORIPS').AsDateTime;
        item.InspecaoEntradaRealizada := (item.DataInspecaoEntrada > 0);
        item.InspecaoSaidaRealizada := (item.DataInspecaoSaida > 0);

        item.strDocEnv := qryConsulta.FieldByName('EQD_DOCENV').AsString;
        item.strDocRet := qryConsulta.FieldByName('EQD_DOCRET').AsString;
        item.NomSupervisorEntrada := qryConsulta.FieldByName('OPE_NOMSPE').AsString;
        item.NomSupervisorSaida := qryConsulta.FieldByName('OPE_NOMSPS').AsString;
        item.ValorAdicional := qryConsulta.FieldByName('EQD_VLRADC').AsFloat;

        qryConsulta.Next;
      End;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pCarregarDadosDocEnvio;
var
  qryDet: TUniQuery;
begin
  FRecEnv.dtaEnv := 0;
  FRecEnv.fltVlr := 0;

  qryDet := fCriaQuery();
  Try
    qryDet.SQL.Text := 'SELECT DET_DTAENT, DET_VLRCON FROM MOVDET '+
                       '  WHERE DET_CODEMP = :CODEMP ' +
                       '    AND DET_ESPDOC = :ESPDOC ' +
                       '    AND DET_NUMDOC = :NUMDOC ' +
                       '    AND DET_CODITE = :CODITE ' +
                       '    AND DET_TIP_FC = "C"     ' +
                       '    AND DET_ORIDOC = "V"     ' ;

    If Not fEmptyStr( FNumEnv ) Then
    Begin
      qryDet.ParamByName('CODEMP').AsString := FEmpEnv;
      qryDet.ParamByName('ESPDOC').AsString := FEspEnv;
      qryDet.ParamByName('NUMDOC').AsString := FNumEnv;
      qryDet.ParamByName('CODITE').AsString := FEquipamento.CodigoItem;
      qryDet.Open;
      If Not qryDet.IsEmpty Then
      Begin
        FRecEnv.dtaEnv := qryDet.FieldByName('DET_DTAENT').AsDateTime;
        FRecEnv.fltVlr := qryDet.FieldByName('DET_VLRCON').AsFloat;
      End;
    End;
  Finally
    FreeAndNil(qryDet);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pCarregar(const strAutInc: String; strCodEql: String = '');
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
begin

  SQLSelect := 'SELECT EQLDET.*,                          ' +
               '  IF(                                     ' +
               '    EQD_DTAIPS IS NULL,                   ' +
               '    "PENDENTE",                           ' +
               '     CONCAT(                              ' +
               '      "REALIZADA ",                       ' +
               '      DATE_FORMAT(EQD_DTAIPS, "%d/%m/%Y") ' +
               '    )                                     ' +
               '  ) AS EQD_STTIPS,                        ' +
               '  IF(                                     ' +
               '    EQD_DTAIPE IS NULL,                   ' +
               '    "PENDENTE",                           ' +
               '    CONCAT(                               ' +
               '      "REALIZADA ",                       ' +
               '      DATE_FORMAT(EQD_DTAIPE, "%d/%m/%Y") ' +
               '    )                                     ' +
               '  ) AS EQD_STTIPE,                        ' +
               '  E.OPE_NOMOPE AS  OPE_NOMIPE,            ' +
               '  CONCAT(                                 ' +
               '    EQD_NUMENV,                           ' +
               '    "-",                                  ' +
               '    EQD_ESPENV,                           ' +
               '    "-",                                  ' +
               '    EQD_EMPENV                            ' +
               '  ) AS EQD_DOCENV,                        ' +
               '  CONCAT(                                 ' +
               '    EQD_NUMRET,                           ' +
               '    "-",                                  ' +
               '    EQD_ESPRET,                           ' +
               '    "-",                                  ' +
               '    EQD_EMPRET                            ' +
               '  ) AS EQD_DOCRET,                        ' +
               '  SUPE.OPE_NOMOPE AS OPE_NOMSPE,          ' +
               '  EQD_NUMENV,                             ' +
               '  EQD_SERENV,                             ' +
               '  EQD_ESPENV,                             ' +
               '  EQD_EMPENV,                             ' +
               '  SUPE.OPE_NOMOPE AS OPE_NOMSPE,          ' +
               '  SUPS.OPE_NOMOPE AS OPE_NOMSPS,          ' +
               '  EQD_EQUTRC                              ' +
               'FROM EQLDET                               ' +
               'LEFT JOIN CADOPE E ON (E.OPE_CODOPE = EQLDET.EQD_OPEIPE)  ' +
               'LEFT JOIN CADOPE SUPE ON (SUPE.OPE_CODOPE = EQLDET.EQD_SUPIPE)  ' +
               'LEFT JOIN CADOPE SUPS ON (SUPS.OPE_CODOPE = EQLDET.EQD_SUPIPS)  ' +
               'WHERE EQD_SEQCON = :EQD_SEQCON            ';
  If Not fEmptyStr(strAutInc) Then
    SQLSelect := SQLSelect + '  AND EQLDET.AUTOINCREM = :AUTINC  ';
  If Not fEmptyStr(strCodEql) Then
    SQLSelect := SQLSelect + '  AND EQD_SEQEQL = :EQD_SEQEQL       ';

  SQLSelect := SQLSelect + '  ORDER BY AUTOINCREM ';

  qryConsulta := fCriaQuery;
  Try
    FEquipamento.pCarregaEquipamento(strAutInc, strCodEql);

    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    qryConsulta.ParamByName('EQD_SEQCON').AsString := FContrato.AutInc;
    If (Not fEmptyStr(strAutInc)) Then
      qryConsulta.ParamByName('AUTINC').AsString := strAutInc;
    If (Not fEmptyStr(strCodEql)) Then
      qryConsulta.ParamByName('EQD_SEQEQL').AsString := strCodEql;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      FAutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;

      FstrInspecaoEntrada       := qryConsulta.FieldByName('EQD_STTIPE').AsString;
      FstrInspecaoSaida         := qryConsulta.FieldByName('EQD_STTIPS').AsString;
      FstrCondicaoPerfeitaSaida := qryConsulta.FieldByName('EQD_CNDIPS').AsString;
      FstrObservacoesSaida      := qryConsulta.FieldByName('EQD_OBSIPS').AsString;
      FCodConferenteSaida       := qryConsulta.FieldByName('EQD_OPEIPS').AsString;
      FCodSupervisorSaida       := qryConsulta.FieldByName('EQD_SUPIPS').AsString;
      FNomSupervisorSaida       := qryConsulta.FieldByName('OPE_NOMSPS').AsString;
      FstrHigienizado           := qryConsulta.FieldByName('EQD_HIGIPE').AsString;
      FstrAvaria                := qryConsulta.FieldByName('EQD_AVAIPE').AsString;
      FstrObservacoesEntrada    := qryConsulta.FieldByName('EQD_OBSIPE').AsString;
      FstrGerarCobranca         := qryConsulta.FieldByName('EQD_COBIPE').AsString;
      FCodConferenteEntrada     := qryConsulta.FieldByName('EQD_OPEIPE').AsString;
      FCodSupervisorEntrada     := qryConsulta.FieldByName('EQD_SUPIPE').AsString;
      FNomSupervisorEntrada     := qryConsulta.FieldByName('OPE_NOMSPE').AsString;
      FNomConferenteEntrada     := qryConsulta.FieldByName('OPE_NOMIPE').AsString;
      FstrDocEnv                := qryConsulta.FieldByName('EQD_DOCENV').AsString;
      FstrDocRet                := qryConsulta.FieldByName('EQD_DOCRET').AsString;
      FTipoCalculo              := fStrTipoCalculoVlLocacaoToTipoCalculoVlLocacao(qryConsulta.FieldByName('EQD_TIPDUR').AsString);
      Case FTipoCalculo Of
        tpHoras : FDuracaoContratado := FContrato.TotalHoras;
        tpDiaria: FDuracaoContratado := FContrato.TotalDias;
      End;
      FVlrTotalLocacaoContratado := qryConsulta.FieldByName('EQD_TOTEQL').AsFloat;
      FVlrLocacaoContratado := qryConsulta.FieldByName('EQD_VALHOR').AsFloat;
      FVlrLocacaoLiquido := qryConsulta.FieldByName('EQD_VLLOCL').AsFloat;
      FVlrTotLiquidO := qryConsulta.FieldByName('EQD_TOTLIQ').AsFloat;
      FVlrCobranca := qryConsulta.FieldByName('EQD_VALIPE').AsFloat;
      FVlrTot := FVlrTotLiquido + FVlrCobranca;
      FPerDes := qryConsulta.FieldByName('EQD_PERDES').AsFloat;
      FVlrDes := FVlrTotalLocacaoContratado - FVlrTotLiquido;

      FDataInspecaoEntrada := qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime;
      FDataInspecaoSaida := qryConsulta.FieldByName('EQD_DTAIPS').AsDateTime;
      FHoraInspecaoEntrada := qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
      FHoraInspecaoSaida := qryConsulta.FieldByName('EQD_HORIPS').AsDateTime;
      FDataIniCobranca := qryConsulta.FieldByName('EQD_DTACOB').AsDateTime + qryConsulta.FieldByName('EQD_HORCOB').AsDateTime;
      FInspecaoEntradaRealizada := (FDataInspecaoEntrada > 0);
      FInspecaoSaidaRealizada   := (FDataInspecaoSaida > 0);
      If FInspecaoEntradaRealizada  Then
      Begin
        FDataFimCobranca := qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime + qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
        FHraFCob := qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
      End
      Else
      Begin
        FDataFimCobranca := FContrato.fCalculaDataFinalCobranca(FDataIniCobranca, FContrato.FTotHor);
        FHraFCob := FContrato.fCalculaDataFinalCobranca(FDataIniCobranca, FContrato.FTotHor);
      End;
      FblnUtilizaFaixaNegociacao := (qryConsulta.FieldByName('EQD_UTIFXN').AsString = 'S');
      If Not FblnUtilizaFaixaNegociacao Then
      Begin
        FblnUtilizaFaixaNegociacao := fItemUtilizaFaixaNegociacao;
      End;

      FNumEnv := qryConsulta.FieldByName('EQD_NUMENV').AsString;
      FEspEnv := qryConsulta.FieldByName('EQD_ESPENV').AsString;
      FEmpEnv := qryConsulta.FieldByName('EQD_EMPENV').AsString;
      FSerEnv := qryConsulta.FieldByName('EQD_SERENV').AsString;
      FNumRet := qryConsulta.FieldByName('EQD_NUMRET').AsString;
      FEspRet := qryConsulta.FieldByName('EQD_ESPRET').AsString;
      FEmpRet := qryConsulta.FieldByName('EQD_EMPRET').AsString;
      FSerRet := qryConsulta.FieldByName('EQD_SERRET').AsString;

      FlbnAlteradoTotalLiquidoManual := qryConsulta.FieldByName('EQD_VLRALT').AsString = 'S';
      FblnRecalcularVlrLocacao := (Not FlbnAlteradoTotalLiquidoManual);
      FblnEquTrc := (qryConsulta.FieldByName('EQD_EQUTRC').AsString = 'S');

      pCarregarAcessorios;
      pCalculaValorTotalCobranca;
      pCarregarDadosDocEnvio;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pCarregarTipoLocacaoEquipamento;
begin
  If (FEquipamento.ValorLocacaoMensal > 0) And (FContrato.TipoDuracaoContrato = 'M') Then
  Begin
    FTipoCalculo := tpMensal;
    pCalculaValorLocacaoPorMes(False);
  End
  Else
  If FEquipamento.ValorLocacaoDiaria > 0 Then
  Begin
    FTipoCalculo := tpDiaria;
    pCalculaValorLocacaoPorDiaria(False);
  End
  Else
  Begin
    FTipoCalculo := tpHoras;
    pCalculaValorLocacaoPorHora(False);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pConfirmarInspecaoEntrada;
Begin
  If FblnLimparInspecaoEntrada Then
    pLimparGravacaoInspecaoEntrada
  Else
    pGravarDadosInspecaoEntrada;
End;

procedure TItemContratoLocacaoEquipamentos.pConfirmarInspecaoSaida ;
begin
  If FblnLimparInspecaoSaida Then
    pLimparGravacaoInspecaoSaida
  Else
    pGravarDadosInspecaoSaida;
end;

procedure TItemContratoLocacaoEquipamentos.pGravarDadosInspecaoSaida;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE EQLDET                  ';
  strSQL := strSQL + 'SET EQD_DTAIPS = :DTAIPS,      ';
  strSQL := strSQL + '    EQD_CNDIPS = :CNDIPS,      ';
  strSQL := strSQL + '    EQD_OBSIPS = :OBSIPS,      ';
  strSQL := strSQL + '    EQD_OPEIPS = :OPEIPS,      ';
  strSQL := strSQL + '    EQD_SUPIPS = :SUPIPS,      ';
  strSQL := strSQL + '    EQD_HORIPS = :HORIPS       ';
  strSQL := strSQL + 'WHERE AUTOINCREM = :CODDET     ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.DisableControls;
    qryUpd.SQL.Text := strSQL;
    qryUpd.ParamByName('DTAIPS').AsDateTime := FDataInspecaoSaida;
    qryUpd.ParamByName('CNDIPS').AsString   := FstrCondicaoPerfeitaSaida;
    qryUpd.ParamByName('OBSIPS').AsString   := FstrObservacoesSaida;
    qryUpd.ParamByName('OPEIPS').AsString   := FCodConferenteSaida;
    qryUpd.ParamByName('SUPIPS').AsString   := FCodSupervisorSaida;
    qryUpd.ParamByName('CODDET').AsString   := FAutInc;
    qryUpd.ParamByName('HORIPS').AsDateTime := FHoraInspecaoSaida;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;

  pAtualizarDataHoraInicioCobrancaEquipamento(FAutInc);
end;

procedure TItemContratoLocacaoEquipamentos.pGravarDadosInspecaoEntrada;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE EQLDET                  ';
  strSQL := strSQL + 'SET EQD_DTAIPE = :DTAIPE,      ';
  strSQL := strSQL + '    EQD_HIGIPE = :HIGIPE,      ';
  strSQL := strSQL + '    EQD_AVAIPE = :AVAIPE,      ';
  strSQL := strSQL + '    EQD_OBSIPE = :OBSIPE,      ';
  strSQL := strSQL + '    EQD_COBIPE = :COBIPE,      ';
  strSQL := strSQL + '    EQD_VALIPE = :VALIPE,      ';
  strSQL := strSQL + '    EQD_OPEIPE = :OPEIPE,      ';
  strSQL := strSQL + '    EQD_SUPIPE = :SUPIPE,      ';
  strSQL := strSQL + '    EQD_HORIPE = :HORIPE       ';
  strSQL := strSQL + 'WHERE AUTOINCREM = :CODDET     ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Text := strSQL;
    qryUpd.ParamByName('CODDET').AsString := FAutInc;
    qryUpd.ParamByName('HIGIPE').AsString := FstrHigienizado;
    qryUpd.ParamByName('AVAIPE').AsString := FstrAvaria;
    qryUpd.ParamByName('OBSIPE').AsString := FstrObservacoesEntrada;
    qryUpd.ParamByName('COBIPE').AsString := FstrGerarCobranca;
    qryUpd.ParamByName('VALIPE').AsFloat  := FVlrCobranca;
    qryUpd.ParamByName('OPEIPE').AsString := FCodConferenteEntrada;
    qryUpd.ParamByName('SUPIPE').AsString := FCodSupervisorEntrada;
    qryUpd.ParamByName('DTAIPE').AsDateTime := FDataInspecaoEntrada;
    qryUpd.ParamByName('HORIPE').AsDateTime := FHoraInspecaoEntrada;

    qryUpd.ExecSQL;

  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pLimparGravacaoInspecaoEntrada;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE EQLDET               ';
  strSQL := strSQL + 'SET EQD_DTAIPE = NULL,      ';
  strSQL := strSQL + '    EQD_HIGIPE = NULL,      ';
  strSQL := strSQL + '    EQD_AVAIPE = NULL,      ';
  strSQL := strSQL + '    EQD_OBSIPE = NULL,      ';
  strSQL := strSQL + '    EQD_COBIPE = NULL,      ';
  strSQL := strSQL + '    EQD_VALIPE = NULL,      ';
  strSQL := strSQL + '    EQD_OPEIPE = NULL,      ';
  strSQL := strSQL + '    EQD_SUPIPE = NULL,      ';
  strSQL := strSQL + '    EQD_HORIPE = NULL       ';
  strSQL := strSQL + 'WHERE AUTOINCREM = :CODDET  ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Text := strSQL;
    qryUpd.ParamByName('CODDET').AsString := FAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pLimparGravacaoInspecaoSaida;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE EQLDET               ';
  strSQL := strSQL + 'SET EQD_DTAIPS = NULL,      ';
  strSQL := strSQL + '    EQD_CNDIPS = NULL,      ';
  strSQL := strSQL + '    EQD_OBSIPS = NULL,      ';
  strSQL := strSQL + '    EQD_OPEIPS = NULL,      ';
  strSQL := strSQL + '    EQD_SUPIPS = NULL,      ';
  strSQL := strSQL + '    EQD_HORIPS = NULL,      ';
  strSQL := strSQL + '    EQD_DTACOB = NULL,      ';
  strSQL := strSQL + '    EQD_HORCOB = NULL       ';
  strSQL := strSQL + 'WHERE AUTOINCREM = :CODDET  ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.DisableControls;
    qryUpd.SQL.Text := strSQL;
    qryUpd.ParamByName('CODDET').AsString   := FAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pLimpar;
begin
  FAutInc := EmptyStr;
  FTipoCalculo := tpNone;
  FStrTipoCalculo  := EmptyStr;
  FVlrTotalLocacaoContratado := 0;
  FVlrLocacaoContratado := 0;
  FVlrLocacaoLiquido := 0;
  FPerDes := 0;
  FVlrTotLiquido := 0;
  FblnDescontoLiberado := False;
  FlbnAlteradoTotalLiquidoManual := False;
  FMensagem := EmptyStr;
  FListaAcessorios.Clear;
  FEquipamento.pLimpar;
  pLimparDadosInspecaoEntrada;
  pLimparDadosInspecaoSaida;
  FblnLimparInspecaoEntrada := False;
  FblnLimparInspecaoSaida := False;
  FblnRecalcularVlrLocacao:= True;
  FTotDes := 0;
  FVlrDes := 0;
  FPerDes := 0;
  FQtdEqu := 1;
  FblnEquTrc := False;
end;

procedure TItemContratoLocacaoEquipamentos.pLimparAcessorios;
begin
  FListaAcessorios.Clear;
end;

procedure TItemContratoLocacaoEquipamentos.pLimparDadosInspecaoEntrada(blnLimparGravacaoDados: Boolean = False);
begin
  FblnLimparInspecaoEntrada := blnLimparGravacaoDados;
  FInspecaoEntradaRealizada := False;
  FstrInspecaoEntrada := EmptyStr;
  FCodConferenteEntrada := EmptyStr;
  FCodSupervisorEntrada := EmptyStr;
  FNomSupervisorEntrada := EmptyStr;
  FNomConferenteEntrada := EmptyStr;
  FstrHigienizado := EmptyStr;
  FstrAvaria := EmptyStr;
  FstrObservacoesEntrada := EmptyStr;
  FstrGerarCobranca := EmptyStr;
  FVlrCobranca := 0;
  FDataInspecaoEntrada := 0;
  FHoraInspecaoEntrada := 0;
  FVlrCobAce := 0;
end;

procedure TItemContratoLocacaoEquipamentos.pLimparDadosInspecaoSaida(blnLimparGravacaoDados: Boolean = False);
begin
  FblnLimparInspecaoSaida := blnLimparGravacaoDados;
  FInspecaoSaidaRealizada := False;
  FstrInspecaoSaida := EmptyStr;
  FstrCondicaoPerfeitaSaida := EmptyStr;
  FstrObservacoesSaida := EmptyStr;
  FCodConferenteSaida := EmptyStr;
  FNomConferenteSaida := EmptyStr;
  FCodSupervisorSaida := EmptyStr;
  FNomSupervisorSaida := EmptyStr;
  FDataInspecaoSaida := 0;
  FHoraInspecaoSaida := 0;
  FDataIniCobranca := 0;
end;

procedure TItemContratoLocacaoEquipamentos.pLimparDocumentoEnvio;
begin
  FNumEnv := EmptyStr;
  FEmpEnv := EmptyStr;
  FEspEnv := EmptyStr;
  FSerEnv := EmptyStr;
  FstrDocEnv := EmptyStr;
end;

procedure TItemContratoLocacaoEquipamentos.pLimparDocumentoRetorno;
begin
  FNumRet := EmptyStr;
  FEmpRet := EmptyStr;
  FEspRet := EmptyStr;
  FSerRet := EmptyStr;
  FstrDocRet := EmptyStr;
end;

procedure TItemContratoLocacaoEquipamentos.pRealizarInspecaoEntrada(
  const strChaveDet: String; strHigienizado, strAvaria, strObservacoes,
  strGerarCobranca: String; vlrCobranca: Double;
  strCodConf, strCodSup: String; dtaInspecao: TDateTime = 0);
begin

  FNomSupervisorEntrada := EmptyStr;
  FNomConferenteEntrada := EmptyStr;
  FstrHigienizado := strHigienizado;
  FstrAvaria := strAvaria;
  FstrObservacoesEntrada := strObservacoes;
  FstrGerarCobranca := strGerarCobranca;
  FVlrCobranca := vlrCobranca;
  FCodConferenteEntrada := strCodConf;
  FCodSupervisorEntrada := strCodSup;
  FInspecaoEntradaRealizada := True;
  
  If dtaInspecao > 0 Then
  Begin
    FDataInspecaoEntrada := fObtemData(dtaInspecao);
    FHoraInspecaoEntrada := fObtemHora(dtaInspecao);
  End
  Else
  Begin
    FDataInspecaoEntrada := fObtemData(fNow());
    FHoraInspecaoEntrada := fObtemHora(fNow());
  End;
  FstrInspecaoEntrada := 'REALIZADA ' + FormatDateTime('dd/mm/yyyy', FDataInspecaoEntrada);
end;

procedure TItemContratoLocacaoEquipamentos.pRealizarInspecaoSaida(
  const strChaveDet: String; strPerfeitasCondicoes, strObservacoes, strCodConf,
  strCodSup: String; dtaInspecao: TDateTime; dtaCobIni: TDateTime; const blnAtualizaDataCobranca : Boolean = False);
begin
  If (dtaInspecao > 0) Then
  Begin
    FDataInspecaoSaida := fObtemData(dtaInspecao);
    FHoraInspecaoSaida := fObtemHora(dtaInspecao);
  End
  Else
  Begin
    FDataInspecaoSaida := fObtemData(fNow());
    FHoraInspecaoSaida := fObtemHora(fNow());
  End;

  If (dtaCobIni > 0) and Not blnAtualizaDataCobranca Then
  Begin
    FDataIniCobranca   := dtaCobIni;
  End
  Else
  Begin
    FDataIniCobranca   := FDataInspecaoSaida + FHoraInspecaoSaida;
  End;

  FNomConferenteSaida := EmptyStr;
  FNomSupervisorSaida := EmptyStr;
  FstrCondicaoPerfeitaSaida := strPerfeitasCondicoes;
  FstrObservacoesSaida := strObservacoes;
  FCodConferenteSaida := strCodConf;
  FCodSupervisorSaida := strCodSup;
  FInspecaoSaidaRealizada := True;
  FblnLimparInspecaoSaida := False;
  
  FstrInspecaoSaida := 'REALIZADA ' + FormatDateTime('dd/mm/yyyy', FDataInspecaoSaida);
end;

procedure TItemContratoLocacaoEquipamentos.SetSerEnv(const AValue: String);
begin
  FSerEnv := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetAtuIpE(const AValue: Boolean);
begin
  FBlnAtuIpE := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetAtuIpS(const AValue: Boolean);
begin
  FBlnAtuIpS := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetblnEnc(const AValue: Boolean);
begin
  FblnEncerrarItem := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetNomCfE(const AValue: String);
begin
  FNomConferenteEntrada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetCndIps(const AValue: String);
begin
  FstrCondicaoPerfeitaSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetCobTrc(const AValue: Double);
begin
  FVlrCobTrc := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetContrato(
  const AValue: TContratoLocacaoEquipamentos);
begin
  FContrato := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetDocEnv(const AValue: String);
begin
  FstrDocEnv := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetDocRet(const AValue: String);
begin
  FstrDocRet := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetDtaCob(const AValue: TDateTime);
begin
  FDataIniCobranca := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetDtaEnc(const AValue: TDateTime);
begin
  FDataEncerramento := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetDtaFCob(const AValue: TDateTime);
begin
  FDataFimCobranca := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetDtaIpE(const AValue: TDateTime);
begin
  FDataInspecaoEntrada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetDtaIps(const AValue: TDateTime);
begin
  FDataInspecaoSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetDurEql(const AValue: Double);
begin
  FDuracaoContratado := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetEmpEnv(const AValue: String);
begin
  FEmpEnv := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetEmpRet(const AValue: String);
begin
  FEmpRet := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetEqlAva(const AValue: String);
begin
  FstrAvaria := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetEqlHig(const AValue: String);
begin
  FstrHigienizado := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetEquip(
  const AValue: TEquipamentoLocacaoPrincipal);
begin
  FEquipamento := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetEquTrc(const Value: Boolean);
begin
  FblnEquTrc := Value;
end;

procedure TItemContratoLocacaoEquipamentos.SetEspEnv(const AValue: String);
begin
  FEspEnv := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetEspRet(const AValue: String);
begin
  FEspRet := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetGerCob(const AValue: String);
begin
  FstrGerarCobranca := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetHorIpE(const AValue: TDateTime);
begin
  FHoraInspecaoEntrada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetHorIpS(const AValue: TDateTime);
begin
  FHoraInspecaoSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetHraFCob(const AValue: TDateTime);
begin
  FHraFCob := FHraFCob;
end;

procedure TItemContratoLocacaoEquipamentos.SetIspERea(const AValue: Boolean);
begin
  FInspecaoEntradaRealizada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetIspSRea(const AValue: Boolean);
begin
  FInspecaoSaidaRealizada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetLAce(
  const AValue: TList<TAcessorioContratoLocacaoEquipamentos>);
begin
  FListaAcessorios := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetNOpIps(const AValue: String);
begin
  FNomConferenteSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetNSuIpE(const AValue: String);
begin
  FNomSupervisorEntrada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetNSuIps(const AValue: String);
begin
  FNomSupervisorSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetNumEnv(const AValue: String);
begin
  FNumEnv := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetNumRet(const AValue: String);
begin
  FNumRet := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetObsIpE(const AValue: String);
begin
  FstrObservacoesEntrada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetObsIps(const AValue: String);
begin
  FstrObservacoesSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetOpeIpE(const AValue: String);
begin
  FCodConferenteEntrada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetOpeIps(const AValue: String);
begin
  FCodConferenteSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetSerRet(const AValue: String);
begin
  FSerRet := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetStrInsE(const AValue: String);
begin
  FstrInspecaoEntrada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetStrInsS(const AValue: String);
begin
  FstrInspecaoSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetStrTpDur(const AValue: String);
begin
  FStrTipoCalculo := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetSupIpE(const AValue: String);
begin
  FCodSupervisorEntrada := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetSupIps(const AValue: String);
begin
  FCodSupervisorSaida := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetTipDur(
  const AValue: TTipoCalculoValorLocacao);
begin
  FTipoCalculo := AVAlue;
end;

procedure TItemContratoLocacaoEquipamentos.SetTotTrc(const AValue: Double);
begin
  FVlrTotCob := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetUtiFxN(const AValue: String);
begin
  FblnUtilizaFaixaNegociacao := IIF(AValue = 'S', True, False);
end;

procedure TItemContratoLocacaoEquipamentos.SetVlLocC(const AValue: Double);
begin
  FVlrLocacaoContratado := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetVlLocL(const AValue: Double);
begin
  FVlrLocacaoLiquido := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetVlrCob(const AValue: Double);
begin
  FVlrCobranca := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetVlrDes(const AValue: Double);
begin
  FVlrDes := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetVlrTot(const AValue: Double);
begin
  FVlrTot := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetPerDes(const AValue: Double);
begin
  FPerDes := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetQtdEqu(const Value: Double);
begin
  FQtdEqu := Value;
end;

procedure TItemContratoLocacaoEquipamentos.SetVlTotC(const AValue: Double);
begin
  FVlrTotalLocacaoContratado := AValue;
end;

procedure TItemContratoLocacaoEquipamentos.SetVlTotL(const AValue: Double);
begin
  FVlrTotLiquido := AValue;
end;

function TItemContratoLocacaoEquipamentos.fSenhaDescontoContrato(const srtDirAce: String; const aPerDes: Double; const intNvl: Integer): Boolean;
Var
  objLiberacao: TLiberacao;
begin

  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(99);
    objLiberacao.objMsgLibera.pAddTexto('Valor da Locação Menor que o Valor Mínimo Permitido', alCentro, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);

    objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + FContrato.CodCliente + ' - ' + FContrato.NomCliente, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Vendedor: ' + FContrato.Vendedor.Codigo+ ' - ' + FContrato.Vendedor.Nome, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);

    objLiberacao.objMsgLibera.pAddTexto('Equipamento: ' + FEquipamento.Codigo + ' - ' + FEquipamento.Descricao, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Contrado em: ' + GetStrTpDur, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);

    objLiberacao.objMsgLibera.pAddTexto('Valor Total de Tabela: ' + FormatFloat('#,##0.00', FVlrTotalLocacaoContratado), alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('% Desconto Máximo Permitido: ' + FormatFloat('#,##0.00', FEquipamento.ValorDescontoVendedor), alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('% Desconto Concedido: ' + FormatFloat('#,##0.00', FPerDes), alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);

    objLiberacao.objMsgLibera.pAddTexto('Valor Total Líquido: ' +FormatFloat('#,##0.00', FVlrTotLiquido), alEsquerda, teAmbos, '', 99);

    objLiberacao.objMsgLibera.pAddTexto('NECESSÁRIO INFORMAÇÃO DE SENHA', alCentro, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);
    objLiberacao.objMsgLibera.pAddTextoCaption('EMPRESA  SOLICITANTE', VS_strCodEmp);
    objLiberacao.objMsgLibera.pAddTextoCaption('OPERADOR SOLICITANTE', strLoginUsuarioLogado + ' - ' +strDescriUsuarioLogado);

    objLiberacao.strDirAce    := srtDirAce;
    objLiberacao.strDirAceNv2 := cstDirAceDescNvl2;
    objLiberacao.strDirAceNv3 := cstDirAceDescNvl3;

    objLiberacao.strMsgSen := 'Valor da Locação Menor que o Valor Mínimo Permitido.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pAddAcessorios;
var
  itemAux: TAcessorioContratoLocacaoEquipamentos;
  intCnt: Integer;
begin
  FEquipamento.Acessorios.Clear;
  FEquipamento.pCarregaItensAcessorios;
  For intCnt := 0 to FEquipamento.Acessorios.Count-1 do
  Begin
    itemAux := TAcessorioContratoLocacaoEquipamentos.Create(Self);
    itemAux.CodEquipamento := FEquipamento.Codigo;
    itemAux.Acessorio      := FEquipamento.Acessorios[intCnt].Acessorio;
    itemAux.Quantidade     := FEquipamento.Acessorios[intCnt].Quantidade;
    itemAux.ValorAdicional := FEquipamento.Acessorios[intCnt].ValorAdicional;

    FListaAcessorios.add(itemAux);
  End;
end;

procedure TItemContratoLocacaoEquipamentos.pAtualizarDataHoraInicioCobrancaEquipamento(
  const strAutInc: String);
var
  qry: TUniQuery;
Begin
  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('UPDATE EQLDET SET EQD_DTACOB = :EQD_DTACOB, EQD_HORCOB = :EQD_HORCOB WHERE EQD_SEQCON = :EQD_SEQCON AND AUTOINCREM = :EQD_AUTINC');
    qry.ParamByName('EQD_AUTINC').AsString := strAutInc;
    qry.ParamByName('EQD_SEQCON').AsString := FContrato.AutInc;

    If FDataIniCobranca <= 0 Then
      FDataIniCobranca := fNow();

    qry.ParamByName('EQD_DTACOB').AsDateTime := fObtemData(FDataIniCobranca);
    qry.ParamByName('EQD_HORCOB').AsDateTime := fObtemHora(FDataIniCobranca);
    qry.ExecSQL;
  Finally
    pFreeAndNil(qry);
  End;
End;

{ TEmitenteContratoLocacao }

procedure TEmitenteContratoLocacao.pCarregar(const aCodEmp: String);
var
  qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('SELECT EMP_CODEMP,            ' +
                '       EMP_NOMEMP,            ' +
                '       EMP_C_G_C_,            ' +
                '       EMP_ENDERE,            ' +
                '       CID_CODCID,            ' +
                '       CID_NOMCID,            ' +
                '       EMP_FONE01,            ' +
                '       EMP_F_A_X_,            ' +
                '       EMP_BAIRRO,            ' +
                '       EMP_ENDNUM,            ' +
                '       EMP_C_E_P_,            ' +
                '       CID_ESTADO,            ' +
                '       EMP_I_E_S_             ' +
                '  FROM CADEMP                 ' +
                'INNER JOIN CADCID             ' +
                '   ON CID_CODCID = EMP_CODCID ' +
                'WHERE EMP_CODEMP = :CODEMP    ');
    qry.ParamByName('CODEMP').AsString := aCodEmp;
    qry.Open;
    If Not qry.IsEmpty Then
    Begin
      FCodEmp := qry.FieldByName('EMP_CODEMP').AsString;
      FNomEmp := qry.FieldByName('EMP_NOMEMP').AsString;
      FEmtCGC := qry.FieldByName('EMP_C_G_C_').AsString;
      FEndere := qry.FieldByName('EMP_ENDERE').AsString;
      FCodCid := qry.FieldByName('CID_CODCID').AsString;
      FNomCid := qry.FieldByName('CID_NOMCID').AsString;
      FFone01 := qry.FieldByName('EMP_FONE01').AsString;
      FNumFax := qry.FieldByName('EMP_F_A_X_').AsString;
      FBairro := qry.FieldByName('EMP_BAIRRO').AsString;
      FNumEnd := qry.FieldByName('EMP_ENDNUM').AsString;
      F_C_E_P := qry.FieldByName('EMP_C_E_P_').AsString;
      FEstado := qry.FieldByName('CID_ESTADO').AsString;
      F_I_E_S := qry.FieldByName('EMP_I_E_S_').AsString;
    End;

  Finally
    FreeAndNil(qry);
  End;
end;

function TEmitenteContratoLocacao.GetBairro: String;
begin
  Result := FBairro;
end;

function TEmitenteContratoLocacao.GetCep: String;
begin
  Result := F_C_E_P;
end;

function TEmitenteContratoLocacao.GetCodCid: String;
begin
  Result := FCodCid;
end;

function TEmitenteContratoLocacao.GetCodEmp: String;
begin
  Result := FCodEmp;
end;

function TEmitenteContratoLocacao.GetEmtCGC: String;
begin
  Result := FEmtCGC;
end;

function TEmitenteContratoLocacao.GetEndEmp: String;
begin
  Result := FEndere;
end;

function TEmitenteContratoLocacao.GetEstado: String;
begin
  Result := FEstado;
end;

function TEmitenteContratoLocacao.GetFone01: String;
begin
  Result := FFone01;
end;

function TEmitenteContratoLocacao.GetIES: String;
begin
  Result := F_I_E_S;
end;

function TEmitenteContratoLocacao.GetNomCid: String;
begin
  Result := FNomCid;
end;

function TEmitenteContratoLocacao.GetNomEmp: String;
begin
  Result := FNomEmp;
end;

function TEmitenteContratoLocacao.GetNumEnd: String;
begin
  Result := FNumEnd;
end;

function TEmitenteContratoLocacao.GetNumFax: String;
begin
  Result := FNumFax;
end;

procedure TEmitenteContratoLocacao.SetBairro(const AValue: String);
begin
  FBairro := AValue;
end;

procedure TEmitenteContratoLocacao.SetCep(const AValue: String);
begin
  F_C_E_P := AValue;
end;

procedure TEmitenteContratoLocacao.SetCodCid(const AValue: String);
begin
  FCodCid := AValue;
end;

procedure TEmitenteContratoLocacao.SetCodEmp(const AValue: String);
begin
  FCodEmp := AValue;
end;

procedure TEmitenteContratoLocacao.SetEmtCGC(const AValue: String);
begin
  FEmtCGC := AValue;
end;

procedure TEmitenteContratoLocacao.SetEndEmp(const AValue: String);
begin
  FEndere := AValue;
end;

procedure TEmitenteContratoLocacao.SetEstado(const AValue: String);
begin
  FEstado := AValue;
end;

procedure TEmitenteContratoLocacao.SetFone01(const AValue: String);
begin
  FFone01 := AValue;
end;

procedure TEmitenteContratoLocacao.SetIES(const aValue: String);
begin
  F_I_E_S := aValue;
end;

procedure TEmitenteContratoLocacao.SetNomCid(const AValue: String);
begin
  FNomCid := AValue;
end;

procedure TEmitenteContratoLocacao.SetNomEmp(const AValue: String);
begin
  FNomEmp := AValue;
end;

procedure TEmitenteContratoLocacao.SetNumEnd(const AValue: String);
begin
  FNumEnd := AValue;
end;

procedure TEmitenteContratoLocacao.SetNumFax(const AValue: String);
begin
  FNumFax := AValue;
end;

{ TAcessorioContratoLocacaoEquipamentos }

constructor TAcessorioContratoLocacaoEquipamentos.Create(
  Owner: TItemContratoLocacaoEquipamentos);
begin
  FItem := Owner;
  FAcessorio := TEquipamentoLocacaoAcessorio.Create;

  FqryInsert := fCriaQuery;
  FqryInsert.DisableControls;

  FqryDelete := fCriaQuery;
  FqryDelete.DisableControls;

  pLimpar;
end;

destructor TAcessorioContratoLocacaoEquipamentos.Destroy;
begin

  inherited;
end;

function TAcessorioContratoLocacaoEquipamentos.fBloquearCadastroAcessorio: Boolean;
var
  qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('UPDATE CADACL SET ACL_STATUS = "B" WHERE AUTOINCREM = :AUTOINCREM');
    qry.ParamByName('AUTOINCREM').AsString := FAcessorio.AutInc;
    qry.ExecSQL;
    Result := True;
  Finally
    qry.Close;
  End;

end;

function TAcessorioContratoLocacaoEquipamentos.fExcluir: Boolean;
begin
  Try
    FqryDelete.SQL.Clear;
    FqryDelete.SQL.Add('DELETE FROM ACLDET WHERE AUTOINCREM = :AUTOINCREM');
    FqryDelete.ParamByName('AUTOINCREM').AsString := FAutInc;
    FqryDelete.ExecSQL;

    Result := True;
  Finally
    FqryDelete.Close;
  End;
end;

function TAcessorioContratoLocacaoEquipamentos.fInserir: Boolean;
Begin
  Try
    FAutInc := fRetAutoIncrem('ACLDET', VS_strCodEmp);

    FqryInsert.SQL.Clear;
    FqryInsert.SQL.Add('INSERT INTO ACLDET( AUTOINCREM,	EQD_SEQCON,	EQD_SEQEQL, EQD_SEQACL,	EQD_QTDACL, EQD_VLRAQU, EQD_VLRADC) ' +
                       'VALUES            ( :AUTOINCREM, :EQD_SEQCON,	:EQD_SEQEQL, :EQD_SEQACL, :EQD_QTDACL, :EQD_VLRAQU, :EQD_VLRADC) ' );
    FqryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    FqryInsert.ParamByName('EQD_SEQCON').AsString := FItem.FContrato.FAutInc;
    FqryInsert.ParamByName('EQD_SEQEQL').AsString := FItem.FEquipamento.Codigo;
    FqryInsert.ParamByName('EQD_SEQACL').AsString := FAcessorio.Codigo;
    FqryInsert.ParamByName('EQD_QTDACL').AsFloat  := FQtdAcl;
    FqryInsert.ParamByName('EQD_VLRAQU').AsFloat  := FAcessorio.ValorAqu;
    FqryInsert.ParamByName('EQD_VLRADC').AsFloat  := FAcessorio.ValorAdicional;
    FqryInsert.ExecSQL;
    Result := True;
  Finally
    FqryInsert.Close;
  End;
End;

function TAcessorioContratoLocacaoEquipamentos.fValidaDataInspecao(
  const aDtaInspecao: TDateTime): Boolean;
begin
  Result := aDtaInspecao > (FItem.FContrato.DataInicial + FItem.FContrato.HoraInicial);
end;

procedure TAcessorioContratoLocacaoEquipamentos.pRealizarInspecaoEntrada(
  const strChaveDet: String; strHigienizado, strAvaria, strObservacoes,
  strGerarCobranca: String; vlrCobranca: Double; strCodConf, strCodSup: String;
  dtaInspecao: TDateTime = 0; blnAtualizarDataInsp: Boolean = True);
begin
  FNomSupervisorEntrada := EmptyStr;
  FNomConferenteEntrada := EmptyStr;
  FstrHigienizado := strHigienizado;
  FstrAvaria := strAvaria;
  FstrObservacoesEntrada := strObservacoes;
  FstrGerarCobranca := strGerarCobranca;
  FVlrCobranca := vlrCobranca;
  FCodConferenteEntrada := strCodConf;
  FCodSupervisorEntrada := strCodSup;
  FInspecaoEntradaRealizada := True;
  If (dtaInspecao > 0) and Not blnAtualizarDataInsp Then
  Begin
    FDataInspecaoEntrada := fObtemData(dtaInspecao);
    FHoraInspecaoEntrada := fObtemHora(dtaInspecao);
  End
  Else
  Begin
    FDataInspecaoEntrada := Today;
    FHoraInspecaoEntrada := fObtemHora(fNow());
  End;
  FstrInspecaoEntrada := 'REALIZADA ' + FormatDateTime('dd/mm/yyyy', FDataInspecaoEntrada);
end;

procedure TAcessorioContratoLocacaoEquipamentos.pRealizarInspecaoSaida(const strChaveDet: String; strPerfeitasCondicoes: String; strObservacoes: String;
  strCodConf: String; strCodSup: String; dtaInspecao: TDateTime = 0; blnAtualizarDataInsp: Boolean = True);
begin
  FNomSupervisorSaida := EmptyStr;
  FNomConferenteSaida := EmptyStr;
  FstrCondicaoPerfeitaSaida := strPerfeitasCondicoes;
  FstrObservacoesSaida := strObservacoes;
  FCodConferenteSaida := strCodConf;
  FCodSupervisorSaida := strCodSup;
  FInspecaoSaidaRealizada := True;

  If (dtaInspecao > 0) and Not blnAtualizarDataInsp Then
  Begin
    FDataInspecaoSaida := fObtemData(dtaInspecao);
    FHoraInspecaoSaida := fObtemHora(dtaInspecao);
  End
  Else
  Begin
    FDataInspecaoSaida := Today;
    FHoraInspecaoSaida := fObtemHora(fNow());
  End;

  FstrInspecaoSaida := 'REALIZADA ' + FormatDateTime('dd/mm/yyyy', FDataInspecaoSaida);
end;

function TAcessorioContratoLocacaoEquipamentos.GetAcessorio: TEquipamentoLocacaoAcessorio;
begin
  Result := FAcessorio;
end;

function TAcessorioContratoLocacaoEquipamentos.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TAcessorioContratoLocacaoEquipamentos.GetBlnAtuEnt: Boolean;
begin
  Result := FblnAtualizarInspEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetBlnAtuSai: Boolean;
begin
  Result := FblnAtualizarInspSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetCndIps: String;
begin
  Result := FstrCondicaoPerfeitaSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetCodEql: String;
begin
  Result := FCodEql;
end;

function TAcessorioContratoLocacaoEquipamentos.GetDatIpS: TDateTime;
begin
  Result := FDataInspecaoSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetDocEnv: String;
begin
  Result := FstrDocEnv;
end;

function TAcessorioContratoLocacaoEquipamentos.GetDocRet: String;
begin
  Result := FstrDocRet;
end;

function TAcessorioContratoLocacaoEquipamentos.GetDtaIpe: TDateTime;
begin
  Result := FDataInspecaoEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetEqlAva: String;
begin
  Result := FstrAvaria;
end;

function TAcessorioContratoLocacaoEquipamentos.GetEqlHig: String;
begin
  Result := FstrHigienizado;
end;

function TAcessorioContratoLocacaoEquipamentos.GetGerCob: String;
begin
  Result := FstrGerarCobranca;
end;

function TAcessorioContratoLocacaoEquipamentos.getHorIpE: TDateTime;
begin
  Result := FHoraInspecaoEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.getHorIpS: TDateTime;
begin
  Result := FHoraInspecaoSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetIspERea: Boolean;
begin
  Result := FInspecaoEntradaRealizada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetIspSRea: Boolean;
begin
  Result := FInspecaoSaidaRealizada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetItem: TItemContratoLocacaoEquipamentos;
begin
  Result := FItem;
end;

function TAcessorioContratoLocacaoEquipamentos.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TAcessorioContratoLocacaoEquipamentos.GetNomCfE: String;
begin
  If fEmptyStr(FNomConferenteEntrada) Then
  Begin
    FNomConferenteEntrada := fRetNomeOperador(FCodConferenteEntrada);
  End;

  Result := FNomConferenteEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetNOpIps: String;
begin
  If fEmptyStr(FNomConferenteSaida) Then
  Begin
    FNomConferenteSaida := fRetNomeOperador(FCodConferenteSaida);
  End;

  Result := FNomConferenteSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetNSuIpE: String;
begin
  If fEmptyStr(FNomSupervisorEntrada) Then
  Begin
    FNomSupervisorEntrada := fRetNomeOperador(FCodSupervisorEntrada);
  End;

  Result := FNomSupervisorEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetNSuIps: String;
begin
  If fEmptyStr(FNomSupervisorSaida) Then
  Begin
    FNomSupervisorSaida := fRetNomeOperador(FCodSupervisorSaida);
  End;

  Result := FNomSupervisorSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetObsIpE: String;
begin
  Result := FstrObservacoesEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetObsIps: String;
begin
  Result := FstrObservacoesSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetOpeIpE: String;
begin
  Result := FCodConferenteEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetOpeIps: String;
begin
  Result := FCodConferenteSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetQtdAcl: Double;
begin
  Result := FQtdAcl;
end;

function TAcessorioContratoLocacaoEquipamentos.GetStrAva: String;
begin
  Result := IIF(FstrAvaria = 'S', 'Sim', 'Não');
end;

function TAcessorioContratoLocacaoEquipamentos.GetStrInsE: String;
begin
  Result := FstrInspecaoEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetStrInsS: String;
begin
  Result := FstrInspecaoSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetSupIpE: String;
begin
  Result := FCodSupervisorEntrada;
end;

function TAcessorioContratoLocacaoEquipamentos.GetSupIps: String;
begin
  Result := FCodSupervisorSaida;
end;

function TAcessorioContratoLocacaoEquipamentos.GetVlrAdc: Double;
begin
  Result := FVlrAdc;
end;

function TAcessorioContratoLocacaoEquipamentos.GetVlrCob: Double;
begin
  Result := FVlrCobranca;
end;

procedure TAcessorioContratoLocacaoEquipamentos.pCarregar(
  const strAutInc: String);
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
begin

  SQLSelect := 'SELECT ACLDET.*,                          ' +
               '  IF(                                     ' +
               '    EQD_DTAIPS IS NULL,                   ' +
               '    "PENDENTE",                           ' +
               '     CONCAT(                              ' +
               '      "REALIZADA ",                       ' +
               '      DATE_FORMAT(EQD_DTAIPS, "%d/%m/%Y") ' +
               '    )                                     ' +
               '  ) AS EQD_STTIPS,                        ' +
               '  IF(                                     ' +
               '    EQD_DTAIPE IS NULL,                   ' +
               '    "PENDENTE",                           ' +
               '    CONCAT(                               ' +
               '      "REALIZADA ",                       ' +
               '      DATE_FORMAT(EQD_DTAIPE, "%d/%m/%Y") ' +
               '    )                                     ' +
               '  ) AS EQD_STTIPE,                        ' +
               '  E.OPE_NOMOPE AS  OPE_NOMIPE,            ' +
               '  CONCAT(                                 ' +
               '    EQD_NUMENV,                           ' +
               '    "-",                                  ' +
               '    EQD_ESPENV,                           ' +
               '    "-",                                  ' +
               '    EQD_EMPENV                            ' +
               '  ) AS EQD_DOCENV,                        ' +
               '  CONCAT(                                 ' +
               '    EQD_NUMRET,                           ' +
               '    "-",                                  ' +
               '    EQD_ESPRET,                           ' +
               '    "-",                                  ' +
               '    EQD_EMPRET                            ' +
               '  ) AS EQD_DOCRET,                        ' +
               '  SUPE.OPE_NOMOPE AS OPE_NOMSPE,          ' +
               '  SUPS.OPE_NOMOPE AS OPE_NOMSPS,          ' +
               '  ACLDET.EQD_VLRADC                       ' +
               'FROM ACLDET                               ' +
               'LEFT JOIN CADOPE E ON (E.OPE_CODOPE = ACLDET.EQD_OPEIPE)  ' +
               'LEFT JOIN CADOPE SUPE ON (SUPE.OPE_CODOPE = ACLDET.EQD_SUPIPE)  ' +
               'LEFT JOIN CADOPE SUPS ON (SUPS.OPE_CODOPE = ACLDET.EQD_SUPIPS)  ' +
               'WHERE ACLDET.AUTOINCREM = :AUTINC    ' +
               'ORDER BY ACLDET.AUTOINCREM ';

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    qryConsulta.ParamByName('AUTINC').AsString := strAutInc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      FAutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;
      FCodEql := qryConsulta.FieldByName('EQD_SEQEQL').AsString;
      FQtdAcl := qryConsulta.FieldByName('EQD_QTDACL').AsFloat;
      FInspecaoEntradaRealizada := Not(qryConsulta.FieldByName('EQD_STTIPE').AsString = 'PENDENTE');
      FInspecaoSaidaRealizada := Not(qryConsulta.FieldByName('EQD_STTIPS').AsString = 'PENDENTE');
      FstrInspecaoEntrada := qryConsulta.FieldByName('EQD_STTIPE').AsString;
      FstrInspecaoSaida := qryConsulta.FieldByName('EQD_STTIPS').AsString;
      FstrCondicaoPerfeitaSaida := qryConsulta.FieldByName('EQD_CNDIPS').AsString;
      FstrObservacoesSaida := qryConsulta.FieldByName('EQD_OBSIPS').AsString;
      FCodConferenteSaida := qryConsulta.FieldByName('EQD_OPEIPS').AsString;
      FCodSupervisorSaida := qryConsulta.FieldByName('EQD_SUPIPS').AsString;
      FstrHigienizado := qryConsulta.FieldByName('EQD_HIGIPE').AsString;
      FstrAvaria := qryConsulta.FieldByName('EQD_AVAIPE').AsString;
      FstrObservacoesEntrada := qryConsulta.FieldByName('EQD_OBSIPE').AsString;
      FstrGerarCobranca := qryConsulta.FieldByName('EQD_COBIPE').AsString;
      FVlrCobranca := qryConsulta.FieldByName('EQD_VALIPE').AsFloat;
      FCodConferenteEntrada := qryConsulta.FieldByName('EQD_OPEIPE').AsString;
      FCodSupervisorEntrada := qryConsulta.FieldByName('EQD_SUPIPE').AsString;
      FNomConferenteEntrada := qryConsulta.FieldByName('OPE_NOMIPE').AsString;
      FDataInspecaoEntrada := qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime;
      FDataInspecaoSaida := qryConsulta.FieldByName('EQD_DTAIPS').AsDateTime;
      FHoraInspecaoEntrada := qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
      FHoraInspecaoSaida := qryConsulta.FieldByName('EQD_HORIPS').AsDateTime;
      FstrDocEnv := qryConsulta.FieldByName('EQD_DOCENV').AsString;
      FstrDocRet := qryConsulta.FieldByName('EQD_DOCRET').AsString;
      FNomSupervisorEntrada := qryConsulta.FieldByName('OPE_NOMSPE').AsString;
      FNomSupervisorSaida:= qryConsulta.FieldByName('OPE_NOMSPS').AsString;
      FVlrAdc := qryConsulta.FieldByName('EQD_VLRADC').AsFloat;

      FAcessorio.fCarregaAcessorio(qryConsulta.FieldByName('EQD_SEQACL').AsString);

      FVlrTotal := FVlrCobranca;
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TAcessorioContratoLocacaoEquipamentos.pGravarDadosInspecaoEntrada;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ACLDET                  ';
  strSQL := strSQL + 'SET EQD_DTAIPE = :DTAIPE,      ';
  strSQL := strSQL + '    EQD_HIGIPE = :HIGIPE,      ';
  strSQL := strSQL + '    EQD_AVAIPE = :AVAIPE,      ';
  strSQL := strSQL + '    EQD_OBSIPE = :OBSIPE,      ';
  strSQL := strSQL + '    EQD_COBIPE = :COBIPE,      ';
  strSQL := strSQL + '    EQD_VALIPE = :VALIPE,      ';
  If Not fEmptyStr(FCodConferenteEntrada) Then
    strSQL := strSQL + '    EQD_OPEIPE = :OPEIPE,    ';
  If Not fEmptyStr(FCodSupervisorEntrada) Then
    strSQL := strSQL + '    EQD_SUPIPE = :SUPIPE,    ';
  strSQL := strSQL + '    EQD_HORIPE = :HORIPE       ';
  strSQL := strSQL + 'WHERE AUTOINCREM = :CODDET     ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Text := strSQL;
    qryUpd.ParamByName('CODDET').AsString := FAutInc;
    qryUpd.ParamByName('HIGIPE').AsString := FstrHigienizado;
    qryUpd.ParamByName('AVAIPE').AsString := FstrAvaria;
    qryUpd.ParamByName('OBSIPE').AsString := FstrObservacoesEntrada;
    qryUpd.ParamByName('COBIPE').AsString := FstrGerarCobranca;
    qryUpd.ParamByName('VALIPE').AsFloat  := FvlrCobranca;
    If Not fEmptyStr(FCodConferenteEntrada) Then
      qryUpd.ParamByName('OPEIPE').AsString := FCodConferenteEntrada;
    If Not fEmptyStr(FCodSupervisorEntrada) Then
    qryUpd.ParamByName('SUPIPE').AsString := FCodSupervisorEntrada;
    qryUpd.ParamByName('CODDET').AsString := FAutInc;
    qryUpd.ParamByName('DTAIPE').AsDateTime := FDataInspecaoEntrada;
    qryUpd.ParamByName('HORIPE').AsDateTime := FHoraInspecaoEntrada;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TAcessorioContratoLocacaoEquipamentos.pConfirmarInspecaoEntrada;
Begin
  If FblnLimparInspecaoEntrada Then
    pLimparGravacaoInspecaoEntrada
  Else
    pGravarDadosInspecaoEntrada;
End;

procedure TAcessorioContratoLocacaoEquipamentos.pConfirmarInspecaoSaida;
Begin
  If FblnLimparInspecaoSaida Then
    pLimparGravacaoInspecaoSaida
  Else
    pGravarDadosInspecaoSaida;
End;

procedure TAcessorioContratoLocacaoEquipamentos.pGravarDadosInspecaoSaida;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ACLDET                  ';
  strSQL := strSQL + 'SET EQD_DTAIPS = :DTAIPS,      ';
  strSQL := strSQL + '    EQD_CNDIPS = :CNDIPS,      ';
  strSQL := strSQL + '    EQD_OBSIPS = :OBSIPS,      ';
  If Not fEmptyStr(FCodConferenteSaida) Then
    strSQL := strSQL + '    EQD_OPEIPS = :OPEIPS,    ';
  If Not fEmptyStr(FCodSupervisorSaida) Then
    strSQL := strSQL + '    EQD_SUPIPS = :SUPIPS,    ';
  strSQL := strSQL + '    EQD_HORIPS = :HORIPS       ';
  strSQL := strSQL + 'WHERE AUTOINCREM = :CODDET     ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.DisableControls;
    qryUpd.SQL.Text := strSQL;
    qryUpd.ParamByName('CNDIPS').AsString   := FstrCondicaoPerfeitaSaida;
    qryUpd.ParamByName('OBSIPS').AsString   := FstrObservacoesSaida;
    qryUpd.ParamByName('OPEIPS').AsString   := FCodConferenteSaida;
    qryUpd.ParamByName('SUPIPS').AsString   := FCodSupervisorSaida;
    qryUpd.ParamByName('CODDET').AsString   := FAutinc;
    qryUpd.ParamByName('DTAIPS').AsDateTime := FDataInspecaoSaida;
    qryUpd.ParamByName('HORIPS').AsDateTime := FHoraInspecaoSaida;

    qryUpd.ExecSQL;

  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TAcessorioContratoLocacaoEquipamentos.pLimpar;
begin
  FAutInc := EmptyStr;
  FQtdAcl := 0;
  FMensagem := EmptyStr;
  FVlrAdc := 0;
end;

procedure TAcessorioContratoLocacaoEquipamentos.pLimparDadosInspecaoEntrada(const blnLimparGravacaoDados: Boolean = False);
begin
  FblnLimparInspecaoEntrada := blnLimparGravacaoDados;
  FInspecaoEntradaRealizada := False;
  FstrInspecaoEntrada := EmptyStr;
  FNomSupervisorEntrada := EmptyStr;
  FNomConferenteEntrada := EmptyStr;
  FstrHigienizado := EmptyStr;
  FstrAvaria := EmptyStr;
  FstrObservacoesEntrada := EmptyStr;
  FstrGerarCobranca := EmptyStr;
  FVlrCobranca := 0;
  FCodConferenteEntrada := EmptyStr;
  FCodSupervisorEntrada := EmptyStr;
  FDataInspecaoEntrada := 0;
  FHoraInspecaoEntrada := 0;
end;

procedure TAcessorioContratoLocacaoEquipamentos.pLimparDadosInspecaoSaida(const blnLimparGravacaoDados: Boolean = False);
begin
  FblnLimparInspecaoSaida := blnLimparGravacaoDados;
  FInspecaoSaidaRealizada := False;
  FstrInspecaoSaida := EmptyStr;
  FstrCondicaoPerfeitaSaida := EmptyStr;
  FstrObservacoesSaida := EmptyStr;
  FCodConferenteSaida := EmptyStr;
  FNomConferenteSaida := EmptyStr;
  FCodSupervisorSaida := EmptyStr;
  FNomSupervisorSaida := EmptyStr;
  FDataInspecaoSaida := 0;
  FHoraInspecaoSaida := 0;
end;

procedure TAcessorioContratoLocacaoEquipamentos.pLimparGravacaoInspecaoEntrada;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ACLDET               ';
  strSQL := strSQL + 'SET EQD_DTAIPE = NULL,      ';
  strSQL := strSQL + '    EQD_HIGIPE = NULL,      ';
  strSQL := strSQL + '    EQD_AVAIPE = NULL,      ';
  strSQL := strSQL + '    EQD_OBSIPE = NULL,      ';
  strSQL := strSQL + '    EQD_COBIPE = NULL,      ';
  strSQL := strSQL + '    EQD_VALIPE = NULL,      ';
  strSQL := strSQL + '    EQD_OPEIPE = NULL,      ';
  strSQL := strSQL + '    EQD_SUPIPE = NULL,      ';
  strSQL := strSQL + '    EQD_HORIPE = NULL       ';
  strSQL := strSQL + 'WHERE AUTOINCREM = :CODDET  ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Text := strSQL;
    qryUpd.ParamByName('CODDET').AsString := FAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TAcessorioContratoLocacaoEquipamentos.pLimparGravacaoInspecaoSaida;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ACLDET               ';
  strSQL := strSQL + 'SET EQD_DTAIPS = NULL,      ';
  strSQL := strSQL + '    EQD_CNDIPS = NULL,      ';
  strSQL := strSQL + '    EQD_OBSIPS = NULL,      ';
  strSQL := strSQL + '    EQD_OPEIPS = NULL,      ';
  strSQL := strSQL + '    EQD_SUPIPS = NULL,      ';
  strSQL := strSQL + '    EQD_HORIPS = NULL       ';
  strSQL := strSQL + 'WHERE AUTOINCREM = :CODDET  ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.DisableControls;
    qryUpd.SQL.Text := strSQL;
    qryUpd.ParamByName('CODDET').AsString   := FAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetAcessorio(
  const AValue: TEquipamentoLocacaoAcessorio);
begin
  FAcessorio := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetBlnAtuEnt(
  const AValue: Boolean);
begin
  FblnAtualizarInspEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetBlnAtuSai(
  const AValue: Boolean);
begin
  FblnAtualizarInspSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetCndIps(const AValue: String);
begin
  FstrCondicaoPerfeitaSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetCodEql(const AValue: String);
begin
  FCodEql := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetDatIpS(
  const AValue: TDateTime);
begin
  FDataInspecaoSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetDocEnv(const AValue: String);
begin
  FstrDocEnv := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetDocRet(const AValue: String);
begin
  FstrDocRet := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetDtaIpE(
  const AValue: TDateTime);
begin
  FDataInspecaoEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetEqlAva(const AValue: String);
begin
  FstrAvaria := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetEqlHig(const AValue: String);
begin
  FstrHigienizado := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetGerCob(const AValue: String);
begin
  FstrGerarCobranca := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetHorIpE(
  const AValue: TDateTime);
begin
  FHoraInspecaoEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetHorIpS(
  const AValue: TDateTime);
begin
  FHoraInspecaoSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetIspERea(
  const AValue: Boolean);
begin
  FInspecaoEntradaRealizada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetIspSRea(
  const AValue: Boolean);
begin
  FInspecaoSaidaRealizada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetNomCfE(const AValue: String);
begin
  FNomConferenteEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetNOpIps(const AValue: String);
begin
  FNomConferenteSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetNSuIpE(const AValue: String);
begin
  FNomSupervisorEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetNSuIps(const AValue: String);
begin
  FNomSupervisorSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetObsIpE(const AValue: String);
begin
  FstrObservacoesEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetObsIps(const AValue: String);
begin
  FstrObservacoesSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetOpeIpE(const AValue: String);
begin
  FCodConferenteEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetOpeIps(const AValue: String);
begin
  FCodConferenteSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetQtdAcl(const AValue: Double);
begin
  FQtdAcl := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetStrInsE(const AValue: String);
begin
  FstrInspecaoEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetStrInsS(const AValue: String);
begin
  FstrInspecaoSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetSupIpE(const AValue: String);
begin
  FCodSupervisorEntrada := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetSupIps(const AValue: String);
begin
  FCodSupervisorSaida := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetVlrAdc(const AValue: Double);
begin
  FVlrAdc := AValue;
end;

procedure TAcessorioContratoLocacaoEquipamentos.SetVlrCob(const AValue: Double);
begin
  FVlrCobranca := AValue;
end;

{ TClienteContratoLocacao }

function TClienteContratoLocacao.GetCliBai: String;
begin
  Result := FCliBairro;
end;

function TClienteContratoLocacao.GetCliCep: String;
begin
  Result := FCliCep;
end;

function TClienteContratoLocacao.GetCliDoc: String;
begin
  Result := FCliCpfCnpj;
end;

function TClienteContratoLocacao.GetCliEnd: String;
begin
  Result := FCliEndereco;
end;

function TClienteContratoLocacao.GetCliIes: String;
begin
  Result := FCliInscEst;
end;

function TClienteContratoLocacao.GetCli_UF: String;
begin
  Result := FEstado;
end;

function TClienteContratoLocacao.GetCodCli: String;
begin
  Result := FCodCli;
end;

function TClienteContratoLocacao.GetEmail_: String;
begin
  Result := FEmail_;
end;

function TClienteContratoLocacao.GetFone01: String;
begin
  Result := FCliFone01;
end;

function TClienteContratoLocacao.GetFone02: String;
begin
  Result := FCliFone02;
end;

function TClienteContratoLocacao.GetNextel: String;
begin
  Result := FCliNextel;
end;

function TClienteContratoLocacao.GetNomCid: String;
begin
  Result := FNomCid;
end;

function TClienteContratoLocacao.GetNomCli: String;
begin
  Result := FNomCli;
end;

function TClienteContratoLocacao.GetNomFan: String;
begin
  Result := FNomFan;
end;

function TClienteContratoLocacao.GetNumFax: String;
begin
  Result := FCliNumFax;
end;

function TClienteContratoLocacao.GetNum_Rg: String;
begin
  Result := FNum_RG;
end;

function TClienteContratoLocacao.GetRamal1: String;
begin
  Result := FCliRamal1;
end;

function TClienteContratoLocacao.GetRamal2: String;
begin
  Result := FCliRamal2;
end;

function TClienteContratoLocacao.GetRamal3: String;
begin
  Result := FCliRamal3;
end;

function TClienteContratoLocacao.GetTelCel: String;
begin
  Result := FCliTelCel;
end;

function TClienteContratoLocacao.GetTelEnt: String;
begin
  Result := FCliTelEnt;
end;

function TClienteContratoLocacao.GetTipo_1: String;
begin
  Result := FstrTipo_1;
end;

procedure TClienteContratoLocacao.pCarregar(const aCodCli: String; const aSeqCon: String = '');
var
  strSQL: String;
  qryConsulta: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                            ';
  strSQL := strSQL + '  L.CLI_CODCLI,                   ';
  strSQL := strSQL + '  L.CLI_NOMCLI,                   ';
  strSQL := strSQL + '  I.CID_NOMCID,                   ';
  strSQL := strSQL + '  I.CID_ESTADO,                   ';
  strSQL := strSQL + '  L.CLI_FONE01,                   ';
  strSQL := strSQL + '  L.CLI_RAMAL1,                   ';
  strSQL := strSQL + '  L.CLI_FONE02,                   ';
  strSQL := strSQL + '  L.CLI_RAMAL2,                   ';
  strSQL := strSQL + '  L.CLI_F_A_X_,                   ';
  strSQL := strSQL + '  L.CLI_RAMAL3,                   ';
  strSQL := strSQL + '  L.CLI_CELULA,                   ';
  strSQL := strSQL + '  L.CLI_NEXTEL,                   ';
  strSQL := strSQL + '  E.ETC_TELENT,                   ';
  strSQL := strSQL + '  L.CLI_C_G_C_,                   ';
  strSQL := strSQL + '  E.ETC_ENDENT,                   ';
  strSQL := strSQL + '  E.ETC_CEPENT,                   ';
  strSQL := strSQL + '  E.ETC_BAIENT,                   ';
  strSQL := strSQL + '  L.CLI_EMAIL_,                   ';
  strSQL := strSQL + '  L.CLI_I_E_S_,                   ';
  strSQL := strSQL + '  L.CLI_CGCCPF,                   ';
  strSQL := strSQL + '  L.CLI_NUMR_G,                   ';
  strSQL := strSQL + '  L.CLI_FANSOB                    ';
  strSQL := strSQL + 'FROM CADCLI L                     ';
  If Not fEmptyStr(aSeqCon) Then
    strSQL := strSQL + ' INNER JOIN CONEQL C ON L.CLI_CODCLI = C.EQL_CODCLI  ';
  strSQL := strSQL + ' INNER JOIN ENTCLI E              ';
  strSQL := strSQL + '  ON E.ETC_CODCLI = L.CLI_CODCLI  ';
  If Not fEmptyStr(aSeqCon) Then
    strSQL := strSQL + '  AND E.AUTOINCREM = C.EQL_ENTCLI ';
  strSQL := strSQL + 'INNER JOIN CADCID I               ';
  strSQL := strSQL + '  ON I.CID_CODCID = E.ETC_CIDENT  ';
  strSQL := strSQL + 'WHERE L.CLI_CODCLI = :CODCLI      ';
  If Not fEmptyStr(aSeqCon) Then
    strSQL := strSQL + 'AND C.AUTOINCREM = :SEQCON        ';

  pLimpar;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(strSQL);
    qryConsulta.ParamByName('CODCLI').AsString := aCodCli;
    If Not fEmptyStr(aSeqCon) Then
      qryConsulta.ParamByName('SEQCON').AsString := aSeqCon;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      FCodCli := qryConsulta.FieldByName('CLI_CODCLI').AsString;
      FNomCli := qryConsulta.FieldByName('CLI_NOMCLI').AsString;
      FCliFone01 := qryConsulta.FieldByName('CLI_FONE01').AsString;
      FCliRamal1 := qryConsulta.FieldByName('CLI_RAMAL1').AsString;
      FCliFone02 := qryConsulta.FieldByName('CLI_FONE02').AsString;
      FCliRamal2 := qryConsulta.FieldByName('CLI_RAMAL2').AsString;
      FCliNumFax := qryConsulta.FieldByName('CLI_F_A_X_').AsString;
      FCliRamal3 := qryConsulta.FieldByName('CLI_RAMAL3').AsString;
      FCliTelCel := qryConsulta.FieldByName('CLI_CELULA').AsString;
      FCliNextel := qryConsulta.FieldByName('CLI_NEXTEL').AsString;
      FCliNextel := qryConsulta.FieldByName('ETC_TELENT').AsString;
      FNomCid    := qryConsulta.FieldByName('CID_NOMCID').AsString;
      FEstado    := qryConsulta.FieldByName('CID_ESTADO').AsString;
      FCliBairro := qryConsulta.FieldByName('ETC_BAIENT').AsString;
      FCliCpfCnpj:= qryConsulta.FieldByName('CLI_C_G_C_').AsString;
      FCliEndereco:= qryConsulta.FieldByName('ETC_ENDENT').AsString;
      FCliCep    := qryConsulta.FieldByName('ETC_CEPENT').AsString;
      FEmail_    := qryConsulta.FieldByName('CLI_EMAIL_').AsString;
      FCliInscEst:= qryConsulta.FieldByName('CLI_I_E_S_').AsString;
      FstrTipo_1 := IIF(qryConsulta.FieldByName('CLI_CGCCPF').AsString = '1', 'CNPJ', 'CPF');
      FNum_Rg    := qryConsulta.FieldByName('CLI_NUMR_G').AsString;
      FNomFan    := qryConsulta.FieldByName('CLI_FANSOB').AsString;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TClienteContratoLocacao.pLimpar;
begin
  FCodCli := EmptyStr;
  FNomCli := EmptyStr;
  FCliFone01 := EmptyStr;
  FCliRamal1 := EmptyStr;
  FCliFone02 := EmptyStr;
  FCliRamal2 := EmptyStr;
  FCliNumFax := EmptyStr;
  FCliRamal3 := EmptyStr;
  FCliTelCel := EmptyStr;
  FCliNextel := EmptyStr;
  FCliTelEnt := EmptyStr;
  FNomCid := EmptyStr;
  FEstado := EmptyStr;
  FCliBairro := EmptyStr;
  FCliEndereco := EmptyStr;
  FCliCpfCnpj := EmptyStr;
  FCliCep := EmptyStr;
  FEmail_ := EmptyStr;
  FCliInscEst := EmptyStr;
  FstrTipo_1 := EmptyStr;
  FNum_Rg := EmptyStr;
end;

procedure TClienteContratoLocacao.SetCliBai(const AValue: String);
begin
  FCliBairro := AValue;
end;

procedure TClienteContratoLocacao.SetCliCep(const AValue: String);
begin
  FCliCep := AValue;
end;

procedure TClienteContratoLocacao.SetCliDoc(const AValue: String);
begin
  FCliCpfCnpj := AValue;
end;

procedure TClienteContratoLocacao.SetCliEnd(const AValue: String);
begin
  FCliEndereco := AValue;
end;

procedure TClienteContratoLocacao.SetCliIes(const AValue: String);
begin
  FCliInscEst := AValue;
end;

procedure TClienteContratoLocacao.SetCli_UF(const AValue: String);
begin
  FEstado := AValue;
end;

procedure TClienteContratoLocacao.SetCodCli(const AValue: String);
begin
  FCodCli := AValue;
end;

procedure TClienteContratoLocacao.SetEmail_(const AValue: String);
begin
  FEmail_ := AValue;
end;

procedure TClienteContratoLocacao.SetFone01(const AValue: String);
begin
  FCliFone01 := AValue;
end;

procedure TClienteContratoLocacao.SetFone02(const AValue: String);
begin
  FCliFone02 := AValue;
end;

procedure TClienteContratoLocacao.SetNextel(const AValue: String);
begin
  FCliNextel := AValue;
end;

procedure TClienteContratoLocacao.SetNomCid(const AValue: String);
begin
  FNomCid := AValue;
end;

procedure TClienteContratoLocacao.SetNomCli(const AValue: String);
begin
  FNomCli := AValue;
end;

procedure TClienteContratoLocacao.SetNomFan(const Value: String);
begin
  FNomFan := Value;
end;

procedure TClienteContratoLocacao.SetnumFax(const AValue: String);
begin
  FCliNumFax := AValue;
end;

procedure TClienteContratoLocacao.SetNum_Rg(const Value: String);
begin
  FNum_Rg := Value;
end;

procedure TClienteContratoLocacao.SetRamal1(const AValue: String);
begin
  FCliRamal1 := AValue;
end;

procedure TClienteContratoLocacao.SetRamal2(const AValue: String);
begin
  FCliRamal2 := AValue;
end;

procedure TClienteContratoLocacao.SetRamal3(const AValue: String);
begin
  FCliRamal3 := AValue;
end;

procedure TClienteContratoLocacao.SetTelCel(const AValue: String);
begin
  FCliTelCel := AValue;
end;

procedure TClienteContratoLocacao.SetTelEnt(const AValue: String);
begin
  FCliTelEnt := AValue;
end;

procedure TClienteContratoLocacao.SetTipo_1(const AValue: String);
begin
  FstrTipo_1 := AValue;
end;

function TClienteContratoLocacao.fFormataTelefoneMensagem(
  const strNroTel, strRamal: String): String;
begin
  Result := EmptyStr;
  If Not fEmptyStr(strNroTel) Then
  Begin
    Result := fFormataFone(strNroTel);
    If Not fEmptyStr(strRamal) Then
      Result := Result + '-' + strRamal;
  End;
end;

function TClienteContratoLocacao.fAdicionaMensagemTelefone(const strMensagem, strTelefone: String): String;
Begin
  If fEmptyStr(strTelefone) Then
    Result := strMensagem;

  If Not fEmptyStr(strMensagem) Then
  Begin
    If Not fEmptyStr(strMensagem) Then
      Result := strMensagem + ' / ';

    Result := Result + strTelefone;
  End;
End;

function TClienteContratoLocacao.fRetornaMensagemTelefone: String;
var
  strTelefoneFormatado: String;
Begin
  strTelefoneFormatado := fFormataTelefoneMensagem(Fone01, Ramal1);
  Result := fAdicionaMensagemTelefone(Result, strTelefoneFormatado);

  strTelefoneFormatado := fFormataTelefoneMensagem(Fone02, Ramal2);
  Result := fAdicionaMensagemTelefone(Result, strTelefoneFormatado);

  strTelefoneFormatado := fFormataTelefoneMensagem(Numfax, Ramal3);
  Result := fAdicionaMensagemTelefone(Result, strTelefoneFormatado);

  strTelefoneFormatado := fFormataTelefoneMensagem(TelCel, '');
  Result := fAdicionaMensagemTelefone(Result, strTelefoneFormatado);

  If Not fEmptyStr(Nextel) Then
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result + ' / ';
    Result := Result + Nextel;
  End;

  strTelefoneFormatado := fFormataTelefoneMensagem(TelEnt, '');
  Result := fAdicionaMensagemTelefone(Result, strTelefoneFormatado);

  If Not fEmptyStr(Result) Then
    Result := 'Telefones: ' + Result;
End;

{ TAdiantamentoContrato }

function TAdiantamentoContrato.GetEmpDoc: String;
begin
  Result := FEmpDocAdt;
end;

function TAdiantamentoContrato.GetEspDoc: String;
begin
  Result := FEspDocAdt;
end;

function TAdiantamentoContrato.GetNumDoc: String;
begin
  Result := FNumDocAdt;
end;

procedure TAdiantamentoContrato.pCarregar(const strAutInc: String);
var
  qrySelect: TUniQuery;
begin
  qrySelect := fCriaQuery;
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP  ');
    qrySelect.SQL.Add('  FROM FATGOR              ');
    qrySelect.SQL.Add('WHERE                      ');
    qrySelect.SQL.Add('  AUTOINCREM = :AUTINC     ');
    qrySelect.ParamByName('AUTINC').AsString := strAutInc;
    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      FNumDocAdt := qrySelect.FieldByName('FGO_NUMDOC').AsString;
      FEspDocAdt := qrySelect.FieldByName('FGO_ESPDOC').AsString;
      FEmpDocAdt := qrySelect.FieldByName('FGO_CODEMP').AsString;
    End;
  Finally
    FreeAndNil(qrySelect);
  End;
end;

procedure TAdiantamentoContrato.SetEmpDoc(const AValue: String);
begin
  FEmpDocAdt := AValue;
end;

procedure TAdiantamentoContrato.SetEspDoc(const AValue: String);
begin
  FEspDocAdt := AValue;
end;

procedure TAdiantamentoContrato.SetNumDoc(const AValue: String);
begin
  FNumDocAdt := AValue;
end;


{ TVendedorContratoLocacao }

procedure TVendedorContratoLocacao.pCarregar(const strCodigo: String);
var
  qry: TUniQuery;
begin
  pLimpar;

  qry := fCriaQuery;
  Try
    qry.DisableControls;
    qry.SQL.Add('SELECT OPE_CODOPE,            ' +
                '       OPE_NOMOPE,            ' +
                '       OPE_NUMCPF             ' +
                '  FROM CADOPE                 ' +
                'WHERE OPE_CODOPE = :OPE_CODOPE  ');
    qry.ParamByName('OPE_CODOPE').AsString := strCodigo;
    qry.Open;
    If Not qry.IsEmpty Then
    Begin
      FCodVen := qry.FieldByName('OPE_CODOPE').AsString;
      FNomVen := qry.FieldByName('OPE_NOMOPE').AsString;
      FCpfVen := qry.FieldByName('OPE_NUMCPF').AsString;
    End;

  Finally
    FreeAndNil(qry);
  End;
end;

procedure TVendedorContratoLocacao.pLimpar;
begin
  FCodVen := EmptyStr;
  FNomVen := EmptyStr;
  FCpfVen := EmptyStr;
end;

procedure TVendedorContratoLocacao.SetCodVen(const AValue: String);
begin
  FCodVen := AValue;
end;

procedure TVendedorContratoLocacao.SetCpfVen(const AValue: String);
begin
  FCpfVen := AValue;
end;

function TVendedorContratoLocacao.GetCodVen: String;
begin
  Result := FCodVen;
end;

procedure TVendedorContratoLocacao.SetNomVen(const AValue: String);
begin
  FNomVen := AValue;
end;

function TVendedorContratoLocacao.GetCpfVen: String;
begin
  Result := FCpfVen;
end;

function TVendedorContratoLocacao.GetNomVen: String;
begin
  Result := FNomVen;
end;



end.


