unit untEditorHtml;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.ExtCtrls, MSHTML, Vcl.StdCtrls,

  ComCtrls, ToolWin, Buttons, Menus, AppEvnts, ActiveX, Vcl.ExtDlgs, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  untDBEditFone, System.ImageList, Vcl.ImgList, Vcl.ButtonGroup, System.Actions, Vcl.ActnList, untFuncoesSimples,
  System.Win.Registry;

type
  THTMLProcEvent = procedure(Sender: TObject; Event: IHTMLEventObj) of object;

  THTMLEventLink = class(TInterfacedObject, IDispatch)
  private
    FOnEvent: THTMLProcEvent;
  private
    constructor Create(Handler: THTMLProcEvent);
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    property OnEvent: THTMLProcEvent read FOnEvent write FOnEvent;
  end;

  TWebBrowser = class(SHDocVw.TWebBrowser)
  private
    procedure CNChar(var Message: TWMChar); message CN_CHAR;
  end;

  TfrmEditorHtml = class(TForm)
    ColorDialog1: TColorDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    SaveDialog1: TSaveDialog;
    pnlPrincipal: TPanel;
    pnlBotoes: TPanel;
    btnNegrito: TSpeedButton;
    btnItalico: TSpeedButton;
    btnUnderline: TSpeedButton;
    btnColor: TSpeedButton;
    btnSep1: TSpeedButton;
    btnAlinhamentoEsquerda: TSpeedButton;
    btnAlinhamentoCentro: TSpeedButton;
    btnAlinhamentoDireita: TSpeedButton;
    btnSep2: TSpeedButton;
    btnRecortar: TSpeedButton;
    btnCopiar: TSpeedButton;
    btnColar: TSpeedButton;
    btnDesfazer: TSpeedButton;
    SpeedButton1: TSpeedButton;
    btnSep3: TSpeedButton;
    btnListagemNumerica: TSpeedButton;
    btnBullets: TSpeedButton;
    btnDecremIndentacao: TSpeedButton;
    btnIncremIndentacao: TSpeedButton;
    btnSep4: TSpeedButton;
    btnImagem: TSpeedButton;
    btnLinhaHorizontal: TSpeedButton;
    btnTabela: TSpeedButton;
    btnLink: TSpeedButton;
    Label3: TLabel;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    combofont: TComboBox;
    ComboSize: TComboBox;
    imgTabela: TImageList;
    pnlTabela: TPanel;
    gbtTabela: TButtonGroup;
    shpTabela: TShape;
    lblTabela: TLabel;
    shpTabela2: TShape;
    pnlTabelaOpcoes: TPanel;
    lblLinhas: TLabel;
    lblColunas: TLabel;
    btnDesenharTabela: TSpeedButton;
    btnFecharTabela: TSpeedButton;
    edtLinhas: TEdit;
    edtColunas: TEdit;
    chbCabecalho: TCheckBox;
    pmnAtalhos: TPopupMenu;
    mnuNegrito: TMenuItem;
    imgAtalhos: TImageList;
    Itlico1: TMenuItem;
    Sublinhado1: TMenuItem;
    CordoTexto1: TMenuItem;
    N1: TMenuItem;
    Recortar1: TMenuItem;
    Copiar1: TMenuItem;
    Colar1: TMenuItem;
    Desfazer1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    AlinhamentoEsquerda1: TMenuItem;
    AlinhamentoaoCentro1: TMenuItem;
    AlinhamentoDireita1: TMenuItem;
    N4: TMenuItem;
    ListagemNumrica1: TMenuItem;
    ListagemdeDiscos1: TMenuItem;
    DecrementarIndentao1: TMenuItem;
    IncrementarIndentao1: TMenuItem;
    N5: TMenuItem;
    InserirTabela1: TMenuItem;
    InserirLinhaHorizontal1: TMenuItem;
    InserirImagem2: TMenuItem;
    InserirLink1: TMenuItem;
    AppEvents: TApplicationEvents;
    WebBrowser: TWebBrowser;
    procedure btnNegritoClick(Sender: TObject);
    procedure btnBoldClick(Sender: TObject);
    procedure btnItalicoClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure btnColorClick(Sender: TObject);
    procedure btnListagemNumericaClick(Sender: TObject);
    procedure btnBulletsClick(Sender: TObject);
    procedure combofontChange(Sender: TObject);
    procedure btnDecremIndentacaoClick(Sender: TObject);
    procedure btnIncremIndentacaoClick(Sender: TObject);
    procedure btnAlinhamentoEsquerdaClick(Sender: TObject);
    procedure btnAlinhamentoCentroClick(Sender: TObject);
    procedure btnAlinhamentoDireitaClick(Sender: TObject);
    procedure btnImagemClick(Sender: TObject);
    procedure btnLinhaHorizontalClick(Sender: TObject);
    procedure btnRecortarClick(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure btnColarClick(Sender: TObject);
    procedure btnDesfazerClick(Sender: TObject);
    procedure btnLinkClick(Sender: TObject);
    procedure ComboSizeChange(Sender: TObject);
    procedure btnTabelaClick(Sender: TObject);
    procedure edtLinhasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtColunasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chbCabecalhoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesenharTabelaClick(Sender: TObject);
    procedure edtLinhasExit(Sender: TObject);
    procedure edtColunasExit(Sender: TObject);
    procedure gbtTabelaButtonClicked(Sender: TObject; Index: Integer);
    procedure btnFecharTabelaClick(Sender: TObject);
    procedure gbtTabelaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pnlTabelaEnter(Sender: TObject);
    procedure gbtTabelaMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WebBrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch; const [Ref] URL: OleVariant);
    procedure mnuNegritoClick(Sender: TObject);
    procedure Itlico1Click(Sender: TObject);
    procedure Sublinhado1Click(Sender: TObject);
    procedure CordoTexto1Click(Sender: TObject);
    procedure Recortar1Click(Sender: TObject);
    procedure Copiar1Click(Sender: TObject);
    procedure Colar1Click(Sender: TObject);
    procedure Desfazer1Click(Sender: TObject);
    procedure AlinhamentoEsquerda1Click(Sender: TObject);
    procedure AlinhamentoaoCentro1Click(Sender: TObject);
    procedure AlinhamentoDireita1Click(Sender: TObject);
    procedure ListagemNumrica1Click(Sender: TObject);
    procedure ListagemdeDiscos1Click(Sender: TObject);
    procedure DecrementarIndentao1Click(Sender: TObject);
    procedure IncrementarIndentao1Click(Sender: TObject);
    procedure InserirTabela1Click(Sender: TObject);
    procedure InserirLinhaHorizontal1Click(Sender: TObject);
    procedure InserirImagem2Click(Sender: TObject);
    procedure InserirLink1Click(Sender: TObject);
    procedure WebBrowserNewWindow2(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
    procedure AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FOnKeyDownConnector:  THTMLEventLink;
    procedure WebBrowserOnKeyDown(Sender: TObject; EventObjIfc: IHTMLEventObj);

    function GetIEHandle(WebBrowser: TWebbrowser; ClassName: string): HWND;
    procedure DesenharTabela(linhas, colunas: Integer; Cabecalho: Boolean);
    procedure InicializarComponentes;
  public
    { Public declarations }
    IEHandle: HWND;

    strArquivoFisicoHtml: String;

    blnConsultaEmail   : Boolean;

    procedure LimparEdicao;
    procedure AtualizarCorpoMensagem;
  end;

  Const
    IDM_MARCADOR       = 2184;
    IDM_MARCADOR_LISTA = 2185;
    IDM_OUTDENT        = 2187;
    IDM_INDENT         = 2186;
    IDM_ALINHARESQ     = 59;
    IDM_CENTRALIZAR    = 57;
    IDM_ALINHADIR      = 60;
    IDM_IMAGEM         = 2168;
    IDM_LINHAHORIZ     = 2150;
    IDM_RECORTAR       = 16;
    IDM_COPIAR         = 15;
    IDM_COLAR          = 26;
    IDM_HYPERLINK      = 2124;
    IDM_DESFAZER       = 43;

var
  frmEditorHtml: TfrmEditorHtml;

implementation

{$R *.dfm}

procedure TfrmEditorHtml.btnAlinhamentoEsquerdaClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_ALINHARESQ, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnAlinhamentoDireitaClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_ALINHADIR, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnBulletsClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_MARCADOR_LISTA, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.AlinhamentoaoCentro1Click(Sender: TObject);
begin
  btnAlinhamentoCentro.Click();
end;

procedure TfrmEditorHtml.AlinhamentoDireita1Click(Sender: TObject);
begin
  btnAlinhamentoDireita.Click();
end;

procedure TfrmEditorHtml.AlinhamentoEsquerda1Click(Sender: TObject);
begin
  btnAlinhamentoEsquerda.Click();
end;

procedure TfrmEditorHtml.AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
  var
    mClass : Array[0..1024] of Char;
begin
  If (Msg.Message = WM_RBUTTONDOWN) Or (Msg.Message = WM_RBUTTONDBLCLK) Then
  Begin
    If (IsChild(WebBrowser.Handle, Msg.hwnd)) Then
    Begin
      If (Not blnConsultaEmail) Then
        pmnAtalhos.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      Handled := True;
    End;
  End;

  if (GetClassName(Msg.hwnd, mClass, 1024) > 0) then
  begin
    if (StrIComp(@mClass, 'Internet Explorer_Server') = 0) then
    begin
      if (Msg.message = WM_KEYDOWN) and (GetKeyState(VK_CONTROL) < 0) then
      begin
        if (Msg.wParam = Ord('P')) or (Msg.wParam = Ord('N')) or (Msg.wParam = Ord('F'))
          or (Msg.wParam = Ord('O')) or (Msg.wParam = Ord('A')) or (Msg.wParam = Ord('S')) then
        begin
          Handled := True;
        end
        else if (Msg.wParam = Ord('H')) then
        begin
          btnColor.Click();
          Handled := True;
        end;
      end;
    end
  end;
end;

procedure TfrmEditorHtml.AtualizarCorpoMensagem;
begin
  InicializarComponentes();
end;

procedure TfrmEditorHtml.btnAlinhamentoCentroClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_CENTRALIZAR, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnCopiarClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_COPIAR, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnRecortarClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_RECORTAR, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnDecremIndentacaoClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_OUTDENT, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnLinhaHorizontalClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_LINHAHORIZ, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnIncremIndentacaoClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_INDENT, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnNegritoClick(Sender: TObject);
  Var
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);
  HTMLDocumento.execCommand('Bold', False, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnListagemNumericaClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_MARCADOR, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnColarClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_COLAR, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.chbCabecalhoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_Return) then
    btnDesenharTabela.Click();
