{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Dacar   *}
{****************************************************************************AC*}
unit untConfiguradorDacar;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untTypesSistema;

type
  TConfiguradorDacar = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean; const strNomCam: String); override;
  {$IFNDEF LINUX}
    function DiretorioValidar(strDir: String): string; override;
  {$ENDIF}
    function BotaoVendaClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
  end;

implementation

uses
  untLibTintaFactory;

{ TConfiguradorDacar }

function TConfiguradorDacar.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorDacar.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorDacar.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorDacar.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorDacar.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('USAFOR', 'Utilizar formulação',  'S', tpSimNao, 'GERAL');
  Configurar('TRADAC', 'Trava para valor de venda DAC_PRE', 'VEN', tpTravaPreco, 'GERAL');
  Configurar('FATDAC', 'Fator da trava de preço', '1', tpNumeroDecimal, 'GERAL');
  Configurar('NXTDAC', 'Próximo código Nova Fórmula', '1', tpNumero_5, 'GERAL');
  Configurar('TXTDAC', 'Path para arquivo TXT', '', tpDiretorio, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('UNIOPR' ,  'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL');
  Configurar('DTAATU', 'Data da Ultima Atualização', '', tpData, 'GERAL');
  Configurar('VERSAO', 'Versão da máquina', '', tpNormal, 'GERAL');
  Configurar('ZERCOL', 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorDacar.DiretorioValidar(strDir: String): string;
var
  odSel: TOpenDialog;
begin
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.txt*';
    odSel.Title      := 'Informe o diretório...';
    odSel.InitialDir :=  ExtractFileDir(Result);

    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
end;
{$ENDIF}

procedure TConfiguradorDacar.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
