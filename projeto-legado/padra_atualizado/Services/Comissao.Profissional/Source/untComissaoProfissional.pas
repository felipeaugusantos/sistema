unit untComissaoProfissional;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, Data.DB,
  System.JSON, strUtils, Math, System.DateUtils, REST.Authenticator.OAuth,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types, Services.Core.Task.Monitor;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni;
  {$ENDIF LINUX}

type
  TRetornoAuthenticacao = class
    private
      FAuth: Boolean;
      FToken: String;

      class function FromJsonString(AJsonString: string): TRetornoAuthenticacao;
    public
      property auth: Boolean read FAuth write FAuth;
      property token: String read FToken write FToken;
  end;

  TAuthenticacao = class
    private
      FEmail: String;
      FPassword: String;

      function ToJsonString: String;
      class function fRetToken: String;
    public
      property email: String read FEmail write FEmail;
      property password: String read FPassword write FPassword;
  end;

  TComissaoProfissional = class
    private
      FCpf: String;
      FValor: String;

      function ToJsonString: String;
    public
      property cpf: String read FCpf write FCpf;
      property valor: String read FValor write FValor;

      function fEnviaComissao: Boolean;
  end;

  TComissaoProfissionalService = class sealed(TInterfacedObject,
    ITaskMonitorProcedure)
  private
    procedure pEnviaComissaoProfissional;
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
  end;

implementation

{ TComissaoProfissionalService }

uses untRestApi, untComissaoProfissionalRestApi,
  untComissaoProfissionalAutenticacaoRestApi;

function TComissaoProfissionalService.fExecute: TResultExecute;
begin

end;

procedure TComissaoProfissionalService.pExecuteAll;
begin
  if not fCfgSis('UTICMP', varBoolean) then
    Exit;

  pExecute;
end;

procedure TComissaoProfissionalService.pExecute;
begin
  pEnviaComissaoProfissional;
end;

procedure TComissaoProfissionalService.pEnviaComissaoProfissional;
const
  QTD_ENVIOS = 2;
var
  qryComPro: IQuery;
  qryAux: IQuery;
  ComissaoProfissional: TComissaoProfissional;
  intCount: Integer;
begin
  qryComPro := fCriaQuery;
  qryComPro.Close;
  qryComPro.SQL.Text :=
  ' SELECT '+
  '   CADDIV.AUTOINCREM, '+
  '   CADDIV.DIV_C_G_C_, '+
  '   CADDIV.DIV_DTHINT, '+
  '   CURRENT_TIMESTAMP AS DATAHORA_ATUAL, '+
  '   CURRENT_DATE AS DATA_ATUAL, '+
  '   SUM( '+
  '       CASE '+
  '           WHEN COMISSOES.COM_CREDEB = "C" THEN COMISSOES.COM_VRCOMI '+
  '           WHEN COMISSOES.COM_CREDEB = "D" THEN -COMISSOES.COM_VRCOMI '+
  '           ELSE 0 '+
  '       END '+
  '   ) AS VRCOMI '+
  ' FROM COMPRO COMISSOES '+
  ' INNER JOIN CADDIV '+
  '     ON COMISSOES.COM_CODPRO = CADDIV.DIV_CODDIV '+
  ' WHERE '+
  '     COMISSOES.COM_DTABAI IS NULL '+
  ' GROUP BY '+
  '     CADDIV.DIV_C_G_C_ ';

  qryComPro.Open;

  for intCount := 0 to QTD_ENVIOS-1 do
  begin
    if (qryComPro.FieldByName('DATAHORA_ATUAL').AsDateTime) < (StrToDateTime(qryComPro.FieldByName('DATA_ATUAL').AsString+' '+fCfgSis('CMPHR'+IntToStr(intCount+1)))) then
      Continue;

    while not qryComPro.Eof do
    begin
      if (StrToDateTime(qryComPro.FieldByName('DATA_ATUAL').AsString+' '+fCfgSis('CMPHR'+IntToStr(intCount+1)))) <= (qryComPro.FieldByName('DIV_DTHINT').AsDateTime) then
      begin
        qryComPro.Next;
        Continue;
      end;

      ComissaoProfissional := TComissaoProfissional.Create;
      try
        ComissaoProfissional.cpf := AdicionarMascaraCpfCnpj(qryComPro.FieldByName('DIV_C_G_C_').AsString);
        ComissaoProfissional.valor := fTiraCaracEspeciais(FormatFloat( '#,##0.00' , qryComPro.FieldByName('VRCOMI').AsFloat), False, False, False, False, False, True, False, '.,');
        if ComissaoProfissional.fEnviaComissao then
        begin
          qryAux := fCriaQuery;
          qryAux.Close;
          qryAux.SQL.Text :=
          ' UPDATE '+
          '   CADDIV '+
          ' SET '+
          '   DIV_DTHINT = :DTHINT '+
          ' WHERE '+
          '   AUTOINCREM = :AUTINC ';

          qryAux.ParamByName('DTHINT').AsDateTime := fNow;
          qryAux.ParamByName('AUTINC').AsString   := qryComPro.FieldByName('AUTOINCREM').AsString;
          qryAux.ExecSQL;
        end;

        Sleep(500);
      finally
        FreeAndNil(ComissaoProfissional);
      end;

      qryComPro.Next;
    end;
  end;
end;

{ TRetornoAuthenticacao }

class function TRetornoAuthenticacao.FromJsonString(
  AJsonString: string): TRetornoAuthenticacao;
begin
  result := TJson.JsonToObject<TRetornoAuthenticacao>(AJsonString)
end;

{ TAuthenticacao }

class function TAuthenticacao.fRetToken: String;
var
  Authenticacao: TAuthenticacao;
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := EmptyStr;

  ControllerRest := TControllerRest.Create('COMPRO', TComissaoProfissionalAutenticacaoRestApi.fConfigurarApi);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  Authenticacao := TAuthenticacao.Create;
  try
    Authenticacao.email := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_USUCMP', VS_strCodEmp], True, EmptyStr);
    Authenticacao.password := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_SENCMP', VS_strCodEmp], True, EmptyStr);

    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               Authenticacao.ToJsonString,
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
    begin
      if TRetornoAuthenticacao.FromJsonString(JSONRetorno).auth then
        Result := TRetornoAuthenticacao.FromJsonString(JSONRetorno).token;
    end;
  finally
    RestRequest.Free;
    ControllerRest.Free;
    Authenticacao.Free;
  end;
end;

function TAuthenticacao.ToJsonString: String;
begin
  Result := TJson.ObjectToJsonString(self);
end;

{ TComissaoProfissional }

function TComissaoProfissional.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

function TComissaoProfissional.fEnviaComissao: Boolean;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  LstrToken: String;
  JSONRetorno: String;
begin
  ControllerRest := TControllerRest.Create('COMPRO', TComissaoProfissionalRestApi.fConfigurarApi);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Method := rmPOST;

    LstrToken := TAuthenticacao.fRetToken;
    if fEmptyStr(LstrToken) then
      Exit(False);

    RestRequest.Params.AddItem('x-access-token', LstrToken, pkHTTPHEADER);

    RESTRequest
    .Params
    .AddItem(  '',
               Self.ToJsonString,
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    Result := ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.

