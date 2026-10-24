unit Principal.View.FMXPainelEntregas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, System.StrUtils,
  Shared.Functions.DataSet, System.IOUtils, Math,
  FMX.DateTimeCtrls, Shared.Functions.Core, FMX.Edit, System.Rtti,
  Principal.View.Frame.FMXPainelRotasGridRomaneiosLinha, FMX.ListBox,
  FMX.MultiResBitmap, System.DateUtils, System.ImageList, FMX.ImgList,
  Principal.View.Frame.FMXPainelRotasGridDocumentosLinha, FMX.Maps,
  TaEntregue.Romaneios.Interfaces, System.Generics.Collections, FMX.Calendar,
  FMX.ScrollBox, FMX.Memo, FMX.TabControl, FMX.Ani,
  Principal.View.Frame.FMXPainelRotasConversasRecentes,
  Principal.View.Frame.FMXPainelRotasEnviaMensagem,
  Principal.View.Frame.FMXPainelRotasRecebeMensagem, FMX.Effects,
  Principal.View.Frame.FMXPainelRotasNotificacao,
  Principal.View.Frame.FMXPainelRotasGridPendenciasLinha,
  Principal.View.Interfaces, FMX.TMSFNCCustomComponent, FMX.TMSFNCCloudBase,
  FMX.TMSFNCGeocoding, FMX.TMSFNCMapsCommonTypes, FMX.TMSFNCTypes,
  FMX.TMSFNCUtils, FMX.TMSFNCGraphics, FMX.TMSFNCGraphicsTypes,
  FMX.TMSFNCCustomControl, FMX.TMSFNCWebBrowser,IdHTTP, IdHashMessageDigest,
  IdComponent, System.JSON, System.NetEncoding, untMaplinkTripClasses,
  Principal.Classes.ImagemMemoria, Windows, IdException, IdExceptionCore,
  IdSSLOpenSSL, IdStack;

Type
  TTipoMsg = (tmEnviada, tmRecebida);

Type
  TUltimoFiltro = record
    dtaInicio  : TDatetime;
    dtaFim     : TDatetime;
    strPesquisa: String;
    strExceto  : String;
End;

