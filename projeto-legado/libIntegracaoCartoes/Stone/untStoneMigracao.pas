unit untStoneMigracao;

interface

uses
  System.Classes, System.SysUtils, System.JSON, System.Generics.Collections,
  System.DateUtils, System.StrUtils,
  REST.Types, REST.Client, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, IdHTTP, IdSSLOpenSSL, HTTPSend, ssl_openssl,
  Uni, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  blcksock, synautil;

Type
  TChavesStone = class
  private
  public
    Empresa,
    Estabelecimento,
    Authorization,
    SHA512,
    Documento,
    Token : String;
  end;

type
  TStoneMigracao = class
  private
    FChave: TChavesStone;
    FClientId: string;
    FClientSecret: string;
    FUrlWebhook: string;
    FUrlMigracao: string;
    FUrlPedidoConsentimento: string;
    FUrlConsultaWebhook: string;
    FUsername: string;
    FPassword: string;
    FUrlToken: string;
    FUrlConsultaExtrato: string;

    FHTTPSend: THTTPSend;

    procedure CriarComponentes;
    procedure DestruirComponentes;
    procedure CarregarConfiguracoes;

    function ConsultarConsentimentoNoWebhook(out AUsername, APassword, AEmail: string): Boolean;
    function SolicitarConsentimento: Integer;
    procedure pSalvarValorCfg(ACodCfg, ACodEmp, AValor: string);
    procedure InserirConfiguracoesMigracao(ACodEmp: string);
    procedure InserirConfiguracao(ACodEmp, ACodCfg, ADescricao, AValor, AGrupo: string);
  public
    constructor Create(AChave: TChavesStone);
    destructor Destroy; override;
    class function fTiraCaracEspeciaisPonto(strTexto: String): String;

    function ExecutarMigracao: Boolean;
  end;

implementation

uses untFuncoes, untIDataSet;

{ TStoneMigracao }

constructor TStoneMigracao.Create(AChave: TChavesStone);
begin
  inherited Create;
  FChave := AChave;
  CarregarConfiguracoes;
end;

destructor TStoneMigracao.Destroy;
begin
  DestruirComponentes;
  inherited;
end;


procedure TStoneMigracao.CarregarConfiguracoes;
begin

  If fRetornaValorConfiguracao('CFG_STOCID',FChave.Empresa).Trim.IsEmpty Then
    InserirConfiguracoesMigracao(FChave.Empresa)
  Else if fRetornaValorConfiguracao('CFG_STOCON',FChave.Empresa).Trim.IsEmpty Then
  Begin
    InserirConfiguracao(FChave.Empresa, 'CFG_STOCON', 'STONE - Url Pedido de consentimento',
      'https://conciliation.stone.com.br/v2/merchant/consents', 'CARTÕES');
  End;

  FClientId           := fRetornaValorConfiguracao('CFG_STOCID',FChave.Empresa);
  FClientSecret       := fRetornaValorConfiguracao('CFG_STOCSC',FChave.Empresa);
  FUsername           := fRetornaValorConfiguracao('CFG_STOUSU',FChave.Empresa);
  FPassword           := fRetornaValorConfiguracao('CFG_STOPAS',FChave.Empresa);
  FUrlToken           := fRetornaValorConfiguracao('CFG_STOTKN',FChave.Empresa);
  FUrlConsultaExtrato := fRetornaValorConfiguracao('CFG_STOCOE',FChave.Empresa);
  FUrlWebhook         := fRetornaValorConfiguracao('CFG_STOWHO',FChave.Empresa);
  FUrlMigracao        := fRetornaValorConfiguracao('CFG_STOMIG',FChave.Empresa);
  FUrlConsultaWebhook := fRetornaValorConfiguracao('CFG_STOCOW',FChave.Empresa);
  FUrlPedidoConsentimento := fRetornaValorConfiguracao('CFG_STOCON',FChave.Empresa);
end;

procedure TStoneMigracao.CriarComponentes;
begin
  FHTTPSend := THTTPSend.Create;
  FHTTPSend.MimeType := 'application/json';
  FHTTPSend.UserAgent := 'Citel ERP - Stone Migracao';
  FHTTPSend.Protocol := '1.1';
  FHTTPSend.KeepAlive := True;
  FHTTPSend.Sock.SSL.SSLType := LT_TLSv1_2;
  FHTTPSend.Sock.SetTimeout(30000);
  FHTTPSend.Sock.ConnectionTimeout := 30000;
