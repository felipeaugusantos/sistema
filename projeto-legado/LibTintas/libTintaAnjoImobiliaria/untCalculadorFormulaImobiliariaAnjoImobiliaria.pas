unit untCalculadorFormulaImobiliariaAnjoImobiliaria;

interface

uses
  untICalculadorFormulaImobiliaria, untColorante, untAbstractFormulaImobiliaria, SysUtils, Classes,
  untGenericTintaDeMaquina, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untAbstractFormula, untAbstractCalculadorFormulaImobiliaria;

type
  TCalculadorFormulaImobiliariaAnjoImobiliaria = class(TAbstractCalculadorFormulaImobiliaria)
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

procedure TCalculadorFormulaImobiliariaAnjoImobiliaria.CalcularColorante(const colorante: TColorante);
begin
  fltOutrosValores             := fltOutrosValores             + colorante.Quantidade * colorante.OutrosValores             / colorante.Embalagem;
  fltPrecoMedio                := fltPrecoMedio                + colorante.Quantidade * colorante.PrecoMedio                / colorante.Embalagem;
  fltUltimoPrecoCompra         := fltUltimoPrecoCompra         + colorante.Quantidade * colorante.UltimoPrecoCompra         / colorante.Embalagem;
  fltUltimoPrecoCompraImpostos := fltUltimoPrecoCompraImpostos + colorante.Quantidade * colorante.UltimoPrecoCompraImpostos / colorante.Embalagem;
  fltPrecoCompraLiquido        := fltPrecoCompraLiquido        + colorante.Quantidade * colorante.PrecoCompraLiquido        / colorante.Embalagem;

  fltIcmsSaida                 := fltIcmsSaida            + colorante.Quantidade * (colorante.IcmsSaida            * colorante.PrecoVenda / 100) / colorante.Embalagem;
  fltImpostosFederais          := fltImpostosFederais     + colorante.Quantidade * (colorante.ImpostosFederais     * colorante.PrecoVenda / 100) / colorante.Embalagem;
  fltDespesasOperacionais      := fltDespesasOperacionais + colorante.Quantidade * (colorante.DespesasOperacionais * colorante.PrecoVenda / 100) / colorante.Embalagem;

  fltPrecoCusto     := fltPrecoCusto     + (colorante.Quantidade / colorante.PesoEspecifico) * (colorante.PrecoCusto     / colorante.Embalagem);
  fltPrecoCustoReal := fltPrecoCustoReal + (colorante.Quantidade / colorante.PesoEspecifico) * (colorante.PrecoCustoReal / colorante.Embalagem);
  fltPrecoVenda     := fltPrecoVenda     + (colorante.Quantidade / colorante.PesoEspecifico) * (colorante.PrecoVenda     / colorante.Embalagem);

  if formula.Promoc = 'S' then
    strPromoc := 'S';
end;

procedure TCalculadorFormulaImobiliariaAnjoImobiliaria.CalcularComponente(
  const colorante: TColorante; const componente: ITintaDeMaquinaComponente);
begin
  componente.Quantidade                := colorante.Quantidade;
  componente.PrecoCusto                := (colorante.Quantidade / colorante.PesoEspecifico) * (colorante.PrecoCusto     / colorante.Embalagem);
  componente.PrecoCustoReal            := (colorante.Quantidade / colorante.PesoEspecifico) * (colorante.PrecoCustoReal / colorante.Embalagem);
  componente.PrecoVenda                := (colorante.Quantidade / colorante.PesoEspecifico) * (colorante.PrecoVenda     / colorante.Embalagem);
  componente.PrecoMedio                := colorante.Quantidade * colorante.PrecoMedio    / colorante.Embalagem;
  componente.OutrosValores             := colorante.Quantidade * colorante.OutrosValores / colorante.Embalagem;
  componente.IcmsSaida                 := colorante.Quantidade * (colorante.IcmsSaida            * colorante.PrecoVenda / 100) / colorante.Embalagem;
  componente.ImpostosFederais          := colorante.Quantidade * (colorante.ImpostosFederais     * colorante.PrecoVenda / 100) / colorante.Embalagem;
  componente.DespesasOperacionais      := colorante.Quantidade * (colorante.DespesasOperacionais * colorante.PrecoVenda / 100) / colorante.Embalagem;
  componente.UltimoPrecoCompra         := colorante.Quantidade * colorante.UltimoPrecoCompra         / colorante.Embalagem;
  componente.UltimoPrecoCompraImpostos := colorante.Quantidade * colorante.UltimoPrecoCompraImpostos / colorante.Embalagem;
  componente.PrecoCompraLiquido        := colorante.Quantidade * colorante.PrecoCompraLiquido        / colorante.Embalagem;

  componente.PrecoVenda                := componente.PrecoVenda + (fltPerAcr * componente.PrecoVenda);
end;

constructor TCalculadorFormulaImobiliariaAnjoImobiliaria.Create(const formula: TAbstractFormulaImobiliaria);
begin
  inherited Create(formula);
end;

end.
