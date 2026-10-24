unit Principal.View.FMXPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.ImageList, FMX.ImgList,
  FMX.Objects, FMX.Ani, FMX.Edit, FMX.MultiView, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  Fmx.Bind.GenData, Data.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope, System.DateUtils, FMX.TreeView, FMX.ListBox, FMX.Menus,
  FMX.ExtCtrls, Principal.View.Interfaces, System.Actions, FMX.ActnList,
  System.StrUtils, FMX.ScrollBox, FMX.SearchBox, Data.Bind.DBScope, Data.DB,
  Datasnap.DBClient, Winapi.Windows, FMX.Platform.Win, FMX.Effects, FMX.Grid,
  Fmx.Bind.Grid, Data.Bind.Grid, Math, FMX.Platform, Principal.View.FMXSobre,
  Principal.View.FMXCRM, Principal.View.FMXNotificacao, Winapi.Messages,
  Principal.View.FMXDashboardOld, Shared.Functions.DataSet, Shared.Functions.Core,
  FMX.DateTimeCtrls, Principal.View.FMXPainelEntregas, TaEntregue.Romaneios.Interfaces,
  FMX.TMSFNCCustomComponent, FMX.TMSFNCPopup, FMX.Filter.Effects,
  Principal.View.FMXQuadroLicencas;

