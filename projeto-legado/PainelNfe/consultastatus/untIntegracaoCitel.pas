unit untIntegracaoCitel;

interface

uses
  Forms,
  SysUtils,
  Windows,
  Classes,
  ActiveX,
  Variants,
  StrUtils,
  DateUtils,
  EncdDecd,
  untInterfaces,
  untConfigNFE,
  DB,
  Math,
  untInterfacesConhecimentoEletronico,
  untConhecimentoEletronico

  {$IF Defined(UNIDAC)}
    , Uni, UniSQLMonitor, MemDS, DBAccess, JSON
    {$IFNDEF VER270}
    , NetEncoding
    {$ENDIF}
  {$ELSE}
    , ZConnection, ZDataset
  {$IFEND}
  , untRegistrarTarefa;

  procedure pSetaConfiguracoes(objCfgNFE: TConfiguracoesNFE); stdcall; External 'libNfe.dll';
  function fCriarFonteDadosBD(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}; strNumDoc, strEspDoc,
           strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall; External 'libNfe.dll';
  function fCriarFonteDadosEmitenteBD(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}; strNumDoc, strEspDoc,
           strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall; External 'libNfe.dll';
  function fCriarNFEService(fonteDados: IFonteDados): INFEService; stdcall; External 'libNfe.dll';

  function fCriarConhecimentoEletronicoService(fonteDados: IFonteDadosConhecimento; fonteDadosBD: IFonteDados): IConhecimentoEletronicoService; stdcall; External 'libNfe.dll';
  function fCriarFonteDadosConhecimento(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): IFonteDadosConhecimento; stdcall; External 'libNfe.dll';

  type
    TMetodo = (mGet, mPost, mDelete);
    TTipDfe = (CCe, CTe, NFe, NFCe, NFSe, CTeCancelamento, NFeCancelamento, NFCeCancelamento, NFSeCancelamento);

  type
    TWSNfeCitelRetorno = class(TInterfacedObject, IInterface)
  private
    FRetornoOk: Boolean;
    FTexto: String;
  public
    constructor Create(ARetornoOk: Boolean; ATexto: String);
    function RetornoOk: Boolean;
    function Texto: String;
  end;

  type
    TRetornoIntegracaoCitel = class
  private
    FCodigo: String;
    FMensagem: String;
  public
    property strCodigo: String    read FCodigo     write FCodigo;
    property strMensagem: String  read FMensagem   write FMensagem;
  end;

