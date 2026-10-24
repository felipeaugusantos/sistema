{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoGeneral;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoGeneral = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected

    conf: IConfTinta;

    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath: Boolean;
    function GetPath: String;
    function fCfgTin(strNome: String): String;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoGeneralCores }

constructor TAbstractGravandoExecucaoGeneral.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('GEN');
end;

destructor TAbstractGravandoExecucaoGeneral.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoGeneral.fCfgTin(strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoGeneral.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoGeneral.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoGeneral.fValidaPath: Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoGeneral.GetPath : String;
begin
  Result := conf.fGet('GENPAT');
end;

end.
