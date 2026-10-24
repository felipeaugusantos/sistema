{*******************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Velutex Imobiliaria *}
{****************************************************************************************PH*}
unit untConfiguradorVelutexImobiliaria;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, SysUtils, untIDataSet, untStrUtils, untAutcomTintaFactory, untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, untGenericLibTintaControleVisualLabel, untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus, untLibTintaControleVisualImplementacao, untGenericLibTintaControleVisualDBCheckBox,
  untGenericLibTintaControleVisual, untGenericLibTintaControleVisualWinControl, untTypesSistema;

type
  TConfiguradorVelutexImobiliaria = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorVelutexImobiliaria }

function TConfiguradorVelutexImobiliaria.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorVelutexImobiliaria.BotaoVendaValidar(
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorVelutexImobiliaria.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorVelutexImobiliaria.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;


constructor TConfiguradorVelutexImobiliaria.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN' ,  'Utilizar essa maquina de tinta          ' , 'N'       , tpSimNao        , 'GERAL');
  Configurar('USAFOR' ,  'Utilizar Formulação                     ' , 'S'       , tpSimNao        , 'GERAL');
  Configurar('VELTRA' ,  'Trava para valor de venda(VEL_TRA)      ' , 'VEN'     , tpTravaPreco    , 'GERAL');
  Configurar('VELFAT' ,  'Fator                                   ' , '1'       , tpNumeroDecimal , 'GERAL');
  Configurar('VELNFM' ,  'Próximo Código Novas Formulas           ' , '00001'   , tpNumero_5      , 'GERAL');
  Configurar('DESOPE' ,  'Despesas Operacionais (%)               ' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('APREVE' ,  'Acréscimo Adicional sobre Preço de Venda (%)' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('VELPAT' ,  'Path para os arquivos de fórmulas       ' , ''        , tpDiretorio     , 'GERAL');
  Configurar('UNIOPR' ,  'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL', 'CFG_PULMLS');
  Configurar('VERSAO' ,  'Versão da máquina'                        , ''        , tpNormal        , 'GERAL');
  Configurar('ZERCOL' ,  'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorVelutexImobiliaria.DiretorioValidar(strDir: String): string;
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

procedure TConfiguradorVelutexImobiliaria.NumeroValidar(
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean;
  const strNomCam: String);
begin
end;

end.