type
  TNfeApiWS = class
  private
    FlibApiClient: Cardinal;

    fExecuteAuth:       function(AMetodo, AUrl, AJsonEnvio, AToken, AContentType: WideString; ABytes: TBytes; out AJsonRetorno: WideString): Integer; stdcall;
    fGetJsonValue:      function(AJsonString, AChave: WideString): WideString; stdcall;
    fGetJsonArrayValue: function(AJsonString, AChaveArr, AChave: WideString; AIndex: Integer): WideString; stdcall;
    fGetToken:          function(ACnpjEmitente: WideString; AChavePublica: TStringList; AUnixTimestamp: Int64): WideString; stdcall;

    function fRetornaUnixTimestamp: Int64;
    function fParseResponse(const AMetodo: TMetodo; const AStatus: Integer; AJson: WideString): TRetornoIntegracaoCitel;
  public
    constructor Create;
    destructor Destroy; override;
    function NfeEnviaRecebeDados(AUrl, ACnpjEmitente: WideString; AChavePublica: TStringList; AMetodo: TMetodo; AComando, AJson, AContentType: WideString; ABytes: TBytes; var ARetorno: String): TRetornoIntegracaoCitel;
  end;

  Type
    TIntegracaoCitel = class
  private
    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FTarefa: TRegistrarTarefa;

    WSCitel: TNfeApiWS;

    confignfe: TConfiguracoesNFE;

    FJson: String;
    FStatus: String;
    FArquivo: String;

    pSetaConfiguracoesBD: procedure(objCfgNFE: TConfiguracoesNFE); stdcall;
    fCriarFonteDadosBDSet: function(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND};
                                    ANumDoc, AEspDoc, ACodEmp, ACodCli, ASerie, ATip_FC: String): IFonteDados; stdcall;

    procedure pCarregaConfigNFE(ACodigoEmpresa: String);
    procedure pCarregarDll;

    function fRemoverCaracteresInvalidosXML(const AValue: String): String;
    function fDataHora(const dta: TDateTime): String;
    function fRemoveZerosEsquerda(strValor: String): String;
    function fLimpaCaracteresInvalidos(strTexto: String): String;
    function fFormataCampo(strValor: String): String;
    function fNumerico(fltValor: Double; intDecimais: Integer): String;
    function fRetornaCnpjEmitente(ACodigoEmpresa: String): String;
    function fBase64Decodifica(ATexto: String): String;
    function fBytesOf(const Val: AnsiString): TBytes;

    function fComunicaWebService(AMetodo: TMetodo; AComando, AJson, AContentType: String; ABytes: TBytes): TWSNfeCitelRetorno;
    function fComunicaWebServiceInterna(AMetodo: TMetodo; AComando, AJson, AContentType: String; ABytes: TBytes): TWSNfeCitelRetorno;

    procedure pPreparaNFe(AAutInc, AOrigem: String; AJson: TStringList);
    procedure pPreparaNFSe(AAutInc: String; AJson: TStringList);
    procedure pPreparaNFCe(AAutInc: String; AJson: TStringList);
    procedure pPreparaCTe(AAutInc: String; AJson: TStringList);

    function fRetornaMotivoCancelamento(AAutInc: String): String;

    function fEnviarDFe(ATipDFe: TTipDfe; AAutInc, AOrigem: String; var AMensagemApi: String): Boolean;
    function fEnviarDFeXml(ATipDFe: TTipDfe; AChaveAcesso, ADocumento, ASerie: String; var AMensagemApi: String): Boolean;
    function fEnviarDFePdf(ATipDFe: TTipDfe; AChaveAcesso, ADocumento, ASerie: String; var AMensagemApi: String): Boolean;

    function fGerarDFeXml(ATipDFe: TTipDfe; AChaveAcesso: String; var AMensagem: String): Boolean;
    function fGerarDFePdf(ATipDFe: TTipDfe; AChaveAcesso: String; var AMensagem: String): Boolean;

    function fEnviarDFeCancelamento(ATipDFe: TTipDfe; AAutInc, AChaveAcesso, ADocumento, ASerie: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
    function fEnviarDFeCancelamentoXml(ATipDfe: TTipDfe; AAutInc, AChaveAcesso, ADocumento, ASerie: String; var AMensagemApi: String): Boolean;
    function fEnviarCartaDeCorrecao(AAutInc, AChaveAcesso, AProtocolo: String; var AMensagemApi: String): Boolean;
    function fEnviarCartaDeCorrecaoXml(AChaveAcesso, AProtocolo: String; var AMensagemApi: String): Boolean;

    function fPostDFe(ATipDFe: TTipDfe; AJson: String): TWSNfeCitelRetorno;
    function fPostDFeXml(ATipDFe: TTipDfe; AChaveAcesso, ADocumento, ASerie: String; ABytes: TBytes): TWSNfeCitelRetorno;
    function fPostDFePdf(ATipDFe: TTipDfe; AChaveAcesso, ADocumento, ASerie: String; ABytes: TBytes): TWSNfeCitelRetorno;
    function fPostDFeCancelamento(ATipDFe: TTipDfe; AJson: String): TWSNfeCitelRetorno;

    procedure pPreparaNFeXml(AChaveAcesso: String; var ABytes: TBytes);
    procedure pPreparaNFePdf(AChaveAcesso: String; var ABytes: TBytes);
    procedure pPreparaDFeXml(ATipDfe: TTipDfe; AChaveAcesso, AProtocolo: String; var ABytes: TBytes);

    function fProcessaNFe(ATipInt, AAutInc, AChaveAcesso, ADocumento, ASerie, AProtocolo, AOrigem: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
    function fProcessaNFCe(ATipInt, AAutInc, AChaveAcesso, ADocumento, ASerie: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
    function fProcessaNFSe(ATipInt, AAutInc, AChaveAcesso, ADocumento, ASerie: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
    function fProcessaCTe(ATipInt, AAutInc, ADocumento, ASerie: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
    function fRetornaChaveAcessoCTe(AAutInc: String): String;
    function fExisteDocumentoPainelCitel(ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, ATipInt: String): Boolean;
    procedure pGravaDocumentoPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, ATipInt, AStatus: String);
    function fRetornaTipoIntegracao(AEspDoc: String): String;
    procedure pAnaliseErroPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, ATipInt, AMensagemApi: String);
    procedure pGravaJson(ASeqFis, ATipInt, AProtoc, AJson: String);
    procedure pGerarXmlCitel(AChaveAcesso: String);
    function fSQLQuantidadeLimite: String;
    {$IF Defined(UNIDAC)}
    procedure pDownloadConhecimentosDeTerceiros;
    procedure pDownloadNotasDeTerceiros;
    function fRetornaListagemNSU(ATipDFe: TTipDfe; ARetornoNSU: String): TJSONArray;
    function fRetornaUltimoNSU(ATipDFe: TTipDfe): String;
    function fRetornaNSU(ATipDFe: TTipDfe; AUltimoNSU:String): TWSNfeCitelRetorno;
    function fRetornaDocumentoDeTerceiros(ATipDFe: TTipDfe; AChaveAcesso:String): TWSNfeCitelRetorno;
    procedure pAtualizaUltimoNSU(ATipDFe: TTipDfe; AUltimoNSU:String);
    {$IFEND}
    function fRetornaCnpjClienteFilial: String;
    function fEhDocumentoClienteFilial(ANumeroCNPJ, ACnpjClienteFilial: String): Boolean;
    function fRetornaOrigem(ADataSet: TDataSet): String;
    procedure pFreeAndNil(AObject: TObject);
    procedure ProcessaDocumentos;
  public
    constructor Create(ATarefa: TRegistrarTarefa);
    destructor Destroy; override;
    procedure Executar;

    property strStatus: String  read FStatus write FStatus;
  end;

implementation

uses untUtil, untLibNfe, untModulo, untLogDanfe, untDicSis;

{ TWSNfeCitelRetorno }

constructor TWSNfeCitelRetorno.Create(ARetornoOk: Boolean; ATexto: String);
begin
  FRetornoOk := ARetornoOk;
  FTexto := ATexto;
end;

function TWSNfeCitelRetorno.RetornoOk: Boolean;
begin
  Result := FRetornoOk;
end;

function TWSNfeCitelRetorno.Texto: String;
begin
  Result := FTexto;
end;

{TNfeApiWS}

constructor TNfeApiWS.Create;
Var
  strMsg: String;
  resultValidacao: TResultadoValidacao;
begin
  objLogDanfe.AddLog('TNfeApiWS.Create');

  FlibApiClient := LoadLibrary(PChar('api.client.dll'));

  If FlibApiClient = 0 Then
  Begin
    strMsg := 'Biblioteca "api.client.dll" não encontrada!';
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    objLogDanfe.AddLog(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  @fExecuteAuth       := GetProcAddress(FlibApiClient, PChar('ExecuteAuth'));
  @fGetJsonValue      := GetProcAddress(FlibApiClient, PChar('GetJsonValue'));
  @fGetJsonArrayValue := GetProcAddress(FlibApiClient, PChar('GetJsonArrayValue'));
  @fGetToken          := GetProcAddress(FlibApiClient, PChar('GetToken'));

end;

destructor TNfeApiWS.Destroy;
begin
  objLogDanfe.AddLog('TNfeApiWS.Destroy');
  If (FlibApiClient <> 0) Then
  Begin
    FreeLibrary(FlibApiClient);
    FlibApiClient := 0;
  End;

  inherited;
end;

function TNfeApiWS.fRetornaUnixTimestamp: Int64;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT ROUND(UNIX_TIMESTAMP(CURTIME(4)) * 1000) AS TIMESTAMP ');
    qryAux.Open;

   {$IF Defined(VER250) Or Defined(UNIDAC)}
    Result := qryAux.FieldByName('TIMESTAMP').AsLargeInt;
   {$ELSE}
    Result := qryAux.FieldByName('TIMESTAMP').Value;
   {$IFEND}    
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TNfeApiWS.NfeEnviaRecebeDados(AUrl, ACnpjEmitente: WideString; AChavePublica: TStringList; AMetodo: TMetodo; AComando, AJson, AContentType: WideString; ABytes: TBytes; var ARetorno: String): TRetornoIntegracaoCitel;
var
  LStatus: Integer;
  LToken: WideString;
  LMetodo: WideString;
  LResultado: WideString;
  LRetorno: TStringList;
  LUnixTimestamp: Int64;
begin
  objLogDanfe.AddLog('TNfeApiWS.NfeEnviaRecebeDados');

  ARetorno := '';

  Try
    Case AMetodo Of
         mGet: LMetodo := 'GET';
        mPost: LMetodo := 'POST';
      mDelete: LMetodo := 'DELETE';
    End;

    objLogDanfe.AddLog('LMetodo = ' + LMetodo);
    objLogDanfe.AddLog('AUrl = ' + AUrl);
    objLogDanfe.AddLog('ACnpjEmitente = ' + ACnpjEmitente);
    objLogDanfe.AddLog('AChavePublica = ' + AChavePublica.Text);
    objLogDanfe.AddLog('AComando = ' + AComando);
    objLogDanfe.AddLog('AContentType = ' + AContentType);

    LUnixTimestamp := fRetornaUnixTimestamp;

    LToken := fGetToken(ACnpjEmitente, AChavePublica, LUnixTimestamp);

    objLogDanfe.AddLog('LToken = ' + LToken);

    LStatus := fExecuteAuth(LMetodo, AUrl + AComando, AJson, LToken, AContentType, ABytes, LResultado);

    objLogDanfe.AddLog('LStatus = ' + IntToStr(LStatus));

    LRetorno := TStringList.Create;
    Try
      LRetorno.Add(LResultado);
      Try
        objLogDanfe.AddLog('LRetorno.SaveToFile > ULTIMO_RETORNO_PAINEL_CITEL.TXT');
        objLogDanfe.AddLog(LRetorno.Text);
        LRetorno.SaveToFile(fPnlDir('ULTIMO_RETORNO_PAINEL_CITEL.TXT'));
      Except

      End;
    Finally
      FreeAndNil(LRetorno);
    End;

    If (AMetodo = mGet) Then
      ARetorno := LResultado;

    Result := fParseResponse(AMetodo, LStatus, LResultado);
  Except
    On E: Exception Do
    Begin
      objLogDanfe.AddLog(E.Message);
      Raise ErrosValidacaoNFE.fCriaErroSimples(E.Message);
    End;
  End;
end;

function TNfeApiWS.fParseResponse(const AMetodo: TMetodo; const AStatus: Integer; AJson: WideString): TRetornoIntegracaoCitel;
begin
  Result := TRetornoIntegracaoCitel.Create();

  Result.strCodigo   := IntToStr(AStatus);
  Result.strMensagem := '';

  If (AMetodo = mGet) Then
    Exit;

  If (AStatus = 200) Then
  Begin
    Result.strMensagem := fGetJsonValue(AJson, 'status');
  End
  Else
  Begin
    Result.strMensagem := fGetJsonValue(AJson, 'message');

    If fEmptyStr(Result.strMensagem) Then
      Result.strMensagem := fGetJsonValue(AJson, 'error');

    If fEmptyStr(Result.strMensagem) Then
      Result.strMensagem := AJson;
  End;
end;

{ TIntegracaoCitel }

constructor TIntegracaoCitel.Create(ATarefa: TRegistrarTarefa);
begin
  inherited Create;
  FTarefa := ATarefa;
  Banco   := frmModulo.Database;
  WSCitel := TNfeApiWS.Create;

  {$IFDEF UNIDAC}
  If fExisteConfiguracao('PWCLOG', Banco, VS_strCodEmp) Then
  Begin
    If fCfgSis('PWCLOG', varBoolean, VS_strCodEmp) Then
    Begin
      objLogDanfe.objConexao := Banco;
      objLogDanfe.strNumDoc := '...';
      objLogDanfe.strEspDoc := '...';
      objLogDanfe.strCodEmp := VS_strCodEmp;
      objLogDanfe.strSerie_ := '...';
      objLogDanfe.strCodCli := '...';
    End;
  End;
  {$ENDIF}
end;

destructor TIntegracaoCitel.Destroy;
begin
  FreeAndNil(WSCitel);

  If Assigned(confignfe) Then
    FreeAndNil(confignfe);

  inherited;
end;

function TIntegracaoCitel.fDataHora(const dta: TDateTime): String;
begin
  Result := 'null';

  If not (dta = 0) Then
    Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', dta);
end;

function TIntegracaoCitel.fRemoveZerosEsquerda(strValor: String): String;
var
  intContador: Integer;
begin
  Result := strValor;

  for intContador := 1 to Length(strValor) do
  begin
    if not (strValor[intContador] = '0') then
    begin
      Result := Copy(strValor, intContador, Length(strValor));
      Break;
    end;
  end;
end;

function TIntegracaoCitel.fLimpaCaracteresInvalidos(strTexto: String): String;
begin
  Result := strTexto;

  Result := AnsiReplaceStr(Result, '"', '');

  Result := AnsiReplaceStr(Result, '''', '');
end;

function TIntegracaoCitel.fFormataCampo(strValor: String): String;
begin
  if not fEmptyStr(strValor) Then
    Result := '"'+ fLimpaCaracteresInvalidos(strValor) +'"'
  else
    Result := 'null';
end;

function TIntegracaoCitel.fNumerico(fltValor: Double; intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, 12, intDecimais);
  Result := AnsiReplaceStr(Result, '.', '');
  Result := AnsiReplaceStr(Result, ',', '.');
end;

function TIntegracaoCitel.fRetornaCnpjEmitente(ACodigoEmpresa: String): String;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT EMP_C_G_C_ FROM CADEMP ');
    qryAux.SQL.Add('WHERE EMP_CODEMP = :CODEMP ');

    qryAux.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryAux.Open;

    Result := fTiraCaracEspeciais(qryAux.FieldByName('EMP_C_G_C_').AsString, True, True, True); // '30560616000188';
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TIntegracaoCitel.fBase64Decodifica(ATexto: String): String;
var
  LEntrada:  TStringStream;
  LSaida: TStringStream;
begin
  LEntrada := TStringStream.Create(ATexto);
  LSaida   := TStringStream.Create(EmptyStr);

  Try
    EncdDecd.DecodeStream(LEntrada, LSaida);
    Result := LSaida.DataString;
  Finally
    FreeAndNil(LEntrada);
    FreeAndNil(LSaida);
  End;
end;

function TIntegracaoCitel.fBytesOf(const Val: AnsiString): TBytes;
var
  Len: Integer;
begin
  Len := Length(Val);
  SetLength(Result, Len);
  Move(Val[1], Result[0], Len);
end;

function TIntegracaoCitel.fComunicaWebService(AMetodo: TMetodo; AComando, AJson, AContentType: String; ABytes: TBytes): TWSNfeCitelRetorno;
Var
  LMsg: String;
  LResultValidacao: TResultadoValidacao;
begin
  Try
    Result := fComunicaWebServiceInterna(AMetodo, AComando, AJson, AContentType, ABytes);
  Except
    On E: Exception Do
    Begin
      LMsg := E.Message;
      LResultValidacao := TResultadoValidacao.Create;
      LResultValidacao.pAdicionarErro(LMsg, Nil);
      objLogDanfe.AddLog(LMsg);
      Raise ErrosValidacaoNFE.Create(LMsg, LResultValidacao);
    End;
  End;
end;

function TIntegracaoCitel.fComunicaWebServiceInterna(AMetodo: TMetodo; AComando, AJson, AContentType: String; ABytes: TBytes): TWSNfeCitelRetorno;
Var
  LRetorno: String;
  LUrl: String;
  LCnpjEmitente: String;
  LChavePublica: TStringList;
  LRetornoCitel: TRetornoIntegracaoCitel;
  LMsg: String;
  LResultValidacao: TResultadoValidacao;
  LPubKey: String;
begin
  objLogDanfe.AddLog('TIntegracaoCitel.fComunicaWebServiceInterna');
  objLogDanfe.AddLog('AComando = ' + AComando);
  objLogDanfe.AddLog('AJson = ' + AJson);
  objLogDanfe.AddLog('AContentType = ' + AContentType);
  objLogDanfe.AddLog('AComando = ' + AComando);
  Try
    Try
      LUrl               := fRetornaURLPainelCitel(VS_strCodEmp);
      FJson              := fTiraCaracEspeciais(AJson, False);
      LPubKey            := fCfgSis('PUBKEY', varString, VS_strCodEmp);
      LCnpjEmitente      := fRetornaCnpjEmitente(VS_strCodEmp);
      LChavePublica      := TStringList.Create;

      LChavePublica.Text := '-----BEGIN PUBLIC KEY-----'+#13 + LPubKey + #13+'-----END PUBLIC KEY-----';

      LRetornoCitel := WSCitel.NfeEnviaRecebeDados(LUrl, LCnpjEmitente, LChavePublica, AMetodo, AComando, FJson, AContentType, ABytes, FArquivo);

      LRetorno := LRetornoCitel.strCodigo+'|'+LRetornoCitel.strMensagem;

      objLogDanfe.AddLog('LRetorno = ' + LRetorno);

      Result := TWSNfeCitelRetorno.Create(True, LRetorno);

    Finally
      FreeAndNil(LChavePublica);
    End;

  Except
    On E: Exception Do
    Begin
      LMsg := E.Message;
      objLogDanfe.AddLog(LMsg);
      LResultValidacao := TResultadoValidacao.Create;
      LResultValidacao.pAdicionarErro(LMsg, Nil);
      Raise ErrosValidacaoNFE.Create(LMsg, LResultValidacao);
    End;
  End;
end;

procedure TIntegracaoCitel.pCarregaConfigNFE(ACodigoEmpresa: String);
begin
  confignfe := TConfiguracoesNFE.Create;
  confignfe.strCodEmp := ACodigoEmpresa;
  confignfe.strEmpLog := VS_strCodEmp;
  confignfe.blnSimPau := fCfgSis('SIMPAU', varBoolean, ACodigoEmpresa);
  confignfe.strClaSub := fCfgSis('CLASUB', varString,  ACodigoEmpresa);
  confignfe.blnNFEFab := fCfgSis('NFEFAB', varBoolean, ACodigoEmpresa);
  confignfe.blnNFEMar := fCfgSis('NFEMAR', varBoolean, ACodigoEmpresa);
  confignfe.blnNFELoc := fCfgSis('NFELOC', varBoolean, ACodigoEmpresa);
  confignfe.blnNfeMFi := fCfgSis('NFEMFI', varBoolean, ACodigoEmpresa);
  confignfe.blnVendad := fCfgSis('VENDAD', varBoolean, ACodigoEmpresa);
  confignfe.strNfeEmp := fCfgSis('NFEEMP', varString,  ACodigoEmpresa);
  confignfe.blnNfeDse := fCfgSis('NFEDSE', varBoolean, ACodigoEmpresa);
  confignfe.blnHomolo := fCfgSis('HOMOLO', varBoolean, ACodigoEmpresa);
  confignfe.blnCclNfe := fCfgSis('CCLNFE', varBoolean, ACodigoEmpresa);
  confignfe.strNfeIte := fCfgSis('NFEITE', varString,  ACodigoEmpresa);
  confignfe.strPatOph := fCfgSis('NFEPAT', varString,  ACodigoEmpresa);
  confignfe.strIteSer := fCfgSis('ITESER', varString,  ACodigoEmpresa);
  confignfe.blnUsaSer := fCfgSis('USASER', varBoolean, ACodigoEmpresa);
  confignfe.blnCdpNfe := fCfgSis('CDPNFE', varBoolean, ACodigoEmpresa);
  confignfe.blnOrgDfi := fCfgSis('ORGDFI', varBoolean, ACodigoEmpresa);
  confignfe.strEndPrc := fCfgSis('ENDPRC', varString,  ACodigoEmpresa);
  confignfe.strTelPrc := fCfgSis('TELPRC', varString,  ACodigoEmpresa);
  confignfe.strEndAle := fCfgSis('ENDALE', varString,  ACodigoEmpresa);
  confignfe.strTelAle := fCfgSis('TELALE', varString,  ACodigoEmpresa);
  If (fCfgSis('CLIPRO', varString,  ACodigoEmpresa) = 'S') Then
    confignfe.strCliPro := 'S'
  Else
    confignfe.strCliPro := 'N';
  confignfe.blnConIpi := fCfgSis('CONIPI', varBoolean, ACodigoEmpresa);
  confignfe.blnRIcmPr := fCfgSis('RICMPR', varBoolean, ACodigoEmpresa);
  confignfe.strClaVen := fTransform(fCfgSis('CLAVEN', varString, ACodigoEmpresa), 4);
  confignfe.strClaDev := fTransform(fCfgSis('CLADEV', varString, ACodigoEmpresa), 4);

  If (fExisteConfiguracao('EMATRA', Banco, ACodigoEmpresa)) Then
    confignfe.strEmaTra := fCfgSis('EMATRA', varString, ACodigoEmpresa)
  Else
    confignfe.strEmaTra := 'N';

  confignfe.strImpPag := fCfgSis('IMPPAG', varString,  ACodigoEmpresa);
  confignfe.blnInfGar := fCfgSis('IMPGAR', varBoolean, ACodigoEmpresa);
  confignfe.strClaCif := fTransform(fCfgSis('CLACIF', varString, ACodigoEmpresa), 3);
  confignfe.blnImpCif := fCfgSis('IMPCIF', varBoolean, ACodigoEmpresa);
  confignfe.strPCitel := 'S';
end;

procedure TIntegracaoCitel.pCarregarDll;
begin
  If handleBD <> 0 Then
    Exit;

  handleBD := LoadLibrary(PChar('libNfeBD.dll'));

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD := GetProcAddress(handleBD, PAnsiChar('pSetaConfiguracoesBD'));

  If (handleBD = 0) Then
    fCriarFonteDadosBDSet := fCriarFonteDadosBD
  Else
    fCriarFonteDadosBDSet := GetProcAddress(handleBD, PAnsiChar('fCriarFonteDadosBD'));
end;

function TIntegracaoCitel.fRemoverCaracteresInvalidosXML(const AValue: String): String;
begin
  Result := AValue;

  If (StartsStr('"', Result)) And (EndsStr('"', Result)) Then
  Begin
    Result := Copy(Result, 2, Length(Result));
    Result := Copy(Result, 1, Pred(Length(Result)));
  End;

  Result := AnsiReplaceStr(Result, '\', '');
end;

{***************************}
{* Nota Fiscal de Produtos *}
{*********************** BZ*}
procedure TIntegracaoCitel.pPreparaNfe(AAutInc, AOrigem: String; AJson: TStringList);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;

  fonteDados: IFonteDados;
  service: INFEService;
  dadosItem: TDadosItem;

  function fPessoa(ACnpj: String):String;
  begin
    Result := IIF(Length(ACnpj) <= 11, 'F', 'J');
  end;
begin
  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT * FROM CADFIS ';
    LSQL := LSQL + 'LEFT JOIN LOGNFE ON LOGNFE.NFE_NUMDOC = FIS_NUMDOC AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_ESPDOC = FIS_ESPDOC AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_CODEMP = FIS_CODEMP AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_CODCLI = FIS_FORCLI AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_TIP_FC = FIS_TIP_FC AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_SERIE_ = FIS_SERIE_ ';
    LSQL := LSQL + 'WHERE AUTOINCREM = :AUTINC';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('AUTINC').AsString := AAutInc;
    qryAux.Open;

    pCarregaConfigNFE(VS_strCodEmp);

    pCarregarDll;

    pSetaConfiguracoes(confignfe);

    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(confignfe);

    fonteDados := fCriarFonteDadosBDSet(Banco,
                                        qryAux.FieldByName('FIS_NUMDOC').AsString,
                                        qryAux.FieldByName('FIS_ESPDOC').AsString,
                                        qryAux.FieldByName('FIS_CODEMP').AsString,
                                        qryAux.FieldByName('FIS_FORCLI').AsString,
                                        qryAux.FieldByName('FIS_SERIE_').AsString,
                                        qryAux.FieldByName('FIS_TIP_FC').AsString);

    fonteDados.pSetaIndicadorIntegracaoCitel;

    service := fCriarNFEService(fonteDados);

    fonteDados.pCarregarDados;

    fonteDados.pInicio;

    AJson.Add('{ ');
    AJson.Add('  "id": 0, ');
    AJson.Add('  "accessKey": '+fFormataCampo(qryAux.FieldByName('FIS_ACESSO').AsString)+', ');
    AJson.Add('  "documentNumber": '+fRemoveZerosEsquerda(qryAux.FieldByName('FIS_NUMDOC').AsString)+', ');
    AJson.Add('  "documentSeries": '+fFormataCampo(qryAux.FieldByName('FIS_SERIE_').AsString)+', ');
    AJson.Add('  "documentStatus": "Autorizada", ');
    AJson.Add('  "statusReason": null, ');
    AJson.Add('  "emissionDate": "'+fDataHora(fonteDados.fDadosGerais.dtaDtaEnt)+'", ');
    AJson.Add('  "authorizationDate": "'+fDataHora(qryAux.FieldByName('NFE_DTAAUT').AsDateTime)+'", ');
    AJson.Add('  "totalValue": '+fNumerico(fonteDados.fDadosGerais.fltTotGer, 2)+', ');
    AJson.Add('  "documentOrigin": '+fFormataCampo(AOrigem)+', ');
    AJson.Add('  "items": [ ');

    While fonteDados.fTemDados Do
    Begin
      dadosItem := fonteDados.fProximoItem;

      AJson.Add('    { ');
      AJson.Add('      "cfop": '+fFormataCampo(dadosItem.strClaFis)+', ');
      AJson.Add('      "itemCode": '+fFormataCampo(dadosItem.strCodIte)+', ');
      AJson.Add('      "itemDescription": '+fFormataCampo(dadosItem.strDesIte)+', ');
      AJson.Add('      "ncm": '+fFormataCampo(dadosItem.strClaIpi)+', ');
      AJson.Add('      "itemQuantity": '+fNumerico(dadosItem.fltQtdIte, 4)+', ');
      AJson.Add('      "unity": '+fFormataCampo(dadosItem.strUnidad)+', ');
      AJson.Add('      "unitaryValue": '+fNumerico(dadosItem.fltUnitar, 4)+', ');
      AJson.Add('      "totalValue": '+fNumerico(dadosItem.fltTotIte, 2)+' ');
      AJson.Add('    } ');

      If fonteDados.fTemDados Then
        AJson.Add(',');
    End;

    AJson.Add('  ], ');

    AJson.Add('  "client": { ');
    AJson.Add('    "addressNumber": '+fFormataCampo(fonteDados.fDadosGerais.strNumeroEndEnt)+', ');
    AJson.Add('    "name": '+fFormataCampo(fonteDados.fDadosGerais.strNomCli)+', ');
    AJson.Add('    "email": '+fFormataCampo(fonteDados.fDadosGerais.strEmail)+', ');
    AJson.Add('    "cpf": ' +IIF(fPessoa(fonteDados.fDadosGerais.strCnpj) = 'F', fFormataCampo(fTiraCaracEspeciais(fonteDados.fDadosGerais.strCnpj)), 'null')+', ');
    AJson.Add('    "cnpj": '+IIF(fPessoa(fonteDados.fDadosGerais.strCnpj) = 'J', fFormataCampo(fTiraCaracEspeciais(fonteDados.fDadosGerais.strCnpj)), 'null')+', ');
    AJson.Add('    "uf": '+fFormataCampo(fonteDados.fDadosGerais.strEstado)+', ');
    AJson.Add('    "address": '+fFormataCampo(fonteDados.fDadosGerais.strLogradouroEndEnt)+', ');
    AJson.Add('    "zipCode": '+fFormataCampo(fonteDados.fDadosGerais.strCEPEndEnt)+', ');
    AJson.Add('    "city": '+fFormataCampo(fonteDados.fDadosGerais.strNomeCidade)+', ');
    AJson.Add('    "district": null, ');
    AJson.Add('    "complement": '+fFormataCampo(fonteDados.fDadosGerais.strComplementoEndEnt));
    AJson.Add('  } ');
    AJson.Add('} ');

  Finally
    FreeAndNil(qryAux);
  End;
end;

{***************************}
{* Nota Fiscal de Serviços *}
{*********************** BZ*}
procedure TIntegracaoCitel.pPreparaNFSe(AAutInc: String; AJson: TStringList);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LNumeroRPS: String;
  LNumeroDOC: String;

  fonteDados: IFonteDados;
  service: INFEService;
  dadosItem: TDadosItem;

  function fPessoa(ACnpj: String):String;
  begin
    Result := IIF(Length(ACnpj) <= 11, 'F', 'J');
  end;
begin
  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT * FROM CADFIS ';
    LSQL := LSQL + 'INNER JOIN LOGNFE ON LOGNFE.NFE_NUMDOC = FIS_NUMDOC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_ESPDOC = FIS_ESPDOC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_CODEMP = FIS_CODEMP AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_CODCLI = FIS_FORCLI AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_TIP_FC = FIS_TIP_FC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_SERIE_ = FIS_SERIE_ ';
    LSQL := LSQL + 'WHERE AUTOINCREM = :AUTINC';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('AUTINC').AsString := AAutInc;
    qryAux.Open;

    pCarregaConfigNFE(VS_strCodEmp);

    pCarregarDll;

    pSetaConfiguracoes(confignfe);

    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(confignfe);

    fonteDados := fCriarFonteDadosBDSet(Banco,
                                        qryAux.FieldByName('FIS_NUMDOC').AsString,
                                        qryAux.FieldByName('FIS_ESPDOC').AsString,
                                        qryAux.FieldByName('FIS_CODEMP').AsString,
                                        qryAux.FieldByName('FIS_FORCLI').AsString,
                                        qryAux.FieldByName('FIS_SERIE_').AsString,
                                        qryAux.FieldByName('FIS_TIP_FC').AsString);

    fonteDados.pSetaIndicadorIntegracaoCitel;

    service := fCriarNFEService(fonteDados);

    fonteDados.pCarregarDados;

    fonteDados.pInicio;

    LNumeroRPS := fRemoveZerosEsquerda(qryAux.FieldByName('FIS_NUMDOC').AsString);
    LNumeroDOC := fRemoveZerosEsquerda(qryAux.FieldByName('FIS_NUMDOC').AsString);

    If fTabelaExiste('SUBNFS', Banco) Then
    Begin
      LNumeroRPS := fCampoTabela('SUB_NUMRPS', 'SUBNFS', ['SUB_SEQGER'], [AAutInc], Banco);
    End;

    AJson.Add('{ ');
    AJson.Add('  "id": 0, ');
    AJson.Add('  "documentNumber": '+LNumeroDOC+', ');
    AJson.Add('  "rpsNumber": '+ IIF(fEmptyStr(LNumeroRPS), LNumeroDOC, LNumeroRPS) +', ');
    AJson.Add('  "documentSeries": '+fFormataCampo(qryAux.FieldByName('FIS_SERIE_').AsString)+', ');
    AJson.Add('  "documentStatus": "Autorizada", ');
    AJson.Add('  "statusReason": null, ');
    AJson.Add('  "emissionDate": "'+fDataHora(fonteDados.fDadosGerais.dtaDtaEnt)+'", ');
    AJson.Add('  "authorizationDate": "'+fDataHora(qryAux.FieldByName('NFE_DTAAUT').AsDateTime)+'", ');
    AJson.Add('  "totalValue": '+fNumerico(fonteDados.fDadosGerais.fltTotSer, 2)+', ');

    If fonteDados.fTemDados Then
    Begin
      dadosItem := fonteDados.fProximoItem;

      AJson.Add('  "service": { ');
      AJson.Add('    "description": '+fFormataCampo(dadosItem.strDesIte)+', ');
      AJson.Add('    "aliquotIss": '+ fNumerico(fonteDados.fDadosGerais.fltPerIss,2) +',');
      AJson.Add('    "issWithheldSource": '+IIF(fonteDados.fDadosGerais.strRetIss = 'S', 'true','false')+',');
      AJson.Add('    "codeMunicipalService": '+fFormataCampo(dadosItem.strTriMun)+', ');
      AJson.Add('    "itemServiceListLC116": '+fFormataCampo(dadosItem.strCodSLC)+', ');
      AJson.Add('    "cnae": '+fFormataCampo(dadosItem.strCnaeFiscal)+', ');
      AJson.Add('    "municipalityProvisionService": null ');
      AJson.Add('  }, ');
    End;

    AJson.Add('  "client": { ');
    AJson.Add('    "addressNumber": '+fFormataCampo(fonteDados.fDadosGerais.strNumeroEndEnt)+', ');
    AJson.Add('    "name": '+fFormataCampo(fonteDados.fDadosGerais.strNomCli)+', ');
    AJson.Add('    "email": '+fFormataCampo(fonteDados.fDadosGerais.strEmail)+', ');
    AJson.Add('    "cpf": ' +IIF(fPessoa(fonteDados.fDadosGerais.strCnpj) = 'F', fFormataCampo(fTiraCaracEspeciais(fonteDados.fDadosGerais.strCnpj)), 'null')+', ');
    AJson.Add('    "cnpj": '+IIF(fPessoa(fonteDados.fDadosGerais.strCnpj) = 'J', fFormataCampo(fTiraCaracEspeciais(fonteDados.fDadosGerais.strCnpj)), 'null')+', ');
    AJson.Add('    "uf": '+fFormataCampo(fonteDados.fDadosGerais.strEstado)+', ');
    AJson.Add('    "address": '+fFormataCampo(fonteDados.fDadosGerais.strLogradouroEndEnt)+', ');
    AJson.Add('    "zipCode": '+fFormataCampo(fonteDados.fDadosGerais.strCEPEndEnt)+', ');
    AJson.Add('    "city": '+fFormataCampo(fonteDados.fDadosGerais.strNomeCidade)+', ');
    AJson.Add('    "district": null, ');
    AJson.Add('    "complement": '+fFormataCampo(fonteDados.fDadosGerais.strComplementoEndEnt));
    AJson.Add('  } ');
    AJson.Add('} ');

  Finally
    FreeAndNil(qryAux);
  End;
end;

{*****************************}
{* Nota Fiscal de Consumidor *}
{************************* BZ*}
procedure TIntegracaoCitel.pPreparaNFCe(AAutInc: String; AJson: TStringList);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;

  fonteDados: IFonteDados;
  service: INFEService;
  dadosItem: TDadosItem;

  function fPessoa(ACnpj: String):String;
  begin
    Result := IIF(Length(ACnpj) <= 11, 'F', 'J');
  end;
begin
  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT * FROM CADFIS ';
    LSQL := LSQL + 'INNER JOIN LOGNFE ON LOGNFE.NFE_NUMDOC = FIS_NUMDOC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_ESPDOC = FIS_ESPDOC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_CODEMP = FIS_CODEMP AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_CODCLI = FIS_FORCLI AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_TIP_FC = FIS_TIP_FC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_SERIE_ = FIS_SERIE_ ';
    LSQL := LSQL + 'WHERE AUTOINCREM = :AUTINC';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('AUTINC').AsString := AAutInc;
    qryAux.Open;

    pCarregaConfigNFE(VS_strCodEmp);

    pCarregarDll;

    pSetaConfiguracoes(confignfe);

    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(confignfe);

    fonteDados := fCriarFonteDadosBDSet(Banco,
                                        qryAux.FieldByName('FIS_NUMDOC').AsString,
                                        qryAux.FieldByName('FIS_ESPDOC').AsString,
                                        qryAux.FieldByName('FIS_CODEMP').AsString,
                                        qryAux.FieldByName('FIS_FORCLI').AsString,
                                        qryAux.FieldByName('FIS_SERIE_').AsString,
                                        qryAux.FieldByName('FIS_TIP_FC').AsString);

    fonteDados.pSetaIndicadorIntegracaoCitel;

    service := fCriarNFEService(fonteDados);

    fonteDados.pCarregarDados;

    fonteDados.pInicio;

    AJson.Add('{ ');
    AJson.Add('  "id": 0, ');
    AJson.Add('  "accessKey": '+fFormataCampo(qryAux.FieldByName('FIS_ACESSO').AsString)+', ');
    AJson.Add('  "documentNumber": '+fRemoveZerosEsquerda(qryAux.FieldByName('FIS_NUMDOC').AsString)+', ');
    AJson.Add('  "documentSeries": '+fFormataCampo(qryAux.FieldByName('FIS_SERIE_').AsString)+', ');
    AJson.Add('  "documentStatus": "Autorizada", ');
    AJson.Add('  "statusReason": null, ');
    AJson.Add('  "emissionDate": "'+fDataHora(fonteDados.fDadosGerais.dtaDtaEnt)+'", ');
    AJson.Add('  "authorizationDate": "'+fDataHora(qryAux.FieldByName('NFE_DTAAUT').AsDateTime)+'", ');
    AJson.Add('  "totalValue": '+fNumerico(fonteDados.fDadosGerais.fltTotGer, 2)+', ');

    AJson.Add('  "items": [ ');

    While fonteDados.fTemDados Do
    Begin
      dadosItem := fonteDados.fProximoItem;

      AJson.Add('    { ');
      AJson.Add('      "cfop": '+fFormataCampo(dadosItem.strClaFis)+', ');
      AJson.Add('      "itemCode": '+fFormataCampo(dadosItem.strCodIte)+', ');
      AJson.Add('      "itemDescription": '+fFormataCampo(dadosItem.strDesIte)+', ');
      AJson.Add('      "ncm": '+fFormataCampo(dadosItem.strClaIpi)+', ');
      AJson.Add('      "itemQuantity": '+fNumerico(dadosItem.fltQtdIte, 4)+', ');
      AJson.Add('      "unity": '+fFormataCampo(dadosItem.strUnidad)+', ');
      AJson.Add('      "unitaryValue": '+fNumerico(dadosItem.fltUnitar, 4)+', ');
      AJson.Add('      "totalValue": '+fNumerico(dadosItem.fltTotIte, 2)+' ');
      AJson.Add('    } ');

      If fonteDados.fTemDados Then
        AJson.Add(',');
    End;

    AJson.Add('  ], ');

    AJson.Add('  "client": { ');
    AJson.Add('    "addressNumber": '+fFormataCampo(fonteDados.fDadosGerais.strNumeroEndEnt)+', ');
    AJson.Add('    "name": '+fFormataCampo(fonteDados.fDadosGerais.strNomCli)+', ');
    AJson.Add('    "email": '+fFormataCampo(fonteDados.fDadosGerais.strEmail)+', ');
    AJson.Add('    "cpf": ' +IIF(fPessoa(fonteDados.fDadosGerais.strCnpj) = 'F', fFormataCampo(fTiraCaracEspeciais(fonteDados.fDadosGerais.strCnpj)), 'null')+', ');
    AJson.Add('    "cnpj": '+IIF(fPessoa(fonteDados.fDadosGerais.strCnpj) = 'J', fFormataCampo(fTiraCaracEspeciais(fonteDados.fDadosGerais.strCnpj)), 'null')+', ');
    AJson.Add('    "uf": '+fFormataCampo(fonteDados.fDadosGerais.strEstado)+', ');
    AJson.Add('    "address": '+fFormataCampo(fonteDados.fDadosGerais.strLogradouroEndEnt)+', ');
    AJson.Add('    "zipCode": '+fFormataCampo(fonteDados.fDadosGerais.strCEPEndEnt)+', ');
    AJson.Add('    "city": '+fFormataCampo(fonteDados.fDadosGerais.strNomeCidade)+', ');
    AJson.Add('    "district": null, ');
    AJson.Add('    "complement": '+fFormataCampo(fonteDados.fDadosGerais.strComplementoEndEnt));
    AJson.Add('  } ');
    AJson.Add('} ');

  Finally
    FreeAndNil(qryAux);
  End;
end;

{*****************************************}
{* Conhecimento de Transporte eletrônico *}
{************************************* BZ*}
procedure TIntegracaoCitel.pPreparaCTe(AAutInc: String; AJson: TStringList);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LIndex: Integer;

  fonteDados: IFonteDadosConhecimento;
  conhecimento: TConhecimentoEletronico;

  function fPessoa(ACnpj: String):String;
  begin
    Result := IIF(Length(ACnpj) <= 11, 'F', 'J');
  end;
begin
  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT ';
    LSQL := LSQL + '  CTE_NUMCTE, CTE_ACESSO, NFE_DTAAUT, CID_ESTADO, CID_NOMCID ';
    LSQL := LSQL + 'FROM MOVCTE ';
    LSQL := LSQL + 'INNER JOIN LOGNFE ON CTE_NUMCTE = NFE_NUMDOC ';
    LSQL := LSQL + '                AND NFE_ESPDOC = "CT" ';
    LSQL := LSQL + '                AND CTE_CODEMP = NFE_CODEMP ';
    LSQL := LSQL + 'INNER JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
    LSQL := LSQL + 'INNER JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
    LSQL := LSQL + 'LEFT  JOIN CADCID ON CLI_CODCID = CID_CODCID ';
    LSQL := LSQL + 'INNER JOIN CADFIS ON GER_NUMDOC = FIS_NUMDOC ';
    LSQL := LSQL + '                 AND GER_ESPDOC = FIS_ESPDOC ';
    LSQL := LSQL + '                 AND GER_SERIE_ = FIS_SERIE_ ';
    LSQL := LSQL + '                 AND GER_CODEMP = FIS_CODEMP ';
    LSQL := LSQL + '                 AND GER_TIP_FC = FIS_TIP_FC ';
    LSQL := LSQL + '                 AND IFNULL(GER_CODCLI, GER_CODFOR) = FIS_FORCLI ';
    LSQL := LSQL + 'WHERE CADFIS.AUTOINCREM = :AUTINC ';

    LSQL := LSQL + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(LSQL, 'MOVGER', 'NOTGER'), 'MOVCTE', 'NOTCTE');

    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('AUTINC').AsString := AAutInc;
    qryAux.Open;

    If (qryAux.RecordCount = 0) Then
      Exit;

    pCarregaConfigNFE(VS_strCodEmp);

    pCarregarDll;

    pSetaConfiguracoes(confignfe);

    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(confignfe);

    fonteDados := fCriarFonteDadosConhecimento(Self.Banco);

    conhecimento := fonteDados.fGetConhecimento(qryAux.FieldByName('CTE_NUMCTE').AsString, True);

    AJson.Add('{ ');
    AJson.Add('  "id": 0, ');
    AJson.Add('  "accessKey": "'+qryAux.FieldByName('CTE_ACESSO').AsString+'", ');
    AJson.Add('  "documentNumber": '+fRemoveZerosEsquerda(conhecimento.strNumeroConhecimento)+', ');
    AJson.Add('  "documentSeries": "'+conhecimento.strSerie+'", ');
    AJson.Add('  "documentStatus": "Autorizada", ');
    AJson.Add('  "statusReason": null, ');
    AJson.Add('  "emissionDate": "'+fDataHora(conhecimento.dtaDataEmissao)+'", ');
    AJson.Add('  "authorizationDate": "'+fDataHora(qryAux.FieldByName('NFE_DTAAUT').AsDateTime)+'", ');
    AJson.Add('  "totalValue": '+fNumerico(conhecimento.fltValorPrestacaoServico, 2)+', ');

    AJson.Add('  "documents": [ ');

    for LIndex := 0 to conhecimento.intQtdInformacoesNFe - 1 do
    begin
      AJson.Add('    { ');
      AJson.Add('      "accessKey": "'+conhecimento.CTeInformacoesNFe[LIndex].strChaveAcessoNFe+'" ');
      AJson.Add('    } ');

      If LIndex < (conhecimento.intQtdInformacoesNFe - 1) Then
        AJson.Add(',');

    end;

    AJson.Add('  ], ');

    AJson.Add('  "client": { ');
    AJson.Add('    "addressNumber": '+fFormataCampo(conhecimento.Destinatario.strNumero)+', ');
    AJson.Add('    "name": '+fFormataCampo(conhecimento.Destinatario.strRazaoSocialNome)+', ');
    AJson.Add('    "email": '+IIF(fEmptyStr(conhecimento.Destinatario.strEmail),'" "', fFormataCampo(conhecimento.Destinatario.strEmail))+', ');
    AJson.Add('    "cpf": ' +IIF(fPessoa(conhecimento.Destinatario.strCPFCNPJ) = 'F', fFormataCampo(fTiraCaracEspeciais(conhecimento.Destinatario.strCPFCNPJ)), 'null')+', ');
    AJson.Add('    "cnpj": '+IIF(fPessoa(conhecimento.Destinatario.strCPFCNPJ) = 'J', fFormataCampo(fTiraCaracEspeciais(conhecimento.Destinatario.strCPFCNPJ)), 'null')+', ');
    AJson.Add('    "uf": '+fFormataCampo(qryAux.FieldByName('CID_ESTADO').AsString)+', ');
    AJson.Add('    "address": '+fFormataCampo(conhecimento.Destinatario.strLogradouro)+', ');
    AJson.Add('    "zipCode": '+fFormataCampo(conhecimento.Destinatario.strCEP)+', ');
    AJson.Add('    "city": '+fFormataCampo(qryAux.FieldByName('CID_NOMCID').AsString)+', ');
    AJson.Add('    "district": null, ');
    AJson.Add('    "complement": '+fFormataCampo(conhecimento.Destinatario.strComplemento));
    AJson.Add('  } ');
    AJson.Add('} ');

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TIntegracaoCitel.fRetornaMotivoCancelamento(AAutInc: String): String;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
begin
  Result := 'Cancelado';

  If not fTabelaExiste('DEL_MOVGER', Banco) Then
    Exit;

  If not fCampoExiste('DEL_MOVGER', 'MOTDEL', Banco) Then
    Exit;

  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT DISTINCT MOTDEL FROM PCITEL ';
    LSQL := LSQL + 'LEFT JOIN DEL_MOVGER ON GER_NUMDOC = NFE_NUMDOC ';
    LSQL := LSQL + '                    AND GER_ESPDOC = NFE_ESPDOC ';
    LSQL := LSQL + '                    AND GER_CODEMP = NFE_CODEMP ';
    LSQL := LSQL + '                    AND GER_CODCLI = NFE_FORCLI ';
    LSQL := LSQL + '                    AND GER_TIP_FC = NFE_TIP_FC ';
    LSQL := LSQL + '                    AND GER_SERIE_ = NFE_SERIE_ ';
    LSQL := LSQL + 'WHERE NFE_SEQFIS = :AUTINC ';

    If fTabelaExiste('DEL_NOTGER', Banco) Then
    Begin
      LSQL := LSQL + 'UNION ALL ' + AnsiReplaceStr(LSQL, 'MOVGER', 'NOTGER');
    End;

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('AUTINC').AsString := AAutInc;
    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      If not fEmptyStr(qryAux.FieldByName('MOTDEL').AsString) Then
        Result := qryAux.FieldByName('MOTDEL').AsString;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TIntegracaoCitel.fEnviarDFe(ATipDFe: TTipDfe; AAutInc, AOrigem: String; var AMensagemApi: String): Boolean;
Var
  LJson: TStringList;
  LArquivo: String;
  LRetornoCitel: TWSNfeCitelRetorno;
begin
  Result := False;

  Case ATipDFe of
    CTe  : LArquivo := 'ULTIMO_PAINEL_CITEL_CTE.TXT';
    NFe  : LArquivo := 'ULTIMO_PAINEL_CITEL_NFE.TXT';
    NFCe : LArquivo := 'ULTIMO_PAINEL_CITEL_NFCE.TXT';
    NFSe : LArquivo := 'ULTIMO_PAINEL_CITEL_NFSE.TXT';
  End;

  LJson := TStringList.Create;

  Try
    Case ATipDFe of
      CTe  : pPreparaCTe(AAutInc,  LJson);
      NFe  : pPreparaNFe(AAutInc, AOrigem, LJson);
      NFCe : pPreparaNFCe(AAutInc, LJson);
      NFSe : pPreparaNFSe(AAutInc, LJson);
    End;

    Try
      LJson.SaveToFile(fPnlDir(LArquivo));
    Except

    End;

    Case ATipDFe of
      CTe  : LRetornoCitel := fPostDFe(CTe,  LJson.Text);
      NFe  : LRetornoCitel := fPostDFe(NFe,  LJson.Text);
      NFCe : LRetornoCitel := fPostDFe(NFCe, LJson.Text);
      NFSe : LRetornoCitel := fPostDFe(NFSe, LJson.Text);
    Else
      LRetornoCitel := nil;
    End;

  Finally
    FreeAndNil(LJson);
  End;

  If Assigned(LRetornoCitel) Then
  Begin
    Result       := LRetornoCitel.RetornoOk;
    AMensagemApi := LRetornoCitel.Texto;
  End;
end;

function TIntegracaoCitel.fEnviarDFeXml(ATipDFe: TTipDfe; AChaveAcesso, ADocumento, ASerie: String; var AMensagemApi: String): Boolean;
Var
  LBytes: TBytes;
  LRetornoCitel: TWSNfeCitelRetorno;
begin
  pPreparaNFeXml(AChaveAcesso, LBytes);

  If (Length(LBytes) = 0) Then
  Begin
    AMensagemApi := 'Arquivo XML não existe';
    Result := False;
    Exit;
  End;

  LRetornoCitel := fPostDFeXml(ATipDFe, AChaveAcesso, ADocumento, ASerie, LBytes);

  AMensagemApi := LRetornoCitel.Texto;

  Result := LRetornoCitel.RetornoOk;
end;

function TIntegracaoCitel.fEnviarDFePdf(ATipDFe: TTipDfe; AChaveAcesso, ADocumento, ASerie: String; var AMensagemApi: String): Boolean;
Var
  LBytes: TBytes;
  LRetornoCitel: TWSNfeCitelRetorno;
begin
  pPreparaNFePdf(AChaveAcesso, LBytes);

  If (Length(LBytes) = 0) Then
  Begin
    AMensagemApi := 'Arquivo PDF não existe';
    Result := False;
    Exit;
  End;

  LRetornoCitel := fPostDFePdf(ATipDFe, AChaveAcesso, ADocumento, ASerie, LBytes);

  AMensagemApi := LRetornoCitel.Texto;

  Result := LRetornoCitel.RetornoOk;
end;

function TIntegracaoCitel.fGerarDFeXml(ATipDFe: TTipDfe; AChaveAcesso: String; var AMensagem: String): Boolean;
var
  LTipo: String;
  LEmpresa: String;
  LImpressora: String;
  LComando: String;
  LNfeImprimirExe: String;
begin
  Result := False;

  LNfeImprimirExe := IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName) ) + 'NFeImpressao.exe';

  If Not FileExists(LNfeImprimirExe) then
  Begin
    AMensagem := 'Arquivo não existe: ' + LNfeImprimirExe;
    Exit;
  End;

  Case ATipDFe of
    NFe  : LTipo := 'NFE';
    NFSe : LTipo := 'NFS';
    NFCe : LTipo := 'NFCE';
  End;

  LTipo       := LTipo + '_GERAR_XML';
  LEmpresa    := VS_strCodEmp;
  LImpressora := 'NENHUMA';

  Try
    LComando := fTagComValorToParam(LTipo,           consTagParamsTrf) +
                fTagComValorToParam(LEmpresa,        consTagParamsEmp) +
                fTagComValorToParam(AChaveAcesso,    consTagParamsChv) +
                fTagComValorToParam(LImpressora,     consTagParamsImp) +
                fTagComValorToParam(VS_PidMD5DicSis, consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

    StartProcess(LNfeImprimirExe, LComando, False, False);

    Result := True;
  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
    End;
  End;
end;

function TIntegracaoCitel.fGerarDFePdf(ATipDFe: TTipDfe; AChaveAcesso: String; var AMensagem: String): Boolean;
var
  LTipo: String;
  LEmpresa: String;
  LImpressora: String;
  LComando: String;
  LNfeImprimirExe: String;
begin
  Result := False;

  LNfeImprimirExe := IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName) ) + 'NFeImpressao.exe';

  If Not FileExists(LNfeImprimirExe) then
  Begin
    AMensagem := 'Arquivo não existe: ' + LNfeImprimirExe;
    Exit;
  End;

  Case ATipDFe of
    NFe  : LTipo := 'NFE';
    NFSe : LTipo := 'NFS';
    NFCe : LTipo := 'NFCE';
  End;

  LTipo       := LTipo + '_GERAR_PDF';
  LEmpresa    := VS_strCodEmp;
  LImpressora := 'NENHUMA';

  Try
    LComando := fTagComValorToParam(LTipo,           consTagParamsTrf) +
                fTagComValorToParam(LEmpresa,        consTagParamsEmp) +
                fTagComValorToParam(AChaveAcesso,    consTagParamsChv) +
                fTagComValorToParam(LImpressora,     consTagParamsImp) +
                fTagComValorToParam(VS_PidMD5DicSis, consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

    StartProcess(LNfeImprimirExe, LComando, False, False);

    Result := True;
  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
    End;
  End;
end;

function TIntegracaoCitel.fEnviarDFeCancelamento(ATipDFe: TTipDfe; AAutInc, AChaveAcesso, ADocumento, ASerie: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
Var
  LJson: TStringList;
  LRetornoCitel: TWSNfeCitelRetorno;
begin
  LJson := TStringList.Create;

  Try
    If (ATipDFe = NFSe) Then
    Begin
      LJson.Add('{ ');
      LJson.Add('  "documentNumber": '+fRemoveZerosEsquerda(ADocumento)+', ');
      LJson.Add('  "documentSeries": '+fFormataCampo(ASerie)+', ');
      LJson.Add('  "cancellationReason": '+fFormataCampo(fRetornaMotivoCancelamento(AAutInc))+', ');
      LJson.Add('  "cancellationDate": "'+fDataHora(ADtaCad)+'" ');
      LJson.Add('} ');
    End
    Else
    Begin
      LJson.Add('{ ');
      LJson.Add('  "accessKey": '+fFormataCampo(AChaveAcesso)+', ');
      LJson.Add('  "cancellationReason": '+fFormataCampo(fRetornaMotivoCancelamento(AAutInc))+', ');
      LJson.Add('  "cancellationDate": "'+fDataHora(ADtaCad)+'" ');
      LJson.Add('} ');
    End;

    LRetornoCitel := fPostDFeCancelamento(ATipDFe, LJson.Text);

  Finally
    FreeAndNil(LJson);
  End;

  AMensagemApi := LRetornoCitel.Texto;

  Result := LRetornoCitel.RetornoOk;
end;

function TIntegracaoCitel.fEnviarDFeCancelamentoXml(ATipDfe: TTipDfe; AAutInc, AChaveAcesso, ADocumento, ASerie: String; var AMensagemApi: String): Boolean;
Var
  LBytes: TBytes;
  LRetornoCitel: TWSNfeCitelRetorno;
begin
  pPreparaDFeXml(ATipDfe, AChaveAcesso, '', LBytes);

  If (Length(LBytes) = 0) Then
  Begin
    AMensagemApi := 'Arquivo XML não existe';
    Result := False;
    Exit;
  End;

  LRetornoCitel := fPostDFeXml(ATipDfe, AChaveAcesso, ADocumento, ASerie, LBytes);

  AMensagemApi := LRetornoCitel.Texto;

  Result := LRetornoCitel.RetornoOk;
end;

function TIntegracaoCitel.fEnviarCartaDeCorrecao(AAutInc, AChaveAcesso, AProtocolo: String; var AMensagemApi: String): Boolean;
Const
  CondicoesUso: String = 'A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art. 7o do Convenio S/N, de 15 de dezembro de 1970 '+
                         'e pode ser utilizada para regularizacao de erro ocorrido na emissao de documento fiscal,'+
                         ' desde que o erro nao esteja relacionado com: I - as variaveis que determinam o valor do imposto tais como: base de calculo,'+
                         ' aliquota, diferenca de preco, quantidade, valor da operacao ou da prestacao;'+
                         ' II - a correcao de dados cadastrais que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida.';

Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LJson: TStringList;
  LRetornoCitel: TWSNfeCitelRetorno;
begin

  Result := False;

  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT * FROM CC_NFE ';
    LSQL := LSQL + 'WHERE CCN_SEQGER = :SEQGER ';
    LSQL := LSQL + '  AND CCN_PROTOC = :PROTOC ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('SEQGER').AsString := AAutInc;
    qryAux.ParamByName('PROTOC').AsString := AProtocolo;
    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      LJson := TStringList.Create;

      Try
        LJson.Add('{ ');
        LJson.Add('  "status": "Autorizada", ');
        LJson.Add('  "document": { ');
        LJson.Add('    "accessKey": '+fFormataCampo(AChaveAcesso)+' ');
        LJson.Add('  }, ');
        LJson.Add('  "correctionId": "'+qryAux.FieldByName('CCN_CODSEQ').AsString+'", ');
        LJson.Add('  "correction": '+fFormataCampo(qryAux.FieldByName('CCN_DESCOR').AsString)+', ');
        LJson.Add('  "emissionDate": "'+fDataHora(qryAux.FieldByName('CCN_DTAENV').AsDateTime)+'", ');
        LJson.Add('  "authorizationDate": "'+fDataHora(qryAux.FieldByName('CCN_DTAENV').AsDateTime)+'", ');
        LJson.Add('  "id": 0, ');
        LJson.Add('  "motivoStatus": null, ');
        LJson.Add('  "condicoesUso": '+fFormataCampo(Copy(CondicoesUso,1, 600))+', ');
        LJson.Add('  "protocoloAutorizacao": '+fFormataCampo(AProtocolo)+' ');
        LJson.Add('} ');

        LRetornoCitel :=  fPostDFe(CCe, LJson.Text);

      Finally
        FreeAndNil(LJson);
      End;

      AMensagemApi := LRetornoCitel.Texto;

      Result := LRetornoCitel.RetornoOk;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TIntegracaoCitel.fEnviarCartaDeCorrecaoXml(AChaveAcesso, AProtocolo: String; var AMensagemApi: String): Boolean;
Var
  LBytes: TBytes;
  LRetornoCitel: TWSNfeCitelRetorno;
begin
  pPreparaDFeXml(CCe, AChaveAcesso, AProtocolo, LBytes);

  If (Length(LBytes) = 0) Then
  Begin
    AMensagemApi := 'Arquivo XML não existe';
    Result := False;
    Exit;
  End;

  LRetornoCitel := fPostDFeXml(CCe, AChaveAcesso+'/'+AProtocolo, '', '', LBytes);

  AMensagemApi := LRetornoCitel.Texto;

  Result := LRetornoCitel.RetornoOk;
end;

function TIntegracaoCitel.fPostDFe(ATipDFe: TTipDfe; AJson: String): TWSNfeCitelRetorno;
var
  LStatus: Integer;
  LComando: String;
begin

  Case ATipDFe of
    CTe  : LComando := '/api/documentCte';
    CCe  : LComando := '/api/documentCce';
    NFe  : LComando := '/api/documentNfe';
    NFCe : LComando := '/api/documentNfce';
    NFSe : LComando := '/api/documentNfse';
  End;

  Result := fComunicaWebService(mPost, LComando, AJson, 'application/json', nil);

  If Result.FRetornoOk Then
  Begin
    LStatus := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 0);
    If LStatus = 200 Then
    Begin
      Result := TWSNfeCitelRetorno.Create(True, Result.Texto);
    End
    Else
    Begin
      Result := TWSNfeCitelRetorno.Create(False, Result.Texto);
    End;
  End;
end;

function TIntegracaoCitel.fPostDFeXml(ATipDFe: TTipDfe; AChaveAcesso, ADocumento, ASerie: String; ABytes: TBytes): TWSNfeCitelRetorno;
var
  LStatus: Integer;
  LComando: String;
begin

  Case ATipDFe of
    CCe             : LComando := '/api/xmlCceUpload/'+AChaveAcesso;
    CTe             : LComando := '/api/xmlCteUpload/'+AChaveAcesso;
    NFe             : LComando := '/api/xmlNfeUpload/'+AChaveAcesso;
    NFCe            : LComando := '/api/xmlNfceUpload/'+AChaveAcesso;
    NFSe            : LComando := '/api/xmlNfseUpload/'+ADocumento+'/'+ASerie;
    CTeCancelamento : LComando := '/api/xmlCancellationCteUpload/'+AChaveAcesso;
    NFeCancelamento : LComando := '/api/xmlCancellationNfeUpload/'+AChaveAcesso;
    NFCeCancelamento: LComando := '/api/xmlCancellationNfceUpload/'+AChaveAcesso;
    NFSeCancelamento: LComando := '/api/xmlCancellationNfseUpload/'+ADocumento+'/'+ASerie;
  End;

  Result := fComunicaWebService(mPost, LComando, '', 'text/xml', ABytes);

  If Result.FRetornoOk Then
  Begin
    LStatus := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 0);
    If LStatus = 200 Then
    Begin
      Result := TWSNfeCitelRetorno.Create(True, Result.Texto);
    End
    Else
    Begin
      Result := TWSNfeCitelRetorno.Create(False, Result.Texto);
    End;
  End;
end;

function TIntegracaoCitel.fPostDFePdf(ATipDFe: TTipDfe; AChaveAcesso, ADocumento, ASerie: String; ABytes: TBytes): TWSNfeCitelRetorno;
var
  LStatus: Integer;
  LComando: String;
begin

  Case ATipDFe of
    CTe  : LComando := '/api/pdfCteUpload/'+AChaveAcesso;
    NFe  : LComando := '/api/pdfNfeUpload/'+AChaveAcesso;
    NFCe : LComando := '/api/pdfNfceUpload/'+AChaveAcesso;
    NFSe : LComando := '/api/pdfNfseUpload/'+ADocumento+'/'+ASerie;
  End;

  Result := fComunicaWebService(mPost, LComando, '', 'application/pdf', ABytes);

  If Result.FRetornoOk Then
  Begin
    LStatus := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 0);
    If LStatus = 200 Then
    Begin
      Result := TWSNfeCitelRetorno.Create(True, Result.Texto);
    End
    Else
    Begin
      Result := TWSNfeCitelRetorno.Create(False, Result.Texto);
    End;
  End;
end;

function TIntegracaoCitel.fPostDFeCancelamento(ATipDFe: TTipDfe; AJson: String): TWSNfeCitelRetorno;
var
  LStatus: Integer;
  LComando: String;
begin

  Case ATipDFe of
    CTe  : LComando := '/api/CancellationDocumentCte';
    NFe  : LComando := '/api/CancellationDocumentNfe';
    NFCe : LComando := '/api/CancellationDocumentNfce';
    NFSe : LComando := '/api/CancellationDocumentNfse';
  End;

  Result := fComunicaWebService(mPost, LComando, AJson, 'application/json', nil);

  If Result.FRetornoOk Then
  Begin
    LStatus := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 0);
    If LStatus = 200 Then
    Begin
      Result := TWSNfeCitelRetorno.Create(True, Result.Texto);
    End
    Else
    Begin
      Result := TWSNfeCitelRetorno.Create(False, Result.Texto);
    End;
  End;
end;

procedure TIntegracaoCitel.pPreparaNFeXml(AChaveAcesso: String; var ABytes: TBytes);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LStringStream: TStringStream;
begin
  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT NFE_ARQXML FROM XMLNFE ';
    LSQL := LSQL + 'WHERE NFE_ACESSO = :ACESSO ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      Try
        pGerarXmlCitel(AChaveAcesso);
      Except

      End;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(LSQL);
      qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
      qryAux.Open;
    End;

    If not qryAux.IsEmpty Then
    Begin
      LStringStream := TStringStream.Create(EmptyStr);

      Try
        TBlobField(qryAux.FieldByName('NFE_ARQXML')).SaveToStream(LStringStream);

        {$IF Defined(UNIDAC)}
          ABytes := TEncoding.UTF8.GetBytes(fRemoverCaracteresInvalidosXML(LStringStream.DataString));
        {$ELSE}
          ABytes := fBytesOf(AnsiToUtf8(fRemoverCaracteresInvalidosXML(LStringStream.DataString)));
        {$IFEND}

      Finally
        FreeAndNil(LStringStream);
      End;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TIntegracaoCitel.pPreparaNFePdf(AChaveAcesso: String; var ABytes: TBytes);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LStringStream: TStringStream;
begin
  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT NFE_ARQPDF FROM PDFNFE ';
    LSQL := LSQL + 'WHERE NFE_ACESSO = :ACESSO ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      LStringStream := TStringStream.Create(EmptyStr);
      Try
        TBlobField(qryAux.FieldByName('NFE_ARQPDF')).SaveToStream(LStringStream);

        ABytes := fBytesOf(AnsiString(fBase64Decodifica(LStringStream.DataString)));

      Finally
        FreeAndNil(LStringStream);
      End;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TIntegracaoCitel.pPreparaDFeXml(ATipDfe: TTipDfe; AChaveAcesso, AProtocolo: String; var ABytes: TBytes);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LTipDfe: String;
  LStringStream: TStringStream;
begin

  Case ATipDFe of
    CCe             : LTipDfe := 'CC_CARTA_CORRECAO';
    CTeCancelamento : LTipDfe := 'CT_CANCELAMENTO';
    NFeCancelamento : LTipDfe := 'NF_CANCELAMENTO';
    NFCeCancelamento: LTipDfe := 'IF_CANCELAMENTO';
    NFSeCancelamento: LTipDfe := 'NS_CANCELAMENTO';
  End;

  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT NFE_ARQXML FROM XMLDFE ';
    LSQL := LSQL + 'WHERE NFE_ACESSO = :ACESSO ';
    LSQL := LSQL + '  AND NFE_TIPDFE = :TIPDFE ';

    If (ATipDFe = CCe) Then
      LSQL := LSQL + '  AND NFE_PROTOC = :PROTOC ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.ParamByName('TIPDFE').AsString := LTipDfe;

    If (ATipDFe = CCe) Then
      qryAux.ParamByName('PROTOC').AsString := AProtocolo;

    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      LStringStream := TStringStream.Create(EmptyStr);
      Try
        TBlobField(qryAux.FieldByName('NFE_ARQXML')).SaveToStream(LStringStream);

        {$IF Defined(UNIDAC)}
          ABytes := TEncoding.UTF8.GetBytes(fRemoverCaracteresInvalidosXML(LStringStream.DataString));
        {$ELSE}
          ABytes := fBytesOf(AnsiToUtf8(fRemoverCaracteresInvalidosXML(LStringStream.DataString)));
        {$IFEND}

      Finally
        FreeAndNil(LStringStream);
      End;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TIntegracaoCitel.fProcessaNFe(ATipInt, AAutInc, AChaveAcesso, ADocumento, ASerie, AProtocolo, AOrigem: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
begin
  Result := False;

  If ATipInt = 'NFE' Then
  Begin
    Result := fEnviarDFe(NFe, AAutInc, AOrigem, AMensagemApi);
  End;

  If ATipInt = 'NFE_XML' Then
  Begin
    Result := fEnviarDFeXml(NFe, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'NFE_PDF' Then
  Begin
    Result := fEnviarDFePdf(NFe, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'NFE_CANCELAMENTO' Then
  Begin
    Result := fEnviarDFeCancelamento(NFe, AAutInc, AChaveAcesso, ADocumento, ASerie, ADtaCad, AMensagemApi);
  End;

  If ATipInt = 'NFE_CANCELAMENTO_XML' Then
  Begin
    Result := fEnviarDFeCancelamentoXml(NFeCancelamento, AAutInc, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'NFE_CARTA_CORRECAO' Then
  Begin
    Result := fEnviarCartaDeCorrecao(AAutInc, AChaveAcesso, AProtocolo, AMensagemApi);
  End;

  If ATipInt = 'NFE_CARTA_CORRECAO_XML' Then
  Begin
    Result := fEnviarCartaDeCorrecaoXml(AChaveAcesso, AProtocolo, AMensagemApi);
  End;

  If ATipInt = 'GERAR_NFE_XML' Then
  Begin
    Result := fGerarDFeXml(NFe, AChaveAcesso, AMensagemApi);
  End;

  If ATipInt = 'GERAR_NFE_PDF' Then
  Begin
    Result := fGerarDFePdf(NFe, AChaveAcesso, AMensagemApi);
  End;
end;

function TIntegracaoCitel.fProcessaNFCe(ATipInt, AAutInc, AChaveAcesso, ADocumento, ASerie: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
begin
  Result := False;

  If ATipInt = 'NFCE' Then
  Begin
    Result := fEnviarDFe(NFCe, AAutInc, '', AMensagemApi);
  End;

  If ATipInt = 'NFCE_XML' Then
  Begin
    Result := fEnviarDFeXml(NFCe, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'NFCE_PDF' Then
  Begin
    Result := fEnviarDFePdf(NFCe, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'NFCE_CANCELAMENTO' Then
  Begin
    Result := fEnviarDFeCancelamento(NFCe, AAutInc, AChaveAcesso, ADocumento, ASerie, ADtaCad, AMensagemApi);
  End;

  If ATipInt = 'NFCE_CANCELAMENTO_XML' Then
  Begin
    Result := fEnviarDFeCancelamentoXml(NFCeCancelamento, AAutInc, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'GERAR_NFCE_XML' Then
  Begin
    Result := fGerarDFeXml(NFCe, AChaveAcesso, AMensagemApi);
  End;

  If ATipInt = 'GERAR_NFCE_PDF' Then
  Begin
    Result := fGerarDFePdf(NFCe, AChaveAcesso, AMensagemApi);
  End;
end;

function TIntegracaoCitel.fProcessaNFSe(ATipInt, AAutInc, AChaveAcesso, ADocumento, ASerie: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
begin
  Result := False;

  If ATipInt = 'NFSE' Then
  Begin
    Result := fEnviarDFe(NFSe, AAutInc, '', AMensagemApi);
  End;

  If ATipInt = 'NFSE_XML' Then
  Begin
    Result := fEnviarDFeXml(NFSe, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'NFSE_PDF' Then
  Begin
    Result := fEnviarDFePdf(NFSe, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'NFSE_CANCELAMENTO' Then
  Begin
    Result := fEnviarDFeCancelamento(NFSe, AAutInc, AChaveAcesso, ADocumento, ASerie, ADtaCad, AMensagemApi);
  End;

  If ATipInt = 'NFSE_CANCELAMENTO_XML' Then
  Begin
    Result := fEnviarDFeCancelamentoXml(NFSeCancelamento, AAutInc, AChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'GERAR_NFSE_XML' Then
  Begin
    Result := fGerarDFeXml(NFSe, AChaveAcesso, AMensagemApi);
  End;

  If ATipInt = 'GERAR_NFSE_PDF' Then
  Begin
    Result := fGerarDFePdf(NFSe, AChaveAcesso, AMensagemApi);
  End;
end;

function TIntegracaoCitel.fProcessaCTe(ATipInt, AAutInc, ADocumento, ASerie: String; ADtaCad: TDateTime; var AMensagemApi: String): Boolean;
var
  LChaveAcesso: String;
begin
  Result := False;

  LChaveAcesso := fRetornaChaveAcessoCTe(AAutInc);

  If ATipInt = 'CTE' Then
  Begin
    Result := fEnviarDFe(CTe, AAutInc, '', AMensagemApi);
  End;

  If ATipInt = 'CTE_XML' Then
  Begin
    Result := fEnviarDFeXml(CTe, LChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'CTE_PDF' Then
  Begin
    Result := fEnviarDFePdf(CTe, LChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;

  If ATipInt = 'CTE_CANCELAMENTO' Then
  Begin
    Result := fEnviarDFeCancelamento(CTe, AAutInc, LChaveAcesso, ADocumento, ASerie, ADtaCad, AMensagemApi);
  End;

  If ATipInt = 'CTE_CANCELAMENTO_XML' Then
  Begin
    Result := fEnviarDFeCancelamentoXml(CTeCancelamento, AAutInc, LChaveAcesso, ADocumento, ASerie, AMensagemApi);
  End;
end;

function TIntegracaoCitel.fRetornaChaveAcessoCTe(AAutInc: String): String;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
begin
  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT ';
    LSQL := LSQL + '  MOVCTE.CTE_ACESSO ';
    LSQL := LSQL + 'FROM MOVCTE ';
    LSQL := LSQL + 'INNER JOIN LOGNFE ON CTE_NUMCTE = NFE_NUMDOC ';
    LSQL := LSQL + '                AND NFE_ESPDOC = "CT" ';
    LSQL := LSQL + '                AND CTE_CODEMP = NFE_CODEMP ';
    LSQL := LSQL + 'INNER JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
    LSQL := LSQL + 'INNER JOIN CADFIS ON GER_NUMDOC = FIS_NUMDOC ';
    LSQL := LSQL + '                 AND GER_ESPDOC = FIS_ESPDOC ';
    LSQL := LSQL + '                 AND GER_SERIE_ = FIS_SERIE_ ';
    LSQL := LSQL + '                 AND GER_CODEMP = FIS_CODEMP ';
    LSQL := LSQL + '                 AND GER_TIP_FC = FIS_TIP_FC ';
    LSQL := LSQL + '                 AND IFNULL(GER_CODCLI, GER_CODFOR) = FIS_FORCLI ';
    LSQL := LSQL + 'WHERE CADFIS.AUTOINCREM = :AUTINC ';

    LSQL := LSQL + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(LSQL, 'MOVGER', 'NOTGER'), 'MOVCTE', 'NOTCTE');

    LSQL := LSQL + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(LSQL, 'MOVCTE', 'DEL_MOVCTE'), 'NOTCTE', 'DEL_NOTCTE');

    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('AUTINC').AsString := AAutInc;
    qryAux.Open;

    Result := qryAux.FieldByName('CTE_ACESSO').AsString;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TIntegracaoCitel.fSQLQuantidadeLimite: String;
var
  LQtdeGR: String;
begin
  LQtdeGR := '20';

  If fExisteConfiguracao('PWCQGR') Then
  Begin
    LQtdeGR := fCfgSis('PWCQGR', varString);
    LQtdeGR := IIF(fEmptyStr(LQtdeGR),'20',LQtdeGR);
  End;

  Result := IIF(FStatus = 'GR', LQtdeGR, '100');
end;

function TIntegracaoCitel.fRetornaOrigem(ADataSet: TDataSet): String;
begin
 Result := '';

 If fCampoExiste('PCITEL', 'NFE_ORIGEM', Banco) Then
   Result := ADataSet.FieldByName('NFE_ORIGEM').AsString;

end;

procedure TIntegracaoCitel.Executar;
var
  LErroDownload: TStringList;
begin
  If Not fIntegracaoPainelCitelConfigurada(VS_strCodEmp, Banco) Then
    Exit;

  Try
    {$IF Defined(UNIDAC)}
    pDownloadNotasDeTerceiros;
    pDownloadConhecimentosDeTerceiros;
    {$IFEND};
  Except
    On E: Exception Do
    Begin
      LErroDownload := TStringList.Create;
      Try
        objLogDanfe.AddLog('Erro Download Dfe de Terceiros: ' + E.Message);
        LErroDownload.Add(E.Message);
        LErroDownload.SaveToFile(fPnlDir('ErroDfeTerceiros.txt'));
      Finally
        FreeAndNil(LErroDownload);
      End;
    End;
  End;

  If Not fExistemRegistrosPendentesIntegracaoPainelCitel(FStatus, VS_strCodEmp, Banco) Then
    Exit;

  ProcessaDocumentos;
end;

procedure TIntegracaoCitel.pFreeAndNil(AObject: TObject);
begin
  If Assigned(AObject) Then
    FreeAndNil(AObject);
end;

procedure TIntegracaoCitel.ProcessaDocumentos;
Var
  qryDocumentosPendentes: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryUpdate: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LMensagemApi: String;
  LRetornoOK: Boolean;
begin

  qryDocumentosPendentes := fCriaQuery(Nil, Banco);
  qryUpdate := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT ';
    LSQL := LSQL + '  PCITEL.*, CADFIS.* ';
    LSQL := LSQL + 'FROM PCITEL ';
    LSQL := LSQL + 'INNER JOIN CADFIS ON CADFIS.AUTOINCREM = PCITEL.NFE_SEQFIS ';
    LSQL := LSQL + 'LEFT JOIN LOGNFE ON LOGNFE.NFE_NUMDOC = CADFIS.FIS_NUMDOC AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_ESPDOC = CADFIS.FIS_ESPDOC AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_CODEMP = CADFIS.FIS_CODEMP AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_CODCLI = CADFIS.FIS_FORCLI AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_TIP_FC = CADFIS.FIS_TIP_FC AND ';
    LSQL := LSQL + '                    LOGNFE.NFE_SERIE_ = CADFIS.FIS_SERIE_ ';
    LSQL := LSQL + 'WHERE PCITEL.NFE_STATUS = :STATUS ';
    LSQL := LSQL + '  AND PCITEL.NFE_CODEMP = :CODEMP ';
    LSQL := LSQL + 'ORDER BY PCITEL.NFE_SEQFIS ';
    LSQL := LSQL + 'LIMIT '+fSQLQuantidadeLimite;

    qryDocumentosPendentes.SQL.Add(LSQL);
    qryDocumentosPendentes.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDocumentosPendentes.ParamByName('STATUS').AsString := IIF(fEmptyStr(FStatus), 'GE', FStatus);
    qryDocumentosPendentes.Open;

    LSQL := '';
    LSQL := LSQL + 'UPDATE ';
    LSQL := LSQL + '  PCITEL ';
    LSQL := LSQL + 'SET ';
    LSQL := LSQL + '  NFE_STATUS = :STATUS, ';
    LSQL := LSQL + '  NFE_DTAENV = :DTAENV, ';
    LSQL := LSQL + '  NFE_MSGAPI = :MSGAPI  ';
    LSQL := LSQL + 'WHERE NFE_SEQFIS = :SEQFIS ';
    LSQL := LSQL + '  AND NFE_CODEMP = :CODEMP ';
    LSQL := LSQL + '  AND NFE_TIPINT = :TIPINT ';
    LSQL := LSQL + '  AND NFE_PROTOC = :PROTOC ';

    qryUpdate.SQL.Add(LSQL);
    qryDocumentosPendentes.First;

    FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

    While Not qryDocumentosPendentes.Eof Do
    Begin
      FTarefa.pSinalizarExecutando;

      If FTarefa.blnBloquear Then
        Break;

      FTarefa.pAtualizarInformacao(FTarefa.strDescricao +' '+ Concat(qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString, '-',
                                                                     qryDocumentosPendentes.FieldByName('FIS_NUMDOC').AsString, '-',
                                                                     qryDocumentosPendentes.FieldByName('FIS_ESPDOC').AsString, '-',
                                                                     qryDocumentosPendentes.FieldByName('FIS_CODEMP').AsString));

      LRetornoOK   := False;
      LMensagemApi := '';
      FJson        := '';
      FArquivo     := '';

      Try
        {***************************}
        {* Nota Fiscal de Produtos *}
        {*********************** BZ*}
        If Pos('NFE', qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString) > 0 Then
        Begin
          LRetornoOK := fProcessaNFe(qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString,
                                     qryDocumentosPendentes.FieldByName('NFE_SEQFIS').AsString,
                                     qryDocumentosPendentes.FieldByName('FIS_ACESSO').AsString,
                                     qryDocumentosPendentes.FieldByName('FIS_NUMDOC').AsString,
                                     qryDocumentosPendentes.FieldByName('FIS_SERIE_').AsString,
                                     qryDocumentosPendentes.FieldByName('NFE_PROTOC').AsString,
                                     fRetornaOrigem(qryDocumentosPendentes),
                                     qryDocumentosPendentes.FieldByName('NFE_DTACAD').AsDateTime,
                                     LMensagemApi);
        End;

        {*****************************}
        {* Nota Fiscal de Consumidor *}
        {************************* BZ*}
        If Pos('NFCE', qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString) > 0 Then
        Begin
          LRetornoOK := fProcessaNFCe(qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString,
                                      qryDocumentosPendentes.FieldByName('NFE_SEQFIS').AsString,
                                      qryDocumentosPendentes.FieldByName('FIS_ACESSO').AsString,
                                      qryDocumentosPendentes.FieldByName('FIS_NUMDOC').AsString,
                                      qryDocumentosPendentes.FieldByName('FIS_SERIE_').AsString,
                                      qryDocumentosPendentes.FieldByName('NFE_DTACAD').AsDateTime,
                                      LMensagemApi);
        End;

        {***************************}
        {* Nota Fiscal de Serviços *}
        {*********************** BZ*}
        If Pos('NFSE', qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString) > 0 Then
        Begin
          LRetornoOK := fProcessaNFSe(qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString,
                                      qryDocumentosPendentes.FieldByName('NFE_SEQFIS').AsString,
                                      qryDocumentosPendentes.FieldByName('FIS_ACESSO').AsString,
                                      qryDocumentosPendentes.FieldByName('FIS_NUMDOC').AsString,
                                      qryDocumentosPendentes.FieldByName('FIS_SERIE_').AsString,
                                      qryDocumentosPendentes.FieldByName('NFE_DTACAD').AsDateTime,
                                      LMensagemApi);
        End;

        {*****************************************}
        {* Conhecimento de Transporte eletrônico *}
        {************************************* BZ*}
        If Pos('CTE', qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString) > 0 Then
        Begin
          LRetornoOK := fProcessaCTe(qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString,
                                     qryDocumentosPendentes.FieldByName('NFE_SEQFIS').AsString,
                                     qryDocumentosPendentes.FieldByName('FIS_NUMDOC').AsString,
                                     qryDocumentosPendentes.FieldByName('FIS_SERIE_').AsString,
                                     qryDocumentosPendentes.FieldByName('NFE_DTACAD').AsDateTime,
                                     LMensagemApi);
        End;

      Except
        On E: Exception Do
        Begin
          LMensagemApi := E.Message;
        End;
      End;

      qryUpdate.ParamByName('SEQFIS').AsString := qryDocumentosPendentes.FieldByName('NFE_SEQFIS').AsString;
      qryUpdate.ParamByName('CODEMP').AsString := qryDocumentosPendentes.FieldByName('NFE_CODEMP').AsString;
      qryUpdate.ParamByName('TIPINT').AsString := qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString;
      qryUpdate.ParamByName('PROTOC').AsString := qryDocumentosPendentes.FieldByName('NFE_PROTOC').AsString;
      qryUpdate.ParamByName('MSGAPI').AsString := LMensagemApi;

      If LRetornoOK Then
      Begin
        qryUpdate.ParamByName('STATUS').AsString   := 'OK';
        qryUpdate.ParamByName('DTAENV').AsDateTime := nOw();
      End
      Else
      Begin
        qryUpdate.ParamByName('STATUS').AsString   := 'EE';

        pAnaliseErroPainelCitel(qryDocumentosPendentes.FieldByName('NFE_SEQFIS').AsString,
                                qryDocumentosPendentes.FieldByName('NFE_NUMDOC').AsString,
                                qryDocumentosPendentes.FieldByName('NFE_ESPDOC').AsString,
                                qryDocumentosPendentes.FieldByName('NFE_CODEMP').AsString,
                                qryDocumentosPendentes.FieldByName('NFE_SERIE_').AsString,
                                qryDocumentosPendentes.FieldByName('NFE_FORCLI').AsString,
                                qryDocumentosPendentes.FieldByName('NFE_TIP_FC').AsString,
                                qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString,
                                LMensagemApi);
      End;

      qryUpdate.ExecSQL;

      pGravaJson(qryDocumentosPendentes.FieldByName('NFE_SEQFIS').AsString,
                 qryDocumentosPendentes.FieldByName('NFE_TIPINT').AsString,
                 qryDocumentosPendentes.FieldByName('NFE_PROTOC').AsString,
                 FJson);

      qryDocumentosPendentes.Next;
    End;

  Finally
    pFreeAndNil(qryDocumentosPendentes);
    pFreeAndNil(qryUpdate);
  End;
end;

function TIntegracaoCitel.fExisteDocumentoPainelCitel(ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, ATipInt: String): Boolean;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM PCITEL');
    qryAux.SQL.Add('WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND NFE_FORCLI = :CODCLI ');
    qryAux.SQL.Add('  AND NFE_TIP_FC = :TIP_FC ');
    qryAux.SQL.Add('  AND NFE_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('  AND NFE_TIPINT = :TIPINT ');

    qryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.ParamByName('CODCLI').AsString := ACodCli;
    qryAux.ParamByName('TIP_FC').AsString := ATip_FC;
    qryAux.ParamByName('SERIE_').AsString := ASerie;
    qryAux.ParamByName('TIPINT').AsString := ATipInt;

    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      Result := (qryAux.FieldByName('QTD').AsInteger > 0);
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TIntegracaoCitel.pGravaDocumentoPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, ATipInt, AStatus: String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  If fEmptyStr(ASeqFis) Then
    Exit;

  If (Pos('GERAR', ATipInt) = 0) And fExisteDocumentoPainelCitel(ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, ATipInt) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('REPLACE INTO PCITEL (');
    qryAux.SQL.Add('  NFE_SEQFIS,');
    qryAux.SQL.Add('  NFE_NUMDOC,');
    qryAux.SQL.Add('  NFE_ESPDOC,');
    qryAux.SQL.Add('  NFE_CODEMP,');
    qryAux.SQL.Add('  NFE_FORCLI,');
    qryAux.SQL.Add('  NFE_SERIE_,');
    qryAux.SQL.Add('  NFE_TIP_FC,');
    qryAux.SQL.Add('  NFE_DTACAD,');
    qryAux.SQL.Add('  NFE_DTAENV,');
    qryAux.SQL.Add('  NFE_TIPINT,');
    qryAux.SQL.Add('  NFE_PROTOC,');
    qryAux.SQL.Add('  NFE_STATUS)');
    qryAux.SQL.Add('VALUES (');
    qryAux.SQL.Add('  :SEQFIS,');
    qryAux.SQL.Add('  :NUMDOC,');
    qryAux.SQL.Add('  :ESPDOC,');
    qryAux.SQL.Add('  :CODEMP,');
    qryAux.SQL.Add('  :FORCLI,');
    qryAux.SQL.Add('  :SERIE_,');
    qryAux.SQL.Add('  :TIP_FC,');
    qryAux.SQL.Add('  :DTACAD,');
    qryAux.SQL.Add('  :DTAENV,');
    qryAux.SQL.Add('  :TIPINT,');
    qryAux.SQL.Add('  :PROTOC,');
    qryAux.SQL.Add('  :STATUS)');

    qryAux.ParamByName('SEQFIS').AsString   := ASeqFis;
    qryAux.ParamByName('NUMDOC').AsString   := ANumDoc;
    qryAux.ParamByName('ESPDOC').AsString   := AEspDoc;
    qryAux.ParamByName('CODEMP').AsString   := ACodEmp;
    qryAux.ParamByName('FORCLI').AsString   := ACodCli;
    qryAux.ParamByName('TIP_FC').AsString   := ATip_FC;
    qryAux.ParamByName('SERIE_').AsString   := ASerie;
    qryAux.ParamByName('DTACAD').AsDateTime := nOw();
    qryAux.ParamByName('TIPINT').AsString   := ATipInt;
    qryAux.ParamByName('PROTOC').AsString   := 'ND';
    qryAux.ParamByName('STATUS').AsString   := AStatus;

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TIntegracaoCitel.fRetornaTipoIntegracao(AEspDoc: String): String;
begin
  case AnsiIndexStr(AEspDoc, ['NF', 'NS','IF']) of
    0 : Result := 'NFE';
    1 : Result := 'NFSE';
    2 : Result := 'NFCE';
  end;
end;

procedure TIntegracaoCitel.pAnaliseErroPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, ATipInt, AMensagemApi: String);
begin
  If (Pos('GERAR', ATipInt) > 0) Then
    Exit;

  If not VS_PCitelCorrigeErros Then
    Exit;

  If (Pos('chave de acesso não encontrada', LowerCase(AMensagemApi)) > 0) Or
     (Pos('documento nf-e não localizado a partir da chave de acesso informada', LowerCase(AMensagemApi)) > 0) Then
  Begin
    pGravaDocumentoPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, fRetornaTipoIntegracao(AEspDoc), 'GE');
    pGravaDocumentoPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, fRetornaTipoIntegracao(AEspDoc) + '_XML', 'GE');
    pGravaDocumentoPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, fRetornaTipoIntegracao(AEspDoc) + '_PDF', 'GE');

    Exit;
  End;

  If Pos('arquivo xml não existe', LowerCase(AMensagemApi)) > 0 Then
  Begin
    pGravaDocumentoPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, 'GERAR_' + ATipInt, 'GR');
    Exit;
  End;

  If Pos('arquivo pdf não existe', LowerCase(AMensagemApi)) > 0 Then
  Begin
    pGravaDocumentoPainelCitel(ASeqFis, ANumDoc, AEspDoc, ACodEmp, ASerie, ACodCli, ATip_FC, 'GERAR_' + ATipInt, 'GR');
    Exit;
  End;
end;

procedure TIntegracaoCitel.pGravaJson(ASeqFis, ATipInt, AProtoc, AJson: String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  If not VS_PCitelGravaDocJson Then
    Exit;

  If fEmptyStr(ASeqFis) Then
    Exit;

  If fEmptyStr(ATipInt) Then
    Exit;

  If fEmptyStr(AProtoc) Then
    Exit;

  If fEmptyStr(AJson) Then
    Exit;

  If (Pos('GERAR', ATipInt) > 0) Then
    Exit;

  If not fTabelaExiste('PCJSON') Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('REPLACE INTO PCJSON (');
    qryAux.SQL.Add('  NFE_SEQFIS,');
    qryAux.SQL.Add('  NFE_TIPINT,');
    qryAux.SQL.Add('  NFE_PROTOC,');
    qryAux.SQL.Add('  NFE_JSON__)');
    qryAux.SQL.Add('VALUES (');
    qryAux.SQL.Add('  :SEQFIS,');
    qryAux.SQL.Add('  :TIPINT,');
    qryAux.SQL.Add('  :PROTOC,');
    qryAux.SQL.Add('  :JSON__)');

    qryAux.ParamByName('SEQFIS').AsString   := ASeqFis;
    qryAux.ParamByName('TIPINT').AsString   := ATipInt;
    qryAux.ParamByName('PROTOC').AsString   := AProtoc;
    qryAux.ParamByName('JSON__').AsString   := AJson;

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TIntegracaoCitel.pGerarXmlCitel(AChaveAcesso: String);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LIntRps: Integer;
  LstrRps: String;
  LNumeroNSe: String;
  LNumeroRPS: String;
  LSerieRPS: String;
  fonteDados: IFonteDados;
  service: INFEService;

begin
  If not fExisteConfiguracao('NFSCIT') Then
    Exit;

  If not fCfgSis('NFSCIT', varBoolean) Then
    Exit;

  qryAux := fCriaQuery(Nil, Banco);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT * FROM CADFIS ';
    LSQL := LSQL + 'INNER JOIN LOGNFE ON LOGNFE.NFE_NUMDOC = FIS_NUMDOC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_ESPDOC = FIS_ESPDOC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_CODEMP = FIS_CODEMP AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_CODCLI = FIS_FORCLI AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_TIP_FC = FIS_TIP_FC AND ';
    LSQL := LSQL + '                     LOGNFE.NFE_SERIE_ = FIS_SERIE_ ';
    LSQL := LSQL + 'WHERE FIS_ACESSO = :ACESSO';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(LSQL);
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.Open;

    If not (qryAux.RecordCount > 0) Then
      Exit;

    If not (qryAux.FieldByName('FIS_ESPDOC').AsString = 'NS') Then
      Exit;

    LIntRps := 0;

    If fExisteConfiguracao('INTRPS') Then
    Begin
      LstrRps := fCfgSis('INTRPS', varString);

      If Not fEmptyStr(LstrRps) Then
        LIntRps := StrToIntDef(LstrRps, 0)
      Else
        LIntRps := 0;
    End;

    LNumeroNSe := IntToStr(Floor(StrToFloat(qryAux.FieldByName('FIS_NUMDOC').AsString)));
    LNumeroRPS := IntToStr(Floor(StrToFloat(qryAux.FieldByName('FIS_NUMDOC').AsString)) - LIntRps);
    LSerieRPS  := qryAux.FieldByName('FIS_SERIE_').AsString;

    pCarregaConfigNFE(VS_strCodEmp);

    pCarregarDll;

    pSetaConfiguracoes(confignfe);

    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(confignfe);

    fonteDados := fCriarFonteDadosBDSet(Banco,
                                        qryAux.FieldByName('FIS_NUMDOC').AsString,
                                        qryAux.FieldByName('FIS_ESPDOC').AsString,
                                        qryAux.FieldByName('FIS_CODEMP').AsString,
                                        qryAux.FieldByName('FIS_FORCLI').AsString,
                                        qryAux.FieldByName('FIS_SERIE_').AsString,
                                        qryAux.FieldByName('FIS_TIP_FC').AsString);

    fonteDados.pSetaIndicadorIntegracaoCitel;

    service := fCriarNFEService(fonteDados);

    service.pGerarXmlCitel(LNumeroNSe, LNumeroRPS, LSerieRPS, AChaveAcesso);

  Finally
    FreeAndNil(qryAux);
  End;

end;

{$IF Defined(UNIDAC)}
procedure TIntegracaoCitel.pDownloadConhecimentosDeTerceiros;
var
  LRetorno: TWSNfeCitelRetorno;
  LCaminhoXml: String;
  LUltimoNSU: String;
  LRetornoNSU: String;
  LNumeroNSU: String;
  LChaveAcesso: String;
  LArquivoXML: String;
  LNumeroCNPJ: String;
  LCnpjClienteFilial: String;
  LRetornoNFE: TStringList;
  LjSubObject: TJSONObject;
  LjsonArray: TJSONArray;
  LContador: Integer;
begin

  If not fIntegracaoPainelCitelDownloadConhecimentosDeTerceirosConfigurada(VS_strCodEmp, Banco) Then
    Exit;

  objLogDanfe.AddLog('TIntegracaoCitel.pDownloadConhecimentosDeTerceiros - Inicio');

  LCaminhoXml := fCfgSis('XMLCTE', varString, VS_strCodEmp);

  objLogDanfe.AddLog('LCaminhoXml - CFG_XMLCTE - ' + LCaminhoXml);

  LCnpjClienteFilial := fRetornaCnpjClienteFilial;

  objLogDanfe.AddLog('LCnpjClienteFilial - CADEMP - EMP_C_G_C_:'+LCnpjClienteFilial);

  LUltimoNSU := fRetornaUltimoNSU(CTe);

  objLogDanfe.AddLog('LUltimoNSU - CFG_PWCNCT - '+LUltimoNSU);

  LRetorno := fRetornaNSU(CTe, LUltimoNSU);

  If LRetorno.RetornoOk Then
  Begin
    LRetornoNSU := FArquivo;

    LjsonArray := fRetornaListagemNSU(CTe, LRetornoNSU);

    If Assigned(LjsonArray) Then
    Begin
      objLogDanfe.AddLog('LjsonArray.Count - '+ IntToStr(LjsonArray.Count));

      For LContador := 0 To LjsonArray.Count - 1 do
      Begin
        LjSubObject := (LjsonArray.Items[LContador] as TJSONObject);

        LNumeroNSU   := LjSubObject.GetValue('nsuNumber').Value;
        LChaveAcesso := LjSubObject.GetValue('accessKey').Value;
        LNumeroCNPJ  := LjSubObject.GetValue('issuerCnpj').Value;

        objLogDanfe.AddLog('fEhDocumentoClienteFilial - LNumeroCNPJ: '+LNumeroCNPJ+' LCnpjClienteFilial: '+LCnpjClienteFilial);

        If not fEhDocumentoClienteFilial(LNumeroCNPJ, LCnpjClienteFilial) Then
        Begin
          LRetorno := fRetornaDocumentoDeTerceiros(CTe, LChaveAcesso);

          If LRetorno.RetornoOk Then
          Begin
            Try
              LArquivoXML := LCaminhoXml + LChaveAcesso + '.xml';

              LRetornoNFE := TStringList.Create;
              LRetornoNFE.Text := FArquivo;
              LRetornoNFE.SaveToFile(LArquivoXML);

              objLogDanfe.AddLog('LRetornoNFE.SaveToFile - '+LArquivoXML);
            Finally
              FreeAndNil(LRetornoNFE);
            End;

            pAtualizaUltimoNSU(CTe, LNumeroNSU);
          End
          Else
          Begin
            Break;
          End;
        End;

      End;
    End;
  End;

  objLogDanfe.AddLog('TIntegracaoCitel.pDownloadConhecimentosDeTerceiros - Fim');
end;

procedure TIntegracaoCitel.pDownloadNotasDeTerceiros;
var
  LRetorno: TWSNfeCitelRetorno;
  LCaminhoXml: String;
  LUltimoNSU: String;
  LRetornoNSU: String;
  LNumeroNSU: String;
  LChaveAcesso: String;
  LArquivoXML: String;
  LNumeroCNPJ: String;
  LCnpjClienteFilial: String;
  LRetornoNFE: TStringList;
  LjSubObject: TJSONObject;
  LjsonArray: TJSONArray;
  LContador: Integer;
begin

  If not fIntegracaoPainelCitelDownloadNotasDeTerceirosConfigurada(VS_strCodEmp, Banco) Then
    Exit;

  objLogDanfe.AddLog('TIntegracaoCitel.pDownloadNotasDeTerceiros - Inicio');

  LCaminhoXml := fCfgSis('XMLPAT', varString, VS_strCodEmp);

  objLogDanfe.AddLog('LCaminhoXml - CFG_XMLPAT - ' + LCaminhoXml);

  LCnpjClienteFilial := fRetornaCnpjClienteFilial;

  objLogDanfe.AddLog('LCnpjClienteFilial - CADEMP - EMP_C_G_C_:'+LCnpjClienteFilial);

  LUltimoNSU := fRetornaUltimoNSU(NFe);

  objLogDanfe.AddLog('LUltimoNSU - CFG_PWCNSU - '+LUltimoNSU);

  LRetorno := fRetornaNSU(Nfe, LUltimoNSU);

  If LRetorno.RetornoOk Then
  Begin
    LRetornoNSU := FArquivo;

    LjsonArray := fRetornaListagemNSU(NFe, LRetornoNSU);

    If Assigned(LjsonArray) Then
    Begin
      objLogDanfe.AddLog('LjsonArray.Count - '+ IntToStr(LjsonArray.Count));

      For LContador := 0 To LjsonArray.Count - 1 do
      Begin
        LjSubObject := (LjsonArray.Items[LContador] as TJSONObject);

        LNumeroNSU   := LjSubObject.GetValue('nsuNumber').Value;
        LChaveAcesso := LjSubObject.GetValue('accessKey').Value;
        LNumeroCNPJ  := LjSubObject.GetValue('issuerCnpj').Value;

        objLogDanfe.AddLog('fEhDocumentoClienteFilial - LNumeroCNPJ: '+LNumeroCNPJ+' LCnpjClienteFilial: '+LCnpjClienteFilial);

        If not fEhDocumentoClienteFilial(LNumeroCNPJ, LCnpjClienteFilial) Then
        Begin
          LRetorno := fRetornaDocumentoDeTerceiros(NFe, LChaveAcesso);

          If LRetorno.RetornoOk Then
          Begin
            Try
              LArquivoXML := LCaminhoXml + LChaveAcesso + '.xml';

              LRetornoNFE := TStringList.Create;
              LRetornoNFE.Text := FArquivo;
              LRetornoNFE.SaveToFile(LArquivoXML);

              objLogDanfe.AddLog('LRetornoNFE.SaveToFile - '+LArquivoXML);
            Finally
              FreeAndNil(LRetornoNFE);
            End;

            pAtualizaUltimoNSU(NFe, LNumeroNSU);
          End
          Else
          Begin
            Break;
          End;
        End;

      End;
    End;
  End;

  objLogDanfe.AddLog('TIntegracaoCitel.pDownloadNotasDeTerceiros - Fim');
end;

function TIntegracaoCitel.fRetornaListagemNSU(ATipDFe: TTipDfe; ARetornoNSU: String): TJSONArray;
var
  LjsonObject: TJSONObject;
  LjsonValue: TJSONValue;
  LjsonArray: TJSONArray;
begin
  objLogDanfe.AddLog('TIntegracaoCitel.fRetornaListagemNSU - Inicio');

  LjsonArray := Nil;

  ARetornoNSU := '{"LISTAGEM": '+ARetornoNSU+'}';

  LjsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(ARetornoNSU), 0) as TJSONObject;

  If Assigned(LjsonObject) Then
  Begin
    LjsonValue  := LjsonObject.Get('LISTAGEM').JsonValue;
    LjsonArray  := LjsonValue as TJSONArray;
  End;

  Result := LjsonArray;

  objLogDanfe.AddLog('TIntegracaoCitel.fRetornaListagemNSU - Fim');
end;

function TIntegracaoCitel.fRetornaUltimoNSU(ATipDFe: TTipDfe): String;
begin
  Case ATipDFe of
    CTe: Result := fCfgSis('PWCNCT', varString, VS_strCodEmp);
    NFe: Result := fCfgSis('PWCNSU', varString, VS_strCodEmp);
  End;
end;

procedure TIntegracaoCitel.pAtualizaUltimoNSU(ATipDFe: TTipDfe; AUltimoNSU:String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LCodCfg: String;
begin

  Case ATipDFe of
    CTe: LCodCfg := 'CFG_PWCNCT';
    NFe: LCodCfg := 'CFG_PWCNSU';
  End;

  objLogDanfe.AddLog('TIntegracaoCitel.pAtualizaUltimoNSU - '+LCodCfg+' - Nro: ' + AUltimoNSU);

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Text := 'UPDATE CFGSIS SET SIS_VALCFG = :VALCFG WHERE SIS_CODCFG = "'+LCodCfg+'" AND SIS_CODEMP = :CODEMP ';
    qryAux.ParamByName('VALCFG').AsString := AUltimoNSU;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TIntegracaoCitel.fRetornaNSU(ATipDFe: TTipDfe; AUltimoNSU:String): TWSNfeCitelRetorno;
var
  LStatus: Integer;
  LComando: String;
begin
  objLogDanfe.AddLog('TIntegracaoCitel.fRetornaNSU - Inicio');

  If fEmptyStr(AUltimoNSU) Then
    AUltimoNSU := '0';

  Case ATipDFe of
    CTe: LComando := '/api/getNsuEntryCte/' + AUltimoNSU;
    NFe: LComando := '/api/getNsuEntryNfe/' + AUltimoNSU;
  End;

  Result := fComunicaWebService(mGet, LComando, '', 'application/json', nil);

  If Result.FRetornoOk Then
  Begin
    LStatus  := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 0);

    If LStatus = 200 Then
    Begin
      Result := TWSNfeCitelRetorno.Create(True, Result.Texto);
    End
    Else
    Begin
      Result := TWSNfeCitelRetorno.Create(False, Result.Texto);
    End;
  End;

  objLogDanfe.AddLog('TIntegracaoCitel.fRetornaNSU - Fim');
end;

function TIntegracaoCitel.fRetornaDocumentoDeTerceiros(ATipDFe: TTipDfe; AChaveAcesso:String): TWSNfeCitelRetorno;
var
  LStatus: Integer;
  LComando: String;
begin
  objLogDanfe.AddLog('TIntegracaoCitel.fRetornaDocumentoDeTerceiros - Inicio');

  Case ATipDFe of
    CTe: LComando := '/api/xmlEntryCteDownload/' + AChaveAcesso;
    NFe: LComando := '/api/xmlEntryNfeDownload/' + AChaveAcesso;
  End;

  Result := fComunicaWebService(mGet, LComando, '', 'application/json', nil);

  If Result.FRetornoOk Then
  Begin
    LStatus  := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 0);

    If LStatus = 200 Then
    Begin
      Result := TWSNfeCitelRetorno.Create(True, Result.Texto);
    End
    Else
    Begin
      Result := TWSNfeCitelRetorno.Create(False, Result.Texto);
    End;
  End;

  objLogDanfe.AddLog('TIntegracaoCitel.fRetornaDocumentoDeTerceiros - Fim');
end;
{$IFEND}

function TIntegracaoCitel.fRetornaCnpjClienteFilial: String;
begin
  Result := fCampoTabela('GROUP_CONCAT(DISTINCT EMP_C_G_C_)', 'CADEMP', [], [], Banco);
  Result := AnsiReplaceStr(Result, ',', '_');
end;

function TIntegracaoCitel.fEhDocumentoClienteFilial(ANumeroCNPJ, ACnpjClienteFilial: String): Boolean;
begin
  Result := (Pos(ANumeroCNPJ, ACnpjClienteFilial) > 0);
end;


end.
