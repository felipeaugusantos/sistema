{*******************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Universo Imobiliaria *}
{****************************************************************************************PH*}
unit untConfiguradorUniverso;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untStrUtils, untAutcomTintaFactory, untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, untGenericLibTintaControleVisualLabel, untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus, untLibTintaControleVisualImplementacao, untGenericLibTintaControleVisualDBCheckBox,
  untGenericLibTintaControleVisual, untGenericLibTintaControleVisualWinControl, untTypesSistema;

type
  TConfiguradorUniverso = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorUniverso }

function TConfiguradorUniverso.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorUniverso.BotaoVendaValidar(
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorUniverso.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorUniverso.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;


constructor TConfiguradorUniverso.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);


  Configurar('USATIN' ,   'Utilizar essa tinta de máquina          ' , 'N'       , tpSimNao        , 'GERAL');
  Configurar('DTAATU' ,   'Data da ultima atualização              ' , ''        , tpData          , 'GERAL');
  Configurar('UNITRA' ,   'Trava para valor de venda(UNI_PRE)      ' , 'VEN'     , tpTravaPreco    , 'GERAL');
  Configurar('UNIFAT' ,   'Fator                                   ' , '1'       , tpNumeroDecimal , 'GERAL');
  Configurar('UNINFM' ,   'Próximo Código Novas Formulas           ' , '00001'   , tpNumero_5      , 'GERAL');
  Configurar('UNIPAT' ,   'Path para os arquivos de fórmulas       ' ,  ''       , tpDiretorio     , 'GERAL');
  Configurar('DESOPE' ,   'Despesas Operacionais(%)                ' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('APREVE' ,   'Acréscimo Adicional sobre Preço de Venda (%)' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('USAFOR' ,   'Utilizar Formulação                     ' , 'S'       , tpSimNao        , 'GERAL');
  Configurar('UNIOPR' ,   'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL');
  Configurar('VERSAO' ,   'Versão da Maquina                       ' , ''        , tpNormal        , 'GERAL');
  Configurar('ZERCOL' ,   'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorUniverso.DiretorioValidar(strDir: String): string;
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

procedure TConfiguradorUniverso.NumeroValidar(
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean;
  const strNomCam: String);
begin
end;

end.
