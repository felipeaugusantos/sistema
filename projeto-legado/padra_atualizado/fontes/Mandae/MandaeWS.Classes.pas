unit MandaeWS.Classes;

interface

  Type

  TServico = (tsAdicionarEncomenda, tsConsultarTracking);

  TMandaeWS = class
  private
    FstrTokenIntegracao           : String;
    FstrURLIntegracao             : String;
    FstrServicoAdicionarEncomenda : String;
    FstrServicoConsultarTracking  : String;
    function fExtractBetweenTags(const Value, TagI, TagF: String): String;
  public
    constructor Create;
    function fComunicar(ATipoServico: TServico; var AintCodigoRetorno : Integer; var AstrMensagemRetorno : String ;
      AstrJson: String = ''; ACodigoDeRastreio : String = ''): String;
  end;

implementation

uses
  REST.Client, REST.Types, SysUtils, REST.Json, IPPeerCommon, IPPeerClient,
  IPPeerServer, untConstantes, IdMultipartFormData, IdHTTP, IdURI, Classes,
  IOUtils, Forms, System.NetEncoding, untFuncoes, Graphics, DateUtils,
  Web.HTTPApp, untFuncoesSimples, RegularExpressions;

{ TMandaeWS }

constructor TMandaeWS.Create;
begin
  inherited;
  FstrTokenIntegracao           := fCfgSis('MANTOK', varString);
  FstrURLIntegracao             := fCfgSis('MANURL', varString);
  FstrServicoAdicionarEncomenda := fCfgSis('MANADC', varString);
  FstrServicoConsultarTracking  := fCfgSis('MANCTR', varString);
end;

function TMandaeWS.fComunicar(ATipoServico: TServico; var AintCodigoRetorno : Integer; var AstrMensagemRetorno : String ;
      AstrJson: String = ''; ACodigoDeRastreio : String = ''): String;
var
  LRESTClient1: TRESTClient;
  LRESTRequest1: TRESTRequest;
  LRESTResponse1: TRESTResponse;
  LPostData: TStringStream;
  LstrGetPost : String;
begin
  LRESTClient1   := nil;
  LRESTRequest1  := nil;
  LRESTResponse1 := nil;

  try
    try

      Sleep(250);
      LRESTClient1             := TRESTClient.Create(nil);
      LRESTClient1.ContentType := 'application/json';

      LRESTRequest1        := TRESTRequest.Create(nil);
      LRESTRequest1.Accept := 'application/json';
      LRESTRequest1.Params.AddHeader('Authorization', FstrTokenIntegracao);

      if ATipoServico = tsAdicionarEncomenda then
      Begin
        LRESTClient1.BaseURL := FstrURLIntegracao+'/'+FstrServicoAdicionarEncomenda;
        LstrGetPost          := 'POST';
      End
      else if ATipoServico = tsConsultarTracking then
      Begin
        LRESTClient1.BaseURL := FstrURLIntegracao+'/'+FstrServicoConsultarTracking+'/'+ACodigoDeRastreio;
        LstrGetPost          := 'GET';
      End
      Else
      Begin
        LRESTClient1.BaseURL := FstrURLIntegracao;
        LstrGetPost          := '';
      End;

      with LRESTRequest1 do
      begin
        if LstrGetPost = 'GET' then
          Method := TRESTRequestMethod.rmGET
        else if LstrGetPost = 'POST' then
          Method := TRESTRequestMethod.rmPOST
        else if LstrGetPost = 'DELETE' then
          Method := TRESTRequestMethod.rmDELETE
        else if LstrGetPost = 'PATCH' then
          Method := TRESTRequestMethod.rmPATCH
        else
          Method := TRESTRequestMethod.rmPUT;

        LRESTRequest1.Timeout := 10000;
        LRESTRequest1.HandleRedirects := True;

        LRESTResponse1 := TRESTResponse.Create(nil);

        Client := LRESTClient1;
        Response := LRESTResponse1;
      end;

      if not fEmptyStr(AstrJson) then
      begin
        LPostData := TStringStream.Create(AstrJson, TEncoding.UTF8);

        with LRESTRequest1.Params.AddItem do
        begin
          Value := LPostData.DataString;
          ContentType := ctAPPLICATION_JSON;
        end;
      end;

      LRESTRequest1.Execute;

      { Todos os retornos de erro (400, 500, Exception, etc.) retorno com um *
        no primeiro caractere da String. Desta forma, eu consigo verificar se
        retornou erro com Pos('*', strRetorno) = 1, por exemplo }
      try
        AintCodigoRetorno   := LRESTResponse1.StatusCode;

        if LRESTResponse1.StatusCode >= 400 then
        Begin
          Result := '*' +LRESTResponse1.Content;
          AstrMensagemRetorno := fExtractBetweenTags(LRESTResponse1.Content,'"message":"','"}');
        End
        else
        Begin
          Result := LRESTResponse1.Content;
          AstrMensagemRetorno := 'Enviado';
        End;

      except
        Result := '';
      end;
    except
      on E: Exception do
        Result := '*' +E.Message +LRESTResponse1.Content;
    end;

  finally
    LRESTClient1.Disconnect;

    if Assigned(LRESTClient1) then
      FreeAndNil(LRESTClient1);

    if Assigned(LRESTRequest1) then
      FreeAndNil(LRESTRequest1);

    if Assigned(LRESTResponse1) then
      FreeAndNil(LRESTResponse1);
  end;
end;

function TMandaeWS.fExtractBetweenTags(const Value, TagI, TagF: String): String;
  function fTratarTag(strTag: String): String;
  begin
    Result :=
      strTag.Replace('/', '\/')
      .Replace('[', '\[')
      .Replace(']', '\]')
      .Replace('(', '\(')
      .Replace('(', '\)')
      .Replace('|', '\|')

  end;
var
  regEx : TRegEx;
begin
  regEx :=
    TRegEx.Create(Format('%s.+?%s', [fTratarTag(TagI), fTratarTag(TagF)]));

  result :=
    regEx.Match(Value).Value.Replace(TagI, '').Replace(TagF, '');
end;

end.
