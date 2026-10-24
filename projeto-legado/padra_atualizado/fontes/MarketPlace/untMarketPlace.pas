unit untMarketPlace;

interface

uses Generics.Collections,
     untFuncoesSimples,
     untTypesSistema,
     System.DateUtils,
     Data.DB,
     Types,
     Uni,
     StrUtils,
     IdHTTP,
     IdURI,
     Classes,
     SysUtils,
     Rest.Client,
     Rest.Authenticator.OAuth,
     Rest.Types,
     Rest.Json,
     IdBaseComponent,
     IdCoder,
     IdCoder3to4,
     IdCoderMIME,
     IpPeerClient,
     Forms,
     ShellApi,
     Printers,
     Windows,
     Messages,
     System.Zip;

function fCommunica(AUrl, AGetPost, AJson: String; AIgnoreToken: Boolean; ANumPok, AEmpHub: String): String;
function fConfiguraToken(AIgnoreToken: Boolean; AEmpHub: String): Boolean;
function fGet_UrlHub: String;
procedure pGetToken(AEmpHub: String; AForcaToken: Boolean = False);
function fVerificaNota(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, AOrigem: String; var ANumPok, AEmpHub, ARetorno: String): Boolean;
function fRetornaEtiquetMarketplaceZPL(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix: String; Var strMsgErro, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace: string; blnApenasGerarEtiqueta: Boolean; out AResultadoUnificacao: TResultadoEtiquetaUnificada; intTimeoutSec: Integer = 30): Boolean;
function fDownloadEtiquetMarketplacePDF(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix: String; Var strMsgErro, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace: string; intTimeoutSec: Integer = 30): Boolean;
function fSalvaArquivo(ANumPok: string; AArquivo: TRESTResponse; AFileExt: String): string;
function fPegaHandle(ATitulo, ADanfe: String): Cardinal;
procedure pSendMinimize;
procedure pSendClose;
procedure pChecaTempo(ATimeout: Boolean);
function fDescompactaArquivo(ACaminho, ADiretorio: string): Boolean;
function fSqlNota(APrefix, ACodCli: string): string;
function fValidaNotaMarketPlace(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix: String): Boolean;
function fRetornaStatusPedidoNoHub(const ANumPOK: String): String;
function fStatusPedidoNoHub(const AStatusHub: String): String;

var
  FToken: String;
  FEmpHub: String;
  FUltimoToken: TDateTime;
  FHandlePdf: Cardinal;
  FSair: Boolean;
  FTempo: TDateTime;

const
  PREFIX_MERCADO_LIVRE = 'MLB_';
  PREFIX_MAGALU = 'MGL_';
  PREFIX_SHOPEE = 'SHP_';
  PREFIX_VIAVAREJO = 'VRJ_';
  PREFIX_OLIST = 'OLS_';
  PREFIX_AMAZON = 'AMZ_';
  PREFIX_TIKTOK = 'TIKTOK_';

implementation

uses
  untMarketPlace.Classes,
  Marketplace.EtiquetaDespachoUnificada;

procedure pLog(AText: String);
begin
  If Not fEmptyStr(AText) Then
    If Not AText.ToLower.Contains('password') Then
      If Not VS_ExibirMensagemAoUsuario Then
        If Assigned(VS_OnMensagemAoUsuario) Then
          VS_OnMensagemAoUsuario(AText);
end;

function fCommunica(AUrl, AGetPost, AJson: String; AIgnoreToken: Boolean; ANumPok, AEmpHub: String): String;
var
  RESTClient1: TRESTClient;
  RESTRequest1: TRESTRequest;
  RESTResponse1: TRESTResponse;
  auth: TOAuth2Authenticator;
