unit untCalculadorFormulaImobiliariaBrasimixImobiliaria;

interface

uses
  untICalculadorFormulaImobiliaria, untColorante, untAbstractFormulaImobiliaria, SysUtils, Classes,
  untGenericTintaDeMaquina, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untAbstractFormula, untAbstractCalculadorFormulaImobiliaria;

type
  TCalculadorFormulaImobiliariaBrasimixImobiliaria = class(TAbstractCalculadorFormulaImobiliaria)
  protected
    procedure CalcularColorante(const colorante: TColorante); override;
    procedure CalcularComponente(const colorante: TColorante; const componente: ITintaDeMaquinaComponente); override;
  public
    constructor Create(const formula: TAbstractFormulaImobiliaria);
  end;

implementation

uses
  untStrUtils, untAutcomTintaFactory, untIDicionario,
  untTintaDeMaquinaComponenteComparerColorante;

{ TAbstractCalculadorFormulaImobiliaria }

procedure TCalculadorFormulaImobiliariaBrasimixImobiliaria.CalcularColorante(const colorante: TColorante);
  Var
    fltQtdLoc: Double;
    fltPesEsp: Double;
begin
  fltPesEsp := colorante.PesoEspecifico;
  If (fltPesEsp = 0) Then
    fltPesEsp := 1;

  fltQtdLoc := (colorante.Quantidade / fltPesEsp);

  fltOutrosValores             := fltOutrosValores             + (fltQtdLoc * (colorante.OutrosValores             / colorante.Embalagem));
  fltPrecoMedio                := fltPrecoMedio                + (fltQtdLoc * (colorante.PrecoMedio                / colorante.Embalagem));
  fltUltimoPrecoCompra         := fltUltimoPrecoCompra         + (fltQtdLoc * (colorante.UltimoPrecoCompra         / colorante.Embalagem));
  fltUltimoPrecoCompraImpostos := fltUltimoPrecoCompraImpostos + (fltQtdLoc * (colorante.UltimoPrecoCompraImpostos / colorante.Embalagem));
  fltPrecoCompraLiquido        := fltPrecoCompraLiquido        + (fltQtdLoc * (colorante.PrecoCompraLiquido        / colorante.Embalagem));

  fltIcmsSaida                 := fltIcmsSaida            + (fltQtdLoc * ((colorante.IcmsSaida            * colorante.PrecoVenda / 100) / colorante.Embalagem));
  fltImpostosFederais          := fltImpostosFederais     + (fltQtdLoc * ((colorante.ImpostosFederais     * colorante.PrecoVenda / 100) / colorante.Embalagem));
  fltDespesasOperacionais      := fltDespesasOperacionais + (fltQtdLoc * ((colorante.DespesasOperacionais * colorante.PrecoVenda / 100) / colorante.Embalagem));

  fltPrecoCusto     := fltPrecoCusto     + (fltQtdLoc * (colorante.PrecoCusto     / colorante.Embalagem));
  fltPrecoCustoReal := fltPrecoCustoReal + (fltQtdLoc * (colorante.PrecoCustoReal / colorante.Embalagem));
  fltPrecoVenda     := fltPrecoVenda     + (fltQtdLoc * (colorante.PrecoVenda     / colorante.Embalagem));

  if formula.Promoc = 'S' then
    strPromoc := 'S';
end;

procedure TCalculadorFormulaImobiliariaBrasimixImobiliaria.CalcularComponente(
  const colorante: TColorante; const componente: ITintaDeMaquinaComponente);
  Var
    fltQtdLoc: Double;
    fltPesEsp: Double;
begin
  fltPesEsp := colorante.PesoEspecifico;
  If (fltPesEsp = 0) Then
    fltPesEsp := 1;

  fltQtdLoc := (colorante.Quantidade / fltPesEsp);

  componente.Quantidade                := colorante.Quantidade;
  componente.PrecoCusto                := fltQtdLoc * (colorante.PrecoCusto     / colorante.Embalagem);
  componente.PrecoCustoReal            := fltQtdLoc * (colorante.PrecoCustoReal / colorante.Embalagem);
  componente.PrecoVenda                := fltQtdLoc * (colorante.PrecoVenda     / colorante.Embalagem);
  componente.PrecoMedio                := fltQtdLoc * (colorante.PrecoMedio     / colorante.Embalagem);
  componente.OutrosValores             := fltQtdLoc * (colorante.OutrosValores  / colorante.Embalagem);
  componente.IcmsSaida                 := fltQtdLoc * ((colorante.IcmsSaida            * colorante.PrecoVenda / 100) / colorante.Embalagem);
  componente.ImpostosFederais          := fltQtdLoc * ((colorante.ImpostosFederais     * colorante.PrecoVenda / 100) / colorante.Embalagem);
  componente.DespesasOperacionais      := fltQtdLoc * ((colorante.DespesasOperacionais * colorante.PrecoVenda / 100) / colorante.Embalagem);
  componente.UltimoPrecoCompra         := fltQtdLoc * (colorante.UltimoPrecoCompra         / colorante.Embalagem);
  componente.UltimoPrecoCompraImpostos := fltQtdLoc * (colorante.UltimoPrecoCompraImpostos / colorante.Embalagem);
  componente.PrecoCompraLiquido        := fltQtdLoc * (colorante.PrecoCompraLiquido        / colorante.Embalagem);

  pAplicarAcrescimoPrecoVenda(componente, fltPerAcr);
end;

constructor TCalculadorFormulaImobiliariaBrasimixImobiliaria.Create(const formula: TAbstractFormulaImobiliaria);
begin
  inherited Create(formula);
end;

end.
