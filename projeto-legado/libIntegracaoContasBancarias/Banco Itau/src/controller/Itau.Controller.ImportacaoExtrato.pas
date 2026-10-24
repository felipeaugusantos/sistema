unit Itau.Controller.ImportacaoExtrato;

interface

uses
  Forms, System.SysUtils, Winapi.Windows, System.JSON, System.NetEncoding, 
  System.Generics.Collections, StrUtils, DateUtils, System.Classes, httpsend, 
  ssl_openssl, blcksock, synautil, System.IOUtils, System.RegularExpressions,
  Itau.Model.ImportacaoExtrato, Itau.Model.LancamentoExtrato,
  ContasBancarias.Model.ContaBancaria, untLibContaBancariaConstantes, 
  IdCoderMIME, untLibContaBancariaGravandoOld, untLibContaBancariaGravando, 
  cxProgressBar;

type
  EServidorItauTimeOutException = class(Exception);
  ECredenciaisInvalidasException = class(Exception);
  EApiItauException = class(Exception);

type
  TDadosToken = class
  public
    AccessToken: String;
    TokenType: String;
    ExpiresIn: Integer;
    Scope: String;
    DataLimite: TDateTime;
  end;

type
  TDadosCertificadoItau = class
  public
    ArquivoCertificado: String;
    ArquivoChavePrivada: String;
    SenhaChave: String;
    ClientId: String;
    ClientSecret: String;
  end;

type
  TImportacaoExtratoItau = class
  private
    FPastaLibContasBancarias: String;
    FLancamentosExtrato: TExtratoItau;
    FContaBancaria: TContaBancaria;
    FDadosCertificado: TDadosCertificadoItau;
    FDadosToken: TDadosToken;
    FUrlConsultaExtrato: String;
    FUrlToken: String;
    FFormGravando: TForm;
    FQuantidadePaginas: Integer;
    FUrlImportacao: String;
    FConsultaSaldo: Boolean;
    FCorrelationId: String;

    function ObterToken: TDadosToken;
    function RetornaUrlConsultaExtrato(APagina: Integer): String;
    function RetornaTokenAtivo: TDadosToken;
    function RetornaTokenObjectJson(AJsonRetorno: String): TDadosToken;
    procedure ImportarPagina(APagina: Integer; out ATemProxima: Boolean);
    function CriarLancamento(AEventoJSON: TJSONObject): TLancamentoExtrato;
    function CriarLancamentoSaldo(ABalanceJSON: TJSONObject): TLancamentoExtrato;
    procedure AdicionaCertificadosRequisicao(var AComponente: THTTPSend);
    procedure CarregaCertificados;
    procedure RemoverCertificados;
    procedure CarregaUrl;
    function RetornaTextoDoJsonDeErros(AErro: String): String;
    function ImportarExtratoBancario(pgbStatus: TcxProgressBar): Boolean;
    function ConverterDataISOParaData(AValorData: String): TDateTime;
    procedure AguardeParaProximaRequisicao;
    function GerarCorrelationId: String;
    function GerarStatementsId: String;
    function GetValorJson(AJSON: TJSONObject; const AChave: String): String;
    procedure ProcessarBalances(ABalancesArray: TJSONArray);
    function TipoContaParaParametro: String;
    
  public
    constructor Create(out AContaBancaria: TContaBancaria);
    destructor Destroy; override;
    procedure Importar;
    procedure ConsultarSaldo;
  end;

const
  C_URL_HOM = 'https://account-statement.api.hom.itau.com/account-statement/v1';
  C_URL_PROD = 'https://account-statement.api.itau.com/account-statement/v1';
  C_URL_TOKEN_HOM = 'https://sts.rdhi.com.br/api/oauth/token';
  C_URL_TOKEN_PROD = 'https://sts.itau.com.br/api/oauth/token';
  C_CODIGO_BANCO_ITAU = '341';

implementation

uses untTLibContasBancariasFuncoes;

{ TImportacaoExtratoItau }

constructor TImportacaoExtratoItau.Create(out AContaBancaria: TContaBancaria);
begin
  inherited Create;
  FPastaLibContasBancarias := ExtractFilePath(Application.ExeName);
  FLancamentosExtrato := TExtratoItau.Create;
  FContaBancaria := AContaBancaria;
  FDadosCertificado := TDadosCertificadoItau.Create;
  CarregaCertificados;
  CarregaUrl;
  FConsultaSaldo := False;
  FContaBancaria.ErroConsulta := '';
  FCorrelationId := GerarCorrelationId;
