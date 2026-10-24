{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Kresil *}
{****************************************************************************PH*}
unit untConfiguradorKresil;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, SysUtils, untTypesSistema;

type
  TConfiguradorKresil = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorKresil }

function TConfiguradorKresil.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorKresil.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorKresil.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorKresil.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorKresil.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);
  Configurar('USATIN', 'Utilizar essa tinta de máquina              ', 'N'      , tpSimNao          , 'GERAL');
  Configurar('USAFOR', 'Utilizar formulação                         ', 'S'      , tpSimNao          , 'GERAL');
  Configurar('FATKRE', 'Fator                                       ', '1'      , tpNumeroDecimal   , 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais(%)                    ', '0'      , tpNumeroDecimal   , 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0'      , tpNumeroDecimal   , 'GERAL');
  Configurar('KRETRA', 'Trava para valor de venda KRE_PRE           ', 'VEN'    , tpTravaPreco      , 'GERAL');
  Configurar('NFMKRE', 'Próximo Código Nova Fórmula                 ', '00001'  , tpNumero_5        , 'GERAL');
  Configurar('PATKRE', 'Path para arquivos                          ', ''       , tpDiretorio       , 'GERAL');
  Configurar('UNIOPR', 'Unidade da Impressão de Ordem de Produção   ', ''       , tpUniImpOp        , 'GERAL');
  Configurar('DTAATU', 'Data da ultima atualização                  ', ''       , tpData            , 'GERAL');
  Configurar('VERSAO', 'Versão da máquina                           ', ''       , tpNormal          , 'GERAL');
  Configurar('ZERCOL', 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao     , 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorKresil.DiretorioValidar(strDir: String): string;
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

procedure TConfiguradorKresil.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
