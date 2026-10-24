{************************************************************************************************}
{* Classe abstrata que implementa a interface ICalculadorFormulaAutomotiva responsável pelo     *}
{* calculo de preço dos componentes de uma tinta                                                *}
{* Houve a necessidade de tornar essa unit especifica para a color pro, por conta da quantidade *}
{* de processamento. Se ficasse especifica por conta dos calculos de porcentagem ficaria muito  *}
{* lento e desorganizado.                                                                       *}
{*********************************************************************************************AC*}
unit untAbstractCalculadorFormulaAutomotivaColorPro;

interface

uses
  untICalculadorFormulaAutomotiva, untBaseAutomotiva, untAbstractFormulaAutomotiva, SysUtils, Classes,
  untGenericTintaDeMaquina, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untAbstractFormula, untModoVenda, untIConfTinta, Math,
  Variants;

type
  TAbstractCalculadorFormulaAutomotivaColorPro = class abstract(TInterfacedObject, ICalculadorFormulaAutomotiva)
  protected
    fltQuantidadeCon: Double;
    fltQuantidadeDil: Double;

    fltOutrosValoresCon: Double;
    fltIcmsSaidaCon: Double;
    fltImpostosFederaisCon: Double;
    fltDespesasOperacionaisCon: Double;

    fltPrecoMedioCon: Double;
    fltUltimoPrecoCompraCon: Double;
    fltUltimoPrecoCompraImpostosCon: Double;
    fltPrecoCompraLiquidoCon: Double;

    fltPrecoCustoCon: Double;
    fltPrecoCustoRealCon: Double;
    fltPrecoVendaCon: Double;

    fltOutrosValoresDil: Double;
    fltIcmsSaidaDil: Double;
    fltImpostosFederaisDil: Double;
    fltDespesasOperacionaisDil: Double;

    fltPrecoMedioDil: Double;
    fltUltimoPrecoCompraDil: Double;
    fltUltimoPrecoCompraImpostosDil: Double;
    fltPrecoCompraLiquidoDil: Double;

    fltPrecoCustoDil: Double;
    fltPrecoCustoRealDil: Double;
    fltPrecoVendaDil: Double;


    strPromoc: String;

    formula: TAbstractFormulaAutomotiva;
    tintaDeMaquina: array[TModoVenda] of TGenericTintaDeMaquina;
    fltPerAcr: Double;
  protected

  public
    procedure Calcular; virtual;
    procedure Zerar; virtual;
  public
    constructor Create(const formula: TAbstractFormulaAutomotiva);

    function GetDespesasOperacionaisCon: Double;
    function GetIcmsSaidaCon: Double;
    function GetImpostosFederaisCon: Double;
    function GetOutrosValoresCon: Double;

    function GetPrecoMedioCon: Double;
    function GetUltimoPrecoCompraCon: Double;
    function GetUltimoPrecoCompraImpostosCon: Double;
    function GetPrecoCompraLiquidoCon: Double;

    function GetPrecoCustoCon: Double;
    function GetPrecoVendaCon: Double;
    function GetPrecoCustoRealCon: Double;

    function GetDespesasOperacionaisDil: Double;
    function GetIcmsSaidaDil: Double;
    function GetImpostosFederaisDil: Double;
    function GetOutrosValoresDil: Double;

    function GetPrecoMedioDil: Double;
    function GetUltimoPrecoCompraDil: Double;
    function GetUltimoPrecoCompraImpostosDil: Double;
    function GetPrecoCompraLiquidoDil: Double;

    function GetPrecoCustoDil: Double;
    function GetPrecoVendaDil: Double;
    function GetPrecoCustoRealDil: Double;

    function GetPromocao: String;
  end;

implementation

uses
  untStrUtils, untAutcomTintaFactory, untIDicionario,
  untTintaDeMaquinaComponenteComparerBaseAutomotiva;

{ TAbstractCalculadorFormulaAutomotivaColorPro }

