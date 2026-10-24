unit untMazaAutomotiva;

interface

uses
  untFuncEspecificas, Forms, Uni, untFuncoesSimples, Classes,
  SysUtils, Controls, Dialogs, untPnlBotoesAcoesNovaConsulta,
  Math;

type
  TfrmConsultaCompMazaAutomotiva = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  end;

  TMazaAutomotiva = class(TFormulaAutomotiva)
  protected
    FPesCor: Double;
    FPesFor: Double;
    fltPerAcr: Double;
    fltAcrMob: Double;
    function fCalculaQuantidadeParaBaixaEstoque(objBase: TBaseAutomotiva): Double; override;
  public
    procedure pCarregarColorantes; override;
    procedure pCalcularPrecos; override;
    procedure pCarregaPrecosBases; override;
    Constructor Create(strTabPre: String); override;

    property fltPesCor: Double Read FPesCor Write FPesCor; // Peso Específico da Fórmula
    property fltPesFor: Double Read FPesFor Write FPEsFor; // Peso Total da Fórmula (g)
  End;

  function fConsultaMazaAutomotivaDinamica(Sender: TForm): String; stdcall;
  function fConsultaMazaAutomotivaDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaMazaAutomotivaDinamicaVenda(Sender: TForm; qryTinta: TUniQuery;
    strTabPre: String): String; stdcall;

  function fConsultaMazaAutomotivaDinamicaInterna(Sender: TForm; qryTinta: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String): String;

  function fGTinForMazaAutomotivaDinamica(strIteTin: String; strTipPre: String;
            Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
            Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean; stdcall;

  function fDigDadosTintometricos(qryCadMza: TUniQuery; stlDesEmb, stlProEmbLt,
    stlProEmbGl: TStringList; strProEmbCo,
    strProEmbSp: String; Var strIteEmb,
    strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala,
    fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;

  function fRetornaPrecoMazaAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  function fRetornaDescricaoMazaAutomotivaDinamica(qryCadMza: TUniQuery; strDesCor: String): String;

  procedure pRetornaDadosMazaAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoMazaAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
  function fRetDescriMontadora(strCodMon: String): String;
  function fRetornaUniTraProMazaAutomotivaDinamica(fltPrcTin, fltPrvTin: Double): Double;
  procedure pObterDadosFormulacao(const objFormula: TMazaAutomotiva; const strIteTin: string);
  function fRetornaAcrescimoMaoObra(strIteTin: String): Double;


implementation

uses DB, untDigTintaAutomotiva, untFuncoes, untDigTintaAutomotivaMazaAutomotiva, untICalculadorFatVendas,
untIConfTinta,
untIConsultaTinta,
untTintaMaquina,
untMazaAutomotivaConsulta,
    untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
    untITintaDeMaquinaComponente, untTintaDeMaquinaComponenteComparerBaseAutomotiva;

Constructor TMazaAutomotiva.Create(strTabPre: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('MZA');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  fltAcrMob := 0;
end;

function TMazaAutomotiva.fCalculaQuantidadeParaBaixaEstoque(
  objBase: TBaseAutomotiva): Double;
begin
  Result := IIF(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) *
            (fltPesCor / fltPesFor) *
            Self.fltVolumePro;
end;

procedure TMazaAutomotiva.pCalcularPrecos;
var
  intCont: Integer;
  objBase: TBaseAutomotiva;

  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala: Double;

  fltPreCusCon: double;
  fltPreCu2Con: double;
  fltPreVenCon: Double;

  fltPreVenDil: Double;
  fltPreCusDil: Double;
  fltPreCu2Dil: Double;

  fltQtdAux   : Double;
  fltQtdAuxDil: Double;
  fltPreCusPro,
  fltPreVenPro: Double;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;

  procedure ZerarPrecos;
  Begin
    fltPreCusBas := 0.0;
    fltPreCu2Bas := 0.0;
    fltPreVenBas := 0.0;
    fltEmbala    := 0.0;
    fltPreCusCon := 0.0;
    fltPreCu2Con := 0.0;
    fltPreVenCon := 0.0;
    fltPreCusCon := 0.0;
    fltPreCu2Con := 0.0;
    fltPreVenCon := 0.0;
    FPrecoCusCon := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoCusDil := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoVenDil := 0.0;
    fltPreVenDil := 0.0;
    fltPreCusDil := 0.0;
    fltPreCu2Dil := 0.0;

    FOutValCon := 0;
    FIcmsaiCon := 0;
    FImpFedCon := 0;
    FDesOpeCon := 0;
    FPreMedCon := 0;

    FOutValDil := 0;
    FIcmsaiDil := 0;
    FImpFedDil := 0;
    FDesOpeDil := 0;
    FPreMedDil := 0;

    FComLiqCon := 0;
    FPreUltCon := 0;
    FImpUltCon := 0;

    FComLiqDil := 0;
    FPreUltDil := 0;
    FImpUltDil := 0;
  End;
begin
  fltVolumeOri := 0.9;
  ZerarPrecos;

  For intCont := 0 To Count - 1 Do
  Begin
    objBase := TBaseAutomotiva(Items[intCont]);

    If Not qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []) Then
    Begin
      ZerarPrecos;
      Raise Exception.Create(Format('A base %s não está cadastrada. Favor verificar', [objBase.strCodBas]));
    End;

    If fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString) Then
    Begin
      ZerarPrecos;
      Raise Exception.Create(Format('A base %s não está com um item associado. Favor verificar', [objBase.strCodBas]));
    End;

    If qryCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0 Then
    Begin
      ZerarPrecos;
      Raise Exception.Create(Format('O produto %s não está com o fator tintometrico preenchido corretamente. Favor verificar', [qryCadBas.FieldByName('BAS_CODITE').AsString]));
    End;

    If objBase.fltPesEsp <= 0 Then
    Begin
      ZerarPrecos;
      Raise Exception.Create(Format('A base %s não está com o peso específico preenchido corretamente. Favor verificar', [objBase.strCodBas]));
    End;

    if not IsItemAtivo(qryCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      ZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

    componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvConcentrado]) then
    begin
      componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    componente[mvDiluido] := tintaDeMaquina[mvDiluido].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvDiluido]) then
    begin
      componente[mvDiluido] := tintaDeMaquina[mvDiluido].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    fltEmbala := qryCadBas.FieldByName('BAS_EMBALA').AsFloat;

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreCusBas := fltPreCusPro;
      fltPreVenBas := fltPreVenPro;
      FPromoc := 'S';

      If fltPreCusBas = 0 Then
        fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenBas := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenBas,
                                        fltPreCusBas,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltQtdAux    := FVolumePro * (((fltPesCor / fltPesFor) * 1000) * objBase.fltQtdCon);
    fltQtdAuxDil := FVolumePro * (((fltPesCor / fltPesFor) * 1000) * objBase.fltQtdDil);

    fltPreCusCon := (fltPreCusBas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    fltPreCu2Con := (fltPreCu2Bas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    fltPreVenCon := (fltPreVenBas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);

    fltPreCusDil := (fltPreCusBas / objBase.fltEmbala) * (fltQtdAuxDil / objBase.fltPesEsp);
    fltPreCu2Dil := (fltPreCu2Bas / objBase.fltEmbala) * (fltQtdAuxDil / objBase.fltPesEsp);
    fltPreVenDil := (fltPreVenBas / objBase.fltEmbala) * (fltQtdAuxDil / objBase.fltPesEsp);


    componente[mvConcentrado].Quantidade                := fltQtdAux;
    componente[mvDiluido].Quantidade                    := fltQtdAuxDil;

    componente[mvConcentrado].OutrosValores             := (objBase.fltOutVal / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].PrecoMedio                := (objBase.fltPreMed / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].UltimoPrecoCompra         := (objBase.fltPreUlt / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].UltimoPrecoCompraImpostos := (objBase.fltImpUlt / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].PrecoCompraLiquido        := (objBase.fltComLiq / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    componente[mvConcentrado].IcmsSaida                 := objBase.fltIcmSai * fltPreVenCon / 100;
    componente[mvConcentrado].ImpostosFederais          := objBase.fltImpFed * fltPreVenCon / 100;
    componente[mvConcentrado].DespesasOperacionais      := objBase.fltDesOpe * fltPreVenCon / 100;
    componente[mvConcentrado].PrecoCusto                := fltPreCusCon;
    componente[mvConcentrado].PrecoCustoReal            := fltPreCu2Con;
    componente[mvConcentrado].PrecoVenda                := fltPreVenCon;

    componente[mvDiluido].OutrosValores                 := (objBase.fltOutVal / objBase.fltEmbala) * (fltQtdAuxDil / objBase.fltPesEsp);
    componente[mvDiluido].PrecoMedio                    := (objBase.fltPreMed / objBase.fltEmbala) * (fltQtdAuxDil / objBase.fltPesEsp);
    componente[mvDiluido].UltimoPrecoCompra             := (objBase.fltPreUlt / objBase.fltEmbala) * (fltQtdAuxDil / objBase.fltPesEsp);
    componente[mvDiluido].UltimoPrecoCompraImpostos     := (objBase.fltImpUlt / objBase.fltEmbala) * (fltQtdAuxDil / objBase.fltPesEsp);
    componente[mvDiluido].PrecoCompraLiquido            := (objBase.fltComLiq / objBase.fltEmbala) * (fltQtdAuxDil / objBase.fltPesEsp);
    componente[mvDiluido].IcmsSaida                     := objBase.fltIcmSai * fltPreVenDil / 100;
    componente[mvDiluido].ImpostosFederais              := objBase.fltImpFed * fltPreVenDil / 100;
    componente[mvDiluido].DespesasOperacionais          := objBase.fltDesOpe * fltPreVenDil / 100;
    componente[mvDiluido].PrecoCusto                    := fltPreCusDil;
    componente[mvDiluido].PrecoCustoReal                := fltPreCu2Dil;
    componente[mvDiluido].PrecoVenda                    := fltPreVenDil;

{
    fltQtdAux    := FVolumePro * (((fltPesCor / fltPesFor) * 1000) * objBase.fltQtdCon);
    fltPreCusBas := (fltPreCusBas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    fltPreCu2Bas := (fltPreCu2Bas / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    fltPreVenBas := (objBase.fltPreVen / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);

    FOutValCon := FOutValCon + (objBase.fltOutVal / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    FIcmsaiCon := FIcmsaiCon + objBase.fltIcmSai * fltPreVenBas / 100;
    FImpFedCon := FImpFedCon + objBase.fltImpFed * fltPreVenBas / 100;
    FDesOpeCon := FDesOpeCon + objBase.fltDesOpe * fltPreVenBas / 100;
    FPreMedCon := FPreMedCon + (objBase.fltPreMed / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);

    FComLiqCon := FComLiqCon + (objBase.fltComLiq / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    FPreUltCon := FPreUltCon + (objBase.fltPreUlt / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);
    FImpUltCon := FImpUltCon + (objBase.fltImpUlt / objBase.fltEmbala) * (fltQtdAux / objBase.fltPesEsp);

    FPrecoCusCon := FPrecoCusCon + fltPreCusBas;
    FPrecoCu2Con := FPrecoCu2Con + fltPreCu2Bas;
    FPrecoVenCon := FPrecoVenCon + fltPreVenBas;
}
  End;

  FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;

  FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;

  FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
  FPreUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes;

  FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
  FImpUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes;

  FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
  FComLiqDil := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes;

  FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;

  FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;

  FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;

  FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;

  FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;

  FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;
  FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;

  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);
  FPrecoVenDil := FPrecoVenDil + (fltPerAcr * FPrecoVenDil);

//  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);

  If FPrecoVenCon > 0 Then
    FPrecoVenCon := FPrecoVenCon + fltAcrMob;

  If FPrecoVenDil > 0 Then
    FPrecoVenDil := FPrecoVenDil + fltAcrMob;

  pCarregaPrecosBases;
end;

procedure TMazaAutomotiva.pCarregaPrecosBases;
  Var
    intContador: Integer;
    objBase: TBaseAutomotiva;

    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro,
    fltPreVenItem : Double;

begin
  conf := fGetConfTinta('MZA');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  For intContador := 0 To Self.Count - 1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreVenItem := fltPreVenPro;
    End
    Else
    Begin
      fltPreVenItem := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objBase.fltEmbala := qryCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := qryCadBas.FieldByName('BAS_PESESP').AsFloat;
    objBase.fltPreVen := fltPreVenItem;
    objBase.strImpDir := qryCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := qryCadBas.FieldByName('BAS_CODITE').AsString;                

    objBase.fltOutVal := qryCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := qryCadBas.FieldByName('ITE_ICMSAI').AsFloat;
      
    objBase.fltImpFed := qryCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := qryCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPreMed := qryCadBas.FieldByName('ITE_PREMED').AsFloat;

    objBase.fltImpUlt := qryCadBas.FieldByName('ITE_IMPULT').AsFloat;
    objBase.fltPreUlt := qryCadBas.FieldByName('ITE_PREULT').AsFloat;
    objBase.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(qryCadBas.Fieldbyname('ITE_PRECOM').AsFloat, qryCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF02').AsFloat, qryCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF04').AsFloat, qryCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                qryCadBas.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
  End;

  FCalculo.Clear;
  FCalculo.Add('PesoEspecíficoFormula = ' + FloatToStrF(fltPesCor, ffFixed, 12, 3));
  FCalculo.Add('PesoTotalFormula(g) = ' + FloatToStrF(fltPesFor, ffFixed, 12, 3));
  FCalculo.Add('QtdAux = VolumeDigitado * (((PesoEspecíficoFormula / PesoTotalFórmula) * 1000) * Quantidade)');
  FCalculo.Add('Valor da Base = (Preço / Embalagem) * (QtdAux / Peso Específico)');
end;

procedure TMazaAutomotiva.pCarregarColorantes;
begin
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESESP                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');

  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');
  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_ICMSAI                       ');
    qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
    qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_PREMED                  ');
  end;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
    qryCadBas.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
  end
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryCadBas.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryCadBas.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryCadBas.SQL.Add(' FROM                                 ');
  qryCadBas.SQL.Add('   MZA_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;
end;

{ TfrmConsultaCompMazaAutomotiva }

procedure TfrmConsultaCompMazaAutomotiva.pTarefaFormulacao(Sender: TObject);
var
  qryTinta: TUniQuery;
  dicRetorno: TDicionario;

  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;

  strProEmbCo: String;
  strProEmbSp: String;
  strIteEmb: String;
  strTipEmb: String;
  strTipPre: String;

  intQtdEmb: Integer;

  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltPreVen: Double;
  fltVolPro: Double;
  conf: IConfTinta;
begin
  dicRetorno := nil;
  stlDesEmb := nil; 
  stlProEmbGl := nil;
  stlProEmbLT := nil;
  qryTinta := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf     := fGetConfTinta('MZA');
      
      dicRetorno  := TDicionario.Create;
      stlDesEmb   := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLT := TStringList.Create;

      qryTinta := fCriaQuery(Self);
      qryTinta.Close;
      qryTinta.SQL.Clear;
      qryTinta.SQL.Add('SELECT * FROM MZA_CADMZA WHERE AUTOINCREM = :AUTINC');
      qryTinta.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryTinta.Open;

      stlDesEmb.Add(qryTinta.FieldByName('MZA_LINHA_').AsString);
      stlProEmbGl.Add(conf.fGet('MZAGAL'));
      stlProEmbLT.Add(conf.fGet('MZALIT'));
      strProEmbCo := conf.fGet('MZACOP');
      strProEmbSp := conf.fGet('MZASPR');

      dicRetorno['idepro'] := 'MZA';

      fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLT, stlProEmbGl, strProEmbCo, strProEmbSp,
                            strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                            fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLT) then FreeAndNil(stlProEmbLT);
    if Assigned(qryTinta) then FreeAndNil(qryTinta);
  End;
end;

procedure TfrmConsultaCompMazaAutomotiva.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompMazaAutomotiva.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadMzaNfm', False);
end;

function fConsultaMazaAutomotivaDinamica(Sender: TForm): String; stdcall;
  Var
    qryMza: TUniQuery;
Begin
  Try
    qryMza := fCriaQuery();
    Result := fConsultaMazaAutomotivaDinamicaInterna(Sender,qryMza, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
  Finally
    FreeAndNil(qryMza);
  End;
End;

function fConsultaMazaAutomotivaDinamicaGeral(Sender: TForm): String; stdcall;
Begin
  Result := fConsultaMazaAutomotivaDinamica(Sender);
End;

function fConsultaMazaAutomotivaDinamicaVenda(Sender: TForm; qryTinta: TUniQuery;
  strTabPre: String): String; stdcall;
Begin
  Result := fConsultaMazaAutomotivaDinamicaInterna(Sender, qryTinta, tpcVenda, strTabPre);
End;

function fConsultaMazaAutomotivaDinamicaInterna(Sender: TForm; qryTinta: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String): String;
begin
  Result := (TMazaAutomotivaConsulta.Create).fExecutarConsulta(Sender,
    qryTinta, tipoConsulta, strTabPre, TfrmConsultaCompMazaAutomotiva);

end;

function fGTinForMazaAutomotivaDinamica(strIteTin: String; strTipPre: String;
          Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
          Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean; stdcall;
  Var
    qryMza: TUniQuery;
    dicRetorno: TDicionario;
    strBases: String;
    strSql: String;
    intCont: Integer;
    fltPesFor: Double;
    fltPesCor: Double;        
Begin

  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM MZA_CADMZA ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '    UPPER(CAST(MD5(CONCAT( ';
  strSQL := strSQL + '       IFNULL(MZA_CODIGO, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_VARIAC, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_DESCRI, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_ANOCOR, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_DTAFOR, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_LINHA_, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_CODMON, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_CODNFM, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_UNIVER, "")))AS CHAR)) = :ITETIN ';

  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := strSql;
    qryMza.ParamByName('ITETIN').AsString := strIteTin;
    qryMza.Open;

    If qryMza.IsEmpty Then
    Begin
      Result := False;
      FreeAndNil(qryMza);
      Exit;
    End;

    fltPesCor := qryMza.FieldByName('MZA_PESCOR').AsFloat; //* 1000;
    fltPesFor := qryMza.FieldByName('MZA_PESFOR').AsFloat;    

    dicRetorno := TDicionario.Create;

    For intCont := 1 To 15 Do
    Begin
      If fEmptyStr(qryMza.FieldByName('MZA_FORM' + fStrZero(intCont, 2)).AsString) Then
        Break;

      If (strTipPre = 'C') And (qryMza.FieldByName('MZA_QTDC' + fStrZero(intCont, 2)).AsFloat = 0) Then
        Break;

      arrFormul[intCont].strFormul := qryMza.FieldByName('MZA_FORM' + fStrZero(intCont, 2)).AsString;

      arrFormul[intCont].fltQtdbas := fltVolPro * (((fltPesCor / fltPesFor) * 1000) * qryMza.FieldByName('MZA_QTDC' + fStrZero(intCont, 2)).AsFloat);
      
      dicRetorno[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

      strBases := strBases + ',' + QuotedStr(arrFormul[intCont].strFormul);
    End;

    strBases := Trim(strBases);
    strBases := Copy(strBases, 2, Length(strBases));

    strSql := '';
    strSql := strSql + ' SELECT ';
    strSql := strSql + '   BAS_CODBAS, ';
    strSql := strSql + '   BAS_CODITE ';
    strSql := strSql + ' FROM MZA_CADBAS ';
    strSql := strSql + ' WHERE BAS_CODBAS IN(' + strBases + ') ';

    qryMza.Close;
    qryMza.SQL.Text := strSql;
    qryMza.Open;

    SetLength(arrBaixaPigmentos, qryMza.RecordCount);

    While Not qryMza.Eof Do
    Begin
      stlItensTraMl.Add(qryMza.FieldByName('BAS_CODITE').AsString);
      arrBaixaPigmentos[qryMza.RecNo - 1].strCodIte := qryMza.FieldByName('BAS_CODITE').AsString;
      arrBaixaPigmentos[qryMza.RecNo - 1].fltQtdBaixa := dicRetorno[qryMza.FieldByName('BAS_CODBAS').AsString];
      qryMza.Next;
    End;
  Finally
    If Assigned(dicRetorno) Then
      FreeAndNil(dicRetorno);
    If Assigned(qryMza) Then
      FreeAndNil(qryMza);
  End;
End;

function fDigDadosTintometricos(qryCadMza: TUniQuery; stlDesEmb, stlProEmbLt,
  stlProEmbGl: TStringList; strProEmbCo,
  strProEmbSp: String; Var strIteEmb,
  strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala,
  fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TMazaAutomotiva;
  intCont: Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
Begin
  Result := False;
  frmDigTintaAutomotivaMazaAutomotiva := nil;
  objFormula := nil;
  conf := fGetConfTinta('MZA');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TMazaAutomotiva.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strDescri := fRetornaDescricaoMazaAutomotivaDinamica(qryCadMza, '');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      objFormula.fltPesCor    := qryCadMza.FieldByName('MZA_PESCOR').AsFloat; //* 1000;
      objFormula.fltPesFor    := qryCadMza.FieldByName('MZA_PESFOR').AsFloat;

      objFormula.fltAcrMob := qryCadMza.FieldByName('MZA_ACRMOB').AsFloat;

      For intCont := 1 To 15 Do
      Begin
        If fEmptyStr(qryCadMza.FieldbyName('MZA_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadMza.FieldbyName('MZA_FORM' + fStrZero(intCont, 2)).AsString;
        objBase.fltQtdCon := qryCadMza.FieldbyName('MZA_QTDC' + fStrZero(intCont, 2)).AsFloat;

        objFormula.qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);
        objBase.fltEmbala := objFormula.qryCadBas.FieldByName('BAS_EMBALA').AsFloat;
        objBase.fltPesEsp := objFormula.qryCadBas.FieldByName('BAS_PESESP').AsFloat;

        objBase.strTipBas := 'B';
      End;

      objFormula.pCarregaPrecosBases;

      Application.CreateForm(TfrmDigTintaAutomotivaMazaAutomotiva, frmDigTintaAutomotivaMazaAutomotiva);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotivaMazaAutomotiva.objFormula  := objFormula;
      frmDigTintaAutomotivaMazaAutomotiva.stlDesEmb   := stlDesEmb;
      frmDigTintaAutomotivaMazaAutomotiva.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotivaMazaAutomotiva.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotivaMazaAutomotiva.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotivaMazaAutomotiva.strProEmbSp := strProEmbSp;
      frmDigTintaAutomotivaMazaAutomotiva.Caption := frmDigTintaAutomotivaMazaAutomotiva.Caption;
      frmDigTintaAutomotivaMazaAutomotiva.edtQtdEmb.Text := '1';

      {*************************************}
      {* NAO POSSUI CATALISADOR ESSA TINTA *}
      {**********************************PH*}
      frmDigTintaAutomotivaMazaAutomotiva.chkComCat.Visible := False;

      frmDigTintaAutomotivaMazaAutomotiva.strIdePro   := dicRetorno['idepro'];

      Result := (frmDigTintaAutomotivaMazaAutomotiva.ShowModal = mrOk);

      If Result Then
      Begin
        strIteEmb := frmDigTintaAutomotivaMazaAutomotiva.objFormula.strCodEmb;

        Case frmDigTintaAutomotivaMazaAutomotiva.objFormula.tpeTipEmb of
          teLitro  : begin
                       strTipEmb := 'LT';
                       fltEmbala := 0.900;
                     end;
          teGalao  : begin
                       strTipEmb := 'GL';
                       fltEmbala := 3.600;
                     end;
          teCopo   : begin
                       strTipEmb := 'CP';
                       fltEmbala := 0.450;
                     end;
          teSpray  : begin
                       strTipEmb := 'SP';
                       fltEmbala := 0.190;
                     end;
        end;

        strTipPre := IIF(frmDigTintaAutomotivaMazaAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotivaMazaAutomotiva.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoEmbalagem;
        fltVolPro := frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltVolumePro;

        If (frmDigTintaAutomotivaMazaAutomotiva.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCusCon + frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCu2Con + frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoVenCon + frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCusDil + frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCu2Dil + frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoVenDil + frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoEmbalagem;
        End;
        dicRetorno['premed'] := IfThen(frmDigTintaAutomotivaMazaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPreMedCon,
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPreMedDil) +
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotivaMazaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltImpUltCon,
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltImpUltDil) +
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotivaMazaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPreUltCon,
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPreUltDil) +
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotivaMazaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltComLiqCon,
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltComLiqDil) +
          frmDigTintaAutomotivaMazaAutomotiva.objFormula.fltPrecoCompraLiquidoEmbalagem;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        dicRetorno['promoc']      := objFormula.StrPromoc;

        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['saldocols'] := frmDigTintaAutomotivaMazaAutomotiva.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotivaMazaAutomotiva.matrizSaldosColorantes);

        If (Result) And (Assigned(dicRetorno)) Then
        Begin
          objFormula.pRecalculaTabelas(strTipPre, dicRetorno);
        End;
      End;


    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmDigTintaAutomotivaMazaAutomotiva) then FreeAndNil(frmDigTintaAutomotivaMazaAutomotiva);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
End;

function fRetornaPrecoMazaAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  Var
    strIteTin: String;

    stlDesEmb: TStringList;
    stlProEmbGl: TStringList;
    stlProEmbLt: TStringList;

    strProEmbCo: String;
    strProEmbSp: String;
    strIteEmb: String;
    strTipEmb: String;
    strTipPre: String;
    intQtdEmb: Integer;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltPreVen: Double;
    fltVolPro: Double;
    strTabPre: String;

//    fltPrcTin: Double;
    fltPrvTin: Double;

    blnUsaPreCus : Boolean;

    strAuto: String;
    tinta : IConsultaTinta;
    strDesCor : String;
    conf : IConfTinta;
Begin
  Result := False;

  stlDesEmb   := TStringList.Create;
  stlProEmbGl := TStringList.Create;
  stlProEmbLT := TStringList.Create;

  blnUsaPreCus := dicRetorno['usaprecus'];

  strAuto := fConsultaMazaAutomotivaDinamicaVenda(Sender, qryTinta, strTabPre);

  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  conf  := fGetConfTinta('MZA');
  tinta := TMazaAutomotivaConsulta.Create;

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

  strIteTin := fGetMd5MySQl(qryTinta.FieldByName('MZA_CODIGO').AsString +
                            qryTinta.FieldByName('MZA_VARIAC').AsString +
                            qryTinta.FieldByName('MZA_DESCRI').AsString +
                            qryTinta.FieldByName('MZA_ANOCOR').AsString +
                            qryTinta.FieldByName('MZA_DTAFOR').AsString +
                            qryTinta.FieldByName('MZA_LINHA_').AsString +
                            qryTinta.FieldByName('MZA_CODMON').AsString +
                            qryTinta.FieldByName('MZA_CODNFM').AsString +
                            qryTinta.FieldByName('MZA_UNIVER').AsString );

  stlDesEmb.Add(qryTinta.FieldByName('MZA_LINHA_').AsString);
  stlProEmbGl.Add(conf.fGet('MZAGAL'));
  stlProEmbLT.Add(conf.fGet('MZALIT'));
  strProEmbCo := conf.fGet('MZACOP');
  strProEmbSp := conf.fGet('MZASPR');

  If Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLT, stlProEmbGl, strProEmbCo, strProEmbSp,
                        strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                        fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno) Then
    Exit;

  strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldByName('AUTOINCREM').AsString));

//  fltPrcTin := fltPreCus;
  If blnUsaPreCus Then
    fltPreVen := fltPreCus;

  fltPrvTin := fltPreVen;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltPreVen;
//  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('MZAPRO'); 
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['tippre'] := strTipPre;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['gruemb'] := fRetGrupoItem(strIteEmb); //strGruEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['volpro'] := fltVolPro;

  dicRetorno['montad'] := fRetDescriMontadora(qryTinta.FieldByName('MZA_CODMON').AsString);
  dicRetorno['a_n_o_'] := qryTinta.FieldByName('MZA_ANOCOR').AsString;
  dicRetorno['chafor'] := fRetornaDescricaoMazaAutomotivaDinamica(qryTinta, strDesCor);
  dicRetorno['descor'] := strDesCor;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmbGl);
  FreeAndNil(stlProEmbLt);

  Result := True;
End;

function fRetornaDescricaoMazaAutomotivaDinamica(qryCadMza: TUniQuery; strDesCor: String): String;
Begin
  Result := strDesCor;      
End;

procedure pRetornaDadosMazaAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryMza: TUniQuery;
    strSql: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM MZA_CADMZA ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '    UPPER(CAST(MD5(CONCAT( ';
  strSQL := strSQL + '       IFNULL(MZA_CODIGO, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_VARIAC, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_DESCRI, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_ANOCOR, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_DTAFOR, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_LINHA_, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_CODMON, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_CODNFM, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_UNIVER, "")))AS CHAR)) = :ITETIN ';

  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := strSql;
    qryMza.Open;

    dicRetorno['codtin'] := qryMza.FieldByName('MZA_CODIGO').AsString + ' ' +
                            qryMza.FieldByName('MZA_VARIAC').AsString + ' ' +
                            qryMza.FieldByName('MZA_DESCRI').AsString + ' ' +
                            qryMza.FieldByName('MZA_ANOCOR').AsString + ' ' +
                            qryMza.FieldByName('MZA_DTAFOR').AsString + ' ' +
                            qryMza.FieldByName('MZA_LINHA_').AsString + ' ' +
                            qryMza.FieldByName('MZA_CODMON').AsString + ' ' +
                            qryMza.FieldByName('MZA_CODNFM').AsString + ' ' +
                            qryMza.FieldByName('MZA_UNIVER').AsString;


    dicRetorno['montad'] := fRetDescriMontadora(qryMza.FieldByName('MZA_CODMON').AsString);
  Finally
    FreeAndNil(qryMza);
  End;
End;

procedure pRetornaTabelaPrecoMazaAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  objFormula: TMazaAutomotiva;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  strTabelas: String;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
  strTabelaUnica: String;
begin
  conf := fGetConfTinta('MZA');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TMazaAutomotiva.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.fltVolumeOri := 0.9;
      objFormula.fltVolumePro := 1; //dicRetorno['volpro'];
      objFormula.fltPesCor    := 1;
      objFormula.fltPesFor    := 1;

      objFormula.fltAcrMob    := fRetornaAcrescimoMaoObra(dicRetorno['itetin']);

      If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;

      objFormula.fltFatorAcerto := fltFatorAcerto;
//      pObterDadosFormulacao(objFormula, IfNull(dicRetorno['itetin'], ''));

      objFormula.strCodEmb := dicRetorno['iteemb'];
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 4) / 1000
        Else
          objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 4) / 1000;
        objBase.strTipBas := 'B';
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');
      if not fEmptyStr(strTabelaUnica) then
      begin
        objFormula.strTabPre := strTabelaUnica;
        objFormula.pCarregarColorantes;
        objFormula.pCarregaPrecosBases;
        objFormula.pCalcularPrecos;

        If IfNull(dicRetorno['precus'], 0) <= 0 Then
        Begin
          If dicRetorno['tippre'] = 'C' Then
            dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
          Else
            dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
        End;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
        End;

        objFormula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
        dicRetorno['promoc'] := objFormula.StrPromoc;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End
        Else
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End;
      end
      else
      begin
        strTabelas := fCfgSis('TABPRC');
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

        For intContador := 1 To Length(strTabelas) Do
        Begin
          if strTabelas[intContador] = 'S' then
          begin
            objFormula.strTabPre := IntToStr(intContador);
            objFormula.pCarregarColorantes;
            objFormula.pCarregaPrecosBases;
            objFormula.pCalcularPrecos;
            If IfNull(dicRetorno['precus'], 0) <= 0 Then
            Begin
              If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
                dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
              Else
                dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
            End;

            If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
            End
            Else
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
            End;

            If intContador = IfNull(dicRetorno['tabpre'], 0) Then
            Begin
              objFormula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
              dicRetorno['promoc'] := objFormula.StrPromoc;
            End;

            If IfNull(dicRetorno['tippre'], 'C') = 'C' Then
            Begin
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End
            Else
            Begin
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End;
          end;
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
End;

function fRetDescriMontadora(strCodMon: String): String;
  Var
    qryMza: TUniQuery;
begin
  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Add(' SELECT ');
    qryMza.SQL.Add('   MON_DESCRI ');
    qryMza.SQL.Add(' FROM MZA_CADMON ');
    qryMza.SQL.Add(' WHERE MON_CODMON = :CODMON ');
    qryMza.ParamByName('CODMON').AsString := strCodMon;
    qryMza.Open;
    
    Result := qryMza.FieldByName('MON_DESCRI').AsString;
  Finally
    FreeAndNil(qryMza);
  End;
end;

function fRetornaUniTraProMazaAutomotivaDinamica(fltPrcTin, fltPrvTin: Double): Double;
Var
  conf: IConfTinta;
begin
  conf := fGetConfTinta('MZA');

  If conf.fGet('MZATRV') = 'VEN' Then
    Result :=  fltPrvTin * fStrToFloat(conf.fGet('MZAFAT'))
  Else
    Result :=  fltPrcTin * fStrToFloat(conf.fGet('MZAFAT'));

  Result := fFormataFloat(Result, 2);
end;

procedure pObterDadosFormulacao(const objFormula: TMazaAutomotiva; const strIteTin: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                              ' +
        '   MZA_PESCOR                        ' +
        '   , MZA_PESFOR                      ' +
        ' FROM                                ' +
        '   MZA_CADMZA                        ' +
        ' WHERE UPPER(CAST(MD5(CONCAT(        ' +
        '           IFNULL(MZA_CODIGO, "")    ' +
        '           , IFNULL(MZA_VARIAC, "")  ' +
        '           , IFNULL(MZA_DESCRI, "")  ' +
        '           , IFNULL(MZA_ANOCOR, "")  ' +
        '           , IFNULL(MZA_DTAFOR, "")  ' +
        '           , IFNULL(MZA_LINHA_, "")  ' +
        '           , IFNULL(MZA_CODMON, "")  ' +
        '           , IFNULL(MZA_CODNFM, "")  ' +
        '           , IFNULL(MZA_UNIVER, "")  ' +
        '         )) AS CHAR)) = :ITETIN      ';

      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      objFormula.fltPesCor    := qryGen.FieldByName('MZA_PESCOR').AsFloat;
      objFormula.fltPesFor    := qryGen.FieldByName('MZA_PESFOR').AsFloat;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

function fRetornaAcrescimoMaoObra(strIteTin: String): Double;
var
  strSQL: String;
  qryMza: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT MZA_ACRMOB ';
  strSQL := strSQL + '   FROM MZA_CADMZA ';
  strSQL := strSQL + '  WHERE            ';
  strSQL := strSQL + '    UPPER(CAST(MD5(CONCAT(      ';
  strSQL := strSQL + '       IFNULL(MZA_CODIGO, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_VARIAC, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_DESCRI, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_ANOCOR, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_DTAFOR, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_LINHA_, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_CODMON, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_CODNFM, ""),  ';
  strSQL := strSQL + '       IFNULL(MZA_UNIVER, "")))AS CHAR)) = :ITETIN ';

  Try
    qryMza := fCriaQuery;

    With qryMza Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := strSql;
      ParamByName('ITETIN').AsString := strIteTin;
      Open;

      Result := FieldByName('MZA_ACRMOB').AsFloat;
    End;
  Finally
    FreeAndNil(qryMza);
  End;
end;

end.
