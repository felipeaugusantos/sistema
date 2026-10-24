{*************************************************************************************}
{* Interface que representa a tinta ao todo, com isso pode ser trabalhada pelo       *}
{* autcom/autcomtinta/auttin, sem esses terem conhecimento da implementação da tinta *}
{**********************************************************************************PH*}
unit untILibTinta;

interface

uses
  untTipoTinta, untITintadeMaquinaWrapper, untIDataSet,
  untGTinForTipos, untIDicionario, untIAuttinMenuItem,
  untISaldosColorantes, Classes
  {$IFNDEF LINUX}
  ,Winapi.Windows
  {$ENDIF}
  ;

type
  ILibTinta = interface
    ['{077D9660-2090-4007-BC0C-281C471D7654}']
    function GetIdePro: String;
    function fTipoTinta: TTipoTinta;
    function fTintaBaixaProduto(): Boolean;
    function fTintaBaixaEmbalagem(const strTipEmb: String; Var strCodIte: String): Boolean;
    function fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean;
    function fTintaGeraFormulacao(): Boolean;
    function fRetornaTabelaColoranteTinta(): String;
    procedure pRetItemColorante(const strColTinDet: String; Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: String);
    function fFormulacaoAcumulada(): Boolean;
    procedure pTintaRetornaTabelaPreco(dicRetorno: IDicionario; fltFatorAcerto: Double);
    function fGetFatorML(): Double;
    function GetITintadeMaquina(): ITintadeMaquinaWrapper;
    function GetNomeTinta: String;
    function RetornaDescricaoTinta(const strDesCri: String; const dtsTinta: IDataSet; const strTipPre: String): String;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
    function RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
      var saldos: ISaldosColorantes; blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil;
        strMD5Key: String = ''; blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
    function fGTinForGeral(var arrFormul: TForMulTinDetArray;
      var arrBaixaPigmentos: TBaixaPigmentosArray;
      const dicDados: IDicionario): Boolean;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
    function GetMenu: IAuttinMenuItem;
    function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String = ''): String;
    function GetQuantidadeMlPulso(const fltValor: Double; intDecFor: Integer; strFormul: String): String;
    function GetNomeTabelaFormulacao: String;
    function GetQuantidadeGramaMl(const fltValor: Double; const Fator: Double; strFormula: String): Double;
    function fUsaChapinhaTinta(strIdePro, strIteTin: String): Boolean;
    function fRetornaCodigoChapinha(strIdePro: String): String;
    property IdePro: String read GetIdePro;
    property Menu: IAuttinMenuItem read GetMenu;
  end;

procedure pDebugViaEventLog(const strMsg: String);

implementation

procedure pDebugViaEventLog(const strMsg: String);
begin
  EXIT;

{*******************************************************************************}
{* ATENÇÃO SÓ TIRE O EXIT; ACIMA EM TEMPO DE DESENVOLVIMENTO PARA ACOMPANHAR O *}
{* FLUXO DAS CHAMADAS DO AutcomTinta.dll UMA VEZ QUE OutputDebugString DEIXA A *}
{* EXECUÇÃO EXTREMAMENTE LENTA. NUNCA COMMIT SEM ESSE EXIT;                    *}
{****************************************************************************VA*}

{$IFNDEF LINUX}
 {$IFDEF DEBUG}
  OutputDebugString(PWideChar(strMsg));
 {$ENDIF}
{$ENDIF}
end;

end.

