unit PitStop.Classes.Base;

interface

uses REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
     Data.Bind.ObjectScope, REST.Types, System.SysUtils,
     Classes, System.SyncObjs, REST.Json,
     System.JSON, System.IOUtils, System.StrUtils,
     PitStop.Classes.EndPoint, Forms, Windows,
     Cotacao.ApiPrecos.BaseParam,
     Cotacao.ApiPrecos.ConstAndTypes,
     untFuncoesSimples, Dialogs, IPPeerClient,
     PitStop.classe.log;


  Type

  TipoRedePitStopCallApi = (trpitLista, trpitFornecedores, trpitBuscaCotacao, trpitFaturarPedido, trpiCancelaCotacao);

  TRedePitStopBase = class
  private
    FblnConsultaPitStop: Boolean;
    function fGetToken(Var AFalha: string): String;
    procedure pCriaRestClient;
    procedure pCriaRestRequest;
  protected
    FToken : String;
    FUrlBalcao: String;
    FUrlToken: String;
    FUsuario: String;
    FUrlFornecedor: String;
    FUrlContacaoProcessada: String;
    FUrlCotacao: String;
    FInicioComunicacao: TDatetime;
    FFimComunicacao: TDatetime;
    raRESTClient: TRESTClient;
    raRESTRequest: TRESTRequest;
    raRESTResponse: TRESTResponse;
    raHTTPBasicAuthenticator: THTTPBasicAuthenticator;
    procedure pSetaParametroJsonBody(AJson: String; Header: Boolean; Name: String);
  public
    TempoComunicacao: TDateTime;
    blnSalvarJson: Boolean;
    PitStopLog: TPitStopLog;

    function fExecute(ATipoRedePitStopCallApi: TipoRedePitStopCallApi; var AParamns: TBaseParamApi; Ret: TProc<TBaseParamApi>; var AFalha: String): String; virtual;
    constructor Create(AblnConsultaPitStop: Boolean); virtual;
    destructor Destroy; override;
  end;

implementation

{ TRedePitStopBase }

constructor TRedePitStopBase.Create(AblnConsultaPitStop: Boolean);
begin
  raHTTPBasicAuthenticator := THTTPBasicAuthenticator.Create('', '');
  raRESTResponse := TRESTResponse.Create(nil);
  raRESTResponse.ContentType := 'application/json';
  pCriaRestClient;
  pCriaRestRequest;
  blnSalvarJson := True;
  FUrlBalcao := fCfgSis('PSTBAL');
  FUrlToken := fCfgSis('PSTTOK');
  FUsuario := fCfgSis('PSTUSE');
  FUrlFornecedor := fCfgSis('PSTEPF');
  FUrlContacaoProcessada := fCfgSis('PSTCCO');
  FUrlCotacao := fcfgSis('PSTURL');
  FblnConsultaPitStop := AblnConsultaPitStop;
  If FblnConsultaPitStop Then
    PitStopLog := TPitStopLog.Create(ParamStr(2));
end;

destructor TRedePitStopBase.Destroy;
begin
  FreeAndNil(raHTTPBasicAuthenticator);
  FreeAndNil(raRESTResponse);
  FreeAndNil(raRESTRequest);
  FreeAndNil(raRESTClient);
  If FblnConsultaPitStop Then
    FreeAndNil(PitStopLog);

  inherited;
end;

function TRedePitStopBase.fExecute(ATipoRedePitStopCallApi: TipoRedePitStopCallApi;
  var AParamns: TBaseParamApi; Ret: TProc<TBaseParamApi>; var AFalha: string): String;
  var JsonEnvio: String;
      lProcesso: String;