begin
  Result        := EmptyStr;
  RESTClient1   := nil;
  RESTRequest1  := nil;
  RESTResponse1 := nil;
  auth          := nil;
  try
    try
      if not fConfiguraToken(AIgnoreToken, AEmpHub) then
        Exit;

      Sleep(250);
      RESTClient1 := TRESTClient.Create(nil);
      RESTClient1.ContentType := 'application/json';
      RESTClient1.BaseURL := fGet_UrlHub + AUrl;

      pLog(RESTClient1.BaseURL);

      if not fEmptyStr(FToken) Then
      begin
        auth := TOAuth2Authenticator.Create(nil);
        auth.TokenType := TOAuth2TokenType.ttBEARER;
        auth.AccessToken := FToken;
        RESTClient1.Authenticator := auth;
      end;

      RESTRequest1 := TRESTRequest.Create(nil);
      RESTRequest1.Accept := 'application/json';

      case AnsiIndexStr(UpperCase(AGetPost), ['GET','POST','DELETE','PUT']) of
        0: RESTRequest1.Method := TRESTRequestMethod.rmGET;
        1: RESTRequest1.Method := TRESTRequestMethod.rmPOST;
        2: RESTRequest1.Method := TRESTRequestMethod.rmDELETE;
        3: RESTRequest1.Method := TRESTRequestMethod.rmPUT;
      end;

      RESTRequest1.Timeout := 10000;
      RESTRequest1.HandleRedirects := True;

      RESTResponse1 := TRESTResponse.Create(nil);

      RESTRequest1.Client := RESTClient1;
      RESTRequest1.Response := RESTResponse1;

      if not fEmptyStr(AJson) then
      begin
        RESTRequest1.Params.AddItem;
        RESTRequest1.Params.Items[0].Value := AJson;
        RESTRequest1.Params.Items[0].ContentType := ctAPPLICATION_JSON;
        pLog(LeftStr(AJson, 255) + ' ... ');
      end;

      RESTRequest1.Execute;

      try
        if RESTResponse1.StatusCode >= 400 then
        begin
          Result := '*' + RESTResponse1.Content + ' - ' + RESTResponse1.StatusText + ' - ' + IntToStr(RESTResponse1.StatusCode);
          pLog(RESTResponse1.StatusText + ' - ' + IntToStr(RESTResponse1.StatusCode) + ': ' + RESTResponse1.Content);
        end
        else
        begin
          Result := RESTResponse1.Content;
          pLog(RESTResponse1.StatusText + ' - ' + IntToStr(RESTResponse1.StatusCode));

          if AUrl.Contains('/tags') then
          begin
            Result := fSalvaArquivo(ANumPok, RESTResponse1, IfThen(AUrl.Contains('=pdf'), '.pdf', '.zip'));
            pLog(Result);
          end;
        end;
      except
        on E: Exception do
        begin
          pLog(E.Message);
          Result := '';
        end;
      end;
    except
      on E: Exception do
      begin
        Result := '*' + E.Message;
        if Assigned(RESTResponse1) then
          Result := Result + RESTResponse1.Content;
        pLog(Result);
      end;
    end;

  finally
    if Assigned(RESTClient1) then
    begin
      RESTClient1.Disconnect;
      FreeAndNil(RESTClient1);
    end;

    if Assigned(RESTRequest1) then
      FreeAndNil(RESTRequest1);

    if Assigned(RESTResponse1) then
      FreeAndNil(RESTResponse1);

    if Assigned(auth) then
      FreeAndNil(auth);
  end;
end;

function fConfiguraToken(AIgnoreToken: Boolean; AEmpHub: String): Boolean;
begin
  Result := True;

  if not AIgnoreToken then
  begin
    if not AEmpHub.IsEmpty Then
    begin
      pGetToken(AEmpHub);
      if FToken = '' then
        pGetToken(VS_strCodEmp);
    end
    else
      pGetToken(VS_strCodEmp);

    if FToken = '' then
      Result := False;
  end;
end;

function fGet_UrlHub: String;
begin
  if fArqIni(0, 'GERAL', 'HUB_HOMOLOG', 'N') = 'S' then
  begin
    Result := 'https://hub-hom.citelsoftware.com.br';
    Exit;
  end;

  Result := 'https://hub.citelsoftware.com.br';
end;

procedure pGetToken(AEmpHub: String; AForcaToken: Boolean = False);
var
  LJson: String;
  LRetorno: String;
  LLoja: String;
  LUser: String;
  LSenha: String;
