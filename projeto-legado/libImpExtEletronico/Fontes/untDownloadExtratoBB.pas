unit untDownloadExtratoBB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, IdUri, Vcl.AppEvnts, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, EditFocus, Vcl.Buttons, Vcl.ExtCtrls,
  dxGDIPlusClasses, dxCustomWizardControl, dxWizardControl, Vcl.Menus, ShellAPI, System.UiTypes,
  cxButtons, cxGroupBox, Winapi.WinInet, MSHTML, Registry, UrlMon, ActiveX,
  IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdCookieManager,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IPPeerClient, System.IOUtils, DateUtils;

const
  IID_IDownloadManager: TGUID = '{988934A4-064B-11D3-BB80-00104B35E7F9}';
  SID_SDownloadManager: TGUID = '{988934A4-064B-11D3-BB80-00104B35E7F9}';

type
  IDownloadManager = interface(IUnknown)
    ['{988934A4-064B-11D3-BB80-00104B35E7F9}']
    function Download(pmk: IMoniker; pbc: IBindCtx; dwBindVerb: DWORD;
      grfBINDF: DWORD; pBindInfo: PBindInfo; pszHeaders: PWideChar;
      pszRedir: PWideChar; uiCP: UINT): HRESULT; stdcall;
  end;

  TBeforeFileDownloadEvent = procedure(Sender: TObject; const FileSource: WideString;
    var Allowed: Boolean) of object;

  TWebBrowser = class(SHDocVw.TWebBrowser, IServiceProvider, IDownloadManager)
  private
    FFileSource: WideString;
    FOnBeforeFileDownload: TBeforeFileDownloadEvent;
    function QueryService(const rsid, iid: TGUID; out Obj): HRESULT; stdcall;
    function Download(pmk: IMoniker; pbc: IBindCtx; dwBindVerb: DWORD;
      grfBINDF: DWORD; pBindInfo: PBindInfo; pszHeaders: PWideChar;
      pszRedir: PWideChar; uiCP: UINT): HRESULT; stdcall;
  protected
    procedure InvokeEvent(ADispID: TDispID; var AParams: TDispParams); override;
  published
    property OnBeforeFileDownload: TBeforeFileDownloadEvent read FOnBeforeFileDownload write FOnBeforeFileDownload;
  end;