procedure TAbstractCalculadorFormulaAutomotivaColorPro.Calcular;
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
      Zerar;
      Raise Exception.Create('Base ' + base.CodigoBase + ' não cadastrada. Favor verificar.');
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

    If (Copy(formula.CodFormul,1,3) = 'ESP') Or Not(Pos(TStrUtils.fStrZero(strLinha, 3), '004_001_014_013_011_027_008_058_009_006_') > 0) Then
    Begin
      fltQtdCon := Base.QuantidadeConcentrado;

      If bln4Por1 Then
        fltQtdDil := Base.QuantidadeDiluido2
      Else
        fltQtdDil := Base.QuantidadeDiluido;

      fltQtdCon := RoundTo(fltQtdCon / formula.VolumeOri * formula.VolumePro,-1);
      fltQtdDil := RoundTo(fltQtdDil / formula.VolumeOri * formula.VolumePro,-1);
    end
    else
    Begin
      If (Pos(TStrUtils.fStrZero(strLinha, 3), '004_001_014_') > 0) Then
      begin
        fltQtdCon := Formula.fCalculoA(Formula, 'CON', intIndex, strLinha);
        fltQtdDil := Formula.fCalculoA(Formula, 'DIL', intIndex, strLinha);
      end
      Else If (Pos(TStrUtils.fStrZero(strLinha, 3), '008_') > 0) Then
      begin
        fltQtdCon := Formula.fCalculoBLinha08(Formula, 'CON', intIndex);
        If bln4Por1 Then
          fltQtdDil := Formula.fCalculoBLinha08(Formula, 'DI2', intIndex)
        Else
          fltQtdDil := Formula.fCalculoBLinha08(Formula, 'DIL', intIndex);
      end
      Else If (Pos(TStrUtils.fStrZero(strLinha, 3), '058_013_') > 0) Then
      begin
        fltQtdCon := Formula.fCalculoB(Formula, 'CON', intIndex, strLinha);
        if bln4Por1 then
          fltQtdDil := Formula.fCalculoB(Formula, 'DI2', intIndex, strLinha)
        else
          fltQtdDil := Formula.fCalculoB(Formula, 'DIL', intIndex, strLinha);
      end
      Else If (Pos(TStrUtils.fStrZero(strLinha, 3), '011_') > 0) Then
      begin
        fltQtdCon := Formula.fCalculoC(Formula, intIndex);
        fltQtdDil := 0;
      end
      Else
      begin
        fltQtdCon := Formula.fCalculoA(Formula, 'CON', intIndex, strLinha);
        fltQtdDil := 0;
      end;
    end;

    componente[mvConcentrado].Quantidade                := fltQtdCon;
    componente[mvConcentrado].PrecoCusto                := (fltQtdCon * base.PrecoCusto) / base.Cnv_Ml;
    componente[mvConcentrado].PrecoCustoReal            := (fltQtdCon * base.PrecoCustoReal) / base.Cnv_Ml;
    componente[mvConcentrado].PrecoVenda                := (fltQtdCon * base.PrecoVenda) / base.Cnv_Ml;
    componente[mvConcentrado].PrecoMedio                := (fltQtdCon * base.PrecoMedio) / base.Cnv_Ml;
    componente[mvConcentrado].OutrosValores             := (fltQtdCon * base.OutrosValores) / base.Cnv_Ml;
    componente[mvConcentrado].IcmsSaida                 := ((fltQtdCon * base.PrecoVenda) / base.Cnv_Ml) * base.IcmsSaida / 100;
    componente[mvConcentrado].ImpostosFederais          := ((fltQtdCon * base.PrecoVenda) / base.Cnv_Ml) * base.ImpostosFederais / 100;
    componente[mvConcentrado].DespesasOperacionais      := ((fltQtdCon * base.PrecoVenda) / base.Cnv_Ml) * base.DespesasOperacionais / 100;
    componente[mvConcentrado].UltimoPrecoCompra         := (fltQtdCon * base.UltimoPrecoCompra) / base.Cnv_Ml;
    componente[mvConcentrado].UltimoPrecoCompraImpostos := (fltQtdCon * base.UltimoPrecoCompraImpostos) / base.Cnv_Ml;
    componente[mvConcentrado].PrecoCompraLiquido        := (fltQtdCon * base.PrecoCompraLiquido) / base.Cnv_Ml;
    componente[mvConcentrado].PrecoVenda                := componente[mvConcentrado].PrecoVenda + (fltPerAcr * componente[mvConcentrado].PrecoVenda);

    componente[mvDiluido].Quantidade                    := fltQtdDil;
    componente[mvDiluido].PrecoCusto                    := (fltQtdDil * base.PrecoCusto) / base.Cnv_Ml;
    componente[mvDiluido].PrecoCustoReal                := (fltQtdDil * base.PrecoCustoReal) / base.Cnv_Ml;
    componente[mvDiluido].PrecoVenda                    := (fltQtdDil * base.PrecoVenda) / base.Cnv_Ml;
    componente[mvDiluido].PrecoMedio                    := (fltQtdDil * base.PrecoMedio) / base.Cnv_Ml;
    componente[mvDiluido].OutrosValores                 := (fltQtdDil * base.OutrosValores) / base.Cnv_Ml;
    componente[mvDiluido].IcmsSaida                     := ((fltQtdDil * base.PrecoVenda) / base.Cnv_Ml) * base.IcmsSaida / 100;
    componente[mvDiluido].ImpostosFederais              := ((fltQtdDil * base.PrecoVenda) / base.Cnv_Ml) * base.ImpostosFederais / 100;
    componente[mvDiluido].DespesasOperacionais          := ((fltQtdDil * base.PrecoVenda) / base.Cnv_Ml) * base.DespesasOperacionais / 100;
    componente[mvDiluido].UltimoPrecoCompra             := (fltQtdDil * base.UltimoPrecoCompra) / base.Cnv_Ml;
    componente[mvDiluido].UltimoPrecoCompraImpostos     := (fltQtdDil * base.UltimoPrecoCompraImpostos) / base.Cnv_Ml;
    componente[mvDiluido].PrecoCompraLiquido            := (fltQtdDil * base.PrecoCompraLiquido) / base.Cnv_Ml;
    componente[mvDiluido].PrecoVenda                    := componente[mvDiluido].PrecoVenda + (fltPerAcr * componente[mvDiluido].PrecoVenda);
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

  If fltPrecoVendaCon > 0 Then
    fltPrecoVendaCon              := fltPrecoVendaCon + formula.AcrMob;

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

  If fltPrecoVendaDil > 0 Then
    fltPrecoVendaDil              := fltPrecoVendaDil + formula.AcrMob;