begin
  if FEmpHub <> AEmpHub then
  begin
    FEmpHub := AEmpHub;
    FToken := '';
  end;

  LLoja  := fCfgSisHubCitel('LOJA', varString, AEmpHub, 'HUBCIT_');
  LUser  := fCfgSisHubCitel('USER', varString, AEmpHub, 'HUBCIT_');
  LSenha := fCfgSisHubCitel('SENHA', varString, AEmpHub, 'HUBCIT_');

  if not (MinutesBetween(fRetDtaHraServidor, FUltimoToken) > 10) then
  begin
    if not (fEmptyStr(FToken)) then
    begin
      if not AForcaToken then
        Exit;
    end;
  end;

  LJson := Format('{"store":"%s","userEmail":"%s","password":"%s"}', [LLoja, LUser, LSenha]);

  LRetorno := fCommunica('/authenticate/login', 'POST', LJson, True, '', AEmpHub);

  if Pos('*', LRetorno) = 1 then
  begin
    FToken := '';
  end
  else
  begin
    FToken := fExtractBetweenTags(LRetorno, '"accessToken":"', '"');
    FUltimoToken := fRetDtaHraServidor;
  end;

end;

function fVerificaNota(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, AOrigem: String; var ANumPok, AEmpHub, ARetorno: String): Boolean;
var
  LQryNota: TUniQuery;
  LObjPedidoNFe: TPedidoNFeHubCitel;
  LJson: String;
begin
  Result := False;
  LQryNota := fCriaQuery;
  LObjPedidoNFe := TPedidoNFeHubCitel.Create;

  try
    LQryNota.Close;
    LQryNota.SQL.Clear;
    LQryNota.SQL.Add(fSqlNota(APrefix, ACodCli));

    LQryNota.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryNota.ParamByName('ESPDOC').AsString := AEspDoc;
    LQryNota.ParamByName('CODEMP').AsString := ACodEmp;

    if (fCfgSis('CLETDS', varBoolean)) then
    begin
      if (not fEmptyStr(ACodCli)) then
        LQryNota.ParamByName('CODCLI').AsString := ACodCli;
    end;

    LQryNota.Open;

    if LQryNota.IsEmpty then
      Exit;

    LObjPedidoNFe.NfKey := LQryNota.FieldByName('CHAVE_ACESSO').AsString;
    LObjPedidoNFe.NfNumber := LQryNota.FieldByName('NOTA_FATURADA').AsString;
    LObjPedidoNFe.NfXml := LQryNota.FieldByName('NFE_ARQXML').AsString;
    LObjPedidoNFe.OrderId := LQryNota.FieldByName('PEDIDO_HUB').AsString.Replace(APrefix, '');
    LObjPedidoNFe.TrackingCode := LQryNota.FieldByName('COB_OBJDIG').AsString;
    LObjPedidoNFe.Origin := AOrigem;

    ANumPok := LQryNota.FieldByName('PEDIDO_HUB').AsString.Replace(APrefix, '');
    AEmpHub := LQryNota.FieldByName('EMPRESA_HUB').AsString;

    LJson := LObjPedidoNFe.ToJsonString;
    ARetorno := fCommunica('/pedidos/orders/'+ANumPok+'/fatured?sendMarketplace=true', 'PUT', LJson, False, '', AEmpHub);

    //Se trouxer alguma resposta deixa passar para pegar a etiqueta, assim pode haver a reimpressão da mesma caso precise.
    if not fEmptyStr(ARetorno) then
      Result := True;
  finally
    FreeAndNil(LQryNota);
    FreeAndNil(LObjPedidoNFe);
  end;
end;

// Retorna a chave NFe (44 digitos) vinculada ao pedido marketplace.
// Reutiliza fSqlNota que ja faz o JOIN FATGOR/LOGNFE necessario.
// Retorna string vazia se a nota nao for encontrada ou ainda nao estiver aprovada.
function fBuscarChaveNFeMarketPlace(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix: String): String;
var
  qryChave: TUniQuery;
begin
  Result := '';
  qryChave := fCriaQuery(nil);
  try
    qryChave.SQL.Text := fSqlNota(APrefix, ACodCli);
    qryChave.ParamByName('NUMDOC').AsString := ANumDoc;
    qryChave.ParamByName('ESPDOC').AsString := AEspDoc;
    qryChave.ParamByName('CODEMP').AsString := ACodEmp;
    if fCfgSis('CLETDS', varBoolean) then
      if not fEmptyStr(ACodCli) then
        qryChave.ParamByName('CODCLI').AsString := ACodCli;
    qryChave.Open;
    if not qryChave.IsEmpty then
      Result := qryChave.FieldByName('CHAVE_ACESSO').AsString;
  finally
    FreeAndNil(qryChave);
  end;