type
  TfmxPainelEntregas = class(TForm)
    layPrincipal: TLayout;
    recFundoCinza: TRectangle;
    scrBarraRolagem: TVertScrollBox;
    layTopo: TLayout;
    recFundoBranco: TRectangle;
    linRodape: TLine;
    lblTitulo: TLabel;
    recBotaoFiltros: TRectangle;
    lblFiltros: TLabel;
    imgFiltrosOFF: TImage;
    recBotaoRelatorios: TRectangle;
    lblRelatorios: TLabel;
    imgRelatorios: TImage;
    layBody: TLayout;
    layGridEntregas: TLayout;
    imgFiltrosON: TImage;
    StyleBook1: TStyleBook;
    layGridDocumentos: TLayout;
    layGrid: TLayout;
    recBordas: TRectangle;
    lblDataRomaneio: TLabel;
    lblDocsConcluidos: TLabel;
    lblEntregas: TLabel;
    lblRomaneio: TLabel;
    lblFim: TLabel;
    lblInicio: TLabel;
    lblMotorista: TLabel;
    lblRota: TLabel;
    lblStatus: TLabel;
    lstEntregas: TListBox;
    lstiteEntregas1: TListBoxItem;
    layRodape: TLayout;
    recBordasRodape: TRectangle;
    aniAguarde: TAniIndicator;
    lblAguarde: TLabel;
    imglstStatus: TImageList;
    imgVoltar: TImage;
    imgReordenarEntregas: TImage;
    layGridDocs: TLayout;
    recTopoBordasDocs: TRectangle;
    lblDocsItems: TLabel;
    lblDocsDataBaixa: TLabel;
    lblDocsMotorista: TLabel;
    lblDocsDocumentos: TLabel;
    lblDocsDataRomaneio: TLabel;
    lblDocsCliente: TLabel;
    lblDocsFotos: TLabel;
    lblDocsObs: TLabel;
    lstDocumentos: TListBox;
    lstiteDocumentos: TListBoxItem;
    layRodapeDocs: TLayout;
    recBordasRodapeDocs: TRectangle;
    aniAguardeDocs: TAniIndicator;
    Label2: TLabel;
    lblDocsStatus: TLabel;
    lblDocsAssinaturas: TLabel;
    lblDocsRecebedor: TLabel;
    imgDocsFotos: TImage;
    imgDocsAssinaturas: TImage;
    imgDocsObs: TImage;
    Timer: TTimer;
    tabPainelEntregas: TTabControl;
    tabAbaPainel: TTabItem;
    layAbas: TFlowLayout;
    btnAbaPainel: TSpeedButton;
    recBotaoAbaPainel: TRectangle;
    linAbaVendedores: TLine;
    layBotaoAbaPainel: TLayout;
    imgAbaPainel: TImage;
    lblAbaPainel: TLabel;
    btnAbaChat: TSpeedButton;
    recBotaoAbaChat: TRectangle;
    linAbaFiliais: TLine;
    layBotaoAbaChat: TLayout;
    imgAbaChat: TImage;
    lblAbaChat: TLabel;
    tabAbaChat: TTabItem;
    layAbaPainel: TLayout;
    layAbaChat: TLayout;
    recFundoChat: TRectangle;
    recFundoOperador: TRectangle;
    layChatsRecentes: TLayout;
    layChat: TLayout;
    recTopoChat: TRectangle;
    recFundoPesquisaRecentes: TRectangle;
    recFundoMsgChat: TRectangle;
    linVerticalDireita: TLine;
    recEditPesquisa: TRectangle;
    recFundoEditChat: TRectangle;
    cirAvatarOperador: TCircle;
    lblOperador: TLabel;
    lstRecentes: TListBox;
    lstChat: TListBox;
    imgBotaoNovaMsg: TImage;
    cirAvatarChat: TCircle;
    lblChat: TLabel;
    imgPesquisaRecentes: TImage;
    edtPesquisaRecentes: TEdit;
    lblPesquisaRecentes: TLabel;
    edtMsg: TEdit;
    Image1: TImage;
    lblMsg: TLabel;
    recSemMensagem: TRectangle;
    lblTituloMsgDefault: TLabel;
    layMsgDefault: TLayout;
    lblMsgDefault: TLabel;
    btnEnviaMsg: TRectangle;
    lblEnviaMsg: TLabel;
    efeSombra: TShadowEffect;
    Circle1: TCircle;
    TimerChat: TTimer;
    frameNotificacaoChat: TframeNotificacao;
    linPesquisaRecentesCursor: TLine;
    linMsgCursor: TLine;
    imgApagar: TImage;
    btnAbaPendencias: TSpeedButton;
    recBotaoAbaPendencias: TRectangle;
    linAbaPendencias: TLine;
    layBotaoAbaPendencias: TLayout;
    imgAbaPendencias: TImage;
    lblAbaPendencias: TLabel;
    tabAbaPendencias: TTabItem;
    layAbaPendencias: TLayout;
    layPendencias: TLayout;
    layGridPendencias: TLayout;
    recTopoDocumentos: TRectangle;
    lblDocumentos: TLabel;
    lstPendencias: TListBox;
    aniAguardePendencias: TAniIndicator;
    lblAguardePendencias: TLabel;
    layTopoGridPendendicas: TLayout;
    recTopoItensLiberar: TRectangle;
    linItensLiberar: TLine;
    lblItensLiberar: TLabel;
    lblCodigo: TLabel;
    lblProduto: TLabel;
    lblQtdPedido: TLabel;
    lblLiberar: TLabel;
    lblQtdEntregue: TLabel;
    lblQtdFaltante: TLabel;
    lblQtdAvariada: TLabel;
    scrBarraRolagemPendencias: TVertScrollBox;
    layBotoesPendencias: TLayout;
    btnLiberacao: TButton;
    linBotoesPendencias: TLine;
    recBotoesPendencias: TRectangle;
    layAguarde: TLayout;
    TimerRefresh: TTimer;
    recTravaTela: TRectangle;
    layFiltroPendencia: TLayout;
    recFundoFiltro: TRectangle;
    lblFiltroPendencia: TLabel;
    btnPesquisaPendencia: TButton;
    recFundoEditFiltro: TRectangle;
    imgPesquisaPendencia: TImage;
    lblPesquisaPendencia: TLabel;
    edtPesquisaPendencia: TEdit;
    linPesquisaPendenciaCursor: TLine;
    lblVeiculo: TLabel;
    lblDocsCidadeUF: TLabel;
    frameGridRomaneiosLinha1: TframeGridRomaneiosLinha;
    geoLocalizacao: TTMSFNCGeocoding;
    lblDocsPrevisaoEntrega: TLabel;
    btnAbaDashboard: TSpeedButton;
    recBotaoAbaDashboard: TRectangle;
    linAbaDashboard: TLine;
    layBotaoAbaDashboard: TLayout;
    imgAbaDashboard: TImage;
    lblAbaDashboard: TLabel;
    tabAbaDashboard: TTabItem;
    layAbaDashboard: TLayout;
    layFiltrosDashboard: TLayout;
    layCentralizaFiltros: TLayout;
    recFundoFiltrosDashboard: TRectangle;
    lblMotoristaDash: TLabel;
    recEdtCodMotorista: TRectangle;
    edtCodMotorista: TEdit;
    linCodMotoristaCursor: TLine;
    btnFiltrarDashboard: TButton;
    recNomeMotorista: TRectangle;
    lblNomeMotorista: TLabel;
    lblDataInicial: TLabel;
    recDataIniDash: TRectangle;
    imgDataIniDash: TImage;
    edtDataIniDash: TEdit;
    linDataIniDashCursor: TLine;
    imgCalDataIniDash: TImage;
    calDataIniDash: TCalendar;
    lblDataFinal: TLabel;
    recDataFinDash: TRectangle;
    imgDataFinDash: TImage;
    edtDataFinDash: TEdit;
    linDataFinDashCursor: TLine;
    imgCalDataFinDash: TImage;
    calDataFinDash: TCalendar;
    recCarregando: TRectangle;
    recFundoCarregando: TRectangle;
    efeSombraCarregando: TShadowEffect;
    imgLogo: TImage;
    pgbStatus: TProgressBar;
    lblInfo: TLabel;
    recProgressFundo: TRectangle;
    recProgressValue: TRectangle;
    lblPercProgresso: TLabel;
    frameNotificacaoPendencias: TframeNotificacao;
    lblDocsRota: TLabel;
    imgNovaEntrega: TImage;
    lblDocsDistanciaTempo: TLabel;
    layColunasGridRomaneio: TGridPanelLayout;
    layColunasGridDocumentos: TGridPanelLayout;
    layBotoesImagens: TLayout;
    frameGridDocumentosLinha1: TframeGridDocumentosLinha;
    recFundoCinzaAbaPainel: TRectangle;
    recFundoCinzaAbaChat: TRectangle;
    recFundoCinzaAbaDash: TRectangle;
    recFundoCinzaAbaPendencias: TRectangle;
    layFiltros: TFlowLayout;
    recBordasFiltros: TRectangle;
    lblAte: TLabel;
    lblDe: TLabel;
    lblPesquisar: TLabel;
    recDataFim: TRectangle;
    imgDataFim: TImage;
    edtDataFim: TEdit;
    linDataFimCursor: TLine;
    imgCalFim: TImage;
    calFim: TCalendar;
    recDataIni: TRectangle;
    imgDataIni: TImage;
    edtDataIni: TEdit;
    linDataIniCursor: TLine;
    imgCalIni: TImage;
    calInicio: TCalendar;
    recEdtPesquisa: TRectangle;
    imgPesquisa: TImage;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    linPesquisaCursor: TLine;
    recEdtExceto: TRectangle;
    cirExceto: TCircle;
    linExcetoCorte: TLine;
    lblExceto: TLabel;
    edtExceto: TEdit;
    linExcetoCursor: TLine;
    recStatus: TRectangle;
    cbxRomaneiosCancelados: TCheckBox;
    recTotais: TRectangle;
    lblTotalRomaneios: TLabel;
    lblTotalEntregas: TLabel;
    lblTotalConcluidos: TLabel;
    recProgressBordaDocsConcluidos: TRectangle;
    recPorcentagemDocsConcluidos: TRectangle;
    lblPorcentagemDocsConcluidos: TLabel;
    lblValorDocsConcluidos: TLabel;
    lblValorTotalEntregas: TLabel;
    lblValorTotalRomaneios: TLabel;
    recLegenda: TRectangle;
    lblLegenda: TLabel;
    recLegendaPausada: TRectangle;
    lblLegendaPausada: TLabel;
    recLegendaNaoConformidade: TRectangle;
    lblLegendaNaoConformidade: TLabel;
    imgFinalizadaON: TImage;
    imgTemPendenciaON: TImage;
    imgTemPendenciaOFF: TImage;
    imgNaoIniciadaON: TImage;
    imgNaoIniciadaOFF: TImage;
    imgFinalizadaOFF: TImage;
    imgEmAndamentoON: TImage;
    imgEmAndamentoOFF: TImage;
    cbxTemPendencia: TCheckBox;
    cbxNaoIniciada: TCheckBox;
    cbxFinalizada: TCheckBox;
    cbxEmAndamento: TCheckBox;
    tmrHabilitarBotoes: TTimer;
    btnFiltrar: TButton;
    procedure recBotaoFiltrosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure imgReordenarEntregasClick(Sender: TObject);
    procedure fraGridDocumentosLinhaimgDocsAssinaturasClick(Sender: TObject);
    procedure edtPesquisaExit(Sender: TObject);
    procedure edtPesquisaEnter(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edtDataIniKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtDataFimKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtDataIniEnter(Sender: TObject);
    procedure edtDataIniValidate(Sender: TObject; var Text: string);
    procedure edtPesquisaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtExcetoChangeTracking(Sender: TObject);
    procedure edtExcetoClick(Sender: TObject);
    procedure edtExcetoEnter(Sender: TObject);
    procedure edtExcetoExit(Sender: TObject);
    procedure edtExcetoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtExcetoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure imgCalFimClick(Sender: TObject);
    procedure calFimDateSelected(Sender: TObject);
    procedure calInicioDateSelected(Sender: TObject);
    procedure imgCalIniClick(Sender: TObject);
    procedure fraGridRomaneiosLinhaimgRotaClick(Sender: TObject);
    procedure edtDataIniKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtPesquisaChangeTracking(Sender: TObject);
    procedure cbxFinalizadaChange(Sender: TObject);
    procedure cbxFinalizadaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure cbxEmAndamentoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure cbxNaoIniciadaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure cbxFinalizadaEnter(Sender: TObject);
    procedure cbxFinalizadaExit(Sender: TObject);
    procedure fraGridRomaneiosLinhaimgDocumentosClick(Sender: TObject);
    procedure fraGridDocumentosLinhaimgDocsImprimirClick(Sender: TObject);
    procedure imgDocsFotosClick(Sender: TObject);
    procedure edtPesquisaClick(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure TimerTimer(Sender: TObject);
    procedure edtDataIniChangeTracking(Sender: TObject);
    procedure edtDataIniClick(Sender: TObject);
    procedure edtDataIniExit(Sender: TObject);
    procedure btnAbaChatClick(Sender: TObject);
    procedure btnAbaPainelClick(Sender: TObject);
    procedure edtMsgEnter(Sender: TObject);
    procedure edtMsgExit(Sender: TObject);
    procedure edtMsgChange(Sender: TObject);
    procedure btnEnviaMsgClick(Sender: TObject);
    procedure TimerChatTimer(Sender: TObject);
    procedure edtPesquisaRecentesChangeTracking(Sender: TObject);
    procedure edtPesquisaRecentesClick(Sender: TObject);
    procedure edtPesquisaRecentesEnter(Sender: TObject);
    procedure edtPesquisaRecentesExit(Sender: TObject);
    procedure edtMsgChangeTracking(Sender: TObject);
    procedure edtMsgClick(Sender: TObject);
    procedure imgApagarMouseEnter(Sender: TObject);
    procedure imgApagarMouseLeave(Sender: TObject);
    procedure imgApagarClick(Sender: TObject);
    procedure fraGridRomaneiosLinhaimgChatClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure edtPesquisaRecentesChange(Sender: TObject);
    procedure lstRecentesKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure fraGridRomaneiosLinhaimgOcorrenciaClick(Sender: TObject);
    procedure fraGridRomaneiosLinhaimgResolvidoClick(Sender: TObject);
    procedure btnAbaPendenciasClick(Sender: TObject);
    procedure btnLiberacaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure actEscExecute(Sender: TObject);
    procedure TimerRefreshTimer(Sender: TObject);
    procedure edtPesquisaPendenciaChangeTracking(Sender: TObject);
    procedure edtPesquisaPendenciaEnter(Sender: TObject);
    procedure edtPesquisaPendenciaExit(Sender: TObject);
    procedure btnPesquisaPendenciaClick(Sender: TObject);
    procedure edtPesquisaPendenciaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnAbaDashboardClick(Sender: TObject);
    procedure imgCalDataIniDashClick(Sender: TObject);
    procedure imgCalDataFinDashClick(Sender: TObject);
    procedure calDataFinDashDateSelected(Sender: TObject);
    procedure calDataIniDashDateSelected(Sender: TObject);
    procedure edtDataIniDashKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtDataFinDashKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtCodMotoristaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtCodMotoristaChange(Sender: TObject);
    procedure edtCodMotoristaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtCodMotoristaExit(Sender: TObject);
    procedure btnFiltrarDashboardClick(Sender: TObject);
    procedure fraGridDocumentosLinhaimgDocsCadCliClick(Sender: TObject);
    procedure imgNovaEntregaClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbxRomaneiosCanceladosKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure cbxTemPendenciaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure tmrHabilitarBotoesTimer(Sender: TObject);
  private
    FNumeroRomaneioDocumentos: String;
    { Private declarations }
    webDash: TTMSFNCWebBrowser;

    FTaEntregue  : ITaEntregue;
    FTaEntregueRefresh : ITaEntregue;
    Chat         : IChat;
    ContatoAberto: IContato;
    Pendencias   : IPendencia;

    lstRomaneios,
    lstTemp,
    lstCancelados: TList<IRomaneio>;
    lstDocs      : TList<IDocumento>;
    imgExpandida : TImage;
    intCancelados: Integer;

    recUltimoFiltro: TUltimoFiltro;

    FProcessandoMudancaAba: Boolean;

    procedure AnimarAguarde(LayoutGrid: TLayout; Ligar: Boolean = True; ProccessMessages:Boolean = true);
    procedure AbrirTelaDocumentos(NumeroRomaneio: String; ListIndex: Integer);
    procedure FecharTelaDocumentos;
    procedure AtualizaDocumentos(ListIndex: Integer);
    procedure ExpandeLinha(Sender: TObject; AlterarTag: Boolean = true);
    procedure ExpandeTodasLinhas(Sender: TObject);
    procedure TrocarLayouts(Sender: TObject);
    procedure TrocarLayoutLinha(Sender: TObject; ListItem : TListBoxItem);
    procedure EsconderLayouts(LFrame: TframeGridDocumentosLinha);
//    procedure ComprimeLinhas;
    procedure CarregaImagem(Imagem: TImage; Nome: String);
    procedure CarregaImagemRota(Imagem: TImage; TemRotas: Boolean; IndexRomaneio: Integer);
    procedure CarregaImagemDocumentos(Imagem: TImage; IndexRomaneio: Integer);
    procedure CarregaImagemChat(Imagem: TImage; IndexRomaneio: Integer);
    procedure CarregaImagemOcorrencia(Imagem: TImage; IndexRomaneio: Integer; TemOcorrencia: Boolean);
    procedure CarregaImagemResolver(Imagem: TImage; IndexRomaneio: Integer; TemOcorrencia: Boolean);
    procedure CalculaAlturaBarraRolagem;
    procedure AjustaGridDocumentos(AlterarTag : Boolean);

    procedure CarregaBotaoFotos(Documento: IDocumento; Frame: TframeGridDocumentosLinha; Indice: Integer);
    procedure CarregaBotaoAssinaturas(Documento: IDocumento; Frame: TframeGridDocumentosLinha; Indice: Integer);
    procedure CarregaBotaoObservacoes(Documento: IDocumento; Frame: TframeGridDocumentosLinha; Indice: Integer);
    procedure AbrirQuadro(Imagem: TImage; Frame: TframeGridDocumentosLinha);
    procedure ValidaDataPreenchida(Sender: TObject);
    procedure ValidaFormatoData(Sender: TObject);
    function RetornaComprimentoQuadro(QuantidadeImagens: Integer; Frame: TframeGridDocumentosLinha): Single;

    function FormataDataHora(Data: TDatetime; SoData: Boolean = false): String;
    function RetornaStatus(Status: IStatus): String;

    function Mascara(edt: String;str:String):string;

    procedure EscondeCursor(Sender: TObject);
    procedure MoveCursor(Sender: TObject; Key: Word);
    procedure PiscaCursor(Sender: TObject);
    function RetornaCursorDoEditFocado: TLine;

    procedure CleanListBox(Sender: TListBox);

    procedure HabilitarAbaNova(Tab: TTabItem);
    procedure DesabilitarAbaAtual;

    function EntregaEmNaoConformidade(Romaneio: IRomaneio): Boolean;
    function EntregaPausada(Romaneio: IRomaneio): Boolean;

    procedure MensagemInstalacaoWebView;

    procedure AtualizaEntregas;

    Function RetornaSituacaoRomaneio(Romaneio: IRomaneio): Integer;

    function PaineldeEntregasEstaVisivel: Boolean;
    procedure HabilitarRefreshAuto(Ligar: Boolean);

    procedure AtualizaListaEntregas;

    Function StatusToStr(Status: IStatus): String;

    function fPermitidoLiberarItem(var intOpcao: Integer): Boolean;

    function ListaEnderecosGeolocalizados(Romaneio: IRomaneio;
      Var TotDistancia: Double; Var TotTempo: Integer): TStringlist;

    function ListaEntregasDivergentes(Romaneio: IRomaneio): TStringlist;

    procedure CarregarListaDocumentos(Romaneio: IRomaneio);
    procedure CarregarDadosRotas(Romaneio: IRomaneio);
    procedure CarregarListaOcorrencias(Romaneio: IRomaneio);

    procedure preencheTotais(intRomaneios, intEntregas, intConcluidos, intNaoIniciado,
      intACaminho, intFinalizados, intPendencia: Integer);

    procedure pStepStatusGravacao(pgbStatus: TProgressBar; strInformacao: String='');

    procedure AbrirMapaGoogle(Romaneio : IRomaneio;
                              lstEntregas,
                              lstDivergencias : TStringlist;
                              fltTotDistancia : Double;
                              intTotTempo     : integer);

    procedure AbrirMapaMaplink(Romaneio : IRomaneio;
                               lstEntregas,
                               lstDivergencias     : TStringlist;
                               fltTotDistancia     : Double;
                               intTotTempo         : integer;
                               mapLinkRotaPlanejada,
                               mapLinkRotaEfetuada : TRetornoMaplinkTrip);

    procedure habilitarCursores;

    procedure HabilitarBotoes(AHabilitar: Boolean);
    procedure MudarAbaSegura(Acao: TProc);

    {********}
    {* CHAT *}
    {********}
    procedure AddMensagemChat(Msg: String; tipoMensagem: TTipoMsg; dataHoraMsg: TDateTime);
    procedure AddMensagemEmBranco;
    procedure AddContatoRecente(Contato: IContato; Index: Integer);
    procedure AddGrupoPorDataChat(Dia: TDateTime);

    procedure AtualizaRecentes;

    procedure CarregaChat;
    procedure CarregaMensagens;

    function AjustaNome(Nome: String): String;
    function GetTextSize(lblMsg : TLabel): Single;

    procedure SelecionaRecente(Sender: TObject);
    procedure TelaDefault(Mostrar: boolean);

    function RetornaPeriodoUltimaMensagem(DataEnvio: TDatetime): String;
    function RetornaDiaDaSemana(Dia: TDatetime): String;
    function ExisteChatComEsseContato(Contato: IContato): Boolean;

    procedure NovoChat(Contato: IContato);

    {**************}
    {* PENDÊNCIAS *}
    {**************}

    procedure CarregaPendencias(strFiltro: String = '');
    procedure LimparPendenciasAnteriores;
    procedure ConfigurarDadosDocumento(Frame: TframePendencias; Documento: IDocumento);
    procedure ProcessarOcorrencias(Frame: TframePendencias; Documento: IDocumento);
    function CalcularAlturaItem(Documento: IDocumento): Single;
    procedure AjustarAlturasLayouts(TotalHeight: Single);
    function TemItensSelecionadosParaLiberacao: Boolean;
    function fDocumentoComItemMarcadoParaLiberacao(Documento: IDocumento): Boolean;
    procedure AtualizaQtdePendencias;

{    function GetIdleTime:DWORD;
    function AplicacaoOciosaPor60Seg: Boolean; }

    {*************}
    {* DASHBOARD *}
    {*************}
    function GetUTC(dt: TDateTime): TDateTime;
    function RetornaTimeStampEmMilisegundos: Int64;
    function RetornaChaveBasic(AClientID, AClientSecret: String): String;
    function GetMD5(const strTexto: string): string;
    function GetAuthorization: string;
    function GetJsonValue(AJson, APath: String): string;

    procedure GerarDashboardWeb(strJSONRel : String);
    procedure OnWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);

    procedure WebBrowserNavigate(url: String);
    procedure WebBrowserLoading;
    procedure ConsultaMotorista;
    procedure AtualizaGraficos;

    {*************}
    {* API MAPAS *}
    {*************}
    function GetURLRotas(JSONRoutes, NumeroRomaneio, CNPJEmpresa: String): string;

    procedure pVerificaRotaRecalculada(Romaneio: IRomaneio);

    function IndiceRomaneioDocumentos: Integer;
  public
    { Public declarations }
    objFuncoes: IFuncoes;

    strGoogleAPIKey,
    strLoginUsuarioLogado,
    strNomeUsuarioLogado,
    strEmpLogada,
    strNumRom : String;
    objDash: IDashboard;

    intQtdNovasMensagens: Integer;

    FGerenciadorImagens: TGerenciadorImagens;

    procedure MostrarFiltros;
    procedure AtualizaRomaneios(DataInicio,
                                DataFim: TDatetime;
                                Pesquisa: String = '';
                                Exceto: String = '');
    procedure NotificaNovasMensagens(PeloTimer: Boolean = False);
    procedure HabilitaDashboard;
  published
    property TaEntregue: ITaEntregue Read FTaEntregue write FTaEntregue;
    property TaEntregueRefresh: ITaEntregue Read FTaEntregueRefresh  write FTaEntregueRefresh;
  end;

const
  azulCitel = TAlphaColor($FF00AAE4);
  ChaveAutorizacaoCitel = 'uLtr@-F!n&320147';
  URLDashboard = 'https://dashboard.citelsoftware.com.br';

var
  fmxPainelEntregas: TfmxPainelEntregas;

implementation

{$R *.fmx}

uses Principal.View.FMXConsultaContatos,
  Principal.View.FMXConsultaOcorrencias,
  Principal.View.FMXMensagemInstalacaoWebView,
  Principal.View.FMXConsultaMotoristas,
  Principal.View.FMXReordenarEntregas;

procedure TfmxPainelEntregas.AbrirMapaGoogle(Romaneio: IRomaneio; lstEntregas,
  lstDivergencias: TStringlist; fltTotDistancia: Double; intTotTempo: integer);
begin
  objFuncoes.AbrirMapaGoogle(Romaneio,
                             lstEntregas,
                             lstDivergencias,
                             fltTotDistancia,
                             intTotTempo,
                             TaEntregue);
end;

procedure TfmxPainelEntregas.AbrirMapaMaplink(Romaneio: IRomaneio;
                                              lstEntregas,
                                              lstDivergencias     : TStringlist;
                                              fltTotDistancia     : Double;
                                              intTotTempo         : integer;
                                              mapLinkRotaPlanejada,
                                              mapLinkRotaEfetuada : TRetornoMaplinkTrip);
begin
  objFuncoes.AbrirMapaMaplink(Romaneio,
                              lstEntregas,
                              lstDivergencias,
                              fltTotDistancia,
                              intTotTempo,
                              mapLinkRotaPlanejada,
                              mapLinkRotaEfetuada,
                              TaEntregue);
end;

procedure TfmxPainelEntregas.AbrirQuadro(Imagem: TImage;
  Frame: TframeGridDocumentosLinha);
begin
  if (Imagem = Frame.imgDocsFotos) Then
  Begin
    Frame.layDocsFotos.Width    := RetornaComprimentoQuadro(Frame.layDocsFotos.Tag, Frame);
    Frame.layDocsFotos.Visible  := True;
    Frame.layDocsFotos.Opacity  := 1;
    Frame.scrHorizontal.Visible := True;
    Frame.scrHorizontal.Width   := Frame.layBody.Width;
  End
  Else if (Imagem = Frame.imgDocsAssinaturas) Then
  Begin
    Frame.layDocsAssinaturas.Width   := RetornaComprimentoQuadro(Frame.layDocsAssinaturas.Tag, Frame);
    Frame.layDocsAssinaturas.Visible := True;
    Frame.layDocsAssinaturas.Opacity := 1;
    Frame.scrHorizontal.Visible      := True;
    Frame.scrHorizontal.Width        := Frame.layBody.Width;
  End
  Else if (Imagem = Frame.imgDocsObs) Then
  Begin
    Frame.scrHorizontal.Visible      := False;
    Frame.layDocsObservacoes.Visible := True;
    Frame.layDocsObservacoes.Opacity := 1;

    Frame.grdOcorrencias.SelectRow(0);
    Frame.grdOcorrencias.SetFocus;
    Frame.grdOcorrencias.Repaint;
  End;
end;

procedure TfmxPainelEntregas.AbrirTelaDocumentos(NumeroRomaneio: String; ListIndex: Integer);
begin
  FNumeroRomaneioDocumentos := NumeroRomaneio;
  lblTitulo.Text := 'Documentos do Romaneio (' + NumeroRomaneio + ')';

  recBotaoFiltros.Visible := false;
  layFiltros.Visible      := false;
  layGridEntregas.Visible := false;

  layGridDocumentos.Visible := true;
  layColunasGridDocumentos.Visible := true;
  imgVoltar.Visible         := true;
  imgReordenarEntregas.Visible         := true;

  AtualizaDocumentos(ListIndex);
end;

procedure TfmxPainelEntregas.actEscExecute(Sender: TObject);
begin
  If (imgVoltar.Visible) Then
    imgVoltarClick(imgvoltar)
  else
    Self.Close;
end;

procedure TfmxPainelEntregas.AjustaGridDocumentos(AlterarTag : Boolean);
var
  LItem : TListBoxItem;
  heigthItens : Double;
  x : integer;
begin
  heigthItens := 0;

  For x := 1 to lstDocumentos.Count do
  Begin
    LItem := lstDocumentos.ItemByIndex(x-1);
    heigthItens := heigthItens + LItem.Height;
  End;

  layGridDocs.Height       := 45 + heigthItens;
  layGridDocumentos.Height := layGridDocs.Height + 2;

  If (AlterarTag) Then
  begin
    if ((heigthItens / lstDocumentos.Count) = 40) Then
    begin
      imgDocsFotos.Tag       := 0;
      imgDocsAssinaturas.Tag := 0;
      imgDocsObs.Tag         := 0;

      imgExpandida := Nil;
    end
    Else if ((heigthItens / lstDocumentos.Count) = 140) Then
    begin
      imgDocsFotos.Tag       := 1;
      imgDocsAssinaturas.Tag := 1;
      imgDocsObs.Tag         := 1;
    end;
  End;

  CalculaAlturaBarraRolagem;
end;

function TfmxPainelEntregas.AjustaNome(Nome: String): String;
Const
  ComAcentoMaiusculo = 'ÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  ComAcentoMinusculo = 'àâêôûãõáéíóúçü';
var
   i : integer;
begin
  if Nome = '' then
    Result := ''
  Else
  begin
    Result := Uppercase(Nome[1]);
    for i := 2 to Length(Nome) do
      if Nome[i - 1] = ' ' then
        Result := Result + Uppercase(Nome[i])
      else
        Result := Result + Lowercase(Nome[i]);

    For i := 1 to Length(Result) do
      If Pos(Result[i],ComAcentoMaiusculo)<> 0 Then
        Result[i] := ComAcentoMinusculo[Pos(Result[i],ComAcentoMaiusculo)];
  end;
end;

{function TfmxPainelEntregas.GetIdleTime: DWORD;
var
  lastI : TLastInputInfo;
begin
  lastI.cbSize := SizeOf(lastI);
  GetLastInputInfo(lastI);
  Result := (gettickcount - lastI.dwTime) div 1000;
end;}

procedure TfmxPainelEntregas.GerarDashboardWeb(strJSONRel: String);
var
  LRequisicao: TIdHTTP;
  LParametros: TStringStream;
  LRespostaRequisicao: string;
  LURL: string;
begin
  LRequisicao := TIdHTTP.Create(nil);
  LParametros := nil;

  try
    LURL := URLDashboard + '/api/dashboard';

    LRequisicao.ConnectTimeout      := 15000; // 15 segundos para conectar
    LRequisicao.ReadTimeout         := 30000; // 30 segundos para aguardar resposta
    LRequisicao.Request.Connection  := 'close';
    LRequisicao.Request.ContentType := 'application/json';
    LRequisicao.OnWork              := OnWork;
    LRequisicao.Request.UserAgent   := 'Mozilla/5.0';
    LRequisicao.HandleRedirects     := True;

    LRequisicao.Request.CustomHeaders.Clear;
    LRequisicao.Request.CustomHeaders.AddValue('Authorization', GetAuthorization);

    LParametros := TStringStream.Create(Trim(strJSONRel), TEncoding.UTF8);

    try
      LRespostaRequisicao := LRequisicao.Post(LURL, LParametros);
    except
      on E: EIdConnectTimeout do
        raise Exception.Create(
          'Não foi possível conectar ao servidor do dashboard dentro do tempo limite.' + sLineBreak +
          'Verifique internet, firewall, DNS ou se o servidor está online.' + sLineBreak + sLineBreak +
          'URL: ' + LURL);

      on E: EIdReadTimeout do
        raise Exception.Create(
          'O servidor do dashboard demorou muito para responder.' + sLineBreak +
          'Tente novamente em alguns instantes.' + sLineBreak + sLineBreak +
          'URL: ' + LURL);

      on E: EIdSocketError do
        raise Exception.Create(
          'Erro de conexão com o servidor do dashboard.' + sLineBreak +
          E.Message + sLineBreak + sLineBreak +
          'URL: ' + LURL);

      on E: EIdHTTPProtocolException do
        raise Exception.Create(
          'O servidor do dashboard retornou erro HTTP ' + IntToStr(E.ErrorCode) + '.' + sLineBreak +
          E.ErrorMessage);

      on E: Exception do
        raise;
    end;

    if LRequisicao.Response.ResponseCode <> 200 then
      raise Exception.Create(LRequisicao.Response.ResponseCode.ToString + ' - ' + LRespostaRequisicao);

    WebBrowserNavigate(URLDashboard + GetJsonValue(LRespostaRequisicao, 'location'));

  finally
    FreeAndNil(LParametros);
    FreeAndNil(LRequisicao);
  end;
end;

function TfmxPainelEntregas.GetAuthorization: string;
var
  LTimeStampRequisicao: string;
begin
  LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;
  Result := RetornaChaveBasic(LTimeStampRequisicao, GetMD5(LTimeStampRequisicao + ChaveAutorizacaoCitel));
end;

function TfmxPainelEntregas.GetJsonValue(AJson, APath: String): string;
var
  LObj: TJSONValue;
begin
  LObj := TJSONObject.ParseJSONValue(AJson);
  if not Assigned(LObj) then
    raise Exception.Create('Resposta do servidor não é um JSON válido. Caminho esperado: "' + APath + '"');
  try
    Result := LObj.GetValue<string>(APath);
  finally
    FreeAndNil(LObj);  // libera em todos os caminhos (sucesso e exce?)
  end;
end;

function TfmxPainelEntregas.GetMD5(const strTexto: string): string;
  var
    idHash128: TIdHashMessageDigest5;
begin
  Try
    idHash128 := TIdHashMessageDigest5.Create;

    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    FreeAndNil(idHash128);
  End;
end;

function TfmxPainelEntregas.GetTextSize(lblMsg: TLabel): Single;
Var
  Bmp : FMX.Graphics.TBitmap;
  Wdt : Single;
begin
  Bmp := FMX.Graphics.TBitmap.Create;
  Bmp.Canvas.Font.Assign(lblMsg.TextSettings.Font);
  Wdt := Bmp.Canvas.TextWidth(lblMsg.Text);

  Result := Wdt;
end;

function TfmxPainelEntregas.GetURLRotas(JSONRoutes, NumeroRomaneio, CNPJEmpresa: String): string;
var
  LRequisicao: TidHTTP;
  LParametros: TStringStream;
  LRespostaRequisicao: string;
  URLMaps : String;
begin
  Result := '';

  URLMaps := objFuncoes.fCfgSis('URLMAP', varString);

  If URLMaps.IsEmpty Then
    URLMaps := 'http://maps2.citelsoftware.com.br:8080';

  LRequisicao                     := TIdHTTP.Create(Nil);
  LRequisicao.Request.Connection  := 'keep-alive';
  LRequisicao.Request.ContentType := 'application/json';
  LRequisicao.Response.KeepAlive  := True;
  LRequisicao.HTTPOptions         := [];
  LRequisicao.OnWork              := OnWork;
  LRequisicao.Request.UserAgent   := 'Mozilla/5.0';
  LRequisicao.HandleRedirects     := True;

  LRequisicao.Request.CustomHeaders.AddValue('Authorization', objFuncoes.GetAuthorizationMaps);
  LRequisicao.Request.CustomHeaders.AddValue('Content-Type', 'application/json');

  LParametros := nil;
  try
    LParametros := TStringStream.Create(Trim(JSONRoutes), TEncoding.UTF8);

    try
      LRespostaRequisicao := LRequisicao.Post(URLMaps + '/romaneio', LParametros);
    except
      on E: EIdConnectTimeout do
        raise Exception.Create('Tempo limite de conexão excedido.' + sLineBreak +
                               'URL: ' + URLMaps + '/romaneio');
      on E: EIdReadTimeout do
        raise Exception.Create('Tempo limite de resposta excedido.' + sLineBreak +
                               'URL: ' + URLMaps + '/romaneio');
      on E: EIdSocketError do
        raise Exception.Create('Erro de socket: ' + E.Message + sLineBreak +
                               'URL: ' + URLMaps + '/romaneio');
      on E: Exception do
        raise;
    end;

    if LRequisicao.Response.ResponseCode <> 200 then
      raise Exception.Create(LRequisicao.Response.ResponseCode.ToString + ' - ' + LRespostaRequisicao);

    Result := URLMaps + '/?romaneio=' + NumeroRomaneio + '&cnpj=' + CNPJEmpresa;
  finally
    FreeAndNil(LParametros);
    FreeAndNil(LRequisicao);
  end;
end;

function TfmxPainelEntregas.GetUTC(dt: TDateTime): TDateTime;
begin
  Result := TTimeZone.Local.ToUniversalTime(dt);
end;

procedure TfmxPainelEntregas.AnimarAguarde(LayoutGrid: TLayout; Ligar,
  ProccessMessages: Boolean);
begin
  LayoutGrid.Visible := Not Ligar;

  If ProccessMessages Then
  Begin
    aniAguarde.Visible     := Ligar;
    aniAguarde.Enabled     := Ligar;
    aniAguardeDocs.Visible := Ligar;
    aniAguardeDocs.Enabled := Ligar;
    aniAguardePendencias.Visible := Ligar;
    aniAguardePendencias.Enabled := Ligar;
    Application.ProcessMessages;
  End;

end;

{function TfmxPainelEntregas.AplicacaoOciosaPor60Seg: Boolean;
begin
  Result := False;

  If Assigned(TaEntregueRefresh) Then
    If GetIdleTime >= 60 Then
      Result := True;
end;}

procedure TfmxPainelEntregas.AtualizaDocumentos(ListIndex: Integer);
Var
  LItem      : TListBoxItem;
  LFrame     : TframeGridDocumentosLinha;
  LCount     : Integer;
  Romaneio   : IRomaneio;
  Documento  : IDocumento;
begin

  Try
    AnimarAguarde(layGridDocs);

    layGridDocumentos.Tag := ListIndex;

    Romaneio := lstRomaneios.Items[ListIndex];

    lstDocs  := Romaneio.Documentos;

    lstDocumentos.BeginUpdate;
    lstDocumentos.Items.Clear;

    If (Romaneio.Documentos.Count > 0) Then
    Begin
      layGridDocs.Height       := 40 + (Romaneio.Documentos.Count * 40) + 5;
      layGridDocumentos.Height := layGridDocs.Height + 2;

      For Documento in lstDocs do
      Begin
        Inc(LCount);
        Application.ProcessMessages;

        If (Documento.Fotos.Count <= 0) Then
        Begin
          Documento.CarregaImagens;
          Documento.CarregaOcorrencias;
        End;

        LItem            := TListBoxItem.Create(Self);
        LItem.Selectable := False;
        LFrame           := TframeGridDocumentosLinha.Create(Self);
        LFrame.Name      := 'FrameDocs' + LCount.ToString();

        LFrame.Parent := LItem;
        LFrame.Align  := TAlignLayout.Contents;
        LItem.Height  := 40;

        LFrame.lblDocsValorRota.Text            := Documento.RotaOrdem;
        LFrame.lblDocsValorDocumento.Text       := Documento.NumeroDocumento + '-' +
                                                   Documento.EspecieDocumento + '-' +
                                                   Documento.Empresa.CodigoEmpresa;
        LFrame.lblDocsValorCliente.Text         := Documento.Cliente.NomeCliente;

        LFrame.imgDocsCadCli.Tag                := LCount - 1;
        LFrame.imgDocsCadCli.OnClick            := fraGridDocumentosLinhaimgDocsCadCliClick;

        If Self.Width <= 1370 Then
        begin
          LFrame.layColunasGridDocumentos.ColumnCollection[3].Value := 0;
          LFrame.layColunasGridDocumentos.ColumnCollection[4].Value := 0;
        end
        Else
        begin
          LFrame.layColunasGridDocumentos.ColumnCollection[3].Value := 130;
          LFrame.layColunasGridDocumentos.ColumnCollection[4].Value := 90;
        end;


        LFrame.lblDocsValorCidadeUF.Text        := Documento.EnderecoEntrega.Cidade +' - '+
                                                   Documento.EnderecoEntrega.Uf;
        LFrame.lblDocsValorDistancia.Text       := '';
        LFrame.lblDocsValorTempo.Text           := '';

        If (Documento.PercursoKm > 0) Then
        Begin
          LFrame.lblDocsValorDistancia.Text       := FormatFloat('#,##0.00', Documento.PercursoKm) + ' km';
          LFrame.lblDocsValorTempo.Text           := objFuncoes.fRetTempo(Documento.TempoPercurso);
        End;

        LFrame.lblDocsValorRecebedor.Text       := Documento.NomeRecebedor;
        LFrame.lblDocsValorMotorista.Text       := Documento.Motorista.NomeMotorista;
        LFrame.lblDocsValorItens.Text           := IntToStr(Documento.QuantidadeItens);
        LFrame.lblDocsValorDataRomaneio.Text    := FormataDataHora(Documento.DataHoraInicioEntrega);
        LFrame.lblDocsValorDataBaixa.Text       := FormataDataHora(Documento.DataHoraBaixaEntrega);
        LFrame.lblDocsValorPrevisaoEntrega.Text := FormataDataHora(Documento.DataHoraEntregaPrevista, True);

        LFrame.imgDocsImprimir.Tag := LCount - 1;
        LFrame.imgDocsImprimir.OnClick := fraGridDocumentosLinhaimgDocsImprimirClick;

        CarregaImagem(LFrame.imgDocsStatus, RetornaStatus(Documento.StatusDocumento));

        CarregaBotaoFotos(Documento, LFrame, LCount - 1);
        CarregaBotaoAssinaturas(Documento, LFrame, LCount - 1);
        CarregaBotaoObservacoes(Documento, LFrame, LCount - 1);

        LFrame.layDocsFotos.Visible       := False;
        LFrame.layDocsAssinaturas.Visible := False;
        LFrame.scrHorizontal.Visible      := False;
        LFrame.layDocsObservacoes.Visible := False;

        LFrame.imgDocsFotos.OnClick       := fraGridDocumentosLinhaimgDocsAssinaturasClick;
        LFrame.imgDocsObs.OnClick         := fraGridDocumentosLinhaimgDocsAssinaturasClick;
        LFrame.imgDocsAssinaturas.OnClick := fraGridDocumentosLinhaimgDocsAssinaturasClick;

        LItem.Parent := lstDocumentos;
      End;

      layRodapeDocs.Visible := True;
    End
    Else
      layRodapeDocs.Visible := false;

  Finally
    lstDocumentos.EndUpdate;
  End;

  CalculaAlturaBarraRolagem;

  AnimarAguarde(layGridDocs, false);
end;

procedure TfmxPainelEntregas.AtualizaEntregas;
Var
  lstRefresh       : TList<IRomaneio>;
  RomRefresh       : IRomaneio;
  LCount           : Integer;
  blnAtualizar     : Boolean;
  LItem            : TListBoxItem;
  SituacaoRomaneio : Integer;
  lstEntregasRef   : TListBox;
begin
  blnAtualizar := False;
  LCount := 0;

  If (PaineldeEntregasEstaVisivel) Then
  Begin
    Try
      lstRefresh := TaEntregueRefresh.fGetRomaneios(recUltimoFiltro.strPesquisa,
                                                    recUltimoFiltro.strExceto,
                                                    recUltimoFiltro.dtaInicio,
                                                    recUltimoFiltro.dtaFim);

      lstEntregasRef := lstEntregas;

      If (lstRefresh.Count <> lstEntregasRef.Items.Count) Then
      Begin
        AtualizaRomaneios(recUltimoFiltro.dtaInicio,
                          recUltimoFiltro.dtaFim,
                          recUltimoFiltro.strPesquisa,
                          recUltimoFiltro.strExceto);
        Exit;
      End
      Else
      Begin
        For RomRefresh in lstRefresh do
        begin
          LItem  := lstEntregasRef.ItemByIndex(LCount);

          SituacaoRomaneio := RetornaSituacaoRomaneio(RomRefresh);

          Case SituacaoRomaneio Of
            {* Entrega Ativo *}
            0: blnAtualizar := LItem.TagString <> RetornaStatus(RomRefresh.StatusRomaneio);

            {* Entrega Em Nao Conformidade *}
            1: blnAtualizar := LItem.TagString <> 'NAO CONFORMIDADE';

            {* Entrega Pausada *}
            2: blnAtualizar := LItem.TagString <> 'PAUSADA'
          End;

          If (blnAtualizar) Then
          Begin
            AtualizaRomaneios(recUltimoFiltro.dtaInicio,
                              recUltimoFiltro.dtaFim,
                              recUltimoFiltro.strPesquisa,
                              recUltimoFiltro.strExceto);
            Break;
          End;

          Inc(LCount);
        End;
      End;

    Finally

    End;
  End;
end;

procedure TfmxPainelEntregas.AtualizaGraficos;
Var
  LJSONRel,
  LCodMot : String;
begin
  recTravaTela.Visible := True;

  WebBrowserLoading;

  Application.ProcessMessages;

  If (edtCodMotorista.Text = '') And (edtCodMotorista.TextPrompt = '...') Then
    LCodMot := '(IN)' + edtCodMotorista.TagString
  Else
    LCodMot := edtCodMotorista.Text;

  LJSONRel := objDash.RetornaJsonEditorDashBoard(422, 520726,
                                                ['DTAINI', 'DTAFIN', 'CODEMP', 'CODMOT'],
                                                [edtDataIniDash.Text, edtDataFinDash.Text, strEmpLogada, LCodMot],
                                                False);

  GerarDashboardWeb(LJSONRel);

  recTravaTela.Visible := False;
  edtDataIniDash.SetFocus;
end;

procedure TfmxPainelEntregas.AtualizaListaEntregas;
Var
  Romaneio : IRomaneio;
begin
  if Assigned(lstRomaneios) then
    FreeAndNil(lstRomaneios);

  if Assigned(lstCancelados) then
    FreeAndNil(lstCancelados);

  lstRomaneios  := TList<IRomaneio>.Create;
  lstCancelados := TList<IRomaneio>.Create;

  lstTemp       := TaEntregue.fGetRomaneios(recUltimoFiltro.strPesquisa,
                                            recUltimoFiltro.strExceto,
                                            recUltimoFiltro.dtaInicio,
                                            recUltimoFiltro.dtaFim);

  for Romaneio in lstTemp do
  begin
    If (Not cbxRomaneiosCancelados.IsChecked) And (Romaneio.Cancelado) Then
      lstCancelados.Add(Romaneio)
    Else
      lstRomaneios.Add(Romaneio);
  end;

  intCancelados := lstCancelados.Count;

  AtualizaQtdePendencias;
end;

procedure TfmxPainelEntregas.AtualizaQtdePendencias;
Var
  LCountPendencias : Integer;
begin
  LCountPendencias := TaEntregue.fCountPendencias;

  If (LCountPendencias > 0) Then
  Begin
    frameNotificacaoPendencias.lblQtde.Text := LCountPendencias.ToString();
    frameNotificacaoPendencias.Visible      := True;
  End
  Else
    frameNotificacaoPendencias.Visible      := False;
end;

procedure TfmxPainelEntregas.AtualizaRecentes;
Var
  Contato: IContato;
begin
  lstRecentes.Clear;
  lstRecentes.BeginUpdate;

  for Contato in Chat.ContatosRecentes do
  begin
    AddContatoRecente(Contato, Chat.ContatosRecentes.IndexOf(Contato));

    If Assigned(ContatoAberto) Then
      If (ContatoAberto.CodigoContato = Contato.CodigoContato) Then
        lstRecentes.ItemIndex := TListBoxItem(FindComponent('lstIteConversasRecentes' + ContatoAberto.CodigoContato)).Index;
  end;

  lstRecentes.EndUpdate;
end;

procedure TfmxPainelEntregas.AtualizaRomaneios(DataInicio,
                                               DataFim: TDatetime;
                                               Pesquisa: String = '';
                                               Exceto: String = '');
Var
  LItem      : TListBoxItem;
  LFrame     : TframeGridRomaneiosLinha;
  LCount, LEntregas, LConcluidos, LCountVisiveis,
  LCountFinalizado, LCountNaoIniciado,
  LCountACaminho, LCountTemPendencia : Integer;
  Romaneio   : IRomaneio;
begin
  Try
    LCount             := 0;
    LCountVisiveis     := 0;
    LEntregas          := 0;
    LConcluidos        := 0;
    LCountFinalizado   := 0;
    LCountNaoIniciado  := 0;
    LCountACaminho     := 0;
    LCountTemPendencia := 0;

    AnimarAguarde(layGrid);

    recUltimoFiltro.dtaInicio        := DataInicio;
    recUltimoFiltro.dtaFim           := DataFim;
    recUltimoFiltro.strPesquisa      := Pesquisa;
    recUltimoFiltro.strExceto        := Exceto;

    AtualizaListaEntregas;

    lstEntregas.BeginUpdate;

    layRodape.Visible := false;

    CleanListBox(lstEntregas);

    lstEntregas.Items.Clear;

    if (lstRomaneios.Count > 0) Then
    Begin
      for Romaneio in lstRomaneios do
      begin
        If (cbxRomaneiosCancelados.IsChecked = False) And (Romaneio.Cancelado) Then
          Continue;

        Inc(LCount);

        LItem       := TListBoxItem.Create(Self);
        LFrame      := TframeGridRomaneiosLinha.Create(Self);
        LFrame.Name := 'Frame' + LCount.ToString();

        LFrame.Parent := LItem;
        LFrame.Align  := TAlignLayout.Contents;
        LItem.Height  := 40;

        LFrame.lblValorRomaneio.Text  := Romaneio.NumeroRomaneio;

        LFrame.lblValorMotorista.Text := Romaneio.Motorista.NomeMotorista;

        If (Romaneio.Veiculo.PlacaVeiculo.IsEmpty) Then
          LFrame.lblValorVeiculo.Text   := ''
        Else
          LFrame.lblValorVeiculo.Text   := Romaneio.Veiculo.PlacaVeiculo + ' - ' +
                                           Romaneio.Veiculo.ModeloVeiculo;

        Case Romaneio.StatusRomaneio Of
          rmFinalizado :
          begin
            LItem.Visible    := cbxFinalizada.IsChecked;
            LCountFinalizado := LCountFinalizado + 1;

            If cbxFinalizada.IsChecked then
            begin
              Inc(LCountVisiveis);
              LEntregas   := LEntregas + Romaneio.QuantidadeEntregas;
              LConcluidos := LConcluidos + Romaneio.QuantidadeEntregasConcluidas;
            end;
          end;

          rmNaoIniciado :
          begin
            LItem.Visible     := cbxNaoIniciada.IsChecked;
            LCountNaoIniciado := LCountNaoIniciado + 1;

            If cbxNaoIniciada.IsChecked then
            begin
              Inc(LCountVisiveis);
              LEntregas   := LEntregas + Romaneio.QuantidadeEntregas;
              LConcluidos := LConcluidos + Romaneio.QuantidadeEntregasConcluidas;
            end;
          end;

          rmACaminho :
          begin
            LItem.Visible  := cbxEmAndamento.IsChecked;
            LCountACaminho := LCountACaminho + 1;

            If cbxEmAndamento.IsChecked then
            begin
              Inc(LCountVisiveis);
              LEntregas   := LEntregas + Romaneio.QuantidadeEntregas;
              LConcluidos := LConcluidos + Romaneio.QuantidadeEntregasConcluidas;
            end;
          end;

          rmTemPendencia :
          begin
            LItem.Visible      := cbxTemPendencia.IsChecked;
            LCountTemPendencia := LCountTemPendencia + 1;

            If cbxTemPendencia.IsChecked then
            begin
              Inc(LCountVisiveis);
              LEntregas   := LEntregas + Romaneio.QuantidadeEntregas;
              LConcluidos := LConcluidos + Romaneio.QuantidadeEntregasConcluidas;
            end;
          end;
        end;

        CarregaImagem(LFrame.imgStatus, RetornaStatus(Romaneio.StatusRomaneio));

        LFrame.lblValorEntregas.Text := IntToStr(Romaneio.QuantidadeEntregas);

        LFrame.lblValorData.Text   := FormataDataHora(Romaneio.DataHoraRomaneio, True);
        LFrame.lblValorInicio.Text := FormataDataHora(Romaneio.DataHoraInicioRomaneio);
        LFrame.lblValorFim.Text    := FormataDataHora(Romaneio.DataHoraBaixaRomaneio);

        LFrame.lblValorDocsConcluidos.Text := Concat(IntToStr(Romaneio.QuantidadeEntregasConcluidas),
                                                     '/',
                                                     IntToStr(Romaneio.QuantidadeEntregas));

        If (Frac(Romaneio.PercentualConcluido) = 0) Then
          LFrame.lblPorcentagemDocsConcluidos.Text  := FormatFloat('#0', Romaneio.PercentualConcluido) + '%'
        Else
          LFrame.lblPorcentagemDocsConcluidos.Text  := FormatFloat('#,##0.00', Romaneio.PercentualConcluido) + '%';
        LFrame.recPorcentagemDocsConcluidos.TagFloat := Romaneio.PercentualConcluido;

        LFrame.recPorcentagemDocsConcluidos.TagFloat := Romaneio.PercentualConcluido;

        CarregaImagemRota(LFrame.imgRota, Romaneio.QuantidadeEntregas > 0, LCount - 1);
        CarregaImagemDocumentos(LFrame.imgDocumentos, LCount - 1);
        CarregaImagemChat(LFrame.imgChat, LCount - 1);
        CarregaImagemOcorrencia(LFrame.imgOcorrencia, LCount - 1, Romaneio.QuantidadeOcorrencias > 0);
        CarregaImagemResolver(LFrame.imgResolvido, LCount - 1, EntregaEmNaoConformidade(Romaneio));

        If EntregaEmNaoConformidade(Romaneio) Then
        Begin
          LItem.TagString := 'NAO CONFORMIDADE';
          LFrame.recFundoBranco.Stroke.Thickness := recLegendaNaoConformidade.Stroke.Thickness;
          LFrame.recFundoBranco.Stroke.Color     := recLegendaNaoConformidade.Stroke.Color;
          LFrame.recFundoBranco.Fill.Color       := recLegendaNaoConformidade.Fill.Color;
        End
        Else If EntregaPausada(Romaneio) Then
        Begin
          LItem.TagString := 'PAUSADA';
          LFrame.recFundoBranco.Stroke.Thickness := recLegendaPausada.Stroke.Thickness;
          LFrame.recFundoBranco.Stroke.Color     := recLegendaPausada.Stroke.Color;
          LFrame.recFundoBranco.Fill.Color       := recLegendaPausada.Fill.Color;
        End
        Else
        Begin
          LItem.TagString := RetornaStatus(Romaneio.StatusRomaneio);
          LFrame.recFundoBranco.Stroke.Thickness := 0;
          LFrame.recFundoBranco.Stroke.Color     := TAlphaColorRec.White;
          LFrame.recFundoBranco.Fill.Color       := TAlphaColorRec.White;
        End;

        If Romaneio.Cancelado Then
        Begin
          LFrame.imgCancelado.Visible            := True;
          LFrame.recFundoBranco.Stroke.Thickness := 1;
          LFrame.recFundoBranco.Stroke.Dash      := TStrokeDash.Dash;
          LFrame.recFundoBranco.Stroke.Color     := $FFA2A2A2;
          LFrame.recFundoBranco.Fill.Color       := $FFE8E8E8;
          LFrame.efeSombra1.Enabled              := False;
        End;

        LItem.Parent := lstEntregas;
      End;

      layRodape.Visible := True;
    End;

    preencheTotais(LCountVisiveis, LEntregas, LConcluidos,
                   LCountNaoIniciado, LCountACaminho, LCountFinalizado,
                   LCountTemPendencia);

    layGrid.Height         := 40 + (LCountVisiveis * 40) + 5;
    layGridEntregas.Height := layGrid.Height + 2;
    lstEntregas.Height     := LCountVisiveis * 40;

  Finally
    lstEntregas.EndUpdate;
  End;

  CalculaAlturaBarraRolagem;

  AnimarAguarde(layGrid, false);
end;

procedure TfmxPainelEntregas.btnAbaChatClick(Sender: TObject);
begin
  MudarAbaSegura(
    procedure
    begin
      TButton(Sender).Enabled := False;
      try
        If (tabPainelEntregas.ActiveTab <> tabAbaChat) Then
        Begin
          HabilitarRefreshAuto(False);

          imgVoltar.Visible       := False;
          imgReordenarEntregas.Visible       := False;
          recBotaoFiltros.Visible := False;

          lstChat.TagString := '';
          lblOperador.Text  := AjustaNome(strNomeUsuarioLogado);
          CarregaChat;

          TelaDefault(True);
          HabilitarAbaNova(tabAbaChat);

          TimerChat.Enabled := True;
          imgApagar.Visible := False;
        End;
      finally
        TButton(Sender).Enabled := True;
      end;
    end
  );
end;

procedure TfmxPainelEntregas.btnAbaDashboardClick(Sender: TObject);
begin
  MudarAbaSegura(
    procedure
    begin
      TButton(Sender).Enabled := False;
      try
        If (tabPainelEntregas.ActiveTab <> tabAbaDashboard) Then
        Begin
          HabilitarRefreshAuto(False);

          imgVoltar.Visible       := False;
          imgReordenarEntregas.Visible       := False;
          recBotaoFiltros.Visible := False;

          WebBrowserNavigate('https://dashboard.citelsoftware.com.br/open.html');

          HabilitarAbaNova(tabAbaDashboard);

          Application.ProcessMessages;

          edtDataIniDash.SetFocus;
        End;
      finally
        TButton(Sender).Enabled := True;
      end;
    end
  );
end;

procedure TfmxPainelEntregas.btnAbaPainelClick(Sender: TObject);
begin
  MudarAbaSegura(
    procedure
    begin
      TButton(Sender).Enabled := False;
      try
        If (tabPainelEntregas.ActiveTab <> tabAbaPainel) Then
        Begin
          ContatoAberto := Nil;

          if (layGridEntregas.Visible) Then
            recBotaoFiltros.Visible := True
          else
          begin
            imgVoltar.Visible       := True;
            imgReordenarEntregas.Visible       := True;
          end;

          HabilitarAbaNova(tabAbaPainel);

          HabilitarRefreshAuto(True);
        End;
      finally
        TButton(Sender).Enabled := True;
      end;
    end
  );
end;

procedure TfmxPainelEntregas.btnAbaPendenciasClick(Sender: TObject);
begin
  MudarAbaSegura(
    procedure
    begin
      TButton(Sender).Enabled := False;
      try
        If (tabPainelEntregas.ActiveTab <> tabAbaPendencias) Then
        Begin
          HabilitarRefreshAuto(False);

          imgVoltar.Visible       := False;
          imgReordenarEntregas.Visible       := False;
          recBotaoFiltros.Visible := False;

          CarregaPendencias;

          HabilitarAbaNova(tabAbaPendencias);

          edtPesquisaPendencia.SetFocus;
        End;
      finally
        TButton(Sender).Enabled := True;
      end;
    end
  );
end;

procedure TfmxPainelEntregas.btnFiltrarClick(Sender: TObject);
begin
  HabilitarRefreshAuto(False);

  If (StrToDate(edtDataIni.Text) > StrToDate(edtDataFim.Text)) Then
  Begin
    Showmessage('Data inicial não pode ser posterior a data final');
    edtDataIni.Tag := 0;
    edtDataIni.SetFocus;
    Exit;
  End;

  If (Not cbxEmAndamento.IsChecked) And
     (Not cbxFinalizada.IsChecked) And
     (Not cbxNaoIniciada.IsChecked) And
     (Not cbxTemPendencia.IsChecked) Then
  Begin
    Showmessage('Nenhum status de entrega foi selecionado');
    cbxEmAndamento.SetFocus;
    Exit;
  End;

  AtualizaRomaneios(StrToDate(edtDataIni.Text),
                    StrToDate(edtDataFim.Text),
                    edtPesquisa.Text,
                    edtExceto.Text);

  edtPesquisa.SetFocus;

  HabilitarRefreshAuto(True);
end;

procedure TfmxPainelEntregas.btnFiltrarDashboardClick(Sender: TObject);
begin
  If (StrToDate(edtDataIniDash.Text) > StrToDate(edtDataFinDash.Text)) Then
  Begin
    Showmessage('Data inicial não pode ser posterior a data final');
    edtDataIniDash.Tag := 0;
    edtDataIniDash.SetFocus;
    Exit;
  End;

  AtualizaGraficos;
end;

function TfmxPainelEntregas.fDocumentoComItemMarcadoParaLiberacao(Documento: IDocumento): Boolean;
var
  Item : IItem;
begin
  Result := False;

  for Item in Documento.Itens do
  begin
    if Item.LiberarItem then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TfmxPainelEntregas.btnLiberacaoClick(Sender: TObject);
var
  blnLiberado: Boolean;
  Documento : IDocumento;

  intOpcao: Integer;
begin
  If Not TemItensSelecionadosParaLiberacao Then
  Begin
    Showmessage('Nenhum item foi selecionado para liberação');
    Exit;
  End;

  blnLiberado := fPermitidoLiberarItem(intOpcao);

  If blnLiberado then
  Begin
    for Documento in Pendencias.DocsComItensBaixadosParcialmente do
    begin
      if not fDocumentoComItemMarcadoParaLiberacao(Documento) then
        Continue;

      if intOpcao = 1 then
        Pendencias.LiberarItensBaixadosParcialmenteParaNovoRomaneio(documento)
      else
        Pendencias.LiberarItensBaixadosParcialmenteParaDevolucao(documento);
    end;

    ShowMessage('Item(ns) liberados com sucesso');
    AtualizaQtdePendencias;
    CarregaPendencias(edtPesquisaPendencia.Text);
  End;
end;

function TfmxPainelEntregas.fPermitidoLiberarItem(var intOpcao: Integer): Boolean;
begin
  Result := False;

  intOpcao := TaEntregue.fMensagem('', 'Liberar quantidade não entregue para:',
                                       ['Reenvio em outro romaneio', 'Realizar devolução'],
                                       3,
                                       True,
                                       1,
                                       210,
                                       False,
                                       0,
                                       False,
                                       False,
                                       True,
                                       0,
                                       460
                                       );

  if intOpcao = 1 then
    Result := TaEntregue.fCriaMsgLiberacao('LIBPRO', 'Liberar quantidade não entregue do item para reenvio em outro romaneio.')
  else if intOpcao = 2 then
    Result := TaEntregue.fCriaMsgLiberacao('LIBDEV', 'Liberar quantidade não entregue do item para realizar devolução.');
end;

procedure TfmxPainelEntregas.btnPesquisaPendenciaClick(Sender: TObject);
begin
  HabilitarRefreshAuto(False);

  CarregaPendencias(edtPesquisaPendencia.Text);

  edtPesquisaPendencia.SetFocus;

  HabilitarRefreshAuto(True);
end;

procedure TfmxPainelEntregas.CalculaAlturaBarraRolagem;
Var
  LHeight : Double;
begin
  LHeight := 30;

  If layFiltros.Visible Then
    LHeight := LHeight + layFiltros.Height + layFiltros.Margins.Top;

  If layGridEntregas.Visible Then
    LHeight := LHeight + layGridEntregas.Height + layGridEntregas.Margins.Top;

  If layGridDocumentos.Visible Then
    LHeight := LHeight + layGridDocumentos.Height + layGridDocumentos.Margins.Top;

  layBody.Height := LHeight;
  layAbaPainel.Height := LHeight;
  tabPainelEntregas.Height := LHeight;
end;

procedure TfmxPainelEntregas.calDataFinDashDateSelected(Sender: TObject);
begin
  edtDataFinDash.Text    := DateToStr(calDataFinDash.Date);
  calDataFinDash.Visible := False;
end;

procedure TfmxPainelEntregas.calDataIniDashDateSelected(Sender: TObject);
begin
  edtDataIniDash.Text    := DateToStr(calDataIniDash.Date);
  calDataIniDash.Visible := False;
end;

procedure TfmxPainelEntregas.calFimDateSelected(Sender: TObject);
begin
  edtDataFim.Text := DateToStr(calFim.Date);
  calFim.Visible  := False;
end;

procedure TfmxPainelEntregas.calInicioDateSelected(Sender: TObject);
begin
  edtDataIni.Text   := DateToStr(calInicio.Date);
  calInicio.Visible := False;
end;

procedure TfmxPainelEntregas.btnEnviaMsgClick(Sender: TObject);
begin
  fmxConsultaContatos := TfmxConsultaContatos.Create(Self);
  fmxConsultaContatos.objFuncoes          := objFuncoes;
  fmxConsultaContatos.Chat                := Chat;
  fmxConsultaContatos.RunningInTSPlus     := objFuncoes.RunningInTSPlus;
  fmxConsultaContatos.UtilizaModoClassico := objFuncoes.UtilizaModoClassico;
  fmxConsultaContatos.Height := Screen.WorkAreaHeight;
  fmxConsultaContatos.Width  := Screen.WorkAreaWidth;
  fmxConsultaContatos.ShowModal;

  If (fmxConsultaContatos.ModalResult = mrOk) Then
    NovoChat(fmxConsultaContatos.ContatoSelecionado);

  FreeAndNil(fmxConsultaContatos);
end;

function TfmxPainelEntregas.RetornaChaveBasic(AClientID,
  AClientSecret: String): String;
  Var
    LBase64: TBase64Encoding;
begin
  Result := '';

  If AClientID.IsEmpty Then
    Exit;

  If AClientSecret.IsEmpty Then
    Exit;

  Try
    LBase64 := TBase64Encoding.Create(0);

    Result := 'Basic ' + LBase64.Encode(AClientID + ':' + AClientSecret);
  Finally
    FreeAndNil(LBase64);
  End;
end;

function TfmxPainelEntregas.RetornaComprimentoQuadro(QuantidadeImagens: Integer; Frame: TframeGridDocumentosLinha): Single;
Var
  LWidth: Single;
begin
  LWidth := 90 * QuantidadeImagens;

  If (LWidth < Frame.layBody.Width) Then
    LWidth := Frame.layBody.Width - 10;

  Result := LWidth;
end;

function TfmxPainelEntregas.RetornaCursorDoEditFocado: TLine;
Var
  LContador: Integer;
begin
  Result := Nil;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassNameIs('TEdit')) Then
      If (TEdit(Self.Components[LContador]).IsFocused) Then
        Result := TLine(FindComponent('lin' + Copy(TEdit(Self.Components[LContador]).Name,4,20) + 'Cursor'));
  End;
