{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoAnjoAutomotiva;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet,
  PostgreSQLUniProvider, Uni;

type
  TAbstractGravandoExecucaoAnjoAutomotiva = class(TInterfacedObject, IGravandoExecucaoNome)
  private
  protected
    conf: IConfTinta;
    FConexao: TUniConnection;
    Provider : TPostgreSQLUniProvider;

    function fConexaoPostgreSQL(): TUniConnection;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoAnjoAutomotivaCores }

constructor TAbstractGravandoExecucaoAnjoAutomotiva.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('AJT');
end;

destructor TAbstractGravandoExecucaoAnjoAutomotiva.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoAnjoAutomotiva.fConexaoPostgreSQL: TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.Name := 'Conexao';
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'PostgreSQL';
    FConexao.Port := Conf.fGetInteger('PORANJ');
    FConexao.Server := Conf.fGet('SERANJ');
    FConexao.Username := Conf.fGet('USUANJ');
    FConexao.Password := Conf.fGet('SENANJ');
    FConexao.Database := Conf.fGet('DTBANJ');
    FConexao.Connect;

    Result := FConexao;
  Except
    On E: Exception Do
    Begin
      Result := Nil;
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro ao tentar conexão com o banco de dados!' + #13 +
        e.Message , ['&OK']);
    End;
  End;
end;

function TAbstractGravandoExecucaoAnjoAutomotiva.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.