end;

destructor TImportacaoExtratoItau.Destroy;
begin
  FLancamentosExtrato.Free;
  FDadosToken.Free;
  RemoverCertificados;
  inherited;
end;

procedure TImportacaoExtratoItau.AdicionaCertificadosRequisicao(
  var AComponente: THTTPSend);
begin
  if FDadosCertificado.ArquivoCertificado.IsEmpty then
    Exit;

  // Itaú exige certificado .crt e chave .key separados
  AComponente.Sock.SSL.CertificateFile := FDadosCertificado.ArquivoCertificado;
  AComponente.Sock.SSL.PrivateKeyFile := FDadosCertificado.ArquivoChavePrivada;
  
  if not FDadosCertificado.SenhaChave.IsEmpty then
  begin
    AComponente.Sock.SSL.KeyPassword := FDadosCertificado.SenhaChave;
  end;
end;

procedure TImportacaoExtratoItau.AguardeParaProximaRequisicao;
begin
  if FConsultaSaldo then
    TLibContaBancariaFuncoes.AguardeTresSegundos
  else
    TLibContaBancariaFuncoes.AguardeExecutarModalA(
      TLibContaBancariaFuncoes.AguardeCincoSegundos,
      'Falha na comunicação, Nova tentativa em 5 segundos.', 
      '');
end;

procedure TImportacaoExtratoItau.CarregaCertificados;
var
  LStreamCert, LStreamKey: TMemoryStream;
  LDecoder: TIdDecoderMIME;
  LTempDir: String;
begin
  if not Assigned(FDadosCertificado) then
    FDadosCertificado := TDadosCertificadoItau.Create;

  // Certificado e chave vêm em campos separados no Itaú
  FDadosCertificado.ClientId := FContaBancaria.CredenciaisAutenticacao.ClientId;
  FDadosCertificado.ClientSecret := FContaBancaria.CredenciaisAutenticacao.ClientSecret;
  FDadosCertificado.SenhaChave := FContaBancaria.CredenciaisAutenticacao.SenhaCertificado;

  // Verifica se tem certificado e chave
  if FContaBancaria.CredenciaisAutenticacao.ArquivoCertificado.IsEmpty or
     FContaBancaria.CredenciaisAutenticacao.ArquivoChavePrivada.IsEmpty then
    Exit;

  LTempDir := IncludeTrailingPathDelimiter(FPastaLibContasBancarias) + 'temp\';
  ForceDirectories(LTempDir);

  LDecoder := TIdDecoderMIME.Create(nil);
  LStreamCert := TMemoryStream.Create;
  LStreamKey := TMemoryStream.Create;

  try
    // Salva certificado .crt
    LDecoder.DecodeStream(FContaBancaria.CredenciaisAutenticacao.ArquivoCertificado, LStreamCert);
    FDadosCertificado.ArquivoCertificado := 
      LTempDir + 'itau_cert_' + TLibContaBancariaFuncoes.fGetConnectionID + 
      '_' + VS_strCodEmp + '_' + strLoginUsuarioLogado + '.crt';
    LStreamCert.SaveToFile(FDadosCertificado.ArquivoCertificado);

    // Salva chave privada .key
    LStreamKey.Clear;
    LDecoder.DecodeStream(FContaBancaria.CredenciaisAutenticacao.ArquivoChavePrivada, LStreamKey);
    FDadosCertificado.ArquivoChavePrivada := 
      LTempDir + 'itau_key_' + TLibContaBancariaFuncoes.fGetConnectionID + 
      '_' + VS_strCodEmp + '_' + strLoginUsuarioLogado + '.key';
    LStreamKey.SaveToFile(FDadosCertificado.ArquivoChavePrivada);

  finally
    LDecoder.Free;
    LStreamCert.Free;
    LStreamKey.Free;
  end;
end;