end;

function TfmxPainelEntregas.RetornaDiaDaSemana(Dia: TDatetime): String;
Var
  Dias: Integer;
begin
  Dias    := DaysBetween(Now, Dia);

  If (Dias <= 0) Then
    Result := 'Hoje'

  Else If (Dias = 1) Then
    Result := 'Ontem'

  Else If (Dias < 7) Then
  Begin
    Case DayOfTheWeek(Dia) Of
     0: Result := 'Domingo';
     1: Result := 'Segunda-feira';
     2: Result := 'Terça-feira';
     3: Result := 'Quarta-feira';
     4: Result := 'Quinta-feira';
     5: Result := 'Sexta-feira';
     6: Result := 'Sábado';
    End;
  End

  Else
    Result := FormatDateTime('dd/mm/yyyy', Dia);
end;

function TfmxPainelEntregas.RetornaPeriodoUltimaMensagem(
  DataEnvio: TDatetime): String;
Var
  Semanas, Dias, Horas, Minutos: Integer;
begin
  Semanas := WeeksBetween(Now, DataEnvio);
  Dias    := DaysBetween(Now, DataEnvio);
  Horas   := HoursBetween(Now, Dataenvio);
  Minutos := MinutesBetween(Now, Dataenvio);

  If (Minutos < 1) Then
    Result := 'agora'

  Else If (Minutos < 60) Then
    Result := Minutos.ToString() + ' min'

  Else If (Horas < 24) Then
    Result := Horas.ToString() + ' h'

  Else If (Dias < 7) Then
    Result := Dias.ToString() + ' d'

  Else
    Result := Semanas.ToString() + ' sem';
