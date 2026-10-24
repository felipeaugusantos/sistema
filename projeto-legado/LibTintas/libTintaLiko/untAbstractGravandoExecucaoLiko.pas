{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Liko *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoLiko;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet;

type
  TAbstractGravandoExecucaoLiko = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    function GetUnidade(const fltVolume: Double): string;
    function fFormataAutInc(const intAutInc: Integer): String;
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

{ TGravandoExecucaoLikoCores }


constructor TAbstractGravandoExecucaoLiko.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LIK');


end;

destructor TAbstractGravandoExecucaoLiko.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoLiko.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;


function TAbstractGravandoExecucaoLiko.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoLiko.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoLiko.GetPath: String;
begin
  Result := conf.fGet('PATLIK');
end;

function TAbstractGravandoExecucaoLiko.GetUnidade(const fltVolume: Double): string;
begin
  if RoundTo(fltVolume, -3) <= 0.9 then
    Result := 'LT'
  else if RoundTo(fltVolume, -3) <= 3.6 then
    Result := 'GL'
  else
    Result := 'LA';
end;

end.
