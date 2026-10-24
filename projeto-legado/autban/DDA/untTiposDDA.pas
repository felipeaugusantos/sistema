unit untTiposDDA;

interface

Uses untFuncoesSimples, System.SysUtils, System.Classes, System.StrUtils;

type
  TDDAAPIDadosCarteira = class
  private
    FBanco: string;
    FConfiguracao: string;
    FCodigoEmpresa: string;

    FHomologacao: string;
    FClientId: string;
    FClientSecret: string;
    FChaveBasic: string;
    FCertificadoPfx: string;
    FSenhaCertificado: string;
    FContaCorrente: string;
    FCodigoAgencia: string;
    FDigitoAgencia: string;
    FDigitoContaCorrente: string;

    function ExtrairUltimaParteAposHifen(const ATexto: string): string;
    function TextoEhNumerico(const ATexto: string): Boolean;

  public
    constructor Create(ACodigoBanco, AConfiguracao: String); overload;

    function NumeroCarteiraSelecionada: string;

    procedure Recarregar;
    property Banco: string read FBanco;
    property Configuracao: string read FConfiguracao;
    property CodigoEmpresa: string read FCodigoEmpresa write FCodigoEmpresa;
    property Homologacao: string read FHomologacao;
    property ClientId: string read FClientId;
    property ClientSecret: string read FClientSecret;
    property ChaveBasic: string read FChaveBasic;
    property CertificadoPfx: string read FCertificadoPfx;
    property SenhaCertificado: string read FSenhaCertificado;
    property ContaCorrente: string read FContaCorrente;
    property CodigoBanco: string read FBanco;
    property CodigoAgencia: string read FCodigoAgencia;
    property DigitoAgencia: string read FDigitoAgencia;
    property DigitoContaCorrente: string read FDigitoContaCorrente;
end;

const
  NOME_OCORRENCIA_DDA: array[0..6, 0..1] of string = (
    ('1', 'Em aberto'),
    ('2', 'Agendado'),
    ('3', 'Liquidado'),
    ('4', 'Baixado'),
    ('5', 'Cancelado'),
    ('6', 'Vencido'),
    ('0', 'Desconhecida')
  );

implementation

{ TDDAAPIDadosCarteira }

constructor TDDAAPIDadosCarteira.Create(ACodigoBanco, AConfiguracao: String);
begin
  inherited Create;
  FBanco        := ACodigoBanco;
  FConfiguracao := AConfiguracao;

  FCodigoEmpresa := ExtrairUltimaParteAposHifen(AConfiguracao);
  if not TextoEhNumerico(FCodigoEmpresa) then
    FCodigoEmpresa := EmptyStr;

  Recarregar;
end;

function TDDAAPIDadosCarteira.ExtrairUltimaParteAposHifen(
  const ATexto: string): string;
var
  LPosicaoHifen: Integer;
begin
  LPosicaoHifen := LastDelimiter('-', ATexto);
  if LPosicaoHifen > 0 then
    Result := Copy(ATexto, LPosicaoHifen + 1, MaxInt)
  else
    Result := EmptyStr;
end;

function TDDAAPIDadosCarteira.NumeroCarteiraSelecionada: string;
var
  LPosicaoHifen: Integer;
  LSufixoNumerico: string;
begin
  Result := EmptyStr;
  LPosicaoHifen := LastDelimiter('-', FConfiguracao);
  if LPosicaoHifen > 0 then
  begin
    LSufixoNumerico := Copy(FConfiguracao, LPosicaoHifen + 1, MaxInt);
    if TextoEhNumerico(LSufixoNumerico) then
      Exit(LSufixoNumerico);
  end;
  Result := '1';
end;

procedure TDDAAPIDadosCarteira.Recarregar;
begin
  FClientId         := fGetBancoConfig(0, FConfiguracao, 'CLIENT_ID', EmptyStr);
  FClientSecret     := fGetBancoConfig(0, FConfiguracao, 'CLIENT_SECRET', EmptyStr);
  FChaveBasic       := fGetBancoConfig(0, FConfiguracao, 'AUTHORIZATION', EmptyStr);
  FCertificadoPfx   := fGetBancoConfig(0, FConfiguracao, 'AUTHPFX', EmptyStr);
  FSenhaCertificado := fGetBancoConfig(0, FConfiguracao, 'AUTHSEN', EmptyStr);
  FContaCorrente    := fGetBancoConfig(0, FConfiguracao, 'NUMCTAC', EmptyStr);
  FHomologacao      := fGetBancoConfig(0, FConfiguracao, 'HOMOLOGACAO', 'N');
  FCodigoAgencia           := fGetBancoConfig(0, FConfiguracao, 'CODAGEN', EmptyStr);
  FDigitoAgencia           := fGetBancoConfig(0, FConfiguracao, 'DIGAGEN', EmptyStr);
  FDigitoContaCorrente     := fGetBancoConfig(0, FConfiguracao, 'DIGCTAC', EmptyStr);
end;

function TDDAAPIDadosCarteira.TextoEhNumerico(const ATexto: string): Boolean;
var
  LIndiceCaractere: Integer;
begin
  Result := (ATexto <> EmptyStr);
  for LIndiceCaractere := 1 to Length(ATexto) do
    if not CharInSet(ATexto[LIndiceCaractere], ['0'..'9']) then
      Exit(False);
end;

end.