end;

procedure TfmxPainelEntregas.CarregaBotaoAssinaturas(Documento: IDocumento; Frame: TframeGridDocumentosLinha; Indice: Integer);
Var
  LImage     : TImage;
  LRectangle : TRectangle;
  LItemBMP   : TCustomBitmapItem;
  LSize      : TSize;
  Assinatura : IAssinatura;
  LBitmap    : FMX.Graphics.TBitmap;
  LIDImagem  : string;
begin
  if (Documento.Assinaturas.Count > 0) And
     (imglstStatus.BitmapItemByName('ASSINATURAS', LItemBMP, LSize)) Then
  Begin

    while Frame.layDocsAssinaturas.ControlsCount > 0 do
      Frame.layDocsAssinaturas.Controls[0].Free;

    Frame.imgDocsAssinaturas.Bitmap := LItemBMP.MultiResBitmap.Bitmaps[2.0];
    Frame.imgDocsAssinaturas.Opacity := 0.4;
    Frame.imgDocsAssinaturas.Tag     := Indice;
    Frame.layDocsAssinaturas.Tag     := Documento.Assinaturas.Count;

    for Assinatura in Documento.Assinaturas do
    begin
      try
        Assinatura.AssinaturaStream.Position := 0;

        LBitmap := FMX.Graphics.TBitmap.Create;
        try
          LBitmap.LoadFromStream(Assinatura.AssinaturaStream);

          LIDImagem := FGerenciadorImagens.AdicionarImagem(LBitmap);

          LRectangle := TRectangle.Create(Self);
          try
            LRectangle.XRadius      := 10;
            LRectangle.YRadius      := 10;
            LRectangle.Width        := 80;
            LRectangle.Height       := 80;
            LRectangle.Stroke.Color := TAlphaColorRec.Gray;
            LRectangle.Fill.Color   := TAlphaColorRec.White;
            LRectangle.Parent       := Frame.layDocsAssinaturas;

            LImage := TImage.Create(Self);
            try
              LImage.Parent         := LRectangle;
              LImage.Align          := TAlignLayout.Contents;
              LImage.Margins.Left   := 5;
              LImage.Margins.Right  := 5;
              LImage.Margins.Top    := 5;
              LImage.Margins.Bottom := 5;
              LImage.WrapMode       := TImageWrapMode.Fit;
              LImage.Cursor         := crHandPoint;
              LImage.OnClick        := Frame.ImageClick;

              LImage.Bitmap := nil;
              LImage.Repaint;

              LImage.Bitmap.Assign(LBitmap.CreateThumbnail(80,80));
              LImage.TagString := LIDImagem;

              LImage.Repaint;
              LRectangle.Repaint;
            except
              LImage.Free;
              raise;
            end;
          except
            LRectangle.Free;
            raise;
          end;
        finally
          LBitmap.Free;
        end;
      except
        on E: Exception do
          OutputDebugString(PChar('Erro ao carregar assinatura: ' + E.Message));
      end;
    end;

    Frame.Repaint;
  End
  Else
  Begin
    while Frame.layDocsAssinaturas.ControlsCount > 0 do
      Frame.layDocsAssinaturas.Controls[0].Free;

    Frame.imgDocsAssinaturas.HitTest := False;
    Frame.imgDocsAssinaturas.Opacity := 0;
    Frame.imgDocsAssinaturas.Tag     := -1;
    Frame.Repaint;
  End;
end;

procedure TfmxPainelEntregas.CarregaBotaoFotos(Documento: IDocumento; Frame: TframeGridDocumentosLinha; Indice: Integer);
Var
  LImage     : TImage;
  LRectangle : TRectangle;
  LItemBMP   : TCustomBitmapItem;
  LSize      : TSize;
  Foto       : IFoto;
  LBitmap    : FMX.Graphics.TBitmap;
  LIDImagem  : string;
begin
  if (Documento.Fotos.Count > 0) And
     (imglstStatus.BitmapItemByName('FOTOS', LItemBMP, LSize)) Then
  Begin
    while Frame.layDocsFotos.ControlsCount > 0 do
      Frame.layDocsFotos.Controls[0].Free;

    Frame.imgDocsFotos.Bitmap  := LItemBMP.MultiResBitmap.Bitmaps[2.0];
    Frame.imgDocsFotos.Opacity := 0.4;
    Frame.imgDocsFotos.Tag     := Indice;
    Frame.layDocsFotos.Tag     := Documento.Fotos.Count;

    for Foto in Documento.Fotos do
    begin
      try
        Foto.FotoStream.Position := 0;

        LBitmap := FMX.Graphics.TBitmap.Create;
        try
          LBitmap.LoadFromStream(Foto.FotoStream);

          LIDImagem := FGerenciadorImagens.AdicionarImagem(LBitmap);

          LRectangle := TRectangle.Create(Self);
          try
            LRectangle.XRadius      := 10;
            LRectangle.YRadius      := 10;
            LRectangle.Width        := 80;
            LRectangle.Height       := 80;
            LRectangle.Stroke.Color := TAlphaColorRec.Gray;
            LRectangle.Fill.Color   := TAlphaColorRec.White;
            LRectangle.Parent       := Frame.layDocsFotos;

            LImage := TImage.Create(Self);
            try
              LImage.Parent         := LRectangle;
              LImage.Align          := TAlignLayout.Contents;
              LImage.Margins.Left   := 5;
              LImage.Margins.Right  := 5;
              LImage.Margins.Top    := 5;
              LImage.Margins.Bottom := 5;
              LImage.WrapMode       := TImageWrapMode.Fit;
              LImage.Cursor         := crHandPoint;
              LImage.OnClick        := Frame.ImageClick;

              LImage.Bitmap := nil;
              LImage.Repaint;

              LImage.Bitmap.Assign(LBitmap.CreateThumbnail(80,80));
              LImage.TagString := LIDImagem;

              LImage.Repaint;
              LRectangle.Repaint;
            except
              LImage.Free;
              raise;
            end;
          except
            LRectangle.Free;
            raise;
          end;
        finally
          LBitmap.Free;
        end;
      except
        on E: Exception do
          OutputDebugString(PChar('Erro ao carregar foto: ' + E.Message));
      end;
    end;

    Frame.Repaint;
  End
  Else
  Begin
    while Frame.layDocsFotos.ControlsCount > 0 do
      Frame.layDocsFotos.Controls[0].Free;

    Frame.imgDocsFotos.HitTest := False;
    Frame.imgDocsFotos.Opacity := 0;
    Frame.imgDocsFotos.Tag     := -1;
    Frame.Repaint;
  End;
end;

procedure TfmxPainelEntregas.CarregaBotaoObservacoes(Documento: IDocumento;
  Frame: TframeGridDocumentosLinha; Indice: Integer);
Var
  LItemBMP : TCustomBitmapItem;
  LSize    : TSize;
  Ocorrencia : IOcorrencia;
  LIndex   : Integer;
begin
  if (Documento.Ocorrencias.Count > 0) And
     (imglstStatus.BitmapItemByName('OBS', LItemBMP, LSize)) Then
  Begin
    Frame.imgDocsObs.Bitmap  := LItemBMP.MultiResBitmap.Bitmaps[2.0];
    Frame.imgDocsObs.Opacity := 0.4;
    Frame.imgDocsObs.Tag     := Indice;

    LIndex := 0;
    SetLength(Frame.arrOcorrencias, Documento.Ocorrencias.Count, 3);
    SetLength(Frame.arrMensagens, Documento.Ocorrencias.Count);

    for Ocorrencia in Documento.Ocorrencias do
    begin
      Frame.arrOcorrencias[LIndex][0] := IfThen(Ocorrencia.StatusEntregue = '',
                                                '-1',
                                                IfThen(Ocorrencia.StatusEntregue = 'N', '0', '1'));

      If (Ocorrencia.DataHoraOcorrencia = 0) Then
        Frame.arrOcorrencias[LIndex][1] := ''
      Else
        Frame.arrOcorrencias[LIndex][1] := FormatDateTime('dd/MM/yyyy hh:nn', Ocorrencia.DataHoraOcorrencia);

      Frame.arrOcorrencias[LIndex][2] := Ocorrencia.Ocorrencia;

      Frame.arrMensagens[LIndex] := Ocorrencia.Mensagem;

      Inc(LIndex);
    end;

    Frame.grdOcorrencias.RowCount := Length(Frame.arrOcorrencias);
    Frame.grdOcorrencias.UpdateColumns;
    Frame.grdOcorrencias.Repaint;
  End
  Else
  Begin
    Frame.imgDocsObs.HitTest := False;
    Frame.imgDocsObs.Opacity := 0;
    Frame.imgDocsObs.Tag     := -1;
  End;
end;

procedure TfmxPainelEntregas.CarregaChat;
begin
  Chat := TaEntregue.fGetChat(strLoginUsuarioLogado);

  AtualizaRecentes;

  If (Assigned(ContatoAberto)) Then
    if (lstRecentes.Items.Count > 0) Then
      SelecionaRecente(TListBoxItem(FindComponent('lstIteConversasRecentes' + ContatoAberto.CodigoContato)));
end;

procedure TfmxPainelEntregas.CarregaImagemDocumentos(Imagem: TImage;
  IndexRomaneio: Integer);

begin
  Imagem.Tag     := IndexRomaneio;
  imagem.Cursor  := crHandPoint;
  Imagem.Opacity := 0.4;
  Imagem.OnClick := fraGridRomaneiosLinhaimgDocumentosClick;
end;

procedure TfmxPainelEntregas.CarregaImagemOcorrencia(Imagem: TImage; IndexRomaneio: Integer; TemOcorrencia: Boolean);
begin
  If (TemOcorrencia) Then
  Begin
    Imagem.HitTest := True;
    Imagem.Opacity := 0.4;
    Imagem.Tag     := IndexRomaneio;
    imagem.Cursor  := crHandPoint;
    Imagem.OnClick := fraGridRomaneiosLinhaimgOcorrenciaClick;
  End
  Else
  Begin
    Imagem.HitTest := False;
    Imagem.Opacity := 0;
    Imagem.Tag     := -1;
    imagem.Cursor  := crDefault;
  End;
end;

procedure TfmxPainelEntregas.CarregaImagem(Imagem: TImage; Nome: String);
Var
  LItemBMP: TCustomBitmapItem;
  LSize   : TSize;
begin
  if (imglstStatus.BitmapItemByName(Nome, LItemBMP, LSize)) Then
  Begin
    Imagem.Bitmap    := LItemBMP.MultiResBitmap.Bitmaps[2.0];
    Imagem.TagString := Nome;
  End;
end;

procedure TfmxPainelEntregas.CarregaImagemChat(Imagem: TImage;
  IndexRomaneio: Integer);
begin
  Imagem.Tag     := IndexRomaneio;
  imagem.Cursor  := crHandPoint;
  Imagem.Opacity := 0.4;
  Imagem.OnClick := fraGridRomaneiosLinhaimgChatClick;
end;

procedure TfmxPainelEntregas.CarregaImagemResolver(Imagem: TImage; IndexRomaneio: Integer; TemOcorrencia: Boolean);
begin
  If (TemOcorrencia) Then
  Begin
    Imagem.HitTest := True;
    Imagem.Tag     := IndexRomaneio;
    imagem.Cursor  := crHandPoint;
    Imagem.Opacity := 1;
    Imagem.OnClick := fraGridRomaneiosLinhaimgResolvidoClick;
  End
  Else
  Begin
    Imagem.HitTest := False;
    Imagem.Tag     := -1;
    imagem.Cursor  := crDefault;
    Imagem.Opacity := 0;
  End;

end;

procedure TfmxPainelEntregas.CarregaImagemRota(Imagem: TImage; TemRotas: Boolean; IndexRomaneio: Integer);
Var
  LItemBMP: TCustomBitmapItem;
  LSize   : TSize;
begin
  if (TemRotas) And
     (imglstStatus.BitmapItemByName('ROTA', LItemBMP, LSize)) Then
  Begin
    Imagem.Tag     := IndexRomaneio;
    imagem.Cursor  := crHandPoint;
    Imagem.Bitmap  := LItemBMP.MultiResBitmap.Bitmaps[2.0];
    Imagem.Opacity := 0.4;
    Imagem.OnClick := fraGridRomaneiosLinhaimgRotaClick;
  End
  Else
    Imagem.Opacity := 0;
