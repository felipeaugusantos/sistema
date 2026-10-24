{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Ciacolor *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoCiacollor;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, ActiveX, untStatusGravando, Windows, Uni, SQLiteUniProvider;

type
  TAbstractGravandoExecucaoCiacollor = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    FConexao: TUniConnection;
    Provider : TSQLiteUniProvider;
    function fConexaoSQLiteStudio(): TUniConnection;
    function fValidarPath(intContador: Integer; intDiretorio: Integer): Boolean;
    function fFormataAutInc(const intAutInc: Integer; strAutoIncremAntigo: String): String;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; virtual; abstract;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
    procedure Executar(const gravando: IGravando); virtual; abstract;
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils, untADOFactory;


{ TGravandoExecucaoCiacollorCores }


constructor TAbstractGravandoExecucaoCiacollor.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('CIA');
  Provider := TSQLiteUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoCiacollor.Destroy;
begin
  inherited;

  If Assigned(FConexao) Then
    FreeAndNil(FConexao);
end;

function TAbstractGravandoExecucaoCiacollor.fConexaoSQLiteStudio(): TUniConnection;
begin
  FConexao := TUniConnection.Create(Nil);

  Try
    FConexao.LoginPrompt := False;
    FConexao.ProviderName := 'Sqlite';
    FConexao.Database := fGetPath(1, 1);
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

function TAbstractGravandoExecucaoCiacollor.fFormataAutInc(
  const intAutInc: Integer; strAutoIncremAntigo: String): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');

  If Result = strAutoIncremAntigo Then
  Begin
    Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc + 1) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
  End;
end;

function TAbstractGravandoExecucaoCiacollor.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoCiacollor.fValidarPath(intContador,
  intDiretorio: Integer): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath(intContador, intDiretorio)) Then
  Begin
    Result := False;
    Exit;
  End;
end;


end.