end;

procedure TfrmEditorHtml.Colar1Click(Sender: TObject);
begin
  btnColar.Click();
end;

procedure TfrmEditorHtml.combofontChange(Sender: TObject);
  Var
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);
  HTMLDocumento.execCommand('FontName', False, ComboFont.Text);
end;

procedure TfrmEditorHtml.ComboSizeChange(Sender: TObject);
  Var
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);

  case Combosize.ItemIndex of
    0: HTMLDocumento.execCommand('FontSize', False, 1);
    1: HTMLDocumento.execCommand('FontSize', False, 2);
    2: HTMLDocumento.execCommand('FontSize', False, 3);
    3: HTMLDocumento.execCommand('FontSize', False, 4);
    4: HTMLDocumento.execCommand('FontSize', False, 5);
    5: HTMLDocumento.execCommand('FontSize', False, 6);
    6: HTMLDocumento.execCommand('FontSize', False, 7);
  end;
end;

procedure TfrmEditorHtml.Copiar1Click(Sender: TObject);
begin
  btnCopiar.Click();
end;

procedure TfrmEditorHtml.CordoTexto1Click(Sender: TObject);
begin
  btnColor.Click();
end;

procedure TfrmEditorHtml.DecrementarIndentao1Click(Sender: TObject);
begin
  btnDecremIndentacao.Click();
