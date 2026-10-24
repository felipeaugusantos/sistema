unit untHubCitel;

interface

uses
  Generics.Collections,
  untFuncoesSimples,
  System.DateUtils,
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
  Forms,
  Windows,
  Messages,
  Data.DB,
  IPPeerCommon,
  IPPeerClient,
  IPPeerServer;

Type

  TToken = class
  strict private
    FToken       : String;
    FEmpHub      : String;
    FUltimoToken : TDateTime;
    FTrocouEmp   : Boolean;
    function Expirou : Boolean;
    procedure GetToken;
  public
    constructor New(AEmpHub : String); Reintroduce;
    function ConfiguraToken(AEmpHub : String) : Boolean;
    property Token : String read FToken;
  end;

  TComunica = class
  private
    FURL     : String;
    FGetPost : String;
    FJSON    : String;
    FNumPok  : String;
    FEmpHub  : String;
    FIgnoreToken : Boolean;
    function Get_UrlHub: String;
    function ValidouToken : Boolean;
  public
    constructor New(const AUrl, AGetPost, AJson: String; AIgnoreToken: Boolean; ANumPok, AEmpHub: String); Reintroduce;
    function Execute : String;
  end;

  THubCitel = class
  private
    function VerificaNota(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, AOrigem: String; var ANumPok, AEmpHub, ARetorno: String): Boolean;
    function SQLNota(const APrefix, ACodCli: string): string;
    function RetornaPrefixo(const ANumDoc, AEspDoc, ACodEmp : String) : String;
  public
    constructor New;
    function RetornaEtiquetaZPLHubCitel(const
                                        ANumDoc,
                                        AEspDoc,
                                        ACodEmp,
                                        ACodCli,
                                        AAcesso : String): Boolean;
  end;

  const
    GEROU_ARQUIVO = 'GEROU_ARQUIVO';
    TIME_OUT_SEC  = 30;

  var
    GLog     : TStringList;
    objToken : TToken;

  procedure Log(AText: String);

implementation

uses
  untMarketPlace.Classes;

{ THubCitel }

function TToken.ConfiguraToken(AEmpHub : String) : Boolean;
begin

  Result := True;

  If FEmpHub.IsEmpty Then
    FEmpHub := AEmpHub;

  FTrocouEmp := (FEmpHub <> AEmpHub);

  if FTrocouEmp then
  begin
    FEmpHub := AEmpHub;
    FToken  := '';
  end;

  GetToken;

  if FToken.IsEmpty then
    Result := False;

end;

function TToken.Expirou: Boolean;
begin

  Result := True;

  If FToken.IsEmpty Then
    Exit;

  If (MinutesBetween(fRetDtaHraServidor, FUltimoToken) > 10) Then
    Exit;

  Result := False;

end;

procedure TToken.GetToken;
  var
    LJson     : String;
    LRetorno  : String;
    LLoja     : String;
    LUser     : String;
    LSenha    : String;
    LComunica : TComunica;
begin

  If Not FTrocouEmp Then
    If Not Expirou Then
      Exit;

  LLoja  := fCfgSisHubCitel('LOJA' , varString, FEmpHub, 'HUBCIT_');
  LUser  := fCfgSisHubCitel('USER' , varString, FEmpHub, 'HUBCIT_');
  LSenha := fCfgSisHubCitel('SENHA', varString, FEmpHub, 'HUBCIT_');

  LJson := Format('{"store":"%s","userEmail":"%s","password":"%s"}', [LLoja, LUser, LSenha]);

  LComunica := TComunica.New('/authenticate/login', 'POST', LJson, True, '', FEmpHub);

  Try
    LRetorno := LComunica.Execute;
  Finally
    FreeAndNil(LComunica);
  End;

  if Pos('*', LRetorno) = 1 then
  begin
    FToken := '';
  end
  else
  begin
    FToken       := fExtractBetweenTags(LRetorno, '"accessToken":"', '"');
    FUltimoToken := fRetDtaHraServidor;
  end;

end;

constructor TToken.New(AEmpHub: String);
begin
  FEmpHub    := AEmpHub;
  FTrocouEmp := False;
end;

function TComunica.Get_UrlHub: String;
begin

  if fArqIni(0, 'GERAL', 'HUB_HOMOLOG', 'N') = 'S' then
    Exit('https://hub-hom.citelsoftware.com.br');

  Result := 'https://hub.citelsoftware.com.br';

