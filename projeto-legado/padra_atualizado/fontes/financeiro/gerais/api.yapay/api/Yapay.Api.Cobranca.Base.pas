unit Yapay.Api.Cobranca.Base;

interface

uses
  RTTI,
  System.JSON,
  System.SysUtils,
  System.DateUtils,
  Yapay.Api.Helpers,
  Yapay.Api.Core,
  Yapay.Api.Conexao,
  Yapay.Api.ErrorResponse,
  Yapay.Api.Tabela.Tabela3.FormasDePagamento;

type
{$M+}
  TYapayApiTipoRespostaCobranca = (Sucesso, Erro);

  TYapayApiRespostaBase = class abstract
  protected
    FTipoResposta: TYapayApiTipoRespostaCobranca;
  published
    property TipoResposta: TYapayApiTipoRespostaCobranca read FTipoResposta;
  end;

  TYapayApiRespostaBaseComSucesso = class abstract(TYapayApiRespostaBase)
  protected
    FAvailable_payment_methods: TListFormasDePagamento;
    FPayment_link: string;
    FCode: string;
    FCreated_at: int64;
    FResource: string;
    FMax_split_transaction: int64;
    Fid: int64;
    FStatus: Boolean;
    FDescription: string;
    FOrder_number: string;
    FValue: double;
  published
    property Resource: string read FResource;
    property Id: int64 read Fid;
    property Order_number: string read FOrder_number;
    property Code: string read FCode;
    property Value: double read FValue;
    property Description: string read FDescription;
    property Max_split_transaction: int64 read FMax_split_transaction;
    property Available_payment_methods: TListFormasDePagamento read FAvailable_payment_methods;
    property Payment_link: string read FPayment_link;
    property Status: Boolean read FStatus;
    property Created_at: int64 read FCreated_at;
  public
    constructor Create; reintroduce; virtual;
  end;

  TErrors = TGeneralErrors;

  TYapayApiRespostaBaseComErro = class(TYapayApiRespostaBase)
  strict private
    FErrors: TErrors;
  published
    property Errors: TErrors read FErrors;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

  TYapayApiTabelaParametrosBase = class abstract
  private
    FAccess_token: string;
  published
    property Access_token: string read FAccess_token;
  end;

  TYapayApiCobrancaBase<TTabelaParametros: TYapayApiTabelaParametrosBase; TRespostaSucesso: TYapayApiRespostaBaseComSucesso> = class abstract
  strict private
    FConexao: TYapayApiConexao;
    FTabelaParametros: TTabelaParametros;
    FJSONEnvio: string;
    FJSONRetorno: string;

    function ProcessaRetorno: Boolean;
    procedure ProcessaErro;
  strict protected
    FResposta: TYapayApiRespostaBase;
    FCore: TYapayApiCore;
    FMetodo: TYapayApiCoreMetodo;
    FJSONRequest: TJSONObject;
    function GetEndereco: string; virtual; abstract;
    procedure ProcessaSucesso; virtual;
    procedure ProcessaJSONSucesso(const psJSON: string; out poResposta: TYapayApiRespostaBaseComSucesso);
  published
    property Conexao: TYapayApiConexao read FConexao write FConexao;
    property Metodo: TYapayApiCoreMetodo read FMetodo;
    property TabelaParametros: TTabelaParametros read FTabelaParametros;
    property Resposta: TYapayApiRespostaBase read FResposta;
    property JSONEnvio: string read FJSONEnvio;
    property JSONRetorno: string read FJSONRetorno;
    property Endereco: string read GetEndereco;
  public
    function Enviar: Boolean; virtual;
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
  end;
{$M-}

implementation

{ TYapayApiCobranca<TTabelaParametros, TResposta> }

constructor TYapayApiCobrancaBase<TTabelaParametros, TRespostaSucesso>.Create;
var
  Contexto: TRttiContext;
begin
  inherited;
  FTabelaParametros := Contexto.GetType(TClass(TTabelaParametros)).GetMethod('Create').Invoke(TClass(TTabelaParametros), []).AsType<TTabelaParametros>;
end;

destructor TYapayApiCobrancaBase<TTabelaParametros, TRespostaSucesso>.Destroy;
begin
  if Assigned(FResposta) then
    FreeAndNil(FResposta);

  if Assigned(FTabelaParametros) then
    FreeAndNil(FTabelaParametros);

  inherited;
end;

function TYapayApiCobrancaBase<TTabelaParametros, TRespostaSucesso>.Enviar: Boolean;
begin
  TabelaParametros.FAccess_token := Self.Conexao.Token.Data_Response.Authorization.Access_Token;
  FCore := TYapayApiCore.Create;
  try
    FCore.Metodo := FMetodo;
    FCore.Debug := Self.Conexao.Debug;
    FCore.Log := Self.Conexao.Log;
    FCore.BaseURL := GetEndereco;
    FCore.Access_Token := TabelaParametros.FAccess_token;

    if Assigned(FJSONRequest) then
      FCore.JSONEnvio := FJSONRequest.ToJSON;

    FCore.Execute;
    FJSONEnvio := FCore.JSONEnvio;
    FJSONRetorno := FCore.JSONRetorno;
    Result := ProcessaRetorno;
  finally
    if Assigned(FCore) then
      FreeAndNil(FCore);
  end;
end;

