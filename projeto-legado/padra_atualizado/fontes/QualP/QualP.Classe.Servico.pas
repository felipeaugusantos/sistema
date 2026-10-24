unit QualP.Classe.Servico;

interface

uses
  QualP.Base.Servico, QualP.Classe.Requisicao, QualP.Classe.Resposta;

type
  TServicoQualP = class (TBaseServicoQualP)
  protected
    procedure pConfigurarRequisicao; override;

  public
    function fInformacoesQualp(
      const ARequisicao: TRequisicaoQualP):TRespostaQualP;

  end;

implementation

uses
  untFuncoesSimples, untBaseIntegracaoService, System.JSON, REST.Json;

{ TServicoQualP }

function TServicoQualP.fInformacoesQualp(
  const ARequisicao: TRequisicaoQualP): TRespostaQualP;
begin
  try
    fGet;

    Requisicao
      .fAddParam('json',ARequisicao.AsJson);

    pExecutar;

    Result := TRespostaQualP.Create;
    Result.AsJson := Resposta.Content;
  except
    raise;
  end;
end;

procedure TServicoQualP.pConfigurarRequisicao;

begin
  inherited;
  Requisicao
    .fAPI('QUALP')
    .fAccept(CONTENT_TYPE)
    .fContentType(CONTENT_TYPE)
    .fAddHeader('Access-Token', fCfgSis('QLPTOK'))
    .fBaseURL(fCfgSis('QLPURL'));
end;


end.

