{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Luztol *}
{*************************************************************************************AC*}
unit untConfiguradorLuztol;

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
  TConfiguradorLuztol = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorLuztol }

function TConfiguradorLuztol.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;


procedure TConfiguradorLuztol.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorLuztol.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorLuztol.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorLuztol.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  ///Configuração Luztol
  Configurar('USATIN' , 'Utilizar essa tinta de máquina               ', 'N'        , tpSimNao          , 'GERAL');
  Configurar('USAFOR' , 'Utilizar Formulação                          ', 'S'        , tpSimNao          , 'GERAL');
  Configurar('TRALUZ' , 'Trava para valor de venda COR_PRE            ', 'VEN'      , tpTravaPreco      , 'GERAL');
  Configurar('FATLUZ' , 'Fator                                        ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('MARLUZ' , 'Margem de Lucro do colorante                 ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('DESOPE' , 'Despesas Operacionais (%)                    ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('APREVE' , 'Acréscimo Adicional sobre Preço de Venda (%) ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('NFMLUZ' , 'Próximo Código Novas Fórmulas                ', '00001'    , tpNumero_5        , 'GERAL');
  Configurar('PATLUZ' , 'Path para arquivo                            ', ''         , tpDiretorio       , 'GERAL');
  Configurar('DTAATU' , 'Data da Ultima Atualização                   ', ''         , tpData            , 'GERAL');
  Configurar('VERSAO' , 'Versão da Máquina                            ', ''         , tpNormal          , 'GERAL');
  Configurar('UNIOPR' , 'Unidade da Impressão da Ordem de Produção    ', ''         , tpUniImpOp        , 'GERAL');
  Configurar('ZERCOL' , 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao        , 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorLuztol.DiretorioValidar(strDir: String): string;
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

procedure TConfiguradorLuztol.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
