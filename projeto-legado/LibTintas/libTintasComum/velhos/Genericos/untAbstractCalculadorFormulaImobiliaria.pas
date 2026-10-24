{*********************************************************************************************}
{* Classe abstrata que implementa a interface ICalculadorFormulaImobiliaria responsável pelo *}
{* calculo de preço dos componentes de uma tinta                                             *}
{******************************************************************************************PH*}
unit untAbstractCalculadorFormulaImobiliaria;

interface

uses
  untICalculadorFormulaImobiliaria, untColorante, untAbstractFormulaImobiliaria, SysUtils;

type
  TAbstractCalculadorFormulaImobiliaria = class abstract(TInterfacedObject, ICalculadorFormulaImobiliaria)
  protected
    fltOutrosValores: Double;
    fltIcmsSaida: Double;
    fltImpostosFederais: Double;
    fltDespesasOperacionais: Double;
    fltPrecoCusto: Double;
    fltPrecoCustoReal: Double;
    fltPrecoVenda: Double;
    formula: TAbstractFormulaImobiliaria;
  protected
    procedure CalcularColorante(const colorante: TColorante); virtual; 
  public
    procedure Calcular; virtual;
    procedure Zerar; virtual;
  public
    constructor Create(const formula: TAbstractFormulaImobiliaria);
    function GetDespesasOperacionais: Double;
    function GetIcmsSaida: Double;
    function GetImpostosFederais: Double;
    function GetOutrosValores: Double;
    function GetPrecoCusto: Double;
    function GetPrecoVenda: Double;
    function GetPrecoCustoReal: Double;
  end;

implementation

uses
  untStrUtils, untAutcomTintaFactory, untIDicionario;

{ TAbstractCalculadorFormulaImobiliaria }

procedure TAbstractCalculadorFormulaImobiliaria.Calcular;
var
  colorante: TColorante;
  intIndex: Integer;
  dicDados: IDicionario;
begin
  Zerar;

  For intIndex := 0 To formula.Count -1 Do
  Begin
    colorante := TColorante(formula.Items[intIndex]);

    If (Not formula.ColorantesDataSet.Locate('COL_CODCOL', colorante.CodigoColorante, [])) Then
    Begin
      Zerar;
      Raise Exception.Create('Colorante ' + colorante.CodigoColorante + ' não cadastrado. Favor verificar.');
    End;

    If (TStrUtils.fEmptyStr(formula.ColorantesDataSet.FieldByName('COL_CODITE').AsString)) Then
    Begin
      Zerar;
      Raise Exception.Create('Colorante ' + colorante.CodigoColorante + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
    End;

    If (formula.ColorantesDataSet.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      Zerar;
      Raise Exception.Create('O produto ' + formula.ColorantesDataSet.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
    End;

    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := colorante.PrecoVenda;
    dicDados['precus'] := colorante.PrecoCusto;
    dicDados['outval'] := colorante.OutrosValores;
    dicDados['icmsai'] := colorante.IcmsSaida;
    dicDados['impfed'] := colorante.ImpostosFederais;
    dicDados['desope'] := colorante.DespesasOperacionais;

    colorante.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
    CalcularColorante(colorante);
  End;
  
end;

procedure TAbstractCalculadorFormulaImobiliaria.CalcularColorante(const colorante: TColorante);
begin
  fltOutrosValores := fltOutrosValores + colorante.Quantidade * formula.FatorEstoque * colorante.OutrosValores / colorante.Embalagem;

  fltIcmsSaida := fltIcmsSaida +
    colorante.Quantidade * formula.FatorEstoque * (colorante.IcmsSaida * colorante.PrecoVenda / 100) / colorante.Embalagem;

  fltImpostosFederais := fltImpostosFederais +
    colorante.Quantidade * formula.FatorEstoque * (colorante.ImpostosFederais * colorante.PrecoVenda / 100) / colorante.Embalagem;

  fltDespesasOperacionais := fltDespesasOperacionais +
    colorante.Quantidade * formula.FatorEstoque * (colorante.DespesasOperacionais * colorante.PrecoVenda / 100) / colorante.Embalagem;

  fltPrecoCusto := fltPrecoCusto + colorante.Quantidade * formula.FatorEstoque * colorante.PrecoCusto / colorante.Embalagem;
  fltPrecoCustoReal := fltPrecoCustoReal + colorante.Quantidade * formula.FatorEstoque * colorante.PrecoCustoReal / colorante.Embalagem;
  fltPrecoVenda := fltPrecoVenda + colorante.Quantidade * formula.FatorEstoque * colorante.PrecoVenda / colorante.Embalagem;
end;

constructor TAbstractCalculadorFormulaImobiliaria.Create(const formula: TAbstractFormulaImobiliaria);
begin
  inherited Create();
  Self.formula := formula;
end;

function TAbstractCalculadorFormulaImobiliaria.GetDespesasOperacionais: Double;
begin
  Result := fltDespesasOperacionais;
end;

function TAbstractCalculadorFormulaImobiliaria.GetIcmsSaida: Double;
begin
  Result := fltIcmsSaida;
end;

function TAbstractCalculadorFormulaImobiliaria.GetImpostosFederais: Double;
begin
  Result := fltImpostosFederais;
end;

function TAbstractCalculadorFormulaImobiliaria.GetOutrosValores: Double;
begin
  Result := fltOutrosValores;
end;

function TAbstractCalculadorFormulaImobiliaria.GetPrecoCusto: Double;
begin
  Result := fltPrecoCusto;
end;

function TAbstractCalculadorFormulaImobiliaria.GetPrecoCustoReal: Double;
begin
  Result := fltPrecoCustoReal;
end;

function TAbstractCalculadorFormulaImobiliaria.GetPrecoVenda: Double;
begin
  Result := fltPrecoVenda;
end;

procedure TAbstractCalculadorFormulaImobiliaria.Zerar;
begin
  fltOutrosValores := 0;
  fltIcmsSaida := 0;
  fltImpostosFederais := 0;
  fltDespesasOperacionais := 0;
  fltPrecoCusto := 0;
  fltPrecoVenda := 0;
end;

end.
