  unit FrenetWS.Classes;

interface

  Type

  TFrenetWS = class
  private
    FstrTokenIntegracao           : String;
    FstrURLIntegracao             : String;
    function fExtractBetweenTags(const Value, TagI, TagF: String): String;
    function fTratarTag(strTag: String): String;
  public
    constructor Create;
    function fComunicar(var AintCodigoRetorno : Integer; var AstrMensagemRetorno : String ; AstrJson: String = ''): String;
  end;

implementation

uses
  REST.Client, REST.Types, SysUtils, REST.Json, IPPeerCommon, IPPeerClient,
  IPPeerServer, untConstantes, IdMultipartFormData, IdHTTP, IdURI, Classes,
  IOUtils, Forms, System.NetEncoding, untFuncoes, Graphics, DateUtils,
  Web.HTTPApp, untFuncoesSimples, RegularExpressions;

{ TFrenetWS }

constructor TFrenetWS.Create;
begin
  inherited;
  FstrTokenIntegracao := fCfgSis('FRETOK', varString);
  FstrURLIntegracao   := fCfgSis('FREURL', varString);
end;

function TFrenetWS.fComunicar(var AintCodigoRetorno : Integer; var AstrMensagemRetorno : String ; AstrJson: String = ''): String;
var
  LRESTClient1   : TRESTClient;
  LRESTRequest1  : TRESTRequest;
  LRESTResponse1 : TRESTResponse;
  LPostData      : TStringStream;
  LParamRequest  : TRESTRequestParameter;
begin
  LRESTClient1   := nil;
  LRESTRequest1  := nil;
  LRESTResponse1 := nil;

  try
    try

      Sleep(250);
      LRESTClient1             := TRESTClient.Create(nil);
      LRESTClient1.ContentType := 'application/json';
      LRESTClient1.BaseURL     := FstrURLIntegracao;

      LRESTRequest1        := TRESTRequest.Create(nil);
      LRESTRequest1.Accept := 'application/json';
      LRESTRequest1.Params.AddHeader('Token', FstrTokenIntegracao);

      LRESTRequest1.Method := TRESTRequestMethod.rmPOST;

      LRESTRequest1.Timeout := 10000;
      LRESTRequest1.HandleRedirects := True;

      LRESTResponse1 := TRESTResponse.Create(nil);

      LRESTRequest1.Client   := LRESTClient1;
      LRESTRequest1.Response := LRESTResponse1;

      LPostData                 := TStringStream.Create(AstrJson, TEncoding.UTF8);

      LParamRequest             := LRESTRequest1.Params.AddItem();
      LParamRequest.Value       := LPostData.DataString;
      LParamRequest.ContentType := ctAPPLICATION_JSON;

      LRESTRequest1.Execute;

      try
        AintCodigoRetorno   := LRESTResponse1.StatusCode;

        if LRESTResponse1.StatusCode >= 400 then
        Begin
          if LRESTResponse1.StatusCode = 404 then
            AstrMensagemRetorno := 'URL de integração inválida!'
          Else
            AstrMensagemRetorno := fExtractBetweenTags(LRESTResponse1.Content,'"Message":"','",');

          Result := '*' +LRESTResponse1.Content;

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

    FreeAndNil(LRESTClient1);

    FreeAndNil(LRESTRequest1);

    FreeAndNil(LRESTResponse1);
  end;
end;

function TFrenetWS.fExtractBetweenTags(const Value, TagI, TagF: String): String;
var
  regEx : TRegEx;
begin
  regEx :=
    TRegEx.Create(Format('%s.+?%s', [fTratarTag(TagI), fTratarTag(TagF)]));

  result :=
    regEx.Match(Value).Value.Replace(TagI, '').Replace(TagF, '');
end;

function TFrenetWS.fTratarTag(strTag: String): String;
begin
  Result :=
    strTag.Replace('/', '\/')
    .Replace('[', '\[')
    .Replace(']', '\]')
    .Replace('(', '\(')
    .Replace('(', '\)')
    .Replace('|', '\|');
end;

end.