end;

procedure TStoneMigracao.DestruirComponentes;
begin
  FreeAndNil(FHTTPSend);
end;


function TStoneMigracao.ConsultarConsentimentoNoWebhook(out AUsername, APassword, AEmail: string): Boolean;
var
  LUrl: string;
  LResposta: string;
  LJsonArray: TJSONArray;
  LJsonValue: TJSONValue;
  LJsonObject: TJSONObject;
  LStatus: string;
  LFDataResp : TMemoryStream;
  I: Integer;
  J: Integer;
begin
  Result := False;
  AUsername := '';
  APassword := '';

  Try
    for I := 1 to 3 do
    begin
      LUrl := FUrlConsultaWebhook + '/' + FChave.Documento;

      CriarComponentes;
      try
        FHTTPSend.Headers.Clear;
        FHTTPSend.Headers.Add('accept: application/json');

        if FHTTPSend.HTTPMethod('GET', LUrl) then
        begin

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(FHTTPSend.Document);

            LFDataResp.Position := 0;

            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          Finally
            FreeAndNil(LFDataResp);
          End;

          If FHTTPSend.ResultCode <> 200 Then
            Raise Exception.Create('Status: ' + FHTTPSend.ResultCode.ToString + ' Erro: ' + LResposta);

          if FHTTPSend.ResultCode = 200 then
          begin
            LJsonValue := TJSONObject.ParseJSONValue(LResposta);

            if Assigned(LJsonValue) then
            begin
              try
                if LJsonValue is TJSONArray then
                begin
                  LJsonArray := LJsonValue as TJSONArray;

                  for J := 0 to LJsonArray.Count - 1 do
                  begin

                    if LJsonArray.Items[J] is TJSONObject then
                    begin
                      LJsonObject := LJsonArray.Items[J] as TJSONObject;
                      LJsonObject.TryGetValue('email', AEmail);
                      Result := True;

                      if LJsonObject.TryGetValue('status', LStatus) and
                         ((LowerCase(LStatus) = 'active') Or (LowerCase(LStatus) = 'accepted'))  then
                      begin
                        LJsonObject.TryGetValue('username', AUsername);
                        LJsonObject.TryGetValue('senhaDecriptada', APassword);
                        Exit;
                      end;

                    End;
                  end;
                end;
              finally
                LJsonValue.Free;
              end;
            end;
          end;
        end;
      finally
        DestruirComponentes;
      end;

      if (I < 3) and (not Result) then
        Sleep(1000);
    end;
  Except
    On E: Exception Do
    Begin
      raise Exception.Create('Erro ao consultar o webhook: '+ E.Message);
    End;
  End;
end;

function TStoneMigracao.SolicitarConsentimento: Integer;
var
  LUrl: string;
  LRequestBody: TJSONObject;
  LResposta: string;
  LRequestBodyStream: TStringStream;
  LFDataResp: TMemoryStream;
begin
  Result := 0;
  LUrl := FUrlPedidoConsentimento;

  Try
    LRequestBody := TJSONObject.Create;
    try
      LRequestBody.AddPair('document', FChave.Documento);
      LRequestBody.AddPair('affiliationCode', FChave.Estabelecimento);
      LRequestBody.AddPair('webhookUrl', FUrlWebhook);
      LRequestBody.AddPair('clientId', FClientId);
      LRequestBody.AddPair('clientSecret', FClientSecret);

      CriarComponentes;
      try
        FHTTPSend.Headers.Clear;
        FHTTPSend.Headers.Add('Content-Type: application/json');


        LRequestBodyStream := TStringStream.Create(LRequestBody.ToJSON);
        try
          FHTTPSend.Document.Clear;
          FHTTPSend.Document.LoadFromStream(LRequestBodyStream);
        finally
          LRequestBodyStream.Free;
        end;

        if FHTTPSend.HTTPMethod('POST', LUrl) then
        begin
          FHTTPSend.Document.Position := 0;

          LFDataResp := TMemoryStream.Create;
          try
            LFDataResp.LoadFromStream(FHTTPSend.Document);
            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
          finally
            FreeAndNil(LFDataResp);
          end;

           // Stone retorna exclusivamente 200 - Req. 434925
          if FHTTPSend.ResultCode <> 200 then
            raise Exception.Create('Status: ' + FHTTPSend.ResultCode.ToString + ' Erro: ' + LResposta);

          Result := FHTTPSend.ResultCode;
        end
        else
          raise Exception.Create('Falha na requisição HTTP');

      finally
        DestruirComponentes;
      end;
    finally
      LRequestBody.Free;
    end;

  Except
    On E: Exception Do
    Begin
      raise Exception.Create('Erro ao solicitar consentimento: ' + E.Message);
    End;
  End;