end;

procedure TfmxPainelEntregas.CarregaMensagens;
var
  Conversa: IConversa;
  TipoMsg : TTipoMsg;
  DataMsg : TDatetime;
begin
  if not Assigned(ContatoAberto) then
    Exit;

  DataMsg := 0;

  ContatoAberto.CarregaConversa(strLoginUsuarioLogado);

  lstChat.Clear;
  lstChat.BeginUpdate;

  AddMensagemEmBranco;

  for Conversa in ContatoAberto.Conversas do
  begin
    If (DataMsg < DateOf(Conversa.DataHora)) Then
    Begin
      DataMsg := DateOf(Conversa.DataHora);
      AddGrupoPorDataChat(DataMsg);
    End;

    If (Conversa.Remetente = strLoginUsuarioLogado) Then
      TipoMsg := tmEnviada
    else
      TipoMsg := tmRecebida;

    AddMensagemChat(String(Conversa.Mensagem), TipoMsg, Conversa.DataHora);
  end;

  lstChat.EndUpdate;
  lblChat.Text := AjustaNome(ContatoAberto.NomeContato);
end;

procedure TfmxPainelEntregas.CarregaPendencias(strFiltro: String = '');
var
  Documento: IDocumento;
  ListItem: TListBoxItem;
  Frame: TframePendencias;
  Count: Integer;
  Height, TotalHeight: Single;
begin
  AnimarAguarde(layGridPendencias);
  try
    Count := 0;
    TotalHeight := 0;

    LimparPendenciasAnteriores;

    Pendencias := TaEntregue.fGetPendencias(strFiltro);
    if not Assigned(Pendencias) then
      Exit;

    lstPendencias.BeginUpdate;
    try
      for Documento in Pendencias.DocsComItensBaixadosParcialmente do
      begin
        Inc(Count);

        ListItem := TListBoxItem.Create(nil);
        try
          Frame := TframePendencias.Create(ListItem);
          try
            Frame.Name := 'FramePendencias' + Count.ToString;
            Frame.Parent := ListItem;
            Frame.Align := TAlignLayout.Contents;
            Frame.Pendencias := Pendencias;

            ConfigurarDadosDocumento(Frame, Documento);

            ProcessarOcorrencias(Frame, Documento);

            Documento.CarregaItens;
            Frame.CarregaItens(Documento, Count-1);

            Height := CalcularAlturaItem(Documento);
            Frame.Height := Height;
            ListItem.Height := Height;
            TotalHeight := TotalHeight + Height;

            ListItem.Parent := lstPendencias;
          except
            Frame.Free;
            raise;
          end;
        except
          ListItem.Free;
          raise;
        end;
      end;

      // Ajusta layouts
      AjustarAlturasLayouts(TotalHeight);
    finally
      lstPendencias.EndUpdate;
    end;
  finally
    btnLiberacao.Width := layPendencias.Width;
    AnimarAguarde(layGridPendencias, False);
  end;
end;

procedure TfmxPainelEntregas.LimparPendenciasAnteriores;
var
  I: Integer;
  ListItem: TListBoxItem;
begin
  for I := lstPendencias.Count - 1 downto 0 do
  begin
    ListItem := lstPendencias.ListItems[I];
    ListItem.Free;
  end;
  lstPendencias.Clear;
end;

procedure TfmxPainelEntregas.ConfigurarDadosDocumento(Frame: TframePendencias; Documento: IDocumento);
begin
  Frame.lblValorNumero.Text := Documento.NumeroDocumento + '-' + Documento.EspecieDocumento;
  Frame.lblValorCliente.Text := Documento.Cliente.NomeCliente;
  Frame.lblValorDataBaixa.Text := DateToStr(Documento.DataHoraBaixaEntrega);
  Frame.lblValorRomaneio.Text := Documento.NumeroRomaneio;
  Frame.lblValorMotorista.Text := Documento.Motorista.NomeMotorista;
  Frame.lblValorObs.Text := '';
end;

procedure TfmxPainelEntregas.ProcessarOcorrencias(Frame: TframePendencias; Documento: IDocumento);
var
  Ocorrencia: IOcorrencia;
begin
  Documento.CarregaOcorrencias;

  for Ocorrencia in Documento.Ocorrencias do
  begin
    if (Ocorrencia.StatusEntregue = 'N') then
    begin
      Frame.lblValorObs.Text := Ocorrencia.Ocorrencia;

      if (Ocorrencia.Mensagem <> EmptyAnsiStr) then
      begin
        Frame.lblValorObs.Text := Frame.lblValorObs.Text + ' - ' + String(Ocorrencia.Mensagem);
        Frame.lblValorObs.AutoSize := True;
      end
      else
      begin
        Frame.lblValorObs.AutoSize := False;
        Frame.lblValorObs.Height := 30;
      end;
      Frame.lblValorObs.Repaint;
    end;
  end;
end;

function TfmxPainelEntregas.CalcularAlturaItem(Documento: IDocumento): Single;
begin
  if (Documento.Itens.Count > 3) then
    Result := Documento.Itens.Count * 45
  else
    Result := 164;
end;

procedure TfmxPainelEntregas.AjustarAlturasLayouts(TotalHeight: Single);
begin
  layGridPendencias.Height := TotalHeight + 60;
  layPendencias.Height := layGridPendencias.Height + 2;
  layAbaPendencias.Height := layFiltroPendencia.Height + layPendencias.Height + 75;
end;

procedure TfmxPainelEntregas.CarregarDadosRotas(Romaneio: IRomaneio);
begin
  If Assigned(Romaneio) Then
  Begin
    Romaneio.CarregaRastreamentos;
    Romaneio.CarregaRotasGPX;
  End;
end;

procedure TfmxPainelEntregas.CarregarListaDocumentos(Romaneio: IRomaneio);
begin
  If Assigned(Romaneio) Then
    If Romaneio.Documentos.Count <= 0 Then
      Romaneio.CarregaDocumentos;
end;

procedure TfmxPainelEntregas.CarregarListaOcorrencias(Romaneio: IRomaneio);
begin
  if Assigned(Romaneio) Then
    Romaneio.CarregaOcorrenciasRomaneio;
end;

procedure TfmxPainelEntregas.cbxEmAndamentoKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn,
    vkRight : cbxFinalizada.SetFocus;
    vkDown  : cbxNaoIniciada.SetFocus;
  End;
end;

procedure TfmxPainelEntregas.cbxFinalizadaChange(Sender: TObject);
Var
  ImgON, ImgOFF: TImage;
begin
  ImgON  := TImage(FindComponent('img' + Copy(String(TCheckBox(Sender).Name), 4, 20) + 'ON'));
  ImgOFF := TImage(FindComponent('img' + Copy(String(TCheckBox(Sender).Name), 4, 20) + 'OFF'));

  ImgON.Visible  := TCheckBox(Sender).IsChecked;
  ImgOFF.Visible := Not TCheckBox(Sender).IsChecked;
end;

procedure TfmxPainelEntregas.cbxFinalizadaEnter(Sender: TObject);
begin
  TCheckBox(sender).Opacity := 1;
end;

procedure TfmxPainelEntregas.cbxFinalizadaExit(Sender: TObject);
begin
  TCheckBox(sender).Opacity := 0.7;
end;

procedure TfmxPainelEntregas.cbxFinalizadaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn : cbxNaoIniciada.SetFocus;
    vkLeft   : cbxEmAndamento.SetFocus;
    vkDown   : cbxTemPendencia.SetFocus;
  End;
end;

procedure TfmxPainelEntregas.cbxNaoIniciadaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn,
    vkRight : cbxTemPendencia.SetFocus;
    vkUp    : cbxEmAndamento.SetFocus;
  End;
end;

procedure TfmxPainelEntregas.cbxRomaneiosCanceladosKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkDown, vkReturn : btnFiltrar.SetFocus;
    vkUp : cbxNaoIniciada.SetFocus;
  End;
end;

procedure TfmxPainelEntregas.cbxTemPendenciaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn : cbxRomaneiosCancelados.SetFocus;
    vkLeft   : cbxNaoIniciada.SetFocus;
    vkUp     : cbxFinalizada.SetFocus;
  End;
end;

procedure TfmxPainelEntregas.CleanListBox(Sender: TListBox);
var
  I: Integer;
begin
  for I := Sender.Count-1 downto 0 do
    Sender.ItemByIndex(I).DisposeOf;
end;

procedure TfmxPainelEntregas.ConsultaMotorista;
Var
  LMotorista, LCodMot : String;
  LMotoristas: TArray<String>;
begin
  LMotoristas := objDash.ListaMotoristas;

  fmxConsultaMotoristas := TfmxConsultaMotoristas.Create(Self);
  fmxConsultaMotoristas.RunningInTSPlus := objFuncoes.RunningInTSPlus;

  For LMotorista in LMotoristas do
    fmxConsultaMotoristas.lstMotoristas.Add(LMotorista + '|' + objDash.NomeMotorista(LMotorista));

  fmxConsultaMotoristas.Height := Screen.WorkAreaHeight;
  fmxConsultaMotoristas.Width  := Screen.WorkAreaWidth;
  fmxConsultaMotoristas.ShowModal;

  If (fmxConsultaMotoristaS.ModalResult = mrOk) Then
  Begin
    If (Length(fmxConsultaMotoristas.strCodMot) > 5) Then
    Begin
      edtCodMotorista.TagString  := fmxConsultaMotoristas.strCodMot;
      edtCodMotorista.TextPrompt := '...';
      edtCodMotorista.Text       := '';

      LCodMot := edtCodMotorista.TagString.Replace(',','');
      lblNomeMotorista.Text := (Length(LCodMot) / 5).ToString + ' MOTORISTAS SELECIONADOS';

      btnFiltrarDashboard.SetFocus;
    End
    Else
    Begin
      edtCodMotorista.TagString  := '';
      edtCodMotorista.TextPrompt := '';
      edtCodMotorista.Text       := fmxConsultaMotoristas.strCodMot;
    End;
  End;

  FreeAndNil(fmxConsultaMotoristas);
end;

procedure TfmxPainelEntregas.DesabilitarAbaAtual;
Var
  LLayoutBotao,
  LLayoutPrincipal : TLayout;
  LRectangle       : TRectangle;
  LTab             : TTabItem;
begin
  If Assigned(tabPainelEntregas.ActiveTab) Then
  Begin
    LTab       := tabPainelEntregas.ActiveTab;

    LLayoutPrincipal := TLayout(FindComponent('lay' + Copy(LTab.Name,4,30)));
    LLayoutPrincipal.Visible := False;

    LLayoutBotao := TLayout(FindComponent('layBotao' + Copy(LTab.Name,4,30)));
    LRectangle   := TRectangle(FindComponent('recBotao' + Copy(LTab.Name, 4, 30)));

    LLayoutBotao.Opacity := 0.3;
    LRectangle.Visible   := False;

    tabPainelEntregas.TabIndex := -1;
    Application.ProcessMessages;
  End;

end;

{procedure TfmxPainelEntregas.ComprimeLinhas;
Var
  x : Integer;
  LItem : TListBoxItem;
  LFrame: TframeGridDocumentosLinha;
begin
  lstDocumentos.BeginUpdate;

  For x := 1 to lstDocumentos.Count do
  Begin
    LItem := lstDocumentos.ItemByIndex(x - 1);

    If (LItem.Height > 40) Then
    Begin
      LItem.Height := 40;

      LFrame := TframeGridDocumentosLinha(FindComponent('FrameDocs' + x.ToString()));

      If Assigned(LFrame) Then
      Begin
        LFrame.layDocsFotos.Visible := False;
        LFrame.layDocsFotos.Opacity := 0;

        LFrame.layDocsAssinaturas.Visible := False;
        LFrame.layDocsAssinaturas.Opacity := 0;

        LFrame.scrHorizontal.Visible := False;

        LFrame.layDocsObservacoes.Visible := False;
        LFrame.layDocsObservacoes.Opacity := 0;
      End;
    End;
  End;

  layGridDocs.Height       := 40 + (lstDocumentos.Items.Count * 40) + 5;
  layGridDocumentos.Height := layGridDocs.Height + 2;

  lstDocumentos.EndUpdate;
end; }

procedure TfmxPainelEntregas.edtDataIniChangeTracking(Sender: TObject);
begin
  MoveCursor(Sender, vkRight);
end;

procedure TfmxPainelEntregas.edtDataIniClick(Sender: TObject);
begin
  MoveCursor(Sender, vkHome);
  PiscaCursor(Sender);

  if Not (TEdit(Sender).Text.IsEmpty) Then
  Begin
    TEdit(Sender).SelectAll;
    TEdit(Sender).Repaint;
  End;
end;

procedure TfmxPainelEntregas.edtDataIniDashKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn:
    Begin
      If (TEdit(Sender).Tag = 1) Then
        edtDataFinDash.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtDataIniEnter(Sender: TObject);
begin
  MoveCursor(Sender, vkHome);
  PiscaCursor(Sender);

  if Not (TEdit(Sender).Text.IsEmpty) Then
  Begin
    TEdit(Sender).SelectAll;
    TEdit(Sender).Repaint;
  End;
end;

procedure TfmxPainelEntregas.edtDataIniExit(Sender: TObject);
begin
  EscondeCursor(Sender);
end;

procedure TfmxPainelEntregas.edtDataIniValidate(Sender: TObject; var Text: string);
Var
  Value : TDatetime;
begin
  TEdit(Sender).Tag := 0;

  ValidaDataPreenchida(TEdit(Sender));
  ValidaFormatoData(TEdit(Sender));

  if (Length(TEdit(Sender).Text) = 6) then
    Text := Mascara(LeftStr(TEdit(Sender).Text, 4) + '20' + RightStr(TEdit(Sender).Text, 2),'99/99/9999')
  else
    Text := Mascara(TEdit(Sender).Text,'99/99/9999');

  TEdit(Sender).Text := Text;
  TEdit(Sender).SelStart := Length(TEdit(Sender).Text);

  If Not TryStrToDate(Text, Value) Then
  Begin
    Showmessage(Text + ' não é uma data válida');
    TEdit(Sender).SetFocus;
  End
  Else
    TEdit(Sender).Tag := 1;
end;

procedure TfmxPainelEntregas.edtPesquisaPendenciaChangeTracking(Sender: TObject);
var
  thetext: String;
begin
  thetext := edtPesquisaPendencia.Text;
  edtPesquisaPendencia.OnChangeTracking := nil;
  edtPesquisaPendencia.Text := '';
  edtPesquisaPendencia.Text := AnsiUpperCase(thetext);
  edtPesquisaPendencia.OnChangeTracking := edtPesquisaPendenciaChangeTracking;
  edtPesquisaPendencia.GoToTextEnd;

  MoveCursor(Sender, vkRight);
end;

procedure TfmxPainelEntregas.edtPesquisaPendenciaEnter(Sender: TObject);
begin
  If (edtPesquisaPendencia.Text = EmptyStr) Then
    lblPesquisaPendencia.Visible := False;

  PiscaCursor(Sender);
end;

procedure TfmxPainelEntregas.edtPesquisaPendenciaExit(Sender: TObject);
begin
  If (edtPesquisaPendencia.Text = EmptyStr) Then
    lblPesquisaPendencia.Visible := True;

  EscondeCursor(Sender);
end;

procedure TfmxPainelEntregas.edtPesquisaPendenciaKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn:
    Begin
      btnPesquisaPendencia.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtMsgChange(Sender: TObject);
Var
  LFrame : TframeConversasRecentes;
begin
  if Not Assigned(ContatoAberto) then
    Exit;

  If (edtMsg.Text <> EmptyStr) Then
  begin
    If DateOf(ContatoAberto.DataHoraUltimaMensagem) < DateOf(Now) Then
    Begin
      AddGrupoPorDataChat(Now);
    End;

    ContatoAberto.EnviarMensagem(strLoginUsuarioLogado, AnsiString(edtMsg.Text));

    AddMensagemChat(edtMsg.Text, tmEnviada, Now);

    If (lstChat.TagString = 'NovaConversa') Then
    Begin
      CarregaChat;
      lstChat.TagString := '';
    End;

    lstRecentes.Selected.Index := 0;
    lstRecentes.ItemIndex      := 0;

    LFrame := TframeConversasRecentes(FindComponent('frameConversasRecentes' + lstRecentes.Selected.TagString));
    LFrame.lblPeriodo.Text   := RetornaPeriodoUltimaMensagem(Now);
    LFrame.lblUltimaMsg.Text := edtMsg.Text;
  end;

  edtMsg.Text := EmptyStr;
end;

procedure TfmxPainelEntregas.edtMsgChangeTracking(Sender: TObject);
begin
  MoveCursor(Sender, vkRight);
end;

procedure TfmxPainelEntregas.edtMsgClick(Sender: TObject);
begin
  MoveCursor(Sender, vkNone);
end;

procedure TfmxPainelEntregas.edtMsgEnter(Sender: TObject);
begin
  If (edtMsg.Text = EmptyStr) Then
    lblMsg.Visible := False;

  PiscaCursor(Sender);
end;

procedure TfmxPainelEntregas.edtMsgExit(Sender: TObject);
begin
  If (edtMsg.Text = EmptyStr) Then
    lblMsg.Visible := True;

  EscondeCursor(Sender);
end;

procedure TfmxPainelEntregas.edtCodMotoristaChange(Sender: TObject);
Var
  LCodMot,
  LNomeMotorista : String;
begin
  LCodMot := '';

  If (edtCodMotorista.Text.IsEmpty) Then
  Begin
    lblNomeMotorista.FontColor := TAlphaColorRec.Black;
    lblNomeMotorista.Opacity   := 0.6;
    lblNomeMotorista.Text      := 'TODAS';
    btnFiltrarDashboard.SetFocus;
  End
  Else
  Begin
    edtCodMotorista.TagString  := '';
    edtCodMotorista.TextPrompt := '';

    LNomeMotorista := objDash.NomeMotorista(FormatFloat('00000',StrToInt(edtCodMotorista.Text)));

    lblNomeMotorista.FontColor := TAlphaColorRec.Red;
    lblNomeMotorista.Opacity   := 1;

    edtCodMotorista.SelectAll;
    MoveCursor(Sender, vkEnd);

    If (LNomeMotorista.IsEmpty) Then
    Begin
      lblNomeMotorista.Text    := 'MOTORISTA NÃO ENCONTRADO. POR FAVOR, INFORME UM CÓDIGO VÁLIDO';
      edtCodMotorista.SetFocus;
      Exit;
    End
    Else
    Begin
      lblNomeMotorista.FontColor := TAlphaColorRec.Black;
      lblNomeMotorista.Opacity   := 0.6;
      lblNomeMotorista.Text      := LNomeMotorista;
      btnFiltrarDashboard.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtCodMotoristaExit(Sender: TObject);
begin
  If (Not edtCodMotorista.Text.IsEmpty) And (lblNomeMotorista.FontColor <> TAlphaColorRec.Red) Then
    edtCodMotorista.Text := FormatFloat('00000', edtCodMotorista.Text.ToInteger());

  EscondeCursor(Sender);
end;

procedure TfmxPainelEntregas.edtCodMotoristaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  If (KeyChar = '/') Then
    ConsultaMotorista;

  If (edtCodMotorista.Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Sender, Key);
    End;
  End;
end;

procedure TfmxPainelEntregas.edtCodMotoristaKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn :
    Begin
      if (lblNomeMotorista.FontColor <> TAlphaColorRec.Red) Then
        btnFiltrarDashboard.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtDataFimKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn:
    Begin
      If (TEdit(Sender).Tag = 1) Then
        cbxEmAndamento.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtDataFinDashKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn:
    Begin
      If (TEdit(Sender).Tag = 1) Then
        edtCodMotorista.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtDataIniKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If (TEdit(Sender).Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Sender, Key);
    End;
  End;

  if (Length(TEdit(Sender).Text) = 8) Then
  begin
    KeyChar := #0;
  end;
end;

procedure TfmxPainelEntregas.edtDataIniKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn:
    Begin
      If (TEdit(Sender).Tag = 1) Then
        edtDataFim.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtPesquisaChangeTracking(Sender: TObject);
var
  thetext: String;
begin
  thetext := edtPesquisa.Text;
  edtPesquisa.OnChangeTracking := nil;
  edtPesquisa.Text := '';

  edtPesquisa.Text := AnsiUpperCase(thetext);
  edtPesquisa.OnChangeTracking := edtPesquisaChangeTracking;
  edtPesquisa.GoToTextEnd;

  MoveCursor(Sender, vkRight);
end;

procedure TfmxPainelEntregas.edtPesquisaClick(Sender: TObject);
begin
  MoveCursor(Sender, vkNone);
end;

procedure TfmxPainelEntregas.edtPesquisaEnter(Sender: TObject);
begin
  If (edtPesquisa.Text = EmptyStr) Then
    lblPesquisa.Visible := False;

  PiscaCursor(Sender);
end;

