{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta International *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoInternational;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;


type
  TAbstractGravandoExecucaoInternational = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    GetInternational : TADOConnection;
    procedure GetArquivosProcessar(stlArquivos: TStringList);
    function fValidaPath : Boolean;
    function GetPath : String;
    function fGetAcessInternational(strPath:String): TADOConnection;
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

{ TGravandoExecucaoInternationalCores }


constructor TAbstractGravandoExecucaoInternational.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('INT');

end;

destructor TAbstractGravandoExecucaoInternational.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoInternational.fGetAcessInternational(strPath:String): TADOConnection;
begin
  If Not Assigned(GetInternational) Then
  Begin
    GetInternational := TADOConnection.Create(Nil);
    GetInternational.LoginPrompt := False;
    GetInternational.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=' + strPath +
      ';Persist Security Info=False';
  End;

  Result := GetInternational;
end;

function TAbstractGravandoExecucaoInternational.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoInternational.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

procedure TAbstractGravandoExecucaoInternational.GetArquivosProcessar(
  stlArquivos: TStringList);
begin
  stlArquivos.Text := conf.fGet('INTPAT');
end;

function TAbstractGravandoExecucaoInternational.GetPath: String;
begin
  Result := conf.fGet('INTPAT');
end;


end.
