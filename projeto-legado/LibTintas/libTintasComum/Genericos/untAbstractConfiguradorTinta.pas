{**********************************************************************************}
{* Classe abstrata que implementa a interface IConfiguradorTinta responsável pela *}
{* comumicação da tela de configuração da tinta e a tinta atual                   *}
{*******************************************************************************PH*}
unit untAbstractConfiguradorTinta;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untIConfiguradorTinta, Classes, SysUtils, untIConfTinta, untAutcomTintaFactory,
  untIAuttinWrapper, untStrUtils, untTypesSistema;

type
  TAbstractConfiguradorTinta = class abstract (TInterfacedObject, IConfiguradorTinta)
  private
    stlPropriedades: TStringList;
    stlConfiguracoesExistentes: TStringList;
    stlGrupos: TStringList;
    stlCfgSisTin: TStringList;
    strIdePro: string;
    conf: IConfTinta;
    function GetPropriedades(): TStringList;
    function GetGrupos(): TStringList;
    function GetCfgSisTin(): TStringList;
  protected
    auttin: IAuttinWrapper;
    procedure Configurar(const strCodCfg: string; const strDescri: string; const strDefault: string; const tipoPropriedade: TTipoPropriedade;
                         const strGrupo: String = ''; const strCfgSisTin: String = '');
    function GetDefault(const strCodCfg: String): String;
    function GetConfiguracoesExistentes(): TStringList;
  public
    constructor Create(const strIdePro: string; const auttin: IAuttinWrapper);
    destructor Destroy; override;
    function GetIdePro: string;
    function GetPropriedade(const strCodCfg: string): Integer;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; virtual; abstract;
    function IsConfiguracaoExistente(const strCodCfg: string): Boolean; Virtual;
    function IsGrupoExistente(const strCodCfg: string): Boolean;
    function IsCfgSisTintaExistente(const strCodCfg: string): Boolean;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); virtual; abstract;
    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean; const strNomCam: String); virtual; abstract;
    function DiretorioValidar(strDir: String): String; virtual; abstract;
    function GetGrupo(const strCodCfg: string): String;
    function GetCfgSisTinta(const strCodCfg: string): String;
    function BotaoVendaClick(const strCodCfg: string; const strValCfg: string): string; virtual; abstract;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); virtual; abstract;

    function BotaoLinhaClick(const strCodCfg: string; const strValCfg: string): string; virtual;
    procedure BotaoLinhaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); virtual;

    function BotaoBaseClick(const strCodCfg: string; const strValCfg: string): string; virtual;
    procedure BotaoBaseValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); virtual;

    function BotalLinhasUtilClick(const strCodCfg: string; const strValCfg: string): string; virtual;


    procedure MovEstValidar(Sender: TObject; strNomCam: String); virtual;

    function DiretorioValidarNv(strDiretorio: String; strNomCam: String): String; Virtual;


  end;

implementation

{ TAbstractConfiguradorTinta }

function TAbstractConfiguradorTinta.BotalLinhasUtilClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := '';
end;

function TAbstractConfiguradorTinta.BotaoBaseClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := '';
end;

procedure TAbstractConfiguradorTinta.BotaoBaseValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
 //
end;

function TAbstractConfiguradorTinta.BotaoLinhaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := '';
end;

procedure TAbstractConfiguradorTinta.BotaoLinhaValidar(
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
//
end;

procedure TAbstractConfiguradorTinta.Configurar(const strCodCfg: string; const strDescri: string;
  const strDefault: string; const tipoPropriedade: TTipoPropriedade; const strGrupo: String = '';const strCfgSisTin: String = '');
begin
  GetPropriedades.Values[strCodCfg] := IntToStr(tipoPropriedade);
  conf.pInsereCodigo(strCodCfg, strDescri, strDefault);
  GetConfiguracoesExistentes.Add(strCodCfg);
  GetGrupos.Values[strCodCfg] := strGrupo;
  GetCfgSisTin.Values[strCodCfg] := strCfgSisTin;

end;

constructor TAbstractConfiguradorTinta.Create(const strIdePro: string; const auttin: IAuttinWrapper);
begin
  inherited Create();
  Self.strIdePro := strIdePro;
  stlPropriedades := nil;
  Self.auttin := auttin;
  stlConfiguracoesExistentes := nil;
  conf := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro);
  stlGrupos := nil;
  stlCfgSisTin := nil;
