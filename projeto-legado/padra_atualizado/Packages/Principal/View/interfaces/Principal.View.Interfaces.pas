unit Principal.View.Interfaces;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  System.UITypes, FMX.TMSFNCMapsCommonTypes, FMX.Forms,
  TaEntregue.Romaneios.Interfaces, untMaplinkTripClasses;

Type
  TTipoRotaEfetuada = (rtExata, rtAproximada);

Type
  TTotalizaRotas = record
    fltDistanciaPlanejada : Double;
    intTempoPlanejado     : Integer;
    fltDistanciaEfetuada  : Double;
    intTempoEfetuada      : Integer;
  End;

type
  IItemMenuAutcom = interface
    ['{2976BF69-D7B4-40FB-B963-A09EF5AA5C92}']
    function Name: String;
    function Caption: String;
    function SetCaption(AValue: String): IItemMenuAutcom;
    function Hint: String;
    function Visible: Boolean;
    function Favorito: Boolean;
    procedure ExecutarClick();
    procedure EditarPermissoesAcesso;
    function Items: TList<IItemMenuAutcom>;
    function Find(AName: String): IItemMenuAutcom;
    function Enabled: Boolean;
  end;

  IMenuAutcom = interface
    ['{D3F951AA-D975-457E-A96A-EA280B5B2B1F}']
    function Items: TList<IItemMenuAutcom>;
    function Find(AName: String): IItemMenuAutcom;
  end;

  IFavoritosAutcom = interface
    ['{3F8CB151-6C72-4AD4-B22E-E53B02A12258}']
    function Items: TList<IItemMenuAutcom>;
    procedure AdicionarFavorito(LMenu, LDescricao: String);
    procedure RemoverFavorito(LMenu, LDescricao: String);
  end;

  IRecentesAutcom = interface
    ['{3F8CB151-6C72-4AD4-B22E-E53B02A12258}']
    function Items: TList<IItemMenuAutcom>;
  end;

  IResultadoPesquisaAutcom = interface
    ['{73017791-F8B8-4147-9E43-F0AE64288C6C}']
    function Items: TList<IItemMenuAutcom>;
  end;

  IAba = interface
  ['{5AD0FF6D-A7BF-4B84-B5C3-CB24F2395312}']
    function Titulo: String;
    function NomeBotao: String;
    function Atalho: Integer;
    function Chave: Integer;
    function Tipo: String;
    function TipoVisao: String;
  end;

  IDashboard = interface
    ['{940B4CC5-ABEC-43F4-8ACB-5D3803F00FC1}']
    procedure RetornaDadosProjecaoFaturamento(Var arrValores: Array of Double;
                                              Var ValorMaior: Double;
                                              dtaMes: TDatetime;
                                              strTipEmp: String;
                                              strCodEmp: String;
                                              strTipVis: String);
    procedure RetornaDadosProjecaoMargem(Var Meta, MargemAtual: Double;
                                         dtaMes: TDatetime; strTipEmp: String;
                                         strCodEmp: String;
                                         strComCus: String;
                                         strTipVis: String);
    procedure RetornaDadosTotalVendas(Var arrMeses: Array of Double;
                                      Var ValorMaior: Double;
                                      dtaMes: TDatetime;
                                      strTipEmp: String;
                                      strCodEmp: String;
                                      strTipVis: String);
    procedure RetornaDadosPedidosNaoFaturados(Var arrMeses: Array of Double;
                                              Var ValorMaior: Double;
                                              dtaMes: TDatetime;
                                              strTipEmp: String;
                                              strCodEmp: String;
                                              strTipVis: String);
    function RetornaSQLConstrucaoMeta(dtaMes: TDatetime; strTipEmp: String;
                                      strCodEmp: String): String;
    function RetornaSQLFaturamentoXMetas(dtaMes: TDatetime; strTipEmp: String): String;
    function RetornaSQLMargemXMetas(dtaMes: TDatetime; strTipEmp: String; strComCus: String): String;
    function RetornaSQLTotalVendedores(dtaMes: TDatetime; strTipEmp: String;
                                       strCodEmp: String; strTipVis: String): String;
    function RetornaSQLVendasXMetasDiarias(dtaMes: TDatetime; strTipEmp: String;
                                           strCodEmp: String; strTipVis: String): String;
    function RetornaSQLTotalFormaPagamento(dtaMes: TDatetime; strTipEmp: String; strCodEmp: String): String;
    function RetornaSQLTopClientes(dtaMes: TDatetime; strTipEmp: String; strCodEmp: String): String;
    function RetornaJsonEditorDashBoard(intCodigoAtalho,
                                        intChaveDefault: integer;
                                        arrParametros: Array Of String;
                                        arrValores: Array Of String;
                                        blnMostrarProgresso: Boolean): string;
    Procedure pApagaTemporarias;
    function TemRelatorioConfiguradoParaDashboard: Boolean;
    function EhFeriado(dteData: TDate): Boolean;
    function CfgSis(strCodCfg: String): Variant;
    function RetornaTipoEmpresa: String;
    function ListaEmpresas(ApenasAsQueUsuarioTemAcesso: Boolean = False): TArray<String>;
    function UsuarioTemAcessoAEmpresa(ACodEmp : String): Boolean;
    function NomeEmpresa(ACodigoEmpresa: String): String;
    function ListaCompCusto: TArray<String>;
    function MostrarFiltros: Boolean;
    function fRetornaTipoOperador: String;
    function Abas: TList<IAba>;
    procedure SalvarAbasNovas(lstAbas: TStringList);
    Procedure ApagaTemporarias;
    function OperadorLogado: String;
    function NomeMotorista(ACodigoMotorista: String): String;
    function ListaMotoristas: TArray<String>;
    function UtilizaDashboardWeb: Boolean;
    procedure CarregaAbasDinamicas;
    Procedure pMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);
  end;


