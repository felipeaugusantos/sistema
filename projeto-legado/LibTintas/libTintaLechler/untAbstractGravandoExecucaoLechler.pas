{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lechler *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoLechler;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;


type
  TAbstractGravandoExecucaoLechler = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
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

{ TGravandoExecucaoLechlerCores }


constructor TAbstractGravandoExecucaoLechler.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LEC');

end;

destructor TAbstractGravandoExecucaoLechler.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoLechler.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