end;

function TStoneMigracao.ExecutarMigracao: Boolean;
var
  LUsername, LPassword, LEmail: string;
  LStatusCode: Integer;
begin
  Result := False;

  try
    if (FUsername <> '') And (FPassword <> '') then
      Exit(True);

    if ConsultarConsentimentoNoWebhook(LUsername, LPassword, LEmail) then
    begin

      If  (LUsername = '') Or (LPassword = '') then
      Begin

         objFunctions.fIMensagem('ATENÇÃO',
          'A Stone exige o consentimento do lojista para utilização da importação.' + sLineBreak +
          'Um e-mail de aprovação foi enviado ao lojista da empresa '+FChave.Empresa+'.' + sLineBreak +
          'Peça para o lojista acessar o e-mail '+ LEmail +', aceitar o consentimento e, após a aprovação, retornar aqui para continuar.' + sLineBreak +
          'O sistema seguirá com a importação das demais empresas.', ['&OK']);

        Exit;
      End;

      pSalvarValorCfg('CFG_STOUSU', FChave.Empresa, LUsername);
      pSalvarValorCfg('CFG_STOPAS', FChave.Empresa, LPassword);

      Result := True;
      Exit;
    end;

    if objFunctions.fIMensagem('ATENÇÃO!',
      'A Stone passou a exigir o consentimento do lojista para a utilização da importação '  +
      'e a empresa ' + FChave.Empresa + ' ainda não concedeu esse consentimento.' + sLineBreak +
      'Deseja realizar o processo agora?'  + sLineBreak +
      'Caso não seja feito agora, a importação desta empresa será ignorada neste momento.',
      ['&Sim', '&Não']) = 2 then
      Exit;

    LStatusCode := SolicitarConsentimento;

    if LStatusCode = 200 then
    begin
      Sleep(2000);

      if ConsultarConsentimentoNoWebhook(LUsername, LPassword, LEmail) then
      begin

        If (LUsername = '') Or (LPassword = '') then
        Begin

          objFunctions.fIMensagem('ATENÇÃO',
            'Um e-mail de aprovação foi enviado ao lojista da empresa '+FChave.Empresa+'.' + sLineBreak +
            'Peça para o lojista acessar o e-mail '+ LEmail +', aceitar o consentimento e, após a aprovação, retornar aqui para continuar.' + sLineBreak +
            'O sistema seguirá com a importação das demais empresas.', ['&OK']);

          Exit;
        End;

        pSalvarValorCfg('CFG_STOUSU', FChave.Empresa, LUsername);
        pSalvarValorCfg('CFG_STOPAS', FChave.Empresa, LPassword);

        Result := True;
      end
      else
      begin
        objFunctions.fIMensagem('ATENÇÃO',
          'Um e-mail de aprovação foi enviado ao lojista da empresa '+FChave.Empresa+'.' + sLineBreak +
          'Peça para o lojista acessar o e-mail, aceitar o consentimento e, após a aprovação, retornar aqui para continuar.' + sLineBreak +
          'O sistema seguirá com a importação das demais empresas.', ['&OK']);
      end;
    end;

  except
    on E: Exception do
      Raise Exception.Create('Falha na solicitação do consentimento da empresa '+ FChave.Empresa + ': ' + E.Message);
  end;
end;

