unit untDownloadExtratoBradesco;

interface

uses
  ShareMem, Winapi.Messages, System.SysUtils,  System.Types,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdComponent, IdUri,
  EditFocus, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.OleCtrls, DateUtils,
  Vcl.Menus, SHDocVw,  MSHTML, wininet, System.UiTypes,
  IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdCookieManager,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  Vcl.Controls, System.Classes, Vcl.Buttons, Registry, Winapi.Windows,
  untGravandoObs, untSubjectIntf, untSubjectClass, Vcl.AppEvnts, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar;

type
  TfrmDownloadExtratoBradesco = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtUsuario: TEditFocus;
    edtSenha: TEditFocus;
    rdOpcoes: TRadioGroup;
    grpPeriodo: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    WebBrowser1: TWebBrowser;
    btnConectar: TSpeedButton;
    CheckBox1: TCheckBox;
    ApplicationEvents1: TApplicationEvents;
    mskDtaFin: TcxDateEdit;
    mskDtaIni: TcxDateEdit;
    chkExibirSenha: TCheckBox;
    procedure btnConectarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const {$IF Defined(VER270)} {$ELSE}[Ref]{$IFEND} URL: OleVariant);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure WebBrowser1BeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; const {$IF Defined(VER270)} {$ELSE}[Ref]{$IFEND} URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure WebBrowser1NavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; const {$IF Defined(VER270)} {$ELSE}[Ref]{$IFEND} URL: OleVariant);
    procedure WebBrowser1DownloadBegin(Sender: TObject);
    procedure WebBrowser1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure FormCreate(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure chkExibirSenhaClick(Sender: TObject);
    procedure mskDtaIniPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure mskDtaFinPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    FIdCookieManager: TIdCookieManager;
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    strFuncao: String;
    CurDispatch: IDispatch;
    FDocLoaded: Boolean;

    FGravando : IObserver_;
    FSubject  : ISubject_;
    intTamanhoArquivo: Int64;

    strParameter : Array of String;

    function fBaixarArquivo: String;
    function fCarregarPagina: Boolean;
    function fFazerLogin: Boolean;
    function fGerarArquivo: Boolean;
    procedure pDesabilitarControles;
    procedure pHabilitaControles;

    procedure pGerarArquivo;

    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
  public
    { Public declarations }
    strArquivoBaixado: String;
    strDiretorioSalvar: String;
    hwndAutcom: HWND;
  end;

var
  frmDownloadExtratoBradesco: TfrmDownloadExtratoBradesco;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmDownloadExtratoBradesco.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if Msg.hwnd = hwndAutcom then
  begin
    Msg.wParam  := 0;
    Msg.message := 0;
    Msg.lParam  := 0;
  end;
end;

procedure TfrmDownloadExtratoBradesco.btnConectarClick(Sender: TObject);
begin
  if Trim(edtUsuario.Text) = '' then
  begin
    MessageDlg('Informe o usuário! ', mtInformation, [mbOK], 0);
    edtUsuario.SetFocus;
    Exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    MessageDlg('Informe a senha! ', mtInformation, [mbOK], 0);
    edtSenha.SetFocus;
    Exit;
  end;

  if mskDtaIni.Date > mskDtaFin.Date then
  begin
    MessageDlg('Data inicial não pode ser maior do que a data final!', mtInformation, [mbOK], 0);
    mskDtaIni.SetFocus;
    Exit;
  end;

  pApagarIECache;
  pDesabilitarControles;
  StatusBar1.Panels[0].Text := 'Iniciando conexão...';
  pGerarArquivo;
end;

procedure TfrmDownloadExtratoBradesco.edtSenhaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    btnConectar.Click;
end;

function TfrmDownloadExtratoBradesco.fBaixarArquivo: String;
var
  document: IHTMLDocument2;
  i, j, intTentativas: Integer;
  frame_dispatch: IDispatch;
  frame_win: IHTMLWindow2;
  Elements: OleVariant;
  strTag: TStringList;
  strLink, strNomeArquivo: WideString;
  cookies: TStringList;
  uri: TIdURI;
  ms:TMemoryStream;
  blnBaixou: Boolean;
begin
  Result        := '';
  blnBaixou     := False;
  intTentativas := 1;
  StatusBar1.Panels[0].Text := 'Iniciando dowload do arquivo...';

  strParameter[0] := '';
  strParameter[1] := '';
  strParameter[2] := 'Aguarde... Iniciando dowload do arquivo...';
  FSubject.pNotify(strParameter);

  //Fiz isso pois as opções do frame de download do arquivo não estava
  //pronto, ocasionando erro na hora do download do arquivo.
  while intTentativas <= 100 do
  begin
    Application.ProcessMessages;
    Inc(intTentativas);
  end;

  intTentativas := 1;

  try
    while (blnBaixou = False) and (intTentativas <= 100) do
    begin
      {$REGION 'VERIFICA_E_BAIXA'}
      document := WebBrowser1.Document as IHTMLDocument2;
      strLink := '';

      strParameter[2] := 'Aguarde... Iniciando dowload do arquivo...';
      FSubject.pNotify(strParameter);

      Application.ProcessMessages;

      for i := 0 to document.Frames.length -1 do
      begin
         frame_dispatch := document.Frames.Item(i);
        if frame_dispatch <> nil then
        begin
          frame_win := frame_dispatch as IHTMLWindow2;
          Elements := frame_win.document.all;
          for j := 0 to (Elements.length - 1) do
          begin
            if (Elements.item(j).id = 'linkDownloadArquivoVV') then
              Elements.item(j).Click;
          end;
        end;
      end;

      for i := 0 to document.Frames.length -1 do
      begin
        frame_dispatch := document.Frames.Item(i);
        if frame_dispatch <> nil then
        begin
          frame_win := frame_dispatch as IHTMLWindow2;
          Elements := frame_win.document.all;
          for j := 0 to (Elements.length - 1) do
          begin
            if (Elements.item(j).id = 'spanNomeArquivo') then
              strNomeArquivo := Elements.item(j).InnerText;

            if (Elements.item(j).id = 'linkDownloadArquivoVV') then
            begin
              strTag := TStringList.Create;
              strTag.Text := frame_win.document.Body.InnerHtml;
              cookies := TStringList.Create;
              cookies.Add(frame_win.document.cookie);

              try
                uri := TIdURI.Create(frame_win.document.URL);
                try
                  FIdCookieManager.AddServerCookies(cookies, uri);
                finally
                  uri.Free;
                end;
              finally
                cookies.Free;
              end;

              strLink := strTag.Strings[strTag.Count-1];
              strLink := StringReplace(strLink, '<div style="left: 0px; top: 0px; width: 1px; height: 1px; position: absolute;">', '', [rfReplaceAll]);
              strLink := StringReplace(strLink, '<a tabindex="15" title="" class="tabindex" id="hiddentablast" style="font-size: 1px;" href="javascript:;">&nbsp;</a></div><iframe src="', '', [rfReplaceAll]);
              strLink := StringReplace(strLink, '" style="display: none;"></iframe>', '', [rfReplaceAll]);
              strLink := StringReplace(strLink, '&amp;', '&', [rfReplaceAll]);
              strLink := 'https://www.ne12.bradesconetempresa.b.br/saldoExtratoNE/' + strLink;

              strTag.Free;
            end;
          end;
        end;
      end;

      if (strLink <> '') and (Pos(WideString('.ofx'), strLink) > 0) then
      begin
        StatusBar1.Panels[0].Text := 'Baixando arquivo...';
        if strDiretorioSalvar = '' then
          strDiretorioSalvar := ExtractFilePath(Application.ExeName)+'\Extratos_Baixados';

        if not DirectoryExists(strDiretorioSalvar) then
          CreateDir(strDiretorioSalvar);

        ms:=TMemoryStream.Create;
        try
          FIdHTTP.get(strLink, ms);
        except
           on e: Exception do
           begin
             strParameter[0] := 'Esconder';
             FSubject.pNotify(strParameter);
             ms.Free;
             MessageDlg('Ocorreu o seguinte erro ao tentar baixar o arquivo ofx: ' + e.Message, mtInformation, [mbOK], 0);
             Break;
           end;
        end;

        ms.SaveToFile(strDiretorioSalvar+'\'+strNomeArquivo);
        ms.Free;

        Result := strDiretorioSalvar+'\'+strNomeArquivo;

        blnBaixou := True;
      end;
      {$ENDREGION}
      Inc(intTentativas);
    end;

    strParameter[0] := 'Esconder';
    FSubject.pNotify(strParameter);
  except
    on e: Exception do
     begin
       strParameter[0] := 'Esconder';
       FSubject.pNotify(strParameter);
       MessageDlg('Ocorreu o seguinte erro ao tentar baixar o arquivo ofx: ' + e.Message, mtInformation, [mbOK], 0);
     end;
  end;
end;

function TfrmDownloadExtratoBradesco.fCarregarPagina: Boolean;
var
  i: dword;
begin
  Result := True;
  if InternetGetConnectedState(@i,0) then
  begin
    //Preparando array de parametros que será responsavel pelas notificações com o objeto observador.
    strParameter[0] := '';
    strParameter[1] := '';
    strParameter[2] := 'Aguarde... Carregando informações...';

    //Enviando notificação que vai atualizar os observadores.
    FSubject.pNotify(strParameter);

    try
      WebBrowser1.Navigate('https://www.ne2.bradesconetempresa.b.br/ibpjlogin/login.jsf');
    except
      strParameter[0] := 'Esconder';
      FSubject.pNotify(strParameter);
      MessageDlg('Ocorreu um erro ao carregar as informações', mtInformation, [mbOK], 0);
      Result := False;
      Exit;
    end;

    repeat
      Application.ProcessMessages;

      //Atualizando os observadores
      strParameter[3] := '';
      FSubject.pNotify(strParameter);
    until FDocLoaded;

    WebBrowser1.OleObject.Document.all.Item('rdoTipoAcesso', 0).Click;
    repeat
      Application.ProcessMessages;

      //Atualizando os observadores
      strParameter[3] := '';
      FSubject.pNotify(strParameter);
    until FDocLoaded;
  end
  else
  begin
    strParameter[0] := 'Esconder';
    FSubject.pNotify(strParameter);
    Result := False;
    MessageDlg('Para baixar o extrato em arquivo ofx, é necessária uma conexão válida com a internet!', mtInformation, [mbOK], 0);
  end;

  strParameter[0] := 'Esconder';
  FSubject.pNotify(strParameter);
end;

function TfrmDownloadExtratoBradesco.fFazerLogin: Boolean;
begin
  //Preparando array de parametros que será responsavel pelas notificações com o objeto observador.
  strParameter[0] := '';
  strParameter[1] := '';
  strParameter[2] := 'Aguarde... Efetuando Login...';

  //Enviando notificação que vai atualizar os observadores.
  FSubject.pNotify(strParameter);

  try
    StatusBar1.Panels[0].Text := 'Efetuando Login...';
    WebBrowser1.OleObject.Document.all.Item('identificationForm:txtUsuario', 0).value := edtUsuario.text;
    WebBrowser1.OleObject.Document.all.Item('identificationForm:txtSenha', 0).value   := edtSenha.text;

    WebBrowser1.OleObject.Document.all.Item('identificationForm:botaoAvancar', 0).Click;

    repeat
      Application.ProcessMessages;
      //Atualizando os observadores
      strParameter[3] := '';
      FSubject.pNotify(strParameter);

    until FDocLoaded;

    if Pos(WideString('/ibpjlogin/login.jsf'), WebBrowser1.LocationURL) > 0 then
    begin
      if WebBrowser1.OleObject.Document.GetElementByID('titleErroUsua').title =  'Usuário ou senha inválido' then
      begin
        strParameter[0] := 'Esconder';
        FSubject.pNotify(strParameter);

        MessageDlg('Usuário ou senha inválido!', mtInformation, [mbOK], 0);
        pHabilitaControles;
        edtUsuario.SetFocus;
        strFuncao := '';

        raise Exception.Create('Erro ao fazer login!');
      end;
    end;

    WebBrowser1.Navigate(WebBrowser1.LocationURL);

    while WebBrowser1.ReadyState <> READYSTATE_COMPLETE do
    begin
      Application.ProcessMessages;
      //Atualizando os observadores
      strParameter[3] := '';
      FSubject.pNotify(strParameter);
    end;

    repeat
      Application.ProcessMessages;
      //Atualizando os observadores
      strParameter[3] := '';
      FSubject.pNotify(strParameter);

    until FDocLoaded;

    Result := True;
    strParameter[0] := 'Esconder';
    FSubject.pNotify(strParameter);
  except
    strParameter[0] := 'Esconder';
    FSubject.pNotify(strParameter);
    Result := False;
  end;
end;

function TfrmDownloadExtratoBradesco.fGerarArquivo: Boolean;
var
  document: IHTMLDocument2;
  i, j, intTentativas: Integer;
  frame_dispatch: IDispatch;
  frame_win: IHTMLWindow2;
  Elements: OleVariant;
  blnGerou,
  blnCarregouConta: Boolean;
  strConta: String;
begin
  blnGerou  := False;
  Result    := False;
  intTentativas := 1;
  StatusBar1.Panels[0].Text := 'Gerando Arquivo......';

  strParameter[0] := '';
  strParameter[1] := '';
  strParameter[2] := 'Aguarde... Gerando Arquivo...';
  FSubject.pNotify(strParameter);

  //Fiz isso pois as opções do frame de geração de arquivo não estavam
  //completamente preenchidas, ocasionando erro na hora da geração do arquivo e
  //consequentemente no download do arquivo.
  while intTentativas <= 100 do
  begin
    Application.ProcessMessages;
    Inc(intTentativas);
  end;

  intTentativas := 1;
  blnCarregouConta := False;

  try
    while (blnGerou = False) and (intTentativas <= 100) do
    begin
      {$REGION 'GERANDO_ARQUIVO'}
      //Atualizando os observadores
      strParameter[2] := 'Aguarde... Gerando Arquivo...';
      FSubject.pNotify(strParameter);

      Application.ProcessMessages;

      if not blnCarregouConta then
      begin
        document := WebBrowser1.Document as IHTMLDocument2;
        for i := 0 to document.Frames.length -1 do
        begin
          frame_dispatch := document.Frames.Item(i);
          if frame_dispatch <> nil then
          begin
            frame_win := frame_dispatch as IHTMLWindow2;
            Elements := frame_win.document.all;
            for j := 0 to (Elements.length - 1) do
            begin
              if (Elements.item(j).id = 'todasContas') then
              begin
                strConta := Elements.item(j).InnerText;
                if strConta <> '' then
                begin
                  blnCarregouConta := True;
                  intTentativas    := 0;
                  Break;
                end;
              end;
            end;
          end;
        end;
      end;

      if blnCarregouConta then
      begin
        document := WebBrowser1.Document as IHTMLDocument2;

        for i := 0 to document.Frames.length -1 do
        begin
          frame_dispatch := document.Frames.Item(i);
          if frame_dispatch <> nil then
          begin
            frame_win := frame_dispatch as IHTMLWindow2;
            Elements := frame_win.document.all;
            for j := 0 to (Elements.length - 1) do
            begin
              if (Elements.item(j).id = 'btGerarArquivo') then
              begin
                Elements.item(j).Click;
                blnGerou := True;
              end;
            end;
          end;
        end;
      end;
      {$ENDREGION}
      Inc(intTentativas);
    end;

    if blnGerou then
      Result := True;

    strParameter[0] := 'Esconder';
    FSubject.pNotify(strParameter);
  except
    strParameter[0] := 'Esconder';
    FSubject.pNotify(strParameter);

    Raise Exception.Create('Não foi possível gerar o arquivo!');
  end;
end;


procedure TfrmDownloadExtratoBradesco.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  vReg : TRegistry;
begin
  SetLength(strParameter, 0);
  vReg := TRegistry.Create(KEY_WRITE);
  try
    vReg.RootKey := HKEY_CURRENT_USER;

    if vReg.OpenKey('Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION',True) then
      vReg.DeleteValue(ExtractFileName(Application.ExeName));

     vReg.CloseKey;
  finally
    vReg.Free;
  end;
end;

procedure TfrmDownloadExtratoBradesco.FormCreate(Sender: TObject);
begin
  strDiretorioSalvar := '';
end;

procedure TfrmDownloadExtratoBradesco.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  If key = #13 then Begin
    Perform(Wm_NextDlgCtl,0,0);
  end;

  if Key = #27 then
    Close;
end;

procedure TfrmDownloadExtratoBradesco.FormShow(Sender: TObject);
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
        vReg.WriteInteger(ExtractFileName(Application.ExeName), 11001);
      end;
      vReg.CloseKey;
    end;
  finally
    vReg.Free;
  end;
  FIdHttp := TIdHTTP.Create(nil);

  FIdHttp.Request.Accept := 'text/html, */*';
  FIdHttp.Request.UserAgent := 'Mozilla/3.0 (compatible; IndyLibrary)';
  FIdHttp.Request.ContentType := 'application/x-www-form-urlencoded';
  FIdHttp.HandleRedirects := True;

  FIdCookieManager := TIdCookieManager.Create(Nil);
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  FIdHttp.CookieManager := FIdCookieManager;
  FIdHttp.IOHandler     := FIdSSLIOHandlerSocketOpenSSL;

  FIdHttp.OnWork      := HTTPWork;
  FIdHttp.OnWorkBegin := HTTPWorkBegin;
  FIdHTTP.OnWorkEnd   := HTTPWorkEnd;

  FIdHttp.ConnectTimeout := 5000;
  FIdHttp.ReadTimeout    := 5000;

  mskDtaIni.Properties.MaxDate   :=  IncDay(Date, -1);
  mskDtaIni.Date                 :=  IncDay(Date, -1);

  mskDtaFin.Properties.MaxDate :=  IncDay(Date, -1);
  mskDtaFin.Date               :=  IncDay(Date, -1);

  FGravando := TGravandoObs.Create;
  FSubject  := TSubject.Create;
  FSubject.pAddObserver(FGravando);
  SetLength(strParameter, 4);

  StatusBar1.Panels[0].Text := 'Limpando Cache...';
  pDesabilitarControles;
  pApagarIECache;
  pHabilitaControles;
  StatusBar1.Panels[0].Text := 'Aguardando dados para conexão...';
  Self.BringToFront;
end;

procedure TfrmDownloadExtratoBradesco.HTTPWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  if intTamanhoArquivo = 0 then
    Exit;

  if Assigned(FSubject) then
  begin
    strParameter[0] := 'TProgressBar';
    strParameter[1] := IntToStr(intTamanhoArquivo);
    strParameter[2] := 'Baixando Arquivo...';
    strParameter[3] := IntToStr(Round((AWorkCount / intTamanhoArquivo) * 100));

    FSubject.pNotify(strParameter);
    Application.ProcessMessages;
  end;
end;

procedure TfrmDownloadExtratoBradesco.HTTPWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  if Assigned(FSubject) then
  begin
    intTamanhoArquivo := 100;

    strParameter[0] := 'TProgressBar';
    strParameter[1] := IntToStr(intTamanhoArquivo);
    strParameter[2] := 'Baixando Arquivo...';
    strParameter[3] := '0';
    FSubject.pNotify(strParameter);

    Application.ProcessMessages;
  end;
end;

procedure TfrmDownloadExtratoBradesco.HTTPWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  if intTamanhoArquivo > 0 then
  begin
    if Assigned(FSubject) then
    begin
      strParameter[0] := 'TProgressBar';
      strParameter[1] := IntToStr(intTamanhoArquivo);
      strParameter[2] := 'Arquivo Baixado com Sucesso!';
      strParameter[3] := '100';
      FSubject.pNotify(strParameter);
      Application.ProcessMessages;
    end;
    intTamanhoArquivo := 0;
  end;
end;

procedure TfrmDownloadExtratoBradesco.mskDtaFinPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  if DisplayValue >= Date then
  begin
    Error := True;
    MessageDlg('Data inválida!'+#13+'A data deve ser menor que hoje ' + DateToStr(now), mtInformation, [mbOK], 0);
  end;

end;

procedure TfrmDownloadExtratoBradesco.mskDtaIniPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  if DisplayValue >= Date then
  begin
    Error := True;
    MessageDlg('Data inválida!'+#13+'A data deve ser menor que hoje ' + DateToStr(now), mtInformation, [mbOK], 0);
  end;

end;

procedure TfrmDownloadExtratoBradesco.pDesabilitarControles;
begin
  rdOpcoes.Enabled   := False;
  grpPeriodo.Enabled := False;
  edtUsuario.Enabled := False;
  edtSenha.Enabled   := False;
  mskDtaIni.Enabled  := False;
  mskDtaFin.Enabled  := False;
  btnConectar.Enabled := False;
end;

procedure TfrmDownloadExtratoBradesco.pGerarArquivo;
var
  strRetorno: String;
begin
  Application.ProcessMessages;
  Self.Enabled := false;
  if fCarregarPagina then
  begin
    if fFazerLogin then
    begin
      repeat Application.ProcessMessages until FDocLoaded;
      if fGerarArquivo then
      begin
        strArquivoBaixado := '';
        repeat Application.ProcessMessages until FDocLoaded;
        strArquivoBaixado :=  fBaixarArquivo;
        if strArquivoBaixado <> '' then
          strRetorno := 'Acabou'
        else
          strRetorno := 'Erro';
      end
      else
        strRetorno := 'Erro';
    end
    else
      strRetorno := 'Erro';
  end
  else
    strRetorno := 'Erro';

  Self.Enabled := True;

  if strRetorno = 'Erro' then
  begin
    strParameter[0] := 'Esconder';
    FSubject.pNotify(strParameter);

    MessageDlg('Ocorreu um erro ao tentar baixar o arquivo ofx!', mtInformation, [mbOK], 0);
    strRetorno := '';
    pHabilitaControles;
    edtUsuario.SetFocus;
  end;

  if strRetorno = 'Acabou' then
    Close;
end;

procedure TfrmDownloadExtratoBradesco.pHabilitaControles;
begin
  rdOpcoes.Enabled   := True;
  grpPeriodo.Enabled := True;
  edtUsuario.Enabled := True;
  edtSenha.Enabled   := True;
  mskDtaIni.Enabled  := True;
  mskDtaFin.Enabled  := True;
  btnConectar.Enabled := True;
end;

procedure TfrmDownloadExtratoBradesco.btnInfoClick(Sender: TObject);
begin
  MessageDlg('Só é permitido baixar o extrato com data anterior a data atual', mtInformation, [mbOK], 0);
end;

procedure TfrmDownloadExtratoBradesco.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Self.Width  := 1136;
    Self.Height := 461;
    WebBrowser1.Visible := True;
  end
  else
  begin
    Self.Width  := 389;
    Self.Height := 209;
    WebBrowser1.Visible := False;
  end;

end;

procedure TfrmDownloadExtratoBradesco.chkExibirSenhaClick(Sender: TObject);
begin
  if chkExibirSenha.Checked then
    edtSenha.PasswordChar := #0
  else
    edtSenha.PasswordChar := '*'
end;

procedure TfrmDownloadExtratoBradesco.WebBrowser1BeforeNavigate2(
  ASender: TObject; const pDisp: IDispatch; const {$IF Defined(VER270)} {$ELSE}[Ref]{$IFEND} URL, Flags,
  TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);
begin
  CurDispatch := nil;
  FDocLoaded := False;
end;

procedure TfrmDownloadExtratoBradesco.WebBrowser1DocumentComplete(
  ASender: TObject; const pDisp: IDispatch; const {$IF Defined(VER270)} {$ELSE}[Ref]{$IFEND} URL: OleVariant);
var
  currentBrowser: IWebBrowser;
  topBrowser: IWebBrowser;
  document: OleVariant;
  windowName: string;
  Elements: OleVariant;
  documento: IHTMLDocument2;
  i, intAguardarPagina: Integer;
begin
  if (pDisp = CurDispatch) then
  begin
    FDocLoaded := True;
    CurDispatch := nil;
  end;

  currentBrowser := pDisp as IWebBrowser;
  topBrowser := (ASender as TWebBrowser).DefaultInterface;
  document := currentBrowser.Document;
  windowName := document.ParentWindow.Name;

  try
    if UpperCase(windowName) = 'PAGINACENTRAL' then
    begin

      if Pos(WideString('dashboardSaldos'), currentBrowser.LocationURL) > 0 then
      begin
        WebBrowser1.OleObject.Document.GetElementByID('_id64_0:_id66', 0).Click;
      end;

      if Pos(WideString('menuSaldoExtrato'), currentBrowser.LocationURL) > 0 then
      begin
        documento := (currentBrowser.Document as IHTMLDocument2);

        Elements := documento.all;
        for i := 0 to (Elements.length - 1) do
        begin

           if (Elements.item(i).title = 'Exportar Extrato em Arquivo') then
               Elements.item(i).Click;
        end;
      end;

      if Pos(WideString('extratoDownloadSelecionar'), currentBrowser.LocationURL) > 0 then
      begin
        documento := (currentBrowser.Document as IHTMLDocument2);

        Elements := documento.all;
        for i := 0 to (Elements.length - 1) do
        begin
           if (Elements.item(i).title = 'OFX (Money 2000 em diante)') then
               Elements.item(i).Click;

        end;

        case rdOpcoes.ItemIndex of
          0: Document.GetElementByID('radio_conta_corrente', 0).Click;
          1: Document.GetElementByID('radio_conta_poupanca', 0).Click;
          2: Document.GetElementByID('radio_conta_investimento', 0).Click;
        end;

        Document.GetElementByID('apartirde', 0).Click;
        Document.all.Item('txtDiaIni', 0).value := FormatDateTime('dd', mskDtaIni.Date);
        Document.all.Item('txtMesIni', 0).value := FormatDateTime('mm', mskDtaIni.Date);
        Document.all.Item('txtAnoIni', 0).value := FormatDateTime('yyyy', mskDtaIni.Date);

        Document.all.Item('txtDiaFim', 0).value := FormatDateTime('dd', mskDtaFin.Date);
        Document.all.Item('txtMesFim', 0).value := FormatDateTime('mm', mskDtaFin.Date);
        Document.all.Item('txtAnoFim', 0).value := FormatDateTime('yyyy', mskDtaFin.Date);

        intAguardarPagina := 0;

        while intAguardarPagina <= 20 do
        begin
          Application.ProcessMessages;

          Inc(intAguardarPagina);
        end;
      end;
    end;
  except
     on e: Exception do
     begin
       strParameter[0] := 'Esconder';
       FSubject.pNotify(strParameter);
       MessageDlg('Ocorreu o seguinte erro ao tentar baixar o arquivo ofx: ' + e.Message, mtInformation, [mbOK], 0);
     end;
  end;
end;

procedure TfrmDownloadExtratoBradesco.WebBrowser1DownloadBegin(Sender: TObject);
begin
  Application.ProcessMessages;
end;

procedure TfrmDownloadExtratoBradesco.WebBrowser1NavigateComplete2(
  ASender: TObject; const pDisp: IDispatch; const {$IF Defined(VER270)} {$ELSE}[Ref]{$IFEND} URL: OleVariant);
begin
  if CurDispatch = nil then
    CurDispatch := pDisp;
end;


procedure TfrmDownloadExtratoBradesco.WebBrowser1NewWindow2(ASender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin
  Cancel := True;
end;

end.




