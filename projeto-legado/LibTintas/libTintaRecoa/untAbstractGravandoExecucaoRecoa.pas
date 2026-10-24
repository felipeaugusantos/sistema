{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Recoa *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoRecoa;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet;

type
  TAbstractGravandoExecucaoRecoa = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    Conexao: TADOConnection;

    function fValidaPath : Boolean;
    function GetPath : String;
    function fConexaoRecoa():TADOConnection;

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

{ TGravandoExecucaoRecoaCores }

function TAbstractGravandoExecucaoRecoa.fConexaoRecoa: TADOConnection;
begin
  If Not Assigned(Conexao) Then
  Begin
    Conexao := TADOConnection.Create(Nil);
    Conexao.LoginPrompt := False;
    Conexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + GetPath +
      ';Persist Security Info=True';
  End;

  Result := Conexao;
end;

function TAbstractGravandoExecucaoRecoa.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

constructor TAbstractGravandoExecucaoRecoa.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('REC');

end;

destructor TAbstractGravandoExecucaoRecoa.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoRecoa.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoRecoa.GetPath: String;
begin
  Result := conf.fGet('PATREC');
end;


end.