type
  TArrayListaPesquisa = Array Of Array Of String;

  TfmxMenu = class(TForm)
    layToolBar: TLayout;
    btnMessages: TSpeedButton;
    imgMessages: TImage;
    btnSettings: TSpeedButton;
    imgSettings: TImage;
    btnInformation: TSpeedButton;
    imgSobre: TImage;
    btnLogout: TSpeedButton;
    imgLogoff: TImage;
    shaSearch: TRoundRect;
    edtSearch: TEdit;
    mviMenuLateral: TMultiView;
    estilos: TStyleBook;
    lstIcones: TImageList;
    lblSaudacao: TLabel;
    imgLogoFundo: TImage;
    layBody: TLayout;
    layMenuTopo: TLayout;
    pnlFundoMenuTopo: TPanel;
    btnMenuTopo1: TSpeedButton;
    linTopo: TLine;
    linRodape: TLine;
    pnlNotificacoes: TRoundRect;
    lblNotificacoes: TLabel;
    layLateral: TLayout;
    btnMenuTopo8: TSpeedButton;
    btnEmail: TSpeedButton;
    imgEmail: TImage;
    imgLogo: TImage;
    layRodapeEscondido: TLayout;
    imgSeta: TImage;
    laySetaAbrirMenuLateral: TLayout;
    layFundo: TLayout;
    imgmnuFatResumoCaixa: TImage;
    imgmnuCadClientes: TImage;
    imgmnuFatPedido: TImage;
    imgmnuCadProdutos: TImage;
    imgmnuFatOrcamento: TImage;
    flwLayMenuLateral: TFlowLayout;
    layIconeClientes: TLayout;
    layIconeProdutos: TLayout;
    layIconeOrcamentos: TLayout;
    layIconePedidos: TLayout;
    layIconeResumoCaixa: TLayout;
    layIconesMenuLateral: TLayout;
    lblPesquisa: TLabel;
    lblTesteCores: TLabel;
    cbbTesteCores: TComboBox;
    lsbxMenuCentral: TListBox;
    popMenuCentral: TPopup;
    btnVoltar: TSpeedButton;
    imgVoltar: TImage;
    lsbxItemModelo: TListBoxItem;
    flwLayBreadcrumb: TFlowLayout;
    recFundoMenu: TRectangle;
    btnMenuTopo5: TSpeedButton;
    btnMenuTopo6: TSpeedButton;
    btnMenuTopo7: TSpeedButton;
    btnMenuTopo4: TSpeedButton;
    btnMenuTopo3: TSpeedButton;
    btnMenuTopo2: TSpeedButton;
    linRodapeBreadcrumb: TLine;
    layMenuCentral: TLayout;
    recFundoMenuBreadcrumb: TRectangle;
    btnFecharMenu: TSpeedButton;
    imgFecharMenu: TImage;
    lblBreadcrumbMenu1: TLabel;
    lblBreadcrumbMenu2: TLabel;
    lblBreadcrumbMenu3: TLabel;
    lblBreadcrumbMenu4: TLabel;
    lblBreadcrumbMenu5: TLabel;
    lblBreadcrumbMenu6: TLabel;
    recFundoMenuLateral: TRectangle;
    layRecentes: TLayout;
    lbxAcessosRecentes: TListBox;
    lsbxGrupoRecentes: TListBoxItem;
    imgGrupoRecentes: TImage;
    lsbxRecente1: TListBoxItem;
    imgRecente1: TImage;
    lblRecente1: TLabel;
    lsbxRecente2: TListBoxItem;
    imgRecente2: TImage;
    lblRecente2: TLabel;
    lsbxRecente3: TListBoxItem;
    imgRecente3: TImage;
    lblRecente3: TLabel;
    lsbxRecente4: TListBoxItem;
    imgRecente4: TImage;
    lblRecente4: TLabel;
    lsbxRecente5: TListBoxItem;
    imgRecente5: TImage;
    lblRecente5: TLabel;
    lsbxRecente6: TListBoxItem;
    imgRecente6: TImage;
    lblRecente6: TLabel;
    lsbxRecente7: TListBoxItem;
    imgRecente7: TImage;
    lblRecente7: TLabel;
    lsbxRecente8: TListBoxItem;
    imgRecente8: TImage;
    lblRecente8: TLabel;
    lsbxRecente9: TListBoxItem;
    imgRecente9: TImage;
    lblRecente9: TLabel;
    lsbxRecente10: TListBoxItem;
    imgRecente10: TImage;
    lblRecente10: TLabel;
    recFundoRecentes: TRectangle;
    linRodapeRecentes: TLine;
    linTopoRecentes: TLine;
    layFavoritos: TLayout;
    lbxFavoritos: TListBox;
    lsbxGrupoFavoritos: TListBoxItem;
    imgGrupoFavoritos: TImage;
    lsbxFavorito1: TListBoxItem;
    imgFavorito1: TImage;
    lblFavorito1: TLabel;
    lsbxFavorito2: TListBoxItem;
    imgFavorito2: TImage;
    lblFavorito2: TLabel;
    lsbxFavorito3: TListBoxItem;
    imgFavorito3: TImage;
    lblFavorito3: TLabel;
    lsbxFavorito4: TListBoxItem;
    imgFavorito4: TImage;
    lblFavorito4: TLabel;
    lsbxFavorito5: TListBoxItem;
    imgFavorito5: TImage;
    lblFavorito5: TLabel;
    lsbxFavorito6: TListBoxItem;
    imgFavorito6: TImage;
    lblFavorito6: TLabel;
    lsbxFavorito7: TListBoxItem;
    imgFavorito7: TImage;
    lblFavorito7: TLabel;
    lsbxFavorito8: TListBoxItem;
    imgFavorito8: TImage;
    lblFavorito8: TLabel;
    lsbxFavorito9: TListBoxItem;
    imgFavorito9: TImage;
    lblFavorito9: TLabel;
    lsbxFavorito10: TListBoxItem;
    imgFavorito10: TImage;
    lblFavorito10: TLabel;
    recFundoFavoritos: TRectangle;
    linRodapeFavoritos: TLine;
    linTopoFavoritos: TLine;
    scrBarraRolagemLateral: TVertScrollBox;
    btnNews: TSpeedButton;
    imgNews: TImage;
    lblBanco: TLabel;
    layInformacoes: TLayout;
    imgIconDatabase: TImage;
    lblIP: TLabel;
    imgIconPin: TImage;
    lblConexao: TLabel;
    imgIconConexao: TImage;
    actAtalhos: TActionList;
    actManCadastros: TAction;
    actFaturamento: TAction;
    actTeleatendimento: TAction;
    actFinanceiro: TAction;
    actCancelamentoDocumentos: TAction;
    actLivroFiscal: TAction;
    actMovItens: TAction;
    actFechamentosMensais: TAction;
    actTintaDeMaquina: TAction;
    actContabilidade: TAction;
    actCRM: TAction;
    actFavorito1: TAction;
    actFavorito2: TAction;
    actFavorito3: TAction;
    actFavorito4: TAction;
    actFavorito5: TAction;
    actFavorito6: TAction;
    actFavorito7: TAction;
    actFavorito8: TAction;
    actFavorito9: TAction;
    actFavorito10: TAction;
    actRecente1: TAction;
    actRecente2: TAction;
    actRecente3: TAction;
    actRecente4: TAction;
    actRecente5: TAction;
    actRecente6: TAction;
    actRecente7: TAction;
    actRecente8: TAction;
    actRecente9: TAction;
    actRecente10: TAction;
    actPesquisar: TAction;
    actNews: TAction;
    actEmail: TAction;
    actMessages: TAction;
    actSettings: TAction;
    actInformation: TAction;
    actLogout: TAction;
    actRodapeClientes: TAction;
    actRodapeProdutos: TAction;
    actRodapeOrcamentos: TAction;
    actRodapePedidos: TAction;
    actRodapeCaixa: TAction;
    actMenuTopo1: TAction;
    actMenuTopo2: TAction;
    actMenuTopo3: TAction;
    actMenuTopo4: TAction;
    actMenuTopo5: TAction;
    actMenuTopo6: TAction;
    actMenuTopo7: TAction;
    actMenuTopo8: TAction;
    grdPesquisa: TGrid;
    colIcone: TStringColumn;
    ColDescricao: TStringColumn;
    layGridPesquisa: TLayout;
    linLeft: TLine;
    linRight: TLine;
    linBottom: TLine;
    imgPrincipal: TImage;
    linSearchCursor: TLine;
    edtFoco: TEdit;
    lblMensagemTEF: TLabel;
    imgIconCard: TImage;
    layMenuLateral: TLayout;
    mnuFaturamento: TSpeedButton;
    imgFaturamentoLine: TImage;
    imgFaturamentoFull: TImage;
    mnuTeleatendimento: TSpeedButton;
    imgTeleatendimentoLine: TImage;
    imgTeleatendimentoFull: TImage;
    mnuFinanceiro: TSpeedButton;
    imgControleFinanceiroLine: TImage;
    imgControleFinanceiroFull: TImage;
    mnuCancelamentoDocumentos: TSpeedButton;
    imgCancelamentosLine: TImage;
    imgCancelamentosFull: TImage;
    mnuLivroFiscal: TSpeedButton;
    imgLivroFiscalLine: TImage;
    imgLivroFiscalFull: TImage;
    mnuMovItens: TSpeedButton;
    imgMovimentacaoLine: TImage;
    imgMovimentacaoFull: TImage;
    mnuFechamentosMensais: TSpeedButton;
    imgFechamentosLine: TImage;
    imgFechamentosFull: TImage;
    mnuTintaDeMaquina: TSpeedButton;
    imgTintaMaquinaLine: TImage;
    imgTintaMaquinaFull: TImage;
    mnuContabilidade: TSpeedButton;
    imgContabilidadeLine: TImage;
    imgContabilidadeFull: TImage;
    mnuCRM: TSpeedButton;
    imgCRMLine: TImage;
    imgCRMFull: TImage;
    mnuManCadastros: TSpeedButton;
    imgCadastrosLine: TImage;
    imgCadastrosFull: TImage;
    mnuDashboard: TSpeedButton;
    imgDashboardLine: TImage;
    imgDashboardFull: TImage;
    recTravaTela: TRectangle;
    layMessages: TLayout;
    popGridPesquisa: TPopupMenu;
    mnuDireitosAcessoGridPesquisa: TMenuItem;
    popListBoxItem: TPopupMenu;
    mnuDireitosAcessoListBoxItem: TMenuItem;
    lblTEFInativo: TLabel;
    Image1: TImage;
    recHint: TRectangle;
    lblHint: TLabel;
    layPedLiberacao: TLayout;
    btnPedLiberacao: TSpeedButton;
    imgPedLiberacao: TImage;
    pnlNotifPedLiberacao: TRoundRect;
    lblNotifPedLiberacao: TLabel;
    actPedLiberacao: TAction;
    actPainelEntregas: TAction;
    mnuPainelEntregas: TSpeedButton;
    imgPainelEntregasLine: TImage;
    imgPainelEntregasFull: TImage;
    lsbxVerMais: TListBoxGroupFooter;
    lblDiretorio: TLabel;
    imgIconDiretorio: TImage;
    btnCitelDesk: TSpeedButton;
    imgCitelDesk: TImage;
    actCitelDesk: TAction;
    popWMS: TPopupMenu;
    layIconeWMS: TLayout;
    imgmnuWMS: TImage;
    somWMS: TShadowEffect;
    somFatResumoCaixa: TShadowEffect;
    somCadProdutos: TShadowEffect;
    somFatPedido: TShadowEffect;
    somFatOrcamento: TShadowEffect;
    somCadClientes: TShadowEffect;
    btnMenuTopo9: TSpeedButton;
    procedure btnSearchMouseEnter(Sender: TObject);
    procedure btnSearchMouseLeave(Sender: TObject);
    procedure shaSearchMouseEnter(Sender: TObject);
    procedure shaSearchMouseLeave(Sender: TObject);
    procedure edtSearchEnter(Sender: TObject);
    procedure edtSearchExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgSetaMouseEnter(Sender: TObject);
    procedure imgmnuCadClientesMouseEnter(Sender: TObject);
    procedure imgmnuCadClientesMouseLeave(Sender: TObject);
    procedure imgSetaClick(Sender: TObject);
    procedure cbbTesteCoresChange(Sender: TObject);
    procedure mnuManCadastrosMouseEnter(Sender: TObject);
    procedure mnuManCadastrosMouseLeave(Sender: TObject);
    procedure lsbxFavorito1MouseEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lsbxFavorito1Click(Sender: TObject);
    procedure lsbxFavorito1MouseLeave(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actFavorito1Execute(Sender: TObject);
    procedure imgGrupoFavoritosClick(Sender: TObject);
    procedure lsbxRecente1Click(Sender: TObject);
    procedure actRecente1Execute(Sender: TObject);
    procedure lsbxItemModeloClick(Sender: TObject);
    procedure mnuManCadastrosClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure popMenuCentralPopup(Sender: TObject);
    procedure popMenuCentralClosePopup(Sender: TObject);
    procedure lblBreadcrumbMenu1MouseEnter(Sender: TObject);
    procedure lblBreadcrumbMenu1MouseLeave(Sender: TObject);
    procedure lblBreadcrumbMenu1Click(Sender: TObject);
    procedure btnVoltarMouseEnter(Sender: TObject);
    procedure btnVoltarMouseLeave(Sender: TObject);
    procedure actManCadastrosExecute(Sender: TObject);
    procedure btnFecharMenuClick(Sender: TObject);
    procedure imgLogoFundoDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure actNewsExecute(Sender: TObject);
    procedure actEmailExecute(Sender: TObject);
    procedure actMessagesExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actInformationExecute(Sender: TObject);
    procedure actLogoutExecute(Sender: TObject);
    procedure btnMenuTopo1Click(Sender: TObject);
    procedure actMenuTopo1Execute(Sender: TObject);
    procedure imgmnuCadClientesClick(Sender: TObject);
    procedure actRodapeClientesExecute(Sender: TObject);
    procedure grdPesquisaGetValue(Sender: TObject; const Col, Row: Integer;
      var Value: TValue);
    procedure grdPesquisaDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
    procedure grdPesquisaMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtSearchChangeTracking(Sender: TObject);
    procedure Grid1GetValue(Sender: TObject; const Col, Row: Integer;
      var Value: TValue);
    procedure edtSearchChange(Sender: TObject);
    procedure grdPesquisaDblClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtSearchClick(Sender: TObject);
    procedure imgLogoFundoClick(Sender: TObject);
    procedure actDashboardExecute(Sender: TObject);
    procedure mnuDireitosAcessoGridPesquisaClick(Sender: TObject);
    procedure grdPesquisaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure mnuDireitosAcessoListBoxItemClick(Sender: TObject);
    procedure lsbxMenuCentralMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure lsbxItemModeloMouseEnter(Sender: TObject);
    procedure lsbxItemModeloMouseLeave(Sender: TObject);
    procedure actPedLiberacaoExecute(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure actPainelEntregasExecute(Sender: TObject);
    procedure lsbxVerMaisClick(Sender: TObject);
    procedure actCitelDeskExecute(Sender: TObject);
    procedure imgmnuWMSClick(Sender: TObject);
    procedure grdPesquisaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  protected
    procedure Recreate; override;

  private

    { Private declarations }
    LPathMenus: TStringList;
    LListaMenuCompleta : TStringList;
    LListaPesquisa: TArrayListaPesquisa;
    LListaPesquisaFiltro: TArrayListaPesquisa;
    ExibirFiltrados : Boolean;

    FGridRow: Integer;
    FGridCol: Integer;

    FListBoxItemPopup: TListBoxItem;
    FHintItemPopup: String;
    FLastPathMenus: String;

    FCarregandoMenu: Boolean;

    FobjQuadroLicencas: TQuadroLicencasFMX;

    procedure MostraPesquisa;
    procedure EscondePesquisa;

    procedure RestaurarUltimoMenuCentral;

    procedure AbreMenuCentral(LNomeMenu: String);
    procedure AbreMenuCentralFavoritos;
    procedure ClicarBotao(LCaption, LNomeMenu: String);
    procedure ClicarIconeLateral(Sender: TObject);
    procedure ClicarMenuPopup(Sender: TObject);

    procedure CarregarFavoritos;
    procedure CarregarRecentes;
    procedure CarregarMenu(LNomeMenu: String);
    procedure CarregarMenuFavoritos;
    procedure CarregaMenuTopo;
    procedure CarregaMenuLateral;
    procedure CarregaBarraFerramentas;
    procedure CarregaListaDePesquisa;
    procedure CarregaBotoesAtalhoLateral;
    procedure CarregaMenusPopUp;
    procedure AddMenuPopup(AMenu: IItemMenuAutcom; APopup: TPopupMenu; APopupItem: TMenuItem = Nil);

    procedure TrocaIconeMenuLateral(Sender: TObject; Mostrar: Boolean);
    procedure RealcaLinkLista(icone: TImage; texto: TLabel; Realca: Boolean);
    procedure RealcaBreadcrumbAberto(Text, Hint: String; Breadcrumb: TLabel);

    procedure AjustaLayoutMenuLateral;
    procedure AbreGridPesquisa(Linhas:Integer);
    procedure FechaGridPesquisa;

    function RetornaSaudacaoUsuario: String;

    function FindWordsList: TStringList;

    procedure PintarPesquisa(Canvas: TCanvas; Rect: TRectF; Linha, Coluna: Integer);
    function ItemPesquisaValido(const ALinha, AColuna: Integer; const ALista : TArrayListaPesquisa): Boolean;

    procedure EscondeCursor;
    procedure MoveCursor(Key: Word);
    procedure PiscaCursor;

    function RetornaIconeIndex(Menu: String; TemSubmenus: Boolean): Integer;

    procedure TravarTelaPrincipal(Ligar: Boolean = False);

    procedure TimerDinamico(ID: Integer; Intervalo: Integer; Ativado: Boolean);

    procedure AtualizaVisibilidadePanelTef;

    procedure ControlaFechamentoESC;

    procedure CriaDashboardAntiga(objDash: IDashboard);
    procedure CriaDashboardWeb(objDash: IDashboard);

    procedure AtualizarQuadroLicencas;
  public
    { Public declarations }
    objPrincipalAutcom    : IPrincipalAutcom;
    objTaEntregue         : ITaEntregue;
    objTaEntregueRefresh  : ITaEntregue;
    strNumRom             : String;

    procedure AtualizarTela(ARecarregaListaDePesquisa: Boolean = False);
    procedure AtualizarQuantidadeMensagens(AValue: Integer);
    procedure MostraMensagemTEF(AMensagem: String);
    procedure AtualizarQuantidadePedLiberacao(AValue: Integer);
    procedure DefineStatusActionAtalhos(const AEnabled : Boolean);
  end;

  MouseLLHookStruct = record
    pt          : TPoint;
    mouseData   : cardinal;
    flags       : cardinal;
    time        : cardinal;
    dwExtraInfo : cardinal;
  end;

procedure ExibirNovaTelaPrincipalAutcom(APrincipalAutcom: IPrincipalAutcom);
procedure AtualizarNovaTelaPrincipalAutcom(ARecarregaListaDePesquisa: Boolean = False; const AMenuRecemCriado: String='');
procedure AtualizarQuantidadeMensagens(AValue: Integer);
procedure EncerrarNovaTelaPrincipalAutcom();
procedure AtualizarTelaPrincipalNova(Esconder: Boolean);
procedure MostraMensagemTEF(AMensagem: String);
procedure DefineStatusActionAtalhos(const AEnabled : Boolean);
procedure AbrirDashboard;
procedure AbrirPainelEntregas(ATaEntregue, ATaEntregueRefresh: ITaEntregue; strNumRom: String);
procedure AtualizarQuantidadePedLiberacao(AValue: Integer);

function LowLevelMouseHookProc(nCode, wParam, lParam : integer) : integer; stdcall;
function LowLevelKeyboardProc(nCode: integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;

procedure SetKeyboardHook(AEnabled: Boolean);
procedure SetMouseHook(AEnabled: Boolean);

var
  fmxMenu: TfmxMenu;
  mHook : cardinal;
  kHook : HHook;

implementation

uses Principal.View.FMXDashboard;

var
  WndProcHook: THandle;
  FMinimized: Boolean;
  FMinimizedTime: TDateTime;
  FMinimizedHandle: HWND;

Type
  TLabelHint = class(THint)
  private
    FForm: TfmxMenu;
  public
    constructor CreateHint(const AForm: TfmxMenu);
    procedure SetEnabled(const Value: Boolean); override;
    procedure SetPosition(const X, Y: Single); override;
  end;

function WndProc(Code: integer; WParam, LParam: LongInt): LRESULT; stdcall;
var
  msg: TCWPRetStruct;
begin;
  Result := 0;
  try
    if not Assigned(fmxMenu) then
      Exit;

    if not ((Code >= HC_ACTION) and (LParam > 0)) then
      Exit;

    msg := PCWPRetStruct(LParam)^;

    case msg.Message of
      WM_SIZE:
        if (msg.WParam = SIZE_MINIMIZED) and
           (FindWindow(msg.hwnd) <> nil) then
        begin
          if (FindWindow(msg.hwnd).Name = 'fmxMenu') then
          begin
            FMinimized       := True;
            FMinimizedTime   := Now();
            FMinimizedHandle := FormToHWND(fmxMenu);
          end;
          if (FindWindow(msg.hwnd).Name = 'fmxPainelEntregas') then
          begin
            FMinimized       := True;
            FMinimizedTime   := Now();
            FMinimizedHandle := FormToHWND(fmxPainelEntregas);
          end;
          if (FindWindow(msg.hwnd).Name = 'fmxDashboardPrincipal') then
          begin
            FMinimized       := True;
            FMinimizedTime   := Now();
            FMinimizedHandle := FormToHWND(fmxDashboardPrincipal);
          end;
          if (FindWindow(msg.hwnd).Name = 'fmxDashboardPrincipalOld') then
          begin
            FMinimized       := True;
            FMinimizedTime   := Now();
            FMinimizedHandle := FormToHWND(fmxDashboardPrincipalOld);
          end;
        end;

      WM_ACTIVATE:
        if (FMinimized) then
        begin
          if SecondsBetween(Now, FMinimizedTime) >= 1 then
          begin
            FMinimized := False;
            ShowWindow(FMinimizedHandle, SW_SHOWMAXIMIZED);
          end;
        end;
    end;

  finally
    Result := CallNextHookEx(WndProcHook, Code, WParam, LParam);
  end;
end;

function LowLevelMouseHookProc(nCode, wParam, lParam : integer) : integer; stdcall;
var
  info     : ^MouseLLHookStruct absolute lParam;
  LMonitor : TDisplay;
begin
  result := CallNextHookEx(mHook, nCode, wParam, lParam);
  case wParam of
    514:
    Begin
      LMonitor := TDisplay(Screen.DisplayFromForm(fmxMenu));
      If (info^.pt.y > LMonitor.WorkareaRect.Height) Then
      Begin
        fmxMenu.popMenuCentral.IsOpen := False;
        SetMouseHook(False);
        SetMouseHook(True);
      End;
    End;
  end;
end;

function LowLevelKeyboardProc(nCode: integer; wParam: WPARAM; lParam: LPARAM):
  LRESULT; stdcall;
type
  PKBDLLHOOKSTRUCT = ^TKBDLLHOOKSTRUCT;
  TKBDLLHOOKSTRUCT = record
    vkCode: cardinal;
    scanCode: cardinal;
    flags: cardinal;
    time: cardinal;
    dwExtraInfo: Cardinal;
  end;

  PKeyboardLowLevelHookStruct = ^TKeyboardLowLevelHookStruct;
  TKeyboardLowLevelHookStruct = TKBDLLHOOKSTRUCT;
const
  LLKHF_ALTDOWN = $20;
var
  hs: PKeyboardLowLevelHookStruct;
begin
  if nCode = HC_ACTION then
  begin
    hs := PKeyboardLowLevelHookStruct(lParam);
    if (hs^.vkCode = VK_TAB) and ((hs^.flags and LLKHF_ALTDOWN) <> 0) then
    begin
      fmxMenu.popMenuCentral.IsOpen := False;
      SetKeyboardHook(False);
      SetKeyboardHook(True);
    end;
  end;
  result := CallNextHookEx(kHook, nCode, wParam, lParam);
end;

procedure SetKeyboardHook(AEnabled: Boolean);
begin
  if AEnabled then
    kHook := SetWindowsHookEx(WH_KEYBOARD_LL, @LowLevelKeyboardProc, 0, 0)
  else
    UnhookWindowsHookEx(kHook);
end;

procedure SetMouseHook(AEnabled: Boolean);
begin
  if AEnabled then
    mHook := SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseHookProc, hInstance, 0)
  else
    UnhookWindowsHookEx(mHook);
end;

{$R *.fmx}

Const
  strEspaco = '       ';


procedure TimerMensagem(hwnd: HWND; uMsg: UINT;idEvent: UINT ; dwTime : DWORD ); stdcall;
begin
  fmxMenu.lblSaudacao.Text := fmxMenu.RetornaSaudacaoUsuario;

  If (fmxMenu.linSearchCursor.Tag = 0) Then
    fmxMenu.linSearchCursor.Visible := False

  Else If (fmxMenu.linSearchCursor.Tag = 1) Then
  Begin
    fmxMenu.linSearchCursor.Visible := Not fmxMenu.linSearchCursor.Visible;
  End;
end;

function fRemoveAcento(Str:String): String;
  Const
    ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
    SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
  Var
    x : Integer;
Begin
  For x := 1 to Length(Str) do
    If Pos(Str[x],ComAcento)<>0 Then
      Str[x] := SemAcento[Pos(Str[x],ComAcento)];

  Result := Str;
end;

procedure ExibirNovaTelaPrincipalAutcom(APrincipalAutcom: IPrincipalAutcom);
begin
  fmxMenu := TfmxMenu.Create(nil);
  Try
    fmxMenu.objPrincipalAutcom := APrincipalAutcom;
    fmxMenu.ShowModal;
  Finally
    FreeAndNil(fmxMenu);
  End;
end;

procedure AtualizarNovaTelaPrincipalAutcom(ARecarregaListaDePesquisa: Boolean = False; const AMenuRecemCriado: String='');
begin
  If Assigned(fmxMenu) Then
  Begin
    fmxMenu.AtualizarTela(ARecarregaListaDePesquisa);

    If (AMenuRecemCriado <> '') Then
      fmxMenu.CarregarMenu(AMenuRecemCriado);
  End;
end;

procedure AtualizarQuantidadeMensagens(AValue: Integer);
begin
  If Assigned(fmxMenu) Then
    fmxMenu.AtualizarQuantidadeMensagens(AValue);
end;

procedure EncerrarNovaTelaPrincipalAutcom();
begin
  If Assigned(fmxMenu) Then
    fmxMenu.Close;
end;

procedure AtualizarTelaPrincipalNova(Esconder: Boolean);
begin
  If Assigned(fmxMenu) Then
  Begin
    If Esconder Then
    Begin
      fmxMenu.Hide;
    End
    Else
    Begin
      fmxMenu.mnuTintaDeMaquina.Pressed := False;
      fmxMenu.Show;
      SetForegroundWindow(FormToHWND(fmxMenu));
      fmxMenu.SetActive(True);
    End;
  End;
end;

procedure MostraMensagemTEF(AMensagem: String);
begin
  If Assigned(fmxMenu) Then
    fmxMenu.MostraMensagemTEF(AMensagem);
end;

procedure DefineStatusActionAtalhos(const AEnabled : Boolean);
begin
  If (Not Assigned(fmxMenu)) Then
    Exit;
  fmxMenu.DefineStatusActionAtalhos(AEnabled);
end;

procedure AbrirDashboard;
begin
  If Assigned(fmxMenu) Then
    fmxMenu.actDashboardExecute(fmxMenu.mnuDashboard);
end;

procedure AbrirPainelEntregas(ATaEntregue, ATaEntregueRefresh: ITaEntregue; strNumRom: String);
begin
  If Assigned(fmxMenu) Then
  Begin
    fmxMenu.objTaEntregue        := ATaEntregue;
    fmxMenu.objTaEntregueRefresh := ATaEntregueRefresh;
    fmxMenu.strNumRom            := strNumRom;
    fmxMenu.actPainelEntregasExecute(fmxMenu.mnuPainelEntregas);
  End;
end;

procedure AtualizarQuantidadePedLiberacao(AValue: Integer);
begin
  If Assigned(fmxMenu) Then
    fmxMenu.AtualizarQuantidadePedLiberacao(AValue);
end;

procedure TfmxMenu.btnSearchMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Opacity := 1;
end;

procedure TfmxMenu.btnSearchMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Opacity := 0.5;
end;

procedure TfmxMenu.btnVoltarClick(Sender: TObject);
Var
  LMenuAnterior : String;
  LLabel : TLabel;
begin
  if (Not FCarregandoMenu) Then
  Begin
    If (LPathMenus.Count = 1) Then
      Exit;

    FCarregandoMenu := True;

    LMenuAnterior := LPathMenus[LPathMenus.Count - 2];
    CarregarMenu(LMenuAnterior);
    LPathMenus.Delete(LPathMenus.Count - 1);
    LLabel := TLabel(FindComponent('lblBreadcrumbMenu' + IntToStr(LPathMenus.Count + 1)));
    LLabel.Visible := False;

    LLabel := TLabel(FindComponent('lblBreadcrumbMenu' + IntToStr(LPathMenus.Count)));
    LLabel.TextSettings.FontColor := $FF3b6887;
    LLabel.TextSettings.Font.Style := [TFontStyle.fsBold];

    btnVoltar.Visible := LPathMenus.Count > 1;

    FLastPathMenus := LPathMenus.CommaText;

    FCarregandoMenu := False;
  End;
end;

procedure TfmxMenu.btnVoltarMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Opacity := 0.5;
end;

procedure TfmxMenu.btnVoltarMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Opacity := 0.2;
end;

procedure TfmxMenu.CarregaBarraFerramentas;
Var
  LMenu : IMenuAutcom;
  LHint : String;
begin
  LMenu  := objPrincipalAutcom.MenuPrincipal;
  LHint  := objPrincipalAutcom.MenuPrincipal.Find('mnuCadConfiguracoes').Hint;

  btnSettings.Visible := objPrincipalAutcom.VerificaAcessoSistema(LHint);
  layPedLiberacao.Visible := objPrincipalAutcom.MenuPrincipal.Find('mnuPedLiberacao').Enabled;
  btnCitelDesk.Visible := objPrincipalAutcom.MenuPrincipal.Find('mnuCitelDesk').Visible And
                          objPrincipalAutcom.MenuPrincipal.Find('mnuCitelDesk').Enabled;
end;

procedure TfmxMenu.CarregaBotoesAtalhoLateral;
Var
  LContador, LVisiveis: Integer;
  LHint : String;
begin
  LVisiveis := 0;
  LHint                    := objPrincipalAutcom.MenuPrincipal.Find('mnuCadClientes').Hint;
  layIconeClientes.Visible := objPrincipalAutcom.MenuPrincipal.Find('mnuCadClientes').Visible And
                              objPrincipalAutcom.VerificaAcessoSistema(LHint);

  LHint                    := objPrincipalAutcom.MenuPrincipal.Find('mnuCadProdutos').Hint;
  layIconeProdutos.Visible := objPrincipalAutcom.MenuPrincipal.Find('mnuCadProdutos').Visible And
                              objPrincipalAutcom.VerificaAcessoSistema(LHint);

  LHint                      := objPrincipalAutcom.MenuPrincipal.Find('mnuFatOrcamento').Hint;
  layIconeOrcamentos.Visible := objPrincipalAutcom.MenuPrincipal.Find('mnuFatOrcamento').Visible And
                                objPrincipalAutcom.VerificaAcessoSistema(LHint);

  LHint                   := objPrincipalAutcom.MenuPrincipal.Find('mnuFatPedido').Hint;
  layIconePedidos.Visible := objPrincipalAutcom.MenuPrincipal.Find('mnuFatPedido').Visible And
                             objPrincipalAutcom.VerificaAcessoSistema(LHint);

  LHint                       := objPrincipalAutcom.MenuPrincipal.Find('mnuFatResumoCaixa').Hint;
  layIconeResumoCaixa.Visible := objPrincipalAutcom.MenuPrincipal.Find('mnuFatResumoCaixa').Visible And
                                 objPrincipalAutcom.VerificaAcessoSistema(LHint);

  layIconeWMS.Visible := objPrincipalAutcom.HabilitaAtalhoWMS;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassNameIs('TLayout')) Then
      If (TLayout(Self.Components[LContador]).Parent.Name = 'flwLayMenuLateral') Then
        If (TLayout(Self.Components[LContador]).Visible) Then
          Inc(LVisiveis);
  End;

  layRodapeEscondido.Visible := LVisiveis > 0;
  flwLayMenuLateral.Height   := LVisiveis * 80;
end;

procedure TfmxMenu.CarregaListaDePesquisa;
Var
  LItem: IItemMenuAutcom;
  LIndex: Integer;
begin
  LIndex := 0;
  SetLength(LListaPesquisa, objPrincipalAutcom.RetornaTodos.Items.Count, 3);

  If Not Assigned(LListaMenuCompleta) Then
  Begin
    LListaMenuCompleta := TStringList.Create;
  End;

  LListaMenuCompleta.Clear;

  For LItem In objPrincipalAutcom.RetornaTodos.Items Do
  Begin
    LListaPesquisa[LIndex][0] := IfThen(LItem.Favorito, '4', '5');
    LListaPesquisa[LIndex][1] := LItem.Caption;
    LListaPesquisa[LIndex][2] := LItem.Name;

    LListaMenuCompleta.Add(LItem.Name);

    Inc(LIndex);
  End;

  grdPesquisa.RowCount := Length(LListaPesquisa);
  grdPesquisa.UpdateColumns;
end;

procedure TfmxMenu.CarregaMenuLateral;
Var
  LCount, LIndex, LCountVisible : Integer;
  LMenu   : IMenuAutcom;
  LButton : TSpeedButton;
begin
  layMenuLateral.Height := 440;

  LMenu  := objPrincipalAutcom.MenuPrincipal;
  LCount := LMenu.Find('mnuPrincipal').Items.Count;

  LCountVisible := 0;
  For LIndex := 1 To LCount Do
  Begin
    If (LMenu.Find('mnuPrincipal').Items[Pred(LIndex)].Caption <> '-') Then
    Begin
      LButton := TSpeedButton(FindComponent(LMenu.Find('mnuPrincipal').Items[Pred(LIndex)].Name));

      If LMenu.Find('mnuPrincipal').Visible Then
        LButton.Visible := LMenu.Find('mnuPrincipal').Items[Pred(LIndex)].Visible And
                           LMenu.Find('mnuPrincipal').Items[Pred(LIndex)].Enabled
      Else
        LButton.Visible := False;

      If LButton.Visible Then
        Inc(LCountVisible);
    End;
  End;

  layMenuLateral.Height := (40 * LCountVisible) + 10;

  AjustaLayoutMenuLateral;
end;

procedure TfmxMenu.CarregaMenusPopUp;
Var
  LIndex : Integer;
  LMenu  : IMenuAutcom;
begin
  If (objPrincipalAutcom.HabilitaAtalhoWMS) Then
  Begin
    popWMS.Clear;
    LMenu  := objPrincipalAutcom.MenuWMS;

    For LIndex := 1 To LMenu.Items.Count Do
      AddMenuPopup(LMenu.Items[Pred(LIndex)], popWMS);
  End;
end;

procedure TfmxMenu.CarregaMenuTopo;
Var
  LIndex   : Integer;
  LButton  : TSpeedButton;
  LMenu    : IMenuAutcom;
  LItem    : IItemMenuAutcom;
begin
  LMenu  := objPrincipalAutcom.MenuPrincipal;
  LIndex := 0;

  For LItem In LMenu.Items Do
  Begin
    If SameText(LItem.Caption, '-') Or
       ContainsText(LItem.Caption, 'Principal') Or
       ContainsText(LItem.Caption, 'Logoff') Or
       ContainsText(LItem.Caption, 'Sobre') Then
      Continue;

    Inc(LIndex);

    LButton := TSpeedButton(FindComponent('btnMenuTopo' + LIndex.ToString()));

    If Not Assigned(LButton) Then
      Break;

    If LItem.Visible And LItem.Enabled Then
    Begin
      LButton.Text      := Trim(LItem.Caption);
      LButton.Hint      := Trim(LItem.Caption) + ' (Shift+Ctrl+F' + LIndex.ToString() + ')';
      LButton.TagString := Trim(LItem.Name);
      LButton.Visible   := True;
    End
    Else
      LButton.Visible   := False;
  End;
end;

procedure TfmxMenu.CarregarFavoritos;
Var
  LIndex, LCount: Integer;
  LLabel: TLabel;
  LListBox: TListBoxItem;
  LFavoritos: IFavoritosAutcom;
  LNomeFavorito: TArray<String>;
begin
  LFavoritos := objPrincipalAutcom.Favoritos;

  layFavoritos.Visible := LFavoritos.Items.Count > 0;

  If (LFavoritos.Items.Count > 10) Then
  Begin
    LCount := 10;
    layFavoritos.Height := 50 + (LCount * 18);
  End
  Else
  Begin
    LCount := LFavoritos.Items.Count;
    layFavoritos.Height := 28 + (LCount * 18);
  End;

  lbxFavoritos.BeginUpdate;
  For LIndex := 1 To 10 Do
  Begin
    LLabel := TLabel(FindComponent('lblFavorito' + LIndex.ToString()));
    LListBox := TListBoxItem(FindComponent('lsbxFavorito' + LIndex.ToString()));

    If LIndex > LFavoritos.Items.Count Then
    Begin
      LListBox.Visible := False;
      Continue;
    End;

    LNomeFavorito := LFavoritos.Items[Pred(LIndex)].Caption.Split(['>']);

    LListBox.Visible  := True;
    LListBox.ShowHint := True;
    LListBox.Hint     := Trim(LFavoritos.Items[Pred(LIndex)].Caption) + ' (Ctrl+' + IntToStr(IfThen(LIndex = 10, 0, LIndex)) + ')';

    LLabel.ShowHint := False;
    LLabel.Hint     := Trim(LFavoritos.Items[Pred(LIndex)].Name);
    LLabel.Text     := Trim(LNomeFavorito[High(LNomeFavorito)]);
  End;
  lbxFavoritos.EndUpdate;

  lsbxVerMais.Visible := LFavoritos.Items.Count > 10;

  AjustaLayoutMenuLateral;
end;

procedure TfmxMenu.CarregarMenu(LNomeMenu: String);
Var
  LIndex, LCount: Integer;
  LListBoxItem  : TListBoxItem;
  LMenu         : IMenuAutcom;
  LTextoMenu    : String;
begin
  lsbxMenuCentral.Items.Clear;

  LMenu  := objPrincipalAutcom.MenuPrincipal;
  LCount := LMenu.Find(LNomeMenu).Items.Count;

  lsbxMenuCentral.BeginUpdate;
  For LIndex := 1 To LCount Do
  Begin
    Try
      If (LMenu.Find(LNomeMenu).Items[Pred(LIndex)].Visible) And
         (LMenu.Find(LNomeMenu).Items[Pred(LIndex)].Caption <> '-') Then
      Begin
        LTextoMenu               := ReplaceText(LMenu.Find(LNomeMenu).Items[Pred(LIndex)].Caption, '&', '');

        LTextoMenu               := IfThen(LTextoMenu = 'Criar Novo RelatÛrio',
                                           '[ ' + LTextoMenu + ' ]',
                                           LTextoMenu);

        LListBoxItem             := TListBoxItem.Create(lsbxMenuCentral);
        LListBoxItem.Text        := LTextoMenu;
        LListBoxItem.Hint        := LMenu.Find(LNomeMenu).Items[Pred(LIndex)].Name;
        LListBoxItem.Enabled     := LMenu.Find(LNomeMenu).Items[Pred(LIndex)].Enabled;
        LListBoxItem.StyleLookup := 'CitelItemMenuCentralStyle';
        LListBoxItem.Height      := 20;
        LListBoxItem.Width       := 400;
        LListBoxItem.HitTest     := True;
        LListBoxItem.Cursor      := crHandPoint;
        LListBoxItem.Selectable  := False;
        LListBoxItem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Other];
        LListBoxItem.OnMouseEnter:= lsbxItemModeloMouseEnter;
        LListBoxItem.OnMouseLeave:= lsbxItemModeloMouseLeave;
        LListBoxItem.OnClick     := lsbxItemModeloClick;

        LListBoxItem.ImageIndex := RetornaIconeIndex(LTextoMenu, ((LMenu.Find(LNomeMenu).Items[Pred(LIndex)].Items.Count) > 0));

        lsbxMenuCentral.AddObject(LListBoxItem);
        lsbxMenuCentral.Sorted := True;
      End;
    Except
      On E: Exception Do
        Showmessage(E.Message);
    End;
  End;
  lsbxMenuCentral.EndUpdate;