procedure TImportacaoExtratoItau.CarregaUrl;
begin
  FUrlToken := VS_FuncoesExternas.fICfgSis('URLTIT',varString, VS_strCodEmp);
  FUrlConsultaExtrato := VS_FuncoesExternas.fICfgSis('URLEIT',varString, VS_strCodEmp);

  If FUrlConsultaExtrato.IsEmpty Then
    FUrlConsultaExtrato := C_URL_HOM;

  If FUrlToken.IsEmpty Then
    FUrlToken := C_URL_TOKEN_HOM;
end;

function TImportacaoExtratoItau.GerarCorrelationId: String;
var
  LGuid: TGUID;
begin
  CreateGUID(LGuid);
  Result := GUIDToString(LGuid);
  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
  Result := LowerCase(Result);
end;

function TImportacaoExtratoItau.GerarStatementsId: String;
begin
  Result := Format('%s00%s%s', [
    FContaBancaria.Agencia,
    FContaBancaria.NumeroConta,
    FContaBancaria.DVConta
  ]);
end;

procedure TImportacaoExtratoItau.RemoverCertificados;
begin
  if not Assigned(FDadosCertificado) then
    Exit;

  try
    if not FDadosCertificado.ArquivoCertificado.IsEmpty and 
       FileExists(FDadosCertificado.ArquivoCertificado) then
      DeleteFile(PChar(FDadosCertificado.ArquivoCertificado));
    
    if not FDadosCertificado.ArquivoChavePrivada.IsEmpty and
       FileExists(FDadosCertificado.ArquivoChavePrivada) then
      DeleteFile(PChar(FDadosCertificado.ArquivoChavePrivada));
  finally
    FreeAndNil(FDadosCertificado);
  end;
end;

function TImportacaoExtratoItau.RetornaTextoDoJsonDeErros(AErro: String): String;
var
  LJsonObject: TJsonObject;
  LJsonArray: TJsonArray;
  LJsonValue: TJsonValue;
begin
  Result := AErro;
  
  if AErro.IsEmpty then
    Exit;
    
  try
    LJsonObject := TJSONObject.ParseJSONValue(AErro) as TJsonObject;
    
    if LJsonObject = nil then
      Exit;

    // Tenta diferentes formatos de erro
    if LJsonObject.TryGetValue<string>('message', Result) then
      Exit;
      
    if LJsonObject.TryGetValue<string>('error_description', Result) then
      Exit;
      
    if LJsonObject.TryGetValue<string>('error', Result) then
      Exit;
      
    if LJsonObject.TryGetValue<TJSONArray>('erros', LJsonArray) then
    begin
      Result := '';
      for LJsonValue in LJsonArray do
      begin
        if (LJsonValue as TJsonObject).TryGetValue<string>('mensagem', Result) then
          Break;
      end;
    end;

    if Result.IsEmpty then
      Result := AErro;
      
  except
    // Mantém o erro original se não conseguir parsear
  end;
end;

function TImportacaoExtratoItau.RetornaTokenAtivo: TDadosToken;
begin
  Result := nil;
  
  if Assigned(FDadosToken) then
  begin
    // Verifica se o token ainda é válido (com margem de 60 segundos)
    if IncSecond(FDadosToken.DataLimite, -60) > Now then
      Result := FDadosToken
    else
      FreeAndNil(FDadosToken);
  end;
end;

function TImportacaoExtratoItau.RetornaTokenObjectJson(AJsonRetorno: String): TDadosToken;
var
  LJsonObject: TJsonObject;
begin
  Result := TDadosToken.Create;
  
  try
    LJsonObject := TJSONObject.ParseJSONValue(AJsonRetorno) as TJSONObject;
    
    if Assigned(LJsonObject) then
    begin
      Result.AccessToken := LJsonObject.GetValue<string>('access_token', '');
      Result.TokenType := LJsonObject.GetValue<string>('token_type', '');
      Result.ExpiresIn := LJsonObject.GetValue<Integer>('expires_in', 0);
      Result.Scope := LJsonObject.GetValue<string>('scope', '');
      Result.DataLimite := IncSecond(Now, Result.ExpiresIn);
    end;
    
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TImportacaoExtratoItau.TipoContaParaParametro: String;
begin
  Result := 'current_account';

  if SameText(FContaBancaria.TipoConta, 'POUPANCA') or 
     SameText(FContaBancaria.TipoConta, 'POUPANÇA') or
     SameText(FContaBancaria.TipoConta, 'SAVINGS') then
    Result := 'savings_account';
