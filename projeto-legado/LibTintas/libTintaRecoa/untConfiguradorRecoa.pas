{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Recoa *}
{*************************************************************************************AC*}
unit untConfiguradorRecoa;

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
  TConfiguradorRecoa = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorRecoa }

function TConfiguradorRecoa.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorRecoa.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorRecoa.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorRecoa.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorRecoa.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  ///Configuração Recoa
  Configurar('USATIN' , 'Utilizar essa tinta de máquina'            , 'N'       , tpSimNao        , 'GERAL');
  Configurar('USAFOR' , 'Utilizar Formulação'                       , 'S'       , tpSimNao        , 'GERAL');
  Configurar('PATREC' , 'Path para arquivos'                        , ''        , tpDiretorio     , 'GERAL');
  Configurar('NFMREC' , 'Próximo Código Novas Fórmulas'             , '00001'   , tpNumero_5      , 'GERAL');
  Configurar('TRAREC' , 'Trava para valor de venda COR_PRE'         , 'VEN'     , tpTravaPreco    , 'GERAL');
  Configurar('MARREC' , 'Margem de Lucro do colorante'              , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('DTAATU' , 'Data da Ultima Atualização'                , ''        , tpNormal        , 'GERAL');
  Configurar('VERSAO' , 'Versão da máquina'                         , ''        , tpNormal        , 'GERAL');
  Configurar('UNIOPR' , 'Unidade da Impressão da Ordem de Produção' , ''        , tpUniImpOp      , 'GERAL');
  Configurar('DESOPE' , 'Despesas Operacionais (%)'                   , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('APREVE' , 'Acréscimo Adicional sobre Preço de Venda (%)'  , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('FATREC' , 'Fator da trava de preço'                  , '0'       ,  tpNumeroDecimal , 'GERAL');
  Configurar('ZERCOL' , 'Zerar Valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorRecoa.DiretorioValidar(strDir: String): string;
var
  odSel: TOpenDialog;
begin
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.MDB*';
    odSel.Title      := 'Informe o diretório...';
    odSel.InitialDir :=  ExtractFileDir(Result);

    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
end;
{$ENDIF}

procedure TConfiguradorRecoa.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