end;

procedure TfmxMenu.CarregarMenuFavoritos;
Var
  LIndex, LCount: Integer;
  LListBoxItem  : TListBoxItem;
  LMenu         : IFavoritosAutcom;
  LNomeFavorito : TArray<String>;
begin
  lsbxMenuCentral.Items.Clear;

  LMenu  := objPrincipalAutcom.Favoritos;
  LCount := LMenu.Items.Count;

  lsbxMenuCentral.BeginUpdate;
  For LIndex := 1 To LCount Do
  Begin
    Try
      LNomeFavorito               := LMenu.Items[Pred(LIndex)].Caption.Split(['>']);

      LListBoxItem                := TListBoxItem.Create(lsbxMenuCentral);
      LListBoxItem.Text           := Trim(LNomeFavorito[High(LNomeFavorito)]);
      LListBoxItem.Hint           := Trim(LMenu.Items[Pred(LIndex)].Caption);
      LListBoxItem.Enabled        := True;
      LListBoxItem.StyleLookup    := 'CitelItemMenuCentralStyle';
      LListBoxItem.Height         := 20;
      LListBoxItem.Width          := 400;
      LListBoxItem.HitTest        := True;
      LListBoxItem.Cursor         := crHandPoint;
      LListBoxItem.Selectable     := False;
      LListBoxItem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Other];
      LListBoxItem.OnMouseEnter   := lsbxItemModeloMouseEnter;
      LListBoxItem.OnMouseLeave   := lsbxItemModeloMouseLeave;
      LListBoxItem.OnClick        := lsbxFavorito1Click;

      LListBoxItem.ImageIndex := RetornaIconeIndex('Favoritos', False);

      lsbxMenuCentral.AddObject(LListBoxItem);
      lsbxMenuCentral.Sorted := True;
    Except
      On E: Exception Do
        Showmessage(E.Message);
    End;
  End;
  lsbxMenuCentral.EndUpdate;