procedure TfmxPainelEntregas.edtPesquisaExit(Sender: TObject);
begin
  If (edtPesquisa.Text = EmptyStr) Then
    lblPesquisa.Visible := True;

  EscondeCursor(Sender);
end;

procedure TfmxPainelEntregas.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If (TEdit(Sender).Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Sender, Key);
    End;
  End;
end;

procedure TfmxPainelEntregas.edtPesquisaKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn:
    Begin
      edtExceto.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtExcetoChangeTracking(Sender: TObject);
var
  thetext: String;
begin
  thetext := edtExceto.Text;
  edtExceto.OnChangeTracking := nil;
  edtExceto.Text := '';

  edtExceto.Text := AnsiUpperCase(thetext);
  edtExceto.OnChangeTracking := edtExcetoChangeTracking;
  edtExceto.GoToTextEnd;

  MoveCursor(Sender, vkRight);
end;

procedure TfmxPainelEntregas.edtExcetoClick(Sender: TObject);
begin
  MoveCursor(Sender, vkNone);
end;

procedure TfmxPainelEntregas.edtExcetoEnter(Sender: TObject);
begin
  If (edtExceto.Text = EmptyStr) Then
    lblExceto.Visible := False;

  PiscaCursor(Sender);
end;

procedure TfmxPainelEntregas.edtExcetoExit(Sender: TObject);
begin
  If (edtExceto.Text = EmptyStr) Then
    lblExceto.Visible := True;

  EscondeCursor(Sender);
end;

procedure TfmxPainelEntregas.edtExcetoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if ssCtrl in Shift then
  begin
    case Key of
      vkLeft, vkRight:
      begin
        FormKeyDown(Sender, Key, KeyChar, Shift);
        Exit;
      end;
    end;
  end;

  if (TEdit(Sender).Text <> EmptyStr) then
  begin
    case Key of
      vkLeft, vkHome, vkRight, vkEnd:
        MoveCursor(Sender, Key);
    end;
  end;
end;

procedure TfmxPainelEntregas.edtExcetoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn:
    Begin
      edtDataIni.SetFocus;
    End;
  End;
end;

procedure TfmxPainelEntregas.edtPesquisaRecentesChange(Sender: TObject);
begin
  If (lstRecentes.Items.Count > 0) Then
  Begin
    SelecionaRecente(lstRecentes.ItemByIndex(0));
    lstRecentes.SetFocus;
  End;
end;

procedure TfmxPainelEntregas.edtPesquisaRecentesChangeTracking(Sender: TObject);
var
  S: String;
  Contato: IContato;
begin
  lstRecentes.Items.BeginUpdate;
  try
    lstRecentes.Clear;

    if edtPesquisaRecentes.Text.Length > 0 then
    begin
      ContatoAberto := Nil;
      lstRecentes.ItemIndex := -1;

      S := edtPesquisaRecentes.Text;

      for Contato in Chat.ContatosRecentes do
      begin
        if ContainsText(Contato.NomeContato, S) then
          AddContatoRecente(Contato, Chat.ContatosRecentes.IndexOf(Contato));
      end;
    end
    else
    begin
      AtualizaRecentes;

      If Assigned(ContatoAberto) Then
        SelecionaRecente(TListBoxItem(FindComponent('lstIteConversasRecentes' + ContatoAberto.CodigoContato)));
    end;
  finally
    lstRecentes.Items.EndUpdate;
  end;

  imgApagar.Visible := edtPesquisaRecentes.Text.Length > 0;

  MoveCursor(Sender, vkRight);
end;

procedure TfmxPainelEntregas.edtPesquisaRecentesClick(Sender: TObject);
begin
  MoveCursor(Sender, vkNone);
end;

procedure TfmxPainelEntregas.edtPesquisaRecentesEnter(Sender: TObject);
begin
  If (edtPesquisaRecentes.Text = EmptyStr) Then
    lblPesquisaRecentes.Visible := False;

  PiscaCursor(Sender);
end;

procedure TfmxPainelEntregas.edtPesquisaRecentesExit(Sender: TObject);
begin
  If (edtPesquisaRecentes.Text = EmptyStr) Then
    lblPesquisaRecentes.Visible := True;

  EscondeCursor(Sender);
end;

procedure TfmxPainelEntregas.AddContatoRecente(Contato: IContato; Index: Integer);
Var
  LItem : TListBoxItem;
  LFrame: TframeConversasRecentes;
begin
  LItem            := TListBoxItem.Create(Self);
  LItem.HitTest    := True;
  LItem.Cursor     := crHandPoint;
  LItem.Selectable := True;
  LItem.TagString  := Contato.CodigoContato;
  LItem.Tag        := Index;
  LItem.Name       := 'lstIteConversasRecentes' + Contato.CodigoContato;
  LItem.Height     := 50;
  LItem.Text       := '';
  LItem.Parent     := lstRecentes;
  LItem.OnClick    := SelecionaRecente;

  LFrame           := TframeConversasRecentes.Create(Self);
  LFrame.Cursor    := crHandPoint;
  LFrame.Name      := 'frameConversasRecentes' + Contato.CodigoContato;
  LFrame.Align     := TAlignLayout.Contents;
  LFrame.Height    := 50;
  LFrame.Parent    := LItem;

  LFrame.lblNome.Text                  := AjustaNome(Contato.NomeContato);
  LFrame.lblNome.TagString             := Contato.CodigoContato;
  LFrame.lblUltimaMsg.Text             := Contato.UltimaMensagem;
  LFrame.lblPeriodo.Text               := RetornaPeriodoUltimaMensagem(Contato.DataHoraUltimaMensagem);
  LFrame.frameNotificacao.lblQtde.Text := IntToStr(Contato.QuantidadeMensagensNaoLidas);

  LFrame.frameNotificacao.Visible := Contato.QuantidadeMensagensNaoLidas > 0;
  LFrame.lblPeriodo.Visible       := Contato.QuantidadeMensagensNaoLidas <= 0;
end;

procedure TfmxPainelEntregas.AddGrupoPorDataChat(Dia: TDateTime);
Var
  LItem   : TListBoxItem;
  LHeight : Double;
begin
  LItem                := TListBoxGroupHeader.Create(Self);
  LItem.Selectable     := False;
  LItem.HitTest        := False;
  LItem.Name           := 'GrupoData' + IntToStr(lstChat.Items.Count + 1);
  LItem.StyleLookup    := 'citelgroupitemlistbox';
  LItem.Height         := 25;
  LItem.Margins.Top    := 15;
  LItem.Margins.Bottom := 15;
  LItem.Index          := 0;
  LItem.Text           := RetornaDiaDaSemana(Dia);

  LItem.Parent      := lstChat;

  LHeight := lstChat.ItemByIndex(0).Height;
  lstChat.ItemByIndex(0).Height := LHeight - 55;

  If (lstChat.ItemByIndex(0).Height <= 0) Then
    lstChat.ItemByIndex(0).Height := 0;
end;

procedure TfmxPainelEntregas.AddMensagemEmBranco;
begin
  lstChat.Clear;
  lstChat.BeginUpdate;
  lstChat.Items.Add('');
  lstChat.ItemByIndex(0).Selectable := False;
  lstChat.ItemByIndex(0).Height := lstChat.Height;
  lstChat.EndUpdate;
end;

procedure TfmxPainelEntregas.AddMensagemChat(Msg: String; tipoMensagem: TTipoMsg; dataHoraMsg: TDateTime);
Var
  LItem       : TListBoxItem;
  LFrameEnv   : TframeMsgEnviada;
  LFrameRec   : TframeMsgRecebida;
  LHeight,
  WidthMsg,
  FatorHeight : Double;
begin
  LItem               := TListBoxItem.Create(Self);
  LItem.Selectable    := False;
  LItem.HitTest       := False;
  LItem.Name          := 'Msg' + IntToStr(lstChat.Items.Count + 1);
  LItem.Margins.Right := 15;
  LItem.Margins.Left  := 15;
  LItem.Height        := 50;
  LItem.Index         := 0;
  LItem.Text          := '';

  If (tipoMensagem = tmEnviada) Then
  Begin
    LFrameEnv        := TframeMsgEnviada.Create(Self);
    LFrameEnv.Name   := 'frameMsgEnviada' + IntToStr(lstChat.Items.Count + 1);
    LFrameEnv.HitTest:= False;
    LFrameEnv.Align  := TAlignLayout.Right;
    LFrameEnv.Height := 50;
    LFrameEnv.Parent := LItem;

    LFrameEnv.lblMensagem.Text := Msg;
    LFrameEnv.lblHora.Text     := FormatDateTime('hh:mm', dataHoraMsg);

    WidthMsg := GetTextSize(LFrameEnv.lblMensagem) +
                LFrameEnv.lblMensagem.Margins.Left +
                LFrameEnv.lblMensagem.Margins.Right +
                LFrameEnv.lblHora.Width +
                LFrameEnv.lblHora.Margins.Left +
                LFrameEnv.lblHora.Margins.Right;

    If (WidthMsg > lstChat.Width) Then
    Begin
      LFrameEnv.Width                := (lstChat.Width - 30) - 20;
      LFrameEnv.lblMensagem.WordWrap := True;
      LFrameEnv.lblMensagem.Width    := (lstChat.Width - 30) - 100;
      FatorHeight                    := WidthMsg / LFrameEnv.lblMensagem.Width;
      LItem.Height                   := (17 * Ceil(FatorHeight)) + 30;
      LFrameEnv.Height               := LItem.Height;
    End
    Else
      LFrameEnv.Width                := WidthMsg;
  End
  Else If (tipoMensagem = tmRecebida) Then
  Begin
    LFrameRec        := TframeMsgRecebida.Create(Self);
    LFrameRec.Name   := 'frameMsgEnviada' + IntToStr(lstChat.Items.Count + 1);
    LFrameRec.HitTest:= False;
    LFrameRec.Align  := TAlignLayout.Left;
    LFrameRec.Height := 50;
    LFrameRec.Parent := LItem;

    LFrameRec.lblMensagem.Text := Msg;
    LFrameRec.lblHora.Text     := FormatDateTime('hh:mm', dataHoraMsg);

    WidthMsg := GetTextSize(LFrameRec.lblMensagem) +
                LFrameRec.lblMensagem.Margins.Left +
                LFrameRec.lblMensagem.Margins.Right +
                LFrameRec.lblHora.Width +
                LFrameRec.lblHora.Margins.Left +
                LFrameRec.lblHora.Margins.Right;

    If (WidthMsg > lstChat.Width) Then
    Begin
      LFrameRec.Width                := (lstChat.Width - 30) - 20;
      LFrameRec.lblMensagem.WordWrap := True;
      LFrameRec.lblMensagem.Width    := (lstChat.Width - 30) - 100;
      FatorHeight                    := WidthMsg / LFrameRec.lblMensagem.Width;
      LItem.Height                   := (17 * Ceil(FatorHeight)) + 30;
      LFrameRec.Height               := LItem.Height;
    End
    Else
      LFrameRec.Width                := WidthMsg;
  End;

  LItem.Parent  := lstChat;

  LHeight := lstChat.ItemByIndex(0).Height;
  lstChat.ItemByIndex(0).Height := LHeight - LItem.Height;

  If (lstChat.ItemByIndex(0).Height <= 0) Then
  Begin
    lstChat.ItemByIndex(0).Height := 0;
    lstChat.ScrollToItem(LItem);
  End;
end;

function TfmxPainelEntregas.EntregaEmNaoConformidade(
  Romaneio: IRomaneio): Boolean;
begin
  Result := Romaneio.NivelPrioridade > -1;
end;

function TfmxPainelEntregas.EntregaPausada(Romaneio: IRomaneio): Boolean;
var
  Alerta: IAlerta;
begin
  inherited;

  Result := False;

  for Alerta in Romaneio.Alertas do
  begin
    if Alerta.IdentificacaoAlerta = 'PAUSA_INICIADA'then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

procedure TfmxPainelEntregas.EscondeCursor(Sender: TObject);
Var
  LCursor: TLine;
begin
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LCursor.Visible := False;
  LCursor.Tag := 0;
end;

procedure TfmxPainelEntregas.EsconderLayouts(LFrame: TframeGridDocumentosLinha);
begin
  LFrame.layDocsFotos.Visible := False;
  LFrame.layDocsFotos.Opacity := 0;

  LFrame.layDocsAssinaturas.Visible := False;
  LFrame.layDocsAssinaturas.Opacity := 0;

  LFrame.layDocsObservacoes.Visible := False;
  LFrame.layDocsObservacoes.Opacity := 0;
end;

function TfmxPainelEntregas.ExisteChatComEsseContato(
  Contato: IContato): Boolean;
Var
  ContatoRec : IContato;
begin
  Result := False;

  for ContatoRec in Chat.ContatosRecentes Do
  begin
    If (ContatoRec.CodigoContato = Contato.CodigoContato) Then
    Begin
      Result := True;
      Exit;
    End;
  end;
end;

procedure TfmxPainelEntregas.ExpandeLinha(Sender: TObject; AlterarTag: Boolean = true);
var
  LItem : TListBoxItem;
  LFrame: TframeGridDocumentosLinha;
  LIndice: Integer;
begin
  LItem  := lstDocumentos.ItemByIndex(TImage(Sender).Tag);
  LIndice:= TImage(Sender).Tag + 1;
  LFrame := TframeGridDocumentosLinha(FindComponent('FrameDocs' + LIndice.ToString()));

  IF (Assigned(LItem)) Then
  Begin
    lstDocumentos.BeginUpdate;

    If (LItem.Height >= 140) Then
    begin
      LItem.Height := 40;
      EsconderLayouts(LFrame);
      LFrame.scrHorizontal.Visible := False;
      LFrame.TagString := '';
    end
    else
    begin
      LItem.Height := 140;
      AbrirQuadro(TImage(Sender), LFrame);
      LFrame.TagString := String(TImage(Sender).Name);
    End;

    AjustaGridDocumentos(AlterarTag);
    lstDocumentos.EndUpdate;
  End;
end;

procedure TfmxPainelEntregas.ExpandeTodasLinhas(Sender: TObject);
Var
  LItem : TListBoxItem;
  LFrame: TframeGridDocumentosLinha;
  LImage: TImage;
  x     : Integer;
begin
  For x := 1 to lstDocumentos.Count do
  Begin
    LItem  := lstDocumentos.ItemByIndex(x-1);
    LFrame := TframeGridDocumentosLinha(FindComponent('FrameDocs' + x.ToString()));
    LImage := TImage(LFrame.FindComponent(String(TImage(Sender).Name)));

    if (TImage(Sender).Tag = 0) Then
    begin
      if (LItem.Height <= 40) Then
      begin
        ExpandeLinha(LImage, false);
        imgExpandida := TImage(Sender);
      end;
    end
    else
    begin
      if (LItem.Height > 40) Then
      begin
        ExpandeLinha(LImage, false);
        imgExpandida := Nil;
      end;
    end;
  End;
end;

procedure TfmxPainelEntregas.FecharTelaDocumentos;
begin
  CleanListBox(lstDocumentos);

  FGerenciadorImagens.LimparTodasImagens;

  lblTitulo.Text := 'Painel de Rotas';

  recBotaoFiltros.Visible := true;
  layFiltros.Visible      := true;
  layGridEntregas.Visible := true;

  layGridDocumentos.Visible := false;
  layColunasGridDocumentos.Visible := false;
  imgVoltar.Visible         := false;
  imgReordenarEntregas.Visible         := false;
end;

procedure TfmxPainelEntregas.FormActivate(Sender: TObject);
begin
  habilitarCursores;

  If objFuncoes.RunningInTSPlus Then
  Begin
    if objFuncoes.UtilizaModoClassico then
      edtDataIni.SetFocus
    else
      edtPesquisa.SetFocus;
  End
  Else
    edtPesquisa.SetFocus;
end;

function TfmxPainelEntregas.FormataDataHora(Data: TDatetime; SoData: Boolean = false): String;
begin
  if (Data <> StrToDate('30/12/1899')) Then
    Result := FormatDateTime(IfThen(SoData, 'dd/MM/yyyy', 'dd/MM/yyyy hh:nn'), Data)
  else
    Result := '';
end;

procedure TfmxPainelEntregas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGerenciadorImagens.LimparTodasImagens;
  FreeAndNil(FGerenciadorImagens);

  if Assigned(lstRomaneios) Then
    lstRomaneios.Clear;

  if Assigned(lstCancelados) Then
    lstCancelados.Clear;

  if Assigned(lstTemp) Then
    lstTemp.Clear;

  Self.Tag := 0;
end;

procedure TfmxPainelEntregas.FormCreate(Sender: TObject);
begin
  EscondeCursor(edtPesquisa);
  EscondeCursor(edtExceto);
  EscondeCursor(edtDataIni);
  EscondeCursor(edtDataFim);
  EscondeCursor(edtPesquisaRecentes);
  EscondeCursor(edtMsg);
  EscondeCursor(edtDataIniDash);
  EscondeCursor(edtDataFinDash);
  EscondeCursor(edtCodMotorista);

  tabPainelEntregas.TabIndex := 0;

  layGridDocumentos.Visible := False;
  layColunasGridDocumentos.Visible := false;
  imgVoltar.Visible         := False;
  imgReordenarEntregas.Visible         := False;
  calFim.Visible            := False;
  calInicio.Visible         := False;
  imgExpandida              := Nil;
  Timer.Enabled             := True;
  recBotaoFiltros.Visible   := True;

  frameNotificacaoChat.Visible       := False;
  frameNotificacaoPendencias.Visible := False;

  preencheTotais(0,0,0,0,0,0,0);
  recCarregando.Visible := False;

  FGerenciadorImagens := TGerenciadorImagens.Create;

  tmrHabilitarBotoes.Enabled := False;
  HabilitarBotoes(True);

  intQtdNovasMensagens      := 0;
  intCancelados             := 0;
end;

procedure TfmxPainelEntregas.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape:
    Begin
      If (imgVoltar.Visible) Then
        imgVoltarClick(imgvoltar)
      else
        Self.Close;
    End;

    VK_F4:
    Begin
      If (Shift = ([ssAlt])) Then
        Abort;
    End;
  End;
end;

procedure TfmxPainelEntregas.FormResize(Sender: TObject);
//Var
//  LLarguraMinima : Double;
begin
//  LLarguraMinima := layFiltros.Margins.Left +
//                    layFiltros.Margins.Right +
//                    recBordasFiltros.Width +
//                    recBordasFiltros.Margins.Right +
//                    recTotais.Width +
//                    recTotais.Margins.Right +
//                    recLegenda.Width;

  If Self.Width <= 1370 Then
    layFiltros.Height := 146
  Else
    layFiltros.Height := 68;

  If Self.Width <= 1370 Then
  begin
    layColunasGridDocumentos.ColumnCollection[3].Value := 0;
    layColunasGridDocumentos.ColumnCollection[4].Value := 0;
  end
  Else
  begin
    layColunasGridDocumentos.ColumnCollection[3].Value := 130;
    layColunasGridDocumentos.ColumnCollection[4].Value := 90;
  end;

  If layGridDocumentos.Visible Then
    AtualizaDocumentos(layGridDocumentos.Tag);
end;

procedure TfmxPainelEntregas.FormShow(Sender: TObject);
begin
  TimerChat.Enabled         := True;
  TimerRefresh.Enabled      := True;
end;

procedure TfmxPainelEntregas.fraGridDocumentosLinhaimgDocsImprimirClick(
  Sender: TObject);
Var
  Documento: IDocumento;
  titulo : String;
begin
  titulo := lblTitulo.Text;
  lblTitulo.Text := 'Aguarde, realizando a impressão...';

  Documento := lstDocs.Items[TImage(Sender).Tag];
  Documento.ImprimirDocumento;

  lblTitulo.Text := titulo;
end;

procedure TfmxPainelEntregas.fraGridRomaneiosLinhaimgChatClick(Sender: TObject);
Var
  Romaneio : IRomaneio;
  Contato  : IContato;
begin
  HabilitarRefreshAuto(False);

  Try
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  Except
    AtualizaListaEntregas;
    Sleep(200);
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  End;

  for Contato in Chat.Contatos do
  Begin
    If (Romaneio.Motorista.CodigoMotorista = Contato.CodigoContato) Then
    Begin
      btnAbaChatClick(btnAbaChat);
      NovoChat(Contato);
      Exit;
    End;
  End;
end;

procedure TfmxPainelEntregas.fraGridRomaneiosLinhaimgDocumentosClick(
  Sender: TObject);
Var
  Romaneio : IRomaneio;
begin
  HabilitarRefreshAuto(False);

  Try
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  Except
    AtualizaListaEntregas;
    Sleep(200);
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  End;

  imgNovaEntrega.Tag := TImage(Sender).Tag;

  CarregarListaDocumentos(Romaneio);

  AbrirTelaDocumentos(Romaneio.NumeroRomaneio, TImage(Sender).Tag);
