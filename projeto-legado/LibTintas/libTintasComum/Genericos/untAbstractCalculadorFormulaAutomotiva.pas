{*********************************************************************************************}
{* Classe abstrata que implementa a interface ICalculadorFormulaAutomotiva responsável pelo  *}
{* calculo de preço dos componentes de uma tinta                                             *}
{******************************************************************************************AC*}
unit untAbstractCalculadorFormulaAutomotiva;

interface

uses
  untICalculadorFormulaAutomotiva, untBaseAutomotiva, untAbstractFormulaAutomotiva, SysUtils, Classes,
  untGenericTintaDeMaquina, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untAbstractFormula, untModoVenda, Variants;

type
  TAbstractCalculadorFormulaAutomotiva = class abstract(TInterfacedObject, ICalculadorFormulaAutomotiva)
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

{ TAbstractCalculadorFormulaAutomotiva }

procedure TAbstractCalculadorFormulaAutomotiva.Calcular;
var
  base: TBaseAutomotiva;
  intIndex: Integer;
  dicDados: IDicionario;
  componente: array[TModoVenda] of ITintaDeMaquinaComponente;
  fltPreVenPro,
  fltPreCusPro: Double;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  Zerar;
  tintaDeMaquina[mvConcentrado].limpar;
  tintaDeMaquina[mvDiluido].limpar;

  formula.pDefineVolumeOriginal;

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


  {$IFNDEF LINUX}
    If ( formula.mveModoVenda = mvConcentrado) And (Base.TipoBase = 'D') Then
    Begin
      Continue;
    End;
  {$ELSE}
    If (Formula.ModVen = 'C') And (Base.TipoBase = 'D') Then
      Continue;
  {$ENDIF}

    If formula.fPossuiConexaoSQLServer Then
    Begin
      Base.LinhaBase := formula.BasesDataSet.FieldByName('BAS_LINHA_').AsString;
      If Not (formula.BasesDataSet.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Base.CodigoBase, Base.LinhaBase]), [])) Then
      Begin
        Zerar;
        Raise Exception.Create('Base/Linha ' + Base.CodigoBase + '/' + Base.LinhaBase + ' não cadastrada. Favor verificar.');
      End;
    End
    ELse
    If (Not formula.BasesDataSet.Locate('BAS_CODBAS', base.CodigoBase, [])) Then
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

    If formula.fPossuiConexaoSQLServer Then
    Begin
      If TAutcomTintaFactory.Get.fCarregaPromocao(formula.BasesDataSet.FieldByName('BAS_CODITE').AsString, formula.TabPre, formula.CodCli, formula.CodCnd,
        formula.PrzMed , fltPreVenPro, fltPreCusPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria) Then
      Begin
        Base.PrecoVenda := fltPreVenPro;
        Base.PrecoCusto := fltPreCusPro;
        strPromoc := 'S';

        If Base.PrecoCusto = 0 Then
          Base.PrecoCusto := formula.BasesDataSet.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        Base.PrecoCusto := formula.BasesDataSet.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := formula.BasesDataSet.FieldByName('ITE_PREVEN').AsFloat;
      End;
    End;

    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := base.PrecoVenda;
    dicDados['precus'] := base.PrecoCusto;
    dicDados['outval'] := base.OutrosValores;
    dicDados['icmsai'] := base.IcmsSaida;
    dicDados['impfed'] := base.ImpostosFederais;
    dicDados['desope'] := base.DespesasOperacionais;

    base.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);

    componente[mvConcentrado].Quantidade                := formula.GetCalcQuantidade(base, formula, 'C');                //formula.GetCalcQuantidade(base.QuantidadeConcentrado, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].PrecoCusto                := formula.GetCalcPrecoCusto(base, formula, 'C');                //formula.GetCalcPrecoCusto(base.QuantidadeConcentrado, base.PrecoCusto, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].PrecoCustoReal            := formula.GetCalcPrecoCustoReal(base, formula, 'C');            //formula.GetCalcPrecoCustoReal(base.QuantidadeConcentrado, base.PrecoCustoReal, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].PrecoVenda                := formula.GetCalcPrecoVenda(base, formula, 'C');                //formula.GetCalcPrecoVenda(base.QuantidadeConcentrado, base.PrecoVenda, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].PrecoMedio                := formula.GetCalcPrecoMedio(base, formula, 'C');                //formula.GetCalcPrecoMedio(base.QuantidadeConcentrado, base.PrecoMedio, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].OutrosValores             := formula.GetCalcOutrosValores(base, formula, 'C');             //formula.GetCalcOutrosValores(base.QuantidadeConcentrado, base.OutrosValores, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].IcmsSaida                 := formula.GetCalcIcmsSaida(base, formula, 'C');                 //formula.GetCalcIcmsSaida(base.QuantidadeConcentrado, base.IcmsSaida, base.PrecoVenda, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].ImpostosFederais          := formula.GetCalcImpostosFederais(base, formula, 'C');          //formula.GetCalcImpostosFederais(base.QuantidadeConcentrado, base.ImpostosFederais, base.PrecoVenda, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].DespesasOperacionais      := formula.GetCalcDespesasOperacionais(base, formula, 'C');      //formula.GetCalcDespesasOperacionais(base.QuantidadeConcentrado, base.DespesasOperacionais, base.PrecoVenda, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].UltimoPrecoCompra         := formula.GetCalcUltimoPrecoCompra(base, formula, 'C');         //formula.GetCalcUltimoPrecoCompra(base.QuantidadeConcentrado, base.UltimoPrecoCompra, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].UltimoPrecoCompraImpostos := formula.GetCalcUltimoPrecoCompraImpostos(base, formula, 'C'); //formula.GetCalcUltimoPrecoCompraImpostos(base.QuantidadeConcentrado, base.UltimoPrecoCompraImpostos, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvConcentrado].PrecoCompraLiquido        := formula.GetCalcPrecoCompraLiquido(base, formula, 'C');        //formula.GetCalcPrecoCompraLiquido(base.QuantidadeConcentrado, base.PrecoCompraLiquido, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);

    componente[mvDiluido].Quantidade                    := formula.GetCalcQuantidade(base, formula, 'D');                //formula.GetCalcQuantidade(base.QuantidadeDiluido, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].PrecoCusto                    := formula.GetCalcPrecoCusto(base, formula, 'D');                //formula.GetCalcPrecoCusto(base.QuantidadeDiluido, base.PrecoCusto, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].PrecoCustoReal                := formula.GetCalcPrecoCustoReal(base, formula, 'D');            //formula.GetCalcPrecoCustoReal(base.QuantidadeDiluido, base.PrecoCustoReal, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].PrecoVenda                    := formula.GetCalcPrecoVenda(base, formula, 'D');                //formula.GetCalcPrecoVenda(base.QuantidadeDiluido, base.PrecoVenda, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].PrecoMedio                    := formula.GetCalcPrecoMedio(base, formula, 'D');                //formula.GetCalcPrecoMedio(base.QuantidadeDiluido, base.PrecoMedio, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].OutrosValores                 := formula.GetCalcOutrosValores(base, formula, 'D');             //formula.GetCalcOutrosValores(base.QuantidadeDiluido, base.OutrosValores, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].IcmsSaida                     := formula.GetCalcIcmsSaida(base, formula, 'D');                 //formula.GetCalcIcmsSaida(base.QuantidadeDiluido, base.IcmsSaida, base.PrecoVenda, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].ImpostosFederais              := formula.GetCalcImpostosFederais(base, formula, 'D');          //formula.GetCalcImpostosFederais(base.QuantidadeDiluido, base.ImpostosFederais, base.PrecoVenda, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].DespesasOperacionais          := formula.GetCalcDespesasOperacionais(base, formula, 'D');      //formula.GetCalcDespesasOperacionais(base.QuantidadeDiluido, base.DespesasOperacionais, base.PrecoVenda, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].UltimoPrecoCompra             := formula.GetCalcUltimoPrecoCompra(base, formula, 'D');         //formula.GetCalcUltimoPrecoCompra(base.QuantidadeDiluido, base.UltimoPrecoCompra, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].UltimoPrecoCompraImpostos     := formula.GetCalcUltimoPrecoCompraImpostos(base, formula, 'D'); //formula.GetCalcUltimoPrecoCompraImpostos(base.QuantidadeDiluido, base.UltimoPrecoCompraImpostos, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);
    componente[mvDiluido].PrecoCompraLiquido            := formula.GetCalcPrecoCompraLiquido(base, formula, 'D');        //formula.GetCalcPrecoCompraLiquido(base.QuantidadeDiluido, base.PrecoCompraLiquido, base.Cnv_Ml, formula.VolumePro, formula.VolumeOri);

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

