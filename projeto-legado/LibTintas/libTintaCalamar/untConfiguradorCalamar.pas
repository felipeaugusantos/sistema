{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Calamar *}
{*************************************************************************************AC*}
unit untConfiguradorCalamar;

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
  TConfiguradorCalamar = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorCalamar }

function TConfiguradorCalamar.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorCalamar.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorCalamar.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorCalamar.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorCalamar.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);
  //Configuração Calamar
  Configurar('USATIN',  'Utulizar essa tinta de máquina                           ',  'N'        ,  tpSimNao         , 'GERAL');
  Configurar('USAFOR',  'Utilizar Formulação                                      ',  'S'        ,  tpSimNao         , 'GERAL');
  Configurar('TRACAL',  'Trava para valor de venda(CAL_TRA)                       ',  'VEN'      ,  tpTravaPreco     , 'GERAL');
  Configurar('FATCAL',  'Fator da trava de preço                                  ',  '0'        ,  tpNumeroDecimal  , 'GERAL');
  Configurar('CALNFM',  'Próximo Código Novas Fórmulas                            ',  '00001'    ,  tpNumero_5       , 'GERAL');
  Configurar('DESOPE',  'Despesas Operacionais (%)                                ',  '0'        ,  tpNumeroDecimal  , 'GERAL');
  Configurar('APREVE',  'Acréscimo Adicional sobre Preço de Venda (%)             ',  '0'        ,  tpNumeroDecimal  , 'GERAL');
  Configurar('PATCAL',  'Path para os arquivos                                    ',  ''         ,  tpDiretorio      , 'GERAL');
  Configurar('DTAATU',  'Data da Ultima Atualização                               ',  ''         ,  tpNormal         , 'GERAL');
  Configurar('VERSAO',  'Versão da máquina                                        ',  ''         ,  tpNormal         , 'GERAL');
  Configurar('UNIOPR',  'Unidade da Impressão de Ordem de Produção                ',  ''         ,  tpUniImpOp       , 'GERAL');
  Configurar('ZERCOL',  'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorCalamar.DiretorioValidar(strDir: String): string;
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

procedure TConfiguradorCalamar.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
