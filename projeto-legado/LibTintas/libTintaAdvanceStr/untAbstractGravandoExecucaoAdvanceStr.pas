{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta AdvanceStr *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoAdvanceStr;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX, PostgreSQLUniProvider, Uni;
type
  TAbstractGravandoExecucaoAdvanceStr = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    Provider : TPostgreSQLUniProvider;
    FConexao: TUniConnection;

    function fConexaoPostgreSQL(): TUniConnection;
    function fValidarPath(intContador: Integer; intDiretorio: Integer): Boolean;
    class function LimpaTexto(const strTexto: string): string;
    function LimpaCaracteres(const strTexto: string): string;
    //Abstract
    function GetSqlDestino(): string; virtual; abstract;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; virtual; abstract;
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; virtual; abstract;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); virtual; abstract;
    //Virtuais
    function GetDataSetDestino(): IDataSet; virtual;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils, untADOFactory,
   untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory;
{ TGravandoExecucaoAdvanceStrCores }


constructor TAbstractGravandoExecucaoAdvanceStr.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ADS');
  Provider := TPostgreSQLUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoAdvanceStr.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoAdvanceStr.fConexaoPostgreSQL: TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.Name := 'Conexao';
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'PostgreSQL';
    FConexao.Server := Conf.fGet('SERADS');
    FConexao.Username := Conf.fGet('USUADS');
    FConexao.Password := Conf.fGet('SENADS');
    FConexao.Database := Conf.fGet('DTBADS');
    FConexao.Port := Conf.fGetInteger('PORADS');
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

function TAbstractGravandoExecucaoAdvanceStr.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAdvanceStr.fValidarPath(intContador,
  intDiretorio: Integer): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath(intContador, intDiretorio)) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAbstractGravandoExecucaoAdvanceStr.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;
function TAbstractGravandoExecucaoAdvanceStr.LimpaCaracteres(
  const strTexto: string): string;
begin
  Result := TAutcomTintaFactory.Get.fTiraCaracEspeciaisPonto(strTexto);
end;

class function TAbstractGravandoExecucaoAdvanceStr.LimpaTexto(
  const strTexto: string): string;
begin
  Result := AnsiUpperCase(Trim(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;


end.
