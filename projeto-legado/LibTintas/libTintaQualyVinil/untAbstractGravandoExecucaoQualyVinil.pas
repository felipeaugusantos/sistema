{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta QualyVinil *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoQualyVinil;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, InterBaseUniProvider;


type
  TAbstractGravandoExecucaoQualyVinil = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    Provider : TInterBaseUniProvider;

    function fConexaoQualyVinilMaker(): TUniConnection;
    function fConexaoQualyVinilLocal(): TUniConnection;
    function fGetPathMaker(): String;
    function fGetPathLocal(): String;
    function fValidaPath(): Boolean;

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

{ TGravandoExecucaoQualyVinilCores }


constructor TAbstractGravandoExecucaoQualyVinil.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('QUA');
  Provider := TInterBaseUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoQualyVinil.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoQualyVinil.fConexaoQualyVinilLocal: TUniConnection;
begin
  Result := TUniConnection.Create(Nil);

  Try
    Result.Database := fGetPathLocal;
    Result.Username := Conf.fGet('QUSUAR');
    Result.Password := Conf.fGet('QSENHA');
    Result.Server   := Conf.fGet('SERVER');
    Result.Port     := Conf.fGetInteger('QPORTA');
    Result.ProviderName := 'Interbase';
    Result.Connect;
  Except
    On E: Exception Do
    Begin
      Result := Nil;
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro ao tentar conexão com o banco de dados!' + #13 +
        e.Message , ['&OK']);
    End;
  End;
end;

function TAbstractGravandoExecucaoQualyVinil.fConexaoQualyVinilMaker: TUniConnection;
begin
  Result := TUniConnection.Create(Nil);

  Try
    Result.Database := fGetPathMaker;
    Result.Username := Conf.fGet('QUSUAR');
    Result.Password := Conf.fGet('QSENHA');
    Result.Server   := Conf.fGet('SERVER');
    Result.Port     := Conf.fGetInteger('QPORTA');
    Result.ProviderName := 'Interbase';
    Result.Connect;
  Except
    On E: Exception Do
    Begin
      Result := Nil;
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro ao tentar conexão com o banco de dados!' + #13 +
        e.Message , ['&OK']);
    End;
  End;

  //FreeAndNil(qryConexao);
end;

function TAbstractGravandoExecucaoQualyVinil.fGetPathLocal: String;
begin
  Result := Conf.fGet('PATLOC');
end;

function TAbstractGravandoExecucaoQualyVinil.fGetPathMaker: String;
begin
  Result := Conf.fGet('PATMAR');
end;

function TAbstractGravandoExecucaoQualyVinil.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoQualyVinil.fValidaPath: Boolean;
begin
  Result := True;

  If Not FileExists(fGetPathLocal) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not FileExists(fGetPathMaker) Then
  Begin
    Result := False;
    Exit;
  End;

end;

end.
