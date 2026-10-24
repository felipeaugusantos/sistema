unit untTDDASicoobAPI;

interface

uses System.Classes, System.SysUtils, untTiposDDA, untTRestSynalistAutban,
UniClientDataSet, cxProgressBar, System.JSON, untFuncoesSimples, untDDAApiHelpers,
Data.DB;

type
  TDDASicoobAPI = class
  private
    FDadosCarteira: TDDAAPIDadosCarteira;
    FHttp           : TRestSynalistAutban;
    FAccessToken    : string;
    FTokenExpiraEm  : TDateTime;

    function FormatarDataParaAPI(const AData: TDateTime): string;
    function MontarURLMovimentacoesDDA(const ADataInicial, ADataFinal: TDateTime;
      const ASituacao, ATipoData: Integer): string;

    function RetornaLinkTokenDoAmbiente: string;
    function RetornaLinkDoAmbiente(const ARecurso: string): string;

    function CriarDadosCarteira(const AConfiguracao: string): TDDAAPIDadosCarteira;
    function RetornaTextoDoJsonDeErros(const AErro: string): string;
    function HttpGETJson(const AUrl: string; out AResposta: string): Integer;
    procedure ValidarConfiguracao(const AConfiguracao: string);

  public
    constructor Create(AConfiguracao: string);
    destructor Destroy; override;

    function  RetornaToken: string;

    procedure ImportarMovimentacoesDDA(
      const ADataInicial, ADataFinal: TDateTime;
      const ASituacao, ATipoData: Integer;
      var ADestino: TUniClientDataset;
      AProgresso: TcxProgressBar);

    property DadosCarteira: TDDAAPIDadosCarteira read FDadosCarteira;
  const
    URL_API_HOMOLOGACAO = 'https://sandbox.sicoob.com.br/sicoob/sandbox/cobranca-bancaria-pagamentos/v3';
    URL_API_PRODUCAO    = 'https://api.sicoob.com.br/pagamentos/v3';
    URL_TOKEN = 'https://auth.sicoob.com.br/auth/realms/cooperado/protocol/openid-connect/token';

end;

implementation

{ TDDASicoobAPI }

constructor TDDASicoobAPI.Create(AConfiguracao: string);
begin
  ValidarConfiguracao(AConfiguracao);
  FDadosCarteira := CriarDadosCarteira(AConfiguracao);

  FHttp := TRestSynalistAutban.Create;
  FHttp.CarregaCertificados(
    FDadosCarteira.Configuracao,
    FDadosCarteira.CertificadoPfx,
    EmptyStr, EmptyStr, FDadosCarteira.SenhaCertificado);

  FAccessToken := EmptyStr;
end;

function TDDASicoobAPI.CriarDadosCarteira(
  const AConfiguracao: string): TDDAAPIDadosCarteira;
begin
  Result := TDDAAPIDadosCarteira.Create('756', AConfiguracao);
end;

destructor TDDASicoobAPI.Destroy;
begin
  FreeAndNil(FHttp);
  FreeAndNil(FDadosCarteira);
  inherited;
end;

function TDDASicoobAPI.FormatarDataParaAPI(const AData: TDateTime): string;
begin
  Result := FormatDateTime('yyyy"-"mm"-"dd"', AData);
end;

function TDDASicoobAPI.HttpGETJson(const AUrl: string;
  out AResposta: string): Integer;
var
  LListaCabecalhos : TStringList;
  LTokenBearer : string;
begin
  if not Assigned(FHttp) then
    raise Exception.Create('HTTP não inicializado.');

  if (AUrl = EmptyStr) or (Pos('http', LowerCase(AUrl)) <> 1) then
    raise Exception.Create('URL inválida: ' + AUrl);

  LTokenBearer := RetornaToken;
  if LTokenBearer = EmptyStr then
    raise Exception.Create('Token vazio ao chamar: ' + AUrl);

  LListaCabecalhos := TStringList.Create;
  try
    LListaCabecalhos.Add('Authorization: ' + LTokenBearer);
    if FDadosCarteira.ClientId <> EmptyStr then
      LListaCabecalhos.Add('client_id: ' + FDadosCarteira.ClientId);
    LListaCabecalhos.Add('Accept: application/json');

    FHttp.StatusSemRaise := [204];
    try
      Result := FHttp.ExecuteRestSynalist('GET', AUrl, LListaCabecalhos, AResposta, EmptyStr, 'application/json');
    finally
      FHttp.StatusSemRaise := [];
    end;

  finally
    LListaCabecalhos.Free;
  end
end;

procedure TDDASicoobAPI.ImportarMovimentacoesDDA(
  const ADataInicial, ADataFinal: TDateTime;
  const ASituacao, ATipoData: Integer;
  var ADestino: TUniClientDataset;
  AProgresso: TcxProgressBar);
var
  LUrlRequisicao   : string;
  LRespostaJson    : string;
  LCodigoHTTP      : Integer;
  LRaizJson        : TJSONValue;
  LListaRegistros  : TJSONArray;
  LRegistroObj     : TJSONObject;
  LIndiceRegistro  : Integer;
  LCriouListaTemp  : Boolean;
  LCampoResultado  : TJSONValue;