end;

procedure TfrmEditorHtml.DesenharTabela(linhas, colunas: Integer; Cabecalho: Boolean);
  var
    i       : Integer;
    vo      : OleVariant;
    lComando, strLinhas, strColunas: String;
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);

  lComando := '<table align="center" borderColor="black" cellSpacing="0" cellPadding="3" width="75%" border="1">';

  if (Cabecalho) then
    lComando := lComando + '<tr bgcolor="B8B8B8">'
  else
    lComando := lComando + '<tr>';

  for i := 0 to colunas - 1 do
    strColunas := strColunas + '<td></td>';

  lComando := lComando + strColunas + '</tr>';

  linhas    := linhas - 1;
  strLinhas := '';

  for i := 0 to linhas - 1 do
    strLinhas := strLinhas + '<tr>' + strColunas + '</tr>';

  lComando := lComando + strLinhas + '</table>';

  if (HTMLDocumento.Selection.Type_ = 'Control') then
    WebBrowser.ExecWB(OLECMDID_DELETE, OLECMDEXECOPT_DODEFAULT);

  vo := HTMLDocumento.Selection.CreateRange;
  vo.pasteHTML(lComando);

  for i := 0 to gbtTabela.Items.Count - 1 do
    gbtTabela.Items[i].ImageIndex := -1;
