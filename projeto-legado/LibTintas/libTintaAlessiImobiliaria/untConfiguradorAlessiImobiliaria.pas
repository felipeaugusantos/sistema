{******************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Alessi Imobiliaria *}
{***************************************************************************************AC*}
unit untConfiguradorAlessiImobiliaria;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, SysUtils, untTypesSistema;

type
  TConfiguradorAlessiImobiliaria = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorAlessiImobiliaria }

function TConfiguradorAlessiImobiliaria.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorAlessiImobiliaria.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorAlessiImobiliaria.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorAlessiImobiliaria.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorAlessiImobiliaria.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('USAFOR', 'Utilizar formulação',  'S', tpSimNao, 'GERAL');
  Configurar('ALEPRE', 'Trava para valor de venda ALE_PRE', 'VEN', tpTravaPreco, 'GERAL');
  Configurar('ALEFAT', 'Fator da trava de preço', '1', tpNumeroDecimal, 'GERAL');
  Configurar('PROCOD', 'Próximo código Nova Fórmula', '1', tpNumero_5, 'GERAL');
  Configurar('ALEPAT', 'Path para arquivo TXT', '', tpDiretorio, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('UNIOPR', 'Unidade da Impressão de Ordem de Produção', '3', tpUniImpOp, 'GERAL');
  Configurar('DTAATU', 'Data da Última Atualização', '', tpData, 'GERAL');
  Configurar('VERSAO', 'Versão da máquina', '', tpNormal, 'GERAL');
  Configurar('ZERCOL', 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

function TConfiguradorAlessiImobiliaria.DiretorioValidar(strDir: String): string;
{$IFNDEF LINUX}
var
  odSel: TOpenDialog;
{$ENDIF}
begin
{$IFNDEF LINUX}
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.XLS*';
    odSel.Title      := 'Informe o arquivo...';
    odSel.InitialDir :=  ExtractFileDir(Result);

    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
{$ENDIF}
end;

procedure TConfiguradorAlessiImobiliaria.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
