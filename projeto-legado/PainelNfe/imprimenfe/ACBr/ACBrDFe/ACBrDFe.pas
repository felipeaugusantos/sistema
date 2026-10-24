unit ACBrDFe;

interface

uses
  Classes, SysUtils, IniFiles,
  ACBrBase,
  untConversao;

const
  ACBRDFE_VERSAO = '0.1.0a';
  CSCHEMA_EXT = '.xsd';
  CSCHEMA_SeparadorVersao = '_v';

type

  TACBrDFeOnTransmitError = procedure(const HttpError, InternalError: Integer;
    const URL, DadosEnviados, SoapAction: String; var Retentar: Boolean; var Tratado: Boolean) of object ;

  { TACBrDFe }
  {$IFDEF UNIDAC}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF UNIDAC}
  TACBrDFe = class(TACBrComponent)
  private
    FOnTransmitError: TACBrDFeOnTransmitError;
    FListaDeSchemas: TStringList;
    FPathSchemas: String;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog: TACBrGravarLog;
    procedure SetAbout(AValue: String);
  protected
    FPIniParams: TMemIniFile;
    FPIniParamsCarregado: Boolean;
    FPSeparadorVersaoSchema: String;

    function GetAbout: String; virtual;

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetNomeModeloDFe: String; virtual;
    function GetNameSpaceURI: String; virtual;

    procedure FazerLog(const Msg: String; out Tratado: Boolean);
    procedure GerarException(const Msg: String; E: Exception = nil);

  published
    property OnTransmitError : TACBrDFeOnTransmitError read FOnTransmitError
       write FOnTransmitError;
    property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
    property About: String read GetAbout write SetAbout stored False;

    property OnGerarLog: TACBrGravarLog read FOnGerarLog write FOnGerarLog;
  end;

implementation

uses strutils,
  ACBrDFeException, ACBrUtil;

{ TACBrDFe }

constructor TACBrDFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPSeparadorVersaoSchema := CSCHEMA_SeparadorVersao;

  // Criando uma instância de FSSL e atribuindo valores de "Configuracoes" a ela;
  FListaDeSchemas := TStringList.Create;
  FPathSchemas := '';

  FOnGerarLog := nil;
  FOnTransmitError := nil;

  FPIniParamsCarregado := False;
end;


destructor TACBrDFe.Destroy;
begin
  FListaDeSchemas.Free;
  FPIniParams.Free;

  inherited;
end;

function TACBrDFe.GetNomeModeloDFe: String;
begin
  Result := '';
end;

function TACBrDFe.GetNameSpaceURI: String;
begin
  Result := '';
end;

function TACBrDFe.GetAbout: String;
begin
  Result := 'ACBrDFe Ver: ' + ACBRDFE_VERSAO;
end;

procedure TACBrDFe.SetAbout(AValue: String);
begin
  {nada aqui}
end;



procedure TACBrDFe.FazerLog(const Msg: String; out Tratado: Boolean);
begin
  Tratado := False;
  if (Msg <> '') then
  begin
    if Assigned(OnGerarLog) then
      OnGerarLog(Msg, Tratado);
  end;
end;

procedure TACBrDFe.GerarException(const Msg: String; E: Exception);
var
  Tratado: Boolean;
  MsgErro: String;
begin
  MsgErro := Msg;
  if Assigned(E) then
    MsgErro := MsgErro + sLineBreak + E.Message;

  Tratado := False;
  FazerLog('ERRO: ' + MsgErro, Tratado);

  // MsgErro já está na String Nativa da IDE... por isso deve usar "CreateDef"
  if not Tratado then
    raise EACBrDFeException.CreateDef(MsgErro);
end;

end.