end;

procedure TfmxMenu.CarregarRecentes;
Var
  LIndex, LCount: Integer;
  LLabel: TLabel;
  LListBox: TListBoxItem;
  LRecentes: IRecentesAutcom;
  LNomeRecente: TArray<String>;
begin
  LRecentes := objPrincipalAutcom.Recentes;
  layRecentes.Visible := LRecentes.Items.Count > 0;

  If (LRecentes.Items.Count > 10) Then
    LCount := 10
  Else
    LCount := LRecentes.Items.Count;

  layRecentes.Height := 28 + (LCount * 18);

  lbxAcessosRecentes.BeginUpdate;
  For LIndex := 1 To 10 Do
  Begin
    LLabel := TLabel(FindComponent('lblRecente' + LIndex.ToString()));
    LListBox := TListBoxItem(FindComponent('lsbxRecente' + LIndex.ToString()));

    If LIndex > LRecentes.Items.Count Then
    Begin
      LListBox.Visible := False;
      Continue;
    End;

    LNomeRecente := LRecentes.Items[Pred(LIndex)].Caption.Split(['>']);

    LListBox.Visible  := True;
    LListBox.ShowHint := True;
    LListBox.Hint     := Trim(LRecentes.Items[Pred(LIndex)].Caption) + ' (Shift+F' + IntToStr(LIndex) + ')';

    LLabel.ShowHint := False;
    LLabel.Hint     := Trim(LRecentes.Items[Pred(LIndex)].Name);
    LLabel.Text     := Trim(LNomeRecente[High(LNomeRecente)]);
  End;
  lbxAcessosRecentes.EndUpdate;

  AjustaLayoutMenuLateral;
end;

procedure TfmxMenu.ClicarIconeLateral(Sender: TObject);
Var
  LMenu : IItemMenuAutcom;
begin
  DefineStatusActionAtalhos(False);
  TravarTelaPrincipal(True);

  FechaGridPesquisa;

  LMenu := objPrincipalAutcom.MenuPrincipal.Find(Copy(TImage(Sender).Name,4,50));

  If (Assigned(LMenu)) And (LMenu.Visible) Then
    LMenu.ExecutarClick;

  TravarTelaPrincipal(False);
  DefineStatusActionAtalhos(True);
end;

procedure TfmxMenu.ClicarMenuPopup(Sender: TObject);
Var
  LMenu : IItemMenuAutcom;
begin
  LMenu := objPrincipalAutcom.MenuWMS.Find(TMenuItem(Sender).TagString);

  If (Assigned(LMenu)) And (LMenu.Visible) Then
    LMenu.ExecutarClick;
end;

procedure TfmxMenu.ControlaFechamentoESC;
begin
  If (edtSearch.Text <> EmptyStr) Then
  Begin
    edtSearch.Text := '';
    edtSearch.SetFocus;
  End
  Else
    Close;
end;

procedure TfmxMenu.ClicarBotao(LCaption, LNomeMenu: String);
Var
  LCount: Integer;
  LMenu : IMenuAutcom;
begin
  LMenu  := objPrincipalAutcom.MenuPrincipal;
  LCount := LMenu.Find(LNomeMenu).Items.Count;

  If (LCount <= 0) Then
    LMenu.Find(LNomeMenu).ExecutarClick
  Else
  Begin
    RealcaBreadcrumbAberto(LCaption, LNomeMenu, lblBreadcrumbMenu1);

    AbreMenuCentral(LNomeMenu);
    LPathMenus.Add(LNomeMenu);
  End;

  FLastPathMenus := LPathMenus.CommaText;
end;

procedure TfmxMenu.cbbTesteCoresChange(Sender: TObject);
begin
  Case cbbTesteCores.ItemIndex Of
   0: recFundoMenuLateral.Fill.Color := TAlphaColor($FF003E5A);
   1: recFundoMenuLateral.Fill.Color := TAlphaColor($FF5A0000);
   2: recFundoMenuLateral.Fill.Color := TAlphaColor($FF5A3800);
   3: recFundoMenuLateral.Fill.Color := TAlphaColor($FF005A2B);
   4: recFundoMenuLateral.Fill.Color := TAlphaColor($FF47005A);
   5: recFundoMenuLateral.Fill.Color := TAlphaColor($FF00575A);
   6: recFundoMenuLateral.Fill.Color := TAlphaColor($FF696969);
   7: recFundoMenuLateral.Fill.Color := TAlphaColor($FF000000);
  End;
end;

procedure TfmxMenu.edtSearchChange(Sender: TObject);
begin
  If (edtSearch.Text <> EmptyStr) Then
  Begin
    grdPesquisa.SelectRow(0);
    grdPesquisa.SetFocus;
  End;
end;

procedure TfmxMenu.edtSearchChangeTracking(Sender: TObject);
Var
  LIndex, LCount: Integer;
  LPalavra, LPalavras : String;
  LEncontrou: Boolean;
begin
  LPalavras := Trim(TEdit(Sender).Text);

  While Pos('  ', LPalavras) > 0 Do
    LPalavras := AnsiReplaceStr(LPalavras, '  ', ' ');

  ExibirFiltrados := Not LPalavras.IsEmpty;

  If (ExibirFiltrados) Then
  Begin
    LListaPesquisaFiltro := Nil;
    LCount := 0;

    For LIndex := Low(LListaPesquisa) to High(LListaPesquisa) do
    begin
      LEncontrou:= True;

      For LPalavra In LPalavras.Split([' ']) Do
        LEncontrou := LEncontrou And UpperCase(fRemoveAcento(LListaPesquisa[LIndex][1])).Contains(UpperCase(fRemoveAcento(LPalavra)));

      If (LEncontrou) Then
      Begin
        SetLength(LListaPesquisaFiltro, LCount+1, 3);

        LListaPesquisaFiltro[LCount][0] := LListaPesquisa[LIndex][0];
        LListaPesquisaFiltro[LCount][1] := LListaPesquisa[LIndex][1];
        LListaPesquisaFiltro[LCount][2] := LListaPesquisa[LIndex][2];

        Inc(LCount);
      End;
    end;
    grdPesquisa.RowCount := Length(LListaPesquisaFiltro);
  End
  Else
  Begin
    LListaPesquisaFiltro := Nil;
    grdPesquisa.RowCount := Length(LListaPesquisa);
  End;

  If (grdPesquisa.RowCount = 0) Then
    grdPesquisa.Selected := -1;

  grdPesquisa.UpdateColumns;
  MoveCursor(vkRight);
  AbreGridPesquisa(grdPesquisa.RowCount);
end;

procedure TfmxMenu.edtSearchClick(Sender: TObject);
begin
  MoveCursor(vkNone);
end;

procedure TfmxMenu.edtSearchEnter(Sender: TObject);
begin
  PiscaCursor;

  If (edtSearch.Text = EmptyStr) Then
  Begin
    popMenuCentral.IsOpen := False;
    lblPesquisa.Visible := False;
    MostraPesquisa;
  End;
end;

procedure TfmxMenu.edtSearchExit(Sender: TObject);
begin
  EscondeCursor;

  If (edtSearch.Text = EmptyStr) Then
  Begin
    lblPesquisa.Visible := True;
    EscondePesquisa;
  End;
end;

procedure TfmxMenu.edtSearchKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If (edtSearch.Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkDown :
      Begin
        grdPesquisa.SelectRow(0);
        grdPesquisa.SetFocus;
      End;

      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Key);
    End;
  End;
end;

procedure TfmxMenu.edtSearchKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  grdPesquisa.Repaint;
end;

procedure TfmxMenu.EscondeCursor;
begin
  linSearchCursor.Tag := 0;
end;

procedure TfmxMenu.EscondePesquisa;
begin
  linLeft.StrokeThickness   := 0;
  linRight.StrokeThickness  := 0;
  linBottom.StrokeThickness := 0;
end;

procedure TfmxMenu.FechaGridPesquisa;
begin
  linSearchCursor.Visible := False;
  edtSearch.Text := EmptyStr;

  edtFoco.SetFocus;
end;

function TfmxMenu.FindWordsList: TStringList;
Var
  LWords: String;
begin
  Result := TStringList.Create;

  LWords := Trim(edtSearch.Text);

  While Pos('  ', LWords) > 0 Do
    LWords := AnsiReplaceStr(LWords, '  ', ' ');

  Result.Text := AnsiReplaceStr(LWords, ' ', #13#10);
end;

procedure TfmxMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  objPrincipalAutcom.FormClose(Sender, Action);

  If (Action <> TCloseAction.caNone) Then
    TimerDinamico(1, 300, False);
end;

procedure TfmxMenu.FormCreate(Sender: TObject);
Var
  LIndex: Integer;
const
  WH_MOUSE_LL = 14;
begin
  SetMouseHook(True);
  SetKeyboardHook(True);

  FCarregandoMenu := False;

  ExibirFiltrados := False;

  For LIndex := 1 To 9 Do
    TSpeedButton(FindComponent('btnMenuTopo' + (LIndex).ToString())).Visible := False;

  LPathMenus := TStringList.Create;

  cbbTesteCores.ItemIndex := 0;
  layRodapeEscondido.Height := 20;

  TimerDinamico(1, 300, True);

  recHint.Visible := False;

  edtSearch.OnMouseEnter     := shaSearchMouseEnter;
  edtSearch.OnMouseLeave     := shaSearchMouseLeave;

  lblMensagemTEF.Text := '';

  If (Self.ClientHeight > Screen.WorkAreaRect.Height) Then
    Self.ClientHeight := Screen.WorkAreaRect.Height - 30;

  strNumRom := '';

  EscondeCursor;
end;

procedure TfmxMenu.FormDestroy(Sender: TObject);
begin
  SetMouseHook(False);
  SetKeyboardHook(False);
  If Assigned(FobjQuadroLicencas) Then
    FreeAndNil(FobjQuadroLicencas);

  LPathMenus.Free;
end;

procedure TfmxMenu.FormFocusChanged(Sender: TObject);
begin
  fmxMenu.Activate;
end;

procedure TfmxMenu.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape :
    Begin
      If Not (recTravaTela.Visible) Then
      Begin
        ControlaFechamentoESC;
        layFundo.Repaint;
      End;
    End;

    VK_F1:
    Begin
      If (Shift = ([ssCtrl])) Then
        objPrincipalAutcom.KeyDownVersaoClassica;
    End;
  End;
end;

procedure TfmxMenu.FormShow(Sender: TObject);
begin
  Self.Height := Screen.WorkAreaRect.Height + 4;

  AtualizarTela;
  AtualizarQuantidadeMensagens(0);
  AtualizarQuantidadePedLiberacao(0);
  CarregaListaDePesquisa;

  layGridPesquisa.Height := 39;

  AtualizaVisibilidadePanelTef;

  ShowWindow(ApplicationHWND, SW_HIDE);
end;

function FindText(ASubText, AText: String): TArray<Integer>;
Var
  LStart: Integer;
  LPosition: Integer;
begin
  SetLength(Result, 0);

  AText := UpperCase(fRemoveAcento(AText));
  ASubText := UpperCase(fRemoveAcento(ASubText));

  LStart := 1;

  While True Do
  Begin
    LPosition := Pos(ASubText, MidStr(AText, LStart, Length(AText)));

    If LPosition > 0 Then
    Begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1] := LStart + LPosition - 1;
      LStart := LStart + LPosition;
      Continue;
    End;

    Break;
  End;