end;

constructor TAbstractCalculadorFormulaAutomotivaColorPro.Create(const formula: TAbstractFormulaAutomotiva);
begin
  inherited Create();
  Self.formula := formula;
  Self.tintaDeMaquina[mvConcentrado] := formula.tintaDeMaquina[mvConcentrado];
  Self.tintaDeMaquina[mvDiluido]     := formula.tintaDeMaquina[mvDiluido];
  Self.fltPerAcr                     := TAutcomTintaFactory.Get().fGetConfTinta(formula.GetIdePro).fGetDouble('APREVE') / 100.0;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetDespesasOperacionaisCon: Double;
begin
  Result := fltDespesasOperacionaisCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetDespesasOperacionaisDil: Double;
begin
  Result := fltDespesasOperacionaisDil;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetIcmsSaidaCon: Double;
begin
  Result := fltIcmsSaidaCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetIcmsSaidaDil: Double;
begin
  Result := fltIcmsSaidaDil;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetImpostosFederaisCon: Double;
begin
  Result := fltImpostosFederaisCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetImpostosFederaisDil: Double;
begin
  Result := fltImpostosFederaisDil;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetOutrosValoresCon: Double;
begin
  Result := fltOutrosValoresCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetOutrosValoresDil: Double;
begin
  Result := fltOutrosValoresDil;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoCompraLiquidoCon: Double;
begin
  Result := fltPrecoCompraLiquidoCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoCompraLiquidoDil: Double;
begin
  Result := fltPrecoCompraLiquidoDil;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoCustoCon: Double;
begin
  Result := fltPrecoCustoCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoCustoDil: Double;
begin
  Result := fltPrecoCustoDil;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoCustoRealCon: Double;
begin
  Result := fltPrecoCustoRealCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoCustoRealDil: Double;
begin
  Result := fltPrecoCustoRealDil;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoMedioCon: Double;
begin
  Result := fltPrecoMedioCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoMedioDil: Double;
begin
  Result := fltPrecoMedioDil;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoVendaCon: Double;
begin
  Result := fltPrecoVendaCon; // + (fltPerAcr * fltPrecoVendaCon);
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPrecoVendaDil: Double;
begin
  Result := fltPrecoVendaDil; // + (fltPerAcr * fltPrecoVendaDil);
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetPromocao: String;
begin
  Result := strPromoc;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetUltimoPrecoCompraCon: Double;
begin
  Result := fltUltimoPrecoCompraCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetUltimoPrecoCompraDil: Double;
begin
  Result := fltUltimoPrecoCompraDil
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetUltimoPrecoCompraImpostosCon: Double;
begin
  Result := fltUltimoPrecoCompraImpostosCon;
end;

function TAbstractCalculadorFormulaAutomotivaColorPro.GetUltimoPrecoCompraImpostosDil: Double;
begin
  Result := fltUltimoPrecoCompraImpostosDil;
end;

procedure TAbstractCalculadorFormulaAutomotivaColorPro.Zerar;
begin
  fltOutrosValoresCon             := 0;
  fltIcmsSaidaCon                 := 0;
  fltImpostosFederaisCon          := 0;
  fltDespesasOperacionaisCon      := 0;
  fltPrecoMedioCon                := 0;
  fltUltimoPrecoCompraCon         := 0;
  fltUltimoPrecoCompraImpostosCon := 0;
  fltPrecoCompraLiquidoCon        := 0;
  fltPrecoCustoCon                := 0;
  fltPrecoVendaCon                := 0;

  fltOutrosValoresDil             := 0;
  fltIcmsSaidaDil                 := 0;
  fltImpostosFederaisDil          := 0;
  fltDespesasOperacionaisDil      := 0;
  fltPrecoMedioDil                := 0;
  fltUltimoPrecoCompraDil         := 0;
  fltUltimoPrecoCompraImpostosDil := 0;
  fltPrecoCompraLiquidoDil        := 0;
  fltPrecoCustoDil                := 0;
  fltPrecoVendaDil                := 0;
end;

end.
