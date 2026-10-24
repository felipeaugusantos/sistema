{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta MazaImobiliaria           *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoMazaImobiliaria;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX, PostgreSQLUniProvider, Uni;

type
  TAbstractGravandoExecucaoMazaImobiliaria = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    Provider : TPostgreSQLUniProvider;
    FConexao: TUniConnection;

    function fConexaoPostgreSQL(): TUniConnection;
    function fValidaPath(intContador: Integer) : Boolean;
    function fGetPath(intContador: Integer): String; virtual; abstract;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory, StrUtils;

{ TGravandoExecucaoMazaImobiliariaCores }

constructor TAbstractGravandoExecucaoMazaImobiliaria.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MZI');
  Provider := TPostgreSQLUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoMazaImobiliaria.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoMazaImobiliaria.fConexaoPostgreSQL: TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.Name := 'Conexao';
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'PostgreSQL';
    FConexao.Server := Conf.fGet('SERMZI');
    FConexao.Username := Conf.fGet('USUMZI');
    FConexao.Password := Conf.fGet('SENMZI');
    FConexao.Database := Conf.fGet('DBMZII');
    FConexao.Port := Conf.fGetInteger('PORMZI');
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

function TAbstractGravandoExecucaoMazaImobiliaria.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoMazaImobiliaria.fValidaPath(
  intContador: Integer): Boolean;
begin
  Result := True;

  If (Not FileExists(fGetPath(intContador))) Then
    Result := False;
end;



end.
