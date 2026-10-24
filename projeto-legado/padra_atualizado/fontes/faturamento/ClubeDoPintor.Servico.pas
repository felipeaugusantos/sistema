unit ClubeDoPintor.Servico;

interface

uses
  untBaseIntegracaoService, untBaseIntegracaoJSON, ClubeDoPintor.Classes;

type
  TClubeDoPintorError = class(TBaseJSON)
  strict private
    FErro: String;
  public
    property Erro: String read FErro write FErro;
  End;

  TServicoClubeDoPintor = class (TBaseServico)
  strict protected
    function fValidaResposta: Boolean; override;
    procedure pConfigurarRequisicao; override;

  public
    function fPontuar(const objPontuar : TPontuar): Boolean;
    function fResgatar(const objResgatar : TResgatar): Boolean;

  End;

implementation

uses
  untConstantes, System.SysUtils, untTypesSistema, untFuncoesSimples;

{ TServicoClubeDoPintor }

function TServicoClubeDoPintor.fPontuar(const objPontuar: TPontuar): Boolean;
begin
  Try
    fPost;

    Requisicao
      .fRequestResource('/pontuar')
      .fBody(objPontuar.AsJson);

    pExecutar;

    Result := (Resposta.StatusCode = 200);
  Except
    raise;
  End;
end;

function TServicoClubeDoPintor.fResgatar(const objResgatar: TResgatar): Boolean;
begin
  Try
    fPost;

    Requisicao
      .fRequestResource('/resgatar')
      .fBody(objResgatar.AsJson);

    pExecutar;

    Result := (Resposta.StatusCode = 200);
  Except
    raise;
  End;
end;

function TServicoClubeDoPintor.fValidaResposta: Boolean;
var
  LErrorMessage : String;
  LError        : TClubeDoPintorError;
begin
  Try
    If Not Assigned(Resposta) Then
      LErrorMessage := 'Não foi possível obter uma resposta do servidor.'
    Else
    Begin
      Case Resposta.StatusCode of
        200 : LErrorMessage := EmptyStr;
        500 : LErrorMessage := 'Ocorreu um erro no servidor.';
        404 : LErrorMessage := 'Recurso não encontrado.';
        401 : LErrorMessage := 'API Key inválida.';
        400 : LErrorMessage := 'Dados inválidos na requisição.';
      End;
    End;

    Result := LErrorMessage.IsEmpty;
    If Not LErrorMessage.IsEmpty Then
    Begin
      Try
        LError := TClubeDoPintorError.Create;
        If Assigned(Resposta) Then
        Begin
          LError.AsJson := Resposta.Content;
          LErrorMessage := LErrorMessage + #13#10
                         + 'Status: ' + Resposta.StatusCode.ToString + #13#10
                         + LError.Erro;

        End;
      Finally
        FreeAndNil(LError);
      End;

      raise Exception.Create(LErrorMessage);
    End;
  Except
    On E:Exception Do
    Begin
      raise ExceptionAutCom.Create('Erro Clube do Pintor: '+#13#10+E.Message);
    End;
  End;
end;

procedure TServicoClubeDoPintor.pConfigurarRequisicao;
begin
  inherited;

  Requisicao
    .fAPI('CLUBE_DO_PINTOR')
    .fAccept(CONTENT_TYPE)
    .fContentType(CONTENT_TYPE)
    .fAddHeader(AUTHORIZATION, fCfgSis('CDPAPK'))
    .fBaseURL(fCfgSis('CDPURL'));
end;

end.
