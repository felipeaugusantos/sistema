{**********************************************************************************}
{* Classe abstrata que implementa a interface IConfiguradorTinta responsável pela *}
{* comumicação da tela de configuração da tinta e a tinta atual                   *}
{*******************************************************************************PH*}
unit untAbstractConfiguradorTinta;

interface

uses
  untIConfiguradorTinta, Classes, SysUtils, untIConfTinta, untAutcomTintaFactory,
  untIAuttinWrapper;

type
  TAbstractConfiguradorTinta = class abstract (TInterfacedObject, IConfiguradorTinta)
  private
    stlPropriedades: TStringList;
    stlConfiguracoesExistentes: TStringList;
    strIdePro: string;
    conf: IConfTinta;
    function GetPropriedades(): TStringList;
    function GetConfiguracoesExistentes(): TStringList;
  protected
    auttin: IAuttinWrapper;
    procedure Configurar(const strCodCfg: string; const strDescri: string; const strDefault: string; const tipoPropriedade: TTipoPropriedade);
  public
    constructor Create(const strIdePro: string; const auttin: IAuttinWrapper);
    destructor Destroy; override;
    function GetIdePro: string;
    function GetPropriedade(const strCodCfg: string): Integer;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; virtual; abstract;
    function IsConfiguracaoExistente(const strCodCfg: string): Boolean;
  end;

implementation

{ TAbstractConfiguradorTinta }

procedure TAbstractConfiguradorTinta.Configurar(const strCodCfg: string; const strDescri: string;
  const strDefault: string; const tipoPropriedade: TTipoPropriedade);
begin
  GetPropriedades.Values[strCodCfg] := IntToStr(tipoPropriedade);
  conf.pInsereCodigo(strCodCfg, strDescri, strDefault);
  GetConfiguracoesExistentes.Add(strCodCfg);
end;

constructor TAbstractConfiguradorTinta.Create(const strIdePro: string; const auttin: IAuttinWrapper);
begin
  inherited Create();
  Self.strIdePro := strIdePro;
  stlPropriedades := nil;
  Self.auttin := auttin;
  stlConfiguracoesExistentes := nil;
  conf := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro);
end;

destructor TAbstractConfiguradorTinta.Destroy;
begin
  if Assigned(stlPropriedades) then FreeAndNil(stlPropriedades);
  if Assigned(stlConfiguracoesExistentes) then FreeAndNil(stlConfiguracoesExistentes);
  inherited;
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

function TAbstractConfiguradorTinta.IsConfiguracaoExistente(const strCodCfg: string): Boolean;
begin
  Result := GetConfiguracoesExistentes().IndexOf(strCodCfg) >= 0;
end;

end.