end;

procedure TfmxPainelEntregas.fraGridRomaneiosLinhaimgOcorrenciaClick(
  Sender: TObject);
Var
  Romaneio : IRomaneio;
begin
  HabilitarRefreshAuto(False);

  Try
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  Except
    AtualizaListaEntregas;
    Sleep(200);
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  End;

  CarregarListaOcorrencias(Romaneio);

  fmxConsultaOcorrencias := TfmxConsultaOcorrencias.Create(Self);

  Try
    fmxConsultaOcorrencias.lblCaptionForm.Text := 'Ocorrências do Romaneio ' + Romaneio.NumeroRomaneio;
    fmxConsultaOcorrencias.RunningInTSPlus     := objFuncoes.RunningInTSPlus;
    fmxConsultaOcorrencias.UtilizaModoClassico := objFuncoes.UtilizaModoClassico;
    fmxConsultaOcorrencias.Romaneio := Romaneio;
    fmxConsultaOcorrencias.Height := Screen.WorkAreaHeight;
    fmxConsultaOcorrencias.Width  := Screen.WorkAreaWidth;
    fmxConsultaOcorrencias.ShowModal;
  Finally
    FreeAndNil(fmxConsultaOcorrencias);
    HabilitarRefreshAuto(True);
  End;
end;

procedure TfmxPainelEntregas.fraGridRomaneiosLinhaimgResolvidoClick(
  Sender: TObject);
Var
  Romaneio : IRomaneio;
  Frame    : TframeGridRomaneiosLinha;
begin
  HabilitarRefreshAuto(False);

  If (TaEntregue.fMensagem('Atenção!','A ocorrência desta entrega foi solucionada?', ['&Sim', '&Não']) = 1) Then
  Begin
    Try
      Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
    Except
      AtualizaListaEntregas;
      Sleep(200);
      Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
    End;

    If (Romaneio.Ocorrencias.Count <= 0) Then
      Romaneio.CarregaOcorrenciasRomaneio;

    Romaneio.AlteraStatusOcorrencia;

    Frame  := TframeGridRomaneiosLinha(FindComponent('Frame' + (TImage(Sender).Tag + 1).ToString));

    TImage(Sender).HitTest := False;
    TImage(Sender).Tag     := -1;
    TImage(Sender).Cursor  := crDefault;

    If (EntregaPausada(Romaneio)) Then
    Begin
      Frame.recFundoBranco.Fill.Color       := recLegendaPausada.Fill.Color;
      Frame.recFundoBranco.Stroke.Color     := recLegendaPausada.Stroke.Color;
      Frame.recFundoBranco.Stroke.Thickness := recLegendaPausada.Stroke.Thickness;
    End
    Else
    Begin
      Frame.recFundoBranco.Fill.Color := TAlphaColorRec.White;
      Frame.recFundoBranco.Stroke.Color := TAlphaColorRec.White;
      Frame.recFundoBranco.Stroke.Thickness := 0;
      TImage(Sender).Opacity := 0;
    End;

    TImage(Sender).Opacity := 0;
  End;

  HabilitarRefreshAuto(True);
end;

procedure TfmxPainelEntregas.fraGridRomaneiosLinhaimgRotaClick(Sender: TObject);
Var
  Romaneio        : IRomaneio;
  lstEndEntrega,
  lstEntregasDiv  : TStringlist;
  mapLinkPlan,
  mapLinkEfet     : TRetornoMaplinkTrip;
  fltTotDistancia : Double;
  intTotTempo     : integer;
  RotaGPX         : IRotaGPX;
  blnLoadRotaPlan,
  blnLoadRotaEfet : Boolean;
  jsonFile, strURL: String;
  recTotalRotas   : TTotalizaRotas;
begin
  If Not objFuncoes.CheckEdgeBrowser Then
  Begin
    MensagemInstalacaoWebView;
    Exit;
  End;

  mapLinkPlan := Nil;
  mapLinkEfet := Nil;

  pgbStatus.Value := 0;
  pgbStatus.Max   := 7;
  pStepStatusGravacao(pgbStatus, 'Aguarde... Carregando dados da entrega');

  geoLocalizacao.APIKey := strGoogleAPIKey;

  HabilitarRefreshAuto(False);

  Try
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  Except
    AtualizaListaEntregas;
    Sleep(200);
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  End;

  pStepStatusGravacao(pgbStatus, 'Aguarde... Atualizando documentos');
  CarregarListaDocumentos(Romaneio);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Atualizando informações das rotas');
  CarregarDadosRotas(Romaneio);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Listando endereços de entrega');
  lstEndEntrega := ListaEnderecosGeolocalizados(Romaneio, fltTotDistancia, intTotTempo);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Verificando entregas divergentes');
  lstEntregasDiv := ListaEntregasDivergentes(Romaneio);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Calculando rotas');

  pStepStatusGravacao(pgbStatus, 'Aguarde... Abrindo visualização das rotas');
  TaEntregue.pGravaLogUsoGoogleMaps(Romaneio.NumeroRomaneio, 'Abertura do Google Maps [Painel de Entregas]');

  Try
    If (objFuncoes.fCfgSis('APIROT', varString) = 'CITEL') Then
    Begin
      recTotalRotas.fltDistanciaPlanejada := fltTotDistancia;
      recTotalRotas.intTempoPlanejado     := intTotTempo;

      recTotalRotas.fltDistanciaEfetuada  := fltTotDistancia;
      recTotalRotas.intTempoEfetuada      := intTotTempo;

      jsonFile := objFuncoes.GerarArquivoJSON(Romaneio, lstEntregasDiv, recTotalRotas);

      strURL   := GetURLRotas(jsonFile,
                              Romaneio.NumeroRomaneio,
                              objFuncoes.RetCNPJEmpresa(Romaneio.EmpresaRomaneio));

      If Not strURL.IsEmpty Then
      Begin
        Romaneio.AlteraStatusRotaEfetuada;
        objFuncoes.BrowserNavigate(strURL, True);
      End;
    End

    Else If (objFuncoes.fCfgSis('APIROT', varString) = 'GOOGLE') Then
      AbrirMapaGoogle(Romaneio,
                      lstEndEntrega,
                      lstEntregasDiv,
                      fltTotDistancia,
                      intTotTempo)

    Else If (objFuncoes.fCfgSis('APIROT', varString) = 'MAPLINK') Then
    Begin
      blnLoadRotaPlan := True;
      blnLoadRotaEfet := True;

      For RotaGPX In Romaneio.RotasGPX Do
      Begin
        If (RotaGPX.TipoRota = tpPlanejada) Then
          blnLoadRotaPlan := False;

        If (RotaGPX.TipoRota = tpEfetuada) Then
          blnLoadRotaEfet := False;
      End;

      If (blnLoadRotaPlan) Then
        mapLinkPlan := Romaneio.fRetRotaPlanejada;

      If (blnLoadRotaEfet) And
         (objFuncoes.fCfgSis('TPROEF', varString) = 'S') Then
        mapLinkEfet := Romaneio.fRetRotaEfetuada;

      AbrirMapaMaplink(Romaneio,
                       lstEndEntrega,
                       lstEntregasDiv,
                       fltTotDistancia,
                       intTotTempo,
                       mapLinkPlan,
                       mapLinkEfet);
    End;

  Finally
    HabilitarRefreshAuto(True);
    TaEntregue.pGravaLogUsoGoogleMaps(Romaneio.NumeroRomaneio, 'Fechamento do Google Maps [Painel de Entregas]');
    recCarregando.Visible := False;
  End;
end;

procedure TfmxPainelEntregas.HabilitaDashboard;
begin
  If Assigned(objDash) Then
  Begin
    If (objDash.UtilizaDashboardWeb) Then
    Begin
      webDash := TTMSFNCWebBrowser.Create(Self);
      webDash.Color                := $FFE8E8E8;
      webDash.Align                := TAlignLayout.Client;
      webDash.Padding.Bottom       := 30;
      webDash.Margins.Bottom       := 0;
      webDash.Size.PlatformDefault := False;
      webDash.TabOrder             := 0;
      webDash.URL                  := 'about:blank';
      webDash.Parent               := layAbaDashboard;

      btnAbaDashboard.Visible      := True;
    End
    Else
      btnAbaDashboard.Visible      := False;
  End;
end;

procedure TfmxPainelEntregas.HabilitarAbaNova(Tab: TTabItem);
Var
  LLayoutBotao,
  LLayoutPrincipal : TLayout;
  LRectangle       : TRectangle;
begin
  DesabilitarAbaAtual;

  LLayoutBotao     := TLayout(FindComponent('layBotao' + Copy(tab.Name,4,30)));
  LLayoutPrincipal := TLayout(FindComponent('lay' + Copy(tab.Name,4,30)));
  LRectangle       := TRectangle(FindComponent('recBotao' + Copy(tab.Name,4,30)));

  LLayoutBotao.Opacity := 0.6;
  LRectangle.Visible   := True;

  tabPainelEntregas.ActiveTab := tab;
  LLayoutPrincipal.Visible := True;
  Application.ProcessMessages;
end;

procedure TfmxPainelEntregas.HabilitarBotoes(AHabilitar: Boolean);
begin
  btnAbaChat.Enabled       := AHabilitar;
  btnAbaDashboard.Enabled  := AHabilitar;
  btnAbaPainel.Enabled     := AHabilitar;
  btnAbaPendencias.Enabled := AHabilitar;
end;

procedure TfmxPainelEntregas.habilitarCursores;
Var
  LContador : Integer;
  LOpacity  : Single;
begin
  If objFuncoes.RunningInTSPlus Then
    LOpacity := 0
  Else
  Begin
    If objFuncoes.UtilizaModoClassico Then
      LOpacity := 0.7
    Else
      LOpacity := 0;
  End;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassNameIs('TLine')) Then
      If ContainsStr(TLine(Self.Components[LContador]).Name, 'Cursor') Then
        TLine(Self.Components[LContador]).Opacity := LOpacity;
  End;
end;

procedure TfmxPainelEntregas.HabilitarRefreshAuto(Ligar: Boolean);
begin
  TimerRefresh.Enabled := Ligar;
end;

procedure TfmxPainelEntregas.Image1Click(Sender: TObject);
begin
  if Not (edtMsg.Text.IsEmpty) Then
    edtMsgChange(edtMsg);
end;

procedure TfmxPainelEntregas.fraGridDocumentosLinhaimgDocsAssinaturasClick(
  Sender: TObject);
var
  soTrocaLayouts : Boolean;
  LIndice : Integer;
  LFrame  : TframeGridDocumentosLinha;
begin
  lstDocumentos.BeginUpdate;

  soTrocaLayouts := False;

  LIndice:= TImage(Sender).Tag + 1;
  LFrame := TframeGridDocumentosLinha(FindComponent('FrameDocs' + LIndice.ToString()));

  If Not (LFrame.TagString.IsEmpty) Then
    soTrocaLayouts := LFrame.TagString <> String(TImage(Sender).Name);

  if (soTrocaLayouts) Then
    TrocarLayoutLinha(Sender, lstDocumentos.ItemByIndex(TImage(Sender).Tag))
  else
    ExpandeLinha(Sender);

  AjustaGridDocumentos(false);

  lstDocumentos.EndUpdate;
end;

procedure TfmxPainelEntregas.fraGridDocumentosLinhaimgDocsCadCliClick(
  Sender: TObject);
Var
  Documento: IDocumento;
begin
  Documento := lstDocs.Items[TImage(Sender).Tag];
  Documento.Cliente.AbrirCadastro;
end;

procedure TfmxPainelEntregas.imgApagarClick(Sender: TObject);
begin
  edtPesquisaRecentes.Text := '';
  edtPesquisaRecentes.SetFocus;
end;

procedure TfmxPainelEntregas.imgApagarMouseEnter(Sender: TObject);
begin
  TImage(Sender).Opacity := 1;
end;

procedure TfmxPainelEntregas.imgApagarMouseLeave(Sender: TObject);
begin
  TImage(Sender).Opacity := 0.3;
end;

procedure TfmxPainelEntregas.imgCalDataFinDashClick(Sender: TObject);
begin
  calDataFinDash.Date       := StrToDate(edtDataFinDash.Text);
  calDataFinDash.Position.X := 0;
  calDataFinDash.Position.Y := 26;
  calDataFinDash.Visible    := Not calDataFinDash.Visible;
end;

procedure TfmxPainelEntregas.imgCalDataIniDashClick(Sender: TObject);
begin
  calDataIniDash.Date       := StrToDate(edtDataIniDash.Text);
  calDataIniDash.Position.X := 0;
  calDataIniDash.Position.Y := 26;
  calDataIniDash.Visible    := Not calDataIniDash.Visible;
end;

procedure TfmxPainelEntregas.imgCalFimClick(Sender: TObject);
begin
  calFim.Date       := StrToDate(edtDataFim.Text);
  calFim.Position.X := 0;
  calFim.Position.Y := 26;
  calFim.Visible := Not calFim.Visible;
end;

procedure TfmxPainelEntregas.imgCalIniClick(Sender: TObject);
begin
  calInicio.Date       := StrToDate(edtDataIni.Text);
  calInicio.Position.X := 0;
  calInicio.Position.Y := 26;
  calInicio.Visible    := Not calInicio.Visible;
end;

procedure TfmxPainelEntregas.imgDocsFotosClick(Sender: TObject);
var
  soTrocaLayouts : Boolean;
begin
  lstDocumentos.BeginUpdate;

  soTrocaLayouts := False;

  If Assigned(imgExpandida) Then
    soTrocaLayouts := (imgExpandida <> TImage(Sender));

  if (soTrocaLayouts) Then
    TrocarLayouts(Sender)
  else
    ExpandeTodasLinhas(Sender);

  AjustaGridDocumentos(true);

  lstDocumentos.EndUpdate;
end;

procedure TfmxPainelEntregas.imgNovaEntregaClick(Sender: TObject);
Var
  Romaneio : IRomaneio;
begin
  Try
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  Except
    AtualizaListaEntregas;
    Sleep(200);
    Romaneio := lstRomaneios.Items[TImage(Sender).Tag];
  End;

  Romaneio.AdicionarTarefa;
  pVerificaRotaRecalculada(Romaneio);
  Romaneio.CarregaDocumentos;

  AtualizaDocumentos(TImage(Sender).Tag);
end;

procedure TfmxPainelEntregas.pVerificaRotaRecalculada(Romaneio: IRomaneio);
var
  intQtdVerificacao: Integer;
begin
  intQtdVerificacao := 0;

  pStepStatusGravacao(pgbStatus, 'A rota está sendo recalculada. Aguarde...');
  try
    repeat
      if intQtdVerificacao = 3 then
      begin
        if (TaEntregue.fMensagem('Atenção!','A rota ainda não foi recalculada automaticamente!'+sLineBreak+
                                            'Deseja continuar aguardando?', ['&Sim', '&Não']) = 1) then
          intQtdVerificacao := 0;
      end;

      Inc(intQtdVerificacao);
      Sleep(1500);
    until ((Romaneio.RotaRecalculada) or (intQtdVerificacao > 3));
  finally
    recCarregando.Visible := False;
  end;
end;

{ -1 quando o romaneio aberto na grade de documentos nao esta mais na lista. }
function TfmxPainelEntregas.IndiceRomaneioDocumentos: Integer;
Var
  i: Integer;
begin
  Result := -1;
  For i := 0 to lstRomaneios.Count - 1 do
    If (lstRomaneios.Items[i].NumeroRomaneio = FNumeroRomaneioDocumentos) Then
      Exit(i);
end;

procedure TfmxPainelEntregas.imgReordenarEntregasClick(Sender: TObject);
Var
  Romaneio    : IRomaneio;
  LTela       : TfmxReordenarEntregas;
  LConfirmou  : Boolean;
  LRecalculou : Boolean;
  LAplicou    : Boolean;
  LMudancas   : TArray<TMudancaOrdem>;
  LMotivo     : String;
  LIndice     : Integer;
begin
  { O refresh automatico recria lstRomaneios, e o timer dispara durante o
    ShowModal e as mensagens. Fica desligado no fluxo todo; a grade de
    documentos ja trabalha sem ele, e imgVoltarClick o religa. }
  HabilitarRefreshAuto(False);

  { Pelo numero, e nao pelo indice da grade: esta acao grava a rota e notifica o
    motorista, e um indice velho (lista refeita pelo filtro) apontaria para outro
    romaneio. Sem o romaneio aberto na lista, aborta. }
  Romaneio := nil;
  LIndice  := IndiceRomaneioDocumentos;
  If (LIndice >= 0) Then
    Romaneio := lstRomaneios.Items[LIndice];

  If (Not Assigned(Romaneio)) Then
  Begin
    TaEntregue.fMensagem('Atenção!', 'Não foi possível localizar o romaneio ' + FNumeroRomaneioDocumentos +
                                     ' na lista. Volte à lista de romaneios e abra os documentos novamente.', ['&OK']);
    Exit;
  End;

  { Abre sobre os documentos que a grade ja carregou, sem ir ao banco: recarregar
    aqui deixava a tela lenta para abrir. O risco de estarem velhos e tratado na
    confirmacao (TfmxReordenarEntregas.AplicarMudancas). }
  CarregarListaDocumentos(Romaneio);

  If (Not TfmxReordenarEntregas.PodeReordenar(Romaneio, LMotivo)) Then
  Begin
    TaEntregue.fMensagem('Atenção!', LMotivo, ['&OK']);
    Exit;
  End;

  LTela := TfmxReordenarEntregas.Create(Self);
  Try
    LTela.StyleBook        := Self.StyleBook;
    LTela.RunningInTSPlus  := objFuncoes.RunningInTSPlus;
    LTela.Romaneio         := Romaneio;

    LTela.ShowModal;

    LConfirmou := (LTela.ModalResult = mrOk);
    LMudancas  := LTela.Mudancas;
  Finally
    { Destruir antes do trabalho pesado, nao depois: enquanto a tela existe o
      painel ainda esta retomando o foco, e o overlay de aguarde nao aparece. }
    FreeAndNil(LTela);
  End;

  If (Not LConfirmou) or (Length(LMudancas) = 0) Then
    Exit;

  If (TaEntregue.fMensagem('Atenção!', 'Recalcular a rota com a nova ordem e notificar o motorista no aplicativo?',
                           ['&Sim', '&Não']) <> 1) Then
    Exit;

  pgbStatus.Value := 0;
  pgbStatus.Max   := 3;

  Try
    recCarregando.BringToFront;
    pStepStatusGravacao(pgbStatus, 'Aguarde... Conferindo as entregas do romaneio');

    Romaneio.CarregaDocumentos;
    Try
      LAplicou := TfmxReordenarEntregas.AplicarMudancas(Romaneio, LMudancas);

      pStepStatusGravacao(pgbStatus, 'Aguarde... Recalculando a rota com a nova ordem');

      If LAplicou Then
        LRecalculou := Romaneio.AtualizaRotaComRetorno
      Else
        LRecalculou := False;
    Finally
      { Recarregar mesmo na falha, inclusive com excecao (pMensagensErro relanca
        depois do rollback): AplicarMudancas alterou a ordem em memoria, e
        AtualizaRota le de la. Se ela ficasse diferente do banco, a proxima
        chamada gravaria e notificaria o motorista sem o operador confirmar. }
      pStepStatusGravacao(pgbStatus, 'Aguarde... Atualizando os documentos');
      Romaneio.CarregaDocumentos;

      LIndice := IndiceRomaneioDocumentos;
      If (LIndice >= 0) Then
        AtualizaDocumentos(LIndice);
    End;
  Finally
    recCarregando.Visible := False;
  End;

  If (Not LAplicou) Then
    TaEntregue.fMensagem('Atenção!', 'O romaneio foi alterado enquanto a reordenação estava aberta (entrega iniciada, baixada ou rota recalculada). '+
                                     'Nada foi gravado. Abra a reordenação novamente.', ['&OK'])
  Else If LRecalculou Then
    TaEntregue.fMensagem('Rota recalculada', 'A nova ordem foi gravada e o motorista será notificado no aplicativo.', ['&OK'])
  Else
    TaEntregue.fMensagem('Atenção!', 'Não foi possível recalcular a rota. A ordem das entregas não foi alterada.', ['&OK']);
end;

procedure TfmxPainelEntregas.imgVoltarClick(Sender: TObject);
begin
  AnimarAguarde(layGridDocs);
  FecharTelaDocumentos;
  CalculaAlturaBarraRolagem;
  AnimarAguarde(layGridDocs, False);
  HabilitarRefreshAuto(True);
end;

function TfmxPainelEntregas.ListaEnderecosGeolocalizados(Romaneio: IRomaneio;
  Var TotDistancia: Double; Var TotTempo: Integer): TStringlist;
Var
  Documento      : IDocumento;
  strEndereco,
  strCoordenada  : String;
  MapsCoordinate : TTMSFNCMapsCoordinateRec;