end;

function TImportacaoExtratoItau.RetornaUrlConsultaExtrato(APagina: Integer): String;
var
  LStatementsId, LTipoConta: String;
begin
  LStatementsId := GerarStatementsId;
  LTipoConta := TipoContaParaParametro;

  Result := Format('%s/statements/%s?' +
                   'type=%s&' +
                   'start_date=%s&' +
                   'end_date=%s&' +
                   'page=%d&' +
                   'page_size=%d',
                   [FUrlConsultaExtrato,
                    LStatementsId,
                    LTipoConta,
                    FormatDateTime('yyyy-mm-dd', FContaBancaria.DadosRequisicao.DataInicial),
                    FormatDateTime('yyyy-mm-dd', FContaBancaria.DadosRequisicao.DataFinal),
                    APagina,
                    1000]);
end;

function TImportacaoExtratoItau.ObterToken: TDadosToken;
var
  LHTTPSend: THTTPSend;
  LParams: TStringList;
  LJsonRetorno, LDadosEnvio: String;
  LFDataReq, LFDataResp: TMemoryStream;
begin
  Result := RetornaTokenAtivo;
  
  if Assigned(Result) then
    Exit;

  LHTTPSend := THTTPSend.Create;
  LParams := TStringList.Create;
  
  try
    LHTTPSend.MimeType := 'application/x-www-form-urlencoded';
    LHTTPSend.Protocol := '1.1';
    LHTTPSend.Sock.SSL.SSLType := LT_all;
    LHTTPSend.Sock.SetTimeout(30000);
    LHTTPSend.Sock.ConnectionTimeout := 30000;

    AdicionaCertificadosRequisicao(LHTTPSend);

    LParams.Add('Content-Type: application/x-www-form-urlencoded');
    LHTTPSend.Headers.AddStrings(LParams);

    LDadosEnvio := 
      'grant_type=client_credentials&' +
      'client_id=' + TNetEncoding.URL.Encode(FDadosCertificado.ClientId) + '&' +
      'client_secret=' + TNetEncoding.URL.Encode(FDadosCertificado.ClientSecret);

    try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosEnvio)));
      LHTTPSend.Document.LoadFromStream(LFDataReq);
    finally
      FreeAndNil(LFDataReq);
    end;

    if LHTTPSend.HTTPMethod('POST', FUrlToken) then
    begin
      LHTTPSend.Document.Position := 0;

      try
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(LHTTPSend.Document);
        LFDataResp.Position := 0;
        LJsonRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        if not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) then
        begin
          raise ECredenciaisInvalidasException.Create(
            'Erro ao autenticar no Itaú. Código: ' + LHTTPSend.ResultCode.ToString + #13 +
            'Resposta: ' + RetornaTextoDoJsonDeErros(LJsonRetorno));
        end;

        Result := RetornaTokenObjectJson(LJsonRetorno);
        
        if Result.AccessToken.IsEmpty then
          raise ECredenciaisInvalidasException.Create('Token de acesso não retornado pelo Itaú.');

      finally
        FreeAndNil(LFDataResp);
      end;
    end
    else
    begin
      raise EServidorItauTimeOutException.Create(
        'Servidor do Itaú não respondeu.' + #10#13 +
        'URL: ' + FUrlToken + #10#13 +
        'Verifique:' + #10#13 +
        '1. Certificado e chave privada instalados' + #10#13 +
        '2. Client ID e Client Secret configurados' + #10#13 +
        '3. Conexão com a internet');
    end;

  finally
    LParams.Free;
    LHTTPSend.Free;
  end;
end;

function TImportacaoExtratoItau.GetValorJson(AJSON: TJSONObject; const AChave: String): String;
begin
  Result := '';
  
  if not Assigned(AJSON) then
    Exit;
    
  AJSON.TryGetValue<string>(AChave, Result);
end;


function TImportacaoExtratoItau.ConverterDataISOParaData(AValorData: String): TDateTime;
var
  LAno, LMes, LDia: Word;
  LHora, LMinuto, LSegundo: Word;
