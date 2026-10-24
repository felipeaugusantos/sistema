{***********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Anjo Imobiliaria 2 *}
{********************************************************************************************PH*}
unit untAbstractGravandoExecucaoAnjoImobiliaria2;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, PostgreSQLUniProvider;

type
  TAbstractGravandoExecucaoAnjoImobiliaria2 = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    Conf: IConfTinta;
    Provider : TPostgreSQLUniProvider;
    FConexao: TUniConnection;
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

{ TGravandoExecucaoAnjoImobiliaria2Cores }



constructor TAbstractGravandoExecucaoAnjoImobiliaria2.Create;
begin
  inherited Create;
  Conf := TAutcomTintaFactory.Get.fGetConfTinta('AN2');
end;

destructor TAbstractGravandoExecucaoAnjoImobiliaria2.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoAnjoImobiliaria2.fConexaoPostgreSQL: TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.Name := 'Conexao';
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'PostgreSQL';
    FConexao.Server := Conf.fGet('SERAN2');
    FConexao.Username := Conf.fGet('USEAN2');
    FConexao.Password := Conf.fGet('PASAN2');
    FConexao.Database := Conf.fGet('DATAN2');
    FConexao.Port := Conf.fGetInteger('PORAN2');
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

function TAbstractGravandoExecucaoAnjoImobiliaria2.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAnjoImobiliaria2.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

end.

