{****************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta AdvanceStr *}
{*************************************************************************************AC*}
unit untConfiguradorAdvanceStr;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
  DirectoryEditFocus,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, SysUtils, untAutcomTintaFactory,
  untTypesSistema;

type
  TConfiguradorAdvanceStr = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean; const strNomCam: String); override;
    function DiretorioValidar(strDir: String): string; override;
    function BotaoVendaClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
    procedure MovEstValidar(Sender: TObject; strNomCam: String); Override;
  end;

implementation

uses
  untLibTintaFactory;

{ TConfiguradorAdvanceStr }

function TConfiguradorAdvanceStr.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;


procedure TConfiguradorAdvanceStr.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorAdvanceStr.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
end;

procedure TConfiguradorAdvanceStr.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
end;

constructor TConfiguradorAdvanceStr.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  ///Configuração AdvanceStr
  Configurar('USATIN' , 'Utilizar essa tinta de máquina               ', 'N'        , tpSimNao          , 'GERAL');
  Configurar('USAFOR' , 'Utilizar Formulação                          ', 'S'        , tpSimNao          , 'GERAL');
  Configurar('TRAADS' , 'Trava para valor de venda COR_PRE            ', 'VEN'      , tpTravaPreco      , 'GERAL');
  Configurar('FATADS' , 'Fator                                        ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('MARADS' , 'Margem de Lucro do colorante                 ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('DESOPE' , 'Despesas Operacionais (%)                    ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('APREVE' , 'Acréscimo Adicional sobre Preço de Venda (%) ', '0'        , tpNumeroDecimal   , 'GERAL');
  Configurar('NFMADS' , 'Próximo Código Novas Fórmulas                ', '00001'    , tpNumero_5        , 'GERAL');
  Configurar('PATADS' , 'Path para arquivo                            ', ''         , tpDiretorio       , 'GERAL');
  Configurar('DTAATU' , 'Data da Ultima Atualização                   ', ''         , tpData            , 'GERAL');
  Configurar('VERSAO' , 'Versão da Máquina                            ', ''         , tpNormal          , 'GERAL');
  Configurar('UNIOPR' , 'Unidade da Impressão da Ordem de Produção    ', ''         , tpUniImpOp        , 'GERAL');
  Configurar('ZERCOL' , 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao        , 'GERAL');
  Configurar('ACRMOB' , 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('MOVEST' , 'Movimentar Estoque dos Colorantes em         ',           'GR', tpMovEst       , 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');

  //CONFIGURAÇÃO POSTGRESSQL - Advance Str
  Configurar('SERADS', 'Servidor: ', '', tpNormal, 'CONEXÃO');
  Configurar('PORADS', 'Porta: ', '', tpNormal, 'CONEXÃO');
  Configurar('USUADS', 'Usuario: ', '', tpNormal, 'CONEXÃO');
  Configurar('SENADS', 'Senha: ', '', tpSenha, 'CONEXÃO');
  Configurar('DTBADS', 'Database: ', '', tpNormal, 'CONEXÃO');
end;

function TConfiguradorAdvanceStr.DiretorioValidar(strDir: String): string;
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


procedure TConfiguradorAdvanceStr.MovEstValidar(Sender: TObject;
  strNomCam: String);
begin
  If strNomCam = 'MOVEST' Then
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'ESSA CONFIGURAÇÃO TEM IMPACTO NA MOVIMENTAÇÃO DE ESTOQUE E NO SALDO DOS COLORANTES.' + #13#10 +
      'ENTRAR EM CONTATO COM A CITEL ANTES DE ALTERAR.', ['&Ok']);
end;

procedure TConfiguradorAdvanceStr.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
