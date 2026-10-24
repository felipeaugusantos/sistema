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

    fltFatorTinta: Double;
    strItemEmbalagem: String;
    strTipoPreco: String;
    strTipoEmbalagem: String;
    intQuantidadeEmbalagem: Integer;
    intTipoFormulacao : Integer;
    fltPrecoEmbalagem: Double;
    fltEmbalagem: Double;
    fltVolumeProduto: Double;
    strMontadora: String;
    strA_n_o_: String;
    strUniversal: String;
    strChaFor: String;
    fltPrecoCustoRealTinta: Double;
    strNovaEmbalagem:String;
    strTipoTinta: String;
    strCatalisador: String;
    strBaseQtdZerada: String;
    strLinha: String;
    strUsaChapinha: String;
    strItemChapinha: String;
  public
    function GetChaveIteTin: String;
    function GetCodigoItem: String;
    function GetDescricaoCor: String;
    function GetPrecoCustoTinta: Double;
    function GetPrecoVendaTinta: Double;
    function GetUnidade: String;
    function fDigDadosTintometricos(const dtsCadTin: IDataSet; dicRetorno: IDicionario; blnSemTela: Boolean = False;
      strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean; virtual; abstract;
    constructor Create();
    function GetSaldos: ISaldosColorantes; virtual; abstract;

    function GetChaForEspecifico(const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String; virtual; abstract;

    function GetFatorTinta: Double;
    function GetItemEmbalagem: String;
    function GetTipoPreco: String;
    function GetTipoEmbalagem: String;
    function GetQuantidadeEmbalagem: Integer;
    function GetPrecoEmbalagem: Double;
    function GetEmbalagem: Double;
    function GetVolumeProduto: Double;
    function GetMontadadora: String;
    function GetA_n_o_: String;
    function GetUniversal: String;
    function GetChaFor: String;
    function GetPrecoCustoRealTinta: Double;
    function GetTipoTinta: String;
    function GetNovaEmbalagem:String;
    function GetCatalisador: String;
    function GetBaseQtdZerada: String;
    function GetLinha: String;
    function GetTipoFormulacao : Integer;
    function GetUsaChapinha: String;
    function GetItemChapinha: String;
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

  fltFatorTinta := 0.0;
  strItemEmbalagem := '';
  strTipoPreco := '';
  strTipoEmbalagem := '';
  intQuantidadeEmbalagem := 0;
  intTipoFormulacao := 0;
  fltPrecoEmbalagem := 0.0;
  fltEmbalagem := 0.0;
  fltVolumeProduto := 0.0;
  strMontadora := '';
  strA_n_o_ := '';
  strUniversal := '';
  strChaFor := '';
  fltPrecoCustoRealTinta := 0;
  strCatalisador := '';
  strBaseQtdZerada := '';
  strLinha := '';
end;

function TAbstractDigDadosTintometricos.GetA_n_o_: String;
begin
  Result := strA_n_o_;
end;

function TAbstractDigDadosTintometricos.GetBaseQtdZerada: String;
begin
  Result := strBaseQtdZerada;
end;

function TAbstractDigDadosTintometricos.GetCatalisador: String;
begin
  Result := strCatalisador;
end;

function TAbstractDigDadosTintometricos.GetChaFor: String;
begin
  Result := strChaFor;
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

function TAbstractDigDadosTintometricos.GetEmbalagem: Double;
begin
  Result := fltEmbalagem;
end;

function TAbstractDigDadosTintometricos.GetFatorTinta: Double;
begin
  Result := fltFatorTinta;
end;

function TAbstractDigDadosTintometricos.GetItemChapinha: String;
begin
  Result := strItemChapinha;
end;

function TAbstractDigDadosTintometricos.GetItemEmbalagem: String;
begin
  Result := strItemEmbalagem;
end;

function TAbstractDigDadosTintometricos.GetLinha: String;
begin
  Result := strLinha;
end;

function TAbstractDigDadosTintometricos.GetMontadadora: String;
begin
  Result := strMontadora;
end;

function TAbstractDigDadosTintometricos.GetNovaEmbalagem: String;
begin
  Result := strNovaEmbalagem;
end;

function TAbstractDigDadosTintometricos.GetPrecoCustoRealTinta: Double;
begin
  Result := fltPrecoCustoRealTinta;
end;

function TAbstractDigDadosTintometricos.GetPrecoCustoTinta: Double;
begin
  Result := fltPrecoCustoTinta;
end;

function TAbstractDigDadosTintometricos.GetPrecoEmbalagem: Double;
begin
  Result := fltPrecoEmbalagem;
end;

function TAbstractDigDadosTintometricos.GetPrecoVendaTinta: Double;
begin
  Result := fltPrecoVendaTinta;
end;

function TAbstractDigDadosTintometricos.GetQuantidadeEmbalagem: Integer;
begin
  Result := intQuantidadeEmbalagem;
end;

function TAbstractDigDadosTintometricos.GetTipoEmbalagem: String;
begin
  Result := strTipoEmbalagem;
end;

function TAbstractDigDadosTintometricos.GetTipoFormulacao: Integer;
begin
  Result := intTipoFormulacao;
end;

function TAbstractDigDadosTintometricos.GetTipoPreco: String;
begin
  Result := strTipoPreco;
end;

function TAbstractDigDadosTintometricos.GetTipoTinta: String;
begin
  Result := strTipoTinta;
end;

function TAbstractDigDadosTintometricos.GetUnidade: String;
begin
  Result := strUnidade;
end;

function TAbstractDigDadosTintometricos.GetUniversal: String;
begin
  Result := strUniversal;
end;

function TAbstractDigDadosTintometricos.GetUsaChapinha: String;
begin
  Result := strUsaChapinha;
end;

function TAbstractDigDadosTintometricos.GetVolumeProduto: Double;
begin
  Result := fltVolumeProduto;
end;

end.