begin
  LUrlRequisicao := MontarURLMovimentacoesDDA(
                     ADataInicial, ADataFinal, ASituacao, ATipoData);

  LCodigoHTTP := HttpGETJson(LUrlRequisicao, LRespostaJson);

  if LCodigoHTTP = 204 then
    Exit;

  if LCodigoHTTP <> 200 then
    raise Exception.Create('Falha ao consultar DDA (HTTP ' +
                           LCodigoHTTP.ToString + '): ' +
                           RetornaTextoDoJsonDeErros(LRespostaJson));

  if not ADestino.Active then
    ADestino.CreateDataSet
  else
    ADestino.EmptyDataSet;

  LRaizJson := TJSONObject.ParseJSONValue(LRespostaJson);
  try
    LListaRegistros := nil;
    LCriouListaTemp := False;

    if LRaizJson is TJSONArray then
      LListaRegistros := TJSONArray(LRaizJson)
    else
    if (LRaizJson is TJSONObject) and
       ( TJSONObject(LRaizJson).TryGetValue('RESULTADO', LCampoResultado) or
         TJSONObject(LRaizJson).TryGetValue('resultado', LCampoResultado) ) then
    begin
      if LCampoResultado is TJSONArray then
        LListaRegistros := TJSONArray(LCampoResultado)
      else if LCampoResultado is TJSONObject then
      begin
        LListaRegistros := TJSONArray.Create;
        LListaRegistros.AddElement(LCampoResultado.Clone as TJSONObject);
        LCriouListaTemp := True;
      end;
    end;

    if LListaRegistros = nil then
      Exit;

    if Assigned(AProgresso) then
    begin
      AProgresso.Properties.Min := 0;
      AProgresso.Properties.Max := LListaRegistros.Count;
      AProgresso.Position := 0;
    end;

    ADestino.DisableControls;
    try
      for LIndiceRegistro := 0 to LListaRegistros.Count - 1 do
      begin
        if not (LListaRegistros.Items[LIndiceRegistro] is TJSONObject) then
          Continue;

        LRegistroObj := TJSONObject(LListaRegistros.Items[LIndiceRegistro]);

        ADestino.Append;

        ADestino.FieldByName('CODBCO').AsString := FDadosCarteira.CodigoBanco;
        ADestino.FieldByName('CODEMP').AsString := FDadosCarteira.CodigoEmpresa;
        ADestino.FieldByName('CODAGE').AsString := FDadosCarteira.CodigoAgencia;
        ADestino.FieldByName('CODCTA').AsString := FDadosCarteira.ContaCorrente;
        ADestino.FieldByName('DTAARQ').AsDateTime := LerDataJson(LRegistroObj, 'dataEmissao');
      	ADestino.FieldByName('CNPJ__').AsString := LerTextoJson(LRegistroObj, 'numeroCpfCnpjBeneficiario');
      	ADestino.FieldByName('NOMCED').AsString := LerTextoJson(LRegistroObj, 'nomeRazaoSocialBeneficiario');
        ADestino.FieldByName('DTAVEN').AsDateTime := LerDataJson(LRegistroObj, 'dataVencimentoBoleto');
      	ADestino.FieldByName('VALTIT').AsFloat := LerNumeroJson(LRegistroObj, 'valorBoleto');
        ADestino.FieldByName('NUMDUP').AsString := LerTextoJson(LRegistroObj, 'numeroDocumento');
        ADestino.FieldByName('AGECOB').AsString := FDadosCarteira.CodigoAgencia;
        ADestino.FieldByName('ESPDOC').AsString := LerTextoJson(LRegistroObj, 'codigoEspecieDocumento');
        ADestino.FieldByName('BCOCOM').AsString := FDadosCarteira.CodigoBanco;
      	ADestino.FieldByName('CODBAR').AsString := LerTextoJson(LRegistroObj, 'numeroCodigoBarras');
        ADestino.Post;


        if Assigned(AProgresso) then
        begin
          AProgresso.Position := LIndiceRegistro + 1;
          AProgresso.Update;
        end;
      end;
    finally
      ADestino.EnableControls;
    end;

    if LCriouListaTemp then
      LListaRegistros.Free;

  finally
    LRaizJson.Free;
  end;
end;

function TDDASicoobAPI.MontarURLMovimentacoesDDA(const ADataInicial,
  ADataFinal: TDateTime; const ASituacao, ATipoData: Integer): string;
var
  LNumeroConta: Integer;
  LQuery : string;
begin
  LNumeroConta := StrToIntDef(FDadosCarteira.ContaCorrente, 0);
  if LNumeroConta = 0 then
    raise Exception.Create('DDA: número da conta não configurado.');

  LQuery := Format('boletos?numeroConta=%d&dataInicial=%s&dataFinal=%s',
                  [LNumeroConta, FormatarDataParaAPI(ADataInicial), FormatarDataParaAPI(ADataFinal)]);

  if ASituacao > 0 then
    LQuery := LQuery + '&situacao=' + IntToStr(ASituacao);
  if ATipoData > 0 then
    LQuery := LQuery + '&tipoData=' + IntToStr(ATipoData);

  Result := RetornaLinkDoAmbiente(LQuery);