end;

function TfmxMenu.ItemPesquisaValido(const ALinha, AColuna: Integer; const ALista : TArrayListaPesquisa): Boolean;
begin
  If (AColuna < 0) Then
    Exit(False);

  Result := (ALinha >= Low(ALista)) And
            (ALinha <= High(ALista)) And
            (AColuna <= High(ALista[ALinha]));
end;

procedure TfmxMenu.grdPesquisaDblClick(Sender: TObject);
Var
  LMenu: String;
begin
  If (Not ItemPesquisaValido(grdPesquisa.Selected, 2, LListaPesquisaFiltro)) Then
    Exit;

  LMenu := LListaPesquisaFiltro[grdPesquisa.Selected][2];
  edtSearch.Text := EmptyStr;
  edtSearchExit(edtSearch);
  FechaGridPesquisa;
  objPrincipalAutcom.MenuPrincipal.Find(LMenu).ExecutarClick();
end;

procedure TfmxMenu.grdPesquisaDrawColumnCell(Sender: TObject;
  const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF;
  const Row: Integer; const Value: TValue; const State: TGridDrawStates);
var
  LRect: TRectF;
  LText: String;
  LWord: String;
  LWords: TStringList;
  LPosition: Integer;
  LPositions: TArray<Integer>;
  LFatorAjuste: Double;
begin
  If Column = colIcone Then
  Begin
    LRect := Bounds;

    Canvas.Fill.Color := TAlphaColorRec.White;

    Canvas.FillRect(Bounds, 0, 0, AllCorners, 1);

    LRect.Left   := LRect.Left + 5;
    LRect.Top    := LRect.Top + 1;
    LRect.Height := LRect.Height - 4;

    PintarPesquisa(Canvas, LRect, Row, Column.Index);
  End;

  If Column = ColDescricao Then
  Begin
    LText  := Value.AsString;
    LWords := FindWordsList;

    Try
      If grdPesquisa.IsFocused And (Row = grdPesquisa.Selected) Then
        Canvas.Fill.Color := TAlphaColorRec.Lightskyblue
      Else
        Canvas.Fill.Color := TAlphaColorRec.White;

      Bounds.Height := 20;
      Canvas.FillRect(Bounds, 0, 0, AllCorners, 1);

      For LWord In LWords Do
      Begin
        LPositions := FindText(LWord, LText);

        For LPosition In LPositions Do
        Begin
          LRect        := Bounds;
          LRect.Left   := LRect.Left + Canvas.TextWidth(MidStr(LText, 1, LPosition - 1).Replace(' ', '.'));
          LFatorAjuste := (LRect.Left * 20.5) / 914;
          LRect.Left   := LRect.Left + LFatorAjuste;
          LRect.Width  := Canvas.TextWidth(LWord + '.');

          Canvas.Fill.Color := TAlphaColorRec.Yellow;
          Canvas.FillRect(LRect, 0, 0, AllCorners, 1);
        End;
      End;

      Canvas.Fill.Color  := TAlphaColorRec.Black;
      Canvas.Font.Family := 'Segoe UI';
      Canvas.Font.Size   := 12;
      Canvas.FillText(Bounds, LText, False, 1, [], TTextAlign.Leading);
    Finally
      FreeAndNil(LWords);
    End;
  End;

end;

procedure TfmxMenu.grdPesquisaGetValue(Sender: TObject; const Col, Row: Integer;
  var Value: TValue);
  Var
    LLista : TArrayListaPesquisa;
begin
  Value := EmptyStr;

  If ExibirFiltrados Then
    LLista := LListaPesquisaFiltro
  Else
    LLista := LListaPesquisa;

  If Not ItemPesquisaValido(Row, Col, LLista) Then
    Exit;

  Value := LLista[Row][Col]
end;

procedure TfmxMenu.grdPesquisaKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
Var
  LMenu: String;
  Copy: IFMXClipboardService;
begin
  If (grdPesquisa.Selected > -1) And
     (LListaPesquisaFiltro <> nil) And
     (grdPesquisa.Selected < Length(LListaPesquisaFiltro)) And
     (High(LListaPesquisaFiltro[grdPesquisa.Selected]) >= 2) Then
  Begin
    if (TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Copy)) then
      If (ssCtrl In Shift) And (Key In [Ord('c'), Ord('C')]) Then
        Copy.SetClipboard(TValue(LListaPesquisaFiltro[grdPesquisa.Selected][1]));

    Case Key Of
      vkReturn:
      Begin
        LMenu := LListaPesquisaFiltro[grdPesquisa.Selected][2];
        edtSearch.Text := EmptyStr;
        edtSearchExit(edtSearch);
        FechaGridPesquisa;
        objPrincipalAutcom.MenuPrincipal.Find(LMenu).ExecutarClick();

        // Tenta prevenir que a tecla continue sendo processada
        Key := 0;
        KeyChar := #0;
      End;
    End;
  End;
end;

procedure TfmxMenu.grdPesquisaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  Try
    FGridCol := grdPesquisa.ColumnByPoint(X, Y).Index;
    FGridRow := grdPesquisa.RowByPoint(X, Y);
  Except
    //Do Nothing
  End;
end;

procedure TfmxMenu.grdPesquisaMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
Var
  LCol, LRow, LIndice: Integer;
  LFavoritos: IFavoritosAutcom;
  LMenu : String;
begin
  Try
    LCol := grdPesquisa.ColumnByPoint(X, Y).Index;
    LRow := grdPesquisa.RowByPoint(X, Y);

    If (LCol = -1) Or (LRow = -1) Or (LCol <> colIcone.Index) Then
      Exit;

    If Not ItemPesquisaValido(LRow, LCol, LListaPesquisaFiltro) Then
      Exit;

    LMenu      := LListaPesquisaFiltro[LRow][2];
    LFavoritos := objPrincipalAutcom.Favoritos;
    LIndice    := LListaMenuCompleta.IndexOf(LMenu);

    If (LListaPesquisaFiltro[LRow, LCol].ToInteger = 4) Then
    Begin
      LFavoritos.RemoverFavorito(LMenu, LListaPesquisaFiltro[LRow][1]);
      LListaPesquisaFiltro[LRow, LCol] := '5';
      If ItemPesquisaValido(LIndice, LCol, LListaPesquisa) Then
        LListaPesquisa[LIndice, LCol] := '5';
    End
    Else If (LListaPesquisaFiltro[LRow, LCol].ToInteger = 5) Then
    Begin
      LFavoritos.AdicionarFavorito(LMenu, LListaPesquisaFiltro[LRow][1]);
      LListaPesquisaFiltro[LRow, LCol] := '4';
      If ItemPesquisaValido(LIndice, LCol, LListaPesquisa) Then
        LListaPesquisa[LIndice, LCol] := '4';
    End;

    objPrincipalAutcom.GerarPopupFavoritos;
    CarregarFavoritos;
    grdPesquisa.UpdateColumns;
    grdPesquisa.Repaint;
  Except
    //Do Nothing
  End;
end;

procedure TfmxMenu.Grid1GetValue(Sender: TObject; const Col, Row: Integer;
  var Value: TValue);
begin
  If ExibirFiltrados Then
  Value := LListaPesquisaFiltro[Row][Col];
end;

procedure TfmxMenu.imgSetaClick(Sender: TObject);
begin
  if (layRodapeEscondido.Width > 30) Then
  Begin
    layRodapeEscondido.Width := 30;
    imgSeta.RotationAngle    := 90;
    imgSeta.Opacity          := 0.7;
  End;
end;

procedure TfmxMenu.imgSetaMouseEnter(Sender: TObject);
begin
  if (layRodapeEscondido.Width <= 30) Then
  Begin
    layRodapeEscondido.Width := 120;
    imgSeta.RotationAngle    := 270;
    imgSeta.Opacity          := 0.2;
  End
end;

procedure TfmxMenu.lblBreadcrumbMenu1Click(Sender: TObject);
Var
  LBreadcrumbs: Integer;
begin
  if (Not FCarregandoMenu) Then
  Begin
    FCarregandoMenu := True;

  CarregarMenu(TLabel(Sender).Hint);
  RealcaBreadcrumbAberto(TLabel(Sender).Text, TLabel(Sender).Hint, TLabel(Sender));

  While (LPathMenus.Count > TLabel(Sender).Tag) Do
  Begin
    TLabel(FindComponent('lblBreadcrumbMenu' + (LPathMenus.Count).ToString())).Visible := False;
    LBreadcrumbs := LPathMenus.Count;
    LPathMenus.Delete(LBreadcrumbs-1);
    btnVoltar.Visible := LPathMenus.Count > 1;
  End;

  FLastPathMenus := LPathMenus.CommaText;

    FCarregandoMenu := False;
  End;
end;

procedure TfmxMenu.lblBreadcrumbMenu1MouseEnter(Sender: TObject);
begin
  If (TLabel(Sender).TextSettings.Font.Style = []) Then
    TLabel(Sender).FontColor := $FF3b6887;
end;

procedure TfmxMenu.lblBreadcrumbMenu1MouseLeave(Sender: TObject);
begin
  If (TLabel(Sender).TextSettings.Font.Style = []) Then
    TLabel(Sender).FontColor := $FF8E8E8E;
end;

procedure TfmxMenu.lsbxMenuCentralMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  FListBoxItemPopup := lsbxMenuCentral.ItemByPoint(X, Y);
  If Assigned(FListBoxItemPopup) Then
  Begin
    // Guarda o Hint, nao o ponteiro: o item e destruido em CarregarMenu e o campo continuaria apontando para memoria liberada.
    FHintItemPopup            := FListBoxItemPopup.Hint;
    lsbxMenuCentral.PopupMenu := popListBoxItem;
  End
  Else
  Begin
    FHintItemPopup            := EmptyStr;
    lsbxMenuCentral.PopupMenu := Nil;
  End;
end;

procedure TfmxMenu.lsbxItemModeloClick(Sender: TObject);
Var
  LCount: Integer;
  LMenu : IMenuAutcom;
  LBreadcrumb: TLabel;
  LHint : String;
begin
  if (Not FCarregandoMenu) Then
  Begin
    Try
      FCarregandoMenu := True;

      LMenu  := objPrincipalAutcom.MenuPrincipal;
      LCount := LMenu.Find(TListBoxItem(Sender).Hint).Items.Count;

      If (LCount > 0) Then
      Begin
        If Not TListBoxItem(Sender).Enabled Then
          Exit;

        LPathMenus.Add(TListBoxItem(Sender).Hint);

        LBreadcrumb := TLabel(FindComponent('lblBreadcrumbMenu' + (LPathMenus.Count).ToString()));

        If Assigned(LBreadcrumb) Then
        Begin
          LBreadcrumb.Text := '        ' + Trim(TListBoxItem(Sender).Text);
          LBreadcrumb.Hint := Trim(TListBoxItem(Sender).Hint);
          LBreadcrumb.Visible := True;
          LBreadcrumb.TextSettings.FontColor := $FF3b6887;
          LBreadcrumb.TextSettings.Font.Style := [TFontStyle.fsBold];

          If Assigned(TLabel(FindComponent('lblBreadcrumbMenu' + (LPathMenus.Count - 1).ToString()))) Then
          Begin
            LBreadcrumb := TLabel(FindComponent('lblBreadcrumbMenu' + (LPathMenus.Count - 1).ToString()));
            LBreadcrumb.TextSettings.FontColor := $FF8E8E8E;
            LBreadcrumb.TextSettings.Font.Style := [];
          End;
        End;

        // CarregarMenu() limpa lsbxMenuCentral.Items, o que destroi o proprio Sender.
        // Release o desparenta agora e adia o Free, pois o FMX ainda usa este objeto ao retornar de TCommonCustomForm.MouseUp.
        LHint := TListBoxItem(Sender).Hint;
        TListBoxItem(Sender).Release;

        CarregarMenu(LHint);
        btnVoltar.Visible := LPathMenus.Count > 1;
      End
      Else
      Begin
        LMenu.Find(TListBoxItem(Sender).Hint).ExecutarClick;
      End;

      FLastPathMenus := LPathMenus.CommaText;
      FCarregandoMenu := False;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message + ' | ' + SysErrorMessage(GetLastError));
    End;
  End;
end;

procedure TfmxMenu.lsbxItemModeloMouseEnter(Sender: TObject);
begin
  If Not FCarregandoMenu Then
  Begin
    TListBoxItem(Sender).BeginUpdate;
    TListBoxItem(Sender).Font.Style := [TFontStyle.fsBold, TFontStyle.fsUnderline];
    TListBoxItem(Sender).EndUpdate;
  End;