end;

destructor TAbstractConfiguradorTinta.Destroy;
begin
  if Assigned(stlPropriedades) then FreeAndNil(stlPropriedades);
  if Assigned(stlConfiguracoesExistentes) then FreeAndNil(stlConfiguracoesExistentes);
  if Assigned(stlGrupos) then FreeAndNil(stlGrupos);
  if Assigned(stlCfgSisTin) then FreeAndNil(stlCfgSisTin);
  inherited;
end;

function TAbstractConfiguradorTinta.DiretorioValidarNv(strDiretorio,
  strNomCam: String): String;
begin
  Result := '';
end;

function TAbstractConfiguradorTinta.GetCfgSisTin: TStringList;
begin
  if not Assigned(stlCfgSisTin) then
  begin
    stlCfgSisTin := TStringList.Create;
    stlCfgSisTin.Duplicates := dupIgnore;
  end;

  Result := stlCfgSisTin;
end;

function TAbstractConfiguradorTinta.GetCfgSisTinta(
  const strCodCfg: string): String;
begin
  Result := GetCfgSisTin.Values[strCodCfg];
end;

function TAbstractConfiguradorTinta.GetConfiguracoesExistentes: TStringList;
begin
  if not Assigned(stlConfiguracoesExistentes) then
  begin
    stlConfiguracoesExistentes := TStringList.Create;
    stlConfiguracoesExistentes.Sorted := True;
    stlConfiguracoesExistentes.Duplicates := dupIgnore;
  end;

  Result := stlConfiguracoesExistentes;
end;

function TAbstractConfiguradorTinta.GetDefault(const strCodCfg: String): String;
begin
  Result := conf.fGet(strCodCfg);
end;

function TAbstractConfiguradorTinta.GetGrupo(const strCodCfg: string): String;
begin
  Result := GetGrupos.Values[strCodCfg];
end;

function TAbstractConfiguradorTinta.GetGrupos: TStringList;
begin
  if not Assigned(stlGrupos) then
  begin
    stlGrupos := TStringList.Create;
    stlGrupos.Duplicates := dupIgnore;
  end;

  Result := stlGrupos;
end;

function TAbstractConfiguradorTinta.GetIdePro: string;
begin
  Result := strIdePro;
end;

function TAbstractConfiguradorTinta.GetPropriedade(const strCodCfg: string): Integer;
begin
  Result := StrToIntDef(GetPropriedades.Values[strCodCfg], 0);
end;

function TAbstractConfiguradorTinta.GetPropriedades: TStringList;
begin
  if not Assigned(stlPropriedades) then
  begin
    stlPropriedades := TStringList.Create;
    stlPropriedades.Duplicates := dupIgnore;
  end;

  Result := stlPropriedades;
end;

function TAbstractConfiguradorTinta.IsCfgSisTintaExistente(
  const strCodCfg: string): Boolean;
var
  strCfgSisTinta: String;
begin
  strCfgSisTinta := GetCfgSisTin.Values[strCodCfg];
  Result := (Not TStrUtils.fEmptyStr(strCfgSisTinta));

end;

function TAbstractConfiguradorTinta.IsConfiguracaoExistente(const strCodCfg: string): Boolean;
begin
  Result := GetConfiguracoesExistentes().IndexOf(strCodCfg) >= 0;
end;

function TAbstractConfiguradorTinta.IsGrupoExistente(
  const strCodCfg: string): Boolean;
var
  strGrupo: String;
begin
  strGrupo := GetGrupos.Values[strCodCfg];
  Result := (Not TStrUtils.fEmptyStr(strGrupo));
end;

procedure TAbstractConfiguradorTinta.MovEstValidar(Sender: TObject; strNomCam: String);
begin
end;

end.