begin
  Result := 0;
  
  if AValorData.IsEmpty then
    Exit;
    
  try
    // Formato ISO 8601: 2024-04-25T02:59:00Z
    if (Pos('T', AValorData) > 0) then
    begin
      LAno := StrToIntDef(Copy(AValorData, 1, 4), 0);
      LMes := StrToIntDef(Copy(AValorData, 6, 2), 0);
      LDia := StrToIntDef(Copy(AValorData, 9, 2), 0);
      
      // Extrai hora se disponível
      if Length(AValorData) >= 19 then
      begin
        LHora := StrToIntDef(Copy(AValorData, 12, 2), 0);
        LMinuto := StrToIntDef(Copy(AValorData, 15, 2), 0);
        LSegundo := StrToIntDef(Copy(AValorData, 18, 2), 0);
        
        Result := EncodeDate(LAno, LMes, LDia) + 
                  EncodeTime(LHora, LMinuto, LSegundo, 0);
      end
      else
      begin
        Result := EncodeDate(LAno, LMes, LDia);
      end;
    end
    // Formato data simples: 2024-04-24
    else if Length(AValorData) = 10 then
    begin
      LAno := StrToIntDef(Copy(AValorData, 1, 4), 0);
      LMes := StrToIntDef(Copy(AValorData, 6, 2), 0);
      LDia := StrToIntDef(Copy(AValorData, 9, 2), 0);
      
      Result := EncodeDate(LAno, LMes, LDia);
    end;
  except
    Result := 0;
  end;
end;

function TImportacaoExtratoItau.CriarLancamentoSaldo(ABalanceJSON: TJSONObject): TLancamentoExtrato;
var
  LLancamento: TLancamentoExtrato;
  LDateJSON, LAmountJSON, LLiteralJSON: TJSONObject;
begin
  try
    // Dados básicos do balance
    LLancamento.IdEvento := 'BALANCE_' + FormatDateTime('yyyymmddhhnnss', Now);
    LLancamento.TipoEvento := GetValorJson(ABalanceJSON, 'type');
    LLancamento.Operacao := 'C';
    LLancamento.Estorno := False;

    // Datas
    if ABalanceJSON.TryGetValue<TJSONObject>('date', LDateJSON) then
    begin
      LLancamento.DataEvento := ConverterDataISOParaData(GetValorJson(LDateJSON, 'event'));
      LLancamento.DataContabil := Trunc(LLancamento.DataEvento);
    end;

    // Descrição literal
    if ABalanceJSON.TryGetValue<TJSONObject>('literal', LLiteralJSON) then
    begin
      LLancamento.CodigoHistorico := 'SALDO';
      LLancamento.DescricaoResumida := GetValorJson(LLiteralJSON, 'shortened');
      LLancamento.DescricaoCompleta := GetValorJson(LLiteralJSON, 'complete');
      LLancamento.TipoHistorico := GetValorJson(LLiteralJSON, 'shortened');
    end;

    // Valor
    if ABalanceJSON.TryGetValue<TJSONObject>('amount', LAmountJSON) then
    begin
      LLancamento.ValorLancamento := Abs(LAmountJSON.GetValue<Double>('value', 0)); // Valor absoluto
      LLancamento.Moeda := GetValorJson(LAmountJSON, 'currency');
    end;

    LLancamento.Agencia := FContaBancaria.Agencia;
    LLancamento.Conta := FContaBancaria.NumeroConta;
    LLancamento.DigitoConta := FContaBancaria.DVConta;

    LLancamento.OperadorImportacao := VS_FuncoesExternas.fIRetOperadorLogado;
    LLancamento.DataImportacao := VS_FuncoesExternas.fIGetVS_Date;
    LLancamento.HoraDaImportacao := TLibContaBancariaFuncoes.fTime;
    LLancamento.UrlImportacao := FUrlImportacao;
    LLancamento.ContaBancaria := FContaBancaria;

    Result := LLancamento;

  except
    on E: Exception do
      raise Exception.Create('Erro ao criar lançamento de saldo Itaú: ' + E.Message);
  end;
end;

function TImportacaoExtratoItau.CriarLancamento(AEventoJSON: TJSONObject): TLancamentoExtrato;
var
  LLancamento: TLancamentoExtrato;
  LDateJSON, LAmountJSON, LCounterpartJSON, LOriginJSON, LLiteralJSON: TJSONObject;
