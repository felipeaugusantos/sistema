unit untDadosEnviaGatilhoSms;

interface

uses
  REST.Json, System.SysUtils;

type
  TDadosGatilho = class
  private
    FSchedule: String;
    FCgcEmp: String;
    FUtilizaIntegracaoMKON: Boolean;
    FNomeGatilho: String;
    FCodigoGrupo: String;
    FCodigoGatilho: String;
    FEmpresaDocumento: String;
    FOpcDocumento: String;
    FEspecieDocumento: String;
    FNumeroDocumento: String;
  public
    property schedule: String Read FSchedule write FSchedule;
    property cgcEmp: String Read FCgcEmp write FCgcEmp;
    property utilizaIntegracaoMKON: Boolean Read FUtilizaIntegracaoMKON write FUtilizaIntegracaoMKON;
    property nomeGatilho: String Read FNomeGatilho write FNomeGatilho;
    property codigoGrupo: String Read FCodigoGrupo write FCodigoGrupo;
    property codigoGatilho: String Read FCodigoGatilho write FCodigoGatilho;
    property numeroDocumento: String Read FNumeroDocumento write FNumeroDocumento;
    property especieDocumento: String Read FEspecieDocumento write FEspecieDocumento;
    property opcDocumento: String Read FOpcDocumento write FOpcDocumento;
    property empresaDocumento: String Read FEmpresaDocumento write FEmpresaDocumento;
  end;

  TDadosEnviaGatilhoSms = class
  private
    FType: String;
    FDadosGatilho: TDadosGatilho;
  public
    property &type: String Read FType write FType;
    property gatilho: TDadosGatilho Read FDadosGatilho write FDadosGatilho;

    constructor Create;
    destructor Destroy; override;

    function ToJsonString: String;
    class function FromJsonString(AJsonString: string): TDadosEnviaGatilhoSms;
  end;

implementation

{ TDadosEnviaGatilhoSms }

constructor TDadosEnviaGatilhoSms.Create;
const
  FTYPEJSON = 'TDadosEnviaGatilhoSms';
begin
  FType := FTYPEJSON;

  FDadosGatilho := TDadosGatilho.Create;
end;

destructor TDadosEnviaGatilhoSms.Destroy;
begin
  FDadosGatilho.Free;

  inherited;
end;

function TDadosEnviaGatilhoSms.ToJsonString: String;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TDadosEnviaGatilhoSms.FromJsonString(AJsonString: string): TDadosEnviaGatilhoSms;
begin
  Result := TJson.JsonToObject<TDadosEnviaGatilhoSms>(AJsonString);
end;

end.
