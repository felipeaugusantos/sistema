unit Correios.Controller;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Correios.Classes;

type
  TTipoAutenticacao = (taNone, taBasic, taOAuth);

  THttpResponse = record
    Code: Integer;
    Status: String;
    Content: String;
  end;

  TApiBase = class
  protected
    FHttpResult: THttpResponse;
    function GetUrlBase: String;
    function GetMsgErro: String;
    procedure Communicate(const AUrl, AMetodo: String;
                          const ABody: String = '';
                          const ATipoAuth: TTipoAutenticacao = taOAuth);
  end;

  TTokenCorreios = class(TApiBase)
  private
    FToken: String;
    FEmissao: TDateTime;
    FExpiraEm: TDateTime;
    procedure AtualizaToken;
  public
    constructor Create;
    function GetToken: String;
  end;

  TConsultaCepApi = class(TApiBase)
  private
    FCep: String;
    FCidade: String;
    FEndereco: String;
    FBairro: String;
    FEstado: String;
  public
    property Cep: String read FCep write FCep;
    property Cidade: String read FCidade write FCidade;
    property Endereco: String read FEndereco write FEndereco;
    property Bairro: String read FBairro write FBairro;
    property Estado: String read FEstado write FEstado;

    function ConsultaCep: Boolean;
  end;

  TServicosContratoApi = class(TApiBase)
  private
    FNumContrato: String;
    FNumCartao: String;
    FHomologacao: Boolean;
  public
    property NumContrato: String read FNumContrato write FNumContrato;
    property NumCartao: String read FNumCartao write FNumCartao;
    property Homologacao: Boolean read FHomologacao write FHomologacao;

    function ConsultaServicos: TArray<TServicoContratoCliente>;
  end;

  TPrePostagemApi = class(TApiBase)
  private
    FJsonEnv: String;
    FJsonRet: String;
    FIdPostagem: String;
    FCodObjeto: String;
  public
    property JsonEnv: String read FJsonEnv write FJsonEnv;
    property JsonRet: String read FJsonRet write FJsonRet;
    property IdPostagem: String read FIdPostagem write FIdPostagem;
    property CodObjeto: String read FCodObjeto write FCodObjeto;

    function EnviaPrePostagem: Boolean;
  end;

implementation

uses
  Correios.Constantes,
  Correios.Funcoes,
  Correios.Rest;

{ TApiBase }

procedure TApiBase.Communicate(const AUrl, AMetodo: String;
                               const ABody: String = '';
                               const ATipoAuth: TTipoAutenticacao = taOAuth);
  var
    LPathDll: String;
    LobjRest: ICorreiosREST;