end;

procedure TfrmEditorHtml.Desfazer1Click(Sender: TObject);
begin
  btnDesfazer.Click();
end;

procedure TfrmEditorHtml.edtColunasExit(Sender: TObject);
begin
  if (TEdit(Sender).Text = '') Then
    TEdit(Sender).Text := '0';
end;

procedure TfrmEditorHtml.edtColunasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_Return) then
    pSetFocus(chbCabecalho);
end;

procedure TfrmEditorHtml.edtLinhasExit(Sender: TObject);
begin
  if (TEdit(Sender).Text = '') Then
    TEdit(Sender).Text := '0';
end;

procedure TfrmEditorHtml.edtLinhasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_Return) then
    pSetFocus(edtColunas);
end;

procedure TfrmEditorHtml.FormClose(Sender: TObject; var Action: TCloseAction);
  var
  Flags: OleVariant;
  vReg : TRegistry;
begin

  vReg := TRegistry.Create(KEY_WRITE);
  try
    vReg.RootKey := HKEY_CURRENT_USER;

    if vReg.OpenKey('Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION',True) then
      vReg.DeleteValue(ExtractFileName(Application.ExeName));

     vReg.CloseKey;
  finally
    vReg.Free;
  end;

  Flags := 'navNoHistory,navNoReadFromCache,navNoWriteToCache';
  WebBrowser.Navigate('about:blank',Flags);
  WebBrowser.Free();
  IEHandle := 0;
  
  CoFreeUnusedLibrariesEx(0, 0);

  inherited;
end;

procedure TfrmEditorHtml.FormCreate(Sender: TObject);
begin
  inherited;

  IEHandle            := 0;
  strArquivoFisicoHtml:= '';
  blnconsultaEmail    := False;

  FOnKeyDownConnector := THTMLEventLink.Create(WebBrowserOnKeyDown); //assign the address of the event handler
end;

procedure TfrmEditorHtml.FormShow(Sender: TObject);
var
  vReg : TRegistry;
begin
  vReg := TRegistry.Create(KEY_WRITE);
  try
    vReg.RootKey := HKEY_CURRENT_USER;

    if vReg.OpenKey('Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION',True) then
    begin
      if not vReg.ValueExists(ExtractFileName(Application.ExeName)) then
      begin
        vReg.WriteInteger(ExtractFileName(Application.ExeName), 10001 );
      end;
      vReg.CloseKey;
    end;
  finally
    vReg.Free;
  end;

  inherited;
  
  InicializarComponentes();
end;

procedure TfrmEditorHtml.gbtTabelaButtonClicked(Sender: TObject; Index: Integer);
  var
    linhas, colunas: Integer;