end;

procedure TfmxMenu.lsbxItemModeloMouseLeave(Sender: TObject);
begin
  TListBoxItem(Sender).BeginUpdate;
  TListBoxItem(Sender).Font.Style := [];
  TListBoxItem(Sender).EndUpdate;
end;

procedure TfmxMenu.lsbxFavorito1Click(Sender: TObject);
Var
  LFavorito: IItemMenuAutcom;
  LHint : String;
begin
  DefineStatusActionAtalhos(False);
  TravarTelaPrincipal(True);

  if (Not FCarregandoMenu) Then
  Begin
    Try
      FCarregandoMenu := True;

      If (Trim(TListBoxItem(Sender).Hint).Contains('Ctrl')) Then
      Begin
        FechaGridPesquisa;
        // Remove indicaÁ„o da tecla de atalho - Ex: CTRL+1
        LHint := Trim(LeftStr(Trim(TListBoxItem(Sender).Hint), Length(Trim(TListBoxItem(Sender).Hint)) - 9));
      End
      Else
        LHint := Trim(TListBoxItem(Sender).Hint);

      For LFavorito In objPrincipalAutcom.Favoritos.Items Do
      Begin
        Try
          If LHint = Trim(LFavorito.Caption) Then
          Begin
            popMenuCentral.IsOpen := False;
            LFavorito.ExecutarClick;
            Break;
          End;
        Except
          // do nothing
        End;
      End;

      FCarregandoMenu := False;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message + ' | ' + SysErrorMessage(GetLastError));
    End;
  End;

  TravarTelaPrincipal(False);
  DefineStatusActionAtalhos(True);
end;

procedure TfmxMenu.lsbxFavorito1MouseEnter(Sender: TObject);
Var
  LLabel: TLabel;
  LImage: TImage;
  LIndex, LNomeComponente: String;
begin
  // Remove prefixo e sufixo do nome do componente.
  // Ex: lsbxFavorito1 -> Favorito
  LNomeComponente := Copy(TListBoxItem(Sender).Name,5,30);
  LNomeComponente := LeftStr(LNomeComponente, Length(LNomeComponente) - Length(TListBoxItem(Sender).Tag.ToString()));

  LIndex := TListBoxItem(Sender).Tag.ToString();
  LLabel := TLabel(FindComponent('lbl' + LNomeComponente + LIndex));
  LImage := TImage(FindComponent('img' + LNomeComponente + LIndex));
  RealcaLinkLista(LImage, LLabel, True);
end;

procedure TfmxMenu.lsbxFavorito1MouseLeave(Sender: TObject);
Var
  LLabel: TLabel;
  LImage: TImage;
  LIndex, LNomeComponente: String;
begin
  // Remove prefixo e sufixo do nome do componente.
  // Ex: lsbxFavorito1 -> Favorito
  LNomeComponente := Copy(TListBoxItem(Sender).Name,5,30);
  LNomeComponente := LeftStr(LNomeComponente, Length(LNomeComponente) - Length(TListBoxItem(Sender).Tag.ToString()));

  LIndex := TListBoxItem(Sender).Tag.ToString();
  LLabel := TLabel(FindComponent('lbl' + LNomeComponente + LIndex));
  LImage := TImage(FindComponent('img' + LNomeComponente + LIndex));
  RealcaLinkLista(LImage, LLabel, False);
end;

// Remove indicaÁ„o da tecla de atalho - Ex: (SHIFT+F1)
function fRemoveIndicacaoAtalho(const AHint: String): String;
Var
  LPos: Integer;
begin
  Result := Trim(AHint);

  If Not EndsText(')', Result) Then
    Exit;

  LPos := LastDelimiter('(', Result);

  If (LPos > 1) Then
    Result := Trim(Copy(Result, 1, Pred(LPos)));
end;

procedure TfmxMenu.lsbxRecente1Click(Sender: TObject);
Var
  LRecentes    : IRecentesAutcom;
  LRecente     : IItemMenuAutcom;
  LSelecionado : IItemMenuAutcom;
  LCleanHint   : String;
begin
  DefineStatusActionAtalhos(False);
  TravarTelaPrincipal(True);
  Try
    FechaGridPesquisa;

    LCleanHint := fRemoveIndicacaoAtalho(TListBoxItem(Sender).Hint);

    LSelecionado := Nil;
    LRecentes    := objPrincipalAutcom.Recentes;

    For LRecente In LRecentes.Items Do
      If LCleanHint = Trim(LRecente.Caption) Then
      Begin
        LSelecionado := LRecente;
        Break;
      End;

    If Assigned(LSelecionado) Then
      LSelecionado.ExecutarClick;
  Finally
    TravarTelaPrincipal(False);
    DefineStatusActionAtalhos(True);
  End;
end;

procedure TfmxMenu.lsbxVerMaisClick(Sender: TObject);
Var
  LMenu : IFavoritosAutcom;
begin
  FechaGridPesquisa;

  LMenu  := objPrincipalAutcom.Favoritos;
  RealcaBreadcrumbAberto('Favoritos', 'mnuFavoritos', lblBreadcrumbMenu1);
  AbreMenuCentralFavoritos;
  LPathMenus.Add('mnuFavoritos');
  FLastPathMenus := LPathMenus.CommaText;
end;

procedure TfmxMenu.imgGrupoFavoritosClick(Sender: TObject);
Var
  LLayout : TLayout;
  LItens  : Integer;
  LFavoritos: IFavoritosAutcom;
  LRecentes : IRecentesAutcom;
begin
  If ContainsText(TImage(Sender).Name, 'Favorito') Then
  Begin
    LFavoritos := objPrincipalAutcom.Favoritos;
    LItens     := LFavoritos.Items.Count;
  End
  else
  Begin
    LRecentes  := objPrincipalAutcom.Recentes;
    LItens     := LRecentes.Items.Count;
  End;

  If LItens > 10 Then
    LItens := 10;

  LLayout := TLayout(FindComponent('lay' + Copy(TImage(Sender).Name, 9, 30)));

  If (LLayout.Height > 25) Then
  Begin
    LLayout.Height               := 25;
    TImage(Sender).RotationAngle := 0;
    layLateral.Height            := layLateral.Height - ((LItens * 18) + 3);
  End
  Else
  Begin
    LLayout.Height               := (LItens * 18) + 28;
    TImage(Sender).RotationAngle := 180;
    layLateral.Height            := layLateral.Height + ((LItens * 18) + 3);
  End;
end;

procedure TfmxMenu.imgLogoFundoClick(Sender: TObject);
begin
  FechaGridPesquisa;
end;

procedure TfmxMenu.imgLogoFundoDblClick(Sender: TObject);
begin
  TAnimator.AnimateFloatWait(imgLogoFundo, 'Width', 605, 1.25, TAnimationType.Out, TInterpolationType.Bounce);
  Sleep(1000);
  TAnimator.AnimateFloat(imgLogoFundo, 'Width', 230, 1, TAnimationType.In, TInterpolationType.Back);
end;

procedure TfmxMenu.imgmnuCadClientesClick(Sender: TObject);
begin
  ClicarIconeLateral(Sender);
end;

procedure TfmxMenu.imgmnuCadClientesMouseEnter(Sender: TObject);
Var
  efeito : TShadowEffect;
begin
  efeito := TShadowEffect(FindComponent('som' + Copy(TImage(Sender).Name,7)));
  If Assigned(efeito) Then
    efeito.Enabled := True;
end;

procedure TfmxMenu.imgmnuCadClientesMouseLeave(Sender: TObject);
Var
  efeito : TShadowEffect;
begin
  efeito := TShadowEffect(FindComponent('som' + Copy(TImage(Sender).Name,7)));
  If Assigned(efeito) Then
    efeito.Enabled := False;
end;

procedure TfmxMenu.imgmnuWMSClick(Sender: TObject);
Var
  Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popWMS.Popup(Posicao.X + 40, Posicao.Y + 10);
end;

procedure TfmxMenu.MostraMensagemTEF(AMensagem: String);
begin
  lblMensagemTEF.Text    := '      ' + AMensagem;
end;

procedure TfmxMenu.MostraPesquisa;
begin
  linLeft.StrokeThickness   := 0.3;
  linRight.StrokeThickness  := 0.3;
  linBottom.StrokeThickness := 0.3;
end;

procedure TfmxMenu.MoveCursor(Key: Word);
Var
  LText: String;
begin
  PiscaCursor;

  edtSearch.Canvas.Font.Family := edtSearch.Font.Family;
  edtSearch.Canvas.Font.Size   := edtSearch.Font.Size;

  Case Key Of
    vkEnd  : linSearchCursor.Position.X := edtSearch.Canvas.TextWidth(String(edtSearch.Text).Replace(' ', '.')) + 2.5;
    vkHome : linSearchCursor.Position.X := 2.5;

    vkLeft, vkRight, vkNone:
    Begin
      If Key = vkLeft Then
        LText := Copy(String(edtSearch.Text).Replace(' ', '.'), 1, (edtSearch.CaretPosition - 1))
      Else If Key = vkRight Then
        LText := Copy(String(edtSearch.Text).Replace(' ', '.'), 1, (edtSearch.CaretPosition + 1))
      Else
        LText := Copy(String(edtSearch.Text).Replace(' ', '.'), 1, (edtSearch.CaretPosition));

      linSearchCursor.Position.X := edtSearch.Canvas.TextWidth(LText) + 2.5;
    End;
  End;
end;

procedure TfmxMenu.CriaDashboardAntiga(objDash: IDashboard);
begin
  Try
    fmxDashboardPrincipalOld := TfmxDashboardPrincipalOld.Create(Self);
    fmxDashboardPrincipalOld.blnUsuarioLogadoUtilizaModoClassico := False;
    fmxDashboardPrincipalOld.objDash                             := objDash;
    fmxDashboardPrincipalOld.Width                               := Screen.WorkAreaWidth;
    fmxDashboardPrincipalOld.Height                              := Screen.WorkAreaHeight - 25;
    fmxDashboardPrincipalOld.scrBarraRolagem.Height              := Screen.WorkAreaHeight - 25;
    fmxDashboardPrincipalOld.scrBarraRolagem.Width               := Screen.WorkAreaWidth;
    fmxDashboardPrincipalOld.ClientWidth                         := Screen.WorkAreaWidth - 100;
    fmxDashboardPrincipalOld.ClientHeight                        := Screen.WorkAreaHeight - 100;
    fmxDashboardPrincipalOld.WindowState                         := TWindowState.wsMaximized;
    fmxDashboardPrincipalOld.Tag                                 := 1;
    fmxDashboardPrincipalOld.recComCusto.Enabled                 := objPrincipalAutcom.VerificaAcessoSistema('mnuFiltroComCus');

    If objPrincipalAutcom.VerificaAcessoSistema('mnuAbaLojas') Then
      fmxDashboardPrincipalOld.btnAbaLoja.Tag := 1;

    fmxDashboardPrincipalOld.ShowModal;
  Finally
    FreeAndNil(fmxDashboardPrincipalOld);
    objPrincipalAutcom.GerarPopupRecentes;
    CarregarRecentes;
  End;
end;

procedure TfmxMenu.CriaDashboardWeb;
begin
  Try
    fmxDashboardPrincipal := TfmxDashboardPrincipal.Create(Self);
    fmxDashboardPrincipal.blnUsuarioLogadoUtilizaModoClassico := False;
    fmxDashboardPrincipal.objDash                             := objDash;
    fmxDashboardPrincipal.Width                               := Screen.WorkAreaWidth;
    fmxDashboardPrincipal.Height                              := Screen.WorkAreaHeight - 25;
    fmxDashboardPrincipal.scrBarraRolagem.Height              := Screen.WorkAreaHeight - 25;
    fmxDashboardPrincipal.scrBarraRolagem.Width               := Screen.WorkAreaWidth;
    fmxDashboardPrincipal.ClientWidth                         := Screen.WorkAreaWidth - 100;
    fmxDashboardPrincipal.ClientHeight                        := Screen.WorkAreaHeight - 100;
    fmxDashboardPrincipal.WindowState                         := TWindowState.wsMaximized;
    fmxDashboardPrincipal.Tag                                 := 1;
    fmxDashboardPrincipal.recComCusto.Enabled                 := objPrincipalAutcom.VerificaAcessoSistema('mnuFiltroComCus');

    If objPrincipalAutcom.VerificaAcessoSistema('mnuAbaLojas') Then
      fmxDashboardPrincipal.btnAbaLoja.Tag := 1;

    fmxDashboardPrincipal.ShowModal;
  Finally
    FreeAndNil(fmxDashboardPrincipal);
    objPrincipalAutcom.GerarPopupRecentes;
    CarregarRecentes;
  End;
end;

procedure TfmxMenu.PintarPesquisa(Canvas: TCanvas; Rect: TRectF; Linha, Coluna: Integer);
  Var
    LLista : TArrayListaPesquisa;
begin
  If ExibirFiltrados Then
    LLista := LListaPesquisaFiltro
  Else
    LLista := LListaPesquisa;

  If Not ItemPesquisaValido(Linha, Coluna, LLista) Then
    Exit;

  lstIcones.Draw(Canvas, Rect, LLista[Linha, Coluna].ToInteger)
end;

procedure TfmxMenu.PiscaCursor;
begin
  linSearchCursor.Tag := 1;
end;

procedure TfmxMenu.popMenuCentralClosePopup(Sender: TObject);
Var
  LIndice: Integer;
begin
  LPathMenus.Clear;
  For LIndice := 1 To 6 Do
    TLabel(FindComponent('lblBreadcrumbMenu' + LIndice.ToString())).Visible := False;