begin
  FillChar(FHttpResult, SizeOf(FHttpResult), #0);

  LPathDll := ExtractFilePath(ParamStr(0)) + 'synapse.dll';

  if FileExists(LPathDll) then
    LobjRest := TCorreiosREST_dll.Create(LPathDll)
  else
    LobjRest := TCorreiosREST_def.Create;

  try
    case ATipoAuth of
      taBasic: LobjRest.SetBasicAuth;
      taOAuth: LobjRest.SetBearerAuth;
    end;

    FHttpResult := LobjRest.Execute(AUrl, AMetodo, ABody);
  except
    raise;
  end;
end;

function TApiBase.GetMsgErro: String;
  var
    LobjError: TApiError;
begin
  if FHttpResult.Content.IsEmpty then
    Exit(FHttpResult.Status);

  Result := LeftStr(FHttpResult.Content, 200);

  try
    LobjError := TApiError.FromJsonString(FHttpResult.Content);

    if Length(LobjError.msgs) > 0 then
      if not LobjError.msgs[0].IsEmpty then
        Exit(LobjError.msgs[0]);

    if not LobjError.causa.IsEmpty then
      Result := LobjError.causa;

    LobjError.Free;
  except
  end;
end;

function TApiBase.GetUrlBase: String;
begin
  if VS_blnHomolo then
    Result := URL_HOMOLOGACAO
  else
    Result := URL_PRODUCAO;
end;

{ TTokenCorreios }

procedure TTokenCorreios.AtualizaToken;
  var
    LRequest: String;
    LobjToken: TApiToken;
begin
  try
    LRequest := '{"numero": "'+ VS_strNumCar +'"}';

    Communicate(GetUrlBase + REQ_TOKEN, 'POST', LRequest, taBasic);

    if FHttpResult.Code <> STATUS_CREATED then
      raise Exception.Create(GetMsgErro);

    LobjToken := TApiToken.FromJsonString(FHttpResult.Content);

    FToken    := LobjToken.token;
    FEmissao  := LobjToken.emissao;
    FExpiraEm := LobjToken.expiraEm;

    LobjToken.Free;

    StartTransaction;

    if not FToken.IsEmpty then
      AtuCfgSigep('TOKEN_', FToken);

    if FEmissao > 0 then
      AtuCfgSigep('DTATKN', FormatDateTime('yyyy-mm-dd hh:nn:ss', FEmissao));

    if FExpiraEm > 0 then
      AtuCfgSigep('EXPTKN', FormatDateTime('yyyy-mm-dd hh:nn:ss', FExpiraEm));

    Commit;
  except
    on E: Exception do
    begin
      Rollback;
      if FHttpResult.Code = 401 then
        raise Exception.CreateFmt('Credenciais de autenticação incorretas. Tente novamente!'+ sLineBreak +
                                  'Verifique o usuário e o código de acesso API junto aos Correios.' + sLineBreak +
                                  'Status: %d: %s', [FHttpResult.Code, E.Message])
      else
        raise Exception.CreateFmt('Erro ao obter o token (status: %d): %s', [FHttpResult.Code, E.Message]);
    end;
  end;
end;

constructor TTokenCorreios.Create;
begin
  FToken    := GetCfgSigep('TOKEN_');
  FEmissao  := StrToDateTimeDef(GetCfgSigep('DTATKN'), 0);
  FExpiraEm := StrToDateTimeDef(GetCfgSigep('EXPTKN'), 0);
end;

function TTokenCorreios.GetToken: String;
begin
  if Now > FExpiraEm then
    AtualizaToken;

  Result := FToken;
end;

{ TConsultaCepApi }

function TConsultaCepApi.ConsultaCep: Boolean;
  var
    LobjCep: TApiCEP;
    LMsgErro: String;
begin
  try
    Communicate(GetUrlBase + REQ_CEP + FCep, 'GET');

    Result := (FHttpResult.Code = STATUS_OK);

    if not Result then
    begin
      LMsgErro := GetMsgErro;

      if LMsgErro.Contains(FCep +' não foi encontrado') then
        Exit;

      raise Exception.Create(LMsgErro);
    end;

    LobjCep := TApiCEP.FromJsonString(FHttpResult.Content);

    FCidade   := LobjCep.localidade;
    FEndereco := LobjCep.logradouro;
    FBairro   := LobjCep.bairro;
    FEstado   := LobjCep.uf;

    LobjCep.Free;
  except
    raise;
  end;
end;

{ TServicosContratoApi }

function TServicosContratoApi.ConsultaServicos: TArray<TServicoContratoCliente>;
  var
    LobjServicos: TServicosContratoCliente;
    LCnpj: String;
begin
  Result := [];
  try
    LCnpj := GetCfgSis('CGCPLP').Trim;

    if LCnpj.IsEmpty then
      LCnpj := GetCGCEmpresa(VS_strCodEmp);

    Communicate(IfThen(FHomologacao, URL_HOMOLOGACAO, URL_PRODUCAO) +
                Format(REQ_SERVICOS, [LCnpj, FNumContrato, FNumCartao]),
                'GET');

    if FHttpResult.Code <> STATUS_OK then
      raise Exception.Create(GetMsgErro);

    LobjServicos := TServicosContratoCliente.FromJsonString(FHttpResult.Content);

    Result := LobjServicos.itens;

    LobjServicos.Free;
  except
    raise;
  end;
end;

{ TPrePostagemApi }

function TPrePostagemApi.EnviaPrePostagem: Boolean;
  var
    LobjPostagem: TPrePostagemResponse;
begin
  try
    FJsonRet    := EmptyStr;
    FIdPostagem := EmptyStr;
    FCodObjeto  := EmptyStr;

    Communicate(GetUrlBase + REQ_PLP, 'POST', FJsonEnv);

    Result := (FHttpResult.Code = STATUS_OK);

    if not Result then
      raise Exception.Create(GetMsgErro);

    LobjPostagem := TPrePostagemResponse.FromJsonString(FHttpResult.Content);

    FJsonRet    := FHttpResult.Content;
    FIdPostagem := LobjPostagem.id;
    FCodObjeto  := LobjPostagem.codigoObjeto;

    LobjPostagem.Free;
  except
    raise;
  end;
end;

end.
