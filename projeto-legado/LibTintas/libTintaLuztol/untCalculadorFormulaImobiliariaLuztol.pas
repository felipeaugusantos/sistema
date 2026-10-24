{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Luztol *}
{***********************************************************************************AC*}
unit untCalculadorFormulaImobiliariaLuztol;

interface

uses
  untICalculadorFormulaImobiliaria, untColorante, untAbstractFormulaImobiliaria, SysUtils, Classes,
  untGenericTintaDeMaquina, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untAbstractFormula, untAbstractCalculadorFormulaImobiliaria, untIDataSet;

type
  TCalculadorFormulaImobiliariaLuztol = class(TAbstractCalculadorFormulaImobiliaria)
  protected
    procedure pVerificacoesColorante(DataSetColorante: IDataSet; strCodCol: String);
  protected
    procedure CalcularColorante(const colorante: TColorante); Override;
    procedure CalcularComponente(const colorante: TColorante; const componente: ITintaDeMaquinaComponente); Override;
  public
    procedure Calcular; Override;
    procedure Zerar; Override;
  public
    constructor Create(const formula: TAbstractFormulaImobiliaria);
  end;


implementation

uses
  untStrUtils, untAutcomTintaFactory, untIDicionario,
  untTintaDeMaquinaComponenteComparerColorante;


{ TCalculadorFormulaImobiliariaLuztol }

procedure TCalculadorFormulaImobiliariaLuztol.Calcular;
var
  colorante: TColorante;
  intIndex: Integer;
  dicDados: IDicionario;
  componente: ITintaDeMaquinaComponente;
begin
  Zerar;

  For intIndex := 0 To formula.Count -1 Do
  Begin
    colorante := TColorante(formula.Items[intIndex]);

    If Colorante.Tipo = tciColorante Then
      pVerificacoesColorante(formula.ColorantesDataSet, Colorante.CodigoColorante);

    If Colorante.Tipo = tciBase Then
    Begin

      If Not formula.BasesDataSet.Locate('BAS_CODBAS', colorante.CodigoColorante, []) Then
      Begin
        Zerar;
        Raise Exception.Create('Base ' + Colorante.CodigoColorante + ' não cadastrada. Favor Verificar.');
      End;

      If (TStrUtils.fEmptyStr(formula.BasesDataSet.FieldByName('BAS_CODITE').AsString)) Then
      Begin
        Zerar;
        Raise Exception.Create('Base ' + Colorante.CodigoColorante + ' não está com  o produto para venda associado. ' + #13#10 +
          'Favor Verificar.');
      End;
    End;

     If (colorante.Embalagem <= 0) Then
    Begin
      Zerar;
      Raise Exception.Create('O Colorante ' + colorante.CodigoColorante + ' não está com a Embalagem preenchida corretamente.' + #13#10 +
                             'Favor verificar.');
    End;

    componente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(colorante.CodigoColorante));
    if not Assigned(componente) then
    begin
      If Colorante.Tipo = tciBase Then
        componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
          formula.BasesDataSet.FieldByName('BAS_CODITE').AsString, colorante.CodigoColorante, tmctColoranteImobiliario))
      Else
        componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
          formula.ColorantesDataSet.FieldByName('COL_CODITE').AsString, colorante.CodigoColorante, tmctColoranteImobiliario));
    end;

    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := colorante.PrecoVenda;
    dicDados['precus'] := colorante.PrecoCusto;
    dicDados['outval'] := colorante.OutrosValores;
    dicDados['icmsai'] := colorante.IcmsSaida;
    dicDados['impfed'] := colorante.ImpostosFederais;
    dicDados['desope'] := colorante.DespesasOperacionais;

    colorante.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
    CalcularColorante(colorante);
    CalcularComponente(colorante, componente);
  End;
end;

procedure TCalculadorFormulaImobiliariaLuztol.CalcularColorante(
  const colorante: TColorante);
begin
  fltOutrosValores := fltOutrosValores + colorante.Quantidade * formula.FatorEstoque * colorante.OutrosValores / colorante.Embalagem;

  fltPrecoMedio := fltPrecoMedio + colorante.Quantidade * formula.FatorEstoque * colorante.PrecoMedio / colorante.Embalagem;
  fltUltimoPrecoCompra := fltUltimoPrecoCompra + colorante.Quantidade * formula.FatorEstoque * colorante.UltimoPrecoCompra / colorante.Embalagem;
  fltUltimoPrecoCompraImpostos := fltUltimoPrecoCompraImpostos + colorante.Quantidade * formula.FatorEstoque * colorante.UltimoPrecoCompraImpostos / colorante.Embalagem;
  fltPrecoCompraLiquido := fltPrecoCompraLiquido + colorante.Quantidade * formula.FatorEstoque * colorante.PrecoCompraLiquido / colorante.Embalagem;

  fltIcmsSaida := fltIcmsSaida +
    colorante.Quantidade * formula.FatorEstoque * (colorante.IcmsSaida * colorante.PrecoVenda / 100) / colorante.Embalagem;

  fltImpostosFederais := fltImpostosFederais +
    colorante.Quantidade * formula.FatorEstoque * (colorante.ImpostosFederais * colorante.PrecoVenda / 100) / colorante.Embalagem;

  fltDespesasOperacionais := fltDespesasOperacionais +
    colorante.Quantidade * formula.FatorEstoque * (colorante.DespesasOperacionais * colorante.PrecoVenda / 100) / colorante.Embalagem;

  fltPrecoCusto := fltPrecoCusto + colorante.Quantidade * formula.FatorEstoque * colorante.PrecoCusto / colorante.Embalagem;
  fltPrecoCustoReal := fltPrecoCustoReal + colorante.Quantidade * formula.FatorEstoque * colorante.PrecoCustoReal / colorante.Embalagem;
  fltPrecoVenda := fltPrecoVenda + colorante.Quantidade * formula.FatorEstoque * colorante.PrecoVenda / colorante.Embalagem;

  if formula.Promoc = 'S' then
    strPromoc := 'S';
