{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta MaxVinil *}
{*************************************************************************************AC*}
unit untConfiguradorMaxVinil;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
  DirectoryEditFocus,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untTypesSistema;

type
  TConfiguradorMaxVinil = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorMaxVinil }

function TConfiguradorMaxVinil.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorMaxVinil.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorMaxVinil.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorMaxVinil.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorMaxVinil.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN'   ,   'Utilizar essa tinta de máquina'            , 'N'           ,   tpSimNao          ,   'GERAL');
  Configurar('USAFOR'   ,   'Utilizar Formulação'                       , 'S'           ,   tpSimNao          ,   'GERAL');
  Configurar('PATMAX'   ,   'Path para arquivo      '                   , ''            ,   tpDiretorio       ,   'GERAL');
  Configurar('NFMMAX'   ,   'Próximo Código Novas Fórmulas'             , '00001'       ,   tpNumero_5        ,   'GERAL');
  Configurar('TRAMAX'   ,   'Trava para valor de venda '                , 'VEN'         ,   tpTravaPreco      ,   'GERAL');
  Configurar('FATMAX'   ,   'Fator'                                     , '0'           ,   tpNumeroDecimal   ,   'GERAL');
  Configurar('MARMAX'   ,   'Margem de lucro do colorante'              , '0'           ,   tpNumeroDecimal   ,   'GERAL');
  Configurar('APREVE'   ,   'Acréscimo Adicional sobre Preço de Venda (%)'  , '0'       ,   tpNumeroDecimal   ,   'GERAL');
  Configurar('DESOPE'   ,   'Despesas Operacionais (%)'                   , '0'         ,   tpNumeroDecimal   ,   'GERAL');
  Configurar('DTAATU'   ,   'Data da Ultima Atualização'                , ''            ,   tpData            ,   'GERAL');
  Configurar('VERSAO'   ,   'Versão da máquina'                         , ''            ,   tpNormal          ,   'GERAL');
  Configurar('UNIOPR'   ,   'Unidade da Impressão da Ordem de Produção' , ''            ,   tpUniImpOp        ,   'GERAL');
  Configurar('ZERCOL'   ,   'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorMaxVinil.DiretorioValidar(strDir: String): string;
var
  odSel: TOpenDialog;
begin
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.TXT*';
    odSel.Title      := 'Informe o diretório...';
    odSel.InitialDir :=  ExtractFileDir(Result);

    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
end;
{$ENDIF}

procedure TConfiguradorMaxVinil.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