begin
  linhas  := 0;
  colunas := 0;

  case (Index) of
    0: begin linhas := 1; colunas := 1; end;
    1: begin linhas := 1; colunas := 2; end;
    2: begin linhas := 1; colunas := 3; end;
    3: begin linhas := 1; colunas := 4; end;
    4: begin linhas := 1; colunas := 5; end;

    5: begin linhas := 2; colunas := 1; end;
    6: begin linhas := 2; colunas := 2; end;
    7: begin linhas := 2; colunas := 3; end;
    8: begin linhas := 2; colunas := 4; end;
    9: begin linhas := 2; colunas := 5; end;

    10: begin linhas := 3; colunas := 1; end;
    11: begin linhas := 3; colunas := 2; end;
    12: begin linhas := 3; colunas := 3; end;
    13: begin linhas := 3; colunas := 4; end;
    14: begin linhas := 3; colunas := 5; end;

    15: begin linhas := 4; colunas := 1; end;
    16: begin linhas := 4; colunas := 2; end;
    17: begin linhas := 4; colunas := 3; end;
    18: begin linhas := 4; colunas := 4; end;
    19: begin linhas := 4; colunas := 5; end;

    20: begin linhas := 5; colunas := 1; end;
    21: begin linhas := 5; colunas := 2; end;
    22: begin linhas := 5; colunas := 3; end;
    23: begin linhas := 5; colunas := 4; end;
    24: begin linhas := 5; colunas := 5; end;
  end;

  DesenharTabela(linhas, colunas, chbCabecalho.Checked);
  btnFecharTabela.Click();
end;

procedure TfrmEditorHtml.gbtTabelaMouseLeave(Sender: TObject);
  var
    i: Integer;
begin
  lblTabela.Caption := 'Inserir Tabela';
  for i := 0 to gbtTabela.Items.Count - 1 do
    gbtTabela.Items[i].ImageIndex := -1;
end;

procedure TfrmEditorHtml.gbtTabelaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  var
    altura, largura: Double;
    i, j, linha, coluna: Integer;
begin
  linha  := 0;
  coluna := 0;

  altura  := Y / gbtTabela.Height;
  largura := X / gbtTabela.Width;

  if (largura >= 0) and (largura <= 0.20) then
    coluna := 1
  else if (largura >= 0) and (largura <= 0.40) then
    coluna := 2
  else if (largura >= 0) and (largura <= 0.60) then
    coluna := 3
  else if (largura >= 0) and (largura <= 0.80) then
    coluna := 4
  else if (largura >= 0) and (largura <= 1) then
    coluna := 5;

  if (altura >= 0) and (altura <= 0.20) then
    linha := 1
  else if (altura >= 0) and (altura <= 0.40) then
    linha := 2
  else if (altura >= 0) and (altura <= 0.60) then
    linha := 3
  else if (altura >= 0) and (altura <= 0.80) then
    linha := 4
  else if (altura >= 0) and (altura <= 1) then
    linha := 5;

  lblTabela.Caption := 'Inserir Tabela: ' + IntToStr(linha) + 'x' + IntToStr(coluna);

  for i := 0 to gbtTabela.Items.Count - 1 do
    gbtTabela.Items[i].ImageIndex := -1;

  for i := 0 to linha - 1 do
    for j := 0 to coluna - 1 do
      gbtTabela.Items[(i + (i * 4)) + j].ImageIndex := 0;
end;

function TfrmEditorHtml.GetIEHandle(WebBrowser: TWebbrowser; ClassName: string): HWND;
var
  szClass: array[0..255] of char;
begin
  if HandleAllocated then
  begin
    Result := GetWindow(WindowHandle, GW_CHILD);
    repeat
      if (GetClassName(Result, szClass, SizeOf(szClass)) > 0) and
        (AnsiStrComp(PChar(ClassName), szClass) = 0) then
        Exit;
      Result := GetWindow(Result, GW_CHILD);
    until not IsWindow(Result);
  end;
  Result := 0;
end;

procedure TfrmEditorHtml.IncrementarIndentao1Click(Sender: TObject);
begin
  btnIncremIndentacao.Click();
end;

procedure TfrmEditorHtml.InicializarComponentes;
  var
    Flags: OleVariant;
begin
  WebBrowser.RegisterAsBrowser := False;

  Flags := 'navNoHistory,navNoReadFromCache,navNoWriteToCache';

  If (fEmptyStr(strArquivoFisicoHtml)) Then
  Begin
    WebBrowser.Navigate2('about:blank', Flags)
  End
  Else
  Begin
    If FileExists(strArquivoFisicoHtml) Then
    Begin
      WebBrowser.Navigate2(strArquivoFisicoHtml, Flags);

      While (WebBrowser.ReadyState < READYSTATE_INTERACTIVE) Do 
      Begin
        Application.ProcessMessages;
        Sleep(1);
      End;
    End
    Else
    Begin
      WebBrowser.Navigate2('about:blank', Flags);
      fMensagem('ATENÇÃO!', 'O Autcom não conseguiu achar o arquivo temporário do e-mail. '+
                            'Verifique o mapeamento de seu computador em relação ao sevidor.'+#10#13+
                            strArquivoFisicoHtml, ['&Ok']);
    End;
  End;

  pnlBotoes.Visible := (Not blnConsultaEmail);