type
  TfrmDownloadExtratoBB = class(TForm)
    Panel1: TPanel;
    WebBrowser1: TWebBrowser;
    ApplicationEvents1: TApplicationEvents;
    wzctPrincipal: TdxWizardControl;
    wzpgPrincipal: TdxWizardControlPage;
    wzpgDadosConexao: TdxWizardControlPage;
    wzpgPeriodo: TdxWizardControlPage;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    pnlLogin: TPanel;
    Label6: TLabel;
    Image3: TImage;
    Image4: TImage;
    Label7: TLabel;
    cxGroupBox1: TcxGroupBox;
    edtChave: TEdit;
    cxGroupBox2: TcxGroupBox;
    edtSenha: TEdit;
    btnLogin: TcxButton;
    btnVisualizarSenha: TcxButton;
    wzpgFinal: TdxWizardControlPage;
    Label9: TLabel;
    Image8: TImage;
    Label13: TLabel;
    memArquivo: TMemo;
    Label14: TLabel;
    pnlPeriodo: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Image6: TImage;
    Label16: TLabel;
    Label17: TLabel;
    Label15: TLabel;
    dteDataFinal: TcxDateEdit;
    grpSenhaConta: TcxGroupBox;
    edtSenhaConta: TEdit;
    btnVisSenhaConta: TcxButton;
    grpContaCorrente: TcxGroupBox;
    edtContaCorrente: TEdit;
    grpAgencia: TcxGroupBox;
    edtAgencia: TEdit;
    btnEntrar: TcxButton;
    tmrGeral: TTimer;
    Panel3: TPanel;
    Image2: TImage;
    Panel4: TPanel;
    Image5: TImage;
    Panel5: TPanel;
    Image7: TImage;
    dteDataInicial: TcxDateEdit;
    cxGroupBox4: TcxGroupBox;
    procedure wzctPrincipalPageChanged(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const {$IF Defined(VER270)} {$ELSE}[Ref]{$IFEND} URL: OleVariant);
    procedure WebBrowser1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure btnVisualizarSenhaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnVisualizarSenhaMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure btnVisSenhaContaMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnVisSenhaContaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnEntrarClick(Sender: TObject);
    procedure tmrGeralTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtSenhaContaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wzctPrincipalButtonClick(Sender: TObject;
      AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
  private
    { Private declarations }
    intArquivo: Integer;
    strAcao_ : String;
    blnBaixou: Boolean;
    intVezes : Integer;

    function ExecuteScript(Doc: IHTMLDocument2; Script: string; Language: string): Boolean;
    procedure BeforeFileDownload(Sender: TObject; const FileSource: WideString;
      var Allowed: Boolean);
  public
    { Public declarations }
    strDiretorioSalvar : String;
    strArquivoBaixado: String;
    hwndAutcom: HWND;
  end;

var
  frmDownloadExtratoBB: TfrmDownloadExtratoBB;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmDownloadExtratoBB.btnVisSenhaContaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edtSenhaConta.PasswordChar := #0;
end;

procedure TfrmDownloadExtratoBB.btnVisSenhaContaMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edtSenhaConta.PasswordChar := '*';
end;

procedure TfrmDownloadExtratoBB.btnVisualizarSenhaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edtSenha.PasswordChar := #0;
end;

procedure TfrmDownloadExtratoBB.btnVisualizarSenhaMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edtSenha.PasswordChar := '*';
end;

procedure TfrmDownloadExtratoBB.edtSenhaContaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
    btnEntrar.Click;
end;

procedure TfrmDownloadExtratoBB.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_RETURN Then
    btnLogin.Click;
end;

procedure TfrmDownloadExtratoBB.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if Msg.hwnd = hwndAutcom then
  begin
    Msg.wParam  := 0;
    Msg.message := 0;
    Msg.lParam  := 0;
  end;
end;

procedure TfrmDownloadExtratoBB.BeforeFileDownload(Sender: TObject;
  const FileSource: WideString; var Allowed: Boolean);
var
  IdHTTP: TIdHTTP;
  FileTarget: string;
  FileStream: TMemoryStream;
  IdCookieManager: TIdCookieManager;
  IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  cookies: TStringList;
  uri: TIdURI;
  i: Integer;
begin
  if not Allowed then
  try
    IdHTTP := TIdHTTP.Create(nil);
    IdCookieManager := TIdCookieManager.Create(Nil);

    IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdHttp.IOHandler     := IdSSLIOHandlerSocketOpenSSL;


    uri := TIdURI.Create(FileSource);

    cookies := TStringList.Create;
    cookies.Delimiter := ';' ;
    cookies.DelimitedText  := (WebBrowser1.Document as IHTMLDocument2).cookie;

    for i := 0 to cookies.Count-1 do
      IdCookieManager.AddServerCookie(cookies[i], uri);

    cookies.Free;
    Uri.Free;

    IdHttp.CookieManager := IdCookieManager;

    try
      FileStream := TMemoryStream.Create;
      try
        IdHTTP.AllowCookies := True;
        IdHTTP.Post(FileSource, FileStream);
        FileTarget := IdHTTP.URL.Document;
        if FileTarget = '' then
          FileTarget := 'File';
        FileTarget := ExtractFilePath(ParamStr(0)) + FileTarget;
        FileStream.SaveToFile(FileTarget);
      finally
        FileStream.Free;
      end;
    finally
      IdHTTP.Free;
    end;

    ShowMessage('Downloading finished! File has been saved as:' + sLineBreak +
      FileTarget);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmDownloadExtratoBB.btnEntrarClick(Sender: TObject);
begin
  If Trim(edtAgencia.Text) = '' Then
  Begin
    ShowMessage('Informe a Agência!');
    edtAgencia.SETFOCUS;
    Exit;
  End;

  If Trim(edtContaCorrente.Text) = '' Then
  Begin
    ShowMessage('Informe a Conta Corrente!');
    edtContaCorrente.SETFOCUS;
    Exit;
  End;


  If dteDataInicial.Date > dteDataFinal.Date Then
  Begin
    ShowMessage('Período de datas inválido!');
    dteDataInicial.SETFOCUS;
    Exit;
  End;

  If DaysBetween(dteDataInicial.Date, dteDataFinal.Date) > 30 Then
  Begin
    ShowMessage('O intervalo de datas não pode ser superior a 30 dias!');
    dteDataInicial.SETFOCUS;
    Exit;
  End;

  If Trim(edtSenhaConta.Text) = '' Then
  Begin
    ShowMessage('Informe a senha da conta!');
    edtSenhaConta.SETFOCUS;
    Exit;
  End;

  pnlPeriodo.Visible := False;
  strAcao_ := 'AcionaFiltro';
  tmrGeral.Enabled := True;
  blnBaixou        := False;
  intVezes         := 0;
  wzctPrincipal.Buttons.Next.Enabled := False;
end;

procedure TfrmDownloadExtratoBB.btnLoginClick(Sender: TObject);
var
  strScript_: String;
  i: Integer;
begin
  If Trim(edtChave.Text) = '' Then
  Begin
    ShowMessage('Informe a Chave J!');
    edtChave.SETFOCUS;
    Exit;
  End;

  If Trim(edtSenha.Text) = '' Then
  Begin
    ShowMessage('Informe a Senha!');
    edtSenha.SETFOCUS;
    Exit;
  End;

  If InternetGetConnectedState(@i,0) Then
  Begin
    strScript_ :=  '  function efetuaLogin() { ' +
                   '      document.getElementById("chaveJ").click(); ' +
                   '      document.getElementById("identificacaoUsuario").value = '+Quotedstr(edtChave.Text)+'; ' +
                   '      document.getElementById("senhaUsuario").value = '+Quotedstr(edtSenha.Text)+'; ' +
                   '      document.getElementById("botao.acao.entrar").click(); ' +
                   '  }; ' +
                   '  efetuaLogin();';

    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), strScript_, 'JavaScript');

    Application.ProcessMessages;
    pnlLogin.Visible := False;
    strAcao_ := 'Login';
    tmrGeralTimer(nil);
    tmrGeral.Enabled := True;
  End
  Else
    MessageDlg('Para baixar o extrato em arquivo ofx, é necessária uma conexão válida com a internet!', mtInformation, [mbOK], 0);