end;

function TDDASicoobAPI.RetornaLinkDoAmbiente(const ARecurso: string): string;
var
  LBase: string;
begin
  if FDadosCarteira.Homologacao = 'S' then
    LBase := URL_API_HOMOLOGACAO
  else
    LBase := URL_API_PRODUCAO;

  if (LBase <> EmptyStr) and (LBase[Length(LBase)] = '/') then
    Result := LBase + ARecurso.TrimLeft(['/'])
  else
    Result := LBase + '/' + ARecurso.TrimLeft(['/']);
end;

function TDDASicoobAPI.RetornaLinkTokenDoAmbiente: string;
begin
  Result := URL_TOKEN;
end;

function TDDASicoobAPI.RetornaTextoDoJsonDeErros(const AErro: string): string;
var
  LJsonObject   : TJSONObject;
  LJsonArray   : TJSONArray;
  LString  : string;
  LItem  : TJSONValue;
begin
  Result := AErro;
  if Trim(AErro) = EmptyStr then Exit;

  LJsonObject := TJSONObject.ParseJSONValue(AErro) as TJSONObject;
  try
    if LJsonObject = nil then Exit;

    if LJsonObject.TryGetValue<string>('error_description', LString) then
      Exit(LString);

    if LJsonObject.TryGetValue<string>('mensagem', LString) then
      Exit(LString);

    if LJsonObject.TryGetValue<string>('message', LString) then
      Exit(LString);

    if LJsonObject.TryGetValue<TJSONArray>('erros', LJsonArray) then
    begin
      Result := EmptyStr;
      for LItem in LJsonArray do
        if (LItem is TJSONObject) and TJSONObject(LItem).TryGetValue<string>('mensagem', LString) then
        begin
          if Result <> EmptyStr then
            Result := Result + sLineBreak;
          Result := Result + LString;
        end;
      if Result = EmptyStr then
        Result := AErro;
      Exit;
    end;
  finally
    LJsonObject.Free;
  end;
end;

function TDDASicoobAPI.RetornaToken: string;
var
  LListaCabecalhos  : TStringList;
  LCorpoRequisicao  : string;
  LRespostaToken    : string;
  LCodigoHTTP       : Integer;
  LObjetoJSON       : TJSONObject;
  LTextoToken       : string;
  LExpiraEmSegundos : Integer;
  LEscopo           : string;
begin
  if (FAccessToken <> EmptyStr) and (Now < FTokenExpiraEm) then
    Exit(FAccessToken);

  LListaCabecalhos := TStringList.Create;
  try
    if not FDadosCarteira.ChaveBasic.IsEmpty then
      LListaCabecalhos.Add('Authorization: ' + FDadosCarteira.ChaveBasic);

    LListaCabecalhos.Add('Accept: application/json');
    LListaCabecalhos.Add('Content-Type: application/x-www-form-urlencoded');

    LEscopo := 'pagamentos_consulta pagamentos_inclusao pagamentos_alteracao';

    LCorpoRequisicao :=
      'grant_type=client_credentials' +
      '&client_id=' + FDadosCarteira.ClientId +
      '&scope=' + LEscopo;

    if not FDadosCarteira.ClientSecret.IsEmpty then
      LCorpoRequisicao := LCorpoRequisicao + '&client_secret=' + FDadosCarteira.ClientSecret;

    LCodigoHTTP := FHttp.ExecuteRestSynalist(
                    'POST',
                    RetornaLinkTokenDoAmbiente,
                    LListaCabecalhos,
                    LRespostaToken,
                    LCorpoRequisicao,
                    'application/x-www-form-urlencoded');

    if LCodigoHTTP <> 200 then
      raise Exception.Create('Falha ao obter token: ' + RetornaTextoDoJsonDeErros(LRespostaToken));

    LObjetoJSON := TJSONObject.ParseJSONValue(LRespostaToken) as TJSONObject;
    try
      LTextoToken := LObjetoJSON.GetValue<string>('access_token');
      if not LObjetoJSON.TryGetValue<Integer>('expires_in', LExpiraEmSegundos) then
        LExpiraEmSegundos := 0;
    finally
      LObjetoJSON.Free;
    end;

    if LTextoToken = EmptyStr then
      raise Exception.Create('Token não retornado pelo servidor.');

    FAccessToken := 'Bearer ' + LTextoToken;

    if LExpiraEmSegundos > 0 then
      FTokenExpiraEm := Now + (LExpiraEmSegundos - 60) / 86400
    else
      FTokenExpiraEm := Now + (50 * 60) / 86400;

    Result := FAccessToken;
  finally
    LListaCabecalhos.Free;
  end;
end;

procedure TDDASicoobAPI.ValidarConfiguracao(const AConfiguracao: string);
begin
  if AConfiguracao.Trim = EmptyStr then
    raise Exception.Create('A configuração da carteira não pode ser vazia.');
end;

end.
