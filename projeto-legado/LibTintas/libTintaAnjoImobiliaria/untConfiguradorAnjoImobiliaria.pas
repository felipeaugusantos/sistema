{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta AnjoImobiliaria *}
{****************************************************************************PH*}
unit untConfiguradorAnjoImobiliaria;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, SysUtils, untTypesSistema;

type
  TConfiguradorAnjoImobiliaria = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean; const strNomCam: String); override;
    function DiretorioValidar(strDir: String): string; override;
    function BotaoVendaClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
  end;

implementation

uses
  untLibTintaFactory;

{ TConfiguradorAnjoImobiliaria }

function TConfiguradorAnjoImobiliaria.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorAnjoImobiliaria.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorAnjoImobiliaria.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorAnjoImobiliaria.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorAnjoImobiliaria.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('USAFOR', 'Utilizar formulação',  'S', tpSimNao, 'GERAL');
  Configurar('ANJTRA', 'Trava para valor de venda ANJ_PRE', 'VEN', tpTravaPreco, 'GERAL');
  Configurar('FATANJ', 'Fator', '1', tpNumeroDecimal, 'GERAL');
  Configurar('NFMANJ', 'Próximo código Nova Fórmula', '1', tpNumero_5, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('PATANJ', 'Path para arquivo de fórmula ANJO1', '', tpDiretorio, 'GERAL');
  Configurar('ANJPAT', 'Path para arquivo de fórmula ANJO2', '', tpDiretorio, 'GERAL');
  Configurar('UNIOPR' ,  'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL');
  Configurar('DTAATU', 'Data da Ultima Atualização', '', tpData, 'GERAL');
  Configurar('VERSAO', 'Versão da máquina', '', tpNormal, 'GERAL');
  Configurar('ZERCOL', 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

function TConfiguradorAnjoImobiliaria.DiretorioValidar(strDir: String): string;
{$IFNDEF LINUX}
var
  Dialogo: TOpenDialog;
{$ENDIF}
begin
{$IFNDEF LINUX}
  If FileExists(strDir) Then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    Dialogo := TOpenDialog.Create(nil);
    Dialogo.Filter      := '*.txt';
    Dialogo.InitialDir  := Result;
    Dialogo.FileName    := Result;
    If Dialogo.Execute Then
      Result := Dialogo.FileName;
  Finally
    FreeAndNil(Dialogo);
  End;
{$ENDIF}
end;

procedure TConfiguradorAnjoImobiliaria.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
