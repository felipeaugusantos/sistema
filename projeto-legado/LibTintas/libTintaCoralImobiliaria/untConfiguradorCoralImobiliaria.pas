{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta CoralImobiliaria *}
{*************************************************************************************AC*}
unit untConfiguradorCoralImobiliaria;

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
  TConfiguradorCoralImobiliaria = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorCoralImobiliaria }

function TConfiguradorCoralImobiliaria.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorCoralImobiliaria.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorCoralImobiliaria.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorCoralImobiliaria.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorCoralImobiliaria.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('APREVE' ,  'Acréscimo Adicional sobre Preço de Venda (%)' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('DESOPE' ,  'Despesas Operacionais da Tinta (%)'           , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('FATCOR' ,  'Fator da trava de preço'                  , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('TXTCOR' ,  'Path para os arquivos       '             , ''        , tpDiretorio     , 'GERAL');
  Configurar('NFMCOR' ,  'Próximo Código Novas Fórmulas'            , '00001'   , tpNumero_5      , 'GERAL');
  Configurar('TRACOR' ,  'Trava para valor de venda'                , 'VEN'     , tpTravaPreco    , 'GERAL');
  Configurar('USAFOR' ,  'Utilizar Formulação'                      , 'S'       , tpSimNao        , 'GERAL');
  Configurar('USATIN' ,  'Utilizar essa tinta de máquina'           , 'N'       , tpSimNao        , 'GERAL');
  Configurar('MARCOR' ,  'Margem de Lucro do colorante'             , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('VERSAO' ,  'Versão da máquina'                        , ''        , tpNormal        , 'GERAL');
  Configurar('DTAATU' ,  'Data da Ultima Atualização'               , ''        , tpNormal        , 'GERAL');
  Configurar('EXPARQ' ,  'Exportar formulação de tinta de máquina ' , ''        , tpDiretorio     , 'GERAL');
  Configurar('UNIOPR' ,  'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL');
  Configurar('ZERCOL' ,  'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');

  //CONFIGURAÇÃO POSTGRESSQL - Coral Imobiliaria
  Configurar('SERCOR', 'Servidor: ', '', tpNormal, 'CONEXÃO');
  Configurar('PORCOR', 'Porta: ', '', tpNormal, 'CONEXÃO');
  Configurar('USUCOR', 'Usuario: ', '', tpNormal, 'CONEXÃO');
  Configurar('SENCOR', 'Senha: ', '', tpSenha, 'CONEXÃO');
  Configurar('DTBCOR', 'Database: ', '', tpNormal, 'CONEXÃO');
end;

function TConfiguradorCoralImobiliaria.DiretorioValidar(strDir: String): string;
{$IFNDEF LINUX}
var
{$WARN SYMBOL_PLATFORM OFF}
  Dialogo: TFileOpenDialog;
{$WARN SYMBOL_PLATFORM ON}
{$ENDIF}
begin
  {$IFNDEF LINUX}
  If DirectoryExists(strDir) Then
    Result := strDir
  Else
    Result := 'C:\';

{$WARN SYMBOL_PLATFORM OFF}
  Try
    Dialogo := TFileOpenDialog.Create(nil);
    Dialogo.Options       := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
    Dialogo.OkButtonLabel := 'Selecionar';
    Dialogo.DefaultFolder := Result;
    Dialogo.FileName      := Result;
    If Dialogo.Execute Then
      Result := Dialogo.FileName;
  Finally
    FreeAndNil(Dialogo);
  End;
{$WARN SYMBOL_PLATFORM ON}
{$ENDIF}
end;

procedure TConfiguradorCoralImobiliaria.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