class function TStoneMigracao.fTiraCaracEspeciaisPonto(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():.';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

procedure TStoneMigracao.pSalvarValorCfg(ACodCfg, ACodEmp, AValor: string);
var
  LUpdate: IDataset;
begin

  if ACodCfg = '' then
    raise Exception.Create('Código da configuração não informado');

  if ACodEmp = '' then
    raise Exception.Create('Código da empresa não informado');

  LUpdate := objFunctions.fGetDataSet;
  try
    LUpdate.SQL := 'UPDATE CFGSIS SET ' +
                   'SIS_VALCFG = :VALCFG ' +
                    'WHERE SIS_CODEMP = :CODEMP AND ' +
                    'SIS_CODCFG = :CODCFG';

    LUpdate.ParamByName('CODCFG').AsString := ACodCfg;
    LUpdate.ParamByName('CODEMP').AsString := ACodEmp;
    LUpdate.ParamByName('VALCFG').AsString := AValor;

    LUpdate.ExecSQL;

  except
    on E: Exception do
      raise Exception.Create('Erro ao salvar configuração ' + ACodCfg +
                             ' para empresa ' + ACodEmp + ': ' + E.Message);
  end;
end;


procedure TStoneMigracao.InserirConfiguracoesMigracao(ACodEmp: string);
begin
  if ACodEmp = '' then
    raise Exception.Create('Código da empresa não informado');

  InserirConfiguracao(ACodEmp, 'CFG_STOCID', 'STONE - Client ID',
    '27gjdttlknvlmje2n06ns3n7vi', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOCSC', 'STONE - Client Secret',
    '1tpn1bkqdt6id1qd4bs4cdocht8b9nqirnjphkrf4iugploop61b', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOUSU', 'STONE - Usuario',
    '', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOPAS', 'STONE - Senha',
    '', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOTKN', 'STONE - Url Token',
    'https://payments.stone.com.br/auth/realms/payments/oauth/token', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOCOE', 'STONE - Url Consulta Extrato',
    'https://conciliation.stone.com.br/v2/merchant/%s/conciliation-file/%s?layout=%s', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOWHO', 'STONE - Url Consentimento Webhook',
    'https://webhook-stone.citelsoftware.com.br/webhook/stone/consentimento', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOMIG', 'STONE - Url Migração V1 para V2',
    'https://conciliation.stone.com.br/v1/merchant/migration', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOCOW', 'STONE - Url Consulta Webhook',
    'https://webhook-stone.citelsoftware.com.br/api/consentimentos/documento', 'CARTÕES');

  InserirConfiguracao(ACodEmp, 'CFG_STOCON', 'STONE - Url Pedido de consentimento',
    'https://conciliation.stone.com.br/v2/merchant/consents', 'CARTÕES');
end;

procedure TStoneMigracao.InserirConfiguracao(ACodEmp, ACodCfg, ADescricao, AValor, AGrupo: string);
var
  LReplace: IDataset;
begin
  if ACodEmp = '' then
    raise Exception.Create('Código da empresa não informado');

  if ACodCfg = '' then
    raise Exception.Create('Código da configuração não informado');

  LReplace := objFunctions.fGetDataSet;
  try

    LReplace.SQL := 'REPLACE INTO CFGSIS (' +
        'SIS_CODEMP, ' +
        'SIS_CODCFG, ' +
        'SIS_DESCRI, ' +
        'SIS_VALCFG, ' +
        'SIS_GRUCFG, ' +
        'SIS_ULTALT, ' +
        'SIS_DHUALT, ' +
        'SIS_LAYOUT' +
    ') VALUES (' +
        ':CODEMP, ' +
        ':CODCFG, ' +
        ':DESCRI, ' +
        ':VALCFG, ' +
        ':GRUPO, ' +
        ':ULTALT, ' +
        ':DHUALT, ' +
        ':LAYOUT' +
    ')';

    LReplace.ParamByName('CODEMP').AsString := ACodEmp;
    LReplace.ParamByName('CODCFG').AsString := ACodCfg;
    LReplace.ParamByName('DESCRI').AsString := ADescricao;
    LReplace.ParamByName('VALCFG').AsString := AValor;
    LReplace.ParamByName('GRUPO').AsString := AGrupo;
    LReplace.ParamByName('ULTALT').AsDateTime := Date;
    LReplace.ParamByName('DHUALT').AsDateTime := Now;
    LReplace.ParamByName('LAYOUT').AsString := '';

    LReplace.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao inserir/substituir configuração ' + ACodCfg +
                             ' para empresa ' + ACodEmp + ': ' + E.Message);
  end;
end;





end.