begin
  AParamns.RetornoApi.Sucess := False;
  AParamns.RetornoApi.Falha := '';
  AFalha := '';
  Try
    FToken := fGetToken(AFalha);
    If AFalha <> '' Then
    Begin
      If AFalha = psUsuarioNaoEncotrado Then
        Raise Exception.Create('Usuário não encotrado, verifique a configuração [CFG_PSTUSE]!')
      Else If AFalha = psFalhaAutenticacao Then
        Raise Exception.Create('Falha na autenticação: Verifique as configurações se estiverem corretas, entre em contato com a Pit Stop !')
      Else
        Raise Exception.Create('API PitStop: Token não definido! Falha Relatada: ' + AFalha);
    End;
    lProcesso := '';

    If FToken = '' Then
      Raise Exception.Create('API PitStop: Token não definido! Falha Relatada: ');

    case ATipoRedePitStopCallApi of
      trpitLista: Begin
                    If TParamLista(AParamns).PitStopTipoConsulta = pstcBalcao then
                       raRESTRequest.Method := rmGet
                    Else
                       raRESTRequest.Method := rmPost;
                  End;
      trpitFornecedores,
      trpitBuscaCotacao: raRESTRequest.Method := rmGet;
      trpiCancelaCotacao: raRESTRequest.Method := rmPost;
    End;

    JsonEnvio := AParamns.JsonEnvioBody;
    case ATipoRedePitStopCallApi of
      trpiCancelaCotacao : Begin
                             raRESTClient.BaseURL := FUrlCotacao + '?token={token}&conexao={conexao}';
                             raRESTClient.Params.ParameterByName('token').Value := FToken;
                             raRESTClient.Params.ParameterByName('conexao').Value := 'conexao-citel';
                             pSetaParametroJsonBody(JsonEnvio, False, '');
                             lProcesso := 'CancelaCotacao';
                           End;
      trpitLista: begin
                    If (TParamLista(AParamns).PitStopTipoConsulta = pstcBalcao) Then
                    Begin
                      raRESTClient.BaseURL :=FUrlBalcao;
                      raRESTClient.BaseURL := raRESTClient.BaseURL + '?token={token}&dados={dados}&conexao={conexao}';
                      raRESTClient.Params.ParameterByName('conexao').Value := 'conexao-citel';
                      raRESTClient.Params.ParameterByName('token').Value := FToken;
                      raRESTClient.Params.ParameterByName('dados').Value := JsonEnvio;
                      lProcesso := 'Balcao';
                    End
                    Else
                    begin
                      raRESTClient.BaseURL := FUrlCotacao + '?token={token}&conexao={conexao}';
                      raRESTClient.Params.ParameterByName('token').Value := FToken;
                      raRESTClient.Params.ParameterByName('conexao').Value := 'conexao-citel';
                      pSetaParametroJsonBody(JsonEnvio, False, '');
                      lProcesso := 'Cotacao';
                    End;
                  End;
      trpitFornecedores : begin
                            raRESTClient.BaseURL :=  FUrlFornecedor + '?token={token}&cnpj={cnpj}&conexao={conexao}';
                            raRESTClient.Params.ParameterByName('token').Value := FToken;
                            If TParamFornecedoresPitStop(AParamns).EmpresaCNPJ  = '' Then
                              TParamFornecedoresPitStop(AParamns).EmpresaCNPJ := '12345678911564';
                            raRESTClient.Params.ParameterByName('cnpj').Value := TParamFornecedoresPitStop(AParamns).EmpresaCNPJ;
                            raRESTClient.Params.ParameterByName('conexao').Value := 'conexao-citel';
                          End;
      trpitBuscaCotacao: Begin
                          raRESTClient.BaseURL := FUrlContacaoProcessada + '?token={token}&id_cotacao={id_cotacao}&pagina={pagina}&conexao={conexao}';
                          raRESTClient.Params.ParameterByName('conexao').Value := 'conexao-citel';
                          raRESTClient.Params.ParameterByName('token').Value := FToken;
                          raRESTClient.Params.ParameterByName('id_cotacao').Value := TParamBuscaCotacao(AParamns).idConsulta;
                          raRESTClient.Params.ParameterByName('pagina').Value := TParamBuscaCotacao(AParamns).pagina.ToString;

                         End;
    end;

    case ATipoRedePitStopCallApi of
      trpitFornecedores : lProcesso := 'Fornecedores';
      trpitBuscaCotacao : lProcesso := 'BuscaCotacao';
    End;

    FInicioComunicacao := fNow;
    raRESTRequest.Execute;
    FFimComunicacao    := fNow;

    TempoComunicacao := FFimComunicacao  - FInicioComunicacao;

    AParamns.RetornoApi.StatusCode := raRESTResponse.StatusCode;
    AParamns.RetornoApi.Retorno := raRESTResponse.Content;
    AParamns.RetornoApi.Sucess := AParamns.RetornoApi.StatusCode = 200;


    If Assigned(Ret) Then
      Ret(AParamns);
    If Not AParamns.RetornoApi.Sucess Then
      AFalha := AParamns.RetornoApi.Falha;
  Except
    on e:Exception do
    Begin
      If Not FblnConsultaPitStop Then
        pMensagensErro(e.message, '[TRedePitStopBase.fExecute]');
      AFalha := e.message;
      AParamns.RetornoApi.Sucess := False;
    End;
  End;
