
{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Killing *}
{****************************************************************************PH*}
unit untConfiguradorKilling;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untStrUtils, untTypesSistema;

type
  TConfiguradorKilling = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorKilling }

function TConfiguradorKilling.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorKilling.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  //
end;

function TConfiguradorKilling.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
  //
end;

procedure TConfiguradorKilling.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  //
end;

constructor TConfiguradorKilling.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  ///////////////////// Configurações Killing [GERAIS
  Configurar('USATIN'       , 'Utilizar essa tinta de máquina                       ',  'N'     , tpSimNao        ,   'GERAL');
  Configurar('USAFOR'       , 'Utilizar Formulação                                  ',  'S'     , tpSimNao        ,   'GERAL');
  Configurar('DESOPE'       , 'Despesas Operacionais (%)                            ',  '0'     , tpNumeroDecimal ,   'GERAL');
  Configurar('APREVE'       , 'Acréscimo Adicional sobre Preço de Venda (%)         ',  '0'     , tpNumeroDecimal ,   'GERAL');
  Configurar('FATKIL'       , 'Fator da trava de preço                              ',  '0'     , tpNumeroDecimal ,   'GERAL');
  Configurar('TRAKIL'       , 'Trava para valor de venda KIL_PRE                    ',  'VEN'   , tpTravaPreco    ,   'GERAL');
  Configurar('KILNFM'       , 'Proximo Código Novas Fórmulas                        ',  '00001' , tpNumero_5      ,   'GERAL');
  Configurar('DTAATU'       , 'Data da Ultima Atualização                           ',  ''      , tpData          ,   'GERAL');
  Configurar('VERSAO'       , 'Versão da máquina                                    ',  ''      , tpNormal        ,   'GERAL');
  Configurar('PATKIL'       , 'Path para arquivos de fórmulas                       ',  ''      , tpDiretorio     ,   'GERAL');
  Configurar('UNIOPR'       , 'Unidade da Impressão de Ordem de Produção            ',  ''      , tpUniImpOp      ,   'GERAL');
  Configurar('TIPDOS'       , 'Tipo da Dosadora(Novas Fórmulas)                     ',  '0'     , tpDosadora      ,   'GERAL');
  Configurar('ZERCOL'       , 'Zerar valor dos colorantes na venda da tinta de máquina', 'N'    , tpSimNao        ,   'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
                                                                                                         /////////////////////]

  ///////////////////// Configurações Killing [CONEXÃO FIREBIRD
  Configurar('SERKIL'      ,  'Servidor:                                            ',  ''              ,  tpNormal        ,   'CONEXÃO POSTGRES');
  Configurar('PORKIL'      ,  'Porta:                                               ',  ''              ,  tpNormal        ,   'CONEXÃO POSTGRES');
  Configurar('USUKIL'      ,  'Usuario:                                             ',  ''              ,  tpNormal        ,   'CONEXÃO POSTGRES');
  Configurar('SENKIL'      ,  'Senha:                                               ',  ''              ,  tpSenha         ,   'CONEXÃO POSTGRES');
  Configurar('DBKILL'      ,  'Database:                                            ',  ''              ,  tpNormal        ,   'CONEXÃO POSTGRES');
                                                                                                                    /////////////////////]
end;

{$IFNDEF LINUX}
function TConfiguradorKilling.DiretorioValidar(strDir: String): string;
var
  odSel: TOpenDialog;
begin
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.txt*;.gdb*';
    odSel.Title      := 'Informe o diretório...';
    odSel.InitialDir :=  ExtractFileDir(Result);

    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
end;
{$ENDIF}


procedure TConfiguradorKilling.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