procedure TYapayApiCobrancaBase<TTabelaParametros, TRespostaSucesso>.ProcessaJSONSucesso(const psJSON: string; out poResposta: TYapayApiRespostaBaseComSucesso);
var
  oJSONObj, oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
  oJSONArray: TJSONArray;
  Contexto: TRttiContext;
  sDecimalSeparator: Char;
begin
  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(psJSON) as TJSONObject;
    oJSONValue := oJSONObj.Get('resource').JsonValue;
    poResposta.FResource := oJSONValue.Value;

    oJSONValue := oJSONObj.Get('id').JsonValue;
    poResposta.Fid := StrToInt64Def(oJSONValue.Value, 0);

    oJSONValue := oJSONObj.Get('order_number').JsonValue;
    poResposta.FOrder_number := oJSONValue.Value;

    oJSONValue := oJSONObj.Get('code').JsonValue;
    poResposta.FCode := oJSONValue.Value;

    oJSONValue := oJSONObj.Get('value').JsonValue;
    sDecimalSeparator := FormatSettings.DecimalSeparator;
    FormatSettings.DecimalSeparator := '.';
    poResposta.FValue := StrToFloat(oJSONValue.Value);
    FormatSettings.DecimalSeparator := sDecimalSeparator;

    oJSONValue := oJSONObj.Get('description').JsonValue;
    poResposta.FDescription := oJSONValue.Value;

    oJSONValue := oJSONObj.Get('max_split_transaction').JsonValue;
    poResposta.FMax_split_transaction := StrToInt64Def(oJSONValue.Value, 0);

    oJSONValue := oJSONObj.Get('available_payment_methods').JsonValue;
    poResposta.FAvailable_payment_methods := TListFormasDePagamento.FromString(oJSONValue.Value);

    oJSONValue := oJSONObj.Get('payment_link').JsonValue;
    poResposta.FPayment_link := oJSONValue.Value;

    oJSONValue := oJSONObj.Get('status').JsonValue;
    poResposta.FStatus := StrToBool(oJSONValue.Value);

    oJSONValue := oJSONObj.Get('created_at').JsonValue;
    poResposta.FCreated_at := StrToInt64(oJSONValue.Value);

  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

procedure TYapayApiCobrancaBase<TTabelaParametros, TRespostaSucesso>.ProcessaSucesso;
var
  oJSONObj, oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
  Contexto: TRttiContext;
begin
  if Assigned(FResposta) then
    FreeAndNil(FResposta);

  FResposta := Contexto.GetType(TClass(TRespostaSucesso)).GetMethod('Create').Invoke(TClass(TRespostaSucesso), []).AsType<TRespostaSucesso>;
  FResposta.FTipoResposta := Sucesso;

  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;

    oJSONValue := oJSONObj.Get('resource').JsonValue;
    TYapayApiRespostaBaseComSucesso(FResposta).FResource := oJSONValue.Value;

    if CompareText(TYapayApiRespostaBaseComSucesso(FResposta).FResource, 'charge') <> 0 then
      exit;

    ProcessaJSONSucesso(FCore.JSONRetorno, TYapayApiRespostaBaseComSucesso(FResposta));

  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

procedure TYapayApiCobrancaBase<TTabelaParametros, TRespostaSucesso>.ProcessaErro;
var
  oJSONObj, oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
  oJSONArray: TJSONArray;
  i: integer;
  oGeneralError: TGeneralError;
begin
  if Assigned(FResposta) then
    FreeAndNil(FResposta);
  FResposta := TYapayApiRespostaBaseComErro.Create;
  FResposta.FTipoResposta := Erro;

  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;
    oJSONValue := oJSONObj.Get('errors').JsonValue;
    oJSONArray := oJSONValue as TJSONArray;
    for I := 0 to oJSONArray.Count - 1 do
    begin
      oGeneralError := TGeneralError.Create;
      oJSONValue := oJSONArray.Items[i];
      oJSONSubObj := oJSONValue as TJSONObject;

      oJSONValue := oJSONSubObj.Get('code').JsonValue;
      oGeneralError.Code := oJSONValue.Value;

      oJSONValue := oJSONSubObj.Get('message').JsonValue;
      oGeneralError.Message := oJSONValue.Value;

      TYapayApiRespostaBaseComErro(FResposta).Errors.Add(oGeneralError);
    end;
  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

function TYapayApiCobrancaBase<TTabelaParametros, TRespostaSucesso>.ProcessaRetorno: Boolean;
var
  oJSONObj: TJSONObject;
  oJSONValue: TJSONValue;
begin
  Result := False;
  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;
    if oJSONObj.TryGetValue<TJSONValue>('errors', oJSONValue) then
      ProcessaErro
    else if oJSONObj.TryGetValue<TJSONValue>('resource', oJSONValue) then
    begin
      ProcessaSucesso;
      Result := True;
    end;
  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

{ TYapayApiRespostaBaseComErro }

constructor TYapayApiRespostaBaseComErro.Create;
begin
  inherited;
  FTipoResposta := Erro;
  FErrors := TErrors.Create;
end;

destructor TYapayApiRespostaBaseComErro.Destroy;
begin
  if Assigned(FErrors) then
    FreeAndNil(FErrors);
  inherited;
end;

{ TYapayApiRespostaBaseComSucesso }

constructor TYapayApiRespostaBaseComSucesso.Create;
begin
  inherited;
  FTipoResposta := Sucesso;
end;


end.
