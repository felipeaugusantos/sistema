{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Killing           *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoKilling;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, InterBaseUniProvider, PostgreSQLUniProvider;

type
  TAbstractGravandoExecucaoKilling = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    FConexao: TUniConnection;
    Provider : TPostgreSQLUniProvider;

    function fConexaoPostgreSQL(): TUniConnection;

    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; Virtual; Abstract;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); Virtual; Abstract;
    function GetSqlDestino(): String; Virtual; Abstract;
    function GetDataSetDestino(): IDataSet; Virtual;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoKillingCores }

constructor TAbstractGravandoExecucaoKilling.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('KIL');
  Provider := TPostgreSQLUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoKilling.Destroy;
begin
  inherited;
  If Assigned(Provider) Then
    FreeAndNil(Provider);
end;

function TAbstractGravandoExecucaoKilling.fConexaoPostgreSQL: TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.Name := 'Conexao';
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'PostgreSQL';
    FConexao.Port := Conf.fGetInteger('PORKIL');
    FConexao.Server := Conf.fGet('SERKIL');
    FConexao.Username := Conf.fGet('USUKIL');
    FConexao.Password := Conf.fGet('SENKIL');
    FConexao.Database := Conf.fGet('DBKILL');
    FConexao.Database := Conf.fGet('DBKILL');
    FConexao.SpecificOptions.Values['PostgreSQL.UseUnicode'] := 'True';
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

function TAbstractGravandoExecucaoKilling.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;


function TAbstractGravandoExecucaoKilling.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

end.