end;

procedure Log(AText: String);
  var
    LLog : String;
begin
  LLog := FormatDateTime('dd/mm/yyyy hh:mm', fRetDtaHraServidor) + ' - ' + AText;
  GLog.Add(LLog);
end;

constructor THubCitel.New;
begin
  GLog.Clear;
end;

function THubCitel.RetornaEtiquetaZPLHubCitel(const ANumDoc, AEspDoc, ACodEmp, ACodCli, AAcesso : String): Boolean;
  var
    LBegin    : TDateTime;
    LRetorno  : String;
    LNumPok   : String;
    LEmpHub   : String;
    LJaEnviou : Boolean;
    LPrefix   : String;
    LComunica : TComunica;

    strMsgErro             : String;
    strPathEtiqueta        : String;
    strPathEtiquetaRenomeada : String;
    strMarketplaceEtiqueta   : String;
    strRetornoEnvioNFeMarketplace : String;

begin

  Result := False;
  LBegin := fNow();

  strMsgErro             := EmptyStr;
  strPathEtiqueta        := EmptyStr;
  strMarketplaceEtiqueta := EmptyStr;

  LJaEnviou := False;

  Repeat

    LPrefix := RetornaPrefixo(ANumDoc, AEspDoc, ACodEmp);

    case AnsiIndexStr(UpperCase(LPrefix), [PREFIX_MERCADO_LIVRE, PREFIX_MAGALU, PREFIX_SHOPEE, PREFIX_VIAVAREJO, PREFIX_OLIST, PREFIX_AMAZON]) of
      0: strMarketplaceEtiqueta := 'Mercado Livre';
      1: strMarketplaceEtiqueta := 'Magazine Luiza';
      2: strMarketplaceEtiqueta := 'Shopee';
      3: strMarketplaceEtiqueta := 'Via Varejo';
      4: strMarketplaceEtiqueta := 'Olist';
      5: strMarketplaceEtiqueta := 'Amazon';
    end;

    if LJaEnviou Or VerificaNota(ANumDoc, AEspDoc, ACodEmp, ACodCli, LPrefix, strMarketplaceEtiqueta, LNumPok, LEmpHub, strRetornoEnvioNFeMarketplace) then
    begin

      LJaEnviou := True;

      LComunica := TComunica.New('/pedidos/orders/'+LNumPok+'/tags?type=zpl2','GET','', True, LNumPok, LEmpHub);

      Try
        LRetorno := LComunica.Execute;
      Finally
        FreeAndNil(LComunica);
      End;

      if LRetorno.Equals(GEROU_ARQUIVO) then
      begin

        strPathEtiqueta          := ExtractFilePath(Application.ExeName) + 'ARQUIVOS\' + LNumPok + '\Etiqueta de envio.txt';
        strPathEtiquetaRenomeada := strPathEtiqueta.Replace('\Etiqueta de envio.txt', '\' + AAcesso + '.zpl');

        RenameFile(strPathEtiqueta, strPathEtiquetaRenomeada);
        pLog(strPathEtiquetaRenomeada);

        Result := FileExists(strPathEtiquetaRenomeada);

      end
      else
        strMsgErro := LRetorno;

    end;

    If SecondsBetween(fNow(), LBegin) >= TIME_OUT_SEC Then
    begin
      if (TIME_OUT_SEC > 0) Then
        pLog('ETIQUETA MARKETPLACE TIMEOUT');
      Break;
    end;

    Application.ProcessMessages;
    Sleep(1000);

  Until Result;

end;

function THubCitel.RetornaPrefixo(const ANumDoc, AEspDoc, ACodEmp: String): String;
  const
    SQL = 'SELECT   ' +
          '  FGO_NUMPOK AS PEDIDO_HUB ' +
          'FROM     ' +
          '  FATGOR ' +
          '  LEFT JOIN MOVGER ON (GER_NUMDOC = FGO_NUMFAT AND ' +
          '                       GER_ESPDOC = FGO_TIPFAT AND ' +
          '                       GER_CODEMP = FGO_EMPFAT AND ' +
          '                       GER_CODCLI = FGO_CODCLI AND ' +
          '                       GER_TIP_FC = "C")           ' +
          'WHERE ' +
          '  FGO_NUMFAT <> ""     AND ' +
          '  GER_CODEMP = :CODEMP AND ' +
          '  GER_ESPDOC = :ESPDOC AND ' +
          '  GER_NUMDOC = :NUMDOC ';
  var
    LBuscaPrefixo : TUniQuery;
    LPrefixo : String;
begin

  Result := '';

  If ANumDoc.IsEmpty Then
    Exit;

  If AEspDoc.IsEmpty Then
    Exit;

  If ACodEmp.IsEmpty Then
    Exit;

  LBuscaPrefixo := fCriaQuery(Nil);

  Try

    LBuscaPrefixo.SQL.Add(SQL);
    LBuscaPrefixo.ParamByName('NUMDOC').AsString := ANumDoc;
    LBuscaPrefixo.ParamByName('ESPDOC').AsString := AEspDoc;
    LBuscaPrefixo.ParamByName('CODEMP').AsString := ACodEmp;
    LBuscaPrefixo.Open;

    If LBuscaPrefixo.IsEmpty Then
      Exit;

    LPrefixo := LBuscaPrefixo.FieldByName('PEDIDO_HUB').AsString;

    If (Pos(PREFIX_MERCADO_LIVRE, LPrefixo) > 0) Then
      Result := PREFIX_MERCADO_LIVRE
    Else If (Pos(PREFIX_MAGALU, LPrefixo) > 0) Then
      Result := PREFIX_MAGALU
    Else If (Pos(PREFIX_SHOPEE, LPrefixo) > 0) Then
      Result := PREFIX_SHOPEE
    Else If (Pos(PREFIX_VIAVAREJO, LPrefixo) > 0) Then
      Result := PREFIX_VIAVAREJO
    Else If (Pos(PREFIX_OLIST, LPrefixo) > 0) Then
      Result := PREFIX_OLIST
    Else If (Pos(PREFIX_AMAZON, LPrefixo) > 0) Then
      Result := PREFIX_AMAZON;

  Finally
    FreeAndNil(LBuscaPrefixo);
  End;

end;

function THubCitel.SQLNota(const APrefix, ACodCli: string): string;
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
            'AND FGO_NUMFAT <> "" ' +
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

function THubCitel.VerificaNota(ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, AOrigem: String; var ANumPok, AEmpHub, ARetorno: String): Boolean;
  var
    LQryNota      : TUniQuery;
    LObjPedidoNFe : TPedidoNFeHubCitel;
    LJson         : String;
    LComunica     : TComunica;
begin

  Result := False;

  LQryNota      := fCriaQuery;
  LObjPedidoNFe := TPedidoNFeHubCitel.Create;

  try

    LQryNota.Close;
    LQryNota.SQL.Clear;
    LQryNota.SQL.Add(SqlNota(APrefix, ACodCli));

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

    LObjPedidoNFe.NfKey        := LQryNota.FieldByName('CHAVE_ACESSO').AsString;
    LObjPedidoNFe.NfNumber     := LQryNota.FieldByName('NOTA_FATURADA').AsString;
    LObjPedidoNFe.NfXml        := LQryNota.FieldByName('NFE_ARQXML').AsString;
    LObjPedidoNFe.OrderId      := LQryNota.FieldByName('PEDIDO_HUB').AsString.Replace(APrefix, '');
    LObjPedidoNFe.TrackingCode := LQryNota.FieldByName('COB_OBJDIG').AsString;
    LObjPedidoNFe.Origin       := AOrigem;

    ANumPok := LQryNota.FieldByName('PEDIDO_HUB').AsString.Replace(APrefix, '');
    AEmpHub := LQryNota.FieldByName('EMPRESA_HUB').AsString;

    LJson := LObjPedidoNFe.ToJsonString;

    LComunica := TComunica.New('/pedidos/orders/'+ANumPok+'/fatured?sendMarketplace=true', 'PUT', LJson, False, '', AEmpHub);

    Try
      ARetorno := LComunica.Execute;
    Finally
      FreeAndNil(LComunica);
    End;

    //Se trouxer alguma resposta deixa passar para pegar a etiqueta, assim pode haver a reimpressão da mesma caso precise.
    if not fEmptyStr(ARetorno) then
      Result := True;

  finally
    FreeAndNil(LQryNota);
    FreeAndNil(LObjPedidoNFe);
  end;

end;

{ TComunica }

function TComunica.Execute: String;
  var
    LRESTClient   : TRESTClient;
    LRESTRequest  : TRESTRequest;
    LRESTResponse : TRESTResponse;
    LAuth         : TOAuth2Authenticator;
begin

  try

    try

      If Not ValidouToken Then
        Exit;

      Sleep(250);
      LRESTClient             := TRESTClient.Create(nil);
      LRESTClient.ContentType := 'application/json';
      LRESTClient.BaseURL     := Get_UrlHub + FUrl;

      Log(LRESTClient.BaseURL);

      if not fEmptyStr(objToken.Token) Then
      begin
        LAuth := TOAuth2Authenticator.Create(nil);
        LAuth.TokenType   := TOAuth2TokenType.ttBEARER;
        LAuth.AccessToken := objToken.Token;
        LRESTClient.Authenticator := LAuth;
      end;

      LRESTRequest := TRESTRequest.Create(nil);
      LRESTRequest.Accept := 'application/json';

      case AnsiIndexStr(UpperCase(FGetPost), ['GET','POST','DELETE','PUT']) of
        0: LRESTRequest.Method := TRESTRequestMethod.rmGET;
        1: LRESTRequest.Method := TRESTRequestMethod.rmPOST;
        2: LRESTRequest.Method := TRESTRequestMethod.rmDELETE;
        3: LRESTRequest.Method := TRESTRequestMethod.rmPUT;
      end;

      LRESTRequest.Timeout := 10000;
      LRESTRequest.HandleRedirects := True;

      LRESTResponse := TRESTResponse.Create(nil);

      LRESTRequest.Client   := LRESTClient;
      LRESTRequest.Response := LRESTResponse;

      if not fEmptyStr(FJson) then
      begin
        LRESTRequest.Params.AddItem;
        LRESTRequest.Params.Items[0].Value := FJson;
        LRESTRequest.Params.Items[0].ContentType := ctAPPLICATION_JSON;
        Log(LeftStr(FJson, 255) + ' ... ');
      end;

      LRESTRequest.Execute;

      try
        if LRESTResponse.StatusCode >= 400 then
        begin
          Result := '*' + LRESTResponse.Content + ' - ' + LRESTResponse.StatusText + ' - ' + IntToStr(LRESTResponse.StatusCode);
          Log(LRESTResponse.StatusText + ' - ' + IntToStr(LRESTResponse.StatusCode) + ': ' + LRESTResponse.Content);
        end
        else
        begin
          Result := LRESTResponse.Content;
          Log(LRESTResponse.StatusText + ' - ' + IntToStr(LRESTResponse.StatusCode));

          if FUrl.Contains('/tags') then
          begin
            Result := SalvaArquivo(FNumPok, LRESTResponse, GEROU_ARQUIVO);
            Log(Result);
          end;
        end;
      except
        on E: Exception do
        begin
          Log(E.Message);
          Result := '';
        end;
      end;
    except
      on E: Exception do
      begin
        Result := '*' + E.Message + LRESTResponse.Content;
        Log(Result);
      end;
    end;

  finally
    LRESTClient.Disconnect;
    FreeAndNil(LRESTClient);
    FreeAndNil(LRESTRequest);
    FreeAndNil(LRESTResponse);

    if not fEmptyStr(objToken.Token) Then
      FreeAndNil(LAuth);
  end;

end;

constructor TComunica.New(const AUrl, AGetPost, AJson: String; AIgnoreToken: Boolean; ANumPok, AEmpHub: String);
begin
  FURL     := AUrl;
  FGetPost := AGetPost;
  FJSON    := AJson;
  FNumPok  := ANumPok;
  FEmpHub  := AEmpHub;
  FIgnoreToken := AIgnoreToken;
end;

function TComunica.ValidouToken : Boolean;
begin

  Result := True;

  If FIgnoreToken Then
    Exit;

  If objToken.ConfiguraToken(FEmpHub) Then
    Exit;

  Result := False;

end;

initialization
  GLog     := TStringList.Create;
  objToken := TToken.New(VS_strCodEmp);

finalization
  FreeAndNil(GLog);
  FreeAndNil(objToken);

end.


