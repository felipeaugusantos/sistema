{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta RennerIndustrial *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoRennerIndustrial;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet;

type
  TAbstractGravandoExecucaoRennerIndustrial = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    GetRennerIndustrial: TADOConnection;
    GetRennerCores:TADOConnection;

    function fValidaPath : Boolean;
    function fGetDataRenner(strPath:String):TADOConnection;
    function fGetDataCores(strPath:String):TADOConnection;
    function GetPath : String;

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

{ TGravandoExecucaoRennerIndustrialCores }


constructor TAbstractGravandoExecucaoRennerIndustrial.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('REN');


end;

destructor TAbstractGravandoExecucaoRennerIndustrial.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoRennerIndustrial.fGetDataCores(
  strPath: String): TADOConnection;
begin
  If Not Assigned(GetRennerCores) Then
  Begin
    GetRennerCores := TADOConnection.Create(Nil);
    GetRennerCores.LoginPrompt := False;
    GetRennerCores.ConnectionString := 'Driver={Microsoft Access Driver (*.mdb)}; Dbq=' + strPath +
                                       '; Uid=Admin; Pwd=;';
  End;

  Result := GetRennerCores;
end;

function TAbstractGravandoExecucaoRennerIndustrial.fGetDataRenner(strPath:String): TADOConnection;
begin
  If Not Assigned(GetRennerIndustrial) Then
  Begin
    GetRennerIndustrial := TADOConnection.Create(Nil);
    GetRennerIndustrial.LoginPrompt := False;
    GetRennerIndustrial.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
                                            ';Persist Security Info=True';
  End;

  Result := GetRennerIndustrial;
end;

function TAbstractGravandoExecucaoRennerIndustrial.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoRennerIndustrial.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoRennerIndustrial.GetPath: String;
begin
  Result := conf.fGet('PATREN');
end;


end.
