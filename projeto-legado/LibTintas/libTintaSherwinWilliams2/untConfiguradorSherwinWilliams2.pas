{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta SherwinWilliams2 *}
{****************************************************************************PH*}
unit untConfiguradorSherwinWilliams2;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}

  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, SysUtils, untTypesSistema;

type
  TConfiguradorSherwinWilliams2 = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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
  untLibTintaFactory, untAutcomTintaFactory;

{ TConfiguradorSherwinWilliams2 }

function TConfiguradorSherwinWilliams2.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorSherwinWilliams2.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorSherwinWilliams2.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorSherwinWilliams2.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorSherwinWilliams2.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  TAutcomTintaFactory.Get.fInsereProCod('SHW_CADBAS', false);
  TAutcomTintaFactory.Get.fInsereProCod('SHW_CADCOL', false);
  TAutcomTintaFactory.Get.fInsereProCod('SHW_CADNFM', false);
  TAutcomTintaFactory.Get.fInsereProCod('SHW_CADSHW', false);

  Configurar('APREVE' ,  'Acréscimo Adicional sobre Preço de Venda (%)' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('DESOPE' ,  'Despesas Operacionais da Tinta (%)'           , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('FATTIN' ,  'Fator da Trava de Preço'                  , '1'       , tpNumeroDecimal , 'GERAL');
  Configurar('PATSHW' ,  'Path para arquivo de geração'             , ''        , tpDiretorio     , 'GERAL');
  Configurar('PROCOD' ,  'Próximo Código Novas Fórmulas'            , '00001'   , tpNumero_5      , 'GERAL');
  Configurar('TRASHW' ,  'Trava de Preço'                           , 'VEN'     , tpTravaPreco    , 'GERAL');
  Configurar('USAFOR' ,  'Utilizar Formulação'                      , 'S'       , tpSimNao        , 'GERAL');
  Configurar('USATIN' ,  'Utilizar essa tinta de máquina'           , 'N'       , tpSimNao        , 'GERAL');
  Configurar('DTAATU' ,  'Data da Ultima Atualização'               , ''        , tpData          , 'GERAL');
  Configurar('VERSAO' ,  'Versão da máquina'                        , ''        , tpNormal        , 'GERAL');
  Configurar('UNIOPR' ,  'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL');
  Configurar('ZERCOL' ,  'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao , 'GERAL');
  Configurar('EXIQML' ,  'Exibir Quantidade(ML) na tela de formulação?', 'S'    , tpSimNao        , 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('PATRGB' , 'Path para arquivo Rgb e Família:', '', tpDiretorio, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

function TConfiguradorSherwinWilliams2.DiretorioValidar(strDir: String): string;
{$IFNDEF LINUX}
var
  odSel: TOpenDialog;
{$ENDIF}
begin
{$IFNDEF LINUX}
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.TXT*';
    odSel.Title      := 'Informe o arquivo...';
    odSel.InitialDir :=  ExtractFileDir(Result);

    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
{$ENDIF}
end;
procedure TConfiguradorSherwinWilliams2.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
