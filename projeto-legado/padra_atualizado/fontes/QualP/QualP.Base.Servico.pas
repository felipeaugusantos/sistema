unit QualP.Base.Servico;

interface

uses
  untBaseIntegracaoService, untBaseIntegracaoJSON;

type
  TQualPError = class(TBaseJSON)
  private
    FMessage: String;
  public
    property &Message: String read FMessage write FMessage;
  end;

  TBaseServicoQualP = class abstract(TBaseServico)
  strict protected
    function fValidaResposta: Boolean; override;

  end;

implementation

uses
  untConstantes, System.SysUtils, untTypesSistema;

{ TBaseServicoQualP }

function TBaseServicoQualP.fValidaResposta: Boolean;
var
  LErrorMessage : String;
  LError        : TQualPError;
begin
  try
    if not Assigned(Resposta) then
      LErrorMessage := 'Não foi possível obter uma resposta do servidor.'
    else
    begin
      case Resposta.StatusCode of
        200 : LErrorMessage := EmptyStr;
        500 : LErrorMessage := 'Ocorreu um erro no servidor.';
        404 : LErrorMessage := 'A requisição não foi encontrada.';
        400 : LErrorMessage := 'Existem informações não preenchidas corretamente na requisição.';
      else
        try
          LError := TQualPError.Create;
          if Assigned(Resposta) then
          begin
            LError.AsJson := Resposta.Content;
            LErrorMessage := LError.Message;
          end;
        finally
          FreeAndNil(LError);
        end;
      end;
    end;

    Result := LErrorMessage.IsEmpty;
    if not LErrorMessage.IsEmpty then
      raise ExceptionAutcom.Create(LErrorMessage);
  except
    raise;
  end;
end;

end.