begin
  try
    // Dados básicos do evento
    LLancamento.IdEvento := GetValorJson(AEventoJSON, 'id');
    LLancamento.TipoEvento := GetValorJson(AEventoJSON, 'type');
    LLancamento.Operacao := GetValorJson(AEventoJSON, 'operation');
    LLancamento.Estorno := AEventoJSON.GetValue<Boolean>('reversal', False);
    
    // Datas
    if AEventoJSON.TryGetValue<TJSONObject>('date', LDateJSON) then
    begin
      LLancamento.DataEvento := ConverterDataISOParaData(GetValorJson(LDateJSON, 'event'));
      LLancamento.DataContabil := ConverterDataISOParaData(GetValorJson(LDateJSON, 'accounting'));
    end;

    // Descrição literal
    if AEventoJSON.TryGetValue<TJSONObject>('literal', LLiteralJSON) then
    begin
      LLancamento.CodigoHistorico := GetValorJson(LLiteralJSON, 'code');
      LLancamento.DescricaoResumida := GetValorJson(LLiteralJSON, 'shortened');
      LLancamento.DescricaoCompleta := GetValorJson(LLiteralJSON, 'complete');
      LLancamento.TipoHistorico := GetValorJson(LLiteralJSON, 'tip');
    end;

    // Valor
    if AEventoJSON.TryGetValue<TJSONObject>('amount', LAmountJSON) then
    begin
      LLancamento.ValorLancamento := LAmountJSON.GetValue<Double>('value', 0);
      LLancamento.Moeda := GetValorJson(LAmountJSON, 'currency');
    end;

    // Contrapartida
    if AEventoJSON.TryGetValue<TJSONObject>('counterpart', LCounterpartJSON) then
    begin
      LLancamento.TipoContrapartida := GetValorJson(LCounterpartJSON, 'type');
      LLancamento.ISPBContrapartida := GetValorJson(LCounterpartJSON, 'ispb');
      LLancamento.AgenciaContrapartida := GetValorJson(LCounterpartJSON, 'agency');
      LLancamento.ContaContrapartida := GetValorJson(LCounterpartJSON, 'account');
      LLancamento.DigitoContaContrapartida := GetValorJson(LCounterpartJSON, 'digit');
      LLancamento.NomeContrapartida := GetValorJson(LCounterpartJSON, 'name');
      LLancamento.DocumentoContrapartida :=GetValorJson(LCounterpartJSON, 'document');
      LLancamento.TipoPessoaContrapartida := GetValorJson(LCounterpartJSON, 'person');
      LLancamento.TipoPessoaContrapartida := GetValorJson(LCounterpartJSON, 'type_person');
    end;

    // Origem
    if AEventoJSON.TryGetValue<TJSONObject>('origin', LOriginJSON) then
    begin
      LLancamento.IdentificadorOrigem := GetValorJson(LOriginJSON, 'identifier');
      LLancamento.OperacaoOrigem := GetValorJson(LOriginJSON, 'operation');
      LLancamento.CanalOrigem := GetValorJson(LOriginJSON, 'channel');
    end;
    
    LLancamento.Agencia := FContaBancaria.Agencia;
    LLancamento.Conta := FContaBancaria.NumeroConta;
    LLancamento.DigitoConta := FContaBancaria.DVConta;

    LLancamento.OperadorImportacao := VS_FuncoesExternas.fIRetOperadorLogado;
    LLancamento.DataImportacao := VS_FuncoesExternas.fIGetVS_Date;
    LLancamento.HoraDaImportacao := TLibContaBancariaFuncoes.fTime;
    LLancamento.UrlImportacao := FUrlImportacao;
    LLancamento.ContaBancaria := FContaBancaria;

    Result := LLancamento;
    
  except
    on E: Exception do
      raise Exception.Create('Erro ao criar lançamento Itaú: ' + E.Message);
  end;
end;

procedure TImportacaoExtratoItau.ProcessarBalances(ABalancesArray: TJSONArray);
var
  I: Integer;
  LBalanceJSON: TJSONObject;
  LLancamento: TLancamentoExtrato;
