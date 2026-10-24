{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Calamar *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoCalamar;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;


type
  TAbstractGravandoExecucaoCalamar = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    qryConexao: TADOConnection;
    GetCalamar: TADODataSet;
    function fValidaPath : Boolean;
    function GetPath : String;
    function GetDataSetCalamar(strPath:String):TADODataSet;
    function fConexaoCalamar(strPath:String):TADOConnection;
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

{ TGravandoExecucaoCalamarCores }


constructor TAbstractGravandoExecucaoCalamar.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('CAL');

end;

destructor TAbstractGravandoExecucaoCalamar.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoCalamar.GetDataSetCalamar(strPath: String): TADODataSet;
begin
    Result := TADODataSet.Create(Nil);
    Result.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=' + strPath +
    ';Persist Security Info=False';
end;

function TAbstractGravandoExecucaoCalamar.fConexaoCalamar(
  strPath: String): TADOConnection;
begin
  If Not Assigned(qryConexao) Then
  Begin
    qryConexao := TADOConnection.Create(Nil);
    qryConexao.LoginPrompt := False;
    qryConexao.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=' + strPath +
    ';Persist Security Info=False';
  End;

  Result := qryConexao;
end;

function TAbstractGravandoExecucaoCalamar.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoCalamar.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;


function TAbstractGravandoExecucaoCalamar.GetPath: String;
begin
  Result := conf.fGet('PATCAL');
end;

end.