end;

function fRetornaEtiquetMarketPlaceZPL(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix: String; Var strMsgErro, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace: string; blnApenasGerarEtiqueta: Boolean; out AResultadoUnificacao: TResultadoEtiquetaUnificada; intTimeoutSec: Integer = 30): Boolean;
var
  LBegin: TDateTime;
  LRetorno: String;
  LNumPok: String;
  LEmpHub: String;
  LJaEnviou: Boolean;
  // EDUNIF: se marketplace habilitado no CFG_EDUNIF, unifica marketplace + DANFE
  // renderizada num unico ZPL. Cada prefixo (MLB_, SHP_, TIKTOK_...) e avaliado
  // individualmente - permite habilitar por marketplace via checklist na config.
  procedure pUnificarSeHabilitado;
  var
    LChaveNFe: String;
    LPathOriginal: String;
  begin
    If Not TEtiquetaDespachoUnificada.fMarketplaceUnificarAtivo(APrefix) Then
      Exit;

    LPathOriginal := strPathEtiqueta;
    LChaveNFe := fBuscarChaveNFeMarketPlace(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix);
    strPathEtiqueta := TEtiquetaDespachoUnificada.fGerar(strPathEtiqueta, ANumDoc, AEspDoc, ACodEmp, APrefix, LChaveNFe);

    If SameText(strPathEtiqueta, LPathOriginal) Then
      AResultadoUnificacao := reuNaoUnificada
    Else
      AResultadoUnificacao := reuUnificada;
  end;

  procedure pImprimirEtiqueta;
  begin
    pUnificarSeHabilitado;
    // Gerar o arquivo unificado nao e imprimir: a fila pode nao estar cadastrada ou a
    // escolha ser cancelada. Etiqueta que nao saiu nao entregou a DANFE, e quem decide a
    // DANFE separada (expedicao FATAUT) precisa saber disso.
    If (Not fImprimirEtiquetaZPL('frmImpEtiDespacho_'+ fTiraEspacos(strMarketplaceEtiqueta), 'Etiqueta de Despacho ('+ strMarketplaceEtiqueta +')', strPathEtiqueta))
       And (AResultadoUnificacao = reuUnificada) Then
      AResultadoUnificacao := reuNaoUnificada;
  end;

begin
  Result := False;
  AResultadoUnificacao := reuNaoAplicavel;
  LBegin := fNow();
  strMsgErro := EmptyStr;
  strPathEtiqueta := EmptyStr;
  strMarketplaceEtiqueta := EmptyStr;

  LJaEnviou := False;

  Repeat
    case AnsiIndexStr(UpperCase(APrefix), [PREFIX_MERCADO_LIVRE, PREFIX_MAGALU, PREFIX_SHOPEE, PREFIX_VIAVAREJO, PREFIX_OLIST, PREFIX_AMAZON, PREFIX_TIKTOK]) of
      0: strMarketplaceEtiqueta := 'Mercado Livre';
      1: strMarketplaceEtiqueta := 'Magazine Luiza';
      2: strMarketplaceEtiqueta := 'Shopee';
      3: strMarketplaceEtiqueta := 'Via Varejo';
      4: strMarketplaceEtiqueta := 'Olist';
      5: strMarketplaceEtiqueta := 'Amazon';
      6: strMarketplaceEtiqueta := 'Tik Tok Shop';
    end;

    If fFaturadorAutomaticoJaBaixouEtiquetaMarketplace(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, strPathEtiqueta) then
    Begin
      If Not blnApenasGerarEtiqueta Then
      Begin
        pImprimirEtiqueta;
      End;
      Result := True;
    End
    Else If LJaEnviou Or fVerificaNota(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, strMarketplaceEtiqueta, LNumPok, LEmpHub, strRetornoEnvioNFeMarketplace) then
    begin
      LJaEnviou := True;

      LRetorno := fCommunica('/pedidos/orders/'+LNumPok+'/tags?type=zpl2','GET','', True, LNumPok, LEmpHub);

      if LRetorno.Equals('gerou arquivo') then
      begin
        strPathEtiqueta := ExtractFilePath(Application.ExeName) + 'MarketPlace\' + LNumPok + '\Etiqueta de envio.txt';

        pLog(strPathEtiqueta);

        if FileExists(strPathEtiqueta) then
        begin
          If Not blnApenasGerarEtiqueta Then
          Begin
            pImprimirEtiqueta;
          End;
          Result := True;
        end;
      end
      else
        strMsgErro := LRetorno;
    end;

    If SecondsBetween(fNow(), LBegin) >= intTimeoutSec Then
    begin
      if intTimeoutSec > 0 Then
        pLog('ETIQUETA MARKETPLACE TIMEOUT');
      Break;
    end;
    Application.ProcessMessages;
    Sleep(1000);
  Until Result;
