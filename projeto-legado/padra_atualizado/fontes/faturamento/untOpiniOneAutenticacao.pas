unit untOpiniOneAutenticacao;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TOpiniOneAutenticacao = class
  private
    FEmail: String;
    FSenha: String;
  public
    property Email: String read FEmail write FEmail;
    property Senha: String read FSenha write FSenha;
    function ToJsonString: string;
  end;

  TOpiniOneRetornoAutenticacao = class
  private
    FDataExpiracao: String;
    FEmail: String;
    FNomePerfil: String;
    FToken: String;
  public
    property DataExpiracao: String read FDataExpiracao write FDataExpiracao;
    property Email: String read FEmail write FEmail;
    property NomePerfil: String read FNomePerfil write FNomePerfil;
    property Token: String read FToken write FToken;
    class function FromJsonString(AJsonString: string): TOpiniOneRetornoAutenticacao;
  end;

  TControllerOpiniOneAutenticacao = class
  private
    class function fRetAutenticacao(OpiniOneAutenticacao: TOpiniOneAutenticacao): TOpiniOneRetornoAutenticacao;
  public
    class function fRetToken(): String;
  end;

implementation

{TOpiniOneAutenticacao}

uses untOpiniOneRestApi, untRestApi;

function TOpiniOneAutenticacao.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

{TOpiniOneRetornoAutenticacao}

class function TOpiniOneRetornoAutenticacao.FromJsonString(AJsonString: string): TOpiniOneRetornoAutenticacao;
begin
  Result := TJson.JsonToObject<TOpiniOneRetornoAutenticacao>(AJsonString)
end;

{TControllerOpiniOneAutenticacao}

class function TControllerOpiniOneAutenticacao.fRetToken(): String;
var
  OpiniOneAutenticacao: TOpiniOneAutenticacao;
  OpiniOneRetornoAutenticacao: TOpiniOneRetornoAutenticacao;
begin
  Result := EmptyStr;

  OpiniOneAutenticacao := TOpiniOneAutenticacao.Create;
  try
    OpiniOneAutenticacao.Email := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_USUOPI', VS_strCodEmp], True, '');
    OpiniOneAutenticacao.Senha := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_SENOPI', VS_strCodEmp], True, '');

    OpiniOneRetornoAutenticacao := fRetAutenticacao(OpiniOneAutenticacao);
    if Assigned(OpiniOneRetornoAutenticacao) then
      Result := OpiniOneRetornoAutenticacao.Token;
  finally
    FreeAndNil(OpiniOneAutenticacao);
    FreeAndNil(OpiniOneRetornoAutenticacao);
  end;
end;

class function TControllerOpiniOneAutenticacao.fRetAutenticacao(OpiniOneAutenticacao: TOpiniOneAutenticacao): TOpiniOneRetornoAutenticacao;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('OPINIONE', TControllerOpiniOne.fConfigurarOpiniOne);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'autenticacao';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               OpiniOneAutenticacao.ToJsonString,
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TOpiniOneRetornoAutenticacao.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
