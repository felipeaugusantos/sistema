{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Falcao *}
{****************************************************************************PH*}
unit untConfiguradorFalcao;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, SysUtils, untTypesSistema;

type
  TConfiguradorFalcao = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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
  untLibTintaFactory, untAutcomTintaFactory;

{ TConfiguradorFalcao }

function TConfiguradorFalcao.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorFalcao.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorFalcao.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorFalcao.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorFalcao.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  TAutcomTintaFactory.Get.fInsereProCod('FAL_CADBAS', false);
  TAutcomTintaFactory.Get.fInsereProCod('FAL_CADCOL', false);
  TAutcomTintaFactory.Get.fInsereProCod('FAL_CADNFM', false);
  TAutcomTintaFactory.Get.fInsereProCod('FAL_CADFAL', false);

  Configurar('APREVE' ,  'Acréscimo Adicional sobre Preço de Venda (%)' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('DESOPE' ,  'Despesas Operacionais da Tinta (%)'           , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('FATTIN' ,  'Fator da Trava de Preço'                  , '1'       , tpNumeroDecimal , 'GERAL');
  Configurar('PATFAL' ,  'Path para arquivo de geração'             , ''        , tpDiretorio     , 'GERAL');
  Configurar('PROCOD' ,  'Próximo Código Novas Fórmulas'            , '00001'   , tpNumero_5      , 'GERAL');
  Configurar('TRAFAL' ,  'Trava de Preço'                           , 'VEN'     , tpTravaPreco    , 'GERAL');
  Configurar('USAFOR' ,  'Utilizar Formulação'                      , 'S'       , tpSimNao        , 'GERAL');
  Configurar('USATIN' ,  'Utilizar essa tinta de máquina'           , 'N'       , tpSimNao        , 'GERAL');
  Configurar('DTAATU' ,  'Data da Ultima Atualização'               , ''        , tpData          , 'GERAL');
  Configurar('VERSAO' ,  'Versão da máquina'                        , ''        , tpNormal        , 'GERAL');
  Configurar('UNIOPR' ,  'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL');
  Configurar('ZERCOL' ,  'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorFalcao.DiretorioValidar(strDir: String): string;
var
{$WARN SYMBOL_PLATFORM OFF}
  Dialogo: TFileOpenDialog;
{$WARN SYMBOL_PLATFORM ON}
begin
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
end;
{$ENDIF}

procedure TConfiguradorFalcao.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