begin
  if not Assigned(ABalancesArray) then
    Exit;

  for I := 0 to ABalancesArray.Count - 1 do
  begin
    LBalanceJSON := ABalancesArray.Items[I] as TJSONObject;

    LLancamento := CriarLancamentoSaldo(LBalanceJSON);

    FLancamentosExtrato.SalvarLancamento(LLancamento);

    if SameText(UpperCase(LLancamento.TipoEvento), 'SALDO_DISPONIVEL') And
       SameText(UpperCase(LLancamento.DescricaoResumida), 'SALDO EM CONTA')  then
      FContaBancaria.Saldo := LLancamento.ValorLancamento;
  end;
end;

procedure TImportacaoExtratoItau.ImportarPagina(APagina: Integer; out ATemProxima: Boolean);
var
  LHTTPSend: THTTPSend;
  LParams: TStringList;
  LJsonRetorno: String;
  LFDataResp: TMemoryStream;
  LJsonObject, LPaginationObject, LDataItem: TJSONObject;
  LDataArray, LEventsArray, LBalancesArray: TJSONArray;
  I: Integer;
  LLancamento: TLancamentoExtrato;
  LMensagem: String;
begin
  ATemProxima := False;

  LHTTPSend := THTTPSend.Create;
  LParams := TStringList.Create;

  try
    LHTTPSend.MimeType := 'application/json';
    LHTTPSend.Protocol := '1.1';
    LHTTPSend.Sock.SSL.SSLType := LT_all;
    LHTTPSend.Sock.SetTimeout(30000);
    LHTTPSend.Sock.ConnectionTimeout := 30000;

    AdicionaCertificadosRequisicao(LHTTPSend);

    LParams.Add('Authorization: Bearer ' + FDadosToken.AccessToken);
    LParams.Add('Accept: application/json');
    LParams.Add('x-itau-correlationid: ' + FCorrelationId);

    LHTTPSend.Headers.AddStrings(LParams);

    LMensagem := 'Aguarde... Importando extrato bancário';
    if FQuantidadePaginas > 0 then
      LMensagem := Format('Aguarde... Importando extrato bancário (Página %d de %d)',
                         [APagina, FQuantidadePaginas]);

    if not FConsultaSaldo then
    begin
      TLibContaBancariaFuncoes.AlterarMensagemFormGravando(FFormGravando, LMensagem);
      TLibContaBancariaFuncoes.IniciarProgressoFormGravando(FFormGravando, 0, 0);
    end;

    FUrlImportacao := RetornaUrlConsultaExtrato(APagina);

    if LHTTPSend.HTTPMethod('GET', FUrlImportacao) then
    begin
      LHTTPSend.Document.Position := 0;

      try
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(LHTTPSend.Document);
        LFDataResp.Position := 0;
        LJsonRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        if LHTTPSend.ResultCode <> 200 then
        begin
          raise EApiItauException.Create(
            Format('Erro %d ao consultar extrato Itaú: %s', 
                   [LHTTPSend.ResultCode, RetornaTextoDoJsonDeErros(LJsonRetorno)]));
        end;

        LJsonObject := TJSONObject.ParseJSONValue(LJsonRetorno) as TJSONObject;
        if Assigned(LJsonObject) then
        begin
          try
            if LJsonObject.TryGetValue<TJSONArray>('data', LDataArray) then
            begin
              if LDataArray.Count > 0 then
              begin
                LDataItem := LDataArray.Items[0] as TJSONObject;

                // Processa os balances (saldos)
                if LDataItem.TryGetValue<TJSONArray>('balances', LBalancesArray) then
                  ProcessarBalances(LBalancesArray);

                If FConsultaSaldo Then
                    Exit;

                // Processa os events (movimentações) se existirem
                if LDataItem.TryGetValue<TJSONArray>('events', LEventsArray) then
                begin
                  if not FConsultaSaldo then
                    TLibContaBancariaFuncoes.IniciarProgressoFormGravando(
                      FFormGravando, 0, LEventsArray.Count);

                  for I := 0 to LEventsArray.Count - 1 do
                  begin
                    LLancamento := CriarLancamento(LEventsArray.Items[I] as TJSONObject);

                    if LLancamento.TipoEvento = 'lancamento' then
                      FLancamentosExtrato.SalvarLancamento(LLancamento);

                    if not FConsultaSaldo then
                      TLibContaBancariaFuncoes.AtualizarStatusProgressaFormGravando(FFormGravando);
                  end;
                end;
              end;
            end;

            if LJsonObject.TryGetValue<TJSONObject>('pagination', LPaginationObject) then
            begin
              FQuantidadePaginas := LPaginationObject.GetValue<Integer>('total_pages', 0);
              ATemProxima := LPaginationObject.GetValue<Integer>('page', 0) < FQuantidadePaginas;
            end;

          finally
            If Assigned(LJsonObject) Then
              LJsonObject.Free;
          end;
        end;

      finally
        FreeAndNil(LFDataResp);
      end;
    end
    else
    begin
      raise EServidorItauTimeOutException.Create(
        'Servidor do Itaú não respondeu.' + #10#13 +
        'URL: ' + FUrlImportacao);
    end;
    
  finally
    LParams.Free;
    LHTTPSend.Free;
  end;
