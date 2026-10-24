{*********************************************************************************************}
{* Interface que representa um configurador da tela de configuração, assim cada configuração *}
{* da tinta pode ser representada de formas distintas na tela.                               *}
{******************************************************************************************PH*}
unit untIConfiguradorTinta;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untTypesSistema;

const
  tpNormal = 1;
  tpDiretorio = tpNormal + 1;
  tpSimNao = tpDiretorio + 1;
  tpTravaPreco = tpSimNao + 1;
  tpSenha = tpTravaPreco + 1;
  tpNumero = tpSenha + 1;
  tpNumeroDecimal = tpNumero + 1;
  tpData = tpNumeroDecimal + 1;
  tpNumero_5 = tpData + 1;
  tpBotao = tpNumero_5 + 1;
  tpTravaPrecoCon = tpBotao + 1;
  tpTravaPrecoDil = tpTravaPrecoCon + 1;
  tpAcuAbs = tpTravaPrecoDil + 1;
  tpBotaoVenda = tpAcuAbs + 1;
  tpEmbalagemShe = tpBotaoVenda + 1;
  tpUniImpOp = tpEmbalagemShe + 1;
  tpTipoGeracao = tpUniImpOp + 1;
  tpBotaoBase = tpTipoGeracao + 1;
  tpBotaoLinha = tpBotaoBase + 1;
  tpBotaoLinhasUtil = tpBotaoLinha + 1;
  tpBotaoCalcFormulacao = tpBotaoLinhasUtil + 1;
  tpDosadora = tpBotaoCalcFormulacao + 1;
  tpQtdArquivo = tpDosadora + 1;
  tpArqDox = tpQtdArquivo + 1;
  tpCalForSal = tpArqDox + 1;
  tpModoVenda = tpCalForSal + 1;
  tpVolumeEmb = tpModoVenda + 1;
  tpDiluicao = tpVolumeEmb + 1;
  tpAcrMob = tpDiluicao + 1;
  tpMovEst = tpAcrMob + 1;
  tpDiretorioNv = tpMovEst + 1;


type
  TTipoPropriedade = Integer;

type
  IConfiguradorTinta = interface
    ['{573971B7-8979-4AE4-B388-B9DD9CC70F89}']
    function GetIdePro: string;
    function GetPropriedade(const strCodCfg: string): TTipoPropriedade;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
    function IsConfiguracaoExistente(const strCodCfg: string): Boolean;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
    function DiretorioValidar(strDir: String): String;
    function IsGrupoExistente(const strCodCfg: string): Boolean;
    function IsCfgSisTintaExistente(const strCodCfg: string): Boolean;
    function GetGrupo(const strCodCfg: string): String;
    function GetCfgSisTinta(const strCodCfg: string): String;
    function BotaoVendaClick(const strCodCfg: string; const strValCfg: string): string;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);

    function BotaoLinhaClick(const strCodCfg: string; const strValCfg: string): string;
    procedure BotaoLinhaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);

    function BotaoBaseClick(const strCodCfg: string; const strValCfg: string): string;
    procedure BotaoBaseValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);

    function BotalLinhasUtilClick(const strCodCfg: string; const strValCfg: string): string;
    procedure MovEstValidar(Sender: TObject; strNomCam: String);

    function DiretorioValidarNv(strDiretorio: String; strNomCam: String): String;

    property IdePro: string read GetIdePro;
  end;

implementation

end.
