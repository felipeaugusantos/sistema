{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Sparlack           *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoSparlack;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet;

type
  TAbstractGravandoExecucaoSparlack = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    qryCadBas,
    qryCadCol,
    qryCadSpa: IDataSet;

    strPath: String;

    procedure CarregarDados;
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

Const
  arrUnidades: Array[1..3] of String = ('QT', 'GL', 'BL');

implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoSparlackCores }

procedure TAbstractGravandoExecucaoSparlack.CarregarDados;
begin
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.SQL := ' SELECT * ' +
                   '   FROM SPA_CADBAS ';

  qryCadBas.Open;

  qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadCol.SQL := ' SELECT * ' +
                   '   FROM SPA_CADCOL ';
  qryCadCol.Open;

  qryCadSpa := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadSpa.SQL := ' SELECT * ' +
                   '   FROM SPA_CADSPA' +
                   '  WHERE FALSE ';
  qryCadSpa.Open;
end;

constructor TAbstractGravandoExecucaoSparlack.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SPA');

  strPath := '';

  CarregarDados;
end;

destructor TAbstractGravandoExecucaoSparlack.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoSparlack.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoSparlack.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoSparlack.fValidaPath : Boolean;
begin
  Result := True;

  If (Not DirectoryExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoSparlack.GetPath: String;
begin
  Result := conf.fGet('PATSPA');

  strPath := Result;
end;

function TAbstractGravandoExecucaoSparlack.GetUnidade(const fltVolume: Double): string;
begin
  if RoundTo(fltVolume, -3) <= 0.9 then
    Result := 'LT'
  else if RoundTo(fltVolume, -3) <= 3.6 then
    Result := 'GL'
  else
    Result := 'LA';
end;

end.
