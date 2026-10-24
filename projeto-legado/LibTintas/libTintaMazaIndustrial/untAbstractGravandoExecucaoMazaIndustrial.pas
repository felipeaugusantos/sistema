{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoMazaIndustrial;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX, Uni, InterBaseUniProvider, PostgreSQLUniProvider;

type
  TAbstractGravandoExecucaoMazaIndustrial = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoMazaIndustrialCores }


constructor TAbstractGravandoExecucaoMazaIndustrial.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MZD');
  Provider := TPostgreSQLUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoMazaIndustrial.Destroy;
begin
  inherited;
  If Assigned(Provider) Then
    FreeAndNil(Provider);
end;

function TAbstractGravandoExecucaoMazaIndustrial.fConexaoPostgreSQL: TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.Name := 'Conexao';
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'PostgreSQL';
    FConexao.Port := Conf.fGetInteger('PORMZD');
    FConexao.Server := Conf.fGet('SERMZD');
    FConexao.Username := Conf.fGet('USUMZD');
    FConexao.Password := Conf.fGet('SENMZD');
    FConexao.Database := LowerCase(Conf.fGet('DBMZDD'));
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

function TAbstractGravandoExecucaoMazaIndustrial.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