end;

procedure TfrmEditorHtml.InserirImagem2Click(Sender: TObject);
begin
  btnImagem.Click();
end;

procedure TfrmEditorHtml.InserirLinhaHorizontal1Click(Sender: TObject);
begin
  btnLinhaHorizontal.Click();
end;

procedure TfrmEditorHtml.InserirLink1Click(Sender: TObject);
begin
  btnLink.Click();
end;

procedure TfrmEditorHtml.InserirTabela1Click(Sender: TObject);
begin
  btnTabela.Click();
end;

procedure TfrmEditorHtml.Itlico1Click(Sender: TObject);
begin
  btnItalico.Click();
end;

procedure TfrmEditorHtml.LimparEdicao;
begin
  WebBrowser.Refresh();

  If (Not blnConsultaEmail) Then
    (WebBrowser.DefaultInterface.Document as IHTMLDocument2).DesignMode := 'On';
end;

procedure TfrmEditorHtml.ListagemdeDiscos1Click(Sender: TObject);
begin
  btnBullets.Click();
end;

procedure TfrmEditorHtml.ListagemNumrica1Click(Sender: TObject);
begin
  btnListagemNumerica.Click();
end;

procedure TfrmEditorHtml.mnuNegritoClick(Sender: TObject);
begin
  btnNegrito.Click();
end;

procedure TfrmEditorHtml.pnlTabelaEnter(Sender: TObject);
  var
    i: Integer;
begin
  for i := 0 to gbtTabela.Items.Count - 1 do
    gbtTabela.Items[i].ImageIndex := -1;
end;

procedure TfrmEditorHtml.Recortar1Click(Sender: TObject);
begin
  btnRecortar.Click();
end;

procedure TfrmEditorHtml.Sublinhado1Click(Sender: TObject);
begin
  btnUnderline.Click();
end;

procedure TfrmEditorHtml.WebBrowserOnKeyDown(Sender: TObject; EventObjIfc: IHTMLEventObj);
  Var
    point      : TPoint;
    metrics    : IHTMLTextRangeMetrics;
    keyCode    : Word;
    textRange  : IHTMLTxtRange;
    definirFoco: Boolean;
    HTMLDocumento: IHTMLDocument2;
begin
  definirFoco := True;

  If (Not Assigned(WebBrowser.DefaultInterface.Document)) Then Exit;

  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);

  //bloqueia o atalho do teclado do menu popup
  If (HTMLDocumento.parentWindow.event.keyCode = 93) Then
  Begin
    HTMLDocumento.parentWindow.event.cancelBubble:=True;
    HTMLDocumento.parentWindow.event.keyCode     :=0;

    textRange := (HTMLDocumento.Selection.CreateRange() As IHTMLTxtRange);
    metrics   := (textRange As IHTMLTextRangeMetrics);

    point     := TPoint.Create(
                          ((Screen.Width  - 830) div 2) + metrics.boundingLeft + metrics.boundingWidth + 5,
                          (Screen.Height - 768) + 155);

    pmnAtalhos.Popup(point.X, point.Y);
  End;

  keyCode := Word(HTMLDocumento.parentWindow.event.keyCode);

  If (not HTMLDocumento.parentWindow.event.ctrlKey) and
    (not HTMLDocumento.parentWindow.event.altKey) and
    (not HTMLDocumento.parentWindow.event.shiftKey) Then
  Begin
    If (KeyCode = VK_F2) Then
      btnAlinhamentoEsquerda.Click()
    Else If (KeyCode = VK_F3) Then
      btnAlinhamentoCentro.Click()
    Else If (KeyCode = VK_F4) Then
      btnAlinhamentoDireita.Click()
    Else If (KeyCode = VK_F5) Then
      btnListagemNumerica.Click()
    Else If (KeyCode = VK_F6) Then
      btnBullets.Click()
    Else If (KeyCode = VK_F7) Then
      btnDecremIndentacao.Click()
    Else If (KeyCode = VK_F8) Then
      btnIncremIndentacao.Click()
    Else If (KeyCode = VK_F9) Then
      btnTabela.Click()
    Else If (KeyCode = VK_F10) Then
      btnLinhaHorizontal.Click()
    Else If (KeyCode = VK_F11) Then
      btnImagem.Click()
    Else If (KeyCode = VK_F12) Then
      btnLink.Click()
    Else
      definirFoco := False;
  End
  Else
    definirFoco := False;

  If (definirFoco) Then pSetFocus(WebBrowser);