type
  IFuncoes = interface
    ['{10B29021-73F8-4841-AA0C-08DA6EDA86E1}']
    procedure BrowserNavigate(strURL: String; AAbrirNoAutcom: Boolean = False);
    function fRetTempo(intSegund: Integer): String;
    function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
    function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
    function StrToCoordinate(ACoordenada: String): TTMSFNCMapsCoordinateRec;
    function RunningInTSPlus : Boolean;
    procedure AbrirMapaGoogle(Romaneio : IRomaneio;
                              lstEntregas, lstDivergencias : TStringlist;
                              fltTotDistancia : Double;
                              intTotTempo : integer;
                              TaEntregue : ITaEntregue);
    procedure AbrirMapaMaplink(Romaneio : IRomaneio;
                               lstEntregas, lstDivergencias : TStringlist;
                               fltTotDistancia : Double;
                               intTotTempo : integer;
                               mapLinkRotaPlanejada,
                               mapLinkRotaEfetuada : TRetornoMaplinkTrip;
                               TaEntregue : ITaEntregue);
    function CheckEdgeBrowser: Boolean;
    function UtilizaModoClassico: Boolean;
    function fMensagem(strTitulo, strTexto: String; arrOpcoes: Array Of String): Integer;
    function GerarArquivoJSON(Romaneio: IRomaneio; ADivergentes: TStringList; ATotalizador: TTotalizaRotas): string;
    function RetCNPJEmpresa(ACodEmp : String) : String;
    function GetAuthorizationMaps: String;
    { Log de erro para as views FMX. O package nao alcanca untFuncoesSimples,
      onde vivem pGravaLogErrArquivoLocal e fRetornaStack, entao o host grava. }
    procedure GravarLogErro(const AstrErro, AstrLocal: String);
  end;

  { Uma linha do quadro de licencas. O host calcula tudo - regra, faixa e ordem -
    e as views (VCL e FMX) apenas desenham. }
  ILicencaProduto = interface
    ['{4E1D6A02-8C3B-4A77-9B21-6F0A5C7E1D34}']
    function Produto: String;
    function Contratadas: Integer;
    function Utilizadas: Integer;
    function DataBase: TDateTime;
    { 0 acima do limite, 1 no limite, 2 dentro do limite, 3 sem limite contratado }
    function Faixa: Integer;
    { utilizadas / contratadas; zero quando nao ha limite contratado }
    function PercentualUso: Double;
  end;

  IQuadroLicencas = interface
    ['{9A7C2B18-05D4-4E6F-8A93-2C1B7D0E5F46}']
    { Falso quando o operador nao e master, a tabela nao existe ou esta vazia }
    function Visivel: Boolean;
    function Itens: TArray<ILicencaProduto>;
    { conta todos os produtos acima do limite }
    function QtdAcimaDoLimite: Integer;
  end;

type
  IPrincipalAutcom = interface
    ['{93DE833C-3417-4525-B3FD-7DEDA42A7A69}']
    function Titulo(): String;
    function NomeUsuario(): String;
    function LoginUsuarioLogado(): String;
    function MenuPrincipal(): IMenuAutcom;
    function MenuWMS(): IMenuAutcom;
    function Favoritos(): IFavoritosAutcom;
    function Recentes(): IRecentesAutcom;
    function CorIdentificacaoEmpresa(): TAlphaColor;
    function Pesquisar(ATexto: String): IResultadoPesquisaAutcom;
    function RetornaTodos(): IResultadoPesquisaAutcom;
    function BancoDeDados(): String;
    function IP(): String;
    function IDConexao(): String;
    function Revisao(): String;
    function Versao(): String;
    function DiretorioExecutavel(): String;
    function VerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
    function PanelTEFIsVisible(): Boolean;
    function RunningInTSPlus(): Boolean;
    function GerarDashboard(): IDashboard;
    function GerarQuadroLicencas(): IQuadroLicencas;
    function GerarFuncoesFiremonkey(): IFuncoes;
    function GoogleAPIKey(): String;
    procedure FormClose(Sender: TObject; var Action: System.UITypes.TCloseAction);
    procedure AbrirCRM(Opcao: Integer);
    procedure GerarPopupFavoritos;
    procedure GerarPopupRecentes;
    procedure MudarMonitor(IndexMonitor: Integer);
    procedure KeyDownVersaoClassica;
    procedure AbrirCitelDesk;
    function HabilitaAtalhoWMS: Boolean;
    function TEFIsEnabled() : Boolean;
    function CodigoEmpresaLogada(): String;
  end;

implementation

end.