begin
  Result := TStringList.Create;

  TotDistancia := 0;
  TotTempo     := 0;

  For Documento in Romaneio.Documentos Do
  Begin
    strEndereco := Documento.EnderecoEntrega.Endereco + ' - ' +
                   Documento.EnderecoEntrega.Bairro + ', ' +
                   Documento.EnderecoEntrega.Cidade + ' - ' +
                   Documento.EnderecoEntrega.Uf + ', ' +
                   Documento.EnderecoEntrega.Cep;

    If (Documento.EnderecoEntrega.Coordenadas.IsEmpty) Then
    Begin
      If Not Documento.EnderecoEntrega.Endereco.IsEmpty Then
      Begin
        MapsCoordinate := geolocalizacao.GetGeocodingSync(strEndereco);

        TaEntregue.pGravaLogUsoGoogleMaps(Romaneio.NumeroRomaneio, 'Consulta Api Geocoding [Painel de Entregas]');

        strCoordenada  := MapsCoordinate.Latitude.ToString().Replace(',','.') + ',' +
                          MapsCoordinate.Longitude.ToString().Replace(',','.');

        If Not Documento.EnderecoEntrega.EnderecoAlterado Then
          Documento.SalvarCoordenadaGeografica(Romaneio.NumeroRomaneio, Romaneio.EmpresaRomaneio, strCoordenada);
      End
      Else
      Begin
        If Documento.EspecieDocumento = 'OX' Then
          strCoordenada := Romaneio.PontoChegada.Coordenadas;
      End;
    End
    Else
      strCoordenada  := Documento.EnderecoEntrega.Coordenadas;

    TotDistancia := TotDistancia + Documento.PercursoKm;
    TotTempo     := TotTempo + Documento.TempoPercurso;

    index := Result.IndexOf(strEndereco);

    If (index = -1) Then
    Begin
      Result.Add(strCoordenada + '|' +
                 strEndereco + '|' +
                 StatusToStr(Documento.StatusDocumento) + '|' +
                 Documento.RotaOrdem + '|' +
                 Documento.EnderecoEntrega.Cep + '|' +
                 Documento.Cliente.NomeCliente + '|' +
                 DatetimeToStr(Documento.DataHoraBaixaEntrega));
    End;
  End;

  TotDistancia := TotDistancia + Romaneio.DistanciaRetorno;
  TotTempo     := TotTempo + Romaneio.TempoRetorno;
end;

function TfmxPainelEntregas.ListaEntregasDivergentes(
  Romaneio: IRomaneio): TStringlist;
Var
  Documento      : IDocumento;
  strEndereco,
  strEntPrevista,
  strEntEfetuada : String;
  Distancia      : Double;
  MapsCoordinate : TTMSFNCMapsCoordinateRec;
begin
  Result := TStringList.Create;

  For Documento in Romaneio.Documentos Do
  Begin
    If Assigned(Documento.PontoEntregaEfetuada) Then
    Begin
      If Not Assigned(Documento.PontoEntregaPrevista) Then
      Begin
        strEndereco := Documento.EnderecoEntrega.Endereco + ' - ' +
                       Documento.EnderecoEntrega.Bairro + ', ' +
                       Documento.EnderecoEntrega.Cidade + ' - ' +
                       Documento.EnderecoEntrega.Uf + ', ' +
                       Documento.EnderecoEntrega.Cep;

        MapsCoordinate := geolocalizacao.GetGeocodingSync(strEndereco);

        TaEntregue.pGravaLogUsoGoogleMaps(Romaneio.NumeroRomaneio, 'Consulta Api Geocoding [Painel de Entregas]');

        strEntPrevista := MapsCoordinate.Latitude.ToString().Replace(',','.') + ',' +
                          MapsCoordinate.Longitude.ToString().Replace(',','.');
      End
      Else
        strEntPrevista := Documento.PontoEntregaPrevista.Coordenadas;

      Distancia := MeasureDistance(objFuncoes.StrToCoordinate(strEntPrevista),
                                   objFuncoes.StrToCoordinate(Documento.PontoEntregaEfetuada.Coordenadas));

      If (Distancia > 150) Then
      Begin
        strEntEfetuada := geolocalizacao.GetReverseGeocodingSync(objFuncoes.StrToCoordinate(Documento.PontoEntregaEfetuada.Coordenadas));

        TaEntregue.pGravaLogUsoGoogleMaps(Romaneio.NumeroRomaneio, 'Consulta Api Geocoding [Entrega Divergente - Painel de Entregas]');

        Result.Add(Documento.PontoEntregaEfetuada.Coordenadas + '|' +
                   '*** ' + strEntEfetuada + '|' +
                   StatusToStr(Documento.StatusDocumento) + '|' +
                   Documento.RotaOrdem + '|' +
                   Documento.EnderecoEntrega.Cep + '|' +
                   Documento.Cliente.NomeCliente + '|' +
                   DatetimeToStr(Documento.DataHoraBaixaEntrega));
      End;
    End;
  End;
end;

procedure TfmxPainelEntregas.lstRecentesKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn : SelecionaRecente(lstRecentes.ItemByIndex(lstRecentes.ItemIndex));
  End;
end;

function TfmxPainelEntregas.Mascara(edt, str: String): string;
var
  i : integer;
begin
  for i := 1 to Length(edt) do
  begin
     if (str[i] = '9') and
        (not CharInSet(edt[i], ['0'..'9'])) and
        (Length(edt)=Length(str) + 1) then
       delete(edt,i,1);
     if (str[i] <> '9') and CharInSet(edt[i], ['0'..'9']) then
       insert(str[i],edt, i);
  end;
  result := edt;
end;

procedure TfmxPainelEntregas.MensagemInstalacaoWebView;
begin
  FmxMensagemInstalacaoWebView := TFmxMensagemInstalacaoWebView.Create(Self);
  FmxMensagemInstalacaoWebView.objFuncoes := objFuncoes;
  FmxMensagemInstalacaoWebView.memMensagem.Lines.Clear;
  FmxMensagemInstalacaoWebView.memMensagem.Lines.Add('As bibliotecas de utilização do Google Maps não estão instaladas.');
  FmxMensagemInstalacaoWebView.memMensagem.Lines.Add('Por favor, efetue a instalação antes de prosseguir!');
  FmxMensagemInstalacaoWebView.ShowModal;

  FreeAndNil(FmxMensagemInstalacaoWebView);
end;

procedure TfmxPainelEntregas.MostrarFiltros;
begin
  // Se os filtros estiverem desligados, então LIGA
  If (recBotaoFiltros.Tag = 0) Then
  begin
    recBotaoFiltros.Tag          := 1;
    recBotaoFiltros.Stroke.Color := azulCitel;
    recBotaoFiltros.Fill.Color   := TAlphaColorRec.White;
    layFiltros.Visible           := True;
    imgFiltrosON.Opacity         := 1;
    imgFiltrosOFF.Opacity        := 0;

    edtPesquisa.SetFocus;
  end

  // Se os filtros estiverem ligados, então DESLIGA
  else if (recBotaoFiltros.Tag = 1) Then
  begin
    recBotaoFiltros.Tag          := 0;
    recBotaoFiltros.Stroke.Color := TAlphaColor($FFA2A2A2);
    recBotaoFiltros.Fill.Color   := TAlphaColor($FFE8E8E8);
    layFiltros.Visible           := False;
    imgFiltrosON.Opacity         := 0;
    imgFiltrosOFF.Opacity        := 1;
  end;
end;

procedure TfmxPainelEntregas.MoveCursor(Sender: TObject; Key: Word);
Var
  LText: String;
  LEdit: TEdit;
  LCursor: TLine;
  LFatorAjuste: Double;
begin
  LEdit   := TEdit(Sender);
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LFatorAjuste := 2.5;

  LEdit.Canvas.Font.Family := LEdit.Font.Family;
  LEdit.Canvas.Font.Size   := Ledit.Font.Size;

  PiscaCursor(LEdit);

  Case Key Of
    vkEnd  : LCursor.Position.X := LEdit.Canvas.TextWidth(LEdit.Text) + LFatorAjuste;
    vkHome : LCursor.Position.X := LFatorAjuste;

    vkLeft, vkRight, vkNone:
    Begin
      If Key = vkLeft Then
        LText := Copy(LEdit.Text, 1, (LEdit.CaretPosition - 1))
      Else If Key = vkRight Then
        LText := Copy(LEdit.Text, 1, (LEdit.CaretPosition + 1))
      Else
        LText := Copy(LEdit.Text, 1, (LEdit.CaretPosition));

      If (RightStr(LText, 1) = ' ') Then
        LText := Copy(LText, 1, LText.Length - 1) + '.';

      LCursor.Position.X := LEdit.Canvas.TextWidth(LText) + LFatorAjuste;
    End;
  End;
end;

procedure TfmxPainelEntregas.MudarAbaSegura(Acao: TProc);
begin
  if FProcessandoMudancaAba then
    Exit;

  FProcessandoMudancaAba := True;
  HabilitarBotoes(False);
  try
    Acao();
  finally
    tmrHabilitarBotoes.Enabled := True;
  end;
end;

procedure TfmxPainelEntregas.NotificaNovasMensagens(PeloTimer: Boolean = False);
begin
  if Not Assigned(Chat) then
  Begin
    if Not strLoginUsuarioLogado.IsEmpty Then
      CarregaChat
    else
      Exit;
  End;

  Chat.VerificaNovasMensagens(strLoginUsuarioLogado);

  frameNotificacaoChat.Visible := Chat.QuantidadeNovasMensagens <> 0;

  if intQtdNovasMensagens <> Chat.QuantidadeNovasMensagens then
  begin
    intQtdNovasMensagens := Chat.QuantidadeNovasMensagens;
    frameNotificacaoChat.lblQtde.Text := IntToStr(Chat.QuantidadeNovasMensagens);

    if (PeloTimer) Then
      CarregaChat;
  end;
end;

procedure TfmxPainelEntregas.NovoChat(Contato: IContato);
begin
  TelaDefault(false);

  ContatoAberto     := Contato;
  lstChat.TagString := 'NovaConversa';

  CarregaMensagens;

  If (ExisteChatComEsseContato(Contato)) Then
    SelecionaRecente(TListBoxItem(FindComponent('lstIteConversasRecentes' + Contato.CodigoContato)))
  else
    lstRecentes.ItemIndex := -1;

  edtMsg.SetFocus;
end;

procedure TfmxPainelEntregas.OnWork(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;

function TfmxPainelEntregas.PaineldeEntregasEstaVisivel: Boolean;
begin
  Result := False;

  If (tabPainelEntregas.ActiveTab = tabAbaPainel) Then
    If (layGridEntregas.Visible) Then
      Result := True;
end;

procedure TfmxPainelEntregas.PiscaCursor(Sender: TObject);
Var
  LCursor: TLine;
begin
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LCursor.Tag := 1;
end;

procedure TfmxPainelEntregas.preencheTotais(intRomaneios, intEntregas, intConcluidos, intNaoIniciado,
      intACaminho, intFinalizados, intPendencia : Integer);
Var
  LPerConcluido : Double;
begin
  If (intRomaneios > 0) Then
  Begin
    LPerConcluido := (intConcluidos * 100) / intEntregas;

    lblValorTotalRomaneios.Text        := intRomaneios.ToString;
    lblValorTotalEntregas.Text         := intEntregas.ToString;
    lblValorDocsConcluidos.Text        := intConcluidos.ToString + '/' + intEntregas.ToString;

    If (Frac(LPerConcluido) = 0) Then
      lblPorcentagemDocsConcluidos.Text  := FormatFloat('#0', LPerConcluido) + '%'
    Else
      lblPorcentagemDocsConcluidos.Text  := FormatFloat('#,##0.00', LPerConcluido) + '%';

    recPorcentagemDocsConcluidos.Width := (LPerConcluido * (recProgressBordaDocsConcluidos.Width - 2)) / 100;
    cbxFinalizada.Text                 := 'Finalizada (' + FormatFloat('#0', intFinalizados) + ')';
    cbxEmAndamento.Text                := 'Em Andamento (' + FormatFloat('#0', intACaminho) + ')';
    cbxNaoIniciada.Text                := 'Não Iniciada (' + FormatFloat('#0', intNaoIniciado) + ')';
    cbxTemPendencia.Text               := 'Tem Pendência (' + FormatFloat('#0', intPendencia) + ')';
  End
  Else
  Begin
    lblValorTotalRomaneios.Text        := '';
    lblValorTotalEntregas.Text         := '';
    lblValorDocsConcluidos.Text        := '';
    lblPorcentagemDocsConcluidos.Text  := '';
    recPorcentagemDocsConcluidos.Width := 0;
    cbxFinalizada.Text                 := 'Finalizada';
    cbxEmAndamento.Text                := 'Em Andamento';
    cbxNaoIniciada.Text                := 'Não Iniciada';
    cbxTemPendencia.Text               := 'Tem Pendência';
  End;
end;

procedure TfmxPainelEntregas.pStepStatusGravacao(pgbStatus: TProgressBar;
  strInformacao: String);
Var
  fltPerc : Double;
begin
  If Not recCarregando.Visible Then
  Begin
    recCarregando.Visible  := True;
    recProgressValue.Width := 0;
  End;

  pgbStatus.Value := pgbStatus.Value + 1;
  lblInfo.Text    := strInformacao;

  fltPerc := (pgbStatus.Value * 100) / pgbStatus.Max;

  If (fltPerc < 90) Then
    recProgressValue.Corners := [TCorner.BottomLeft]
  Else
    recProgressValue.Corners := [TCorner.BottomLeft, TCorner.BottomRight];

  recProgressValue.Width := (fltPerc * recProgressFundo.Width) / 100;
  lblPercProgresso.Text := SimpleRoundTo(fltPerc, 0).ToString + '%';

  Application.ProcessMessages;
end;

procedure TfmxPainelEntregas.recBotaoFiltrosClick(Sender: TObject);
begin
  MostrarFiltros;
end;

function TfmxPainelEntregas.RetornaStatus(Status: IStatus): String;
begin
  case status of
    rmFinalizado:   Result := 'FINALIZADO';
    rmNaoIniciado:  Result := 'NAO INICIADO';
    rmACaminho:     Result := 'EM TRANSITO';
    rmNaoEntregue:  Result := 'NAO ENTREGUE';
    rmTemPendencia: Result := 'TEM PENDENCIA';
  end;
end;

function TfmxPainelEntregas.RetornaTimeStampEmMilisegundos: Int64;
var
  LDateTime: TDateTime;

  LDataServidor,
  LHoraServidor: TDateTime;
begin
  Try
    raise Exception.Create('Se conexao com banco de dados ...');

    LDateTime := EncodeDate(YearOf(LDataServidor), MonthOf(LDataServidor), DayOf(LDataServidor)) +
                 EncodeTime(HourOf(LHoraServidor), MinuteOf(LHoraServidor), SecondOf(LHoraServidor), MilliSecondOf(LHoraServidor));
    Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
  Except
    Result := MilliSecondsBetween(GetUTC(System.SysUtils.Now), UnixDateDelta);
  End;
end;

function TfmxPainelEntregas.RetornaSituacaoRomaneio(Romaneio: IRomaneio): Integer;
begin
  Result := 0;

  If EntregaEmNaoConformidade(Romaneio) Then
    Result := 1;

  If EntregaPausada(Romaneio) Then
    Result := 2;
end;

procedure TfmxPainelEntregas.SelecionaRecente(Sender: TObject);
Var
  LFrame : TframeConversasRecentes;
begin
  TelaDefault(False);

  lstRecentes.ItemIndex := TListBoxItem(Sender).Index;

  ContatoAberto := Chat.ContatosRecentes[lstRecentes.Selected.Tag];
  CarregaMensagens;

  lstChat.ScrollToItem(lstChat.ItemByIndex(lstChat.Items.Count - 1));

  lstRecentes.BeginUpdate;

  LFrame                          := TframeConversasRecentes(FindComponent('frameConversasRecentes' + TListBoxItem(Sender).TagString));
  LFrame.frameNotificacao.Visible := False;
  LFrame.lblPeriodo.Visible       := True;

  lstRecentes.EndUpdate;

//  CodigoContatoSelecionado := lstRecentes.Selected.TagString;

  edtMsg.SetFocus;

  NotificaNovasMensagens;
end;

function TfmxPainelEntregas.StatusToStr(Status: IStatus): String;
begin
  case status of
    rmFinalizado  : Result := 'Finalizada';
    rmNaoIniciado : Result := 'NaoIniciada';
    rmACaminho    : Result := 'EmAndamento';
    rmNaoEntregue : Result := 'NaoEntregue';
    rmTemPendencia: Result := 'TemPendencia';
  end;
end;

procedure TfmxPainelEntregas.TelaDefault(Mostrar: boolean);
begin
  If (Not Mostrar) Then
  Begin
    if (recSemMensagem.Visible) Then
    Begin
      recTopoChat.Visible     := True;
      lstChat.Opacity         := 1;
      recFundoMsgChat.Visible := True;

      recSemMensagem.Visible  := False;
    End;
  End
  Else
  Begin
    recTopoChat.Visible     := False;
    lstChat.Opacity         := 0;
    recFundoMsgChat.Visible := False;

    recSemMensagem.Visible  := True;
  End;
end;

function TfmxPainelEntregas.TemItensSelecionadosParaLiberacao: Boolean;
Var
  Documento : IDocumento;
begin
  Result := False;

  for Documento in Pendencias.DocsComItensBaixadosParcialmente do
  begin
    if fDocumentoComItemMarcadoParaLiberacao(Documento) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TfmxPainelEntregas.TimerChatTimer(Sender: TObject);
begin
  NotificaNovasMensagens(True);
  AtualizaQtdePendencias;
end;

procedure TfmxPainelEntregas.TimerRefreshTimer(Sender: TObject);
begin
  If Assigned(TaEntregueRefresh) Then
  Begin
    If TaEntregueRefresh.fHabilitaAtualizacaoAutomatica Then
    Begin
      recTravaTela.Visible := True;
      AtualizaEntregas;
      recTravaTela.Visible := False;
    End
    Else
      HabilitarRefreshAuto(False);
  End;
end;

procedure TfmxPainelEntregas.TimerTimer(Sender: TObject);
Var
  LCursor: TLine;
begin
  LCursor := RetornaCursorDoEditFocado;

  If Assigned(LCursor) Then
  Begin
    If (LCursor.Tag = 0) Then
      LCursor.Visible := False

    Else If (LCursor.Tag = 1) Then
      LCursor.Visible := Not LCursor.Visible;
  End;
end;

procedure TfmxPainelEntregas.tmrHabilitarBotoesTimer(Sender: TObject);
begin
  tmrHabilitarBotoes.Enabled := False;
  FProcessandoMudancaAba     := False;
  HabilitarBotoes(True);
end;

procedure TfmxPainelEntregas.TrocarLayoutLinha(Sender: TObject; ListItem : TListBoxItem);
Var
  LFrame: TframeGridDocumentosLinha;
  LImage: TImage;
begin
  LFrame := TframeGridDocumentosLinha(FindComponent('FrameDocs' + (ListItem.Index + 1).ToString()));
  LImage := TImage(LFrame.FindComponent(String(TImage(Sender).Name)));

  If (ListItem.Height > 40) Then
  Begin
    LFrame.TagString := String(TImage(Sender).Name);
    EsconderLayouts(LFrame);
    AbrirQuadro(LImage, LFrame);
  End;
end;

procedure TfmxPainelEntregas.TrocarLayouts(Sender: TObject);
Var
  x     : Integer;
begin
  For x := 1 to lstDocumentos.Count do
  Begin
    TrocarLayoutLinha(Sender, lstDocumentos.ItemByIndex(x-1));
    imgExpandida := TImage(Sender);
  End;
end;

procedure TfmxPainelEntregas.ValidaDataPreenchida(Sender: TObject);
begin
  If (TEdit(Sender).Text.IsEmpty) Then
  Begin
    Showmessage('Informe a data');
    Exit;
  End;
end;

procedure TfmxPainelEntregas.ValidaFormatoData(Sender: TObject);
Var
  mostrarMensagem: Boolean;
begin
  mostrarMensagem := False;

  If (Length(TEdit(Sender).Text) < 6) Then
    mostrarMensagem := True;

  If (Length(TEdit(Sender).Text) = 7) Then
    mostrarMensagem := True;

  if (mostrarMensagem) Then
  begin
    Showmessage('Formato de data inválido. Siga o padrão XX/XX/XXXX');
    Exit;
  End;
end;

procedure TfmxPainelEntregas.WebBrowserLoading;
begin
  WebBrowserNavigate('https://dashboard.citelsoftware.com.br/loading.html');
end;

procedure TfmxPainelEntregas.WebBrowserNavigate(url: String);
begin
  webDash.BeginUpdate;
  webDash.URL := url;
  webDash.Navigate;
  webDash.EndUpdate;
end;

end.