end;

procedure TImportacaoExtratoItau.ConsultarSaldo;
begin
  FConsultaSaldo := True;
  try
    ImportarExtratoBancario(nil);
  finally
    FConsultaSaldo := False;
  end;
end;

procedure TImportacaoExtratoItau.Importar;
begin
  FFormGravando := TLibContaBancariaFuncoes.CriarFormGravando;
  try
    TLibContaBancariaFuncoes.AlterarMensagemFormGravando(
      FFormGravando, 'Aguarde... Importando Extrato Bancário Itaú.');
    
    TLibContaBancariaFuncoes.AdicionarFuncaoAcaoFormGravando(
      FFormGravando, ImportarExtratoBancario);
    
    FFormGravando.ShowModal;
    
  finally
    FreeAndNil(FFormGravando);
  end;
end;

function TImportacaoExtratoItau.ImportarExtratoBancario(pgbStatus: TcxProgressBar): Boolean;
var
  LPagina: Integer;
  LTemProxima: Boolean;
  LContadorTentativas: Integer;
begin
  Result := False;
  FQuantidadePaginas := 0;
  FContaBancaria.QuantidadeDeMovimentacoes := 0;
  LContadorTentativas := 1;
  LPagina := 1;

  While LContadorTentativas <= 2 do
  begin
    try
      FDadosToken := ObterToken;

      Repeat
        ImportarPagina(LPagina, LTemProxima);
        Inc(LPagina);
      Until Not LTemProxima;
      
      Result := True;
      Break;
      
    Except
      on E: EServidorItauTimeOutException do
      begin
        AguardeParaProximaRequisicao;
        
        if LContadorTentativas >= 2 then
        begin
          FContaBancaria.ErroConsulta := 
            'Timeout ao conectar com o Itaú.' + sLineBreak +
            'Verifique sua conexão com a internet e tente novamente.';
          VS_FuncoesExternas.pIGravarErro(True, 'Itaú Timeout', E.Message);
        end;
      end;
      
      On E: ECredenciaisInvalidasException do
      begin
        AguardeParaProximaRequisicao;
        
        if LContadorTentativas >= 2 then
        begin
          FContaBancaria.ErroConsulta := 
            'Falha na autenticação com o Itaú.' + sLineBreak +
            'Verifique:' + sLineBreak +
            '1. Certificado e chave privada configurados' + sLineBreak +
            '2. Client ID e Client Secret configurados' + sLineBreak +
            '3. Conta habilitada para API';
          VS_FuncoesExternas.pIGravarErro(True, 'Itaú Autenticação', E.Message);
        end;
      end;
      
      On E: EApiItauException do
      begin
        AguardeParaProximaRequisicao;
        
        if LContadorTentativas >= 2 then
        begin
          FContaBancaria.ErroConsulta := 
            'Erro na API do Itaú.' + sLineBreak +
            'Detalhes: ' + E.Message;
          VS_FuncoesExternas.pIGravarErro(True, 'Itaú API', E.Message);
        end;
      end;
      
      On E: Exception do
      begin
        AguardeParaProximaRequisicao;
        
        if LContadorTentativas >= 2 then
        begin
          FContaBancaria.ErroConsulta :=
            'Erro inesperado ao importar extrato Itaú.' + sLineBreak +
            'Detalhes: ' + E.Message;
          VS_FuncoesExternas.pIGravarErro(True, 'Itaú Importação', E.Message);
        end;
      end;
    end;
    
    Inc(LContadorTentativas);
  end;

  FreeAndNil(FDadosToken);
end;

end.