end;

procedure TfmxMenu.popMenuCentralPopup(Sender: TObject);
begin
  btnFecharMenu.Opacity := 0.2;
  btnVoltar.Opacity     := 0.2;
  lblBreadcrumbMenu1.Visible := True;
end;

procedure TfmxMenu.RealcaBreadcrumbAberto(Text, Hint: String; Breadcrumb: TLabel);
begin
  Breadcrumb.Text := '        ' + Trim(Text);
  Breadcrumb.Hint := Trim(Hint);
  Breadcrumb.TextSettings.FontColor := $FF3b6887;
  Breadcrumb.TextSettings.Font.Style := [TFontStyle.fsBold];
end;

procedure TfmxMenu.RealcaLinkLista(icone: TImage; texto: TLabel; Realca: Boolean);
begin
  If Realca Then
  Begin
    texto.TextSettings.Font.Style := [TFontStyle.fsUnderline];

    If Assigned(icone) Then
      icone.Opacity := 1;
  End
  Else
  Begin
    texto.TextSettings.Font.Style := [];

    If Assigned(icone) Then
      icone.Opacity := 0.2;
  End;
end;

procedure TfmxMenu.Recreate;
Var
  LField: TRttiField;
begin
  inherited;
  If Not (csDesigning in ComponentState) Then
  Begin
    LField := TRttiContext.create.GetType(TCommonCustomForm).GetField('FSharedHint');
    LField.GetValue(TCommonCustomForm(Self)).AsObject.Free;
    LField.SetValue(TCommonCustomForm(Self), TValue.From(TLabelHint.CreateHint(Self)));
  End;
end;

procedure TfmxMenu.RestaurarUltimoMenuCentral;
Var
  I: Integer;
  LMenu: String;
  LMenus: TArray<String>;
  LObject: TObject;
begin
  LMenus := FLastPathMenus.Split([',']);
  For LMenu In LMenus Do
  Begin
    LObject := Self.FindComponent(LMenu);

    If Assigned(LObject) And (LObject Is TSpeedButton) Then
    Begin
      TSpeedButton(LObject).OnClick(LObject);
      Continue;
    End;

    For I := 0 To pnlFundoMenuTopo.ControlsCount -1 Do
    Begin
      LObject := pnlFundoMenuTopo.Controls[I];
      If (LObject Is TSpeedButton) Then
        If (TSpeedButton(LObject).TagString.ToLower = LMenu.ToLower) Then
        Begin
          TSpeedButton(LObject).OnClick(LObject);
          Break;
        End;
    End;

    For I := 0 To lsbxMenuCentral.ComponentCount -1 Do
    Begin
      LObject := lsbxMenuCentral.Components[I];
      If (LObject Is TListBoxItem) Then
        If (TListBoxItem(LObject).Hint.ToLower = LMenu.ToLower) Then
        Begin
          TListBoxItem(LObject).OnClick(LObject);
          Break;
        End;
    End;
  End;
end;

function TfmxMenu.RetornaIconeIndex(Menu: String; TemSubmenus: Boolean): Integer;
begin
  Result := 2;

  If (TemSubmenus) Then
    Result := 1;

  If (Menu = '[ Criar Novo RelatÛrio ]') Then
    Result := 6;

  If (Menu = 'Favoritos') Then
    Result := 4;
end;

function TfmxMenu.RetornaSaudacaoUsuario: String;
Var
  User, Split: String;
begin
  Split := '';
  If Not objPrincipalAutcom.NomeUsuario.IsEmpty Then
    Split:= objPrincipalAutcom.NomeUsuario.Split([' '])[0];

  User := AnsiLowerCase(Split);
  User := AnsiUpperCase(Copy(User,1,1)) + Copy(User,2,20);

  If IsPM(nOw) Then
    If (HourOf(nOw) >= 18) Then
      Result := 'Boa noite, ' + User + '!'
    Else
      Result := 'Boa tarde, ' + User + '!'
  Else
    Result := 'Bom dia, ' + User + '!';
end;

procedure TfmxMenu.shaSearchMouseEnter(Sender: TObject);
begin
  if (Not edtSearch.IsFocused) And (edtSearch.Text = EmptyStr) Then
    MostraPesquisa;
end;

procedure TfmxMenu.shaSearchMouseLeave(Sender: TObject);
begin
  if (Not edtSearch.IsFocused)  And (edtSearch.Text = EmptyStr) Then
    EscondePesquisa;
end;

procedure TfmxMenu.TimerDinamico(ID: Integer; Intervalo: Integer; Ativado: Boolean);
begin
  if Ativado then
    SetTimer(ApplicationHWND, ID, Intervalo, @TimerMensagem)
  else
    KillTimer(ApplicationHWND, ID);
end;

procedure TfmxMenu.TravarTelaPrincipal(Ligar: Boolean);
begin
  recTravaTela.Visible := Ligar;
end;

procedure TfmxMenu.TrocaIconeMenuLateral(Sender: TObject; Mostrar: Boolean);
Var
  imgLine, imgFull: TImage;
begin
  imgLine := Nil;
  imgFull := Nil;

  If (Sender is TSpeedButton) Then
  Begin
    Case TSpeedButton(Sender).Tag Of
      1:
      Begin
        imgLine := imgDashboardLine;
        imgFull := imgDashboardFull;
      End;
      2:
      Begin
        imgLine := imgCadastrosLine;
        imgFull := imgCadastrosFull;
      End;
      3:
      Begin
        imgLine := imgFaturamentoLine;
        imgFull := imgFaturamentoFull;
      End;
      4:
      Begin
        imgLine := imgTeleatendimentoLine;
        imgFull := imgTeleatendimentoFull;
      End;
      5:
      Begin
        imgLine := imgControleFinanceiroLine;
        imgFull := imgControleFinanceiroFull;
      End;
      6:
      Begin
        imgLine := imgCancelamentosLine;
        imgFull := imgCancelamentosFull;
      End;
      7:
      Begin
        imgLine := imgLivroFiscalLine;
        imgFull := imgLivroFiscalFull;
      End;
      8:
      Begin
        imgLine := imgMovimentacaoLine;
        imgFull := imgMovimentacaoFull;
      End;
      9:
      Begin
        imgLine := imgFechamentosLine;
        imgFull := imgFechamentosFull;
      End;
      10:
      Begin
        imgLine := imgTintaMaquinaLine;
        imgFull := imgTintaMaquinaFull;
      End;
      11:
      Begin
        imgLine := imgContabilidadeLine;
        imgFull := imgContabilidadeFull;
      End;
      12:
      Begin
        imgLine := imgCRMLine;
        imgFull := imgCRMFull;
      End;
      13:
      Begin
        imgLine := imgPainelEntregasLine;
        imgFull := imgPainelEntregasFull;
      End;
    End;

    If Mostrar Then
    Begin
      imgLine.Opacity := 0;
      imgFull.Opacity := 1;
    End
    Else
    Begin
      imgLine.Opacity := 1;
      imgFull.Opacity := 0;
    End;
  End;
end;

procedure TfmxMenu.AbreGridPesquisa(Linhas:Integer);
Var
  LHeight: Double;
begin
  If (Not ExibirFiltrados) And (layGridPesquisa.Height > 39) Then
  Begin
    layGridPesquisa.Height := 39;
    linLeft.Visible   := False;
    linRight.Visible  := False;
    linBottom.Visible := False;
  End
  Else If (ExibirFiltrados) Then
  Begin
    If (Linhas >= 10) Then
      LHeight := 252
    else
      LHeight := (Linhas * 21) + 42;

    linLeft.Visible   := True;
    linRight.Visible  := True;
    linBottom.Visible := True;
    layGridPesquisa.Height := LHeight;
  End;
end;

procedure TfmxMenu.AbreMenuCentral(LNomeMenu: String);
begin
  if (Not FCarregandoMenu) Then
  Begin
    FCarregandoMenu := True;

    popMenuCentral.IsOpen := False;

    lsbxMenuCentral.Columns      := (Trunc(layFundo.Height - 40) Div 20);
    popMenuCentral.Width  := layMenuTopo.Width;
    popMenuCentral.Height := layFundo.Height;
    popMenuCentral.Popup();

    btnVoltar.Visible := False;

    CarregarMenu(LNomeMenu);

    FCarregandoMenu := False;
  End;
end;

procedure TfmxMenu.AbreMenuCentralFavoritos;
begin
  if (Not FCarregandoMenu) Then
  Begin
    FCarregandoMenu := True;

    popMenuCentral.IsOpen := False;

    lsbxMenuCentral.Columns      := (Trunc(layFundo.Height - 40) Div 20);
    popMenuCentral.Width  := layMenuTopo.Width;
    popMenuCentral.Height := layFundo.Height;
    popMenuCentral.Popup();

    btnVoltar.Visible := False;

    CarregarMenuFavoritos;

    FCarregandoMenu := False;
  End;

end;

procedure TfmxMenu.actManCadastrosExecute(Sender: TObject);
Var
  LButton: TSpeedButton;
begin
  FechaGridPesquisa;

  LButton := TSpeedButton(FindComponent('mnu' + Copy(TAction(Sender).Name,4,30)));

  If Assigned(LButton) And (LButton.Visible) Then
    mnuManCadastrosClick(LButton);
end;

procedure TfmxMenu.actMenuTopo1Execute(Sender: TObject);
Var
  LButton: TSpeedButton;
begin
  LButton := TSpeedButton(FindComponent('btn' + Copy(TAction(Sender).Name,4,30)));

  If Assigned(LButton) And (LButton.Visible) Then
    btnMenuTopo1Click(LButton);
end;

procedure TfmxMenu.actMessagesExecute(Sender: TObject);
begin
  TravarTelaPrincipal(True);

  FechaGridPesquisa;
  objPrincipalAutcom.MenuPrincipal.Find('mnuMensagensRecebidas').ExecutarClick;

  TravarTelaPrincipal(False);
end;

procedure TfmxMenu.actNewsExecute(Sender: TObject);
begin
  fmxNotificacao := TfmxNotificacao.Create(nil);
  Try
    fmxNotificacao.Left := Screen.WorkAreaRect.Width - 400;
    fmxNotificacao.Top  := Screen.WorkAreaRect.Height - (FMXNotificacao.Height - 31);
    fmxNotificacao.layFundo.Position.X := fmxNotificacao.Width + 5;
    fmxNotificacao.tipNotificacao := 3;
    fmxNotificacao.ShowModal;
  Finally
    FreeAndNil(fmxNotificacao);
  End;
end;

procedure TfmxMenu.actCitelDeskExecute(Sender: TObject);
begin
  TravarTelaPrincipal(True);

  FechaGridPesquisa;
  objPrincipalAutcom.AbrirCitelDesk;

  TravarTelaPrincipal(False);
end;

procedure TfmxMenu.actDashboardExecute(Sender: TObject);
Var
  objDash: IDashboard;
begin
  If (Not Assigned(objDash)) Then
    objDash := objPrincipalAutcom.GerarDashboard;

  If objDash.TemRelatorioConfiguradoParaDashboard Then
  Begin
    TravarTelaPrincipal(True);

    FechaGridPesquisa;

    If (objDash.CfgSis('DASWEB') = 'S') Then
      CriaDashboardWeb(objDash)
    Else
      CriaDashboardAntiga(objDash);

    TravarTelaPrincipal(False);
  End;
end;

procedure TfmxMenu.actEmailExecute(Sender: TObject);
begin
  TravarTelaPrincipal(True);

  FechaGridPesquisa;
  objPrincipalAutcom.MenuPrincipal.Find('mnuEnviaEmail').ExecutarClick();

  TravarTelaPrincipal(False);
end;

procedure TfmxMenu.actFavorito1Execute(Sender: TObject);
Var
  LListItem: TListBoxItem;
  LIndex: String;
begin
  LIndex := TAction(Sender).Tag.ToString();
  LListItem := TListBoxItem(FindComponent('lsbxFavorito' + LIndex));

  If LListItem.Visible Then
    lsbxFavorito1Click(LListItem);
end;

procedure TfmxMenu.actInformationExecute(Sender: TObject);
begin
  TravarTelaPrincipal(True);

  FechaGridPesquisa;

  Try
    fmxSobre := TfmxSobre.Create(Self);
    fmxSobre.lblConexao.Text := 'Conex„o: ' + objPrincipalAutcom.IDConexao;
    fmxSobre.lblRevisao.Text := 'Revis„o: ' + objPrincipalAutcom.Revisao;
    fmxSobre.lblVersao.Text  := 'Vers„o.: ' + objPrincipalAutcom.Versao;
    fmxSobre.ShowModal;
  Finally
    fmxSobre.Free;
  End;

  TravarTelaPrincipal(False);
end;

procedure TfmxMenu.DefineStatusActionAtalhos(const AEnabled : Boolean);
  var
    intCnt : Integer;
begin
  for intCnt := 0 to Pred(actAtalhos.ActionCount) do
    actAtalhos.Actions[intCnt].Enabled := AEnabled;
end;

procedure TfmxMenu.actLogoutExecute(Sender: TObject);
begin
  DefineStatusActionAtalhos(False);
  TravarTelaPrincipal(True);

  FechaGridPesquisa;
  objPrincipalAutcom.MenuPrincipal.Find('mnuLogoff').ExecutarClick();
  AtualizaVisibilidadePanelTef;

  TravarTelaPrincipal(False);
  DefineStatusActionAtalhos(True);
end;

procedure TfmxMenu.actPainelEntregasExecute(Sender: TObject);
Var
  objDash: IDashboard;
  objFuncoes: IFuncoes;
