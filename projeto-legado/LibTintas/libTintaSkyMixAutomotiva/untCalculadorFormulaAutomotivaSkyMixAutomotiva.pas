unit untCalculadorFormulaAutomotivaSkyMixAutomotiva;

interface

uses untBaseAutomotiva, untAbstractFormulaAutomotiva, SysUtils, Classes,
  untGenericTintaDeMaquina, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untAbstractFormula, untModoVenda, untIConfTinta, Math,
  Variants, untAbstractCalculadorFormulaAutomotiva;

type
  TCalculadorFormulaAutomotivaSkyMixAutomotiva = class(TAbstractCalculadorFormulaAutomotiva)
  protected

  public
    procedure Calcular; override;
    constructor Create(const formula: TAbstractFormulaAutomotiva);
  end;

implementation

uses
  untStrUtils, untAutcomTintaFactory, untIDicionario,
  untTintaDeMaquinaComponenteComparerBaseAutomotiva;

{ TCalculadorFormulaAutomotivasSkyMixAutomotiva }

procedure TCalculadorFormulaAutomotivaSkyMixAutomotiva.Calcular;
var
  base: TBaseAutomotiva;
  intIndex: Integer;
  dicDados: IDicionario;
  componente: array[TModoVenda] of ITintaDeMaquinaComponente;


  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala   : Double;
  fltCusBasDil: Double;
  fltCusBasCon: Double;
  fltCu2BasDil: Double;
  fltCu2BasCon: Double;
  fltVenBasDil: Double;
  fltVenBasCon: Double;
  fltPorMVA: Double;
  fltPorIPI: Double;
  fltPorICMS: Double;
  fltFatMl: Double;
  fltFatMlCon: Double;
  fltFator: Double;
  fltFatorCon: Double;
  fltVIcmsVen: Double;
  fltVIcmsCus: Double;
  fltVIcmsCu2: Double;
  fltVIPICus: Double;
  fltVIPICu2: Double;
  fltVIPIVen: Double;
  fltVMVACus: Double;
  fltVMVACu2: Double;
  fltVMVAVen: Double;
  fltVMVAIcmsCus: Double;
  fltVMVAIcmsCu2: Double;
  fltVMVAIcmsVen: Double;
  fltDifIcmsCus: Double;
  fltDifIcmsCu2: Double;
  fltDifIcmsVen: Double;
  fltValorTintaCus: Double;
  fltValorTintaCu2: Double;
  fltValorTintaVen: Double;
  conf: IConfTinta;
  fltQtdMlCon: Double;
  fltQtdMlDil: Double;
  fltPreCusItem: Double;
  fltPreVenItem: Double;
  fltPreCusPro: Double;
  fltPreVenPro: Double;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  Conf := TAutcomTintaFactory.Get.fGetConfTinta('SKY');
  Zerar;

  fltPorMVA := Conf.fGetDouble('SKYMVA') / 100;

  If Formula.VolumePro <= 0.0 Then
    Formula.VolumePro := 1;

  tintaDeMaquina[mvConcentrado].Limpar;
  tintaDeMaquina[mvDiluido].Limpar;

  formula.pDefineVolumeOriginal;

  For intIndex := 0 To formula.Count -1 Do
  Begin
    base := TBaseAutomotiva(formula.Items[intIndex]);

    If ( formula.mveModoVenda = mvConcentrado) And (Base.TipoBase = 'D') Then
    Begin
      Continue;
    End;

    If (Not formula.BasesDataSet.Locate('BAS_CODBAS;', VarArrayOf([Base.CodigoBase]), [])) Then
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

    If (formula.BasesDataSet.FieldByName('BAS_PESESP').AsFloat <= 0) Then
    Begin
      Zerar;
      Raise Exception.Create('A base ' + Base.CodigoBase + ' está com o Peso Específico zerado.' + #13#10 + 'Favor Verificar.');
    End;

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

    componente[mvConcentrado].Quantidade                := Base.QuantidadeConcentrado * Formula.VolumePro / Formula.VolumeOri;
    componente[mvDiluido].Quantidade                    := Base.QuantidadeDiluido * Formula.VolumePro / Formula.VolumeOri;

    If TAutcomTintaFactory.Get.fCarregaPromocao(Formula.BasesDataSet.FieldByName('BAS_CODITE').AsString, Formula.TabPre, Formula.CodCli, Formula.CodCnd,
      Formula.PrzMed, fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria) Then
    Begin
      fltPreCusItem := fltPreCusPro;
      fltPreVenItem := fltPreVenPro;
      strPromoc := 'S';

      If fltPreCusItem <= 0 Then
        fltPreCusItem := Formula.BasesDataSet.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusItem := Formula.BasesDataSet.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenItem := Formula.BasesDataSet.FieldByName('ITE_PREVEN').AsFloat;
    End;


    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := base.PrecoVenda;
    dicDados['precus'] := base.PrecoCusto;
    dicDados['outval'] := base.OutrosValores;
    dicDados['icmsai'] := base.IcmsSaida;
    dicDados['impfed'] := base.ImpostosFederais;
    dicDados['desope'] := base.DespesasOperacionais;

    fltPreCu2Bas := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);

    fltPreCusBas := fltPreCusItem;
    fltPreVenBas := fltPreVenItem;
    fltEmbala := Formula.BasesDataSet.FieldByName('BAS_EMBALA').AsFloat;
    fltPorICMS := Formula.BasesDataSet.FieldByName('ITE_ICMSAI').AsFloat / 100;
    fltPorIPI := Formula.BasesDataSet.FieldByName('ITE_IPISAI').AsFloat / 100;

    fltFatMl := Base.QuantidadeDiluido / Base.PesoEspecifico;
    fltFatMlCon := Base.QuantidadeConcentrado / Base.PesoEspecifico;

    fltFator := fltFatMl / fltEmbala;
    fltFatorCon := fltFatMlCon / fltEmbala;

    fltVIcmsCus := fltPreCusBas * fltPorICMS;
    fltVIcmsCu2 := fltPreCu2Bas * fltPorICMS;
    fltVIcmsVen := TAutcomTintaFactory.Get.fFormataFloat(fltPreVenBas, 4) * TAutcomTintaFactory.Get.fFormataFloat(fltPorICMS, 4);

    fltVIPICus := fltPreCusBas * fltPorIPI;
    fltVIPICus := fltVIPICus + fltPreCusBas;
    fltVIPICu2 := fltPreCu2Bas * fltPorIPI;
    fltVIPICu2 := fltVIPICu2 + fltPreCu2Bas;
    fltVIPIVen := fltPreVenBas * fltPorIPI;
    fltVIPIVen := fltVIPIVen + fltPreVenBas;

    fltVMVACus := fltVIPICus * fltPorMVA;
    fltVMVACus := fltVMVACus + fltVIPICus;
    fltVMVACu2 := fltVIPICu2 * fltPorMVA;
    fltVMVACu2 := fltVMVACu2 + fltVIPICu2;
    fltVMVAVen := fltVIPIVen * fltPorMVA;
    fltVMVAVen := fltVMVAVen + fltVIPIVen;

    fltVMVAIcmsCus := fltVMVACus * fltPorICMS;
    fltVMVAIcmsCu2 := fltVMVACu2 * fltPorICMS;
    fltVMVAIcmsVen := fltVMVAVen * fltPorICMS;

    fltDifIcmsCus := fltVMVAIcmsCus - fltVIcmsCus;
    fltDifIcmsCu2 := fltVMVAIcmsCu2 - fltVIcmsCu2;
    fltDifIcmsVen := fltVMVAIcmsVen - fltVIcmsVen;

    fltValorTintaCus := fltVIPICus + fltDifIcmsCus;
    fltValorTintaCu2 := fltVIPICu2 + fltDifIcmsCu2;
    fltValorTintaven := fltVIPIVen + fltDifIcmsVen;

    fltCusBasDil := fltValorTintaCus * fltFator * Formula.VolumePro / Formula.VolumeOri;
    fltCu2BasDil := fltValorTintaCu2 * fltFator * Formula.VolumePro / Formula.VolumeOri;

    fltCusBasCon := fltValorTintaCus * fltFatorCon * Formula.VolumePro / Formula.VolumeOri;
    fltCu2BasCon := fltValorTintaCu2 * fltFatorCon * Formula.VolumePro / Formula.VolumeOri;

    fltVenBasDil := fltValorTintaVen * fltFator * Formula.VolumePro / Formula.VolumeOri;
    fltVenBasCon := fltValorTintaVen * fltFatorCon * Formula.VolumePro / Formula.VolumeOri;

    componente[mvConcentrado].IcmsSaida := (fltVenBasCon * Base.IcmsSaida / 100);
    componente[mvDiluido].IcmsSaida := (fltVenBasDil * Base.IcmsSaida / 100);

    componente[mvConcentrado].ImpostosFederais := (fltVenBasCon * Base.ImpostosFederais / 100);
    componente[mvDiluido].ImpostosFederais := (fltVenBasDil * Base.ImpostosFederais / 100);

    componente[mvConcentrado].DespesasOperacionais := (fltVenBasCon * Base.DespesasOperacionais / 100);
    componente[mvDiluido].DespesasOperacionais := (fltVenBasDil * Base.DespesasOperacionais / 100);

    componente[mvConcentrado].OutrosValores := (Base.OutrosValores * fltFatorCon * Formula.VolumePro / Formula.VolumeOri);
    componente[mvDiluido].OutrosValores := (Base.OutrosValores * fltFator *  Formula.VolumePro / Formula.VolumeOri);

    componente[mvConcentrado].PrecoMedio := (Base.PrecoMedio * fltFatorCon * Formula.VolumePro / Formula.VolumeOri);
    componente[mvDiluido].PrecoMedio := (Base.PrecoMedio * fltFator * Formula.VolumePro / Formula.VolumeOri);

    componente[mvConcentrado].UltimoPrecoCompra := (Base.UltimoPrecoCompra * fltFatorCon * Formula.VolumePro / Formula.VolumeOri);
    componente[mvDiluido].UltimoPrecoCompra := (Base.UltimoPrecoCompra * fltFator * Formula.VolumePro / Formula.VolumeOri);

    componente[mvConcentrado].UltimoPrecoCompraImpostos := (Base.UltimoPrecoCompraImpostos * fltFatorCon * Formula.VolumePro / Formula.VolumeOri);
    componente[mvDiluido].UltimoPrecoCompraImpostos := (Base.UltimoPrecoCompraImpostos * fltFator * Formula.VolumePro / Formula.VolumeOri);

    componente[mvConcentrado].PrecoCompraLiquido := (Base.PrecoCompraLiquido * fltFatorCon * Formula.VolumePro / Formula.VolumeOri);
    componente[mvDiluido].PrecoCompraLiquido := (Base.PrecoCompraLiquido * fltFator * Formula.VolumePro / Formula.VolumeOri);

    componente[mvConcentrado].PrecoCusto := fltCusBasCon;
    componente[mvDiluido].PrecoCusto := fltCusBasDil;

    componente[mvConcentrado].PrecoCustoReal := fltCu2BasCon;
    componente[mvDiluido].PrecoCustoReal := fltCu2BasDil;

    componente[mvConcentrado].PrecoVenda := fltVenBasCon;
    componente[mvDiluido].PrecoVenda := fltVenBasDil;

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

constructor TCalculadorFormulaAutomotivaSkyMixAutomotiva.Create(
  const formula: TAbstractFormulaAutomotiva);
begin
  inherited Create(formula);
end;

end.
