{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Resicolor2 *}
{*************************************************************************************AC*}
unit untConfiguradorResicolor2;

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
  TConfiguradorResicolor2 = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorResicolor2 }

function TConfiguradorResicolor2.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;


procedure TConfiguradorResicolor2.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorResicolor2.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorResicolor2.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorResicolor2.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  ///Configuração Resicolor2
  Configurar('USATIN' , 'Utilizar essa tinta de máquina               ', 'N'        , tpSimNao          , 'GERAL');
  Configurar('USAFOR' , 'Utilizar Formulação                          ', 'S'        , tpSimNao          , 'GERAL');
  Configurar('TRARS2' , 'Trava para valor de venda COR_PRE            ', 'VEN'      , tpTravaPreco      , 'GERAL');
  Configurar('FATRS2' , 'Fator                                        ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('MARRS2' , 'Margem de Lucro do colorante                 ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('DESOPE' , 'Despesas Operacionais (%)                    ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('APREVE' , 'Acréscimo Adicional sobre Preço de Venda (%) ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('NFMRS2' , 'Próximo Código Novas Fórmulas                ', '00001'    , tpNumero_5        , 'GERAL');
  Configurar('DTAATU' , 'Data da Ultima Atualização                   ', ''         , tpData            , 'GERAL');
  Configurar('VERSAO' , 'Versão da Máquina                            ', ''         , tpNormal          , 'GERAL');
  Configurar('UNIOPR' , 'Unidade da Impressão da Ordem de Produção    ', ''         , tpUniImpOp        , 'GERAL');
  Configurar('ZERCOL' , 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao        , 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
  Configurar('PATRS2', 'Path para a geração dos arquivos', '', tpDiretorio, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorResicolor2.DiretorioValidar(strDir: String): string;
var
  odSel: TOpenDialog;
begin
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.XLSX*';
    odSel.Title      := 'Informe o arquivo...';
    odSel.InitialDir :=  ExtractFileDir(Result);

    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
{$WARN SYMBOL_PLATFORM ON}
end;
{$ENDIF}

procedure TConfiguradorResicolor2.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
