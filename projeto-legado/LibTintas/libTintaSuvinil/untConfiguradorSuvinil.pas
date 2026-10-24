{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta suvinil *}
{****************************************************************************PH*}
unit untConfiguradorSuvinil;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, untTypesSistema;

type
  TConfiguradorSuvinil = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorSuvinil }

function TConfiguradorSuvinil.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorSuvinil.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorSuvinil.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorSuvinil.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorSuvinil.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('TRASUV', 'Trava de Preço', 'VEN', tpTravaPreco, 'GERAL');
  Configurar('USAFOR', 'Utilizar Formulação', 'S', tpSimNao, 'GERAL');
  Configurar('VERSAO', 'Versão da máquina', '', tpNormal, 'GERAL');
  Configurar('NFMSUV', 'Próximo código', '1', tpNumero_5, 'GERAL');
  Configurar('FATSUV', 'Fator da Trava', '1', tpNumeroDecimal, 'GERAL');
  Configurar('DTAATU', 'Data da Ultima Atualização', '', tpData, 'GERAL');
  Configurar('SRVNAM', 'Servidor SQL Server Self Color', 'SRVTINTA\SELFCOLOR', tpNormal, 'GERAL');
  Configurar('USERDB', 'Usuário do banco SQL Server Self Color', 'integracao', tpNormal, 'GERAL');
  Configurar('SENHDB', 'Senha do banco SQL Server Self Color', '1nt3gr4c40', tpSenha, 'GERAL');
  Configurar('DATABA', 'Banco Self Color', 'SELFCOLOR', tpNormal, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('UNIOPR', 'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL');
  Configurar('ZERCOL', 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

function TConfiguradorSuvinil.DiretorioValidar(strDir: String): string;
begin

end;

procedure TConfiguradorSuvinil.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