end;

function fDownloadEtiquetMarketplacePDF(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix: String; Var strMsgErro, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace: string; intTimeoutSec: Integer = 30): Boolean;
var
  LBegin: TDateTime;
  LRetorno: String;
  LNumPok: String;
  LEmpHub: String;
  LJaEnviou: Boolean;
begin
  Result := False;
  LBegin := fNow();
  strMsgErro := EmptyStr;
  strPathEtiqueta := EmptyStr;
  strMarketplaceEtiqueta := EmptyStr;

  LJaEnviou := False;

  Repeat
    case AnsiIndexStr(UpperCase(APrefix), [PREFIX_MERCADO_LIVRE, PREFIX_MAGALU, PREFIX_SHOPEE, PREFIX_VIAVAREJO, PREFIX_AMAZON]) of
      0: strMarketplaceEtiqueta := 'Mercado Livre';
      1: strMarketplaceEtiqueta := 'Magazine Luiza';
      2: strMarketplaceEtiqueta := 'Shopee';
      3: strMarketplaceEtiqueta := 'Via Varejo';
      4: strMarketplaceEtiqueta := 'Amazon';
    end;

    If fFaturadorAutomaticoJaBaixouEtiquetaMarketplace(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, strPathEtiqueta) and ExtractFileExt(strPathEtiqueta).Equals('.pdf') then
    Begin
      Result := True;
    End
    Else If LJaEnviou Or fVerificaNota(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, strMarketplaceEtiqueta, LNumPok, LEmpHub, strRetornoEnvioNFeMarketplace) then
    begin
      LJaEnviou := True;
      LRetorno := fCommunica('/pedidos/orders/'+LNumPok+'/tags?type=pdf','GET','', True, LNumPok, LEmpHub);
      if ExtractFileExt(LRetorno).Equals('.pdf') then
      begin
        strPathEtiqueta := LRetorno;
        pLog(strPathEtiqueta);
        if FileExists(strPathEtiqueta) then
          Result := True;
      end
      else
        strMsgErro := LRetorno;
    end;
    If SecondsBetween(fNow(), LBegin) >= intTimeoutSec Then
    begin
      if intTimeoutSec > 0 Then
        pLog('ETIQUETA MARKETPLACE TIMEOUT');
      Break;
    end;
    Application.ProcessMessages;
    Sleep(1000);
  Until Result;
end;

function fSalvaArquivo(ANumPok: string; AArquivo: TRESTResponse; AFileExt: String): string;
var
  LContador : Integer;
  LDanfeStream : TFileStream;
  LByteAtual: Byte;
  LPath: string;
  LDiretorio: string;
begin
  Result := EmptyStr;
  LDiretorio := ExtractFilePath(Application.ExeName) + 'MarketPlace\';

  if not DirectoryExists(LDiretorio) then
    CreateDir(LDiretorio);

  LPath := LDiretorio + ANumPok + AFileExt;
  LDanfeStream := TFileStream.Create(LPath, fmCreate);
  try
    For LContador := Low(AArquivo.RawBytes) To High(AArquivo.RawBytes) Do
    Begin
      LByteAtual := AArquivo.RawBytes[LContador];
      LDanfeStream.Write(LByteAtual, 1);
    End;
  Finally
    FreeAndNil(LDanfeStream);
  End;

  if AFileExt.Equals('.pdf') then
    Result := LPath
  else if fDescompactaArquivo(LPath, LDiretorio + ANumPok) then
    Result := 'gerou arquivo';
end;

function fPegaHandle(ATitulo, ADanfe: String): Cardinal;
begin
  Result := FindWindow('AcrobatSDIWindow', Nil);
  if Result <= 0 then
    Result := FindWindow(Nil, PChar(ATitulo));

  if Result <= 0 then
    Result := FindWindow(Nil, PChar(ADanfe + ' - ' + ATitulo));
