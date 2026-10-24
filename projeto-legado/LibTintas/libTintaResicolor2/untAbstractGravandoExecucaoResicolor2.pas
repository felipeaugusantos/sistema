{***********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Resicolor 2         *}
{********************************************************************************************PH*}
unit untAbstractGravandoExecucaoResicolor2;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, PostgreSQLUniProvider;

type
  TAbstractGravandoExecucaoResicolor2 = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    Conf: IConfTinta;
    function fGetPath: String;
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

{ TGravandoExecucaoResicolor2Cores }



constructor TAbstractGravandoExecucaoResicolor2.Create;
begin
  inherited Create;
  Conf := TAutcomTintaFactory.Get.fGetConfTinta('RS2');
end;

destructor TAbstractGravandoExecucaoResicolor2.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoResicolor2.fGetPath: String;
begin
  Result := Conf.fGet('PATRS2');
end;

function TAbstractGravandoExecucaoResicolor2.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;


end.

