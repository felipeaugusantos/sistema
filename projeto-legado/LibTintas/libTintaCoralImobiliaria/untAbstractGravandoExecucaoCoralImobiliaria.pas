 {********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta CoralImobiliaria *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoCoralImobiliaria;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, PostgreSQLUniProvider, Uni;

type
  TAbstractGravandoExecucaoCoralImobiliaria = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    Provider : TPostgreSQLUniProvider;
    FConexao: TUniConnection;
    function fConexaoPostgreSQL(): TUniConnection;
    function fGetParteDescricao(): String;

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

Var
  arrOpcoes: Array [0..2] Of String = ('LOC', 'DTHC', 'SEM IDENTIFICAÇÃO DA VERSÃO');

implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoCoralImobiliariaCores }

constructor TAbstractGravandoExecucaoCoralImobiliaria.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('CIM');
  Provider := TPostgreSQLUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoCoralImobiliaria.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoCoralImobiliaria.fConexaoPostgreSQL: TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.Name := 'Conexao';
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'PostgreSQL';
    FConexao.Server := Conf.fGet('SERCOR');
    FConexao.Username := Conf.fGet('USUCOR');
    FConexao.Password := Conf.fGet('SENCOR');
    FConexao.Database := Conf.fGet('DTBCOR');
    FConexao.Port := Conf.fGetInteger('PORCOR');
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

function TAbstractGravandoExecucaoCoralImobiliaria.fGetParteDescricao: String;
Var
  intOpcao: Integer;
begin
  intOpcao := TAutcomTintaFactory.Get.fGetMenu('Gerar as fórmulas na versão:', arrOpcoes, 3);

  If intOpcao = 3 Then
    Result := ''
  Else
    Result := arrOpcoes[intOpcao-1];
end;


function TAbstractGravandoExecucaoCoralImobiliaria.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;


function TAbstractGravandoExecucaoCoralImobiliaria.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

end.