end;

function TfrmDownloadExtratoBB.ExecuteScript(Doc: IHTMLDocument2; Script,
  Language: string): Boolean;
var
  Win: IHTMLWindow2;
  Olelanguage: Olevariant;
begin
  Result := True;
  Try
    if Doc <> nil then
    begin
      try
        Win := Doc.parentWindow;
        if Win <> nil then
        begin
          try
            Olelanguage := language;
            Win.ExecScript(Script, Olelanguage);
          finally
            Win := nil;
          end;
        end;
      finally
         Doc := nil;
      end;
    end;
  Except
    Result := False;
  End;
end;

procedure TfrmDownloadExtratoBB.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.querySelector("#idSair > a").click(); ', 'JavaScript');
  Application.ProcessMessages;
end;

procedure TfrmDownloadExtratoBB.FormCreate(Sender: TObject);
begin
  WebBrowser1.OnBeforeFileDownload := BeforeFileDownload;
end;

procedure TfrmDownloadExtratoBB.FormShow(Sender: TObject);
begin
  intArquivo := 0;
  dteDataInicial.Date := NoW;
  dteDataFinal.Date   := NoW;
end;

procedure TfrmDownloadExtratoBB.tmrGeralTimer(Sender: TObject);
var
 Registro: TRegistry;
 strDirDownload: String;
 searchResult : TSearchRec;
 strUltArq: String;
 dtaDtaAlt: TDateTime;
