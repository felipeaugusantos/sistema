{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoKillingIndustrial;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, InterBaseUniProvider;
type
  TAbstractGravandoExecucaoKillingIndustrial = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    qryConexao: TUniConnection;
    Provider : TInterBaseUniProvider;

    function fConexaoKilling(): TUniConnection;
    function fGetPath(): String;
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
  untStrUtils, untAutcomTintaFactory;

{ TGravandoExecucaoKillingIndustrialCores }


constructor TAbstractGravandoExecucaoKillingIndustrial.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('KIN');
  Provider := TInterBaseUniProvider.Create(Nil);
end;

destructor TAbstractGravandoExecucaoKillingIndustrial.Destroy;
begin
  inherited;
  If Assigned(Provider) Then
    FreeAndNil(Provider);

  If Assigned(qryConexao) Then
    FreeAndNil(qryConexao);
end;


function TAbstractGravandoExecucaoKillingIndustrial.fConexaoKilling: TUniConnection;
begin
  qryConexao := TUniConnection.Create(Nil);

  Try
    qryConexao.Database := fGetPath;
    qryConexao.Username := Conf.fGet('KUSUAR');
    qryConexao.Password := Conf.fGet('KSENHA');
    qryConexao.Server   := Conf.fGet('SERVER');
    qryConexao.Port     := Conf.fGetInteger('KPORTA');
    qryConexao.ProviderName := 'Interbase';
    qryConexao.Connect;

    Result := qryConexao;
  Except
    On E: Exception Do
    Begin
      Result := Nil;
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro ao tentar conexão com o banco de dados!' + #13 +
        e.Message , ['&OK']);
    End;
  End;
end;

function TAbstractGravandoExecucaoKillingIndustrial.fGetPath: String;
begin
  Result := Conf.fGet('KINPAT');
end;

function TAbstractGravandoExecucaoKillingIndustrial.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoKillingIndustrial.fValidaPath: Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath) Then
    Result := False;
end;

end.
