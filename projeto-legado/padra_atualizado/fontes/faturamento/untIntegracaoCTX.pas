unit untIntegracaoCTX;

interface

uses
  untInterSistemaEstacionamento, System.Classes, REST.Client, Rest.Types,
  REST.Authenticator.Basic, System.JSON, System.SysUtils;

type
  TIntegracaoCTX = class(TInterfacedObject, ISistemaEstacionamento)
  private
    objClient: TRESTClient;
    objRequest: TRESTRequest;
    objResponse: TRESTResponse;
    objDadosDeEnvio: TStringStream;
    objParamRequest: TRESTRequestParameter;
    objAutenticacao: THTTPBasicAuthenticator;
    strPathAPI: String;

    function fMensagemCodigoDeRetorno: String;
    function fMensagemRetorno: String;
    procedure pPreencheAutenticacao;
    procedure pPreencheClientLiberacaoTicket;
    procedure pPreencheRequestLiberacaoTicket;
    procedure pPreencheDadosLiberacaoTicket(strTicket, strCodOpe: String);
    procedure pMontaRequisicaoDeLiberacaoTicket(strNumTicket: String);
    procedure pEnviaRequisicao(Var strMsgRetorno: String);
  public
    constructor Create;
    function fSolicitaLiberacaoDeTicket(strNumTicket: String; Var strMsgRetorno: String): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

{ TIntegracaoCTX }

constructor TIntegracaoCTX.Create;
begin
  objAutenticacao := THTTPBasicAuthenticator.Create('','');
  objClient := TRESTClient.Create(nil);
  objResponse := TRESTResponse.Create(nil);
  objRequest := TRESTRequest.Create(nil);
  strPathAPI := fCfgSis('PATCTX', varString)
end;

function TIntegracaoCTX.fSolicitaLiberacaoDeTicket(strNumTicket: String;
  var strMsgRetorno: String): Boolean;
begin
  pMontaRequisicaoDeLiberacaoTicket(strNumTicket);
  pEnviaRequisicao(strMsgRetorno);
  Result := fEmptyStr(strMsgRetorno);
end;

procedure TIntegracaoCTX.pMontaRequisicaoDeLiberacaoTicket(strNumTicket: String);
begin
  pPreencheAutenticacao;
  pPreencheClientLiberacaoTicket;
  pPreencheRequestLiberacaoTicket;
  pPreencheDadosLiberacaoTicket(strNumTicket, strLoginUsuarioLogado);
end;

procedure TIntegracaoCTX.pEnviaRequisicao(Var strMsgRetorno: String);
begin
  objRequest.Execute;
  strMsgRetorno := fMensagemRetorno;
end;

procedure TIntegracaoCTX.pPreencheAutenticacao;
begin
  objAutenticacao.Username := fCfgSis('LOGCTX', varString);
  objAutenticacao.Password := fCfgSis('SENCTX', varString);
end;

procedure TIntegracaoCTX.pPreencheClientLiberacaoTicket;
  Const
    URL_LIB = '/ticket/liberar';
begin
  objClient.Authenticator := objAutenticacao;
  objClient.ContentType := 'application/x-www-form-urlencoded';
  objClient.BaseURL := strPathAPI + URL_LIB;
end;

procedure TIntegracaoCTX.pPreencheRequestLiberacaoTicket;
begin
  objRequest.Client := objClient;
  objRequest.Method := TRESTRequestMethod.rmPOST;
  objRequest.Response := objResponse;
end;

procedure TIntegracaoCTX.pPreencheDadosLiberacaoTicket(strTicket, strCodOpe: String);
  Var
    strDados: String;
begin
  strDados := 'ticket=' + strTicket + '&identificador=' + strCodOpe;

  objDadosDeEnvio := TStringStream.Create(strDados, TEncoding.UTF8);
  objParamRequest := objRequest.Params.AddItem();
  objParamRequest.Value := objDadosDeEnvio.DataString;
  objParamRequest.Kind := pkREQUESTBODY;
  objParamRequest.name := 'body';
  objParamRequest.Options := [poDoNotEncode];
  objParamRequest.ContentType := ctAPPLICATION_X_WWW_FORM_URLENCODED;
end;

function TIntegracaoCTX.fMensagemCodigoDeRetorno: String;
begin
  Case objResponse.StatusCode Of
    404: Result := 'URL de integração inválida.';
    403: Result := 'Dados de autenticação inválidos.'+#13+
                   'Verifique as configurações "CFG_LOGCTX" e "CFG_SENCTX".';
  End;
end;

function TIntegracaoCTX.fMensagemRetorno: String;
  Var
    strMensagem: String;
    objJSON: TJSONObject;
begin
  If (objResponse.StatusCode <> 200) Then
    strMensagem := fMensagemCodigoDeRetorno
  Else
  Begin
    If (pos('true', objResponse.JSONText) <= 0) Then
    Begin
      objJSON := TJSONObject.ParseJSONValue(objResponse.JSONText) As TJSONObject;
      strMensagem := objJSON.GetValue<string>('mensagem');
    End;
  End;

  Result := strMensagem;
end;

end.