end;

procedure TCalculadorFormulaImobiliariaLuztol.CalcularComponente(
  const colorante: TColorante; const componente: ITintaDeMaquinaComponente);
begin
  componente.Quantidade                := colorante.Quantidade * formula.FatorEstoque;
  componente.PrecoCusto                := colorante.Quantidade * formula.FatorEstoque * colorante.PrecoCusto / colorante.Embalagem;
  componente.PrecoCustoReal            := colorante.Quantidade * formula.FatorEstoque * colorante.PrecoCustoReal / colorante.Embalagem;
  componente.PrecoVenda                := colorante.Quantidade * formula.FatorEstoque * colorante.PrecoVenda / colorante.Embalagem;
  componente.PrecoMedio                := colorante.Quantidade * formula.FatorEstoque * colorante.PrecoMedio / colorante.Embalagem;
  componente.OutrosValores             := colorante.Quantidade * formula.FatorEstoque * colorante.OutrosValores / colorante.Embalagem;
  componente.IcmsSaida                 := colorante.Quantidade * formula.FatorEstoque * (colorante.IcmsSaida * colorante.PrecoVenda / 100) / colorante.Embalagem;
  componente.ImpostosFederais          := colorante.Quantidade * formula.FatorEstoque * (colorante.ImpostosFederais * colorante.PrecoVenda / 100) / colorante.Embalagem;
  componente.DespesasOperacionais      := colorante.Quantidade * formula.FatorEstoque * (colorante.DespesasOperacionais * colorante.PrecoVenda / 100) / colorante.Embalagem;
  componente.UltimoPrecoCompra         := colorante.Quantidade * formula.FatorEstoque * colorante.UltimoPrecoCompra / colorante.Embalagem;
  componente.UltimoPrecoCompraImpostos := colorante.Quantidade * formula.FatorEstoque * colorante.UltimoPrecoCompraImpostos / colorante.Embalagem;
  componente.PrecoCompraLiquido        := colorante.Quantidade * formula.FatorEstoque * colorante.PrecoCompraLiquido / colorante.Embalagem;

  pAplicarAcrescimoPrecoVenda(componente, fltPerAcr);
end;

constructor TCalculadorFormulaImobiliariaLuztol.Create(
  const formula: TAbstractFormulaImobiliaria);
begin
  inherited Create(formula);
  Self.formula := formula;
  Self.tintaDeMaquina := formula.tintaDeMaquina;
  Self.fltPerAcr := TAutcomTintaFactory.Get().fGetConfTinta(formula.GetIdePro).fGetDouble('APREVE') / 100.0;
end;

procedure TCalculadorFormulaImobiliariaLuztol.pVerificacoesColorante(
  DataSetColorante: IDataSet; strCodCol: String);
begin
  If (Not DataSetColorante.Locate('COL_CODCOL', strCodCol, [])) Then
  Begin
    Zerar;
    Raise Exception.Create('Colorante ' + strCodCol + ' não cadastrado. Favor verificar.');
  End;

  If (TStrUtils.fEmptyStr(DataSetColorante.FieldByName('COL_CODITE').AsString)) Then
  Begin
    Zerar;
    Raise Exception.Create('Colorante ' + strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                         'Favor verificar.');
  End;

  If (DataSetColorante.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
  Begin
    Zerar;
    Raise Exception.Create('O produto ' + formula.ColorantesDataSet.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                         'preenchido corretamente. Favor verificar.');
  End;

  If (DataSetColorante.FieldByName('ITE_ITEATI').AsString = 'N') Then
  Begin
    Zerar;
    raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [DataSetColorante.FieldByName('COL_CODITE').AsString]);
  End;
end;

procedure TCalculadorFormulaImobiliariaLuztol.Zerar;
begin
  fltOutrosValores := 0;
  fltIcmsSaida := 0;
  fltImpostosFederais := 0;
  fltDespesasOperacionais := 0;
  fltPrecoMedio := 0;
  fltUltimoPrecoCompra := 0;
  fltUltimoPrecoCompraImpostos := 0;
  fltPrecoCompraLiquido := 0;
  fltPrecoCusto := 0;
  fltPrecoVenda := 0;
  fltPrecoCustoReal := 0;
end;

end.



