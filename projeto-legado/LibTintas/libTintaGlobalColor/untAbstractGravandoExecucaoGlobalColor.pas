{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta GlobalColor *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoGlobalColor;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet;

type
  TAbstractGravandoExecucaoGlobalColor = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    function fValidaPath : Boolean;
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

{ TGravandoExecucaoGlobalColorCores }

constructor TAbstractGravandoExecucaoGlobalColor.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('GLO');

end;

destructor TAbstractGravandoExecucaoGlobalColor.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoGlobalColor.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoGlobalColor.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoGlobalColor.GetPath: String;
begin
  Result := conf.fGet('PATGLO');
end;


end.