end;

procedure TfrmEditorHtml.WebBrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch; const [Ref] URL: OleVariant);
  Var
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);

  If (IEHandle = 0) Then IEHandle := GetIEHandle(WebBrowser, 'Internet Explorer_Server');

  HTMLDocumento.OnKeyDown := FOnKeyDownConnector as IDispatch;

  If (Not blnConsultaEmail) Then
    HTMLDocumento.DesignMode := 'On';

  combofont.Items := screen.Fonts;
  combofont.Text := 'Calibri';
  HTMLDocumento.execCommand('FontName', False, 'Calibri');

  comboSize.ItemIndex := 2;
  HTMLDocumento.execCommand('FontSize', False, 3);

  pnlTabela.Top  := btnTabela.Top  + 26;
  pnlTabela.Left := btnTabela.Left + 2;
end;

procedure TfrmEditorHtml.WebBrowserNewWindow2(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
begin
  Cancel := True;
end;

procedure TfrmEditorHtml.btnBoldClick(Sender: TObject);
  Var
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);
  HTMLDocumento.execCommand('Bold', False, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnItalicoClick(Sender: TObject);
  Var
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);
  HTMLDocumento.execCommand('Italic', False, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnUnderlineClick(Sender: TObject);
  Var
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);
  HTMLDocumento.execCommand('Underline', False, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnColorClick(Sender: TObject);
  Var
    HTMLDocumento: IHTMLDocument2;
begin
  HTMLDocumento := (WebBrowser.DefaultInterface.Document As IHTMLDocument2);
  if ColorDialog1.Execute then
    HTMLDocumento.execCommand('ForeColor', False, ColorDialog1.Color)
  else
    abort;

  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnImagemClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_IMAGEM, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnLinkClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_HYPERLINK, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnDesenharTabelaClick(Sender: TObject);
begin
  if ((StrToInt(edtLinhas.Text) > 0) and (StrToInt(edtColunas.Text) > 0)) then
  begin
    DesenharTabela(StrToInt(edtLinhas.Text), StrToInt(edtColunas.Text), chbCabecalho.Checked);
    btnFecharTabela.Click();
  end
  else
    pSetFocus(edtLinhas);
end;

procedure TfrmEditorHtml.btnDesfazerClick(Sender: TObject);
begin
  SendMessage(IEHandle, WM_COMMAND, IDM_DESFAZER, 0);
  TSpeedButton(Sender).Down := False;
end;

procedure TfrmEditorHtml.btnFecharTabelaClick(Sender: TObject);
begin
  pnlTabela.Visible := False;
end;

procedure TfrmEditorHtml.btnTabelaClick(Sender: TObject);
begin
  pnlTabela.Visible    := (not pnlTabela.Visible);
  edtLinhas.Text       := '0';
  edtColunas.Text      := '0';
  chbCabecalho.Checked := True;
end;

{ TWebBrowser }

procedure TWebBrowser.CNChar(var Message: TWMChar);
begin
  Message.Result := 0;
end;

{ THTMLEventLink }

constructor THTMLEventLink.Create(Handler: THTMLProcEvent);
begin
  inherited Create;
  _AddRef;
  FOnEvent := Handler;
end;

function THTMLEventLink.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function THTMLEventLink.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function THTMLEventLink.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function THTMLEventLink.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  HTMLEventObjIfc: IHTMLEventObj;
begin
  Result := S_OK;

  if Assigned(FOnEvent) then
    FOnEvent(Self, HTMLEventObjIfc);
end;

end.