constructor TAbstractCalculadorFormulaAutomotiva.Create(const formula: TAbstractFormulaAutomotiva);
begin
  inherited Create();
  Self.formula := formula;
  Self.tintaDeMaquina[mvConcentrado] := formula.tintaDeMaquina[mvConcentrado];
  Self.tintaDeMaquina[mvDiluido]     := formula.tintaDeMaquina[mvDiluido];
  Self.fltPerAcr                     := TAutcomTintaFactory.Get().fGetConfTinta(formula.GetIdePro).fGetDouble('APREVE') / 100.0;
end;

function TAbstractCalculadorFormulaAutomotiva.GetDespesasOperacionaisCon: Double;
begin
  Result := fltDespesasOperacionaisCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetDespesasOperacionaisDil: Double;
begin
  Result := fltDespesasOperacionaisDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetIcmsSaidaCon: Double;
begin
  Result := fltIcmsSaidaCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetIcmsSaidaDil: Double;
begin
  Result := fltIcmsSaidaDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetImpostosFederaisCon: Double;
begin
  Result := fltImpostosFederaisCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetImpostosFederaisDil: Double;
begin
  Result := fltImpostosFederaisDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetOutrosValoresCon: Double;
begin
  Result := fltOutrosValoresCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetOutrosValoresDil: Double;
