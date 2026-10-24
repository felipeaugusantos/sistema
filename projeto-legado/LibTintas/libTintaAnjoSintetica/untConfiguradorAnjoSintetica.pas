{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta AnjoSintetica *}
{*************************************************************************************AC*}
unit untConfiguradorAnjoSintetica;

interface

uses
{$IFNDEF LINUX}
  Controls, Dialogs, DirectoryEditFocus,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untTypesSistema;

type
  TConfiguradorAnjoSintetica = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorAnjoSintetica }

function TConfiguradorAnjoSintetica.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorAnjoSintetica.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorAnjoSintetica.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorAnjoSintetica.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorAnjoSintetica.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  ///Configuração AnjoSintetica
  Configurar('USATIN', 'Utilizar essa tinta de máquina               ', 'N'       ,  tpSimNao          , 'GERAL');
  Configurar('USAFOR', 'Utilizar Formulação                          ', 'S'       ,  tpSimNao          , 'GERAL');
  Configurar('NFMAJA', 'Próximo Código Novas Fórmulas                ', '00001'   ,  tpNumero_5        , 'GERAL');
  Configurar('PATAJA', 'Path para arquivos                           ', ''        ,  tpDiretorio       , 'GERAL');
  Configurar('TRAAJA', 'Trava para valor de venda AJA_PRE            ', 'VEN'     ,  tpTravaPreco      , 'GERAL');
  Configurar('FATAJA', 'Fator da trava de preço                      ', '0'       ,  tpNumeroDecimal   , 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais (%)                    ', '0'       ,  tpNumeroDecimal   , 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%) ', '0'       ,  tpNumeroDecimal   , 'GERAL');
  Configurar('DTAATU', 'Data da Ultima Atualização                   ', ''        ,  tpData            , 'GERAL');
  Configurar('VERSAO', 'Versão da Máquina                            ', ''        ,  tpNormal          , 'GERAL');
  Configurar('UNIOPR', 'Unidade da Impressão da Ordem de Produção    ', ''        ,  tpUniImpOp        , 'GERAL');
  Configurar('ZERCOL', 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao        , 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorAnjoSintetica.DiretorioValidar(strDir: String): string;
Var
 {$WARN SYMBOL_PLATFORM OFF}
  Dialogo: TFileOpenDialog;
{$WARN SYMBOL_PLATFORM ON}
Begin

  If DirectoryExists(strDir) Then
    Result := strDir
  Else
    Result := 'C:\';

{$WARN SYMBOL_PLATFORM OFF}
  Try
    Dialogo := TFileOpenDialog.Create(Nil);
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
End;
{$ENDIF}

procedure TConfiguradorAnjoSintetica.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
