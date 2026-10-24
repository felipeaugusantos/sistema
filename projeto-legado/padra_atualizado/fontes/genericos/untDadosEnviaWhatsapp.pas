unit untDadosEnviaWhatsapp;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ENDIF}
  Rest.Json;

type
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

  TDadosEnviaWhatsapp = class
  private
    FType: String;
    FTemplate: TTemplateClass;
    FFila: TFilaClass;
  public
    property &type: String read FType write FType;
    property template: TTemplateClass read FTemplate write FTemplate;
    property fila: TFilaClass read FFila write FFila;
    constructor Create;
    destructor Destroy; override;

    class function FromJsonString(AJsonString: string): TDadosEnviaWhatsapp;
    function ToJsonString: String;
  end;

implementation

{TDadosEnviaWhatsapp}

constructor TDadosEnviaWhatsapp.Create;
const
  FTYPEJSON = 'TDadosEnviaWhatsapp';
begin
  inherited;
  FType := FTYPEJSON;
  FTemplate := TTemplateClass.Create();
  FFila := TFilaClass.Create();
end;

destructor TDadosEnviaWhatsapp.Destroy;
begin
  FTemplate.free;
  FFila.Free;

  inherited;
end;

class function TDadosEnviaWhatsapp.FromJsonString(AJsonString: string): TDadosEnviaWhatsapp;
begin
  Result := TJson.JsonToObject<TDadosEnviaWhatsapp>(AJsonString);
end;

function TDadosEnviaWhatsapp.ToJsonString: String;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.
