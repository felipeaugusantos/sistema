{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoMazaAutomotiva;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX, Uni, InterBaseUniProvider, PostgreSQLUniProvider;

type
  TAbstractGravandoExecucaoMazaAutomotiva = class(TInterfacedObject, IGravandoExecucaoNome)
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
  untAutcomTintaFactory, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory, StrUtils;

{ TGravandoExecucaoMazaAutomotivaCores }


constructor TAbstractGravandoExecucaoMazaAutomotiva.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MZA');
  Provider := TPostgreSQLUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoMazaAutomotiva.Destroy;
begin
  inherited;
  If Assigned(Provider) Then
    FreeAndNil(Provider);
end;

function TAbstractGravandoExecucaoMazaAutomotiva.fConexaoPostgreSQL: TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.Name := 'Conexao';
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'PostgreSQL';
    FConexao.Port := Conf.fGetInteger('PORMZA');
    FConexao.Server := Conf.fGet('SERMZA');
    FConexao.Username := Conf.fGet('USUMZA');
    FConexao.Password := Conf.fGet('SENMZA');
    FConexao.Database := LowerCase(Conf.fGet('DBMZAA'));
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

function TAbstractGravandoExecucaoMazaAutomotiva.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