begin
  Result := fltOutrosValoresDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoCompraLiquidoCon: Double;
begin
  Result := fltPrecoCompraLiquidoCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoCompraLiquidoDil: Double;
begin
  Result := fltPrecoCompraLiquidoDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoCustoCon: Double;
begin
  Result := fltPrecoCustoCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoCustoDil: Double;
begin
  Result := fltPrecoCustoDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoCustoRealCon: Double;
begin
  Result := fltPrecoCustoRealCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoCustoRealDil: Double;
begin
  Result := fltPrecoCustoRealDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoMedioCon: Double;
begin
  Result := fltPrecoMedioCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoMedioDil: Double;
begin
  Result := fltPrecoMedioDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoVendaCon: Double;
begin
  Result := fltPrecoVendaCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPrecoVendaDil: Double;
begin
  Result := fltPrecoVendaDil;
end;

function TAbstractCalculadorFormulaAutomotiva.GetPromocao: String;
begin
  Result := strPromoc;
end;

function TAbstractCalculadorFormulaAutomotiva.GetUltimoPrecoCompraCon: Double;
begin
  Result := fltUltimoPrecoCompraCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetUltimoPrecoCompraDil: Double;
begin
  Result := fltUltimoPrecoCompraDil
end;

function TAbstractCalculadorFormulaAutomotiva.GetUltimoPrecoCompraImpostosCon: Double;
begin
  Result := fltUltimoPrecoCompraImpostosCon;
end;

function TAbstractCalculadorFormulaAutomotiva.GetUltimoPrecoCompraImpostosDil: Double;
begin
  Result := fltUltimoPrecoCompraImpostosDil;
end;

procedure TAbstractCalculadorFormulaAutomotiva.Zerar;
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
