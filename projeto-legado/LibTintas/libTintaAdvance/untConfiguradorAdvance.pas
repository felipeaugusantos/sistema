{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Advance *}
{*************************************************************************************AC*}
unit untConfiguradorAdvance;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
  DirectoryEditFocus,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, SysUtils, untTypesSistema;

type
  TConfiguradorAdvance = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorAdvance }

function TConfiguradorAdvance.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorAdvance.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorAdvance.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorAdvance.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorAdvance.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  ///Configuração Advance
  Configurar('USATIN',  'Utilizar essa tinta de máquina:                ',  'N'        ,  tpSimNao            ,  'GERAL');
  Configurar('USAFOR',  'Utilizar Formulação:                           ',  'S'        ,  tpSimNao            ,  'GERAL');
  Configurar('UTF8'  ,  'Arquivo Codificação UTF-8:                     ',  'N'        ,  tpSimNao            ,  'GERAL');
  Configurar('TRAADV',  'Trava para valor de venda ADV_PRE:             ',  'VEN'      ,  tpTravaPreco        ,  'GERAL');
  Configurar('FATADV',  'Fator:                                         ',  '0'        ,  tpNumeroDecimal     ,  'GERAL');
  Configurar('DESOPE',  'Despesas Operacionais (%):                     ',  '0'        ,  tpNumeroDecimal     ,  'GERAL');
  Configurar('APREVE',  'Acréscimo adicional sobre preço de venda (%):  ',  '0'        ,  tpNumeroDecimal     ,  'GERAL');
  Configurar('NFMADV',  'Próximo código novas fórmulas:                 ',  '00001'    ,  tpNumero_5          ,  'GERAL');
  Configurar('DTAATU',  'Data da ultima atualização:                    ',  ''         ,  tpData              ,  'GERAL');
  Configurar('VERSAO',  'Versão da máquina:                             ',  ''         ,  tpNormal            ,  'GERAL');
  Configurar('PATADV',  'Path para arquivos de fórmulas:                ',  ''         ,  tpDiretorio         ,  'GERAL');
  Configurar('UNIOPR',  'Unidade da Impressão da Ordem de Produção:     ',  ''         ,  tpUniImpOp          ,  'GERAL');
  Configurar('QTDORI',  'Quantidade Arquivo Origem                      ',  '0'        ,  tpQtdArquivo        ,  'GERAL');
  Configurar('ZERCOL',  'Zerar valor dos colorantes na venda da tinta de máquina', 'N' ,  tpSimNao            ,  'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

function TConfiguradorAdvance.DiretorioValidar(strDir: String): string;
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

procedure TConfiguradorAdvance.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
