{*************************************************************************************}
{* Interface que representa a tinta ao todo, com isso pode ser trabalhada pelo       *}
{* autcom/autcomtinta/auttin, sem esses terem conhecimento da implementação da tinta *}
{**********************************************************************************PH*}
unit untILibTinta;

interface

uses
  untTipoTinta, untITintadeMaquinaWrapper, untIDataSet,
  untGTinForTipos, untIDicionario, untIAuttinMenuItem,
  untISaldosColorantes;

type
  ILibTinta = interface
    ['{077D9660-2090-4007-BC0C-281C471D7654}']
    function GetIdePro: String;
    function fTipoTinta: TTipoTinta;
    function fTintaBaixaProduto(): Boolean;
    function fTintaBaixaEmbalagem(const strTipEmb: String; Var strCodIte: String): Boolean;
    function fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean;
    function fTintaGeraFormulacao(): Boolean;
    function fTintaVendaDinamica(): Boolean;
    function fRetornaTabelaColoranteTinta(): String;
    procedure pRetItemColorante(const strColTinDet: String; Var strCodIte, strCodBas: String);
    function fFormulacaoAcumulada(): Boolean;
    procedure pTintaRetornaTabelaPreco(const dicRetorno: IDicionario; fltFatorAcerto: Double);
    function fGetFatorML(): Double;
    function GetITintadeMaquina(): ITintadeMaquinaWrapper;
    function GetNomeTinta: String;
    function RetornaDescricaoTinta(const strDesCri: String; const dtsTinta: IDataSet; const strTipPre: String): String;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
    function RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
      var saldos: ISaldosColorantes): Boolean;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
    function fGTinForGeral(var arrFormul: TForMulTinDetArray;
      var arrBaixaPigmentos: TBaixaPigmentosArray;
      const dicDados: IDicionario): Boolean;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
    function GetMenu: IAuttinMenuItem;

    property IdePro: String read GetIdePro;
    property Menu: IAuttinMenuItem read GetMenu;
  end;

implementation

end.
