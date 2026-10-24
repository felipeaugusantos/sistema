unit untDadosEnviaGatilhoWhatsapp;

interface

uses
  REST.Json, System.SysUtils;

type
  TDadosChavesPrimarias = class
  private
    FAutIncNotfic: String;
  public
    property autIncNotfic: String Read FAutIncNotfic write FAutIncNotfic;
  end;

  TTemplateClass = class
  private
    FId: String;
    FVarsdata: TArray<String>;
  public
    property id: String read FId write FId;
    property varsdata: TArray<String> read FVarsdata write FVarsdata;
  end;

  TFilaClass = class
  private
    FId: String;
  public
    property id: String read FId write FId;
  end;

  TOutrasInformacoes = class
  private
    FQrCodePix: String;
  public
    property qrCodePix: String Read FQrCodePix write FQrCodePix;
  end;

  TDadosGatilho = class
  private
    FNomeGatilho: String;
    FUnitDisparo: String;
    FCodigoGrupo: String;
    FCodigoGatilho: String;
    FEmpresaDocumento: String;
    FOpcDocumento: String;
    FEspecieDocumento: String;
    FNumeroDocumento: String;
  public
    property nomeGatilho: String Read FNomeGatilho write FNomeGatilho;
    property unitDisparo: String Read FUnitDisparo write FUnitDisparo;
    property codigoGrupo: String Read FCodigoGrupo write FCodigoGrupo;
    property codigoGatilho: String Read FCodigoGatilho write FCodigoGatilho;
    property numeroDocumento: String Read FNumeroDocumento write FNumeroDocumento;
    property especieDocumento: String Read FEspecieDocumento write FEspecieDocumento;
    property opcDocumento: String Read FOpcDocumento write FOpcDocumento;
    property empresaDocumento: String Read FEmpresaDocumento write FEmpresaDocumento;
  end;

  TDadosEnviaGatilhoWhatsapp = class
  private
    FType: String;
    FDadosChavesPrimarias: TDadosChavesPrimarias;
    FTemplate: TTemplateClass;
    FFila: TFilaClass;
    FOutrasInformacoes: TOutrasInformacoes;
    FDadosGatilho: TDadosGatilho;
  public
    property &type: String Read FType write FType;
    property chavesPrimarias: TDadosChavesPrimarias read FDadosChavesPrimarias write FDadosChavesPrimarias;
    property template: TTemplateClass read FTemplate write FTemplate;
    property fila: TFilaClass read FFila write FFila;
    property outrasInformacoes: TOutrasInformacoes read FOutrasInformacoes write FOutrasInformacoes;
    property gatilho: TDadosGatilho read FDadosGatilho write FDadosGatilho;

    constructor Create;
    destructor Destroy; override;

    class function FromJsonString(AJsonString: string): TDadosEnviaGatilhoWhatsapp;
    function ToJsonString: String;
  end;

implementation

{ TDadosEnviaGatilhoWhatsapp }

constructor TDadosEnviaGatilhoWhatsapp.Create;
const
  FTYPEJSON = 'TDadosEnviaGatilhoWhatsapp';
begin
  FType := FTYPEJSON;
  FDadosChavesPrimarias := TDadosChavesPrimarias.Create();
  FTemplate := TTemplateClass.Create();
  FFila := TFilaClass.Create();
  FOutrasInformacoes := TOutrasInformacoes.Create();
  FDadosGatilho := TDadosGatilho.Create();
end;

destructor TDadosEnviaGatilhoWhatsapp.Destroy;
begin
  FDadosChavesPrimarias.Free;
  FTemplate.free;
  FFila.Free;
  FOutrasInformacoes.Free;
  FDadosGatilho.Free;
  inherited;
end;

class function TDadosEnviaGatilhoWhatsapp.FromJsonString(
  AJsonString: string): TDadosEnviaGatilhoWhatsapp;
begin
  Result := TJson.JsonToObject<TDadosEnviaGatilhoWhatsapp>(AJsonString);
end;

function TDadosEnviaGatilhoWhatsapp.ToJsonString: String;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.
