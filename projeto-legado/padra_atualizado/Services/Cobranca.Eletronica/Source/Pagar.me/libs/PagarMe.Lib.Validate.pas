unit PagarMe.Lib.Validate;

interface

uses
  untBaseIntegracaoJSON, Generics.Collections, System.JSON, REST.Json.Types;

{$M+}
type
  TError = class sealed(TBaseJSON)
  strict private
    FMessage: String;
    [JSONName('parameter_name')]
    FParameterName: String;
    FType: String;
  public
    property &Message: String read FMessage write FMessage;
    property ParameterName: String read FParameterName write FParameterName;
    property &Type: String read FType write FType;
  end;

  TErrorPagarMe = class sealed(TBaseJSON)
  strict private
    [JSONName('errors')]
    FErrorsArray: TArray<TError>;
    [JSONMarshalled(False)]
    FErrors: TObjectList<TError>;
    FMethod: String;
    FUrl: String;

    function GetErrors: TObjectList<TError>;
  strict protected
    function GetAsJson: String; override;
  published
    property Errors: TObjectList<TError> read GetErrors;
    property Method: String read FMethod write FMethod;
    property Url: String read FUrl write FUrl;
  public
    destructor Destroy; override;
  end;

  TValidatePagarMe = class
  public
    class function fValidaResposta(const AStatusCode: Integer;
      const AContent: String): Boolean;
  end;

implementation

uses
  PagarMe.Lib.Dicionario, System.SysUtils;

{ TValidatePagarMe }

class function TValidatePagarMe.fValidaResposta(const AStatusCode: Integer;
  const AContent: String): Boolean;
var
  LErrorMessage : String;
  LErrorList    : TErrorPagarMe;
  LErrorItem    : TError;
begin
  try
    case AStatusCode of
      200 : LErrorMessage := '';
    else
      if AContent.IsEmpty then
        LErrorMessage := 'Sem informações sobre o erro.'
      else
      begin
        case AStatusCode of
          500 : LErrorMessage := 'Ocorreu um erro interno.';
          429 : LErrorMessage := 'Quantidade de requisições realizadas pelo IP maior que o permitido pela Pagar.me.';
          422 : LErrorMessage := 'Parâmetros inválidos.';
          412 : LErrorMessage := 'Parâmetros válidos mas a requisição falhou.';
          404 : LErrorMessage := 'O recurso solicitado não existe.';
          401 : LErrorMessage := 'Chave de API inválida.';
          400 : LErrorMessage := 'Requisição inválida.';
        end;

        LErrorList := TErrorPagarMe.Create;
        try
          LErrorList.AsJson := AContent;
          for LErrorItem in LErrorList.Errors do
          begin
            LErrorMessage := LErrorMessage
                           + #13#10
                           + '- '+LErrorItem.&Message
                           + #13#10
                           + '  Tipo: '+TDicionarioPagarMe.GetInstance.ErrosApi.fValor(LErrorItem.&Type);
          end;
        finally
          LErrorList.Free;
        end;
      end;
    end;

    Result := Trim(LErrorMessage) = '';

    if (Trim(LErrorMessage) <> '') then
      raise Exception.Create(LErrorMessage);
  except
    raise;
  end;
end;

{ TErrorPagarMe }

destructor TErrorPagarMe.Destroy;
begin
  GetErrors.Free;
  inherited;
end;

function TErrorPagarMe.GetAsJson: String;
begin
  RefreshArray<TError>(FErrors, FErrorsArray);
  Result := inherited;
end;

function TErrorPagarMe.GetErrors: TObjectList<TError>;
begin
  Result := ObjectList<TError>(FErrors, FErrorsArray);
end;

end.
