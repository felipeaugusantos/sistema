{**************************************************************************************}
{* Classe abstrata que implementa a interface IDigDadosTintometricos, resposável pela *}
{* digitação de dados do usuario para configurar a tinta que está sendo vendidada no  *}
{* momento, como por exemplo, descrição auxiliar e troca de base                      *}
{***********************************************************************************PH*}
unit untAbstractDigDadosTintometricos;

interface

uses
  untIDigDadosTintometricos, untIDataSet, untIDicionario, untISaldosColorantes;

type
  TAbstractDigDadosTintometricos = class abstract(TInterfacedObject, IDigDadosTintometricos)
  protected
    strChaveIteTin: String;
    strCodigoItem: String;
    strDescricaoCor: String;
    fltPrecoCustoTinta: Double;
    fltPrecoVendaTinta: Double;
    strUnidade: String;
  public
    function GetChaveIteTin: String;
    function GetCodigoItem: String;
    function GetDescricaoCor: String;
    function GetPrecoCustoTinta: Double;
    function GetPrecoVendaTinta: Double;
    function GetUnidade: String;
    function fDigDadosTintometricos(const dtsCadTin: IDataSet; const dicRetorno: IDicionario): Boolean; virtual; abstract;
    constructor Create();
    function GetSaldos: ISaldosColorantes; virtual; abstract;
  end;

implementation

{ TAbstractDigDadosTintometricos }

constructor TAbstractDigDadosTintometricos.Create;
begin
  inherited Create();
  strChaveIteTin := '';
  strCodigoItem := '';
  strDescricaoCor := '';
  fltPrecoCustoTinta := 0;
  fltPrecoVendaTinta := 0;
  strUnidade := '';
end;

function TAbstractDigDadosTintometricos.GetChaveIteTin: String;
begin
  Result := strChaveIteTin;
end;

function TAbstractDigDadosTintometricos.GetCodigoItem: String;
begin
  Result := strCodigoItem;
end;

function TAbstractDigDadosTintometricos.GetDescricaoCor: String;
begin
  Result := strDescricaoCor;
end;

function TAbstractDigDadosTintometricos.GetPrecoCustoTinta: Double;
begin
  Result := fltPrecoCustoTinta;
end;

function TAbstractDigDadosTintometricos.GetPrecoVendaTinta: Double;
begin
  Result := fltPrecoVendaTinta;
end;

function TAbstractDigDadosTintometricos.GetUnidade: String;
begin
  Result := strUnidade;
end;

end.
