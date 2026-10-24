unit untStoneMigracao;

interface

uses
  System.Classes, System.SysUtils, System.JSON, System.Generics.Collections,
  System.DateUtils, System.StrUtils,
  REST.Types, REST.Client, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, IdHTTP, IdSSLOpenSSL, HTTPSend, ssl_openssl,
  Uni, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  untTStoneFuncoes,blcksock,synautil;

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

  public
    constructor Create(AChave: TChavesStone);
    destructor Destroy; override;

    function ExecutarMigracao: Boolean;
  end;

implementation

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
  FClientId           := VS_FuncoesExternas.fICfgSis('STOCID',varString,FChave.Empresa);
  FClientSecret       := VS_FuncoesExternas.fICfgSis('STOCSC',varString,FChave.Empresa);
  FUsername           := VS_FuncoesExternas.fICfgSis('STOUSU',varString,FChave.Empresa);
  FPassword           := VS_FuncoesExternas.fICfgSis('STOPAS',varString,FChave.Empresa);
  FUrlToken           := VS_FuncoesExternas.fICfgSis('STOTKN',varString,FChave.Empresa);
  FUrlConsultaExtrato := VS_FuncoesExternas.fICfgSis('STOCOE',varString,FChave.Empresa);
  FUrlWebhook         := VS_FuncoesExternas.fICfgSis('STOWHO',varString,FChave.Empresa);
  FUrlMigracao        := VS_FuncoesExternas.fICfgSis('STOMIG',varString,FChave.Empresa);
  FUrlConsultaWebhook := VS_FuncoesExternas.fICfgSis('STOCOW',varString,FChave.Empresa);
  FUrlPedidoConsentimento := VS_FuncoesExternas.fICfgSis('STOCON',varString,FChave.Empresa);
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

  LStringJson: String;
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
                      LStringJson := LJsonArray.Items[J].ToJSON;
                      LJsonObject := TJSONObject.ParseJSONValue(LStringJson) as TJSONObject;
                      Try
                        LJsonObject.TryGetValue('email', AEmail);
                        Result := True;

                        if LJsonObject.TryGetValue('status', LStatus) and
                           ((LowerCase(LStatus) = 'active') Or (LowerCase(LStatus) = 'accepted'))  then
                        begin
                          LJsonObject.TryGetValue('username', AUsername);
                          LJsonObject.TryGetValue('senhaDecriptada', APassword);
                          Exit;
                        end;
                      Finally
                        If Assigned(LJsonObject) Then
                          FreeAndNil(LJsonObject);
                      End;
                    end;
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
    if (FUsername <> '') and (FPassword <> '') then
      Exit(True);

    if ConsultarConsentimentoNoWebhook(LUsername, LPassword, LEmail) then
    begin

      If  (LUsername = '') Or (LPassword = '') then
      Begin

         TStoneFuncoes.fMensagem('ATENÇÃO',
          'A Stone exige o consentimento do lojista para utilização da importação.' + sLineBreak +
          'Um e-mail de aprovação foi enviado ao lojista da empresa '+FChave.Empresa+'.' + sLineBreak +
          'Peça para o lojista acessar o e-mail '+ LEmail +', aceitar o consentimento e, após a aprovação, retornar aqui para continuar.' + sLineBreak +
          'O sistema seguirá com a importação das demais empresas.', ['&OK']);

        Exit;
      End;

      TStoneFuncoes.pSalvarValorCfg('CFG_STOUSU', FChave.Empresa, LUsername);
      TStoneFuncoes.pSalvarValorCfg('CFG_STOPAS', FChave.Empresa, LPassword);

      Result := True;
      Exit;
    end;

    if TStoneFuncoes.fMensagem('ATENÇÃO!',
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

          TStoneFuncoes.fMensagem('ATENÇÃO',
            'Um e-mail de aprovação foi enviado ao lojista da empresa '+FChave.Empresa+'.' + sLineBreak +
            'Peça para o lojista acessar o e-mail '+ LEmail +', aceitar o consentimento e, após a aprovação, retornar aqui para continuar.' + sLineBreak +
            'O sistema seguirá com a importação das demais empresas.', ['&OK']);

          Exit;
        End;

        TStoneFuncoes.pSalvarValorCfg('CFG_STOUSU', FChave.Empresa, LUsername);
        TStoneFuncoes.pSalvarValorCfg('CFG_STOPAS', FChave.Empresa, LPassword);

        Result := True;
      end
      else
      begin
        TStoneFuncoes.fMensagem('ATENÇÃO',
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



end.
