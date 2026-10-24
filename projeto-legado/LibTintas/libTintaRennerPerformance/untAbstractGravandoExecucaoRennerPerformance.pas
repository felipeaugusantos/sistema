{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta RennerPerformance *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoRennerPerformance;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;


type
  TAbstractGravandoExecucaoRennerPerformance = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    function fGetPath(): String;
    function fValidarDiretorio(strPath: String): Boolean;

    function IsRegistroExistente(qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer): Boolean; Virtual; Abstract;
    Procedure GravarRegistro(qryDestino: IDataSet; Excel: OleVariant; intLinha: Integer); Virtual; Abstract;
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

{ TGravandoExecucaoRennerPerformanceCores }


constructor TAbstractGravandoExecucaoRennerPerformance.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('REP');
end;

destructor TAbstractGravandoExecucaoRennerPerformance.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoRennerPerformance.fGetPath: String;
begin
  Result := Conf.fGet('REPPAT');
end;

function TAbstractGravandoExecucaoRennerPerformance.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoRennerPerformance.fValidarDiretorio(
  strPath: String): Boolean;
begin
  Result := True;

  If Not DirectoryExists(strPath) Then
  Begin
    Result := False;
    Exit;
  End;
end;

end.