end;

procedure pSendMinimize;
begin
  Try
    SendMessage(FHandlePdf, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  Except

  End;
end;

procedure pSendClose;
var
  LCont: Integer;
begin
  For LCont := 1 To 3 Do
  Begin
    Try
      SendMessage(FHandlePdf, WM_CLOSE, 0, 0);
    Except

    End;
  End;
end;

procedure pChecaTempo(ATimeout: Boolean);
Const
  TIMEOUT = 30;
begin
  if SecondsBetween(nOw(), FTempo) > TIMEOUT then
  Begin
    if ATimeout then
    Begin
      Raise Exception.Create('Timeout na impressão, por favor verifique o caminho da impressora nas ' +
        'configurações da Nota Eletrônica Citel.' + #13#10 +
        'Caso já esteja correto, feche o Acrobat Reader e tente novamente.');
    End
    Else
    Begin
      pSendClose;
      FSair := True;
    End;
  End;
end;

function fDescompactaArquivo(ACaminho, ADiretorio: string): Boolean;
var
  LDescompactar: TZipFile;
begin
  LDescompactar := TZipFile.Create;

  try
    Result := False;
    try
      if not DirectoryExists(ADiretorio) then
        CreateDir(ADiretorio);

      LDescompactar.Open(ACaminho, zmRead);
      LDescompactar.ExtractAll(ADiretorio);
      LDescompactar.Close;
      DeleteFile(pChar(ACaminho));
      Result := True;
    except
      on E: Exception do
        fMensagem('Descompactar',E.Message,['&OK']);
    end;
  finally
    FreeAndNil(LDescompactar);
  end;
end;

function fSqlNota(APrefix, ACodCli: string): string;
begin
  Result := 'SELECT FGO_NUMPOK AS PEDIDO_HUB, FGO_NUMFAT AS NOTA_FATURADA, ' +
            '       LOGNFE.NFE_ACESSO AS CHAVE_ACESSO, NFE_ARQXML, COB_OBJDIG, LOG_CODEMP AS EMPRESA_HUB ' +
            'FROM FATGOR ' +
            'LEFT JOIN LOGNFE ON LOGNFE.NFE_NUMDOC = FGO_NUMFAT AND LOGNFE.NFE_ESPDOC = FGO_TIPFAT AND LOGNFE.NFE_CODEMP = FGO_EMPFAT ' +
            'LEFT JOIN MOVGER ON GER_NUMDOC = FGO_NUMFAT AND GER_ESPDOC = FGO_TIPFAT AND GER_CODEMP = FGO_EMPFAT AND GER_CODCLI = FGO_CODCLI AND GER_TIP_FC = "C" ' +
            'LEFT JOIN PLPDOC ON PLD_NUMDOC = GER_NUMDOC AND PLD_ESPDOC = GER_ESPDOC AND PLD_CODEMP = GER_CODEMP ' +
            'LEFT JOIN COROBJ ON COB_NUMOBJ = PLD_NUMOBJ ' +
            'LEFT JOIN XMLNFE ON XMLNFE.NFE_ACESSO = LOGNFE.NFE_ACESSO ' +
            'INNER JOIN HUBCIT_LOGPED ON FATGOR.FGO_NUMPOK = HUBCIT_LOGPED.LOG_PEDIDO ' +
            'WHERE FGO_NUMPOK LIKE "' + APrefix + '%" ' +
            'AND GER_CODEMP = :CODEMP ' +
            'AND GER_ESPDOC = :ESPDOC ' +
            'AND GER_NUMDOC = :NUMDOC ';

  if (fCfgSis('CLETDS', varBoolean)) then
  begin
    if (not fEmptyStr(ACodCli)) then
      Result := Result + 'AND GER_CODCLI = :CODCLI ';
  end;

  Result := Result + 'AND GER_TIP_FC = "C" ' +
                     'AND GER_ORIDOC = "V" ' +
                     'GROUP BY FGO_NUMDOC, FGO_NUMPOK, FGO_NUMFAT, ' +
                     'LOGNFE.NFE_ACESSO, NFE_ARQXML, NFE_HORINI, COB_OBJDIG ';
end;

function fValidaNotaMarketPlace(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix: String): Boolean;
var
  LQryNota: TUniQuery;
  LOrigem: String;
  LPathEtiqueta: String;
begin
  If fFaturadorAutomaticoJaBaixouEtiquetaMarketplace(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, LPathEtiqueta) then
  begin
    Exit(True);
  end;

  Result := False;
  LQryNota := fCriaQuery;

  try
    case AnsiIndexStr(UpperCase(APrefix), [PREFIX_MERCADO_LIVRE, PREFIX_MAGALU, PREFIX_SHOPEE, PREFIX_VIAVAREJO, PREFIX_OLIST, PREFIX_AMAZON, PREFIX_TIKTOK]) of
      0: LOrigem := 'Mercado Livre';
      1: LOrigem := 'Magazine Luiza';
      2: LOrigem := 'Shopee';
      3: LOrigem := 'Via Varejo';
      4: LOrigem := 'Olist';
      5: LOrigem := 'Amazon';
      6: LOrigem := 'Tik Tok Shop';
    end;

    LQryNota.Close;
    LQryNota.SQL.Clear;
    LQryNota.SQL.Add(fSqlNota(APrefix, ACodCli));

    LQryNota.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryNota.ParamByName('ESPDOC').AsString := AEspDoc;
    LQryNota.ParamByName('CODEMP').AsString := ACodEmp;

    if (fCfgSis('CLETDS', varBoolean)) then
    begin
      if (not fEmptyStr(ACodCli)) then
        LQryNota.ParamByName('CODCLI').AsString := ACodCli;
    end;

    LQryNota.Open;

    if LQryNota.IsEmpty then
    begin
      fMensagem('ERRO - Marketplace','Pedido '+ LOrigem +' não encontrado para a geração da etiqueta.',['&OK']);
      Exit;
    end;

    if fEmptyStr(LQryNota.FieldByName('CHAVE_ACESSO').AsString) then
    begin
      fMensagem('ERRO - Marketplace', 'A nota ainda não foi aprovada no painel, verifique.',['&OK']);
      Exit;
    end;

    if fEmptyStr(LQryNota.FieldByName('NFE_ARQXML').AsString) then
    begin
      fMensagem('ERRO - Marketplace', 'A nota ainda não possui o XML para envio, verifique.',['&OK']);
      Exit;
    end;

    Result := True;
  finally
    FreeAndNil(LQryNota);
  end;
end;

function fRetornaStatusPedidoNoHub(const ANumPOK: String): String;
var
  LNumPok  : String;
  LRetorno : String;
  LEmpHub  : String;

  function fRetornaEmpresaHubPedido(const ANumPOK: String): String;
  var
    LConsulta: TUniQuery;
  begin
    Result := EmptyStr;

    LConsulta := fCriaQuery;
    Try
      LConsulta.Close;
      LConsulta.SQL.Text :=
        'SELECT L.LOG_CODEMP ' +
        '  FROM HUBCIT_LOGPED L ' +
        ' WHERE L.LOG_PEDIDO = :NUMPOK ' +
        '   AND IFNULL(L.LOG_CODEMP, '''') <> '''' ' +
        ' ORDER BY L.LOG_DTAENT DESC ' +
        ' LIMIT 1 ';

      LConsulta.ParamByName('NUMPOK').AsString := ANumPOK;
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
        Result := LConsulta.FieldByName('LOG_CODEMP').AsString;
    Finally
      FreeAndNil(LConsulta);
    End;
  end;

begin
  LEmpHub := EmptyStr;
  LNumPok := Copy(ANumPOK, 5, ANumPOK.Length);

  If fEmptyStr(LNumPok) Then
    Exit(EmptyStr);

  LEmpHub := fRetornaEmpresaHubPedido(ANumPOK);

  LRetorno := fCommunica('/pedidos/orders/'+LNumPok,
                         'GET',
                         EmptyStr,
                         False,
                         LNumPok,
                         LEmpHub);

  Result   := fExtractBetweenTags(LRetorno, '"status":"', '"');
end;

function fStatusPedidoNoHub(const AStatusHub: String): String;
begin
  Result := EmptyStr;
  If AStatusHub = 'CanceledOrder' Then
    Result := 'C'
  Else If AStatusHub = 'QuebraDePacote' Then
    Result := 'Q'
  Else If AStatusHub = 'TransportedOrder' Then
    Result := 'A';
end;

end.