begin
  If strAcao_ = 'Login' Then
  Begin
    strAcao_ := 'VerificaLogin';

    intVezes := 0;

    Exit;
  End;

  If strAcao_ = 'VerificaLogin' Then
  Begin
    If WebBrowser1.LocationURL <> fDesCriptografa('ÔààÜß¦ÍÍÜÖÎÎÏÛÙÎÞÍÍÜÖØÛÓÕÚÜÒÑÎÎ', 108) Then
    Begin
      tmrGeral.Enabled := False;
      strAcao_ := '';

      Exit;
    End;

    If intVezes >= 1 Then
    Begin
      ShowMessage('Chave J ou Senha Inválida!');
      tmrGeral.Enabled := False;
      strAcao_ := '';
      pnlLogin.Visible := True;

      Exit;
    End
    Else
    Begin
      IntVezes := IntVezes+1;
      Exit;
    End;

  End;

  If strAcao_ = 'AcionaFiltro' Then
  Begin
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.querySelector('+Quotedstr('table > tbody > tr:nth-child(2) > td > input[type="radio"]')+').click(); ', 'JavaScript');
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.getElementById("botao.acao.ok").click(); ', 'JavaScript');

    Application.ProcessMessages;

    strAcao_ := 'PreencheCampos';

    Exit;
  End;

  If strAcao_ = 'PreencheCampos' Then
  Begin
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.getElementById("dependenciaOrigem").value = '+Quotedstr(Trim(edtAgencia.Text))+'; ', 'JavaScript');
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.getElementById("numeroContratoOrigem").value = '+Quotedstr(Trim(edtContaCorrente.Text))+'; ', 'JavaScript');
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.querySelector("#formTrans > table.tabelaTrsEntrada > tbody > tr:nth-child(5) > td.dados > input[type='+QuotedStr('radio')+']:nth-child(1)").click(); ', 'JavaScript');
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.querySelector("#formTrans > table.tabelaTrsEntrada > tbody > tr:nth-child(5) > td.dados > input:nth-child(4)").value = ' +Quotedstr(Trim(dteDataInicial.Text))+'; ', 'JavaScript');
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.querySelector("#formTrans > table.tabelaTrsEntrada > tbody > tr:nth-child(5) > td.dados > input:nth-child(8)").value = ' +Quotedstr(Trim(dteDataFinal.Text))+'; ', 'JavaScript');
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.querySelector("#areaSenhaConta > tbody > tr > td:nth-child(2) > input").value = ' +Quotedstr(Trim(edtSenhaConta.Text))+'; ', 'JavaScript');
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.getElementById("botao.acao.ok").click(); ', 'JavaScript');

    Application.ProcessMessages;

    strAcao_ := 'DownloadArquivo';

    Exit;
  End;

  If strAcao_ = 'DownloadArquivo' Then
  Begin
    If Pos('Dígito verificador inválido.', Webbrowser1.OleObject.Document.documentElement.innerHTML) > 0 Then
    Begin
      ShowMessage('Verifique os dados de Agência e Conta!');
      strAcao_ := '';

      tmrGeral.Enabled := False;
      pnlPeriodo.Visible := True;

      Exit;
    End;


    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.getElementById("botao.acao.salvarOfx").click(); ', 'JavaScript');

    Application.ProcessMessages;

    strAcao_ := 'RecuperarArquivo';

    Exit;
  End;

  If strAcao_ = 'RecuperarArquivo' Then
  Begin
    Registro := TRegistry.Create;
    Registro.RootKey := HKEY_CURRENT_USER;
    Registro.OpenKey('Software\Microsoft\Internet Explorer', True);
    strDirDownload := Registro.ReadString('Download Directory');
    Registro.Free;

    strUltArq := '';

    If strDirDownload <> '' Then
    Begin
      dtaDtaAlt := 0;
      if FindFirst(strDirDownload+'\*.*', faAnyFile, searchResult) = 0 then
      begin
        repeat
          If Pos('OFX', UpperCase(searchResult.Name)) > 0  Then
          Begin
            If searchResult.TimeStamp >  dtaDtaAlt Then
            Begin
              dtaDtaAlt := searchResult.TimeStamp;
              strUltArq := searchResult.Name;
            End;
          End;

        until FindNext(searchResult) <> 0;

        FindClose(searchResult);
      end;

      If strUltArq <> '' Then
      Begin
        wzctPrincipal.Buttons.Next.Enabled := True;
        wzctPrincipal.Buttons.Next.Click;

        memArquivo.Lines.Add(strDirDownload + '\' + strUltArq);
        strAcao_ := '';

        If Trim(strDiretorioSalvar) <> ''  Then
        Begin
          If strDiretorioSalvar <> strDirDownload Then
          Begin
            CopyFile(PWideChar(strDirDownload + '\' + strUltArq), PWideChar(strDiretorioSalvar + '\' + strUltArq), False);
            DeleteFile(strDirDownload + '\' + strUltArq);
            strDirDownload := strDiretorioSalvar;
          End;
        End;

        strArquivoBaixado := strDirDownload + '\' + strUltArq;

        tmrGeral.Enabled := False;

        Close;
      End;

      If intVezes >= 200 Then
      Begin
        ShowMessage('Ocorreu um erro ao salvar o arquivo! Sessão encerrada!');
        tmrGeral.Enabled := False;
        Close;
      End
      Else IntVezes := IntVezes+1;

    End;
  End;
end;

procedure TfrmDownloadExtratoBB.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const [Ref] URL: OleVariant);
begin
  If (Pos(fDesCriptografa('ÔààÜß¦ÍÍÜÖÎÎÏÛÙÎÞÍÍÜÖÔÛÙÑÎÎ«àÛ×ÑÚ¿ÑßßÍÛ©', 108), String(WebBrowser1.LocationURL)) > 0) Then
  Begin
    wzctPrincipal.Buttons.Next.Enabled := True;
    ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.querySelector("#aItemMenuFilho12").click(); ', 'JavaScript');
    Exit;
  End;

  If (wzctPrincipal.ActivePage = wzpgDadosConexao) Then
  Begin
    If (Pos(fDesCriptografa('ÔààÜß¦ÍÍÜÖÎÎÏÛÙÎÞÍÍÜÖÚÛàÕÏÕÍÎÎ«àÛ×ÑÚ¿ÑßßÍÛ©', 108), String(WebBrowser1.LocationURL)) > 0) Then
    Begin
      If (Pos('&codMenus=6272,6276,6279&codNoticia=0', String(WebBrowser1.LocationURL)) > 0) Then
      Begin
        ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.getElementById("setaFilho1").click(); ', 'JavaScript');
        ExecuteScript((WebBrowser1.Document as IHTMLDocument2), ' document.querySelector("#tbRetratilFilho31 > tbody > tr > td > a").click(); ', 'JavaScript');

        wzctPrincipal.Buttons.Next.Click;

        Exit;
      End;
    End;
  End;
end;

procedure TfrmDownloadExtratoBB.WebBrowser1NewWindow2(ASender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin
  Cancel := True;
end;

procedure TfrmDownloadExtratoBB.wzctPrincipalButtonClick(Sender: TObject;
  AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
begin
  If AKind = wcbkCancel Then
    Close;
end;

procedure TfrmDownloadExtratoBB.wzctPrincipalPageChanged(Sender: TObject);
var
  i: dword;
begin
  If wzctPrincipal.ActivePage = wzpgPrincipal Then
  Begin
    WebBrowser1.Navigate('about:blank');

    pApagarIECache;
  End;

  If (wzctPrincipal.ActivePage = wzpgFinal) Then
  Begin
    wzctPrincipal.Buttons.Back.Enabled   := False;
    wzctPrincipal.Buttons.Cancel.Visible := False;
  End;

  If wzctPrincipal.ActivePage = wzpgPeriodo Then
  Begin
    wzctPrincipal.Buttons.Next.Enabled   := False;
    edtAgencia.SETFOCUS;
    If not pnlPeriodo.Visible Then
      pnlPeriodo.Visible := True;
  End;

  If wzctPrincipal.ActivePage = wzpgDadosConexao Then
  Begin
    wzctPrincipal.Buttons.Next.Enabled := False;
    pnlLogin.Visible := False;

    If InternetGetConnectedState(@i,0) Then
    Begin
      WebBrowser1.Navigate(fDesCriptografa('ÔààÜß¦ÍÍÜÖÎÎÏÛÙÎÞÍÍÜÖØÛÓÕÚÜÒÑÎÎ', 108));

      pnlLogin.Visible := True;
      edtChave.SETFOCUS;
    End
    Else
    Begin
      MessageDlg('Para baixar o extrato em arquivo ofx, é necessária uma conexão válida com a internet!', mtInformation, [mbOK], 0);
      wzctPrincipal.Buttons.Back.Click;
    End;
  End
  Else
    wzctPrincipal.Buttons.Next.Enabled := True;
end;

{ TWebBrowser }

function TWebBrowser.Download(pmk: IMoniker; pbc: IBindCtx; dwBindVerb,
  grfBINDF: DWORD; pBindInfo: PBindInfo; pszHeaders, pszRedir: PWideChar;
  uiCP: UINT): HRESULT;
var
  Allowed: Boolean;
begin
  Result := E_NOTIMPL;
  if Assigned(FOnBeforeFileDownload) then
  begin
    Allowed := True;
    if pszRedir <> '' then
      FFileSource := pszRedir;

    FOnBeforeFileDownload(Self, FFileSource, Allowed);
    if not Allowed then
      Result := S_OK;
  end;
end;

procedure TWebBrowser.InvokeEvent(ADispID: TDispID; var AParams: TDispParams);
begin
  inherited;
  // DispID 250 is the BeforeNavigate2 dispinterface and to the FFileSource here
  // is stored the URL parameter (for cases, when the IDownloadManager::Download
  // won't redirect the URL and pass empty string to the pszRedir)
  if ADispID = 250 then
    FFileSource := OleVariant(AParams.rgvarg^[5]);
end;

function TWebBrowser.QueryService(const rsid, iid: TGUID; out Obj): HRESULT;
begin
  Result := E_NOINTERFACE;
  Pointer(Obj) := nil;
  if Assigned(FOnBeforeFileDownload) and IsEqualCLSID(rsid, SID_SDownloadManager) and
    IsEqualIID(iid, IID_IDownloadManager) then
  begin
    if Succeeded(QueryInterface(IID_IDownloadManager, Obj)) and
      Assigned(Pointer(Obj))
    then
      Result := S_OK;
  end;
end;

end.
