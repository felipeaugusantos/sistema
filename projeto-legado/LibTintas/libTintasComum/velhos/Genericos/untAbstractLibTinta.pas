{***************************************************************************************}
{* Classe abstrata que representa a tinta ao todo, contendo todos os metodos que serão *}
{* acessados pelos outros modulos (Autcom/Auttin)                                      *}
{************************************************************************************PH*}
unit untAbstractLibTinta;

interface

uses
  untILibTinta, untTipoTinta, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untITintadeMaquinaWrapper, untGTinForTipos, untIDicionario, untIDigDadosTintometricos,
  untIAuttinMenuItem, untISaldosColorantes;
  
type
  TAbstractLibTinta = class abstract (TInterfacedObject, ILibTinta)
  protected
    function GetInstrucaoRetComponentes(): String; virtual;
    function GetWhereRetComponente(): String; virtual; abstract;
    function GetCampoComponenteCodIte(): String; virtual; abstract;
    function GetCampoComponenteCodComp(): String; virtual; abstract;
    procedure SetaParametrosRetComponentes(const dataSet: IDataSet; const strCodComp: String); virtual; abstract;
    function GetFatorEstoque(): Double; virtual;
  public
    constructor Create();
    destructor Destroy; override;
    function GetIdePro: String; virtual; abstract;
    function fTipoTinta: TTipoTinta; virtual; abstract;
    function fTintaBaixaProduto(): Boolean; virtual; abstract;
    function fTintaBaixaEmbalagem(const strTipEmb: String; Var strCodIte: String): Boolean; virtual; abstract;
    function fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean; virtual; abstract;
    function fTintaGeraFormulacao(): Boolean; virtual;
    function fTintaVendaDinamica(): Boolean; virtual;
    function fRetornaTabelaColoranteTinta(): String; virtual; abstract;
    procedure pRetItemColorante(const strColTinDet: String; Var strCodIte, strCodBas: String); virtual;
    function fFormulacaoAcumulada(): Boolean; virtual; abstract;
    procedure pTintaRetornaTabelaPreco(const dicRetorno: IDicionario; fltFatorAcerto: Double); virtual; abstract;
    function fGetFatorML(): Double;
    function GetITintadeMaquina: ITintadeMaquinaWrapper; virtual; abstract;
    function GetNomeTinta: String; virtual; abstract;
    function RetornaDescricaoTinta(const strDesCri: String; const dtsTinta: IDataSet; const strTipPre: String): String; virtual;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String; virtual; abstract;
    function RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
      var saldos: ISaldosColorantes): Boolean; virtual; abstract;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double; virtual; abstract;
    function fGTinForGeral(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
      const dicDados: IDicionario): Boolean; virtual; abstract;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario); virtual; abstract;
    function GetDigDadosTintometricos(strTabPre: string): IDigDadosTintometricos; virtual; abstract;
    function GetMenu: IAuttinMenuItem; virtual; abstract;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TAbstractLibTinta }

constructor TAbstractLibTinta.Create();
begin
  inherited Create();
end;

destructor TAbstractLibTinta.Destroy;
begin

  inherited Destroy;
end;

function TAbstractLibTinta.fGetFatorML: Double;
begin
  Result := GetFatorEstoque;
end;

function TAbstractLibTinta.fTintaGeraFormulacao: Boolean;
begin
  Result := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetBoolean('USAFOR');
end;

function TAbstractLibTinta.fTintaVendaDinamica: Boolean;
begin
  Result := True;
end;

function TAbstractLibTinta.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TAbstractLibTinta.GetInstrucaoRetComponentes: String;
begin
  Result :=
    ' SELECT ' +
    '   ' + Self.GetCampoComponenteCodIte +
    '   ,' + Self.GetCampoComponenteCodComp +
    ' FROM ' +
    '   ' + Self.fRetornaTabelaColoranteTinta +
    ' WHERE ' + GetWhereRetComponente;
end;

procedure TAbstractLibTinta.pRetItemColorante(const strColTinDet: String; var strCodIte, strCodBas: String);
var
  dataSet: IDataSet;
begin
  dataSet := nil;
  Try
    Try
      dataSet := TAutcomTintaFactory.Get().fGetDataSet;
      dataSet.SQL:= GetInstrucaoRetComponentes;
      SetaParametrosRetComponentes(dataSet, strColTinDet);
      dataSet.Open;

      strCodIte := dataSet.FieldByName(GetCampoComponenteCodIte).AsString;
      strCodBas := dataSet.FieldByName(GetCampoComponenteCodComp).AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    dataSet := nil;
  End;
end;

function TAbstractLibTinta.RetornaDescricaoTinta(const strDesCri: String; const dtsTinta: IDataSet; const strTipPre: String): String;
begin
  Result := strDesCri;
end;

end.