end;

function TRedePitStopBase.fGetToken(Var AFalha: string): String;
var lBaseParamApi: TParamToken;

begin
  Try
    lBaseParamApi := TParamToken.Create;
    Try
      raRESTRequest.Method := rmGet;
      raRESTClient.BaseURL := FUrlToken +'?usuario={usuario}&conexao={conexao}';
      raRESTClient.Params.ParameterByName('usuario').Value := FUsuario;
      raRESTClient.Params.ParameterByName('conexao').Value := 'conexao-citel';
      raRESTRequest.Execute;
      lBaseParamApi.RetornoApi.Retorno := raRESTResponse.Content;
      lBaseParamApi.fProcessaRetono;
      Result := '';
      If raRESTResponse.StatusCode = 200 Then
        Result := lBaseParamApi.Token
      Else
      Begin
        Result := '';
        AFalha := lBaseParamApi.RetornoApi.Falha;
      End
    Finally
      FreeAndNil(lBaseParamApi)
    End;
  Except
    on e: Exception do
      AFalha := e.message;
  End;
end;



procedure TRedePitStopBase.pCriaRestClient;
begin
  Try
    raRESTClient := TRESTClient.Create('');
    raRESTClient.Authenticator := raHTTPBasicAuthenticator;
    raRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    raRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
    raRESTClient.BaseURL := 'http://189.20.74.72:18080/main/webhook/citel';
    raRESTClient.Params.Clear;
    raRESTClient.HandleRedirects := True;
    raRESTClient.RaiseExceptionOn500 := False;
    raRESTClient.SynchronizedEvents := False;
  Except
    on e: Exception do
    begin
      Showmessage(e.message);
    End;
  End;
end;

procedure TRedePitStopBase.pCriaRestRequest;
begin
  raRESTRequest := TRESTRequest.Create(nil);
  raRESTRequest.Client := raRESTClient;
  raRESTRequest.Response := raRESTResponse;
  raRESTRequest.SynchronizedEvents := False;
end;


procedure TRedePitStopBase.pSetaParametroJsonBody(AJson: String; Header: Boolean; Name: String);
begin
  If AJson.IsEmpty Then
    Exit;


  If Header Then
    raRESTRequest.Params.AddItem.Kind  := pkHTTPHEADER
  Else
    raRESTRequest.Params.AddItem.Kind  := pkREQUESTBODY;

  raRESTRequest.Params[raRESTRequest.Params.Count -1].name := Name;
  raRESTRequest.Params[raRESTRequest.Params.Count -1].Value := AJson;
  raRESTRequest.Params[raRESTRequest.Params.Count -1].ContentType := ctAPPLICATION_JSON;
end;

end.