begin
  If (mnuPainelEntregas.Visible) Then
  Begin
    TravarTelaPrincipal(True);

    FechaGridPesquisa;

    If Assigned(fmxPainelEntregas) Then
      Exit;

    If (Not Assigned(objDash)) Then
      objDash := objPrincipalAutcom.GerarDashboard;

    If (Not Assigned(objFuncoes)) Then
      objFuncoes := objPrincipalAutcom.GerarFuncoesFiremonkey;

    fmxPainelEntregas := TfmxPainelEntregas.Create(Self);
    try
      fmxPainelEntregas.objFuncoes             := objFuncoes;
      fmxPainelEntregas.strGoogleAPIKey        := objPrincipalAutcom.GoogleAPIKey;
      fmxPainelEntregas.strLoginUsuarioLogado  := objPrincipalAutcom.LoginUsuarioLogado;
      fmxPainelEntregas.strNomeUsuarioLogado   := objPrincipalAutcom.NomeUsuario;
      fmxPainelEntregas.TaEntregue             := objTaEntregue;
      fmxPainelEntregas.TaEntregueRefresh      := objTaEntregueRefresh;
      fmxPainelEntregas.Position               := FMX.Forms.TFormPosition.Designed;
      fmxPainelEntregas.ClientWidth            := 1024;
      fmxPainelEntregas.ClientHeight           := 768;
      fmxPainelEntregas.WindowState            := TWindowState.wsMaximized;
      fmxPainelEntregas.scrBarraRolagem.Height := Screen.WorkAreaHeight;
      fmxPainelEntregas.scrBarraRolagem.Width  := Screen.WorkAreaWidth;
      fmxPainelEntregas.Tag                    := 1;
      fmxPainelEntregas.Top                    := Round((Screen.DesktopHeight / 2) - 384);
      fmxPainelEntregas.Left                   := Round((Screen.DesktopWidth / 2) - 512);
      fmxPainelEntregas.recBotaoFiltros.Tag    := 0;
      fmxPainelEntregas.edtDataIni.Text        := DateToStr(Today);
      fmxPainelEntregas.edtDataFim.Text        := DateToStr(Today);
      fmxPainelEntregas.edtDataIniDash.Text    := DateToStr(StartOfaMonth(YearOf(Today), MonthOf(Today)));
      fmxPainelEntregas.edtDataFinDash.Text    := DateToStr(Today);
      fmxPainelEntregas.strEmpLogada           := objPrincipalAutcom.CodigoEmpresaLogada;
      fmxPainelEntregas.objDash                := objDash;
      fmxPainelEntregas.HabilitaDashboard;
      fmxPainelEntregas.MostrarFiltros;

      If Not Self.strNumRom.IsEmpty Then
        fmxPainelEntregas.AtualizaRomaneios(IncYear(Today,-5), Today, Self.strNumRom)
      Else
        fmxPainelEntregas.AtualizaRomaneios(Today, Today);

      fmxPainelEntregas.NotificaNovasMensagens;
      fmxPainelEntregas.ShowModal;
    finally
      FreeAndNil(fmxPainelEntregas);
      objPrincipalAutcom.GerarPopupRecentes;
      CarregarRecentes;
    End;

    TravarTelaPrincipal(False);
  End;
end;

procedure TfmxMenu.actPedLiberacaoExecute(Sender: TObject);
begin
  TravarTelaPrincipal(True);

  FechaGridPesquisa;
  objPrincipalAutcom.MenuPrincipal.Find('mnuPedLiberacao').ExecutarClick;

  TravarTelaPrincipal(False);
end;

procedure TfmxMenu.actPesquisarExecute(Sender: TObject);
begin
  edtSearch.SetFocus;
end;

procedure TfmxMenu.actRecente1Execute(Sender: TObject);
Var
  LListItem: TListBoxItem;
  LIndex: String;
begin
  LIndex := TAction(Sender).Tag.ToString();
  LListItem := TListBoxItem(FindComponent('lsbxRecente' + LIndex));

  If LListItem.Visible Then
    lsbxRecente1Click(LListItem);
end;

procedure TfmxMenu.actRodapeClientesExecute(Sender: TObject);
Var
  LImage: TImage;
begin
  LImage := TImage(FindComponent(TAction(Sender).Hint));
  ClicarIconeLateral(LImage);
end;

procedure TfmxMenu.actSettingsExecute(Sender: TObject);
begin
  TravarTelaPrincipal(True);

  FechaGridPesquisa;
  objPrincipalAutcom.MenuPrincipal.Find('mnuCadConfiguracoes').ExecutarClick();

  TravarTelaPrincipal(False);
end;

procedure TfmxMenu.AddMenuPopup(AMenu: IItemMenuAutcom; APopup: TPopupMenu; APopupItem: TMenuItem = Nil);
Var
  LIndex : Integer;
  mnuNovo: TMenuItem;
begin
  mnuNovo           := TMenuItem.Create(Self);
  mnuNovo.Text      := Trim(AMenu.Caption);
  mnuNovo.Hint      := Trim(AMenu.Hint);
  mnuNovo.TagString := Trim(AMenu.Name);
  mnuNovo.Name      := Trim(AMenu.Name);
  mnuNovo.OnClick   := ClicarMenuPopup;

  If Assigned(APopupItem) Then
    APopupItem.AddObject(mnuNovo)
  Else
    APopup.AddObject(mnuNovo);

  If (AMenu.Items.Count > 0) Then
    For LIndex := 1 To AMenu.Items.Count Do
    Begin
      AddMenuPopup(AMenu.Items[Pred(LIndex)], APopup, mnuNovo)
    End;
end;

procedure TfmxMenu.AjustaLayoutMenuLateral;
begin
  layLateral.Height := (layMenuLateral.Height + 35) +
                       (layFavoritos.Height + 35) +
                       (layRecentes.Height + 35);
end;

procedure TfmxMenu.AtualizarQuantidadeMensagens(AValue: Integer);
begin
  pnlNotificacoes.Visible := AValue > 0;
  lblNotificacoes.Visible := AValue > 0;
  lblNotificacoes.Text := AValue.ToString;
end;

procedure TfmxMenu.AtualizarQuantidadePedLiberacao(AValue: Integer);
begin
  pnlNotifPedLiberacao.Visible := AValue > 0;
  lblNotifPedLiberacao.Visible := AValue > 0;
  lblNotifPedLiberacao.Text    := AValue.ToString;
end;


{***************************************************}
{* QUADRO DE LICENCAS NO RODAPE DA TELA NOVA       *}
{* Os dados vem prontos do host por IQuadroLicencas*}
{* - a mesma fonte da versao classica. Falha aqui  *}
{* nao pode impedir a abertura da tela.            *}
{***************************************************}
procedure TfmxMenu.AtualizarQuadroLicencas;
begin
  Try
    If Not Assigned(objPrincipalAutcom) Then
      Exit;

    If Not Assigned(FobjQuadroLicencas) Then
      FobjQuadroLicencas := TQuadroLicencasFMX.Create(layFundo);

    FobjQuadroLicencas.pAtualizar(objPrincipalAutcom.GerarQuadroLicencas);

    { lblSaudacao tem Align Client com AutoSize e transborda layInformacoes por
      cima do quadro, entao os dois nao convivem no mesmo canto }
    lblSaudacao.Visible := Not FobjQuadroLicencas.fVisivel;
  Except
    On E: Exception Do
    Begin
      { o quadro e informativo e nao derruba a tela, mas o erro tem de ficar
        registrado. Nesta versao objFuncoes nao e campo do form, entao o
        IFuncoes vem do host na hora }
      If Assigned(objPrincipalAutcom) Then
        objPrincipalAutcom.GerarFuncoesFiremonkey.GravarLogErro(
          E.ClassName + ' - ' + E.Message, 'TfmxMenu.AtualizarQuadroLicencas');
    End;
  End;
end;

procedure TfmxMenu.AtualizarTela(ARecarregaListaDePesquisa: Boolean = False);
begin
  Self.Caption        := objPrincipalAutcom.Titulo;
  lblBanco.Text       := strEspaco + objPrincipalAutcom.BancoDeDados;
  lblIP.Text          := strEspaco + objPrincipalAutcom.IP;
  lblConexao.Text     := strEspaco + objPrincipalAutcom.IDConexao;
  lblDiretorio.Text   := strEspaco + objPrincipalAutcom.DiretorioExecutavel;

  recFundoMenuLateral.Fill.Color := objPrincipalAutcom.CorIdentificacaoEmpresa;

  CarregarFavoritos;
  CarregarRecentes;
  CarregaMenuTopo;
  CarregaMenuLateral;
  CarregaBarraFerramentas;
  CarregaBotoesAtalhoLateral;
  CarregaMenusPopUp;

  If ARecarregaListaDePesquisa Then
    CarregaListaDePesquisa;

  AtualizarQuadroLicencas;
end;

procedure TfmxMenu.mnuDireitosAcessoGridPesquisaClick(Sender: TObject);
Var
  LMenu: String;
begin
  Try
    If (FGridCol = -1) Or (FGridRow = -1) Then
      Exit;

    LMenu := LListaPesquisaFiltro[FGridRow][2];

    objPrincipalAutcom.MenuPrincipal.Find(LMenu).EditarPermissoesAcesso;
  Except
    //Do Nothing
  End;
end;

procedure TfmxMenu.mnuDireitosAcessoListBoxItemClick(Sender: TObject);
begin
  Try
    If (FHintItemPopup <> EmptyStr) Then
    Begin
      objPrincipalAutcom.MenuPrincipal.Find(FHintItemPopup).EditarPermissoesAcesso;
      RestaurarUltimoMenuCentral;
    End;
  Except
    //Do Nothing
  End;
end;

procedure TfmxMenu.AtualizaVisibilidadePanelTef;
begin
  lblMensagemTEF.Visible := objPrincipalAutcom.PanelTEFIsVisible;
  lblTEFInativo.Visible := not objPrincipalAutcom.PanelTEFIsVisible and objPrincipalAutcom.TEFIsEnabled;
end;

procedure TfmxMenu.mnuManCadastrosClick(Sender: TObject);
Var
  LCount: Integer;
  LMenu : IMenuAutcom;
  LItem : IItemMenuAutcom;
begin
  LMenu  := objPrincipalAutcom.MenuPrincipal;
  LCount := 0;

  If Assigned(LMenu) Then
  Begin
    LItem := LMenu.Find(TSpeedButton(Sender).Name);

    If Assigned(LItem) Then
    Begin
      If (TSpeedButton(Sender).Name = 'mnuTintaDeMaquina') Then
        LItem.ExecutarClick;

      LCount := LItem.Items.Count;
    End;
  End;

  If (TSpeedButton(Sender).Name = 'mnuDashboard') Or
     (TSpeedButton(Sender).Name = 'mnuPainelEntregas') Then
    LMenu.Find(TSpeedButton(Sender).Name).ExecutarClick

  Else
  Begin
    If (LCount <= 0) Then
      LMenu.Find(TSpeedButton(Sender).Name).ExecutarClick
    Else
    Begin
      RealcaBreadcrumbAberto(TSpeedButton(Sender).Text, TSpeedButton(Sender).Name, lblBreadcrumbMenu1);

      AbreMenuCentral(TSpeedButton(Sender).Name);
      LPathMenus.Add(TSpeedButton(Sender).Name);
    End;
  End;

  FLastPathMenus := LPathMenus.CommaText;
end;

procedure TfmxMenu.mnuManCadastrosMouseEnter(Sender: TObject);
begin
  TrocaIconeMenuLateral(Sender, True);
end;

procedure TfmxMenu.mnuManCadastrosMouseLeave(Sender: TObject);
begin
  TrocaIconeMenuLateral(Sender, False);
end;

procedure TfmxMenu.btnFecharMenuClick(Sender: TObject);
begin
  popMenuCentral.IsOpen := False;
end;

procedure TfmxMenu.btnMenuTopo1Click(Sender: TObject);
begin
  FechaGridPesquisa;
  ClicarBotao(TSpeedButton(Sender).Text, TSpeedButton(Sender).TagString);
end;

{ TLabelHint }

constructor TLabelHint.CreateHint(const AForm: TfmxMenu);
begin
  FForm := AForm;
end;

procedure TLabelHint.SetEnabled(const Value: Boolean);
var
  LPoint: TPointF;
begin
  If Not Assigned(FForm) Then
    Exit;

  FForm.recHint.Visible := Value;

  If fmxMenu.popMenuCentral.IsOpen Then
    FForm.recHint.Visible := False;

  If Not FForm.recHint.Visible Then
    Exit;

  LPoint := Screen.MousePos;
  LPoint := FForm.ScreenToClient(LPoint);

  FForm.recHint.Position.X := LPoint.X + 20;
  FForm.recHint.Position.Y := LPoint.Y + 20;
  FForm.lblHint.Text       := ' ' + Self.FHint;
  FForm.recHint.Size.Width := FForm.lblHint.Size.Width;

  If FForm.recHint.Position.X + FForm.recHint.Size.Width >= (FForm.Width - 20) Then
  Begin
    FForm.recHint.Position.X := FForm.Width - FForm.recHint.Size.Width -20;
  End;

  If FForm.recHint.Position.Y + FForm.recHint.Size.Height >= (FForm.Height - 20) Then
  Begin
    FForm.recHint.Position.Y := FForm.Height - FForm.recHint.Size.Height -40;
  End;

  FForm.recHint.BringToFront;
end;

procedure TLabelHint.SetPosition(const X, Y: Single);
begin
  inherited;
end;

initialization
  THint.RegisterClass(TLabelHint);
  WndProcHook := SetWindowsHookEx(WH_CALLWNDPROCRET, @WndProc, 0, GetCurrentThreadId);

finalization
  UnhookWindowsHookEx(WndProcHook);

end.
