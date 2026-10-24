{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Iquine *}
{*************************************************************************************AC*}
unit untConfiguradorIquine;

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
  TConfiguradorIquine = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorIquine }

function TConfiguradorIquine.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorIquine.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorIquine.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorIquine.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorIquine.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);
  //Configuração Iquine
  Configurar('USATIN'         ,       'Utilizar essa tinta de máquina'                          , 'N'             ,   tpSimNao             ,   'GERAL');
  Configurar('USAFOR'         ,       'Utilizar Formulação'                                     , 'S'             ,   tpSimNao             ,   'GERAL');
  Configurar('PATIQU'         ,       'Path para os arquivos'                                   , ''              ,   tpDiretorio          ,   'GERAL');
  Configurar('NFMIQU'         ,       'Próximo Código Novas Fórmulas'                           , '00001'         ,   tpNumero_5           ,   'GERAL');
  Configurar('TRAIQU'         ,       'Trava para valor de venda COR_PRE'                       , 'VEN'           ,   tpTravaPreco         ,   'GERAL');
  Configurar('FATIQU'         ,       'Fator da trava de preço'                                 , '0'             ,   tpNumeroDecimal      ,   'GERAL');
  Configurar('MARIQU'         ,       'Margem de lucro do colorante'                            , '0'             ,   tpNumeroDecimal      ,   'GERAL');
  Configurar('VERSAO'         ,       'Versão da máquina'                                       , ''              ,   tpNormal             ,   'GERAL');
  Configurar('DTAATU'         ,       'Data da ultima Atualização'                              , ''              ,   tpNormal             ,   'GERAL');
  Configurar('DESOPE'         ,       'Despesas Operacionais (%)'                                   , '0'             ,   tpNumeroDecimal      ,   'GERAL');
  Configurar('APREVE'         ,       'Acréscimo Adicional sobre Preço de Venda (%)'                , '0'             ,   tpNumeroDecimal      ,   'GERAL');
  Configurar('UNIOPR'         ,       'Unidade da Impressão de Ordem de Produção'               , ''              ,   tpUniImpOp           ,   'GERAL');
  Configurar('ZERCOL'         ,       'Zerar valor dos colorantes na venda da tinta de máquina' , 'N'             ,   tpSimNao             ,   'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorIquine.DiretorioValidar(strDir: String): string;
var
  odSel: TOpenDialog;
begin
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.XLS*';
    odSel.Title      := 'Informe o diretório...';
    odSel.InitialDir :=  ExtractFileDir(Result);

    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
end;
{$ENDIF}

procedure TConfiguradorIquine.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
