unit untCalculadorFormulaAutomotivaColorPro;

interface

uses untBaseAutomotiva, untAbstractFormulaAutomotiva, SysUtils, Classes,
  untGenericTintaDeMaquina, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untAbstractFormula, untModoVenda, untIConfTinta, Math,
  Variants, untAbstractCalculadorFormulaAutomotiva;

type
  TCalculadorFormulaAutomotivaColorPro = class(TAbstractCalculadorFormulaAutomotiva)
  protected

  public
    procedure Calcular; override;
    constructor Create(const formula: TAbstractFormulaAutomotiva);
  end;

implementation

uses
  untStrUtils, untAutcomTintaFactory, untIDicionario,
  untTintaDeMaquinaComponenteComparerBaseAutomotiva;

{ TCalculadorFormulaAutomotivaColorPro }

procedure TCalculadorFormulaAutomotivaColorPro.Calcular;
var
  base: TBaseAutomotiva;
  intIndex: Integer;
  dicDados: IDicionario;
  componente: array[TModoVenda] of ITintaDeMaquinaComponente;
  bln4Por1: Boolean;

  fltQtdCon: Double;
  fltQtdDil: Double;

  strLinha: String;
begin
  Zerar;

  tintaDeMaquina[mvConcentrado].Limpar;
  tintaDeMaquina[mvDiluido].Limpar;

  formula.pDefineVolumeOriginal;
  bln4Por1 := formula.fDefine4Por1;

  base := TBaseAutomotiva(formula.Items[0]);
  strLinha := base.LinhaBase;

  For intIndex := 0 To formula.Count -1 Do
  Begin
    base := TBaseAutomotiva(formula.Items[intIndex]);

    If (not formula.ComCatalisador) And (base.TipoBase = 'C') Then
    begin
      componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(Base.CodigoBase));
      if Assigned(componente[mvConcentrado]) then
      begin
        tintaDeMaquina[mvConcentrado].Remover(componente[mvConcentrado]);
      end;

      componente[mvDiluido] := tintaDeMaquina[mvDiluido].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(Base.CodigoBase));
      if Assigned(componente[mvDiluido]) then
      begin
        tintaDeMaquina[mvDiluido].Remover(componente[mvDiluido]);
      end;

      Continue;
    end;

    If ( formula.mveModoVenda = mvConcentrado) And (Base.TipoBase = 'D') Then
    Begin
      Continue;
    End;

    If (Not formula.BasesDataSet.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Base.CodigoBase, Base.LinhaBase]), [])) Then
    Begin
      If (formula.mveModoVenda = mvConcentrado) And (base.QuantidadeConcentrado > 0)  Then
      Begin
        Zerar;
        Raise Exception.Create('Base ' + base.CodigoBase + ' não cadastrada. Favor verificar.');
      End
      Else
      If (formula.mveModoVenda = mvDiluido) And (base.QuantidadeDiluido > 0)  Then
      Begin
        Zerar;
        Raise Exception.Create('Base ' + base.CodigoBase + ' não cadastrada. Favor verificar.');
      End
      Else
        Continue;
    End;

    If (TStrUtils.fEmptyStr(formula.BasesDataSet.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      Zerar;
      Raise Exception.Create('Base ' + base.CodigoBase + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
    End;

    If (formula.BasesDataSet.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      Zerar;
      Raise Exception.Create('O produto ' + formula.BasesDataSet.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
    End;

    If (formula.BasesDataSet.FieldByName('ITE_ITEATI').AsString = 'N') Then
    begin
      Zerar;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [formula.BasesDataSet.FieldByName('BAS_CODITE').AsString]);
    end;

    componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(Base.CodigoBase));
    if not Assigned(componente[mvConcentrado]) then
    begin
      componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        formula.BasesDataSet.FieldByName('BAS_CODITE').AsString, base.CodigoBase, tmctBaseAutomotiva
      ));
    end;

    componente[mvDiluido] := tintaDeMaquina[mvDiluido].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(Base.CodigoBase));
    if not Assigned(componente[mvDiluido]) then
    begin
      componente[mvDiluido] := tintaDeMaquina[mvDiluido].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        formula.BasesDataSet.FieldByName('BAS_CODITE').AsString, base.CodigoBase,  tmctBaseAutomotiva
      ));
    end;

    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := base.PrecoVenda;
    dicDados['precus'] := base.PrecoCusto;
    dicDados['outval'] := base.OutrosValores;
    dicDados['icmsai'] := base.IcmsSaida;
    dicDados['impfed'] := base.ImpostosFederais;
    dicDados['desope'] := base.DespesasOperacionais;

    base.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);

    fltQtdCon := Base.QuantidadeConcentrado;

    If bln4Por1 Then
      fltQtdDil := Base.QuantidadeDiluido2
    Else
      fltQtdDil := Base.QuantidadeDiluido;

    fltQtdCon := RoundTo(fltQtdCon / formula.VolumeOri * formula.VolumePro,-1);
    fltQtdDil := RoundTo(fltQtdDil / formula.VolumeOri * formula.VolumePro,-1);

    componente[mvConcentrado].Quantidade                := fltQtdCon;
    componente[mvDiluido].Quantidade                    := fltQtdDil;

    componente[mvConcentrado].PrecoCusto                := ((fltQtdCon * base.PrecoCusto) / base.Cnv_Ml);
    componente[mvConcentrado].PrecoCustoReal            := ((fltQtdCon * base.PrecoCustoReal) / base.Cnv_Ml);
    componente[mvConcentrado].PrecoVenda                := ((fltQtdCon * base.PrecoVenda) / base.Cnv_Ml);
    componente[mvConcentrado].PrecoMedio                := ((fltQtdCon * base.PrecoMedio) / base.Cnv_Ml);
    componente[mvConcentrado].OutrosValores             := ((fltQtdCon * base.OutrosValores) / base.Cnv_Ml);
    componente[mvConcentrado].IcmsSaida                 := (((fltQtdCon * base.PrecoVenda) / base.Cnv_Ml) * base.IcmsSaida / 100);
    componente[mvConcentrado].ImpostosFederais          := (((fltQtdCon * base.PrecoVenda) / base.Cnv_Ml) * base.ImpostosFederais / 100);
    componente[mvConcentrado].DespesasOperacionais      := (((fltQtdCon * base.PrecoVenda) / base.Cnv_Ml) * base.DespesasOperacionais / 100);
    componente[mvConcentrado].UltimoPrecoCompra         := ((fltQtdCon * base.UltimoPrecoCompra) / base.Cnv_Ml);
    componente[mvConcentrado].UltimoPrecoCompraImpostos := ((fltQtdCon * base.UltimoPrecoCompraImpostos) / base.Cnv_Ml);
    componente[mvConcentrado].PrecoCompraLiquido        := ((fltQtdCon * base.PrecoCompraLiquido) / base.Cnv_Ml);

    componente[mvDiluido].PrecoCusto                    := ((fltQtdDil * base.PrecoCusto) / base.Cnv_Ml);
    componente[mvDiluido].PrecoCustoReal                := ((fltQtdDil * base.PrecoCustoReal) / base.Cnv_Ml);
    componente[mvDiluido].PrecoVenda                    := ((fltQtdDil * base.PrecoVenda) / base.Cnv_Ml);
    componente[mvDiluido].PrecoMedio                    := ((fltQtdDil * base.PrecoMedio) / base.Cnv_Ml);
    componente[mvDiluido].OutrosValores                 := ((fltQtdDil * base.OutrosValores) / base.Cnv_Ml);
    componente[mvDiluido].IcmsSaida                     := (((fltQtdDil * base.PrecoVenda) / base.Cnv_Ml) * base.IcmsSaida / 100);
    componente[mvDiluido].ImpostosFederais              := (((fltQtdDil * base.PrecoVenda) / base.Cnv_Ml) * base.ImpostosFederais / 100);
    componente[mvDiluido].DespesasOperacionais          := (((fltQtdDil * base.PrecoVenda) / base.Cnv_Ml) * base.DespesasOperacionais / 100);
    componente[mvDiluido].UltimoPrecoCompra             := ((fltQtdDil * base.UltimoPrecoCompra) / base.Cnv_Ml);
    componente[mvDiluido].UltimoPrecoCompraImpostos     := ((fltQtdDil * base.UltimoPrecoCompraImpostos) / base.Cnv_Ml);
    componente[mvDiluido].PrecoCompraLiquido            := ((fltQtdDil * base.PrecoCompraLiquido) / base.Cnv_Ml);

    pAplicarAcrescimoPrecoVenda(componente[mvConcentrado], fltPerAcr);
    pAplicarAcrescimoPrecoVenda(componente[mvDiluido]    , fltPerAcr);
  End;

  fltOutrosValoresCon             := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  fltPrecoMedioCon                := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  fltUltimoPrecoCompraCon         := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
  fltUltimoPrecoCompraImpostosCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
  fltPrecoCompraLiquidoCon        := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
  fltIcmsSaidaCon                 := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  fltImpostosFederaisCon          := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  fltDespesasOperacionaisCon      := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  fltPrecoCustoCon                := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  fltPrecoCustoRealCon            := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  fltPrecoVendaCon                := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;

  fltOutrosValoresDil             := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;
  fltPrecoMedioDil                := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;
  fltUltimoPrecoCompraDil         := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes;
  fltUltimoPrecoCompraImpostosDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes;
  fltPrecoCompraLiquidoDil        := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes;
  fltIcmsSaidaDil                 := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;
  fltImpostosFederaisDil          := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;
  fltDespesasOperacionaisDil      := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;
  fltPrecoCustoDil                := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;
  fltPrecoCustoRealDil            := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;
  fltPrecoVendaDil                := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;
end;

constructor TCalculadorFormulaAutomotivaColorPro.Create(
  const formula: TAbstractFormulaAutomotiva);
begin
  inherited Create(formula);
end;

end.

