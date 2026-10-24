unit Neocredit.Service;

interface

uses
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples,
  {$ENDIF LINUX}
  untBaseIntegracaoService, System.SysUtils, System.StrUtils, REST.Client;

type
  TServiceNeocredit = class(TBaseServico)
  strict protected
    function fValidaResposta: Boolean; override;
    procedure pConfigurarRequisicao; override;

  public
    function AnalisarCredito(const ALimiteCreditoJSON: String;
      out AJsonRetorno: String): Boolean;

    function ConsultarProcessoAnalisarCredito(const AIdConsulta: String;
      out AJsonRetorno: String): Boolean;
  end;

implementation

uses
  untConstantes, untTypesSistema, System.DateUtils, Neocredit.Classe;

{ TServiceNeocredit }

function TServiceNeocredit.AnalisarCredito(const ALimiteCreditoJSON: String;
  out AJsonRetorno: String): Boolean;
begin
  Try
    fPost;

    Requisicao
      .fRequestResource('/' + fCfgSis('NEOCCD') + '/integracao')
      .fBody(ALimiteCreditoJSON);

    pExecutar;

    Result := (Resposta.StatusCode = 200);
    AJsonRetorno := Resposta.Content;
  Except
    raise;
  End;
end;

function TServiceNeocredit.ConsultarProcessoAnalisarCredito(
  const AIdConsulta: String; out AJsonRetorno: String): Boolean;
begin
  Try
    fGet;

    Requisicao
      .fRequestResource('/' + Trim(AIdConsulta) + '/integracao');

    pExecutar;

    Result := (Resposta.StatusCode = 200);
    AJsonRetorno := Resposta.Content;
  Except
    raise;
  End;
end;

function TServiceNeocredit.fValidaResposta: Boolean;
begin
  Result := True;
end;

procedure TServiceNeocredit.pConfigurarRequisicao;
begin
  inherited;

  Requisicao
    .fAPI(TLibNeocredit.API_NEOCREDIT)
    .fAccept(CONTENT_TYPE)
    .fContentType(CONTENT_TYPE)
    .fBaseURL(fCfgSis('NEOCBU'))
    .fToken('Bearer '+ fCfgSis('NEOCTK'));
end;

end.
