unit untTefCitelTransacaoSitefExp;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.StrUtils, System.DateUtils,
  System.Generics.Collections, System.Generics.Defaults,
  REST.Types, REST.Json,REST.Client, REST.Authenticator.Basic, REST.Authenticator.OAuth,
  untTefCitelTransacaoInterfaces, untTefCitelTransacaoSitefExpUtils;

type
  TTransaocaoTefParserSitefExp = class
  private
    class function fJsonStrToDadosLista(const AJson: string): TTransacaoTefDadosLista;
    class function fGetStatus(const AEstado: string): TTransacaoTefStatus;

  public
    class function fCompararTransacoesPorDataHora(const Left, Right: TTransacaoTefDados): Integer;
    class procedure fDateTimeToDataHoraApi(const ADateTime: TDateTime; var AData, AHora: string);
    class function fDataHoraApiToDateTime(const AData, AHora: string): TDateTime;
    class function fJsonToDados(const AJson: string): TTransacaoTefDados;
    class function fJsonToLista(const AJson: string): TTransacaoTefDadosLista;
  end;

  TTransacaoTefRestConfigSitefExp = class
  public
    class function fConfigurarSitefExpress(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

  TTransacaoTefRepositorySitefExp = class(TInterfacedObject, ITransacaoTefRepository)
  private
    FCredController: TSitefExpCredencialController;
    function fEnviarRequisicao(AMethod: TRESTRequestMethod; AResource: string; AStrParams: string; var AStrJson: string): Boolean;
    procedure pAddStrPar(var AStr: string; const AKey, AValue: string);
    procedure pAddParRequest(var ARequest: TRestRequest; AStrPar: string);
    function fErroCredencialInvalida(const AintStatusRet: Integer; const AstrMsgRet: string): Boolean;

  public
    function fBuscarTransacao(AParam: TTransacaoTefBuscaParam): TTransacaoTefDados;
    function fBuscarTransacoesPorData(const ADate: TDate): TTransacaoTefDadosLista;
    function fBuscarTransacoesPendentes(const ADateFrom, ADateTo: TDate): TTransacaoTefDadosLista;
    function fCancelarTransacaoPendente(const ATrn: TTransacaoTefDados): Boolean;
    function fConfirmarTransacaoPendente(const ATrn: TTransacaoTefDados): Boolean;

    class function New: ITransacaoTefRepository;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  untRestApi, untFuncoesSimples;

{ TTransaocaoTefParserSitefExp }

class function TTransaocaoTefParserSitefExp.fCompararTransacoesPorDataHora(
  const Left, Right: TTransacaoTefDados): Integer;
begin
  if Left.DtaHra < Right.DtaHra then
    Result := -1
  else if Left.DtaHra > Right.DtaHra then
    Result := 1
  else
    Result := 0;
end;

class function TTransaocaoTefParserSitefExp.fDataHoraApiToDateTime(const AData,
  AHora: string): TDateTime;
var
  LAno, LMes, LDia, LHora, LMinuto, LSegundo: Word;
begin
  try
    LAno := Copy(AData, 1, 4).ToInteger;
    LMes := Copy(AData, 5, 2).ToInteger;
    LDia := Copy(AData, 7, 2).ToInteger;

    LHora    := Copy(AHora, 1, 2).ToInteger;
    LMinuto  := Copy(AHora, 3, 2).ToInteger;
    LSegundo := Copy(AHora, 5, 2).ToInteger;

    Result := EncodeDateTime(LAno, LMes, LDia, LHora, LMinuto, LSegundo, 0 {ms});
  except
    raise TTrasacaoTefParseException.Create('Erro ao converter Data/Hora da API para TDateTime.');
  end;
end;

class procedure TTransaocaoTefParserSitefExp.fDateTimeToDataHoraApi(
  const ADateTime: TDateTime; var AData, AHora: string);
var
  LAno, LMes, LDia, LHora, LMinuto, LSegundo, LMilisegundo: Word;
begin
  try
    DecodeDateTime(ADateTime, LAno, LMes, LDia, LHora, LMinuto, LSegundo, LMilisegundo);

    AData := fPadL(IntToStr(LAno), 4, '0') + fPadL(IntToStr(LMes), 2, '0') + fPadL(IntToStr(LDia), 2, '0');
    AHora := fPadL(IntToStr(LHora), 2, '0') + fPadL(IntToStr(LMinuto), 2, '0') + fPadL(IntToStr(LSegundo), 2, '0');
  except
    raise TTrasacaoTefParseException.Create('Erro ao converter TDateTime para Data/Hora da API.');
  end;
end;

class function TTransaocaoTefParserSitefExp.fGetStatus(
  const AEstado: string): TTransacaoTefStatus;
begin
  //TTransacaoTefStatus = (stDesconhecido, stPendente, stEstornada, stCancelada, stConfirmada);

  if AEstado.ToUpper.Contains('CONFIRM')then
    Result := stConfirmada
  else
  if AEstado.ToUpper.Contains('PENDEN') or AEstado.ToUpper.Contains('AGUARDANDO') then
    Result := stPendente
  else
  if AEstado.ToUpper.Contains('CANCEL') or AEstado.ToUpper.Contains('NEGADA') then
    Result := stCancelada
  else
  if AEstado.ToUpper.Contains('ESTORN') then
    Result := stCancelada
  else
    Result := stGenerico;
end;

class function TTransaocaoTefParserSitefExp.fJsonStrToDadosLista(
  const AJson: string): TTransacaoTefDadosLista;
var
  LJsonObject: TJsonObject;
  LTransacoesArray: TJsonArray;
  LTransacaoItem: TTransacaoTefDados;
  LintCnt: Integer;
begin
  Result := TList<TTransacaoTefDados>.Create();
  try
    LJsonObject := TJsonObject.ParseJSONValue(AJson)as TJsonObject;
    try
      if not Assigned(LJsonObject.Values['transacoes']) then
        Exit;

      if not(LJsonObject.Values['transacoes'] is TJsonArray) then
        Exit;

      LTransacoesArray := LJsonObject.Values['transacoes'] as TJsonArray;

      if LTransacoesArray.Count <= 0 then
        Exit;

      for LintCnt := 0 to LTransacoesArray.Count - 1 do
      begin
        FillChar(LTransacaoItem,SizeOf(LTransacaoItem),#0);

        LTransacaoItem.DtaHra   := Self.fDataHoraApiToDateTime(
          LTransacoesArray.Items[LintCnt].GetValue<string>('dataTrn'),
          LTransacoesArray.Items[LintCnt].GetValue<string>('horaTrn')
        );
        LTransacaoItem.NumNsu := LTransacoesArray.Items[LintCnt].GetValue<string>('nsuSitef');
        LTransacaoItem.NsuHos := LTransacoesArray.Items[LintCnt].GetValue<string>('nsuHost');
        LTransacaoItem.TipTrn := LTransacoesArray.Items[LintCnt].GetValue<string>('tipo');
        LTransacaoItem.InfTrn := LTransacoesArray.Items[LintCnt].GetValue<string>('infoTransacao');
        LTransacaoItem.Estado := LTransacoesArray.Items[LintCnt].GetValue<string>('estado');
        LTransacaoItem.Status := Self.fGetStatus(LTransacaoItem.Estado);
        try
          LTransacaoItem.ValTrn := LTransacoesArray.Items[LintCnt].GetValue<Double>('valor') / 100;
        except
          LTransacaoItem.ValTrn := 0;
        end;
        try
          LTransacaoItem.CodSit := LTransacoesArray.Items[LintCnt].GetValue<Integer>('codSit').ToString;
        except
          LTransacaoItem.CodSit := '';
        end;
        LTransacaoItem.CodEst := LTransacoesArray.Items[LintCnt].GetValue<string>('codEstabelecimento');
        LTransacaoItem.CodLoj := LTransacoesArray.Items[LintCnt].GetValue<string>('codLojaSitef');
        LTransacaoItem.CodCli := LTransacoesArray.Items[LintCnt].GetValue<string>('codigoCliente');
        LTransacaoItem.NumPdv := LTransacoesArray.Items[LintCnt].GetValue<string>('numPdv');
        try
          LTransacaoItem.QtdPar :=  StrToIntDef(LTransacoesArray.Items[LintCnt].GetValue<string>('numParcelas'), 0);
        except
          LTransacaoItem.QtdPar := 0;
        end;
        LTransacaoItem.CodAut := LTransacoesArray.Items[LintCnt].GetValue<string>('codAutorizacao');
        LTransacaoItem.NomRed := LTransacoesArray.Items[LintCnt].GetValue<string>('descrRede');
        LTransacaoItem.NomBan := LTransacoesArray.Items[LintCnt].GetValue<string>('produto');
        LTransacaoItem.NumCar := LTransacoesArray.Items[LintCnt].GetValue<string>('documento');
        LTransacaoItem.Contro := '';
        LTransacaoItem.Versao := '';

        Result.Add(LTransacaoItem);
      end;

    finally
      FreeAndNil(LJsonObject);
    end;
  except
    if Assigned(Result) then
      Result.Free;

    raise TTrasacaoTefParseException.Create('Erro ao converter resposta da API (json) em objeto.');
  end;
end;

class function TTransaocaoTefParserSitefExp.fJsonToDados(
  const AJson: string): TTransacaoTefDados;
var
  LlstDados: TTransacaoTefDadosLista;
begin
  LlstDados := nil;
  try
    LlstDados := Self.fJsonStrToDadosLista(AJson);

    if LlstDados.Count = 0 then
      raise TTrasacaoTefNotFoundException.Create('Transação não encontrada.');

    Result := LlstDados.First;
  finally
    if Assigned(LlstDados) then
      FreeAndNil(LlstDados);
  end;
end;

class function TTransaocaoTefParserSitefExp.fJsonToLista(
  const AJson: string): TTransacaoTefDadosLista;
begin
  try
    Result := Self.fJsonStrToDadosLista(AJson);

    Result.Sort(TComparer<TTransacaoTefDados>.Construct(fCompararTransacoesPorDataHora));
  except
    if Assigned(Result) then
      FreeAndNil(Result);

    Result := nil;

    raise TTrasacaoTefParseException.Create('Erro ao converter resposta da API (json) em objeto.');
  end;

  Result.Sort();
end;

{ TTransacaoTefRepositorySitefExp }

constructor TTransacaoTefRepositorySitefExp.Create;
begin
  FCredController := TSitefExpCredencialController.Create;
end;

destructor TTransacaoTefRepositorySitefExp.Destroy;
begin
  FreeAndNil(FCredController);
  inherited;
end;

function TTransacaoTefRepositorySitefExp.fBuscarTransacao(
  AParam: TTransacaoTefBuscaParam): TTransacaoTefDados;
var
  LStrPar, LStrJsonRet: string;
  LStrData, LStrHora: string;
begin
  FillChar(Result,SizeOf(Result),#0);
  LStrPar := '';

  TTransaocaoTefParserSitefExp.fDateTimeToDataHoraApi(AParam.DtaTrn, LStrData, LStrHora);
  pAddStrPar(LStrPar,'datatrn', LStrData);
  pAddStrPar(LStrPar,'codloja', AParam.CodLoj);
  pAddStrPar(LStrPar,'nsusitef', AParam.NumNsu);
  pAddStrPar(LStrPar,'codsit', AParam.CodSit);

  if fEnviarRequisicao(rmGET, 'busca', LStrPar, LStrJsonRet) then
    Result := TTransaocaoTefParserSitefExp.fJsonToDados(LStrJsonRet)
  else
    raise TTrasacaoTefResponseException.Create('API Sitef Express [fBuscarTransacao]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + LStrJsonRet));
end;

function TTransacaoTefRepositorySitefExp.fBuscarTransacoesPendentes(
  const ADateFrom, ADateTo: TDate): TTransacaoTefDadosLista;
var
  LStrPar, LStrJsonRet: string;
  LStrDataFrom, LStrHoraFrom, LStrDataTo, LStrHoraTo: string;
begin
  Result := Nil;
  LStrPar := '';

  try
    TTransaocaoTefParserSitefExp.fDateTimeToDataHoraApi(ADateFrom, LStrDataFrom, LStrHoraFrom);
    TTransaocaoTefParserSitefExp.fDateTimeToDataHoraApi(ADateTo, LStrDataTo, LStrHoraTo);
    pAddStrPar(LStrPar, 'datefrom', LStrDataFrom);
    pAddStrPar(LStrPar, 'dateto', LStrDataTo);

    if fEnviarRequisicao(rmGet, 'pendencias', LStrPar, LStrJsonRet) then
      Result := TTransaocaoTefParserSitefExp.fJsonToLista(LStrJsonRet)
    else
      raise TTrasacaoTefResponseException.Create('API Sitef Express [fBuscarTransacoesPendentes]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + LStrJsonRet));

  except
    if Assigned(Result) then
      FreeAndNil(Result);
    Result := nil;

    raise;
  end;
end;


function TTransacaoTefRepositorySitefExp.fBuscarTransacoesPorData(
  const ADate: TDate): TTransacaoTefDadosLista;
var
  LStrPar, LStrJsonRet: string;
  LStrData, LStrHora: string;
begin
  Result := Nil;
  LStrPar := '';

  try
    TTransaocaoTefParserSitefExp.fDateTimeToDataHoraApi(ADate, LStrData, LStrHora);
    pAddStrPar(LStrPar,'datatrn', LStrData);

    if fEnviarRequisicao(rmGet, 'buscadata', LStrPar, LStrJsonRet) then
      Result := TTransaocaoTefParserSitefExp.fJsonToLista(LStrJsonRet)
    else
      raise TTrasacaoTefResponseException.Create('API Sitef Express [fBuscarTransacoesPorData]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + LStrJsonRet));

  except
    if Assigned(Result) then
      FreeAndNil(Result);

    Result := nil;

    raise;
  end;
end;

function TTransacaoTefRepositorySitefExp.fCancelarTransacaoPendente(
  const ATrn: TTransacaoTefDados): Boolean;
var
  LStrPar, LStrJsonRet: string;
  LStrData, LStrHora: string;
begin
  LStrPar := '';

  TTransaocaoTefParserSitefExp.fDateTimeToDataHoraApi(ATrn.DtaHra, LStrData, LStrHora);

  pAddStrPar(LStrPar, 'codsit', ATrn.CodSit);
  pAddStrPar(LStrPar, 'datatrn', LStrData);
  pAddStrPar(LStrPar, 'nsusitef', ATrn.NumNsu);
  pAddStrPar(LStrPar, 'codlojasitef', ATrn.CodLoj);

  Result := fEnviarRequisicao(rmPost, 'pendencias/cancela', LStrPar, LStrJsonRet);

  if not Result then
    raise TTrasacaoTefResponseException.Create('API Sitef Express [fCancelarTransacaoPendente]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + LStrJsonRet));
end;

function TTransacaoTefRepositorySitefExp.fConfirmarTransacaoPendente(
  const ATrn: TTransacaoTefDados): Boolean;
var
  LStrPar, LStrJsonRet: string;
  LStrData, LStrHora: string;
begin
  LStrPar := '';

  TTransaocaoTefParserSitefExp.fDateTimeToDataHoraApi(ATrn.DtaHra, LStrData, LStrHora);

  pAddStrPar(LStrPar, 'codsit', ATrn.CodSit);
  pAddStrPar(LStrPar, 'datatrn', LStrData);
  pAddStrPar(LStrPar, 'nsusitef', ATrn.NumNsu);
  pAddStrPar(LStrPar, 'codlojasitef', ATrn.CodLoj);

  Result := fEnviarRequisicao(rmPost, 'pendencias/confirma', LStrPar, LStrJsonRet);

  if not Result then
    raise TTrasacaoTefResponseException.Create('API Sitef Express [fConfirmarTransacaoPendente]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + LStrJsonRet));
end;

function TTransacaoTefRepositorySitefExp.fEnviarRequisicao(
  AMethod: TRESTRequestMethod; AResource, AStrParams: string;
  var AStrJson: string): Boolean;
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LStrParamsCod: string;
  LCredencial: TSitefExpCredencial;
begin
  Result := False;
  AStrJson := '';

  LControllerRest := TControllerRest.Create('SIEXP', TTransacaoTefRestConfigSitefExp.fConfigurarSitefExpress);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);

  try
    if FCredController.fCountCredenciais <= 0 then
      raise TTrasacaoTefCredenciaisException.Create('Credenciais não parametrizadas. Ajustar CFG_SE_CRE.');

    FCredController.pNovaTentativa;

    repeat
      LCredencial := FCredController.fProximaCredencial;
      if LCredencial = nil then
        break;

      LStrParamsCod := AStrParams;
      pAddStrPar(LStrParamsCod, 'codigo_cliente', LCredencial.Cod);

      LRestRequest.Client.BaseURL := LCredencial.Url ;
      LRestRequest.Method := AMethod;
      LRestRequest.Resource := AResource;

      pAddParRequest(LRestRequest, LStrParamsCod);

      if Assigned(LRestRequest.Client.Authenticator) then
        LRestRequest.Client.Authenticator.Free;
      LRestRequest.Client.Authenticator := THTTPBasicAuthenticator.Create(LCredencial.Usr, LCredencial.Pwd);

      Result := LControllerRest.fExecute(LRestRequest, AStrJson, ['200','201']);

      if Result then
        Break;

    until not fErroCredencialInvalida(LRestRequest.Response.StatusCode, AStrJson);

    if Result then
    begin
      FCredController.pSucesso;
    end
    else if fErroCredencialInvalida(LRestRequest.Response.StatusCode, AStrJson) then
    begin
      if FCredController.fCountCredenciais = 1 then
        raise TTrasacaoTefCredenciaisException.Create('Credencial inválida ou serviço indisponível. Verificar CFG_SE_CRE.')

      else if FCredController.fCountCredenciais > 1 then
        raise TTrasacaoTefCredenciaisException.Create('Todas as credenciais cadastradas estão inválidas ou nenhum serviço disponível. Verificar CFG_SE_CRE.');
    end;

  finally
    FreeAndNil(LRestRequest);
    FreeAndNil(LControllerRest);
  end;
end;

function TTransacaoTefRepositorySitefExp.fErroCredencialInvalida(
  const AintStatusRet: Integer; const AstrMsgRet: string): Boolean;
const
  ERRO_CLIENTE_NAO_RECONHECIDO = 'codigo_cliente nao reconhecido!';
begin
  Result := (AintStatusRet = 401) or AstrMsgRet.Trim.ToLower.Equals(ERRO_CLIENTE_NAO_RECONHECIDO);
end;

class function TTransacaoTefRepositorySitefExp.New: ITransacaoTefRepository;
begin
  Result := Self.Create();
end;

procedure TTransacaoTefRepositorySitefExp.pAddParRequest(
  var ARequest: TRestRequest; AStrPar: string);
var
  LParameters: TStringList;
  LParam, LKey, LValue: String;
  LParPost: String;
  LPos: Integer;
begin
  LParameters := TStringList.Create;
  try
    LParameters.Delimiter := ';';
    LParameters.DelimitedText := AStrPar;
    LParPost := '';
    for LParam in LParameters do
    begin
      LPos := Pos('|', LParam);
      LKey := Copy(LParam, 1, LPos - 1);
      LValue := Copy(LParam, LPos + 1, Length(LParam) - LPos);

      case ARequest.Method of
        rmGet:
          ARequest.Params.AddItem(LKey, LValue, pkGETorPOST);

        rmPost:
        begin
          if LParPost = '' then
            LParPost := '?'
          else
            LParPost := LParPost + '&';

          LParPost := LParPost + LKey + '=' + LValue;
        end;
      end;
    end;

    if LParPost <> '' then
      ARequest.Resource := ARequest.Resource + LParPost;
  finally
    FreeAndNil(LParameters);
  end;
end;

procedure TTransacaoTefRepositorySitefExp.pAddStrPar(var AStr: string;
  const AKey, AValue: string);
begin
  if AStr <> '' then
    AStr := AStr + ';';

  AStr := AStr + AKey + '|' + AValue;
end;

{ TTransacaoTefRepositorySitefExpRestConfig }

class function TTransacaoTefRestConfigSitefExp.fConfigurarSitefExpress(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
  Result := True;

  try
    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

end.
